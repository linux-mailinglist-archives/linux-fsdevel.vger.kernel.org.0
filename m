Return-Path: <linux-fsdevel+bounces-68808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50651C66930
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 00:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id ACDE12450B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 23:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B010319862;
	Mon, 17 Nov 2025 23:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rcbPVM8T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9D02459E5
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 23:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763422988; cv=none; b=O1c9n4Lzvs3e/qa6MFcRAFZ2ONxCNI23FYMo+gjXvjZRTipMYvxt0qhvD0LvgVVV8Ao50Y4P9XXpujGvUzMmo2AgtBY0yLxudxGgm1ibncbOJaWsrymTMXLYxns4WIugqsTKMX5dgw0alpNCWShgzAZGr5pZRAzAvkfQCaNCJIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763422988; c=relaxed/simple;
	bh=dL2LiF1FldEZ/KOYQf5dYKmrAGWobpV3y8hV3ZgMVqE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pxGWI8WN7sKrwT+lpjkZ/+Lt6N/Ex+EfgwX8BGKaSA9nGux3NM+xD31TvbXn2B7Q51eY0mr+7bm/s+gJEQKO3SCgfUU3i7v2qMpch6DzT3PscK313YxO17o7zFK2IxMneeCvNHwQePOd3e47oWLhm5SvD3rqRT2Iswr4YqxeOXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rcbPVM8T; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-297f8a2ba9eso130330385ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 15:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763422985; x=1764027785; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dL2LiF1FldEZ/KOYQf5dYKmrAGWobpV3y8hV3ZgMVqE=;
        b=rcbPVM8TnVfERGvsvSmP7961dYkn9YkidetAXAAKkfgeCWpf1NMpwK/foi3ueUvYcf
         scVXNhyVsUeOYJar3TfVxhYgp9xISLmUAlGAwOSdFZMDynJCt/fjjbI0yh3BTKwzWlDk
         gkv0pQZ/nHN+vn1W1LHqcn3VTSD0gIYzoR7+admWaeuP9Qcqo8t3KlXGKVfFnE3KXPfc
         AXyihUSB8/fEqtXX1SJ8KdzlqNbp9gu1m3aoxk27uLKmFifa4L7DEa1RleeHwPiOtl54
         leWeQ2p0rSPU+lbmY78qwjvp6aY/1RTtPZC5a6whmO5vEjtRsExvY215ixGK40FPTpkh
         a2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763422985; x=1764027785;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dL2LiF1FldEZ/KOYQf5dYKmrAGWobpV3y8hV3ZgMVqE=;
        b=GER3O0/N4PA1h7DzxAabILr7UwaVOVVSAuCYNgp3sdHHRD4KZvbQ0tklMuo9UL9m7i
         mAmDfSs03qKor7c9MOSdk7urzWp/FGYVuk3uSHkcbro+A8oglPNCSdnGd59kdW8pGxOX
         n2OfYv6UL5bG57AeEqOF2DpWnb1fIaaXzZwy/8uDdqI8ubq614ZnvfV7HKk+qbBoYm03
         KwYRfWqBSCrpSYw4itANAY8bFEQbIgvU2jczdOsFhKxR41guJdDqXXXAWlk+gdK0VSuq
         n/nIjD5I6MNUJJqo0xXjJyL30kJulVsyJBjhWJGdgZfRl5hJw0SMT+1xx0ii22MkLoYO
         QaVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXac4fmmOEoyHdkpRW+EqYqfnasgwgMrJm5zMy8qhw1UPYBhvHsY5XwRHLjFXopL/obNWOCsX4/uNWmglBW@vger.kernel.org
X-Gm-Message-State: AOJu0YyLQYxwi4fAkBiQv4f7G++TsToQKRQa3KnjZmsYV4KRX1+xKhLi
	5QDWZOX/KTKnj+VbDKthYB3NWijQwAizM3XU238ZyQAmsHwsDa8EbjwpBDinag+rAjGiVXRv8Jf
	x/OFz5Fpi4oAq3BJLj6vPnL3GpA==
X-Google-Smtp-Source: AGHT+IHWpz1bcVZOmz2II2H4ZeDGXr1yKcY8vxUhe1flIg0qA+8VT3coJzci/8Ii6V7iaVk1iTvEUQ+0iPC050VUeQ==
X-Received: from plbkq4.prod.google.com ([2002:a17:903:2844:b0:295:41b0:5445])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:db0e:b0:297:c272:80ec with SMTP id d9443c01a7336-2986a741bbbmr167625985ad.42.1763422984901;
 Mon, 17 Nov 2025 15:43:04 -0800 (PST)
Date: Mon, 17 Nov 2025 15:43:03 -0800
In-Reply-To: <aRuuRGxw2vuXcVv6@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251117224701.1279139-1-ackerleytng@google.com> <aRuuRGxw2vuXcVv6@casper.infradead.org>
Message-ID: <diqztsysb4zc.fsf@google.com>
Subject: Re: [RFC PATCH 0/4] Extend xas_split* to support splitting
 arbitrarily large entries
From: Ackerley Tng <ackerleytng@google.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, david@redhat.com, 
	michael.roth@amd.com, vannapurve@google.com
Content-Type: text/plain; charset="UTF-8"

Matthew Wilcox <willy@infradead.org> writes:

> On Mon, Nov 17, 2025 at 02:46:57PM -0800, Ackerley Tng wrote:
>> guest_memfd is planning to store huge pages in the filemap, and
>> guest_memfd's use of huge pages involves splitting of huge pages into
>> individual pages. Splitting of huge pages also involves splitting of
>> the filemap entries for the pages being split.

>
> Hm, I'm not most concerned about the number of nodes you're allocating.

Thanks for reminding me, I left this out of the original message.

Splitting the xarray entry for a 1G folio (in a shift-18 node for
order=18 on x86), assuming XA_CHUNK_SHIFT is 6, would involve

+ shift-18 node (the original node will be reused - no new allocations)
+ shift-12 node: 1 node allocated
+ shift-6 node : 64 nodes allocated
+ shift-0 node : 64 * 64 = 4096 nodes allocated

This brings the total number of allocated nodes to 4161 nodes. struct
xa_node is 576 bytes, so that's 2396736 bytes or 2.28 MB, so splitting a
1G folio to 4K pages costs ~2.5 MB just in filemap (XArray) entry
splitting. The other large memory cost would be from undoing HVO for the
HugeTLB folio.

> I'm most concerned that, once we have memdescs, splitting a 1GB page
> into 512 * 512 4kB pages is going to involve allocating about 20MB
> of memory (80 bytes * 512 * 512).

I definitely need to catch up on memdescs. What's the best place for me
to learn/get an overview of how memdescs will describe memory/replace
struct folios?

I think there might be a better way to solve the original problem of
usage tracking with memdesc support, but this was intended to make
progress before memdescs.

> Is this necessary to do all at once?

The plan for guest_memfd was to first split from 1G to 4K, then optimize
on that by splitting in stages, from 1G to 2M as much as possible, then
to 4K only for the page ranges that the guest shared with the host.


