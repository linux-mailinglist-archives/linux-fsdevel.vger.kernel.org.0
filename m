Return-Path: <linux-fsdevel+bounces-73923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6CCD24ADC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 14:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0336C3029C1D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 13:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0FB39E6D3;
	Thu, 15 Jan 2026 13:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2t8/IxG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F72336E47A
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 13:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768482594; cv=none; b=Q7OiHPJNaLMPmE4NTUEDwDExuk6Sn6eXneuAXxcl7kvIgCyY/KsMIM4LMv263dt6CyJvDdWjUxnQZqp3M8SigXCp2W6aw1OJrmyej4v5U767wccN+UsYxlXmcLz+zkeuKJDqhUSo+62BAcGecKYoHNRir2ZaEH6AL0WRcukRIXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768482594; c=relaxed/simple;
	bh=nuGWw+p+199ey0Y+bDhBXKrsiIDKFBdWCIlEZx+25Po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/R54hdU1etQPy06zk3Vzh/D5m2r+M9Fe0XmtY0OocH+cS5H4Dsh1WtU/9YJAR2XaojQOkRLi54ooor0yR8ktj+ulPEtxYHNwzAG//hWRnC+ureE3Lc9KIxCUFFFh2XOX2iu5ixQ5n7WRvXVAKnX+i/AkEOM/lqtkcr5dnRHLH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2t8/IxG; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-64b9230f564so1208542a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 05:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768482592; x=1769087392; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vTFqLfTpmjvd/D1e35q26Wh69x5Oa0nOkyYRGyRK3GI=;
        b=O2t8/IxG4kWjYg7ZwMQpURj6ciaVR4p8tnkvjtIjF+3TMvk3z+ib60i89N6saAO4UN
         O37pBuaKNV7AVvOV16+7/UOHCDzHU8eiCo0QcnhWpSphLtpi/N2c4iM19uDJIj69hcpM
         N2iyHRg2Vx8iDTMvU60P6pHGCvo1L8HtypJ9mvkSJlxJB2n1gktPYsSwK6gqVgjiE3FJ
         mm93MrtHOoVSDlvoGF6eSgqWWL9WjaiyM1F4vdFV4HKXoUVlU+jECT2dDFNutiDjRI4/
         nIOucXfhHCfBBc/kABHxOdUeQyTnuIDmRcjZh7KA7g5LqxVySTD2B4UC6Qzh54yYlySH
         2d2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768482592; x=1769087392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTFqLfTpmjvd/D1e35q26Wh69x5Oa0nOkyYRGyRK3GI=;
        b=vJ2/3+zT4BreFVmroK15KjfLM7k6fOygzlelK2nsSbaouGwQt9NbBSCVfAcjhkrV1X
         AV1dIWhjM4bRkFtUFGdP4YoQa8gUdmPuItM9deVWBsMqTEluTjbQAXB3SAlx0xxHMxqB
         MwoEI5N02BJI1Gzcl12tQQMXWEwWsQG0H9lMQWYklR5yh8Ah9Hpgfu74I/kVHtb3EmqO
         Xz3LavE636KPqNUHFxUcNSRTMocn4ICgsXS3mce9MDUPq+6RiYErFwsdYFqaWuJ7N02X
         A9Uy9hwhsh2/IzI9135EqUM2UHJMGjXxUsP5sxHdsZsub0qiEQjRQc9zO8BJRoV+pC7g
         p/gQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/eLGYXwKM0jWkMEFD5zqGlDpsXXIZQRpF4n9fNLzD7BSxz+bvD3NUbtstvw+sxdJggpD/CUCGyq+sS4I+@vger.kernel.org
X-Gm-Message-State: AOJu0YwUJEniYDGK1feiYXU3nOIry/QOvtkZsazE6gDV85NhoWT9V7rT
	lSXKxlgX1q4OMvNOm4lNXjy20ekrLOn9Cg+zK4Wb4SAmEP/fp4Z+jnHc
X-Gm-Gg: AY/fxX5mUTFZgOWlEgiIE/9ruE8biEkXV8C/BYHq5ZdiuLz7DSFWXIe4RjY/6f8Ypis
	N/SeMuf97AJsgY2lJzena7m0zbRLo3PNXLo/9VvlhuOaOzDdbYvsdQXrsIzLvDJTw6rEYjPg981
	lkosw2QlADkHmUjaiXiWlRB2xnbjuLGw8DyAvIhRlvCUTcl4+JkpW9ndSSs2XJ1zOFsd2tXFh/0
	uiUh62+ECj2IHu8WWQOpXf1Y7NOySGa+xpFzOS6/gMlmJqwzMN3I50kaZUwBk1cfDomgSAI4qTw
	1acvQFGQrPa9046IIwOAwx7BTLshznLQ9opXpp8ca4KDIi5k6gQWLCaXSM5BS4ZHiIHpF4SUw57
	H9w+HwDc4Pn79D/cWR6OJ7jAZQ19aB5EzMNbAScMqRSX5Paq1/EMQo3Y4pUMO7Sa86+sHLJ/GT8
	zTvjrBmJpXIWu0V2gN7WoUAtRofkZniKEi7Lj7o8OzpRiUQ86qMNxfnoLbuN5wDYREcVKOrluqM
	A4w80c/GWorAIDU4ZcQTIb6xhM=
X-Received: by 2002:a05:6402:1e92:b0:650:31ef:177b with SMTP id 4fb4d7f45d1cf-653ec47475dmr4973265a12.34.1768482591375;
        Thu, 15 Jan 2026 05:09:51 -0800 (PST)
Received: from localhost (2001-1c00-570d-ee00-7a88-ab31-60c0-33c9.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:7a88:ab31:60c0:33c9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6541187748fsm2443869a12.7.2026.01.15.05.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 05:09:50 -0800 (PST)
Date: Thu, 15 Jan 2026 14:09:50 +0100
From: Amir Goldstein <amir73il@gmail.com>
To: Chunsheng Luo <luochunsheng@ustc.edu>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, paullawrence@google.com
Subject: Re: [RFC 2/2] fuse: Add new flag to reuse the backing file of
 fuse_inode
Message-ID: <aWjnHvP5jsafQeag@amir-ThinkPad-T480>
References: <20260115072032.402-1-luochunsheng@ustc.edu>
 <20260115072032.402-3-luochunsheng@ustc.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115072032.402-3-luochunsheng@ustc.edu>

Hi Chunsheng,

Please CC me for future fuse passthrough patch sets.

On Thu, Jan 15, 2026 at 03:20:31PM +0800, Chunsheng Luo wrote:
> To simplify crash recovery and reduce performance impact, backing_ids
> are not persisted across daemon restarts. However, this creates a
> problem: when the daemon restarts and a process opens the same FUSE
> file, a new backing_id may be allocated for the same backing file. If
> the inode already has a cached backing file from before the restart,
> subsequent open requests with the new backing_id will fail in
> fuse_inode_uncached_io_start() due to fb mismatch, even though both
> IDs reference the identical underlying file.

I don't think that your proposal makes this guaranty.

> 
> Introduce the FOPEN_PASSTHROUGH_INODE_CACHE flag to address this
> issue. When set, the kernel reuses the backing file already cached in
> the inode.
> 
> Signed-off-by: Chunsheng Luo <luochunsheng@ustc.edu>
> ---
>  fs/fuse/iomode.c          |  2 +-
>  fs/fuse/passthrough.c     | 11 +++++++++++
>  include/uapi/linux/fuse.h |  2 ++
>  3 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
> index 3728933188f3..b200bb248598 100644
> --- a/fs/fuse/iomode.c
> +++ b/fs/fuse/iomode.c
> @@ -163,7 +163,7 @@ static void fuse_file_uncached_io_release(struct fuse_file *ff,
>   */
>  #define FOPEN_PASSTHROUGH_MASK \
>  	(FOPEN_PASSTHROUGH | FOPEN_DIRECT_IO | FOPEN_PARALLEL_DIRECT_WRITES | \
> -	 FOPEN_NOFLUSH)
> +	 FOPEN_NOFLUSH | FOPEN_PASSTHROUGH_INODE_CACHE)
>  
>  static int fuse_file_passthrough_open(struct inode *inode, struct file *file)
>  {
> diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> index 72de97c03d0e..fde4ac0c5737 100644
> --- a/fs/fuse/passthrough.c
> +++ b/fs/fuse/passthrough.c
> @@ -147,16 +147,26 @@ ssize_t fuse_passthrough_mmap(struct file *file, struct vm_area_struct *vma)
>  /*
>   * Setup passthrough to a backing file.
>   *
> + * If fuse inode backing is provided and FOPEN_PASSTHROUGH_INODE_CACHE flag
> + * is set, try to reuse it first before looking up backing_id.
> + *
>   * Returns an fb object with elevated refcount to be stored in fuse inode.
>   */
>  struct fuse_backing *fuse_passthrough_open(struct file *file, int backing_id)
>  {
>  	struct fuse_file *ff = file->private_data;
>  	struct fuse_conn *fc = ff->fm->fc;
> +	struct fuse_inode *fi = get_fuse_inode(file->f_inode);
>  	struct fuse_backing *fb = NULL;
>  	struct file *backing_file;
>  	int err;
>  
> +	if (ff->open_flags & FOPEN_PASSTHROUGH_INODE_CACHE) {
> +		fb = fuse_backing_get(fuse_inode_backing(fi));
> +		if (fb)
> +			goto do_open;
> +	}
> +

Maybe an explicit FOPEN_PASSTHROUGH_INODE_CACHE flag is a good idea,
but just FYI, I intentionally reserved backing_id 0 for this purpose.
For example, for setting up the backing id on lookup [1] and then
open does not need to specify the backing_id.

[1] https://lore.kernel.org/linux-fsdevel/20250804173228.1990317-1-paullawrence@google.com/

But what you are proposing is a little bit odd API IMO:
"Use this backing_id with this backing file, unless you find another
 backing file so use that one instead" - this sounds a bit awkward to me.

I think it would be saner and simpler to relax the check in
fuse_inode_uncached_io_start() to check that old and new fuse_backing
objects refer to the same backing inode:

diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
index 3728933188f30..c6070c361d855 100644
--- a/fs/fuse/iomode.c
+++ b/fs/fuse/iomode.c
@@ -88,9 +88,9 @@ int fuse_inode_uncached_io_start(struct fuse_inode *fi, struct fuse_backing *fb)
 	int err = 0;
 
 	spin_lock(&fi->lock);
-	/* deny conflicting backing files on same fuse inode */
+	/* deny conflicting backing inodes on same fuse inode */
 	oldfb = fuse_inode_backing(fi);
-	if (fb && oldfb && oldfb != fb) {
+	if (fb && oldfb && file_inode(oldfb->file) != file_inode(fb->file)) {
 		err = -EBUSY;
 		goto unlock;
 	}
--

I don't think that this requires opt-in flag.

Thanks,
Amir.

