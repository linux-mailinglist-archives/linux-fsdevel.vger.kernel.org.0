Return-Path: <linux-fsdevel+bounces-24740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 894D3944610
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 10:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31DEE1F236B4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 08:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D3A16C87B;
	Thu,  1 Aug 2024 08:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iyXs3lqD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EEA14F9FA
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Aug 2024 08:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722499294; cv=none; b=gEfjySQGcr7xQIm9VhHrVltgiCAoxNaMURItkYSnkWuCW5AQJS60+LS8bdaJ0cnTuCIDZW3epnbcqeNqqrpDXJyZsvc3nvzGZh27ZFTjOUtbT3FVC6ZMew3TL+GEdgAXG7MNg52Z5MZ4t4PLXFUpyWKhNxZgXDEnNDmegJG1yv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722499294; c=relaxed/simple;
	bh=Bgzl+Yau9ChklaOFiE/zntI5cfQezV0JW3SA8Iu4Dgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGyOaqTyBcCjxoeLZlMDNtRKpvbC69Nn8jKkP4+HnAV6X9LkBSMwKOuNL+ylLlS2ihcrLT2f4RaGvrc0eyKh1cdZ/qqBSsbEjJBJkH7WZ0T7cspU8VzXTMtKa58ARhds+LzcNAr+OyBsACMCPnEH8CLR6OpqAnnE9Pr7E7AsKew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iyXs3lqD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722499292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BJT8BerayjO+edRHg4OqqoNW2Fn4Tnno7cm6u5lzb9Y=;
	b=iyXs3lqDQgd4+rBeaws0C9jBnfp7RoEqQUPNOOOlOO+b3Cint5nzdRPoQCf6PCvicSONTC
	SorbD2Qu1mziSVM0F/y8HgZUZ1kwHFkMTUO4j32ItgRBulQ9/isOTyqnni9rWCN7SwVXg4
	aQ/K4ATmbU930l3OXVbKIMRcOGJo3AI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-v1C6Tkq4Nv23s0EwXchEeg-1; Thu,
 01 Aug 2024 04:01:26 -0400
X-MC-Unique: v1C6Tkq4Nv23s0EwXchEeg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AFF331955F45;
	Thu,  1 Aug 2024 08:01:24 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.183])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id CB2D51955D42;
	Thu,  1 Aug 2024 08:01:21 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  1 Aug 2024 10:01:24 +0200 (CEST)
Date: Thu, 1 Aug 2024 10:01:20 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Aleksa Sarai <cyphar@cyphar.com>,
	Tycho Andersen <tandersen@netflix.com>,
	Daan De Meyer <daan.j.demeyer@gmail.com>, Tejun Heo <tj@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] pidfd: prevent creation of pidfds for kthreads
Message-ID: <20240801080120.GA4038@redhat.com>
References: <20240731-gleis-mehreinnahmen-6bbadd128383@brauner>
 <20240731145132.GC16718@redhat.com>
 <20240801-report-strukturiert-48470c1ac4e8@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801-report-strukturiert-48470c1ac4e8@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

OK, I won't argue, but ....

On 08/01, Christian Brauner wrote:
>
> On Wed, Jul 31, 2024 at 04:51:33PM GMT, Oleg Nesterov wrote:
> > On 07/31, Christian Brauner wrote:
> > >
> > > It's currently possible to create pidfds for kthreads but it is unclear
> > > what that is supposed to mean. Until we have use-cases for it and we
> > > figured out what behavior we want block the creation of pidfds for
> > > kthreads.
> >
> > Hmm... could you explain your concerns? Why do you think we should disallow
> > pidfd_open(pid-of-kthread) ?
>
> It basically just works now and it's not intentional - at least not on
> my part. You can't send signals to them,

Yes, you can't send signals to kthread. So what?

You can't send signals to the normal processes if check_kill_permission()
fails. And even if you are root, you can't send an unhandled signal via
pidfd = pidfd_open(1).

> you may or may not get notified
> via poll when a kthread exits.

Why? the exiting kthread should not differ in this respect?

> (So imho this causes more confusion then it is actually helpful. If we
> add supports for kthreads I'd also like pidfs to gain a way to identify
> them via statx() or fdinfo.)

/proc/$pid/status has a "Kthread" field...

> > > @@ -2403,6 +2416,12 @@ __latent_entropy struct task_struct *copy_process(
> > >  	if (clone_flags & CLONE_PIDFD) {
> > >  		int flags = (clone_flags & CLONE_THREAD) ? PIDFD_THREAD : 0;
> > >
> > > +		/* Don't create pidfds for kernel threads for now. */
> > > +		if (args->kthread) {
> > > +			retval = -EINVAL;
> > > +			goto bad_fork_free_pid;
> >
> > Do we really need this check? Userspace can't use args->kthread != NULL,
> > the kernel users should not use CLONE_PIDFD.
>
> Yeah, I know. That's really just proactive so that user of e.g.,
> copy_process() such as vhost or so on don't start handing out pidfds for
> stuff without requring changes to the helper itself.

Then I'd suggest WARN_ON_ONCE(args->kthread).

But as I said I won't argue. I see nothing wrong in this patch.

Oleg.


