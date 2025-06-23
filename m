Return-Path: <linux-fsdevel+bounces-52431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 586E9AE3350
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 03:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E5B83B0449
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 01:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F642225D7;
	Mon, 23 Jun 2025 01:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G/WuNN1+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBE4134CF
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 01:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750642753; cv=none; b=fZKACm26NGDF/yhZDYochGdJh/rtpxWNt4JJGyJ9yGY27H7eDQcwdz1ykqvt6Tujiq653FV0i9cl5YKBhzm2KMHRYFmMESu19YwOAbzoZjcHs7xXPUG0zo44htX7ZqjIEoCdg6b7kOpbEg7LXXfoCM0bXtXdfELvs8PIOAIJApI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750642753; c=relaxed/simple;
	bh=mOMZmDtg7UpragCui3/1ieWMRXj97ofX5z4uaqmbxc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbdaneb56wvlETMwgWc/GWjx8adGaM8vBg1JS/DzxX6XFsDjBNzfk3kSAUG9o+i9O9nj8xqdRw+q1FhRTGaQ+V8ZUgZnQT1zeeGqakEF5SXtMrrJE62unfAoESWmx0wHVf5Qx2HNw2rWidfPx6f9rCNApwkMVQftm54V91/1MX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G/WuNN1+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750642751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yexjD/xwmxHkcuPr5ND041umEuakLm6g0ZCZufHMl+c=;
	b=G/WuNN1+BjVk7MklxkKYI1wpsghGSGio11FurHUm9kQi2pGkrJtlhBPZhdZOLaEeVP/vZm
	deCVmJB5UINkWYzjQyYZ4DPqcpxq1idqZ7OTo+O8xcpCC6LLI0YWVUlWG1HrPMW2c0sR77
	MKI74asqYIkBo3egPNoyXVGEta7aSWI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-nXpEzMJ8Ot-i-eeU0V48nQ-1; Sun,
 22 Jun 2025 21:39:09 -0400
X-MC-Unique: nXpEzMJ8Ot-i-eeU0V48nQ-1
X-Mimecast-MFC-AGG-ID: nXpEzMJ8Ot-i-eeU0V48nQ_1750642748
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2976719560AA;
	Mon, 23 Jun 2025 01:39:08 +0000 (UTC)
Received: from fedora (unknown [10.72.116.88])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F4CB180045B;
	Mon, 23 Jun 2025 01:39:04 +0000 (UTC)
Date: Mon, 23 Jun 2025 09:38:59 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, selinux@vger.kernel.org
Subject: Re: [v6.16-rc2+ Bug] panic in inode_doinit_with_dentry during booting
Message-ID: <aFiwMxE4OlcFp7Ox@fedora>
References: <CAFj5m9KOjqYmUOYM4EgDBrJ-rQxEgOhm+pokmdAE6w+bCGrhSg@mail.gmail.com>
 <CAHC9VhQ0dyqsjsNt98yiPCGsiuUXep3T7T24LWWRHy8V8xjV4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQ0dyqsjsNt98yiPCGsiuUXep3T7T24LWWRHy8V8xjV4Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Sat, Jun 21, 2025 at 02:40:41PM -0400, Paul Moore wrote:
> On Sat, Jun 21, 2025 at 2:08 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > Hello Guys,
> >
> > The latest v6.16-rc2+ kernel panics during booting, commit
> > 3f75bfff44be ("Merge tag 'mtd/fixes-for-6.16-rc3' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux"):
> >
> >
> > [  OK  ] Finished systemd-modules-load.service - Load Kernel Modules.
> >          Starting systemd-sysctl.service - Apply Kernel Variables...
> >          Starting systemd-sysusers.service - Create System Users...
> > [  OK  ] Finished systemd-sysctl.service - Apply Kernel Variables.
> > [    1.851473] Oops: general protection fault, probably for
> > non-canonical address 0x8cbad568292ed62c: 0000 [#1] SMP NOPTI
> > [    1.853362] CPU: 9 UID: 0 PID: 269 Comm: systemd-sysuser Not
> > tainted 6.16.0-rc2+ #328 PREEMPT(full)
> > [    1.854923] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> > BIOS 1.16.3-1.fc39 04/01/2014
> > [    1.856374] RIP: 0010:__list_add_valid_or_report+0x1e/0xa0
> > [    1.857366] Code: 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa
> > 53 48 83 ec 08 48 85 f6 0f 84 76 2f 76 ff 48 89 d3 48 85 d2 0f 84 5c
> > 2f9
> > [    1.860338] RSP: 0018:ffffd152c0de3a10 EFLAGS: 00010286
> > [    1.861244] RAX: ffff8aa5414d38d8 RBX: 8cbad568292ed624 RCX: 0000000000000000
> > [    1.862439] RDX: 8cbad568292ed624 RSI: ffff8aa5401f40f0 RDI: ffff8aa5414d38d8
> > [    1.863622] RBP: ffff8aa5414d38f4 R08: ffffd152c0de3a7c R09: ffffd152c0de3a20
> > [    1.864810] R10: ffff8aa5401f40c0 R11: 0000000000000007 R12: ffff8aa5414d38d8
> > [    1.864813] R13: ffff8aa5401f40c0 R14: ffff8aa5401f40f0 R15: ffff8aa5414d38d0
> > [    1.864814] FS:  00007feebef42bc0(0000) GS:ffff8aa9ed02f000(0000)
> > knlGS:0000000000000000
> > [    1.864816] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    1.864818] CR2: 00007feebfb58180 CR3: 0000000117f4d004 CR4: 0000000000770ef0
> > [    1.870018] PKRU: 55555554
> > [    1.870020] Call Trace:
> > [    1.870029]  <TASK>
> > [    1.870031]  inode_doinit_with_dentry+0x42d/0x520
> 
> Thanks for the report.  I'm assuming you didn't see this with
> v6.16-rc1, or earlier?

It isn't observed on -rc2.

> 
> Do you have any line number information you could share?  Also, based
> on the RIP in __list_add_valid_or_report(), can you confirm that this
> is either happening in an initrd/initramfs or on a system where a
> SELinux policy is not being loaded?

Looks the issue can't be reproduced any more with -rc3.



thanks,
Ming


