Return-Path: <linux-fsdevel+bounces-20162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 436E38CF1F2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2024 01:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B04E6B211FC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 May 2024 23:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EA6129A71;
	Sat, 25 May 2024 23:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="upxmnVYb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759933B297
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 May 2024 23:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716678164; cv=none; b=jxebqezeB+Z4HMcr9No7i5ob09lPkY+LeHAZXv6QMglwzR+HAkMbs9qLmZ4JqtSvT/7mJlEvR8iW9lO7N2ePBIocRboETgOzjcP/bcnTK8ybJajJHe9b/NC2vAvtJO3aLtuJCq7gT5LpXs9FtAZ5M7LyzQ1/DLaX0VFrf1OaTBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716678164; c=relaxed/simple;
	bh=L3hWBTMmA6viEgmlEybu5t+iS/55NiCc6jPW1Kjsoa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iE8WAYeIYTF+BWOGlcOBpV3KprPX2GkOXBqgh/e8+snjGWXjV5/QbXhmqmxb/ON8yM+BE+6U3+faHzUkND2GL6VEwTctxIewt1Ada6NmvEBTeKL+OXPVZUqZySC8Kke0Onmqi1UT1WCJ6xnQk/Zz0jPWew7BjFCeU7ZP2P1f8wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=upxmnVYb; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6f8e9555eabso1773363b3a.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 May 2024 16:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1716678163; x=1717282963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gic6Wo3zjudyzI0BAjsVaWRrn7WVkv86SSZTvDO7XFs=;
        b=upxmnVYbF9XuqlhXcqNr8K+zIJ1d9TVX6Mon09OG0FFLHCqYaj7yD1Ms1Sfxu9RZpD
         TaeFXJNQ4eJ1FqL21NTClYIV26S51nH8shM+vzjfb7KSxRYxcH0dk2Wng+cxkDpr40EH
         hFgNR/0qWwNxlLCHQ6WGhnSpbnJLmLmN2k+/XAQdFWDFjrtPZHVdDAxS55mGnXE9Ldv8
         NEba7m2oCj4uPOVIAKdjDZBlyNaTbGOcVUvJIH4YWzWz4WXeeb3eGs6is2FivFkODsB+
         QOR88d4K70UUIwKaKx6rEcHOO+FDHMF8DLliEHlzPAHFkPz5aUoRlKnlUkPN6i7y5TAs
         KzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716678163; x=1717282963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gic6Wo3zjudyzI0BAjsVaWRrn7WVkv86SSZTvDO7XFs=;
        b=Hd3vNRPySRL8/Y8gau7M6fDiXpaBGrdEMRlvh7hMn8dyi8eW5PwzrDADavil3cfxYS
         EXzivr5G567MQRRGvJXR40vrXSLZIaq+aV7fS+BdJgOEyGK28dcBxyZthhKMcQN1jDv4
         yiKVMff0G5BRu+aR58zU26pFMAPMepamCUq+MnlzddHHiJ/Mipz32YiTOBNxuA14D9N1
         i01JEMt+eothy4BuyUPB8/F7i+ZUaD2y3HrAD+UYZBNG786cPK3rk8IOlCm6fgsP4lsM
         X+oTUdSyVI4T7VobreufsLIjmv9+9wtWXflVPyUO0zygyOLJg0q2ueLOS5WIvf5X4JCC
         lOWg==
X-Forwarded-Encrypted: i=1; AJvYcCXc5wlidroI0/E54KtrDwxtPKi650g1eQ+bG2A86H1K8bbZ/pLa4y5KIsNgrd2HAUbS7ZVvDIkdcYHV0yyPDZ/oMoetyIA8lFNsswnY3w==
X-Gm-Message-State: AOJu0Yw6bVun45BQC2oCzETKvN9B+CDN8etyQ9stMGwLZ46P1Q1uVfDO
	Z7UMjvLgFZVrhbtP1T/rjdc7i7FkaRHpTI/KqCJ3MnAapYnaNovD1RvJBWP5Bkk=
X-Google-Smtp-Source: AGHT+IHkIK468Us7w5racBBbD0k32HWYTGqS9h3qKLyIaPSGj5Sg+dT6eM4UpYv8VhDI97pWq3omsw==
X-Received: by 2002:a05:6a00:4405:b0:6f8:caf2:8f4f with SMTP id d2e1a72fcca58-6f8f45d2624mr6450954b3a.33.1716678162585;
        Sat, 25 May 2024 16:02:42 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fcbeaaa3sm2831749b3a.103.2024.05.25.16.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 May 2024 16:02:42 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sB0PP-00AUdG-2E;
	Sun, 26 May 2024 09:02:39 +1000
Date: Sun, 26 May 2024 09:02:39 +1000
From: Dave Chinner <david@fromorbit.com>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	martin.petersen@oracle.com, bvanassche@acm.org, hare@suse.de,
	damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
	joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 05/12] fs/read_write: Enable copy_file_range for
 block device.
Message-ID: <ZlJuDxhMEpJxKQHV@dread.disaster.area>
References: <20240520102033.9361-1-nj.shetty@samsung.com>
 <CGME20240520102917epcas5p1bda532309b9174bf2702081f6f58daf7@epcas5p1.samsung.com>
 <20240520102033.9361-6-nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520102033.9361-6-nj.shetty@samsung.com>

On Mon, May 20, 2024 at 03:50:18PM +0530, Nitesh Shetty wrote:
> From: Anuj Gupta <anuj20.g@samsung.com>
> 
> This is a prep patch. Allow copy_file_range to work for block devices.
> Relaxing generic_copy_file_checks allows us to reuse the existing infra,
> instead of adding a new user interface for block copy offload.
> Change generic_copy_file_checks to use ->f_mapping->host for both inode_in
> and inode_out. Allow block device in generic_file_rw_checks.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> ---
>  fs/read_write.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index ef6339391351..31645ca5ed58 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1413,8 +1413,8 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
>  				    struct file *file_out, loff_t pos_out,
>  				    size_t *req_count, unsigned int flags)
>  {
> -	struct inode *inode_in = file_inode(file_in);
> -	struct inode *inode_out = file_inode(file_out);
> +	struct inode *inode_in = file_in->f_mapping->host;
> +	struct inode *inode_out = file_out->f_mapping->host;
>  	uint64_t count = *req_count;
>  	loff_t size_in;
>  	int ret;

Ok, so this changes from file->f_inode to file->mapping->host. No
doubt this is because of how bdev inode mappings are munged.
However, the first code that is run here is:

	ret = generic_file_rw_checks(file_in, file_out);

and that function still uses file_inode().

Hence there checks:

> @@ -1726,7 +1726,9 @@ int generic_file_rw_checks(struct file *file_in, struct file *file_out)
>  	/* Don't copy dirs, pipes, sockets... */
>  	if (S_ISDIR(inode_in->i_mode) || S_ISDIR(inode_out->i_mode))
>  		return -EISDIR;
> -	if (!S_ISREG(inode_in->i_mode) || !S_ISREG(inode_out->i_mode))
> +	if (!S_ISREG(inode_in->i_mode) && !S_ISBLK(inode_in->i_mode))
> +		return -EINVAL;
> +	if ((inode_in->i_mode & S_IFMT) != (inode_out->i_mode & S_IFMT))
>  		return -EINVAL;

.... are being done on different inodes to the rest of
generic_copy_file_checks() when block devices are used.

Is this correct? If so, this needs a pair of comments (one for each
function) to explain why the specific inode used for these functions
is correct for block devices....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

