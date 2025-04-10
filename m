Return-Path: <linux-fsdevel+bounces-46224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C74CA84C17
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 20:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CFC11BA605B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 18:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E67628EA50;
	Thu, 10 Apr 2025 18:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rHgxW1Q7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30C128C5BE;
	Thu, 10 Apr 2025 18:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744309670; cv=fail; b=H42oGlF2WiOaN6PzXnbrK6WwhpXOFBetoP6YJYuWZ+6MgxdB4EYF/Ma5XlQMPTHeaufgLMOGxlSUIVQuRqN851rg9HjAdK2vpO0h5VW3zPshNDrr5MCqat5aHsCl5HGExCgafqTzHhSjZdQ49DOPx4++mApgFeUGeUk/lAn+FZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744309670; c=relaxed/simple;
	bh=yLTBpYizmArkRX4w2miFi3ByvidQ2xmxZD4atTJ8BMg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cNbuXD/+55QszCamRCM3UWTsjyH+QLpZCM+juTDUDiR3kynhgoDHDFXWm5R5VoiQiMgUS3M8moB6uWHPj0nhQnsAQ5/2eICYj5udZvJD3N9d4nRtQwHaFGUc2VnGbIhM5upagfbxhtHA/aIFnUCE4xNXw4ccSQS6sbVTvbXZL/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rHgxW1Q7; arc=fail smtp.client-ip=40.107.220.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MD17GdkNsTDClL1vU+Krzp5rq6QkKcPDkPIbuJ2p2kgSUP5sVGIQX2goUYoqnPtcGhVcUyePKGp6gtuLe3zb0IGhlzFO23Tl+Ngb9+9bRPCmiHksl4A6wGg1Egz+4O+Q+VVOcyZ8XUuMMkWy1K3g6auIJ8bouKFyaflPF+aqEmms9yZvRrOitbzXBbzHoUaxOgO/uW/u0Y8kLbiA50PA0okCDWpQp9KhRZcniMPngQkp2FLfuvXtmsJB2esBL3OGFuPmXEJEJbehyVWvFM0lSSN3r2g2itK3nk+Fh+D6CHnG+o0rSLbo68ppnVuN3EH6qU2LDma9C8f5vhUZp1oFSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=poZqf9VCopl4ibeBi6fv7JHKZy3DookTjj12hLmyn1o=;
 b=MIPIMT+8Gdu0/vmjjp4UVw14uT2dzle+LeOqWBh0vJeRHVogwHtVo6n3potl7BGRLdx+boUYqdxjdEccQcqsQLjZ8DrRXyfLqm7WHwP4fR0YTf+4f5F+cAaFRBjFYi4j1GIma4g+4F1hhvVRyqXEQoWjYuAewSZG21rjufS6/nwdinWD4RnTBhudYTkffT0LFFYWBpOl7czAmsfX1oohgPmYIS41fabGTV+t7cmy7iT7xTrmsVk++7EBwBBBtO9ANr/Y0fXsjpQ0EqGGrfeIlDAX4VhFXVyNQ7OkadYvxpdqqDZFR8Ok45p49zBXGH6znuZdmuNo2Va3tdiaPK0kOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=poZqf9VCopl4ibeBi6fv7JHKZy3DookTjj12hLmyn1o=;
 b=rHgxW1Q7UAVV8CvZrNc51zmEKHsC4pytpeqIA0S64nA+YgKQTh4EZtvlwIyHuJtSacLQSs1W4fgeeqZ08oJCn3/QHHzb4FmPT246m4vTNPIb2B0bPqQwYy8BXPf1EGABMRW22DampWhmi/JTkX4wwx6HndMPEx71wkvaILb8eKI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Thu, 10 Apr
 2025 18:27:46 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 18:27:46 +0000
Message-ID: <8556d931-d2a9-4dd7-824a-a67317ddaa05@amd.com>
Date: Thu, 10 Apr 2025 13:27:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] dax/mum: Save the dax mum platform device pointer
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
 <20250403183315.286710-4-terry.bowman@amd.com>
 <20250404143409.00000961@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250404143409.00000961@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0029.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::34) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|LV3PR12MB9356:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a1e31b0-1904-4f2b-814d-08dd785d63b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0I0ZFZYWGVQZlpuNmgycGdGa3AxSEJFNW12K0F6YXV5cnN5Ujh5cXAvMlNE?=
 =?utf-8?B?NC9uMWhYWjVNeElxYnB0dkJ2ZXNBQjNjVnpuTVV2bDdwK3F2SDh2SWNPbUFL?=
 =?utf-8?B?Nk1rTDZXSXUrSmhHemZLRVRTRlA3ZTZnTmVaa3E5QUdGTHhtK0xxNGphQ29P?=
 =?utf-8?B?UVZSYnNaSUtIcnFRVFh6cTVKUWcySDk2aHh1MWZRalRJeDFWN1hRaUNIWlMv?=
 =?utf-8?B?bjJxSGtJZjcwaVRNYnd4VXVLY29YbnpXTFAwb0ZpdGVrSi9Sa3hEempnbmcr?=
 =?utf-8?B?dnhNUEd3V3FFa3lXSWxmcnVGWWJORkpYTjJyWVdKdDZyQmF6MXJNZkYvRktU?=
 =?utf-8?B?ai9DajgrcWZHN1Z1RVIyTEMvR1ZLNzRzTWJ6L29PanlwUDVBMjlHN0pYdEJy?=
 =?utf-8?B?TllscUV2WGRleDhweTJLNzJxbmVzME5vUW0vVnlUQ0NrN3psWlB6WFFpei9w?=
 =?utf-8?B?UWJrU24rR2RvQmFFOFFFa28rV0Fzck53dFZQcE11eVVMT1dON25QbVFJMXNP?=
 =?utf-8?B?bDdDVlcxdkgwT0Z2OGJKM0YxRGJHazFscHJ3bFlZTzNhRGJNY0lRRzFwb2ls?=
 =?utf-8?B?UysweW9iMWlXOHlOdEExT3Znb1U0djNESlFFWmxGTzBxNnB3cFJWNlZGN1NB?=
 =?utf-8?B?TFRETlphNHY0MkpBYTZTUjJvTHRPOXRpMHduUFhSVGFNK1dkTDJTdW9zUTk2?=
 =?utf-8?B?OUkwelhPekwrM3MrTWxiUW1QNlpURUhLeFpuUW1CQ2tUTjFzWTJHWTdDdksz?=
 =?utf-8?B?YUpZcVVZb0ZvWitickN1QnZodFFDcDM3ZmRmRHpKY3pEM2VnZVJCSEZvMG5F?=
 =?utf-8?B?d0FTTElEM3Iza3ZXZlpNL0JESkkxUFhBUTdqTUpJa3RMMWw2RldvcmxOeVIx?=
 =?utf-8?B?cVU4WVlNeWpDRzZiZFJjMk1DVklnQm9EWS9yenNQeTFONGpVWUpnODVEY09o?=
 =?utf-8?B?REp5QjB2MitsVzhDSUdZalRLemRtRk1DK0p3clZGVCt6MjdIQkl6V0k0UHEz?=
 =?utf-8?B?OVZBWUxXRkVGc1A0QytqQ3NhQTVyc2p2MXJFeDAwWENMYm1KZmJGWVBHNFQ5?=
 =?utf-8?B?T3Qwd1BYTmVMbWg1Q1JFR0pLSHVQMkdpenpFOWNjM2M5NVUzdmFGMzA4OXpX?=
 =?utf-8?B?S0pmbHhXRGIyS0xaODYrT3FoTmZRQmNEckcveFRDNWtFSDl2TlNNM1lmbUs4?=
 =?utf-8?B?b0xocG9BdXpLL0tUK2dyTkVzeGNRaXlKTS9DbkJmbDdRdkRNZHIrQ3BqSnhD?=
 =?utf-8?B?eWNPRWI0NyszY0drbnpZRnZBME5SWk1pRVRtWERRbDJqRTRUMnlSODNuNFFy?=
 =?utf-8?B?c0tZZU1oQlFERlJBRnErZmsrTTB0djBSMTVaZis2SUUvTFhxRXBxZDVITEVi?=
 =?utf-8?B?RDB6MGljUTRNeGdZVnc2aGNpWm93V0VzaVlxaVlUYXdBSXh5a1p3L01WaHlS?=
 =?utf-8?B?MGovVWx4V1ZiVzkzVXo4ZkNTK1Y3d0dadU9FWElvMFFSVTJSTzNUbm5VSjlV?=
 =?utf-8?B?dEtLTEJMMXhtaGpWbDArREJUNEJLbWFmcEZ5UFMwUjNobGt0V3hzeUdYeVRG?=
 =?utf-8?B?ZE9MU0cvRmc2QkI4TnNibUYxaWdJWUdleis5eXUweTZodnNxZmRQWXZKOGpu?=
 =?utf-8?B?T1ZHdEFsMlE2dkI1NHFwSkUxdHJ0ZXVtMStKVjh3N1VwT1cyYWNLL0tFekVx?=
 =?utf-8?B?ZVhBSjdKVXRQTlplenFoM2NGYURkeC9scWlFU0dCNXhBOHB6djZRZktPOTRz?=
 =?utf-8?B?YnJBS0N1a3h0ZkVFc1hRQlhMQU5jRFZkUVJySzg1Um15YTZEN1RwMW5RMDY2?=
 =?utf-8?B?N0RPWjVyUVNvUk1maVlWR3p0TnhjMzVMdVF5MU82VTZlVUIvZ1dETlU3eGE0?=
 =?utf-8?Q?cvMNcSpZ63L6N?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXAzUGhIYVZiakFQSHZDS01BOE9EVVc5elJ2MDFveVp5NCtOS2hhcEZnQ1pV?=
 =?utf-8?B?SzN4Z3ZXTHVCU3RZY0FONmRjZGJUaldqN0Nwckl2dmxlaUVZS2hFSDg0OWRR?=
 =?utf-8?B?aUFuc2NxRWFxSXVUT3RqdElHUHNYaXJTTm9QZS9URXI0Q1pubXJVNUtIam5j?=
 =?utf-8?B?M1E4a05NQ3VUTkZqWHRzUjNGTy9vVWR0NzQvSHA2Mk9WczU3bWFyZnZkQURF?=
 =?utf-8?B?UFBTYzA5TDBpNHBxYVZTZHE4N2JQQzhuRGJibFVXeXg1ZFg2cE05Zyt1U2V5?=
 =?utf-8?B?WUU0L2t5L1VzVmdBcVd1QnVkNmFHUmdKRXdQbXpoaVRKS1NPeUMyQVh4SjBG?=
 =?utf-8?B?azZ4ZTEwemJpV1lQYWFXbnRRQzN2dUZOOG96VVhteGdzalM1NE5pL2VBcVJs?=
 =?utf-8?B?MUpxUmpEaUoySnBKZHZDdTFJUjRzc2V3T1pNdUg2ZkdwYzlaQjNUVjRCK2RH?=
 =?utf-8?B?MWxpdU42em8rUm5vUlY1aG1SNGZrUStXdnVpaFRhOFkyS0Zia1VrQ0dHVjVs?=
 =?utf-8?B?WGc4REQ3ZGlkZHhzQjg0WTZ0VEdwOGFpeVJXYytYWWhtYmU0cmhxbHNDdmhV?=
 =?utf-8?B?YlZJcUErQmE3aUdrUDRRbWpuOUpFWFZTRm1iRHNMcC9LYUdXVHRla1dUbGFy?=
 =?utf-8?B?RDF5VXREQnpRVUhqVGtjNHM5dzMxSnpXUURYcHhZaEFwY0ZnWVFucTN3bU83?=
 =?utf-8?B?bFk1L1FxL0g1emtUUXBZbVRJOGx6UEZ4REl1cVBVb2tBZGg1eG9sVDFRZlpa?=
 =?utf-8?B?bkc2Y01RVjRjTFE1ckRPLzlSdVR1VllhakR3ZkpDdHdmQ0hlVHJiOTJsNFNm?=
 =?utf-8?B?bGNwWDhYNUhPOU53OW95cS9ra1RHWkdtRk85aWpheXkxWUhaMjdmT3hqVWda?=
 =?utf-8?B?Qm12bkdCSnduL2g3S3FSNkk0YTF0TE5oQ2hLckRZNThxTXlHMi9zQktublFU?=
 =?utf-8?B?RkIxMmFzSHpwL0RheGN2OHhYRTF2Z2RJL2o3RUpORlI2OHdubzhWWitDeHlx?=
 =?utf-8?B?MHhaRzcxSWZyYmdpb3pPbnRMYVlWU1p3QzVCOENsMXR3NzdiSi80TEQxRFlx?=
 =?utf-8?B?dXkrUHRwbEp1RnVTWUllcGxtNUxuRnRWWE5LSm44ZHRhL3B6SjdqeDlUSzdR?=
 =?utf-8?B?LzNZZzhEKzBLb3NidFVqQmZxM0NIQTU3TldCd0lQL2RyVWxGenZISkxsd2FL?=
 =?utf-8?B?RnR4dTdiNUxuS3lnb0x5d2Y2cTBUTmN1U3pSZndMbDFzQmR4bUk4Nm9QUmpJ?=
 =?utf-8?B?c3dlSkFNdUtoWXRhUzFtZzFmY3ZIUFJralZ5NGRGLzRlaXRGeXM2eFlSSUh3?=
 =?utf-8?B?b01yQWJ5Rzh1cUtQalg5b2hzZi80NERKMGFzdzlwWGlhaXh6NC9aajdEaHhW?=
 =?utf-8?B?MzgrRHhOcm52d0sxRXAxSHNuVERDb05OcTFrV1cxMGE4c00wMGlFb09HTnEy?=
 =?utf-8?B?L2FFUDVzb3N3Z3FqNXg4VEk1TTN1NG5Pc3dEUmpKczVXSFZBWWZJcUx5MXh3?=
 =?utf-8?B?YnZ6cFFLZkUrRWFDNW9ldUh3bzNQdWVkOTc4bVNpRUxIK2xpNHZYcFJ5eit4?=
 =?utf-8?B?N2xzRnlESlRYZGNRemdaTW5LWGNuMXVLa3Q1VTRTL3o5d04wUXZtMXlobTFq?=
 =?utf-8?B?dUwrb04xME54U1ZGekY5UTRDQ1NUMTlSN1dFeU9CZU0zakVxZUhBbVV0SmZo?=
 =?utf-8?B?L3ZKQVdqdThpdndOQ1V6UlZJN3hQM3Y3NTJSWnZPRnM0SGlPYUJ3UjJUNGJI?=
 =?utf-8?B?VFBiVldMOS83Z0RXdTUwbmM4Y3ZCYjBJS3FzYS9xVEtGR1dVTUZzRmVIM3Zi?=
 =?utf-8?B?RFZPOE84NnVheE1Kc1prRExtNnExbEZVTmpZWHpCTFJZOXY5cnBHRjBLVy90?=
 =?utf-8?B?dUtFWHBLaFNlSTBZajF4bFBqTWhpRSttbS9sRUg0RndFSHR6cXcvRmR0Uzh1?=
 =?utf-8?B?T2FKRFNXSmVQMGh2cUNjMkZVYWRDTDJLUGhFVDBKZUpNUnk1YVZicVlqYUlr?=
 =?utf-8?B?VUZhbDYwRWY3ZFlqRG80WG1ianE0WE9QOW1SWVVaWW9MM3hxQm1BNUU3alVl?=
 =?utf-8?B?YmN3QWhObkplN2o1ZE1LV29adEp6eklzVnF1elVaSDJqZmFlSFJHWW5qcnZ5?=
 =?utf-8?Q?XUCiUS7NqzLIn/3mUGLSJ2H8X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1e31b0-1904-4f2b-814d-08dd785d63b9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 18:27:45.9125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BEhJ+I+Ro113Vm2VVoCk/Pm462es6BsEubURqelb0MnRR5ckUYksa2JsvO6lK1n4K7qC47zZov8C0A8Rdh8Ymg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9356

On 4/4/2025 8:34 AM, Jonathan Cameron wrote:
> On Thu, 3 Apr 2025 13:33:14 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
>> From: Nathan Fontenot <nathan.fontenot@amd.com>
> 
> mum?
> 
>>
>> In order to handle registering hmem devices for SOFT RESERVE
>> resources after the dax hmem device initialization occurs
>> we need to save a reference to the dax hmem platform device
>> that will be used in a following patch.
>>
>> Saving the platform device pointer also allows us to clean
>> up the walk_hmem_resources() routine to no require the
>> struct device argument.
>>
>> There should be no functional changes.
>>
>> Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 

Thanks. Updated to be hmem. 

-Terry

