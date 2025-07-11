Return-Path: <linux-fsdevel+bounces-54634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D07FB01B85
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 14:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00E664A7989
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 12:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CB6290BA2;
	Fri, 11 Jul 2025 12:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="NEvaFiRp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A871F4C8C;
	Fri, 11 Jul 2025 12:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752235776; cv=none; b=RtfO3a3/N2n6FZfyFNftQJdSzh5SyoSWI7G7H/uPu+kIF1frLd/qugti8vh6rKPVOqSNKUVGI/SP0AbQMxkFensNgWuQWJPMAG/sStkG0fxH1Q91kpj1amCKT+AOe5yYzTY0rSJZRHB2rbK9dIHQoPlRt605ljXeaFhlGKk6TPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752235776; c=relaxed/simple;
	bh=OH6igIH0VnLlQeaehu/2rr7T/sYdx6rQbMfXPqkOURw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gklSDP+ByZcFhN14MUN7sNGr2Y0xzpYY79ew6K+HRO9wdL2fnfG3Qa6/Fo0ucnPfQIWYAP3f5b66mLiD6kvO/PKxlSXjuyhsHagYKbv81etsBirFh9y4REujehmmA7Vy+sNun/TrlzQY3uLbchEVfQjx6XCFYJNhylfM6Y7N8s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=NEvaFiRp; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1752235771;
	bh=zLIhDjORDALPL1f9cxqC+vMuKXG/jVF8rfdI3FxxNNk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=NEvaFiRpEbrBCYqyx/55a4noUdEDJVZgX6jKZygUaSS9qBm0Rzs0AoKiD+FmAVBKn
	 tm8K2a5is6GtAJNXug/VnJHzDvo8CAuMk8Y6soNjIhlpphMwyPa96KKPZo3HrDkq3I
	 3rykmVxIqQNNSERNdJcQ1XD1YSfZ7bZJWfqmh/To=
Received: from [IPv6:110::1f] (unknown [IPv6:2409:874d:200:3037::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id B869C65F62;
	Fri, 11 Jul 2025 08:09:22 -0400 (EDT)
Message-ID: <7a50fd8af9d21aade901fe4d32e14e698378c82f.camel@xry111.site>
Subject: Re: [PATCH v3] eventpoll: Fix priority inversion problem
From: Xi Ruoyao <xry111@xry111.site>
To: Nam Cao <namcao@linutronix.de>
Cc: Christian Brauner <brauner@kernel.org>, Frederic Weisbecker	
 <frederic@kernel.org>, Valentin Schneider <vschneid@redhat.com>, Alexander
 Viro	 <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Sebastian Andrzej
 Siewior	 <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, 	linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-rt-devel@lists.linux.dev,
 linux-rt-users@vger.kernel.org, Joe Damato	 <jdamato@fastly.com>, Martin
 Karsten <mkarsten@uwaterloo.ca>, Jens Axboe	 <axboe@kernel.dk>
Date: Fri, 11 Jul 2025 20:09:12 +0800
In-Reply-To: <20250711095830.048P551B@linutronix.de>
References: <20250710034805.4FtG7AHC@linutronix.de>
	 <20250710040607.GdzUE7A0@linutronix.de>
	 <6f99476daa23858dc0536ca182038c8e80be53a2.camel@xry111.site>
	 <20250710062127.QnaeZ8c7@linutronix.de>
	 <d14bcceddd9f59a72ef54afced204815e9dd092e.camel@xry111.site>
	 <20250710083236.V8WA6EFF@linutronix.de>
	 <c720efb6a806e0ffa48e35d016e513943d15e7c0.camel@xry111.site>
	 <20250711050217.OMtx7Cz6@linutronix.de>
	 <20250711-ermangelung-darmentleerung-394cebde2708@brauner>
	 <6856a981f0505233726af0301a1fb1331acdce1c.camel@xry111.site>
	 <20250711095830.048P551B@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-07-11 at 11:58 +0200, Nam Cao wrote:
> On Fri, Jul 11, 2025 at 05:48:56PM +0800, Xi Ruoyao wrote:
> > Sadly, still no luck.
>=20
> That's unfortunate.
>=20
> I'm still unable to reproduce the issue, so all I can do is staring at th=
e
> code and guessing. But I'm out of idea for now.

Same as I.  I tried to reproduce in a VM running Fedora Rawhide but
failed.

> This one is going to be hard to figure out..

And I'm afraid this may be a bug in my userspace... Then I'd feel guilty
if this is reverted because of an invalid bug report from I :(.

--=20
Xi Ruoyao <xry111@xry111.site>

