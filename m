Return-Path: <linux-fsdevel+bounces-10756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA8F84DCDC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 10:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AF8EB27424
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 09:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AEC768E1;
	Thu,  8 Feb 2024 09:23:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106C76EB67;
	Thu,  8 Feb 2024 09:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707384195; cv=none; b=a6JeTinXzQBbVSp6E+JTXjWKE51GRmTPND0sT389plPCHOL4xEZev87VdG3/Hx9YnsNjSF8IOFNy26LCUa2BII5S6DaJ27xKt2UiTkU1WNrAqG4k2qnlLVHl5VJoFlsbG/+VVoQHJjNL9h/sqhiuuTbPJPiwJIyHD7wbDTRh/vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707384195; c=relaxed/simple;
	bh=m8ByMPmtH9hhv//zYNDkx9dkDkOeAX7tnkbM/aPtZJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DdMFXhQAGrcIbq0VdfrXLdMfKqAoOTyfwfhsAMirudQEsgCMaPrvvPt0LpkdssFO72bYrRi0wJOLjXKtQYjZ/qPHi3HfFUc22NLf1y6uA9ehDJp01NTXp4jNYmFonqghoMecT+R31LzWr4Jq6yq3VJAAAzEQCIrEKMuLLtrTTqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TVs375Vtyz4f3m7Y;
	Thu,  8 Feb 2024 17:22:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 86BCD1A04BE;
	Thu,  8 Feb 2024 17:23:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP2 (Coremail) with SMTP id Syh0CgAnSQx4ncRl3tGXDQ--.8574S2;
	Thu, 08 Feb 2024 17:23:06 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] Fixes and cleanups to fs-writeback
Date: Fri,  9 Feb 2024 01:20:17 +0800
Message-Id: <20240208172024.23625-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAnSQx4ncRl3tGXDQ--.8574S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gry5AFyrXFyftr13GFy7Awb_yoW3AFb_XF
	y8JFyDJrnrXF17GayI9FnrJFyqkw4UCF1UJF15CFs8Jr1akwnxZrs5Cr4DXr1UXFyUuF4D
	GwnrWw48JwsFgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb7kYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl8c
	AvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7
	JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oV
	Cq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG
	8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2js
	IE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY
	0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcV
	CF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
	aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUsBMNUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

This series contains some random fixes and cleanups to fs-writeback.
More details can be found in respective patches. Thanks!

Kemeng Shi (7):
  fs/writeback: avoid to writeback non-expired inode in kupdate
    writeback
  fs/writeback: bail out if there is no more inodes for IO and queued
    once
  fs/writeback: remove unused parameter wb of finish_writeback_work
  fs/writeback: remove unneeded check in writeback_single_inode
  fs/writeback: only calculate dirtied_before when b_io is empty
  fs/writeback: correct comment of __wakeup_flusher_threads_bdi
  fs/writeback: remove unnecessary return in writeback_inodes_sb

 fs/fs-writeback.c | 66 +++++++++++++++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 22 deletions(-)

-- 
2.30.0


