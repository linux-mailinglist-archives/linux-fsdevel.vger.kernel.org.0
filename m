Return-Path: <linux-fsdevel+bounces-14230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF7F879B4D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 19:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFDDEB23787
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 18:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6924E139594;
	Tue, 12 Mar 2024 18:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OTp6Uakl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5A1273FC;
	Tue, 12 Mar 2024 18:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710267844; cv=none; b=qcRAbjENUUjcUV4q0fzTyQ7T1RCH0uOnyBgda54FRPK+Q8xB6sFyFLnPOXUSXvA/KZ56zWf1yC3y6ruq95ipi0f2TJ+4ybjonBgc0IyWl4mYYD5xS2HuscWQTbRj4JNHts9HiiqNerY8InAo0vj+zYUA7KPO3NeW8bY16aZKbwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710267844; c=relaxed/simple;
	bh=gj54TXLGtoqUu8AMVdjcFZZuTsEkjN88snjO6zTDCi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pd7BZ7r4Eat7ZiHA8dYuD6gawRgXDehseu3UvCmWA63AY28hm5mlwpD5Ei6LXMR/PMGVYq7Njw3I/clBNx/KzqYXjxx5CvjEgO53BCmB+D5i4eJantf2uQ4zzXzOx52829zdC4bpqMdgdKJ6B+ywRONHfD53GSJLjW8M5Gxbqds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OTp6Uakl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xm7GbgXJn9YwnZvlLSry0HH3FBwrqzxic0mWxiDob2w=; b=OTp6UaklGT+zH4v4znpg1opiV8
	NB3qzGKgQ392B3qikqglBFCsBTZ/ITN3RepSR8mfOqliJyZ8P6vPZWkEucocxDznHbj4Q8NfZfSky
	r5hTRDUZtyzJbyw73C5MTADF9M6rbHpyplQ1wQIgs9XZNG9ePr9M66bkibeHQOOlcLP3fMH9P6+hi
	rkYDd5T5ESp2blS0iNFsOmZsRFfyoXXGyEpntSNeY3aC4c03h5T8VeDIou+zIEnxN5h/BV6aPJXxC
	2GVLUijB40Xr9Z48KdwiQJqHSi94QEkQDxVUzv/muVg34lq8ha3PURBB6fDGIIcoOPe8F6nKukVgT
	Lo3t+Kmg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk6mv-000000076Ob-0eEr;
	Tue, 12 Mar 2024 18:23:45 +0000
Date: Tue, 12 Mar 2024 11:23:45 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
	kent.overstreet@linux.dev, mhocko@suse.com, hannes@cmpxchg.org,
	roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net,
	willy@infradead.org, liam.howlett@oracle.com,
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net,
	void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com,
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, peterx@redhat.com, david@redhat.com,
	axboe@kernel.dk, masahiroy@kernel.org, nathan@kernel.org,
	dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev,
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com,
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org,
	ndesaulniers@google.com, vvvvvv@google.com,
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
Subject: Re: [PATCH v4 13/36] lib: prevent module unloading if memory is not
 freed
Message-ID: <ZfCdsbPgiARPHUkw@bombadil.infradead.org>
References: <20240221194052.927623-1-surenb@google.com>
 <20240221194052.927623-14-surenb@google.com>
 <a9ebb623-298d-4acf-bdd5-0025ccb70148@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9ebb623-298d-4acf-bdd5-0025ccb70148@suse.cz>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Mon, Feb 26, 2024 at 05:58:40PM +0100, Vlastimil Babka wrote:
> On 2/21/24 20:40, Suren Baghdasaryan wrote:
> > Skip freeing module's data section if there are non-zero allocation tags
> > because otherwise, once these allocations are freed, the access to their
> > code tag would cause UAF.
> > 
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> 
> I know that module unloading was never considered really supported etc.

If its not supported then we should not have it on modules. Module
loading and unloading should just work, otherwise then this should not
work with modules and leave them in a zombie state.

  Luis

