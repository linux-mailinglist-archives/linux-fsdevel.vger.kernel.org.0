Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F545A1D82
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 02:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244364AbiHZAHL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Aug 2022 20:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244311AbiHZAHJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Aug 2022 20:07:09 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C59C8748;
        Thu, 25 Aug 2022 17:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1661472427; x=1693008427;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r4LdSZUDZ6Wa2PcUEjszgiPOzzF4/l84paO2XRX3n54=;
  b=VximcEZrQ+cFjvcvCLV7b0oTrdyza2GQnBbANxZa+gdQzCx6KcHkFfai
   JGkIb5AGrvLnpDV2SU5GsePN3bloPSpM88f3n8IEekAGUYrJcUGeLYZke
   3wakmXtKu/AX9y+hDuv2YM4OsYFPqZAJ0YXCrn6/znAQNPE6vRjG9EnhU
   s=;
X-IronPort-AV: E=Sophos;i="5.93,264,1654560000"; 
   d="scan'208";a="123539149"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-5c4a15b1.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 00:06:53 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-5c4a15b1.us-west-2.amazon.com (Postfix) with ESMTPS id 7323C451A3;
        Fri, 26 Aug 2022 00:06:52 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Fri, 26 Aug 2022 00:06:51 +0000
Received: from 88665a182662.ant.amazon.com (10.43.162.140) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Fri, 26 Aug 2022 00:06:48 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
CC:     Kuniyuki Iwashima <kuniyu@amazon.com>,
        Kuniyuki Iwashima <kuni1840@gmail.com>,
        <netdev@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v1 net-next 05/13] tcp: Clean up some functions.
Date:   Thu, 25 Aug 2022 17:04:37 -0700
Message-ID: <20220826000445.46552-6-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220826000445.46552-1-kuniyu@amazon.com>
References: <20220826000445.46552-1-kuniyu@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.162.140]
X-ClientProxiedBy: EX13D10UWB001.ant.amazon.com (10.43.161.111) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch adds no functional change and cleans up some functions
that the following patches touch around so that we make them tidy
and easy to review/revert.  The changes are

  - Keep reverse christmas tree order
  - Remove unnecessary init of port in inet_csk_find_open_port()
  - Use req_to_sk() once in reqsk_queue_unlink()

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/inet_connection_sock.c | 21 ++++++++++-----------
 net/ipv4/inet_hashtables.c      | 29 +++++++++++++++--------------
 net/ipv4/tcp_ipv4.c             |  4 ++--
 3 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index f0038043b661..8e71d65cfad4 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -286,15 +286,13 @@ inet_csk_find_open_port(const struct sock *sk, struct inet_bind_bucket **tb_ret,
 			struct inet_bind_hashbucket **head2_ret, int *port_ret)
 {
 	struct inet_hashinfo *hinfo = sk->sk_prot->h.hashinfo;
-	int port = 0;
+	int i, low, high, attempt_half, port, l3mdev;
 	struct inet_bind_hashbucket *head, *head2;
 	struct net *net = sock_net(sk);
-	bool relax = false;
-	int i, low, high, attempt_half;
 	struct inet_bind2_bucket *tb2;
 	struct inet_bind_bucket *tb;
 	u32 remaining, offset;
-	int l3mdev;
+	bool relax = false;
 
 	l3mdev = inet_sk_bound_l3mdev(sk);
 ports_exhausted:
@@ -471,15 +469,14 @@ int inet_csk_get_port(struct sock *sk, unsigned short snum)
 {
 	bool reuse = sk->sk_reuse && sk->sk_state != TCP_LISTEN;
 	struct inet_hashinfo *hinfo = sk->sk_prot->h.hashinfo;
-	int ret = 1, port = snum;
-	struct net *net = sock_net(sk);
 	bool found_port = false, check_bind_conflict = true;
 	bool bhash_created = false, bhash2_created = false;
 	struct inet_bind_hashbucket *head, *head2;
 	struct inet_bind2_bucket *tb2 = NULL;
 	struct inet_bind_bucket *tb = NULL;
 	bool head2_lock_acquired = false;
-	int l3mdev;
+	int ret = 1, port = snum, l3mdev;
+	struct net *net = sock_net(sk);
 
 	l3mdev = inet_sk_bound_l3mdev(sk);
 
@@ -909,14 +906,16 @@ static void reqsk_migrate_reset(struct request_sock *req)
 /* return true if req was found in the ehash table */
 static bool reqsk_queue_unlink(struct request_sock *req)
 {
-	struct inet_hashinfo *hashinfo = req_to_sk(req)->sk_prot->h.hashinfo;
+	struct sock *sk = req_to_sk(req);
 	bool found = false;
 
-	if (sk_hashed(req_to_sk(req))) {
-		spinlock_t *lock = inet_ehash_lockp(hashinfo, req->rsk_hash);
+	if (sk_hashed(sk)) {
+		struct inet_hashinfo *hashinfo = sk->sk_prot->h.hashinfo;
+		spinlock_t *lock;
 
+		lock = inet_ehash_lockp(hashinfo, req->rsk_hash);
 		spin_lock(lock);
-		found = __sk_nulls_del_node_init_rcu(req_to_sk(req));
+		found = __sk_nulls_del_node_init_rcu(sk);
 		spin_unlock(lock);
 	}
 	if (timer_pending(&req->rsk_timer) && del_timer_sync(&req->rsk_timer))
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 60d77e234a68..29dce78de179 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -169,13 +169,14 @@ void inet_bind_hash(struct sock *sk, struct inet_bind_bucket *tb,
 static void __inet_put_port(struct sock *sk)
 {
 	struct inet_hashinfo *hashinfo = sk->sk_prot->h.hashinfo;
-	const int bhash = inet_bhashfn(sock_net(sk), inet_sk(sk)->inet_num,
-			hashinfo->bhash_size);
-	struct inet_bind_hashbucket *head = &hashinfo->bhash[bhash];
-	struct inet_bind_hashbucket *head2 =
-		inet_bhashfn_portaddr(hashinfo, sk, sock_net(sk),
-				      inet_sk(sk)->inet_num);
+	struct inet_bind_hashbucket *head, *head2;
+	struct net *net = sock_net(sk);
 	struct inet_bind_bucket *tb;
+	int bhash;
+
+	bhash = inet_bhashfn(net, inet_sk(sk)->inet_num, hashinfo->bhash_size);
+	head = &hashinfo->bhash[bhash];
+	head2 = inet_bhashfn_portaddr(hashinfo, sk, net, inet_sk(sk)->inet_num);
 
 	spin_lock(&head->lock);
 	tb = inet_csk(sk)->icsk_bind_hash;
@@ -209,17 +210,17 @@ int __inet_inherit_port(const struct sock *sk, struct sock *child)
 {
 	struct inet_hashinfo *table = sk->sk_prot->h.hashinfo;
 	unsigned short port = inet_sk(child)->inet_num;
-	const int bhash = inet_bhashfn(sock_net(sk), port,
-			table->bhash_size);
-	struct inet_bind_hashbucket *head = &table->bhash[bhash];
-	struct inet_bind_hashbucket *head2 =
-		inet_bhashfn_portaddr(table, child, sock_net(sk), port);
+	struct inet_bind_hashbucket *head, *head2;
 	bool created_inet_bind_bucket = false;
-	bool update_fastreuse = false;
 	struct net *net = sock_net(sk);
+	bool update_fastreuse = false;
 	struct inet_bind2_bucket *tb2;
 	struct inet_bind_bucket *tb;
-	int l3mdev;
+	int bhash, l3mdev;
+
+	bhash = inet_bhashfn(net, port, table->bhash_size);
+	head = &table->bhash[bhash];
+	head2 = inet_bhashfn_portaddr(table, child, net, port);
 
 	spin_lock(&head->lock);
 	spin_lock(&head2->lock);
@@ -629,8 +630,8 @@ static bool inet_ehash_lookup_by_sk(struct sock *sk,
 bool inet_ehash_insert(struct sock *sk, struct sock *osk, bool *found_dup_sk)
 {
 	struct inet_hashinfo *hashinfo = sk->sk_prot->h.hashinfo;
-	struct hlist_nulls_head *list;
 	struct inet_ehash_bucket *head;
+	struct hlist_nulls_head *list;
 	spinlock_t *lock;
 	bool ret = true;
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index cc2ad67f75be..61a9bf661814 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2406,9 +2406,9 @@ static void *established_get_first(struct seq_file *seq)
 
 static void *established_get_next(struct seq_file *seq, void *cur)
 {
-	struct sock *sk = cur;
-	struct hlist_nulls_node *node;
 	struct tcp_iter_state *st = seq->private;
+	struct hlist_nulls_node *node;
+	struct sock *sk = cur;
 
 	++st->num;
 	++st->offset;
-- 
2.30.2

