Return-Path: <linux-fsdevel+bounces-33425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BFC9B8B66
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 07:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 996CDB21EFF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 06:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5691547EF;
	Fri,  1 Nov 2024 06:51:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DC91527B1;
	Fri,  1 Nov 2024 06:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730443881; cv=none; b=AUI9q/EJC8X6+etTT57Vt95tYj9oncJRlS0+MIA+WzKnWcQWWPnhtKRrWtH3kztmrTshQQmqkEOyVt9/coK5DdwbkuKLYEDFEcQBLa2TnDBmPYUglq0MesavflTSaTVAhCRFj1inuAXohIYoqMK4dr5Pdf/nk63LhHpwWLHAZzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730443881; c=relaxed/simple;
	bh=L63OyW7jQVcbNqAaR3sT+P7iha7o9KrUA3h5l/XUH/o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FN0UEpVqNPnM4uImSHiDI6SjRMe0EtYf1qkAiXyhhIUkK/6+oBJei4+yb6E3feGVY6rUug46Pm3ep7agEd1xS9eby+k3GD7FwLfuo2QK+u5okglIO3UaobvL24SkS3IFhxF2E4e/mnOrAqVC/gcnegmLH1/yHfSgWJrmCAgK5QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xfs2T2l1Cz4f3jt9;
	Fri,  1 Nov 2024 14:50:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id EE37B1A0194;
	Fri,  1 Nov 2024 14:51:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP3 (Coremail) with SMTP id _Ch0CgAHmcVceiRnzhcPAg--.62749S2;
	Fri, 01 Nov 2024 14:51:09 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org,
	willy@infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/6] Fixes and cleanups to xarray
Date: Fri,  1 Nov 2024 23:50:22 +0800
Message-Id: <20241101155028.11702-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAHmcVceiRnzhcPAg--.62749S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GryUKFWxuF45Jr1kuF1xKrg_yoW3CFg_ua
	yvkF9rtr4UAFWUJa429Fn0q3yrJr48Gr12vFyYgr43ZFyUXr9xJr1kAr45XrnrWFy7JayD
	XrZ8ZryFkw17tjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb7xYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl8c
	AvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq
	3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gc
	CE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxI
	r21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87
	Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
	vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j-6pPUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/


This series contains some random fixes and cleanups to xarray. Patch 1-3
are fixes and patch 4-6 are cleanups. More details can be found in
respective patches. Thanks!

Kemeng Shi (6):
  Xarray: Do not return sibling entries from xas_find_marked()
  Xarray: distinguish large entries correctly in xas_split_alloc()
  Xarray: move forward index correctly in xas_pause()
  Xarray: skip unneeded xas_store() and xas_clear_mark() in __xa_alloc()
  Xarray: remove repeat check in xas_squash_marks()
  Xarray: use xa_mark_t in xas_squash_marks() to keep code consistent

 lib/test_xarray.c                     | 35 +++++++++++++++++++++++++++
 lib/xarray.c                          | 33 ++++++++++++++-----------
 tools/testing/radix-tree/multiorder.c |  4 +++
 3 files changed, 58 insertions(+), 14 deletions(-)

-- 
2.30.0


