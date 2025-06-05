Return-Path: <linux-fsdevel+bounces-50731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D40BACF01D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 15:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A24FE1899CED
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 13:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C8422D790;
	Thu,  5 Jun 2025 13:17:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6AF38FB9;
	Thu,  5 Jun 2025 13:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749129423; cv=none; b=KNL+vqXk7PJKn6dtyT5vGKCDNVl1z92GM31+Nz/ZBQxy74/Kgd15zZJOJElRDRNmo3YZoNv32wWrdN/negAuvSxq2a1vq9UReY3J7Izta/ykteZq+EFqDeps1NQljeA+hqu2ZIgODCUDhadwPUycL0OTE94VypmSIi7y47e8H6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749129423; c=relaxed/simple;
	bh=4d5JJ/c1jR0wHKQHZnxPxIReNnqyfDLCCv1OX9n/Er0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gg2iYtl+90pXHXXkf1lFXJx0lwGqsXDa7EhKNwpB+budbNkgWROWc+vcVdRhVvsCA7FjWnRAZfzn3Nq+2u5Q0LLXWjCAYlNmrTPrJd5u0Ge4SjB4tprg4R3cYrLWSuFSoz7aCSuw3QObziOLXhHD4qDrh6lJo2HnD7PWTblH2HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bClNB2DVNzYQvdp;
	Thu,  5 Jun 2025 21:16:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 5A3EE1A159C;
	Thu,  5 Jun 2025 21:16:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP1 (Coremail) with SMTP id cCh0CgDnTH3HmEFobD9lOQ--.29489S2;
	Thu, 05 Jun 2025 21:16:57 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: hughd@google.com,
	baolin.wang@linux.alibaba.com,
	willy@infradead.org,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/7] Some random fixes and cleanups to shmem
Date: Fri,  6 Jun 2025 06:10:30 +0800
Message-Id: <20250605221037.7872-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDnTH3HmEFobD9lOQ--.29489S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gry7uF1DGFW3Cr17Ar1kZrb_yoWDWrX_uF
	WFqFy5Grn0vF4UWFyS9F4DJrZYgrW8Wr4qvFyrta1akFyUAFnxCw1DWrWrZr1xX3W5CrZ5
	AF4vqr1xJw17WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
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
	j3TmhUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

This series contains more fixes and cleanups which are made during
learning shmem. Patch 1-3 are some random fixes; Patch 4-7 are some
random cleanups. More details can be found in respective patches. Thanks!

Kemeng Shi (7):
  mm: shmem: correctly pass alloced parameter to shmem_recalc_inode() to
    avoid WARN_ON()
  mm: shmem: avoid setting error on splited entries in
    shmem_set_folio_swapin_error()
  mm: shmem: avoid missing entries in shmem_undo_range() when entries
    was splited concurrently
  mm: shmem: handle special case of shmem_recalc_inode() in it's caller
  mm: shmem: wrap additional shmem quota related code with
    CONFIG_TMPFS_QUOTA
  mm: shmem: simplify error flow in thpsize_shmem_enabled_store()
  mm: shmem: eliminate unneeded page counting in
    shmem_unuse_swap_entries()

 include/linux/shmem_fs.h |   4 +
 mm/filemap.c             |   2 +-
 mm/internal.h            |   2 +
 mm/shmem.c               | 169 ++++++++++++++++++++++++++-------------
 4 files changed, 121 insertions(+), 56 deletions(-)

-- 
2.30.0


