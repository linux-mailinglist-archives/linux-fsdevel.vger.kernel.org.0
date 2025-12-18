Return-Path: <linux-fsdevel+bounces-71691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AABCCDAB7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 22:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0B3BE305AD85
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 21:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A368331A4E;
	Thu, 18 Dec 2025 21:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SEBytomn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A930A283FEF;
	Thu, 18 Dec 2025 21:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766092877; cv=none; b=k7Nr9Mpdl4KuNeWgPOt+LDvoFixf4Z6hk9J9ewR0mD98vOwB0CJkXgx9c7aObNmoh2A/kldK4YZ1zdERMVYmM85uvo/I8Lh0aAAIOaMn0FtjoOGAOMb0CYflX9D5sLecIyLATUOl8fsCWT8gA7HJ+LY4r5B/Ccx/uNx9CQGDZfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766092877; c=relaxed/simple;
	bh=2QxZ3eI3kgiomXWTwHaqixPIsDeJcNn8cyYTgWzVg/w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cuuWU0xDvH5nWRO2kWfNjAxoF0BKVT/ZC1FHGZ/C4lCb6+/qNoOmMLyH7BQshM1yAO/nU5b3w8G3xOd6BAzrYPyJOKQK+wPnlT1VzhGIXSn8NZ1LwSxYDF0TUMNtWUvju8DIqjVnyBbdPdeHrpSgGwSQpbP997ogL/Wwzl88U0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SEBytomn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98754C4CEFB;
	Thu, 18 Dec 2025 21:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1766092877;
	bh=2QxZ3eI3kgiomXWTwHaqixPIsDeJcNn8cyYTgWzVg/w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SEBytomnYuljvMejgFs8ipzlTDlgRK+8pBd15nJa0wmfn9W6MwFCxxsSVQHdgXsoO
	 zHuCld1a8EXWan1iysITOyAe28IwuwYNeTSNEjCc9J0DFsYqN1V596Tn2Fs7xrbjI6
	 +uE/ePcwfaOfzt0aTPVM1ztOnSKv8ju9xaX5rAGQ=
Date: Thu, 18 Dec 2025 13:21:16 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>, Andrii Nakryiko
 <andrii@kernel.org>, Shaurya Rane <ssrane_b23@ee.vjti.ac.in>,
 "Darrick J . Wong" <djwong@kernel.org>, Christoph Hellwig
 <hch@infradead.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Meta kernel team <kernel-team@meta.com>,
 bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 syzbot+09b7d050e4806540153d@syzkaller.appspotmail.com, Christoph Hellwig
 <hch@lst.de>
Subject: Re: [PATCH bpf v2] lib/buildid: use __kernel_read() for sleepable
 context
Message-Id: <20251218132116.c1edb3ee6688605bd270a666@linux-foundation.org>
In-Reply-To: <20251218205505.2415840-1-shakeel.butt@linux.dev>
References: <20251218205505.2415840-1-shakeel.butt@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Dec 2025 12:55:05 -0800 Shakeel Butt <shakeel.butt@linux.dev> wrote:

> For the sleepable context, convert freader to use __kernel_read()
> instead of direct page cache access via read_cache_folio(). This
> simplifies the faultable code path by using the standard kernel file
> reading interface which handles all the complexity of reading file data.
> 
> At the moment we are not changing the code for non-sleepable context
> which uses filemap_get_folio() and only succeeds if the target folios
> are already in memory and up-to-date. The reason is to keep the patch
> simple and easier to backport to stable kernels.
> 
> Syzbot repro does not crash the kernel anymore and the selftests run
> successfully.
> 
> In the follow up we will make __kernel_read() with IOCB_NOWAIT work for
> non-sleepable contexts. In addition, I would like to replace the
> secretmem check with a more generic approach and will add fstest for the
> buildid code.
> 
> Reported-by: syzbot+09b7d050e4806540153d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=09b7d050e4806540153d
> Fixes: ad41251c290d ("lib/buildid: implement sleepable build_id_parse() API")

v6.12.

> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Thanks, I'll add cc:stable to this due to "crashes the kernel".


