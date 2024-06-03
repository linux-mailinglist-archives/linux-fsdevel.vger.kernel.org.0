Return-Path: <linux-fsdevel+bounces-20802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9645D8D807E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 13:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 285DA284059
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 11:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA9584A49;
	Mon,  3 Jun 2024 11:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Nh7Jx1bh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1iUSXdMP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Nh7Jx1bh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1iUSXdMP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1270482891;
	Mon,  3 Jun 2024 11:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717412637; cv=none; b=HHdnBbfAjjcDtLZdOmW814Ca0+gThb3NBDSBz32n2tXuuHG14R6LiTTXJrVBTk3/p4dEhvm1myAGeztYUkYJwxQ5b4A9Ctka4oy7QNHMNJXmTajhasK3l2L8xfz6CIzVsCOtv9F59beksq8CF7sS7KlCD4my31T7Gz4fqAa0dj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717412637; c=relaxed/simple;
	bh=bQPnQcAIRDKBdTp8lMVtsR76hFtMqgQtFqFIcPainMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VAxjHIgW41wyJO4yJHM4ZJ9ACYJXi6rYOQBQLdMWzYuIeIapqQp8TUOwsXOWcXyn8B3Eo6XQpax8AftSuiNrbOBIPit24hr+CUTTPpX0rH/XhHIEwnJOmGJGTXETgc8PBiv1He9N/sPSiWOsQHgbtzCkvXJ/LK700KwrA2AgrCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Nh7Jx1bh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1iUSXdMP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Nh7Jx1bh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1iUSXdMP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2815C20031;
	Mon,  3 Jun 2024 11:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717412633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n5/X7Y8BzC0MwNPhikLy5onR3o+8EW7j6LOz1oCOdHI=;
	b=Nh7Jx1bhwQOzWC/cAEBaBv9sKXguMByr35SycoUAom89Kq49Sem/mNaa7AuAUtUAzM3HCB
	oXNmoRWYGFDGdmULGcmcO6gZU/tCthgmu2YGaKENOef/hJo0G64bEEY8NI6Thb8VGcryvO
	hJ+RYydNYLtYe1F04WZnCVG04tVNWmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717412633;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n5/X7Y8BzC0MwNPhikLy5onR3o+8EW7j6LOz1oCOdHI=;
	b=1iUSXdMPGHYkVyXbvZjtcYCsEeoal+Q2EaMTFibvUMei9mIIFGSPz/vFU5HWxO980EDFZK
	xDZd6aS7rG9Ck9Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717412633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n5/X7Y8BzC0MwNPhikLy5onR3o+8EW7j6LOz1oCOdHI=;
	b=Nh7Jx1bhwQOzWC/cAEBaBv9sKXguMByr35SycoUAom89Kq49Sem/mNaa7AuAUtUAzM3HCB
	oXNmoRWYGFDGdmULGcmcO6gZU/tCthgmu2YGaKENOef/hJo0G64bEEY8NI6Thb8VGcryvO
	hJ+RYydNYLtYe1F04WZnCVG04tVNWmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717412633;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n5/X7Y8BzC0MwNPhikLy5onR3o+8EW7j6LOz1oCOdHI=;
	b=1iUSXdMPGHYkVyXbvZjtcYCsEeoal+Q2EaMTFibvUMei9mIIFGSPz/vFU5HWxO980EDFZK
	xDZd6aS7rG9Ck9Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 102CD13A93;
	Mon,  3 Jun 2024 11:03:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KrWlAxmjXWagIAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 03 Jun 2024 11:03:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A10FFA087F; Mon,  3 Jun 2024 13:03:44 +0200 (CEST)
Date: Mon, 3 Jun 2024 13:03:44 +0200
From: Jan Kara <jack@suse.cz>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] readdir: Add missing quote in macro comment
Message-ID: <20240603110344.weobnu6augggrbdw@quack3>
References: <20240602004729.229634-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240602004729.229634-2-thorsten.blum@toblux.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]

On Sun 02-06-24 02:47:30, Thorsten Blum wrote:
> Add a missing double quote in the unsafe_copy_dirent_name() macro
> comment.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/readdir.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/readdir.c b/fs/readdir.c
> index 278bc0254732..5045e32f1cb6 100644
> --- a/fs/readdir.c
> +++ b/fs/readdir.c
> @@ -72,7 +72,7 @@ int wrap_directory_iterator(struct file *file,
>  EXPORT_SYMBOL(wrap_directory_iterator);
>  
>  /*
> - * Note the "unsafe_put_user() semantics: we goto a
> + * Note the "unsafe_put_user()" semantics: we goto a
>   * label for errors.
>   */
>  #define unsafe_copy_dirent_name(_dst, _src, _len, label) do {	\
> -- 
> 2.45.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

