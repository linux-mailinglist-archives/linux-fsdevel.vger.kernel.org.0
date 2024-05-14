Return-Path: <linux-fsdevel+bounces-19414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 834438C5643
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 14:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F000B22080
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 12:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9727E583;
	Tue, 14 May 2024 12:53:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96CC47F5D;
	Tue, 14 May 2024 12:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715691217; cv=none; b=Tbxci7uKQHatKrx52qlzGuW+iYTYfxpf3VsmqNJUSzdwbs/pFAdtyfZeauIi7rL0Z97haWDmy9gQoiiFrHg7w/d9Mb+DwrXyUHp5Y04JdylXtrdzKCTXvJOBldpBbdaeJc/7DCptJjEcIWypelsW8/Q8xKnZYnifLaD0DeQRmro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715691217; c=relaxed/simple;
	bh=fIt4Cp+Y1kOWl1ERp547eUhh12GLNeZxSmn9AkF26Mo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mPo2gJrwYlay7sUzWmtLWfT8jTn8Sd/KXbSuOQJPnHKn9Aoc92NH8WbClOn57BsCd9TbdSa5UtsvLpCsE7qnDTncG6K0NGGRpArSljvkHFAbQtwTNXjFU2CMxMRK2MTVE3JsUBblmnwAc8pT3W9w+UbhNmkdCJkfuRA2xcPx9mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vdx9X4MrNz4f3kKl;
	Tue, 14 May 2024 20:53:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 24AB81A0ACF;
	Tue, 14 May 2024 20:53:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP4 (Coremail) with SMTP id gCh0CgDHzG7EXkNmCyyLMw--.6596S2;
	Tue, 14 May 2024 20:53:25 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: willy@infradead.org,
	akpm@linux-foundation.org,
	tj@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8] Add helper functions to remove repeated code and improve readability of cgroup writeback
Date: Tue, 14 May 2024 20:52:46 +0800
Message-Id: <20240514125254.142203-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHzG7EXkNmCyyLMw--.6596S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr1DuF48Gw1ktry3Jr4ktFb_yoW8ur4DpF
	Z3Kr1aqr4UJFnxAr9xCay29rySyrZ3JF15t3sxuw4avF4akr12ga42vFyFkFW7AFy3GryY
	vF4qy34xGF1qkaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s
	0DMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
	daVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

v1->v2:
-add dtc_is_global() helper
-rename "bool bg" to "include_writeback"
-fold patches using domain_dirty_avail
-reflow comment to 80col
-Fix potential NULL deref of mdtc->dirty_exceeded

This series add a lot of helpers to remove repeated code between domain
and wb; dirty limit and dirty background; global domain and wb domain.
The helpers also improve readability. More details can be found on
respective patches.
Thanks.

A simple domain hierarchy is tested:
global domain (> 20G)
	|
cgroup domain1(10G)
	|
	wb1
	|
	fio

Test steps:
/* make it easy to observe */
echo 300000 > /proc/sys/vm/dirty_expire_centisecs
echo 3000 > /proc/sys/vm/dirty_writeback_centisecs

/* create cgroup domain */
cd /sys/fs/cgroup
echo "+memory +io" > cgroup.subtree_control
mkdir group1
cd group1
echo 10G > memory.high
echo 10G > memory.max
echo $$ > cgroup.procs
mkfs.ext4 -F /dev/vdb
mount /dev/vdb /bdi1/

/* run fio to generate dirty pages */
fio -name test -filename=/bdi1/file -size=xxx -ioengine=libaio -bs=4K \
-iodepth=1 -rw=write -direct=0 --time_based -runtime=600 -invalidate=0

When fio size is 1G, the wb is in freerun state and dirty pages are only
written back when dirty inode is expired after 30 seconds.
When fio size is 2G, the dirty pages keep being written back and
bandwidth of fio is limited.

Kemeng Shi (8):
  writeback: factor out wb_bg_dirty_limits to remove repeated code
  writeback: add general function domain_dirty_avail to calculate dirty
    and avail of domain
  writeback: factor out domain_over_bg_thresh to remove repeated code
  writeback: Factor out code of freerun to remove repeated code
  writeback: factor out wb_dirty_freerun to remove more repeated freerun
    code
  writeback: factor out balance_domain_limits to remove repeated code
  writeback: factor out wb_dirty_exceeded to remove repeated code
  writeback: factor out balance_wb_limits to remove repeated code

 mm/page-writeback.c | 315 ++++++++++++++++++++++++--------------------
 1 file changed, 169 insertions(+), 146 deletions(-)

-- 
2.30.0


