Return-Path: <linux-fsdevel+bounces-35466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AF59D50CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 17:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17B991F22800
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 16:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA9F1A08A3;
	Thu, 21 Nov 2024 16:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gV1e8WjL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="c5L0hCOC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="akyTH1yr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FdsfhEJ6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4692158A33;
	Thu, 21 Nov 2024 16:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732206986; cv=none; b=rUfWsTlQ1qzCWcKy/9W7wTxWXhistkZuS6/0FLGoltLWgLPp1565+lZPTUC36LwmS0SkzHZNuqMwE94MSrJEKH3AmDCV3ysyHe8S+GTrjZ3yn70zPQi5lmfMwYltYjwaj5HwUOj7vV7hAro4G/ZoEMRnoMtekOhYQZ4pZtk0tJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732206986; c=relaxed/simple;
	bh=r1npEq0ptwRK9KGqwxWMtfIk6dHrxnLfnNaiyIKgEKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hUqAFfiwff6NdCgOunKVNoJ+9sVuVekzgZ+uPT+sU/xzoFKO3kKrkKqqL5PSy87Pf0ajZ8XcG8Q8vu7PHVQjmSbpuzx2Z7BGMVxuueOJNkKNRVPAFsEVp0yNYL0/TXpSKHzdyAVIFZlLoDUYqt57PtbAhWlLErm2fpSuxXGKB68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gV1e8WjL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=c5L0hCOC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=akyTH1yr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FdsfhEJ6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DDAD521A1F;
	Thu, 21 Nov 2024 16:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732206983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=owpYThB1H3Ar3OZ3shQAJEwqjDt1Pg/S0sw5HXZq9co=;
	b=gV1e8WjLDrReA1TaAazvauUv8Rz3sgBIfrIq2XafYUXJYD+Se4EPBMJB2jqgmY8yOX6/JW
	Yjd6u37CPz/2Q1Uiq1qcEDYPW1NT4bVzQcD3sZ1SNXq12tVIRNPPsRSJnJdI65ul080L0/
	GCNAMOCYMIcjXUjY2p3wNoF5HhQ5PL0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732206983;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=owpYThB1H3Ar3OZ3shQAJEwqjDt1Pg/S0sw5HXZq9co=;
	b=c5L0hCOCVD+j/6pVnFCMS1fcdvvW5F0Xq+olEN0wdnh674K69Dm5nTr8H2L6GyMKhvPONA
	A/zZHvCW4BztszAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=akyTH1yr;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=FdsfhEJ6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732206982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=owpYThB1H3Ar3OZ3shQAJEwqjDt1Pg/S0sw5HXZq9co=;
	b=akyTH1yrjt4uURPAMj2Opr2QAlOEezzScxIKcbBlpEveqglKW+s0SvZfeKzZIGZDGd1ha3
	5QniWYnxtGpq6y7mtxhgObnX5tfO8dSTFTy7HwhLOOCrT0KzoHbpAplk0TOt45T8RpTkbf
	ZTWl3s5X+5Ma2W1UYLWvFTQdfqmTknE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732206982;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=owpYThB1H3Ar3OZ3shQAJEwqjDt1Pg/S0sw5HXZq9co=;
	b=FdsfhEJ6AfFetOsQMF3Wm205FH1c6YuxDgs3g0gLrz9RTFrBxj46EZG7WNfzx8T/Tjc7PB
	o/IDLVpHiCHd4lAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC924137CF;
	Thu, 21 Nov 2024 16:36:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MqTSMYZhP2d8YwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Nov 2024 16:36:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 47071A08A2; Thu, 21 Nov 2024 17:36:18 +0100 (CET)
Date: Thu, 21 Nov 2024 17:36:18 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
	kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
	brauner@kernel.org, torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk, linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v8 10/19] fanotify: introduce FAN_PRE_ACCESS permission
 event
Message-ID: <20241121163618.ubz7zplrnh66aajw@quack3>
References: <cover.1731684329.git.josef@toxicpanda.com>
 <b80986f8d5b860acea2c9a73c0acd93587be5fe4.1731684329.git.josef@toxicpanda.com>
 <20241121104428.wtlrfhadcvipkjia@quack3>
 <CAOQ4uxhTiR8eHaf4q0_gLC62CWi9KdaQ05GSeqFkKFkXCH++PA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhTiR8eHaf4q0_gLC62CWi9KdaQ05GSeqFkKFkXCH++PA@mail.gmail.com>
X-Rspamd-Queue-Id: DDAD521A1F
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Thu 21-11-24 15:18:36, Amir Goldstein wrote:
> On Thu, Nov 21, 2024 at 11:44 AM Jan Kara <jack@suse.cz> wrote:
> >
> > On Fri 15-11-24 10:30:23, Josef Bacik wrote:
> > > From: Amir Goldstein <amir73il@gmail.com>
> > >
> > > Similar to FAN_ACCESS_PERM permission event, but it is only allowed with
> > > class FAN_CLASS_PRE_CONTENT and only allowed on regular files and dirs.
> > >
> > > Unlike FAN_ACCESS_PERM, it is safe to write to the file being accessed
> > > in the context of the event handler.
> > >
> > > This pre-content event is meant to be used by hierarchical storage
> > > managers that want to fill the content of files on first read access.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >
> > Here I was wondering about one thing:
> >
> > > +     /*
> > > +      * Filesystems need to opt-into pre-content evnets (a.k.a HSM)
> > > +      * and they are only supported on regular files and directories.
> > > +      */
> > > +     if (mask & FANOTIFY_PRE_CONTENT_EVENTS) {
> > > +             if (!(path->mnt->mnt_sb->s_iflags & SB_I_ALLOW_HSM))
> > > +                     return -EINVAL;
> > > +             if (!is_dir && !d_is_reg(path->dentry))
> > > +                     return -EINVAL;
> > > +     }
> >
> > AFAICS, currently no pre-content events are generated for directories. So
> > perhaps we should refuse directories here as well for now? I'd like to
> 
> readdir() does emit PRE_ACCESS (without a range)

Ah, right.

> and also always emitted ACCESS_PERM.

I know that and it's one of those mostly useless events AFAICT.

> my POC is using that PRE_ACCESS to populate
> directories on-demand, although the functionality is incomplete without the
> "populate on lookup" event.

Exactly. Without "populate on lookup" doing "populate on readdir" is ok for
a demo but not really usable in practice because you can get spurious
ENOENT from a lookup.

> > avoid the mistake of original fanotify which had some events available on
> > directories but they did nothing and then you have to ponder hard whether
> > you're going to break userspace if you actually start emitting them...
> 
> But in any case, the FAN_ONDIR built-in filter is applicable to PRE_ACCESS.

Well, I'm not so concerned about filtering out uninteresting events. I'm
more concerned about emitting the event now and figuring out later that we
need to emit it in different places or with some other info when actual
production users appear.

But I've realized we must allow pre-content marks to be placed on dirs so
that such marks can be placed on parents watching children. What we'd need
to forbid is a combination of FAN_ONDIR and FAN_PRE_ACCESS, wouldn't we?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

