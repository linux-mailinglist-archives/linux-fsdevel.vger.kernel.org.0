Return-Path: <linux-fsdevel+bounces-24424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E47A93F3AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 13:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDB1B1C21C48
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 11:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EC1145A18;
	Mon, 29 Jul 2024 11:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LoptllnC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jHSCQwt+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LoptllnC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jHSCQwt+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB5A140E29;
	Mon, 29 Jul 2024 11:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722251419; cv=none; b=n0rqc6z8gAv/kTyA3QLDCAZdinFQQQAwGW+LP2n7fNzadKrLM30cJq4DL8JLeeVwxgqKYfQqyqldcdyuvgMmOLHRj052Ik6d90qW9bFNReWsZI6QPNGqcf+0oynj4WlQ1GqrapyMTyHCT/DiEI7MRG7myvsdGAPfenHR6OaR8Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722251419; c=relaxed/simple;
	bh=H9HBVcTJ/O0ln+gb2tNhWGDfQ4K452lzw+IzOrwqY20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ld4ZfAvX1DpxYZm2mlQ4u0BBT0EnXBaYEsjWrIoF/L3HeF11eUJIFdCZBivqYRmq7kaBmwSYNYar5N/J7lwMPMJOdEo6yOVbl/JUSPr1yq8br7zzetE4e6WhgPkFbbKNH9bBzgQKJZ5yAeiYj+V9jsnE0Ouo3TlpogEdRumvx50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LoptllnC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jHSCQwt+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LoptllnC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jHSCQwt+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9ECC81F793;
	Mon, 29 Jul 2024 11:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722251412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0/SfsmJEKCBaxcoXsuzu3RK/5swEgXg2CmacYluDWv8=;
	b=LoptllnCsdEn4dSlybfteASZmGEpIgqLTpobiWQc6cqN2fnIJPZp8+RJeOZ/Olk8ReXLRH
	dQgGFF2/ONtU6PhLRv9Ecwb46XUOlVsnkHkgWgHG5p9tJZ6i82CNC5x0sfoBpVUtkwgTei
	OixhSqmx9RntI8IGxpxA1ISkZYNRK7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722251412;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0/SfsmJEKCBaxcoXsuzu3RK/5swEgXg2CmacYluDWv8=;
	b=jHSCQwt+YiMLY5uOyUHr7Pm9V4GtiKDXCbH1qEP44+OSnfdbQswn45lN+QW+hYsKTwEH+Y
	GAc+mqm2dWFUwvBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LoptllnC;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jHSCQwt+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722251412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0/SfsmJEKCBaxcoXsuzu3RK/5swEgXg2CmacYluDWv8=;
	b=LoptllnCsdEn4dSlybfteASZmGEpIgqLTpobiWQc6cqN2fnIJPZp8+RJeOZ/Olk8ReXLRH
	dQgGFF2/ONtU6PhLRv9Ecwb46XUOlVsnkHkgWgHG5p9tJZ6i82CNC5x0sfoBpVUtkwgTei
	OixhSqmx9RntI8IGxpxA1ISkZYNRK7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722251412;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0/SfsmJEKCBaxcoXsuzu3RK/5swEgXg2CmacYluDWv8=;
	b=jHSCQwt+YiMLY5uOyUHr7Pm9V4GtiKDXCbH1qEP44+OSnfdbQswn45lN+QW+hYsKTwEH+Y
	GAc+mqm2dWFUwvBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8EB671368A;
	Mon, 29 Jul 2024 11:10:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MMPRIpR4p2bzKwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 29 Jul 2024 11:10:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4487BA099C; Mon, 29 Jul 2024 13:10:12 +0200 (CEST)
Date: Mon, 29 Jul 2024 13:10:12 +0200
From: Jan Kara <jack@suse.cz>
To: Haifeng Xu <haifeng.xu@shopee.com>
Cc: jack@suse.cz, axboe@kernel.dk, brauner@kernel.org, tj@kernel.org,
	viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs: don't flush in-flight wb switches for superblocks
 without cgroup writeback
Message-ID: <20240729111012.u5wlfymn3qm4mrk6@quack3>
References: <20240725084232.bj7apjqqowae575c@quack3>
 <20240726030525.180330-1-haifeng.xu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726030525.180330-1-haifeng.xu@shopee.com>
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.81 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.81
X-Rspamd-Queue-Id: 9ECC81F793

On Fri 26-07-24 11:05:25, Haifeng Xu wrote:
> When deactivating any type of superblock, it had to wait for the in-flight
> wb switches to be completed. wb switches are executed in inode_switch_wbs_work_fn()
> which needs to acquire the wb_switch_rwsem and races against sync_inodes_sb().
> If there are too much dirty data in the superblock, the waiting time may increase
> significantly.
> 
> For superblocks without cgroup writeback such as tmpfs, they have nothing to
> do with the wb swithes, so the flushing can be avoided.
> 
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> Suggested-by: Jan Kara <jack@suse.cz>

Looks good! Thanks! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Changes since v1:
> - do the check in cgroup_writeback_umount().
> - check the capabilities of bdi.
> ---
>  fs/fs-writeback.c         | 6 +++++-
>  fs/super.c                | 2 +-
>  include/linux/writeback.h | 4 ++--
>  3 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 92a5b8283528..09facd4356d9 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1140,8 +1140,12 @@ int cgroup_writeback_by_id(u64 bdi_id, int memcg_id,
>   * rare occurrences and synchronize_rcu() can take a while, perform
>   * flushing iff wb switches are in flight.
>   */
> -void cgroup_writeback_umount(void)
> +void cgroup_writeback_umount(struct super_block *sb)
>  {
> +
> +	if (!(sb->s_bdi->capabilities & BDI_CAP_WRITEBACK))
> +		return;
> +
>  	/*
>  	 * SB_ACTIVE should be reliably cleared before checking
>  	 * isw_nr_in_flight, see generic_shutdown_super().
> diff --git a/fs/super.c b/fs/super.c
> index 095ba793e10c..acc16450da0e 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -621,7 +621,7 @@ void generic_shutdown_super(struct super_block *sb)
>  		sync_filesystem(sb);
>  		sb->s_flags &= ~SB_ACTIVE;
>  
> -		cgroup_writeback_umount();
> +		cgroup_writeback_umount(sb);
>  
>  		/* Evict all inodes with zero refcount. */
>  		evict_inodes(sb);
> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> index 112d806ddbe4..d78d3dce4ede 100644
> --- a/include/linux/writeback.h
> +++ b/include/linux/writeback.h
> @@ -217,7 +217,7 @@ void wbc_account_cgroup_owner(struct writeback_control *wbc, struct page *page,
>  			      size_t bytes);
>  int cgroup_writeback_by_id(u64 bdi_id, int memcg_id,
>  			   enum wb_reason reason, struct wb_completion *done);
> -void cgroup_writeback_umount(void);
> +void cgroup_writeback_umount(struct super_block *sb);
>  bool cleanup_offline_cgwb(struct bdi_writeback *wb);
>  
>  /**
> @@ -324,7 +324,7 @@ static inline void wbc_account_cgroup_owner(struct writeback_control *wbc,
>  {
>  }
>  
> -static inline void cgroup_writeback_umount(void)
> +static inline void cgroup_writeback_umount(struct super_block *sb)
>  {
>  }
>  
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

