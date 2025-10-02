Return-Path: <linux-fsdevel+bounces-63305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39382BB4721
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 18:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31ED916618B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 16:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDF0242925;
	Thu,  2 Oct 2025 16:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ufKzI35u";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="N9W6Xp0r";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ufKzI35u";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="N9W6Xp0r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4029D2BD03
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759421339; cv=none; b=uKhbTvUAJtI+qJIEtkjhDpPJxhFMFsD8U5Tra6MsVOfU8lba1aHtnzeSET+voKk/el8z0NdCKORc23V8XsB41FPCewJgRw2qFzseVrgTQf78yAWALFsHTW9YrYFB7mbaBgl2v/l/SLEAbBJzGJU09Gu4zLWX4AclyhCeqYf74q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759421339; c=relaxed/simple;
	bh=ioIMyd3kpSLAWwGhmKX9lIlETZIrkU/y9fHDB/gkBn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RzDNkaUJEqkHqeHtbAStyoO7ZobCmMJm0KRvxQoI7HJNz97osbWElF1iRfxWLGB1Dp/KToLim9SrV+HitVlTTIFDSWR3gk+M9/V+IEVG+qfWwn1vtESM0H2/COiSj5e4MlrG2L/No7haNDaMpNDPxcYH7GC7HOPi9DSNgoCkNMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ufKzI35u; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=N9W6Xp0r; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ufKzI35u; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=N9W6Xp0r; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 782F71F74C;
	Thu,  2 Oct 2025 16:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759421335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mMfYu5fHhCkDmwDC+Z/a2bGRlbbVtf3KJSZLjjALdzI=;
	b=ufKzI35uZa4zMwSPHm2MK4TOZAbPklKHse7WEcOFbzy2arkUiTPs9e2gJEW89HpMAxTTn5
	/O68y2FoOeTM4I2oKRaZIrmxjQX3Ti5zChAaPXXsqxzMpv37JVKS3Tz5LNojundgh62SC0
	RRHkRxBg9jel7OVdC549War/dHVojRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759421335;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mMfYu5fHhCkDmwDC+Z/a2bGRlbbVtf3KJSZLjjALdzI=;
	b=N9W6Xp0r0R1DLKoBRQDvprCVWl5pQFQmRT35JNejAEdSFxltTTc5BJZQeEPznrrNriH1bW
	q55s34TXpym6BPAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759421335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mMfYu5fHhCkDmwDC+Z/a2bGRlbbVtf3KJSZLjjALdzI=;
	b=ufKzI35uZa4zMwSPHm2MK4TOZAbPklKHse7WEcOFbzy2arkUiTPs9e2gJEW89HpMAxTTn5
	/O68y2FoOeTM4I2oKRaZIrmxjQX3Ti5zChAaPXXsqxzMpv37JVKS3Tz5LNojundgh62SC0
	RRHkRxBg9jel7OVdC549War/dHVojRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759421335;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mMfYu5fHhCkDmwDC+Z/a2bGRlbbVtf3KJSZLjjALdzI=;
	b=N9W6Xp0r0R1DLKoBRQDvprCVWl5pQFQmRT35JNejAEdSFxltTTc5BJZQeEPznrrNriH1bW
	q55s34TXpym6BPAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6BDD31395B;
	Thu,  2 Oct 2025 16:08:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id z6tQGpej3mglbwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 02 Oct 2025 16:08:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1AA34A0A58; Thu,  2 Oct 2025 18:08:51 +0200 (CEST)
Date: Thu, 2 Oct 2025 18:08:51 +0200
From: Jan Kara <jack@suse.cz>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isofs: fix inode leak caused by disconnected dentries
 from exportfs
Message-ID: <of6vjajyda3355hl7vskbjjb67wrqlqfv4hn5i2vxihn2qspau@3dqu5dolu3z5>
References: <20251001202713.2077654-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001202713.2077654-1-kartikey406@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

Hello,

On Thu 02-10-25 01:57:13, Deepanshu Kartikey wrote:
> Thank you for the review. You're absolutely right - my initial
> explanation was incorrect. I've done extensive debugging to understand
> the actual mechanism causing the leak.

Hrm, the text below looks like it was generated by some AI agent :) More
importantly it still doesn't really explain the underlying cause of the
leak - it is fine to use AI for debugging but then one should get his own
understanding of the situation. As I was curious about the root cause, I
did the debugging myself and [1] has the proper analysis of the problem and
the fix.

								Honza

[1] https://lore.kernel.org/all/20251002155506.10755-2-jack@suse.cz/

> 
> Root Cause Analysis
> ===================
> 
> The leak occurs specifically with CONFIG_JOLIET=y through the following sequence:
> 
> 1. Joliet Root Switching During Mount
> --------------------------------------
> 
> In isofs_fill_super(), when Joliet extensions are detected:
> - Primary root inode 1792 is created with i_count=1, i_nlink=3
> - During Joliet switching, iput(inode) is called on inode 1792
> - i_count decrements to 0, but generic_drop_inode() returns false (i_nlink=3 > 0)
> - Inode 1792 remains cached at i_count=0
> - New Joliet root inode 1920 is created and attached to sb->s_root
> 
> Debugging output:
>   [9.653617] isofs: switching roots, about to iput ino=1792, i_count=1
>   [9.653676] isofs: after iput, getting new root
>   [9.653880] isofs: old inode after iput ino=1792, i_count=0, i_nlink=3
>   [9.654219] isofs: got new root ino=1920, i_count=1
> 
> 2. open_by_handle_at() Triggers Reconnection
> ---------------------------------------------
> 
> When the system call attempts to resolve a file handle:
> - exportfs_decode_fh_raw() calls fh_to_dentry() which returns inode 1856
> - The dentry is marked DCACHE_DISCONNECTED
> - reconnect_path() is invoked to connect the path to root
> - This calls reconnect_one() to walk up the directory tree
> 
> 3. Reference Accumulation in reconnect_one()
> ---------------------------------------------
> 
> I instrumented reconnect_one() to track dentry reference counts:
> 
>   [8.010398] reconnect_one: called for inode 1856
>   [8.010735] isofs: __isofs_iget got inode 1792, i_count=1
>   [8.011041] After fh_to_parent: d_count=1
>   [8.011319] After exportfs_get_name: d_count=2
>   [8.011769] After lookup_one_unlocked: d_count=3
> 
> The parent dentry (inode 1792) accumulates 3 references:
> 1. Initial reference from fh_to_parent()
> 2. Additional reference taken by exportfs_get_name()
> 3. Another reference taken by lookup_one_unlocked()
> 
> Then lookup_one_unlocked() creates a dentry for inode 1807:
>   [8.015179] isofs: __isofs_iget got inode 1807, i_count=1
>   [8.016169] lookup returns tmp (inode 1807), d_count=1
> 
> The code enters the tmp != dentry branch and calls dput(tmp), then goes to 
> out_reconnected.
> 
> 4. Insufficient Cleanup
> -----------------------
> 
> For inode 1807, I traced through dput():
>   [10.083359] fast_dput: lockref_put_return returned 0
>   [10.083699] fast_dput: RETAINING dentry for inode 1807, d_flags=0x240043
> 
> The dentry refcount goes to 0, but retain_dentry() returns true because of 
> the DCACHE_REFERENCED flag (0x40 in 0x240043). The dentry is kept in cache 
> with refcount 0, still holding the inode reference.
> 
> For inode 1792:
>   [10.084125] fast_dput: lockref_put_return returned 2
> 
> At out_reconnected, only one dput(parent) is called, decrementing from 3 to 2. 
> Two references remain leaked.
> 
> 5. Unmount Failure
> ------------------
> 
> At unmount time:
> - shrink_dcache_for_umount() doesn't evict dentries with positive refcounts (1792)
> - Doesn't aggressively evict retained dentries with refcount 0 (1807)
> - Both inodes appear as leaked with i_count=1
> 
>   [10.155385] LEAKED INODE: ino=1807, i_count=1, i_state=0x0, i_nlink=1
>   [10.155604] LEAKED INODE: ino=1792, i_count=1, i_state=0x0, i_nlink=1
> 
> Why shrink_dcache_sb() Works
> =============================
> 
> Calling shrink_dcache_sb() in isofs_put_super() forces eviction of:
> - Dentries with extra references that weren't properly released
> - Retained dentries sitting in cache at refcount 0
> 
> This ensures cleanup happens before the superblock is destroyed.
> 
> Open Questions
> ==============
> 
> 1. Are exportfs_get_name() and lookup_one_unlocked() supposed to take 
>    references to the parent dentry that the caller must release? Should 
>    reconnect_one() be calling dput(parent) multiple times, or are these 
>    functions leaking references?
> 
> 2. Is adding shrink_dcache_sb() in put_super() the appropriate fix, or 
>    should this be handled in the reconnection error path when 
>    reconnect_one() fails?
> 
> 3. Does this indicate a broader issue with how exportfs handles parent 
>    dentry references during failed path reconnections that might affect 
>    other filesystems?
> 
> I can investigate further into the implementation of exportfs_get_name() 
> and lookup_one_unlocked() to understand where exactly the extra references 
> are taken if that would be helpful.
> 
> Best regards,
> Deepanshu Kartikey
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

