Return-Path: <linux-fsdevel+bounces-34222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD02B9C3EEA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 13:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A28A4284EA0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 12:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFA71AAE1C;
	Mon, 11 Nov 2024 12:55:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F3819DF4D;
	Mon, 11 Nov 2024 12:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731329701; cv=none; b=WsgnuAvb4p5Yi7QKedXacgGHN2rsq/2VF1lH+EwvrOtbY+SSU4Z9tkGK1pGZKSL7gYpklpZ5skFMBEEyJgOUSUGhqui9kWZw5vaT8XMEaNF0KmEygwxPw6F3rS7uC2+PVLJMARHhw8Hl5//CDAiKosrHNGsEW4GsNRvMNwG6shk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731329701; c=relaxed/simple;
	bh=9T6kfsDKgMbtkWYG6v9h5udnRIqsmK19/CMNG4eb59c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fIFOsulh1u7UmWa9zPfZxR/hdU1ctaAiYMhT2xUpzoMtEY2Oz0kclrptFZu6j4UQKHr+6zQicRF2PHmwo3crynwWSTXyk8UGNsza2LGCx1DHjQY9D8/zBUZ6HxCNROwOQmXRIVXMFRGlE8p0DqWfgDH7raVf3vZKYJxKHHC8BV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xn8db0MXqz4f3kpP;
	Mon, 11 Nov 2024 20:54:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 214A61A0568;
	Mon, 11 Nov 2024 20:54:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP4 (Coremail) with SMTP id gCh0CgB3n4Oe_jFnllryBQ--.36628S2;
	Mon, 11 Nov 2024 20:54:55 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org,
	willy@infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH RESEND V2 0/5] Fixes and cleanups to xarray
Date: Tue, 12 Nov 2024 05:53:54 +0800
Message-Id: <20241111215359.246937-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3n4Oe_jFnllryBQ--.36628S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr4xur45Cw43AF1kKF4rXwb_yoW3Krg_ua
	4vkF9rtr4UAFWUJa429Fn8t3yrAr48Gr1jqFyYgr43ZFyUXrZxJr4kCr45XrnrWFyaya4D
	XrW5ZryFkw17KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl8c
	AvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWD
	JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gc
	CE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxI
	r21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87
	Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAa
	w2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r12
	6r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07
	jSYL9UUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

resend:
-also cc linux-mm

v1->v2:
-Drop patch "Xarray: skip unneeded xas_store() and xas_clear_mark() in
__xa_alloc()"

This series contains some random fixes and cleanups to xarray. Patch 1-3
are fixes and patch 4-5 are cleanups. More details can be found in
respective patches. Thanks!

Kemeng Shi (5):
  Xarray: Do not return sibling entries from xas_find_marked()
  Xarray: distinguish large entries correctly in xas_split_alloc()
  Xarray: move forward index correctly in xas_pause()
  Xarray: remove repeat check in xas_squash_marks()
  Xarray: use xa_mark_t in xas_squash_marks() to keep code consistent

 lib/test_xarray.c                     | 35 +++++++++++++++++++++++++++
 lib/xarray.c                          | 26 +++++++++++---------
 tools/testing/radix-tree/multiorder.c |  4 +++
 3 files changed, 54 insertions(+), 11 deletions(-)

-- 
2.30.0


