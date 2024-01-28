Return-Path: <linux-fsdevel+bounces-9268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4902183FA56
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 23:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C2D6281148
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 22:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A1D3C684;
	Sun, 28 Jan 2024 22:26:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EC63C47B;
	Sun, 28 Jan 2024 22:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706480813; cv=none; b=Ns+9Mz6Cb2rlPNFkC4NoHh/xJCu9Rs8/Fwqflryy5FVtC43bLvSS7c7x56HKYHdsaHXbbEbT9HuS4RtLmx83L4xpKViIlOZXdHQY2JM+tWGz0F2f8zqvMXINhy3+x8RNnCxLdvi635wR4SDr8haCeaaGp0YZbnX7Hv+xtM94JJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706480813; c=relaxed/simple;
	bh=zZJBRLbn08IT5qVFOnNExQyusK/CxFFEjTB/T5ZB19g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lPROn1TaVSk+2HGsS/zCiefNGeRabRhvx3RLkdNcn2idBxE0Dx2GTNc9ab2ismFaSxVylHmHxPZbQqCcRyM3qO/c8c9jg7dYR2kG3JSMiPyCd8U2kKvnWa9Q7soQlqwRj1+skSGAmu5YIbdGvWsJiofmzOU/YCPgVQK0b2kWNqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E3FC433F1;
	Sun, 28 Jan 2024 22:26:51 +0000 (UTC)
Date: Sun, 28 Jan 2024 17:26:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Christian Brauner
 <brauner@kernel.org>, Ajay Kaher <ajay.kaher@broadcom.com>, Geert
 Uytterhoeven <geert@linux-m68k.org>, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
Message-ID: <20240128172650.6dbf402d@rorschach.local.home>
In-Reply-To: <CAHk-=wg0bfqL9Yn-KnamLTvTpw+zbAa=og_JRPjZHgJ5m9iCZA@mail.gmail.com>
References: <20240126150209.367ff402@gandalf.local.home>
	<CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
	<20240126162626.31d90da9@gandalf.local.home>
	<CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
	<CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
	<CAHk-=wj+DsZZ=2iTUkJ-Nojs9fjYMvPs1NuoM3yK7aTDtJfPYQ@mail.gmail.com>
	<20240128151542.6efa2118@rorschach.local.home>
	<CAHk-=whKJ6dzQJX27gvL4Xug5bFRKW7_Cx4XpngMKmWxOtb+Qg@mail.gmail.com>
	<CAHk-=wiWo9Ern_MKkWJ-6MEh6fUtBtwU3avQRm=N51VsHevzQg@mail.gmail.com>
	<20240128170125.7d51aa8f@rorschach.local.home>
	<CAHk-=wg0bfqL9Yn-KnamLTvTpw+zbAa=og_JRPjZHgJ5m9iCZA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Jan 2024 14:17:43 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> You seem to have used SRCU as a "I don't want to do refcounts" thing.
> I bet you'll notice that it clarifies things *enormously* to just use
> refcounts.

Well, removing creating dentries in the readdir() logic is what opened
up the door to a lot of simplification. Thanks for helping me with that.
As I believe that may have been the source of most of the deadlocks we
were struggling with.

But yeah, kref probably could have fixed that too.

-- Steve

