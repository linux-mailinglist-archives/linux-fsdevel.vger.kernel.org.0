Return-Path: <linux-fsdevel+bounces-67077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD0DC34C8B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 10:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7165534559F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 09:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9F72FD68F;
	Wed,  5 Nov 2025 09:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="n7CKcfUG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1OwZB+RB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="n7CKcfUG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1OwZB+RB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F0D2FA0E9
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 09:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334371; cv=none; b=TtQOyt3ctCfVM30iyYYZrWN0gRNU0d54PZovEBJ8KV8NGKIsgRaR9R2vjdCUw2DidLmYsyau0WBcyBROFhWBeab6C7NpBgKUpAkNOTJF/7gnhXyzMNQl9DimI3mWrXzOAFy+OJwmMWW2zKupn8uvW7VZM+lkqGj5Ah/++PaSGeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334371; c=relaxed/simple;
	bh=sq6aVF0Cbo5IoUk3Ud3H9yMfyidVw7SfILVp4JhdL5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mv4fJn5fzxZyVNDCwKAJoCg3hA8f1G93wHtnOG1e/6JHO1Yka2pu08/2PJ4GL/ZGH91AS5x/AaCO3b9qbMjvkZwlpK/+xdsgCdfCB75VJ+vE3+k0P3ZNxH+M4m2r0xq+CqdEA3wyKnvtRdFacdZO1eZ77ACxcsVoFjZtmkEW300=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=n7CKcfUG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1OwZB+RB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=n7CKcfUG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1OwZB+RB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0AC941F394;
	Wed,  5 Nov 2025 09:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762334368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FMwdMVhHhC8T39Jua7OgonrjFmJ+xRW6Om3Oi/7Ntz0=;
	b=n7CKcfUGsA9pxtR/T6/gyIL9atCSLS4qFmqG0juDkMTcHntgxPyHmPNINv5Vt4kEy6rg+k
	1SFP7Q3BwUoZIS/TNRsjJTOAsPG9FZt99NA1xKyVRPPw+mY8CfgJzhDSCU+Anjwa3Ue+JJ
	jwFELPxZeznF7OPG81qgnuE1ZI0zDhU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762334368;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FMwdMVhHhC8T39Jua7OgonrjFmJ+xRW6Om3Oi/7Ntz0=;
	b=1OwZB+RBx2VqDiKFCkxeh+3Fmfs9jMP5GkHhZsXrYqIco49jEwEKwxJwENpp6AZwJBVuKX
	ZvRw0YSLC0UbpZDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=n7CKcfUG;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1OwZB+RB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762334368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FMwdMVhHhC8T39Jua7OgonrjFmJ+xRW6Om3Oi/7Ntz0=;
	b=n7CKcfUGsA9pxtR/T6/gyIL9atCSLS4qFmqG0juDkMTcHntgxPyHmPNINv5Vt4kEy6rg+k
	1SFP7Q3BwUoZIS/TNRsjJTOAsPG9FZt99NA1xKyVRPPw+mY8CfgJzhDSCU+Anjwa3Ue+JJ
	jwFELPxZeznF7OPG81qgnuE1ZI0zDhU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762334368;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FMwdMVhHhC8T39Jua7OgonrjFmJ+xRW6Om3Oi/7Ntz0=;
	b=1OwZB+RBx2VqDiKFCkxeh+3Fmfs9jMP5GkHhZsXrYqIco49jEwEKwxJwENpp6AZwJBVuKX
	ZvRw0YSLC0UbpZDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E915C132DD;
	Wed,  5 Nov 2025 09:19:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Tu/iOJ8WC2mBEgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 05 Nov 2025 09:19:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B1A86A083B; Wed,  5 Nov 2025 10:19:27 +0100 (CET)
Date: Wed, 5 Nov 2025 10:19:27 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, kernel@pankajraghav.com, 
	mcgrof@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com, 
	libaokun1@huawei.com
Subject: Re: [PATCH 14/25] ext4: prepare buddy cache inode for BS > PS with
 large folios
Message-ID: <6beewixhvz3kfu33gz7silaiceywhuftyuplfnqsusrzwlsq6l@b75fxyfcmrkg>
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
 <20251025032221.2905818-15-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025032221.2905818-15-libaokun@huaweicloud.com>
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
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_ALLOW(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.com:email,huaweicloud.com:email,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 0AC941F394
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -0.21

On Sat 25-10-25 11:22:10, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> We use EXT4_BAD_INO for the buddy cache inode number. This inode is not
> accessed via __ext4_new_inode() or __ext4_iget(), meaning
> ext4_set_inode_mapping_order() is not called to set its folio order range.
> 
> However, future block size greater than page size support requires this
> inode to support large folios, and the buddy cache code already handles
> BS > PS. Therefore, ext4_set_inode_mapping_order() is now explicitly
> called for this specific inode to set its folio order range.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 31f4c7d65eb4..155c43ff2bc2 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3493,6 +3493,8 @@ static int ext4_mb_init_backend(struct super_block *sb)
>  	 * this will avoid confusion if it ever shows up during debugging. */
>  	sbi->s_buddy_cache->i_ino = EXT4_BAD_INO;
>  	EXT4_I(sbi->s_buddy_cache)->i_disksize = 0;
> +	ext4_set_inode_mapping_order(sbi->s_buddy_cache);
> +
>  	for (i = 0; i < ngroups; i++) {
>  		cond_resched();
>  		desc = ext4_get_group_desc(sb, i, NULL);
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

