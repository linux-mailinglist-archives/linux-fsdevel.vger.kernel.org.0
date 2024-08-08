Return-Path: <linux-fsdevel+bounces-25448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D189094C485
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 20:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 005561C23173
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 18:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1971F159598;
	Thu,  8 Aug 2024 18:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ue5ESW7a";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gq3Fzz64";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="e28Em4JD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HqW7DcPq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5272B1514F8;
	Thu,  8 Aug 2024 18:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723142185; cv=none; b=Cv/E4XQDsZbJo5neRHQCRvoJQurkTn6b2FwxH2c4oClAUBeocr6OMYUwENeIOnK1xcsajruP++PGQ3jyDJ30xzWUdmpgzUx68lFpjR50bt5H8BBDd3W9X4EpA2AKlDkDsyYOdzB58P6CSN3DKDW30vN5asSk8jJMwlMmRQEnsvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723142185; c=relaxed/simple;
	bh=CDAFOFt5DzJaMoWfO/l4Cfza08ShV3O7UQ08LmTdzog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPyJA3qpcI/6jLzoW2WrV8kvDdLpYVZUj/Zfk6unTF4jh/RQv1pCicSie/+W2IIoOQ5Glo90OTw1Mvz648TKCPsd8XX89CWxFuQgyaqNQr0Vlkc88kQxggEpddDixIumfCDNozjps7J6M+nlLVU5lepYs/CqaD07C5CSPbaweTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ue5ESW7a; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gq3Fzz64; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=e28Em4JD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HqW7DcPq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1ECFF1F7A7;
	Thu,  8 Aug 2024 18:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723142181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/JaCNE0SPz0UELsNll2QC/drBtMQPxlZjo7hKdIw8oY=;
	b=Ue5ESW7agT1P5AKmZqH+cGDxC/BueL3Q82ckrM1qLgJIGoQweRg9Ja3EqfKp/YtFLFsnna
	H63vfE//9eV9OU7vSPM4r2vWlOsUDeCxLDZS3D/5GWgujK0Esap3GRhk5Nd8w78kOazB1l
	HHXifFutNohdd1cAoykjKsCx0zgOVnw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723142181;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/JaCNE0SPz0UELsNll2QC/drBtMQPxlZjo7hKdIw8oY=;
	b=Gq3Fzz646CBfudHE1pGYk8S/Yn/nt/ZT/Q2a1UrKq0kzaMqaQnO9/+Q7sFhtEBX+kHNBz6
	dGe7luKEGlylrDCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=e28Em4JD;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=HqW7DcPq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723142180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/JaCNE0SPz0UELsNll2QC/drBtMQPxlZjo7hKdIw8oY=;
	b=e28Em4JDMENPBg2he7R3xPqRU1XYtxFnzsmXJ8mQKf29AsdBSSfHfI9RjklulB6HDjoZim
	CWuyKPXpTW/H5cwdND+HHdQRiUYzDMJt8urNWOqDXT/Dr+n4ZMlluhzvsBWthEGjMi2imM
	uCC1yu2NZLNkBNPP1r4GzZJtP5TlB3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723142180;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/JaCNE0SPz0UELsNll2QC/drBtMQPxlZjo7hKdIw8oY=;
	b=HqW7DcPqKS68JFb/eDrYri+0k6zLt812S/TmsWqJ+CbhByfa/t/wnIfZZHkLUDHp6xU+3P
	4iZvJkWIn0mzxqBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF81C13876;
	Thu,  8 Aug 2024 18:36:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KJAuOiMQtWZdUgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 08 Aug 2024 18:36:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 99826A0851; Thu,  8 Aug 2024 20:36:19 +0200 (CEST)
Date: Thu, 8 Aug 2024 20:36:19 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	tytso@mit.edu, adilger.kernel@dilger.ca, ritesh.list@gmail.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 06/10] ext4: update delalloc data reserve spcae in
 ext4_es_insert_extent()
Message-ID: <20240808183619.vmxttspcs5ngm6g3@quack3>
References: <20240802115120.362902-1-yi.zhang@huaweicloud.com>
 <20240802115120.362902-7-yi.zhang@huaweicloud.com>
 <20240807174108.l2bbbhlnpznztp34@quack3>
 <a23023f6-93cc-584d-c55a-9f8395e360ae@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a23023f6-93cc-584d-c55a-9f8395e360ae@huaweicloud.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	URIBL_BLOCKED(0.00)[suse.cz:dkim,huawei.com:email,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,mit.edu,dilger.ca,gmail.com,huawei.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,huawei.com:email,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 1ECFF1F7A7
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: 0.49

On Thu 08-08-24 19:18:30, Zhang Yi wrote:
> On 2024/8/8 1:41, Jan Kara wrote:
> > On Fri 02-08-24 19:51:16, Zhang Yi wrote:
> >> From: Zhang Yi <yi.zhang@huawei.com>
> >>
> >> Now that we update data reserved space for delalloc after allocating
> >> new blocks in ext4_{ind|ext}_map_blocks(), and if bigalloc feature is
> >> enabled, we also need to query the extents_status tree to calculate the
> >> exact reserved clusters. This is complicated now and it appears that
> >> it's better to do this job in ext4_es_insert_extent(), because
> >> __es_remove_extent() have already count delalloc blocks when removing
> >> delalloc extents and __revise_pending() return new adding pending count,
> >> we could update the reserved blocks easily in ext4_es_insert_extent().
> >>
> >> Thers is one special case needs to concern is the quota claiming, when
> >> bigalloc is enabled, if the delayed cluster allocation has been raced
> >> by another no-delayed allocation(e.g. from fallocate) which doesn't
> >> cover the delayed blocks:
> >>
> >>   |<       one cluster       >|
> >>   hhhhhhhhhhhhhhhhhhhdddddddddd
> >>   ^            ^
> >>   |<          >| < fallocate this range, don't claim quota again
> >>
> >> We can't claim quota as usual because the fallocate has already claimed
> >> it in ext4_mb_new_blocks(), we could notice this case through the
> >> removed delalloc blocks count.
> >>
> >> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> > ...
> >> @@ -926,9 +928,27 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
> >>  			__free_pending(pr);
> >>  			pr = NULL;
> >>  		}
> >> +		pending = err3;
> >>  	}
> >>  error:
> >>  	write_unlock(&EXT4_I(inode)->i_es_lock);
> >> +	/*
> >> +	 * Reduce the reserved cluster count to reflect successful deferred
> >> +	 * allocation of delayed allocated clusters or direct allocation of
> >> +	 * clusters discovered to be delayed allocated.  Once allocated, a
> >> +	 * cluster is not included in the reserved count.
> >> +	 *
> >> +	 * When bigalloc is enabled, allocating non-delayed allocated blocks
> >> +	 * which belong to delayed allocated clusters (from fallocate, filemap,
> >> +	 * DIO, or clusters allocated when delalloc has been disabled by
> >> +	 * ext4_nonda_switch()). Quota has been claimed by ext4_mb_new_blocks(),
> >> +	 * so release the quota reservations made for any previously delayed
> >> +	 * allocated clusters.
> >> +	 */
> >> +	resv_used = rinfo.delonly_cluster + pending;
> >> +	if (resv_used)
> >> +		ext4_da_update_reserve_space(inode, resv_used,
> >> +					     rinfo.delonly_block);
> > 
> > I'm not sure I understand here. We are inserting extent into extent status
> > tree. We are replacing resv_used clusters worth of space with delayed
> > allocation reservation with normally allocated clusters so we need to
> > release the reservation (mballoc already reduced freeclusters counter).
> > That I understand. In normal case we should also claim quota because we are
> > converting from reserved into allocated state. Now if we allocated blocks
> > under this range (e.g. from fallocate()) without
> > EXT4_GET_BLOCKS_DELALLOC_RESERVE, we need to release quota reservation here
> > instead of claiming it. But I fail to see how rinfo.delonly_block > 0 is
> > related to whether EXT4_GET_BLOCKS_DELALLOC_RESERVE was set when allocating
> > blocks for this extent or not.
> 
> Oh, this is really complicated due to the bigalloc feature, please let me
> explain it more clearly by listing all related situations.
> 
> There are 2 types of paths of allocating delayed/reserved cluster:
> 1. Normal case, normally allocate delayed clusters from the write back path.
> 2. Special case, allocate blocks under this delayed range, e.g. from
>    fallocate().
> 
> There are 4 situations below:
> 
> A. bigalloc is disabled. This case is simple, after path 2, we don't need
>    to distinguish path 1 and 2, when calling ext4_es_insert_extent(), we
>    set EXT4_GET_BLOCKS_DELALLOC_RESERVE after EXT4_MAP_DELAYED bit is
>    detected. If the flag is set, we must be replacing a delayed extent and
>    rinfo.delonly_block must be > 0. So rinfo.delonly_block > 0 is equal
>    to set EXT4_GET_BLOCKS_DELALLOC_RESERVE.

Right. So fallocate() will call ext4_map_blocks() and
ext4_es_lookup_extent() will find delayed extent and set EXT4_MAP_DELAYED
which you (due to patch 2 of this series) transform into
EXT4_GET_BLOCKS_DELALLOC_RESERVE. We used to update the delalloc
accounting through in ext4_ext_map_blocks() but this patch moved the update
to ext4_es_insert_extent(). But there is one cornercase even here AFAICT:

Suppose fallocate is called for range 0..16k, we have delalloc extent at
8k..16k. In this case ext4_map_blocks() at block 0 will not find the
delalloc extent but ext4_ext_map_blocks() will allocate 16k from mballoc
without using delalloc reservation but then ext4_es_insert_extent() will
still have rinfo.delonly_block > 0 so we claim the quota reservation
instead of releasing it?

> B. bigalloc is enabled, there a 3 sub-cases of allocating a delayed
>    cluster:
> B0.Allocating a whole delayed cluster, this case is the same to A.
> 
>      |<         one cluster       >|
>      ddddddd+ddddddd+ddddddd+ddddddd
>      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ allocating the whole range

I agree. In this case there's no difference.

 
> B1.Allocating delayed blocks in a reserved cluster, this case is the same
>    to A, too.
> 
>      |<         one cluster       >|
>      hhhhhhh+hhhhhhh+ddddddd+ddddddd
>                              ^^^^^^^
>                              allocating this range

Yes, if the allocation starts within delalloc range, we will have
EXT4_GET_BLOCKS_DELALLOC_RESERVE set and ndelonly_blocks will always be >
0.

> B2.Allocating blocks which doesn't cover the delayed blocks in one reserved
>    cluster,
> 
>      |<         one cluster       >|
>      hhhhhhh+hhhhhhh+hhhhhhh+ddddddd
>      ^^^^^^^
>      fallocating this range
> 
>   This case must from path 2, which means allocating blocks without
>   EXT4_GET_BLOCKS_DELALLOC_RESERVE. In this case, rinfo.delonly_block must
>   be 0 since we are not replacing any delayed extents, so
>   rinfo.delonly_block == 0 means allocate blocks without EXT4_MAP_DELAYED
>   detected, which further means that EXT4_GET_BLOCKS_DELALLOC_RESERVE is
>   not set. So I think we could use rinfo.delonly_block to identify this
>   case.

Well, this is similar to the non-bigalloc case I was asking about above.
Why the allocated unwritten extent cannot extend past the start of delalloc
extent? I didn't find anything that would disallow that...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

