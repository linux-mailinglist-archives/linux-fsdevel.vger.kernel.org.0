Return-Path: <linux-fsdevel+bounces-49197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50649AB9128
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 23:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DCF57AB1DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 21:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B0329B773;
	Thu, 15 May 2025 21:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="UGxd2zhy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA7D4174A;
	Thu, 15 May 2025 21:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747343122; cv=none; b=My0/Wd2J3q4h52eVF1uf3HJ5lj7GzY6e9zzGYxUssItCoVwD3laovSw9peSxRD9KochMtnitLn+Pnu36m/exKaFePuRPCoPm1pp1qxdflts4Z6yJQxwWmEaEkFArcp+p3ztjP/fFipiLSBN8iZqT6QA1gE8hIKqpGdN4Bq/qB6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747343122; c=relaxed/simple;
	bh=hjdY6wXLhuusRwtLdNI+7Lc2DWrEQ6E1YASsEzK2Aks=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SJE0QmicJAsywpJkVgxghuNXVAKWN5ptK1sXXyT3bJInBmqLVRm6vOl67F6uePQTED135rpQ8bRzTRvSxPCThaYpzYlm6Ee4ulbYieimJG6IxYwsquD5hU5P/YLvyPqcETeSQu/GW9Cldhj8t4HwLqWdqUbBMl/Ye8FdUQRaL+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=UGxd2zhy; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747343122; x=1778879122;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tU5GPI6luOeZZUz1jc3iKVDreM5mUB0uafA/q4t13GU=;
  b=UGxd2zhya9q1VxIlJoDvVSmSdXaZk+CB9idGs9TZogy1c2z9T+7UxTKu
   pdoYMJmntnJzX6UX5iqVLwUiN+zrcQFDrKbUnyULO/9q5LXuhRfI5VucV
   BTsp432j9qMHacBrzmWqSRUFxIKXilOxsDeJBERVSzj2js0DoD0xlBjdm
   mpSxy5iXKC2Qss5Du8dNGiJ3Gnu/TkEbsuYhR7VIwuUYfGYoy4rS4iozU
   e85BmQB2i3umzaXR3BasjSRWnmVk0Vjep1sCxprqt0JJyoTwEdd2XlhvV
   C1xiC5Eh21zCA0gwmk9uOfwLSy2TBt85yTF57so66mwBlGIR/qYwdYTCk
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,292,1739836800"; 
   d="scan'208";a="405700419"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 21:05:16 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:60934]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.53:2525] with esmtp (Farcaster)
 id d61893e1-700d-487e-8d5c-88e3e57e8dda; Thu, 15 May 2025 21:05:10 +0000 (UTC)
X-Farcaster-Flow-ID: d61893e1-700d-487e-8d5c-88e3e57e8dda
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 15 May 2025 21:05:10 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.35) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 15 May 2025 21:05:05 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <jannh@google.com>
CC: <alexander@mihalicyn.com>, <bluca@debian.org>, <brauner@kernel.org>,
	<daan.j.demeyer@gmail.com>, <daniel@iogearbox.net>, <davem@davemloft.net>,
	<david@readahead.eu>, <edumazet@google.com>, <horms@kernel.org>,
	<jack@suse.cz>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<lennart@poettering.net>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<me@yhndnzj.com>, <netdev@vger.kernel.org>, <oleg@redhat.com>,
	<pabeni@redhat.com>, <viro@zeniv.linux.org.uk>, <zbyszek@in.waw.pl>
Subject: Re: [PATCH v7 4/9] coredump: add coredump socket
Date: Thu, 15 May 2025 14:04:37 -0700
Message-ID: <20250515210458.91912-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CAG48ez3fC902JU244d=0zzr39f+iXxQH0GZgJp0rs8pbu8ka4w@mail.gmail.com>
References: <CAG48ez3fC902JU244d=0zzr39f+iXxQH0GZgJp0rs8pbu8ka4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D041UWB003.ant.amazon.com (10.13.139.176) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jann Horn <jannh@google.com>
Date: Thu, 15 May 2025 22:52:22 +0200
> On Thu, May 15, 2025 at 7:01 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> > nit: please keep these in the reverse xmas tree order.
> > https://docs.kernel.org/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs
> 
> Isn't that rule specific to things that go through the net tree?

Which tree to go through doesn't matter, rather it's applied
to code maintained by netdev maintainers, especially net/ and
drivers/net/.

