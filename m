Return-Path: <linux-fsdevel+bounces-48286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF09AAACDEB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 21:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EB6F3BB99D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 19:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F661F4176;
	Tue,  6 May 2025 19:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="iOJMpOmx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE471C3C14;
	Tue,  6 May 2025 19:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746559116; cv=none; b=T/+iMHBy82pBwYMxbs6VXjFeGrYf61+UqGHlgFmfyuq8l/SGGHwkokV3YA7NhQrM88M6AsXyJcJMYaNPfmhT2KcUzuxvuijmOY6noGgBhhhpj6zhknWKc3Lq+0Tsm9ZEItIjQWIQ3fGUPb5ALyVQ+XL8Gxr+1QfH8Z6ibpc7ShY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746559116; c=relaxed/simple;
	bh=KmQUTFKNw48BeM/Yl9YgetYIh2v0+91c2dmV0lrA1CY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eHm9b19qQJ991ysYc+Pm7FC7a2PukZdWjA/ODJkPZyzl/J8iuoqh7l5im0MdpmZvIM5VDGTfaNdjrO973JSQQ1JVT9zmkHCIGNJtipQmSblE6RsVxFc1Tv7l4uxaR+xfiDJczJ0U9pj6xmnFLKoGSat+N3Jw3XbV/zhtuOlB8VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=iOJMpOmx; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1746559112; x=1778095112;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MGS6WcCdgR40DRTItgS2fPnyq9VSeBn6e33rAdkaNuI=;
  b=iOJMpOmxOhpUNaG48bYoCKPWuKhlUQZO/faHertLFOksi5e66ZUKRJhy
   UMJ93V6a5YlXm0f/XJSB8DMAA19ODaE5y3MIUGUprY2rI66XdtD4kqRZx
   hkxDSxNI9Yk+aVHbOEILUdLZRR7R/nFnAGGfavcvrhfhwKrb/M31Y0MND
   sKZdVLiLCQPSxn6BOFCJyLcrNmWtfryKSFRWSf1ztlin6PNRuAyu0Odt7
   3X7TrAmXooLIB1UVGrwhkRy0fslJi3rTgi+dqVxmKUugn1qahNYVdgOyO
   jARXlcGZyr0Seh3/ipYuPh0U8Om1dQqcHvFm6/8ufQ7sp0/ZPdyj7Hqf0
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,267,1739836800"; 
   d="scan'208";a="197906031"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 19:18:30 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:23045]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.68:2525] with esmtp (Farcaster)
 id 32993a23-baf2-4749-8fc3-a15c25f65271; Tue, 6 May 2025 19:18:30 +0000 (UTC)
X-Farcaster-Flow-ID: 32993a23-baf2-4749-8fc3-a15c25f65271
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 6 May 2025 19:18:29 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 6 May 2025 19:18:25 +0000
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
Date: Tue, 6 May 2025 12:18:12 -0700
Message-ID: <20250506191817.14620-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506-zugabe-bezog-f688fbec72d3@brauner>
References: <20250506-zugabe-bezog-f688fbec72d3@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Christian Brauner <brauner@kernel.org>
Date: Tue, 6 May 2025 10:06:27 +0200
> On Mon, May 05, 2025 at 09:10:28PM +0200, Jann Horn wrote:
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
> > 
> > My understanding is that BPF LSM creates fairly tight coupling between
> > userspace and the kernel implementation, and it is kind of unwieldy
> > for userspace. (I imagine the "man 5 core" manpage would get a bit
> > longer and describe more kernel implementation detail if you tried to
> > show how to write a BPF LSM that is capable of detecting unix domain
> > socket connections to a specific address that are not initiated by
> > core dumping.) I would like to keep it possible to implement core
> > userspace functionality in a best-practice way without needing eBPF.
> > 
> > > It's hard to loosen such a default restriction as someone might
> > > argue that's unexpected and regression.
> > 
> > If userspace wants to allow other processes to connect to the core
> > dumping service, that's easy to implement - userspace can listen on a
> > separate address that is not subject to these restrictions.
> 
> I think Kuniyuki's point is defensible. And I did discuss this with
> Lennart when I wrote the patch and he didn't see a point in preventing
> other processes from connecting to the core dump socket. He actually
> would like this to be possible because there's some userspace programs
> out there that generate their own coredumps (Python?) and he wanted them
> to use the general coredump socket to send them to.
> 
> I just found it more elegant to simply guarantee that only connections
> are made to that socket come from coredumping tasks.
> 
> But I should note there are two ways to cleanly handle this in
> userspace. I had already mentioned the bpf LSM in the contect of
> rate-limiting in an earlier posting:
> 
> (1) complex:
> 
>     Use a bpf LSM to intercept the connection request via
>     security_unix_stream_connect() in unix_stream_connect().
> 
>     The bpf program can simply check:
> 
>     current->signal->core_state
> 
>     and reject any connection if it isn't set to NULL.
> 
>     The big downside is that bpf (and security) need to be enabled.
>     Neither is guaranteed and there's quite a few users out there that
>     don't enable bpf.
> 
> (2) simple (and supported in this series):
> 
>     Userspace accepts a connection. It has to get SO_PEERPIDFD anyway.
>     It then needs to verify:
> 
>     struct pidfd_info info = {
>             info.mask = PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP,
>     };
> 
>     ioctl(pidfd, PIDFD_GET_INFO, &info);
>     if (!(info.mask & PIDFD_INFO_COREDUMP)) {
>             // Can't be from a coredumping task so we can close the
> 	    // connection without reading.
> 	    close(coredump_client_fd);
> 	    return;
>     }
> 
>     /* This has to be set and is only settable by do_coredump(). */
>     if (!(info.coredump_mask & PIDFD_COREDUMPED)) {
>             // Can't be from a coredumping task so we can close the
> 	    // connection without reading.
> 	    close(coredump_client_fd);
> 	    return;
>     }
> 
>     // Ok, this is a connection from a task that has coredumped, let's
>     // handle it.
> 
>     The crux is that the series guarantees that by the time the
>     connection is made the info whether the task/thread-group did
>     coredump is guaranteed to be available via the pidfd.
>  
> I think if we document that most coredump servers have to do (2) then
> this is fine. But I wouldn't mind a nod from Jann on this.

I like this approach (2) allowing users to filter the right client.
This way we can extend the application flexibly for another coredump
service.

