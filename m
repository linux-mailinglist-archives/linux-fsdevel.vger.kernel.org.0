Return-Path: <linux-fsdevel+bounces-22729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2992F91B71C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 08:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74556B20EE0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 06:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71B17641D;
	Fri, 28 Jun 2024 06:31:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D65D27E;
	Fri, 28 Jun 2024 06:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719556267; cv=none; b=KDnaoSNKY2ozUEtXaclx9D8g1MzdHsDnKrGi2GHBvyDxZl++UpscQPqQirCI6RIOFG/F7JijBgJ+gykYf8mTeQK96pw84v12KBpPekmAu/zBdPHSbgnScTbIE2ih2omg6U9DTl4XUCbsKXo7ynQD4BFQo5z4yjZ236780zYhUqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719556267; c=relaxed/simple;
	bh=OB3rG63lQv8Wc0U7H2NQzqY5pNuhOA7iXsARZQPDZro=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=URKt3QRLxlHOMxWqaNsf9cWwY8vmrI3hEb+CA3XwjsrhEpqjLW/fvNnOib0BBaRh190KxXYuox8J/m6G7AdPhM0YnLHMnJBC6stMTju38mGCoXvC+NH/EhRjKSVFit/RZLC5JRSyQJoXCfXWPL+8zUwdZk5zK3isL6ldvIH9tJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W9QYM50Hxz4f3l19;
	Fri, 28 Jun 2024 14:30:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id E7D8C1A0572;
	Fri, 28 Jun 2024 14:30:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP2 (Coremail) with SMTP id Syh0CgBXwIWfWH5mZZVAAg--.52859S4;
	Fri, 28 Jun 2024 14:30:57 +0800 (CST)
From: libaokun@huaweicloud.com
To: netfs@lists.linux.dev,
	dhowells@redhat.com,
	jlayton@kernel.org
Cc: hsiangkao@linux.alibaba.com,
	jefflexu@linux.alibaba.com,
	zhujia.zj@bytedance.com,
	linux-erofs@lists.ozlabs.org,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	libaokun@huaweicloud.com,
	yangerkun@huawei.com,
	houtao1@huawei.com,
	yukuai3@huawei.com,
	wozizhi@huawei.com,
	Baokun Li <libaokun1@huawei.com>
Subject: [PATCH v3 0/9] cachefiles: random bugfixes
Date: Fri, 28 Jun 2024 14:29:21 +0800
Message-Id: <20240628062930.2467993-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBXwIWfWH5mZZVAAg--.52859S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGr15CF1DXrW3GFy5ZFy5Arb_yoWrAr17pF
	Waka13JrykWry7C393Zw13tFyrA3yfXFn2gr17Xw15A3s8XF15ZrWI9r1YvFyUCrZ7Jw42
	vr1jkFn7Gr1jv3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjfUYWrWUUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAIBV1jkH-YcwABs3

From: Baokun Li <libaokun1@huawei.com>

Hi all!

This is the third version of this patch series, in which another patch set
is subsumed into this one to avoid confusing the two patch sets.
(https://patchwork.kernel.org/project/linux-fsdevel/list/?series=854914)

Thank you, Jia Zhu, Gao Xiang, Jeff Layton, for the feedback in the
previous version.

We've been testing ondemand mode for cachefiles since January, and we're
almost done. We hit a lot of issues during the testing period, and this
patch series fixes some of the issues. The patches have passed internal
testing without regression.

The following is a brief overview of the patches, see the patches for
more details.

Patch 1-2: Add fscache_try_get_volume() helper function to avoid
fscache_volume use-after-free on cache withdrawal.

Patch 3: Fix cachefiles_lookup_cookie() and cachefiles_withdraw_cache()
concurrency causing cachefiles_volume use-after-free.

Patch 4: Propagate error codes returned by vfs_getxattr() to avoid
endless loops.

Patch 5-7: A read request waiting for reopen could be closed maliciously
before the reopen worker is executing or waiting to be scheduled. So
ondemand_object_worker() may be called after the info and object and even
the cache have been freed and trigger use-after-free. So use
cancel_work_sync() in cachefiles_ondemand_clean_object() to cancel the
reopen worker or wait for it to finish. Since it makes no sense to wait
for the daemon to complete the reopen request, to avoid this pointless
operation blocking cancel_work_sync(), Patch 1 avoids request generation
by the DROPPING state when the request has not been sent, and Patch 2
flushes the requests of the current object before cancel_work_sync().

Patch 8: Cyclic allocation of msg_id to avoid msg_id reuse misleading
the daemon to cause hung.

Patch 9: Hold xas_lock during polling to avoid dereferencing reqs causing
use-after-free. This issue was triggered frequently in our tests, and we
found that anolis 5.10 had fixed it. So to avoid failing the test, this
patch is pushed upstream as well.

Comments and questions are, as always, welcome.
Please let me know what you think.

Thanks,
Baokun

Changes since v2:
  * Collect Acked-by from Jeff Layton.(Thanks for your ack!)
  * Collect RVB from Gao Xiang.(Thanks for your review!)
  * Patch 1-4 from another patch set.
  * Pathch 4,6,7: Optimise commit messages and subjects.

Changes since v1:
  * Collect RVB from Jia Zhu and Gao Xiang.(Thanks for your review!)
  * Pathch 1,2：Add more commit messages.
  * Pathch 3：Add Fixes tag as suggested by Jia Zhu.
  * Pathch 4：No longer changing "do...while" to "retry" to focus changes
    and optimise commit messages.
  * Pathch 5: Drop the internal RVB tag.

v1: https://lore.kernel.org/all/20240424033409.2735257-1-libaokun@huaweicloud.com
v2: https://lore.kernel.org/all/20240515125136.3714580-1-libaokun@huaweicloud.com

Baokun Li (7):
  netfs, fscache: export fscache_put_volume() and add
    fscache_try_get_volume()
  cachefiles: fix slab-use-after-free in fscache_withdraw_volume()
  cachefiles: fix slab-use-after-free in cachefiles_withdraw_cookie()
  cachefiles: propagate errors from vfs_getxattr() to avoid infinite
    loop
  cachefiles: stop sending new request when dropping object
  cachefiles: cancel all requests for the object that is being dropped
  cachefiles: cyclic allocation of msg_id to avoid reuse

Hou Tao (1):
  cachefiles: wait for ondemand_object_worker to finish when dropping
    object

Jingbo Xu (1):
  cachefiles: add missing lock protection when polling

 fs/cachefiles/cache.c          | 45 ++++++++++++++++++++++++++++-
 fs/cachefiles/daemon.c         |  4 +--
 fs/cachefiles/internal.h       |  3 ++
 fs/cachefiles/ondemand.c       | 52 ++++++++++++++++++++++++++++++----
 fs/cachefiles/volume.c         |  1 -
 fs/cachefiles/xattr.c          |  5 +++-
 fs/netfs/fscache_volume.c      | 14 +++++++++
 fs/netfs/internal.h            |  2 --
 include/linux/fscache-cache.h  |  6 ++++
 include/trace/events/fscache.h |  4 +++
 10 files changed, 123 insertions(+), 13 deletions(-)

-- 
2.39.2


