Return-Path: <linux-fsdevel+bounces-24825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B609994515B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 19:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 118C0B251D8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 17:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145ED1A4884;
	Thu,  1 Aug 2024 17:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vQBi0TSi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UDEodsIX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fU2a8iIV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+N82taDQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC111EB4B1
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Aug 2024 17:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722532596; cv=none; b=Kzn54GyTdb8eoWqJe+mMb89iSP5Gl2JHMzXMvPGs2LNpzF3AxekcVfM67n5uvXzsPUcao7Vfr3OoQe7DBIVsaTZe7F5faeuhQZEWCIg1BUA/TCl9lU5S/rfF5sXr9yW3KmTmBMw00Xf8Z6DAowCamMWqGQPmsOySaSMIdlzicLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722532596; c=relaxed/simple;
	bh=WvEO0kUfcLMifwu7d27oADj371NmCZSAIt3rIw+Y3Jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AM2Q8SgxDUrkEiYlHuMUWtrcireNqck23rl3mOfjPtgh4mu+kt28Sd7bH/WFFrNV4G59Y02wp94cTEC0JG7T4zYnko/Vw1SI0Y54A9gew2fBP7rQ3HdIKVxpevKhUZ7sNdlnWI1RrwG7LanivJvs/BFiFszE+Ud1iVZubkDYags=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vQBi0TSi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UDEodsIX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fU2a8iIV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+N82taDQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9541021A1F;
	Thu,  1 Aug 2024 17:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722532593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QkeokA/aG+KxHpZZa+uYmSo918bs/mbWW6g2TeqvytY=;
	b=vQBi0TSiVdr1Bs205ZTCqahEelxEIYERWdMJzVKmR/H6HVyPISBfcdc7rx5r9sftMW6mGn
	PBdLuUWbqu1nCbBj0o/DmmWs0rkiZIV4HjDA7s3GXFvmn3alm8MX60TmFN44GEcrlF11o6
	zdICudbKduObyW6YtysaPVaTDdkMmY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722532593;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QkeokA/aG+KxHpZZa+uYmSo918bs/mbWW6g2TeqvytY=;
	b=UDEodsIXvcZZwcsCX1uD5t9l1LhTcobwQSliV0s8r+V0LzkWEZwy4DbZnq53r0opJ+bC/w
	rG/J7eCx42FZaSBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=fU2a8iIV;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+N82taDQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722532591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QkeokA/aG+KxHpZZa+uYmSo918bs/mbWW6g2TeqvytY=;
	b=fU2a8iIVFmo7bJSUM3uTSApK32G/Qw2PaIJTXVQK4UhEswyf1yNnWeVpYPuOS/iqlIb0Ox
	HdQT5biGX6+4yqlG2PxQWK9Pl1UCvjaqHGTIB6Xysr+Si4BRIUqeJh6L9ZKgiziUa+vyUa
	pn733lDtP+zvngtWBlR9mDjHY/VocAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722532591;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QkeokA/aG+KxHpZZa+uYmSo918bs/mbWW6g2TeqvytY=;
	b=+N82taDQlRRlgxUY8/dMYPhJ/FWJOkaEYPhjtRfphdflaohegmgHFem7Rys4Tuv1ZauiX4
	sp6urblAyYymkECw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8AA73136CF;
	Thu,  1 Aug 2024 17:16:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bP/YIe/Cq2aBMwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 01 Aug 2024 17:16:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4962DA08CB; Thu,  1 Aug 2024 19:16:31 +0200 (CEST)
Date: Thu, 1 Aug 2024 19:16:31 +0200
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	amir73il@gmail.com, brauner@kernel.org
Subject: Re: [PATCH 06/10] fanotify: pass optional file access range in
 pre-content event
Message-ID: <20240801171631.pxxeyiosbdhjzfvx@quack3>
References: <cover.1721931241.git.josef@toxicpanda.com>
 <bd00d41050b3982ba96c2c3ed8677c136f8019e0.1721931241.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd00d41050b3982ba96c2c3ed8677c136f8019e0.1721931241.git.josef@toxicpanda.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9541021A1F
X-Spam-Score: -3.81
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.81 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
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
	FREEMAIL_CC(0.00)[fb.com,vger.kernel.org,suse.cz,gmail.com,kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:dkim]

On Thu 25-07-24 14:19:43, Josef Bacik wrote:
> From: Amir Goldstein <amir73il@gmail.com>
> 
> We would like to add file range information to pre-content events.
> 
> Pass a struct file_range with optional offset and length to event handler
> along with pre-content permission event.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

...

> @@ -565,6 +569,10 @@ static struct fanotify_event *fanotify_alloc_perm_event(const struct path *path,
>  	pevent->hdr.len = 0;
>  	pevent->state = FAN_EVENT_INIT;
>  	pevent->path = *path;
> +	if (range) {
> +		pevent->ppos = range->ppos;
> +		pevent->count = range->count;
> +	}

Shouldn't we initialze ppos & count in case range info isn't passed?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

