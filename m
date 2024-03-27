Return-Path: <linux-fsdevel+bounces-15374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C0C88D505
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 04:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA0C72C515E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 03:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC9E22F08;
	Wed, 27 Mar 2024 03:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CvKbObme"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830BC17545;
	Wed, 27 Mar 2024 03:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711509916; cv=none; b=HUF+kZWIQU1g4E5gOrPu0ixxQt3ugiYCG8boS+DpG2H7VqRHN5S82FClvZef3QQgkDul7fRxWGtGfWWz+t3p/4ghVUNhRqr+5pLewDgV7kGUQpnb6Rymulv3ysLQNk34fYm0x7/baT+FXX7DeRJAn5kcYm+1t4f7T4CUvMvuFlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711509916; c=relaxed/simple;
	bh=Ajy7EClEZNT2l5jOz2HI8KHPxT0cshu9vXiK2kZRlto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ReRtvfXj3NavgzydWCWY9EQm3+1BbJM7IeHD+3lUltRhxsgoK6lLJCqyalPq8uSc5A+A+hwgbgbkDuXI/CsovsDzYs3+jpI4ZIqTDnXYT1hZDkpss0r96Uzx2l2y6x6R1xVlClUM+GyAMq1iuoyFiWJECAGqRSZxJt45b4I2CA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CvKbObme; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RlEUjYz6ln8uzzOTkIlgn9vdiC3nQ/IHmLuBP8wka2o=; b=CvKbObmeyBqqOPthjS/+uTpYG7
	eoUDBQh9S0XUeVkTmqvfA2KU9S2jl1TZ0d/qfo5XKxsxRNNeBlTMQ9ds6skxSEv80Xd12pe1JfdEb
	wBCa1azgkkM7zTLqgfjH1rCC5601LmPSODTJbeICFjKQWfDpMNA114PK6p2Yu5WOCMl603JqhWXFP
	GAqIFx5AGDyS+2+gnJcmPNdFornkVnc81GPJerRi2bQih5+8inhCt2YgTrhOsNBiT38nwzY62TPlz
	+Ui6qV0zTYT8lAxb8f7sCnUN35mUg/q0e5NBUGjmRCTIeFKN0D3jcStJA97Y0rx4kDHTcdjGvCFZw
	x40o0e+w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpJtt-00000002v5K-0VmM;
	Wed, 27 Mar 2024 03:24:29 +0000
Date: Wed, 27 Mar 2024 03:24:28 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com,
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
	mgorman@suse.de, dave@stgolabs.net, liam.howlett@oracle.com,
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net,
	void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com,
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, peterx@redhat.com, david@redhat.com,
	axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
	nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com,
	tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org,
	paulmck@kernel.org, pasha.tatashin@soleen.com,
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org,
	ndesaulniers@google.com, vvvvvv@google.com,
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
	elver@google.com, dvyukov@google.com, songmuchun@bytedance.com,
	jbaron@akamai.com, aliceryhl@google.com, rientjes@google.com,
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v6 14/37] lib: introduce support for page allocation
 tagging
Message-ID: <ZgORbAY5F0MWgX5K@casper.infradead.org>
References: <20240321163705.3067592-1-surenb@google.com>
 <20240321163705.3067592-15-surenb@google.com>
 <ZgI9Iejn6DanJZ-9@casper.infradead.org>
 <CAJuCfpGvviA5H1Em=ymd8Yqz_UoBVGFOst_wbaA6AwGkvffPHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpGvviA5H1Em=ymd8Yqz_UoBVGFOst_wbaA6AwGkvffPHg@mail.gmail.com>

On Mon, Mar 25, 2024 at 11:23:25PM -0700, Suren Baghdasaryan wrote:
> Ah, good eye! We probably didn't include page_ext.h before and then
> when we did I missed removing these declarations. I'll post a fixup.
> Thanks!

Andrew's taken a patch from me to remove these two declarations as
part of marking them const.  No patch needed from you, just needed to
check there was no reason to have them.

