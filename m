Return-Path: <linux-fsdevel+bounces-66918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8518BC308A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 11:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E5E8934CC8A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 10:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD2D2D5954;
	Tue,  4 Nov 2025 10:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cHmzukTa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A188634F;
	Tue,  4 Nov 2025 10:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762252577; cv=none; b=THGrq/G+CPcN0U1MLfRA+18zO4qLG2XpMuxACV52UyLENK/AEADriYMgXx217uOMLN1wCJGIswvnK9TAWa5cepTWPAj9srDJ1zcWW0YnnARJHMsKJOHdFQ6OOXGRvLorORkRFjTWfJLnfBZ+LzT+nq3PKEW1EAHJCNtHQylRQYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762252577; c=relaxed/simple;
	bh=2jcOvjqz2GO6vgAzuZs3LnV8SM+jD1nmHoELokgwBDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyrJ8PJQpa2SAj9Z9wwt7wUAjRLLN+bD+jPX2eQmbyxKxP4PI3nRZd0CLkqKr5Gc368rHpEC8X27QFTYWGCMw9buQrdC6/DaEDmuWGd0bca/V7L/k80SIacq+DuApiulurAZUmR4U5QM/lnaiuqNMQ5hWrJYdf+81+zPCcyRQtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cHmzukTa; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D3C2540E01CD;
	Tue,  4 Nov 2025 10:26:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qU-QXUyeGs75; Tue,  4 Nov 2025 10:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762251961; bh=/Y+74FurpLyA1xT8XfG7FRl00KJfIfAK9VFYn9nYZeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cHmzukTak5Wse9R7XTWyaqPwMUV32DrkokAaQeOZxS43ARLiRyp9w0kTMs0O/C4ZI
	 jrmilHRRf08msiFR5JgpfNLxxSQYSDWuMY0+Begfz10mM34kS+xdp4rubahcSMzGVu
	 E21tKw5W5qpdBOEelLpXGCfoOX2L+xNCGmRWIE8CMw8WpwqSsO+bzO5PT7ljKmBFC2
	 dMLeAo6Op6hVglW9OCh1H2qhmlD13hhQkhMPW8wQat8jCoQn2TrBlMgn3fjvZsRh7z
	 9WIlSD+4iokCfjZsHX+xUqkDVlpII7rNCTEydsytHk9yBi/2Xf4AvTwMesp7biRYhh
	 /F/rrlSm3oVuRZqNMcOLGw4ZUZJjPAf7TVhh5/yT5C83ur/bo8+rbTGT6eB2s45OrR
	 PGXwEeyssCJQ5uh7rL43cT3xkRB4O7TVJ9j4nLU1Pv6S5zVrKXRzo9c+glcQvIWLlg
	 7U0ELmqeShZaUmM5TyJDBEtC5OVoR3B4wEw0z3IqbVAgQZlBZvhiA+zHCFfk4Yph+1
	 BbbrpFWzV0L8+WHt274CPEO7SI4TCZ4s4JLxArdeDF2L0UUzMoMWLZi7wDlUwu7ZqJ
	 Hpkw0EEsM24Bs/8wRx1fObAsEwbarHKORk/dIxEvLPUPdKzUB7kaWmyCi1qyIWJYNZ
	 1MRs3FOE357klYZZxCHV2Exw=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id C8F5D40E015B;
	Tue,  4 Nov 2025 10:25:50 +0000 (UTC)
Date: Tue, 4 Nov 2025 11:25:44 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>,
	the arch/x86 maintainers <x86@kernel.org>, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tglx@linutronix.de, pfalcato@suse.de
Subject: Re: [PATCH 1/3] x86: fix access_ok() and valid_user_address() using
 wrong USER_PTR_MAX in modules
Message-ID: <20251104102544.GBaQnUqFF9nxxsGCP7@fat_crate.local>
References: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
 <20251031174220.43458-1-mjguzik@gmail.com>
 <20251031174220.43458-2-mjguzik@gmail.com>
 <CAHk-=wimh_3jM9Xe8Zx0rpuf8CPDu6DkRCGb44azk0Sz5yqSnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wimh_3jM9Xe8Zx0rpuf8CPDu6DkRCGb44azk0Sz5yqSnw@mail.gmail.com>

On Tue, Nov 04, 2025 at 03:25:20PM +0900, Linus Torvalds wrote:
> Borislav - comments?

LGTM at a quick glance but lemme take it for a spin around the hw jungle here
later and give it a more thorough look, once I've put out all the daily
fires...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

