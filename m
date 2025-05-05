Return-Path: <linux-fsdevel+bounces-48129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E660AA9D31
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 22:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E41C01A8058E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 20:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F417026E146;
	Mon,  5 May 2025 20:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="K1QYsB5h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC1C26AEC;
	Mon,  5 May 2025 20:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746477063; cv=none; b=EK4oBTiQ7F0ss57VdLiO1/Ueo1PDtf7Uxgz23Mp8ljx8T25yK9q/slXWpwoSN3t5AKK7lNV/sret7BnuFoUN/NgzdtN9yoXbPqf2AHuRqvXEvHrfb46dnlF7bR+tnenEIlqkFEBDbtt8WpmOyJp9gvItZ2vtHCuN8Xqy4TnoVbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746477063; c=relaxed/simple;
	bh=hpXawiMCbFNMtLwupeoUmf2Xm0mnA5xTmSvR13MfLeM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tbq5WC3fIuguT72K86m7qp6gmGAbsQOPWxEOd7V7FgWwQC4JJ9Qp5DKHxrUiWaJ3yWC4Ayj5khKPCOYdJUsyni/gZz/xCV4etQJhWj8qo2tdiGei9tmx7YnVlgH3O8Z0cCTEuxPg7nlPPAYLtSpWMWfGVqd6lcd2As6y8abpaQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=K1QYsB5h; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1746477061; x=1778013061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y2iuPuGSDdUuGQ1kMEtvZ4TsfeO77AdopcHWmkz8TV0=;
  b=K1QYsB5hJIQJlv1+NPyDADW6TwBvnvirYXuxCTHPla7/6sQ+fjM/MQY2
   XNv9U0/vn9PsyGcXd2fiKxaohaaaZJ/aW7lNWnTQ8fRuvwjA4ySoh2BOn
   HD2OLLUUkN1WoZ0IzFtHdRwqqDXNFz7T1JxJlTcQVWnfyEMd3GnM7qPCs
   c=;
X-IronPort-AV: E=Sophos;i="6.15,264,1739836800"; 
   d="scan'208";a="90207148"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 20:30:57 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:21986]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.92:2525] with esmtp (Farcaster)
 id cc2fda14-57a4-4f3b-8957-2c51c2f77658; Mon, 5 May 2025 20:30:56 +0000 (UTC)
X-Farcaster-Flow-ID: cc2fda14-57a4-4f3b-8957-2c51c2f77658
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 5 May 2025 20:30:56 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 5 May 2025 20:30:52 +0000
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
Date: Mon, 5 May 2025 13:30:42 -0700
Message-ID: <20250505203044.27771-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CAG48ez1TePJ87PKNt_xFTSKs=N4z06d1mG9iUA7M9pgvbXPPMw@mail.gmail.com>
References: <CAG48ez1TePJ87PKNt_xFTSKs=N4z06d1mG9iUA7M9pgvbXPPMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D039UWA003.ant.amazon.com (10.13.139.49) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jann Horn <jannh@google.com>
Date: Mon, 5 May 2025 21:55:04 +0200
> On Mon, May 5, 2025 at 9:38 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> > From: Jann Horn <jannh@google.com>
> > Date: Mon, 5 May 2025 21:10:28 +0200
> > > On Mon, May 5, 2025 at 8:41 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> > > > From: Christian Brauner <brauner@kernel.org>
> > > > Date: Mon, 5 May 2025 16:06:40 +0200
> > > > > On Mon, May 05, 2025 at 03:08:07PM +0200, Jann Horn wrote:
> > > > > > On Mon, May 5, 2025 at 1:14 PM Christian Brauner <brauner@kernel.org> wrote:
> > > > > > > Make sure that only tasks that actually coredumped may connect to the
> > > > > > > coredump socket. This restriction may be loosened later in case
> > > > > > > userspace processes would like to use it to generate their own
> > > > > > > coredumps. Though it'd be wiser if userspace just exposed a separate
> > > > > > > socket for that.
> > > > > >
> > > > > > This implementation kinda feels a bit fragile to me... I wonder if we
> > > > > > could instead have a flag inside the af_unix client socket that says
> > > > > > "this is a special client socket for coredumping".
> > > > >
> > > > > Should be easily doable with a sock_flag().
> > > >
> > > > This restriction should be applied by BPF LSM.
> > >
> > > I think we shouldn't allow random userspace processes to connect to
> > > the core dump handling service and provide bogus inputs; that
> > > unnecessarily increases the risk that a crafted coredump can be used
> > > to exploit a bug in the service. So I think it makes sense to enforce
> > > this restriction in the kernel.
> >
> > It's already restricted by /proc/sys/kernel/core_pattern.
> > We don't need a duplicated logic.
> 
> The core_pattern does not restrict which processes can call connect()
> on the unix domain socket address.

I misread it so added LSM can filter the source as well.


> 
> > Even when the process holding the listener dies, you can
> > still avoid such a leak.
> >
> > e.g.
> >
> > 1. Set up a listener
> > 2. Put the socket into a bpf map
> > 3. Attach LSM at connect()
> >
> > Then, the LSM checks if the destination socket is
> 
> Where does the LSM get the destination socket pointer from? The
> socket_connect LSM hook happens before the point where the destination
> socket is looked up. What you have in that hook is the unix socket
> address structure.

The hook is invoked after the lookup.
"sk" is the source and "other" is the destination.

        err = security_unix_stream_connect(sk, other, newsk);
        if (err) {
                unix_state_unlock(sk);
                goto out_unlock;
        }


> 
> >   * listening on the name specified in /proc/sys/kernel/core_pattern
> >   * exists in the associated BPF map
> >
> > So, if the socket is dies and a malicious user tries to hijack
> > the core_pattern name, LSM still rejects such connect().
> 
> This patch is not about a malicious user binding to the core dumping
> service's unix domain socket address, that is blocked in "[PATCH RFC
> v3 03/10] net: reserve prefix". This patch is about preventing
> userspace from connect()ing to the legitimate listening socket.

I mean both can be better handled by BPF.


> 
> > Later, the admin can restart the program with different core_pattern.
> >
> >
> > >
> > > My understanding is that BPF LSM creates fairly tight coupling between
> > > userspace and the kernel implementation, and it is kind of unwieldy
> > > for userspace. (I imagine the "man 5 core" manpage would get a bit
> > > longer and describe more kernel implementation detail if you tried to
> > > show how to write a BPF LSM that is capable of detecting unix domain
> > > socket connections to a specific address that are not initiated by
> > > core dumping.) I would like to keep it possible to implement core
> > > userspace functionality in a best-practice way without needing eBPF.
> >
> > I think the untrusted user scenario is paranoia in most cases,
> > and the man page just says "if you really care, use BPF LSM".
> 
> Are you saying that you expect crash dumping services to be written
> with the expectation that the system will not have multiple users or
> multiple security contexts?

Do you mean other program could use different LSM ?

I think different LSMs can co-exist, see call_int_hook().

I remember BPF LSM was not stackable at some point, but not sure
if it's still true.

I expect the service to use necessary functionality if it's
needed for the specific use case.

Not everyone need such restriction, and it's optional.  Why not
allowing those who really need it to implement it.


> 
> > If someone can listen on a name AND set it to core_pattern, most
> > likely something worse already happened.

