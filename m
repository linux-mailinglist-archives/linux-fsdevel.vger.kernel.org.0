Return-Path: <linux-fsdevel+bounces-24670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B9E942A2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 11:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CC10285AF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 09:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EDD1AC432;
	Wed, 31 Jul 2024 09:16:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB911AC430;
	Wed, 31 Jul 2024 09:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722417401; cv=none; b=hOqiCfAVoK+k1zKE47GPdCx/cuowwb6gs4dk+PgJ+HLUUqoXVxVaoih1NPA1fSTPBBv+Iptohr7q6CdL8ajHKpALQ9M+/i2EZs21Rx9HCeQO90feU/0EwQnics4Nn/KsACkelDHWM6G+3AVFAf8zAghtCELEFWdrF7bzrQSd/DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722417401; c=relaxed/simple;
	bh=dm4ngLb4nwvWfzDAaiHuPLMqupt+/B3kjkBU6nZ+3lo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XC3ppSE/zxX3f2tmKvbDaqPb4FCSrGRUckfU01dLptMXv6w/43MZtwHst2ml/hXBQAXUSPwjAn3GEJYqIojao7hjLZsQxgr7GYY2AEBLt/T7et+4tMu/HY49CW64GA25qNkqOoVsOaTEV0e3LY6S5UmIw9RZA2nV1xEmGS5bIHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WYmg74sK6z4f3jrx;
	Wed, 31 Jul 2024 17:16:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 934271A0C12;
	Wed, 31 Jul 2024 17:16:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgB37ILpAKpmm6FzAQ--.49647S4;
	Wed, 31 Jul 2024 17:16:32 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	brauner@kernel.org,
	david@fromorbit.com,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH 0/6] iomap: some minor non-critical fixes and improvements when block size < folio size
Date: Wed, 31 Jul 2024 17:12:59 +0800
Message-Id: <20240731091305.2896873-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB37ILpAKpmm6FzAQ--.49647S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr13WF18KFy5Xr4fuFyrtFb_yoW8WrW7pF
	W3Kr98Gr1DJr1ayF93WayUXrnYy34rKF45J34fGwn2vFnxCF1xXF10ga95ua40yryfCr4F
	qr1jgFy7Wr4DC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfU5dgADUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

This series contains some minor non-critical fixes and performance
improvements on the filesystem with block size < folio size.

The first 4 patches fix the handling of setting and clearing folio ifs
dirty bits when mark the folio dirty and when invalidat the folio.
Although none of these code mistakes caused a real problem now, it's
still deserve a fix to correct the behavior.

The second 2 patches drop the unnecessary state_lock in ifs when setting
and clearing dirty/uptodate bits in the buffered write path, it could
improve some (~10% on my machine) buffer write performance. I tested it
through UnixBench on my x86_64 (Xeon Gold 6151) and arm64 (Kunpeng-920)
virtual machine with 50GB ramdisk and xfs filesystem, the results shows
below.

UnixBench test cmd:
 ./Run -i 1 -c 1 fstime-w

Before:
x86    File Write 1024 bufsize 2000 maxblocks       524708.0 KBps
arm64  File Write 1024 bufsize 2000 maxblocks       801965.0 KBps

After:
x86    File Write 1024 bufsize 2000 maxblocks       571315.0 KBps
arm64  File Write 1024 bufsize 2000 maxblocks       876077.0 KBps

Thanks,
Yi.

Zhang Yi (6):
  iomap: correct the range of a partial dirty clear
  iomap: support invalidating partial folios
  iomap: advance the ifs allocation if we have more than one blocks per
    folio
  iomap: correct the dirty length in page mkwrite
  iomap: drop unnecessary state_lock when setting ifs uptodate bits
  iomap: drop unnecessary state_lock when changing ifs dirty bits

 fs/iomap/buffered-io.c | 55 ++++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 21 deletions(-)

-- 
2.39.2


