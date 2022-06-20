Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424AD550E71
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 03:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237603AbiFTB4L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jun 2022 21:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236741AbiFTB4K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jun 2022 21:56:10 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E14B496;
        Sun, 19 Jun 2022 18:56:09 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LRCP76DlWz1KC2l;
        Mon, 20 Jun 2022 09:54:03 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 20 Jun 2022 09:56:07 +0800
Subject: Re: [PATCH] filemap: obey mapping->invalidate_lock lock/unlock order
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220618083820.35626-1-linmiaohe@huawei.com>
 <Yq2qQcHUZ2UjPk/M@casper.infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <364c8981-95c4-4bf8-cfbf-688c621db5b5@huawei.com>
Date:   Mon, 20 Jun 2022 09:56:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <Yq2qQcHUZ2UjPk/M@casper.infradead.org>
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

On 2022/6/18 18:34, Matthew Wilcox wrote:
> On Sat, Jun 18, 2022 at 04:38:20PM +0800, Miaohe Lin wrote:
>> The invalidate_locks of two mappings should be unlocked in reverse order
>> relative to the locking order in filemap_invalidate_lock_two(). Modifying
> 
> Why?  It's perfectly valid to lock(A) lock(B) unlock(A) unlock(B).
> If it weren't we'd have lockdep check it and complain.

For spin_lock, they are lock(A) lock(B) unlock(B) unlock(A) e.g. in copy_huge_pud,
copy_huge_pmd, move_huge_pmd and so on:
	dst_ptl = pmd_lock(dst_mm, dst_pmd);
	src_ptl = pmd_lockptr(src_mm, src_pmd);
	spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
	...
	spin_unlock(src_ptl);
	spin_unlock(dst_ptl);

For rw_semaphore, they are also lock(A) lock(B) unlock(B) unlock(A) e.g. in dup_mmap():
	mmap_write_lock_killable(oldmm)
	mmap_write_lock_nested(mm, SINGLE_DEPTH_NESTING);
	...
	mmap_write_unlock(mm);
	mmap_write_unlock(oldmm);

and ntfs_extend_mft():
	down_write(&ni->file.run_lock);
	down_write_nested(&sbi->used.bitmap.rw_lock, BITMAP_MUTEX_CLUSTERS);
	...
	up_write(&sbi->used.bitmap.rw_lock);
	up_write(&ni->file.run_lock);

But I see some lock(A) lock(B) unlock(A) unlock(B) examples in some fs codes. Could you
please tell me the right lock/unlock order? I'm somewhat confused now...

BTW: If lock(A) lock(B) unlock(A) unlock(B) is requested, filemap_invalidate_lock_two might
still need to be changed to respect that order?

Thanks!

> 
> .
> 

