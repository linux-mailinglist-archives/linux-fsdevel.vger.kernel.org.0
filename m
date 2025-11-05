Return-Path: <linux-fsdevel+bounces-67088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D252CC350DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 11:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14E6A18C737F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 10:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F4E2FD68D;
	Wed,  5 Nov 2025 10:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="l0cQXXR6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4e0fPDMY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="l0cQXXR6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4e0fPDMY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1972FE06C
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 10:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762337651; cv=none; b=RsKcVoo5MgxmD8sjcJEJ5rQyLgZZ/jf+asuEKY+OVBpR9D+zzjg5USZMM1ihrcFrFXTaqcoUOmAreq1zt6jYjJVzOjGOigait6eO9VS94YpXTA0LCS5fiQ0EBRKUgczo2h/yN+8zSjufiKS3wMUNN98Ou0feQzLwb1+lh6K+ehQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762337651; c=relaxed/simple;
	bh=ma3NUSKZRaLFgW3cU1K6dPbec62gMsfiSS4Lyfg+le0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2ratNFlMyMR90CS4JcdOHvpk3upN0od48YaPRQHxxk1IbvpJLxWkn6KkRvtMTs5y0uPxnWqjZ5doFzgvX/UDb8Onv6kR1s0sIu4lV1yDUEecnnamfum0+q6ttVFl0l4ZCRJnfFeLoUldaID/IukZgx/WU7cKERPh7s5YTC6HeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=l0cQXXR6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4e0fPDMY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=l0cQXXR6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4e0fPDMY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6A58221194;
	Wed,  5 Nov 2025 10:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762337646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MnRVR2SMvEXU1ELRAdRpW7eZedo4gImxWnnMJ4zuclU=;
	b=l0cQXXR65kwfMnOQuqf4sI31Lioyf3TVNPKTfrgIj4F6XXWGa9fkHS+kgkKS8YiAr9fqDF
	oj3FT/D2jbICKbvHgBx1QW8QqBdsQ8CGPkg36UDKNd6IqnIuzfxTo56tFt5l4W4k1LCKaf
	ObyaP+p8qJEHf2kXWCaTuW9wJsKJxXo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762337646;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MnRVR2SMvEXU1ELRAdRpW7eZedo4gImxWnnMJ4zuclU=;
	b=4e0fPDMYKopYKys+zw4ggx2+K8sISKVGpt9q+xE+8lppJSi8hVuDEhD7QzM9Yti4Qzw/jq
	qCleDpry2UkyKACw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762337646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MnRVR2SMvEXU1ELRAdRpW7eZedo4gImxWnnMJ4zuclU=;
	b=l0cQXXR65kwfMnOQuqf4sI31Lioyf3TVNPKTfrgIj4F6XXWGa9fkHS+kgkKS8YiAr9fqDF
	oj3FT/D2jbICKbvHgBx1QW8QqBdsQ8CGPkg36UDKNd6IqnIuzfxTo56tFt5l4W4k1LCKaf
	ObyaP+p8qJEHf2kXWCaTuW9wJsKJxXo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762337646;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MnRVR2SMvEXU1ELRAdRpW7eZedo4gImxWnnMJ4zuclU=;
	b=4e0fPDMYKopYKys+zw4ggx2+K8sISKVGpt9q+xE+8lppJSi8hVuDEhD7QzM9Yti4Qzw/jq
	qCleDpry2UkyKACw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5DC9013699;
	Wed,  5 Nov 2025 10:14:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6KXwFm4jC2mUSQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 05 Nov 2025 10:14:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0A2C1A28C2; Wed,  5 Nov 2025 11:14:02 +0100 (CET)
Date: Wed, 5 Nov 2025 11:14:01 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, kernel@pankajraghav.com, 
	mcgrof@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com, 
	libaokun1@huawei.com
Subject: Re: [PATCH 25/25] ext4: enable block size larger than page size
Message-ID: <yp4gorgjhh6c3qeopjabmknimeifhnpbz63irrrtjpplatnk4k@ycofoucc4ry3>
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
 <20251025032221.2905818-26-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025032221.2905818-26-libaokun@huaweicloud.com>
X-Spamd-Result: default: False [-0.30 / 50.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:email,imap1.dmz-prg2.suse.org:helo,suse.com:email,huawei.com:email]
X-Spam-Flag: NO
X-Spam-Score: -0.30
X-Spam-Level: 

On Sat 25-10-25 11:22:21, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Since block device (See commit 3c20917120ce ("block/bdev: enable large
> folio support for large logical block sizes")) and page cache (See commit
> ab95d23bab220ef8 ("filemap: allocate mapping_min_order folios in the page
> cache")) has the ability to have a minimum order when allocating folio,
> and ext4 has supported large folio in commit 7ac67301e82f ("ext4: enable
> large folio for regular file"), now add support for block_size > PAGE_SIZE
> in ext4.
> 
> set_blocksize() -> bdev_validate_blocksize() already validates the block
> size, so ext4_load_super() does not need to perform additional checks.
> 
> Here we only need to enable large folio by default when s_min_folio_order
> is greater than 0 and add the FS_LBS bit to fs_flags.
> 
> In addition, mark this feature as experimental.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

...

> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 04f9380d4211..ba6cf05860ae 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5146,6 +5146,9 @@ static bool ext4_should_enable_large_folio(struct inode *inode)
>  	if (!ext4_test_mount_flag(sb, EXT4_MF_LARGE_FOLIO))
>  		return false;
>  
> +	if (EXT4_SB(sb)->s_min_folio_order)
> +		return true;
> +

But now files with data journalling flag enabled will get large folios
possibly significantly greater that blocksize. I don't think there's a
fundamental reason why data journalling doesn't work with large folios, the
only thing that's likely going to break is that credit estimates will go
through the roof if there are too many blocks per folio. But that can be
handled by setting max folio order to be equal to min folio order when
journalling data for the inode.

It is a bit scary to be modifying max folio order in
ext4_change_inode_journal_flag() but I guess less scary than setting new
aops and if we prune the whole page cache before touching the order and
inode flag, we should be safe (famous last words ;).

								Honza

>  	if (!S_ISREG(inode->i_mode))
>  		return false;
>  	if (ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA))
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index fdc006a973aa..4c0bd79bdf68 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5053,6 +5053,9 @@ static int ext4_check_large_folio(struct super_block *sb)
>  		return -EINVAL;
>  	}
>  
> +	if (sb->s_blocksize > PAGE_SIZE)
> +		ext4_msg(sb, KERN_NOTICE, "EXPERIMENTAL bs(%lu) > ps(%lu) enabled.",
> +			 sb->s_blocksize, PAGE_SIZE);
>  	return 0;
>  }
>  
> @@ -7432,7 +7435,8 @@ static struct file_system_type ext4_fs_type = {
>  	.init_fs_context	= ext4_init_fs_context,
>  	.parameters		= ext4_param_specs,
>  	.kill_sb		= ext4_kill_sb,
> -	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME,
> +	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME |
> +				  FS_LBS,
>  };
>  MODULE_ALIAS_FS("ext4");
>  
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

