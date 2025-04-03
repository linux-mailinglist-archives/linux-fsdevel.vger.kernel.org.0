Return-Path: <linux-fsdevel+bounces-45586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBD6A7999A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 03:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C28203AC50C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 01:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84CA7F7FC;
	Thu,  3 Apr 2025 01:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="0E3LJfFd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0CCD26D
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 01:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743643358; cv=none; b=Zw0TpXmVIU+XeH+Yq65IZhPwIOx+UKjhRqliiVDq2rlh5PbbfwszChxCIS+iNCqa0IPkmlXp2P7JTQ5JDbXu08CZ2pmSVxex0s498hl2hB/XvIwUnyctr9tnueTL17QzD/kG+4nYi34jT4vZhEHEVzQBJ+eCr4M/0021bNlFUtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743643358; c=relaxed/simple;
	bh=R8DoRHeCqkdDoh1zmRk66sV3y9QX4YBRKQLRivDDbzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6Y0OEWqGCSJ6NZcTaEERAzYSEAFhXqfR2yRhNxqWkA9fVoQmWo+vLpspZL9JRtRH6xLQbOXo5qhBNf7c5KBKQTnVKTivA/DAnt5ITsc1phYbMw1KcmRqHZZ+sKn7gPDpQoHIDxqhIWzOz9fsk835DDmC3Kvn+JFF4SStVs0zj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=0E3LJfFd; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-af6a315b491so367249a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Apr 2025 18:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1743643356; x=1744248156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H4rcAW6CiUL4EGwBHYCgCAM1aNdXUEavAlcbulq5QK8=;
        b=0E3LJfFdjJafcIs//Rs4tJKQOVEQV3xy7BGRprMxth/zweCnJNldaWlqtR6x4cRK6S
         UDytfkbDH+uTX5K60dwUsv0zmnG8vzGci9gB50uvAeXuBPQdFqk0z2pJB7NjsjACA2s+
         OcaZHKC9a99hP3g19Za9tEeXrgJMQDtYgEhNSkCj6ZztsSiMcz7T5sxfSym5PMHeEG8v
         0t4+SOlvZoJnXZ8GgJn3Jw/fqDeQpQWqMiXX/rpB7fFX9cMg1SpxXQgc3Pnic0KGOzMx
         ACwKB/5y0uPpUvEc1k6Ki4XtqDOHKNnyJclVj6Y78HePgrWfrHz/J6Gy/1AFiERpiYt1
         rp5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743643356; x=1744248156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4rcAW6CiUL4EGwBHYCgCAM1aNdXUEavAlcbulq5QK8=;
        b=CyxketJwyNv8d7e0Jqda7giO0Z/q+bF+jpcI2f2HByGq7ngFr5Z+51n9/wcMYib1se
         BpSQLngiodWXyQ+tDWsOTzWGlTKFS/npHoF5KuyVPhq6tHiv5kzeZi8gg/5fWExLijA7
         7iEPa7iCv2KokB5uhB3Nwx+sNQnjvt9LI9sbqAJIbYS7XmXwhNGagX7vqsDOANd+DLtl
         J3LearQb+e3WTQ4JfRibp3vx/tL0HNLTRpOvq8qzCGFYU4SmL6QzqNgaMs1P1aiLNL+/
         guMZ+z8oJGMANiQil4sv/DYxfH3VF7HRELUa+GHZLdp4Dr6b5WZBdt449vFzAblQuX7C
         7UAA==
X-Forwarded-Encrypted: i=1; AJvYcCVgrSjdJ8T/y5whDgOORhGVJFz14VuTrGZSIs+krUo/sL5ruyTt6YwC76/NIh+YKQ/bdcbfBsU3MSiH4E2B@vger.kernel.org
X-Gm-Message-State: AOJu0YyZhdBhuocgmU7UIBDEx/bIYctZEbY8bgb3r6Ke7oh2f64Ae19y
	xuK+P6oBV9PnxNaU86/FnKYLsV8/YpPtm64yFNKUnDJ6UT6lRNEYAE4jHZm9Vww=
X-Gm-Gg: ASbGncsV0Q6j7AkpuNY4ygKI9i3txZ6CchfBeVrj05nVlQF5a0OF5YqGDaFNvRi9cya
	G5Qyvj3l4q6yLx1fLssxOSasa6t2CM2C+qwnaSJDAIQg4UX7C5yibY+yPWLe6Sj9U8hxOin8QZf
	EmIpul9oY7xSHUq2IcYYn+nW5M9wS19CXlpWsa79Tu1jheA2YG5FIjJgMPPW55uFHLPVo16yScs
	JDv3i/O5L5pMUaCs672xmS6XQhWzAcsGvAWYX1HEIsTymG0opj9kLBezVuE3/HR74/ERteRefPg
	l1aZ5fPWSN4xg587B00g2zytbKmuk2IfHCiXbP+61asQGEPLj3SCm/AcxM7CUvb7o1vKAglQnSR
	8hvbWobc=
X-Google-Smtp-Source: AGHT+IHMRa3sFAfbWro38Uxsf5pzpkFaygYzxLs0JzIu4oVQOmbGGlje/VbuGD8ibb/J/RjYbjK44Q==
X-Received: by 2002:a17:90b:2e0b:b0:2fe:a515:4a98 with SMTP id 98e67ed59e1d1-3057cbef71dmr1095737a91.31.1743643355647;
        Wed, 02 Apr 2025 18:22:35 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3058494a321sm162810a91.19.2025.04.02.18.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 18:22:35 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1u09Hr-00000003lXk-0oE4;
	Thu, 03 Apr 2025 12:22:31 +1100
Date: Thu, 3 Apr 2025 12:22:31 +1100
From: Dave Chinner <david@fromorbit.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Michal Hocko <mhocko@suse.com>, Yafang Shao <laoar.shao@gmail.com>,
	Harry Yoo <harry.yoo@oracle.com>, Kees Cook <kees@kernel.org>,
	joel.granados@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] proc: Avoid costly high-order page allocations when
 reading proc files
Message-ID: <Z-3i1wATGh6vI8x8@dread.disaster.area>
References: <20250401073046.51121-1-laoar.shao@gmail.com>
 <3315D21B-0772-4312-BCFB-402F408B0EF6@kernel.org>
 <Z-y50vEs_9MbjQhi@harry>
 <CALOAHbBSvMuZnKF_vy3kGGNOCg5N2CgomLhxMxjn8RNwMTrw7A@mail.gmail.com>
 <Z-0gPqHVto7PgM1K@dread.disaster.area>
 <Z-0sjd8SEtldbxB1@tiehlicka>
 <Z-2pSF7Zu0CrLBy_@dread.disaster.area>
 <b7qr6djsicpkecrkjk6473btzztfrvxifiy34u2vdb4cp5ktjf@lvg3rtwrbmsx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7qr6djsicpkecrkjk6473btzztfrvxifiy34u2vdb4cp5ktjf@lvg3rtwrbmsx>

On Wed, Apr 02, 2025 at 04:10:06PM -0700, Shakeel Butt wrote:
> On Thu, Apr 03, 2025 at 08:16:56AM +1100, Dave Chinner wrote:
> > On Wed, Apr 02, 2025 at 02:24:45PM +0200, Michal Hocko wrote:
> > > On Wed 02-04-25 22:32:14, Dave Chinner wrote:
> > > > Have a look at xlog_kvmalloc() in XFS. It implements a basic
> > > > fast-fail, no retry high order kmalloc before it falls back to
> > > > vmalloc by turning off direct reclaim for the kmalloc() call.
> > > > Hence if the there isn't a high-order page on the free lists ready
> > > > to allocate, it falls back to vmalloc() immediately.
> > > > 
> > > > For XFS, using xlog_kvmalloc() reduced the high-order per-allocation
> > > > overhead by around 80% when compared to a standard kvmalloc()
> > > > call. Numbers and profiles were documented in the commit message
> > > > (reproduced in whole below)...
> > > 
> > > Btw. it would be really great to have such concerns to be posted to the
> > > linux-mm ML so that we are aware of that.
> > 
> > I have brought it up in the past, along with all the other kvmalloc
> > API problems that are mentioned in that commit message.
> > Unfortunately, discussion focus always ended up on calling context
> > and API flags (e.g. whether stuff like GFP_NOFS should be supported
> > or not) no the fast-fail-then-no-fail behaviour we need.
> > 
> > Yes, these discussions have resulted in API changes that support
> > some new subset of gfp flags, but the performance issues have never
> > been addressed...
> > 
> > > kvmalloc currently doesn't support GFP_NOWAIT semantic but it does allow
> > > to express - I prefer SLAB allocator over vmalloc.
> > 
> > The conditional use of __GFP_NORETRY for the kmalloc call is broken
> > if we try to use __GFP_NOFAIL with kvmalloc() - this causes the gfp
> > mask to hold __GFP_NOFAIL | __GFP_NORETRY....
> > 
> > We have a hard requirement for xlog_kvmalloc() to provide
> > __GFP_NOFAIL semantics.
> > 
> > IOWs, we need kvmalloc() to support kmalloc(GFP_NOWAIT) for
> > performance with fallback to vmalloc(__GFP_NOFAIL) for
> > correctness...
> 
> Are you asking the above kvmalloc() semantics just for xfs or for all
> the users of kvmalloc() api? 

I'm suggesting that fast-fail should be the default behaviour for
everyone.

If you look at __vmalloc() internals, you'll see that it turns off
__GFP_NOFAIL for high order allocations because "reclaim is too
costly and it's far cheaper to fall back to order-0 pages".

That's pretty much exactly what we are doing with xlog_kvmalloc(),
and what I'm suggesting that kvmalloc should be doing by default.

i.e. If it's necessary for mm internal implementations to avoid
high-order reclaim when there is a faster order-0 allocation
fallback path available for performance reasons, then we should be
using that same behaviour anywhere optimisitic high-order allocation
is used as an optimisation for those same performance reasons.

The overall __GFP_NOFAIL requirement is something XFS needs, but it
is most definitely not something that should be enabled by default.
However, it needs to work with kvmalloc(), and it is not possible to
do so right now.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

