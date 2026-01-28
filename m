Return-Path: <linux-fsdevel+bounces-75767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFwbKRM/emlB4wEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:53:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C742A6526
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4732A309F1DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 16:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0456A30FC12;
	Wed, 28 Jan 2026 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0HUvKH9v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013007.outbound.protection.outlook.com [40.93.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3D129D288;
	Wed, 28 Jan 2026 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769617213; cv=fail; b=lCFL9jiDMVboyhVmk9gdqttW1p0Mt6gInoBjXKOFB3rDgqK5VRheJiilkwuJ20+ixhcaXZpSxHGUM3FAu6hyK1y66bUFszcIV84rAPjrh5gaijpgrFFH2Js0oTpDJlF0e0IpGiAnZ3NGvo4tl2SUoYmkp1G+6BUaUoKIf0BjNf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769617213; c=relaxed/simple;
	bh=OKjla90jWBIe+dN6SVkiBXpkEWH4eRDQVDol7oJOr8Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Nt03zaTVsHjgN2NB3WJal/voS2fwBcP/8mUVfohqc7ebTotsbPwLZA0KtqkkOpx6fXrJOIZClmim0MPGoRFktwHO6FDyintcniY2adssDEn6V9oaEYBLJhgLiMF0s3MR4rJFL96NNcsgkQX2aT/eUIUXJci+qweXSS6uUr8n84U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0HUvKH9v; arc=fail smtp.client-ip=40.93.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWxkTFcFmT14vLSvYRLIFpH/ZTWYtGvRmqYBXEEdI9AVWud2M7/WzGCAEJhqNtn8V82XO4VJ7rD4Z60cY2wnN/7mEElU2/FzxYp36v15+F1PVdoKzPkTxKdwIZQyuy/ZGMaLWDQeDgnol88o2gCqOd0XzitN3ZRLQjCskhs1tRQ7Kh4PvyqM84W4wbpSMIa8WBrOdCg4dRe92xEe3mwyQAaU8YabZU5uLby5tvdWQGJFlzU9Ae5fGCf3/wlEMwuaarMVeCG3uNwKchtHFokSn/VrtVfPU3eUFDW1g449S445lyNi55U9GbJzs/mNZ38syWVfUc7PDmWBkiP+DNzezQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCQO/CemG74EdWxcR5e7AbTsM0x56Y8eU4bGDGtMNh8=;
 b=dA/PTjm8rdNo5UytlHcpuPPRkatzre+f+m5V+Uwgw13cRHvN6l3wWYFsJAoFmRNVSnk1/Rsab9pkno2/TOR6eQaabX3h8b7L5UCzQMg9yvUybbX9BtgL/c+jlz8aU7C/H/d3fh6Hr2IBPcWFxcmM146x5XCBA2O4YE0dUM7WYSdu/mVTBDOfyAMgG3RtYVg5I7QsQurjvLOwJm4oJ4rL0glh7NbPnmr2wk3nv4vAw/dVrWTMm7G92gLon98YUVP/ObUE8KneDOj92eJR4Id/0Pv5vTUlrXRS+Xlb1u70FL551kFRWyPWOTZ4bJy3k84IXkiBqdsW9wlTNl8U7EhrHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCQO/CemG74EdWxcR5e7AbTsM0x56Y8eU4bGDGtMNh8=;
 b=0HUvKH9vaKIp3WmIng+gxP/A1sEAbm5czyNHCukNzJ3KtdtB2ff0yl31Xt4qaCJpFTX6DePkr2W+HrxZdlN0LjWtw5fhA3eoYvBldu81rhaCs/nLUcyN4HmThXYEBYiJj7P+qQOtHrkwFgavekSznI2Id5Hi8W8YR83lNfR4n9U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CYYPR12MB8870.namprd12.prod.outlook.com (2603:10b6:930:bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 16:20:08 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%4]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 16:20:07 +0000
Message-ID: <5d59b03d-12be-4bc5-b7e3-055486fc0866@amd.com>
Date: Wed, 28 Jan 2026 16:19:59 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] dax/hmem, cxl: Defer and resolve ownership of Soft
 Reserved memory ranges
Content-Language: en-US
To: dan.j.williams@intel.com,
 "Koralahalli Channabasappa, Smita" <skoralah@amd.com>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Matthew Wilcox <willy@infradead.org>,
 Jan Kara <jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Jeff Johnson
 <jeff.johnson@oss.qualcomm.com>, Ying Huang <huang.ying.caritas@gmail.com>,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nathan Fontenot <nathan.fontenot@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>,
 Zhijian Li <lizhijian@fujitsu.com>, Borislav Petkov <bp@alien8.de>,
 Tomasz Wolski <tomasz.wolski@fujitsu.com>
References: <20260122045543.218194-1-Smita.KoralahalliChannabasappa@amd.com>
 <20260122045543.218194-7-Smita.KoralahalliChannabasappa@amd.com>
 <e38625c5-16fd-4fa2-bec0-6773d91fd2b4@amd.com>
 <84d0ede7-b39d-4a41-b2b6-8183d9ccbb9e@amd.com>
 <6977fe94d8ee_309510033@dwillia2-mobl4.notmuch>
 <f4bdf04d-7481-4282-b9da-ce5fcf911af9@amd.com>
 <69794d438629e_1d33100f3@dwillia2-mobl4.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <69794d438629e_1d33100f3@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P265CA0006.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::17) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CYYPR12MB8870:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aa5f1e7-1bc8-4930-641b-08de5e891a22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qk5DeVJtMWFlVlgxcmFjSVRlb3g5K2RHK1h2d2t5czlRWVgvZ2NlZW1GaVFL?=
 =?utf-8?B?QXgvODBMSDZ2Zm5vWldHN2J6UTZSNVRFclMxcnh0V0VsamFrQnRkZGF1VTRo?=
 =?utf-8?B?ZVNxWmpENXJuWVJ0c1JnR1NVVklGSXRrYmNQeWFqZGR0UVNvdndJQllhVmVJ?=
 =?utf-8?B?VnprQmxQbHpXeS9nOTgxaitnazhhQVJqcm03dXdOREdxYzl0YjQ0VTRBNTVq?=
 =?utf-8?B?QmFWS0k5TnB4L0VWY204SjcxbnVjWStIQytBdHZhK3dqNnNBemlnanh5OWll?=
 =?utf-8?B?T0VsQzM2aGE3MnZzNHEwYVNOZDUwRlZJUndJMDRKQndoMkIyTDdVQ05rVUtU?=
 =?utf-8?B?ZVMzaVZOQ3hEa21LMlFLSmpIc2UrTlF4VFVqQTQySlRmbGdra3djWTkzYUhZ?=
 =?utf-8?B?MzgzSDRqeDUxeE1jWlRjY1B5YTFmNzUxeEdYL2ZNNXI0ejFMVXVKNXY2WW9C?=
 =?utf-8?B?YlhBbTM1SjBwYitFSDBuN3Q1b0xCRUpnRWtiRWZNSnVMZ0xhL2R3YTg5ODdm?=
 =?utf-8?B?blY1SnVJZ1VENlA4N293ZHlyZC82R2Jwby9KNERaakl2QnlucGRpNkNNOWdw?=
 =?utf-8?B?OHZGazF6NDJ6c1p2QUhrTDNZWmx5QjA5OXNEWXJDOUtjdEhxaTBnMkhZcTFZ?=
 =?utf-8?B?YUVSSDcxdklRU1Nod2hkdjJVKzM4eTRYOUQ1ckpUR2FaM3E5bmFBWEJldDN4?=
 =?utf-8?B?blZ6Z0RteUxuRW00bmkvRWZueXNVUzlGUzltSlFwcStDVWM1aU9uM0NPNkl3?=
 =?utf-8?B?bDRhVFRLRU9aQ2twSGFQUEQ3RDVjMjh0SzZPQ0tjeGJjcFdaOERxR2Voc0dT?=
 =?utf-8?B?eEd0ZzUvNGhXYVppSmFsdmwzdVU4WHJZY04zSmVsOXRZZVhLMFJicnQwZmM5?=
 =?utf-8?B?K2dlcU5qbFNCOEJpRDNJQllhOVRraDZnNzFzejZhNFVMaEdBRUpyNFowUGlv?=
 =?utf-8?B?ajQ4SHhRZUI0MFQ2dEF1VDlXWCt4TDhvZVIwUWlVWmFBQlFMZWJDMmMzVlBo?=
 =?utf-8?B?akI2N2hmVDMrVlBXelp1aGJIRytmcGN4VHNmRmh1RTgyVHJSUWZFaVQxNXZp?=
 =?utf-8?B?NUErUk1WNHFTYmU2cWNlNHozS3VmRE1FbFNaSFBSOUlYb1RhLzZjc2xxZngw?=
 =?utf-8?B?cW01bjNVc2Rva1dGZnZrRHBSeFlRK21WTS9lek51TDFsVDdWTElaT0pZUU8w?=
 =?utf-8?B?VjNIYmJubjVBbEVUTWRleHg4Uk16NG1oQVp2KzgzdENmTm8zR3FZQ2k1czB3?=
 =?utf-8?B?aTNnNHIySDFGMmpObUdEYnhtZU1GbnI0TkYzbk1OeUVKSmJZc1VJVnlqQjBq?=
 =?utf-8?B?bDAzS2tsM1E0dU1qZEVnT1kraXE1OUdtWFZiRlhLR0VpVFM4S2RUSG5xbnd0?=
 =?utf-8?B?Z1B2cm51SFpwUWk0a0lSajA2V25GUUdVdXJHUVJNbnZKT2w4WVlXWmthbVZP?=
 =?utf-8?B?MWVsWk1CWFZaQjBHL2Y4MjdMLzRqRzhhUmh3SXBRQkV2cmNUc29wK1lqY1J1?=
 =?utf-8?B?SnIxRFIwSlJZTDRYVGVIUkNpZklZS0lveU16ZXFnNy93ZndYU1FoMTRaUjVN?=
 =?utf-8?B?UGpNRkVPYWpFcHpHUkM3cm5jVmN3SlpMS2JwTE5PVFdjREJHR3JZMEovZVAy?=
 =?utf-8?B?elJxRlh4MkdkMHE4Ly80S04vNjI5cUkzcit2b3Z1VkN5QkhscDdJbFJ0endh?=
 =?utf-8?B?SGxnelFYejMxazB3OW9EankyRTFaZEEyUS9Hc0FuSUNZblZLSXBQaU8rblk3?=
 =?utf-8?B?aWVvRk9mYy84QUs4U2FhSGVWcEdJZ29VQWJkWTc4dFBmaDAwZW4zMXU0N2Q4?=
 =?utf-8?B?N0x6aFpFUVJhaVNkNHdMbkJET1NFcXVKQ1JRcVVmVExNVTBDSklFTG43UVdm?=
 =?utf-8?B?QzJDeldKcUM0RzZab1RWT1lJY1hZTVJoRDF6dWRJSC8xUnM5b0JvSWtOQnd3?=
 =?utf-8?B?VVM1WXdvbDRacGlSdVZCM2hqMVBXV1h4K3V1TlZRMmxyRzhjb3d0L3RCb3Fw?=
 =?utf-8?B?UDlWOWJQUllqUXh2NWlmRVdUeGRka2k4MURqWVJyRDM0eXRXL1JMUklTWGNC?=
 =?utf-8?B?SVRyTTZZVW5PU2dobG9tMWJ2TXdaR2pIVFFRYkVJajhiek45NDRabGo5UnA1?=
 =?utf-8?Q?lSDA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEp5M28xUnduaXM0U2xBZ3VFMWZVMmwyQk5PWGNzMlZtMGg3YnEvZGo5aGM0?=
 =?utf-8?B?Tkx2Y0RRS28yTTBvak4rTTNTZ3ovTlZpc3huUStTOVRRQzU4dkVBMGN4UGY0?=
 =?utf-8?B?b3c2TUFBbnQwMW9EVzRmV0NqelEyRk9oTmlBWHFoY0xrbXhPVkhaT21uTUZy?=
 =?utf-8?B?M1hGRWF2SHlGbG9nNFBrbTk1dXA1RzAyeWVHbE9HbUQwaHkrUG5PR2dBRHNU?=
 =?utf-8?B?Y0tWRjZrMGc0akhkMWtEU1dvNzdua0tuYm9PMzNEQ2xTQUl1RDkwczlaUUxO?=
 =?utf-8?B?VTJhcWg4RHNITlVlMVpRR2lkODRDbEtNT3F6NUZGSVNpRGZObGY3VnlkbHFo?=
 =?utf-8?B?TGFlaU1HOGpKY3I0MkxFR3NrdXAwUTRXRG44VW9PVzV1azlseTIrWHhpcVhO?=
 =?utf-8?B?dzFLNXNsNm5KUjFOaGJjZDlGcFJzaVhlWm9lZWVuV3BsL2dWay9OSVBKVWx2?=
 =?utf-8?B?MVllK1hJMnNUT0JVSTBXSEM4SytnRk84NjZwL3N2ODZReDAvTjMyRm1Eb0kr?=
 =?utf-8?B?QjIxekdyTXhldXoveTByU0gvdEtuQ29YaHB4Y0I3RGJsSmJ6YlM1YUJUeGpE?=
 =?utf-8?B?TXpnRW1VaTJtbGhRMUJobmdlT1gzU01aOUpyYldrcExLZ1JuMm9QTkZicGRE?=
 =?utf-8?B?N2d1YlMrNTFxaGJ2UU5VQVUydUw0OElZTVFnVmZSbWIrZVA5aGk5Y1ZDVWVJ?=
 =?utf-8?B?dVA1TW1QczYvNUF2SzhtNHJGU2IrbG1sZHpId0tOekVSTXVxNldvd2hBNU1N?=
 =?utf-8?B?NjJIQ2xZNE1DaEZuZTU2dTRXVXh0RGZaZElJSlBSUk1QaE5rL3o3TjhTZy8w?=
 =?utf-8?B?Q0ZYQnVONlhNZ291QXFTQzNaQk1Zelh1a1AvdHc3MU9EQkExKzNOMWRNMk1x?=
 =?utf-8?B?YkxrSDlaTjdNQnhreEV6ck1SbjRWdkRHdzZKaUZ6QmNILzBLZk9DZnZlSW44?=
 =?utf-8?B?dVJZYXRnTWRKUjVwRmd0dCtvQkxJWkNaVDB0ODdFT3AwNjNUcGFTTWw5dUFU?=
 =?utf-8?B?VWtVa01BcmZVSWRxcFdwQlBhd3lQc016eWhHVjRhb20wSzVQanpadm5PMlk1?=
 =?utf-8?B?eEVJWnhMc0pmdzZaTGlvYlFGVHB2d2VYbkgvZ3RsZWRHdzRLT0hpWDdmMFJF?=
 =?utf-8?B?RS9jK25zbDdBalJUbGc2OHorU1lWVjhCWVU3d1NaanFDSFFQeTBtTEdtRzcv?=
 =?utf-8?B?aFpLMWtUZHBpS28zSk1jOTdoeWxSWVlrTm1tbENGZ09uNGJncnpRR0dHNlkv?=
 =?utf-8?B?VnQyc25nRVFiSFVrdHhOOEJXTForc09kYXZmUDhwcEREaHp0dGpQWEhjMDJF?=
 =?utf-8?B?dWpvbFREL0ZnUnJiNHRtaVVXdXQzWk0yeHBUR1NtWDFvQmlabmE1QVFaVW50?=
 =?utf-8?B?UkxYOUh0R3hweGFwV1MvdmZXR0F4VXJJb29BeGZmOEJFSVFhMjJLOHVRRWZE?=
 =?utf-8?B?K2EyS0hKbG1nZjRBZ21CRW0za2NHVm1qOHc5Ykh2Q0g0OXRwNHF2dXAwVVN2?=
 =?utf-8?B?ZVNVcFgyVDJqb1ZmWGZIQzJuU1d4ZTFRekFrQWdkNHluNFZ0RXU2VTNIZER5?=
 =?utf-8?B?bTRBT3BSRFpBelZyVkR5V1gwL1VaWi9KQVFNR1JhdUZKL3c1SHMxR2F0S3Nm?=
 =?utf-8?B?OWZjMVZFV2lWcmdZTnZZY3ZxZ3hlWHlwK1NSeW5KTVlGL29XSFBLbGdtcHFM?=
 =?utf-8?B?SG1MNGdYZ2ZEZXdzZkRlN0N4dytBaFlqYWgyVlhLZ0Q1ZHdmQ1lySUZ2alRZ?=
 =?utf-8?B?UEF3MHhBN3dUckNlZHVMMWJjNVBzdjhPQ1NFczB3aUVERWVyYTVXZ29QaU00?=
 =?utf-8?B?czFQbHNKNDhncytkci9RcXY1Q2ZsSW9HZVluSjhTRElQNlMyaWpnaTJleXNB?=
 =?utf-8?B?QUJiUEkrVjhYMlgvTGdJUHl2T24yTHhyVkJCRVUxZ29Lc0tWK1RhOEZUR2RE?=
 =?utf-8?B?WXIxR0JXdjBKeVhzOXJkWmdhUWloV0Q1c1RjQk9BV3BSUC9FV0VRRGJtZlhP?=
 =?utf-8?B?SzI2ZVZlQy8yR2JiYTVqWStsZG95Vkw4VHNqSEM3UmRxdVFnRnlvdzZoTXM0?=
 =?utf-8?B?SmNOdkNGSmQzWnF4UElCcStaM2lRNUd1YjdoWGt4KzEzSjhqYXdRY044Vmxq?=
 =?utf-8?B?RkRRVy9HcTRXUm5WbVBNY0MrOXFzeDVzSkdaN2tTbityd0VKZDJ6dXJva2pM?=
 =?utf-8?B?VDVoRW9INFJIeGt5aTZhY3pUSnQ3N1FhQ1hyYXljN29BZlM4Vitla2xyazg5?=
 =?utf-8?B?L2c2LzZqRVFvZ2JBempzMlFJOUE2S2JDUDdISUNOV1JUamRZVWx0STdPV2Jr?=
 =?utf-8?B?SVlBTjlIcnJuOE8xeXZ6ZlNmV2lTYWg2Zlozb0FHc0M3NVEvNm9EQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa5f1e7-1bc8-4930-641b-08de5e891a22
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 16:20:07.7615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MWDdFRx/z6USSdXGKcJNI2BptasWljSMZJjZlOJlubkyiHK1QeoHaXFA7gTVYznEsj1Vp1/qLPDm4v6WesrIHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8870
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[34];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75767-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alucerop@amd.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0C742A6526
X-Rspamd-Action: no action


On 1/27/26 23:41, dan.j.williams@intel.com wrote:
> Alejandro Lucero Palau wrote:
> [..]
>> I will take a look at this presentation, but I think there could be
>> another option where accelerators information is obtained during pci
>> enumeration by the kernel and using this information by this
>> functionality skipping those ranges allocated to them. Forcing them to
>> be compiled with the kernel would go against what distributions
>> currently and widely do with initramfs. Not sure if some current "early"
>> stubs could be used for this though but the information needs to be
>> recollected before this code does the checks.
> The simple path is "do not use EFI_MEMORY_SP for accelerator memory".


Sure. That is what I hope our device will end up having ... since 
neither hmem nor dax is an option for us.


> However, if the accelerator wants to publish memory as EFI_MEMORY_SP
> then it needs to coordinate with the kernel's default behavior somehow.


I think some Type2 drivers could be happy with dax and therefore using 
EFI_MEMORY_SP, so yes, that is what I meant: there is another option 
instead of forcing drivers to be present at the time of this decision. 
If someone reading is working on Type2 drivers and see this 
suitable/required, please tell. I'll be interested in doing it or helping.


> That means expanding the list of drivers that dax_hmem needs to await
> before it can make a determination, or teaching dax_hmem to look for a
> secondary indication that it should never fall back to the default
> behavior.


I think waiting could be problematic as some Type2 drivers could not be 
automatically load. It looks like if a CXL region is not backing the 
Type2 CXL.mem completely should not impact dax devices and cxl regions 
maybe being used at Type2 driver probe. Would a warning be enough?


>
> Talk to your AMD peers Paul and Rajneesh about their needs. I took it on
> faith that the use case was required.


After reading that presentation, I think this is a different subject. 
Assuming case 1 there is what you have in mind, and if I understand it 
properly, that could be useful for companies owning the full platform, 
but not sure adding a specific acpi driver per device makes sense for 
less-powerful vendors. Anyway, I will talk with them as the memory 
allocation part which seems to be one thing to do by those acpi drivers 
is interesting.


Thank you


