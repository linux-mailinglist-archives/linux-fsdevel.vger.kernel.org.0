Return-Path: <linux-fsdevel+bounces-18041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E00E38B4FFE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 05:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9568A1F2170B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 03:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9FF12E6C;
	Mon, 29 Apr 2024 03:47:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52351118D;
	Mon, 29 Apr 2024 03:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714362476; cv=none; b=PeoTZrpXqU4k0Hxb2shhNjjcErdjbn59Yt7EZ/wJbeD3iWhDqMxDmzO+H2viAphWZkzKX//bAWdCQDO2eSLwBVViQrEike7O0En18smKLp1IqB8xjwxEt1WwydoTYxB7N5CMLzs/th4eYsx01yPlFYOPfKlxFSPPXDyWRBNvog4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714362476; c=relaxed/simple;
	bh=s+npPNcWKMeZEYom4cv+3hbdgohXqkg2iyExANnuyDo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZcLuXAzacza98H1a5TH+PZxszNtVVYcvRv1da64kXHhMbTpUk3bxjsyj06Y5nQTFJHhkKxnd/FzePwHriSDcbxdF5UABhZy1ivVMhD5UGDmR5GLZtcgETyXr5fYwm4RQCHLsN+J3gMZ8nQvQf/DMoVGiYNiMQrJK973Jzeuqz6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VSTmr6CdBz4f3jkS;
	Mon, 29 Apr 2024 11:47:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id DB60D1A0568;
	Mon, 29 Apr 2024 11:47:45 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP1 (Coremail) with SMTP id cCh0CgA3UwxgGC9m24__LA--.38879S2;
	Mon, 29 Apr 2024 11:47:45 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: willy@infradead.org,
	akpm@linux-foundation.org,
	jack@suse.cz,
	tj@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] Add helper functions to remove repeated code and
Date: Mon, 29 Apr 2024 11:47:28 +0800
Message-Id: <20240429034738.138609-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3UwxgGC9m24__LA--.38879S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw18WF1rGF4kJF47AF1rCrg_yoW8tFW7pF
	Z3Kr1aqr1UJ3W3Ar9xCay29ryS9397AF45t3sxXw4SvF43Cry2gFy2vFyFkay2yFy3Gry5
	ZFs8t34xGr1qkaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
	MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJV
	Cq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBI
	daVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

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

When fio size is 1.5G, the wb is in freerun state and dirty pages is
written back when dirty inode is expired after 30 seconds.
When fio size is 2G, the dirty pages keep being written back.
When fio size is 3G, the dirty pages keep being written back and
bandwidth of fio is reduce to 0 occasionally. It's more easy to observe
the dirty limitation by set /proc/sys/vm/dirty_ratio to a higher
value, and set /proc/sys/vm/dirty_ratio back to 20 when 3G pages are
dirtied.

Kemeng Shi (10):
  writeback: factor out wb_bg_dirty_limits to remove repeated code
  writeback: add general function domain_dirty_avail to calculate dirty
    and avail of domain
  writeback: factor out domain_over_bg_thresh to remove repeated code
  writeback use [global/wb]_domain_dirty_avail helper in
    cgwb_calc_thresh
  writeback: call domain_dirty_avail in balance_dirty_pages
  writeback: Factor out code of freerun to remove repeated code
  writeback: factor out wb_dirty_freerun to remove more repeated freerun
    code
  writeback: factor out balance_domain_limits to remove repeated code
  writeback: factor out wb_dirty_exceeded to remove repeated code
  writeback: factor out balance_wb_limits to remove repeated code

 mm/page-writeback.c | 324 ++++++++++++++++++++++++--------------------
 1 file changed, 176 insertions(+), 148 deletions(-)

-- 
2.30.0


