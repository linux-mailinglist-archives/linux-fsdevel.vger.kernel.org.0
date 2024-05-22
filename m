Return-Path: <linux-fsdevel+bounces-19969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B53F78CBA2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 06:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47C84B20370
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 04:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F27377F13;
	Wed, 22 May 2024 04:06:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE8E29CA;
	Wed, 22 May 2024 04:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716350762; cv=none; b=TFOq5xZH4Av2VCo85Z3ES5A/MV/WpsVLtrqfvJnMazQKNFeOZFwC/FaKJWU/y3mGYns2nbH8OCKMz00dP1IhoDPHilgexiFMM7T2s4GHly2Z7QdWMbZc0PNuZHhwkP4LhbxEKzaomiqDYxvKYrvswxK0OgjI/teRsUTqMjMzcqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716350762; c=relaxed/simple;
	bh=ChxVf4FnXZilWSTRkjIB2ZHFv7JVFX1ZGcQCv3Sbf1c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GZJbNZJM1AEZrHrOC/SXZ0pTYIJ7pSIeoGLANCjSK5C2XFiYU5JHUhP6GxqlK/6g3xw5wc1sxXqcPhQiBmynFjmJabYueMA6naPL9ZVRXb3qjefidhcDE2PZorELtJ6fy6zsrdSSY4i5BP5NSqJ1bFIRy4dX7PLy0+q2qjOQ6lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vkd560tQRz4f3m6r;
	Wed, 22 May 2024 12:05:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 94F5B1A01B9;
	Wed, 22 May 2024 12:05:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHZQ4ib01ms1VYNQ--.24441S4;
	Wed, 22 May 2024 12:05:56 +0800 (CST)
From: libaokun@huaweicloud.com
To: netfs@lists.linux.dev,
	dhowells@redhat.com,
	jlayton@kernel.org
Cc: hsiangkao@linux.alibaba.com,
	jefflexu@linux.alibaba.com,
	zhujia.zj@bytedance.com,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	libaokun@huaweicloud.com,
	yangerkun@huawei.com,
	houtao1@huawei.com,
	yukuai3@huawei.com,
	wozizhi@huawei.com,
	Baokun Li <libaokun1@huawei.com>
Subject: [PATCH RESEND 0/5] cachefiles: some bugfixes for withdraw and xattr
Date: Wed, 22 May 2024 19:59:06 +0800
Message-Id: <20240522115911.2403021-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHZQ4ib01ms1VYNQ--.24441S4
X-Coremail-Antispam: 1UD129KBjvJXoW7WFWxuF1xtw13Ar4ktFyDGFg_yoW8Xr47pF
	WakF13JrykW39rGw4fAw15Xr1fA3yfGF4vg347Wr18Awn5Xr1YvF4Iyw15ZFy5Cr17tws2
	v3WUKFy7Wr1Yy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBa14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
	YI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
	CY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0pR6wZ7UUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

From: Baokun Li <libaokun1@huawei.com>

Hi all!

There are some fixes for some cachefiles generic processes. We found these
issues when testing the on-demand mode, but the non-on-demand mode is also
involved. The following is a brief overview of the patches, see the patches
for more details.

Patch 1-2: Add fscache_try_get_volume() helper function to avoid
fscache_volume use-after-free on cache withdrawal.

Patch 3: Fix cachefiles_lookup_cookie() and cachefiles_withdraw_cache()
concurrency causing cachefiles_volume use-after-free.

Patch 4-5: Propagate error codes returned by vfs_getxattr() to avoid
endless loops.

Comments and questions are, as always, welcome.

Thanks,
Baokun

Baokun Li (5):
  netfs, fscache: export fscache_put_volume() and add
    fscache_try_get_volume()
  cachefiles: fix slab-use-after-free in fscache_withdraw_volume()
  cachefiles: fix slab-use-after-free in cachefiles_withdraw_cookie()
  cachefiles: correct the return value of
    cachefiles_check_volume_xattr()
  cachefiles: correct the return value of cachefiles_check_auxdata()

 fs/cachefiles/cache.c          | 45 +++++++++++++++++++++++++++++++++-
 fs/cachefiles/volume.c         |  1 -
 fs/cachefiles/xattr.c          |  5 +++-
 fs/netfs/fscache_volume.c      | 14 +++++++++++
 fs/netfs/internal.h            |  2 --
 include/linux/fscache-cache.h  |  6 +++++
 include/trace/events/fscache.h |  4 +++
 7 files changed, 72 insertions(+), 5 deletions(-)

-- 
2.39.2


