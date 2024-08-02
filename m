Return-Path: <linux-fsdevel+bounces-24861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFCB945D73
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 13:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D77BB28286E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 11:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F45A1E289C;
	Fri,  2 Aug 2024 11:55:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9471DB44E;
	Fri,  2 Aug 2024 11:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722599708; cv=none; b=JzMpBViVpNI+2WvQjsnrf10NFQMfS9K2WyAzI31xkMUrIGfNAIEdoCPFQ9zrrlA6Dy42KS+JTsv1o0TizEKMHUyoVabI/Hvap67ipzG2GlTx6TrkqTGra6f1SMOhQzz9O6OSeiKSYKt3rk8QDtQWJYNpCv+vnFl4sRIcClwqT+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722599708; c=relaxed/simple;
	bh=lmFxQoS2dQENq/ej4zW2Ulekjz6OPFwd5UD+yLrQHyI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uNoZBkwfXkn9B+621DkKc+9bZcXcF8AuaAT2ozmBqb+buEfU1xDhmJsdlmI2hnJM5tKpTDUAdSV/us0yl1pn8djc3cMCwc9dG80pL5KViovFwUmwuwtQZu/HfQfa19bAI0tCOLjAlPdsUUPV2qM+5rlseHdQZcm8ODe038g/O2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wb4595j2Hz4f3k62;
	Fri,  2 Aug 2024 19:54:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8FE731A07BB;
	Fri,  2 Aug 2024 19:55:02 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgB3n4UJyaxmamI8Ag--.7970S4;
	Fri, 02 Aug 2024 19:55:00 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH v2 00/10] ext4: simplify the counting and management of delalloc reserved blocks
Date: Fri,  2 Aug 2024 19:51:10 +0800
Message-Id: <20240802115120.362902-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3n4UJyaxmamI8Ag--.7970S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww45JrW5Xr43ZrWxGrWUtwb_yoW8Zr4fpr
	WfC3W3Jr1kWw17WrZ3Aw1UJw1rW3WxCr4UWrWxKr18ua48AryxZFnrKF1rZFW5trWxAF1Y
	qF1jkw18Cas8C37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUZYFZUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

Changes since v1:
 - Just rebase to v6.11-rc1.

This patch series is the part 3 prepartory changes of the buffered IO
iomap conversion, it simplify the counting and updating logic of
delalloc reserved blocks. I picked them out from my buffered IO iomap
conversion RFC series v4[1], and did some minor improvements of commit
messages. This series is based on 6.11-rc1, after it we could save a lot
of code.

Patch 1-3 simplify the delalloc extent management logic by changes to
always set EXT4_GET_BLOCKS_DELALLOC_RESERVE flag when allocating
preallocated blocks, and don't add EXTENT_STATUS_DELAYED flag to an
unwritten extent, which means ext4_es_is_delayed() is equal to
ext4_es_is_delonly().

Patch 4-6 simplify the reserved blocks updating logic by moves the
reserved blocks updating from ext4_{ind|ext}_map_blocks() to
ext4_es_insert_extent().

Patch 7-10 drop the unused code (e.g. ext4_es_is_delonly())and update
comments.

[1] https://lore.kernel.org/linux-ext4/20240410142948.2817554-1-yi.zhang@huaweicloud.com/

Thanks,
Yi.

Zhang Yi (10):
  ext4: factor out ext4_map_create_blocks() to allocate new blocks
  ext4: optimize the EXT4_GET_BLOCKS_DELALLOC_RESERVE flag set
  ext4: don't set EXTENT_STATUS_DELAYED on allocated blocks
  ext4: let __revise_pending() return newly inserted pendings
  ext4: count removed reserved blocks for delalloc only extent entry
  ext4: update delalloc data reserve spcae in ext4_es_insert_extent()
  ext4: drop ext4_es_delayed_clu()
  ext4: use ext4_map_query_blocks() in ext4_map_blocks()
  ext4: drop ext4_es_is_delonly()
  ext4: drop all delonly descriptions

 fs/ext4/extents.c        |  37 ------
 fs/ext4/extents_status.c | 271 ++++++++++++++++-----------------------
 fs/ext4/extents_status.h |   7 -
 fs/ext4/indirect.c       |   7 -
 fs/ext4/inode.c          | 197 +++++++++++++---------------
 5 files changed, 195 insertions(+), 324 deletions(-)

-- 
2.39.2


