Return-Path: <linux-fsdevel+bounces-71213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03981CB9B66
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 21:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 472093008541
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 20:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2249030C61C;
	Fri, 12 Dec 2025 20:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tfL88dC9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011032.outbound.protection.outlook.com [40.107.208.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A6B309F1C;
	Fri, 12 Dec 2025 20:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765569609; cv=fail; b=DuNoww9TKobOaSPVXBXXhrCLhYTq8wlrE0SeJdiG9ZAUmRt9KX4TSHzMKMLPORapWspSLbIIqUdoWEWh9T+KUMivhyRaJXB5AUOzI3rmS9gLvQ5wQn9xbOi+jLib2WDpYzKTNDPrzv+0XZ3b4DH4+7kNzkuOTmqTtXlyKXu4yiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765569609; c=relaxed/simple;
	bh=F2QAwFqd2ehJC5xe5fwsFste4AEQKP9JLV1c6Ok0eCI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EVp5dGBMcwWVA6KjTpDLwaHnUTWnhhUwK3NT0wIfkHoHCt7aqXsRXzCRQMY7eR7vbuLRPyHbB5Upez3aAqFBj9yI9Q5+xheHQoSWlnNficjCXUeqvAEdX/gKndhUJTZJIHYN6+n6S+oR3HCSbSTg4Jk5zjc+uu+EQCcXxrUFSr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tfL88dC9; arc=fail smtp.client-ip=40.107.208.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bl+zN+QTOQoIGXBqg4Lmi9G6yPvYbL6mYiodErb/XwrSPi5XHhUCK9Cy9CmrRixXGGoqA+V1Mh1Pqs6R5BedTyUMDP5VqAwgUUMa0BlEMBjc7ei8xvuHO2veG+Dvc2CDBvC+su1tQNYz/5Y72xn29Po1dCocTZc0idtRjaTmFxtvblEoxKZUXcAMOAyzc5eZkZUNaWK5lNZiRgD57W8uVN4MRFyU/zM1jNXFXjCVgVKADtnLLHNMRf9EvRuc94u0MWNW+vsE2KzY11TwobN2OhyZCLT9HuiekCldFWsAIxOd//4c0dJRZ89hc9yWKiWeVLoT/iKqrUBf/6jIGz47tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFdqzLTJxeY+Q755IKnQxzCOuHOEH9RFvbxL57fhIFw=;
 b=dFiMaPeYSo6wwlr/sxXeWSOgFYs/WXLSvWO4smeJTPd+SLGAMWU2mcF9xE7Uibd6tPFIYslDYZwYxIKtVvnJzBxs4uK8Aq50DKhrucV/jcRLqdRbDA9cYvgFCQn89AgdqoiX7KH6M/sZAE7O9fQj/q5vhCpLDJFNfvA6TUF4i69M1INnzqZIPeuABcVVsOgvRD/rRrd0aos9qavM+Us+e7wxHQBTNeWEWQh+PoI757nGvNcS6M/sNQNcYCPtW07kRl4RNtpbC8TR8w1IARj6PZ9hh4pI145dDbFYubKSmzYKilEfi3Idj4cHh+nANwmRRmLHdbUQ2haxpg+a6KiVAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFdqzLTJxeY+Q755IKnQxzCOuHOEH9RFvbxL57fhIFw=;
 b=tfL88dC9rVjSnXTta0K/9/tvfkGYw48x5rgAc8/kTTllR+oOGYcFqOI834LNhqJIMfYwlClErwy1cLRngLhVDT5SP4XLskghK1UH4EAbq6R8yvPI4/BlEYEuLPGw93d35IGlUX27iCWsjwOGUz1Ln4c2/Bv+FR3xEZyg0ImWc8E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9714.namprd12.prod.outlook.com (2603:10b6:408:2a0::5)
 by SA1PR12MB8094.namprd12.prod.outlook.com (2603:10b6:806:336::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Fri, 12 Dec
 2025 20:00:03 +0000
Received: from LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::c18e:2d2:3255:7a8c]) by LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::c18e:2d2:3255:7a8c%4]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 20:00:03 +0000
Message-ID: <218ed5a6-d4c4-4bb0-b04e-18086d0df38a@amd.com>
Date: Fri, 12 Dec 2025 11:59:58 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/9] cxl/region: Add register_dax flag to defer DAX
 setup
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
 <20251120031925.87762-7-Smita.KoralahalliChannabasappa@amd.com>
 <6930d45fb836f_1981100b7@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
In-Reply-To: <6930d45fb836f_1981100b7@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::33) To LV8PR12MB9714.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9714:EE_|SA1PR12MB8094:EE_
X-MS-Office365-Filtering-Correlation-Id: a10c701f-133c-4fed-0179-08de39b90a11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N3JrU1RFQWxWOHhFRVZqQWl6ODB1VlF0clVmU3VKODFGSkVObUtockR2MDBC?=
 =?utf-8?B?Nm1pOEZoRC82UHVaRnNEZ1IzaCtmR2IrTm1kNEVMQk9HeUlmZnB1WmZxMWlh?=
 =?utf-8?B?VFBvSlZIRlRMSUNqZENoMHFNYUdHQXk1ZkFaWWNwTzQ3LzNPc3lPNDRaOGUx?=
 =?utf-8?B?NG5GMXJPU1JqR3lKTlFBT3RBOS95cllEUkR6MzA2dDIzdUJmNHdJMm9jTEda?=
 =?utf-8?B?SGhUcmp1dytsTlRZNDJRd3VxV1BwaURMZzIzTUFOWVczSEhqaVZpUDBjR0JS?=
 =?utf-8?B?ODlYNGk3d3lYVUNqaEtOeitWN2R5NldJdDFxZFU4T3dPN0pCR3poS1prRzZ5?=
 =?utf-8?B?Uk1SMlczN09GSVpMS282U1hpQTFuaHlMT3dzK3JHa3RTcEt0SDBtRVlUOFNO?=
 =?utf-8?B?L3Y5T2Q0UFRLNVp2K2hZN3J2NXk5SzRZZUt4VEhkeEVzUGhhdjRnZ25vbjBR?=
 =?utf-8?B?RUg3NHZsSmE0RkhhOWxQM3ZYVlU0bHJRZ2tXTGMvaEE5aHh4b2Q1TWZsVHRx?=
 =?utf-8?B?RWs0cnMvWWlEZGdaRmRPWnp1bnlNZGZUOVg0WG1vZmNZWHFqdWZRVE5XSEJv?=
 =?utf-8?B?bVU4aEN5Nk1GQ1lwZWRHK1dNdHBjUVh2RUpZeU5SeFFsNVZhN3E3S3NiYnQ1?=
 =?utf-8?B?ZnZUQUJMai9laWZhQm4vRFV4QTE3MUtYN2dUVXFQMjFUb09iSzIraVhEZFdY?=
 =?utf-8?B?eFRSUnJCNmhFRWUxd28vdFBuYWJEQUg0RkNxN21zNGw2aldSTGNPN3hIMWp4?=
 =?utf-8?B?YjBVSXpuRm4zSVFaVDJqNFhFTWRCdWViTzdmQzVuQmJac1NLYmJIUGI2amtN?=
 =?utf-8?B?cGd2OXlKQlJ5R005SEhtMWU2OGdPV1BPdkdEaUhNcmt3Q2Z4c3lNcVl5RlBS?=
 =?utf-8?B?MUNIOXBkbVliVkxiMkwrWkFCVlFHbkJ1S0lvN25ucE9DeWZaWlFXcXo0ZTYz?=
 =?utf-8?B?ZzdFdmNhSUNUWTRFVzlOamszM0NQeEJmdkpCM3dUb2tqMW5NTC9ibERnVk1k?=
 =?utf-8?B?Qld2ZzJUb1dUaE5zSUpDc3J1UkZ0NU5nbnBvcG9yUVFrVnZNTmFtZnVGcVJ5?=
 =?utf-8?B?NEdmKzY3NTcwZFNZNEdieVFIT0t4Q2J0b3VxenZLNzMyS2d0eFk4cld2d0Zs?=
 =?utf-8?B?RXBBUnlQVXNxclhxYTh6Z0JGWEJiUmtaWEhCSms0ZFU1MFhrZzBlNlo5Ymw1?=
 =?utf-8?B?bkwyai9PQ0g5dWt5Zk1hUWk0SVA4Vlc0YUIyRmhjUTBFanVFdjZVSGFXaXpB?=
 =?utf-8?B?N2xnbHdMQlQySURLUWNLbTFmc2J0S0hYV2hvcGlrQ3BMR2d4bG1SWGJ6bTY2?=
 =?utf-8?B?RnFyYkZ4dWl0ekVFalJzWXAvenpMSlNua0xrbjk3Z21jNjB6MGJENVJ1MTAw?=
 =?utf-8?B?QW9xYmp1R0VHTFpFVkY5RFhKaVdIVi83SzFLNDhSZU02Y1dlNU8xeDBDT3E0?=
 =?utf-8?B?a2xMQ0dpODFyVy9EM2dqZTFyUDhLalNKMnYwb2dLS0JvOEdqN3JoNWxwYUFi?=
 =?utf-8?B?ZGV6dXBvK1drS3ZBWXVyNC9wdmR4VDc5cm5jN0lIQUNURm5zZTJMN0xhVkti?=
 =?utf-8?B?UjkzWm9lb3ZhUDhWRUZEWGsrZVpPbHZUSXBxVFZHcjZFTG9GNUhWd3kxQnZ0?=
 =?utf-8?B?MFVSYnBCRGdsVDY5QXhkQUFFWW1kQ1NlOGRKNDAvUmpoc2duQldnbzZnT28z?=
 =?utf-8?B?YlVOcmp1eTNmTzZnYWtKT0F2NzBSckI3cEY0TlJXZHVRVWlOVUd1Z1BhVWJO?=
 =?utf-8?B?aUtWa1FqQVp2aWd5Rmg2Mm1uYTNNYUsvYnBPUyt3a1Z3dGpWKy93WHpRRnls?=
 =?utf-8?B?blA2SXBzUCtvano4RjBOdXdPc1NNTzZVNkxUOUVPakZ4dEQxNFo1L1BKMTlY?=
 =?utf-8?B?KzlnZFpyVi8vT0xkN2hobUc3K3Z4SUt5K3dRMXpHOXZUYXR6MFBmV2RBNjRx?=
 =?utf-8?Q?EKG7NIXACHvdxPTxgejKbemWWmXwbB7P?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qzd4WGdIaG9oOVJwRm9CTjJrQXZ0M3BVc1lHQ1FQM21WSloySmw4RVVVV3Ux?=
 =?utf-8?B?SmhPemsyZ1dUN2diMEZNSTZ5alBsRjh5bFFmekpZcjlVQ3Z2WGNRTUtIV25I?=
 =?utf-8?B?eWpQK0NCZGFrRjRRbERYd2FPWEpMbUxEQ2dwcmY4ZFVObm9Oc1dwa2FkYWNa?=
 =?utf-8?B?M3Rpa0ZlcURacjdDUndJZkVCUHh5QllsbEJVY2RUSUZNano1cDVHcGhvdUJt?=
 =?utf-8?B?eU1rSGZkVEducWxoV1FjQk9ZYUVlcU1rbXJxeEYwb3FTa3hLanVXc0dsOVJx?=
 =?utf-8?B?MnEySGlFRnZuVTlpUW5PeXR2Q3FOSTlyaDVab0g1MXk3UzdUMHNDWExhUDl4?=
 =?utf-8?B?WU8rRE5CQkUzaDdQb1ErOGM4QWplZy9KS2p5alhPaVZ1YndFbGNCRXRjMmxG?=
 =?utf-8?B?cVpLcmpBblNTeFY3aG5KTmxxdy9kZVZKd1JXVXJ5ZUxRdmNKQ2pUYTFsQzhp?=
 =?utf-8?B?VmNkbXhjSjRVVlNvUVdqVVRyU01aaHpQVFFFb21qU3NBenJhVkNJci8xd0l3?=
 =?utf-8?B?SWtscHZLNUQ3UmFtS3kxQVcvbGR0RDlxSnRRczBveWlHS3orYVFXSEwwQlA1?=
 =?utf-8?B?WlpRN1h6T3VKYjY5THVpQmpkVnYydlNjZEFuVW50a3ZsV1FKN2lMdHQ2SVZJ?=
 =?utf-8?B?Ukd0dnJweDF0T25tQXpXOGR6UXFOc0RFMUtmT0dBMnNpd09rUmZtcWhIWGZT?=
 =?utf-8?B?a2o4bjhqUnVlTCtTajRvSlh0MlIwVGcvcXl6M3JpR2ZHcEFSZUplN1VsRHBU?=
 =?utf-8?B?dWhKRzhuN1RPcGNDVDVlVlhuVkl0R0xPOWN5aERJZmRnRWwreC91SkJIaDht?=
 =?utf-8?B?ZmJ0VHE3R2Fzbm1rSVR4bElWYUpsV01iY09WaGpJdC9pUWNIU0FuV0RENzJu?=
 =?utf-8?B?aE9pRmw5VFZwQlE1QVQ3ZGZlS0hnUThQOUU3T3FLZU9lSGhOY00va3NmTDlF?=
 =?utf-8?B?OWdkZUk1SlVSNUJLWTR6dGVXUDhrNGFsekxKY3V6Y0MvSlk3K1NyNkxqWnVi?=
 =?utf-8?B?SVJhWVU5dUxOOEZFODA2ZmdES1B3c1ppb2FIWXFiekMyWGdwdWpOTFJQOXFs?=
 =?utf-8?B?THBXeGJEblQvbDBhU29kTXpER1Y4eXV5RCs1V2FDVG5ERTdSd00veSszaG8x?=
 =?utf-8?B?TS9CVjllTTdpbmlkSlc3MWZNY0lKY0h0MWZWdjJ5bGlCajdMY3BsU1k4OHJx?=
 =?utf-8?B?Sjd4RnVWNzVleTR0cTk5MHBCUnN0RTJyVTlncENHTnd4YjJoWC9uaHJZMVhX?=
 =?utf-8?B?VXZPSDN0cWc0NlFOL0tLVUdXM3ZnRDUxd0ZsaXE5MHVnTjRMdUtJd2VJYjd5?=
 =?utf-8?B?eEhhZjNRK0VQaXJhOTNtQ0l5alh0VFAvTHcyajdrMFBkdkhja0tROERpMXRp?=
 =?utf-8?B?RlNVVk9KWVFObGlTOEJoanIrMGRtYmRjR3NiT3dyUUhFTFJwNGJiK1MzUWNo?=
 =?utf-8?B?Z1dDSWRmNjNkdSs2S0dSVllWVDNJY0RzQWFYMTJlTGdPUDZnUm1xZzlxWG9T?=
 =?utf-8?B?cUNET3hoeVh3cisrVzJjb3pvRW5YdlY1SVNvSFRWWDVQMXJ6RjNZSnhnWWxL?=
 =?utf-8?B?cm1XK1JjUE4zZWhyMDE2UGgvMTgvakdhUmR5bmMrR0Y4cHNwcXJIOFRNWjdq?=
 =?utf-8?B?R3EvaHNVNTZNYXVRbnlvMC82RWZmUzBzN2lvd0d2QW4zc2lOckZFK25ubEo3?=
 =?utf-8?B?Z1AvTWNxYVB0OE1IT1BJeFVpS2VlbllROXNZanYrSEFWdUVYTWlMR096a0V0?=
 =?utf-8?B?U2RJZ0tJaTd3bFNKMlRhZ2hVc2V5YWVTcXlDTzZQa2FVa1FUNUpIamlRZ0hF?=
 =?utf-8?B?ekNGNXcyQmtCYWpJRjVreTNWWFdRNTloWXVBbmdNb3VOMnpMdFU1dVAxMWVq?=
 =?utf-8?B?U08xQTJHUEo5bW01azdiZjV3cXRZUnpIaVNvTVdVMDNkN3hXRlMyTmthR202?=
 =?utf-8?B?NkhNY3U4OGIrL3RIMkFoSHc2bnFOTElUa21XZkJqVG82ZUlUUmJJYlU1dnU5?=
 =?utf-8?B?NExsNmFoVnB3SjhqeHRmMW1SbjZXMUw0VGRneGMrekRPa1JEbGd3K2J4WmJZ?=
 =?utf-8?B?Yk54UUQvMmo0S2JWbEhqSzhNL3hrYkxKQXRrbk9IdXFscjZwUE53Y1ByKy9B?=
 =?utf-8?Q?0+hwLCtllwgHEkdLqN9H5+ImI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a10c701f-133c-4fed-0179-08de39b90a11
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 20:00:03.5179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G1YM2yill02i11EJO006oXBR0uGLnYuSgaEbTYo3kTO+KV7mwCEqF38+XSD+RBUEsyoRpp/K7dXIHnxUna2PzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8094

On 12/3/2025 4:22 PM, dan.j.williams@intel.com wrote:
> Smita Koralahalli wrote:
>> Stop creating cxl_dax during cxl_region_probe(). Early DAX registration
>> can online memory before ownership of Soft Reserved ranges is finalized.
>> This makes it difficult to tear down regions later when HMEM determines
>> that a region should not claim that range.
>>
>> Introduce a register_dax flag in struct cxl_region_params and gate DAX
>> registration on this flag. Leave probe time registration disabled for
>> regions discovered during early CXL enumeration; set the flag only for
>> regions created dynamically at runtime to preserve existing behaviour.
>>
>> This patch prepares the region code for later changes where cxl_dax
>> setup occurs from the HMEM path only after ownership arbitration
>> completes.
> 
> This seems backwards to me. The dax subsystem knows when it wants to
> move ahead with CXL or not, dax_cxl_mode is that indicator. So, just
> share that variable with drivers/dax/cxl.c, arrange for
> cxl_dax_region_probe() to fail while waiting for initial CXL probing to
> succeed.
> 
> Once that point is reached move dax_cxl_mode to DAX_CXL_MODE_DROP, which
> means drop the hmem alias, and go with the real-deal CXL region. Rescan
> the dax-bus to retry cxl_dax_region_probe(). No need to bother 'struct
> cxl_region' with a 'dax' flag, it just registers per normal and lets the
> dax-subsystem handle accepting / rejecting.
> 
> Now, we do need a mechanism from dax-to-cxl to trigger region removal in
> the DAX_CXL_MODE_REGISTER case (proceed with the hmem registration), but
> that is separate from blocking the attachment of dax to CXL regions.
> Keep all that complexity local to dax.

Okay. To make sure I'm aligned with your suggestion.

It should be something like below in cxl_dax_region_probe():

switch (dax_cxl_mode) {
case DAX_CXL_MODE_DEFER:
	return -EPROBE_DEFER;
case DAX_CXL_MODE_REGISTER:
	return -ENODEV;
case DAX_CXL_MODE_DROP:
default:
	break;
}

Then in the HMEM path, if the SR span is fully covered I will switch to
DAX_CXL_MODE_DROP and trigger a rescan.

Something like:

if (cxl_regions_fully_map(res->start, res->end)) {
	dax_cxl_mode = DAX_CXL_MODE_DROP;
	bus_rescan_devices(&cxl_bus_type);
} else {
	dax_cxl_mode = DAX_CXL_MODE_REGISTER;
	cxl_region_teardown(res->start, res->end);
}

hmem_register_device(host, target_nid, res);

cxl_regions_fully_map() will include changes as suggested in Patch 5.

Thanks
Smita


