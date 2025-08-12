Return-Path: <linux-fsdevel+bounces-57449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A150B21A29
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 03:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 826EF427925
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 01:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8B02D8377;
	Tue, 12 Aug 2025 01:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="frvUwLRQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942941D54FE;
	Tue, 12 Aug 2025 01:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754962216; cv=none; b=Rk8DzF5pH80Ft5c2I4jki6O7j4GF8D8ioZVgrrQb7L3hPogZw/TlpjG0IWlXTiM/6ksm6zFi04VRjy9pBd1Pn0iQcT7+c208kTMgsLll2mZGYTDqBUdHGLOTZVwTSwEOTVXUh1Mp1x85xSxBIqdO8QkqgPF7Nn/QDQ2C1AuKDZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754962216; c=relaxed/simple;
	bh=5VapdnES7ub01fEzwLbmifK+dKN+v5agxO17nHqVte8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SCDaSH2WL9qEQtT1aOt+3ZGMrBYhfShrdyQacXQnpvmcmdxQI4XtTCxXX0fhGJQ+NUXZMvniUY1ehBmocBBi8AHvonsoZkuPJclRcfY6Q8Q57xvkZrYX8ypFApu4IMN1W9rle+oASyo1VFO2SF/py3OnmqpHOlbC4tQ1IytI0Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=frvUwLRQ; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754962211; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=djZxdkbYS5ABjJh5vZ+OSyzqxKEA12clHOn12k1eFBw=;
	b=frvUwLRQLX0H2asuzYyXjungyRzbjcqgz05Uzou8O9sYyKpjxyIoCkyOeNcebZqP3+WpAHzwUeWLqG9X/qe9unx2FyE1diCLrrSXMjh2Rvke5WmTPRhiTzhj5VXAM1R7Y/LmArvgpwAFZ5FVHnAosG4OoMeHPme5/OvjXAKZ5bA=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WlYvemQ_1754962181 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 Aug 2025 09:30:08 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org,  linux-mm@kvack.org,
  linuxppc-dev@lists.ozlabs.org,  virtualization@lists.linux.dev,
  linux-fsdevel@vger.kernel.org,  linux-aio@kvack.org,
  linux-btrfs@vger.kernel.org,  jfs-discussion@lists.sourceforge.net,
  Andrew Morton <akpm@linux-foundation.org>,  Madhavan Srinivasan
 <maddy@linux.ibm.com>,  Michael Ellerman <mpe@ellerman.id.au>,  Nicholas
 Piggin <npiggin@gmail.com>,  Christophe Leroy
 <christophe.leroy@csgroup.eu>,  Jerrin Shaji George
 <jerrin.shaji-george@broadcom.com>,  Arnd Bergmann <arnd@arndb.de>,  Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Jason Wang <jasowang@redhat.com>,  Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>,  Eugenio =?utf-8?Q?P=C3=A9rez?=
 <eperezma@redhat.com>,
  Alexander Viro <viro@zeniv.linux.org.uk>,  Christian Brauner
 <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,  Benjamin LaHaise
 <bcrl@kvack.org>,  Chris Mason <clm@fb.com>,  Josef Bacik
 <josef@toxicpanda.com>,  David Sterba <dsterba@suse.com>,  Muchun Song
 <muchun.song@linux.dev>,  Oscar Salvador <osalvador@suse.de>,  Dave
 Kleikamp <shaggy@kernel.org>,  Zi Yan <ziy@nvidia.com>,  Matthew Brost
 <matthew.brost@intel.com>,  Joshua Hahn <joshua.hahnjy@gmail.com>,  Rakie
 Kim <rakie.kim@sk.com>,  Byungchul Park <byungchul@sk.com>,  Gregory Price
 <gourry@gourry.net>,  Alistair Popple <apopple@nvidia.com>,  Minchan Kim
 <minchan@kernel.org>,  Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v1 0/2] mm: remove MIGRATEPAGE_*
In-Reply-To: <20250811143949.1117439-1-david@redhat.com> (David Hildenbrand's
	message of "Mon, 11 Aug 2025 16:39:46 +0200")
References: <20250811143949.1117439-1-david@redhat.com>
Date: Tue, 12 Aug 2025 09:29:40 +0800
Message-ID: <87bjolgwe3.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi, David,

David Hildenbrand <david@redhat.com> writes:

> This is against mm/mm-new.
>
> This series gets rid of MIGRATEPAGE_UNMAP, to then convert the remaining
> MIGRATEPAGE_SUCCESS usage to simply use 0 instead.
>
> Not sure if it makes sense to split the second patch up, a treewide
> cleanup felt more reasonable for this simple change in an area where
> I don't expect a lot of churn.
>
> Briefly tested with virtio-mem in a VM, making sure that basic
> page migration keeps working.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Jerrin Shaji George <jerrin.shaji-george@broadcom.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Cc: "Eugenio P=C3=A9rez" <eperezma@redhat.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Benjamin LaHaise <bcrl@kvack.org>
> Cc: Chris Mason <clm@fb.com>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: David Sterba <dsterba@suse.com>
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Dave Kleikamp <shaggy@kernel.org>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
> Cc: Rakie Kim <rakie.kim@sk.com>
> Cc: Byungchul Park <byungchul@sk.com>
> Cc: Gregory Price <gourry@gourry.net>
> Cc: Ying Huang <ying.huang@linux.alibaba.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
>
> David Hildenbrand (2):
>   mm/migrate: remove MIGRATEPAGE_UNMAP
>   treewide: remove MIGRATEPAGE_SUCCESS

LGTM.  Feel free to add my

Reviewed-by: Huang Ying <ying.huang@linux.alibaba.com>

for the whole series in the future versions.

>  arch/powerpc/platforms/pseries/cmm.c |  2 +-
>  drivers/misc/vmw_balloon.c           |  4 +-
>  drivers/virtio/virtio_balloon.c      |  2 +-
>  fs/aio.c                             |  2 +-
>  fs/btrfs/inode.c                     |  4 +-
>  fs/hugetlbfs/inode.c                 |  4 +-
>  fs/jfs/jfs_metapage.c                |  8 +--
>  include/linux/migrate.h              | 11 +---
>  mm/migrate.c                         | 80 ++++++++++++++--------------
>  mm/migrate_device.c                  |  2 +-
>  mm/zsmalloc.c                        |  4 +-
>  11 files changed, 56 insertions(+), 67 deletions(-)
>
>
> base-commit: 53c448023185717d0ed56b5546dc2be405da92ff

---
Best Regards,
Huang, Ying

