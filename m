Return-Path: <linux-fsdevel+bounces-12961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 421AD869A40
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 16:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A73621F2305E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 15:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737EE1420B3;
	Tue, 27 Feb 2024 15:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ItidPi8m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2276C130E2A
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 15:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709047351; cv=none; b=TFXt/b7OTwwSyjEbpDKOf35yQBp3H3s39Wi3jIF37gep4X7YYK1ZsiZzTZxFTpC2wiZT1ru7lPPCC1Tiejhl7PoFTdSlXyoSwUzF/m7kwic9AUuKjeYrTIGT90mCwkyCc6HnSZ8V/1xMV3E3GFcb5aFAytvtXjCGZP2A7HwhZgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709047351; c=relaxed/simple;
	bh=bt+eNnxaUZ9eBVYvB4dgwW24uzdeN3tCauvZQOCgP2k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aKp5i4TiuKlERK7shh6V55ronI2mxx/d1ECSpWzfoc7ussHXGe3b7s7NUUUjgT/lnwSp7o18h7EKBal18OZ/KBQsNXG83dGTQw53J6j5VfuvIq6CXKb/liHY42teEaKLeH4tyAtRqHYXwsx/hH29+NPeHcaJ2DKZcXVOy/Lvapo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ItidPi8m; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33d90dfe73cso3007261f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 07:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709047348; x=1709652148; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZP15jhwQqyp1M8J8HnBxXA/u8DsN0LSl5saNKrx5gFs=;
        b=ItidPi8mKSSUaM+lHWN1V6qHjCIloToEO3Kv2sdgfhOlESU5jIg7z/HwPWMdxkVnzB
         5Z/5trcnjvUnXQYjqzTpZRbSBDZJLZoIbfcP7HTjqkb2exJOzfIL0/MkMewzX/3rxcD4
         DovK7djQTuiYRbypw5fhM22780gO01Po8uX0eThfQFVGhp8EtvySE/yNlu8l3LQXORBX
         l5oNqVyK2/QKlwlNpy27Z6dEEM6CK3I9wvoaakgrmfrq0mAdt6JZTUUBhJs4+ZglnG9x
         xq81prDQE3e7ADSqvsPj7ziBxNfrs7H5ZP/Itq8fLuJvIHfRyonrxUpkMBSn+iIHvop/
         yOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709047348; x=1709652148;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZP15jhwQqyp1M8J8HnBxXA/u8DsN0LSl5saNKrx5gFs=;
        b=PZOIbTFVAAwWciELBWoDwYf71OI53qdlWJAxuR6eQEjdg0WYIn91n3XP0PhyLn9ytf
         VcWFSitZcHpaXiaCCEyBCUVPdV7pIp3I8jfDiiGeFcU2ArUtrpisb++vOfEnhgXI79Pt
         CfMHWQQWK4dkQ1Ei1HBhYzrXRomGKR+5ftpI1uD4Ccgm7FAFbIBJcj6AQgi/yvyY3KFQ
         YRJIU9kEbIWzYCM9OkKbzIcjoy2Y0+f742zn/oGnv5svWPPhPa15H1foxFOpOBLFoiKr
         ij/HpBtfosI0fApcDkHU93HcoVvyrAJewgEsuqInu61Wkfsf7xdn4Gxl6hbY95jXwUAd
         GNGg==
X-Gm-Message-State: AOJu0YypaRtig30XkgdDV8j580aSg81nCcS43CxeBOdI15r/bAfA5j+G
	fuv0ijnCL0+ERqlWZKkcMogouGOywMRpcN7lyqW0F7t8CcVU/uQPX8LDx7lyOApYRaqFo0x9Jpa
	4
X-Google-Smtp-Source: AGHT+IE/1a6TO/dLh1Rh8t4JV8s7VXs3M5CSmiQLCGcDh8IWEAtXDih05l9WbcLZsFwNv0/e8CHo6Q==
X-Received: by 2002:adf:f303:0:b0:33d:c0c3:fe0a with SMTP id i3-20020adff303000000b0033dc0c3fe0amr8935893wro.0.1709047348671;
        Tue, 27 Feb 2024 07:22:28 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id f1-20020adfe901000000b0033d8b1ace25sm11763586wrm.2.2024.02.27.07.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 07:22:28 -0800 (PST)
Date: Tue, 27 Feb 2024 18:22:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: amir73il@gmail.com
Cc: linux-fsdevel@vger.kernel.org
Subject: [bug report] fuse: implement open in passthrough mode
Message-ID: <11068567-a3c4-457a-bc49-7c9480cabb29@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Amir Goldstein,

The patch 51deab7d21f5: "fuse: implement open in passthrough mode"
from Feb 9, 2024 (linux-next), leads to the following Smatch static
checker warning:

	fs/fuse/iomode.c:225 fuse_file_io_open()
	error: uninitialized symbol 'err'.

fs/fuse/iomode.c
    177 int fuse_file_io_open(struct file *file, struct inode *inode)
    178 {
    179         struct fuse_file *ff = file->private_data;
    180         struct fuse_inode *fi = get_fuse_inode(inode);
    181         int err;
    182 
    183         /*
    184          * io modes are not relevant with DAX and with server that does not
    185          * implement open.
    186          */
    187         if (FUSE_IS_DAX(inode) || !ff->args)
    188                 return 0;
    189 
    190         /*
    191          * Server is expected to use FOPEN_PASSTHROUGH for all opens of an inode
    192          * which is already open for passthrough.
    193          */
    194         if (fuse_inode_backing(fi) && !(ff->open_flags & FOPEN_PASSTHROUGH))
    195                 goto fail;

err not set on this path.

    196 
    197         /*
    198          * FOPEN_PARALLEL_DIRECT_WRITES requires FOPEN_DIRECT_IO.
    199          */
    200         if (!(ff->open_flags & FOPEN_DIRECT_IO))
    201                 ff->open_flags &= ~FOPEN_PARALLEL_DIRECT_WRITES;
    202 
    203         /*
    204          * First passthrough file open denies caching inode io mode.
    205          * First caching file open enters caching inode io mode.
    206          *
    207          * Note that if user opens a file open with O_DIRECT, but server did
    208          * not specify FOPEN_DIRECT_IO, a later fcntl() could remove O_DIRECT,
    209          * so we put the inode in caching mode to prevent parallel dio.
    210          */
    211         if ((ff->open_flags & FOPEN_DIRECT_IO) &&
    212             !(ff->open_flags & FOPEN_PASSTHROUGH))
    213                 return 0;
    214 
    215         if (ff->open_flags & FOPEN_PASSTHROUGH)
    216                 err = fuse_file_passthrough_open(inode, file);
    217         else
    218                 err = fuse_file_cached_io_start(inode, ff);
    219         if (err)
    220                 goto fail;
    221 
    222         return 0;
    223 
    224 fail:
--> 225         pr_debug("failed to open file in requested io mode (open_flags=0x%x, err=%i).\n",
    226                  ff->open_flags, err);
                                         ^^^

    227         /*
    228          * The file open mode determines the inode io mode.
    229          * Using incorrect open mode is a server mistake, which results in
    230          * user visible failure of open() with EIO error.
    231          */
    232         return -EIO;
    233 }

regards,
dan carpenter

