Return-Path: <linux-fsdevel+bounces-67778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C48A9C49D9B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 01:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2190F188CC04
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 00:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD82136349;
	Tue, 11 Nov 2025 00:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="vjkeLHDm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFE454763;
	Tue, 11 Nov 2025 00:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762820271; cv=none; b=mooVU1Ag7/Ii6tk/im5TbXdFz4IeLGxlnjRVH5An7GF7ge1maNkhZ5YLdcVLN98knjlQjDpyVD56eH82FrZLsAacbovRt/XTdPdKL5V1OlBvmwWScrVSivXLvGbohvMPHmR0hHCIdPsl/KwmsoYNz9pAbVtpImA3lDVOTxg9GyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762820271; c=relaxed/simple;
	bh=h4IOFDJ10o8gxsjF+0swXOnDNA//+lvIGav3YD5mbm4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=r+VRs+4P0pEYLBkDT1OxCqrfvvg17R5ATPRVQWr+OF3SLo6dibLuydJfez9hkG55vvWpi0sAcpCFXq2gO829fz9FwulBv1E6JXegjgpiCFKIdO9l4/J5Zu8iJKQU9qQEkQb5kAEz6abJkF6ZQGB+3/wLJ+wTOCKA6duwr6EAnBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=vjkeLHDm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68CB5C4CEFB;
	Tue, 11 Nov 2025 00:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1762820268;
	bh=h4IOFDJ10o8gxsjF+0swXOnDNA//+lvIGav3YD5mbm4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vjkeLHDmhlbRmdh2J8YEkuADTnOje8197r13F9Y+9M4PNEGyrIjTsJrXa9FcWBd30
	 3dmWPQqBvqXKMpha7c0qNKjQ5ewY10+fA5vTYMX7SAz0x9GQP2DAUfOdVKd+b+ILms
	 w4QnZBmAPYCsSnhcOO+V0J4HJESA9uFYopLe6MVY=
Date: Mon, 10 Nov 2025 16:17:45 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank
 <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, David
 Hildenbrand <david@redhat.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
 <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, Muchun Song
 <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, Vlastimil
 Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Matthew Brost
 <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim
 <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, Gregory Price
 <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, Alistair
 Popple <apopple@nvidia.com>, Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Kemeng Shi
 <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, Nhat Pham
 <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Chris Li
 <chrisl@kernel.org>, SeongJae Park <sj@kernel.org>, Matthew Wilcox
 <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky
 <leon@kernel.org>, Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou
 <chengming.zhou@linux.dev>, Jann Horn <jannh@google.com>, Miaohe Lin
 <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, Pedro
 Falcato <pfalcato@suse.de>, Pasha Tatashin <pasha.tatashin@soleen.com>, Rik
 van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>, Hugh Dickins
 <hughd@google.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH v2 00/16] mm: remove is_swap_[pte, pmd]() + non-swap
 entries, introduce leaf entries
Message-Id: <20251110161745.2075f263e3c693bf65f98ccc@linux-foundation.org>
In-Reply-To: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
References: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Nov 2025 22:21:18 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> There's an established convention in the kernel that we treat leaf page
> tables (so far at the PTE, PMD level) as containing 'swap entries' should
> they be neither empty (i.e. p**_none() evaluating true) nor present
> (i.e. p**_present() evaluating true).
> 
> However, at the same time we also have helper predicates - is_swap_pte(),
> is_swap_pmd() - which are inconsistently used.
> 
> This is problematic, as it is logical to assume that should somebody wish
> to operate upon a page table swap entry they should first check to see if
> it is in fact one.
> 
> It also implies that perhaps, in future, we might introduce a non-present,
> none page table entry that is not a swap entry.
> 
> This series resolves this issue by systematically eliminating all use of
> the is_swap_pte() and is swap_pmd() predicates so we retain only the
> convention that should a leaf page table entry be neither none nor present
> it is a swap entry.

Thanks, I updated mm.git's mm-unstable branch to this version the patchset.

