Return-Path: <linux-fsdevel+bounces-54754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF57B02A2A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 10:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F9CD7ADE3D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 08:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CA827381D;
	Sat, 12 Jul 2025 08:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="lEOiJPIl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7358B80B;
	Sat, 12 Jul 2025 08:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752310468; cv=none; b=TQ/d3HbNWqGNcdRNKTBm8KlEOhTIzs9teG4d05FQ7jTREVYJyKElIvarRetboaKsYBM0tmuf1cn5JkV+jG06ToIk5MLpmvhtQaHnEhP2dtVBuKv+9cJYUAhxL1A21A0L16oUUwZBMOhijgMxI+U1awmo5YSDJnf16joOCTulqns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752310468; c=relaxed/simple;
	bh=xZn+1tqQMBBxbYwmnsDfCKpNuwK9OnL2B8bBtLY/GFw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uJAXkFNr/e5wpUA6yF57SWuRhtaHXARj5hHBBzZHgqHXoi3BtF4d29qM3e4F4lfIyxDMxl/eVDPLkQ0agBfyG4fU0o0y9t+dsJK1EM384dvmFCXJVCdBUAhm0LA66qZcjxEDhMytZXpTGrIxWi9b/qfQfTob/XzHE1QdMqDFEQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=lEOiJPIl; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1752310465;
	bh=xZn+1tqQMBBxbYwmnsDfCKpNuwK9OnL2B8bBtLY/GFw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=lEOiJPIl0ArA3F/97OQLJ2ndtZaUoudYM4wrBy6zSX+cnbEBH0msvp4izLalGp3Mu
	 4rthZw8k72ioGJgS/CE94f2rWz5BxFOJrlXMxMreKOQ8TYzr1/gUw9DdcnqJtcukW+
	 VkERItt2GrKKNnaUPtw+zpYxvmjIjOtl10QABklc=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 8E34F65997;
	Sat, 12 Jul 2025 04:54:19 -0400 (EDT)
Message-ID: <984d89b10dca8e227b7b1a37e5a2fa2f8b260b9c.camel@xry111.site>
Subject: Re: [PATCH v3] eventpoll: Fix priority inversion problem
From: Xi Ruoyao <xry111@xry111.site>
To: linux-fsdevel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>, Christian Brauner <brauner@kernel.org>, 
 Frederic Weisbecker	 <frederic@kernel.org>, Valentin Schneider
 <vschneid@redhat.com>, Alexander Viro	 <viro@zeniv.linux.org.uk>, Jan Kara
 <jack@suse.cz>, Sebastian Andrzej Siewior	 <bigeasy@linutronix.de>, John
 Ogness <john.ogness@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, linux-rt-users@vger.kernel.org, Joe Damato	
 <jdamato@fastly.com>, Martin Karsten <mkarsten@uwaterloo.ca>, Jens Axboe	
 <axboe@kernel.dk>
Date: Sat, 12 Jul 2025 16:54:15 +0800
In-Reply-To: <20250712000934.DwvOk7Hk@linutronix.de>
References: <20250710062127.QnaeZ8c7@linutronix.de>
	 <d14bcceddd9f59a72ef54afced204815e9dd092e.camel@xry111.site>
	 <20250710083236.V8WA6EFF@linutronix.de>
	 <c720efb6a806e0ffa48e35d016e513943d15e7c0.camel@xry111.site>
	 <20250711050217.OMtx7Cz6@linutronix.de>
	 <20250711-ermangelung-darmentleerung-394cebde2708@brauner>
	 <6856a981f0505233726af0301a1fb1331acdce1c.camel@xry111.site>
	 <20250711095830.048P551B@linutronix.de>
	 <7a50fd8af9d21aade901fe4d32e14e698378c82f.camel@xry111.site>
	 <20250711122123.qXVK-EkF@linutronix.de>
	 <20250712000934.DwvOk7Hk@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-07-12 at 02:09 +0200, Nam Cao wrote:
> On Fri, Jul 11, 2025 at 08:09:12PM +0800, Xi Ruoyao wrote:
> > And I'm afraid this may be a bug in my userspace... Then I'd feel guilt=
y
> > if this is reverted because of an invalid bug report from I :(.
>=20
> FYI I just got a separate bug report. So something is definitely wrong wi=
th
> this patch.

FTR Linus has reverted this patch after encountering the same issue at
https://git.kernel.org/torvalds/c/5f02b80c21e1.

--=20
Xi Ruoyao <xry111@xry111.site>

