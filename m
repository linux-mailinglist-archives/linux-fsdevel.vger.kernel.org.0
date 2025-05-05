Return-Path: <linux-fsdevel+bounces-48130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F45FAA9D7C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 22:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CA245A0CB3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 20:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CA8270EA1;
	Mon,  5 May 2025 20:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="dypUlMDa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7623726FDAA;
	Mon,  5 May 2025 20:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746477732; cv=none; b=MUOdUKSjgJbjVccHBu71JQp032kyRwbumrPJKhMC+J8UUkN0e87rqH1YyE4ZQj4uaSnsfS02eRkx9w3D2UvEiEOYUtRdwVkWDGNLveBHilFspoX8SQmnUUDQxAmQjDqyoLvy+BS3sSLtOiACt3FaIJDhDDYqSpm3eFLj+GqXYXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746477732; c=relaxed/simple;
	bh=dGtv3RQfd81ha2ADXYVqJXeZnAASB8WkWmra4owmmC0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E/XoV0jl3rmsNRecgFMoxBN9vYABymoOI44f6e6bCJq0N4ZCNaDAkOVXz7SlIWxy2CXnYnPH+8sR18UiJEKCwtIWT3Q5zzkeN+EP7wWKy2fTVFIK6kY22lt6gBtXtuqJkigS+I99Qwe8y9DTriGKCw/ZDno4j32gJL2RNFXEKBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=dypUlMDa; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1746477730; x=1778013730;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G0EXnOP3G7keUVE+ya5D8zXpMtGwAkLtHPqE4Gmd3X0=;
  b=dypUlMDaQ3aD0qAGjkMUCf6J3Mo5Yto5VKwYgkiGDWGM2l25weU6SUkF
   HNscWTnSuppa1o+4/DDVHz8OpV880oKVxzLGoaOy+C6RdWvdIjWnNpLNX
   0IYRPB+s62QD/t9WLxRCrv6Fa5wdosoe/IKySOHPsEIOud0AAILhIAvan
   Q=;
X-IronPort-AV: E=Sophos;i="6.15,264,1739836800"; 
   d="scan'208";a="495725901"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 20:42:06 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:18793]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.114:2525] with esmtp (Farcaster)
 id f9ec8b4f-e323-4cd6-9ab9-e9c3fe307cb0; Mon, 5 May 2025 20:42:05 +0000 (UTC)
X-Farcaster-Flow-ID: f9ec8b4f-e323-4cd6-9ab9-e9c3fe307cb0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 5 May 2025 20:42:04 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 5 May 2025 20:42:00 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <jannh@google.com>
CC: <alexander@mihalicyn.com>, <bluca@debian.org>, <brauner@kernel.org>,
	<daan.j.demeyer@gmail.com>, <davem@davemloft.net>, <david@readahead.eu>,
	<edumazet@google.com>, <horms@kernel.org>, <jack@suse.cz>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <lennart@poettering.net>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<me@yhndnzj.com>, <netdev@vger.kernel.org>, <oleg@redhat.com>,
	<pabeni@redhat.com>, <viro@zeniv.linux.org.uk>, <zbyszek@in.waw.pl>
Subject: Re: [PATCH RFC v3 08/10] net, pidfs, coredump: only allow coredumping tasks to connect to coredump socket
Date: Mon, 5 May 2025 13:41:20 -0700
Message-ID: <20250505204152.33909-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CAG48ez2YRJxDmAZEOSWVvCyz0fkHN2NaC=_mLzcLibVKVOWqHw@mail.gmail.com>
References: <CAG48ez2YRJxDmAZEOSWVvCyz0fkHN2NaC=_mLzcLibVKVOWqHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jann Horn <jannh@google.com>
Date: Mon, 5 May 2025 21:55:06 +0200
> On Mon, May 5, 2025 at 9:45 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> > and LSM can check if the source socket is a kernel socket too.
> 
> ("a kernel socket" is not necessarily the same as "a kernel socket
> intended for core dumping")

Yes, but why we need to care about it :)

It doesn't happen or it's out-of-tree driver that is out-of-control
for us but should be in-control on the host where the service is
running.

