Return-Path: <linux-fsdevel+bounces-32280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4CA9A2FFB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 23:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23FFC28489C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 21:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF701D63D0;
	Thu, 17 Oct 2024 21:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JpxBUc0t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525571386B4;
	Thu, 17 Oct 2024 21:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729201571; cv=fail; b=X2TORjOilId8eMbKrVAkgtnU4YeLTJkHVWeSD++BgHb7jbJ/I3ppkPxJsvq78H7B0Dqk8UQ/hJw15VaimhTLavxcF4qVqydMXAf5FR6A/W8Q/CIwOSJ/J+IsBROwFzaDBnL1m8XtjSIqsQq8JxHUevb/sgJ6Jceh0YoONsdTCEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729201571; c=relaxed/simple;
	bh=sRyNOJF23I8dPG85+L6JGw90vySjJBKH0BEozoVwDHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kwWry0sb7x5vA1Rupt2fVZ6uF175VMZL0a020ViVDFm+AXExLBTgI6Tbx/ACKmAQCIvfLokXLcc8Oy0LVmNh/4j7YRBD/0yJpuy9nw8LDfAXKps2iito4+52LZ6GZZBntlKRj+n0InL/we4htE0FtTjYp1CswZ18wELXuNEJ6fU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JpxBUc0t; arc=fail smtp.client-ip=40.107.236.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5z4KLNsVYuQQKi9U9l1pJZ7q1UAmLcpcaAdrS9R94HDYbVJ1bO2dN9vJLtFKTi11XxQNMQQrd2CVGCxeBZN19YndWnA3aX+Mybt3OdXjRyFIBJcMrJeH1ZuCndI5JDWro8fSMOGOvMT4URUsZIXD5CbRC92gKiGGAVNT/g6aQDxd0vsrtPUiYbxmIVWACuggp9pbeFbFOK+Gi0txjGJzzeu/NGuHCszG1SsC9KXK/rHhzcDrTDSftuDxIXSQYsCtOrAbmkDSXKZWM/27pq47ZpcIGS0vaIO+CC5tZwlGoP5wHTriaSuqJlzdC0KKdPLqsi1Lce1PLduWuQBxXyJvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhb/Rirz5ZAU9n4iQHJxYPe48Sp8jyL2KsNvyGXmmBw=;
 b=bDTm1OoI5aIxLJHCSzvvb4qV1XoQahBLHcbrYIbk68A0ou0eS1S54pD0/uLd+dgHhQU5Wdc8noachJ4NEjlE7s4qS5xK1UGTuT696E9/a+QrkJ2U2cB5EduSuBLV2+RA3C0aXoe8baPRlK4Vd+GiPxkR3fjj5TBCgLRW2RI3K4naYnYloZXEpU4K4SFjaAWFVeb2WHB6l9D3oKjNu6msrK4GRdBwEFha30uERz4IbJUX/Np9KdhHhmAX9H4GXnPAmARMNAjs/hsVkjoK9yOrRqrn9MbQ071K2771HL2BU3oVC7MQXGz7qMBhxCldyXjnICy4MPPbcGrXUqXdOO6Kuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhb/Rirz5ZAU9n4iQHJxYPe48Sp8jyL2KsNvyGXmmBw=;
 b=JpxBUc0tmuqEoYAe29+xYSzZivXaufrmCr6iBc69G4iZ7Q8SDu4p31TdAPlaZgTvjUaywZ4gwd7X4v+5+MKuZvZt1Y+eq+km+YBscKLRqI0tghDtaXKUetYc7VEgT1j0jxvEVYm9K/4sbSsAscIqF5np+YqCYyGSsyDnnFFoZX8/kUHC54bcjhHqEcmK4ntLKaO6zYMZzMMI0lqkm8hlpIWh7Dw4fEp7qXqQ2OOGbQ04njDUg08fg8CHggrpscrSuLpeM2g6yXnjVcwd1IbT4n3WZV4XvFTO+9gvYsw6t7eVYHV/4CqlFtBtJUSSC6F/8cVh2XBTkOn6N5xa1wTvnw==
Received: from BL1PR13CA0386.namprd13.prod.outlook.com (2603:10b6:208:2c0::31)
 by SN7PR12MB6932.namprd12.prod.outlook.com (2603:10b6:806:260::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Thu, 17 Oct
 2024 21:46:01 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:208:2c0:cafe::d6) by BL1PR13CA0386.outlook.office365.com
 (2603:10b6:208:2c0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.16 via Frontend
 Transport; Thu, 17 Oct 2024 21:46:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 21:46:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Oct
 2024 14:45:45 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Oct
 2024 14:45:44 -0700
Message-ID: <7df771b9-bfd6-465e-b0ba-12d2aab13ec6@nvidia.com>
Date: Thu, 17 Oct 2024 14:45:43 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] selftests: pidfd: add pidfd.h UAPI wrapper
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Christian Brauner
	<christian@brauner.io>
CC: Shuah Khan <shuah@kernel.org>, "Liam R . Howlett"
	<Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, "Vlastimil
 Babka" <vbabka@suse.cz>, <pedro.falcato@gmail.com>,
	<linux-kselftest@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-api@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Oliver Sang <oliver.sang@intel.com>
References: <cover.1729198898.git.lorenzo.stoakes@oracle.com>
 <d8d1a8c6ade7f13a100a5c11fd1e53f7f2fddba3.1729198898.git.lorenzo.stoakes@oracle.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <d8d1a8c6ade7f13a100a5c11fd1e53f7f2fddba3.1729198898.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|SN7PR12MB6932:EE_
X-MS-Office365-Filtering-Correlation-Id: fe3b5d10-f2d2-4972-f8fd-08dceef51803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1p3emQzZ2t4anBVdGNKWThvK3BxYVdvZ3NxMVBqWm45MlBSZnB3V2V6Rk82?=
 =?utf-8?B?dldpSW5oZWt0K2krZlVOVU1wRmk5cmJsblZJOUNRc3VPSkszU20vaEpONFdR?=
 =?utf-8?B?TGtrUzJvZ2xKUHJmMll1VmhzS2Z3dmZRVHkzL25ncE5zUWg2TWhoTmVDRlIv?=
 =?utf-8?B?QmVYSVU5RGFJdmthbldvOXBUWEFkSmNvdWVGZGhkUW5HYUxkcEJoT2tPZHZ4?=
 =?utf-8?B?THF5cHcrK3NWUjhXU0VvSUhJNlV2VXduWWcvL1g3QXBJOXRMWWZ0Mi9xT2FV?=
 =?utf-8?B?aGd5ZEpGUU9RbUxmcW1yQlp3UjdnaFN6SVB1S21tZTYyV25KUUtweEZVSmRY?=
 =?utf-8?B?RDJ5bk1SRUl0Y00wNmxodVdzUXJPb215TmVyYTFLaDFVeGRTZ1gvdVJDV3Nt?=
 =?utf-8?B?UlVZU1hMcHc3Z1dkYjk2L1FlMVpmd2tycTNVR0NxUVJtU1dnSmpoVVZDZllN?=
 =?utf-8?B?WXZHTDdWU0I4M1ZEdXZFc3FLVnNMQi9nRjRDT2Q4WnFFcTJKdFZ3dVk2TDJ3?=
 =?utf-8?B?dUl5SlFiNDhRamlEU3ZXdG9kM3dmNzROaGNORmpwa28vNTFlTXJFUFgzc2pC?=
 =?utf-8?B?VDFVRE9sK3gweXBYTVMzbkh1R2h3Tkh2VDhrSEhkUXRlUTZwczNzSDFvcGk1?=
 =?utf-8?B?N21NRDR1dGxVVytKK1pjT210SXY1VzZuRnBXZmlOcmF2Z0VDTWxQSjdyZGN0?=
 =?utf-8?B?NGswd0pMOEw1L3VZL3h2TTd5NUtYMnI3ck5BN0VCcTQwTW9uNmhycm1kZmNa?=
 =?utf-8?B?S3RpZUlucnBZT2VSa052N1Q0UjNXdWtJMG9XM21NeDM4NHo0OWFXa2JMYlZJ?=
 =?utf-8?B?b1hLR2RlZG01YzlGaGtISzhmR2JFMG81OTNIdEovM2pxTlpkZGE2TS9sUXdo?=
 =?utf-8?B?YWwrcXNVbllLTXFiZHZWL1VpODQ5bXFmZ0VpSTRmeEIrZXlNZmRZTEFzblo4?=
 =?utf-8?B?R3ErblgzOFRCdUtNUVFhREtFMUtnbzVvVzZRK1FTMjZDREdDOTZUUDRUSG9h?=
 =?utf-8?B?SHVNcmo4YUEzM0FxUmwwZVFaQUI2b2YvUW5yd1dLckRyRUdwYjRBZXRZUE9O?=
 =?utf-8?B?NzJ3QksyM3ptbm5CSElGMExLd21LSEgvY3NseDVJS09NWFkxMW9xU052TlE2?=
 =?utf-8?B?d1U4dVRpT1VTaDBaN09FcFRJZVVJVjZXSXlpUEtXTmdwVGxNVm9aSmZwc1Nn?=
 =?utf-8?B?WCt1R0llTE5EWFZwRVh6UHJWZGJGWUhmbzJPdU1HeksvTDZjcnJtZktDYzE4?=
 =?utf-8?B?dHUzTWx4ZEVydGJVQ2t5WnV1ZWlwcE1GZklLOFRMaDNPZ3ByWVJONGl5anJ1?=
 =?utf-8?B?QkV5TEZWaVVIcDZKRy96Z2FTUTNNc1J1UU1YQ29sbmZtY09SL2IzMnZDK3Vj?=
 =?utf-8?B?U3FReXBXNDVDZ3NGNVM0L093ZHJENTdoejh3UE9yMzNQTVNSUS85YmVGTExG?=
 =?utf-8?B?d0lXZ2x4TE52Nm5xMlBJZmg3UmJ3QVM5WWFGWU8xVEh4R3ZNRWhVU3c3cVNt?=
 =?utf-8?B?S2pGOUZPRzQ2ZVBHQlFza0JBNU5aMEdFbXVwdVhNT1Q4WFJaNVJVTTdPNzhU?=
 =?utf-8?B?aTBnWnZreDNZUXVaQk5XWXpmR2RNMU4xdzhVd0hvUGJPR042clo4U0lid1JW?=
 =?utf-8?B?a1FtU2ZrK3JMR1ozM0JsQkZ1QVM1U3pmR3VsVUcvRW8rZEhCVzR1K1RCak1w?=
 =?utf-8?B?YXRnWjFSL3BYQWFvSUlmZ2UzVVJGTUsvYzF6WE9zeE95TDV3akFoWU1NUDdn?=
 =?utf-8?B?a0lHWEFGZVAwLzZuQ0tVOEJMZEo2MEx0Zlo4ZVF0b0pPdjFOK1BGdXBwSndw?=
 =?utf-8?B?TUZ3R1E2YnZOVGdWU01pRnBFeGZsMTF5dnRGbGZybnhEditodkZ6OExwVmIw?=
 =?utf-8?B?ZWNQU2NEZjFYQ2RJNm1yd3Z2OHBYR2FKYlk1aWlhNjQ5QUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 21:46:01.5048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe3b5d10-f2d2-4972-f8fd-08dceef51803
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6932

On 10/17/24 2:05 PM, Lorenzo Stoakes wrote:
> Conflicts can arise between system fcntl.h and linux/fcntl.h, imported by
> the linux/pidfd.h UAPI header.
> 
> Work around this by adding a wrapper for linux/pidfd.h to
> tools/include/ which sets the linux/fcntl.h header guard ahead of
> importing the pidfd.h header file.
> 
> Adjust the pidfd selftests Makefile to reference this include directory and
> put it at a higher precidence than any make header installed headers to
> ensure the wrapper is preferred.

...but we are not actually using the installed headers, now. And we intend
to continue avoiding them. So the ordering shouldn't matter. More below:

> 
> This way we can directly import the UAPI header file without issue, use the
> latest system header file without having to duplicate anything.
> 
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>   tools/include/linux/pidfd.h            | 14 ++++++++++++++
>   tools/testing/selftests/pidfd/Makefile |  3 +--
>   2 files changed, 15 insertions(+), 2 deletions(-)
>   create mode 100644 tools/include/linux/pidfd.h
> 
> diff --git a/tools/include/linux/pidfd.h b/tools/include/linux/pidfd.h
> new file mode 100644
> index 000000000000..113c8023072d
> --- /dev/null
> +++ b/tools/include/linux/pidfd.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef _TOOLS_LINUX_PIDFD_H
> +#define _TOOLS_LINUX_PIDFD_H
> +
> +/*
> + * Some systems have issues with the linux/fcntl.h import in linux/pidfd.h, so
> + * work around this by setting the header guard.
> + */
> +#define _LINUX_FCNTL_H
> +#include "../../../include/uapi/linux/pidfd.h"
> +#undef _LINUX_FCNTL_H

Oh shoot, I think you, Shuah and I were referring to different uapi locations,
the whole time. And so the basic approach is different after all.

Your include path above actually refers to:

     $(top_srcdir)/include/uapi/linux/fcntl.h

...but what I was intending was to copy a snapshot of that file (or a
snapshot from the one generated by "make headers"), to here:

     $(top_srcdir)/tools/include/uapi/linux/fcntl.h

...and then use $(TOOLS_INCLUDES), which is already in selftests/lib.mk,
for that reason: to be available to all of the kselftests:

     TOOLS_INCLUDES := -isystem $(top_srcdir)/tools/include/uapi

The reasoning for this directory is further explained here:

     tools/include/uapi/README

(And I see that selftests/proc has started using $(TOOLS_INCLUDES), that's
progress.)

And now, it's possible to change fcntl.h in place, instead of using a wrapper.
Although either way seems OK to me. (I'm sort of ignoring the details of
the actual header file conflict itself, for now.)


> +
> +#endif /* _TOOLS_LINUX_PIDFD_H */
> diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
> index d731e3e76d5b..f5038c9dae14 100644
> --- a/tools/testing/selftests/pidfd/Makefile
> +++ b/tools/testing/selftests/pidfd/Makefile
> @@ -1,8 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-only
> -CFLAGS += -g $(KHDR_INCLUDES) -pthread -Wall
> +CFLAGS += -g -isystem $(top_srcdir)/tools/include $(KHDR_INCLUDES) -pthread -Wall

Instead, it would look like this, which now mostly matches selftests/mm/Makefile,
which is also helpful, because eventually this can be factored into a common
piece for all selftests:

     CFLAGS += -g -isystem $(KHDR_INCLUDES) $(TOOLS_INCLUDES) -pthread -Wall

I apologize for just now noticing this! And these kselftests shouldn't require
so much fussing around, I know. But once we get this just right, it will work
well and last a long time. :)

thanks,
-- 
John Hubbard

