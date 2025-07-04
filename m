Return-Path: <linux-fsdevel+bounces-53991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 662CCAF9BD7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 23:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0969C1BC60B7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 21:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC1221930A;
	Fri,  4 Jul 2025 21:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="y88kB/pc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0E6A2D;
	Fri,  4 Jul 2025 21:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751663186; cv=none; b=bbwX0oW82X3pOn0ZRXyXd7uYnu6tUzuac9oZZsdpwYAcsXjUt56eK9BJrZs5iLGFbXttsm73qPdefg9yejDsVSOlVaxRU1HnNYz4o3agk7lv5GjgHymA/gBvyrPzG/MJoM/yrl4hjIkBasSOLrJ65c9Rl1qhD6roZsm/wbKMU9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751663186; c=relaxed/simple;
	bh=f1hFiasjHfmlcHU6lmk4NYAher/zzJdd1u4QQBrYVJ8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NBocScyDG87bjOlrMQLdM5GxNZKcLEgdftYuhIT3kOnTeeqzR9ScxrO5Ltg35qceY/7AKBkuSHzRIJ7AOHhq5N5CqoHgd+YlD2CYQfwH948BCb639qaf8AXic9Mm8cHwigv2uxRbDYAUtxjBUHlrhQq6abC1ABhB5pncGaVFmiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=y88kB/pc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27406C4CEE3;
	Fri,  4 Jul 2025 21:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1751663185;
	bh=f1hFiasjHfmlcHU6lmk4NYAher/zzJdd1u4QQBrYVJ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=y88kB/pcD4E4EqtT4CkMHjZGaNV/MSL+BfunpDneJYf0u7QKpcXsSW9s14r8BkNmx
	 WaI24KqTkwL1L2kVQDd0U0gUqzKoB3oOSJKBdiYtW2qefak2kybpZOsGNd5sTK4MTP
	 njKj4JxNYga3WE9rzmNqEaH7gILlxUtdajr7p1I8=
Date: Fri, 4 Jul 2025 14:06:23 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org, Jonathan
 Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Jerrin Shaji George
 <jerrin.shaji-george@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Zi Yan
 <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, Joshua Hahn
 <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park
 <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Minchan
 Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard
 <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, Xu Xin
 <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, Miaohe
 Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Oscar Salvador <osalvador@suse.de>, Rik van Riel <riel@surriel.com>, Harry
 Yoo <harry.yoo@oracle.com>, Qi Zheng <zhengqi.arch@bytedance.com>, Shakeel
 Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v2 00/29] mm/migration: rework movable_ops page
 migration (part 1)
Message-Id: <20250704140623.d6b9a013984bc2a109dd4dc9@linux-foundation.org>
In-Reply-To: <20250704102524.326966-1-david@redhat.com>
References: <20250704102524.326966-1-david@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri,  4 Jul 2025 12:24:54 +0200 David Hildenbrand <david@redhat.com> wrote:

> In the future, as we decouple "struct page" from "struct folio", pages
> that support "non-lru page migration" -- movable_ops page migration
> such as memory balloons and zsmalloc -- will no longer be folios. They
> will not have ->mapping, ->lru, and likely no refcount and no
> page lock. But they will have a type and flags 🙂
> 
> This is the first part (other parts not written yet) of decoupling
> movable_ops page migration from folio migration.
> 
> In this series, we get rid of the ->mapping usage, and start cleaning up
> the code + separating it from folio migration.
> 
> Migration core will have to be further reworked to not treat movable_ops
> pages like folios. This is the first step into that direction.
> 
> Heavily tested with virtio-balloon and lightly tested with zsmalloc
> on x86-64. Cross-compile-tested.

Thanks, I added this to mm-new.  I suppressed the 1363 mm-commits
emails to avoid breaking the internet.


