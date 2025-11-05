Return-Path: <linux-fsdevel+bounces-67070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B70C345B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 08:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DFAB4EF594
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 07:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E392D738A;
	Wed,  5 Nov 2025 07:51:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA2A2D3EF2;
	Wed,  5 Nov 2025 07:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762329076; cv=none; b=XszjePNXWj+fjl+MgJWp/ZK60FWmQKJKWSJP7yjjy9K2a7YXkEvdQHuKAUW4udzg5h5jPsSnsf3M714bha3+5p4Wou3RYQf1oZ4jV03v/ST2xSFDwBGvbiH+7MAOm9tbcevHHH11bqxqmWsFogKskU7zr8ljG2m2/y7ZJa8bOvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762329076; c=relaxed/simple;
	bh=GcHIDROv4Fr5TWfluLvmmBRAc0i1hJy5IIBrVOzS/EE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T31fcFPJjjoB2H7uQXB2/d5CkLEIMmBMRQ+Dt/2owQ+Us+pDEHYuQcBFXEHniN+u7Fbv5C72qQm1/o/+NUw4l94z7EkJffs0S0DxTmaq7ZnIK9dxHaH64iGG+8l4zczjcqP3CiqLkHN6gna24YSbGUVrnwBriZof7aXVq+yHulA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d1cvL6XV6zYQvM7;
	Wed,  5 Nov 2025 15:50:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 13E0C1A1970;
	Wed,  5 Nov 2025 15:51:11 +0800 (CST)
Received: from huawei.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgCn_UXuAQtpwcIVCw--.9854S4;
	Wed, 05 Nov 2025 15:51:10 +0800 (CST)
From: Yongjian Sun <sunyongjian@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	tytso@mit.edu,
	jack@suse.cz,
	yangerkun@huawei.com,
	yi.zhang@huawei.com,
	libaokun1@huawei.com,
	chengzhihao1@huawei.com,
	sunyongjian1@huawei.com
Subject: [PATCH 0/2] ext4: fixes for mb_check_buddy integrity checks
Date: Wed,  5 Nov 2025 15:42:48 +0800
Message-Id: <20251105074250.3517687-1-sunyongjian@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Reply-To: sunyongjian1@huawei.com
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCn_UXuAQtpwcIVCw--.9854S4
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYn7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r
	4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAK
	I48JMxAqzxv26xkF7I0En4kS14v26r1q6r43MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
	tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvj
	xUoKsjUUUUU
X-CM-SenderInfo: 5vxq505qjmxt3q6k3tpzhluzxrxghudrp/

From: Yongjian Sun <sunyongjian1@huawei.com>

Yongjian Sun (2):
  ext4: fix incorrect group number assertion in mb_check_buddy for
    exhausted preallocations
  ext4: improve integrity checking in __mb_check_buddy by enhancing
    order-0 validation

 fs/ext4/mballoc.c | 59 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 42 insertions(+), 17 deletions(-)

-- 
2.39.2


