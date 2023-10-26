Return-Path: <linux-fsdevel+bounces-1273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC17A7D8C61
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 01:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECB091C20F61
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 23:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B02405CC;
	Thu, 26 Oct 2023 23:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wlXDU2r/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4069418050
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 23:54:50 +0000 (UTC)
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [IPv6:2001:41d0:203:375::b4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A291BB
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 16:54:47 -0700 (PDT)
Date: Thu, 26 Oct 2023 19:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698364483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fxBcC6WpG3KRFkLY2+tQDJJ4+RZgo+8n9ZWicropf8c=;
	b=wlXDU2r/5NnsFnSK4PA0DRbeQnz5idT7VKahwUmPIGnLuoPyox6xMFxCRq1Pws1EO9s3ve
	aIg3upr66EtS1MsZX/PbSPfqPxCaMEUcPviZb6meANiNZEhNmrQ2++x3KPz3NDd9hcGBJa
	757p2yOOJ0ABimOFGTUk16CjWjiwuWc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
	roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net,
	willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net,
	void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com,
	ldufour@linux.ibm.com, catalin.marinas@arm.com, will@kernel.org,
	arnd@arndb.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, peterx@redhat.com, david@redhat.com,
	axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com,
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com,
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com,
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
	elver@google.com, dvyukov@google.com, shakeelb@google.com,
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v2 28/39] timekeeping: Fix a circular include dependency
Message-ID: <20231026235433.yuvxf7opxg74ncmd@moria.home.lan>
References: <20231024134637.3120277-1-surenb@google.com>
 <20231024134637.3120277-29-surenb@google.com>
 <87h6me620j.ffs@tglx>
 <CAJuCfpH1pG513-FUE_28MfJ7xbX=9O-auYUjkxKLmtve_6rRAw@mail.gmail.com>
 <87jzr93rxv.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jzr93rxv.ffs@tglx>
X-Migadu-Flow: FLOW_OUT

On Fri, Oct 27, 2023 at 01:05:48AM +0200, Thomas Gleixner wrote:
> On Thu, Oct 26 2023 at 18:33, Suren Baghdasaryan wrote:
> > On Wed, Oct 25, 2023 at 5:33 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> > This avoids a circular header dependency in an upcoming patch by only
> >> > making hrtimer.h depend on percpu-defs.h
> >>
> >> What's the actual dependency problem?
> >
> > Sorry for the delay.
> > When we instrument per-cpu allocations in [1] we need to include
> > sched.h in percpu.h to be able to use alloc_tag_save(). sched.h
> 
> Including sched.h in percpu.h is fundamentally wrong as sched.h is the
> initial place of all header recursions.
> 
> There is a reason why a lot of funtionalitiy has been split out of
> sched.h into seperate headers over time in order to avoid that.

Yeah, it's definitely unfortunate. The issue here is that
alloc_tag_save() needs task_struct - we have to pull that in for
alloc_tag_save() to be inline, which we really want.

What if we moved task_struct to its own dedicated header? That might be
good to do anyways...

