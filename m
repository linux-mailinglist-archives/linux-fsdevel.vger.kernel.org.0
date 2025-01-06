Return-Path: <linux-fsdevel+bounces-38456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BECA02DDD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 17:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5DC73A035F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 16:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69EA1DE4FB;
	Mon,  6 Jan 2025 16:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RchITIZG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VFTFmHPe";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RchITIZG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VFTFmHPe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237EC15C120;
	Mon,  6 Jan 2025 16:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736181139; cv=none; b=exOAA46c044QLOX1Jenm5BFsvvL6cGdm3HACbPgTSdTuX6+S1FqwIFojH2k1yvR0ZBWPzNVq2efvYspcICDBfjyxOR6Sbewph4Y3aRkoO/8OSVARmRAXyk7Re6IpbBvh/nON9rP+Pu+01TpHqTDG2n5xrr2Pihl5GlpUkNqqQjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736181139; c=relaxed/simple;
	bh=xDJgmI192oP5ri86Kd31lA3f9muCrvmu6e/rXxoaHfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IuF0WNYwFkY9TIYRr0FkET1ArdIvbFd0o9clbUANYPxt53uYhKD5gW5G4nEz11vgYX0A/NU8AFTCbTlscg409siW14h7bNueg3KHcE+Xoxb+YL5v728RRG8WNtQz3smOQ9iD+Q6Ljie30vdNKGqGdffa8cWNusrQizDWYlQ0tCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RchITIZG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VFTFmHPe; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RchITIZG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VFTFmHPe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 142A31F44E;
	Mon,  6 Jan 2025 16:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736181135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RWPdAZlb59xkLZuu1WHl6e4ladkxOHvL26RatpSZduY=;
	b=RchITIZG4jMQ78SSUe6F8qOk/PD1Xxa/wKfqQDGG0sq4/+pwn41kymsWuG0gtGEA7kFh8h
	Jp2366WdNPxn2B/3QQ7PA4WPMSrCTw/FWMGah8n8UtxDvFCtJ5ny2fXQLcvkz3QxhgR0+d
	cdGfhWU5UUCCz8Cc1CU26Ppu1867A4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736181135;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RWPdAZlb59xkLZuu1WHl6e4ladkxOHvL26RatpSZduY=;
	b=VFTFmHPerTOFbpXLearTaChPlWGGSsOQRNmXp80EPHrr1iII8cJ+pIkGy8ScgoINmBkqGw
	xQh0OpwOVJ/6T9CA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=RchITIZG;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VFTFmHPe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736181135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RWPdAZlb59xkLZuu1WHl6e4ladkxOHvL26RatpSZduY=;
	b=RchITIZG4jMQ78SSUe6F8qOk/PD1Xxa/wKfqQDGG0sq4/+pwn41kymsWuG0gtGEA7kFh8h
	Jp2366WdNPxn2B/3QQ7PA4WPMSrCTw/FWMGah8n8UtxDvFCtJ5ny2fXQLcvkz3QxhgR0+d
	cdGfhWU5UUCCz8Cc1CU26Ppu1867A4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736181135;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RWPdAZlb59xkLZuu1WHl6e4ladkxOHvL26RatpSZduY=;
	b=VFTFmHPerTOFbpXLearTaChPlWGGSsOQRNmXp80EPHrr1iII8cJ+pIkGy8ScgoINmBkqGw
	xQh0OpwOVJ/6T9CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 02CBA137DA;
	Mon,  6 Jan 2025 16:32:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BZesAI8FfGeaWgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 06 Jan 2025 16:32:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8A283A089C; Mon,  6 Jan 2025 17:32:14 +0100 (CET)
Date: Mon, 6 Jan 2025 17:32:14 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Chandan Babu R <chandan.babu@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Hongbo Li <lihongbo22@huawei.com>, Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/4] fs: add STATX_DIO_READ_ALIGN
Message-ID: <o2gecwhofinap2qolyomkaijaeaorbqnqw4othvpwl4eqhdieo@a57gqldklqi7>
References: <20250106151607.954940-1-hch@lst.de>
 <20250106151607.954940-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106151607.954940-3-hch@lst.de>
X-Rspamd-Queue-Id: 142A31F44E
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[11];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,huawei.com,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

On Mon 06-01-25 16:15:55, Christoph Hellwig wrote:
> Add a separate dio read align field, as many out of place write
> file systems can easily do reads aligned to the device sector size,
> but require bigger alignment for writes.
> 
> This is usually papered over by falling back to buffered I/O for smaller
> writes and doing read-modify-write cycles, but performance for this
> sucks, so applications benefit from knowing the actual write alignment.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

So if I understand right dio_offset_align is guaranteed to work for all DIO
(i.e., maximum of all possible alignments), dio_read_offset_align is
possibly lower and works only for reads. Looks good to me. Feel free to
add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/stat.c                 | 1 +
>  include/linux/stat.h      | 1 +
>  include/uapi/linux/stat.h | 4 +++-
>  3 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/stat.c b/fs/stat.c
> index 0870e969a8a0..2c0e111a098a 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -725,6 +725,7 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
>  	tmp.stx_mnt_id = stat->mnt_id;
>  	tmp.stx_dio_mem_align = stat->dio_mem_align;
>  	tmp.stx_dio_offset_align = stat->dio_offset_align;
> +	tmp.stx_dio_read_offset_align = stat->dio_read_offset_align;
>  	tmp.stx_subvol = stat->subvol;
>  	tmp.stx_atomic_write_unit_min = stat->atomic_write_unit_min;
>  	tmp.stx_atomic_write_unit_max = stat->atomic_write_unit_max;
> diff --git a/include/linux/stat.h b/include/linux/stat.h
> index 3d900c86981c..9d8382e23a9c 100644
> --- a/include/linux/stat.h
> +++ b/include/linux/stat.h
> @@ -52,6 +52,7 @@ struct kstat {
>  	u64		mnt_id;
>  	u32		dio_mem_align;
>  	u32		dio_offset_align;
> +	u32		dio_read_offset_align;
>  	u64		change_cookie;
>  	u64		subvol;
>  	u32		atomic_write_unit_min;
> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> index 8b35d7d511a2..f78ee3670dd5 100644
> --- a/include/uapi/linux/stat.h
> +++ b/include/uapi/linux/stat.h
> @@ -179,7 +179,8 @@ struct statx {
>  	/* Max atomic write segment count */
>  	__u32   stx_atomic_write_segments_max;
>  
> -	__u32   __spare1[1];
> +	/* File offset alignment for direct I/O reads */
> +	__u32	stx_dio_read_offset_align;
>  
>  	/* 0xb8 */
>  	__u64	__spare3[9];	/* Spare space for future expansion */
> @@ -213,6 +214,7 @@ struct statx {
>  #define STATX_MNT_ID_UNIQUE	0x00004000U	/* Want/got extended stx_mount_id */
>  #define STATX_SUBVOL		0x00008000U	/* Want/got stx_subvol */
>  #define STATX_WRITE_ATOMIC	0x00010000U	/* Want/got atomic_write_* fields */
> +#define STATX_DIO_READ_ALIGN	0x00020000U	/* Want/got dio read alignment info */
>  
>  #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
>  
> -- 
> 2.45.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

