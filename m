Return-Path: <linux-fsdevel+bounces-32786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 199809AEC4D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 18:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EB621F21C39
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 16:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B8B1F76CE;
	Thu, 24 Oct 2024 16:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vaEXFviC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hPJlHQvT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G1SQmVbC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cK9ZOrLv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2561F4FC2
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 16:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787714; cv=none; b=eo4rnBpS4uGqQo5VRHsJSwGaCGw8tqG1XqQMDyyFKYOqKBpFmgBiGBqvMA/OVK/JGY8MXZiaR7/31KhcPHPWHYx8DUxm0FY/BKo7S5xAJw5TM6UJmXIUkxM26CrIjO75ZabKArF9cgsRxi36GM+TuiRIb03PRtnyggJyfLP4ZF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787714; c=relaxed/simple;
	bh=dqhe/9TATegcCaYBwgM4HEAMKOwrbjtBRcPwNCNDSxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A++XZY0HIWpZOY1JPgv9kgmZssyI+/mBIb1hozJn8vJH9CPbKFHU+qTGPHlTstYm/xmxV2prQMIej/pmU8C/5vwGmi0NRBXlAlqioPb5ApDIurU3t+cH+rANEmSbkXj9QnuAQyXhBXpoD3fNoafxgHM68SNG1dnQ39oAUMYJY10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vaEXFviC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hPJlHQvT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G1SQmVbC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cK9ZOrLv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D34841F745;
	Thu, 24 Oct 2024 16:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729787709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oGq+hFK7JqKI2MGRbmq7rQyhKBKSq/9xtjt/vkA4i3w=;
	b=vaEXFviCMduDnYiH1IjwnZK2jHmaa7Fnbtv3qdoYeKf2hQlCGVEw8ixcl6oYlWhdW5FXIT
	ySROVbc+hpDkF2/ytFTN1hdDcdE3axMc+RLlBhispy7AUaxjsUK91QKS76xzA9Gb8kQbno
	MKGy1cjUtG7aAIrhmKkuboCdWQWN7Bw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729787709;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oGq+hFK7JqKI2MGRbmq7rQyhKBKSq/9xtjt/vkA4i3w=;
	b=hPJlHQvTRLF/I6ZepBbBGCv1lgIbBRvbRPHFZKTwmG4WuJOie0sNQsZjJy9mz+l06FzfCD
	G4Jgk/6TlAgDhcDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=G1SQmVbC;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cK9ZOrLv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729787708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oGq+hFK7JqKI2MGRbmq7rQyhKBKSq/9xtjt/vkA4i3w=;
	b=G1SQmVbCDjU/iuyHnbVjDPXXi82USzRSFKd3H1OygCxff/KLy8nZPgPzCtxLnj/PqfU2YR
	c+A5zml0VZo/ElrvkaUUdG9jQqFf7bz74lpoVjEuneWPE3rdkjPaavrCehi9hn/qWW/jzi
	iez2+RRAxEaCJyirHtyI6mExTNuM6ug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729787708;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oGq+hFK7JqKI2MGRbmq7rQyhKBKSq/9xtjt/vkA4i3w=;
	b=cK9ZOrLvQH46aoaTuax6sZIWelzA0uw3/iO0ig6NUifacrB+mLcwCz2hrKYcaDZ8V0xuuY
	yq97EhXsb7ht8mDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD2EA136F5;
	Thu, 24 Oct 2024 16:35:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5ZewLTx3Gme/WAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 24 Oct 2024 16:35:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 623DEA0826; Thu, 24 Oct 2024 18:35:08 +0200 (CEST)
Date: Thu, 24 Oct 2024 18:35:08 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
	kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Subject: Re: [PATCH 08/10] fanotify: report file range info with pre-content
 events
Message-ID: <20241024163508.qlwxu65lgft5q3po@quack3>
References: <cover.1721931241.git.josef@toxicpanda.com>
 <1a378ca2df2ce30e5aecf7145223906a427d9037.1721931241.git.josef@toxicpanda.com>
 <20240801173831.5uzwvhzdqro3om3q@quack3>
 <CAOQ4uxg-yjHnDfBnu4ZVGnzA8k2UpFr+3aTLDPa6kSXBxxJ6=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxg-yjHnDfBnu4ZVGnzA8k2UpFr+3aTLDPa6kSXBxxJ6=w@mail.gmail.com>
X-Rspamd-Queue-Id: D34841F745
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Thu 24-10-24 12:06:35, Amir Goldstein wrote:
> On Thu, Aug 1, 2024 at 7:38 PM Jan Kara <jack@suse.cz> wrote:
> > On Thu 25-07-24 14:19:45, Josef Bacik wrote:
> > > From: Amir Goldstein <amir73il@gmail.com>
> > >
> > > With group class FAN_CLASS_PRE_CONTENT, report offset and length info
> > > along with FAN_PRE_ACCESS and FAN_PRE_MODIFY permission events.
> > >
> > > This information is meant to be used by hierarchical storage managers
> > > that want to fill partial content of files on first access to range.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >  fs/notify/fanotify/fanotify.h      |  8 +++++++
> > >  fs/notify/fanotify/fanotify_user.c | 38 ++++++++++++++++++++++++++++++
> > >  include/uapi/linux/fanotify.h      |  7 ++++++
> > >  3 files changed, 53 insertions(+)
> > >
> > > diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> > > index 93598b7d5952..7f06355afa1f 100644
> > > --- a/fs/notify/fanotify/fanotify.h
> > > +++ b/fs/notify/fanotify/fanotify.h
> > > @@ -448,6 +448,14 @@ static inline bool fanotify_is_perm_event(u32 mask)
> > >               mask & FANOTIFY_PERM_EVENTS;
> > >  }
> > >
> > > +static inline bool fanotify_event_has_access_range(struct fanotify_event *event)
> > > +{
> > > +     if (!(event->mask & FANOTIFY_PRE_CONTENT_EVENTS))
> > > +             return false;
> > > +
> > > +     return FANOTIFY_PERM(event)->ppos;
> > > +}
> >
> > Now I'm a bit confused. Can we have legally NULL ppos for an event from
> > FANOTIFY_PRE_CONTENT_EVENTS?
> >
> 
> Sorry for the very late reply...
> 
> The short answer is that NULL FANOTIFY_PERM(event)->ppos
> simply means that fanotify_alloc_perm_event() was called with NULL
> range, which is the very common case of legacy permission events.
> 
> The long answer is a bit convoluted, so bare with me.
> The long answer is to the question whether fsnotify_file_range() can
> be called with a NULL ppos.
> 
> This shouldn't be possible AFAIK for regular files and directories,
> unless some fs that is marked with FS_ALLOW_HSM opens a regular
> file with FMODE_STREAM, which should not be happening IMO,
> but then the assertion belongs inside fsnotify_file_range().
> 
> However, there was another way to get NULL ppos before I added the patch
> "fsnotify: generate pre-content permission event on open"
> 
> Which made this "half intentional" change:
>  static inline int fsnotify_file_perm(struct file *file, int perm_mask)
>  {
> -       return fsnotify_file_area_perm(file, perm_mask, NULL, 0);
> +       return fsnotify_file_area_perm(file, perm_mask, &file->f_pos, 0);
>  }
> 
> In order to implement:
> "The event will have a range info of (0..0) to provide an opportunity
>  to fill the entire file content on open."
> 
> The problem is that do_open() was not the only caller of fsnotify_file_perm().
> There is another call from iterate_dir() and the change above causes
> FS_PRE_ACCESS events on readdir to report the directory f_pos -
> Do we want that? I think we do, but HSM should be able to tell the
> difference between opendir() and readdir(), because my HSM only
> wants to fill dir content on the latter.

Well, I'm not so sure we want to report fpos on opendir / readdir(). For
directories fpos is an opaque cookie that is filesystem dependent and you
are not even allowed to carry it from open to open. It is valid only within
that one open-close session if I remember right. So userspace HSM cannot do
much with it and in my opinion reporting it to userspace is a recipe for
abuse...

I'm undecided whether we want to allow pre-access events without range or
enforce 0-0 range. I don't think there's a big practical difference.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

