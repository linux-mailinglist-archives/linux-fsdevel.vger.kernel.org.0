Return-Path: <linux-fsdevel+bounces-60329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D07FEB44BA8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 04:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D95B7A6D01
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 02:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EA522172D;
	Fri,  5 Sep 2025 02:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="t3OeD4nS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AE81E3DE5;
	Fri,  5 Sep 2025 02:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757039835; cv=none; b=ljjQVTQcWcF3LHUTpmXNCweRBWcL6ToF6ThUMHxPGvoQuvjgHRzl2oJqIW+PVR1pwFBID8zLflxpbMS5XdUA0QgNVXT1+1EO7gxRlbQIAj5absMGm8AOo2/Yr1NtH6eWEZJJRhlCeKSt1MWMzKH0sNWVabFezO+D6sTXdSUAxYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757039835; c=relaxed/simple;
	bh=UGTXJugIRy1M4WKMCUR7w0GnUB25at2ZQABEUPH3W/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n118pvRxLsi+nV7JHakMXJnx2ycbymgLn67P+iu/BoHS++q2FWQPLJfu/0GaK6J/JapaKwx+cnjjrh0LidqYB7pQqtdI4Xbthx1dw+U041Wc9C2QLTBuHowHMhzMrcSxjYHUNLYjGIf0lknptNkl0Zmyo07zgZQjW/5QWqGoX8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=t3OeD4nS; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757039823; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=NGYgvY6Y3kPW16Obeyy1FYL0bUeHAOATt2HrRULbluQ=;
	b=t3OeD4nSCawUWywtsrwsrGBqbU1xcf/2vIwEDAlDzhxuOxWGfHs7F6YGyb9Tv5LYoNis3pyeHtOz3JgxfLjSBGHEc1dwzWmFA4qEN8d12Jbu+8Oj2f0BaRNYBHs0pzeVG5xGZoBkFZd67uBt3bSC413nWU3NyGTE93/Qx7VtGsE=
Received: from 30.221.131.209(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WnIqbYy_1757038879 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 05 Sep 2025 10:21:20 +0800
Message-ID: <d631c71f-9d0d-405f-862d-b881767b1945@linux.alibaba.com>
Date: Fri, 5 Sep 2025 10:21:19 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 13/16] iomap: add a private arg for read and readahead
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org,
 djwong@kernel.org, linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
 linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
 <20250829235627.4053234-14-joannelkoong@gmail.com> <aLJZv5L6q0FH5F8a@debian>
 <CAJnrk1af4-FG==X=4LzoBRaxL9N-hnh1i-zx89immQZMLKSzyQ@mail.gmail.com>
 <a44fd64d-e0b1-4131-9d71-2d36151c90f4@linux.alibaba.com>
 <CAJnrk1bBmA+VK6UK1n6DRnuLvX8UOMp-VgQGnn2rUrq0=mCyqA@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAJnrk1bBmA+VK6UK1n6DRnuLvX8UOMp-VgQGnn2rUrq0=mCyqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/9/5 07:29, Joanne Koong wrote:
> On Tue, Sep 2, 2025 at 6:55 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>

...


>>>>
>>>>>    int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops,
>>>>> -             const struct iomap_read_ops *read_ops)
>>>>> +             const struct iomap_read_ops *read_ops, void *private)
>>>>>    {
>>>>>         struct iomap_iter iter = {
>>>>>                 .inode          = folio->mapping->host,
>>>>>                 .pos            = folio_pos(folio),
>>>>>                 .len            = folio_size(folio),
>>>>> +             .private        = private,
>>>>>         };
>>>>
>>>> Will this whole work be landed for v6.18?
>>>>
>>>> If not, may I ask if this patch can be shifted advance in this
>>>> patchset for applying separately (I tried but no luck).
>>>>
>>>> Because I also need some similar approach for EROFS iomap page
>>>> cache sharing feature since EROFS uncompressed I/Os go through
>>>> iomap and extra information needs a proper way to pass down to
>>>> iomap_{begin,end} with extra pointer `.private` too.
>>>
>>> Hi Gao,
>>>
>>> I'm not sure whether this will be landed for v6.18 but I'm happy to
>>> shift this patch to the beginning of the patchset for applying
>>> separately.
>>
>> Yeah, thanks.  At least this common patch can be potentially applied
>> easily (e.g. form a common commit id for both features if really
>> needed) since other iomap/FUSE patches are not dependency of our new
>> feature and shouldn't be coupled with our development branch later.
>>
> 
> Hi Gao,
> 
> I'll be dropping this patch in v2 since all the iomap read stuff is
> going to go through a struct ctx arg instead of through iter->private.
> Sorry this won't help your use case, but looking forward to seeing your patches.

Hi Joanne,

Thanks for your reminder.  Okay, I will check your v2 to know how
you change then.

Also, one thing I really think it's helpful for our use cases is
converting .iomap_begin() at least to pass struct iomap_iter *
directly rather than (inode, pos, len, flags, iomap, srcmap)
since:
   - .iomap_{begin,end}() are introduced before iomap_iter()
     and struct iomap_iter but those callbacks are basically
     now passed down some fields of `struct iomap_iter` now;

   - struct iomap_iter->private then can contain a per-request
     context so that .iomap_begin() can leverage too;

   - There are already too many arguments for .iomap_begin(),
     pass down struct iomap_iter directly could avoid adding
     another `private` argument to .iomap_begin()..

Therefore, I do wonder if this change (.iomap_begin() passes
struct iomap_iter *) is a good idea for the iomap folks, in
addition that filesystems can specify `struct iomap_iter->private`
as in this patch.  Since this change is necessary to make our
page cache sharing feature efficient, I will continue working on
this soon.


Another thing I want to discuss (but it's less important for our
recent features) is the whole callback hook model of iomap.

Basically the current model does mean if any filesystem doesn't
fulfill the iomap standard flow, it has to add some customized
callback hook somewhere to modify the code flow then (or introduce
a new special flag and move their specific logic into iomap/
itself even other fses may not need this), but the hook way will
cause increased indirect calls for them, currently we have
`struct iomap_ops`, `struct iomap_writeback_ops` and
`struct iomap_dio_ops`, if some another filesystem (when converting
buffer I/Os for example or adding {pre,post}-processing ) have
specified timing, it needs to add new hooks then.

I do wonder if it's possible to convert iomap to get rid of the
indirect-call model by just providing helper kAPIs instead,
take .read_folio / .fiemap for example e.g.

    xxxfs_read_folio:
       loop iomap_iter
         xxxfs_iomap_begin();
	iomap_readpage_bio_advance(); [ or if a fs is non-bio
              based, spliting more low-level helpers for them. ]
         xxxfs_iomap_end();

    xxxfs_fiemap():
       iomap_fiemap_begin
       loop iomap_iter
         xxxfs_iomap_begin();
         iomap_readpage_fiemap_advance()
         xxxfs_iomap_end();
       iomap_fiemap_end
        
So that each fs can use those helpers flexibly instead of diging
into adding various new indirect call hooks or moving customized
logic into iomap/ itself.

I don't have a specific example  because currently we don't have
direct issue against standard iomap flow on our uncompressed
path, but after a quick glance of other potential users who try
to convert their buffer I/Os to iomap, I had such impression in
my head for a while.

Thanks,
Gao Xiang

> 
> 
> Thanks,
> Joanne
> 
>> Thanks,
>> Gao Xiang
>>
>>>
>>> Thanks,
>>> Joanne
>>>>
>>>> Thanks,
>>>> Gao Xiang
>>


