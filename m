Return-Path: <linux-fsdevel+bounces-20568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 536998D52B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 21:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86134B22E06
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 19:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEBD142913;
	Thu, 30 May 2024 19:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="bKzDEDm1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EC9433CA
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 19:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717099164; cv=none; b=q654ZUSfHpMykfD9Powfku5IAiJjn2T0Z7CQ6+x9S16+myGSrBo5+DKBN0n/c+PxBzKR66I17XYbbBQc7eAWc4xLqPc91XSVlo1hJXWBCxZT+lxbr4IEuHIpSwZ7z0ObeHIhIZ65jQF7iSJFARvhza30pmrdxzhAdoTW+no9BA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717099164; c=relaxed/simple;
	bh=3ZluTkuz/RJqpoQjlYpmoHWR0EeAd0f3c7vlX32pmpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7tPZFyFHNTl6YVsE94500o4uaY5xKhoYXRhggxji/7f4AIj1TMRaaH27gLPVHNuVeOdiODiCMETuKa7LUjs1NZGiGEVMKBHlty0Oz7MakpBkk8OPEtlSaIYHDTqvp7H9juq6VroD3u7tF9r0L3toq98h7jtZ1Zw7ookBvhlyZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=bKzDEDm1; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-794c3ae6db2so85540585a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 12:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1717099161; x=1717703961; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RKyTY/KYWSmlP4+ILxQ00RmZPB09WbtNoUiUHxnZ/7E=;
        b=bKzDEDm1vr/IZxbYF3Cey48YKLGBQ6kEeblkZF0WYB/4+xvi6lb39AjkcgKkuUY5nh
         cinc7GAeh/4Hb9RWSAuvXi20cwpr+vgLCA4wN2j/0cDlBTRMQb3JeylaKmRaZcgmmCFH
         8T0WopDwSmU7o97/IzrsLOALZ60jnK/du2oXJN21lIo3nPTixuCIkSfn2Pw4uK7BiAQu
         FhOOvapSJAVk3cK/iUnL10d4vwCQNknmP2b0dzbG81PxVPuy2vhxelqk1tQxXmutlcCh
         4GLJGzOE6uYzQidM1F1GRI/0q6TKTyzZlT1PbCtQHjqpmr8YA1UWoKqZRzuyyV4Nk+fZ
         nF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717099161; x=1717703961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKyTY/KYWSmlP4+ILxQ00RmZPB09WbtNoUiUHxnZ/7E=;
        b=w/4as2S5HXFBgNN7e+Zki2SnjDVUM8KJdxO2dr/kC8KbkmKgfOpRYpYFrOxbaBbW/K
         PlrfBur8yW2vqShbc54OMGnSJak0oWnQoq9VbNIgf3M8KYfFUUJ2uZd3ZW0b5o0yceB+
         aTLCODDH3KMtL8ZLdevQ8zzpqHTCECTw06nKdrhxDh+JHJLVtDKHbp6L2Njl6Gy/OvAZ
         j3VgREM8vjENBSZMpWB67nN8bDKB0k3VUSFs+CElpvXSbT7kxlPK8JfpnALkDgGOR00D
         ptGGPbLGOz0QZA0v2XCpaAkRI0x96epWx8Zy+7BECctzqGYQ6RoqI42z6v2NrNKRitYy
         O/rg==
X-Forwarded-Encrypted: i=1; AJvYcCXFDxtILQN3+5dNqM5zOog1Lj151jeeuMv/qc8BRsFxHp8qmkzLBmGLR8UNheXSPQp+KMTGQhZEuG9ejLuttFUfoJaooVpXlm2S1GrYpg==
X-Gm-Message-State: AOJu0Yxq08QmkWTOLmb1IVYWY8veu3R/22qv0/HnGYtMMHCoe60YRye1
	x4XyemDnqrFcObNi9FzFXvx8UI4/aX1bbM7ZNtZ9nkY0/gPo+ytIY2zotwUqUeY=
X-Google-Smtp-Source: AGHT+IF6MC1nvYycHb4pFOgY/tmhZWPhbb0oY7LrSvSDI+7BHGRsz8ek7VrSTAVY2qI/LoyAZ4qH1w==
X-Received: by 2002:a05:620a:460f:b0:78e:db2f:2726 with SMTP id af79cd13be357-794e9e18586mr375871285a.51.1717099161355;
        Thu, 30 May 2024 12:59:21 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794f317863asm9004285a.114.2024.05.30.12.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 12:59:21 -0700 (PDT)
Date: Thu, 30 May 2024 15:59:20 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm
Subject: Re: [PATCH RFC v2 11/19] fuse: Add support to copy from/to the ring
 buffer
Message-ID: <20240530195920.GC2210558@perftesting>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
 <20240529-fuse-uring-for-6-9-rfc2-out-v1-11-d149476b1d65@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529-fuse-uring-for-6-9-rfc2-out-v1-11-d149476b1d65@ddn.com>

On Wed, May 29, 2024 at 08:00:46PM +0200, Bernd Schubert wrote:
> This adds support to existing fuse copy code to copy
> from/to the ring buffer. The ring buffer is here mmaped
> shared between kernel and userspace.
> 
> This also fuse_ prefixes the copy_out_args function
> 
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/fuse/dev.c        | 60 ++++++++++++++++++++++++++++++----------------------
>  fs/fuse/fuse_dev_i.h | 38 +++++++++++++++++++++++++++++++++
>  2 files changed, 73 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 05a87731b5c3..a7d26440de39 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -637,21 +637,7 @@ static int unlock_request(struct fuse_req *req)
>  	return err;
>  }
>  
> -struct fuse_copy_state {
> -	int write;
> -	struct fuse_req *req;
> -	struct iov_iter *iter;
> -	struct pipe_buffer *pipebufs;
> -	struct pipe_buffer *currbuf;
> -	struct pipe_inode_info *pipe;
> -	unsigned long nr_segs;
> -	struct page *pg;
> -	unsigned len;
> -	unsigned offset;
> -	unsigned move_pages:1;
> -};
> -
> -static void fuse_copy_init(struct fuse_copy_state *cs, int write,
> +void fuse_copy_init(struct fuse_copy_state *cs, int write,
>  			   struct iov_iter *iter)
>  {
>  	memset(cs, 0, sizeof(*cs));
> @@ -662,6 +648,7 @@ static void fuse_copy_init(struct fuse_copy_state *cs, int write,
>  /* Unmap and put previous page of userspace buffer */
>  static void fuse_copy_finish(struct fuse_copy_state *cs)
>  {
> +

Extraneous newline.

>  	if (cs->currbuf) {
>  		struct pipe_buffer *buf = cs->currbuf;
>  
> @@ -726,6 +713,10 @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
>  			cs->pipebufs++;
>  			cs->nr_segs++;
>  		}
> +	} else if (cs->is_uring) {
> +		if (cs->ring.offset > cs->ring.buf_sz)
> +			return -ERANGE;
> +		cs->len = cs->ring.buf_sz - cs->ring.offset;
>  	} else {
>  		size_t off;
>  		err = iov_iter_get_pages2(cs->iter, &page, PAGE_SIZE, 1, &off);
> @@ -744,21 +735,35 @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
>  static int fuse_copy_do(struct fuse_copy_state *cs, void **val, unsigned *size)
>  {
>  	unsigned ncpy = min(*size, cs->len);
> +
>  	if (val) {
> -		void *pgaddr = kmap_local_page(cs->pg);
> -		void *buf = pgaddr + cs->offset;
> +
> +		void *pgaddr = NULL;
> +		void *buf;
> +
> +		if (cs->is_uring) {
> +			buf = cs->ring.buf + cs->ring.offset;
> +			cs->ring.offset += ncpy;
> +
> +		} else {
> +			pgaddr = kmap_local_page(cs->pg);
> +			buf = pgaddr + cs->offset;
> +		}
>  
>  		if (cs->write)
>  			memcpy(buf, *val, ncpy);
>  		else
>  			memcpy(*val, buf, ncpy);
>  
> -		kunmap_local(pgaddr);
> +		if (pgaddr)
> +			kunmap_local(pgaddr);
> +
>  		*val += ncpy;
>  	}
>  	*size -= ncpy;
>  	cs->len -= ncpy;
>  	cs->offset += ncpy;
> +

Extraneous newline.

Once those nits are fixed you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

