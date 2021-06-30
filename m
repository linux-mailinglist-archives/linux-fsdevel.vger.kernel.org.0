Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553563B7BAA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 04:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbhF3Cil (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 22:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbhF3Cik (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 22:38:40 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295F4C061760;
        Tue, 29 Jun 2021 19:36:12 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id i6so1069763pfq.1;
        Tue, 29 Jun 2021 19:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Vwd7IsRrp/T/LYxrS9jpNnIbBfNUxIhyCA5fuEJb/hs=;
        b=p7cd/RjTnmf/k/gz3pbr2Qx3kJvJWlO2L/epw3XeLW46rn3mrhP3adzzQ7cXIxAN1E
         knhHinhhB2yfgIz9QxDdgueiI8Ry1hL6uEZ8fJRN8AWplQ4wrIgWdBbo8DM+WAnKf7f6
         x+SOLsKzsEtX8nrAhH21dsqaw49vwi+Uu1GbwAM6xUULVw3JleGovm0sgbJA1yCs4w73
         UUuylwrGgFnMoYOxqs5QRVaOLiBs1MgwMSB1NeK65bqyjlXTZYN3OaWxg4s9LjQoQx5N
         wnrxUA0sxGRfme4ui0IxrRMY+8Jc0F56sC2zELbR0zXS6IPIWDDbyLS9Q6VZwbdlV6Em
         Ij1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vwd7IsRrp/T/LYxrS9jpNnIbBfNUxIhyCA5fuEJb/hs=;
        b=C1mmy5Yj7O5Xs3A8loEFuZNZApVUwJg5KLbsZbHHl7HNBl6tJe3xKqAPCfri90tfDt
         4j3ZM7aCVjgbUNmyJVtlsiJrq9soQ+bo0B0+RrxKSnwdtd7jPn/WHPD+krUGwrn9+67p
         8dCLuLFXnqw/k6sExbeMPRLkiTP9blu+SkknBJ8BwldWL0Vj0vooiMDS0lHwIrWbFSQY
         2Y2mq9baWjxEsvIkcjxwBb/Q/UHdbGGA1cZ1tALWINfjZTWtZlDu1mU/3QTrEdEdMjYY
         5ByJjSWvkBBG6fZjz5zR39NsSayNIKLXhgq8tFF4u8xjPNwl63bY6UvOkHR9IEzkrEHx
         zx5A==
X-Gm-Message-State: AOAM531TSMPHZmom4Dwru9a2RJHuZrOxYnxpnK+jRP8CTlVLzVv0tQx5
        8hPw5BDAqb3hc733j8wivus=
X-Google-Smtp-Source: ABdhPJxDIwxkkCOVfJmmddgVrHXe+xzsKT3YGKNLw3ncuIrm2fIrReITTBgsr7q1rePb71VtoChSGg==
X-Received: by 2002:a63:eb4f:: with SMTP id b15mr32026193pgk.2.1625020571681;
        Tue, 29 Jun 2021 19:36:11 -0700 (PDT)
Received: from [192.168.1.237] ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id z27sm19890437pfg.91.2021.06.29.19.36.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 19:36:11 -0700 (PDT)
Subject: Re: [PATCH 2/3] hfs: fix high memory mapping in hfs_bnode_read
To:     Viacheslav Dubeyko <slava@dubeyko.com>
Cc:     gustavoars@kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20210629144803.62541-1-desmondcheongzx@gmail.com>
 <20210629144803.62541-3-desmondcheongzx@gmail.com>
 <4E2B2BE9-3C0F-4D99-A099-601A780E0CED@dubeyko.com>
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Message-ID: <bd0e5597-7fa6-dd80-9f3d-f48c3806d5fb@gmail.com>
Date:   Wed, 30 Jun 2021 10:36:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <4E2B2BE9-3C0F-4D99-A099-601A780E0CED@dubeyko.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 30/6/21 3:31 am, Viacheslav Dubeyko wrote:
> 
> 
>> On Jun 29, 2021, at 7:48 AM, Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com> wrote:
>>
>> Pages that we read in hfs_bnode_read need to be kmapped into kernel
>> address space. However, currently only the 0th page is kmapped. If the
>> given offset + length exceeds this 0th page, then we have an invalid
>> memory access.
>>
>> To fix this, we use the same logic used  in hfsplus' version of
>> hfs_bnode_read to kmap each page of relevant data that we copy.
>>
>> An example of invalid memory access occurring without this fix can be
>> seen in the following crash report:
>>
>> ==================================================================
>> BUG: KASAN: use-after-free in memcpy include/linux/fortify-string.h:191 [inline]
>> BUG: KASAN: use-after-free in hfs_bnode_read+0xc4/0xe0 fs/hfs/bnode.c:26
>> Read of size 2 at addr ffff888125fdcffe by task syz-executor5/4634
>>
>> CPU: 0 PID: 4634 Comm: syz-executor5 Not tainted 5.13.0-syzkaller #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>> Call Trace:
>> __dump_stack lib/dump_stack.c:79 [inline]
>> dump_stack+0x195/0x1f8 lib/dump_stack.c:120
>> print_address_description.constprop.0+0x1d/0x110 mm/kasan/report.c:233
>> __kasan_report mm/kasan/report.c:419 [inline]
>> kasan_report.cold+0x7b/0xd4 mm/kasan/report.c:436
>> check_region_inline mm/kasan/generic.c:180 [inline]
>> kasan_check_range+0x154/0x1b0 mm/kasan/generic.c:186
>> memcpy+0x24/0x60 mm/kasan/shadow.c:65
>> memcpy include/linux/fortify-string.h:191 [inline]
>> hfs_bnode_read+0xc4/0xe0 fs/hfs/bnode.c:26
>> hfs_bnode_read_u16 fs/hfs/bnode.c:34 [inline]
>> hfs_bnode_find+0x880/0xcc0 fs/hfs/bnode.c:365
>> hfs_brec_find+0x2d8/0x540 fs/hfs/bfind.c:126
>> hfs_brec_read+0x27/0x120 fs/hfs/bfind.c:165
>> hfs_cat_find_brec+0x19a/0x3b0 fs/hfs/catalog.c:194
>> hfs_fill_super+0xc13/0x1460 fs/hfs/super.c:419
>> mount_bdev+0x331/0x3f0 fs/super.c:1368
>> hfs_mount+0x35/0x40 fs/hfs/super.c:457
>> legacy_get_tree+0x10c/0x220 fs/fs_context.c:592
>> vfs_get_tree+0x93/0x300 fs/super.c:1498
>> do_new_mount fs/namespace.c:2905 [inline]
>> path_mount+0x13f5/0x20e0 fs/namespace.c:3235
>> do_mount fs/namespace.c:3248 [inline]
>> __do_sys_mount fs/namespace.c:3456 [inline]
>> __se_sys_mount fs/namespace.c:3433 [inline]
>> __x64_sys_mount+0x2b8/0x340 fs/namespace.c:3433
>> do_syscall_64+0x37/0xc0 arch/x86/entry/common.c:47
>> entry_SYSCALL_64_after_hwframe+0x44/0xae
>> RIP: 0033:0x45e63a
>> Code: 48 c7 c2 bc ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 88 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
>> RSP: 002b:00007f9404d410d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
>> RAX: ffffffffffffffda RBX: 0000000020000248 RCX: 000000000045e63a
>> RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f9404d41120
>> RBP: 00007f9404d41120 R08: 00000000200002c0 R09: 0000000020000000
>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
>> R13: 0000000000000003 R14: 00000000004ad5d8 R15: 0000000000000000
>>
>> The buggy address belongs to the page:
>> page:00000000dadbcf3e refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x125fdc
>> flags: 0x2fffc0000000000(node=0|zone=2|lastcpupid=0x3fff)
>> raw: 02fffc0000000000 ffffea000497f748 ffffea000497f6c8 0000000000000000
>> raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
>> page dumped because: kasan: bad access detected
>>
>> Memory state around the buggy address:
>> ffff888125fdce80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> ffff888125fdcf00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>>> ffff888125fdcf80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>>                                                                 ^
>> ffff888125fdd000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> ffff888125fdd080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> ==================================================================
>>
>> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
>> ---
>> fs/hfs/bnode.c | 18 ++++++++++++++----
>> 1 file changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
>> index b63a4df7327b..936cfa763224 100644
>> --- a/fs/hfs/bnode.c
>> +++ b/fs/hfs/bnode.c
>> @@ -18,13 +18,23 @@
>> void hfs_bnode_read(struct hfs_bnode *node, void *buf,
>> 		int off, int len)
>> {
>> -	struct page *page;
>> +	struct page **pagep;
>> +	int l;
>>
>> 	off += node->page_offset;
>> -	page = node->page[0];
>> +	pagep = node->page + (off >> PAGE_SHIFT);
> 
> I would like to have a check here that we are not out of the page array. Could you add this check?
> 
> Also, maybe, node->page[index] could look much safer here. What do you think?
> 

Hi Slava,

Thanks for the review.

Checking that we don't exceed the page array sounds good. Also agree 
that node->page[index] looks more readable.

>> +	off &= ~PAGE_MASK;
>>
>> -	memcpy(buf, kmap(page) + off, len);
>> -	kunmap(page);
>> +	l = min_t(int, len, PAGE_SIZE - off);
> 
> Maybe, it makes sense to use more informative name of the variable instead of “l”?
> 
>> +	memcpy(buf, kmap(*pagep) + off, l);
> 
> I suppose that it could be good to have a check that we do not overflow the buffer. How do you feel about it?
> 

The computation of `l = min_t(int, len, PAGE_SIZE - off);` ensures that 
we don't overflow the buffer because the number of bytes read won't 
exceed the given len. But I think you're right that this can be made 
more explicit, alongside giving "l" a more informative name.

>> +	kunmap(*pagep);
> 
> What’s about kmap_atomic/kunmap_atomic in this function?
> 
> Thanks,
> Slava.
> 

kmap_atomic/kunmap_atomic sounds good to me. I'll followup with a v2 
series. Thanks again!

Best wishes,
Desmond

>> +
>> +	while ((len -= l) != 0) {
>> +		buf += l;
>> +		l = min_t(int, len, PAGE_SIZE);
>> +		memcpy(buf, kmap(*++pagep), l);
>> +		kunmap(*pagep);
>> +	}
>> }
>>
>> u16 hfs_bnode_read_u16(struct hfs_bnode *node, int off)
>> -- 
>> 2.25.1
>>
> 

