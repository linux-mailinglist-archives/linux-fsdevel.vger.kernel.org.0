Return-Path: <linux-fsdevel+bounces-49583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B074DABF8FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 17:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ADD08C17B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 15:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF8518C031;
	Wed, 21 May 2025 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkNTqGQs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462A21D63DF;
	Wed, 21 May 2025 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747840381; cv=none; b=bAz+GJshNraunWf1vryFVZpXB8BcrQ7ckwj1QhtDgREAkjUIGXqzAApLru+vnoe9dVtLp3T6etLSot4PAFwQJjV2GnPC/c5TwRsTuEQMODtLoOkA/7pJEf+Aa8rvsl/UzZcdgn7By3OMXifRcSPkXxdLhLrUd4iWG8KBvhHkfK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747840381; c=relaxed/simple;
	bh=YKIYQlFJfiRSqvZ5K+grxRTf6ru0wjO7N2apehq86Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQj4FtkZ2frkoPZyiMmamSwuVd0thPNbrM86y2oFHXcDRZ4dLUuxRISej9HH0uhf/d4f4SnrvnHV8brJrKhxIgkaFssT4Yal6OtE/qwmmDbBl6F6znNl0JuxkcBQQvbExIGeCpWZMpl2FRCyu2nujet6OIRKPjsPEqMSe3a9URY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tkNTqGQs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D214C4CEE4;
	Wed, 21 May 2025 15:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747840380;
	bh=YKIYQlFJfiRSqvZ5K+grxRTf6ru0wjO7N2apehq86Fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tkNTqGQsNf/aAr/nQVP0FQb48j45fv0zcv8XXhgWZdtDkePjhRzk3DOGY1+2dKUS1
	 +2uhBF9KhVolSDKFdfhtbascrSMz56C+G8XeVY6o5Fz71jc5n1KmCV82XL5aaIru7v
	 WWCDTqsATOrYnoISvCeRmkTyQHf/grASXTatzv2gFL3LV03s0RjpJoErLOiqiP64qo
	 P6TO21cEdE9pSartdRY3/MGow2Ys/KMrpbBOoTsHB/9hyWWNyTYrqeJKOxKV1ueVef
	 dTWq728qBRrwAJ34AZlGUciiVl0R8IsTxeL9w/ZaSMLJFw9/y+Xb6+Lox0epZ7mH/1
	 4oxL77Rc/hh2w==
Date: Wed, 21 May 2025 17:12:52 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, stephen@networkplumber.org, 
	alexander@mihalicyn.com, daan.j.demeyer@gmail.com, daniel@iogearbox.net, 
	davem@davemloft.net, david@readahead.eu, edumazet@google.com, horms@kernel.org, 
	jack@suse.cz, kuba@kernel.org, lennart@poettering.net, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, luca.boccassi@gmail.com, me@yhndnzj.com, netdev@vger.kernel.org, 
	oleg@redhat.com, pabeni@redhat.com, serge@hallyn.com, viro@zeniv.linux.org.uk, 
	zbyszek@in.waw.pl
Subject: Re: [PATCH v8 0/9] coredump: add coredump socket
Message-ID: <20250521-knirschen-kommst-2fcf19f7d280@brauner>
References: <20250520122838.29131f04@hermes.local>
 <20250521004207.10514-1-kuniyu@amazon.com>
 <CAG48ez0r4A7iMXzBBdPiHWycYSAGSm7VFWULCqKQPXoBKFWpEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez0r4A7iMXzBBdPiHWycYSAGSm7VFWULCqKQPXoBKFWpEw@mail.gmail.com>

> The path lookups work very differently between COREDUMP_SOCK and
> COREDUMP_FILE - they are interpreted relative to different namespaces,
> and they run with different privileges, and they do different format
> string interpretation. I think trying to determine dynamically whether
> the path refers to a socket or to a nonexistent location at which we
> should create a file (or a preexisting file we should clobber) would
> not be practical, partly for these reasons.

Agreed.

> 
> Also, fundamentally, if we have the choice between letting userspace
> be explicit about what it wants, or trying to guess userspace's intent
> from the kernel, I think we should always go for being explicit.

Agreed.

> 
> meaning in this context, like '>'; but I don't think we should be
> changing the overall approach because of this.

Agreed.

