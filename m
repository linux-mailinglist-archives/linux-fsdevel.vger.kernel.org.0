Return-Path: <linux-fsdevel+bounces-26317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 326EB957503
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 21:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF20C2833C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 19:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADA91DD381;
	Mon, 19 Aug 2024 19:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pc8w1r77"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EC0186E56;
	Mon, 19 Aug 2024 19:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724097189; cv=fail; b=EBgg7uACdtiGbx2m+sWUcQZxrJx0bvOFDXCK42fF46T6MfaM1kn9diRp+rC4dNaG8h1DIYuT5BPa8/EjnOmbBLLfyt1sN+fEyAMs/cDNXxnua15ks2tO0htRa9fTDsH/rQkC0YrDQUaD61xgLrOLRPj1nQ3wPhNL/3Uis/lVf2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724097189; c=relaxed/simple;
	bh=kl6XqShBcQx2AT7SAwvwyjDKs9EauOFL2Te26mRIWQo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=PeGoJkgPsPhimfaZjCYu8nuZreKV2ThZ4bzdFLc4Fab+1iEMFNLfNKg6lLNLxlbi5GPmjCya9FPlQxnrzlkMJaCBmMSD2rEoKtYMgxwpu71GKdCsY/e6MpFoKZ0mrIMuh0hlg+uP5lDSTa6t46u1Ki60OD58PFkmtLVyRQDzpyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pc8w1r77; arc=fail smtp.client-ip=40.107.92.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMS+uVaizTO1vtBR7JPlMBmqZgQGfYRK3mgJ8AnJb+KJBydNtQ54bbGp2fkL2WG2N/JDiSz3hsS2dlYRJkBJFRJIUlhsd0/5HZq22YF5b5oa+SAecjQldLjMhO66Y+XweFL5wJZJoOpb0CnumVC0OuiyYUTmKGk1+w+5HhozX6Z41fupAShBAGBVY8Dmpum8uG47uV4SoI5ia/D70yiEGjBmyUQ/h4EatOMuknZ0DQwSQV7NINQvqL/jmpY8frQdwxfKAdg2MD/ZbC9z31qIRLjQzC/dIopxXPBDyv7hzx6Ud5KKvQuC+u2ywyApE5GKkKggmpy/TL514eZO7VCmiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gv204l3FJ0hIf5GsFSXSU9jTsthZZ/YewAq866sd14I=;
 b=AAviGpaoeTLm2xe64u6XnSRtk/6BDJNTDnXb95BoXdo2rmVtYD+h7iSUKKPeVpM0N9USFPCcDPpS62JxgWVJHlgBDeXpJWB6MZFQsE8/AF5xG1b7kQinjKUs+cCShXgIKoMwtNh9RyU1WnoyWphA1s/doOxVZr1tPPkdtQC+aC0hSdNXt6klmtB/27Mu5lGdY6in3SF5bl1ziqSaFnub0kueiVdiWWhXrj3xJga2NWECtjGGQlH4WLEKLga/u+LB0JqDhQAXfn1pUg2ZxOnX3g21FQVYkbC0XmJUOlkykMBU0rO9ARkNw8j33FyudmvVzix96JNSWc7jY+h5QXUzXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=collabora.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gv204l3FJ0hIf5GsFSXSU9jTsthZZ/YewAq866sd14I=;
 b=pc8w1r77fmsXNJGoJn+Av8H9llMGb3Xjuz96Bf2nUYUgk+oiCCToSb1FER7YqsKEeEMrBxwgyNq0IrZFBAEi9ixAQ3sSMWK5EOrH4qrsdnPOz/3N0QMtUxR8oQVjPmD2SrVbcck0DgNofU8jcgD/egv4C7qyjfF4aJ55pkJ3YCeisL9y9V3Vs+NAes6OscwejKQXBbCVYBX3omMRK9akrhTjElIlHo2KxUYeRag38e/rIgAtTXg57pF6eaVjksvgSgWl2dLGXpVq1oFrTfGF90WqXY3mb46tj9o1sI+5Zq9ZPqtVGSUs+eoVJJSEEfti4uqpBYK/3MGIIJlMKiS+KA==
Received: from CY5PR15CA0135.namprd15.prod.outlook.com (2603:10b6:930:68::25)
 by DS0PR12MB7654.namprd12.prod.outlook.com (2603:10b6:8:11d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 19:53:03 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:930:68:cafe::a8) by CY5PR15CA0135.outlook.office365.com
 (2603:10b6:930:68::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Mon, 19 Aug 2024 19:53:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Mon, 19 Aug 2024 19:53:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 19 Aug
 2024 12:52:41 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 19 Aug
 2024 12:52:40 -0700
Message-ID: <6b98f32c-5ce6-44cb-9288-1348c7e50909@nvidia.com>
Date: Mon, 19 Aug 2024 12:52:40 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] selftests/exec: Build both static and non-static
 load_address tests
From: John Hubbard <jhubbard@nvidia.com>
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
 <0c6ff7bb-8a22-403d-b015-aa20c907df8f@nvidia.com>
Content-Language: en-US
In-Reply-To: <0c6ff7bb-8a22-403d-b015-aa20c907df8f@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|DS0PR12MB7654:EE_
X-MS-Office365-Filtering-Correlation-Id: 99f68380-0290-42e7-b558-08dcc088893e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1NYQzB1VzF2ZXB1aXhLVzFFZzZTQ2Y2eEtmWk1HMHdvcmR3a09Tejc1d1Ay?=
 =?utf-8?B?VldoZEFwekZTT1NoKzRCaHE1cnJ1ZzFWZEZ6YVRKaDU5K2l6ZG5LbVVSU0JB?=
 =?utf-8?B?YmpwTUpFTFRXZFE1ekJEVUpWM3hBNW8xdkFSV2Zxb0JOT0dqbE5FT2R1eE10?=
 =?utf-8?B?WEd6cUt6cGU3WWQ4ZER3eUxDZTFhTlIxdXU0K3dqMm0rRUxLMkhlYzNzTUFD?=
 =?utf-8?B?ZGQ4aEpzU2xad0dJeC96Q1ZHZStpYnNhVlBZK0k5bC81RHJsS0NOcU9lTFlF?=
 =?utf-8?B?VzhuUDY3NDU5M25tblNqeWpSRGxOcGQweDNETzFoVnBpSGc2WGFWUkJOMTNs?=
 =?utf-8?B?RFlOYTFRWm01OUM1b1B4S2tvUklwdnhId3dZY3ZCWjdHbVZPdWltOEp4T3VV?=
 =?utf-8?B?SmJ3NEQ2UzFhcS9EUHp5TWNYaDRmbVdiQ2lBOGhVNTlrZk4rNUxQdXNnMTda?=
 =?utf-8?B?eVZQeG5NbSt3NnNaK2lFUTlJcEdQY25hUHlVT0dGdHZjMDVCMy9oa1luNHFs?=
 =?utf-8?B?RWlGdmtSK1F5TWhCQ29WQTRmK0JodnpqQUpwTnVwcWtmSHdGZXErWUlUcjVG?=
 =?utf-8?B?bmludzJlb2hwVUljRm1mSTY3b0UwYXFoeG1PYU04N3I4QU05NnNVYWlDU2Vk?=
 =?utf-8?B?UEVBMEk0SnlxeXZDVlpMOG1iVHFBV2NFTnVtbGJwcHgwTnJhMDJ3OU84Vm5n?=
 =?utf-8?B?V3dCeXI2Vy8xTmZ2Z3FwWVNQYkNyWEJuckU2Qks3eW84NlRQWU1jY2puOGth?=
 =?utf-8?B?UjlQUDNIU0RvZzJxMXdDV2s4NE1QR3QwS1NFa1lJMk11aiswLytDdlBxcnFL?=
 =?utf-8?B?NVJJb2dYQVRWcVA3VUdFcFZMMlIzMHZESjVrNWY0cWY5cVM4K2d4Mlp3V2NH?=
 =?utf-8?B?MmYxdWxndnJqZ01VZW13V2I2WG9zZnV2dUVzZ2FYOFlxMlJMOWhUNzJPWnN0?=
 =?utf-8?B?MGxGcml2ZHY0M0lHM3pEL1F5dEdvUFlIbnRRdnhiaWU5NHpPRnFPc0xCaWxK?=
 =?utf-8?B?Q1hVUW5ScHpHU24vM0NLdGEwazVRS1FTWGlZWTM2TE1wM3lUd1RhUTQrYzdC?=
 =?utf-8?B?MGFpbUNodWJFdUcyTmtzY1F5bXVDWEVacUZYd1d3OWZtd3IwUkNBZmJqalFy?=
 =?utf-8?B?QjRZUmVJdkJOQ05uTGk5YnF1NFB1S3dRcDdmbmhRU0drRnJJQ0N1Z0NoMXRC?=
 =?utf-8?B?Yi9Ydk9aMG1wRllPMHkxYlYrVnBHdzlTT2pvRGdjc290ZVZ2ZmZJTHpDeE1t?=
 =?utf-8?B?MnpQZXBxajVXOXFMVG5STGowZGc2dUNSRG9yT2h6anZZTWlCeHk1VzlINGoy?=
 =?utf-8?B?Q0lvUTNhZGwrQ0NQd01paU5SLzhRZHRicndhc3VmSllxck8xbytpZDhSd0Rn?=
 =?utf-8?B?MHZoYkNQcjdKVTc0Q1RaSVVKTWV0bzRVQ0lYcEdnTEt0V1RZaFlPNzUrT25V?=
 =?utf-8?B?MitURUM2b2RGR2o5eC9tMGZrSlJYOXkweU5ITlJoc0ZzV0NwcGRXSDVQU1Bs?=
 =?utf-8?B?Q0dPV2RKOEFpMUJQZXRFNnR5dDZyS0FlWWNMUi9IZG4xMFhHQXVkSWpVRmUz?=
 =?utf-8?B?SlVzQTJEWTFjcERsL0QybGV2WlNJQUc5Q1NDcnorTUQ5bHRJb1lQSWJ5OU4x?=
 =?utf-8?B?eHloZUJkTzZHTllEL0RRenpycGxaVmhPT3dsK2FBUFdiL3BWRXpJaHdiN1Z1?=
 =?utf-8?B?bnlqRjdiZTdWM1F3T0FYcEw4Tmx4eng0UURkV0JDajJkMGgyanZXdlNTU3l4?=
 =?utf-8?B?THVyZjFJaDlGTysyc2Qxbkg1NkZTQlBYZUVhNFZMOXpmZjF3elgwekk3Rjk0?=
 =?utf-8?B?V2ZqN1NDUFZLL09XR2ZTOXhva2pJNUE1T2VRZ2FBblV5WCsxaDQ1bHJVRHBK?=
 =?utf-8?B?Q1lpVVdVRGF3dExtZkorZW1HdTVNQjRva1NwcFVObHJ2dDlmK2VTc3QyMVVH?=
 =?utf-8?Q?fmKiYvlV+pimmGpNg/qeVoQ7x9FflKUo?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 19:53:02.9035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f68380-0290-42e7-b558-08dcc088893e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7654

On 8/19/24 12:41 PM, John Hubbard wrote:
> On 8/18/24 8:55 PM, Muhammad Usama Anjum wrote:
>> On 8/7/24 3:22 PM, Muhammad Usama Anjum wrote:
>>> On 5/9/24 11:16 AM, Kees Cook wrote:
...
>>> make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-
>>> arm-linux-gnueabihf-gcc -Wall -Wno-nonnull -D_GNU_SOURCE=
>>> -Wl,-z,max-page-size=0x1000 \
>>>          -fPIE -static-pie load_address.c -o
>>> /home/usama/repos/kernel/linux_mainline/tools/testing/selftests/exec/load_address.static.0x1000
>>> /usr/lib/gcc-cross/arm-linux-gnueabihf/12/../../../../arm-linux-gnueabihf/bin/ld:
>>> cannot find rcrt1.o: No such file or directory
>>> collect2: error: ld returned 1 exit status
>>> make: *** [Makefile:39:
>>> /home/usama/repos/kernel/linux_mainline/tools/testing/selftests/exec/load_address.static.0x1000]
>>> Error 1
> 
> This appears to be because that particular cross compiler setup
> (the libc part of the installation) fails to include rcrt1.o. I was
> able to reproduce this on Ubuntu 23.04, using their standard arm
> cross compilation packages for gcc and libc.
> 
> Also, -static-pie is what is causing the linker to look for rcrt1.o.
> If you change the invocation from "-static-pie" to "-static -pie",
> then linking succeeds.
> 
> Putting all of this together, I think we were are seeing is that
> even though "-static-pie" was added to gcc 8.1+, and even though
> the cross-compiler installation here shows gcc 12.3.0, the libc
> support for that feature is lagging. In other words, the cross
> installation of libc is effectively at something earlier than
> gcc 8.1's needs.
> 
> So I think this means that we need to fix up the distros'packages,
> and meanwhile, fall back to something like "-static-pie" for
> selftests.
> 

Or, another way of handling this would be to say, "gcc 8.1 is
sufficiently old, and cross-compiling of kselftests is sufficiently
rare, that we can wait for the cross compilers to catch up.

Until then, only native builds of kselftests are supported".

Shuah, you would know whether or not that's a reasonable thing
to claim--what do you think? I'm just trying to list all of the
options so that people can decide which way to go here.


thanks,
-- 
John Hubbard
NVIDIA


