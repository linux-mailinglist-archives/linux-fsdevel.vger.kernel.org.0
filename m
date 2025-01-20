Return-Path: <linux-fsdevel+bounces-39716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D01FA172DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 19:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5435167760
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 18:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E991EE7BB;
	Mon, 20 Jan 2025 18:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="liD4/p6m";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="liD4/p6m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [104.223.66.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7855D7DA82;
	Mon, 20 Jan 2025 18:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.223.66.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737399477; cv=none; b=TDbaheHIOUCM6n4P/v3DRVy5VTqsnS/pV9bEBRhwmNWuYbsI/J8yUb1ploZZ2uKcs5dqqnL2VeSsaPWjY4QTptoMeBWuMNM/BczW4hXDIbGaTWfF0oT6o0dV11YJq7SymeBIRS5kBf3HQmN/xN817Et6aCFXKzMHuS+LlimUQi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737399477; c=relaxed/simple;
	bh=UzgRE03mDOrdWjy1kf/GZBCcOWxOtlWOojHoQ30Kdp0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bUKHVeK5WTvF3x8yf3EG3zlgvC4h+abN2/r+ip4MW55gp11h9XByguM8TWJRUehQZImyfHQwTVFjY9WkyobQBKQrk8Krv0K+PJ0tcjVfNhh95/SA2Ga9txaxk/NJ1ra6V2EESZM/NwiNMmh9P/GM0sIJPsxdBn7m1J74vK/n9oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=liD4/p6m; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=liD4/p6m; arc=none smtp.client-ip=104.223.66.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1737399474;
	bh=UzgRE03mDOrdWjy1kf/GZBCcOWxOtlWOojHoQ30Kdp0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=liD4/p6mdfJP/hVAE3v9i/ZKUgskDa5bNyS2mTtqy3X74o5vRUNaKvdgEgAgqsw0x
	 L+FhJK6+HuGILheLqAPJvGWrJdwKuLPhpujSoPMnm4iLb4esJ7XtmPZqwzpKkjZ605
	 W858gp0V8XjVC1EXMtkz7NeRcxr3RchyIgawjQSk=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 7DBA11286702;
	Mon, 20 Jan 2025 13:57:54 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id Uk3gH9umEJmW; Mon, 20 Jan 2025 13:57:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1737399474;
	bh=UzgRE03mDOrdWjy1kf/GZBCcOWxOtlWOojHoQ30Kdp0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=liD4/p6mdfJP/hVAE3v9i/ZKUgskDa5bNyS2mTtqy3X74o5vRUNaKvdgEgAgqsw0x
	 L+FhJK6+HuGILheLqAPJvGWrJdwKuLPhpujSoPMnm4iLb4esJ7XtmPZqwzpKkjZ605
	 W858gp0V8XjVC1EXMtkz7NeRcxr3RchyIgawjQSk=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::db7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B6608128650C;
	Mon, 20 Jan 2025 13:57:53 -0500 (EST)
Message-ID: <7217bfc596e48cf228bd63aec68e4b18c64524f5.camel@HansenPartnership.com>
Subject: Re: [PATCH v3 0/8] convert efivarfs to manage object data correctly
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org, Jeremy Kerr
	 <jk@ozlabs.org>, Christian Brauner <brauner@kernel.org>, Al Viro
	 <viro@zeniv.linux.org.uk>
Date: Mon, 20 Jan 2025 13:57:51 -0500
In-Reply-To: <CAMj1kXG1L_pYiXoy+OOFKko4r8NhsPX7qLXcwzMdTTHBS1Yibw@mail.gmail.com>
References: <20250119151214.23562-1-James.Bottomley@HansenPartnership.com>
	 <CAMj1kXEaWBaL2YtqFrEGD1i5tED8kjZGmc1G7bhTqwkHqTfHbg@mail.gmail.com>
	 <CAMj1kXG1L_pYiXoy+OOFKko4r8NhsPX7qLXcwzMdTTHBS1Yibw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Mon, 2025-01-20 at 17:31 +0100, Ard Biesheuvel wrote:
> On Sun, 19 Jan 2025 at 17:59, Ard Biesheuvel <ardb@kernel.org> wrote:
> > 
> > On Sun, 19 Jan 2025 at 16:12, James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > > 
> ...
> > 
> > Thanks James. I've queued up this version now, so we'll get some
> > coverage from the robots. I'll redo my own testing tomorrow, but
> > I'll
> > omit these changes from my initial PR to Linus. If we're confident
> > that things are sound, I'll send another PR during the second half
> > of
> > the merge window.
> 
> I'm hitting the failure cases below. The first one appears to hit the
> same 'Operation not permitted' condition on the write, the error
> message is just hidden by the /dev/null redirect.
> 
> I'm running the make command from a root shell. Using printf from the
> command line works happily so I suspect there is some issue with the
> concurrency and the subshells?

It could be that the file isn't opened until the subshell is spawned. 
I can probably use the pipe to wait for the subshell to start; I'll try
to code that up.

Regards,

James


