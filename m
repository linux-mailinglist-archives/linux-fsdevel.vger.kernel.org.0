Return-Path: <linux-fsdevel+bounces-52530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3599AAE3DAB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 13:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 382FA189405B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 11:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392F023D284;
	Mon, 23 Jun 2025 11:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MkCSdvc7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uay9gry2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MkCSdvc7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uay9gry2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5301E492D
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 11:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750676983; cv=none; b=aMtbAdsQ4I+3DB93ElsCkyQK0E4sFs7hW4/qg4VfSnzuourb041sC34H0xSsY1ayIRBewbMgljkjQy5v0fgCCf/WcKfwDHzYrUKJLg2u6p+e2iKKT9511OR6CTHyGzoXFhCxrKNbYlOFsF+h547ObAdD1W7DzJgaurjmFRqgSn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750676983; c=relaxed/simple;
	bh=byy6HnLzr4XvDPSgzzx70dttPtAqJtwCULtJrfZmBew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rebLpBJ/Y1DmIM0N37RBTthQOGiHJiD97FIXWcLTHSao5du15k5sTPvqLxKfg9GPUyN/XhkDn5uO0PHeOvHXQ7SIiYF7DVGr2u9pj7UbkzxSem+DU3vPgHDoowyo9S0MIoZFDk5eOs9IGa/tR5+tfWNIW2NwprCJFw4Qjh2Ui/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MkCSdvc7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uay9gry2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MkCSdvc7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uay9gry2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3D1551F385;
	Mon, 23 Jun 2025 11:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750676980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9U/dY0NffF2ZhRrdLHT5QYYMdU9TDrPPd+rd5Jk1UWM=;
	b=MkCSdvc7q15FJRiEvoEEZ2UGCiZb3KxDxpQ6euI6GwjVEbA1vGRzfyAsaLUTzUiPpXVLJc
	qBXQfDHc+oN9ZvlWkC6i2kEdKI4ocX0Db+lCjjk3zrgjQh41o99t0FnOFMMlC3r38CgfnO
	D3cq82do29o+D2IcQvXgdv5670jPIVY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750676980;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9U/dY0NffF2ZhRrdLHT5QYYMdU9TDrPPd+rd5Jk1UWM=;
	b=uay9gry24POaaD+iZ24WM5IzdC+GWYiMzhXR5elcuQrXFuWrCiE12UncOaIUsUkoF2InjK
	xX0PSHEdWvWXAOAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MkCSdvc7;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=uay9gry2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750676980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9U/dY0NffF2ZhRrdLHT5QYYMdU9TDrPPd+rd5Jk1UWM=;
	b=MkCSdvc7q15FJRiEvoEEZ2UGCiZb3KxDxpQ6euI6GwjVEbA1vGRzfyAsaLUTzUiPpXVLJc
	qBXQfDHc+oN9ZvlWkC6i2kEdKI4ocX0Db+lCjjk3zrgjQh41o99t0FnOFMMlC3r38CgfnO
	D3cq82do29o+D2IcQvXgdv5670jPIVY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750676980;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9U/dY0NffF2ZhRrdLHT5QYYMdU9TDrPPd+rd5Jk1UWM=;
	b=uay9gry24POaaD+iZ24WM5IzdC+GWYiMzhXR5elcuQrXFuWrCiE12UncOaIUsUkoF2InjK
	xX0PSHEdWvWXAOAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3023B13A27;
	Mon, 23 Jun 2025 11:09:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /gy8C/Q1WWhlKgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Jun 2025 11:09:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C58B8A2A00; Mon, 23 Jun 2025 13:09:39 +0200 (CEST)
Date: Mon, 23 Jun 2025 13:09:39 +0200
From: Jan Kara <jack@suse.cz>
To: Junxuan Liao <ljx@cs.wisc.edu>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jonathan Corbet <corbet@lwn.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2] docs/vfs: update references to i_mutex to i_rwsem
Message-ID: <bi5e6qyg6htcmuocfahgvwxx2djxyeorhlc425y72pggmvw4hi@dzfheotxoz7j>
References: <72223729-5471-474a-af3c-f366691fba82@cs.wisc.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72223729-5471-474a-af3c-f366691fba82@cs.wisc.edu>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3D1551F385
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01
X-Spam-Level: 

On Sun 22-06-25 23:01:32, Junxuan Liao wrote:
> VFS has switched to i_rwsem for ten years now (9902af79c01a: parallel
> lookups actual switch to rwsem), but the VFS documentation and comments
> still has references to i_mutex.
> 
> Signed-off-by: Junxuan Liao <ljx@cs.wisc.edu>

One comment below. Christian, can you please fix it up? Otherwise feel free
to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index fd32a9a17bfb..dd9da7e04a99 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -758,8 +758,9 @@ process is more complicated and uses write_begin/write_end or
>  dirty_folio to write data into the address_space, and
>  writepages to writeback data to storage.
>  
> -Adding and removing pages to/from an address_space is protected by the
> -inode's i_mutex.
> +Removing pages from an address_space requires holding the inode's i_rwsem
> +exclusively, while adding pages to the address_space requires holding the
> +inode's i_mapping->invalidate_lock exclusively.

I wasn't probably precise enough in my previous comment. This paragraph
should be:

Removing pages from an address_space requires holding the inode's i_rwsem
exclusively and i_mapping->invalidate_lock exclusively. Adding pages to the
address_space requires either holding inode's i_rwsem exclusively or
i_mapping->invalidate_lock in shared mode.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

