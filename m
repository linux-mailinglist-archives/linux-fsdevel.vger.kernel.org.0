Return-Path: <linux-fsdevel+bounces-78673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKLQCRwIoWlXpwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 03:57:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6F71B221C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 03:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0F6630713CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 02:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01352FF148;
	Fri, 27 Feb 2026 02:57:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBEF2FF140
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 02:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772161040; cv=none; b=C+j6DyNk7xWIAsNPi6bjiMi898yurXGl+JFW6LLovgkGncNkGIHF3TNNZjw99SRfBkD1Qo5xHzbKI9JAvByjqCQpLBUlij3PJ2ozM1DQ9F37jpZF1EhN/fdASmPevL7CBhIMfthv6Jl2tP4CYOYtKVsk7KMcnNT4U5zOp8dWi7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772161040; c=relaxed/simple;
	bh=YQPDUz6dwT2AAzb3zKocnX1wL6n/fVlA1xzTuZIjYMI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pTvtjbfqjIrCyEf7xHejuqt/ifSt6Mq+HEuUl4pLix4zy918/tqsuNVVAkc5pz01gv1MD+m5txhNVe/QFeodLhYWVVuMyidIsCpBkFJiwmXl2bNxY9UPkxndEraZj0espfU3V1atdMgf6HL7kumb3MqPVgmLDQff1V4yPFikgms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fMXzN3tSNzYQtj0
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 10:56:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id EF1AE40590
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 10:57:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.132])
	by APP4 (Coremail) with SMTP id gCh0CgBXuPgJCKFpsEGdIw--.32070S4;
	Fri, 27 Feb 2026 10:57:13 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	david@fromorbit.com,
	zhengqi.arch@bytedance.com,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	linux-mm@kvack.org,
	yebin10@huawei.com
Subject: [PATCH v3 0/3] add support for drop_caches for individual filesystem
Date: Fri, 27 Feb 2026 10:55:45 +0800
Message-Id: <20260227025548.2252380-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXuPgJCKFpsEGdIw--.32070S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1fCF4UKw4kJr4xZw1xGrg_yoW8Cr1xpa
	9ruw15Kr4rAF1fGr93Aw48Z3WFvw4kua17t3ZxWw1FyrnxAFyIvrnI93y5XFyDZrW7uw4q
	v3WDtr1Yg34DZw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
	tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IUbmii3UUUUU==
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[huaweicloud.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78673-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yebin@huaweicloud.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huaweicloud.com:mid]
X-Rspamd-Queue-Id: 7F6F71B221C
X-Rspamd-Action: no action

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

Diff v3 vs v2
1. Introduce introduce drop_sb_dentry_inode() helper instead of
reclaim_dcache_sb()/reclaim_icache_sb() helper for reclaim dentry/inode.
2. Fixing compilation issues in specific architectures and configurations.

Diff v2 vs v1:
1. Fix possible live lock for shrink_icache_sb().
2. Introduce reclaim_dcache_sb() for reclaim dentry.
3. Fix potential deadlocks as follows:
https://lore.kernel.org/linux-fsdevel/00000000000098f75506153551a1@google.com/
After some consideration, it was decided that this feature would primarily
be used for debugging purposes. Instead of adding a new IOCTL command, the
task_work mechanism was employed to address potential deadlock issues.

Ye Bin (3):
  mm/vmscan: introduce drop_sb_dentry_inode() helper
  sysctl: add support for drop_caches for individual filesystem
  Documentation: add instructions for using 'drop_fs_caches sysctl'
    sysctl

 Documentation/admin-guide/sysctl/vm.rst |  44 +++++++++
 fs/drop_caches.c                        | 125 ++++++++++++++++++++++++
 include/linux/mm.h                      |   1 +
 mm/internal.h                           |   3 +
 mm/shrinker.c                           |   4 +-
 mm/vmscan.c                             |  50 ++++++++++
 6 files changed, 225 insertions(+), 2 deletions(-)

-- 
2.34.1


