Return-Path: <linux-fsdevel+bounces-20947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1CD8FB213
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 14:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41CE6283A27
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 12:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD439146001;
	Tue,  4 Jun 2024 12:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IUAkFt/b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E614BE7F;
	Tue,  4 Jun 2024 12:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717503854; cv=none; b=XsSnAr0Y+y2+8WYuGIgFaOGosPXX/WLanq17zO96whxtDg53kQv/VGBhO63WoEEFFyjKsxuq8z6mDfaPrhYkeDYNIqrk/I9digKbjxUrYV5RYfBSFHQPVYedqIMt+3LKHq2lf/3q0JmacXQdlW0Qh3t8aIwRIvwFg3DJqGXUykw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717503854; c=relaxed/simple;
	bh=ZwDWpEgrdrXqFWIrKyzELQzl+gwfit0FDORF0fNWeD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KbkbeH1QhKOgAjOHH8IrJfsM2Ln766InrPxNYf9gHfetsxpGNsGR34WpE9qOreUyI5w/aizMNt+h9Sey9rK6A9LxIumIH323I9/g/um0fjUsjSz63HbChyo1uFhmIb1JRQHUc/f/s7Xj1IX6wjhrJIYOx84mpMuCmXxjnLRtoQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IUAkFt/b; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717503848; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=jPomrUN2mMhHCZSoHA6BXf+LpnTjctPJaYag2ZL8SMk=;
	b=IUAkFt/bTF3gb3tAXx3JmuVtVDo3marrDBmm4vhLI/WLvR/nVXPjsDZupw1M2k3b5+jB61GNF1iJRTBcN9D542M5ILiHBKTZU2uVPpUhVLTEuy02bJCmLQ0BFlm+PkY0588+bv1ITtEZQ8DKKJAt4DHkyItISeE7zzW8kD+xKaU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W7r4iPR_1717503847;
Received: from 30.221.146.134(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W7r4iPR_1717503847)
          by smtp.aliyun-inc.com;
          Tue, 04 Jun 2024 20:24:08 +0800
Message-ID: <cc2ca6ec-191f-4b30-85f4-b3fc6ddd7323@linux.alibaba.com>
Date: Tue, 4 Jun 2024 20:24:06 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [HELP] FUSE writeback performance bottleneck
To: Bernd Schubert <bernd.schubert@fastmail.fm>,
 Miklos Szeredi <miklos@szeredi.hu>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
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
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <2f834b5c-d591-43c5-86ba-18509d77a865@fastmail.fm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/4/24 5:32 PM, Bernd Schubert wrote:
> 
> 
> On 6/4/24 09:36, Jingbo Xu wrote:
>>
>>
>> On 6/4/24 3:27 PM, Miklos Szeredi wrote:
>>> On Tue, 4 Jun 2024 at 03:57, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>>
>>>> IIUC, there are two sources that may cause deadlock:
>>>> 1) the fuse server needs memory allocation when processing FUSE_WRITE
>>>> requests, which in turn triggers direct memory reclaim, and FUSE
>>>> writeback then - deadlock here
>>>
>>> Yep, see the folio_wait_writeback() call deep in the guts of direct
>>> reclaim, which sleeps until the PG_writeback flag is cleared.  If that
>>> happens to be triggered by the writeback in question, then that's a
>>> deadlock.
>>>
>>>> 2) a process that trigfgers direct memory reclaim or calls sync(2) may
>>>> hang there forever, if the fuse server is buggyly or malicious and thus
>>>> hang there when processing FUSE_WRITE requests
>>>
>>> Ah, yes, sync(2) is also an interesting case.   We don't want unpriv
>>> fuse servers to be able to block sync(2), which means that sync(2)
>>> won't actually guarantee a synchronization of fuse's dirty pages.  I
>>> don't think there's even a theoretical solution to that, but
>>> apparently nobody cares...
>>
>> Okay if the temp page design is unavoidable, then I don't know if there
>> is any approach (in FUSE or VFS layer) helps page copy offloading.  At
>> least we don't want the writeback performance to be limited by the
>> single writeback kworker.  This is also the initial attempt of this thread.
>>
> 
> Offloading it to another thread is just a workaround, though maybe a
> temporary solution.

If we could break the limit that only one single (writeback) kworker for
one bdi... Apparently it's much more complicated.  Just a brainstorming
idea...

I agree it's a tough thing.

-- 
Thanks,
Jingbo

