Return-Path: <linux-fsdevel+bounces-66984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6965C32E37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 21:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0940189BA33
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 20:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BA4257423;
	Tue,  4 Nov 2025 20:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cRJ5B8dt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8BA2AF1D;
	Tue,  4 Nov 2025 20:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762287504; cv=none; b=utSzn7eKJH1bypLc29nUPBmIde3z0ZEmD/Qf9Kfss8mv1ERTYhmV34AW41P/vCD9RZ6oOVCSxXvBjsp9wxVdrsZkrrTLfcWPK9/dbmx6ye0oC2Sdio9Zr9dQEFj2/yIPBXy9R0xBBzKF6InGU5cDIJGeVmENXjD3JcVqXmRLkWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762287504; c=relaxed/simple;
	bh=y2gxGTfxiZ80dfmPpbZRHh1nNDEiaWfj1uhB2eFRlMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jgb9hMoG4AeQc09K+E0IAiRjItlr0r09R1BgwrUg4SHL8DvBF8+35vq7lopgm8GwKHydRsm+QOwhN3J2IABqc2UyEkntSJRuX4wt8q7ydy7P5ldYEsJkDru0CzC2DfNXRwbkDmQ+Cw9afYohxyVWv1Ru0VVHIfc70fS5iLsUsUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cRJ5B8dt; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 91D7240E015A;
	Tue,  4 Nov 2025 20:18:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Oe6lyQbYUsc1; Tue,  4 Nov 2025 20:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762287492; bh=tKjIeGnqrPTtUgF/PkbKjsczLHU0zRG28yi7dOChAvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cRJ5B8dtmUVe0BvIW30jwsGfLK6giN7jZS0ZLVwAVXnRplSkcUAOW8/A9vrRxfLtf
	 jQw+UTmovVUHXB2PUH4xTBH0zb91Z1Eeft1XmL/HaZbG/d7PRuyAU8h0fONjwhWdMe
	 2aJLZSAOB7jxhHI8PIwjDLaxMwqhKA+JprSRSO99prpCe/8xaEnrXjhmenyijwUyiI
	 w6VHfnFcLX32SUWOm8hgfWb4Cvd/IQXjn64tlJZpWXTjCWsEcYDL3yXWHp72aaKbnX
	 YDC7UGCc4vI6LCTkz+KZ+E4vx1kNxtR4pDO2SoY8ECqFTplt5VrQXpPNUbA68NUvwQ
	 /wH2CZ1su9hSRQEof5QEUfO2wqufOhuuyjpnPPui4gNWrPoofRwW3N8UP6o1t+LPo7
	 7lUfZ4o9QpnGi3rVrAshaA1s6LW9Ssd5OoA6s2e1Y7nKlTBJ0rlefcD+rvkCGMhUvI
	 I4tu2dmLedOc+kjcPUHaWLeWOjb25kUtPGw82EF+qb6Tc+PXNcB6QT4GsbVpJkPVIr
	 XAx/HV04Wd9SCUyt5yB9GfDX2i50cGYmxkJ2d0quPVWy0xNHpGn0Xk54o6cuQSiyrg
	 stbwP1GGJQZmc+rci4JRG0R99h3/ZSU4KW3KoHjAAYNlVnFHgnMP+GDTjhX3AWtH0X
	 Ip/VvtsPg5de9VYg6z01LXuE=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 26DCE40E015B;
	Tue,  4 Nov 2025 20:17:59 +0000 (UTC)
Date: Tue, 4 Nov 2025 21:17:52 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Joerg Roedel <joro@8bytes.org>,
	Tom Lendacky <thomas.lendacky@amd.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	the arch/x86 maintainers <x86@kernel.org>, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tglx@linutronix.de, pfalcato@suse.de
Subject: Re: [PATCH 1/3] x86: fix access_ok() and valid_user_address() using
 wrong USER_PTR_MAX in modules
Message-ID: <20251104201752.GEaQpfcJtiI_IxeLVq@fat_crate.local>
References: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
 <20251031174220.43458-1-mjguzik@gmail.com>
 <20251031174220.43458-2-mjguzik@gmail.com>
 <CAHk-=wimh_3jM9Xe8Zx0rpuf8CPDu6DkRCGb44azk0Sz5yqSnw@mail.gmail.com>
 <aQozS2ZHX4x1APvb@google.com>
 <CAHk-=wjkaHdi2z62fn+rf++h-f0KM66MXKxVX-xd3X6vqs8SoQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjkaHdi2z62fn+rf++h-f0KM66MXKxVX-xd3X6vqs8SoQ@mail.gmail.com>

+ Joerg and Tom.

On Wed, Nov 05, 2025 at 04:07:44AM +0900, Linus Torvalds wrote:
> In fact, Josh Poimboeuf tried to do that __get_user() fix fairly
> recently, but he hit at least the "coco" code mis-using this thing.
> 
> See vc_read_mem() in arch/x86/coco/sev/vc-handle.c.

So Tom and I did pre-fault this whole deal just now: so we need an atomic way
to figure out whether we'll fault on the address and then handle that result
properly. Which we do. So we only need to know whether it'll fault or not,
without sleeping.

So the question is, what would be an alternative to do that? Should we do
something homegrown?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

