Return-Path: <linux-fsdevel+bounces-47314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCD6A9BC93
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 03:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14B5B4A2B19
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 01:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E0E1537A7;
	Fri, 25 Apr 2025 01:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Nu5gNgBC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422984C7C;
	Fri, 25 Apr 2025 01:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745546372; cv=none; b=l2epPFp4aGE4UxYZg586zVtvK1Soa+QL82Gbiv8Tjg7OlrfrQdaICosTIw+YQYRC8xNuZRrVng5+CiOkDm8M/7mYIEp4NXW9+tp5fY3fh08HpAgY9rdL1hyS8v4kgdctkB0n88ZFAPWN9hfX7kd4x+fHqZ+gNo3ABQ8+TVw+tFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745546372; c=relaxed/simple;
	bh=+raNOYS8WXaA8C1oJIjsKu8SNSfgIJF4Td6CTRpGzto=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ocam8vx18/kRX46fEvhlNFMVBeGJFAouRd+UXJEIlPjxYaAd4WeVXtPFntkJZx2e62czaIqtneaxBS/QPCZy2LkraB1MbIxtRV4SG5E8np9fxqawVDnYNibneuim7ozs++7tvn6cjtMTYgCAGhrYLxyAgmiBx3kRi7mJiDnp2vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Nu5gNgBC; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1745546371; x=1777082371;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/UvTrfENQSso9dk5x/xbtN23kE4a23kj6ZgvvmCpbBY=;
  b=Nu5gNgBC9cCMS1iM1RZEgFC8zUNwreP44z04MiUoT6qewdpPLuSrZB0F
   M4Q5v+l2ftqUyWJhUpgppjUuMSw18e0t2qrGPIvlJI4NPug+z/Whg8byx
   Ofqz7cs5uLJVgxM9xCchH6NLgwPYZvJmVA9G0Cr2PSzUV+qg7ah1xWgrU
   8=;
X-IronPort-AV: E=Sophos;i="6.15,237,1739836800"; 
   d="scan'208";a="483544296"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 01:59:26 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:40601]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.26.145:2525] with esmtp (Farcaster)
 id 4a79e7f5-eeb9-447e-a037-2d34145183d0; Fri, 25 Apr 2025 01:59:25 +0000 (UTC)
X-Farcaster-Flow-ID: 4a79e7f5-eeb9-447e-a037-2d34145183d0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 25 Apr 2025 01:59:24 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 25 Apr 2025 01:59:20 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <brauner@kernel.org>
CC: <alexander@mihalicyn.com>, <bluca@debian.org>, <daan.j.demeyer@gmail.com>,
	<davem@davemloft.net>, <david@readahead.eu>, <edumazet@google.com>,
	<horms@kernel.org>, <jack@suse.cz>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<lennart@poettering.net>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <me@yhndnzj.com>, <netdev@vger.kernel.org>,
	<oleg@redhat.com>, <pabeni@redhat.com>
Subject: Re: [PATCH RFC 2/4] net, pidfs: prepare for handing out pidfds for reaped sk->sk_peer_pid
Date: Thu, 24 Apr 2025 18:57:19 -0700
Message-ID: <20250425015911.93197-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424-work-pidfs-net-v1-2-0dc97227d854@kernel.org>
References: <20250424-work-pidfs-net-v1-2-0dc97227d854@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Christian Brauner <brauner@kernel.org>
Date: Thu, 24 Apr 2025 14:24:35 +0200
> @@ -734,13 +743,48 @@ static void unix_release_sock(struct sock *sk, int embrion)
>  		unix_gc();		/* Garbage collect fds */
>  }
>  
> -static void init_peercred(struct sock *sk)
> +struct af_unix_peercred {

nit: conventional naming for AF_UNIX is without af_, all structs
(and most functions) start with unix_.


> +	struct pid *peer_pid;
> +	const struct cred *peer_cred;
> +};
> +
> +static inline int prepare_peercred(struct af_unix_peercred *peercred)
> +{
> +	struct pid *pid;
> +	int err;
> +
> +	pid = task_tgid(current);
> +	err = pidfs_register_pid(pid);
> +	if (likely(!err)) {
> +		peercred->peer_pid = get_pid(pid);
> +		peercred->peer_cred = get_current_cred();
> +	}
> +	return err;
> +}
> +
> +static void drop_peercred(struct af_unix_peercred *peercred)
> +{
> +	struct pid *pid = NULL;
> +	const struct cred *cred = NULL;

another nit: please keep variables in reverse xmas tree order.
https://docs.kernel.org/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs

Otherwise looks good to me.

