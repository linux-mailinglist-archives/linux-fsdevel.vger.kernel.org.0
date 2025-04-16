Return-Path: <linux-fsdevel+bounces-46527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E5DA8ADA3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 03:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF27189EA07
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 01:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85548227BA5;
	Wed, 16 Apr 2025 01:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="p2XkKrve"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8345227
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Apr 2025 01:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744767984; cv=none; b=XryOj7F+TvaBQIsuOpxHD20Q4q4niKFOgXUWQIGVi0Wi7AXZMkal1QvOmaCdi8V+J7TD+T6fBmK+ETrdJ5h2WKkF+WXKV8824U5RrhW59TOu/P+ZKckjpF314Pbi+qU2FSAmozGKkKXdsDPX/suT6FFMkn9SYEsgZI2YFu1WV2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744767984; c=relaxed/simple;
	bh=nYQl/0+s5ofdTpf2naezz9Y2HcZqp9Y95zbF+sMfJtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V5HCp2/SZxaCSINxkmNYOrRq+F6VyvEsZ/ERyYV3JROGXf8v4p8SePNJr2nUb0y2aVVHYdnQqvJOugSnQmF5fgS02cEdo1bKGalYYvocXJc36awrxpSPt5x64nUWSKzhfqNEqtl6bOj9Mb6QJtoyyWxlDQ1xc7GpcuUlQltn9g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=p2XkKrve; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1744767973; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=s4sBxL4tACesuCIMvtcUHLQ2pa3yCtq67KgEP0eetU0=;
	b=p2XkKrveHbhcAqhwcwBdwyGg+UF+65B8PngRHBxkX2bOU/SBdAq5vch/Xr7O1KWibGU7FYOltbqQX3GeYe8A+5pqNOQztr4egju8mD5UJ9a+zry6wnYemsl57plKQKhF/8P+LJZhDui90YgnFfutzuy1ltKwR51+GNPi1xweGss=
Received: from 30.221.144.237(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WX6kxaq_1744767652 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Apr 2025 09:40:52 +0800
Message-ID: <c66d712f-e2f1-4c6e-b9a6-14689101f866@linux.alibaba.com>
Date: Wed, 16 Apr 2025 09:40:51 +0800
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
 <9a3cfb55-faae-4551-9bef-b9650432848a@linux.alibaba.com>
 <CAJnrk1a_YL-Dg4HeVWnmwUVH2tCN2MYu30kiV5KSv4mkezWOZg@mail.gmail.com>
 <a738a765-a5e1-44bc-b1cd-e1a42d73e255@linux.alibaba.com>
 <CAJnrk1ZZ7tRwPk0hUePDVcwKnec96qFkO3Mk1zyG2g5PO1XL=w@mail.gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAJnrk1ZZ7tRwPk0hUePDVcwKnec96qFkO3Mk1zyG2g5PO1XL=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/15/25 11:59 PM, Joanne Koong wrote:
> On Tue, Apr 15, 2025 at 12:49 AM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>
>> Hi Joanne,
>>
>> Sorry for the late reply...
> 
> Hi Jingbo,
> 
> No worries at all.
>>
>>
>> On 4/11/25 12:11 AM, Joanne Koong wrote:
>>> On Thu, Apr 10, 2025 at 8:11 AM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>>>
>>>> On 4/10/25 11:07 PM, Joanne Koong wrote:
>>>>> On Wed, Apr 9, 2025 at 7:12 PM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 4/10/25 7:47 AM, Joanne Koong wrote:
>>>>>>>   On Tue, Apr 8, 2025 at 7:43 PM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>>>>>>>
>>>>>>>> Hi Joanne,
>>>>>>>>
>>>>>>>> On 4/5/25 2:14 AM, Joanne Koong wrote:
>>>>>>>>> In the current FUSE writeback design (see commit 3be5a52b30aa
>>>>>>>>> ("fuse: support writable mmap")), a temp page is allocated for every
>>>>>>>>> dirty page to be written back, the contents of the dirty page are copied over
>>>>>>>>> to the temp page, and the temp page gets handed to the server to write back.
>>>>>>>>>
>>>>>>>>> This is done so that writeback may be immediately cleared on the dirty page,
>>>>>>>>> and this in turn is done in order to mitigate the following deadlock scenario
>>>>>>>>> that may arise if reclaim waits on writeback on the dirty page to complete:
>>>>>>>>> * single-threaded FUSE server is in the middle of handling a request
>>>>>>>>>   that needs a memory allocation
>>>>>>>>> * memory allocation triggers direct reclaim
>>>>>>>>> * direct reclaim waits on a folio under writeback
>>>>>>>>> * the FUSE server can't write back the folio since it's stuck in
>>>>>>>>>   direct reclaim
>>>>>>>>>
>>>>>>>>> With a recent change that added AS_WRITEBACK_INDETERMINATE and mitigates
>>>>>>>>> the situations described above, FUSE writeback does not need to use
>>>>>>>>> temp pages if it sets AS_WRITEBACK_INDETERMINATE on its inode mappings.
>>>>>>>>>
>>>>>>>>> This commit sets AS_WRITEBACK_INDETERMINATE on the inode mappings
>>>>>>>>> and removes the temporary pages + extra copying and the internal rb
>>>>>>>>> tree.
>>>>>>>>>
>>>>>>>>> fio benchmarks --
>>>>>>>>> (using averages observed from 10 runs, throwing away outliers)
>>>>>>>>>
>>>>>>>>> Setup:
>>>>>>>>> sudo mount -t tmpfs -o size=30G tmpfs ~/tmp_mount
>>>>>>>>>  ./libfuse/build/example/passthrough_ll -o writeback -o max_threads=4 -o source=~/tmp_mount ~/fuse_mount
>>>>>>>>>
>>>>>>>>> fio --name=writeback --ioengine=sync --rw=write --bs={1k,4k,1M} --size=2G
>>>>>>>>> --numjobs=2 --ramp_time=30 --group_reporting=1 --directory=/root/fuse_mount
>>>>>>>>>
>>>>>>>>>         bs =  1k          4k            1M
>>>>>>>>> Before  351 MiB/s     1818 MiB/s     1851 MiB/s
>>>>>>>>> After   341 MiB/s     2246 MiB/s     2685 MiB/s
>>>>>>>>> % diff        -3%          23%         45%
>>>>>>>>>
>>>>>>>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>>>>>>>> Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>>>>>>>>> Acked-by: Miklos Szeredi <mszeredi@redhat.com>
>>>>>>>>
>>>>>>>
>>>>>>> Hi Jingbo,
>>>>>>>
>>>>>>> Thanks for sharing your analysis for this.
>>>>>>>
>>>>>>>> Overall this patch LGTM.
>>>>>>>>
>>>>>>>> Apart from that, IMO the fi->writectr and fi->queued_writes mechanism is
>>>>>>>> also unneeded then, at least the DIRECT IO routine (i.e.
>>>>>>>
>>>>>>> I took a look at fi->writectr and fi->queued_writes and my
>>>>>>> understanding is that we do still need this. For example, for
>>>>>>> truncates (I'm looking at fuse_do_setattr()), I think we still need to
>>>>>>> prevent concurrent writeback or else the setattr request and the
>>>>>>> writeback request could race which would result in a mismatch between
>>>>>>> the file's reported size and the actual data written to disk.
>>>>>>
>>>>>> I haven't looked into the truncate routine yet.  I will see it later.
>>>>>>
>>>>>>>
>>>>>>>> fuse_direct_io()) doesn't need fuse_sync_writes() anymore.  That is
>>>>>>>> because after removing the temp page, the DIRECT IO routine has already
>>>>>>>> been waiting for all inflight WRITE requests, see
>>>>>>>>
>>>>>>>> # DIRECT read
>>>>>>>> generic_file_read_iter
>>>>>>>>   kiocb_write_and_wait
>>>>>>>>     filemap_write_and_wait_range
>>>>>>>
>>>>>>> Where do you see generic_file_read_iter() getting called for direct io reads?
>>>>>>
>>>>>> # DIRECT read
>>>>>> fuse_file_read_iter
>>>>>>   fuse_cache_read_iter
>>>>>>     generic_file_read_iter
>>>>>>       kiocb_write_and_wait
>>>>>>        filemap_write_and_wait_range
>>>>>>       a_ops->direct_IO(),i.e. fuse_direct_IO()
>>>>>>
>>>>>
>>>>> Oh I see, I thought files opened with O_DIRECT automatically call the
>>>>> .direct_IO handler for reads/writes but you're right, it first goes
>>>>> through .read_iter / .write_iter handlers, and the .direct_IO handler
>>>>> only gets invoked through generic_file_read_iter() /
>>>>> generic_file_direct_write() in mm/filemap.c
>>>>>
>>>>> There's two paths for direct io in FUSE:
>>>>> a) fuse server sets fi->direct_io = true when a file is opened, which
>>>>> will set the FOPEN_DIRECT_IO bit in ff->open_flags on the kernel side
>>>>> b) fuse server doesn't set fi->direct_io = true, but the client opens
>>>>> the file with O_DIRECT
>>>>>
>>>>> We only go through the stack trace you listed above for the b) case.
>>>>> For the a) case, we'll hit
>>>>>
>>>>>         if (ff->open_flags & FOPEN_DIRECT_IO)
>>>>>                 return fuse_direct_read_iter(iocb, to);
>>>>>
>>>>> and
>>>>>
>>>>>         if (ff->open_flags & FOPEN_DIRECT_IO)
>>>>>                 return fuse_direct_write_iter(iocb, from);
>>>>>
>>>>> which will invoke fuse_direct_IO() / fuse_direct_io() without going
>>>>> through the kiocb_write_and_wait() -> filemap_write_and_wait_range() /
>>>>> kiocb_invalidate_pages() -> filemap_write_and_wait_range() you listed
>>>>> above.
>>>>>
>>>>> So for the a) case I think we'd still need the fuse_sync_writes() in
>>>>> case there's still pending writeback.
>>>>>
>>>>> Do you agree with this analysis or am I missing something here?
>>>>
>>>> Yeah, that's true.  But instead of calling fuse_sync_writes(), we can
>>>> call filemap_wait_range() or something similar here.
>>>>
>>>
>>> Agreed. Actually, the more I look at this, the more I think we can
>>> replace all fuse_sync_writes() and get rid of it entirely.
>>
>>
>> I have seen your latest reply that this cleaning up won't be included in
>> this series, which is okay.
>>
>>
>>> fuse_sync_writes() is called in:
>>>
>>> fuse_fsync():
>>>         /*
>>>          * Start writeback against all dirty pages of the inode, then
>>>          * wait for all outstanding writes, before sending the FSYNC
>>>          * request.
>>>          */
>>>         err = file_write_and_wait_range(file, start, end);
>>>         if (err)
>>>                 goto out;
>>>
>>>         fuse_sync_writes(inode);
>>>
>>>         /*
>>>          * Due to implementation of fuse writeback
>>>          * file_write_and_wait_range() does not catch errors.
>>>          * We have to do this directly after fuse_sync_writes()
>>>          */
>>>         err = file_check_and_advance_wb_err(file);
>>>         if (err)
>>>                 goto out;
>>>
>>>
>>>       We can get rid of the fuse_sync_writes() and
>>> file_check_and_advance_wb_err() entirely since now without temp pages,
>>> the file_write_and_wait_range() call actually ensures that writeback
>>> is completed
>>>
>>>
>>>
>>> fuse_writeback_range():
>>>         static int fuse_writeback_range(struct inode *inode, loff_t
>>> start, loff_t end)
>>>         {
>>>                 int err =
>>> filemap_write_and_wait_range(inode->i_mapping, start, LLONG_MAX);
>>>
>>>                 if (!err)
>>>                         fuse_sync_writes(inode);
>>>
>>>                 return err;
>>>         }
>>>
>>>
>>>       We can replace fuse_writeback_range() entirely with
>>> filemap_write_and_wait_range().
>>>
>>>
>>>
>>> fuse_direct_io():
>>>         if (fopen_direct_io && fc->direct_io_allow_mmap) {
>>>                 res = filemap_write_and_wait_range(mapping, pos, pos +
>>> count - 1);
>>>                 if (res) {
>>>                         fuse_io_free(ia);
>>>                         return res;
>>>                 }
>>>         }
>>>         if (!cuse && filemap_range_has_writeback(mapping, pos, (pos +
>>> count - 1))) {
>>>                 if (!write)
>>>                         inode_lock(inode);
>>>                 fuse_sync_writes(inode);
>>>                 if (!write)
>>>                         inode_unlock(inode);
>>>         }
>>>
>>>
>>>        I think this can just replaced with
>>>                 if (fopen_direct_io && (fc->direct_io_allow_mmap || !cuse)) {
>>>                         res = filemap_write_and_wait_range(mapping,
>>> pos, pos + count - 1);
>>>                         if (res) {
>>>                                 fuse_io_free(ia);
>>>                                 return res;
>>>                         }
>>>                 }
>>
>> Alright. But I would prefer doing this filemap_write_and_wait_range() in
>> fuse_direct_write_iter() rather than fuse_direct_io() if possible.
>>
>>>        since for the !fopen_direct_io case, it will already go through
>>> filemap_write_and_wait_range(), as you mentioned in your previous
>>> message. I think this also fixes a bug (?) in the original code - in
>>> the fopen_direct_io && !fc->direct_io_allow_mmap case, I think we
>>> still need to write out dirty pages first, which we don't currently
>>> do.
>>
>> Nope.  In case of fopen_direct_io && !fc->direct_io_allow_mmap, there
>> won't be any page cache at all, right?
>>
> 
> Isn't there still a page cache if the file was previously opened
> without direct io and then the client opens another handle to that
> file with direct io? In that case, the pages could still be dirty in
> the page cache and would need to be written back first, no?

Do you mean that when the inode is firstly opened, FOPEN_DIRECT_IO is
not set by the FUSE server, while it is secondly opened, the flag is set?

Though the behavior of the FUSE daemon is quite confusing in this case,
it is completely possible in real life.  So yes we'd better add
filemap_write_and_wait_range() unconditionally in fopen_direct_io case.


-- 
Thanks,
Jingbo

