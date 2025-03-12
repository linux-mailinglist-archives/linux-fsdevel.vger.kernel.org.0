Return-Path: <linux-fsdevel+bounces-43826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B92A5E216
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 17:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BFBB1897F8F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 16:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5C7247DE1;
	Wed, 12 Mar 2025 16:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qk6ZOTdN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x9gDHSwF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qk6ZOTdN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x9gDHSwF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060A423C8A1
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 16:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741798581; cv=none; b=cdGPQrxqSEkneVe8D8YQYRFmWdbh6jSPiqEELFonWO5O35RiUTHrCSX2C+Wd1dhQpn4CfbCC1Ch2JGwbAo39/zYFU/35TDqPVJ/QEMS21Htmlg4ZOsOLsuJufmCC9ccW4QVeRYgO2jIH6/yC9ALN7CdDhtCG+ts9pDWUQLkhuis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741798581; c=relaxed/simple;
	bh=uh35nGN0IHCrnwywIYK+0vEczrB5TEUMO0E6zbeTKfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYCm5OW9qvMjB3gj2I72XiStWBVYfFZ9aEO3A9DBNr1wtKZKKIKYauF48GkON9gcJyZs3j4SGCJr7Jqk5Kgrb/Sv4GN+JUgg+DGgbvuue99T6Z2jdCE8gBbb8KTth1OfAus59yID992KuTKLfr5MbtHPQCGQWK73LowSaJ1qO9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qk6ZOTdN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x9gDHSwF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qk6ZOTdN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x9gDHSwF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3130A21162;
	Wed, 12 Mar 2025 16:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741798578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NP19c8DtsXsOXhqedlpTQdpMcnzzs5JhTXYgSKYWJtA=;
	b=qk6ZOTdN2O8DG0xVJqfH7r1m04DlHuClu9yl7AcA+uNMUQ6WBog/QaQcDguLUCFBL6Xgr+
	732vcBNLShhtozBJp7mcbWpIGT+m+HvZ0+1o+46ZXgzXS01ZBcN5yveTV++YA/c4Qi3nFf
	Z1xXGAe/FeMhtHLmcQdZiK8U338LWwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741798578;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NP19c8DtsXsOXhqedlpTQdpMcnzzs5JhTXYgSKYWJtA=;
	b=x9gDHSwFXNaeZ7wmZKSHUh/wCklBf1rLrUcChN7rBbOoU6wT7bYdaWEkqqeF9cDp7ImfEN
	8Z4CIhyuI44GE/BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741798578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NP19c8DtsXsOXhqedlpTQdpMcnzzs5JhTXYgSKYWJtA=;
	b=qk6ZOTdN2O8DG0xVJqfH7r1m04DlHuClu9yl7AcA+uNMUQ6WBog/QaQcDguLUCFBL6Xgr+
	732vcBNLShhtozBJp7mcbWpIGT+m+HvZ0+1o+46ZXgzXS01ZBcN5yveTV++YA/c4Qi3nFf
	Z1xXGAe/FeMhtHLmcQdZiK8U338LWwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741798578;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NP19c8DtsXsOXhqedlpTQdpMcnzzs5JhTXYgSKYWJtA=;
	b=x9gDHSwFXNaeZ7wmZKSHUh/wCklBf1rLrUcChN7rBbOoU6wT7bYdaWEkqqeF9cDp7ImfEN
	8Z4CIhyuI44GE/BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 28B25132CB;
	Wed, 12 Mar 2025 16:56:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SNbqCbK80WdHKQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 12 Mar 2025 16:56:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D5E9DA0908; Wed, 12 Mar 2025 17:56:17 +0100 (CET)
Date: Wed, 12 Mar 2025 17:56:17 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] Fix for potential deadlock in pre-content event
Message-ID: <b7ryrvrr4m42x3sjvjeh334zjldtgeioslw4cfe7mbuhhe5w2p@3qujunxr4ezd>
References: <20250312073852.2123409-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312073852.2123409-1-amir73il@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

Hi!

On Wed 12-03-25 08:38:46, Amir Goldstein wrote:
> This is the mmap solution proposed by Josef to solve the potential
> deadlock with faulting in user pages [1].
> 
> I've added test coverage to mmap() pre-content events and verified
> no pre-content events on page fault [2].

Yeah, sorry for a bit delayd reply but this seems like the least
controversial path forward for now. I was thinking for some time about a
proper solution for the deadlock but so far I didn't come up with anything
clever.

> After some push back on [v2] for disabling page fault pre-content hooks
> while leaving their code in the kernel, this series revert the page
> fault pre-content hooks.
> 
> This leaves DAX files access without pre-content hooks, but that was
> never a goal for this feature, so I think that is fine.

Yes, I think we can live with that for now.

I'll take the patches to my tree with a view of sending them to Linus over
the weekend after some exposure in linux-next.

Thanks for taking care of this!

								Honza

> Changes since v2:
> - Revert page fault pre-content hooks
> - Remove mmap hook from remap_file_pages() (Lorenzo)
> - Create fsnotify_mmap_perm() wrapper (Lorenzo)
> 
> [1] https://lore.kernel.org/linux-fsdevel/20250307154614.GA59451@perftesting/
> [2] https://github.com/amir73il/ltp/commits/fan_hsm/
> [v2] https://lore.kernel.org/linux-fsdevel/20250311114153.1763176-1-amir73il@gmail.com/
> [v1] https://lore.kernel.org/linux-fsdevel/20250309115207.908112-1-amir73il@gmail.com/
> 
> Amir Goldstein (6):
>   fsnotify: add pre-content hooks on mmap()
>   Revert "ext4: add pre-content fsnotify hook for DAX faults"
>   Revert "xfs: add pre-content fsnotify hook for DAX faults"
>   Revert "fsnotify: generate pre-content permission event on page fault"
>   Revert "mm: don't allow huge faults for files with pre content
>     watches"
>   Revert "fanotify: disable readahead if we have pre-content watches"
> 
>  fs/ext4/file.c           |  3 --
>  fs/xfs/xfs_file.c        | 13 ------
>  include/linux/fsnotify.h | 21 ++++++++++
>  include/linux/mm.h       |  1 -
>  mm/filemap.c             | 86 ----------------------------------------
>  mm/memory.c              | 19 ---------
>  mm/nommu.c               |  7 ----
>  mm/readahead.c           | 14 -------
>  mm/util.c                |  3 ++
>  9 files changed, 24 insertions(+), 143 deletions(-)
> 
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

