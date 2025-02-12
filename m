Return-Path: <linux-fsdevel+bounces-41585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 848D7A326EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 14:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAB8B1885EE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 13:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164B220E03C;
	Wed, 12 Feb 2025 13:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xbK3uUYG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WR/LIYt1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xbK3uUYG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WR/LIYt1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6F52066DB;
	Wed, 12 Feb 2025 13:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739366803; cv=none; b=j5Gs5UYawmz5gVa0jpp8suhnvW/DF0loC1uyFcJ9pNN7q3G71H03FGsy70r8rDla68XyUCRrFDYoEAwwczoruVqsZrj0jFgor2aLMjpE0Gy6ANE4ygV2NR4uQ1+hfS93AcRT4QwNfwLROU76wVEK66Njpznfl7UeDIIT18Q6RBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739366803; c=relaxed/simple;
	bh=ZbofgXvmNvRUBkkbrVGqbC7gAe6IQKSxoxA7LYuJHPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9N+XICsUer9FL/yptVq5EcKgPP//IL6ouc4rfTSenwXbWs59Dsqeql4vdkTWwAsThutszh68yc0G9JblnW/ChI6IUG9K9kw9jYSUU7FHUEcvQoJkzQmOicCyg4hxHfpFREUg6RwlhVtfitoqGaFB2d+OFJJJ8KnfZg7LRRgtWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xbK3uUYG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WR/LIYt1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xbK3uUYG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WR/LIYt1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9AA91336D5;
	Wed, 12 Feb 2025 13:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739366799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x6vOJ00kVKwMqCcyI2pHuiwZPjgghnI2PCf03qDeFV0=;
	b=xbK3uUYGZOUr9X4rrBMzd8lvPwueh8Dllk9v6AedZcLgK9pQkuX68ErQDMiYdjc1snWhOT
	I03IdGJ2lBYcXiDjRgbSARqlqqhjFti68N9ubRbtNUT8qBupzJqbBthE/QKr4tgKWozbR5
	cE1BZPwZf10fGLSLUypRd+oIHKhmasU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739366799;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x6vOJ00kVKwMqCcyI2pHuiwZPjgghnI2PCf03qDeFV0=;
	b=WR/LIYt1xWQHov4T+B9gUVGhPEl1VyQTxYaGrcGQI+6ZtNja2R7Hy/a7CmqJy0rLYkT29e
	bq++RYcYx843gYBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xbK3uUYG;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="WR/LIYt1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739366799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x6vOJ00kVKwMqCcyI2pHuiwZPjgghnI2PCf03qDeFV0=;
	b=xbK3uUYGZOUr9X4rrBMzd8lvPwueh8Dllk9v6AedZcLgK9pQkuX68ErQDMiYdjc1snWhOT
	I03IdGJ2lBYcXiDjRgbSARqlqqhjFti68N9ubRbtNUT8qBupzJqbBthE/QKr4tgKWozbR5
	cE1BZPwZf10fGLSLUypRd+oIHKhmasU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739366799;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x6vOJ00kVKwMqCcyI2pHuiwZPjgghnI2PCf03qDeFV0=;
	b=WR/LIYt1xWQHov4T+B9gUVGhPEl1VyQTxYaGrcGQI+6ZtNja2R7Hy/a7CmqJy0rLYkT29e
	bq++RYcYx843gYBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F25B13AEF;
	Wed, 12 Feb 2025 13:26:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gonvIo+hrGeHGwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 12 Feb 2025 13:26:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4E956A095C; Wed, 12 Feb 2025 14:26:35 +0100 (CET)
Date: Wed, 12 Feb 2025 14:26:35 +0100
From: Jan Kara <jack@suse.cz>
To: Qasim Ijaz <qasdev00@gmail.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzbot <syzbot+812641c6c3d7586a1613@syzkaller.appspotmail.com>
Subject: Re: [PATCH] isofs: fix KMSAN uninit-value bug in do_isofs_readdir()
Message-ID: <imwm3w6wa52hy3uqqyeeversty6uptuwo2mm3c5tac7mpdzorp@tws4i2ap6kzk>
References: <20250211195900.42406-1-qasdev00@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211195900.42406-1-qasdev00@gmail.com>
X-Rspamd-Queue-Id: 9AA91336D5
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
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[812641c6c3d7586a1613];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

On Tue 11-02-25 19:59:00, Qasim Ijaz wrote:
> In do_isofs_readdir() when assigning the variable 
> "struct iso_directory_record *de" the b_data field of the buffer_head 
> is accessed and an offset is added to it, the size of b_data is 2048 
> and the offset size is 2047, meaning 
> "de = (struct iso_directory_record *) (bh->b_data + offset);" 
> yields the final byte of the 2048 sized b_data block.
> 
> The first byte of the directory record (de_len) is then read and 
> found to be 31, meaning the directory record size is 31 bytes long. 
> The directory record is defined by the structure:
> 
> 	struct iso_directory_record {
> 		__u8 length;                     // 1 byte 
> 		__u8 ext_attr_length;            // 1 byte 
> 		__u8 extent[8];                  // 8 bytes 
> 		__u8 size[8];                    // 8 bytes 
> 		__u8 date[7];                    // 7 bytes 
> 		__u8 flags;                      // 1 byte 
> 		__u8 file_unit_size;             // 1 byte 
> 		__u8 interleave;                 // 1 byte 
> 		__u8 volume_sequence_number[4];  // 4 bytes
> 		__u8 name_len;                   // 1 byte
> 		char name[];                     // variable size
> 	} __attribute__((packed));
> 
> The fixed portion of this structure occupies 33 bytes. Therefore, a 
> valid directory record must be at least 33 bytes long 
> (even without considering the variable-length name field). 
> Since de_len is only 31, it is insufficient to contain
> the complete fixed header. 
> 
> The code later hits the following sanity check that 
> compares de_len against the sum of de->name_len and 
> sizeof(struct iso_directory_record):
> 
> 	if (de_len < de->name_len[0] + sizeof(struct iso_directory_record)) {
> 		...
> 	}
> 
> Since the fixed portion of the structure is 
> 33 bytes (up to and including name_len member), 
> a valid record should have de_len of at least 33 bytes; 
> here, however, de_len is too short, and the field de->name_len 
> (located at offset 32) is accessed even though it lies beyond 
> the available 31 bytes. 
> 
> This access on the corrupted isofs data triggers a KASAN uninitialized 
> memory warning. The fix would be to first verify that de_len is at least 
> sizeof(struct iso_directory_record) before accessing any 
> fields like de->name_len.
> 
> Reported-by: syzbot <syzbot+812641c6c3d7586a1613@syzkaller.appspotmail.com>
> Tested-by: syzbot <syzbot+812641c6c3d7586a1613@syzkaller.appspotmail.com>
> Closes: https://syzkaller.appspot.com/bug?extid=812641c6c3d7586a1613
> Fixes: 2deb1acc653c ("isofs: fix access to unallocated memory when reading corrupted filesystem")
> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>

Thanks. Added to my tree.

								Honza

> ---
>  fs/isofs/dir.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/isofs/dir.c b/fs/isofs/dir.c
> index eb2f8273e6f1..366ac8b95330 100644
> --- a/fs/isofs/dir.c
> +++ b/fs/isofs/dir.c
> @@ -147,7 +147,8 @@ static int do_isofs_readdir(struct inode *inode, struct file *file,
>  			de = tmpde;
>  		}
>  		/* Basic sanity check, whether name doesn't exceed dir entry */
> -		if (de_len < de->name_len[0] +
> +		if (de_len < sizeof(struct iso_directory_record) ||
> +		    de_len < de->name_len[0] +
>  					sizeof(struct iso_directory_record)) {
>  			printk(KERN_NOTICE "iso9660: Corrupted directory entry"
>  			       " in block %lu of inode %lu\n", block,
> -- 
> 2.39.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

