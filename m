Return-Path: <linux-fsdevel+bounces-12829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF68867AAD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 16:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D1A11C216CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 15:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DD512BF1C;
	Mon, 26 Feb 2024 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFxebVyZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FFD12BEB6;
	Mon, 26 Feb 2024 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962533; cv=none; b=jNwcS9xlCbZf6b0V/MIPZMZC92FjVH/G08fuenLioPBOrXc3m0K2K25Wus1vQl9ZyftP17QKwDMwapmG6TXuyrzTgP5Lab+ZCHsPT8+5oWukmZqNBvthSZSjYDzWAbF3PQXaVmFfC4C2jpnqQCZ0070Kr1CNlIpgfBKi/8SWJPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962533; c=relaxed/simple;
	bh=HAFBj8+lhYpdZl1QneCB2GMGS+XvqJF/SW95VkhrC5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9tb/YM685M853pViKKLN8FigBk564cUNWyYHntdRQQtAHdatdKbPpPHm2evDDhyMikbhGd6gk92Y+YHDDZNi9J4TY6GKK3ANw14T5Cvhtt1zKQlMe6Bqy4zA6a8YBZoXb4TQhMsrTFnb7Pf3+jdhkUbeGQvQJQnofICfXTXIO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFxebVyZ; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-21ffac15528so743182fac.0;
        Mon, 26 Feb 2024 07:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708962529; x=1709567329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g1Ef7Zrtq6omQnQLjTPEQeB7WpA4VjRn7DjZ66gvGyg=;
        b=QFxebVyZl4IhedVrAmqd7K77MgBzAN/98UUwpllIEAbDX3ivC4+/31vkpwmf0GQKy2
         dHcYKnng1vuaNJTS4lkvZPlw1iAydPdhDwBxFPyLaphblEiE540vT5Lp0lrM4qhBFlEk
         84XGKkFQ+heP1e4+bHHfKAr/7ZT/TgntWbig3mvOQnNlRBpsJW7Fx+HXxtGGc9LReeIp
         Gck0d8p3q6/Zxgu5wwlp2vxckjAvEBGcxTEM4uoR3y/Ufo1fzIH1ASQ7ddpxp5yDEimq
         0JuQTSxGRgL3phK/dMHRhGyzk5nhk/Yg+mvWydRPXeZMHEFR53m847jfNK4vardnLj4E
         etdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708962529; x=1709567329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1Ef7Zrtq6omQnQLjTPEQeB7WpA4VjRn7DjZ66gvGyg=;
        b=VKDlwicOzkmU96nyT28OAuKx9GnXeTCcHHSa8cjbS0Ih8+pOpA5gRsbFAhmzn5rfy8
         E/eS46rpPgGkXv9wv7OtcEHyIoekNQ9BalMqaJMWJx7Ehyz75PaAL0n0CoteHtXAH14G
         nlwEcbctBKBS45tJvPxaqaXZQNDSepE4bdtmBG5wNjBvd6tND2+EJudeAjYdJyp11Gb2
         RVwvYoAt+/0LWHjJ7iPkE0I1xpY2rLNWhAAcllrrueRCS6lMZNNLJFp6UgMfMA1DowP/
         vRVpJxE3+9Wz5RN4lKDGMqH+N0wPTp5Yg2lwW67ihF+xgOe0sbBr/dxGm4MpSPKT7LL8
         toew==
X-Forwarded-Encrypted: i=1; AJvYcCXwa2PDNWfwcoztp6/XVeYGIdqer2RgeDP+mqC471jxr7lUPrBkFwRuCmydpfA0Mar/OYWYBrJD5Y7YEQegajocRa3/luI8qSHpsc64F3HgVyZWnhGs59S2ahEWhau5YEIk/D6hq1Dx3dOSg64bToRcCcd+JziHfu9zwRhyqSGOrvAKGCYz7mp5MHWWuGiaNs8VEt3+oWkSb+GRTQmLDmpPLg==
X-Gm-Message-State: AOJu0YxVr4+WueQLZZOJY3rap0eRYoNpG7dokIUeUn3SJz/RFv3MSj/Q
	pYEQiBv06VdOKWpDXj11Q/KepQPIslOdecdLsxAMcM0WvLACyRxP
X-Google-Smtp-Source: AGHT+IHBnk/ikDk3sUqAcZtkdVfd8nz2HPMuab3RRIOBE3LZkSw4ZFujEh+N/1KdTo/PHgEe82UeRw==
X-Received: by 2002:a05:6870:709f:b0:21e:8797:95ca with SMTP id v31-20020a056870709f00b0021e879795camr9411219oae.23.1708962529545;
        Mon, 26 Feb 2024 07:48:49 -0800 (PST)
Received: from Borg-9.local (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id d7-20020a9d4f07000000b006e42884bad9sm1147569otl.1.2024.02.26.07.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 07:48:48 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Mon, 26 Feb 2024 09:48:46 -0600
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
Subject: Re: [RFC PATCH 04/20] dev_dax_iomap: Save the kva from memremap
Message-ID: <tngofq33j2uk7cixkiicvy73n67dkx3aqzypdrkgd6bbuusgjc@jugpgbcvgzvx>
References: <cover.1708709155.git.john@groves.net>
 <66620f69fa3f3664d955649eba7da63fdf8d65ad.1708709155.git.john@groves.net>
 <20240226122139.0000135b@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226122139.0000135b@Huawei.com>

On 24/02/26 12:21PM, Jonathan Cameron wrote:
> On Fri, 23 Feb 2024 11:41:48 -0600
> John Groves <John@Groves.net> wrote:
> 
> > Save the kva from memremap because we need it for iomap rw support
> > 
> > Prior to famfs, there were no iomap users of /dev/dax - so the virtual
> > address from memremap was not needed.
> > 
> > Also: in some cases dev_dax_probe() is called with the first
> > dev_dax->range offset past pgmap[0].range. In those cases we need to
> > add the difference to virt_addr in order to have the physaddr's in
> > dev_dax->ranges match dev_dax->virt_addr.
> 
> Probably good to have info on when this happens and preferably why
> this dragon is there.

I added this paragraph:

  This happens with devdax devices that started as pmem and got converted
  to devdax. I'm not sure whether the offset is due to label storage, or
  page tables. Dan?

...which is also insufficient, but perhaps Dan or somebody else from the
dax side can correct this.

> 
> > 
> > Dragons...
> > 
> > Signed-off-by: John Groves <john@groves.net>
> > ---
> >  drivers/dax/dax-private.h |  1 +
> >  drivers/dax/device.c      | 15 +++++++++++++++
> >  2 files changed, 16 insertions(+)
> > 
> > diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
> > index 446617b73aea..894eb1c66b4a 100644
> > --- a/drivers/dax/dax-private.h
> > +++ b/drivers/dax/dax-private.h
> > @@ -63,6 +63,7 @@ struct dax_mapping {
> >  struct dev_dax {
> >  	struct dax_region *region;
> >  	struct dax_device *dax_dev;
> > +	u64 virt_addr;
> 
> Why as a u64? If it's a virt address why not just void *?

Changed to void * - thanks

> 
> >  	unsigned int align;
> >  	int target_node;
> >  	bool dyn_id;
> > diff --git a/drivers/dax/device.c b/drivers/dax/device.c
> > index 40ba660013cf..6cd79d00fe1b 100644
> > --- a/drivers/dax/device.c
> > +++ b/drivers/dax/device.c
> > @@ -372,6 +372,7 @@ static int dev_dax_probe(struct dev_dax *dev_dax)
> >  	struct dax_device *dax_dev = dev_dax->dax_dev;
> >  	struct device *dev = &dev_dax->dev;
> >  	struct dev_pagemap *pgmap;
> > +	u64 data_offset = 0;
> >  	struct inode *inode;
> >  	struct cdev *cdev;
> >  	void *addr;
> > @@ -426,6 +427,20 @@ static int dev_dax_probe(struct dev_dax *dev_dax)
> >  	if (IS_ERR(addr))
> >  		return PTR_ERR(addr);
> >  
> > +	/* Detect whether the data is at a non-zero offset into the memory */
> > +	if (pgmap->range.start != dev_dax->ranges[0].range.start) {
> > +		u64 phys = (u64)dev_dax->ranges[0].range.start;
> 
> Why the cast? Ranges use u64s internally.

I've removed all the unnecessary casts in this function - thanks
for the catch

> 
> > +		u64 pgmap_phys = (u64)dev_dax->pgmap[0].range.start;
> > +		u64 vmemmap_shift = (u64)dev_dax->pgmap[0].vmemmap_shift;
> > +
> > +		if (!WARN_ON(pgmap_phys > phys))
> > +			data_offset = phys - pgmap_phys;
> > +
> > +		pr_notice("%s: offset detected phys=%llx pgmap_phys=%llx offset=%llx shift=%llx\n",
> > +		       __func__, phys, pgmap_phys, data_offset, vmemmap_shift);
> 
> pr_debug() + dynamic debug will then deal with __func__ for you.

Thanks - yeah that would be better than just taking it out...

> 
> > +	}
> > +	dev_dax->virt_addr = (u64)addr + data_offset;
> > +
> >  	inode = dax_inode(dax_dev);
> >  	cdev = inode->i_cdev;
> >  	cdev_init(cdev, &dax_fops);
> 

Thanks,
John


