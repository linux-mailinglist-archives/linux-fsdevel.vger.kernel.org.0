Return-Path: <linux-fsdevel+bounces-16306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DF489ADFC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 04:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29730B229B4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 02:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D13217C9;
	Sun,  7 Apr 2024 02:05:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D678B8494;
	Sun,  7 Apr 2024 02:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712455522; cv=none; b=sUH696LyMaykKqrLmmcRx1lcpmXvClv5RAebhkzsBCWymkONkyJCJEM5yWAHOf3z1HrCk+XVv5B2ELGndcOCgBo5fGVimP+SDJR3g82tQgXj+sBeJxVXYrgPZdqor5eas66OI5YMVALEjZ8WQOq3HgCBKx8qRh5jt2hWo6uEiEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712455522; c=relaxed/simple;
	bh=q7avWxTZ18Mq6nKKz2xrkTtQwuh0fsXGBm/jnjmYUEk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mMbbwQgu7LNH11TeDXASXsHzSzGQJf+JsKIHbLNFnwccNFuHobZS1ZRlikB09NLZYyDYz0NQFSccZwMyBkpOMLJVRa0cyVfWfcSXXBhL8LpBGEawdqe9A0jl2Q8+Efl1rFhwTI6iKR0JrsQNnurkEei49pnfkCZ4XBr7og8OaMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VBwXg5B76z4f3m73;
	Sun,  7 Apr 2024 10:05:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 3C56E1A0176;
	Sun,  7 Apr 2024 10:05:16 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP2 (Coremail) with SMTP id Syh0CgCXBQlY_xFmjWn_JQ--.19215S2;
	Sun, 07 Apr 2024 10:05:14 +0800 (CST)
Subject: Re: [syzbot] [nilfs?] KASAN: slab-out-of-bounds Read in wb_writeback
To: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>
Cc: gregkh@linuxfoundation.org, konishi.ryusuke@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org,
 viro@zeniv.linux.org.uk
References: <000000000000fd0f2a061506cc93@google.com>
 <00000000000003b8c406151e0fd1@google.com>
 <20240403094717.zex45tc2kpkfelny@quack3>
 <20240405-heilbad-eisbrecher-cd0cbc27f36f@brauner>
 <20240405132346.bid7gibby3lxxhez@quack3>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <089011b5-63a1-5251-022b-91cf1af95e17@huaweicloud.com>
Date: Sun, 7 Apr 2024 10:05:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240405132346.bid7gibby3lxxhez@quack3>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgCXBQlY_xFmjWn_JQ--.19215S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFy3tw4rWF17ZF4rXF1UWrg_yoW5tF1Upr
	Z8tFyIkrZ5tryFyF1kKw1qgr1jvrZ8CFW7Xay8tr1jvan2yrn8tryIyr1UWrWDCr1xAFyj
	vF45Z34fX3ykZ37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU1zuWJUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 4/5/2024 9:23 PM, Jan Kara wrote:
> On Fri 05-04-24 13:05:59, Christian Brauner wrote:
>> On Wed, Apr 03, 2024 at 11:47:17AM +0200, Jan Kara wrote:
>>> On Tue 02-04-24 07:38:25, syzbot wrote:
>>>> syzbot has found a reproducer for the following issue on:
>>>>
>>>> HEAD commit:    c0b832517f62 Add linux-next specific files for 20240402
>>>> git tree:       linux-next
>>>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=14af7dd9180000
>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=afcaf46d374cec8c
>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=7b219b86935220db6dd8
>>>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1729f003180000
>>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17fa4341180000
>>>>
>>>> Downloadable assets:
>>>> disk image: https://storage.googleapis.com/syzbot-assets/0d36ec76edc7/disk-c0b83251.raw.xz
>>>> vmlinux: https://storage.googleapis.com/syzbot-assets/6f9bb4e37dd0/vmlinux-c0b83251.xz
>>>> kernel image: https://storage.googleapis.com/syzbot-assets/2349287b14b7/bzImage-c0b83251.xz
>>>> mounted in repro: https://storage.googleapis.com/syzbot-assets/9760c52a227c/mount_0.gz
>>>>
>>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>>> Reported-by: syzbot+7b219b86935220db6dd8@syzkaller.appspotmail.com
>>>>
>>>> ==================================================================
>>>> BUG: KASAN: slab-out-of-bounds in __lock_acquire+0x78/0x1fd0 kernel/locking/lockdep.c:5005
>>>> Read of size 8 at addr ffff888020485fa8 by task kworker/u8:2/35
>>>
>>> Looks like the writeback cleanups are causing some use-after-free issues.
>>> The code KASAN is complaining about is:
>>>
>>> 		/*
>>> 		 * Nothing written. Wait for some inode to
>>> 		 * become available for writeback. Otherwise
>>> 		 * we'll just busyloop.
>>> 		 */
>>> 		trace_writeback_wait(wb, work);
>>> 		inode = wb_inode(wb->b_more_io.prev);
>>>>>>>> 		spin_lock(&inode->i_lock); <<<<<<
>>> 		spin_unlock(&wb->list_lock);
>>> 		/* This function drops i_lock... */
>>> 		inode_sleep_on_writeback(inode);
>>>
>>> in wb_writeback(). Now looking at the changes indeed the commit
>>> 167d6693deb ("fs/writeback: bail out if there is no more inodes for IO and
>>> queued once") is buggy because it will result in trying to fetch 'inode'
>>> from empty b_more_io list and thus we'll corrupt memory. I think instead of
>>> modifying the condition:
>>>
>>> 		if (list_empty(&wb->b_more_io)) {
>>>
>>> we should do:
>>>
>>> -		if (progress) {
>>> +		if (progress || !queued) {
>>>                         spin_unlock(&wb->list_lock);
>>>                         continue;
>>>                 }
>>>
>>> Kemeng?
>>
>> Fwiw, I observed this on xfstest too the last few days and tracked it
>> down to this series. Here's the splat I got in case it helps:
> 
> OK, since this is apparently causing more issues and Kemeng didn't reply
> yet, here's a fix in the form of the patch. It has passed some basic
> testing. Feel free to fold it into Kemeng's patch so that we don't keep
> linux-next broken longer than necessary. Thanks!
Sorry for the late reply as I was on vacation these days. Also sorry
for the bug introduced. The change looks good to me. Thanks a lot
for helping to fix this in time.

Kemeng
> 
> 								Honza
> 


