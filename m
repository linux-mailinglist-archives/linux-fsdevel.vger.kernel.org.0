Return-Path: <linux-fsdevel+bounces-60722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22584B5092C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 01:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 214891C6299D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 23:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CA0287262;
	Tue,  9 Sep 2025 23:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wXnbFwfA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0951F3D58;
	Tue,  9 Sep 2025 23:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757460116; cv=none; b=OssVQcprkr4rc3t26iuo/Cow/k8lPW6AwtohFb1uGbF5sMFpjNLPx6ioEnueZtnOlgdpI643XKy1svvreB5ufMEv/OEfGpfJ2pocUZZPtujXzhJqiJwXC2kh6lmX3JYfDAirYe8tRWmg0MBXs+9ohQrZqzt3TVdvAbn/x+VpN/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757460116; c=relaxed/simple;
	bh=eibTRJ7HE0lU2R0MPS4mUJGOox1jCETS8teAgOrwFjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=W1Fc2jecFNyepjZ+5phcW7s2mDphtpNnLfuYSN+U+iRq99HXYKR2ZSx35w+KqFZAiZPMSx1/qsMbRBO9lWPuxalEqihIhpD8M3iR0rf6jRwMY+cYwmxQx//gdSGoS2NWc7NU+HxObpIXkm7Y4jpj9c1MShsw7qSpUbaa5dzN02M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wXnbFwfA; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757460110; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=108KB8TcIdTBZlziMq4PiXlySytzFGUVDHJv6u8P/ss=;
	b=wXnbFwfAzv/LidCVZ8/U8296g++8KU3IJXma8z9avo0lRQs+AxnmIQFJnaxhTEB4QRDnTOgG2hnmVh947cIIGjEpxFZctzfsP0sDMewVnnSRhhmFCaX1MljDqgqy1LBMyvTiiaixx5nDNr0fDSFsSmuOAUzzS+U03GbrKsHvY0M=
Received: from 30.180.0.242(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WnfVsA3_1757460109 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 10 Sep 2025 07:21:50 +0800
Message-ID: <488d246b-13c7-4e36-9510-8ae2de450647@linux.alibaba.com>
Date: Wed, 10 Sep 2025 07:21:48 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/16] iomap: add caller-provided callbacks for read
 and readahead
To: Joanne Koong <joannelkoong@gmail.com>, djwong@kernel.org,
 hch@infradead.org, brauner@kernel.org, miklos@szeredi.hu,
 linux-block@vger.kernel.org, gfs2@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
 linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-12-joannelkoong@gmail.com> <aL9xb5Jw8tvIRMcQ@debian>
 <CAJnrk1YPpNs811dwWo+ts1xwFi-57OgWvSO4_8WLL_3fJgzrFw@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAJnrk1YPpNs811dwWo+ts1xwFi-57OgWvSO4_8WLL_3fJgzrFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Joanne,

On 2025/9/9 23:24, Joanne Koong wrote:
> On Mon, Sep 8, 2025 at 8:14 PM Gao Xiang <xiang@kernel.org> wrote:
>>
>> Hi Joanne,
>>
>> On Mon, Sep 08, 2025 at 11:51:17AM -0700, Joanne Koong wrote:
>>> Add caller-provided callbacks for read and readahead so that it can be
>>> used generically, especially by filesystems that are not block-based.
>>>
>>> In particular, this:
>>> * Modifies the read and readahead interface to take in a
>>>    struct iomap_read_folio_ctx that is publicly defined as:
>>>
>>>    struct iomap_read_folio_ctx {
>>>        const struct iomap_read_ops *ops;
>>>        struct folio *cur_folio;
>>>        struct readahead_control *rac;
>>>        void *private;
>>>    };
>>>
>>>    where struct iomap_read_ops is defined as:
>>>
>>>    struct iomap_read_ops {
>>>        int (*read_folio_range)(const struct iomap_iter *iter,
>>>                               struct iomap_read_folio_ctx *ctx,
>>>                               loff_t pos, size_t len);
>>>        int (*read_submit)(struct iomap_read_folio_ctx *ctx);
>>>    };
>>>
>>
>> No, I don't think `struct iomap_read_folio_ctx` has another
>> `.private` makes any sense, because:
>>
>>   - `struct iomap_iter *iter` already has `.private` and I think
>>     it's mainly used for per-request usage; and your new
>>     `.read_folio_range` already passes
>>      `const struct iomap_iter *iter` which has `.private`
>>     I don't think some read-specific `.private` is useful in any
>>     case, also below.
>>
>>   - `struct iomap_read_folio_ctx` cannot be accessed by previous
>>     .iomap_{begin,end} helpers, which means `struct iomap_read_ops`
>>     is only useful for FUSE read iter/submit logic.
>>
>> Also after my change, the prototype will be:
>>
>> int iomap_read_folio(const struct iomap_ops *ops,
>>                       struct iomap_read_folio_ctx *ctx, void *private2);
>> void iomap_readahead(const struct iomap_ops *ops,
>>                       struct iomap_read_folio_ctx *ctx, void *private2);
>>
>> Is it pretty weird due to `.iomap_{begin,end}` in principle can
>> only use `struct iomap_iter *` but have no way to access
>> ` struct iomap_read_folio_ctx` to get more enough content for
>> read requests.
> 
> Hi Gao,
> 
> imo I don't think it makes sense to, if I'm understanding what you're
> proposing correctly, have one shared data pointer between iomap
> read/readahead and the iomap_{begin,end} helpers because

My main concern is two `private` naming here: I would like to add
`private` to iomap_read/readahead() much like __iomap_dio_rw() at
least to make our new feature work efficiently.

> 
> a) I don't think it's guaranteed that the data needed by
> read/readahead and iomap_{begin,end} is the same.  I guess we could
> combine the data each needs altogether into one struct, but it seems
> simpler and cleaner to me to just have the two be separate.
> 
> b) I'm not sure about the erofs use case, but at least for what I'm
> seeing for fuse and the block-based filesystems currently using iomap,
> the data needed by iomap read/readahead (eg bios, the fuse
> fuse_fill_read_data) is irrelevant for iomap_{begin/end} and it seems
> unclean to expose that extraneous info. (btw I don't think it's true
> that iomap_iter is mainly used for per-request usage - for readahead
> for example, iomap_{begin,end} is called before and after we service
> the entire readahead, not called per request, whereas
> .read_folio_range() is called per request).

I said `per-request` meant a single sync read or readahead request,
which is triggered by vfs or mm for example.

> 
> c) imo iomap_{begin,end} is meant to be a more generic interface and I
> don't think it makes sense to tie read-specific data to it. For
> example, some filesystems (eg gfs2) use the same iomap_ops across
> different file operations (eg buffered writes, direct io, reads, bmap,
> etc).

Previously `.iomap_{begin,end}` participates in buffer read and write
I/O paths (except for page writeback of course) as you said, in
principle users only need to care about fields in `struct iomap_iter`.

`struct iomap_readpage_ctx` is currently used as an internal structure
which is completely invisible to filesystems (IOWs, filesystems don't
need to care or specify any of that).

After your proposal, new renamed `struct iomap_read_folio_ctx` will be
exposed to individual filesystems too, but that makes two external
context structures for the buffer I/O reads (`struct iomap_iter` and
`struct iomap_read_folio_ctx`) instead of one.

I'm not saying your proposal doesn't work, but:

  - which is unlike `struct iomap_writepage_ctx` because writeback path
    doesn't have `struct iomap_iter` involved, and it has only that
    exact one `struct iomap_writepage_ctx` context and all callbacks
    use that only;

  - take a look at `iomap_dio_rw` and `iomap_dio_ops`, I think it's
    somewhat similiar to the new `struct iomap_read_ops` in some
    extent, but dio currently also exposes the exact one context
    (`struct iomap_iter`) to users.

  - take a look at `iomap_write_ops`, it also exposes
    `struct iomap_iter` only. you may say `folio`, `pos`, `len` can be
    wrapped as another `struct iomap_write_ctx` if needed, but that is
    not designed to be exposed to be specfied by write_iter (e.g.
    fuse_cache_write_iter)

In short, traditionally the buffered read/write external context is
the only unique one `struct iomap_iter` (`struct iomap_readpage_ctx`
is only for iomap internal use), after your proposal there will be
two external contexts specified by users (.read_folio and .readahead)
but `.iomap_{begin,end}` is unable to get one of them, which is
unlike the current writeback and direct i/o paths (they uses one
external context too.)

Seperate into two contexts works for your use case, but it may
cause issues since future developers have to decide where to
place those new context fields for buffer I/O paths (
`struct iomap_iter` or `struct iomap_read_folio_ctx`), it's still
possible but may cause further churn on the codebase perspective.

That is my minor concern, but my main concern is still `private`
naming.

Thanks,
Gao Xiang


> 
> 
> Thanks,
> Joanne
> 
>>
>> Thanks,
>> Gao Xiang


