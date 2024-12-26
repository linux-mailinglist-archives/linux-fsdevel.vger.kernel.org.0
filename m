Return-Path: <linux-fsdevel+bounces-38139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1939FCBB8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2024 17:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 552947A05A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2024 16:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC78E136353;
	Thu, 26 Dec 2024 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kc4C2Hny"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA76EAC6
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Dec 2024 16:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735228897; cv=none; b=L52V3BVXTMayG42blL2EuU3TxFlxiCHWj2t4SCyy43ho7Oz1kNHkAT4VSkq6Vp+XOMPkpaFHldajDcPXVQcmCPkLFCzW6AuE4paDU3BKOHg7ISAm1dddo89YMKMOYHOQ5/+ixPD7GGiCEAkImNZi8ZVaxK/tK7naEbzFBNf75uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735228897; c=relaxed/simple;
	bh=gO989+ZIqLTsHQFynxxAPZnsv0y1OIoyTTxDCJTHkRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LexexJPgscbSl9rhmoaNKNQYmd/QBHiyDjlIZ3q67M95fWL9FfPVcm+xOFCjxq2vrVZtC1W06EV3RfcEevRYhGMI1pBH481u50Tt8q35uTkIUEKdndc9D5MUEoD0jrAfnTTgg2DAEVCF2ovOvM7tbOe0XJQUE2jGQkhx428TiEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kc4C2Hny; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735228894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6LfBbaZ0P6lfnPu6U7Nw6hYad8+an6Rll8cn1hwkHJM=;
	b=Kc4C2HnyZ9Ej8ZZZD34brwfUu5/jVOW1sNTkwnmMRJkxRLbkPWPMNLO3kRRJEdxOzwQ71+
	KauGxEL4ioa98YsM3RZmHQaYeKoEfL7QdCEwi+2gse3TWe3mIGAYQn1vhQnuzMJDgp7CRa
	Z+qHErH82WYo2Wr3At4/x1IsEg3gKS8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-BMfGBTSONF63wlqxTDGSbQ-1; Thu,
 26 Dec 2024 11:01:29 -0500
X-MC-Unique: BMfGBTSONF63wlqxTDGSbQ-1
X-Mimecast-MFC-AGG-ID: BMfGBTSONF63wlqxTDGSbQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 926C219560A3;
	Thu, 26 Dec 2024 16:01:20 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.44])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4AEB319560AA;
	Thu, 26 Dec 2024 16:00:32 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 26 Dec 2024 17:00:56 +0100 (CET)
Date: Thu, 26 Dec 2024 17:00:07 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: WangYuli <wangyuli@uniontech.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	yushengjin@uniontech.com, zhangdandan@uniontech.com,
	guanwentao@uniontech.com, zhanjun@uniontech.com,
	oliver.sang@intel.com, ebiederm@xmission.com,
	colin.king@canonical.com, josh@joshtriplett.org,
	penberg@cs.helsinki.fi, manfred@colorfullife.com, mingo@elte.hu,
	jes@sgi.com, hch@lst.de, aia21@cantab.net, arjan@infradead.org,
	jgarzik@pobox.com, neukum@fachschaft.cup.uni-muenchen.de,
	oliver@neukum.name, dada1@cosmosbay.com, axboe@kernel.dk,
	axboe@suse.de, nickpiggin@yahoo.com.au, dhowells@redhat.com,
	nathans@sgi.com, rolandd@cisco.com, tytso@mit.edu, bunk@stusta.de,
	pbadari@us.ibm.com, ak@linux.intel.com, ak@suse.de,
	davem@davemloft.net, jsipek@cs.sunysb.edu, jens.axboe@oracle.com,
	ramsdell@mitre.org, hch@infradead.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
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
	socketpair@gmail.com, penguin-kernel@I-love.SAKURA.ne.jp, w@1wt.eu,
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
	David.Laight@ACULAB.com, Mark.Rutland@arm.com,
	linux-morello@op-lists.linaro.org, Luca.Vizzarro@arm.com,
	max.kellermann@ionos.com, adobriyan@gmail.com, lukas@schauer.dev,
	j.granados@samsung.com, djwong@kernel.org,
	kent.overstreet@linux.dev, linux@weissschuh.net,
	kstewart@efficios.com
Subject: Re: [RESEND PATCH] fs/pipe: Introduce a check to skip sleeping
 processes during pipe read/write
Message-ID: <20241226160007.GA11118@redhat.com>
References: <75B06EE0B67747ED+20241225094202.597305-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75B06EE0B67747ED+20241225094202.597305-1-wangyuli@uniontech.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Quite possibly I missed something, but I have some concerns after
a quick glance...

On 12/25, WangYuli wrote:
>
> +config PIPE_SKIP_SLEEPER
> +	bool "Skip sleeping processes during pipe read/write"
> +	default n
> +	help
> +	  This option introduces a check whether the sleep queue will
> +	  be awakened during pipe read/write.
> +
> +	  It often leads to a performance improvement. However, in
> +	  low-load or single-task scenarios, it may introduce minor
> +	  performance overhead.
> +
> +	  If unsure, say N.
> +

Well, IMO the new config option should be avoided for this optimization.

> +static inline bool
> +pipe_check_wq_has_sleeper(struct wait_queue_head *wq_head)
> +{
> +	if (IS_ENABLED(CONFIG_PIPE_SKIP_SLEEPER))
> +		return wq_has_sleeper(wq_head);
> +	else
> +		return true;
> +}

I think that another helper makes more sense:

	pipe_wake_xxx(wait_queue_head_t wait, flags)
	{
		if (wq_has_sleeper(wait))
			wake_up_interruptible_sync_poll(wait, flags);
	}

-------------------------------------------------------------------------------
But either way I am not sure this optimization is 100% correct, see below.

> @@ -377,7 +386,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
>  		 * _very_ unlikely case that the pipe was full, but we got
>  		 * no data.
>  		 */
> -		if (unlikely(was_full))
> +		if (unlikely(was_full) && pipe_check_wq_has_sleeper(&pipe->wr_wait))
>  			wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);

OK, at first glance this can't race with wait_event_xxx(wr_wait, pipe_writable),
wq_has_sleeper() and prepare_to_wait_event() have the necessary barriers.

But what about pipe_poll() ?

To oversimplify, pipe_poll(FMODE_WRITE) does

	// poll_wait()
	__pollwait() -> add_wait_queue(pipe->wr_wait) -> list_add()

	check pipe_full()

and I don't see the (in theory) necessary barrier between list_add()
and LOAD(pipe->head/tail).

Oleg.


