Return-Path: <linux-fsdevel+bounces-46136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E804A833E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 00:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BD9B17C6D8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 22:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB72215787;
	Wed,  9 Apr 2025 22:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hInql5Zl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044EC211474
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Apr 2025 22:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744236330; cv=none; b=QhP+PI33pDxQqaFt1aHdI4sCjS+MoYfIov/Hge7qFPSJuQr1bF8clpZ9q8nhP9FLsgTELtF/e881cectCRgvipNBC6TL6zzjUCAV0KeMzMH6rg4oQ3rBVRXow33eqJAFSh82F4++t1o670v62E3pXaSzLfezdG0s0Z1W/Lp9qiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744236330; c=relaxed/simple;
	bh=u5PyeKX5UOQAZxJN0bycmihuV5BHcHjz8hzlJuWMXtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfTkQAKUnV7nLjgPFdzAimPk0he94rr+BFrHwH88El0r+jpoaVurOqjBuqFFmJnLWb/lSq62QvKS0hkDkibBrMExlJWzbJ3sH2WqpYDVej2oCaLr0ltCst98eQY6YC3zD251xdlzTQAJ78GxQjaZqjdUjw3tuwlUxVqvj0C3cZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hInql5Zl; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 9 Apr 2025 15:05:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744236323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=09r/CWT/cCwyNMYQClu5zBH5raBe8xtET0pxWWB2fIM=;
	b=hInql5ZlgGMEBjah698hzr352Uv7S/lOqlrEqZVxPqk/5PmtUoV+tAACFFc9f3SSn5wIFl
	VwdVSMXNrlCT6roXKpCgIb21zhRKcqR1ht49dQDtvEzM8/HziVVAp8Zw8pda9A+F0nBzu7
	uc48+cJ/+7ui/qGx+jllbGX0qFalpa4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: David Hildenbrand <david@redhat.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu, 
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	jefflexu@linux.alibaba.com, bernd.schubert@fastmail.fm, ziy@nvidia.com, jlayton@kernel.org, 
	kernel-team@meta.com, Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [PATCH v7 1/3] mm: add AS_WRITEBACK_INDETERMINATE mapping flag
Message-ID: <ukmd4fdrca2ofoqouq66rtjmq2agl57otwozvlwusnzxg3crah@byvep55p2hlk>
References: <20250404181443.1363005-1-joannelkoong@gmail.com>
 <20250404181443.1363005-2-joannelkoong@gmail.com>
 <0462bb5b-c728-4aef-baaf-a9da7398479f@redhat.com>
 <CAJnrk1Z2S9K1AsNnYHBOD_kGsOmYuJGyARimtc_4VUgUWDPigQ@mail.gmail.com>
 <221860f0-092c-47f1-a6f8-ebbe96429b1a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221860f0-092c-47f1-a6f8-ebbe96429b1a@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 04, 2025 at 10:13:55PM +0200, David Hildenbrand wrote:
> On 04.04.25 22:09, Joanne Koong wrote:
> > On Fri, Apr 4, 2025 at 12:13 PM David Hildenbrand <david@redhat.com> wrote:
> > > 
> > > On 04.04.25 20:14, Joanne Koong wrote:
> > > > Add a new mapping flag AS_WRITEBACK_INDETERMINATE which filesystems may
> > > > set to indicate that writing back to disk may take an indeterminate
> > > > amount of time to complete. Extra caution should be taken when waiting
> > > > on writeback for folios belonging to mappings where this flag is set.
> > > > 
> > > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > > Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > > Acked-by: Miklos Szeredi <mszeredi@redhat.com>
> > > > ---
> > > >    include/linux/pagemap.h | 11 +++++++++++
> > > >    1 file changed, 11 insertions(+)
> > > > 
> > > > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > > > index 26baa78f1ca7..762575f1d195 100644
> > > > --- a/include/linux/pagemap.h
> > > > +++ b/include/linux/pagemap.h
> > > > @@ -210,6 +210,7 @@ enum mapping_flags {
> > > >        AS_STABLE_WRITES = 7,   /* must wait for writeback before modifying
> > > >                                   folio contents */
> > > >        AS_INACCESSIBLE = 8,    /* Do not attempt direct R/W access to the mapping */
> > > > +     AS_WRITEBACK_INDETERMINATE = 9, /* Use caution when waiting on writeback */
> > > >        /* Bits 16-25 are used for FOLIO_ORDER */
> > > >        AS_FOLIO_ORDER_BITS = 5,
> > > >        AS_FOLIO_ORDER_MIN = 16,
> > > > @@ -335,6 +336,16 @@ static inline bool mapping_inaccessible(struct address_space *mapping)
> > > >        return test_bit(AS_INACCESSIBLE, &mapping->flags);
> > > >    }
> > > > 
> > > > +static inline void mapping_set_writeback_indeterminate(struct address_space *mapping)
> > > > +{
> > > > +     set_bit(AS_WRITEBACK_INDETERMINATE, &mapping->flags);
> > > > +}
> > > > +
> > > > +static inline bool mapping_writeback_indeterminate(struct address_space *mapping)
> > > > +{
> > > > +     return test_bit(AS_WRITEBACK_INDETERMINATE, &mapping->flags);
> > > > +}
> > > > +
> > > >    static inline gfp_t mapping_gfp_mask(struct address_space * mapping)
> > > >    {
> > > >        return mapping->gfp_mask;
> > > 
> > > Staring at this again reminds me of my comment in [1]
> > > 
> > > "
> > > b) Call it sth. like AS_WRITEBACK_MIGHT_DEADLOCK_ON_RECLAIM to express
> > >        that very deadlock problem.
> > > "
> > > 
> > > In the context here now, where we really only focus on the reclaim
> > > deadlock that can happen for trusted FUSE servers during reclaim, would
> > > it make sense to call it now something like that?
> > 
> > Happy to make this change. My thinking was that
> > 'AS_WRITEBACK_INDETERMINATE' could be reused in the future for stuff
> > besides reclaim, but we can cross that bridge if that ends up being
> > the case.
> 
> Yes, but I'm afraid one we start using it in other context we're reaching
> the point where we are trying to deal with untrusted user space and the page
> lock would already be a similar problem.
> 
> Happy to be wrong on this one.
> 
> Wait for other opinions first. Apart from that, no objection from my side.

I am on-board with keeping it specific to reclaim deadlock avoidance and
naming it such.

