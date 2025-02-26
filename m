Return-Path: <linux-fsdevel+bounces-42706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F75A46631
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 17:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CF173B5739
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 16:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766E821D3D4;
	Wed, 26 Feb 2025 16:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VNGWza+I";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yrABucOj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VNGWza+I";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yrABucOj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3180F21885B
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 16:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740586002; cv=none; b=hL0Py/BcB2ecLaMukVsZs0w8SnJEPjY8bvscUOTweHMaDh8bEnH7/d8Uz6KdgXziKgBT6ueAFz8VrWSUwiFdFqPkBpboIeCnQgv9tsz7TzDiCuaMUE9hU8urDVsDq56Ar0RFhY+Y+aEdRVJigs6MYs2ntyG9T+LCzJu5Trb0rws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740586002; c=relaxed/simple;
	bh=LCyoHSmapOSrLRv9RBkiRoPz+cmSw1HoK6QDtW4VrwA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H/VWFjQWilLF2BnR8lPv8hb1o1aO8VxaRB57Av3O6Sa89ZBHuL11tdmxXs0QQUIIQCHCmIKBRBK3InvG1TnfWT9CuzfXwomZw0apR471I6Uyb2meOzF8lFHi/anoIWU/bCMgmp3J2oZuI1UMaRfSPszdZHMbJQi2KGNKSdhWjYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VNGWza+I; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yrABucOj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VNGWza+I; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yrABucOj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 464CA1F387;
	Wed, 26 Feb 2025 16:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740585999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z+6Lt7QtAt9Z+XWboE+EPbbEmZwM15M49tfg3Y2BUCo=;
	b=VNGWza+IAZhDSZY3n+l/bL74q0nHEgEaOEf7VTJqK5nvYLPCa71le4Z6vi4ff2YiLtp1yq
	VmDFE+HvnaP+ELO+whmL2UdRrqpMAFvzbPsbt7WAcqbjdoyTej1KO2z+WGpwwOmKWOhDQ9
	gpBRmoUi0I2TMi3RGTIOsi/5jRIOLx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740585999;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z+6Lt7QtAt9Z+XWboE+EPbbEmZwM15M49tfg3Y2BUCo=;
	b=yrABucOj4HWWBjO5FA7Pk9t2MH32TS1RcMCCpUwME4AfLHxUl4rkrv5kxhfp9EelDa7tjJ
	D/9hhIOBaragCxDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VNGWza+I;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yrABucOj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740585999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z+6Lt7QtAt9Z+XWboE+EPbbEmZwM15M49tfg3Y2BUCo=;
	b=VNGWza+IAZhDSZY3n+l/bL74q0nHEgEaOEf7VTJqK5nvYLPCa71le4Z6vi4ff2YiLtp1yq
	VmDFE+HvnaP+ELO+whmL2UdRrqpMAFvzbPsbt7WAcqbjdoyTej1KO2z+WGpwwOmKWOhDQ9
	gpBRmoUi0I2TMi3RGTIOsi/5jRIOLx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740585999;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z+6Lt7QtAt9Z+XWboE+EPbbEmZwM15M49tfg3Y2BUCo=;
	b=yrABucOj4HWWBjO5FA7Pk9t2MH32TS1RcMCCpUwME4AfLHxUl4rkrv5kxhfp9EelDa7tjJ
	D/9hhIOBaragCxDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C62213A53;
	Wed, 26 Feb 2025 16:06:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1IU2Cg88v2daZwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 26 Feb 2025 16:06:39 +0000
Date: Wed, 26 Feb 2025 17:06:38 +0100
Message-ID: <87plj43d2p.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	regressions@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Chrome and VSCode breakage with the commit b9b588f22a0c
In-Reply-To: <5ff2354e-3bc6-4bb8-a481-bb81d717d698@oracle.com>
References: <874j0lvy89.wl-tiwai@suse.de>
	<dede396a-4424-4e0f-a223-c1008d87a6a8@oracle.com>
	<87jz9d5cdp.wl-tiwai@suse.de>
	<263acb8f-2864-4165-90f7-6166e68180be@oracle.com>
	<87h64g4wr1.wl-tiwai@suse.de>
	<7a4072d6-3e66-4896-8f66-5871e817d285@oracle.com>
	<87eczk4vui.wl-tiwai@suse.de>
	<5ff2354e-3bc6-4bb8-a481-bb81d717d698@oracle.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 464CA1F387
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 26 Feb 2025 17:00:43 +0100,
Chuck Lever wrote:
> 
> On 2/26/25 9:35 AM, Takashi Iwai wrote:
> > On Wed, 26 Feb 2025 15:20:20 +0100,
> > Chuck Lever wrote:
> >>
> >> On 2/26/25 9:16 AM, Takashi Iwai wrote:
> >>> On Wed, 26 Feb 2025 15:11:04 +0100,
> >>> Chuck Lever wrote:
> >>>>
> >>>> On 2/26/25 3:38 AM, Takashi Iwai wrote:
> >>>>> On Sun, 23 Feb 2025 16:18:41 +0100,
> >>>>> Chuck Lever wrote:
> >>>>>>
> >>>>>> On 2/23/25 3:53 AM, Takashi Iwai wrote:
> >>>>>>> [ resent due to a wrong address for regression reporting, sorry! ]
> >>>>>>>
> >>>>>>> Hi,
> >>>>>>>
> >>>>>>> we received a bug report showing the regression on 6.13.1 kernel
> >>>>>>> against 6.13.0.  The symptom is that Chrome and VSCode stopped working
> >>>>>>> with Gnome Scaling, as reported on openSUSE Tumbleweed bug tracker
> >>>>>>>   https://bugzilla.suse.com/show_bug.cgi?id=1236943
> >>>>>>>
> >>>>>>> Quoting from there:
> >>>>>>> """
> >>>>>>> I use the latest TW on Gnome with a 4K display and 150%
> >>>>>>> scaling. Everything has been working fine, but recently both Chrome
> >>>>>>> and VSCode (installed from official non-openSUSE channels) stopped
> >>>>>>> working with Scaling.
> >>>>>>> ....
> >>>>>>> I am using VSCode with:
> >>>>>>> `--enable-features=UseOzonePlatform --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto` and for Chrome, I select `Preferred Ozone platform` == `Wayland`.
> >>>>>>> """
> >>>>>>>
> >>>>>>> Surprisingly, the bisection pointed to the backport of the commit
> >>>>>>> b9b588f22a0c049a14885399e27625635ae6ef91 ("libfs: Use d_children list
> >>>>>>> to iterate simple_offset directories").
> >>>>>>>
> >>>>>>> Indeed, the revert of this patch on the latest 6.13.4 was confirmed to
> >>>>>>> fix the issue.  Also, the reporter verified that the latest 6.14-rc
> >>>>>>> release is still affected, too.
> >>>>>>>
> >>>>>>> For now I have no concrete idea how the patch could break the behavior
> >>>>>>> of a graphical application like the above.  Let us know if you need
> >>>>>>> something for debugging.  (Or at easiest, join to the bugzilla entry
> >>>>>>> and ask there; or open another bug report at whatever you like.)
> >>>>>>>
> >>>>>>> BTW, I'll be traveling tomorrow, so my reply will be delayed.
> >>>>>>>
> >>>>>>>
> >>>>>>> thanks,
> >>>>>>>
> >>>>>>> Takashi
> >>>>>>>
> >>>>>>> #regzbot introduced: b9b588f22a0c049a14885399e27625635ae6ef91
> >>>>>>> #regzbot monitor: https://bugzilla.suse.com/show_bug.cgi?id=1236943
> >>>>>>
> >>>>>> We received a similar report a few days ago, and are likewise puzzled at
> >>>>>> the commit result. Please report this issue to the Chrome development
> >>>>>> team and have them come up with a simple reproducer that I can try in my
> >>>>>> own lab. I'm sure they can quickly get to the bottom of the application
> >>>>>> stack to identify the misbehaving interaction between OS and app.
> >>>>>
> >>>>> Do you know where to report to?
> >>>>
> >>>> You'll need to drive this, since you currently have a working
> >>>> reproducer.
> >>>
> >>> No, I don't have, I'm merely a messenger.
> >>
> >> Whoever was the original reporter has the ability to reproduce this and
> >> answer any questions the Chrome team might have. Please have them drive
> >> this. I'm already two steps removed, so it doesn't make sense for me to
> >> report a problem for which I have no standing.
> > 
> > Yeah, I'm going to ask the original reporter, but this is still not
> > perfect at all; namely, you'll be missed in the loop.  e.g. who can
> > answer to the questions from Chrome team about the breakage commit?
> > That's why I asked you posting it previously.  If it has to be done by
> > the original reporter, at least, may your name / mail be put as the
> > contact for the kernel stuff in the report?
> 
> Certainly! Perhaps add Cc: linux-fsdevel@ as well.

OK, thanks, now asked on the bugzilla.


Takashi

