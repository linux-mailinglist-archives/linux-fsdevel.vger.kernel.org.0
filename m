Return-Path: <linux-fsdevel+bounces-37703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E5D9F5EC9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 07:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 182C31886F73
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 06:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D174157493;
	Wed, 18 Dec 2024 06:48:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CE414B075;
	Wed, 18 Dec 2024 06:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734504493; cv=none; b=QWddpVPua5oVBan93Bs1UCjRHHyYoa9ej9zYnJoYzCAb1LFfEQXkjFa7EM7YVzzWb/TlKqH7AwEbGI4BBeHKMs6yvEP2tiEdIYlZZV/GjgDwGXhZYTadxappG5Fs9eb8p7qQzG0eO5ubSQfJVRjCt8b9ExSV7f0SzhHoq9IMA8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734504493; c=relaxed/simple;
	bh=U5MFuxxGda+/HMEwEeJcz6lvkK1M31w5xkCKOqLxHU8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uw405iVA8RaOSNXIsTXS9a5BB4LmeDkvjH4NMZ6Q1t+coJKVN/sXI5mshfxqNbSe2EU26Pv/a9T4zCNiV3MknK2pHnio8adsAN6qGSQadGrmtL+908iLLwJ6TOp9C2Qj96Dux2yG9lkzAcavkwEE/97T3dHYvCJgFBL1rvTBKUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YCkl72CXsz4f3jMK;
	Wed, 18 Dec 2024 14:47:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D141F1A07B6;
	Wed, 18 Dec 2024 14:48:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP1 (Coremail) with SMTP id cCh0CgA33a4mcGJnxKU7Ew--.4083S2;
	Wed, 18 Dec 2024 14:48:07 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org,
	willy@infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v4 0/5] Fix and cleanups to xarray
Date: Wed, 18 Dec 2024 23:46:08 +0800
Message-Id: <20241218154613.58754-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA33a4mcGJnxKU7Ew--.4083S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JFy8Gr4fXw1rCw48JryfXrb_yoWDGFX_ua
	ykCF97tw4UAFWUAaya9FnYq3yrtr48ur1jvF90gr47ZF1UXr9xJr4kCr15Xrn7WFy7Ga4D
	Xrs8XrWFkw17KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl8c
	AvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWD
	JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oV
	Cq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG
	8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2js
	IE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kK
	e7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_
	Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	jSYL9UUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

v3->v4:
-Correct changelog in patch 1 by using nfs as low-level filesystem in
example how bug could be triggered in theory.

v2->v3:
-Add impact about fixed issue in changelog.

v1->v2:
-Drop patch "Xarray: skip unneeded xas_store() and xas_clear_mark() in
__xa_alloc()"

This series contains some random fixes and cleanups to xarray. Patch 1-2
are fixes and patch 3-6 are cleanups. More details can be found in
respective patches. Thanks!

Kemeng Shi (5):
  Xarray: Do not return sibling entries from xas_find_marked()
  Xarray: move forward index correctly in xas_pause()
  Xarray: distinguish large entries correctly in xas_split_alloc()
  Xarray: remove repeat check in xas_squash_marks()
  Xarray: use xa_mark_t in xas_squash_marks() to keep code consistent

 lib/test_xarray.c                     | 35 +++++++++++++++++++++++++++
 lib/xarray.c                          | 26 +++++++++++---------
 tools/testing/radix-tree/multiorder.c |  4 +++
 3 files changed, 54 insertions(+), 11 deletions(-)

-- 
2.30.0


