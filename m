Return-Path: <linux-fsdevel+bounces-28480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5278E96B19A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 08:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07DEB1F21755
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 06:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34A11384B9;
	Wed,  4 Sep 2024 06:31:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ED7D2FB;
	Wed,  4 Sep 2024 06:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725431476; cv=none; b=rICjKGxkJN4fmlXPKFi/cTZYozaZS1GOR5CRjI8lntQNzAe9MQVhibQy7xSfRHlTeZPAOrYY5pIqZh5DhzgZUdzHpp2i5jQSc+opZ7Qslv4miOaI2/4/dM28Mf0B7vQDoXyUytNgqXC9m//DA7HXF4ZEbTJJqXEHoZ7HJlnx7D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725431476; c=relaxed/simple;
	bh=ymxE/mFIEEcQfGhvoEMdefF73lJUke8MMEv/Pug4dfE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D99tRe9TyIt/29aOJEygIpBgXc1NSRp9dWbL9pRlQZsgBp/h3BmP0+q0fmcbU9U7SjOuK5gVH/BuxDXfzkXgc1yESe/AAVeD+xOrIZ4ny5+vjjzNLQPHNhzAaoXd3PeiXcqf3I6/vKsyXCZbh+0+wQNQlH53UtWqUWLIZYR3240=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WzCL66nQnz4f3jMD;
	Wed,  4 Sep 2024 14:30:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E868E1A0359;
	Wed,  4 Sep 2024 14:31:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAnXMif_tdmjKtlAQ--.29879S4;
	Wed, 04 Sep 2024 14:31:09 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH v2 00/10] ext4: clean up and refactor fallocate
Date: Wed,  4 Sep 2024 14:29:15 +0800
Message-Id: <20240904062925.716856-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAnXMif_tdmjKtlAQ--.29879S4
X-Coremail-Antispam: 1UD129KBjvJXoW7KF45ZrW7Cr17Gr15tF4DXFb_yoW8AFWrpF
	WfWwnaqr4jg3sruws3Zw4xXF4xKw4rAw47JFWIgw4vgrn5uF109F4Uta40kFWxAFWfJa47
	XFWjvrnru3Wjka7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
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
 - Fix an using uninitialized variable problem in the error out path in
   ext4_do_fallocate() in patch 08.

Current ext4 fallocate code is mess with mode checking, locking, input
parameter checking, position calculation, and having some stale code.
Almost all of the five sub-functions have the same preparation, it
deserve a clean up now.

This series tries to clean this up by refactor all fallocate related
operations, it unify variable naming, reduce some unnecessary position
calculation, factor out one common helper to check input parameters, and
also foctor out one common helper to wait for the dios to finish, hold
filemap invalidate lock, write back dirty data and drop page cache.

The first patch fix a potential data loss problem when punch hole, zero
range and collapse range by always write back dirty pages. Later patchs
do cleanup and refactor work, please see them for details. After this
series, we can reduce a lot of redundant code and make it more clear
than before.

Thanks,
Yi.

Zhang Yi (10):
  ext4: write out dirty data before dropping pages
  ext4: don't explicit update times in ext4_fallocate()
  ext4: drop ext4_update_disksize_before_punch()
  ext4: refactor ext4_zero_range()
  ext4: refactor ext4_punch_hole()
  ext4: refactor ext4_collapse_range()
  ext4: refactor ext4_insert_range()
  ext4: factor out ext4_do_fallocate()
  ext4: factor out the common checking part of all fallocate operations
  ext4: factor out a common helper to lock and flush data before
    fallocate

 fs/ext4/ext4.h    |   5 +-
 fs/ext4/extents.c | 566 +++++++++++++++++++---------------------------
 fs/ext4/inode.c   | 173 ++++----------
 3 files changed, 278 insertions(+), 466 deletions(-)

-- 
2.39.2


