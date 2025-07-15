Return-Path: <linux-fsdevel+bounces-54948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E26DCB0599E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 14:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED4F33A672C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 12:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7182F533D6;
	Tue, 15 Jul 2025 12:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i43V6tij";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NbbyxiNS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i43V6tij";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NbbyxiNS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC4D26CE31
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752581494; cv=none; b=iOMEB63cmD6NHW+jUpJwTQ7ZAk4Y9Bqx0jovzwVdNfVpD73k1FN6B4+fXsd8KefZm+8nBWHe7uYajXQEq1HYiVYPfKPeaUROxfep3UnnoBSQNgHS8wuw+1D2ZrfNwiKU6aMBn5tFEKThRalTwkoPH+d6WRKET6m9V83+MT6aEZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752581494; c=relaxed/simple;
	bh=1IXXqTZAgpGbOrPLX2uW9FfJhvCinAG+pPHtfq/E9V0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVyw2j6yOhMWBItj2S8kODhnfHoMobVZI+28CBj2HXSLol4NBEg6dc0lmwDEzqxruw2RP9lS2S0U98aGl7AeHgce3JYXCjeb4b2fq6HLbCIaDWqB1GX+CROTZ4hHkzH069cUsyAgTvtdwXm2z0bz/Gbqy7oJDkd3SUlpz8OiVsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i43V6tij; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NbbyxiNS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i43V6tij; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NbbyxiNS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 07D452124F;
	Tue, 15 Jul 2025 12:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752581491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/PPPpjjJHrfsTExege3o0O2P13HHKLAkALpweQSfj5k=;
	b=i43V6tijXA6scBGSsqOMtFAj+gr4tDymlTD7NEx4OHW3nPl1JprGpqtjf2yu47AeiJc66g
	CRVaiGDvcpoxyDpypY70+RfQHzJLNx42AVkioQV4FFdYfgKtqrBMB4qGCKRyKd9Vviod+G
	TzVdLrlza9lW/K4aKaQoUHUSp9j4zbE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752581491;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/PPPpjjJHrfsTExege3o0O2P13HHKLAkALpweQSfj5k=;
	b=NbbyxiNSfNt2NLNEwrLEqe263byBEcX4q2mB5qtrxkPjgQj+cBzg3dLJJo5FE5XjU9c4Fw
	Nw3qjoMl6ccGDZBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=i43V6tij;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NbbyxiNS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752581491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/PPPpjjJHrfsTExege3o0O2P13HHKLAkALpweQSfj5k=;
	b=i43V6tijXA6scBGSsqOMtFAj+gr4tDymlTD7NEx4OHW3nPl1JprGpqtjf2yu47AeiJc66g
	CRVaiGDvcpoxyDpypY70+RfQHzJLNx42AVkioQV4FFdYfgKtqrBMB4qGCKRyKd9Vviod+G
	TzVdLrlza9lW/K4aKaQoUHUSp9j4zbE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752581491;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/PPPpjjJHrfsTExege3o0O2P13HHKLAkALpweQSfj5k=;
	b=NbbyxiNSfNt2NLNEwrLEqe263byBEcX4q2mB5qtrxkPjgQj+cBzg3dLJJo5FE5XjU9c4Fw
	Nw3qjoMl6ccGDZBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB7BC13A68;
	Tue, 15 Jul 2025 12:11:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id utt5OXJFdmhaHQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 15 Jul 2025 12:11:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7A31DA0993; Tue, 15 Jul 2025 14:11:30 +0200 (CEST)
Date: Tue, 15 Jul 2025 14:11:30 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Ibrahim Jirdeh <ibrahimjirdeh@meta.com>, 
	josef@toxicpanda.com, lesha@meta.com, linux-fsdevel@vger.kernel.org, sargun@meta.com
Subject: Re: [PATCH] fanotify: support custom default close response
Message-ID: <f5xtqk4gpbeowtnbiegbfosnpjr4ge42rfebjgyz66cxxzmhse@fjn44egzgdpt>
References: <CAOQ4uxjd1tPFoV6CrsktJK8yr+ZMBptTMK-qH_+ADjiK7voYOw@mail.gmail.com>
 <20250711223041.1249535-1-ibrahimjirdeh@meta.com>
 <CAOQ4uxhN6ok6BCBGbxeUt9ULq6g=qL6=_2_QGi8MqTHv5ZN7Vg@mail.gmail.com>
 <sx5g7pmkchjqucfbzi77xh7wx4wua5nteqi5bsa2hfqgxua2a2@v7x6ja3gsirn>
 <CAOQ4uxj6EF5G=0RAE45ovVLqbro9TJP-WdP-ixwAgnr7zg-2wA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxj6EF5G=0RAE45ovVLqbro9TJP-WdP-ixwAgnr7zg-2wA@mail.gmail.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 07D452124F
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -4.01

On Mon 14-07-25 21:59:22, Amir Goldstein wrote:
> On Mon, Jul 14, 2025 at 7:25 PM Jan Kara <jack@suse.cz> wrote:
> > > I don't think there is much to lose from this retry behavior.
> > > The only reason we want to opt-in for it is to avoid surprises of
> > > behavior change in existing deployments.
> > >
> > > While we could have FAN_RETRY_UNANSWERED as an
> > > independent feature without a handover ioctl,
> > > In order to avoid test matrix bloat, at least for a start (we can relax later),
> > > I don't think that we should allow it as an independent feature
> > > and especially not for legacy modes (i.e. for Anti-Virus) unless there
> > > is a concrete user requesting/testing these use cases.
> >
> > With queue-fd design I agree there's no reason not to have the "resend
> > pending events" behavior from the start.
> >
> > > Going on about feature dependency.
> > >
> > > Practically, a handover ioctl is useless without
> > > FAN_REPORT_RESPONSE_ID, so for sure we need to require
> > > FAN_REPORT_RESPONSE_ID for the handover ioctl feature.
> > >
> > > Because I do not see an immediate use case for
> > > FAN_REPORT_RESPONSE_ID without handover,
> > > I would start by only allowing them together and consider relaxing
> > > later if such a use case is found.
> >
> > We can tie them together but I think queue-fd design doesn't require
> > FAN_REPORT_RESPONSE_ID. Since we resend events anyway, we'd generate new
> > fds for events as well and things would just work AFAICT.
> >
> 
> Right. hmm.
> I'd still like to consider the opportunity of the new-ish API for
> deprecating some old legacy API baggage.
> 
> For example: do you consider the fact that async events are mixed
> together with permission/pre-content events in the same queue
> an historic mistake or a feature?
 
So far I do consider it a feature although not a particularly useful one.
Given fanotify doesn't guarantee ordering of events and async events can
arbitrarily skip over the permission events there's no substantial
difference to having two notification groups. If you can make a good case
of what would be simpler if we disallowed that I'm open to consider
disallowing that.

> I'm tempted, as we split the control fd from the queue fd to limit
> a queue to events of the same "type".
> Maybe an O_RDONLY async queue fd
> or an O_RDWR permission events queue fd
> or only allow the latter with the new API?

There's value in restricting unneeded functionality and there's also value
in having features not influencing one another so the balance has to be
found :). So far I don't find that disallowing async events with queue fd
or restricting fd mode for queue fd would simplify our life in a
significant way but maybe I'm missing something.

> Please note that FAN_CLOEXEC and FAN_NONBLOCK
> currently apply to the control fd.
> I guess they can also apply to the queue fd,
> Anyway the control fd should not be O_RDWR
> probably O_RDONLY even though it's not for reading.

I guess the ioctl to create queue fd can take desired flags for the queue
fd so we don't have to second guess what the application wants.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

