Return-Path: <linux-fsdevel+bounces-12848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2C6867EB0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 18:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3493A290538
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 17:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B847512EBC8;
	Mon, 26 Feb 2024 17:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFaxMXfp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BAC12DD9B;
	Mon, 26 Feb 2024 17:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708968922; cv=none; b=EH8BCuW5pQoZS9V5oqMNeb5Idmu6io6PHt8WxUk8CJ86aMLX6cGSfb0LqXjYxFSUsKhWMbWL9LcFTBsRr8uhgl0zupvd3adIK4xYqkg18GMRNGz+oU0+rItgfntfrCzuTmd8RNTQCVuU83Mx1dPrnvr8XPZGNRssDpgYDk+pFVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708968922; c=relaxed/simple;
	bh=pZFdEHHS74uSQSTtdQp92KKc3jquRq20V+XWcp6EgKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khIzCPUpvLHSPoWEOrdXTAbVz6xCQMjwSrCOJr85EICxU9WolFzNgY84RxZOfx2YkK3EqDAIpPOYGIK+aZvWbhXCZJ+uursR7VpMGca7dJJyYnRjk7HnOh8PyvN1zuJPC0z509nnUL7EF1JgXoAnOfWR1WQ8EgiZzeaIH9UVr98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFaxMXfp; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bbd6ea06f5so1914626b6e.1;
        Mon, 26 Feb 2024 09:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708968919; x=1709573719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hg3y8nxzXla36uWDR1Drq6uiHQJkrYi4jCCDyrCzFbs=;
        b=TFaxMXfp3JGeK9rllU4q9ofK/0Lh1SJWyiBZDr76KNyWArPxKLWGTdfXIoEvn7Dd60
         RSx+lMGC672ZDaJdmfQnub6MpQZrEUudpzt/oQVg0CMuXnESay/aoSkCIdOgTtSm4cm9
         MGWnb/iyA1bpZ4oTiPtwlGHDlMujBuVn/ku1Oa7MA51GVTgD6vrW/1ereRhYzHH0tB2N
         jI4gy40F7OHsmQOf04rHyIi5MetxRVtBDBXeKpfuBrvOuM7JnsEq6MVD+505hHp1cs7D
         6nQWqu75nKvIIoG1zWTUvGtAJ+SMwfFjz7erA6oZj/s2kmx5mSUUe0LRK/97mk22mMG4
         +u3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708968919; x=1709573719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hg3y8nxzXla36uWDR1Drq6uiHQJkrYi4jCCDyrCzFbs=;
        b=GZDakPuv5kJxh5ThHivFtMarV2GxA806VhOnnDNwTcrktgZhWqrcG9VQ2EfZBlfIqU
         +04Q4htxMJhjlNWfLvRYD7EcaN7JRJoKDnJ6umtQeEqViBjAseKyRoE0MB06jeq3oROd
         wqEESjHDcy8n7WBGhNU++MhQCtqhrfw9PrOrk6oYVM+KgQf62hQdaulbw5uPpQAaSsDM
         2X+RU0rE/2ExX3EU9cdaG7kz4puOUBURR01LZKXPM2X42DYHyCONvnDZRGg8CvJMXNk8
         MgyuOiLelcbUZzbD3NCNu82CHWCeSSaxmYhiYmjxW4DxxEWfdjadpiyPkGXwzT5IJwWr
         Q7qw==
X-Forwarded-Encrypted: i=1; AJvYcCVGwfw8uanz+A3FwfbRMLzcD+6r92UcmkIjmeUTJRwLOOMYHHogE/4TLP1b77chQ06TY9ovoUjtlJSlbZnsn0pnO2Y3drjzzLqfTcoibhKBeBSIfcP1cKJFPoZBSJpa/98EEqO5TvItZlSsGEMBl1/mOF8GWeITbMU3tR0SzLDbccXA0eVCiwmOp+V3yrr7oNbn4BY9svV/tM7IL/CMDy1qpw==
X-Gm-Message-State: AOJu0Yyha+5NXBSYw2wGGFCi5iKZ0PdvmxIewdbJFA8GE6yFBR2KWoCN
	NUWGcabyha7QkCNfdxRwvxa+BBfeK+KH+zxuwstHFiqcc5fGgIjs/KqnWqCvRzE=
X-Google-Smtp-Source: AGHT+IFuGdZK2cA6mg4QaQRipIAZUshKOlcLnpK35D5bx97ZwiW/jzC0fLpOLdgOaA8FJ/BdbTj3rQ==
X-Received: by 2002:a05:6808:d8:b0:3c1:578b:e25e with SMTP id t24-20020a05680800d800b003c1578be25emr3049917oic.9.1708968919401;
        Mon, 26 Feb 2024 09:35:19 -0800 (PST)
Received: from Borg-9.local (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id bh26-20020a056808181a00b003c15125b39asm1126976oib.34.2024.02.26.09.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 09:35:18 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Mon, 26 Feb 2024 11:35:17 -0600
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
Subject: Re: [RFC PATCH 08/20] famfs: Add famfs_internal.h
Message-ID: <u6nfwlidsmmhejsboqdo4r2juox4txkzt4ffjlnlcqzzrwthlt@wsh5eb5xeghj>
References: <cover.1708709155.git.john@groves.net>
 <13556dbbd8d0f51bc31e3bdec796283fe85c6baf.1708709155.git.john@groves.net>
 <20240226124818.0000251d@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226124818.0000251d@Huawei.com>

On 24/02/26 12:48PM, Jonathan Cameron wrote:
> On Fri, 23 Feb 2024 11:41:52 -0600
> John Groves <John@Groves.net> wrote:
> 
> > Add the famfs_internal.h include file. This contains internal data
> > structures such as the per-file metadata structure (famfs_file_meta)
> > and extent formats.
> > 
> > Signed-off-by: John Groves <john@groves.net>
> Hi John,
> 
> Build this up as you add the definitions in later patches.
> 
> Separate header patches just make people jump back and forth when trying
> to review.  Obviously more work to build this stuff up cleanly but
> it's worth doing to save review time.
> 

Ohhhhkaaaaay. I think you're right, just not looking forward to
all that rebasing.

> Generally I'd plumb up Kconfig and Makefile a the beginning as it means
> that the set is bisectable and we can check the logic of building each stage.
> That is harder to do but tends to bring benefits in forcing clear step
> wise approach on a patch set. Feel free to ignore this one though as it
> can slow things down.

I'm not sure that's practical. A file system needs a bunch of different
kinds of operations
- super_operations
- fs_context_operations
- inode_operations
- file_operations
- dax holder_operations, iomap_ops
- etc.

Will think about the dependency graph of these entities, but I'm not sure
it's tractable...

> 
> A few trivial comments inline.
> 
> > ---
> >  fs/famfs/famfs_internal.h | 53 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> >  create mode 100644 fs/famfs/famfs_internal.h
> > 
> > diff --git a/fs/famfs/famfs_internal.h b/fs/famfs/famfs_internal.h
> > new file mode 100644
> > index 000000000000..af3990d43305
> > --- /dev/null
> > +++ b/fs/famfs/famfs_internal.h
> > @@ -0,0 +1,53 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * famfs - dax file system for shared fabric-attached memory
> > + *
> > + * Copyright 2023-2024 Micron Technology, Inc.
> > + *
> > + * This file system, originally based on ramfs the dax support from xfs,
> > + * is intended to allow multiple host systems to mount a common file system
> > + * view of dax files that map to shared memory.
> > + */
> > +#ifndef FAMFS_INTERNAL_H
> > +#define FAMFS_INTERNAL_H
> > +
> > +#include <linux/atomic.h>
> 
> Why?

Because fault counters are the one phased change to this file, and this
should have been with that. That may go away, but either way I'll do the
phased thing with this file.

> 
> > +#include <linux/famfs_ioctl.h>
> > +
> > +#define FAMFS_MAGIC 0x87b282ff
> > +
> > +#define FAMFS_BLKDEV_MODE (FMODE_READ|FMODE_WRITE)
> 
> Spaces around | 

Done

> 
> > +
> > +extern const struct file_operations      famfs_file_operations;
> 
> I wouldn't force alignment. It rots too often as new stuff gets added
> and doesn't really help readability much.

OK

> 
> > +
> > +/*
> > + * Each famfs dax file has this hanging from its inode->i_private.
> > + */
> > +struct famfs_file_meta {
> > +	int                   error;
> > +	enum famfs_file_type  file_type;
> > +	size_t                file_size;
> > +	enum extent_type      tfs_extent_type;
> > +	size_t                tfs_extent_ct;
> > +	struct famfs_extent   tfs_extents[];  /* flexible array */
> 
> Comment kind of obvious ;) I'd drop it.  Though we have
> magic markings for __counted_by which would be good to use from the start.

Done

> 
> 
> 
> > +};
> > +
> > +struct famfs_mount_opts {
> > +	umode_t mode;
> > +};
> > +
> > +extern const struct iomap_ops             famfs_iomap_ops;
> > +extern const struct vm_operations_struct  famfs_file_vm_ops;
> > +
> > +#define ROOTDEV_STRLEN 80
> 
> Why?  You aren't creating an array of this size here so I can't
> immediately see what the define is for.

Oversight. It was a char array but I switched to strdup() and 
failed to delete this. Gone now, thanks.

Thanks,
John


