Return-Path: <linux-fsdevel+bounces-23685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78241931406
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 14:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B8291C21547
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 12:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA5218C18A;
	Mon, 15 Jul 2024 12:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N30hUtX6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rQI9CSLJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N30hUtX6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rQI9CSLJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF0F1850AF;
	Mon, 15 Jul 2024 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721046046; cv=none; b=rzqoFvSqHQgA6HYBbjDscASeIqgZHWbGgO271nduYFjXjkVbCIUtZM/YI4fkM9/uKT0jvafc6Mj5m46j5K7q9OAD1rJV25b5KM1lsIR9wwEc/RDPP5jXdJ24HZO2IJlsULSy0EPzmn0h6u6bz/uKjr8exJIx2VqJXgjSEY61sCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721046046; c=relaxed/simple;
	bh=9uzn5Usxj+9BAmkWT9T2U2eyx+fqo/0Yq+5Rf7irORk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPWP3+A60ZBi/e/gKAJ2eFKTMfyesvAjw7Cf9D7mwDg9a35qv0VnfC1VSO8umTRmjWy2T3a+6dSsAIH4Tez0NZcgqLjphY7DVh6zeMnT1JyNP38CE8xHoIu0f5Er0f/Yks7YLe+boSdYlrfcQpWbu2MEhD1SxNM/nTc/Qzier7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=N30hUtX6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rQI9CSLJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=N30hUtX6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rQI9CSLJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7FAD521BAC;
	Mon, 15 Jul 2024 12:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721046042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P+Mbv/X0MqHu+ywT7rkTT/iA7QS5ozIjP1l8oL0Yp/s=;
	b=N30hUtX64uHROHH37pYfpjWTKnAadC8ueIMegy4zp6hMdUEMEWYIRZYkEQNbweh1uk2iwr
	Wv/r87hF0VbJ+AhlTECHt0TmzfHtPx9xZlTf8kC9XPOOWPPdOQcliLcL9nhrDEgDO60Ung
	foyyJ0DGVD+x3SBq0WoytkjdZxOQKNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721046042;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P+Mbv/X0MqHu+ywT7rkTT/iA7QS5ozIjP1l8oL0Yp/s=;
	b=rQI9CSLJ6qqNERnuPg/44l+6Wr3TFpKFznfm/hQbDa5sE7mjZHZ0VZ04hOOtci348mTUJI
	s737NI4PNKBttMAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721046042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P+Mbv/X0MqHu+ywT7rkTT/iA7QS5ozIjP1l8oL0Yp/s=;
	b=N30hUtX64uHROHH37pYfpjWTKnAadC8ueIMegy4zp6hMdUEMEWYIRZYkEQNbweh1uk2iwr
	Wv/r87hF0VbJ+AhlTECHt0TmzfHtPx9xZlTf8kC9XPOOWPPdOQcliLcL9nhrDEgDO60Ung
	foyyJ0DGVD+x3SBq0WoytkjdZxOQKNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721046042;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P+Mbv/X0MqHu+ywT7rkTT/iA7QS5ozIjP1l8oL0Yp/s=;
	b=rQI9CSLJ6qqNERnuPg/44l+6Wr3TFpKFznfm/hQbDa5sE7mjZHZ0VZ04hOOtci348mTUJI
	s737NI4PNKBttMAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 755341395F;
	Mon, 15 Jul 2024 12:20:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9WiiHBoUlWZ9QQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 15 Jul 2024 12:20:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1F5ECA0987; Mon, 15 Jul 2024 14:20:27 +0200 (CEST)
Date: Mon, 15 Jul 2024 14:20:27 +0200
From: Jan Kara <jack@suse.cz>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+701037856c25b143f1ad@syzkaller.appspotmail.com>,
	amir73il@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] KCSAN: data-race in __fsnotify_parent /
 __fsnotify_recalc_mask (5)
Message-ID: <20240715122027.laabtspznjfi3f4l@quack3>
References: <000000000000dc5b12061c6cac00@google.com>
 <CACT4Y+Zk0ohwwwHSD63U2-PQ=UuamXczr1mKBD6xtj2dyYKBvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Zk0ohwwwHSD63U2-PQ=UuamXczr1mKBD6xtj2dyYKBvA@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Score: 2.70
X-Spamd-Result: default: False [2.70 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=5b9537cd00be479e];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[701037856c25b143f1ad];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[syzkaller.appspotmail.com,gmail.com,suse.cz,vger.kernel.org,googlegroups.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,syzkaller.appspot.com:url,imap1.dmz-prg2.suse.org:helo];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Level: **

On Thu 04-07-24 16:28:09, Dmitry Vyukov wrote:
> On Thu, 4 Jul 2024 at 16:22, syzbot
> <syzbot+701037856c25b143f1ad@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    795c58e4c7fc Merge tag 'trace-v6.10-rc6' of git://git.kern..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=16a6b6b9980000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=5b9537cd00be479e
> > dashboard link: https://syzkaller.appspot.com/bug?extid=701037856c25b143f1ad
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/3d1d205c1fdf/disk-795c58e4.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/641c78d42b7a/vmlinux-795c58e4.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/45ecf25d8ba3/bzImage-795c58e4.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+701037856c25b143f1ad@syzkaller.appspotmail.com
> >
> > EXT4-fs (loop3): unmounting filesystem 00000000-0000-0000-0000-000000000000.
> > ==================================================================
> > BUG: KCSAN: data-race in __fsnotify_parent / __fsnotify_recalc_mask
> >
> > write to 0xffff8881001c9d44 of 4 bytes by task 6671 on cpu 1:
> >  __fsnotify_recalc_mask+0x216/0x320 fs/notify/mark.c:248
> >  fsnotify_recalc_mask fs/notify/mark.c:265 [inline]
> >  fsnotify_add_mark_locked+0x703/0x870 fs/notify/mark.c:781
> >  fsnotify_add_inode_mark_locked include/linux/fsnotify_backend.h:812 [inline]
> >  inotify_new_watch fs/notify/inotify/inotify_user.c:620 [inline]
> >  inotify_update_watch fs/notify/inotify/inotify_user.c:647 [inline]
> >  __do_sys_inotify_add_watch fs/notify/inotify/inotify_user.c:786 [inline]
> >  __se_sys_inotify_add_watch+0x66f/0x810 fs/notify/inotify/inotify_user.c:729
> >  __x64_sys_inotify_add_watch+0x43/0x50 fs/notify/inotify/inotify_user.c:729
> >  x64_sys_call+0x2af1/0x2d70 arch/x86/include/generated/asm/syscalls_64.h:255
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > read to 0xffff8881001c9d44 of 4 bytes by task 10004 on cpu 0:
> >  fsnotify_object_watched fs/notify/fsnotify.c:187 [inline]
> >  __fsnotify_parent+0xd4/0x370 fs/notify/fsnotify.c:217
> >  fsnotify_parent include/linux/fsnotify.h:96 [inline]
> >  fsnotify_file include/linux/fsnotify.h:131 [inline]
> >  fsnotify_open include/linux/fsnotify.h:401 [inline]
> >  vfs_open+0x1be/0x1f0 fs/open.c:1093
> >  do_open fs/namei.c:3654 [inline]
> >  path_openat+0x1ad9/0x1fa0 fs/namei.c:3813
> >  do_filp_open+0xf7/0x200 fs/namei.c:3840
> >  do_sys_openat2+0xab/0x120 fs/open.c:1413
> >  do_sys_open fs/open.c:1428 [inline]
> >  __do_sys_openat fs/open.c:1444 [inline]
> >  __se_sys_openat fs/open.c:1439 [inline]
> >  __x64_sys_openat+0xf3/0x120 fs/open.c:1439
> >  x64_sys_call+0x1057/0x2d70 arch/x86/include/generated/asm/syscalls_64.h:258
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > value changed: 0x00000000 -> 0x00002008
> >
> > Reported by Kernel Concurrency Sanitizer on:
> > CPU: 0 PID: 10004 Comm: syz-executor Not tainted 6.10.0-rc6-syzkaller-00069-g795c58e4c7fc #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
> > ==================================================================
> 
> 
> I think __fsnotify_recalc_mask() can be compiled along the lines of:
> 
> *fsnotify_conn_mask_p(conn) = 0;
> hlist_for_each_entry(mark, &conn->list, obj_list) {
>    ...
>    *fsnotify_conn_mask_p(conn) |= fsnotify_calc_mask(mark);
>    ...
> }
> 
> And then fsnotify_object_watched() may falsely return that it's not
> watched (if it observes 0, or any other incomplete value).

Yeah, a vicious compiler could do this. Probably we should use WRITE_ONCE()
when setting *fsnotify_conn_mask_p(conn). Thanks for report!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

