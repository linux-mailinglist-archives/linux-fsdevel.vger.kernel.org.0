Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C43731F46E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Feb 2021 05:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhBSEXD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 23:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhBSEXB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 23:23:01 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6E2C061756;
        Thu, 18 Feb 2021 20:22:21 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lCxJ5-00FgXI-1r; Fri, 19 Feb 2021 04:22:19 +0000
Date:   Fri, 19 Feb 2021 04:22:19 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Denis Kirjanov <kda@linux-powerpc.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/8] fold unix_mknod() into unix_bind_bsd()
Message-ID: <YC88+4o23SZKpHfK@zeniv-ca.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 net/unix/af_unix.c | 39 +++++++++++++++------------------------
 1 file changed, 15 insertions(+), 24 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index d7aeb4827747..36b88c8c438b 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -984,45 +984,36 @@ static struct sock *unix_find_other(struct net *net,
 	return NULL;
 }
 
-static int unix_mknod(const char *sun_path, umode_t mode, struct path *res)
+static int unix_bind_bsd(struct sock *sk, struct unix_address *addr)
 {
+	struct unix_sock *u = unix_sk(sk);
+	umode_t mode = S_IFSOCK |
+	       (SOCK_INODE(sk->sk_socket)->i_mode & ~current_umask());
+	struct path parent, path;
 	struct dentry *dentry;
-	struct path path;
-	int err = 0;
+	unsigned int hash;
+	int err;
+
 	/*
 	 * Get the parent directory, calculate the hash for last
 	 * component.
 	 */
-	dentry = kern_path_create(AT_FDCWD, sun_path, &path, 0);
-	err = PTR_ERR(dentry);
+	dentry = kern_path_create(AT_FDCWD, addr->name->sun_path, &parent, 0);
 	if (IS_ERR(dentry))
-		return err;
+		return PTR_ERR(dentry);
 
 	/*
 	 * All right, let's create it.
 	 */
-	err = security_path_mknod(&path, dentry, mode, 0);
+	err = security_path_mknod(&parent, dentry, mode, 0);
 	if (!err) {
-		err = vfs_mknod(d_inode(path.dentry), dentry, mode, 0);
+		err = vfs_mknod(d_inode(parent.dentry), dentry, mode, 0);
 		if (!err) {
-			res->mnt = mntget(path.mnt);
-			res->dentry = dget(dentry);
+			path.mnt = mntget(parent.mnt);
+			path.dentry = dget(dentry);
 		}
 	}
-	done_path_create(&path, dentry);
-	return err;
-}
-
-static int unix_bind_bsd(struct sock *sk, struct unix_address *addr)
-{
-	struct unix_sock *u = unix_sk(sk);
-	struct path path = { };
-	umode_t mode = S_IFSOCK |
-	       (SOCK_INODE(sk->sk_socket)->i_mode & ~current_umask());
-	unsigned int hash;
-	int err;
-
-	err = unix_mknod(addr->name->sun_path, mode, &path);
+	done_path_create(&parent, dentry);
 	if (err) {
 		if (err == -EEXIST)
 			err = -EADDRINUSE;
-- 
2.11.0

