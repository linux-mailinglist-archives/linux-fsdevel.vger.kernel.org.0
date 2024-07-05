Return-Path: <linux-fsdevel+bounces-23195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C281928833
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 13:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD4AA2870C6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 11:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90802149DFA;
	Fri,  5 Jul 2024 11:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="Dwliym3D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="irI83qys"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702DC146D45;
	Fri,  5 Jul 2024 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720180207; cv=none; b=cZQFrcAs2EFNCDRJxO05tuzF5WYDbwyqfvy+rEh1dt9UAxgw0sKL0tZYiTXrEAZvrEtHPLAaoc1CBX2FGX8Pp+KFlijdPVFk3/dH+ctquhtCwrR4Wpoj6AeZg1lZ5RLiNWY2XSKapeJapYNBWE417arxnKHEmL2B3Iofj9RbTKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720180207; c=relaxed/simple;
	bh=Uvmlvi5c6K5Xe9xvACZBTHBHPox8EvzM/gnA0fiaSEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jUsb1qDliw2CTPgCZKeMvcZUIG7nepHJnEcT2y3I/Rl3rbhQ3QX0ACePvvL4BCdlwKGaWpX7CN2J2R6LTqA+NDOVBV98kTkQFgMI7p9oN9mjbzCE3gbjqiCPn3srHNcQVU6uu8VkXxMX9Vms8wCyr9u09as4UtR8cyQZkFyi0EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=Dwliym3D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=irI83qys; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7D6B51140225;
	Fri,  5 Jul 2024 07:50:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 05 Jul 2024 07:50:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1720180204;
	 x=1720266604; bh=P5Moo0o6AavA7RrRK876IOZmHcSEvzMU+9njrwM8Nyk=; b=
	Dwliym3D84SuB0x4SEdEk17Gj2H0HTciyCvTFnDE+wFgIcM9Fql9jTvXYvRNpyQZ
	LLKW7OudC430z5uox2arZX9BgZU/FXWMPXgrzev+vmPnspr3Iw+BqJGzYWGqb/E+
	O97B8DdC7wWHZl4P54aKTAmWPNOk9j1KrEHl97GFHPkz2EWVN4Ixq1qN1NhxqdUG
	8qxDGULyZD0z9M7fvEhNX/0BED18MKNIwIvEy5+R60hZyr7PwAhKB2D76jt82GrO
	ZaMxxO9Pfd6qBEHKvCFFCqHMFRNX25F6ZOVmtk3+ZNpgoUEVDt5RG1FZ7TG+NXx+
	XUZ8sY4vF7h0N017qSdx0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1720180204; x=
	1720266604; bh=P5Moo0o6AavA7RrRK876IOZmHcSEvzMU+9njrwM8Nyk=; b=i
	rI83qysMZ649OR7hHF9IVpIJXF5JZ8ngGLrH8sqzjYGzJ5NyojYCZIiu6Nf+Qg79
	Ij6gpElbg1IHn10kzXQ9818ej/jEyxAylK/933ouQVNADBe7ieY2pvXs7xSG9pjb
	BGD89pkLfzxep1VtUC9xz3jSg8r9pDrZhU7J1TWo0OsiB+mUeSVA2eeffUpmrWlj
	HaWi+FSja2yhBp8qYF0eOOj0Z0oLD8UH4lPQ+rb5HwUEW5fUz1r/lZKF6nPIU1So
	BbOKknHFXZKg6NrSMIBkScHhxjEKUf722ATr63enL6DaietS95o3K56GT3jLfTVs
	pP47sbmccWyBjE22/T3GA==
X-ME-Sender: <xms:692HZpu1uNG8p4aKQM1IMFqhsN99XA9OkeWj6JHam1rQLsvRTvlXBw>
    <xme:692HZiexqFuzIItFPCp1iRJ9v2YlDE7UmJE1CAtKw2K0GbbHzt64WNms-QBgoYGbV
    gf2-1jSop8Lx1bG>
X-ME-Received: <xmr:692HZszPUK_BGJlpZ3uHxTPxG0784K6O05FT7R2ZD6xTWErCk49QD0RBHhMwJg0QkqG3UHKqXDfhpbokGwZ9UrKklgdkQZaDN1dhTWOVwSEpLXmOODFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddugdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtje
    ertddtvdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhs
    tghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepffejve
    effeejgffhfefhieeuffffteeltdfghffhtddtfeeuveelvdelteefvedtnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhf
    mh
X-ME-Proxy: <xmx:692HZgMuDf0Ugl04Ly27jcNgZv7hCy_OGU0X14xnr_g1ODGyD6Rwkg>
    <xmx:692HZp8N-9bZYLNvdpn5haLa7tRuL6dppkPXzekEF5PGO5OIwyo1Bw>
    <xmx:692HZgVDnAjcAhuRI5mEfBOnagNUb4bWdM0oF8zLemLi-U8SQjnj_w>
    <xmx:692HZqeY-J-RQFUeqVizc8A4iccGxH76rPePW0XlbZFMmMhCw5jm0w>
    <xmx:7N2HZlb17yM_mohVnCl-B33dBRUq5hNbLrMqVAyGKuBJrzGOAd_-TgZg>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jul 2024 07:50:02 -0400 (EDT)
Message-ID: <ca86fc29-b0fe-4e23-94b3-76015a95b64f@fastmail.fm>
Date: Fri, 5 Jul 2024 13:50:01 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: make foffset alignment opt-in for optimum backend
 performance
To: Jingbo Xu <jefflexu@linux.alibaba.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20240705100449.60891-1-jefflexu@linux.alibaba.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, fr, ru
In-Reply-To: <20240705100449.60891-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/5/24 12:04, Jingbo Xu wrote:
> Sometimes the file offset alignment needs to be opt-in to achieve the
> optimum performance at the backend store.
> 
> For example when ErasureCode [1] is used at the backend store, the
> optimum write performance is achieved when the WRITE request is aligned
> with the stripe size of ErasureCode.  Otherwise a non-aligned WRITE
> request needs to be split at the stripe size boundary.  It is quite
> costly to handle these split partial requests, as firstly the whole
> stripe to which the split partial request belongs needs to be read out,
> then overwrite the read stripe buffer with the request, and finally write
> the whole stripe back to the persistent storage.
> 
> Thus the backend store can suffer severe performance degradation when
> WRITE requests can not fit into one stripe exactly.  The write performance
> can be 10x slower when the request is 256KB in size given 4MB stripe size.
> Also there can be 50% performance degradation in theory if the request
> is not stripe boundary aligned.
> 
> Besides, the conveyed test indicates that, the non-alignment issue
> becomes more severe when decreasing fuse's max_ratio, maybe partly
> because the background writeback now is more likely to run parallelly
> with the dirtier.
> 
> fuse's max_ratio	ratio of aligned WRITE requests
> ----------------	-------------------------------
> 70			99.9%
> 40			74%
> 20			45%
> 10			20%
> 
> With the patched version, which makes the alignment constraint opt-in
> when constructing WRITE requests, the ratio of aligned WRITE requests
> increases to 98% (previously 20%) when fuse's max_ratio is 10.
> 
> [1] https://lore.kernel.org/linux-fsdevel/20240124070512.52207-1-jefflexu@linux.alibaba.com/T/#m9bce469998ea6e4f911555c6f7be1e077ce3d8b4
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/fuse/file.c            | 4 ++++
>  fs/fuse/fuse_i.h          | 6 ++++++
>  fs/fuse/inode.c           | 9 +++++++++
>  include/uapi/linux/fuse.h | 9 ++++++++-
>  4 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index f39456c65ed7..f9b477016c2e 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -2246,6 +2246,10 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, struct page *page,
>  	if (ap->num_pages == data->max_pages && !fuse_pages_realloc(data))
>  		return true;
>  
> +	/* Reached alignment */
> +	if (fc->opt_alignment && !(page->index % fc->opt_alignment_pages))
> +		return true;

I link the idea, but couldn't it just do that with 
fc->max_pages? I'm asking because fc->opt_alignment_pages
takes another uint32_t in fuse_init_out and there is not so much
space left anymore.

> +
>  	return false;
>  }
>  
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index f23919610313..5963571b394c 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -860,6 +860,9 @@ struct fuse_conn {
>  	/** Passthrough support for read/write IO */
>  	unsigned int passthrough:1;
>  
> +	/* Foffset alignment required for optimum performance */
> +	unsigned int opt_alignment:1;
> +
>  	/** Maximum stack depth for passthrough backing files */
>  	int max_stack_depth;
>  
> @@ -917,6 +920,9 @@ struct fuse_conn {
>  	/** IDR for backing files ids */
>  	struct idr backing_files_map;
>  #endif
> +
> +	/* The foffset alignment in PAGE_SIZE */
> +	unsigned int opt_alignment_pages;
>  };
>  
>  /*
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 99e44ea7d875..9266b22cce8e 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1331,6 +1331,15 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
>  			}
>  			if (flags & FUSE_NO_EXPORT_SUPPORT)
>  				fm->sb->s_export_op = &fuse_export_fid_operations;
> +
> +			/* fallback to default if opt_alignment <= PAGE_SHIFT */
> +			if (flags & FUSE_OPT_ALIGNMENT) {
> +				if (arg->opt_alignment > PAGE_SHIFT) {
> +					fc->opt_alignment = 1;
> +					fc->opt_alignment_pages = 1 <<
> +						(arg->opt_alignment - PAGE_SHIFT);

opt_alignment is the number of bits required for alignment? Not 
very user friendly, from my point of view would be better to have
this in a byte or kb unit.


Thanks,
Bernd


> +				}
> +			}
>  		} else {
>  			ra_pages = fc->max_read / PAGE_SIZE;
>  			fc->no_lock = 1;
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index d08b99d60f6f..2c6ad1577591 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -217,6 +217,9 @@
>   *  - add backing_id to fuse_open_out, add FOPEN_PASSTHROUGH open flag
>   *  - add FUSE_NO_EXPORT_SUPPORT init flag
>   *  - add FUSE_NOTIFY_RESEND, add FUSE_HAS_RESEND init flag
> + *
> + *  7.41
> + *  - add opt_alignment to fuse_init_out, add FUSE_OPT_ALIGNMENT init flag
>   */
>  
>  #ifndef _LINUX_FUSE_H
> @@ -421,6 +424,8 @@ struct fuse_file_lock {
>   * FUSE_NO_EXPORT_SUPPORT: explicitly disable export support
>   * FUSE_HAS_RESEND: kernel supports resending pending requests, and the high bit
>   *		    of the request ID indicates resend requests
> + * FUSE_OPT_ALIGNMENT: init_out.opt_alignment contains log2(byte alignment) for
> + *		       foffset alignment for optimum write performance
>   */
>  #define FUSE_ASYNC_READ		(1 << 0)
>  #define FUSE_POSIX_LOCKS	(1 << 1)
> @@ -463,6 +468,7 @@ struct fuse_file_lock {
>  #define FUSE_PASSTHROUGH	(1ULL << 37)
>  #define FUSE_NO_EXPORT_SUPPORT	(1ULL << 38)
>  #define FUSE_HAS_RESEND		(1ULL << 39)
> +#define FUSE_OPT_ALIGNMENT	(1ULL << 40)
>  
>  /* Obsolete alias for FUSE_DIRECT_IO_ALLOW_MMAP */
>  #define FUSE_DIRECT_IO_RELAX	FUSE_DIRECT_IO_ALLOW_MMAP
> @@ -893,7 +899,8 @@ struct fuse_init_out {
>  	uint16_t	map_alignment;
>  	uint32_t	flags2;
>  	uint32_t	max_stack_depth;
> -	uint32_t	unused[6];
> +	uint32_t	opt_alignment;
> +	uint32_t	unused[5];
>  };
>  
>  #define CUSE_INIT_INFO_MAX 4096

