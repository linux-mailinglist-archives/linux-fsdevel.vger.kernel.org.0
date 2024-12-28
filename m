Return-Path: <linux-fsdevel+bounces-38199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A7F9FDB80
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2024 16:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46B9C3A1454
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2024 15:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BA518B46C;
	Sat, 28 Dec 2024 15:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ezIw5xAT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74606155756
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Dec 2024 15:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735399436; cv=none; b=VRq2dn43ovgfCrtK4o/5ndsw0IxtaQT9BmSU51jrcQrZ2pFId3l1YgYS7BAWvt4ZWAiBjHCqLw0b2NbYwLUXeBnsME9AwVvr71vMHPdm6MkZigkxbGVFgINqDJGzdB/h6i0lLbo/4c3rkg0J5FTqjaFjP+X1O6AwcGxqvzhaGkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735399436; c=relaxed/simple;
	bh=nNOPcypbOzfFoodbrHPXMebriJRIgNx6X2R+SehGl1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4naMo8Rhfb8zdPrAtW7nZkFWeUyWhQVj33piTjjLmsmgqN5qC8ef3gwJSiVycBhSff5kkQcSk+i1MwvLwQhzD4Fk1qFtMyRiSB0VB3jwgTWHIgsRHoor4ZAtI+nOj5s8pidIsjODJfcbV+HKX/IuQQcxyaSY8dwChZFaVYU0dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ezIw5xAT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735399433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sYqOueoe1exEDVDAtM1S6cZlf7MIxfxS+48IPQs/hFE=;
	b=ezIw5xATMLWDvHEQ+be+KOysQI2rWfD5OLaXtzWzHsQhOueyMpv89b2aedULCTv8OCpZBh
	iChyrP8VuqLyGGe6HgSJoHtOICkgAhwKNkWfX1qQlDpr87GO+mOAMdAPGr3tfW4ryZ2J0d
	ydv8PP/HiNxli9McOZrKZ8/2T74srfY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-UPvp96kSN8mwEQGiMXceUQ-1; Sat,
 28 Dec 2024 10:23:51 -0500
X-MC-Unique: UPvp96kSN8mwEQGiMXceUQ-1
X-Mimecast-MFC-AGG-ID: UPvp96kSN8mwEQGiMXceUQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A7E7F19560A2;
	Sat, 28 Dec 2024 15:23:43 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.13])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 9E1E219560A3;
	Sat, 28 Dec 2024 15:22:56 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 28 Dec 2024 16:23:18 +0100 (CET)
Date: Sat, 28 Dec 2024 16:22:30 +0100
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
Message-ID: <20241228152229.GC5302@redhat.com>
References: <75B06EE0B67747ED+20241225094202.597305-1-wangyuli@uniontech.com>
 <CAHk-=wj5A-fO+GnfwqGpXhFbfpS4+_8xU+dnXkSx+0AfwBYrxA@mail.gmail.com>
 <20241226201158.GB11118@redhat.com>
 <1df49d97-df0e-4471-9e40-a850b758d981@colorfullife.com>
 <20241228143248.GB5302@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241228143248.GB5302@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 12/28, Oleg Nesterov wrote:
>
> >  int __wake_up(struct wait_queue_head *wq_head, unsigned int mode,
> >  	      int nr_exclusive, void *key)
> >  {
> > +	if (list_empty(&wq_head->head)) {
> > +		struct list_head *pn;
> > +
> > +		/*
> > +		 * pairs with spin_unlock_irqrestore(&wq_head->lock);
> > +		 * We actually do not need to acquire wq_head->lock, we just
> > +		 * need to be sure that there is no prepare_to_wait() that
> > +		 * completed on any CPU before __wake_up was called.
> > +		 * Thus instead of load_acquiring the spinlock and dropping
> > +		 * it again, we load_acquire the next list entry and check
> > +		 * that the list is not empty.
> > +		 */
> > +		pn = smp_load_acquire(&wq_head->head.next);
> > +
> > +		if(pn == &wq_head->head)
> > +			return 0;
> > +	}
>
> Too subtle for me ;)
>
> I have some concerns, but I need to think a bit more to (try to) actually
> understand this change.

If nothing else, consider

	int CONDITION;
	wait_queue_head_t WQ;

	void wake(void)
	{
		CONDITION = 1;
		wake_up(WQ);
	}

	void wait(void)
	{
		DEFINE_WAIT_FUNC(entry, woken_wake_function);

		add_wait_queue(WQ, entry);
		if (!CONDITION)
			wait_woken(entry, ...);
		remove_wait_queue(WQ, entry);
	}

this code is correct even if LOAD(CONDITION) can leak into the critical
section in add_wait_queue(), so CPU running wait() can actually do

		// add_wait_queue
		spin_lock(WQ->lock);
		LOAD(CONDITION);	// false!
		list_add(entry, head);
		spin_unlock(WQ->lock);

		if (!false)		// result of the LOAD above
			wait_woken(entry, ...);

Now suppose that another CPU executes wake() between LOAD(CONDITION)
and list_add(entry, head). With your patch wait() will miss the event.
The same for __pollwait(), I think...

No?

Oleg.


