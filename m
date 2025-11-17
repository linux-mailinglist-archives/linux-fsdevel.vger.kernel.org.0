Return-Path: <linux-fsdevel+bounces-68715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D567BC63D4A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 12:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4296635C539
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 11:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E4432863C;
	Mon, 17 Nov 2025 11:27:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C672C3261;
	Mon, 17 Nov 2025 11:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763378863; cv=none; b=kBIEMazHSlbHnuht+Fe+Vk/c0LZCtMT9mypzswmzHGkhL3BjGOSqdJVYhmDHnWRoLAVy1RmOK+44/zkevy1dCxs4sjSsFICUDKF+XdEO0kdoF3LS6AtT0jxlapDr0wmP0RrknwM2KjQe3yQC0OCtnTwe0ywCBT0b+3AypYLcOE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763378863; c=relaxed/simple;
	bh=K4AKOQMbVGt6Y4ETHeZcDZeqQIy4nyQpnNUjox/WmmM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CpdsMwIKJpRLGRYIjmEF+Vo0EA7VaJznGXT2jkUkHW9XIKsMN0Zgv9jRH4T+OT2IlJsqttBvrBbSjLlBrUX/XPV91dPqKdquNgNoy5KvR0W90UkTqPZ+7d/H9b0fgBaKafQqsHUAD4oumIbwHUbsyY2cdK9XFVglI4RizMBrHYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d957974BhzYQvCF;
	Mon, 17 Nov 2025 19:27:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id B12541A1767;
	Mon, 17 Nov 2025 19:27:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.132])
	by APP2 (Coremail) with SMTP id Syh0CgAnhXunBhtp39Q6BA--.30165S4;
	Mon, 17 Nov 2025 19:27:36 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	yebin10@huawei.com
Subject: [PATCH v2 0/3] add support for drop_caches for individual filesystem
Date: Mon, 17 Nov 2025 19:27:32 +0800
Message-Id: <20251117112735.4170831-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAnhXunBhtp39Q6BA--.30165S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1fCF4UKw4kJr4xZw1xGrg_yoW8Xw4kpa
	9rur15K3yrAFyfGrn3Aw4j9F4rZw4kuF43t3ZxWr1FywnxAa4Ivrn2krW5ZFyDZrW29anF
	y3WDtw1jg34DZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2NtUUUUU=
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

In order to better analyze the issue of file system uninstallation caused
by kernel module opening files, it is necessary to perform dentry recycling
on a single file system. But now, apart from global dentry recycling, it is
not supported to do dentry recycling on a single file system separately.
This feature has usage scenarios in problem localization scenarios.At the
same time, it also provides users with a slightly fine-grained
pagecache/entry recycling mechanism.
This patchset supports the recycling of pagecache/entry for individual file
systems.

Diff v2 vs v1:
1. Fix possible live lock for shrink_icache_sb().
2. Introduce reclaim_dcache_sb() for reclaim dentry.
3. Fix potential deadlocks as follows:
https://lore.kernel.org/linux-fsdevel/00000000000098f75506153551a1@google.com/
After some consideration, it was decided that this feature would primarily
be used for debugging purposes. Instead of adding a new IOCTL command, the
task_work mechanism was employed to address potential deadlock issues.

Ye Bin (3):
  vfs: introduce reclaim_icache_sb() and reclaim_dcache_sb() helper
  sysctl: add support for drop_caches for individual filesystem
  Documentation: add instructions for using 'drop_fs_caches sysctl'
    sysctl

 Documentation/admin-guide/sysctl/vm.rst |  34 +++++++
 fs/dcache.c                             |  22 ++++
 fs/drop_caches.c                        | 127 ++++++++++++++++++++++++
 fs/inode.c                              |  21 ++++
 fs/internal.h                           |   1 +
 include/linux/dcache.h                  |   1 +
 6 files changed, 206 insertions(+)

-- 
2.34.1


