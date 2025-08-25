Return-Path: <linux-fsdevel+bounces-59139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C10B34E28
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 23:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 097741A8781A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 21:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA0729B778;
	Mon, 25 Aug 2025 21:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHK0J2XK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A4C27A917;
	Mon, 25 Aug 2025 21:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756157832; cv=none; b=q3OMa9klER5kcD5hfQzcH5gEW7TqnE/VhFRTneqUwrlw9Ruy4lQnon4v6dAnVBJVeyxj47K7EVeVDBtSpzNjA3D0XmVWwws2RJuLrKb1iZuZqoyYDzXpZh+InipMXWpFSo/36P6fq4/tqnZ9SPk1Di+jP/zgFVDtia5yEbTg33M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756157832; c=relaxed/simple;
	bh=R44bcAauESCYgLUnJio9oy6n01PzJ9gIprVhrTrJHrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jysYVL6zkgDrCW3NlDdD4AKsp+HbcYV1IbcdhXRmL27yEHvsChfnOoa0Eh/Sq0iLbiQTuWFctTWTUn1oA5Ht2e0dBAdZcuP7w+a0W00fpZ8DJEaQfG8LtOvNTZ4Em1HCnXspuWpMbk/plehaBPNhO5YXS/jHcvh/teyxa9FO+2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHK0J2XK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A2DC4CEED;
	Mon, 25 Aug 2025 21:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756157832;
	bh=R44bcAauESCYgLUnJio9oy6n01PzJ9gIprVhrTrJHrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cHK0J2XKD7O53HrO4WZ8mbIIVXn1J5qjjnP+8NSiRBKE3qlSqot7fO4LiyDmh3qgE
	 994EaQi3GxaYUTiVcTdNq2CGuy4qPwf/BZ6vvOP7yQ30A6KQwyOxLpJ4d9L/7pKqbH
	 63qLEryMSPxlPH2YhbRhXt0pRoKURT7ELLjHiKpyDkSL4+J1AcoW5Sk8qXCImM2+ak
	 p+lYv9xx85LoSuSqFv4ayEsXAVqjvuHqIqMi44uUedVEGuxxRKPPODQHHSRnAgIdh6
	 6clMMLqdhTofD9UT8HCFqf2Jy7NMLg5RmykPuzN+FoKKgILHRb4q6/nyDxdavQQRRP
	 2Gu14gyBVu0BQ==
Date: Mon, 25 Aug 2025 14:37:11 -0700
From: Kees Cook <kees@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Mike Rapoport <rppt@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
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
	Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Hugh Dickins <hughd@google.com>, Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
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
Subject: Re: [PATCH 2/3] mm: update core kernel code to use vm_flags_t
 consistently
Message-ID: <202508251436.762035B@keescook>
References: <cover.1750274467.git.lorenzo.stoakes@oracle.com>
 <d1588e7bb96d1ea3fe7b9df2c699d5b4592d901d.1750274467.git.lorenzo.stoakes@oracle.com>
 <aIgSpAnU8EaIcqd9@hyeyoo>
 <73764aaa-2186-4c8e-8523-55705018d842@lucifer.local>
 <aIkVRTouPqhcxOes@pc636>
 <69860c97-8a76-4ce5-b1d6-9d7c8370d9cd@lucifer.local>
 <aJCRXVP-ZFEPtl1Y@pc636>
 <aJHQ9XCLtibFjt93@kernel.org>
 <aJItxJNfn8B2JBbn@pc636>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJItxJNfn8B2JBbn@pc636>

On Tue, Aug 05, 2025 at 06:13:56PM +0200, Uladzislau Rezki wrote:
> I agree. Also it can be even moved under vmalloc.c. There is only one
> user which needs it globally, it is usercopy.c. It uses find_vmap_area()
> which is wrong. See:
> 
> <snip>
> 	if (is_vmalloc_addr(ptr) && !pagefault_disabled()) {
> 		struct vmap_area *area = find_vmap_area(addr);
> 
> 		if (!area)
> 			usercopy_abort("vmalloc", "no area", to_user, 0, n);
> 
> 		if (n > area->va_end - addr) {
> 			offset = addr - area->va_start;
> 			usercopy_abort("vmalloc", NULL, to_user, offset, n);
> 		}
> 		return;
> 	}
> <snip>
> 
> we can add a function which just assign va_start, va_end as input
> parameters and use them in the usercopy.c. 

Yes please! I'd must rather use some exported validation routine than
having it hand-coded in usercopy.c. :)

-- 
Kees Cook

