Return-Path: <linux-fsdevel+bounces-52480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F08F6AE357D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 08:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9047A188E9AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 06:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409CC1E261F;
	Mon, 23 Jun 2025 06:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Br7u0j8y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2075.outbound.protection.outlook.com [40.107.101.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DAC126BFF;
	Mon, 23 Jun 2025 06:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750659236; cv=fail; b=rDl+20/e842Fs7MTt6mNyMkho2QkMv5pVENy29L0Zlt7URda2wLrlgXrSZ1Pn8XM0vjZBCnCmQh3EjlZTnJE8AgpvmHYdJh79wIyQpbZ92Io4RJE0EeVVSPvsKoxfP17TwfCFPAqysGwpeiqaN8DSE+rSKAxUkHV2+zdi9j0qEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750659236; c=relaxed/simple;
	bh=VhizUotUWN2GZFadyIJ40/ZuFURbJtwJ35RyAFcx8t4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WLzbEvxjlRs3gyZBU9udZVSf4R1l7sJgYdzFdBr8Nc4uUTsq6yZCSEk4qguNoRDuq8A1X+82kbiFIQgcWNt11wqF0K6Icn2Zp/KBUSBLkTndfZ1DaX0Pfo2h3BORrqWEnZnt+bDcEkC4gYM4tci2Pgb2eCcdyi+AH9UG+XjnW/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Br7u0j8y; arc=fail smtp.client-ip=40.107.101.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3BC/YD8yfzrtc2cmgBD3lDOfb7Wbag4f47iBdlRX86t5jEw98yZ1dOkmaHPuZyB1UfprEFBsQyg7qyZgtzhdwoJjGNmEbfasojhTXHPDSCTNjG9mI9VZN37+fezx7/N61NdObt6n7KY0uiqEimfyG84jesay73EYtyo9U088K7QBfNFRwXaJIHQsvUq07uMpSffTzWDZWGf2yR7F7fVW+pZehtfJf9Ul+CaO9gsDq5qvgd14a211bxaUJiK/tseqpIKu0JcPCeIA6eL3wv+ak7WpaBo73asyGsTRozgRwUMQnDVQHp1vsDbzmZFk25sqVG18iGc0vYVqwT1ek+9sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFD6fN2zaXu7xoebl4vI8TgZXLEmFpQZeOvSJrG9tu8=;
 b=Pjg+yehtjyHIB6g21T36L3b7+aJh5eUDNAwEGg3x1JQm/Nn7HbWOrM9XlDMv/4TZP0KjaLRCkPXlYG8d4NBPhlOVBFvO3gphAnzJ1YNYkpedOasn/pLD1mvTKAvw6BFHuxXD6Y/DC3hTPmSgiGqcLVHoyaTsiRQVSvERQ87jh4o+uIA1gC4LAbGzAHdf9V4iaVxgIP1qQwmxBryokgXgpqqhSzTIeZIppmjkQn91anq7iGJS8w2yDYDArj5VmoptkWvvUG6sRsOgjLMZbUuICvt630w+B7usa23opOVK7wj/FNxK0simsQPBaymWJMOK+rbxr5O7xjvjh0ywZJXPOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFD6fN2zaXu7xoebl4vI8TgZXLEmFpQZeOvSJrG9tu8=;
 b=Br7u0j8yaAHIoGZPEgAjgViWVqY2k4kD+EPbnXbL70glCpF5exRzayQGCsspUH54b08XDlN1e82o+5CBu/PuYj8YtaKXERTfImSSTT8wE7K1xt7fcTKVVnTwd1DhFml+EabMpQ99YeKdLG1yVBMBkAuNCiP+q9LMavIaAd5lryk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8189.namprd12.prod.outlook.com (2603:10b6:208:3f0::13)
 by DS0PR12MB8293.namprd12.prod.outlook.com (2603:10b6:8:f3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.35; Mon, 23 Jun 2025 06:13:51 +0000
Received: from IA1PR12MB8189.namprd12.prod.outlook.com
 ([fe80::193b:bbfd:9894:dc48]) by IA1PR12MB8189.namprd12.prod.outlook.com
 ([fe80::193b:bbfd:9894:dc48%4]) with mapi id 15.20.8835.027; Mon, 23 Jun 2025
 06:13:51 +0000
Message-ID: <9ec4c72e-8895-42d3-9b3c-0794fc9c5c34@amd.com>
Date: Mon, 23 Jun 2025 08:13:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] filemap: Add a mempolicy argument to
 filemap_alloc_folio()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Shivank Garg <shivankg@amd.com>, seanjc@google.com, david@redhat.com,
 vbabka@suse.cz, akpm@linux-foundation.org, shuah@kernel.org,
 pbonzini@redhat.com, brauner@kernel.org, viro@zeniv.linux.org.uk
Cc: ackerleytng@google.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, pvorel@suse.cz, bfoster@redhat.com, tabba@google.com,
 vannapurve@google.com, chao.gao@intel.com, bharata@amd.com, nikunj@amd.com,
 michael.day@amd.com, yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com,
 thomas.lendacky@amd.com, michael.roth@amd.com, aik@amd.com, jgg@nvidia.com,
 kalyazin@amazon.com, peterx@redhat.com, jack@suse.cz, rppt@kernel.org,
 hch@infradead.org, cgzones@googlemail.com, ira.weiny@intel.com,
 rientjes@google.com, roypat@amazon.co.uk, ziy@nvidia.com,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 byungchul@sk.com, gourry@gourry.net, kent.overstreet@linux.dev,
 ying.huang@linux.alibaba.com, apopple@nvidia.com, chao.p.peng@intel.com,
 amit@infradead.org, ddutile@redhat.com, dan.j.williams@intel.com,
 ashish.kalra@amd.com, gshan@redhat.com, jgowans@amazon.com,
 papaluri@amd.com, yuzhao@google.com, suzuki.poulose@arm.com,
 quic_eberman@quicinc.com, aneeshkumar.kizhakeveetil@arm.com,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-coco@lists.linux.dev
References: <20250618112935.7629-4-shivankg@amd.com>
 <20250620143502.3055777-1-willy@infradead.org>
Content-Language: en-US
From: "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20250620143502.3055777-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR04CA0017.eurprd04.prod.outlook.com
 (2603:10a6:20b:92::30) To IA1PR12MB8189.namprd12.prod.outlook.com
 (2603:10b6:208:3f0::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8189:EE_|DS0PR12MB8293:EE_
X-MS-Office365-Filtering-Correlation-Id: 49c9ff72-cce7-4eb8-c5c7-08ddb21d1f9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVNCdHBRcDJKbWtTVUdxZU9RcHlKYlN5dzFSNUtLZFhWcWpPT1g3TTBrVlpw?=
 =?utf-8?B?eGNjZVZwd0g4Q0k0VkltbWdoNEIyblNpUENzQlFEdkkvWEJIZm9zS2U4RUt4?=
 =?utf-8?B?bnhCY1h6dVZ5dkZGUERMUWVCc2J5TzdnazRURXlNeHdqZHdiUTBLWmFuRFFL?=
 =?utf-8?B?VWo0R1B0L3pxaW4xd0RnR0J0bDNwVDV0NDhxOHRrNVV5VUNGbndmUXZVV1R5?=
 =?utf-8?B?ZzUyOGU4QU83c0p5eWYraTlDUW80ZzBHZGJnSFBJSnoySENDNXNMeUVoNzVR?=
 =?utf-8?B?VzFmRWRrR01LNzU3VzlWUkY4YXJrZ1NpVlpLVG5IRmFJYWpVT0pNNmdIZlJK?=
 =?utf-8?B?eEw5ZnJNUmUwamhxQVJUTGJIVWlVQzV6OFQzSGJrTzF5Y0Y3OUhUYmZKTEx0?=
 =?utf-8?B?ZkJCMzF1aCsxTTZhWEZmMGZNYkZ5eTRSNTFsL0ZoVmk3MU9hQ29jampVRmE5?=
 =?utf-8?B?Z2ovTk43MUROWmYrZGxGNXJMaW1iOHlTYVAyWFBwWWJWZm1LMDFzTjA5dXdv?=
 =?utf-8?B?ZFpkeTBINlNHZTlhSlRHV2xFUE5tYXBKRDhnNVFOWXpkQUFjWDRaY3dZWTRv?=
 =?utf-8?B?SzNRQlRQMFdjejcrSzBpZDJSNUM4K043WE5hbS9SYW84b3VrRTZHNWJQNk01?=
 =?utf-8?B?WkZ0NnJaRDQrYlpNQ0E5Y2RRbFhSZTRkdTFFZ0NDZ014TjdOeHdiTUxLdjNj?=
 =?utf-8?B?dHRYWThVVytCaFpTQ2x2UU9UMjh6UmsySkIzbFpBRjFQRm03bkoyUXFNYmpV?=
 =?utf-8?B?MUR0M0RLM0VUZXN1ZWJHU2FIQ2prQ3RwcmJMRFpWKzZwZmJtR3ZEa3ZKSUhq?=
 =?utf-8?B?QW4xSGgydGtBYUpqRm5iajBSRWF3R0YrNkNLQmJkTTVobHFlRCtkQlM0Q3ZD?=
 =?utf-8?B?Y3RqQlpTUEp1Rzdid1dKb2l4ejJLZllsNWlTSlF1eWdiS1MvY0U5bVA5UEhC?=
 =?utf-8?B?UVlXRTZWN21odCsybjQxdkhMT2hOQytibWdZcEw1MnREazB0eHFWV2hvdmdP?=
 =?utf-8?B?Y1VUQTFNSUl2UWZTWGlOZC85SGtuWVFkdGtrTG05NEZ5OURjMEUzQi83WlBy?=
 =?utf-8?B?RVY0TWpickZqSDlFc0FDMEcxK3RPZ0lCWURYcXJveENKNDkya3dqbzF0ZUpC?=
 =?utf-8?B?T0hWM2VEUmpxV3Z0SU96bGdoOW5GL0V2d2FCUk1UYnNXcVFBbGV4U09VTG5y?=
 =?utf-8?B?YkNTdTA2YllnT0ZFL3ZPWTA3dHpEN2xFczlIZXlnMU5OZkVzaCtHcUIvYStF?=
 =?utf-8?B?U21OMDRnRGg0S0NnSmVseUxyZjhBNmVRRkJBRnc0NTNObDlQNklQejRuTzBM?=
 =?utf-8?B?YzBLOUFRcVVNanpZbEtlYjdtZ1lxdWl2TDhlalRpcWsycytkSVhsL0IzVkxD?=
 =?utf-8?B?Z0xzOFQ2cHVTdVY5ZDR1aEp6UFlXUUxFR0dxVmVvZC8xbVhJTnZyZmQ3M3JT?=
 =?utf-8?B?NnJCWlNXWHAxc0ZvaDY1eTdtbkRDdExabHRkVXU0M213R2NpRlFuRnJNZVk2?=
 =?utf-8?B?R2FYaTk0eUJGUUx4N3o0UFUrWUc0a2hyTFhPTVdwZlowaHdnZVlqRzE4Ti9i?=
 =?utf-8?B?ZWlTTWpyclZmYzBwZWw4MlV5OU51NnJGbnQvQXMrOVA1a3hOMlBacTJSeWVp?=
 =?utf-8?B?RlVVMkpKNWYrODF5M25pdTZPWS9wbUx1LzNKR1I3SHh3RC9NWGRhWDlVOENQ?=
 =?utf-8?B?OEEwTnMzTUEvL2o5ZG5VY2RmdGVodk10NThiZ2o4UERuRTVDaVhuWUxDRjc0?=
 =?utf-8?B?Z2NLSk9zdnF2Vy9YWDRoWlBCVS9xUGVJRitoUkFERGJsallDdEtSTmliRnZK?=
 =?utf-8?B?TTViRGFvUXE0N0podjV3UGUyZGNaSEluaHpYVFhNOEc2UDFmVGcyd2VTTjBQ?=
 =?utf-8?B?UGEyUGFRREE4RTNmUzY4KzY2TWc2TnFsZWMxam8rWlpvRnphMmtMaWg5MWFq?=
 =?utf-8?B?bFFBWWZXUWtzRFBJNEdvR0JzcS9yMnpqdGhuM3I3ZXFFN05KcXJZTVppOGdz?=
 =?utf-8?B?SHlpM3FtdEV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB8189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czZTMU5jWE1ZY1dnb1lKUFdpWTVzUVg2MWdtbHBSMm9MUkpHK0lMN0p0Qkxz?=
 =?utf-8?B?b3h1bVFqUlE5ZXpVUWwxcXJic0d1RmxmM3E2TUF0QlRZY3ZzYVcxOWU2STF1?=
 =?utf-8?B?dHlmakVyZjQyZ1gxM0dJOU05MXNoNHZxNDZwRytaaUVBdkY4VXVTUlFULzVo?=
 =?utf-8?B?bWN1YnU0azV0am04eVhvQnVXWm1xOFdHSmRUOWNYemw3SjFWS21GWWJWT1Y0?=
 =?utf-8?B?YkhmWitBa0RDL1RYZTBJNUZ0azRFSUZpbi9Pdlg2aG1pcU9HSnBpdkgvRmZw?=
 =?utf-8?B?WDJHQmxnUWhyeS9OVDZzQ2FHNGFFcEhpSDZyaFZJNjg1Z210ZmRxTU11YVpN?=
 =?utf-8?B?ZW9tVmZuOGYxTFI0aTcvQ0F5bEE3TWZUR1RhSGY4VklFd3gyMC81QVoydlh5?=
 =?utf-8?B?WWExSGFqY2o4LzZEeTZ5VFZ5R0VEVnhkRHJTMUZONDJPNXhyblY3STl3NEZk?=
 =?utf-8?B?ZkU5YmxpKy9YSFByckJXTUJoVm1md3A4QkZZT3Arak5GRlo0U0JqUlZkbHc2?=
 =?utf-8?B?OFltQldSRDYzbTVqUkpTK3VBNjV2ZG5oK0lESGZPVGtiMCsvNTlhTXFHT0xs?=
 =?utf-8?B?YUtNRUMxOWpzME0wVjJ0aDBoUkpvbUdQVGJ0aTFHMUhHNXNzRWNweUcrYi8v?=
 =?utf-8?B?cUM1QW5DMXBRV0lGSytsQTE0YkFNOHJsRVI1elA4NEZScmhvS3VSdWpvMXFL?=
 =?utf-8?B?cU1yd3BPblJjL3dXYnhOR1ZHbjVzc2UvV2Jaa0YxOEpZMjU3ei9pOWFMOTc4?=
 =?utf-8?B?WkxkWEMwcFMxcU90UVlZVzlsVXA2N1FKZGFZSnZPQmIvU3hZTHhOUzB0Ryth?=
 =?utf-8?B?NnozZ2hITWN5NmQxcDZJdEpwYVJRbHNCbWdlSzIyU1dyTjFMQU9wQXFEYjJ0?=
 =?utf-8?B?a1pEQXZZTmRSdVdycHFEQ1k3MnNES2N4ZW5aSWE1VUNyZTk2eUs2M0JTeEFu?=
 =?utf-8?B?a0tmYmZFN25vdm5vSGdtTEFrelZvTms0ZmxzcWZjZ1M2K3VObHZEeFBhazN6?=
 =?utf-8?B?M3gvOXJkYkpuZ3BMWHdZNVp0YmZMc0M4eUIyTU5HUzUzS1h5cWI2Zmk1bksx?=
 =?utf-8?B?OTQrdHk5OVNIVFd5Tk9rcFZtMU9aNlZoNncwb0IvZTh4OVA0ZnNxaERoWXVy?=
 =?utf-8?B?YWZ6ZEVtbzZXb0NQVERwOVRpeXN0eUZwZmRud214VnNrRU9IUlgrRkVXa0d6?=
 =?utf-8?B?SHlJMGwxeEtYUTZFZnlxNVFRenFMRjdkTFgvSkFaeDBuOU5yMGR2aXFaVGhj?=
 =?utf-8?B?ZlArYVlXRFRrT2dVUkZkOUM5N2JvM3VESmwvLzB5MjhkcTZoZFFMa3lMUVNp?=
 =?utf-8?B?VEJIa2FxcTN1MnQ2Y3lYY3lpanBEejJCNnRuVTRGRTFUaFBtZnVOUjRjRkF2?=
 =?utf-8?B?bGpLdy9PWXo5KzRHOHMzWkpBdmMzTVZtS2dqL1lOaUpEYStiR1hEdkNvT1A5?=
 =?utf-8?B?UTNVejE0ODRCNEx5WnVxMDRHY3JhTHdYRC9kQ014U04rQzNRN3YwcGtGUzVK?=
 =?utf-8?B?MFZnQ01uTngyNU9Kc056K3RGM285Y3dDbjhaQ1VBTGFwYWx5MlBHdEdZTWJw?=
 =?utf-8?B?T1laMC9qYmltdnNBWkZ2M2F3cTFCZWxXZ1c2RXRTdmZNbDN1Uk1Id1RGUFBw?=
 =?utf-8?B?MG1nMXlpS29Kb3JHUUlYQUxWVkdody9JVnRIT2MyVmlrYzdxNElvN2hEZ0w0?=
 =?utf-8?B?bEdlbmVUY3haUGxtcFRQWkZOVitEQWVHM1NOMjVMS2JIU3hCMWtxZ0RSRHJF?=
 =?utf-8?B?UDlwOUZRYjRsNThjWGh5c3pSUHdwQmpYd2IrZDNrWHdvYjJSNS9lYTdlYW9U?=
 =?utf-8?B?UHpuMlV6TDZNUi9PRjQxU2w3SUV4ZU5EQkZLeVBFSE9zWTc4VHNWMGhQTWo3?=
 =?utf-8?B?YitaUmtLOVJpTkUra1hrNVBtMXVKYnpXYjJkaFMwdEwxbk0vMVNmR1IveVdi?=
 =?utf-8?B?b1FwOHFDMHFGTGQ2WU1PbG0rNmR2aHJlc2kwNkx0bEtUUEMwMVZYbGxleFhX?=
 =?utf-8?B?MVptRnFTL3A4QjFGem5VSStrLzdHc3BVTnBhbXR3YVNGbnJVU3JNTG9HQjdZ?=
 =?utf-8?B?bVh5bW9oQWU3N3lPU2FPTUhuYndDdldxZ2U4OUxKb01Ob1AzeThwWlZlSWpU?=
 =?utf-8?Q?5CEbOIEJUAJYXyJARkEzKCHdN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c9ff72-cce7-4eb8-c5c7-08ddb21d1f9f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 06:13:51.4804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GtQmyQRam8HvcIRFd27VqQIeThLRg7zgA1x241nMQ+riuHOMEUTCz0OiKY/GwFUflM9jyMj9Bq54kHAVZbRwkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8293


> guest_memfd needs to support memory policies so add an argument
> to filemap_alloc_folio().  All existing users pass NULL, the first
> user will show up later in this series.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>

> ---
>   fs/bcachefs/fs-io-buffered.c |  2 +-
>   fs/btrfs/compression.c       |  3 ++-
>   fs/btrfs/verity.c            |  2 +-
>   fs/erofs/zdata.c             |  2 +-
>   fs/f2fs/compress.c           |  2 +-
>   include/linux/pagemap.h      |  6 +++---
>   mm/filemap.c                 | 13 +++++++++----
>   mm/readahead.c               |  2 +-
>   8 files changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/bcachefs/fs-io-buffered.c b/fs/bcachefs/fs-io-buffered.c
> index 66bacdd49f78..392344232b16 100644
> --- a/fs/bcachefs/fs-io-buffered.c
> +++ b/fs/bcachefs/fs-io-buffered.c
> @@ -124,7 +124,7 @@ static int readpage_bio_extend(struct btree_trans *trans,
>   			if (folio && !xa_is_value(folio))
>   				break;
>   
> -			folio = filemap_alloc_folio(readahead_gfp_mask(iter->mapping), order);
> +			folio = filemap_alloc_folio(readahead_gfp_mask(iter->mapping), order, NULL);
>   			if (!folio)
>   				break;
>   
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 48d07939fee4..8430ccf70887 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -475,7 +475,8 @@ static noinline int add_ra_bio_pages(struct inode *inode,
>   		}
>   
>   		folio = filemap_alloc_folio(mapping_gfp_constraint(mapping,
> -								   ~__GFP_FS), 0);
> +								   ~__GFP_FS),
> +				0, NULL);
>   		if (!folio)
>   			break;
>   
> diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
> index b7a96a005487..c43a789ba6d2 100644
> --- a/fs/btrfs/verity.c
> +++ b/fs/btrfs/verity.c
> @@ -742,7 +742,7 @@ static struct page *btrfs_read_merkle_tree_page(struct inode *inode,
>   	}
>   
>   	folio = filemap_alloc_folio(mapping_gfp_constraint(inode->i_mapping, ~__GFP_FS),
> -				    0);
> +				    0, NULL);
>   	if (!folio)
>   		return ERR_PTR(-ENOMEM);
>   
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index fe8071844724..00e9160a0d24 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -562,7 +562,7 @@ static void z_erofs_bind_cache(struct z_erofs_frontend *fe)
>   			 * Allocate a managed folio for cached I/O, or it may be
>   			 * then filled with a file-backed folio for in-place I/O
>   			 */
> -			newfolio = filemap_alloc_folio(gfp, 0);
> +			newfolio = filemap_alloc_folio(gfp, 0, NULL);
>   			if (!newfolio)
>   				continue;
>   			newfolio->private = Z_EROFS_PREALLOCATED_FOLIO;
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index b3c1df93a163..7ef937dd7624 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -1942,7 +1942,7 @@ void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi, struct page *page,
>   		return;
>   	}
>   
> -	cfolio = filemap_alloc_folio(__GFP_NOWARN | __GFP_IO, 0);
> +	cfolio = filemap_alloc_folio(__GFP_NOWARN | __GFP_IO, 0, NULL);
>   	if (!cfolio)
>   		return;
>   
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index e63fbfbd5b0f..c176aeeb38db 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -646,9 +646,9 @@ static inline void *detach_page_private(struct page *page)
>   }
>   
>   #ifdef CONFIG_NUMA
> -struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order);
> +struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order, struct mempolicy *policy);
>   #else
> -static inline struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
> +static inline struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order, struct mempolicy *policy)
>   {
>   	return folio_alloc_noprof(gfp, order);
>   }
> @@ -659,7 +659,7 @@ static inline struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int o
>   
>   static inline struct page *__page_cache_alloc(gfp_t gfp)
>   {
> -	return &filemap_alloc_folio(gfp, 0)->page;
> +	return &filemap_alloc_folio(gfp, 0, NULL)->page;
>   }
>   
>   static inline gfp_t readahead_gfp_mask(struct address_space *x)
> diff --git a/mm/filemap.c b/mm/filemap.c
> index bada249b9fb7..a26df313207d 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -989,11 +989,16 @@ int filemap_add_folio(struct address_space *mapping, struct folio *folio,
>   EXPORT_SYMBOL_GPL(filemap_add_folio);
>   
>   #ifdef CONFIG_NUMA
> -struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
> +struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order,
> +		struct mempolicy *policy)
>   {
>   	int n;
>   	struct folio *folio;
>   
> +	if (policy)
> +		return folio_alloc_mpol_noprof(gfp, order, policy,
> +				NO_INTERLEAVE_INDEX, numa_node_id());
> +
>   	if (cpuset_do_page_mem_spread()) {
>   		unsigned int cpuset_mems_cookie;
>   		do {
> @@ -1977,7 +1982,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>   			err = -ENOMEM;
>   			if (order > min_order)
>   				alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
> -			folio = filemap_alloc_folio(alloc_gfp, order);
> +			folio = filemap_alloc_folio(alloc_gfp, order, NULL);
>   			if (!folio)
>   				continue;
>   
> @@ -2516,7 +2521,7 @@ static int filemap_create_folio(struct kiocb *iocb, struct folio_batch *fbatch)
>   	if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
>   		return -EAGAIN;
>   
> -	folio = filemap_alloc_folio(mapping_gfp_mask(mapping), min_order);
> +	folio = filemap_alloc_folio(mapping_gfp_mask(mapping), min_order, NULL);
>   	if (!folio)
>   		return -ENOMEM;
>   	if (iocb->ki_flags & IOCB_DONTCACHE)
> @@ -3854,7 +3859,7 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
>   	folio = filemap_get_folio(mapping, index);
>   	if (IS_ERR(folio)) {
>   		folio = filemap_alloc_folio(gfp,
> -					    mapping_min_folio_order(mapping));
> +				mapping_min_folio_order(mapping), NULL);
>   		if (!folio)
>   			return ERR_PTR(-ENOMEM);
>   		index = mapping_align_index(mapping, index);
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 20d36d6b055e..0b2aec0231e6 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -183,7 +183,7 @@ static struct folio *ractl_alloc_folio(struct readahead_control *ractl,
>   {
>   	struct folio *folio;
>   
> -	folio = filemap_alloc_folio(gfp_mask, order);
> +	folio = filemap_alloc_folio(gfp_mask, order, NULL);
>   	if (folio && ractl->dropbehind)
>   		__folio_set_dropbehind(folio);
>   


