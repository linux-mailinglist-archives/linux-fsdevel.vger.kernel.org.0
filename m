Return-Path: <linux-fsdevel+bounces-75768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sD8FM2U/emlB4wEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:55:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3CBA658F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2930730EE9AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 16:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848B03148D3;
	Wed, 28 Jan 2026 16:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ui6CV3FH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ik74xksu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sgWAWt8x";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BEKDCUeC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADD7313295
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 16:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769617364; cv=none; b=ucATvgfrzmfYy1TVphLkEY1aOvfaAu4IOOTjSHI/dFC59fxgNeLDaHfFOHENN4q0KUzD5FTB6SKVP31MjL0fWH1iS8ySpcolOlXeL6h7xsXStABV8FVvdcfC7/fe+5E5woPUqDLSty7hP7WiBMwl2IUY9lhZG79Jc/pZRfAq5fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769617364; c=relaxed/simple;
	bh=fDFjeDMfv4KG7xodCbiiUiINc8A6rrrHvZNEJe5Nwo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJhvPWWj6hjEHts/M2LUmfiHTw+WSe1c9kbV8O2zUhQ4l5pXP2l4SZYhMgqipjyjR5z/inMWRcQ880UdCP/bqWyB3TPoA9LIcQRmQJ/AGjRQtxi2SK4HvRlkXdlJ4Zx6j0LepxdBysWslClq7ip/NPVYZIm6At04cBgq2nKwzb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ui6CV3FH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ik74xksu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sgWAWt8x; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BEKDCUeC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CFAD333C83;
	Wed, 28 Jan 2026 16:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769617361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RQfvrO2r2koAtgaVFyVs2Mrkyfu60zaLnTdUlkhYI7M=;
	b=Ui6CV3FH/KxDSF/5ja5t2MsKUnAZYTTeziPU5f6iKwIH/qQGrwbczuX+sHPBOGl5uNaEuM
	D7KzUfbqOE1/EmmudxqNg4Jpkp3XBAaVArh1/4C2CbP5aJIrm7pBOB8ZCdU0e7pJyBEKY4
	DaXz+D0M9X7plxlRfOxxu683e+3y8Cw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769617361;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RQfvrO2r2koAtgaVFyVs2Mrkyfu60zaLnTdUlkhYI7M=;
	b=ik74xksuK1Swa76hpFuvgO1ma5IxWOxyu8IPe3dEuVhq/W5L09K8ey9Jw0egG0013g0QgU
	ALbhZKX2SGjGYNBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sgWAWt8x;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=BEKDCUeC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769617360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RQfvrO2r2koAtgaVFyVs2Mrkyfu60zaLnTdUlkhYI7M=;
	b=sgWAWt8xGz3/GzrEQN7xXngdxyj1iMH/vNMkaxck3Nnan1jfGf//gFzktfpqg3PGCaAhkD
	n/VqnMcLPMyHJ8SSsdB7/n7AJ0rFH9Q/hNI4Vc55g1xiw3MaQzrkBLb27zklGSG9hjVScU
	IGfZp9QfN+/v2KUNQCgU9cZvsDGqt1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769617360;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RQfvrO2r2koAtgaVFyVs2Mrkyfu60zaLnTdUlkhYI7M=;
	b=BEKDCUeCMd3NqMpdY+ygxtb4gGYcPbFG0ucarv7+0x309fB40rzWEBvnObakRLlqHn0iVV
	D7l6q26wWoZzyNCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB4763EA61;
	Wed, 28 Jan 2026 16:22:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ku+zLdA3emlMcQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 28 Jan 2026 16:22:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 74345A06AC; Wed, 28 Jan 2026 17:22:36 +0100 (CET)
Date: Wed, 28 Jan 2026 17:22:36 +0100
From: Jan Kara <jack@suse.cz>
To: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs: dcache: fix typo in enum d_walk_ret comment
Message-ID: <6eysg7ylje35of4z6hjkx4m5xbclll7tpmyy5tzegrvpejdfg6@eqean3xckhs4>
References: <20260128143150.3674284-1-chelsyratnawat2001@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128143150.3674284-1-chelsyratnawat2001@gmail.com>
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.cz:email,suse.cz:dkim];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-75768-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2C3CBA658F
X-Rspamd-Action: no action

On Wed 28-01-26 06:31:50, Chelsy Ratnawat wrote:
> Fix minor spelling and indentation errors in the
> documentation comments.
> 
> Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/dcache.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 66dd1bb830d1..f995c25fb52b 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -1298,8 +1298,8 @@ void shrink_dcache_sb(struct super_block *sb)
>  EXPORT_SYMBOL(shrink_dcache_sb);
>  
>  /**
> - * enum d_walk_ret - action to talke during tree walk
> - * @D_WALK_CONTINUE:	contrinue walk
> + * enum d_walk_ret - action to take during tree walk
> + * @D_WALK_CONTINUE:	continue walk
>   * @D_WALK_QUIT:	quit walk
>   * @D_WALK_NORETRY:	quit when retry is needed
>   * @D_WALK_SKIP:	skip this dentry and its children
> @@ -1722,7 +1722,7 @@ void d_invalidate(struct dentry *dentry)
>  EXPORT_SYMBOL(d_invalidate);
>  
>  /**
> - * __d_alloc	-	allocate a dcache entry
> + * __d_alloc - allocate a dcache entry
>   * @sb: filesystem it will belong to
>   * @name: qstr of the name
>   *
> @@ -1806,7 +1806,7 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
>  }
>  
>  /**
> - * d_alloc	-	allocate a dcache entry
> + * d_alloc - allocate a dcache entry
>   * @parent: parent of entry to allocate
>   * @name: qstr of the name
>   *
> @@ -2546,7 +2546,7 @@ static void __d_rehash(struct dentry *entry)
>  }
>  
>  /**
> - * d_rehash	- add an entry back to the hash
> + * d_rehash - add an entry back to the hash
>   * @entry: dentry to add to the hash
>   *
>   * Adds a dentry to the hash according to its name.
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

