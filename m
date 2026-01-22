Return-Path: <linux-fsdevel+bounces-74962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eC9RAjaCcWk1IAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 02:49:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9AF6082C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 02:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4AB46769C2A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 01:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7D31C84D7;
	Thu, 22 Jan 2026 01:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="D+lT7U+u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73025352949
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 01:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769046575; cv=none; b=aDAPhddA6TI6asiKFQ8/NU3Y/R6bc3tZpqIJnGahhXUKOTmiMpyK84cq/1ifE/qXQJm9wArwWYJbRbu/BhOs5cDO8PStM30Yhu+JHNwlqddR+HPwc03fu1lVJJ7kiXmbBYeJ2PWlzQBHNlvZKoLCsqLtxxgp7FYalrQWbpkusRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769046575; c=relaxed/simple;
	bh=lANgwnZBx7uJ6AaFObhUfdRMzyN4cP9tsw8bYmRA5Ho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IUo2wf6AzaOT+lak+MsfYagIQPRV1aogK1BBEjXP8Pqf+R0VNedJ+EBzPiEVGVwX3RswZtlbjJZPDIhMJuCKUsm492IT6IREwQsh1A0KTMJ/pOF8H6xFTO2k7Ln2J8gSRPcQ20kaUuay93I98Qg/tCn0VkRXjJlo6uUku1Gv4Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=D+lT7U+u; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769046568; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=CSbaboWUbbkVLULY+de+RcFIwy5mlcueIjalB3v17S4=;
	b=D+lT7U+uu38NRLgPmTR4zxCSNixZuX99xVnUj31NVA0nUitLhPyqTPsPo63l8KfWc58DtThTM04snwoEKkMALzfMjwfJzo8cqc//jeuI8UCU/t6AXcRLoztrn4w57+sB09FrPqhLAr0tZufr34ZFip/LzzpJqS6+0Nx60Iiz5w0=
Received: from 30.221.148.85(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WxaUo2a_1769046567 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 22 Jan 2026 09:49:28 +0800
Message-ID: <e9bbebb4-83e2-4ded-9def-7ad2fdb54c9e@linux.alibaba.com>
Date: Thu, 22 Jan 2026 09:49:26 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] fuse: use DIV_ROUND_UP() for page count
 calculations
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
References: <20260116235606.2205801-1-joannelkoong@gmail.com>
 <20260116235606.2205801-2-joannelkoong@gmail.com>
 <2295ba7e-b830-4177-bccb-250fca11b142@linux.alibaba.com>
 <CAJnrk1Y1SkEgEjsJx9Ya4N2Nso08ic+J1PUzYySiyj=MR1ofKA@mail.gmail.com>
 <CAJnrk1YNmN1rcZ8sa8SHzBt-M1AcO9bsQv1090W=po+vFVMr5g@mail.gmail.com>
 <90a1bb2f-3c21-4ab8-86e8-b94677c0976b@linux.alibaba.com>
 <CAJnrk1Z-cSywcZ+0LyEb_tNWZRTLrHjFMSGSJPzNO4EqK4wozA@mail.gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAJnrk1Z-cSywcZ+0LyEb_tNWZRTLrHjFMSGSJPzNO4EqK4wozA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-8.96 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74962-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linux.alibaba.com,none];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jefflexu@linux.alibaba.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,alibaba.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim]
X-Rspamd-Queue-Id: 6E9AF6082C
X-Rspamd-Action: no action



On 1/22/26 5:59 AM, Joanne Koong wrote:
> On Tue, Jan 20, 2026 at 7:21 PM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>
>> Hi Joanne,
>>
>> Thanks for the replying ;)
>>
>> On 1/21/26 4:06 AM, Joanne Koong wrote:
>>> On Tue, Jan 20, 2026 at 11:10 AM Joanne Koong <joannelkoong@gmail.com> wrote:
>>>>
>>>> On Sun, Jan 18, 2026 at 6:12 PM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>>>>
>>>>> On 1/17/26 7:56 AM, Joanne Koong wrote:
>>>>>> Use DIV_ROUND_UP() instead of manually computing round-up division
>>>>>> calculations.
>>>>>>
>>>>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>>>>> ---
>>>>>>  fs/fuse/dev.c  | 6 +++---
>>>>>>  fs/fuse/file.c | 2 +-
>>>>>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>>>>>> index 6d59cbc877c6..698289b5539e 100644
>>>>>> --- a/fs/fuse/dev.c
>>>>>> +++ b/fs/fuse/dev.c
>>>>>> @@ -1814,7 +1814,7 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
>>>>>>
>>>>>>               folio_offset = ((index - folio->index) << PAGE_SHIFT) + offset;
>>>>>>               nr_bytes = min_t(unsigned, num, folio_size(folio) - folio_offset);
>>>>>> -             nr_pages = (offset + nr_bytes + PAGE_SIZE - 1) >> PAGE_SHIFT;
>>>>>> +             nr_pages = DIV_ROUND_UP(offset + nr_bytes, PAGE_SIZE);
>>>>>>
>>>>>>               err = fuse_copy_folio(cs, &folio, folio_offset, nr_bytes, 0);
>>>>>>               if (!folio_test_uptodate(folio) && !err && offset == 0 &&
>>>>>
>>>>> IMHO, could we drop page offset, instead just update the file offset and
>>>>> re-calculate folio index and folio offset for each loop, i.e. something
>>>>> like what [1] did?
>>>>>
>>>>> This could make the code simpler and cleaner.
>>>>
>>>> Hi Jingbo,
>>>>
>>>> I'll break this change out into a separate patch. I agree your
>>>> proposed restructuring of the logic makes it simpler to parse.
>>>>
>>>> Thanks,
>>>> Joanne
>>>>
>>>>>
>>>>> BTW, it seems that if the grabbed folio is newly created on hand and the
>>>>> range described by the store notify doesn't cover the folio completely,
>>>>> the folio won't be set as Uptodate and thus the written data may be
>>>>> missed?  I'm not sure if this is in design.
>>>
>>> (sorry, forgot to respond to this part of your email)
>>>
>>> I think this is intentional. By "thus the written data may be missed",
>>> I think you're talking about the writeback path? My understanding is
>>> it's the dirty bit, not uptodate,
>>
>> Not exactly. What I'm concerned is the uptodate bit.
>>
>> In the case where "the grabbed folio is newly created on hand and the
>> range described by the store notify doesn't cover the folio completely,
>> the folio won't be set as Uptodate", the following read(2) or write(2)
>> on the folio will discard the content already in the folio, instead it
>> triggers .readpage() to fetch data from FUSE server again.
> 
> Could you elaborate on why this concerns you? Isn't this necessary
> behavior given that it needs to fetch the parts that the store notify
> didn't cover? Or is your concern that the contents are discarded? But
> the server already has that information stored on their side, so I'm
> not seeing why that's a problem.
> 

I'm not thinking it as a problem.  As said, I guess it is just a design
constraint for FUSE_NOTIFY_STORE.

Thanks.


-- 
Thanks,
Jingbo


