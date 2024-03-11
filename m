Return-Path: <linux-fsdevel+bounces-14125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07323877FFE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 13:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A91631F227AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 12:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492863FE2D;
	Mon, 11 Mar 2024 12:30:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402CF383A9;
	Mon, 11 Mar 2024 12:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710160205; cv=none; b=qLPdBGwJmLLYZFwWOslPv0X6y+bM65/2EgDDOe3vU8tHQ2giFlhcSSvVCDDaCFupRnC85aWRGLnMPIrbFS/lbTksZFxS2erPvZqxn2JsQxDaujYcHE9fp6lkJ/JkWAuijYh/dAh5L+ihSKEWeTDO6QPuRvko/keS4uPcp+/TdjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710160205; c=relaxed/simple;
	bh=xMM2DNemWdbPKiUWoRG3Me9R5Y6sBkgMp7tKEGkoQJM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OYDcN8I1u5EAHKXAxhcaD0aPljhuB9PraBuhwev/hxqFFQXIsaio++8BQndObscOKW+lVdM+cZHxoR7jBTqL+ZXSH3yMTACi5Xzg2EdOSO+DMo8aO9XDSMT1HLTvaakVAUiM8n0BYDWzAO/aRC6tsDJbNj4H7pmOTKkLyDVEaCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Ttbgx41qWz4f3lgB;
	Mon, 11 Mar 2024 20:29:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 37E501A017A;
	Mon, 11 Mar 2024 20:29:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxAt+e5lAE9+Gg--.62739S4;
	Mon, 11 Mar 2024 20:29:55 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	brauner@kernel.org,
	david@fromorbit.com,
	tytso@mit.edu,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH 0/4] xfs/iomap: fix non-atomic clone operation and don't update size when zeroing range post eof
Date: Mon, 11 Mar 2024 20:22:51 +0800
Message-Id: <20240311122255.2637311-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxAt+e5lAE9+Gg--.62739S4
X-Coremail-Antispam: 1UD129KBjvJXoWruF4xJrWfAr1DXr48tFyrJFb_yoW8JF1DpF
	saka1S9r1xGr1xurs3KF45Gw45ta1rZr1UWr1fGw1rZ3y8Ary29r4IgF4FkrWUJr9akw4F
	qr129Fy8K34UArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1
	a9aPUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

This patch series fix a problem of exposing zeroed data on xfs since the
non-atomic clone operation. This problem was found while I was
developing ext4 buffered IO iomap conversion (ext4 is relying on this
fix [1]), the root cause of this problem and the discussion about the
solution please see [2]. After fix the problem, iomap_zero_range()
doesn't need to update i_size so that ext4 can use it to zero partial
block, e.g. truncate eof block [3].

[1] https://lore.kernel.org/linux-ext4/20240127015825.1608160-1-yi.zhang@huaweicloud.com/
[2] https://lore.kernel.org/linux-ext4/9b0040ef-3d9d-6246-4bdd-82b9a8f55fa2@huaweicloud.com/
[3] https://lore.kernel.org/linux-ext4/9c9f1831-a772-299b-072b-1c8116c3fb35@huaweicloud.com/

Thanks,
Yi.

Zhang Yi (4):
  xfs: match lock mode in xfs_buffered_write_iomap_begin()
  xfs: convert delayed extents to unwritten when zeroing post eof blocks
  iomap: don't increase i_size if it's not a write operation
  iomap: cleanup iomap_write_iter()

 fs/iomap/buffered-io.c | 78 +++++++++++++++++++++---------------------
 fs/xfs/xfs_iomap.c     | 39 ++++++++++++++++++---
 2 files changed, 73 insertions(+), 44 deletions(-)

-- 
2.39.2


