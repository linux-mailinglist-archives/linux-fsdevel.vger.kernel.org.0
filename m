Return-Path: <linux-fsdevel+bounces-13189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BC586C865
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 12:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA5AC1F232AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 11:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2527E113;
	Thu, 29 Feb 2024 11:45:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23157E0E4;
	Thu, 29 Feb 2024 11:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709207141; cv=none; b=IDbsgHKrUU1PszECizn4PCUyAJJhA7s03+WvWe+hHv6DaQWD7uwpJsSNdYWfVV2L9h3dTkk7pUw0Hb06RL0t+2VOqvi0ShM5Tm5JhWfHnfS5kI7DJPTwOmpr+gke1mSFmp4OzkaDyNWNsw344o5qSEkelQ0byXH6d00/UF5actw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709207141; c=relaxed/simple;
	bh=hngxUyHulZ27eylXtud4AjMHhGagOr3zuKNraEBD/S0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sh2+t9C8oNY7wNuXmIivoSKqym6/ZyrpyatMUpa4EYcsI+FlSM3iOQ1KQ9Lvcima6rbFiRGuQLEfXEOVZfZgQy1MRDnsZCQu51wlAMigCEHlbguCA6VSAwGMfWdoKz+9Q2V+w06o2/xajaH0mUbdDQPCruk67GgOoMVQ+oyAjA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Tlq9M6mSQzvW29;
	Thu, 29 Feb 2024 19:43:19 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 067BB1404DB;
	Thu, 29 Feb 2024 19:45:31 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 29 Feb
 2024 19:45:30 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <brauner@kernel.org>, <david@fromorbit.com>, <djwong@kernel.org>,
	<jack@suse.cz>, <tytso@mit.edu>
CC: <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
	<yi.zhang@huawei.com>
Subject: [PATCH RFC 0/2] ext4: Do endio process under irq context for DIO overwrites
Date: Thu, 29 Feb 2024 19:38:47 +0800
Message-ID: <20240229113849.2222577-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600013.china.huawei.com (7.193.23.68)

Recently we found an ext4 performance regression problem between 4.18
and 5.10 by following test command on a x86 physical machine with nvme:
  fio -direct=1 -iodepth=128 -rw=randwrite -ioengine=libaio -bs=4k
      -size=2G -numjobs=1 -time_based -runtime=60 -group_reporting
      -filename=/test/test -name=Rand_write_Testing --cpus_allowed=1
4.18: 288k IOPS    5.10: 234k IOPS

After anlayzing the changes between above two versions, we found that
the endio context changed since commit 378f32bab3714("ext4: introduce
direct I/O write using iomap infrastructure"), in aio DIO overwriting
case. And the problem still exist in latest mainline.
4.18: endio is processed under irq context
 dio_bio_end_aio
  defer_completion = dio->defer_completion || ... // defer_completion is
                                                  // false for overwrite
  if (defer_completion) {
    queue_work
  } else {
    dio_complete                          // endio in irq context
  }
mainline: endio is processed in kworker
 iomap_dio_bio_end_io
  if (dio->flags & IOMAP_DIO_INLINE_COMP) // false, only for read
  if (dio->flags & IOMAP_DIO_CALLER_COMP) // false, only for io_uring
  queue_work                              // endio in kworker context

Assume that nvme irq registers on cpu 1, and fio runs on cpu 1, it could
be possible(Actually we did reproduce it easily) that fio, nvme irq and
kworker all run on cpu 1. Firstly, compared with 4.18, there are extra
operations(eg. queue work and wake up kworker) while processing endio,
which is slower than processing endio under nvme irq context. Secondly,
fio and kworker will race to get cpu resource, which will slow down fio.

There is no need to do
ext4_convert_unwritten_extents/ext4_handle_inode_extension under
ext4_dio_write_end_io in overwriting case, so we can put ext4 dio endio
under irq context.

It is worth noting that iomap_dio_complete shouldn't be executed under
irq context if datasync is required(IOMAP_DIO_NEED_SYNC), so overwriting
endio is still done in kworker for this situation.

Zhihao Cheng (2):
  iomap: Add a IOMAP_DIO_MAY_INLINE_COMP flag
  ext4: Optimize endio process for DIO overwrites

 fs/ext4/file.c        |  8 ++++++--
 fs/iomap/direct-io.c  | 10 ++++++++--
 include/linux/iomap.h |  6 ++++++
 3 files changed, 20 insertions(+), 4 deletions(-)

-- 
2.39.2


