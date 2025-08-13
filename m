Return-Path: <linux-fsdevel+bounces-57670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D45B245B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 11:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54BFB723F6F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 09:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B60F2F6599;
	Wed, 13 Aug 2025 09:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="DNAea/8T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3FD2F6580
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 09:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755077932; cv=none; b=KvcRjwSj/wG7UFiGDuMbDe71pZlVHKRbWoPLIWIkQedEX8sNQhQ5i03tMbypVUAZfAoQWbCVR7mK4acRhTG1LH4ekmXn1Buh0rUljIkOlSBZ0ufIUOMq64NGs0gxcL5OSWTXzZpF4M7a2sqvn0mTKdxPIlZFVoPuAtRG3q/JtDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755077932; c=relaxed/simple;
	bh=fSs0uKmTkWsBhG0EkZ3SRL+KckVpI5HUXNKqb3a8/yA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Z3AsHPy7So4D7y4JWgMGXwJiD+RFyBGb3cRnr/T6W2yR5k1QOWbGZqX0tSJByuJjhqy7meiatVXc3xM0LJiQX/EuFnTKCA76OGSeGuXPsTayU6n9hrK/lehKU6Vq2iJbZBBBIckRsvS9lymF+7tsB2EFURs+BTHcGEIgAC3Xzyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=DNAea/8T; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=QwdKSo3YK0esWLMX0A++CG41fz927dLcjOBFe+UWw9c=;
	b=DNAea/8TLFIG7NkeiHI0hALSRJueZrU9EacU2792bTf+OJeaMGWVYB6QcGdUxN
	vEXrafT8qzHemdxhe++0VoPP/cohWwC1PHORVy7gehZieGRI4PhiMR50mzhGnkK9
	3IVKym73xPF9qJese67gBI5qsCwFCAHDHfqw2zLGdK03M=
Received: from YLLaptop.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3tyv8XJxo_MzyBQ--.54250S2;
	Wed, 13 Aug 2025 17:38:16 +0800 (CST)
From: Nanzhe Zhao <nzzhao@126.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Chao Yu <chao@kernel.org>,
	Yi Zhang <yi.zhang@huawei.com>,
	Barry Song <21cnbao@gmail.com>,
	Nanzhe Zhao <nzzhao@126.com>
Subject: [f2fs-dev] [RESEND RFC PATCH 0/9] f2fs: Enable buffered read/write large folios support with extended iomap
Date: Wed, 13 Aug 2025 17:37:46 +0800
Message-Id: <20250813093755.47599-1-nzzhao@126.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3tyv8XJxo_MzyBQ--.54250S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUO6pPDUUUU
X-CM-SenderInfo: xq22xtbr6rjloofrz/1tbiFg+oz2icTc3h1wAAs8

Resend: original patch was misspelling
the linux-f2fs-devel@lists.sourceforge.net address.
No code changes.

This RFC series enable buffered read/write paths large folio support
with F2FS-specific extended iomap, combined with some other preparation
work for large folio integration.

Because this is my first time to send a patch series to the kernel
mailing list,
I might have missed some conventions.
The patch passes checkpatch.pl with no errors,
but a few warnings remain.
I wasn't sure about the best way to address them,
so I would appreciate your guidance.
I am happy to fix them if needed.

Motivations:

* **Why iomap**:
  * F2FS couples pages directly to BIOs without a per-block tracking
    struct like buffer-head or sub-page.
    A naive large-folio port would cause:
    * Write-amplification.
    * Premature folio_end_read() / folio_end_writeback()
      when multi sub-ranges of a large folio are in io concurrently.
    Above issues has already been handled cleanly by iomap_folio_state.

  * Original buffered write path unlocks a folio halfway,causes status
    recheck for large folios carried with iomap_folio_state
    or partially trucnated folio tricky.iomap handles all locking
    unlocking operations automatically.

* **Why extends iomap**
  * F2FS stores its flags in the folio's private field,
    which conflicts with iomap_folio_state.
  * To resolve this, we designed f2fs_iomap_folio_state,
    compatible with iomap_folio_state's layout while extending
    its flexible state array for F2FS private flags.
  * We store a magic number in read_bytes_pending to distinguish
    whether a folio uses the original or F2FS's iomap_folio_state.
    It's chosen because it remains 0 after readahead completes.

Implementation notes:

* New Kconfig: `CONFIG_F2FS_IOMAP_FOLIO_STATE`; when off,falls back
  to the legacy buffered io path.

Limitations

* Don't support BLOCK_SIZE > PAGE_SIZE now.
* Don't support large folios for encrypted and fsverity files.
* Page writeback and compressed files large folios support is still WIP.

Why RFC:

* Need review and potential improvement on
 `f2fs_iomap_folio_state` design and implementation.
* Limited test coverage so far.Any extra testing is highly appreciated.
* Two runtime issues remain (see below).

Performance Testing:

* Platform: x86-64 laptop (PCIe 4.0 NVMe) -> qemu-arm64 VM, 4 GiB RAM
* Kernel: gcc-13.2, defconfig + `CONFIG_F2FS_IOMAP_FOLIO_STATE=y`
fio 3.35, `ioengine=psync`, `size=1G`, `numjobs=1`

Read throughput (MiB/s):

--- Kernel: iomap_v1 file type: normal ---
Block Size (bs)      | Avg. Bandwidth (MiB/s)       | Avg. IOPS
---------------------+------------------------------+-----------------
100M                 | 2809.60                      | 27.50
10M                  | 3184.60                      | 317.90
128k                 | 1376.20                      | 11000.80
1G                   | 1954.70                      | 1.20
1M                   | 2717.00                      | 2716.70
4k                   | 616.50                       | 157800.00

--- Kernel: vanilla  file type: normal ---
Block Size (bs)      | Avg. Bandwidth (MiB/s)       | Avg. IOPS
---------------------+------------------------------+-----------------
100M                 | 994.60                       | 9.60
10M                  | 986.50                       | 98.10
128k                 | 693.80                       | 5550.90
1G                   | 816.90                       | 0.00
1M                   | 968.90                       | 968.40
4k                   | 429.80                       | 109990.00
--- Kernel: iomap_v1 file type: hole ---
Block Size (bs)      | Avg. Bandwidth (MiB/s)       | Avg. IOPS
---------------------+------------------------------+-----------------
100M                 | 1825.60                      | 17.70
10M                  | 1989.24                      | 198.42
1G                   | 1312.80                      | 0.90
1M                   | 2326.02                      | 2325.42
4k                   | 799.40                       | 204700.00

--- Kernel: vanilla file type: hole ---
Block Size (bs)      | Avg. Bandwidth (MiB/s)       | Avg. IOPS
---------------------+------------------------------+-----------------
100M                 | 708.90                       | 6.50
10M                  | 735.00                       | 73.10
128k                 | 786.70                       | 6292.20
1G                   | 613.20                       | 0.00
1M                   | 764.50                       | 764.25
4k                   | 478.80                       | 122400.00

Sparse-file numbers on qemu look skewed; further bare-metal tests planned.

Write benchmarks are currently blocked by the issues below.

Known issues (help appreciated)

**Write throttling stalls**
  ```sh
  dd if=/dev/zero of=test.img bs=1G count=1 conv=fsync
  ```
  Write speed decays; task spins in `iomap_write_iter`
  ->`balance_dirty_pages_ratelimited_flags`.

**fsync dead-lock**
  ```sh
  fio --rw=write --bs=4K --fsync=1 --size=1G --ioengine=psync …
  ```
  Task Hangs in `f2fs_issue_flush`->'submit_bio_wait'

Full traces will be posted in a follow-up.

Nanzhe Zhao (9):
  f2fs: Introduce f2fs_iomap_folio_state
  f2fs: Integrate f2fs_iomap_folio_state into f2fs page private helpers
  f2fs: Using `folio_detach_f2fs_private` in invalidate and release
    folio
  f2fs: Convert outplace write path page private funcions to folio
    private functions.
  f2fs:Refactor `f2fs_is_compressed_page` to `f2fs_is_compressed_folio`
  f2fs: Extend f2fs_io_info to support sub-folio ranges
  f2fs:Make GC aware of large folios
  f2fs: Introduce F2FS_GET_BLOCK_IOMAP and map_blocks he lpers
  f2fs: Enable buffered read/write path large folios support for normal
    and atomic file with iomap

 fs/f2fs/Kconfig    |  10 ++
 fs/f2fs/Makefile   |   1 +
 fs/f2fs/compress.c |  11 +-
 fs/f2fs/data.c     | 389 ++++++++++++++++++++++++++++++++++++------
 fs/f2fs/f2fs.h     | 412 ++++++++++++++++++++++++++++++++++-----------
 fs/f2fs/f2fs_ifs.c | 221 ++++++++++++++++++++++++
 fs/f2fs/f2fs_ifs.h |  79 +++++++++
 fs/f2fs/file.c     |  33 +++-
 fs/f2fs/gc.c       |  37 ++--
 fs/f2fs/inline.c   |  15 +-
 fs/f2fs/inode.c    |  27 +++
 fs/f2fs/namei.c    |   7 +
 fs/f2fs/segment.c  |   2 +-
 fs/f2fs/super.c    |   3 +
 14 files changed, 1082 insertions(+), 165 deletions(-)
 create mode 100644 fs/f2fs/f2fs_ifs.c
 create mode 100644 fs/f2fs/f2fs_ifs.h


base-commit: b45116aef78ff0059abf563b339e62a734487a50
--
2.34.1


