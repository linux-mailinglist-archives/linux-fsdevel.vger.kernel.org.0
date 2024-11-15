Return-Path: <linux-fsdevel+bounces-34863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E329CD54C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 03:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E34CB2313F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 02:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4485113774D;
	Fri, 15 Nov 2024 02:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XogfyNDl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579B510F2
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 02:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731637090; cv=none; b=Cn6LbqjUH5ucr5QXA7fIwbB8ZMDCGTIJolcDkbsd++SNqOD+xERD1mwsGDa2KjprQze5ZUfuvN9wjkan+VZWm0w7XXbv6geSve9uZeSSxbOBPslJRcTUUAcNIYmLDNt2bcMCANgtxOa4CmNuThXlJ84cHIafcA/S8XdOzAUjWEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731637090; c=relaxed/simple;
	bh=q4FeBsNv6k4LuxmIZoTIhQR3jSwURzPidwjOpqgggCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KWrzz2Fgj5qC8yRyX8q71d8zJ5P0LScwkO6SYdDf6XAX7uxbvnngmFUrzVw70dbsvkVDtvMYw7kPlQUUeqWJ9g8M7gkn/OgUvivudDVpv2J0//nBk3mOoRnSPWTRFh1uxy9S0Ir6GB7Gmip3QzCphRIvL5NCU0ux7T3OuQxMxDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XogfyNDl; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731637084; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=3OsQYofxeejJ/f/fyS7qFZ2htI7XNIwL8dHv0UqcEqg=;
	b=XogfyNDlxjmSZe7T8z5Ej5UfTUpxPDZ20dE5v1GraWmF0RfDS8zrD0//gLpXeTBs7go7LzKUnJb+YMj0Mg9hAzIaJmizcmS2fnA3cyXRXPdjd0p5rEoCbx70KWyMh3ZEud1HMuHMEO1XajTlNKgcTpcKb1BgIVnVv5JvkAHSv58=
Received: from 192.168.31.58(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WJQmacF_1731637082 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 15 Nov 2024 10:18:03 +0800
Message-ID: <8cd0a96c-7d8f-4a38-afc6-2c48bc701da8@linux.alibaba.com>
Date: Fri, 15 Nov 2024 10:18:02 +0800
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
 <e85bd643-894e-4eb2-994b-62f0d642b4f1@linux.alibaba.com>
 <CAJnrk1bS6J9NXae5bXTF+MrKV2VZ-2bi=WqkyY1XY2BggA01TQ@mail.gmail.com>
 <47661fe5-8616-4133-8d9c-faeb1ab96962@linux.alibaba.com>
 <CAJnrk1Y+CZq5uL72kp1vXxF4Vf1kf+Nk_oGmYFHA8b-uw2gfgQ@mail.gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAJnrk1Y+CZq5uL72kp1vXxF4Vf1kf+Nk_oGmYFHA8b-uw2gfgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/15/24 2:19 AM, Joanne Koong wrote:
> On Wed, Nov 13, 2024 at 5:47 PM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>
>>
>>
>> On 11/14/24 8:39 AM, Joanne Koong wrote:
>>> On Tue, Nov 12, 2024 at 1:25 AM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>>>
>>>> Hi Joanne,
>>>>
>>>> On 11/8/24 7:56 AM, Joanne Koong wrote:
>>>>> Currently, we allocate and copy data to a temporary folio when
>>>>> handling writeback in order to mitigate the following deadlock scenario
>>>>> that may arise if reclaim waits on writeback to complete:
>>>>> * single-threaded FUSE server is in the middle of handling a request
>>>>>   that needs a memory allocation
>>>>> * memory allocation triggers direct reclaim
>>>>> * direct reclaim waits on a folio under writeback
>>>>> * the FUSE server can't write back the folio since it's stuck in
>>>>>   direct reclaim
>>>>>
>>>>> To work around this, we allocate a temporary folio and copy over the
>>>>> original folio to the temporary folio so that writeback can be
>>>>> immediately cleared on the original folio. This additionally requires us
>>>>> to maintain an internal rb tree to keep track of writeback state on the
>>>>> temporary folios.
>>>>>
>>>>> A recent change prevents reclaim logic from waiting on writeback for
>>>>> folios whose mappings have the AS_WRITEBACK_MAY_BLOCK flag set in it.
>>>>> This commit sets AS_WRITEBACK_MAY_BLOCK on FUSE inode mappings (which
>>>>> will prevent FUSE folios from running into the reclaim deadlock described
>>>>> above) and removes the temporary folio + extra copying and the internal
>>>>> rb tree.
>>>>>
>>>>> fio benchmarks --
>>>>> (using averages observed from 10 runs, throwing away outliers)
>>>>>
>>>>> Setup:
>>>>> sudo mount -t tmpfs -o size=30G tmpfs ~/tmp_mount
>>>>>  ./libfuse/build/example/passthrough_ll -o writeback -o max_threads=4 -o source=~/tmp_mount ~/fuse_mount
>>>>>
>>>>> fio --name=writeback --ioengine=sync --rw=write --bs={1k,4k,1M} --size=2G
>>>>> --numjobs=2 --ramp_time=30 --group_reporting=1 --directory=/root/fuse_mount
>>>>>
>>>>>         bs =  1k          4k            1M
>>>>> Before  351 MiB/s     1818 MiB/s     1851 MiB/s
>>>>> After   341 MiB/s     2246 MiB/s     2685 MiB/s
>>>>> % diff        -3%          23%         45%
>>>>>
>>>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>>>
>>>> I think there are some places checking or waiting for writeback could be
>>>> reconsidered if they are still needed or not after we dropping the temp
>>>> page design.
>>>>
>>>> As they are inherited from the original implementation, at least they
>>>> are harmless.  I think they could be remained in this patch, and could
>>>> be cleaned up later if really needed.
>>>>
>>>
>>> Thank you for the thorough inspection!
>>>
>>>>
>>>>> @@ -891,7 +813,7 @@ static int fuse_do_readfolio(struct file *file, struct folio *folio)
>>>>>        * have writeback that extends beyond the lifetime of the folio.  So
>>>>>        * make sure we read a properly synced folio.
>>>>>        */
>>>>> -     fuse_wait_on_folio_writeback(inode, folio);
>>>>> +     folio_wait_writeback(folio);
>>>>
>>>> I doubt if wait-on-writeback is needed here, as now page cache won't be
>>>> freed until the writeback IO completes.
>>>>
>>>> The routine attempts to free page cache, e.g. invalidate_inode_pages2()
>>>> (generally called by distributed filesystems when the file content has
>>>> been modified from remote) or truncate_inode_pages() (called from
>>>> truncate(2) or inode eviction) will wait for writeback completion (if
>>>> any) before freeing page.
>>>>
>>>> Thus I don't think there's any possibility that .read_folio() or
>>>> .readahead() will be called when the writeback has not completed.
>>>>
>>>
>>> Great point. I'll remove this line and the comment above it too.
>>>
>>>>
>>>>> @@ -1172,7 +1093,7 @@ static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
>>>>>       int err;
>>>>>
>>>>>       for (i = 0; i < ap->num_folios; i++)
>>>>> -             fuse_wait_on_folio_writeback(inode, ap->folios[i]);
>>>>> +             folio_wait_writeback(ap->folios[i]);
>>>>
>>>> Ditto.
>>
>> Actually this is a typo and I originally meant that waiting for
>> writeback in fuse_send_readpages() is unneeded as page cache won't be
>> freed until the writeback IO completes.
>>
>>> -     wait_event(fi->page_waitq, !fuse_range_is_writeback(inode, first, last));
>>> +     filemap_fdatawait_range(inode->i_mapping, first, last);
>>
> 
> Gotcha and agreed. I'll remove this wait from readahead().
> 
>>
>> In fact the above waiting for writeback in fuse_send_write_pages() is
>> needed.  The reason is as follows:
>>
>>>>
>>>
>>> Why did we need this fuse_wait_on_folio_writeback() even when we had
>>> the temp pages? If I'm understanding it correctly,
>>> fuse_send_write_pages() is only called for the writethrough case (by
>>> fuse_perform_write()), so these folios would never even be under
>>> writeback, no?
>>
>> I think mmap write could make the page dirty and the writeback could be
>> triggered then.
>>
> 
> Ohhh I see, thanks for the explanation.
> 
>>>
>>>>
>>>>
>>>>>  static void fuse_writepage_args_page_fill(struct fuse_writepage_args *wpa, struct folio *folio,
>>>>> -                                       struct folio *tmp_folio, uint32_t folio_index)
>>>>> +                                       uint32_t folio_index)
>>>>>  {
>>>>>       struct inode *inode = folio->mapping->host;
>>>>>       struct fuse_args_pages *ap = &wpa->ia.ap;
>>>>>
>>>>> -     folio_copy(tmp_folio, folio);
>>>>> -
>>>>> -     ap->folios[folio_index] = tmp_folio;
>>>>> +     folio_get(folio);
>>>>
>>>> I still think this folio_get() here is harmless but redundant.
>>>>
>>>> Ditto page cache won't be freed before writeback completes.
>>>>
>>>> Besides, other .writepages() implementaions e.g. iomap_writepages() also
>>>> doen't get the refcount when constructing the writeback IO.
>>>>
>>>
>>> Point taken. I'll remove this then, since other .writepages() also
>>> don't obtain a refcount.
>>>
>>>>
>>>>> @@ -2481,7 +2200,7 @@ static int fuse_write_begin(struct file *file, struct address_space *mapping,
>>>>>       if (IS_ERR(folio))
>>>>>               goto error;
>>>>>
>>>>> -     fuse_wait_on_page_writeback(mapping->host, folio->index);
>>>>> +     folio_wait_writeback(folio);
>>>>
>>>> I also doubt if wait_on_writeback() is needed here, as now there won't
>>>> be duplicate writeback IOs for the same page.
>>>
>>> What prevents there from being a duplicate writeback write for the
>>> same page? This is the path I'm looking at:
>>>
>>> ksys_write()
>>>   vfs_write()
>>>     new_sync_write()
>>>        op->write_iter()
>>>           fuse_file_write_iter()
>>>             fuse_cache_write_iter()
>>>                generic_file_write_iter()
>>>                    __generic_file_write_iter()
>>>                        generic_perform_write()
>>>                            op->write_begin()
>>>                                fuse_write_begin()
>>>
>>> but I'm not seeing where there's anything that prevents a duplicate
>>> write from happening.
>>
>> I mean there won't be duplicate *writeback* rather than *write* for the
>> same page.  You could write the page cache and make it dirty at the time
>> when the writeback for the same page is still on going, as long as we
>> can ensure that even when the page is dirtied again, there won't be a
>> duplicate writeback IO for the same page when the previous writeback IO
>> has not completed yet.
>>
> 
> I think we still need this folio_wait_writeback() since we're calling
> fuse_do_readfolio() and removing the folio_wait_writeback() from
> fuse_do_readfolio(). else we could read back stale data if the
> writeback hasn't gone through yet.
> I think we could probably move the folio_wait_writeback() here in
> fuse_write_begin() to be right before the fuse_do_readfolio() call and
> skip waiting on writeback if we hit the "success" gotos.

IIUC if cache hit when fuse_write_begin() is called, the page is marked
with PG_update which indicates that (.readpage()) the IO request reading
data from disk to page is already done.  Thus fuse_write_begin() will do
nothing and return directly.

> 	if (folio_test_uptodate(folio) || len >= folio_size(folio))
> 		goto success;

Otherwise fuse_do_readfolio() is called to read data when cache miss,
i.e. the page doesn't exist in the page cache before or it gets
invalidated previously.  Since we can ensure that no page can be
invalidated until the writeback IO completes, we can ensure that there's
no in-flight writeback IO when fuse_do_readfolio() is called.

Other folks can also correct me if I get wrong, since I also attempts to
figure out all these details about the page cache management recently.


-- 
Thanks,
Jingbo

