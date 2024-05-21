Return-Path: <linux-fsdevel+bounces-19882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BAD8CAE5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 14:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4901A1F22207
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 12:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7515F524C9;
	Tue, 21 May 2024 12:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VK77Pmi1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D395928E7
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 12:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716294803; cv=none; b=bd8/Hf2txJyiB2bnb9S1J6Q0GzeTdHsP9P41Hlsylw3+peM4SPHYoAngqc41p1EMcvJ+qti4glXKABvnNGFrZjxNyJYr8AbL7YBdRKK3mNxb0LF9XeKurHcmYEt0fCYzLZ5uDBiwyl3RI5U1f7GJ7Xo/HR5OxGRlQwrXUbPc2bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716294803; c=relaxed/simple;
	bh=9LsLMivTSIbclkqpmoK1e2OrvZHNdkyH4684hJ5NY8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/TPIQnME5txYpzBNSgK8E5zEQtBx/fzJD4DXALr1mrFsDxoVfG9tKCRVyeiqWq1F6z4rN67Munvtf6D9CPTSgrQrZ+IH1w3GYKOrWZmydgartgCQ16y6PhUJnFux2eytfgqXHmNI7IKMyntAm5d3aCOEsyO7wceZIkMojRfwmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VK77Pmi1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D66C32786;
	Tue, 21 May 2024 12:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716294803;
	bh=9LsLMivTSIbclkqpmoK1e2OrvZHNdkyH4684hJ5NY8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VK77Pmi1jap8EVPR3kdTzHSrvvCtepGbITWpgITv0c2z9dv+M6TRZJJR64kFWDKUr
	 vat95jHtW5WImqDoBQQmgjNSnzD3LEdacpCHXzb24n2tTYFwy2wptHPsPbvuxUTzkW
	 afATpMsABfUdNIIWe3V5afRzO82jSgbJQryGDPgyULRciM2r/qj+ydUNqWHbEgfPnl
	 9ntYKr4/XtjifGdQOGx3pRs9eU8Nx7jEJQ3sz4EJr6hiUqMu92iDrWkbkR6FuZY7Dq
	 nFpwnBN3WLMCZLPeQxzac7GAASsTn9QNRaZsxM2c+Bs1+DB1mJyDr/fZpN1/JX8pDa
	 0JJgguYkR7c5A==
Date: Tue, 21 May 2024 14:33:19 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Seth Forshee <sforshee@kernel.org>, 
	Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
Message-ID: <20240521-ambitioniert-alias-35c21f740dba@brauner>
References: <20240515-anklopfen-ausgleichen-0d7c220b16f4@brauner>
 <a15b1050-4b52-4740-a122-a4d055c17f11@kernel.org>
 <a65b573a-8573-4a17-a918-b5cf358c17d6@kernel.org>
 <84bc442d-c4dd-418e-8020-e1ff987cad13@kernel.org>
 <CAHk-=whMVsvYD4-OZx20ZR6zkOPoeMckxETxtqeJP2AAhd=Lcg@mail.gmail.com>
 <d2805915-5cf0-412e-a8e3-04ff1b18b315@kernel.org>
 <CAHk-=wh68QbOZi_rYaKiydsRDnYHEaCsvK6FD83-vfE6SXg5UA@mail.gmail.com>
 <CAHk-=whgMGb0qM638KfBaa2AA9TR95D3oHJTu6=5YtRoBVWa3g@mail.gmail.com>
 <e983a37b-9eb3-4b53-8f02-d671281f82f9@kernel.org>
 <0bbf8e1d-0590-4e42-91b2-7a35614319d3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0bbf8e1d-0590-4e42-91b2-7a35614319d3@kernel.org>

On Tue, May 21, 2024 at 08:13:08AM +0200, Jiri Slaby wrote:
> On 21. 05. 24, 8:07, Jiri Slaby wrote:
> > On 20. 05. 24, 21:15, Linus Torvalds wrote:
> > > On Mon, 20 May 2024 at 12:01, Linus Torvalds
> > > <torvalds@linux-foundation.org> wrote:
> > > > 
> > > > So how about just a patch like this?  It doesn't do anything
> > > > *internally* to the inodes, but it fixes up what we expose to user
> > > > level to make it look like lsof expects.
> > > 
> > > Note that the historical dname for those pidfs files was
> > > "anon_inode:[pidfd]", and that patch still kept the inode number in
> > > there, so now it's "anon_inode:[pidfd-XYZ]", but I think lsof is still
> > > happy with that.
> > 
> > Now the last column of lsof still differs from 6.8:
> > -[pidfd:1234]
> > +[pidfd-4321]
> > 
> > And lsof tests still fail, as "lsof -F pfn" is checked against:
> >      if ! fgrep -q "p${pid} f${fd} n[pidfd:$pid]" <<<"$line"; then
> > 
> > Where $line is:
> > p1015 f3 n[pidfd-1315]
> > 
> > Wait, even if I change that minus to a colon, the inner pid (1315)
> > differs from the outer (1015), but it should not (according to the
> > test).
> 
> This fixes the test (meaning literally "it shuts up the test", but I have no
> idea if it is correct thing to do at all):
> -       return dynamic_dname(buffer, buflen, "anon_inode:[pidfd-%llu]",
> pid->ino);
> +       return dynamic_dname(buffer, buflen, "anon_inode:[pidfd:%d]",
> pid_nr(pid));
> 
> Maybe pid_vnr() would be more appropriate, I have no idea either.

So as pointed out the legacy format for pidfds is:

lrwx------ 1 root root  64 21. Mai 14:24 39 -> 'anon_inode:[pidfd]'

So it's neither showing inode number nor pid.

The problem with showing the pid unconditionally like that in
dynamic_dname() is that it's wrong in various circumstances. For
example, when the pidfd is sent into a pid namespace outside the it's
pid namespace hierarchy (e.g., into a sibling pid namespace or when the
task has already been reaped.

Imho, showing the pid is more work than it's worth especially because we
expose that info in fdinfo/<nr> anyway. So let's just do the simple thing.

