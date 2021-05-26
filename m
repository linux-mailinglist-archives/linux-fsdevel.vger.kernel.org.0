Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03B03913B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 11:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbhEZJcc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 May 2021 05:32:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20299 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232218AbhEZJcb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 May 2021 05:32:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622021460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uXwHyc8YEWzgO7cvp9x09kOnIf54F6bkUKMKciKUfB0=;
        b=ZCP/yKWiqBqEI4XjaDd6gG8Zlc13ejKTB1CUJFl5Q7KsvI3Dx3G19HY1UM1x6FrbmPeCMr
        QXvXDwVsFUVGyeTM0GyNM+aygoczkRe91wcAPL7+/LsIvTgj/gOuAtUVSJdZDRsvU9hPEC
        9TwkoLijaHQHfZAzZpStcixSD+z9zVw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-sT7g9JJoMvawfd5AZdW9aQ-1; Wed, 26 May 2021 05:30:58 -0400
X-MC-Unique: sT7g9JJoMvawfd5AZdW9aQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCD0D106BB2A;
        Wed, 26 May 2021 09:30:54 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-99.ams2.redhat.com [10.36.113.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 924105D9D3;
        Wed, 26 May 2021 09:30:42 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Steven Price <steven.price@arm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Aili Yao <yaoaili@kingsoft.com>, Jiri Bohac <jbohac@suse.cz>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v3 0/6] fs/proc/kcore: don't read offline sections, logically offline pages and hwpoisoned pages
Date:   Wed, 26 May 2021 11:30:35 +0200
Message-Id: <20210526093041.8800-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looking for places where the kernel might unconditionally read
PageOffline() pages, I stumbled over /proc/kcore; turns out /proc/kcore
needs some more love to not touch some other pages we really don't want to
read -- i.e., hwpoisoned ones.

Examples for PageOffline() pages are pages inflated in a balloon,
memory unplugged via virtio-mem, and partially-present sections in
memory added by the Hyper-V balloon.

When reading pages inflated in a balloon, we essentially produce
unnecessary load in the hypervisor; holes in partially present sections in
case of Hyper-V are not accessible and already were a problem for
/proc/vmcore, fixed in makedumpfile by detecting PageOffline() pages. In
the future, virtio-mem might disallow reading unplugged memory -- marked
as PageOffline() -- in some environments, resulting in undefined behavior
when accessed; therefore, I'm trying to identify and rework all these
(corner) cases.

With this series, there is really only access via /dev/mem, /proc/vmcore
and kdb left after I ripped out /dev/kmem. kdb is an advanced corner-case
use case -- we won't care for now if someone explicitly tries to do nasty
things by reading from/writing to physical addresses we better not touch.
/dev/mem is a use case we won't support for virtio-mem, at least for now,
so we'll simply disallow mapping any virtio-mem memory via /dev/mem next.
/proc/vmcore is really only a problem when dumping the old kernel via
something that's not makedumpfile (read: basically never), however, we'll
try sanitizing that as well in the second kernel in the future.

Tested via kcore_dump:
	https://github.com/schlafwandler/kcore_dump

v2 -> v3:
- "mm: introduce page_offline_(begin|end|freeze|thaw) to synchronize
   setting PageOffline()"
-- Rephrased a comment as suggested by Mike
- Collected acks and rbs

v1 -> v2:
- Dropped "mm: rename and move page_is_poisoned()"
- "fs/proc/kcore: don't read offline sections, logically offline pages ..."
-- Add is_page_hwpoison() in page-flags.h along with a comment
- "mm: introduce page_offline_(begin|end|freeze|thaw) to ..."
-- s/unfreeze/thaw/
-- Add a comment to PageOffline documentation in page-flags.h
- "virtio-mem: use page_offline_(start|end) when setting PageOffline()"
-- Extend patch description
- "fs/proc/kcore: use page_offline_(freeze|thaw)"
-- Simplify freeze/thaw logic
- Collected acks/rbs

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Roman Gushchin <guro@fb.com>
Cc: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Steven Price <steven.price@arm.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Aili Yao <yaoaili@kingsoft.com>
Cc: Jiri Bohac <jbohac@suse.cz>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: linux-hyperv@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org

David Hildenbrand (6):
  fs/proc/kcore: drop KCORE_REMAP and KCORE_OTHER
  fs/proc/kcore: pfn_is_ram check only applies to KCORE_RAM
  fs/proc/kcore: don't read offline sections, logically offline pages
    and hwpoisoned pages
  mm: introduce page_offline_(begin|end|freeze|thaw) to synchronize
    setting PageOffline()
  virtio-mem: use page_offline_(start|end) when setting PageOffline()
  fs/proc/kcore: use page_offline_(freeze|thaw)

 drivers/virtio/virtio_mem.c |  2 ++
 fs/proc/kcore.c             | 67 ++++++++++++++++++++++++++++++-------
 include/linux/kcore.h       |  3 --
 include/linux/page-flags.h  | 22 ++++++++++++
 mm/util.c                   | 40 ++++++++++++++++++++++
 5 files changed, 118 insertions(+), 16 deletions(-)


base-commit: 6efb943b8616ec53a5e444193dccf1af9ad627b5
-- 
2.31.1

