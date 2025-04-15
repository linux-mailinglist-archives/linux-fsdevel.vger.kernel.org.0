Return-Path: <linux-fsdevel+bounces-46431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D14A5A8959A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 09:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3DC57A483A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 07:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632882417C8;
	Tue, 15 Apr 2025 07:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uFvZ1YOf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F701BEF8C
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 07:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744703355; cv=none; b=ohd3NJN8rJdowKopWH5xti2P0ujD417q3QItPqRHO20qFvGqXBHnK2NIySOiHlafGZSLcrh+H3dJjwMIlVryfSkTAeM0vM1d1H1CxoAb6LxzxPeThywhfkt01RV0lZBzqe9ju+qgDLZ973oEajn5Wjt8e336C2lzqqSkhgpsRKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744703355; c=relaxed/simple;
	bh=5pPeXkQmB+LU95C9GmAV+gxtWT2KbSWlQzvMs7UP9dA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U9fqqZNsvMbKVLV8tkFdslkpehZ2ipNyuuBy/GBTyQ6MPTzxmJ+HzsRjteMYnsEpD/fLN74EHoeJ9/eM7MduORKZmCQnbxTTtt4ecV+A4dweimqv5qtvjL2eGEE1bbH6M5WROPx3xpB79cvkMhzFJ2GmChIH4DYmiUS79TuGExQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uFvZ1YOf; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1744703349; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=zLPR7liFdTw1eqeX46Q2j532O9oTxRIw1mmcFVNsuFE=;
	b=uFvZ1YOfH8ek7oio0U1fPpwXwfUPHiYzC4yjGgOlYYknnKYendO2dxLWMWC6j2ry9sMjhqboppRkUYYlc0OmDHKgUckcfKJZS6F9yMAOpqfu4Xi8gY/6+zUOxwsEg0fgL6Qgd8FiDInQEIfyZ3t/XpfkYFSVmxOHIUbT0RGfEI4=
Received: from 30.221.145.234(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WX4-mjH_1744703346 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Apr 2025 15:49:07 +0800
Message-ID: <a738a765-a5e1-44bc-b1cd-e1a42d73e255@linux.alibaba.com>
Date: Tue, 15 Apr 2025 15:49:06 +0800
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
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAJnrk1a_YL-Dg4HeVWnmwUVH2tCN2MYu30kiV5KSv4mkezWOZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Joanne,

Sorry for the late reply...


On 4/11/25 12:11 AM, Joanne Koong wrote:
> On Thu, Apr 10, 2025 at 8:11 AM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>
>> On 4/10/25 11:07 PM, Joanne Koong wrote:
>>> On Wed, Apr 9, 2025 at 7:12 PM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>>>
>>>>
>>>>
>>>> On 4/10/25 7:47 AM, Joanne Koong wrote:
>>>>>   On Tue, Apr 8, 2025 at 7:43 PM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>>>>>
>>>>>> Hi Joanne,
>>>>>>
>>>>>> On 4/5/25 2:14 AM, Joanne Koong wrote:
>>>>>>> In the current FUSE writeback design (see commit 3be5a52b30aa
>>>>>>> ("fuse: support writable mmap")), a temp page is allocated for every
>>>>>>> dirty page to be written back, the contents of the dirty page are copied over
>>>>>>> to the temp page, and the temp page gets handed to the server to write back.
>>>>>>>
>>>>>>> This is done so that writeback may be immediately cleared on the dirty page,
>>>>>>> and this in turn is done in order to mitigate the following deadlock scenario
>>>>>>> that may arise if reclaim waits on writeback on the dirty page to complete:
>>>>>>> * single-threaded FUSE server is in the middle of handling a request
>>>>>>>   that needs a memory allocation
>>>>>>> * memory allocation triggers direct reclaim
>>>>>>> * direct reclaim waits on a folio under writeback
>>>>>>> * the FUSE server can't write back the folio since it's stuck in
>>>>>>>   direct reclaim
>>>>>>>
>>>>>>> With a recent change that added AS_WRITEBACK_INDETERMINATE and mitigates
>>>>>>> the situations described above, FUSE writeback does not need to use
>>>>>>> temp pages if it sets AS_WRITEBACK_INDETERMINATE on its inode mappings.
>>>>>>>
>>>>>>> This commit sets AS_WRITEBACK_INDETERMINATE on the inode mappings
>>>>>>> and removes the temporary pages + extra copying and the internal rb
>>>>>>> tree.
>>>>>>>
>>>>>>> fio benchmarks --
>>>>>>> (using averages observed from 10 runs, throwing away outliers)
>>>>>>>
>>>>>>> Setup:
>>>>>>> sudo mount -t tmpfs -o size=30G tmpfs ~/tmp_mount
>>>>>>>  ./libfuse/build/example/passthrough_ll -o writeback -o max_threads=4 -o source=~/tmp_mount ~/fuse_mount
>>>>>>>
>>>>>>> fio --name=writeback --ioengine=sync --rw=write --bs={1k,4k,1M} --size=2G
>>>>>>> --numjobs=2 --ramp_time=30 --group_reporting=1 --directory=/root/fuse_mount
>>>>>>>
>>>>>>>         bs =  1k          4k            1M
>>>>>>> Before  351 MiB/s     1818 MiB/s     1851 MiB/s
>>>>>>> After   341 MiB/s     2246 MiB/s     2685 MiB/s
>>>>>>> % diff        -3%          23%         45%
>>>>>>>
>>>>>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>>>>>> Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>>>>>>> Acked-by: Miklos Szeredi <mszeredi@redhat.com>
>>>>>>
>>>>>
>>>>> Hi Jingbo,
>>>>>
>>>>> Thanks for sharing your analysis for this.
>>>>>
>>>>>> Overall this patch LGTM.
>>>>>>
>>>>>> Apart from that, IMO the fi->writectr and fi->queued_writes mechanism is
>>>>>> also unneeded then, at least the DIRECT IO routine (i.e.
>>>>>
>>>>> I took a look at fi->writectr and fi->queued_writes and my
>>>>> understanding is that we do still need this. For example, for
>>>>> truncates (I'm looking at fuse_do_setattr()), I think we still need to
>>>>> prevent concurrent writeback or else the setattr request and the
>>>>> writeback request could race which would result in a mismatch between
>>>>> the file's reported size and the actual data written to disk.
>>>>
>>>> I haven't looked into the truncate routine yet.  I will see it later.
>>>>
>>>>>
>>>>>> fuse_direct_io()) doesn't need fuse_sync_writes() anymore.  That is
>>>>>> because after removing the temp page, the DIRECT IO routine has already
>>>>>> been waiting for all inflight WRITE requests, see
>>>>>>
>>>>>> # DIRECT read
>>>>>> generic_file_read_iter
>>>>>>   kiocb_write_and_wait
>>>>>>     filemap_write_and_wait_range
>>>>>
>>>>> Where do you see generic_file_read_iter() getting called for direct io reads?
>>>>
>>>> # DIRECT read
>>>> fuse_file_read_iter
>>>>   fuse_cache_read_iter
>>>>     generic_file_read_iter
>>>>       kiocb_write_and_wait
>>>>        filemap_write_and_wait_range
>>>>       a_ops->direct_IO(),i.e. fuse_direct_IO()
>>>>
>>>
>>> Oh I see, I thought files opened with O_DIRECT automatically call the
>>> .direct_IO handler for reads/writes but you're right, it first goes
>>> through .read_iter / .write_iter handlers, and the .direct_IO handler
>>> only gets invoked through generic_file_read_iter() /
>>> generic_file_direct_write() in mm/filemap.c
>>>
>>> There's two paths for direct io in FUSE:
>>> a) fuse server sets fi->direct_io = true when a file is opened, which
>>> will set the FOPEN_DIRECT_IO bit in ff->open_flags on the kernel side
>>> b) fuse server doesn't set fi->direct_io = true, but the client opens
>>> the file with O_DIRECT
>>>
>>> We only go through the stack trace you listed above for the b) case.
>>> For the a) case, we'll hit
>>>
>>>         if (ff->open_flags & FOPEN_DIRECT_IO)
>>>                 return fuse_direct_read_iter(iocb, to);
>>>
>>> and
>>>
>>>         if (ff->open_flags & FOPEN_DIRECT_IO)
>>>                 return fuse_direct_write_iter(iocb, from);
>>>
>>> which will invoke fuse_direct_IO() / fuse_direct_io() without going
>>> through the kiocb_write_and_wait() -> filemap_write_and_wait_range() /
>>> kiocb_invalidate_pages() -> filemap_write_and_wait_range() you listed
>>> above.
>>>
>>> So for the a) case I think we'd still need the fuse_sync_writes() in
>>> case there's still pending writeback.
>>>
>>> Do you agree with this analysis or am I missing something here?
>>
>> Yeah, that's true.  But instead of calling fuse_sync_writes(), we can
>> call filemap_wait_range() or something similar here.
>>
> 
> Agreed. Actually, the more I look at this, the more I think we can
> replace all fuse_sync_writes() and get rid of it entirely. 


I have seen your latest reply that this cleaning up won't be included in
this series, which is okay.


> fuse_sync_writes() is called in:
> 
> fuse_fsync():
>         /*
>          * Start writeback against all dirty pages of the inode, then
>          * wait for all outstanding writes, before sending the FSYNC
>          * request.
>          */
>         err = file_write_and_wait_range(file, start, end);
>         if (err)
>                 goto out;
> 
>         fuse_sync_writes(inode);
> 
>         /*
>          * Due to implementation of fuse writeback
>          * file_write_and_wait_range() does not catch errors.
>          * We have to do this directly after fuse_sync_writes()
>          */
>         err = file_check_and_advance_wb_err(file);
>         if (err)
>                 goto out;
> 
> 
>       We can get rid of the fuse_sync_writes() and
> file_check_and_advance_wb_err() entirely since now without temp pages,
> the file_write_and_wait_range() call actually ensures that writeback
> is completed
> 
> 
> 
> fuse_writeback_range():
>         static int fuse_writeback_range(struct inode *inode, loff_t
> start, loff_t end)
>         {
>                 int err =
> filemap_write_and_wait_range(inode->i_mapping, start, LLONG_MAX);
> 
>                 if (!err)
>                         fuse_sync_writes(inode);
> 
>                 return err;
>         }
> 
> 
>       We can replace fuse_writeback_range() entirely with
> filemap_write_and_wait_range().
> 
> 
> 
> fuse_direct_io():
>         if (fopen_direct_io && fc->direct_io_allow_mmap) {
>                 res = filemap_write_and_wait_range(mapping, pos, pos +
> count - 1);
>                 if (res) {
>                         fuse_io_free(ia);
>                         return res;
>                 }
>         }
>         if (!cuse && filemap_range_has_writeback(mapping, pos, (pos +
> count - 1))) {
>                 if (!write)
>                         inode_lock(inode);
>                 fuse_sync_writes(inode);
>                 if (!write)
>                         inode_unlock(inode);
>         }
> 
> 
>        I think this can just replaced with
>                 if (fopen_direct_io && (fc->direct_io_allow_mmap || !cuse)) {
>                         res = filemap_write_and_wait_range(mapping,
> pos, pos + count - 1);
>                         if (res) {
>                                 fuse_io_free(ia);
>                                 return res;
>                         }
>                 }

Alright. But I would prefer doing this filemap_write_and_wait_range() in
fuse_direct_write_iter() rather than fuse_direct_io() if possible.

>        since for the !fopen_direct_io case, it will already go through
> filemap_write_and_wait_range(), as you mentioned in your previous
> message. I think this also fixes a bug (?) in the original code - in
> the fopen_direct_io && !fc->direct_io_allow_mmap case, I think we
> still need to write out dirty pages first, which we don't currently
> do.

Nope.  In case of fopen_direct_io && !fc->direct_io_allow_mmap, there
won't be any page cache at all, right?



-- 
Thanks,
Jingbo

