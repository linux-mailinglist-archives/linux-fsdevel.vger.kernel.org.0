Return-Path: <linux-fsdevel+bounces-15877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFB9895544
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 15:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12AE0B23EE6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 13:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099C7823DD;
	Tue,  2 Apr 2024 13:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="FLxPp+wO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="heTZOoId"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB72960B96;
	Tue,  2 Apr 2024 13:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064244; cv=none; b=MXQa4FuwR+ycYq8Qw+/5ZlrbQfq9T0G0A/rBDMWPVWpWBJja37+LRbwS8b6AIa2ISFd26KLsjV1x2n/5kJISbyY+jWYDiHhGjQJipwyvKEOh+uE7H6Zy4nzsh3vTCu3zOWlud5ZlK8sgaCfG7sgfirSDRGpd4k2ynpX6LLkw9wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064244; c=relaxed/simple;
	bh=USFwic0tTENjVLY2dqh0I2ab92hTn9N36VPGPzJOvAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Re2APQ6TQCnqgDLmM1T+45FBCqjetSRY0RXhowl8eI2xhL71Jz4KuVRxpLKOKiMPX6FKOpGEe3b1yL1mbIQQ1gfCvvTfZCR6Y0ZsDwxMPEUMp4cEJh2fnMh2AqH7+JodCAVt0tpM0lbpfc8GFpcjJX5RPvaksOFm+LhEHaRwnFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=FLxPp+wO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=heTZOoId; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id C77961380084;
	Tue,  2 Apr 2024 09:24:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 02 Apr 2024 09:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1712064240;
	 x=1712150640; bh=Js2S58m2l6sNwgBTMzF9uZUTqrqU2tT4zQ8cKP0U8TE=; b=
	FLxPp+wOz/Z60oJ1z/COp1ZBVuKPTbKoAhdL2utHywKpjURfcrDjZ1NG0Ob7olmY
	eKtFtqeLQYQiBYkZaEmG2yfUTXhe4a7h9cHyQp5mkp9ZsJoFXfvFgQ+/RLkLs3ZT
	+XXVD835RpK77XKJ4qjmAz7P3GQPGa2d8EBmjhTV2AagHNrzDdrxLYmwz7GuuwfF
	4bBRtAFWcObCCIatICEOrNUSOQvl2/+/XCmBtMj3e3P70/GQx+YDZ7KFvcopNyh2
	SvetBkq1+7Ttsys6ffmcCD95vfXyzrD5zUCPHnZ3mYsomr6GAVzw+UwV5rBQx0cO
	QpJ4kqMrTkx/J1GUDaqDrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712064240; x=
	1712150640; bh=Js2S58m2l6sNwgBTMzF9uZUTqrqU2tT4zQ8cKP0U8TE=; b=h
	eTZOoIdN34r3nHLr1ptBd2q/WY3ks/RD+HWGMPeU6WnrtY+T2CIS5LmLu0llx7FT
	OmZ/PrOof4u+B/5mdEwH16oqd46K9xQLsxfA9cC60l+VXlZq5YnrCE8DLFUYBJMV
	EnE89Dc5+cRLAn8zp+Ay5cDyb3xPlCTAQyXxgR1ys1P6s5ag1xYZqWbSqt+rD1lZ
	vF+2vK/Ix7Kljj6xWQlQ5/E18XtFSFiZapMODi5d4yL9Jn1JjazPhCEoZIlEmBul
	jEY6Acxf+5ncnEkCS+2r0Hl6wI3w2NqjCGaQTyydHYw7k6+qDOkQ+LBw+lpM3aDZ
	TmKexFKGCGz7KV+oE6w6w==
X-ME-Sender: <xms:8AYMZim9oA1i9CX1tK0JdUPYGfJv7JJTCuSbUqd0ALgaTtO3Jm-S3Q>
    <xme:8AYMZp18JW9ucttptYw2-Jb2yOC8cPYag8bppTq8WaHM5quh58rKEsRu9848BIo1W
    1wSes1V47enoL-6>
X-ME-Received: <xmr:8AYMZgp1B_9b9n91toHAajmx0HpoemLDsus9G4Obncn5SJEWZKeBkzrYhM_FcyQ9Jd11bfPM897BgDoHOWAIdfYGfwpP3QMVNoTDilS1yRUs-fcLMqSz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledtudfgtdfggeelfedvheefieev
    jeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:8AYMZmk9bx-XpTs-0WCqMQTrSboxhoHo4Kqcj92vz-CCwCXpcTf05Q>
    <xmx:8AYMZg1AmToSzuzzdSwzXuTloJP8DbvQXhzpKGStkCXWhZZ9lUcOnA>
    <xmx:8AYMZtuPrnXZfguzI0sYs6oLjo26-wOVCeKbrJ5rkk63nYmfUdvztA>
    <xmx:8AYMZsWTE-tA_Imhld45CkjGtbN4XGDnqWYRdQcKKPcMkkVLbZho_g>
    <xmx:8AYMZk-Cv8bnqzjbs2qQO99-0Vphptw2vZuNfsBqXJd1EVEp6QRO6ZBs>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 09:23:59 -0400 (EDT)
Message-ID: <8a8e8c0d-7878-4289-b490-cb9bf17e56b9@fastmail.fm>
Date: Tue, 2 Apr 2024 15:23:57 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fuse: allow FUSE drivers to declare themselves free
 from outside changes
To: Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240402-setlease-v2-1-b098a5f9295d@kernel.org>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20240402-setlease-v2-1-b098a5f9295d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/2/24 15:10, Jeff Layton wrote:
> Traditionally, we've allowed people to set leases on FUSE inodes.  Some
> FUSE drivers are effectively local filesystems and should be fine with
> kernel-internal lease support. Others are backed by a network server
> that may have multiple clients, or may be backed by something non-file
> like entirely. On those, we don't want to allow leases.
> 
> Have the filesytem driver to set a fuse_conn flag to indicate whether
> the inodes are subject to outside changes, not done via kernel APIs.  If
> the flag is unset (the default), then setlease attempts will fail with
> -EINVAL, indicating that leases aren't supported on that inode.
> 
> Local-ish filesystems may want to start setting this value to true to
> preserve the ability to set leases.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> This is only tested for compilation, but it's fairly straightforward.
> 
> I've left the default the "safe" value of false, so that we assume that
> outside changes are possible unless told otherwise.
> ---
> Changes in v2:
> - renamed flag to FUSE_NO_OUTSIDE_CHANGES
> - flesh out comment describing the new flag
> ---
>  fs/fuse/file.c            | 11 +++++++++++
>  fs/fuse/fuse_i.h          |  5 +++++
>  fs/fuse/inode.c           |  4 +++-
>  include/uapi/linux/fuse.h |  1 +
>  4 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index a56e7bffd000..79c7152c0d12 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -3298,6 +3298,16 @@ static ssize_t fuse_copy_file_range(struct file *src_file, loff_t src_off,
>  	return ret;
>  }
>  
> +static int fuse_setlease(struct file *file, int arg,
> +			 struct file_lease **flp, void **priv)
> +{
> +	struct fuse_conn *fc = get_fuse_conn(file_inode(file));
> +
> +	if (fc->no_outside_changes)
> +		return generic_setlease(file, arg, flp, priv);
> +	return -EINVAL;
> +}
> +
>  static const struct file_operations fuse_file_operations = {
>  	.llseek		= fuse_file_llseek,
>  	.read_iter	= fuse_file_read_iter,
> @@ -3317,6 +3327,7 @@ static const struct file_operations fuse_file_operations = {
>  	.poll		= fuse_file_poll,
>  	.fallocate	= fuse_file_fallocate,
>  	.copy_file_range = fuse_copy_file_range,
> +	.setlease	= fuse_setlease,
>  };
>  
>  static const struct address_space_operations fuse_file_aops  = {
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index b24084b60864..49d44a07b0db 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -860,6 +860,11 @@ struct fuse_conn {
>  	/** Passthrough support for read/write IO */
>  	unsigned int passthrough:1;
>  
> +	/** Can we assume that the only changes will be done via the local
> +	 *  kernel? If the driver represents a network filesystem or is a front
> +	 *  for data that can change on its own, set this to false. */
> +	unsigned int no_outside_changes:1;
> +
>  	/** Maximum stack depth for passthrough backing files */
>  	int max_stack_depth;
>  
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 3a5d88878335..f33aedccdb26 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1330,6 +1330,8 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
>  			}
>  			if (flags & FUSE_NO_EXPORT_SUPPORT)
>  				fm->sb->s_export_op = &fuse_export_fid_operations;
> +			if (flags & FUSE_NO_OUTSIDE_CHANGES)
> +				fc->no_outside_changes = 1;
>  		} else {
>  			ra_pages = fc->max_read / PAGE_SIZE;
>  			fc->no_lock = 1;
> @@ -1377,7 +1379,7 @@ void fuse_send_init(struct fuse_mount *fm)
>  		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_EXT |
>  		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
>  		FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP |
> -		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND;
> +		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND | FUSE_NO_OUTSIDE_CHANGES;
>  #ifdef CONFIG_FUSE_DAX
>  	if (fm->fc->dax)
>  		flags |= FUSE_MAP_ALIGNMENT;
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index d08b99d60f6f..703d149d45ff 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -463,6 +463,7 @@ struct fuse_file_lock {
>  #define FUSE_PASSTHROUGH	(1ULL << 37)
>  #define FUSE_NO_EXPORT_SUPPORT	(1ULL << 38)
>  #define FUSE_HAS_RESEND		(1ULL << 39)
> +#define FUSE_NO_OUTSIDE_CHANGES	(1ULL << 40)

Above all of these flags are comments explaining the flags, so that one
doesn't need to look up in kernel sources what the exact meaning is.

Could you please add something like below?

FUSE_NO_OUTSIDE_CHANGES: No file changes through other mounts / clients



Thanks,
Bernd


