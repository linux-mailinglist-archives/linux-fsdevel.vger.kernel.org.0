Return-Path: <linux-fsdevel+bounces-35537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 001A39D5886
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 04:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B28EF2830E2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 03:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74C6158219;
	Fri, 22 Nov 2024 03:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aKjdi9AY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7503E23098F;
	Fri, 22 Nov 2024 03:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732245829; cv=fail; b=eByQJy9q7T7/qNIgYlHgwq6/M6kXwvYkrWOhgmJmh6BYRtOHTppDqPSHJkQ+mc70QocNkjzIlFG9pwMqQuECZhAhWVEWtZpZyFSlmy2P+lqxtDEpY0YvfexlH6XoXSq49+RJy9WTnYBTgtRgp3oLQghitLgW2sEqzh8exROqOGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732245829; c=relaxed/simple;
	bh=dkahJiHZlqs41u4qf9qjwI7hIUpI3rLvV1XdJpPtl1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dvCzYkEg77nBgK17jwucQeZKgeA68Pyx7JnvlX+rT94VSktZEkd8ZFkCygFt6dbvkh8c6WaDb+cEwnp0b4hPKBx2nYARL/yuCJ2SL4r/ob/Wd77uBoPs7SXVWU6kNP+VHCyNf5b6y3stzZacbxNyk8wGMSgHKMH2hijjuB01aHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aKjdi9AY; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kI6tLcNYJ+t4Fq5WwFiOBJ0DEgpSpqLGd8P7/+XnFd6RlriKl1d5Uew1L71Zf37fC1YJpZNSEZLOfJaMu1/Qu/hvSd8mFfDx3H9xNW8HyJqUJwOEzpg13RMqv9/2luKnZgQY0PZjMzkpYdubfzE1cD0z6TxP2UBBVFiJ4pXIPn96naBv+fG6gkpI8vmwww9DSo1jHDl6D1hEiRDzPFp+mV4HbxHGe6pUqJIMLtIsszyktSbAk5JjqC4WDHpJn7IogxWh7u6A+oE1zrbbxT5K0o/8ToiEwYADURDxQQ+pFkcL30fKtqnFTh31SGrVVVZ+MF+tSZIuMgY8AjP3C4lL4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETSdF40gF8CERm8Rp3zWNAg7pfjE+AtTR3jebknJgsw=;
 b=KxsW3RwA51TGF6cm0kUoMxBSqf2Q3yUt/bEpsoWHC2i4HRreMeYut2NXACZ9cPd+b0FE+0fbbd7XoWOk4cPC9Cw0FH8aqQ17Mh0ZMpX99ECnhxk/4F38jHhC0vK3oqJH4AlKSTEwltWY46uMvKnirNXq7j9jEDxGRNlPvUcZ+uIeLPk4b5/P+Ot9Z95FHaGyeZaNk6Dxv6XNf/C9VBk65ThdI9HIZPkCrFRhGxmOY9HmcyVqHyNqdbA06SQTC7h4GlYD+Y4PtRSivx3bTkVlSEwdUoL3MxHkK1S5CqNhUPeWcrpB/fJdXyN34P0XYiRMN2d83CslKBp9uST4ReGnuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETSdF40gF8CERm8Rp3zWNAg7pfjE+AtTR3jebknJgsw=;
 b=aKjdi9AY/yW+qSkiwK4ZxQdqjHotLuHy4ZM/ERXZK8xKbpiXnO/O7xE0agpghMQj+Y7JPCLh6l/vef7anKYW1mirPccXRf2Nj+8cNV8QFIV3BleCf8rJJu4UpMMNK1lnCvURa1WS8TPozz/j24NgzyhgLKJp4iW+S028vHf8C8iHJ2hqhvpbq7PKo+fv6PlO5/df3KGlbz75wi5KzEqaHYNOa+IStLkgYmzUhwOIc478UuDMMm1UK5lpb1izH5tOxhSHWWEvIV2259/DjgQDXVwCFssrZCmSDpCabV9w/hcthC+hV41Jcs6zSgs1Uap+l1dWhiHjvLl29/c34FIZQA==
Received: from SJ0P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::29)
 by SA1PR12MB6895.namprd12.prod.outlook.com (2603:10b6:806:24e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Fri, 22 Nov
 2024 03:23:42 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::b2) by SJ0P220CA0006.outlook.office365.com
 (2603:10b6:a03:41b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15 via Frontend
 Transport; Fri, 22 Nov 2024 03:23:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.16 via Frontend Transport; Fri, 22 Nov 2024 03:23:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 21 Nov
 2024 19:23:32 -0800
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 21 Nov
 2024 19:23:31 -0800
Message-ID: <fa5e1bb4-33a3-49eb-9b57-038cac3c0e15@nvidia.com>
Date: Thu, 21 Nov 2024 19:23:30 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/25] gup: Don't allow FOLL_LONGTERM pinning of FS DAX
 pages
To: Alistair Popple <apopple@nvidia.com>, <dan.j.williams@intel.com>,
	<linux-mm@kvack.org>
CC: <lina@asahilina.net>, <zhang.lyra@gmail.com>,
	<gerald.schaefer@linux.ibm.com>, <vishal.l.verma@intel.com>,
	<dave.jiang@intel.com>, <logang@deltatee.com>, <bhelgaas@google.com>,
	<jack@suse.cz>, <jgg@ziepe.ca>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <dave.hansen@linux.intel.com>,
	<ira.weiny@intel.com>, <willy@infradead.org>, <djwong@kernel.org>,
	<tytso@mit.edu>, <linmiaohe@huawei.com>, <david@redhat.com>,
	<peterx@redhat.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxppc-dev@lists.ozlabs.org>, <nvdimm@lists.linux.dev>,
	<linux-cxl@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-ext4@vger.kernel.org>, <linux-xfs@vger.kernel.org>, <hch@lst.de>,
	<david@fromorbit.com>
References: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
 <cf9cd76a2e376030d8b68e5a6c7025f3c82b20ca.1732239628.git-series.apopple@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <cf9cd76a2e376030d8b68e5a6c7025f3c82b20ca.1732239628.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|SA1PR12MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: 441ba43f-23a2-42dd-1acb-08dd0aa510a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGNPSDZLbHVXdXV5bGFibXRiQlhHd0F0c1JQOFIwc1lFaWUzckJYU3U0WWxI?=
 =?utf-8?B?Rk9INTJGTzFOcEFYMlZ5cHduanRmUlJtMnp5bmYwTCsxaVZlT3FlUCtpcGRN?=
 =?utf-8?B?a3c3KzZzZU9hOU5XQ2VwYTNoM1FjaFQxaHpkd1c1Sngzb283ZnhUeFdPbXFY?=
 =?utf-8?B?YkoybzV3WGZSS0V4SHI5bnAzQVhhZG1hbHpTQVNnM09IWU1PZXJnOFlrN0pD?=
 =?utf-8?B?SytVVWgxcGdaVlFWa1d6ZkFMNGV3RlpqamdZUzF5RjFMaUd4MGc4Vmx2Zk1a?=
 =?utf-8?B?L1V4QjRTcC93VVRBZjhHcmVSeW9lcDMrbnZ3NG94RU9aOWJ1dFFYQ2FIRitz?=
 =?utf-8?B?L0E0bVR4VWVFNDltSzdyRFduRmJmV2JKekdSbDNQVTlvVzZyaFh1aUFKdjh4?=
 =?utf-8?B?Y0tOZ2NNUHhESzFsNlI3NXBmcGEybFRZSnhWMXp5RGFYZzRsaTRFUW5JNHVa?=
 =?utf-8?B?S2FpZ2g2SzdLeFBPNHJMVDNiWTBtUnNXN0xGUTVSZnlLSFI1RVhaUVNPcnNJ?=
 =?utf-8?B?UFE2clBDZTA3dmhaa2dMMHhIK09ZSzV4M2xVNjNLNWV5UnZxZHZsa3ltNXlO?=
 =?utf-8?B?SFNoTWdVWFB3eGtyMEFOaThWN0l5S3hQUElQMlBQZk83VDFQRm13Q2Z0ZFFr?=
 =?utf-8?B?ZVZ1RE1vYy81WDQ3N2E1bmNKb1RzbHJyQkRUaWFUN1l1UzdycndYeUs5OElS?=
 =?utf-8?B?c0JnMFZkRkFpb3Q4V0Y1WG1TdTZSaWJhMnozQS9EVlFIb3M3OGl6c1REVHk2?=
 =?utf-8?B?blYra0hTa3JybzlaZ2FlVGt5Z0taTW0rKzVBLzkwdXA1dFBsK01IUzhkazM2?=
 =?utf-8?B?K1I5ZW45K3hMb0xSUkNTNkYwenZrNEtBQ05hSE9WdzliOW9TUklFYnlkQWtv?=
 =?utf-8?B?MDRINjNYbmFwbnFrWHdlRG1MVytJdmwvbnpOU3d3Qzl6RWdqVTJJQVlvWHVs?=
 =?utf-8?B?VlJoeEtyNERBMnpYdjVlRHJlNk05TGkrZVJ3UzZ4WkNqOWxmOXdpS0VMQXp6?=
 =?utf-8?B?M3VGMEpMSXpqakdvR0lIR1h3YUJSNUdxeWNkQnRQaUIvb0Z5WUdNMngwdERj?=
 =?utf-8?B?czhvSnpzS2E4WU5wSzlVQ1Jkbm8yc054UlpaS3FWUVZjNUMrL3kyT3VpaTV0?=
 =?utf-8?B?SjlZRkxvWU5vL1krOUlUc3pUOWxwYlM5UzE3UjVQWHVKTFBSMHd6V3BNYjQ3?=
 =?utf-8?B?R0JvQXE5eUUyOFpDNS9Gc0JDN1A4aE1SNW1VVWxSaklTcDhuN2JLMENTSzJZ?=
 =?utf-8?B?Y3BoZFY4OWFEdVMxY3IrSnNpUHBDZVBQWmdpeWJDcVZGclYwUC9GZG5OYnhw?=
 =?utf-8?B?U3dONVF6WUNEUVJiak9HOEVFc0h0a25EbnVlU3JIalpGWEhUSGU4UEIwWW5z?=
 =?utf-8?B?VHZ6dVJmZ2pxYXpQMlF2dHFYR0U0bTNHMDNmdlVVSzJpWXFHYlcvL1IyNjl0?=
 =?utf-8?B?eUVXS05JYlIwUzloR1o0WFcrYjJUMFNPSFYxVUFnWkJOQkhmYVBNZHlyQkhD?=
 =?utf-8?B?M1BDejMyU1JNRUlvRGFnb1VmZDJZMWtCYXVISE5KRWFTWGJPMnluczFFQWYz?=
 =?utf-8?B?SUdrdHMwWUFrNDEyc0ZlQTV3c29xM1VTOEdZOW9STlFFN0xPdVB3N0NhQk9B?=
 =?utf-8?B?ckVnZkplU3ZJWUlPRzZVakVISFVWajBrNGRRUnc0czF6SmwyNlBRUVRMUE0v?=
 =?utf-8?B?Ymk2WEh3MVY0SDczRzNhZHF0OEVNTG5WZ1B3a0pkTzQ0K00zSm9IMHF6WEU5?=
 =?utf-8?B?VmJhRDFUUzU2aktLMlcwTk8zT1hQRm5NaWZZb04xMzdIV2JHeWFLNWM0aS9U?=
 =?utf-8?B?d25uOHZpTW5JaHc5MFpLZE1vL0ZReFRsMDhjbExFVm5ld3lMUkFMVC96TFRj?=
 =?utf-8?B?ZUZJUGRjWmJDWTRlT1owTWkrcU1pUzVnMHhCVnFHVW1QSVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 03:23:42.1237
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 441ba43f-23a2-42dd-1acb-08dd0aa510a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6895

On 11/21/24 5:40 PM, Alistair Popple wrote:
> Longterm pinning of FS DAX pages should already be disallowed by
> various pXX_devmap checks. However a future change will cause these
> checks to be invalid for FS DAX pages so make
> folio_is_longterm_pinnable() return false for FS DAX pages.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>   include/linux/mm.h | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 22c651b..4f9ae37 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2004,6 +2004,10 @@ static inline bool folio_is_longterm_pinnable(struct folio *folio)
>   	if (folio_is_device_coherent(folio))
>   		return false;
>   
> +	/* DAX must also always allow eviction. */
> +	if (folio_is_fsdax(folio))
> +		return false;
> +
>   	/* Otherwise, non-movable zone folios can be pinned. */
>   	return !folio_is_zone_movable(folio);
>   

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard


