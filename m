Return-Path: <linux-fsdevel+bounces-60760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3724BB5152F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 13:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 942BD1C83AD6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 11:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764AC31B115;
	Wed, 10 Sep 2025 11:12:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CF731987A;
	Wed, 10 Sep 2025 11:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757502750; cv=none; b=KUYebJQ3dnvfagLjezNp4DqT5b2fEVapmr+0eeqNJpV0ZMXlVgilHqG0jI3TKoX2vr6j/SilI45fVYPiWPW6/6Mfi/xZ9XrMaq8g6Ygn8D1F84mUKkUZHofeHJI+gbG49Fz0vfmweCNUdKXY3OGTuASeC9yi4qdYmuR9H0N8N50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757502750; c=relaxed/simple;
	bh=RkMW71KR4d8IcNGzo6QwDQJqUX0PSB059k24VbnjrpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dkX/GdGrR9Lv69FrpyGXpiJTJaFOqaYIeEqhOMx0IHO+iEnBDS3t22R8MHCMxePT17gKegEpPkUmNnqHmwf+bZaegdPwHA2JwUDRC5clTMochmiu+RzwAK2COkQgoB+PrTS3qUisWiMQ1c7a8c0h/6ybDuYxeHOhL4Y3kLMMs60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cMJ1j5GQCzYQvPJ;
	Wed, 10 Sep 2025 19:12:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 37CA61A1005;
	Wed, 10 Sep 2025 19:12:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgCn8Y0OXcFonCkfCA--.57678S4;
	Wed, 10 Sep 2025 19:12:22 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org,
	drbd-dev@lists.linbit.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	john.g.garry@oracle.com,
	pmenzel@molgen.mpg.de,
	hch@lst.de,
	martin.petersen@oracle.com,
	axboe@kernel.dk,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v2 0/2] Fix the initialization of max_hw_wzeroes_unmap_sectors for stacking drivers
Date: Wed, 10 Sep 2025 19:11:05 +0800
Message-ID: <20250910111107.3247530-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCn8Y0OXcFonCkfCA--.57678S4
X-Coremail-Antispam: 1UD129KBjvdXoW7XFy8Jr4kZrWDCrW5tF13Jwb_yoWDGrXE9F
	4Sqr9xZr4kGa12yr4UGFn3AFy2v348WF1qgryqgayFgw4fZF45CF4qv345J3WjyFy0vFZ8
	AF1ktw47ZrnxXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
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

Changes since v1:
 - Improve commit messages in patch 1 by adding a simple reproduction
   case as Paul suggested and explaining the implementation differences
   between RAID 0 and RAID 1/10/5, no code changes.

v1: https://lore.kernel.org/linux-block/20250825083320.797165-1-yi.zhang@huaweicloud.com/

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


