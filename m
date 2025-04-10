Return-Path: <linux-fsdevel+bounces-46217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28028A848E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 17:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 379017A8C0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 15:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338B31EBA14;
	Thu, 10 Apr 2025 15:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S3mlOzKk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FD31E8329;
	Thu, 10 Apr 2025 15:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300650; cv=fail; b=eblQxWvLzMlYHFbc5HGSVqwEGhXvxJPMhPbcNo73eTqJr3NewB6mRGUq/YPgoNRT6d2w76soFpl4UVZrMggtvw3tokHaDWhMuOgPIFg9gHU31FcZlgbntKcqBO4rqTzu03iM6qGfBTXnQESxQ0YQtW+PePBGeBT6I9GZ4FJ1GOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300650; c=relaxed/simple;
	bh=vvsruQT3fdt5JNcE1pFv574bR3pxNrlyleABNmSp+4c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RiA6PBy9AhKDBRrzRILqEmRvOJL/106THc0mPlWafE94eS3myd4qT9zc4u+OTdMNk2hNgbUVC3wFaCCYgoIb1qi/5bNDyS0tOwg/wQYqqoE99xGaXH/NkSP2ITg/FZfBTtIQ9gS9n8ujei/JKAxMEWXB9nHLtryV+eLdUfw5fNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S3mlOzKk; arc=fail smtp.client-ip=40.107.236.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mQpszrnUtJKzOup1Z6HIjiDwRvA5sy/BmaXHqXuSk88VHRW18H3v4tgT9kzcTmEHC1yNXZ+ygZaYip0Vc3QFJEte+opWuGFhAqXeLEtLGrtfoy5YOSbH9mQKGyADgWkJcr8uIuOxEvHaihe4nG6SIFdBnAZkrSRX4sesI0WH6qP4L4rjea+Xm9LvsUqsCxeD+/oEjtAHOoyZflaDC5HW7fdPS5staSJqnyvBUV0U/ImftydmBS8XE8Q392kqGMm+S/e78dzkHoFq/dpS9Aew1/IqWoTf0YJYDN7GIn3D+KoHcQULQuQPkGk3zH0UEjD/1L0omZV+jQn15iaXW4Ia9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZ07Qegye/+3iWbSpHD/AM1yMcjHEwIb6HZ1xBtb/Ck=;
 b=Dfjrm9HH1jpnmFAsd9BB0+IYTQrJ5sGJ9IU7ingpB//omBkye5AJljzgrbajI6VSxg9g9bGeI55IRvbriOf5IQBcz2RVPd0t1zK4iiwdvackGLitsZX6DAEX+y4oHIDRg9UDE4u4fBisEhDDCx9661zcqSmscfRBrbtyahny5wgmnc5EslXAUGKmGLWzT71ieLd2SYO0c07ZjypOz2P7Ya4KEJvv9NzqAL3i3cN4Q4OqFvyly3kX06Ry+1K+NDlX8ZokBz8/S75ZutyX8XsxtxMAmQzvUKHqhjIcFsPkhYsaXoMC+tSPn4K0q48L4i88pqIxQvmwhw3j8jwO+2J/Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZ07Qegye/+3iWbSpHD/AM1yMcjHEwIb6HZ1xBtb/Ck=;
 b=S3mlOzKkRaJTi5Ywhpv77S6diVftn5TAP9F8+ijLdagQTWt9thhZXWyBUQ68LV/hJzNX80uWwnQiyYcsb0RVAln7zJY0mVHD37eE8YSO2Rjq8RO4qDIOjiDEdYsBffku2FWFZn0Ann+XvQvX1EQ7pe7CPG14SOZfZubZYkS6IiQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SJ2PR12MB8783.namprd12.prod.outlook.com (2603:10b6:a03:4d0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Thu, 10 Apr
 2025 15:57:25 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 15:57:24 +0000
Message-ID: <c9c65e4a-720b-4913-870e-c322bf33c80f@amd.com>
Date: Thu, 10 Apr 2025 10:57:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] cxl: Update Soft Reserved resources upon region
 creation
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 willy@infradead.org, jack@suse.cz, rafael@kernel.org, len.brown@intel.com,
 pavel@ucw.cz, ming.li@zohomail.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, huang.ying.caritas@gmail.com,
 yaoxt.fnst@fujitsu.com, peterz@infradead.org, gregkh@linuxfoundation.org,
 quic_jjohnson@quicinc.com, ilpo.jarvinen@linux.intel.com,
 bhelgaas@google.com, andriy.shevchenko@linux.intel.com,
 mika.westerberg@linux.intel.com, akpm@linux-foundation.org,
 gourry@gourry.net, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org, rrichter@amd.com, benjamin.cheatham@amd.com,
 PradeepVineshReddy.Kodamati@amd.com, lizhijian@fujitsu.com
References: <20250403183315.286710-1-terry.bowman@amd.com>
 <20250403183315.286710-3-terry.bowman@amd.com>
 <20250404143252.00007d06@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250404143252.00007d06@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0063.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::12) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SJ2PR12MB8783:EE_
X-MS-Office365-Filtering-Correlation-Id: 877d47e4-869a-4bcb-2611-08dd784862bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3plMCt2NmVkUFhRdTVhZmhyY3pJdW42Z25xOEZzOGdRc1NtU0ZqZmIxQUR1?=
 =?utf-8?B?RmFPNE40WmdqRGZnOGFDWXVhei85VG1HNWFyUktnbXpPNnRnSUM4QmJXS1N6?=
 =?utf-8?B?bWZtSGdEdzFTS3JqeHlxSFJtNWRTQzJoUjNUT3FBTllDN1lIL2l4Q1lveGNS?=
 =?utf-8?B?SUEvdmY2Y2Z5a3YycVlTNUdjVjBzQURrd2dGeVlWRUlVRUF0NDV5U2VOazJt?=
 =?utf-8?B?Qk9pM1NVVE51SSt0cml1NWxVVmFJdnJnL2JrYjZIN2pnNndiYlpNUjE2WlRq?=
 =?utf-8?B?QXN5Q1NFeVBtOWlQaFJ5NFIra0V0UWh3elNLWlVKcUs4ZVVjTmRRakcvVSti?=
 =?utf-8?B?bXdmRlJFY1pYREV3RXJiV3RSbGJieStvaEtkanVIRXdTQTlqT0NYTFVIOEFM?=
 =?utf-8?B?K2c2QUdURTVObXgybW1kMlpsT251TjAzZzVXV2xXb2dkdDE3N1lBQ2R2UndS?=
 =?utf-8?B?MGxXcnFJOUZobFBPSWJjaHJOdkN2WDJTMDE5UCtFM0JoTXJKK0JqQ2hjQTVD?=
 =?utf-8?B?QXJpUGVnU2h1aXAzNzh5eUtVVFB4bVg4WmExOE8zYW1oMDh4aVlkNFJjNzU3?=
 =?utf-8?B?RS9hUHVDQmozOTVlZ2kvWXJxRnFmMU1SdlZUNkRFNzZ4T3crc2h1VmUzNHVP?=
 =?utf-8?B?MDV1MWR3UzUrL3RyNnZlWXBFRUtUZ1J3dmkxOHlubXpmZllNSlVhd2Rwbk03?=
 =?utf-8?B?TUl4TmpvOWc2dEZyUFNVc2dDZEt4TWRWeGduMG92dWRUN1Y2ZW1qK3o2TklP?=
 =?utf-8?B?Q2xTMGpRTk1ObVNjWGk2eWVLUFhzNTB1NVNMSEVTdnIwMGlIeDh0UEoxdlEv?=
 =?utf-8?B?T0wzT2VjaXFadWFpUERjVUFJVGhUMDRxRVZaS1JKSmowWUkva2c5NDBrMGhn?=
 =?utf-8?B?T0NJbFdOeFRwOGo5cE9NaG1FK0piUC9Jd3RtcUc3cEszaUlkVUh5STdWSlZE?=
 =?utf-8?B?dUNURUVrOTB5ZjUxNG1wZGZkTUhSeUs2MUhMcjZkRU5NdmJkVjNLNUZLRmJl?=
 =?utf-8?B?ZGRVVytvYm1SdSsybm5LK05pNy96Qmh1eFROSGdBeUZJM0VxWkwwL1NJa1Ir?=
 =?utf-8?B?ZnB0TEtuMzI4ZS9odVNhMjBteVJ2Y2d0UU9XSmdUSnpPVkFHL2kzSm5CREp3?=
 =?utf-8?B?Ris0UXprWFFHUkJrR2RtOHVRNEdqTDBVQVJUY0thZUp5L1ozSVhLcHhCSDQ0?=
 =?utf-8?B?QmhmaGxyaFc0cXUwaVNkbStXOXlXbGJ3Z3BUWXd6N2ZwWkUwOWtEN3puV3V6?=
 =?utf-8?B?cWZCNEM3K3VnZnpaamF3dkU0TWxRdi8yVGJpQjMwSU9GbFhIejRjZ0xCVnRZ?=
 =?utf-8?B?VjFwMTBZcXJWUCtpZTJzRFAzdVdGWEZWRFVHbXhxSWh0M2RVVVU0NjczQ2dm?=
 =?utf-8?B?NUoydmUvRUk4UGpVSG8wOXd1Q3p2STBzQm94Z2VlTGZFS2s2NjNGS1EzOXpw?=
 =?utf-8?B?RklJVjdUTW9lb3BRTi91NWhMN1pjUjNWNVk2N25TN2QwWWJ3Z3p4U3lCMDJT?=
 =?utf-8?B?Z1FNZjVRejA4WEltSjg4Z1hQa0kyTHZrd2lMWVMrMjRYR3Y0WjBXN3QwNHdK?=
 =?utf-8?B?L0VjVGhLVDBhTzVaZmlCamdQZDNYaDBvZXAvbHZsTFNxTXRoVEtPN0VxaE5S?=
 =?utf-8?B?ZHpVOUthRTNTa2hDMlluVXkrWk50RWE1a0tWK0MxdktBbmZQeXdDT0Via2hj?=
 =?utf-8?B?Rm1uS01FM0xOdlhsTDNydm1sQ2lCWlBrQ2NzaEZGU2x5cE5IMXJaako2bm1B?=
 =?utf-8?B?WlQ1RDNocXAxVmtvODdQd05HRmh6eXM4SG5TbnZVbnNpSVlhaWMvZXhZZkRV?=
 =?utf-8?B?dWovcENTZXRTcWVrWDdGLzNzOW40RTg1SGN2Z0d0N0VVRHdKRnFIU3RNOERW?=
 =?utf-8?B?ZmtwY1lpaEpqSlBDbXFQVWZZVWpHQ1NKSVJOZSsvSXYyTHEzdW5QckMrbURi?=
 =?utf-8?Q?bitoTBgPR+M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGdSVWY1ckUwcDFYOEltUkRMQ0Y4WkRDQlZXZS95aG5LZytTcUM0aHJXMzlY?=
 =?utf-8?B?NUhUVng1WEJ0MTljRjFaZHVITHQ2TE5jS2t0K0xyYXJIeEYyRzMrWGQ4Rk51?=
 =?utf-8?B?cXpFbktzTmFPcFRyNFFibENJci9vdWNLcEl3OC9JRlNQOUY5UHk2Z2dFOG94?=
 =?utf-8?B?d083TlIrUzk2bGFPQ29hQ0RYLytwR3l3d2phSEs4R0t5TGNPa1MvUUlzY0pz?=
 =?utf-8?B?MjQwekFjR3ZUSFp3ZXBpaG5pQTBBQXRIb25hM2NDSDh3WEs3TytSUEdwQXJy?=
 =?utf-8?B?Q2JDcVdiSm1FK3BsbVhSL3JDUjEvdjdjMDZQcFgyMDd6RWgwTjUyZTNSNlMv?=
 =?utf-8?B?dW9hK0VGVEFWSEZsdzI5YVpxNnBYQzNGYlpVaEFIQUlHZytWemZKSE1zSk11?=
 =?utf-8?B?aGI4TTJjYTZ5MkNEWGo3OENad1RmbXdKQlowalRicjlrMzVubGZyZUR0akhH?=
 =?utf-8?B?VGdKZFhoYzBid0NQSDJJZzZDQWNzZHhpWFNrRXlvQmJTYWVYUEdWQ0k4N09p?=
 =?utf-8?B?V2huMTRCd0ZwcStucjlHYWdQRjduWi9XcWNVam4xWHJMOGtmWlRzMy80eEtn?=
 =?utf-8?B?Mm5ENWpDcytsV2RDZjZzU2ZBMUFYeE1kTUFmTGJpRy9IZ2NPVlE4Uk9sQnkv?=
 =?utf-8?B?d1p4eE81Z3QxRUtFTjFzQ2xiME1lVk11dXJkdHVKY1Q0T2ZpY3FDMS9zWHdo?=
 =?utf-8?B?OFlidG5LaTlUaVhic1BWVDBHWCtJOVFwZHB4NzhZaGhUQTcwMVJjZkwxUm02?=
 =?utf-8?B?MWw3ZEo0ZUtLVzR5VHVYVmhIeExPL1MvQmZvRjduc3EwdjlrL0t1d0JTR2tI?=
 =?utf-8?B?WmoraG91SzRxSnNkVHUwQW1Uc1lJZmUzWFAzNTRGZ2xlQjQzMXlLU1ZGeEQz?=
 =?utf-8?B?Y3BxZS91amRSK3h2OGtXakl1T3FScFArS0wxWVMyMjNHL2lVVnp1WHpBK3Bt?=
 =?utf-8?B?YWZOaW5LMFBzTDlYcXlhb29FR3N1L2ZpTG5TSGlGYlpaQXd4OG52VExoZy9Z?=
 =?utf-8?B?a1BzQW9mQUIxSGpiTnVDMUphR2ZRUDBzYW9WSWxCVDdaMzRjaEY1bWc0bzlV?=
 =?utf-8?B?ckpJVjh5V09DOXg4dTZKbSt5TjVGbTVGVlR2M2kxNVppM1VmVUM3bFBGb3R1?=
 =?utf-8?B?Sk9sTHdKSXdVN1ZhZDRDTkFmUTdsREY0T0lLaXlTeVpQV1VhWDFLSC9YVGRS?=
 =?utf-8?B?VTM3MkVhU3ZkdWdwTC9CRHdnYzgxSXZFaFJCWlBBOXFKSVJIK215akVKQ0NL?=
 =?utf-8?B?dDlsRzgrUkJNbno4RnVTaWNZVWRJUHAvMyt3N1o5dlc0NStnU2tNYitPRVF4?=
 =?utf-8?B?dzdtbkNXL3N0aU5xUmx4bDZYRGtTRFFyZmNjMTdGZzdSWFFyWC9hOWdGYzJj?=
 =?utf-8?B?QU54aEVsM3Y1REgyeU5zdGtxVGVzck1oWng0czlDZkk4d3dMRTVzZVJLUUti?=
 =?utf-8?B?RUc2TkxsUUx4MDRwdzlLY0phQk1Yc3ZrOGR0M1dBcDBDN3VvRWFReTlWMUZR?=
 =?utf-8?B?WWlhcDFKNUJ3eFloSWJmaS9KUEhiczJqSFpDZCt4U3NNRDFyMzdaalg4L0ow?=
 =?utf-8?B?Sk5WbEdlM2lTZlNsSmJydE5QSmU4SkJJWUh4STZuaGdxV28yVlpobE5BQ2ow?=
 =?utf-8?B?b2hTMnZGSDV2K0tvZXhVQU9mZlliTjQzMkRPdG52bERvRXZhL1VwajBBNVhM?=
 =?utf-8?B?elZieUR5SS84RnF2MGNTMW9UandDL29BTjJOeTgxQWM1aHd4SWdkeTROMEgw?=
 =?utf-8?B?QnN4L2d2eUZWRy9aSWwxV2F0NTNUSTNpKzljaVpRdDZTSmtkcktkM3ZvbVhO?=
 =?utf-8?B?aXV4L05PRk1sa2RjVEVZaFRDR2h3MEhzb1daWEVMemFOOHVsWTl2NWc5VjRT?=
 =?utf-8?B?NWtxbjMvWmlDb1VSL1Y5Ylp4TXdQMXlWN1Z0ZUFnMVY2bE4xd3VSQ1luNS9O?=
 =?utf-8?B?enJmMFhzendOSG1aQU9nakptbnpsSkZFMHNZL2FNYVhtSGRsT1RXUHhkK0Jt?=
 =?utf-8?B?Qnd2MWxFVyt5UVpEM2dMWWg2YmM5VWJIT1ZoTTc4UHkvM2VCR3ZuV0xta0Ft?=
 =?utf-8?B?VCtMMFZaT3hIREZsNWJiYVVzWFRqTUdQbDIrV3psZjJLYjIwdmhtS3JIMVZz?=
 =?utf-8?Q?TOJAXpXL/U/a++fS+f4qnhMr6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 877d47e4-869a-4bcb-2611-08dd784862bd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 15:57:24.8060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eIpl9xCyS5ypIqAas1NWqFAT3fI8bFW3T2Jylc29VwmalR/tU9i1PXC1lFs+XKb4WdXTOWsGsbvnVEQK23Q14Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8783

On 4/4/2025 8:32 AM, Jonathan Cameron wrote:
> On Thu, 3 Apr 2025 13:33:13 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
>> From: Nathan Fontenot <nathan.fontenot@amd.com>
>>
>> Update handling of SOFT RESERVE iomem resources that intersect with
>> CXL region resources to remove intersections from the SOFT RESERVE
>> resources. The current approach of leaving SOFT RESERVE resources as
>> is can cause failures during hotplug replace of CXL devices because
>> the resource is not available for reuse after teardown of the CXL device.
>>
>> To accomplish this the cxl acpi driver creates a worker thread at the
> 
> Inconsistent in capitalization. I'd just use CXL ACPI here given you used CXL PCI
> below.
> 

Thanks. I will update.

>> end of cxl_acpi_probe(). This worker thread first waits for the CXL PCI
>> CXL mem drivers have loaded. The cxl core/suspend.c code is updated to
>> add a pci_loaded variable, in addition to the mem_active variable, that
>> is updated when the pci driver loads. Remove CONFIG_CXL_SUSPEND Kconfig as
>> it is no longer needed. A new cxl_wait_for_pci_mem() routine uses a
>> waitqueue for both these driver to be loaded. The need to add this
>> additional waitqueue is ensure the CXL PCI and CXL mem drivers have loaded
>> before we wait for their probe, without it the cxl acpi probe worker thread
>> calls wait_for_device_probe() before these drivers are loaded.
>>
>> After the CXL PCI and CXL mem drivers load the cxl acpi worker thread
> CXL ACPI
> 
>> uses wait_for_device_probe() to ensure device probe routines have
>> completed.
> 
> Does it matter if these drivers go away again?  Everything seems
> to be one way at the moment.
> 

There is a maximum timeout wait period. I'll add these details to the 
commit message here.

>>
>> Once probe completes and regions have been created, find all cxl
> 
> CXL
> 
>> regions that have been created and trim any SOFT RESERVE resources
>> that intersect with the region.
>>
>> Update cxl_acpi_exit() to cancel pending waitqueue work.
>>
>> Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> 
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index be8a7dc77719..40835ec692c8 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -858,6 +858,7 @@ bool is_cxl_pmem_region(struct device *dev);
>>  struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
>>  int cxl_add_to_region(struct cxl_port *root,
>>  		      struct cxl_endpoint_decoder *cxled);
>> +int cxl_region_srmem_update(void);
> 
> As before: srmem is a bit obscure. Maybe spell it out more.
> 

Yes, will update.

-Terry

>>  struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
>>  u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa);
>>  #else
>> @@ -902,6 +903,8 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>>  
>>  bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
>>  
>> +void cxl_wait_for_pci_mem(void);
> 


