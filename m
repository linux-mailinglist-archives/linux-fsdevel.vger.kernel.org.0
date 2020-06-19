Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1682820005D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 04:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbgFSCnY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 22:43:24 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33608 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727929AbgFSCnX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 22:43:23 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5629A3848E085825E87F;
        Fri, 19 Jun 2020 10:43:21 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 19 Jun
 2020 10:43:16 +0800
Subject: Re: [PATCH 3/4] f2fs: add inline encryption support
To:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
CC:     Satya Tangirala <satyat@google.com>,
        <linux-fscrypt@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-ext4@vger.kernel.org>
References: <20200617075732.213198-1-satyat@google.com>
 <20200617075732.213198-4-satyat@google.com>
 <5e78e1be-f948-d54c-d28e-50f1f0a92ab3@huawei.com>
 <20200618181357.GC2957@sol.localdomain> <20200618192804.GA139436@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <f49534bf-f119-2fa5-81a3-5e169d6c5f61@huawei.com>
Date:   Fri, 19 Jun 2020 10:43:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200618192804.GA139436@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/6/19 3:28, Jaegeuk Kim wrote:
> On 06/18, Eric Biggers wrote:
>> Hi Chao,
>>
>> On Thu, Jun 18, 2020 at 06:06:02PM +0800, Chao Yu wrote:
>>>> @@ -936,8 +972,11 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
>>>>  
>>>>  	inc_page_count(sbi, WB_DATA_TYPE(bio_page));
>>>>  
>>>> -	if (io->bio && !io_is_mergeable(sbi, io->bio, io, fio,
>>>> -			io->last_block_in_bio, fio->new_blkaddr))
>>>> +	if (io->bio &&
>>>> +	    (!io_is_mergeable(sbi, io->bio, io, fio, io->last_block_in_bio,
>>>> +			      fio->new_blkaddr) ||
>>>> +	     !f2fs_crypt_mergeable_bio(io->bio, fio->page->mapping->host,
>>>> +				       fio->page->index, fio)))
>>>
>>> bio_page->index, fio)))
>>>
>>>>  		__submit_merged_bio(io);
>>>>  alloc_new:
>>>>  	if (io->bio == NULL) {
>>>> @@ -949,6 +988,8 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
>>>>  			goto skip;
>>>>  		}
>>>>  		io->bio = __bio_alloc(fio, BIO_MAX_PAGES);
>>>> +		f2fs_set_bio_crypt_ctx(io->bio, fio->page->mapping->host,
>>>> +				       fio->page->index, fio, GFP_NOIO);
>>>
>>> bio_page->index, fio, GFP_NOIO);
>>>
>>
>> We're using ->mapping->host and ->index.  Ordinarily that would mean the page
>> needs to be a pagecache page.  But bio_page can also be a compressed page or a
>> bounce page containing fs-layer encrypted contents.
>>
>> Is your suggestion to keep using fio->page->mapping->host (since encrypted pages
>> don't have a mapping), but start using bio_page->index (since f2fs apparently
>> *does* set ->index for compressed pages, and if the file uses fs-layer
>> encryption then f2fs_set_bio_crypt_ctx() won't use the index anyway)?
>>
>> Does this mean the code is currently broken for compression + inline encryption
>> because it's using the wrong ->index?  I think the answer is no, since
>> f2fs_write_compressed_pages() will still pass the first 'nr_cpages' pagecache
>> pages along with the compressed pages.  In that case, your suggestion would be a
>> cleanup rather than a fix?
>>
>> It would be helpful if there was an f2fs mount option to auto-enable compression
>> on all files (similar to how test_dummy_encryption auto-enables encryption on
>> all files) so that it could be tested more easily.
> 
> Eric, you can use "-o compress_extension=*".

Cool, we should update documentation when merge that patch...

> 
>>
>> - Eric
> .
> 
