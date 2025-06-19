Return-Path: <linux-fsdevel+bounces-52252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C104AE0B79
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 18:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C741A1BC277F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 16:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B85E28BA82;
	Thu, 19 Jun 2025 16:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qc2aD+Rk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iYrgsVHt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qc2aD+Rk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iYrgsVHt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F70111712
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jun 2025 16:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750351473; cv=none; b=TUdLDBtWj6+88AQiYLFwBvS2ZjVRvZft+5AJh6TFVtebLLZ0o4ejzQj5r+OVOP5Y/sH7EALnjvFw2bItKusA0UhbD9r6/1JiC98byWSLvxpYGgchakkeX97R2ULFHQws/TL009Q03to88i/g92a/ElHekk6IwbAGwUBsdy80FI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750351473; c=relaxed/simple;
	bh=b/+ikzLp54Gc/0Xc09GVIw86JXBMCy4h4061cXUV7GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZ4B9fxWgHmRK/dk4C+/1Uds/a+QsUbk9ibMc1iDBPvtCN4EiBbSkGJoTko1i31Nr4JhzqLPzPwi51Gd0/DBveruwU066TRHp1glGqzaYCnAOveN6zBZHIxtSzFcpsT9AT1TZrkYODeMCsPv9CBN4qiLwDVMpTL54obpoSU4pTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qc2aD+Rk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iYrgsVHt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qc2aD+Rk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iYrgsVHt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8ED40211E3;
	Thu, 19 Jun 2025 16:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750351469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1N/DpDRogQtGmbHByX+jvX5Z1OyNpESX58Fdy62AS+Q=;
	b=qc2aD+Rkb2PqRaORoyjmyNhxNS75Ye9PVbQDebDjJb62jRi5Y97Z+GJV0ky8C/4yJNPziG
	08GfntvK4he50AzcQjuG3U6hI3ep2ssbkqs1AY48KIg7eo6zrRObRHCARAPPnDuSLb/lih
	x/FMHO/DgRmrdzc43iVsSFbENybe188=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750351469;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1N/DpDRogQtGmbHByX+jvX5Z1OyNpESX58Fdy62AS+Q=;
	b=iYrgsVHtWVTIxCiShTFdv0+Fe18Yck4+nQPXyCKlGSVE1QptSl6CQgIriuyzAP6Qmls1bk
	QWMv31Iw3ia+OIAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qc2aD+Rk;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iYrgsVHt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750351469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1N/DpDRogQtGmbHByX+jvX5Z1OyNpESX58Fdy62AS+Q=;
	b=qc2aD+Rkb2PqRaORoyjmyNhxNS75Ye9PVbQDebDjJb62jRi5Y97Z+GJV0ky8C/4yJNPziG
	08GfntvK4he50AzcQjuG3U6hI3ep2ssbkqs1AY48KIg7eo6zrRObRHCARAPPnDuSLb/lih
	x/FMHO/DgRmrdzc43iVsSFbENybe188=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750351469;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1N/DpDRogQtGmbHByX+jvX5Z1OyNpESX58Fdy62AS+Q=;
	b=iYrgsVHtWVTIxCiShTFdv0+Fe18Yck4+nQPXyCKlGSVE1QptSl6CQgIriuyzAP6Qmls1bk
	QWMv31Iw3ia+OIAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 80C1A13721;
	Thu, 19 Jun 2025 16:44:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U+9qH20+VGh9SQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 19 Jun 2025 16:44:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3DA56A29FA; Thu, 19 Jun 2025 18:44:29 +0200 (CEST)
Date: Thu, 19 Jun 2025 18:44:29 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	ojaswin@linux.ibm.com, yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com, 
	yangerkun@huawei.com
Subject: Re: [PATCH v2 5/6] ext4/jbd2: reintroduce
 jbd2_journal_blocks_per_page()
Message-ID: <ugup3tdvaxgzc6agaidbdh7sdcpzcqvwzsurqkesyhsyta7q7y@h3q6mrc2jcno>
References: <20250611111625.1668035-1-yi.zhang@huaweicloud.com>
 <20250611111625.1668035-6-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611111625.1668035-6-yi.zhang@huaweicloud.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:dkim];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 8ED40211E3
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.01

On Wed 11-06-25 19:16:24, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> This partially reverts commit d6bf294773a4 ("ext4/jbd2: convert
> jbd2_journal_blocks_per_page() to support large folio"). This
> jbd2_journal_blocks_per_folio() will lead to a significant
> overestimation of journal credits. Since we still reserve credits for
> one page and attempt to extend and restart handles during large folio
> writebacks, so we should convert this helper back to
> ext4_journal_blocks_per_page().
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Here I'm not decided. Does it make any particular sense to reserve credits
for one *page* worth of blocks when pages don't have any particular meaning
in our writeback code anymore? We could reserve credits just for one
physical extent and that should be enough. For blocksize == pagesize (most
common configs) this would be actually equivalent. If blocksize < pagesize,
this could force us to do some more writeback retries and thus get somewhat
higher writeback CPU overhead but do we really care for these configs?  It
is well possible I've overlooked something and someone will spot a
performance regression in practical setup with this in which case we'd have
to come up with something more clever but I think it's worth it to start
simple and complicate later.

								Honza

> ---
>  fs/ext4/ext4_jbd2.h  | 7 +++++++
>  fs/ext4/inode.c      | 6 +++---
>  fs/jbd2/journal.c    | 6 ++++++
>  include/linux/jbd2.h | 1 +
>  4 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
> index 63d17c5201b5..c0ee756cb34c 100644
> --- a/fs/ext4/ext4_jbd2.h
> +++ b/fs/ext4/ext4_jbd2.h
> @@ -326,6 +326,13 @@ static inline int ext4_journal_blocks_per_folio(struct inode *inode)
>  	return 0;
>  }
>  
> +static inline int ext4_journal_blocks_per_page(struct inode *inode)
> +{
> +	if (EXT4_JOURNAL(inode) != NULL)
> +		return jbd2_journal_blocks_per_page(inode);
> +	return 0;
> +}
> +
>  static inline int ext4_journal_force_commit(journal_t *journal)
>  {
>  	if (journal)
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 67e37dd546eb..9835145b1b27 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -2556,7 +2556,7 @@ static int mpage_map_and_submit_extent(handle_t *handle,
>   */
>  static int ext4_da_writepages_trans_blocks(struct inode *inode)
>  {
> -	int bpp = ext4_journal_blocks_per_folio(inode);
> +	int bpp = ext4_journal_blocks_per_page(inode);
>  
>  	return ext4_meta_trans_blocks(inode,
>  				MAX_WRITEPAGES_EXTENT_LEN + bpp - 1, bpp);
> @@ -2634,7 +2634,7 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
>  	ext4_lblk_t lblk;
>  	struct buffer_head *head;
>  	handle_t *handle = NULL;
> -	int bpp = ext4_journal_blocks_per_folio(mpd->inode);
> +	int bpp = ext4_journal_blocks_per_page(mpd->inode);
>  
>  	if (mpd->wbc->sync_mode == WB_SYNC_ALL || mpd->wbc->tagged_writepages)
>  		tag = PAGECACHE_TAG_TOWRITE;
> @@ -6255,7 +6255,7 @@ int ext4_meta_trans_blocks(struct inode *inode, int lblocks, int pextents)
>   */
>  int ext4_writepage_trans_blocks(struct inode *inode)
>  {
> -	int bpp = ext4_journal_blocks_per_folio(inode);
> +	int bpp = ext4_journal_blocks_per_page(inode);
>  	int ret;
>  
>  	ret = ext4_meta_trans_blocks(inode, bpp, bpp);
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index d480b94117cd..7fccb425907f 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -84,6 +84,7 @@ EXPORT_SYMBOL(jbd2_journal_start_commit);
>  EXPORT_SYMBOL(jbd2_journal_force_commit_nested);
>  EXPORT_SYMBOL(jbd2_journal_wipe);
>  EXPORT_SYMBOL(jbd2_journal_blocks_per_folio);
> +EXPORT_SYMBOL(jbd2_journal_blocks_per_page);
>  EXPORT_SYMBOL(jbd2_journal_invalidate_folio);
>  EXPORT_SYMBOL(jbd2_journal_try_to_free_buffers);
>  EXPORT_SYMBOL(jbd2_journal_force_commit);
> @@ -2661,6 +2662,11 @@ int jbd2_journal_blocks_per_folio(struct inode *inode)
>  		     inode->i_sb->s_blocksize_bits);
>  }
>  
> +int jbd2_journal_blocks_per_page(struct inode *inode)
> +{
> +	return 1 << (PAGE_SHIFT - inode->i_sb->s_blocksize_bits);
> +}
> +
>  /*
>   * helper functions to deal with 32 or 64bit block numbers.
>   */
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 43b9297fe8a7..f35369c104ba 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1724,6 +1724,7 @@ static inline int tid_geq(tid_t x, tid_t y)
>  }
>  
>  extern int jbd2_journal_blocks_per_folio(struct inode *inode);
> +extern int jbd2_journal_blocks_per_page(struct inode *inode);
>  extern size_t journal_tag_bytes(journal_t *journal);
>  
>  static inline int jbd2_journal_has_csum_v2or3(journal_t *journal)
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

