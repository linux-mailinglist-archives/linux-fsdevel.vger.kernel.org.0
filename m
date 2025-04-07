Return-Path: <linux-fsdevel+bounces-45917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B44A7F05F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 00:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FEF97A64B7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 22:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77545224AF8;
	Mon,  7 Apr 2025 22:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oCkUpsQp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2072.outbound.protection.outlook.com [40.107.212.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4DA25634;
	Mon,  7 Apr 2025 22:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744065337; cv=fail; b=jd83GbpTWI9fU2ChMwd1Y3tHXSY+BoexCWhokru9+2ghko/yJGY1N8vp0YQzKfjOCM42376fl4sImE4mrOA3+9EJz3+lGPVEjNVzaO+eKU5WxyOmdKygNI3P0v3w59PELhCXQIkZCEkKN8+bP/iH8mYDFntv3yG0RbDf2l6L0fI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744065337; c=relaxed/simple;
	bh=G22wjVpJK2HSbybeP2KKJmDNyGlzYIupVRxS2yspRCM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e5fDdl6VzxU9Dxyp0Tts87F3mInosGmVB4qmzjeXerETFQuIJQRWx/0eCFiiXhHNoocZirj137KlWbvqkuW4rnZI0tTT1MgZqCp79qk6XUB/SXPKKlePwxJN/DgAIXH5yohlSShWQkNQMQKHwo9p1s+5hVk88JIaGtM/8TP5CYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oCkUpsQp; arc=fail smtp.client-ip=40.107.212.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZmNttzpufqVF6L/b9IHxNZiizDDu5pLIGtPcVRfWY9HgziIz8XXmMFNiM6p1GSNHRKSwOYWq1GvxYKLcQJPJjcNR0+8lCASR2zq6FKpQKhu5BZwW/GKcTIiux/T6cvxufywoLYvsCmk+A/79bMmc+hX1fph7IBpQDNML43z4V3RNnXi5S+Esg4RLCmuXpH07dzOEgGlNLtglru9SmCfZuZbQg8/Zi3nCJcohUFlNw0RUNarI3RDdin/heZPEgGarHj0QoMSqW7MMZQTOGCXHQGx7G7KIQiQD0r7w9isRL5Un2zuoXAo4UszxnKvNjtvdAcvVI7XtjOkaBjluKeX8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCSsBv7nEUuo3Htj7YSzx7OZ9zHd562GT9CElWxDRQY=;
 b=T72Bot9rRKk1WZ+TXdXM3i/RbH/b+HTR9B3tUetN/QUvgN3uerahxramf+byNotGg7DkG/kOG5V10usTgB1CrMPHYOo8B5SQ+rzdlYx2SntqVe8PbS2wS3rMVEzLUj7N5XeWLzpKSju+IBrSdWxX4a04KGquSsC5BwLc1go35blRtir09JSfH9vwuvVn5iF2RUD/A8G3vNV2XJbFRQmdQCphKgqd82qJUObrjJSj8wR8ioqsjxvRxVki6JVZV12ROOmWpO/7KOmY528tV9YwX18Pdo5sTMQ3pFrjY6aC7x5FSZ0BBIXs1DShJ/pxTlty0Mn8tK6liJdXE3heb3YcYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCSsBv7nEUuo3Htj7YSzx7OZ9zHd562GT9CElWxDRQY=;
 b=oCkUpsQp+fC/aG9Kep5lAPn7vO5ZG+Dh61hJtZhLcuuqqx1tLRhNvyyk+zpjwa2JuJlqIdzJpV4jyQRkMg4eSDvpkKmav6OhCdCrqHHw6TaSNCCfy/10lsqYsDtLoGw+kIzj+TzFQ6RIY4Zx60hDoEwmVQbhVE0MQl8Mcsi1oYM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SN7PR12MB7787.namprd12.prod.outlook.com (2603:10b6:806:347::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Mon, 7 Apr
 2025 22:35:33 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8606.033; Mon, 7 Apr 2025
 22:35:32 +0000
Message-ID: <6b999222-8a14-47f3-bac8-7af7efd79b12@amd.com>
Date: Mon, 7 Apr 2025 17:35:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] Add managed SOFT RESERVE resource handling
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 "dave@stgolabs.net" <dave@stgolabs.net>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "dave.jiang@intel.com" <dave.jiang@intel.com>,
 "alison.schofield@intel.com" <alison.schofield@intel.com>,
 "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
 "ira.weiny@intel.com" <ira.weiny@intel.com>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "willy@infradead.org" <willy@infradead.org>, "jack@suse.cz" <jack@suse.cz>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "len.brown@intel.com" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
 "ming.li@zohomail.com" <ming.li@zohomail.com>,
 "nathan.fontenot@amd.com" <nathan.fontenot@amd.com>,
 "Smita.KoralahalliChannabasappa@amd.com"
 <Smita.KoralahalliChannabasappa@amd.com>,
 "huang.ying.caritas@gmail.com" <huang.ying.caritas@gmail.com>,
 "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
 "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
 "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "gourry@gourry.net" <gourry@gourry.net>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "rrichter@amd.com" <rrichter@amd.com>,
 "benjamin.cheatham@amd.com" <benjamin.cheatham@amd.com>,
 "PradeepVineshReddy.Kodamati@amd.com" <PradeepVineshReddy.Kodamati@amd.com>
Cc: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
References: <20250403183315.286710-1-terry.bowman@amd.com>
 <00489171-8e9d-4c97-9538-c5a97d4bac97@fujitsu.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <00489171-8e9d-4c97-9538-c5a97d4bac97@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0070.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::26) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SN7PR12MB7787:EE_
X-MS-Office365-Filtering-Correlation-Id: fc4ec398-016a-4c80-69b1-08dd762481c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NmNCZlpJNE56eFAzY2JzZS9ycnZCRTJCaVBGNjJNa04zRlhVSllhR3BuOG5v?=
 =?utf-8?B?aDNLVFdpQWNlbUtRclZRZ1o2YmdqWU50WFdwd1V6dnpFeEZBVG5hZllqenJk?=
 =?utf-8?B?cVBadENiYnVEcXpTU0t4M0tsNHc3Mm9ZYVRuVEdhUk4yVEloeWJpTVo2cnBu?=
 =?utf-8?B?QTBoMDVCaFdlQTVXQVJRYXBHT2Q2TWxoTUFiRHJuRXlGcjc1UkxsRFVpNisv?=
 =?utf-8?B?RVpab0FKWjJ0S3JlNEkxQ2grQ1d3YjR5N091cjNaS0JJc0NMTi9MZnRUMkVZ?=
 =?utf-8?B?QUFhTWtSYkRaZ09nbHRZcVVoZWxCZlFCUEJGM0FnZjJTN0dmRXNzK2pkU1h6?=
 =?utf-8?B?WnhCVmVhenN0Zk5VNWpsUHBsUnNBcFRnZVpIeFpBQzBjVlplQjJqaDZ0cHdB?=
 =?utf-8?B?ZXJuMXFkRDUrd0NUdll0M1ZSNWJhNUt3KzNNeG5qOWVkamhIcDZSTFdmdmRh?=
 =?utf-8?B?anQ5SkRqUS8zc3hKWW5yTDN3dFZ3Vmloa3JVMXI4MUtYKzZLRTZMMERDeVcv?=
 =?utf-8?B?OG1zTmhySnRrNHJsVGlTNFpTSFhXaTNFUzJqRjd5YmpBaVFycmlCbDlaUWhS?=
 =?utf-8?B?aEZKVzNET1RodTZSYWJRdGM3OU9kcE5wUEpNKzRZS25IRTNXQ0xoRUNhaFpi?=
 =?utf-8?B?K1hCSS8zMzVsUVo0UU9TRnpOR09OWmZ5N2NhNytxVWZxWXhkcHlTclhhMVBl?=
 =?utf-8?B?cHZRUmpxR2JuSjlvOGpNbFB3TlpOS1hWMDRrbjV6MTlhNitNSVcxQWtoZzZk?=
 =?utf-8?B?ZGNUZE13aHdoZW5CbXRsY1dkbW5HM1ZwWWh4OVkxRUFrV0FGV0M5aktjVzRp?=
 =?utf-8?B?b3J6djd1clFaamdydU9VZENWbWdRbkZsdld1VkxjUlEzZEQyK214bkkvaWdm?=
 =?utf-8?B?eHJFVTV0NE16YlVGdjM3S2pJT0djRHJ4Y2ZkN3hWdk1YKzBOVUZzeVNRaFNB?=
 =?utf-8?B?V3NBNUxIemRqU05uMmdBMEtOeVU5VnRpMFZIWHBMS2xIOTJmSDhyRlZhYlQ0?=
 =?utf-8?B?NUM5bkNrZEpOSmdZVGJ5NXpNMzQwbFRTRCtIQ3B4TWlkd3lTdHQ0WW9mOUJu?=
 =?utf-8?B?K1RFc3JoRzJmR1NiWmZLVWtiNTBROUo2WkZwdE1vcFBCQlFhZ2JsTjhNakFu?=
 =?utf-8?B?NE9hMFFMTk9leEJUeWJkTnhQWmY4bWNqK0dDNXZacmhlelBZaVRBZ0Vid04y?=
 =?utf-8?B?Vi9zaU55eTNlbTV5cEV2UWtVTHc1TUtteDV3MDNock54ZndDdXNuQnc2VStp?=
 =?utf-8?B?YVp1dU52TWRLS0dGQVdGRXdPSFZPNk5MU293SGl2Wk0yeFZIY2VLZnkwOXR0?=
 =?utf-8?B?M0FPZXVpNlcyWGdtdTJ3YXY3eXpHM2hNT3NDK1pSYnhsUi9ZRzZ6K0tGYUlL?=
 =?utf-8?B?MGp3akRnSG1KVnZYY2N4TDdUdGhIdHRhSmNSdkUvbkd4aGsrRkc2MTRzeFo2?=
 =?utf-8?B?cnZTSVUxalRNTEZGbmoyNS9XbHFmU25ITDBjUkVSSGREajZiM2swMHdjL0hx?=
 =?utf-8?B?bFkzL3BZTDY0OGF4bk5lVFZkbXRHaTVFc0lBTHE3WlBxb0FUaUo2OEFmZmZQ?=
 =?utf-8?B?OTNmK1NVTzVtaldKbWZXa0dzdHhaNEFQQnhua1JHWDZUQ1cveEM2ZTlGOEt3?=
 =?utf-8?B?ZjdSMG1sZGdyUmJPQzZVNEswTGVSayswL29zRjJuZ3ZVZmhIbDQrWnFhN2xX?=
 =?utf-8?B?MkxZaWdJeGd2TlJFc0lzNjEraXU2K3dZenI5L2g2TTUyWXRlUE13cTRZUjNC?=
 =?utf-8?B?MTdSY2JtL0Y1M1lLdEZxMlQ1UXIwRjVTSmFPUjRJbW80MDBpcXRFY0hUejFS?=
 =?utf-8?B?NHkreEtZMGZINHdoZThacCtucXlPdWFwTFVyVmlwUHZYUlZSYzlocTh0Si9k?=
 =?utf-8?B?dWtycS8vdDNLZHhRejlWeDFLdXBrRHV3bUlOYVdHeWU4anF4c1hibkdScHpW?=
 =?utf-8?Q?xWmOTL39+rw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUV0QjRJSVk0ZEpLZCs5UkVGNUd0Y0xsQm0zeU5BK1BnWFc3NGpYVEpVOXdS?=
 =?utf-8?B?QkJiUXl5WFFyMGFJZUNESEJhVEM2WjNHTWhxR0NYZUptVU0zRi9LUTFhVTR6?=
 =?utf-8?B?MlN6UisyWUdjZEVLajAvL3dCZzJpZ0creVlJOGoveVVLQ3o1NVJLdUwyRi9M?=
 =?utf-8?B?amd6OTBUYkY5S3ZPWmEyM05vUG1DTzdWV09DNytiQkVZdittTzVOekdyNjhY?=
 =?utf-8?B?cWh2Y0pVM1lQLzA5K3VPZEo4ZDR5Y2dneEJFc2JJa2c3ZnNCMGllWlljVmYy?=
 =?utf-8?B?QXpZMlgwc3p0SXpSelFvTGJEa1RZQmJEVjkwdGQ0RzcyYnhsY1ozR2RmZWd4?=
 =?utf-8?B?RDNSU0xPNnVpY3VHMncxTk5tVklNUWlVVWkvcjhFWWNxRWRJSEVRT05ON2xC?=
 =?utf-8?B?MDlmdlFFQU9Cd08xWkxZeE5Va3EzVHBrU2dJbXhXWmhTWVNnM0d0dklhNzNQ?=
 =?utf-8?B?NzBMajNGeDU4L0NKS1NwMnYreXRyTlgzTzZzaGhMbWp6cFpiNVV2M0t0THhw?=
 =?utf-8?B?c3hiMmo0c3lCMlliekU3RVhYQVBRdE03MFVBSDlUYUVjRjdoUGRkb29kSTd4?=
 =?utf-8?B?SW9uUnhZbFBOajg4aXpUWkFNN2pOQ1dyODdna2x3ZVA5RUlPamZQbWd1L2RH?=
 =?utf-8?B?bHUrSEFMMEpFai9jQyszdTJzaWJEUEN5dW1RNFlFVnZCVGxPN0FPOXJqekF1?=
 =?utf-8?B?Ry80eTZPajNNeHI4R1B3R2luV3hLOXVROE1pc1pmV3JMYnRGUTFpUE9uU2lS?=
 =?utf-8?B?M1JXWStMa29YN0tTTTIvVDVuNVVUN2lTeVBZendjZHE2endHK3dDMkV3NkhN?=
 =?utf-8?B?SUJJZjhTYTNMaHRGSjVQVTNsY0JlNG5BS0gvZlp5bUlzcWtJWDY0UnJHVWh2?=
 =?utf-8?B?MnhITTA0Sk5vYWE4VDFnLy9xZXVYV1BQSkY0VGg5UXo5VGZ5c2RrMWYxRDVP?=
 =?utf-8?B?bVh5T0gwbWlUWDg0Y1M0aXFZeDFYdW9SVmFCUzQ2VzdndDM3T2VKc0dBY05H?=
 =?utf-8?B?RFZtRkUvVUlzYjRXTmx3K0szaHZKYzBMV0kxNkREK1NmMDh2RDNGY254V0hZ?=
 =?utf-8?B?UXplRDduQWpNejJESE1EYk5qS3lsS0Vjb3RvK2xOQy9yQnEvd1hNRVNZSG9u?=
 =?utf-8?B?dkRRd041a3pObkRndlNnU3RTYzQrNFBJazZnTXJQWUNUQ1V0MDZHQnVXSUFN?=
 =?utf-8?B?SHBCNE1yT2NBWVk3bU1Vak1SN1d1SmlrUitFTCtMaTlCblFvRkR1S0g0cEQv?=
 =?utf-8?B?elpYbFVXZFRmakpoeUZSeGk3Z1R5NXhHYkJMeTlvWUdva1hVdlpLV3lZUzdm?=
 =?utf-8?B?UmNVTHRIZHBjT3JEWktLTjBqS013ZnhJZ2F0Slo2S2JacFhhUEhuZXAva0ZE?=
 =?utf-8?B?ZGhYcUZlSkszOWE2UFNpOTNFajRBd0lGOTRzOW96TWlxZ3FSc1p2SW5oc0Nq?=
 =?utf-8?B?S0tRRnZIQThXV3lWUUFhb3ptUWpGR2xCajAxK2psdjVZMXNDSERzSytBU3dh?=
 =?utf-8?B?Q3pKejJKbEdMNllRNUhmbzZMYkRqcmVITjFYcXVmZEpTakZNMmlwYTdKdCt4?=
 =?utf-8?B?cHdvTklCcENMcGg5THdJRkUwaFFoSWwxRzAxUlFpQzFxenJOZHFLRFdiY1Vr?=
 =?utf-8?B?TTRhSTRlWDlOdVQrTVljVXVOWndTcWh3NDZXZVlLRUdlTmwwT3pudGVRS3E2?=
 =?utf-8?B?WkRnb2MyakpZUkF3bWUxd2JjdTNmL0hmbFdXZ1V4TlBFZVREaktYTERMM1BT?=
 =?utf-8?B?WTJDcVVIK2l2MXJLWVlvYnpPUE9tNWo5TkdBWGdrZVUrb2lUeDdLZ2E2Um9k?=
 =?utf-8?B?dFEwSFZJdkszQlZIRzBZeCtCVlAxRnJ1L3FkbXIxbllXOFFtRUxnUXlRQnJ5?=
 =?utf-8?B?a1o3L1YrZUZGbktmOUVQRlBpc1FGSTY4VjV4NGlxZU12TDB5cnRTSXA1N1NZ?=
 =?utf-8?B?TU44U2ltQm9KNmt4RUxjZGliZ3I5eDBtSTZMN0hHZ2NwYjF3dldwOVNSQThv?=
 =?utf-8?B?aVJOZUhNWk1vVFRlU0M5YlEyaTQzQW5ISFZ6UGVqQXo5RjhLa2NySnQwSVpO?=
 =?utf-8?B?L0ROYkNBVHVYR1JOUW9neHgrSnNQN0paZWpaRE9DY0hmMWVaU1d3eCtxSVVW?=
 =?utf-8?Q?0EqKblKOTlErC3jUd9nBQCFqC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc4ec398-016a-4c80-69b1-08dd762481c2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 22:35:32.6994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kreeOfag+jk4yG8CakoYShFc/b0DevdNnUL0Wk1QDIdsy7H0OlFbYcI5KXpRbfxaxNHIZwwpIuR3THx9UkHbwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7787


On 4/7/2025 2:31 AM, Zhijian Li (Fujitsu) wrote:
> Hi Terry,
>
> If I understand correctly, this patch set has only considered the situation where the
> soft reserved area and the region are exactly the same, as in pattern 1.

Hi Zhijian,

I'm working on example test case(s) for your questions. I'll respond here.

Regards,
Terry


> However, I believe we also need to consider situations where these two are not equal,
> which are outlined in pattern 2 and 3 below. Let me explain them:
>
> ===========================================
> Pattern 1:
> - region0 will be created during OS booting due to programed hdm decoder
> - After OS booted, region0 can be re-created again after destroy it
> ┌────────────────────┐
> │       CFMW         │
> └────────────────────┘
> ┌────────────────────┐
> │    reserved0       │
> └────────────────────┘
> ┌────────────────────┐
> │       mem0         │
> └────────────────────┘
> ┌────────────────────┐
> │      region0       │
> └────────────────────┘
>
>
> Pattern 2:
> The HDM decoder is not in a committed state, so during the kernel boot process,
> egion0 will not be created automatically. In this case, the soft reserved area will
> not be removed from the iomem tree. After the OS starts,
> users cannot create a region (cxl create-region) either, as there should
> be an intersection between the soft reserved area and the region.
>                               
> ┌────────────────────┐
> │       CFMW         │
> └────────────────────┘
> ┌────────────────────┐
> │    reserved0       │
> └────────────────────┘
> ┌────────────────────┐
> │       mem0*        │
> └────────────────────┘
> ┌────────────────────┐
> │      N/A           │ region0
> └────────────────────┘
> *HDM decoder in mem0 is not committed.
>                                        
>                
> Pattern 3:
> Region0 is a child of the soft reserved area. In this case, the soft reserved area will
> not be removed from the iomem tree, resulting in being unable to be recreated later after destroy.
> ┌────────────────────┐
> │       CFMW         │
> └────────────────────┘
> ┌────────────────────┐
> │   reserved         │
> └────────────────────┘
> ┌────────────────────┐
> │ mem0    | mem1*    │
> └────────────────────┘
> ┌────────────────────┐
> │region0  |  N/A     │ region1
> └────────────────────┘
> *HDM decoder in mem1 is not committed.
>
>
> Thanks
> Zhijian
>
>
>
> On 04/04/2025 02:33, Terry Bowman wrote:
>> Add the ability to manage SOFT RESERVE iomem resources prior to them being
>> added to the iomem resource tree. This allows drivers, such as CXL, to
>> remove any pieces of the SOFT RESERVE resource that intersect with created
>> CXL regions.
>>
>> The current approach of leaving the SOFT RESERVE resources as is can cause
>> failures during hotplug of devices, such as CXL, because the resource is
>> not available for reuse after teardown of the device.
>>
>> The approach is to add SOFT RESERVE resources to a separate tree during
>> boot. This allows any drivers to update the SOFT RESERVE resources before
>> they are merged into the iomem resource tree. In addition a notifier chain
>> is added so that drivers can be notified when these SOFT RESERVE resources
>> are added to the ioeme resource tree.
>>
>> The CXL driver is modified to use a worker thread that waits for the CXL
>> PCI and CXL mem drivers to be loaded and for their probe routine to
>> complete. Then the driver walks through any created CXL regions to trim any
>> intersections with SOFT RESERVE resources in the iomem tree.
>>
>> The dax driver uses the new soft reserve notifier chain so it can consume
>> any remaining SOFT RESERVES once they're added to the iomem tree.
>>
>> V3 updates:
>>   - Remove srmem resource tree from kernel/resource.c, this is no longer
>>     needed in the current implementation. All SOFT RESERVE resources now
>>     put on the iomem resource tree.
>>   - Remove the no longer needed SOFT_RESERVED_MANAGED kernel config option.
>>   - Add the 'nid' parameter back to hmem_register_resource();
>>   - Remove the no longer used soft reserve notification chain (introduced
>>     in v2). The dax driver is now notified of SOFT RESERVED resources by
>>     the CXL driver.
>>
>> v2 updates:
>>   - Add config option SOFT_RESERVE_MANAGED to control use of the
>>     separate srmem resource tree at boot.
>>   - Only add SOFT RESERVE resources to the soft reserve tree during
>>     boot, they go to the iomem resource tree after boot.
>>   - Remove the resource trimming code in the previous patch to re-use
>>     the existing code in kernel/resource.c
>>   - Add functionality for the cxl acpi driver to wait for the cxl PCI
>>     and me drivers to load.
>>
>> Nathan Fontenot (4):
>>    kernel/resource: Provide mem region release for SOFT RESERVES
>>    cxl: Update Soft Reserved resources upon region creation
>>    dax/mum: Save the dax mum platform device pointer
>>    cxl/dax: Delay consumption of SOFT RESERVE resources
>>
>>   drivers/cxl/Kconfig        |  4 ---
>>   drivers/cxl/acpi.c         | 28 +++++++++++++++++++
>>   drivers/cxl/core/Makefile  |  2 +-
>>   drivers/cxl/core/region.c  | 34 ++++++++++++++++++++++-
>>   drivers/cxl/core/suspend.c | 41 ++++++++++++++++++++++++++++
>>   drivers/cxl/cxl.h          |  3 +++
>>   drivers/cxl/cxlmem.h       |  9 -------
>>   drivers/cxl/cxlpci.h       |  1 +
>>   drivers/cxl/pci.c          |  2 ++
>>   drivers/dax/hmem/device.c  | 47 ++++++++++++++++----------------
>>   drivers/dax/hmem/hmem.c    | 10 ++++---
>>   include/linux/dax.h        | 11 +++++---
>>   include/linux/ioport.h     |  3 +++
>>   include/linux/pm.h         |  7 -----
>>   kernel/resource.c          | 55 +++++++++++++++++++++++++++++++++++---
>>   15 files changed, 202 insertions(+), 55 deletions(-)
>>
>>
>> base-commit: aae0594a7053c60b82621136257c8b648c67b512


