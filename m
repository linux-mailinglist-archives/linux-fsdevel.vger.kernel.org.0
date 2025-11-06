Return-Path: <linux-fsdevel+bounces-67271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F95C39DDA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 10:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B5C8E3507F0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 09:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7BD30C636;
	Thu,  6 Nov 2025 09:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1yq/6pjQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="skSLr3o4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="j/bcGhWZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wlGTWKG3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8E130C611
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 09:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762422236; cv=none; b=ieCnvvraKLf6oe2UKRvLbDSq9tEqpyEXlNkCloEUcnny5iHXwkqr+FQD5YHz0PknCNj0puRrbs55Ta3vp1YqJ9eaqwSWoYC5FHY2mdJuMIaiXEkE4l5JHswq78drxY/tXJsrBPRU8iF8BEJNgfUI2yQyID4wwt9BzJwOCcidUDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762422236; c=relaxed/simple;
	bh=JXyGrB/YmwW+T9kJMtY2qQIXEPyBT69mdj/IwEiHzSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kO/tKwj7b8dajyouW7f0esDw+/HmEF+ECybGL2BC0f03hYlPAqbI9/3udjhNHPCD/6x4ldCNmWQ1gANlrRxirlUR7LEnzRV1goh5kcHucWkNrfHm8ZVIQznN9cCx8t8lSQEz31JPW9e128IlZ+djmDUh3kVEFisK+SOvOjjTOxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1yq/6pjQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=skSLr3o4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=j/bcGhWZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wlGTWKG3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DED9E211C4;
	Thu,  6 Nov 2025 09:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762422233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mRLXmyuGKJItkOrRiiEvUPcNtUAWALiHEih+p270pb8=;
	b=1yq/6pjQvQBeKq2qOaInNpS9utsm+ekOzMuQBeQCDIEqP8IAvfuBCtsyXFIcU5oHh861tD
	kIARYaIL21WR3s3i9UdD440AcABsPFZfk1OguB/hwDUqXPWdnKB0qzAS+bi+KRBIVFNDeg
	DK40WORa57a1k5MtVzIrKoO3mPVC+4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762422233;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mRLXmyuGKJItkOrRiiEvUPcNtUAWALiHEih+p270pb8=;
	b=skSLr3o4U4JHci7AofgxD1FkMjBm9WW2UORyojEqRI8Ys8PJ4sryHJBBQTZfJBJl77s0SP
	kVcWRkT9N7FBA+CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762422232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mRLXmyuGKJItkOrRiiEvUPcNtUAWALiHEih+p270pb8=;
	b=j/bcGhWZakKIwOKsHkyFkp8yjU5jR6aAdSxT9fnlBA3utVIfHdhtRpuAskGXn32OTaV9Tg
	p0+Q7kd0gSuee/8SJRDJv0Kv/wPD5GkcA88zdzUSd+rBh45KdGVY4A5EccoT7/aXj5KSlm
	HCH8Bi55zxEDKsbo6UcnOwCrQ6RhU4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762422232;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mRLXmyuGKJItkOrRiiEvUPcNtUAWALiHEih+p270pb8=;
	b=wlGTWKG34paZxiU0p52CD0g8xDZPsCwGr7nt1zhaej96wZ+VziEGc+gK6oYLTMpIpWfN3/
	hyi6Avv0/uTApuBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D042F139A9;
	Thu,  6 Nov 2025 09:43:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iL/TMthtDGnpJAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 06 Nov 2025 09:43:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 81E2CA0948; Thu,  6 Nov 2025 10:43:52 +0100 (CET)
Date: Thu, 6 Nov 2025 10:43:52 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: mic@digikod.net, brauner@kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	eadavis@qq.com, gnoack@google.com, jack@suse.cz, jannh@google.com, 
	max.kellermann@ionos.com, m@maowtm.org, 
	syzbot+12479ae15958fc3f54ec@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] fs: add iput_not_last()
Message-ID: <ppbhsfpqvbhktqrpro4y6qsbx44utxombpgqgfyhttq4ve3pge@zapn5bpuamtz>
References: <20251105212025.807549-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105212025.807549-1-mjguzik@gmail.com>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[12479ae15958fc3f54ec];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,qq.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[digikod.net,kernel.org,vger.kernel.org,zeniv.linux.org.uk,qq.com,google.com,suse.cz,ionos.com,maowtm.org,syzkaller.appspotmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 

On Wed 05-11-25 22:20:24, Mateusz Guzik wrote:
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

I guess better than giving up the common might_sleep() annotation. Feel
free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

One nit below:

> +/**
> + *	iput_not_last	- put an inode assuming this is not the last reference
> + *	@inode: inode to put
> + */
> +void iput_not_last(struct inode *inode)
> +{

Standard iput() silently does nothing for NULL inode. I'm undecided whether
it belongs here or not. It might be convenient for some error handling
paths but OTOH if you are confident you hold a reference then inode should
better not be NULL...

								Honza

> +	VFS_BUG_ON_INODE(atomic_read(&inode->i_count) < 2, inode);
> +
> +	WARN_ON(atomic_sub_return(1, &inode->i_count) == 0);
> +}
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

