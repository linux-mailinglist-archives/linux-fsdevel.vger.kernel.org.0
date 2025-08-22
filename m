Return-Path: <linux-fsdevel+bounces-58804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC52B319C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 15:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FB82AE1A17
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 13:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8302FFDEF;
	Fri, 22 Aug 2025 13:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="dgEwETev"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FAB26D4CE
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869452; cv=none; b=qVMkz6sRyWN1AtHkinRh6xHLTE9ArLyaROIAVr/pGoME5OfQ6zF1XY8petTkyL5Lddne4gtJi0NF+xFQdGY+wWFc8f/6WXM4MczDsLEZ6ES49MC19h9kIGFxSq9E7THJgWM8VR49TEQQ0Ob0dEqcGNblSi6ETlGwyD+AHGaIIf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869452; c=relaxed/simple;
	bh=vawMYpL5MnTwScaPKytLvoy2AK4jNtOc6mZjESzBhco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LqqK+9XGeIWGrANZe5loJ3mBjz3mobfwUtM+NhDb/sdluYJJ6rR+jhgZiWqtY5/tQ7TQd2C783yCyzrDGcDDadVsLHqTuVm9TFuCO35l90DhOtFHiJL5ms1iAI7+NWXZnOzVC3LNDGwdSvjZtOpU12sUotsPs5SB/aWgVChDLhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=dgEwETev; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71fab75fc97so19035797b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 06:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755869449; x=1756474249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ysGi6IoThbqflSFP0+quOx+igxfKxKnr1laLr0pAEm0=;
        b=dgEwETevblf20PEHJ5z0NjoehlVqLOzlFv1mhAZz9rz41QlPXxXmeqR8LfrYq8+cl8
         YAlUT/A1joboXNNyG+bevf0BSw0PhQprfZm8L7zjcLPag8O64rlIPRqBb0Kdqp7fxJ8z
         BrMRQH+h/brLImw3FLt0nR4UEYTGUc4ZTBR5rYXqIFOPQaDyyYq/WTD/p9yNvDLmZzCz
         sFubt8WzUEI88h3QAIkxvoGFpBRDuTxH/PNiV8jxUJNuJwk11sl/k0apc/BDp343sPZ6
         OFploYZUk8R4UymOOKt8xJxin8Dz7eGSFLjnvkYbf0VUFuXujfwEw+VVnfQ7+a6m0j71
         s/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755869449; x=1756474249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysGi6IoThbqflSFP0+quOx+igxfKxKnr1laLr0pAEm0=;
        b=c5xgPjHlXnaSRVzBaekNIkn8co9KvEJIWkO+ZYkfpML/m0Wi++L1IAvD03mLA+NQCK
         +NWlSOhgBMVFYErpLVqLvZUXXJZvX+hbVgkH6g03q2IyS2iE4U05PMpFSGAhLANfgDsp
         urctqDCwNc1EBT3cC+ILIQlMHNQQesJhc8+FeUMbECSeOY9aOJrsWKMO0V7A7RCvBrp8
         L2AeiH2IviO7jGc/zFaGXCknIqOEE+KJ0WVmKBnIQcOwNacvGttCSVi2ivu6LRTZGxX+
         2sh9r6vbqFayU5dau8rsVtzCvALBuMZfrSK2F9VfBAH7LhRdwCwXuFj+5s7lFxqPZfdC
         haOg==
X-Gm-Message-State: AOJu0Yx4dUAmrShsmFxT/nJSO5i6AWZepOQO+gbYYUC72addIC378lap
	bsTRh8JOwSjgb+o6a4m6L3jiGzo7HMcuEJHn1P9m8yX5Vpb6d5eaaX8ofxFKgsOELcc=
X-Gm-Gg: ASbGncs5p2WLSG9Mx6w+PGqLSbjR9QVB0d5I2BfN4rGR1YboCCz7Od3rAcw2kkLnTHO
	BQxGFdkRQcxGZx0HAZBP0MEfhhVSNdFO+352kpW02qVKRPUft4qNKAEqwPRB5HZpQnuh6EVUtCM
	FDcuYTCld+SxHPjPmz7pz6INfD3Ed7ln7PV8f8AXqIFd+PM4etXA07DMGXP6xKBuKVvZXYgYFOJ
	+rbQUBMnjRxKslcFgyHSH+92cnbIV7GsWFp01GLkD+bqKxJ7MptuNAQkV1LO02xZmniceGnjYEk
	lCYbrQRSxyc7buzM6qzpfZViAYPoApPxDfdlBRDKYaTZM29/ki7aIx0YE9lVLSpWwlWXqhAFDVW
	meiruXIqK3K7dEnGskyR7iBtuOIcMQj4SZaURjjpeJ+mfGipTdE+fV35lH3qisUN5An+MWA==
X-Google-Smtp-Source: AGHT+IE7d8mBxJn5ZH3yrL6qHVvJSHezvTY0uEOPyAXgDu4q6zdL0lvpLU/s1EK3p0Klfj6p9sFXwA==
X-Received: by 2002:a05:690c:6286:b0:71e:727d:7dc5 with SMTP id 00721157ae682-71fdc406db2mr34431647b3.36.1755869449027;
        Fri, 22 Aug 2025 06:30:49 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e70c426aasm48695597b3.29.2025.08.22.06.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:30:48 -0700 (PDT)
Date: Fri, 22 Aug 2025 09:30:47 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 00/50] fs: rework inode reference counting
Message-ID: <20250822133047.GA927384@perftesting>
References: <cover.1755806649.git.josef@toxicpanda.com>
 <20250822-monster-ganztags-cc8039dc09db@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822-monster-ganztags-cc8039dc09db@brauner>

On Fri, Aug 22, 2025 at 12:51:29PM +0200, Christian Brauner wrote:
> On Thu, Aug 21, 2025 at 04:18:11PM -0400, Josef Bacik wrote:
> > Hello,
> > 
> > This series is the first part of a larger body of work geared towards solving a
> > variety of scalability issues in the VFS.
> > 
> > We have historically had a variety of foot-guns related to inode freeing.  We
> > have I_WILL_FREE and I_FREEING flags that indicated when the inode was in the
> > different stages of being reclaimed.  This lead to confusion, and bugs in cases
> > where one was checked but the other wasn't.  Additionally, it's frankly
> > confusing to have both of these flags and to deal with them in practice.
> 
> Agreed.
> 
> > However, this exists because we have an odd behavior with inodes, we allow them
> > to have a 0 reference count and still be usable. This again is a pretty unfun
> > footgun, because generally speaking we want reference counts to be meaningful.
> 
> Agreed.
> 
> > The problem with the way we reference inodes is the final iput(). The majority
> > of file systems do their final truncate of a unlinked inode in their
> > ->evict_inode() callback, which happens when the inode is actually being
> > evicted. This can be a long process for large inodes, and thus isn't safe to
> > happen in a variety of contexts. Btrfs, for example, has an entire delayed iput
> > infrastructure to make sure that we do not do the final iput() in a dangerous
> > context. We cannot expand the use of this reference count to all the places the
> > inode is used, because there are cases where we would need to iput() in an IRQ
> > context  (end folio writeback) or other unsafe context, which is not allowed.
> > 
> > To that end, resolve this by introducing a new i_obj_count reference count. This
> > will be used to control when we can actually free the inode. We then can use
> > this reference count in all the places where we may reference the inode. This
> > removes another huge footgun, having ways to access the inode itself without
> > having an actual reference to it. The writeback code is one of the main places
> > where we see this. Inodes end up on all sorts of lists here without a proper
> > reference count. This allows us to protect the inode from being freed by giving
> > this an other code mechanisms to protect their access to the inode.
> > 
> > With this we can separate the concept of the inode being usable, and the inode
> > being freed.  The next part of the patch series is to stop allowing for inodes
> > to have an i_count of 0 and still be viable.  This comes with some warts. The
> > biggest wart is now if we choose to cache inodes in the LRU list we have to
> > remove the inode from the LRU list if we access it once it's on the LRU list.
> > This will result in more contention on the lru list lock, but in practice we
> > rarely have inodes that do not have a dentry, and if we do that inode is not
> > long for this world.
> > 
> > With not allowing inodes to hit a refcount of 0, we can take advantage of that
> > common pattern of using refcount_inc_not_zero() in all of the lockless places
> > where we do inode lookup in cache.  From there we can change all the users who
> > check I_WILL_FREE or I_FREEING to simply check the i_count. If it is 0 then they
> > aren't allowed to do their work, othrwise they can proceed as normal.
> > 
> > With all of that in place we can finally remove these two flags.
> > 
> > This is a large series, but it is mostly mechanical. I've kept the patches very
> > small, to make it easy to review and logic about each change. I have run this
> > through fstests for btrfs and ext4, xfs is currently going. I wanted to get this
> > out for review to make sure this big design changes are reasonable to everybody.
> > 
> > The series is based on vfs/vfs.all branch, which is based on 6.9-rc1. Thanks,
> 
> I so hope you meant 6.17-rc1 because otherwise I did something very very
> wrong. :)

Stupid AI hallucination...

Josef

