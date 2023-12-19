Return-Path: <linux-fsdevel+bounces-6492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D0281897F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 15:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 583EB1F25010
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 14:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BC31D556;
	Tue, 19 Dec 2023 14:12:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4101D528;
	Tue, 19 Dec 2023 14:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Vyr8ugS_1702994833;
Received: from 192.168.31.58(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vyr8ugS_1702994833)
          by smtp.aliyun-inc.com;
          Tue, 19 Dec 2023 22:07:14 +0800
Message-ID: <c194c632-5bf9-40ec-ab3b-6ebbd9f199fa@linux.alibaba.com>
Date: Tue, 19 Dec 2023 22:07:12 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mm: fix arithmetic for max_prop_frac when setting
 max_ratio
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
Cc: shr@devkernel.io, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
References: <20231219024246.65654-1-jefflexu@linux.alibaba.com>
 <20231219024246.65654-3-jefflexu@linux.alibaba.com>
 <ZYEWyn5g/jG/ixMk@casper.infradead.org>
 <5460aaf1-44f6-475f-b980-cb9058cc1df4@linux.alibaba.com>
 <ZYGUOslxxwe1sNzR@casper.infradead.org>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <ZYGUOslxxwe1sNzR@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/19/23 9:01 PM, Matthew Wilcox wrote:
> On Tue, Dec 19, 2023 at 01:58:21PM +0800, Jingbo Xu wrote:
>> On 12/19/23 12:06 PM, Matthew Wilcox wrote:
>>> On Tue, Dec 19, 2023 at 10:42:46AM +0800, Jingbo Xu wrote:
>>>>  	} else {
>>>>  		bdi->max_ratio = max_ratio;
>>>> -		bdi->max_prop_frac = (FPROP_FRAC_BASE * max_ratio) / 100;
>>>> +		bdi->max_prop_frac = div64_u64(FPROP_FRAC_BASE * max_ratio,
>>>> +					       100 * BDI_RATIO_SCALE);
>>>>  	}
>>>
>>> Why use div64_u64 here?
>>>
>>> FPROP_FRAC_BASE is an unsigned long.  max_ratio is an unsigned int, so
>>> the numerator is an unsigned long.  BDI_RATIO_SCALE is 10,000, so the
>>> numerator is an unsigned int.  There's no 64-bit arithmetic needed here.
>>
>> Yes, div64_u64() is actually not needed here. So it seems
>>
>> bdi->max_prop_frac = FPROP_FRAC_BASE * max_ratio / 100 / BDI_RATIO_SCALE;
>>
>> is adequate?
> 
> I'd rather spell that as:
> 
> 		bdi->max_prop_frac = (FPROP_FRAC_BASE * max_ratio) /
> 					(100 * BDI_RATIO_SCALE);
> 
> It's closer to how you'd write it out mathematically and so it reads
> more easily.  At least for me.

Thanks, I would send v3 soon.

-- 
Thanks,
Jingbo

