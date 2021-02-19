Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCA031F475
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Feb 2021 05:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhBSEYd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 23:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhBSEYa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 23:24:30 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4509C061574;
        Thu, 18 Feb 2021 20:23:50 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lCxKV-00FgYw-Pp; Fri, 19 Feb 2021 04:23:47 +0000
Date:   Fri, 19 Feb 2021 04:23:47 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Denis Kirjanov <kda@linux-powerpc.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 8/8] __unix_find_socket_byname(): don't pass hash and type
 separately
Message-ID: <YC89U4dM2xX17FwT@zeniv-ca.linux.org.uk>
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

We only care about exclusive or of those, so pass that directly.
Makes life simpler for callers as well...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 net/unix/af_unix.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index bb4c6200953d..a7e20fcadfcc 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -288,11 +288,11 @@ static inline void unix_insert_socket(struct hlist_head *list, struct sock *sk)
 
 static struct sock *__unix_find_socket_byname(struct net *net,
 					      struct sockaddr_un *sunname,
-					      int len, int type, unsigned int hash)
+					      int len, unsigned int hash)
 {
 	struct sock *s;
 
-	sk_for_each(s, &unix_socket_table[hash ^ type]) {
+	sk_for_each(s, &unix_socket_table[hash]) {
 		struct unix_sock *u = unix_sk(s);
 
 		if (!net_eq(sock_net(s), net))
@@ -307,13 +307,12 @@ static struct sock *__unix_find_socket_byname(struct net *net,
 
 static inline struct sock *unix_find_socket_byname(struct net *net,
 						   struct sockaddr_un *sunname,
-						   int len, int type,
-						   unsigned int hash)
+						   int len, unsigned int hash)
 {
 	struct sock *s;
 
 	spin_lock(&unix_table_lock);
-	s = __unix_find_socket_byname(net, sunname, len, type, hash);
+	s = __unix_find_socket_byname(net, sunname, len, hash);
 	if (s)
 		sock_hold(s);
 	spin_unlock(&unix_table_lock);
@@ -900,12 +899,12 @@ static int unix_autobind(struct socket *sock)
 retry:
 	addr->len = sprintf(addr->name->sun_path+1, "%05x", ordernum) + 1 + sizeof(short);
 	addr->hash = unix_hash_fold(csum_partial(addr->name, addr->len, 0));
+	addr->hash ^= sk->sk_type;
 
 	spin_lock(&unix_table_lock);
 	ordernum = (ordernum+1)&0xFFFFF;
 
-	if (__unix_find_socket_byname(net, addr->name, addr->len, sock->type,
-				      addr->hash)) {
+	if (__unix_find_socket_byname(net, addr->name, addr->len, addr->hash)) {
 		spin_unlock(&unix_table_lock);
 		/*
 		 * __unix_find_socket_byname() may take long time if many names
@@ -920,7 +919,6 @@ static int unix_autobind(struct socket *sock)
 		}
 		goto retry;
 	}
-	addr->hash ^= sk->sk_type;
 
 	__unix_set_addr(sk, addr, addr->hash);
 	err = 0;
@@ -966,7 +964,7 @@ static struct sock *unix_find_other(struct net *net,
 		}
 	} else {
 		err = -ECONNREFUSED;
-		u = unix_find_socket_byname(net, sunname, len, type, hash);
+		u = unix_find_socket_byname(net, sunname, len, type ^ hash);
 		if (u) {
 			struct dentry *dentry;
 			dentry = unix_sk(u)->path.dentry;
@@ -1036,8 +1034,7 @@ static int unix_bind_bsd(struct sock *sk, struct unix_address *addr)
 	return err == -EEXIST ? -EADDRINUSE : err;
 }
 
-static int unix_bind_abstract(struct sock *sk, unsigned hash,
-			      struct unix_address *addr)
+static int unix_bind_abstract(struct sock *sk, struct unix_address *addr)
 {
 	struct unix_sock *u = unix_sk(sk);
 	int err;
@@ -1053,7 +1050,7 @@ static int unix_bind_abstract(struct sock *sk, unsigned hash,
 
 	spin_lock(&unix_table_lock);
 	if (__unix_find_socket_byname(sock_net(sk), addr->name, addr->len,
-				      sk->sk_type, hash)) {
+				      addr->hash)) {
 		spin_unlock(&unix_table_lock);
 		mutex_unlock(&u->bindlock);
 		return -EADDRINUSE;
@@ -1095,7 +1092,7 @@ static int unix_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 	if (sun_path[0])
 		err = unix_bind_bsd(sk, addr);
 	else
-		err = unix_bind_abstract(sk, hash, addr);
+		err = unix_bind_abstract(sk, addr);
 	if (err)
 		unix_release_addr(addr);
 	return err;
-- 
2.11.0

