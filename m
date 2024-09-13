Return-Path: <linux-fsdevel+bounces-29271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 301E8977667
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 03:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6388E1C234CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 01:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B398A5228;
	Fri, 13 Sep 2024 01:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BuTH+Cqm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39604A06;
	Fri, 13 Sep 2024 01:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726190723; cv=none; b=l5YUuQfzAbK6Wx8PtwXBjJ9mrG/yg5jyxsag95/sg2oV0PAzPRcF0lqtyxAkvGvQ8Ia55xYAgbc61dCOThr+Zwq2A5KJSeDjTAMPZ1NSyeOC/3HeSEDaRiLm2cw+NfRvW6vQ3v25Zhdc01x5PSNT7x0Ukz+8BxoGal8nDnnMXMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726190723; c=relaxed/simple;
	bh=eiUizTWYb3R75gtwRcaE685TMRMQQ3cX7DcC/rF1grI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MtUPfCxzcaqpeskLWgT0HbxgfVmNLTf84KJrWBzRjxSOitSr+AS5c8he/cjI6BjN/hwGvSr4IVYJleiVyAv11WbQrjvnp2puxpRTjwspnqFyMYvbCGiLp7kmZDY0MXTxSZyOVKzFh44rXLIvib7Bi4xQ/Q6I0j0TAZaCYuyhdtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BuTH+Cqm; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726190717; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=bT7Ehu308cTbhhm8mjO8oPSFI42XJ/7qjVWe+08lwuE=;
	b=BuTH+CqmAS1JIJ6L5yWk9xZuGGiVEXnujN6va2twzgTmznANc8dHx9Y0wbV6sAI4UvBHO7T/XclVtC0XX4kkvOIzwn9l0L8mimFNH1FLznVNLUkItKyIoptjRRnqZ6Prv55+9B50pwjKkASlFngJ6qIOnSlZp1pMzgkIgIoco8s=
Received: from 30.221.145.1(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WEsnkWg_1726190715)
          by smtp.aliyun-inc.com;
          Fri, 13 Sep 2024 09:25:16 +0800
Message-ID: <67cdcde3-1095-41cc-9d99-a0b97274d7be@linux.alibaba.com>
Date: Fri, 13 Sep 2024 09:25:13 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [HELP] FUSE writeback performance bottleneck
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
 Bernd Schubert <bernd.schubert@fastmail.fm>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 lege.wang@jaguarmicro.com, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <495d2400-1d96-4924-99d3-8b2952e05fc3@linux.alibaba.com>
 <67771830-977f-4fca-9d0b-0126abf120a5@fastmail.fm>
 <CAJfpeguts=V9KkBsMJN_WfdkLHPzB6RswGvumVHUMJ87zOAbDQ@mail.gmail.com>
 <bd49fcba-3eb6-4e84-a0f0-e73bce31ddb2@linux.alibaba.com>
 <CAJfpegsfF77SV96wvaxn9VnRkNt5FKCnA4mJ0ieFsZtwFeRuYw@mail.gmail.com>
 <ffca9534-cb75-4dc6-9830-fe8e84db2413@linux.alibaba.com>
 <2f834b5c-d591-43c5-86ba-18509d77a865@fastmail.fm>
 <CAJfpegt_mEYOeeTo2bWS3iJfC38t5bf29mzrxK68dhMptrgamg@mail.gmail.com>
 <e7a54ce3-7905-4e70-a824-f48a112c1924@linux.alibaba.com>
 <CAJnrk1bTt7r1hfkp6oA3-_x3ixEd_qKb8Kkxrugv8XOOJz7U4Q@mail.gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAJnrk1bTt7r1hfkp6oA3-_x3ixEd_qKb8Kkxrugv8XOOJz7U4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/13/24 8:00 AM, Joanne Koong wrote:
> On Thu, Aug 22, 2024 at 8:34 PM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>
>> On 6/4/24 6:02 PM, Miklos Szeredi wrote:
>>> On Tue, 4 Jun 2024 at 11:32, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>>>
>>>> Back to the background for the copy, so it copies pages to avoid
>>>> blocking on memory reclaim. With that allocation it in fact increases
>>>> memory pressure even more. Isn't the right solution to mark those pages
>>>> as not reclaimable and to avoid blocking on it? Which is what the tmp
>>>> pages do, just not in beautiful way.
>>>
>>> Copying to the tmp page is the same as marking the pages as
>>> non-reclaimable and non-syncable.
>>>
>>> Conceptually it would be nice to only copy when there's something
>>> actually waiting for writeback on the page.
>>>
>>> Note: normally the WRITE request would be copied to userspace along
>>> with the contents of the pages very soon after starting writeback.
>>> After this the contents of the page no longer matter, and we can just
>>> clear writeback without doing the copy.
>>
>> OK this really deviates from my previous understanding of the deadlock
>> issue.  Previously I thought *after* the server has received the WRITE
>> request, i.e. has copied the request and page content to userspace, the
>> server needs to allocate some memory to handle the WRITE request, e.g.
>> make the data persistent on disk, or send the data to the remote
>> storage.  It is the memory allocation at this point that actually
>> triggers a memory direct reclaim (on the FUSE dirty page) and causes a
>> deadlock.  It seems that I misunderstand it.
> 
> I think your previous understanding is correct (or if not, then my
> understanding of this is incorrect too lol).
> The first write request makes it to userspace and when the server is
> in the middle of handling it, a memory reclaim is triggered where
> pages need to be written back. This leads to a SECOND write request
> (eg writing back the pages that are reclaimed) but this second write
> request will never be copied out to userspace because the server is
> stuck handling the first write request and waiting for the page
> reclaim bits of the reclaimed pages to be unset, but those reclaim
> bits can only be unset when the pages have been copied out to
> userspace, which only happens when the server reads /dev/fuse for the
> next request.

Right, that's true.

> 
>>
>> If that's true, we can clear PF_writeback as long as the whole request
>> along with the page content has already been copied to userspace, and
>> thus eliminate the tmp page copying.
>>
> 
> I think the problem is that on a single-threaded server,  the pages
> will not be copied out to userspace for the second request (aka
> writing back the dirty reclaimed pages) since the server is stuck on
> the first request.

Agreed.


-- 
Thanks,
Jingbo

