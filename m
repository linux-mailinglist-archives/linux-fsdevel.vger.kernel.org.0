Return-Path: <linux-fsdevel+bounces-35342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BEA9D3FDC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 17:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 097E01F22824
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 16:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659F014D439;
	Wed, 20 Nov 2024 16:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IisjzLSh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6R5ZHaJW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IisjzLSh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6R5ZHaJW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194F713957C;
	Wed, 20 Nov 2024 16:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732119391; cv=none; b=H6n/83+GE7tmdIqmnutAW4uqV4cOgIATE/3XrCp3bjI6OhhO5G5yrJ6cOdD/3sNp99wVwGqbwsMcA3Vyl1HdkQ4INVKRKoXAfq3FCMjsRceSRARnQhhZBLoa/Z1H7rsUy8ui+rZQPeEqpkNNlqschJJXE2EedtbHHIRelZNavyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732119391; c=relaxed/simple;
	bh=2zJoHAyB8rvbnBz3xn6o2akF7IGLbhyjd5tgXI0WmMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdJqwuxjD3PEIeq30X8MwJHhQKhYe3h2HElN7xsffsMk/Q82mu40hY3TETo92VbOsU/n2Vwup1LlIwo88UFG4RwuVv2IApAAW/KwVJQBWw4+NRzJhlzIDZtSk3aO2ea6fJbdlhWLwlN0myFGIFucr8MhkUTYOlu0LBu/bn8SGVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IisjzLSh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6R5ZHaJW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IisjzLSh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6R5ZHaJW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3BF2C219B3;
	Wed, 20 Nov 2024 16:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732119388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wz13sx0cDR8noJSoNQ/P4iPjmJ9JKdZOk5KjfUWLOnk=;
	b=IisjzLShbwz7Pj1uEHoXXbbKY/Uieu+EWXzK2LpFMn4x55huJksMH4KvC7c+Np7thb9Xr1
	fyflW0FGhu7K87I8XIMxRAcsmSwUZuQIfOZYJcuzS0Y8Duqb9zOTXRhBJpNGObZqt55a5v
	moGTA+2Dl+1jTxPMDLtVPvKuuVxBBVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732119388;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wz13sx0cDR8noJSoNQ/P4iPjmJ9JKdZOk5KjfUWLOnk=;
	b=6R5ZHaJWwGwfgTvxo4AQbJvD7X9Zi+P7MjsUD+TAY0+NTfvSIhPtg1ebrUKTKC/8WB/xup
	sy6+m4iFeMkFt3CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732119388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wz13sx0cDR8noJSoNQ/P4iPjmJ9JKdZOk5KjfUWLOnk=;
	b=IisjzLShbwz7Pj1uEHoXXbbKY/Uieu+EWXzK2LpFMn4x55huJksMH4KvC7c+Np7thb9Xr1
	fyflW0FGhu7K87I8XIMxRAcsmSwUZuQIfOZYJcuzS0Y8Duqb9zOTXRhBJpNGObZqt55a5v
	moGTA+2Dl+1jTxPMDLtVPvKuuVxBBVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732119388;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wz13sx0cDR8noJSoNQ/P4iPjmJ9JKdZOk5KjfUWLOnk=;
	b=6R5ZHaJWwGwfgTvxo4AQbJvD7X9Zi+P7MjsUD+TAY0+NTfvSIhPtg1ebrUKTKC/8WB/xup
	sy6+m4iFeMkFt3CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B0B1137CF;
	Wed, 20 Nov 2024 16:16:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WrvrCVwLPmdEUwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 20 Nov 2024 16:16:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C9B38A08A2; Wed, 20 Nov 2024 17:16:23 +0100 (CET)
Date: Wed, 20 Nov 2024 17:16:23 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
	kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
	brauner@kernel.org, torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk, linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v8 09/19] fsnotify: generate pre-content permission event
 on truncate
Message-ID: <20241120161623.brmiiggtwcvcre3u@quack3>
References: <cover.1731684329.git.josef@toxicpanda.com>
 <23af8201db6ac2efdea94f09ab067d81ba5de7a7.1731684329.git.josef@toxicpanda.com>
 <20241120152340.gu7edmtm2j3lmxoy@quack3>
 <CAOQ4uxiyAU7n4w-BMZx9gzL_DTeKMPkBOy9OZzZYEsqkMHWAGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxiyAU7n4w-BMZx9gzL_DTeKMPkBOy9OZzZYEsqkMHWAGw@mail.gmail.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 20-11-24 16:57:30, Amir Goldstein wrote:
> On Wed, Nov 20, 2024 at 4:23 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Fri 15-11-24 10:30:22, Josef Bacik wrote:
> > > From: Amir Goldstein <amir73il@gmail.com>
> > >
> > > Generate FS_PRE_ACCESS event before truncate, without sb_writers held.
> > >
> > > Move the security hooks also before sb_start_write() to conform with
> > > other security hooks (e.g. in write, fallocate).
> > >
> > > The event will have a range info of the page surrounding the new size
> > > to provide an opportunity to fill the conetnt at the end of file before
> > > truncating to non-page aligned size.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >
> > I was thinking about this. One small issue is that similarly as the
> > filesystems may do RMW of tail page during truncate, they will do RMW of
> > head & tail pages on hole punch or zero range so we should have some
> > strategically sprinkled fsnotify_truncate_perm() calls there as well.
> > That's easy enough to fix.
> 
> fallocate already has fsnotify_file_area_perm() hook.
> What is missing?

Sorry, I've missed that in the patch that was adding it.

> > But there's another problem which I'm more worried about: If we have
> > a file 64k large, user punches 12k..20k and then does read for 0..64k, then
> > how does HSM daemon in userspace know what data to fill in? When we'll have
> > modify pre-content event, daemon can watch it and since punch will send modify
> > for 12k-20k, the daemon knows the local (empty) page cache is the source of
> > truth. But without modify event this is just a recipe for data corruption
> > AFAICT.
> >
> > So it seems the current setting with access pre-content event has only chance
> > to work reliably in read-only mode? So we should probably refuse writeable
> > open if file is being watched for pre-content events and similarly refuse
> > truncate?
> 
> I am confused. not sure I understand the problem.
> 
> In the events that you specific, punch hole WILL generate a FS_PRE_ACCESS
> event for 12k-20k.
> 
> When HSM gets a FS_PRE_ACCESS event for 12k-20k it MUST fill the content
> and keep to itself that 12k-20k is the source of truth from now on.

Ah, right. I've got confused and didn't realize we'll be sending FS_PRE_ACCESS
for 12k-20k. Thanks for clarification!

> The extra FS_PRE_ACCESS event on 0..64k absolutely does not change that.
> IOW, a FS_PRE_ACCESS event on 0..64k definitely does NOT mean that
> HSM NEEDS to fill content in 0..64k, it just means that it MAY needs
> to fill content
> if it hasn't done that for a range before the event.
> 
> To reiterate this important point, it is HSM responsibility to maintain the
>  "content filled map" per file is its own way, under no circumstances it is
> assumed that fiemap or page cache state has anything to do with the
> "content filled map".
> 
> The *only* thing that HSM can assume if that if its "content filled map"
> is empty for some range, then page cache is NOT yet populated in that
> range and that also relies on how HSM and mount are being initialized
> and exposed to users.

OK, understood and makes sense.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

