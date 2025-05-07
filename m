Return-Path: <linux-fsdevel+bounces-48352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4D4AADCF6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 13:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F93850298A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 11:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4345621770C;
	Wed,  7 May 2025 11:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VgttKnPC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fRfToGMn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="p2sSrdbt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AJUMJSCz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D7120F062
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 May 2025 11:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746616111; cv=none; b=ngQrzsIDaDLT/SwA4d/GukEviNi6AmnCIm9LsYDKA18HcKh2njFebUbbFTMA7IDpYWyHvveFpZCg91Fw8T8B40DziGIPYVmhCM9F3qWbNnedD4zkV5mh6y+YomTH4Q6LPfCD9GuR3luHkrVd0WEQwy7InbK0rfvA04xTUtIJaw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746616111; c=relaxed/simple;
	bh=TFtAvhGPCjH1vQkg0Kk4DxEheOg80Nt8ZeP3uBHqlMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNE7gYXjaeY2GohylCOKw3ueDpZvsQlmV9rYbtU8YLNy7Gb0j9saikYFWSxdxsxLYjU2DmXC/v3+OSkSd4AfqUiuJUd2UPHez30srVsaKcd0icDW6iLtqcKW3SaIBEwXowjouAiSTl0EpY/D+GvSmQ3xt8T35Wpi8mH18P0wEF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VgttKnPC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fRfToGMn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=p2sSrdbt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AJUMJSCz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F24891F395;
	Wed,  7 May 2025 11:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746616108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fFEUUmten1TD6D9lybLOMxeEWKfyYel0DbgWwF/eDV4=;
	b=VgttKnPCL+3uxScODxoZE6rRTI0CYyLnjJP0R5QzIWFmPSYWEdEL1D8+lPl3qlJtLjkx+g
	nSUNAh31gkW8iTzZFdfnuYN3VnbEpC7g7oOviJqJbEc8p0c5fZl+JJl9PA/2hKEwLwKsEU
	uw40FAbsXLhZyLYzDyc4isLtcNniryE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746616108;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fFEUUmten1TD6D9lybLOMxeEWKfyYel0DbgWwF/eDV4=;
	b=fRfToGMnGAob1D1LzD3IifHSYLNKzmMd+Dwxm9iqRpSRGu/ad6hPvBKI4AL6lZvghusHuX
	hoSiW5aqT7ngh+Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746616107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fFEUUmten1TD6D9lybLOMxeEWKfyYel0DbgWwF/eDV4=;
	b=p2sSrdbt23q3b2Rvq6uDIdHM1P/4+IFYzmDqO/23ydHY88dTHA52v9/qh6/8mFBysOd+fl
	c6W9ZBgxlwQIx+XPf/pr52E0NvnWhCJ9aFrbltPZHRpXp2u97HlAuvDQJloIyqcFW7vQaC
	NvG62kfSwXPzixxhJmhEFkJ6XxhQavQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746616107;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fFEUUmten1TD6D9lybLOMxeEWKfyYel0DbgWwF/eDV4=;
	b=AJUMJSCzGEu0XKMcg51iF6nGs3z3i8ZyYDS2maSWN4Hdt8lszXVaGlu66nsPHvgzgl5T3+
	y5Va8XSVMNcE7zCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E636413882;
	Wed,  7 May 2025 11:08:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0aAwOCs/G2jgGQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 07 May 2025 11:08:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 83A91A09BE; Wed,  7 May 2025 13:08:23 +0200 (CEST)
Date: Wed, 7 May 2025 13:08:23 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Jan Kara <jack@suse.cz>, 
	Matthew Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] fanotify: Avoid a couple of
 -Wflex-array-member-not-at-end warnings
Message-ID: <42nltwupsu4567oc5hioa4djga5yoqqoq3h7j3dj6vjr6hv4kt@54wdcs2wwefj>
References: <aBqdlxlBtb9s7ydc@kspp>
 <CAOQ4uxj-tsr5XWXfu3BHRygubA5kzZVsb_x6ELb_U_N77AA96A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxj-tsr5XWXfu3BHRygubA5kzZVsb_x6ELb_U_N77AA96A@mail.gmail.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.80

On Wed 07-05-25 07:56:21, Amir Goldstein wrote:
> On Wed, May 7, 2025 at 1:39 AM Gustavo A. R. Silva
> <gustavoars@kernel.org> wrote:
> >
> > -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> > getting ready to enable it, globally.
> >
> > Modify FANOTIFY_INLINE_FH() macro, which defines a struct containing a
> > flexible-array member in the middle (struct fanotify_fh::buf), to use
> > struct_size_t() to pre-allocate space for both struct fanotify_fh and
> > its flexible-array member. Replace the struct with a union and relocate
> > the flexible structure (struct fanotify_fh) to the end.
> >
> > See the memory layout of struct fanotify_fid_event before and after
> > changes below.
> >
> > pahole -C fanotify_fid_event fs/notify/fanotify/fanotify.o
> >
> > BEFORE:
> > struct fanotify_fid_event {
> >         struct fanotify_event      fae;                  /*     0    48 */
> >         __kernel_fsid_t            fsid;                 /*    48     8 */
> >         struct {
> >                 struct fanotify_fh object_fh;            /*    56     4 */
> >                 unsigned char      _inline_fh_buf[12];   /*    60    12 */
> >         };                                               /*    56    16 */
> >
> >         /* size: 72, cachelines: 2, members: 3 */
> >         /* last cacheline: 8 bytes */
> > };
> >
> > AFTER:
> > struct fanotify_fid_event {
> >         struct fanotify_event      fae;                  /*     0    48 */
> >         __kernel_fsid_t            fsid;                 /*    48     8 */
> >         union {
> >                 unsigned char      _inline_fh_buf[16];   /*    56    16 */
> >                 struct fanotify_fh object_fh __attribute__((__aligned__(1))); /*    56     4 */
> 
> I'm not that familiar with pahole, but I find it surprising to see this member
> aligned(1), when struct fanotify_fh is defined as __aligned(4).

Yeah.

> >         } __attribute__((__aligned__(1)));               /*    56    16 */
> >
> >         /* size: 72, cachelines: 2, members: 3 */
> >         /* forced alignments: 1 */
> >         /* last cacheline: 8 bytes */
> > } __attribute__((__aligned__(8)));
> >
> > So, with these changes, fix the following warnings:
> >
> > fs/notify/fanotify/fanotify.h:317:28: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > fs/notify/fanotify/fanotify.h:289:28: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> >
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >  fs/notify/fanotify/fanotify.h | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> > index b44e70e44be6..91c26b1c1d32 100644
> > --- a/fs/notify/fanotify/fanotify.h
> > +++ b/fs/notify/fanotify/fanotify.h
> > @@ -275,12 +275,12 @@ static inline void fanotify_init_event(struct fanotify_event *event,
> >         event->pid = NULL;
> >  }
> >
> > -#define FANOTIFY_INLINE_FH(name, size)                                 \
> > -struct {                                                               \
> > -       struct fanotify_fh name;                                        \
> > -       /* Space for object_fh.buf[] - access with fanotify_fh_buf() */ \
> > -       unsigned char _inline_fh_buf[size];                             \
> > -}
> > +#define FANOTIFY_INLINE_FH(name, size)                                               \
> > +union {                                                                                      \
> > +       /* Space for object_fh and object_fh.buf[] - access with fanotify_fh_buf() */ \
> > +       unsigned char _inline_fh_buf[struct_size_t(struct fanotify_fh, buf, size)];   \
> 
> The name _inline_fh_buf is confusing in this setting
> better use bytes[] as in DEFINE_FLEX() or maybe even consider
> a generic helper DEFINE_FLEX_MEMBER() to use instead of
> FANOTIFY_INLINE_FH(), because this is not fanotify specific,
> except maybe for alignment (see below).

Yes, I guess a generic helper for this would be nice but if fanotify is the
only place that plays these tricks, we can keep it specific for now. I
agree naming the "space-buffer" field "bytes" would be less confusing.

> 
> > +       struct fanotify_fh name;                                                      \
> > +} __packed
> 
> Why added __packed?
> 
> The fact that struct fanotify_fh is 4 bytes aligned could end up with less
> bytes reserved for the inline buffer if the union is not also 4 bytes aligned.
> 
> So maybe something like this:
> 
> #define FANOTIFY_INLINE_FH(name, size) \
>     DEFINE_FLEX_MEMBER(struct fanotify_fh, name, size) __aligned(4)

I guess you need to provide the "member" information to
DEFINE_FLEX_MEMBER() somewhere as well.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

