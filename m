Return-Path: <linux-fsdevel+bounces-71219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC48CB9E8E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 23:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A138F30173C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 22:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25D430BF62;
	Fri, 12 Dec 2025 22:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tyoJ84Cg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012029.outbound.protection.outlook.com [40.107.209.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17A743147;
	Fri, 12 Dec 2025 22:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765577667; cv=fail; b=c9p+PU/6hqjFTK1/OHbUBaVPC3oXKq1zSyZExYCEkCBfYP9qpU3VdK8+O/BOcapBbhpzl7Cp1a2je9vuk041d7Lr7Ae8kkUAPZP/pN1kTZnQZMKCb8ZGhvQDpVzh0fy+wlg50Lxh190Y3Lq9eRIoWTV8fM4kvrHXmlVZN2XTK3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765577667; c=relaxed/simple;
	bh=3o3nZb5ce9AB/ogQDEiOZ50ko59SgL9VSxzDqiitNUg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KuxeCpinjJ4uC024k6itAP6kbdSvmCURxZphma/moP22Y5IUh99kHqwTHSbElgwKUOGdBcbvmqfQ89f4fXjhjL0cAAhj9hZjDHKOd+lpMUA9tEtDUDa+NTNr3MU6EpqXJFMFY/p65ot1j/f0DoyrZBoF6i0BkBg8qmFoUds5ac8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tyoJ84Cg; arc=fail smtp.client-ip=40.107.209.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QjA75yl8K3l09knIBeNeqNgSLfoSdEvZXLx1u+5BvrkfcN+fR1dvJVLxaSNAwfl2osoQevkWwUTV2GUfUGAOK+3XpXAi9c7V+pDZ6OjHXDPnN73K4M/DC6H/A9FzKRZK2sVa5K9sVSkBpLJ+pnaYnEdltnTrI8hhn0S7FyhzrhnGpjZx+zhIdsyvPuDr79coQPatHsXFOEZ+Oyz0WZ3ZJeIKc+W9Y8ccB1BkfUzIM/xTqnNp6JxgNxAeURWLnbpzld6cikUb4VSgddRPZh2teS6RE05wh7sd2SXZPvwPiNBmVFPVsxmElOVQPh9Vk8Tg7HdEzUcegldjSya7TNvmjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RW4QzP3MyL0Rxz9BcMcnxhxtNWoxDGpnxouCf373lHo=;
 b=KPLtOV3H6ueDSU8VD0/dbyvBspDyFdPmTUHWURCvIf99wjUsY7uk0U4WJNkWGF8iZm4zxKA63YPekhgpeGAynfNyfwyqBhzILg66GgJJLiWkAB/ZkSEB+GTCwfYSWq8JSidYhJ9QzWaNBHhmdMPNlS3IceH8MURPUHaVHfksW4YIhMakArnezuXlboZ3Do5Dt0aU3NPUkxHDusEaGKmXj0NEy9/1BonofSpDf1M6EDAzwZsnMUg4+imX34sWf8WyGC7lFMx0tOJ2udvQi+5twgwjGPKxbvcDfb+H1TV+Sc/e6oq6mFKjQyAIGRrNf55sieYYzQuqOSi9++eKStsDqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RW4QzP3MyL0Rxz9BcMcnxhxtNWoxDGpnxouCf373lHo=;
 b=tyoJ84CgtVc2A6ExnHiGp+3sgMoacWG0XPFNxFYTvhWuVuezIgQmrR367jvFxKZgMsfy8bKGSu5SEVXHi+0QYg5SEojNv2Alnc3fDZaBpxWpeAMI2EeHi3ZHYkc/wVKWrEu3w3AAznyxR3RixmGZb42ExBB4UWUKJbb8GNVxn/4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9714.namprd12.prod.outlook.com (2603:10b6:408:2a0::5)
 by SA1PR12MB6800.namprd12.prod.outlook.com (2603:10b6:806:25c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Fri, 12 Dec
 2025 22:14:22 +0000
Received: from LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::c18e:2d2:3255:7a8c]) by LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::c18e:2d2:3255:7a8c%4]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 22:14:21 +0000
Message-ID: <aed282ff-e125-409a-8c38-d6e68cf3f102@amd.com>
Date: Fri, 12 Dec 2025 14:14:16 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 9/9] dax/hmem: Reintroduce Soft Reserved ranges back
 into the iomem tree
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
 <20251120031925.87762-10-Smita.KoralahalliChannabasappa@amd.com>
 <6930dbdbcc6e_198110055@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
In-Reply-To: <6930dbdbcc6e_198110055@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0132.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::17) To LV8PR12MB9714.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9714:EE_|SA1PR12MB6800:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b4456b6-c514-4274-006b-08de39cbcce2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N3hTd1ZPSmlGMVZqNng1VGdnZTUxQys0bUh3QVhnTU1WSGZtMnl6VWl1T08x?=
 =?utf-8?B?R09JVjlrYUdGNUZUb0hRRGFmUmRnTHdBQStXenVod09mcGFaSFdlV3N3Sm92?=
 =?utf-8?B?Nm92U2NLb2oxMXBqa3FSdDVxbVlIZnlFWkk5Tm4xa2RwcmlYUnBMcTF6YVNa?=
 =?utf-8?B?dGd0d3R6ZElTUGkwZ1FLNUU5VlFGRTU1VEdFOFgvT0NuNEhsZldEU28wZDhD?=
 =?utf-8?B?M0F1SDRMK0o4SlM2QUlMT0Q1QlJSaW80RlNVWksrelplaDY4VUNoODJpYzNK?=
 =?utf-8?B?TWhFUS9rMnFSVHcwR2Jyd05xdlUrQWxFL2laM1JuZU5jN0Z3aW5CMWdaUXVI?=
 =?utf-8?B?MnFkRlFESUdWVFJJeCtHWEVFcWF0SHJDOHBwNDZ1OXZhMW4wVzM1VTMvWEY2?=
 =?utf-8?B?djM1VnkzNE5pVmM5clUwTnN4cmlMOVc3Rmx0emgvcjE5dkJUZk9DOFhTK1JP?=
 =?utf-8?B?ZUgwMmgrcktlVm4ySU15QUhTVTZGNG9iaEVjNjJiWWlJN3ludS9wZ3A5Sldp?=
 =?utf-8?B?cnlNNTZXenZzQjU0Tmh5eUttRDdoa1FpeSt6cmJPd3ZSc2pTWHY1TFFCVmQr?=
 =?utf-8?B?L21aT3ZkQm1KUUJsb3BxaThnb0RmbHNIZUllUjF3d0FVbCtvZ2Y5VUtBYjl0?=
 =?utf-8?B?Ylo5d0xnTHZ1cW1aOE9JaFlRNHB1aVB4L3MyWFFrbmE4dE14ZHB2QjRpNVR1?=
 =?utf-8?B?K2E1WVp3Y0FDaTFGb0MvU1M4OEFaZW9VR0J3Y3lJU0lKTzBxbyt2cDdGT01K?=
 =?utf-8?B?ZU5RcElaOFdha3RpQTdKMHp1bVk2cER1SFhGWUp6Y3ZBK1BVV3VCSENFUkZh?=
 =?utf-8?B?TC9KRERDMTlDOXIyQ3JvUk5JaTQzOHd5ZXRUK29EYWJaY2R4eG5yMHp6M01M?=
 =?utf-8?B?Y2VzRXJNeVhUeDk2SVZYdnY5TWVIR2RPeksxQ0J6bU5ZeUk5bm9uS2lKaEtO?=
 =?utf-8?B?QnpyQ2RxQm5zOWlNdzk4RWxWbWkzTzhVeXdSWFJZK3huRk5xZXFFeEZySmRW?=
 =?utf-8?B?RXRWTjBhWkJ2cm5zMWxGVG1qcHZXZnp3M1AzUGxLSlQ1VFFMUW9qdEorRERB?=
 =?utf-8?B?czczSkdUZm1KcVl3MUFINXpQbHQyYm1xQ0FBcElhK3FVSm1ybEVMQjZlYmhu?=
 =?utf-8?B?ZlBaeHNVQS9pZGZUVjhmaFhMb0YvSEIrYUh2eFFacWRqUHBiTXdMYU9zdzUw?=
 =?utf-8?B?a1lzenliQnluYU1SQURwLzNKbTRiT2NDNzZoTUZZUk50WjlYcTFXMlRFeTV6?=
 =?utf-8?B?K0J3c0pSd1ZIYTlUcXplLzhpNy9wNzZ5S2NucEVPa2N6eU1lSm5id2JFT1R0?=
 =?utf-8?B?ajh1dzNOekZZNEQrR2RqV1ZYS29ZS000MmZRWWcrN1JvNEY5QzkwWWhtL1Qv?=
 =?utf-8?B?S29GMVFsUDAyQlE1dnV0VE9QU1VmSGlKTlBCNlRsRFVSTm13cnl5V2VES1Rv?=
 =?utf-8?B?eFFoak9sU0kvRVJ6c2g4SUE3M3JYMWF0b0V3MVAyeENFaTBpR1BQWC9mY3F2?=
 =?utf-8?B?aHpVejlhNmtESSs0TklZOVkxbUJOK2cvazltWU81eUduZm9iRWtFU0NwaThy?=
 =?utf-8?B?WXE3YmppNkhrK1pybmtYUGk0MnB0R290K2JUME80c0I3UUd6WUhBVTlMV2FJ?=
 =?utf-8?B?eENmY1dyNkdFN3lBU20vRXdnVlR0cXJYbTVPS0hOdmtsTkpvWnlZWnFkUkVm?=
 =?utf-8?B?UmhGYi92b3JlMmFYNDRmMXdHRGRGajlxZXV1QWk3VUlVeW9zV2JxbDdkTm95?=
 =?utf-8?B?cUsyckMyNnovNEcrV1o3dzF0Z3o2YUFaeU9PSDNCTk9tTVRHUVpibExRMW40?=
 =?utf-8?B?QkpaTk5VK0l3d205a0JEdkpTZWhYZHpBRUxUdnNtV0hIeldDMEM2anp5d01k?=
 =?utf-8?B?Q05kV1RNWHkrRHJ2ajR4cjZIaXAwcDN0SlRsbVV1LzcwcVJSaW5JbGRSczlC?=
 =?utf-8?B?eHBaNWJkb1c0aHlJVDVJVTQrb01aTUtaZlphdDFLMzd3WjA5WXI1QW5GdVpw?=
 =?utf-8?B?d1UyVlB4TDZBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVVjRnRtTGdwMG0vMDJGWXlVL3Y1b2NFR3M2Q0FBNjEyb3NPbFhwRWE2Rk5t?=
 =?utf-8?B?RWtaYnFNNVJmVllRdzcxY09kakxhN2NiOEVIRzJhRmxKQWxQSEJGdzEweTZw?=
 =?utf-8?B?ZjVCVFRmQ3VGZnVybTB6L29jV1dWRmx4TTJnRjM5SmNnbWs4Uml5M2xjMlB3?=
 =?utf-8?B?dVF0RG16WjEvMFNsYjZZcCtUdmphZ2JYVWVHR1pxQ2YxL3lhQ1NSMnF5L3dL?=
 =?utf-8?B?STh5dG5WWDdkaWZLSWFGeW83VVhSL1dEOG9RWHhoemFUb082ME9ZR1VZc0h6?=
 =?utf-8?B?czZXOGdaZ2VObEJZYTFheGU5RXlSSFJHbzcrMUQvSjFaUnQ4WXUwYUJOSGN2?=
 =?utf-8?B?THNHaWpES2MvbkYzYUdzOXBSRG1udlpxUkJaSDJVTEp6djczWHo4MEpGdkZp?=
 =?utf-8?B?bTBOa0FQVUltcDN5azQ2RWlKRmRlRzNIUGR0eTB0WXVXT0pnMEJjRXQ1ekVR?=
 =?utf-8?B?cGZEMW9welZpeWRsSXBmcC9IMW82Tk9sMVRTZEZBSTlGbVhCMVV2c0tTZDJy?=
 =?utf-8?B?VzZmVzFOOXF4RnJoSWd2OElwM2xMSGprUGV0d1h2MXJUK3A1Y3BBWTZ1NHNM?=
 =?utf-8?B?MlBZTHJnODlZd0FaZXBwTEw3RVZ5VzdOUS9QR0tQeDlpQmlWZE42ZERnZ2pT?=
 =?utf-8?B?bDA2RGk4bVFIL2hSaE5qdmhtUDhydUZ2VzMzR3RLWjE5eDF5ZlFJOGhOMFNK?=
 =?utf-8?B?WWpjbmdrU05YSS9BWHBZSHExbnBkQlROQmlTdzVzdnVSQm5DcjYrUTJkSjNp?=
 =?utf-8?B?ZlFRQ0ROWkpoY09GNzhzbEhlMnJ3YS9hakNRc3ZyZlZPTUJaUzZybVVhaUlD?=
 =?utf-8?B?ZWNiZGt2cnZrQm9UMjRONXE1NUV6U1lXNlJEUDBKdVY2YStOcnVSTi9lN1dY?=
 =?utf-8?B?VkNqdm94QUpSRHk3bDhRbys1RURYWEdtVGRHV2I2QTE3cXZ4eTcvWC82b2x0?=
 =?utf-8?B?M1lVcis5MEYzaU5GVDJNR2FqWVM5VUxBM0RlMG1iMWpxZVNJZ2F5czYyZ3A2?=
 =?utf-8?B?U2c3MTV2ZmVTRkJQNjAvNGJlTzNBNkN6L0xiQzRRZFVna0NPd0p2WDIyamJN?=
 =?utf-8?B?S25mM3B3ZUsxdVBQUnRsRHNsbld5RXFJQUtlNWRhRm9tc3JEbFB6NVdFSHlp?=
 =?utf-8?B?OFVxNzk4WE9IM2pDdUpXWWhRUTA4ajdrVVJWMWpkbWpIUUtPUFY3QXpVNlpV?=
 =?utf-8?B?ME8xR2tUZmxlM3AxbUJHRjBQQjNMVEZYemRKN0M1MUhWSnZOOXJOakdaU0Vk?=
 =?utf-8?B?eHJNSTdaMGZRNVViTHpBNmxBbXZHMEFBNmJEUXBQdlQ5Rk9ydWdiaS9xZkRk?=
 =?utf-8?B?c1RCdjRkbk5leCttSEtmNzlKa2hkYjEvaTE3c2ViODdzdmVHT0NDa1QzZXlu?=
 =?utf-8?B?amdUR29YbGtqblVra2JrWGFTU0IvUENtTU92bElQY2kzTGc4bGZidjUxdnFh?=
 =?utf-8?B?Tk5RSEtrNm1FUUNycmM2bk9iVVRoajdhaW5IeFdBUkgvY3JOYzI2cnNBVHcz?=
 =?utf-8?B?dVhWSjVsVzlYd3ZKOWRaTDhRL2FsQ3lITjhib3FLeDJsQitnTWJoVEVrcDB1?=
 =?utf-8?B?eXVrMWF2TjE4WTRUU0YrTUJrak5JSHFFS1RlZFR1YmZ6dGhXTWFzOEZraWJy?=
 =?utf-8?B?Y1Z3U2NzejZEcHMxM2NvNmZmdklnQ01wM0JNbDRZZmM0cFhRdlhZR2tpUnFU?=
 =?utf-8?B?UGYyVDVXTHRpelVnT3oxdkYyYndOTzRBbUJWVzBSQlJ2L0xnYXhFOXdEenJT?=
 =?utf-8?B?T0VVbW5XdStkUjNPQlFmeVFuMFZqRWVWK2dia0diZnQ3ZUZTd0JweWQwNDMy?=
 =?utf-8?B?b0txOVFBc2VMVXdRdGFOK2pDeFhBMUdzYVpUNWROSmowWW1vVHB1Ym5BYmpq?=
 =?utf-8?B?STlHbTVRQnhsZ3VZYUhwS3pSWldvQzRQRDIxTU05U3ZSR2RhQWpkSzZjVkxh?=
 =?utf-8?B?UXlNV2Rqdi9NRGRCSVJKL1N4UnpOcHdKV09Td2NyZjVHeGU4TER1NkVoZUJQ?=
 =?utf-8?B?L1Q5VG9SZ3dCK3dTRU1OYlZ2NmFKM05kaGlCQllCWmRCeUhoZlZGVG9DbzdR?=
 =?utf-8?B?emVNQlNFUkoxUyszazZ0RXlRQ1YrVnFhTDl3SjVJY3J1d0ZIRGNVcjE2VE8r?=
 =?utf-8?Q?CM8HLzKuLNWpslcev6Y9Ssm5P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b4456b6-c514-4274-006b-08de39cbcce2
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 22:14:21.3176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UupzMnWxldMgT/Og/6O/FOfpFMdTuukRM4QCMDs0sduK+rpzrvYWIr3FXgeqFvILJOOvucIx8ALGosdgOWHCgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6800

On 12/3/2025 4:54 PM, dan.j.williams@intel.com wrote:
> Smita Koralahalli wrote:
>> Reworked from a patch by Alison Schofield <alison.schofield@intel.com>
>>
>> Reintroduce Soft Reserved range into the iomem_resource tree for HMEM
>> to consume.
>>
>> This restores visibility in /proc/iomem for ranges actively in use, while
>> avoiding the early-boot conflicts that occurred when Soft Reserved was
>> published into iomem before CXL window and region discovery.
>>
>> Link: https://lore.kernel.org/linux-cxl/29312c0765224ae76862d59a17748c8188fb95f1.1692638817.git.alison.schofield@intel.com/
>> Co-developed-by: Alison Schofield <alison.schofield@intel.com>
>> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
>> Co-developed-by: Zhijian Li <lizhijian@fujitsu.com>
>> Signed-off-by: Zhijian Li <lizhijian@fujitsu.com>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
> Looks good to me:
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> 
> Thanks for all the work on this Smita, and Alison too, you have flushed
> out many issues and helped me through my blind spots.

Thanks for the review!

I will get started with working on v5.

Thanks
Smita


