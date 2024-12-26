Return-Path: <linux-fsdevel+bounces-38142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFB39FCD57
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2024 20:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E16516212F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2024 19:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F0F147C86;
	Thu, 26 Dec 2024 19:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TVvwCSVo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03882BCF5
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Dec 2024 19:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735241301; cv=none; b=gvsiVLqznhOEkT4qg7P+6Mr5Ba/1zabPT6hUNDeHu0wOwjqCoRwF++RguJUAj+kmX+meDYvpKeBMGiFIjqw1w/Z7GpbYKvzbwuo/KDRvvD4W13dndIEFqMLCyg6HdKmJummv+eliAP6yCKlcHdfZtfThoLrUYyVxisEf77JM40c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735241301; c=relaxed/simple;
	bh=pSWpbJXD8hWdcvU7ZuqPnkDEj4NBtkAidcz3T23gn6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TFP7VVvH4DUK+oGi30LXflrJ0rLTxfMDIC7kU6AKsG7OBR2VqF9mrdjlPeXztP123oQakLttrCYzaOl+QuUKUT94pQxqZa5DgaFOQnnT3wul08pBwJcBRo8j6rCdgC5f43M/TmhqgiDjrhgHZhEp8aslBdrDrR4NxOcJMQ7H7mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TVvwCSVo; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d3ecae02beso7983288a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Dec 2024 11:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1735241296; x=1735846096; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/NMUImSjcGHKg+Gvj2KvEBIgCuv7UhXeK5cD/H4h4A=;
        b=TVvwCSVoqE3pLalnlba5VhtY3wglrCQD2rK3pif4QPIAzZbDg/2969iaxdaxw1dFu1
         WHAYFlJrYHTS7IMlCOVMysbOwLPKMQXWgbp1afNASZD8Gl82z/fNH2NG3mDXeaaqaj4M
         Kj50kMUQBLxacWK1+sPkDIa7muIPyU/I3djdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735241296; x=1735846096;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q/NMUImSjcGHKg+Gvj2KvEBIgCuv7UhXeK5cD/H4h4A=;
        b=GA2V7GTQuKqejWnz4M59jZ0FVWo0h3RS3OBOd6E8XyHbdmp8ZgwmeC364uuAoElqig
         pGgD5A5qtNYCKbryBbSdgxbXDVeeTRo7Xuu+LWXSy1WaVlVA3Q6+WcuvFbaHC3CTc5my
         lhsz+gwHx12bMPotZ0/lD/jj5S1DGwpTVPIjbpcp1JA7IjAevxji/vI0T+tQVvIZhnEv
         4kKPyaX3hQTkiz1KldVpFzi79/AAQw3YxNaBPM+sbXEQO7gIcTUxD5WeO/l/BQwzYFuo
         eg1zZsLpty+TqKukc0yF2z87tm3/PVYMK6yzuVJmCrKpzP5QHswz/7jadpwU85AnJ8+6
         XS0w==
X-Forwarded-Encrypted: i=1; AJvYcCV/2ffBVN2sySxaGSs3YNgdu6J3zFWFn3Sm9x2vNvoMf88AIENSlxf6cPrzHHNiXybDMtr9LmLTgOBJ5lOi@vger.kernel.org
X-Gm-Message-State: AOJu0YxhD9jNKw2Lk96PMIM38o+LhifDxaT5pCo4eohJmlFN6TCsv0Qp
	8mOK5OcgletB+w58ivUN9DBnJgWjkUdMwE0Alq6ivS3KCIVu06l/jYNXVrxqi8s9js4j1ihfIHp
	qp7R6Vg==
X-Gm-Gg: ASbGnctKIi/uDFzHpUSrcK5HdNJkocwTky8qMDxbV2ez5fVzWI6qsgae378Lh/G2FyB
	gxyDej0fid5UtlS3AG/yZptagL/ClEkQnT+c98Q+KPoN4lFKGxcDK12dgr+H2zgMK+crXKFicHG
	qx23FdYlPOzlwvhXXyb3BDMIwQaLNQWeM5FnCm1qlQOX5QiGFf4hXqgHTB9reAimPP/IqoE4FgE
	p0k8K3PlE9uob9SyqHw5c8h4eP2Wyf0W7PqEEUadZRAyHoj+grMlJdqQSUr0/OvVI/7/CdeDbvR
	KB2B+tM5krdwsjPHtqbyAgI8M/F1pWg=
X-Google-Smtp-Source: AGHT+IEXx+WmATz8prDijV4XQ0WRDodDOMBMEMZpcOPpfvm7266AqEQr/zZoaI3oNqkXdBiNpE+1Jg==
X-Received: by 2002:a05:6402:4403:b0:5d1:1024:97a0 with SMTP id 4fb4d7f45d1cf-5d81dd5ee48mr22457609a12.6.1735241295789;
        Thu, 26 Dec 2024 11:28:15 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80676f397sm9872222a12.22.2024.12.26.11.28.13
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Dec 2024 11:28:14 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa684b6d9c7so1174690566b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Dec 2024 11:28:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUcSK20f19jA9ApnnO+dnJ9zuGpOOPdimQVBsGJ0F49ycatHdlNTfS4hsrrgJAOcueM9H+zIkNs6XpzkSE3@vger.kernel.org
X-Received: by 2002:a17:907:6e90:b0:aa6:5d30:d974 with SMTP id
 a640c23a62f3a-aac2d3286bfmr2588071266b.28.1735239782146; Thu, 26 Dec 2024
 11:03:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <75B06EE0B67747ED+20241225094202.597305-1-wangyuli@uniontech.com>
In-Reply-To: <75B06EE0B67747ED+20241225094202.597305-1-wangyuli@uniontech.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 26 Dec 2024 11:02:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj5A-fO+GnfwqGpXhFbfpS4+_8xU+dnXkSx+0AfwBYrxA@mail.gmail.com>
Message-ID: <CAHk-=wj5A-fO+GnfwqGpXhFbfpS4+_8xU+dnXkSx+0AfwBYrxA@mail.gmail.com>
Subject: Re: [RESEND PATCH] fs/pipe: Introduce a check to skip sleeping
 processes during pipe read/write
To: WangYuli <wangyuli@uniontech.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yushengjin@uniontech.com, zhangdandan@uniontech.com, guanwentao@uniontech.com, 
	zhanjun@uniontech.com, oliver.sang@intel.com, ebiederm@xmission.com, 
	colin.king@canonical.com, josh@joshtriplett.org, penberg@cs.helsinki.fi, 
	manfred@colorfullife.com, mingo@elte.hu, jes@sgi.com, hch@lst.de, 
	aia21@cantab.net, arjan@infradead.org, jgarzik@pobox.com, 
	neukum@fachschaft.cup.uni-muenchen.de, oliver@neukum.name, 
	dada1@cosmosbay.com, axboe@kernel.dk, axboe@suse.de, nickpiggin@yahoo.com.au, 
	dhowells@redhat.com, nathans@sgi.com, rolandd@cisco.com, tytso@mit.edu, 
	bunk@stusta.de, pbadari@us.ibm.com, ak@linux.intel.com, ak@suse.de, 
	davem@davemloft.net, jsipek@cs.sunysb.edu, jens.axboe@oracle.com, 
	ramsdell@mitre.org, hch@infradead.org, akpm@linux-foundation.org, 
	randy.dunlap@oracle.com, efault@gmx.de, rdunlap@infradead.org, 
	haveblue@us.ibm.com, drepper@redhat.com, dm.n9107@gmail.com, jblunck@suse.de, 
	davidel@xmailserver.org, mtk.manpages@googlemail.com, 
	linux-arch@vger.kernel.org, vda.linux@googlemail.com, jmorris@namei.org, 
	serue@us.ibm.com, hca@linux.ibm.com, rth@twiddle.net, lethal@linux-sh.org, 
	tony.luck@intel.com, heiko.carstens@de.ibm.com, oleg@redhat.com, 
	andi@firstfloor.org, corbet@lwn.net, crquan@gmail.com, mszeredi@suse.cz, 
	miklos@szeredi.hu, peterz@infradead.org, a.p.zijlstra@chello.nl, 
	earl_chew@agilent.com, npiggin@gmail.com, npiggin@suse.de, julia@diku.dk, 
	jaxboe@fusionio.com, nikai@nikai.net, dchinner@redhat.com, davej@redhat.com, 
	npiggin@kernel.dk, eric.dumazet@gmail.com, tim.c.chen@linux.intel.com, 
	xemul@parallels.com, tj@kernel.org, serge.hallyn@canonical.com, 
	gorcunov@openvz.org, levinsasha928@gmail.com, penberg@kernel.org, 
	amwang@redhat.com, bcrl@kvack.org, muthu.lkml@gmail.com, muthur@gmail.com, 
	mjt@tls.msk.ru, alan@lxorguk.ukuu.org.uk, raven@themaw.net, thomas@m3y3r.de, 
	will.deacon@arm.com, will@kernel.org, josef@redhat.com, 
	anatol.pomozov@gmail.com, koverstreet@google.com, zab@redhat.com, 
	balbi@ti.com, gregkh@linuxfoundation.org, mfasheh@suse.com, 
	jlbec@evilplan.org, rusty@rustcorp.com.au, asamymuthupa@micron.com, 
	smani@micron.com, sbradshaw@micron.com, jmoyer@redhat.com, sim@hostway.ca, 
	ia@cloudflare.com, dmonakhov@openvz.org, ebiggers3@gmail.com, 
	socketpair@gmail.com, penguin-kernel@i-love.sakura.ne.jp, w@1wt.eu, 
	kirill.shutemov@linux.intel.com, mhocko@suse.com, vdavydov.dev@gmail.com, 
	vdavydov@virtuozzo.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	minchan@kernel.org, deepa.kernel@gmail.com, arnd@arndb.de, balbi@kernel.org, 
	swhiteho@redhat.com, konishi.ryusuke@lab.ntt.co.jp, dsterba@suse.com, 
	vegard.nossum@oracle.com, axboe@fb.com, pombredanne@nexb.com, 
	tglx@linutronix.de, joe.lawrence@redhat.com, mpatocka@redhat.com, 
	mcgrof@kernel.org, keescook@chromium.org, linux@dominikbrodowski.net, 
	jannh@google.com, shakeelb@google.com, guro@fb.com, willy@infradead.org, 
	khlebnikov@yandex-team.ru, kirr@nexedi.com, stern@rowland.harvard.edu, 
	elver@google.com, parri.andrea@gmail.com, paulmck@kernel.org, 
	rasibley@redhat.com, jstancek@redhat.com, avagin@gmail.com, cai@redhat.com, 
	josef@toxicpanda.com, hare@suse.de, colyli@suse.de, johannes@sipsolutions.net, 
	sspatil@android.com, alex_y_xu@yahoo.ca, mgorman@techsingularity.net, 
	gor@linux.ibm.com, jhubbard@nvidia.com, andriy.shevchenko@linux.intel.com, 
	crope@iki.fi, yzaikin@google.com, bfields@fieldses.org, jlayton@kernel.org, 
	kernel@tuxforce.de, steve@sk2.org, nixiaoming@huawei.com, 
	0x7f454c46@gmail.com, kuniyu@amazon.co.jp, alexander.h.duyck@intel.com, 
	kuni1840@gmail.com, soheil@google.com, sridhar.samudrala@intel.com, 
	Vincenzo.Frascino@arm.com, chuck.lever@oracle.com, Kevin.Brodsky@arm.com, 
	Szabolcs.Nagy@arm.com, David.Laight@aculab.com, Mark.Rutland@arm.com, 
	linux-morello@op-lists.linaro.org, Luca.Vizzarro@arm.com, 
	max.kellermann@ionos.com, adobriyan@gmail.com, lukas@schauer.dev, 
	j.granados@samsung.com, djwong@kernel.org, kent.overstreet@linux.dev, 
	linux@weissschuh.net, kstewart@efficios.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Dec 2024 at 01:44, WangYuli <wangyuli@uniontech.com> wrote:
>
>
> +config PIPE_SKIP_SLEEPER
> +       bool "Skip sleeping processes during pipe read/write"

If the optimization is correct, there is no point to having a config option.

If the optimization is incorrect, there is no point to having the code.

Either way, there's no way we'd ever have a config option for this.

> +pipe_check_wq_has_sleeper(struct wait_queue_head *wq_head)
> +{
> +               return wq_has_sleeper(wq_head);

So generally, the reason this is buggy is that it's racy due to either
CPU memory ordering issues or simply because the sleeper is going to
sleep but hasn't *quite* added itself to the wait queue.

Which is why the wakeup path takes the wq head lock.

Which is the only thing you are actually optimizing away.

> +       if (was_full && pipe_check_wq_has_sleeper(&pipe->wr_wait))
>                 wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);

End result: you need to explain why the race cannot exist.

And I think your patch is simply buggy because the race can in fact
exist, because there is no other lock than the waitqueue lock that
enforces memory ordering and protects against the "somebody is just
about to sleep" race.

That said, *if* all the wait queue work was done under the pipe mutex,
we could use the pipe mutex for exclusion instead.

That's actually how it kind of used to work long long ago (not really
- but close: it depended on the BKL originally, and adding waiters to
the wait-queues early before all the tests for full/empty, and
avoiding the races that way)

But now waiters use "wait_event_interruptible_exclusive()" explicitly
outside the pipe mutex, so the waiters and wakers aren't actually
serialized.

And no, you are unlikely to see the races in practice (particularly
the memory ordering ones). So you have to *think* about them, not test
them.

         Linus

