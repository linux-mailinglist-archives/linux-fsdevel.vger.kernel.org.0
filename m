Return-Path: <linux-fsdevel+bounces-75906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aA9AFjnPe2mdIgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 22:20:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC89B48E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 22:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED73E301A3BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 21:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58543596E4;
	Thu, 29 Jan 2026 21:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pwVRwkw+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011053.outbound.protection.outlook.com [52.101.52.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABA72C08D1;
	Thu, 29 Jan 2026 21:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769721646; cv=fail; b=u4N9IBAmM3R1u30HWzNhd37cinS8Y7v3VWqbyd4zbZACQR8Md4l/0yhKRqihIomtJTAITjy2ICyIAYTp1JXuH10VxYEawCPp6l6KL+nhXfP8zGT9D/HaMZUYPzM8RmAng49JsDwZL8OxXmYBDhs/9gWIC/3pH/JmdjoVa/xr5X4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769721646; c=relaxed/simple;
	bh=Jt1/KA/Lso6C6okFm2OiIigcuYGYEe9S2NJ1yzxx3I0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jl0bz+1Q2EXWQXAfWq00/7rMfbXATNW8WPorTUHrFjg4AH23GfxtCaVb34i1TnQAo6p/0mX3gmfo555uduzfdFLCi2tfVHrs+4totak2eD7/kc1nY1TTE+vIX8jPE0ZLdOAefB/vOAwGvZz6nttO+ZTqZi7US004MY/dP/Q+uio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pwVRwkw+; arc=fail smtp.client-ip=52.101.52.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uegHeLHudJjRai9hrrjzwfoMidJsLPFE/g/HIvp0lUiaQL7uQCJM3kYFTXdUVbjBrbxXQKCFdRzNWCAkkgq4lFxOhA+DhqpnYBJRuYs3aQYMBYoPrmHi7vlnFbJ6OdseF/aU2byNCYEuXqw1JQmRAW+6QcfYbFcZlTHWW5YcYjdg3y3TeH0AbQLDMljByBGSXsV26+nk/+S3ZbZK8lof+DUqtOqK3aMhGe++mvKk+uwDzofB/QY2pn27CX2ZhHXnSsLnD8QHbqb8w62iwSM/N0jyxvqfGXM5I3cdhxQqwz6fy8raC7XiHKAxKc34rIisvicALWKS4DlP4qQDu/mH7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZNS/3lNVpunP88ENs7j7KMDTh4XEuBjlzwIScCZFZA=;
 b=tjvmj5bQT6huaslqnPIDVVeyYPFpNzyd66h66MBamlNH0ahNb7zrDOo/KsHvd5it2cfG6332V4h2hvZKk44QPL6RtjeRLQ68KBBTt3qN652pdxHfD6KS7okQkHyr09UIgoqaeBdKGGBdcQJgDTkKlhGrW+3lT2s8LGhael8GBaMzHvR0L9aJ6EWJlFbIC8gN7mPAnJBFvRKFd49m2YjGtCPP1XHeCvBP9L8U5i3BOCxvdaHRKnY2L0XJdu7TZ6n6yFVXlowKv/eb0HQb1NZKZmB3pzSy59Nlm6UdauQhd045Ggtti6oytnAvxRMeWxQwzPthxpeZj5jPl/Z66FVAew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZNS/3lNVpunP88ENs7j7KMDTh4XEuBjlzwIScCZFZA=;
 b=pwVRwkw+3cBWgutP1I97g849Dmfjm5pdOQYP1sfHsCVi5gGL8pCDTpG60HKvhyGxaeYfPhuZcFb6yPYFo1PXxctmt/pXHz8QSThJhC+8nIQGFiKWhY/Je1RGJPPmLMpZ385QCH8hn07npQjZYHLmiZrd1cyPKMa73XhOYwNMm3o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9714.namprd12.prod.outlook.com (2603:10b6:408:2a0::5)
 by CH3PR12MB8511.namprd12.prod.outlook.com (2603:10b6:610:15c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Thu, 29 Jan
 2026 21:20:40 +0000
Received: from LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::8c9f:3a5b:974b:99c6]) by LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::8c9f:3a5b:974b:99c6%6]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 21:20:40 +0000
Message-ID: <b137dd39-dcf6-4203-adab-8c9ee2b3e6ef@amd.com>
Date: Thu, 29 Jan 2026 13:20:36 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] dax/hmem, cxl: Defer and resolve ownership of Soft
 Reserved memory ranges
To: dan.j.williams@intel.com,
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
 <697a9d46b147e_309510027@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
In-Reply-To: <697a9d46b147e_309510027@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::15) To LV8PR12MB9714.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9714:EE_|CH3PR12MB8511:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a781872-6735-432a-36a6-08de5f7c40f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3FTUjdnc1JHWFN4Y05CbHcwdVpwRGM1N1hzWWJldnB0aXcyYUM4cjBwVmlW?=
 =?utf-8?B?UWpkYUFHQkJ4OUZoN0NUNXFXZGRYdHNtT0VoZlhtRXVheGFKSlRRSytyN1FC?=
 =?utf-8?B?ZnZRb1ZLSjlmTVBOWkJtcEN0dFlRd2JYc1g4bHEyQ2NnNTd5b3ZVZWhxZWRm?=
 =?utf-8?B?bkdUbFgvc3ZYeFdIY1Fud1h1eGI2ajJ1RFkwcm91SWVrc2JlbDZZTzBvemo2?=
 =?utf-8?B?ZmpKRld3dFF3VEZYRWNRVmpMV2VIam82ZmM4b1lYN1grbmJrb245dmY4S0c5?=
 =?utf-8?B?NnY5UnlVRjRubUFVRWdKNmlaWUdxbDA0Y2RNZVgwMjFOWVZSeE1OaGVJdVNm?=
 =?utf-8?B?ZXBwdy9Yc3RoSnNWNFFDTTNwTi9xWlhrelJBYW9TZjFZVlQ5NHhLYUFkUU1U?=
 =?utf-8?B?UlFUZ3JDMnlsc0FKWmQ4eG9GVDVBT1pOZENraTE4SWM5a1ordFNENTFVcUh6?=
 =?utf-8?B?RFJ0Ylk2ZmxwNlRLbytPOEY0cGJrNlBHd01oQlZpVEdEV1E1Z1lDUUV2TGo0?=
 =?utf-8?B?dWdJUHhrRzVSVjBlZWdvMlA0NFlOWmhpcDFmdUZlQjNwd2daY0FwQ2dva05y?=
 =?utf-8?B?SFE0elZqUE80cHB3SGtXbmVzOGFlRVZnTDFZTEdiT2NxOGhjNFl2ZGI5Vy9t?=
 =?utf-8?B?ZUNEUFZPaE9uSitqZmZSZGZKWm81aHh1Y25FYmJBa2FUZll3Uk1jdUJndHV2?=
 =?utf-8?B?Q3N3NWpDNXYyeUtSY2plYXpFcEVuYlFyVlFTZmJBcFl3Yi9OSFlUSk5QQURG?=
 =?utf-8?B?dG40TFljZXR6WktteUVjY1l5NHhYWGJnYmZpR04rWlp5R1crM3JkdzQwdlc1?=
 =?utf-8?B?RTB2ZWtxODExaXN1dzhTRTVSV1VCb0xrVkRsUFByaU41MjBqQ1YydUMwMitk?=
 =?utf-8?B?elBmQTJ6cGhCbkpaTWVLS0xDWXUzU21laXRmUGVhNWc4dDIyRjZOWGxJdkQv?=
 =?utf-8?B?KzRQeDl6M3RDcitQVExLSkRENWt4WFJqbWVRS1BEMFd3SEl1dUVlWnZrYzVX?=
 =?utf-8?B?d0dDeU1RMmVrc3NEZ0VkaWhjbzNrSjY5a3laV3pXeml4djVudTRIeHJUbW5i?=
 =?utf-8?B?dDhpUzVUc1VyRHFFdmZKSmU5ay9xM29IcDhya1BOYTgrbldVeTI4akVEYno3?=
 =?utf-8?B?djNYMHd4Wk9Yb3ZqSk1Ed01QbU1QWXR6S3Q4MXRxaU1Tc3kxYW9ZazF5VTRW?=
 =?utf-8?B?MGRlcnJhcUJFMVo1UmNLdkJTRHNXb0trdlhpb2dOWXByR3hZalFKKzF1cFRD?=
 =?utf-8?B?cEIwelBWWlJCMmpVbWkvNTJMT0JUaFhPa2pPK3NUYVJoSVIwci9WYXdPZkh4?=
 =?utf-8?B?VVBXV1Vtd1FZazQxOTAzMStQMUhYd1VVOTZtS1BiRE1WN295VkpuNnhLTXgw?=
 =?utf-8?B?SGcxWWdwMlBMRjYya0dhNW9OUFN0czF1R09ZdDh2VzJUbU1pMHpyRGc3TU1k?=
 =?utf-8?B?QlJQa1d3QUx2dk4ycWZ2bElBNUhsUUROaTduSkRQenR1bVVLT2xhUDFVT3Z2?=
 =?utf-8?B?bnpsWElvMEttYlBpU1lORGtUTjJqMWlzMXlOa25lN21LckcvKytIS0hNZDF0?=
 =?utf-8?B?TkNPZ0NrdHNwTzdaaDlnZUlyVkVoYXh3dng2aS9ZT1pQcmpkNnpXRmh1cVVO?=
 =?utf-8?B?Nno2YTNCcWN1Y2llTThvdnBvYzBkdGl5cUdiaGRKOWNGQU1rUWlid1IyOTdz?=
 =?utf-8?B?c0h6UHpXNmllaDdQSWJaT2pMYUNPU0tXUi9idkgxY21jQlNmdTQzZUc4Ulp2?=
 =?utf-8?B?aEo4dzlueXA4RUF4YmVScThqSEhDOFI2d254NnJBTzF4YmJZMU1sVU41a1Nx?=
 =?utf-8?B?Q084S3d5dlhnQ1dMNUxSc2NITERWeFFmRGVYNjd0RFExalhzQ212RW1jVHY0?=
 =?utf-8?B?RU9iN1ZadHZkbkh0b3dRVGpPdzBhNDJLaEhrdTJzWFdBSDBvMTJxcWZnalN1?=
 =?utf-8?B?QytlK0dHdHVJa1FKVXQxZktmSmUrVVZLUGNUWnppbTcrOUVoQ3d2eGdRVW1M?=
 =?utf-8?B?MnI3UmNucmpGeE91cytEMFBKTWtMVnNLRVdMeGx3ZXR6b3E4LzZUbEJKclhi?=
 =?utf-8?B?SklmbHJ1WSt1OXFMT1JPTGthTXRqOU56VVpNVWNlRG9wRzhIR3lqeHVFbFJZ?=
 =?utf-8?Q?GrhI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGd0a1N6ZkxZSFliZFp6YzJOWThBMXVBZTFCd3U0NVlFeFJkS2IxTnNXbHBm?=
 =?utf-8?B?c1Q1MjZCWTdJenJMakxCTmRjanZrWGZqTHVNNkpvYzg5TTRzc09FNVQxd0xT?=
 =?utf-8?B?N3ZGbzNwZi9jbGptUVdMOEVUdzVjRFllT0dIZ0dYcGF0MzhjeFN4ekpCL01p?=
 =?utf-8?B?cUgxY0pqRUYrcHdIUFJOazVRSUpIWGRYV3B5cEtmZ29pRnJ1aEs2Yk54bXlr?=
 =?utf-8?B?M094SnlkTWZmVHJaYlFpVXhodHRvK2M0OFVuQnRNd3JNYUtSZU1wWnJnQUVP?=
 =?utf-8?B?K0g4VlI2OWNoNk5VUktTUzJQdWxsRlVFeGNUUTh0YVZPUExmdTlIQjhXdzly?=
 =?utf-8?B?Tm5Oa3YzSVdkZHB1OWpMOER3Q0RXWnJXMlQzUGxMcDZHM2lHdFFPTWpnOVlH?=
 =?utf-8?B?M3hEQkw0UzJFcXNjNVVCSmdMT21SMVVFUVpuODZkL056ZXptaWx1M0taRmlF?=
 =?utf-8?B?emhhcktML2J0K0hPakc1TmtpSVpYN2NRTGFIYVY3eHFhOEk3aGY5V0Zac2NL?=
 =?utf-8?B?dnNFdkpUVTh4YzNWMXBUL1pRZmw0UUlucjFiMFhSN3RzcUpEenp3MlJlM3F3?=
 =?utf-8?B?R1Q2ajkxRkcrL0lUVmRQTXdSaTg1MThKWDVwN2JKWktGanI0bnpiRzRjanVY?=
 =?utf-8?B?a3NQdHRyWDBFUzc2RkZ2d2FPbjNLSVdmd05LUTc2YVNkNjdqZUZRamhBbStV?=
 =?utf-8?B?UUJFcFZTK1AvK3NHTUpJV1dDemVxZ2xIZGdkblJxSkVFeHlFQjZNbHNQdTlS?=
 =?utf-8?B?TTJxbld4KzVPRjcrRlV4U0ZEVjhGc0lJVXVLaEpJNWlTbkJnNW82NHBPTDZI?=
 =?utf-8?B?QkJzUW04TUNDNVlwa0tyNlcwR1lmZTJSN2FDOEc1OHdlV1g2TnNzSGR0TTlV?=
 =?utf-8?B?c0JjRHlYYVRTUUJBQ1MwMkJDbU9PcTQwa3gyVE9ldXhzb1A4REpiR3hQM3Fo?=
 =?utf-8?B?WC9DMHlZRk8xcWRydW1yNlRsYVc5bmlUbnFtUnpjSHU4b2pKZlRrQmd2TUZh?=
 =?utf-8?B?bzZrUTBsN2hvNGhLbEtUWndXejZtbldQbk5UT2NTZWtrV09GK0prcG1oeE45?=
 =?utf-8?B?ZGpTd2lLZ1owN3RuTE01ZGRaZ3FMdDhEUlBzK00yS3U2VXUxTDRXaGpKakRo?=
 =?utf-8?B?Y0M1dG44Q2EzSGN1alh2eXJkR2o0NjdBcTA5UXdqTWNsRk1iZzJLcW5WTE83?=
 =?utf-8?B?c3R4OTlTWHhrRlMyKytxREljWHE5RS9GZ0d1dVExVlYrNVBaMmp5aHQyYmNs?=
 =?utf-8?B?S2FnSFk5MXFBbzVZclE4eW9HUVJXWmtBVGVWT3RqVDVFQ1V5MjYvc3BUS2xm?=
 =?utf-8?B?OXprcXJtR0VJRWdxRExqVjA2ckFXYkd6L0F4NmZWQ0JvVk9WVUh4MnZjVDRp?=
 =?utf-8?B?cmtJdmZhREt0bzdOTTdDUVg5SFljRlYzb2VPeFI3cFNxZGNVN1ZkQVNsam9n?=
 =?utf-8?B?ZU5zU3lXZmNhSnBKakF6d0I0Y3hYVmt2OVorUlZsTHl1dXJVRGEwb242T2dD?=
 =?utf-8?B?aWZSbWNScTRvL0RVT093eGIyWDRPcURKdzc1OVFQSDlROWE4NFdnYU5wbm1O?=
 =?utf-8?B?cExlVTJlOTFsQ01KaHBmWkoyanpqZzQ4UFFmZEI4eHR1RUlaOUdsYldMTGxT?=
 =?utf-8?B?VXJ0WWxxL1hiWkU0TDl1RW9KeUZqWkVUVTlYTCs5ZnpxeUxQSmZGOGs5emRq?=
 =?utf-8?B?d2ZyT2Jqb2dUUkxranptRW9pSlRER1FqY0xwRWJRV3NJamkyVnhxTUFGbk9u?=
 =?utf-8?B?MngwaWdLbEN1NU52UmlhblJJWEc3ZllQemx0OG5SOFV1ck1ROE1PTFVmYklJ?=
 =?utf-8?B?T2I0N0o3bFU2NUc1ckI2TWNWUHRqbFF0dGkxN1d5cGs2YmlVY1ZQaTBvVVEv?=
 =?utf-8?B?RU1IWTBqdm80S2JxZ0JESUxQd0hPa09kalR1a2FZemYrTFE3NENnTnVwWElo?=
 =?utf-8?B?MnF1TmIwRitpVVpDbG0xdVJSMEd2Sy9tZkdLc3U0R0hIRXE2Vjd3UU9Fc0ZU?=
 =?utf-8?B?QUs4NERxbFpEcDUzcGJvYzU0WDNjMkRXMzgvNFAwYXNqb3Flb1o3MW5XbzhX?=
 =?utf-8?B?QTlncHpRemhicWFZS0p6K0t0MzhmcGFvdDhldTJ3Um9rVnlnS2NGbWk0UDZ1?=
 =?utf-8?B?M0ZiTU96Y1JTZzMxYm1ybFYrRlpxbk5wSm0rcjRLK04rQ3dHWU16ZHVDRDYw?=
 =?utf-8?B?U3paRGlxY3p4dCtBSjBuRFFoMU9lV0paeGZlTzlIa0xoNkNwaThBYkJjdzY2?=
 =?utf-8?B?bUU4MFg3WCs5NkVaNkhNd0x6T25KK1VOdEpRWU1kR1dzakN1VjlQSzl2SnlD?=
 =?utf-8?B?dlhueXdUeGNSWjNyemdwenpmOTA3SG5ZeHZ3UmsvMHovZ0cyMXVNUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a781872-6735-432a-36a6-08de5f7c40f6
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 21:20:40.4722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s6YE2M5Ttcr3EiTrFVXZC8OQqnVbKDLSB7V/yi3bJuUWoePWg1gmqci2rbL5jz8y7mxl5WLbBQWntnvkPmTc+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8511
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
	RCPT_COUNT_TWELVE(0.00)[33];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75906-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skoralah@amd.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: EBC89B48E2
X-Rspamd-Action: no action

Hi Dan,

On 1/28/2026 3:35 PM, dan.j.williams@intel.com wrote:
> Smita Koralahalli wrote:
>> The current probe time ownership check for Soft Reserved memory based
>> solely on CXL window intersection is insufficient. dax_hmem probing is not
>> always guaranteed to run after CXL enumeration and region assembly, which
>> can lead to incorrect ownership decisions before the CXL stack has
>> finished publishing windows and assembling committed regions.
>>
>> Introduce deferred ownership handling for Soft Reserved ranges that
>> intersect CXL windows at probe time by scheduling deferred work from
>> dax_hmem and waiting for the CXL stack to complete enumeration and region
>> assembly before deciding ownership.
>>
>> Evaluate ownership of Soft Reserved ranges based on CXL region
>> containment.
>>
>>     - If all Soft Reserved ranges are fully contained within committed CXL
>>       regions, DROP handling Soft Reserved ranges from dax_hmem and allow
>>       dax_cxl to bind.
>>
>>     - If any Soft Reserved range is not fully claimed by committed CXL
>>       region, tear down all CXL regions and REGISTER the Soft Reserved
>>       ranges with dax_hmem instead.
>>
>> While ownership resolution is pending, gate dax_cxl probing to avoid
>> binding prematurely.
>>
>> This enforces a strict ownership. Either CXL fully claims the Soft
>> Reserved ranges or it relinquishes it entirely.
>>
>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> ---
>>   drivers/cxl/core/region.c | 25 ++++++++++++
>>   drivers/cxl/cxl.h         |  2 +
>>   drivers/dax/cxl.c         |  9 +++++
>>   drivers/dax/hmem/hmem.c   | 81 ++++++++++++++++++++++++++++++++++++++-
>>   4 files changed, 115 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 9827a6dd3187..6c22a2d4abbb 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -3875,6 +3875,31 @@ static int cxl_region_debugfs_poison_clear(void *data, u64 offset)
>>   DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
>>   			 cxl_region_debugfs_poison_clear, "%llx\n");
>>   
>> +static int cxl_region_teardown_cb(struct device *dev, void *data)
>> +{
>> +	struct cxl_root_decoder *cxlrd;
>> +	struct cxl_region *cxlr;
>> +	struct cxl_port *port;
>> +
>> +	if (!is_cxl_region(dev))
>> +		return 0;
>> +
>> +	cxlr = to_cxl_region(dev);
>> +
>> +	cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>> +	port = cxlrd_to_port(cxlrd);
>> +
>> +	devm_release_action(port->uport_dev, unregister_region, cxlr);
>> +
>> +	return 0;
>> +}
>> +
>> +void cxl_region_teardown_all(void)
>> +{
>> +	bus_for_each_dev(&cxl_bus_type, NULL, NULL, cxl_region_teardown_cb);
>> +}
>> +EXPORT_SYMBOL_GPL(cxl_region_teardown_all);
>> +
>>   static int cxl_region_contains_sr_cb(struct device *dev, void *data)
>>   {
>>   	struct resource *res = data;
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index b0ff6b65ea0b..1864d35d5f69 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -907,6 +907,7 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled);
>>   struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
>>   u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa);
>>   bool cxl_region_contains_soft_reserve(const struct resource *res);
>> +void cxl_region_teardown_all(void);
>>   #else
>>   static inline bool is_cxl_pmem_region(struct device *dev)
>>   {
>> @@ -933,6 +934,7 @@ static inline bool cxl_region_contains_soft_reserve(const struct resource *res)
>>   {
>>   	return false;
>>   }
>> +static inline void cxl_region_teardown_all(void) { }
>>   #endif
>>   
>>   void cxl_endpoint_parse_cdat(struct cxl_port *port);
>> diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
>> index 13cd94d32ff7..b7e90d6dd888 100644
>> --- a/drivers/dax/cxl.c
>> +++ b/drivers/dax/cxl.c
>> @@ -14,6 +14,15 @@ static int cxl_dax_region_probe(struct device *dev)
>>   	struct dax_region *dax_region;
>>   	struct dev_dax_data data;
>>   
>> +	switch (dax_cxl_mode) {
>> +	case DAX_CXL_MODE_DEFER:
>> +		return -EPROBE_DEFER;
> 
> So, I think this causes a mess because now you have 2 workqueues (driver
> core defer-queue and hmem work) competing to disposition this device.
> What this seems to want is to only run in the post "soft reserve
> dispositioned" world. Something like (untested!)
> 
> diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
> index 13cd94d32ff7..1162495eb317 100644
> --- a/drivers/dax/cxl.c
> +++ b/drivers/dax/cxl.c
> @@ -14,6 +14,9 @@ static int cxl_dax_region_probe(struct device *dev)
>          struct dax_region *dax_region;
>          struct dev_dax_data data;
>   
> +       /* Make sure that dax_cxl_mode is stable, only runs once at boot */
> +       flush_hmem_work();
> +
>          if (nid == NUMA_NO_NODE)
>                  nid = memory_add_physaddr_to_nid(cxlr_dax->hpa_range.start);
>   
> @@ -38,6 +41,7 @@ static struct cxl_driver cxl_dax_region_driver = {
>          .id = CXL_DEVICE_DAX_REGION,
>          .drv = {
>                  .suppress_bind_attrs = true,
> +               .probe_type = PROBE_PREFER_ASYNCHRONOUS,
>          },
>   };
>   
> ...where that flush_hmem_work() is something provided by
> drivers/dax/bus.c. The asynchronous probe is to make sure that the wait
> is always out-of-line of any other synchronous probing.
> 
> You could probably drop the work item from being a per hmem_platform
> drvdata and just make it a singleton work item in bus.c that hmem.c
> queues and cxl.c flushes.
> 
> Probably also need to make sure that hmem_init() always runs before
> dax_cxl module init with something like this for the built-in case:
> 
> diff --git a/drivers/dax/Makefile b/drivers/dax/Makefile
> index 5ed5c39857c8..70e996bf1526 100644
> --- a/drivers/dax/Makefile
> +++ b/drivers/dax/Makefile
> @@ -1,4 +1,5 @@
>   # SPDX-License-Identifier: GPL-2.0
> +obj-y += hmem/
>   obj-$(CONFIG_DAX) += dax.o
>   obj-$(CONFIG_DEV_DAX) += device_dax.o
>   obj-$(CONFIG_DEV_DAX_KMEM) += kmem.o
> @@ -10,5 +11,3 @@ dax-y += bus.o
>   device_dax-y := device.o
>   dax_pmem-y := pmem.o
>   dax_cxl-y := cxl.o
> -
> -obj-y += hmem/
> 
> [..]
>> +static void process_defer_work(struct work_struct *_work)
>> +{
>> +	struct dax_defer_work *work = container_of(_work, typeof(*work), work);
>> +	struct platform_device *pdev = work->pdev;
>> +	int rc;
>> +
>> +	/* relies on cxl_acpi and cxl_pci having had a chance to load */
>> +	wait_for_device_probe();
>> +
>> +	rc = walk_hmem_resources(&pdev->dev, cxl_contains_soft_reserve);
> 
> Like I said before this probably wants to be named something like
> soft_reserve_has_cxl_match() to make it clear what is happening.
> 
>> +
>> +	if (!rc) {
>> +		dax_cxl_mode = DAX_CXL_MODE_DROP;
>> +		rc = bus_rescan_devices(&cxl_bus_type);
>> +		if (rc)
>> +			dev_warn(&pdev->dev, "CXL bus rescan failed: %d\n", rc);
>> +	} else {
>> +		dax_cxl_mode = DAX_CXL_MODE_REGISTER;
>> +		cxl_region_teardown_all();
> 
> I was thinking through what Alison asked about what to do later in boot
> when other regions are being dynamically created. It made me wonder if
> this safety can be achieved more easily by just making sure that the
> alloc_dax_region() call fails.

Agreed with all the points above, including making alloc_dax_region() 
fail as the safety mechanism. This also cleanly avoids the no Soft 
Reserved case Alison pointed out, where dax_cxl_mode can remain stuck in 
DEFER and return -EPROBE_DEFER.

What I’m still trying to understand is the case of “other regions being 
dynamically created.” Once HMEM has claimed the relevant HPA range, any 
later userspace attempts to create regions (via cxl create-region) 
should naturally fail due to the existing HPA allocation. This already 
shows up as an HPA allocation failure currently.

#cxl create-region -d decoder0.0 -m mem2 -w 1 -g256
cxl region: create_region: region0: set_size failed: Numerical result 
out of range
cxl region: cmd_create_region: created 0 regions

And in the dmesg:
[  466.819353] alloc_hpa: cxl region0: HPA allocation error (-34) for 
size:0x0000002000000000 in CXL Window 0 [mem 0x850000000-0x284fffffff 
flags 0x200]

Also, at this point, with the probe-ordering fixes and the use of 
wait_for_device_probe(), region probing should have fully completed.

Am I missing any other scenario where regions could still be created 
dynamically beyond this?

> 
> Something like (untested / incomplete, needs cleanup handling!)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index fde29e0ad68b..fd18343e0538 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -10,6 +10,7 @@
>   #include "dax-private.h"
>   #include "bus.h"
>   
> +static struct resource dax_regions = DEFINE_RES_MEM_NAMED(0, -1, "DAX Regions");
>   static DEFINE_MUTEX(dax_bus_lock);
>   
>   /*
> @@ -661,11 +662,7 @@ struct dax_region *alloc_dax_region(struct device *parent, int region_id,
>          dax_region->dev = parent;
>          dax_region->target_node = target_node;
>          ida_init(&dax_region->ida);
> -       dax_region->res = (struct resource) {
> -               .start = range->start,
> -               .end = range->end,
> -               .flags = IORESOURCE_MEM | flags,
> -       };
> +       dax_region->res = __request_region(&dax_regions, range->start, range->end, flags);
>   
>          if (sysfs_create_groups(&parent->kobj, dax_region_attribute_groups)) {
>                  kfree(dax_region);
> 
> ...which will result in enforcing only one of dax_hmem or dax_cxl being
> able to register a dax_region.
> 
> Yes, this would leave a mess of disabled cxl_dax_region devices lying
> around, but it would leave more breadcrumbs for debug, and reduce the
> number of races you need to worry about.
> 
> In other words, I thought total teardown would be simpler, but as the
> feedback keeps coming in, I think that brings a different set of
> complexity. So just inject failures for dax_cxl to trip over and then we
> can go further later to effect total teardown if that proves to not be
> enough.

One concern with the approach of not tearing down CXL regions is the 
state it leaves behind in /proc/iomem. Soft Reserved ranges are 
REGISTERed to HMEM while CXL regions remain present. The resulting 
nesting (dax under region, region under window and window under SR) 
visually suggests a coherent CXL hierarchy, even though ownership has 
effectively moved to HMEM. When users, then attempt to tear regions down 
and recreate them from userspace, they hit the same HPA allocation 
failures described above.

If we decide not to tear down regions in the REGISTER case, should we 
gate decoder resets during user initiated region teardown? Today, 
decoders are reset when regions are torn down dynamically, and 
subsequent attempts to recreate regions can trigger a large amount of 
mailbox traffic. Much of what shows up as repeated “Reading event logs/ 
Clearing …” messages which ends up interleaved with the HPA allocation 
failure, which can be confusing.

Thanks
Smita

