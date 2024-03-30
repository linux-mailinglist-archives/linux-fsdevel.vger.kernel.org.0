Return-Path: <linux-fsdevel+bounces-15765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CFB892B14
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 13:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 256B51C210C1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 12:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C2939FC1;
	Sat, 30 Mar 2024 12:10:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D219B3308A;
	Sat, 30 Mar 2024 12:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711800640; cv=none; b=pNuhuwHPJKg59ewr0SsrEsIAQQPIS9uSYVvMU/N2+62RA0Qe4zYSzwWuvgf8+9ft4gnH28ka01dm53ByfDXqf66ND/wlFc1SrOUMAHMacrF9mv1o2/po3kumIiG/YET20G9He7cNEnwr8en9Z+kVwh6Al3GaM1TwnzNQhPR7bVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711800640; c=relaxed/simple;
	bh=a+LNOdkQlYnSt/8ppmspGPD5Pv/kj3Xgnu7c4yJ9ic8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ljSoKX0x7m3xK44r3m2lL0ucS8IExoXrI8S65Z5cZZ91+N9rT7BJ7/PYdj6RcoglMcTTs67EC94R3jvJ6cjQeTL9JT49dZ2ZoK+unmvOZ4looRdFc5gLwhw6Oj/EIUTVVxmvCX/rJ3KS8eVTO7vwFjujzGW3uH+vfvUrZC1+O48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V6GLq3Mpxz4f3jQY;
	Sat, 30 Mar 2024 20:10:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 93F8E1A0232;
	Sat, 30 Mar 2024 20:10:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+REsAQhmkPEjIg--.10652S4;
	Sat, 30 Mar 2024 20:10:27 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH 0/7] ext4: support adding multi-delalloc blocks
Date: Sat, 30 Mar 2024 20:02:29 +0800
Message-Id: <20240330120236.3789589-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+REsAQhmkPEjIg--.10652S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Wry3JrWkZw1ftw13GF1kGrg_yoW8JFWfpF
	WS9a4Sgr48Ww1aga1fAa1UJF45Xw4fCr4UG343tw18ZrWDZFyfXFsrKF1F9ayrJrZ3ZFn0
	qF1a9ry8u3Wjk37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Hello!

This patch series is the part 2 prepartory changes of the buffered IO
iomap conversion, I picked them out from my buffered IO iomap conversion
RFC series v3[1], and add bigalloc feature support.

The first 6 patches make ext4_insert_delayed_block() call path support
inserting multi-delalloc blocks once a time, and the last patch makes
ext4_da_map_blocks() buffer_head unaware.

This patch set has been passed 'kvm-xfstests -g auto' tests, I hope it
could be reviewed and merged first.

[1] https://lore.kernel.org/linux-ext4/20240127015825.1608160-1-yi.zhang@huaweicloud.com/

Thanks,
Yi.

Zhang Yi (7):
  ext4: trim delalloc extent
  ext4: drop iblock parameter
  ext4: make ext4_es_insert_delayed_block() insert multi-blocks
  ext4: make ext4_da_reserve_space() reserve multi-clusters
  ext4: factor out check for whether a cluster is allocated
  ext4: make ext4_insert_delayed_block() insert multi-blocks
  ext4: make ext4_da_map_blocks() buffer_head unaware

 fs/ext4/extents_status.c    |  63 +++++++++-----
 fs/ext4/extents_status.h    |   5 +-
 fs/ext4/inode.c             | 165 ++++++++++++++++++++++--------------
 include/trace/events/ext4.h |  26 +++---
 4 files changed, 162 insertions(+), 97 deletions(-)

-- 
2.39.2


