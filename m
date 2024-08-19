Return-Path: <linux-fsdevel+bounces-26316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4AC9574A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 21:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16138B21DD6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 19:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354271DC488;
	Mon, 19 Aug 2024 19:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aVSIkUgo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2050.outbound.protection.outlook.com [40.107.100.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CEF14A0A4;
	Mon, 19 Aug 2024 19:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724096541; cv=fail; b=bS8X2eXYwxqMLvEBhtn6k9h08Nd6dWa61KDAolyYJ/Ha6iqvFCF8eOVxA4wSon6m0eXYDeJbmU7Qm+1Kdp7+5FU0RgxzVhjQKJHhv5P3xi62v5DxK/m8AVnfuhDZNPe7ZnD3RCsJ+FtmGpIyQUP364M1VRXnpFuTWeQoA+BVP88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724096541; c=relaxed/simple;
	bh=rUOHA/0IxBgW8y3ZNr6PV0nFBKceQOO2kqUs+KdXssY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dYuSt8yQsxDScfd6/uyTZQDooCA/SU56iVN5K+2MBoZvjbRC+vednpxxTKDsvHKZa0sQPxsl21U/uitHdcbVBKWt3LepZbo3naAi7UssY9sjD1LaBAtSouWOHcYym9YYECm9Sj0+ZS7eCXti3GRtkzkXKmO8AHzAfahhs6EKkuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aVSIkUgo; arc=fail smtp.client-ip=40.107.100.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aHIVkCwY9F+sKUQtc4+fh7irkB2mmNFuYhMONsBhg/ljTlY20nnYht8FN7rH9ixFhr4LVHbG3UwWka11IxwMAUQj89oTzJlafOoRn14ebd0ul5lExpJfKRkyeYKjM8eaBGIp7utBriHf9bvrtxqGDzEAP4UVEE0lvy4I9KzYAZ9JnzxW7tmy+6VprDN38iya7Xdh2/hJxKBD1Yel3oCYTHVJSzYOc2NfDco+Xr0u6EPMUw2hD9pFm/Hmm0DK2wL/3MOOoQePUEEWCxiniJku/o2nAcZSPLVSGNteUvVp1UZftUHPrQMfZ8J50qRGPNw+DalJYtusQchy+LRfaZ7R6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVAEuV0Iupcs3iGtRwSvUMpGe7R6df4qBripJQmUZPQ=;
 b=ToeGaJHKu3B3kdvO1USQ8ARtjDqQpn2rZpRZTLw9F1HrIe3Q2Jmo8Y5MsMTiqHrgm/G9mLnqBzL3RidYWCkZkDkP0crwHK96RBuQxRsYtcYAd6Nl4KwjEM9M+Ra3cvdFOQkYKxf32x601hJEfB3a1P2BzDO0bW/24XoSDbWXaB3BGseslslVheEi+3+24G9fxVaB9gcqXThvYqireU3ZoVy3qJYAHkOmiVipGoaYSW0O+4oSpaTeFe5PpFNQVPRXDw4a6Tbs0lreGuQZUUL3RAmnEQuy+iyd2RKpettD/n8yPtRG8CE1USEFvr4qHCWQa7M7gLWCZq/ggDDrVvzu9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=collabora.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVAEuV0Iupcs3iGtRwSvUMpGe7R6df4qBripJQmUZPQ=;
 b=aVSIkUgo3DU9tER6HZgnaE/u1omlH6k6RyJ4tjfxGWinrmtbBlieJ1q8yVzqCUD9hE/IIaBhYTUAiSIEssW+rVTnjOd1Gqs5YY8MHUoNdPSKBCWxR4IQg/1iJm+VsZEOvhT93vj03kMl4QJXqN25FXd1HONWbVXqi8yWAtO/rYclT2OOseea4APs1pmxHhq8HTEwm23rKBU3AbN3mYXtMfU1Mg9EpqybWhn81pRayIwZPATkdOAXnIOACOWuKV6xiq4XbK2D30X0nG0uAW1T9VWtsrNucydxDiuShrhmplk0c0y98RgI5MavVcfEAe4N3O5NHo0YSycFZ9wDJhrZAQ==
Received: from SA1P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::33)
 by DS7PR12MB6191.namprd12.prod.outlook.com (2603:10b6:8:98::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 19:42:12 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:806:22c:cafe::2f) by SA1P222CA0015.outlook.office365.com
 (2603:10b6:806:22c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Mon, 19 Aug 2024 19:42:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Mon, 19 Aug 2024 19:42:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 19 Aug
 2024 12:41:57 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 19 Aug
 2024 12:41:56 -0700
Message-ID: <0c6ff7bb-8a22-403d-b015-aa20c907df8f@nvidia.com>
Date: Mon, 19 Aug 2024 12:41:55 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] selftests/exec: Build both static and non-static
 load_address tests
To: Muhammad Usama Anjum <Usama.Anjum@collabora.com>, Kees Cook
	<keescook@chromium.org>
CC: "H . J . Lu" <hjl.tools@gmail.com>, Chris Kennelly <ckennelly@google.com>,
	Eric Biederman <ebiederm@xmission.com>, Shuah Khan <shuah@kernel.org>,
	Fangrui Song <maskray@google.com>, Andrew Morton <akpm@linux-foundation.org>,
	Yang Yingliang <yangyingliang@huawei.com>, <linux-mm@kvack.org>,
	<linux-kselftest@vger.kernel.org>, Mike Rapoport <rppt@kernel.org>, "Rui
 Salvaterra" <rsalvaterra@gmail.com>, Victor Stinner <vstinner@redhat.com>,
	"Jan Palus" <jpalus@fastmail.com>, Al Viro <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>
References: <20240508172848.work.131-kees@kernel.org>
 <20240508173149.677910-1-keescook@chromium.org>
 <1f6a2905-395d-4f81-9ee0-57c541fb2486@nvidia.com>
 <202405082312.D922795@keescook>
 <a1e8ab86-64e1-4cf1-bd2f-145b4c173e6d@collabora.com>
 <c2ed3020-f0c7-4077-aa63-648f7cd6bc75@collabora.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <c2ed3020-f0c7-4077-aa63-648f7cd6bc75@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|DS7PR12MB6191:EE_
X-MS-Office365-Filtering-Correlation-Id: 509024cb-ef74-496b-0587-08dcc0870523
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHFFQ0tORkdxT2NRdW15bUNkYWw2WlVjSmlzTFFNYzVKTldScDFwTXorYURh?=
 =?utf-8?B?aldWZGRNbFdDbGMvT3cxeDBsdWt0UEYxOU1XRXdETnhjSk9wNEVLU0IxcTU0?=
 =?utf-8?B?QmVSMmY2bFl0dlVMQ2tDeDdnalpNQ0xqa1R0cjZoRm5nR25qTTVvRHRJNno2?=
 =?utf-8?B?V0xPL2ZHdjdSK3dpUlNYd0I3Lzd2SStpQk9aQWgzc2crU0NQMVo4ZThHUkpr?=
 =?utf-8?B?UTBZUVlkTFExSkQ3MDU0eDBqMjFWRkhyMmRPVmJUTUhLS0F0ZVVSZENPOVFt?=
 =?utf-8?B?R1NDZnk5V1d4UTV4UUJhM2xxQ2J0T0JtUWJwWXJIbHlwTmxEak05cXNScVRu?=
 =?utf-8?B?azJaUzJnRHBGUnIreFNRN1gxbzhWVjBlUmZMMG52aHpLc2svckprZS9qbzhx?=
 =?utf-8?B?d3ZOVzcwUExNNXZNYWRjNHNTeGdOcVRoMlNHREtBc3VMZDlEU1dIcjc0WThM?=
 =?utf-8?B?RWVxUUJnZVpnZmRxVnZObk1ySUl5Y3l1TTZoTXJHUUw1TkVmcEdzMUFwR0kx?=
 =?utf-8?B?bTY4SzI0ZlVTekJ4dHVCeUlaUEQ5Y3N3R2Z3QlptZFNoc3NtUGJDWEVHeG5m?=
 =?utf-8?B?TUhySzltanM1cTdFWDNkclpoZ1FMVG94blFneTl2alpxN3dnWlpBd1dzdUVP?=
 =?utf-8?B?YjAyZUVQdDc2dGNQU1JSYjN6dEZDWkwxRlJXU0RrS2NnaXRzRVhncXZTa25x?=
 =?utf-8?B?bVViSjUrdGFsUlk4R1pnakQyMXFGUGhMck5ZNGYrRENYcFBxeFVXTjMvZVhr?=
 =?utf-8?B?R0x6dzIyb2dPMFZ0VTVjdm1pOVM2ZEd0Q2NqOTFEcVA5dU45bDVhOGFRYjhs?=
 =?utf-8?B?VFBBRFJ0UGF2d2ViN0o2VXpLQjN3M016T05KdC9wWUtqbXlJQ2V1NmRBRzV4?=
 =?utf-8?B?TDd0MmhscVh5bWMzODVvYlJHSGhUVUE0eWh1QXpnL0FRVTFqSjVXQ2l6L2dU?=
 =?utf-8?B?cjlhZ3VnK0RrdWZQSHJIU2M5U3l6M2E0K0ExZFRlcXBWQ1JkTnpTZUh2OFhT?=
 =?utf-8?B?ajFrVVcxWVUyUGhGbWdhREh6NWIwVXIveGJHQm05dkNML2lpd0czVVVhYUVt?=
 =?utf-8?B?czJRZWlZSTUrL2hva1VJK3VVZis1dVp1UDhMWlk0OGZZczJPWHBiUFBRRXp3?=
 =?utf-8?B?M1o0bUpsL1Z2UmVxU1M1c0NQY241a3BpL3RpekRuc2Rud3B4NlJnOXNvOENB?=
 =?utf-8?B?TVhkajNkOTZqM0xsL3JDNnF2NUZ3b2QwclEwZU45M0JhRGhnMndnVVRlTGpE?=
 =?utf-8?B?U3pJdEpPWldqU0NJSlBKbDdZSXd4R1VWcUErR082OUVwdHJCYTFtb0FJK3Fw?=
 =?utf-8?B?WXNsK1djQUVLT3hob2RJc0VnWFdtRXU3TFNudC9vSXpnYXNXL0E0Nkw3RE5h?=
 =?utf-8?B?emhhYWIyWTVTVFo4dzZZbE16OGpBR0hGb0M4MEt4eTJyQTBhVG12ekxrcG9Y?=
 =?utf-8?B?M1U5Y1FXUHpBTXpSRzRBWmo2WHc1ZU5scFdVeXgwcnhIdVNtTlN4c0MvRXBs?=
 =?utf-8?B?cTBYZlA1c2lIei9VT1VLaUYzeXNQYU5WWEZjUmE2WnljSU9lTVhHOVY4djh1?=
 =?utf-8?B?SmJ6YUd4SE5SbGswTllJR3FYRHUrUVU0b3VRWVNrY3d6Q1QxS01na3JXcnls?=
 =?utf-8?B?elFOcHRjYThtRUZhZDBxb1JQU1VaY0N2QWlTVHJ3UzIzOGduMDhUeXArbWxL?=
 =?utf-8?B?cjZETUxnZW9WVXFzNEJzWkdManhCTzdEMm5JV1czMGJNcTVEK3dzMkxhV3ZG?=
 =?utf-8?B?Ui9qT3NCM05OcUVQUWVmUFZNSlV1bktQVkh6Q0ZHVEhXTW1lQXJGZ21Cd0hl?=
 =?utf-8?B?REJab0hEc29Tbk1yU080Z2xsYVZBWE5SUitzMjVBbUxoUEFKblY3U2lXek1t?=
 =?utf-8?B?MmQyQVA3LzZrQkpWSWhvcndNSkhMOHhBM3hBRjd4S1FiSG5FZWMxSkZZb2hy?=
 =?utf-8?Q?rmwiO/EO4wOd/ahgYrQ9eglQHw5mfcpi?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 19:42:11.7504
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 509024cb-ef74-496b-0587-08dcc0870523
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6191

On 8/18/24 8:55 PM, Muhammad Usama Anjum wrote:
> On 8/7/24 3:22 PM, Muhammad Usama Anjum wrote:
>> On 5/9/24 11:16 AM, Kees Cook wrote:
>>> On Wed, May 08, 2024 at 07:54:13PM -0700, John Hubbard wrote:
>>>> Didn't we learn recently, though, that -static-pie is gcc 8.1+, while the
>>>> kernel's minimum gcc version is 5?
>>>
>>> Yes, that's true. If we encounter anyone trying to build the selftests
>>> with <8.1 I think we'll have to add a compiler version test in the
>>> Makefile to exclude the static pie tests.
>>>
>>> There's also the potential issue with arm64 builds that caused the
>>> original attempt at -static. We'll likely need an exclusion there too.
>>>
>> I'm not getting failures for arm64 instead for arm. I'm trying to find
>> this "rcrt1.o" file. Does anybody have any idea if this error can be
>> resolved by missing file or is it something arm-linux-gnueabihf
>> toolchain doesn't support?
> Do you have any idea?

Yes, I took a closer look just now:

> 
>>
>> make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-
>> arm-linux-gnueabihf-gcc -Wall -Wno-nonnull -D_GNU_SOURCE=
>> -Wl,-z,max-page-size=0x1000 \
>>          -fPIE -static-pie load_address.c -o
>> /home/usama/repos/kernel/linux_mainline/tools/testing/selftests/exec/load_address.static.0x1000
>> /usr/lib/gcc-cross/arm-linux-gnueabihf/12/../../../../arm-linux-gnueabihf/bin/ld:
>> cannot find rcrt1.o: No such file or directory
>> collect2: error: ld returned 1 exit status
>> make: *** [Makefile:39:
>> /home/usama/repos/kernel/linux_mainline/tools/testing/selftests/exec/load_address.static.0x1000]
>> Error 1
> 

This appears to be because that particular cross compiler setup
(the libc part of the installation) fails to include rcrt1.o. I was
able to reproduce this on Ubuntu 23.04, using their standard arm
cross compilation packages for gcc and libc.

Also, -static-pie is what is causing the linker to look for rcrt1.o.
If you change the invocation from "-static-pie" to "-static -pie",
then linking succeeds.

Putting all of this together, I think we were are seeing is that
even though "-static-pie" was added to gcc 8.1+, and even though
the cross-compiler installation here shows gcc 12.3.0, the libc
support for that feature is lagging. In other words, the cross
installation of libc is effectively at something earlier than
gcc 8.1's needs.

So I think this means that we need to fix up the distros'packages,
and meanwhile, fall back to something like "-static-pie" for
selftests.

thanks,
-- 
John Hubbard
NVIDIA
  



