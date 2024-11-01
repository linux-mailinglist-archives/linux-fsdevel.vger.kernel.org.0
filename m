Return-Path: <linux-fsdevel+bounces-33455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A759B900A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 12:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B532E1F224B3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 11:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1A819924A;
	Fri,  1 Nov 2024 11:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xb5Bjqcr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k5RVC1wO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K5oSEMFB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UuNIMjbF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADA718953D;
	Fri,  1 Nov 2024 11:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730459637; cv=none; b=BiZ5V+1MEAEA3jmbOyDst82ha/7xObxxpX0x0n3YWFC40MpKcLRVYnNcWUzSZ/C4DdVKmbAcM79iS/9yrDGoRA1FxvV/3OLFOiZX3uIiaUtM2w1ylxqujT+ZZNPvT2Pa6ZijZMb2OlYfHRCZGh+wnt3o9OCmgGT0z7syUfDiDjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730459637; c=relaxed/simple;
	bh=wofRbP/pMn87nKTukTcLzSwkzXDzjiYYay3B9CTczQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfzC/L1YaRoWm0nbU91W0Bz+uyxN4BnnD6Qstb4WNK96+UiTFsa0BlauzhGLC4OX/e0tecVn6C98OOMwzcBsOlyGaP9VNOyNCWUthpoWqNISYODpZxHsI9K4TL9i1giR54DbzVu17bsPz4gS9R0xkPwODKNF+vNYvpbn4vscEvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xb5Bjqcr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=k5RVC1wO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K5oSEMFB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UuNIMjbF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0960E21E2F;
	Fri,  1 Nov 2024 11:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730459633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DtT3u0Jge1FAxA07AdN4UGOFLn9EB0JG4DUFrAIuua8=;
	b=xb5Bjqcr2eEQJ/x0W1fo4gRcHfea1/4F4em6Xt7l+ax7e2bUtaPGtnS+6ZFaBef97lEbGG
	jN0cBvTNK80VA1G6v8uQI+DE6grOlt/S0afoGUV+TouLfcxvwZ4Q8e8T14IiRynT+rro4X
	HfkBXiWnyZz/8AFT6HiRdFk6PoeTTGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730459633;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DtT3u0Jge1FAxA07AdN4UGOFLn9EB0JG4DUFrAIuua8=;
	b=k5RVC1wO6G+derlfstBOxTSpOs7DI6rtiakrkaMotBbwO3FfVpuQXNfagPRKdEwzksTbdn
	8uo/BN3ZSxFfySAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=K5oSEMFB;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UuNIMjbF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730459632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DtT3u0Jge1FAxA07AdN4UGOFLn9EB0JG4DUFrAIuua8=;
	b=K5oSEMFBOKBXvqSnmOUbRs50mEXwidlhVoaTtyKLAGpjqPbbfoXypcha2mepBKj7FZo5Vo
	BvB0Ai0yV4OKPKDbj6vcta6XdWC1QDa3wdVGfCc3T0vIcjCWHpG+pbY+7EckPuowJi3SZ6
	9ioq+ndxNjphyEHwjzoiXitZf1mfy+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730459632;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DtT3u0Jge1FAxA07AdN4UGOFLn9EB0JG4DUFrAIuua8=;
	b=UuNIMjbF9xclxCvqWukvgTgsqM43sQ106ZLwPH/dyKLhH8RsTF+NOYuoOfdnWt1+olKt43
	LwZj9K55VnPWEMAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F1BFD136D9;
	Fri,  1 Nov 2024 11:13:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AxX9Ou+3JGdgVwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 01 Nov 2024 11:13:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A8D0FA0AF4; Fri,  1 Nov 2024 12:13:36 +0100 (CET)
Date: Fri, 1 Nov 2024 12:13:36 +0100
From: Jan Kara <jack@suse.cz>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>, "Darrick J . Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	John Garry <john.g.garry@oracle.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] ext4: Do not fallback to buffered-io for DIO
 atomic write
Message-ID: <20241101111336.j34umexmaww4uyae@quack3>
References: <cover.1730437365.git.ritesh.list@gmail.com>
 <78fb5c40dde4847dc32af09e668a6f81fa251137.1730437365.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78fb5c40dde4847dc32af09e668a6f81fa251137.1730437365.git.ritesh.list@gmail.com>
X-Rspamd-Queue-Id: 0960E21E2F
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 01-11-24 12:20:54, Ritesh Harjani (IBM) wrote:
> atomic writes is currently only supported for single fsblock and only
> for direct-io. We should not return -ENOTBLK for atomic writes since we
> want the atomic write request to either complete fully or fail
> otherwise. Hence, we should never fallback to buffered-io in case of
> DIO atomic write requests.
> Let's also catch if this ever happens by adding some WARN_ON_ONCE before
> buffered-io handling for direct-io atomic writes. More details of the
> discussion [1].
> 
> While at it let's add an inline helper ext4_want_directio_fallback() which
> simplifies the logic checks and inherently fixes condition on when to return
> -ENOTBLK which otherwise was always returning true for any write or directio in
> ext4_iomap_end(). It was ok since ext4 only supports direct-io via iomap.
> 
> [1]: https://lore.kernel.org/linux-xfs/cover.1729825985.git.ritesh.list@gmail.com/T/#m9dbecc11bed713ed0d7a486432c56b105b555f04
> Suggested-by: Darrick J. Wong <djwong@kernel.org> # inline helper
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/file.c  |  7 +++++++
>  fs/ext4/inode.c | 27 ++++++++++++++++++++++-----
>  2 files changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 96d936f5584b..a7de03e47db0 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -599,6 +599,13 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  		ssize_t err;
>  		loff_t endbyte;
> 
> +		/*
> +		 * There is no support for atomic writes on buffered-io yet,
> +		 * we should never fallback to buffered-io for DIO atomic
> +		 * writes.
> +		 */
> +		WARN_ON_ONCE(iocb->ki_flags & IOCB_ATOMIC);
> +
>  		offset = iocb->ki_pos;
>  		err = ext4_buffered_write_iter(iocb, from);
>  		if (err < 0)
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 3e827cfa762e..5b9eeb74ce47 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3444,17 +3444,34 @@ static int ext4_iomap_overwrite_begin(struct inode *inode, loff_t offset,
>  	return ret;
>  }
> 
> +static inline bool ext4_want_directio_fallback(unsigned flags, ssize_t written)
> +{
> +	/* must be a directio to fall back to buffered */
> +	if ((flags & (IOMAP_WRITE | IOMAP_DIRECT)) !=
> +		    (IOMAP_WRITE | IOMAP_DIRECT))
> +		return false;
> +
> +	/* atomic writes are all-or-nothing */
> +	if (flags & IOMAP_ATOMIC)
> +		return false;
> +
> +	/* can only try again if we wrote nothing */
> +	return written == 0;
> +}
> +
>  static int ext4_iomap_end(struct inode *inode, loff_t offset, loff_t length,
>  			  ssize_t written, unsigned flags, struct iomap *iomap)
>  {
>  	/*
>  	 * Check to see whether an error occurred while writing out the data to
> -	 * the allocated blocks. If so, return the magic error code so that we
> -	 * fallback to buffered I/O and attempt to complete the remainder of
> -	 * the I/O. Any blocks that may have been allocated in preparation for
> -	 * the direct I/O will be reused during buffered I/O.
> +	 * the allocated blocks. If so, return the magic error code for
> +	 * non-atomic write so that we fallback to buffered I/O and attempt to
> +	 * complete the remainder of the I/O.
> +	 * For non-atomic writes, any blocks that may have been
> +	 * allocated in preparation for the direct I/O will be reused during
> +	 * buffered I/O. For atomic write, we never fallback to buffered-io.
>  	 */
> -	if (flags & (IOMAP_WRITE | IOMAP_DIRECT) && written == 0)
> +	if (ext4_want_directio_fallback(flags, written))
>  		return -ENOTBLK;
> 
>  	return 0;
> --
> 2.46.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

