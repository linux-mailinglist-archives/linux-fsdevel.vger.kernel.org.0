Return-Path: <linux-fsdevel+bounces-9235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2545083F4C3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 10:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5821A1C2123B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 09:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C306DF66;
	Sun, 28 Jan 2024 09:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="q6XUuXse"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761581CA9C;
	Sun, 28 Jan 2024 09:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706433494; cv=none; b=Jy6T4sieDcE2FFMelAnaPgZM4bSgOHq+qeZsXo4Bdkt02wfM96pABrddAZfPmZCErnPR82hH08rpZqq1AMEy8gDgXWJbHhqVngb2NYS8cCHWutE5DKRa7Jn1egiLjoGaL9ZqCUfWjv6h/WmlkZx6icl5sO9YVPULwEU/DEwXPXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706433494; c=relaxed/simple;
	bh=2CIAo7p8YLQ+5GDpWqQqmFIf0AbjP9xMSPmF+lmwHDs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YaOSYHMnECyZkGITh8jKMTVSoPTGkt1XfsxV5Ke6ERjPR0nQH9IrnREyD0QmvvI9Y4h6VMICozFp6iufZwCTk5jOClHkehaInwLWFsAD67WRNWfQrzq7LeSTnUV3jVr3cM93P95Hx8ESh6dhYXn00tm1xf0W1oCgFQ/tHohxaI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=q6XUuXse; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706433493; x=1737969493;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KqhGXnLeW9gFa27LDu76BMLx57htZ96OIe/VfEvgW5I=;
  b=q6XUuXseSydJGkeYe5CC8DQ0OAhefLLJDBVkq9KrKJTlzFSbYgtJ4vI8
   ZV1yAmpX+imyDCM3xJA/2v9M0zuS1Ft1uvp984p8sdR/EeXP7g0lqBrSH
   RMhPJueKPLZkWbHiLlcPMEnt9ic4avCMn6+f2SyFbBFnYuBD6npmQIP5K
   g=;
X-IronPort-AV: E=Sophos;i="6.05,220,1701129600"; 
   d="scan'208";a="630399487"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-dc7c3f8b.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 09:18:12 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2c-m6i4x-dc7c3f8b.us-west-2.amazon.com (Postfix) with ESMTPS id 1750BA099A;
	Sun, 28 Jan 2024 09:18:10 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:57075]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.8:2525] with esmtp (Farcaster)
 id fb09d7f9-488f-4aa1-99fc-9c6e2b7e8e3d; Sun, 28 Jan 2024 09:18:09 +0000 (UTC)
X-Farcaster-Flow-ID: fb09d7f9-488f-4aa1-99fc-9c6e2b7e8e3d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 28 Jan 2024 09:18:09 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 28 Jan 2024 09:18:06 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kent.overstreet@linux.dev>
CC: <boqun.feng@gmail.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<peterz@infradead.org>, <kuniyu@amazon.com>
Subject: Re: [PATCH 3/4] net: Convert sk->sk_peer_lock to lock_set_cmp_fn_ptr_order()
Date: Sun, 28 Jan 2024 01:17:58 -0800
Message-ID: <20240128091758.9206-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240127020833.487907-4-kent.overstreet@linux.dev>
References: <20240127020833.487907-4-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB001.ant.amazon.com (10.13.139.160) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Kent Overstreet <kent.overstreet@linux.dev>
Date: Fri, 26 Jan 2024 21:08:30 -0500
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>  net/core/sock.c    | 1 +
>  net/unix/af_unix.c | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 158dbdebce6a..da7360c0f454 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -3474,6 +3474,7 @@ void sock_init_data_uid(struct socket *sock, struct sock *sk, kuid_t uid)
>  	sk->sk_peer_pid 	=	NULL;
>  	sk->sk_peer_cred	=	NULL;
>  	spin_lock_init(&sk->sk_peer_lock);
> +	lock_set_cmp_fn_ptr_order(&sk->sk_peer_lock);
>  
>  	sk->sk_write_pending	=	0;
>  	sk->sk_rcvlowat		=	1;
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index ac1f2bc18fc9..d013de3c5490 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -706,10 +706,10 @@ static void copy_peercred(struct sock *sk, struct sock *peersk)
>  
>  	if (sk < peersk) {
>  		spin_lock(&sk->sk_peer_lock);
> -		spin_lock_nested(&peersk->sk_peer_lock, SINGLE_DEPTH_NESTING);
> +		spin_lock(&peersk->sk_peer_lock);
>  	} else {
>  		spin_lock(&peersk->sk_peer_lock);
> -		spin_lock_nested(&sk->sk_peer_lock, SINGLE_DEPTH_NESTING);
> +		spin_lock(&sk->sk_peer_lock);
>  	}

hmm.. I think we need not hold two locks here in the first place.
Let me post patches.

Thanks!


>  	old_pid = sk->sk_peer_pid;
>  	old_cred = sk->sk_peer_cred;
> -- 
> 2.43.0

