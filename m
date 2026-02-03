Return-Path: <linux-fsdevel+bounces-76134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iH/WA0+WgWl/HAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 07:31:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 928DED543C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 07:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1FF2D3039324
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 06:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914B437C0FF;
	Tue,  3 Feb 2026 06:30:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29FE1FC7C5;
	Tue,  3 Feb 2026 06:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770100218; cv=none; b=BZlMKEDqXuTzr1ntsPG6tFBeGEtnS11LoW+hF7j0DQMHn80aHH3gzlyhTRIRSKjfZsOC5eRPfg8IGpz3QIhxpUMRL8htgg6DqB4hDli5/XsOzpptv2CJDJB9CVod0GJAYex/xCk8NolZbUmSrtYhenopXA+xIrJkJI4/tUx4Nts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770100218; c=relaxed/simple;
	bh=7KekQQ9hUdknH0BcYzxZjggpYODIO/9ZBgJvo0V+ogw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c4xthC5vjpYjiwauVv+UPDssDs4Dxsm/uDbbFvZ7rf24n88kgbNzy+bNcwuPZO0CCIXcaOChQoiH2tOuoSFO85r1nkfJ8fYcltNfek/KIBJR1cteza6QwV3rcQPyadtSNuAicPBsGNhm6mrHjshkCGgirxgAF14kn0bOiBhSYo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4f4tqp52FTzYQtvJ;
	Tue,  3 Feb 2026 14:29:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A08EF40570;
	Tue,  3 Feb 2026 14:30:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgAHaPjnlYFpiadbGA--.27803S4;
	Tue, 03 Feb 2026 14:30:11 +0800 (CST)
From: Zhang Yi <yi.zhang@huawei.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com,
	hch@infradead.org,
	djwong@kernel.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	yizhang089@gmail.com,
	libaokun1@huawei.com,
	yangerkun@huawei.com,
	yukuai@fnnas.com
Subject: [PATCH -next v2 00/22]  ext4: use iomap for regular file's buffered I/O path
Date: Tue,  3 Feb 2026 14:25:00 +0800
Message-ID: <20260203062523.3869120-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHaPjnlYFpiadbGA--.27803S4
X-Coremail-Antispam: 1UD129KBjvJXoW3GFW3Kr17WFy3WF4rGw4UArb_yoW7ZryxpF
	98KFWfKrnrWryI9an7CF4xtr1Yqan3JF43Wr4rW34UuF1jgr18ZFZ29F1j9FW5KrW7Jry0
	vr4akFy2gF98A37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0aVACjI8F5VA0II8E6IAqYI8I648v4I1l
	FIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr4
	1l42xK82IY64kExVAvwVAq07x20xyl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF9NV
	DUUUU
Sender: yi.zhang@huaweicloud.com
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,linux.ibm.com,gmail.com,infradead.org,kernel.org,huawei.com,huaweicloud.com,fnnas.com];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-76134-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yi.zhang@huawei.com,linux-fsdevel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_TWELVE(0.00)[16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huaweicloud.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 928DED543C
X-Rspamd-Action: no action

From: Zhang Yi <yi.zhang@huaweicloud.com>

Changes since V1:
 - Rebase this series on linux-next 20260122.
 - Refactor partial block zero range, stop passing handle to
   ext4_block_truncate_page() and ext4_zero_partial_blocks(), and move
   partial block zeroing operation outside an active journal transaction
   to prevent potential deadlocks because of the lock ordering of folio
   and transaction start.
 - Clarify the lock ordering of folio lock and transaction start, update
   the comments accordingly.
 - Fix some issues related to fast commit, pollute post-EOF folio.
 - Some minor code and comments optimizations.

v1:     https://lore.kernel.org/linux-ext4/20241022111059.2566137-1-yi.zhang@huaweicloud.com/
RFC v4: https://lore.kernel.org/linux-ext4/20240410142948.2817554-1-yi.zhang@huaweicloud.com/
RFC v3: https://lore.kernel.org/linux-ext4/20240127015825.1608160-1-yi.zhang@huaweicloud.com/
RFC v2: https://lore.kernel.org/linux-ext4/20240102123918.799062-1-yi.zhang@huaweicloud.com/
RFC v1: https://lore.kernel.org/linux-ext4/20231123125121.4064694-1-yi.zhang@huaweicloud.com/

Original Cover (Updated):

This series adds the iomap buffered I/O path supports for regular files.
It implements the core iomap APIs on ext4 and introduces two mount
options called 'buffered_iomap' and "nobuffered_iomap" to enable and
disable the iomap buffered I/O path. This series supports the default
features, default mount options and bigalloc feature for ext4. We do not
yet support online defragmentation, inline data, fs_verify, fs_crypt,
non-extent, and data=journal mode, it will fall to buffered_head I/O
path automatically if these features and options are used.

Key notes on the iomap implementations in this series.
 - Don't use ordered data mode to prevent exposing stale data when
   performing append write and truncating down.
 - Override dioread_nolock mount option, always allocate unwritten
   extents for new blocks.
 - When performing write back, don't use reserved journal handle and
   postponing updating i_disksize until I/O is done.
 - The lock ordering of the folio lock and start transaction is the
   opposite of that in the buffer_head buffered write path.

Series details:

Patch 01-08: Refactor partial block zeroing operation, move it out of an
             active running journal transaction, and handle post EOF
             partial block zeroing properly.
Patch 09-21: Implement the core iomap buffered read, write path, dirty
             folio write back path, mmap path and partial block zeroing
             path for ext4 regular file. 
Patch 22:    Introduce 'buffered_iomap' and 'nobuffer_iomap' mount option
             to enable and disable the iomap buffered I/O path.

Tests and Performance:

I tested this series using xfstests-bld with auto configurations, as
well as fast_commit and 64k configurations. No new regressions were
observed.

I used fio to test my virtual machine with a 150 GB memory disk and
found an improvement of approximately 30% to 50% in large I/O write
performance, while read performance showed no significant difference.

 buffered write
 ==============

  buffer_head:
  bs      write cache    uncached write
  1k       423  MiB/s      36.3 MiB/s
  4k       1067 MiB/s      58.4 MiB/s
  64k      4321 MiB/s      869  MiB/s
  1M       4640 MiB/s      3158 MiB/s
  
  iomap:
  bs      write cache    uncached write
  1k       403  MiB/s      57   MiB/s
  4k       1093 MiB/s      61   MiB/s
  64k      6488 MiB/s      1206 MiB/s
  1M       7378 MiB/s      4818 MiB/s

 buffered read
 =============

  buffer_head:
  bs      read hole   read cache      read data
  1k       635  MiB/s    661  MiB/s    605  MiB/s
  4k       1987 MiB/s    2128 MiB/s    1761 MiB/s
  64k      6068 MiB/s    9472 MiB/s    4475 MiB/s
  1M       5471 MiB/s    8657 MiB/s    4405 MiB/s

  iomap:
  bs      read hole   read cache       read data
  1k       643  MiB/s    653  MiB/s    602  MiB/s
  4k       2075 MiB/s    2159 MiB/s    1716 MiB/s
  64k      6267 MiB/s    9545MiB/s     4451 MiB/s
  1M       6072 MiB/s    9191MiB/s     4467 MiB/s

Comments and suggestions are welcome!

Thanks,
Yi.


Zhang Yi (22):
  ext4: make ext4_block_zero_page_range() pass out did_zero
  ext4: make ext4_block_truncate_page() return zeroed length
  ext4: only order data when partially block truncating down
  ext4: factor out journalled block zeroing range
  ext4: stop passing handle to ext4_journalled_block_zero_range()
  ext4: don't zero partial block under an active handle when truncating
    down
  ext4: move ext4_block_zero_page_range() out of an active handle
  ext4: zero post EOF partial block before appending write
  ext4: add a new iomap aops for regular file's buffered IO path
  ext4: implement buffered read iomap path
  ext4: pass out extent seq counter when mapping da blocks
  ext4: implement buffered write iomap path
  ext4: implement writeback iomap path
  ext4: implement mmap iomap path
  iomap: correct the range of a partial dirty clear
  iomap: support invalidating partial folios
  ext4: implement partial block zero range iomap path
  ext4: do not order data for inodes using buffered iomap path
  ext4: add block mapping tracepoints for iomap buffered I/O path
  ext4: disable online defrag when inode using iomap buffered I/O path
  ext4: partially enable iomap for the buffered I/O path of regular
    files
  ext4: introduce a mount option for iomap buffered I/O path

 fs/ext4/ext4.h              |  21 +-
 fs/ext4/ext4_jbd2.c         |   1 +
 fs/ext4/ext4_jbd2.h         |   7 +-
 fs/ext4/extents.c           |  31 +-
 fs/ext4/file.c              |  40 +-
 fs/ext4/ialloc.c            |   1 +
 fs/ext4/inode.c             | 822 ++++++++++++++++++++++++++++++++----
 fs/ext4/move_extent.c       |  11 +
 fs/ext4/page-io.c           | 119 ++++++
 fs/ext4/super.c             |  32 +-
 fs/iomap/buffered-io.c      |  12 +-
 include/trace/events/ext4.h |  45 ++
 12 files changed, 1033 insertions(+), 109 deletions(-)

-- 
2.52.0


