Return-Path: <linux-fsdevel+bounces-14229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACFF879B43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 19:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2665B28320B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 18:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442B813958E;
	Tue, 12 Mar 2024 18:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QqGwtO3T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F51273FC;
	Tue, 12 Mar 2024 18:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710267767; cv=none; b=HNi6MpSe0LTqmjieTYAAj6xZG58OXg4fa1PncPyx4pnd4SgSBVJPz83x3XevVLLcj4idHIv4qTHL8qakNQk0TkbX3NsYSUCNLQDmRnXvepEk9MXAS0hRzTRdjiuMVk/MxQmvtQQ7Zn6fLfDOpgFzgcJYKCcKSU7/UUx4n8mQq7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710267767; c=relaxed/simple;
	bh=YUc5IZWOe5T6YFtoM1+wQHxiKRB8D8X7e2HnId3ioaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q95rzI24UgbvRFo2ta4qFFRNTnERW1hCWn8X8dlJu1wAYDmos0ca+GbWVlDdSroYkSG2994xSUgP8ZOjLmuL6ZoUp+thO9rxVUpOWwQ5L0BlpsjmvQ37SSnbPtyNthsyPWJtRF8Gfhzt+uUWZrY133vIkybiyJYJ3Whbs6lHMK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QqGwtO3T; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dyIsdsMhrpRwB/lg1STothrgvq3zjNGfcwfAiy3Vmak=; b=QqGwtO3T5/xX63J1bb+PRK1e2Y
	HCNI2/xOcbWZFosust02xhjQt3eLEU3w032AbMAKk5Q6Us/M2J5LhESewS88IykqWhlkGyIUup8qQ
	eWnZym/zxsAPg6hPjXEpsxikgIGY6wWieBYp3/aMPXWS42WpM9BMOZODHKJR4rMZAbAc23ibPSQ2N
	tsSpuc9c6pdvZ/fsZU2Zm+UXsZ15mWdicSuBqEX/ez9fyZ3EDtB8jGH03SSyDIrop2OtOfb2aEcT5
	lAah57O7yF5dxZ/wVu6s+1BqyiE1TTE8BHL1uBVXRDvk+3wwqGHvEgsWdN+zXpv7A9F9QNQRmBwbu
	3okmEohw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk6lQ-00000007648-3mVp;
	Tue, 12 Mar 2024 18:22:12 +0000
Date: Tue, 12 Mar 2024 11:22:12 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com,
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
	liam.howlett@oracle.com, penguin-kernel@i-love.sakura.ne.jp,
	corbet@lwn.net, void@manifault.com, peterz@infradead.org,
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org,
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
	david@redhat.com, axboe@kernel.dk, masahiroy@kernel.org,
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
	elver@google.com, dvyukov@google.com, shakeelb@google.com,
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com,
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
	kernel-team@android.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-modules@vger.kernel.org,
	kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v5 12/37] lib: prevent module unloading if memory is not
 freed
Message-ID: <ZfCdVI464EqeI9YP@bombadil.infradead.org>
References: <20240306182440.2003814-1-surenb@google.com>
 <20240306182440.2003814-13-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306182440.2003814-13-surenb@google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Wed, Mar 06, 2024 at 10:24:10AM -0800, Suren Baghdasaryan wrote:
> Skip freeing module's data section if there are non-zero allocation tags
> because otherwise, once these allocations are freed, the access to their
> code tag would cause UAF.

So you just let them linger?

> Signed-off-by: Suren Baghdasaryan <surenb@google.com>


>  /* Free a module, remove from lists, etc. */
>  static void free_module(struct module *mod)
>  {
> +	bool unload_codetags;
> +
>  	trace_module_free(mod);
>  
> -	codetag_unload_module(mod);
> +	unload_codetags = codetag_unload_module(mod);
> +	if (!unload_codetags)
> +		pr_warn("%s: memory allocation(s) from the module still alive, cannot unload cleanly\n",
> +			mod->name);
> +

Because this is not unwinding anything. Should'd we check if we can
free all tags first, if we can't then we can't free the module. If we
can then ensure we don't enter a state where we can't later?

  Luis

