Return-Path: <linux-fsdevel+bounces-61149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CBDB559F7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 01:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72C13580738
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 23:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FF228469E;
	Fri, 12 Sep 2025 23:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wiatbwaE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDEA280A2F;
	Fri, 12 Sep 2025 23:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757719261; cv=none; b=BRyyMrNixA4ENgV3+SScvi1JB6hAtzsXdX8hGii6gkKpoA6ruMGcxS8AjngikIMkQHPa4GCW33MRXAD1JZ/e6PCxjkh5VkdurutRdEPdImkM4E46PJCPZ6Y5PLf/4cyi6Lp2+JClXY10/YgjdHxDz7iKjOOo2jYdsrS7f6TuPDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757719261; c=relaxed/simple;
	bh=LMgjFCFXS7lWqAMsP0k6ElrXCn4PbmCAQ9cG/JltHiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qp3zxXgp8hbiX+WVxtfM1eLO5TkNriVv35GiuVSO9b6Ky7SHkxvsGluPwbFgtzfkxMf0KzuMYqoSLLaxXF96nFK6dS0/MeS2orst0adsayd+hA5eLzntvZVBGSPEmOfnkz3pjc1tfirrPvSN6a3Sv+oOafZrgDJzCTmXwMGqwGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wiatbwaE; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757719249; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=0O+HEt4GxNAVHjkomsoPJNj9dN5Mu9s+azTdTAvcdIQ=;
	b=wiatbwaECKg8LhzmLa4Yl6IgFgxSWcq0JlJrkZfRu1nQuEmYkoCxL6s6PCKbqP1RJq5RT+p9gdHG4bnva0EHW/HYIHMxrbFjsLWxY5XWPhf31vxOX57HsGSm51HRIcPIcljvJ2UAcI6/zlWE5hDFy9SQS7gyS1QK+502Op/RVks=
Received: from 30.180.0.242(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wns48bz_1757719247 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 13 Sep 2025 07:20:48 +0800
Message-ID: <dd0ea3a4-5e2e-4dc3-8cba-94dfdec06d17@linux.alibaba.com>
Date: Sat, 13 Sep 2025 07:20:46 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/16] iomap: move read/readahead logic out of
 CONFIG_BLOCK guard
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org,
 miklos@szeredi.hu, djwong@kernel.org, linux-block@vger.kernel.org,
 gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
 linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-14-joannelkoong@gmail.com>
 <a1529c0f-1f1a-477a-aeeb-a4f108aab26b@linux.alibaba.com>
 <CAJnrk1aCCqoOAgcPUpr+Z09DhJ5BAYoSho5dveGQKB9zincYSQ@mail.gmail.com>
 <0b33ab17-2fc0-438f-95aa-56a1d20edb38@linux.alibaba.com>
 <aMK0lC5iwM0GWKHq@infradead.org>
 <9c104881-f09e-4594-9e41-0b6f75a5308c@linux.alibaba.com>
 <CAJnrk1b2_XGfMuK-UAej31TtCAAg5Aq8PFS_36yyGg8NerA97g@mail.gmail.com>
 <6609e444-5210-42aa-b655-8ed8309aae75@linux.alibaba.com>
 <66971d07-2c1a-4632-bc9e-e0fc0ae2bd04@linux.alibaba.com>
 <267abd34-2337-4ae3-ae95-5126e9f9b51c@linux.alibaba.com>
 <CAJnrk1Y31b-Yr03rN8SXPmUA7D6HW8OhnkfFOebn56z57egDOw@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAJnrk1Y31b-Yr03rN8SXPmUA7D6HW8OhnkfFOebn56z57egDOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/9/13 03:56, Joanne Koong wrote:
> On Thu, Sep 11, 2025 at 9:11 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>> On 2025/9/12 09:09, Gao Xiang wrote:
>>>
>>>
>>> On 2025/9/12 08:06, Gao Xiang wrote:
>>>>
>>>>
>>>> On 2025/9/12 03:45, Joanne Koong wrote:
>>>>> On Thu, Sep 11, 2025 at 8:29 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>>>
>>>>>> But if FUSE or some other fs later needs to request L2P information
>>>>>> in their .iomap_begin() and need to send L2P requests to userspace
>>>>>> daemon to confirm where to get the physical data (maybe somewhat
>>>>>> like Darrick's work but I don't have extra time to dig into that
>>>>>> either) rather than just something totally bypass iomap-L2P logic
>>>>>> as above, then I'm not sure the current `iomap_iter->private` is
>>>>>> quite seperate to `struct iomap_read_folio_ctx->private`, it seems
>>>>>
>>>>> If in the future this case arises, the L2P mapping info is accessible
>>>>> by the read callback in the current design. `.read_folio_range()`
>>>>> passes the iomap iter to the filesystem and they can access
>>>>> iter->private to get the L2P mapping data they need.
>>>>
>>>> The question is what exposes to `iter->private` then, take
>>>> an example:
>>>>
>>>> ```
>>>> struct file *file;
>>>> ```
>>>>
>>>> your .read_folio_range() needs `file->private_data` to get
>>>> `struct fuse_file` so `file` is kept into
>>>> `struct iomap_read_folio_ctx`.
>>>>
>>>> If `file->private_data` will be used for `.iomap_begin()`
>>>> as well, what's your proposal then?
>>>>
>>>> Duplicate the same `file` pointer in both
>>>> `struct iomap_read_folio_ctx` and `iter->private` context?
>>>
>>> It's just an not-so-appropriate example because
>>> `struct file *` and `struct fuse_file *` are widely used
>>> in the (buffer/direct) read/write flow but Darrick's work
>>> doesn't use `file` in .iomap_{begin/end}.
>>>
>>> But you may find out `file` pointer is already used for
>>> both FUSE buffer write and your proposal, e.g.
>>>
>>> buffer write:
>>>    /*
>>>     * Use iomap so that we can do granular uptodate reads
>>>     * and granular dirty tracking for large folios.
>>>     */
>>>    written = iomap_file_buffered_write(iocb, from,
>>>                                        &fuse_iomap_ops,
>>>                                        &fuse_iomap_write_ops,
>>>                                        file);
>>
>> And your buffer write per-fs context seems just use
>> `iter->private` entirely instead to keep `file`.
>>
> 
> I don’t think the iomap buffered writes interface is good to use as a
> model. I looked a bit at some of the other iomap file operations and I
> think we should just pass operation-specific data through an
> operation-specific context for those too, eg for buffered writes and
> dio modifying the interface from
> 
> ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter
> *from, const struct iomap_ops *ops, const struct iomap_write_ops
> *write_ops, void *private);
> ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter, const
> struct iomap_ops *ops, const struct iomap_dio_ops *dops, unsigned int
> dio_flags, void *private, size_t done_before);
> 
> to something like
> 
> ssize_t iomap_file_buffered_write(const struct iomap_ops *ops, struct
> iomap_write_folio_ctx *ctx);
> ssize_t iomap_dio_rw(const struct iomap_ops *ops, struct iomap_dio_ctx *ctx);
> 
> There’s one filesystem besides fuse that uses “iter->private” and
> that’s for xfs zoned inodes (xfs_zoned_buffered_write_iomap_begin()),
> which passes the  struct xfs_zone_alloc_ctx*  through iter->private,
> and it's used afaict for tracking block reservations. imo that's what
> iter->private should be used for, to track the more high level
> metadata stuff and then the lower-level details that are
> operation-specific go through the ctx->data fields. That seems the
> cleanest design to me. I think we should rename the iter->private
> field to something like "iter->metadata" to make that delineation more
> clear.  I'm not sure what the iomap maintainers think, but that is my
> opinion.

In short, I don't think new "low-level" and "high-level" concepts are
really useful even for disk fses.

> 
> I think if in the future there is a case/feature which needs something
> previously in one of the operation-specific ctxes, it seems fine to me
> to have both iter->private and ctx->data point to the same thing.
> 

I want to stop this topic here, it's totally up to iomap maintainers to
decide what's the future iomap looks like but I still keep my strong
reserve opinion (you can ignore) from my own code design taste.

Thanks,
Gao Xiang

> 
> Thanks,
> Joanne

