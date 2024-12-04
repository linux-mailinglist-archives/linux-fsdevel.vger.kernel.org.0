Return-Path: <linux-fsdevel+bounces-36433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB549E3A08
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 13:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29FE7B2E24E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 12:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09031B87C4;
	Wed,  4 Dec 2024 12:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZjSyxQDB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aIlOAOVW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cJFusa5M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rPvzw9NX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783421B3944;
	Wed,  4 Dec 2024 12:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733314610; cv=none; b=pKdgIotmIG22DIGeLiDtq4UH8T/AyamDpc8bdBpmeG1i6s/rJu00f5g+8X3Yqm55s3XORjZfXq+yHadRbHNjrbciLT3i5zU7iFyx/li1iHsnu7mFea5+bYhvg1r80yAY5438rire1R+/PbB1zNcEBZE75Wx4+US532QThJIjAt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733314610; c=relaxed/simple;
	bh=mbqm05QsLtfH1zcVtdC0Ew81ktpfdl9KOf/MRMKnyXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LO4RdCLhWu0NZzYA8GTB9nCME+9y3x8vsHnX8lSdwfNmakZTTy9iDYEslPM+DZnvl4pwd8Utr0oPWcsUCdsLF9eSyruVzNIJPbbbdxo+TTWIEPyD9YpwDFxbV9lXBrfvB3edPLU41Th+kSPV2RanKSXRPuW4XHCj5+X2Zte2L0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZjSyxQDB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aIlOAOVW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cJFusa5M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rPvzw9NX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5798F21162;
	Wed,  4 Dec 2024 12:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733314606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2CWmtwh9QDdiKDXT51AR1IHK70deMQtHJlD1duRpLYE=;
	b=ZjSyxQDBDQ7csz+EUu3wpLLrykzNrhbtsGSOz5BPgQoU7f/03rXVDLHlQGib5aBLs/BFlG
	tJWCbl5w0Tr+8R3XK3Ru9/U3yMC3Cpf+TWoVd5282WqwYObZGfkKaKj4ff1XIKY9UyQ+MD
	4rH39sDmuXeRBX1TUMx0j/sUykDLpmQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733314606;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2CWmtwh9QDdiKDXT51AR1IHK70deMQtHJlD1duRpLYE=;
	b=aIlOAOVWTTrZcqd6qXfna+SBg86sPLFms81vrFl4t1dn/LRQwTHSbnppZtGOWCe0xaG3Br
	JMlIU7KtFDCcq1Bg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cJFusa5M;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rPvzw9NX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733314605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2CWmtwh9QDdiKDXT51AR1IHK70deMQtHJlD1duRpLYE=;
	b=cJFusa5MUae0u0qtKl+UX6I0S4h9YSj8y0lTVZMzBog0t4pFf/wiNH8CocVYRcwShy62zo
	7POEqbXKzq/YJ0xNAl4Oq/QFmh2mOhJixcNYg1utnSB+NnEvWkGZsVguEKL8fMKhjxUkAj
	dXPdagVFRl6tlfW3DkZTV8BATv+t23s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733314605;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2CWmtwh9QDdiKDXT51AR1IHK70deMQtHJlD1duRpLYE=;
	b=rPvzw9NXSqIB6FCpMrwtPhhDPzUmGUVkOYf6BjdCfennjDD9cNecD35x2Nhvp6ayTlZS9j
	HQih+LF7ZsMsO+Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 45F391396E;
	Wed,  4 Dec 2024 12:16:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zezGEC1IUGcEIwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Dec 2024 12:16:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E90E6A0918; Wed,  4 Dec 2024 13:16:44 +0100 (CET)
Date: Wed, 4 Dec 2024 13:16:44 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	hch@infradead.org, djwong@kernel.org, david@fromorbit.com,
	zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 11/27] ext4: use reserved metadata blocks when splitting
 extent on endio
Message-ID: <20241204121644.gmflmc4u3u34vltt@quack3>
References: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
 <20241022111059.2566137-12-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022111059.2566137-12-yi.zhang@huaweicloud.com>
X-Rspamd-Queue-Id: 5798F21162
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
	RCPT_COUNT_TWELVE(0.00)[16];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,infradead.org,kernel.org,fromorbit.com,google.com,huawei.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

On Tue 22-10-24 19:10:42, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> When performing buffered writes, we may need to split and convert an
> unwritten extent into a written one during the end I/O process. However,
> we do not reserve space specifically for these metadata changes, we only
> reserve 2% of space or 4096 blocks. To address this, we use
> EXT4_GET_BLOCKS_PRE_IO to potentially split extents in advance and
> EXT4_GET_BLOCKS_METADATA_NOFAIL to utilize reserved space if necessary.
> 
> These two approaches can reduce the likelihood of running out of space
> and losing data. However, these methods are merely best efforts, we
> could still run out of space, and there is not much difference between
> converting an extent during the writeback process and the end I/O
> process, it won't increase the rick of losing data if we postpone the
> conversion.
> 
> Therefore, also use EXT4_GET_BLOCKS_METADATA_NOFAIL in
> ext4_convert_unwritten_extents_endio() to prepare for the buffered I/O
> iomap conversion, which may perform extent conversion during the end I/O
> process.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Yeah, I agree. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index d5067d5aa449..33bc2cc5aff4 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3767,6 +3767,8 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
>  	 * illegal.
>  	 */
>  	if (ee_block != map->m_lblk || ee_len > map->m_len) {
> +		int flags = EXT4_GET_BLOCKS_CONVERT |
> +			    EXT4_GET_BLOCKS_METADATA_NOFAIL;
>  #ifdef CONFIG_EXT4_DEBUG
>  		ext4_warning(inode->i_sb, "Inode (%ld) finished: extent logical block %llu,"
>  			     " len %u; IO logical block %llu, len %u",
> @@ -3774,7 +3776,7 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
>  			     (unsigned long long)map->m_lblk, map->m_len);
>  #endif
>  		path = ext4_split_convert_extents(handle, inode, map, path,
> -						EXT4_GET_BLOCKS_CONVERT, NULL);
> +						  flags, NULL);
>  		if (IS_ERR(path))
>  			return path;
>  
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

