Return-Path: <linux-fsdevel+bounces-61042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 031CCB54A83
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 13:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE6BE1BC1840
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 11:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EAB2FE591;
	Fri, 12 Sep 2025 11:00:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B272F2FDC2C;
	Fri, 12 Sep 2025 11:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757674814; cv=none; b=nBy8Rh5GYIf97VKrJybnD/Q6wIDDZw1Tq8GgDjTPxFRbrv7GuGXB6dhjlrHLfUC9tCsa24s1lbObdF5zZdzCV2NFkAnC9JjktOYoHE+t/gTNTnnYLX02N33OoPM7arDrVce1+6GOCams6AuCLi0beeS/0XnN6jE4Pg9YkN+thIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757674814; c=relaxed/simple;
	bh=SehddXTMIsz74GoDH6nj1R8W/jgXb6jePzjpjFOqgWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T1YsxjGtBoX2rRNmRxkMQPEEeKPN66VmtuOORiKRZCnZZfIAAeQ8wPFKmLt98XbUgqte4bhOJMWrn08AxXJK9xfbO8lofAHUUq4PWrm+SKvp0X9RLpdYw5PUNF6X+rftxpKR8BofC+DyayByMh6G9FQaKAtIAavbz0REI4crlRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cNWfW2hl0zYQvQs;
	Fri, 12 Sep 2025 19:00:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E08A21A155E;
	Fri, 12 Sep 2025 19:00:01 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgCn8Y0r_cNoFHACCQ--.47583S4;
	Fri, 12 Sep 2025 19:00:01 +0800 (CST)
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
Subject: [PATCH] ext4: fix an off-by-one issue during moving extents
Date: Fri, 12 Sep 2025 18:58:41 +0800
Message-ID: <20250912105841.1886799-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCn8Y0r_cNoFHACCQ--.47583S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4rGFWktF4fJF1UWF1xZrb_yoW8JFW5p3
	sIkay5KrW0qwnxCw4kW3Z7X3yUG34DKr47W34Fk3W7CFyay3409rWUK3Wq9a45tFWUJrWr
	XF4rKr15Za4UXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUFg4SDUUUU
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


