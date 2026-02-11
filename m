Return-Path: <linux-fsdevel+bounces-76964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLm8Fpm8jGmisgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 18:30:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CD21269C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 18:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3878301CF86
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 17:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC62434BA44;
	Wed, 11 Feb 2026 17:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jma74DSU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UOXdsOea"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3205234A3AC;
	Wed, 11 Feb 2026 17:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770830985; cv=none; b=OE+kmRkGaOxhr/LttIVSc3SQ3E6ICSrsCuNHJGxRlwyy40o/i5dmYkPfMtSH4248+uoSKXd+HPTfPE4HPotA9YbiDUex/h5jTZxe60Fyx6VkjR5t0P656piMvl8MgHGbSO7g9276X9hFIneVb2r1MsP+l9voX9ax+1e6lawmeOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770830985; c=relaxed/simple;
	bh=as33h5+gUvzghnNp7Ka3pHr7sX5ESwaGrsqJlF74sU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0r9smg7d5Fg5Fd+kUmUVMg23OEDE3TKAfuietKBNK1nOnYhSLQ+SaL1ivY0mESsar4CL2MVlQL0fciGZ+6LA8O2JSRJmClaav7CWyaf5aIldeazB90Rxr0gKAzO9Nactf32Vnb+zN9q80G9yfA35midkGjmYQ6ACfAU58J7SlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jma74DSU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UOXdsOea; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 11 Feb 2026 18:29:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770830981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cbEel4PmuiUrUyHkaWhV7dLVKIPBghtgKZGu2hBZ3ec=;
	b=Jma74DSUzZPNEfuy6ZOhRYuM2HMTFeS9q478o4j03Y5HEZSnqL/fcQaiH4WR1M1XS6nuiz
	KKvTZ+D44QptJZnk3zzvUotmD6PVDrmgBbfxysH+N1x1ewUcKYF3u+xwGeFxcdeF4WcSTj
	lyD6KucPfiZmYcBF55D+QDVg06GXBkB4WbqipKjoJCXMxPKSopsHa2Yq2kVQ01BEW5SZap
	X3vH5afWqIYoyyk4aqEuYhSfT/E5aJKwAuhsVZzy9n/GCjFTYM+9T64/LtCklXQTZbhjMp
	mzIJTgBASe/Zd5Nhj9S5tovWLWecxhX42MAl3F+8Fr8ldqXAOtmrJ3Gi4eKQmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770830981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cbEel4PmuiUrUyHkaWhV7dLVKIPBghtgKZGu2hBZ3ec=;
	b=UOXdsOeaBE3esYDWd+7rhBhF5NaDMRuQD4lXcXFbPMXaxUeNLwZQnByA6nDfa+Wf9sGfAk
	TshOCCioSGateLCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
	surenb@google.com, shakeel.butt@linux.dev,
	syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com,
	syzbot+237b5b985b78c1da9600@syzkaller.appspotmail.com,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] procfs: Prevent double mmput() in do_procmap_query()
Message-ID: <20260211172940.9RQbZViV@linutronix.de>
References: <20260129215340.3742283-1-andrii@kernel.org>
 <87qzqsa1br.ffs@tglx>
 <CAEf4BzZHktcrxO0_PnMer-oEsAm++R4VZKj-gCmft-mVi58P8g@mail.gmail.com>
 <87ikc49unc.ffs@tglx>
 <20260211115825.MLF4L4Jq@linutronix.de>
 <CAEf4BzZ__PYqiYEBxJQhAaV8fyNYSmDB5rKDGsvmpXG-Vu4eMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEf4BzZ__PYqiYEBxJQhAaV8fyNYSmDB5rKDGsvmpXG-Vu4eMQ@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76964-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel,4e70c8e0a2017b432f7a,237b5b985b78c1da9600];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:mid,linutronix.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 03CD21269C0
X-Rspamd-Action: no action

On 2026-02-11 09:24:15 [-0800], Andrii Nakryiko wrote:
> We raced with Thomas sending the same fix, I see that my patch was
> staged by Andrew already in [0], just FYI
> 
This one has a reviewer :) 

Sebastian

