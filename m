Return-Path: <linux-fsdevel+bounces-31561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2586F9987C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 15:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AE9A28960D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 13:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B091C9DFD;
	Thu, 10 Oct 2024 13:35:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8941BC9EE;
	Thu, 10 Oct 2024 13:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728567346; cv=none; b=CNVrdd62McBOM+KiSU/P6lGzGttQPmHeBODFVOX6iHqHooPtFhDtw7csNYCFbA3rwGSW3zW3A7fBQ/O0+GYWNuniTIia03RmAUU51+81qAWG6oZWA/H6jqb8VIDp0Zy+Gf36XdD7mwTJhf4p188LGsNqDhkALHmayVZkd+91/SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728567346; c=relaxed/simple;
	bh=Efhrzb5QbMg8lfmuRIBsdj0eQQ/aZ8Jq26Wl5piij44=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rFn6Vco9iYWMIbje4i0GNIUP5OfjFNv4Bte1juLNqHkH+e68s/pM2GwfiZxVONpAqUa2g0RlJj4kHxrH4d4UdmJGN59alAB8yHl411oBwwi1RPz7xbhDOFi7+w7+gndPlnlpzUCJOZ681POzYsXZ+EC+VwScQom+itcytDCkfic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XPW3N5Wwtz4f3jt2;
	Thu, 10 Oct 2024 21:35:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8F47F1A07B6;
	Thu, 10 Oct 2024 21:35:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCXysYc2AdnDRnZDg--.21356S4;
	Thu, 10 Oct 2024 21:35:38 +0800 (CST)
From: Zhang Yi <yi.zhang@huawei.com>
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
Subject: [PATCH v3 00/10] ext4: clean up and refactor fallocate
Date: Thu, 10 Oct 2024 21:33:23 +0800
Message-Id: <20241010133333.146793-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXysYc2AdnDRnZDg--.21356S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGr4xZr1fWr15AFy3JFyxKrg_yoW5Gr1fpF
	ZxW3WSqr1UW3sxCrn7Wa1xXF1rKw4rJay7JryIg34I9w4kuFyIqF4DtayF9FWxArW5JF1j
	vr4jvw1Du3WDCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0aVACjI8F5VA0II8E6IAqYI8I648v4I1l
	FIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr4
	1l42xK82IY64kExVAvwVAq07x20xyl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF0Pf
	DUUUU
Sender: yi.zhang@huaweicloud.com
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

Changes since v2:
 - Add Patch 1 to address a newly discovered data loss issue that occurs
   when using mmap to write after zeroing out a partial page on a
   filesystem with the block size smaller than the page size.
 - Do not write all data before punching hole, zeroing out and
   collapsing range as Jan suggested, also drop current data writeback
   in ext4_punch_hole().
 - Since we don't write back all data in these 4 operations, we only
   writeback data during inserting range,so do not factor out new
   helpers in the last two patches, just move common components of
   sub-operations into ext4_fallocate().
 - Only keep Jan's review tag on patch 02 and 08, other patches contain
   many code adaptations since v2, so please review them again.
Changes since v1:
 - Fix an using uninitialized variable problem in the error out path in
   ext4_do_fallocate() in patch 08.

v2: https://lore.kernel.org/linux-ext4/20240904062925.716856-1-yi.zhang@huaweicloud.com/

Current ext4 fallocate code is mess with mode checking, locking, input
parameter checking, position calculation, and having some stale code.
Almost all five sub-operation share similar preparation steps, so it
deserves a cleanup now.

This series tries to improve the code by refactoring all operations
related to fallocate. It unifies variable naming, reduces unnecessary
position calculations, and factors out common preparation components.

The first patch addresses a potential data loss issue that occurs when
using mmap to write after zeroing out partial blocks of a page on a
filesystem where the block size is smaller than the page size.
Subsequent patches focus on cleanup and refactoring, please see them for
details. After this series, we will significantly reduce redundant code
and enhance clarity compared to the previous version.

Thanks,
Yi.


Zhang Yi (10):
  ext4: remove writable userspace mappings before truncating page cache
  ext4: don't explicit update times in ext4_fallocate()
  ext4: don't write back data before punch hole in nojournal mode
  ext4: refactor ext4_punch_hole()
  ext4: refactor ext4_zero_range()
  ext4: refactor ext4_collapse_range()
  ext4: refactor ext4_insert_range()
  ext4: factor out ext4_do_fallocate()
  ext4: move out inode_lock into ext4_fallocate()
  ext4: move out common parts into ext4_fallocate()

 fs/ext4/ext4.h    |   2 +
 fs/ext4/extents.c | 532 ++++++++++++++++++----------------------------
 fs/ext4/inode.c   | 188 ++++++++--------
 3 files changed, 303 insertions(+), 419 deletions(-)

-- 
2.39.2


