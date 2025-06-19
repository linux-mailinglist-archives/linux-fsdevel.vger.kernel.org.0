Return-Path: <linux-fsdevel+bounces-52208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E045AE032B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 13:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 924FF1BC4C3C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 11:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E75D223710;
	Thu, 19 Jun 2025 11:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LWD1cmo0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2076.outbound.protection.outlook.com [40.107.101.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4373B221FB5;
	Thu, 19 Jun 2025 11:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750331610; cv=fail; b=Y2CAVrwp3ZnbyTA7CpSE2HdWaknvW2mQFgdCSdRdUX0m54tgX5IQK6HwiQmXexfLVgjrywqLAM5OORwWEukW9xfS1wN+u1NCdHPs5nqwnVacdH3B/yZdkaCD7VS/C1hfQQygIMWUrd2xgEY/qpFYKynBRq7Sdd8fbXd4eIQ9Glo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750331610; c=relaxed/simple;
	bh=+D2ogRkQvHoMQKt31ppTlICAckIl36Xy49Gi2LckRec=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K0QFQskpklEMeyYEWpjMoYhNluLAF7sfZYwpGwvjt4Ybtsl97siJ4Thgtl0Spr8nL/2hvO0gK15QTVGmfasXosm7R83rTFij6Vsx8/avDahkO52NEI4YRxvsLuTle4Kdj8mvHZSImYu2eARvcbF9eLHJSM/+W/BuNr0K/hYq8AY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LWD1cmo0; arc=fail smtp.client-ip=40.107.101.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DUQYrJeLY2mT+K57xLsjbVRNvVaqrExXnAqhvGzK7DHhCV/CKWYn9oQfXepJBm179njuQCy9c5hTpsWxMP2tGoZKliAQdhL/uTf6l/5p/56Jn9OjBZn+68VHCuN2Dg5ejhnewkLsca6l0ykDSgJXT+YLBd/DPC1gCgbU69Wt3IpOyN4K47M2sjFqYzuOgF2cPZ6trTJGLUuXuUkOiY9VKfFY5j2BM+XDvj5tJYW1GqhvDW3m/fbOpY/Ct602uBEUBZJy7HjM12LxaA3l5F4vSEuz3KEzimEpgmEOHi9I5RoX9cPjD9xp74I/L8u23lJiAvG+Czm65iZGOo6n2cHE/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DpOMMTdjB6BrY9M7K5wNsKOL5MirLyu39PCyT0SKg64=;
 b=LPM/9uSeHwlZL24fguDtjrAJLNwkN1IT5UalKAXcYBDKmFgPE2R/DPFcpnYrcblt8CnMoZku0bDVdXt4xPWPDzO68fPS+7/JMh4jiL8p9j55p+thLh0AYs5ZPZ1uFWfmkfcHcRUfJBxvN+cY47EP0513NRjvHT+d6mU7wSX4VfmgDeqdX2THs2LqLjCt3tlYsaKpUNNtqPDw5mQWGLGHQrMQaB40YIAui3cTU/GDaDIKdrFEkZNVF4v26JgCVZ7FMaLhMtxy6/rADcNaaXts53Ls6mrnRcMcvwUhXXrAZNsDIKCfyq7uZcC+SU30UdVftjalELSmj9weq/9URbxr6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpOMMTdjB6BrY9M7K5wNsKOL5MirLyu39PCyT0SKg64=;
 b=LWD1cmo0u4Hcxj2YkTZXFpUyPA0yJf+BH9//4/pbrKQT1ZFqb699B7YAr3zEHTVsr0BajcisAIxPOpOkksqz0G3ztVuwfV68P/fTkZrL6jj3eWTk3O99I3dfwflm6+e/HgsImGffvcDfATmgdauiSBXuDWQTaod11n1ev/X9Y6M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by SA3PR12MB9178.namprd12.prod.outlook.com (2603:10b6:806:396::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.36; Thu, 19 Jun
 2025 11:13:25 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870%5]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 11:13:24 +0000
Message-ID: <4267108c-ac26-4528-97cc-0d160568baee@amd.com>
Date: Thu, 19 Jun 2025 16:43:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v8 4/7] mm/mempolicy: Export memory policy symbols
To: Gregory Price <gourry@gourry.net>
Cc: seanjc@google.com, david@redhat.com, vbabka@suse.cz, willy@infradead.org,
 akpm@linux-foundation.org, shuah@kernel.org, pbonzini@redhat.com,
 brauner@kernel.org, viro@zeniv.linux.org.uk, ackerleytng@google.com,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, pvorel@suse.cz,
 bfoster@redhat.com, tabba@google.com, vannapurve@google.com,
 chao.gao@intel.com, bharata@amd.com, nikunj@amd.com, michael.day@amd.com,
 yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com,
 michael.roth@amd.com, aik@amd.com, jgg@nvidia.com, kalyazin@amazon.com,
 peterx@redhat.com, jack@suse.cz, rppt@kernel.org, hch@infradead.org,
 cgzones@googlemail.com, ira.weiny@intel.com, rientjes@google.com,
 roypat@amazon.co.uk, ziy@nvidia.com, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
 kent.overstreet@linux.dev, ying.huang@linux.alibaba.com, apopple@nvidia.com,
 chao.p.peng@intel.com, amit@infradead.org, ddutile@redhat.com,
 dan.j.williams@intel.com, ashish.kalra@amd.com, gshan@redhat.com,
 jgowans@amazon.com, pankaj.gupta@amd.com, papaluri@amd.com,
 yuzhao@google.com, suzuki.poulose@arm.com, quic_eberman@quicinc.com,
 aneeshkumar.kizhakeveetil@arm.com, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-coco@lists.linux.dev
References: <20250618112935.7629-1-shivankg@amd.com>
 <20250618112935.7629-5-shivankg@amd.com>
 <aFLXRtCDfoNzQym6@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <aFLXRtCDfoNzQym6@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::22) To CH2PR12MB4262.namprd12.prod.outlook.com
 (2603:10b6:610:af::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|SA3PR12MB9178:EE_
X-MS-Office365-Filtering-Correlation-Id: 6da1ae5a-f926-48dc-7735-08ddaf224ecc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVhhdk0vTVU0SERGaUNGemRZTEMwUXp6dlY0cTZHenJ6Z2JMODdHTDdOWElB?=
 =?utf-8?B?T3N2aDVkbnllNnpRaHMyd053N3hRbjBsNmpKY0dpVmJQVUlHay8rZTdLWGNM?=
 =?utf-8?B?WmtrUk94TmtuSTQ0WEpUVENaenRYakVhODBOQXhkSzlhcmpjVm5ocEdyQlRl?=
 =?utf-8?B?anJJUWhvVllRQnQwbmRqdFVsM1BYRGwzK2MwVkMrRnVtSVo3Y1VDaFhLSWNE?=
 =?utf-8?B?TUd6UmhqUGpNVEFUaFM3TE0zTllQeXNNazRVbG5CWjRmU3F2U3c2MHVsb0x1?=
 =?utf-8?B?cTREcUxjMUcwUUphaHk1N0FyMTc1ZkR5NlR1cThBQUdUa0JLWVIwMS9ZM3hR?=
 =?utf-8?B?NGlGMjJ1TzJJOWFWUjlLbk92WFRMbjZXZHplU2c5WEZ0SFpGRUNKR0JuR1Ex?=
 =?utf-8?B?RURQc0JLQzRxbnBwVzBuMmhHODZnTUZzUGR6ek5iVjRkd0ZPd28zeThLNTNq?=
 =?utf-8?B?MkpuOHUvSjVML2tUdnBhVURYemJTcWJ0M0laOE1MdzlvRTFZTHFKSmNqd3dF?=
 =?utf-8?B?cTl2Vnp1bVQ3TFRLWjN2L1NlSFArUllXNDFralhTMUxsQ3JOUEw4eGx6Vjli?=
 =?utf-8?B?N3ZRU3RxMG1VZ3diZEZrMXJyV1pRczJ3NnpweXRwbEpQdjdrN2RQMTU4ejJu?=
 =?utf-8?B?WW5EaVNNWHJCejhmUEM2b2w0VnBIUkpUd29sNnRIWis3MnQrSXdTcFhoZTds?=
 =?utf-8?B?czZhOVV1ZVVPQ2NZM3NnZ2lPcmx1YkUzYVhEbUV1WGlFWC91MWYwTHRtVjhK?=
 =?utf-8?B?Z09oZkxZR1prNDhSanlvdWdxNzZsb2FzV2w1M2ozOGplbUdhK1Jxd1FmWW5i?=
 =?utf-8?B?eWtlTUx1SVNGcFo0eUhDcjZIVWp4Ym4vYkJTdzZ1UUxqaUREd1JOQWdyYnpw?=
 =?utf-8?B?dkJiQ3NCRkt5eVVrNVFMZmk3aEozci9aVEo0MVBlSWFaYmVobjhhdS9KVHlK?=
 =?utf-8?B?RTR3OXFZWHo1RWdKRy85NTR5Nm8wQWsvRnIvVmd0enNIYllrWVRrTUovUjU3?=
 =?utf-8?B?R0R2VHNkcXdaUUdqcGtoZWs4eGtBNVRHZ25WWFdUeDlTVVQ1U2VRSE81VG5N?=
 =?utf-8?B?ZCswaDR2WHRFT3ZVMFdxVXFqVUNGV2dZY1IxWHF6QVBseUJZVFpVM05qeUNh?=
 =?utf-8?B?UDBNL2hHSFNMWnVjWmJhd2dqdnFlUlZ0MEpBbWZsNnJiWGNPOEZzUFJ4Q0g5?=
 =?utf-8?B?a0JXR2tSaVBsdHRwM2FNR0JqNWpINXdwWTJVMDRwcnp2YzBoSzZqMDBXM2Ro?=
 =?utf-8?B?TmRIQmJwT281dkE1ZHY3cG1OUmJPbC9BWGFKb1NyOHVhZHZ2YkZTeWc5VDhI?=
 =?utf-8?B?Z2NNMU5oVVU1ZncxZEdwSEk3b0ROMXI5aENtbVdMVCtQT0dsQVdjc0dyU3R6?=
 =?utf-8?B?ZnpTNnVEa0I2QkIrVzcvaUpXTm1XK25qRUtMUnFCb3R1dGM3clNZd1l1aEEr?=
 =?utf-8?B?RmZmQ24wZkU5Nno3dXh0b1REYnc5clR3aFI3YUttTzM4V0xnUkxvOHFtc3Bn?=
 =?utf-8?B?U3VpRjVpTldHYThLY1FybmNvTTJmWUhvUjB0MlVnMno2a2pmdE5JTUZmbTcx?=
 =?utf-8?B?WVE0MWVBYWRaS0lvYU1MdS8zajNyYmxLZExpSDdnYUtzbzErdmFQaW4yMzlW?=
 =?utf-8?B?d21DMFFZYmVEUG9EMkFaY2pxSUVYMEpoNEYzMS90a1dMYTFadTRWSDJMUm1i?=
 =?utf-8?B?ZnhSOWJHYk9Tc09VZ29ZWWVUZGNUOUhPNGpoL0xqeGxLYkx1S1NMNEVxMXpY?=
 =?utf-8?B?bXhnUHhtSGl0cjhCcXpxVDF6Z0hDZHZOcnQ3YnYzNFk0TkE5UE14Y3hyM0Fl?=
 =?utf-8?B?a1JnZUMzcVRDWFF1T3J0UG1lOTE0b2JpaENPVjROWjhpZU15WWNiYlVGTjdY?=
 =?utf-8?B?TFptVk5sTmxLdVNydjVmaVplK2RMYmp2UFB3MHhMS3ZsREZkZnBqRlNaZjRs?=
 =?utf-8?Q?vi0ZfYqDgk8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHdDM3hPRjV3ekVXa0RQaXNWWFcyOUVZRlpCMEwrc0d1N0RMYWdlNjJ4YXB6?=
 =?utf-8?B?cHkxZVB0Nk54V282UUhsK1pzU0tlbHEzbkZHVmJYYk5WL0lLWTlndXlpMUZ6?=
 =?utf-8?B?ck0vaDBwaWg3c2tzRU5odnlVZ29KSS8rWUh5eldsRUlkaWJINDc5dG8xQit4?=
 =?utf-8?B?TDBpd05CSmlGNUlzdFU0TlhBZ1plWEpaNUh5K1B0OGYwS21WOEM0eFZ2TlV3?=
 =?utf-8?B?cW4yWFpKZ1pLQ1o4K2MyYWZiNGhCeDN4Z215d2d6Nk5vMk15RGNtSGpoMjRX?=
 =?utf-8?B?RlU5VmRHRW5LN0tTNDdlSDZyd2Q0UDl0cUVIRHZtM2ZDejB5Y0VaYXJKNm5F?=
 =?utf-8?B?NFlrUmNjK0dGRTVIRm5JQld4UXFVeFFrZm9ONGJSd3Jtd3V6NkVDOGJPR1hk?=
 =?utf-8?B?K2h3VXBreFh2eFJZbTZhVmJacnVLcW82Nmx2eDl0ZkRVMW0wVU1FV0xUYW92?=
 =?utf-8?B?ekhQU2hjTEl3YWh0VEd1cEZIQkdGaGhHQ1pSV3BNSzdVaFkvV2UraVluVGpt?=
 =?utf-8?B?TG80M0E1S05TZWRsVjA3RllLdEpObUdBZkFUOE9vMkYrNjkxdXJhVHM3bWRp?=
 =?utf-8?B?cDBpbm5lOFhLU2E1UVVBUUxXakt4ajRobWFOc0xHcEVrUFNBYXhJVUF3d0c2?=
 =?utf-8?B?QXZ4ZTc3MnRKLzhXMVA5eGZUUVVsK0RqVk5iNkZKQm9rKzFRbm1PQlRpQkVh?=
 =?utf-8?B?OXZhNWZiV3RtZDc0UEhhZHlsS2xzby9ETXEzay9TaVJXU2YrL0grUnpLVWRp?=
 =?utf-8?B?a2J6NGQ0U3BvU2FpWk5aTHNSVERIR3QwbjU0L3JLZzNBTkdiK29pRmRpNUta?=
 =?utf-8?B?a1VZNUxGZUUwVUxjbjYzRjJmV2RpbWpzNXBhbk9icUlmVkJtQ1dOZkJqVDVP?=
 =?utf-8?B?OGpEOFNoc1hXVjYyYktxdTRLblpoWnZhcWs1MTVMbmlZWUt5S1ZpaGY2cmdk?=
 =?utf-8?B?T0xjZDFic0o4VW1oT3k3cWNscTZaWDZ2cldqVmxraFFlSlpqeXRxdW4xNm1r?=
 =?utf-8?B?RUY4eE1sNitOeXNUUzkyKy9TSXBmSWRwZVNVczlYSnNZMnR2KzloeTFDSzRk?=
 =?utf-8?B?TlptUng5K2d3ci96R2RvcWt6R3dUdHh6RWhHTG1RZnZFbGhBRjhMbStuZG5O?=
 =?utf-8?B?a1JDdklaZlg2N2o5bVVBb1RVckJXc2hKL0xVRkdsNkw1dXFuT0NvaW1oQkpM?=
 =?utf-8?B?WkV4SmlnV1dxaTdHMkhMSHI0aGZpSWhNbUNhSVRTK3UzUjhYWkNWUEc2eFY1?=
 =?utf-8?B?TUtOSjZaSTF3RHRjdVg5ZFAyWjdqNWROV0NEK1h0eGFZQXpOaE1iL244QnEy?=
 =?utf-8?B?L2pxNTN4V1ZzS1M5Zjh1VFFmY0FackxOUCtmRmIweTlnbmpsa0hVZWNHUGJq?=
 =?utf-8?B?RnFOT3pZRXZoUTlwYVE2NElyTUhjb20vVVFlSm1mRnJ4U09qcDZhOVh0MXJH?=
 =?utf-8?B?Nmg5cG5uL3dhVkNGNHR3TWxLQTJ0NlhmQTI0cTB1T2VldVFFSWx1ZjR2a05T?=
 =?utf-8?B?QkNNZWhHTWNyY3JPSU1uL01tcnFWMDY2RTlrRzlFVERoWFlXRzZWWUUrVHBj?=
 =?utf-8?B?TVVnNllBbGNYd3pUZEdZRVVTN1BIcjVYNERITUFhay9HdkRIQ2RlTGRnb2Ra?=
 =?utf-8?B?REV6YVZXU3daTUNGZEFSdlRuVXEwcSt4QjYvNnlZdVRKZ3BxS1N0aTFrSkJ4?=
 =?utf-8?B?ZktoTERybWg3Z0w4Z0V0Q1VwQUd3ZnN5V2d5NWZ4bEIzWVJzWlFPSHB4TTBy?=
 =?utf-8?B?dHpTNklaZC95aWNNNGJqalQxLzVIOXF1bGhuUTVYOEoyNGp1cnNRWG8yaTlF?=
 =?utf-8?B?bC8vNzgwMVBXZk8zdGlaSXlSc2psYU1lUzJMN3NSNTcwYWZCYmRtRUcxWmZl?=
 =?utf-8?B?NmdjMmEydmhCY0NSNENUUGxIYVF0M21MaFQrTG01Rld4OHdET1ZBQlE2aklL?=
 =?utf-8?B?MElubHp2THFwOGdpTTVmVEhRYWNpc0VTWmlWeU1XYXlJVWtSUnpmYUs4Y3VV?=
 =?utf-8?B?eW1Mc2I1Y2VPK21JY3J1SzZ1UEd1am43MjRSSFo3RnlxNk9zLzIxazVMNUxm?=
 =?utf-8?B?ZE9BUHBqd3lLWjU3MTU3ZEtiZUxGOC9jWS9rbVlnMUt3MG91d2NyNTVuZ00w?=
 =?utf-8?Q?utzaa49KUsriS74NwJ4PYrwy1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da1ae5a-f926-48dc-7735-08ddaf224ecc
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 11:13:24.6368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z2W2SBhDTnyN1P2wln9L5cX00Lrsv5FZnr2M8ZuTrXy7vnJDWLaNBnEF22yKKW91/xUey0phZa4Ma0HR2t+NIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9178



On 6/18/2025 8:42 PM, Gregory Price wrote:
> On Wed, Jun 18, 2025 at 11:29:32AM +0000, Shivank Garg wrote:
>> KVM guest_memfd wants to implement support for NUMA policies just like
>> shmem already does using the shared policy infrastructure. As
>> guest_memfd currently resides in KVM module code, we have to export the
>> relevant symbols.
>>
>> In the future, guest_memfd might be moved to core-mm, at which point the
>> symbols no longer would have to be exported. When/if that happens is
>> still unclear.
>>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>> Signed-off-by: Shivank Garg <shivankg@amd.com>
>> ---
>>  mm/mempolicy.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
>> index 3b1dfd08338b..d98243cdf090 100644
>> --- a/mm/mempolicy.c
>> +++ b/mm/mempolicy.c
>> @@ -354,6 +354,7 @@ struct mempolicy *get_task_policy(struct task_struct *p)
>>  
>>  	return &default_policy;
>>  }
>> +EXPORT_SYMBOL_GPL(get_task_policy);
>>  
>>  static const struct mempolicy_operations {
>>  	int (*create)(struct mempolicy *pol, const nodemask_t *nodes);
>> @@ -487,6 +488,7 @@ void __mpol_put(struct mempolicy *pol)
>>  		return;
>>  	kmem_cache_free(policy_cache, pol);
>>  }
>> +EXPORT_SYMBOL_GPL(__mpol_put);
>>  
> 
> I'm concerned that get_task_policy doesn't actually increment the policy
> refcount - and mpol_cond_put only decrements the refcount for shared
> policies (vma policies) - while __mpol_put decrements it unconditionally.
> 
> If you look at how get_task_policy is used internally to mempolicy,
> you'll find that it either completes the operation in the context of the
> task lock (allocation time) or it calls mpol_get afterwards.

I agree. But the semantics of my usage isn't new. shmem use this in same way.

I think the alloc_frozen_pages_noprof(), alloc_pages_bulk_mempolicy_noprof()
calls get_task_policy without task_lock or calling mpol_get.

> 
> Exporting this as-is creates a triping hazard, if only because get/put
> naming implies reference counting.

Since KVM is the only user, we could consider newly added EXPORT_SYMBOL_GPL_FOR_MODULES(..., "kvm")
to avoid wider exposure.
Does this solve your concern?
Or should we rename these functions.
What should be the preferred approach?

Thanks,
Shivank

