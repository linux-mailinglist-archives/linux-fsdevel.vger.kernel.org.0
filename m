Return-Path: <linux-fsdevel+bounces-67779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4DDC49DB6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 01:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D2B03A88C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 00:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634EC1A2630;
	Tue, 11 Nov 2025 00:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="pBK+uz/9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3B2188CC9;
	Tue, 11 Nov 2025 00:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762820596; cv=none; b=U8kZUaY+H/tnkWfukAy9g1blNupE1FQu8Il2q/pl7VVPlYZgIEPNvxR9IzERrE4yP0AJ5TJPx/gnjaCZiWykVZ1Gb5D6H5QPldaxGywf0QcthhTGRs20XSyy1Ore2vmbwCqyX56x/dk59a4dmyU0P90HalDF5TEMNcADO09zHJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762820596; c=relaxed/simple;
	bh=gHyaL6pqvKbF/42T+jG0a6a0x8S6QYiyQ3WK/gyAZKs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Sm/o2JNgzFDYvJ2xTQn6h702uXE691TWQaz9QeeBifwUtFFISQitehhwX7w4ZNmMTkoqNcCKFDzXUVSINzJNyV8Qc80nb6bGYcA7mc2XtaHhatss3DHZ9BzrKP3RBgV/0Txb0VC+vu0dzDHkP7/OyOG7C72OD1F8RHJHBqLAezs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=pBK+uz/9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8D1C19425;
	Tue, 11 Nov 2025 00:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1762820596;
	bh=gHyaL6pqvKbF/42T+jG0a6a0x8S6QYiyQ3WK/gyAZKs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pBK+uz/9B/7dT4Dfr1fmhdpoHhdxbIQqjTbyre/CkikfJY2PM+IIamTL2ZV0BAKI6
	 KK/J5MjNOlWuttzCb4ScA2sCUxaN79WlqRq+Yt72sQj5jhbtkPdo/BxnO6J7GWbfms
	 VP61krwUmcnmNbdLHyOdfy1bZLglbb1ntnV/rcd8=
Date: Mon, 10 Nov 2025 16:23:13 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Hugh Dickins <hughd@google.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Chris Li
 <chrisl@kernel.org>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda
 <imbrenda@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Peter Xu
 <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Arnd Bergmann
 <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, "Liam R . Howlett"
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
 <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, SeongJae Park
 <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe
 <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Xu Xin
 <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, Jann Horn
 <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi
 <nao.horiguchi@gmail.com>, Pedro Falcato <pfalcato@suse.de>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, Rik van Riel <riel@surriel.com>, Harry Yoo
 <harry.yoo@oracle.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH v2 00/16] mm: remove is_swap_[pte, pmd]() + non-swap
 entries, introduce leaf entries
Message-Id: <20251110162313.baee36f4815b3aeb3f12921e@linux-foundation.org>
In-Reply-To: <c9e3ad0e-02ef-077c-c12c-f72057eb7817@google.com>
References: <cover.1762621567.git.lorenzo.stoakes@oracle.com>
	<CACePvbVq3kFtrue2smXRSZ86+EuNVf6q+awQnU-n7=Q4x7U9Lw@mail.gmail.com>
	<5b60f6e8-7eab-4518-808a-b34331662da5@lucifer.local>
	<CACePvbUvQu+So7OoUbJTMLODz8YDAOgWaM8A-RXFj2U_Qc-dng@mail.gmail.com>
	<3c0e9dd0-70ac-4588-813b-ffb24d40f067@lucifer.local>
	<c9e3ad0e-02ef-077c-c12c-f72057eb7817@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Nov 2025 15:38:55 -0800 (PST) Hugh Dickins <hughd@google.com> wrote:

> > I'm sorry but this is not a reasonable request. I am being as empathetic and
> > kind as I can be here, but this series is proceeding without arbitrary delay.
> > 
> > I will do everything I can to accommodate any concerns or issues you may have
> > here _within reason_ :)
> 
> But Lorenzo, have you even tested your series properly yet, with
> swapping and folio migration and huge pages and tmpfs under load?
> Please do.
> 
> I haven't had time to bisect yet, maybe there's nothing more needed
> than a one-liner fix somewhere; but from my experience it is not yet
> ready for inclusion in mm and next - it stops testing other folks' work.
> 
> I haven't tried today's v3, but from the cover letter of differences,
> it didn't look like much of importance is fixed since v2: which
> (after a profusion of "Bad swap offet entry 3ffffffffffff" messages,
> not seen with v1, and probably not really serious) soon hits an Oops
> or a BUG or something (as v1 did) - I don't have any logs or notes
> to give yet, just forewarning before pursuing later in the day.
> 
> If you think v3 has fixed real crashes under load, please say so:
> otherwise, I doubt it's worth Andrew hurrying to replace v2 by v3.

Oh.  Thanks.  I'll move the v3 series into mm-new for now.


