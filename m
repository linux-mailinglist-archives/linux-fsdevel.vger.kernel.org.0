Return-Path: <linux-fsdevel+bounces-57642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2B8B24128
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 08:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C6CC4E3C27
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 06:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274062C1599;
	Wed, 13 Aug 2025 06:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F+fsdRS2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD252BF005;
	Wed, 13 Aug 2025 06:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755065474; cv=fail; b=P5pP7mKTDa3OhwA3q5xJKeSL+f03H43YTFYFUfrpCDu6Zdg7iXQLyRrJUd93/8UJY41uR7czSEdz2jK6RegdE7KulgFRKos6ouA3olAlFoEpFTA3aL/KGPmfv3F5xxkAeyjg3szHXdU6xMXwHqRyo3TGOE+DzvzydIW/YTd9reY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755065474; c=relaxed/simple;
	bh=219O0tVUwXgCecF5gRgG7WNNWPMQzdahDrA1uWSVgkw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JUFhKRF8iczyvdlSMVghJK35higZzQMVOfFZODBSezkhfLfrbUErvOBhwXXXil9BEXZGZvKLuHH321FDBDxlwxhhFb92HCWrTtiBQnkhDz459emn5J50G3TgX9SiO9hcSSns2PXx3P4eq8YKQmskZwx5iHucEvKbFInaMvWxkR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F+fsdRS2; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IKn+cKkvDuS1fzgGoHf5xhhXxoF4bXQ/sLiJcPBVqWqhBUSVFMsdcykM66PM18E/kuBBVtpkBmAnk8/sX0K7KBUwThZ1hn+2ThrqkUeFuCYZan4VlBLOD21/lTCsD5Z0GLvl/Sg2OYefzhOJsW/fUmaEuXenVXAd1vGM3rFUn+BisHNa9LLpSCQV1xvwqA5+Ufkaxd0YkOEoykuRzXCqLa3D8brFNnRcxkc+OD6KzCVblbxvPiy6zjyZbTRIqNmxDwgf3KLfmsGypAWKxja6YlXvIFjDpri+Qicj96pXzkPbaXWR+GvyW7VaA9VDM/X7gYeWcvDg/+WaE3DL+XNjrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thR8ZN+bbW+AlBpbBiu9twn1iVln+Yg134z7zQe25+I=;
 b=pvWRmdWgmBVrd6wPADsuI6mXY4M47t5FILFmkJcyI9r4LNYvv7g2AqvjOwj5b3v77VxUk1F3k/Fmrmc9UfolK5T5YBco2Yfy0zIN71BW5iZsn16ke25f93jBcu/yxdvPmCIHlSRm3+e4M9TlF7PMxbC0tRfb0GsK88NJjzXOzo3eWEpQGwSvtVFK5EznWYOwvwSF7nT1RGgIm5El4n4qNfYRlgKZt+/2ApqpR9nT5d/o4fIm+OhAfHUUoPAqH3BMgr/xwDSWaW+SWGGydIDmdJGXsOC46mreo1j1NA7PYhMa7badYZW4uGPXz7VVIUMP2hCaa6vhTJb/oDJ169ONyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thR8ZN+bbW+AlBpbBiu9twn1iVln+Yg134z7zQe25+I=;
 b=F+fsdRS2GhpuqiAEKGrFI0YZq7zOKQmCiTOwhynBiwPevax5h36Xf5M5vxx36UjPnMgmD+XcLRdUc36DNSfpPHaD/jBUooq/81RNgPLXFncaTaFyk32ngOMlhzLaqTOJCGTruYVTJpkSw4HtxJ1q9KXDWFJFn9I8TD3UJhx04Yg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPFDC28CEE69.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::be8) by DS4PR12MB9772.namprd12.prod.outlook.com
 (2603:10b6:8:2a6::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Wed, 13 Aug
 2025 06:11:09 +0000
Received: from IA0PPFDC28CEE69.namprd12.prod.outlook.com
 ([fe80::7945:d828:51e7:6a0f]) by IA0PPFDC28CEE69.namprd12.prod.outlook.com
 ([fe80::7945:d828:51e7:6a0f%4]) with mapi id 15.20.8835.025; Wed, 13 Aug 2025
 06:11:09 +0000
Message-ID: <e7f7703d-fe76-4ab2-bef4-8d4c54da03ad@amd.com>
Date: Wed, 13 Aug 2025 11:40:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC V10 5/7] KVM: guest_memfd: Add slab-allocated inode
 cache
To: seanjc@google.com, david@redhat.com, vbabka@suse.cz, willy@infradead.org,
 akpm@linux-foundation.org, shuah@kernel.org, pbonzini@redhat.com,
 brauner@kernel.org, viro@zeniv.linux.org.uk
Cc: ackerleytng@google.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, pvorel@suse.cz, bfoster@redhat.com, tabba@google.com,
 vannapurve@google.com, chao.gao@intel.com, bharata@amd.com, nikunj@amd.com,
 michael.day@amd.com, shdhiman@amd.com, yan.y.zhao@intel.com,
 Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com, michael.roth@amd.com,
 aik@amd.com, jgg@nvidia.com, kalyazin@amazon.com, peterx@redhat.com,
 jack@suse.cz, rppt@kernel.org, hch@infradead.org, cgzones@googlemail.com,
 ira.weiny@intel.com, rientjes@google.com, roypat@amazon.co.uk,
 ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
 rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net,
 kent.overstreet@linux.dev, ying.huang@linux.alibaba.com, apopple@nvidia.com,
 chao.p.peng@intel.com, amit@infradead.org, ddutile@redhat.com,
 dan.j.williams@intel.com, ashish.kalra@amd.com, gshan@redhat.com,
 jgowans@amazon.com, pankaj.gupta@amd.com, papaluri@amd.com,
 yuzhao@google.com, suzuki.poulose@arm.com, quic_eberman@quicinc.com,
 aneeshkumar.kizhakeveetil@arm.com, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-coco@lists.linux.dev
References: <20250811090605.16057-2-shivankg@amd.com>
 <20250811090605.16057-11-shivankg@amd.com>
Content-Language: en-US
From: "Garg, Shivank" <shivankg@amd.com>
In-Reply-To: <20250811090605.16057-11-shivankg@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0089.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:268::14) To IA0PPFDC28CEE69.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::be8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPFDC28CEE69:EE_|DS4PR12MB9772:EE_
X-MS-Office365-Filtering-Correlation-Id: a38571e7-2cfd-4e2f-d6d6-08ddda30321f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cm41ZFVBakNrYVpPWnFzWlZRRUFrQTZZSmF1RFh3NWtvSmlwVzNmdlJUb3U0?=
 =?utf-8?B?MGlhcTdQckYwN2ttYWNRNCtGckVYY1IxUm5qYVdMSmNOdlg2eVIyZm9tZmVr?=
 =?utf-8?B?QlYwWDdTUkFKbnMrRm1WWC9tdDJrNURyYXhEMUJVdlNUd2N5amlaRjE2dFRC?=
 =?utf-8?B?SHlCVHNWcEFVdGMxRmVtZWFWbEdlTTd1dzFLaG1XZnBhVGlLbmd0czgwNk1F?=
 =?utf-8?B?NWdpQ3oybjFvVEdWV0pkdEFwT0xSa0NyZ0tadllzaFZyUFhkZFI5VHdDZHdy?=
 =?utf-8?B?THZGcGJnSjFOY0duOWMxUkxDZ01tSTIvMnVIVTR4dmtaNVlBVjg3LzVKQVVH?=
 =?utf-8?B?UTI0VEJkQTdmWE5CRVJETzRtOGlaVVBGbkNJVEh2cHhxWDdKOWhaM3FKbFpa?=
 =?utf-8?B?bFRGU1pCb3lKZkZaRHJNL0E2SzdSM003d0owQjhsS0ZqbXNwV2xlNXBDaEds?=
 =?utf-8?B?ajRNTm00by9TN3grY1ZmbGUvR1pDWmpmd1VTMHhEVUZGTG5JV25ObldLZWxS?=
 =?utf-8?B?dGFHS2czNHdIbllhamFZcVg4NlJSZlRFWEVrTUhOcDdCV0dZMWpxUUR6Q2w4?=
 =?utf-8?B?amU5aHJBUTJ1c3ZoY3pHM1JUWjhoQXAyaDR5NUNTRE1odVpBVVNKUHpPcHBU?=
 =?utf-8?B?QlFrbWdzY3JYRkxXbXEyTy93SnRGYk5mSXVtSzhTT2tObDlZSlB1Y3FVRkFF?=
 =?utf-8?B?WThkSVlsY2FIY2xUUzliQ2RVb2VQZVhQTUQ2UXkrSUd3dU9UQlpWMVFoYXFN?=
 =?utf-8?B?N29yRDZPQUtnbVpJY1NzU0M0d0c0Tnh5UzAzSnpTWGU4dGQ3blFVaERyTUUw?=
 =?utf-8?B?ajZDZWtrdURxc3lSN001dTc2S0xzcG16YWlsM3RmQnR0eU8vSTl0UGwzdVNQ?=
 =?utf-8?B?OW56THhvNko2dVRDUEV5Ym9oamdvaDlvbkpzNE93OGRJNWhiWlJJKzU5c0tq?=
 =?utf-8?B?NDlTVmFvRlNtVEZpQmNFeXNGRWVIbi9ndHRLcHdXNWhRaFMyM3NkZXVxeDFP?=
 =?utf-8?B?SHBkbiszWFJGd3hqSkpWMEhiSEFXK2JNT3ZVZGpUVzZWVVJ6RHdrb2c1YVNr?=
 =?utf-8?B?QkpYOE9LSVlBZS8zOU1TMFB5M1BPYk8yUDdkWTlKMnpIbEhNUXZrT3BpUnZH?=
 =?utf-8?B?Rm9DV3dKd1RTV3dSQ0s1TTJaaHdFTjYyeUx3NDU5R2dIdS9lTDl0NU10WGJ3?=
 =?utf-8?B?Q1VQOG0xYnl1ci85Y25GREF4bE1nTUtFMy9RczNpbVE5Um1RTXVBUFI4cnNn?=
 =?utf-8?B?UG5objlRWlpUanh4UGNPOEtwYjBuMnVNN1hONVI1SWltTi9jVFlPbjZQMVBF?=
 =?utf-8?B?MmtWSUl4Qzl1L3p3Ry9tOGYvaGpVdkhlcTlvSFVHT0U5UjM5ak9wWnJSYzVu?=
 =?utf-8?B?b1NnZWYwd1Y0ck10N005bjJNNEl4aHlGZDdaRGJhdmg0dTNuNkZHOWRWN3Fq?=
 =?utf-8?B?eWhMN2lIeFZnYlMxUENhRHppR1lGakNJM3c1Rm1vek44aVZIcGtYT3pZODdj?=
 =?utf-8?B?ZHRhcUNIU1FmK2ZXMjM2MHp1ZVU1MFRMNFk3czFVWHpEZTE2K3BGbHh3SUEv?=
 =?utf-8?B?NEhtenFldGx1enB0NGNqdS94OWhPOHFVSWlELzVEdFgzci85bjBLRlR4clBH?=
 =?utf-8?B?aTBlRGdjTVIvdjNwT1N4QnhramtQdGtEN3E0eFFCdW1pSFZ0ZEVZYnBuaEpS?=
 =?utf-8?B?bVBhZzhiaXM1WUUyRmtGQWw4SXBMVkhOQk5SNkhxZlJpa212c05HUDhIc0Jx?=
 =?utf-8?B?VDdHOTZ3elRUT2dPcERBRmtpTzJ0UzhHMmlLd2daSXJ4aWNkREE0YWI1VTM3?=
 =?utf-8?B?M3dJZ2RHM0FxNkt6M01Uc3RLNEkzeCtvTkhtOUo1aUl5RE9SK1dJeWlSakps?=
 =?utf-8?B?dmJKMHpkSkxkSy9tb3pVUlg2NEI5aTVkcHl1bTM2UDdqOGMrT3gvQURBK3ZO?=
 =?utf-8?Q?B6NVfuSgDrc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPFDC28CEE69.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3BWUjRZeHh1VXhhOHZYb1pRVVNDS1JIT3k0UHpBejdyT0loYnZUd29iRUoy?=
 =?utf-8?B?c3NNT1FmK3FTYllGSzRQS2xtVzFHOCtDZW02eFRuUlF3dzZSd2dVRTk2SFJE?=
 =?utf-8?B?MUtXbi9iTHJhdk5yOVFyZ2xyWUg4dEZrcHdDNU43WCtsTzU0bkRlT0tMSC9x?=
 =?utf-8?B?eFVzMkdkZXZBc1ljZk9Jc2NiNVNRTkJuT01FUGt4d1BGVEQrZ2UvZUR6T2xN?=
 =?utf-8?B?QVQ5c1Mzb1B6T1gwMDMzK2kxaDA0eHNSL1J6Y1Zaai9HOFhaWDBpelZReCtM?=
 =?utf-8?B?MUd4QmdJejN0R0doK2JabDFmUXpiQ0Zsa3lobEIrUmZxMlJLNVJkb1U5Mm5i?=
 =?utf-8?B?bkFSUkJiajJnREpvZC95T1BvZ1g4am9YVjl2UWpUazRwWm5TZTFxSFdQekNi?=
 =?utf-8?B?OTJzSTFwUXNJRzZpY1JjbDNLQW43SEdrUXJiVmJwMTNQNWNDMzJCTDAyRUh4?=
 =?utf-8?B?VnF4VkhCWFUzcitQMWMwZlE2MG1QTUt3RlFwVHF0cWNCMmVrQzZBYUJmdFJa?=
 =?utf-8?B?bWVBc1MvYldaRHdnenBQbGpqeWhsSHN6eTE3c2VzL3dxMDZVRHZWU3QzZFFj?=
 =?utf-8?B?RHZ3ZENVRWQxdFVkcWJFNitwRUd1aVp0RGoxNWlhNkxxaWhGbDlkRERlNWVn?=
 =?utf-8?B?R1N1K0dmKzdXR0FCRkhrVTVnN0VrQWZ2RUJXQmVEUThud2dwcTNGbno1RWFN?=
 =?utf-8?B?S2psQVM5clpRZ1lhNnVTNHJKNStWMUFsYlVnUitGcS9yT2RiMGN6clZTWlZj?=
 =?utf-8?B?eUdqd01lNUh2WjZXTGw3WGV6Y2hMMGF2ZVBHNFA4Nk1ielpSM0hLUldKWWNC?=
 =?utf-8?B?MjdQWWFSK0xNdDhoVFRUSWZjeExLcXhOSnhpdGdQWW0wYjlBNmZnZmJGOGlv?=
 =?utf-8?B?VlJPS1h3QjZVN3N3ZlBjM3JuT2ptU3orVzlUcUp0VFoxZ1o5VjFFUFNlN0hI?=
 =?utf-8?B?WDlTVlFCQVlUUzZkODJKNTQ4eDk4TXlsclNIZXRteGlzQUM0cWVmRmt3VGxh?=
 =?utf-8?B?ZStRVDFISk01K0hqcFFHYnB6TlpTV3lxOVFacFd3QklRK3RYbG1wbTVLNVps?=
 =?utf-8?B?TXgzRGdhUmJtdzZzMG9TZXROQTluRjFIcFVRMlNEV29ES29MQmRNZVllcUUz?=
 =?utf-8?B?VFZXYkFhMmx0elU5c1pwWjh5OWM2bXRaZElya3p2L2FFNXpNR1Y2TUdPUVFU?=
 =?utf-8?B?WW1Bc3Yvdmp3eFpKaWxTVnIvSlNBclY3M1ZTdXlzK3FzQ1laWXJRL3MzQUxC?=
 =?utf-8?B?ZHUyRHRQRktVRW5aSWQ4clBaN3FBVllUNlFHaS91dEZvZkFtcUlMM0kvaWIz?=
 =?utf-8?B?OW5lMkQ3TXdqSzBpVFY4cGIrWm1PUWlQYzhJOGszTUVuWkRBRVhRTnFoc0pJ?=
 =?utf-8?B?bjhubnVlQkxidktPUFdzbWRRWng1M1RaaUZNb3VpcXl0TnJEUUpqZzEwWXRh?=
 =?utf-8?B?dWVrY3BmZk9iMmphTlZRYXJZOCt4UHBwaVptN0swQzFvWkZ4TEttTkRwSUsx?=
 =?utf-8?B?T29kdW5VcE81T3M2NGI1U0VkTVE0RkZ5QTRHNUdlNUhLVkc2cGdPTi9NTk5V?=
 =?utf-8?B?MmRHNTEyTnZvdnFEb1hzS0VQeU5KUTRlNFFoM1Y4UGRXYi9Gd2p6Q1NlN3Ba?=
 =?utf-8?B?S2ZDTDJNMDl6L3F4Q1hrQWlkSWJrT1V2blc2NkFJUGIwUWJMckpYZ0tKeWRt?=
 =?utf-8?B?ODBpQTdzeTI5cmhFN05JMS9RTW14dHVqWEsxVFpvMXN3emo2dE1xekJLdFkz?=
 =?utf-8?B?ellRSEo5eXhMNG4rbTVZSWZ1dm9oL3NDRUF5K1hEZDB1QmxaTkQ4bGdyVGpR?=
 =?utf-8?B?dkkvNVlVZElLTFhoR0p3SmwxQ0dVL2xxZUVqZWVIYm1qS3QyQm8rMGhGR25T?=
 =?utf-8?B?TGdncG1VMTlPQW9vNWh0QVNlZlFqOXdzVTVLTU5lZGMyUEJkTG9ETnhRZ3Vo?=
 =?utf-8?B?Wmt4Q3VocWIzVlZXUHBIa3krRDRoTTRqalpoYVVGVGRXdk1jU3k1U016bkt2?=
 =?utf-8?B?bVVGL1UrajBRQ3FUWlhGSWFKZy8xaTNQZTJmdWxITnNoOVhxQ3loaDZzV0t6?=
 =?utf-8?B?aUNPVzFkM1BzSTBJVlZwWS9VQWZuWG9qWlJwNkNPVFhmWFRrdlZ6K3MxQklr?=
 =?utf-8?Q?tq1dIlfYhR49ys69Oe+SV2f7V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a38571e7-2cfd-4e2f-d6d6-08ddda30321f
X-MS-Exchange-CrossTenant-AuthSource: IA0PPFDC28CEE69.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 06:11:09.2586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Arp0evJTqNY0N4uZ4YCvSfJuLOtizEuyr7rGCdV1IM6RFIGGun2k4yzsnaZWJDF5M2BBqxpYbMe9EAPsNvevQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9772



On 8/11/2025 2:36 PM, Shivank Garg wrote:
> Add dedicated inode structure (kvm_gmem_inode_info) and slab-allocated
> inode cache for guest memory backing, similar to how shmem handles inodes.
> 
> This adds the necessary allocation/destruction functions and prepares
> for upcoming guest_memfd NUMA policy support changes.
> 
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---
>  virt/kvm/guest_memfd.c | 69 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 67 insertions(+), 2 deletions(-)
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 0e93323fc839..d9c23401e770 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -17,6 +17,15 @@ struct kvm_gmem {
>  	struct list_head entry;
>  };
>  
> +struct kvm_gmem_inode_info {
> +	struct inode vfs_inode;
> +};
> +
> +static inline struct kvm_gmem_inode_info *KVM_GMEM_I(struct inode *inode)
> +{
> +	return container_of(inode, struct kvm_gmem_inode_info, vfs_inode);
> +}
> +
>  /**
>   * folio_file_pfn - like folio_file_page, but return a pfn.
>   * @folio: The folio which contains this index.
> @@ -389,13 +398,46 @@ static struct file_operations kvm_gmem_fops = {
>  	.fallocate	= kvm_gmem_fallocate,
>  };
>  
> +static struct kmem_cache *kvm_gmem_inode_cachep;
> +
> +static struct inode *kvm_gmem_alloc_inode(struct super_block *sb)
> +{
> +	struct kvm_gmem_inode_info *info;
> +
> +	info = alloc_inode_sb(sb, kvm_gmem_inode_cachep, GFP_KERNEL);
> +	if (!info)
> +		return NULL;
> +
> +	return &info->vfs_inode;
> +}
> +
> +static void kvm_gmem_destroy_inode(struct inode *inode)
> +{
> +}
> +
> +static void kvm_gmem_free_inode(struct inode *inode)
> +{
> +	kmem_cache_free(kvm_gmem_inode_cachep, KVM_GMEM_I(inode));
> +}
> +
> +static const struct super_operations kvm_gmem_super_operations = {
> +	.statfs		= simple_statfs,
> +	.alloc_inode	= kvm_gmem_alloc_inode,
> +	.destroy_inode	= kvm_gmem_destroy_inode,
> +	.free_inode	= kvm_gmem_free_inode,
> +};
> +
>  static int kvm_gmem_init_fs_context(struct fs_context *fc)
>  {
> +	struct pseudo_fs_context *ctx;
> +
>  	if (!init_pseudo(fc, GUEST_MEMFD_MAGIC))
>  		return -ENOMEM;
>  
>  	fc->s_iflags |= SB_I_NOEXEC;
>  	fc->s_iflags |= SB_I_NODEV;
> +	ctx = fc->fs_private;
> +	ctx->ops = &kvm_gmem_super_operations;
>  
>  	return 0;
>  }
> @@ -417,17 +459,40 @@ static int kvm_gmem_init_mount(void)
>  	return 0;
>  }
>  
> +static void kvm_gmem_init_inode(void *foo)
> +{
> +	struct kvm_gmem_inode_info *info = foo;
> +
> +	inode_init_once(&info->vfs_inode);
> +}
> +
>  int kvm_gmem_init(struct module *module)
>  {
> -	kvm_gmem_fops.owner = module;
> +	int ret;
> +	struct kmem_cache_args args = {
> +		.align = 0,
> +		.ctor = kvm_gmem_init_inode,
> +	};
>  
> -	return kvm_gmem_init_mount();
> +	kvm_gmem_fops.owner = module;
> +	kvm_gmem_inode_cachep = kmem_cache_create("kvm_gmem_inode_cache",
> +						  sizeof(struct kvm_gmem_inode_info),
> +						  &args, SLAB_ACCOUNT);
> +	if (!kvm_gmem_inode_cachep)
> +		return -ENOMEM;
> +	ret = kvm_gmem_init_mount();
> +	if (ret) {
> +		kmem_cache_destroy(kvm_gmem_inode_cachep);
> +		return ret;
> +	}
> +	return 0;
>  }
>  
>  void kvm_gmem_exit(void)
>  {
>  	kern_unmount(kvm_gmem_mnt);
>  	kvm_gmem_mnt = NULL;
> +	kmem_cache_destroy(kvm_gmem_inode_cachep);
>  }

While testing my code, I discovered a bug that occurs when unloading the kvm_amd module
after a guest_memfd-backed VM has run.

dmesg logs:
[  610.075763] =============================================================================
[  610.083933] BUG kvm_gmem_inode_cache (Not tainted): Objects remaining on __kmem_cache_shutdown()
[  610.092711] -----------------------------------------------------------------------------
[  610.102368] Object 0x000000008ee52a58 @offset=19200
[  610.107247] Slab 0x000000004b1b088c objects=51 used=1 fp=0x000000007c55fc00 flags=0x57ffffc0000240(workingset|head|node=1|zone=2|lastcpupid=0x1fffff)
[  610.120733] Disabling lock debugging due to kernel taint
[  610.120741] ------------[ cut here ]------------
[  610.120742] WARNING: CPU: 7 PID: 7554 at mm/slub.c:1171 __kmem_cache_shutdown+0x264/0x370
[  610.120751] Modules linked in: xt_set ip_set xt_addrtype xfrm_user xfrm_algo xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4 nft_compat nff_defrag_ipv4 nf_tables overlay bridge stp llc cfg80211 rfkill binfmt_misc ipmi_ssif amd_atl intel_rapl_msr wmi_bmof intel_rapl_common amd64_edac edac_mce_amdmem_helper drm_kms_helper i2c_piix4 ptdma i2c_smbus k10temp wmi acpi_power_meter ipmi_si acpi_ipmi ipmi_devintf ipmi_msghandler sg dm_multipath fuse drm dm_mo56 async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq raid1 raid0 sd_mod kvm_amd(-) ahci libahci kvm nvme tg3 libata ccp irqbypass nvme_c
[  610.120831] CPU: 7 UID: 0 PID: 7554 Comm: rmmod Kdump: loaded Tainted: G    B               6.16.0+ #10 PREEMPT(none)
[  610.120835] Tainted: [B]=BAD_PAGE
[  610.120836] Hardware name: Dell Inc. PowerEdge R6525/024PW1, BIOS 2.16.2 07/09/2024
[  610.120838] RIP: 0010:__kmem_cache_shutdown+0x264/0x370
[  610.120841] Code: 89 f1 4c 89 f6 4d 8b 46 20 48 c7 c7 08 08 ec 87 81 e2 ff 7f 00 00 e8 fb a7 d7 ff be 01 00 00 00 bf 05 00 00 00 e8 dc e9 cd ff <0f> 0b 48 fe ff ff
[  610.120843] RSP: 0018:ffffcd6962963cb8 EFLAGS: 00010046
[  610.120846] RAX: 0000000000000000 RBX: ffff89fde07d21c0 RCX: 0000000000000027
[  610.120848] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff89fcbe5dbe80
[  610.120850] RBP: ffff89fde07d21c0 R08: 0000000000000000 R09: 0000000000000003
[  610.120851] R10: ffffcd6962963b58 R11: ffffffff889db908 R12: ffff89fdcccd7f80
[  610.120852] R13: ffff89fdcccd0000 R14: fffff96802333400 R15: ffff89fdd6ab6c00
[  610.120854] FS:  00007f066eaab080(0000) GS:ffff89fd3516f000(0000) knlGS:0000000000000000
[  610.120856] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  610.120857] CR2: 00007ffefd577828 CR3: 0000000220406004 CR4: 0000000000770ef0
[  610.120859] PKRU: 55555554
[  610.120860] Call Trace:
[  610.120862]  <TASK>
[  610.120866]  kmem_cache_destroy+0x3a/0x150
[  610.120872]  kvm_exit+0x7b/0xa0 [kvm]
[  610.120919]  svm_exit+0x5/0x10 [kvm_amd]
[  610.120926]  __do_sys_delete_module.isra.0+0x18b/0x2e0
[  610.120933]  ? srso_alias_return_thunk+0x5/0xfbef5
[  610.120937]  ? syscall_trace_enter+0xfa/0x1a0
[  610.120941]  do_syscall_64+0x7b/0x2c0
[  610.120947]  ? srso_alias_return_thunk+0x5/0xfbef5
[  610.120950]  ? __handle_mm_fault+0x2aa/0x670
[  610.120954]  ? iterate_dir+0x11e/0x230
[  610.120960]  ? srso_alias_return_thunk+0x5/0xfbef5
[  610.120963]  ? count_memcg_events+0xb2/0x160
[  610.120967]  ? srso_alias_return_thunk+0x5/0xfbef5
[  610.120969]  ? handle_mm_fault+0xb2/0x2f0
[  610.120972]  ? srso_alias_return_thunk+0x5/0xfbef5
[  610.120975]  ? do_user_addr_fault+0x16f/0x6f0
[  610.120981]  ? srso_alias_return_thunk+0x5/0xfbef5
[  610.120984]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  610.120986] RIP: 0033:0x7f066e12ac9b
[  610.120989] Code: 73 01 c3 48 8b 0d 7d 81 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 89 01 48
[  610.120990] RSP: 002b:00007ffc629f1878 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
[  610.120993] RAX: ffffffffffffffda RBX: 00005630e80256f0 RCX: 00007f066e12ac9b
[  610.120994] RDX: 0000000000000000 RSI: 0000000000000800 RDI: 00005630e8025758
[  610.120996] RBP: 00007ffc629f18a0 R08: 1999999999999999 R09: 0000000000000000
[  610.120997] R10: 00007f066e1b1fc0 R11: 0000000000000206 R12: 0000000000000000
[  610.120999] R13: 00007ffc629f1af0 R14: 00005630e80256f0 R15: 0000000000000000
[  610.121003]  </TASK>
[  610.121004] ---[ end trace 0000000000000000 ]---
[  610.121017] ------------[ cut here ]------------

There is a race condition here:
kern_unmount() -> mntput() -> cleanup_mnt() -> deactivate_super() -> deactivate_locked_super() -> fs->kill_sb() (guest_memfd kill_sb) -> generic_shutdown_super() -> evict_inodes() -> destroy_inode() -> call_rcu()

I should be waiting for pending RCU callback to finish before calling the kmem_cache_destroy().

To fix this, I added rcu_barrier() like dax_fs_exit() is doing.

@@ -561,6 +566,7 @@ void kvm_gmem_exit(void)
 {
        kern_unmount(kvm_gmem_mnt);
        kvm_gmem_mnt = NULL;
+       rcu_barrier();
        kmem_cache_destroy(kvm_gmem_inode_cachep);
 }


I'll incorporate this fix into next version.

Thanks,
Shivank

