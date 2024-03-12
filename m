Return-Path: <linux-fsdevel+bounces-14248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A56FB879DD8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 22:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AE802822DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 21:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E3F143C41;
	Tue, 12 Mar 2024 21:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="tk5A7Rny"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103B114372D
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Mar 2024 21:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710279959; cv=none; b=rZU/AD4Jc1jN5hYut7hWr/uqEDEgJYlnTc4LuSsRKGKLxPqKNm+BBIZX4vosMRcSyvQnZrRErLJ9tz6IE7IWPOiDDyiObH37rsuGqxmGH8QmIenPEnUnEbnVk7CN2LnoUOUHMTCI5UxQ2sGComU59xdz7/MJWRz7Q11v2sCvTPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710279959; c=relaxed/simple;
	bh=f3eY7jujqWw1XvgJDeDiiJy79+k+9wTdds8Oes7ISpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZpDHyEXbbgqQbFXaLyqOtK6GHJAFAcGq4RIsqKG5gJGcwBdtatfJlPytVdNHAYzG7z3qpg40A7c00KN5Z+05m1O9ioYgqL1Md8FJAVDmgn7aUmDfwksFEJ9FHrj+tjfjkF9Xkagh7ke3AlHTzEjxPqoF/oWXBlcFgkXlKg6omk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=tk5A7Rny; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e6ac00616cso968484b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Mar 2024 14:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1710279957; x=1710884757; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y58pehAP/4Id091dfYV3xPG49yNSzXT1cbd/+tKFRVI=;
        b=tk5A7Rny4pTNY6A2lqqFDM5XIPPC33rVp+NORNXpxTLIPb9Bu0uFDs3HvSr3JNTCTF
         vFawJlQRGzautFrkyT/SLGqtlbSUM5PP57PYYEqMoMF5FjmKgJ13fTR3e9Dil6dDWmc8
         pRFX3DkdsAo7Sl9L2SX/f8AlMaulGRIFEFxliYJWHr6WRORHoZ3lAeV5ckzt6AQL8txi
         zzkLZEw3lJUhCBu5o6NbmpmT59kX61n0BdTw86jzQnUcCRY/69o8uXYfm+vgSHyH9+2m
         gXOD8ugPA5kz1r3OBalksbrLtOy5FqlOsA5+OwK7tMvAhJPPKW5DyQIs6o673pXJBADK
         PdvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710279957; x=1710884757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y58pehAP/4Id091dfYV3xPG49yNSzXT1cbd/+tKFRVI=;
        b=p71/p9cwcv0832oB+3R5iosDbEmL9+ReFYychOeLmfWQWSuoTOuSs4z0fDiSBe+7ND
         jKHYAVmRIr9dz0WQQiHRRqEuvu5GLndGWQFPsHaHpLYmtqi2sPuNy+puNvqqm07yoCcy
         Y0Y8lwT2lGC728e5JJB0nFEX2EgXE4u/JaOcO7QI87IqiOLgyFEi9a0M2HhRlORuXB/R
         aiyJ8UTacgWwLEpm0Mv5R5jDbCqF1DUd1pVIlHa9OQfjW4LzzdNdbNT0Cwegh39uRXHf
         utrnUC4tn8jqscHrbFALvsECVFHsMZyeTMTZwPfNFqxlpu+F7QGO9SI4J6t6hkrexnFc
         Yz9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVPHoGZTC8pbWXrA5uW4OXfqwJT+4Qby+kYR4wrmVvpWiNHmTz1N//qjx1TfkIzvWW2ZhWu4aN9TIeN85XC/R5Zpwbht4OLV7rFoIg2ow==
X-Gm-Message-State: AOJu0YwN8+fzbFM2pQLf1KpIUl2B5EYoVIL4tSVxyBYLVmf/NJ7/m/dO
	b0prtOpqPK0bzBoxVaC+XOxJgnwjtAtkTJLta6Z3fm8b70w+hypVYvBOZNCdBCY=
X-Google-Smtp-Source: AGHT+IFSsvZMEO2cSXuiiGx4Ka26u79YnHGMyHjf5N2wevjeM2cgyFrwVWbQTvO1DKW1p66AYkoDxA==
X-Received: by 2002:a05:6a00:938b:b0:6e6:97b9:1ec3 with SMTP id ka11-20020a056a00938b00b006e697b91ec3mr753409pfb.13.1710279956991;
        Tue, 12 Mar 2024 14:45:56 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-47-118.pa.nsw.optusnet.com.au. [49.179.47.118])
        by smtp.gmail.com with ESMTPSA id y3-20020aa78543000000b006e641fee598sm6799210pfn.141.2024.03.12.14.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 14:45:56 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rk9wX-0014op-2L;
	Wed, 13 Mar 2024 08:45:53 +1100
Date: Wed, 13 Mar 2024 08:45:53 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com, ebiggers@kernel.org
Subject: Re: [PATCH v5 11/24] xfs: add XBF_VERITY_SEEN xfs_buf flag
Message-ID: <ZfDNESXL4bH1Gx1K@dread.disaster.area>
References: <20240304191046.157464-13-aalbersh@redhat.com>
 <20240307224654.GB1927156@frogsfrogsfrogs>
 <ZepxHObVLb3JLCl/@dread.disaster.area>
 <20240308033138.GN6184@frogsfrogsfrogs>
 <20240309162828.GQ1927156@frogsfrogsfrogs>
 <Ze5PsMopkWqZZ1NX@dread.disaster.area>
 <20240311152505.GR1927156@frogsfrogsfrogs>
 <20240312024507.GY1927156@frogsfrogsfrogs>
 <Ze/9rdVsnwyksHmi@dread.disaster.area>
 <20240312200424.GH1927156@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312200424.GH1927156@frogsfrogsfrogs>

On Tue, Mar 12, 2024 at 01:04:24PM -0700, Darrick J. Wong wrote:
> On Tue, Mar 12, 2024 at 06:01:01PM +1100, Dave Chinner wrote:
> > On Mon, Mar 11, 2024 at 07:45:07PM -0700, Darrick J. Wong wrote:
> > > On Mon, Mar 11, 2024 at 08:25:05AM -0700, Darrick J. Wong wrote:
> > > > > But, if a generic blob cache is what it takes to move this forwards,
> > > > > so be it.
> > > > 
> > > > Not necessarily. ;)
> > > 
> > > And here's today's branch, with xfs_blobcache.[ch] removed and a few
> > > more cleanups:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/tag/?h=fsverity-cleanups-6.9_2024-03-11
> > 
> > Walking all the inodes counting all the verity blobs in the shrinker
> > is going to be -expensive-. Shrinkers are run very frequently and
> > with high concurrency under memory pressure by direct reclaim, and
> > every single shrinker execution is going to run that traversal even
> > if it is decided there is nothing that can be shrunk.
> > 
> > IMO, it would be better to keep a count of reclaimable objects
> > either on the inode itself (protected by the xa_lock when
> > adding/removing) to avoid needing to walk the xarray to count the
> > blocks on the inode. Even better would be a counter in the perag or
> > a global percpu counter in the mount of all caches objects. Both of
> > those pretty much remove all the shrinker side counting overhead.
> 
> I went with a global percpu counter, let's see if lockdep/kasan have
> anything to say about my new design. :P
> 
> > Couple of other small things.
> > 
> > - verity shrinker belongs in xfs_verity.c, not xfs_icache.c. It
> >   really has nothing to do with the icache other than calling
> >   xfs_icwalk(). That gets rid of some of the config ifdefs.
> 
> Done.
> 
> > - SHRINK_STOP is what should be returned by the scan when
> >   xfs_verity_shrinker_scan() wants the shrinker to immediately stop,
> >   not LONG_MAX.
> 
> Aha.  Ok, thanks for the tipoff. ;)
> 
> > - In xfs_verity_cache_shrink_scan(), the nr_to_scan is a count of
> >   how many object to try to free, not how many we must free. i.e.
> >   even if we can't free objects, they are still objects that got
> >   scanned and so should decement nr_to_scan...
> 
> <nod>
> 
> Is there any way for ->scan_objects to tell its caller how much memory
> it actually freed? Or does it only know about objects? 

The shrinker infrastructure itself only concerns itself with object
counts. It's almost impossible to balance memory used by slab caches
based on memory used because the objects are of different sizes.

For example, it's easy to acheive a 1:1 balance for dentry objects
and inode objects when shrinking is done by object count. Now try
getting that balance when individual shrinkers and the shrinker
infrastructure don't know the relative size of the objects in caches
it is trying to balance against. For shmem and fuse inode it is 4:1
size difference between a dentry and the inode, XFS inodes is 5:1,
ext4 it's 6:1, etc. Yet they all want the same 1:1 object count
balance with the dentry cache, and the same shrinker implementation
has to manage that...

IOws, there are two key scan values - a control value to tell the
shrinker scan how many objects to scan, and a return value that
tells the shrinker how many objects that specific scan freed.

> I suppose
> "number of bytes freed" wouldn't be that helpful since someone else
> could allocate all the freed memory immediately anyway.

The problem is that there isn't a direct realtionship between
"object freed" and "memory available for allocation" with slab cache
shrinkers. If you look at the back end of SLUB freeing, when it
frees a backing page for a cache because it is now empty (all
objects freed) it calls mm_account_reclaimed_pages() to account for
the page being freed. We do the same in xfs_buf_free_pages() to
account for the fact the object being freed also freed a bunch of
extra pages not directly accounted to the shrinker.

THis is the feedback to the memory reclaim process to determine how
much progress was made by the entire shrinker scan. Memory reclaim
is not actually caring how many objects were freed, it's using
hidden accounting to track how many pages actually got freed by the
overall 'every shrinker scan' call.

IOWs, object count base shrinking makes for realtively simple
cross-cache balance tuning, whilst actual memory freed accounting
by scans is hidden in the background...

In the case of this cache, it might be worthwhile adding something
like this for vmalloc()d objects:

	if (is_vmalloc_addr(ptr))
		mm_account_reclaimed_pages(how_many_pages(ptr))
	kvfree(ptr)

as I think that anything allocated from the SLUB heap by kvmalloc()
is already accounted to reclaim by the SLUB freeing code.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

