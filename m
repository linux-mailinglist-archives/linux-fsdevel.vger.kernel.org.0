Return-Path: <linux-fsdevel+bounces-36929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AD39EB15A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 13:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9255616AFA1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 12:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2131A9B21;
	Tue, 10 Dec 2024 12:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2QVtu7hV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4nu0I9RD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2QVtu7hV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4nu0I9RD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E1178F44;
	Tue, 10 Dec 2024 12:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733835451; cv=none; b=Vj/XZQ6SjP47F186PcNOW/NoCdo9KHI4A7GQKM5GCBNfI2y0Daesv29wZVLxg99T1agM2LPArR3rV//5AyPSbF+HtOuK/zS/5rtHE3BXn2K6+IxxeMyl7ysgmfxWEGLVR/7DcD7l03INdEKa/VF+BPE7qzmmbDIIPDrBHD+Pqws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733835451; c=relaxed/simple;
	bh=ocwfZQ5ezf0xmQIgzqU7lqN4U6UtASJKJd95I+DSHXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lG4HHorBzTKMr6sdDQkj1Lp0YywPe9C4b23aIcdvVOcZ6U7f9cZTHYJyLTzYa4Xn1BqzuH+raCVk1niO3WlxP/d3SoWxgUvBvCeMiC9HD+WosvcWGpfTFoBKWb2XeXl6FITDpjDtH3kGOqpCWbewaUAmIXNiXZj4EhmHNfTr7Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2QVtu7hV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4nu0I9RD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2QVtu7hV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4nu0I9RD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1892421119;
	Tue, 10 Dec 2024 12:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733835447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mnal0SBhkd6JU8ilF9O1Ssfq+H0ZBcS4AqNzGmDWo6o=;
	b=2QVtu7hVJj+3f66YnAp8D4UMGUE4Y0vMnY/78+0dIWenTbn/mL6UndwPUyLl+VkCRnuNdS
	4tTjQTn5gO3eJ/QA9KV1zeKFCQBApbL3+tdQP+MtISgE2JHuH1bn0lIST8hd4QhMCLfxK6
	h7wy5iQV4NuiI9ROr0IFgDFw/89W9ms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733835447;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mnal0SBhkd6JU8ilF9O1Ssfq+H0ZBcS4AqNzGmDWo6o=;
	b=4nu0I9RDvnW8eEA+9h+vWO4uhHGi6ha1uzeTjuu0ibUhvYw+U+FOX9ySNNRj2JcjnQ/S3z
	lL+68LGx9firXYAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733835447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mnal0SBhkd6JU8ilF9O1Ssfq+H0ZBcS4AqNzGmDWo6o=;
	b=2QVtu7hVJj+3f66YnAp8D4UMGUE4Y0vMnY/78+0dIWenTbn/mL6UndwPUyLl+VkCRnuNdS
	4tTjQTn5gO3eJ/QA9KV1zeKFCQBApbL3+tdQP+MtISgE2JHuH1bn0lIST8hd4QhMCLfxK6
	h7wy5iQV4NuiI9ROr0IFgDFw/89W9ms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733835447;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mnal0SBhkd6JU8ilF9O1Ssfq+H0ZBcS4AqNzGmDWo6o=;
	b=4nu0I9RDvnW8eEA+9h+vWO4uhHGi6ha1uzeTjuu0ibUhvYw+U+FOX9ySNNRj2JcjnQ/S3z
	lL+68LGx9firXYAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A587138D2;
	Tue, 10 Dec 2024 12:57:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rGR+Arc6WGctdgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 10 Dec 2024 12:57:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A701CA0B0D; Tue, 10 Dec 2024 13:57:26 +0100 (CET)
Date: Tue, 10 Dec 2024 13:57:26 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	tytso@mit.edu, adilger.kernel@dilger.ca, ritesh.list@gmail.com,
	hch@infradead.org, djwong@kernel.org, david@fromorbit.com,
	zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 12/27] ext4: introduce seq counter for the extent status
 entry
Message-ID: <20241210125726.gzcx6mpuecifqdwe@quack3>
References: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
 <20241022111059.2566137-13-yi.zhang@huaweicloud.com>
 <20241204124221.aix7qxjl2n4ya3b7@quack3>
 <c831732e-38c5-4a82-ab30-de17cff29584@huaweicloud.com>
 <20241206162102.w4hw35ims5sdf4ik@quack3>
 <5049c794-9a92-462c-a455-2bdf94cdebef@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5049c794-9a92-462c-a455-2bdf94cdebef@huaweicloud.com>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,mit.edu,dilger.ca,gmail.com,infradead.org,kernel.org,fromorbit.com,google.com,huawei.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 09-12-24 16:32:41, Zhang Yi wrote:
> On 2024/12/7 0:21, Jan Kara wrote:
> >>> I think you'll need to use atomic_t and appropriate functions here.
> >>>
> >>>> @@ -872,6 +879,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
> >>>>  	BUG_ON(end < lblk);
> >>>>  	WARN_ON_ONCE(status & EXTENT_STATUS_DELAYED);
> >>>>  
> >>>> +	ext4_es_inc_seq(inode);
> >>>
> >>> I'm somewhat wondering: Are extent status tree modifications the right
> >>> place to advance the sequence counter? The counter needs to advance
> >>> whenever the mapping information changes. This means that we'd be
> >>> needlessly advancing the counter (and thus possibly forcing retries) when
> >>> we are just adding new information from ordinary extent tree into cache.
> >>> Also someone can be doing extent tree manipulations without touching extent
> >>> status tree (if the information was already pruned from there). 
> >>
> >> Sorry, I don't quite understand here. IIUC, we can't modify the extent
> >> tree without also touching extent status tree; otherwise, the extent
> >> status tree will become stale, potentially leading to undesirable and
> >> unexpected outcomes later on, as the extent lookup paths rely on and
> >> always trust the status tree. If this situation happens, would it be
> >> considered a bug? Additionally, I have checked the code but didn't find
> >> any concrete cases where this could happen. Was I overlooked something?
> > 
> > What I'm worried about is that this seems a bit fragile because e.g. in
> > ext4_collapse_range() we do:
> > 
> > ext4_es_remove_extent(inode, start, EXT_MAX_BLOCKS - start)
> > <now go and manipulate the extent tree>
> > 
> > So if somebody managed to sneak in between ext4_es_remove_extent() and
> > the extent tree manipulation, he could get a block mapping which is shortly
> > after invalidated by the extent tree changes. And as I'm checking now,
> > writeback code *can* sneak in there because during extent tree
> > manipulations we call ext4_datasem_ensure_credits() which can drop
> > i_data_sem to restart a transaction.
> > 
> > Now we do writeout & invalidate page cache before we start to do these
> > extent tree dances so I don't see how this could lead to *actual* use
> > after free issues but it makes me somewhat nervous. So that's why I'd like
> > to have some clear rules from which it is obvious that the counter makes
> > sure we do not use stale mappings.
> 
> Yes, I see. I think the rule should be as follows:
> 
> First, when the iomap infrastructure is creating or querying file
> mapping information, we must ensure that the mapping information
> always passes through the extent status tree, which means
> ext4_map_blocks(), ext4_map_query_blocks(), and
> ext4_map_create_blocks() should cache the extent status entries that
> we intend to use.

OK, this currently holds. There's just one snag that during fastcommit
replay ext4_es_insert_extent() doesn't do anything. I don't think there's
any race possible during that stage but it's another case to think about.

> Second, when updating the extent tree, we must hold the i_data_sem in
> write mode and update the extent status tree atomically.

Fine.

> Additionally,
> if we cannot update the extent tree while holding a single i_data_sem,
> we should first remove all related extent status entries within the
> specified range, then manipulate the extent tree, ensuring that the
> extent status entries are always up-to-date if they exist (as
> ext4_collapse_range() does).

In this case, I think we need to provide more details. In particular I
would require that in all such cases we must:
a) hold i_rwsem exclusively and hold invalidate_lock exclusively ->
   provides exclusion against page faults, reads, writes
b) evict all page cache in the affected range -> should stop writeback -
   *but* currently there's one case which could be problematic. Assume we
   do punch hole 0..N and the page at N+1 is dirty. Punch hole does all of
   the above and starts removing blocks, needs to restart transaction so it
   drops i_data_sem. Writeback starts for page N+1, needs to load extent
   block into memory, ext4_cache_extents() now loads back some extents
   covering range 0..N into extent status tree. So the only protection
   against using freed blocks is that nobody should be mapping anything in
   the range 0..N because we hold those locks & have evicted page cache.

So I think we need to also document, that anybody mapping blocks needs to
hold i_rwsem or invalidate_lock or a page lock, ideally asserting that in
ext4_map_blocks() to catch cases we missed. Asserting for page lock will
not be really doable but luckily only page writeback needs that so that can
get some extemption from the assert.

> Finally, if we want to manipulate the extent tree without caching, we
> should also remove the extent status entries first.

Based on the above, I don't think this is really needed. We only must make
sure that after all extent tree updates are done and before we release
invalidate_lock, all extents from extent status tree in the modified range
must be evicted / replaced to match reality.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

