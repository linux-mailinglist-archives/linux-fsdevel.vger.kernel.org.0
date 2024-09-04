Return-Path: <linux-fsdevel+bounces-28512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD5296B82E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 12:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 912CCB256C6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 10:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEE41CF7B7;
	Wed,  4 Sep 2024 10:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ltiFGBtl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fJY2n5VT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VeSx0szL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5/kEvgzO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A471CF5F4;
	Wed,  4 Sep 2024 10:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445267; cv=none; b=XzWGzOrrvcn5TcavGAAc49lapQZtYH3uEmlwnQYGTKH5vqOW78Kprwu6M7golGUYd/toi0Wa7Ymf9jKDSbcG03yp3O4EbaNpbzvpbx37YmYiyI00Sd05QUs1EWz3nK6kuzQ/JJa/suDlililJ5rLAC3b/JrK8cckAaQ+PNdytAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445267; c=relaxed/simple;
	bh=QXGchwXHXE5193TvoORSwDV3lTt5vdf4As4ycADyV/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kn4Ss59P9oO0xxjyvD9htKdqU66yWD/H0xF6hrUE697oJUUGGYMO5dhHs0Qb/FNxh26+Jwh8W9wywyUeiGoZlPvnE7FhibbyyfSe1e+udKb0VM98yedq4bohbYfpNau9DS9P4yCpkIt2/4PwBqfeC2fjJ9C1ogI0xActTi3hdK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ltiFGBtl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fJY2n5VT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VeSx0szL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5/kEvgzO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ECC0F21A08;
	Wed,  4 Sep 2024 10:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725445264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PGIias3wEFd2drZsmekiW4yI0CWUsTQUKkrhMikaxEc=;
	b=ltiFGBtlV/ezAl0hOWATRn3FD3Y+lee/VhfMXiIsDpPwjchs48zioLZbirzAPPGjpG13wP
	3NPaThtJGpz6OU8cZjk79cTKmE1xNBdTG7Z4asehxgqsn+yoCjV+4mrWHVWc0mFCZ2nIht
	K2x2bx1AqmUm9ScxhNRib5PGs/ZkWjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725445264;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PGIias3wEFd2drZsmekiW4yI0CWUsTQUKkrhMikaxEc=;
	b=fJY2n5VTDGs+nvNy74oOnbewz6R7ZmMIvIdcxPUX/4UbKr5oropVDt+tpsREqFYWixVtTV
	tOYR5BklDeGURiAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725445263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PGIias3wEFd2drZsmekiW4yI0CWUsTQUKkrhMikaxEc=;
	b=VeSx0szLzOiO7OKrEG5j3YwBH7QYu2tdGvCIArmfBRM9rCC74i5/L0JPwGL7fjHAtR/GqP
	b1piDtFPxTaRdHRiz5KT3CI1rzcdlCbFeo5mXDXmm0WMcB+dVNPH+vrZjcGjMYVPXLZ9pn
	06oFzUqL+0EJV548tbYb6/pCEFhZf24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725445263;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PGIias3wEFd2drZsmekiW4yI0CWUsTQUKkrhMikaxEc=;
	b=5/kEvgzOUK5ZDSCA7ujh2S8rfj8QxkA0vhsvlPUgHcZo5vTwtdPM2/cMzNwTUaJ61adkPJ
	Ca8LBVk4ARK0a8DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E0E74139D2;
	Wed,  4 Sep 2024 10:21:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 90DgNo802GYOJwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Sep 2024 10:21:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 92034A0968; Wed,  4 Sep 2024 12:21:03 +0200 (CEST)
Date: Wed, 4 Sep 2024 12:21:03 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v3 05/12] ext4: passing block allocation information to
 ext4_es_insert_extent()
Message-ID: <20240904102103.3lss7s5yxavcnjwm@quack3>
References: <20240813123452.2824659-1-yi.zhang@huaweicloud.com>
 <20240813123452.2824659-6-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813123452.2824659-6-yi.zhang@huaweicloud.com>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 13-08-24 20:34:45, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Just pass the block allocation flag to ext4_es_insert_extent() when we
> replacing a current extent after an actually block allocation or extent
> status conversion, this flag will be used by later changes.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Just one suggestion below. With that feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> @@ -848,7 +848,7 @@ static int __es_insert_extent(struct inode *inode, struct extent_status *newes,
>   */
>  void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>  			   ext4_lblk_t len, ext4_fsblk_t pblk,
> -			   unsigned int status)
> +			   unsigned int status, int flags)

Since you pass flags to ext4_es_insert_extent() only from one place, let's
not pretend these are always full mapping flags and just make this new
argument:

bool delalloc_reserve_used

and from ext4_map_blocks_create() you can pass flags &
EXT4_GET_BLOCKS_DELALLOC_RESERVE.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

