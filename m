Return-Path: <linux-fsdevel+bounces-39099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 665CBA0FDAC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 01:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CE711888F21
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 00:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCF735943;
	Tue, 14 Jan 2025 00:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XFA6X7cj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0841F92A;
	Tue, 14 Jan 2025 00:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736815612; cv=none; b=KWB56KqCkmUOfuIWoqno+HNjo8u/5CEL0G1mnxonactVxnOEgphMtlWRPr7AanNLwIYY4yA/cYUZO3bsrrPpT5WEyHyji/Va4q7q+o5gZxk3u8CYY0nL95dd794fZBY3Kkllab9APZQMBIzwXf9k/VszuKThnK/RqXcnozUkd5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736815612; c=relaxed/simple;
	bh=8mP726DmMF2Uh+5gqJGUOIXM5CKPS8V3Mr1N6BkduMY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PIKg3NU+NwFTjvtuO5Vih8WQsPzDCEjkkh55j7BDd5htQCysrsact7AuEv0AZ3qZutZvceIBc5ZucYBN3Lh6Zbe5pjgIY4xwsNYf7fzYyOPACFfw8QY7qBV4EjKaGT4qD8bFIDoEhvWk3aJp46JS4k5kcAI4WsHbm1CaFaohAeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XFA6X7cj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51BA6C4CED6;
	Tue, 14 Jan 2025 00:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1736815611;
	bh=8mP726DmMF2Uh+5gqJGUOIXM5CKPS8V3Mr1N6BkduMY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XFA6X7cj+a8EL9RqyrGXe09P/hPBMiA2lyZn2wbRqrxcZ3+S1vOc/458obqwi5dW5
	 IJSmMVVkpx19oq+Sjb/2eSbDqnVu1MBRZN7buw7ca29/Dg3xb7cg5nKQOv5i635KIo
	 gZLpqxtU2MFCX1gQViTddPV33fENyRgmYu8TQ8Xo=
Date: Mon, 13 Jan 2025 16:46:50 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
 clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org,
 kirill@shutemov.name, bfoster@redhat.com
Subject: Re: [PATCHSET v8 0/12] Uncached buffered IO
Message-Id: <20250113164650.5dfbc4f77c4b294bb004804c@linux-foundation.org>
In-Reply-To: <3cba2c9e-4136-4199-84a6-ddd6ad302875@kernel.dk>
References: <20241220154831.1086649-1-axboe@kernel.dk>
	<20250107193532.f8518eb71a469b023b6a9220@linux-foundation.org>
	<3cba2c9e-4136-4199-84a6-ddd6ad302875@kernel.dk>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jan 2025 08:34:18 -0700 Jens Axboe <axboe@kernel.dk> wrote:

> > 
>
> ...
>
> > Of course, we're doing something here which userspace could itself do:
> > drop the pagecache after reading it (with appropriate chunk sizing) and
> > for writes, sync the written area then invalidate it.  Possible
> > added benefits from using separate threads for this.
> > 
> > I suggest that diligence requires that we at least justify an in-kernel
> > approach at this time, please.
> 
> Conceptually yes. But you'd end up doing extra work to do it. Some of
> that not so expensive, like system calls, and others more so, like LRU
> manipulation. Outside of that, I do think it makes sense to expose as a
> generic thing, rather than require applications needing to kick
> writeback manually, reclaim manually, etc.
> 
> > And there's a possible middle-ground implementation where the kernel
> > itself kicks off threads to do the drop-behind just before the read or
> > write syscall returns, which will probably be simpler.  Can we please
> > describe why this also isn't acceptable?
> 
> That's more of an implementation detail. I didn't test anything like
> that, though we surely could. If it's better, there's no reason why it
> can't just be changed to do that. My gut tells me you want the task/CPU
> that just did the page cache additions to do the pruning to, that should
> be more efficient than having a kworker or similar do it.

Well, gut might be wrong ;)

There may be benefit in using different CPUs to perform the dropbehind,
rather than making the read() caller do this synchronously.

If I understand correctly, the write() dropbehind is performed at
interrupt (write completion) time so that's already async.

> > Also, it seems wrong for a read(RWF_DONTCACHE) to drop cache if it was
> > already present.  Because it was presumably present for a reason.  Does
> > this implementation already take care of this?  To make an application
> > which does read(/etc/passwd, RWF_DONTCACHE) less annoying?
> 
> The implementation doesn't drop pages that were already present, only
> pages that got created/added to the page cache for the operation. So
> that part should already work as you expect.
> 
> > Also, consuming a new page flag isn't a minor thing.  It would be nice
> > to see some justification around this, and some decription of how many
> > we have left.
> 
> For sure, though various discussions on this already occurred and Kirill
> posted patches for unifying some of this already. It's not something I
> wanted to tackle, as I think that should be left to people more familiar
> with the page/folio flags and they (sometimes odd) interactions.

Matthew & Kirill: are you OK with merging this as-is and then
revisiting the page-flag consumption at a later time?


