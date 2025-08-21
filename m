Return-Path: <linux-fsdevel+bounces-58626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B41B300A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 18:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE05B17ECC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 16:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7EF2E764B;
	Thu, 21 Aug 2025 16:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="af+Hak+N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4832E7198;
	Thu, 21 Aug 2025 16:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755795586; cv=none; b=CYEJHcR4t9tBwr6/cDmnLTuOHxk9cQE8J9dVvpXZceU7wMakuUVWpgA4DcZ/mFh3rw8DztotySjn3fAnUaV0hfqQE8x+mbL0avJNqnSuqu0xQl3H9STI+m6i2qD8t3TPMIFakK7JJ925Uu26xiheEOkhicfVAnpy//eYiZXLZkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755795586; c=relaxed/simple;
	bh=pp/gk4pOi/0v1HmMWUiDkoQlsk+QIM6imhIi2GSSpK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjpV4h2ulMTe15ipobwA0VAF51SysyXza/5fpnFuw8t06PNUBh2hXyV9ikNeqGaNmPMCC16EEnoFzW4Jj2qp8vqMJaY7jOSFywL9255E7ebobYKn+wMxPBkkxfqv/0HQxxMIhvUe3R+tsWH5CO1sxevDiVXvPdCsNGE7KIVo0UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=af+Hak+N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A4DC4CEEB;
	Thu, 21 Aug 2025 16:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755795586;
	bh=pp/gk4pOi/0v1HmMWUiDkoQlsk+QIM6imhIi2GSSpK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=af+Hak+Nfuz0y6X0Qr8P866fWXKOmFsFqBUtxHcrew5O8pLnWjiqhMEcRwul5lFqf
	 uDCDxPRYZ1BuFhfghVTm+7r4DJWCvD+ES0luQVuh3/4x9Mio9Q9Yzn0bjAvy4EQp3I
	 3tgigV4T3NrYBKO4FVr7LkF0SpONlzLKAPcdDMQ8F0ZwA3Hc3HO69utwGNyFYsu0LI
	 Xnzid3gnttQZM4kZTUzOAs5IHLkuMBGVw+hZ6Krg4nXe/KsdTdSTPFMoxT+8RVAYg7
	 H0GuZPtY4Z0BcnLVXy3ZUiltSZMtcwU+VLqIB+ll+7ePtZufzYkWmSsMRfPsEJB0L8
	 63lviEWaVEnfg==
Date: Thu, 21 Aug 2025 06:59:44 -1000
From: Tejun Heo <tj@kernel.org>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, axboe@kernel.dk
Subject: Re: [External] Re: [PATCH] memcg: Don't wait writeback completion
 when release memcg.
Message-ID: <aKdQgIvZcVCJWMXl@slm.duckdns.org>
References: <20250820111940.4105766-1-sunjunchao@bytedance.com>
 <20250820111940.4105766-4-sunjunchao@bytedance.com>
 <aKY2-sTc5qQmdea4@slm.duckdns.org>
 <CAHSKhtf--qn3TH3LFMrwqb-Nng2ABwV2gOX0PyAerd7h612X5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHSKhtf--qn3TH3LFMrwqb-Nng2ABwV2gOX0PyAerd7h612X5Q@mail.gmail.com>

Hello,

On Thu, Aug 21, 2025 at 10:30:30AM +0800, Julian Sun wrote:
> On Thu, Aug 21, 2025 at 4:58 AM Tejun Heo <tj@kernel.org> wrote:
> >
> > On Wed, Aug 20, 2025 at 07:19:40PM +0800, Julian Sun wrote:
> > > @@ -3912,8 +3921,12 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
> > >       int __maybe_unused i;
> > >
> > >  #ifdef CONFIG_CGROUP_WRITEBACK
> > > -     for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
> > > -             wb_wait_for_completion(&memcg->cgwb_frn[i].done);
> > > +     for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++) {
> > > +             struct wb_completion *done = memcg->cgwb_frn[i].done;
> > > +
> > > +             if (atomic_dec_and_test(&done->cnt))
> > > +                     kfree(done);
> > > +     }
> > >  #endif
> >
> > Can't you just remove done? I don't think it's doing anything after your
> > changes anyway.
> 
> Thanks for your review.
> 
> AFAICT done is also used to track free slots in
> mem_cgroup_track_foreign_dirty_slowpath() and
> mem_cgroup_flush_foreign(), otherwise we have no method to know which
> one is free and might flush more than what MEMCG_CGWB_FRN_CNT allow.
> 
> Am I missing something?

No, I missed that. I don't think we need to add extra mechanisms in wb for
this tho. How about shifting wb_wait_for_completion() and kfree(memcg) into
a separate function and punt those to a separate work item? That's going to
be a small self-contained change in memcg.

Thanks.

-- 
tejun

