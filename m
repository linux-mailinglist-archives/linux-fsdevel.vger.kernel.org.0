Return-Path: <linux-fsdevel+bounces-32404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5223C9A4A55
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 01:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 921D4B21855
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 23:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33BE191F74;
	Fri, 18 Oct 2024 23:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VFvGRfX4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DE418C90A;
	Fri, 18 Oct 2024 23:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729295759; cv=fail; b=lYUJ4qK+zD9A8jNNVmTLEV3RCQ2u53p2zCa5aPeHIRFLF18j1nCt9/CwT2mb5cAqpEs2DyNDdp8T79hbUk2pJrDKy/ouFOgwdJuSWqG5VLRoBt0/YHFtCvdqhNeF48fHVm38EHRkigYFJBal6eDU7WFNd03jQ5b01y78gdv35z8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729295759; c=relaxed/simple;
	bh=VNMAsgZujYEz8jMwfL+CQsRF0ne4ByGjzGksR3QxGDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Pc7K+SDcp88fZ/XFWzcDsU5kqVh6hjo8+H3zc+dmrqdOX1k9FAV/RRHtyHr2GOiRCiIpF8tLyjyMnxN3rKka6sl5hr5vVQI1ngS/B5U1jI5dB99l1/Y/BPhz2b0vs0ZMdHkaPY2tU/FVu31yvmKK2jXPQInl0/iPnhMIeR3Gwng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VFvGRfX4; arc=fail smtp.client-ip=40.107.236.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G5rwt0fSjozLNVBCMoEOFuJ9jTgoJcYL1JMgBxxWlD6LdnqBBcJuWtkBwonWTZUa7QHvWfnEHzB+fxURLLPeledgehnb4+ivi1hNGFMm27EuHKB+4nApnbXevOT7l0+jZppbQM/ygzN4Nwof/LyRgrwi3GCO3fUsOdqdlqsgsEydRDShvhYF4a/0CsFR+qNtYik6RWAsSk9IBmLJQLRnR5pPsawpj2y1ppol04/476BPlJaOfgpOa155CONjw3JJc6o8MGONxRZdk4LCQ40oQZUXY6db+fJIokDdBwt7p4oe8Im9bUHamMyv2WAP4+1WrN9qsDc1sXp4D3HN3+yLKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pexlr1AxcEcYYdm5dZSmncVbeuDu7RnYg62hjUujyN0=;
 b=Ik4Tom1AKtkaz1kKaXqm0qlKVp+yEqjZZbvzMbYhmbL2Dg2uWJfUnZNmjhVCPcRfnAGFuxy7KvMIxgYwijxChufTibCgcAY2V2sqKtH3fDwYRp3tqj6yfCHpBLxI3LtTNhNnkPFXhGUGw+jecSt6e/k+oEQq/ITSWZqtR1Dp/cVCF2UmIe+B66BoIPL8yEKHJdtDe8px3xoEjG8ie01vmyEXw5650FfAFk+g5hzepYri9im73uHwTW+OPmTDxixZELreGxMgQgW/IIJuiq1t/rCOBQJN4w3z17R7OLOpGHpja85kT2wVQ1TQQN8IAOWpfXH8/I/efhgVIYSlFB6Dzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pexlr1AxcEcYYdm5dZSmncVbeuDu7RnYg62hjUujyN0=;
 b=VFvGRfX4GCEhTdkTZeFyna6VwAXkQuIklziJ8XWq56U7nX4ySoeEnJYF07her0R/vIVtO5pyv8ps17S33fzVRHo0JHwcDmic13hXINCaXdFIt48WqKwYlnfIwL5xZLKXukwAhwgB5BBu6YRK6ryaMBHGUXM8qvc0y7cjhhprWxi1v69oExp3T3l8jwnAYztQMWQ4pzBTsOwgl8gbMgzmGuYAbJkWCZ+bVoC4mT79nj8KKlYChP6L58cUQnvgbi6tw+xC2j01kFT24QfQYQfyGZ+i/ddC3CkYqtQk13AycaiMNNlpR9RTSgTpoDur58NX8YCgZSqgqiZ4lQrrwa6PPw==
Received: from SN7PR04CA0185.namprd04.prod.outlook.com (2603:10b6:806:126::10)
 by MW4PR12MB6684.namprd12.prod.outlook.com (2603:10b6:303:1ee::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Fri, 18 Oct
 2024 23:55:51 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:126:cafe::99) by SN7PR04CA0185.outlook.office365.com
 (2603:10b6:806:126::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21 via Frontend
 Transport; Fri, 18 Oct 2024 23:55:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 23:55:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 18 Oct
 2024 16:55:39 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 18 Oct
 2024 16:55:38 -0700
Message-ID: <3c27a383-45f9-4307-b1b2-f6bfa78633f2@nvidia.com>
Date: Fri, 18 Oct 2024 16:55:37 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] selftests: pidfd: add pidfd.h UAPI wrapper
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
CC: Christian Brauner <christian@brauner.io>, Shuah Khan <shuah@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan
	<surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
	<pedro.falcato@gmail.com>, <linux-kselftest@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-api@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Oliver Sang
	<oliver.sang@intel.com>
References: <cover.1729198898.git.lorenzo.stoakes@oracle.com>
 <d8d1a8c6ade7f13a100a5c11fd1e53f7f2fddba3.1729198898.git.lorenzo.stoakes@oracle.com>
 <7df771b9-bfd6-465e-b0ba-12d2aab13ec6@nvidia.com>
 <bc07dba0-90c7-4926-ae38-71c3c3e17e16@lucifer.local>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <bc07dba0-90c7-4926-ae38-71c3c3e17e16@lucifer.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|MW4PR12MB6684:EE_
X-MS-Office365-Filtering-Correlation-Id: ce9c18da-4b8f-4479-503c-08dcefd06574
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TE12RkdFZjhqbjZvbEh6d3RuNTZBMWZXUWQwWE5ZRTgzMUl2NnNHZWZzWkxL?=
 =?utf-8?B?TGJ6dlQybnJxNExLUHZ0UVVXVUx1OWFHSUVPRHFhbERmOUI3MkUwWUZzZUsw?=
 =?utf-8?B?WGI0ZFdGaUZ5T21LcjFiVG9XQlQxK2RjeFhzdWZwMi8zamtwZ0NTOGMrR1Jn?=
 =?utf-8?B?SGlBOVZpT3VBTVluMklFN1AyWXNDZlEvTGQ4cHZZbWJhTCtPNVZZekFqZXcz?=
 =?utf-8?B?b0d1Y2U2Q1dkZWJhR1RrWGJHcHVwSTV1MHpBcVQxa2p5b2I0cmh1M3plK2hh?=
 =?utf-8?B?YzJBVVVzREFNY3FwS3FESkdiQ0FlS2hsUFVUSVJhZjdLRDgyR1V2WWg5R3Uw?=
 =?utf-8?B?djV0T2QzazlVdDEyNUJWNnIrTEZLNGthWnovcVdReEJGOGN2c2QyeWlqSC80?=
 =?utf-8?B?NUMyOXJ6RFM4SjlXc3JaYWNONHN4Yi8xczk0U1MrTHpYZzFzYmNHSktTY0Rx?=
 =?utf-8?B?dEVWUlRQNjZWZDJYZGU0RmNuTHlyamFIRVNibmRvb1B2c0xMSGFaVWQ5K1g2?=
 =?utf-8?B?anpQeis4V0RtN1J0SGJTRWxPSW9iOWhKRlcvU2t1WENMS3NyUGl6a1ljOCta?=
 =?utf-8?B?eEhNbWlQWWFJSWhEWjRJVlg2QzYrTlVqY1paRHgzazgxS2dWTURmczVFVTFC?=
 =?utf-8?B?dWhtT3dDcVZ5VnNmTVdZNkFjY2pEdjE0VWFTSDRRSnArcFRFUVFYemZ2Wk9C?=
 =?utf-8?B?VHRMaHlLVDZTT0J4THFtZjNEYVN6M252aDY0c3lKN0RBVXhwZGpYVEY1b3Mr?=
 =?utf-8?B?WVZTV2ZiY3ZvMXFkZlFCWUNWOCtoeFNUOXdKeDVLSUpuRjFXOFg2T1dMclBD?=
 =?utf-8?B?M3BMUnNETTRZM3F6ZjRXL3BEUUxUZ2swYXIzODNRS29CaUFxWFJkTGJOSStj?=
 =?utf-8?B?ZmMwT3pjMllqdmpQQ2JsN2hBN2VzdnZJRnpGallEQS84OHRqeGV6SHgzYUVH?=
 =?utf-8?B?MHZRZ09lc1ljRWgwV1ZITXNRd2VubGlVYWpSV2syalIvTnFXR210Q2g0M1ZC?=
 =?utf-8?B?WVFQRzBqVDArVS9oYjM1L1dVQ0ZIbWErZHJPQjgxb2JUc2Q1SWxDZEpuS0M2?=
 =?utf-8?B?LzJOS3NkK1lzUmt1Qk1jRTc5L0pJYUMzTTUrUTBERCtUMkJXNEtBMkcwQUpL?=
 =?utf-8?B?c3U3RC9iMXNIM28vRUNDa0JnZmtCRDMzRDlkaGpYZzNUN2lJU2JEb1pCVlBm?=
 =?utf-8?B?VWdDekJ6SERLczdJV29UbW12N0VCaVVmWDZBMG5oWTV5STgvNmxBbDRDR0Ny?=
 =?utf-8?B?UXBlRzhxMTlsMjE3Y00yT3pWYytSenVKdWR6L2FSQ1VldXJsb0NqdERqdk9P?=
 =?utf-8?B?QmN6Q002T01CNUJBQ2FPRHExL2xJZjczc21jNzZ1K3dPNmVxS1N4bE5EU3Jm?=
 =?utf-8?B?d1lnSUNhREVpSGFBRlhtSFlpZ2RVZEtLVUYxOWxSSlR2TE4wQ2pPbGozYnNE?=
 =?utf-8?B?WEZTZ3NnSEdHZncvQVppYTVyU3QyMG1VdkRiMS84RFBCSWU0dGx6Rkd1VE1U?=
 =?utf-8?B?ekpiRzVlMGV4TFFTS0FQR25MVXFaTWtrSU9nUXMrKzdQQ0ViYmlGR0lLZmFG?=
 =?utf-8?B?Y3AvNjR0QlJKbGFJWDYyRjM2eXcyZFNiZXFkNm9OenVZU1pjd29xWGV6Rkk3?=
 =?utf-8?B?a05vR25Zb3BOZ1VkU2dPaEtxbmZJM2dPaW83UXpVRGlvNE9uSXhtdGE3RXdI?=
 =?utf-8?B?d1JRUHNCdnZ4SzBEcEhRcmNuOUxMRTl1b3ZWcG4yK01mVjhTMG90NzFkRUVX?=
 =?utf-8?B?aDRTVzN4WnRkMEMwMVladlhub0ppYWxDVDVueFluZHhTOWVTVDNjMXF5WkR2?=
 =?utf-8?B?U09xM2IyMCtPa2NnVjB4R3YrNzJ3VXNITDVOdndhWExPRjVTenI1T0IxMGQy?=
 =?utf-8?B?VThOeHYvZGVFTm1uMU1oUUozSjYyd0toTDhtKzhKc3VUUFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 23:55:51.2719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce9c18da-4b8f-4479-503c-08dcefd06574
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6684

On 10/17/24 11:49 PM, Lorenzo Stoakes wrote:
> On Thu, Oct 17, 2024 at 02:45:43PM -0700, John Hubbard wrote:
>> On 10/17/24 2:05 PM, Lorenzo Stoakes wrote:
...
>> Your include path above actually refers to:
>>
>>      $(top_srcdir)/include/uapi/linux/fcntl.h
>>
>> ...but what I was intending was to copy a snapshot of that file (or a
>> snapshot from the one generated by "make headers"), to here:
>>
>>      $(top_srcdir)/tools/include/uapi/linux/fcntl.h
> 
> Yeah my first version of this used the uapi one but I thought doing that
> might conflict with snapshotting? Also it'd mean you'd absolutely have to
> have the $(TOOLS_INCLUDES) earlier in the include priority list and better
> maybe to special case in this instance.

Actually, I think the goal is to just stop using KHDR_INCLUDES (./usr/include)
entirely!

More below...

> 
>>
>> ...and then use $(TOOLS_INCLUDES), which is already in selftests/lib.mk,
>> for that reason: to be available to all of the kselftests:
>>
>>      TOOLS_INCLUDES := -isystem $(top_srcdir)/tools/include/uapi
>>
>> The reasoning for this directory is further explained here:
>>
>>      tools/include/uapi/README
>>
>> (And I see that selftests/proc has started using $(TOOLS_INCLUDES), that's
>> progress.)
>>
>> And now, it's possible to change fcntl.h in place, instead of using a wrapper.
>> Although either way seems OK to me. (I'm sort of ignoring the details of
>> the actual header file conflict itself, for now.)
> 
> The fcntl.h and linux/fcntl.h conflict is apparently a rather well-known
> horror show. It's a difficult one to resolve as the UAPI pidfd.h header
> needs O_xxx defines but we also need to include this header in kernel code.
> 
> An #ifdef __KERNEL__ block might be a solution here but fixing that is out
> of scope for these changes.

Certainly out of scope! Your patch already avoids the biggest issue: it no
longer requires "make headers", in order to build it. That's fine for now. Sorry
to put you into the middle of a pre-existing kselftests debate.

And the #ifdef __KERNEL__ sounds like a potential solution, or at least a
building block for one. I need to take a closer look at this particular header
file mess, the fcntl.h situation is new to me.

  
>>> +#endif /* _TOOLS_LINUX_PIDFD_H */
>>> diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
>>> index d731e3e76d5b..f5038c9dae14 100644
>>> --- a/tools/testing/selftests/pidfd/Makefile
>>> +++ b/tools/testing/selftests/pidfd/Makefile
>>> @@ -1,8 +1,7 @@
>>>    # SPDX-License-Identifier: GPL-2.0-only
>>> -CFLAGS += -g $(KHDR_INCLUDES) -pthread -Wall
>>> +CFLAGS += -g -isystem $(top_srcdir)/tools/include $(KHDR_INCLUDES) -pthread -Wall
>>
>> Instead, it would look like this, which now mostly matches selftests/mm/Makefile,
>> which is also helpful, because eventually this can be factored into a common
>> piece for all selftests:
>>
>>      CFLAGS += -g -isystem $(KHDR_INCLUDES) $(TOOLS_INCLUDES) -pthread -Wall
>>
>> I apologize for just now noticing this! And these kselftests shouldn't require
>> so much fussing around, I know. But once we get this just right, it will work
>> well and last a long time. :)
> 
> Yeah I know, but this won't work due to the header conflict, I was doing
> this previously.
> 
> Also doing it this way means that uapi snapshot doesn't override the usr/
> one if you have that, which I guess you want?

Actually, given that we want (or should want, so I claim) to build without first
running "make headers", and given that "make headers" populates ./usr/include/,
which in turn is what $(KHDR_INCLUDES) points to, this means that eventually we
should end up with approximately:

     CFLAGS += -g -isystem $(TOOLS_INCLUDES) -pthread -Wall

And I just checked, today's selftests/mm builds just fine, with a similar
diff applied, so I'm not totally crazy:

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 02e1204971b0..b004a8edcba5 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -33,7 +33,7 @@ endif
  # LDLIBS.
  MAKEFLAGS += --no-builtin-rules
  
-CFLAGS = -Wall -I $(top_srcdir) $(EXTRA_CFLAGS) $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
+CFLAGS = -Wall -I $(top_srcdir) $(EXTRA_CFLAGS) $(TOOLS_INCLUDES)
  LDLIBS = -lrt -lpthread -lm
  
  TEST_GEN_FILES = cow



thanks,
-- 
John Hubbard


