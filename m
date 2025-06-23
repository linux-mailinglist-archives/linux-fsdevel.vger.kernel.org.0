Return-Path: <linux-fsdevel+bounces-52511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 866B2AE3B53
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 11:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C36321896B5D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 09:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D7723C4EB;
	Mon, 23 Jun 2025 09:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qRXn2ioG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216C7238C09;
	Mon, 23 Jun 2025 09:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750672638; cv=fail; b=TzTsU2XLWgPJYbJ8CuJFhB0w4tzh/FCFMxGtWk+bKtofogu2Np/Cb8PyFCE7ATVHLiP3y2TGoXDUCAL1jPjP6sjSrG/qjU47ivpPOnnBdVv4/To46+Q6laqDQImL/rzKzdARnEdiqymlInqRICWIFLSHxJi2F6HwX9f1RkKS1CA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750672638; c=relaxed/simple;
	bh=pvAi0jZBZLqpTfZO8Rx3zLQl25eJxHSBlCG1z5eEM58=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=evpzpcZqWcJWfz8hx5bm89Nwo/R+D/lLBJwiA5mozNEsB7/GoSnwsiQQopuENR566dLqtozukC1B35DLmB6LBen+hyCMKm0FmBTS7v9yHjvmXrtVhAhMvhmQpmTEqb3e+m8+zvdDQkm/aSmRmQsGuPRXlWCREMJFG/qN7yv7CUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qRXn2ioG; arc=fail smtp.client-ip=40.107.223.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fGYFmaelq3ZKpKSS8HQPiVlvRjxeptp4tEX6APYukKpE4cAb135UErlx0Aoito1AKeoLjZCB8Ee5K4HP+AcSinVC/0THWS68CUDJbq6KRNOEDECfRqeFvuNjjEFyaEIvQmq+Sz7GXMANOJHvXuKEOh0Lz75BBEw/8rXqxZ8zYok+uBhjBF0sHvVwT2tHsEhINfgPR5uebg/qqHmrRQEvEqtkDNpqg0WhHia+LFwUJUbCS/z8J93BvBcnss4eJ4cIBW0b1D/4v1p+1xnF9Z8Tpfe+q6R17recWlhhMJ6958oLBc02k6l5wIBKl6pdzlGemztfbdx47gNkF5M/efjpZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVyNzrO5/o2IOWfBJdfs+cOkNmDiOi53k1LWP39gR9I=;
 b=cp6ZXofJiBQsQpMIgNx8zxyqTU/1YQjr4D7d3I+Qs9sAudsiZyelhPYAsmY2X93JGliJy8JOa/58qOl8dkKRNou668FGD5Ai6tWdL0LNNq6glLnXfQnF+WQ9thO2/o+HulkWwKnG/dQdkd1OQqnqnojUcf7QmxdSkPnp/t9uUORcaM49M4DC9CP+w9zqGJNZZDoZZZvN1q7bgsvx3BbiZXLWDCTZBde0QcvXCVflJMXbWju7DqXqJVhjXHOdLEeg2CToip3k6hzsuTZ0Rns0FdYzZ4o8zm5zq8dewjVf5y/tRmnGsfB/UXDadc6yVXBVMChqYYpojBgDIU2TsaRFjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVyNzrO5/o2IOWfBJdfs+cOkNmDiOi53k1LWP39gR9I=;
 b=qRXn2ioGDjZgKoRh2JzEB5ZLRqLF/O0vThyYI/FJrmNGmibBBdy5lrLitbhXMCNFz3F/fvaokYGo6J9kTQsifv08roP0L4KQc1NDV2/GEPGsdYri3/HPfwqNQ/votDGEGR5x0i9JjKl8TlvLYWmMSr8Jw/VZB4UicGqJUkyfo54=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9aa) by SA1PR12MB7441.namprd12.prod.outlook.com
 (2603:10b6:806:2b9::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 09:57:14 +0000
Received: from SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 ([fe80::40bb:ae48:4c30:c3bf]) by SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 ([fe80::40bb:ae48:4c30:c3bf%8]) with mapi id 15.20.8722.031; Mon, 23 Jun 2025
 09:57:14 +0000
Message-ID: <c6d897d5-8b6f-43e7-98cb-706d6f3252b7@amd.com>
Date: Mon, 23 Jun 2025 15:26:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] filemap: Add __filemap_get_folio_mpol()
To: Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>
Cc: seanjc@google.com, david@redhat.com, shuah@kernel.org,
 pbonzini@redhat.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
 ackerleytng@google.com, paul@paul-moore.com, jmorris@namei.org,
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
 pankaj.gupta@amd.com, papaluri@amd.com, yuzhao@google.com,
 suzuki.poulose@arm.com, quic_eberman@quicinc.com,
 aneeshkumar.kizhakeveetil@arm.com, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-coco@lists.linux.dev
References: <20250618112935.7629-4-shivankg@amd.com>
 <20250620143502.3055777-2-willy@infradead.org>
 <aFWR-2WAQ283SZvg@casper.infradead.org>
 <20250622114322.c6c35800e01e4cc4007a0f89@linux-foundation.org>
 <d1d7feed-c450-4b88-ab73-a673f4029433@amd.com>
 <1d9a4656-8aa8-4e82-9301-644625bf2d4f@suse.cz>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <1d9a4656-8aa8-4e82-9301-644625bf2d4f@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0176.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::18) To SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9aa)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPFF6E64BC2C:EE_|SA1PR12MB7441:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d1e9dfe-8782-4257-1d50-08ddb23c5442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dDYrN1hwbzVVYjAwMnJuUWhUTUdvOURwT2s1TmFFbm9pM1E5VzF3SzNqaC8z?=
 =?utf-8?B?cUZNc09lb1kwWGJyTm5iSCtlN3JsTEdMS0dueCszRmVhWWlFZzhhRVV0UHZi?=
 =?utf-8?B?SlFQRFptL0s0VFZyRmlrQllDaXJzVzBIdlhQYVVULzJ3cnhRTitkQ0pWZWxX?=
 =?utf-8?B?QzlzQUFwQWJKVjZwYTlhQWFQMkpZQzI2M0FMdHEwcmhtb2p2dzBjVi9nMytz?=
 =?utf-8?B?RjZ3Z1FlYy93cUY3QkZjV0tvZm00ajFhNldYZDRlMlU3bUpkams2SUFBank2?=
 =?utf-8?B?TEg5TWZIQjNLVngwUXlPSk9xem9hTlZRTE9oaVdhSW8zYllHQStRMWt2M3No?=
 =?utf-8?B?MklpT0p2MTNvRFZNT1pTMTdFa0FiOGJnVU90azFLT2R2RFl3ZkxDMlVwVmln?=
 =?utf-8?B?MFdzVHQzSmwyVThnTEswdENNR0lXVlhYNlFCRit4UmdoWlNYaGRkS0FWOUFK?=
 =?utf-8?B?YkY0b0FZWU5wUVQ5OVNpb2JuWE01SWtzYm5tSWZrbjJ4MjJTbGk1SmtsWmxO?=
 =?utf-8?B?c1plOHBGU2hvbDRqWmNlcEFzb1dnK2RDaFUwK0YyZ3JkRG8rQzZjVG0rMUY5?=
 =?utf-8?B?WUlVeXp6OVA5aFo1UUkzQ3lFTWw5R1FkWWUzR3BoWEhreVY4K05vbjJ5eExE?=
 =?utf-8?B?akp3VjlSanVhT3ZGbDJGZzgza3lwVFJKWE1yVlhJZ0R5WWd1Q1RFSGZ3M3ph?=
 =?utf-8?B?NDJlSW9YOWJScWVGUzg2eHAydTJUOFJaZGhrUGdqMld2c3ZnRHBvSi85NXZP?=
 =?utf-8?B?b3cySURxclJuZ1MzUVdtcUh4ZnQxK050bWJBRVU2TzFRWmZ0VjcxZ1Z2aWhx?=
 =?utf-8?B?b2hIQ000VzFLQVl0VXZEZkRQczJGSVRGRkNxVnFnZFNuTjNtYTlPTTBwVDdq?=
 =?utf-8?B?UGRyMEF4dXF6c01GbVdlQ1MrOHlLRnJWZ2p0SjdMMTZEQ2JxbUs1S2dUYWpY?=
 =?utf-8?B?RVYyVmowOXJwOE9HR2FqSXRvVWFRaW1Lc3VvWllhVlRTN3lQcjVFSmZiRkcy?=
 =?utf-8?B?ZjBJSHVGeU81eUwwMS9IYnc0M2RFYnJtMG9jN2Q4QkdkZ2dGMC9EYmk3MmtJ?=
 =?utf-8?B?d2t2U0w4ZW03dkg2REVhclRpWDBITXRoSXV5ZWNRdEx2VFJ1ZjNNdjgveWlB?=
 =?utf-8?B?OE9WTDkzeExzbTA0cDJFMFNVaWZETFRLTTZXcGRyWGtKMDNBVldOS2Q0Q2V1?=
 =?utf-8?B?ajQ1QlJ3bjVHRjh3MWZLaURXcVF5cXhDUWxrUmY3TGlUVmd3V1BCSGdFWGpj?=
 =?utf-8?B?S3dITkdiSU1wNFhYejR3YzFOMU53K1NlV2pycThXTE85Sm5KOVZwK3F2UmFV?=
 =?utf-8?B?ajB2cW5tZnBMTXQrWVB1VEhIanRpM3hkODBldi94RHFyelFRNDh0THNqKzYy?=
 =?utf-8?B?TGVhTzVpem92b1JFKy9PSlFXckRjYUFiNXp5QkVTOTlMQ2srVjRWd3VKb0Q3?=
 =?utf-8?B?WjJjckkvUCtjSjVTcXlLV0VZOXJYb3hoNG1MUTEzZWJTeWFrWnpsMjgwSVdY?=
 =?utf-8?B?SEgyWWVkS1F1dlErVjNqclA0dmZEOVcvZnJxSHVjU0RoVGZQczRKTnc1SDd0?=
 =?utf-8?B?RDhVdUZZM0Fhd0dHOElvd0RMby92QVNXRUR2OERIRCtjKytidk05SVo3WDU4?=
 =?utf-8?B?c2NZamdaQS9nOGxJMW5ZRFQ2cUQxNmhuTVZ1OWxLOWNJWlhMNEdJaFNJUVFI?=
 =?utf-8?B?Q3AyeDhtd0NhU0gyOWhyVUFUYnNSK09WckppM2ZjSWpLdTUyaVVLdStNakFF?=
 =?utf-8?B?TThhdDFFNEZqckJrVWhMY2dXOXE5YmF0UWduMllYT2lvSHlxWlBuNmpiNllo?=
 =?utf-8?B?K05yMFRidFpmME9jbjFzZXZrczhCT05KdzA3VjF6azcxRXNzWVVqU3hjMWF3?=
 =?utf-8?B?Yk1ZK0RwQmtzNVRSNWxsWHJ2R21pVmMxV2ZCZzhRaDZnZS9lMGJLby85N0Nl?=
 =?utf-8?Q?H7UfKQQFayY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPFF6E64BC2C.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnhJS1dDdHNneW5xYk9sUFIyYmtuM25WQ3lPOHdIcy9UMm1WNUU2NzduMHcz?=
 =?utf-8?B?bGxEbXFDaVB6UE5uV3N1TTNTSzl0ejA4c0NXM1g4YnZNUjF6ajBEMTB3U0hk?=
 =?utf-8?B?TFlMRXlEZWhYcC9PTk84cXh3NFIrZ0RnVUhLMk1DUjhydHRjSU9xdTRBMkVY?=
 =?utf-8?B?d1h3S01uMFNVNUZTYXdSYms5MmI4Yks4Zm43b2JEV0VKMnNGMmVzbXZ4Wk5F?=
 =?utf-8?B?R2I0ZnlBdEhKR2RJaVdCcGhmK2owRlVqcVdRN2hnR3EwUmVmYXNhL21OckZK?=
 =?utf-8?B?ZlZOS3UvM2JoY25NL2o0VmxUUFBGYU5MQkJ6ZUZCeDFtMllHTmQyWjgwSjZa?=
 =?utf-8?B?UWszdHdDY3NNY0ZlUnBNNFdRMUJXZHZ1N0JDQmhaZlp3azBROGdXOUlDaVdM?=
 =?utf-8?B?VVZxMk9iZzlLWmRwbHU4aHBia2JJRXBGUXRJSWJmQzNuM0FoLzVKdHU4TW8r?=
 =?utf-8?B?TnJibUwxS1NqakhSUzBrWHV3VDJEOXkyekNsUzd1VzAzaDdlMEZCRVZHakhq?=
 =?utf-8?B?ZWJiN1dnRE9qTHVDN3JkMTMvVm83MlB5N3RLbWpweFIzQkZxd25STklReU84?=
 =?utf-8?B?d2hIWTBjaHpCcytNUUkzdHVpNnBLeVNkb2tLalh1SUdDbWtiZVV6bm55Vmp1?=
 =?utf-8?B?UGdReHBTSE04MjdzSHZGMHFYd1BlQUdrdlNxQU9QMXpNN1U4RllRanNpSTBo?=
 =?utf-8?B?ZUZWZFF0YlBxSjYzV1IvQ0pjdGg0b01rZC9HUFFPU3NWUElLMjhiZDVtK2Ur?=
 =?utf-8?B?aG1neXVhblozWldKdEtKRkxSbmx2VlJOL2tkL3lOdVBDdDlRVXhtTEZHdW1z?=
 =?utf-8?B?TTVYY2JaWldXeTY4Q3hVaENpMlRvMjdLczd0bFVKQnhzN1NWallHZG5PSDAy?=
 =?utf-8?B?MkZvZ2Job1hhdHlBTXNiaGlpKzhVd2xtTG5uUGgzTi9oMWhKODQ4T3U3SjdK?=
 =?utf-8?B?Ky9rc0llT295bWpuMzJMaE1FWldXTnZDZ2RTano0bEZvOUdNSTRZNkw4aGJO?=
 =?utf-8?B?K1FKeUp1SjBqV1Jub25DZHJiSDByV1hhb0haUWVGa3NvTDVQSGtab3NqTGNs?=
 =?utf-8?B?MmJGaUZGak5leHdOdC9XQms4aEdYV0RVUmVBRlE0dmJlUkpGMjhLSjhxckg5?=
 =?utf-8?B?WnFkdmUrN3EyVnNjVnIvSERJbndLR0pGcHNkRE5Ea3pHeFhuUDZKRDc2ZTlF?=
 =?utf-8?B?MWlTeXpUamdBdHVEVXNIRlcyM0dlbmRiMWdzWnZaQ1M3Z1U5Z0JzN0JmTUZi?=
 =?utf-8?B?dkR1c2NHZTdsaVJjMmYxZXpJQS8zelNhSE95TDNGMWdGdG56TGQ4NmFlay9N?=
 =?utf-8?B?cHFCYWVpRU8wbkwreG9oYVJpUktUR05IUmJsVk9rZnJURzB0amNZVlJGN3Rz?=
 =?utf-8?B?TmUwbDRVNUJpWklqVS9WTi9aYk9zSmtLSTFyOVE3UExwV0FZWjlNak85T3oy?=
 =?utf-8?B?VWRPaWtiZHpJT3FyVzBTWkFkOXhqODRqd2paL1VIc0Z1Rk1EelNrU2ZiUXhP?=
 =?utf-8?B?ZUg3L3cwRkgxbDF5elVYa2Nqb2VZVFI5KzVraFBtelAwTm5xTGNxbDJ1a2FC?=
 =?utf-8?B?c0RXSW9ic0hKc3NteGxwcm1kSEEyTUlWdnNydVZUbUd4VmJNQWs2d3luVzVS?=
 =?utf-8?B?SFJKYlBXUEVEakdlZ0hMUGpoRGZDQ0xkQXppd1NaOEw0QkwwZ0NGSEM1U2hr?=
 =?utf-8?B?WTJCUGk1NjA3UlNiRDhBMGRMbmJuTVpLalJ6OTlFRE85NEQ4VTZjaHBqSDRT?=
 =?utf-8?B?eHNpdlRyalpNVEFKWGlTeExJbUpFaitDMmtUY0t1dmZDdzg2YWh3YmVPVFJY?=
 =?utf-8?B?Z2duSm04SkVtbXF6ZzN3aS9wTGNsUEVZRFE0aVdRc2E2ZmtZK3Uvd2VJNVlX?=
 =?utf-8?B?WkFKWGZaQ2d3SHhVQWRqYkxLNVczOGlzQ0MwZTAzNUdKU21EckU1Ym14VVdT?=
 =?utf-8?B?THd6VEIvQnRRZjA1V3BpZVd4RXJueGU4R21oWEs0azFlT0VqVXZHSHpSMUdS?=
 =?utf-8?B?TWlMNkNDMGM2WXprT05OdzdFSjVvUDJDeTI0ckxiODVrYlNHQVZBMmw0Mnhp?=
 =?utf-8?B?MjQ0RkZaekt2QUl3LzJ0QnF6cmR1d09qK3JzOWlHSjhFRC8ydjFpSmY5Q2pW?=
 =?utf-8?Q?LKSAffnoX+17qhfV/DbDWKK15?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d1e9dfe-8782-4257-1d50-08ddb23c5442
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 09:57:14.1613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sjxTZtoI4ykfRNUGckg1EiZU1TL4o6kYW2ZmXZMYAPF70QANHAQnB2IRoPbs7aztqnM63X2F6kz9cIZr6R/ozg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7441



On 6/23/2025 12:46 PM, Vlastimil Babka wrote:
> On 6/22/25 21:02, Shivank Garg wrote:
>>
>> Hi Andrew,
>>
>> Thank you for addressing this.
>>
>> If you don’t mind me asking,
>> I was curious why we used EXPORT_SYMBOL instead of EXPORT_SYMBOL_GPL here.
>> I had previously received feedback recommending the use of EXPORT_SYMBOL_GPL
>> to better align with the kernel’s licensing philosophy, which made sense to me.
> 
> That's the recommendation for new symbols, but this has become effectively a
> rename (plus a new parameter) so it's a bit different situation.

agreed, Thanks.

