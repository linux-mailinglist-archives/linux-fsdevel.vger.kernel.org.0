Return-Path: <linux-fsdevel+bounces-63948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A42BD2C85
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 13:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 47EC64E5BED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 11:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89141258EFF;
	Mon, 13 Oct 2025 11:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c2pY3Q60";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PKyKaGFX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c2pY3Q60";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PKyKaGFX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A276221F26
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 11:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760355143; cv=none; b=V/y+iy6SKG+MkEo0aS1QY0YqzbnhGHHB1KCf7XHn3blUQPVrFz6uH8kRFwmbqLpJlIqcksiLm+PFgRlYZoij6rpMRL725tj5hAHfFo/0GkUQwnv+FoyUZcQVcpslKtCZ/aXWzQ7Opds+oOWWkYZ5+FmaPOQNWlaNYlgFn7Qet9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760355143; c=relaxed/simple;
	bh=0xosZGkTXmSnEMdEcfXUoHuhuRB8W/qpykqw2fzqVZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U39RhNzhw86FX7TUZeyihzoLCO/uGVd0WoRPHvuXB8BHeSkazDP3iheirj60YkobDEpqkvxgB0l9H/Lc+gEKt0daqp7ISt+ToYFLbdc5FRX0UfkVyXLiTFXcjADfkd9/E/Y1Tt1z4LMGcai5w1FKGnnyKD2e2eS8mCc8z3kTYLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c2pY3Q60; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PKyKaGFX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c2pY3Q60; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PKyKaGFX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4135121A0B;
	Mon, 13 Oct 2025 11:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760355139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OJD2D5sOD1UwFVRnLiisA06ok66jFshkpFT7U5auYaU=;
	b=c2pY3Q60rdySkJnHio1esw2RtxdDS1I/ROgZuToYDooNtM5rlAyGD3QtN3IG5Biyk9zkDd
	okc+vn2gfnqpE+l51QceqRYB1D59POM0BcYhL7iEbOXycj1ovhLT9DyS1f8xJx6reFNUId
	CuxNanTwAusOc1HkfPI2SLlSS1FzxMY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760355139;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OJD2D5sOD1UwFVRnLiisA06ok66jFshkpFT7U5auYaU=;
	b=PKyKaGFXDxUdTiiurMffn9aZFLjkmr8MgiOPS9YDScwKazJYvsQqAb+UV2lM1fMEPkFYXF
	1HdhYBXBMD1JZjAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760355139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OJD2D5sOD1UwFVRnLiisA06ok66jFshkpFT7U5auYaU=;
	b=c2pY3Q60rdySkJnHio1esw2RtxdDS1I/ROgZuToYDooNtM5rlAyGD3QtN3IG5Biyk9zkDd
	okc+vn2gfnqpE+l51QceqRYB1D59POM0BcYhL7iEbOXycj1ovhLT9DyS1f8xJx6reFNUId
	CuxNanTwAusOc1HkfPI2SLlSS1FzxMY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760355139;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OJD2D5sOD1UwFVRnLiisA06ok66jFshkpFT7U5auYaU=;
	b=PKyKaGFXDxUdTiiurMffn9aZFLjkmr8MgiOPS9YDScwKazJYvsQqAb+UV2lM1fMEPkFYXF
	1HdhYBXBMD1JZjAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 327D61374A;
	Mon, 13 Oct 2025 11:32:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C3H+C0Pj7GgJZwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 13 Oct 2025 11:32:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CD496A0A58; Mon, 13 Oct 2025 13:32:03 +0200 (CEST)
Date: Mon, 13 Oct 2025 13:32:03 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org, 
	v9fs@lists.linux.dev, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
	ocfs2-devel@lists.linux.dev, linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 01/10] mm: don't opencode filemap_fdatawrite_range in
 filemap_invalidate_inode
Message-ID: <wxziorjgzpc5nlktnl53ctsroriqvwjkuvwsgznl63oeid4cvp@p7mkzimdgltg>
References: <20251013025808.4111128-1-hch@lst.de>
 <20251013025808.4111128-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013025808.4111128-2-hch@lst.de>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Mon 13-10-25 11:57:56, Christoph Hellwig wrote:
> Use filemap_fdatawrite_range instead of opencoding the logic using
> filemap_fdatawrite_wbc.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/filemap.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 13f0259d993c..99d6919af60d 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -4457,16 +4457,8 @@ int filemap_invalidate_inode(struct inode *inode, bool flush,
>  	unmap_mapping_pages(mapping, first, nr, false);
>  
>  	/* Write back the data if we're asked to. */
> -	if (flush) {
> -		struct writeback_control wbc = {
> -			.sync_mode	= WB_SYNC_ALL,
> -			.nr_to_write	= LONG_MAX,
> -			.range_start	= start,
> -			.range_end	= end,
> -		};
> -
> -		filemap_fdatawrite_wbc(mapping, &wbc);
> -	}
> +	if (flush)
> +		filemap_fdatawrite_range(mapping, start, end);
>  
>  	/* Wait for writeback to complete on all folios and discard. */
>  	invalidate_inode_pages2_range(mapping, start / PAGE_SIZE, end / PAGE_SIZE);
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

