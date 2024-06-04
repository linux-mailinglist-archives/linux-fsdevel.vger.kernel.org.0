Return-Path: <linux-fsdevel+bounces-20970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FC48FB8F2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 18:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71A431F215AC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 16:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A49D149E01;
	Tue,  4 Jun 2024 16:28:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C0314882F;
	Tue,  4 Jun 2024 16:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717518529; cv=none; b=bCxCFzdyqN/dL4l2+xvc2kQT9rhhKJRv9U14XPwCg3IaGye92PB0YWWSyP/Q2Vzxk0am46pTTNqSWMqrrG5MnGu8qv2PSYovI983j8GLYBx0o4M4BcCF7sgcopgYbgHjnV7KbLy2F2t2KMRpi0418lpNLKZ9TqwOfiTM93o4J0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717518529; c=relaxed/simple;
	bh=TX40eYpPBSoNfgjKiXXx9iO88CRFF2v2Ilo21ADay8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jkceXMH7MgWXG0RA6IlEriYE5JVBh+drRmCQfr59r37S+BIMiAx24vhl4K5MdNDFFwkxxIn5Sw5uHkmwTC3qLE31b9n5ACUlznOw11Uv/zgtNT4Rt5jAHbh+VnfefDwhNJ7vdZyeXJjDSddEvAcAamB8IYohNMsV2QL8mDCtUpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484C2C4AF09;
	Tue,  4 Jun 2024 16:28:44 +0000 (UTC)
Date: Tue, 4 Jun 2024 12:28:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Metin
 Kaya <metin.kaya@arm.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v5 2/2] sched/rt, dl: Convert functions to return bool
Message-ID: <20240604122842.40296fb1@gandalf.local.home>
In-Reply-To: <20240604144228.1356121-3-qyousef@layalina.io>
References: <20240604144228.1356121-1-qyousef@layalina.io>
	<20240604144228.1356121-3-qyousef@layalina.io>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Jun 2024 15:42:28 +0100
Qais Yousef <qyousef@layalina.io> wrote:

> {rt, realtime, dl}_{task, prio}() functions return value is actually
> a bool.  Convert their return type to reflect that.
> 
> Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Signed-off-by: Qais Yousef <qyousef@layalina.io>
> ---
>  include/linux/sched/deadline.h |  8 +++-----
>  include/linux/sched/rt.h       | 16 ++++++----------
>  2 files changed, 9 insertions(+), 15 deletions(-)

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

