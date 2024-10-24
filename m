Return-Path: <linux-fsdevel+bounces-32794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE849AECC6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 18:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3EA8B22FBB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 16:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863571F8EFA;
	Thu, 24 Oct 2024 16:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="S6peyEaN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UmKlERt1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SsMKWfWr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gK+Esa+s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AED1F4FC2
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 16:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729789011; cv=none; b=K6f9CLTXroxh4spRQ7423i89VMBhPJf5VOWXJXI01HpV8R2qbtcF0CRCWnBnnO28B6JcVP4yTay+92jIHFLq5JLViNuwX+SXt7uChb7t8oN5z0nan67WmFN5Y8OtoeycMBID0ruM1qCQ3+LlHYPeRISLoexWaOTu5ZbkK34q1e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729789011; c=relaxed/simple;
	bh=HmnOHA0M2c61J0WBT/QLG2v5mwOerXwiRNJPI3F2mtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsfSOmMeQkJKitLV6RwJ84rUMynr9aHGh7kL5pmr9e0lr5Aa3b6zbSynSPpuTVygiZK0hZCnClKbVWrCdQajdRWY/bEr925NP9yt+dj3Gr0wzoOsBv4QHu5ZI3WFDERqxiu6TkJUmzKNo3Wvt6psynHyFVfG4u7k3mObfUg1nps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=S6peyEaN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UmKlERt1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SsMKWfWr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gK+Esa+s; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E0CBA1F78E;
	Thu, 24 Oct 2024 16:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729788988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wvRUik8nzmwVZOtnalfRrFvizzg4PE47VhmZtcPCzik=;
	b=S6peyEaNDKngzD4qzOw7afhfwAlr7HdRkRiZR9X6YBSL3dONdzcQB31Pxprwq3uGlEN9Wr
	KR8lpiQ8sskE1iDwgWZyBZEZy4CO15OQhWu6rvm5m37Tg6ofW6yxTsR+xsw4aaVbBDGOXV
	ia8C+hb5+ScD4iuVHL2MehrBJ7I8Ivk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729788988;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wvRUik8nzmwVZOtnalfRrFvizzg4PE47VhmZtcPCzik=;
	b=UmKlERt1XPjeacgnif4nc8L867+G4+k/HeTwFYbKDHzV/UeV2n8s3RSc+lqePZ5IalGxZg
	n0ALk1byGulLJxAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729788987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wvRUik8nzmwVZOtnalfRrFvizzg4PE47VhmZtcPCzik=;
	b=SsMKWfWrfqTcTg6V2UJ8U1XApUOhwylYInGoVNbe0G7Fv9sWhzvIMySCRbn8UA3oQ3T3Cs
	pKCwcxEMuBMQUz2Nby/G9+Hb9Qqqbv5/UKK48l3tSgQMWRqjC+9v/zfjLaXEp4aDDlNav4
	AQfa7IKOxWz42XrzJnIMb04BVOC/U4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729788987;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wvRUik8nzmwVZOtnalfRrFvizzg4PE47VhmZtcPCzik=;
	b=gK+Esa+s2F2nP4XHtjIwd0lseDdhe/JyAmsaj2UeOmT3+sKMglEzhoIXaJeD7IMhtPuGKq
	9ZvT6oaLF+kCtBBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D7153136F5;
	Thu, 24 Oct 2024 16:56:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZNV6NDt8Gme8XgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 24 Oct 2024 16:56:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8E781A083F; Thu, 24 Oct 2024 18:56:27 +0200 (CEST)
Date: Thu, 24 Oct 2024 18:56:27 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
	kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Subject: Re: [PATCH 08/10] fanotify: report file range info with pre-content
 events
Message-ID: <20241024165627.ab5q46tf32by56yn@quack3>
References: <cover.1721931241.git.josef@toxicpanda.com>
 <1a378ca2df2ce30e5aecf7145223906a427d9037.1721931241.git.josef@toxicpanda.com>
 <20240801173831.5uzwvhzdqro3om3q@quack3>
 <CAOQ4uxg-yjHnDfBnu4ZVGnzA8k2UpFr+3aTLDPa6kSXBxxJ6=w@mail.gmail.com>
 <20241024163508.qlwxu65lgft5q3po@quack3>
 <CAOQ4uxgf0M2oE1kpZSw+tWv72tp55yHh385vr1D0VAeO1f-yAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgf0M2oE1kpZSw+tWv72tp55yHh385vr1D0VAeO1f-yAg@mail.gmail.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 24-10-24 18:49:02, Amir Goldstein wrote:
> On Thu, Oct 24, 2024 at 6:35 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 24-10-24 12:06:35, Amir Goldstein wrote:
> > > On Thu, Aug 1, 2024 at 7:38 PM Jan Kara <jack@suse.cz> wrote:
> > > > On Thu 25-07-24 14:19:45, Josef Bacik wrote:
> > > > > From: Amir Goldstein <amir73il@gmail.com>
> > > > >
> > > > > With group class FAN_CLASS_PRE_CONTENT, report offset and length info
> > > > > along with FAN_PRE_ACCESS and FAN_PRE_MODIFY permission events.
> > > > >
> > > > > This information is meant to be used by hierarchical storage managers
> > > > > that want to fill partial content of files on first access to range.
> > > > >
> > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > > ---
> > > > >  fs/notify/fanotify/fanotify.h      |  8 +++++++
> > > > >  fs/notify/fanotify/fanotify_user.c | 38 ++++++++++++++++++++++++++++++
> > > > >  include/uapi/linux/fanotify.h      |  7 ++++++
> > > > >  3 files changed, 53 insertions(+)
> > > > >
> > > > > diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> > > > > index 93598b7d5952..7f06355afa1f 100644
> > > > > --- a/fs/notify/fanotify/fanotify.h
> > > > > +++ b/fs/notify/fanotify/fanotify.h
> > > > > @@ -448,6 +448,14 @@ static inline bool fanotify_is_perm_event(u32 mask)
> > > > >               mask & FANOTIFY_PERM_EVENTS;
> > > > >  }
> > > > >
> > > > > +static inline bool fanotify_event_has_access_range(struct fanotify_event *event)
> > > > > +{
> > > > > +     if (!(event->mask & FANOTIFY_PRE_CONTENT_EVENTS))
> > > > > +             return false;
> > > > > +
> > > > > +     return FANOTIFY_PERM(event)->ppos;
> > > > > +}
> > > >
> > > > Now I'm a bit confused. Can we have legally NULL ppos for an event from
> > > > FANOTIFY_PRE_CONTENT_EVENTS?
> > > >
> > >
> > > Sorry for the very late reply...
> > >
> > > The short answer is that NULL FANOTIFY_PERM(event)->ppos
> > > simply means that fanotify_alloc_perm_event() was called with NULL
> > > range, which is the very common case of legacy permission events.
> > >
> > > The long answer is a bit convoluted, so bare with me.
> > > The long answer is to the question whether fsnotify_file_range() can
> > > be called with a NULL ppos.
> > >
> > > This shouldn't be possible AFAIK for regular files and directories,
> > > unless some fs that is marked with FS_ALLOW_HSM opens a regular
> > > file with FMODE_STREAM, which should not be happening IMO,
> > > but then the assertion belongs inside fsnotify_file_range().
> > >
> > > However, there was another way to get NULL ppos before I added the patch
> > > "fsnotify: generate pre-content permission event on open"
> > >
> > > Which made this "half intentional" change:
> > >  static inline int fsnotify_file_perm(struct file *file, int perm_mask)
> > >  {
> > > -       return fsnotify_file_area_perm(file, perm_mask, NULL, 0);
> > > +       return fsnotify_file_area_perm(file, perm_mask, &file->f_pos, 0);
> > >  }
> > >
> > > In order to implement:
> > > "The event will have a range info of (0..0) to provide an opportunity
> > >  to fill the entire file content on open."
> > >
> > > The problem is that do_open() was not the only caller of fsnotify_file_perm().
> > > There is another call from iterate_dir() and the change above causes
> > > FS_PRE_ACCESS events on readdir to report the directory f_pos -
> > > Do we want that? I think we do, but HSM should be able to tell the
> > > difference between opendir() and readdir(), because my HSM only
> > > wants to fill dir content on the latter.
> >
> > Well, I'm not so sure we want to report fpos on opendir / readdir(). For
> > directories fpos is an opaque cookie that is filesystem dependent and you
> > are not even allowed to carry it from open to open. It is valid only within
> > that one open-close session if I remember right. So userspace HSM cannot do
> > much with it and in my opinion reporting it to userspace is a recipe for
> > abuse...
> >
> > I'm undecided whether we want to allow pre-access events without range or
> > enforce 0-0 range. I don't think there's a big practical difference.
> >
> 
> So there is a practical difference.
> My HSM wants to fill dir content on readdir() and not on opendir().
> Other HSMs may want to fill dir content on opendir().
> It could do that if opendir() (as does open()) reports range [0..0]
> and readdir() reports no range.

OK, this looks reasonably consistent so ack from me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

