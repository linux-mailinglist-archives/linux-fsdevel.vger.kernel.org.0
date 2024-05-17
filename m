Return-Path: <linux-fsdevel+bounces-19655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B0B8C858D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 13:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDC381F22E32
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 11:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10E53F9D4;
	Fri, 17 May 2024 11:24:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6563D0A3;
	Fri, 17 May 2024 11:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715945090; cv=none; b=aHnF199yJN8hwxUX1ZJNY6YXxrKvAkWaYWMFvtaG0tT++9V3DVKCNL/Oob1RNtFT3iMhByTN9A13Os5V8WGd9mbJTzBNrdA6WGWm5SGB5SLuz1Oni14skcJ7J1WQzRNYQQRG15bgNxjTcidqR0wQeqioIehYbwrKIvNNYnySL7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715945090; c=relaxed/simple;
	bh=DoyCXkpOfzLWKgC9ctYH1ac8X2WIkrxKpQLa1A3Sw+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RGedFnnCr7jSLO+SOId/+ao9ofgtcfAcyUnnuwuQTWGhkomdQxhL+YHRnEy0Xn0iQkSZ8zq+fGjfVKm4UFKf5oaUxe/su8d18RvDrAVadwxS50eGufNuvqtpDHy85kiW+w37FL91HujFKYFVIliUIJkXSCAPIvzwAHiHYmLQL/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vgl3p3kPYz4f3jkq;
	Fri, 17 May 2024 19:24:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2280C1A017F;
	Fri, 17 May 2024 19:24:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBFrPkdm3V+kMw--.2732S4;
	Fri, 17 May 2024 19:24:41 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	brauner@kernel.org,
	david@fromorbit.com,
	chandanbabu@kernel.org,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH v3 0/3] iomap/xfs: fix stale data exposure when truncating realtime inodes
Date: Fri, 17 May 2024 19:13:52 +0800
Message-Id: <20240517111355.233085-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHGBFrPkdm3V+kMw--.2732S4
X-Coremail-Antispam: 1UD129KBjvJXoW7AF4fZr4furyktF45Xry7Jrb_yoW8XF45pF
	Z8Gry5Wr48Gry3ua4fua1qv345J3W0yrWUuFyxtwnxZFy2qryIyr10ga10gayDtrykXr4U
	Xr15JFZ7Wr1vyrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoO
	J5UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Changes since v2:
 - Use div_u64_rem() instead of do_div().

Changes since v1:
 - In iomap_truncate_page() and dax_truncate_page(), for the case of
   truncate blocksize is not power of 2, use do_dive() to calculate the
   offset.

This series fix a stale data exposure issue reported by Chandan when
running fstests generic/561 on xfs with realtime device[1]. The real
problem is xfs_setattr_size() doesn't zero out enough range when
truncating a realtime inode, please see the third patch or [1] for
details.

The first two patches modify iomap_truncate_page() and
dax_truncate_page() to pass filesystem identified blocksize, and drop
the assumption of i_blocksize() as Dave suggested. The third patch fix
the issue by modifying xfs_truncate_page() to pass the correct
blocksize, and make sure zeroed range have been flushed to disk before
updating i_size.

[1] https://lore.kernel.org/linux-xfs/87ttj8ircu.fsf@debian-BULLSEYE-live-builder-AMD64/

Thanks,
Yi.

Zhang Yi (3):
  iomap: pass blocksize to iomap_truncate_page()
  fsdax: pass blocksize to dax_truncate_page()
  xfs: correct the zeroing truncate range

 fs/dax.c               | 13 +++++++++----
 fs/ext2/inode.c        |  4 ++--
 fs/iomap/buffered-io.c | 13 +++++++++----
 fs/xfs/xfs_iomap.c     | 36 ++++++++++++++++++++++++++++++++----
 fs/xfs/xfs_iops.c      | 10 ----------
 include/linux/dax.h    |  4 ++--
 include/linux/iomap.h  |  4 ++--
 7 files changed, 56 insertions(+), 28 deletions(-)

-- 
2.39.2


