Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13CB2001FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 08:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgFSGh7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 02:37:59 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6287 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727808AbgFSGh6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 02:37:58 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DBE6EBE6350EF092C04C;
        Fri, 19 Jun 2020 14:37:54 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 19 Jun
 2020 14:37:52 +0800
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
 <c6f9d02d-623f-8b36-1f18-91c69bdd17c8@huawei.com>
 <20200619042048.GF2957@sol.localdomain>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <f1013767-9099-5b38-e3cd-b8caa639f66c@huawei.com>
Date:   Fri, 19 Jun 2020 14:37:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200619042048.GF2957@sol.localdomain>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/6/19 12:20, Eric Biggers wrote:
> On Fri, Jun 19, 2020 at 10:39:34AM +0800, Chao Yu wrote:
>> Hi Eric,
>>
>> On 2020/6/19 2:13, Eric Biggers wrote:
>>> Hi Chao,
>>>
>>> On Thu, Jun 18, 2020 at 06:06:02PM +0800, Chao Yu wrote:
>>>>> @@ -936,8 +972,11 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
>>>>>  
>>>>>  	inc_page_count(sbi, WB_DATA_TYPE(bio_page));
>>>>>  
>>>>> -	if (io->bio && !io_is_mergeable(sbi, io->bio, io, fio,
>>>>> -			io->last_block_in_bio, fio->new_blkaddr))
>>>>> +	if (io->bio &&
>>>>> +	    (!io_is_mergeable(sbi, io->bio, io, fio, io->last_block_in_bio,
>>>>> +			      fio->new_blkaddr) ||
>>>>> +	     !f2fs_crypt_mergeable_bio(io->bio, fio->page->mapping->host,
>>>>> +				       fio->page->index, fio)))
>>>>
>>>> bio_page->index, fio)))
>>>>
>>>>>  		__submit_merged_bio(io);
>>>>>  alloc_new:
>>>>>  	if (io->bio == NULL) {
>>>>> @@ -949,6 +988,8 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
>>>>>  			goto skip;
>>>>>  		}
>>>>>  		io->bio = __bio_alloc(fio, BIO_MAX_PAGES);
>>>>> +		f2fs_set_bio_crypt_ctx(io->bio, fio->page->mapping->host,
>>>>> +				       fio->page->index, fio, GFP_NOIO);
>>>>
>>>> bio_page->index, fio, GFP_NOIO);
>>>>
>>>
>>> We're using ->mapping->host and ->index.  Ordinarily that would mean the page
>>> needs to be a pagecache page.  But bio_page can also be a compressed page or a
>>> bounce page containing fs-layer encrypted contents.
>>
>> I'm concerning about compression + inlinecrypt case.
>>
>>>
>>> Is your suggestion to keep using fio->page->mapping->host (since encrypted pages
>>
>> Yup,
>>
>>> don't have a mapping), but start using bio_page->index (since f2fs apparently
>>
>> I meant that we need to use bio_page->index as tweak value in write path to
>> keep consistent as we did in read path, otherwise we may read the wrong
>> decrypted data later to incorrect tweak value.
>>
>> - f2fs_read_multi_pages (only comes from compression inode)
>>  - f2fs_alloc_dic
>>   - f2fs_set_compressed_page(page, cc->inode,
>> 					start_idx + i + 1, dic);
>>                                         ^^^^^^^^^^^^^^^^^
>>   - dic->cpages[i] = page;
>>  - for ()
>>      struct page *page = dic->cpages[i];
>>      if (!bio)
>>        - f2fs_grab_read_bio(..., page->index,..)
>>         - f2fs_set_bio_crypt_ctx(..., first_idx, ..)   /* first_idx == cpage->index */
>>
>> You can see that cpage->index was set to page->index + 1, that's why we need
>> to use one of cpage->index/page->index as tweak value all the time rather than
>> using both index mixed in read/write path.
>>
>> But note that for fs-layer encryption, we have used cpage->index as tweak value,
>> so here I suggest we can keep consistent to use cpage->index in inlinecrypt case.
> 
> Yes, inlinecrypt mustn't change the ciphertext that gets written to disk.
> 
>>
>>> *does* set ->index for compressed pages, and if the file uses fs-layer
>>> encryption then f2fs_set_bio_crypt_ctx() won't use the index anyway)?
>>>
>>> Does this mean the code is currently broken for compression + inline encryption
>>> because it's using the wrong ->index?  I think the answer is no, since
>>
>> I guess it's broken now for compression + inlinecrypt case.
>>
>>> f2fs_write_compressed_pages() will still pass the first 'nr_cpages' pagecache
>>> pages along with the compressed pages.  In that case, your suggestion would be a
>>> cleanup rather than a fix?
>>
>> That's a fix.
>>
> 
> FWIW, I tested this, and it actually works both before and after your suggested
> change.  The reason is that f2fs_write_compressed_pages() actually passes the
> pagecache pages sequentially starting at 'start_idx_of_cluster(cc) + 1' for the
> length of the compressed cluster.  That matches the '+ 1' adjustment elsewhere,
> so we have fio->page->index == bio_page->index.

I've checked the code, yes, that's correct.

> 
> I personally think the way the f2fs compression code works is really confusing.
> Compressed pages don't have a 1:1 correspondence to pagecache pages, so there
> should *not* be a pagecache page passed around when writing a compressed page.

The only place we always use fio->page is:
- f2fs_submit_page_write
 - trace_f2fs_submit_page_write(fio->page,..)
  - f2fs__submit_page_bio
   __entry->dev		= page_file_mapping(page)->host->i_sb->s_dev;
   __entry->ino		= page_file_mapping(page)->host->i_ino;

For compression case, we can get rid of using this parameter because bio_page
(fio->compressed_page) has correct mapping info, however for fs-layer encryption
case, bio_page (fio->encrypted_page, allocated by fscrypt_alloc_bounce_page())
has not correct mapping info.

> 
> Anyway, here's the test script I used in case anyone else wants to use it.  But
> we really need to write a proper f2fs compression + encryption test for xfstests
> which decrypts and decompresses a file in userspace and verifies we get back the
> original data.  (There are already ciphertext verification tests, but they don't
> cover compression.)  Note that this test is needed even for the filesystem-layer
> encryption which is currently supported.

Yes, let me check how to make this testcase a bit later.

> 
> #!/bin/bash
> 
> set -e
> 
> DEV=/dev/vdb
> 
> umount /mnt &> /dev/null || true
> mkfs.f2fs -f -O encrypt,compression,extra_attr $DEV
> head -c 1000000 /dev/zero > /tmp/testdata
> 
> for opt1 in '-o inlinecrypt' ''; do
>         mount $DEV /mnt $opt1
>         rm -rf /mnt/.fscrypt /mnt/dir
>         fscrypt setup /mnt
>         mkdir /mnt/dir
>         chattr +c /mnt/dir
>         echo hunter2 | fscrypt encrypt /mnt/dir --quiet --source=custom_passphrase --name=secret
>         cp /tmp/testdata /mnt/dir/file
>         umount /mnt
>         for opt2 in '-o inlinecrypt' ''; do
>                 mount $DEV /mnt $opt2
>                 echo hunter2 | fscrypt unlock /mnt/dir --quiet
>                 cmp /mnt/dir/file /tmp/testdata
>                 umount /mnt
>         done
> done
> .
> 
