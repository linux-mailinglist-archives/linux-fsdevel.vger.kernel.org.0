Return-Path: <linux-fsdevel+bounces-35374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E769D4616
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 04:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B218D2818C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 03:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE511304BA;
	Thu, 21 Nov 2024 03:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EHE2nbGU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A7C2AD00
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2024 03:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732158527; cv=none; b=V609TuoD1y2QYZKKwJG51IXssBHsN2yHRkWHeb8hY/RnDsHQmyqNSPLy4iXzkbpn/FHwwI0TFsQiS/I3kjU/G5xSof/tSqAUyTUpm6EJiho4oWY+4WOki2ncqZYp8urwc5i+u9PLcpOxnaE0rjCqFXpcm0N3Oy7O+5vGzh6+Apk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732158527; c=relaxed/simple;
	bh=ytjAm//5JBI9TR+Rk9jTN4bWK+a0J6W6wJvsSryRqG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hV6q9QYj56XE12ZXM2M7wyg6axGZ3+WSvwutLzZ2TQ7eU/Xyvi7hV07A79eTZ4JbNXqm7toYsEcRkuh1AUIWlKDGxEhDQhOvoIDlaNZQgrIQSU5x42HAIZT8HWYbUB1MHR921BzrTaLlovl1D6uCiJpDg4ADYrmDr5aloFzxvb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EHE2nbGU; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732158515; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=KCXXX5o9L2eLUDNzQHtOaw7+2ZdwxM3iR4LbK/u0Zys=;
	b=EHE2nbGUiQA4/yCEc4x7P/DnKC1fP6tii9mkIfvE53GoEtADLvGe67KG/oNQUIp/Cm3cm4MXX0pYSQrPxNN7vzFiOl8ekIZ294orudN5HcgTLIJbTxUdiKJiogIXxVQQdSFnDd/a+tw884RCs/71YB8l8rfiBOPRABlAt/ZDIz0=
Received: from 30.221.144.254(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WJuAsIM_1732158514 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 21 Nov 2024 11:08:35 +0800
Message-ID: <53277184-6c03-469a-bb5e-3249460258ba@linux.alibaba.com>
Date: Thu, 21 Nov 2024 11:08:32 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, shakeel.butt@linux.dev,
 josef@toxicpanda.com, linux-mm@kvack.org, bernd.schubert@fastmail.fm,
 kernel-team@meta.com
References: <20241115224459.427610-1-joannelkoong@gmail.com>
 <20241115224459.427610-6-joannelkoong@gmail.com>
 <cad4a8b3-8065-4187-875f-1810263b988c@linux.alibaba.com>
 <CAJnrk1aiNZM_JhCwNX+XCdBWsqWxujLi3sUYaQEuN-qnA2gneQ@mail.gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAJnrk1aiNZM_JhCwNX+XCdBWsqWxujLi3sUYaQEuN-qnA2gneQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/21/24 5:53 AM, Joanne Koong wrote:
> On Wed, Nov 20, 2024 at 1:56 AM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>
>> On 11/16/24 6:44 AM, Joanne Koong wrote:
>>> In the current FUSE writeback design (see commit 3be5a52b30aa
>>> ("fuse: support writable mmap")), a temp page is allocated for every
>>> dirty page to be written back, the contents of the dirty page are copied over
>>> to the temp page, and the temp page gets handed to the server to write back.
>>>
>>> This is done so that writeback may be immediately cleared on the dirty page,
>>> and this in turn is done for two reasons:
>>> a) in order to mitigate the following deadlock scenario that may arise
>>> if reclaim waits on writeback on the dirty page to complete:
>>> * single-threaded FUSE server is in the middle of handling a request
>>>   that needs a memory allocation
>>> * memory allocation triggers direct reclaim
>>> * direct reclaim waits on a folio under writeback
>>> * the FUSE server can't write back the folio since it's stuck in
>>>   direct reclaim
>>> b) in order to unblock internal (eg sync, page compaction) waits on
>>> writeback without needing the server to complete writing back to disk,
>>> which may take an indeterminate amount of time.
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
>>> ---
>>>  fs/fuse/file.c | 339 +++----------------------------------------------
>>>  1 file changed, 20 insertions(+), 319 deletions(-)
>>>
>>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>>> index 88d0946b5bc9..56289ac58596 100644
>>> --- a/fs/fuse/file.c
>>> +++ b/fs/fuse/file.c
>>> @@ -1172,7 +1082,7 @@ static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
>>>       int err;
>>>
>>>       for (i = 0; i < ap->num_folios; i++)
>>> -             fuse_wait_on_folio_writeback(inode, ap->folios[i]);
>>> +             folio_wait_writeback(ap->folios[i]);
>>>
>>>       fuse_write_args_fill(ia, ff, pos, count);
>>>       ia->write.in.flags = fuse_write_flags(iocb);
>>> @@ -1622,7 +1532,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
>>>                       return res;
>>>               }
>>>       }
>>> -     if (!cuse && fuse_range_is_writeback(inode, idx_from, idx_to)) {
>>> +     if (!cuse && filemap_range_has_writeback(mapping, pos, (pos + count - 1))) {
>>>               if (!write)
>>>                       inode_lock(inode);
>>>               fuse_sync_writes(inode);
>>> @@ -1825,7 +1735,7 @@ static void fuse_writepage_free(struct fuse_writepage_args *wpa)
>>>               fuse_sync_bucket_dec(wpa->bucket);
>>>
>>>       for (i = 0; i < ap->num_folios; i++)
>>> -             folio_put(ap->folios[i]);
>>> +             folio_end_writeback(ap->folios[i]);
>>
>> I noticed that if we folio_end_writeback() in fuse_writepage_finish()
>> (rather than fuse_writepage_free()), there's ~50% buffer write
>> bandwridth performance gain (5500MB -> 8500MB)[*]
>>
>> The fuse server is generally implemented in multi-thread style, and
>> multi (fuse server) worker threads could fetch and process FUSE_WRITE
>> requests of one fuse inode.  Then there's serious lock contention for
>> the xarray lock (of the address space) when these multi worker threads
>> call fuse_writepage_end->folio_end_writeback when they are sending
>> replies of FUSE_WRITE requests.
>>
>> The lock contention is greatly alleviated when folio_end_writeback() is
>> serialized with fi->lock.  IOWs in the current implementation
>> (folio_end_writeback() in fuse_writepage_free()), each worker thread
>> needs to compete for the xarray lock for 256 times (one fuse request can
>> contain at most 256 pages if FUSE_MAX_MAX_PAGES is 256) when completing
>> a FUSE_WRITE request.
>>
>> After moving folio_end_writeback() to fuse_writepage_finish(), each
>> worker thread needs to compete for fi->lock only once.  IOWs the locking
>> granularity is larger now.
>>
> 
> Interesting! Thanks for sharing. Are you able to consistently repro
> these results and on different machines? When I run it locally on my
> machine using the commands you shared, I'm seeing roughly the same
> throughput:
> 
> Current implementation (folio_end_writeback() in fuse_writepage_free()):
>   WRITE: bw=385MiB/s (404MB/s), 385MiB/s-385MiB/s (404MB/s-404MB/s),
> io=113GiB (121GB), run=300177-300177msec
>   WRITE: bw=384MiB/s (403MB/s), 384MiB/s-384MiB/s (403MB/s-403MB/s),
> io=113GiB (121GB), run=300178-300178msec
> 
> fuse_end_writeback() in fuse_writepage_finish():
>   WRITE: bw=387MiB/s (406MB/s), 387MiB/s-387MiB/s (406MB/s-406MB/s),
> io=113GiB (122GB), run=300165-300165msec
>   WRITE: bw=381MiB/s (399MB/s), 381MiB/s-381MiB/s (399MB/s-399MB/s),
> io=112GiB (120GB), run=300143-300143msec
> 
> I wonder if it's because your machine is so much faster that lock
> contention makes a difference for you whereas on my machine there's
> other things that slow it down before lock contention comes into play.

Yeah, I agree that the lock contention matters only when the writeback
kworker consumes 100% CPU, i.e. when the writeback kworker is the
bottleneck.  To expose that, the passthrough_hp daemon works in
benchmark[*] mode (I noticed that passthrough_hp can be the bottleneck
when disabling "--bypass-rw" mode).

[*]
https://github.com/libfuse/libfuse/pull/807/commits/e83789cc6e83ca42ccc9899c4f7f8c69f31cbff9


> 
> I see your point about why it would make sense that having
> folio_end_writeback() in fuse_writepage_finish() inside the scope of
> the fi->lock could make it faster, but I also could see how having it
> outside the lock could make it faster as well. I'm thinking about the
> scenario where if there's 8 threads all executing
> fuse_send_writepage() at the same time, calling folio_end_writeback()
> outside the fi->lock would unblock other threads trying to get the
> fi->lock and that other thread could execute while
> folio_end_writeback() gets executed.
> 
> Looking at it some more, it seems like it'd be useful if there was
> some equivalent api to folio_end_writeback() that takes in an array of
> folios and would only need to grab the xarray lock once to clear
> writeback on all the folios in the array.

Yes it's exactly what we need.


> 
> When fuse supports large folios [*] this will help lock contention on
> the xarray lock as well because there'll be less folio_end_writeback()
> calls.

Cool, it definitely helps.


> 
> I'm happy to move the fuse_end_writeback() call to
> fuse_writepage_finish() considering what you're seeing. 5500 Mb ->
> 8800 Mb is a huge perf improvement!

This statistics is tested in benchmark ("--bypass-rw") mode.  When
disabling "--bypass-rw" mode and testing fuse passthrough_hp over a ext4
over nvme, the performance gain is ~10% (4009MB/s ->4428MB/s).


>>> @@ -2367,54 +2111,23 @@ static int fuse_writepages_fill(struct folio *folio,
>>>               data->wpa = NULL;
>>>       }
>>>
>>> -     err = -ENOMEM;
>>> -     tmp_folio = folio_alloc(GFP_NOFS | __GFP_HIGHMEM, 0);
>>> -     if (!tmp_folio)
>>> -             goto out_unlock;
>>> -
>>> -     /*
>>> -      * The page must not be redirtied until the writeout is completed
>>> -      * (i.e. userspace has sent a reply to the write request).  Otherwise
>>> -      * there could be more than one temporary page instance for each real
>>> -      * page.
>>> -      *
>>> -      * This is ensured by holding the page lock in page_mkwrite() while
>>> -      * checking fuse_page_is_writeback().  We already hold the page lock
>>> -      * since clear_page_dirty_for_io() and keep it held until we add the
>>> -      * request to the fi->writepages list and increment ap->num_folios.
>>> -      * After this fuse_page_is_writeback() will indicate that the page is
>>> -      * under writeback, so we can release the page lock.
>>> -      */
>>>       if (data->wpa == NULL) {
>>>               err = -ENOMEM;
>>>               wpa = fuse_writepage_args_setup(folio, data->ff);
>>> -             if (!wpa) {
>>> -                     folio_put(tmp_folio);
>>> +             if (!wpa)
>>>                       goto out_unlock;
>>> -             }
>>>               fuse_file_get(wpa->ia.ff);
>>>               data->max_folios = 1;
>>>               ap = &wpa->ia.ap;
>>>       }
>>>       folio_start_writeback(folio);
>>
>> There's also a lock contention for the xarray lock when calling
>> folio_start_writeback().
>>
>> I also noticed a strange thing that, if we lock fi->lock and unlock
>> immediately, the write bandwidth improves by 5% (8500MB -> 9000MB).  The
> 
> Interesting! By lock fi->lock and unlock immediately, do you mean
> locking it, then unlocking it, then calling folio_start_writeback() or
> locking it, calling folio_start_writeback() and then unlocking it?

Either way works, as long as we lock/unlock fi->lock in
fuse_writepages_fill()...  The lock contention is further alleviated
when folio_start_writeback() is inside the critical area of fi->lock.


-- 
Thanks,
Jingbo

