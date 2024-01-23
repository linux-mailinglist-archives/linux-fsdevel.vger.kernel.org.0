Return-Path: <linux-fsdevel+bounces-8528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6978E838C2B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 11:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21672289672
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 10:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042895C8E7;
	Tue, 23 Jan 2024 10:35:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579B85C610;
	Tue, 23 Jan 2024 10:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706006155; cv=none; b=tdRMByEOV+0RRFmqpmenxGPmugoxNZuLd3QGouwB5vysKYUxcFPr+SbH1Pas0kpGGBEdmqC91B4y4TOlnWWb1RrR3sKN9RETAUtmIbXmHPknAv5S5jsrZv13w9uHq5CyBr+p3o2BWioDuLpYG7c7FEsG7aqouD85uaifVkiKBLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706006155; c=relaxed/simple;
	bh=jGLQft2UCd1WQbnLWgW3Z8a2vV5Cihn+2pK2dxVLl1E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kDRPNX1/B6LLQpu/bqjHhDmWxS0dlDqMTw9IhbXCM7n0ZPyc3LFcecDmgM2TUa2yCipg5goJ2NK8y1Rkm+q3bjDykbTv7D5IHzH2VrP7OyrmM+w7qFMXBI7nx7Kg6IGuHWWRx4dkRdYTeOrEAy55h4WsZ0Gd6s969C+GhQojOcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TK3QX5kmSz4f3jZG;
	Tue, 23 Jan 2024 18:35:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 22D631A0232;
	Tue, 23 Jan 2024 18:35:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgA3Bg+Flq9ly6DjBg--.30161S2;
	Tue, 23 Jan 2024 18:35:50 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: willy@infradead.org,
	akpm@linux-foundation.org
Cc: tj@kernel.org,
	hcochran@kernelspring.com,
	mszeredi@redhat.com,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Fix and cleanups to page-writeback
Date: Wed, 24 Jan 2024 02:33:27 +0800
Message-Id: <20240123183332.876854-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3Bg+Flq9ly6DjBg--.30161S2
X-Coremail-Antispam: 1UD129KBjvdXoWrXr1rCFyfJr47uw4DGr1DGFg_yoWxXFg_Wa
	y8JasrGryUJFZ8Ga429wn8XFyDGw4UWr1UG3ZYqrWUJr1Iqr1DZF1DCa1rZr1xZF1UuFy3
	AF9rXr4ftwn7CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb7AYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl8c
	AvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWD
	JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gc
	CE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxI
	r21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87
	Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
	vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU0VnQUUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

This series contains some random cleanups and a fix to correct
calculation of cgroup wb's bg_thresh. More details can be found
respective patches. Thanks!

Kemeng Shi (5):
  mm: enable __wb_calc_thresh to calculate dirty background threshold
  mm: correct calculation of cgroup wb's bg_thresh in wb_over_bg_thresh
  mm: call __wb_calc_thresh instead of wb_calc_thresh in
    wb_over_bg_thresh
  mm: remove redundant check in wb_min_max_ratio
  mm: remove stale comment __folio_mark_dirty

 mm/page-writeback.c | 43 +++++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

-- 
2.30.0


