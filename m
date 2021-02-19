Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26FB931F46A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Feb 2021 05:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbhBSEV4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 23:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhBSEVy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 23:21:54 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD86C061756;
        Thu, 18 Feb 2021 20:21:14 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lCxHy-00FgWC-H2; Fri, 19 Feb 2021 04:21:10 +0000
Date:   Fri, 19 Feb 2021 04:21:10 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Denis Kirjanov <kda@linux-powerpc.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/8] unix_bind(): separate BSD and abstract cases
Message-ID: <YC88tqCkBEKoLrjW@zeniv-ca.linux.org.uk>
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

We do get some duplication that way, but it's minor compared to
parts that are different.  What we get is an ability to change
locking in BSD case without making failure exits very hard to
follow.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 net/unix/af_unix.c | 52 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 451d81f405c0..11e18b0efbc6 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1023,7 +1023,6 @@ static int unix_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 	int err;
 	unsigned int hash;
 	struct unix_address *addr;
-	struct path path = { };
 
 	err = -EINVAL;
 	if (addr_len < offsetofend(struct sockaddr_un, sun_family) ||
@@ -1050,6 +1049,7 @@ static int unix_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 	refcount_set(&addr->refcnt, 1);
 
 	if (sun_path[0]) {
+		struct path path = { };
 		umode_t mode = S_IFSOCK |
 		       (SOCK_INODE(sock)->i_mode & ~current_umask());
 		err = unix_mknod(sun_path, mode, &path);
@@ -1058,40 +1058,52 @@ static int unix_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 				err = -EADDRINUSE;
 			goto out_addr;
 		}
-	}
 
-	err = mutex_lock_interruptible(&u->bindlock);
-	if (err)
-		goto out_put;
+		err = mutex_lock_interruptible(&u->bindlock);
+		if (err) {
+			path_put(&path);
+			goto out_addr;
+		}
 
-	err = -EINVAL;
-	if (u->addr)
-		goto out_up;
+		err = -EINVAL;
+		if (u->addr) {
+			mutex_unlock(&u->bindlock);
+			path_put(&path);
+			goto out_addr;
+		}
 
-	if (sun_path[0]) {
 		addr->hash = UNIX_HASH_SIZE;
 		hash = d_backing_inode(path.dentry)->i_ino & (UNIX_HASH_SIZE - 1);
 		spin_lock(&unix_table_lock);
 		u->path = path;
+		__unix_set_addr(sk, addr, hash);
+		mutex_unlock(&u->bindlock);
+		addr = NULL;
+		err = 0;
 	} else {
+		err = mutex_lock_interruptible(&u->bindlock);
+		if (err)
+			goto out_addr;
+
+		err = -EINVAL;
+		if (u->addr) {
+			mutex_unlock(&u->bindlock);
+			goto out_addr;
+		}
+
 		spin_lock(&unix_table_lock);
 		err = -EADDRINUSE;
 		if (__unix_find_socket_byname(net, sunaddr, addr_len,
 					      sk->sk_type, hash)) {
 			spin_unlock(&unix_table_lock);
-			goto out_up;
+			mutex_unlock(&u->bindlock);
+			goto out_addr;
 		}
-		hash = addr->hash;
+		__unix_set_addr(sk, addr, addr->hash);
+		mutex_unlock(&u->bindlock);
+		addr = NULL;
+		err = 0;
 	}
-
-	__unix_set_addr(sk, addr, hash);
-	addr = NULL;
-	err = 0;
-out_up:
-	mutex_unlock(&u->bindlock);
-out_put:
-	if (err)
-		path_put(&path);
 out_addr:
 	if (addr)
 		unix_release_addr(addr);
-- 
2.11.0

