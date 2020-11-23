Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48412C0029
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Nov 2020 07:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgKWGin (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 01:38:43 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:43808 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726626AbgKWGim (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 01:38:42 -0500
X-UUID: 4478e254bcb4440ebe8244f9399a7d23-20201123
X-UUID: 4478e254bcb4440ebe8244f9399a7d23-20201123
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1958505899; Mon, 23 Nov 2020 14:38:38 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 23 Nov 2020 14:38:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 23 Nov 2020 14:38:35 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>
Subject: [RESEND PATCH v1] proc: use untagged_addr() for pagemap_read addresses
Date:   Mon, 23 Nov 2020 14:38:35 +0800
Message-ID: <20201123063835.18981-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When we try to visit the pagemap of a tagged userspace pointer, we find
that the start_vaddr is not correct because of the tag.
To fix it, we should untag the usespace pointers in pagemap_read().

I tested with 5.10-rc4 and the issue remains.

My test code is baed on [1]:

A userspace pointer which has been tagged by 0xb4: 0xb400007662f541c8

=== userspace program ===

uint64 OsLayer::VirtualToPhysical(void *vaddr) {
	uint64 frame, paddr, pfnmask, pagemask;
	int pagesize = sysconf(_SC_PAGESIZE);
	off64_t off = ((uintptr_t)vaddr) / pagesize * 8; // off = 0xb400007662f541c8 / pagesize * 8 = 0x5a00003b317aa0
	int fd = open(kPagemapPath, O_RDONLY);
	...

	if (lseek64(fd, off, SEEK_SET) != off || read(fd, &frame, 8) != 8) {
		int err = errno;
		string errtxt = ErrorString(err);
		if (fd >= 0)
			close(fd);
		return 0;
	}
...
}

=== kernel fs/proc/task_mmu.c ===

static ssize_t pagemap_read(struct file *file, char __user *buf,
		size_t count, loff_t *ppos)
{
	...
	src = *ppos;
	svpfn = src / PM_ENTRY_BYTES; // svpfn == 0xb400007662f54
	start_vaddr = svpfn << PAGE_SHIFT; // start_vaddr == 0xb400007662f54000
	end_vaddr = mm->task_size;

	/* watch out for wraparound */
	// svpfn == 0xb400007662f54
	// (mm->task_size >> PAGE) == 0x8000000
	if (svpfn > mm->task_size >> PAGE_SHIFT) // the condition is true because of the tag 0xb4
		start_vaddr = end_vaddr;

	ret = 0;
	while (count && (start_vaddr < end_vaddr)) { // we cannot visit correct entry because start_vaddr is set to end_vaddr
		int len;
		unsigned long end;
		...
	}
	...
}

[1] https://github.com/stressapptest/stressapptest/blob/master/src/os.cc#L158

Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 fs/proc/task_mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 217aa2705d5d..e9a70f7ee515 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1599,11 +1599,11 @@ static ssize_t pagemap_read(struct file *file, char __user *buf,
 
 	src = *ppos;
 	svpfn = src / PM_ENTRY_BYTES;
-	start_vaddr = svpfn << PAGE_SHIFT;
+	start_vaddr = untagged_addr(svpfn << PAGE_SHIFT);
 	end_vaddr = mm->task_size;
 
 	/* watch out for wraparound */
-	if (svpfn > mm->task_size >> PAGE_SHIFT)
+	if (start_vaddr > mm->task_size)
 		start_vaddr = end_vaddr;
 
 	/*
-- 
2.18.0

