Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D617031F466
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Feb 2021 05:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhBSEUl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 23:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhBSEUk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 23:20:40 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2665BC061788;
        Thu, 18 Feb 2021 20:20:00 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lCxGj-00FgV2-IR; Fri, 19 Feb 2021 04:19:53 +0000
Date:   Fri, 19 Feb 2021 04:19:53 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Denis Kirjanov <kda@linux-powerpc.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/8] af_unix: take address assignment/hash insertion into a
 new helper
Message-ID: <YC88acS6dN6cU1y0@zeniv-ca.linux.org.uk>
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

Duplicated logics in all bind variants (autobind, bind-to-path,
bind-to-abstract) gets taken into a common helper.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 net/unix/af_unix.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 41c3303c3357..179b4fe837e6 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -262,6 +262,16 @@ static void __unix_insert_socket(struct hlist_head *list, struct sock *sk)
 	sk_add_node(sk, list);
 }
 
+static void __unix_set_addr(struct sock *sk, struct unix_address *addr,
+			    unsigned hash)
+	__releases(&unix_table_lock)
+{
+	__unix_remove_socket(sk);
+	smp_store_release(&unix_sk(sk)->addr, addr);
+	__unix_insert_socket(&unix_socket_table[hash], sk);
+	spin_unlock(&unix_table_lock);
+}
+
 static inline void unix_remove_socket(struct sock *sk)
 {
 	spin_lock(&unix_table_lock);
@@ -912,10 +922,7 @@ static int unix_autobind(struct socket *sock)
 	}
 	addr->hash ^= sk->sk_type;
 
-	__unix_remove_socket(sk);
-	smp_store_release(&u->addr, addr);
-	__unix_insert_socket(&unix_socket_table[addr->hash], sk);
-	spin_unlock(&unix_table_lock);
+	__unix_set_addr(sk, addr, addr->hash);
 	err = 0;
 
 out:	mutex_unlock(&u->bindlock);
@@ -1016,7 +1023,6 @@ static int unix_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 	int err;
 	unsigned int hash;
 	struct unix_address *addr;
-	struct hlist_head *list;
 	struct path path = { };
 
 	err = -EINVAL;
@@ -1068,26 +1074,20 @@ static int unix_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 		hash = d_backing_inode(path.dentry)->i_ino & (UNIX_HASH_SIZE - 1);
 		spin_lock(&unix_table_lock);
 		u->path = path;
-		list = &unix_socket_table[hash];
 	} else {
 		spin_lock(&unix_table_lock);
 		err = -EADDRINUSE;
 		if (__unix_find_socket_byname(net, sunaddr, addr_len,
 					      sk->sk_type, hash)) {
+			spin_unlock(&unix_table_lock);
 			unix_release_addr(addr);
-			goto out_unlock;
+			goto out_up;
 		}
-
-		list = &unix_socket_table[addr->hash];
+		hash = addr->hash;
 	}
 
+	__unix_set_addr(sk, addr, hash);
 	err = 0;
-	__unix_remove_socket(sk);
-	smp_store_release(&u->addr, addr);
-	__unix_insert_socket(list, sk);
-
-out_unlock:
-	spin_unlock(&unix_table_lock);
 out_up:
 	mutex_unlock(&u->bindlock);
 out_put:
-- 
2.11.0

