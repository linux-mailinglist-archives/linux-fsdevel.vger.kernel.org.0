Return-Path: <linux-fsdevel+bounces-17583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFCD8AFFE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 05:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B30CFB2309D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 03:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C71913C9D0;
	Wed, 24 Apr 2024 03:43:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2AA85C59;
	Wed, 24 Apr 2024 03:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713930208; cv=none; b=Faeq87iUJy9tcKXYtGf0QITc7GVuRrmMzXyv4v7ekIH9YoYJbsfqCFIXWlFhpAois51keFFvIKZrHy6U3zq1rGlugHIhFmBimG7PjdinBAXTKrR/jxIN38L62OGcAP4rRv6wixiqU5t5vRNswT+C5TsDn/HAqGug4xPWwLjS02E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713930208; c=relaxed/simple;
	bh=NXQYY86D+GDRBXc8Sz0xux5RIySTPOpCMXcp/jSOXFs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=biTpjNQyVq7Z+zdS9nWqvxaopQ32bB43wz+G3pV7wgkJBsQN0H/QXc6SF1VRbOsR67OsAzoNTqoJRck1CLiDHghga53j6wQUFqC88JQiJQ/UrPyXdVrbgywBfv+yIGgTFSgVazPPeaqNliCA4QqmFdaLbtYmlwHIWwpMJjBxJ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VPPw65qbcz4f3l8g;
	Wed, 24 Apr 2024 11:43:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A819E1A0EE6;
	Wed, 24 Apr 2024 11:43:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBHafyhmuSA4Kw--.57541S4;
	Wed, 24 Apr 2024 11:43:23 +0800 (CST)
From: libaokun@huaweicloud.com
To: netfs@lists.linux.dev
Cc: dhowells@redhat.com,
	jlayton@kernel.org,
	zhujia.zj@bytedance.com,
	jefflexu@linux.alibaba.com,
	linux-cachefs@redhat.com,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	libaokun@huaweicloud.com,
	Baokun Li <libaokun1@huawei.com>
Subject: [PATCH 0/5] cachefiles: some bugfixes for clean object/send req/poll
Date: Wed, 24 Apr 2024 11:34:04 +0800
Message-Id: <20240424033409.2735257-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHGBHafyhmuSA4Kw--.57541S4
X-Coremail-Antispam: 1UD129KBjvJXoW7JF48GFW7Xr43Xr1DXrW5KFg_yoW8JF4rpF
	Wav3W3JFy8Wr12kws3Zw1rJrWrC3s3ZF9rtF47XrykArn8XF1FvrW0yrn8ZFyUCrZ7Gw42
	gw48WF929wn0v3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUWVWUuwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK
	8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU0_-PUUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

From: Baokun Li <libaokun1@huawei.com>

Hello everyone!

Recently we found some bugs while doing tests on cachefiles ondemand mode,
and this patchset is a fix for some of those issues. The following is a
brief overview of the patches, see the patches for more details.

Patch 1-3: After an object has been cleaned up, make sure it has no
outstanding requests and that the corresponding ondemand_object_worker
has exited, otherwise it may use-after-free.

Patch 4: Cyclic allocation of msg_id to avoid msg_id reuse misleading
the daemon to cause hung.

Patch 5: Hold xas_lock during polling to avoid dereferencing reqs causing
use-after-free.

Comments and questions are, as always, welcome.

Thanks,
Baokun

Baokun Li (3):
  cachefiles: stop sending new request when dropping object
  cachefiles: flush all requests for the object that is being dropped
  cachefiles: cyclic allocation of msg_id to avoid reuse

Hou Tao (1):
  cachefiles: flush ondemand_object_worker during clean object

Jingbo Xu (1):
  cachefiles: add missing lock protection when polling

 fs/cachefiles/daemon.c   |   4 +-
 fs/cachefiles/internal.h |   3 +
 fs/cachefiles/ondemand.c | 120 ++++++++++++++++++++++++++-------------
 3 files changed, 86 insertions(+), 41 deletions(-)

-- 
2.39.2


