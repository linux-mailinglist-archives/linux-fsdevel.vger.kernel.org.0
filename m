Return-Path: <linux-fsdevel+bounces-47310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2748CA9BC30
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 03:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BBA85A263D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 01:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3C73597E;
	Fri, 25 Apr 2025 01:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ksdYkpDW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B09D24B34;
	Fri, 25 Apr 2025 01:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745543708; cv=none; b=gstklvA0VQuKdEP67lVan1eRyqYpTJcns/1ke6UeuQGEeu0xhekq7TyktfctEPyHRvw519GyH+c2N/ZsrqG+OUVa8RbHsErg/UhzMJVWvJ/h/n/g8Qp+33iwctJPmhGFLHUMbkwAmUeXAq/pI0T7RQOyTCOBHwil232b2YSi3AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745543708; c=relaxed/simple;
	bh=dibXvsCIlw/r5xer4uGGb3IzXFKI1fgh2NkaWgp2q4Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VrzUei7nqQv4lGYGkAfEmMNDOM8n0jB7AHtxBgIrsRe9YEmxK+UnzmfrtdPuFdonf+5T6MUINec+aFyy4OlBcV3dehlBHPBgPnNVBVC7pw7qIxAoMrIAURmYvbTFek4+M/igycx9+Qi7tX6Z/cmED5p8p0trFdtdGXX7v2CLn3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ksdYkpDW; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1745543706; x=1777079706;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6plyhxgT9bnqn3jAySOCqKgFkQSEJPbSjpMDXSsRL/0=;
  b=ksdYkpDWMpk7qsgJNOYwz3vaeE9lEiTLe0xpuKdv00SZigGRBwSYbYra
   QZ56k+0mzXU/jwHZF1NmP4+MWPDYfZK+dv538s8Gnkw1tEFulMsAVnraq
   1gacueHD2A3DXeoopMS/WAs5E1gJtiJx1psF9hkesBWaM8FoNTGvH3t4Y
   o=;
X-IronPort-AV: E=Sophos;i="6.15,237,1739836800"; 
   d="scan'208";a="738575957"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 01:15:01 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:42637]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.20:2525] with esmtp (Farcaster)
 id b487d46e-dabb-473b-a507-671f53cb5076; Fri, 25 Apr 2025 01:15:01 +0000 (UTC)
X-Farcaster-Flow-ID: b487d46e-dabb-473b-a507-671f53cb5076
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 25 Apr 2025 01:15:00 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 25 Apr 2025 01:14:56 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <brauner@kernel.org>
CC: <alexander@mihalicyn.com>, <bluca@debian.org>, <daan.j.demeyer@gmail.com>,
	<davem@davemloft.net>, <david@readahead.eu>, <edumazet@google.com>,
	<horms@kernel.org>, <jack@suse.cz>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<lennart@poettering.net>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <me@yhndnzj.com>, <netdev@vger.kernel.org>,
	<oleg@redhat.com>, <pabeni@redhat.com>
Subject: Re: [PATCH RFC 2/4] net, pidfs: prepare for handing out pidfds for reaped sk->sk_peer_pid
Date: Thu, 24 Apr 2025 18:08:46 -0700
Message-ID: <20250425011448.86924-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424-chipsatz-verpennen-afa9e213e332@brauner>
References: <20250424-chipsatz-verpennen-afa9e213e332@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC001.ant.amazon.com (10.13.139.218) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Christian Brauner <brauner@kernel.org>
Date: Thu, 24 Apr 2025 17:19:28 +0200
> > > @@ -643,6 +644,14 @@ static void unix_sock_destructor(struct sock *sk)
> > >  		return;
> > >  	}
> > > 
> > > +	if (sock_flag(sk, SOCK_RCU_FREE)) {
> > > +		pr_info("Attempting to release RCU protected socket with sleeping 
> > > locks: %p\n", sk);
> > > +		return;
> > > +	}
> > 
> > unix-sockets do not use `SOCK_RCU_FREE`,

Right, and I think we won't flag SOCK_RCU_FREE in the future.


> but even if they did, doesn't
> > this flag imply that the destructor is delayed via `call_rcu`, and
> > thus *IS* allowed to sleep? And then, sleeping in the destructor is
> > always safe, isn't it? `SOCK_RCU_FREE` just guarantees that it is
> > delayed for at least an RCU grace period, right? Not sure, what you
> > are getting at here, but I might be missing something obvious as well.
> 
> Callbacks run from call_rcu() can be called from softirq context and in
> general are not allowed to block. That's what queue_rcu_work() is for
> which uses system_unbound_wq.
> 
> > 
> > Regardless, wouldn't you want WARN_ON_ONCE() rather than pr_info?
> 
> Sure.

I prefer DEBUG_NET_WARN_ON_ONCE() or removing it as rcu_sleep_check()
in __might_sleep() has better checks.

The netdev CI enables debug.config, which has CONFIG_DEBUG_ATOMIC_SLEEP
and enables the checks, so adding a test case in
tools/testing/selftests/net/af_unix/scm_pidfd.c will catch the future
regression.

