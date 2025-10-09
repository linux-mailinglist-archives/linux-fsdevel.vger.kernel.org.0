Return-Path: <linux-fsdevel+bounces-63649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDA3BC83D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 11:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB16C3B97C2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 09:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321012D5C9E;
	Thu,  9 Oct 2025 09:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ibZuG9av";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vVxAFBh3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ibZuG9av";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vVxAFBh3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FAD23536C
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Oct 2025 09:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760001295; cv=none; b=a7ZlIXlgC5npNKGJD7ayMdARuitzVzpK78lFO0vl+0rBfl7j1SLeVhCxRcu5lUPmnOboPOYwXP8LXUIqepMC8mXNo6sBxhlsifgX5JFL+25BKklyyNE2SyqwE1nKwB2bpuWaXttBjy6hnTLZA/8SYJHcOwH6MWq1LkK8ZPBXWew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760001295; c=relaxed/simple;
	bh=lwze01EGQqh0w8i67xHjUAt3irzTPZKcurk8S+nlUrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUoe44aAkx6UQnshiqYwXlxvSi0VBcg1WTPb+f2oLcer8xrKjF7lCstcb/AHwjlBLyNhoubcIUf7CBn9XiRFI5PYiYmGn/TiXDIYOjnDoJ55yqHCMY8kwBo7mHvz36Hpi5zPKXtjVk68zpZ2l4ZCGFbVH0f0q2HOpNCGUuNwh+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ibZuG9av; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vVxAFBh3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ibZuG9av; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vVxAFBh3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1A0C0222EA;
	Thu,  9 Oct 2025 09:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760001292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wMIyd836qP5Ki2ZUFL7X/NOxQSeVjKDqqMfBkHBMGOY=;
	b=ibZuG9avywFKe4uXHdQDX0cfHeuY88FFtUv86QwatJ4okkrHdq5e9WT2m3vEbmnF2YZx51
	RKgNlgVO0OylMMfjMdfWKlUz2tiN+XiW64Cjc2MpIiTRqvUkhVnpfEWRN3/SxcOwtTe+6j
	KvNlqwdyQass6YfDERluqErvyE3H46c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760001292;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wMIyd836qP5Ki2ZUFL7X/NOxQSeVjKDqqMfBkHBMGOY=;
	b=vVxAFBh3kvEnvny1uC4aWErvWilCgXNqYyLHrJUqigDziGnjVL0NsVDe1co7x19Lh45vig
	T+fcih5YOP9j8RCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ibZuG9av;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vVxAFBh3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760001292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wMIyd836qP5Ki2ZUFL7X/NOxQSeVjKDqqMfBkHBMGOY=;
	b=ibZuG9avywFKe4uXHdQDX0cfHeuY88FFtUv86QwatJ4okkrHdq5e9WT2m3vEbmnF2YZx51
	RKgNlgVO0OylMMfjMdfWKlUz2tiN+XiW64Cjc2MpIiTRqvUkhVnpfEWRN3/SxcOwtTe+6j
	KvNlqwdyQass6YfDERluqErvyE3H46c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760001292;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wMIyd836qP5Ki2ZUFL7X/NOxQSeVjKDqqMfBkHBMGOY=;
	b=vVxAFBh3kvEnvny1uC4aWErvWilCgXNqYyLHrJUqigDziGnjVL0NsVDe1co7x19Lh45vig
	T+fcih5YOP9j8RCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1087B13A61;
	Thu,  9 Oct 2025 09:14:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id J872Awx952isJgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 09 Oct 2025 09:14:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A0C5BA0A71; Thu,  9 Oct 2025 11:14:51 +0200 (CEST)
Date: Thu, 9 Oct 2025 11:14:51 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu, 
	adilger.kernel@dilger.ca, yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com, 
	yangerkun@huawei.com
Subject: Re: [PATCH v2 11/13] ext4: switch to using the new extent movement
 method
Message-ID: <5g66nxbf3ay2bryv4legk46pudqonsbrdkxr5ljegbxaydkctk@2dyyoxguxyxu>
References: <20250925092610.1936929-1-yi.zhang@huaweicloud.com>
 <20250925092610.1936929-12-yi.zhang@huaweicloud.com>
 <wdluk2p7bmgkh3n3xzep3tf3qb7mv3x2o6ltemjcahgorgmhwb@hfu7t7ar2vol>
 <fcf30c3c-25c3-4b1a-8b34-a5dcd98b7ebd@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcf30c3c-25c3-4b1a-8b34-a5dcd98b7ebd@huaweicloud.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 1A0C0222EA
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01

On Thu 09-10-25 15:20:59, Zhang Yi wrote:
> On 10/8/2025 8:49 PM, Jan Kara wrote:
> > On Thu 25-09-25 17:26:07, Zhang Yi wrote:
> >> +			if (ret == -EBUSY &&
> >> +			    sbi->s_journal && retries++ < 4 &&
> >> +			    jbd2_journal_force_commit_nested(sbi->s_journal))
> >> +				continue;
> >> +			if (ret)
> >>  				goto out;
> >> -		} else { /* in_range(o_start, o_blk, o_len) */
> >> -			cur_len += cur_blk - o_start;
> >> +
> >> +			*moved_len += m_len;
> >> +			retries = 0;
> >>  		}
> >> -		unwritten = ext4_ext_is_unwritten(ex);
> >> -		if (o_end - o_start < cur_len)
> >> -			cur_len = o_end - o_start;
> >> -
> >> -		orig_page_index = o_start >> (PAGE_SHIFT -
> >> -					       orig_inode->i_blkbits);
> >> -		donor_page_index = d_start >> (PAGE_SHIFT -
> >> -					       donor_inode->i_blkbits);
> >> -		offset_in_page = o_start % blocks_per_page;
> >> -		if (cur_len > blocks_per_page - offset_in_page)
> >> -			cur_len = blocks_per_page - offset_in_page;
> >> -		/*
> >> -		 * Up semaphore to avoid following problems:
> >> -		 * a. transaction deadlock among ext4_journal_start,
> >> -		 *    ->write_begin via pagefault, and jbd2_journal_commit
> >> -		 * b. racing with ->read_folio, ->write_begin, and
> >> -		 *    ext4_get_block in move_extent_per_page
> >> -		 */
> >> -		ext4_double_up_write_data_sem(orig_inode, donor_inode);
> >> -		/* Swap original branches with new branches */
> >> -		*moved_len += move_extent_per_page(o_filp, donor_inode,
> >> -				     orig_page_index, donor_page_index,
> >> -				     offset_in_page, cur_len,
> >> -				     unwritten, &ret);
> >> -		ext4_double_down_write_data_sem(orig_inode, donor_inode);
> >> -		if (ret < 0)
> >> -			break;
> >> -		o_start += cur_len;
> >> -		d_start += cur_len;
> >> +		orig_blk += mext.orig_map.m_len;
> >> +		donor_blk += mext.orig_map.m_len;
> >> +		len -= mext.orig_map.m_len;
> > 
> > In case we've called mext_move_extent() we should update everything only by
> > m_len, shouldn't we? Although I have somewhat hard time coming up with a
> > realistic scenario where m_len != mext.orig_map.m_len for the parameters we
> > call ext4_swap_extents() with... So maybe I'm missing something.
> 
> In the case of MEXT_SKIP_EXTENT, the target move range of the donor file
> is a hole. In this case, the m_len is return zero after calling
> mext_move_extent(), not equal to mext.orig_map.m_len, and we need to move
> forward and skip this range in the next iteration in ext4_move_extents().
> Otherwise, it will lead to an infinite loop.

Right, that would be a problem. I thought this shouldn't happen because we
call mext_move_extent() only if we have mapped or unwritten extent but if
donor inode has a hole in the same place, MEXT_SKIP_EXTENT can still
happen.

> In the other two cases, MEXT_MOVE_EXTENT and MEXT_COPY_DATA, m_len should
> be equal to mext.orig_map.m_len after calling mext_move_extent().

So this is the bit which isn't 100% clear to me. Because what looks fishy
to me is that ext4_swap_extents() can fail after swapping part of the
passed range (e.g. due to extent split failure). In that case we'll return
number smaller than mext.orig_map.m_len. Now that I'm looking again, we'll
set *erp in all those cases (there are cases where ext4_swap_extents()
returns smaller number even without setting *erp but I don't think those
can happen given the locks we hold and what we've already verified - still
it would be good to add an assert for this in mext_move_extent()) so the
problem would rather be that we don't advance by m_len in case of error
returned from mext_move_extent()?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

