Return-Path: <linux-fsdevel+bounces-30022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B0C984FA3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 03:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70CA31C22C3F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 01:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D89136672;
	Wed, 25 Sep 2024 01:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="2wG9L15t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740A21386B3
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 01:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727226018; cv=none; b=h3lXWkSBURq5mvN/5nNtmRBWOVjHaMl0/P0iB3HrzzqVuYGKD2y5VAuKUvIuaAxjwlZUSbxJ741CECLe9uQSujuUnkea89DmkXTXRA4jkXTeixj5aOKTTn6tOC/HCfaJqjeA1ToPq+Ge4dWimJrGxwclS83EURqGat40jIlNB7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727226018; c=relaxed/simple;
	bh=xYktIkXQ15frF7P5Q3qcWSwJNgJzoKJz+5SWEqQnc/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ab6MkwxUHvkGHXtULfeO2XHz2LyOJINNeW/N9bWL0MH8sl+adURwfbVFcr/DXVcqCymJopVdgZmMqVsoxqHT7/D+tlQDGaAXclgQgjj5Zl77uzyU+kqhjNXqS4srPtxw4pyeVw4kukxD7aYPFXwhoDotSzlIZHd27PH1SwxDM6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=2wG9L15t; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2dee71e47c5so2616049a91.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2024 18:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1727226016; x=1727830816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M9P19Dpz8pYn0b02ZYZ9X2FwfHXZd1aOXbrW9qrvHLk=;
        b=2wG9L15tTOxvrK6jMVP6b+kyz0Z1XArT/rsIiSmUNCvrvwtNNNOfqGbs4DmRz7HjTR
         ZzSIXS8ttfhXaPnFLNMmlsHl8Iuk2MrghAEpEADypaUWdIcGfX43/5v3Nfh5E6KnrC/b
         ZjyghOiduGKJvqSA+e5dwkW+arRkG+1AvjOFMtIV263YpptBKdFwVgY8+BHasbK1GHFF
         Es3iO4zQdUFoYNA1bumJXXggqLIsJSNUTMzCq4NywKKo+v42eQAUL9BZjHYyvcgHtS8i
         fyXJliaLKOKelGUT4AwOXQlA0GX3XBlcCx4GOuDQrWKfRZGuYP8sJQE5PCp641k4VCi5
         nDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727226016; x=1727830816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9P19Dpz8pYn0b02ZYZ9X2FwfHXZd1aOXbrW9qrvHLk=;
        b=CaALXqvoHiHCDDn0KdDHIoJAZkyfzGF6csM5svl8VkESaSVqa4a/4xbS1IVazhMcq6
         OGZY7li4Mwdd94/NGP9E43lT89UwyHROcEcOvT+qrVoSbfAAK7gODY87KXpVXHZQiPK+
         I8TJD8xUMxRfvtIhGtesN9uEvPpc81nQkOGQFK0kbyEbcckpvMzw+DnnFq/DPpG09JGv
         igXl7INbiHTcCeVN3OZInyeovgoHQ+eKDayekTfAWX+HfIJx1U8FKj9Fc3hSAnsOyfp1
         HiAnpWhR4X1IJi3713jwz3j078IxUPub37mcg+ZseMWQ9dL4hTiolNce7scK4dLaNoCt
         DDjg==
X-Forwarded-Encrypted: i=1; AJvYcCVycaON/W5s8ymmTy6WbarSoqPzaA3JtJ0zhMgiiQFCH+Sothh+LycC9V0DTU75GaqiUmupSjaA2LuO61Zq@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4umg3cJLz95DMuzOJfiHnYaimzQcsKuqYhjWmqHELNrRTdqrH
	gpDORODgiXZCCS8wc2no13JIMEiOu3N7TYztNBtSS2nk/rOv8l8UwKy4bQz6LPA=
X-Google-Smtp-Source: AGHT+IEM7TDZzneq8AdP+jj2pLX3nFkKqcakDcc8T3ybOf+A6xVCkRRDIVO4PWWelkRcfh6Fh4H9EQ==
X-Received: by 2002:a17:90b:3144:b0:2d4:bf3:428e with SMTP id 98e67ed59e1d1-2e06afe04cbmr1336970a91.37.1727226015679;
        Tue, 24 Sep 2024 18:00:15 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e1c286csm187676a91.17.2024.09.24.18.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 18:00:14 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1stGO2-009ede-2D;
	Wed, 25 Sep 2024 11:00:10 +1000
Date: Wed, 25 Sep 2024 11:00:10 +1000
From: Dave Chinner <david@fromorbit.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Subject: Re: [GIT PULL] bcachefs changes for 6.12-rc1
Message-ID: <ZvNgmoKgWF0TBXP8@dread.disaster.area>
References: <dtolpfivc4fvdfbqgmljygycyqfqoranpsjty4sle7ouydycez@aw7v34oibdhm>
 <CAHk-=whQTx4xmWp9nGiFofSC-T0U_zfZ9L8yt9mG5Qvx8w=_RQ@mail.gmail.com>
 <6vizzdoktqzzkyyvxqupr6jgzqcd4cclc24pujgx53irxtsy4h@lzevj646ccmg>
 <ZvIHUL+3iO3ZXtw7@dread.disaster.area>
 <CAHk-=whbD0zwn-0RMNdgAw-8wjVJFQh4o_hGqffazAiW7DwXSQ@mail.gmail.com>
 <74sgzrvtnry4wganaatcmxdsfwauv6r33qggxo27yvricrzxvq@77knsf6cfftl>
 <ZvIzNlIPX4Dt8t6L@dread.disaster.area>
 <dia6l34faugmuwmgpyvpeeppqjwmv2qhhvu57nrerc34qknwlo@ltwkoy7pstrm>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dia6l34faugmuwmgpyvpeeppqjwmv2qhhvu57nrerc34qknwlo@ltwkoy7pstrm>

On Mon, Sep 23, 2024 at 11:47:54PM -0400, Kent Overstreet wrote:
> On Tue, Sep 24, 2024 at 01:34:14PM GMT, Dave Chinner wrote:
> > On Mon, Sep 23, 2024 at 10:55:57PM -0400, Kent Overstreet wrote:
> > > But stat/statx always pulls into the vfs inode cache, and that's likely
> > > worth fixing.
> > 
> > No, let's not even consider going there.
> > 
> > Unlike most people, old time XFS developers have direct experience
> > with the problems that "uncached" inode access for stat purposes.
> > 
> > XFS has had the bulkstat API for a long, long time (i.e. since 1998
> > on Irix). When it was first implemented on Irix, it was VFS cache
> > coherent. But in the early 2000s, that caused problems with HSMs
> > needing to scan billions inodes indexing petabytes of stored data
> > with certain SLA guarantees (i.e. needing to scan at least a million
> > inodes a second).  The CPU overhead of cache instantiation and
> > teardown was too great to meet those performance targets on 500MHz
> > MIPS CPUs.
> > 
> > So we converted bulkstat to run directly out of the XFS buffer cache
> > (i.e. uncached from the perspective of the VFS). This reduced the
> > CPU over per-inode substantially, allowing bulkstat rates to
> > increase by a factor of 10. However, it introduced all sorts of
> > coherency problems between cached inode state vs what was stored in
> > the buffer cache. It was basically O_DIRECT for stat() and, as you'd
> > expect from that description, the coherency problems were horrible.
> > Detecting iallocated-but-not-yet-updated and
> > unlinked-but-not-yet-freed inodes were particularly consistent
> > sources of issues.
> > 
> > The only way to fix these coherency problems was to check the inode
> > cache for a resident inode first, which basically defeated the
> > entire purpose of bypassing the VFS cache in the first place.
> 
> Eh? Of course it'd have to be coherent, but just checking if an inode is
> present in the VFS cache is what, 1-2 cache misses? Depending on hash
> table fill factor...

Sure, when there is no contention and you have CPU to spare. But the
moment the lookup hits contention problems (i.e. we are exceeding
the cache lookup scalability capability), we are straight back to
running a VFS cache speed instead of uncached speed.

IOWs, needing to perform the cache lookup defeated the purpose of
using uncached lookups to avoid the cache scalabilty problems.

Keep in mind that not having a referenced inode opens up the code to
things like pre-emption races. i.e. a cache miss doesn't prevent
the current task from being preempted before it reads the inode
information into the user buffer. The VFS inode could bei
instantiated and modified before the uncached access runs again and
pulls stale information from the underlying buffer and returns that
to userspace.

Those were the sorts of problems we continually had with using low
level inode information for stat operations vs using the up-to-date
VFS inode state....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

