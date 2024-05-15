Return-Path: <linux-fsdevel+bounces-19525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 395808C66C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 15:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A6CB1C23320
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 13:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A43F12A16E;
	Wed, 15 May 2024 13:02:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05521127E35;
	Wed, 15 May 2024 13:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715778139; cv=none; b=uzX/28rMlzFxHPkhHCemPZft080EVlELvNROXqz6P+LH9daMqSpevmtfg8aZPABgbdJwsv4NsFjrtTFXNh5F/vUEiO2eF3X61/4Nj3duP2Ml2QrGx+N8J+/8X/js6J8C9gXR5zNr6+ablgyWvaYbrkO1YGZhfmSFjfk9yzIocxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715778139; c=relaxed/simple;
	bh=hB0JAs+m+raTZOxayk9LfX8vHa3XymJHLJmzVMOjn98=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=aV729z53HJhUlwDrV4Wp6DyjVaLxMb5/HIf9ty2cXMoihDuVc6i+VnS6ejfKeFVAwcqZdqvBe/L5FbSOKri+CoO0Lm4xKPYMHhy5Yf369IB/P/MUmwFrrx1gJ8sv6k9NE8+TkQAjP2AD/KsV7hvHGRJK6ypNzzJsf1EDa2Vi0fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VfYK61BhBz4f3k6D;
	Wed, 15 May 2024 21:02:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B26C11A0182;
	Wed, 15 May 2024 21:02:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RFLskRmALLwMg--.18738S4;
	Wed, 15 May 2024 21:02:05 +0800 (CST)
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
Subject: [PATCH v2 0/5] cachefiles: some bugfixes for clean object/send req/poll
Date: Wed, 15 May 2024 20:51:31 +0800
Message-Id: <20240515125136.3714580-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX6RFLskRmALLwMg--.18738S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXr1kJFyDAr1UWw13tFyfXrb_yoW5GFyUpF
	Wak3W3Gr1kWryIkws3Za1xtFyFy3yfZ3W3Gr4xX345A3s8XF1rArWIvr1jqa4DCrZ7Xw4a
	9r1jgFn3Cryjv3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI
	42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbfWrJUUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

From: Baokun Li <libaokun1@huawei.com>

Hi all!

This is the second version of this patch series. Thank you, Jia Zhu and
Gao Xiang, for the feedback in the previous version.

We've been testing ondemand mode for cachefiles since January, and we're
almost done. We hit a lot of issues during the testing period, and this
patch set fixes some of the issues related to reopen worker/send req/poll.
The patches have passed internal testing without regression.

Patch 1-3: A read request waiting for reopen could be closed maliciously
before the reopen worker is executing or waiting to be scheduled. So
ondemand_object_worker() may be called after the info and object and even
the cache have been freed and trigger use-after-free. So use
cancel_work_sync() in cachefiles_ondemand_clean_object() to cancel the
reopen worker or wait for it to finish. Since it makes no sense to wait
for the daemon to complete the reopen request, to avoid this pointless
operation blocking cancel_work_sync(), Patch 1 avoids request generation
by the DROPPING state when the request has not been sent, and Patch 2
flushes the requests of the current object before cancel_work_sync().

Patch 4: Cyclic allocation of msg_id to avoid msg_id reuse misleading
the daemon to cause hung.

Patch 5: Hold xas_lock during polling to avoid dereferencing reqs causing
use-after-free. This issue was triggered frequently in our tests, and we
found that anolis 5.10 had fixed it, so to avoid failing the test, this
patch was pushed upstream as well.

Comments and questions are, as always, welcome.
Please let me know what you think.

Thanks,
Baokun

Changes since v1:
  * Collect RVB from Jia Zhu and Gao Xiang.(Thanks for your review!)
  * Pathch 1,2：Add more commit messages.
  * Pathch 3：Add Fixes tag as suggested by Jia Zhu.
  * Pathch 4：No longer changing "do...while" to "retry" to focus changes
    and optimise commit messages.
  * Pathch 5: Drop the internal RVB tag.

[V1]: https://lore.kernel.org/all/20240424033409.2735257-1-libaokun@huaweicloud.com

Baokun Li (3):
  cachefiles: stop sending new request when dropping object
  cachefiles: flush all requests for the object that is being dropped
  cachefiles: cyclic allocation of msg_id to avoid reuse

Hou Tao (1):
  cachefiles: flush ondemand_object_worker during clean object

Jingbo Xu (1):
  cachefiles: add missing lock protection when polling

 fs/cachefiles/daemon.c   |  4 ++--
 fs/cachefiles/internal.h |  3 +++
 fs/cachefiles/ondemand.c | 52 +++++++++++++++++++++++++++++++++++-----
 3 files changed, 51 insertions(+), 8 deletions(-)

-- 
2.39.2


