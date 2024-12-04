Return-Path: <linux-fsdevel+bounces-36437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DC79E3A4C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 13:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92D491667B8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 12:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3211CEAD6;
	Wed,  4 Dec 2024 12:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VSw40rmO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vtDi/cXU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VSw40rmO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vtDi/cXU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C441BBBEB;
	Wed,  4 Dec 2024 12:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316517; cv=none; b=nQI6glLW4dBrbVEG+0WdkO4H3wJe8np9LAAr63ogATHhyjCssXYWSTlTkizetyAdHnsdl9zLuvLCt38APTgFyKnfLpoMQPY8R7D1Hd4nYmUsWXntMUA7khjK5DMDcBR0OYLHy0HU3N6ltWzNIvZqlzQhzKO+iCGAunTHXWm0vpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316517; c=relaxed/simple;
	bh=3+3umjB6i4zlNQ+jSDt7rGEB4ImooE0pfJVXv34MOY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pwdw52VmGCMrO92YeP32g/uR1nMkYqnRwPOIS1sV4pyJzyL2zILPJXH2JfaGKaVnRGUjojKPiwzIoNZ9RcRxQHFl3IFUARcvJVLf3FkgzdlDFHYEgfNq+YHsJ6yQANiCSL67zMKE979tVABkuTJuAvYKmmwdH7NkDHOVEYZT+ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VSw40rmO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vtDi/cXU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VSw40rmO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vtDi/cXU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1E6EF1F38E;
	Wed,  4 Dec 2024 12:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733316514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ymlL70I+HNZPwYkjWNX9SluucT3Yj/oicORRSjAS6GE=;
	b=VSw40rmOJrMQTSZliWEOhBHwJ7/Dz998sQ64V2Abc0TGDF8vXZeVLH2pQBJLgB/A7WXN7h
	HzEa59c5QUPMLV3sUr4tCjTgZJzq1HSBvAEIroBh2wyVHeTVeDPFVH6ESKxr72hb+zCuA6
	6WmH32irJ9n+UqLlymfP12ohYc6nwVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733316514;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ymlL70I+HNZPwYkjWNX9SluucT3Yj/oicORRSjAS6GE=;
	b=vtDi/cXUrUAytByy7Ja9FrOxzLM767auPG3QEUhC+o6W6Gl0qtrb0QANEz+6r5UdY8ZTS/
	DwVSAoDG/kql/UAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=VSw40rmO;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="vtDi/cXU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733316514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ymlL70I+HNZPwYkjWNX9SluucT3Yj/oicORRSjAS6GE=;
	b=VSw40rmOJrMQTSZliWEOhBHwJ7/Dz998sQ64V2Abc0TGDF8vXZeVLH2pQBJLgB/A7WXN7h
	HzEa59c5QUPMLV3sUr4tCjTgZJzq1HSBvAEIroBh2wyVHeTVeDPFVH6ESKxr72hb+zCuA6
	6WmH32irJ9n+UqLlymfP12ohYc6nwVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733316514;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ymlL70I+HNZPwYkjWNX9SluucT3Yj/oicORRSjAS6GE=;
	b=vtDi/cXUrUAytByy7Ja9FrOxzLM767auPG3QEUhC+o6W6Gl0qtrb0QANEz+6r5UdY8ZTS/
	DwVSAoDG/kql/UAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1398B139C2;
	Wed,  4 Dec 2024 12:48:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 29/IBKJPUGcVLQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Dec 2024 12:48:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C1CFDA0918; Wed,  4 Dec 2024 13:48:29 +0100 (CET)
Date: Wed, 4 Dec 2024 13:48:29 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, I Hsin Cheng <richard120310@gmail.com>,
	viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] file: Wrap locking mechanism for f_pos_lock
Message-ID: <20241204124829.4xpciqbz73u2e2nc@quack3>
References: <20241204092325.170349-1-richard120310@gmail.com>
 <20241204102644.hvutdftkueiiyss7@quack3>
 <20241204-osterblume-blasorchester-2b05c8ee6ace@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204-osterblume-blasorchester-2b05c8ee6ace@brauner>
X-Rspamd-Queue-Id: 1E6EF1F38E
X-Spam-Score: -4.01
X-Rspamd-Action: no action
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
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,zeniv.linux.org.uk,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 04-12-24 12:11:02, Christian Brauner wrote:
> > motivation of introducing __f_unlock_pos() in the first place? It has one
> 
> May I venture a guess:
> 
>   CALL    ../scripts/checksyscalls.sh
>   INSTALL libsubcmd_headers
>   INSTALL libsubcmd_headers
>   CC      fs/read_write.o
> In file included from ../fs/read_write.c:12:
> ../include/linux/file.h:78:27: error: incomplete definition of type 'struct file'
>    78 |                 mutex_unlock(&fd_file(f)->f_pos_lock);
>       |                               ~~~~~~~~~~^
> 
> If you don't include linux/fs.h before linux/file.h you'd get compilation
> errors and we don't want to include linux/fs.h in linux/file.h.

Ah, subtle ;)

> I wouldn't add another wrapper for lock though. Just put a comment on top of
> __f_unlock_pos().       

Yes, I guess comment is better in that case.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

