Return-Path: <linux-fsdevel+bounces-38627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19005A0519A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 04:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB6F0188A200
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 03:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6005519D884;
	Wed,  8 Jan 2025 03:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aHtvWA/2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83615225D7;
	Wed,  8 Jan 2025 03:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736307333; cv=none; b=CHGZLCPyIlBFIsDaP6QQf0Op8+c/5VyzQjwe9xaWOsFnM9B28opRk8a0IWpN0m6GPPpBnJKrn5bHBTYVf3MgHU2G8wKgn2DM2iv11mlN6Le/vNmUZdJyDrCBw/Js+ek5PkDbP5QxI0c60nxV56oID68VjThiBilwBHpHU6ZBu6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736307333; c=relaxed/simple;
	bh=sQAX/iqTnOw6UTmjfw9UedjzVrSYr4SYKc+Q9qOwxpQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=r/csVDH37ffgih73fm8pu88SQfouC1XQdv55GXHfNqYKUl4pGWkmbgrDQdVCcPimsokbbm1+NdVCdQCIxQRNVTu6Fz7JsMOmmSLShBIV4VLYJqJmw/P0LvKtX1besgvL1ZGaXXP1dRgaYwbs3ycp0eUItYCOPrIBuPpQlo1eW6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aHtvWA/2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7BF0C4CED0;
	Wed,  8 Jan 2025 03:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1736307333;
	bh=sQAX/iqTnOw6UTmjfw9UedjzVrSYr4SYKc+Q9qOwxpQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aHtvWA/2Te0L5DBjFwURMWyTb0dSEVJLliE7pNi73K/Ju/hz3WhqLhRGulkwoCgy4
	 Vrp9VScfP/Ry42p2FFbE1zoagysnj+14Qf+33OO9tO4rCudYzP5Hl75v599tT35vkX
	 GR4a1LWBMnQ3KkCdeZMv0QwvPQlLWWPyJ+iw+hGw=
Date: Tue, 7 Jan 2025 19:35:32 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
 clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org,
 kirill@shutemov.name, bfoster@redhat.com
Subject: Re: [PATCHSET v8 0/12] Uncached buffered IO
Message-Id: <20250107193532.f8518eb71a469b023b6a9220@linux-foundation.org>
In-Reply-To: <20241220154831.1086649-1-axboe@kernel.dk>
References: <20241220154831.1086649-1-axboe@kernel.dk>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Dec 2024 08:47:38 -0700 Jens Axboe <axboe@kernel.dk> wrote:

> So here's a new approach to the same concent, but using the page cache
> as synchronization. Due to excessive bike shedding on the naming, this
> is now named RWF_DONTCACHE, and is less special in that it's just page
> cache IO, except it prunes the ranges once IO is completed.
> 
> Why do this, you may ask? The tldr is that device speeds are only
> getting faster, while reclaim is not. Doing normal buffered IO can be
> very unpredictable, and suck up a lot of resources on the reclaim side.
> This leads people to use O_DIRECT as a work-around, which has its own
> set of restrictions in terms of size, offset, and length of IO. It's
> also inherently synchronous, and now you need async IO as well. While
> the latter isn't necessarily a big problem as we have good options
> available there, it also should not be a requirement when all you want
> to do is read or write some data without caching.

Of course, we're doing something here which userspace could itself do:
drop the pagecache after reading it (with appropriate chunk sizing) and
for writes, sync the written area then invalidate it.  Possible
added benefits from using separate threads for this.

I suggest that diligence requires that we at least justify an in-kernel
approach at this time, please.

And there's a possible middle-ground implementation where the kernel
itself kicks off threads to do the drop-behind just before the read or
write syscall returns, which will probably be simpler.  Can we please
describe why this also isn't acceptable?


Also, it seems wrong for a read(RWF_DONTCACHE) to drop cache if it was
already present.  Because it was presumably present for a reason.  Does
this implementation already take care of this?  To make an application
which does read(/etc/passwd, RWF_DONTCACHE) less annoying?


Also, consuming a new page flag isn't a minor thing.  It would be nice
to see some justification around this, and some decription of how many
we have left.

