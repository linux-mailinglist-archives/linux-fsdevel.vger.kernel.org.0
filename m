Return-Path: <linux-fsdevel+bounces-13010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB9F86A25F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 23:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4DF8B3195B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 22:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647C4153506;
	Tue, 27 Feb 2024 22:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+ExSpaz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC5914A4C1;
	Tue, 27 Feb 2024 22:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709072126; cv=none; b=Wlz2z3RsOR4I+uRNKWDSjc+p+9pY5beZa2Us+QdomVr28no7y+AbF5/yfvWpy+bN1oWX1lc8xrjhTVnNelNxoYYx64iaQwjbJR1M3ADAvHUoYvuvddDrvW2kZKyhpGh2RpHv33cSrVXow3+zGH/mloJmLop4Q5eFmpmXH6g3pfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709072126; c=relaxed/simple;
	bh=H0bRBi5Hvxdu8BhZUiSwQ4zqP2aNAbrTGOFlAL9HJGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRJpILg9Q4wNWrAqybdiom4aIepTM505+F7ye0tU9YU7fLv2L3Iu6FrHy3kJneI7Bf9jH/sATwo3GtFSFHAjBlhmlj5Le/GBlggFDDeuvwAEHF4ro9DJ3Zs6UcHaFwgPSJ0JLr0KLYxSqZCL0WAkKgzyH5OiL7F0ug81vJVaTb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+ExSpaz; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-21fa086008fso2470019fac.0;
        Tue, 27 Feb 2024 14:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709072123; x=1709676923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QeQuoKsMqjADISGm2Hn4uU+Ji8iXgLUMY646RY4awK4=;
        b=E+ExSpaz512qXQYvzThd7vyHe4ps4Hxku54ysZaNCyn91FkpMVRQlTb1ZjZbOPh2j8
         XJXXJmk+09cDNR1z30ZF3itqcHMVxWTESiKxvjBNnnRZzKWjyWavlotKls6UOOHziV5K
         W8J8+7WbJQx5iF2vEhU4pA7wHwBa/ejWZbeawudDh/ncuSc3q7fw/25QZOCxUAMCbFSV
         +oBuYZhiblPhbUK54pvRAPwvZ9IVqyS9khSkhNEcKVEm2O1q1CnLoDUXYGV8L6UZUIK0
         mFgRN1K3Ygta5JFKXnkMO0PJPwZtZ7UyfsbdV2v5S/wubz/bE0QX802c5HalMqcZ/Yas
         8FuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709072123; x=1709676923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QeQuoKsMqjADISGm2Hn4uU+Ji8iXgLUMY646RY4awK4=;
        b=H0KFeOGx1C4Stnm0+uocBq79iPgcs4+fD78F4CF4QzQ7QFIfbkeAxcTZEbWbk1mA1b
         bf4OnYXyGM3bafX9m0oXW5kjgsZcTkSi/bFFjgf287MABxh8+h0+7OY1py16A9XVULRK
         +mnbcrh3/y09O6TAjP+jM9NE0BdA1zueBHx84JYQkNQoCBLQoSATtRAuYOZKwI0g0qFF
         rnLmtFlfLtnolf/ZjVGcBk7CmSz6pcJiRQFNzlQ4+0PLakyAEnVVt6/9OPPO+Qv3WGdz
         1/yG+UKWMTxOI/NiPKTAZG4Sr1smWDsk6rzuxY0H78uwa9A6J6azCvrT5JBt57/qNOKQ
         fZwA==
X-Forwarded-Encrypted: i=1; AJvYcCVu0K0uozfvVS0Apd4r2i3KlRjvgL7w1HbWLcaqjpyYGICzKZs7JTBS9c0RheIgamdpCeb3e7sO3ojlzD/RXITE+hG6hSrHuuaAYDsioL+SW20TgetleZXDSZofYqKR3TacbgavZrALzO0psNGNtUlaU7nj+88H21bLfdJJGX7mc3Vx5mqB0bpY8ozZzrmP12X6ps8HgGB80zoanJVh38Rk9g==
X-Gm-Message-State: AOJu0YwhNMX1qk7uePPSKg52E61jBcyLsoLFqXEtjpKQePTcJbGCAWyW
	dY7ekQxNOSQRNR5io+BSJaqoG/coQKLsyCNDkGFeTLP6sPY/uSpxwm4dU546nr4=
X-Google-Smtp-Source: AGHT+IG+nWjzy1vXAWmi7d4mreq3B1aqw1Sej/iFVDg9WGc8pdhcR0YbATO4JmgBoO6xtBE1Kqr+ZQ==
X-Received: by 2002:a05:6870:c112:b0:21f:ccef:a4d0 with SMTP id f18-20020a056870c11200b0021fccefa4d0mr10576079oad.21.1709072123242;
        Tue, 27 Feb 2024 14:15:23 -0800 (PST)
Received: from Borg-9.local (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id gq27-20020a056870d91b00b0021fb8dc5cabsm2257249oab.47.2024.02.27.14.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 14:15:22 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Tue, 27 Feb 2024 16:15:21 -0600
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
Subject: Re: [RFC PATCH 17/20] famfs: Add module stuff
Message-ID: <ydr7ziya3e5evsdbofcqgestidkrjv7opsb6behlcs5oew4kbo@zhyhhzuh26ma>
References: <cover.1708709155.git.john@groves.net>
 <e633fb92d3c20ba446e60c2c161cf07074aef374.1708709155.git.john@groves.net>
 <20240226134748.00003f57@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226134748.00003f57@Huawei.com>

On 24/02/26 01:47PM, Jonathan Cameron wrote:
> On Fri, 23 Feb 2024 11:42:01 -0600
> John Groves <John@Groves.net> wrote:
> 
> > This commit introduces the module init and exit machinery for famfs.
> > 
> > Signed-off-by: John Groves <john@groves.net>
> I'd prefer to see this from the start with the functionality of the module
> built up as you go + build logic in place.  Makes it easy to spot places
> where the patches aren't appropriately self constrained. 
> > ---
> >  fs/famfs/famfs_inode.c | 44 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> > 
> > diff --git a/fs/famfs/famfs_inode.c b/fs/famfs/famfs_inode.c
> > index ab46ec50b70d..0d659820e8ff 100644
> > --- a/fs/famfs/famfs_inode.c
> > +++ b/fs/famfs/famfs_inode.c
> > @@ -462,4 +462,48 @@ static struct file_system_type famfs_fs_type = {
> >  	.fs_flags	  = FS_USERNS_MOUNT,
> >  };
> >  
> > +/*****************************************************************************************
> > + * Module stuff
> 
> I'd drop these drivers structure comments. They add little beyond
> a high possibility of being wrong after the code has evolved a bit.

Probably will do with the module-ops-up refactor for v2

> 
> > + */
> > +static struct kobject *famfs_kobj;
> > +
> > +static int __init init_famfs_fs(void)
> > +{
> > +	int rc;
> > +
> > +#if defined(CONFIG_DEV_DAX_IOMAP)
> > +	pr_notice("%s: Your kernel supports famfs on /dev/dax\n", __func__);
> > +#else
> > +	pr_notice("%s: Your kernel does not support famfs on /dev/dax\n", __func__);
> > +#endif
> > +	famfs_kobj = kobject_create_and_add(MODULE_NAME, fs_kobj);
> > +	if (!famfs_kobj) {
> > +		pr_warn("Failed to create kobject\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	rc = sysfs_create_group(famfs_kobj, &famfs_attr_group);
> > +	if (rc) {
> > +		kobject_put(famfs_kobj);
> > +		pr_warn("%s: Failed to create sysfs group\n", __func__);
> > +		return rc;
> > +	}
> > +
> > +	return register_filesystem(&famfs_fs_type);
> 
> If this fails, do we not leak the kobj and sysfs groups?

Good catch, thanks! Fixed for now- but the kobj is also likely to go away. Will
endeavor to get it right...

Thanks,
John


