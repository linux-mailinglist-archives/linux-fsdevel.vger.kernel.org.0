Return-Path: <linux-fsdevel+bounces-59426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C29B389A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 20:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F6A61B25D7F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 18:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2B02E1C56;
	Wed, 27 Aug 2025 18:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GfOCaaj9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BD52D29DB
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 18:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756319682; cv=none; b=ow1Q2ukfSgaPOGV4dR+KbA5v2/dtUcHKoMQmMyTG+Ih7DXTX/XMAEDwDjc1IOF51S7jha/qsn7nn5wJSK0nLabKbikXDKiyU3ttcgS0Gp9StKkRLfz8EDXUC93ywv/VUjyyHFWEgX2a4ZySmLEwMBXe0mLwCjZ8csEG0VgBp8eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756319682; c=relaxed/simple;
	bh=BwP2Im58iS/1V1K2roDJStD7HUdyohg5SWw9CmSQFro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=mCYt2nO/fDiHT4fkygovL81KgJo6tCS4RJiBc25jaFvujUd1YYGuVxKyCTrsFmMVki/F+hrlpxprGVR6VnIWJcWjW85/JeEjyml9EaH5Z22kYroZ1+Om8BoTlXCs0bxTteubt2DVpX3Ir/OnBZ/o1Vq8uQBRg/M/HvLt4YPSIHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GfOCaaj9; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250827183432euoutp02667bfe9df3153860f0441f83cf018d07~fs2-L67iV3018730187euoutp02P
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 18:34:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250827183432euoutp02667bfe9df3153860f0441f83cf018d07~fs2-L67iV3018730187euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1756319672;
	bh=0vmdefCDmyt9ywh+yymejY1N8ERx9TnrKiWiAjIj7Kg=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=GfOCaaj9iz+LW9wShqGApHa6/ZXQqOzHlqMklQXcYYC4w2as50eHruUBxlDoQeKd8
	 DY/qvufuUXCjNJZCjcFtYZOg42voEjT8ILaKIyRgs5ZzcIS53QnL52Zy2vmMoiK5eP
	 O2zDW8gyof+yqtT2zRTYPNi1no0gLH3CNcPp47nY=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250827183431eucas1p18406106ab84b10142c924ddc8afe26ba~fs2_wamdm0942609426eucas1p1k;
	Wed, 27 Aug 2025 18:34:31 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250827183431eusmtip29186bce2444aa1e212b09f3beb37a98d~fs292QuJH0603806038eusmtip2h;
	Wed, 27 Aug 2025 18:34:30 +0000 (GMT)
Message-ID: <8f6aa9a5-54bf-4884-aaf8-d2e3cef6ec78@samsung.com>
Date: Wed, 27 Aug 2025 20:34:30 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [syzbot] [fs?] [mm?] linux-next test error: WARNING in
 __folio_start_writeback
To: Joanne Koong <joannelkoong@gmail.com>, Aleksandr Nogikh
	<nogikh@google.com>
Cc: syzbot <syzbot+0630e71306742d4b2aea@syzkaller.appspotmail.com>, David
	Hildenbrand <david@redhat.com>, mszeredi@redhat.com,
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-next@vger.kernel.org, sfr@canb.auug.org.au,
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <CAJnrk1Ziam4ZqqyzOpbUD8j=RwJOK22Uz3VMqWZsUNiJ5bkBrg@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250827183431eucas1p18406106ab84b10142c924ddc8afe26ba
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250827164428eucas1p1e184d31f56fbcbb0d0526d2354d730a5
X-EPHeader: CA
X-CMS-RootMailID: 20250827164428eucas1p1e184d31f56fbcbb0d0526d2354d730a5
References: <68a841d7.050a0220.37038e.0051.GAE@google.com>
	<CANp29Y5zWmwXDq1uuzxi43_VXieykD2OOLF12YvBELCUS_Hibg@mail.gmail.com>
	<CGME20250827164428eucas1p1e184d31f56fbcbb0d0526d2354d730a5@eucas1p1.samsung.com>
	<CAJnrk1Ziam4ZqqyzOpbUD8j=RwJOK22Uz3VMqWZsUNiJ5bkBrg@mail.gmail.com>

On 27.08.2025 18:42, Joanne Koong wrote:
> On Wed, Aug 27, 2025 at 6:45 AM Aleksandr Nogikh <nogikh@google.com> wrote:
>> I've bisected the problem to the following commit:
>>
>> commit 167f21a81a9c4dbd6970a4ee3853aecad405fa7f (HEAD)
>> Author: Joanne Koong <joannelkoong@gmail.com>
>> Date:   Mon Jul 7 16:46:06 2025 -0700
>>
>>      mm: remove BDI_CAP_WRITEBACK_ACCT
>>
>>      There are no users of BDI_CAP_WRITEBACK_ACCT now that fuse doesn't do
>>      its own writeback accounting. This commit removes
>>      BDI_CAP_WRITEBACK_ACCT.
>>
>> Joanne Koong, could you please take a look at the syzbot report below?
> Hi Aleksandr,
>
> Thanks for bisecting this. This is a duplicate of what Marek reported
> in [1]. His patch in [2] fixes the warning getting triggered.
>
> Marek, could you submit your patch formally to the mm tree so it could
> be picked up?

I've already did that:

https://lore.kernel.org/all/20250826130948.1038462-1-m.szyprowski@samsung.com/



>
> Thanks,
> Joanne
>
>
> [1] https://lore.kernel.org/linux-fsdevel/a91010a8-e715-4f3d-9e22-e4c34efc0408@samsung.com/T/#u
> [2] https://lore.kernel.org/linux-fsdevel/a91010a8-e715-4f3d-9e22-e4c34efc0408@samsung.com/T/#m3aa6506ee7de302242e64861f8e2199f24e4ad46
>
>> On Fri, Aug 22, 2025 at 12:09 PM syzbot
>> <syzbot+0630e71306742d4b2aea@syzkaller.appspotmail.com> wrote:
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    0f4c93f7eb86 Add linux-next specific files for 20250822
>>> git tree:       linux-next
>>> console output: https://protect2.fireeye.com/v1/url?k=1fb70741-7eccadc9-1fb68c0e-74fe4860018a-55254c3abc8830cc&q=1&e=3aa7e54d-e6d6-43e9-ade0-0a94ae0545e0&u=https%3A%2F%2Fsyzkaller.appspot.com%2Fx%2Flog.txt%3Fx%3D172c07bc580000
>>> kernel config:  https://protect2.fireeye.com/v1/url?k=7674b464-170f1eec-76753f2b-74fe4860018a-dc792d3947085adc&q=1&e=3aa7e54d-e6d6-43e9-ade0-0a94ae0545e0&u=https%3A%2F%2Fsyzkaller.appspot.com%2Fx%2F.config%3Fx%3D21eed27c0deadb92
>>> dashboard link: https://protect2.fireeye.com/v1/url?k=cc82c51b-adf96f93-cc834e54-74fe4860018a-15cd3914e26f6b7e&q=1&e=3aa7e54d-e6d6-43e9-ade0-0a94ae0545e0&u=https%3A%2F%2Fsyzkaller.appspot.com%2Fbug%3Fextid%3D0630e71306742d4b2aea
>>> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
>>>
>>> Downloadable assets:
>>> disk image: https://protect2.fireeye.com/v1/url?k=e6bff250-87c458d8-e6be791f-74fe4860018a-800b933a7034a696&q=1&e=3aa7e54d-e6d6-43e9-ade0-0a94ae0545e0&u=https%3A%2F%2Fstorage.googleapis.com%2Fsyzbot-assets%2F669ede8f5d66%2Fdisk-0f4c93f7.raw.xz
>>> vmlinux: https://protect2.fireeye.com/v1/url?k=2603018e-4778ab06-26028ac1-74fe4860018a-9b89a99c7853c7f0&q=1&e=3aa7e54d-e6d6-43e9-ade0-0a94ae0545e0&u=https%3A%2F%2Fstorage.googleapis.com%2Fsyzbot-assets%2F50feda89fe89%2Fvmlinux-0f4c93f7.xz
>>> kernel image: https://protect2.fireeye.com/v1/url?k=420b962e-23703ca6-420a1d61-74fe4860018a-a965e5c8c6b4614a&q=1&e=3aa7e54d-e6d6-43e9-ade0-0a94ae0545e0&u=https%3A%2F%2Fstorage.googleapis.com%2Fsyzbot-assets%2F317a0d3516fb%2FbzImage-0f4c93f7.xz
>>>
>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>> Reported-by: syzbot+0630e71306742d4b2aea@syzkaller.appspotmail.com
>>>
>>> ------------[ cut here ]------------
>>> WARNING: ./include/linux/backing-dev.h:243 at inode_to_wb include/linux/backing-dev.h:239 [inline], CPU#1: kworker/u8:6/2949
>>> WARNING: ./include/linux/backing-dev.h:243 at __folio_start_writeback+0x9d5/0xb70 mm/page-writeback.c:3027, CPU#1: kworker/u8:6/2949
>>> Modules linked in:
>>> CPU: 1 UID: 0 PID: 2949 Comm: kworker/u8:6 Not tainted syzkaller #0 PREEMPT(full)
>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
>>> Workqueue: writeback wb_workfn (flush-8:0)
>>> RIP: 0010:inode_to_wb include/linux/backing-dev.h:239 [inline]
>>> RIP: 0010:__folio_start_writeback+0x9d5/0xb70 mm/page-writeback.c:3027
>>> Code: 28 4c 89 f8 48 c1 e8 03 42 80 3c 28 00 74 08 4c 89 ff e8 ce a2 29 00 49 8b 07 25 ff 3f 00 00 e9 1b fa ff ff e8 7c 04 c6 ff 90 <0f> 0b 90 e9 d6 fb ff ff e8 6e 04 c6 ff 48 c7 c7 a0 f8 5f 8e 4c 89
>>> RSP: 0018:ffffc9000bb06ea0 EFLAGS: 00010293
>>> RAX: ffffffff81fad344 RBX: ffffea00050de8c0 RCX: ffff88802ee29e00
>>> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
>>> RBP: ffffc9000bb07010 R08: ffffc9000bb06f97 R09: 0000000000000000
>>> R10: ffffc9000bb06f80 R11: fffff52001760df3 R12: ffffea00050de8c8
>>> R13: 0000000000000000 R14: ffff888023060880 R15: ffff888023060660
>>> FS:  0000000000000000(0000) GS:ffff8881258c3000(0000) knlGS:0000000000000000
>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> CR2: 00007f7354907000 CR3: 000000000e338000 CR4: 00000000003526f0
>>> Call Trace:
>>>   <TASK>
>>>   __block_write_full_folio+0x75f/0xe10 fs/buffer.c:1928
>>>   blkdev_writepages+0xd1/0x170 block/fops.c:484
>>>   do_writepages+0x32e/0x550 mm/page-writeback.c:2604
>>>   __writeback_single_inode+0x145/0xff0 fs/fs-writeback.c:1680
>>>   writeback_sb_inodes+0x6c7/0x1010 fs/fs-writeback.c:1976
>>>   __writeback_inodes_wb+0x111/0x240 fs/fs-writeback.c:2047
>>>   wb_writeback+0x44f/0xaf0 fs/fs-writeback.c:2158
>>>   wb_check_old_data_flush fs/fs-writeback.c:2262 [inline]
>>>   wb_do_writeback fs/fs-writeback.c:2315 [inline]
>>>   wb_workfn+0xaef/0xef0 fs/fs-writeback.c:2343
>>>   process_one_work kernel/workqueue.c:3236 [inline]
>>>   process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
>>>   worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
>>>   kthread+0x711/0x8a0 kernel/kthread.c:463
>>>   ret_from_fork+0x47c/0x820 arch/x86/kernel/process.c:148
>>>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>>>   </TASK>
>>>
>>>
>>> ---
>>> This report is generated by a bot. It may contain errors.
>>> See https://protect2.fireeye.com/v1/url?k=d9d7c080-b8ac6a08-d9d64bcf-74fe4860018a-5a4a20c239e4ea82&q=1&e=3aa7e54d-e6d6-43e9-ade0-0a94ae0545e0&u=https%3A%2F%2Fgoo.gl%2FtpsmEJ for more information about syzbot.
>>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>>
>>> syzbot will keep track of this issue. See:
>>> https://protect2.fireeye.com/v1/url?k=03a49fa8-62df3520-03a514e7-74fe4860018a-9a57f917485c2c59&q=1&e=3aa7e54d-e6d6-43e9-ade0-0a94ae0545e0&u=https%3A%2F%2Fgoo.gl%2FtpsmEJ%23status for how to communicate with syzbot.
>>>
>>> If the report is already addressed, let syzbot know by replying with:
>>> #syz fix: exact-commit-title
>>>
>>> If you want to overwrite report's subsystems, reply with:
>>> #syz set subsystems: new-subsystem
>>> (See the list of subsystem names on the web dashboard)
>>>
>>> If the report is a duplicate of another one, reply with:
>>> #syz dup: exact-subject-of-another-report
>>>
>>> If you want to undo deduplication, reply with:
>>> #syz undup
>>>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


