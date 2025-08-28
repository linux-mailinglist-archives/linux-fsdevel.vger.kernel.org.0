Return-Path: <linux-fsdevel+bounces-59482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D96B39BD4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 13:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA5A87BA5E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 11:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE4430E840;
	Thu, 28 Aug 2025 11:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="mLPKNi9J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95B330DEDC
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 11:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756381352; cv=none; b=Dbjz3sRL52K7dONfQ618PCrf3LevqA6Wznqg//ib0eJ9UTGFIc/yov2XBirpRbdQzMmnGORbnIo28HaTJcMuaRogHckFvFpgA9RxszTX7FBD+KM4U6ly3XnOarHYn0KSpgSYWquKjl6JUFYNzH0k1b8Fu8ce5FgIoecSecc6lRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756381352; c=relaxed/simple;
	bh=pXGKWFVyVsRQelEkZGduol4s3jmhYKFx2akcAoEt+EU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eP6fPXH42qSfJepE29cpz+Pk484UgCeA6+g39le+Az5uXXb3HqetZLU7JxnTZkwCSAzy5lcs172U5ZV2NrpoLCUmxbTlm0lqfjAvmX52RYTZsosVFqNON5vk7Z52CEiQcVz7q4F5/zZyOxXfi+nlQc7AEbGylu+BldvVrFl9fT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=mLPKNi9J; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e96f14a6f2aso494967276.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 04:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1756381348; x=1756986148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g2mtr4MahWN1CaeWoRERBafDml3LAYcHAVZcXe/+ugQ=;
        b=mLPKNi9J5ZHe7J0F5ExCMHZi80W3+MBpqsLUqPcu7z8vLe7wAPSnR5y/plrVPe0q9w
         FGiFGR4045PqryGPrpcMAhx9JrbkkMovLSGxymx7id3DvG5ZBuQYNF73/NxEE1Sm/NJo
         ogqfMyX560Tga3w9aFBZamZzjX2y8BJ5+X4xzxRcEnQ0uEpnIZIiFxJ8yVVy2dL+uQ1J
         aj7zwqJ1zFh0RYk8GntjbpclGFWKYlqmzEzqMDibuEbcuoPbFwMG/Q+WeijHPI/0fqmV
         QThshVmhegEeJxXLVLFWX0bI03bHfJlZqSWDacjywovrKOLPcc3TR1f1XEtSMIMzNm8L
         DItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756381348; x=1756986148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2mtr4MahWN1CaeWoRERBafDml3LAYcHAVZcXe/+ugQ=;
        b=Ufqp/6FJYfV7d43qkNkjdqdwoOd4HR/qiKgceq/prCkxAMGTlLpr1vPem7pEjBTUvy
         Iky1J9+W5iZCBmzdPk1udiwd1mFEPiPNf0DyCCfLABdF8QcZU9qGrTHDvBeGbLXxWB0U
         zNXZkt0QnppjpI6JZbENTCGu4uZJ/LmGSvQ6UmPt62gx2S0iwJRDFsNKmkV9f1S5wc5F
         HdsziKOmw2pgCuv2hck/wZNwqgV9+dxfJI/zxv2lapRoDqk9n0KEXVreiDayW3u3vxF1
         J6qsMGCMSU0N02/xuJxeOFiKlw1MpzAyAqI8LlQ8+E/pCZQG9dHWlpm/Phj6rTuR8evE
         nZ6g==
X-Gm-Message-State: AOJu0YwMWlnYy6PgIiQHnkCsuNJJOw+dpWWHl9BliYqxyjxAz7Xj1mx2
	pzxjkdovInojUWahJ7eN832CxHMcH4cuVw8sZ1KjC1pxwJPzSyTLVbE9DcEZRd3LaMg=
X-Gm-Gg: ASbGnctlxEjLIyeJ+6KUPBUtH56offtm0zHmp04IfQolf6DA1EOYojz82+7iuLa8AHS
	JOCF7lwr5BDaWQd9vZPg8C5zOGgbo+iWY+GTiHExlBPPxJjcelsU0dQfOAZL5GtEQI2gfeUfQ1r
	xe3FXbx8RZkrHUFUsDWbtLLvvsRUAi90s26dPJnofPhHM5bvy1nupsxO91n85OKjRhhojpVWK4F
	sDUBw4drtGwFLjnR4Mjf+MACmYSPOw9KIvG3ioMS68ccooRVp9rnByVv0onyDvfA+Iy7dS2eNGA
	Q2SDTipa5w3eSsNdqO4FL4CyFHk8arfpUYTGnbr5jj/FabkMzMS3uVO20VkX4FFnN4s7g3903rh
	pk81pnYiQzK7T2Vsi3ulC/wESQnux7TU4W1ZLvTdldQQEAKdO3Ij+8pzfWn8=
X-Google-Smtp-Source: AGHT+IHzU9aYDYU3YAH3hfgvOIUS16goFJso3B9bUXGDolR4NrbvimCaMQ06YKvjMpun0m8FzBSWLA==
X-Received: by 2002:a05:6902:c06:b0:e96:f9fe:2f31 with SMTP id 3f1490d57ef6-e96f9fe30f7mr5099573276.42.1756381347519;
        Thu, 28 Aug 2025 04:42:27 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff17093e9sm38418147b3.7.2025.08.28.04.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 04:42:26 -0700 (PDT)
Date: Thu, 28 Aug 2025 07:42:25 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, brauner@kernel.org,
	viro@zeniv.linux.org.uk, amir73il@gmail.com
Subject: Re: [PATCH v2 16/54] fs: delete the inode from the LRU list on lookup
Message-ID: <20250828114225.GA2848932@perftesting>
References: <cover.1756222464.git.josef@toxicpanda.com>
 <646d132baae6e5633064645e677dada101681850.1756222465.git.josef@toxicpanda.com>
 <aK980KTSlSViOWXW@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK980KTSlSViOWXW@dread.disaster.area>

On Thu, Aug 28, 2025 at 07:46:56AM +1000, Dave Chinner wrote:
> On Tue, Aug 26, 2025 at 11:39:16AM -0400, Josef Bacik wrote:
> > When we move to holding a full reference on the inode when it is on an
> > LRU list we need to have a mechanism to re-run the LRU add logic. The
> > use case for this is btrfs's snapshot delete, we will lookup all the
> > inodes and try to drop them, but if they're on the LRU we will not call
> > ->drop_inode() because their refcount will be elevated, so we won't know
> > that we need to drop the inode.
> > 
> > Fix this by simply removing the inode from it's respective LRU list when
> > we grab a reference to it in a way that we have active users.  This will
> > ensure that the logic to add the inode to the LRU or drop the inode will
> > be run on the final iput from the user.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> Have you benchmarked this for scalability?
> 
> The whole point of lazy LRU removal was to remove LRU lock
> contention from the hot lookup path. I suspect that putting the LRU
> locks back inside the lookup path is going to cause performance
> regressions...
> 
> FWIW, why do we even need the inode LRU anymore?
> 
> We certainly don't need it anymore to keep the working set in memory
> because that's what the dentry cache LRU does (i.e. by pinning a
> reference to the inode whilst the dentry is active).
> 
> And with the introduction of the cached inode list, we don't need
> the inode LRU to track  unreferenced dirty inodes around whilst
> they hang out on writeback lists. The inodes on the writeback lists
> are now referenced and tracked on the cached inode list, so they
> don't need special hooks in the mm/ code to handle the special
> transition from "unreferenced writeback" to "unreferenced LRU"
> anymore, they can just be dropped from the cached inode list....
> 
> So rather than jumping through hoops to maintain an LRU we likely
> don't actually need and is likely to re-introduce old scalability
> issues, why not remove it completely?

That's next on the list, but we're already at 54 patches.  This won't be a hot
path, we're not going to consistently find inodes on the LRU to remove.

My rough plans are

1. Get this series merged.
2. Let it bake and see if any issues arise.
3. Remove the inode LRU completely.
4. Remove the i_hash and use an xarray for inode lookups.

The inode LRU removal is going to be a big change, and I want it to be separate
from this work from the LRU work in case we find that we do really need the LRU.
If that turns out to be the case then we can revisit if this is a scalability
issue.  Thanks,

Josef

