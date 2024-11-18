Return-Path: <linux-fsdevel+bounces-35083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABB39D100C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 12:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AFA0B2742F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 11:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F3A1993A3;
	Mon, 18 Nov 2024 11:45:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6356148827;
	Mon, 18 Nov 2024 11:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731930315; cv=none; b=BAgOl0gXIMCP/p3o8BrhHQUszBAtPUkc8hROj9m0TSU6WHq5o7p6nUcY7ga4b0P+gJKGeTGTcYp7vze5HhMlYtCoGrr3y+H6Lcfz5IbliTmeCj1uQyJ49csX429NUlvFNBYfi0J2F9aYZ5U4S1g/ZWTv8y4/ftjGdoIgjRoZ94g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731930315; c=relaxed/simple;
	bh=rcgFhFs++ejbghwtrVjfsT60p3rYlOkju6ZDDpb8mZg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L3sVYJAXZkRqX5n8AtN1jU2126urH5t7hI63RtKzP96CRSkGjABIx5bhiANaQ+kyKu7cyHehCKx4LQuxh5ipq44eNzUDG0fnJauA6Gx4kkKUysEH5uDPfPMbkjOpqu7uTv+DIz8Mul7XxzAbiK0s4JStHBihmATla3ysFjFS1RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XsQlm45H7z4f3jXJ;
	Mon, 18 Nov 2024 19:44:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 04FE61A0568;
	Mon, 18 Nov 2024 19:45:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.107])
	by APP4 (Coremail) with SMTP id gCh0CgCnzoLEKDtn3fCKCA--.48005S4;
	Mon, 18 Nov 2024 19:45:10 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	axboe@kernel.dk,
	linux-block@vger.kernel.org,
	agruenba@redhat.com,
	gfs2@lists.linux.dev,
	amir73il@gmail.com,
	mic@digikod.net,
	gnoack@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	linux-security-module@vger.kernel.org
Cc: yebin10@huawei.com,
	zhangxiaoxu5@huawei.com
Subject: [PATCH 00/11] fix hungtask due to repeated traversal of inodes list
Date: Mon, 18 Nov 2024 19:44:57 +0800
Message-Id: <20241118114508.1405494-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnzoLEKDtn3fCKCA--.48005S4
X-Coremail-Antispam: 1UD129KBjvJXoWxJr4fuF15Xr1DWw45ZFyDGFg_yoW8WrW8pF
	43XFW3XF4UJry3Wr93Jw18Xw1Syan5GrWDJrW7tw13Xr45Aryayr4Iyw1YgFyDWFWrZw1Y
	9r4UC3y7uF1DXrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8
	ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU0s2-5UUUUU==
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

As commit 04646aebd30b ("fs: avoid softlockups in s_inodes iterators")
introduces the retry logic. In the problem environment, the 'i_count'
of millions of files is not zero. As a result, the time slice for each
traversal to the matching inode process is almost used up, and then the
traversal is started from scratch. The worst-case scenario is that only
one inode can be processed after each wakeup. Because this process holds
a lock, other processes will be stuck for a long time, causing a series
of problems.
To solve the problem of repeated traversal from the beginning, each time
the CPU needs to be freed, a cursor is inserted into the linked list, and
the traversal continues from the cursor next time.

Ye Bin (11):
  fs: introduce I_CURSOR flag for inode
  block: use sb_for_each_inodes API
  fs: use sb_for_each_inodes API
  gfs2: use sb_for_each_inodes API
  fs: use sb_for_each_inodes_safe API
  fsnotify: use sb_for_each_inodes API
  quota: use sb_for_each_inodes API
  fs/super.c: use sb_for_each_inodes API
  landlock: use sb_for_each_inodes API
  fs: fix hungtask due to repeated traversal of inodes list
  fs: fix potential soft lockup when 'sb->s_inodes' has large number of
    inodes

 block/bdev.c           |  4 +--
 fs/drop_caches.c       |  2 +-
 fs/gfs2/ops_fstype.c   |  2 +-
 fs/inode.c             | 59 ++++++++++++++++++++++++++++--------------
 fs/notify/fsnotify.c   |  2 +-
 fs/quota/dquot.c       |  4 +--
 fs/super.c             |  2 +-
 include/linux/fs.h     | 45 ++++++++++++++++++++++++++++++++
 security/landlock/fs.c |  2 +-
 9 files changed, 93 insertions(+), 29 deletions(-)

-- 
2.34.1


