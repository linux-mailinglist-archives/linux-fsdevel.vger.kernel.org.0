Return-Path: <linux-fsdevel+bounces-20386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2908D2A2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 03:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 976DB1F283EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 01:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8628115ADA9;
	Wed, 29 May 2024 01:59:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD81715AAD1;
	Wed, 29 May 2024 01:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716947963; cv=none; b=dWWgj0Aeftuj9p2YwQ++NyNgyHvg6kNhjZvQZEhzZVuDGCOveZWZrNazQ9ZO7iRnRf0Ji7nv0pIsruzBYo/ymgTFHSlnOgq/KiIQEBp+pMXbBLq67xvmohcGbydwFxopVTffJLX8rgqelY/MHETOxE07TYXMhnQksWx639RoGgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716947963; c=relaxed/simple;
	bh=EftrWlTdXrV8eries2uVwbxcta6q8kmV/CnKImnKnAY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gczpBbgaUwPV4/RkfGd9Gu8GaTMqSFSuV5dNu7/CBeXGyVJURziatCmtScfbTG9r/ukwR0PzB14yJO1ytZ99Q8oLCXtFRikqYm0jjeMh8RkGVoxfw4ted/GDAXjbdEkzicUDp6DglUnu/TgmTF8WBpiMmd1Ojb0JbCyqS8O/4Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Vpsxl51PTz4f3jcp;
	Wed, 29 May 2024 09:59:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id F21CE1A0572;
	Wed, 29 May 2024 09:59:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g7wi1Zmr3XbNw--.12147S4;
	Wed, 29 May 2024 09:59:14 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	brauner@kernel.org,
	david@fromorbit.com,
	chandanbabu@kernel.org,
	jack@suse.cz,
	willy@infradead.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [RFC PATCH v4 0/8] iomap/xfs: fix stale data exposure when truncating realtime inodes
Date: Wed, 29 May 2024 17:51:58 +0800
Message-Id: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn9g7wi1Zmr3XbNw--.12147S4
X-Coremail-Antispam: 1UD129KBjvJXoWxCr17JFyfuw1UCw1Utw4ktFb_yoW5Xw1UpF
	Z3G3yY9r4kJ343ZFyfZ3ZFqw15u3ZYkF4UCFy7Grsak3W3Wr1Iyr1aqF45XayjkrWkWr4Y
	vr45tFW8urnYyFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9a14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7
	xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3
	Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
	UvcSsGvfC2KfnxnUUI43ZEXa7sRiRwZDUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Changes since v3:
 - Factor out a new helper to get the remainder in math64.h as Darrick
   suggested.
 - Adjust the truncating order to prevent too much redundant blocking
   writes as Dave suggested.
 - Improve to convert the tail extent to unwritten when truncating down
   an inode with large rtextsize as Darrick and Dave suggested.

This series fix a stale data exposure issue reported by Chandan when
running fstests generic/561 on xfs with realtime device[1]. The real
problem is xfs_setattr_size() doesn't zero out enough range when
truncating a realtime inode, please see the patch 6 or [1] for
details.

Patch 1 is from Dave, it improves truncate down performace by changing
iomap_zero_iter() to aware dirty pages on unwritten extents, but for the
case of the zeroing range that contains a cow mapping over a hole still
needs to be handled. 

Patch 3-5 modify iomap_truncate_page() and dax_truncate_page() to pass
filesystem identified blocksize, and drop the assumption of
i_blocksize() as Dave suggested.

Patch 6-7 adjust the truncating down processing order to first zero out
the tail aligned blocks, then write back, update i_size and finally drop
cache beyond aligned EOF. Fix the data exposure issue by zeroing out the
entire EOF extent.

Patch 8-9 add a rtextsize threshold (64k), improves truncate down performace
on realtime inode with large rtextsize (beyonds this threshold) by
converting the tail unaligned extent to unwritten.

I've tested this series on fstests (1) with reflink=0, (2) with 28K RT
device and (3) with 96K RT device (beyonds rtextsize threshold), no new
failures detected. This series still needs to do furtuer tests with
reflink=1 after Patch 1 covers the cow mapping over a hole case.

[1] https://lore.kernel.org/linux-xfs/87ttj8ircu.fsf@debian-BULLSEYE-live-builder-AMD64/

Thanks,
Yi.

Dave Chinner (1):
  iomap: zeroing needs to be pagecache aware

Zhang Yi (7):
  math64: add rem_u64() to just return the remainder
  iomap: pass blocksize to iomap_truncate_page()
  fsdax: pass blocksize to dax_truncate_page()
  xfs: refactor the truncating order
  xfs: correct the truncate blocksize of realtime inode
  xfs: reserve blocks for truncating realtime inode
  xfs: improve truncate on a realtime inode with huge extsize

 fs/dax.c               |   8 +--
 fs/ext2/inode.c        |   4 +-
 fs/iomap/buffered-io.c |  50 ++++++++++++++--
 fs/xfs/xfs_inode.c     |   3 +
 fs/xfs/xfs_inode.h     |  12 ++++
 fs/xfs/xfs_iomap.c     |   5 +-
 fs/xfs/xfs_iomap.h     |   3 +-
 fs/xfs/xfs_iops.c      | 133 +++++++++++++++++++++++++----------------
 include/linux/dax.h    |   4 +-
 include/linux/iomap.h  |   4 +-
 include/linux/math64.h |  24 ++++++++
 11 files changed, 179 insertions(+), 71 deletions(-)

-- 
2.39.2


