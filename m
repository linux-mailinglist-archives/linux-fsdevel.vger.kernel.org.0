Return-Path: <linux-fsdevel+bounces-12958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 871AC869699
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 15:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 154532954BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 14:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27B5145B15;
	Tue, 27 Feb 2024 14:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXShywRK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C583F14534E;
	Tue, 27 Feb 2024 14:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043184; cv=none; b=RB4cUuRqur60Pc9RwaQe1v4UW8cfa9PtaQFw7B5YpRqtQ8OWOYMvUJbjTXubl1rXaMELkiRwMmfmv6zlzj5F1uB8UABiaWZISPUCXBXXLcLmdmZbwVcP8GBI5aFFqx5pBMJxuBuDwhG3pb9xHEt8B/wKLIkW5Q983kOZvs5WlaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043184; c=relaxed/simple;
	bh=vdy2/jshL3R4Tx8oyk8z07nWJMHJ6K0TNsRxmG/PSc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGH5qUBqYYuVLwF+8IOeYXIiNVPtd4kyn7OG6NbKs3YxDQZ71falCpDsV4JcWtBuqJ+uzzd+k7GJh4jFcuSRqDTIUbleFZAE23HIp2TMoe1MQz/kwxgglao75RyhW6/Cre89GLOgGWeAIwDtjHuOvihZJLgO84FCDDpxuaoqzrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXShywRK; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-214c940145bso2426895fac.1;
        Tue, 27 Feb 2024 06:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709043181; x=1709647981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PGb5zgEK6C2hj+4mYKhczrOkyb0sOdrGR3mLsPhWNC8=;
        b=PXShywRK049W3X5LmVSZqPmEQ5LKw/FOKJ6bjKwtye8eAoHggbrsC61K5WWMK+0ARz
         YizcDV+k7O4Yxig5AAJj44TuyfMqMnJFKSrObesIMObzSWwZ8TdcBwwEWRKLJjG0ZKiu
         LSq5rZ3qwHpEihc+/IX88V0vlyIke0pNpHQJLOUdQ5NUiMYmKGoHHRqwPx6dqSOM4qDy
         cU4EL38m9y4Ny3wzls+OuJtLB8Jx1bkzq6lxP7NHQB/ODGQ5MYX+6FbXGEMkzSRnYO9z
         EGo+7VizKiSkxsLEzbqNSf4P7E7U0JvzEiFgSjC8UNz/4VD6T5JvDNaILvh1cQ/eyIup
         rnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709043181; x=1709647981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PGb5zgEK6C2hj+4mYKhczrOkyb0sOdrGR3mLsPhWNC8=;
        b=aeufsoWK5GvPe0dkDl7M2mcs6Op/eroHvBkKHn0MjX+e/uHx0gYOK5ehlNMCxGCFBT
         L3h5Ii050l7DImlOpdk6CBUE4IPBjtClascaguA9BDBcrUPOvhpIsiG+vc5Yx1DEOXM8
         uVMaEMW7Ry/dlhQVRT/keeQmAkT4oT8IJLFK/3TQ1/hSWAKS2Ac3Wcbe0iaxqIfBSOxn
         0WJ1PpPkRsh1u5Ct/yPJCGZ8iRhopZ+k0sA/exymM4RN4XyasFxZdE7qo1z3Vj952ag4
         KDR9h1ZM1l/e/szcn8WMOlKmbK5UWRSg7OhyUVpF9mANm3uMMeWDUgAgSNnrInEpwiYh
         H5kA==
X-Forwarded-Encrypted: i=1; AJvYcCUt3yc2m2bMFkGteqoew1Bhl38+A1zLiW3APQ9Ct1MvLlq0AmOB/C+dN8V05tNePJKu9iCJq9ljxbNO9VWjWAq2ZP4QdeUdM+qD+8SMtCtv6hILZm+ZcFjdVZf2Yfh2apzsdlv9Ls3Dnedl6+gMnHLKkNWE3IvwZFYuhG4Ogkh5QGlelLOdoibt4xV3B3RkKM9W7624ETOCJXdiOF55SMmxVQ==
X-Gm-Message-State: AOJu0Yw/VDFCyqm6XrgBjcpuB4S9l9u1LEp1ky+uZRQdPCO2NFv5A7uV
	m/ZoMV8nGwTZaxTe9aZUv3/gs9g+ZO8sdQShiA7nt0J+S2tCUg6z
X-Google-Smtp-Source: AGHT+IH8/5KlM61VXYvgT2KPkGjl5A/QR3/+KkQX0L9Vg1IRz6Sl1T6Dy9r6eVf85Z1umiZN01LQ1Q==
X-Received: by 2002:a05:6870:8291:b0:21e:b3aa:1906 with SMTP id q17-20020a056870829100b0021eb3aa1906mr9462866oae.4.1709043180684;
        Tue, 27 Feb 2024 06:13:00 -0800 (PST)
Received: from Borg-9.local (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id eu3-20020a0568303d0300b006e2e64d2e14sm1507666otb.75.2024.02.27.06.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 06:13:00 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Tue, 27 Feb 2024 08:12:57 -0600
From: John Groves <John@groves.net>
To: Christian Brauner <brauner@kernel.org>
Cc: John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, linux-cxl@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, john@jagalactic.com, Dave Chinner <david@fromorbit.com>, 
	Christoph Hellwig <hch@infradead.org>, dave.hansen@linux.intel.com, gregory.price@memverge.com
Subject: Re: [RFC PATCH 08/20] famfs: Add famfs_internal.h
Message-ID: <doozhoqznmwg74tc4uvmg2qwzwvga7hyoajb4naso7ptiddmvs@ysxldif4k6rn>
References: <13556dbbd8d0f51bc31e3bdec796283fe85c6baf.1708709155.git.john@groves.net>
 <20240227-kiesgrube-couch-77ee2f6917c7@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227-kiesgrube-couch-77ee2f6917c7@brauner>

On 24/02/27 02:38PM, Christian Brauner wrote:
> On Fri, Feb 23, 2024 at 11:41:52AM -0600, John Groves wrote:
> > Add the famfs_internal.h include file. This contains internal data
> > structures such as the per-file metadata structure (famfs_file_meta)
> > and extent formats.
> > 
> > Signed-off-by: John Groves <john@groves.net>
> > ---
> >  fs/famfs/famfs_internal.h | 53 +++++++++++++++++++++++++++++++++++++++
> 
> Already mentioned in another reply here but adding a bunch of types such
> as famfs_file_operations that aren't even defines is pretty odd. So you
> should reorder this.

Acknowledged, thanks. V2 will phase in only what is needed by the
code in each patch.

> 
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
> > +#include <linux/famfs_ioctl.h>
> > +
> > +#define FAMFS_MAGIC 0x87b282ff
> 
> That needs to go into include/uapi/linux/magic.h.

Done for v2.

Thank you,
John


