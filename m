Return-Path: <linux-fsdevel+bounces-67876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD2CC4CB80
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 10:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF6BE18848E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 09:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7BB2F2618;
	Tue, 11 Nov 2025 09:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCiWpRgX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C1C2EBBAF;
	Tue, 11 Nov 2025 09:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854007; cv=none; b=ClXclZJlL3U58zMq9pjk/hLLH/RK4luaKCjc0ou1bBMjFqnpfyClSkqoF/6iK/y7/5lg5bFoh9gyGaTJMN8v1dVSbBLgBKWi4T0W1k1+dXldZQShrXoqFwbAkWcRmGKJiPhm8NZMHi+rWsvDmyLwLK04cC94L40OgUeor90K6Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854007; c=relaxed/simple;
	bh=tV63J7taBdyVxD5Onk+zak6F3ctliG+Q3nAMch/i9HU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkFvqRV57OF45zjTXDxHbx+nFo9SocMMRzR2HowxegepkjeNKqitE4TtaK6O5qi4HfKmNI29/p+5OTuexinHO6FrY1AAnRVQVZAz0VWvmE9JCD0XGbPhCXC+tSkb1inaKtcjJFvu5oQDlyi/k68FdZVXVcqiz7aQrvuFtgXihw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCiWpRgX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E4CC4CEF7;
	Tue, 11 Nov 2025 09:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762854006;
	bh=tV63J7taBdyVxD5Onk+zak6F3ctliG+Q3nAMch/i9HU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GCiWpRgXryUr0YiOuRCqFKMHFElrFfOJGLeX13fDzQhzdLeEMfA68uzI2EJFfxVhm
	 0MUDm4yk8dcgPkbCGQ9mByaYozbzGtDDR+dxx7BYEgVrFiJ8SZ2pdALZBfQboS0gvo
	 mHVFJX+o1gZPTNTphPXA9WbgGYWk9nlExIF62mZ73WXnbIrDTiR4NqRFsQaQL8Dvkw
	 S1IFcQzK7HMyEOdAdOb32M0+zECDPIh+yvtjXasK0QRuj70XQpLdc9540fG5C8LyLy
	 GOdJphkYB7U4gWmOkayWv8GOEYQl0T5F0efMNLKo7WjK4EvGrJauQ6RDtyW294LDmB
	 ZpUDNt59CcokQ==
Date: Tue, 11 Nov 2025 11:39:43 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
	SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
	Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH v3 01/16] mm: correctly handle UFFD PTE markers
Message-ID: <aRMEX5YP7ubGOmqo@kernel.org>
References: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
 <c38625fd9a1c1f1cf64ae8a248858e45b3dcdf11.1762812360.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c38625fd9a1c1f1cf64ae8a248858e45b3dcdf11.1762812360.git.lorenzo.stoakes@oracle.com>

On Mon, Nov 10, 2025 at 10:21:19PM +0000, Lorenzo Stoakes wrote:
> PTE markers were previously only concerned with UFFD-specific logic - that
> is, PTE entries with the UFFD WP marker set or those marked via
> UFFDIO_POISON.
> 
> However since the introduction of guard markers in commit
>  7c53dfbdb024 ("mm: add PTE_MARKER_GUARD PTE marker"), this has no longer
>  been the case.
> 
> Issues have been avoided as guard regions are not permitted in conjunction
> with UFFD, but it still leaves very confusing logic in place, most notably
> the misleading and poorly named pte_none_mostly() and
> huge_pte_none_mostly().
> 
> This predicate returns true for PTE entries that ought to be treated as
> none, but only in certain circumstances, and on the assumption we are
> dealing with H/W poison markers or UFFD WP markers.
> 
> This patch removes these functions and makes each invocation of these
> functions instead explicitly check what it needs to check.
> 
> As part of this effort it introduces is_uffd_pte_marker() to explicitly
> determine if a marker in fact is used as part of UFFD or not.
> 
> In the HMM logic we note that the only time we would need to check for a
> fault is in the case of a UFFD WP marker, otherwise we simply encounter a
> fault error (VM_FAULT_HWPOISON for H/W poisoned marker, VM_FAULT_SIGSEGV
> for a guard marker), so only check for the UFFD WP case.
> 
> While we're here we also refactor code to make it easier to understand.
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

with a small nit below

> ---
>  
> -	ret = false;
> +	/*
> +	 * A race could arise which would result in a softleaf entry such a

                                                                    ^ such as 

> +	 * migration entry unexpectedly being present in the PMD, so explicitly
> +	 * check for this and bail out if so.
> +	 */

-- 
Sincerely yours,
Mike.

