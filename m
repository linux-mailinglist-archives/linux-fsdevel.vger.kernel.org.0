Return-Path: <linux-fsdevel+bounces-17764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D268B2265
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 15:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A419AB26F3C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 13:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E9F149C7C;
	Thu, 25 Apr 2024 13:17:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B923022331;
	Thu, 25 Apr 2024 13:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714051052; cv=none; b=LTJ38a1LkuvvzKTjElBzoUzaI774Iylcdcb/68p2U8firBrfUGGYmaVyP9TBEqgq9rT2Vmi+0wZ66CxucpkFMtS0tX5+NPNltpyUCzXNQ0nxJnIVfKuv/jyO2xXjpIk9/gHCYoZ+3nd+fkmkgi0OL21BvoZ3QELNP7S/QLwNojY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714051052; c=relaxed/simple;
	bh=L0TY563YT83IZ6ayZjf48s0Ao3TTmt+yqW9NgGVjvpI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RQ9mUghR3k9mhK7bfuTyMr1rF4JwqZsraYim3kbxD6nrUmd0WgyIkbhRm8g1J+83tag/61yuDHF8+vSoGXdcgYwWz5cl4AeKEFN3KS+EyMtmRJ/YntzkkgxV1jGW9jhqj2ORn5IAcOsYCWtzWg0zK9Gak2WqyFa2klSZqQiaJM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VQGby40vRz4f3khg;
	Thu, 25 Apr 2024 21:17:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 2B41E1A0568;
	Thu, 25 Apr 2024 21:17:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP3 (Coremail) with SMTP id _Ch0CgA3+J_kVypmFDcOKw--.42283S2;
	Thu, 25 Apr 2024 21:17:25 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: willy@infradead.org,
	akpm@linux-foundation.org
Cc: tj@kernel.org,
	jack@suse.cz,
	hcochran@kernelspring.com,
	axboe@kernel.dk,
	mszeredi@redhat.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] Fix and cleanups to page-writeback
Date: Thu, 25 Apr 2024 21:17:20 +0800
Message-Id: <20240425131724.36778-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgA3+J_kVypmFDcOKw--.42283S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKr1DtFykCFW7ZF1UCry5XFb_yoW3Krc_Wa
	y8JasrGryUXF43Wa429wn8XFyUKr4UWryDG3ZYqFWDAryIqr4DZrn2kw4fZr1xZFy7AFW3
	uFZrXw4fJwn2kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb28YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
	vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

v1->v2:
-rebase on up-to-date tree.
-add test result in "mm: correct calculation of wb's bg_thresh in cgroup
domain"
-drop "mm: remove redundant check in wb_min_max_ratio"
-collect RVB from Matthew to "mm: remove stale comment __folio_mark_dirty"

This series contains some random cleanups and a fix to correct
calculation of wb's bg_thresh in cgroup domain. More details can
be found respective patches. Thanks!

Kemeng Shi (4):
  mm: enable __wb_calc_thresh to calculate dirty background threshold
  mm: correct calculation of wb's bg_thresh in cgroup domain
  mm: call __wb_calc_thresh instead of wb_calc_thresh in
    wb_over_bg_thresh
  mm: remove stale comment __folio_mark_dirty

 mm/page-writeback.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

-- 
2.30.0


