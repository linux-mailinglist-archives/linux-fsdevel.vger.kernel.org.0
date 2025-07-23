Return-Path: <linux-fsdevel+bounces-55779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFC2B0EAF5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 08:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D62901AA5FA5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 06:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D55A26F463;
	Wed, 23 Jul 2025 06:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H0X7b5lP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7630B26E718
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 06:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753253425; cv=none; b=QgebxTZbLSM9IrpsC9B/eHnyxgiMWIDZlLepcoZLsADZ0LtzA+lH+C8Uytga8kuyY4JoGnNMY0t7rySO2yrn6b2x5yPuNcHkTKkkqsXcoLjhWe9f+2EZRKsCr5IRiAhMDZhu0wqzZI7DwDNVjUfqSNsIJNPL+7qQw+w08uQbmWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753253425; c=relaxed/simple;
	bh=oPy6t+1RaeFbH/aJLu65e5pAbF2TBLlZiCfDemUC2QY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=la/sVjrf4sqO8vqpl4P3nMCuRY/5XY+toaaQFUjOcJKSfZqauU+OK0x1vNOlyIgkrf/DiqDcufOBYDDsP1qkd44puwGXAmpGwuZ000SVKJFbyQSzm3DzeEnIxApE5lMxaTw/rAkkaBfpSvoR3tE8ouLuD8mJ/Uogy17MI9rur7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H0X7b5lP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MMOZG2011036
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 06:50:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vIOnuFzxTaTZ2kZliUHt8+E+wNhpF1ajP7gxvaOKN9M=; b=H0X7b5lPIbttHQUa
	/nd3/wGmu1spel9ls30pCGoB6/MjAMVzvOBeEgRkJmgucsYZ9KmcB7RrjkoescBO
	ZuUPSdHP0NnPiJqHcsgZ3soWUmVVlIzbDn52ovyGOpxO9DO8BpXjbb2YAsQS0qnx
	O2vmupjs+ym+CInPbVTWrnOKsEGmNlEuiDK+IDc5weDIcvl/TMlaVg01D2HvE3uU
	FBJgr3++dgCMBrT1MZ6taDI2BtMVbQDyeMcvMcR8osiFywF8LcWGZ0dpoVPKeqxh
	5RvAWkl7VVUMRwaU7zPRtZo5uyZ75yRxFLCoMU82r5F7xe9mrUcWbgBmrNUfT2ix
	HtbAUA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 482d3ht5fk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 06:50:21 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-235e1d70d67so61674955ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 23:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753253421; x=1753858221;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vIOnuFzxTaTZ2kZliUHt8+E+wNhpF1ajP7gxvaOKN9M=;
        b=FD3KfGvtsVuqNwxXou6quSTN+3i7v7GfwuONhnesjghCdzziZC9xlucbND+Dv7WgPR
         3Qr779hy8UAu4ZOR/i6rLmnsUMcjQlI4vCcA7hSYxyMzjRJ6W7wyquxCy5WdVOgcXTHZ
         0UjyQaJb333uz6XKdpP+GpPnIaUG2G/xSRJxE6TReEWZmGLKvwVSYVLqHc6bcQYEny7I
         lbKxBxpsK+F9CCAAGICf1T2lsvOoSOa+marDnMsJtyhesdqmnsZ8lJO7x2A9Y/HUVBzV
         +Y5m0kWY3gnK8wWXdMyDyBIQX+OhlktV25hFs+aj8uxwe0OOOO6GC8swWjbcUXA2vBQl
         0vGg==
X-Forwarded-Encrypted: i=1; AJvYcCUdukmR6Es3lDCsrauSWL7moMuGDAMKfwwV/btozJoPVFuj3CVc67M+0FGE+wBerweRbVcYHClAOSmUMl93@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr+afVnm3m3niOKUD++4arRB5BovNh4JGZvJ64PDyCSo9ygrUR
	xM79zxSiHmvgEhn9OqPwPPJyL+uS5sEK/v0qMeT7ESxZbgh9/LZCBWTF+uBk1aGXq5UVGz9ZJgX
	meWZ/uDHQCbRyIyJ6/BP7xdC/fv5nUsjgYedaplZOwQRR67a2++5xdon2hK6aLP0yxgJr
X-Gm-Gg: ASbGncuJ0CWY1TmdLXvqWKnjpFFaPAZyMpkE5qVnUavr4i5LWJCSCTMZjgyUptkVb9a
	vB9UN7oygGe5Uv3Zr3n2E5zpEf/BMmTKo/3DId+RcBAH85LXwB4xxlfcUR3mC51CyVn4SvvdUjU
	qKS/BVuZ2rEIn8hxXRsJxSNZQpvzG+AtCFAxagqqX99JRaPyumu7IIGXWHH9DXGmms1ooA+pCUR
	O5WTt9iRaMLyMUlNn7H4xu3Msf0/CbdpXlk7GqlAARToVVDeSle6S1Sw7dQ7aqv88LAiaqATmlC
	c9SnhV30Q66tVsC43rWU/5tC1+2xtdp2DysBP3a7mQNWIEqnNeymCzcepkOiXbTssKWaxQMggNx
	o+OVj1XJc+42S7PrOS//jUg4ueh+23uw=
X-Received: by 2002:a17:902:d501:b0:235:e71e:a37b with SMTP id d9443c01a7336-23f981aed8emr25652265ad.34.1753253420616;
        Tue, 22 Jul 2025 23:50:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhrXo7D9/2ndR2uk0h1bpQY6uhlrFldB+Iw+IrNA9vaeHEV+mcRPFxDAlq8umwq1DbFFtE3g==
X-Received: by 2002:a17:902:d501:b0:235:e71e:a37b with SMTP id d9443c01a7336-23f981aed8emr25651875ad.34.1753253420102;
        Tue, 22 Jul 2025 23:50:20 -0700 (PDT)
Received: from [10.133.33.45] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e519b1494sm891203a91.4.2025.07.22.23.50.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 23:50:19 -0700 (PDT)
Message-ID: <12a66199-3fe2-49d1-994a-84e4e1d2eba9@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 14:50:15 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Excessive page cache occupies DMA32 memory
To: Robin Murphy <robin.murphy@arm.com>, Greg KH
 <gregkh@linuxfoundation.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Matthew Wilcox <willy@infradead.org>,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        kernel@collabora.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <766ef20e-7569-46f3-aa3c-b576e4bab4c6@collabora.com>
 <aH51JnZ8ZAqZ6N5w@casper.infradead.org>
 <2025072238-unplanted-movable-7dfb@gregkh>
 <91fc0c41-6d25-4f60-9de3-23d440fc8e00@collabora.com>
 <2025072234-cork-unadvised-24d3@gregkh>
 <c93b34ca-1abf-4db0-90f9-3802ac02c25a@arm.com>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <c93b34ca-1abf-4db0-90f9-3802ac02c25a@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=G8UcE8k5 c=1 sm=1 tr=0 ts=6880862d cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=RbrrYmC37znnBZKoEx0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA1NiBTYWx0ZWRfX5jXCBRk3lrlo
 TZTRDntjYCKgdPeInZr9FRM4S22CEyQ+GODg1kleoPGiPdusy5icpwg2omm/hbHE/s8XStA7h5A
 ZAi7l4xDgH+hBhEWWWmc5KjS1KIBpw6ifTqMmCchHKmbNFuGBHcmaaYHS9SI7uO1bKDXmWkBudg
 8rnJsDjQFPjZForSQPTntqnsa4eaBDtY8HCT/dUSyyi69CIPOAPT80Jv5VKHCzhkTk6Xmk0MFek
 vpvyaHDsHNuN0Kryl6mHGyrKoMJH30uvhcZk0o7XF2miizUC01UWXXHq+a7FRrRORi103JTPY4r
 2Wgz2d+n+5p7VhNQkgGPSRGFlGHvscxuf7eJzmH/OaVGuKerDYsVu1QD6eNxzTilOfCm5XGgdUU
 24GjjX5ymlAyVS2fEBlGmrBINuhOqUTpA90+QUWd1pDxrEC1gOChbKq46s5c0oPGWwMP+l88
X-Proofpoint-GUID: iXxdU2zu4W38iuBSCNY08kk4uCkO_HLM
X-Proofpoint-ORIG-GUID: iXxdU2zu4W38iuBSCNY08kk4uCkO_HLM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0 suspectscore=0 priorityscore=1501 clxscore=1011
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230056



On 7/22/2025 6:03 PM, Robin Murphy wrote:
> On 2025-07-22 8:24 am, Greg KH wrote:
>> On Tue, Jul 22, 2025 at 11:05:11AM +0500, Muhammad Usama Anjum wrote:
>>> Adding ath/mhi and dma API developers to the discussion.
>>>
>>> On 7/22/25 10:32 AM, Greg KH wrote:
>>>> On Mon, Jul 21, 2025 at 06:13:10PM +0100, Matthew Wilcox wrote:
>>>>> On Mon, Jul 21, 2025 at 08:03:12PM +0500, Muhammad Usama Anjum wrote:
>>>>>> Hello,
>>>>>>
>>>>>> When 10-12GB our of total 16GB RAM is being used as page cache
>>>>>> (active_file + inactive_file) at suspend time, the drivers fail to allocate
>>>>>> dma memory at resume as dma memory is either occupied by the page cache or
>>>>>> fragmented. Example:
>>>>>>
>>>>>> kworker/u33:5: page allocation failure: order:7, mode:0xc04(GFP_NOIO|GFP_DMA32),
>>>>>> nodemask=(null),cpuset=/,mems_allowed=0
>>>>>
>>>>> Just to be clear, this is not a page cache problem.  The driver is asking
>>>>> us to do a 512kB allocation without doing I/O!  This is a ridiculous
>>>>> request that should be expected to fail.
>>>>>
>>>>> The solution, whatever it may be, is not related to the page cache.
>>>>> I reject your diagnosis.  Almost all of the page cache is clean and
>>>>> could be dropped (as far as I can tell from the output below).
>>>>>
>>>>> Now, I'm not too familiar with how the page allocator chooses to fail
>>>>> this request.  Maybe it should be trying harder to drop bits of the page
>>>>> cache.  Maybe it should be doing some compaction.
>>> That's very thoughtful. I'll look at the page allocator why isn't it dropping
>>> cache or doing compaction.
>>>
>>>>> I am not inclined to
>>>>> go digging on your behalf, because frankly I'm offended by the suggestion
>>>>> that the page cache is at fault.
>>> I apologize—that wasn't my intention.
>>>
>>>>>
>>>>> Perhaps somebody else will help you, or you can dig into this yourself.
>>>>
>>>> I'm with Matthew, this really looks like a driver bug somehow.  If there
>>>> is page cache memory that is "clean", the driver should be able to
>>>> access it just fine if really required.
>>>>
>>>> What exact driver(s) is having this problem?  What is the exact error,
>>>> and on what lines of code?
>>> The issue occurs on both ath11k and mhi drivers during resume, when
>>> dma_alloc_coherent(GFP_KERNEL) fails and returns -ENOMEM. This failure has
>>> been observed at multiple points in these drivers.
>>>
>>> For example, in the mhi driver, the failure is triggered when the
>>> MHI's st_worker gets scheduled-in at resume.
>>>
>>> mhi_pm_st_worker()
>>> -> mhi_fw_load_handler()
>>>     -> mhi_load_image_bhi()
>>>        -> mhi_alloc_bhi_buffer()
>>>           -> dma_alloc_coherent(GFP_KERNEL) returns -ENOMEM
>>
>> And what is the exact size you are asking for here?
>> What is the dma ops set to for your system?  Are you sure that is
>> working properly for your platform?  What platform is this exactly?
>>
>> The driver isn't asking for DMA32 here, so that shouldn't be the issue,
>> so why do you feel it is?  Have you tried using the tracing stuff for
>> dma allocations to see exactly what is going on for this failure?
> 
> I'm guessing the device has a 32-bit DMA mask, and the allocation ends up in

Yeah, the device is capable of 32 bit coherent DMA only.

> __dma_direct_alloc_pages() such that that adds GFP_DMA32 in order to try to satisfy the
> mask via regular page allocation. How GFP_KERNEL turns into GFP_NOIO, though, given that
> the DMA layer certainly isn't (knowingly) messing with __GFP_IO or __GFP_FS, is more of a
> mystery... I suppose "during resume" is the red flag there - is this worker perhaps trying
> to run too early in some restricted context before the rest of the system has fully woken up?

the worker is running at __resume_early stage.

> 
> Thanks,
> Robin.
> 
>>
>> I think you need to do a bit more debugging :)
>>
>> thanks,
>>
>> greg k-h
> 


