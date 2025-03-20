Return-Path: <linux-fsdevel+bounces-44502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4F0A69ECD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 04:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DD9C3BA68E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 03:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1F81EDA3B;
	Thu, 20 Mar 2025 03:27:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C601EDA27
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 03:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742441259; cv=none; b=qrzfuGEzNAUm+5LtJC5PsuMcF2Fdh/JUAHY2fGkz5jTBludorUcYXFW6di6C/zUV3zmwl58lwi/QBn8T7raA8///2xLTPMgSacdxqkyDU6V6Vb1pdvbSyWB1j+SnFh318blzZIGSFNtTy4r0Ig/OVGB57OJFGoLojeRRqVvInrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742441259; c=relaxed/simple;
	bh=NdGbicUvIY97RXgtzGTNEjBlbhVlFY4x5SIhxVF/Y2I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ouPQDea2upyNTGMqQeww8mHF1Atcg8w3TPMGirJH1a/F9GL3J5xUCcbM8U47JCQ/BnuhWVRtlBQeMX0bICvBKeeplu5DGTnWMNeydetdd6uXDKIlSlAkc6kn7Ilr1o3QxM/it/l+2VqBKO1O/5Axiovp+xFYw3lkeQh8xdykd3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZJ9x75ThPz4f3lfd;
	Thu, 20 Mar 2025 11:27:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id E62651A17D2;
	Thu, 20 Mar 2025 11:27:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
	by APP3 (Coremail) with SMTP id _Ch0CgCn+sQii9tnJ8KoGw--.42997S4;
	Thu, 20 Mar 2025 11:27:31 +0800 (CST)
From: Yongjian Sun <sunyongjian@huaweicloud.com>
To: linux-fsdevel@vger.kernel.org,
	linux-mm@vger.kernel.org
Cc: yangerkun@huawei.com
Subject: [PATCH] libfs: Fix duplicate directory entry in offset_dir_lookup
Date: Thu, 20 Mar 2025 11:44:17 +0800
Message-Id: <20250320034417.555810-1-sunyongjian@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCn+sQii9tnJ8KoGw--.42997S4
X-Coremail-Antispam: 1UD129KBjvJXoW7trW7trW3Gr48Cw1UXr48Xrb_yoW8CF4kpF
	W5J3s0kw4kJr1xCw4qkF1kW34Ik39rGFsruFZ5Ww1rA398GFn7tF1xKF1Yq3s7Jrs3uw1q
	qF4Fy398J34UZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgGb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6r106r1rM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
	MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnI
	WIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: 5vxq505qjmxt3q6k3tpzhluzxrxghudrp/

From: Yongjian Sun <sunyongjian1@huawei.com>

There is an issue in the kernel:

In tmpfs, when using the "ls" command to list the contents
of a directory with a large number of files, glibc performs
the getdents call in multiple rounds. If a concurrent unlink
occurs between these getdents calls, it may lead to duplicate
directory entries in the ls output. One possible reproduction
scenario is as follows:

Create 1026 files and execute ls and rm concurrently:

for i in {1..1026}; do
    echo "This is file $i" > /tmp/dir/file$i
done

ls /tmp/dir				rm /tmp/dir/file4
	->getdents(file1026-file5)
						->unlink(file4)

	->getdents(file5,file3,file2,file1)

It is expected that the second getdents call to return file3
through file1, but instead it returns an extra file5.

The root cause of this problem is in the offset_dir_lookup
function. It uses mas_find to determine the starting position
for the current getdents call. Since mas_find locates the first
position that is greater than or equal to mas->index, when file4
is deleted, it ends up returning file5.

It can be fixed by replacing mas_find with mas_find_rev, which
finds the first position that is less than or equal to mas->index.

Fixes: b9b588f22a0c ("libfs: Use d_children list to iterate simple_offset directories")
Signed-off-by: Yongjian Sun <sunyongjian1@huawei.com>
---
 fs/libfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 8444f5cc4064..dc042a975a56 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -496,7 +496,7 @@ offset_dir_lookup(struct dentry *parent, loff_t offset)
 		found = find_positive_dentry(parent, NULL, false);
 	else {
 		rcu_read_lock();
-		child = mas_find(&mas, DIR_OFFSET_MAX);
+		child = mas_find_rev(&mas, DIR_OFFSET_MIN);
 		found = find_positive_dentry(parent, child, false);
 		rcu_read_unlock();
 	}
-- 
2.39.2


