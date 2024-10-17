Return-Path: <linux-fsdevel+bounces-32282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F17BE9A308E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 00:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 209601C20FF4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 22:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A729E1D79B4;
	Thu, 17 Oct 2024 22:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jaFQP3O8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D55E1C1ADA;
	Thu, 17 Oct 2024 22:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729203753; cv=fail; b=K9uTa5iHIlkuN3bT/rn9WgTmEJfm8GIzcXpBEzhGKANmqu/t2tDalAPJuuRx7TmzjuTuQbvI6UqkvsuVmXnosQNVYELNVFtVS1+mgMuCDcjOAGcPWT9en0ns1JfuNDre450+1E6828d6JuU7ds3zzELOvS94/PAXhWA6T0+FfMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729203753; c=relaxed/simple;
	bh=wDoSYU1cyLKm1PB85wa9sTpiRWzoVuD1ulS129FySyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UCNbcCoq4IvuGlaJg1qmgXjHfrZAsXSdlJGPUN/8jnVWEYDypyPHBFVWnRXM0MAtEIirmt9tWUgM+oT5OeQOCNrJLP6ovnO+CS62go03OWV0UbJUabzZG4BwabluVO6k1QDevcpUWQa5Xw+/GrhrhyZ28rv4dUUQZD+L4UPVZRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jaFQP3O8; arc=fail smtp.client-ip=40.107.101.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pOKz7bvH9a8+4yQYDsRyDvA8jUSGhH3W4hy84l/fEGG9kpBeczLv8bDB55qdQ2zz7ihhETze/GGTCXxnGuG8tjids0lzlXikzSdw49BXa2DftV8T9OnR0vMjanWHWo6APaik680Q4TqsU7xzLPZLhnaq5hKMA2EGl6UPLPTi988hlwQBfAKSLWUFvwybJY4f0vjaeVe1iC66LCkdJQouQKuIPyZ+OjeUzIG98gnIh6TURkhgOonGQZ5sNg9U1OXLyfsj2RTz2Zpwt2oB3JqegqYh84x3mqXtDzRApDNzmSjlyv+vSDymgYGu38VgUXrkz5kSDvjTbcsPVXl0VK1w0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hrtb7hJBI817FpRdb337p+djcJ572Klu7i3M36LPPBk=;
 b=MRv1DcQNNrb6xdotQZU5FtRHTeJKPQ67sqm6SPb7+wXnvo3JOYY9elMOvqP50mv1beJ8j6Ojs6pkbdo80ey+pHMjozzErCGPvyvG2kK1Wq2UvzxL0Qz/bTNC/2sn/pIhK6GouHqaeW06IKtaG4hLkPwpK6esU+o/PTHnnKVovClbq1vSqJaQap+wAHTHC7+DRWzFkLMjJmVL351vRRPYwu4yMpr4AK2nhwlk8v5Ohr0oli/zokTYK1hhy9rNMCMhD9tpN4vU5ogvclCh+ocyW3DZvKl48JSUHwU2qSU3YDeZg02XPN6F+/pOeZqj+l+6+AkLrQmfDruhdCaRKHWp/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hrtb7hJBI817FpRdb337p+djcJ572Klu7i3M36LPPBk=;
 b=jaFQP3O8Be12JJTEyR1OCc6Sw3wNxl9lPWly0NglJIBwXzIOX5DFGZ2C/StsH47mZC0/9stVZaF8bGufWI6wMyuBkECAEzfaUW1fuXUYYiIRG5ssNQXuULVYvN9PoZDJkwnmdgeE49/y+hAArkgt1D/m0MJrfI3sNtCDN1A8a0zAnDxwTqS/H0w7zrVKzB7JQXsdnEBmHWAjY9rSgtiVsNwJ2lEdDjTIVFaKmrQf0ItofDtTWSV36fQ+XVuJ3g7uSaoikuvNMK2utmGG8ee049Hkx5Jvh2nlWHwOh07uuKO0GRmpCa4Wc20kTt9nwowz8Harv1TWdxvhFWd52oQXkw==
Received: from CH0PR03CA0416.namprd03.prod.outlook.com (2603:10b6:610:11b::7)
 by CH3PR12MB8969.namprd12.prod.outlook.com (2603:10b6:610:17c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.29; Thu, 17 Oct
 2024 22:22:20 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:11b:cafe::26) by CH0PR03CA0416.outlook.office365.com
 (2603:10b6:610:11b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19 via Frontend
 Transport; Thu, 17 Oct 2024 22:22:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 22:22:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Oct
 2024 15:22:04 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Oct
 2024 15:22:03 -0700
Message-ID: <80e06cf2-fcd4-48be-86f9-a5d6acec46c4@nvidia.com>
Date: Thu, 17 Oct 2024 15:22:02 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] selftests: pidfd: add pidfd.h UAPI wrapper
To: Shuah Khan <skhan@linuxfoundation.org>, Lorenzo Stoakes
	<lorenzo.stoakes@oracle.com>, Christian Brauner <christian@brauner.io>
CC: Shuah Khan <shuah@kernel.org>, "Liam R . Howlett"
	<Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, "Vlastimil
 Babka" <vbabka@suse.cz>, <pedro.falcato@gmail.com>,
	<linux-kselftest@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-api@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Oliver Sang <oliver.sang@intel.com>
References: <cover.1729198898.git.lorenzo.stoakes@oracle.com>
 <d8d1a8c6ade7f13a100a5c11fd1e53f7f2fddba3.1729198898.git.lorenzo.stoakes@oracle.com>
 <7df771b9-bfd6-465e-b0ba-12d2aab13ec6@nvidia.com>
 <f24e645f-e7e6-436d-875b-7e15feeae8eb@linuxfoundation.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <f24e645f-e7e6-436d-875b-7e15feeae8eb@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|CH3PR12MB8969:EE_
X-MS-Office365-Filtering-Correlation-Id: f4c78d29-e700-4fcc-1b7f-08dceefa2a77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1VVcmx6Qk9jaU1BYk9NcGdvUldLOWtjL09oRE02MFdkQ1FKVGlzbnJoQnJE?=
 =?utf-8?B?aDgvRkVIVnlOanE2cmRjZFJYeEdHZk9pam1HTEkvaFE2ME4xTjU3TU1KYVVu?=
 =?utf-8?B?U1dCalZrYjZqZ01QSTVWMFRCaXlvS0lwemZPWFBjMmxXOThESlgwc1ZkYTBK?=
 =?utf-8?B?QnpQd1FHWUE2aE44U2tRTDhDeEhzVDAvTW04RFNRTzJISGkzemlCVkRrbWlq?=
 =?utf-8?B?NVBhYjE3R29xOEc1WStaRTNURnNoVVZqOEk4NEJwMkIyNXk3L05EZTNFM0J4?=
 =?utf-8?B?dXkyVkRiRHh3czdCZjk1cmxwWWhBSGxtdkpmazVYU1M0UGQrampoUmh5N1Zv?=
 =?utf-8?B?czVaRTdmblNUNXRBSEF5eTB4Snp3ZGlIY1BPY25xcWRnU1ZKL3UvZDZrYytm?=
 =?utf-8?B?YjQySW9lOWdkYlF3VXJWNlZDVjlHeVlCd1IrQ3NsUm1XTk44NDJxTGdDYm50?=
 =?utf-8?B?RCt6bnhNTWE4cm5lL3pKRVQxakt2c0lQQXBwT0lKeWlhQzhEaFRPQXRMTXYr?=
 =?utf-8?B?eG1VSStBdHlkVW96azNnb1B4OFMxRGIrenBxWXlPY0ZHRGNVd2pxODdOaWI1?=
 =?utf-8?B?ajJ5YXZXSzd5WnVmYzFENWJqN1VRTmV6RFA4UHVYMkJrVWVQa2JmclV1dEUz?=
 =?utf-8?B?UXZZWXlvU3ZlSmJZKzlQd3dKNjFDY3hweXNMaE1jVysxWTBNa3IwWUZlckVX?=
 =?utf-8?B?bThUN3p5aTJ6L3B6NXFGUDkzTzh2ZmQxQTJQa1NhSXFDc3lQcGMvOEtYSVl0?=
 =?utf-8?B?dUl2OTVrSjV2NTlhd20rNWgwaVQyVlkrZVZ2MjBIaEtjSkl4YUtoVmhLL0NU?=
 =?utf-8?B?d01RMnJnVzkzc3RyMWdKTnphSm84TVhHTmR4cWJjTlRpTHdGWlZKK3JLQUFp?=
 =?utf-8?B?eXNza01xc1lPRk9Mb2ZFbE9sLzhFRFFqZWdUNVJneXZEaUw4UWhZWE5PVUE2?=
 =?utf-8?B?RU51OFExTDlraXpJbXdvUHkwNmQ5cUhvU3EvVkRleWU1MFRnQVprakQzb2l0?=
 =?utf-8?B?MFcrSHZLcURkTEVRT2xYQmpLWDRvNWNFM3F6cTJmeW94dlBnTDZiaXY5Rlps?=
 =?utf-8?B?NHRjRTVEdkV0ZjBXN3lqYnF0QWxReGtIUEVtYTg5UXNOWnVNa2hRczV1dXhU?=
 =?utf-8?B?azNXK0JXT3dvdDBYVWVPZkMzWmtoejlvQmZMQzZqOGFvT3NCNS9lQ3hOY1Fn?=
 =?utf-8?B?VE9kZkdqYy8vLzNrTXFMZUNjR0dMSkxwSFNnRGRwN1hQWnFFcDlwcHJkODR6?=
 =?utf-8?B?OFZQZyttd2VYU1hCZUJlSVcraFRBMmVKbW1tUmNNb05Ia1NtRmJFSGMybHRn?=
 =?utf-8?B?TVF1czZiUkF3U2NWbkREZWRzY1V5bnBlWnhId3FKUXVNYU5oaTBJM3REN1hh?=
 =?utf-8?B?NGd2VncxbmV1NU42THByWHVaU1ZLTWZSRDUzQ0lJREFYTGljNEp0RjRpY09N?=
 =?utf-8?B?SU5HK3JPdWZUR1pmNnpicDFWbzQyb1pCSzI5WEFlOXlUOFgyR1dkc0tZZkpv?=
 =?utf-8?B?NHplSjZsTTI4Zk1wWlF3SXFIem00UWNkNXpQVHZ3RzB5N0tpWFkrNkh2a09F?=
 =?utf-8?B?cjQwSjA4QzZTOHpzc3NFLzRZK1VSTG5qTjVrcDFlSVMvZDIyNHI0ZzdRamVy?=
 =?utf-8?B?SXdwM2p0MFhqVHBMQmxON0RLQjNuZ3NveG10Tm5DTXhhRW53cVRycGZPY051?=
 =?utf-8?B?djRya0JGY241UThubE85QUNaZ1BXKy9sN2pNckRJRXJxamFBdGtpZGlseTU2?=
 =?utf-8?B?RVNKRUZMOTUvRW5LaTBNN3JDak0xakQzcHJPc05Tc1hmRFI4MTVHQkZPZ2FV?=
 =?utf-8?B?UGk4VG0zSkxwM1grOHVZZWx1T3BZUkRaSGhJRk1UMXFiUGd2eE5kczRoaXBE?=
 =?utf-8?B?cnNIL2RsRUJOYUd2bDYyZUpsbGU0TGNjOGNLSDNkd1kzbXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 22:22:20.0201
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c78d29-e700-4fcc-1b7f-08dceefa2a77
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8969

On 10/17/24 3:11 PM, Shuah Khan wrote:
> On 10/17/24 15:45, John Hubbard wrote:
>> On 10/17/24 2:05 PM, Lorenzo Stoakes wrote:
>>> Conflicts can arise between system fcntl.h and linux/fcntl.h, imported by
>>> the linux/pidfd.h UAPI header.
>>>
>>> Work around this by adding a wrapper for linux/pidfd.h to
>>> tools/include/ which sets the linux/fcntl.h header guard ahead of
>>> importing the pidfd.h header file.
>>>
>>> Adjust the pidfd selftests Makefile to reference this include directory and
>>> put it at a higher precidence than any make header installed headers to
>>> ensure the wrapper is preferred.
>>
>> ...but we are not actually using the installed headers, now. And we intend
>> to continue avoiding them. So the ordering shouldn't matter. More below:
>>
>>>
>>> This way we can directly import the UAPI header file without issue, use the
>>> latest system header file without having to duplicate anything.
>>>
>>> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
>>> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>> ---
>>>   tools/include/linux/pidfd.h            | 14 ++++++++++++++
>>>   tools/testing/selftests/pidfd/Makefile |  3 +--
>>>   2 files changed, 15 insertions(+), 2 deletions(-)
>>>   create mode 100644 tools/include/linux/pidfd.h
>>>
>>> diff --git a/tools/include/linux/pidfd.h b/tools/include/linux/pidfd.h
>>> new file mode 100644
>>> index 000000000000..113c8023072d
>>> --- /dev/null
>>> +++ b/tools/include/linux/pidfd.h
>>> @@ -0,0 +1,14 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>> +
>>> +#ifndef _TOOLS_LINUX_PIDFD_H
>>> +#define _TOOLS_LINUX_PIDFD_H
>>> +
>>> +/*
>>> + * Some systems have issues with the linux/fcntl.h import in linux/pidfd.h, so
>>> + * work around this by setting the header guard.
>>> + */
>>> +#define _LINUX_FCNTL_H
>>> +#include "../../../include/uapi/linux/pidfd.h"
>>> +#undef _LINUX_FCNTL_H
>>
>> Oh shoot, I think you, Shuah and I were referring to different uapi locations,
>> the whole time. And so the basic approach is different after all.
>>
>> Your include path above actually refers to:
>>
>>      $(top_srcdir)/include/uapi/linux/fcntl.h
> 
> Correct. I am glad we are on the same page now.
> 
>>
>> ...but what I was intending was to copy a snapshot of that file (or a
>> snapshot from the one generated by "make headers"), to here:
>>
>>      $(top_srcdir)/tools/include/uapi/linux/fcntl.h
> 
> So why do the copy and snapshot. Anytime you build userspace in the
> reoo - you will need to run "make headers: whether you install
> them under tools/include or include.

No, you only do "make headers" once, and that's a temporary thing too.
After the author of the new selftest runs "make headers", the author
will typically remove those headers, in order to verify that the
selftests still build without the kernel generated header files.

That's it! No one else has to deal with it. And that's what is being
asked for here.

> 
> 
>>
>> ...and then use $(TOOLS_INCLUDES), which is already in selftests/lib.mk,
>> for that reason: to be available to all of the kselftests:
>>
>>      TOOLS_INCLUDES := -isystem $(top_srcdir)/tools/include/uapi
> 
> Yes some tests do include that.
> 
>>
>> The reasoning for this directory is further explained here:
>>
>>      tools/include/uapi/README
>>
>> (And I see that selftests/proc has started using $(TOOLS_INCLUDES), that's
>> progress.)
> 
> Yes the same problems apply here - what complicates this more is
> selftests are supposed to test kernel changes, hence the need to
> include latest kernel headers. The simple solution is adding a
> dependency so we don't have to duplicate the headers. I don't
> believe the perf solution works here. We will have to figure out
> a solution.

That's the key point: the fact that the selftests are intended to
test kernel changes does *not* mean that we have to include the
dynamically generated header files. That's going further than
necessary. And it leads to problems and complaints for kernel
developers, who are really one of the main user groups here.

> 
>>
>> And now, it's possible to change fcntl.h in place, instead of using a wrapper.
>> Although either way seems OK to me. (I'm sort of ignoring the details of
>> the actual header file conflict itself, for now.)
>>
>>
>>> +
>>> +#endif /* _TOOLS_LINUX_PIDFD_H */
>>> diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
>>> index d731e3e76d5b..f5038c9dae14 100644
>>> --- a/tools/testing/selftests/pidfd/Makefile
>>> +++ b/tools/testing/selftests/pidfd/Makefile
>>> @@ -1,8 +1,7 @@
>>>   # SPDX-License-Identifier: GPL-2.0-only
>>> -CFLAGS += -g $(KHDR_INCLUDES) -pthread -Wall
>>> +CFLAGS += -g -isystem $(top_srcdir)/tools/include $(KHDR_INCLUDES) -pthread -Wall
>>
>> Instead, it would look like this, which now mostly matches selftests/mm/Makefile,
>> which is also helpful, because eventually this can be factored into a common
>> piece for all selftests:
>>
>>      CFLAGS += -g -isystem $(KHDR_INCLUDES) $(TOOLS_INCLUDES) -pthread -Wall
> 
> KHDR_INCLUDES is "make headers" location under the root directory. So what
> happens when you add TOOLS_INCLUDES to it.
> 
> Does "make kselftest-all" work as it is supposed to? If it and all tests
> can build then I am all for it.
> 
>>
>> I apologize for just now noticing this! And these kselftests shouldn't require
>> so much fussing around, I know. But once we get this just right, it will work
>> well and last a long time. :)
>>
> 
> 
> On the contrary if we don't discuss/fuss and get this right, we have to
> deal with changes like adding local defines and adhoc approaches in
> individual tests - that is one reason we made the "make headers"
> as a dependency. I would like to solve the problem of proliferation
> of local defines and even system calls in some cases.

Yes, let's work through this.

> 
> For now I am going let this patch go through as it is important to
> add tests.

Sure, we can iterate on it as necessary.

> 
> My goals are simple:
> 
> - no local defines unless it is abslulutely necessary

Agreed.

> - be able to build tests that add coverage for new kernel
>    api and features before we release the kernel.
> - make it easier for CIs to build and run tests

Up to a point! And that point should be somewhere *before*
it inflicts extra pain and annoyance on the kernel developers.

Let's not let CI drive this all by itself. CI is not writing
these tests, and furthermore it can adapt a little bit if necessary.

But even more to the point, avoiding "make headers" simplifies
CI, rather than complicating it.

> - continue to have tests works for kernel developres
>    e.g: mm developers build tests in mm directory. They
>    don't see the issues that crop up in CIs or running
>    the entire kselftest default run like CIs do.
> 
> Adhoc changes break some use-cases.
> 
> thanks,
> -- Shuah
> 
> 

thanks,
-- 
John Hubbard


