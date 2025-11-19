Return-Path: <linux-fsdevel+bounces-69062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 43499C6DB5F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 10:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D1C424F8B68
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 09:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE50433C18A;
	Wed, 19 Nov 2025 09:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1eviRHi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2BA33893E;
	Wed, 19 Nov 2025 09:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763543845; cv=none; b=lyFa9zlryHe7vuKYhkpkllMXAfdVY6nua77gOR1TNlLOoJ0nelsgWXBuHKPMjN+T6raksrPK0Hommmxl+mc8QM4ltLv/pXWmhiU9+SOBFDssdohGmQvne+gMiMfszCb6I5NVvlBeFZRjLJVvjVuU2WZTicm/fIUBUoEvxckn5Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763543845; c=relaxed/simple;
	bh=+ffPga0iEGIkgs/2Wyne8l2+b7HCliT4lHlAANtUKP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O4HhF8IQ9CsEvKKzYBazzvkoCRLVNvaTZRBv5ZZAJFSGa9hy6ZUBWrCLlPGo9q5buT2lPH3rXrBUwW99EbIL1g5bihcE4a17XDTZnqMgRZJIpOj/hR0ZKmMB5j4XeBOv8ek1akBNFVamUcTkOSLSJVadMCmtqKjl05bG6G0/QMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1eviRHi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72CC8C113D0;
	Wed, 19 Nov 2025 09:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763543844;
	bh=+ffPga0iEGIkgs/2Wyne8l2+b7HCliT4lHlAANtUKP0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r1eviRHifDhzFR62Rl4Hl0Fldbxi2i1iUnRJ7++2aGuq32uA+sAcMmBxT7j5wcxja
	 Dr3ZCuEdjdi8uHutObrIAwF0D3hmur8+G1xnxQFbAKkLNL4iYe27x5IIXBJBjwF3Xn
	 rMjfwIIGVLgiU6ulekobGpCWlb6zkHltfsa8SzERy2qg6tWRTjshCJLTGPZ6wuTwwQ
	 OCQ9I8WFX1h1b3KktdQHU34zpodV9N9zEu3H1biShZL/3tZAdlnkgltMswqALaTjxE
	 eX9ysZSrrbzj1mt2R0c9c7jXa5m9WR8iNE2m/RO3JX7xMzNFbmQ7RIqHovhYcsURJu
	 lOX2pHSd5VFlQ==
Message-ID: <dfba107a-21fd-4439-ad6f-bd8a976fb232@kernel.org>
Date: Wed, 19 Nov 2025 10:17:13 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/9] mm: introduce copy-on-fork VMAs and make
 VM_MAYBE_GUARD one
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
References: <cover.1763460113.git.lorenzo.stoakes@oracle.com>
 <5d41b24e7bc622cda0af92b6d558d7f4c0d1bc8c.1763460113.git.lorenzo.stoakes@oracle.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <5d41b24e7bc622cda0af92b6d558d7f4c0d1bc8c.1763460113.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.11.25 11:17, Lorenzo Stoakes wrote:
> Gather all the VMA flags whose presence implies that page tables must be
> copied on fork into a single bitmap - VM_COPY_ON_FORK - and use this
> rather than specifying individual flags in vma_needs_copy().
> 
> We also add VM_MAYBE_GUARD to this list, as it being set on a VMA implies
> that there may be metadata contained in the page tables (that is - guard
> markers) which would will not and cannot be propagated upon fork.
> 
> This was already being done manually previously in vma_needs_copy(), but
> this makes it very explicit, alongside VM_PFNMAP, VM_MIXEDMAP and
> VM_UFFD_WP all of which imply the same.
> 
> Note that VM_STICKY flags ought generally to be marked VM_COPY_ON_FORK too
> - because equally a flag being VM_STICKY indicates that the VMA contains
> metadat that is not propagated by being faulted in - i.e.  that the VMA
> metadata does not fully describe the VMA alone, and thus we must propagate
> whatever metadata there is on a fork.
> 
> However, for maximum flexibility, we do not make this necessarily the case
> here.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> ---

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David

