Return-Path: <linux-fsdevel+bounces-47416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FE1A9D382
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 22:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E908C7B83BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 20:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D31322CBD5;
	Fri, 25 Apr 2025 20:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="q50ypVGo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1806F219EB6;
	Fri, 25 Apr 2025 20:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745614097; cv=none; b=Pc0LwpPvpUBBC1I3N5c9Mzvpe2xN/XxjBSpQRdEuTAYMSrxI4sVmRxK0w+6A5cWj2AjlicQZh9iThCeKcdNRsAgfzpmMoK4zgcrtzdmvZ6GHKcmhaQSyIX4FBQdGhqtOlJWGW9+a8r7kRodkwUNVqzXHLfuMTvaVM43cFdYbpkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745614097; c=relaxed/simple;
	bh=xAeBHwLSOxSne/Thp7PHxwv44mY8WHpSgb2+ZJ36Mlk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pafd34PURqGX5RrIgbS9IeRWiPOolSsnVg/1Dg1azA0J7Oy7mD07iwi2uY7kc5hQgxd/kg3QgWGPq+xgQfLGn+0MNOFpAvJW9KDLg3l/22Om+CgNwTF6OXqpY/tVwmMct3N2eJgtVaDOeDqWdlhjmFMQvNFmt12VxToipfkiqNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=q50ypVGo; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1745614096; x=1777150096;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0ugj1nxdBDjlfhSIYyALctJ/L8UlqOrsiT4vUcCIlQo=;
  b=q50ypVGoks/gZFqxq1V2UVU207cIglFQ2TIOqbGphOcdK+nttyQDBPd5
   kzdxvFT9uIQu7x2CaXilqbFCOJosySw19ZrMDl4Cdpe44aYo/1Vf05wIB
   kLC8TFrsGAVVwid8hOMUaXSplIo+sg6m3R0whWtJeq9Y6vlaF9xilyRkF
   w=;
X-IronPort-AV: E=Sophos;i="6.15,240,1739836800"; 
   d="scan'208";a="194481346"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 20:48:14 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:65528]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.220:2525] with esmtp (Farcaster)
 id 0c507809-fa15-41b1-b049-b97e7622fb5e; Fri, 25 Apr 2025 20:48:13 +0000 (UTC)
X-Farcaster-Flow-ID: 0c507809-fa15-41b1-b049-b97e7622fb5e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 25 Apr 2025 20:48:12 +0000
Received: from 6c7e67bfbae3.amazon.com (10.142.164.216) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 25 Apr 2025 20:48:09 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <brauner@kernel.org>
CC: <alexander@mihalicyn.com>, <bluca@debian.org>, <daan.j.demeyer@gmail.com>,
	<davem@davemloft.net>, <david@readahead.eu>, <edumazet@google.com>,
	<horms@kernel.org>, <jack@suse.cz>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<lennart@poettering.net>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <me@yhndnzj.com>, <netdev@vger.kernel.org>,
	<oleg@redhat.com>, <pabeni@redhat.com>
Subject: Re: [PATCH v2 4/4] net, pidfs: enable handing out pidfds for reaped sk->sk_peer_pid
Date: Fri, 25 Apr 2025 13:47:59 -0700
Message-ID: <20250425204800.46158-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425-work-pidfs-net-v2-4-450a19461e75@kernel.org>
References: <20250425-work-pidfs-net-v2-4-450a19461e75@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA003.ant.amazon.com (10.13.139.42) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Christian Brauner <brauner@kernel.org>
Date: Fri, 25 Apr 2025 10:11:33 +0200
> Now that all preconditions are met, allow handing out pidfs for reaped
> sk->sk_peer_pids.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks!

