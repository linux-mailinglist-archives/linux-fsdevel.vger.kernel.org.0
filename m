Return-Path: <linux-fsdevel+bounces-48451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8C5AAF4AE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 09:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A29061C06AAD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 07:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE3B21E096;
	Thu,  8 May 2025 07:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tA9LcZLO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA091F4C9D
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 07:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746689524; cv=fail; b=WvdNj8UY/8X7UaGWtMRthbiHDuLzaJ1aJTbMYPabCHLGN8/HYAvcK9f2lH4aHAucJV1WE9aniMYAzzM6Dj0xAjixqG34Lade4nGw4XyGVXslQxZmfMe8h7WJm1NmREkz30vS4NP9L+d/66QU4W5zTOO8em2HBSeOoXy6whc3p/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746689524; c=relaxed/simple;
	bh=syWTnPMejMaoyL8fnfz8FUTKMcpPrt0SxFBHHyrCZe8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dh460xVaB9j0I86ApZ3is3mmo2Dk5B9v/A+YVo1RaGYZrBXB5KTp6ewkqXhdNpGtMxgmUOQOALUSC2KvC5v/n98dsaA2LzDdVgfbcpBJnQJVDKOOnPL4NhIgH7LzrDKUtKJnXPyqhMkQDTAT5tNebkJioN6yQBmdUlVeok7lzjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tA9LcZLO; arc=fail smtp.client-ip=40.107.94.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tx/xNmQDIGRcLRln09aQPjK2pRJYI1cnefe3lqOFPBH0+L6WqGjwPUjvGcWfnXEsPk0ghvU18ngm9eaCbJ0+2pQwXLnXDLYjSKgpEmTz9E+UuKYL42d4HUEkF4IMaKWtiino+blo1dy9DOXh8PAVDwktKUwBWPttDbZZZK/lY4Yx8G+Mumc3xVAeBUg8xA8Ky/qtzTKpu9V0BfNAnirf1gvyJ5GHcPy7nkqPff4Im//YNj4KsDgO1NVSFlj3B2ZqZ0w4OlwZ2KdLjesXszoE2Jb6yec0wox11yG1/1cqA7RUHGO4EVLTtRfoMYC/D8txD/GXDdNphfKsbMYpN6xNiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGy+1LziA1R3hwBO1GuGEt/IhdjZ69VZ2CwOny1IaVI=;
 b=vUUV9OaSqnWorrQx4tRleDVWZfIHVciqafCCP0E4Oc07u5ycdV+h6fnYVuEEonMy64rOf1tsJTZ84PjPiN1z4TSxvN3OsJYYHAGDJHO28iuSj/6fm1oM+psOJKBWX25F2xhJVhgha1gXIWFNQBr9KbgxTFInG+beyv6Ai16U9dFojSVbIJqY1mmu5EekBwyg6bucr5PgElp3TYGCqqYRL/cpZZQMPb3ackfgMpWq1D6oLq46vKKykgEGhEHC4hj6VVGOig2DyLYsPKf5IXljpKkvNIfUBuPGFOty+7sJohHUDlz0Eq8qksOPHNjRrR2z/HzZWbVHm0/dh+5rCLo7vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGy+1LziA1R3hwBO1GuGEt/IhdjZ69VZ2CwOny1IaVI=;
 b=tA9LcZLONV1G0iHUE+ro0dy5wvrpQLTOU0PR/JGj+ShuyMZmOsmgzs2yPYcWYQxvR8q9f3J4YV0Q7J25CrIwLXdn6QNSgRHRsUpgixzAtiVkju6NJ4ubwq3YMrNkW5SCLET1g5EbBBc7WxyPfn0z9VJBrG/PWgEM2iPRJ7rX04fEmGL/RAiqFB1SJ92A37QVSDuITtEU+yclcTIXcWpvnxsLwN/MhcdDb+6RSvsxXiSStHwx5BKbXUqHIfgk0Fj4jOlcA4wae1L6NS9d5OmrM0rhrbRPbKKH8+lu1WvgNBH8ZIx+WBT9lciUC91Aw991z1ds59seOW+KXo7TtosLbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by CH3PR12MB8354.namprd12.prod.outlook.com (2603:10b6:610:12f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 07:31:56 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%7]) with mapi id 15.20.8722.021; Thu, 8 May 2025
 07:31:56 +0000
Message-ID: <ab266a48-c150-44cb-a0c9-ceb25e4cebbc@nvidia.com>
Date: Thu, 8 May 2025 00:31:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] selftests/filesystems: move wrapper.h out of
 overlayfs subdir
To: Amir Goldstein <amir73il@gmail.com>,
 Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-fsdevel@vger.kernel.org
References: <20250507204302.460913-1-amir73il@gmail.com>
 <20250507204302.460913-2-amir73il@gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20250507204302.460913-2-amir73il@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0032.namprd13.prod.outlook.com
 (2603:10b6:a03:180::45) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|CH3PR12MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: 34af64cf-4ab6-4a6c-7f58-08dd8e02691f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGhZMlhKY0VDNFNyWDYrcm9hQ09GaEFhSTMrOEN2KzV0VklCU3MyYzFIZTlV?=
 =?utf-8?B?T1h2ekV3Y1JGNHhFVy8zM0tTQzZKNkRySVdjU1pQWFl1VEt2ZWlmUHZqOXcv?=
 =?utf-8?B?NVV3TDNFTDJpcGhUODMyTnllQkR3Q3BjK05Oa1Nvdm1QNlRtNEFrT0tSRmYw?=
 =?utf-8?B?ZWFWSDBMSTNKeEtsRnQ3Q3dWaitoUHZNTWFhL0sybmpFMWZRcTdmK2VoT01N?=
 =?utf-8?B?NHZNTjNTa2hsd2RkUE9wTEQzc1ZObFBaNjlGUDB2akhGV1MyVG5HRm9kdWVt?=
 =?utf-8?B?eFRPMytYK2EveUZrS0VPeHFieUlmSlpRVkpTMWRJU09ZWFQ5akVIbGpSd0Nx?=
 =?utf-8?B?Ny9kRUVlY1VtR3pMaS9nTDJZYWMxdGoxWjVMMTk3OTd4SDhNZXJpeFdwMVBP?=
 =?utf-8?B?emo3NHFGb3UyVUlyN1NzWm1BVmlsY3E3cmhNVVpzSmZkYkhmY0xrWXViYU14?=
 =?utf-8?B?VkpTTkRKMWF3emNOcUZ1bHFSYmt0SVNTZEFTb2g4SjZQeUU2YTdIeko4eGFP?=
 =?utf-8?B?bDlOSEJOTmtIQ21FSGt3dmpCd0NQVmVqSnVkUmNsamdZQy8rRHFpVmY3MnMw?=
 =?utf-8?B?a3VsTHFZSld0QjdoSHd3KytsbnpzTlk2WFlCYjI4WjhmOFhxczFSaVVnNHkx?=
 =?utf-8?B?ZnBscVNuK3JhWFRKSVl0Q0I3ci9GR0ttV25DRWpOZmlCdHYxS0lTMmJkZWpj?=
 =?utf-8?B?Nm0vZE84T3pPVUNQMldmVnBLNW95K3dyMG43ZUlwY1FCWm1iVWJrUS9uZkM2?=
 =?utf-8?B?RnlxSEtRRytpMjNvQWpLMFJORXgzcHZIN1F6YzNlMnVXMGVCTjc3TjUyNkNr?=
 =?utf-8?B?Q0lZb2ZERXBPMmZRUmhlb1pSTnJPSTM2ZllTN2NtbVBJNmdqNDRvOFkrRUZE?=
 =?utf-8?B?b0cvU1RSSS8ydW5aeG1oN3Z3MWczVHIzQlpZUk8wcVZjYkI2RTlWTW5odlJ6?=
 =?utf-8?B?eEVrYU1pdjA2R0hmakYzRjdoeGNDUFhrZGxSb09KOHVwVWcydW12R3ZoNXJx?=
 =?utf-8?B?c28weGlwcCtSOFNPS3h1TGJLQTM2eUliQlJRNUIyWDFyaVd4V2l1aE1MdG9h?=
 =?utf-8?B?dU5zY0Rxdk9nOVB4RVlYN3JXanpsRklQQzluK2twdWlnVU1QNFp5aHYxMWdG?=
 =?utf-8?B?R0lmcGg3N2xyTm84MkdLMzdZSE01L3JvbGljNXJGVUFhaW9iN1J5TE0rcThH?=
 =?utf-8?B?UFdkMk5NbUdSZlNaOC9wOUg3aTVtWEVQeGRRM2I4bTFKbldGbUhncW1hOWZY?=
 =?utf-8?B?RStXaVVPNVZtQnFVL2NzWFBiUFFOWkgwU3dSUlJhNjZrWDFjTU5SUDZvY21V?=
 =?utf-8?B?SmxBVlhadkt1ckg4WWZLamVTTnBKdlFkOFVQNk1LbmxOeGxnbW41V3ZrSURa?=
 =?utf-8?B?YWJzQmxBK3dSWnQ4enhXOTBGZ3hDNU85dGpxcDZPVVFGV1VxMm9GUlBDTDlu?=
 =?utf-8?B?QVE4dzNqeDNUZWl6Y2c4TTAwbytKVlBSZm1KMks3VjJqek9kSXc0Z3puT09w?=
 =?utf-8?B?cGxHZEgzZlNDZDZnK2VkUDNpYm9IVjhEenJRaWZzc0JGSmxGdnh0djNSWWxk?=
 =?utf-8?B?dnJTQjNBTFR4bVNsR3l0c2NxL1RpaEd3L0tnM0I4d01WMTVSdSsyUkJDRWM1?=
 =?utf-8?B?VHowMHlYSXNMRUxBaDZhVkNHK2xZWHgwUk1OVDUvOFJtS3Bqek9KN09ZWnFE?=
 =?utf-8?B?VDBucTNrL0tla3BOUlpvZUhQanVKb0hZd3JsZHJIVkZrRTNmbWUrRWdVU0hk?=
 =?utf-8?B?UXE3Rzh3M2VxTktpdUMyUEVkbU4rdnA3clRLZm04NDJxZkZHZk1Sd1lyQjRU?=
 =?utf-8?B?dHJPL3o3SEo2SGVSbkc3cUFGMlo5S1Y3RVNpNUx4bE5PMmZlc3NFQW9KQkUw?=
 =?utf-8?B?QzRyZ1lrcmc1V1FvU3pqdHpEa1Z6SC9mT2RIdUQ3eHdTelplU2IzZVJ0ZXRH?=
 =?utf-8?Q?1Jae11OTd34=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDF4RlhOVWNXUUF5M1lDRTFLWnM0SlNTRkdIZGxJOEl5NzBPNHpscnphMW1S?=
 =?utf-8?B?UmZ3N1RsN1lTcUVRRHdyTHV1WSt1VnhRMDNQT0wxbUZlU2Fuc3dEOG5XU29C?=
 =?utf-8?B?ekk1bERzdUp5V0kyTFFnNFVBUG11clNFS3FMTGQvMjVIblNKaDJwamtleWdo?=
 =?utf-8?B?dkFYbm9XVHlzUzFJaHZDMmVFS1FieUhCQnY0aWExb3libkd4VjU3eTZYUllQ?=
 =?utf-8?B?dDhGMGtoQThDMXN5YncrNURjbC9EbzQ1S1ZqOEhkRGwzOFc3dXFNVkFCN3M4?=
 =?utf-8?B?Y3ppSW85R3hERzNTK1hYYmJVa1NNd3dkaDVUSTNyNGZvVlZ5Q3JyWm5uSndz?=
 =?utf-8?B?NEgydDlIbFdlVFcxU3RuTWlxUm96c2JBaDBta25pVHlNMHI4RUVQempvZ1R3?=
 =?utf-8?B?NGVxeVRZYVRKWXFETW1Sb29qNm0zaVZ1MGRaR1kwUTQ1RFAzMFpuenQvcVc0?=
 =?utf-8?B?N2txeDYzeGFIZ04rc0VtNkVHMFVaLytYN0E3dm1IamlZTXVaMzN5eE5zYXZI?=
 =?utf-8?B?L0pSOFh0V1o3OHJkcTVkNWFtMWFJYzZKS0tUVVhGYW9BN1JqRndjN0ZTU1FW?=
 =?utf-8?B?dm41T2tFcUMvWXRLRVUwNE4rZ2hGTVV4dkhrSDBCSVJYVWNvYXNkWml1VGxn?=
 =?utf-8?B?dmJDbFFWK1JNM3kzdDY3ajRCMVYrazh1NUVGMUVNbW00KytWcXprdFQ3dXFD?=
 =?utf-8?B?ejk4NXR3MWxWSEp1N29TRFBUSk1lTCtJZk5Vb3J0VkxUdkhCeXBMbWQ1cFlI?=
 =?utf-8?B?RGtITTlCU04yU3VjYzkyOWVQUHZxdEZOYkRzUlJOa0FWYzN1bnRkR3lXWnJK?=
 =?utf-8?B?aU5oSUpNVXlYMU9EVjE3Q1o0MjRnOWQ4SzFRNERDYkZmQlBPK0JjU001cDBL?=
 =?utf-8?B?cWZneC9vN3kzbWNVbzJuTkZuVDlTYWozSUdaK04rdXN3eUgzSC9QY3ZmT0Er?=
 =?utf-8?B?TTI0ZUNZT0FIQlFsQUNnYmFiVDAyZ0oyYzJwOW4rT0V5Y2pPWmhReGVWdk11?=
 =?utf-8?B?OWlGMFlKUTdQNW1JNzh0d0dUTEJNejdhdTdsemF3TnFmNFNEUVVQSUFRMlI2?=
 =?utf-8?B?bkZJQ09mVzhVSVFqVnNkVUxia3Vxa0hZMThBdlJrbGVyTExsL3FKT3lkNURF?=
 =?utf-8?B?VGR1aEZZdW1XSmhBaVR2QTlaeVJIc0prRE1rY250RXBDZlgzTHFBbjY2ZHlN?=
 =?utf-8?B?aXp2aEFIWXhGemlnc2R4dlhyMGhMdUx0cEVRUFY1M1RJUXdVTmRMK0VIQ2tQ?=
 =?utf-8?B?VlVnNWVEMG12dWNVNno5YXliY1lYanY0WkcyMWdoVHQ0c3J6ZEVsNGxvSUdx?=
 =?utf-8?B?d205RnU1UWZCLzhQWDI3dllPUEkzdEo5c3FXSm84N254eElMNGJITnk2R1A0?=
 =?utf-8?B?SU5RRnZlUHBqeU8vMGlqSDdrekM5dmZ5VnMxelUrRy9wb2lYRFZ0YW5CZWx4?=
 =?utf-8?B?SzFoZFFOU01TZ0hqVkJpcGZlYlB2UmdvdkNnZEl4dVh3NnpGbjl5cEJBUUJW?=
 =?utf-8?B?WHNWUjFYOFoxOHlRWk9ncnJvRlp5cFM1MUtwNDFwekR5ZUVoRStOZ3ZaRHRv?=
 =?utf-8?B?L3c1ZG1NQWttd1V6SXRYM1ZPZGcyVHdWSkQzLzNWTjlETTJoeTh6STR2ZW1q?=
 =?utf-8?B?U1lIZGNRREVHd0U4bUh0U21DNTdyck5HUUE2Snh3YVdua2RCcnRhdUJPMHpQ?=
 =?utf-8?B?Q1RLV0NjUWl1VWc2Ukd2S3ByY0w1Vnk0d1MrNkpSQ1RUTDVDcWJmdjlDSEFq?=
 =?utf-8?B?d0o0RTltaFhiRTc0RmtBaXRVRStZQ3RIT1N0ZzhSakh0OTNPandwdElyenhQ?=
 =?utf-8?B?Q2ZKN0tTWlhkUTVUNlBPZUkySkowd0dZaEZGQUNIOCttdzNiMStsUUwvNHQw?=
 =?utf-8?B?UzZZVG1GSVU2QnFsMDUxQ2o2eHR5OTUwa2c1dUhEWE5Ld3ZrZThYNDEwSUJV?=
 =?utf-8?B?dXk0SlN4b09FZEtlV3lMQnhERlRIeVFCdzlGbHo1OEpBalQ5WjNPMmZNb1Fx?=
 =?utf-8?B?TjE3czdYWmJJcXdZS0FTc092MG55UlRsKzlMZXR5VDhmZUdVSlhFMytyczUy?=
 =?utf-8?B?L0pHUHpWcUx3Q3N4MXp0RGdNbXlrYlJ6TmN1d1lLV1BBYkx5aXJoRkMzQXpX?=
 =?utf-8?B?M3hSalA1N1hKa1BmRi9ybGF0MURsR2ZSMy9sQXFjNjlYZ3lDZnBnMU9EZEl3?=
 =?utf-8?B?VkE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34af64cf-4ab6-4a6c-7f58-08dd8e02691f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 07:31:56.2720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6i1n72+SFoGjilI7+5ZXG/QYz6Pj64b6/k5TnR4si14t8OY2rIvpQVAD3wouqT8mKbxYWzNitrcH23O7zKxmhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8354

On 5/7/25 1:42 PM, Amir Goldstein wrote:
> This is not an overlayfs specific header.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>   tools/testing/selftests/filesystems/overlayfs/Makefile          | 2 +-
>   tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c     | 2 +-
>   .../selftests/filesystems/overlayfs/set_layers_via_fds.c        | 2 +-
>   tools/testing/selftests/filesystems/{overlayfs => }/wrappers.h  | 0
>   tools/testing/selftests/mount_setattr/Makefile                  | 2 ++
>   tools/testing/selftests/mount_setattr/mount_setattr_test.c      | 2 +-
>   6 files changed, 6 insertions(+), 4 deletions(-)
>   rename tools/testing/selftests/filesystems/{overlayfs => }/wrappers.h (100%)

Simple and clearly correct by inspection, yes.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard

> 
> diff --git a/tools/testing/selftests/filesystems/overlayfs/Makefile b/tools/testing/selftests/filesystems/overlayfs/Makefile
> index 6c661232b3b5..d3ad4a77db9b 100644
> --- a/tools/testing/selftests/filesystems/overlayfs/Makefile
> +++ b/tools/testing/selftests/filesystems/overlayfs/Makefile
> @@ -4,7 +4,7 @@ CFLAGS += -Wall
>   CFLAGS += $(KHDR_INCLUDES)
>   LDLIBS += -lcap
>   
> -LOCAL_HDRS += wrappers.h log.h
> +LOCAL_HDRS += ../wrappers.h log.h
>   
>   TEST_GEN_PROGS := dev_in_maps
>   TEST_GEN_PROGS += set_layers_via_fds
> diff --git a/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
> index 3b796264223f..31db54b00e64 100644
> --- a/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
> +++ b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
> @@ -17,7 +17,7 @@
>   
>   #include "../../kselftest.h"
>   #include "log.h"
> -#include "wrappers.h"
> +#include "../wrappers.h"
>   
>   static long get_file_dev_and_inode(void *addr, struct statx *stx)
>   {
> diff --git a/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c b/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
> index 5074e64e74a8..dc0449fa628f 100644
> --- a/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
> +++ b/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
> @@ -16,7 +16,7 @@
>   #include "../../pidfd/pidfd.h"
>   #include "log.h"
>   #include "../utils.h"
> -#include "wrappers.h"
> +#include "../wrappers.h"
>   
>   FIXTURE(set_layers_via_fds) {
>   	int pidfd;
> diff --git a/tools/testing/selftests/filesystems/overlayfs/wrappers.h b/tools/testing/selftests/filesystems/wrappers.h
> similarity index 100%
> rename from tools/testing/selftests/filesystems/overlayfs/wrappers.h
> rename to tools/testing/selftests/filesystems/wrappers.h
> diff --git a/tools/testing/selftests/mount_setattr/Makefile b/tools/testing/selftests/mount_setattr/Makefile
> index 0c0d7b1234c1..4d4f810cdf2c 100644
> --- a/tools/testing/selftests/mount_setattr/Makefile
> +++ b/tools/testing/selftests/mount_setattr/Makefile
> @@ -2,6 +2,8 @@
>   # Makefile for mount selftests.
>   CFLAGS = -g $(KHDR_INCLUDES) -Wall -O2 -pthread
>   
> +LOCAL_HDRS += ../filesystems/wrappers.h
> +
>   TEST_GEN_PROGS := mount_setattr_test
>   
>   include ../lib.mk
> diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
> index 432d9af23ab2..9e933925b3c2 100644
> --- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
> +++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
> @@ -20,7 +20,7 @@
>   #include <stdarg.h>
>   #include <linux/mount.h>
>   
> -#include "../filesystems/overlayfs/wrappers.h"
> +#include "../filesystems/wrappers.h"
>   #include "../kselftest_harness.h"
>   
>   #ifndef CLONE_NEWNS



