Return-Path: <linux-fsdevel+bounces-41411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC02A2F090
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 16:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CCEF167A14
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 15:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A0E23CEE9;
	Mon, 10 Feb 2025 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tx/9VjYP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vvx0EZa5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ka5txNQF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LIjosRce"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED012237185
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 14:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739199509; cv=none; b=cKoUwSQB8JujbgwI1lp2W7ecUj30Yujy0IS4t5hXslENjzejHcvj7mAztmytYTPl5Qc+IA7U4CJIwKchS8SywBY1NgYDhGdtU1+BvSjoY5CC2IGKFOFv02bl68UyyMYir+wNKydq08mLuWwFw35dH9STa1vrn4LABj8uhc46wKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739199509; c=relaxed/simple;
	bh=DSD0zYhwDELD61sxpSjE03ssnwGIcDfGWHrcimFryE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSfkZ/E4PZBUDSqWF0eQqieiwCoPmgOfP8T9LJWwvX83XWYRmkSFQ57MBLaUprIV1u6QKUIYByf3YOgcUBskqLqxWPk2SyQDZc71Nk35SWeygE7FdpUFSp6ovGDOAkDaj6HAhNXRihg+Q0gfUkSVb+MI3EiHstkBr4W2WhHpHQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tx/9VjYP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vvx0EZa5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ka5txNQF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LIjosRce; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E709121137;
	Mon, 10 Feb 2025 14:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739199506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2fD1sxfSNcfvE2oaK3cNgTkdXh8/b6/naCbvOYiaSI8=;
	b=tx/9VjYPhWrDjFvwHOEvzobyeSdQWJumbrEf/QfzO3Bvplm6qi2+ht8Qrt6+d9RtfNDXdv
	ZNQqExokbuSze1lh26FDq0Sx+FEQUlcxHphhz4Siz5k8dBbmhLa9+LVxtCV2KkqC1yxJnn
	6veQDMAxsqHgLm97086yyaAT5AnxD+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739199506;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2fD1sxfSNcfvE2oaK3cNgTkdXh8/b6/naCbvOYiaSI8=;
	b=Vvx0EZa5M2WxXPMJREbiFWHcIBD1Z2puQ3g0cIFl/tuxAOfqwbcZw9ASml5zX/O8qr9rHn
	Z9uYmkUEQv06NXBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739199505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2fD1sxfSNcfvE2oaK3cNgTkdXh8/b6/naCbvOYiaSI8=;
	b=ka5txNQFnSdJy3dInSyiNLi5NqrZhOlQsVQKVS8di/86a1FdEwbbn2HZoAAve7uxt4xrY8
	8zkm46lj7t2+38f0zhARgBpWCljMfx0DZBbfP1kBIJGAlv+xDsAkt3hDm+qFZ2JsE/ZjMA
	v44LIz9XIJu5df38PBmn3u6Hq5Hj2l4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739199505;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2fD1sxfSNcfvE2oaK3cNgTkdXh8/b6/naCbvOYiaSI8=;
	b=LIjosRceJ3EKSB/JDkqWsC8owawiZoVpLHv9TCaO8RPsi+mP2d7DGOkedHbn/Ud30sLYcQ
	k5Kq6LCnA1qlk1BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC98B13707;
	Mon, 10 Feb 2025 14:58:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JsvXNREUqmf9KwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 10 Feb 2025 14:58:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 67CFDA095C; Mon, 10 Feb 2025 15:58:17 +0100 (CET)
Date: Mon, 10 Feb 2025 15:58:17 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH] fs: don't needlessly acquire f_lock
Message-ID: <rdvlpbbybxrlti5xywzlcmtq63ln2evibmzeqf3lvmyclaumsd@2s43fhbmrxqg>
References: <20250207-daten-mahlzeit-99d2079864fb@brauner>
 <hn5go2srp6csjkckh3sgru7moukgsa3glsvc6bwd5leabzamw6@osxrfpjw5wqq>
 <CAGudoHGGW0BZcqyWbEV7x3rtQnRCkhhkbHNhYB0QeihSnE0VTA@mail.gmail.com>
 <20250210-urfassung-heerscharen-aa9c46a64724@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250210-urfassung-heerscharen-aa9c46a64724@brauner>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,vger.kernel.org,kernel.org,zeniv.linux.org.uk];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 10-02-25 13:01:38, Christian Brauner wrote:
> On Fri, Feb 07, 2025 at 05:42:17PM +0100, Mateusz Guzik wrote:
> > On Fri, Feb 7, 2025 at 4:50 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Fri 07-02-25 15:10:33, Christian Brauner wrote:
> > > > Before 2011 there was no meaningful synchronization between
> > > > read/readdir/write/seek. Only in commit
> > > > ef3d0fd27e90 ("vfs: do (nearly) lockless generic_file_llseek")
> > > > synchronization was added for SEEK_CUR by taking f_lock around
> > > > vfs_setpos().
> > > >
> > > > Then in 2014 full synchronization between read/readdir/write/seek was
> > > > added in commit 9c225f2655e3 ("vfs: atomic f_pos accesses as per POSIX")
> > > > by introducing f_pos_lock for regular files with FMODE_ATOMIC_POS and
> > > > for directories. At that point taking f_lock became unnecessary for such
> > > > files.
> > > >
> > > > So only acquire f_lock for SEEK_CUR if this isn't a file that would have
> > > > acquired f_pos_lock if necessary.
> > > >
> > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > >
> > > ...
> > >
> > > >       if (whence == SEEK_CUR) {
> > > > +             bool locked;
> > > > +
> > > >               /*
> > > > -              * f_lock protects against read/modify/write race with
> > > > -              * other SEEK_CURs. Note that parallel writes and reads
> > > > -              * behave like SEEK_SET.
> > > > +              * If the file requires locking via f_pos_lock we know
> > > > +              * that mutual exclusion for SEEK_CUR on the same file
> > > > +              * is guaranteed. If the file isn't locked, we take
> > > > +              * f_lock to protect against f_pos races with other
> > > > +              * SEEK_CURs.
> > > >                */
> > > > -             guard(spinlock)(&file->f_lock);
> > > > -             return vfs_setpos(file, file->f_pos + offset, maxsize);
> > > > +             locked = (file->f_mode & FMODE_ATOMIC_POS) ||
> > > > +                      file->f_op->iterate_shared;
> > >
> > > As far as I understand the rationale this should match to
> > > file_needs_f_pos_lock() (or it can possibly be weaker) but it isn't obvious
> > > to me that's the case. After thinking about possibilities, I could convince
> > > myself that what you suggest is indeed safe but the condition being in two
> > > completely independent places and leading to subtle bugs if it gets out of
> > > sync seems a bit fragile to me.
> > >
> > 
> > A debug-only assert that the lock is held when expected should sort it out?
> 
> Good idea. Let me reuse the newly added infra:
> VFS_WARN_ON_ONCE(locked && !mutex_is_locked(&file->f_pos_lock));

Fine, but won't this actually trigger? file_needs_f_pos_lock() is:

        return (file->f_mode & FMODE_ATOMIC_POS) &&
                (file_count(file) > 1 || file->f_op->iterate_shared);

and here you have:

        locked = (file->f_mode & FMODE_ATOMIC_POS) ||
                  file->f_op->iterate_shared;

So if (file->f_mode & FMODE_ATOMIC_POS) and (file_count(file) == 1),
file_needs_f_pos_lock() returns false but locked is true?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

