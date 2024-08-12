Return-Path: <linux-fsdevel+bounces-25667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8703294EC98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 14:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA34E1C2176E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 12:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB8117A5AD;
	Mon, 12 Aug 2024 12:16:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0242513634B;
	Mon, 12 Aug 2024 12:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464983; cv=none; b=kOPUWj1PyVG97wQKmBwcTg4K6U0bc+N8UIsZgyYHqz+kmIWMEHCQWPHQAghM0ZDTtsuI03ieKtBFIjzJL7wY6TLaHfd722floEsyHnCeXUH9TEtq6rZ1Z9K+raZDu8FhWgwfpIE0xLBYPxnf4WAyO7xm9t1he/qUhVCezesAEvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464983; c=relaxed/simple;
	bh=4BYV6v4Hw0CJPWckbUhfullAUNf/TCOxkcGynzSXdtc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V/n8yNqKBZdAQ6xpx4Ox4Glq9Wqx4Jk8kV3VNoDhBd4q/7qclMzYPn+HBrohYHWheJOPn3XNxg4m9+OCSa4tZmBKvNN8RZMuxyX2E6ihek74TkeoRuVvUgTD0RwsKDQCutpNmbjiZWIAcogk2iuZsvNjf1uJlWJ/NrRUOatrznU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WjD4r4Ddcz4f3mJH;
	Mon, 12 Aug 2024 20:15:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 324951A0359;
	Mon, 12 Aug 2024 20:16:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP3 (Coremail) with SMTP id _Ch0CgDHeLcD_blmHhy7BQ--.21435S4;
	Mon, 12 Aug 2024 20:16:10 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	brauner@kernel.org,
	david@fromorbit.com,
	jack@suse.cz,
	willy@infradead.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH v2 0/6] iomap: some minor non-critical fixes and improvements when block size < folio size
Date: Mon, 12 Aug 2024 20:11:53 +0800
Message-Id: <20240812121159.3775074-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDHeLcD_blmHhy7BQ--.21435S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uF17Jr4xGw45tF13trW5ZFb_yoW8uFyUpF
	WfKF98Kr1Dtw1ayas3W3y7Xr1Fvw1FqF15Ga4xGws8AFnxJFyxXF10ga98uay0yr4Skrs0
	qr1jgFyxWr1DAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUFg4SDUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Changes since v1:
 - Patch 5 fix a stale data exposure problem pointed out by Willy, drop
   the setting of uptodate bits after zeroing out unaligned range.
 - As Dave suggested, in order to prevent increasing the complexity of
   maintain the state_lock, don't just drop all the state_lock in the
   buffered write path, patch 6 introduce a new helper to set uptodate
   bit and dirty bits together under the state_lock, reduce one time of
   locking per write, the benefits of performance optimization do not
   change too much.

This series contains some minor non-critical fixes and performance
improvements on the filesystem with block size < folio size.

The first 4 patches fix the handling of setting and clearing folio ifs
dirty bits when mark the folio dirty and when invalidat the folio.
Although none of these code mistakes caused a real problem now, it's
still deserve a fix to correct the behavior.

The second 2 patches drop the unnecessary state_lock in ifs when setting
and clearing dirty/uptodate bits in the buffered write path, it could
improve some (~8% on my machine) buffer write performance. I tested it
through UnixBench on my x86_64 (Xeon Gold 6151) and arm64 (Kunpeng-920)
virtual machine with 50GB ramdisk and xfs filesystem, the results shows
below.

UnixBench test cmd:
 ./Run -i 1 -c 1 fstime-w

Before:
x86    File Write 1024 bufsize 2000 maxblocks       524708.0 KBps
arm64  File Write 1024 bufsize 2000 maxblocks       801965.0 KBps

After:
x86    File Write 1024 bufsize 2000 maxblocks       569218.0 KBps
arm64  File Write 1024 bufsize 2000 maxblocks       871605.0 KBps

Thanks,
Yi.

Zhang Yi (6):
  iomap: correct the range of a partial dirty clear
  iomap: support invalidating partial folios
  iomap: advance the ifs allocation if we have more than one blocks per
    folio
  iomap: correct the dirty length in page mkwrite
  iomap: don't mark blocks uptodate after partial zeroing
  iomap: reduce unnecessary state_lock when setting ifs uptodate and
    dirty bits

 fs/iomap/buffered-io.c | 73 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 60 insertions(+), 13 deletions(-)

-- 
2.39.2


