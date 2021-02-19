Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A496531F471
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Feb 2021 05:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhBSEXr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 23:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhBSEXq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 23:23:46 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90B2C061574;
        Thu, 18 Feb 2021 20:23:05 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lCxJf-00FgXz-GY; Fri, 19 Feb 2021 04:22:55 +0000
Date:   Fri, 19 Feb 2021 04:22:55 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Denis Kirjanov <kda@linux-powerpc.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 6/8] unix_bind_bsd(): move done_path_create() call after
 dealing with ->bindlock
Message-ID: <YC89H3eTQnJBQkff@zeniv-ca.linux.org.uk>
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

Final preparations for doing unlink on failure past the successful
mknod.  We can't hold ->bindlock over ->mknod() or ->unlink(), since
either might do sb_start_write() (e.g. on overlayfs).  However, we
can do it while holding filesystem and VFS locks - doing
	kern_path_create()
	vfs_mknod()
	grab ->bindlock
	if u->addr had been set
		drop ->bindlock
		done_path_create
		return -EINVAL
	else
		assign the address to socket
		drop ->bindlock
		done_path_create
		return 0
would be deadlock-free.  Here we massage unix_bind_bsd() to that
form.  We are still doing equivalent transformations.

Next commit will *not* be an equivalent transformation - it will
add a call of vfs_unlink() before done_path_create() in "alread bound"
case.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 net/unix/af_unix.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 36b88c8c438b..d55035a9695f 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -989,7 +989,7 @@ static int unix_bind_bsd(struct sock *sk, struct unix_address *addr)
 	struct unix_sock *u = unix_sk(sk);
 	umode_t mode = S_IFSOCK |
 	       (SOCK_INODE(sk->sk_socket)->i_mode & ~current_umask());
-	struct path parent, path;
+	struct path parent;
 	struct dentry *dentry;
 	unsigned int hash;
 	int err;
@@ -1006,38 +1006,34 @@ static int unix_bind_bsd(struct sock *sk, struct unix_address *addr)
 	 * All right, let's create it.
 	 */
 	err = security_path_mknod(&parent, dentry, mode, 0);
-	if (!err) {
+	if (!err)
 		err = vfs_mknod(d_inode(parent.dentry), dentry, mode, 0);
-		if (!err) {
-			path.mnt = mntget(parent.mnt);
-			path.dentry = dget(dentry);
-		}
-	}
-	done_path_create(&parent, dentry);
+
 	if (err) {
 		if (err == -EEXIST)
 			err = -EADDRINUSE;
+		done_path_create(&parent, dentry);
 		return err;
 	}
-
 	err = mutex_lock_interruptible(&u->bindlock);
 	if (err) {
-		path_put(&path);
+		done_path_create(&parent, dentry);
 		return err;
 	}
-
 	if (u->addr) {
 		mutex_unlock(&u->bindlock);
-		path_put(&path);
+		done_path_create(&parent, dentry);
 		return -EINVAL;
 	}
 
 	addr->hash = UNIX_HASH_SIZE;
-	hash = d_backing_inode(path.dentry)->i_ino & (UNIX_HASH_SIZE - 1);
+	hash = d_backing_inode(dentry)->i_ino & (UNIX_HASH_SIZE - 1);
 	spin_lock(&unix_table_lock);
-	u->path = path;
+	u->path.mnt = mntget(parent.mnt);
+	u->path.dentry = dget(dentry);
 	__unix_set_addr(sk, addr, hash);
 	mutex_unlock(&u->bindlock);
+	done_path_create(&parent, dentry);
 	return 0;
 }
 
-- 
2.11.0

