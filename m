Return-Path: <linux-fsdevel+bounces-19568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EC48C7228
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 09:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A7ED1F213F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 07:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E958912BEAB;
	Thu, 16 May 2024 07:40:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8839028DD1;
	Thu, 16 May 2024 07:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715845241; cv=none; b=rr8i1XSKusDv/uVaMB8Dk+81PdTfJCqoDE+5hjxrfAg6t3xpGdcD5hikpvTvHoaglEbDABXSLqRam/3PsdSWUq0FYaytwVus9JQTFk2+c/csGWOEOBPb/C8vM+8ntNOCMp52Z/AJvrpvJN8CuhFGE3Df8VcW/FWkk9XOrhZbSQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715845241; c=relaxed/simple;
	bh=mEaKmv5UPk7MYJdN06YN/FyqoRm0lwQ1F7u9FB8ErgE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HyuIUGD9fBuGyTX0HPzJTZo2GOe8xH5S18G1YgPqAidmm88lPDyFYxG4Dl30qTLtusNXskFGC5zR9IVwf81KW9mQITTdjjcha2GNDFlHdzxt7QtOWjXsfUoU8Mq9B6BUr9Et1Ra13OOf969pDvOUwTEFYbv1eIDSIt3LOgJ+wkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Vg27Z0qxDz4f3jYK;
	Thu, 16 May 2024 15:40:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id CA0161A0B17;
	Thu, 16 May 2024 15:40:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBFtuEVmQuY4Mw--.31554S4;
	Thu, 16 May 2024 15:40:32 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	brauner@kernel.org,
	david@fromorbit.com,
	chandanbabu@kernel.org,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH v2 0/3] iomap/xfs: fix stale data exposure when truncating realtime inodes
Date: Thu, 16 May 2024 15:29:58 +0800
Message-Id: <20240516073001.1066373-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXKBFtuEVmQuY4Mw--.31554S4
X-Coremail-Antispam: 1UD129KBjvJXoWxJry5KFWDAw48AFy7WF4rXwb_yoW8GFyxpF
	s5Kry3Wr18Cry3Za4fua1qv345J3W0yrWUuFyxtwnxZasFqFyIyr10ka10gayDKrykXr4U
	Wr15JFZ7uFn5Ar7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0J
	UZa9-UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

Changes since v1:
 - In iomap_truncate_page() and dax_truncate_page(), for the case of
   truncate blocksize is not power of 2, use do_dive() to calculate the
   offset.

This series fix a stale data exposure issue reported by Chandan when
running fstests generic/561 on xfs with realtime device[1]. The real
problem is xfs_setattr_size() doesn't zero out enough range when
truncating a realtime inode, please see the third patch or [1] for
details.

The first two patches modify iomap_truncate_page() and
dax_truncate_page() to pass filesystem identified blocksize, and drop
the assumption of i_blocksize() as Dave suggested. The third patch fix
the issue by modifying xfs_truncate_page() to pass the correct
blocksize, and make sure zeroed range have been flushed to disk before
updating i_size.

[1] https://lore.kernel.org/linux-xfs/87ttj8ircu.fsf@debian-BULLSEYE-live-builder-AMD64/

Thanks,
Yi.

Zhang Yi (3):
  iomap: pass blocksize to iomap_truncate_page()
  fsdax: pass blocksize to dax_truncate_page()
  xfs: correct the zeroing truncate range

 fs/dax.c               | 11 ++++++-----
 fs/ext2/inode.c        |  4 ++--
 fs/iomap/buffered-io.c | 11 ++++++-----
 fs/xfs/xfs_iomap.c     | 36 ++++++++++++++++++++++++++++++++----
 fs/xfs/xfs_iops.c      | 10 ----------
 include/linux/dax.h    |  4 ++--
 include/linux/iomap.h  |  4 ++--
 7 files changed, 50 insertions(+), 30 deletions(-)

-- 
2.39.2


