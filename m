Return-Path: <linux-fsdevel+bounces-49845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFCDAC409A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 15:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C90A5175B6F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 13:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEE320CCD0;
	Mon, 26 May 2025 13:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aHVq773Q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SWzT/9EW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aHVq773Q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SWzT/9EW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE7D1F03D6
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 May 2025 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748267019; cv=none; b=q/0vKYhKd+0ovdXdH01Cryo0F7UIV36HwXrsHixGBrsKAI5hPjK9D+zCHYknuXVJ1TxYVhgvvIAdscZlau12zolH7Gy9RBkcyiFnNZHm0cbrG9iET2Vms6/QHpEUwnmFKAvWDBL1e9w7bYKv8qySWMlGHrMImpL28QKG4tOak54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748267019; c=relaxed/simple;
	bh=dbdT8CH9kLMBgpqw2k4Ycebiq5nWvPRHpskIWVDXcdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gY/dmyieRiQZOzE/hSqcJolVt6+um7fTQ8D5zRZYZ3r5PER9P0Xl6VNhCUH+p+wrggygp4NczP20SaXUnwDKSodZIaOmK2O+qceAKG9wpEh5rkfCYq3UMsVQpoCyhy12n844twOu+YSO7K8i+Dqx8k/DYivJbsU5p3f6ouT+x6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aHVq773Q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SWzT/9EW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aHVq773Q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SWzT/9EW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7643121B02;
	Mon, 26 May 2025 13:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748267015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GJKMoSICTohzot7RddDaVJ7KmKKzKBE+vdA1bFKH+Pc=;
	b=aHVq773QRUWSwQ9s8pxOdi67mNt6I5VQ942/TSaRSITHgILgc31qt6Eirz/BQp8Xaqjeaz
	sLpchB+Diu2r+A/ubbuua+0rl3rb4fs/DQ8w81N/EFecvmirPWSmAWFipE4ZnezfrTpBNL
	24bT2fYxIhLiOU2aji0bDNNo2RM2Glw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748267015;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GJKMoSICTohzot7RddDaVJ7KmKKzKBE+vdA1bFKH+Pc=;
	b=SWzT/9EWur9LCVlkKsb1+TOM1kIEi4QMD/HvfZc93wQG5YP7usIwmf1AIuunacNlO22SyS
	rHvJF5IaJodK++Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748267015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GJKMoSICTohzot7RddDaVJ7KmKKzKBE+vdA1bFKH+Pc=;
	b=aHVq773QRUWSwQ9s8pxOdi67mNt6I5VQ942/TSaRSITHgILgc31qt6Eirz/BQp8Xaqjeaz
	sLpchB+Diu2r+A/ubbuua+0rl3rb4fs/DQ8w81N/EFecvmirPWSmAWFipE4ZnezfrTpBNL
	24bT2fYxIhLiOU2aji0bDNNo2RM2Glw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748267015;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GJKMoSICTohzot7RddDaVJ7KmKKzKBE+vdA1bFKH+Pc=;
	b=SWzT/9EWur9LCVlkKsb1+TOM1kIEi4QMD/HvfZc93wQG5YP7usIwmf1AIuunacNlO22SyS
	rHvJF5IaJodK++Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B62D1397F;
	Mon, 26 May 2025 13:43:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Rww2GgdwNGiuPQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 26 May 2025 13:43:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 26105A09B7; Mon, 26 May 2025 15:43:31 +0200 (CEST)
Date: Mon, 26 May 2025 15:43:31 +0200
From: Jan Kara <jack@suse.cz>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>, 
	Tao Ma <boyu.mt@taobao.com>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Eric Biggers <ebiggers@google.com>, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com, 
	syzbot+0c89d865531d053abb2d@syzkaller.appspotmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] ext4: inline: do not convert when writing to memory map
Message-ID: <ixlyfqaobk4whctod5wwhusqeeduqxamni6zkxl2wdlbtcyms2@intsywwjfv25>
References: <20250519-ext4_inline_page_mkwrite-v1-1-865d9a62b512@igalia.com>
 <20250520145708.GA432950@mit.edu>
 <aC5LA4bExl8rMRv0@quatroqueijos.cascardo.eti.br>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aC5LA4bExl8rMRv0@quatroqueijos.cascardo.eti.br>
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[0c89d865531d053abb2d];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]

On Wed 21-05-25 18:52:03, Thadeu Lima de Souza Cascardo wrote:
> On Tue, May 20, 2025 at 10:57:08AM -0400, Theodore Ts'o wrote:
> > On Mon, May 19, 2025 at 07:42:46AM -0300, Thadeu Lima de Souza Cascardo wrote:
> > > inline data handling has a race between writing and writing to a memory
> > > map.
> > > 
> > > When ext4_page_mkwrite is called, it calls ext4_convert_inline_data, which
> > > destroys the inline data, but if block allocation fails, restores the
> > > inline data. In that process, we could have:
> > > 
> > > CPU1					CPU2
> > > destroy_inline_data
> > > 					write_begin (does not see inline data)
> > > restory_inline_data
> > > 					write_end (sees inline data)
> > > 
> > > The conversion inside ext4_page_mkwrite was introduced at commit
> > > 7b4cc9787fe3 ("ext4: evict inline data when writing to memory map"). This
> > > fixes a documented bug in the commit message, which suggests some
> > > alternatives fixes.
> > 
> > Your fix just reverts commit 7b4cc9787fe3, and removes the BUG_ON.
> > While this is great for shutting up the syzbot report, but it causes
> > file writes to an inline data file via a mmap to never get written
> > back to the storage device.  So you are replacing BUG_ON that can get
> > triggered on a race condition in case of a failed block allocation,
> > with silent data corruption.   This is not an improvement.
> > 
> > Thanks for trying to address this, but I'm not going to accept your
> > proposed fix.
> > 
> >      	    	 	       	       - Ted
> 
> Hi, Ted.
> 
> I am trying to understand better the circumstances where the data loss
> might occur with the fix, but might not occur without the fix. Or, even if
> they occur either way, such that I can work on a better/proper fix.
> 
> Right now, if ext4_convert_inline_data (called from ext4_page_mkwrite)
> fails with ENOSPC, the memory access will lead to a SIGBUS. The same will
> happen without the fix, if there are no blocks available.
> 
> Now, without ext4_convert_inline_data, blocks will be allocated by
> ext4_page_mkwrite and written by ext4_do_writepages. Are you concerned
> about a failure between the clearing of the inode data and the writing of
> the block in ext4_do_writepages?
> 
> Or are you concerned about a potential race condition when allocating
> blocks?
> 
> Which of these cannot happen today with the code as is? If I understand
> correctly, the inline conversion code also calls ext4_destroy_inline_data
> before allocating and writing to blocks.
> 
> Thanks a lot for the review and guidance.

So I'm not sure what Ted was exactly worried about because writeback code
should normally allocate underlying blocks for writeout of the mmaped page
AFAICT. But the problem I can see is that clearing
EXT4_STATE_MAY_INLINE_DATA requires i_rwsem held as otherwise we may be
racing with e.g. write(2) and switching EXT4_STATE_MAY_INLINE_DATA in the
middle of the write will cause bad things (inconsistency between how
write_begin() and write_end() callbacks behave).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

