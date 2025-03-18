Return-Path: <linux-fsdevel+bounces-44262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C539A66BCF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 08:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F10C189A7A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 07:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA08E1F4CB3;
	Tue, 18 Mar 2025 07:34:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B701EF37E;
	Tue, 18 Mar 2025 07:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742283289; cv=none; b=q+CvfhqovZxd0MIKLOXSfWow5L8gqdLDiEa2YIF5BN5Riq8C+CJfBb0KSKKWmXouiwMMmWBDDzXm7nutrwcNi6oc2XXMcVZc9kTjwaBxmlmgPPQk/6ewqia7INXRgrAoudfIHNZJiR+rrMBNvMLyhu9A8vpGU2xbiYy79EZ7XUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742283289; c=relaxed/simple;
	bh=WFho1XHp84WTnAVFdUu9OrZndGAcg91IPCB+7SOw4gI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NDGajaoUB+9dSTYIgMRx4Z8l6/Kg3FPq6mP8p4hS9PrrURBJI9K+Iwzt/P5KumDZX7agTVJ3lplEgQ0woznZdiLOBipAs8zc+gZlkLIyzE47hJdiF4wHMXJ91ZBq3N2dlBwajTkUh1MxQBBzk5BxpuAfwxYMGqlqf0GCaPJtCPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZH3WJ5WLJz4f3khY;
	Tue, 18 Mar 2025 15:34:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5D3C11A058E;
	Tue, 18 Mar 2025 15:34:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCnCl8EItlnJDdYGw--.56140S4;
	Tue, 18 Mar 2025 15:34:40 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hch@lst.de,
	tytso@mit.edu,
	djwong@kernel.org,
	john.g.garry@oracle.com,
	bmarzins@redhat.com,
	chaitanyak@nvidia.com,
	shinichiro.kawasaki@wdc.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH xfstests 0/5] fstests: add fallocate write zeroes tests
Date: Tue, 18 Mar 2025 15:26:10 +0800
Message-ID: <20250318072615.3505873-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnCl8EItlnJDdYGw--.56140S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uFWfWryDtr43uFWfXr1DWrg_yoW8AF1kpa
	1vgr15tr4UGF17Crs3Gr1Dtrn5Aws7Gr4Ykr4xt34avFy8Aw18GF9Ygr1UXr93Cw18uw4Y
	yrs8Kryagw47A37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjTR_OzsDUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

The Linux kernel is planning to support FALLOC_FL_WRITE_ZEROES in
fallocate(2). Add tests for the newly added fallocate
FALLOC_FL_WRITE_ZEROES command. This series depends on the changes to
xfs_io [1] that introduced the 'fwzero' command.

 - generic/764 is an extension of generic/008, it is designed to test
   page boundaries for fwzero.
 - generic/765 is an extension of generic/009, it is designed to do
   generic functions tests for fwzero.
 - generic/766 is and extension of generic/349 and generic/351, it is
   designed to test fwzero on raw block device.
 - Finally, add FALLOC_FL_WRITE_ZEROES support for fstress and fsx.

[1] https://lore.kernel.org/linux-fsdevel/20250318072318.3502037-1-yi.zhang@huaweicloud.com/

Thanks,
Yi.

Zhang Yi (5):
  generic/764: add page boundaries tests for fallocate write zeroes
  generic/765: add generic tests for fallocate write zeroes
  generic/766: test fallocate write zeroes on block device
  fstress: add fallocate write zeroes support
  fsx: add fallocate write zeroes support

 common/rc             |   2 +-
 ltp/fsstress.c        |  12 ++
 ltp/fsx.c             |  80 ++++++++
 src/global.h          |   4 +
 tests/generic/764     |  34 ++++
 tests/generic/764.out | 433 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/765     |  40 ++++
 tests/generic/765.out | 269 ++++++++++++++++++++++++++
 tests/generic/766     |  80 ++++++++
 tests/generic/766.out |  23 +++
 10 files changed, 976 insertions(+), 1 deletion(-)
 create mode 100755 tests/generic/764
 create mode 100644 tests/generic/764.out
 create mode 100755 tests/generic/765
 create mode 100644 tests/generic/765.out
 create mode 100755 tests/generic/766
 create mode 100644 tests/generic/766.out

-- 
2.46.1


