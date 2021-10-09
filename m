Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B67427868
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Oct 2021 11:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244345AbhJIJ3D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Oct 2021 05:29:03 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:60186 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231818AbhJIJ3B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Oct 2021 05:29:01 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0Ur5qOcb_1633771618;
Received: from localhost.localdomain(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0Ur5qOcb_1633771618)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 09 Oct 2021 17:27:02 +0800
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        viro@zeniv.linux.org.uk, song@kernel.org,
        william.kucharski@oracle.com, hughd@google.com,
        shy828301@gmail.com, linmiaohe@huawei.com, peterx@redhat.com
Subject: [PATCH 3/3] mm, thp: make mapping address of PIC binaries THP align
Date:   Sat,  9 Oct 2021 17:26:58 +0800
Message-Id: <20211009092658.59665-4-rongwei.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211009092658.59665-1-rongwei.wang@linux.alibaba.com>
References: <20211009092658.59665-1-rongwei.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For binaries that are compiled with '--pie -fPIC' and with LOAD
alignment smaller than 2M (typically 4K, 64K), the load address
is least likely to be 2M aligned.

This changes the maximum_alignment of such binaries to 2M to
facilitate file THP for .text section as far as possible.

Signed-off-by: Gang Deng <gavin.dg@linux.alibaba.com>
Signed-off-by: Xu Yu <xuyu@linux.alibaba.com>
Signed-off-by: Rongwei Wang <rongwei.wang@linux.alibaba.com>
---
 fs/binfmt_elf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index a813b70f594e..78795572d877 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1136,6 +1136,11 @@ static int load_elf_binary(struct linux_binprm *bprm)
 				retval = -EINVAL;
 				goto out_free_dentry;
 			}
+#ifdef CONFIG_HUGETEXT
+			if (hugetext_enabled() && interpreter &&
+					total_size >= HPAGE_PMD_SIZE)
+				load_bias &= HPAGE_PMD_MASK;
+#endif
 		}
 
 		error = elf_map(bprm->file, load_bias + vaddr, elf_ppnt,
-- 
2.27.0

