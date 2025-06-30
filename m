Return-Path: <linux-fsdevel+bounces-53237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84517AED1ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 02:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCC8D16FE44
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 00:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4412E41E;
	Mon, 30 Jun 2025 00:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VQ1BeiR9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E00FEEB3;
	Mon, 30 Jun 2025 00:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751242774; cv=fail; b=G76VQdDLxzX5yVltjfd/loaGQIbTVEhdrXX4BBMS7hTms6fn+QC0I00EReDKpWzncO939MDvtvyFO34HH6Bk7e2Dp3SHvyGlnpMcb6vA05FbyaYtpMFLWmBU2sG2Gy7V/oB/7G6Gu8352w17tdWa4WIUYoaJexSl3+PLqkuXsOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751242774; c=relaxed/simple;
	bh=xqUrn3BrBhagQJMMAO1BkfVr20IEX0eE82E+oFRblCs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vi+2L1hmmsBBgm7IHcusxPQHtifJfU/l1invU2hlDVELY4AMNpJ9aGmVRAeGxgtQBvXWu3fZco2s4X+vTWU2Kxh3VS/U90HxoB7sCaJHY2u6aR8RrplIxFVdGKbqqikWy8w/gD3m5AyHpAjaAxfe/tdYNzTUSp8nuwxvlm3hNZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VQ1BeiR9; arc=fail smtp.client-ip=40.107.220.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N9McsXIJxpEzF8tK/26GZgaGMgPahD83N/EUgmUJqaNpe1dekl0Jj6/Bbcr9i1bpa7/ql7LO1ya/PfHn1EZqHD9dS+ZfzH0FWvzKvkVKT33M2nLyLjjpc+BXMAjHpBTGzg9RHq2RPAdFSkvfI6C99Ish31to6GoDtXJaPubFYAxopwhFBjPa6RPfdTTSo812ZqNwKHblO8JW9EgpRkvM0leFtTE3UfsbxQGBD3lathp5VrGDIXeVrp7fjKwQwmiHUPEbMZGEoH+c1gmSoki3xI0OA6717mK/gzStw1dLHiqBSz2lI9/TPooXv0pabHnbmO9gyP+Fq9ogVheMYmVz2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKZfEhYkv8rOjqeiyKcnkzUfSUn4MBg9SzXHiw5N7K0=;
 b=WHQ2FldYbJhX25ISKvARDX9E/KaZiZTgxn/D+J1CJx++faFIluiMgiTFA3N4gUvnebgKgztBE5BYOpLE8JuVJQxtMolut1yYuQD4II1hrsqxShgSBup0kCwTodgsQBgAEFOlKQsA3DPRO+KDDaRob8zUjLidEfwMFhuLbzWbzT3NE7ddCO4Nvi5QnY6NccCWHOe+5bxobvCTsfi5ZuoRgqeqFK7YTo5nyqDqxJW+0pnASZ8TUzSR1j7RrSluYSTkA7rrYVSw3wKv41Wg/QNBZEkABK7yOBYSEoUt+u3znqDK0kWkRbDG04Ov5sC0c9z3grzG6gGHrQnre1483wfmHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKZfEhYkv8rOjqeiyKcnkzUfSUn4MBg9SzXHiw5N7K0=;
 b=VQ1BeiR9NYKpjHwsvQLr1lWCXy1eHIEFYiUsImCXVB2qlyp8ioduHeKG47MxZO+AF4oii11podmChxz4CMzdC62FyncrEvTKsVUuRTOTVcWO37kQikLtnAcH8oXe5VJ6wgamq3B8ICcIq6U6OKfJ5MgHSKY+A56jqMIpXpmff3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by BL1PR12MB5707.namprd12.prod.outlook.com (2603:10b6:208:386::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Mon, 30 Jun
 2025 00:19:29 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee%7]) with mapi id 15.20.8880.026; Mon, 30 Jun 2025
 00:19:29 +0000
Message-ID: <8f04f1df-d68d-4ef8-b176-595bbf00a9d1@amd.com>
Date: Mon, 30 Jun 2025 10:19:06 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH v2 04/51] KVM: guest_memfd: Introduce
 KVM_GMEM_CONVERT_SHARED/PRIVATE ioctls
To: Vishal Annapurve <vannapurve@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Fuad Tabba <tabba@google.com>,
 Ackerley Tng <ackerleytng@google.com>, kvm@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-fsdevel@vger.kernel.org, ajones@ventanamicro.com,
 akpm@linux-foundation.org, amoorthy@google.com, anthony.yznaga@oracle.com,
 anup@brainfault.org, aou@eecs.berkeley.edu, bfoster@redhat.com,
 binbin.wu@linux.intel.com, brauner@kernel.org, catalin.marinas@arm.com,
 chao.p.peng@intel.com, chenhuacai@kernel.org, dave.hansen@intel.com,
 david@redhat.com, dmatlack@google.com, dwmw@amazon.co.uk,
 erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, graf@amazon.com,
 haibo1.xu@intel.com, hch@infradead.org, hughd@google.com,
 ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz,
 james.morse@arm.com, jarkko@kernel.org, jgowans@amazon.com,
 jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com,
 jun.miao@intel.com, kai.huang@intel.com, keirf@google.com,
 kent.overstreet@linux.dev, kirill.shutemov@intel.com,
 liam.merwick@oracle.com, maciej.wieczor-retman@intel.com,
 mail@maciej.szmigiero.name, maz@kernel.org, mic@digikod.net,
 michael.roth@amd.com, mpe@ellerman.id.au, muchun.song@linux.dev,
 nikunj@amd.com, nsaenz@amazon.es, oliver.upton@linux.dev,
 palmer@dabbelt.com, pankaj.gupta@amd.com, paul.walmsley@sifive.com,
 pbonzini@redhat.com, pdurrant@amazon.co.uk, peterx@redhat.com,
 pgonda@google.com, pvorel@suse.cz, qperret@google.com,
 quic_cvanscha@quicinc.com, quic_eberman@quicinc.com,
 quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com,
 quic_pheragu@quicinc.com, quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com,
 richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, rientjes@google.com,
 roypat@amazon.co.uk, rppt@kernel.org, seanjc@google.com, shuah@kernel.org,
 steven.price@arm.com, steven.sistare@oracle.com, suzuki.poulose@arm.com,
 thomas.lendacky@amd.com, usama.arif@bytedance.com, vbabka@suse.cz,
 viro@zeniv.linux.org.uk, vkuznets@redhat.com, wei.w.wang@intel.com,
 will@kernel.org, willy@infradead.org, xiaoyao.li@intel.com,
 yan.y.zhao@intel.com, yilun.xu@intel.com, yuzenghui@huawei.com,
 zhiquan1.li@intel.com
References: <cover.1747264138.git.ackerleytng@google.com>
 <d3832fd95a03aad562705872cbda5b3d248ca321.1747264138.git.ackerleytng@google.com>
 <CA+EHjTxtHOgichL=UvAzczoqS1608RSUNn5HbmBw2NceO941ng@mail.gmail.com>
 <CAGtprH8eR_S50xDnnMLHNCuXrN2Lv_0mBRzA_pcTtNbnVvdv2A@mail.gmail.com>
 <CA+EHjTwjKVkw2_AK0Y0-eth1dVW7ZW2Sk=73LL9NeQYAPpxPiw@mail.gmail.com>
 <CAGtprH_Evyc7tLhDB0t0fN+BUx5qeqWq8A2yZ5-ijbJ5UJ5f-g@mail.gmail.com>
 <9502503f-e0c2-489e-99b0-94146f9b6f85@amd.com>
 <20250624130811.GB72557@ziepe.ca>
 <CAGtprH_qh8sEY3s-JucW3n1Wvoq7jdVZDDokvG5HzPf0HV2=pg@mail.gmail.com>
 <31beeed3-b1be-439b-8a5b-db8c06dadc30@amd.com>
 <CAGtprH9gojp6hit2SZ0jJBJnzuRvpfRhSa334UhAMFYPZzp4PA@mail.gmail.com>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <CAGtprH9gojp6hit2SZ0jJBJnzuRvpfRhSa334UhAMFYPZzp4PA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SYBPR01CA0093.ausprd01.prod.outlook.com
 (2603:10c6:10:3::33) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|BL1PR12MB5707:EE_
X-MS-Office365-Filtering-Correlation-Id: 4abed0c8-e1d2-4163-34ee-08ddb76bc767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2M3Y21STFR4bit3NDBuZmVTeTZVamZvRDVIMFc3Nm5Ha00zWGpiZDR3M1Zw?=
 =?utf-8?B?OFRLYlU5eXIxYWdmVTNtT2RJNVBVRTdPclBmQ2dYK0N0L1hBaTFYTXplam5C?=
 =?utf-8?B?VTcwMU83T2JPdXpMKzZlTkJmbVNzcjQ1bXE1MGhkaWtXa2g5bVVqTTBxZGdj?=
 =?utf-8?B?NW56amh0czI4VUVDejRWeUdwK0U2YW5LZm8rbXpRbWJJM3UvQ3ladENmSlVD?=
 =?utf-8?B?bFVMN1BmTmQrRmxwaXFvTEp6LzI2SXhlaEdmVktac1NLOHZBZ3o1QUIxRE5H?=
 =?utf-8?B?Rm95ZFoxQVhXV3dsZEZGaXB1L3ZHZUVzbVVnWkxxa3pXWkhsNHovazBNY1Bs?=
 =?utf-8?B?bE1BRU9iZFpTcHZDN2dlQ1Q1dERHYndYbGpuSE52VDcyb3hqUHpiT0FUajNZ?=
 =?utf-8?B?eURaY2h5TERIQjhHN1JvUWpQaGdFRUJTeTdJd3dJMzZUb3pqS0I0VTY1S0pS?=
 =?utf-8?B?SlR6QldIL3Z3RE1RbThzWkJ2VWNUSmFEUGE2bXBVMUtiQkU4UWNrOHFvQ1Az?=
 =?utf-8?B?UFh2WlYzRDhnVGhMTzdtVWRlZ2d5aHBEN3FzSDJFUldJSWVLYjd4VXcxWVp2?=
 =?utf-8?B?Yzkvc09IMGZ2cTJRcWR0bXQ2cjF4RlAzdU9ReUxkT1FKb1NrMHRQSE5QRjZP?=
 =?utf-8?B?Q0h0NG9pUThzL1FJdklqemlvdE50Y05za0ZGbkMvKzQ0Zm16cG4rVHp2dk96?=
 =?utf-8?B?eC9CWU5wNlBuU09uanE4S2x0aXZlakZTakVPODczUXBHK2dvQXB6dzZ0NElJ?=
 =?utf-8?B?cU0rMFEycWtDUk9odzZsR013TWdyZHBFS0wydmx6MVFZMkNleFUxTlZ6YVoz?=
 =?utf-8?B?TmJJeGZLalZQUUtGK0RKL2FFN09lUkMvemt3Sm5ORjBQRFdnK253b0VPK0pU?=
 =?utf-8?B?S1JaSDZDMmx4OEg2ZnhKbjJOQ25TR0NyMTFnMGdyK0VLQUx2eTdEOFlidUtT?=
 =?utf-8?B?Z3loWTk1Q284enBqZW1NNlRQbmlsbEY1cDhMNnFkN1lVT0RmbzROVDFZbTR6?=
 =?utf-8?B?RTRIVGQzNURLaEVCaWtaLy9aWkw1R0hTbWdjNjFpK2JKUUtiY0U4Zzg0QnpT?=
 =?utf-8?B?WVdUbTdjeXVZZHgyYkhLbld6WCtwWTI3bHRsdEx1UElpL2xGaVl3SGdNanFQ?=
 =?utf-8?B?OHlGTFYyMklUWmRzUVlkc3NjVDdvS2p4ekpxQjBNSm9hdEUybEMwNXlDQlFC?=
 =?utf-8?B?VFVXMUU5Y0lMZ0JMdDFTMEhjZGdnN253R25TU1VNUnoxQzBFUmh2V29FcGh1?=
 =?utf-8?B?bXNiZFc4dzNudHFuVitNbXpzbmJJaURNRjFXS2Y4cjRla3lITUZ4RE9RZHFE?=
 =?utf-8?B?Q3ZUTVVVdnFocFlCOCtMMEM2aTF2RGFldStKV1U5OUJITlo5dDgyUDd2S01T?=
 =?utf-8?B?Qk11cjh5WHdDYVZ0RHBsYzZBUXlHMnVIYlZ4N1BubUJFdS9tNDEzTlJNNmFm?=
 =?utf-8?B?M0FJUWFnQ3Y3M1E4cEFjUGdEVUJzb3gxd1VnNTN4NEpZWEhURU1yUkdNMEQ0?=
 =?utf-8?B?YmdFUS9pMVc4YlAvd05IUUpoSE9TQkRFTTJPbDNCV0h1L3RDQ3pNSHo3ZGFr?=
 =?utf-8?B?eW45aUpBc294R1dTVGQ1aWpDY0RpTlFzaVRteUdiNjBDQit5ZkNhQmhYTTJQ?=
 =?utf-8?B?OEUxa3I1VmNEeUNFemR3eUNsU1JiWXNGcGh4Qm4wOVRvZmRTZ1BqMWlpWE1q?=
 =?utf-8?B?VE1ZNlRIWjAyakZIUFg5RlJHSStGbGY0VWRURzhHYkVTSkFBVm5EbkRmTFVY?=
 =?utf-8?B?VTRFNVY3UkQzeldLeGpYQXZGaVhtYWd2SXNXQVNGOTJ4YWNUWWNvVVV5cit6?=
 =?utf-8?B?NWhhU0FXbXd5T0RKYUhNVmxrOGpnMzk0NDZ5Zlg2a1EyZ0ZhbkhhR3hCamJH?=
 =?utf-8?B?V3VNTExiZVhYWWFUQ0tyd3o2MjlPOXd5K0JYZlIrMlNsQ0hoVXJCMTNCci9G?=
 =?utf-8?Q?baHErlcHvLM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VytUWjVHOStzaWNReVZaYm8yaUQ4NXpiWjBkV2hSajFVZjZLQkRIakdiR0pC?=
 =?utf-8?B?ZS9HaE9pVFFxdkt5cGZsRHpQbklwZ1A2NC9FUXlsSGhEeGxEUjVRNkFGY2V3?=
 =?utf-8?B?WEJNdytrNWExQUY1N0hleFRaZ1hpUXVDMjdodUQxOThkRUJNUzdEM3dmTGZS?=
 =?utf-8?B?dWJ6MFRBNVlhYnlOZzI2c0JoVUVsdWdYVVdROFZ1dksvNXVnVWZiTjlaYmhC?=
 =?utf-8?B?Sy9xV3Z6cTNxZkc5MEU5WExrMXUxVTRyNlE5TkQrNjVMbUpoT0dZclpERWNF?=
 =?utf-8?B?UnRVQVg0TWUrc3FPL1NhSUNZTmJnbDJ1d1pXODNyL3I5VGZpb0gxTitxTXEy?=
 =?utf-8?B?RGF0V3RaL2tXSk52SVV0MkZpbmQ4bWcrcWx5djdQT0dCWWF2cHdIYUJEWFBL?=
 =?utf-8?B?eWRJMnJPVGVaemdjM21RL25GVVVxUnFhaVU1QTBTKzkxU1ZaWGdvZ1hXRWNH?=
 =?utf-8?B?UTVSNjdhTWEydGJaWC83cjVEV2tqRkhRYk5rN1lSTlNUbkRWOHRxaHFHb2NF?=
 =?utf-8?B?aHZPSEhPaGtTUXoyK0I4YlRtQ2VweFVNMy9lcVBnNWtyRGdZNnhlbnZ0S1ZV?=
 =?utf-8?B?SlhpN2p5UjArL0lBSldMSUFTRnhsV3ozdkNBajBQNTdJZEE2RnNia2RFUE9u?=
 =?utf-8?B?TTFhZ3U2ZzNqNGJpNjVVcjBxSGJZNU1qc1RTNU5lcVFST0ZONjhuWFBlbkdo?=
 =?utf-8?B?ZWV2Mmk3eHh4dkZmN2N4WnJhVHlNdnZDYUJzT3dvV1Jib0JudjdNNlR5dXR5?=
 =?utf-8?B?Qzhwb2Rmc1JQdHRkcGttOTBhZFg2VEZ2SEVXY2Z2OTNGcFZNRStEUlFXY094?=
 =?utf-8?B?UGZQWm5wdC9SQ2pXZDZrRWp3b0UrSlRxeEgwZVZXcFpRSHRHU004bnNZOUxh?=
 =?utf-8?B?U244MGpqZlpxR2FuYlVpQmpZRHgrQmRTS2IvTnRQbEdMTFJCVnlJVmhZeGJ2?=
 =?utf-8?B?enpMK1RLc2s4bGxKWGxzRVZac1I1Uk5jdUNFeFEvbytlSGFycGdVcWlQZk9M?=
 =?utf-8?B?SWVGeGdOZ09iaWx0RzNjdXlneW15OGEvcFpPVnZyQmk5QmNTM0ZBVnhaRWxa?=
 =?utf-8?B?OVNQMUowdWVrWmVlYmN0VXRzaTVJYkdHcWlRU2FVSWE3dmxDMTNJaHVqRUxX?=
 =?utf-8?B?eWRaU0pYQjBMc1IvaTBRTUQwNFRia29Ydk8vK1RPNnMwQ1lLd0pzZEVJVy82?=
 =?utf-8?B?WURCSGZ4N3J4bFNxaUtySlozSlg0b3BtY1BqK0RwclJ6enhhbCtCUXllU2ps?=
 =?utf-8?B?QmpWK21LZndBaXlRdlFGUDhoWDFTVUo5Y0hwNWlocUQ5UXQzRkhDTzNuRElk?=
 =?utf-8?B?NG43K3lrM1BSRkhPRWdhYnhINGhkNzBESGJnNHRyb2dXczB4Kzh2VUsvdHQ5?=
 =?utf-8?B?M0ozNFlVRGRRVEw1LzlSdWRYeTFMS3lEbm51KytTdit3OGcybTVON1Jpc3U5?=
 =?utf-8?B?WFhiSTJkUzFvOG5sUVNKRjIzYmVJOHE5R2xWd3ZzTkNra25tMzRJTlNuUE82?=
 =?utf-8?B?K1ZibCtJOGR4MmNkZ0NwVEpIZXljZ0JKaExUR2FRdkxuK1ZnSE55STVnS2lG?=
 =?utf-8?B?cldHemR4bTIyV0FpaDh2NVlnVkdFNjZXQVdWclVLSGNPcll5b3UrQnlXUGZH?=
 =?utf-8?B?UE5QdStHdGRtcHZGMnF0bFBZUjJPK2dpZVJ6OER6MDZMVWM4VXBnTndsWGVF?=
 =?utf-8?B?WDhWZk1idmdneGVlNnMzU2hhRTNvZ2xIRkp3OGR5K01RNVpHcDduUHFETGI0?=
 =?utf-8?B?ZlN6V0kwemFiMkd6Wm43S1lKN3BqazlFTjMrMEp2UUNveGhSazZLQjRyalhy?=
 =?utf-8?B?a3NoQlc0K1BWRDkyRkxxMFVaS1l3QmM1enMxNnFtUGFWdXA3Y1ZJbndVbUp2?=
 =?utf-8?B?TWlXc2tSbksrU1ZBVDBtSGRyaWRjbFpmeEw5dy9ybnFYclg0Ty90UkZEMnFz?=
 =?utf-8?B?WFF3ZzAvTUV6a0owa2szWTFUcUNrVlZtSkpGc2dRdUMxa2RVcTR3TGhCUjhZ?=
 =?utf-8?B?MCtZRVFMamZhWnZ6RXo1UUsrMDVGTG1Sa2VwNHVFWERWR2pBeDl2djJKMnZR?=
 =?utf-8?B?OEp5MGlpUFJlZWRhVzlBWjArZkEvKzY2Unk4c0NqbmRBdW5xd0F0NGFTblZ6?=
 =?utf-8?Q?9kSUxaLX/uqhqotfa9r5TPZz+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4abed0c8-e1d2-4163-34ee-08ddb76bc767
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 00:19:29.3665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ox70zgkklx8Gbahe4j4eZMkAAll5u/R1bt7+C2TZJvQIsYx4GCgF/jzV8EPqZBaxpEQKyPKIGPzX9SUpfNcIpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5707



On 28/6/25 01:17, Vishal Annapurve wrote:
> On Thu, Jun 26, 2025 at 9:50 PM Alexey Kardashevskiy <aik@amd.com> wrote:
>>
>>
>>
>> On 25/6/25 00:10, Vishal Annapurve wrote:
>>> On Tue, Jun 24, 2025 at 6:08 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>>>
>>>> On Tue, Jun 24, 2025 at 06:23:54PM +1000, Alexey Kardashevskiy wrote:
>>>>
>>>>> Now, I am rebasing my RFC on top of this patchset and it fails in
>>>>> kvm_gmem_has_safe_refcount() as IOMMU holds references to all these
>>>>> folios in my RFC.
>>>>>
>>>>> So what is the expected sequence here? The userspace unmaps a DMA
>>>>> page and maps it back right away, all from the userspace? The end
>>>>> result will be the exactly same which seems useless. And IOMMU TLB
>>>
>>>    As Jason described, ideally IOMMU just like KVM, should just:
>>> 1) Directly rely on guest_memfd for pinning -> no page refcounts taken
>>> by IOMMU stack
>>> 2) Directly query pfns from guest_memfd for both shared/private ranges
>>> 3) Implement an invalidation callback that guest_memfd can invoke on
>>> conversions.
> 
> Conversions and truncations both.
> 
>>>
>>> Current flow:
>>> Private to Shared conversion via kvm_gmem_convert_range() -
>>>       1) guest_memfd invokes kvm_gmem_invalidate_begin() for the ranges
>>> on each bound memslot overlapping with the range
>>>            -> KVM has the concept of invalidation_begin() and end(),
>>> which effectively ensures that between these function calls, no new
>>> EPT/NPT entries can be added for the range.
>>>        2) guest_memfd invokes kvm_gmem_convert_should_proceed() which
>>> actually unmaps the KVM SEPT/NPT entries.
>>>        3) guest_memfd invokes kvm_gmem_execute_work() which updates the
>>> shareability and then splits the folios if needed
>>>
>>> Shared to private conversion via kvm_gmem_convert_range() -
>>>       1) guest_memfd invokes kvm_gmem_invalidate_begin() for the ranges
>>> on each bound memslot overlapping with the range
>>>        2) guest_memfd invokes kvm_gmem_convert_should_proceed() which
>>> actually unmaps the host mappings which will unmap the KVM non-seucure
>>> EPT/NPT entries.
>>>        3) guest_memfd invokes kvm_gmem_execute_work() which updates the
>>> shareability and then merges the folios if needed.
>>>
>>> ============================
>>>
>>> For IOMMU, could something like below work?
>>>
>>> * A new UAPI to bind IOMMU FDs with guest_memfd ranges
>>
>> Done that.
>>
>>> * VFIO_DMA_MAP/UNMAP operations modified to directly fetch pfns from
>>> guest_memfd ranges using kvm_gmem_get_pfn()
>>
>> This API imho should drop the confusing kvm_ prefix.
>>
>>>       -> kvm invokes kvm_gmem_is_private() to check for the range
>>> shareability, IOMMU could use the same or we could add an API in gmem
>>> that takes in access type and checks the shareability before returning
>>> the pfn.
>>
>> Right now I cutnpasted kvm_gmem_get_folio() (which essentially is filemap_lock_folio()/filemap_alloc_folio()/__filemap_add_folio()) to avoid new links between iommufd.ko and kvm.ko. It is probably unavoidable though.
> 
> I don't think that's the way to avoid links between iommufd.ko and
> kvm.ko. Cleaner way probably is to have gmem logic built-in and allow
> runtime registration of invalidation callbacks from KVM/IOMMU
> backends. Need to think about this more.

Yeah, otherwise iommufd.ko will have to install a hook in guest_memfd (==kvm.ko) in run time so more beloved symbol_get() :)

> 
>>
>>
>>> * IOMMU stack exposes an invalidation callback that can be invoked by
>>> guest_memfd.
>>>
>>> Private to Shared conversion via kvm_gmem_convert_range() -
>>>       1) guest_memfd invokes kvm_gmem_invalidate_begin() for the ranges
>>> on each bound memslot overlapping with the range
>>>        2) guest_memfd invokes kvm_gmem_convert_should_proceed() which
>>> actually unmaps the KVM SEPT/NPT entries.
>>>              -> guest_memfd invokes IOMMU invalidation callback to zap
>>> the secure IOMMU entries.
>>>        3) guest_memfd invokes kvm_gmem_execute_work() which updates the
>>> shareability and then splits the folios if needed
>>>        4) Userspace invokes IOMMU map operation to map the ranges in
>>> non-secure IOMMU.
>>>
>>> Shared to private conversion via kvm_gmem_convert_range() -
>>>       1) guest_memfd invokes kvm_gmem_invalidate_begin() for the ranges
>>> on each bound memslot overlapping with the range
>>>        2) guest_memfd invokes kvm_gmem_convert_should_proceed() which
>>> actually unmaps the host mappings which will unmap the KVM non-seucure
>>> EPT/NPT entries.
>>>            -> guest_memfd invokes IOMMU invalidation callback to zap the
>>> non-secure IOMMU entries.
>>>        3) guest_memfd invokes kvm_gmem_execute_work() which updates the
>>> shareability and then merges the folios if needed.
>>>        4) Userspace invokes IOMMU map operation to map the ranges in secure IOMMU.
>>
>>
>> Alright (although this zap+map is not necessary on the AMD hw).
> 
> IMO guest_memfd ideally should not directly interact or cater to arch
> specific needs, it should implement a mechanism that works for all
> archs. KVM/IOMMU implement invalidation callbacks and have all the
> architecture specific knowledge to take the right decisions.


Every page conversion will go through:

kvm-amd.ko -1-> guest_memfd (kvm.ko) -2-> iommufd.ko -3-> amd-iommu (build-in).

Which one decides on IOMMU not needing (un)mapping? Got to be (1) but then it need to propagate the decision to amd-iommu (and we do not have (3) at the moment in that path).

Or we just always do unmap+map (and trigger unwanted page huge page smashing)? All is doable and neither particularly horrible, I'm trying to see where the consensus is now. Thanks,


>>
>>> There should be a way to block external IOMMU pagetable updates while
>>> guest_memfd is performing conversion e.g. something like
>>> kvm_invalidate_begin()/end().
>>>
>>>>> is going to be flushed on a page conversion anyway (the RMPUPDATE
>>>>> instruction does that). All this is about AMD's x86 though.
>>>>
>>>> The iommu should not be using the VMA to manage the mapping. It should
>>>
>>> +1.
>>
>> Yeah, not doing this already, because I physically cannot map gmemfd's memory in IOMMU via VMA (which allocates memory via gup() so wrong memory is mapped in IOMMU). Thanks,
>>
>>
>>>> be directly linked to the guestmemfd in some way that does not disturb
>>>> its operations. I imagine there would be some kind of invalidation
>>>> callback directly to the iommu.
>>>>
>>>> Presumably that invalidation call back can include a reason for the
>>>> invalidation (addr change, shared/private conversion, etc)
>>>>
>>>> I'm not sure how we will figure out which case is which but guestmemfd
>>>> should allow the iommu to plug in either invalidation scheme..
>>>>
>>>> Probably invalidation should be a global to the FD thing, I imagine
>>>> that once invalidation is established the iommu will not be
>>>> incrementing page refcounts.
>>>
>>> +1.
>>
>> Alright. Thanks for the comments.
>>
>>>
>>>>
>>>> Jason
>>
>> --
>> Alexey
>>

-- 
Alexey


