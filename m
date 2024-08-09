Return-Path: <linux-fsdevel+bounces-25546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3221A94D47A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 18:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7E7D1F217DA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 16:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C9F1991CA;
	Fri,  9 Aug 2024 16:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L4gBGvlF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wRwRuPLe";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L4gBGvlF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wRwRuPLe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373761990DE;
	Fri,  9 Aug 2024 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723220418; cv=none; b=F87CH9Am2ZyEUq+QPiLq3DVtzJCLhuUoG4pLc7rE87EvS4nftn6z5kpLejpYbN6PN4POI8ZmfIVnS+7aCs3jVmcn0ZKKgZ2cFIyolJwAZfzfx8QOVgNbpy4qTqG5hpbIKNoBCp0MErDbH7AkkjZcv+1Jd8q3zt/rVlL+mCf03wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723220418; c=relaxed/simple;
	bh=yZaiFbp/BGYhOatReN+abAtfZEaHS43dHoaBRz5xxKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDfLuXPouL4RZmba7EeJ2GDSqEcch0wct7+Un8gsp+a5+He3SiRo0b5zfDMdSQMDBEkHFlBq66kvBAB5dxKlVHnO5rCxKlNoaMR+Fiew3XEJrTRPtLmkrXBA7eMt7YQu2VlBYYNgfw+nah+aHII9EIrD2PcmYCp2HHtATk1Q97c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L4gBGvlF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wRwRuPLe; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L4gBGvlF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wRwRuPLe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 318E11F7F6;
	Fri,  9 Aug 2024 16:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723220414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oN0VY5gulIc1EHn3LcstMCeAw0A23iCam/gCOtjuplI=;
	b=L4gBGvlFVcSb7gA8VF2pbJVbKsQEnlPxJLfuHUqO/rVmcpY3zy+vC+5T+VSgthq8fLc0IB
	FKtY24YsUVz3etKGsEMcxF1tHLZroII1SFGx+Vg1PPiSrOgUSsDA6k61nrCbd+Z/pMvebm
	KGBJ+ciCyaqk+Cr7KZPZ153gEZ1i7f4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723220414;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oN0VY5gulIc1EHn3LcstMCeAw0A23iCam/gCOtjuplI=;
	b=wRwRuPLeCZK2BjFuUoUX3Q6f4hn/EZyAC9dBT5uq1FoYPBrRfw1kAZXtMDl2xK3KpTHLGs
	Skn4dtwPYCe+xTDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723220414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oN0VY5gulIc1EHn3LcstMCeAw0A23iCam/gCOtjuplI=;
	b=L4gBGvlFVcSb7gA8VF2pbJVbKsQEnlPxJLfuHUqO/rVmcpY3zy+vC+5T+VSgthq8fLc0IB
	FKtY24YsUVz3etKGsEMcxF1tHLZroII1SFGx+Vg1PPiSrOgUSsDA6k61nrCbd+Z/pMvebm
	KGBJ+ciCyaqk+Cr7KZPZ153gEZ1i7f4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723220414;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oN0VY5gulIc1EHn3LcstMCeAw0A23iCam/gCOtjuplI=;
	b=wRwRuPLeCZK2BjFuUoUX3Q6f4hn/EZyAC9dBT5uq1FoYPBrRfw1kAZXtMDl2xK3KpTHLGs
	Skn4dtwPYCe+xTDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1BC3713A7D;
	Fri,  9 Aug 2024 16:20:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PxK/Br5BtmYnMwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 09 Aug 2024 16:20:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B1226A084B; Fri,  9 Aug 2024 18:20:13 +0200 (CEST)
Date: Fri, 9 Aug 2024 18:20:13 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	tytso@mit.edu, adilger.kernel@dilger.ca, ritesh.list@gmail.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 06/10] ext4: update delalloc data reserve spcae in
 ext4_es_insert_extent()
Message-ID: <20240809162013.tieom26umwqcsfe4@quack3>
References: <20240802115120.362902-1-yi.zhang@huaweicloud.com>
 <20240802115120.362902-7-yi.zhang@huaweicloud.com>
 <20240807174108.l2bbbhlnpznztp34@quack3>
 <a23023f6-93cc-584d-c55a-9f8395e360ae@huaweicloud.com>
 <20240808183619.vmxttspcs5ngm6g3@quack3>
 <d6b8ed3c-82a7-6344-bdb9-8c18b1f526ca@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6b8ed3c-82a7-6344-bdb9-8c18b1f526ca@huaweicloud.com>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,mit.edu,dilger.ca,gmail.com,huawei.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 09-08-24 11:35:49, Zhang Yi wrote:
> On 2024/8/9 2:36, Jan Kara wrote:
> > On Thu 08-08-24 19:18:30, Zhang Yi wrote:
> >> On 2024/8/8 1:41, Jan Kara wrote:
> >>> On Fri 02-08-24 19:51:16, Zhang Yi wrote:
> >>>> From: Zhang Yi <yi.zhang@huawei.com>
> >>>>
> >>>> Now that we update data reserved space for delalloc after allocating
> >>>> new blocks in ext4_{ind|ext}_map_blocks(), and if bigalloc feature is
> >>>> enabled, we also need to query the extents_status tree to calculate the
> >>>> exact reserved clusters. This is complicated now and it appears that
> >>>> it's better to do this job in ext4_es_insert_extent(), because
> >>>> __es_remove_extent() have already count delalloc blocks when removing
> >>>> delalloc extents and __revise_pending() return new adding pending count,
> >>>> we could update the reserved blocks easily in ext4_es_insert_extent().
> >>>>
> >>>> Thers is one special case needs to concern is the quota claiming, when
> >>>> bigalloc is enabled, if the delayed cluster allocation has been raced
> >>>> by another no-delayed allocation(e.g. from fallocate) which doesn't
> >>>> cover the delayed blocks:
> >>>>
> >>>>   |<       one cluster       >|
> >>>>   hhhhhhhhhhhhhhhhhhhdddddddddd
> >>>>   ^            ^
> >>>>   |<          >| < fallocate this range, don't claim quota again
> >>>>
> >>>> We can't claim quota as usual because the fallocate has already claimed
> >>>> it in ext4_mb_new_blocks(), we could notice this case through the
> >>>> removed delalloc blocks count.
> >>>>
> >>>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> >>> ...
> >>>> @@ -926,9 +928,27 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
> >>>>  			__free_pending(pr);
> >>>>  			pr = NULL;
> >>>>  		}
> >>>> +		pending = err3;
> >>>>  	}
> >>>>  error:
> >>>>  	write_unlock(&EXT4_I(inode)->i_es_lock);
> >>>> +	/*
> >>>> +	 * Reduce the reserved cluster count to reflect successful deferred
> >>>> +	 * allocation of delayed allocated clusters or direct allocation of
> >>>> +	 * clusters discovered to be delayed allocated.  Once allocated, a
> >>>> +	 * cluster is not included in the reserved count.
> >>>> +	 *
> >>>> +	 * When bigalloc is enabled, allocating non-delayed allocated blocks
> >>>> +	 * which belong to delayed allocated clusters (from fallocate, filemap,
> >>>> +	 * DIO, or clusters allocated when delalloc has been disabled by
> >>>> +	 * ext4_nonda_switch()). Quota has been claimed by ext4_mb_new_blocks(),
> >>>> +	 * so release the quota reservations made for any previously delayed
> >>>> +	 * allocated clusters.
> >>>> +	 */
> >>>> +	resv_used = rinfo.delonly_cluster + pending;
> >>>> +	if (resv_used)
> >>>> +		ext4_da_update_reserve_space(inode, resv_used,
> >>>> +					     rinfo.delonly_block);
> >>>
> >>> I'm not sure I understand here. We are inserting extent into extent status
> >>> tree. We are replacing resv_used clusters worth of space with delayed
> >>> allocation reservation with normally allocated clusters so we need to
> >>> release the reservation (mballoc already reduced freeclusters counter).
> >>> That I understand. In normal case we should also claim quota because we are
> >>> converting from reserved into allocated state. Now if we allocated blocks
> >>> under this range (e.g. from fallocate()) without
> >>> EXT4_GET_BLOCKS_DELALLOC_RESERVE, we need to release quota reservation here
> >>> instead of claiming it. But I fail to see how rinfo.delonly_block > 0 is
> >>> related to whether EXT4_GET_BLOCKS_DELALLOC_RESERVE was set when allocating
> >>> blocks for this extent or not.
> >>
> >> Oh, this is really complicated due to the bigalloc feature, please let me
> >> explain it more clearly by listing all related situations.
> >>
> >> There are 2 types of paths of allocating delayed/reserved cluster:
> >> 1. Normal case, normally allocate delayed clusters from the write back path.
> >> 2. Special case, allocate blocks under this delayed range, e.g. from
> >>    fallocate().
> >>
> >> There are 4 situations below:
> >>
> >> A. bigalloc is disabled. This case is simple, after path 2, we don't need
> >>    to distinguish path 1 and 2, when calling ext4_es_insert_extent(), we
> >>    set EXT4_GET_BLOCKS_DELALLOC_RESERVE after EXT4_MAP_DELAYED bit is
> >>    detected. If the flag is set, we must be replacing a delayed extent and
> >>    rinfo.delonly_block must be > 0. So rinfo.delonly_block > 0 is equal
> >>    to set EXT4_GET_BLOCKS_DELALLOC_RESERVE.
> > 
> > Right. So fallocate() will call ext4_map_blocks() and
> > ext4_es_lookup_extent() will find delayed extent and set EXT4_MAP_DELAYED
> > which you (due to patch 2 of this series) transform into
> > EXT4_GET_BLOCKS_DELALLOC_RESERVE. We used to update the delalloc
> > accounting through in ext4_ext_map_blocks() but this patch moved the update
> > to ext4_es_insert_extent(). But there is one cornercase even here AFAICT:
> > 
> > Suppose fallocate is called for range 0..16k, we have delalloc extent at
> > 8k..16k. In this case ext4_map_blocks() at block 0 will not find the
> > delalloc extent but ext4_ext_map_blocks() will allocate 16k from mballoc
> > without using delalloc reservation but then ext4_es_insert_extent() will
> > still have rinfo.delonly_block > 0 so we claim the quota reservation
> > instead of releasing it?
> > 
> 
> After commit 6430dea07e85 ("ext4: correct the hole length returned by
> ext4_map_blocks()"), the fallocate range 0-16K would be divided into two
> rounds. When we first calling ext4_map_blocks() with 0-16K, the map range
> will be corrected to 0-8k by ext4_ext_determine_insert_hole() and the
> allocating range should not cover any delayed range.

Eww, subtle, subtle, subtle... And isn't this also racy? We drop i_data_sem
in ext4_map_blocks() after we do the initial lookup. So there can be some
changes to both the extent tree and extent status tree before we grab
i_data_sem again for the allocation. We hold inode_lock so there can be
only writeback and page faults racing with us but e.g. ext4_page_mkwrite()
-> block_page_mkwrite -> ext4_da_get_block_prep() -> ext4_da_map_blocks()
can add delayed extent into extent status tree in that window causing
breakage, can't it?

> Then
> ext4_alloc_file_blocks() will call ext4_map_blocks() again to allocate
> 8K-16K in the second round, in this round, we are allocating a real
> delayed range. Please below graph for details,
> 
> ext4_alloc_file_blocks() //0-16K
>  ext4_map_blocks()  //0-16K
>   ext4_es_lookup_extent() //find nothing
>    ext4_ext_map_blocks(0)
>     ext4_ext_determine_insert_hole() //change map range to 0-8K
>    ext4_ext_map_blocks(EXT4_GET_BLOCKS_CREATE) //allocate blocks under hole
>  ext4_map_blocks()  //8-16K
>   ext4_es_lookup_extent() //find delayed extent
>   ext4_ext_map_blocks(EXT4_GET_BLOCKS_CREATE)
>     //allocate blocks under a whole delayed range,
>     //use rinfo.delonly_block > 0 is okay
> 
> Hence the allocating range can't mixed with delayed and non-delayed extent
> at a time, and the rinfo.delonly_block > 0 should work.

Besides the race above I agree. So either we need to trim mapping extent in
ext4_map_blocks() after re-acquiring i_data_sem or we need to deal with
unwritten extents that are partially delalloc. I'm more and more leaning
towards just passing the information whether delalloc was used or not to
extent status tree insertion. Because that can deal with partial extents
just fine...

Thanks for your patience with me :).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

