Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF93C200052
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 04:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgFSCjn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 22:39:43 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35730 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726906AbgFSCjn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 22:39:43 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 615274DC5B259B57828C;
        Fri, 19 Jun 2020 10:39:40 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 19 Jun
 2020 10:39:35 +0800
Subject: Re: [PATCH 3/4] f2fs: add inline encryption support
To:     Eric Biggers <ebiggers@kernel.org>
CC:     Satya Tangirala <satyat@google.com>,
        <linux-fscrypt@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-ext4@vger.kernel.org>
References: <20200617075732.213198-1-satyat@google.com>
 <20200617075732.213198-4-satyat@google.com>
 <5e78e1be-f948-d54c-d28e-50f1f0a92ab3@huawei.com>
 <20200618181357.GC2957@sol.localdomain>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <c6f9d02d-623f-8b36-1f18-91c69bdd17c8@huawei.com>
Date:   Fri, 19 Jun 2020 10:39:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200618181357.GC2957@sol.localdomain>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Eric,

On 2020/6/19 2:13, Eric Biggers wrote:
> Hi Chao,
> 
> On Thu, Jun 18, 2020 at 06:06:02PM +0800, Chao Yu wrote:
>>> @@ -936,8 +972,11 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
>>>  
>>>  	inc_page_count(sbi, WB_DATA_TYPE(bio_page));
>>>  
>>> -	if (io->bio && !io_is_mergeable(sbi, io->bio, io, fio,
>>> -			io->last_block_in_bio, fio->new_blkaddr))
>>> +	if (io->bio &&
>>> +	    (!io_is_mergeable(sbi, io->bio, io, fio, io->last_block_in_bio,
>>> +			      fio->new_blkaddr) ||
>>> +	     !f2fs_crypt_mergeable_bio(io->bio, fio->page->mapping->host,
>>> +				       fio->page->index, fio)))
>>
>> bio_page->index, fio)))
>>
>>>  		__submit_merged_bio(io);
>>>  alloc_new:
>>>  	if (io->bio == NULL) {
>>> @@ -949,6 +988,8 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
>>>  			goto skip;
>>>  		}
>>>  		io->bio = __bio_alloc(fio, BIO_MAX_PAGES);
>>> +		f2fs_set_bio_crypt_ctx(io->bio, fio->page->mapping->host,
>>> +				       fio->page->index, fio, GFP_NOIO);
>>
>> bio_page->index, fio, GFP_NOIO);
>>
> 
> We're using ->mapping->host and ->index.  Ordinarily that would mean the page
> needs to be a pagecache page.  But bio_page can also be a compressed page or a
> bounce page containing fs-layer encrypted contents.

I'm concerning about compression + inlinecrypt case.

> 
> Is your suggestion to keep using fio->page->mapping->host (since encrypted pages

Yup,

> don't have a mapping), but start using bio_page->index (since f2fs apparently

I meant that we need to use bio_page->index as tweak value in write path to
keep consistent as we did in read path, otherwise we may read the wrong
decrypted data later to incorrect tweak value.

- f2fs_read_multi_pages (only comes from compression inode)
 - f2fs_alloc_dic
  - f2fs_set_compressed_page(page, cc->inode,
					start_idx + i + 1, dic);
                                        ^^^^^^^^^^^^^^^^^
  - dic->cpages[i] = page;
 - for ()
     struct page *page = dic->cpages[i];
     if (!bio)
       - f2fs_grab_read_bio(..., page->index,..)
        - f2fs_set_bio_crypt_ctx(..., first_idx, ..)   /* first_idx == cpage->index */

You can see that cpage->index was set to page->index + 1, that's why we need
to use one of cpage->index/page->index as tweak value all the time rather than
using both index mixed in read/write path.

But note that for fs-layer encryption, we have used cpage->index as tweak value,
so here I suggest we can keep consistent to use cpage->index in inlinecrypt case.

> *does* set ->index for compressed pages, and if the file uses fs-layer
> encryption then f2fs_set_bio_crypt_ctx() won't use the index anyway)?
> 
> Does this mean the code is currently broken for compression + inline encryption
> because it's using the wrong ->index?  I think the answer is no, since

I guess it's broken now for compression + inlinecrypt case.

> f2fs_write_compressed_pages() will still pass the first 'nr_cpages' pagecache
> pages along with the compressed pages.  In that case, your suggestion would be a
> cleanup rather than a fix?

That's a fix.

> 
> It would be helpful if there was an f2fs mount option to auto-enable compression
> on all files (similar to how test_dummy_encryption auto-enables encryption on
> all files) so that it could be tested more easily.

Agreed.

Previously I changed mkfs to allow to add compression flag to root inode for
compression test. :P

Thanks,

> 
> - Eric
> .
> 
