Return-Path: <linux-fsdevel+bounces-42695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7A2A4641F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 16:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B53A189BA8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 15:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085462222AC;
	Wed, 26 Feb 2025 15:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IErsfgiO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hshsi33d";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YllqJGhE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="czSEGYDg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75131A01BF
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 15:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740582508; cv=none; b=EkYIz7nGNEhj4+CY9moxucW4sO495lCylLnd76dorkTXSAcfWyglBrFl8ysK/WgFHwI1QxBp5iXpSRenHOjGNfMh4azSxiUCe8wKp16O89+uCNRLYaFkicl54uapQyDr6ZZ1EJVcqRn+DtiQuZQfE7gRKIA5u6zrveu2wTm4Hno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740582508; c=relaxed/simple;
	bh=+n+Uj/CYqeSyMfDNX5/8ch9JpozLOwuVn6Ar9KD5VPg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=paHYvw8DgS7620BE5vPwvksi6n6nELsiuGQbEpEJKKOQgQLOWYdRDJrKO9RV/MRynEEFg6anXOcSHllY1jJev0dQZJaWL4j0ckWsCCajpA3j8qZwNYBx/3hfcFUaJZxxftnQxWr66jw0wXNo+8B4rgPJFpA+DzrYQAd+K3fO6+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IErsfgiO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hshsi33d; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YllqJGhE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=czSEGYDg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D7E341F387;
	Wed, 26 Feb 2025 15:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740582505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ohhmQGcGAX7oiS4p1z1Cv5LYBT+04raTpf9SsbgF6SQ=;
	b=IErsfgiOQ20nU9hLLWR3lkOr1M68MxC8tDIS/VJ7KpH78Yep5QOFJA/do86Ujjb8sYvGTp
	3tqYUkdX6/gSir6ZVbd5ppKoQdrBY1Jv+nT5CIpLxy28EjnIjHVTGgbloFdo5vtWTteKoJ
	yKiQqQOaDPdwQRJwvj/c8gYMVwXo6dU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740582505;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ohhmQGcGAX7oiS4p1z1Cv5LYBT+04raTpf9SsbgF6SQ=;
	b=hshsi33dwjCjz6UQ5xSb1H4hjAWSGM/1CZiUv9BUfPNeBrcc9MsM1f+lHvwSX4l/KTe28c
	tWplKh9YfjstREAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YllqJGhE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=czSEGYDg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740582504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ohhmQGcGAX7oiS4p1z1Cv5LYBT+04raTpf9SsbgF6SQ=;
	b=YllqJGhEkouUkgsMwN8q6AI/srAFTQjKtXO+jgPyxt2jblRdk/h+S3nejsV/rTouTuD1r1
	xgt7bYnMBrDWEebS0v3daVysqopMSRU4afCGXQULas38W6L/WqCNFuOZxOENSThIrk1rxx
	jZSc0GtA2gXIFBmVXrZD+9ftaG/H14Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740582504;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ohhmQGcGAX7oiS4p1z1Cv5LYBT+04raTpf9SsbgF6SQ=;
	b=czSEGYDgaXTfJxAn4lxYgiC9s7yvztVdvKKwWZOBIlTEoTYYRXjUVOwFmuqVpQ6LUODIuO
	NTq4DM8kIKgrUQCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA1F81377F;
	Wed, 26 Feb 2025 15:08:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id voJzLGguv2ftUgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 26 Feb 2025 15:08:24 +0000
Date: Wed, 26 Feb 2025 16:08:24 +0100
Message-ID: <875xkw4uc7.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Takashi Iwai <tiwai@suse.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	regressions@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Chrome and VSCode breakage with the commit b9b588f22a0c
In-Reply-To: <2025022630-reseal-habitat-939a@gregkh>
References: <874j0lvy89.wl-tiwai@suse.de>
	<dede396a-4424-4e0f-a223-c1008d87a6a8@oracle.com>
	<87jz9d5cdp.wl-tiwai@suse.de>
	<263acb8f-2864-4165-90f7-6166e68180be@oracle.com>
	<87h64g4wr1.wl-tiwai@suse.de>
	<7a4072d6-3e66-4896-8f66-5871e817d285@oracle.com>
	<2025022657-credit-undrilled-81f1@gregkh>
	<2025022626-octane-rickety-304a@gregkh>
	<87cyf44vnc.wl-tiwai@suse.de>
	<2025022630-reseal-habitat-939a@gregkh>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: D7E341F387
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.com:url];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

On Wed, 26 Feb 2025 16:02:04 +0100,
Greg KH wrote:
> 
> On Wed, Feb 26, 2025 at 03:40:07PM +0100, Takashi Iwai wrote:
> > On Wed, 26 Feb 2025 15:35:34 +0100,
> > Greg KH wrote:
> > > 
> > > On Wed, Feb 26, 2025 at 03:26:44PM +0100, Greg KH wrote:
> > > > On Wed, Feb 26, 2025 at 09:20:20AM -0500, Chuck Lever wrote:
> > > > > On 2/26/25 9:16 AM, Takashi Iwai wrote:
> > > > > > On Wed, 26 Feb 2025 15:11:04 +0100,
> > > > > > Chuck Lever wrote:
> > > > > >>
> > > > > >> On 2/26/25 3:38 AM, Takashi Iwai wrote:
> > > > > >>> On Sun, 23 Feb 2025 16:18:41 +0100,
> > > > > >>> Chuck Lever wrote:
> > > > > >>>>
> > > > > >>>> On 2/23/25 3:53 AM, Takashi Iwai wrote:
> > > > > >>>>> [ resent due to a wrong address for regression reporting, sorry! ]
> > > > > >>>>>
> > > > > >>>>> Hi,
> > > > > >>>>>
> > > > > >>>>> we received a bug report showing the regression on 6.13.1 kernel
> > > > > >>>>> against 6.13.0.  The symptom is that Chrome and VSCode stopped working
> > > > > >>>>> with Gnome Scaling, as reported on openSUSE Tumbleweed bug tracker
> > > > > >>>>>   https://bugzilla.suse.com/show_bug.cgi?id=1236943
> > > > > >>>>>
> > > > > >>>>> Quoting from there:
> > > > > >>>>> """
> > > > > >>>>> I use the latest TW on Gnome with a 4K display and 150%
> > > > > >>>>> scaling. Everything has been working fine, but recently both Chrome
> > > > > >>>>> and VSCode (installed from official non-openSUSE channels) stopped
> > > > > >>>>> working with Scaling.
> > > > > >>>>> ....
> > > > > >>>>> I am using VSCode with:
> > > > > >>>>> `--enable-features=UseOzonePlatform --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto` and for Chrome, I select `Preferred Ozone platform` == `Wayland`.
> > > > > >>>>> """
> > > > > >>>>>
> > > > > >>>>> Surprisingly, the bisection pointed to the backport of the commit
> > > > > >>>>> b9b588f22a0c049a14885399e27625635ae6ef91 ("libfs: Use d_children list
> > > > > >>>>> to iterate simple_offset directories").
> > > > > >>>>>
> > > > > >>>>> Indeed, the revert of this patch on the latest 6.13.4 was confirmed to
> > > > > >>>>> fix the issue.  Also, the reporter verified that the latest 6.14-rc
> > > > > >>>>> release is still affected, too.
> > > > > >>>>>
> > > > > >>>>> For now I have no concrete idea how the patch could break the behavior
> > > > > >>>>> of a graphical application like the above.  Let us know if you need
> > > > > >>>>> something for debugging.  (Or at easiest, join to the bugzilla entry
> > > > > >>>>> and ask there; or open another bug report at whatever you like.)
> > > > > >>>>>
> > > > > >>>>> BTW, I'll be traveling tomorrow, so my reply will be delayed.
> > > > > >>>>>
> > > > > >>>>>
> > > > > >>>>> thanks,
> > > > > >>>>>
> > > > > >>>>> Takashi
> > > > > >>>>>
> > > > > >>>>> #regzbot introduced: b9b588f22a0c049a14885399e27625635ae6ef91
> > > > > >>>>> #regzbot monitor: https://bugzilla.suse.com/show_bug.cgi?id=1236943
> > > > > >>>>
> > > > > >>>> We received a similar report a few days ago, and are likewise puzzled at
> > > > > >>>> the commit result. Please report this issue to the Chrome development
> > > > > >>>> team and have them come up with a simple reproducer that I can try in my
> > > > > >>>> own lab. I'm sure they can quickly get to the bottom of the application
> > > > > >>>> stack to identify the misbehaving interaction between OS and app.
> > > > > >>>
> > > > > >>> Do you know where to report to?
> > > > > >>
> > > > > >> You'll need to drive this, since you currently have a working
> > > > > >> reproducer.
> > > > > > 
> > > > > > No, I don't have, I'm merely a messenger.
> > > > > 
> > > > > Whoever was the original reporter has the ability to reproduce this and
> > > > > answer any questions the Chrome team might have. Please have them drive
> > > > > this. I'm already two steps removed, so it doesn't make sense for me to
> > > > > report a problem for which I have no standing.
> > > > 
> > > > Ugh, no.  The bug was explictly bisected to the offending commit.  We
> > > > should just revert that commit for now and it can come back in the
> > > > future if the root-cause is found.
> > > > 
> > > > As the revert seems to be simple, and builds here for me, I guess I'll
> > > > have to send it in. {sigh}
> > > > 
> > > > Takashi, thanks for the report and the bisection, much appreciated.
> > > 
> > > Now sent:
> > > 	https://lore.kernel.org/r/2025022644-blinked-broadness-c810@gregkh
> > 
> > Thanks Greg!
> > 
> > Let's continue hunting the cause before 6.14 release, meanwhile.
> 
> I'd prefer that the revert land in Linus's tree first and I can take the
> revert from there for the stable releases, otherwise it's going to be a
> mess once 6.14-final is released :(

Ah, I thought your patch were for stable-only, but it was for
mainline.  Let's see how it goes.


thanks,

Takashi

