Return-Path: <linux-fsdevel+bounces-67311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52467C3B5F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 14:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 957C81A44B13
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 13:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E80C3431ED;
	Thu,  6 Nov 2025 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="kPRvGJg4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA167494;
	Thu,  6 Nov 2025 13:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762436235; cv=none; b=XCU0Iu921tQLDim11PtlHoeCBcXqt9IsjMWC7fa1UK5oPA8kgrhKIWJyEG7hGj+Iwko1iGkDvfL8/Yiwsy5ZCcBUeFGJ0xvS/l2oQ5HUsktZzR2vnTFuWZQ3Aw8fz9rLzlch0Srd9FHI92P4lv0FPd5YpTj92ZWnaIwFlcB23Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762436235; c=relaxed/simple;
	bh=vFnnRBTkLPd2e1WR6V+o0Wa1KKqCCfBa4J+PBZU4TaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3+yKrfbWayGnbx4X3L19Gnlo1+r3PfnEPyqfEv0LJWLkGPbCSYu3+j1+eCSOqeG9ArUf4xYspRqvkonydiFuQ9s+kfpCdS+78SfWbRz2i4IswGNVcv2cqd2Ql4bMqRSnsvNzNPFkjGef57NPfbZueu4/XpqunlHG9baPauMa6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=kPRvGJg4; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4489440E00DE;
	Thu,  6 Nov 2025 13:37:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3Z5ssJXgl1OM; Thu,  6 Nov 2025 13:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762436226; bh=FQDhBJgwj6X6q0aJgOiyBIsFD2016rlUj/knt4jjtqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kPRvGJg4T94kBzWZKgcLb/JPCfOWOP3axDSJ+eo08QfYPYXKlLKamAE8RIqlMzY+S
	 vwlzptGjdeHKV7JqUiceH9abk4tVA40IM6nKvt05FgBOk6IgahsnbaZ029w8PeqpnT
	 1W2rvoywBQOD27iGK1QERXzJuA4K56R2B34qvRvFWuT6/0GiEZycRXt7OpoG81VLNS
	 5DgtIA+/H9NMk0xpOoD2hb96OIXsHSi0+PdVKEWDZ5fewf359OSKd+Ojh5fM7ArA0H
	 BpWd5N/MMy1rndKazzNvc89/YidPRV4PXA424bu19QOyVqlvLcxdnDw4NxUD2HmLsb
	 k2fLff2bL5zARdjcDCfkK5BND1/uVhY8h/RQXoypBySg11ueSQIZZHBlLwjLpgXFG1
	 e3nnvZjv2kjTjfjFJ4Se3evamoEICmGZkS6xmkz72Wo8TNoeXl5NhwWvX6hotCkBdT
	 TE9iHHe0+RViLM/RZQlrPBm4pUUl3eV50ECAD/dsDcdufK6bjY+Kxn5SAQoCma29y7
	 8i/5NsyM2MfmtzrJZ7JMu5RjMJPV7+ozlf0zZ2aTxvmWGheUCyqJO12YBEwtBxrkfK
	 Nu3plvUksrYc9JY6o9GtllVuFABbFoFGD116eAeF5ikVvdePcy2zW16F/TEv1PPtg4
	 bahrYzbVkUIWO/w6YkiO1+Vo=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id D681740E015B;
	Thu,  6 Nov 2025 13:36:55 +0000 (UTC)
Date: Thu, 6 Nov 2025 14:36:49 +0100
From: Borislav Petkov <bp@alien8.de>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	the arch/x86 maintainers <x86@kernel.org>, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tglx@linutronix.de, pfalcato@suse.de
Subject: Re: [PATCH 1/3] x86: fix access_ok() and valid_user_address() using
 wrong USER_PTR_MAX in modules
Message-ID: <20251106133649.GEaQykcT0XXJ_SDE4P@fat_crate.local>
References: <20251031174220.43458-1-mjguzik@gmail.com>
 <20251031174220.43458-2-mjguzik@gmail.com>
 <CAHk-=wimh_3jM9Xe8Zx0rpuf8CPDu6DkRCGb44azk0Sz5yqSnw@mail.gmail.com>
 <20251104102544.GBaQnUqFF9nxxsGCP7@fat_crate.local>
 <20251104161359.GDaQomRwYqr0hbYitC@fat_crate.local>
 <CAGudoHGXeg+eBsJRwZwr6snSzOBkWM0G+tVb23zCAhhuWR5UXQ@mail.gmail.com>
 <20251106111429.GCaQyDFWjbN8PjqxUW@fat_crate.local>
 <CAGudoHGWL6gLjmo3m6uCt9ueHL9rGCdw_jz9FLvgu_3=3A-BrA@mail.gmail.com>
 <20251106131030.GDaQyeRiAVoIh_23mg@fat_crate.local>
 <CAGudoHG1P61Nd7gMriCSF=g=gHxESPBPNmhHjtOQvG8HhpW0rg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGudoHG1P61Nd7gMriCSF=g=gHxESPBPNmhHjtOQvG8HhpW0rg@mail.gmail.com>

On Thu, Nov 06, 2025 at 02:19:06PM +0100, Mateusz Guzik wrote:
> Then, as I pointed out, you should be protesting the patching of
> USER_PTR_MAX as it came with no benchmarks

That came in as a security fix. I'd say correctness before performance. And if
anyone finds a better and faster fix and can prove it, I'm all ears.

> and also resulted in a regression.

Oh well, shit happens on a daily basis. And then we fix it and move on.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

