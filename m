Return-Path: <linux-fsdevel+bounces-35400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0F59D4A1D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 10:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EF801F21972
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 09:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B3A1CD202;
	Thu, 21 Nov 2024 09:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fyborDxb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ngieK/es";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fyborDxb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ngieK/es"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405CC126C05;
	Thu, 21 Nov 2024 09:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732181963; cv=none; b=m51oRYOoxiWagEwA6wH3h0BIbhCJkB5fczt+Jo8El0AOwKGpMfQOrVMjMqhkzw9lWJBJ6eHThQozQvxc/GL4I8bCf8pCkDryMNGFbJ8BMJy2MMmsxicTRJEsKmuqEhlFTBK9vrQbuwfLX/debHAYTub6H/Y19guoe9DVNpxaJxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732181963; c=relaxed/simple;
	bh=cNZsnsZB5O/BQPgmY0Q+EjFt17ILS5+vIQ5R2ceUhEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRyHYBtNqkbfu47TABXhgFVxCKv9ABHIshqb62Lo40Nkp0eeDpGkHI4LfXBejzhZeQDKyfZ5tVLdNeDb7lzTvGh8FeN1ckgVYY0PA8cOxxdGKir1kzD+oHoDuB4NKQyr7ZSWPruNDhBQi46yj5taZOvEIrtEmgmrU50OJgTgmJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fyborDxb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ngieK/es; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fyborDxb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ngieK/es; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4190F2124D;
	Thu, 21 Nov 2024 09:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732181959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rN7zACpXhWBvmyhdQ9L7AJcccIoJA6vlCdi8480LQC0=;
	b=fyborDxbGV5tOJEsgZOCdPTpEXPwLs66tKq/7XlYBvT+lfOhORmFAM9Gp0L9Rcfc07ZGtO
	M3ahEd0zTbnol02LyixbnSz+aEeUU74bdiQBgK9SZ6opo5+v6Cbk7y9PHaY2Yyv7k/zygS
	r/+fmMO6YcmaB0BZ4nVfbL81omS9NKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732181959;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rN7zACpXhWBvmyhdQ9L7AJcccIoJA6vlCdi8480LQC0=;
	b=ngieK/es157uCVvN4o0UKFZk5Uky2BzuJoAKbgaLqLG+1DDJlEU6UyIHIFwC8RN8yjRAAK
	K1QEBo+WuebSeABg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=fyborDxb;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="ngieK/es"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732181959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rN7zACpXhWBvmyhdQ9L7AJcccIoJA6vlCdi8480LQC0=;
	b=fyborDxbGV5tOJEsgZOCdPTpEXPwLs66tKq/7XlYBvT+lfOhORmFAM9Gp0L9Rcfc07ZGtO
	M3ahEd0zTbnol02LyixbnSz+aEeUU74bdiQBgK9SZ6opo5+v6Cbk7y9PHaY2Yyv7k/zygS
	r/+fmMO6YcmaB0BZ4nVfbL81omS9NKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732181959;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rN7zACpXhWBvmyhdQ9L7AJcccIoJA6vlCdi8480LQC0=;
	b=ngieK/es157uCVvN4o0UKFZk5Uky2BzuJoAKbgaLqLG+1DDJlEU6UyIHIFwC8RN8yjRAAK
	K1QEBo+WuebSeABg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B6D213927;
	Thu, 21 Nov 2024 09:39:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hrlKCsf/PmcJXAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Nov 2024 09:39:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C30E5A089E; Thu, 21 Nov 2024 10:39:18 +0100 (CET)
Date: Thu, 21 Nov 2024 10:39:18 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
	kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
	brauner@kernel.org, torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk, linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v8 02/19] fsnotify: opt-in for permission events at file
 open time
Message-ID: <20241121093918.d2ml5lrfcqwknffb@quack3>
References: <cover.1731684329.git.josef@toxicpanda.com>
 <5ea5f8e283d1edb55aa79c35187bfe344056af14.1731684329.git.josef@toxicpanda.com>
 <20241120155309.lecjqqhohgcgyrkf@quack3>
 <CAOQ4uxgjOZN_=BM3DuLLZ8Vzdh-q7NYKhMnF0p_NveYd=e7vdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgjOZN_=BM3DuLLZ8Vzdh-q7NYKhMnF0p_NveYd=e7vdA@mail.gmail.com>
X-Rspamd-Queue-Id: 4190F2124D
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Wed 20-11-24 17:12:21, Amir Goldstein wrote:
> On Wed, Nov 20, 2024 at 4:53 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Fri 15-11-24 10:30:15, Josef Bacik wrote:
> > > From: Amir Goldstein <amir73il@gmail.com>
> > >
> > > Legacy inotify/fanotify listeners can add watches for events on inode,
> > > parent or mount and expect to get events (e.g. FS_MODIFY) on files that
> > > were already open at the time of setting up the watches.
> > >
> > > fanotify permission events are typically used by Anti-malware sofware,
> > > that is watching the entire mount and it is not common to have more that
> > > one Anti-malware engine installed on a system.
> > >
> > > To reduce the overhead of the fsnotify_file_perm() hooks on every file
> > > access, relax the semantics of the legacy FAN_ACCESS_PERM event to generate
> > > events only if there were *any* permission event listeners on the
> > > filesystem at the time that the file was opened.
> > >
> > > The new semantic is implemented by extending the FMODE_NONOTIFY bit into
> > > two FMODE_NONOTIFY_* bits, that are used to store a mode for which of the
> > > events types to report.
> > >
> > > This is going to apply to the new fanotify pre-content events in order
> > > to reduce the cost of the new pre-content event vfs hooks.
> > >
> > > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > > Link: https://lore.kernel.org/linux-fsdevel/CAHk-=wj8L=mtcRTi=NECHMGfZQgXOp_uix1YVh04fEmrKaMnXA@mail.gmail.com/
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >
> > FWIW I've ended up somewhat massaging this patch (see below).
> >
> > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > index 23bd058576b1..8e5c783013d2 100644
> > > --- a/include/linux/fs.h
> > > +++ b/include/linux/fs.h
> > > @@ -173,13 +173,14 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
> > >
> > >  #define      FMODE_NOREUSE           ((__force fmode_t)(1 << 23))
> > >
> > > -/* FMODE_* bit 24 */
> > > -
> > >  /* File is embedded in backing_file object */
> > > -#define FMODE_BACKING                ((__force fmode_t)(1 << 25))
> > > +#define FMODE_BACKING                ((__force fmode_t)(1 << 24))
> > >
> > > -/* File was opened by fanotify and shouldn't generate fanotify events */
> > > -#define FMODE_NONOTIFY               ((__force fmode_t)(1 << 26))
> > > +/* File shouldn't generate fanotify pre-content events */
> > > +#define FMODE_NONOTIFY_HSM   ((__force fmode_t)(1 << 25))
> > > +
> > > +/* File shouldn't generate fanotify permission events */
> > > +#define FMODE_NONOTIFY_PERM  ((__force fmode_t)(1 << 26))
> >
> > Firstly, I've kept FMODE_NONOTIFY to stay a single bit instead of two bit
> > constant. I've seen too many bugs caused by people expecting the constant
> > has a single bit set when it actually had more in my life. So I've ended up
> > with:
> >
> > +/*
> > + * Together with FMODE_NONOTIFY_PERM defines which fsnotify events shouldn't be
> > + * generated (see below)
> > + */
> > +#define FMODE_NONOTIFY         ((__force fmode_t)(1 << 25))
> > +
> > +/*
> > + * Together with FMODE_NONOTIFY defines which fsnotify events shouldn't be
> > + * generated (see below)
> > + */
> > +#define FMODE_NONOTIFY_PERM    ((__force fmode_t)(1 << 26))
> >
> > and
> >
> > +/*
> > + * The two FMODE_NONOTIFY* define which fsnotify events should not be generated
> > + * for a file. These are the possible values of (f->f_mode &
> > + * FMODE_FSNOTIFY_MASK) and their meaning:
> > + *
> > + * FMODE_NONOTIFY - suppress all (incl. non-permission) events.
> > + * FMODE_NONOTIFY_PERM - suppress permission (incl. pre-content) events.
> > + * FMODE_NONOTIFY | FMODE_NONOTIFY_PERM - suppress only pre-content events.
> > + */
> > +#define FMODE_FSNOTIFY_MASK \
> > +       (FMODE_NONOTIFY | FMODE_NONOTIFY_PERM)
> > +
> > +#define FMODE_FSNOTIFY_NONE(mode) \
> > +       ((mode & FMODE_FSNOTIFY_MASK) == FMODE_NONOTIFY)
> > +#define FMODE_FSNOTIFY_PERM(mode) \
> > +       (!(mode & FMODE_NONOTIFY_PERM))
> 
> That looks incorrect -
> It gives the wrong value for FMODE_NONOTIFY | FMODE_NONOTIFY_PERM
> 
> should be:
> != FMODE_NONOTIFY_PERM &&
> != FMODE_NONOTIFY
> 
> The simplicity of the single bit test is for permission events
> is why I chose my model, but I understand your reasoning.

Ah, thanks for catching this! I've fixed this to:

+#define FMODE_FSNOTIFY_PERM(mode) \
+       ((mode & FMODE_FSNOTIFY_MASK) == 0 || \
+        (mode & FMODE_FSNOTIFY_MASK) == (FMODE_NONOTIFY | FMODE_NONOTIFY_PERM))

It is not a single bit test so it ends up being:

   0x0000000060180345 <+101>:	mov    0x20(%r12),%edx
   0x000000006018034a <+106>:	and    $0x6000000,%edx
   0x0000000060180350 <+112>:	je     0x6018035a <rw_verify_area+122>
   0x0000000060180352 <+114>:	cmp    $0x6000000,%edx
   0x0000000060180358 <+120>:	jne    0x6018032e <rw_verify_area+78>

But I guess that's not terrible either.

> > +#define FMODE_FSNOTIFY_HSM(mode) \
> > +       ((mode & FMODE_FSNOTIFY_MASK) == 0)
> >
> > Also I've moved file_set_fsnotify_mode() out of line into fsnotify.c. The
> > function gets quite big and the call is not IMO so expensive to warrant
> > inlining. Furthermore it saves exporting some fsnotify internals to modules
> > (in later patches).
> 
> Sounds good.
> Since you wanted to refrain from defining a two bit constant,
> I wonder how you annotated for NONOTIFY_HSM case
> 
>    return FMODE_NONOTIFY | FMODE_NONOTIFY_PERM;

I'm not sure I understand. What do you mean by "annotated"?

It is not that I object to "two bit constants". FMODE_FSNOTIFY_MASK is a
two-bit constant and a good one. But the name clearly suggests it is not a
single bit constant. When you have all FMODE_FOO and FMODE_BAR things
single bit except for FMODE_BAZ which is multi-bit, then this is IMHO a
recipe for problems and I rather prefer explicitely spelling the
combination out as FMODE_NONOTIFY | FMODE_NONOTIFY_PERM in the few places
that need this instead of hiding it behind some other name.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

