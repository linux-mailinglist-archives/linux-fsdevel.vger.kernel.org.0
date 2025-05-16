Return-Path: <linux-fsdevel+bounces-49263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B01F0AB9D59
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 15:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A120CA25125
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 13:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B1F72603;
	Fri, 16 May 2025 13:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGwrFC9S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140A53BB48;
	Fri, 16 May 2025 13:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747402173; cv=none; b=MNWyvFiaP0N+x3okLuZPUhqOoukbv7KtEoZkF9wcPAZQnkpt1DjMDtWzRVvYVpmilRkQebuAmWSUeeQdyNaMcU9JIdQZvm3LvOjifX1eF15sgaNJyG0sgLnZ7QqMjg0V1CtmRGg4sXWiHLMGQ3DyNAD/q/PbitlsNaMVPHrAyGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747402173; c=relaxed/simple;
	bh=zgD53pa0Ne5kRM52TE45bY+sFebDuSukI3Nkzr0IjBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNKFVyH1s/DcPHeHbTlc23VKrbePQJb2tBLepY6KCUNHfE47A3LjEYzTFoQQULrCrS5sLr9TmOrXyLv05auHdrmgJ4Orc1N6F34fA1QL+OSFeIg9mJTXOOc63g3mqgUUo/J0fYr3x7N469pXoxBiT30TmCUdYrKDuFI5d942JVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGwrFC9S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00918C4CEE4;
	Fri, 16 May 2025 13:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747402172;
	bh=zgD53pa0Ne5kRM52TE45bY+sFebDuSukI3Nkzr0IjBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BGwrFC9SMHwcc8mfpe7hJFPmrNcip8Du+0ZFcKYKlWcFdh26xpo3r4rl7pl/r/j53
	 MMtDHJT+gyI5D4zQTrM4f8ZuX5764q4fiHEqBoX7/2jXVMzvSdDbIPiyR9+MxNY1yV
	 Kf6JpADX4AKvyGiTTVjh7LeftAssfrr9ier7GkPJ7vmL4AcUCVdxsBjTfIrzlrUgBf
	 sVwfcPeMmoTPENMfrhT8c2ts1gjwVO+MmFyGvO7pG7KxbGZCpESzNEsOImASjwA1PQ
	 W51BFTR9eytYk779Y7gu+EYwBrBZZ6vTdUW3ypwW4UgTpY+o5Pva0pBK/4rMJMMCBt
	 vvmVpnxCSJzJA==
Date: Fri, 16 May 2025 15:29:24 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: linux-fsdevel@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Eric Dumazet <edumazet@google.com>, 
	Oleg Nesterov <oleg@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	David Rheinsberg <david@readahead.eu>, Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: Re: [PATCH v7 7/9] coredump: validate socket name as it is written
Message-ID: <20250516-erden-demagogen-2f5b823aa8e3@brauner>
References: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org>
 <20250515-work-coredump-socket-v7-7-0a1329496c31@kernel.org>
 <CAG48ez1wqbOmQMqg6rH4LNjNifHU_WciceO_SQwu8T=tA_KxLw@mail.gmail.com>
 <20250516-planen-radar-2131a4b7d9b1@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250516-planen-radar-2131a4b7d9b1@brauner>

> > The third strscpy() argument is semantically supposed to be the
> > destination buffer size, not the amount of data to copy. For trivial
> > invocations like here, strscpy() actually allows you to leave out the
> > third argument.
> 
> Eeeeewww, that's really implicit behavior. I can use the destination

Ah, I see the argument is optional. I thought you could pass 0 or
something weird.

