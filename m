Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E3E551067
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 08:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238365AbiFTGfj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 02:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiFTGfi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 02:35:38 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6882F64DA;
        Sun, 19 Jun 2022 23:35:33 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LRKc13zVtzkWP5;
        Mon, 20 Jun 2022 14:33:53 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 20 Jun 2022 14:35:31 +0800
Subject: Re: [PATCH] filemap: obey mapping->invalidate_lock lock/unlock order
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220618083820.35626-1-linmiaohe@huawei.com>
 <Yq2qQcHUZ2UjPk/M@casper.infradead.org>
 <364c8981-95c4-4bf8-cfbf-688c621db5b5@huawei.com>
 <Yq/76OJgZ2GgRReN@casper.infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <72315fc0-eee9-13c8-2d94-43c8c7045a91@huawei.com>
Date:   Mon, 20 Jun 2022 14:35:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <Yq/76OJgZ2GgRReN@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/6/20 12:47, Matthew Wilcox wrote:
> On Mon, Jun 20, 2022 at 09:56:06AM +0800, Miaohe Lin wrote:
>> On 2022/6/18 18:34, Matthew Wilcox wrote:
>>> On Sat, Jun 18, 2022 at 04:38:20PM +0800, Miaohe Lin wrote:
>>>> The invalidate_locks of two mappings should be unlocked in reverse order
>>>> relative to the locking order in filemap_invalidate_lock_two(). Modifying
>>>
>>> Why?  It's perfectly valid to lock(A) lock(B) unlock(A) unlock(B).
>>> If it weren't we'd have lockdep check it and complain.

It seems I misunderstand your word. I thought you said it must be at lock(A) lock(B) unlock(A) unlock(B)
order... Sorry.

>>
>> For spin_lock, they are lock(A) lock(B) unlock(B) unlock(A) e.g. in copy_huge_pud,
> 
> I think you need to spend some time thinking about the semantics of
> locks and try to figure out why it would make any difference at all
> which order locks (of any type) are _unlocked_ in,

IIUC, the lock orders are important to prevent possible deadlock. But unlock orders should be relaxed
because they won't result in problem indeed. And what I advocate here is that making it at lock(A) lock(B)
unlock(B) unlock(A) order should be a better program practice. Or unlock order shouldn't be obligatory
at practice?

Thanks.

> 
>> copy_huge_pmd, move_huge_pmd and so on:
>> 	dst_ptl = pmd_lock(dst_mm, dst_pmd);
>> 	src_ptl = pmd_lockptr(src_mm, src_pmd);
>> 	spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
>> 	...
>> 	spin_unlock(src_ptl);
>> 	spin_unlock(dst_ptl);
>>
>> For rw_semaphore, they are also lock(A) lock(B) unlock(B) unlock(A) e.g. in dup_mmap():
>> 	mmap_write_lock_killable(oldmm)
>> 	mmap_write_lock_nested(mm, SINGLE_DEPTH_NESTING);
>> 	...
>> 	mmap_write_unlock(mm);
>> 	mmap_write_unlock(oldmm);
>>
>> and ntfs_extend_mft():
>> 	down_write(&ni->file.run_lock);
>> 	down_write_nested(&sbi->used.bitmap.rw_lock, BITMAP_MUTEX_CLUSTERS);
>> 	...
>> 	up_write(&sbi->used.bitmap.rw_lock);
>> 	up_write(&ni->file.run_lock);
>>
>> But I see some lock(A) lock(B) unlock(A) unlock(B) examples in some fs codes. Could you
>> please tell me the right lock/unlock order? I'm somewhat confused now...
>>
>> BTW: If lock(A) lock(B) unlock(A) unlock(B) is requested, filemap_invalidate_lock_two might
>> still need to be changed to respect that order?
>>
>> Thanks!
>>
>>>
>>> .
>>>
>>
> 
> .
> 

