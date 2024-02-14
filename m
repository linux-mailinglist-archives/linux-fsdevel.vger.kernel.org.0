Return-Path: <linux-fsdevel+bounces-11558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC3B854BB0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 15:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FFA61C23F8B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 14:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0735A0F8;
	Wed, 14 Feb 2024 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIxe9Hun"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9F454FAD
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Feb 2024 14:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707921631; cv=none; b=WUIg6+QDv3nn0j7tUgloO8CPVLTFqHP+EWJxkSRaXWl7XE4/Ohfy3H9oA2WKJ0eKPAbkH3uKcrAGr4H/dNIGQQMI3HKB7/Lcez/HwPFn3xaEbgMGLlxmDqH0ymoSTTZhMdQGiHv6PjYtN51xJQ79JxvFZVYY3PuVdQiIniZLqZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707921631; c=relaxed/simple;
	bh=TAApCUniVDefu+Dm4un4vmK6XS+2gCKB03wiFpB4tIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JsFcdRjvAJOgPM805KMwckrWzOw+9zS697Um2vKIbTGDNjOtGj8p1OvXzpgY06iXMuU5KuolDGeEIn4VYq1N1MGn7OCErKiMByo5WP3+pDfZNjU+MAEr5EphI/L/jcCAJeIvMPSliR+Lf9wubKN5/0tCFp2zF0TrZZql+Qt8j7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIxe9Hun; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516F4C433F1;
	Wed, 14 Feb 2024 14:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707921631;
	bh=TAApCUniVDefu+Dm4un4vmK6XS+2gCKB03wiFpB4tIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jIxe9HunF3NbfZR/vq3Md8+Y2ZBZ1bWzbtI3uuVEewfOHwOpMVhQXLEVja6xcrlx1
	 PaLoi90zPNya+G1cLMRfSn+buRrJZ9edwJkEfp+XW+km27zeOY3CxM6AljM2/1KpCi
	 m8fklFpJznMr9JpsMS3AN4SzA3JG1Ai7hF0HEp+WNsXVwGAi6QnwmQHC2TzAzl7aQA
	 KWTwoPVqf5NmUzles3uaAbHUYuqbwgWFuAjfjCj4988OJo6xZ9K/7b9Qw2/MKdGBUI
	 TtRZyATZDqJ3xHj34aDJzYK7LjVyedw9QcbPlhtIFmewP4qF6nDR2N1XSA5sq8ns+T
	 CchIY7PCqzEYg==
Date: Wed, 14 Feb 2024 15:40:26 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Seth Forshee <sforshee@kernel.org>, Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
Message-ID: <20240214-kredenzen-teamarbeit-aafb528b1c86@brauner>
References: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org>
 <20240213-vfs-pidfd_fs-v1-2-f863f58cfce1@kernel.org>
 <CAHk-=wjr+K+x8bu2=gSK8SehNWnY3MGxdfO9L25tKJHTUK0x0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjr+K+x8bu2=gSK8SehNWnY3MGxdfO9L25tKJHTUK0x0w@mail.gmail.com>

On Tue, Feb 13, 2024 at 09:17:18AM -0800, Linus Torvalds wrote:
> On Tue, 13 Feb 2024 at 08:46, Christian Brauner <brauner@kernel.org> wrote:
> >
> > * Each struct pid will refer to a different inode but the same struct
> >   pid will refer to the same inode if it's opened multiple times. In
> >   contrast to now where each struct pid refers to the same inode.
> 
> The games for this are disgusting. This needs to be done some other way.

Yeah, I'm not particularly happy about it and I did consider deviating
from this completely and doing a lookup based on stashed inode number
alone. But that would've been a bit more code. Let me see though.

> To quote the Romans:

uniti aedificamus

> Because they *are* the same thing, although you wrote the pidfs copy

I didn't see the point in sharing the code particularly for an rfc
because I didn't expect you to be enthusiastic about the original code
(Which is also why I Cced you here in the first place).

