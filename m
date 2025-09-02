Return-Path: <linux-fsdevel+bounces-59927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 386C9B3F35A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 06:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1CBC483237
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 04:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184692E0B68;
	Tue,  2 Sep 2025 04:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="QBRAITGE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA77C2D592F
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Sep 2025 04:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756786084; cv=none; b=W6FrIo4oZYOMR/gBoKXvb5SRsQFEd+zkOzgYTjA6jrpmRcZY2c2GHbbq0o3jcgRfup7C9OAohvHuG8yYv6wMrq8ijXvEHN1wGfbHUposlGoKWpxpKKPMxsqO7xgRHgiNUqrRvbwe0pNg84QyvIHDfqDmy+lhr41t//oe3ulMRWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756786084; c=relaxed/simple;
	bh=PWNB5atbUEOuqCWpXCHiRuAa8huc06HyOsum8ht+p4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHhAWS72DdCjfI4YQ5VkgcRt6XhCm3wQWHTF2/eoBg9a+TP8o9+JuytsAePuyBQ4Y9dA1iNv55c/l6RQFjkH1Y9fzL/76RSGvpyl5INqFSzM7vujzsTMSHBqrqf33CReskOrtZSaOV2AqAhNXfBA+O6SVwe/l66euXi30OHss20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=QBRAITGE; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-327b657924dso4268455a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Sep 2025 21:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1756786082; x=1757390882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2koyHV7vuEyseT1MwkXtGDYmtqrlLkXDUc1MXluszg0=;
        b=QBRAITGEOjhMRkhNX3qiac+tZhAw8ZcB77z31AC1HEdaVzyA65kIAUeF0DmAm8Igyt
         wDuUybjJj0CoMtmoNr1sgtOt63zbJeVppZzkEwOtPfJeOaICF6Q2CgaaC1fG+T5R3jPD
         VX5t4asCNrI0TTpvUIb1hUHp2gaBSeXykNA7UwqU59Fdq5/K1Qq2rZDMDxj+C+cDHsk9
         ZmFRtZfgkk0LOYDQdIoi3xv9HA4sXQINfvHBHXxC8pJRS5BVhU0g9L5GyGYg6rC/DjAD
         3p6aeyE3qe2psLLq9JEn1E61sOr+A3QlE87N1iPa506ImNCeOyu57Un3jYaLbqKG3rfO
         cmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756786082; x=1757390882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2koyHV7vuEyseT1MwkXtGDYmtqrlLkXDUc1MXluszg0=;
        b=FlPo4sdtW5I7Aqpjk+OSoobam/+Wj7bE2hrp4acC+ZQ2jZzL7499p9Qp0HF+Bnxc0N
         WjX+e95UDSlpJp+rtWYn15hmCvxEjslzxniE9Si7H9nOVy5W55niocD1mOvuuTiCSSGB
         2vZ8LIysMDRlNbJAFWljfjhqndNcjBXtdfWp7P0oAgRkfq1OkSZZQ3GpULawELdNcdVD
         1ToNykwO/CrY2Xa1ONTyGhWAZrHeYdg7HfoiAsvXAVdkWr6ZG9gOHsGVLW0dwzuxRR3S
         fuof6HPaYRDkJ6bcPowFWrlv7GlGfGNEHETgd+eVEK84w75g/aOHDDWOdvYJh0hxN6Er
         U3/g==
X-Gm-Message-State: AOJu0Yw7Rl+1Trzk8qWu3saGObqcJrPJOI0EUEJViEWCuSMDyjl60uW5
	krJjlPoYCM8D0AB/CslPoBIwDFWC3I/Hl8dCrNPJVW+XaxbzxSHsGXwxH5m9aYinBFU=
X-Gm-Gg: ASbGnctlatEPXAZhjjkERTK8G8M7qCpU7rYEFG+hSPlcP3pRAD7uYKAlj/5oFgzYENA
	M34Jp6JVqc6RDq1xmw/sVBAoBKW/4+LoZxm644lsmGVQGY+CTuVn5KTusF9vRwjTM8He2pGDm7+
	RWR3jf7ruBZghbifW8NkbI1kQci05d/MgnwbQlfSxNwllR0F5KARoqv9dFj8nm6NENEXldXmwJ7
	snsUQpsBZxVJ4jFH5jnyDAsDHtyxfiVhHE6kexqjdmdWkWo9i3qCldidMX+ZcoYzlmg4/NtmwuF
	b/w2qx/MPrgiKHbvsZdmtDWeQoRPd94/tbjNjK2pBCZ/XM1fSSq+a+v6uaCKkx3nj4aSHBhNKfF
	blyNan/Qu4MaIMmnEKoARfHxBpN0uXcBOsOkE7gQEVxcPVLVu5x/F5vuypII1E2guY4ei9sp5Kx
	FrCkMcUWqh
X-Google-Smtp-Source: AGHT+IH3u+Jo/a1rSnMJ8O+xKMx2AU7d0v7dIKdjvmcmWczT9CnuxrOhb6LnW4yHVz2TGH9EN1CbSA==
X-Received: by 2002:a17:90b:1d03:b0:328:a89:71b8 with SMTP id 98e67ed59e1d1-328156e1238mr13146811a91.30.1756786081968;
        Mon, 01 Sep 2025 21:08:01 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd006c340sm10931232a12.1.2025.09.01.21.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 21:08:01 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1utIJK-0000000E9YF-1kgq;
	Tue, 02 Sep 2025 14:07:58 +1000
Date: Tue, 2 Sep 2025 14:07:58 +1000
From: Dave Chinner <david@fromorbit.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, brauner@kernel.org,
	viro@zeniv.linux.org.uk, amir73il@gmail.com
Subject: Re: [PATCH v2 16/54] fs: delete the inode from the LRU list on lookup
Message-ID: <aLZtnqTXEpEBpb7z@dread.disaster.area>
References: <cover.1756222464.git.josef@toxicpanda.com>
 <646d132baae6e5633064645e677dada101681850.1756222465.git.josef@toxicpanda.com>
 <aK980KTSlSViOWXW@dread.disaster.area>
 <20250828114225.GA2848932@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828114225.GA2848932@perftesting>

On Thu, Aug 28, 2025 at 07:42:25AM -0400, Josef Bacik wrote:
> On Thu, Aug 28, 2025 at 07:46:56AM +1000, Dave Chinner wrote:
> > On Tue, Aug 26, 2025 at 11:39:16AM -0400, Josef Bacik wrote:
> > > When we move to holding a full reference on the inode when it is on an
> > > LRU list we need to have a mechanism to re-run the LRU add logic. The
> > > use case for this is btrfs's snapshot delete, we will lookup all the
> > > inodes and try to drop them, but if they're on the LRU we will not call
> > > ->drop_inode() because their refcount will be elevated, so we won't know
> > > that we need to drop the inode.
> > > 
> > > Fix this by simply removing the inode from it's respective LRU list when
> > > we grab a reference to it in a way that we have active users.  This will
> > > ensure that the logic to add the inode to the LRU or drop the inode will
> > > be run on the final iput from the user.
> > > 
> > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > 
> > Have you benchmarked this for scalability?
> > 
> > The whole point of lazy LRU removal was to remove LRU lock
> > contention from the hot lookup path. I suspect that putting the LRU
> > locks back inside the lookup path is going to cause performance
> > regressions...
> > 
> > FWIW, why do we even need the inode LRU anymore?
> > 
> > We certainly don't need it anymore to keep the working set in memory
> > because that's what the dentry cache LRU does (i.e. by pinning a
> > reference to the inode whilst the dentry is active).
> > 
> > And with the introduction of the cached inode list, we don't need
> > the inode LRU to track  unreferenced dirty inodes around whilst
> > they hang out on writeback lists. The inodes on the writeback lists
> > are now referenced and tracked on the cached inode list, so they
> > don't need special hooks in the mm/ code to handle the special
> > transition from "unreferenced writeback" to "unreferenced LRU"
> > anymore, they can just be dropped from the cached inode list....
> > 
> > So rather than jumping through hoops to maintain an LRU we likely
> > don't actually need and is likely to re-introduce old scalability
> > issues, why not remove it completely?
> 
> That's next on the list, but we're already at 54 patches.  This won't be a hot
> path, we're not going to consistently find inodes on the LRU to remove.

IME, there are some workloads that hit the inode cache hard
(typically anything that has a large set of working inodes and
memory pressure is causing reclaim to run all the time).  In these
cases, we are finding inodes on the inode cache it's because we've
missed the dentry cache (due to reclaim) and so the inode we hit is
unreferenced and on the LRU. i.e. if we don't have lazy LRU removal,
when we hit the inode cache we'll also typically hit the LRU....

> My rough plans are
> 
> 1. Get this series merged.
> 2. Let it bake and see if any issues arise.
> 3. Remove the inode LRU completely.
> 4. Remove the i_hash and use an xarray for inode lookups.
>
> The inode LRU removal is going to be a big change,

When I last looked at it, it wasn't a particularly big code change
at all. It was just that mm/ depended on the LRU existing that
prevented it from being easily removable. You've addressed that
dependency by adding the cached inode list for inodes with populated
address spaces....

> and I want it to be separate
> from this work from the LRU work in case we find that we do really need the LRU.
> If that turns out to be the case then we can revisit if this is a scalability
> issue.  Thanks,

Understood, but I would prefer to do that the other way around.

i.e. rather than add complexity and potential scalability issues to
the LRU management on the way to removing the LRU at a later date,
we remove the LRU at the earliest possible opportunity.

If we have any sort of perf regression caused by the LRU removal, we
can address those cases via temporary residence on the new cached
inode list...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

