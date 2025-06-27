Return-Path: <linux-fsdevel+bounces-53138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E456FAEAF23
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 08:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDA5D4E0CD6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 06:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6CF217648;
	Fri, 27 Jun 2025 06:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Hza5wT2j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437FC214818;
	Fri, 27 Jun 2025 06:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751006685; cv=none; b=QfYwpuXrg3kS+LVx5mdMqKBwELsqjublsLdPfC9B82BL6irLKKYBOCBSWSALwMOJPbhTiuxFAZ5VnuQc9StJxChDXAcwYST6Re/GHYkyxPgQroO70+TSYGXaP50pzdC4Jz8BZyQcjpianBVWZUyj8fSOt87Iy3O8yGiERbaAuVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751006685; c=relaxed/simple;
	bh=7pIhx5HjCLpkDF6aJv/SDyMoxejq+POAMhsEB0cNBaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAvNve2aoyeZv0SHjdTNClFqeC0ENfbyhBbFIcZFEVDQyKnVFTvCVGYJl8eNEQqKuAlpH2H1QDG2CkzyzJjGrMQOjsBnMPCktv6C6tOmmxnqiERMmUJ5j0b9M/tyGA5xX2K2r3QMfPN69kNefeEjXvgzu3tp84XufmQDJPuqjTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=Hza5wT2j; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 8F2E914C2D3;
	Fri, 27 Jun 2025 08:44:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1751006675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vr7nGqbEftdaKrLXOahP98xg8w9JsBZcMEz9gbvFuyE=;
	b=Hza5wT2jlB55T5f/vRSYtc9WmE5SuWQcZFn+1MTGA3vI4w5WzwmW4IVxK4e8VCOR3rnJLX
	YHDpaWGkAKF5j+fdfZhxTWD4DD4URlAil58Uic+UVKBp71onWEmlQLvRYYODmMz7mcPjMe
	fCIPcT47djy0fiyB7HBO4hUXdqyXzYpvp4LMHjue/E1IQ5+9OcokuvB/4gmHSQIUzq4ne6
	EClR8vp6X3jpzRquGQ1PINV8+UMgAIhP/9NYmEw6unkc7fYSIJ9ZT5KMSnzvhtMr5I8Ukd
	a5TmH9vQGMcZnALdHkHB22qXo8KtsdrqVL9HXekK7RvDGgSHkcg7mryyxm1HEw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 4c2e422b;
	Fri, 27 Jun 2025 06:44:29 +0000 (UTC)
Date: Fri, 27 Jun 2025 15:44:14 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Christian Theune <ct@flyingcircus.io>,
	David Howells <dhowells@redhat.com>
Cc: Ryan Lahfa <ryan@lahfa.xyz>, Antony Antony <antony.antony@secunet.com>,
	Antony Antony <antony@phenome.org>,
	Christian Brauner <brauner@kernel.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Sedat Dilek <sedat.dilek@gmail.com>,
	Maximilian Bosch <maximilian@mbosch.me>,
	regressions@lists.linux.dev, v9fs@lists.linux.dev,
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] 9pfs issues on 6.12-rc1
Message-ID: <aF49vp50BkfjJOTG@codewreck.org>
References: <ZxFQw4OI9rrc7UYc@Antony2201.local>
 <D4LHHUNLG79Y.12PI0X6BEHRHW@mbosch.me>
 <c3eff232-7db4-4e89-af2c-f992f00cd043@leemhuis.info>
 <D4LNG4ZHZM5X.1STBTSTM9LN6E@mbosch.me>
 <CA+icZUVkVcKw+wN1p10zLHpO5gqkpzDU6nH46Nna4qaws_Q5iA@mail.gmail.com>
 <3327438.1729678025@warthog.procyon.org.uk>
 <ZxlQv5OXjJUbkLah@moon.secunet.de>
 <w5ap2zcsatkx4dmakrkjmaexwh3mnmgc5vhavb2miaj6grrzat@7kzr5vlsrmh5>
 <C7DAFD20-65D2-4B61-A612-A25FCC0C9573@flyingcircus.io>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <C7DAFD20-65D2-4B61-A612-A25FCC0C9573@flyingcircus.io>

Hi all,

sorry for the slow reply; I wasn't in Cc of most of the mails back in
October so this is a pain to navigate... Let me recap a bit:
- stuff started failing in 6.12-rc1
- David first posted "9p: Don't revert the I/O iterator after
reading"[1], which fixed the bug, but then found a "better" fix as
"iov_iter: Fix iov_iter_get_pages*() for folio_queue" [2] which was
merged instead (so the first patch was not merged)

But it turns out the second patch is not enough (or causes another
issue?), and the reverting it + applying first one works, is that
correct?
What happens if you keep [2] and just apply [1], does that still bug?

(I've tried reading through the thread now and I don't even see what was
the "bad" patch in the first place, although I assume it's ee4cdf7ba857
("netfs: Speed up buffered reading") -- was that confirmed?)


David, as you worked on this at the time it'd be great if you could have
another look, I have no idea what made you try [1] in the first place
but unless you think 9p is doing something wrong like double-reverting
on error or something like that I'd like to understand a bit more what
happens... Although given 6.12 is getting used more now it could make
sense to just apply [1] first until we understand, and have a proper fix
come second -- if someone can confirm we don't need to revert [2].


[1] https://lore.kernel.org/all/3327438.1729678025@warthog.procyon.org.uk/T/#mc97a248b0f673dff6dc8613b508ca4fd45c4fefe
[2] https://lore.kernel.org/all/3327438.1729678025@warthog.procyon.org.uk/T/#m89597a1144806db4ae89992953031cdffa0b0bf9


Thanks,
-- 
Dominique

