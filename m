Return-Path: <linux-fsdevel+bounces-11560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAD2854C0A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 16:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5DAEB23F52
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 15:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5BD5BADB;
	Wed, 14 Feb 2024 15:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jfoJ/wmk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D635B1F3;
	Wed, 14 Feb 2024 15:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707922842; cv=none; b=swLvXy+KY4ZMDzf7Qher6/BH2nQcWQ3ZYy0GXu4JFetNPzdr9WOVuf3Gn1m5AqpVa5fljAgzbMqmT+6j10OiTZ1JgKiOaneT19VhchStogNVbRixTLrH952cWQSEx3y+N2aJd1P1PDwot/zivv36475pyHz5W1rDJK3eAlx0bzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707922842; c=relaxed/simple;
	bh=J/8B9sj/gh69TjG907GBC0ybnivmqovG5E80SUw+iQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+pgrpdw985tqxBW6M7jTcmkEiF0umnUXBXe9DyGWplXNnq5IISSWpkUtz9euNA7A0tSXMFXa0M6+lyd36+XfPx+UUVnQB5tul+lZuLSLAobwzDWBaSGA71XqXe/jNMPyE5MIHjNqkWnyRe6BXA9JDpAx9CGU14YAVCgTIMgwJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jfoJ/wmk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=N9oS2vBFsBe7fjNywvimN9eVDsY+Q1p8TnsuDCbqyL8=; b=jfoJ/wmkTGQGza6aS6As/LoHT2
	7f9nxqD9DDcP98YSEsCWUa2KUHKv3yOMXShjBerqUVejBrYgV37I0QICjylxkLAH01QVhY7zARA99
	4cl5s8aYSnpH9z5inXWSTSNKWmmn9IJe3FSG3ZYYFRXX3lh0u0p+v8DKBDUFgcmrOVRSGaYZRCpVG
	dswefOzAR6MusqozarzFQUAhf9oOgDNXGT+36hpSGg/Z2EcMWzrPYznsnnyW204WH1S7lTL0sGgVN
	r5hkA+WxnCp1BeMai4eWKbYBadnRcJrtDVtupo9eMxQVeW09i9IRSU1xAJnexHy0C9unE+tOPNqUd
	EaHb7PIg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raGjw-0000000Gs4u-1uPd;
	Wed, 14 Feb 2024 15:00:00 +0000
Date: Wed, 14 Feb 2024 15:00:00 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>,
	David Hildenbrand <david@redhat.com>,
	Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
	mgorman@suse.de, dave@stgolabs.net, liam.howlett@oracle.com,
	corbet@lwn.net, void@manifault.com, peterz@infradead.org,
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org,
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
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
Subject: Re: [PATCH v3 00/35] Memory allocation profiling
Message-ID: <ZczVcOXtmA2C3XX8@casper.infradead.org>
References: <Zctfa2DvmlTYSfe8@tiehlicka>
 <CAJuCfpEsWfZnpL1vUB2C=cxRi_WxhxyvgGhUg7WdAxLEqy6oSw@mail.gmail.com>
 <9e14adec-2842-458d-8a58-af6a2d18d823@redhat.com>
 <2hphuyx2dnqsj3hnzyifp5yqn2hpgfjuhfu635dzgofr5mst27@4a5dixtcuxyi>
 <6a0f5d8b-9c67-43f6-b25e-2240171265be@redhat.com>
 <CAJuCfpEtOhzL65eMDk2W5SchcquN9hMCcbfD50a-FgtPgxh4Fw@mail.gmail.com>
 <adbb77ee-1662-4d24-bcbf-d74c29bc5083@redhat.com>
 <r6cmbcmalryodbnlkmuj2fjnausbcysmolikjguqvdwkngeztq@45lbvxjavwb3>
 <CAJuCfpF4g1jeEwHVHjQWwi5kqS-3UqjMt7GnG0Kdz5VJGyhK3Q@mail.gmail.com>
 <ea5vqiv5rt5cdbrlrdep5flej2pysqbfvxau4cjjbho64652um@7rz23kesqdup>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea5vqiv5rt5cdbrlrdep5flej2pysqbfvxau4cjjbho64652um@7rz23kesqdup>

On Tue, Feb 13, 2024 at 06:08:45PM -0500, Kent Overstreet wrote:
> This is what instrumenting an allocation function looks like:
> 
> #define krealloc_array(...)                     alloc_hooks(krealloc_array_noprof(__VA_ARGS__))
> 
> IOW, we have to:
>  - rename krealloc_array to krealloc_array_noprof
>  - replace krealloc_array with a one wrapper macro call
> 
> Is this really all we're getting worked up over?
> 
> The renaming we need regardless, because the thing that makes this
> approach efficient enough to run in production is that we account at
> _one_ point in the callstack, we don't save entire backtraces.

I'm probably going to regret getting involved in this thread, but since
Suren already decided to put me on the cc ...

There might be a way to do it without renaming.  We have a bit of the
linker script called SCHED_TEXT which lets us implement
in_sched_functions().  ie we could have the equivalent of

include/linux/sched/debug.h:#define __sched             __section(".sched.text")

perhaps #define __memalloc __section(".memalloc.text")
which would do all the necessary magic to know where the backtrace
should stop.


