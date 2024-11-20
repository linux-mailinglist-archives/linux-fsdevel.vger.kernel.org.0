Return-Path: <linux-fsdevel+bounces-35334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 364019D400B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 17:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5005B32D7D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 15:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0211A14601C;
	Wed, 20 Nov 2024 15:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JvPVwTtd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GDl/w4KP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZRaT9ur+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tIemCaNb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E0B24B28;
	Wed, 20 Nov 2024 15:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732117492; cv=none; b=IMddHgWZsMzHk4q1Z+glPUL7kxwrCzzBZOE97K9FoJmWBehANbl2pDyVZozOKtVwhT0/Jh+e/jJLeBqygz2I6KNDDyEw8fyKnQCPMs8st7e1bpEqWzcX9DBi63poqgUbijE7hUcieQbUWnkzTAcNrs64ukpJeofnLI5VGYUM28w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732117492; c=relaxed/simple;
	bh=vdTxX2YuKU95fz9NIU7I0rXE9Xh1OSWG3TAF4nxWTTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrUOPlrFwn0+HDfw46hgiKGnbbFkPUmnNm3ugZDSa/d7294qUSY4DeA0nmvHgTYXDnIYz6cyQwml8pgqpb3n6g5tS7dxT3Pt2AB4A8OrxPXd44jJammrp2gvJuZqDPcaSs1CnM8e9qH/WPvMfVBBnyRHNN4u6k7g51vmaxVQWKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JvPVwTtd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GDl/w4KP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZRaT9ur+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tIemCaNb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D890E21851;
	Wed, 20 Nov 2024 15:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732117489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fj7fJmtXRZ0FYhZKsaGUvpP5NpR+kcXv8aPZO9BcWjs=;
	b=JvPVwTtd+MbQta7TYhE3Ky1Ptg76578DHL7fgJRnuwS7+EsjvTqcU9i6o/WXzmJeE8/N95
	JTJEubWc7cKSXekkbiWLr+8QeuQdxF+/wJiMi6nwYwC5pWCC0UzVWiJe+/xVjkJvFm102q
	QPn0uqXaz5J8MFw/Gyn1KBh6Ri7hPJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732117489;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fj7fJmtXRZ0FYhZKsaGUvpP5NpR+kcXv8aPZO9BcWjs=;
	b=GDl/w4KP2hGUTusRS1+ZfEgiwAUkAFE7fTbWakvs4pkVQ/H47OQoRNBfl3lIN48Yb5kSaR
	2U98Oty+38009eBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZRaT9ur+;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=tIemCaNb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732117488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fj7fJmtXRZ0FYhZKsaGUvpP5NpR+kcXv8aPZO9BcWjs=;
	b=ZRaT9ur+uK+GrsNe98Ae5xAKSdHwwjOYsXnh6vWZb1aFjfSwIzfHP/4a4g/pdKEw75/OyK
	zJBz4RsXJKCF3N028EuaJAmy61D/hRCHFNWsNjv68myNwsg10F19QCy9B6e6aEUCOngJlp
	Vhu6nqNIAHlv6S9h2ahehApZHEML1mE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732117488;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fj7fJmtXRZ0FYhZKsaGUvpP5NpR+kcXv8aPZO9BcWjs=;
	b=tIemCaNb8aws/6zZYsoCT7z2+fWPQLWYSWUcsZXfzESgYYnxicFjdPaZoU4OwfyQCt+kQR
	+VBn1euU5mRMU2Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C9BF113297;
	Wed, 20 Nov 2024 15:44:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /Og8MfADPmfhSAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 20 Nov 2024 15:44:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 80F8CA08A2; Wed, 20 Nov 2024 16:44:48 +0100 (CET)
Date: Wed, 20 Nov 2024 16:44:48 +0100
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	amir73il@gmail.com, brauner@kernel.org,
	torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v8 13/19] fanotify: add a helper to check for pre content
 events
Message-ID: <20241120154448.onc2q5rsusfs4zsm@quack3>
References: <cover.1731684329.git.josef@toxicpanda.com>
 <657f50e37d6d8f908c13f652129bcdd34ed7f4a9.1731684329.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <657f50e37d6d8f908c13f652129bcdd34ed7f4a9.1731684329.git.josef@toxicpanda.com>
X-Rspamd-Queue-Id: D890E21851
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,vger.kernel.org,suse.cz,gmail.com,kernel.org,linux-foundation.org,zeniv.linux.org.uk,kvack.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Fri 15-11-24 10:30:26, Josef Bacik wrote:
> From: Amir Goldstein <amir73il@gmail.com>
> 
> We want to emit events during page fault, and calling into fanotify
> could be expensive, so add a helper to allow us to skip calling into
> fanotify from page fault.  This will also be used to disable readahead
> for content watched files which will be handled in a subsequent patch.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  include/linux/fsnotify.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index 08893429a818..d5a0d8648000 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -178,6 +178,11 @@ static inline void file_set_fsnotify_mode(struct file *file)
>  	}
>  }
>  
> +static inline bool fsnotify_file_has_pre_content_watches(struct file *file)
> +{
> +	return file && unlikely(FMODE_FSNOTIFY_HSM(file->f_mode));
> +}
> +

I was pondering about this and since we are trying to make these quick
checks more explicit, I'll probably drop this helper. Also the 'file &&'
part looks strange (I understand page_cache_[a]sync_ra() need it but I'd
rather handle it explicitely there).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

