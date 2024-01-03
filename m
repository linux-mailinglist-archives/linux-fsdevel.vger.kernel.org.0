Return-Path: <linux-fsdevel+bounces-7174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BF4822C2A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 12:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 214C81C21C1D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 11:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A5118E34;
	Wed,  3 Jan 2024 11:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sjLeX7/c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="roknvRwB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sjLeX7/c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="roknvRwB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED1318E26;
	Wed,  3 Jan 2024 11:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 351B71FD0E;
	Wed,  3 Jan 2024 11:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704281496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zr5N457CxuSQpAO79bf9lVzBLVmoTrucIr0gBnuMyug=;
	b=sjLeX7/cxmdBF4Nb112P/W44lTcoBpHT4fzkwOlQ9h9Rp1Vg9byIVZrdc8Xh2URSKxmVT7
	EN4wAtx65r0BWfgvbkx3HLUuLa1cFcH/W8U6GVUSTtH9yqz2jeMJVMMpcHpYkum4aq0c55
	RsGuTLnubgV0JYSHIuLjp420mIrm7Jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704281496;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zr5N457CxuSQpAO79bf9lVzBLVmoTrucIr0gBnuMyug=;
	b=roknvRwBVe+ZLb6r7fU3WJvnJfDRWkxqfu2274UiQRD4TIBtszk4vIhl9EECYrXJEiwWtA
	PV2N0f8/hJ2c9JAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704281496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zr5N457CxuSQpAO79bf9lVzBLVmoTrucIr0gBnuMyug=;
	b=sjLeX7/cxmdBF4Nb112P/W44lTcoBpHT4fzkwOlQ9h9Rp1Vg9byIVZrdc8Xh2URSKxmVT7
	EN4wAtx65r0BWfgvbkx3HLUuLa1cFcH/W8U6GVUSTtH9yqz2jeMJVMMpcHpYkum4aq0c55
	RsGuTLnubgV0JYSHIuLjp420mIrm7Jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704281496;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zr5N457CxuSQpAO79bf9lVzBLVmoTrucIr0gBnuMyug=;
	b=roknvRwBVe+ZLb6r7fU3WJvnJfDRWkxqfu2274UiQRD4TIBtszk4vIhl9EECYrXJEiwWtA
	PV2N0f8/hJ2c9JAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22B5413AA6;
	Wed,  3 Jan 2024 11:31:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /REUCJhFlWVDEwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 03 Jan 2024 11:31:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B9C3FA07EF; Wed,  3 Jan 2024 12:31:31 +0100 (CET)
Date: Wed, 3 Jan 2024 12:31:31 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
	ritesh.list@gmail.com, hch@infradead.org, djwong@kernel.org,
	willy@infradead.org, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, wangkefeng.wang@huawei.com
Subject: Re: [RFC PATCH v2 05/25] ext4: make ext4_map_blocks() distinguish
 delalloc only extent
Message-ID: <20240103113131.z4jhwim7bzynhrlx@quack3>
References: <20240102123918.799062-1-yi.zhang@huaweicloud.com>
 <20240102123918.799062-6-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102123918.799062-6-yi.zhang@huaweicloud.com>
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.31 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,infradead.org,kernel.org,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="sjLeX7/c";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=roknvRwB
X-Spam-Score: -1.31
X-Rspamd-Queue-Id: 351B71FD0E

On Tue 02-01-24 20:38:58, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Add a new map flag EXT4_MAP_DELAYED to indicate the mapping range is a
> delayed allocated only (not unwritten) one, and making
> ext4_map_blocks() can distinguish it, no longer mixing it with holes.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

One small comment below.

> ---
>  fs/ext4/ext4.h    | 4 +++-
>  fs/ext4/extents.c | 5 +++--
>  fs/ext4/inode.c   | 2 ++
>  3 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index a5d784872303..55195909d32f 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -252,8 +252,10 @@ struct ext4_allocation_request {
>  #define EXT4_MAP_MAPPED		BIT(BH_Mapped)
>  #define EXT4_MAP_UNWRITTEN	BIT(BH_Unwritten)
>  #define EXT4_MAP_BOUNDARY	BIT(BH_Boundary)
> +#define EXT4_MAP_DELAYED	BIT(BH_Delay)
>  #define EXT4_MAP_FLAGS		(EXT4_MAP_NEW | EXT4_MAP_MAPPED |\
> -				 EXT4_MAP_UNWRITTEN | EXT4_MAP_BOUNDARY)
> +				 EXT4_MAP_UNWRITTEN | EXT4_MAP_BOUNDARY |\
> +				 EXT4_MAP_DELAYED)
>  
>  struct ext4_map_blocks {
>  	ext4_fsblk_t m_pblk;
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 0892d0568013..fc69f13cf510 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4073,9 +4073,10 @@ static void ext4_ext_determine_hole(struct inode *inode,
>  	} else if (in_range(map->m_lblk, es.es_lblk, es.es_len)) {
>  		/*
>  		 * Straddle the beginning of the queried range, it's no
> -		 * longer a hole, adjust the length to the delayed extent's
> -		 * after map->m_lblk.
> +		 * longer a hole, mark it is a delalloc and adjust the
> +		 * length to the delayed extent's after map->m_lblk.
>  		 */
> +		map->m_flags |= EXT4_MAP_DELAYED;

I wouldn't set delalloc bit here. If there's delalloc extent containing
lblk now, it means the caller of ext4_map_blocks() is not holding i_rwsem
(otherwise we would have found already in ext4_map_blocks()) and thus
delalloc info is unreliable anyway. So I wouldn't bother. But it's worth a
comment here like:

		/*
		 * There's delalloc extent containing lblk. It must have
		 * been added after ext4_map_blocks() checked the extent
		 * status tree so we are not holding i_rwsem and delalloc
		 * info is only stabilized by i_data_sem we are going to
		 * release soon. Don't modify the extent status tree and
		 * report extent as a hole.
		 */

								Honza

>  		len = es.es_lblk + es.es_len - map->m_lblk;
>  		goto out;
>  	} else {
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 1b5e6409f958..c141bf6d8db2 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -515,6 +515,8 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>  			map->m_len = retval;
>  		} else if (ext4_es_is_delayed(&es) || ext4_es_is_hole(&es)) {
>  			map->m_pblk = 0;
> +			map->m_flags |= ext4_es_is_delayed(&es) ?
> +					EXT4_MAP_DELAYED : 0;
>  			retval = es.es_len - (map->m_lblk - es.es_lblk);
>  			if (retval > map->m_len)
>  				retval = map->m_len;
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

