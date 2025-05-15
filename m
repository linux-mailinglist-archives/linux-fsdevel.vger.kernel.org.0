Return-Path: <linux-fsdevel+bounces-49124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F63DAB84EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 13:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C9D29E74A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 11:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F36129ACEF;
	Thu, 15 May 2025 11:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UhMe6nlw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MQMDuRLc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UhMe6nlw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MQMDuRLc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D8729AB0E
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 11:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747308485; cv=none; b=HcI+EjbVmGnFjdaWtHqvqnaoEnEsZ0qfe7C11Ufz0ffvTh8lX/QOe6t5wSnIL7AnyRQarw1xAEQ8XUtWdJJ0stKYfM/twI+CmlLtq+GaWsc04Z5UC1Xz8lYHL9OhBfaIujrjz+Sa036YMpM8EXT7nnCHsMih/bQjhGlFilVryF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747308485; c=relaxed/simple;
	bh=gFtZ9DObvmyZAhGz65qZCinfw7wwY99cEpmS02/Utpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yf76vuhNICbZASq3CaQLu/giaBmXzPXDLuQhpgOvj65M5UFiqXouLgyIxXnbsvFVAif06kRprn3ZD0jzsS6AQUC6PkFwRZS54m2kDdPEfZMUh5Veebg5Nd/VKEhRpnCHS8vMHBDMJdMzbLSpP+Fw0rbLD88LjgZQtgXBeuT9qYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UhMe6nlw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MQMDuRLc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UhMe6nlw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MQMDuRLc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 45A20211A5;
	Thu, 15 May 2025 11:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747308482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C0N2RU0v+rAl/EZz0pWzktGkWbPzQnZSDw/JRpT7800=;
	b=UhMe6nlwokVyfbgDMR3EjckzbYYKZ06AFbaKNwkehvOuw8Q2Ulyb0kEi8IVibz2nwZov5w
	KMBd8p/zoSYBothcXIYeSIOWWMlTcXaaucY6NH4b7KL8q6EWBRm/QA27Vx8OUY+l4DWAvl
	7VQUPJpW65CkCBrF+lWBR7SDLNx8y78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747308482;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C0N2RU0v+rAl/EZz0pWzktGkWbPzQnZSDw/JRpT7800=;
	b=MQMDuRLcPpSfefmfK2yB+pX40WuqFUZSLhCCxTT8akOb/n3W+KRXwbkMdF+BRylaapzxKf
	SOEdMfwFDWaZRoBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747308482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C0N2RU0v+rAl/EZz0pWzktGkWbPzQnZSDw/JRpT7800=;
	b=UhMe6nlwokVyfbgDMR3EjckzbYYKZ06AFbaKNwkehvOuw8Q2Ulyb0kEi8IVibz2nwZov5w
	KMBd8p/zoSYBothcXIYeSIOWWMlTcXaaucY6NH4b7KL8q6EWBRm/QA27Vx8OUY+l4DWAvl
	7VQUPJpW65CkCBrF+lWBR7SDLNx8y78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747308482;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C0N2RU0v+rAl/EZz0pWzktGkWbPzQnZSDw/JRpT7800=;
	b=MQMDuRLcPpSfefmfK2yB+pX40WuqFUZSLhCCxTT8akOb/n3W+KRXwbkMdF+BRylaapzxKf
	SOEdMfwFDWaZRoBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C898139D0;
	Thu, 15 May 2025 11:28:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UVfXCsLPJWi9cwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 15 May 2025 11:28:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5DA43A08CF; Thu, 15 May 2025 13:28:00 +0200 (CEST)
Date: Thu, 15 May 2025 13:28:00 +0200
From: Jan Kara <jack@suse.cz>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] include/linux/fs.h: add inode_lock_killable()
Message-ID: <2cn6o6b4wkjdx6bxz3r7nrfgxe5tx52q7qyd2wdl432tjqaclk@njcvjewd4pta>
References: <20250513150327.1373061-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513150327.1373061-1-max.kellermann@ionos.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]

On Tue 13-05-25 17:03:24, Max Kellermann wrote:
> Prepare for making inode operations killable while they're waiting for
> the lock.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/fs.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 016b0fe1536e..5e4ac873228d 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -867,6 +867,11 @@ static inline void inode_lock(struct inode *inode)
>  	down_write(&inode->i_rwsem);
>  }
>  
> +static inline __must_check int inode_lock_killable(struct inode *inode)
> +{
> +	return down_write_killable(&inode->i_rwsem);
> +}
> +
>  static inline void inode_unlock(struct inode *inode)
>  {
>  	up_write(&inode->i_rwsem);
> @@ -877,6 +882,11 @@ static inline void inode_lock_shared(struct inode *inode)
>  	down_read(&inode->i_rwsem);
>  }
>  
> +static inline __must_check int inode_lock_shared_killable(struct inode *inode)
> +{
> +	return down_read_killable(&inode->i_rwsem);
> +}
> +
>  static inline void inode_unlock_shared(struct inode *inode)
>  {
>  	up_read(&inode->i_rwsem);
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

