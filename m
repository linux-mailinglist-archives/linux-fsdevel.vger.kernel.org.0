Return-Path: <linux-fsdevel+bounces-38180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE42A9FDAF1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2024 15:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 457303A0395
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2024 14:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0966616DED2;
	Sat, 28 Dec 2024 14:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fK3jPx6f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88234156C74
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Dec 2024 14:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735396455; cv=none; b=EW+ekB1QsA1Rwl+qqT6YvpwZ5u+jKIYIOh0zXJU9XZJXwK7LCxezzEuxCaUt8ODEdohMqsAE+A0nYHNTD9+2m0QJbRKLvCBWT6VEiouc28fogbwy8NOYnOhQWygL8fY12ylcmv78sU72dFDOtgyag+KzChKuzeR3vIILDuUQTww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735396455; c=relaxed/simple;
	bh=fIcYTcR448Ex3EGCPk44O7csmeTF6dRZNufGCDF/GoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ug7CnVzJKefAQ8jZ8uYw8xYOvRTWT16AuYwlmOJ7aCA1YHA6dxUhg5mgh/KqFZ/BPz/4J/fTNQw+HI7fpKxlvqmTmnAXCmhWGdGsmHyXPiOyiAqX6aIFe1mbykai0lhaOH00KZjwN+AA4zI0iupbwVDZoPRSaKfSXgZ2ExK7yQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fK3jPx6f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735396452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3wYfDZBGBizXsABpOPa1MdymfniA3R8gInZpxfq0oLA=;
	b=fK3jPx6fqx/lo8Q2hgxR0QYBAeBLy0yEWKlGN6Oofy/0hh953nL6whCnJlo1E/ZDF/BpJH
	suKX1XVFaqnNS+zvyfXZ9YK0VoxIIUTlLqvF4y7NqjACc/c9BEHjo5jRP0YHy4x018w2hE
	gMDIEJEtrlUODCdCkanRglWaYoHu3tw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-NGz7Bx_WMiiMhWU25n3kPA-1; Sat,
 28 Dec 2024 09:34:08 -0500
X-MC-Unique: NGz7Bx_WMiiMhWU25n3kPA-1
X-Mimecast-MFC-AGG-ID: NGz7Bx_WMiiMhWU25n3kPA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 95BCB1956086;
	Sat, 28 Dec 2024 14:34:01 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.13])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id AFEC5195605A;
	Sat, 28 Dec 2024 14:33:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 28 Dec 2024 15:33:36 +0100 (CET)
Date: Sat, 28 Dec 2024 15:32:49 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, oliver.sang@intel.com,
	ebiederm@xmission.com, colin.king@canonical.com,
	josh@joshtriplett.org, penberg@cs.helsinki.fi, mingo@elte.hu,
	jes@sgi.com, hch@lst.de, aia21@cantab.net, arjan@infradead.org,
	jgarzik@pobox.com, neukum@fachschaft.cup.uni-muenchen.de,
	oliver@neukum.name, dada1@cosmosbay.com, axboe@kernel.dk,
	axboe@suse.de, nickpiggin@yahoo.com.au, dhowells@redhat.com,
	nathans@sgi.com, rolandd@cisco.com, tytso@mit.edu, bunk@stusta.de,
	pbadari@us.ibm.com, ak@linux.intel.com, ak@suse.de,
	davem@davemloft.net, jsipek@cs.sunysb.edu, jens.axboe@oracle.com,
	ramsdell@mitre.org, hch@infradead.org, akpm@linux-foundation.org,
	randy.dunlap@oracle.com, efault@gmx.de, rdunlap@infradead.org,
	haveblue@us.ibm.com, drepper@redhat.com, dm.n9107@gmail.com,
	jblunck@suse.de, davidel@xmailserver.org,
	mtk.manpages@googlemail.com, linux-arch@vger.kernel.org,
	vda.linux@googlemail.com, jmorris@namei.org, serue@us.ibm.com,
	hca@linux.ibm.com, rth@twiddle.net, lethal@linux-sh.org,
	tony.luck@intel.com, heiko.carstens@de.ibm.com, andi@firstfloor.org,
	corbet@lwn.net, crquan@gmail.com, mszeredi@suse.cz,
	miklos@szeredi.hu, peterz@infradead.org, a.p.zijlstra@chello.nl,
	earl_chew@agilent.com, npiggin@gmail.com, npiggin@suse.de,
	julia@diku.dk, jaxboe@fusionio.com, nikai@nikai.net,
	dchinner@redhat.com, davej@redhat.com, npiggin@kernel.dk,
	eric.dumazet@gmail.com, tim.c.chen@linux.intel.com,
	xemul@parallels.com, tj@kernel.org, serge.hallyn@canonical.com,
	gorcunov@openvz.org, bcrl@kvack.org, alan@lxorguk.ukuu.org.uk,
	will.deacon@arm.com, will@kernel.org, zab@redhat.com, balbi@ti.com,
	gregkh@linuxfoundation.org, rusty@rustcorp.com.au,
	socketpair@gmail.com, penguin-kernel@i-love.sakura.ne.jp,
	mhocko@kernel.org, axboe@fb.com, tglx@linutronix.de,
	mcgrof@kernel.org, linux@dominikbrodowski.net, willy@infradead.org,
	paulmck@kernel.org, kernel@tuxforce.de,
	linux-morello@op-lists.linaro.org
Subject: Re: [RESEND PATCH] fs/pipe: Introduce a check to skip sleeping
 processes during pipe read/write
Message-ID: <20241228143248.GB5302@redhat.com>
References: <75B06EE0B67747ED+20241225094202.597305-1-wangyuli@uniontech.com>
 <CAHk-=wj5A-fO+GnfwqGpXhFbfpS4+_8xU+dnXkSx+0AfwBYrxA@mail.gmail.com>
 <20241226201158.GB11118@redhat.com>
 <1df49d97-df0e-4471-9e40-a850b758d981@colorfullife.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1df49d97-df0e-4471-9e40-a850b758d981@colorfullife.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 12/27, Manfred Spraul wrote:
>
> >I _think_ that
> >
> >	wait_event_whatever(WQ, CONDITION);
> >vs
> >
> >	CONDITION = 1;
> >	if (wq_has_sleeper(WQ))
> >		wake_up_xxx(WQ, ...);
> >
> >is fine.
>
> This pattern is documented in wait.h:
>
> https://elixir.bootlin.com/linux/v6.12.6/source/include/linux/wait.h#L96
>
> Thus if there an issue, then the documentation should be updated.

Agreed, basically the same pattern, prepare_to_wait_event() is similar
to prepare_to_wait().

> But I do not understand this comment (from 2.6.0)
>
> https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/kernel/fork.c?h=v2.6.0&id=e220fdf7a39b54a758f4102bdd9d0d5706aa32a7
>
> >/* * Note: we use "set_current_state()" _after_ the wait-queue add, *
> >because we need a memory barrier there on SMP, so that any * wake-function
> >that tests for the wait-queue being active * will be guaranteed to see
> >waitqueue addition _or_ subsequent * tests in this thread will see the
> >wakeup having taken place. * * The spin_unlock() itself is semi-permeable
> >and only protects * one way (it only protects stuff inside the critical
> >region and * stops them from bleeding out - it would still allow
> >subsequent * loads to move into the the critical region). */
...
> set_current_state() now uses smp_store_mb(), which is a memory barrier
> _after_ the store.

And afaics this is what we actually need.

> Thus I do not see what enforces that the store happens
> before the store for the __add_wait_queue().

IIUC this is fine, no need to serialize list_add() and STORE(tsk->__state),
they can be reordered.

But we need mb() between __add_wait_queue + __set_current_state (in any
order) and the subsequent "if (CONDITION)" check.

> --- a/kernel/sched/wait.c
> +++ b/kernel/sched/wait.c
> @@ -124,6 +124,23 @@ static int __wake_up_common_lock(struct wait_queue_head *wq_head, unsigned int m
>  int __wake_up(struct wait_queue_head *wq_head, unsigned int mode,
>  	      int nr_exclusive, void *key)
>  {
> +	if (list_empty(&wq_head->head)) {
> +		struct list_head *pn;
> +
> +		/*
> +		 * pairs with spin_unlock_irqrestore(&wq_head->lock);
> +		 * We actually do not need to acquire wq_head->lock, we just
> +		 * need to be sure that there is no prepare_to_wait() that
> +		 * completed on any CPU before __wake_up was called.
> +		 * Thus instead of load_acquiring the spinlock and dropping
> +		 * it again, we load_acquire the next list entry and check
> +		 * that the list is not empty.
> +		 */
> +		pn = smp_load_acquire(&wq_head->head.next);
> +
> +		if(pn == &wq_head->head)
> +			return 0;
> +	}

Too subtle for me ;)

I have some concerns, but I need to think a bit more to (try to) actually
understand this change.

Oleg.


