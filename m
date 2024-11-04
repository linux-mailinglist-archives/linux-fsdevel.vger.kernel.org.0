Return-Path: <linux-fsdevel+bounces-33593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D73699BADBC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 09:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6831A1F22761
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 08:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA49C18C038;
	Mon,  4 Nov 2024 08:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EL2E92gW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2BB1AAE27
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Nov 2024 08:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730707779; cv=none; b=shmmwM7kEnWxQVe1G9nDBeESoDMKVmA0pLc2m/Nc9vocRfDC/C8DuNnw5NnZ6uEKa6XzJ8zfQBupnGiRN/Sp+5lQGBI9bACbtn2QCO6yXy7gjBuWoW8WPfMi/eel8jS05IxLOayvRXAaKflygmcyw7vZRyh0ZeGwBtHo9/FfdVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730707779; c=relaxed/simple;
	bh=+/C2KpKMoLdMbX7oCsvjostTpUj6O1Oetf7lYIUU+2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AYCY5Ay0X/h+nhNLnbbTiC6aiLtiuzhlHSvfZP/+PydP6Pf5rL3Bsmu3Xhn1kvm1ZDSfkquQ/1nj5VMRg6v/EsUpAfxRq/d+z4rTDpU7Nkfb7+7Or5vmbecnkZWdTLIjTKpGl0mSZ2x9ein+W7MbENRWwWCa7Q6wYbqsQ4V8ggg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EL2E92gW; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730707772; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=oJvJBRBB26RqbMdvyiJ5Irpy2vHP/jmJUK9PCZrezNQ=;
	b=EL2E92gWthXK3+1UjFlX3dFSTDhfRoI8KAGRWeU0JKFIDDWs0C78pmYxeO/xvVCFIimttNe3EwfQHnGZ/Ahd90L/ySNSJnzlu1ab+qMiuqbWlqKfT7LTKptQjVU5tXaWIxQFn/eJck29MhsnV7Pq+rrGJ5/4zWRzDu7e7PgJ81o=
Received: from 30.221.146.28(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WId0IC9_1730707769 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 04 Nov 2024 16:09:31 +0800
Message-ID: <0f168324-1981-481a-82e7-f357d7a7e5a6@linux.alibaba.com>
Date: Mon, 4 Nov 2024 16:09:28 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
 Bernd Schubert <bernd.schubert@fastmail.fm>,
 Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
 josef@toxicpanda.com, hannes@cmpxchg.org, linux-mm@kvack.org,
 kernel-team@meta.com, Vlastimil Babka <vbabka@suse.cz>
References: <CAJnrk1b=ntstDcnjgLsmX+wTyHaiC9SZ7cdSRF2Zbb+0SAG1Zw@mail.gmail.com>
 <023c4bab-0eb6-45c5-9a42-d8fda0abec02@fastmail.fm>
 <CAJnrk1aqMY0j179JwRMZ3ZWL0Hr6Lrjn3oNHgQEiyUwRjLdVRw@mail.gmail.com>
 <c1cac2b5-e89f-452a-ba4f-95ed8d1ab16f@fastmail.fm>
 <CAJnrk1ZLEUZ9V48UfmXyF_=cFY38VdN=VO9LgBkXQSeR-2fMHw@mail.gmail.com>
 <rdqst2o734ch5ttfjwm6d6albtoly5wgvmdyyqepieyjo3qq7n@vraptoacoa3r>
 <ba12ca3b-7d98-489d-b5b9-d8c5c4504987@fastmail.fm>
 <CAJnrk1b9ttYVM2tupaNy+hqONRjRbxsGwdFvbCep75v01RtK+g@mail.gmail.com>
 <4hwdxhdxgjyxgxutzggny4isnb45jxtump7j7tzzv6paaqg2lr@55sguz7y4hu7>
 <CAJnrk1aY-OmjhB8bnowLNYosTP_nTZXGpiQimSS5VRfnNgBoJA@mail.gmail.com>
 <ipa4ozknzw5wq4z4znhza3km5erishys7kf6ov26kmmh4r7kph@vedmnra6kpbz>
 <CAJnrk1aZV=1mXwO+SNupffLQtQNeD3Uz+PBcxL1TKBDgGsgQPg@mail.gmail.com>
 <43aeed1a-0572-4bcc-8c06-49522459f7d2@linux.alibaba.com>
 <CAJnrk1ZOGrOXPRhX0325RvqkLJbv3Bz_CB4Er+5eTs6=3Dr+Zw@mail.gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAJnrk1ZOGrOXPRhX0325RvqkLJbv3Bz_CB4Er+5eTs6=3Dr+Zw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/2/24 4:54 AM, Joanne Koong wrote:
> On Fri, Nov 1, 2024 at 4:44 AM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>
>> Hi Joanne,
>>
>> Thanks for keeping pushing this forward.
>>
>> On 11/1/24 5:52 AM, Joanne Koong wrote:
>>> On Thu, Oct 31, 2024 at 1:06 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
>>>>
>>>> On Thu, Oct 31, 2024 at 12:06:49PM GMT, Joanne Koong wrote:
>>>>> On Wed, Oct 30, 2024 at 5:30 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
>>>> [...]
>>>>>>
>>>>>> Memory pool is a bit confusing term here. Most probably you are asking
>>>>>> about the migrate type of the page block from which tmp page is
>>>>>> allocated from. In a normal system, tmp page would be allocated from page
>>>>>> block with MIGRATE_UNMOVABLE migrate type while the page cache page, it
>>>>>> depends on what gfp flag was used for its allocation. What does fuse fs
>>>>>> use? GFP_HIGHUSER_MOVABLE or something else? Under low memory situation
>>>>>> allocations can get mixed up with different migrate types.
>>>>>>
>>>>>
>>>>> I believe it's GFP_HIGHUSER_MOVABLE for the page cache pages since
>>>>> fuse doesn't set any additional gfp masks on the inode mapping.
>>>>>
>>>>> Could we just allocate the fuse writeback pages with GFP_HIGHUSER
>>>>> instead of GFP_HIGHUSER_MOVABLE? That would be in fuse_write_begin()
>>>>> where we pass in the gfp mask to __filemap_get_folio(). I think this
>>>>> would give us the same behavior memory-wise as what the tmp pages
>>>>> currently do,
>>>>
>>>> I don't think it would be the same behavior. From what I understand the
>>>> liftime of the tmp page is from the start of the writeback till the ack
>>>> from the fuse server that writeback is done. While the lifetime of the
>>>> page of the page cache can be arbitrarily large. We should just make it
>>>> unmovable for its lifetime. I think it is fine to make the page
>>>> unmovable during the writeback. We should not try to optimize for the
>>>> bad or buggy behavior of fuse server.
>>>>
>>>> Regarding the avoidance of wait on writeback for fuse folios, I think we
>>>> can handle the migration similar to how you are handling reclaim and in
>>>> addition we can add a WARN() in folio_wait_writeback() if the kernel ever
>>>> sees a fuse folio in that function.
>>>
>>> Awesome, this is what I'm planning to do in v3 to address migration then:
>>>
>>> 1) in migrate_folio_unmap(), only call "folio_wait_writeback(src);" if
>>> src->mapping does not have the AS_NO_WRITEBACK_WAIT bit set on it (eg
>>> fuse folios will have that AS_NO_WRITEBACK_WAIT bit set)
>>
>> I think it's generally okay to skip FUSE pages under writeback when the
>> sync migrate_pages() is called in low memory context, which only tries
>> to migrate as many pages as possible (i.e. best effort).
>>
>> While more caution may be needed when the sync migrate_pages() is called
>> with an implicit hint that the migration can not fail.  For example,
>>
>> ```
>> offline_pages
>>         while {
>>                 scan_movable_pages
>>                 do_migrate_range
>>         }
>> ```
>>
>> If the malicious server never completes the writeback IO, no progress
>> will be made in the above while loop, and I'm afraid it will be a dead
>> loop then.
>>
> 
> Thanks for taking a look and sharing your thoughts.
> I agree. I think for this offline_pages() path, we need to handle this
> "TODO: fatal migration failures should bail out". For v3 I'm thinking
> of handling this by having some number of retries where we try
> do_migrate_range() but if it still doesn't succeed, to skip those
> pages and move onto the next.
> 
>>
>>>
>>> 2) in the fuse filesystem's implementation of the
>>> mapping->a_ops->migrate_folio callback, return -EAGAIN if the folio is
>>> under writeback.
>>
>> Is there any possibility that a_ops->migrate_folio() may be called with
>> the folio under writeback?
>>
>> - for most pages without AS_NO_WRITEBACK_WAIT, a_ops->migrate_folio()
>> will be called only when Page_writeback is cleared;
>> - for AS_NO_WRITEBACK_WAIT pages, they are skipped if they are under
>> writeback
>>
> 
> For AS_NO_WRITEBACK_WAIT_PAGES, if we skip waiting on them if they are
> under writeback, I think the a_ops->migrate_folio() will still get
> called (by migrate_pages_batch() -> migrate_folio_move() ->
> move_to_new_folio()).
> 
> Looking at migrate_folio_unmap() some more though,  I don't think we
> can just skip the wait call like we can for the sync(2) case. I think
> we need to error out here instead since after the wait call,
> migrate_folio_unmap() will replace the folio's page table mappings
> (try_to_migrate()). If we error out here, then there's no hitting
> a_ops->migrate_folio() when the folio is under writeback.
> 

Right, we need to bail out to skip this page (under writeback), just
like how MIGRATE_SYNC does.

-- 
Thanks,
Jingbo

