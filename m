Return-Path: <linux-fsdevel+bounces-7985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D913782E018
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 19:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4919F1F21C56
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 18:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB2518E38;
	Mon, 15 Jan 2024 18:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MBcPXJnE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1T3StGOd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qR9rtYE5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9K98g5Dj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB6818E32
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 18:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E07AC1FD40;
	Mon, 15 Jan 2024 18:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705343879; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SAmkN+KCCNGr5BCBuo21KG5AQzMIILDjEudzUSTTbLo=;
	b=MBcPXJnErY7N+8D7wicsObBSlnEY9tP5rkBg7NCRPNVT5o8h0qRjALkvwAZuygDnvWaQGW
	jsEAXRClovURLwRyTHFniPPdvdhjFen+UdSekVLC3DAWiXg8Vv9MqUZS8fxi+xeYuo3V63
	2L8xcHNiKbOm8hcgfCah5WeXrZ2t8Jo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705343879;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SAmkN+KCCNGr5BCBuo21KG5AQzMIILDjEudzUSTTbLo=;
	b=1T3StGOd/xK7i5sa/IJQyWbWjh2UDlMgsV3mh4HmhNZdmWfyI+FiAApfBQLBMrsUh8NoK0
	HXcKyWfGz+AHgEBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705343878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SAmkN+KCCNGr5BCBuo21KG5AQzMIILDjEudzUSTTbLo=;
	b=qR9rtYE5KJM4nJGFP4B7veBWEBfsjjf7oX2QJuOGaLrAA3CeMK/wme/w3T2BP7HT069agv
	1+uHXT4W9Bu2zvve1QAgSRltya+7LC3cD7hJQf6ddQC8QTeTap8DZ1N0hRGY9SlLYUryJS
	E5FGFemAheGpw+SyUfmGo+aEcX4/4Sc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705343878;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SAmkN+KCCNGr5BCBuo21KG5AQzMIILDjEudzUSTTbLo=;
	b=9K98g5DjoVBhTW/vnka7eHs5n1VYH6pH5O5hq7zGN3ckhGK5XPnCBKFGQOUOvmwODo/Rc7
	lYxBuXoz+8X/cLAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF666132FA;
	Mon, 15 Jan 2024 18:37:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CSxgMoZ7pWUfPgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 15 Jan 2024 18:37:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 717D0A07EA; Mon, 15 Jan 2024 19:37:58 +0100 (CET)
Date: Mon, 15 Jan 2024 19:37:58 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH v2] fsnotify: optimize the case of no content event
 watchers
Message-ID: <20240115183758.6yq6wjqjvhreyqnu@quack3>
References: <20240111152233.352912-1-amir73il@gmail.com>
 <20240112110936.ibz4s42x75mjzhlv@quack3>
 <CAOQ4uxgAGpBTeEyqJTSGn5OvqaxsVP3yXR6zuS-G9QWnTjoV9w@mail.gmail.com>
 <ec5c6dde-e8dd-4778-a488-886deaf72c89@kernel.dk>
 <4a35c78e-98d4-4edb-b7bf-8a6d1df3c554@kernel.dk>
 <CAOQ4uxgzvz9XE4eMLaRt4Jkg-o4+mTQvgbHrayx27ku2ONGfPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgzvz9XE4eMLaRt4Jkg-o4+mTQvgbHrayx27ku2ONGfPg@mail.gmail.com>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qR9rtYE5;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9K98g5Dj
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[5];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: E07AC1FD40
X-Spam-Flag: NO

On Fri 12-01-24 16:36:05, Amir Goldstein wrote:
> On Fri, Jan 12, 2024 at 4:11 PM Jens Axboe <axboe@kernel.dk> wrote:
> >
> > On 1/12/24 6:58 AM, Jens Axboe wrote:
> > > On 1/12/24 6:00 AM, Amir Goldstein wrote:
> > >> On Fri, Jan 12, 2024 at 1:09?PM Jan Kara <jack@suse.cz> wrote:
> > >>>
> > >>> On Thu 11-01-24 17:22:33, Amir Goldstein wrote:
> > >>>> Commit e43de7f0862b ("fsnotify: optimize the case of no marks of any type")
> > >>>> optimized the case where there are no fsnotify watchers on any of the
> > >>>> filesystem's objects.
> > >>>>
> > >>>> It is quite common for a system to have a single local filesystem and
> > >>>> it is quite common for the system to have some inotify watches on some
> > >>>> config files or directories, so the optimization of no marks at all is
> > >>>> often not in effect.
> > >>>>
> > >>>> Content event (i.e. access,modify) watchers on sb/mount more rare, so
> > >>>> optimizing the case of no sb/mount marks with content events can improve
> > >>>> performance for more systems, especially for performance sensitive io
> > >>>> workloads.
> > >>>>
> > >>>> Set a per-sb flag SB_I_CONTENT_WATCHED if sb/mount marks with content
> > >>>> events in their mask exist and use that flag to optimize out the call to
> > >>>> __fsnotify_parent() and fsnotify() in fsnotify access/modify hooks.
> > >>>>
> > >>>> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > >>>
> > >>> ...
> > >>>
> > >>>> -static inline int fsnotify_file(struct file *file, __u32 mask)
> > >>>> +static inline int fsnotify_path(const struct path *path, __u32 mask)
> > >>>>  {
> > >>>> -     const struct path *path;
> > >>>> +     struct dentry *dentry = path->dentry;
> > >>>>
> > >>>> -     if (file->f_mode & FMODE_NONOTIFY)
> > >>>> +     if (!fsnotify_sb_has_watchers(dentry->d_sb))
> > >>>>               return 0;
> > >>>>
> > >>>> -     path = &file->f_path;
> > >>>> +     /* Optimize the likely case of sb/mount/parent not watching content */
> > >>>> +     if (mask & FSNOTIFY_CONTENT_EVENTS &&
> > >>>> +         likely(!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED)) &&
> > >>>> +         likely(!(dentry->d_sb->s_iflags & SB_I_CONTENT_WATCHED))) {
> > >>>> +             /*
> > >>>> +              * XXX: if SB_I_CONTENT_WATCHED is not set, checking for content
> > >>>> +              * events in s_fsnotify_mask is redundant, but it will be needed
> > >>>> +              * if we use the flag FS_MNT_CONTENT_WATCHED to indicate the
> > >>>> +              * existence of only mount content event watchers.
> > >>>> +              */
> > >>>> +             __u32 marks_mask = d_inode(dentry)->i_fsnotify_mask |
> > >>>> +                                dentry->d_sb->s_fsnotify_mask;
> > >>>> +
> > >>>> +             if (!(mask & marks_mask))
> > >>>> +                     return 0;
> > >>>> +     }
> > >>>
> > >>> So I'm probably missing something but how is all this patch different from:
> > >>>
> > >>>         if (likely(!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED))) {
> > >>>                 __u32 marks_mask = d_inode(dentry)->i_fsnotify_mask |
> > >>>                         path->mnt->mnt_fsnotify_mask |
> > >>
> > >> It's actually:
> > >>
> > >>                           real_mount(path->mnt)->mnt_fsnotify_mask
> > >>
> > >> and this requires including "internal/mount.h" in all the call sites.
> > >>
> > >>>                         dentry->d_sb->s_fsnotify_mask;
> > >>>                 if (!(mask & marks_mask))
> > >>>                         return 0;
> > >>>         }
> > >>>
> > >>> I mean (mask & FSNOTIFY_CONTENT_EVENTS) is true for the frequent events
> > >>> (read & write) we care about. In Jens' case
> > >>>
> > >>>         !(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED) &&
> > >>>         !(dentry->d_sb->s_iflags & SB_I_CONTENT_WATCHED)
> > >>>
> > >>> is true as otherwise we'd go right to fsnotify_parent() and so Jens
> > >>> wouldn't see the performance benefit. But then with your patch you fetch
> > >>> i_fsnotify_mask and s_fsnotify_mask anyway for the test so the only
> > >>> difference to what I suggest above is the path->mnt->mnt_fsnotify_mask
> > >>> fetch but that is equivalent to sb->s_iflags (or wherever we store that
> > >>> bit) fetch?
> > >>>
> > >>> So that would confirm that the parent handling costs in fsnotify_parent()
> > >>> is what's really making the difference and just avoiding that by checking
> > >>> masks early should be enough?
> > >>
> > >> Can't the benefit be also related to saving a function call?
> > >>
> > >> Only one way to find out...
> > >>
> > >> Jens,
> > >>
> > >> Can you please test attached v3 with a non-inlined fsnotify_path() helper?
> > >
> > > I can run it since it doesn't take much to do that, but there's no way
> > > parallel universe where saving a function call would yield those kinds
> > > of wins (or have that much cost).
> >
> > Ran this patch, and it's better than mainline for sure, but it does have
> > additional overhead that the previous version did not:
> >
> >                +1.46%  [kernel.vmlinux]  [k] fsnotify_path
> >
> 
> That is what I suspected would happen.
> 
> So at this time, we have patch v2 which looks like a clear win.
> It uses a slightly hackish SB_I_CONTENT_WATCHED to work around
> the fact that real_mount() is not accessible to the inlined call sites.

But won't it be better to move mnt_fsnotify_mask and perhaps
mnt_fsnotify_marks (to keep things in one place) into struct vfsmount in
that case? IMHO working around this visibility problem with extra flag (and
the code maintaining it) is not a great tradeoff...

As I wrote in my email to Jens I think your v3 patch just makes the real
cost of fsnotify checks visible in fsnotify_path() instead of being hidden
in the cost of read / write.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

