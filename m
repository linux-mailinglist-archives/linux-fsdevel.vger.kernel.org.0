Return-Path: <linux-fsdevel+bounces-9232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA8F83F49B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 09:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E08AE1C2167C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 08:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268CDDDC5;
	Sun, 28 Jan 2024 08:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="VgHeaGEL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03E8D536;
	Sun, 28 Jan 2024 08:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706430535; cv=none; b=i4V9AnslqtD5iCsdjxeaJDms+v3Wet0BjyiL4q3B0clgnomHFQcG9dt/wfT4ucYRBan9RLBLy0km4J9utxsZIS/PFn95v+2xx4FO+IhksERVjPR44Ksl54Cade1qZX+HTu+b1e4GESWkO509r/TPxJsoIfTVHA+TZUQZdttNHZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706430535; c=relaxed/simple;
	bh=VZJ32uBSnHeYLRqyWtoGJ+vKF2durp0l+kmkeHMQY4g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uB/ua+2Igt6iGv9TOb81S6d8Ab95AJdoAB+s2TBymZ2Q5zIaSnSA9DngXCP5iiuV6ln6/EQsItkhr5V7FSEPzJa2YLoxGliz8CTXTeYNzNnyxTNGIY61wYu7XqXahThpcVxggYWKLtPrWOYkqIJVid3dcvIVBcTJQbG1MfE26ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=VgHeaGEL; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706430533; x=1737966533;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Aer27LddC3vgYFmEG+ckZUqU4qn8n6YISCTG6G1GZy8=;
  b=VgHeaGELqUwp7GAJTzhRXTiNKRZy5doIseqYQYbIP0Em+fusrfWfImOp
   2lTPH/sQslDYPUUE7dgkDTLyC48CjZJznQpoFe6ITEzrHlhxaK4eomVBE
   MebhBQjDGOSiIdVy3aWpOy+elbi8LgMwgMnM5GiLNdumoadZxCvAbboWM
   c=;
X-IronPort-AV: E=Sophos;i="6.05,220,1701129600"; 
   d="scan'208";a="630396084"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-8c5b1df3.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 08:28:51 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-8c5b1df3.us-west-2.amazon.com (Postfix) with ESMTPS id 1D98440D4A;
	Sun, 28 Jan 2024 08:28:50 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:28618]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.8:2525] with esmtp (Farcaster)
 id a741d178-266c-4cf2-9742-14a26ef5d16b; Sun, 28 Jan 2024 08:28:49 +0000 (UTC)
X-Farcaster-Flow-ID: a741d178-266c-4cf2-9742-14a26ef5d16b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 28 Jan 2024 08:28:49 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 28 Jan 2024 08:28:46 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kent.overstreet@linux.dev>
CC: <boqun.feng@gmail.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<peterz@infradead.org>, <kuniyu@amazon.com>
Subject: Re: [PATCH 4/4] af_unix: convert to lock_cmp_fn
Date: Sun, 28 Jan 2024 00:28:38 -0800
Message-ID: <20240128082838.3961-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240127020833.487907-5-kent.overstreet@linux.dev>
References: <20240127020833.487907-5-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB003.ant.amazon.com (10.13.139.157) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Kent Overstreet <kent.overstreet@linux.dev>
Date: Fri, 26 Jan 2024 21:08:31 -0500
> Kill
>  - unix_state_lock_nested
>  - _nested usage for net->unx.table.locks[].
> 
> replace both with lock_set_cmp_fn_ptr_order(&u->lock).
> 
> The lock ordering in sk_diag_dump_icons() looks suspicious; this may
> turn up a real issue.

Yes, you cannot use lock_cmp_fn() for unix_state_lock_nested().

The lock order in sk_diag_dump_icons() is

  listening socket -> child socket in the listener's queue

, and the inverse order never happens.  ptr comparison does not make
sense in this case, and lockdep will complain about false positive.


> 
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>  include/net/af_unix.h |  3 ---
>  net/unix/af_unix.c    | 20 ++++++++------------
>  net/unix/diag.c       |  2 +-
>  3 files changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/include/net/af_unix.h b/include/net/af_unix.h
> index 49c4640027d8..4eff0a089640 100644
> --- a/include/net/af_unix.h
> +++ b/include/net/af_unix.h
> @@ -48,9 +48,6 @@ struct scm_stat {
>  
>  #define unix_state_lock(s)	spin_lock(&unix_sk(s)->lock)
>  #define unix_state_unlock(s)	spin_unlock(&unix_sk(s)->lock)
> -#define unix_state_lock_nested(s) \
> -				spin_lock_nested(&unix_sk(s)->lock, \
> -				SINGLE_DEPTH_NESTING)
>  
>  /* The AF_UNIX socket */
>  struct unix_sock {
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index d013de3c5490..1a0d273799c1 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -170,7 +170,7 @@ static void unix_table_double_lock(struct net *net,
>  		swap(hash1, hash2);
>  
>  	spin_lock(&net->unx.table.locks[hash1]);
> -	spin_lock_nested(&net->unx.table.locks[hash2], SINGLE_DEPTH_NESTING);
> +	spin_lock(&net->unx.table.locks[hash2]);
>  }
>  
>  static void unix_table_double_unlock(struct net *net,
> @@ -997,6 +997,7 @@ static struct sock *unix_create1(struct net *net, struct socket *sock, int kern,
>  	u->path.dentry = NULL;
>  	u->path.mnt = NULL;
>  	spin_lock_init(&u->lock);
> +	lock_set_cmp_fn_ptr_order(&u->lock);
>  	atomic_long_set(&u->inflight, 0);
>  	INIT_LIST_HEAD(&u->link);
>  	mutex_init(&u->iolock); /* single task reading lock */
> @@ -1340,17 +1341,11 @@ static int unix_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
>  
>  static void unix_state_double_lock(struct sock *sk1, struct sock *sk2)
>  {
> -	if (unlikely(sk1 == sk2) || !sk2) {
> -		unix_state_lock(sk1);
> -		return;
> -	}
> -	if (sk1 < sk2) {
> +	if (sk1 > sk2)
> +		swap(sk1, sk2);
> +	if (sk1 && sk1 != sk2)
>  		unix_state_lock(sk1);
> -		unix_state_lock_nested(sk2);
> -	} else {
> -		unix_state_lock(sk2);
> -		unix_state_lock_nested(sk1);
> -	}
> +	unix_state_lock(sk2);
>  }
>  
>  static void unix_state_double_unlock(struct sock *sk1, struct sock *sk2)
> @@ -1591,7 +1586,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
>  		goto out_unlock;
>  	}
>  
> -	unix_state_lock_nested(sk);
> +	unix_state_lock(sk);
>  
>  	if (sk->sk_state != st) {
>  		unix_state_unlock(sk);
> @@ -3575,6 +3570,7 @@ static int __net_init unix_net_init(struct net *net)
>  
>  	for (i = 0; i < UNIX_HASH_SIZE; i++) {
>  		spin_lock_init(&net->unx.table.locks[i]);
> +		lock_set_cmp_fn_ptr_order(&net->unx.table.locks[i]);
>  		INIT_HLIST_HEAD(&net->unx.table.buckets[i]);
>  	}
>  
> diff --git a/net/unix/diag.c b/net/unix/diag.c
> index bec09a3a1d44..8ab5e2217e4c 100644
> --- a/net/unix/diag.c
> +++ b/net/unix/diag.c
> @@ -84,7 +84,7 @@ static int sk_diag_dump_icons(struct sock *sk, struct sk_buff *nlskb)
>  			 * queue lock. With the other's queue locked it's
>  			 * OK to lock the state.
>  			 */
> -			unix_state_lock_nested(req);
> +			unix_state_lock(req);
>  			peer = unix_sk(req)->peer;
>  			buf[i++] = (peer ? sock_i_ino(peer) : 0);
>  			unix_state_unlock(req);
> -- 
> 2.43.0

