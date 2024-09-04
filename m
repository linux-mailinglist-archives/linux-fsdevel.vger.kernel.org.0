Return-Path: <linux-fsdevel+bounces-28566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9443296C19C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 17:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42051B2BFB3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 14:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9AC1DCB21;
	Wed,  4 Sep 2024 14:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1bcVT+4H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TB1lxhaE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8A91DCB09;
	Wed,  4 Sep 2024 14:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461744; cv=none; b=MeBEysVoWPdCN6eMA0FYegua56AlVf05Shks2FINOxrPQfcelfSjklK7MbcYZ4mLapZIAaXYqyVTnp9yXJcq/gRIVrVRkKqceWiLflIgq4Hm0VNiAzNUUsotGhGq9VTDPhjGYRP+cybxYPQBLdfvZfylaouCJVdtNpqzxFSk268=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461744; c=relaxed/simple;
	bh=/ct6R4FKRl9rp8LyD80S78FZeFGhueZNb1pn0YRorzA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WUiASvyEuNwuTBefrH1r9VRVqD7llNXjYhfKDAKeFGk85VPalm+yGRJMYxbxXQlFcLahpVy0AXJsML7rvTtj7cO0F7xkamsNvnCdcpgYcFfXHVEu+gX24LfDZj0Apnhw+rNW/RbPLDwvwwnGrAf3KHX0KCxWG72d/TtaEq3Lf1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1bcVT+4H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TB1lxhaE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725461740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/ct6R4FKRl9rp8LyD80S78FZeFGhueZNb1pn0YRorzA=;
	b=1bcVT+4HJL63HsuPKH/FmarU/HWxYtMlZZQgUUiMbq6yYAgFHw1CkdSnsa1WfshxsHtZXq
	rxQfgtbUhr9itRC1EHl02rqAoNT0TggbNzoL+x17Qv8tdfUiAivOkIYS9bzkrehq88h4Rm
	E4uLHluWplCoKjt1X0MZCTjEcy5Fa8JjPMZRE2Ay1hr84AFTk6RhgzRKnY55A2VJQXvVFH
	t30z3z1q3ka3lQ5/DyiCnsNLLwrKOGe5adUvfloe3/Qx34fQEtlFX9sXkHMThhHcfeD62X
	YcQPiREi6QMVvTQDVibf75yrAU3ks2mSwVTCauIDdwNUNCg5sm6FMfRkhrjh3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725461740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/ct6R4FKRl9rp8LyD80S78FZeFGhueZNb1pn0YRorzA=;
	b=TB1lxhaEhLcvQtbabjrZHMscg9WqcA14Nmzf0iixbYBZVkthPUPzdsocQbOjKHAkgAjdVo
	Iiwb9JzXTzRQLODA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, Jiri Slaby
 <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH printk v6 00/17] add threaded printing + the rest
In-Reply-To: <ZthvGoJE26dOtsLm@pathway.suse.cz>
References: <20240904120536.115780-1-john.ogness@linutronix.de>
 <ZthvGoJE26dOtsLm@pathway.suse.cz>
Date: Wed, 04 Sep 2024 17:01:40 +0206
Message-ID: <87ed5za2oj.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-09-04, Petr Mladek <pmladek@suse.com> wrote:
> JFYI, the patchset has been committed into printk/linux.git,
> branch rework/threaded-printk.

Thanks!

> I am not completely sure if we add this early enough for 6.12.
> On one hand, the patchset should not change the handling of legacy
> consoles and it does not add any nbcon console. But it touches
> many code paths where we decide how to flush the consoles
> and could imagine doing "ugly" mistakes there.
>
> OK, let's see how it works in linux-next in the following days.
> There is still time to catch problems and make the decision.

I just don't think there are many real users of linux-next. The code
leading to the 5.19 revert sat in linux-next for a long time and no one
noticed anything. It wasn't until the 5.19-rc's started coming out that
real testing (and bug reporting) occurred.

I think linux-next is great for the kernel robots to work their magic,
but I don't know if having something in linux-next for 6 weeks is any
better than only 2 weeks.

John

