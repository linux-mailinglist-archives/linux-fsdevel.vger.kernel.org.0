Return-Path: <linux-fsdevel+bounces-52326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2107FAE1D2D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 16:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAAFD1BC4A26
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 14:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4333B291891;
	Fri, 20 Jun 2025 14:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cYx1ayUs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hZ3CMdyG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cYx1ayUs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hZ3CMdyG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE1428FAA5
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750429111; cv=none; b=rh4jwWZ3i2iU8NsqULDvJCTLTKqwCqY2i+lHvsMYUZi/jDDJqb6p7aCVw3B2a7UPzrC84hI+TeOvR6jcHCL+Qrs/URgn/jYm9v0VwraVFDVAOl8620rJrpakhezbNfC8foepOPhzP06y4WUvM/nXl8j24kOKvMvW4jDuHSvezYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750429111; c=relaxed/simple;
	bh=GmEF7XtFRaAMmD60L3O3wivlsw6IEUOJIQM94TBoGzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6MFvTmvetuOvZPSehv5WLT3W36+uCxiyQxz2fdFsfzU8CdcWRW/b717y7MrCCmPAOuj0EVljmyfCOSse9NAeQ1tE6ALqsMoVXYaEQNZTj6aio2CfdEmr+bvquaIPhj/XwDFUSh9h0nCfWEv6z/EAcQIT4sHTzE29XX/6z0yeoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cYx1ayUs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hZ3CMdyG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cYx1ayUs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hZ3CMdyG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4B7612122E;
	Fri, 20 Jun 2025 14:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750429108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xrIaBkWkQCmvjsPNtiSTszsjd+CXnshpFyRej0yL6DU=;
	b=cYx1ayUsFCdNhSPC9sTk7egjzcWy083PokC0jwQpyoVlBL+x2rSRByjvbIDtUABkFa68ku
	gogF/zbXyr7Hki1pGfSX5ErKQIhN/fRZqUc/HoyryaeaNXNxG+ExSrywyYU5QcWFxXemYd
	bgfhkAkKBK64C+AV2K99Up2chm2xyb4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750429108;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xrIaBkWkQCmvjsPNtiSTszsjd+CXnshpFyRej0yL6DU=;
	b=hZ3CMdyGaBJGAuowpRgIrvvRtyZ62RKvzjP2V+a6+iwPhj5EAPycQseieFUCt2ePELWjLj
	78JH2+7kt6bw4/DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750429108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xrIaBkWkQCmvjsPNtiSTszsjd+CXnshpFyRej0yL6DU=;
	b=cYx1ayUsFCdNhSPC9sTk7egjzcWy083PokC0jwQpyoVlBL+x2rSRByjvbIDtUABkFa68ku
	gogF/zbXyr7Hki1pGfSX5ErKQIhN/fRZqUc/HoyryaeaNXNxG+ExSrywyYU5QcWFxXemYd
	bgfhkAkKBK64C+AV2K99Up2chm2xyb4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750429108;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xrIaBkWkQCmvjsPNtiSTszsjd+CXnshpFyRej0yL6DU=;
	b=hZ3CMdyGaBJGAuowpRgIrvvRtyZ62RKvzjP2V+a6+iwPhj5EAPycQseieFUCt2ePELWjLj
	78JH2+7kt6bw4/DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 38563136BA;
	Fri, 20 Jun 2025 14:18:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Alx7DbRtVWgmSgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 20 Jun 2025 14:18:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CC62FA08D2; Fri, 20 Jun 2025 16:18:27 +0200 (CEST)
Date: Fri, 20 Jun 2025 16:18:27 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu, 
	adilger.kernel@dilger.ca, ojaswin@linux.ibm.com, yi.zhang@huawei.com, libaokun1@huawei.com, 
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 3/6] ext4: restart handle if credits are insufficient
 during allocating blocks
Message-ID: <hdwxc2rv6vwcqpc33prhhlx4eor47xuuft5utvioxiwtrcsz36@n56ap5fi7uku>
References: <20250611111625.1668035-1-yi.zhang@huaweicloud.com>
 <20250611111625.1668035-4-yi.zhang@huaweicloud.com>
 <7nw5sxwibqmp6zuuanb6eklkxnm5n536fpgzqus6pxts37q2ix@vlpsd2muuj6w>
 <00d60446-f380-4480-b643-2b63669ebccc@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00d60446-f380-4480-b643-2b63669ebccc@huaweicloud.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Fri 20-06-25 13:00:32, Zhang Yi wrote:
> On 2025/6/20 0:33, Jan Kara wrote:
> > On Wed 11-06-25 19:16:22, Zhang Yi wrote:
> >> From: Zhang Yi <yi.zhang@huawei.com>
> >>
> >> After large folios are supported on ext4, writing back a sufficiently
> >> large and discontinuous folio may consume a significant number of
> >> journal credits, placing considerable strain on the journal. For
> >> example, in a 20GB filesystem with 1K block size and 1MB journal size,
> >> writing back a 2MB folio could require thousands of credits in the
> >> worst-case scenario (when each block is discontinuous and distributed
> >> across different block groups), potentially exceeding the journal size.
> >> This issue can also occur in ext4_write_begin() and ext4_page_mkwrite()
> >> when delalloc is not enabled.
> >>
> >> Fix this by ensuring that there are sufficient journal credits before
> >> allocating an extent in mpage_map_one_extent() and _ext4_get_block(). If
> >> there are not enough credits, return -EAGAIN, exit the current mapping
> >> loop, restart a new handle and a new transaction, and allocating blocks
> >> on this folio again in the next iteration.
> >>
> >> Suggested-by: Jan Kara <jack@suse.cz>
> >> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> > 
> > ...
> > 
> >>  static int _ext4_get_block(struct inode *inode, sector_t iblock,
> >>  			   struct buffer_head *bh, int flags)
> >>  {
> >>  	struct ext4_map_blocks map;
> >> +	handle_t *handle = ext4_journal_current_handle();
> >>  	int ret = 0;
> >>  
> >>  	if (ext4_has_inline_data(inode))
> >>  		return -ERANGE;
> >>  
> >> +	/* Make sure transaction has enough credits for this extent */
> >> +	if (flags & EXT4_GET_BLOCKS_CREATE) {
> >> +		ret = ext4_journal_ensure_extent_credits(handle, inode);
> >> +		if (ret)
> >> +			return ret;
> >> +	}
> >> +
> >>  	map.m_lblk = iblock;
> >>  	map.m_len = bh->b_size >> inode->i_blkbits;
> >>  
> >> -	ret = ext4_map_blocks(ext4_journal_current_handle(), inode, &map,
> >> -			      flags);
> >> +	ret = ext4_map_blocks(handle, inode, &map, flags);
> > 
> > Good spotting with ext4_page_mkwrite() and ext4_write_begin() also needing
> > this treatment! But rather then hiding the transaction extension in
> > _ext4_get_block() I'd do this in ext4_block_write_begin() where it is much
> > more obvious (and also it is much more obvious who needs to be prepared for
> > handling EAGAIN error). Otherwise the patch looks good!
> > 
> 
> Yes, I completely agree with you. However, unfortunately, do this in
> ext4_block_write_begin() only works for ext4_write_begin().
> ext4_page_mkwrite() does not call ext4_block_write_begin() to allocate
> blocks, it call the vfs helper __block_write_begin_int() instead.
> 
> vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
> {
> 	...
> 	if (!ext4_should_journal_data(inode)) {
> 		err = block_page_mkwrite(vma, vmf, get_block);
> 	...
> }
> 
> 
> So...

Right, I forgot about the nodelalloc case. But since we do most of things
by hand for data=journal mode, perhaps we could lift some code from
data=journal mode and reuse it for nodelalloc as well like:

        folio_lock(folio);
        size = i_size_read(inode);
        /* Page got truncated from under us? */
        if (folio->mapping != mapping || folio_pos(folio) > size) {
                ret = VM_FAULT_NOPAGE;
                goto out_error;
        }

        len = folio_size(folio);
        if (folio_pos(folio) + len > size)
                len = size - folio_pos(folio);
                
        err = ext4_block_write_begin(handle, folio, 0, len,
                                     get_block);
	if (err)
		goto out_error;
	if (!ext4_should_journal_data(inode))
		block_commit_write(folio, 0, len);
		folio_mark_dirty(folio);
	} else {
	        if (ext4_journal_folio_buffers(handle, folio, len)) {
	        	ret = VM_FAULT_SIGBUS;
		        goto out_error;
		}
	}
	ext4_journal_stop(handle);
	folio_wait_stable(folio);

We get an additional bonus for not waiting for page writeback with
transaction handle held (which is a potential deadlock vector). What do you
think?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

