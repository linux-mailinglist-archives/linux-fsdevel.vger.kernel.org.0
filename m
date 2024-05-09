Return-Path: <linux-fsdevel+bounces-19163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D4A8C0E3A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 12:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CEA8B22C08
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 10:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1715B12E1EB;
	Thu,  9 May 2024 10:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AoJgnk6z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bGlXx/jc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AoJgnk6z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bGlXx/jc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA42322E;
	Thu,  9 May 2024 10:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715250785; cv=none; b=suOqxvGdqbGa9M1MTZEMWAAj6Z/Ho7u/dABlv5d15tnNClknE/hrFqsS1Pp6xiBaMSCWrViazRZfXlbZcvXFP/A/mhiaWpsahNkmfjJGNV9B+NKUUuk2OA3z3kIGcHD3LQdmQ3Qcbxis5h33bEjjH3M/RXtXWpn5xtxkfJmqIrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715250785; c=relaxed/simple;
	bh=CB8xxaIZRl1fzw/CXfLsO53D8/KIS8y+griG0gt4mz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mz0KkapgMpe81hZQqGVVc5M4eUVcFn4n+awtE8Q0anli8b0l/F2L1MYrpNPGbZdFnYEYbVIYzeQLz3+tW/wN60khyyGZLIdt5W8L9lWakpAi0zIROhTBDXyQ4BVl3Z3ofuvydpFcNWMVmqWnq6h0Ise13iX9w+uj3FSqC15oLic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AoJgnk6z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bGlXx/jc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AoJgnk6z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bGlXx/jc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A7A38382D0;
	Thu,  9 May 2024 10:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715250781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6oKJGlMkczFIK1kqWn4wsntIpR+XDMhlPQbmWoBoSDI=;
	b=AoJgnk6zkJLVHEh81ssiaP2zj//h1pZS8irDH65yFLjvJeGOUaxpC1SFldbOMCiP96xft1
	QJ+S1HrrbjcYsF8LcHSuXzvIsx+SPDYBsHQD80l2JLwq190zGF1Ag/Uo/WX7cc+787l4V/
	IAjj1bk0GDB9tYzOPCJnHoWQCO77Z4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715250781;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6oKJGlMkczFIK1kqWn4wsntIpR+XDMhlPQbmWoBoSDI=;
	b=bGlXx/jczYEXd2R9XcD/buBBKn7XXCJ4nklBDdGpjQAGiIv0fDda5GaHVjTmaRZnoVONAK
	3qAk8OwqqJGqgTAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715250781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6oKJGlMkczFIK1kqWn4wsntIpR+XDMhlPQbmWoBoSDI=;
	b=AoJgnk6zkJLVHEh81ssiaP2zj//h1pZS8irDH65yFLjvJeGOUaxpC1SFldbOMCiP96xft1
	QJ+S1HrrbjcYsF8LcHSuXzvIsx+SPDYBsHQD80l2JLwq190zGF1Ag/Uo/WX7cc+787l4V/
	IAjj1bk0GDB9tYzOPCJnHoWQCO77Z4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715250781;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6oKJGlMkczFIK1kqWn4wsntIpR+XDMhlPQbmWoBoSDI=;
	b=bGlXx/jczYEXd2R9XcD/buBBKn7XXCJ4nklBDdGpjQAGiIv0fDda5GaHVjTmaRZnoVONAK
	3qAk8OwqqJGqgTAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9DD8513941;
	Thu,  9 May 2024 10:33:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nJuCJl2mPGbJQAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 09 May 2024 10:33:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4E4B5A0861; Thu,  9 May 2024 12:33:01 +0200 (CEST)
Date: Thu, 9 May 2024 12:33:01 +0200
From: Jan Kara <jack@suse.cz>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv2 1/2] iomap: Fix iomap_adjust_read_range for plen
 calculation
Message-ID: <20240509103301.6rievb5fx32iqcxk@quack3>
References: <cover.1715067055.git.ritesh.list@gmail.com>
 <a32e5f9a4fcfdb99077300c4020ed7ae61d6e0f9.1715067055.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a32e5f9a4fcfdb99077300c4020ed7ae61d6e0f9.1715067055.git.ritesh.list@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On Tue 07-05-24 14:25:42, Ritesh Harjani (IBM) wrote:
> If the extent spans the block that contains i_size, we need to handle
> both halves separately so that we properly zero data in the page cache
> for blocks that are entirely outside of i_size. But this is needed only
> when i_size is within the current folio under processing.
> "orig_pos + length > isize" can be true for all folios if the mapped
> extent length is greater than the folio size. That is making plen to
> break for every folio instead of only the last folio.
> 
> So use orig_plen for checking if "orig_pos + orig_plen > isize".
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  fs/iomap/buffered-io.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 4e8e41c8b3c0..9f79c82d1f73 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -241,6 +241,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
>  	unsigned block_size = (1 << block_bits);
>  	size_t poff = offset_in_folio(folio, *pos);
>  	size_t plen = min_t(loff_t, folio_size(folio) - poff, length);
> +	size_t orig_plen = plen;
>  	unsigned first = poff >> block_bits;
>  	unsigned last = (poff + plen - 1) >> block_bits;
> 
> @@ -277,7 +278,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
>  	 * handle both halves separately so that we properly zero data in the
>  	 * page cache for blocks that are entirely outside of i_size.
>  	 */
> -	if (orig_pos <= isize && orig_pos + length > isize) {
> +	if (orig_pos <= isize && orig_pos + orig_plen > isize) {
>  		unsigned end = offset_in_folio(folio, isize - 1) >> block_bits;
> 
>  		if (first <= end && last > end)
> --
> 2.44.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

