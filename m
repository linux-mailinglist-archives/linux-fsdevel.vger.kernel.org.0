Return-Path: <linux-fsdevel+bounces-74580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1332FD3C08F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 08:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B119D504B37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 07:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DB0396B97;
	Tue, 20 Jan 2026 07:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="V7GJRzwn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4738639524E;
	Tue, 20 Jan 2026 07:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768893577; cv=none; b=L+0ksdn7a0+LQKUCufhnFaOvHENHNB96XPtIwDTPXo/fxNPUImOx4VeTWcky1SV70dRehDM7ghuBl/+125ng7E967MeLiVwsCqb5cc712bAEmWkibhEiSz4BlNZ2KG3ueWOe1lFRvbtwWgdWFKGvm7sYL3UvUx7NuQIyUIKzeis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768893577; c=relaxed/simple;
	bh=EJeU6X/qHTcXu/Pq4el5N67uZM74H8EpHgmxyhHClU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IN9R1NeGQdKFP+uo8/3CvfntY0NfNoOq/mIzijkQsu7nBP2EOaLCEeFrc5zzOgnVinf7gBJ4A/c4KtTdw64I10o5p/p3e2PdGbNiM6zX/vtd8pi4fkW6CwlvICzOqkAFfH3ObZNtbOa0wXok+h0H3V5eni0ph07NnULN+PescRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=V7GJRzwn; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768893564; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=IgKaAzP8aAUp7Q4dUR0XSmPEfcD1EN7TQ/AQjpmO9tw=;
	b=V7GJRzwnOC7jwGmwSBKRJHyRv0jeGJTjW5uB1pXyJY34G2RKVC2FNNAU0776VOThrXJUjVCFhBdM/0TW3gtlaRx7uA7BbnAGeZ/+c8PDOshFH/esnU+445Dki7tygqUyrBwa40TpaOhLi29CzJaVBvddyjTA9dsJlmUnSwKel4A=
Received: from 30.221.131.31(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WxTW.ah_1768893562 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 20 Jan 2026 15:19:23 +0800
Message-ID: <5892c7bb-f06e-45d7-ad84-99837788e5ab@linux.alibaba.com>
Date: Tue, 20 Jan 2026 15:19:21 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 5/9] erofs: introduce the page cache share feature
To: Christoph Hellwig <hch@lst.de>
Cc: Hongbo Li <lihongbo22@huawei.com>, chao@kernel.org, djwong@kernel.org,
 amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Christian Brauner <brauner@kernel.org>, oliver.yang@linux.alibaba.com
References: <20260116095550.627082-6-lihongbo22@huawei.com>
 <20260116154623.GC21174@lst.de>
 <af1f3ff6-a163-4515-92bf-44c9cf6c92f3@linux.alibaba.com>
 <20260119072932.GB2562@lst.de>
 <8e30bc4b-c97f-4ab2-a7ce-27f399ae7462@linux.alibaba.com>
 <20260119083251.GA5257@lst.de>
 <b29b112e-5fe1-414b-9912-06dcd7d7d204@linux.alibaba.com>
 <20260119092220.GA9140@lst.de>
 <73f2c243-e029-4f95-aa8e-285c7affacac@linux.alibaba.com>
 <50db56b8-4cf9-4d62-b242-c982a260a330@linux.alibaba.com>
 <20260120065242.GA3436@lst.de>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260120065242.GA3436@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Thanks for the reply.

On 2026/1/20 14:52, Christoph Hellwig wrote:
> On Tue, Jan 20, 2026 at 11:07:48AM +0800, Gao Xiang wrote:
>>
>> Hi Christoph,
>>
>> Sorry I didn't phrase things clearly earlier, but I'd still
>> like to explain the whole idea, as this feature is clearly
>> useful for containerization. I hope we can reach agreement
>> on the page cache sharing feature: Christian agreed on this
>> feature (and I hope still):
>>
>> https://lore.kernel.org/linux-fsdevel/20260112-begreifbar-hasten-da396ac2759b@brauner
> 
> He has to ultimatively decide.  I do have an uneasy feeling about this.
> It's not super informed as I can keep up, and I'm not the one in charge,
> but I hope it is helpful to share my perspective.
> 
>> First, let's separate this feature from mounting in user
>> namespaces (i.e., unprivileged mounts), because this feature
>> is designed specifically for privileged mounts.
> 
> Ok.
> 
>> The EROFS page cache sharing feature stems from a current
>> limitation in the page cache: a file-based folio cannot be
>> shared across different inode mappings (or the different
>> page index within the same mapping; If this limitation
>> were resolved, we could implement a finer-grained page
>> cache sharing mechanism at the folio level). As you may
>> know, this patchset dates back to 2023,
> 
> I didn't..
> 
>> and as of 2026; I
>> still see no indication that the page cache infra will
>> change.
> 
> It will be very hard to change unless we move to physical indexing of
> the page cache, which has all kinds of downside.s

I'm not sure if it's really needed: I think the final
folio adaption plan is that folio can be dynamic
allocated? then why not keep multiple folios for a
physical memory, since folios are not order-0 anymore.

Using physical indexing sounds really inflexible on my
side, and it can be even regarded as a regression for me.

> 
>> So that let's face the reality: this feature introduces
>> on-disk xattrs called "fingerprints." --- Since they're
>> just xattrs, the EROFS on-disk format remains unchanged.
> 
> I think the concept of using a backing file of some sort for the shared
> pagecache (which I have no problem with at all), vs the imprecise

In that way (actually Jingbo worked that approach in 2023),
we have to keep the shared data physically contiguous and
even uncompressed, which cannot work for most cases.

On the other side, I do think `fingerprint` from design
is much like persistent NFS file handles in some aspect
(but I don't want to equal to that concept, but very
similar) for a single trusted domain, we should have to
deal with multiple filesystem sources and mark in a
unique way in a domain.

> selection through a free form fingerprint are quite different aspects,
> that could be easily separated.  I.e. one could easily imagine using
> the data path approach based purely on exact file system metadata.
> But that would of course not work with multiple images, which I think
> is a key feature here if I'm reading between the lines correctly.

EROFS works as golden immutable images, so especially,
remote filesystem images can and will only be used without
any modification.

So we have to deal with multiple filesystems on the same
machine, otherwise, _hardlinks_ in a single filesystem can
resolve most issues for page cache sharing, but that is not
our intention.

> 
>>   - Let's not focusing entirely on the random human bugs,
>>     because I think every practical subsystem should have bugs,
>>     the whole threat model focuses on the system design, and
>>     less code doesn't mean anything (buggy or even has system
>>     design flaw)
> 
> Yes, threats through malicious actors are much more intereating
> here.

Yes, otherwise we fail into endless meaningless rust and
code line comparsion without any useful real system
design part.

> 
>>   - EROFS only accesses the (meta)data from the source blobs
>>     specified at mount time, even with multi-device support:
>>
>>      mount -t erofs -odevice=[blob],device=[blob],... [source]
> 
> That is an important part that wasn't fully clear to me.

Okay,

Thanks,
Gao Xiang



