Return-Path: <linux-fsdevel+bounces-23936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9866935004
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 17:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69713283705
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 15:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D251448E7;
	Thu, 18 Jul 2024 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="adA8zsYM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF521448E4
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 15:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721316977; cv=none; b=gtP++lwNqBuK15QkDa1UmSctKoI+yb+uOWYTv9PJdwMEVxHbAu1Atw7lov3ngE0TqzSkL8sReQvZScmuxot26549naOPvYI2U3x7Vqi/hI0h4YIcu4636gxT+MKIxbA2poQ4N+U0LM4/XRkZqm0eM8afnHkp+bmKjrae685FFwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721316977; c=relaxed/simple;
	bh=9wbRVa5X6m1ax++0pAB99wHvvRsSCZ8n/WqyNSM9Gxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osacpWghw4olLSUNOy1XkrlU4Jl3YCwRtKa/pmhT18mhKGB9Qok7021huPmzwReiNuDPJynkTSwK1MCmqNbPczLy7S1y1pHLozVPHzfDg33kA4oz3bVLNGDzVQF/9rYEBVA0RqDvYl7ptag0rRmHmNJ2Vln7u4LQq7zmFv8cmXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=adA8zsYM; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e05e4c3228bso916944276.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 08:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1721316975; x=1721921775; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7LV3Cxf4q1HjMCIjpb4AGa+AlPw7o2PO+PnWn6lO3j4=;
        b=adA8zsYMvALo3ECAgD6N9QP2xu1X9zvN230EkQuUyCheF2/WVFfq33i36tg6mnL8dw
         1B8nnUql2ta/xD2GIFDSFrC3e2/o1UzVYj164lkdwnFldz+dosTseNY8+ZMoy/JLwKwM
         7axOq4XSSt8s+At/PHgcAyHxEmm+BFXRow4g/nL1su5CztM/bD3rAuwvLWa2Hugdaeir
         guJkftiwXqlKA4ghaiw3hh7Fow3vGcxQJr/uYoCR7+JN4EOm9EEJsMVJZ3a8TV5VBy7u
         GA9uJ6mJVK4S47JCj+eFz0erM9nIvIZflX9rNvFxF2/WmmpJnxeBp12P3xfeB+QaWLNF
         ytyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721316975; x=1721921775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LV3Cxf4q1HjMCIjpb4AGa+AlPw7o2PO+PnWn6lO3j4=;
        b=mP+41sDExhm7zMIPGMkL0ONQ8C8LciN3zaU0MT3SZxtJI/EzxNtZOG1S6Nxs6kECoR
         GMRpYWgf6f4///9fTn045flrjsDq8Meg+54NGGv1b5EKdwptNmLcfVH/qL+Q/rKr+w2x
         OYMstfmXGjItq7IXD2NEtDAf/vaMgn6wKKezt6INXKzZm8wDF+9Qs72SYPY+bxDFNMEm
         lUSh78iAzXPbQuWzOwdnXEWl1jaedPiUaeEaRkVcEPwMn4F5AlMbm8AlX64Z0BoK1JP1
         01FzQk8eZKvd7Uv75jJDz+ZVT6Wjjmrw7s1qmxQ5bSgSrMGkkDpNHpI+MTCbJDUwvgMd
         92dA==
X-Gm-Message-State: AOJu0Yz5PvHBbwVIOWvholH5KzhRsodKB+U+kZq2jTvWS9DBZrDyyLM3
	MEsDZRIQr+yqeCm5ComWQnuWEX/DsVUFjUYavQvAzUngiebQi3p0FlozJbhaqXUhph/zh42gX/z
	6
X-Google-Smtp-Source: AGHT+IGpQagyNjAu7muByoPHcN4EkCU4xwHhJMJpp2C1+ze2pK7+P/IYq/dWegO6vizWM2XstHbU7g==
X-Received: by 2002:a05:6902:2b93:b0:dff:3028:4631 with SMTP id 3f1490d57ef6-e05ed729577mr6768671276.33.1721316974708;
        Thu, 18 Jul 2024 08:36:14 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e05feb6949dsm367267276.59.2024.07.18.08.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 08:36:14 -0700 (PDT)
Date: Thu, 18 Jul 2024 11:36:13 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH RFC 0/4] iomap: zero dirty folios over unwritten mappings
 on zero range
Message-ID: <20240718153613.GC2099026@perftesting>
References: <20240718130212.23905-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718130212.23905-1-bfoster@redhat.com>

On Thu, Jul 18, 2024 at 09:02:08AM -0400, Brian Foster wrote:
> Hi all,
> 
> This is a stab at fixing the iomap zero range problem where it doesn't
> correctly handle the case of an unwritten mapping with dirty pagecache.
> The gist is that we scan the mapping for dirty cache, zero any
> already-dirty folios via buffered writes as normal, but then otherwise
> skip clean ranges once we have a chance to validate those ranges against
> races with writeback or reclaim.
> 
> This is somewhat simplistic in terms of how it scans, but that is
> intentional based on the existing use cases for zero range. From poking
> around a bit, my current sense is that there isn't any user of zero
> range that would ever expect to see more than a single dirty folio. Most
> callers either straddle the EOF folio or flush in higher level code for
> presumably (fs) context specific reasons. If somebody has an example to
> the contrary, please let me know because I'd love to be able to use it
> for testing.
> 
> The caveat to this approach is that it only works for filesystems that
> implement folio_ops->iomap_valid(), which is currently just XFS. GFS2
> doesn't use ->iomap_valid() and does call zero range, but AFAICT it
> doesn't actually export unwritten mappings so I suspect this is not a
> problem. My understanding is that ext4 iomap support is in progress, but
> I've not yet dug into what that looks like (though I suspect similar to
> XFS). The concern is mainly that this leaves a landmine for fs that
> might grow support for unwritten mappings && zero range but not
> ->iomap_valid(). We'd likely never know zero range was broken for such
> fs until stale data exposure problems start to materialize.
> 
> I considered adding a fallback to just add a flush at the top of
> iomap_zero_range() so at least all future users would be correct, but I
> wanted to gate that on the absence of ->iomap_valid() and folio_ops
> isn't provided until iomap_begin() time. I suppose another way around
> that could be to add a flags param to iomap_zero_range() where the
> caller could explicitly opt out of a flush, but that's still kind of
> ugly. I dunno, maybe better than nothing..?
> 
> So IMO, this raises the question of whether this is just unnecessarily
> overcomplicated. The KISS principle implies that it would also be
> perfectly fine to do a conditional "flush and stale" in zero range
> whenever we see the combination of an unwritten mapping and dirty
> pagecache (the latter checked before or during ->iomap_begin()). That's
> simple to implement and AFAICT would work/perform adequately and
> generically for all filesystems. I have one or two prototypes of this
> sort of thing if folks want to see it as an alternative.

I think this is the better approach, otherwise there's another behavior that's
gated behind having a callback that other filesystems may not know about and
thus have a gap.

Additionally do you have a test for this stale data exposure?  I think no matter
what the solution it would be good to have a test for this so that we can make
sure we're all doing the correct thing with zero range.  Thanks,

Josef

