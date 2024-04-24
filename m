Return-Path: <linux-fsdevel+bounces-17589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F4B8B0014
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 05:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD1928A002
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 03:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25180140368;
	Wed, 24 Apr 2024 03:48:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E6513A3E9;
	Wed, 24 Apr 2024 03:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713930514; cv=none; b=BpJjUKplJ0rvJ6QUeBKg3L1Uo/ueLTORLIP90XWxXyBLqaRfXz4g/00T6Lp+vC6SjB5Q2jlzDzlW3BFtNHG/yVGnmQpBCdUtHwRi93uQEdOucbm3nJQUbYvtnezk+ITmxUTZl2gGTA21XZ2iH3UNm3psdSFi+FiL8weAEugSTro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713930514; c=relaxed/simple;
	bh=mlU9I0mjtlwMMGIWC4P3MzyrfpkH3LZk+T0GesN54pw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JI14cCOn3YZ9mfA8s/l25RE3hsMEn/9EwN0seYxGQY0+j96wtatrD6HXBoW0l3OzWzDraLh0b25nOli8bkbzt62wDPVF7YrR2bBF8w71mqfR5pNa/GYoZX6GFLrAG/XxC4nnSew7MXNOCOyr/1gM0gEVaFgrzZsuyaCunbLr464=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VPQ210N7Nz4f3jqL;
	Wed, 24 Apr 2024 11:48:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id DCA891A0179;
	Wed, 24 Apr 2024 11:48:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBELgShmKXE4Kw--.6143S4;
	Wed, 24 Apr 2024 11:48:29 +0800 (CST)
From: libaokun@huaweicloud.com
To: netfs@lists.linux.dev
Cc: dhowells@redhat.com,
	jlayton@kernel.org,
	zhujia.zj@bytedance.com,
	jefflexu@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	libaokun@huaweicloud.com,
	Baokun Li <libaokun1@huawei.com>
Subject: [PATCH 00/12] cachefiles: some bugfixes and cleanups for ondemand requests
Date: Wed, 24 Apr 2024 11:39:04 +0800
Message-Id: <20240424033916.2748488-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXaBELgShmKXE4Kw--.6143S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uw18JFyfJFWDXrWDtFW8JFb_yoW8ZFyfpF
	WSya4akry8Wr42g3s7Ar4rJryrA3yfAF9Fgr12g34UA3s8Xr1YvryIyr15XFy5CrZrGr42
	qw18uF92q34qv3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBa14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUWVWUuwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAI
	w20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
	CY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU7uc_UUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

From: Baokun Li <libaokun1@huawei.com>

Hello everyone!

Recently we found some bugs while doing tests on cachefiles ondemand mode,
and this patchset is a fix for some of those issues. The following is a
brief overview of the patches, see the patches for more details.

Patch 1-5: Holding reference counts of reqs and objects on read requests
to avoid malicious restore leading to use-after-free.

Patch 6-10: Add some consistency checks to copen/cread/get_fd to avoid
malicious copen/cread/close fd injections causing use-after-free or hung.

Patch 11: When cache is marked as CACHEFILES_DEAD, flush all requests,
otherwise the kernel may be hung. since this state is irreversible, the
daemon can read open requests but cannot copen.

Patch 12: Allow interrupting a read request being processed by killing
the read process as a way of avoiding hung in some special cases.

Comments and questions are, as always, welcome.

Thanks,
Baokun

Baokun Li (11):
  cachefiles: remove request from xarry during flush requests
  cachefiles: remove err_put_fd tag in cachefiles_ondemand_daemon_read()
  cachefiles: fix slab-use-after-free in cachefiles_ondemand_get_fd()
  cachefiles: fix slab-use-after-free in
    cachefiles_ondemand_daemon_read()
  cachefiles: add output string to cachefiles_obj_[get|put]_ondemand_fd
  cachefiles: add consistency check for copen/cread
  cachefiles: add spin_lock for cachefiles_ondemand_info
  cachefiles: never get a new anon fd if ondemand_id is valid
  cachefiles: defer exposing anon_fd until after copy_to_user() succeeds
  cachefiles: flush all requests after setting CACHEFILES_DEAD
  cachefiles: make on-demand read killable

Zizhi Wo (1):
  cachefiles: Set object to close if ondemand_id < 0 in copen

 fs/cachefiles/daemon.c            |   3 +-
 fs/cachefiles/internal.h          |   5 +
 fs/cachefiles/ondemand.c          | 199 +++++++++++++++++++++---------
 include/trace/events/cachefiles.h |   8 +-
 4 files changed, 158 insertions(+), 57 deletions(-)

-- 
2.39.2


