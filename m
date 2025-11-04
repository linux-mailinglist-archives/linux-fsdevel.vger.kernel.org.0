Return-Path: <linux-fsdevel+bounces-66889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA8DC2F89E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 08:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F2A44ECAE7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 07:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEAC13BC0C;
	Tue,  4 Nov 2025 07:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbCgQvdu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36292FDC31
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 07:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762239620; cv=none; b=ozvnWDjYDduKiq1wPOHDwVkHIz4Ir08K4YMRrmSD34e6VyrD6E2LnrpSY1guieVBHGDgYgOmdqHOjxR8Y8iGXkfhhjxMX4+gD8MNydnSucaiUIhRRu2imMRsNNxLQIP05N4CpwdgfHCnGnD19TaC4qkSphIAD9cU10LQGQzidLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762239620; c=relaxed/simple;
	bh=FGCfv80twEdU+R8XzVK1ejUCe8z8NADKArJeiCnBOKg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=bilE99y0h5lN7taQ2bGIIXNPS19f7nTy5xfrkXOANGWDbdptnYaIDX3xFyQWivsZkUpGZ8I5+ler9L3M93S9+bd7OV6dcV/n7DZzO1+/fXojW79BjHWQlh8gWqReq9K/vVF01ydLwkv6DnuvHRhDDRo7o1WttmlWLZrfj7dWf9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbCgQvdu; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-33be037cf73so5339378a91.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Nov 2025 23:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762239615; x=1762844415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f/FIOUr7S9hTEYtUjYatl+ZnZSEtRo87u/cEQk+2WP4=;
        b=FbCgQvduY+kiMoBAfavdLJOETBVfGVgmUaKrOYa11on1jxXoPfqaBcw+U7TkdD5H4R
         +GhT2Uz1LzAE3NsDLkwV/tE+Q6thVyn7Eh8heVZDp1kKM0HUPCClZ0r5Rtrj+Cdb6aNv
         err+Wt91QKD09n0PMWpJzAhJAb+LdwmzzkMpOmqFul/l2rjjyj7U/gfSBsjSrXQpLH/g
         MzJVmNS+3Ka5ArrnG9Bv8v3lL+blPMX3z54UDzrOu0XUl3Oplrfwu+CWSL+J0vwYHIMT
         6wPg/FXcYJXYMQjd8G1HFQumxaEiK/QDDPgirOlvfTJYq+sDfjl0EbtBwcH7qp2xtPUY
         Ihgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762239615; x=1762844415;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f/FIOUr7S9hTEYtUjYatl+ZnZSEtRo87u/cEQk+2WP4=;
        b=jIO4vtijQpk9lErS1NR7cbKUpTPqoV4MqwVjRIzfSEGL7WBkmqB+dXZ1wyB8EGqePK
         QZo1tsMaXVBniwOx99JX0qTgl8Lbb0l9+Yg2KxRM5Kl9Kx8nLS5ucS5qc/kwj0B6NHhM
         Xo+WB89admHNltASnAUCBHMY0B1BND9LODbDo8n+3U2ycni5vrU2pW93iNlshzFkIwwl
         9xDOeVsY+/NHydnorJKognJU8EDc+8mr1FlZWvcoQ4SFdbs1wLliOKjEwP2sFINg5Rmb
         13bTvT6sw8oWYh0n753y6x0xsFXZnX8iWzWu+4u0BeacE5itiVUUscovufdlDNpLAhG3
         SLxw==
X-Forwarded-Encrypted: i=1; AJvYcCU9ZoMG6lB3UI64Y1ybQmylpcb7Is6Wcl/OpAiB3zyXgKChFCJB7OQJp5Fh6Yrs+ig1+z9F4RlWasf/7zJV@vger.kernel.org
X-Gm-Message-State: AOJu0Yxca2T3J4Kyp8ZpKRlNO1QrhLNXzp9pSZEEVFVGhuKPqM2wpv1s
	xagsjt0MA7hhduqZW56m/XpqJcIsOvAvvBQkvlotOmx/d2LEYKyxMQ7y37gj6A==
X-Gm-Gg: ASbGncsZ2qFIIUwh5KVtu97I1SSWJyjTM+veu5ziXNVAXyKlB2H9fgy8zkG62SK3pNF
	n1XacF/B682cnZ5qcQdBDF1ofs96xTSQglb2NBYynIr6bBMvi2HcGETzElsYet9sv/ZUCYr99q+
	Faor8ArAtGslGso+BOIJEhu2uMJhyEA2gx1KhNKITTM73B553NlkefcqVe5RDmF1FyLvzdL2sZv
	ibV4ZRFFEbc0bQfkSlfXjO3YcQB9p25GxVLERG8hU2pNiaPz5sQR5UG31PB8V+aEjk2kgNvlri0
	Tu+Xue4Bb1TIBkNR1+ptBZTN6A6CXQRHXbEJ+wobVy3ek4il7FaqJTiK37hWVCIs+0DV04osd16
	QWttXDaY7P5gCwIR9Ffj8encPUH7Tzdh5073KXT9apQiDi6wevz4SQ1ZvTF3BASac9PAh91SXYW
	dX4OXuGFnHX+oOqMsxs4VGJM0eBefGgDNgXNGGh9t3GnbfCb1nmw==
X-Google-Smtp-Source: AGHT+IFswYKAZZGcmKubDw1Ut70XcdWnygbu/Nz8V8ZIBKgcbXyXjsFNYlrpqEz2UFnG6Imng1iP6Q==
X-Received: by 2002:a17:90b:2783:b0:340:ff7d:c2e with SMTP id 98e67ed59e1d1-340ff7d105cmr10133442a91.29.1762239614970;
        Mon, 03 Nov 2025 23:00:14 -0800 (PST)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([129.41.58.6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3415c4aa8a5sm3316460a91.13.2025.11.03.23.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 23:00:14 -0800 (PST)
Message-ID: <f79ef55f5ec05400582dea69e7bc3f14f5a5d1f0.camel@gmail.com>
Subject: Re: [PATCH 1/4] fs: replace FOP_DIO_PARALLEL_WRITE with a fmode bits
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: Christoph Hellwig <hch@lst.de>, Carlos Maiolino <cem@kernel.org>, 
	Christian Brauner
	 <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, "Martin K. Petersen"
 <martin.petersen@oracle.com>,  linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
 linux-raid@vger.kernel.org,  linux-block@vger.kernel.org
Date: Tue, 04 Nov 2025 12:30:06 +0530
In-Reply-To: <20251029071537.1127397-2-hch@lst.de>
References: <20251029071537.1127397-1-hch@lst.de>
	 <20251029071537.1127397-2-hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

On Wed, 2025-10-29 at 08:15 +0100, Christoph Hellwig wrote:
> To properly handle the direct to buffered I/O fallback for devices that
> require stable writes, we need to be able to set the DIO_PARALLEL_WRITE
> on a per-file basis and no statically for a given file_operations
> instance.
So, is the fallback configurable(like we can turn it on/off)? Looking at the code it seems like it
is not. Any reason for not making it configurable?
--NR
> 
> This effectively reverts a part of 210a03c9d51a ("fs: claw back a few
> FMODE_* bits").
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/ext4/file.c      | 2 +-
>  fs/xfs/xfs_file.c   | 4 ++--
>  include/linux/fs.h  | 7 ++-----
>  io_uring/io_uring.c | 2 +-
>  4 files changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 7a8b30932189..b484e98b9c78 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -924,6 +924,7 @@ static int ext4_file_open(struct inode *inode, struct file *filp)
>  		filp->f_mode |= FMODE_CAN_ATOMIC_WRITE;
>  
>  	filp->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
> +	filp->f_mode |= FMODE_DIO_PARALLEL_WRITE;
>  	return dquot_file_open(inode, filp);
>  }
>  
> @@ -978,7 +979,6 @@ const struct file_operations ext4_file_operations = {
>  	.splice_write	= iter_file_splice_write,
>  	.fallocate	= ext4_fallocate,
>  	.fop_flags	= FOP_MMAP_SYNC | FOP_BUFFER_RASYNC |
> -			  FOP_DIO_PARALLEL_WRITE |
>  			  FOP_DONTCACHE,
>  };
>  
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 2702fef2c90c..5703b6681b1d 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -1553,6 +1553,7 @@ xfs_file_open(
>  	if (xfs_is_shutdown(XFS_M(inode->i_sb)))
>  		return -EIO;
>  	file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
> +	file->f_mode |= FMODE_DIO_PARALLEL_WRITE;
>  	if (xfs_get_atomic_write_min(XFS_I(inode)) > 0)
>  		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
>  	return generic_file_open(inode, file);
> @@ -1951,8 +1952,7 @@ const struct file_operations xfs_file_operations = {
>  	.fadvise	= xfs_file_fadvise,
>  	.remap_file_range = xfs_file_remap_range,
>  	.fop_flags	= FOP_MMAP_SYNC | FOP_BUFFER_RASYNC |
> -			  FOP_BUFFER_WASYNC | FOP_DIO_PARALLEL_WRITE |
> -			  FOP_DONTCACHE,
> +			  FOP_BUFFER_WASYNC | FOP_DONTCACHE,
>  };
>  
>  const struct file_operations xfs_dir_file_operations = {
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c895146c1444..09b47effc55e 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -128,9 +128,8 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
>  #define FMODE_WRITE_RESTRICTED	((__force fmode_t)(1 << 6))
>  /* File supports atomic writes */
>  #define FMODE_CAN_ATOMIC_WRITE	((__force fmode_t)(1 << 7))
> -
> -/* FMODE_* bit 8 */
> -
> +/* Supports non-exclusive O_DIRECT writes from multiple threads */
> +#define FMODE_DIO_PARALLEL_WRITE ((__force fmode_t)(1 << 8))
>  /* 32bit hashes as llseek() offset (for directories) */
>  #define FMODE_32BITHASH         ((__force fmode_t)(1 << 9))
>  /* 64bit hashes as llseek() offset (for directories) */
> @@ -2317,8 +2316,6 @@ struct file_operations {
>  #define FOP_BUFFER_WASYNC	((__force fop_flags_t)(1 << 1))
>  /* Supports synchronous page faults for mappings */
>  #define FOP_MMAP_SYNC		((__force fop_flags_t)(1 << 2))
> -/* Supports non-exclusive O_DIRECT writes from multiple threads */
> -#define FOP_DIO_PARALLEL_WRITE	((__force fop_flags_t)(1 << 3))
>  /* Contains huge pages */
>  #define FOP_HUGE_PAGES		((__force fop_flags_t)(1 << 4))
>  /* Treat loff_t as unsigned (e.g., /dev/mem) */
> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
> index 296667ba712c..668937da27e8 100644
> --- a/io_uring/io_uring.c
> +++ b/io_uring/io_uring.c
> @@ -469,7 +469,7 @@ static void io_prep_async_work(struct io_kiocb *req)
>  
>  		/* don't serialize this request if the fs doesn't need it */
>  		if (should_hash && (req->file->f_flags & O_DIRECT) &&
> -		    (req->file->f_op->fop_flags & FOP_DIO_PARALLEL_WRITE))
> +		    (req->file->f_mode & FMODE_DIO_PARALLEL_WRITE))
>  			should_hash = false;
>  		if (should_hash || (ctx->flags & IORING_SETUP_IOPOLL))
>  			io_wq_hash_work(&req->work, file_inode(req->file));


