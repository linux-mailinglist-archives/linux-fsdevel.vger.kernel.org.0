Return-Path: <linux-fsdevel+bounces-45570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDB2A79772
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 23:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B71B0168F8C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 21:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27501F3FC0;
	Wed,  2 Apr 2025 21:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="gc+pmdpQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796A7126F0A
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Apr 2025 21:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743628623; cv=none; b=eVsYW3ronFl//1Dg47DQOBiPxW0bmSchspN8ZuFyh1J9SV9wlzk5KbRyJq8vBmoMqXoOdx5uxj8ZZGMAQMv1G29IO6ihktWRmkl4g8eAPlVfeyHa/lrH3MaHvnRDJyPmjr5edhFO9TF+2Lxs8VgCAy4mKQ1ZpqKwcNDWfFPm7qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743628623; c=relaxed/simple;
	bh=yRY4i3WLmUWyAE8o8P8TYb1tByrQrsV7UggoX7SedcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kw/MrE1vOJiHcW9rx6+NcZ9p714bYz7Y8wOVxoc3A/WQmbb9c+xo1YIxsYYWRvLKc+UCq0yupwudoMAfckfNgeas5+P0+cItpGfeqC4Jz10ffaGsvZtw9mCtlk8PvgLPMRa5wqzmPWKCpU3QknbsovA7Ba+24kOIq4FC81nJEcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=gc+pmdpQ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7399838db7fso207850b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Apr 2025 14:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1743628621; x=1744233421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xc/zZ+DuPIPBwVNZBMJ0HujjjSUEiZ7ohcynsD7aA4A=;
        b=gc+pmdpQ0+9siX5+vh2aTvHczGfhbe/dnXiKMxqGEozOM+vqaV5XQqsXQzykxl5Vwo
         Nih5jA3YnBHYGVSAHafQtJ0btXDHDkL7rGAnmijaDWvnNCyEhaUzme0QytW49n4kiZVe
         HdarkrdOZxyqT6ysO33SUv2vg0QEiV5x3yg5iU9467esk+te3gSYy4Cv7NLAKQdwljp0
         N11HwzgMVhjZCAUaimSRcd2IgOimlYRxXO0EB7CmK2iEuvczPOiTtLiMtbR54t9Jnv4y
         Yl4ABma7Ogqt7yv2z7lcHmue6KGy2ip5KPV5M6gA7SorGVy2+zqplRTDgKhVknCHOAsF
         AIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743628621; x=1744233421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xc/zZ+DuPIPBwVNZBMJ0HujjjSUEiZ7ohcynsD7aA4A=;
        b=obHItGN+x2bAplBb6H9NJeTY1vBN+scuaM7ytMXukJvzWsgw0SS8kENEPGL6+qAF7V
         fq9l27SsxiDH5qLBz/KYJDVCmiQDdBnZJ1HnwcPah6LYD7ESzfuOdfWLP/IBH7EvUvnv
         W6UhgKPzItqhtscz+Tjlu22hF4YXuFHiNQXAJLPLXhMS2otd3snf+nPVN5gbttD7zANB
         giJBQqIS3RFTv/MBnbTeAnoL0O2SBR052q0VrN2u2eBhZDPvo028NaRGlBb/UoA6T24F
         dE+kZPCD4db1NLi2A3i7+LZipXX+Ltzu8j+uyLXR07DaeoOhmLeZTnchrAjt9CfPMn8c
         Vb9w==
X-Forwarded-Encrypted: i=1; AJvYcCXOWWOpQoKa7H7zNNhlKGzDj7R15zZzvD89ByWJvse5nHUO0WrlZvtKrbNggovCLEGA+z3SmS8h/uPgpzCt@vger.kernel.org
X-Gm-Message-State: AOJu0Yy40Cc0yyiz2k9dxrQF7RDrqftzaac02s6jKn74DgnrKq+nOP6z
	KPIH8iFL0t0gmZTMq3LOkcq3XzE59rD3Df1kNMK9UqGqr6P/xV9CsdB0sEAzqpo=
X-Gm-Gg: ASbGncvE98nG7FZkIpPNEB56XHhJpVG8kpZ9RRqjumCH9j7Xgw2cXGraVUJ7N3k+Mqx
	eFl9momfJ6/KwOf7O1BLWDrHry6DeYbjDvc4lWZiMpvr95oZTqhFjYL1b+YB/TDGth9wOAM0UNQ
	84fa8eEK/vq4PB8z3+S2D/Dfq03r/DJFODYS2nZGxlTAr3r7cEaFEqmkZ1OT/OWZabVROdWSQlO
	RFP67T7oPV1nzVzeUpjgW5IwRv1s2bsaqzoM15Qpyg1SGkKzqzTpQQPYCTn8X69o0lWGUMaR8Id
	CfrWUS2ZXKcUm1CQgCl/uXUU9TUxoauqoTU/v2vViQt+8/4E1/bvO4WgRKthZGa2JqZq/rqVBzx
	jqrJ+oIGrHAD1B0+UXDEbXAerBLpH
X-Google-Smtp-Source: AGHT+IETTieNbw/k3oeNyL1K32Iu4F4JpFYjFu/JJSEnpgavTw/4tVMQ23H2f0Cx5addp90wkEKvIA==
X-Received: by 2002:a05:6a00:4c17:b0:736:4c3d:2cba with SMTP id d2e1a72fcca58-739d6457e2dmr1406094b3a.9.1743628620577;
        Wed, 02 Apr 2025 14:17:00 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739710636a3sm11855554b3a.94.2025.04.02.14.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 14:17:00 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1u05SC-00000003h3r-2yeA;
	Thu, 03 Apr 2025 08:16:56 +1100
Date: Thu, 3 Apr 2025 08:16:56 +1100
From: Dave Chinner <david@fromorbit.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, Harry Yoo <harry.yoo@oracle.com>,
	Kees Cook <kees@kernel.org>, joel.granados@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>, linux-mm@kvack.org,
	Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] proc: Avoid costly high-order page allocations when
 reading proc files
Message-ID: <Z-2pSF7Zu0CrLBy_@dread.disaster.area>
References: <20250401073046.51121-1-laoar.shao@gmail.com>
 <3315D21B-0772-4312-BCFB-402F408B0EF6@kernel.org>
 <Z-y50vEs_9MbjQhi@harry>
 <CALOAHbBSvMuZnKF_vy3kGGNOCg5N2CgomLhxMxjn8RNwMTrw7A@mail.gmail.com>
 <Z-0gPqHVto7PgM1K@dread.disaster.area>
 <Z-0sjd8SEtldbxB1@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-0sjd8SEtldbxB1@tiehlicka>

On Wed, Apr 02, 2025 at 02:24:45PM +0200, Michal Hocko wrote:
> On Wed 02-04-25 22:32:14, Dave Chinner wrote:
> > Have a look at xlog_kvmalloc() in XFS. It implements a basic
> > fast-fail, no retry high order kmalloc before it falls back to
> > vmalloc by turning off direct reclaim for the kmalloc() call.
> > Hence if the there isn't a high-order page on the free lists ready
> > to allocate, it falls back to vmalloc() immediately.
> > 
> > For XFS, using xlog_kvmalloc() reduced the high-order per-allocation
> > overhead by around 80% when compared to a standard kvmalloc()
> > call. Numbers and profiles were documented in the commit message
> > (reproduced in whole below)...
> 
> Btw. it would be really great to have such concerns to be posted to the
> linux-mm ML so that we are aware of that.

I have brought it up in the past, along with all the other kvmalloc
API problems that are mentioned in that commit message.
Unfortunately, discussion focus always ended up on calling context
and API flags (e.g. whether stuff like GFP_NOFS should be supported
or not) no the fast-fail-then-no-fail behaviour we need.

Yes, these discussions have resulted in API changes that support
some new subset of gfp flags, but the performance issues have never
been addressed...

> kvmalloc currently doesn't support GFP_NOWAIT semantic but it does allow
> to express - I prefer SLAB allocator over vmalloc.

The conditional use of __GFP_NORETRY for the kmalloc call is broken
if we try to use __GFP_NOFAIL with kvmalloc() - this causes the gfp
mask to hold __GFP_NOFAIL | __GFP_NORETRY....

We have a hard requirement for xlog_kvmalloc() to provide
__GFP_NOFAIL semantics.

IOWs, we need kvmalloc() to support kmalloc(GFP_NOWAIT) for
performance with fallback to vmalloc(__GFP_NOFAIL) for
correctness...

> I think we could make
> the default kvmalloc slab path weaker by default as those who really
> want slab already have means to achieve that. There is a risk of long
> term fragmentation but I think this is worth trying

We've been doing this for a few years now in XFS in a hot path that
can make in the order of a million xlog_kvmalloc() calls a second.
We've not seen any evidence that this causes or exacerbates memory
fragmentation....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

