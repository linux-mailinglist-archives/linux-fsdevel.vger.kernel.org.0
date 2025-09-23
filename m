Return-Path: <linux-fsdevel+bounces-62457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E21B93DAC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 03:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D2B71888AF8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 01:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BCB264A7F;
	Tue, 23 Sep 2025 01:29:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35EF24169A;
	Tue, 23 Sep 2025 01:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758590974; cv=none; b=a3G7UgdMLCZdpOd3kl0+USh7N1BdtXthILEUKJ3IfT9nMLacjszv7FWmxdbZWSZv/U80XdKZiROzvTWnrcZR3qpfMoa4be4g/Ane3Vxxe5NxiNnsxoU1yR7MLAAH0n3IJCemeN0KgxzacID95gaWfJnrzHIHldac+62LoyxtfH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758590974; c=relaxed/simple;
	bh=2c9J4BVQOGD7WKgfMY5Roo5DXPkX37AymVYJDjwHoC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UEZlGRKnyKLBIwqM3B7Axm19EiWaqq2Xh6Inq5SQ1lq7B14i63TwGiCTtrt1ZzJZXqNsOzlFe+ws8NHgaIB4LABuM7fMqnJsSyCLZ5pOF7jpX118qsyM3W5s4214Obymb5+ZN4WQl5E+LSEdW6edwDzcrM2+79C1E8rFr56nwB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cW2St73wCzYQtHC;
	Tue, 23 Sep 2025 09:29:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 272031A0FA1;
	Tue, 23 Sep 2025 09:29:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgAXKWHq99FoGYYGAg--.10941S5;
	Tue, 23 Sep 2025 09:29:24 +0800 (CST)
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
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 01/13] ext4: fix an off-by-one issue during moving extents
Date: Tue, 23 Sep 2025 09:27:11 +0800
Message-ID: <20250923012724.2378858-2-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250923012724.2378858-1-yi.zhang@huaweicloud.com>
References: <20250923012724.2378858-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXKWHq99FoGYYGAg--.10941S5
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4rGFWktF4fJF1UWF1xZrb_yoW8Gr1xp3
	4aka45KrW0qwnxCw4kW3Z7X3yUG34DKr47Wa4Fkw17CFyay3409rWUK3Wq9a45tFWDJF4r
	XF4Fkr15Za4UXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUTT5JUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

During the movement of a written extent, mext_page_mkuptodate() is
called to read data in the range [from, to) into the page cache and to
update the corresponding buffers. Therefore, we should not wait on any
buffer whose start offset is >= 'to'. Otherwise, it will return -EIO and
fail the extents movement.

 $ for i in `seq 3 -1 0`; \
   do xfs_io -fs -c "pwrite -b 1024 $((i * 1024)) 1024" /mnt/foo; \
   done
 $ umount /mnt && mount /dev/pmem1s /mnt  # drop cache
 $ e4defrag /mnt/foo
   e4defrag 1.47.0 (5-Feb-2023)
   ext4 defragmentation for /mnt/foo
   [1/1]/mnt/foo:    0%    [ NG ]
   Success:                       [0/1]

Fixes: a40759fb16ae ("ext4: remove array of buffer_heads from mext_page_mkuptodate()")
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/move_extent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index adae3caf175a..4b091c21908f 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -225,7 +225,7 @@ static int mext_page_mkuptodate(struct folio *folio, size_t from, size_t to)
 	do {
 		if (bh_offset(bh) + blocksize <= from)
 			continue;
-		if (bh_offset(bh) > to)
+		if (bh_offset(bh) >= to)
 			break;
 		wait_on_buffer(bh);
 		if (buffer_uptodate(bh))
-- 
2.46.1


