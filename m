Return-Path: <linux-fsdevel+bounces-3420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F24BC7F4643
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 13:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20D2A1C20A53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 12:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C184D12B;
	Wed, 22 Nov 2023 12:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NsPKAhuS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aQDW0Dtl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4162F92;
	Wed, 22 Nov 2023 04:29:49 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3017C21940;
	Wed, 22 Nov 2023 12:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700656187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xuFT61rMAuWU8L3b6RjlAfH9ryapgGUCzXO0AJs9dd8=;
	b=NsPKAhuSLvGv93y/RDHG3xIxBmzpVnXRcAS45PTw0AP+CwgGOMfUUs7Bw4REs2SxdDfrR4
	fqzUUnrlpfoue/0R6+XcB4JOuD34TeSvC2i4wMkmdgFjuSk06cC7DuWLsCwf6NpgI9vKWL
	wFFfV8tdVReycVhHv/9DWY34Kpk3AVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700656187;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xuFT61rMAuWU8L3b6RjlAfH9ryapgGUCzXO0AJs9dd8=;
	b=aQDW0DtlhYxecQH4V+PnyDQB7+NZy3dh5S+Uq6OT0hdCJcld1yxOEWxOiARsqNhkeMctyH
	S1OMjUR3tOgKujCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 16DC613461;
	Wed, 22 Nov 2023 12:29:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id iMqKBTv0XWVxTgAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 22 Nov 2023 12:29:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9B8ACA07DC; Wed, 22 Nov 2023 13:29:46 +0100 (CET)
Date: Wed, 22 Nov 2023 13:29:46 +0100
From: Jan Kara <jack@suse.cz>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 2/3] ext2: Convert ext2 regular file buffered I/O to use
 iomap
Message-ID: <20231122122946.wg3jqvem6fkg3tgw@quack3>
References: <cover.1700506526.git.ritesh.list@gmail.com>
 <f5e84d3a63de30def2f3800f534d14389f6ba137.1700506526.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5e84d3a63de30def2f3800f534d14389f6ba137.1700506526.git.ritesh.list@gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[]

On Tue 21-11-23 00:35:20, Ritesh Harjani (IBM) wrote:
> This patch converts ext2 regular file's buffered-io path to use iomap.
> - buffered-io path using iomap_file_buffered_write
> - DIO fallback to buffered-io now uses iomap_file_buffered_write
> - writeback path now uses a new aops - ext2_file_aops
> - truncate now uses iomap_truncate_page
> - mmap path of ext2 continues to use generic_file_vm_ops
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Looks nice and simple. Just one comment below:

> +static void ext2_file_readahead(struct readahead_control *rac)
> +{
> +	return iomap_readahead(rac, &ext2_iomap_ops);
> +}

As Matthew noted, the return of void here looks strange.

> +static int ext2_write_map_blocks(struct iomap_writepage_ctx *wpc,
> +				 struct inode *inode, loff_t offset)
> +{
> +	if (offset >= wpc->iomap.offset &&
> +	    offset < wpc->iomap.offset + wpc->iomap.length)
> +		return 0;
> +
> +	return ext2_iomap_begin(inode, offset, inode->i_sb->s_blocksize,
> +				IOMAP_WRITE, &wpc->iomap, NULL);
> +}

So this will end up mapping blocks for writeback one block at a time if I'm
understanding things right because ext2_iomap_begin() never sets extent
larger than 'length' in the iomap result. Hence the wpc checking looks
pointless (and actually dangerous - see below). So this will probably get
more expensive than necessary by calling into ext2_get_blocks() for each
block? Perhaps we could first call ext2_iomap_begin() for reading with high
length to get as many mapped blocks as we can and if we find unmapped block
(should happen only for writes through mmap), we resort to what you have
here... Hum, but this will not work because of the races with truncate
which could remove blocks whose mapping we have cached in wpc. We can
safely provide a mapping under a folio only once it is locked or has
writeback bit set. XFS plays the revalidation sequence counter games
because of this so we'd have to do something similar for ext2. Not that I'd
care as much about ext2 writeback performance but it should not be that
hard and we'll definitely need some similar solution for ext4 anyway. Can
you give that a try (as a followup "performance improvement" patch).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

