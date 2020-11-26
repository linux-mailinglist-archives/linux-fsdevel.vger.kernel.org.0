Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D36F2C4F3A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 08:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388371AbgKZHQ0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 02:16:26 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:4103 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729631AbgKZHQ0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 02:16:26 -0500
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ChTZC4LNgzXgMb;
        Thu, 26 Nov 2020 15:16:03 +0800 (CST)
Received: from dggemi759-chm.china.huawei.com (10.1.198.145) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Thu, 26 Nov 2020 15:16:21 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi759-chm.china.huawei.com (10.1.198.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 26 Nov 2020 15:16:21 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Thu, 26 Nov 2020 15:16:21 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Miles Chen <miles.chen@mediatek.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wsd_upstream@mediatek.com" <wsd_upstream@mediatek.com>
Subject: RE: [RESEND PATCH v1] proc: use untagged_addr() for pagemap_read
 addresses
Thread-Topic: [RESEND PATCH v1] proc: use untagged_addr() for pagemap_read
 addresses
Thread-Index: AQHWwWNz5MRhXZKR2UCNja39TEhHcanaA0sg
Date:   Thu, 26 Nov 2020 07:16:21 +0000
Message-ID: <24d32889abb1412abcd4e868a36783f9@hisilicon.com>
References: <20201123063835.18981-1-miles.chen@mediatek.com>
In-Reply-To: <20201123063835.18981-1-miles.chen@mediatek.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.201]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> -----Original Message-----
> From: Miles Chen [mailto:miles.chen@mediatek.com]
> Sent: Monday, November 23, 2020 7:39 PM
> To: Alexey Dobriyan <adobriyan@gmail.com>; Andrew Morton
> <akpm@linux-foundation.org>
> Cc: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-mediatek@lists.infradead.org; wsd_upstream@mediatek.com; Miles
> Chen <miles.chen@mediatek.com>
> Subject: [RESEND PATCH v1] proc: use untagged_addr() for pagemap_read
> addresses
> 
> When we try to visit the pagemap of a tagged userspace pointer, we find
> that the start_vaddr is not correct because of the tag.
> To fix it, we should untag the usespace pointers in pagemap_read().
> 
> I tested with 5.10-rc4 and the issue remains.
> 
> My test code is baed on [1]:
> 
> A userspace pointer which has been tagged by 0xb4: 0xb400007662f541c8
> 
> === userspace program ===
> 
> uint64 OsLayer::VirtualToPhysical(void *vaddr) {
> 	uint64 frame, paddr, pfnmask, pagemask;
> 	int pagesize = sysconf(_SC_PAGESIZE);
> 	off64_t off = ((uintptr_t)vaddr) / pagesize * 8; // off =
> 0xb400007662f541c8 / pagesize * 8 = 0x5a00003b317aa0
> 	int fd = open(kPagemapPath, O_RDONLY);
> 	...
> 
> 	if (lseek64(fd, off, SEEK_SET) != off || read(fd, &frame, 8) != 8) {
> 		int err = errno;
> 		string errtxt = ErrorString(err);
> 		if (fd >= 0)
> 			close(fd);
> 		return 0;
> 	}
> ...
> }
> 
> === kernel fs/proc/task_mmu.c ===
> 
> static ssize_t pagemap_read(struct file *file, char __user *buf,
> 		size_t count, loff_t *ppos)
> {
> 	...
> 	src = *ppos;
> 	svpfn = src / PM_ENTRY_BYTES; // svpfn == 0xb400007662f54
> 	start_vaddr = svpfn << PAGE_SHIFT; // start_vaddr ==
> 0xb400007662f54000
> 	end_vaddr = mm->task_size;
> 
> 	/* watch out for wraparound */
> 	// svpfn == 0xb400007662f54
> 	// (mm->task_size >> PAGE) == 0x8000000
> 	if (svpfn > mm->task_size >> PAGE_SHIFT) // the condition is true because
> of the tag 0xb4
> 		start_vaddr = end_vaddr;
> 
> 	ret = 0;
> 	while (count && (start_vaddr < end_vaddr)) { // we cannot visit correct
> entry because start_vaddr is set to end_vaddr
> 		int len;
> 		unsigned long end;
> 		...
> 	}
> 	...
> }
> 
> [1]
> https://github.com/stressapptest/stressapptest/blob/master/src/os.cc#L158
> 
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> ---
>  fs/proc/task_mmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 217aa2705d5d..e9a70f7ee515 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1599,11 +1599,11 @@ static ssize_t pagemap_read(struct file *file, char
> __user *buf,
> 
>  	src = *ppos;
>  	svpfn = src / PM_ENTRY_BYTES;
> -	start_vaddr = svpfn << PAGE_SHIFT;
> +	start_vaddr = untagged_addr(svpfn << PAGE_SHIFT);
>  	end_vaddr = mm->task_size;
> 
>  	/* watch out for wraparound */
> -	if (svpfn > mm->task_size >> PAGE_SHIFT)
> +	if (start_vaddr > mm->task_size)
>  		start_vaddr = end_vaddr;

Wouldn't the untag be done by the user reading pagemap file?
With this patch, even users pass an illegal address, for example,
users put a tag on a virtual address which hasn't really a tag,
they will still get the right pagemap.

> 
>  	/*
> --
> 2.18.0

Thanks
Barry

