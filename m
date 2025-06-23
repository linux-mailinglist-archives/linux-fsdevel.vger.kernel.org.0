Return-Path: <linux-fsdevel+bounces-52611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC40AE4852
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 17:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EF353AC6A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 15:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C14D28D8FA;
	Mon, 23 Jun 2025 15:18:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5C9224893;
	Mon, 23 Jun 2025 15:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750691891; cv=none; b=LOigFgbUWpk7OpQivC32Q/8R5uJDeTJpA3K7HzNMBwFOqquw05/wADZH6bjhdHMGhtCniBGZnJ35UtwdIHvXhaegmiE4sawW2rNGeZX2hFT+NKHeaaNOFIL/2T4toypmbbGTgWeQpaiq6jKaS9w6i7Q+OxJbolOWVxDgqKqC/B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750691891; c=relaxed/simple;
	bh=opP6VbacAik7kXsSXDMkWX87HGWzgD5vpekjckRrHZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oi0naSWmI1KEK+GZM4A/z7TBhUablLvahfZ/fIMZdVDzrTW0f3qawDQrvBC6LjgzO+11UIAMquvCibfQhzcETMCTGlFC3beZgcX+hs4W78/R5wQe337CIXA2HefR5Fo75pMyAaVUlLtNZL1fOUzMo9zDLcl/oEnoU3B/iNsCFpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 789171756;
	Mon, 23 Jun 2025 08:17:50 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04FB33F58B;
	Mon, 23 Jun 2025 08:18:00 -0700 (PDT)
Date: Mon, 23 Jun 2025 16:17:58 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Russell King <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>, Peter Xu <peterx@redhat.com>,
	David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Hugh Dickins <hughd@google.com>, Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-sgx@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	nvdimm@lists.linux.dev, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm: update architecture and driver code to use
 vm_flags_t
Message-ID: <aFlwJgMikwy41OXc@arm.com>
References: <cover.1750274467.git.lorenzo.stoakes@oracle.com>
 <b6eb1894abc5555ece80bb08af5c022ef780c8bc.1750274467.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6eb1894abc5555ece80bb08af5c022ef780c8bc.1750274467.git.lorenzo.stoakes@oracle.com>

On Wed, Jun 18, 2025 at 08:42:54PM +0100, Lorenzo Stoakes wrote:
> In future we intend to change the vm_flags_t type, so it isn't correct for
> architecture and driver code to assume it is unsigned long. Correct this
> assumption across the board.
> 
> Overall, this patch does not introduce any functional change.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  arch/arm/mm/fault.c                |  2 +-
>  arch/arm64/include/asm/mman.h      | 10 +++++-----
>  arch/arm64/mm/fault.c              |  2 +-
>  arch/arm64/mm/mmu.c                |  2 +-

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

