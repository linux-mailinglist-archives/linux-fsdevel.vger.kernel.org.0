Return-Path: <linux-fsdevel+bounces-69867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F87C88E32
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 10:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C7B54E305C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 09:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458A4314B6E;
	Wed, 26 Nov 2025 09:14:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE094280CF6;
	Wed, 26 Nov 2025 09:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764148491; cv=none; b=UbMbZqSXlYoj8wN4Rnmv8dMqSitA00SlgVfDzyOIsyTubftDjTYlvQpAm6tWXIJL9LBrk/h2d+wpclrGGkEG1b63dwFBDtf6ter4a+vDpc0FoZcRlNBD98cdO29FrpYjy7vnL4vMkABvJ2VUFjMbDstABLOXxB5z0XyRje5UQR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764148491; c=relaxed/simple;
	bh=SYrF8vtHOzZA8g/R+xrV1eMlzbnF/Fjt++a/NVV0g2s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KC/KxnmokJBg021ZxIAu1e3bxJpRvtHmGGNO5ocLbSgF4Fz5tpxwV5rd0oUzxS/H3M4/00WzxSMt+HfsEOHHiUfhl0y4OrlK0tD3CqZv9e7bQO/BF+zp19joJXg5f1v2JULXReJiq9MC7tpdUgN5kjnvpCWJvsORF8uNuZ7Ona0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dGYlN4ttszYQvKy;
	Wed, 26 Nov 2025 17:13:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5812B1A1897;
	Wed, 26 Nov 2025 17:14:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP4 (Coremail) with SMTP id gCh0CgAXQV4DxSZpUsJHCA--.59425S4;
	Wed, 26 Nov 2025 17:14:44 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: jack@suse.com,
	brauner@kernel.org,
	hch@lst.de,
	akpm@linux-foundation.org,
	linux@armlinux.org.uk
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	wozizhi@huawei.com,
	yangerkun@huawei.com,
	wangkefeng.wang@huawei.com,
	pangliyuan1@huawei.com,
	xieyuanbin1@huawei.com
Subject: [Bug report] hash_name() may cross page boundary and trigger sleep in RCU context
Date: Wed, 26 Nov 2025 17:05:05 +0800
Message-Id: <20251126090505.3057219-1-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXQV4DxSZpUsJHCA--.59425S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tFW7Jr45Ww1xtF1rury5XFb_yoW5JFWrpr
	45CryYkrZxZryrZr10ka9IgFyYyayUGr43Grs2qryUua1agF1avF48ta4Y9r9Iqr1DWa9r
	Wrs09wn7uw1q9FUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4I
	kC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7Cj
	xVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
	IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
	6r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
	IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUoEfOUUUUU
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

We're running into the following issue on an ARM32 platform with the linux
5.10 kernel:

[<c0300b78>] (__dabt_svc) from [<c0529cb8>] (link_path_walk.part.7+0x108/0x45c)
[<c0529cb8>] (link_path_walk.part.7) from [<c052a948>] (path_openat+0xc4/0x10ec)
[<c052a948>] (path_openat) from [<c052cf90>] (do_filp_open+0x9c/0x114)
[<c052cf90>] (do_filp_open) from [<c0511e4c>] (do_sys_openat2+0x418/0x528)
[<c0511e4c>] (do_sys_openat2) from [<c0513d98>] (do_sys_open+0x88/0xe4)
[<c0513d98>] (do_sys_open) from [<c03000c0>] (ret_fast_syscall+0x0/0x58)
...
[<c0315e34>] (unwind_backtrace) from [<c030f2b0>] (show_stack+0x20/0x24)
[<c030f2b0>] (show_stack) from [<c14239f4>] (dump_stack+0xd8/0xf8)
[<c14239f4>] (dump_stack) from [<c038d188>] (___might_sleep+0x19c/0x1e4)
[<c038d188>] (___might_sleep) from [<c031b6fc>] (do_page_fault+0x2f8/0x51c)
[<c031b6fc>] (do_page_fault) from [<c031bb44>] (do_DataAbort+0x90/0x118)
[<c031bb44>] (do_DataAbort) from [<c0300b78>] (__dabt_svc+0x58/0x80)
...

During the execution of hash_name()->load_unaligned_zeropad(), a potential
memory access beyond the PAGE boundary may occur. For example, when the
filename length is near the PAGE_SIZE boundary. This triggers a page fault,
which leads to a call to do_page_fault()->mmap_read_trylock(). If we can't
acquire the lock, we have to fall back to the mmap_read_lock() path, which
calls might_sleep(). This breaks RCU semantics because path lookup occurs
under an RCU read-side critical section. In linux-mainline, arm/arm64
do_page_fault() still has this problem:

lock_mm_and_find_vma->get_mmap_lock_carefully->mmap_read_lock_killable.

And before commit bfcfaa77bdf0 ("vfs: use 'unsigned long' accesses for
dcache name comparison and hashing"), hash_name accessed the name byte by
byte.

To prevent load_unaligned_zeropad() from accessing beyond the valid memory
region, we would need to intercept such cases beforehand? But doing so
would require replicating the internal logic of load_unaligned_zeropad(),
including handling endianness and constructing the correct value manually.
Given that load_unaligned_zeropad() is used in many places across the
kernel, we currently haven't found a good solution to address this cleanly.

What would be the recommended way to handle this situation? Would
appreciate any feedback and guidance from the community. Thanks!


