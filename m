Return-Path: <linux-fsdevel+bounces-54246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2D6AFCC5E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 15:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 482B74A5652
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 13:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CE42D8380;
	Tue,  8 Jul 2025 13:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cFEYY7Ed";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7hSGj93P";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cFEYY7Ed";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7hSGj93P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010197E107
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Jul 2025 13:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751982222; cv=none; b=Ajm7GZynuAa9wiaQjolmCRnXxDYU3ylPVakMvA8zFzzwoK32LYo3NIKsn7j9pJEdOVOrBRWUQz7zRVn3WXT23uW+BFlLav9TkoF6hhmf4KnJJ76UwRZeN6FVXWYRD4lHkgqQ2ETOsggqHW9iYy/wElH5mFNNcXhFE3gArIz5R34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751982222; c=relaxed/simple;
	bh=nF0+KMniqgdBKRoMm7tnLPAqpXYPBVFXUEdU0h2B6Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AozNzqtJKQuee/sq3nXvtIvtaB/CTpgyqMmNfyD54OjQ1lVk1IM/zUArCdZewlhvBjUx8qPBnFeMlFMDYY8YZhFIAfI8WABn1jDy8E3TFiW+XNu3KjkuOlxLdrqErtyEXGvvIB2nDblSFIQ/HO9FCCNlZhjyrJIamoP4OnerMaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cFEYY7Ed; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7hSGj93P; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cFEYY7Ed; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7hSGj93P; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 00B4F1F395;
	Tue,  8 Jul 2025 13:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751982219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rDNz+q3iSeJkTycdDb83Xreebhf6qwgVfO8x6hpINmc=;
	b=cFEYY7Ed0eYDvTy6O7cjJQnVOFrj8Q5iNAXLbjW/xSkig53bJrtwGrABHWXyMi1bg+BJS4
	RAsiKsL5GKSkA4KSY41wHl7bgjOQmWk8GUbt5F4yft/SMB7Z9+sDHzVN8PaH5I4YqKOGBq
	aujdFNgQa5Fd0YrmhJQTnlz+l1PJ6Fw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751982219;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rDNz+q3iSeJkTycdDb83Xreebhf6qwgVfO8x6hpINmc=;
	b=7hSGj93PLHVX7a6HruTpPRXbWVDgX7RmpkTP/kpZW9piHfirT3iqJkTmwVXqPHcsURzcXt
	H/CxuO/Lx8sLvrBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751982219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rDNz+q3iSeJkTycdDb83Xreebhf6qwgVfO8x6hpINmc=;
	b=cFEYY7Ed0eYDvTy6O7cjJQnVOFrj8Q5iNAXLbjW/xSkig53bJrtwGrABHWXyMi1bg+BJS4
	RAsiKsL5GKSkA4KSY41wHl7bgjOQmWk8GUbt5F4yft/SMB7Z9+sDHzVN8PaH5I4YqKOGBq
	aujdFNgQa5Fd0YrmhJQTnlz+l1PJ6Fw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751982219;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rDNz+q3iSeJkTycdDb83Xreebhf6qwgVfO8x6hpINmc=;
	b=7hSGj93PLHVX7a6HruTpPRXbWVDgX7RmpkTP/kpZW9piHfirT3iqJkTmwVXqPHcsURzcXt
	H/CxuO/Lx8sLvrBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7E9213A54;
	Tue,  8 Jul 2025 13:43:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AI+YOIogbWhVOwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 08 Jul 2025 13:43:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 905BFA098F; Tue,  8 Jul 2025 15:43:38 +0200 (CEST)
Date: Tue, 8 Jul 2025 15:43:38 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Ibrahim Jirdeh <ibrahimjirdeh@meta.com>, 
	josef@toxicpanda.com, lesha@meta.com, linux-fsdevel@vger.kernel.org, sargun@meta.com
Subject: Re: [PATCH] fanotify: introduce unique event identifier
Message-ID: <ggruapqox23obwimkajdj257ffdrhziwk3tbrorqx3wz7qcmm2@epcyf6cqxk27>
References: <CAOQ4uxi8xjfhKLc7T0WGjOmtO4wRQT6b5MLUdaST2KE01BsKBg@mail.gmail.com>
 <20250701072209.1549495-1-ibrahimjirdeh@meta.com>
 <CAOQ4uxhrbN4k+YMd99h8jGyRc0d_n05H8q-gTuJ35jkO1aLO7A@mail.gmail.com>
 <pcyd4ejepc6akgw3uq2bxuf2e255zhirbpfxxe463zj2m7iyfl@6bgetglt74ei>
 <CAOQ4uxiAtKcdzpBP_ZA2hxpECULri+T9DTQRnT1iOCVJfYcryg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxiAtKcdzpBP_ZA2hxpECULri+T9DTQRnT1iOCVJfYcryg@mail.gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

On Tue 08-07-25 14:58:31, Amir Goldstein wrote:
> On Tue, Jul 8, 2025 at 1:40 PM Jan Kara <jack@suse.cz> wrote:
> > > --- a/fs/notify/fanotify/fanotify_user.c
> > > +++ b/fs/notify/fanotify/fanotify_user.c
> > > @@ -1583,6 +1583,16 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int,
> > > flags, unsigned int, event_f_flags)
> > >             (class | fid_mode) != FAN_CLASS_PRE_CONTENT_FID)
> > >                 return -EINVAL;
> > >
> > > +       /*
> > > +        * With group that reports fid info and allows only pre-content events,
> > > +        * user may request to get a response id instead of event->fd.
> > > +        * FAN_REPORT_FD_ERROR does not make sense in this case.
> > > +        */
> > > +       if ((flags & FAN_REPORT_RESPONSE_ID) &&
> > > +           ((flag & FAN_REPORT_FD_ERROR) ||
> > > +            !fid_mode || class != FAN_CLASS_PRE_CONTENT_FID))
> > > +               return -EINVAL;
> > > +
> > >
> > >
> > > This new group mode is safe, because:
> > > 1. event->fd is redundant to target fid
> > > 2. other group priorities allow mixing async events in the same group
> > >     async event can have negative event->fd which signifies an error
> > >     to open event->fd
> >
> > I'm not sure I follow here. I'd expect:
> >
> >         if ((flags & FAN_REPORT_RESPONSE_ID) && !fid_mode)
> >                 return -EINVAL;
> >
> > I.e., if you ask for event ids, we don't return fds at all so you better
> > had FID enabled to see where the event happened. And then there's no need
> > for FAN_CLASS_PRE_CONTENT_FID at all. Yes, you cannot mix async fanotify
> > events with fd with permission events using event id but is that a sane
> > combination? What case do you have in mind that justifies this
> > complication?
> 
> Not sure what complication you are referring to.
> Maybe this would have been more clear:
> 
> +       if ((flags & FAN_REPORT_RESPONSE_ID) && (!fid_mode ||
> +           ((flag & FAN_REPORT_FD_ERROR) || class == FAN_CLASS_NOTIFY))
> +               return -EINVAL;
> +

Right, I can understand this easily :) Thanks for clarification.

> Yes, !fid_mode is the more important check.
> The checks in the second line are because the combination of
> FAN_REPORT_RESPONSE_ID with those other flags does not make sense.

But FAN_REPORT_FD_ERROR influences also the behavior of pidfd (whether we
report full errno there or only FAN_NOPIDFD / FAN_EPIDFD). Hence I think
the exclusion with FAN_REPORT_FD_ERROR is wrong. I agree with
FAN_CLASS_NOTIFY bit.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

