Return-Path: <linux-fsdevel+bounces-67110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3EEC35814
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 12:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5010C4FB124
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 11:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F86431195D;
	Wed,  5 Nov 2025 11:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZPVq/dkN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143202FA0DD;
	Wed,  5 Nov 2025 11:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762343425; cv=none; b=LfuoZe9W5/pSRG0SuCliWjZxtzE2BcyipzC+aY90FLhoEg/cyKqru2SQraOUFWDhLdfYh2kUpR/ULOS9blL5PxneiCU3GVwaA0JxQYMfm7+Mn5GvKYIIGQL/18R81RfeSQsso1elhZOFbpr2eWdkHYyrYfYYUNadDcP8PPX61SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762343425; c=relaxed/simple;
	bh=VOMloqnyogODO4RAovI8U+2QdcgAASCJp7cCXx0YnO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5PLMP91tk/kVKPcIDqZLeqw1TxF3/zvwxshGsLQQiP6isNEMbp0YJMtJdbUPClImmxKXBRQfE+pIwqaIItbbqfr7djRQqQ7C9xPGw9A/LtFe4f7H/3+aizdGep77o0+i5jDPxDQ8r6FdWg+5cvkTTPYTaYa2g4mMdfhXe0nHfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ZPVq/dkN; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D3F1740E021A;
	Wed,  5 Nov 2025 11:50:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id B0YTNYx1HnJ2; Wed,  5 Nov 2025 11:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762343418; bh=nRo8TOnOgXeg6iUb+BAN+icb++7nkjDnWMyA+oE0JCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZPVq/dkNxYTiN/0MvlLGrVYjuugOuqND3m1nZXZvWgdexfkZodVa4SnFZn20UPesp
	 5tBJRIHmSCycCB1SRqnWJ8xct3dkSarcpYlQaem1AK04qa3vpfo6WLgBlv3i5H3/By
	 gdsVdxRVT1WRwqHszW5QKPMeBcamWgEfM6TaclHmfggk1V3ff5Vcl27nlkBulBYszA
	 OPRgpufccKr3EGqqGYCc4/rl05Ks/Tho7HAHnYZ0eWzI1xHl3mjfka3ly//RL1bt1O
	 RVWNTJQGWd6Az1YoU5v8Yc3rTgVMeLqt7e7mW6pta8NsBWHXitH8EDEGKsIC3mhTMF
	 hMqP7fQeXgwk1oSa8JUraGBDX4fi88pToU+oOR7CDDXAx+poZXhzBtHcotgB5LpUJK
	 nWwxqCplPprDQDPe49zj1uJSdN7rPZhbZA79HdJ+faGse+KttXK2MNHI9oHD7UCY8G
	 8O15Wrd1rpcoI4mghD1Ia/UHJdhYFSUtIanfW5oAi7swzLFskYh8DFHwFtoOjwFN6J
	 jei5mU0hQYn/21mg4Iw1dUzVWfWAnOUyg0XTiGKJmqxGDWNl9ms0yXscH65YgZudn+
	 8qJdlZHcBKuCIEOeKp9wGFVHhU32MV27BeOeKetjBjT8xLz+2FlnjltfPDXJtC6EM1
	 EXnecaGRhxyBKqOJKgtTvBC4=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 3B05740E00DA;
	Wed,  5 Nov 2025 11:50:05 +0000 (UTC)
Date: Wed, 5 Nov 2025 12:49:59 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Joerg Roedel <joro@8bytes.org>, Tom Lendacky <thomas.lendacky@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	the arch/x86 maintainers <x86@kernel.org>, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tglx@linutronix.de, pfalcato@suse.de
Subject: Re: [PATCH 1/3] x86: fix access_ok() and valid_user_address() using
 wrong USER_PTR_MAX in modules
Message-ID: <20251105114959.GCaQs556YmafFX_s2o@fat_crate.local>
References: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
 <20251031174220.43458-1-mjguzik@gmail.com>
 <20251031174220.43458-2-mjguzik@gmail.com>
 <CAHk-=wimh_3jM9Xe8Zx0rpuf8CPDu6DkRCGb44azk0Sz5yqSnw@mail.gmail.com>
 <aQozS2ZHX4x1APvb@google.com>
 <CAHk-=wjkaHdi2z62fn+rf++h-f0KM66MXKxVX-xd3X6vqs8SoQ@mail.gmail.com>
 <20251104201752.GEaQpfcJtiI_IxeLVq@fat_crate.local>
 <CAHk-=wgoajqRhtYi=uS0UpmH61qE=tBCwb8x3GG6ywZUqWY6zg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgoajqRhtYi=uS0UpmH61qE=tBCwb8x3GG6ywZUqWY6zg@mail.gmail.com>

On Wed, Nov 05, 2025 at 07:06:05AM +0900, Linus Torvalds wrote:
> but any other users of __get_user() that aren't in x86-specific code
> can't do that, so I do think it's probably better to just migrate the
> *good* cases - the ones known to actually be about user space - away
> from __get_user() and just leave these turds alone.

We probably should think of a scheme to stop __get_user() from spreading
around by hiding it in an arch-specific header which doesn't get exposed to
modules/drivers/etc and then once that is in place, take care of the existing
offenders and convert them slowly.

It'll need careful conversion and testing, I'd say but at least we'll have
a finite, non-growing number of occurrences to convert:

$ git grep -w __get_user *.c | grep -v arch | wc -l
43

Not a lot. (The headers are mostly macro definitions AFAICT).

The arches would then be a separate deal...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

