Return-Path: <linux-fsdevel+bounces-34896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D1D9CDDB4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 12:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD975280EA2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 11:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CA11B85F0;
	Fri, 15 Nov 2024 11:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jPi7ZF/m";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XT72GDTl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yfxa+0uy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xj9DXuah"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF3952F9E;
	Fri, 15 Nov 2024 11:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731671281; cv=none; b=Zn8hRW82O4Yi9H6EARJWChj9rOwfWsHuu+JZfRiNh0ckQ3/+Agm0LigLG8rNyNGnL9eENiAoRAf8g2RHSpER6gyON69ZoVFsXCRNY4FAbDg06fYzlSzk8E8XYloIcUln3FcTt1cksHEex0LVD2rd2YqUosFmC1UgyQOGMhFbfQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731671281; c=relaxed/simple;
	bh=6TldGmezEQC2A7I1k9j2yGZFGHLcdzOgC9FeAlFty3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvjxZQ/CrzdHwrxmE+4WuEM7jwn2+00tGTi+vSHJWT01SsagLLoClRF1AUt1VnXqrRiWf/VlIi7D6Uj+23vApIDOrPL/ygd+nnmvWoa5eAlsZbiMcn6wxnl4qOH8Pq3iYfB3n1sF4yRizGmkX2LubZwcyjnCWThsxwBeeddioB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jPi7ZF/m; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XT72GDTl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yfxa+0uy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xj9DXuah; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 452252116C;
	Fri, 15 Nov 2024 11:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731671277; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sLSISZqZ5n9htJt4xL3hS+cL5Ypb46GaDYtip+z3mJ8=;
	b=jPi7ZF/miO6vjADrGElR8HFeXb3tieltSOCVp/yopEEv6ov0NiIZQBoQf1JcgLxL4+vf2C
	Y2hj07MuJTQCc/KdIqEBPY+uF2gEL9QKWOkP6525ss0AgTNgeMK6bv4d1MB0DMw9BNSF84
	5QtQc6wIbcT7ew4wozE0k/OrE8bMLY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731671277;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sLSISZqZ5n9htJt4xL3hS+cL5Ypb46GaDYtip+z3mJ8=;
	b=XT72GDTlFIzotnygXMZgsWu6N1xjbUOPqXhnyUy9dcr+gPCLTKaw4WD0//QbbkO1/whdNy
	MHpetfDCo1EuFTDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=yfxa+0uy;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=xj9DXuah
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731671276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sLSISZqZ5n9htJt4xL3hS+cL5Ypb46GaDYtip+z3mJ8=;
	b=yfxa+0uyIesOZzZBCTLXJdk2kUMYlkcLUWznOg32xH3p0fiEWzzY5AQ7lVFL/2fEeYNdbI
	OYf/kgB0RMO3XJKkEB28iqZYrN0+K5IGeFaXgRU8st3O+WzjZFyd/ovlR8auI8PBh3oyHy
	iJ94rNfmzkEMfYEmEArrxh0Wv9i5ZLo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731671276;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sLSISZqZ5n9htJt4xL3hS+cL5Ypb46GaDYtip+z3mJ8=;
	b=xj9DXuah+YQn4GXWUPuaeojBApMtPJSw/6KQHov+b4gqbCPl+jcKjJiTJ3HcK6LfY09om8
	NEB0BDvM7VuwgIBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 37663134B8;
	Fri, 15 Nov 2024 11:47:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cT+DDew0N2eXcgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 15 Nov 2024 11:47:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F2707A0986; Fri, 15 Nov 2024 12:47:55 +0100 (CET)
Date: Fri, 15 Nov 2024 12:47:55 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org, jack@suse.cz, brauner@kernel.org,
	torvalds@linux-foundation.org, linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v7 09/18] fanotify: introduce FAN_PRE_ACCESS permission
 event
Message-ID: <20241115114755.whr4q3tuj5rdj7hm@quack3>
References: <cover.1731433903.git.josef@toxicpanda.com>
 <8de8e335e07502f31011a18ec91583467dff51eb.1731433903.git.josef@toxicpanda.com>
 <CAOQ4uxhkPJ=atVPeQ3PsOKps3w8qxJgpvMR1wwT=-onc4KLV5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhkPJ=atVPeQ3PsOKps3w8qxJgpvMR1wwT=-onc4KLV5Q@mail.gmail.com>
X-Rspamd-Queue-Id: 452252116C
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
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,toxicpanda.com:email,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 15-11-24 12:28:01, Amir Goldstein wrote:
> On Tue, Nov 12, 2024 at 6:56 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > From: Amir Goldstein <amir73il@gmail.com>
> >
> > Similar to FAN_ACCESS_PERM permission event, but it is only allowed with
> > class FAN_CLASS_PRE_CONTENT and only allowed on regular files and dirs.
> >
> > Unlike FAN_ACCESS_PERM, it is safe to write to the file being accessed
> > in the context of the event handler.
> >
> > This pre-content event is meant to be used by hierarchical storage
> > managers that want to fill the content of files on first read access.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/notify/fanotify/fanotify.c      |  3 ++-
> >  fs/notify/fanotify/fanotify_user.c | 22 +++++++++++++++++++---
> >  include/linux/fanotify.h           | 14 ++++++++++----
> >  include/uapi/linux/fanotify.h      |  2 ++
> >  4 files changed, 33 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> > index 2e6ba94ec405..da6c3c1c7edf 100644
> > --- a/fs/notify/fanotify/fanotify.c
> > +++ b/fs/notify/fanotify/fanotify.c
> > @@ -916,8 +916,9 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
> >         BUILD_BUG_ON(FAN_OPEN_EXEC_PERM != FS_OPEN_EXEC_PERM);
> >         BUILD_BUG_ON(FAN_FS_ERROR != FS_ERROR);
> >         BUILD_BUG_ON(FAN_RENAME != FS_RENAME);
> > +       BUILD_BUG_ON(FAN_PRE_ACCESS != FS_PRE_ACCESS);
> >
> > -       BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 21);
> > +       BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 22);
> >
> >         mask = fanotify_group_event_mask(group, iter_info, &match_mask,
> >                                          mask, data, data_type, dir);
> > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> > index 9cc4a9ac1515..2ec0cc9c85cf 100644
> > --- a/fs/notify/fanotify/fanotify_user.c
> > +++ b/fs/notify/fanotify/fanotify_user.c
> > @@ -1633,11 +1633,23 @@ static int fanotify_events_supported(struct fsnotify_group *group,
> >                                      unsigned int flags)
> >  {
> >         unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
> > +       bool is_dir = d_is_dir(path->dentry);
> >         /* Strict validation of events in non-dir inode mask with v5.17+ APIs */
> >         bool strict_dir_events = FAN_GROUP_FLAG(group, FAN_REPORT_TARGET_FID) ||
> >                                  (mask & FAN_RENAME) ||
> >                                  (flags & FAN_MARK_IGNORE);
> >
> > +       /*
> > +        * Filesystems need to opt-into pre-content evnets (a.k.a HSM)
> > +        * and they are only supported on regular files and directories.
> > +        */
> > +       if (mask & FANOTIFY_PRE_CONTENT_EVENTS) {
> > +               if (!(path->mnt->mnt_sb->s_iflags & SB_I_ALLOW_HSM))
> > +                       return -EINVAL;
> 
> Should we make this return -EOPNOTSUPP?

I see no reason not to do that so go ahead.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

