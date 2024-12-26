Return-Path: <linux-fsdevel+bounces-38143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 933509FCD88
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2024 21:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A1A1163215
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2024 20:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD7D1547EE;
	Thu, 26 Dec 2024 20:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M1hkP4AX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D751494AD
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Dec 2024 20:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735244001; cv=none; b=oZIXeohwIe/cXzQlW1YFW0dwxaAuX3zbLTLVp04RFQzPLzQzI00uUTb7jRvgRJoKALiHQqzn1TnkYvh5pake6LFpuitI4ilScwaUMGxKkbB4Y677ilDwS7Z9uqsu2BtIBz6DFJ+aWG0Ob1bK39swFmDsYna7U5qbXxO9oIXAUrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735244001; c=relaxed/simple;
	bh=uVHFeVirO7v4fTurSoN+OQIUm+ahYtt/A4og76AlDnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhWzYvcAcshgrWZhRNvLxLHX8wboS+MtowfZvdTluXhJ8bNAtCt8+jw91aeUhtZcI+nUEJSXUV9AfiG8k80TDPuDC1+snr9BpTrzcYHCbBWpPr79VcELxsz29N7MJVmbD7OOC+O3oNdopSmnd46OSS3CGehaFDMqCW08X04z2qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M1hkP4AX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735243997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6mcFSpoSVopEooBntoQ0f8AJTh5ILCU7pXkgD7DiSpc=;
	b=M1hkP4AXazNsLl7KX8TLsa5sGhRoWJ/LQO0UpJ7+mmhtdOEA5EQcpeIWfK1xOW/cL1XrWg
	P8QfMxZS4fMXVZwa3q4Db8N+F9wDBvV34mgo8BFeucsy4D44at8pmumxNWPPYxY/+jz+Kr
	65acfsLC1jx+4XMnuVdiEWTYTRxLL/o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-nHouNs0TNO2Eh8SMu6PJDQ-1; Thu,
 26 Dec 2024 15:13:16 -0500
X-MC-Unique: nHouNs0TNO2Eh8SMu6PJDQ-1
X-Mimecast-MFC-AGG-ID: nHouNs0TNO2Eh8SMu6PJDQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 824B719560AA;
	Thu, 26 Dec 2024 20:13:07 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.44])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 7074719560A3;
	Thu, 26 Dec 2024 20:12:23 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 26 Dec 2024 21:12:42 +0100 (CET)
Date: Thu, 26 Dec 2024 21:11:58 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: WangYuli <wangyuli@uniontech.com>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, yushengjin@uniontech.com,
	zhangdandan@uniontech.com, guanwentao@uniontech.com,
	zhanjun@uniontech.com, oliver.sang@intel.com, ebiederm@xmission.com,
	colin.king@canonical.com, josh@joshtriplett.org,
	penberg@cs.helsinki.fi, manfred@colorfullife.com, mingo@elte.hu,
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
	gorcunov@openvz.org, levinsasha928@gmail.com, penberg@kernel.org,
	amwang@redhat.com, bcrl@kvack.org, muthu.lkml@gmail.com,
	muthur@gmail.com, mjt@tls.msk.ru, alan@lxorguk.ukuu.org.uk,
	raven@themaw.net, thomas@m3y3r.de, will.deacon@arm.com,
	will@kernel.org, josef@redhat.com, anatol.pomozov@gmail.com,
	koverstreet@google.com, zab@redhat.com, balbi@ti.com,
	gregkh@linuxfoundation.org, mfasheh@suse.com, jlbec@evilplan.org,
	rusty@rustcorp.com.au, asamymuthupa@micron.com, smani@micron.com,
	sbradshaw@micron.com, jmoyer@redhat.com, sim@hostway.ca,
	ia@cloudflare.com, dmonakhov@openvz.org, ebiggers3@gmail.com,
	socketpair@gmail.com, penguin-kernel@i-love.sakura.ne.jp, w@1wt.eu,
	kirill.shutemov@linux.intel.com, mhocko@suse.com,
	vdavydov.dev@gmail.com, vdavydov@virtuozzo.com, hannes@cmpxchg.org,
	mhocko@kernel.org, minchan@kernel.org, deepa.kernel@gmail.com,
	arnd@arndb.de, balbi@kernel.org, swhiteho@redhat.com,
	konishi.ryusuke@lab.ntt.co.jp, dsterba@suse.com,
	vegard.nossum@oracle.com, axboe@fb.com, pombredanne@nexb.com,
	tglx@linutronix.de, joe.lawrence@redhat.com, mpatocka@redhat.com,
	mcgrof@kernel.org, keescook@chromium.org,
	linux@dominikbrodowski.net, jannh@google.com, shakeelb@google.com,
	guro@fb.com, willy@infradead.org, khlebnikov@yandex-team.ru,
	kirr@nexedi.com, stern@rowland.harvard.edu, elver@google.com,
	parri.andrea@gmail.com, paulmck@kernel.org, rasibley@redhat.com,
	jstancek@redhat.com, avagin@gmail.com, cai@redhat.com,
	josef@toxicpanda.com, hare@suse.de, colyli@suse.de,
	johannes@sipsolutions.net, sspatil@android.com, alex_y_xu@yahoo.ca,
	mgorman@techsingularity.net, gor@linux.ibm.com, jhubbard@nvidia.com,
	andriy.shevchenko@linux.intel.com, crope@iki.fi, yzaikin@google.com,
	bfields@fieldses.org, jlayton@kernel.org, kernel@tuxforce.de,
	steve@sk2.org, nixiaoming@huawei.com, 0x7f454c46@gmail.com,
	kuniyu@amazon.co.jp, alexander.h.duyck@intel.com,
	kuni1840@gmail.com, soheil@google.com, sridhar.samudrala@intel.com,
	Vincenzo.Frascino@arm.com, chuck.lever@oracle.com,
	Kevin.Brodsky@arm.com, Szabolcs.Nagy@arm.com,
	David.Laight@aculab.com, Mark.Rutland@arm.com,
	linux-morello@op-lists.linaro.org, Luca.Vizzarro@arm.com,
	max.kellermann@ionos.com, adobriyan@gmail.com, lukas@schauer.dev,
	j.granados@samsung.com, djwong@kernel.org,
	kent.overstreet@linux.dev, linux@weissschuh.net,
	kstewart@efficios.com
Subject: Re: [RESEND PATCH] fs/pipe: Introduce a check to skip sleeping
 processes during pipe read/write
Message-ID: <20241226201158.GB11118@redhat.com>
References: <75B06EE0B67747ED+20241225094202.597305-1-wangyuli@uniontech.com>
 <CAHk-=wj5A-fO+GnfwqGpXhFbfpS4+_8xU+dnXkSx+0AfwBYrxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj5A-fO+GnfwqGpXhFbfpS4+_8xU+dnXkSx+0AfwBYrxA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

I mostly agree, see my reply to this patch, but...

On 12/26, Linus Torvalds wrote:
>
> If the optimization is correct, there is no point to having a config option.
>
> If the optimization is incorrect, there is no point to having the code.
>
> Either way, there's no way we'd ever have a config option for this.

Agreed,

> > +       if (was_full && pipe_check_wq_has_sleeper(&pipe->wr_wait))
> >                 wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);
>
> End result: you need to explain why the race cannot exist.

Agreed,

> And I think your patch is simply buggy

Agreed again, but probably my reasoning was wrong,

> But now waiters use "wait_event_interruptible_exclusive()" explicitly
> outside the pipe mutex, so the waiters and wakers aren't actually
> serialized.

This is what I don't understand... Could you spell ?

I _think_ that

	wait_event_whatever(WQ, CONDITION);

vs

	CONDITION = 1;
	if (wq_has_sleeper(WQ))
		wake_up_xxx(WQ, ...);
	
is fine.

Both wq_has_sleeper() and wait_event_whatever()->prepare_to_wait_event()
have the necessary barriers to serialize the waiters and wakers.

Damn I am sure I missed something ;)

> And no, you are unlikely to see the races in practice (particularly
> the memory ordering ones). So you have to *think* about them, not test
> them.

Yes! agreed again.

Oleg.


