Return-Path: <linux-fsdevel+bounces-69462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4244AC7B98A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 20:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 478324EA0FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9D63043BC;
	Fri, 21 Nov 2025 19:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="1gsWB9CG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ABE2E041A;
	Fri, 21 Nov 2025 19:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763754953; cv=none; b=BniwARLWfqQXusplPtyudHW+fFvmU6PFq4x8AGyjfoURnYWuectnn7N1b69OTazzfxpAyYnS+ajXfQins44K5z0DItt8Vg1E0WE1NtBhx86s0nn+g6i2gMTHjvDOufwBPR+V0Vrs50Kzkjq7Djnwnm1Wa2zPcUGE0pUxPcZfNxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763754953; c=relaxed/simple;
	bh=ZJ2imUn9Mco77w7/pdIgQXc4oF4zUj7dqNGxM1kbtZk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=olP/WuvwwLqPyMrg9KInwffs2ffsJuruA50IGOcyUT3VQVo9M5AapzSg26qjDuziaDPtIoi/D6QWGZzVF2D1tWQ4sI9PPur+tYOFHV6Hwlo4BBQlV4JuzQhrbPy3V6otxbXbpFTnL8RncIMiIupVCh8xxtY9QOumFRn/yA0TqGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=1gsWB9CG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01299C4CEF1;
	Fri, 21 Nov 2025 19:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1763754952;
	bh=ZJ2imUn9Mco77w7/pdIgQXc4oF4zUj7dqNGxM1kbtZk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=1gsWB9CGDheDWsUEWoqPq+K2Og2h9mfP0NvvauyDN66X4mW929BZ9UKFHwPQXSfGy
	 Gg/r2nAupA9992Bws/OHN7TpqhJa/fZ+kEl8obZ1dppTp69FiQnjzoYkWIqOioVhAF
	 8wQM/kxEwdZcv6ztDi7xcMyEi6B3+NUgFaO93Jbo=
Date: Fri, 21 Nov 2025 11:55:50 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio
 Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Peter Xu
 <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Arnd Bergmann
 <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
 <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, Muchun Song
 <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Matthew Brost <matthew.brost@intel.com>, Joshua Hahn
 <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park
 <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, Axel
 Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei
 Xu <weixugc@google.com>, Kemeng Shi <shikemeng@huaweicloud.com>, Kairui
 Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He
 <bhe@redhat.com>, Chris Li <chrisl@kernel.org>, SeongJae Park
 <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe
 <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Xu Xin
 <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, Jann Horn
 <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi
 <nao.horiguchi@gmail.com>, Pedro Falcato <pfalcato@suse.de>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, Rik van Riel <riel@surriel.com>, Harry Yoo
 <harry.yoo@oracle.com>, Hugh Dickins <hughd@google.com>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH v3 07/16] mm: avoid unnecessary use of is_swap_pmd()
Message-Id: <20251121115550.8a8f9b39189b215849ce165d@linux-foundation.org>
In-Reply-To: <67c63cce-f1b8-48d3-83a6-6de1f2d86dda@lucifer.local>
References: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
	<8a1704b36a009c18032d5bea4cb68e71448fbbe5.1762812360.git.lorenzo.stoakes@oracle.com>
	<a623f785-6928-4037-b4be-5d42b46aa603@suse.cz>
	<67c63cce-f1b8-48d3-83a6-6de1f2d86dda@lucifer.local>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Nov 2025 19:25:46 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> > > To add to the confusion in this terminology we use is_swap_pmd() in an
> > > inconsistent way similar to how is_swap_pte() was being used - sometimes
> > > adopting the convention that pmd_none(), !pmd_present() implies PMD 'swap'
> >
> > 			       !pmd_none()
> >
> > ?
> 
> Yeah sorry this is a typo.
> 
> Andrew, if it's easy to fix could you?

a few hours ago ;)

> If too late then never mind :)

"too late" is a thing I try to avoid!

