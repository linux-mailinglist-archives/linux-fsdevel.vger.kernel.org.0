Return-Path: <linux-fsdevel+bounces-54825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FFCB03A31
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 11:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B71F176A4A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 09:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABED623D29F;
	Mon, 14 Jul 2025 09:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBJu93Sw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F0123C50C;
	Mon, 14 Jul 2025 09:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752483607; cv=none; b=Bj4BXn66cfA1XpPAL3WQDgAQcNyEgqPB+v54D24dUit+R5onprgZ8XBMq5AJRToi/HOySNeF/FftZeWlowORt0hSZ0rif0bZQIvdPGwJgwLBbNArdCCday9YH3OyHEjHKfn8vkhXj+3dxksrYrYm+PoYHbakMlqW1ATbytZ4aJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752483607; c=relaxed/simple;
	bh=wubLM7oc7vyYccOjiNamFuoXLUMcbsRbuLS8tmqUYLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fX5hXvLN84EYY//wSehBn7JXD1LMe3ktiRLM8uMTozYa9+4Z1sjsl03qsdtorJScb5jj4nNLQfgOvbl8sR+3+VD6wv3X+JXGZnPWwoxfiVa8nnoL56KwXA4Odr2Taupeu0wTizs7M/G8fy2RySw30XcPyyvzk0FfhWcluEbm5ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBJu93Sw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2940C4CEED;
	Mon, 14 Jul 2025 09:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752483605;
	bh=wubLM7oc7vyYccOjiNamFuoXLUMcbsRbuLS8tmqUYLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SBJu93SwzHezEltZTZjnq8mJT/xYjJHioXFB9hCzJ6mxfAbKDzC24qPW4r96LYn/Q
	 B8C3FQMlFt9Xjd5wesqUXEhcVE2ySUwOtPCoHU5yFYTBTdKXL9+t2kCLm3hae9zWMf
	 vG3Y2VSG8e2lCZfCrFP1kscCMan0v+F8VQ5Mgb3Y0b4fervoqeZvrQPZSqAg92+NHc
	 kfJZ5+wUFnN7XlrFPrcDFxdUVyBjiouf7JBIMZmUh/lqlguE7ExBCn7Ensvm4DYtj/
	 JsJnztYC8RUKhStRbv5HdLY+k6WYz2hkNTD/dE1jo8y1BzWes6+RUaTNgXoJVWU6ch
	 Y/KEs7MU+/Cig==
Date: Mon, 14 Jul 2025 10:59:58 +0200
From: Christian Brauner <brauner@kernel.org>
To: Nam Cao <namcao@linutronix.de>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Xi Ruoyao <xry111@xry111.site>, 
	Frederic Weisbecker <frederic@kernel.org>, Valentin Schneider <vschneid@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	linux-rt-users@vger.kernel.org, Joe Damato <jdamato@fastly.com>, 
	Martin Karsten <mkarsten@uwaterloo.ca>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3] eventpoll: Fix priority inversion problem
Message-ID: <20250714-leumund-sinnen-44309048c53d@brauner>
References: <20250710034805.4FtG7AHC@linutronix.de>
 <20250710040607.GdzUE7A0@linutronix.de>
 <6f99476daa23858dc0536ca182038c8e80be53a2.camel@xry111.site>
 <20250710062127.QnaeZ8c7@linutronix.de>
 <d14bcceddd9f59a72ef54afced204815e9dd092e.camel@xry111.site>
 <20250710083236.V8WA6EFF@linutronix.de>
 <c720efb6a806e0ffa48e35d016e513943d15e7c0.camel@xry111.site>
 <20250711050217.OMtx7Cz6@linutronix.de>
 <20250711-ermangelung-darmentleerung-394cebde2708@brauner>
 <20250711095008.lBxtWQh6@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250711095008.lBxtWQh6@linutronix.de>

On Fri, Jul 11, 2025 at 11:50:08AM +0200, Nam Cao wrote:
> On Fri, Jul 11, 2025 at 11:44:28AM +0200, Christian Brauner wrote:
> > I think we should revert the fix so we have time to fix it properly
> > during v6.17+. This patch was a bit too adventurous for a fix in the
> > first place tbh.
> 
> Agreed. I did feel a bit uneasy when I saw the patch being applied to
> vfs.fixes.

I was on the fence myself and I juggled the commit between vfs.fixes and
vfs-6.17.misc because I wasn't sure whether we should consider such
priority inversion fix something that's urgent or not.

I tried to communicate to Linus that I was uncertain about this
particular patch at the beginning of

https://lore.kernel.org/20250704-vfs-fixes-fa31f5ff8c05@brauner

But I should've called it earlier.

Linus, thanks for reverting this! I had a revert ready as announced on
Friday for today but it's good that this got kicked out already.

My lesson from this is that touching epoll without a really really good
and urgent reason always end up a complete mess. So going forward we'll
just be very careful here.

