Return-Path: <linux-fsdevel+bounces-19492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 468148C5F2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 04:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D78F61F22384
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 02:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBF938DE1;
	Wed, 15 May 2024 02:39:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131372E651;
	Wed, 15 May 2024 02:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715740745; cv=none; b=fOZJtbobrrd5q0xksFLyyxQ20iDUVZc+wcTpRRG2wxg5kX7Xrr/qQFGG22iVZbgteq5+FmQE/pSAq2LMTPjNB6awjUFgUJNhC+XRyyR/DDA1fX55xXlLIvXpDCQRoY9ol6FwMB9x+5vnFMU612EZmEL5CrPhBuwK5MJK5BA0FfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715740745; c=relaxed/simple;
	bh=P17TUchu1NIssy+AdAxWw4Luu+/j+iOOFjptCl3k0aY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KBuOucD5RpqFt+SRfMkndWQTndcfcowPP8//GP59T697rgWOWsWMUWYXw73Awa/CXCSHEDzfhc4buyXfxFVEbyjLhbAutVpLMz25TWzL0Jq8WzU5oPjCjbMSr9ru1OztcOW8AIVPHe8YVA9EjKhAA7v1RA/VnvkvfKfnVASGLzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VfHV24Vdhz4f3jXc;
	Wed, 15 May 2024 10:38:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 46E3E1A08D4;
	Wed, 15 May 2024 10:38:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBE8IERmRFzIMg--.49754S4;
	Wed, 15 May 2024 10:38:56 +0800 (CST)
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
Subject: [PATCH 0/3] iomap/xfs: fix stale data exposure when truncating realtime inodes
Date: Wed, 15 May 2024 10:28:26 +0800
Message-Id: <20240515022829.2455554-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXKBE8IERmRFzIMg--.49754S4
X-Coremail-Antispam: 1UD129KBjvJXoWrtrWxZF4UtrWDtF4kAFy8Grg_yoW8JF4UpF
	Z3GFW3Wr48CFy3Zas3ua1qv345t3W0yrWUuFyxJwnxZasIqryIqr4Fka18WayDtrWkWr45
	Xr1UKFW8ur1kArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

From: Zhang Yi <yi.zhang@huawei.com>

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

 fs/dax.c               |  7 +++----
 fs/ext2/inode.c        |  4 ++--
 fs/iomap/buffered-io.c |  7 +++----
 fs/xfs/xfs_iomap.c     | 36 ++++++++++++++++++++++++++++++++----
 fs/xfs/xfs_iops.c      | 10 ----------
 include/linux/dax.h    |  4 ++--
 include/linux/iomap.h  |  4 ++--
 7 files changed, 44 insertions(+), 28 deletions(-)

-- 
2.39.2


