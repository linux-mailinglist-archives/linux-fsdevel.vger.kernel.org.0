Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B230D6A261F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjBYBPl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjBYBPj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:15:39 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287FE125AF
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:15:36 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id bh20so790765oib.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VEsTdN2rF0N9vVrFfNBWGDyTlCKQ7Vl91wkVO7FOQZc=;
        b=fob0BJ7A4FYEUYjznijllko3m6s5dAzVaKs4zDSHAn+Lwdt3bAaflxujZLQOmZ+tQo
         F5d8MKE9QkQrWnw+W/OZdBcCD8pYul2ppjzeWK1QjUmARZBXnKxsXvlGL2Vlhq9cBfHp
         kSidnFiFnCyTzLcx0hi1nxqM82g8nQLo3NDnExy+VNTjbMKl7UjjnzF9HRmnon6ygcCg
         QztvFReoUP1Jq5rRaer/ZqSzdGDuFZqPrZse++C56iyUFYx6nIKo8GQqEcNKACVg4ZSQ
         VSf/vGkg3af7zDlTrSNxsuR+ouXknpzRPcJ5M8AzvgQutctgKUSbZWGUkGlXL8TeJqfD
         6s8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VEsTdN2rF0N9vVrFfNBWGDyTlCKQ7Vl91wkVO7FOQZc=;
        b=n/aerAWb6VGJD22EqGke0xS2/eYIuOBFP9AQWDy7tlb24TkEQoWAm7DJEtMIWr/A/u
         bPVzxHyu8at9i4kI6KWZni6cg9KcN3TNbjjN/fpl8qmSegOxmxOxQ3fOG7KV+1uVavuS
         qii9rzcQMVKxpYkjVLGy4bbey72j/nYyDUPqgOapMVFMAhs1WkysIGi61ceT7DH9yDEZ
         wJdNF4W+hqy0k4DXuQvti3v7/U9iSN6ODRxcrMZF6fX34em6aMMiYEMvSNIceUAzRJRF
         ghm0h2Y49J6uKfRZIqW+qeJU7wnj/+DyxR8rS0lhKmqA7TYZr3jK4ljt/ssp0JnsZ7sg
         iEtg==
X-Gm-Message-State: AO0yUKU/6wnBLkG/KWHvq2arGTyWKq9tUW3wrINFq5MlHlC8m8PI2gV1
        YInX1rU6gE/jSNThlhUGIBdMVYnCOj1ehlE9
X-Google-Smtp-Source: AK7set9KSPzZ+afJ9gJ8Q6Y5PeXiZjhPtHofNYYZ5MpQMFoKQYmE0F3hXfg1SItCmJjFUjbKSf5eZQ==
X-Received: by 2002:a05:6808:2895:b0:37d:5743:3e89 with SMTP id eu21-20020a056808289500b0037d57433e89mr4521277oib.49.1677287734164;
        Fri, 24 Feb 2023 17:15:34 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:15:33 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 00/76] SSDFS: flash-friendly LFS file system for ZNS SSD
Date:   Fri, 24 Feb 2023 17:08:11 -0800
Message-Id: <20230225010927.813929-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

I am completely aware that patchset is big. And I am opened for any
advices how I can split the patchset on reasonable portions with
the goal to introduce SSDFS for the review. Even now, I excluded
the code of several subsystems to make the patchset slightly
smaller. Potentially, I can introduce SSDFS by smaller portions
with limited fucntionality. However, it can confuse and makes it
hard to understand how declared goals are achieved by implemented
functionality. SSDFS is still not completely stable but I believe that
it's time to hear the community opinion.

[PROBLEM DECLARATION]

SSD is a sophisticated device capable of managing in-place
updates. However, in-place updates generate significant FTL GC
responsibilities that increase write amplification factor, require
substantial NAND flash overprovisioning, decrease SSD lifetime,
and introduce performance spikes. Log-structured File System (LFS)
approach can introduce a more flash-friendly Copy-On-Write (COW) model.
However, F2FS and NILFS2 issue in-place updates anyway, even by using
the COW policy for main volume area. Also, GC is an inevitable subsystem
of any LFS file system that introduces write amplification, retention
issue, excessive copy operations, and performance degradation for
aged volume. Generally speaking, available file system technologies
have side effects: (1) write amplification issue, (2) significant FTL GC
responsibilities, (3) inevitable FS GC overhead, (4) read disturbance,
(5) retention issue. As a result, SSD lifetime reduction, perfomance
degradation, early SSD failure, and increased TCO cost are reality of
data infrastructure.

[WHY YET ANOTHER FS?]

ZNS SSD is a good vehicle that can help to manage a subset of known
issues by means of introducing a strict append-only mode of operations.
However, for example, F2FS has an in-place update metadata area that
can be placed into conventional zone and, anyway, introduces FTL GC
responsibilities even for ZNS SSD case. Also, limited number of
open/active zones (for example, 14 open/active zones) creates really
complicated requirements that not every file system architecure can
satisfy. It means that architecture of multiple file systems has
peculiarities compromising the ZNS SSD model. Moreover, FS GC overhead is
still a critical problem for LFS file systems (F2FS, NILFS2, for example),
even for the case of ZNS SSD.

Generally speaking, it will be good to see an LFS file system architecture
that is capable:
(1) eliminate FS GC overhead,
(2) decrease/eliminate FTL GC responsibilities,
(3) decrease write amplification factor,
(4) introduce native architectural support of ZNS SSD + SMR HDD,
(5) increase compression ratio by using delta-encoding and deduplication,
(6) introduce smart management of "cold" data and efficient TRIM policy,
(7) employ parallelism of multiple NAND dies/channels,
(8) prolong SSD lifetime and decrease TCO cost,
(9) guarantee strong reliability and capability to reconstruct heavily
    corrupted file system volume,
(10) guarantee stable performance.

[SSDFS DESIGN GOALS]

SSDFS is an open-source, kernel-space LFS file system designed:
(1) eliminate GC overhead, (2) prolong SSD lifetime, (3) natively support
a strict append-only mode (ZNS SSD + SMR HDD compatible), (4) guarantee
strong reliability, (5) guarantee stable performance.

[SSDFS ARCHITECTURE]

One of the key goals of SSDFS is to decrease the write amplification
factor. Logical extent concept is the fundamental technique to achieve
the goal. Logical extent describes any volume extent on the basis of
{segment ID, logical block ID, and length}. Segment is a portion of
file system volume that has to be aligned on erase block size and
always located at the same offset. It is basic unit to allocate and
to manage free space of file system volume. Every segment can include
one or several Logical Erase Blocks (LEB). LEB can be mapped into
"Physical" Erase Block (PEB). Generally speaking, PEB is fixed-sized
container that includes a number of logical blocks (physical sectors
or NAND flash pages). SSDFS is pure Log-structured File System (LFS).
It means that any write operation into erase block is the creation of
log. Content of every erase block is a sequence of logs. PEB has block
bitmap with the goal of tracking the state (free, pre-allocated,
allocated, invalid) of logical blocks and to account the physical space
is used for storing log's metadata (segment header, partial log header,
footer). Also, log contains an offset translation table that converts
logical block ID into particular offset inside of log's payload.
Log concept implements a support of compression, delta-encoding,
and compaction scheme. As a result, it provides the way: (1) decrease
write amplification, (2) decrease FTL GC responsibilities, (3) improve
compression ration and decrease payload size. Finally, SSD lifetime
can be longer and write I/O performance can be improved.

SSDFS file system is based on the concept of logical segment that
is the aggregation of Logical Erase Blocks (LEB). Moreover, initially,
LEB hasn’t association with a particular "Physical" Erase Block (PEB).
It means that segment could have the association not for all LEBs or,
even, to have no association at all with any PEB (for example, in the
case of clean segment). Generally speaking, SSDFS file system needs
a special metadata structure (PEB mapping table) that is capable of
associating any LEB with any PEB. The PEB mapping table is the crucial
metadata structure that has several goals: (1) mapping LEB to PEB,
(2) implementation of the logical extent concept, (3) implementation of
the concept of PEB migration, (4) implementation of the delayed erase
operation by specialized thread.

SSDFS implements a migration scheme. Migration scheme is a fundamental
technique of GC overhead management. The key responsibility of the
migration scheme is to guarantee the presence of data in the same segment
for any update operations. Generally speaking, the migration scheme’s model
is implemented on the basis of association an exhausted "Physical" Erase
Block (PEB) with a clean one. The goal of such association of two PEBs is
to implement the gradual migration of data by means of the update
operations in the initial (exhausted) PEB. As a result, the old, exhausted
PEB becomes invalidated after complete data migration and it will be
possible to apply the erase operation to convert it to a clean state.
The migration scheme is capable of decreasing GC activity significantly
by means of excluding the necessity to update metadata and by means of
self-migration of data between PEBs is triggered by regular update
operations. Finally, migration scheme can: (1) eliminate GC overhead,
(2) implement efficient TRIM policy, (3) prolong SDD lifetime,
(4) guarantee stable performance.

Generally speaking, SSDFS doesn't need a classical model of garbage
collection that is used in NILFS2 or F2FS. However, SSDFS has several
global GC threads (dirty, pre-dirty, used, using segment states) and
segment bitmap. The main responsibility of global GC threads is:
(1) find segment in a particular state, (2) check that segment object
is constructed and initialized by file system driver logic,
(3) check the necessity to stimulate or finish the migration
(if segment is under update operations or has update operations
recently, then migration stimulation is not necessary),
(4) define valid blocks that require migration, (5) add recommended
migration request to PEB update queue, (6) destroy in-core segment
object if no migration is necessary and no create/update requests
have been received by segment object recently. Global GC threads are
used to recommend migration stimulation for particular PEBs and
to destroy in-core segment objects that have no requests for
processing. Segment bitmap is the critical metadata structure of
SSDFS file system that implements several goals: (1) searching for
a candidate for a current segment capable of storing new data,
(2) searching by GC subsystem for the most optimal segment (dirty
state, for example) with the goal of preparing the segment in
background for storing new data (converting in a clean state).

SSDFS file system uses b-tree architecture for metadata representation
(for example, inodes tree, extents tree, dentries tree, xattr tree)
because it provides the compact way of reserving the metadata space
without the necessity to use the excessive overprovisioning of
metadata reservation (for example, in the case of plain table or array).
SSDFS file system uses a hybrid b-tree architecture with the goal
to eliminate the index nodes’ side effect. The hybrid b-tree operates by
three node types: (1) index node, (2) hybrid node, (3) leaf node.
Generally speaking, the peculiarity of hybrid node is the mixture
as index as data records into one node. Hybrid b-tree starts with
root node that is capable to keep the two index records or two data
records inline (if size of data record is equal or lesser than size
of index record). If the b-tree needs to contain more than two items
then it should be added the first hybrid node into the b-tree.
The root level of b-tree is able to contain only two nodes because
the root node is capable to store only two index records. Generally speaking,
the initial goal of hybrid node is to store the data records in
the presence of reserved index area. B-tree implements compact and
flexible metadata structure that can decrease payload size and
isolate hot, warm, and cold metadata types in different erase blocks.

Migration scheme is completely enough for the case of conventional SSDs
as for metadata as for user data. But ZNS SSD has huge zone size and
limited number of active/open zones. As a result, it requires introducing
a moving scheme for user data in the case of ZNS SSD. Finally, migration
scheme works for metadata and moving scheme works for user data
(ZNS SSD case). Initially, user data can be stored into current user
data segment/zone. And user data can be updated at the same zone until
exhaustion. Next, moving scheme starts to work. Updated user data is moved
into current user data zone for updates. As a result, it needs to update
the extents tree and to store invalidated extents of old zone into
invalidated extents tree. Invalidated extents tree needs to track
the moment when the old zone is completely invalidated and is ready
to be erased.

[BENCHMARKING]

Benchmarking results show that SSDFS is capable:
(1) generate smaller amount of write I/O requests compared with:
    1.4x - 116x (ext4),
    14x - 42x (xfs),
    6.2x - 9.8x (btrfs),
    1.5x - 41x (f2fs),
    0.6x - 22x (nilfs2);
(2) create smaller payload compared with:
    0.3x - 300x (ext4),
    0.3x - 190x (xfs),
    0.7x - 400x (btrfs),
    1.2x - 400x (f2fs),
    0.9x - 190x (nilfs2);
(3) decrease the write amplification factor compared with:
    1.3x - 116x (ext4),
    14x - 42x (xfs),
    6x - 9x (btrfs),
    1.5x - 50x (f2fs),
    1.2x - 20x (nilfs2);
(4) prolong SSD lifetime compared with:
    1.4x - 7.8x (ext4),
    15x - 60x (xfs),
    6x - 12x (btrfs),
    1.5x - 7x (f2fs),
    1x - 4.6x (nilfs2).

[CURRENT ISSUES]

Patchset does not include:
(1) shared dictionary functionality (implemented),
(2) deduplication functionality (partially implemented),
(3) snapshot support functionality (partially implemented),
(4) extended attributes support (implemented),
(5) internal unit-tests functionality (implemented),
(6) IOCTLs support (implemented).

SSDFS code still has bugs and is not fully stable yet:
(1) ZNS support is not fully stable;
(2) b-tree operations have issues for some use-cases;
(3) Support of 8K, 16K, 32K logical blocks has critical bugs;
(4) Support of multiple PEBs in segment is not stable yet;
(5) Delta-encoding support is not stable;
(6) The fsck and recoverfs tools are not fully implemented yet;
(7) Currently, offset translation table functionality introduces
    performance degradation for read I/O patch (patch with the fix is
    under testing).

[REFERENCES]
[1] SSDFS tools: https://github.com/dubeyko/ssdfs-tools.git
[2] SSDFS driver: https://github.com/dubeyko/ssdfs-driver.git
[3] Linux kernel with SSDFS support: https://github.com/dubeyko/linux.git
[4] SSDFS (paper): https://arxiv.org/abs/1907.11825
[5] Linux Plumbers 2022: https://www.youtube.com/watch?v=sBGddJBHsIo

Viacheslav Dubeyko (76):
  ssdfs: introduce SSDFS on-disk layout
  ssdfs: key file system declarations
  ssdfs: implement raw device operations
  ssdfs: implement super operations
  ssdfs: implement commit superblock operation
  ssdfs: segment header + log footer operations
  ssdfs: basic mount logic implementation
  ssdfs: search last actual superblock
  ssdfs: internal array/sequence primitives
  ssdfs: introduce PEB's block bitmap
  ssdfs: block bitmap search operations implementation
  ssdfs: block bitmap modification operations implementation
  ssdfs: introduce PEB block bitmap
  ssdfs: PEB block bitmap modification operations
  ssdfs: introduce segment block bitmap
  ssdfs: introduce segment request queue
  ssdfs: introduce offset translation table
  ssdfs: flush offset translation table
  ssdfs: offset translation table API implementation
  ssdfs: introduce PEB object
  ssdfs: introduce PEB container
  ssdfs: create/destroy PEB container
  ssdfs: PEB container API implementation
  ssdfs: PEB read thread's init logic
  ssdfs: block bitmap initialization logic
  ssdfs: offset translation table initialization logic
  ssdfs: read/readahead logic of PEB's thread
  ssdfs: PEB flush thread's finite state machine
  ssdfs: commit log logic
  ssdfs: commit log payload
  ssdfs: process update request
  ssdfs: process create request
  ssdfs: create log logic
  ssdfs: auxilairy GC threads logic
  ssdfs: introduce segment object
  ssdfs: segment object's add data/metadata operations
  ssdfs: segment object's update/invalidate data/metadata
  ssdfs: introduce PEB mapping table
  ssdfs: flush PEB mapping table
  ssdfs: convert/map LEB to PEB functionality
  ssdfs: support migration scheme by PEB state
  ssdfs: PEB mapping table thread logic
  ssdfs: introduce PEB mapping table cache
  ssdfs: PEB mapping table cache's modification operations
  ssdfs: introduce segment bitmap
  ssdfs: segment bitmap API implementation
  ssdfs: introduce b-tree object
  ssdfs: add/delete b-tree node
  ssdfs: b-tree API implementation
  ssdfs: introduce b-tree node object
  ssdfs: flush b-tree node object
  ssdfs: b-tree node index operations
  ssdfs: search/allocate/insert b-tree node operations
  ssdfs: change/delete b-tree node operations
  ssdfs: range operations of b-tree node
  ssdfs: introduce b-tree hierarchy object
  ssdfs: check b-tree hierarchy for add operation
  ssdfs: check b-tree hierarchy for update/delete operation
  ssdfs: execute b-tree hierarchy modification
  ssdfs: introduce inodes b-tree
  ssdfs: inodes b-tree node operations
  ssdfs: introduce dentries b-tree
  ssdfs: dentries b-tree specialized operations
  ssdfs: dentries b-tree node's specialized operations
  ssdfs: introduce extents queue object
  ssdfs: introduce extents b-tree
  ssdfs: extents b-tree specialized operations
  ssdfs: search extent logic in extents b-tree node
  ssdfs: add/change/delete extent in extents b-tree node
  ssdfs: introduce invalidated extents b-tree
  ssdfs: find item in invalidated extents b-tree
  ssdfs: modification operations of invalidated extents b-tree
  ssdfs: implement inode operations support
  ssdfs: implement directory operations support
  ssdfs: implement file operations support
  introduce SSDFS file system

 fs/Kconfig                          |     1 +
 fs/Makefile                         |     1 +
 fs/ssdfs/Kconfig                    |   300 +
 fs/ssdfs/Makefile                   |    50 +
 fs/ssdfs/block_bitmap.c             |  5313 ++++++++
 fs/ssdfs/block_bitmap.h             |   370 +
 fs/ssdfs/block_bitmap_tables.c      |   310 +
 fs/ssdfs/btree.c                    |  7787 ++++++++++++
 fs/ssdfs/btree.h                    |   218 +
 fs/ssdfs/btree_hierarchy.c          |  9420 ++++++++++++++
 fs/ssdfs/btree_hierarchy.h          |   284 +
 fs/ssdfs/btree_node.c               | 16928 ++++++++++++++++++++++++++
 fs/ssdfs/btree_node.h               |   768 ++
 fs/ssdfs/btree_search.c             |   885 ++
 fs/ssdfs/btree_search.h             |   359 +
 fs/ssdfs/compr_lzo.c                |   256 +
 fs/ssdfs/compr_zlib.c               |   359 +
 fs/ssdfs/compression.c              |   548 +
 fs/ssdfs/compression.h              |   104 +
 fs/ssdfs/current_segment.c          |   682 ++
 fs/ssdfs/current_segment.h          |    76 +
 fs/ssdfs/dentries_tree.c            |  9726 +++++++++++++++
 fs/ssdfs/dentries_tree.h            |   156 +
 fs/ssdfs/dev_bdev.c                 |  1187 ++
 fs/ssdfs/dev_mtd.c                  |   641 +
 fs/ssdfs/dev_zns.c                  |  1281 ++
 fs/ssdfs/dir.c                      |  2071 ++++
 fs/ssdfs/dynamic_array.c            |   781 ++
 fs/ssdfs/dynamic_array.h            |    96 +
 fs/ssdfs/extents_queue.c            |  1723 +++
 fs/ssdfs/extents_queue.h            |   105 +
 fs/ssdfs/extents_tree.c             | 13060 ++++++++++++++++++++
 fs/ssdfs/extents_tree.h             |   171 +
 fs/ssdfs/file.c                     |  2523 ++++
 fs/ssdfs/fs_error.c                 |   257 +
 fs/ssdfs/inode.c                    |  1190 ++
 fs/ssdfs/inodes_tree.c              |  5534 +++++++++
 fs/ssdfs/inodes_tree.h              |   177 +
 fs/ssdfs/invalidated_extents_tree.c |  7063 +++++++++++
 fs/ssdfs/invalidated_extents_tree.h |    95 +
 fs/ssdfs/log_footer.c               |   901 ++
 fs/ssdfs/offset_translation_table.c |  8160 +++++++++++++
 fs/ssdfs/offset_translation_table.h |   446 +
 fs/ssdfs/options.c                  |   190 +
 fs/ssdfs/page_array.c               |  1746 +++
 fs/ssdfs/page_array.h               |   119 +
 fs/ssdfs/page_vector.c              |   437 +
 fs/ssdfs/page_vector.h              |    64 +
 fs/ssdfs/peb.c                      |   813 ++
 fs/ssdfs/peb.h                      |   970 ++
 fs/ssdfs/peb_block_bitmap.c         |  3958 ++++++
 fs/ssdfs/peb_block_bitmap.h         |   165 +
 fs/ssdfs/peb_container.c            |  5649 +++++++++
 fs/ssdfs/peb_container.h            |   291 +
 fs/ssdfs/peb_flush_thread.c         | 16856 +++++++++++++++++++++++++
 fs/ssdfs/peb_gc_thread.c            |  2953 +++++
 fs/ssdfs/peb_mapping_queue.c        |   334 +
 fs/ssdfs/peb_mapping_queue.h        |    67 +
 fs/ssdfs/peb_mapping_table.c        | 12706 +++++++++++++++++++
 fs/ssdfs/peb_mapping_table.h        |   699 ++
 fs/ssdfs/peb_mapping_table_cache.c  |  4702 +++++++
 fs/ssdfs/peb_mapping_table_cache.h  |   119 +
 fs/ssdfs/peb_mapping_table_thread.c |  2817 +++++
 fs/ssdfs/peb_migration_scheme.c     |  1302 ++
 fs/ssdfs/peb_read_thread.c          | 10672 ++++++++++++++++
 fs/ssdfs/readwrite.c                |   651 +
 fs/ssdfs/recovery.c                 |  3144 +++++
 fs/ssdfs/recovery.h                 |   446 +
 fs/ssdfs/recovery_fast_search.c     |  1194 ++
 fs/ssdfs/recovery_slow_search.c     |   585 +
 fs/ssdfs/recovery_thread.c          |  1196 ++
 fs/ssdfs/request_queue.c            |  1240 ++
 fs/ssdfs/request_queue.h            |   417 +
 fs/ssdfs/segment.c                  |  5262 ++++++++
 fs/ssdfs/segment.h                  |   957 ++
 fs/ssdfs/segment_bitmap.c           |  4821 ++++++++
 fs/ssdfs/segment_bitmap.h           |   459 +
 fs/ssdfs/segment_bitmap_tables.c    |   814 ++
 fs/ssdfs/segment_block_bitmap.c     |  1425 +++
 fs/ssdfs/segment_block_bitmap.h     |   205 +
 fs/ssdfs/segment_tree.c             |   748 ++
 fs/ssdfs/segment_tree.h             |    66 +
 fs/ssdfs/sequence_array.c           |   639 +
 fs/ssdfs/sequence_array.h           |   119 +
 fs/ssdfs/ssdfs.h                    |   411 +
 fs/ssdfs/ssdfs_constants.h          |    81 +
 fs/ssdfs/ssdfs_fs_info.h            |   412 +
 fs/ssdfs/ssdfs_inline.h             |  1346 ++
 fs/ssdfs/ssdfs_inode_info.h         |   143 +
 fs/ssdfs/ssdfs_thread_info.h        |    42 +
 fs/ssdfs/super.c                    |  4044 ++++++
 fs/ssdfs/version.h                  |     7 +
 fs/ssdfs/volume_header.c            |  1256 ++
 include/linux/ssdfs_fs.h            |  3468 ++++++
 include/trace/events/ssdfs.h        |   255 +
 include/uapi/linux/magic.h          |     1 +
 include/uapi/linux/ssdfs_fs.h       |   117 +
 97 files changed, 205963 insertions(+)
 create mode 100644 fs/ssdfs/Kconfig
 create mode 100644 fs/ssdfs/Makefile
 create mode 100644 fs/ssdfs/block_bitmap.c
 create mode 100644 fs/ssdfs/block_bitmap.h
 create mode 100644 fs/ssdfs/block_bitmap_tables.c
 create mode 100644 fs/ssdfs/btree.c
 create mode 100644 fs/ssdfs/btree.h
 create mode 100644 fs/ssdfs/btree_hierarchy.c
 create mode 100644 fs/ssdfs/btree_hierarchy.h
 create mode 100644 fs/ssdfs/btree_node.c
 create mode 100644 fs/ssdfs/btree_node.h
 create mode 100644 fs/ssdfs/btree_search.c
 create mode 100644 fs/ssdfs/btree_search.h
 create mode 100644 fs/ssdfs/compr_lzo.c
 create mode 100644 fs/ssdfs/compr_zlib.c
 create mode 100644 fs/ssdfs/compression.c
 create mode 100644 fs/ssdfs/compression.h
 create mode 100644 fs/ssdfs/current_segment.c
 create mode 100644 fs/ssdfs/current_segment.h
 create mode 100644 fs/ssdfs/dentries_tree.c
 create mode 100644 fs/ssdfs/dentries_tree.h
 create mode 100644 fs/ssdfs/dev_bdev.c
 create mode 100644 fs/ssdfs/dev_mtd.c
 create mode 100644 fs/ssdfs/dev_zns.c
 create mode 100644 fs/ssdfs/dir.c
 create mode 100644 fs/ssdfs/dynamic_array.c
 create mode 100644 fs/ssdfs/dynamic_array.h
 create mode 100644 fs/ssdfs/extents_queue.c
 create mode 100644 fs/ssdfs/extents_queue.h
 create mode 100644 fs/ssdfs/extents_tree.c
 create mode 100644 fs/ssdfs/extents_tree.h
 create mode 100644 fs/ssdfs/file.c
 create mode 100644 fs/ssdfs/fs_error.c
 create mode 100644 fs/ssdfs/inode.c
 create mode 100644 fs/ssdfs/inodes_tree.c
 create mode 100644 fs/ssdfs/inodes_tree.h
 create mode 100644 fs/ssdfs/invalidated_extents_tree.c
 create mode 100644 fs/ssdfs/invalidated_extents_tree.h
 create mode 100644 fs/ssdfs/log_footer.c
 create mode 100644 fs/ssdfs/offset_translation_table.c
 create mode 100644 fs/ssdfs/offset_translation_table.h
 create mode 100644 fs/ssdfs/options.c
 create mode 100644 fs/ssdfs/page_array.c
 create mode 100644 fs/ssdfs/page_array.h
 create mode 100644 fs/ssdfs/page_vector.c
 create mode 100644 fs/ssdfs/page_vector.h
 create mode 100644 fs/ssdfs/peb.c
 create mode 100644 fs/ssdfs/peb.h
 create mode 100644 fs/ssdfs/peb_block_bitmap.c
 create mode 100644 fs/ssdfs/peb_block_bitmap.h
 create mode 100644 fs/ssdfs/peb_container.c
 create mode 100644 fs/ssdfs/peb_container.h
 create mode 100644 fs/ssdfs/peb_flush_thread.c
 create mode 100644 fs/ssdfs/peb_gc_thread.c
 create mode 100644 fs/ssdfs/peb_mapping_queue.c
 create mode 100644 fs/ssdfs/peb_mapping_queue.h
 create mode 100644 fs/ssdfs/peb_mapping_table.c
 create mode 100644 fs/ssdfs/peb_mapping_table.h
 create mode 100644 fs/ssdfs/peb_mapping_table_cache.c
 create mode 100644 fs/ssdfs/peb_mapping_table_cache.h
 create mode 100644 fs/ssdfs/peb_mapping_table_thread.c
 create mode 100644 fs/ssdfs/peb_migration_scheme.c
 create mode 100644 fs/ssdfs/peb_read_thread.c
 create mode 100644 fs/ssdfs/readwrite.c
 create mode 100644 fs/ssdfs/recovery.c
 create mode 100644 fs/ssdfs/recovery.h
 create mode 100644 fs/ssdfs/recovery_fast_search.c
 create mode 100644 fs/ssdfs/recovery_slow_search.c
 create mode 100644 fs/ssdfs/recovery_thread.c
 create mode 100644 fs/ssdfs/request_queue.c
 create mode 100644 fs/ssdfs/request_queue.h
 create mode 100644 fs/ssdfs/segment.c
 create mode 100644 fs/ssdfs/segment.h
 create mode 100644 fs/ssdfs/segment_bitmap.c
 create mode 100644 fs/ssdfs/segment_bitmap.h
 create mode 100644 fs/ssdfs/segment_bitmap_tables.c
 create mode 100644 fs/ssdfs/segment_block_bitmap.c
 create mode 100644 fs/ssdfs/segment_block_bitmap.h
 create mode 100644 fs/ssdfs/segment_tree.c
 create mode 100644 fs/ssdfs/segment_tree.h
 create mode 100644 fs/ssdfs/sequence_array.c
 create mode 100644 fs/ssdfs/sequence_array.h
 create mode 100644 fs/ssdfs/ssdfs.h
 create mode 100644 fs/ssdfs/ssdfs_constants.h
 create mode 100644 fs/ssdfs/ssdfs_fs_info.h
 create mode 100644 fs/ssdfs/ssdfs_inline.h
 create mode 100644 fs/ssdfs/ssdfs_inode_info.h
 create mode 100644 fs/ssdfs/ssdfs_thread_info.h
 create mode 100644 fs/ssdfs/super.c
 create mode 100644 fs/ssdfs/version.h
 create mode 100644 fs/ssdfs/volume_header.c
 create mode 100644 include/linux/ssdfs_fs.h
 create mode 100644 include/trace/events/ssdfs.h
 create mode 100644 include/uapi/linux/ssdfs_fs.h

-- 
2.34.1

