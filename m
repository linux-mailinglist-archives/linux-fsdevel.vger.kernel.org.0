Return-Path: <linux-fsdevel+bounces-67106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 100BCC3563F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 12:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A7C8934B669
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 11:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1700A311C2E;
	Wed,  5 Nov 2025 11:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="C4zyDBVF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0724231196A;
	Wed,  5 Nov 2025 11:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762342700; cv=none; b=YECp/nXNol3zln8ofzOr8Z/N3mCQ80qYzCqD5TvsPDdP4nvJHZiA7FILZzkTNYrV4r73XsDjggXowXzQt0LGybuyBIYyKPpcZ4sXSNc3H+R3MhwMoR0c/ImxqKLUB1woXa9g2lfZWDMxywcPNTWTJlTX1cgkkTIUlgsqQTEONLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762342700; c=relaxed/simple;
	bh=w39SoeICTSeuAc5AKH8YOcL5xAcb3Hq3jK64zeoGQ84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsYZQoQwllzqgcnj+vi2NrrK3WGuWe7LtnTOFfmhDd97+xqNl00OUWHumtrBecvCymHFcN2Ypra9OWxhCADAPIwfGShMGYJo/Rdw5VN1UHuIksptxya4TyJENJjgbJJ1t2yPAAwLWbHqvFfrDd38UV5cz2BnjDLR1ZqTRxG6U5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=C4zyDBVF; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A2E6640E021A;
	Wed,  5 Nov 2025 11:38:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id RXtIfwiJSE_U; Wed,  5 Nov 2025 11:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762342690; bh=InAZJOtmOUNuoM4piFxR8iQoucYHkOMwKQfNN52u4vU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C4zyDBVF/RahGHUV/1E3/v1IhiriWDroviB4y9ifO/BAYr+JJYeY9BNhYqRe9JinS
	 mFOBbaso/Ax0lQ79tXvYM//u97xgAsBx8SDN7lEEJzZPYGNIai10bS108cZyffngaf
	 RrBhEWpGZ6XVvYkuk7xoMWfsDrrHWmPk4I3lB28iLYRm6lF4Yv5J+LCZG4eEPUqFdC
	 SGcZ/GXKn/bRbvDgSo8gtIU8He6KjS5wyG1E+b4F9zQvHtoHWIus9nZnPXkYxCr9e+
	 k+VtyF22ujsXuj5f882Un5YWohfDS7OEHdwUzWSIURrW58q814GF3jYLTgBbsYZqv0
	 3N7H6cZmTZWB7ORwiM7ga6eyNk2BQaN1N4tdN4LsqqrH3gUprciabu3vYis7oPI2v9
	 OSy+DjMGyWGXEa4ILrlPlbQvZSi5SRKcr7ohXGrB0BJ9AzS1kkveuvzS5iQo4mPb/n
	 RnDEYkakU0LwqK/pnkhdX+gEMwDggqhKavqdd8UeA0WfkqzUOMGTqXSDoBGQoSVdq7
	 6DBXP55yPOSY2EPOkhS/60f+cHVhGRziZAR9dRwSBuzGFmBfDHQkxFF9XOpfSgVbul
	 gagHXPOuG0ldq/v8oQ/+zctwb92Kdsivgo6F5BNW/y9LiyzDL8EbYZIwmc8oDdFo+1
	 MeZv1iMPnhIOF1zWRvMcMO5Q=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 0D31A40E00DA;
	Wed,  5 Nov 2025 11:37:59 +0000 (UTC)
Date: Wed, 5 Nov 2025 12:37:54 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>,
	the arch/x86 maintainers <x86@kernel.org>, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tglx@linutronix.de, pfalcato@suse.de
Subject: Re: [PATCH 1/3] x86: fix access_ok() and valid_user_address() using
 wrong USER_PTR_MAX in modules
Message-ID: <20251105113754.GBaQs3Egxd9tC4xUg8@fat_crate.local>
References: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
 <20251031174220.43458-1-mjguzik@gmail.com>
 <20251031174220.43458-2-mjguzik@gmail.com>
 <CAHk-=wimh_3jM9Xe8Zx0rpuf8CPDu6DkRCGb44azk0Sz5yqSnw@mail.gmail.com>
 <20251104102544.GBaQnUqFF9nxxsGCP7@fat_crate.local>
 <20251104161359.GDaQomRwYqr0hbYitC@fat_crate.local>
 <CAHk-=whu7aVmk8zwwhh9+2Okx6aGKFUrY7CKEWK_RLieGizuKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whu7aVmk8zwwhh9+2Okx6aGKFUrY7CKEWK_RLieGizuKA@mail.gmail.com>

On Wed, Nov 05, 2025 at 10:50:21AM +0900, Linus Torvalds wrote:
> I pushed it out with a proper commit message etc. It might not be an
> acute bug right now, but I do want it fixed in 6.18, so that when
> Thomas' new scoped accessors get merged - and maybe cause the whole
> inlining pattern to be much more commonly used - this is all behind
> us.

Right.
 
> And the patch certainly _looks_ ObviouslyCorrect(tm). Famous last words.

Yeah, and we are testing the lineup in the coming weeks on a lot of hw so if
anything fires, we will catch it. So we should be good.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

