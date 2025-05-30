Return-Path: <linux-fsdevel+bounces-50147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D82AC8852
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 08:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BE1D7B2BE4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 06:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F3B21771F;
	Fri, 30 May 2025 06:41:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418701F0E4F;
	Fri, 30 May 2025 06:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748587295; cv=none; b=jTTW+t9xuu2CoPyKTN4dFj5axac8qvYi7kWTGqyz+pGnKv1/q9V39YJEh1oR2JBuWU3qP+vOP3HDzL75xi+RSLfm3ls6UQGePbx9x8rz53hnEDYc921IYX6EwxDzhSY7TbMxxpnDakITQl+CaUZz3/ELKHuzMLHleikymUQp7Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748587295; c=relaxed/simple;
	bh=9sFOwelv5fYdviKsYOi6adhX1HjIA7FitQc+BiYdpsk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ctEpzZtUQGeedKmb3OI6YIQH70tSN8ByQhnEk4jwNEGsUvk7nBnmRLjBlQD8DOoOd18cr+wN1/05BEKpHoXyjk+7wMYy9xaANTXlF/GUknCGkLX5HyqWRWSsxObHXYQe5nWEmEmVPQKP6rBaI+rmH8D6j42AVdgOHsiOW4Sc+Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4b7ttg0JmVzKHLw5;
	Fri, 30 May 2025 14:41:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 72BF51A190E;
	Fri, 30 May 2025 14:41:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgD3Wl8PUzlo_wXRNw--.6893S4;
	Fri, 30 May 2025 14:41:27 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	libaokun1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 0/5] ext4: fix insufficient credits when writing back large folios
Date: Fri, 30 May 2025 14:28:53 +0800
Message-ID: <20250530062858.458039-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3Wl8PUzlo_wXRNw--.6893S4
X-Coremail-Antispam: 1UD129KBjvJXoW7CrWrGrWDuw4Dur4xZFyrWFg_yoW8AF4kpa
	93CF95Gw15ua47ZF4fZa1xJF1rG3y8ur4UJFnrXr1DWa98uF1Ikrn3Ka15KFWUJr4xGFyY
	qr1jkryDGFZ8ArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

This series addresses the issue that Jan pointed out regarding large
folios support for ext4[1]. The problem is that the credits calculation
may insufficient in ext4_meta_trans_blocks() when allocating blocks
during write back a sufficiently large and discontinuous folio, it
doesn't involve the credits for updating bitmap and group descriptor
block. However, if we fix this issue, it may lead to significant
overestimation on the some filesystems with a lot of block groups.

The solution involves first reserving credit for one page when writing
back a sufficiently large and discontinuous folio, and then attempting
to extend the current transaction's credits. If the credits reach the
upper limit, the handler stops and initiates a new transaction. Again,
fix the wrong credits calculation in ext4_meta_trans_blocks(). Finally,
this solution only works in dioread_nolock mode, so disable large folios
if dioread_nolock is disabled. Please see the following patches for
details.

[1] https://lore.kernel.org/linux-ext4/ht54j6bvjmiqt62xmcveqlo7bmrunqs4ji7wikfteftdjijzek@7tz5gpejaoen/

Thanks,
Yi.

Zhang Yi (5):
  ext4: restart handle if credits are insufficient during writepages
  ext4: correct the reserved credits for extent conversion
  ext4/jbd2: reintroduce jbd2_journal_blocks_per_page()
  ext4: fix insufficient credits calculation in ext4_meta_trans_blocks()
  ext4: disable large folios if dioread_nolock is not enabled

 fs/ext4/ext4_jbd2.h  | 14 ++++++++++
 fs/ext4/inode.c      | 64 +++++++++++++++++++++++++++++++++++---------
 fs/jbd2/journal.c    |  6 +++++
 include/linux/jbd2.h |  1 +
 4 files changed, 72 insertions(+), 13 deletions(-)

-- 
2.46.1


