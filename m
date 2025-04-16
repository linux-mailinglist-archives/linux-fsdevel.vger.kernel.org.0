Return-Path: <linux-fsdevel+bounces-46555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4511EA8B675
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 12:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CCF23BE63F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 10:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E46C24728F;
	Wed, 16 Apr 2025 10:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="m8jZkJ24";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mEClG1Ka"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE3723907E
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Apr 2025 10:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744798195; cv=none; b=m7kQxTylNrYYVvGWv5tKR+a0XEpsrLSTFKs6oB1mCzh1m7lmHC1XNluTSm5hVueRZzbkT7Q5cqnXFiNvQZ9IsIB+fhoiOMhoai0ajrG5oo8z68+G2IqS18u1rk2ZekGC5hoRD9qxR8nWi+megiN3vbAGASzmHt/YbEtbakXzcYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744798195; c=relaxed/simple;
	bh=47eOesFtX6b1xheptghkNVwy86ntkNBq5lCZs8lll9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Fw93423HpuVf4N9BnMRQYYVT0a4EVQmm6tEiqpOlpid5APpnliQ4r/r1IAQ+NUTvK7MQJca0fcOJhH2XIXjm5Ey0BYMq10yjLQvnHFTi45CLMQ7KteiCSWCkd3H79jB4oLB0wvEqTB458xGm5wp1OLnY9iHdJ36EP6dhxxV83wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=m8jZkJ24; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mEClG1Ka; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B8CCA25403C3;
	Wed, 16 Apr 2025 06:09:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 16 Apr 2025 06:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1744798191;
	 x=1744884591; bh=bygNnvvmjQTPUP8C1e3AfHROvd8APMQXx5SZrvoHcu0=; b=
	m8jZkJ24WStDtvx+t3KWEjGGWRlCgGkFzFn7weAcXIoYOoq/Oacz9BeEDSxISS7f
	sDnoEwbWKOJym7hEUwrwDZKJXGMUg8De2RMxgKGqTL/zEWZYNckOKfplGVczywfu
	NCJaejwb1uySISVI8hEwOFQVJHZJeTv9AYB+zkWfOzkJNoYh/LJ3nLOsg/N07TNe
	G/YLZ3qLb9KUykVoY8y+Mz9eQhzkTIeIY+dYCM8V3344U8uLQGt6TWeSS7EqcgKR
	0XTWfedYDBoP3/11N4yMPg/176alDyD/5bpP8Sen1vFDxNUiheZJso35YFqx7sSN
	6xdo3j9Io1W1z1N34gcHVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744798191; x=1744884591; bh=b
	ygNnvvmjQTPUP8C1e3AfHROvd8APMQXx5SZrvoHcu0=; b=mEClG1KaVEtJ1K4Lr
	pPZymSrrLaKN946qn5qaZJAlqtUgEv7CxR0jmo6j6lTZU+Tf4cYMP/iKeQEMc2Yl
	ZjcMAcQ/M1x18Uh56ZBdyFKGgkFsjtIDlfZrcGZquj8HVYBRm99K2hf8RsFW7xJH
	3g7n/v3oxM8tEZ5MXMG3zoW2vNne7PzGzvD8D2dQRwmqhCfMVrmOfN9f7GYgojpn
	MoSh44duEFpbohvi7eM3+D0ZVnbREG0RZMr0S0yMae2A2Pm3ik+i6v+iY3NoML04
	/ZifKQXaHJIWL+kJ5HPTqOsfBAUWCGRhxacIBXTZDwPMT4ZrLJZMg99dHyElKv7o
	uvUJA==
X-ME-Sender: <xms:74H_Z2k6gTtFaOr1xSQw7uQ-TAlidoEz6UeoHNzjQLj7puaBHrc0qQ>
    <xme:74H_Z91QQp9yl1gQsRCUsXwCI5KxDoSD_GFidrgNbqbeM0UCWiKLhYavXAIPkJvaJ
    lkvnhJSkrezV2em>
X-ME-Received: <xmr:74H_Z0pU_4xaQu9gh0X4a_sEIjjpFTHJ7tGFHLzyd2KWL6pazocfsiAG1yXEF2UWWZWJdbX-uPoqL6sSWx510n7QMgu43bCfY3pdTOHVd85Dp_3CVbpd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeiuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfesthejredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugessghssggvrh
    hnugdrtghomheqnecuggftrfgrthhtvghrnhepvdellefhuefghedugfefteeuffejgfet
    hfeuleegueethfegffegueffteehgeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsggvrhhnugessghssggvrhhnugdrtghomhdpnhgspghr
    tghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhsiigvrhgvug
    hisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:74H_Z6nLjJOv9X8svslKS7C5lfIfQPSbgnPByCGnNUsIQhKiJFKnlw>
    <xmx:74H_Z01R_NvRd3F1asTphb8eabnIzeh1eU23M4ohNmriH9wX4WDFkw>
    <xmx:74H_ZxtoXJVFfNkmVdQgA37rXPNNJkmHu66QO41uyhB8XUvvDykcNA>
    <xmx:74H_ZwUnYnMF6A5qQuZZUtGRDdcz5xC9ZLli3xuH-ECtXfEGv5jeGw>
    <xmx:74H_Zym92I1QP_wrJxxyxVUnmN0orrvNVBOfG7Fh-Dn5mZq0kYOFyCgr>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 06:09:50 -0400 (EDT)
Message-ID: <aa9a34f7-8e95-42c4-a23a-116738aa7f97@bsbernd.com>
Date: Wed, 16 Apr 2025 12:09:49 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] fuse: don't allow signals to interrupt getdents
 copying
To: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
References: <20250416090728.923460-1-mszeredi@redhat.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250416090728.923460-1-mszeredi@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/16/25 11:07, Miklos Szeredi wrote:
> When getting the directory contents, the entries are fist fetched to a
> kernel buffer, then they are copied to userspace with dir_emit().  This
> second phase is non-blocking as long as the userspace buffer is not paged
> out, making it interruptible makes zero sense.
> 
> Overload d_type as flags, since it only uses 4 bits from 32.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/fuse/readdir.c  |  4 ++--
>  fs/readdir.c       | 15 ++++++++++++---
>  include/linux/fs.h |  3 +++
>  3 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
> index 17ce9636a2b1..edcd6f18a8a8 100644
> --- a/fs/fuse/readdir.c
> +++ b/fs/fuse/readdir.c
> @@ -120,7 +120,7 @@ static bool fuse_emit(struct file *file, struct dir_context *ctx,
>  		fuse_add_dirent_to_cache(file, dirent, ctx->pos);
>  
>  	return dir_emit(ctx, dirent->name, dirent->namelen, dirent->ino,
> -			dirent->type);
> +			dirent->type | FILLDIR_FLAG_NOINTR);
>  }
>  
>  static int parse_dirfile(char *buf, size_t nbytes, struct file *file,
> @@ -419,7 +419,7 @@ static enum fuse_parse_result fuse_parse_cache(struct fuse_file *ff,
>  		if (ff->readdir.pos == ctx->pos) {
>  			res = FOUND_SOME;
>  			if (!dir_emit(ctx, dirent->name, dirent->namelen,
> -				      dirent->ino, dirent->type))
> +				      dirent->ino, dirent->type | FILLDIR_FLAG_NOINTR))
>  				return FOUND_ALL;
>  			ctx->pos = dirent->off;
>  		}
> diff --git a/fs/readdir.c b/fs/readdir.c
> index 0038efda417b..00ceae3fc2e3 100644
> --- a/fs/readdir.c
> +++ b/fs/readdir.c
> @@ -266,6 +266,9 @@ static bool filldir(struct dir_context *ctx, const char *name, int namlen,
>  	int reclen = ALIGN(offsetof(struct linux_dirent, d_name) + namlen + 2,
>  		sizeof(long));
>  	int prev_reclen;
> +	unsigned int flags = d_type;
> +
> +	d_type &= S_DT_MASK;
>  
>  	buf->error = verify_dirent_name(name, namlen);
>  	if (unlikely(buf->error))
> @@ -279,7 +282,7 @@ static bool filldir(struct dir_context *ctx, const char *name, int namlen,
>  		return false;
>  	}
>  	prev_reclen = buf->prev_reclen;
> -	if (prev_reclen && signal_pending(current))
> +	if (!(flags & FILLDIR_FLAG_NOINTR) && prev_reclen && signal_pending(current))
>  		return false;
>  	dirent = buf->current_dir;
>  	prev = (void __user *) dirent - prev_reclen;
> @@ -351,6 +354,9 @@ static bool filldir64(struct dir_context *ctx, const char *name, int namlen,
>  	int reclen = ALIGN(offsetof(struct linux_dirent64, d_name) + namlen + 1,
>  		sizeof(u64));
>  	int prev_reclen;
> +	unsigned int flags = d_type;
> +
> +	d_type &= S_DT_MASK;
>  
>  	buf->error = verify_dirent_name(name, namlen);
>  	if (unlikely(buf->error))
> @@ -359,7 +365,7 @@ static bool filldir64(struct dir_context *ctx, const char *name, int namlen,
>  	if (reclen > buf->count)
>  		return false;
>  	prev_reclen = buf->prev_reclen;
> -	if (prev_reclen && signal_pending(current))
> +	if (!(flags & FILLDIR_FLAG_NOINTR) && prev_reclen && signal_pending(current))
>  		return false;
>  	dirent = buf->current_dir;
>  	prev = (void __user *)dirent - prev_reclen;
> @@ -513,6 +519,9 @@ static bool compat_filldir(struct dir_context *ctx, const char *name, int namlen
>  	int reclen = ALIGN(offsetof(struct compat_linux_dirent, d_name) +
>  		namlen + 2, sizeof(compat_long_t));
>  	int prev_reclen;
> +	unsigned int flags = d_type;
> +
> +	d_type &= S_DT_MASK;
>  
>  	buf->error = verify_dirent_name(name, namlen);
>  	if (unlikely(buf->error))
> @@ -526,7 +535,7 @@ static bool compat_filldir(struct dir_context *ctx, const char *name, int namlen
>  		return false;
>  	}
>  	prev_reclen = buf->prev_reclen;
> -	if (prev_reclen && signal_pending(current))
> +	if (!(flags & FILLDIR_FLAG_NOINTR) && prev_reclen && signal_pending(current))
>  		return false;
>  	dirent = buf->current_dir;
>  	prev = (void __user *) dirent - prev_reclen;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 016b0fe1536e..0f2a1a572e3a 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2073,6 +2073,9 @@ struct dir_context {
>  	loff_t pos;
>  };
>  
> +/* If OR-ed with d_type, pending signals are not checked */
> +#define FILLDIR_FLAG_NOINTR	0x1000

This is the part that might be confusing - it is in another 
file than DT_MAX / S_DT_MASK - it might be hard to know about
FILLDIR_FLAG_NOINTR and possible other future flags?
But then it is certainly not a file type, having it in fs.h
makes sense from that point of view.


Reviewed-by: Bernd Schubert <bschubert@ddn.com>

