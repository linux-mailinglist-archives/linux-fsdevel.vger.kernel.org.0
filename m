Return-Path: <linux-fsdevel+bounces-75070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DaKJWxIcmnpfAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 16:55:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B270694C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 16:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67ED4301112F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 15:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A0F4C0430;
	Thu, 22 Jan 2026 15:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Ri9TSFzY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEC24ADDAD;
	Thu, 22 Jan 2026 15:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769096851; cv=none; b=V+2ti2VRrHN97sVmOqMZRFgIMy5DPTezEj/n2gK9CY1KCIp3GhWITc2Ei84zhanqRpG4zd2SGVCWBaGTEPRL6Qsz7jJSuBUuu1Zw8elt7S2IPlIMNjFZSHSnWcEUwddwh2A6E6lt48O7522bYlV2l0NPjIdW6U91QrAy11LYuOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769096851; c=relaxed/simple;
	bh=aEUvKoVEQtEsxEVHELuFvcKImb495BHG2pissEL4Mlc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JvM827t2ThMJUTUy1hSHBa8pMdPgaWmePyglL+1uxU3u7jwtWVYgylMz/tMfXM48ly524kRb9ySKPQMWupgemnu2zD71WsgnBLOC+iKed8FndLESZXbJ9cjujTiqi1x6YaDouWizqoPOSINCYzlLD/VA4ZjAwaSDcht413i9/LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Ri9TSFzY; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Pda/66FZDSfEYDQb7hcVLzuG1BT5SBGG4GYy8ghzdbc=;
	b=Ri9TSFzYnK8CRPkkMaAL2Q5QD98RL60H2Gjy/q/vijZHaYlvpeB10L8fs3ZmaGXTBl4fpTV1N
	p1Kf1dYLwlsNnlXNOmRA280G38n8MIhYr6Mn/VvUkOIAtaAoJntF7xlcTQbduLwHm1eqcXwZFAp
	ypOJcmKFKIUszA5GFGENCjc=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dxlh162wCz1T4Gp;
	Thu, 22 Jan 2026 23:42:57 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 4755140570;
	Thu, 22 Jan 2026 23:47:02 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 Jan
 2026 23:47:01 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>
CC: <hch@lst.de>, <djwong@kernel.org>, <amir73il@gmail.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH v17 00/10] erofs: Introduce page cache sharing feature
Date: Thu, 22 Jan 2026 15:33:56 +0000
Message-ID: <20260122153406.660073-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lst.de,kernel.org,gmail.com,vger.kernel.org,lists.ozlabs.org,huawei.com];
	TAGGED_FROM(0.00)[bounces-75070-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lihongbo22@huawei.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:dkim,app.py:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0B270694C1
X-Rspamd-Action: no action

Enabling page cahe sharing in container scenarios has become increasingly
crucial, as it can significantly reduce memory usage. In previous efforts,
Hongzhen has done substantial work to push this feature into the EROFS
mainline. Due to other commitments, he hasn't been able to continue his
work recently, and I'm very pleased to build upon his work and continue
to refine this implementation.

This patch series is based on Hongzhen's original EROFS shared pagecache
implementation which was posted more than half a year ago:
https://lore.kernel.org/all/20250301145002.2420830-1-hongzhen@linux.alibaba.com/T/#u

I have already made several iterations based on this patch set, resolving
some issues in the code and some pre-requisites.

It should be noted that the two iomap pre-patches from the previous versions
have already been merged into the vfs/iomap branch, see [1][2]. Therefore,
the remaining patches here are mainly related to EROFS module.

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
and the corresponding index will be stored in the super block. The on-disk
`ishare_xattr_prefix_id` indicates the index of the xattr item within the
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
within the same trusted domain by adding "-o domain_id=xxxx" during the
mounting process:

```
mount -t erofs -o inode_share,domain_id=your_shared_domain_id erofs.img /mnt
```

If no domain ID is specified, page cache sharing is not allowed.

2. Implementation
==================

2.1. shared inode creation
When page cache sharing is enabled, the anon inode is created along with
the original inode if its xattr associated with fingerprint, and the anon
inode is called sharedinode. Other inode which has the same fingerprint
(means the same content) will link to the same sharedinode under the same
trusted domain. The page cache of the anon inode (i_mapping member) is the
shared page cache and is shared by the other inodes which have the same
fingerprint and under the same trusted domain.

2.2. file open & close
----------------------
When the file is opened, the backing file is allocated and the
->private_data field of file is set to the backing file. The backing
file records the shared inode and serves the later read proceedure.
When the actual read occurs, we can obtain the real inode and the
shared inode. The location information of real inode is used to
located the data in disk and the page cache of shared inode will
be filled.

When the file is close, the backing file is also released, and the
related reference on real inode and shared inode are also changed.

2.3. file reading
-----------------
Only the page cache of shared inode can be shared. When reading
happened on sharedinode, we should increase the reference of the
real inode to avoid the disk being released, then to decrease it
after reading.

There are two possible scenarios when reading a file:
1) the content being read is already present in sharedinode's page cache.
2) the content being read is not present in sharedinode's page cache.

In the second scenario, it involves the iomap operation to read from the
disk.

2.3.1. reading existing data in sharedinode's page cache
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
erofs_ishare_file_read_iter (switch to the backing file)
             │
             │
             ▼

 read shared page cache & return

At this point, the content in sharedinode's page cache will be read
directly and returned.

2.3.2 reading non-existent content in sharedinode's page cache
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
erofs_ishare_file_read_iter (switch to the backing file)
             │
             │
             ▼
            ... (allocate pages)
             │
             │
             ▼
erofs_read_folio/erofs_readahead (read to shared page cache)
             │
             │
             ▼
            ... (iomap)
             │
             │
             ▼
        erofs_iomap_begin (located by real inode)
             │
             │
             ▼
            ...

Iomap and the below layer will involve disk I/O operations. As
described in 2.3, reads to the shared inode are not bound to
specific filesystem instance, it will select an real backing erofs
inode from the shared list to complete the I/Os.

2.4. release shared page cache
-----------------------
Similar to overlayfs, when dropping the shared page cache via .fadvise,
erofs locates the shared backing file and applies vfs_fadvise to release
the shared page cache.

Effect
==================
I conducted experiments on two aspects across two different minor
versions of container images:

1. reading all files in two different minor versions of container images

2. run workloads or use the default entrypoint within the containers^[I]

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

[I] Below are the workload for these images:
      - redis: redis-benchmark
      - postgres: sysbench
      - tensorflow: app.py of tensorflow.python.platform
      - mysql: sysbench
      - nginx: wrk
      - tomcat: default entrypoint

Changes from v16:
    - Patch 4: Fix undefined error (use just move out to a single helper),
      and remove unneeded dot in subject.
    - Patch 5: move unrelated diff out.

Changes from v15:
    - Patch 4: add erofs_inode_set_aops helper in a seperated patch as
      suggested by Christoph.
    - Patch 5: use safer way on domain_id: alloc/free, not show to userspace
      in sharing case and update notation in doc as suggested by Xiang.
    - Patch 6: use #ifdef as suggested by Christoph and don't allow empty
      domain_id when inode_share is on as suggested by Xiang.
    - Patch 10: remove extra pointer cast as suggested by Christoph.

Changes from v14:
    - Patch 5: add erofs_inode_set_aops helper to simplify the code and add log
      when INODE_SHARE is on as suggested by Xiang. Add inode_drop when
      sharedinode is an orphan and skip fill fingerprint when xattr is not ready.
    - Patch 6: new added one, to pass inode into tracepoint helper.
    - Patch 7: move tracepoint related changes out and simplify the code
      as suggested by Xiang.
    - Patch 8: the compressed related one, add reviewed-by.

Changes from v13:
    - Patch 7: do some minor cleanup as suggested by Xiang.
    - Patch 8,9: use open-code style as suggested by Xiang and pass the
      realinode to trace_erofs_read_folio.

Changes from v12:
    - Patch 5: add reviewed-by.
    - Patch 7: only allow non-direct I/O in open for sharing feature, mask
      INODE_SHARE if sb without ishare_xattrs, simplify the code and better
      naming as suggested by Xiang.
    - Patch 8: remove unuse macro as suggested by Xiang.
    - Patch 9: minor cleanup as suggested by Xiang.

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

v16: https://lore.kernel.org/all/20260122133718.658056-1-lihongbo22@huawei.com/
v15: https://lore.kernel.org/all/20260116095550.627082-1-lihongbo22@huawei.com/
v14: https://lore.kernel.org/all/20260109102856.598531-1-lihongbo22@huawei.com/
v13: https://lore.kernel.org/all/20260109030140.594936-1-lihongbo22@huawei.com/
v12: https://lore.kernel.org/all/20251231090118.541061-1-lihongbo22@huawei.com/
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

[1] https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?id=8806f279244b
[2] https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?id=8d407bb32186

Gao Xiang (1):
  erofs: decouple `struct erofs_anon_fs_type`

Hongbo Li (5):
  fs: Export alloc_empty_backing_file
  erofs: add erofs_inode_set_aops helper to set the aops
  erofs: using domain_id in the safer way
  erofs: pass inode to trace_erofs_read_folio
  erofs: support unencoded inodes for page cache share

Hongzhen Luo (4):
  erofs: support user-defined fingerprint name
  erofs: introduce the page cache share feature
  erofs: support compressed inodes for page cache share
  erofs: implement .fadvise for page cache share

 Documentation/filesystems/erofs.rst |  10 +-
 fs/erofs/Kconfig                    |   9 ++
 fs/erofs/Makefile                   |   1 +
 fs/erofs/data.c                     |  36 +++--
 fs/erofs/erofs_fs.h                 |   5 +-
 fs/erofs/fileio.c                   |  25 ++--
 fs/erofs/fscache.c                  |  19 +--
 fs/erofs/inode.c                    |  27 +---
 fs/erofs/internal.h                 |  67 +++++++++
 fs/erofs/ishare.c                   | 206 ++++++++++++++++++++++++++++
 fs/erofs/super.c                    |  89 +++++++++++-
 fs/erofs/xattr.c                    |  47 +++++++
 fs/erofs/xattr.h                    |   3 +
 fs/erofs/zdata.c                    |  38 +++--
 fs/file_table.c                     |   1 +
 include/trace/events/erofs.h        |  10 +-
 16 files changed, 505 insertions(+), 88 deletions(-)
 create mode 100644 fs/erofs/ishare.c

-- 
2.22.0


