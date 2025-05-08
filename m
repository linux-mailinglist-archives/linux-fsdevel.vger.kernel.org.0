Return-Path: <linux-fsdevel+bounces-48501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD961AB03B8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 21:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D17CC1C40C70
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 19:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE60228A1EE;
	Thu,  8 May 2025 19:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eBSNAzGO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8181528A1D7
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 19:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746732755; cv=fail; b=L4VXQQsxgKcdbMuVA56S2hIF1I5iEU7IIUJCt3bJyyD81eUnULnjAicN4XIF99g9u3lLDgdd33xsqjbrAsQyYMvQfXfy3189g+ZKzTc8suiNBAa6xfUlqHyie+UKC99El+DLRBhzB6uzkLy3pyNU8KNWN4VsLdOcqFHwkn5yFsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746732755; c=relaxed/simple;
	bh=D+y4r5ihtKKf9ilCJeVKrE4GjTfJ6SOsd+ywWtt45ck=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q4qQ4wZTDo4DALyo2yff1arl3chP3PQVXn2GA/8zVox8XQUjpAjJyU4Dr5NayEini9uRzYejkxP5C/830GgTXSoN/Aml6HnGlOt+G+Zl0RkOA/6HHAsupqBKZE+SpbA+2yn9rD+/i5hV+CGCgf9HCimY3AQcv+VDzZPG6SKUlDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eBSNAzGO; arc=fail smtp.client-ip=40.107.93.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQ1Fkyv34tbzZ4i8qumvQaQvAw4+sowKrJRQXfSI1OxO5x79V2RAtBmdTdJw5QCY/2Gm3oVkEceLcBgzK2oT5BGEnqtJ6GNtKQBl3rkmCh6PTnCLwIwTQrhmEPzMlH1v8K6jqVOgLJ+IOavlfdSnHMSr5QZIi1jfEcmQkjJt/sQHMjJ15QN2EHNzs678fPwHNB/YHrFHKm37nlGYQsms3Bg8dqXrUozynaL8XUFhP90ICoBS9BMcrdFcCQx2/HBlM6StnBH0d/RQJslsRAghe+wGfRDF//LTtuRL5rTuQhzpLzL1n4Hf/vndam/6yMeD5LrpJF7hdfEzJ6PSel3NtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PE7Sv5deZBtlM+oOPVLJo16N3lJovczShHnxagEH6zc=;
 b=RrRUCvS4o/eATroiKL4FqDf3oIcek2kkT3krFjxGDDc5/McJiMol2Qndf70Mo5SgSfjgOH2FRUJF/kIuTOsthuiF7N1iDn7mIuA62NzhJOOwfns0UsvUKnsiq7Sphcpm/ftFbG88LIj7BEWUSzB0iaASLYpCbk59bvLLHGcyBR+513OktGrTkdpVybzUx6WrsZe+q4MzIZyAdPBKE+dRvbm8wEbKzLG/JTieduzQE6yHWHx6sYMk2FwK412igwKPLRJ2Wen6mXkqmrZRq2CwrHsdw0fZHTTfYO0uA/5rriQWIBWaV9rNEGFQR0wwcLo3giy5Xs9L/1RhQKgllCZwyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PE7Sv5deZBtlM+oOPVLJo16N3lJovczShHnxagEH6zc=;
 b=eBSNAzGOParvWSjJZPrjXt+w6XI52kxXF24sd74O0qlOpRjgHp3QEn9lGSJ7+vesJT3gwZud9jh8sl7CowLIN14d+hfYhi6yZwJQsmsV8KtGZCdvSxYeHnraiQuLXdGX/5z+s2Mo/dfIxViK12fxU6EK2Uwdnzz/Ml6OUdLOlE9eeznb1nuMwETxPRzx2IZRLsYrwA2LnBjoCI02ArWOYn5xnh8pYUmZGrq7PrqxmQnu0/ysnjgSSdzqNFu42K/h4WrLd2o3KpRMw0ogshZcKsDkluV3JxztdeTx1ZM/lhWiIAkR4TPMEIHjUHwOyDBSqw7lIfYwVtjPzAeV+v7pbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by PH0PR12MB8175.namprd12.prod.outlook.com (2603:10b6:510:291::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 19:32:26 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%7]) with mapi id 15.20.8722.021; Thu, 8 May 2025
 19:32:26 +0000
Message-ID: <cd227433-fbac-4984-9500-a67f3c2585b6@nvidia.com>
Date: Thu, 8 May 2025 12:32:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] selftests/filesystems: create setup_userns() helper
To: Amir Goldstein <amir73il@gmail.com>,
 Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
References: <20250507204302.460913-1-amir73il@gmail.com>
 <20250507204302.460913-6-amir73il@gmail.com>
 <CAOQ4uxjT=5aa9AnR9OgJZAe8btEq5QptzB3VQ7S6rPUwYcC6rQ@mail.gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CAOQ4uxjT=5aa9AnR9OgJZAe8btEq5QptzB3VQ7S6rPUwYcC6rQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR10CA0003.namprd10.prod.outlook.com
 (2603:10b6:a03:255::8) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|PH0PR12MB8175:EE_
X-MS-Office365-Filtering-Correlation-Id: b3e85bb2-ac01-4093-759c-08dd8e671031
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1RwelVkVTd4NHJRZGFRYXRjT1NFTDFObnFhUmhkZXFZMjVyUlhFc0tHaGU1?=
 =?utf-8?B?b29NZ0tPd3NtL2xOblh0b1FLdWVHWmVGb3MyOTZHdlpyVTRPb0piUExwMVNp?=
 =?utf-8?B?NmdCSEptcHkvbTFDdlViWVRGa1k4N2dqeUJyTDh5bXBQZ0pxVmFBOEhPTmxW?=
 =?utf-8?B?WUxUSG50OGF3UlNZUmw1OVZXNzJ5c212U2RodWNudGJ5OXZDQ2Fkd2c4L3BH?=
 =?utf-8?B?bU5ZSDRXbXJaYVZrMVFneHVqNXdKV0xKbCtpei9EWUhmVjd2Z0lMNHR5bWVD?=
 =?utf-8?B?OWU4TFB0b2RYcHFPU3NFeHMwWW9zYjdPOFVJek9VNU5KRGhrcm5PU0NzM1Vx?=
 =?utf-8?B?bnE0clYxcG5ZMWFpZW01TG5aaEZTVmFEUi95RDEwN1V1eWdRU2FTdDJtZjN5?=
 =?utf-8?B?N3d4azhjWTRBUnNLbjFQODRQOHlFVjQzYkVPeml3OWxDMDc5R1hLZjBjSXJ5?=
 =?utf-8?B?dEFpcTQzUGdSRm5lc3hLMklySGRoNmlvUnhmMnJsOVdvSHZIUUNYRGU5cGQ5?=
 =?utf-8?B?czJYdmRjdWNZejJaVk50LzJ1OEFKeW9uaGsvVXZIL2Vtcktwc3V4TksvSmlw?=
 =?utf-8?B?OG9vdWhCRFdHeGVHRlFBenRqLzlmZGFQaGc0TGgxRWtabldNbHhHMzkrN2xK?=
 =?utf-8?B?cnlucFd2N01NRnE2TUNOczBrTDBXa1pGNk9QajFSczM3L1V0THl1YkFTM0tJ?=
 =?utf-8?B?QU5oTVdnM0xFblN4M1JlazVJUzZlTUVtWE9lMC9YZm5UVFZkcVF1SnRTVEUy?=
 =?utf-8?B?a2x6N204eFVnWUhudm10YlJHRmw0c09PSlBaaFR4Vk56Y2FXbjBKczMwa21l?=
 =?utf-8?B?NytWcFpHNEIrZGVsMFJxZ01oN2FsaUkrQlcwMmV2dDYxQnJWT2I5WFlxL3Fw?=
 =?utf-8?B?YnlEUkgxK280N1EzSVBrUFpzR1M1UmtHRnR4YVVROUpVZmxwM2I5emRRenY5?=
 =?utf-8?B?Q2NSeWlzaE5waDR6SzR5SU4wbm9pLyt0a21LY2hNbHdsUDZVODZTM1kwNXZo?=
 =?utf-8?B?amZZc0F2Yzl6VUxTK2Z1YzBwcElKamk0RUVkOVBSemkwOEdZN1phUHRTSXAz?=
 =?utf-8?B?eElPdTlEaGtaNW0rOFN2M0RDazMvdUpaUks3NStEMGhaNUpXcVBxcmNDMVN2?=
 =?utf-8?B?akp3dlQvT2ptT3F6RVVmNGpTdFo3WVFkN2lqVnB0eWtPc0RWZVFDdmJNRGpF?=
 =?utf-8?B?SlNSalNVOVRueVZZWndQck42YlBPdUpGWjF4REgxbzhHemoyY1lHN00yMVJa?=
 =?utf-8?B?NWIxeWVLSmV6R3VMWVh2cEtEbU9KNklSMzZVb1JOc1BPSmFNdzVyOXdBcVYw?=
 =?utf-8?B?M2laM1R4TUNMYnYvektWR0oyaUxzMVRlNWwyMWI2amhvOTc2c2lSdXliRVRv?=
 =?utf-8?B?Q2xsLzJLd3FOREJmZVp6S0x3cjd3RmZCL3hVa0NXZ2NEdkxTZFFnd3MvQ2dT?=
 =?utf-8?B?QVNFNjBuRlkxek1hV0hWK1M3VHEyVkkyWjkxdDNWYlhjV0dLL0ZUendmN29U?=
 =?utf-8?B?NnlxT1RPVWEzTnZnck5xQThXWUhyd2NyanF6Q3QvbVBPWkZpNDl3ZDVRd1hn?=
 =?utf-8?B?d0YwczlMVG1lblNzejIxTVlXZHBVM2ZmNEtIWkdVVUNPY2w3U2V3Nmxab2Ni?=
 =?utf-8?B?bG52L3JaV3FFL0dhbHJwNGorVXlObmNXaXE0Rlp6MXJyeGxUMHZ1VlZ3aXAv?=
 =?utf-8?B?WnhhQ0d4dG5GbUVmK1hzVys4QVhRTHJhZ0dJSlgrUDBlcVNRaVRRQURwczha?=
 =?utf-8?B?UWJWZ2ZpSm04L2dSaHMxZEhRZEY5R0lPUG4yeUcwZ2pVb0prNVN4YzNCTkF0?=
 =?utf-8?B?UGthUVhLS1dnYnJSZjhFS1ErRlhyRENVaE5mR20yU3FiV1ZiUXlVMmRzWmpB?=
 =?utf-8?B?eEw5TVR1V1BKcXYzZXdmK0N6UG9FQmhCdnVrMlJ2cC9iOG5TRExnc3VCYUNh?=
 =?utf-8?Q?MNRMaqrdN6Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c29zRjhJcU1CU1NPK214T3NGVUg4V2RVT1ZINEpWcldxbkIzQldDcGRHdS85?=
 =?utf-8?B?MmxKR29zcG1hbDMreWhtUzI5SFB4Q25MUTNrM2NTM2VMSW1JcWxNVkltSWI4?=
 =?utf-8?B?OWU4dlF0Y01yQWQ4V1pJYmF0NjM3a2xWWlRQdGxNSWlIY002MmswVlBoVFYz?=
 =?utf-8?B?ZzNKanBSeW12dithYzBObmVGYnBwYzVua1A2Tk1mMkpLcU1ycmZXa1REbFpU?=
 =?utf-8?B?SjFnS0RCcU9iWWNsaUJ4SEVYazN0Z2RJOHFwRFZObmppYUdDZUpOaXRPc0dK?=
 =?utf-8?B?NGg3bWp3MzJ6SkpHOFU4anNnNDJRTnFZRExhNW5ZbGwzKzB5b3lWSmZDUlVH?=
 =?utf-8?B?aHFJaVRYQ0hEbEU0NCs3NXJlNWdEc2F2WG9zWThJLzMwckl2bW84SUthTWdW?=
 =?utf-8?B?L3N3eWppb01LZitiVll4MFZDUVJtSU1rZ2VQS1B1Ty96RUh2eWJQZWhlbTJv?=
 =?utf-8?B?WnBwaGtlMmVWdmd1RlI1ZFVONDBHbFJGSDFMWkI4SXdzZ0RSMWlIcERmaFVR?=
 =?utf-8?B?QjZremZ3MnVYRjdOVVBDVkJZTWtWVGxiQjVURnh2ZERWY29ZeFBEWWNhK0ox?=
 =?utf-8?B?Y1dJbmNZRnRMYm9WUlZUSVV0NlRuaXhZWWcxdWlzUFhPa0Q5RUZ0cTg3V3l1?=
 =?utf-8?B?UCtrRVd4VWYwNkZFUEdDUFQzSVZBaHRpNjkwM0dDMmNEUzI3OTNBZjNkaW5v?=
 =?utf-8?B?amFJZWQrOU1CYmVuT3VSRkNoZlpwU2ZXbWRXVjVBZlFCL0NoZ0UyMThGZE9Q?=
 =?utf-8?B?WkRxUU9oRTE3VVk3WE41d25vU2lBT1U2ek1VNDZyWFd2Qi9kaHMxcWxIaFVj?=
 =?utf-8?B?ZUEzb0dRVTBNSVlQelJVMDhESXJNSVIxVkhSeGxseDdLNmoydi9reWRUaCsy?=
 =?utf-8?B?K0F0UkU4L0dDNUJDYUNYdmxBUjVFQUo0UDc1d2tMcHBJVW1KMGpVWmZHeUJ0?=
 =?utf-8?B?YXkxdk5qWnRBRWduaG8zSUlGVjBpWmxFc2wzekw0Wm5ObWlkWTFvcWluOWNY?=
 =?utf-8?B?TTl5ajloNWJ4N0JveXpqUXkyeE05YjlVdUxsQ1kwNmM0YTVOdHQ2MERQSjNX?=
 =?utf-8?B?OHFzYXFhaDF6VmRhaWdFVTVXcDA3WEl3MnYydW1IVzFQODRrdXhqS1ZMM0wv?=
 =?utf-8?B?REJhcFRrVkh4N3JJcjNhKzQvTllNOWFjQXV0YW1MdDhQSXJFd3pyTlFKOC8x?=
 =?utf-8?B?QUtMTy8zcXZsV3FueHRrK0taalJyWjh0OW9DS0J2dmNmL2VSZFpvQ0FFTktW?=
 =?utf-8?B?T3dKN29DTkUxUVNLaGpVSXI2S1c4K1BzT1R6RjEyaVNTZEhtZXBxZUVqa2JY?=
 =?utf-8?B?bmFCbVZkZUF2aDBDRVVHbTNleDN4MmFoQ1ZKMGFEY0JoY0pNQ0RXaHkvcDhQ?=
 =?utf-8?B?cE1UbHFSVVBlQlVmcW55SjBMYlg1dzBCbjhWbllJMmczQVBJbHdyWVRmYnlU?=
 =?utf-8?B?dnlxdjVMWElCY21BWm5xQnIrRUxCZEljZStjbjRZYmhudGNMTjM2dWFZREly?=
 =?utf-8?B?ZG4xV1lXWUNKVFpIOHZBSm1yUTJIVFlGVUhDM2ZaMDlFMnJzeXU1VVJzU2xh?=
 =?utf-8?B?LzY3UXhPbHI4U1pEL2t0OGdVYUhuT0ZabHFvV1hMT0grWHpuQjhIUy9MVXM4?=
 =?utf-8?B?b3NJdU05OXFvbFR0dDdOdnVmTEViNFVJWmRHaE9YdEozRVM4aWJ1aVZlZjhD?=
 =?utf-8?B?UlBHMFVYSlp1eGg2aVI3Z1JOcFBBUDY3NEZIa1A2dFh0ZkRKK2ZoUXJXRmQ3?=
 =?utf-8?B?MVhFSE5pZm5vdnh1THFFZUN3NVNLVHcrNnZ4QXZnZHlLeXprb1hHak5XWVgz?=
 =?utf-8?B?VGVjcEpHdlpoQXJsMFdiT1NEUEZKeU5ma3NyNmRsTDMxbnA0THNDN0RoVVVU?=
 =?utf-8?B?ejI2VGtjRHgxZFBENVFTWjhWejcxcFA5Uk5RL1ROcHphS09Md2JBUzU2L2hZ?=
 =?utf-8?B?MzN0WFJ6bmlwcW1kbFZPbUxMMzVFK1pqTXY3VWRyczF4ZHBIbjlQY0JyRHZV?=
 =?utf-8?B?enF5Zm9jUWhCOWlDZXMxc1lPTGVMRWcwNGh2bWowdy9JQVgrNlhlTjB1VDM3?=
 =?utf-8?B?cUhPbzQ1V2NmamVaQ2FoajN1bktKSVFYcDdDVnFHYWp4RzF2ajJ2K0lwc1Bv?=
 =?utf-8?Q?6x9/csl8LOM2lLHtDjFAitIQQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e85bb2-ac01-4093-759c-08dd8e671031
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 19:32:26.2571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vx/49M1Qt9KiXS7+TwnbZNuaXg7INla+AZ5i9d//qBHcvXcteiwIr+U2RQPXwRLtvkaIbKRfHUNX9I7C6IdtEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8175

On 5/8/25 5:40 AM, Amir Goldstein wrote:
> On Wed, May 7, 2025 at 10:43 PM Amir Goldstein <amir73il@gmail.com> wrote:
.... 
> Pushed a branch to my github will all review fixes and a WIP
> mount-notify-ns_test:
> 
> https://github.com/amir73il/linux/commits/fanotify_selftests/
> 

It's always nice when people provide a pre-cooked branch to pull
down, as it removes the grand glorious guessing game of whether the
patches will apply to $tree. :)

I've pulled this down and will take a quick peek at the Makefile
question in the other thread.

thanks,
-- 
John Hubbard


