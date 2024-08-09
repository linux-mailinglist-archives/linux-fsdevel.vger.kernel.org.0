Return-Path: <linux-fsdevel+bounces-25498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AFE94C890
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 04:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57A9DB22EED
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 02:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E0D179A7;
	Fri,  9 Aug 2024 02:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="J0a+2ghW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3714417591
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Aug 2024 02:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723170660; cv=none; b=P/nDrOAGOKhwaR2QkwvnhLhOwT/sn5Q5gPvKMWScKSq62zMnfeWxLnDRSvGWdYKOS1E9Ykhl2iIjGImjR+0GTvroA+1f1a25W8RtKMTGzYGrZjXK/MaGRRifyRDI+DEvHX5r3sUvznsvuoM6zgzJq7wH9kbhnVTti31Hg/7btjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723170660; c=relaxed/simple;
	bh=pmzPYrxQ4k8Yi96SMlC1w41/25WHKI6QTuKx2LKoe+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUfbyxF8hbyC5VbVoWfwd0EbWqM2+19Z/xDA2k9gtO9EOgYcDhEKBip0rF8vLR3lTSOkj7FtvfjwF7IR63xfpoeQRvt+3n8tyfedtZB0rJkCtjOl0zo2F7XWnE0v5o9OyaXwUMqxXOipLpgGy68WnAZ952oq4MRtMyD6NZDEv88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=J0a+2ghW; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5d5e97b84fbso842666eaf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Aug 2024 19:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1723170658; x=1723775458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pp+gI4Z+eB/8/l+h4KSlAWx3DaU89gtFGX/4ZFgDEwc=;
        b=J0a+2ghWyviG/6iJPglx50nBtUe0JtUZivoZu7FJVbVIXk9uQriOv8ttfjUq7Kt3G7
         tT5RHv8iOJ0Uo/7DA9q+flNTKToIAd5r554yF3q3003MJ+Lqd8rB6PxwLrHYruPTr59Y
         WSTzuwzbypWZMa9E8W1Vokz+H0wb9x26a4Xugm4IWtOKhhO3QC1Io6YkFImDQW2MUcb0
         jUQGB1/Yusx3b2Q0prwaam7TXJmw9iMLu+a2oJXpD2/SCY4DXEnTrpDWDYYylt1QE1hf
         or8n1NZfKBLiDqLdHUwWURTVHJQHW9xgbjmJKGoQgdMAXqsOET6aFZayVRZtmqHqOrBY
         RiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723170658; x=1723775458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pp+gI4Z+eB/8/l+h4KSlAWx3DaU89gtFGX/4ZFgDEwc=;
        b=bMDZKE+TRIgXStXmgH+/9XlNT47XMwOQN4a8d0TChjMQIizEU+m/ta1ilei5HlRRVd
         KMSpuSuNCxXOQqTOvyOXbLaxsAmERL69C7/baejcC9suyzpwi6tyyH4Jq4zUrP4Hgg+V
         nJZsdiOoif0TyGrSQbwJhs1QE49Ozs34S5/OF4JUbijlrOpyaiBGMGsr83Y9pgtKK1Jj
         ro22dj+UYSW5psO7FhPyKs8QSR/sSOMbIRJNceM/B09XjB7qNi7hrsqw6xJJwiyUoR1Y
         1/0Kw8LbIuMxkJAtKrAgP/mOXM5jX9X+46mzADrAVqLkCyzUposoUBud+nx7BKGiQ+ck
         Iqzw==
X-Forwarded-Encrypted: i=1; AJvYcCU48wLSln4braGa8Qpj2Xi68Q8D0OPfkUywFGF9Sfc9mQenkxo4mK8t4JhQhqQ/ilidAgwAEpwa3sS66dEsANn6UjC0fVUre5MOzjUBkg==
X-Gm-Message-State: AOJu0YwfYWpkd4muOnNTrSqq3BiAlF8Ar6T/0XwyONn9yHYzH5b/vXKj
	hRQXY/q2vz9Fw26tXEly4Gu/zW9qbHIjNk8jhU/m2MHBRsZNuAuAPDwPikqQvNs=
X-Google-Smtp-Source: AGHT+IHiSPX2AdKDDvqvgSvOnV38EQf6QJEbJWRz5PUogQeaozBSJ2uHN8liJ4Cd+RQqikLE20XsDg==
X-Received: by 2002:a05:6358:12a6:b0:1ad:471:9b7 with SMTP id e5c5f4694b2df-1b176f7deeemr15232955d.18.1723170658111;
        Thu, 08 Aug 2024 19:30:58 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b762e9e619sm10481634a12.4.2024.08.08.19.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 19:30:57 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1scFP5-00APly-0h;
	Fri, 09 Aug 2024 12:30:55 +1000
Date: Fri, 9 Aug 2024 12:30:55 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH RFC 0/13] fs: generic filesystem shutdown handling
Message-ID: <ZrV/XxDVK4cNbqIq@dread.disaster.area>
References: <20240807180706.30713-1-jack@suse.cz>
 <ZrQA2/fkHdSReAcv@dread.disaster.area>
 <20240808145141.GC6043@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808145141.GC6043@frogsfrogsfrogs>

On Thu, Aug 08, 2024 at 07:51:41AM -0700, Darrick J. Wong wrote:
> On Thu, Aug 08, 2024 at 09:18:51AM +1000, Dave Chinner wrote:
> > On Wed, Aug 07, 2024 at 08:29:45PM +0200, Jan Kara wrote:
> > > Hello,
> > > 
> > > this patch series implements generic handling of filesystem shutdown. The idea
> > > is very simple: Have a superblock flag, which when set, will make VFS refuse
> > > modifications to the filesystem. The patch series consists of several parts.
> > > Patches 1-6 cleanup handling of SB_I_ flags which is currently messy (different
> > > flags seem to have different locks protecting them although they are modified
> > > by plain stores). Patches 7-12 gradually convert code to be able to handle
> > > errors from sb_start_write() / sb_start_pagefault(). Patch 13 then shows how
> > > filesystems can use this generic flag. Additionally, we could remove some
> > > shutdown checks from within ext4 code and rely on checks in VFS but I didn't
> > > want to complicate the series with ext4 specific things.
> > 
> > Overall this looks good. Two things that I noticed that we should
> > nail down before anything else:
> > 
> > 1. The original definition of a 'shutdown filesystem' (i.e. from the
> > XFS origins) is that a shutdown filesystem must *never* do -physical
> > IO- after the shutdown is initiated. This is a protection mechanism
> > for the underlying storage to prevent potential propagation of
> > problems in the storage media once a serious issue has been
> > detected. (e.g. suspect physical media can be made worse by
> > continually trying to read it.) It also allows the block device to
> > go away and we won't try to access issue new IO to it once the
> > ->shutdown call has been complete.
> > 
> > IOWs, XFS implements a "no new IO after shutdown" architecture, and
> > this is also largely what ext4 implements as well.
> 
> I don't think it quite does -- for EXT4_GOING_FLAGS_DEFAULT, it sets the
> shutdown flag, but it doesn't actually abort the journal. I think
> that's an implementation bug since XFS /does/ shut down the log.
>
> But looking at XFS_FSOP_GOING_FLAGS_DEFAULT, I also notice that if the
> bdev_freeze fails, it returns 0 and the fs isn't shut down.  ext4, otoh,
> actually does pass bdev_freeze's errno along.  I think ext4's behavior
> is the correct one, right?

Yes, there are inconsistencies in how different filesystems
implement user-driven shutdown operations, but Jan has specifically
left addressing those sorts of inconsistencies in ioctl/->shutdown
implementations for a later patch set. I agree with that approach -
let's first focus on defining a generic model for how shutdown
filesystems should behave once they are shut down. Once we have the
model defined, then we can worry about making filesystems shutdown
mechanisms behave consistently within that model..

> > However, this isn't what this generic shutdown infrastructure
> > implements. It only prevents new user modifications from being
> > started - it is effectively a "instant RO" mechanism rather than an
> > "instant no more IO" architecture.
> 
> I thought pagefaults are still allowed on a shutdown xfs?  Curiously I
> don't see a prohibition on write faults, but iirc we still allowed read
> faults so that a shutdown on the rootfs doesn't immediately crash the
> whole machine?

Yes, page faults are allowed on a shutdown XFS filesystem right up
to the point where they need to do IO on a page cache miss.  Then
the IO request hits the block mapping code (xfs_bmapi_read()), sees
the shutdown state and the read IO fails. The result of this is
SIGBUS for your executable.

IOWs, if the executable is cached, it will keep running after a
shutdown. If it's not cached, then it's game over already.

> > > Also, as Dave suggested, we can lift *_IOC_{SHUTDOWN|GOINGDOWN} ioctl handling
> > > to VFS (currently in 5 filesystems) and just call new ->shutdown op for
> > > the filesystem abort handling itself. But that is kind of independent thing
> > > and this series is long enough as is.
> > 
> > Agreed - that can be done separately once we've sorted out the
> > little details of what a shutdown filesystem actually means and how
> > that gets reported consistently to userspace...
> 
> I would define it as:
> 
> No more writes to the filesystem or its underlying storage; file IO
> and stat* calls return ESHUTDOWN; read faults still allowed.

We need to operations in terms of whether we allow physical IO or
not. We currently don't allow physical IO from read faults on XFs,
so...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

