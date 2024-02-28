Return-Path: <linux-fsdevel+bounces-13028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DD886A4EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 02:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 309271F21D40
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 01:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3318B1CD0F;
	Wed, 28 Feb 2024 01:23:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32BBCA7D;
	Wed, 28 Feb 2024 01:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709083394; cv=none; b=EW60zTFQ7fsw+8ucUwkADDGFtlSvn5rW+oUWV3Gq4v61BY9Ni/pPfWDbFyUV+OlJ0T5D/IhhmbSUY6PmGaRScWXm+fFZ+rHUAq8CvmPpoPr0SpVAoyl4xclJVz6KemfItA/xdFMX+snSNuv4yhuGPc/aI3lT9T645w1CgRXNnA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709083394; c=relaxed/simple;
	bh=ySnKkkmIyF0nM+QoFS34jQb3+OjGr4X7xBd2KkCkhSs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sxIQagL1yVqw6xfHR7jYdpAl0D7bALY8V8OTeZFzmDmFVgzKf+RUUte2kqGQnVXvvgu6K3Ib5eWrmXak6k/E82prZWnn7GOlVW9T5Mgz6WAzUcvsFcVqbBCsaG7dKHEGZGCZjVM4vOhQTNEObPI5duQgLXNGSFt5yHiHNLuF47Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TkxS80Gn7z4f3jsY;
	Wed, 28 Feb 2024 09:23:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 4580C1A0DDE;
	Wed, 28 Feb 2024 09:23:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgDX8gv7it5lqQx6FQ--.57137S2;
	Wed, 28 Feb 2024 09:23:09 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	tim.c.chen@linux.intel.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] Fixes and cleanups to fs-writeback
Date: Wed, 28 Feb 2024 17:19:52 +0800
Message-Id: <20240228091958.288260-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDX8gv7it5lqQx6FQ--.57137S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr1DCF17CF4rXFy7ZFyrJFb_yoWfuwb_ZF
	WkJFyDJwnrXF17JayI9FnxJFyqkw4UXF15JF15CFs8Ar1Skrs8Zrs5ArWDXr1UXFy7uan8
	Gw17Ww48JrsFgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb2xYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl8c
	AvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWD
	JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gc
	CE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxI
	r21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87
	Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
	vE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
	87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUsBMNUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

v1->v2:
-Filter non-expired in requeue_inode in patch "fs/writeback: avoid to
writeback non-expired inode in kupdate writeback"
-Wrap the comment at 80 columns in patch "fs/writeback: only calculate
dirtied_before when b_io is empty"
-Abandon patch "fs/writeback: remove unneeded check in
writeback_single_inode"
-Collect RVB from Jan and Tim

Kemeng Shi (6):
  fs/writeback: avoid to writeback non-expired inode in kupdate
    writeback
  fs/writeback: bail out if there is no more inodes for IO and queued
    once
  fs/writeback: remove unused parameter wb of finish_writeback_work
  fs/writeback: only calculate dirtied_before when b_io is empty
  fs/writeback: correct comment of __wakeup_flusher_threads_bdi
  fs/writeback: remove unnecessary return in writeback_inodes_sb

 fs/fs-writeback.c | 57 +++++++++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 24 deletions(-)

-- 
2.30.0


