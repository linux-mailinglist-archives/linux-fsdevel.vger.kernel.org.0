Return-Path: <linux-fsdevel+bounces-42658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF82DA45888
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 09:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DA77168790
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 08:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAC11E1E17;
	Wed, 26 Feb 2025 08:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kXZVcSem";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Lo5vVIuL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kXZVcSem";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Lo5vVIuL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC2A258CEF
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 08:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740559127; cv=none; b=fdXBDm1ZNX/mD+rWztOOj5h1gleUtyNGK/aduVPxgX9aPZhWJTWihvScXUKnX7EpFnr5zPKDt/rswGTasn9Tjjit+fr4NZYv+SkZXz7nmoHvyP2FO8+sKBF4jpkwaZpkAycf8L82qIHQJRypuTelvf8I1YdnNTZlRRYOvmtBC4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740559127; c=relaxed/simple;
	bh=L319haLVcr7EgLjzxUtwlakNxNLMdU4uCPNlfpMnBRU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AU/mD86zH/OylJI3owomGJqu0nyUSbrEvimUV1qdKG+g8dGv8PgSNDzT4TqcFJzuJGecAHvGZYFG44QpYqHU96osVejQ8/DcGCSaW4tUX2U2yUTC53IJbYu+Ida/u6LXHl6zP7lam3qWJmq94OK5bXPVkqslnlm0EiPUxTVTWfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kXZVcSem; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Lo5vVIuL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kXZVcSem; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Lo5vVIuL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B59AD1F387;
	Wed, 26 Feb 2025 08:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740559123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qlfzfddCa02ekgtIiZ4Y7lB1ihUd1iRg4dVgIlmzNvI=;
	b=kXZVcSemKgKdHAm19BLeC7fMf2ysr6S8N4tKFEV1AyQhCm7ExozBi2zsUhcbqtcMPT9mqZ
	atk+GdiS6xJRYQ5ceo5D6kwiBKobG9Uu/5EDW1RcFb6ap+QFIcL8dJSc3eKf0IJK9JJnd7
	csKDeTJnnGG3vOMkn35UjMXAPWPUsVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740559123;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qlfzfddCa02ekgtIiZ4Y7lB1ihUd1iRg4dVgIlmzNvI=;
	b=Lo5vVIuL2K4w1s5b4UifME9dCB7a1rzZ1LfvCjZo+sQNTcmAB75q+AxcYUMFmIkguQsKDz
	h/EFqeA7v9ZdthDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kXZVcSem;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Lo5vVIuL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740559123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qlfzfddCa02ekgtIiZ4Y7lB1ihUd1iRg4dVgIlmzNvI=;
	b=kXZVcSemKgKdHAm19BLeC7fMf2ysr6S8N4tKFEV1AyQhCm7ExozBi2zsUhcbqtcMPT9mqZ
	atk+GdiS6xJRYQ5ceo5D6kwiBKobG9Uu/5EDW1RcFb6ap+QFIcL8dJSc3eKf0IJK9JJnd7
	csKDeTJnnGG3vOMkn35UjMXAPWPUsVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740559123;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qlfzfddCa02ekgtIiZ4Y7lB1ihUd1iRg4dVgIlmzNvI=;
	b=Lo5vVIuL2K4w1s5b4UifME9dCB7a1rzZ1LfvCjZo+sQNTcmAB75q+AxcYUMFmIkguQsKDz
	h/EFqeA7v9ZdthDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 777141377F;
	Wed, 26 Feb 2025 08:38:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zYeAGxPTvmdcSgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 26 Feb 2025 08:38:43 +0000
Date: Wed, 26 Feb 2025 09:38:42 +0100
Message-ID: <87jz9d5cdp.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	regressions@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Chrome and VSCode breakage with the commit b9b588f22a0c
In-Reply-To: <dede396a-4424-4e0f-a223-c1008d87a6a8@oracle.com>
References: <874j0lvy89.wl-tiwai@suse.de>
	<dede396a-4424-4e0f-a223-c1008d87a6a8@oracle.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: B59AD1F387
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.com:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Sun, 23 Feb 2025 16:18:41 +0100,
Chuck Lever wrote:
> 
> On 2/23/25 3:53 AM, Takashi Iwai wrote:
> > [ resent due to a wrong address for regression reporting, sorry! ]
> > 
> > Hi,
> > 
> > we received a bug report showing the regression on 6.13.1 kernel
> > against 6.13.0.  The symptom is that Chrome and VSCode stopped working
> > with Gnome Scaling, as reported on openSUSE Tumbleweed bug tracker
> >   https://bugzilla.suse.com/show_bug.cgi?id=1236943
> > 
> > Quoting from there:
> > """
> > I use the latest TW on Gnome with a 4K display and 150%
> > scaling. Everything has been working fine, but recently both Chrome
> > and VSCode (installed from official non-openSUSE channels) stopped
> > working with Scaling.
> > ....
> > I am using VSCode with:
> > `--enable-features=UseOzonePlatform --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto` and for Chrome, I select `Preferred Ozone platform` == `Wayland`.
> > """
> > 
> > Surprisingly, the bisection pointed to the backport of the commit
> > b9b588f22a0c049a14885399e27625635ae6ef91 ("libfs: Use d_children list
> > to iterate simple_offset directories").
> > 
> > Indeed, the revert of this patch on the latest 6.13.4 was confirmed to
> > fix the issue.  Also, the reporter verified that the latest 6.14-rc
> > release is still affected, too.
> > 
> > For now I have no concrete idea how the patch could break the behavior
> > of a graphical application like the above.  Let us know if you need
> > something for debugging.  (Or at easiest, join to the bugzilla entry
> > and ask there; or open another bug report at whatever you like.)
> > 
> > BTW, I'll be traveling tomorrow, so my reply will be delayed.
> > 
> > 
> > thanks,
> > 
> > Takashi
> > 
> > #regzbot introduced: b9b588f22a0c049a14885399e27625635ae6ef91
> > #regzbot monitor: https://bugzilla.suse.com/show_bug.cgi?id=1236943
> 
> We received a similar report a few days ago, and are likewise puzzled at
> the commit result. Please report this issue to the Chrome development
> team and have them come up with a simple reproducer that I can try in my
> own lab. I'm sure they can quickly get to the bottom of the application
> stack to identify the misbehaving interaction between OS and app.

Do you know where to report to?  The reported stuff are no distro
packages, and I myself have no experience with them, hence have no
idea about the upstream development.
If you have more clue about Chrome development, it'd be appreciated if
you can report / ask from your side.  Of course, feel free to put me
to Cc.


thanks,

Takashi

