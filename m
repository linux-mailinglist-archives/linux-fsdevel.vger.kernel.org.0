Return-Path: <linux-fsdevel+bounces-57023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF02B1DF6A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 00:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BC2FA0090A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 22:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3653A229B2E;
	Thu,  7 Aug 2025 22:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="F9Yw2th/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821EF218E96;
	Thu,  7 Aug 2025 22:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754606767; cv=none; b=eqa28l1XvwpRmIk1cRY1fRRnrLvKQo8CD68kYMaeoYM60EEfXMQ5/yfKHbzTM3VTyrmefhH2wCyy0BNEjg4RBkBicAc5rQ4rr+03f0XZJ0ARcxnZ0V2B32oixIgr8n2VlyxC7AtDc0SbYSfeiELWZ2t3OWsryOfaku6WQHTa2CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754606767; c=relaxed/simple;
	bh=dKyb5nVhaIMQZ14/HklCnBFSa+CTSrgOq9B/byRkl3M=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=eM8FG4zUgcraWxAz1KdmG8MLInAVh1x2W7HNiwXmSJXhSwI3puuZi+dFayz58/5RjOlE/0btOEGITw1DJavvYMMpTbLzy7p9WmzrmePDFed06LvwnjBge1OCc9eChKvJyisYUbOxEwD2SHYXYXItawnujUjvxbYtYOTPy4QPocw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=F9Yw2th/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE7DC4CEEB;
	Thu,  7 Aug 2025 22:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1754606767;
	bh=dKyb5nVhaIMQZ14/HklCnBFSa+CTSrgOq9B/byRkl3M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F9Yw2th/LpLS6TV2pioJN3C1FJmUH13GR/GZBUMRuv/OT9vYcEZRgEVQ9Cz+uZBAB
	 L5ZCcJXhm8PYxtmEfnIzomnP6f7ThB8VMvkWstnYRs7dLeRRkTmJzzp02iOaKvmtLt
	 TdsSTAbaoC7X/fvE3U3nmlAlsbTAC3pcZhO/hk4s=
Date: Thu, 7 Aug 2025 15:46:06 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jialin Wang <wjl.linux@gmail.com>
Cc: Penglei Jiang <superman.xpt@gmail.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: proc_maps_open allow proc_mem_open to return NULL
Message-Id: <20250807154606.131d96b133c19baca0c5f2e6@linux-foundation.org>
In-Reply-To: <20250807165455.73656-1-wjl.linux@gmail.com>
References: <20250807165455.73656-1-wjl.linux@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  8 Aug 2025 00:54:55 +0800 Jialin Wang <wjl.linux@gmail.com> wrote:

> The commit 65c66047259f ("proc: fix the issue of proc_mem_open returning NULL")
> breaks `perf record -g -p PID` when profiling a kernel thread.
> 
> The strace of `perf record -g -p $(pgrep kswapd0)` shows:
> 
>   openat(AT_FDCWD, "/proc/65/task/65/maps", O_RDONLY) = -1 ESRCH (No such process)
> 
> This patch partially reverts the commit to fix it.

Thanks.  But "breaks" is a rather thin description of the problem!

Can you please describe the observed misbehavior fully?

> Fixes: 65c66047259f ("proc: fix the issue of proc_mem_open returning NULL")

Because we should backport this fix into 6.16.x -stable kernels.  The
-stable maintainers may wonder why we're requesting this.  Also, any
person who is having problems with their 6.16-based kernel will want
such a description so they can decide whether this fix might address
their problem.

Thanks.


