Return-Path: <linux-fsdevel+bounces-68745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A74C64D07
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 16:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E5F3B4E57C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 15:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1A23370FA;
	Mon, 17 Nov 2025 15:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYFQfp98"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6CD27F724;
	Mon, 17 Nov 2025 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763392316; cv=none; b=MTdIJ7RQnfbeU5ojGYRleb1EpGH1fVob/ELPyomd7WejQ9KhesIvzGwuPAqOiEK3TBU0WStQ5BPZTL49njaTRWIUNmT5prTCcpv9yHVIcawmg5caT5Rfyg7HXI3nmX5UG8C3ctJgbPkL3ssHDXnVmPnaj40H8ItJozE5QwpupYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763392316; c=relaxed/simple;
	bh=TwfGBepi2IUAU/4JFAvHJYTM1sRw3y0VTMA2H2PFuPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RoFe4gctnLOUMMyB4Jimv0yv8Un5NaEsFMlEsgJlL92PqFQmVsrPLSzj8SUNm23p4fezKlr+SkBgRHtm/nje6HQvCzcSu/EMPH8Eps00CLHW0o9+KqdzmQOG78S0lc6eLAsWqbUYYnd8/LVqDgqg5EBLWy1w9fboqXOimsoo174=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYFQfp98; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D213C113D0;
	Mon, 17 Nov 2025 15:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763392316;
	bh=TwfGBepi2IUAU/4JFAvHJYTM1sRw3y0VTMA2H2PFuPQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fYFQfp98q8CZPq2D3/1HwhNKfQ02GOU/p/lXsiGElTjPUzEmC11RUcdhfE0uh+LZe
	 hkTadqxNsT86x26pV78yE9cHtXOZohKJc0CnrhNLYiIZQceAFHoqFiPE78DidXhXLN
	 tFAKq7VHPXZt3xIHdv8rlwuvCmnXJCirwhXCPCvCDSY+GaHO9QVUWndBeMs4LtVKhB
	 vXQzJeyLQ5i7XRjJafFG+RpCQs24WSu+XrfAhKl64rdC/PRf63+PQQaFX6cPXenQKt
	 k5jwAq/pMGJUEEMPjo9TEaBxkVgMEBH/vcGjv4clAdluHxZE2X66gZlaSyNyJg/OV1
	 zEIIjPZilJmXA==
Message-ID: <9e617d7b-afd7-465b-b075-32b02257b90b@kernel.org>
Date: Mon, 17 Nov 2025 16:11:47 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] mm: introduce VM_MAYBE_GUARD and make visible in
 /proc/$pid/smaps
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Andrei Vagin <avagin@gmail.com>
References: <cover.1762531708.git.lorenzo.stoakes@oracle.com>
 <94d1e9c6c6dd8a4de1f2a8022ca92e2e320730ff.1762531708.git.lorenzo.stoakes@oracle.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <94d1e9c6c6dd8a4de1f2a8022ca92e2e320730ff.1762531708.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.11.25 17:11, Lorenzo Stoakes wrote:
> Currently, if a user needs to determine if guard regions are present in a
> range, they have to scan all VMAs (or have knowledge of which ones might
> have guard regions).
> 
> Since commit 8e2f2aeb8b48 ("fs/proc/task_mmu: add guard region bit to
> pagemap") and the related commit a516403787e0 ("fs/proc: extend the
> PAGEMAP_SCAN ioctl to report guard regions"), users can use either
> /proc/$pid/pagemap or the PAGEMAP_SCAN functionality to perform this
> operation at a virtual address level.
> 
> This is not ideal, and it gives no visibility at a /proc/$pid/smaps level
> that guard regions exist in ranges.
> 
> This patch remedies the situation by establishing a new VMA flag,
> VM_MAYBE_GUARD, to indicate that a VMA may contain guard regions (it is
> uncertain because we cannot reasonably determine whether a
> MADV_GUARD_REMOVE call has removed all of the guard regions in a VMA, and
> additionally VMAs may change across merge/split).
> 
> We utilise 0x800 for this flag which makes it available to 32-bit
> architectures also, a flag that was previously used by VM_DENYWRITE, which
> was removed in commit 8d0920bde5eb ("mm: remove VM_DENYWRITE") and hasn't
> bee reused yet.
> 
> We also update the smaps logic and documentation to identify these VMAs.
> 
> Another major use of this functionality is that we can use it to identify
> that we ought to copy page tables on fork.
> 
> We do not actually implement usage of this flag in mm/madvise.c yet as we
> need to allow some VMA flags to be applied atomically under mmap/VMA read
> lock in order to avoid the need to acquire a write lock for this purpose.
> 
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>   Documentation/filesystems/proc.rst | 5 +++--
>   fs/proc/task_mmu.c                 | 1 +
>   include/linux/mm.h                 | 3 +++
>   include/trace/events/mmflags.h     | 1 +
>   mm/memory.c                        | 4 ++++
>   tools/testing/vma/vma_internal.h   | 1 +
>   6 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 0b86a8022fa1..8256e857e2d7 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -553,7 +553,7 @@ otherwise.
>   kernel flags associated with the particular virtual memory area in two letter
>   encoded manner. The codes are the following:
>   
> -    ==    =======================================
> +    ==    =============================================================
>       rd    readable
>       wr    writeable
>       ex    executable
> @@ -591,7 +591,8 @@ encoded manner. The codes are the following:
>       sl    sealed
>       lf    lock on fault pages
>       dp    always lazily freeable mapping
> -    ==    =======================================
> +    gu    maybe contains guard regions (if not set, definitely doesn't)
> +    ==    =============================================================


In general LGTM, BUT in the context of this patch where the flag is 
never set, that's not entirely correct ;) It made sense after staring at 
patch #5.

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David

