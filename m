Return-Path: <linux-fsdevel+bounces-60037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5918EB4121A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 03:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E03D83BDA4B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 01:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1C91E51E0;
	Wed,  3 Sep 2025 01:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="V1M1ooch"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DE021348;
	Wed,  3 Sep 2025 01:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756864552; cv=none; b=itTRYVkNVSDXg3wQYPi/STs0dEnpaLgmx5W/PDdCct7WABuvrtAeiOfimqilyudSX/neJy2q91YZApt3ljlFVIs2QeO8f6CdIajdqf111gaPc+sJM9GmNrz4HaDQSV3tXpGCEnDTlkTTQtKeYihQTOGSDFW5jsBJyyjbCbhOuQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756864552; c=relaxed/simple;
	bh=8wbRuDoihyJUmAI0SMAtjDn6KHUYRibWnsdY5aNbL70=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nbZ3XHzrcM75i7RcaR+gL+hokZ9oX+K59/SHTkfHQWFNloWWx1ybqPodrmHdvLWNP2w1umRHSlcQxBCAGTWj8S41SITuXkaYrYZeE+n5tOfPk0PMCTIASZPbNIQ19ALseLhipVcEvcziBfyP9ufWfThFJITwKUxUIJKM8bkn9oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=V1M1ooch; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756864540; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/QhKN4OvytjwdMcxJKSJfAprTsFXiQ4abK0ebfn9MfI=;
	b=V1M1oochtlP/hC8cQ8KyrFkTzdCCY1l8skblrvjOjFbDnVnq0HD0E3G39V6L2CRHTrkMeR/flhkl9+xipjbTJdUAxVqqz4XUvtv2e5QcA6F+xZAibIkqHXSLXW3JWz01FWjz5gopjH6ZNyMYQnSuh1oePgqIQCpyjfAkUsiU4fY=
Received: from 30.221.131.35(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wn9fORf_1756864539 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Sep 2025 09:55:40 +0800
Message-ID: <a44fd64d-e0b1-4131-9d71-2d36151c90f4@linux.alibaba.com>
Date: Wed, 3 Sep 2025 09:55:37 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 13/16] iomap: add a private arg for read and readahead
To: Joanne Koong <joannelkoong@gmail.com>, brauner@kernel.org,
 miklos@szeredi.hu, hch@infradead.org, djwong@kernel.org,
 linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
 linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
 <20250829235627.4053234-14-joannelkoong@gmail.com> <aLJZv5L6q0FH5F8a@debian>
 <CAJnrk1af4-FG==X=4LzoBRaxL9N-hnh1i-zx89immQZMLKSzyQ@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAJnrk1af4-FG==X=4LzoBRaxL9N-hnh1i-zx89immQZMLKSzyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/9/3 05:24, Joanne Koong wrote:
> On Fri, Aug 29, 2025 at 6:54 PM Gao Xiang <xiang@kernel.org> wrote:
>>
>> Hi Joanne,
>>
>> On Fri, Aug 29, 2025 at 04:56:24PM -0700, Joanne Koong wrote:
>>> Add a void *private arg for read and readahead which filesystems that
>>> pass in custom read callbacks can use. Stash this in the existing
>>> private field in the iomap_iter.
>>>
>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>> ---
>>>   block/fops.c           | 4 ++--
>>>   fs/erofs/data.c        | 4 ++--
>>>   fs/gfs2/aops.c         | 4 ++--
>>>   fs/iomap/buffered-io.c | 8 ++++++--
>>>   fs/xfs/xfs_aops.c      | 4 ++--
>>>   fs/zonefs/file.c       | 4 ++--
>>>   include/linux/iomap.h  | 4 ++--
>>>   7 files changed, 18 insertions(+), 14 deletions(-)
>>>
>>
>> ...
>>
>>>   int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops,
>>> -             const struct iomap_read_ops *read_ops)
>>> +             const struct iomap_read_ops *read_ops, void *private)
>>>   {
>>>        struct iomap_iter iter = {
>>>                .inode          = folio->mapping->host,
>>>                .pos            = folio_pos(folio),
>>>                .len            = folio_size(folio),
>>> +             .private        = private,
>>>        };
>>
>> Will this whole work be landed for v6.18?
>>
>> If not, may I ask if this patch can be shifted advance in this
>> patchset for applying separately (I tried but no luck).
>>
>> Because I also need some similar approach for EROFS iomap page
>> cache sharing feature since EROFS uncompressed I/Os go through
>> iomap and extra information needs a proper way to pass down to
>> iomap_{begin,end} with extra pointer `.private` too.
> 
> Hi Gao,
> 
> I'm not sure whether this will be landed for v6.18 but I'm happy to
> shift this patch to the beginning of the patchset for applying
> separately.

Yeah, thanks.  At least this common patch can be potentially applied
easily (e.g. form a common commit id for both features if really
needed) since other iomap/FUSE patches are not dependency of our new
feature and shouldn't be coupled with our development branch later.

Thanks,
Gao Xiang

> 
> Thanks,
> Joanne
>>
>> Thanks,
>> Gao Xiang


