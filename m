Return-Path: <linux-fsdevel+bounces-48178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E767AABCC9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 10:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00E6B3AC88F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 07:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DDD21CA1C;
	Tue,  6 May 2025 07:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpEZgMWt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF6B219A94;
	Tue,  6 May 2025 07:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746517170; cv=none; b=eb+0Hvu6oHRWJvwRgeNXDTBGaQ5wiTiRoow6IE0i1+AJbhJPEVWPMzy752xVp3NjIft7wWEm3iOizsIoXaiLggSK0SVGXATiod1a+xtWll1AinV4bnbwIQ0fBi0ywRDxeb9UWRG16Ox9JnosL4N4x8BsKx1G1Q/YDWzOlewxHXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746517170; c=relaxed/simple;
	bh=ldajszjlmAJBEpZ7WGRkd+NEPH8q2U32qIt+60788A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jf8WJpMsbee+UHoLmUZUMOwpwrPErDputnsB1vJZZk20SP12EwWP9uoEccaYjEaYVxY29ilHeSL0H60fTdtQuEPt2uyo/TdbY52nYaxbJ4mcZUx/YEosFi835Ij0BZW4nVKqUM8/sRM4o6xNA+17gpg/9gwWX3k1fX5R1/01uds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpEZgMWt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4E3C4CEE4;
	Tue,  6 May 2025 07:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746517169;
	bh=ldajszjlmAJBEpZ7WGRkd+NEPH8q2U32qIt+60788A8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TpEZgMWtRdVUAcq5WPuB3opmprM3oi218jk02ZJLh1AM5Fowc2zzm7ClsB6JQkLdg
	 WcdcDUvSLsWm7OAxM/fjV4cB8aj96mm9Qzr2YxyKiYAPFtZGWWuhxBeJMO3cFxny57
	 xStUmBf/jNAbGPAY054+tfLKAJoRYQxLvZElEDme4ZYktVXu7Jv7MuwF5Zc06R2Yvk
	 XqgvK2LaYbg+ackwJr5GK7551Dv45RTP9xY3Eetc2tgovd0S+pEQQQV8XFZVmaGR1j
	 6DEOmpx0LJHrIcy5N7qpfEplsuCDsjpd6BFsXaZuHSs+7w1vS/q2xwL1TCxY2JPuYR
	 PqdQ0D4c6t05g==
Date: Tue, 6 May 2025 09:39:22 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, alexander@mihalicyn.com, 
	bluca@debian.org, daan.j.demeyer@gmail.com, davem@davemloft.net, 
	david@readahead.eu, edumazet@google.com, horms@kernel.org, jack@suse.cz, 
	kuba@kernel.org, lennart@poettering.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, me@yhndnzj.com, netdev@vger.kernel.org, oleg@redhat.com, 
	pabeni@redhat.com, viro@zeniv.linux.org.uk, zbyszek@in.waw.pl
Subject: Re: [PATCH RFC v3 08/10] net, pidfs, coredump: only allow
 coredumping tasks to connect to coredump socket
Message-ID: <20250506-zertifikat-teint-d866c715291a@brauner>
References: <20250505193828.21759-1-kuniyu@amazon.com>
 <20250505194451.22723-1-kuniyu@amazon.com>
 <CAG48ez2YRJxDmAZEOSWVvCyz0fkHN2NaC=_mLzcLibVKVOWqHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez2YRJxDmAZEOSWVvCyz0fkHN2NaC=_mLzcLibVKVOWqHw@mail.gmail.com>

> ("a kernel socket" is not necessarily the same as "a kernel socket
> intended for core dumping")

Indeed. The usermodehelper is a kernel protocol. Here it's the task with
its own credentials that's connecting to a userspace socket. Which makes
this very elegant because it's just userspace IPC. No one is running
around with kernel credentials anywhere.

