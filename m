Return-Path: <linux-fsdevel+bounces-66969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F85DC31FE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 17:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD3C518C32F5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 16:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE18032B9B7;
	Tue,  4 Nov 2025 16:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="WsJkFqFk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6F228751B;
	Tue,  4 Nov 2025 16:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762272868; cv=none; b=JIdvu3QMjr126eDmXMl5gTdogAGoUbjUP8rxeG4vW+7Cc6ssYiUS6XxLrbw79A2BMsvp3zIubbSUYNQZS0LwGn7paseFn6FTFwQGV2DvpT1lEWrGsjikDFxlw/3hJwkHDzn4zPPSDwLI3lTwfekGcelpSNX5vjzVJqyqNvo+EF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762272868; c=relaxed/simple;
	bh=jtTRcLRPl0S7ICs+I5qWMOFEWJJj/lodA+jLILnY1Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnKAupv0IDRG675DBLA+bb8KJ7VXpetlb/g1f1Br7h80ReMLfsxkTfbN1YzMoHp7/drEkHBGgbqo0a5B8KL8GypId5OkqAPynPpHwmGPKGCcUr6g19RHxLafECXbwgkOvEnQbW/r3F6aO614T9xaxlcFX+xiE7tM2CkgPs/WEl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=WsJkFqFk; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9553940E01A5;
	Tue,  4 Nov 2025 16:14:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 91D3z73EMMNp; Tue,  4 Nov 2025 16:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762272856; bh=FNgyVk2BPz+y0bw3H0Td/xY5ZxkIc4MyugmkwC321Qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WsJkFqFkzmKoHzeo2sq5btxwv0TXojUeM/TpfzyIJTc8hjVk+qMrxoJPnY3TPRilZ
	 t/3IJ9zjf39U/IwlrTalPGaaZYf9JNVMzAtMaFK/DuTjZtlJs4+jfuL4E76Chztvgt
	 qGcydLXPCOLJP6UEF+drNrAE2hT0WMQNvuywlp2yJfDtk3SSz05u6Qql6DDMkriBur
	 6CPyfQKMPPfVtTnYyIldqC6gcondafrVYRbELqQUe5P/OfY2ScnKwFfGpqklHI5kbo
	 u1ZjyrP4pOmQBE2zbfa/emBGke7hSr5TjQiM6fPMF03tW0gQHvkFc/p2O/OQmafP2h
	 URuLkFeRPbHqV1XI8SuNUE8SgquwvStXir1n3UcKu4/zhnMHb7xfiuZ032qWQ2xPxq
	 7E5KWsJ61g0+eZ4mcpGrUaN66gGGYkNF8TaPcELzqSo2kU3I7oJzf+UIDWB0WONd4o
	 a8k8WJKHv6QW5W7/X41jlT36U7sOOCwApDg1V4H0OX2audqiMRpA6bm5aHtiamb6FU
	 xrZbzE/Xkxzm1ogLCyRh0eGBlWurj6KVgldwPd/ZY8qgUgBj/2k17r2a5G7BEn+zId
	 vUA6/4kcCZOHdjRoNaHhyCgsoSAgYg3rMjMpQXkjaXZ2EuLIcalgarcTXQy+QKdUzQ
	 itFlhFjkqmmz5btnz8QXncHw=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 944BD40E015B;
	Tue,  4 Nov 2025 16:14:06 +0000 (UTC)
Date: Tue, 4 Nov 2025 17:13:59 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>,
	the arch/x86 maintainers <x86@kernel.org>, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tglx@linutronix.de, pfalcato@suse.de
Subject: Re: [PATCH 1/3] x86: fix access_ok() and valid_user_address() using
 wrong USER_PTR_MAX in modules
Message-ID: <20251104161359.GDaQomRwYqr0hbYitC@fat_crate.local>
References: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
 <20251031174220.43458-1-mjguzik@gmail.com>
 <20251031174220.43458-2-mjguzik@gmail.com>
 <CAHk-=wimh_3jM9Xe8Zx0rpuf8CPDu6DkRCGb44azk0Sz5yqSnw@mail.gmail.com>
 <20251104102544.GBaQnUqFF9nxxsGCP7@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251104102544.GBaQnUqFF9nxxsGCP7@fat_crate.local>

On Tue, Nov 04, 2025 at 11:25:44AM +0100, Borislav Petkov wrote:
> On Tue, Nov 04, 2025 at 03:25:20PM +0900, Linus Torvalds wrote:
> > Borislav - comments?
> 
> LGTM at a quick glance but lemme take it for a spin around the hw jungle here
> later and give it a more thorough look, once I've put out all the daily
> fires...

Did a deeper look, did randbuilds, boots fine on a couple of machines, so all
good AFAIIC.

I sincerely hope that helps.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

