Return-Path: <linux-fsdevel+bounces-51077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF51AD2A75
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 01:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28FED189067E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 23:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6C322A817;
	Mon,  9 Jun 2025 23:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XJQMZJ/m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C306E227E9F;
	Mon,  9 Jun 2025 23:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749511561; cv=fail; b=aQXPE/RUlwPZWvdfaLytJ57qbgk0pD3S/1k6F3b7jWRQBJQntiTIRI5Pf0lpQhKmWTVuljXwK9i2Ym7CljayyThd74v7QVT/lJRuXvY5bOIFiDxPK+pes9BVqlAB26xVVk1p94i/nHDxiF0wIvjwb53/QVmMWWj+aPZqTwrjvrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749511561; c=relaxed/simple;
	bh=AWmLsAZDdqdmrqT99e/h13EzHdGEcpZhJB+PQazRYWw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eHlLIXOD/X0eQtVH7+hWXYGlW02Ww0yfIamhl/3m686YidmGpVIuj2/9XQv1k7Y3Elfo950W5oLu2p6s9Dnh4GAL0ltfTpq9ECy7UxlTHh9HjjUTmzTNkM2sErHUOmqXFwzgjUnueB69lZBDeH/RIHBe0fZ+RbJInpgwerw286Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XJQMZJ/m; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3Bcu6J7Y6NyqpKenAQrvhZE9zkh5/WHjtHvlVtJABwBvjgxVc5YYoTLoBoLssgEVFocLfjfRpIedyPDzjfio3UZh6rIMIBCTKUYCOveMWP3kDa04uuYw4fTYUvHU7m2plYPGhdD8tLSODQsQA0009D9ZbaWfGzB7LWh8SP2F/aaTQ27iAYfqGfabRzAvINo7vJwBiZ1uS20dshzLTP7AWGdXGZbB+zO5f/GUOrlZtuSSjpfW7X/srlgUkloOahXDYhFIkv3Irci/NtXMK0Fc+SJYn49Bk20yPqfrOsurW8oROMo13oyr/LSZeBW2+KdQUmaWK4JO+wIhWrDi3geVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mU7iiiRJ6IcSZKrgeZdJltiUy19iXk3XFiTgLi6dsSc=;
 b=px3Y8qJNlfHt7IiImLwXA1BTM3jgGahqNL9bG4gBLLGXus49KoUxtwxYrRkC9g+Y7bTNJvUIVROut3WgXkwJK5kdnJ0lJ2dytDTTKd7GL4W/YuI8wbD/jAXNHuKMpnwZOf6pALQ+cvu0rMCpeNzYEVhr0JEKn3n4Z5m1UrkVcHTxmopKNTh3TSYdxW7o4d1sOEQ32SXHdZWOzZyq1R6Z7Gk4OsfeW1pNdREOZLKR00LG/ZRK3Oi7AWBTRlmXguJ9AlfXrdr9egvinsI2HMtaXxxJYUb14QRAUgxdgOzDTz6SY0bRksfSKsbNkOC/9en24iPQvX+w+/+U6tjoYJntiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mU7iiiRJ6IcSZKrgeZdJltiUy19iXk3XFiTgLi6dsSc=;
 b=XJQMZJ/maCTUlEHS+bH8PZkFC54PZZbCR/X4IwVkorXvbXStyrv7RTRLnjgrfkLfZnb1gF3INStnVpoTw+62KGb1oSYQ6AP51/fn7/Vng4QB8gNoBOBjbpmLUC/lgeQO/I7nXcXephZGzBe2fhTiOMIr0FjJuRTlBWOIDZjhMdc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 by SN7PR12MB6912.namprd12.prod.outlook.com (2603:10b6:806:26d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 9 Jun
 2025 23:25:54 +0000
Received: from MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3]) by MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3%3]) with mapi id 15.20.8792.038; Mon, 9 Jun 2025
 23:25:53 +0000
Message-ID: <8e445a49-7209-402f-96ab-5285560a08a1@amd.com>
Date: Mon, 9 Jun 2025 16:25:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] cxl/core: Remove CONFIG_CXL_SUSPEND and always
 build suspend.o
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox
 <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Ying Huang <huang.ying.caritas@gmail.com>,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>,
 Greg KH <gregkh@linuxfoundation.org>,
 Nathan Fontenot <nathan.fontenot@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>,
 PradeepVineshReddy Kodamati <PradeepVineshReddy.Kodamati@amd.com>,
 Zhijian Li <lizhijian@fujitsu.com>
References: <20250603221949.53272-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250603221949.53272-3-Smita.KoralahalliChannabasappa@amd.com>
 <20250609120237.00002eef@huawei.com>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita"
 <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <20250609120237.00002eef@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0065.namprd08.prod.outlook.com
 (2603:10b6:a03:117::42) To MW4PR12MB7142.namprd12.prod.outlook.com
 (2603:10b6:303:220::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7142:EE_|SN7PR12MB6912:EE_
X-MS-Office365-Filtering-Correlation-Id: 54119365-fe6a-445f-509e-08dda7acfa0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cC9ueDVRTFJVZ1RsSlZJSDMxZlNHejVxWTZCOENSV05CZEhVcTFoTlhPd3FP?=
 =?utf-8?B?dTRvbkl1VHJqdGpJUHZxSHd0YjZObmk4Mmh4bktRUGFGeUdZZnpRcytZT0Z2?=
 =?utf-8?B?Y0FPdDJ2RjB5Rk9LSU9OQjkwWVY0b0tWTHEwa1cxYmZsV2JZMXphVHZFVHRk?=
 =?utf-8?B?MnhFNmRKcTh1TTFtMExqeURkSzV0am5oUVVYOFdFbkU4eW1STmgzdFZ2R3BO?=
 =?utf-8?B?S1pNS2lpZW1paTJpdHhJRFpJaWRJazRnYjMvZXpaMitpMWZwUWQ3Ujc5Z2I0?=
 =?utf-8?B?Z3hsTkkxUlUxVDBQQ0x2MHkvVCtYZWllUWZpeGdsTXZtZlZqa2FOWGwrRTNi?=
 =?utf-8?B?b0g2SUdwZWh6MXhhRThGb1BwRUZmUGJYUFc4UzFtUHZ1cEwyUkJlVVBMelkx?=
 =?utf-8?B?MHVQeWsxMFBlNVBEWmhXUGh1TldSM3pGWnd3OXQ1dFhyZmN3djFjVlR3c0N4?=
 =?utf-8?B?c1NMYVMySEcxSW4rdCt4a0luekZmK1BEZ09nR2hvdTFuRGl3SWlUbFRSYm9Y?=
 =?utf-8?B?YmtJZXZMSU5MRWxxMW9nS0JZM2Q0clFNbThKWVBsUUxtQVUySWoxZFVQUDM4?=
 =?utf-8?B?b0M0UjFOVFh5dEVBRzI3YnJMRTNiL25UZ3kwYVJMSGs1Vm1KRkJkcUR0ZXgw?=
 =?utf-8?B?aGVRcGNvU3pmQTFVYUltOEg0NnJORkJuWmdtem1ZSDI2QlkrV2FZUW8xUU52?=
 =?utf-8?B?dkk3Q1ExaGh6SG1kRVVTQTBoY0JCQmRURUJCMHlDSjIrcmd3NHNNekFkNVRZ?=
 =?utf-8?B?ekg2WDZZQ0JJSE1OK1NHY0NxNlZkQXNjZHFDTU9oRTJlL3Zpdkd5a0tLZVpZ?=
 =?utf-8?B?NVowTm1kZWtmcy9pK3lUQ0laYnA3VXZXWDdFMm1IZlMzcUhwM0Y2VmVacGtB?=
 =?utf-8?B?TEtHQXMrdGZ6U05pQi9OMFN4c1YvRG5oUHZiMkc4aHdEQzg3Y1N0VTR4YWJP?=
 =?utf-8?B?K0JlUUxZaGFSZmMzcmVodDQ3L2x0Yi9IRjhSWGNsOEdwbmUrK1pNN3RkcmN0?=
 =?utf-8?B?VTFvMEdPOTZodUNmWFo5Yjc4bzh5WlpxbHM3L3dyK2VqS0drQTF6NXB2NzVt?=
 =?utf-8?B?YW5zdjZ3NmtVQysrYWdnZ3Q4M2MrTXlqWEFvSkRNbWRsMk92NS9NRVYrM0Rn?=
 =?utf-8?B?K2JYdDNReTRQM2ZBYnFnV0FkVUhWN0E1YlJTNCtMUEp6Zm43NnJURUM0aXRx?=
 =?utf-8?B?M1g1b0tORndIUmlodHJGNGI5UGg2cG9zNVZFWXdBaFd3bFVlWlp3RE9qdXZJ?=
 =?utf-8?B?MWZMenYyRFo3djd0Rm9iOUFMTFhsQmx6Wktwa0xzejI0anU0MENkb2ZNN1NI?=
 =?utf-8?B?amtOZjFHa2ZPMWZHNGdNb0h3VVdMWDY2TGRXMjFxWjNiT1N5djVsMWRoQS8w?=
 =?utf-8?B?cm4yZm84U2ExNnVFS1Y2Z2trelRoYks0THVvQmhZSkZ4MWZTNWZ5K1NSRm1w?=
 =?utf-8?B?Uk85bkxzWW5MblRTVW8ycHdrQktFVCt2SFMyRFlBczZsNlNHQkFKUldwVVM1?=
 =?utf-8?B?aDc1QnhMV3Z1Ylp6RHNFdmRTVnZIeGNUNk04aGpLVVovQjNENnpPZyt1dTlG?=
 =?utf-8?B?eHFMWkZqb1dZeU9PSCtRM0QvR0kybnF6OURGbmROYTYzODhIem5GcE8yY3lH?=
 =?utf-8?B?YkJ6YzFlNGV6UCtKQUlWWmgrOW5Yck5zN3hFcnVYUGhJT3NzbmtkbkFMMzJP?=
 =?utf-8?B?bFBRN0NnOVBYZUNlVWx5dkFrTkdxOUswK1RQQjRZb2JzS0dwN3Q2dzQ2RWlH?=
 =?utf-8?B?N0tTQjRGNG5hUGJodTNkT0twSnQwQXdCOW9POHJ1WnJRUTZCa3hFVUVzSU9X?=
 =?utf-8?B?ejRodGZoTGl1aVQ1eXZ5a1hUUzQrZEhXakIvU1hMY2MxakdIbDlnekU3clNx?=
 =?utf-8?B?MkRsbHM5WUIrM1pPSXNTMVBlWEZ5bGZCRmFJaitkZHp4K3ZQR0drWE12Y25F?=
 =?utf-8?Q?10MFKA7ffCM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7142.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVA2MGRrK1M0ZW1XcGhqSllmdzVhdDJ1MEFmcTFuQjRxb2EyZXNMRzhUYUhX?=
 =?utf-8?B?VmUyYTZzTDV2d0Z0WDdzS1NHMTd2ai9ic296ZkRhRzdpRG1wZnRsQlVKdHBE?=
 =?utf-8?B?KzNTTEZKQS9EY051WGpiVVgybFFodXlhTDhIbHgrQlFjRzN2VncvcFJMcSs2?=
 =?utf-8?B?UFpSM1dIRFIvUnJLcTNHUFIxb253WkR6VEs0Z0JTNWYxNFFhbDB0UEhrdW5Y?=
 =?utf-8?B?aEdNc0NNS3VNRlBpejlZL1hkQ3hUMDMxOWRSVDRyTTZTRnFjOHhHZnJXTFdC?=
 =?utf-8?B?SjMyUStSYU9XK0ozL3d0aEZjUTFlemdmRFc5YjJwcXAvUklrdWNpdlI2S0FN?=
 =?utf-8?B?Q1lkeksrcHpsb1hUNU5LZ3FQcVJIVWlhMUYvTWtFN0hCMVQ1aU1HQURlcUls?=
 =?utf-8?B?K0FEOHk3cDU3aWZzU1FRZ29xeVVXeHdka0xEZ3dMSStYcWFVWTdVN0lWaUlq?=
 =?utf-8?B?QjFUU0hKbVNSckwvTTVja0dySkwrY3FlUDJGWHpFQ3NuNVRydTVWN3BrZUZh?=
 =?utf-8?B?M0FEZGl1c1JOT3pWTGJwaGVNTVJ3UnVRN3V6M2phQkEwdHJORUF1L2ZoMXVS?=
 =?utf-8?B?WGdVbEs1bGFuRUk2T3RuNjdVdnNMZVhOSzY4RUhtVU1CNEs4R0ZJWWFxWkRU?=
 =?utf-8?B?WGwyUkd2bXUvZlpNODBwM2JJMGlIUGpYNlVRK1dIUGJrR3UrYVIzS2lmNFpv?=
 =?utf-8?B?ZlBXYk44MGdldTFXYzlXZURtOWJ6UkduMG8rQWFBV3UxK1QzOHJNSS9Qb1dF?=
 =?utf-8?B?amxmbXZNZEZuYjIyN0lVY0Q3TThTSWtsQUJ5ODYvYXU1UnNZTW1pM2pMM3Vy?=
 =?utf-8?B?ZlJOMi8wSjAxb2dnem9yRmFib1B1YURONTRmSGlTa0JGaGVEVkw5NnlFT3BQ?=
 =?utf-8?B?bkNlR2Z2bGMvcjZHK1lDMTJBK2dkTUhWcG9Ja0QwNmJSK3dCNVdKUWJZRklO?=
 =?utf-8?B?akl0UW5HODdMWGRKMEtEVkptZ3UwSDc0QUJJbjZVRFRMOFZaU1R2WklEOTZ4?=
 =?utf-8?B?Qy9venp3VUt3c3RJKzFaUmdtSlhZa01UOXc4aE5nUzIzOXNNTnBQSDNkbkx4?=
 =?utf-8?B?SGhqeGVFcG1HN0ZhSFNuQ1BEYy9vci9TbjVqejJva1F6Z2VzNk1CRnRDVGhT?=
 =?utf-8?B?QVYxK3lGdUVTSG1KVXZEdWFUMFNrUnpYdkJxOUgwbnhMUDkveWdNUWZZdVds?=
 =?utf-8?B?c0gvNklVYVQrRkpQcGlqV1ZjTGJ5MXlSQUFHQ2dtYmFScEhTS3NmcGtINGU2?=
 =?utf-8?B?WEhMckFxVmtYT0F5a0xjQzNyZjVZVllab0dlanBGZjZETWRPVzZaaTlwWWtT?=
 =?utf-8?B?WldoU0pGWmQ3aEc1YXNjd2syNjJqd3JHSHhyenhGU3hQQ1Y4MFZ2eUVWaGlM?=
 =?utf-8?B?SFZub3h5YmlrOXVXNEpqUzM3QzJmN1RlWEpNVTd0UURFZ0ErOC9qbWFSeS9u?=
 =?utf-8?B?dS9KRFJiNlNETHpxbjJPK2E0UE9pWlBSczVLb2t1VStpWlhDSDVzd0RNcW83?=
 =?utf-8?B?cFVZQ1poc3ExZmtCcmU4K05jMjFpRTdZUFErWSt5SXBQWGNNRWU5WHlndXd6?=
 =?utf-8?B?b2hhMEdzZ1A4d0xQYXp2SGd0dGtvMFdhc09BdStYQWZCdEJzWmtKMTU4L0dQ?=
 =?utf-8?B?b0czMHJvMTJCRHdTdTUxRWJwRWZ6eEE0eGplZnJma1ZVUlRmNVhmYmgxYXhr?=
 =?utf-8?B?MXlvbEF2a3M1YUw4bnZMK3lPcFBncUsyUzY2Q1p4NCsyU2FFVVBBL051eDN1?=
 =?utf-8?B?Ui90Qk5Icnl0RENuV09Xd0sybWtKTjF2WlNFc2lYUzhROXRMdUFLUkZyY0pu?=
 =?utf-8?B?Q3NXbXk5ei9sTWpPeTRDeUxGRmRPbFBWc01HVXQrYXZyb011MHV4bXZiVWxI?=
 =?utf-8?B?aWh0QXVHbU56MjFTTWJWUWtqeDcramg3NGZvOFNDY0ZjbGVyek5sczVzc04w?=
 =?utf-8?B?VGhLaHQwWDB4Wm5aMmI1NEdWRjQySHZnQWJmaVU0enp0TXJ4NTRTeUJ3MkNi?=
 =?utf-8?B?REN3T20xL05yVFN1SlN5eFlxL3k0alJLTHVBUGZBWDVjQ01yUnNiazd0OTgv?=
 =?utf-8?B?OFViNGNTa3k0aVMwRzNlQ2pBMnJzZzlmS3lvWDBOTWZsYWFYMXJ3VXI2M0Rs?=
 =?utf-8?Q?CkPl43vkqM+aR5cyR8XcwZt87?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54119365-fe6a-445f-509e-08dda7acfa0b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7142.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 23:25:53.2245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3MXGPfXl1x80YlLmyvKGN91Me9BnzSPo2VSHakXT5IIZhjsJ5l2lPvDjIvbxW/KjZE2gea7G7GihGcYpOw2kZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6912


On 6/9/2025 4:02 AM, Jonathan Cameron wrote:
> On Tue, 3 Jun 2025 22:19:44 +0000
> Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:
> 
>> In preparation for soft-reserved resource handling, make the suspend
>> infrastructure always available by removing the CONFIG_CXL_SUSPEND
>> Kconfig option.
>>
>> This ensures cxl_mem_active_inc()/dec() and cxl_mem_active() are
>> unconditionally available, enabling coordination between cxl_pci and
>> cxl_mem drivers during region setup and hotplug operations.
> 
> If these are no longer just being used for suspend, given there
> is nothing else in the file, maybe move them to somewhere else?

There was recommendation to move the wait queue declaration and its
related changes to acpi.c. I was considering that. Let me know if there 
is any other best place for this.

Thanks
Smita
> 
> 
>>
>> Co-developed-by: Nathan Fontenot <Nathan.Fontenot@amd.com>
>> Signed-off-by: Nathan Fontenot <Nathan.Fontenot@amd.com>
>> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> ---
>>   drivers/cxl/Kconfig        | 4 ----
>>   drivers/cxl/core/Makefile  | 2 +-
>>   drivers/cxl/core/suspend.c | 5 ++++-
>>   drivers/cxl/cxlmem.h       | 9 ---------
>>   include/linux/pm.h         | 7 -------
>>   5 files changed, 5 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
>> index cf1ba673b8c2..d09144c2002e 100644
>> --- a/drivers/cxl/Kconfig
>> +++ b/drivers/cxl/Kconfig
>> @@ -118,10 +118,6 @@ config CXL_PORT
>>   	default CXL_BUS
>>   	tristate
>>   
>> -config CXL_SUSPEND
>> -	def_bool y
>> -	depends on SUSPEND && CXL_MEM
>> -
>>   config CXL_REGION
>>   	bool "CXL: Region Support"
>>   	default CXL_BUS
>> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
>> index 086df97a0fcf..035864db8a32 100644
>> --- a/drivers/cxl/core/Makefile
>> +++ b/drivers/cxl/core/Makefile
>> @@ -1,6 +1,6 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   obj-$(CONFIG_CXL_BUS) += cxl_core.o
>> -obj-$(CONFIG_CXL_SUSPEND) += suspend.o
>> +obj-y += suspend.o
>>   
>>   ccflags-y += -I$(srctree)/drivers/cxl
>>   CFLAGS_trace.o = -DTRACE_INCLUDE_PATH=. -I$(src)
>> diff --git a/drivers/cxl/core/suspend.c b/drivers/cxl/core/suspend.c
>> index 29aa5cc5e565..5ba4b4de0e33 100644
>> --- a/drivers/cxl/core/suspend.c
>> +++ b/drivers/cxl/core/suspend.c
>> @@ -8,7 +8,10 @@ static atomic_t mem_active;
>>   
>>   bool cxl_mem_active(void)
>>   {
>> -	return atomic_read(&mem_active) != 0;
>> +	if (IS_ENABLED(CONFIG_CXL_MEM))
>> +		return atomic_read(&mem_active) != 0;
>> +
>> +	return false;
>>   }
>>   
>>   void cxl_mem_active_inc(void)
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index 3ec6b906371b..1bd1e88c4cc0 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -853,17 +853,8 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
>>   int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
>>   int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
>>   
>> -#ifdef CONFIG_CXL_SUSPEND
>>   void cxl_mem_active_inc(void);
>>   void cxl_mem_active_dec(void);
>> -#else
>> -static inline void cxl_mem_active_inc(void)
>> -{
>> -}
>> -static inline void cxl_mem_active_dec(void)
>> -{
>> -}
>> -#endif
>>   
>>   int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd);
>>   
>> diff --git a/include/linux/pm.h b/include/linux/pm.h
>> index f0bd8fbae4f2..415928e0b6ca 100644
>> --- a/include/linux/pm.h
>> +++ b/include/linux/pm.h
>> @@ -35,14 +35,7 @@ static inline void pm_vt_switch_unregister(struct device *dev)
>>   }
>>   #endif /* CONFIG_VT_CONSOLE_SLEEP */
>>   
>> -#ifdef CONFIG_CXL_SUSPEND
>>   bool cxl_mem_active(void);
>> -#else
>> -static inline bool cxl_mem_active(void)
>> -{
>> -	return false;
>> -}
>> -#endif
>>   
>>   /*
>>    * Device power management
> 


