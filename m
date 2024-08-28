Return-Path: <linux-fsdevel+bounces-27502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6A3961D0C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 05:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF9561F23EDE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 03:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB7414264A;
	Wed, 28 Aug 2024 03:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="k0+J59F2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A913314287
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 03:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724815955; cv=none; b=U4MLrN3F+g/zuViEsiTwkbys27LwDjQaVZo0g52ib+uJVEGWHypz7LdJD1uOwe4/+LcMq4GuIcRs0DHlnA95mrI1KLSnggikj19rGM7cxYJA8yIDDs/5v4NkxUmiOk5kGuTjboiXEzeunoWxYNCRxfyhTrrMA1TxY7RRd/0Hi3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724815955; c=relaxed/simple;
	bh=5I+HdjJIRMydaP7gAcyCzrj8B9drhLDnFzt8FtBGUOA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tbM9KGJSBNVG6gjcXiFCR+55FvgL/dlQfQVgKN2QSJVth/pt6Hl87V1SxbH5lo3zJnJXHGIQnDOBkDYNuu59khpPBgOF1uAP7HGwc8GO8DMYPC7BwHKErxoIVTwE4ygzweO9xOOXSqIW8M6zzC1lLMHbL65/KxPLJH7s2MGnf+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=k0+J59F2; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d3bd8784d3so4870728a91.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 20:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1724815952; x=1725420752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lkrS/c7eA51KRjEOsPxgljxFXqyg4/bJQNYY4aZ/YZU=;
        b=k0+J59F253kT1+gcaySRTHP1yOtHy7pSMloQntshMOMOWr9R0PIW30swmC6KZV+J7O
         FiQH3eFeSrfFJl16+TcaKMNQrcjVB0oN6pqjunbDq6hhQFIy2kH3KvxZO0h1s3VKvtbu
         l4/MiWPUchXAWrKsz7Fh8hkOt6tPFvWwHDzGPeCyd0Q0EcTTVPUFLR1ClcNfOxQ6kNn+
         5HcxXlgxmmWjSZVGqD1HlE3REw9Du6imCLkNAaLyJQI1kMWtoR8ruU93Mt3E1YeFeI2l
         4RYG53Z1DgPAgWNaOwpSSYf8S1PNDES0ZcDNw2Y/XXDEdvCsNmAV0lhwKRSbnm/20U5m
         0p9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724815952; x=1725420752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lkrS/c7eA51KRjEOsPxgljxFXqyg4/bJQNYY4aZ/YZU=;
        b=sr3w6DbW7e7dj4LziZCygSP/wndE652ZZqr0XCTIq9dlTB0dHzn8Mn5eP0My/dKnMj
         tiH5UUvr5y8iL6HfqDFQQBBpoIaDSDGc/FD+RZdEPw7y25/SWfA4QYR3u3hMz1kaDwMR
         WYJl1rN0SMKcBwuTepuSXzbQSjESYNkO7vwOxopa74Sdinf7Sk8h/dU8yyd0c2waNyPc
         ayxvfxzIgWRxiT6szMqufJYNOXquyyr0JLPSwyUPI7MYlmUkZ87lYKbd6jJSbo7j0ZJ9
         Yu8dy0rCzhhr+YPZP2HAz03TvwfpBCgtkl0+G7dFOLOWe9y44zBf9kDTalQwsWrS1+9t
         M1ZA==
X-Forwarded-Encrypted: i=1; AJvYcCW9957A7O1lvMi5PHfcl3on2ZUz5eb1rxZOqxKfSKnmVJaChzrz1vFUxJYdAM9a2eegiX83QtmpDtQhK5Ll@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+iFeNwrvGVPUhMmaHrs31EUcrLvh6j3SDitVyvj8/SiFr5iAH
	yS6rOboMEKbFFipfNwNXUM45JyuUyhHsXWe2ZFKGsiWcoIIe1DVTyHhl+0CBWBA=
X-Google-Smtp-Source: AGHT+IG1fanM1xqpwU6LysH/RO6JJxsuwXSldXMwzYv+IXWA2QBQfOmN6P64rUkB5BabAl1YTzK4rQ==
X-Received: by 2002:a17:90a:a40d:b0:2c2:deda:8561 with SMTP id 98e67ed59e1d1-2d646d8db89mr15290079a91.41.1724815951882;
        Tue, 27 Aug 2024 20:32:31 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8283f6d9csm1985951a91.0.2024.08.27.20.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 20:32:31 -0700 (PDT)
From: Haifeng Xu <haifeng.xu@shopee.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: tytso@mit.edu,
	yi.zhang@huaweicloud.com,
	yukuai1@huaweicloud.com,
	tj@kernel.org,
	linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH] buffer: Associate the meta bio with blkg from buffer page
Date: Wed, 28 Aug 2024 11:32:24 +0800
Message-Id: <20240828033224.146584-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In our production environment, we found many tasks were hung for
a long time. Their call traces are like these:

thread 1:

PID: 189529  TASK: ffff92ab51e5c080  CPU: 34  COMMAND: "mc"
[ffffa638db807800] __schedule at ffffffff83b19898
[ffffa638db807888] schedule at ffffffff83b19e9e
[ffffa638db8078a8] io_schedule at ffffffff83b1a316
[ffffa638db8078c0] bit_wait_io at ffffffff83b1a751
[ffffa638db8078d8] __wait_on_bit at ffffffff83b1a373
[ffffa638db807918] out_of_line_wait_on_bit at ffffffff83b1a46d
[ffffa638db807970] __wait_on_buffer at ffffffff831b9c64
[ffffa638db807988] jbd2_log_do_checkpoint at ffffffff832b556e
[ffffa638db8079e8] __jbd2_log_wait_for_space at ffffffff832b55dc
[ffffa638db807a30] add_transaction_credits at ffffffff832af369
[ffffa638db807a98] start_this_handle at ffffffff832af50f
[ffffa638db807b20] jbd2__journal_start at ffffffff832afe1f
[ffffa638db807b60] __ext4_journal_start_sb at ffffffff83241af3
[ffffa638db807ba8] __ext4_new_inode at ffffffff83253be6
[ffffa638db807c80] ext4_mkdir at ffffffff8327ec9e
[ffffa638db807d10] vfs_mkdir at ffffffff83182a92
[ffffa638db807d50] ovl_mkdir_real at ffffffffc0965c9f [overlay]
[ffffa638db807d80] ovl_create_real at ffffffffc0965e8b [overlay]
[ffffa638db807db8] ovl_create_or_link at ffffffffc09677cc [overlay]
[ffffa638db807e10] ovl_create_object at ffffffffc0967a48 [overlay]
[ffffa638db807e60] ovl_mkdir at ffffffffc0967ad3 [overlay]
[ffffa638db807e70] vfs_mkdir at ffffffff83182a92
[ffffa638db807eb0] do_mkdirat at ffffffff83184305
[ffffa638db807f08] __x64_sys_mkdirat at ffffffff831843df
[ffffa638db807f28] do_syscall_64 at ffffffff83b0bf1c
[ffffa638db807f50] entry_SYSCALL_64_after_hwframe at ffffffff83c0007c

other threads:

PID: 21125  TASK: ffff929f5b9a0000  CPU: 44  COMMAND: "task_server"
[ffffa638aff9b900] __schedule at ffffffff83b19898
[ffffa638aff9b988] schedule at ffffffff83b19e9e
[ffffa638aff9b9a8] schedule_preempt_disabled at ffffffff83b1a24e
[ffffa638aff9b9b8] __mutex_lock at ffffffff83b1af28
[ffffa638aff9ba38] __mutex_lock_slowpath at ffffffff83b1b1a3
[ffffa638aff9ba48] mutex_lock at ffffffff83b1b1e2
[ffffa638aff9ba60] mutex_lock_io at ffffffff83b1b210
[ffffa638aff9ba80] __jbd2_log_wait_for_space at ffffffff832b563b
[ffffa638aff9bac8] add_transaction_credits at ffffffff832af369
[ffffa638aff9bb30] start_this_handle at ffffffff832af50f
[ffffa638aff9bbb8] jbd2__journal_start at ffffffff832afe1f
[ffffa638aff9bbf8] __ext4_journal_start_sb at ffffffff83241af3
[ffffa638aff9bc40] ext4_dirty_inode at ffffffff83266d0a
[ffffa638aff9bc60] __mark_inode_dirty at ffffffff831ab423
[ffffa638aff9bca0] generic_update_time at ffffffff8319169d
[ffffa638aff9bcb0] inode_update_time at ffffffff831916e5
[ffffa638aff9bcc0] file_update_time at ffffffff83191b01
[ffffa638aff9bd08] file_modified at ffffffff83191d47
[ffffa638aff9bd20] ext4_write_checks at ffffffff8324e6e4
[ffffa638aff9bd40] ext4_buffered_write_iter at ffffffff8324edfb
[ffffa638aff9bd78] ext4_file_write_iter at ffffffff8324f553
[ffffa638aff9bdf8] ext4_file_write_iter at ffffffff8324f505
[ffffa638aff9be00] new_sync_write at ffffffff8316dfca
[ffffa638aff9be90] vfs_write at ffffffff8316e975
[ffffa638aff9bec8] ksys_write at ffffffff83170a97
[ffffa638aff9bf08] __x64_sys_write at ffffffff83170b2a
[ffffa638aff9bf18] do_syscall_64 at ffffffff83b0bf1c
[ffffa638aff9bf38] asm_common_interrupt at ffffffff83c00cc8
[ffffa638aff9bf50] entry_SYSCALL_64_after_hwframe at ffffffff83c0007c

The filesystem is ext4(ordered). The meta data can be written out by
writeback, but if there are too many dirty pages, we had to do
checkpoint to write out the meta data in current thread context.

In this case, the blkg of thread1 has set io.max, so the j_checkpoint_mutex
can't be released and many threads must wait for it. However, the blkg from
buffer page didn' set any io policy. Therefore, for the meta buffer head,
we can associate the bio with blkg from the buffer page instead of current
thread context.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 fs/buffer.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/buffer.c b/fs/buffer.c
index e55ad471c530..a7889f258d0d 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2819,6 +2819,17 @@ static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
 	if (wbc) {
 		wbc_init_bio(wbc, bio);
 		wbc_account_cgroup_owner(wbc, bh->b_page, bh->b_size);
+	} else if (buffer_meta(bh)) {
+		struct folio *folio;
+		struct cgroup_subsys_state *memcg_css, *blkcg_css;
+
+		folio = page_folio(bh->b_page);
+		memcg_css = mem_cgroup_css_from_folio(folio);
+		if (cgroup_subsys_on_dfl(memory_cgrp_subsys) &&
+		    cgroup_subsys_on_dfl(io_cgrp_subsys)) {
+			blkcg_css = cgroup_e_css(memcg_css->cgroup, &io_cgrp_subsys);
+			bio_associate_blkg_from_css(bio, blkcg_css);
+		}
 	}
 
 	submit_bio(bio);
-- 
2.25.1


