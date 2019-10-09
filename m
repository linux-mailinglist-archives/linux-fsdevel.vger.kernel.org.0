Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42B8DD1123
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 16:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731454AbfJIOYr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 10:24:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38608 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729491AbfJIOYr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 10:24:47 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6047481DF1;
        Wed,  9 Oct 2019 14:24:46 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 14C6460BF4;
        Wed,  9 Oct 2019 14:24:42 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Qian Cai <cai@lca.pw>, Dan Williams <dan.j.williams@intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>,
        Pankaj gupta <pagupta@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/2] mm: Don't access uninitialized memmaps in fs/proc/page.c
Date:   Wed,  9 Oct 2019 16:24:34 +0200
Message-Id: <20191009142435.3975-2-david@redhat.com>
In-Reply-To: <20191009142435.3975-1-david@redhat.com>
References: <20191009142435.3975-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 09 Oct 2019 14:24:46 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There are three places where we access uninitialized memmaps, namely:
- /proc/kpagecount
- /proc/kpageflags
- /proc/kpagecgroup

We have initialized memmaps either when the section is online or when
the page was initialized to the ZONE_DEVICE. Uninitialized memmaps contain
garbage and in the worst case trigger kernel BUGs, especially with
CONFIG_PAGE_POISONING.

For example, not onlining a DIMM during boot and calling /proc/kpagecount
with CONFIG_PAGE_POISONING:
:/# cat /proc/kpagecount > tmp.test
[   95.600592] BUG: unable to handle page fault for address: fffffffffffffffe
[   95.601238] #PF: supervisor read access in kernel mode
[   95.601675] #PF: error_code(0x0000) - not-present page
[   95.602116] PGD 114616067 P4D 114616067 PUD 114618067 PMD 0
[   95.602596] Oops: 0000 [#1] SMP NOPTI
[   95.602920] CPU: 0 PID: 469 Comm: cat Not tainted 5.4.0-rc1-next-20191004+ #11
[   95.603547] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.4
[   95.604521] RIP: 0010:kpagecount_read+0xce/0x1e0
[   95.604917] Code: e8 09 83 e0 3f 48 0f a3 02 73 2d 4c 89 e7 48 c1 e7 06 48 03 3d ab 51 01 01 74 1d 48 8b 57 08 480
[   95.606450] RSP: 0018:ffffa14e409b7e78 EFLAGS: 00010202
[   95.606904] RAX: fffffffffffffffe RBX: 0000000000020000 RCX: 0000000000000000
[   95.607519] RDX: 0000000000000001 RSI: 00007f76b5595000 RDI: fffff35645000000
[   95.608128] RBP: 00007f76b5595000 R08: 0000000000000001 R09: 0000000000000000
[   95.608731] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000140000
[   95.609327] R13: 0000000000020000 R14: 00007f76b5595000 R15: ffffa14e409b7f08
[   95.609924] FS:  00007f76b577d580(0000) GS:ffff8f41bd400000(0000) knlGS:0000000000000000
[   95.610599] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   95.611083] CR2: fffffffffffffffe CR3: 0000000078960000 CR4: 00000000000006f0
[   95.611686] Call Trace:
[   95.611906]  proc_reg_read+0x3c/0x60
[   95.612228]  vfs_read+0xc5/0x180
[   95.612505]  ksys_read+0x68/0xe0
[   95.612785]  do_syscall_64+0x5c/0xa0
[   95.613092]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

For now, let's drop support for ZONE_DEVICE from the three pseudo files
in order to fix this. To distinguish offline memory (with garbage memmap)
from ZONE_DEVICE memory with properly initialized memmaps, we would have to
check get_dev_pagemap() and pfn_zone_device_reserved() right now. The usage
of both (especially, special casing devmem) is frowned upon and needs to
be reworked. The fundamental issue we have is:

	if (pfn_to_online_page(pfn)) {
		/* memmap initialized */
	} else if (pfn_valid(pfn)) {
		/*
		 * ???
		 * a) offline memory. memmap garbage.
		 * b) devmem: memmap initialized to ZONE_DEVICE.
		 * c) devmem: reserved for driver. memmap garbage.
		 * (d) devmem: memmap currently initializing - garbage)
		 */
	}

We'll leave the pfn_zone_device_reserved() check in stable_page_flags()
in place as that function is also used from memory failure. We now
no longer dump information about pages that are not in use anymore -
offline.

Reported-by: Qian Cai <cai@lca.pw>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>
Cc: Pankaj gupta <pagupta@redhat.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/page.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index decd3fe39674..e40dbfe1168e 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -42,10 +42,12 @@ static ssize_t kpagecount_read(struct file *file, char __user *buf,
 		return -EINVAL;
 
 	while (count > 0) {
-		if (pfn_valid(pfn))
-			ppage = pfn_to_page(pfn);
-		else
-			ppage = NULL;
+		/*
+		 * TODO: ZONE_DEVICE support requires to identify
+		 * memmaps that were actually initialized.
+		 */
+		ppage = pfn_to_online_page(pfn);
+
 		if (!ppage || PageSlab(ppage) || page_has_type(ppage))
 			pcount = 0;
 		else
@@ -218,10 +220,11 @@ static ssize_t kpageflags_read(struct file *file, char __user *buf,
 		return -EINVAL;
 
 	while (count > 0) {
-		if (pfn_valid(pfn))
-			ppage = pfn_to_page(pfn);
-		else
-			ppage = NULL;
+		/*
+		 * TODO: ZONE_DEVICE support requires to identify
+		 * memmaps that were actually initialized.
+		 */
+		ppage = pfn_to_online_page(pfn);
 
 		if (put_user(stable_page_flags(ppage), out)) {
 			ret = -EFAULT;
@@ -263,10 +266,11 @@ static ssize_t kpagecgroup_read(struct file *file, char __user *buf,
 		return -EINVAL;
 
 	while (count > 0) {
-		if (pfn_valid(pfn))
-			ppage = pfn_to_page(pfn);
-		else
-			ppage = NULL;
+		/*
+		 * TODO: ZONE_DEVICE support requires to identify
+		 * memmaps that were actually initialized.
+		 */
+		ppage = pfn_to_online_page(pfn);
 
 		if (ppage)
 			ino = page_cgroup_ino(ppage);
-- 
2.21.0

