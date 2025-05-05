Return-Path: <linux-fsdevel+bounces-48125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0030AAA9CB8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 21:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8280C16347B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 19:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3E224CEE8;
	Mon,  5 May 2025 19:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bqBxAAIx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D3D19CC22;
	Mon,  5 May 2025 19:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746473929; cv=none; b=mcFeDPGIbiHxa2D8ZvN+GRfi2j6818Lu8TMPENQBVjYLldIabYbu0okB0rKkPh7JpCiEAA7gGBLUA59SRbchGVqhy1zuWrCqHTQFkYo8hlDi/gOli6t82YvVhxcu0JoSga5qVpo1uS3QvxmlngdplnoXhkiKJQerTd/A3EWRilg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746473929; c=relaxed/simple;
	bh=h5+ocRkThM3cFZuVHgdmPoWEi3V+/8Fni2J7OAHsn+A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e5/1f5T80uMjnPShdw0p92qB/vsmNMLIzNtV1Wzj0zaPHBKVprVLhvDp8i3WokHFbnyCxMQoG/Z3rREtGFqYfvrx4oUtw4fBga6C6hc9MJXsJhP1MhYxLpbxG8ibszIcmWy0MLsDjUTIoLu72KmgCx4oE662BTaieuUq42yvLPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=bqBxAAIx; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1746473928; x=1778009928;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EmyOzH4Yr6VUhqnbV3Hao5p1e1RvsY0yslF5wkCHRio=;
  b=bqBxAAIx7mDq8+szBJAZ/RYnhnYDMHlGmlsnLmkUXHAojKly1bGkDHl8
   NGI4y4ExCfI9KmMfKV+5wLtGCpXUiMxaaq14HaVk8wC4mmGfzJGFTM60v
   vKkkFmzK8Qp5NkVvyYPMB33BhCZ03Rtt1u8ZZSEjkJLPhymR9rIundQot
   8=;
X-IronPort-AV: E=Sophos;i="6.15,264,1739836800"; 
   d="scan'208";a="719938196"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 19:38:43 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:3458]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.32:2525] with esmtp (Farcaster)
 id 8e51118b-b34a-40f3-8714-330443b79728; Mon, 5 May 2025 19:38:41 +0000 (UTC)
X-Farcaster-Flow-ID: 8e51118b-b34a-40f3-8714-330443b79728
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 5 May 2025 19:38:40 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 5 May 2025 19:38:36 +0000
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
Date: Mon, 5 May 2025 12:35:50 -0700
Message-ID: <20250505193828.21759-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CAG48ez35FN6ka4QtrNQ6aKEycQBOpJKy=VyhQDzKTwey+4KOMg@mail.gmail.com>
References: <CAG48ez35FN6ka4QtrNQ6aKEycQBOpJKy=VyhQDzKTwey+4KOMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D040UWA001.ant.amazon.com (10.13.139.22) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jann Horn <jannh@google.com>
Date: Mon, 5 May 2025 21:10:28 +0200
> On Mon, May 5, 2025 at 8:41 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> > From: Christian Brauner <brauner@kernel.org>
> > Date: Mon, 5 May 2025 16:06:40 +0200
> > > On Mon, May 05, 2025 at 03:08:07PM +0200, Jann Horn wrote:
> > > > On Mon, May 5, 2025 at 1:14 PM Christian Brauner <brauner@kernel.org> wrote:
> > > > > Make sure that only tasks that actually coredumped may connect to the
> > > > > coredump socket. This restriction may be loosened later in case
> > > > > userspace processes would like to use it to generate their own
> > > > > coredumps. Though it'd be wiser if userspace just exposed a separate
> > > > > socket for that.
> > > >
> > > > This implementation kinda feels a bit fragile to me... I wonder if we
> > > > could instead have a flag inside the af_unix client socket that says
> > > > "this is a special client socket for coredumping".
> > >
> > > Should be easily doable with a sock_flag().
> >
> > This restriction should be applied by BPF LSM.
> 
> I think we shouldn't allow random userspace processes to connect to
> the core dump handling service and provide bogus inputs; that
> unnecessarily increases the risk that a crafted coredump can be used
> to exploit a bug in the service. So I think it makes sense to enforce
> this restriction in the kernel.

It's already restricted by /proc/sys/kernel/core_pattern.
We don't need a duplicated logic.

Even when the process holding the listener dies, you can
still avoid such a leak.

e.g.

1. Set up a listener
2. Put the socket into a bpf map
3. Attach LSM at connect()

Then, the LSM checks if the destination socket is

  * listening on the name specified in /proc/sys/kernel/core_pattern
  * exists in the associated BPF map

So, if the socket is dies and a malicious user tries to hijack
the core_pattern name, LSM still rejects such connect().

Later, the admin can restart the program with different core_pattern.


> 
> My understanding is that BPF LSM creates fairly tight coupling between
> userspace and the kernel implementation, and it is kind of unwieldy
> for userspace. (I imagine the "man 5 core" manpage would get a bit
> longer and describe more kernel implementation detail if you tried to
> show how to write a BPF LSM that is capable of detecting unix domain
> socket connections to a specific address that are not initiated by
> core dumping.) I would like to keep it possible to implement core
> userspace functionality in a best-practice way without needing eBPF.

I think the untrusted user scenario is paranoia in most cases,
and the man page just says "if you really care, use BPF LSM".

If someone can listen on a name AND set it to core_pattern, most
likely something worse already happened.


> 
> > It's hard to loosen such a default restriction as someone might
> > argue that's unexpected and regression.
> 
> If userspace wants to allow other processes to connect to the core
> dumping service, that's easy to implement - userspace can listen on a
> separate address that is not subject to these restrictions.
> 

