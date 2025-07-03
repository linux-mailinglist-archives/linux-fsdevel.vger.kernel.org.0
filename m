Return-Path: <linux-fsdevel+bounces-53806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1E7AF77DD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 16:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EDF2567FC6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 14:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43A82EE277;
	Thu,  3 Jul 2025 14:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gOuGy5v9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/9TmepgV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gOuGy5v9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/9TmepgV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5912E62CD
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jul 2025 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751553832; cv=none; b=n40Sky2o83GO13wt4guWF1Zo77LUREwuFCEp++GE5WSy2+4hPf7ko32cRjK9u/NhNXmcjSvuZQ3CMUhYGgIB0n0vFFPi5An8q/AeXUr55+eSygKILeKagrDpG8kzUIIDcWa6UNClLnOLaYSugvNmxjqsgAam/C2mOAZKe267fUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751553832; c=relaxed/simple;
	bh=ZtslKzAI5IVUfM7amCFT9Sn81UB8w513tlOXwjsWeMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0W8h4E8TiaGFZ3xw8t/WU5lE9ylZ/Ssg0pN/z5Fi64vDyVfi/D9AaH1BX8WFHyUpPSWXQrGZctUoLcmyDF+WufPdBgB1FGktZEAEFrSECEQpUtp5RX/2RfMYkK3MXhxn8ORK92Nk28au+AgOaOVjFVck9MAV0tIlL/F76GtNJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gOuGy5v9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/9TmepgV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gOuGy5v9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/9TmepgV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9EA07211AC;
	Thu,  3 Jul 2025 14:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751553828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2KKOK5STEEnIKYkIfRLTvYhfMiKp2W9OxZzF19SQJZQ=;
	b=gOuGy5v9xWBJad9rt97dbmxFpOtw+gkEXJTLKkQ2mis+DT8vgW4sZHWII7xNFkf29Ul7mM
	k8OwKic5MyOBYb+6gwpBoqiDVwEyvNVk7T9GyNvzmzwj2hbd66umFP6WRMA0UDdMGsERMf
	65jxojAMnWwXZ4qJSm4NNtbVEYqzWx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751553828;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2KKOK5STEEnIKYkIfRLTvYhfMiKp2W9OxZzF19SQJZQ=;
	b=/9TmepgVeFFwkw4mjopyYSkBV9H2u9iyK6EehjHEaJrjcIgKUcMYqsRuCx4jHcv5rpjw9p
	bDZogSmomKgaglCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751553828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2KKOK5STEEnIKYkIfRLTvYhfMiKp2W9OxZzF19SQJZQ=;
	b=gOuGy5v9xWBJad9rt97dbmxFpOtw+gkEXJTLKkQ2mis+DT8vgW4sZHWII7xNFkf29Ul7mM
	k8OwKic5MyOBYb+6gwpBoqiDVwEyvNVk7T9GyNvzmzwj2hbd66umFP6WRMA0UDdMGsERMf
	65jxojAMnWwXZ4qJSm4NNtbVEYqzWx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751553828;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2KKOK5STEEnIKYkIfRLTvYhfMiKp2W9OxZzF19SQJZQ=;
	b=/9TmepgVeFFwkw4mjopyYSkBV9H2u9iyK6EehjHEaJrjcIgKUcMYqsRuCx4jHcv5rpjw9p
	bDZogSmomKgaglCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E5A71368E;
	Thu,  3 Jul 2025 14:43:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ac28IiSXZmgbaQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 03 Jul 2025 14:43:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 87A27A0A48; Thu,  3 Jul 2025 16:43:47 +0200 (CEST)
Date: Thu, 3 Jul 2025 16:43:47 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>, jack@suse.cz, 
	josef@toxicpanda.com, lesha@meta.com, linux-fsdevel@vger.kernel.org, sargun@meta.com
Subject: Re: [PATCH] fanotify: support custom default close response
Message-ID: <26dpu7ouochrzo4koexbwofgygqo7mhjbvswzhvqhf46i3kbvc@d6dzwpg6agoc>
References: <CAOQ4uxjTtyn04XC65hv2MVsRByGyvxJ0wK=-FZmb1sH1w0CFtA@mail.gmail.com>
 <20250703070916.217663-1-ibrahimjirdeh@meta.com>
 <CAOQ4uxgfhf6g71_8y5iXLmNVMBvYVtpPJgd9PNXQzZnqa2=CkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgfhf6g71_8y5iXLmNVMBvYVtpPJgd9PNXQzZnqa2=CkQ@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ARC_NA(0.00)[];
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
X-Spam-Level: 

On Thu 03-07-25 10:27:17, Amir Goldstein wrote:
> On Thu, Jul 3, 2025 at 9:10 AM Ibrahim Jirdeh <ibrahimjirdeh@meta.com> wrote:
> >
> > > On Wed, Jul 2, 2025 at 6:15 PM Jan Kara <jack@suse.cz> wrote:
> > > > Eventually the new service starts and we are in the situation I describe 3
> > > > paragraphs above about handling pending events.
> > > >
> > > > So if we'd implement resending of pending events after group closure, I
> > > > don't see how default response (at least in its current form) would be
> > > > useful for anything.
> > > >
> > > > Why I like the proposal of resending pending events:
> > > > a) No spurious FAN_DENY errors in case of service crash
> > > > b) No need for new concept (and API) for default response, just a feature
> > > >    flag.
> > > > c) With additional ioctl to trigger resending pending events without group
> > > >    closure, the newly started service can simply reuse the
> > > >    same notification group (even in case of old service crash) thus
> > > >    inheriting all placed marks (which is something Ibrahim would like to
> > > >    have).
> > >
> >
> > I'm also a fan of the approach of support for resending pending events. As
> > mentioned exposing this behavior as an ioctl and thereby removing the need to
> > recreate fanotify group makes the usage a fair bit simpler for our case.
> >
> > One basic question I have (mainly for understanding), is if the FAN_RETRY flag is
> > set in the proposed patch, in the case where there is one existing group being
> > closed (ie no handover setup), what would be the behavior for pending events?
> > Is it the same as now, events are allowed, just that they get resent once?
> 
> Yes, same as now.
> Instead of replying FAN_ALLOW, syscall is being restarted
> to check if a new watcher was added since this watcher took the event.

Yes, just it isn't the whole syscall that's restarted but only the
fsnotify() call.

> Wondering out loud:
> Currently we order the marks on the mark obj_list,
> within the same priority group, first-subscribed-last-handled.
> 
> I never stopped to think if this order made sense or not.
> Seems like it was just the easier way to implement insert by priority order.
> 
> But if we order the marks first-subscribed-first-handled within the same
> priority group, we won't need to restart the syscall to restart mark
> list iteration.
> 
> The new group of the newly started daemon, will be next in the mark list
> after the current stopped group returns FAN_ALLOW.
> Isn't that a tad less intrusive handover then restarting the syscall
> and causing a bunch of unrelated subsystems to observe the restart?
> 
> And I think that the first-subscribed-first-handled order makes a bit more
> sense logically.
> I mean, if admin really cares about making some super important security
> group first, admin could make sure that its a priority service that
> starts very early
> admin cannot make sure that the important group starts last...

So this idea also briefly crossed my mind yesterday but I didn't look into
it in detail. Looking at how we currently do mark iteration in fsnotify
this won't be very easy to implement. iter_info has an array of marks, some
of those are marks we are currently reporting to, some of those may be from
the next group to report to. Some may be even NULL because for this mark
type there were no more marks to report to. So it's difficult to make sure
iter_into will properly pick freshly added group and its marks without
completely restarting mark iteration. I'm not saying it cannot be done but
I'm not sure it's worth the hassle.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

