Return-Path: <linux-fsdevel+bounces-46155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD81FA8363F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 04:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1F4F7AA803
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 02:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9C61C3F34;
	Thu, 10 Apr 2025 02:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="h/PVKnA/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41B9136327
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Apr 2025 02:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744251162; cv=none; b=XYAdrgrY6nqfDWWmrZ1DAokWHPyXaQb95YON4CyMBkpCvdQT2lHxcY5zC9Mutv0I6HawDxSzrR1jJrrb4z3yEkFlaY5yUAiPcEekxQdq3begVio7t5MKQdnNdGegCQ/Bp1GFl7zxSzw2VBn9xJ2ilaJ0l5n+7eC+3JKgEgJxg6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744251162; c=relaxed/simple;
	bh=woxymu49L+x9hlr4JYz5b1TC7G3iW6Pg2Kx2bai92CE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PLzWOwcF0lTdmWanMAt2/mwpJ1vkpDw3Yy48F0UfbfHjqsOCwS2z2HJOyu6slpNkn/45ytMW5LdB5ECihUWmMCdVHBxu+tA1WBjKRSKcb4Qp5rouNUUmnbqDIK68DddIFdiLqBjoI+9cjlPxTN5VIgKAIUvDSZO1/dz0QeAOi1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=h/PVKnA/; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1744251155; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=R9121b9yjqO2sKle5RkcrFD3eZ/Qsdfxici1u6jpN8k=;
	b=h/PVKnA/9uap2SKbGY3JE0tIksGJMBRXARVJm2F5tSekJ2q3jdOxQLXI8YCwQer3Umi/o39Y6m+TwNQ0+NjmM4nFax45xsuSSbmpWa9TGEphTaHhAC9fO8kN7kmlTtGVZjb3PE6kHb30UEDWbeT/VkdNKNnI6kGvyfuBDNMVtA4=
Received: from 30.222.18.156(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WWMTlsK_1744251153 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 10 Apr 2025 10:12:33 +0800
Message-ID: <7e9b1a40-4708-42a8-b8fc-44fa50227e5b@linux.alibaba.com>
Date: Thu, 10 Apr 2025 10:12:32 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/3] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, akpm@linux-foundation.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, shakeel.butt@linux.dev,
 david@redhat.com, bernd.schubert@fastmail.fm, ziy@nvidia.com,
 jlayton@kernel.org, kernel-team@meta.com,
 Miklos Szeredi <mszeredi@redhat.com>
References: <20250404181443.1363005-1-joannelkoong@gmail.com>
 <20250404181443.1363005-4-joannelkoong@gmail.com>
 <db4f1411-f6de-4206-a6a3-5c9cf6b6d59d@linux.alibaba.com>
 <CAJnrk1bTGFXy+ZTchC7p4OYUnbfKZ7TtVkCsrsv87Mg1r8KkGA@mail.gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAJnrk1bTGFXy+ZTchC7p4OYUnbfKZ7TtVkCsrsv87Mg1r8KkGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/10/25 7:47 AM, Joanne Koong wrote:
>   On Tue, Apr 8, 2025 at 7:43 PM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>
>> Hi Joanne,
>>
>> On 4/5/25 2:14 AM, Joanne Koong wrote:
>>> In the current FUSE writeback design (see commit 3be5a52b30aa
>>> ("fuse: support writable mmap")), a temp page is allocated for every
>>> dirty page to be written back, the contents of the dirty page are copied over
>>> to the temp page, and the temp page gets handed to the server to write back.
>>>
>>> This is done so that writeback may be immediately cleared on the dirty page,
>>> and this in turn is done in order to mitigate the following deadlock scenario
>>> that may arise if reclaim waits on writeback on the dirty page to complete:
>>> * single-threaded FUSE server is in the middle of handling a request
>>>   that needs a memory allocation
>>> * memory allocation triggers direct reclaim
>>> * direct reclaim waits on a folio under writeback
>>> * the FUSE server can't write back the folio since it's stuck in
>>>   direct reclaim
>>>
>>> With a recent change that added AS_WRITEBACK_INDETERMINATE and mitigates
>>> the situations described above, FUSE writeback does not need to use
>>> temp pages if it sets AS_WRITEBACK_INDETERMINATE on its inode mappings.
>>>
>>> This commit sets AS_WRITEBACK_INDETERMINATE on the inode mappings
>>> and removes the temporary pages + extra copying and the internal rb
>>> tree.
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
>>> Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>>> Acked-by: Miklos Szeredi <mszeredi@redhat.com>
>>
> 
> Hi Jingbo,
> 
> Thanks for sharing your analysis for this.
> 
>> Overall this patch LGTM.
>>
>> Apart from that, IMO the fi->writectr and fi->queued_writes mechanism is
>> also unneeded then, at least the DIRECT IO routine (i.e.
> 
> I took a look at fi->writectr and fi->queued_writes and my
> understanding is that we do still need this. For example, for
> truncates (I'm looking at fuse_do_setattr()), I think we still need to
> prevent concurrent writeback or else the setattr request and the
> writeback request could race which would result in a mismatch between
> the file's reported size and the actual data written to disk.

I haven't looked into the truncate routine yet.  I will see it later.

> 
>> fuse_direct_io()) doesn't need fuse_sync_writes() anymore.  That is
>> because after removing the temp page, the DIRECT IO routine has already
>> been waiting for all inflight WRITE requests, see
>>
>> # DIRECT read
>> generic_file_read_iter
>>   kiocb_write_and_wait
>>     filemap_write_and_wait_range
> 
> Where do you see generic_file_read_iter() getting called for direct io reads?

# DIRECT read
fuse_file_read_iter
  fuse_cache_read_iter
    generic_file_read_iter
      kiocb_write_and_wait
       filemap_write_and_wait_range
      a_ops->direct_IO(),i.e. fuse_direct_IO()


> Similarly, where do you see generic_file_write_iter() getting called
> for direct io writes?

# DIRECT read
fuse_file_write_iter
  fuse_cache_write_iter
    generic_file_write_iter
      generic_file_direct_write
        kiocb_invalidate_pages
         filemap_invalidate_pages
           filemap_write_and_wait_range
      a_ops->direct_IO(),i.e. fuse_direct_IO()


> Where do you see fi->writectr / fi->queued-writes preventing this
> race?

IMO overall fi->writectr / fi->queued-writes are introduced to prevent
DIRECT IO and writeback from sending duplicate (inflight) WRITE requests
for the same page.

For the DIRECT write routine:

# non-FOPEN_DIRECT_IO DIRECT write
fuse_cache_write_iter
  fuse_direct_IO
    fuse_direct_io
      fuse_sync_writes


# FOPEN_DIRECT_IO DIRECT write
fuse_direct_write_iter
  fuse_direct_IO
    fuse_direct_io
      fuse_sync_writes


For the writeback routine:
fuse_writepages()
  fuse_writepages_fill
    fuse_writepages_send
      # buffer the WRITE request in queued_writes list
      fuse_flush_writepages
	# flush WRITE only when fi->writectr >= 0
	


> It looks to me like in the existing code, this race condition
> you described of direct write invalidating the page cache, then
> another buffer write reads the page cache and dirties it, then
> writeback is called on that, and the 2 write requests racing, could
> still happen?
> 
> 
>> However it seems that the writeback
>> won't wait for previous inflight DIRECT WRITE requests, so I'm not much
>> sure about that.  Maybe other folks could offer more insights...
> 
> My understanding is that these lines
> 
> if (!cuse && filemap_range_has_writeback(...)) {
>    ...
>    fuse_sync_writes(inode);
>    ...
> }
> 
> in fuse_direct_io() is what waits on previous inflight direct write
> requests to complete before the direct io happens.

Right.

> 
> 
>>
>> Also fuse_sync_writes() is not needed in fuse_flush() anymore, with
>> which I'm pretty sure.
> 
> Why don't we still need this for fuse_flush()?
> 
> If a caller calls close(), this will call
> 
> filp_close()
>   filp_flush()
>       filp->f_op->flush()
>           fuse_flush()
> 
> it seems like we should still be waiting for all writebacks to finish
> before sending the fuse server the fuse_flush request, no?
> 

filp_close()
   filp_flush()
       filp->f_op->flush()
           fuse_flush()
 	     write_inode_now
		writeback_single_inode(WB_SYNC_ALL)
		  do_writepages
		    # flush dirty page
		  filemap_fdatawait
		    # wait for WRITE completion

>>
>>> ---
>>>  fs/fuse/file.c   | 360 ++++-------------------------------------------
>>>  fs/fuse/fuse_i.h |   3 -
>>>  2 files changed, 28 insertions(+), 335 deletions(-)
>>>
>>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>>> index 754378dd9f71..91ada0208863 100644
>>> --- a/fs/fuse/file.c
>>> +++ b/fs/fuse/file.c
>>> @@ -415,89 +415,11 @@ u64 fuse_lock_owner_id(struct fuse_conn *fc, fl_owner_t id)
>>>
>>>  struct fuse_writepage_args {
>>>       struct fuse_io_args ia;
>>> -     struct rb_node writepages_entry;
>>>       struct list_head queue_entry;
>>> -     struct fuse_writepage_args *next;
>>>       struct inode *inode;
>>>       struct fuse_sync_bucket *bucket;
>>>  };
>>>
>>> -static struct fuse_writepage_args *fuse_find_writeback(struct fuse_inode *fi,
>>> -                                         pgoff_t idx_from, pgoff_t idx_to)
>>> -{
>>> -     struct rb_node *n;
>>> -
>>> -     n = fi->writepages.rb_node;
>>> -
>>> -     while (n) {
>>> -             struct fuse_writepage_args *wpa;
>>> -             pgoff_t curr_index;
>>> -
>>
>> --
>> Thanks,
>> Jingbo

-- 
Thanks,
Jingbo

