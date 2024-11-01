Return-Path: <linux-fsdevel+bounces-33459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C78439B909E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 12:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5437DB21D38
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 11:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8F81990A8;
	Fri,  1 Nov 2024 11:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="O2fzpXo6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C58E15359A
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Nov 2024 11:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730461776; cv=none; b=oZD/6m439ZRUx3sWdnLJxdFuKVQgXbMv1QAhlfE83zdCLx3cnLXIFLf8bqU7ZYA/C+v+A8gbPyNxZvm/zfn3uZg3ZnU+K06QB57bkkXxjHxpiwfoMcfI5hMGzaMQTOlm2DKlaUkot874IbEEr/R9YbPHfjOzTzL6jUa0f0dC0as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730461776; c=relaxed/simple;
	bh=RdRm/7ldv81PwF9wtIyiApv4SggN9B2SlFNn2QkUGPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YF0ZBNDYQ3veMoFx7XhFKtf6FtJEjCZNVTdZRZXw1xKTAP0CCyjcgG0YaCbuJQA8gvo+4MdY3GODDgu4w1DD2RxALNu7Hm01s0H2rHA2i9kkeVU6sOv+BgWoDfuTVr/nPbHnMdygEkhR2zt4AvBfwmautXtS9iN5PKaTDMREp5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=O2fzpXo6; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730461770; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=9ijLlyG7y1k+JpZnuKKIER0K2Jko/yUXHQnUqE7/+jc=;
	b=O2fzpXo6GRPbOeRJp6P2Zc2w9g+s2OPXc6KJOczT3nMSQ7NDEhaf7F7E4NGnpjG5kguqIqg3w7xDki0IUONs3rlSxpM5qD5UWPMaz5xSoMQug/fmRFo9djWtPAxNsM+LGdtqyF05iuMgcmVah0zeMwOlxzvdfFdl7tHg6jfdMIk=
Received: from 30.221.145.1(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WIRWj2h_1730461456 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 01 Nov 2024 19:44:17 +0800
Message-ID: <43aeed1a-0572-4bcc-8c06-49522459f7d2@linux.alibaba.com>
Date: Fri, 1 Nov 2024 19:44:13 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Joanne Koong <joannelkoong@gmail.com>,
 Shakeel Butt <shakeel.butt@linux.dev>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
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
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAJnrk1aZV=1mXwO+SNupffLQtQNeD3Uz+PBcxL1TKBDgGsgQPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Joanne,

Thanks for keeping pushing this forward.

On 11/1/24 5:52 AM, Joanne Koong wrote:
> On Thu, Oct 31, 2024 at 1:06 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
>>
>> On Thu, Oct 31, 2024 at 12:06:49PM GMT, Joanne Koong wrote:
>>> On Wed, Oct 30, 2024 at 5:30 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
>> [...]
>>>>
>>>> Memory pool is a bit confusing term here. Most probably you are asking
>>>> about the migrate type of the page block from which tmp page is
>>>> allocated from. In a normal system, tmp page would be allocated from page
>>>> block with MIGRATE_UNMOVABLE migrate type while the page cache page, it
>>>> depends on what gfp flag was used for its allocation. What does fuse fs
>>>> use? GFP_HIGHUSER_MOVABLE or something else? Under low memory situation
>>>> allocations can get mixed up with different migrate types.
>>>>
>>>
>>> I believe it's GFP_HIGHUSER_MOVABLE for the page cache pages since
>>> fuse doesn't set any additional gfp masks on the inode mapping.
>>>
>>> Could we just allocate the fuse writeback pages with GFP_HIGHUSER
>>> instead of GFP_HIGHUSER_MOVABLE? That would be in fuse_write_begin()
>>> where we pass in the gfp mask to __filemap_get_folio(). I think this
>>> would give us the same behavior memory-wise as what the tmp pages
>>> currently do,
>>
>> I don't think it would be the same behavior. From what I understand the
>> liftime of the tmp page is from the start of the writeback till the ack
>> from the fuse server that writeback is done. While the lifetime of the
>> page of the page cache can be arbitrarily large. We should just make it
>> unmovable for its lifetime. I think it is fine to make the page
>> unmovable during the writeback. We should not try to optimize for the
>> bad or buggy behavior of fuse server.
>>
>> Regarding the avoidance of wait on writeback for fuse folios, I think we
>> can handle the migration similar to how you are handling reclaim and in
>> addition we can add a WARN() in folio_wait_writeback() if the kernel ever
>> sees a fuse folio in that function.
> 
> Awesome, this is what I'm planning to do in v3 to address migration then:
> 
> 1) in migrate_folio_unmap(), only call "folio_wait_writeback(src);" if
> src->mapping does not have the AS_NO_WRITEBACK_WAIT bit set on it (eg
> fuse folios will have that AS_NO_WRITEBACK_WAIT bit set)

I think it's generally okay to skip FUSE pages under writeback when the
sync migrate_pages() is called in low memory context, which only tries
to migrate as many pages as possible (i.e. best effort).

While more caution may be needed when the sync migrate_pages() is called
with an implicit hint that the migration can not fail.  For example,

```
offline_pages
	while {
		scan_movable_pages
		do_migrate_range
	}
```

If the malicious server never completes the writeback IO, no progress
will be made in the above while loop, and I'm afraid it will be a dead
loop then.


> 
> 2) in the fuse filesystem's implementation of the
> mapping->a_ops->migrate_folio callback, return -EAGAIN if the folio is
> under writeback.

Is there any possibility that a_ops->migrate_folio() may be called with
the folio under writeback?

- for most pages without AS_NO_WRITEBACK_WAIT, a_ops->migrate_folio()
will be called only when Page_writeback is cleared;
- for AS_NO_WRITEBACK_WAIT pages, they are skipped if they are under
writeback

-- 
Thanks,
Jingbo

