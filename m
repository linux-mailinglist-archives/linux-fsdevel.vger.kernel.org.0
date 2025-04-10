Return-Path: <linux-fsdevel+bounces-46215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CCEA84778
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 17:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0485189824C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 15:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DC91DF26B;
	Thu, 10 Apr 2025 15:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NNMVSCRD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBDB1624D0
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Apr 2025 15:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744297885; cv=none; b=kETiuo7Db/Wn//a8fpVRHb0IgSfYREwA+aen5XKkb/0yTORSBMxHmj479FHdHT2Pq1x2xPkV0ZL24fhnv2dd8SNMZXaNAFeTXf4th9nygPtf3CWERkPAiokzrGvXllHXVUhO5fOisjDI1eT9omTsUeCq8ih16jkJQoZPaE8Bgm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744297885; c=relaxed/simple;
	bh=XjW8sUZ00LJ3jzZcfiMm6oivMZ7AWrndAX8YJCWWAj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jgLDQwlqDEfQF+0Iga5G7dOiwzpQ7NPqJgkA+AW2bE0wIrFGMNJVSnrHAeQJgqagtGunA7FjL1sSccifq0HMZhp0yGhT01jfb84BDCaoSMSy+c+ymXijVIt3c7XODuPOUQZ3Wj71YD883WOVQcnLUXCWxP9u0Xq20w7yKHsN6KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NNMVSCRD; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1744297877; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=QekY4r+1ekyzezfOqZ2L++WB3a0HUkST9Br2kULSuMM=;
	b=NNMVSCRDg5tVWFI5OGLQe9kMe4Pp5U1G+y7YXM8WjmiOfr2uix2/Qmg59v8af+5Q9Z0J90NvW01j9PQVca6ehhWSnyLzzVa1Q1jRdRjRzz8x0ElzvXONmCgMP+RjhIT5gZ1lEmCC1rPkRckXIt+1Vg3r5r2gXyqNGydBUNQ6Nas=
Received: from 192.168.31.58(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WWPSFxj_1744297875 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 10 Apr 2025 23:11:16 +0800
Message-ID: <9a3cfb55-faae-4551-9bef-b9650432848a@linux.alibaba.com>
Date: Thu, 10 Apr 2025 23:11:15 +0800
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
 <7e9b1a40-4708-42a8-b8fc-44fa50227e5b@linux.alibaba.com>
 <CAJnrk1Z7Wi_KPe_TJckpYUVhv9mKX=-YTwaoQRgjT2z0fxD-7g@mail.gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAJnrk1Z7Wi_KPe_TJckpYUVhv9mKX=-YTwaoQRgjT2z0fxD-7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/10/25 11:07 PM, Joanne Koong wrote:
> On Wed, Apr 9, 2025 at 7:12 PM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>
>>
>>
>> On 4/10/25 7:47 AM, Joanne Koong wrote:
>>>   On Tue, Apr 8, 2025 at 7:43 PM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>>>
>>>> Hi Joanne,
>>>>
>>>> On 4/5/25 2:14 AM, Joanne Koong wrote:
>>>>> In the current FUSE writeback design (see commit 3be5a52b30aa
>>>>> ("fuse: support writable mmap")), a temp page is allocated for every
>>>>> dirty page to be written back, the contents of the dirty page are copied over
>>>>> to the temp page, and the temp page gets handed to the server to write back.
>>>>>
>>>>> This is done so that writeback may be immediately cleared on the dirty page,
>>>>> and this in turn is done in order to mitigate the following deadlock scenario
>>>>> that may arise if reclaim waits on writeback on the dirty page to complete:
>>>>> * single-threaded FUSE server is in the middle of handling a request
>>>>>   that needs a memory allocation
>>>>> * memory allocation triggers direct reclaim
>>>>> * direct reclaim waits on a folio under writeback
>>>>> * the FUSE server can't write back the folio since it's stuck in
>>>>>   direct reclaim
>>>>>
>>>>> With a recent change that added AS_WRITEBACK_INDETERMINATE and mitigates
>>>>> the situations described above, FUSE writeback does not need to use
>>>>> temp pages if it sets AS_WRITEBACK_INDETERMINATE on its inode mappings.
>>>>>
>>>>> This commit sets AS_WRITEBACK_INDETERMINATE on the inode mappings
>>>>> and removes the temporary pages + extra copying and the internal rb
>>>>> tree.
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
>>>>> Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>>>>> Acked-by: Miklos Szeredi <mszeredi@redhat.com>
>>>>
>>>
>>> Hi Jingbo,
>>>
>>> Thanks for sharing your analysis for this.
>>>
>>>> Overall this patch LGTM.
>>>>
>>>> Apart from that, IMO the fi->writectr and fi->queued_writes mechanism is
>>>> also unneeded then, at least the DIRECT IO routine (i.e.
>>>
>>> I took a look at fi->writectr and fi->queued_writes and my
>>> understanding is that we do still need this. For example, for
>>> truncates (I'm looking at fuse_do_setattr()), I think we still need to
>>> prevent concurrent writeback or else the setattr request and the
>>> writeback request could race which would result in a mismatch between
>>> the file's reported size and the actual data written to disk.
>>
>> I haven't looked into the truncate routine yet.  I will see it later.
>>
>>>
>>>> fuse_direct_io()) doesn't need fuse_sync_writes() anymore.  That is
>>>> because after removing the temp page, the DIRECT IO routine has already
>>>> been waiting for all inflight WRITE requests, see
>>>>
>>>> # DIRECT read
>>>> generic_file_read_iter
>>>>   kiocb_write_and_wait
>>>>     filemap_write_and_wait_range
>>>
>>> Where do you see generic_file_read_iter() getting called for direct io reads?
>>
>> # DIRECT read
>> fuse_file_read_iter
>>   fuse_cache_read_iter
>>     generic_file_read_iter
>>       kiocb_write_and_wait
>>        filemap_write_and_wait_range
>>       a_ops->direct_IO(),i.e. fuse_direct_IO()
>>
> 
> Oh I see, I thought files opened with O_DIRECT automatically call the
> .direct_IO handler for reads/writes but you're right, it first goes
> through .read_iter / .write_iter handlers, and the .direct_IO handler
> only gets invoked through generic_file_read_iter() /
> generic_file_direct_write() in mm/filemap.c
> 
> There's two paths for direct io in FUSE:
> a) fuse server sets fi->direct_io = true when a file is opened, which
> will set the FOPEN_DIRECT_IO bit in ff->open_flags on the kernel side
> b) fuse server doesn't set fi->direct_io = true, but the client opens
> the file with O_DIRECT
> 
> We only go through the stack trace you listed above for the b) case.
> For the a) case, we'll hit
> 
>         if (ff->open_flags & FOPEN_DIRECT_IO)
>                 return fuse_direct_read_iter(iocb, to);
> 
> and
> 
>         if (ff->open_flags & FOPEN_DIRECT_IO)
>                 return fuse_direct_write_iter(iocb, from);
> 
> which will invoke fuse_direct_IO() / fuse_direct_io() without going
> through the kiocb_write_and_wait() -> filemap_write_and_wait_range() /
> kiocb_invalidate_pages() -> filemap_write_and_wait_range() you listed
> above.
> 
> So for the a) case I think we'd still need the fuse_sync_writes() in
> case there's still pending writeback.
> 
> Do you agree with this analysis or am I missing something here?

Yeah, that's true.  But instead of calling fuse_sync_writes(), we can
call filemap_wait_range() or something similar here.



>> filp_close()
>>    filp_flush()
>>        filp->f_op->flush()
>>            fuse_flush()
>>              write_inode_now
>>                 writeback_single_inode(WB_SYNC_ALL)
>>                   do_writepages
>>                     # flush dirty page
>>                   filemap_fdatawait
>>                     # wait for WRITE completion
> 
> Nice. I missed that write_inode_now() will invoke filemap_fdatawait().
> This seems pretty straightforward. I'll remove the fuse_sync_writes()
> call in fuse_flush() when I send out v8.
> 
> The direct io one above is less straight-forward. I won't add that to
> v8 but that can be done in a separate future patch when we figure that
> out.

Thanks for keep working on this. Appreciated.

-- 
Thanks,
Jingbo

