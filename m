Return-Path: <linux-fsdevel+bounces-63806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24588BCE794
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 22:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABB183B66AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 20:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C7A302170;
	Fri, 10 Oct 2025 20:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndUXUFIr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B67C26F297;
	Fri, 10 Oct 2025 20:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760127640; cv=none; b=Ae1hcvR94aE5yyMLfI+VTB0HrXkbZinCU1pyuFPyLqJmjX8E8DpcBcxQXGaW4/YOACRcyIV0FWHgerYFb+c4yI3MLh1Lzs5qT2dV1tnvla6cY1x+262nJr4IDoZ7i3p7FLx80xl4AnX+FcV+K7i1t6oP1U31wTETfjFIzHcU2xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760127640; c=relaxed/simple;
	bh=uVkz8lpHC9sRqbxmG0cbQgUT9iFYMlmYAvK7Zotg0qI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WMsx2JbF3x9/wYdZ3DcbXdJK3kxl1dZxCY5SnLWSz5V25Bjf+MsQ3RNaQwT0+S9vRy4PTPoCtLPoEqxTHFJnPzS1/vpeEJ7CfTNX1dcHGDT3gBp4cEflZkPx5XaSD/bHGuH2H+IIfuS3V4jo9eSVpHZT2rDj2UJKdyiVA+7YQgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndUXUFIr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9D9C4CEF1;
	Fri, 10 Oct 2025 20:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760127638;
	bh=uVkz8lpHC9sRqbxmG0cbQgUT9iFYMlmYAvK7Zotg0qI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ndUXUFIrDC4sy+YuQodWLx1NncOMGEi6Ntd5aZvhTNWsNDQaAPxewqEYUeMV09/Ku
	 YRH+TZg8HA/2chtSyilVNZpHT53rdKAfleUV94QOMXIEa1o7By8QktAbfxOWx1ZG1R
	 1CTZEMay805+PBoPLgXOWOYA/u+H3OlmWCsx0hBKE/k/Rl5azUvLVWTqEGJ9yjLEH8
	 JpDxQFed9N0KEiiENMtfEs6WsTKSXkPagVoYOJt8bd0Wpb/p+2q5Gmu/5ihNvknD95
	 cupul+zpPbCfBdnZwS073t/xfaGc4MlUbco+Dlzb/PQzGJGOXBLwKhOeJHXCB7L9XM
	 1AFubXAW7f21w==
From: SeongJae Park <sj@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	alexandru.elisei@arm.com,
	peterx@redhat.com,
	rppt@kernel.org,
	mhocko@suse.com,
	corbet@lwn.net,
	axboe@kernel.dk,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	hch@infradead.org,
	jack@suse.cz,
	willy@infradead.org,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	hannes@cmpxchg.org,
	zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	minchan@kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH 6/8] add cleancache documentation
Date: Fri, 10 Oct 2025 13:20:34 -0700
Message-Id: <20251010202034.58002-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251010011951.2136980-7-surenb@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Suren,

On Thu,  9 Oct 2025 18:19:49 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> Document cleancache, it's APIs and sysfs interface.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  Documentation/mm/cleancache.rst | 112 ++++++++++++++++++++++++++++++++
>  MAINTAINERS                     |   1 +

I think this great document is better to be linked on mm/index.rst.

Also, would it make sense to split the sysfs interface part and put under
Documentation/admin-guide/mm/ ?

>  2 files changed, 113 insertions(+)
>  create mode 100644 Documentation/mm/cleancache.rst
> 
> diff --git a/Documentation/mm/cleancache.rst b/Documentation/mm/cleancache.rst
> new file mode 100644
> index 000000000000..deaf7de51829
> --- /dev/null
> +++ b/Documentation/mm/cleancache.rst
> @@ -0,0 +1,112 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==========
> +Cleancache
> +==========
> +
> +Motivation
> +==========
> +
> +Cleancache is a feature to utilize unused reserved memory for extending
> +page cache.
> +
> +Cleancache can be thought of as a folio-granularity victim cache for clean
> +file-backed pages that the kernel's pageframe replacement algorithm (PFRA)
> +would like to keep around, but can't since there isn't enough memory. So
> +when the PFRA "evicts" a folio, it stores the data contained in the folio
> +into cleancache memory which is not directly accessible or addressable by
> +the kernel (transcendent memory) and is of unknown and possibly
> +time-varying size.

IMHO, "(transcendent memory)" better to be dropped, as it has removed by commit
814bbf49dcd0 ("xen: remove tmem driver").

> +
> +Later, when a filesystem wishes to access a folio in a file on disk, it
> +first checks cleancache to see if it already contains required data; if it
> +does, the folio data is copied into the kernel and a disk access is
> +avoided.
> +
> +The memory cleancache uses is donated by other system components, which
> +reserve memory not directly addressable by the kernel. By donating this
> +memory to cleancache, the memory owner enables its utilization while it
> +is not used. Memory donation is done using cleancache backend API and any
> +donated memory can be taken back at any time by its donor without no delay

"without delay" or "with no delay" ?

> +and with guarantees success. Since cleancache uses this memory only to
> +store clean file-backed data, it can be dropped at any time and therefore
> +the donor's request to take back the memory can be always satisfied.
> +
> +Implementation Overview
> +=======================
> +
> +Cleancache "backend" (donor that provides transcendent memory), registers

Again, "transcendent memory" part seems better to be dropped.

> +itself with cleancache "frontend" and received a unique pool_id which it
> +can use in all later API calls to identify the pool of folios it donates.
> +Once registered, backend can call cleancache_backend_put_folio() or
> +cleancache_backend_put_folios() to donate memory to cleancache. Note that
> +cleancache currently supports only 0-order folios and will not accept
> +larger-order ones. Once the backend needs that memory back, it can get it
> +by calling cleancache_backend_get_folio(). Only the original backend can
> +take the folio it donated from the cleancache.
> +
> +Kernel uses cleancache by first calling cleancache_add_fs() to register
> +each file system and then using a combination of cleancache_store_folio(),
> +cleancache_restore_folio(), cleancache_invalidate_{folio|inode} to store,
> +restore and invalidate folio content.
> +cleancache_{start|end}_inode_walk() are used to walk over folios inside
> +an inode and cleancache_restore_from_inode() is used to restore folios
> +during such walks.
> +
> +From kernel's point of view folios which are copied into cleancache have
> +an indefinite lifetime which is completely unknowable by the kernel and so
> +may or may not still be in cleancache at any later time. Thus, as its name
> +implies, cleancache is not suitable for dirty folios. Cleancache has
> +complete discretion over what folios to preserve and what folios to discard
> +and when.
> +
> +Cleancache Performance Metrics
> +==============================
> +
> +If CONFIG_CLEANCACHE_SYSFS is enabled, monitoring of cleancache performance
> +can be done via sysfs in the `/sys/kernel/mm/cleancache` directory.
> +The effectiveness of cleancache can be measured (across all filesystems)
> +with provided stats.
> +Global stats are published directly under `/sys/kernel/mm/cleancache` and
> +include:

``/sys/kernel/mm/cleancache`` ?

> +
> +``stored``
> +	number of successful cleancache folio stores.
> +
> +``skipped``
> +	number of folios skipped during cleancache store operation.
> +
> +``restored``
> +	number of successful cleancache folio restore operations.
> +
> +``missed``
> +	number of failed cleancache folio restore operations.
> +
> +``reclaimed``
> +	number of folios reclaimed from the cleancache due to insufficient
> +	memory.
> +
> +``recalled``
> +	number of times cleancache folio content was discarded as a result
> +	of the cleancache backend taking the folio back.
> +
> +``invalidated``
> +	number of times cleancache folio content was discarded as a result
> +	of invalidation.
> +
> +``cached``
> +	number of folios currently cached in the cleancache.
> +
> +Per-pool stats are published under `/sys/kernel/mm/cleancache/<pool name>`

``/sys/kernel/mm/cleancache/<pool name>`` ?

> +where "pool name" is the name pool was registered under. These stats
> +include:
> +
> +``size``
> +	number of folios donated to this pool.
> +
> +``cached``
> +	number of folios currently cached in the pool.
> +
> +``recalled``
> +	number of times cleancache folio content was discarded as a result
> +	of the cleancache backend taking the folio back from the pool.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1c97227e7ffa..441e68c94177 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6053,6 +6053,7 @@ CLEANCACHE
>  M:	Suren Baghdasaryan <surenb@google.com>
>  L:	linux-mm@kvack.org
>  S:	Maintained
> +F:	Documentation/mm/cleancache.rst
>  F:	include/linux/cleancache.h
>  F:	mm/cleancache.c
>  F:	mm/cleancache_sysfs.c
> -- 
> 2.51.0.740.g6adb054d12-goog


Thanks,
SJ

