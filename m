Return-Path: <linux-fsdevel+bounces-52512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFC7AE3BAC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 12:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D07643A4946
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 10:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B430C23BF9C;
	Mon, 23 Jun 2025 10:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RNg72otU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE18B238C26;
	Mon, 23 Jun 2025 10:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750672924; cv=fail; b=pm2GdIQe4uZoIHbTiddDBMbiF0lybcpkAH5FwaW8ixXkHpgIxRnA1b2A5Xblci+HfH8u6IK86XmdDh+hVKodMcNkgPDjjKkSDRDUNAXj1k85EL0f7f1seR4+a2d1PEUp9RVfb2OTPdNcQHEG/uebqPwLJhkIsrZxyqv6BwGVnsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750672924; c=relaxed/simple;
	bh=Q9mvUFo3f2xOCLUDcuaFgxHbTvm3urddboK7emziHcQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n+q+vSvReD4upt/1QQqRKKo1r8ASmcwmSwGpojZNhNCLYYzPb6TiusfVYsw+f1CfpLn9UCXibBAv4188xYIxsj3bXVb5NcpWzpDQLvZAum835iyYAdR6s1lX6NFb8Up+DLUiFy7zjfsVilNiIvpO/V+Cpa5ROZrYVlkWHkBdk1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RNg72otU; arc=fail smtp.client-ip=40.107.93.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5N8y1kVqHgPdO6j1Cr85sW+GTnnF4FTqKUbRm6+Q+B3t0Ntoq+ju1jmkKbgUFOV0+92T37zxwhom4XvhkMh2U9vxhTXETRCVH/VebnCBin22WM/H1ox+nHMQCJbF3dYU/Mklf1fej5RMmfNFFn7nOaHnmeMw9WXpcq5Y0JlL3mDOmutNeKqTEOHJs63LuNS9H0BzcHuas+XNaiftxKyNkp1kxFU05QO5jRucnb+GWHVVGpMqvSY4Y1Wpdsp3OkdYxzc/ugRwg4OcOaFzjIQ0rQ9Dj/ueG5q20asatR1xIQtS8zRSyadAoa5KpkquWdq/YPz38uXXgVj9LiUEbCe+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mM3QIFRZPTOIyLEH112lpMAhMyL89aqmmd9iD4Z/Dnk=;
 b=S9hH4GBb6uQH3zy2WcsMLpe6F/R2DrctAb+vnjN+BPo/fyBoHjPBNnFcRQbvhHRUIWtiCnn6UJd2+Xh8Y1TJb8O1NSjr9eiHpHPgOwI1Wj07lnjM/XeKwylG9q7C+vMWq4mV27PrMO8LTuIs/l6Qza8aqN/KEPEH1WsSimgvc91A+5iVDaNv63CweRKWX9gt8IUa0YiAzCRfVip4+lmZHAfSeCn+IhZEBMxAG5mF148iqh+ehkrMviEHIfB8/q6clq/BW2VOAEJfZJNvBnh0Hy5l+CneuPIYXWmF69DcNxHMPP03HUJqlOtK7Jlc8ln9SDQIodxpqYVsyBLztQRPPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mM3QIFRZPTOIyLEH112lpMAhMyL89aqmmd9iD4Z/Dnk=;
 b=RNg72otUiZWGRy3oAzOCVaIa1etX1ZwkfxQNoah0m6dtFPFo4S2EA4TFfyVcYJBMad2e4Vtp8MX4HfsI1pOLUTfm42Ed0eF9q1R9JzdvMznnOLwSJqD4htNK8NixyE80xQyzV0McSTre0w56LHjrpN8aLfm9esCr610kk6NQQzU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9aa) by LV8PR12MB9715.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 23 Jun
 2025 10:01:58 +0000
Received: from SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 ([fe80::40bb:ae48:4c30:c3bf]) by SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 ([fe80::40bb:ae48:4c30:c3bf%8]) with mapi id 15.20.8722.031; Mon, 23 Jun 2025
 10:01:58 +0000
Message-ID: <91d50e25-8ef8-4906-9b2b-a47c3763773c@amd.com>
Date: Mon, 23 Jun 2025 15:31:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] filemap: Add __filemap_get_folio_mpol()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, seanjc@google.com,
 david@redhat.com, vbabka@suse.cz, shuah@kernel.org, pbonzini@redhat.com,
 brauner@kernel.org, viro@zeniv.linux.org.uk, ackerleytng@google.com,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, pvorel@suse.cz,
 bfoster@redhat.com, tabba@google.com, vannapurve@google.com,
 chao.gao@intel.com, bharata@amd.com, nikunj@amd.com, michael.day@amd.com,
 yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com,
 michael.roth@amd.com, aik@amd.com, jgg@nvidia.com, kalyazin@amazon.com,
 peterx@redhat.com, jack@suse.cz, rppt@kernel.org, hch@infradead.org,
 cgzones@googlemail.com, ira.weiny@intel.com, rientjes@google.com,
 roypat@amazon.co.uk, ziy@nvidia.com, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
 gourry@gourry.net, kent.overstreet@linux.dev, ying.huang@linux.alibaba.com,
 apopple@nvidia.com, chao.p.peng@intel.com, amit@infradead.org,
 ddutile@redhat.com, dan.j.williams@intel.com, ashish.kalra@amd.com,
 gshan@redhat.com, jgowans@amazon.com, pankaj.gupta@amd.com,
 papaluri@amd.com, yuzhao@google.com, suzuki.poulose@arm.com,
 quic_eberman@quicinc.com, aneeshkumar.kizhakeveetil@arm.com,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-coco@lists.linux.dev
References: <20250618112935.7629-4-shivankg@amd.com>
 <20250620143502.3055777-2-willy@infradead.org>
 <aFWR-2WAQ283SZvg@casper.infradead.org>
 <20250622114322.c6c35800e01e4cc4007a0f89@linux-foundation.org>
 <d1d7feed-c450-4b88-ab73-a673f4029433@amd.com>
 <20250622151625.fb5d23362c2c3d1af22878d2@linux-foundation.org>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <20250622151625.fb5d23362c2c3d1af22878d2@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2af::11) To SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9aa)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPFF6E64BC2C:EE_|LV8PR12MB9715:EE_
X-MS-Office365-Filtering-Correlation-Id: d67eedc6-0836-463a-081c-08ddb23cfdce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2R6SXVJN1JRRERUbGowRHVHRDJaa01mcmxDK1JvQmhPS1dLMFNtV0FaRDlO?=
 =?utf-8?B?NEwvaG9RZE96SkhZb2FablZrRFFPYnNqYlVnTDdpU3d3SlhvVXZZVUl1SnFU?=
 =?utf-8?B?bEJVMlVuOFdDRkY0M2phMWdBZmZpaFFVNGdBZ1RRbGpzalNOZ0pRMUcrb2NW?=
 =?utf-8?B?TmNqZTg1L1dNbXZrM2dvNldXV1VpV2RrcVNHMGFBdXVOMVRUUDJoY21xNmp6?=
 =?utf-8?B?bXV1cm8vN0ZhcTBsUlJKVnNNWWVhWnJGRTJGTXFQbmNBayt3dkJvNCtEbzZE?=
 =?utf-8?B?Z1hZNERLeklRekhjT094NmlBN3RML0JTNk13eko4QzZjY1NEdkxkSS9TSmw0?=
 =?utf-8?B?V3l6UUVCUWJjTklRNVhPTTE3NHhwYkwyRmEycGlhd1RkdkozTDNpWDdmQ2Zl?=
 =?utf-8?B?QmxCUnhDL0puSlVKQkkzZGd2Nll0QkdQbXNZaUNMOUNtYzM0SlY4VExSNGcy?=
 =?utf-8?B?MU5FUGpxaU1lS2E4ZWxCelZ6b2JYNDh0MFlqMEZhdDhDUGpERHJBSFgrQ1NM?=
 =?utf-8?B?UGxpS0NydEdEcjV2Y1dhb0FVVEcxWjdHa2xpbExqVkV1bjVmemd3dFNMangw?=
 =?utf-8?B?OHhjT01BMDV6eDdkWGpCQjlLWW9FLzBSYzJMT0ZDWStCR2N4dWRlQVVaYkls?=
 =?utf-8?B?MnBkNWlFNkJGMmwyRHBlSUpuSXNwdlFLdG9VejZJSDViNGl0K0RvbTJwUUNH?=
 =?utf-8?B?KytTR00vcEVwcXRoQ2ZJSEF0aERlS2szbWdiRjN1SDErREVaUEdrUDNvNk1h?=
 =?utf-8?B?N0hIeVRZN2RxZFhsbUh5c2tkaHpUVjdXL0RwYzNtWEpmbDJlRmhNYjQ3MWFC?=
 =?utf-8?B?RzBXa0Q1c2VoamFIVlBJWUpaenRTT1hmUGM0eXZiYTNjcWN4K0gwMGFDT2VY?=
 =?utf-8?B?NHRrYVY0aXpMMC9JL2x1TVZmNU1VeUN6dWpZc0EwVDVudkpSSCtvdUNTWng0?=
 =?utf-8?B?c3VaZWloakZSaUZyNmNLaXozTlFzdWpWdjBVRmVnZktobHB4dW9OcnNKZHYx?=
 =?utf-8?B?U2Q3ekd0WjBWQ0g5TDdJVnArNm1Dc3VpbWxEU3hLV3lzL2FGS2t0b2diTlZJ?=
 =?utf-8?B?emNnbHZKUXgzK0NuVmUyQjZwUkdtUlg1S0xydk9Bb0tsQU1ZUTc3QlBhNy9X?=
 =?utf-8?B?aWJhSzI4YXhmMHRKZEcwbzRueG9HODlVUGN5bUlRRzlXWThZeTJXNnRxVWcv?=
 =?utf-8?B?WTRMb2ptWHpNdXVPNUxuRmhQb3Zwb1A4cUU5Y1NVUVlTa2Z2REFKWDhxdTBQ?=
 =?utf-8?B?UGcyTVFVYnVTdFNkR2Q2dktFbkpDcG03Q2hsQzd4UEsydTc0Y3IrUituSkdv?=
 =?utf-8?B?V1RNN3VrbG9BTzZOaldHT1l6NGtRbUdxL29vU0ZIWmZ3UjVwVFhtZENjcW42?=
 =?utf-8?B?c01qNXM1WVhGMXhZNG9rQzlQNm9UU1BQNGVQSWI4STNwL05pYm1ReUNUWGZJ?=
 =?utf-8?B?YmhWbXc5ZGxHQnkvTVdrc2RMZC9BYnZrc0RvMUVKSGFPR2Z2M1pzMjR3Myt5?=
 =?utf-8?B?WUhCV1RHQ3JZMWFFdWFrSGFBU1RnYzBVMkNRb09GbWd0L1VNS2V5R011aEU2?=
 =?utf-8?B?QzRWVVRRUTFYNTlud2lRL0h3QStSdFZiQ3RaSHFUdnIveGZaQUozNytaM1A4?=
 =?utf-8?B?U29MMUJEZ2FtKzRYaFYzalAzZlpRd1psN3Q3M24vUDB0L1FTZkFzdjVJZXVl?=
 =?utf-8?B?a0VrY3hFbEV2V01ONy83M3JqTUNCeTVOV2thaitRVlJBRXlCemIxdCtNbTFq?=
 =?utf-8?B?RHN3b0lJREtGbjU2dVJPU3ZraUxjcHVLWVYyZG5lNFJJR1B6MzdUQ1ZySnVa?=
 =?utf-8?B?VnJHNUdrbVc0UXBvdDE3MXI5RHpEQUhVTTR2Rnd3Uys2aUhrZ2szSUtZcmR0?=
 =?utf-8?B?em44NU9BcFFvK1pRdXBaS21WRTdwVXpTYlFlU3liREM3bmdtZDdRUXdVdmVX?=
 =?utf-8?Q?tQDAriWm9pw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPFF6E64BC2C.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlA4MzVOTVU4L1JGMVE5eGl0cjArdjg4YS80STBzcFIzSDcrL0NiamU2dmhs?=
 =?utf-8?B?K3NGRzl1UlhTTUVwNEZOcTd5c0tSdFJUTjVMZUFEM3R4QkZVT0lTWU5WN0Iv?=
 =?utf-8?B?WC9hdTRaSVdTY1Q2Y3UwN0d5NTd1N0UvMEhiQlBleWREcE5qSDRZODhSVTZ3?=
 =?utf-8?B?TWNydlJoNEh2eXo2SnBoZlVHbEVrVW1lbXUxb1psOEVFK3RjeDZhOGg1Y0Qr?=
 =?utf-8?B?WE9DaG05QU91WWczUHg4OXBDOGlJam9xOWk2YU9DTkRXOXFCSGdiZElUYkRF?=
 =?utf-8?B?Nmc5aVlsd01IVzJKWUdNeGhHdS9HQ2FDbitFVFh2UnM2OGFReGJialVXWUNO?=
 =?utf-8?B?NGlZaFVJa1lqSDRyOTJadmxWSTVNYUNBY2RlOUtPcnRQZjZ6K3dWbWpxV0hi?=
 =?utf-8?B?THlFK25tK3QwTW96NGx0R1dvRHV0a2E4c1AydTZ1MzZtdG5LYUtJZ29FNmcz?=
 =?utf-8?B?OVdmS1VsZjZoVHBkOWJaYU5oY1dxSGZLL3ZCVlFpTW1ZbFlSc2o5TjkySnRW?=
 =?utf-8?B?UERFZ2dnUTlVRkNuVEYvS2tFbnROT2FPd2Y5T0VpTExieU13QXhnb2JSMVZN?=
 =?utf-8?B?ZjdOdmR5YnVrdC9iNUtYNDREZDcyLzRyRkN5S2NLUzFsVmd3MzlmQlVnTWlw?=
 =?utf-8?B?dXNhcCtEKzlqV2xJT2FFTlUzVzZZUDRyZUtkV2Nzc2VtK2RsWmxkcUlRTWN1?=
 =?utf-8?B?MzlaaXFkT2V6RkFWdFliYWpBNm15UitmY2JqZjBiclhwNVpBbTNxcHhkTVFP?=
 =?utf-8?B?MkhvNDFUSWw4OEV2eDlmSVBYbE94eUczaDVDbFBVTXBBWUJ5cUM3TURvRW1E?=
 =?utf-8?B?aWI5bzVGRi9QNnFYbnphUXlwMWlLNXQ1dVdLbldBN2dkb014UTJpN0E1WDM4?=
 =?utf-8?B?MThNcFd6TlFocURuem81QmNuazBsc3dZKzRJOGJFR1VFeVlkUkhaNEpRK2xp?=
 =?utf-8?B?WGhOWlFBb2I2YkVrZmNZdDFkalVwQVBRdTNEMDUvMGJEWTRoT1ZQNU90TnlD?=
 =?utf-8?B?RXBkTjg3L0N6dFZ0Snp3b1d1dkJmZ3hvbndZZXhEWklORDZ6TVVPMlRub1JF?=
 =?utf-8?B?cnhCbEhESUdCVkZjRS9QeG9XamVrWlBhSEZiaXZ3YWxoMkpJcFY1OUczSGlY?=
 =?utf-8?B?aDgzNzVHK2tRTkR1bTc0RHQwQUJpR0xKMkcyWnRweFNSMEhJY1pIMmRMYkZt?=
 =?utf-8?B?Z2UvQWZKRWwrdU9iZ3RVUTZFNm91Tk8vcG1XUUNNd2NFWkNxeVlRcHA1RFl6?=
 =?utf-8?B?Q2s3Y2Yva3RLRkcyZm9COFNwZlNJTzNWUTBNanB1L0x5QUQydkp2K1FlMWVV?=
 =?utf-8?B?YnRGb2d0MUk0SnBqci9scTBCeG9ucEk0S2g4NW9ydGdRdnJPMkY3ekpmZHMz?=
 =?utf-8?B?OGZNZ0xzdHorS1Z4NDBEaGhCS25zM0hzdGV4Q3lWaEkzeHpTV1VKMkZzbWpE?=
 =?utf-8?B?K0NVVEo3b3E1QmsxR3k0K3dVYnJSVDdpWDZJemxwakZDenhDSzR4bStoVU9s?=
 =?utf-8?B?dlBnOWZabDVkZTFDRlQrcVBRdmorWWxlQXluNng2cnRJVVBqOFZrdVM2Qmtx?=
 =?utf-8?B?QXBQeDZNMFBSbVdMai9ONXdlM1pVY2N6K2JhWk1vejEwQTVyT0tZUktDMVlh?=
 =?utf-8?B?aFQ2N09udnJVaEdoMjVpenFsaEZnc09NeGJVTWl2VHpqRDBPOW9yRW9MQkQw?=
 =?utf-8?B?d0dLZ2I4bzhtelB5dmxOY3NjZkFPK3RaM3pMVk9WZXpPOE1MTk80a0tmQ0hE?=
 =?utf-8?B?OEU1Z2lOZUQzTU9wZjFNTmZZMVNpdkNJcDlMOFhteHdNamtKK1prcjl0Vkc3?=
 =?utf-8?B?aVBYYmxicDBIV25aN1A3ak0rT09OMGhDVFNWV3VkSys5VHVNditiWmZDL205?=
 =?utf-8?B?NFZBOTBxSVpXbk5xOXdvYVo5QVRJL3BwdzQvS05GVFFxOFFDMFFMK2NQcFlp?=
 =?utf-8?B?UEl2SERNT2xvalJmOG51Y2h4ZUd4NDU2TTlRWWorQ3pVQ1MrZEJwT2pUK0du?=
 =?utf-8?B?TjEya25OZlFOUFVxZ0gxems2bGxHOWY1dHZ1ZlErQzdXdjROL2lRSk1aU3VK?=
 =?utf-8?B?RXpLdzJ0aHNmQnY1c3VjSVNvVTBuUVF4TUI3WnQxcEg5QVIvNldWa0JhZ2hG?=
 =?utf-8?Q?njz+eL+aEiWQeR1/RVj16aJwP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d67eedc6-0836-463a-081c-08ddb23cfdce
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 10:01:58.5162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q5NAkeiJ5eN44Fl2EpD3rud+rwGpdFBmRjMU5KXLoQ+KF35y4DOHze13vbqhz5oTW+anZOnlXY0ZuYPzJBkL4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9715



On 6/23/2025 3:46 AM, Andrew Morton wrote:
> On Mon, 23 Jun 2025 00:32:05 +0530 Shivank Garg <shivankg@amd.com> wrote:
> 
>>> -EXPORT_SYMBOL(__filemap_get_folio);
>>> +EXPORT_SYMBOL(__filemap_get_folio_mpol);
>>>  
>>>  static inline struct folio *find_get_entry(struct xa_state *xas, pgoff_t max,
>>>  		xa_mark_t mark)
>>> _
>>>
>>
>> Hi Andrew,
>>
>> Thank you for addressing this.
>>
>> If you don’t mind me asking,
>> I was curious why we used EXPORT_SYMBOL instead of EXPORT_SYMBOL_GPL here.
>> I had previously received feedback recommending the use of EXPORT_SYMBOL_GPL
>> to better align with the kernel’s licensing philosophy, which made sense to me.
> 
> Making this _GPL would effectively switch __filemap_get_folio() from
> non-GPL to GPL.  Leaving it at non-GPL is less disruptive and Matthew's
> patch did not have the intention of changing licensing.
> 
> Also,
> 
> hp2:/usr/src/25> grep "EXPORT_SYMBOL(" mm/filemap.c|wc -l
> 48
> hp2:/usr/src/25> grep "EXPORT_SYMBOL_GPL(" mm/filemap.c|wc -l 
> 9
> 
> 

Can you pick these revised patches:

https://lore.kernel.org/linux-mm/20250623093939.1323623-4-shivankg@amd.com

I did some touch-up on commit description, changed some code alignments to make it more readable
and fixed couple of checkpatch.pl warnings.

Thanks,
Shivank

