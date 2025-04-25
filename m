Return-Path: <linux-fsdevel+bounces-47323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C18CA9C052
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 10:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A19853BC0A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 08:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AF72343AE;
	Fri, 25 Apr 2025 08:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqiguB/X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782CF26AEC;
	Fri, 25 Apr 2025 08:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745568147; cv=none; b=uJz0H2n0G3vu7o6QKR+JvOprDDFdJN3Rl6ncdxttBdHmcOjCGaxGBup/S2oXMvm/mEmNjtwcBUPw21mzyCtovFt6gD5pkB3W2cm3fwiLcwHKJZlp8mlwJQwB+L9gf/UmJcInrzAokiQ1NIJoUvIlQP1sOulDq0OCogBA8Lj3diE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745568147; c=relaxed/simple;
	bh=ZzZjk3TjuB5fjuT9Nol3bp4rK92tHdKiUKt3jAgH5SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tc014s2zn2kgo7TqPyj2ZfV4aCXJgLqkhVnuPDK9vyoEeDzeCNOsI4Go4wPvancoL/Lrod8dLHM96vn6p8fDpQ/w5V0i8yzQUs/t75dy7OGhwUOJ9EGjkd3L5VBwupjIjG5tbLsBtaRHLQ2smRwea2xeK9J24bnQ7FbVQW+hOT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqiguB/X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430DCC4CEE4;
	Fri, 25 Apr 2025 08:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745568147;
	bh=ZzZjk3TjuB5fjuT9Nol3bp4rK92tHdKiUKt3jAgH5SM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oqiguB/XOmcobZQ6DwFVt3el425tJHvMGeEjW7EoxMhwMX99Esi8Bs4MiLfDbH1ee
	 mnelrUXFdpEUvjXI8i1NfphmSFgqffJ3CRLCzBzmT0Pil4MsVtfRjt8kH3q4izCMOw
	 xDm84uYLAjQIF/qAqCQbMdk0sJEizII5nfALI+uoA2otCBkDZEtNfajRHbR5L1S6Uw
	 djSkk2gh9OCezgZ/Dn55FQx1cF+2FGxXgUMxBe1rpLQKmXYLunxcqmnGibyaTED/C3
	 aSCyqm+P4uMRSGXbzXGvlliFAfBGja2oHT85/Kn1oeNMyjIpsxJb95SKqAJB/bFJtV
	 XH/1SMdYq4xYw==
Date: Fri, 25 Apr 2025 10:02:20 +0200
From: Christian Brauner <brauner@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: alexander@mihalicyn.com, bluca@debian.org, daan.j.demeyer@gmail.com, 
	davem@davemloft.net, david@readahead.eu, edumazet@google.com, horms@kernel.org, 
	jack@suse.cz, kuba@kernel.org, lennart@poettering.net, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, me@yhndnzj.com, 
	netdev@vger.kernel.org, oleg@redhat.com, pabeni@redhat.com
Subject: Re: [PATCH RFC 2/4] net, pidfs: prepare for handing out pidfds for
 reaped sk->sk_peer_pid
Message-ID: <20250425-richten-hubschrauber-02bba42aa559@brauner>
References: <20250424-chipsatz-verpennen-afa9e213e332@brauner>
 <20250425011448.86924-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250425011448.86924-1-kuniyu@amazon.com>

> I prefer DEBUG_NET_WARN_ON_ONCE() or removing it as rcu_sleep_check()

I've removed it.

