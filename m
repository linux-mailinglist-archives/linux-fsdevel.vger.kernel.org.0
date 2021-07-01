Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7E63B8C8C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jul 2021 05:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238751AbhGADL1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 23:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238682AbhGADLY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 23:11:24 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEE6C061756;
        Wed, 30 Jun 2021 20:08:55 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id h4so4810579pgp.5;
        Wed, 30 Jun 2021 20:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LPhAq6c+h5ijWlJnLIAaDpeTI322IxRs/Oy2An/y/kA=;
        b=uFOwINFwmNxyQBzS/7gh0nM9K64OpKP5FgbjsHQDJclbfMM+0OgSCH5OMmz7lo3qXP
         8y3VYlTiN+AtdkPnKfrvWezVM3wtcsIH59VSm+FGu6M5U+KyJ2Az0LHMMvG4kAAHNF8e
         LCkdqO9ZcaWrxT7uDPo+4Qe6QBWPHkwEKT2l0dnPip7ZeDtiu7Qbw/evAR+hFMvaTrCP
         ptokm5Rs6rhKrRvSLhDfYJ2xY6g6SyB/HNpZQctUf6Wp1rn6Q2dlUvqTvB/7k1bsG+j8
         2fvSteepFc7xbJ35+y8Fp3md+aVQhJPq8dnuZqt2LYNNkg6VRMC+/BCBcuSWUhJEOJyr
         RcZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LPhAq6c+h5ijWlJnLIAaDpeTI322IxRs/Oy2An/y/kA=;
        b=JlzLfkevVeuDwOLdOi6uOhXDYG5JG5zl6Vqhbz4/eri98f5OiPLBM8nz3Rr9wvDoUN
         QjmqqZSitHz+E6aCrUWKFOtCE6rtAUHMfEDEHNy7X5zscOwWMNp0/HhHj741/dTrKMno
         XSwHWZRM08uNLXc5FvSWP4kjDgsYi4/yW47ROmnd/pdKORaBZgqEjlETGBCWooCrn5T9
         xYRY7dONge0v57BR/A4uEyGafeSl7MBh1pTYYW9AxQfzB87NgsF9VQXfXdbRtCrVbIfs
         TSDxaQeWyOa6khT+RTgQWCnLjdrdxjxxe0BgUMf99eSZXNwH1SyDRdZ3KanITjzn4ujp
         YhxA==
X-Gm-Message-State: AOAM530+Yq3EI1RCD7OwaDSW9bSHNPi5D7WYcaE2kAFwt1cmfU4nrmUL
        8rAHlJWP2RcO0GJLfqT4DaH3tZC5Asyav+B0rPE=
X-Google-Smtp-Source: ABdhPJy4CJN5Z5COPTfLLuJMK0Ixaxb/eqC1GAcsIFCvO9wp/P29XH0swMMi+appF545pq08P0ROYw==
X-Received: by 2002:a63:ba06:: with SMTP id k6mr3248290pgf.220.1625108934625;
        Wed, 30 Jun 2021 20:08:54 -0700 (PDT)
Received: from localhost.localdomain ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id g10sm4568568pjv.46.2021.06.30.20.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 20:08:54 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     gustavoars@kernel.org, viro@zeniv.linux.org.uk
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        slava@dubeyko.com, skhan@linuxfoundation.org,
        gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2 2/3] hfs: fix high memory mapping in hfs_bnode_read
Date:   Thu,  1 Jul 2021 11:07:55 +0800
Message-Id: <20210701030756.58760-3-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210701030756.58760-1-desmondcheongzx@gmail.com>
References: <20210701030756.58760-1-desmondcheongzx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pages that we read in hfs_bnode_read need to be kmapped into kernel
address space. However, currently only the 0th page is kmapped. If the
given offset + length exceeds this 0th page, then we have an invalid
memory access.

To fix this, we kmap relevant pages one by one and copy their relevant
portions of data.

An example of invalid memory access occurring without this fix can be
seen in the following crash report:

==================================================================
BUG: KASAN: use-after-free in memcpy include/linux/fortify-string.h:191 [inline]
BUG: KASAN: use-after-free in hfs_bnode_read+0xc4/0xe0 fs/hfs/bnode.c:26
Read of size 2 at addr ffff888125fdcffe by task syz-executor5/4634

CPU: 0 PID: 4634 Comm: syz-executor5 Not tainted 5.13.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x195/0x1f8 lib/dump_stack.c:120
 print_address_description.constprop.0+0x1d/0x110 mm/kasan/report.c:233
 __kasan_report mm/kasan/report.c:419 [inline]
 kasan_report.cold+0x7b/0xd4 mm/kasan/report.c:436
 check_region_inline mm/kasan/generic.c:180 [inline]
 kasan_check_range+0x154/0x1b0 mm/kasan/generic.c:186
 memcpy+0x24/0x60 mm/kasan/shadow.c:65
 memcpy include/linux/fortify-string.h:191 [inline]
 hfs_bnode_read+0xc4/0xe0 fs/hfs/bnode.c:26
 hfs_bnode_read_u16 fs/hfs/bnode.c:34 [inline]
 hfs_bnode_find+0x880/0xcc0 fs/hfs/bnode.c:365
 hfs_brec_find+0x2d8/0x540 fs/hfs/bfind.c:126
 hfs_brec_read+0x27/0x120 fs/hfs/bfind.c:165
 hfs_cat_find_brec+0x19a/0x3b0 fs/hfs/catalog.c:194
 hfs_fill_super+0xc13/0x1460 fs/hfs/super.c:419
 mount_bdev+0x331/0x3f0 fs/super.c:1368
 hfs_mount+0x35/0x40 fs/hfs/super.c:457
 legacy_get_tree+0x10c/0x220 fs/fs_context.c:592
 vfs_get_tree+0x93/0x300 fs/super.c:1498
 do_new_mount fs/namespace.c:2905 [inline]
 path_mount+0x13f5/0x20e0 fs/namespace.c:3235
 do_mount fs/namespace.c:3248 [inline]
 __do_sys_mount fs/namespace.c:3456 [inline]
 __se_sys_mount fs/namespace.c:3433 [inline]
 __x64_sys_mount+0x2b8/0x340 fs/namespace.c:3433
 do_syscall_64+0x37/0xc0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x45e63a
Code: 48 c7 c2 bc ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 88 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9404d410d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000248 RCX: 000000000045e63a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f9404d41120
RBP: 00007f9404d41120 R08: 00000000200002c0 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 0000000000000003 R14: 00000000004ad5d8 R15: 0000000000000000

The buggy address belongs to the page:
page:00000000dadbcf3e refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x125fdc
flags: 0x2fffc0000000000(node=0|zone=2|lastcpupid=0x3fff)
raw: 02fffc0000000000 ffffea000497f748 ffffea000497f6c8 0000000000000000
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888125fdce80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888125fdcf00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff888125fdcf80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                                                ^
 ffff888125fdd000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888125fdd080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================

Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
---
 fs/hfs/bnode.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index b63a4df7327b..c0a73a6ffb28 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -15,16 +15,31 @@
 
 #include "btree.h"
 
-void hfs_bnode_read(struct hfs_bnode *node, void *buf,
-		int off, int len)
+void hfs_bnode_read(struct hfs_bnode *node, void *buf, int off, int len)
 {
 	struct page *page;
+	int pagenum;
+	int bytes_read;
+	int bytes_to_read;
+	void *vaddr;
 
 	off += node->page_offset;
-	page = node->page[0];
+	pagenum = off >> PAGE_SHIFT;
+	off &= ~PAGE_MASK; /* compute page offset for the first page */
 
-	memcpy(buf, kmap(page) + off, len);
-	kunmap(page);
+	for (bytes_read = 0; bytes_read < len; bytes_read += bytes_to_read) {
+		if (pagenum >= node->tree->pages_per_bnode)
+			break;
+		page = node->page[pagenum];
+		bytes_to_read = min_t(int, len - bytes_read, PAGE_SIZE - off);
+
+		vaddr = kmap_atomic(page);
+		memcpy(buf + bytes_read, vaddr + off, bytes_to_read);
+		kunmap_atomic(vaddr);
+
+		pagenum++;
+		off = 0; /* page offset only applies to the first page */
+	}
 }
 
 u16 hfs_bnode_read_u16(struct hfs_bnode *node, int off)
-- 
2.25.1

