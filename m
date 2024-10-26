Return-Path: <linux-fsdevel+bounces-32995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 767579B13A7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 02:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C520C285B2D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 00:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEB61E517;
	Sat, 26 Oct 2024 00:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Kb5TwCTD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E44D1C683;
	Sat, 26 Oct 2024 00:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729900943; cv=none; b=K80ro9v1HXYmSwrUoXSR/zTHJ/sM7MkYDbp4D6V/4qlf6+WYt/+U3VubTAq7utQrx9EULFVQmccVTdCcLpp9/gRU+cx1ncWupM6qRF4n5orU94LIs1J8q5dz/hLY4dHRizknBRennREJCuczsqJWCBHqbp6M6KinwAKn6fYgF18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729900943; c=relaxed/simple;
	bh=eQC8+qyIPuZcG2f2PrF7J3/WkI+7xK2EbmNvEPw+M3k=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=F6Sd9npAPb6N57yK4w4zSeUWPp9W9nxMZMpcZj6OUqfedwcqbYwXd4+eTPFU7WJbBABMtVzaHHhMesjp+uEFh40gQ7EeC3Cxylva8gwcddC1jwpHYDjlmBMFcDvaRzc64E7BL8oDz5qVKzVmxNEpTn++kkyFdrLErk5MXhdYhMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Kb5TwCTD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D78C4CEC3;
	Sat, 26 Oct 2024 00:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1729900942;
	bh=eQC8+qyIPuZcG2f2PrF7J3/WkI+7xK2EbmNvEPw+M3k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Kb5TwCTDykxh+F0BV/zgxvFh9tyji0+FhmpBbQtL7rFewAWc7VOBkdTfx6f1aAJz9
	 /Y2iSzjuQL2djCeSnUjpGmVn6UXcLuYThCrQZ/FZK6/VmIgurIJ1EvTp3LLc8O3J8s
	 VyJEr5d3wXzvcqDd8pzf2Vwi1gPU6nT6xnXRzujI=
Date: Fri, 25 Oct 2024 17:02:22 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jim Zhao <jimzhao.ai@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, willy@infradead.org
Subject: Re: [PATCH] mm/page-writeback: Raise wb_thresh to prevent write
 blocking with strictlimit
Message-Id: <20241025170222.0ced663e778935946ea1c9fa@linux-foundation.org>
In-Reply-To: <20241024072919.468589-1-jimzhao.ai@gmail.com>
References: <20241023232042.f9373f9f826ceae2a4f4da35@linux-foundation.org>
	<20241024072919.468589-1-jimzhao.ai@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 15:29:19 +0800 Jim Zhao <jimzhao.ai@gmail.com> wrote:

> > > 2. FUSE with Unstable Network Backends and Occasional Writes
> > > Not easy to reproduce, but when it occurs in this scenario, 
> > > it causes the write thread to experience more pauses and longer durations.
> 
> > Thanks, but it's still unclear how this impacts our users.  How lenghty
> > are these pauses?
> 
> The length is related to device writeback bandwidth.
> Under normal bandwidth, each pause may last around 4ms in several times as shown in the trace above(5 times).
> In extreme cases, fuse with unstable network backends,
> if pauses occur frequently and bandwidth is low, each pause can exceed 10ms, the total duration of pauses can accumulate to second.

Thanks.  I'll assume that the userspace impact isn't serious to warrant
a backport into -stable kernel.

If you disagree with this, please let me know and send along additional
changelog text which helps others understand why we think our users
will significantly benefit from this change.


