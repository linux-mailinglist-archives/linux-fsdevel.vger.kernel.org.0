Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167B379F062
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 19:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjIMRaI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 13:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjIMRaH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:30:07 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E3CCE
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 10:30:03 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58cb845f2f2so757077b3.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 10:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694626202; x=1695231002; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nQYKtEx2Ahg/EgiBcTyeql1DXcav92WH1KFkTagbIIU=;
        b=QcZGQlJFPD7rOD8ukzyNgU4IKqt4aKsgMSJHXOPq0kzX2xLz8OeX5oHGHvOzZlCvID
         +weXoFNpjn8TKNRouilDr2s0covfCzgMXwabba0Dw3WZJQuK47MWwafZavej3GrK4Rwv
         aisp03OFpxns1K+GnZ8NI54KZJX66yoiEIjxJVpJvkLOlkV8rCWlAvXZihIia/kuAJGL
         txHZldYGrijNylL5LtyKgIwPKB4yCSeTmuj13EoCVCEJc/SIBgvMGJJ8AK/UMV/K0VBR
         68FKRV+QkUKIYmfB0IUlfn02vnV4Npr9124pdet16QX5+rly28snLHE3GosYLx3968b+
         6lFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694626202; x=1695231002;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nQYKtEx2Ahg/EgiBcTyeql1DXcav92WH1KFkTagbIIU=;
        b=pnpR+0q2TIySbokFCf0BFGU+qstXTjoMNVYG+PN6SDaZBaQwBL/vk0r6tRn4yFayuv
         hFmV8xhfuCnl9XcOC1jA/N2vMXMiFkIu/oU37RpOKSFs4moc0QJJBHt6stFlvBwhKZ/q
         QGK3hQNR3RQ3s5ysKtNzPhw9aUrJDAegUU3LWGn6uvbx08W/lM4hXIDUMOcMjl8QQd9C
         Hc/napiiMyhLMLuZF/0M+S50imMPxzYWyab4bJidcoogmbuBuBuH247+NjBKoWnuyItv
         6a319AUuRpXpHWimln6HcYC8GMQnJfYal65IMX7nh1fUah9K6tBLDoN8yTdO3gQFx82D
         DcRg==
X-Gm-Message-State: AOJu0Yy/i53PnKuHPNDlvMn35g6pNIhEyCpUbNaOju2nwIduL85kyj5X
        IWJfzIhmW4HTTxEz7+VCoELBX/kpkFuxmqzGrA==
X-Google-Smtp-Source: AGHT+IE5cLs10j5eM7g1XBTKf4J/Tj20JYHER+8VUILJlyo+8XOTakwpxeH8VGHFwpoyBFxAjTheI7UpMFKI+r/eiQ==
X-Received: from souravpanda.svl.corp.google.com ([2620:15c:2a3:200:2718:5cf5:d91:d21d])
 (user=souravpanda job=sendgmr) by 2002:a05:690c:4703:b0:59b:e86f:ed2d with
 SMTP id gz3-20020a05690c470300b0059be86fed2dmr3605ywb.5.1694626202437; Wed,
 13 Sep 2023 10:30:02 -0700 (PDT)
Date:   Wed, 13 Sep 2023 10:29:59 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230913173000.4016218-1-souravpanda@google.com>
Subject: [PATCH v1 0/1] Report perpage metadata information.
From:   Sourav Panda <souravpanda@google.com>
To:     corbet@lwn.net, gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev, rppt@kernel.org, david@redhat.com,
        rdunlap@infradead.org, chenlinxuan@uniontech.com,
        yang.yang29@zte.com.cn, souravpanda@google.com,
        tomas.mudrunka@gmail.com, bhelgaas@google.com, ivan@cloudflare.com,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        hannes@cmpxchg.org, shakeelb@google.com,
        kirill.shutemov@linux.intel.com, wangkefeng.wang@huawei.com,
        adobriyan@gmail.com, vbabka@suse.cz, Liam.Howlett@Oracle.com,
        surenb@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!

This patch adds a new per-node PageMetadata field to
/sys/devices/system/node/nodeN/meminfo and a global PageMetadata field
to /proc/meminfo. This information can be used by users to see how much
memory is being used by per-page metadata, which can vary depending on
build configuration, machine architecture, and system use.

Per-page metadata is the amount of memory that Linux needs in order to
manage memory at the page granularity. The majority of such memory is
used by "struct page" and "page_ext" data structures.


Background
----------

Kernel overhead observability is missing some of the largest
allocations during runtime, including vmemmap (struct pages) and
page_ext. This patch aims to address this problem by exporting a
new metric PageMetadata.

On the contrary, the kernel does provide observibility for boot memory
allocations. For example, the metric reserved_pages depicts the pages
allocated by the bootmem allocator. This can be simply calculated as
present_pages - managed_pages, which are both exported in /proc/zoneinfo.
The metric reserved_pages is primarily composed of struct pages and
page_ext.

What about the struct pages (allocated by bootmem allocator) that are
free'd during hugetlbfs allocations and then allocated by buddy-allocator
once hugtlbfs pages are free'd?

/proc/meminfo MemTotal changes: MemTotal does not include memblock
allocations but includes buddy allocations. However, during runtime
memblock allocations can be shifted into buddy allocations, and therefore
become part of MemTotal.

Once the struct pages get allocated by buddy allocator, we lose track of
these struct page allocations overhead accounting. Therefore, we must
export a new metric that we shall refer to as PageMetadata (exported by
node). This shall also comprise the struct page and page_ext allocations
made during runtime.

Results and analysis
--------------------

Memory model: Sparsemem-vmemmap
$ echo 1 > /proc/sys/vm/hugetlb_optimize_vmemmap

$ cat /proc/meminfo | grep MemTotal
	MemTotal:       32918196 kB
$ cat /proc/meminfo | grep Meta
	PageMetadata:     589824 kB
$ cat /sys/devices/system/node/node0/meminfo | grep Meta
	Node 0 PageMetadata:     294912 kB
$ cat /sys/devices/system/node/node1/meminfo | grep Meta
	Node 1 PageMetadata:     294912 kB


AFTER HUGTLBFS RESERVATION
$ echo 512 > /proc/sys/vm/nr_hugepages

$ cat /proc/meminfo | grep MemTotal

MemTotal:       32934580 kB
$ cat /proc/meminfo | grep Meta
PageMetadata:     575488 kB
$ cat /sys/devices/system/node/node0/meminfo | grep Meta
Node 0 PageMetadata:     287744 kB
$ cat /sys/devices/system/node/node1/meminfo | grep Meta
Node 1 PageMetadata:     287744 kB

AFTER FREEING HUGTLBFS RESERVATION
$ echo 0 > /proc/sys/vm/nr_hugepages
$ cat /proc/meminfo | grep MemTotal
MemTotal:       32934580 kB
$ cat /proc/meminfo | grep Meta
PageMetadata:    589824 kB
$ cat /sys/devices/system/node/node0/meminfo | grep Meta
Node 0 PageMetadata:       294912 kB
$ cat /sys/devices/system/node/node1/meminfo | grep Meta
Node 1 PageMetadata:       294912 kB

Sourav Panda (1):
  mm: report per-page metadata information

 Documentation/filesystems/proc.rst |  3 +++
 drivers/base/node.c                |  2 ++
 fs/proc/meminfo.c                  |  7 +++++++
 include/linux/mmzone.h             |  3 +++
 include/linux/vmstat.h             |  4 ++++
 mm/hugetlb.c                       |  8 +++++++-
 mm/hugetlb_vmemmap.c               |  9 ++++++++-
 mm/mm_init.c                       |  3 +++
 mm/page_alloc.c                    |  1 +
 mm/page_ext.c                      | 17 +++++++++++++----
 mm/sparse-vmemmap.c                |  3 +++
 mm/sparse.c                        |  7 ++++++-
 mm/vmstat.c                        | 21 +++++++++++++++++++++
 13 files changed, 81 insertions(+), 7 deletions(-)

-- 
2.42.0.283.g2d96d420d3-goog

