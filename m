Return-Path: <linux-fsdevel+bounces-34373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD059C4C9E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 03:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C08591F21E85
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 02:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF91D20493F;
	Tue, 12 Nov 2024 02:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qHyOK1wC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39507433BE
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 02:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731378712; cv=none; b=Gmxau7kX77iyb23eZT9RC0RRH3xoBUHTnDAmn01wmjbQVzphHEpPtF8MPO9duBQRLDo7ztm51gU7FERrKW9sXGcMxqUEvPZGSowvjzpn8tOnWVb/zQFerCfNAJhfDa2G/oemdfkSX5nlVI+SLWRtNDFw9wpXSTPpcOO7Fc+sS1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731378712; c=relaxed/simple;
	bh=/O47mt/detEydwJb6wECj65EpKVTBZ4aqWv7K7C5I+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WolqWCgDxg0ZFDZFHm8U+VaEIEO6tvSNDgnZ/vXJFOfEAxgdrJONMdl6s0jEcd/gFZOLVriKGwSOJ/N7f+YLEKTC3AxdNPWNCLflOyMUTEgp5IRVMD5Cs+PCXqjA68Cmruic/M2ZE7rPSyQbk1tNEGy5ZZbikcF3PG8swILnG0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qHyOK1wC; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731378706; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=5E/yqWznFqIBCSOfrFucrEVO6/G4cCny4JPSermzaNk=;
	b=qHyOK1wCjNwYSL/h7G9Pk464VDJtDTyowzB1YQNCSgykmxR2llDx4Y7LQYvG35WNDyHmTskKUObcO85vGegaBpbSfWJNos/TtZQ4ktOz7fZ23OdlDT4CRbuypWFP0LkMpfc15iDIc9dpJjVZJQFYDXYVVJvuFjSBpa8m5wkwV6M=
Received: from 30.221.148.118(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WJFJuD2_1731378705 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 Nov 2024 10:31:46 +0800
Message-ID: <0f585a7c-678b-492a-9492-358f21e57291@linux.alibaba.com>
Date: Tue, 12 Nov 2024 10:31:43 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, shakeel.butt@linux.dev,
 josef@toxicpanda.com, linux-mm@kvack.org, bernd.schubert@fastmail.fm,
 kernel-team@meta.com
References: <20241107235614.3637221-1-joannelkoong@gmail.com>
 <20241107235614.3637221-7-joannelkoong@gmail.com>
 <9c0dbdac-0aed-467c-86c7-5b9a9f96d89d@linux.alibaba.com>
 <CAJnrk1YUPZhCUhGqu+bBngzrG-yCCRLZc7fiOfXQZ0dxCHJV8Q@mail.gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAJnrk1YUPZhCUhGqu+bBngzrG-yCCRLZc7fiOfXQZ0dxCHJV8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/12/24 5:30 AM, Joanne Koong wrote:
> On Mon, Nov 11, 2024 at 12:32 AM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>
>> Hi, Joanne and Miklos,
>>
>> On 11/8/24 7:56 AM, Joanne Koong wrote:
>>> Currently, we allocate and copy data to a temporary folio when
>>> handling writeback in order to mitigate the following deadlock scenario
>>> that may arise if reclaim waits on writeback to complete:
>>> * single-threaded FUSE server is in the middle of handling a request
>>>   that needs a memory allocation
>>> * memory allocation triggers direct reclaim
>>> * direct reclaim waits on a folio under writeback
>>> * the FUSE server can't write back the folio since it's stuck in
>>>   direct reclaim
>>>
>>> To work around this, we allocate a temporary folio and copy over the
>>> original folio to the temporary folio so that writeback can be
>>> immediately cleared on the original folio. This additionally requires us
>>> to maintain an internal rb tree to keep track of writeback state on the
>>> temporary folios.
>>>
>>> A recent change prevents reclaim logic from waiting on writeback for
>>> folios whose mappings have the AS_WRITEBACK_MAY_BLOCK flag set in it.
>>> This commit sets AS_WRITEBACK_MAY_BLOCK on FUSE inode mappings (which
>>> will prevent FUSE folios from running into the reclaim deadlock described
>>> above) and removes the temporary folio + extra copying and the internal
>>> rb tree.
>>>
>>> fio benchmarks --
>>> (using averages observed from 10 runs, throwing away outliers)
>>>
>>> Setup:
>>> sudo mount -t tmpfs -o size=30G tmpfs ~/tmp_mount
>>>  ./libfuse/build/example/passthrough_ll -o writeback -o max_threads=4 -o source=~/tmp_mount ~/fuse_mount
>>>
>>> fio --name=writeback --ioengine=sync --rw=write --bs={1k,4k,1M} --size=2G
>>> --numjobs=2 --ramp_time=30 --group_reporting=1 --directory=/root/fuse_mount
>>>
>>>         bs =  1k          4k            1M
>>> Before  351 MiB/s     1818 MiB/s     1851 MiB/s
>>> After   341 MiB/s     2246 MiB/s     2685 MiB/s
>>> % diff        -3%          23%         45%
>>>
>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>
>>
>> IIUC this patch seems to break commit
>> 8b284dc47291daf72fe300e1138a2e7ed56f38ab ("fuse: writepages: handle same
>> page rewrites").
>>
> 
> Interesting!  My understanding was that we only needed that commit
> because we were clearing writeback on the original folio before
> writeback had actually finished.
> 
> Now that folio writeback state is accounted for normally (eg through
> writeback being set/cleared on the original folio), does the
> folio_wait_writeback() call we do in fuse_page_mkwrite() not mitigate
> this?

Yes, after inspecting the writeback logic more, it seems that the second
writeback won't be initiated if the first one has not completed yet, see

```
a_ops->writepages
  write_cache_pages
    writeback_iter
      writeback_get_folio
	folio_prepare_writeback
	  if folio_test_writeback(folio):
	    folio_wait_writeback(folio)
```

and thus it won't be an issue to remove the auxiliary list ;)

> 
>>> -     /*
>>> -      * Being under writeback is unlikely but possible.  For example direct
>>> -      * read to an mmaped fuse file will set the page dirty twice; once when
>>> -      * the pages are faulted with get_user_pages(), and then after the read
>>> -      * completed.
>>> -      */
>>
>> In short, the target scenario is like:
>>
>> ```
>> # open a fuse file and mmap
>> fd1 = open("fuse-file-path", ...)
>> uaddr = mmap(fd1, ...)
>>
>> # DIRECT read to the mmaped fuse file
>> fd2 = open("ext4-file-path", O_DIRECT, ...)
>> read(fd2, uaddr, ...)
>>     # get_user_pages() of uaddr, and triggers faultin
>>     # a_ops->dirty_folio() <--- mark PG_dirty
>>
>>     # when DIRECT IO completed:
>>     # a_ops->dirty_folio() <--- mark PG_dirty
> 
> If you have the direct io function call stack at hand, could you point
> me to the function where the direct io completion marks this folio as
> dirty?


FYI The full call stack is like:

```
# DIRECT read(2) to the mmaped fuse file
read(fd2, uaddr1, ...)
  f_ops->read_iter()
    (iomap-based ) iomap_dio_rw
      # for READ && user_backed_iter(iter):
        dio->flags |= IOMAP_DIO_DIRTY
      iomap_dio_iter
        iomap_dio_bio_iter
          # add user or kernel pages to a bio
          bio_iov_iter_get_pages
            ...
            pin_user_pages_fast(..., FOLL_WRITE, ...)
              # find corresponding vma of dest buffer (fuse page cache)
              # search page table (pet) to find corresponding page
              # if not fault yet, trigger explicit faultin:
                faultin_page(..., FOLL_WRITE, ...)
                  handle_mm_fault(..., FAULT_FLAG_WRITE)
                    handle_pte_fault
                      do_wp_page
                        (vma->vm_flags & VM_SHARED) wp_page_shared
			  ...
			  fault_dirty_shared_page
                            folio_mark_dirty
                              a_ops->dirty_folio(), i.e.,
filemap_dirty_folio()
				# set PG_dirty
				folio_test_set_dirty(folio)
				# set PAGECACHE_TAG_DIRTY
				__folio_mark_dirty


          # if dio->flags & IOMAP_DIO_DIRTY:
          bio_set_pages_dirty
            (for each dest page) folio_mark_dirty
               a_ops->dirty_folio(), i.e., filemap_dirty_folio()
                 # set PG_dirty
		 folio_test_set_dirty(folio)
                 # set PAGECACHE_TAG_DIRTY
		 __folio_mark_dirty
```


> 
>> ```
>>
>> The auxiliary write request list was introduced to fix this.
>>
>> I'm not sure if there's an alternative other than the auxiliary list to
>> fix it, e.g. calling folio_wait_writeback() in a_ops->dirty_folio() so
>> that the same folio won't get dirtied when the writeback has not
>> completed yet?
>>
> 
> I'm curious how other filesystems solve for this - this seems like a
> generic situation other filesystems would run into as well.
> 

As mentioned above, the writeback path will prevent the duplicate
writeback request on the same page when the first writeback IO has not
completed yet.

Sorry for the noise...

-- 
Thanks,
Jingbo

