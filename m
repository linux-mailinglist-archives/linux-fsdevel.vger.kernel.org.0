Return-Path: <linux-fsdevel+bounces-36099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C429DBB4D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 17:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5B782808CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 16:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11451BF80C;
	Thu, 28 Nov 2024 16:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ypE/f/ly";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mFPlkiz0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ypE/f/ly";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mFPlkiz0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907953232;
	Thu, 28 Nov 2024 16:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732811834; cv=none; b=iwDaMf9fqqg7zpALyQJFXWP+UbO9TUycf8mQY9ro3KzZV7Qm1dZUegA+vxNFV85dcu0p1l+c1wyoAzGAFNN3UOWE5VKT7+0/L3Pb6izNz1otFknzreCwlZ59aAovnH3yvG9X8gK+21NHQcwCvE55JKuodBELvIBPpZjgpBm4gYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732811834; c=relaxed/simple;
	bh=r2jPPi2WYm83gXv0yUX9hMRv1Yl3wYFnxKf79bIJQsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GhFZnr7wjNbL9socOWRApsVfz+Mxz24QwayFmD9SD24pdxFdmVcmN/uQki+0giut2xuwFxxcBIR2SFShIVAhVo/13UTWqRJm5NFIPip0g3bww/Beof3BfapFoGjZztAUOjNUuDCmjYBD8PBol0pAgBYD9moKAt6pF6Uh1CVPR7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ypE/f/ly; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mFPlkiz0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ypE/f/ly; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mFPlkiz0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 686711F7A0;
	Thu, 28 Nov 2024 16:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732811830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G0YgWV6B4NeYWbbuY++6ThFtY8hDLYVjJacblvd4LZk=;
	b=ypE/f/lyhocdeAN6ZwjEPZFCeOHj6U3UuV/obnwq+c3zlz7pjUqqG6IbeuWbKghiOeQHIm
	Jx928IyrjE1bcLX4VvW2UqvkWtdI38jYGDkqLrzA7U8POK5PaHGQGUMXOPX9ow9yRnF0BF
	4tz1++A3tNzzvnIR5c2fZo7wWQaVmT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732811830;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G0YgWV6B4NeYWbbuY++6ThFtY8hDLYVjJacblvd4LZk=;
	b=mFPlkiz08UCciVZ4DOGLQCJXaAWOquF46g3IhZMnJ3F148VZRsq0T50lIPKUoetF0v4du+
	cByqib9ZYHpFW/CA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="ypE/f/ly";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mFPlkiz0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732811830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G0YgWV6B4NeYWbbuY++6ThFtY8hDLYVjJacblvd4LZk=;
	b=ypE/f/lyhocdeAN6ZwjEPZFCeOHj6U3UuV/obnwq+c3zlz7pjUqqG6IbeuWbKghiOeQHIm
	Jx928IyrjE1bcLX4VvW2UqvkWtdI38jYGDkqLrzA7U8POK5PaHGQGUMXOPX9ow9yRnF0BF
	4tz1++A3tNzzvnIR5c2fZo7wWQaVmT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732811830;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G0YgWV6B4NeYWbbuY++6ThFtY8hDLYVjJacblvd4LZk=;
	b=mFPlkiz08UCciVZ4DOGLQCJXaAWOquF46g3IhZMnJ3F148VZRsq0T50lIPKUoetF0v4du+
	cByqib9ZYHpFW/CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 545A913974;
	Thu, 28 Nov 2024 16:37:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gRg3FDacSGeIPwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 28 Nov 2024 16:37:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B0D27A09D3; Thu, 28 Nov 2024 17:37:05 +0100 (CET)
Date: Thu, 28 Nov 2024 17:37:05 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Song Liu <song@kernel.org>, bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, kernel-team@meta.com,
	andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, kpsingh@kernel.org,
	mattbobrowski@google.com, repnop@google.com, jlayton@kernel.org,
	josef@toxicpanda.com, mic@digikod.net, gnoack@google.com
Subject: Re: [PATCH v3 fanotify 1/2] fanotify: Introduce fanotify filter
Message-ID: <20241128163705.vuvmb5k6ryyiblt5@quack3>
References: <20241122225958.1775625-1-song@kernel.org>
 <20241122225958.1775625-2-song@kernel.org>
 <CAOQ4uxgKoCztsPZ-X-annfrDwetpy1fcRJz-RdD-pAdMQKVH=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgKoCztsPZ-X-annfrDwetpy1fcRJz-RdD-pAdMQKVH=Q@mail.gmail.com>
X-Rspamd-Queue-Id: 686711F7A0
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,meta.com,gmail.com,iogearbox.net,linux.dev,zeniv.linux.org.uk,suse.cz,google.com,toxicpanda.com,digikod.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Sun 24-11-24 07:25:20, Amir Goldstein wrote:
> On Sat, Nov 23, 2024 at 12:00 AM Song Liu <song@kernel.org> wrote:
...
> > @@ -921,6 +924,39 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
> >         pr_debug("%s: group=%p mask=%x report_mask=%x\n", __func__,
> >                  group, mask, match_mask);
> >
> > +       if (FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS))
> > +               fsid = fanotify_get_fsid(iter_info);
> > +
> > +#ifdef CONFIG_FANOTIFY_FILTER
> > +       filter_hook = srcu_dereference(group->fanotify_data.filter_hook, &fsnotify_mark_srcu);
> 
> Do we actually need the sleeping rcu protection for calling the hook?
> Can regular rcu read side be nested inside srcu read side?

Nesting rcu inside srcu is fine.

> Jan,
> 
> I don't remember why srcu is needed since we are not holding it
> when waiting for userspace anymore?

You need srcu to access marks or notification group unless you grab a
reference to them (which is what waiting for permission event reply code
does).
 
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

