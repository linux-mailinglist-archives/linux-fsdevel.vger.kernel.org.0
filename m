Return-Path: <linux-fsdevel+bounces-40932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAFDA295F4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 17:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F0B73A5D86
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 16:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27D81D7E31;
	Wed,  5 Feb 2025 16:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DkBKpdR2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aGpKqCS5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DkBKpdR2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aGpKqCS5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A62C19B586;
	Wed,  5 Feb 2025 16:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738771940; cv=none; b=MDxI9U5YYlvnkGsD/57BwvLgZo+ojcoUwG/wELKu+rq0RHNK1usT3NZB24n9QdG6WSuu66kBVSuMOBIQcrQG78JDzefWbqC8DJbdJDaYRb06kb9OdPwOEoXBJ6g8oYt8VGg+SmYCH0Gwb0O/VsG3ShldLkDgftqBb89512MQzn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738771940; c=relaxed/simple;
	bh=UPvva8UySUv3LbJvI8jOukkXOQRpra4CCHNVWdkZbgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hf/PVYbdoyMjeyhcGRe6D6SnVTKbEfE58ESCp3mwToo/mA/1iCC8x/Ler2I8Gfc+SuzrYpRILG1xxeLlBf1+qsN2RlvnICfSePJfA8clLR0j3RThJWQzYNCl/tBrArhcngA3/RmA5FCdMcIjWhEpLEV7gJd8+32X8/qWwZNMjR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DkBKpdR2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aGpKqCS5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DkBKpdR2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aGpKqCS5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3B637211C4;
	Wed,  5 Feb 2025 16:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738771936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/xa3z4SbY0t10iOkUN4r39gpvPVCZNo5zEIDaAsO3+E=;
	b=DkBKpdR2RYVfycypNkVqWkSOglhlmHgTIh+yO4pbzQQp4mqX0MFAHtCuOq4l1hMyjlx9/i
	+QuT0HuPObabJkeSVfi6zkKzvRpyL9Oa6p4wZSb/rgDYbyUWcjAeOE/2MV49LKTNlrBrq1
	aa0+nOif378ygStV/hatgFwCwfsAUig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738771936;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/xa3z4SbY0t10iOkUN4r39gpvPVCZNo5zEIDaAsO3+E=;
	b=aGpKqCS5ESnOkTkGq5WmLmL/qaUbh8+bVi7sA872UO+x3FHhLjUBVSvplqMaNmxn2CFhNZ
	DziaJkKuG/+Zx1DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738771936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/xa3z4SbY0t10iOkUN4r39gpvPVCZNo5zEIDaAsO3+E=;
	b=DkBKpdR2RYVfycypNkVqWkSOglhlmHgTIh+yO4pbzQQp4mqX0MFAHtCuOq4l1hMyjlx9/i
	+QuT0HuPObabJkeSVfi6zkKzvRpyL9Oa6p4wZSb/rgDYbyUWcjAeOE/2MV49LKTNlrBrq1
	aa0+nOif378ygStV/hatgFwCwfsAUig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738771936;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/xa3z4SbY0t10iOkUN4r39gpvPVCZNo5zEIDaAsO3+E=;
	b=aGpKqCS5ESnOkTkGq5WmLmL/qaUbh8+bVi7sA872UO+x3FHhLjUBVSvplqMaNmxn2CFhNZ
	DziaJkKuG/+Zx1DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2EB9313694;
	Wed,  5 Feb 2025 16:12:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id M3VfC+CNo2d1MQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 05 Feb 2025 16:12:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B39C9A28E9; Wed,  5 Feb 2025 17:12:15 +0100 (CET)
Date: Wed, 5 Feb 2025 17:12:15 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: sanity check the length passed to
 inode_set_cached_link()
Message-ID: <zatx4ddmdvymae4454vrpci642gecbq4l6iuv4u64tssixeplc@h6rimv2lhicg>
References: <20250204213207.337980-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204213207.337980-1-mjguzik@gmail.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 04-02-25 22:32:07, Mateusz Guzik wrote:
> This costs a strlen() call when instatianating a symlink.
> 
> Preferably it would be hidden behind VFS_WARN_ON (or compatible), but
> there is no such facility at the moment. With the facility in place the
> call can be patched out in production kernels.
> 
> In the meantime, since the cost is being paid unconditionally, use the
> result to a fixup the bad caller.
> 
> This is not expected to persist in the long run (tm).
> 
> Sample splat:
> bad length passed for symlink [/tmp/syz-imagegen43743633/file0/file0] (got 131109, expected 37)
> [rest of WARN blurp goes here]
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Yeah, it looks a bit pointless to pass the length in only to compare it
against strlen(). But as a quick fix until we figure out something more
clever it's fine I guess.

Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> This has a side effect of working around the panic reported in:
> https://lore.kernel.org/all/67a1e1f4.050a0220.163cdc.0063.GAE@google.com/
> 
> I'm confident this merely exposed a bug in ext4, see:
> https://lore.kernel.org/all/CAGudoHEv+Diti3r0x9VmF5ixgRVKk4trYnX_skVJNkQoTMaDHg@mail.gmail.com/#t
> 
> Nonethelss, should help catch future problems.
> 
>  include/linux/fs.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index be3ad155ec9f..1437a3323731 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -791,6 +791,19 @@ struct inode {
>  
>  static inline void inode_set_cached_link(struct inode *inode, char *link, int linklen)
>  {
> +	int testlen;
> +
> +	/*
> +	 * TODO: patch it into a debug-only check if relevant macros show up.
> +	 * In the meantime, since we are suffering strlen even on production kernels
> +	 * to find the right length, do a fixup if the wrong value got passed.
> +	 */
> +	testlen = strlen(link);
> +	if (testlen != linklen) {
> +		WARN_ONCE(1, "bad length passed for symlink [%s] (got %d, expected %d)",
> +			  link, linklen, testlen);
> +		linklen = testlen;
> +	}
>  	inode->i_link = link;
>  	inode->i_linklen = linklen;
>  	inode->i_opflags |= IOP_CACHED_LINK;
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

