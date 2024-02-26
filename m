Return-Path: <linux-fsdevel+bounces-12862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F952867F83
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 19:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EEDA1F2961E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 18:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EDE12EBDE;
	Mon, 26 Feb 2024 18:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLTavNwQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0912412EBC4;
	Mon, 26 Feb 2024 18:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708970650; cv=none; b=hAz/FbH5y6/hQt/YM+oXGdiDvzteI28ydLuo7mvo0B+Paly6AYs2Ewd9nz5hLWQq9r9+R3gitaLQGvt5Ae6y+5233ME8utGblBXUOodPlaTD1aweUioBhDejswPdlaeT+1C6bi8PvK0Giahzokd+JGvlZsKInRAKS/Eyo1YDxRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708970650; c=relaxed/simple;
	bh=tDPb8vlw/ZoRmRrLyIh3Zsy28YswYOKaPkn8/G0z84Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCDr1N/4DMYLQnd+SM/ipg4N+pza5o8Q2ofJz72MfVgr05Uh2xxeaxIopze49q/KBNQ809f6a8sHaSsgyY8PY8irysQKg5yItdZr2SqXAmHagzyViqUZEhLbj3WWJjakj1K7QnRrAYE3PX2NhUJwTdXeth34Z7IkuvCeDVa0KAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLTavNwQ; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5a02e5c5d2dso1431631eaf.1;
        Mon, 26 Feb 2024 10:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708970648; x=1709575448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b7s8IUy8czqrAQYpGOzabD/DmImOT4f/IOsvl+2f5BQ=;
        b=WLTavNwQNJvZrshbf5J/Uhv1KPrmcUJ2q/1xn4CMAqouj/UfyyrkCJGMMsihvQA4Q7
         fj8sgeHUo/i/kcXAtgkp/C6veZ0+QWoEhB5Z8qlxJYLB6cyKpTTrIywpRYaB/VPFMjFZ
         7nZ3f1Yw05g8YPFXOclLDmPrAubLVIIdFn7ItVxYnt2Ai8ERod3/r8lZV6mHJ3dBXAXr
         F3L/v9ocDXXCTY0+HES5TG/aeziz252eicLNm/7XgKrw17VzQIeu614a0Fp0rYvK4PpK
         B8R0eu9NX06kT8r7FMI+m8xlqKm0miSWCGT8pFoAhV/Fo4/3m6mYy7MpcoAujRKbxgv6
         SL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708970648; x=1709575448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7s8IUy8czqrAQYpGOzabD/DmImOT4f/IOsvl+2f5BQ=;
        b=k6PaaucnGtk1aNx60AwX75gfJOq7au064wV7JkkMVzsY5s2MW/CDNL3B/xJgjyGwJE
         sspSWT+btsMiQKVPBfzwx9GqXoJwDNeRQh3kkMvC88b2bSv4eC5ML1XUf9AgRncoo4fy
         dtQAtYiWjTofZAbv9RBqxbuw7I0hh/b/HNcd59lBMgyzHeAATuCd2tywvAHJ06E3hJWl
         e8rTQK+zLXMtK8SwOETOQwC2RJYBlb3N7pEy8L7hlb5DnmicoPOlRXoXs97uwIJFqqvf
         hSmDzFdXKMYcM2jHHLNQlmH8Mvi0Pe2xCYNGjCvndD7uSovayNywHj7cvPJLWnU2ub6d
         VSrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnBzGpR21qP7HqckY5K/pS1OchouvKuGf5urUqSMInmwNL02/OejN5SXdG2/3OV7f16qRFsbRsEle+jFNT0g+RafJd0g8yJI/MuyviJrZaHMcZX7PcUEl4JQgbV9mfHu5hXop272zMZqkiJWNWZ6sBiixVBlPMEFRtrl+1TeeODPllAhnSA/wMItMWsNS0DhQ2pna/DJFdCSy/e+8yKQZysA==
X-Gm-Message-State: AOJu0Yw1KMyFpZye/XcsYYNd9TeWEug+HkKbTt/zYpv84u6thDkwPDYG
	2RU4MY+RGsqSHZB+aJnH6Hax4N7r3OMuKYcaI8p7wtvBLt0hDRkS
X-Google-Smtp-Source: AGHT+IHO3JQJqrUqgBn9egOt4HQjL1Epy1k4IOgfQYCQYmmcGSlN0f4WlPT0wFFWU2jOVnrpPNk8kA==
X-Received: by 2002:a4a:bd83:0:b0:5a0:6b03:a660 with SMTP id k3-20020a4abd83000000b005a06b03a660mr2448473oop.2.1708970648068;
        Mon, 26 Feb 2024 10:04:08 -0800 (PST)
Received: from Borg-9.local (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id x14-20020a4a620e000000b005a0a1249615sm179887ooc.5.2024.02.26.10.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 10:04:07 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Mon, 26 Feb 2024 12:04:05 -0600
From: John Groves <John@groves.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, john@jagalactic.com, 
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, 
	dave.hansen@linux.intel.com, gregory.price@memverge.com
Subject: Re: [RFC PATCH 07/20] famfs: Add include/linux/famfs_ioctl.h
Message-ID: <4v6ug44nrtk2tqvio2teglsm4auhdvocgyyggtlwc3xkv7b6zw@ntw24jye7omz>
References: <cover.1708709155.git.john@groves.net>
 <b40ca30e4bf689249a8c237909d9a7aaca9861e4.1708709155.git.john@groves.net>
 <20240226123940.0000692c@Huawei.com>
 <z3fx5uiv6uu4sawvxrhfvx42qetchmq4ozxhq2huwg2rrcyk5c@odbiisdhop2m>
 <20240226165639.000025c6@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226165639.000025c6@Huawei.com>

On 24/02/26 04:56PM, Jonathan Cameron wrote:
> On Mon, 26 Feb 2024 10:44:43 -0600
> John Groves <John@groves.net> wrote:
> 
> > On 24/02/26 12:39PM, Jonathan Cameron wrote:
> > > On Fri, 23 Feb 2024 11:41:51 -0600
> > > John Groves <John@Groves.net> wrote:
> > >   
> > > > Add uapi include file for famfs. The famfs user space uses ioctl on
> > > > individual files to pass in mapping information and file size. This
> > > > would be hard to do via sysfs or other means, since it's
> > > > file-specific.
> > > > 
> > > > Signed-off-by: John Groves <john@groves.net>
> > > > ---
> > > >  include/uapi/linux/famfs_ioctl.h | 56 ++++++++++++++++++++++++++++++++
> > > >  1 file changed, 56 insertions(+)
> > > >  create mode 100644 include/uapi/linux/famfs_ioctl.h
> > > > 
> > > > diff --git a/include/uapi/linux/famfs_ioctl.h b/include/uapi/linux/famfs_ioctl.h
> > > > new file mode 100644
> > > > index 000000000000..6b3e6452d02f
> > > > --- /dev/null
> > > > +++ b/include/uapi/linux/famfs_ioctl.h
> > > > @@ -0,0 +1,56 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > > > +/*
> > > > + * famfs - dax file system for shared fabric-attached memory
> > > > + *
> > > > + * Copyright 2023-2024 Micron Technology, Inc.
> > > > + *
> > > > + * This file system, originally based on ramfs the dax support from xfs,
> > > > + * is intended to allow multiple host systems to mount a common file system
> > > > + * view of dax files that map to shared memory.
> > > > + */
> > > > +#ifndef FAMFS_IOCTL_H
> > > > +#define FAMFS_IOCTL_H
> > > > +
> > > > +#include <linux/ioctl.h>
> > > > +#include <linux/uuid.h>
> > > > +
> > > > +#define FAMFS_MAX_EXTENTS 2  
> > > Why 2?  
> > 
> > You catch everything! 
> > 
> > This limit is in place to avoid supporting somethign we're not testing. It
> > will probably be raised later.
> > 
> > Currently user space doesn't support deleting files, which makes it easy
> > to ignore whether any clients have a stale view of metadata. If there is
> > no delete, there's actually no reason to have more than 1 extent.
> Then have 1. + a Comment on why it is 1.

Actually we test the 2 case. That seemed important to testing ioctl and
famfs_meta_to_dax_offset(). It just doesn't yet happen in the wild. Will
clarify with a comment.

> > 
> > > > +
> > > > +enum extent_type {
> > > > +	SIMPLE_DAX_EXTENT = 13,  
> > > 
> > > Comment on this would be good to have  
> > 
> > Done. Basically we anticipate there being other types of extents in the
> > future.
> 
> I was more curious about the 13!

I think I was just being feisty that day. Will drop that...

> 
> > 
> > >   
> > > > +	INVALID_EXTENT_TYPE,
> > > > +};
> > > > +
> > > > +struct famfs_extent {
> > > > +	__u64              offset;
> > > > +	__u64              len;
> > > > +};
> > > > +
> > > > +enum famfs_file_type {
> > > > +	FAMFS_REG,
> > > > +	FAMFS_SUPERBLOCK,
> > > > +	FAMFS_LOG,
> > > > +};
> > > > +
> > > > +/**
> > > > + * struct famfs_ioc_map
> > > > + *
> > > > + * This is the metadata that indicates where the memory is for a famfs file
> > > > + */
> > > > +struct famfs_ioc_map {
> > > > +	enum extent_type          extent_type;
> > > > +	enum famfs_file_type      file_type;  
> > > 
> > > These are going to be potentially varying in size depending on arch, compiler
> > > settings etc.  Been a while, but I though best practice for uapi was always
> > > fixed size elements even though we lose the typing.  
> > 
> > I might not be following you fully here. User space is running the same
> > arch as kernel, so an enum can't be a different size, right? It could be
> > a different size on different arches, but this is just between user/kernel.
> 
> I can't remember why, but this has bitten me in the past.
> Ah, should have known Daniel would have written something on it ;)
> https://www.kernel.org/doc/html/next/process/botching-up-ioctls.html
> 
> It's the fun of need for compat ioctls with 32bit userspace on 64bit kernels.
> 
> The alignment one is key as well. That bit me more than once due to
> 32bit x86 aligning 64 bit integers at 32 bits.
> 
> We could just not support these cases but it's easy to get right so why
> bother with complexity of ruling them out.

Makes sense. Will do.

> 
> > 
> > I initially thought of XDR for on-media-format, which file systems need
> > to do with on-media structs (superblocks, logs, inodes, etc. etc.). But
> > this struct is not used in that way.
> > 
> > In fact, famfs' on-media/in-memory metadata (superblock, log, log entries)
> > is only ever read read and written by user space - so it's the user space
> > code that needs XDR on-media-format handling.
> > 
> > So to clarify - do you think those enums should be u32 or the like?
> 
> Yes. As it's userspace, uint32_t maybe or __u32. I 'think'
> both are acceptable in uapi headers these days.

Roger that.

Thanks,
John

