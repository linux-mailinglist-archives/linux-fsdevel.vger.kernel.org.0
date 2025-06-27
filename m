Return-Path: <linux-fsdevel+bounces-53135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C90AEAE23
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 06:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F6261897DF9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 04:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1941DB95E;
	Fri, 27 Jun 2025 04:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WbJAwzc6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E451B4F0A;
	Fri, 27 Jun 2025 04:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750999813; cv=fail; b=lQQTZYTgvacnJb6nh3BpElpyGJlvKDmSpfpgnUX5gnAaK9PcYpDtOJ/C4Wmjy/ZkaijgnXvhWcdWEd5nnrx24GHtF3T1KurUcjHRhLGv1BWd5475+u4qhDflZmaO/YC5kctNadlXsCwMeNFEKylxtQXAx3PUSa8+QiEWQzKr2jM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750999813; c=relaxed/simple;
	bh=TZYwnNBWm01JqQDzmG9VWtpuo/mfncVsOQSDNVZbWCs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q0jEkN/g37rMOAXeRipmLxFWNFY370p39SElOgyGeToTbiSfyZn8y31pHskBXoJi/+vsQbPe3jEVY4vm9dpBTxOdLqb0TTVQES1uuGB7G3ea4D+7UbQvqJ3V7vz8EirCXPKi9kmD6+s2TrVXN4KL3ittlk+JZWmLcP0TCweXV0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WbJAwzc6; arc=fail smtp.client-ip=40.107.223.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=be9mZW7QwpVQ9qbRppfZauy1dwehRVM5dVK/bgG28AFS8hOtFCIhEXDsGQeb7baTwkydE0/Z5KbuleeDDZcqcmbbWzGTQHBBKVeYyl0uCTM9e8RwZkRL6j359yTd4fP3xxUCza1WIcQdUM/UikcDdL/yKAZe1h5gZTwBws0Av0tbRbWTGccdwKJIPEdH75k8iyntxY5vqBqFSkl5l5i6YAvSkO3xFVas0BK8c4gW8njHyLFPqBf39A4cZ0k/RXbJV/q15qM6cicnHq24FaW5e4uSEEIlIxqmqWr6BDxDvcLBhkel422YehRS2h5lAc+2K1FIesvM7XKeUl2uT4rGVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldthRCkoTsD2UKH4NGE7AwlciWimiB7HU90nzQP/XDY=;
 b=QV9Oxr51uuqS2kPx1FSTghWmbuMK4D4LvGtazHns4EkvoqDMfEgjK7mmKObdLxj2egtUCXn1TnYcYiEequWmh7Sre6rJ5xs5XLfSz2+kCLOL0WFInJjBrETSe7Gk6pVBSqFUNUB6KImIXCH0twJfSzzuDygKbGTjtTYUcE7h7b7gZYRfgRJDzZNrM+K+80Ku3/TA25X3SO+Myu4CUAkNHyXOJf0+ngea1OxbDI9lq/s5EDLwBBCSk2lREnDvzABQB35EW0bXSRgyr2n75baCkFMb7N5cnNZYJcdd1CTINH9Jv25b5jnA80oOZ5ZjDYG6pfniVRVscpWLQrB1ei7H7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldthRCkoTsD2UKH4NGE7AwlciWimiB7HU90nzQP/XDY=;
 b=WbJAwzc6FunNaq+PG664LiZg8O48Oc+LGk5n/ttQcPaRLmN7zqeuxOu5aIHwQ/H9AcZMcu5LqDI05OXhmtCSqIFQqYLbJ9HuVEiDGwsiGKUKIhKEfr65zoQGvXLqMu476+AelB0W2mX5v8eroH9DDmFPDp+0rUrTKV6jMSWscuY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SJ2PR12MB7990.namprd12.prod.outlook.com (2603:10b6:a03:4c3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Fri, 27 Jun
 2025 04:50:07 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee%7]) with mapi id 15.20.8857.026; Fri, 27 Jun 2025
 04:50:06 +0000
Message-ID: <31beeed3-b1be-439b-8a5b-db8c06dadc30@amd.com>
Date: Fri, 27 Jun 2025 14:49:43 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH v2 04/51] KVM: guest_memfd: Introduce
 KVM_GMEM_CONVERT_SHARED/PRIVATE ioctls
To: Vishal Annapurve <vannapurve@google.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Fuad Tabba <tabba@google.com>, Ackerley Tng <ackerleytng@google.com>,
 kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-fsdevel@vger.kernel.org, ajones@ventanamicro.com,
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
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <CAGtprH_qh8sEY3s-JucW3n1Wvoq7jdVZDDokvG5HzPf0HV2=pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SY5P282CA0085.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:201::16) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SJ2PR12MB7990:EE_
X-MS-Office365-Filtering-Correlation-Id: 2610c285-4e8e-48f4-80dd-08ddb5361664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFVGT3E2dWxJbWNEWGNTYVVWSkVUZFRSOExvdlZ4RWtxRjNieFh1TzhsbnpC?=
 =?utf-8?B?MW96dkEwVWtUK0QyMlI5Q3RxR1dzdk1yckpLRlY3Tkl1TDRDSS9kS3R1aGJz?=
 =?utf-8?B?ZU1oNjRlM2JwbDNQN0pEa2ZkQU50eHJaM1FRdWZmVVhkRVp6V295TGw1dWxO?=
 =?utf-8?B?ZFNPWlNTWlgzYXF5NzZUamxLN0lhY1FGWHdtKzlNTWNnUHhxeWVXSW1HWWtw?=
 =?utf-8?B?NzhPeURIVWt2cEpSeHBNSnVjWHMrUEhaL1JObmsyS2I1RjVrakZmSmtQT3Nx?=
 =?utf-8?B?THdGTXMrTFhyTVMyWFNtL01WckJJWVJVVjN6T1d2UUNURGdMcDlHVFNZNENo?=
 =?utf-8?B?c0NDbmcrTFNPbGtjclhQNDAyK1JjMStqa1R2WE9CMmNDVHhBcnNYckFKZG5D?=
 =?utf-8?B?d0pRd2lycU5JbW1FVGQvdnE5RzZIWWdPUVRQMlVVOVZUc1UrUEY2cU9meThZ?=
 =?utf-8?B?NysvRm5HZm1lMGV0aUEvT3NFdDFUQnVtZHpMYnk4QW9HenFFc1h6eXZLVUlL?=
 =?utf-8?B?T3RiZk4zQ2xtcjVsVUlqUDgrWEljS2JDdnF0ZXlMMmFVeGxwMmpMN0swNWV2?=
 =?utf-8?B?SlIvTzkrTWk3TkxzSDFKdHJrR05zbGhSa2lReEQrK0hBcVQyVGtkTlhXSU4x?=
 =?utf-8?B?TlBmUGUrelVyYjNUVWJ6R3NEWUN6QWZDV2hmV2pwZWdCTGlrMGVLaDViRzMx?=
 =?utf-8?B?S2RSNHdtS3grZGx0NnNJS2xVMm1aUVZBVDhHaDFkSHc0YjQrNEJ2alkwVkUr?=
 =?utf-8?B?ck82K3FBK0VBbzhxYjdLQi9TNjFJZ3o0bktlNEZhR3orbC96WWlsUHYxWlRw?=
 =?utf-8?B?ZEVYaWh2enkwWTFBU1ZGK1c1MHR4cXNDUjltdUVIT3AzNHJ5NkhQM2xYZjVE?=
 =?utf-8?B?NVR0QmRURUUvc3l4M0UwN3l1Skh3YmtyZHNySjA2ak1KMUFMeVdxOG82Y0tz?=
 =?utf-8?B?MVVrUzJxQ1JjS2FwWk42NjdoVExYc2c3cFE1Y0I4eU56a2JLVER3eHRwM2Rh?=
 =?utf-8?B?NDdoSFc0Z0Y1blRDOUV4V0FXZ2lOdHBlYlVnZllXYm1naTJLK2RpeTA4amxG?=
 =?utf-8?B?MUxYQ2xpSnloQzR2YzFUWUZFUFozRVBMcUVXRERKaGVONDRVZ3I1WjNJWlNl?=
 =?utf-8?B?ZHZUejVZdFRtYm5MTkowREQrZjVQYytUTWNLU3RObWt2cE1HeXowaU1SOVJa?=
 =?utf-8?B?Wm8xbk9TQitwZkdFY1c3VmNoek85RWFKQk0xa3gyclh0UkhXMmZPMVB3ZGhl?=
 =?utf-8?B?QWZQSnZMT2tlSTBNV0RDY2J3KzZoVlVNV3F2RDJvWlg4NVZTcGIxQ050U0hP?=
 =?utf-8?B?VWpGTHFvUm93anpMRnY2SkQvM0d4UEdvS1pjNC9Kalp3VGRKOTJqblFGNk55?=
 =?utf-8?B?eHFwOTF1UmlTUXlyTEpyU3psQ3dwdEswMXAwQno5UG5GVTRaRmtodlE0aVZB?=
 =?utf-8?B?U2hHRDRJT3BpTFBTTm9saWhuTUUxZ290ZzVyTWxHZDN3KzJ5M01aUU04dVBG?=
 =?utf-8?B?a3kzSXMzK2JTN2s1dGw3VG1ieGEvNFdhdE1neEhScWpRNXhRT2FnajhHVWpi?=
 =?utf-8?B?M1FXbXRIWm5LekNMSy8yR3RIWXdHRFBuQVd5OSthdlduay9yemdnUXpSa2Mr?=
 =?utf-8?B?L0xKL2tmWTJINGFJeDhFdVZpL2VMaXBHcXdhdVJQQmZMZXFYZ2R5NTBwZ2cz?=
 =?utf-8?B?djgvZTVCZEpxS2RUSDI1YlpzSmNtMHNNdFhjVjE0aWJOcnd3MEtYQThVeEFs?=
 =?utf-8?B?OS9lNVQwbmFJcFVuWTBRQVUxVkovdDFZTnZNRjV4MktPcXRYQitjQW1NWHdi?=
 =?utf-8?B?eFBGYU56WlNhKzk5bUJMY2RvTmJjSWwvcktmaDhjbG0ySTJhK2VOUGwzcFp1?=
 =?utf-8?B?TXphRHdmaFlxQ2t5RXRsbERIdS80UnBMaHR3Z0EweGVHWW5udDlvdzh3Q2Ft?=
 =?utf-8?Q?wntKXg6rc3A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjBEaFpCeXBGSTJjcGpMUVFFR296d3hCZXpWVVdxN2E1dE00eGdTODd4b0ZC?=
 =?utf-8?B?R2ZUMCtaUUpkc05EWjJWMzl5cU9Nc20zRWswcVAzR0d4TVJWcGN0Y1J3OFl6?=
 =?utf-8?B?YnZEb1VkUDZzQWw2Umx5eWdLd2pKRU1qVXZyZktKNlE2WEhLREY0d0hSZWdj?=
 =?utf-8?B?NDN5d05RaHh3ejlYNlVHVFhaclk2YjMrbzROQTRjNm5zU001L2tFNU1Rc3R0?=
 =?utf-8?B?NWJIVlI1QmE4YTMwV1hyaDB2RTFIVDVuZ2Y1V0FIZnZNaVEvV1EyZ3pWY3A1?=
 =?utf-8?B?WjRJQTFibDFSNWc4RktYVjdlM3lQeHl1Y0hSeHhlNmo4clNyOFdhWXNMMzIr?=
 =?utf-8?B?OXlmQ0NZMkhTMGhsZ3lDS2E2WTVvdzZ0RGhPbmIzRkc0VWNIczRPbFZCUEhM?=
 =?utf-8?B?UzdhaFJqTUpKWHdTbWNGbWdyUFk0N0tFWnNENjF0TmZhMy94TURFdE5EWTZx?=
 =?utf-8?B?UE9ZQk9GV1FLbmlQejRoZGRRM0Nkd09NTFljb0plM1hNbW9zY1JRVGF2T0JI?=
 =?utf-8?B?MHpGMlEwelgvQmFMdnNaNzVSUnFvS2lueE5mMkI3VmJSem9SNnFmTHdYREk4?=
 =?utf-8?B?b3NYQkpFMTVWbEZGb0JlWklyMHZPempxamwrd0RIemFOTTI1eGMyTDNDbWho?=
 =?utf-8?B?V0xXaEp4TktGZTdqWFlUWjFhMXpIb2hkc2tTMVoyaFZNK3JMVDlac1F3czBM?=
 =?utf-8?B?VThpckJmMzJaSDJiWWZYbFZZUkdKYmJZNzlrTkh3OGYxbkJOdmp1SHlsV2xv?=
 =?utf-8?B?ZU5DNlMxR0laRytxbDJjaHhJK0t1WlhXYmVad1h4Wm5BallKeWNoWW92S3NV?=
 =?utf-8?B?RFhxenNKZGRaYk1PUmtEekRyc2pBTDM1YUVjeVdsK1RlWG94eXBndmRSWXcy?=
 =?utf-8?B?UU1YbnQ4UkFvSWU4SE9HOWswRUhiRDIwZVFvNkNCWjc3anJVeFpISHpVWGdO?=
 =?utf-8?B?OXFrWERCMnBOVzZyZVhydVQzUFFZbm1ab2U5V05VMGxYajFJVHg5R25sRTdM?=
 =?utf-8?B?UDlHZ2tGOFVVUDkyRlZZSENXVGhvbVROTzBPczE0OE9hVEUraTQyVDh0Ynhm?=
 =?utf-8?B?a1RXMzFFanVyNzRXMU9GcjNSLzg3czdwU1ZpaUdhQjBEMXJQZlpYMVVlYmNC?=
 =?utf-8?B?VHQwTVMyYVBLMG5Jc2N4amU3WlFKcEx3TUk2aEF4QnFraGFpSUlzKy9XMUcz?=
 =?utf-8?B?Qm9uVTBWckNjNWhQVjROdHFrZlR1akJSbjN0MTFNSWhQdUk0NG1zcWlvdVNk?=
 =?utf-8?B?bGh4SnkyODRXb0NZZVk2dGh2eDNYL002Vm1hS3FwaFNHd3EwbWU3VUFmVExW?=
 =?utf-8?B?R09LUjNQUERQNnl4OS9pUjBsSG1iSFRXVllZY1pPR1Eyd0NncG0wWnZmaDh0?=
 =?utf-8?B?RlFHalZCOEx5cFJjbXVjWWpXalQ0eFVWN2FrMThwWHdGNGZtcDJ3Y0hUc2pS?=
 =?utf-8?B?QThQazJmcjVQZVJBT01uMnplRTJ3SE9uRU1mSVdYVkhBNm1KUWVDOGdJYkow?=
 =?utf-8?B?a0JBQXpRK0V0VDFGejRpVlNDSDgvMjY5VlZJdEQ4allvQkNLVWJJZGhxYnFy?=
 =?utf-8?B?OEttajFkUHRUYTdvaG1ZcTlMa0VzZkJINXR4QkJKY25QWVowWXBuVWhBQ2Nv?=
 =?utf-8?B?dWlTbWN2R2t0Mi9kYnRRL3BXYXZHby9qeUlJTUd3WUJWZFpmUVJlWjNkcVgr?=
 =?utf-8?B?TWtJQzJyQnRvVWtONzY2LzBzMmNSeDlkbVU0OWQ1cmNTVUZkNGpBUXIvWmNx?=
 =?utf-8?B?b0VzckhhZVdvTU85OU1oNWllN2hURE1IWXpVQ1dZeXVETjB5Z2hjYVZrT0Vo?=
 =?utf-8?B?Rmh0SzdwNDBRSDNZSk8yV3FMZ2llZ0xPUHVzejhhdnhEWGszSGo4OGZZcTBo?=
 =?utf-8?B?ZVd1Zkx5d2NJT2paa1dsK1lVaUQrTWdGK2VFOHh1dDNJcldnaFlVeDQ0M3lH?=
 =?utf-8?B?UGlvelJyYmJpa3lSbTBydzJGNlVtN3JzMUVoV3ZBcjBjZVpkNWNnbDcvLzNL?=
 =?utf-8?B?L1NwZjVOZmljcnRQUDNFVXNCN0Z6aU5aODIwM2ZibTNtQ2ltbitxYzRTemND?=
 =?utf-8?B?R1FmL1k4aTZjbjJGbWJIaVo2alB4Rlo3YnNqY2lVM1Jyd1luWjJ2YS9na25a?=
 =?utf-8?Q?1timBcrJpo96qmMNuFGPjxP+k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2610c285-4e8e-48f4-80dd-08ddb5361664
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 04:50:06.7181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: unBBOIG/ctRvFh6q8q2/rMm09W0Bt1IG5ALKEjDmCYBsMPV+9R9DfgMbRXDdfiBK2FCCbCLC1Zht1/p5/Q0TuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7990



On 25/6/25 00:10, Vishal Annapurve wrote:
> On Tue, Jun 24, 2025 at 6:08 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>
>> On Tue, Jun 24, 2025 at 06:23:54PM +1000, Alexey Kardashevskiy wrote:
>>
>>> Now, I am rebasing my RFC on top of this patchset and it fails in
>>> kvm_gmem_has_safe_refcount() as IOMMU holds references to all these
>>> folios in my RFC.
>>>
>>> So what is the expected sequence here? The userspace unmaps a DMA
>>> page and maps it back right away, all from the userspace? The end
>>> result will be the exactly same which seems useless. And IOMMU TLB
> 
>   As Jason described, ideally IOMMU just like KVM, should just:
> 1) Directly rely on guest_memfd for pinning -> no page refcounts taken
> by IOMMU stack
> 2) Directly query pfns from guest_memfd for both shared/private ranges
> 3) Implement an invalidation callback that guest_memfd can invoke on
> conversions.
> 
> Current flow:
> Private to Shared conversion via kvm_gmem_convert_range() -
>      1) guest_memfd invokes kvm_gmem_invalidate_begin() for the ranges
> on each bound memslot overlapping with the range
>           -> KVM has the concept of invalidation_begin() and end(),
> which effectively ensures that between these function calls, no new
> EPT/NPT entries can be added for the range.
>       2) guest_memfd invokes kvm_gmem_convert_should_proceed() which
> actually unmaps the KVM SEPT/NPT entries.
>       3) guest_memfd invokes kvm_gmem_execute_work() which updates the
> shareability and then splits the folios if needed
> 
> Shared to private conversion via kvm_gmem_convert_range() -
>      1) guest_memfd invokes kvm_gmem_invalidate_begin() for the ranges
> on each bound memslot overlapping with the range
>       2) guest_memfd invokes kvm_gmem_convert_should_proceed() which
> actually unmaps the host mappings which will unmap the KVM non-seucure
> EPT/NPT entries.
>       3) guest_memfd invokes kvm_gmem_execute_work() which updates the
> shareability and then merges the folios if needed.
> 
> ============================
> 
> For IOMMU, could something like below work?
> 
> * A new UAPI to bind IOMMU FDs with guest_memfd ranges

Done that.

> * VFIO_DMA_MAP/UNMAP operations modified to directly fetch pfns from
> guest_memfd ranges using kvm_gmem_get_pfn()

This API imho should drop the confusing kvm_ prefix.

>      -> kvm invokes kvm_gmem_is_private() to check for the range
> shareability, IOMMU could use the same or we could add an API in gmem
> that takes in access type and checks the shareability before returning
> the pfn.

Right now I cutnpasted kvm_gmem_get_folio() (which essentially is filemap_lock_folio()/filemap_alloc_folio()/__filemap_add_folio()) to avoid new links between iommufd.ko and kvm.ko. It is probably unavoidable though.


> * IOMMU stack exposes an invalidation callback that can be invoked by
> guest_memfd.
> 
> Private to Shared conversion via kvm_gmem_convert_range() -
>      1) guest_memfd invokes kvm_gmem_invalidate_begin() for the ranges
> on each bound memslot overlapping with the range
>       2) guest_memfd invokes kvm_gmem_convert_should_proceed() which
> actually unmaps the KVM SEPT/NPT entries.
>             -> guest_memfd invokes IOMMU invalidation callback to zap
> the secure IOMMU entries.
>       3) guest_memfd invokes kvm_gmem_execute_work() which updates the
> shareability and then splits the folios if needed
>       4) Userspace invokes IOMMU map operation to map the ranges in
> non-secure IOMMU.
> 
> Shared to private conversion via kvm_gmem_convert_range() -
>      1) guest_memfd invokes kvm_gmem_invalidate_begin() for the ranges
> on each bound memslot overlapping with the range
>       2) guest_memfd invokes kvm_gmem_convert_should_proceed() which
> actually unmaps the host mappings which will unmap the KVM non-seucure
> EPT/NPT entries.
>           -> guest_memfd invokes IOMMU invalidation callback to zap the
> non-secure IOMMU entries.
>       3) guest_memfd invokes kvm_gmem_execute_work() which updates the
> shareability and then merges the folios if needed.
>       4) Userspace invokes IOMMU map operation to map the ranges in secure IOMMU.


Alright (although this zap+map is not necessary on the AMD hw).


> There should be a way to block external IOMMU pagetable updates while
> guest_memfd is performing conversion e.g. something like
> kvm_invalidate_begin()/end().
> 
>>> is going to be flushed on a page conversion anyway (the RMPUPDATE
>>> instruction does that). All this is about AMD's x86 though.
>>
>> The iommu should not be using the VMA to manage the mapping. It should
> 
> +1.

Yeah, not doing this already, because I physically cannot map gmemfd's memory in IOMMU via VMA (which allocates memory via gup() so wrong memory is mapped in IOMMU). Thanks,


>> be directly linked to the guestmemfd in some way that does not disturb
>> its operations. I imagine there would be some kind of invalidation
>> callback directly to the iommu.
>>
>> Presumably that invalidation call back can include a reason for the
>> invalidation (addr change, shared/private conversion, etc)
>>
>> I'm not sure how we will figure out which case is which but guestmemfd
>> should allow the iommu to plug in either invalidation scheme..
>>
>> Probably invalidation should be a global to the FD thing, I imagine
>> that once invalidation is established the iommu will not be
>> incrementing page refcounts.
> 
> +1.

Alright. Thanks for the comments.

> 
>>
>> Jason

-- 
Alexey


