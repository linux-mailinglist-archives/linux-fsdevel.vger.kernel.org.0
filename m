Return-Path: <linux-fsdevel+bounces-48118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D493AA9BBD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 20:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20F157AA489
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 18:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1ADA26F463;
	Mon,  5 May 2025 18:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="A44qZa+0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B065226B95B;
	Mon,  5 May 2025 18:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746470517; cv=none; b=ulgsXlsivrXJSq1TDMp2tbrDcvwGfY7JJnWGfgsMew2Gix9FjWRXDqB1DkyoPEA5qt+T2bIQ93Mb7xvsIt3kGrxL63D3fy2ncg69boGSjQ2QyFXpyizCxyWmIi0YDhozOKwx/RG3yiW7e1LN/lTiJmrFCassrkjGD3ldC3rUfsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746470517; c=relaxed/simple;
	bh=0FKqzIZqpRDgytT3ZyiY95cLaU6PsvUZkhQ3BP23iMQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BO0Zqh64MI2C0muxSSsPHVhkK96gniJPY9oJgYA9NBK45bXu97A+m+TodVUiDkv0ne9RvaAKyhByKdZktRpK/w4GnhTV2QVPgZzdtMR/s4CSmYC0OHWCT3U10AU9Gyy+Q3MdCSLFHDhweTBmhSBRyCDF0voP9z67IyJWerh/WD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=A44qZa+0; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1746470516; x=1778006516;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jzsJ5oRudDtZ2RKXtGkIO8UfccGcREzhv5fccqsAE2o=;
  b=A44qZa+0EWOhNIJ6M2N+fSYU/Fxh/MItG6L36rHYwueWgLmUqVcsqmdA
   qTSDFqs1F2vWfXzWYIOTVgvYRhzD3lQLj6nVe52GAG0K5P4H829GIs+ed
   sHCKsZt6UxbQMNJdNgxrHF+8g4ledDI16nkvBfBtzcnJ7CZ+NyZzwG/F9
   U=;
X-IronPort-AV: E=Sophos;i="6.15,264,1739836800"; 
   d="scan'208";a="16777511"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 18:41:50 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:21691]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.231:2525] with esmtp (Farcaster)
 id 116f77bc-4965-47e3-ba00-f67fffc1ce7a; Mon, 5 May 2025 18:41:49 +0000 (UTC)
X-Farcaster-Flow-ID: 116f77bc-4965-47e3-ba00-f67fffc1ce7a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 5 May 2025 18:41:48 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 5 May 2025 18:41:44 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <brauner@kernel.org>
CC: <alexander@mihalicyn.com>, <bluca@debian.org>, <daan.j.demeyer@gmail.com>,
	<davem@davemloft.net>, <david@readahead.eu>, <edumazet@google.com>,
	<horms@kernel.org>, <jack@suse.cz>, <jannh@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <lennart@poettering.net>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<me@yhndnzj.com>, <netdev@vger.kernel.org>, <oleg@redhat.com>,
	<pabeni@redhat.com>, <viro@zeniv.linux.org.uk>, <zbyszek@in.waw.pl>
Subject: Re: [PATCH RFC v3 08/10] net, pidfs, coredump: only allow coredumping tasks to connect to coredump socket
Date: Mon, 5 May 2025 11:40:26 -0700
Message-ID: <20250505184136.14852-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250505-dompteur-hinhalten-204b1e16bd02@brauner>
References: <20250505-dompteur-hinhalten-204b1e16bd02@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D043UWC001.ant.amazon.com (10.13.139.202) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Christian Brauner <brauner@kernel.org>
Date: Mon, 5 May 2025 16:06:40 +0200
> On Mon, May 05, 2025 at 03:08:07PM +0200, Jann Horn wrote:
> > On Mon, May 5, 2025 at 1:14 PM Christian Brauner <brauner@kernel.org> wrote:
> > > Make sure that only tasks that actually coredumped may connect to the
> > > coredump socket. This restriction may be loosened later in case
> > > userspace processes would like to use it to generate their own
> > > coredumps. Though it'd be wiser if userspace just exposed a separate
> > > socket for that.
> > 
> > This implementation kinda feels a bit fragile to me... I wonder if we
> > could instead have a flag inside the af_unix client socket that says
> > "this is a special client socket for coredumping".
> 
> Should be easily doable with a sock_flag().

This restriction should be applied by BPF LSM.

It's hard to loosen such a default restriction as someone might
argue that's unexpected and regression.

