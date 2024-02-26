Return-Path: <linux-fsdevel+bounces-12888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B95C386838D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 23:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E2E8285F05
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 22:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E19131E5B;
	Mon, 26 Feb 2024 22:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMeBzee4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15084131E3F;
	Mon, 26 Feb 2024 22:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708986135; cv=none; b=GNhMbt3VgyaKzf3tpNE8JcMBR8K2VdyA0hLHWTf2sVgyWvALMD/iwtvbDlAu6kkBxyk2DibG5gkjQ3dUI5DQlR5gb2FtV6uLCyP1IRQzaCnnYTFIqIGokl8t2SEpkGulHtoZfSmgMbSuIN+oK5ejuM2B3z8ZAZrCfXc3g0ya5hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708986135; c=relaxed/simple;
	bh=9B9sVk95/X6RVwf+p1Qn/KhyyBM6EhLa8TimasuHcWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pp4BMSMpdcf95S9tA9BPQ7bjpi4oX6XRTkkWi1K0dcnAps4kaBTTgT7z+pjX9VxIXenypbr1VsysxWRJycsRHLJKN7apsr5P1GHUdnRLR0Wsqhjc4h7qpSBjjFIRykNalCgsAqxXM7L1FlJPsV8E4WhSNFfSeb0fQF26yJuPFBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMeBzee4; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c19bc08f96so1752168b6e.2;
        Mon, 26 Feb 2024 14:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708986133; x=1709590933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uCljusvDbpC85XBVMK3c5kvPOrdu09iyxvjz7pu6Gtk=;
        b=fMeBzee4rdGqRf++KZpHwK7fHc2KRak3BUg2XDr3gOIp1HTm4uKJhiOT13ukFACDBM
         CBh3Z6QSKr4UjoYxztmAUvdsvnyJG6B9Rp1B1VdCA9SxWIQASYb6y4gl11PcufsYGTrO
         xUhzTwlTdkJtDS2HL+CVIJiaeXDRTSChPHhTcHFj5ql5PaPwxt2OOqlaftJ7REsNwiWN
         TxzTXcmNAq+x/xv7BKV4m+ZxGAoUr92ltlUgj0LchQP/SfqW7ladtmkvU2ABsYqvM5vK
         m4nNhTJFOHN3dNyjWqKZ1NSfm/vQkxjjU0yjQYXDVPH44zhAFQHnQnUuJ8t1WRmNnkrI
         f8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708986133; x=1709590933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uCljusvDbpC85XBVMK3c5kvPOrdu09iyxvjz7pu6Gtk=;
        b=dZ3FcY8n8YULEBQ7+deg+QT5m6E/R+7rBaSTGHKm3QP8UvRctVkB8c1RW8t6JOEAJm
         ncju6Pfidtt2L2UAKJ/DCsQdjfz1H78LwJGKw73Pkq5yne4DoC0Qt46bq04wvxzgQDSQ
         Bc7l2novsCR+RKeNLI7Lzz6M9UrN4AGUho5G1mxFEwNjae0MEtcxLeiaMcBhvj8/fTMe
         tqYlneV1BkVuazZRjqIfP1N+YvGGlahujqVRZp1IAWqNaGdOC0iCBKa5ONdfFMOWmJ2G
         +bSS5UGvB1l9LTrMAJUJK84HPaZpABYm7d5sjAmNIsWxPrFvm8YhNxiIJk6KKR1iwbLM
         6f/g==
X-Forwarded-Encrypted: i=1; AJvYcCWI2vmopXK3UjJyM3SzokcPDBUXKySdHHe5GhHync58JDBo/zpVD3uPhZV60H6IOc75cm4TOwBLrCyuDhcPw5u2PAIhniVDcZPn5oMWUEzwN9cbx4NrBUhF0q9kZacXWMCDlr3mOBVfNDE/HsDWlwVjBKifrn0Z/O0Afn+Dh6qSgWXnppG/StLzrrfzByd5h4lijWc40zNuyuXawt+8xbkx1w==
X-Gm-Message-State: AOJu0YwEuNwUwsF1kJU3Q2CWRQFYfGwLUVnDQkAMP92khA94Xw+yndnO
	O2Qa+09Pfsy/HxlGIqN2m8sFc8H6gRKVREp5ckKedblU4F10JfBC
X-Google-Smtp-Source: AGHT+IH9/ZHMOlN9m2pQ3tNxm4b1iBEwlbsa1DLKOeAJmdm28kiQkwzlw6kslYe8H3uqCwJle03KrA==
X-Received: by 2002:a05:6808:168e:b0:3c0:3752:626f with SMTP id bb14-20020a056808168e00b003c03752626fmr434507oib.58.1708986133186;
        Mon, 26 Feb 2024 14:22:13 -0800 (PST)
Received: from Borg-9.local (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id d17-20020a05680805d100b003c1ad351e43sm50022oij.1.2024.02.26.14.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 14:22:12 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Mon, 26 Feb 2024 16:22:11 -0600
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
Subject: Re: [RFC PATCH 10/20] famfs: famfs_open_device() &
 dax_holder_operations
Message-ID: <xslmwjulygnvrqvzevrzj5clalxwhqnmv5p2k2yvrp56bkqdn6@bbdmfeb24axf>
References: <cover.1708709155.git.john@groves.net>
 <74359fdc83688fb1aac1cb2c336fbd725590a131.1708709155.git.john@groves.net>
 <20240226125642.000076d2@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226125642.000076d2@Huawei.com>

On 24/02/26 12:56PM, Jonathan Cameron wrote:
> On Fri, 23 Feb 2024 11:41:54 -0600
> John Groves <John@Groves.net> wrote:
> 
> > Famfs works on both /dev/pmem and /dev/dax devices. This commit introduces
> > the function that opens a block (pmem) device and the struct
> > dax_holder_operations that are needed for that ABI.
> > 
> > In this commit, support for opening character /dev/dax is stubbed. A
> > later commit introduces this capability.
> > 
> > Signed-off-by: John Groves <john@groves.net>
> 
> Formatting comments mostly same as previous patches, so I'll stop repeating them.

I tried to bulk apply those recommendations.

> 
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
> > +	struct super_block *sb,
> > +	struct fs_context  *fc)
> > +{
> > +	struct famfs_fs_info *fsi = sb->s_fs_info;
> > +	struct dax_device    *dax_devp;
> > +	u64 start_off = 0;
> > +	struct bdev_handle   *handlep;
> Definitely don't force alignment in local parameter definitions.
> Always goes wrong and makes for unreadable mess in patches!

Okay, undone. Everywhere.

> 
> > +
> > +	if (fsi->dax_devp) {
> > +		pr_err("%s: already mounted\n", __func__);
> Fine to fail but worth a error message? Not sure on convention on this but seems noisy
> and maybe in userspace control which isn't good.

Changing to pr_debug. Would be good to have access to it in that way

> > +		return -EALREADY;
> > +	}
> > +
> > +	if (strstr(fc->source, "/dev/dax")) /* There is probably a better way to check this */
> > +		return famfs_open_char_device(sb, fc);
> > +
> > +	if (!strstr(fc->source, "/dev/pmem")) { /* There is probably a better way to check this */
> > +		pr_err("%s: primary backing dev (%s) is not pmem\n",
> > +		       __func__, fc->source);
> > +		return -EINVAL;
> > +	}
> > +
> > +	handlep = bdev_open_by_path(fc->source, FAMFS_BLKDEV_MODE, fsi, &fs_holder_ops);
> > +	if (IS_ERR(handlep->bdev)) {
> > +		pr_err("%s: failed blkdev_get_by_path(%s)\n", __func__, fc->source);
> > +		return PTR_ERR(handlep->bdev);
> > +	}
> > +
> > +	dax_devp = fs_dax_get_by_bdev(handlep->bdev, &start_off,
> > +				      fsi  /* holder */,
> > +				      &famfs_blk_dax_holder_ops);
> > +	if (IS_ERR(dax_devp)) {
> > +		pr_err("%s: unable to get daxdev from handlep->bdev\n", __func__);
> > +		bdev_release(handlep);
> > +		return -ENODEV;
> > +	}
> > +	fsi->bdev_handle = handlep;
> > +	fsi->dax_devp    = dax_devp;
> > +
> > +	pr_notice("%s: root device is block dax (%s)\n", __func__, fc->source);
> 
> pr_debug()  Kernel log is too noisy anyway! + I'd assume we can tell this succeeded
> in lots of other ways.

Done

> 
> 
> > +	return 0;
> > +}
> > +
> > +
> >  
> >  MODULE_LICENSE("GPL");

Thanks,
John
> 

