Return-Path: <linux-fsdevel+bounces-27554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FFC962563
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 13:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 399691F21AAD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 11:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECD216CD2C;
	Wed, 28 Aug 2024 10:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="q5X1XgI/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eRsAVgW4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="q5X1XgI/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eRsAVgW4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C8616C683
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 10:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724842791; cv=none; b=T3JOPxOEE1k8OP+RS11YgwfDEqhOfwOehd/OlJ9DAcmgyk8Lw+dcV3liyP5aKUyRxkaoqFZhJ+PbpkiwVlFXyKNRFPJGcVVM/ubQQt1yQJRAwbH7v87P1en9JKq3cFw54SIA7Y52SRm7htWFk0xck3Pl2PQ7hFGXqMJwSp+E57M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724842791; c=relaxed/simple;
	bh=7pHjnyplGuM3DWCAykKlukTOxPYu8E7ma5ZZBg72Ud0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NoqRg9p5XLVX6ZSGC6u8mzX1Kxfa4tV7N7iVumnvVu+FgETToNSdQyji73K7e5QB+gN2vG4CzPCV8sP8WOd3gasubm45T0ucJyS9wxTYI6MQEPfgV3TB4qavCgCep4BqSgNsbicl/N7Mt2WsDF8gs/t4ZO6M3XhZJRPlKeTQA20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=q5X1XgI/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eRsAVgW4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=q5X1XgI/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eRsAVgW4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C2E001FBED;
	Wed, 28 Aug 2024 10:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724842787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fdA0AFOw222/kzqfkJjH8oZ/u+bLDavCpvU1ZTFIHFE=;
	b=q5X1XgI/LG5vUVhTaypqYhg1csY3MqgsqDnh2gEcKraeIPKYzkK6uHAPLDQB/CB/wlgOIB
	mLpEWA/RV3aUHI48/AUJRHRD0HJEkyd/700K0cBWHTlzXzumLksu0iukXHdqlUdvZvqRDJ
	jSkw9SrUAVHrBHxkjMKfk0AS1yhV0fI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724842787;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fdA0AFOw222/kzqfkJjH8oZ/u+bLDavCpvU1ZTFIHFE=;
	b=eRsAVgW42ShvZdlI2M2a0bgoHvpjkdQLshhuwtZTxRDYfLIBk9odnyRE9+9wqNQdriiE8i
	0A0uAsXv9G3z7BBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724842787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fdA0AFOw222/kzqfkJjH8oZ/u+bLDavCpvU1ZTFIHFE=;
	b=q5X1XgI/LG5vUVhTaypqYhg1csY3MqgsqDnh2gEcKraeIPKYzkK6uHAPLDQB/CB/wlgOIB
	mLpEWA/RV3aUHI48/AUJRHRD0HJEkyd/700K0cBWHTlzXzumLksu0iukXHdqlUdvZvqRDJ
	jSkw9SrUAVHrBHxkjMKfk0AS1yhV0fI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724842787;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fdA0AFOw222/kzqfkJjH8oZ/u+bLDavCpvU1ZTFIHFE=;
	b=eRsAVgW42ShvZdlI2M2a0bgoHvpjkdQLshhuwtZTxRDYfLIBk9odnyRE9+9wqNQdriiE8i
	0A0uAsXv9G3z7BBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B0718138D2;
	Wed, 28 Aug 2024 10:59:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0uoZKyMDz2ZrdAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 28 Aug 2024 10:59:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3307BA0968; Wed, 28 Aug 2024 12:59:39 +0200 (CEST)
Date: Wed, 28 Aug 2024 12:59:39 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs: remove unused path_put_init()
Message-ID: <20240828105939.wzjll4km2gqq7kzs@quack3>
References: <20240822-bewuchs-werktag-46672b3c0606@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822-bewuchs-werktag-46672b3c0606@brauner>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Thu 22-08-24 11:28:38, Christian Brauner wrote:
> This helper has been unused for a while now.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Yup. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Goes into vfs.misc unless I hear complaints.
> ---
>  include/linux/path.h | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/include/linux/path.h b/include/linux/path.h
> index ca073e70decd..7ea389dc764b 100644
> --- a/include/linux/path.h
> +++ b/include/linux/path.h
> @@ -18,12 +18,6 @@ static inline int path_equal(const struct path *path1, const struct path *path2)
>  	return path1->mnt == path2->mnt && path1->dentry == path2->dentry;
>  }
>  
> -static inline void path_put_init(struct path *path)
> -{
> -	path_put(path);
> -	*path = (struct path) { };
> -}
> -
>  /*
>   * Cleanup macro for use with __free(path_put). Avoids dereference and
>   * copying @path unlike DEFINE_FREE(). path_put() will handle the empty
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

