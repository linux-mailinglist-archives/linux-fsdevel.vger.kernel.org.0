Return-Path: <linux-fsdevel+bounces-48126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70278AA9CBD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 21:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 640D5189D49F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 19:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20EB1D6DB6;
	Mon,  5 May 2025 19:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mg74TtMj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBA525A2AD;
	Mon,  5 May 2025 19:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746474308; cv=none; b=tUTYFWxlJjUg6GBUtJwY407x1sFiHynIZ8/1WzQjSKs1OziEPtIH0Cx4CgjrnMM3IcgeGYTZT9Z+izvGQvZ1j3Ux67a9ywtypK4+BKLJjhoVEZgVDlREfGNT9D41B0CdFhRQ6QHQgn7j+IQxTk51fxtzGpPfw9e5F2u7Z6hEg4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746474308; c=relaxed/simple;
	bh=E5D00Fn3Ews3NrcKKo40oyb0gzJDlFcBX1biTaaaB/M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NHyRcxsFHfKcU7+aoWOlhZLFpnJaXTTufXHpHW4FWjMa6DOirTwLWwU+vTkApk89Ef9siptKh0pMa4JUG9+L4f9QsORcANd2PKKGNFPife0mufLOCvY6Ii1VIWp87urA1fo6pShXmbD7Gtt0fuPq3Fr4H50+GT9wtKNb1j42Vq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=mg74TtMj; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1746474306; x=1778010306;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=in13V4Hpf+rM5riCqQp8PkhP40WaDgpbmkmr0PaeIdU=;
  b=mg74TtMjtX5BsB7/ecNyyiha/yPhviJqK8hNBpLaygWG4iRQB+IPxXS3
   m++796nkesS725aK6nKi1ZtYB1Qj01sSsdk90v192n0JXULNgA7bMoitK
   Yyxu73OQ3a/KOBCyP6YttORTdG6GcipFSicy5rSyXe5dBWPu49w7ylTuX
   g=;
X-IronPort-AV: E=Sophos;i="6.15,264,1739836800"; 
   d="scan'208";a="193851574"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 19:45:04 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:50948]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.32:2525] with esmtp (Farcaster)
 id a2fb1d49-05fb-4bfc-b186-5b0439853504; Mon, 5 May 2025 19:45:04 +0000 (UTC)
X-Farcaster-Flow-ID: a2fb1d49-05fb-4bfc-b186-5b0439853504
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 5 May 2025 19:45:03 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 5 May 2025 19:44:59 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuniyu@amazon.com>
CC: <alexander@mihalicyn.com>, <bluca@debian.org>, <brauner@kernel.org>,
	<daan.j.demeyer@gmail.com>, <davem@davemloft.net>, <david@readahead.eu>,
	<edumazet@google.com>, <horms@kernel.org>, <jack@suse.cz>,
	<jannh@google.com>, <kuba@kernel.org>, <lennart@poettering.net>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<me@yhndnzj.com>, <netdev@vger.kernel.org>, <oleg@redhat.com>,
	<pabeni@redhat.com>, <viro@zeniv.linux.org.uk>, <zbyszek@in.waw.pl>
Subject: Re: [PATCH RFC v3 08/10] net, pidfs, coredump: only allow coredumping tasks to connect to coredump socket
Date: Mon, 5 May 2025 12:44:30 -0700
Message-ID: <20250505194451.22723-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250505193828.21759-1-kuniyu@amazon.com>
References: <20250505193828.21759-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D043UWA004.ant.amazon.com (10.13.139.41) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Kuniyuki Iwashima <kuniyu@amazon.com>
Date: Mon, 5 May 2025 12:35:50 -0700
> From: Jann Horn <jannh@google.com>
> Date: Mon, 5 May 2025 21:10:28 +0200
> > On Mon, May 5, 2025 at 8:41 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> > > From: Christian Brauner <brauner@kernel.org>
> > > Date: Mon, 5 May 2025 16:06:40 +0200
> > > > On Mon, May 05, 2025 at 03:08:07PM +0200, Jann Horn wrote:
> > > > > On Mon, May 5, 2025 at 1:14 PM Christian Brauner <brauner@kernel.org> wrote:
> > > > > > Make sure that only tasks that actually coredumped may connect to the
> > > > > > coredump socket. This restriction may be loosened later in case
> > > > > > userspace processes would like to use it to generate their own
> > > > > > coredumps. Though it'd be wiser if userspace just exposed a separate
> > > > > > socket for that.
> > > > >
> > > > > This implementation kinda feels a bit fragile to me... I wonder if we
> > > > > could instead have a flag inside the af_unix client socket that says
> > > > > "this is a special client socket for coredumping".
> > > >
> > > > Should be easily doable with a sock_flag().
> > >
> > > This restriction should be applied by BPF LSM.
> > 
> > I think we shouldn't allow random userspace processes to connect to
> > the core dump handling service and provide bogus inputs; that
> > unnecessarily increases the risk that a crafted coredump can be used
> > to exploit a bug in the service. So I think it makes sense to enforce
> > this restriction in the kernel.
> 
> It's already restricted by /proc/sys/kernel/core_pattern.
> We don't need a duplicated logic.
> 
> Even when the process holding the listener dies, you can
> still avoid such a leak.
> 
> e.g.
> 
> 1. Set up a listener
> 2. Put the socket into a bpf map
> 3. Attach LSM at connect()
> 
> Then, the LSM checks if the destination socket is
> 
>   * listening on the name specified in /proc/sys/kernel/core_pattern
>   * exists in the associated BPF map

and LSM can check if the source socket is a kernel socket too.


> 
> So, if the socket is dies and a malicious user tries to hijack
> the core_pattern name, LSM still rejects such connect().
> 
> Later, the admin can restart the program with different core_pattern.
> 
> 
> > 
> > My understanding is that BPF LSM creates fairly tight coupling between
> > userspace and the kernel implementation, and it is kind of unwieldy
> > for userspace. (I imagine the "man 5 core" manpage would get a bit
> > longer and describe more kernel implementation detail if you tried to
> > show how to write a BPF LSM that is capable of detecting unix domain
> > socket connections to a specific address that are not initiated by
> > core dumping.) I would like to keep it possible to implement core
> > userspace functionality in a best-practice way without needing eBPF.
> 
> I think the untrusted user scenario is paranoia in most cases,
> and the man page just says "if you really care, use BPF LSM".
> 
> If someone can listen on a name AND set it to core_pattern, most
> likely something worse already happened.
> 
> 
> > 
> > > It's hard to loosen such a default restriction as someone might
> > > argue that's unexpected and regression.
> > 
> > If userspace wants to allow other processes to connect to the core
> > dumping service, that's easy to implement - userspace can listen on a
> > separate address that is not subject to these restrictions.
> > 

