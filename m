Return-Path: <linux-fsdevel+bounces-45266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F32A75639
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 13:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E80B516C33F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 12:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200EF1C5F39;
	Sat, 29 Mar 2025 12:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jh5BBsib";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+jfvA3VY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jh5BBsib";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+jfvA3VY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F3C1AB50D
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Mar 2025 12:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743250668; cv=none; b=MF6uldQW6/jeopxYgHNTZNgzyq6vU1AYw+PPEIcyKh3FdnkJx8KS2oopdxSpLa4eY3RbENbfRvcKyKIEeoICalgVcgLV0R1J0AMn08x/XRetb+EyEEfqHB1EY0RLWet+3OZ7U2qxDtO1kdm8Y6Qsz+GCm+R5XYm7VyZ8Dm92c7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743250668; c=relaxed/simple;
	bh=Th9q2zWuN9ateO/cXt4zELyLpd5GlCiqo47HRHIwo6U=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DPbJi0zVsyAd9eWtHb8UtRXciJ22dwM3D8rKGCFKi8ZnBFH37CMqxzuy8y1mRiEu22sdu/2qzv2MDKbw5r2eu8Kz2vb/t1kAVLL5VOsnpVvwh/UEpHOpL0FfZfSAB8IC2IHiTSWDkThdGnpr6XcpDUk7Yo885m70X99j7erpZ5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jh5BBsib; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+jfvA3VY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jh5BBsib; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+jfvA3VY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 13EA51F393;
	Sat, 29 Mar 2025 12:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743250665; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qfC8qPNIcAhBLRTyMdYT4Z+49oDjmYN8xkMGiLd1fpw=;
	b=jh5BBsibFabbvx82IP2rBNMandkFtFiRu+pT5fxN3fSqSJZl5Ka+cR717dFRH8yrp6ruz0
	7Im4hc0kRBcBKQ3gxKyQp35+ce38rk7Opn/EtS9H6YJBfX4OfDbaF7kWSx/xSOuPin9EDc
	TKRfolE8vqOGrowHDKYCOrKBHsE/r/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743250665;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qfC8qPNIcAhBLRTyMdYT4Z+49oDjmYN8xkMGiLd1fpw=;
	b=+jfvA3VYGqtBsZ0pAfTuaX/iAJkH41m6Zrjmd4S+sWTAwFCpEs0JQETVwfYFltnf7X6BGe
	aXowyeY63Pd/eDBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743250665; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qfC8qPNIcAhBLRTyMdYT4Z+49oDjmYN8xkMGiLd1fpw=;
	b=jh5BBsibFabbvx82IP2rBNMandkFtFiRu+pT5fxN3fSqSJZl5Ka+cR717dFRH8yrp6ruz0
	7Im4hc0kRBcBKQ3gxKyQp35+ce38rk7Opn/EtS9H6YJBfX4OfDbaF7kWSx/xSOuPin9EDc
	TKRfolE8vqOGrowHDKYCOrKBHsE/r/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743250665;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qfC8qPNIcAhBLRTyMdYT4Z+49oDjmYN8xkMGiLd1fpw=;
	b=+jfvA3VYGqtBsZ0pAfTuaX/iAJkH41m6Zrjmd4S+sWTAwFCpEs0JQETVwfYFltnf7X6BGe
	aXowyeY63Pd/eDBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA73E13A4B;
	Sat, 29 Mar 2025 12:17:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oUNQJ+jk52e6OgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 29 Mar 2025 12:17:44 +0000
Date: Sat, 29 Mar 2025 13:17:44 +0100
Message-ID: <87wmc83uaf.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: regressions@lists.linux.dev
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Chrome and VSCode breakage with the commit b9b588f22a0c
In-Reply-To: <874j0lvy89.wl-tiwai@suse.de>
References: <874j0lvy89.wl-tiwai@suse.de>
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
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.com:url]
X-Spam-Flag: NO
X-Spam-Level: 

On Sun, 23 Feb 2025 09:53:10 +0100,
Takashi Iwai wrote:
> 
> [ resent due to a wrong address for regression reporting, sorry! ]
> 
> Hi,
> 
> we received a bug report showing the regression on 6.13.1 kernel
> against 6.13.0.  The symptom is that Chrome and VSCode stopped working
> with Gnome Scaling, as reported on openSUSE Tumbleweed bug tracker
>   https://bugzilla.suse.com/show_bug.cgi?id=1236943
> 
> Quoting from there:
> """
> I use the latest TW on Gnome with a 4K display and 150%
> scaling. Everything has been working fine, but recently both Chrome
> and VSCode (installed from official non-openSUSE channels) stopped
> working with Scaling.
> ....
> I am using VSCode with:
> `--enable-features=UseOzonePlatform --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto` and for Chrome, I select `Preferred Ozone platform` == `Wayland`.
> """
> 
> Surprisingly, the bisection pointed to the backport of the commit
> b9b588f22a0c049a14885399e27625635ae6ef91 ("libfs: Use d_children list
> to iterate simple_offset directories").
> 
> Indeed, the revert of this patch on the latest 6.13.4 was confirmed to
> fix the issue.  Also, the reporter verified that the latest 6.14-rc
> release is still affected, too.
> 
> For now I have no concrete idea how the patch could break the behavior
> of a graphical application like the above.  Let us know if you need
> something for debugging.  (Or at easiest, join to the bugzilla entry
> and ask there; or open another bug report at whatever you like.)
> 
> BTW, I'll be traveling tomorrow, so my reply will be delayed.
> 
> 
> thanks,
> 
> Takashi
> 
> #regzbot introduced: b9b588f22a0c049a14885399e27625635ae6ef91
> #regzbot monitor: https://bugzilla.suse.com/show_bug.cgi?id=1236943

After all, this seems to be a bug in Chrome and its variant, which was
surfaced by the kernel commit above: as the commit changes the
directory enumeration, it also changed the list order returned from
libdrm drmGetDevices2(), and it screwed up the application that worked
casually beforehand.  That said, the bug itself has been already
present.  The Chrome upstream tracker:
  https://issuetracker.google.com/issues/396434686

#regzbot invalid: problem has always existed on Chrome and related code


Takashi

