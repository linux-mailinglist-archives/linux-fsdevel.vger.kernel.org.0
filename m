Return-Path: <linux-fsdevel+bounces-55126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55408B070F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 10:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8815B4A49DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 08:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F862EF9C1;
	Wed, 16 Jul 2025 08:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uwakXVMf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6XWvwLhG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uwakXVMf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6XWvwLhG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79532857E2
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 08:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752656126; cv=none; b=Pnzamv/4fJj3iU4VWBnnetJIwJrzHhHnBv2LLCqOuFYRj6aCgYHsBgGgwLmJrIntogCWqMXypmqwJTkFL/IJo5mAGSGDnvLuL0FUuZ+q+EIe6AryzJhpnkH7BW1qQO0bYYJ3zt5qraBoCb/78RNO9s6RzYdJVyMmP1geMseCsMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752656126; c=relaxed/simple;
	bh=22H0L7n77Z//QSOSwWUai8q3L1bCdJtgMgYZDO7Mf4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3NXJuKVFUEUZzEs6gM0rrvkf3elRRzKeS7B+9O/6WHdE/SiWD/RviFH+o6/1w9eQDbCSaSxjcJ6BAsUjovp2p2j5H3Ru8Onit0hWAXrb2ltH/5+J72cXyq1HktZXuyvlUIs2cVyfr8LHAEv0P1Gghx2nrs6K3btyXFoTr+5hBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uwakXVMf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6XWvwLhG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uwakXVMf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6XWvwLhG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 651872122D;
	Wed, 16 Jul 2025 08:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752656122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rxxhtDer8yWZayn6qsbZSwJTpmaOTZLqtA4Uettt6U8=;
	b=uwakXVMfTYL7e2GhZkd0cqf0DNC3Q9BM7/+B+8DQ5sWJ6QPS81Imt+2QDuT0a4cRZDlS7g
	5hf24tUY0aArHjbbgOpXBK54EojeSt2n7K0BTrmG2uUB4rmBf68CUnmIxplQ5zjFVlq8Fu
	Jwppwq9YkslAx5vZ5/66NhRZOhwW+XM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752656122;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rxxhtDer8yWZayn6qsbZSwJTpmaOTZLqtA4Uettt6U8=;
	b=6XWvwLhGpk3/832TVnZo1Dw3HoXsC3SgvRRGE2fLfyWK4mhxDOybIwR3qrOCmYWE5nDT+k
	xddl5yl/BwpgtXAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=uwakXVMf;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6XWvwLhG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752656122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rxxhtDer8yWZayn6qsbZSwJTpmaOTZLqtA4Uettt6U8=;
	b=uwakXVMfTYL7e2GhZkd0cqf0DNC3Q9BM7/+B+8DQ5sWJ6QPS81Imt+2QDuT0a4cRZDlS7g
	5hf24tUY0aArHjbbgOpXBK54EojeSt2n7K0BTrmG2uUB4rmBf68CUnmIxplQ5zjFVlq8Fu
	Jwppwq9YkslAx5vZ5/66NhRZOhwW+XM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752656122;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rxxhtDer8yWZayn6qsbZSwJTpmaOTZLqtA4Uettt6U8=;
	b=6XWvwLhGpk3/832TVnZo1Dw3HoXsC3SgvRRGE2fLfyWK4mhxDOybIwR3qrOCmYWE5nDT+k
	xddl5yl/BwpgtXAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 57ECC13306;
	Wed, 16 Jul 2025 08:55:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rlpxFfpod2iKHQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 16 Jul 2025 08:55:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EEF1AA094F; Wed, 16 Jul 2025 10:55:21 +0200 (CEST)
Date: Wed, 16 Jul 2025 10:55:21 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Ibrahim Jirdeh <ibrahimjirdeh@meta.com>, 
	josef@toxicpanda.com, lesha@meta.com, linux-fsdevel@vger.kernel.org, sargun@meta.com
Subject: Re: [PATCH] fanotify: support custom default close response
Message-ID: <fiur7goc4ber7iwzkvm6ufbnulxkvdlfwqe2wjq3w3zcw73eit@cvhs5ndfkhcq>
References: <CAOQ4uxjd1tPFoV6CrsktJK8yr+ZMBptTMK-qH_+ADjiK7voYOw@mail.gmail.com>
 <20250711223041.1249535-1-ibrahimjirdeh@meta.com>
 <CAOQ4uxhN6ok6BCBGbxeUt9ULq6g=qL6=_2_QGi8MqTHv5ZN7Vg@mail.gmail.com>
 <sx5g7pmkchjqucfbzi77xh7wx4wua5nteqi5bsa2hfqgxua2a2@v7x6ja3gsirn>
 <CAOQ4uxj6EF5G=0RAE45ovVLqbro9TJP-WdP-ixwAgnr7zg-2wA@mail.gmail.com>
 <f5xtqk4gpbeowtnbiegbfosnpjr4ge42rfebjgyz66cxxzmhse@fjn44egzgdpt>
 <CAOQ4uxiPwaq5J9iDAjEQuP4QSXfxi8993ShpAJRfYQA3Dd0Vrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxiPwaq5J9iDAjEQuP4QSXfxi8993ShpAJRfYQA3Dd0Vrg@mail.gmail.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 651872122D
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
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email]
X-Spam-Score: -4.01

On Tue 15-07-25 16:50:00, Amir Goldstein wrote:
> On Tue, Jul 15, 2025 at 2:11 PM Jan Kara <jack@suse.cz> wrote:
> > On Mon 14-07-25 21:59:22, Amir Goldstein wrote:
> > > On Mon, Jul 14, 2025 at 7:25 PM Jan Kara <jack@suse.cz> wrote:
> > > > > I don't think there is much to lose from this retry behavior.
> > > > > The only reason we want to opt-in for it is to avoid surprises of
> > > > > behavior change in existing deployments.
> > > > >
> > > > > While we could have FAN_RETRY_UNANSWERED as an
> > > > > independent feature without a handover ioctl,
> > > > > In order to avoid test matrix bloat, at least for a start (we can relax later),
> > > > > I don't think that we should allow it as an independent feature
> > > > > and especially not for legacy modes (i.e. for Anti-Virus) unless there
> > > > > is a concrete user requesting/testing these use cases.
> > > >
> > > > With queue-fd design I agree there's no reason not to have the "resend
> > > > pending events" behavior from the start.
> > > >
> > > > > Going on about feature dependency.
> > > > >
> > > > > Practically, a handover ioctl is useless without
> > > > > FAN_REPORT_RESPONSE_ID, so for sure we need to require
> > > > > FAN_REPORT_RESPONSE_ID for the handover ioctl feature.
> > > > >
> > > > > Because I do not see an immediate use case for
> > > > > FAN_REPORT_RESPONSE_ID without handover,
> > > > > I would start by only allowing them together and consider relaxing
> > > > > later if such a use case is found.
> > > >
> > > > We can tie them together but I think queue-fd design doesn't require
> > > > FAN_REPORT_RESPONSE_ID. Since we resend events anyway, we'd generate new
> > > > fds for events as well and things would just work AFAICT.
> > > >
> > >
> > > Right. hmm.
> > > I'd still like to consider the opportunity of the new-ish API for
> > > deprecating some old legacy API baggage.
> > >
> > > For example: do you consider the fact that async events are mixed
> > > together with permission/pre-content events in the same queue
> > > an historic mistake or a feature?
> >
> > So far I do consider it a feature although not a particularly useful one.
> > Given fanotify doesn't guarantee ordering of events and async events can
> > arbitrarily skip over the permission events there's no substantial
> > difference to having two notification groups.
> 
> I am not sure I understand your claim.
> It sounds like you are arguing for my case, because mixing
> mergeable async events and non-mergeable permission events
> in the same queue can be very confusing.
> Therefore, I consider it an anti-feature.
> Users can get the same functionality from having two groups,
> with much more sane semantics.

I'd say with the same semantics but less expectations about possibly nicer
semantics :). But we agree two groups are a cleaner way to achieve the
same and give userspace more flexibility with handling the events at the
same time.
 
> > > I'm tempted, as we split the control fd from the queue fd to limit
> > > a queue to events of the same "type".
> > > Maybe an O_RDONLY async queue fd
> > > or an O_RDWR permission events queue fd
> > > or only allow the latter with the new API?
> >
> > There's value in restricting unneeded functionality and there's also value
> > in having features not influencing one another so the balance has to be
> > found :).
> 
> <nod>
> 
> > So far I don't find that disallowing async events with queue fd
> > or restricting fd mode for queue fd would simplify our life in a
> > significant way but maybe I'm missing something.
> >
> 
> It only simplifies our life if we are going to be honest about test coverage.
> When we return a pending permission events to the head of the queue
> when queue fd is closed, does it matter if the queue has async events
> or other permission events or a mix of them?
> 
> Logically, it shouldn't matter, but assuming that for tests is not the
> best practice.

Agreed.

> Thus, reducing the test matrix for a new feature by removing a
> configuration that I consider misguided feels like a good idea, but I am
> also feeling that my opinion on this matter is very biased, so I'd be
> happy if you can provide a more objective decision about the
> restrictions.

Heh, nobody is objective :). We are all biased by our past experiences.
Which is why discussing things together is so beneficial. I agree about
the benefit of simplier testing and that hardly anybody is going to miss
the functionality, what still isn't 100% clear to me how the restrictions
would be implemented in the API. So user creates fanotify_group() with
control fd feature flag. Now will he have to specify in advance whether the
group is for permission events or not? Already when creating the group
(i.e., another feature flag? Or infered from group priority?)? Or when
creating queue fd? Or will the group switch based on marks being placed to
it? I think explicit selection is less confusing than implicit by placed
marks. Using group priority looks appealing at first sight but currently
group priorities also have implications about order in which we deliver
events (both async and permission) to groups and it would be also somewhat
confusing that FAN_CLASS_PRE_CONTENT groups may still likely use
FAN_OPEN_PERM event. So maybe it's not that great fit. Hum... Or we can
have a single feature flag (good name needed!) that will create group with
control fd *and* restricted to permission events only. That actually seems
like the least confusing option to me now.
 
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

