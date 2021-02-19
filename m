Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1466631F46C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Feb 2021 05:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbhBSEWd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 23:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhBSEWb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 23:22:31 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180ECC061574;
        Thu, 18 Feb 2021 20:21:51 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lCxIb-00FgWr-9M; Fri, 19 Feb 2021 04:21:49 +0000
Date:   Fri, 19 Feb 2021 04:21:49 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Denis Kirjanov <kda@linux-powerpc.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/8] unix_bind(): take BSD and abstract address cases into
 new helpers
Message-ID: <YC883dvK+SuIm9pc@zeniv-ca.linux.org.uk>
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

unix_bind_bsd() and unix_bind_abstract() respectively.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 net/unix/af_unix.c | 144 +++++++++++++++++++++++++++--------------------------
 1 file changed, 74 insertions(+), 70 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 11e18b0efbc6..d7aeb4827747 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1013,101 +1013,105 @@ static int unix_mknod(const char *sun_path, umode_t mode, struct path *res)
 	return err;
 }
 
+static int unix_bind_bsd(struct sock *sk, struct unix_address *addr)
+{
+	struct unix_sock *u = unix_sk(sk);
+	struct path path = { };
+	umode_t mode = S_IFSOCK |
+	       (SOCK_INODE(sk->sk_socket)->i_mode & ~current_umask());
+	unsigned int hash;
+	int err;
+
+	err = unix_mknod(addr->name->sun_path, mode, &path);
+	if (err) {
+		if (err == -EEXIST)
+			err = -EADDRINUSE;
+		return err;
+	}
+
+	err = mutex_lock_interruptible(&u->bindlock);
+	if (err) {
+		path_put(&path);
+		return err;
+	}
+
+	if (u->addr) {
+		mutex_unlock(&u->bindlock);
+		path_put(&path);
+		return -EINVAL;
+	}
+
+	addr->hash = UNIX_HASH_SIZE;
+	hash = d_backing_inode(path.dentry)->i_ino & (UNIX_HASH_SIZE - 1);
+	spin_lock(&unix_table_lock);
+	u->path = path;
+	__unix_set_addr(sk, addr, hash);
+	mutex_unlock(&u->bindlock);
+	return 0;
+}
+
+static int unix_bind_abstract(struct sock *sk, unsigned hash,
+			      struct unix_address *addr)
+{
+	struct unix_sock *u = unix_sk(sk);
+	int err;
+
+	err = mutex_lock_interruptible(&u->bindlock);
+	if (err)
+		return err;
+
+	if (u->addr) {
+		mutex_unlock(&u->bindlock);
+		return -EINVAL;
+	}
+
+	spin_lock(&unix_table_lock);
+	if (__unix_find_socket_byname(sock_net(sk), addr->name, addr->len,
+				      sk->sk_type, hash)) {
+		spin_unlock(&unix_table_lock);
+		mutex_unlock(&u->bindlock);
+		return -EADDRINUSE;
+	}
+	__unix_set_addr(sk, addr, addr->hash);
+	mutex_unlock(&u->bindlock);
+	return 0;
+}
+
 static int unix_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 {
 	struct sock *sk = sock->sk;
-	struct net *net = sock_net(sk);
-	struct unix_sock *u = unix_sk(sk);
 	struct sockaddr_un *sunaddr = (struct sockaddr_un *)uaddr;
 	char *sun_path = sunaddr->sun_path;
 	int err;
 	unsigned int hash;
 	struct unix_address *addr;
 
-	err = -EINVAL;
 	if (addr_len < offsetofend(struct sockaddr_un, sun_family) ||
 	    sunaddr->sun_family != AF_UNIX)
-		goto out;
+		return -EINVAL;
 
-	if (addr_len == sizeof(short)) {
-		err = unix_autobind(sock);
-		goto out;
-	}
+	if (addr_len == sizeof(short))
+		return unix_autobind(sock);
 
 	err = unix_mkname(sunaddr, addr_len, &hash);
 	if (err < 0)
-		goto out;
+		return err;
 	addr_len = err;
-	err = -ENOMEM;
 	addr = kmalloc(sizeof(*addr)+addr_len, GFP_KERNEL);
 	if (!addr)
-		goto out;
+		return -ENOMEM;
 
 	memcpy(addr->name, sunaddr, addr_len);
 	addr->len = addr_len;
 	addr->hash = hash ^ sk->sk_type;
 	refcount_set(&addr->refcnt, 1);
 
-	if (sun_path[0]) {
-		struct path path = { };
-		umode_t mode = S_IFSOCK |
-		       (SOCK_INODE(sock)->i_mode & ~current_umask());
-		err = unix_mknod(sun_path, mode, &path);
-		if (err) {
-			if (err == -EEXIST)
-				err = -EADDRINUSE;
-			goto out_addr;
-		}
-
-		err = mutex_lock_interruptible(&u->bindlock);
-		if (err) {
-			path_put(&path);
-			goto out_addr;
-		}
-
-		err = -EINVAL;
-		if (u->addr) {
-			mutex_unlock(&u->bindlock);
-			path_put(&path);
-			goto out_addr;
-		}
-
-		addr->hash = UNIX_HASH_SIZE;
-		hash = d_backing_inode(path.dentry)->i_ino & (UNIX_HASH_SIZE - 1);
-		spin_lock(&unix_table_lock);
-		u->path = path;
-		__unix_set_addr(sk, addr, hash);
-		mutex_unlock(&u->bindlock);
-		addr = NULL;
-		err = 0;
-	} else {
-		err = mutex_lock_interruptible(&u->bindlock);
-		if (err)
-			goto out_addr;
-
-		err = -EINVAL;
-		if (u->addr) {
-			mutex_unlock(&u->bindlock);
-			goto out_addr;
-		}
-
-		spin_lock(&unix_table_lock);
-		err = -EADDRINUSE;
-		if (__unix_find_socket_byname(net, sunaddr, addr_len,
-					      sk->sk_type, hash)) {
-			spin_unlock(&unix_table_lock);
-			mutex_unlock(&u->bindlock);
-			goto out_addr;
-		}
-		__unix_set_addr(sk, addr, addr->hash);
-		mutex_unlock(&u->bindlock);
-		addr = NULL;
-		err = 0;
-	}
-out_addr:
-	if (addr)
+	if (sun_path[0])
+		err = unix_bind_bsd(sk, addr);
+	else
+		err = unix_bind_abstract(sk, hash, addr);
+	if (err)
 		unix_release_addr(addr);
-out:
 	return err;
 }
 
-- 
2.11.0

