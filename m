Return-Path: <linux-fsdevel+bounces-6477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8BC81814D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 07:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D3F4B23C1B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 06:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25B2C158;
	Tue, 19 Dec 2023 06:03:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC16C123;
	Tue, 19 Dec 2023 06:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Vypj0Vc_1702965501;
Received: from 30.221.145.29(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vypj0Vc_1702965501)
          by smtp.aliyun-inc.com;
          Tue, 19 Dec 2023 13:58:22 +0800
Message-ID: <5460aaf1-44f6-475f-b980-cb9058cc1df4@linux.alibaba.com>
Date: Tue, 19 Dec 2023 13:58:21 +0800
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
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <ZYEWyn5g/jG/ixMk@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/19/23 12:06 PM, Matthew Wilcox wrote:
> On Tue, Dec 19, 2023 at 10:42:46AM +0800, Jingbo Xu wrote:
>>  	} else {
>>  		bdi->max_ratio = max_ratio;
>> -		bdi->max_prop_frac = (FPROP_FRAC_BASE * max_ratio) / 100;
>> +		bdi->max_prop_frac = div64_u64(FPROP_FRAC_BASE * max_ratio,
>> +					       100 * BDI_RATIO_SCALE);
>>  	}
> 
> Why use div64_u64 here?
> 
> FPROP_FRAC_BASE is an unsigned long.  max_ratio is an unsigned int, so
> the numerator is an unsigned long.  BDI_RATIO_SCALE is 10,000, so the
> numerator is an unsigned int.  There's no 64-bit arithmetic needed here.

Yes, div64_u64() is actually not needed here. So it seems

bdi->max_prop_frac = FPROP_FRAC_BASE * max_ratio / 100 / BDI_RATIO_SCALE;

is adequate?

-- 
Thanks,
Jingbo

