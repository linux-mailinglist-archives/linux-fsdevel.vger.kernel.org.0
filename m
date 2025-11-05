Return-Path: <linux-fsdevel+bounces-67087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D846DC34FF1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 10:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A9814E4461
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 09:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809A430ACF4;
	Wed,  5 Nov 2025 09:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kI0QejRy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="m415Ww6m";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kI0QejRy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="m415Ww6m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD942F90DB
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 09:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762336780; cv=none; b=QjV/DvFqh5Wev5nDqudKlNJtcdnpWlI1PDxPyR5cjpebcQuxtf52ZDwlf08Lt42kZzuubwXbWCwdRljTroz9f6UZzEy/giafCmWrJLCSBF2f6nGvMahV+1Bcmb1BdEXcQ2/NvNFdiORGVkw5RKUiZlilLJ+IRyHyCXnp7qSz86A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762336780; c=relaxed/simple;
	bh=qNKq8m60y/OwLLO7jRETtlYhLR0ar0wXCsRyTlawI2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=et4/41mkY6ZzcBiz/qE1cqfWQGIPpglyMVJTSt8FGb3Vl4fB1pg6fmGMKOErNjd26mmKGjbNjEX3DIweDwfDUd8aQSM4cFbGLs0J3XP8lLdFKWwMbVxn4/Io17yOgWk55mIZKRTYMjJAFgFx+M2vmM8YdgDaOvm0fOwHqqfYPxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kI0QejRy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=m415Ww6m; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kI0QejRy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=m415Ww6m; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 64B542116F;
	Wed,  5 Nov 2025 09:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762336777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r1Ss//4cSgMvifGeWImkl64oHq4TXjdrB0of3t6e6oo=;
	b=kI0QejRy1xQMo6/OlQcZ/X1tRn0MFaHDbTEU7srbrDJ5m8CqwFoxjrEA5qNMv3kcwW6pyo
	2hIybOCZzJkELbu7gmzmz8KIqaVgzg5vEzTgo+sHldpBWvYhfLit+xb1Fiu6JA6/aqQdaF
	7rPrDUb/RLq64PjxJDTdrGRy9aSO3uA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762336777;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r1Ss//4cSgMvifGeWImkl64oHq4TXjdrB0of3t6e6oo=;
	b=m415Ww6mKZ1x8BvTd7SrZRtqgGp5HzBCazCYjdlSnSWJHQTIki9uPWO6uWwVsZIIvOXEvD
	DjDDVVmycJCtKFAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kI0QejRy;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=m415Ww6m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762336777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r1Ss//4cSgMvifGeWImkl64oHq4TXjdrB0of3t6e6oo=;
	b=kI0QejRy1xQMo6/OlQcZ/X1tRn0MFaHDbTEU7srbrDJ5m8CqwFoxjrEA5qNMv3kcwW6pyo
	2hIybOCZzJkELbu7gmzmz8KIqaVgzg5vEzTgo+sHldpBWvYhfLit+xb1Fiu6JA6/aqQdaF
	7rPrDUb/RLq64PjxJDTdrGRy9aSO3uA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762336777;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r1Ss//4cSgMvifGeWImkl64oHq4TXjdrB0of3t6e6oo=;
	b=m415Ww6mKZ1x8BvTd7SrZRtqgGp5HzBCazCYjdlSnSWJHQTIki9uPWO6uWwVsZIIvOXEvD
	DjDDVVmycJCtKFAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B2EC13699;
	Wed,  5 Nov 2025 09:59:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pnBBFgkgC2l+OgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 05 Nov 2025 09:59:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1C8C8A083B; Wed,  5 Nov 2025 10:59:37 +0100 (CET)
Date: Wed, 5 Nov 2025 10:59:37 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, kernel@pankajraghav.com, 
	mcgrof@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com, 
	libaokun1@huawei.com
Subject: Re: [PATCH 24/25] ext4: add checks for large folio incompatibilities
 when BS > PS
Message-ID: <arj5yptdhk2tptkqu6q2kwbyhh5cx4ncfyz3hfhlfikx57yf4a@nolkehxy2kqs>
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
 <20251025032221.2905818-25-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025032221.2905818-25-libaokun@huaweicloud.com>
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.21 / 50.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_DKIM_ALLOW(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,huaweicloud.com:email,huawei.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 64B542116F
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -0.21

On Sat 25-10-25 11:22:20, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Supporting a block size greater than the page size (BS > PS) requires
> support for large folios. However, several features (e.g., verity, encrypt)
> and mount options (e.g., data=journal) do not yet support large folios.
> 
> To prevent conflicts, this patch adds checks at mount time to prohibit
> these features and options from being used when BS > PS. Since the data
> mode cannot be changed on remount, there is no need to check on remount.
> 
> A new mount flag, EXT4_MF_LARGE_FOLIO, is introduced. This flag is set
> after the checks pass, indicating that the filesystem has no features or
> mount options incompatible with large folios. Subsequent checks can simply
> test for this flag to avoid redundant verifications.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h  |  3 ++-
>  fs/ext4/inode.c | 10 ++++------
>  fs/ext4/super.c | 26 ++++++++++++++++++++++++++
>  3 files changed, 32 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 8223ed29b343..f1163deb0812 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1859,7 +1859,8 @@ static inline int ext4_get_resgid(struct ext4_super_block *es)
>  enum {
>  	EXT4_MF_MNTDIR_SAMPLED,
>  	EXT4_MF_FC_INELIGIBLE,	/* Fast commit ineligible */
> -	EXT4_MF_JOURNAL_DESTROY	/* Journal is in process of destroying */
> +	EXT4_MF_JOURNAL_DESTROY,/* Journal is in process of destroying */
> +	EXT4_MF_LARGE_FOLIO,	/* large folio is support */
>  };
>  
>  static inline void ext4_set_mount_flag(struct super_block *sb, int bit)
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index b3fa29923a1d..04f9380d4211 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5143,14 +5143,12 @@ static bool ext4_should_enable_large_folio(struct inode *inode)
>  {
>  	struct super_block *sb = inode->i_sb;
>  
> -	if (!S_ISREG(inode->i_mode))
> -		return false;
> -	if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA ||
> -	    ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA))
> +	if (!ext4_test_mount_flag(sb, EXT4_MF_LARGE_FOLIO))
>  		return false;
> -	if (ext4_has_feature_verity(sb))
> +
> +	if (!S_ISREG(inode->i_mode))
>  		return false;
> -	if (ext4_has_feature_encrypt(sb))
> +	if (ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA))
>  		return false;
>  
>  	return true;
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 7338c708ea1d..fdc006a973aa 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5034,6 +5034,28 @@ static const char *ext4_has_journal_option(struct super_block *sb)
>  	return NULL;
>  }
>  
> +static int ext4_check_large_folio(struct super_block *sb)
> +{
> +	const char *err_str = NULL;
> +
> +	if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA)
> +		err_str = "data=journal";
> +	else if (ext4_has_feature_verity(sb))
> +		err_str = "verity";
> +	else if (ext4_has_feature_encrypt(sb))
> +		err_str = "encrypt";
> +
> +	if (!err_str) {
> +		ext4_set_mount_flag(sb, EXT4_MF_LARGE_FOLIO);
> +	} else if (sb->s_blocksize > PAGE_SIZE) {
> +		ext4_msg(sb, KERN_ERR, "bs(%lu) > ps(%lu) unsupported for %s",
> +			 sb->s_blocksize, PAGE_SIZE, err_str);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static int ext4_load_super(struct super_block *sb, ext4_fsblk_t *lsb,
>  			   int silent)
>  {
> @@ -5310,6 +5332,10 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  
>  	ext4_apply_options(fc, sb);
>  
> +	err = ext4_check_large_folio(sb);
> +	if (err < 0)
> +		goto failed_mount;
> +
>  	err = ext4_encoding_init(sb, es);
>  	if (err)
>  		goto failed_mount;
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

