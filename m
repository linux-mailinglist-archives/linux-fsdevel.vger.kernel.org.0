Return-Path: <linux-fsdevel+bounces-37262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 315469F0315
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 04:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9487E188B0A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 03:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A2A187553;
	Fri, 13 Dec 2024 03:27:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A9B186616;
	Fri, 13 Dec 2024 03:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734060440; cv=none; b=mz+kbjC0r8vJI/xrktz5Mr3P2B0xmM1gi1m3DXo5HeZ7PhCZ74eB6aPVYv37RrlkFASCBn3maTd2jwgoKwe5zutINqjS0NpbGER5zsbPfdPu5bIej6MTdiOcjZL1xt6pwIf3xoAx+5XPD51ZTaW9X6E9dTyzEZUGNb9SeECAbbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734060440; c=relaxed/simple;
	bh=YvgpRnVIM7awCI7or1Vy2Ib5Au+JjqfRJDNMhtUNIX0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gU7e2D0cM9eva3j3Gu+fIgDwY6pmZe9ohlAR1Na9lmLtnxVK/XYdoAndgG5rvWWZo48mVX6MaNE4ApvHslZY/vU5e60l0CbJrJHq02uRZR5wU3VJ2FKY+F3mrVJ/ewpRJhW1LskNHKtTEAjHRlATZPmS+zHK8iTrNlD9l1/SnnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Y8ZWg2rfdz4f3jkc;
	Fri, 13 Dec 2024 11:26:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B2E981A0359;
	Fri, 13 Dec 2024 11:27:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP4 (Coremail) with SMTP id gCh0CgBHcISMqVtnfJ3KEQ--.55430S2;
	Fri, 13 Dec 2024 11:27:09 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org,
	willy@infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 0/5] Fixes and cleanups to xarray
Date: Fri, 13 Dec 2024 20:25:18 +0800
Message-Id: <20241213122523.12764-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHcISMqVtnfJ3KEQ--.55430S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw4fur15Jr4Dtw45JrWkZwb_yoWfGFb_ua
	4kCF9rtr4UAFWDJa429Fn0q3yrGr48Gr1jyFyYgr47ZFyUXr9xJr4kCr15Xrn7WFy7JayD
	Xrs8XryFkw17KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl8c
	AvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7
	JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s
	0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487
	Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aV
	AFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS
	14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWU
	twCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUVc
	TmDUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

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


