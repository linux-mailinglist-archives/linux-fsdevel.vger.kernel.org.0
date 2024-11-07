Return-Path: <linux-fsdevel+bounces-33873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 631E99BFF25
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 08:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0947C1F22B04
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 07:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102921DA109;
	Thu,  7 Nov 2024 07:30:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5D61922CC;
	Thu,  7 Nov 2024 07:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730964624; cv=none; b=AHogf8UsOcNxZDH1DXztrkGd3jdyXQBWqMvDA7G+imRBdTv+2O+D/7VPv65x1/NVaN1NbyBSO22TvMWIQK6m83aPEkHRBNgdi7cIRw3Cn+WmJgpKhQCqNkHiguhUs1QQ81y99uPVJVIrNikfT1LMdaU7zEmjxYgPGmyXA+E4m4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730964624; c=relaxed/simple;
	bh=wdvtLC5ulGCY1T01mm9zMUMjvGRUSfUxdg3fNyaNeEI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TxHTG8jItpFpx0OfBWey86tPoESyoQiJ9P2loAIq3gznSB5RvhDua6arly7ig3Z7y1/HY9Y2ERQnn2lvqS1jgZI4wIbVc2ReeA+X8eM9BANUhyUYhoSpu598ty7KbhX1Uf5nVBXt/G77Jjjj+HCKP7LrEmZTOV14HYIq6lcz0wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XkYcj6N0gz4f3kk5;
	Thu,  7 Nov 2024 15:29:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C208E1A0196;
	Thu,  7 Nov 2024 15:30:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP1 (Coremail) with SMTP id cCh0CgB3Ha+BbCxnnlhABA--.55387S2;
	Thu, 07 Nov 2024 15:30:10 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org,
	willy@infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/5] Fixes and cleanups to xarray
Date: Fri,  8 Nov 2024 00:29:15 +0800
Message-Id: <20241107162920.208796-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgB3Ha+BbCxnnlhABA--.55387S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr4xur17Xr47JFy5GrWDtwb_yoW3urb_ua
	4vkF9rKr4UAFWUJay29Fn0q395Gr48Gr1jvFyYgw43ZFyUXr9xJr4kCr45Xrn7WFy2ya4D
	XFZ8ZryFkw17KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb7xYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl8c
	AvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWD
	JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gc
	CE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxI
	r21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87
	Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
	vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j-6pPUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

v1->v2:
-Drop patch "Xarray: skip unneeded xas_store() and xas_clear_mark() in
__xa_alloc()"

This series contains some random fixes and cleanups to xarray. Patch 1-3
are fixes and patch 4-6 are cleanups. More details can be found in
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


