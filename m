Return-Path: <linux-fsdevel+bounces-41672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9D4A349ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 17:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 791A91725AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 16:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DA8287DFC;
	Thu, 13 Feb 2025 16:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xkZUBMLe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QTtAQxKz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="V8elntol";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RxtUhQ7w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6F2287DE3
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Feb 2025 16:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739463482; cv=none; b=N0SHuX6w5Bf3UcD2QUM+O+HTyz2BBh7HDweWt+IOKfm8wn80anbBUqhoOuaSYXgHkaj/oLQvN/MePPEEvE74rQQY6nOCycDdvU4GlthMcoaUEtZx4a5UzZc2OI5N/LK7B9t3Z0C5DCipmg0S1r5Oct+V6EHG2ReSyyhjqQzwMMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739463482; c=relaxed/simple;
	bh=lcGFmphFiDkZ11iyKKcjjcDc1hs9YE1WkpeN8GgUmiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDq1nVxMqzdGJN5SfgpqUattrVsxSkCpTa72GU1T0K9NTlmK4M43+JIipvhcVSsq7ACwsaYVHz6Ngp+2Lxl6vyD2CF/kmfItCHMbOyuOacKXQDx89jJg1OJp7YbMznt9oanJNg0CtiNw1d23rsIAHx/2E7urwEQjbRJlqc6dEqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=fail smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xkZUBMLe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QTtAQxKz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=V8elntol; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RxtUhQ7w; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9BC9A1FD65;
	Thu, 13 Feb 2025 16:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739463472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XwkyiBPCw1vmrpaqdbIb9dgcFk6aUyjw3f+yJ65vbs0=;
	b=xkZUBMLeD0SubqpytSDqh78tgLvIgql56YLAJpUY+lH9UHxDW5LzV6ci82DS+95l4i0eNN
	VAnUIk4zoyEhXj9HFUD2dSxiYqDySYemsHm7i4NiuknT/n7mCdyOL8nktDHSCESycEYPaq
	kOynBGhwmi1ppi2wnhRpgpkYR6NbAdA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739463472;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XwkyiBPCw1vmrpaqdbIb9dgcFk6aUyjw3f+yJ65vbs0=;
	b=QTtAQxKzUwY8TVPY31ZcBJyx9PB3R92ArWTHDWbi2fg7ezLpVANVzoi7ENsja23Q66TCnN
	6WX3nZCI713kBhCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=V8elntol;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RxtUhQ7w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739463471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XwkyiBPCw1vmrpaqdbIb9dgcFk6aUyjw3f+yJ65vbs0=;
	b=V8elntolzlt68+3HueA+wcJJg+FkrHQaY5fz8n5bpxQoiN7ER+0K5Hmd44+bd/4X2B5XC4
	/pYOwNlTGyXddwxfWieK7qxC2VXw0UpWIdCwW1kW6ZxJXOFupHbVwXgVgRCf/SlG0T95rY
	ooIN/QHTU/Gu2TNOLbuwmCTJ/3n5TKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739463471;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XwkyiBPCw1vmrpaqdbIb9dgcFk6aUyjw3f+yJ65vbs0=;
	b=RxtUhQ7wGrxAg8ZlZMenp6768Jmn0o+3A53+a2pL12mlokm1op2mkg9yGBAKh6j/0LeGbc
	Jvw33XykoDZxSaCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 77F36137DB;
	Thu, 13 Feb 2025 16:17:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oqjvHC8brmc7EAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 13 Feb 2025 16:17:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 18DE2A29EE; Thu, 13 Feb 2025 17:17:47 +0100 (CET)
Date: Thu, 13 Feb 2025 17:17:47 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Mateusz Guzik <mjguzik@gmail.com>, 
	linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH] fs: don't needlessly acquire f_lock
Message-ID: <wihnxaufypstxgheadnh3egamdlja5yt6b5nwt7uox2e3coppn@6nma7zh2i3cp>
References: <20250207-daten-mahlzeit-99d2079864fb@brauner>
 <hn5go2srp6csjkckh3sgru7moukgsa3glsvc6bwd5leabzamw6@osxrfpjw5wqq>
 <CAGudoHGGW0BZcqyWbEV7x3rtQnRCkhhkbHNhYB0QeihSnE0VTA@mail.gmail.com>
 <20250210-urfassung-heerscharen-aa9c46a64724@brauner>
 <rdvlpbbybxrlti5xywzlcmtq63ln2evibmzeqf3lvmyclaumsd@2s43fhbmrxqg>
 <20250213-eskalation-hellblau-cba3b6377b36@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250213-eskalation-hellblau-cba3b6377b36@brauner>
X-Rspamd-Queue-Id: 9BC9A1FD65
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org,kernel.org,zeniv.linux.org.uk];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 13-02-25 16:10:55, Christian Brauner wrote:
> On Mon, Feb 10, 2025 at 03:58:17PM +0100, Jan Kara wrote:
> > On Mon 10-02-25 13:01:38, Christian Brauner wrote:
> > > On Fri, Feb 07, 2025 at 05:42:17PM +0100, Mateusz Guzik wrote:
> > > > On Fri, Feb 7, 2025 at 4:50 PM Jan Kara <jack@suse.cz> wrote:
> > > > >
> > > > > On Fri 07-02-25 15:10:33, Christian Brauner wrote:
> > > > > > Before 2011 there was no meaningful synchronization between
> > > > > > read/readdir/write/seek. Only in commit
> > > > > > ef3d0fd27e90 ("vfs: do (nearly) lockless generic_file_llseek")
> > > > > > synchronization was added for SEEK_CUR by taking f_lock around
> > > > > > vfs_setpos().
> > > > > >
> > > > > > Then in 2014 full synchronization between read/readdir/write/seek was
> > > > > > added in commit 9c225f2655e3 ("vfs: atomic f_pos accesses as per POSIX")
> > > > > > by introducing f_pos_lock for regular files with FMODE_ATOMIC_POS and
> > > > > > for directories. At that point taking f_lock became unnecessary for such
> > > > > > files.
> > > > > >
> > > > > > So only acquire f_lock for SEEK_CUR if this isn't a file that would have
> > > > > > acquired f_pos_lock if necessary.
> > > > > >
> > > > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > > >
> > > > > ...
> > > > >
> > > > > >       if (whence == SEEK_CUR) {
> > > > > > +             bool locked;
> > > > > > +
> > > > > >               /*
> > > > > > -              * f_lock protects against read/modify/write race with
> > > > > > -              * other SEEK_CURs. Note that parallel writes and reads
> > > > > > -              * behave like SEEK_SET.
> > > > > > +              * If the file requires locking via f_pos_lock we know
> > > > > > +              * that mutual exclusion for SEEK_CUR on the same file
> > > > > > +              * is guaranteed. If the file isn't locked, we take
> > > > > > +              * f_lock to protect against f_pos races with other
> > > > > > +              * SEEK_CURs.
> > > > > >                */
> > > > > > -             guard(spinlock)(&file->f_lock);
> > > > > > -             return vfs_setpos(file, file->f_pos + offset, maxsize);
> > > > > > +             locked = (file->f_mode & FMODE_ATOMIC_POS) ||
> > > > > > +                      file->f_op->iterate_shared;
> > > > >
> > > > > As far as I understand the rationale this should match to
> > > > > file_needs_f_pos_lock() (or it can possibly be weaker) but it isn't obvious
> > > > > to me that's the case. After thinking about possibilities, I could convince
> > > > > myself that what you suggest is indeed safe but the condition being in two
> > > > > completely independent places and leading to subtle bugs if it gets out of
> > > > > sync seems a bit fragile to me.
> > > > >
> > > > 
> > > > A debug-only assert that the lock is held when expected should sort it out?
> > > 
> > > Good idea. Let me reuse the newly added infra:
> > > VFS_WARN_ON_ONCE(locked && !mutex_is_locked(&file->f_pos_lock));
> > 
> > Fine, but won't this actually trigger? file_needs_f_pos_lock() is:
> > 
> >         return (file->f_mode & FMODE_ATOMIC_POS) &&
> >                 (file_count(file) > 1 || file->f_op->iterate_shared);
> > 
> > and here you have:
> > 
> >         locked = (file->f_mode & FMODE_ATOMIC_POS) ||
> >                   file->f_op->iterate_shared;
> > 
> > So if (file->f_mode & FMODE_ATOMIC_POS) and (file_count(file) == 1),
> > file_needs_f_pos_lock() returns false but locked is true?
> 
> Sorry, I got lost in other mails.
> Yes, you're right. I had changed the patch in my tree to fix that.
> I'll append it here. Sorry about that. Tell me if that looks sane ok to
> you now.

Looks good to me! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

