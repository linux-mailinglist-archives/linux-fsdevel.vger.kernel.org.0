Return-Path: <linux-fsdevel+bounces-66550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47360C23689
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 07:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03A6A3B32DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 06:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B083016EC;
	Fri, 31 Oct 2025 06:31:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1742EDD64;
	Fri, 31 Oct 2025 06:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761892286; cv=none; b=S51sDW4h9nZ5xlLfgvpvVZTICC9PAa0Ua/6k5AY6NmUrlskCL840o8qUXp96VRFwB9DlF67MKXsvgaQIggswIjjetZYX0rnABMkbSLBNIZSPmkD4B/5klQvuJ+TMClMty50+jTOj5r+R+02NJ/aDZ6WenGArQ9+MW40vFYTwFNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761892286; c=relaxed/simple;
	bh=8m42JcAQvJEaTiHTQMcTCJ98xv4AIRUlejmBaMD4oeM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XGhyDC8mO8phX9fqMyB2Ed7WlDk/qaAOQjnWFnxzEWZxNJMxqh8Spk8iRubvvKD+U5mtQGj+wAsEX1a315ztu4+gnXUzzyBy90pbvay8tdJKUBW9fdZsu3pyaUy94V38ULmMutHzYpihR5viFlo+O3iF6pVsr2U06tDZntnpirA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cyWLh1sPDzKHM0X;
	Fri, 31 Oct 2025 14:30:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id E5D451A0847;
	Fri, 31 Oct 2025 14:31:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP2 (Coremail) with SMTP id Syh0CgBHnESuVwRpEFrWCA--.33311S4;
	Fri, 31 Oct 2025 14:31:18 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	libaokun1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 0/4] ext4: replace ext4_es_insert_extent() when caching on-disk extents
Date: Fri, 31 Oct 2025 14:29:01 +0800
Message-ID: <20251031062905.4135909-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHnESuVwRpEFrWCA--.33311S4
X-Coremail-Antispam: 1UD129KBjvJXoW7CF48ZFy7uF45Ar47tF4UCFg_yoW8GF48pr
	ZxCw1rXr1rW3y7Ga93Jw47tr1fGan7Cr4xZryfKw1xuFyUZFy7ursFka1UZa4fXrWxAr15
	XF45tr1kG3WUA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

This series addresses the optimization that Jan pointed out [1]
regarding the introduction of a sequence number to
ext4_es_insert_extent(). The proposal is to replace all instances where
the cache of on-disk extents is updated by using ext4_es_cache_extent()
instead of ext4_es_insert_extent(). This change can prevent excessive
cache invalidations caused by unnecessarily increasing the extent
sequence number when reading from the on-disk extent tree. This seires
has no dependency on the patch set[2] that introduced the extent
sequence number, so it can be merged independently.

[1] https://lore.kernel.org/linux-ext4/ympvfypw3222g2k4xzd5pba4zhkz5jihw4td67iixvrqhuu43y@wse63ntv4s6u/
[2] https://lore.kernel.org/linux-ext4/20251013015128.499308-1-yi.zhang@huaweicloud.com/

Thanks,
Yi.

Zhang Yi (4):
  ext4: make ext4_es_cache_extent() support overwrite existing extents
  ext4: check for conflicts when caching extents
  ext4: adjust the debug info in ext4_es_cache_extent()
  ext4: replace ext4_es_insert_extent() when caching on-disk extents

 fs/ext4/extents.c        |  8 ++---
 fs/ext4/extents_status.c | 75 +++++++++++++++++++++++++++++++++++-----
 fs/ext4/extents_status.h |  2 +-
 fs/ext4/inode.c          | 18 +++++-----
 4 files changed, 81 insertions(+), 22 deletions(-)

-- 
2.46.1


