Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D80231B1DF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Feb 2021 19:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhBNSSo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Feb 2021 13:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhBNSSn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Feb 2021 13:18:43 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE91C061574;
        Sun, 14 Feb 2021 10:18:03 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lBLy0-00DwvL-Ab; Sun, 14 Feb 2021 18:17:56 +0000
Date:   Sun, 14 Feb 2021 18:17:56 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Denis Kirjanov <kda@linux-powerpc.org>,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: export kern_path_locked
Message-ID: <YClpVIfHYyzd6EWu@zeniv-ca.linux.org.uk>
References: <20210125154937.26479-1-kda@linux-powerpc.org>
 <20210127175742.GA1744861@infradead.org>
 <CAOJe8K0MC-TCURE2Gpci1SLnLXCbUkE7q6SS0fznzBA+Pf-B8Q@mail.gmail.com>
 <20210129082524.GA2282796@infradead.org>
 <CAOJe8K0iG91tm8YBRmE_rdMMMbc4iRsMGYNxJk0p9vEedNHEkg@mail.gmail.com>
 <20210129131855.GA2346744@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129131855.GA2346744@infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 29, 2021 at 01:18:55PM +0000, Christoph Hellwig wrote:
> On Fri, Jan 29, 2021 at 04:11:05PM +0300, Denis Kirjanov wrote:
> > Do you mean just:
> 
> We'll still need to lock the parent inode.

Not just "lock", we wouldd need to have the lock _held_ across the
entire sequence.  Without that there's no warranty that it will refer
to the same object we'd created.

In any case, unlink in any potentially public area is pretty much
never the right approach.  Once mknod has happened, that's it - too
late to bail out.

IIRC, most of the PITA in that area is due to unix_autobind()
iteractions.  Basically, we try to bind() an unbound socket and
another thread does sendmsg() on the same while we are in the
middle of ->mknod().  Who should wait for whom?

->mknod() really should be a point of no return - any games with
"so we unlink it" are unreliable in the best case, and that's
only if we do _not_ unlock the parent through the entire sequence.

Seeing that we have separate bindlock and iolock now...  How about
this (completely untested) delta?

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 41c3303c3357..c21038b15836 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1034,6 +1034,14 @@ static int unix_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 		goto out;
 	addr_len = err;
 
+	err = mutex_lock_interruptible(&u->bindlock);
+	if (err)
+		goto out;
+
+	err = -EINVAL;
+	if (u->addr)
+		goto out_up;
+
 	if (sun_path[0]) {
 		umode_t mode = S_IFSOCK |
 		       (SOCK_INODE(sock)->i_mode & ~current_umask());
@@ -1041,18 +1049,10 @@ static int unix_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 		if (err) {
 			if (err == -EEXIST)
 				err = -EADDRINUSE;
-			goto out;
+			goto out_up;
 		}
 	}
 
-	err = mutex_lock_interruptible(&u->bindlock);
-	if (err)
-		goto out_put;
-
-	err = -EINVAL;
-	if (u->addr)
-		goto out_up;
-
 	err = -ENOMEM;
 	addr = kmalloc(sizeof(*addr)+addr_len, GFP_KERNEL);
 	if (!addr)
@@ -1090,7 +1090,6 @@ static int unix_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 	spin_unlock(&unix_table_lock);
 out_up:
 	mutex_unlock(&u->bindlock);
-out_put:
 	if (err)
 		path_put(&path);
 out:
