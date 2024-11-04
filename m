Return-Path: <linux-fsdevel+bounces-33597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4419BB2AB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 12:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6EEA1F2259F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 11:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428EF1C9DC8;
	Mon,  4 Nov 2024 10:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="08jLTSmG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Fo0ezgy4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="08jLTSmG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Fo0ezgy4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944E01B6CF5;
	Mon,  4 Nov 2024 10:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717835; cv=none; b=qBPAo3tKbPfeMnNox6XQxW2ZbcQk1YFV+LbStDLX3yuIP1+8P4h1gmPZwe7GsAr6GgTiwyHFFiAm2Euw2huTkQGMvXzX4cg8sCmOY9+DmDJ3P7JVcPlLp4s0f7y6LGp4sz6hE/zwGP1dtMUO/WdR4iXYq7YrM78mtoQ6ymkmKhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717835; c=relaxed/simple;
	bh=UPzlo2d9vGTBJpHoau13kgCUyWgH1napUQb+/vB/Dcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OoP58j4lHyOHb2oIMers2LTY1GBOgrCbewc3+RYI/aDYtI4dIar9Jfg7fNuPqWEwhwMUZnArYfFMHCzS7Ay37QYkdZME4qLByryb4dSQNFhntDLOi9dZRrXci3OMEZahBBB0mAu4/8/IhVw/R3plE2qbEPIWfy0GOEnJqrZLw30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=08jLTSmG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Fo0ezgy4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=08jLTSmG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Fo0ezgy4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C8F5F1F45F;
	Mon,  4 Nov 2024 10:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730717831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IYRQrdsu06X+bjARk5dkS+tv7CJXY6E5nc3x053oWO0=;
	b=08jLTSmGyqORhZ1ZZxcaE4ZOS8tqlHEW5TeUVQrGc6Kr/1a15fJY2tyWnPX6KKr2JVOEa+
	S3CBQ0P5ulmUUAJbmahNS0Y+aGmdU1h/1UKW7cXaPw1wwq62gWHBjPB06gzaHPAXyGqXmP
	F7jLtX6e/B6son4umaU/bsKMvtc946Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730717831;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IYRQrdsu06X+bjARk5dkS+tv7CJXY6E5nc3x053oWO0=;
	b=Fo0ezgy4tRYrOrY/8CD3r1r8knyd2MEdiFENBvHKadCaE/FbmB8OpSO2esg+niHceiTmpW
	m2xPlayNP7F1vbBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730717831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IYRQrdsu06X+bjARk5dkS+tv7CJXY6E5nc3x053oWO0=;
	b=08jLTSmGyqORhZ1ZZxcaE4ZOS8tqlHEW5TeUVQrGc6Kr/1a15fJY2tyWnPX6KKr2JVOEa+
	S3CBQ0P5ulmUUAJbmahNS0Y+aGmdU1h/1UKW7cXaPw1wwq62gWHBjPB06gzaHPAXyGqXmP
	F7jLtX6e/B6son4umaU/bsKMvtc946Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730717831;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IYRQrdsu06X+bjARk5dkS+tv7CJXY6E5nc3x053oWO0=;
	b=Fo0ezgy4tRYrOrY/8CD3r1r8knyd2MEdiFENBvHKadCaE/FbmB8OpSO2esg+niHceiTmpW
	m2xPlayNP7F1vbBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB3D213736;
	Mon,  4 Nov 2024 10:57:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id e9WvLYeoKGdCOgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 04 Nov 2024 10:57:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6A564A0AFB; Mon,  4 Nov 2024 11:57:11 +0100 (CET)
Date: Mon, 4 Nov 2024 11:57:11 +0100
From: Jan Kara <jack@suse.cz>
To: Asahi Lina <lina@asahilina.net>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Sergio Lopez Pascual <slp@redhat.com>,
	linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH] dax: Allow block size > PAGE_SIZE
Message-ID: <20241104105711.mqk4of6frmsllarn@quack3>
References: <20241101-dax-page-size-v1-1-eedbd0c6b08f@asahilina.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101-dax-page-size-v1-1-eedbd0c6b08f@asahilina.net>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Fri 01-11-24 21:22:31, Asahi Lina wrote:
> For virtio-dax, the file/FS blocksize is irrelevant. FUSE always uses
> large DAX blocks (2MiB), which will work with all host page sizes. Since
> we are mapping files into the DAX window on the host, the underlying
> block size of the filesystem and its block device (if any) are
> meaningless.
> 
> For real devices with DAX, the only requirement should be that the FS
> block size is *at least* as large as PAGE_SIZE, to ensure that at least
> whole pages can be mapped out of the device contiguously.
> 
> Fixes warning when using virtio-dax on a 4K guest with a 16K host,
> backed by tmpfs (which sets blksz == PAGE_SIZE on the host).
> 
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---
>  fs/dax.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Well, I don't quite understand how just relaxing the check is enough. I
guess it may work with virtiofs (I don't know enough about virtiofs to
really tell either way) but for ordinary DAX filesystem it would be
seriously wrong if DAX was used with blocksize > pagesize as multiple
mapping entries could be pointing to the same PFN which is going to have
weird results. If virtiofs can actually map 4k subpages out of 16k page on
host (and generally perform 4k granular tracking etc.), it would seem more
appropriate if virtiofs actually exposed the filesystem 4k block size instead
of 16k blocksize? Or am I missing something?

								Honza

> diff --git a/fs/dax.c b/fs/dax.c
> index c62acd2812f8d4981aaba82acfeaf972f555362a..406fb75bdbe9d17a6e4bf3d4cb92683e90f05910 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1032,7 +1032,7 @@ int dax_writeback_mapping_range(struct address_space *mapping,
>  	int ret = 0;
>  	unsigned int scanned = 0;
>  
> -	if (WARN_ON_ONCE(inode->i_blkbits != PAGE_SHIFT))
> +	if (WARN_ON_ONCE(inode->i_blkbits < PAGE_SHIFT))
>  		return -EIO;
>  
>  	if (mapping_empty(mapping) || wbc->sync_mode != WB_SYNC_ALL)
> 
> ---
> base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e
> change-id: 20241101-dax-page-size-83a1073b4e1b
> 
> Cheers,
> ~~ Lina
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

