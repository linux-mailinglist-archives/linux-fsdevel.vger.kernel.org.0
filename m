Return-Path: <linux-fsdevel+bounces-12998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3574869F38
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 19:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C7721F2B082
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 18:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9901E487B4;
	Tue, 27 Feb 2024 18:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVayI6bx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9FF4A2D;
	Tue, 27 Feb 2024 18:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709059101; cv=none; b=LsaTjMaDkse4ScMU8jyePYttQa3TZBE0yUzqAsS074iN8hIoYsr/TicEClIWDYzUegPOU0gyQx+J2nynjeR+5jt7Rkxrk+F80GJbe8NrvGzOc4aK2Q0a0ookN5vPOLCXbPom8jXYcoiN8fAjdWaETVIIsV/oq/6GGyILT5cmpeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709059101; c=relaxed/simple;
	bh=KD1jGm7vKVoOgTdYtRTFbIEQwpq2vLQ0E1ZK54nuRxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggPPlw+Ti9aeGBZgkhTApl0j5D3rIf6sNtXCRYsmYxc9iBFjgK1QQgoDFBdah0O+9lnrRQZzvP2a6fqO9BxKeAiQATFV8zFAUtEbZOohzP5GvDdiGd69ePtvgznMPr4qWeOzlTjECyjEc8lWSrmzRG44qt+b10BECGGs0T/75RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVayI6bx; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bb9d54575cso3624275b6e.2;
        Tue, 27 Feb 2024 10:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709059098; x=1709663898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SACYrnqIZ8nbOqLr4JZuW46LtAQDPnmcG2NHqWDBIBI=;
        b=jVayI6bx0yJad1Y01EMUnPAzx7RV4aLHuz9WtkHCxKAf3c+23plGmai7zH2yC/K5ZP
         OsgPkgsvWZnpfNFeFgYrigmfyRJ6Ww08NM+5ZU4lyhQniirK9ZunVXt8CBw97Wt/XS7o
         6AD7v556ksICWyiu6uW2EEI9lRiiPRcubtxNA3gM0UZv0vUq6c9gVxlp8pdD9Xy0Bd7X
         j2DiuP2biz5Y69SgcVsdT8KacycgfIR3YEzNxRZQRFntDfuaVUQvJns2wtAWnWpzxnX9
         fv8CXiJQPt4yixt/qPj1ypDj7ImFdQ4bJqbSLAEoeBEkKHiEZGbxXgf37oV9ATQq/bxv
         tYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709059098; x=1709663898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SACYrnqIZ8nbOqLr4JZuW46LtAQDPnmcG2NHqWDBIBI=;
        b=GyWVuh3T0Xp63fDTpLEuBeAeExCXmRNd7n38KveLIwn4HFAXRuuto/BIG6k+WWHTqn
         esLyIBa8qEX1y/ooPj4S78DNFhjgTAl++d38/KBKQJriSxzCvb1tYWIGgp5J0DFpwt2i
         bF7d5yW7toi+Y7k9yF+08H5+YNCpDRojXmI13lHGI85jYHyeQVMFxwqU0BCHY7SGFuJX
         oU6s0rD/1PqekorjsAVqaMXvQnRnGmg4t6mtss47ztuYm0q9C70HeZQt9iGXLH9om0so
         jQMQSyWrYZQAFZy46qeM0A/FszBxfUWclVODXLANfgQMrghARJD0byd1JoGFEkwoiosc
         516w==
X-Forwarded-Encrypted: i=1; AJvYcCW9nzSHsrf4RODEZvdUCNKxcsr7fV4MxW25HogcJGAEJ4s01PpIlzHg2zQK3lPTfLfaVdofV80pb/4fkPC8NAuOTap7URi7O4vUMRnqTe2F+X3DsR++wNGy6kEDZhWSA7gD+iwMQU7/O2CRerPVWUOeChg829wjZVtx/Gjyil7H9j9W1Wxr3ORQhaRESJto0iDPXdQlCxNx9m2mpdrXbsNtJA==
X-Gm-Message-State: AOJu0YyUOvMSG0RmsZOKi06ZdWd2g9JQbO+m5tSus5ee0Yjq4HMKvIfV
	1dVrVOaZqWIkm+prI8rNDQN2jNmskxz5seDp7xflmAkhumwY40qP
X-Google-Smtp-Source: AGHT+IGOvteQBz+IDBACbdnQn948atE6oRH0HpzbswyOJvZR99vuzL+t2zUWd+R6Im3I8SlzA+V40w==
X-Received: by 2002:a05:6808:8f3:b0:3c1:7d8d:29b9 with SMTP id d19-20020a05680808f300b003c17d8d29b9mr2670074oic.21.1709059098126;
        Tue, 27 Feb 2024 10:38:18 -0800 (PST)
Received: from Borg-9.local (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id r12-20020a0568080aac00b003c15ac41417sm1522831oij.39.2024.02.27.10.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 10:38:17 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Tue, 27 Feb 2024 12:38:15 -0600
From: John Groves <John@groves.net>
To: Christian Brauner <brauner@kernel.org>
Cc: John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, linux-cxl@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, john@jagalactic.com, Dave Chinner <david@fromorbit.com>, 
	Christoph Hellwig <hch@infradead.org>, dave.hansen@linux.intel.com, gregory.price@memverge.com
Subject: Re: [RFC PATCH 10/20] famfs: famfs_open_device() &
 dax_holder_operations
Message-ID: <ups6cvjw6bx5m3hotn452brbbcgemnarsasre6ep2lbe4tpjsy@ezp6oh5c72ur>
References: <74359fdc83688fb1aac1cb2c336fbd725590a131.1708709155.git.john@groves.net>
 <20240227-aufhalten-funkspruch-91b2807d93a7@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227-aufhalten-funkspruch-91b2807d93a7@brauner>

On 24/02/27 02:39PM, Christian Brauner wrote:
> On Fri, Feb 23, 2024 at 11:41:54AM -0600, John Groves wrote:
> > Famfs works on both /dev/pmem and /dev/dax devices. This commit introduces
> > the function that opens a block (pmem) device and the struct
> > dax_holder_operations that are needed for that ABI.
> > 
> > In this commit, support for opening character /dev/dax is stubbed. A
> > later commit introduces this capability.
> > 
> > Signed-off-by: John Groves <john@groves.net>
> > ---
> >  fs/famfs/famfs_inode.c | 83 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 83 insertions(+)
> > 
> > diff --git a/fs/famfs/famfs_inode.c b/fs/famfs/famfs_inode.c
> > index 3329aff000d1..82c861998093 100644
> > --- a/fs/famfs/famfs_inode.c
> > +++ b/fs/famfs/famfs_inode.c
> > @@ -68,5 +68,88 @@ static const struct super_operations famfs_ops = {
> >  	.show_options	= famfs_show_options,
> >  };
> >  
> > +/***************************************************************************************
> > + * dax_holder_operations for block dax
> > + */
> > +
> > +static int
> > +famfs_blk_dax_notify_failure(
> > +	struct dax_device	*dax_devp,
> > +	u64			offset,
> > +	u64			len,
> > +	int			mf_flags)
> > +{
> > +
> > +	pr_err("%s: dax_devp %llx offset %llx len %lld mf_flags %x\n",
> > +	       __func__, (u64)dax_devp, (u64)offset, (u64)len, mf_flags);
> > +	return -EOPNOTSUPP;
> > +}
> > +
> > +const struct dax_holder_operations famfs_blk_dax_holder_ops = {
> > +	.notify_failure		= famfs_blk_dax_notify_failure,
> > +};
> > +
> > +static int
> > +famfs_open_char_device(
> > +	struct super_block *sb,
> > +	struct fs_context  *fc)
> > +{
> > +	pr_err("%s: Root device is %s, but your kernel does not support famfs on /dev/dax\n",
> > +	       __func__, fc->source);
> > +	return -ENODEV;
> > +}
> > +
> > +/**
> > + * famfs_open_device()
> > + *
> > + * Open the memory device. If it looks like /dev/dax, call famfs_open_char_device().
> > + * Otherwise try to open it as a block/pmem device.
> > + */
> > +static int
> > +famfs_open_device(
> 
> I'm confused why that function is added here but it's completely unclear
> in what wider context it's called. This is really hard to follow.

First, thank you for taking the time to do a thoughtful review.

I didn't factor this series correctly. The next one will be
"module-operations-up" unless you or somebody suggests a more sensible
approach.

Some background that might be useful: this work is really targeted for 
/dev/dax, but it started on /dev/pmem because the iomap interface wasn't 
working on /dev/dax. This patch addresses that (the dev_dax_iomap commits), 
although it's likely that code will evolve.

The current famfs code base tries to support both pmem (block) and /dev/dax 
(char), but I'm now thinking it should move to /dev/dax-only (no block 
support).

/dev/pmem devices can converted to /dev/dax mode anyway, so I'm not sure 
there is a reason to support both interfaces. (Need to think a bit more on 
that...).

> 
> > +	struct super_block *sb,
> > +	struct fs_context  *fc)
> > +{
> > +	struct famfs_fs_info *fsi = sb->s_fs_info;
> > +	struct dax_device    *dax_devp;
> > +	u64 start_off = 0;
> > +	struct bdev_handle   *handlep;
> > +
> > +	if (fsi->dax_devp) {
> > +		pr_err("%s: already mounted\n", __func__);
> > +		return -EALREADY;
> > +	}
> > +
> > +	if (strstr(fc->source, "/dev/dax")) /* There is probably a better way to check this */
> > +		return famfs_open_char_device(sb, fc);
> > +
> > +	if (!strstr(fc->source, "/dev/pmem")) { /* There is probably a better way to check this */
> 
> Yeah, this is not just a bit ugly but also likely wrong because:
> 
> sudo mount --bind /dev/pmem /opt/muhaha
> 
> fsconfig(fd_fs, FSCONFIG_SET_STRING, "source", "/opt/muhaha", [...])
> 
> or a simple mknod to create that device somewhere else. You likely want:
> 
> lookup_bdev(fc->source, &dev);
> 
> if (!DEVICE_NUMBER_SOMETHING_SOMETHING_SANE(dev))
> 	return invalfc(fc, "SOMETHING SOMETHING...
> 
> bdev_open_by_dev(dev, ....)
> 
> (This reminds me that I should get back to making it possible to specify
> "source" as a file descriptor instead of a mere string with the new
> mount api...)

All good points - sorry for the flakyness here.

I think the solution is to stop trying to support both pmem and dax. Then 
I don't need to distinguish between different device types.

> 
> > +		pr_err("%s: primary backing dev (%s) is not pmem\n",
> > +		       __func__, fc->source);
> > +		return -EINVAL;
> > +	}
> > +
> > +	handlep = bdev_open_by_path(fc->source, FAMFS_BLKDEV_MODE, fsi, &fs_holder_ops);
> 
> Hm, I suspected that FAMFS_BLKDEV_MODE would be wrong based on:
> https://lore.kernel.org/r/13556dbbd8d0f51bc31e3bdec796283fe85c6baf.1708709155.git.john@groves.net
> 
> It's defined as FMODE_READ | FMODE_WRITE which is wrong. But these
> helpers want BLOCK_OPEN_READ | BLOCK_OPEN_WRITE.

Dropping pmem/block support will also make this go away

> 
> > +	if (IS_ERR(handlep->bdev)) {
> 
> @bdev_handle will be gone as of v6.9 so you might want to wait until
> then to resend.

And this dependency will also disappear...

Thank you!!
John


