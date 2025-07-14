Return-Path: <linux-fsdevel+bounces-54875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC5BB04678
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 19:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 494177AFA4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 17:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559C3265CB0;
	Mon, 14 Jul 2025 17:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="26e0DMg8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4x8X4aYx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YT6iRM6v";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BHB1r2WJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3BE265CC5
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 17:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752513942; cv=none; b=MxzPdA46X2/zuOhW+XnKHnh8VZLfSx/Ya7WCADrqUDgqWKqtRsIpdszG/x/Y06o374WHDFsCOlQvXirTS6oZziWp/vU7eFvNiMH4xsQad3rIeCgrdAHjcnbK7mCUAfadS06+YfbWIBnZ7d3KpdecJR3cNyVX/USdCMAfkaYinbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752513942; c=relaxed/simple;
	bh=rsv20pIT5rgvaiqycyqP1QBYo45HwYeUYUZf7pTHimE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGzdADO7d7GbqpRVqqbMXL5hhjPmJLBnRaIqcRKo6tGZs6tZYlMU9QJ0MwWeiICg/cEb32vYnhAGU1nyMKbIH/+pA1wkXSXqP4iWgxJwxQ8PSiPHGVllX1Iv2uwyB6yxTadC+2DcF4JXgR7vJ2EwFdw4CDQ/FXe9B96duB0L4Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=26e0DMg8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4x8X4aYx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YT6iRM6v; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BHB1r2WJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6592821251;
	Mon, 14 Jul 2025 17:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752513938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bqBK4SoTUpg7ep1Y5C3b5lAtoEBMOay/53QCRw+bqC8=;
	b=26e0DMg8xeZjYhN1+Tz7tm/Y8SvM3fwr+BWase4BVWAFd88GgeuJNucZv1NPcHPtOMwkEy
	kyNOK1RibsC/j5FiQPt5+tnfHjB09iDq0jXK9EccFiyDrK8fj0pvOFIiPQuUK8CVyEVUvY
	Z7CGLjowyoKQXuMVrKgHf/ZdxVBVV3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752513938;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bqBK4SoTUpg7ep1Y5C3b5lAtoEBMOay/53QCRw+bqC8=;
	b=4x8X4aYxot+YyhK6KU39KqPQiUsJzTO6U8BywPSPPNq/qCgad3C7S8g9FncxEyWlZA+6Eh
	m0fg+iNYh5bsIzDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752513937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bqBK4SoTUpg7ep1Y5C3b5lAtoEBMOay/53QCRw+bqC8=;
	b=YT6iRM6v3mv4SG3p5V/aKjneu5YI+iNIXj3gL68UfaMRHb+o/S99ZVC7HsD5wq4xwl+Jfw
	Ovj/EGubKEKbUjV8y8aJi7X/4/QjvUcfg1Cy8JjD9xwnvNzRpV7Mp4x34lInGAtT3GgxHA
	CanD72vM+SetiSEvbMfMGhYhDbWqb7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752513937;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bqBK4SoTUpg7ep1Y5C3b5lAtoEBMOay/53QCRw+bqC8=;
	b=BHB1r2WJn0wLpEoF1TG0XRQJffDVUBS/4Txuq5JeI5S3a6Sa35i+E//8Y6d8F64T7eBV7E
	lKPOZHUlcUKb2bCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 51724138A1;
	Mon, 14 Jul 2025 17:25:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ofyEE5E9dWgRWgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 14 Jul 2025 17:25:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6D916A0997; Mon, 14 Jul 2025 19:25:36 +0200 (CEST)
Date: Mon, 14 Jul 2025 19:25:36 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>, jack@suse.cz, 
	josef@toxicpanda.com, lesha@meta.com, linux-fsdevel@vger.kernel.org, sargun@meta.com
Subject: Re: [PATCH] fanotify: support custom default close response
Message-ID: <sx5g7pmkchjqucfbzi77xh7wx4wua5nteqi5bsa2hfqgxua2a2@v7x6ja3gsirn>
References: <CAOQ4uxjd1tPFoV6CrsktJK8yr+ZMBptTMK-qH_+ADjiK7voYOw@mail.gmail.com>
 <20250711223041.1249535-1-ibrahimjirdeh@meta.com>
 <CAOQ4uxhN6ok6BCBGbxeUt9ULq6g=qL6=_2_QGi8MqTHv5ZN7Vg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhN6ok6BCBGbxeUt9ULq6g=qL6=_2_QGi8MqTHv5ZN7Vg@mail.gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

On Sat 12-07-25 10:08:25, Amir Goldstein wrote:
> On Sat, Jul 12, 2025 at 12:37 AM Ibrahim Jirdeh <ibrahimjirdeh@meta.com> wrote:
> >
> > > On Thu, Jul 3, 2025 at 4:43 PM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > On Thu 03-07-25 10:27:17, Amir Goldstein wrote:
> > > > > On Thu, Jul 3, 2025 at 9:10 AM Ibrahim Jirdeh <ibrahimjirdeh@meta.com> wrote:
> > > > > >
> > > > > > > On Wed, Jul 2, 2025 at 6:15 PM Jan Kara <jack@suse.cz> wrote:
> > > > > > > > Eventually the new service starts and we are in the situation I describe 3
> > > > > > > > paragraphs above about handling pending events.
> > > > > > > >
> > > > > > > > So if we'd implement resending of pending events after group closure, I
> > > > > > > > don't see how default response (at least in its current form) would be
> > > > > > > > useful for anything.
> > > > > > > >
> > > > > > > > Why I like the proposal of resending pending events:
> > > > > > > > a) No spurious FAN_DENY errors in case of service crash
> > > > > > > > b) No need for new concept (and API) for default response, just a feature
> > > > > > > >    flag.
> > > > > > > > c) With additional ioctl to trigger resending pending events without group
> > > > > > > >    closure, the newly started service can simply reuse the
> > > > > > > >    same notification group (even in case of old service crash) thus
> > > > > > > >    inheriting all placed marks (which is something Ibrahim would like to
> > > > > > > >    have).
> > > > > > >
> > > > > >
> > > > > > I'm also a fan of the approach of support for resending pending events. As
> > > > > > mentioned exposing this behavior as an ioctl and thereby removing the need to
> > > > > > recreate fanotify group makes the usage a fair bit simpler for our case.
> > > > > >
> > > > > > One basic question I have (mainly for understanding), is if the FAN_RETRY flag is
> > > > > > set in the proposed patch, in the case where there is one existing group being
> > > > > > closed (ie no handover setup), what would be the behavior for pending events?
> > > > > > Is it the same as now, events are allowed, just that they get resent once?
> > > > >
> > > > > Yes, same as now.
> > > > > Instead of replying FAN_ALLOW, syscall is being restarted
> > > > > to check if a new watcher was added since this watcher took the event.
> > > >
> > > > Yes, just it isn't the whole syscall that's restarted but only the
> > > > fsnotify() call.
> >
> > I was trying out the resend patch Jan posted in this thread along with a
> > simple ioctl to trigger the resend flow - it worked well, any remaining
> > concerns with exposing this functionality? If not I could go ahead and
> > pull in Jan's change and post it with additional ioctl.
> 
> I do not have any concern about the retry behavior itself,
> but about the ioctl, feature dependency and test matrix.
> 
> Regarding the ioctl, it occured to me that it may be a foot gun.
> Once the new group interrupts all the in-flight events,
> if due to a userland bug, this is done without full collaboration
> with old group, there could be nasty races of both old and new
> groups responding to the same event, and with recyclable
> ida response ids that could cause a real mess.
> 
> Of course you can say it is userspace blame, but the smooth
> handover from old service to new service instance is not always
> easy to get right, hence, a foot gun.
> 
> If we implement the control-fd/queue-fd design, we would
> not have this problem.
> The ioctl to open an event-queue-fd would fail it a queue
> handler fd is already open.
> IOW, the handover is kernel controlled and much safer.
> For the sake of discussion let's call this feature
> FAN_CONTROL_FD and let it allow the ioctl
> IOC_FAN_OPEN_QUEUE_FD.

I agree this is probably a safer variant.

> The simpler functionality of FAN_RETRY_UNANSWERED
> may be useful regardless of the handover ioctl (?), but if we
> agree that the correct design for handover is the control fd design,
> and this design will require a feature flag anyway,
> then I don't think that we need two feature flags.
> 
> If users want the retry unanswered functionality, they can use the
> new API for control fd, regardless of whether they intend to store
> the fd and do handover or not.
> 
> The control fd API means that when a *queue* fd is released,
> events remain in pending state until a new queue fd is opened
> and can also imply the retry unanswered behavior,
> when the *control* fd is released.

Right, given with queue-fd design we actually have clear "successor" fd
where to report already reported but not answered events. So we can just
move back unanswered events on close of old queue fd so they'd be reported
again on read from the new queue fd. So there will be no need to bother
other notification groups with resent events with this design.
 
> I don't think there is much to lose from this retry behavior.
> The only reason we want to opt-in for it is to avoid surprises of
> behavior change in existing deployments.
> 
> While we could have FAN_RETRY_UNANSWERED as an
> independent feature without a handover ioctl,
> In order to avoid test matrix bloat, at least for a start (we can relax later),
> I don't think that we should allow it as an independent feature
> and especially not for legacy modes (i.e. for Anti-Virus) unless there
> is a concrete user requesting/testing these use cases.

With queue-fd design I agree there's no reason not to have the "resend
pending events" behavior from the start.

> Going on about feature dependency.
> 
> Practically, a handover ioctl is useless without
> FAN_REPORT_RESPONSE_ID, so for sure we need to require
> FAN_REPORT_RESPONSE_ID for the handover ioctl feature.
> 
> Because I do not see an immediate use case for
> FAN_REPORT_RESPONSE_ID without handover,
> I would start by only allowing them together and consider relaxing
> later if such a use case is found.

We can tie them together but I think queue-fd design doesn't require
FAN_REPORT_RESPONSE_ID. Since we resend events anyway, we'd generate new
fds for events as well and things would just work AFAICT.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

