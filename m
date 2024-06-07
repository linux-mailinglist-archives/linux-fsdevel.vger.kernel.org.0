Return-Path: <linux-fsdevel+bounces-21160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 215F08FF9F0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 04:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C6A21C21782
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 02:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3913D12E5B;
	Fri,  7 Jun 2024 02:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="ZZ8MRw9u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED61111185
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 02:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717727434; cv=none; b=B5bR6IgU+bDkMGjj2oijRrzc9fm/33QEhVRIxCCbU8PFk0LM46Rhvy/0/R3jpROX2jBmFPKvS87uolo5deICdfkIBXFZxWue5xz1AU81Y4o8a7XLDRhP0rw7MvtXREL578V1HoMRqgSjomG97mrpGpN//xc1Num8yOUkrSoDjsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717727434; c=relaxed/simple;
	bh=F1FSXg+Nua9I1rMQOdDJ+stBJBU+yyDTc+H59mjgWus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcwJJfu8LVGAKhho1Bfalny2A7AIsZprH40QZE8yxRdccAqX+NcG0tDjXcJ/d87+7NFhMMqojwAtZ6rZ9YObU08dwpYDdr9tYpL6vTHUA0mHo+ukwH6SxBylOYnyW9UgQSGiyeK10OEK/JJPkxP4bYLbptHT8MEGg+a849hT2p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=ZZ8MRw9u; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3d1facdf12bso634009b6e.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jun 2024 19:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1717727432; x=1718332232; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RcYAFqsF/ckcf7QO6r1G7NHoqOY/UBNbxhGiJExnXzM=;
        b=ZZ8MRw9uOa8Mah0I0bMrnlMwTu09oSdCpf+cV2ICRzAJPzVxOjs2gvAc6OvFRNyA8w
         jc6zms/u1hyfHDjutBguGYpoEPq1zPZRaTLdZPEyET9m4bbeomowg8xFpmKuI0ZrtDTk
         zUFNcS7BEIdXEX360nlhbdZNcXwq7L+z/Jhcae08Cs3PuSCUE61BGBlraLWCVn1XoxVi
         0HDkx4eOwWTkzNy2Kq97n2HhLUPLyKE6PQLbl0mo6B4bCnaTtDoFOjxE00Xki+IKwFc9
         yGRkMcmsr301Z+P9fbnyvvrq3J1Cv3FKhuKbcxBN0V0NxBT0D3Gsx6kveWnSYbwKUJ8V
         AsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717727432; x=1718332232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RcYAFqsF/ckcf7QO6r1G7NHoqOY/UBNbxhGiJExnXzM=;
        b=cGV9wJNvDRkY3MCnkU5t45qH9yYW1EqkR21b8XBUWPjkuZY5/D9FiVrI1OizTjr/X4
         Vwpaj91Wis/LroX67lLOMZe1FuwEMpaN1E/EHwghytyMXrbgymjntDZOr466cGZN6qBM
         00gXVbbG7iU4wqpaKeKOdRJLidQMeFZTqjSzTjlxC082yWsPG+RaiKm92Ed10SYAnVOJ
         RQgsFOwU9k98xskYAW/xiNX5xZjQ53FCQ69CS+uJpobWLpNbrWJ1VqcBz9u7X9IstKKf
         /HBzvOpu1bUyOZe0ykELMcIXsfWSG1T2p64CiIBcFuOyYBdLP/6AbIcOEwaNIbmjzaKB
         UnfA==
X-Forwarded-Encrypted: i=1; AJvYcCVsdEyVpfAIdrILheoBAnQNJ6Xw03ToC8VEPdWOpZOjnphOio9M+1AKcgnr05/by7+D7MhS7T1RlC0AN1GXqjBQbJfy5zncg+UEZcX+Pg==
X-Gm-Message-State: AOJu0Yzfr3TFM9/L0WwvOxrTHyw+FXf6uv9zOJ10xbpPkBmYLH4VN/ZS
	JhR/5W1LRpmgaoDp3O/ebxAbXHkB5d3gkopajmTpJhPavWjIkKe5Y9RlQxZczfpZR5khut2S9iK
	U
X-Google-Smtp-Source: AGHT+IHtVc/xXs8p2LiOKX6TtS9ZuvcR36mQdLkewI301BrkE2phw2VVCM8NoQWWvK707zUUUr5Nlg==
X-Received: by 2002:a05:6808:1d9:b0:3d2:334:58cd with SMTP id 5614622812f47-3d210f5094dmr1139027b6e.58.1717727431530;
        Thu, 06 Jun 2024 19:30:31 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd4d94c2sm1792722b3a.144.2024.06.06.19.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 19:30:30 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sFPN5-00721B-0d;
	Fri, 07 Jun 2024 12:30:27 +1000
Date: Fri, 7 Jun 2024 12:30:27 +1000
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Bernd Schubert <bschubert@ddn.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"bernd.schubert@fastmail.fm" <bernd.schubert@fastmail.fm>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH RFC v2 06/19] Add a vmalloc_node_user function
Message-ID: <ZmJwwwtpdpGccFtC@dread.disaster.area>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
 <20240529-fuse-uring-for-6-9-rfc2-out-v1-6-d149476b1d65@ddn.com>
 <ZlnW8UFrGmY-kgoV@infradead.org>
 <sxnfn6u4szyly7yu54pyhtg44qe3hlwjgok4xw3a5mr3r2vrwb@3lecpeavc2os>
 <984577b6-e23d-4eec-a5da-214c5b3572ba@ddn.com>
 <Zl6V-qsxKTOBS860@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zl6V-qsxKTOBS860@infradead.org>

On Mon, Jun 03, 2024 at 09:20:10PM -0700, Christoph Hellwig wrote:
> On Mon, Jun 03, 2024 at 07:24:03PM +0000, Bernd Schubert wrote:
> > void *vmalloc_node(unsigned long size, int node)
> > {
> >         return __vmalloc_node(size, 1, GFP_KERNEL, node,
> >                         __builtin_return_address(0));
> > }
> > 
> > 
> > 
> > 
> > If we wanted to avoid another export, shouldn't we better rename
> > vmalloc_user to vmalloc_node_user, add the node argument and change
> > all callers?
> > 
> > Anyway, I will send the current patch separately to linux-mm and will ask
> > if it can get merged before the fuse patches.
> 
> Well, the GFP flags exist to avoid needing a gazillion of variants of
> everything build around the page allocator.  For vmalloc we can't, as
> Kent rightly said, support GFP_NOFS and GFP_NOIO and need to use the
> scopes instead, and we should warn about that (which __vmalloc doesn't
> and could use some fixes for).

Perhaps before going any further here, we should refresh our
memories on what the vmalloc code actually does these days?
__vmalloc_area_node() does this when mapping the pages:


	/*
         * page tables allocations ignore external gfp mask, enforce it
         * by the scope API
         */
        if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
                flags = memalloc_nofs_save();
        else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == 0)
                flags = memalloc_noio_save();

        do {
                ret = vmap_pages_range(addr, addr + size, prot, area->pages,
                        page_shift);
                if (nofail && (ret < 0))
                        schedule_timeout_uninterruptible(1);
        } while (nofail && (ret < 0));

        if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
                memalloc_nofs_restore(flags);
        else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == 0)
                memalloc_noio_restore(flags);


IOWs, vmalloc() has obeyed GFP_NOFS/GFP_NOIO constraints properly
for since early 2022 and there isn't a need to wrap it with scopes
just to do a single constrained allocation:

commit 451769ebb7e792c3404db53b3c2a422990de654e
Author: Michal Hocko <mhocko@suse.com>
Date:   Fri Jan 14 14:06:57 2022 -0800

    mm/vmalloc: alloc GFP_NO{FS,IO} for vmalloc
    
    Patch series "extend vmalloc support for constrained allocations", v2.
    
    Based on a recent discussion with Dave and Neil [1] I have tried to
    implement NOFS, NOIO, NOFAIL support for the vmalloc to make life of
    kvmalloc users easier.

.....

    Add support for GFP_NOFS and GFP_NOIO to vmalloc directly.  All internal
    allocations already comply with the given gfp_mask.  The only current
    exception is vmap_pages_range which maps kernel page tables.  Infer the
    proper scope API based on the given gfp mask.
.....

-Dave.

-- 
Dave Chinner
david@fromorbit.com

