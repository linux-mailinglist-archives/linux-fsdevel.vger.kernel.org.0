Return-Path: <linux-fsdevel+bounces-64794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4B3BF4057
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 01:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 92C0C4E7725
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 23:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE74330B2F;
	Mon, 20 Oct 2025 23:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="kvBttiBG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7860305051
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 23:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761002889; cv=none; b=GKqHApvBHDccCQolsTOnI5Q+g4L4RkUMhYEf3g7fJJRN+uu7UxviAHKyK06rrGPb2HrkFQkarcsy6tTOGSoLCQKgYUnfU6ohjkcyo2wSTNoXXGfLyk3U874vH8+y5UYGb0gYQiAec1wVnq6cJO3MXQEApGtEw7tMnxECsegBdSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761002889; c=relaxed/simple;
	bh=Uly8y7LNTNHGrlEvo4rtugYlowTHH7PHEgVQ8yFGVUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9kpW2IoCeh7+UmAlAyJv7QNZJPzOpvonRc6Bt7WX7C1si9ZWgxjWhMdq/u1nBEjZW+6tXlczZv7syF8cDGGxmRHredaaAYeSAT/8fkH0BMZfVxOUn3Usz2u0j5vpEuMjw/Hb+6cDDXzyGa94mBXk1LkxLXRAqYkDjxdtJ0Bw8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=kvBttiBG; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33bcf228ee4so3626789a91.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 16:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1761002887; x=1761607687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E5x+1UXqj8C++nudO2r6ht89eY6krRyEDQJSgyqLqDY=;
        b=kvBttiBG/eBrbVYn6jvlObFjAyrPfIQJDTpMnigGXmlzEUnkacea/fK8GW9VoB4Xn9
         QaXBT5Y1lt0Y0HnFz4aXjWotfY3BgakHtkctait8XHqKiZ0Th1KYfLYjRaK0DHgK7cyB
         5mc76PiEkEOaNd/otyD/21fVGgNPbTE/a1FBN3EoTS3R7L9z4tlplMpQEFbBAFfn/n8/
         wLVXc0SLe0C1svtem4Ne93RP7pZTK6YnAR9B/rpv0nIuILd8BA9qcD6yXvTLZOJvbzge
         wUGctzCT+bQizZmsK2hZr2HzKr2I1nUeC0enDoR+EOrP6+aGPc4XFs2FY6Lm6VlIK8ya
         5u+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761002887; x=1761607687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5x+1UXqj8C++nudO2r6ht89eY6krRyEDQJSgyqLqDY=;
        b=AvNrEDBQaOEVDWrbdNCN3YoQTYNwLMqQmp/LyllkPvBV5MNOQIk/rAJbYbKfEx0/K1
         3rSRfxkgZgw+qOnqwuatZT1RXIcDYzJaY4nmEtrdwQv4uBhnRGJ2SiJKyAC12WLJNHpy
         yKQl+NJKyVXEHueHCxDR7ShyCqZ84ulyUcLKhI0jwtdP6yDPdiRKNDZMPzXEyQnmaOWo
         TSsoWrMGEzeqznXZImXuTRiJLtTTG302yGWN9UHyKOvniDutBJlRNASNyZ/9hLeYpvJi
         hwBU+ya/pNp8Z984MpwSNdj0fCNGflDhdkFDlDNM92Oyue11yQx5kslNTGIckyvAtWux
         wkNw==
X-Forwarded-Encrypted: i=1; AJvYcCVoc/SVBikuCtTpuujcegKsWSrLYlUeh4HgzqmwdqdYCxJh7jNZl/b6cVXrkS9ekfdJXq4CxiyZTmHGYeXo@vger.kernel.org
X-Gm-Message-State: AOJu0YxAaR4xi39vkCEMeBCDRqDfNf4fchNfu4uBR6sioU47r6dclvbh
	VKce3EWZH6R1IkVYbgiOBBui6BC2B3TnLqiJr7xAgF0nCK9dKzD5Orq/OPRtXkRBNt0=
X-Gm-Gg: ASbGncuf5O5w891c7aLfGV8wq6Ni+c3aYErQhXIfDWJL0SP5ehtvNos04TjKmkcN0l9
	dKaygSdAiONayaFJ1Mj2nHXkIEAvE/XBLpW6me0WcF69hP79tFkq6M9mAvv9fSwIcuZO1Oxvwep
	0jf/Rvgj6aFmRR+zJ/VMG5htkrC/9sXbcpgS5Y4uu+UJcBvmL+r4jZTOWUT+2tVZ2RmJ7R3jwK+
	FytWk1TNoKvfEgOy9UY/E9k1vXjB5vXkuWEn/jmoqdBr2SQc9EjMO6mNEZ4tA8ndBZXQ744pyYc
	IUawSkODS9xxuZO/om8jcEu9VMkmCZnr3JAXyWq83COJ7n44nztj/rRw3GZQZ045lx0fYY+1eqB
	WKmJw+WJFp3GCFvC8biOEcvy4QONbdjIKCfUjF1v1pNEKuaXYHOMzyVHBl2O5B9tTNcyDPoAgrV
	ejksTzcOzhU+CfoV6k6DzGgp8XjPtpTzZsvM6moYFsB6pVWfcjQFWn9oA5s12PKw==
X-Google-Smtp-Source: AGHT+IHcdNH2fOOHB1cm0EXB4SOj6iMNk8Mq9qAcSjpJ0ejuGeU6N8u1EfzBX4tQCCgAhIt/5tgbDg==
X-Received: by 2002:a17:90b:510a:b0:33b:6e60:b846 with SMTP id 98e67ed59e1d1-33bcf87478dmr19465934a91.11.1761002886592;
        Mon, 20 Oct 2025 16:28:06 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33dff3f6c2esm192671a91.6.2025.10.20.16.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 16:28:05 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1vAzII-0000000HWu0-1ddK;
	Tue, 21 Oct 2025 10:28:02 +1100
Date: Tue, 21 Oct 2025 10:28:02 +1100
From: Dave Chinner <david@fromorbit.com>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kiryl Shutsemau <kas@kernel.org>
Subject: Re: [RFC, PATCH 0/2] Large folios vs. SIGBUS semantics
Message-ID: <aPbFgnW1ewPzpBGz@dread.disaster.area>
References: <20251020163054.1063646-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020163054.1063646-1-kirill@shutemov.name>

On Mon, Oct 20, 2025 at 05:30:52PM +0100, Kiryl Shutsemau wrote:
> From: Kiryl Shutsemau <kas@kernel.org>
> 
> I do NOT want the patches in this patchset to be applied. Instead, I
> would like to discuss the semantics of large folios versus SIGBUS.
> 
> ## Background
> 
> Accessing memory within a VMA, but beyond i_size rounded up to the next
> page size, is supposed to generate SIGBUS.
> 
> This definition is simple if all pages are PAGE_SIZE in size, but with
> large folios in the picture, it is no longer the case.
> 
> ## Problem
> 
> Darrick reported[1] an xfstests regression in v6.18-rc1. generic/749
> failed due to missing SIGBUS. This was caused by my recent changes that
> try to fault in the whole folio where possible:
> 
> 	19773df031bc ("mm/fault: try to map the entire file folio in finish_fault()")
> 	357b92761d94 ("mm/filemap: map entire large folio faultaround")
> 
> These changes did not consider i_size when setting up PTEs, leading to
> xfstest breakage.
> 
> However, the problem has been present in the kernel for a long time -
> since huge tmpfs was introduced in 2016. The kernel happily maps
> PMD-sized folios as PMD without checking i_size. And huge=always tmpfs
> allocates PMD-size folios on any writes.

The tmpfs huge=always specific behaviour is not how regular
filesystems have behaved. It is niche, special case functionality
that has weird behaviours and, as such, it most definitely does not
set the standards for how all other filesystems should behave.

> I considered this corner case when I implemented a large tmpfs, and my
> conclusion was that no one in their right mind should rely on receiving
> a SIGBUS signal when accessing beyond i_size. I cannot imagine how it
> could be useful for the workload.

Lacking the imagination or knowledge to understand why a behaviour
exists does not mean that behaviour is unnecessary or that it should
be removed. It just means you didn't ask the people who knew wy the
functionality exists...

> Generic/749 was introduced last year with reference to POSIX, but no
> real workloads were mentioned. It also acknowledged the tmpfs deviation
> from the test case.
> 
> POSIX indeed says[3]:
> 
> 	References within the address range starting at pa and
> 	continuing for len bytes to whole pages following the end of an
> 	object shall result in delivery of a SIGBUS signal.
> 
> Do we care about adhering strictly to this in absence of real workloads
> that relies on this semantics?

We've already told you that we do, because mapping beyond EOF has
implications for the impact on how much stale data exposure occur
when the next set of truncate/mmap() bugs are introduced.

> I think it valuable to allow kernel to map memory with a larger chunks
> -- whole folio -- to get TLB benefits (from both huge pages and TLB
> coalescing). I value TLB hit rate over POSIX wording.

Feel free to do that for tmpfs, but for persistent filesystems the
existing POSIX SIGBUS behaviour needs to remain.

> Any opinions?

There are solid historic reasons for the existing behaviour and for
keeping it unchanged.  You aren't allowed to handwave them away
because you don't understand or care about them.

In critical paths like truncate, correctness and safety come first.
Performance is only a secondary consideration.  The overlap of
mmap() and truncate() is an area where we have had many, many bugs
and, at minimum, the current POSIX behaviour largely shields us from
serious stale data exposure events when those bugs (inevitably)
occur.

Fundamentally, we really don't care about the mapping/tlb
performance of the PTE fragments at EOF. Anyone using files large
enough to notice the TLB overhead improvements from mapping large
folios is not going to notice that the EOF mapping has a slightly
higher TLB miss overhead than everywhere else in the file.

Please jsut fix the regression.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

