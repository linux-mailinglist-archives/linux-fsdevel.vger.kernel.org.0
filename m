Return-Path: <linux-fsdevel+bounces-13012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AF086A270
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 23:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D084285AAF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 22:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DE9153518;
	Tue, 27 Feb 2024 22:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdNOOgcm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E2E4CE17;
	Tue, 27 Feb 2024 22:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709072832; cv=none; b=D1mWKjaWCf8BxdvCkvJ/e1Mgydet6GDZl7Dx44HTym5Gjcw74CAdQb/0dMF8xYROu76u6jngAd+8dNskosTUDGHaUjOxoc0Git0Wv+MZXc3vQJC7qi9lT6DzpqIOimnq563Ns5PoVBIPkBE4CxMAqYaW7ZjdoBBE74AAjbsO2xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709072832; c=relaxed/simple;
	bh=DUwlnHLU8UMerEe2jsOFQdmLjtd1zzuOtaTj9wFrXi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2qGJkcbjC6GHjZPtx924f7Qbw5DExhbnqgbq20jGMDSOR5Q4aCg3eh9JMIibMcXWi/rdBB2MF/RMGTknyK00MVPBf1Rtmsdtfdi7AY4gmxNzFdJeluI9AK+CzgvcZR+X4nSzUIUs9hys6jCJtV6IWhL+cbUwqBU6A1rRggqngE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdNOOgcm; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-22034c323a3so920677fac.0;
        Tue, 27 Feb 2024 14:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709072829; x=1709677629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=czSfIwYqcAAlEOGZom62daR/kwIkMGAHkEzj8k6AIb8=;
        b=MdNOOgcmecxagt6VFv+Isx/ZglugCRCnxQCS5dA51Sc+loJmdWn5c58Hw3Fy46PGC3
         n02pnH8ZtXhyXwwP6bdI7mseAnnFCTEx1KYOgWIwwoW4hWIaw3uZp+Lt+0LK043GEwFi
         Vv1grI0+i0dlbHo0d/J0ioybVgjLkmWSTMdoMW/4RhBmjO1e4AIdawTr8MtTdppqkyiy
         6uZA3LwMujXC82XDpcAirTMci8rfOsCZCJ8C5vmdncEYkpOeQGfP0KBT0mteWa1dqXJ2
         AM3cNLhEF1Tpuyr3WstOhXWa9AUWWeTU1Fh1/w/QNOoIaX8fd674h2+5upml7R33HmiY
         6YcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709072829; x=1709677629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czSfIwYqcAAlEOGZom62daR/kwIkMGAHkEzj8k6AIb8=;
        b=C/VGsrkEs6hIfHDWiJ3RvcHPdACQXi3AjlSgcP/XKBvet1EOix4zaFCvJE6TrsuVmy
         B7qiu8H+cEmNVS+z7wxYzQezm2bWT7n0He7fFMOf3KD10syRB3wSDXUHfnW3R6jTBqHM
         QwqPinQKlvjIn6JshM46Yb0QAuke55mefijXUyr6gIfxDOhtxrTI/fMslKssI/LZwmlJ
         utWUuQujAC2T9MINvCSgG0Y8N8nCW9wBJQZuJY42iHVsPQC5/B0nUbFXdjaXn7LeeOQL
         MsKhNh+dqKdlDB985iPNuHSIq5ijuywXO/ZeM5CsnjBZoMNKaSIXJ0tlL5fuTTA0HF5A
         /KlA==
X-Forwarded-Encrypted: i=1; AJvYcCUoIqqPdTnBu5atQqVX+ek/fFTsDROkVICAmysEwcCCw/r5J7rai++nkVFqCaB4Hsv1OzDF+9IPVH4y+6wOsWWGhtj/uJf4xdPwG3V6iWgtQGGfPBFltMkkrjBXpZBcZB8htXDlEBRNvA7RDMMjmg1zN7Bx4OwRILvJAU3dUNw/ddUAkqcAL/IqYns0ZHg5jzMemKKquQR6n438jawrAw+Qrw==
X-Gm-Message-State: AOJu0YwSjM+/fOmH9rlm8hbXX7WzrOtrdNKjGvimnG5DQES05zpkNOdE
	HOdRl1CErzL7RXlSKKhX6i9n91S0Tp2h/Mltm94/hL6zQpfwDcvt
X-Google-Smtp-Source: AGHT+IEKbYA01YSpW2OAyT0uYT5pzb31FUNW6KvOwjzPB90Y5misMgivhaltW4TUa9HNsFIdgb0pig==
X-Received: by 2002:a05:6870:e9a8:b0:220:971:ab2e with SMTP id r40-20020a056870e9a800b002200971ab2emr8197913oao.41.1709072828832;
        Tue, 27 Feb 2024 14:27:08 -0800 (PST)
Received: from Borg-9.local (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id c2-20020a05687091c200b0021e88b471f2sm2236413oaf.26.2024.02.27.14.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 14:27:08 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Tue, 27 Feb 2024 16:27:06 -0600
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
Subject: Re: [RFC PATCH 18/20] famfs: Support character dax via the
 dev_dax_iomap patch
Message-ID: <iwcbiag4hrcbbpujd6xqatfq77oxdab7a7eeqbstg64u62edad@5bfru25qxz37>
References: <cover.1708709155.git.john@groves.net>
 <fa06095b6a05a26a0a016768b2e2b70663163eeb.1708709155.git.john@groves.net>
 <20240226135228.00007714@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226135228.00007714@Huawei.com>

On 24/02/26 01:52PM, Jonathan Cameron wrote:
> On Fri, 23 Feb 2024 11:42:02 -0600
> John Groves <John@Groves.net> wrote:
> 
> > This commit introduces the ability to open a character /dev/dax device
> > instead of a block /dev/pmem device. This rests on the dev_dax_iomap
> > patches earlier in this series.
> 
> Not sure the back reference is needed given it's in the series.

Roger that

> 
> > 
> > Signed-off-by: John Groves <john@groves.net>
> > ---
> >  fs/famfs/famfs_inode.c | 97 +++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 87 insertions(+), 10 deletions(-)
> > 
> > diff --git a/fs/famfs/famfs_inode.c b/fs/famfs/famfs_inode.c
> > index 0d659820e8ff..7d65ac497147 100644
> > --- a/fs/famfs/famfs_inode.c
> > +++ b/fs/famfs/famfs_inode.c
> > @@ -215,6 +215,93 @@ static const struct super_operations famfs_ops = {
> >  	.show_options	= famfs_show_options,
> >  };
> >  
> > +/*****************************************************************************/
> > +
> > +#if defined(CONFIG_DEV_DAX_IOMAP)
> > +
> > +/*
> > + * famfs dax_operations  (for char dax)
> > + */
> > +static int
> > +famfs_dax_notify_failure(struct dax_device *dax_dev, u64 offset,
> > +			u64 len, int mf_flags)
> > +{
> > +	pr_err("%s: offset %lld len %llu flags %x\n", __func__,
> > +	       offset, len, mf_flags);
> > +	return -EOPNOTSUPP;
> > +}
> > +
> > +static const struct dax_holder_operations famfs_dax_holder_ops = {
> > +	.notify_failure		= famfs_dax_notify_failure,
> > +};
> > +
> > +/*****************************************************************************/
> > +
> > +/**
> > + * famfs_open_char_device()
> > + *
> > + * Open a /dev/dax device. This only works in kernels with the dev_dax_iomap patch
> 
> That comment you definitely don't need as this won't get merged without
> that patch being in place.

This will be gone from v2. I'm 90% sure there is no reason to keep the block
device backing support (pmem), since devdax is the point AND pmem can be
converted to devdax mode. So famfs will become devdax only...etc.

This was under development for quite a few months, and actually working,
I got the dev_dax_iomap right (er, "right enough" for it to work :D). But now
that dev_dax_iomap looks basically stable, pmem/block support can come out.

> 
> 
> > + */
> > +static int
> > +famfs_open_char_device(
> > +	struct super_block *sb,
> > +	struct fs_context  *fc)
> > +{
> > +	struct famfs_fs_info *fsi = sb->s_fs_info;
> > +	struct dax_device    *dax_devp;
> > +	struct inode         *daxdev_inode;
> > +
> > +	int rc = 0;
> set in all paths where it's used.
> 
> > +
> > +	pr_notice("%s: Opening character dax device %s\n", __func__, fc->source);
> 
> pr_debug

Done

> 
> > +
> > +	fsi->dax_filp = filp_open(fc->source, O_RDWR, 0);
> > +	if (IS_ERR(fsi->dax_filp)) {
> > +		pr_err("%s: failed to open dax device %s\n",
> > +		       __func__, fc->source);
> > +		fsi->dax_filp = NULL;
> Better to use a local variable
> 
> 	fp = filp_open(fc->source, O_RDWR, 0);
> 	if (IS_ERR(fp)) {
> 		pr_err.
> 		return;
> 	}
> 	fsi->dax_filp = fp;
> or similar.

Done, thanks.

> 
> > +		return PTR_ERR(fsi->dax_filp);
> > +	}
> > +
> > +	daxdev_inode = file_inode(fsi->dax_filp);
> > +	dax_devp     = inode_dax(daxdev_inode);
> > +	if (IS_ERR(dax_devp)) {
> > +		pr_err("%s: unable to get daxdev from inode for %s\n",
> > +		       __func__, fc->source);
> > +		rc = -ENODEV;
> > +		goto char_err;
> > +	}
> > +
> > +	rc = fs_dax_get(dax_devp, fsi, &famfs_dax_holder_ops);
> > +	if (rc) {
> > +		pr_info("%s: err attaching famfs_dax_holder_ops\n", __func__);
> > +		goto char_err;
> > +	}
> > +
> > +	fsi->bdev_handle = NULL;
> > +	fsi->dax_devp = dax_devp;
> > +
> > +	return 0;
> > +
> > +char_err:
> > +	filp_close(fsi->dax_filp, NULL);
> 
> You carefully set fsi->dax_filp to null in other other error paths.
> Why there and not here?

Why indeed - done now.

> 
> > +	return rc;
> > +}
> > +
> > +#else /* CONFIG_DEV_DAX_IOMAP */
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
> > +
> > +#endif /* CONFIG_DEV_DAX_IOMAP */
> > +
> >  /***************************************************************************************
> >   * dax_holder_operations for block dax
> >   */
> > @@ -236,16 +323,6 @@ const struct dax_holder_operations famfs_blk_dax_holder_ops = {
> >  	.notify_failure		= famfs_blk_dax_notify_failure,
> >  };
> >  
> 
> Put it in right place earlier! Makes this less noisy.

This will be eliminated by the move to /dev/dax-only

Thanks,
John


