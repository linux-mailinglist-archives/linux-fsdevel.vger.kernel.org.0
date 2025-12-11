Return-Path: <linux-fsdevel+bounces-71166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE32CB75F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 00:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1880E3002FE4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 23:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2473F2E173E;
	Thu, 11 Dec 2025 23:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0CWSBMeF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013036.outbound.protection.outlook.com [40.107.201.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161432DCF47;
	Thu, 11 Dec 2025 23:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765495400; cv=fail; b=hsGRImsgfGQOh/vpWZIqGeLDl7aiaFTuijw7cc6n6Xo3Nw0pnfI804d59LtO7rM8YHhOZbJcWvkwVd2SJkYlHt8RWjcI8cTLL9OaPrAIGzGxtN+NQ5XZflJ97NEj4RacRo23D90NdDZMyGJqlSN0SfnnHcnj4T8dMCq2dTD1new=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765495400; c=relaxed/simple;
	bh=dHD3RAu4kF9G3uh8VSQ9SKLvw+kt14INp9i4FK/YPdU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Gw1T2tPVjR0jhtEeMawI4PPeB8Z4cG29D61Rh0atLtIGbIBsNjNHyPyaPa3R7GzNSaZRLH9DC0cMxcp/WAwSWffQbgSR/EA6z4LuaZrVeyPcBhZKesoPnMN2HcABvTcSxQSV61LzHk9YwV8VfL4grGzVYwQSwM4UQjLgmpGTYcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0CWSBMeF; arc=fail smtp.client-ip=40.107.201.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4ycmvOosZb81EgLXXnmyV3gFFx0T2KnR4Vrt9mYSV+hFUmyoRoavalvyT56WexUXonW1Bx29I/pvyE89LIfwUE3+NPnm4GlHwj12Mr1yrYM15q9x67ig3GUziuZVxHCWUWlAVkgE1lhCONoPbfESw2+posOrO0/+p7sTimSz1C5Aou7ziuaQTwK6Wq+qF04xI01pJCGe8FrXTXW2DAZQcOvIQj3U0PcdHszhR84d8lwvgVpQK/QVZUyhk7T4tmsTGSovNO93FdxGdnEr0iUnp2u9aK2lgHiyX5QDcpuxqojyMnB5xQ7EUU4U4We0b49Y/IW7oDr27901NTZU+yZOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2eGq5VzGFNdXEM8ZrOLEpoh3zli/1MJZMMozqF4fEE=;
 b=f59DzEY99+kcQFSnFdzg5jJFbPHH8XTUhetove+mjjCS00DwAwMOP9AzFiGzK73HsPeCxP47F4vgXTAGx85/Pdsb8Pcsj3cQkRCfc9iPhZ7M+EJGj8qdk+m947iZ5BHFf8BlGTzbxEwIZW90lxpzQwOirpWt27hJRrWbT8KTCqjps/TdF85slv0UmB7y7e5CVXMf7CNU4eElFS4NYI++PjQKIanPquh/rcKl0A0+YlyDXJPK0mtNkzzttqkpaC2IrA7Q57gNwog8wozG/zy1gKr/PdO/ahNBPdJD4fjSQr/ORtjKGey0+35opLm0i39tMpxnsWmV6BjouCPySQ83uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2eGq5VzGFNdXEM8ZrOLEpoh3zli/1MJZMMozqF4fEE=;
 b=0CWSBMeF1rOuPRmNG8DiFiviIU+e9NZLt/Gz4mTH2wJA6jnXfkSgtkduWCCzZOnH+6JURucHkI0c7ahBpOzYqyJCIm+r2pBPPrKuJGkM0L4yAhp00PpyDgmxjLMz4rGI1Pv7TR2jvowb58Wc3dcBgMkw2Je0H0zFTPSf12J3fTs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS4PR12MB9707.namprd12.prod.outlook.com (2603:10b6:8:278::9) by
 PH8PR12MB7374.namprd12.prod.outlook.com (2603:10b6:510:216::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.13; Thu, 11 Dec
 2025 23:23:15 +0000
Received: from DS4PR12MB9707.namprd12.prod.outlook.com
 ([fe80::5c6a:7b27:8163:da54]) by DS4PR12MB9707.namprd12.prod.outlook.com
 ([fe80::5c6a:7b27:8163:da54%5]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 23:23:15 +0000
Message-ID: <34a26e2e-d3f3-4508-94ee-89943144f8fa@amd.com>
Date: Thu, 11 Dec 2025 15:23:09 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/9] dax/hmem: Defer handling of Soft Reserved ranges
 that overlap CXL windows
To: dan.j.williams@intel.com,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Matthew Wilcox <willy@infradead.org>,
 Jan Kara <jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Jeff Johnson
 <jeff.johnson@oss.qualcomm.com>, Ying Huang <huang.ying.caritas@gmail.com>,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>,
 Greg KH <gregkh@linuxfoundation.org>,
 Nathan Fontenot <nathan.fontenot@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>,
 Zhijian Li <lizhijian@fujitsu.com>, Borislav Petkov <bp@alien8.de>,
 Ard Biesheuvel <ardb@kernel.org>
References: <20251120031925.87762-1-Smita.KoralahalliChannabasappa@amd.com>
 <20251120031925.87762-5-Smita.KoralahalliChannabasappa@amd.com>
 <692f6a2035c79_261c1100d2@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
In-Reply-To: <692f6a2035c79_261c1100d2@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::7) To DS4PR12MB9707.namprd12.prod.outlook.com
 (2603:10b6:8:278::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB9707:EE_|PH8PR12MB7374:EE_
X-MS-Office365-Filtering-Correlation-Id: ae5cf8eb-4e1c-4dfa-63b2-08de390c4290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cld1b09ITklGelJiREo3WkprRUV6NmhURFQzMjljSmJOa1Jib1k5SFNMeXQr?=
 =?utf-8?B?UHd6NEJCSkZESzJtZkJOelJ1WjhMbExGbm5OV0psUzRWSXZMaDFQZVJNWk0v?=
 =?utf-8?B?eTNDbzh3U2dXbUhSK1ZrNU1zY05tdm16NjhnUjFPeEdpcjB3NkhCeGw1emUv?=
 =?utf-8?B?b0ZYSXB4OTNiZ3pCMmE5dVU1OU5aODJ0YzV5NVR6NWZsTGYzVWF5d3N5dno1?=
 =?utf-8?B?d2J2bm8zOHcxY1VoaC9peklqV3doR1E2RjE5bWJNRTZUVGJpS2prOXVXTnNE?=
 =?utf-8?B?Q21IMnhNUERTZWhxaFBsNlZpMHk3aWRxQUgwZGdTYXdFUkdmWTlnMWhFVXlC?=
 =?utf-8?B?MTlvVDRZMHJsZEFReE9taFRxY0RuTmpqN1lobXBrUks2TXZoZXR2dTVDL0l3?=
 =?utf-8?B?bDlSKzVOQXBUc1kvblBmeUVMK3lzVWJFckRCVW50ay9jNlI4dnZhUzVaN1g3?=
 =?utf-8?B?ZGthSi9RdlIzTE1pUlFJZGRsam9QT2RYaEVTVHdUK1R5cmR2b2dIQ2NmYXhk?=
 =?utf-8?B?clc4eWk0RDZLaVJxTG80eU82VyttcVpJMEI2UUhOVGxCU0R6djY3NzRMTlVE?=
 =?utf-8?B?VVpZdHJGWlBLaWJWOC9zdVRGdDE1V1dCdDZOUVE4b21ldVlDQXExbmZiTUw4?=
 =?utf-8?B?ZENNQWx0N2JMdFZqS1R1OGhQeDZVS2NvVCs2dDV3eUIwOHZ6SGxTRVFLWUZB?=
 =?utf-8?B?eVdDZEMvQ2Q1TEtQcGpoTTVkQ25ZVzZkMEM2TWF5OHQ0WXhvSUh2SkFUbVBW?=
 =?utf-8?B?Y1BHT0ZEK2F1YjVZQ0hRNFVDNnozNVRyY2ZtQTFmemoyMUFLUnF5RU9LQjhG?=
 =?utf-8?B?Y05aZFM0RENiQWRvcGd4RC93NnFiTGFnYStCOFpPQ0JNd083VGx6eFRzOVUz?=
 =?utf-8?B?RTkzdW9CY3o4SW5WOWNieHVkdEV0eHBGaVVndkNnM0RkZGl6aDJIM1Q2alE2?=
 =?utf-8?B?QWlkMHhZNndLZHIwZWRqTDhQUDBuQi9XVmFta3NiOVV2NkM0ZndHalZMcDBj?=
 =?utf-8?B?a2xmaEZ1QWRDdjArWUxsNlAvOWpRcXRpbGhhOXRzeWlZV0Q1RXdCK0w0OUJr?=
 =?utf-8?B?WGtaOUU5alhrV3ZBZ1Zqa3NsL09peUtQM1N6c2ZISkRhUW15ZmNRc1ZGZnE1?=
 =?utf-8?B?Q1J2SzFKK3I3SWswUXUzNlpQMmxFbTJJVEFPUUNDZGM5S1JKUzFOK3NqNnk1?=
 =?utf-8?B?RHI3R3VaSDBCa2o5aGhRY2ZQbTVPY1hQVzlNMW16blVyYlhXcjU0dmlpTW5H?=
 =?utf-8?B?OHRpMWQrZHBxdWNIOUFiQzI1Z3hYZmxubkdIMk9ka2ZWN2hMMGs4Rmc5OUtq?=
 =?utf-8?B?KzBLWWg5dlhDU0puZ2wzb0paR2VhaFJWOVI2MjVpUXdITEh6cVJBRmF0eThm?=
 =?utf-8?B?K3pCMWZxZkN1U0J0N01XTHJDc2cyWDV2bHI0dmxyNEF3L0JhMXptN1lScWxI?=
 =?utf-8?B?VTJUSVlqc0cwOVMzY3U3M3ZpRzZ2NDhSUmFUZHJxZlpjT1VxQ1RFRWZ0SUxo?=
 =?utf-8?B?SE9Ua3NXMXVnUDdubkl0YUxYQkloRDYrZVF6dWMrVWVJVXVlYzBiMUd2MkJi?=
 =?utf-8?B?ZWVJVlIwOXgvV01yUEhIVjZUNGZ1Tk9vVFl3ZWVhQkpwMnptL0VrVXE2TDFG?=
 =?utf-8?B?UDUyU2FqV09aeXZsT3ZneFdNUEErVWxIUVJHRlFPNTJ2QnYzYjltNDFVRTNN?=
 =?utf-8?B?RkRQZXJmbDlNQkFhL1MvdTdpcmx5am9sODdudWIzRUl4bVYzSFNOWkRvb2ZN?=
 =?utf-8?B?Vk9pem9hZExZeEZRSnBTTjJ5Ulo4SGZETEFMNUYvdlAybE1SLzZmUUpseW4z?=
 =?utf-8?B?eDRGcG8yWW83ZGF5NCtKUDhrNldTKzJHYTRjMnZPeFNkRXlQRmYwekphcUw5?=
 =?utf-8?B?Mm9GVHdUcE9LL3NmQ2FMVjhUQnNPR1M4OHZ5VGJWS3o1THI4a1FEcmlhQ1VF?=
 =?utf-8?Q?53UXr4CO+awo8tD+KNRz93dgVSOiadmo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR12MB9707.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STZaRGorNzRjZFFPT3V5UzV3bW1rNTB5RVgxMDVCcDJlODdib1JSMDl3YUtj?=
 =?utf-8?B?cUxYV3daZ21Zd0lOOFNLUzFMZXdpd2NUWTVzZ2lmN2o1SjBVSTI2Q0lmOXJO?=
 =?utf-8?B?NnZ5d2ZiOUJBWUFsZTJxWGh0RmR1R050OER5Qi9TdGtKdmxMT2pRNXR3Uk8v?=
 =?utf-8?B?eGlpbmFTZjBrZWdrRUZqMGttNE9qTWdKK1hUOWl5d0w5YlorYWpMTnIybXk0?=
 =?utf-8?B?MWxtZCtyWTBzZ2kzOWJjbHB5UnFwY0NobDVycG5NWHhvVWdKcm5COG5yTmt3?=
 =?utf-8?B?enkzU3lib0N6MXJxd2Z1VkJBU0NWMENoL1B6R2h2ZDdoK2dsdGRLZU0xaEp0?=
 =?utf-8?B?V0YyU1NTWENMZmh1bmdkS04yOGpvNE1CcGEvWm8xSTFrdTBpY2l2NGVYM2Vr?=
 =?utf-8?B?dGpKRzFoQjYwV1gzU3hJL0ZwT1YxcmJUNjVmcmF1b0YzSmhURllhY1JFYUVi?=
 =?utf-8?B?U3NxeW82SGdtUGM2TFp4Uk9ZWEZBaUtJSVp4SVFIdmlVNHNwZmpIVXFXNERz?=
 =?utf-8?B?eDFzckRVMmZHRkg5VENTQURMd25scnJJNTlTT0tFSElyTnBPK2JHZ1dEZ1l1?=
 =?utf-8?B?T29YNlArUjhEZWpKcFlUMUd0YVZPOXQxYjBWLytkS2ZxN0NSWmVqYzBPMGF3?=
 =?utf-8?B?SzNvSnBUWFV2RDliZm80U3U1dWZBV0FxSnFyUlFSN0wwQkNMbW1PYU5KaUZn?=
 =?utf-8?B?N1V1S1JsaHZFYXpOTFZIcFYzMFU4dDJPNU9hWUxoTkYzWXFSYzFVc3hqQ1VX?=
 =?utf-8?B?SFNhOUd3cW50Q1JCZzZUQ05ZWHpxVmUzbjJLb1VQUHo0TGRKMW5kcU5HTlV6?=
 =?utf-8?B?N0EraVJOWFhQb0NVQ1ViYU5HMEJHMzdneURMcWpsakViL3dxNjhBeHRHbTdo?=
 =?utf-8?B?SXlKS2JFQ0dtSlV1NWtYcXNLWlYrYTZnZXpHUGJqa1M1dEVsMCtkQWU4WHJ6?=
 =?utf-8?B?SU5MOUxXbGt6RVlUZGd3Z0JlSnVMQm9Hdm5QVitUWTl3djNiS3ZHUVAxbG9J?=
 =?utf-8?B?RlFWQkU3Uy9VOXdwR2kwa2VJU1lCZ0tCUzl4dXNNdzlvZy8vTVByaCt5N0Ra?=
 =?utf-8?B?YmJrZ2pXVDhNVC9TWjdjSXVNb0tXdUxkVit5UjRGZXQwV1ZzSzdlUzdZVnlS?=
 =?utf-8?B?TW5JaFQ5dXdSN09lMFNZS1pyUmJ2Y3VSeFFCK2orOHdJRmpqNHowUDZ4T05U?=
 =?utf-8?B?ZGhoT29vbmMzUDh6ajFNemZuZUkrMHJPRnYrS2puU0E0SmVaa3hnNUFqdG9X?=
 =?utf-8?B?Mm5VUFBVWlMwVW1lM2FlSERkT00xZFNUaXdXTUZ1eXhlMW43dmNkZzIrekVt?=
 =?utf-8?B?V2loM1RUWTQzcnVyN3dmTXgxamxwSkJITGRYbUx3TTVid2VkOERvaGdzbmpJ?=
 =?utf-8?B?TytoMkRIQ2RMT0JvemRLTzlzeExQbGp6aFR2RC83cnVvQ0xBcEtLSldZOU1J?=
 =?utf-8?B?d3dXNzhDUW12TWplaXNOLzZWL09Nd21qcUpzdEkyWEJRTlFqODkzRzVhSERp?=
 =?utf-8?B?NFBMUHNvaUNwTkpwazI0endGUGxLRzdoQUlWQnkyWjJDWVRHbDJNblBXWEZX?=
 =?utf-8?B?VEp0SkNTYUhHWnl4R1lPb3dlajVoUlFWYVZ6NUl4ckc5UEJkd2xvQ0RpYndm?=
 =?utf-8?B?S0txT1F4ZEp6L0tJL3RpUFJhSVYzR3RxVGNHWHRTNWdGT0UzRU53WEljSm1V?=
 =?utf-8?B?bW1NU0RCcE5FdXlDOFRzanBjejFjNjZnWTdidDRwZUNoZXdjbWVJUnFGSm1N?=
 =?utf-8?B?cTNTQzZaa0FFU3VyTStNOWdVUnpCM2tzYnVUcUxraWRSL0lzS3lRMy9BL3Rz?=
 =?utf-8?B?QlVQcVNmWDJKRml1ZXdQeXMwQ2JwYjRmTkRpV0xwc3BtY0pQUUdQVkpYSVJB?=
 =?utf-8?B?VVNDOVlreEtreWlQZ1UvUlhvQm1FV0dLMDV1Ky9XYk5LN1BIWnVUbTdwZGtL?=
 =?utf-8?B?cUdNbXQ1QUZtTzZqeVpHQ3dIa244MGlScDlBdU1tbmwyVzVFSzh5MHN3MStx?=
 =?utf-8?B?RE4vaEN4TU8zWHhGOURIbjJBcGxtYW9iNndoK0lzSkxRdkprNXNCWkJMMktW?=
 =?utf-8?B?RXErVlhOMmIwUDl4aThoWXAxOFFvSm1FRm1KdFEyOXlqb3hLMkRUMk5LVWxt?=
 =?utf-8?Q?h+RBXS2RoH/fJ/V+UoBbKqfgG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae5cf8eb-4e1c-4dfa-63b2-08de390c4290
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9707.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 23:23:15.3403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WHif6hvuxxq+GhUwUkQhj1tQTlv1xNR5ZAWREXnxkUNHZz3CuACGfTIPVvdBBElDLpiZf2mNeT9OJq1m2RzhiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7374

On 12/2/2025 2:37 PM, dan.j.williams@intel.com wrote:
> Smita Koralahalli wrote:
>> From: Dan Williams <dan.j.williams@intel.com>
>>
>> Defer handling of Soft Reserved ranges that intersect CXL windows at
>> probe time. Delay processing until after device discovery so that the
>> CXL stack can publish windows and assemble regions before HMEM claims
>> those address ranges.
>>
>> Add a deferral path that schedules deferred work when HMEM detects a
>> Soft Reserved range intersecting a CXL window during probe. The deferred
>> work runs after probe completes and allows the CXL subsystem to finish
>> resource discovery and region setup before HMEM takes any action.
>>
>> This change does not address region assembly failures. It only delays
>> HMEM handling to avoid prematurely claiming ranges that CXL may own.
> 
> No, with the changes it just unconditionally disables dax_hmem in the
> presence of CXL. I do not think these changes can stand alone. It
> probably wants to be folded with patch 5 or something like that.

Sure, will include this with changes suggested in Patch 5.

Thanks
Smita


