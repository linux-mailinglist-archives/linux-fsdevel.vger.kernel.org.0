Return-Path: <linux-fsdevel+bounces-56257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FCFB1506E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 17:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86BE6188423B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 15:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CD2296160;
	Tue, 29 Jul 2025 15:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KOZUeqTA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708D2293C7D;
	Tue, 29 Jul 2025 15:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753804141; cv=fail; b=bLsyttQmE1CfSxZ/HTsfTMhc/t77NBverswbmF0NDxl35a7ZntcTrqcVHygzGo82CLqGPOjlPuQ2g+ztETY/FOle5vGYekoHDoYQkTRPVpbfxAOnV7e5mDbvkVkKP3MIkT6kGgQ8roaYLCzZTWLcLP+aRJ7vy2bkatqLJrbGdEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753804141; c=relaxed/simple;
	bh=iLxR2IlLZtcqUoUuo6ceRmFzVexFCZPXEnvpeHzfPZ8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=epIQ/oPPWECXnPd/7/QzjFzczrLz4ubFSr7HMoDWRb9cpb34MN68/pxZ59GFsk1IlTdMZuoHAWRiDtzzNdOfinM7TNt3u0HOwRgCqko4Z8/6x2K7VNzzHoWUk0FVCuWZD7nF7tR2OHzPVAceWTqTa9aki7S+Y34O2XfWUkdtO3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KOZUeqTA; arc=fail smtp.client-ip=40.107.92.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8Vk1btlTJvbxC8woGa1c8OIvI1uaDeTODKNO8fiEhpYNRFDW9yLAbOXC9nkYNwbpElVkk3SHeAQlwRqV2ekhdTi6VppO7fnghC23KVG5gnPeN2i68/1lw+yOvn+Gh7PNCr7GGqKZfhsnQS0YHTvmlNLplVus7AcDQnbT75CJTBqs+We2KbMxRpWAV8zyGznOT+W9wDS+2DqYEeddJhsXMolaiAqOgSEtb7pdgP9lBVoolmMzJ/4vqdrlkb5bhGgNqEoVQ3ksZyFCrcu6/VD57OS8CFYgiayaQWOrpJZNNadQNmbU0ScnvrT0nSDRcRnIyuVHU5cp9tymUL75Cw2vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNxffvazTzU3KMIMoaOumJENMOlrfR13m2XZGTsAriA=;
 b=Iw/W4RtUC5zvKgs6tBEFV6W3R+m1TjSyLWGCGeXJCNjSls06NhW5jQiTGFqkHewVPHvtDY1NonrDgFMQ6aVZGU4ifJIMFRIOGsdvlTy3qmqX/Bs/m/bTr5dpmXtACW5h6dTL4MmNW6HCmsKmF3vXDyiNap5nTnt+OWY+cNksumLTcxQqa+8D8deKm2wEozuQ8yv1M2Pd7W3Zv9I4GADfH5m/6ZFdiJxk07P5F6AGvfvj9Hs2jMBEKSDX7X4ZCICiS3gxJbjw7y68INy1+AAsX3O5iJ3nYjgy6uy3FFpbsl/rq5qdFy4htwTCZVJpnmU3ToOSxzTxO88kRA4XO49krw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNxffvazTzU3KMIMoaOumJENMOlrfR13m2XZGTsAriA=;
 b=KOZUeqTAnM1dQL3WaYG3RogTyWjEs6wJ63zCjIRCcSGY37/DEjqBQCFTMWlOIIBcw/S14DPBMe3q+QTQ0aKiy7C4TEn52Rv9v0adKCjUc9nYuwXwlVUfHniy6fAZ143JIcDlniDPDTjnaeWT9r1XGr6nc+XyRS/91m8R9xL1L5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 by CYYPR12MB8704.namprd12.prod.outlook.com (2603:10b6:930:c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 15:48:55 +0000
Received: from MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3]) by MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3%3]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 15:48:55 +0000
Message-ID: <bf47567b-3277-48a3-a500-81b444cd165a@amd.com>
Date: Tue, 29 Jul 2025 08:48:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/7] cxl/acpi: Add background worker to coordinate with
 cxl_mem probe completion
To: dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
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
References: <20250715180407.47426-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250715180407.47426-4-Smita.KoralahalliChannabasappa@amd.com>
 <68808fb4e4cbf_137e6b100cc@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita"
 <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <68808fb4e4cbf_137e6b100cc@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:279::11) To MW4PR12MB7142.namprd12.prod.outlook.com
 (2603:10b6:303:220::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7142:EE_|CYYPR12MB8704:EE_
X-MS-Office365-Filtering-Correlation-Id: eedf2a62-1921-42fa-ca7f-08ddceb76c4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2ZqdlA0aTRQNHVxVTU3VmhZODdBYmp0bUc0Qm0xMTZJTmlQMXVER1NnNHYz?=
 =?utf-8?B?WklzYTdlQzd6QWVlWVltVFpnc2QyZGE2Z0VGVUt1UUZSTmM5eEJqT1RDRTFL?=
 =?utf-8?B?cllNNk5wempPSDdsVFowaEVhTHJVejl4dmU0REpJdm1tOEUrTjRhemtFTzB2?=
 =?utf-8?B?ZUg4aGMyaVZTczBOSFZ3MEc2MHZTMTRROWkzSGU1dEkrT1hvMkFFR0hETFFR?=
 =?utf-8?B?b051OHJMMjhVWFJrSlBTTFQyajdSY3lmVE5pTWFpcHJjcjNkMmRCdlFQVU9h?=
 =?utf-8?B?TFdqVXVvc3d5ZUxYQ0lONkVHQjRKY21RSjh1RTc0WnpDeTlnMjhGMkYrejBB?=
 =?utf-8?B?YkVKTW9sQkN2Um81MUNBTGo5TG1peHdKcVNEYmE5c0NHV05yOU9Ick5sdUxp?=
 =?utf-8?B?OHlVZlAxazN1M3BmSXR2cUU5Y21CNjRNRHVnWitxbTF4T0dLR0RnNzUwWlZF?=
 =?utf-8?B?NnVKcVFSUXBrUkZ4WDhoVzMveWJ0RkthUmhGTkNBN290VlhOaEVQY0tmRWtW?=
 =?utf-8?B?YjBsVW5GZWc4Y1JGYkFoczJlZHJrRUIvZ2ZtTTVSRzZGNkJnTU5OQm5rT2Vn?=
 =?utf-8?B?eG9KVTZIMmgwMjJJZFJOdE9aaEJCS2Fhb2lyb0JXdTU2eDFwVy9XYlF3WDNK?=
 =?utf-8?B?UWpvMERzdllGa25FQmdhendQc2w0TUw3WVhVTG8vc25JK243RFo0S3pVUnBD?=
 =?utf-8?B?OXR5cFMyWkVnVHpQK2hURVlmbVpJbU00UU1TVCtHeEZZVC9YTk5zNmgyeVda?=
 =?utf-8?B?TmpMczJKdjJsYmdBQTNQMWJJZit6QXRkMEtVU3grSFRDNUJwWWx0ajJzQzdO?=
 =?utf-8?B?V1IvL3N0bVBVTWFRNUVzbjRKMjFENEpoanZ3MmNxanhJY0V2VzJZQ1J1Tk5W?=
 =?utf-8?B?Tjg3aXVub1Axbms0RS9nZkE3R1RKWmFlVTZaaEJVM0xXSHMwcnBRMHFJMFkx?=
 =?utf-8?B?SmlQQ3FqQnA1Ymwxd0NsK1BNeC8zVlducytNUTBSRGdBWnhtOFpidnRzdWxS?=
 =?utf-8?B?cTk1WnN3ZUFhcVZValhMbzlsRjlUMndWOGM1RVhGV0ovZ1VjdGgzeVBadzlU?=
 =?utf-8?B?dTlBWDE2QnlsMWV4MEZrcnhpb21hcmtBUTJqbTVkNGRwOFVOZXV3eHE0UDVP?=
 =?utf-8?B?a3lQYzROdHdWd3B4OTBXTVJPcjNJN1FYUHMzVUF5MU01RmV4Q3V4S3NFcEd2?=
 =?utf-8?B?YXNsMW05RmhLVDlsbnFrbnBRazJiblBqNlVUSG15NnZubUFHMHE0cXhPbElO?=
 =?utf-8?B?THQyVjl1UmhvRElHVzdwYjBXdFoxdnBMYTF1TElYZUhENlVteGUzS0lHR2pW?=
 =?utf-8?B?c2pyUXRYZldRdFVnbmN3elJaWTFUN2w2Yi9uN2UxTkdkQWJxMTdOOEh2VHlj?=
 =?utf-8?B?OFgvK2tPRVhoWnhQeWViWnEwOWkxakprZ0l3bkJPQXVCVUFhN1dxb1d4NTFs?=
 =?utf-8?B?QXN3YTAwK2tCUURvUnVTV2F3c1kxUzA0VURsc0t2MENiejBsWFQ1c21Pd1BJ?=
 =?utf-8?B?SnRuL0FqWDY1eVY0NUlmc3BZdk9PQ3FyWml0VEhOVHZsUnhDdmxadkNJQWNF?=
 =?utf-8?B?Q2o5Vkl6MmZxc2FsWmRlTEkvT05IbzNDcm9Xd3hOeEVsSlYxalZiTGExSzBO?=
 =?utf-8?B?TlF0NzdMRlduUEt6TUl1U2Yxc3Jad0NKd2g5SWhLU1A1ZXR2SWhoS29TTnNt?=
 =?utf-8?B?Z2NCa1JiVEl5bHFZZXZjZDlVT2FoS1dyNk1WWXpVREZobVNFRDNENmlwRjdE?=
 =?utf-8?B?NTdMYk1ObDQ5T0w5cGJ6Y1AvTjhQcXc5OExtd1R4YVBISk1POUF5cktZdjhq?=
 =?utf-8?B?QnAvU0ZGNlFGZmpFQjEzWGdXUjBDZVNGNmVVdC9ZRWNrRy91MGdON1N1a3Jx?=
 =?utf-8?B?dmVSeWNXajVtMTkyRE91MEZCby81VVNrRjNhRWZnVWRqQjNCSllwMkdpUlE1?=
 =?utf-8?Q?R/YbsstU36M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7142.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmtZRGsyd3JWK1QxMUNydW9BNGRueFBEejM0RlY1bzlKMTV5TEwxa2hITkhG?=
 =?utf-8?B?Y2FmQ3ltQVFPQVZXMnZCczJCVmY3cUFoM2pvZDNjbjVxN3lpMS9RbjAxU3hO?=
 =?utf-8?B?M2JNVDVxanVIa1E4SUFaRkh4WUVIS0wwTDdxQ2FEK240OU95eWs0ZnlNNmpr?=
 =?utf-8?B?ZHlGcVBDWkdrN3VqaE0wWWg3QTg0REJ6VnVLaVl6WGgvVXFCa0MrWmovcnlV?=
 =?utf-8?B?WUJDOGNOdzd4MzVPVlJFWlpPdUtTeGFrT3BFY2FNYTBrY3JmdXQ0ekUrRFBC?=
 =?utf-8?B?aEtkZklybE1OMmJ3UlFEcEhDT1dKUm5Ob2pNMjRRd0QvNlcxM2hXL2doMzJt?=
 =?utf-8?B?bnpxMWNWMTN1V24rVmVaaDNNbFpnRVFPcUMxVGp0NllWTzdOVkhEWXJId0FY?=
 =?utf-8?B?dDIwcE11Y0hhSHh1QkN4bDlxcXBWTm56dDlaSmxWUUZmcURFT0xhc2dFZkk5?=
 =?utf-8?B?MmZXeHZIN0wxT055aDJSeUNVVGdKQ3RvbXorVHp2VWVaUHZTcUQxMkhTSEV4?=
 =?utf-8?B?T2F3OUpuU1RROUFDWXJMdUVDYzNJZFN1Z1lZbVpoSXlnUDVWK0gvbjlmS01s?=
 =?utf-8?B?NUwrYWFMTFc4QjVkL3lFT1FCRzgyZ0h4b1FBaXA4RVRoWGFQSEtyUGZEUkk1?=
 =?utf-8?B?VTIwVUZYQ3l5S3ZNN0RueVlDTUxZRHNPOFhmcjdnQnptTk5mTkN4RTA1eVFQ?=
 =?utf-8?B?K1BZam1yNnByWDQyRXNmZ2pXZEVpOU9yYy9wc1o1cFNGT3ZHbFdSc1pFZ0Nh?=
 =?utf-8?B?UWtjTUk4TUNISWlFb1V2cWRpUmpFM2lER05jS2xyUXAyTERWZTR2Q2tMTEhi?=
 =?utf-8?B?Y3RKd2pnVkFla3RWREZrRVl5NmxsY2ttb3F2U2JyRmNPdy9scGtCYlBYejNx?=
 =?utf-8?B?TDd1SVVRMndoWlZEVGphUGc0S2JUemRoR2ZsZTJFN1dNdTZEdGN4S1V2SEx5?=
 =?utf-8?B?SldvY3JIWVFxZUNNTncwZ3RXVjFrb3hOYWFwbkhzRkp6YjBuZHU5ZXFkQnMr?=
 =?utf-8?B?L1oxTWprUkgvd2xmK2lmRVZydXpvT3hsejZLbWp6Uzk5L3lsQk9VV09WbXBK?=
 =?utf-8?B?WWdaUlE2bkVZTmVQOEJ4dkxFVTVlYkZTQThobXpQMVErRHFlSi9NYUhCL2xW?=
 =?utf-8?B?SGliODZPUDVWMTJ5a1IzYjkzTUh1N1h2OGZ6VlVSYkFwNVZoZlgzNDJhWTBQ?=
 =?utf-8?B?b0prald4S0pRRE5HdDNMLytieGZza3RiVFNqODhpKy80cmhIK2w4b1lzd2hR?=
 =?utf-8?B?VlBJdHFsdHZlQzZ0WTBXLy9PNEliaEF5T1FGbk8yTFlXK2tlWVR0MDFCa3Jx?=
 =?utf-8?B?ZnZGbXFURGtDNmpuUlBQM1dDbWFQbC9JZXUrd1ZWVHlQampoZmN6aXJvRnFS?=
 =?utf-8?B?bUdpM1V0WnZEQ2ltSWRjRDdzTkpSajdWWDBLRGNyY2k0aTVuRjE2dXpKOU5z?=
 =?utf-8?B?bWdyM0x3UTVSNHVEd2ZvM0xuZnVaVFJjRkpWTCtUYVBPdS83OHpWN2dlMHVL?=
 =?utf-8?B?MnFTLy90MnFjUHdLQXhmeXNOZG9OMDlHOWhZUmdhYk1ERTV3S0V4SGthVHhD?=
 =?utf-8?B?eDhYcXV4OFVwclR6SjBlSlpYR0NaOHk3VS80Y3BFc0tFZXFab1FjQjYyTEZv?=
 =?utf-8?B?SDFNdkFBSGVaYmtJdUdTWUFnV0pmd3M5cEduYlZMTGVaUC9nNWxweGJwUjEw?=
 =?utf-8?B?clZCSVpiQk1hWVQrUm5FZzJNZFFKWisvdXdqTlVJRFBRa3kyTUpaMmJGWGJM?=
 =?utf-8?B?TkxSNlg4RlNuamdGV3ZzSXRTc2k0RCtBTmdWeTRTSkcvR1hIWkZEYWFGUCtF?=
 =?utf-8?B?YW1HNjRJWXNZQmNBS0crTEV3eVhDOW91aG5hc0Z0dTMwcGg4emRPQ0N2VmR5?=
 =?utf-8?B?UC9sYjAySmhrT0JnTXhHV0IzalFwTVRFYVBlQnNTNGZKMjdGVUlxNis1L3Zu?=
 =?utf-8?B?enhnMGFld2ZMbjNoUFZKNU8xQitGcDY0UEY1a2VXR25zZ2lHRFNPbldmdXlv?=
 =?utf-8?B?UkhtQzJPK1NxV2lJSzBVYlQ1a250SVVNZTdURHFZb0ZscS82bnpGSjJBa3Vk?=
 =?utf-8?B?MHgzUkZnSENON1g0NUZpU1NkSXV1Vm1HZWRnRzh6VUVBRjNTd1ZHV1UvRkNK?=
 =?utf-8?Q?E/g1CM7pxmUeEGs8zfQcF3jKA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eedf2a62-1921-42fa-ca7f-08ddceb76c4c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7142.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 15:48:55.2616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9BeWKtyrEU6KKYFBR5uZ+44aVWTgaHlX4X5eVjQFyy9hOhABykvUEhc7NXp8NLoliPO5DErpQxxwKe8w3f8G0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8704

Hi Dan,

On 7/23/2025 12:31 AM, dan.j.williams@intel.com wrote:
> Smita Koralahalli wrote:
>> Introduce a background worker in cxl_acpi to delay SOFT RESERVE handling
>> until the cxl_mem driver has probed at least one device. This coordination
>> ensures that DAX registration or fallback handling for soft-reserved
>> regions is not triggered prematurely.
>>
>> The worker waits on cxl_wait_queue, which is signaled via
>> cxl_mem_active_inc() during cxl_mem_probe(). Once at least one memory
>> device probe is confirmed, the worker invokes wait_for_device_probe()
>> to allow the rest of the CXL device hierarchy to complete initialization.
>>
>> Additionally, it also handles initialization order issues where
>> cxl_acpi_probe() may complete before other drivers such as cxl_port or
>> cxl_mem have loaded, especially when cxl_acpi and cxl_port are built-in
>> and cxl_mem is a loadable module. In such cases, using only
>> wait_for_device_probe() is insufficient, as it may return before all
>> relevant probes are registered.
> 
> Right, but that problem is not solved by this which still leaves the
> decision on when to give up on this mechanism, and this mechanism does
> not tell you when follow-on probe work is complete.
> 
>> While region creation happens in cxl_port_probe(), waiting on
>> cxl_mem_active() would be sufficient as cxl_mem_probe() can only succeed
>> after the port hierarchy is in place. Furthermore, since cxl_mem depends
>> on cxl_pci, this also guarantees that cxl_pci has loaded by the time the
>> wait completes.
>>
>> As cxl_mem_active() infrastructure already exists for tracking probe
>> activity, cxl_acpi can use it without introducing new coordination
>> mechanisms.
> 
> In appreciate the instinct to not add anything new, but the module
> loading problem is solvable.
> 
> If the goal is: "I want to give device-dax a point at which it can make
> a go / no-go decision about whether the CXL subsystem has properly
> assembled all CXL regions implied by Soft Reserved instersecting with
> CXL Windows." Then that is something like the below, only lightly tested
> and likely regresses the non-CXL case.
> 
> -- 8< --
>  From 48b25461eca050504cf5678afd7837307b2dd14f Mon Sep 17 00:00:00 2001
> From: Dan Williams <dan.j.williams@intel.com>
> Date: Tue, 22 Jul 2025 16:11:08 -0700
> Subject: [RFC PATCH] dax/cxl: Defer Soft Reserved registration
> 
> CXL and dax_hmem fight over "Soft Reserved" (EFI Specific Purpose Memory)
> resources are published in the iomem resource tree. The entry blocks some
> CXL hotplug flows, and CXL blocks dax_hmem from publishing the memory in
> the event that CXL fails to parse the platform configuration.
> 
> Towards resolving this conflict: (the non-RFC version
> of this patch should split these into separate patches):
> 
> 1/ Defer publishing "Soft Reserved" entries in the iomem resource tree
>     until the consumer, dax_hmem, is ready to use them.
> 
> 2/ Fix detection of "Soft Reserved" vs "CXL Window" resource overlaps by
>     switching from MODULE_SOFTDEP() to request_module() for making sure that
>     cxl_acpi has had a chance to publish "CXL Window" resources.
> 
> 3/ Add cxl_pci to the list of modules that need to have had a chance to
>     scan boot devices such that wait_device_probe() flushes initial CXL
>     topology discovery.
> 
> 4/ Add a workqueue that delays consideration of "Soft Reserved" that
>     overlaps CXL so that the CXL subsystem can complete all of its region
>     assembly.
> 
> For RFC purposes this only solves the reliabilty of the DAX_CXL_MODE_DROP
> case. DAX_CXL_MODE_REGISTER support can follow to shutdown CXL in favor of
> vanilla DAX devices as an emergency fallback for platform configuration
> quirks and bugs.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   arch/x86/kernel/e820.c    |  2 +-
>   drivers/dax/hmem/device.c |  4 +-
>   drivers/dax/hmem/hmem.c   | 94 +++++++++++++++++++++++++++++++++------
>   include/linux/ioport.h    | 25 +++++++++++
>   kernel/resource.c         | 58 +++++++++++++++++++-----
>   5 files changed, 156 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index c3acbd26408b..aef1ff2cabda 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -1153,7 +1153,7 @@ void __init e820__reserve_resources_late(void)
>   	res = e820_res;
>   	for (i = 0; i < e820_table->nr_entries; i++) {
>   		if (!res->parent && res->end)
> -			insert_resource_expand_to_fit(&iomem_resource, res);
> +			insert_resource_late(res);
>   		res++;
>   	}
>   
> diff --git a/drivers/dax/hmem/device.c b/drivers/dax/hmem/device.c
> index f9e1a76a04a9..22732b729017 100644
> --- a/drivers/dax/hmem/device.c
> +++ b/drivers/dax/hmem/device.c
> @@ -83,8 +83,8 @@ static __init int hmem_register_one(struct resource *res, void *data)
>   
>   static __init int hmem_init(void)
>   {
> -	walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED,
> -			IORESOURCE_MEM, 0, -1, NULL, hmem_register_one);
> +	walk_soft_reserve_res_desc(IORES_DESC_SOFT_RESERVED, IORESOURCE_MEM, 0,
> +				   -1, NULL, hmem_register_one);
>   	return 0;
>   }
>   
> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
> index 5e7c53f18491..0916478e3817 100644
> --- a/drivers/dax/hmem/hmem.c
> +++ b/drivers/dax/hmem/hmem.c
> @@ -59,9 +59,45 @@ static void release_hmem(void *pdev)
>   	platform_device_unregister(pdev);
>   }
>   
> +static enum dax_cxl_mode {
> +	DAX_CXL_MODE_DEFER,
> +	DAX_CXL_MODE_REGISTER,
> +	DAX_CXL_MODE_DROP,
> +} dax_cxl_mode;
> +
> +static int handle_deferred_cxl(struct device *host, int target_nid,
> +				const struct resource *res)
> +{
> +	if (region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
> +			      IORES_DESC_CXL) != REGION_DISJOINT) {
> +		if (dax_cxl_mode == DAX_CXL_MODE_DROP)
> +			dev_dbg(host, "dropping CXL range: %pr\n", res);
> +	}
> +	return 0;
> +}
> +
> +struct dax_defer_work {
> +	struct platform_device *pdev;
> +	struct work_struct work;
> +};
> +
> +static void process_defer_work(struct work_struct *_work)
> +{
> +	struct dax_defer_work *work = container_of(_work, typeof(*work), work);
> +	struct platform_device *pdev = work->pdev;
> +
> +	/* relies on cxl_acpi and cxl_pci having had a chance to load */
> +	wait_for_device_probe();
> +
> +	dax_cxl_mode = DAX_CXL_MODE_DROP;
> +
> +	walk_hmem_resources(&pdev->dev, handle_deferred_cxl);
> +}
> +
>   static int hmem_register_device(struct device *host, int target_nid,
>   				const struct resource *res)
>   {
> +	struct dax_defer_work *work = dev_get_drvdata(host);
>   	struct platform_device *pdev;
>   	struct memregion_info info;
>   	long id;
> @@ -70,14 +106,21 @@ static int hmem_register_device(struct device *host, int target_nid,
>   	if (IS_ENABLED(CONFIG_CXL_REGION) &&
>   	    region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
>   			      IORES_DESC_CXL) != REGION_DISJOINT) {

I may be wrong here, but could this check fail? While request_module() 
ensures that cxl_acpi and cxl_pci are requested for loading, it does not 
guarantee that either has completed initialization or that region 
enumeration (i.e add_cxl_resources()) has finished by the time we reach 
this check.

We also haven't called wait_for_device_probe() at this point, which is 
typically used to block until all pending device probes are complete.

Thanks
Smita
> -		dev_dbg(host, "deferring range to CXL: %pr\n", res);
> -		return 0;
> +		switch (dax_cxl_mode) {
> +		case DAX_CXL_MODE_DEFER:
> +			dev_dbg(host, "deferring range to CXL: %pr\n", res);
> +			schedule_work(&work->work);
> +			return 0;
> +		case DAX_CXL_MODE_REGISTER:
> +			dev_dbg(host, "registering CXL range: %pr\n", res);
> +			break;
> +		case DAX_CXL_MODE_DROP:
> +			dev_dbg(host, "dropping CXL range: %pr\n", res);
> +			return 0;
> +		}
>   	}
>   
> -	rc = region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
> -			       IORES_DESC_SOFT_RESERVED);
> -	if (rc != REGION_INTERSECTS)
> -		return 0;
> +	/* TODO: insert "Soft Reserved" into iomem here */
>   
>   	id = memregion_alloc(GFP_KERNEL);
>   	if (id < 0) {
> @@ -123,8 +166,30 @@ static int hmem_register_device(struct device *host, int target_nid,
>   	return rc;
>   }
>   
> +static void kill_defer_work(void *_work)
> +{
> +	struct dax_defer_work *work = container_of(_work, typeof(*work), work);
> +
> +	cancel_work_sync(&work->work);
> +	kfree(work);
> +}
> +
>   static int dax_hmem_platform_probe(struct platform_device *pdev)
>   {
> +	struct dax_defer_work *work = kzalloc(sizeof(*work), GFP_KERNEL);
> +	int rc;
> +
> +	if (!work)
> +		return -ENOMEM;
> +
> +	work->pdev = pdev;
> +	INIT_WORK(&work->work, process_defer_work);
> +
> +	rc = devm_add_action_or_reset(&pdev->dev, kill_defer_work, work);
> +	if (rc)
> +		return rc;
> +
> +	platform_set_drvdata(pdev, work);
>   	return walk_hmem_resources(&pdev->dev, hmem_register_device);
>   }
>   
> @@ -139,6 +204,16 @@ static __init int dax_hmem_init(void)
>   {
>   	int rc;
>   
> +	/*
> +	 * Ensure that cxl_acpi and cxl_pci have a chance to kick off
> +	 * CXL topology discovery at least once before scanning the
> +	 * iomem resource tree for IORES_DESC_CXL resources.
> +	 */
> +	if (IS_ENABLED(CONFIG_CXL_REGION)) {
> +		request_module("cxl_acpi");
> +		request_module("cxl_pci");
> +	}
> +
>   	rc = platform_driver_register(&dax_hmem_platform_driver);
>   	if (rc)
>   		return rc;
> @@ -159,13 +234,6 @@ static __exit void dax_hmem_exit(void)
>   module_init(dax_hmem_init);
>   module_exit(dax_hmem_exit);
>   
> -/* Allow for CXL to define its own dax regions */
> -#if IS_ENABLED(CONFIG_CXL_REGION)
> -#if IS_MODULE(CONFIG_CXL_ACPI)
> -MODULE_SOFTDEP("pre: cxl_acpi");
> -#endif
> -#endif
> -
>   MODULE_ALIAS("platform:hmem*");
>   MODULE_ALIAS("platform:hmem_platform*");
>   MODULE_DESCRIPTION("HMEM DAX: direct access to 'specific purpose' memory");
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index e8b2d6aa4013..4fc6ab518c24 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -232,6 +232,9 @@ struct resource_constraint {
>   /* PC/ISA/whatever - the normal PC address spaces: IO and memory */
>   extern struct resource ioport_resource;
>   extern struct resource iomem_resource;
> +#ifdef CONFIG_EFI_SOFT_RESERVE
> +extern struct resource soft_reserve_resource;
> +#endif
>   
>   extern struct resource *request_resource_conflict(struct resource *root, struct resource *new);
>   extern int request_resource(struct resource *root, struct resource *new);
> @@ -255,6 +258,22 @@ int adjust_resource(struct resource *res, resource_size_t start,
>   		    resource_size_t size);
>   resource_size_t resource_alignment(struct resource *res);
>   
> +
> +#ifdef CONFIG_EFI_SOFT_RESERVE
> +static inline void insert_resource_late(struct resource *new)
> +{
> +	if (new->desc == IORES_DESC_SOFT_RESERVED)
> +		insert_resource_expand_to_fit(&soft_reserve_resource, new);
> +	else
> +		insert_resource_expand_to_fit(&iomem_resource, new);
> +}
> +#else
> +static inline void insert_resource_late(struct resource *new)
> +{
> +	insert_resource_expand_to_fit(&iomem_resource, new);
> +}
> +#endif
> +
>   /**
>    * resource_set_size - Calculate resource end address from size and start
>    * @res: Resource descriptor
> @@ -409,6 +428,12 @@ walk_system_ram_res_rev(u64 start, u64 end, void *arg,
>   extern int
>   walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start, u64 end,
>   		    void *arg, int (*func)(struct resource *, void *));
> +int walk_soft_reserve_res_desc(unsigned long desc, unsigned long flags,
> +			       u64 start, u64 end, void *arg,
> +			       int (*func)(struct resource *, void *));
> +int region_intersects_soft_reserve(struct resource *root, resource_size_t start,
> +				   size_t size, unsigned long flags,
> +				   unsigned long desc);
>   
>   struct resource *devm_request_free_mem_region(struct device *dev,
>   		struct resource *base, unsigned long size);
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 8d3e6ed0bdc1..fd90990c31c6 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -321,8 +321,8 @@ static bool is_type_match(struct resource *p, unsigned long flags, unsigned long
>   }
>   
>   /**
> - * find_next_iomem_res - Finds the lowest iomem resource that covers part of
> - *			 [@start..@end].
> + * find_next_res - Finds the lowest resource that covers part of
> + *		   [@start..@end].
>    *
>    * If a resource is found, returns 0 and @*res is overwritten with the part
>    * of the resource that's within [@start..@end]; if none is found, returns
> @@ -337,9 +337,9 @@ static bool is_type_match(struct resource *p, unsigned long flags, unsigned long
>    * The caller must specify @start, @end, @flags, and @desc
>    * (which may be IORES_DESC_NONE).
>    */
> -static int find_next_iomem_res(resource_size_t start, resource_size_t end,
> -			       unsigned long flags, unsigned long desc,
> -			       struct resource *res)
> +static int find_next_res(struct resource *parent, resource_size_t start,
> +			 resource_size_t end, unsigned long flags,
> +			 unsigned long desc, struct resource *res)
>   {
>   	struct resource *p;
>   
> @@ -351,7 +351,7 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
>   
>   	read_lock(&resource_lock);
>   
> -	for_each_resource(&iomem_resource, p, false) {
> +	for_each_resource(parent, p, false) {
>   		/* If we passed the resource we are looking for, stop */
>   		if (p->start > end) {
>   			p = NULL;
> @@ -382,16 +382,23 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
>   	return p ? 0 : -ENODEV;
>   }
>   
> -static int __walk_iomem_res_desc(resource_size_t start, resource_size_t end,
> -				 unsigned long flags, unsigned long desc,
> -				 void *arg,
> -				 int (*func)(struct resource *, void *))
> +static int find_next_iomem_res(resource_size_t start, resource_size_t end,
> +			       unsigned long flags, unsigned long desc,
> +			       struct resource *res)
> +{
> +	return find_next_res(&iomem_resource, start, end, flags, desc, res);
> +}
> +
> +static int walk_res_desc(struct resource *parent, resource_size_t start,
> +			 resource_size_t end, unsigned long flags,
> +			 unsigned long desc, void *arg,
> +			 int (*func)(struct resource *, void *))
>   {
>   	struct resource res;
>   	int ret = -EINVAL;
>   
>   	while (start < end &&
> -	       !find_next_iomem_res(start, end, flags, desc, &res)) {
> +	       !find_next_res(parent, start, end, flags, desc, &res)) {
>   		ret = (*func)(&res, arg);
>   		if (ret)
>   			break;
> @@ -402,6 +409,15 @@ static int __walk_iomem_res_desc(resource_size_t start, resource_size_t end,
>   	return ret;
>   }
>   
> +static int __walk_iomem_res_desc(resource_size_t start, resource_size_t end,
> +				 unsigned long flags, unsigned long desc,
> +				 void *arg,
> +				 int (*func)(struct resource *, void *))
> +{
> +	return walk_res_desc(&iomem_resource, start, end, flags, desc, arg, func);
> +}
> +
> +
>   /**
>    * walk_iomem_res_desc - Walks through iomem resources and calls func()
>    *			 with matching resource ranges.
> @@ -426,6 +442,26 @@ int walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start,
>   }
>   EXPORT_SYMBOL_GPL(walk_iomem_res_desc);
>   
> +#ifdef CONFIG_EFI_SOFT_RESERVE
> +struct resource soft_reserve_resource = {
> +	.name	= "Soft Reserved",
> +	.start	= 0,
> +	.end	= -1,
> +	.desc	= IORES_DESC_SOFT_RESERVED,
> +	.flags	= IORESOURCE_MEM,
> +};
> +EXPORT_SYMBOL_GPL(soft_reserve_resource);
> +
> +int walk_soft_reserve_res_desc(unsigned long desc, unsigned long flags,
> +			       u64 start, u64 end, void *arg,
> +			       int (*func)(struct resource *, void *))
> +{
> +	return walk_res_desc(&soft_reserve_resource, start, end, flags, desc,
> +			     arg, func);
> +}
> +EXPORT_SYMBOL_GPL(walk_soft_reserve_res_desc);
> +#endif
> +
>   /*
>    * This function calls the @func callback against all memory ranges of type
>    * System RAM which are marked as IORESOURCE_SYSTEM_RAM and IORESOUCE_BUSY.


