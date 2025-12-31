Return-Path: <linux-fsdevel+bounces-72280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97934CEBA8E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 10:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C88F308FAEB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 09:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0551231961D;
	Wed, 31 Dec 2025 09:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="rVhY4R4z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D184C3191A8;
	Wed, 31 Dec 2025 09:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767172449; cv=none; b=QZO+XIo37Oyehslg3H61X7zQ97G11EpuHemX+WEEGzk7uds1vpmhYOzZfGrpWNR/7oyEJkErak4C+G1jFQdedgp6PKZS2k9rCV275STQAbUt890+gUCZlYO9wLCP1Um1uNT6BmxlO3uA9hjC1FP19kFWSvgM1BlYzUEWoYeYLps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767172449; c=relaxed/simple;
	bh=ATBDW5l+vg9TgquZPdYwLWjo5kYyy3eql3LMmeXeg1M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DzOZOIJ1sOPcfw3G/kYVPyMkmjfqZBTsY3gKXheb+PssEh850tdXdCPL8IepVYDitE2kU0WAWw5oQshCDHFIUousC9eKpVhUDLXz38qO/3uxcCtrrCx0vPZK/GsNhfBAdQP0IFHjHz/9kplQDW0jwTutcFJcjT/9mWozvkumOsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=rVhY4R4z; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=xdDMJ2GRkuuSvFRXHDommFRQNutw+jFR8PabQdXdnHY=;
	b=rVhY4R4zh5IV9fwUfR4HpEJWDFqMjdoNUG3DhIU32CTMF7kTFhBLE8Rf5gILrYhkUyJ2s6e45
	qvCoRQ5d2psNpMnE4UoQbGGLdxIxE1t95uK0kxBY+ok6XdDWaZdSrNuls3PkosSIwtHHwWGIW4f
	r8o3MxDhUkX7JIFt2o4kB3s=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4dh41f41y7zRhR8;
	Wed, 31 Dec 2025 17:10:46 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 0B3BB40608;
	Wed, 31 Dec 2025 17:13:58 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 31 Dec
 2025 17:13:57 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>
CC: <djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>,
	<lihongbo22@huawei.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 00/10] erofs: Introduce page cache sharing feature
Date: Wed, 31 Dec 2025 09:01:08 +0000
Message-ID: <20251231090118.541061-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr500015.china.huawei.com (7.202.195.162)

Enabling page cahe sharing in container scenarios has become increasingly
crucial, as it can significantly reduce memory usage. In previous efforts,
Hongzhen has done substantial work to push this feature into the EROFS
mainline. Due to other commitments, he hasn't been able to continue his
work recently, and I'm very pleased to build upon his work and continue
to refine this implementation.

This patch series is based on Hongzhen's original EROFS shared pagecache
implementation which was posted about half a year ago:
https://lore.kernel.org/all/20250301145002.2420830-1-hongzhen@linux.alibaba.com/T/#u

I have already made several iterations based on this patch set, resolving
some issues in the code and some pre-requisites.

(A recap of Hongzhen's original cover letter is below, edited slightly
for this serise:)

Background
==============
Currently, reading files with different paths (or names) but the same
content can consume multiple copies of the page cache, even if the
content of these caches is identical. For example, reading identical
files (e.g., *.so files) from two different minor versions of container
images can result in multiple copies of the same page cache, since
different containers have different mount points. Therefore, sharing
the page cache for files with the same content can save memory.

Proposal
==============

1. determining file identity
----------------------------
First, a way needs to be found to check whether the content of two files
is the same. Here, the xattr values associated with the file
fingerprints are assessed for consistency. When creating the EROFS
image, users can specify the name of the xattr for file fingerprints,
and the corresponding name will be stored in the packfile. The on-disk
`ishare_key_start` indicates the index of the xattr name within the
prefix xattrs:

```
struct erofs_super_block {
	__u8 xattr_filter_reserved; /* reserved for xattr name filter */
-	__u8 reserved[3];
+	__u8 ishare_xattr_prefix_id;
+	__u8 reserved[2];
};
```

For example, users can specify the first long prefix as the name for the
file fingerprint as follows:

```
mkfs.erofs --xattr-inode-digest=trusted.erofs.fingerprint [-zlz4hc] foo.erofs foo/
```

In this way, `trusted.erofs.fingerprint` serves as the name of the xattr
for the file fingerprint. The relevant patch has been supported in erofs-utils
experimental branch:

```
git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git -b experimental
```

At the same time, we introduce a new mount option which is inode_share to
enable the feature. For security reasons, we allow sharing page cache only
within the same domain by adding "-o domain_id=xxxx" during the mounting
process:

```
mount -t erofs -o inode_share,domain_id=your_shared_domain_id erofs.img /mnt
```

If no domain ID is specified, it will share page cache in default none domain.

2. Implementation
==================

2.1. file open & close
----------------------
When the file is opened, the ->private_data field of file A or file B is
set to point to an internal deduplicated file. When the actual read
occurs, the page cache of this deduplicated file will be accessed.

When the file is opened, if the corresponding erofs inode is newly
created, then perform the following actions:
1. add the erofs inode to the backing list of the deduplicated inode;
2. increase the reference count of the deduplicated inode.

The purpose of step 1 above is to ensure that when a real I/O operation
occurs, the deduplicated inode can locate one of the disk devices
(as the deduplicated inode itself is not bound to a specific device).
Step 2 is for managing the lifecycle of the deduplicated inode.

When the erofs inode is destroyed, the opposite actions mentioned above
will be taken.

2.2. file reading
-----------------
Assuming the deduplication inode's page cache is PGCache_dedup, there
are two possible scenarios when reading a file:
1) the content being read is already present in PGCache_dedup;
2) the content being read is not present in PGCache_dedup.

In the second scenario, it involves the iomap operation to read from the
disk.

2.2.1. reading existing data in PGCache_dedup
-------------------------------------------
In this case, the overall read flowchart is as follows (take ksys_read()
for example):

         ksys_read
             │
             │
             ▼
            ...
             │
             │
             ▼
erofs_ishare_file_read_iter (switch to backing deduplicated file)
             │
             │
             ▼

 read PGCache_dedup & return

At this point, the content in PGCache_dedup will be read directly and
returned.

2.2.2 reading non-existent content in PGCache_dedup
---------------------------------------------------
In this case, disk I/O operations will be involved. Taking the reading
of an uncompressed file as an example, here is the reading process:

         ksys_read
             │
             │
             ▼
            ...
             │
             │
             ▼
erofs_ishare_file_read_iter (switch to backing deduplicated file)
             │
             │
             ▼
            ... (allocate pages)
             │
             │
             ▼
erofs_read_folio/erofs_readahead
             │
             │
             ▼
            ... (iomap)
             │
             │
             ▼
        erofs_iomap_begin
             │
             │
             ▼
            ...

Iomap and the layers below will involve disk I/O operations. As
described in 2.1, the deduplicated inode itself is not bound to a
specific device. The deduplicated inode will select an erofs inode from
the backing list (by default, the first one) to complete the
corresponding iomap operation.

2.3. release page cache
-----------------------
Similar to overlayfs, when dropping the page cache via .fadvise, erofs
locates the deduplicated file and applies vfs_fadvise to that specific
file.

Effect
==================
I conducted experiments on two aspects across two different minor
versions of container images:

1. reading all files in two different minor versions of container images

2. run workloads or use the default entrypoint within the containers^[1]

Below is the memory usage for reading all files in two different minor
versions of container images:

+-------------------+------------------+-------------+---------------+
|       Image       | Page Cache Share | Memory (MB) |    Memory     |
|                   |                  |             | Reduction (%) |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     241     |       -       |
|       redis       +------------------+-------------+---------------+
|   7.2.4 & 7.2.5   |        Yes       |     163     |      33%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     872     |       -       |
|      postgres     +------------------+-------------+---------------+
|    16.1 & 16.2    |        Yes       |     630     |      28%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     2771    |       -       |
|     tensorflow    +------------------+-------------+---------------+
|  2.11.0 & 2.11.1  |        Yes       |     2340    |      16%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     926     |       -       |
|       mysql       +------------------+-------------+---------------+
|  8.0.11 & 8.0.12  |        Yes       |     735     |      21%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     390     |       -       |
|       nginx       +------------------+-------------+---------------+
|   7.2.4 & 7.2.5   |        Yes       |     219     |      44%      |
+-------------------+------------------+-------------+---------------+
|       tomcat      |        No        |     924     |       -       |
| 10.1.25 & 10.1.26 +------------------+-------------+---------------+
|                   |        Yes       |     474     |      49%      |
+-------------------+------------------+-------------+---------------+

Additionally, the table below shows the runtime memory usage of the
container:

+-------------------+------------------+-------------+---------------+
|       Image       | Page Cache Share | Memory (MB) |    Memory     |
|                   |                  |             | Reduction (%) |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     34.9    |       -       |
|       redis       +------------------+-------------+---------------+
|   7.2.4 & 7.2.5   |        Yes       |     33.6    |       4%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |    149.1    |       -       |
|      postgres     +------------------+-------------+---------------+
|    16.1 & 16.2    |        Yes       |      95     |      37%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |    1027.9   |       -       |
|     tensorflow    +------------------+-------------+---------------+
|  2.11.0 & 2.11.1  |        Yes       |    934.3    |      10%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |    155.0    |       -       |
|       mysql       +------------------+-------------+---------------+
|  8.0.11 & 8.0.12  |        Yes       |    139.1    |      11%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     25.4    |       -       |
|       nginx       +------------------+-------------+---------------+
|   7.2.4 & 7.2.5   |        Yes       |     18.8    |      26%      |
+-------------------+------------------+-------------+---------------+
|       tomcat      |        No        |     186     |       -       |
| 10.1.25 & 10.1.26 +------------------+-------------+---------------+
|                   |        Yes       |      99     |      47%      |
+-------------------+------------------+-------------+---------------+

It can be observed that when reading all the files in the image, the
reduced memory usage varies from 16% to 49%, depending on the specific
image. Additionally, the container's runtime memory usage reduction
ranges from 4% to 47%.

[1] Below are the workload for these images:
      - redis: redis-benchmark
      - postgres: sysbench
      - tensorflow: app.py of tensorflow.python.platform
      - mysql: sysbench
      - nginx: wrk
      - tomcat: default entrypoint

Changes from v11:
    - Patch 4: apply with Xiang's patch.
    - Patch 5: do not mask the xattr_prefix_id in disk and fix the compiling
      error when disable XATTR config.
    - Patch 6,10: add reviewed-by.
    - Patch 7,8: make inode_share excluded with DAX feature, do
      some cleanup on typo and other code-style as suggested by Xiang.
    - Patch 9: using realinode and shareinode in compressed case to access
      metadata and page cache seperately, and remove some useless
      code as suggested by Xiang.

Changes from v10:
    - add reviewed-by and acked-by.
    - do some cleanup on typo, useless code and some helpers' name.
    - use fingerprint struct and introduce inode_share mount option as
      suggested by Xiang.

Changes from v9:
    - make shared page cache as a compatiable feature.
    - refine code style as suggested by Xiang.
    - init ishare mnt during the module init as suggested by Xiang.
    - rebase the latest mainline and fix the comments in cover letter.

Changes from v8:
    - add review-by in patch 1 and patch 10.
    - do some clean up in patch 2 and patch 4,6,9 as suggested by Xiang.
    - add new patch 3 to export alloc_empty_backing_file.
    - patch 5 only use xattr prefix id to record the ishare info, changed
      config to EROFS_FS_PAGE_CACHE_SHARE and make it compatible.
    - patch 7 use backing file helpers to alloc file when ishare file is
      opened as suggested by Xiang.
    - patch 8 remove erofs_read_{begin,end} as suggested by Xiang.

v11: https://lore.kernel.org/all/20251224040932.496478-1-lihongbo22@huawei.com/
v10: https://lore.kernel.org/all/20251223015618.485626-1-lihongbo22@huawei.com/
v9: https://lore.kernel.org/all/20251117132537.227116-1-lihongbo22@huawei.com/
v8: https://lore.kernel.org/all/20251114095516.207555-1-lihongbo22@huawei.com/
v7: https://lore.kernel.org/all/20251021104815.70662-1-lihongbo22@huawei.com/
v6: https://lore.kernel.org/all/20250301145002.2420830-1-hongzhen@linux.alibaba.com/T/#u
v5: https://lore.kernel.org/all/20250105151208.3797385-1-hongzhen@linux.alibaba.com/
v4: https://lore.kernel.org/all/20240902110620.2202586-1-hongzhen@linux.alibaba.com/
v3: https://lore.kernel.org/all/20240828111959.3677011-1-hongzhen@linux.alibaba.com/
v2: https://lore.kernel.org/all/20240731080704.678259-1-hongzhen@linux.alibaba.com/
v1: https://lore.kernel.org/all/20240722065355.1396365-1-hongzhen@linux.alibaba.com/

Gao Xiang (1):
  erofs: decouple `struct erofs_anon_fs_type`

Hongbo Li (4):
  iomap: stash iomap read ctx in the private field of iomap_iter
  erofs: hold read context in iomap_iter if needed
  fs: Export alloc_empty_backing_file
  erofs: support unencoded inodes for page cache share

Hongzhen Luo (5):
  erofs: support user-defined fingerprint name
  erofs: support domain-specific page cache share
  erofs: introduce the page cache share feature
  erofs: support compressed inodes for page cache share
  erofs: implement .fadvise for page cache share

 Documentation/filesystems/erofs.rst |   5 +
 fs/erofs/Kconfig                    |   9 ++
 fs/erofs/Makefile                   |   1 +
 fs/erofs/data.c                     |  89 ++++++++----
 fs/erofs/erofs_fs.h                 |   5 +-
 fs/erofs/fscache.c                  |  13 --
 fs/erofs/inode.c                    |   4 +
 fs/erofs/internal.h                 |  41 ++++++
 fs/erofs/ishare.c                   | 210 ++++++++++++++++++++++++++++
 fs/erofs/super.c                    |  80 ++++++++++-
 fs/erofs/xattr.c                    |  47 +++++++
 fs/erofs/xattr.h                    |   3 +
 fs/erofs/zdata.c                    |  37 +++--
 fs/file_table.c                     |   1 +
 fs/fuse/file.c                      |   4 +-
 fs/iomap/buffered-io.c              |   6 +-
 include/linux/iomap.h               |   8 +-
 17 files changed, 500 insertions(+), 63 deletions(-)
 create mode 100644 fs/erofs/ishare.c

-- 
2.22.0


