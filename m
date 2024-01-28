Return-Path: <linux-fsdevel+bounces-9253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E5D83F9F2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 21:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB3CD1C21CAD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 20:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331B13C068;
	Sun, 28 Jan 2024 20:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bkXwz3GF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0202F31A7E;
	Sun, 28 Jan 2024 20:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706475411; cv=none; b=pVLRvikIZaKaC8KhZHgqUY3U+pAVlHfstej6dyeOxu/VkEZ8iWyWO3gd+amUUznbDzw7kSu9vgcOXA4X+cMsjKbodC21hrsq/cyEfL12La11kGf9driTe3wyX26WFim/5D2UMT6onOdb45QKQ8JqbHg4zNM9vzugc/h8BA6aCUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706475411; c=relaxed/simple;
	bh=zQPpEUHp5eKj9EhyK7RuxwngFTVum61WXyXTsZdGoLA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kar06IDagJGhzesuO2TqBOspHVjmepp3hEEQTJu317hoNPJI+w8+kgrOlPtnp/Xq4FI4ldbMZm/s+I5T8C2heOZ2vTVZVtx9sCaHsxUwsdhUnAvOEld37FrX7jJD1feAjde2TJf2SXBWzkKCbOfHukybRdrIcip2ggEksfAvgIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=bkXwz3GF; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706475410; x=1738011410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kNjMyJ+fMASTc2wcvJOQRFW38HN5NRSbZjppugncMZ4=;
  b=bkXwz3GFwWBo4hVI+2kTN+ZFgQweXRFupBhXOnkjq70/EC97uGgp7Tg1
   gfygGgNNoKEOju0K9SvDrN4TLovT0zYs3g8uwRvBzdS98B0wN0ft6TKtk
   kOT+hvx70MoU6+MfTqKVx8fa29f2LhOiWEEOoMDgZg2xm14dCf4moPyAB
   s=;
X-IronPort-AV: E=Sophos;i="6.05,220,1701129600"; 
   d="scan'208";a="270070340"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-3e1fab07.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 20:56:48 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1e-m6i4x-3e1fab07.us-east-1.amazon.com (Postfix) with ESMTPS id B9CCD80632;
	Sun, 28 Jan 2024 20:56:45 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:53888]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.162:2525] with esmtp (Farcaster)
 id b7ac26ac-411e-4303-8e3e-96e5a3a16879; Sun, 28 Jan 2024 20:56:45 +0000 (UTC)
X-Farcaster-Flow-ID: b7ac26ac-411e-4303-8e3e-96e5a3a16879
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 28 Jan 2024 20:56:44 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Sun, 28 Jan 2024 20:56:41 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kent.overstreet@linux.dev>
CC: <boqun.feng@gmail.com>, <kuniyu@amazon.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <peterz@infradead.org>
Subject: Re: [PATCH 4/4] af_unix: convert to lock_cmp_fn
Date: Sun, 28 Jan 2024 12:56:32 -0800
Message-ID: <20240128205632.93670-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <suyvonwf55vfeumeujeats2mtozs2q4wcx6ijz4hqfd54mibjj@6dt26flhrfdh>
References: <suyvonwf55vfeumeujeats2mtozs2q4wcx6ijz4hqfd54mibjj@6dt26flhrfdh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB002.ant.amazon.com (10.13.138.97) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Kent Overstreet <kent.overstreet@linux.dev>
Date: Sun, 28 Jan 2024 14:38:02 -0500
> On Sun, Jan 28, 2024 at 12:28:38AM -0800, Kuniyuki Iwashima wrote:
> > From: Kent Overstreet <kent.overstreet@linux.dev>
> > Date: Fri, 26 Jan 2024 21:08:31 -0500
> > > Kill
> > >  - unix_state_lock_nested
> > >  - _nested usage for net->unx.table.locks[].
> > > 
> > > replace both with lock_set_cmp_fn_ptr_order(&u->lock).
> > > 
> > > The lock ordering in sk_diag_dump_icons() looks suspicious; this may
> > > turn up a real issue.
> > 
> > Yes, you cannot use lock_cmp_fn() for unix_state_lock_nested().
> > 
> > The lock order in sk_diag_dump_icons() is
> > 
> >   listening socket -> child socket in the listener's queue
> > 
> > , and the inverse order never happens.  ptr comparison does not make
> > sense in this case, and lockdep will complain about false positive.
> 
> Is that a real lock ordering? Is this parent -> child relationship well
> defined?
> 
> If it is, we should be able to write a lock_cmp_fn for it, as long as
> it's not some handwavy "this will never happen but _nested won't check
> for it" like I saw elsewhere in the net code... :)

The problem would be there's no handy way to detect the relationship
except for iterating the queue again.

---8<---
static int unix_state_lock_cmp_fn(const struct lockdep_map *_a,
				  const struct lockdep_map *_b)
{
	const struct unix_sock *a = container_of(_a, struct unix_sock, lock.dep_map);
	const struct unix_sock *b = container_of(_b, struct unix_sock, lock.dep_map);

	if (a->sk.sk_state == TCP_LISTEN && b->sk.sk_state == TCP_ESTABLISHED) {
		/* check if b is a's cihld */
	}

	/* otherwise, ptr comparison here. */
}
---8<---


This can be resolved by a patch like this, which is in my local tree
for another series.

So, after posting the series, I can revisit this and write lock_cmp_fn
for u->lock.

---8<---
commit 12d39766b06068fda5987f4e7b4827e8c3273137
Author: Kuniyuki Iwashima <kuniyu@amazon.com>
Date:   Thu Jan 11 22:36:58 2024 +0000

    af_unix: Save listener for embryo socket.
    
    Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 9ea04653c7c9..d0c0d81bcb1d 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -82,6 +82,7 @@ struct scm_stat {
 struct unix_sock {
 	/* WARNING: sk has to be the first member */
 	struct sock		sk;
+#define usk_listener		sk.__sk_common.skc_unix_listener
 	struct unix_address	*addr;
 	struct path		path;
 	struct mutex		iolock, bindlock;
diff --git a/include/net/sock.h b/include/net/sock.h
index a9d99a9c583f..3df3d068345a 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -142,6 +142,8 @@ typedef __u64 __bitwise __addrpair;
  *		[union with @skc_incoming_cpu]
  *	@skc_tw_rcv_nxt: (aka tw_rcv_nxt) TCP window next expected seq number
  *		[union with @skc_incoming_cpu]
+ *	@skc_unix_listener: connection request listener socket for AF_UNIX
+ *		[union with @skc_rxhash]
  *	@skc_refcnt: reference count
  *
  *	This is the minimal network layer representation of sockets, the header
@@ -227,6 +229,7 @@ struct sock_common {
 		u32		skc_rxhash;
 		u32		skc_window_clamp;
 		u32		skc_tw_snd_nxt; /* struct tcp_timewait_sock */
+		struct sock	*skc_unix_listener; /* struct unix_sock */
 	};
 	/* public: */
 };
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 5f9871555ec6..4a41bb727c32 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -991,6 +991,7 @@ static struct sock *unix_create1(struct net *net, struct socket *sock, int kern,
 	sk->sk_max_ack_backlog	= net->unx.sysctl_max_dgram_qlen;
 	sk->sk_destruct		= unix_sock_destructor;
 	u = unix_sk(sk);
+	u->usk_listener = NULL;
 	u->inflight = 0;
 	u->path.dentry = NULL;
 	u->path.mnt = NULL;
@@ -1612,6 +1613,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	newsk->sk_type		= sk->sk_type;
 	init_peercred(newsk);
 	newu = unix_sk(newsk);
+	newu->usk_listener = other;
 	RCU_INIT_POINTER(newsk->sk_wq, &newu->peer_wq);
 	otheru = unix_sk(other);
 
@@ -1707,8 +1709,8 @@ static int unix_accept(struct socket *sock, struct socket *newsock, int flags,
 		       bool kern)
 {
 	struct sock *sk = sock->sk;
-	struct sock *tsk;
 	struct sk_buff *skb;
+	struct sock *tsk;
 	int err;
 
 	err = -EOPNOTSUPP;
@@ -1733,6 +1735,7 @@ static int unix_accept(struct socket *sock, struct socket *newsock, int flags,
 	}
 
 	tsk = skb->sk;
+	unix_sk(tsk)->usk_listener = NULL;
 	skb_free_datagram(sk, skb);
 	wake_up_interruptible(&unix_sk(sk)->peer_wait);
 
---8<---


