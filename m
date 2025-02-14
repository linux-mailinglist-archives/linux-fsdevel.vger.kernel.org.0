Return-Path: <linux-fsdevel+bounces-41715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC11A35BBA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 11:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC5A23AD8E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 10:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DD825D52B;
	Fri, 14 Feb 2025 10:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VJ09KSsm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NrWNIXue";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VJ09KSsm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NrWNIXue"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B24245B0B
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 10:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739529913; cv=none; b=QtaBOiRDCX2dB6KWoRfmzhgrh/fXfDGW0cafhvzDuYZuZRbEaw+SczTeIyUNDcoS7StdlwMCgqXqlyFlDAo/VUle4rGdyqq73EbZ+HTyJVIMkAoleR/yyHTqjPVrzLsnRfFoEOWJPyguHBnJIbghNAJ2aQno67yu8UqTwNo/8Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739529913; c=relaxed/simple;
	bh=le7r6IA9Gp7L1oFDSkXA5oZli+zZK8NjnrUNSpbeAwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iK1y+Eg126EoywrLILND7UFtXidIs1xVka/XfIWmee1Thv4SpMrO1s03ABdEy36arEoHKnFbO4ls7VCtvRXm5mJSuozLw78pwZwTS6/rFq6+LfmBy92LBB13j6YN/9uKYxnBkpyKXMU1QoxBR59zKkwS2H9fFp6PsERzuAdZU6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=fail smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VJ09KSsm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NrWNIXue; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VJ09KSsm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NrWNIXue; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3B5B01F381;
	Fri, 14 Feb 2025 10:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739529908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C72YKO+lGONxV8VaoImpaJ8SflA0GRGbtpS5Gj3zqEc=;
	b=VJ09KSsmDfQTkAWohTuFAOzti1Hd+aABS3G4fnGFNmDY4Py4imMEjseJfG7VYyMjxZc8GQ
	sJsO3z2qK7OVidzefK6Y05A1HCHO5NOdmr2ZoBbUgyEVkPPP2EJonkhN+SKDlt7RmsBKWR
	2MPxT2x4NHXsAyw9t9kxRRiuzUXjV2s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739529908;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C72YKO+lGONxV8VaoImpaJ8SflA0GRGbtpS5Gj3zqEc=;
	b=NrWNIXuePRWHrrMR6uU1qbww/jM4Z30FFj9dw1+bcz+A9+FR45yyGScFm95P8mznoMG+aH
	b+1+VDEcIz9BRmBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=VJ09KSsm;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NrWNIXue
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739529908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C72YKO+lGONxV8VaoImpaJ8SflA0GRGbtpS5Gj3zqEc=;
	b=VJ09KSsmDfQTkAWohTuFAOzti1Hd+aABS3G4fnGFNmDY4Py4imMEjseJfG7VYyMjxZc8GQ
	sJsO3z2qK7OVidzefK6Y05A1HCHO5NOdmr2ZoBbUgyEVkPPP2EJonkhN+SKDlt7RmsBKWR
	2MPxT2x4NHXsAyw9t9kxRRiuzUXjV2s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739529908;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C72YKO+lGONxV8VaoImpaJ8SflA0GRGbtpS5Gj3zqEc=;
	b=NrWNIXuePRWHrrMR6uU1qbww/jM4Z30FFj9dw1+bcz+A9+FR45yyGScFm95P8mznoMG+aH
	b+1+VDEcIz9BRmBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 30DE4137DB;
	Fri, 14 Feb 2025 10:45:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AEnkC7Qer2e6UwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 14 Feb 2025 10:45:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E6023A07B2; Fri, 14 Feb 2025 11:45:07 +0100 (CET)
Date: Fri, 14 Feb 2025 11:45:07 +0100
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] ext4: Remove references to bh->b_page
Message-ID: <ffxmulhjdl7wjm5kengcwntppgwxdfmvoqxodi6sgwue7nkw5k@v6one4slgjk5>
References: <20250213182303.2133205-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213182303.2133205-1-willy@infradead.org>
X-Rspamd-Queue-Id: 3B5B01F381
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Thu 13-02-25 18:23:01, Matthew Wilcox (Oracle) wrote:
> Buffer heads are attached to folios, not to pages.  Also
> flush_dcache_page() is now deprecated in favour of flush_dcache_folio().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c   | 2 +-
>  fs/ext4/super.c   | 2 +-
>  fs/jbd2/journal.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 7c54ae5fcbd4..bd579f46c7f3 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -751,7 +751,7 @@ static void ext4_update_bh_state(struct buffer_head *bh, unsigned long flags)
>  	flags &= EXT4_MAP_FLAGS;
>  
>  	/* Dummy buffer_head? Set non-atomically. */
> -	if (!bh->b_page) {
> +	if (!bh->b_folio) {
>  		bh->b_state = (bh->b_state & ~EXT4_MAP_FLAGS) | flags;
>  		return;
>  	}
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index a50e5c31b937..366ce891bcc3 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -7288,7 +7288,7 @@ static ssize_t ext4_quota_write(struct super_block *sb, int type,
>  	}
>  	lock_buffer(bh);
>  	memcpy(bh->b_data+offset, data, len);
> -	flush_dcache_page(bh->b_page);
> +	flush_dcache_folio(bh->b_folio);
>  	unlock_buffer(bh);
>  	err = ext4_handle_dirty_metadata(handle, NULL, bh);
>  	brelse(bh);
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index d8084b31b361..e5a4e4ba7837 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -947,7 +947,7 @@ int jbd2_journal_bmap(journal_t *journal, unsigned long blocknr,
>   * descriptor blocks we do need to generate bona fide buffers.
>   *
>   * After the caller of jbd2_journal_get_descriptor_buffer() has finished modifying
> - * the buffer's contents they really should run flush_dcache_page(bh->b_page).
> + * the buffer's contents they really should run flush_dcache_folio(bh->b_folio).
>   * But we don't bother doing that, so there will be coherency problems with
>   * mmaps of blockdevs which hold live JBD-controlled filesystems.
>   */
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

