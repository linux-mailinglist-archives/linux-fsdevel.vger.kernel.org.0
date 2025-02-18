Return-Path: <linux-fsdevel+bounces-42014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2010A3AB73
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 23:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 857FC174EC0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 22:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028251D47B4;
	Tue, 18 Feb 2025 22:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="xWAWdJIy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AA91D8E07
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 22:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739916309; cv=none; b=kmJdbmKZDdfV5L9CJB2Iu7yoDH9bjMToazyzXQpfj4NnqDSmlNoDqL/q8aoFn8Q8Pq3w5f1fwelonOSuVewLUisjM0C/bD4yFobJlYzIKge3RI8c6ky3oldsC4kgCMTPe0f+aAJq5nathbw1OELJ+ZlzzXAJL/48Xywv5y305SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739916309; c=relaxed/simple;
	bh=b6hloGU1rBuA53x0sVlhq4f+c+PpNZ0TB10ziK163Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gdco6UwI40ek2d3MOc5a2MoWI1LU8ounjqgkZn6FMn3+JoFPU0tppnnJSHU3rC37vRqNNCkMW0ReI1pUOx7dCEUxz0b56tjaW2DBNUWJX9D9371Hc0uTnPoicADXDWGL1Tt0SgGczoeg1VJf7/GcrNd9glMHlwwd6w5wcqC88P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=xWAWdJIy; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-220c92c857aso4346655ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 14:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1739916307; x=1740521107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nag61ie4gTMr5LfKPoMEyRlLePdsRV9vHTySwK445qc=;
        b=xWAWdJIyNqcmq76ryDpl9a38f+ur0IdYgVZlxS95DE3vKXRMtxWm9hA3qqY0xXNuZn
         YA01LQHI81yFMYqQTbm564zoD74ECqQGUGhlsjL8w28AcFmvCCE5wfhEY6E2/9j2BzP5
         riIoxWEKP3YjIMHHDytF9lPZ7e85+BhfjWn6akm+3uIr4tCfpfwmJizsVADwUB8ERc7m
         q7oKkRQzF55nsCxPhIas/CBTSHhI8ZgsfMvdQ1EE8s6JVSAYUCSt3AmbMLLS52iTm8/A
         3PGqEURY0o9QVRzBQuv4pXieKT9lROaUv2aS1w9yKLIMy+fc6tFJf0q4YoCZYKVCCUGP
         mJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739916307; x=1740521107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nag61ie4gTMr5LfKPoMEyRlLePdsRV9vHTySwK445qc=;
        b=WBVS6ilGJbcmP6voi7COEz2kv8FGejItqDsbSsAU32WBl02A/N1j5WT8fEv8E5YMOp
         rZn9jMVuZbLIEvo4U7Uk7sTouEzWUVsRaLkb+sYZ71xxvWaS9clWJzE5/6lTwSVmVYGL
         yiCuX410hmEZQJcD6/DUYpxx9G2tm7mnhMyapFUaeAIB3Pz5kZbpXeKcwLppcOzc6mia
         mLk/OkF5S3r4wIEQZ1eqza4bBHtncpP3l3mcdbqilQttINjD/0KpewgLogzdYhGMC/BS
         gSR2AfiMFxZnvwCVYD3xe70CUbz5E+/YqC2TUljvuLmGfRSq1WSLOZrSCjBRdyV8jK9n
         a60w==
X-Forwarded-Encrypted: i=1; AJvYcCWTRmtBpAnNdnCzkyhijEVl7bziztBoBa1L2z6eGGsKsE0+jGWOZc+hwqYdOfK6FwZVOgLBeFJmhcEFVtL2@vger.kernel.org
X-Gm-Message-State: AOJu0YyB/PQLm4H/0b/+r6nCOu1izmDrf7/wewI7bscjbqINlwc9u+Ah
	KDApdXd4v0VxSoD7hStahPu3IswqtiaKy7AeqP+bS4DUCTuCg3auf/RcmOc3T04=
X-Gm-Gg: ASbGncv/K6DseMlTPBMJiXymmCAzHc7f0FjYrp12gyi5RqNNZK12IHWsar29jZhG7x6
	+8JU5On7bAfZWnQYFYlMvdYJgkiqVsd0rWU2cSmGzM+2gVlKcUMYJQpkfav0tt8ZExfK26zDbdr
	9P4sFJ5yVHcZ+8hgssa/cCOzoIbcEOf0COMO4paQJc3foa9LpbRBtkNdGBw/xADAz8C2a7wYPuw
	6dsuMN4dU+MKTu+drP3NaaIZorRxHPhIjO8+OXJp7seXy8RYLpCbWC9TBGXArq7NecHW8xkVQys
	SxYOxeKxfxA4IFbVsB+cqxp6Quj1YDVCoYYDpuw7YOKKKIkuQAkfxJH0FIygWal5kN8=
X-Google-Smtp-Source: AGHT+IGvkvRLNTlfKTGNQYSAZlUgcJ+QFlAmcpZNTtHnSjPODxm9Rh5H6HhzoPku3AF2NPsfJ1c0ug==
X-Received: by 2002:a17:902:eccb:b0:215:58be:3349 with SMTP id d9443c01a7336-2216eeb0aaemr23278175ad.14.1739916306994;
        Tue, 18 Feb 2025 14:05:06 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556d111sm92826905ad.169.2025.02.18.14.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 14:05:06 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tkViB-00000002yp6-3iiV;
	Wed, 19 Feb 2025 09:05:03 +1100
Date: Wed, 19 Feb 2025 09:05:03 +1100
From: Dave Chinner <david@fromorbit.com>
To: Luis Henriques <luis@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Matt Harvey <mharvey@jumptrading.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Valentin Volkl <valentin.volkl@cern.ch>,
	Laura Promberger <laura.promberger@cern.ch>
Subject: Re: [PATCH v6 2/2] fuse: add new function to invalidate cache for
 all inodes
Message-ID: <Z7UED8Gh7Uo-Yj6K@dread.disaster.area>
References: <20250217133228.24405-1-luis@igalia.com>
 <20250217133228.24405-3-luis@igalia.com>
 <Z7PaimnCjbGMi6EQ@dread.disaster.area>
 <CAJfpegszFjRFnnPbetBJrHiW_yCO1mFOpuzp30CCZUnDZWQxqg@mail.gmail.com>
 <87r03v8t72.fsf@igalia.com>
 <CAJfpegu51xNUKURj5rKSM5-SYZ6pn-+ZCH0d-g6PZ8vBQYsUSQ@mail.gmail.com>
 <87frkb8o94.fsf@igalia.com>
 <CAJfpegsThcFwhKb9XA3WWBXY_m=_0pRF+FZF+vxAxe3RbZ_c3A@mail.gmail.com>
 <87tt8r6s3e.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tt8r6s3e.fsf@igalia.com>

On Tue, Feb 18, 2025 at 06:11:17PM +0000, Luis Henriques wrote:
> On Tue, Feb 18 2025, Miklos Szeredi wrote:
> 
> > On Tue, 18 Feb 2025 at 12:51, Luis Henriques <luis@igalia.com> wrote:
> >>
> >> On Tue, Feb 18 2025, Miklos Szeredi wrote:
> >>
> >> > On Tue, 18 Feb 2025 at 11:04, Luis Henriques <luis@igalia.com> wrote:
> >> >
> >> >> The problem I'm trying to solve is that, if a filesystem wants to ask the
> >> >> kernel to get rid of all inodes, it has to request the kernel to forget
> >> >> each one, individually.  The specific filesystem I'm looking at is CVMFS,
> >> >> which is a read-only filesystem that needs to be able to update the full
> >> >> set of filesystem objects when a new generation snapshot becomes
> >> >> available.
> >> >
> >> > Yeah, we talked about this use case.  As I remember there was a
> >> > proposal to set an epoch, marking all objects for "revalidate needed",
> >> > which I think is a better solution to the CVMFS problem, than just
> >> > getting rid of unused objects.
> >>
> >> OK, so I think I'm missing some context here.  And, obviously, I also miss
> >> some more knowledge on the filesystem itself.  But, if I understand it
> >> correctly, the concept of 'inode' in CVMFS is very loose: when a new
> >> snapshot generation is available (you mentioned 'epoch', which is, I
> >> guess, the same thing) the inodes are all renewed -- the inode numbers
> >> aren't kept between generations/epochs.
> >>
> >> Do you have any links for such discussions, or any details on how this
> >> proposal is being implemented?  This would probably be done mostly in
> >> user-space I guess, but it would still need a way to get rid of the unused
> >> inodes from old snapshots, right?  (inodes from old snapshots still in use
> >> would obvious be kept aroud).
> >
> > I don't have links.  Adding Valentin Volkl and Laura Promberger to the
> > Cc list, maybe they can help with clarification.
> >
> > As far as I understand it would work by incrementing fc->epoch on
> > FUSE_INVALIDATE_ALL. When an object is looked up/created the current
> > epoch is copied to e.g. dentry->d_time.  fuse_dentry_revalidate() then
> > compares d_time with fc->epoch and forces an invalidate on mismatch.
> 
> OK, so hopefully Valentin or Laura will be able to help providing some
> more details.  But, from your description, we would still require this
> FUSE_INVALIDATE_ALL operation to exist in order to increment the epoch.
> And this new operation could do that *and* also already invalidate those
> unused objects.

I think you are still looking at this from the wrong direction.

Invalidation is -not the operation- that is being requested. The
CVMFS fuse server needs to update some global state in the kernel
side fuse mount (i.e. the snapshot ID/epoch), and the need to evict
cached inodes from previous IDs is a CVMFS implementation
optimisation related to changing the global state.

> > Only problem with this is that it seems very CVMFS specific, but I
> > guess so is your proposal.
> >
> > Implementing the LRU purge is more generally useful, but I'm not sure
> > if that helps CVMFS, since it would only get rid of unused objects.
> 
> The LRU inodes purge can indeed work for me as well, because my patch is
> also only getting rid of unused objects, right?  Any inode still being
> referenced will be kept around.
> 
> So, based on your reply, let me try to summarize a possible alternative
> solution, that I think would be useful for CVMFS but also generic enough
> for other filesystems:
> 
> - Add a new operation FUSE_INVAL_LRU_INODES, which would get rid of, at
>   most, 'N' unused inodes.
>
> - This operation would have an argument 'N' with the maximum number of
>   inodes to invalidate.
>
> - In addition, it would also increment this new fuse_connection attribute
>   'epoch', to be used in the dentry revalidation as you suggested above

As per above: invalidation is an implementation optimisation for the
CVMFS epoch update. Invalidation, OTOH, does not imply that any fuse
mount/connector global state (e.g. the epoch) needs to change...

ii.e. the operation should be FUSE_UPDATE_EPOCH, not
FUSE_INVAL_LRU_INODES...

> 
> - This 'N' could also be set to a pre-#define'ed value that would mean
>   *all* (unused) inodes.

Saying "only invalidate N inodes" makes no sense to me - it is
fundamentally impossible for userspace to get right. Either the
epoch update should evict all unreferenced inodes immediately, or it
should leave them all behind to be purged by memory pressure or
other periodic garbage collection mechanisms.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

