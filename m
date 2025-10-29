Return-Path: <linux-fsdevel+bounces-66196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38998C191C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 09:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC9A21AA1AB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 08:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9512631DD86;
	Wed, 29 Oct 2025 08:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jK1XeKd/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B955316194
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 08:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761726729; cv=none; b=eTjAZS3KocC/kKzDXFgnPz4iXjnepXkIhOwv/D65XaYf/0C3KckSv1KY0+Do6Pqx+nsk5fdCKg1p7twcGnp24KzVvw7B5l9Ug5xB4Ftt7fwUHOmnx71t26AsA4Wqnc4ZiryN0eTr5lz5vh1rljHbCYm9svXdfFHGy1R1r4TiSjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761726729; c=relaxed/simple;
	bh=GVdRbX+vh3f/FX0Xwtw4rWEoQgE8vYYkTKmeR3SKQYQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Z8bP0TuJ2s+oRJBst4ZXprCeFbT2n9MoeUWYKiKSzY7XH2fMcxdtlatnKLUNhgbGQHj3LdGDX6Tvbr4JsJR3oEWMZV0+jCb/ClryZuL98eZd6BH1/wD5ec0uILY/iMnmJc/VjMwb5dImp/uTtt9rle5qfXj5pD1gDuE1voHmYzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jK1XeKd/; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-78617e96ae1so21086437b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 01:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761726726; x=1762331526; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j/EgblGubgbnW5Hgy0d7e6d/LE+Ic8+V16TSffZZqhU=;
        b=jK1XeKd/KpuoctD4dR+V/FPl/uAU0Jy7cmLFN+CdPbMut3j6r0g0KdTTTGv683jX4T
         /eOgo6W4A11tZoxaitbwM9xMHYqmT6UW1SSY0XWfh6WHA2wzHG5j0AhauN1CcEZqrs4d
         acKj+SnWZCyvtPEOcls1X7newpYKgpC3H80b4P7T1S0s/sJiosQWi5Cj4sVikHVOalZz
         rYr8lloEAuUOxIW9cMIALi/JKZu/9MUyChb7T+q/LjJK2OEtcP7w04u/amx/e5w/hwZ2
         7Vk9aiSuPD0NWPntKZeD+WE6P3R51mPEE/JquSEEky0Ar5cLv8vkvghzQQWaB7jXQiZP
         AWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761726726; x=1762331526;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j/EgblGubgbnW5Hgy0d7e6d/LE+Ic8+V16TSffZZqhU=;
        b=fpgCFS7vj39BA0+dFAi4dHpcAC3zxdBMk5XEO4x+N3ywTjFvy4FQvw6mg7ZCWdSTZ3
         0IbCcKM6XLqLBEoL65s/yGzttv4ZuXA/69BLIKtuJRHzwKYQcKBPsFjDOXlghX1y3fXB
         iH5lryZ6iQDf73zp+PQLgSkl8s+SzwTrXHxQGoXkyOzYc1U1CsWmjb+SO8MSlwjgGhRW
         Z5Arkxkt4O8coLQC46aVs1fIBqs6p4ieG/IQJoSXwedY+7o4jxxJoqprs5D1bFpJOApM
         i2TwMeNB20RaWuCjxCbTkXUEFn4z6G9slDFcS5S/XV2h0pYJ/sArBu0dYbZW/LZLchBR
         a18A==
X-Forwarded-Encrypted: i=1; AJvYcCUTlCDiCUvbqd+PZfxXZt54qHs5dSQEj4LocVNXJDyNqDvj2AK8GknInclEQM/igKP8vB3AKHfynG73yHMR@vger.kernel.org
X-Gm-Message-State: AOJu0YwOPJHiuDzbZx6WLzQNezXKlsPtURvuXx4h2qtxCnwQEB5ZiKn/
	EtP/LLsok74QLHgYtZ44/NoXd3DGm5x7KQp1u7UDUqZw+IsjZfpEUvZ57U1LnA/HdA==
X-Gm-Gg: ASbGncvZW+iabc2qSu5nyjzg7BSZgXEPQdSGYKK9C7YzvHYjuVvKjEn07H8O/4J0yxP
	+8pmb4TKDJqLD0W3qxifpMkumDu4ugnfONpySESArV4taZbVeKNx07p+f7bfcASA6TUfvKbma2e
	+auJPqbCmJO958ZLfmhgJr4/lBFNz36VsmXtgE/nscJodZA7kJHyusJWukLOJA7eRvk8zGU6iDm
	+F404euNEm6wT9iGTAQtaE71Jz+LVHEFwSgf+mYxcmNkd7Muok0UqEWugCxzwYKCEb62f+BeoMr
	RXa6Jb3YLu4lncZTRz8dOAFDVyn5pVyheZLEKIShlowMs+xx6bFpLTgIzVfib9PFjBroVgGCA2+
	lwb9G+og0fBICXjZG5L1txojhL8hhXuZcoKLkFtLZ+OwUEuP1f0aWZy+LhQF0hsLtNzbcg7S6IO
	5BxN/qdpPMWT490K8nEU2xyfu4kRPGOio5bHluwA6P+RE2vV1gl1Uk96dPp2KNwwN9MAFfmVY=
X-Google-Smtp-Source: AGHT+IFVcmXHrgxMeuEDR2XWr4vAoODDTaHWS/nA8ziQ2WO9nTasjsDjFaROIorfvY19NOZaSKeT+Q==
X-Received: by 2002:a05:690c:6f12:b0:785:caab:e660 with SMTP id 00721157ae682-78628e81678mr18542897b3.26.1761726725736;
        Wed, 29 Oct 2025 01:32:05 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785ed13e443sm33974877b3.8.2025.10.29.01.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:32:03 -0700 (PDT)
Date: Wed, 29 Oct 2025 01:31:45 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: David Hildenbrand <david@redhat.com>
cc: Hugh Dickins <hughd@google.com>, Kiryl Shutsemau <kirill@shutemov.name>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Matthew Wilcox <willy@infradead.org>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, 
    Christian Brauner <brauner@kernel.org>, 
    Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
    "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
    Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
    Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
    Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>, 
    Johannes Weiner <hannes@cmpxchg.org>, 
    Shakeel Butt <shakeel.butt@linux.dev>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    "Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>, 
    linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Kiryl Shutsemau <kas@kernel.org>
Subject: Re: [PATCHv2 1/2] mm/memory: Do not populate page table entries
 beyond i_size
In-Reply-To: <8fc01e1d-11b4-4f92-be43-ea21a06fcef1@redhat.com>
Message-ID: <9646894c-01ef-90b9-0c55-4bdfe3aabffd@google.com>
References: <20251023093251.54146-1-kirill@shutemov.name> <20251023093251.54146-2-kirill@shutemov.name> <96102837-402d-c671-1b29-527f2b5361bf@google.com> <8fc01e1d-11b4-4f92-be43-ea21a06fcef1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 27 Oct 2025, David Hildenbrand wrote:
...
> 
> Just so we are on the same page: this is not about which folio sizes we
> allocate (like what Baolin fixed) but what/how much to map.
> 
> I guess this patch here would imply the following changes
> 
> 1) A file with a size that is not PMD aligned will have the last (unaligned
> part) not mapped by PMDs.
> 
> 2) Once growing a file, the previously-last-part would not be mapped by PMDs.

Yes, the v2 patch was so, and the v3 patch fixes it.

khugepaged might have fixed it up later on, I suppose.

Hmm, does hpage_collapse_scan_file() or collapse_pte_mapped_thp()
want a modification, to prevent reinserting a PMD after a failed
non-shmem truncation folio_split?  And collapse_file() after a
successful non-shmem truncation folio_split?

Conversely, shouldn't MADV_COLLAPSE be happy to give you a PMD
if the map size permits, even when spanning EOF?

> 
> Of course, we would have only mapped the last part of the file by PMDs if the
> VMA would have been large enough in the first place. I'm curious, is that
> something that is commonly done by applications with shmem files (map beyond
> eof)?

Setting aside the very common case of mapping a fraction of PAGE_SIZE
beyond EOF...

I do not know whether it's common to map a >= PAGE_SIZE fraction of
HPAGE_PMD_SIZE beyond EOF, but it has often been sensible to do so.
For example, imagine (using x86_64 numbers) a 4MiB map of a 3MiB
file on huge tmpfs, requiring two TLB entries for the whole file.

Hugh

