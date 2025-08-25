Return-Path: <linux-fsdevel+bounces-58975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 945F1B339E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 10:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 367C53BFFC0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 08:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A462BDC03;
	Mon, 25 Aug 2025 08:50:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CC029D264;
	Mon, 25 Aug 2025 08:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756111856; cv=none; b=fDRB1qUVWx2LHu83hlqi6OW/d0S3qOZEr74RMvSQvHX5sJE/6/6zM/IxenbtOuG9n6MtKPO5EqaNUaxa0/Lx+cHcz80k5Uuw5nYge9tP7pMBpLtDZHqPrswXZMFG/04yZcSiG9ou9bds343xvZRkM7SwbB4CfdqIQ4tdYYgrkB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756111856; c=relaxed/simple;
	bh=QdjvERvpM52UKi4kyoZp4h/KbIyBUz6pCIrnYzo21+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dmEOEBmqDCv4t0xdVBbKPJc73ES8xrlg/HZ086F4ZNWnTg9cyI0KdIypAuvluD4WeD6shSCpzgvRPNvHE0kgFYjQ+NU0a4rxgvg/LWUrSedVwitcgiGKm8hmI5it4Ufb6Y4asm8EM9lIKv7nMr3WDJeNImuoEYSr9SX9zZyKIKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c9PFy30jLzKHNk1;
	Mon, 25 Aug 2025 16:33:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 01A901A0C2C;
	Mon, 25 Aug 2025 16:33:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgAncIzcH6xoZc7rAA--.43322S4;
	Mon, 25 Aug 2025 16:33:41 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org,
	drbd-dev@lists.linbit.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	john.g.garry@oracle.com,
	hch@lst.de,
	martin.petersen@oracle.com,
	axboe@kernel.dk,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 0/2] Fix the initialization of max_hw_wzeroes_unmap_sectors for stacking drivers
Date: Mon, 25 Aug 2025 16:33:18 +0800
Message-ID: <20250825083320.797165-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAncIzcH6xoZc7rAA--.43322S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr43GryxXF18XF1xury7GFg_yoWxCwcEyF
	4fXrZIvr4kC3WIvr43GFn3Aryjvay8WF1qgry2g3yFqa1fZF1rCF1jv345J3W0yFy0qrZ8
	Ar1Dtw1xArnxXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Hello,

This series fixes the initialization of max_hw_wzeroes_unmap_sectors in
queue_limits for all md raid and drbd drivers, preventing
blk_validate_limits() failures on underlying devices that support the
unmap write zeroes command.

Best regards,
Yi.

Zhang Yi (2):
  md: init queue_limits->max_hw_wzeroes_unmap_sectors parameter
  drbd: init queue_limits->max_hw_wzeroes_unmap_sectors parameter

 drivers/block/drbd/drbd_nl.c | 1 +
 drivers/md/md-linear.c       | 1 +
 drivers/md/raid0.c           | 1 +
 drivers/md/raid1.c           | 1 +
 drivers/md/raid10.c          | 1 +
 drivers/md/raid5.c           | 1 +
 6 files changed, 6 insertions(+)

-- 
2.46.1


