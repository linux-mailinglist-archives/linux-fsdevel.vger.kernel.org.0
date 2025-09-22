Return-Path: <linux-fsdevel+bounces-62422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1944AB928DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 20:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5AB02A653D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 18:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1642431812E;
	Mon, 22 Sep 2025 18:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JSX3p04D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0519313526;
	Mon, 22 Sep 2025 18:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758564517; cv=none; b=VdZS9yynR3YDebSCTzh51w3f6xHnOcL5Cie6yCMazCYZF4tklBeSDQgDdzq9uG+dOtO4l+IW0Oih2b0VTvVh1tHOYViJU5gr2kRibG2ve0+SERdQ/LIh0R54TEjKhUA4EsN/EpXfTRoixH53qAHsX6kYbEYi1qGvFU0aOP6NKw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758564517; c=relaxed/simple;
	bh=tKJT6in7ur7nDpwsOw7KRNMi6M5Kfufpw8RxWEQB3gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ub/OtjqASEajjnQWhx6TfnSsccV/TFUjXEurxeLp9rDEQrOSzw3g8Ed21Nxu9cHYivKCf8/x2vuMOEusvAwynxbDaFblzOsZ7sjRduOBjU4Z4JxZSZTnRMlMXCoXhSxy0aftqeR12TI6DI0+zGyP8x1FSeU78W6o8BL9pEFIBPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JSX3p04D; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jQtZMBG55C+hVDGJ8duLOpG289A0c5o5Wr/sU5kj90Q=; b=JSX3p04DHi9p3pN6jPTS1lw8t3
	t75xjBNCz5FRbj9NFF4C/pi+LN3Y/djhaRl7yPhdImVPEge4SFFM1b7p6OJ1FCAbgvS+V+CjHm8Dw
	vWQAfu8z3avjmoqoE2zR6tNR+2+GcPz9RWvuNBUdBfyWrPIB6Db+pAqsuw/Ji3K8qpbYbN7k2vRh3
	6LKjsmlh3ThsCfeyb/Li/zx3GMrUWxF7X+Tty4UIBkAXclq/Umzo9PVGn52ZTfZZ014H/WSkD4VYs
	hmNoGJK4p6doKz0gCy2sde4ToIA9zKXQvN5NZTHQnjFcfw8mk4Jh29aMTzAOyjTpOSIQUD1HPm3Gq
	d0kQivmg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0kxk-0000000BDQU-3Sv6;
	Mon, 22 Sep 2025 18:08:32 +0000
Date: Mon, 22 Sep 2025 11:08:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Julian Sun <sunjunchao@bytedance.com>, cgroups@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, akpm@linux-foundation.org,
	lance.yang@linux.dev, mhiramat@kernel.org, agruenba@redhat.com,
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev
Subject: Re: [PATCH 0/3] Suppress undesirable hung task warnings.
Message-ID: <aNGQoPFTH2_xrd9L@infradead.org>
References: <20250922094146.708272-1-sunjunchao@bytedance.com>
 <20250922132718.GB49638@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922132718.GB49638@noisy.programming.kicks-ass.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Sep 22, 2025 at 03:27:18PM +0200, Peter Zijlstra wrote:
> > Julian Sun (3):
> >   sched: Introduce a new flag PF_DONT_HUNG.
> >   writeback: Introduce wb_wait_for_completion_no_hung().
> >   memcg: Don't trigger hung task when memcg is releasing.
> 
> This is all quite terrible. I'm not at all sure why a task that is
> genuinely not making progress and isn't killable should not be reported.

The hung device detector is way to aggressive for very slow I/O.
See blk_wait_io, which has been around for a long time to work
around just that.  Given that this series targets writeback I suspect
it is about an overloaded device as well.

> 
---end quoted text---

