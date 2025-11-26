Return-Path: <linux-fsdevel+bounces-69858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D952C87F1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 04:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9541335379C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 03:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E8230DEBE;
	Wed, 26 Nov 2025 03:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CWOsq7FO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010017.outbound.protection.outlook.com [52.101.201.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16EFFBF6;
	Wed, 26 Nov 2025 03:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764127426; cv=fail; b=lbCir5wXL99/Fw9jhNGjTIulUGWVXR8vHm9emyImnv98W/yyDR0e5rVFBNjlieeKQrCPzIWPB9DNCClFH5seILempr9qQUBrnBnotELuIHc1KfVWtZGPOlyGqmqm3lbjKvKjI8ZxMCEHVDP2i6fzaKqPOBey3X/cJGgqZgEmhxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764127426; c=relaxed/simple;
	bh=j375bEqV1OZL17+smwNOXsKQWFMZ6V6DiiC4DO16hE8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TtJDErX5TF5hvdEAqP3IpjmIRvgjyjKBWOdGlpBbDOxc9qxkgQX+cK+uaI53+DiLuzxnsju3dr/aUzqyyL5oMVJ7gHrtgIUNdZWXONu5f7feDfthdoPWinlW49FfqULbWK6lBVAtj5jplM8XtgGdDgqpRBvN75aS84UaRu7y+xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CWOsq7FO; arc=fail smtp.client-ip=52.101.201.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xYZa5sxFSoiinvY27geskBGBGwZ/sF2ivgYoYz79QjSimTUjk8kDAk8bioAl35R5QQApRl2LO96PaFhysOGS81/Lm0OJfnlbLXfvAzIUry5SHr/xluwuXEWEmEIteL3CWDnh1vCVXMAmPxZb5tQexxnXWyLflTCceRY6nfeG41qdbUjoqxS7f03oFmMpF5LQsUL2nAaWJu3ZMi/xqqX8n2+3IGwNImm7PnFvmWAcdj57dZztibaX1QIoWhEiV8J80aqmqOuQ3ZINgI010B3/yWSWwHJpRdZDaa6uoh/ByDl4YLVMn1x61SZ81LMUIV5erkUcRU9COzXqYD53AlvZ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q5AlDZB60EV6/XCj/+oPLqDemGoh86mKAfTF0r+hLEA=;
 b=Yqo1itag2AiiX41Cs040oC/L7zgaGnxR/tt9l3QbPeoihH+iJfpXIk+zJKNReFEiwUx/EjdPNgZS4TzYkGMzrVSQionz4i2EKbwJLHbJFuvt1BHaJOcErE3uEee3hQEo2LSfk4Rh+EbBxdoDgSOlxZSBF+WMt9cC2kFDORIv88fa+LNbGqb4tkIjIx69jYmYyO0Vz8KexFtySdcpDjpBe63PsZ6uM/nn9UFIG/EnEvn35v4YkEQRtb8noB68YsUCEri83hga4CTBrC+7VIHX68Rjc5wB5HQNqqf0Tno7ZsMOpeX9lSV0Qwa8vCqa/K6AmaRKTCut2fnDR9AAAGsKVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5AlDZB60EV6/XCj/+oPLqDemGoh86mKAfTF0r+hLEA=;
 b=CWOsq7FOJTppXSPzIGkT7RlxaQbWF+XZQDTNAht3p8Xo1Y14fIG4uHosbZzajvFjexbU06qIn+cz32+9rFkfXIJhxbmBIzXEN5ex9pESiqOEnQEAYwRXJwgGj84ibzEg6RmIIR9RHmTqbxag1liOm2D608SxecNG4cJwTgRaaElR+v8yvw2MPYDRKWHZW541JIkesN/0Ypu8fxpsFZEjZykLhQSkpQWWXcePk/CTF6mPndODvbZhWRh9bifsk68Kk7fevK0LnEDvzw0Zifszcu1epdwbVGCR5v+r9/B+2OBNrNIfTeedJYb/hDbFK/sbHnSwbAVheczwA2LAFCAv6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 03:23:38 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%7]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 03:23:38 +0000
Message-ID: <48078454-f441-4699-9c50-db93783f00fd@nvidia.com>
Date: Wed, 26 Nov 2025 14:23:23 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC LPC2026 PATCH v2 00/11] Specific Purpose Memory NUMA Nodes
To: Gregory Price <gourry@gourry.net>, linux-mm@kvack.org
Cc: kernel-team@meta.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, longman@redhat.com, akpm@linux-foundation.org,
 david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 osalvador@suse.de, ziy@nvidia.com, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
 ying.huang@linux.alibaba.com, apopple@nvidia.com, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, kees@kernel.org, muchun.song@linux.dev,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, rientjes@google.com,
 jackmanb@google.com, cl@gentwo.org, harry.yoo@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 zhengqi.arch@bytedance.com, yosry.ahmed@linux.dev, nphamcs@gmail.com,
 chengming.zhou@linux.dev, fabio.m.de.francesco@linux.intel.com,
 rrichter@amd.com, ming.li@zohomail.com, usamaarif642@gmail.com,
 brauner@kernel.org, oleg@redhat.com, namcao@linutronix.de,
 escape@linux.alibaba.com, dongjoo.seo1@samsung.com
References: <20251112192936.2574429-1-gourry@gourry.net>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <20251112192936.2574429-1-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0113.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::28) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|PH7PR12MB5685:EE_
X-MS-Office365-Filtering-Correlation-Id: c8fe04b9-7538-4566-0acf-08de2c9b30c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|10070799003|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RU9qUC85NUZBbHRNUVpmaWZsUzVRL20vbzNnSXZHL2xncFQrVEJ4Y0g2Sy9q?=
 =?utf-8?B?d3ZOd1d4NXhoK3FmSy9uemFnOGJuUVV4ajZVN096eVp2ME9jL05CZ1A3VUVj?=
 =?utf-8?B?NzYzd0pGZGZLMFRwcDIyUkpTZXpqSmEwcjE2aFBlM05UbzJlR2I1TnVBaFI4?=
 =?utf-8?B?bmJuQXo5UWhKTmFXcTBuODNzWFBFNlorR2I5UDBKL1ZvUStPeHl6S1VMT1dh?=
 =?utf-8?B?V2hXNHZGQ0hJUkszL0U4cnYzMmtwcFdBaHVkZEYxb1VaUTRiMVVWd3A1YXJ6?=
 =?utf-8?B?ckZoQU5xQ25QRmJjK2daMURxalcwYWhxVmVIc1JHSDFscHhvYmhIU2pWM0lo?=
 =?utf-8?B?S2RVTGhiTWNPOGV5a0hlSU1qNzZnbVRpdWMwSlZvT3FLZ3FuOHZFMlNRNi9x?=
 =?utf-8?B?a082MGMvaGRkVThLK3VnNFdRWTR5NTFVVEFwbG1YUkthczgxTnBUVmxyMzVY?=
 =?utf-8?B?NjhmRkQzQW5BWUc5NC9GV1IzcmdycGdjR0lLRndPVks4bWt2N1hncXlYQ2Z4?=
 =?utf-8?B?RkFDSkIra0VtQ0lJMk0rMExXanBMbVppSDBDSFFaMlZBYTNQLzlGckR1bUpG?=
 =?utf-8?B?RDhkRy8yQTFRTG5NZmtuZVZHcEpuVGhzS3BrTE16dTN5aDNRSFVDWEdmUjhq?=
 =?utf-8?B?N0gwVXZla1FSelJIQUtaNUwxUmNFN1dKaElEU081UEVRUGRna1pqbFhoVkhv?=
 =?utf-8?B?cmR6cFhrclc4RFg0TXBSTENpSzYzRFM3N21RaktRZ1pHTUhTMWhwcTA1cEZr?=
 =?utf-8?B?T0ZkVEtJcDk5eGRGQmpXQjE0c1ZJcmtKdi80Qmd5aEtUbGxsUmlBWU1POVk5?=
 =?utf-8?B?MllZKzhqRHd5eU1YUEtkcno1L1p3ZFJ6Y1V3U3hzY1pmUHU3QkI3ZzBYdnFD?=
 =?utf-8?B?TU9GNTI5d3JSa3lrN0dYQWZWRDA0UWZzRzZlU3JjVXNPNWtVQmoyNkQvUXQz?=
 =?utf-8?B?TjdGTHNoMWNiTXVoNjY1WnhLdi9zeFhSaWV3Wlg3ODAxSVdMRWJLMWc5VGRZ?=
 =?utf-8?B?TUx1NEdINWJiNDhvd2JBemhvV01sQ25UdC83R2IzUy9JREhmaStTamFWVkxm?=
 =?utf-8?B?OXVNaFB2WTJtMWJEYzI2cERUQlZYd1BNUksxY2lPZHQvTUcyT1lCbXFtb1Rz?=
 =?utf-8?B?YjU2QVdXVXRzVHlINGt0THJoZldRZTdJejArKzJ2SlRwRFZtVXQzSVdFL094?=
 =?utf-8?B?cmFUQnkzTHhRMjFhaVZ3akkyeDNPTEdnR2ZrQzNhSklhcjh5UW5zL1FCWGNj?=
 =?utf-8?B?U3J6U2NUeUIxblZCTVlQMXQwcllQNUNpeWo1Q0FKT1ZiOTBleS82dVNhQjlX?=
 =?utf-8?B?eVlKZ0lac1B0Q0pYOGtDMmRCTmZKZVF4QW9ZUjRYNVFnTFRtMm8wTGRKY3l4?=
 =?utf-8?B?V1NFUkFpcWNTengzeDRyUFloa3B2Ti9iOW9aWXk2emxmK1JBKzNCNjU4ZzBq?=
 =?utf-8?B?RTcyRC9uS3RJSXNwM1lsWnNvL1h2QTJMaSs3WmRWWG91TGtiK1M3SEhEMTZQ?=
 =?utf-8?B?SVZyd2NBVURxVkgvRVEzbG5Xc2tCUXRHaG1YYmlUN3piN0dVYm1CTFF2SWVI?=
 =?utf-8?B?NVhtaWdSZHBpQTFwZHhXM2E4cWM0WE40bGkySFJYOVFIRGRlN2RvLzhHSXhr?=
 =?utf-8?B?cVNKSUVPSVp3cnBMakloQkc2VlNobWc5ODNVYlFsTmFVWVR4cm5oQmNJQ3Mz?=
 =?utf-8?B?Rko4OEMvUWhBWVZiQWhwV2lHV1lSNkhqelhRWjlPUG50dFRmOUtOc1pyYzdu?=
 =?utf-8?B?VkFLcHBKMkdYUFYvcXRGK0N1b2ZrVno1emFTZitBV2FWeWdCUEZoMEpoSUht?=
 =?utf-8?B?WFpBd1Z6VzVncnYwN21nY3lIRlcrYmJveERHaFIyUjRjb1FhUFNPQktKZFBK?=
 =?utf-8?B?dXJmM1JhTkFVeFRVVnVzTDdoMHV4di9hN0pXbThpRUsrZzVCWitFNmpUd2xQ?=
 =?utf-8?Q?mQO6R1cGD+nbCyJU4dPW9/d5ENcMx558?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2lpQkN3N3c1QjdNMHU0dlg1SWFMeWVxaE5WTkhqYkRyVTc5SWk1T3IrU2NY?=
 =?utf-8?B?WEpFUjRwTnJxMGRWTFBTc2Q0YUxocVZMbnFSZFpORlM2MGp3THdpMzFXUEJu?=
 =?utf-8?B?MUhSRkFKN1lDT3k4ZldVOFA3MHhSMk82cE5qb1dpQ0NURDhtcWhqVFpDMTdo?=
 =?utf-8?B?U3RMSFhXVGxFTWRJbnhQcTVNeFVIait0U1BBMTZGLzIwaiswNmtNUCtzaFdO?=
 =?utf-8?B?bHc2MmtPM1Y0WDE0bXlqQ082bFJCUnNHeE9FbG5LQ2d2UWs4Mmt2bnB5bzJz?=
 =?utf-8?B?alByTkZReWpUYkd6Qk1vNXp3RVc1S3g2cSt6d01zdlkvWnZOaU5LUDZwVm5F?=
 =?utf-8?B?MmFXKzFkYkYxTUlpR1pocFBBUHYrYWN0eXFOVVhSUGJ2RndEN2p2SXNORnlW?=
 =?utf-8?B?QlB5R0RVU21ISytVbmhxWkdKaElqck1BbEhabExQTUVjZTVPOFFadjl1WWU4?=
 =?utf-8?B?Tzh4Wm1RcFM3a0tvWElqUktxak5pVmxsaEJvdngwNVZFbm5XV2kxaHVEQTJU?=
 =?utf-8?B?cy8xZ01XdmpvcURJM1lwNkVPa1J2Y0MrdzZuRWttaVBDS1B3RmZCWjY4WVlQ?=
 =?utf-8?B?cE1aQ2NxQnVhWEdDZEl4MG1qYm1Ja1NCa25uUWJoWmhIRnJyN2RlWU93WGNs?=
 =?utf-8?B?NTdaYk1zWVBTRXkxbzd1Z0dZaU01VkZrakcvc0FZMGhkbkswUll5eHNUNWEy?=
 =?utf-8?B?eHBtK2hoNlBGZ09rdWsxUVhDU0NLT1NPaHY4SEtnWm5JMm1WSHMyOTRwZUxp?=
 =?utf-8?B?dmFCcEpnb0ZHblVqSXE4eUEvUEN1MklLVllUZlpieENnRUFGMU40YUdrVUtS?=
 =?utf-8?B?dUFBL0MyUHREQnhXalVXeUVwNEErSFF5Y2dVbUNrbkVndVg0eHV4QjVHWEtT?=
 =?utf-8?B?QStRWDIyeXJNWXpwNnFBcmxuTlUyTUJNc01uYjF2c2I0OWZQVHVxM0lGTUVM?=
 =?utf-8?B?SUdnOHVBUGM1RytqZFM4MWJKTHIwRFhzYU1PenBjTW9sZlMxZWhOTHpuQ3p1?=
 =?utf-8?B?N1dPZ0tReTZpSFNROEc5SERIMFVIQno5ZDRTeGVuTHdFZWdGNHpieXc4VXp4?=
 =?utf-8?B?NVk5UEpvanBlTFEvaDVuVi9qUjZIdHgvMXkzMEtlbTBJRlRtYUVJZHVzVnpO?=
 =?utf-8?B?a280N2pma01haVJFaDV1SjVuTmE3ckR5Y3MzVzMxTDFlOHU4SW5yZ1E3VGZJ?=
 =?utf-8?B?T0JLbmRuTzlYOHZDalR2THFJU0pMcXVydzVpcTAvRHhTTHZ5aUJzNGFxTjhE?=
 =?utf-8?B?OGZoTWRwNHI3R05NV1pON2x4WWp1Vko4UjlXOVVQeGplWTI5ZUxuR21OMmdv?=
 =?utf-8?B?T2R6dTlWZE5Fem9kVGljYmwwNnZvWEFiMGNVTFRPYXpxQXRPUm1FZWhYZEVL?=
 =?utf-8?B?c0hSVXNUQjU1TFU0ZTlKT3gvc2hVekN2UGtHeXVoazBWY2svVStpYkNaOWhx?=
 =?utf-8?B?VXQ4c21OZVBnNFdEQUg1amp1eTk2WHhEU0w3dmlxdUIxUW5VelFGRGJ5bzV1?=
 =?utf-8?B?NTJHNDNuWGRaNzZsazAwcmYzMjh6eWRwUUoxcFhvWmRLMlRRY0k2UWdvV2Ex?=
 =?utf-8?B?MHhSL01PbTQ5TmZvMTNadjZyK0wxUno4R0p1c3RGMk04Z2V2Vjl2Q3BHbW9V?=
 =?utf-8?B?SE5DS3FENHEwcE5KL1dmaXJwZFpxclBSKy9IN2xhK2ZXWG90cFQrS1FRZ0da?=
 =?utf-8?B?OHZ2c0xJTHFBS2t6WUU1MDJyN3E1a2I5ejRBSXpKTHhGSUtLVmNNSWYzWEMy?=
 =?utf-8?B?THRGdWNLUHFRTzMxTDJDWmlwTFNJWWFEbmxJN3EvSnM4STdMMHV6T0diYkV2?=
 =?utf-8?B?dlp6emtQNWdqOTRhV0QzLzIyQTgwb0syak1XZ29Cc2FhVisvYlBVdUhtL2JF?=
 =?utf-8?B?VjI4aFB3NE5EbzJiMlo3eU9GRWpPKy9nMllLbk53SGhOOHFXWGZDOGdXdG5t?=
 =?utf-8?B?U0RuVXVINTZ0MFlaM3UrT01NNWZJa0JrenJUZUY2a2ljb1ZZVUxwYXMzd0Rq?=
 =?utf-8?B?MFpuU0VUZWx6U3dSQXdVdCs3RHNJTkc0ZEozU3d0VVJidW5LL0RCZ3JUVVZD?=
 =?utf-8?B?SC9WZ1liOGtjQ005azFYUVZodVJBdWk1Tmw3c04zcnEwbzhmQVZ2bWZ4K2ti?=
 =?utf-8?B?dGVUZloxaFhYcWFHWkFVdzB5ZHp0N3p3eHJjZG1UWG1ZV3RaMjBteGc4ZTFD?=
 =?utf-8?Q?YUeWSJ8YHXhmR5NXFP16Z06dRKLLwvOCJhuD3uT9IgAA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8fe04b9-7538-4566-0acf-08de2c9b30c9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 03:23:38.4669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rdggnbnw5wn0wYzbnc4Im1Lqh+D2ORoBOPmWVZheYCph1DFxppz0SH39tyJupoq8rLdgjK7u/boTkHGWcWxSQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5685

On 11/13/25 06:29, Gregory Price wrote:
> This is a code RFC for discussion related to
> 
> "Mempolicy is dead, long live memory policy!"
> https://lpc.events/event/19/contributions/2143/
> 

:)

I am trying to read through your series, but in the past I tried
https://lwn.net/Articles/720380/

> base-commit: 24172e0d79900908cf5ebf366600616d29c9b417
> (version notes at end)
> 
> At LSF 2026, I plan to discuss:
> - Why? (In short: shunting to DAX is a failed pattern for users)
> - Other designs I considered (mempolicy, cpusets, zone_device)
> - Why mempolicy.c and cpusets as-is are insufficient
> - SPM types seeking this form of interface (Accelerator, Compression)
> - Platform extensions that would be nice to see (SPM-only Bits)
> 
> Open Questions
> - Single SPM nodemask, or multiple based on features?
> - Apply SPM/SysRAM bit on-boot only or at-hotplug?
> - Allocate extra "possible" NUMA nodes for flexbility?
> - Should SPM Nodes be zone-restricted? (MOVABLE only?)
> - How to handle things like reclaim and compaction on these nodes.
> 
> 
> With this set, we aim to enable allocation of "special purpose memory"
> with the page allocator (mm/page_alloc.c) without exposing the same
> memory as "System RAM".  Unless a non-userland component, and does so
> with the GFP_SPM_NODE flag, memory on these nodes cannot be allocated.
> 
> This isolation mechanism is a requirement for memory policies which
> depend on certain sets of memory never being used outside special
> interfaces (such as a specific mm/component or driver).
> 
> We present an example of using this mechanism within ZSWAP, as-if
> a "compressed memory node" was present.  How to describe the features
> of memory present on nodes is left up to comment here and at LPC '26.
> 
> Userspace-driven allocations are restricted by the sysram_nodes mask,
> nothing in userspace can explicitly request memory from SPM nodes.
> 
> Instead, the intent is to create new components which understand memory
> features and register those nodes with those components. This abstracts
> the hardware complexity away from userland while also not requiring new
> memory innovations to carry entirely new allocators.
> 
> The ZSwap example demonstrates this with the `mt_spm_nodemask`.  This
> hack treats all spm nodes as-if they are compressed memory nodes, and
> we bypass the software compression logic in zswap in favor of simply
> copying memory directly to the allocated page.  In a real design
> 
> There are 4 major changes in this set:
> 
> 1) Introducing mt_sysram_nodelist in mm/memory-tiers.c which denotes
>    the set of nodes which are eligible for use as normal system ram
> 
>    Some existing users now pass mt_sysram_nodelist into the page
>    allocator instead of NULL, but passing a NULL pointer in will simply
>    have it replaced by mt_sysram_nodelist anyway.  Should a fully NULL
>    pointer still make it to the page allocator, without GFP_SPM_NODE
>    SPM node zones will simply be skipped.
> 
>    mt_sysram_nodelist is always guaranteed to contain the N_MEMORY nodes
>    present during __init, but if empty the use of mt_sysram_nodes()
>    will return a NULL to preserve current behavior.
> 
> 
> 2) The addition of `cpuset.mems.sysram` which restricts allocations to
>    `mt_sysram_nodes` unless GFP_SPM_NODE is used.
> 
>    SPM Nodes are still allowed in cpuset.mems.allowed and effective.
> 
>    This is done to allow separate control over sysram and SPM node sets
>    by cgroups while maintaining the existing hierarchical rules.
> 
>    current cpuset configuration
>    cpuset.mems_allowed
>     |.mems_effective         < (mems_allowed ∩ parent.mems_effective)
>     |->tasks.mems_allowed    < cpuset.mems_effective
> 
>    new cpuset configuration
>    cpuset.mems_allowed
>     |.mems_effective         < (mems_allowed ∩ parent.mems_effective)
>     |.sysram_nodes           < (mems_effective ∩ default_sys_nodemask)
>     |->task.sysram_nodes     < cpuset.sysram_nodes
> 
>    This means mems_allowed still restricts all node usage in any given
>    task context, which is the existing behavior.
> 
> 3) Addition of MHP_SPM_NODE flag to instruct memory_hotplug.c that the
>    capacity being added should mark the node as an SPM Node. 
> 
>    A node is either SysRAM or SPM - never both.  Attempting to add
>    incompatible memory to a node results in hotplug failure.
> 
>    DAX and CXL are made aware of the bit and have `spm_node` bits added
>    to their relevant subsystems.
> 
> 4) Adding GFP_SPM_NODE - which allows page_alloc.c to request memory
>    from the provided node or nodemask.  It changes the behavior of
>    the cpuset mems_allowed and mt_node_allowed() checks.
> 
> v1->v2:
> - naming improvements
>     default_node -> sysram_node
>     protected    -> spm (Specific Purpose Memory)
> - add missing constify patch
> - add patch to update callers of __cpuset_zone_allowed
> - add additional logic to the mm sysram_nodes patch
> - fix bot build issues (ifdef config builds)
> - fix out-of-tree driver build issues (function renames)
> - change compressed_nodelist to spm_nodelist
> - add latch mechanism for sysram/spm nodes (Dan Williams)
>   this drops some extra memory-hotplug logic which is nice
> v1: https://lore.kernel.org/linux-mm/20251107224956.477056-1-gourry@gourry.net/
> 
> Gregory Price (11):
>   mm: constify oom_control, scan_control, and alloc_context nodemask
>   mm: change callers of __cpuset_zone_allowed to cpuset_zone_allowed
>   gfp: Add GFP_SPM_NODE for Specific Purpose Memory (SPM) allocations
>   memory-tiers: Introduce SysRAM and Specific Purpose Memory Nodes
>   mm: restrict slub, oom, compaction, and page_alloc to sysram by
>     default
>   mm,cpusets: rename task->mems_allowed to task->sysram_nodes
>   cpuset: introduce cpuset.mems.sysram
>   mm/memory_hotplug: add MHP_SPM_NODE flag
>   drivers/dax: add spm_node bit to dev_dax
>   drivers/cxl: add spm_node bit to cxl region
>   [HACK] mm/zswap: compressed ram integration example
> 
>  drivers/cxl/core/region.c       |  30 ++++++
>  drivers/cxl/cxl.h               |   2 +
>  drivers/dax/bus.c               |  39 ++++++++
>  drivers/dax/bus.h               |   1 +
>  drivers/dax/cxl.c               |   1 +
>  drivers/dax/dax-private.h       |   1 +
>  drivers/dax/kmem.c              |   2 +
>  fs/proc/array.c                 |   2 +-
>  include/linux/cpuset.h          |  62 +++++++------
>  include/linux/gfp_types.h       |   5 +
>  include/linux/memory-tiers.h    |  47 ++++++++++
>  include/linux/memory_hotplug.h  |  10 ++
>  include/linux/mempolicy.h       |   2 +-
>  include/linux/mm.h              |   4 +-
>  include/linux/mmzone.h          |   6 +-
>  include/linux/oom.h             |   2 +-
>  include/linux/sched.h           |   6 +-
>  include/linux/swap.h            |   2 +-
>  init/init_task.c                |   2 +-
>  kernel/cgroup/cpuset-internal.h |   8 ++
>  kernel/cgroup/cpuset-v1.c       |   7 ++
>  kernel/cgroup/cpuset.c          | 158 ++++++++++++++++++++------------
>  kernel/fork.c                   |   2 +-
>  kernel/sched/fair.c             |   4 +-
>  mm/compaction.c                 |  10 +-
>  mm/hugetlb.c                    |   8 +-
>  mm/internal.h                   |   2 +-
>  mm/memcontrol.c                 |   3 +-
>  mm/memory-tiers.c               |  66 ++++++++++++-
>  mm/memory_hotplug.c             |   7 ++
>  mm/mempolicy.c                  |  34 +++----
>  mm/migrate.c                    |   4 +-
>  mm/mmzone.c                     |   5 +-
>  mm/oom_kill.c                   |  11 ++-
>  mm/page_alloc.c                 |  57 +++++++-----
>  mm/show_mem.c                   |  11 ++-
>  mm/slub.c                       |  15 ++-
>  mm/vmscan.c                     |   6 +-
>  mm/zswap.c                      |  66 ++++++++++++-
>  39 files changed, 532 insertions(+), 178 deletions(-)
> 

Balbir

