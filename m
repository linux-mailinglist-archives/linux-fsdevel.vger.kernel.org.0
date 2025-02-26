Return-Path: <linux-fsdevel+bounces-42690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A515EA46306
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 15:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 944903A7D24
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 14:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5FB223706;
	Wed, 26 Feb 2025 14:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q0atVV/M";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZVRi0DoC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q0atVV/M";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZVRi0DoC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F85821C9E7
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 14:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740580564; cv=none; b=SQ0W8KkhhE1Bm9dOi71zgA7b2fTuX80wwnZESXzJ3MCsYb8kZpSuSLnQO9Ejg7f4ftJnpS5yKC44j29Y/xaWJ1zP5Jg+y47ZHDRyhI+OVAvEAYWHeosvdVPQewTNLX3/jebwcIPbQdjGIZLwTrVniY99RLC38+bBXIFNy1IXhm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740580564; c=relaxed/simple;
	bh=G/ve45/onfpAnZ3RV1JGsK3x9yIrXwNuU5Lk2KU+J0I=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DgESX6hBHnF+PwK7yxe4BSvn2eHt3qn5L7xPkxm+cCCvFlrANy6iOFNXiTaS0rIJSw1hFzhrg+OvK8BmdUBofNBGBeIk9b1oRtSmu6WXm3Oq5CJh7i3tLV7A4BVXaHuVjtitlKXEHVUFe5ZwKYI1wQCp3v93pDaNxE0KwDtaCkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q0atVV/M; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZVRi0DoC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q0atVV/M; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZVRi0DoC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 403E321114;
	Wed, 26 Feb 2025 14:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740580554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QpecWeaQluUonsBvLohYlcoG6HigcU9LrmOVFPkefk8=;
	b=Q0atVV/MiLpk65gHZtcnmm17Cw6+1XYgeb3OIjaImyV7kTUJB68fMnxBSgh7NXa4GLYGW6
	xqcLJ661ZTl99TMSDTYFyah0eiScr6fK8BwOvTyL/HevXnA3Z+yn1nduOuSCFEzxxNpXiq
	6Qc2F9s09yCuILkPsnQVr4Rb3tY6KRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740580554;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QpecWeaQluUonsBvLohYlcoG6HigcU9LrmOVFPkefk8=;
	b=ZVRi0DoCeBq3f8n9uu9uFDoPsxCpj0NzrOSKbTSTPeU19SfRmDEu0btOpyohSxpjSceX1n
	Tdw6lKgRKTvLqCBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740580554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QpecWeaQluUonsBvLohYlcoG6HigcU9LrmOVFPkefk8=;
	b=Q0atVV/MiLpk65gHZtcnmm17Cw6+1XYgeb3OIjaImyV7kTUJB68fMnxBSgh7NXa4GLYGW6
	xqcLJ661ZTl99TMSDTYFyah0eiScr6fK8BwOvTyL/HevXnA3Z+yn1nduOuSCFEzxxNpXiq
	6Qc2F9s09yCuILkPsnQVr4Rb3tY6KRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740580554;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QpecWeaQluUonsBvLohYlcoG6HigcU9LrmOVFPkefk8=;
	b=ZVRi0DoCeBq3f8n9uu9uFDoPsxCpj0NzrOSKbTSTPeU19SfRmDEu0btOpyohSxpjSceX1n
	Tdw6lKgRKTvLqCBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E8F1B1377F;
	Wed, 26 Feb 2025 14:35:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BI1XOMkmv2dNRwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 26 Feb 2025 14:35:53 +0000
Date: Wed, 26 Feb 2025 15:35:49 +0100
Message-ID: <87eczk4vui.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	regressions@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Chrome and VSCode breakage with the commit b9b588f22a0c
In-Reply-To: <7a4072d6-3e66-4896-8f66-5871e817d285@oracle.com>
References: <874j0lvy89.wl-tiwai@suse.de>
	<dede396a-4424-4e0f-a223-c1008d87a6a8@oracle.com>
	<87jz9d5cdp.wl-tiwai@suse.de>
	<263acb8f-2864-4165-90f7-6166e68180be@oracle.com>
	<87h64g4wr1.wl-tiwai@suse.de>
	<7a4072d6-3e66-4896-8f66-5871e817d285@oracle.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 26 Feb 2025 15:20:20 +0100,
Chuck Lever wrote:
> 
> On 2/26/25 9:16 AM, Takashi Iwai wrote:
> > On Wed, 26 Feb 2025 15:11:04 +0100,
> > Chuck Lever wrote:
> >>
> >> On 2/26/25 3:38 AM, Takashi Iwai wrote:
> >>> On Sun, 23 Feb 2025 16:18:41 +0100,
> >>> Chuck Lever wrote:
> >>>>
> >>>> On 2/23/25 3:53 AM, Takashi Iwai wrote:
> >>>>> [ resent due to a wrong address for regression reporting, sorry! ]
> >>>>>
> >>>>> Hi,
> >>>>>
> >>>>> we received a bug report showing the regression on 6.13.1 kernel
> >>>>> against 6.13.0.  The symptom is that Chrome and VSCode stopped working
> >>>>> with Gnome Scaling, as reported on openSUSE Tumbleweed bug tracker
> >>>>>   https://bugzilla.suse.com/show_bug.cgi?id=1236943
> >>>>>
> >>>>> Quoting from there:
> >>>>> """
> >>>>> I use the latest TW on Gnome with a 4K display and 150%
> >>>>> scaling. Everything has been working fine, but recently both Chrome
> >>>>> and VSCode (installed from official non-openSUSE channels) stopped
> >>>>> working with Scaling.
> >>>>> ....
> >>>>> I am using VSCode with:
> >>>>> `--enable-features=UseOzonePlatform --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto` and for Chrome, I select `Preferred Ozone platform` == `Wayland`.
> >>>>> """
> >>>>>
> >>>>> Surprisingly, the bisection pointed to the backport of the commit
> >>>>> b9b588f22a0c049a14885399e27625635ae6ef91 ("libfs: Use d_children list
> >>>>> to iterate simple_offset directories").
> >>>>>
> >>>>> Indeed, the revert of this patch on the latest 6.13.4 was confirmed to
> >>>>> fix the issue.  Also, the reporter verified that the latest 6.14-rc
> >>>>> release is still affected, too.
> >>>>>
> >>>>> For now I have no concrete idea how the patch could break the behavior
> >>>>> of a graphical application like the above.  Let us know if you need
> >>>>> something for debugging.  (Or at easiest, join to the bugzilla entry
> >>>>> and ask there; or open another bug report at whatever you like.)
> >>>>>
> >>>>> BTW, I'll be traveling tomorrow, so my reply will be delayed.
> >>>>>
> >>>>>
> >>>>> thanks,
> >>>>>
> >>>>> Takashi
> >>>>>
> >>>>> #regzbot introduced: b9b588f22a0c049a14885399e27625635ae6ef91
> >>>>> #regzbot monitor: https://bugzilla.suse.com/show_bug.cgi?id=1236943
> >>>>
> >>>> We received a similar report a few days ago, and are likewise puzzled at
> >>>> the commit result. Please report this issue to the Chrome development
> >>>> team and have them come up with a simple reproducer that I can try in my
> >>>> own lab. I'm sure they can quickly get to the bottom of the application
> >>>> stack to identify the misbehaving interaction between OS and app.
> >>>
> >>> Do you know where to report to?
> >>
> >> You'll need to drive this, since you currently have a working
> >> reproducer.
> > 
> > No, I don't have, I'm merely a messenger.
> 
> Whoever was the original reporter has the ability to reproduce this and
> answer any questions the Chrome team might have. Please have them drive
> this. I'm already two steps removed, so it doesn't make sense for me to
> report a problem for which I have no standing.

Yeah, I'm going to ask the original reporter, but this is still not
perfect at all; namely, you'll be missed in the loop.  e.g. who can
answer to the questions from Chrome team about the breakage commit?
That's why I asked you posting it previously.  If it has to be done by
the original reporter, at least, may your name / mail be put as the
contact for the kernel stuff in the report?


thanks,

Takashi

