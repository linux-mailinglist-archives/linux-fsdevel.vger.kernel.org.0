Return-Path: <linux-fsdevel+bounces-12886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFA486834B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 22:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C3A91C23240
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 21:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9F5131E2C;
	Mon, 26 Feb 2024 21:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxPhBclp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057F3405CE;
	Mon, 26 Feb 2024 21:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708984080; cv=none; b=glQXV47LL/kC0X0HDsc+2qUIzPWnpHhzp2UTy/TF0DN4Wq++72oWOEXb6+0sqCHmcX12WsLzNoup/u3gDbVCeOtCYqbw9MCoHqx+4iSKWSLJaYIQlcR6NucPRFGjYgQRsm3YFkhyGvG2nyjj/8PppSjbdoENzZSFuDAHjKS22J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708984080; c=relaxed/simple;
	bh=+mhRZDCckO6W8K7cXxypdompx2eyAZlDqNRYXBm0lRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRHMcO2ldTXHr2jvC7d/XKR0IG6gUeGxZ0DHfwR1h8oG3GtwTIBuCVbLsUs5mDBPw/YuMEzapDYdhNzvHfGD32LXnu0pV44G1doIZdk+DHOCk9e0g5W0WKLQhd4lhkdjpMQGPXW0D+3/u0KTqNSnhLl/eA5VMiu6oGd6gjnBxXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxPhBclp; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5a0669228b6so1321600eaf.0;
        Mon, 26 Feb 2024 13:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708984076; x=1709588876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WwkLzcOkTdepCEL/rTOLTVwMFBrXTv/HE2I151NYxEg=;
        b=fxPhBclpFQ+5AkFBIq5hzfZ7XqCxzt4Zaj0eafEVX/3clW9wh2zFGB6lyYsKlB3UhV
         0belvW+1FJPyFvnoDmqU1Yo6bugWLktH/8SckZJaTcoZVEay8vpIfNVZ3A97gzSqPqrK
         dgoINt2sjdu5aUZWysjxGoTJe8kKosXu/csZaYOGrEeFENrQIknk2XZQDJGsWtZkg97/
         fH/tROE+VJwxtRD455Ctjy5oJPco6uAS7c5cnBg02JIYiyLW96/LHVU5I1lVs5qXa2+u
         rPL0reWB/9l0GyxlzUjPN1vfjR72LG2Ro77IXRWXwWahM8LA4Z+c1VlaY2A9nmbH8hek
         1Izg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708984076; x=1709588876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WwkLzcOkTdepCEL/rTOLTVwMFBrXTv/HE2I151NYxEg=;
        b=j4wMFwoT0Xa+DZxKMXZDgktBUGdvxmRR3nUkyzgK75iF6+dGV1T3VtsHNCvgJXiGeL
         a7WuAHuQo6FELGK9EkolZb4aTNZXTEWIdyr46x6CxtyuO6ZQPBQuB03yAcKmr5eo6wlL
         4nalqTAck1R4HrH/9Dz+DE10DOlt0vcujZOV3cbXfMAnMHyN+LgAgXFvOEdljXbJTAGR
         50crZuyuVBqKXACCzAOuDiYChKOwmPoy/kd6QJgWP6Pbj8rTrQLGCPxpIBk4IyvJ91Ix
         kPvYzugBr8aNgWN7CfZJ2hytHVNAOhJIOWXmJnB4Ps4qujoGh+DW6TLPaxdX3vD55bsb
         93KA==
X-Forwarded-Encrypted: i=1; AJvYcCUwNszFzu0JYKIv6QxA0SKt8VkHctio9biJ2bZyA40YOMGD+pxvBstiKqdHlU9wipyXpo6pRUEsRsMpsM3g77Q9/LwX/QyMMSy7gmxwyS0Y5gKarVP4nC2XS12oAQoFHe1Dm+4G7UGFVTVjTgbPEuTo4Y88xmp2+1nnHwiSt6TqglftDyF+++bMKFm6WZKHgGcggv05JOPc+buSZQ66WuSwWA==
X-Gm-Message-State: AOJu0Yw/eO0xf+3PXlk+bg+lMRXKTETmxaaeuCDcNcw+9mwjjUBWO9bS
	V8MX+1/mGABoIRR73rCMASf1M9kFEyFjpLvdsvaeawKDuuZPQK82
X-Google-Smtp-Source: AGHT+IENzrYho4sVLLETE+2kSmQeGnYGjapvMx2yk+6P/1Df/2LXKbX/7P21pTgZxerQUQHeu5dWRA==
X-Received: by 2002:a4a:ee8e:0:b0:5a0:5ac0:e81c with SMTP id dk14-20020a4aee8e000000b005a05ac0e81cmr6718130oob.6.1708984076000;
        Mon, 26 Feb 2024 13:47:56 -0800 (PST)
Received: from Borg-9.local (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id h26-20020a4ad29a000000b005a0174b67c0sm1415632oos.3.2024.02.26.13.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 13:47:55 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Mon, 26 Feb 2024 15:47:53 -0600
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
Subject: Re: [RFC PATCH 09/20] famfs: Add super_operations
Message-ID: <z3tnfxbbvhtbyantbm3yr3yv2qsih7darbm3p5pwwdsknuxlqa@rvexwleaixiy>
References: <cover.1708709155.git.john@groves.net>
 <537f836056c141ae093c42b9623d20de919083b1.1708709155.git.john@groves.net>
 <20240226125136.00002e64@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226125136.00002e64@Huawei.com>

On 24/02/26 12:51PM, Jonathan Cameron wrote:
> On Fri, 23 Feb 2024 11:41:53 -0600
> John Groves <John@Groves.net> wrote:
> 
> > Introduce the famfs superblock operations
> > 
> > Signed-off-by: John Groves <john@groves.net>
> > ---
> >  fs/famfs/famfs_inode.c | 72 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 72 insertions(+)
> >  create mode 100644 fs/famfs/famfs_inode.c
> > 
> > diff --git a/fs/famfs/famfs_inode.c b/fs/famfs/famfs_inode.c
> > new file mode 100644
> > index 000000000000..3329aff000d1
> > --- /dev/null
> > +++ b/fs/famfs/famfs_inode.c
> > @@ -0,0 +1,72 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * famfs - dax file system for shared fabric-attached memory
> > + *
> > + * Copyright 2023-2024 Micron Technology, inc
> > + *
> > + * This file system, originally based on ramfs the dax support from xfs,
> > + * is intended to allow multiple host systems to mount a common file system
> > + * view of dax files that map to shared memory.
> > + */
> > +
> > +#include <linux/fs.h>
> > +#include <linux/pagemap.h>
> > +#include <linux/highmem.h>
> > +#include <linux/time.h>
> > +#include <linux/init.h>
> > +#include <linux/string.h>
> > +#include <linux/backing-dev.h>
> > +#include <linux/sched.h>
> > +#include <linux/parser.h>
> > +#include <linux/magic.h>
> > +#include <linux/slab.h>
> > +#include <linux/uaccess.h>
> > +#include <linux/fs_context.h>
> > +#include <linux/fs_parser.h>
> > +#include <linux/seq_file.h>
> > +#include <linux/dax.h>
> > +#include <linux/hugetlb.h>
> > +#include <linux/uio.h>
> > +#include <linux/iomap.h>
> > +#include <linux/path.h>
> > +#include <linux/namei.h>
> > +#include <linux/pfn_t.h>
> > +#include <linux/blkdev.h>
> 
> That's a lot of header for such a small patch.. I'm going to guess
> they aren't all used - bring them in as you need them - I hope
> you never need some of these!

I didn't phase in headers in this series. Based on these recommendations,
the next version of this series is gonna have to be 100% constructed from
scratch, but okay. My head hurts just thinking about it. I need a nap...

I've been rebasing for 3 weeks to get this series out, and it occurs to
me that maybe there are tools I'm not aware of that make it eaiser? I'm
just typing "rebase -i..." 200 times a day. Is there a less soul-crushing way?

> 
> 
> > +
> > +#include "famfs_internal.h"
> > +
> > +#define FAMFS_DEFAULT_MODE	0755
> > +
> > +static const struct super_operations famfs_ops;
> > +static const struct inode_operations famfs_file_inode_operations;
> > +static const struct inode_operations famfs_dir_inode_operations;
> 
> Why are these all up here?

These forward declarations are needed by a later patch in the series.
They were in famfs_internal.h, but they are only used in this file, so
I moved them here.

For all answers such as this, I will hereafter reply "rebase fu", with
further clarification only if necessary.

> 
> > +
> > +/**********************************************************************************
> > + * famfs super_operations
> > + *
> > + * TODO: implement a famfs_statfs() that shows size, free and available space, etc.
> > + */
> > +
> > +/**
> > + * famfs_show_options() - Display the mount options in /proc/mounts.
> Run kernel doc script + fix all warnings.

Will do; I actually think I have already fixed those...

> 
> > + */
> > +static int famfs_show_options(
> > +	struct seq_file *m,
> > +	struct dentry   *root)
> Not that familiar with fs code, but this unusual kernel style. I'd go with 
> something more common
> 
> static int famfs_show_options(struct seq_file *m, struct dentry *root)

Done. To all functions...

> 
> > +{
> > +	struct famfs_fs_info *fsi = root->d_sb->s_fs_info;
> > +
> > +	if (fsi->mount_opts.mode != FAMFS_DEFAULT_MODE)
> > +		seq_printf(m, ",mode=%o", fsi->mount_opts.mode);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct super_operations famfs_ops = {
> > +	.statfs		= simple_statfs,
> > +	.drop_inode	= generic_delete_inode,
> > +	.show_options	= famfs_show_options,
> > +};
> > +
> > +
> One blank line probably fine.

Done

> 
> 
> Add the rest of the stuff a module normally has, author etc in this
> patch.

Because "rebase fu" I'm not sure the order will remain the same. Will
try not to make anybody tell me this again though...

John


