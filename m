Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3972F31F468
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Feb 2021 05:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhBSEVZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 23:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhBSEVY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 23:21:24 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E139C061574;
        Thu, 18 Feb 2021 20:20:43 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lCxHS-00FgVY-VX; Fri, 19 Feb 2021 04:20:39 +0000
Date:   Fri, 19 Feb 2021 04:20:38 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Denis Kirjanov <kda@linux-powerpc.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/8] unix_bind(): allocate addr earlier
Message-ID: <YC88ln5Bhls27YqV@zeniv-ca.linux.org.uk>
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

From 24439dbb7b78cb301c73254b364020e6a3f31902 Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Thu, 18 Feb 2021 15:52:53 -0500
Subject: [PATCH 2/8] unix_bind(): allocate addr earlier

makes it easier to massage; we do pay for that by extra work
(kmalloc+memcpy+kfree) in some error cases, but those are not
on the hot paths anyway.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 net/unix/af_unix.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 179b4fe837e6..451d81f405c0 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1039,6 +1039,15 @@ static int unix_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 	if (err < 0)
 		goto out;
 	addr_len = err;
+	err = -ENOMEM;
+	addr = kmalloc(sizeof(*addr)+addr_len, GFP_KERNEL);
+	if (!addr)
+		goto out;
+
+	memcpy(addr->name, sunaddr, addr_len);
+	addr->len = addr_len;
+	addr->hash = hash ^ sk->sk_type;
+	refcount_set(&addr->refcnt, 1);
 
 	if (sun_path[0]) {
 		umode_t mode = S_IFSOCK |
@@ -1047,7 +1056,7 @@ static int unix_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 		if (err) {
 			if (err == -EEXIST)
 				err = -EADDRINUSE;
-			goto out;
+			goto out_addr;
 		}
 	}
 
@@ -1059,16 +1068,6 @@ static int unix_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 	if (u->addr)
 		goto out_up;
 
-	err = -ENOMEM;
-	addr = kmalloc(sizeof(*addr)+addr_len, GFP_KERNEL);
-	if (!addr)
-		goto out_up;
-
-	memcpy(addr->name, sunaddr, addr_len);
-	addr->len = addr_len;
-	addr->hash = hash ^ sk->sk_type;
-	refcount_set(&addr->refcnt, 1);
-
 	if (sun_path[0]) {
 		addr->hash = UNIX_HASH_SIZE;
 		hash = d_backing_inode(path.dentry)->i_ino & (UNIX_HASH_SIZE - 1);
@@ -1080,19 +1079,22 @@ static int unix_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 		if (__unix_find_socket_byname(net, sunaddr, addr_len,
 					      sk->sk_type, hash)) {
 			spin_unlock(&unix_table_lock);
-			unix_release_addr(addr);
 			goto out_up;
 		}
 		hash = addr->hash;
 	}
 
 	__unix_set_addr(sk, addr, hash);
+	addr = NULL;
 	err = 0;
 out_up:
 	mutex_unlock(&u->bindlock);
 out_put:
 	if (err)
 		path_put(&path);
+out_addr:
+	if (addr)
+		unix_release_addr(addr);
 out:
 	return err;
 }
-- 
2.11.0

