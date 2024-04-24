Return-Path: <linux-fsdevel+bounces-17577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB888AFFCE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 05:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C305D1F22E1F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 03:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F003F13E031;
	Wed, 24 Apr 2024 03:36:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4C313340B;
	Wed, 24 Apr 2024 03:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713929813; cv=none; b=ZBUIIFDCXjGx8dVj+oR/hj4j2FCPoNCC2u3x4GQ8ITFy/UXFLZYtWAD8gYrQA+S6VDH3BsVG4b6PPTgjoL2mCheqVM2KXDL7dDzlcGAV+2vTnkO0nf/c9ZumdkgWV7dMQ0DU0kQAqPNJ+nCEMIHaxUisg/QY0ifxyvjuoMVD5bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713929813; c=relaxed/simple;
	bh=GRaCHqEtnIFPBbuvFtR79mT6Pen0M9PcasM0W2yyRFM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r3/J64Tewy5eYHS6BXj774C/w9p0V3AMZWH50uEDe5imlr0UdwpF8rosSVo8nBN0OA/qxMb7z215iDVSiiKl0N2UCLS1DYx7xF4X5IvB+2Mz8Jq5KssxNMr9l37FxJ2D+c8VR47nsYxINWAq+IXl007UeqRU6fZ760ZClmOkOzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VPPmS3fb6z4f3jM2;
	Wed, 24 Apr 2024 11:36:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 0CE8A1A016E;
	Wed, 24 Apr 2024 11:36:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHZQ5Nfihmarc3Kw--.25590S4;
	Wed, 24 Apr 2024 11:36:47 +0800 (CST)
From: libaokun@huaweicloud.com
To: netfs@lists.linux.dev
Cc: dhowells@redhat.com,
	jlayton@kernel.org,
	linux-cachefs@redhat.com,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	libaokun@huaweicloud.com,
	Baokun Li <libaokun1@huawei.com>
Subject: [PATCH 0/5] cachefiles: some bugfixes for withdraw and xattr
Date: Wed, 24 Apr 2024 11:27:27 +0800
Message-Id: <20240424032732.2711487-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHZQ5Nfihmarc3Kw--.25590S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uw18JFyfJFWDXrWkWFyfZwb_yoW8Gw45pF
	WayF43Jry8W3y7Gw1fAr15Jr1rA3s3JF1vg347Wr18Awn5Xr1jqF1Iyr15ZFW5ury7Jws2
	q3WUKFy7Ww1jy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUWVWUuwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUUtrc3UUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

From: Baokun Li <libaokun1@huawei.com>

Hello everyone!

Recently we found some bugs while doing tests on cachefiles ondemand mode,
and this patchset is a fix for some of those issues. The following is a
brief overview of the patches, see the patches for more details.

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


