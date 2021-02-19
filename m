Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923D231F473
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Feb 2021 05:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbhBSEYH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 23:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbhBSEYF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 23:24:05 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FACC061756;
        Thu, 18 Feb 2021 20:23:25 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lCxK3-00FgYK-Al; Fri, 19 Feb 2021 04:23:19 +0000
Date:   Fri, 19 Feb 2021 04:23:19 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Denis Kirjanov <kda@linux-powerpc.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 7/8] unix_bind_bsd(): unlink if we fail after successful mknod
Message-ID: <YC89N3dJb69T7Xco@zeniv-ca.linux.org.uk>
References: <20210125154937.26479-1-kda@linux-powerpc.org>
 <20210127175742.GA1744861@infradead.org>
 <CAOJe8K0MC-TCURE2Gpci1SLnLXCbUkE7q6SS0fznzBA+Pf-B8Q@mail.gmail.com>
 <20210129082524.GA2282796@infradead.org>
 <CAOJe8K0iG91tm8YBRmE_rdMMMbc4iRsMGYNxJk0p9vEedNHEkg@mail.gmail.com>
 <20210129131855.GA2346744@infradead.org>
 <YClpVIfHYyzd6EWu@zeniv-ca.linux.org.uk>
 <CAOJe8K00srtuD+VAJOFcFepOqgNUm0mC8C=hLq2=qhUFSfhpuw@mail.gmail.com>
 <YCwIQmsxWxuw+dnt@zeniv-ca.linux.org.uk>
 <YC86WeSTkYZqRlJY@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YC86WeSTkYZqRlJY@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We can do that more or less safely, since the parent is
held locked all along.  Yes, somebody might observe the
object via dcache, only to have it disappear afterwards,
but there's really no good way to prevent that.  It won't
race with other bind(2) or attempts to move the sucker
elsewhere, or put something else in its place - locked
parent prevents that.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 net/unix/af_unix.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index d55035a9695f..bb4c6200953d 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1001,30 +1001,19 @@ static int unix_bind_bsd(struct sock *sk, struct unix_address *addr)
 	dentry = kern_path_create(AT_FDCWD, addr->name->sun_path, &parent, 0);
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
-
 	/*
 	 * All right, let's create it.
 	 */
 	err = security_path_mknod(&parent, dentry, mode, 0);
 	if (!err)
 		err = vfs_mknod(d_inode(parent.dentry), dentry, mode, 0);
-
-	if (err) {
-		if (err == -EEXIST)
-			err = -EADDRINUSE;
-		done_path_create(&parent, dentry);
-		return err;
-	}
+	if (err)
+		goto out;
 	err = mutex_lock_interruptible(&u->bindlock);
-	if (err) {
-		done_path_create(&parent, dentry);
-		return err;
-	}
-	if (u->addr) {
-		mutex_unlock(&u->bindlock);
-		done_path_create(&parent, dentry);
-		return -EINVAL;
-	}
+	if (err)
+		goto out_unlink;
+	if (u->addr)
+		goto out_unlock;
 
 	addr->hash = UNIX_HASH_SIZE;
 	hash = d_backing_inode(dentry)->i_ino & (UNIX_HASH_SIZE - 1);
@@ -1035,6 +1024,16 @@ static int unix_bind_bsd(struct sock *sk, struct unix_address *addr)
 	mutex_unlock(&u->bindlock);
 	done_path_create(&parent, dentry);
 	return 0;
+
+out_unlock:
+	mutex_unlock(&u->bindlock);
+	err = -EINVAL;
+out_unlink:
+	/* failed after successful mknod?  unlink what we'd created... */
+	vfs_unlink(d_inode(parent.dentry), dentry, NULL);
+out:
+	done_path_create(&parent, dentry);
+	return err == -EEXIST ? -EADDRINUSE : err;
 }
 
 static int unix_bind_abstract(struct sock *sk, unsigned hash,
-- 
2.11.0

