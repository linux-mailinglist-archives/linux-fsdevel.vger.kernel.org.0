Return-Path: <linux-fsdevel+bounces-38454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E140FA02DC6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 17:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EC093A5768
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 16:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DB51DDC3A;
	Mon,  6 Jan 2025 16:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ztc4uGGi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gxEzzlq+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ztc4uGGi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gxEzzlq+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3784142E7C;
	Mon,  6 Jan 2025 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736180933; cv=none; b=usOmPmX4+MJPGkmYAkliqJ4g7mZTQk1MAaazzAKA1v2ecCARYe64a79dcdWPtnvIDoui2IFbye8ssZB/M/L8ywumpnBNEgr9et4uS+nbvmaaXzS+cpRzwhjIwAVhpZZOOW6wkt8jKA6yfFzI0GmiAofTh7MMvsJU7p3AZk2X9Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736180933; c=relaxed/simple;
	bh=IklxIHPtgMbN+/+3Y2Pr2Utb2V+Wd2RauiNMoXWluRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5tGHiuniHp8UpsvWu/eGn9Y/y3FRvcWcwm7TJIgewdrVUMStX3/1k9zykcyzq6mnSXra3jSv8TDoSSfMs7wuRYUDL9H/PcxHS/ZGs+adKzBsR2igQxtfDNsM01TvaG1ykxnUhiCnX6KtRtPnA7GUBBoUbw/3b5yQ8quiDPeCFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ztc4uGGi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gxEzzlq+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ztc4uGGi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gxEzzlq+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0B6E421114;
	Mon,  6 Jan 2025 16:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736180930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ccKG3tbctQt4qp4iia2LI9uHvYP1rYFEwKMr2pLwwAU=;
	b=Ztc4uGGiFzMseT8fJSNOFgh2QVxZQ+1+DvTArnpwy1Zv+mSFi+pyM+eJ02IAHt19i2m1bC
	DZ88X/fj0fq3Bmvx0h7Zy0+fWmSf1QYQuh/0pUywTzrpVksqR21A5Sk25ImygIqYBIXOv3
	zavRfeoy6DzyNaNijCJys5l2yvVPimQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736180930;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ccKG3tbctQt4qp4iia2LI9uHvYP1rYFEwKMr2pLwwAU=;
	b=gxEzzlq+NK0fRDNhcJJ0JsnwLV2kpfVtmq3TRRpcX/DLz3ApZzhEOizIH6jNHiPw6mbtou
	kM2tScNwVGJgPCCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736180930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ccKG3tbctQt4qp4iia2LI9uHvYP1rYFEwKMr2pLwwAU=;
	b=Ztc4uGGiFzMseT8fJSNOFgh2QVxZQ+1+DvTArnpwy1Zv+mSFi+pyM+eJ02IAHt19i2m1bC
	DZ88X/fj0fq3Bmvx0h7Zy0+fWmSf1QYQuh/0pUywTzrpVksqR21A5Sk25ImygIqYBIXOv3
	zavRfeoy6DzyNaNijCJys5l2yvVPimQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736180930;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ccKG3tbctQt4qp4iia2LI9uHvYP1rYFEwKMr2pLwwAU=;
	b=gxEzzlq+NK0fRDNhcJJ0JsnwLV2kpfVtmq3TRRpcX/DLz3ApZzhEOizIH6jNHiPw6mbtou
	kM2tScNwVGJgPCCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB01A137DA;
	Mon,  6 Jan 2025 16:28:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id t34bOcEEfGeVWQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 06 Jan 2025 16:28:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 89073A089C; Mon,  6 Jan 2025 17:28:49 +0100 (CET)
Date: Mon, 6 Jan 2025 17:28:49 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Chandan Babu R <chandan.babu@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Hongbo Li <lihongbo22@huawei.com>, Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/4] fs: reformat the statx definition
Message-ID: <ggon3g5j7a5epncdfapqwxtoefptoxuimxvihmadc3aurqkfyr@bqypxcr43rvn>
References: <20250106151607.954940-1-hch@lst.de>
 <20250106151607.954940-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106151607.954940-2-hch@lst.de>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,huawei.com,gmail.com,vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email]
X-Spam-Score: -2.30
X-Spam-Flag: NO

On Mon 06-01-25 16:15:54, Christoph Hellwig wrote:
> The comments after the declaration are becoming rather unreadable with
> long enough comments.  Move them into lines of their own.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/uapi/linux/stat.h | 95 +++++++++++++++++++++++++++++----------
>  1 file changed, 72 insertions(+), 23 deletions(-)
> 
> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> index 887a25286441..8b35d7d511a2 100644
> --- a/include/uapi/linux/stat.h
> +++ b/include/uapi/linux/stat.h
> @@ -98,43 +98,92 @@ struct statx_timestamp {
>   */
>  struct statx {
>  	/* 0x00 */
> -	__u32	stx_mask;	/* What results were written [uncond] */
> -	__u32	stx_blksize;	/* Preferred general I/O size [uncond] */
> -	__u64	stx_attributes;	/* Flags conveying information about the file [uncond] */
> +	/* What results were written [uncond] */
> +	__u32	stx_mask;
> +
> +	/* Preferred general I/O size [uncond] */
> +	__u32	stx_blksize;
> +
> +	/* Flags conveying information about the file [uncond] */
> +	__u64	stx_attributes;
> +
>  	/* 0x10 */
> -	__u32	stx_nlink;	/* Number of hard links */
> -	__u32	stx_uid;	/* User ID of owner */
> -	__u32	stx_gid;	/* Group ID of owner */
> -	__u16	stx_mode;	/* File mode */
> +	/* Number of hard links */
> +	__u32	stx_nlink;
> +
> +	/* User ID of owner */
> +	__u32	stx_uid;
> +
> +	/* Group ID of owner */
> +	__u32	stx_gid;
> +
> +	/* File mode */
> +	__u16	stx_mode;
>  	__u16	__spare0[1];
> +
>  	/* 0x20 */
> -	__u64	stx_ino;	/* Inode number */
> -	__u64	stx_size;	/* File size */
> -	__u64	stx_blocks;	/* Number of 512-byte blocks allocated */
> -	__u64	stx_attributes_mask; /* Mask to show what's supported in stx_attributes */
> +	/* Inode number */
> +	__u64	stx_ino;
> +
> +	/* File size */
> +	__u64	stx_size;
> +
> +	/* Number of 512-byte blocks allocated */
> +	__u64	stx_blocks;
> +
> +	/* Mask to show what's supported in stx_attributes */
> +	__u64	stx_attributes_mask;
> +
>  	/* 0x40 */
> -	struct statx_timestamp	stx_atime;	/* Last access time */
> -	struct statx_timestamp	stx_btime;	/* File creation time */
> -	struct statx_timestamp	stx_ctime;	/* Last attribute change time */
> -	struct statx_timestamp	stx_mtime;	/* Last data modification time */
> +	/* Last access time */
> +	struct statx_timestamp	stx_atime;
> +
> +	/* File creation time */
> +	struct statx_timestamp	stx_btime;
> +
> +	/* Last attribute change time */
> +	struct statx_timestamp	stx_ctime;
> +
> +	/* Last data modification time */
> +	struct statx_timestamp	stx_mtime;
> +
>  	/* 0x80 */
> -	__u32	stx_rdev_major;	/* Device ID of special file [if bdev/cdev] */
> +	/* Device ID of special file [if bdev/cdev] */
> +	__u32	stx_rdev_major;
>  	__u32	stx_rdev_minor;
> -	__u32	stx_dev_major;	/* ID of device containing file [uncond] */
> +
> +	/* ID of device containing file [uncond] */
> +	__u32	stx_dev_major;
>  	__u32	stx_dev_minor;
> +
>  	/* 0x90 */
>  	__u64	stx_mnt_id;
> -	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
> -	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
> +
> +	/* Memory buffer alignment for direct I/O */
> +	__u32	stx_dio_mem_align;
> +
> +	/* File offset alignment for direct I/O */
> +	__u32	stx_dio_offset_align;
> +
>  	/* 0xa0 */
> -	__u64	stx_subvol;	/* Subvolume identifier */
> -	__u32	stx_atomic_write_unit_min;	/* Min atomic write unit in bytes */
> -	__u32	stx_atomic_write_unit_max;	/* Max atomic write unit in bytes */
> +	/* Subvolume identifier */
> +	__u64	stx_subvol;
> +
> +	/* Min atomic write unit in bytes */
> +	__u32	stx_atomic_write_unit_min;
> +
> +	/* Max atomic write unit in bytes */
> +	__u32	stx_atomic_write_unit_max;
> +
>  	/* 0xb0 */
> -	__u32   stx_atomic_write_segments_max;	/* Max atomic write segment count */
> +	/* Max atomic write segment count */
> +	__u32   stx_atomic_write_segments_max;
> +
>  	__u32   __spare1[1];
> +
>  	/* 0xb8 */
>  	__u64	__spare3[9];	/* Spare space for future expansion */
> +
>  	/* 0x100 */
>  };
>  
> -- 
> 2.45.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

