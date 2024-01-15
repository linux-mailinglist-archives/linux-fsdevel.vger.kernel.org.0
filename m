Return-Path: <linux-fsdevel+bounces-7952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0B582DD14
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 17:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26420283BE9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 16:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A47179B0;
	Mon, 15 Jan 2024 16:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="H/hvCgy6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wrr/XBA/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yT8z0Irb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DTKCQ665"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380E9179A8
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 16:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 358682219E;
	Mon, 15 Jan 2024 16:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705335100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=26DBs4hiTidka38oOUzHxGODeBMOmjtPA79oDl8BMTY=;
	b=H/hvCgy6ahFpIxpPhuPsBslWWxICBwHS9D5N/ORxXWx58VWYQA8SUBKt79F7hC1PzcS9ao
	OZNqeX9JuiwuJOs9vExRmYRxg5siT/Fv9paZ9SRrvH7DUeIXeDXmiV/Q1qGnYD4ooP14/k
	ovWLfkAa5x1rddfmyE6fpClDJ1rHtXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705335100;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=26DBs4hiTidka38oOUzHxGODeBMOmjtPA79oDl8BMTY=;
	b=wrr/XBA/aXhR6bJxYv4z9ps/pajhmJ+EoVUcfg+4Knd/AHzI/b1am3/vRkzdk8ElP/if9D
	AKuqhIsrvXMkbEBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705335098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=26DBs4hiTidka38oOUzHxGODeBMOmjtPA79oDl8BMTY=;
	b=yT8z0IrbDkZd1dXJlvixwEoGr6jgoUHE9W92q+6vbu3q6zlgNXUNY6DSAcB4pGLnjeugg3
	aNoM4xvAm3nNFFTxFtyZf5HovnHIohOqeRuLdmUEdRE3RTJ69n6hLINBZLHyFdX8B2tfAs
	IUSRdJuAnadqcw7kOmxMK5c/wYOgK08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705335098;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=26DBs4hiTidka38oOUzHxGODeBMOmjtPA79oDl8BMTY=;
	b=DTKCQ665O9kvh+yQd3B2i4Tg8tAWPyhwpQ19MS6l+Vjtr/ZyksuD1UKLm41JqbueNzGsjj
	a5be+T1AvJkoP8DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 266C0136F5;
	Mon, 15 Jan 2024 16:11:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id buoNCTpZpWXHFAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 15 Jan 2024 16:11:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B352EA07EA; Mon, 15 Jan 2024 17:11:37 +0100 (CET)
Date: Mon, 15 Jan 2024 17:11:37 +0100
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH v2] fsnotify: optimize the case of no content event
 watchers
Message-ID: <20240115161137.35xta2j4llszyweu@quack3>
References: <20240111152233.352912-1-amir73il@gmail.com>
 <20240112110936.ibz4s42x75mjzhlv@quack3>
 <CAOQ4uxgAGpBTeEyqJTSGn5OvqaxsVP3yXR6zuS-G9QWnTjoV9w@mail.gmail.com>
 <ec5c6dde-e8dd-4778-a488-886deaf72c89@kernel.dk>
 <4a35c78e-98d4-4edb-b7bf-8a6d1df3c554@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a35c78e-98d4-4edb-b7bf-8a6d1df3c554@kernel.dk>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[gmail.com,suse.cz,kernel.org,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Fri 12-01-24 07:11:42, Jens Axboe wrote:
> On 1/12/24 6:58 AM, Jens Axboe wrote:
> > On 1/12/24 6:00 AM, Amir Goldstein wrote:
> >> On Fri, Jan 12, 2024 at 1:09?PM Jan Kara <jack@suse.cz> wrote:
> >>>
> >>> On Thu 11-01-24 17:22:33, Amir Goldstein wrote:
> >>>> Commit e43de7f0862b ("fsnotify: optimize the case of no marks of any type")
> >>>> optimized the case where there are no fsnotify watchers on any of the
> >>>> filesystem's objects.
> >>>>
> >>>> It is quite common for a system to have a single local filesystem and
> >>>> it is quite common for the system to have some inotify watches on some
> >>>> config files or directories, so the optimization of no marks at all is
> >>>> often not in effect.
> >>>>
> >>>> Content event (i.e. access,modify) watchers on sb/mount more rare, so
> >>>> optimizing the case of no sb/mount marks with content events can improve
> >>>> performance for more systems, especially for performance sensitive io
> >>>> workloads.
> >>>>
> >>>> Set a per-sb flag SB_I_CONTENT_WATCHED if sb/mount marks with content
> >>>> events in their mask exist and use that flag to optimize out the call to
> >>>> __fsnotify_parent() and fsnotify() in fsnotify access/modify hooks.
> >>>>
> >>>> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >>>
> >>> ...
> >>>
> >>>> -static inline int fsnotify_file(struct file *file, __u32 mask)
> >>>> +static inline int fsnotify_path(const struct path *path, __u32 mask)
> >>>>  {
> >>>> -     const struct path *path;
> >>>> +     struct dentry *dentry = path->dentry;
> >>>>
> >>>> -     if (file->f_mode & FMODE_NONOTIFY)
> >>>> +     if (!fsnotify_sb_has_watchers(dentry->d_sb))
> >>>>               return 0;
> >>>>
> >>>> -     path = &file->f_path;
> >>>> +     /* Optimize the likely case of sb/mount/parent not watching content */
> >>>> +     if (mask & FSNOTIFY_CONTENT_EVENTS &&
> >>>> +         likely(!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED)) &&
> >>>> +         likely(!(dentry->d_sb->s_iflags & SB_I_CONTENT_WATCHED))) {
> >>>> +             /*
> >>>> +              * XXX: if SB_I_CONTENT_WATCHED is not set, checking for content
> >>>> +              * events in s_fsnotify_mask is redundant, but it will be needed
> >>>> +              * if we use the flag FS_MNT_CONTENT_WATCHED to indicate the
> >>>> +              * existence of only mount content event watchers.
> >>>> +              */
> >>>> +             __u32 marks_mask = d_inode(dentry)->i_fsnotify_mask |
> >>>> +                                dentry->d_sb->s_fsnotify_mask;
> >>>> +
> >>>> +             if (!(mask & marks_mask))
> >>>> +                     return 0;
> >>>> +     }
> >>>
> >>> So I'm probably missing something but how is all this patch different from:
> >>>
> >>>         if (likely(!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED))) {
> >>>                 __u32 marks_mask = d_inode(dentry)->i_fsnotify_mask |
> >>>                         path->mnt->mnt_fsnotify_mask |
> >>
> >> It's actually:
> >>
> >>                           real_mount(path->mnt)->mnt_fsnotify_mask
> >>
> >> and this requires including "internal/mount.h" in all the call sites.
> >>
> >>>                         dentry->d_sb->s_fsnotify_mask;
> >>>                 if (!(mask & marks_mask))
> >>>                         return 0;
> >>>         }
> >>>
> >>> I mean (mask & FSNOTIFY_CONTENT_EVENTS) is true for the frequent events
> >>> (read & write) we care about. In Jens' case
> >>>
> >>>         !(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED) &&
> >>>         !(dentry->d_sb->s_iflags & SB_I_CONTENT_WATCHED)
> >>>
> >>> is true as otherwise we'd go right to fsnotify_parent() and so Jens
> >>> wouldn't see the performance benefit. But then with your patch you fetch
> >>> i_fsnotify_mask and s_fsnotify_mask anyway for the test so the only
> >>> difference to what I suggest above is the path->mnt->mnt_fsnotify_mask
> >>> fetch but that is equivalent to sb->s_iflags (or wherever we store that
> >>> bit) fetch?
> >>>
> >>> So that would confirm that the parent handling costs in fsnotify_parent()
> >>> is what's really making the difference and just avoiding that by checking
> >>> masks early should be enough?
> >>
> >> Can't the benefit be also related to saving a function call?
> >>
> >> Only one way to find out...
> >>
> >> Jens,
> >>
> >> Can you please test attached v3 with a non-inlined fsnotify_path() helper?
> > 
> > I can run it since it doesn't take much to do that, but there's no way
> > parallel universe where saving a function call would yield those kinds
> > of wins (or have that much cost).
> 
> Ran this patch, and it's better than mainline for sure, but it does have
> additional overhead that the previous version did not:
> 
>                +1.46%  [kernel.vmlinux]  [k] fsnotify_path

So did you see any effect in IOPS or just this difference in perf profile?
Because Amir's patch took a bunch of code that was previously inlined
(thus its cost was blended with the cost of the rest of the read/write
code) and moved it to this new fsnotify_path() function so its cost is now
visible...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

