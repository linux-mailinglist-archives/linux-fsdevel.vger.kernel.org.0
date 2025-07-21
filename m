Return-Path: <linux-fsdevel+bounces-55595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14518B0C494
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 14:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9F657AED21
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 12:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AA72D7805;
	Mon, 21 Jul 2025 12:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yVTbxSA1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MGorMX/E";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yVTbxSA1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MGorMX/E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF6713D25D
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jul 2025 12:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753102570; cv=none; b=Ug3rzW/4C0BZC1Kb+BpSxt5jgE+OJwU+C0h910FxtlJjsLcLePx9qejdCKfnofubabWQCp/OptPZcqA5jLyI5XiZ6f1OeKdCaZo31p1k36Dl5JVqitrqvDjED46c3ffw8psE2/+R7gRv4WtfxbFxxrBeUsr4x1gMdoyiVCTLjPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753102570; c=relaxed/simple;
	bh=3N1EkxZDMrHlD5OZQZkHqcrsMdOM3Po5HBJsUEW3bAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1RemGRcSM2sWYrP8uins1Yv4vgAHmSInFfSyoAy85YupeGaItgO0FpDt5zSYF3XkxlomBft0DFNx2W2nYZNC6v1XC4UI3YqaCExwBFHMq3cPCr4y4a5oFFW96H3sY+aWo53s/gU2lgR7OZ1Er0UL33a/qw3REKbv1Kb6/3b0PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yVTbxSA1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MGorMX/E; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yVTbxSA1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MGorMX/E; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A00311FCE8;
	Mon, 21 Jul 2025 12:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753102566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IeDEjPS4DOl70dJrEygjsYAi5EPRM1PXR3gIIMevh9g=;
	b=yVTbxSA1EVhpkIoFphlPTAJlP7xagPg1BBO8Dyba9dhCkvIqQCRH5ToOhH05vR4mBPa4hP
	jpAUKxNTCGdOhQqqGdYW2u11Q6Z/1kfkNFIHAGd0Ti5jBvmOagx8l0KGbu5BJEmx9zJjM8
	Q4vgP3tfKjvm8A0Wy7CPqrwunzB/5n4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753102566;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IeDEjPS4DOl70dJrEygjsYAi5EPRM1PXR3gIIMevh9g=;
	b=MGorMX/Eeo+j23esfMV6FSD/+NTti/HPyWwdlDXP8Q2QpX3HdzErRLoF9r9FdTHvuw2ld6
	+2GgW+7406i/plAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=yVTbxSA1;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="MGorMX/E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753102566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IeDEjPS4DOl70dJrEygjsYAi5EPRM1PXR3gIIMevh9g=;
	b=yVTbxSA1EVhpkIoFphlPTAJlP7xagPg1BBO8Dyba9dhCkvIqQCRH5ToOhH05vR4mBPa4hP
	jpAUKxNTCGdOhQqqGdYW2u11Q6Z/1kfkNFIHAGd0Ti5jBvmOagx8l0KGbu5BJEmx9zJjM8
	Q4vgP3tfKjvm8A0Wy7CPqrwunzB/5n4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753102566;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IeDEjPS4DOl70dJrEygjsYAi5EPRM1PXR3gIIMevh9g=;
	b=MGorMX/Eeo+j23esfMV6FSD/+NTti/HPyWwdlDXP8Q2QpX3HdzErRLoF9r9FdTHvuw2ld6
	+2GgW+7406i/plAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BBD9136A8;
	Mon, 21 Jul 2025 12:56:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GmEZIuY4fmgcSQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 21 Jul 2025 12:56:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3AE84A0884; Mon, 21 Jul 2025 14:56:02 +0200 (CEST)
Date: Mon, 21 Jul 2025 14:56:02 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Ibrahim Jirdeh <ibrahimjirdeh@meta.com>, 
	josef@toxicpanda.com, lesha@meta.com, linux-fsdevel@vger.kernel.org, sargun@meta.com
Subject: Re: [PATCH] fanotify: support custom default close response
Message-ID: <sguiwf3s2e36oj4pzpw5tcqm4464ggjkqf4td6x7pzuef2krmx@uxz5corkhpfc>
References: <CAOQ4uxjd1tPFoV6CrsktJK8yr+ZMBptTMK-qH_+ADjiK7voYOw@mail.gmail.com>
 <20250711223041.1249535-1-ibrahimjirdeh@meta.com>
 <CAOQ4uxhN6ok6BCBGbxeUt9ULq6g=qL6=_2_QGi8MqTHv5ZN7Vg@mail.gmail.com>
 <sx5g7pmkchjqucfbzi77xh7wx4wua5nteqi5bsa2hfqgxua2a2@v7x6ja3gsirn>
 <CAOQ4uxj6EF5G=0RAE45ovVLqbro9TJP-WdP-ixwAgnr7zg-2wA@mail.gmail.com>
 <f5xtqk4gpbeowtnbiegbfosnpjr4ge42rfebjgyz66cxxzmhse@fjn44egzgdpt>
 <CAOQ4uxiPwaq5J9iDAjEQuP4QSXfxi8993ShpAJRfYQA3Dd0Vrg@mail.gmail.com>
 <fiur7goc4ber7iwzkvm6ufbnulxkvdlfwqe2wjq3w3zcw73eit@cvhs5ndfkhcq>
 <CAOQ4uxhwQaDaq+LUtMggY9bkPECNHDYQKgh8Dfe0-iDm7FiLbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhwQaDaq+LUtMggY9bkPECNHDYQKgh8Dfe0-iDm7FiLbA@mail.gmail.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: A00311FCE8
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.com:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:dkim,suse.cz:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01

On Wed 16-07-25 12:31:41, Amir Goldstein wrote:
> On Wed, Jul 16, 2025 at 10:55 AM Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 15-07-25 16:50:00, Amir Goldstein wrote:
> > > On Tue, Jul 15, 2025 at 2:11 PM Jan Kara <jack@suse.cz> wrote:
> > > > On Mon 14-07-25 21:59:22, Amir Goldstein wrote:
> > > > > On Mon, Jul 14, 2025 at 7:25 PM Jan Kara <jack@suse.cz> wrote:
> > > > > > > I don't think there is much to lose from this retry behavior.
> > > > > > > The only reason we want to opt-in for it is to avoid surprises of
> > > > > > > behavior change in existing deployments.
> > > > > > >
> > > > > > > While we could have FAN_RETRY_UNANSWERED as an
> > > > > > > independent feature without a handover ioctl,
> > > > > > > In order to avoid test matrix bloat, at least for a start (we can relax later),
> > > > > > > I don't think that we should allow it as an independent feature
> > > > > > > and especially not for legacy modes (i.e. for Anti-Virus) unless there
> > > > > > > is a concrete user requesting/testing these use cases.
> > > > > >
> > > > > > With queue-fd design I agree there's no reason not to have the "resend
> > > > > > pending events" behavior from the start.
> > > > > >
> > > > > > > Going on about feature dependency.
> > > > > > >
> > > > > > > Practically, a handover ioctl is useless without
> > > > > > > FAN_REPORT_RESPONSE_ID, so for sure we need to require
> > > > > > > FAN_REPORT_RESPONSE_ID for the handover ioctl feature.
> > > > > > >
> > > > > > > Because I do not see an immediate use case for
> > > > > > > FAN_REPORT_RESPONSE_ID without handover,
> > > > > > > I would start by only allowing them together and consider relaxing
> > > > > > > later if such a use case is found.
> > > > > >
> > > > > > We can tie them together but I think queue-fd design doesn't require
> > > > > > FAN_REPORT_RESPONSE_ID. Since we resend events anyway, we'd generate new
> > > > > > fds for events as well and things would just work AFAICT.
> > > > > >
> > > > >
> > > > > Right. hmm.
> > > > > I'd still like to consider the opportunity of the new-ish API for
> > > > > deprecating some old legacy API baggage.
> > > > >
> > > > > For example: do you consider the fact that async events are mixed
> > > > > together with permission/pre-content events in the same queue
> > > > > an historic mistake or a feature?
> > > >
> > > > So far I do consider it a feature although not a particularly useful one.
> > > > Given fanotify doesn't guarantee ordering of events and async events can
> > > > arbitrarily skip over the permission events there's no substantial
> > > > difference to having two notification groups.
> > >
> > > I am not sure I understand your claim.
> > > It sounds like you are arguing for my case, because mixing
> > > mergeable async events and non-mergeable permission events
> > > in the same queue can be very confusing.
> > > Therefore, I consider it an anti-feature.
> > > Users can get the same functionality from having two groups,
> > > with much more sane semantics.
> >
> > I'd say with the same semantics but less expectations about possibly nicer
> > semantics :). But we agree two groups are a cleaner way to achieve the
> > same and give userspace more flexibility with handling the events at the
> > same time.
> >
> > > > > I'm tempted, as we split the control fd from the queue fd to limit
> > > > > a queue to events of the same "type".
> > > > > Maybe an O_RDONLY async queue fd
> > > > > or an O_RDWR permission events queue fd
> > > > > or only allow the latter with the new API?
> > > >
> > > > There's value in restricting unneeded functionality and there's also value
> > > > in having features not influencing one another so the balance has to be
> > > > found :).
> > >
> > > <nod>
> > >
> > > > So far I don't find that disallowing async events with queue fd
> > > > or restricting fd mode for queue fd would simplify our life in a
> > > > significant way but maybe I'm missing something.
> > > >
> > >
> > > It only simplifies our life if we are going to be honest about test coverage.
> > > When we return a pending permission events to the head of the queue
> > > when queue fd is closed, does it matter if the queue has async events
> > > or other permission events or a mix of them?
> > >
> > > Logically, it shouldn't matter, but assuming that for tests is not the
> > > best practice.
> >
> > Agreed.
> >
> > > Thus, reducing the test matrix for a new feature by removing a
> > > configuration that I consider misguided feels like a good idea, but I am
> > > also feeling that my opinion on this matter is very biased, so I'd be
> > > happy if you can provide a more objective decision about the
> > > restrictions.
> >
> > Heh, nobody is objective :). We are all biased by our past experiences.
> > Which is why discussing things together is so beneficial. I agree about
> > the benefit of simplier testing and that hardly anybody is going to miss
> > the functionality, what still isn't 100% clear to me how the restrictions
> > would be implemented in the API. So user creates fanotify_group() with
> > control fd feature flag. Now will he have to specify in advance whether the
> > group is for permission events or not? Already when creating the group
> > (i.e., another feature flag? Or infered from group priority?)? Or when
> > creating queue fd? Or will the group switch based on marks being placed to
> > it? I think explicit selection is less confusing than implicit by placed
> > marks. Using group priority looks appealing at first sight but currently
> > group priorities also have implications about order in which we deliver
> > events (both async and permission) to groups and it would be also somewhat
> > confusing that FAN_CLASS_PRE_CONTENT groups may still likely use
> > FAN_OPEN_PERM event. So maybe it's not that great fit. Hum... Or we can
> > have a single feature flag (good name needed!) that will create group with
> > control fd *and* restricted to permission events only. That actually seems
> > like the least confusing option to me now.
> 
> I was thinking inferred from group priority along with control fd feature flag,
> but I agree that being more explicit is better.
> 
> How about tying the name to your FAN_RETRY patch
> and including its functionality along with the control fd:
> 
> FAN_RESTARTABLE_EVENTS
>        Events for fanotify groups initialized with this flag will be restarted
>        if the group file descriptor is closed after reading the
> permission events
>        and before responding to the event.
>        This means that if an event handler program gets stuck, a new event
>        handler can be started before killing the old event handler,
> without missing
>        the permission event.
>        The file descriptor returned from fanotify_init() cannot be
> used to read and
>        respond to permission events, only to configure marks.
>        The IOC_FAN_OPEN_QUEUE_FD ioctl is required to acquire a secondary
>        event queue file descriptor.  This event queue file descriptor is used to
>        read the permission events and respond to them.
>        When the queue file descriptor is closed, events that were read from the
>        queue but not responded to, are returned to the queue and can be handled
>        by another instance of the program that opens a new queue file
> descriptor.
>        The use of either FAN_CLASS_CONTENT or FAN_CLASS_PRE_CONTENT
>        is required along with this flag.
>        Only permission events and pre-content events are allowed to be
> set in mark
>        masks of a group that was initialized with this flag.

Sounds very nice to me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

