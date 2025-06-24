Return-Path: <linux-fsdevel+bounces-52693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DB1AE5F0A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 10:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D6D93A8C83
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 08:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844D6257AFB;
	Tue, 24 Jun 2025 08:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="12DyVZXI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0255686347;
	Tue, 24 Jun 2025 08:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750753462; cv=fail; b=S5lxPCCBjiAAhMT7vRV9fiOxmLUjkxB9udaKVo7NrrIvh3xpZy/N/3LFCfbc17tInhA+Szv20Vy2OKA9dXUudTJvG8zhP9wtZ0ETOBQiOFYmP9v8ZXm9yxLks5C8xqQ7kw6ZohYHPhpcn6JS6nSF5axmQIe/dQEed5/qnoF1PN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750753462; c=relaxed/simple;
	bh=q4lyBATilm7PLbLZdh/VB8k+YamC2yIZoUMjgMyjkJ8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=unV25nu9uv15P0NBM57glorTDVuEZXx2WRspEQJC3hCKne4uKSafQO5uDaWSIjO/xgSAr7VzrK910DYDoftObwPHS0ncTyyMSt//3NgYHxFuEk895ycEOR1pKAHmh811rf7UreDYI8IS56cj59pcXe5mA4o4Q7D2E1Glcr22eHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=12DyVZXI; arc=fail smtp.client-ip=40.107.237.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NvugGbZX4ieXB6SCHeU0m1KmbW6oqiT3gPKUkKTdqaDqZbQx8zpB9NP/5Rj86Tr+KapmjzdmK74dSPdF9anrbFOO0GsKGbPEs9v3115G7cvr1ycL4XP6jOBU1+o4XrOB/8Kd+8RObN12veBOvbojVkK33TiRuSBSEGrQaL8h8Ka+JJZDVrSvym56jQ6cBmcZTWsjsbvisqLHStih39XyHLMq839+NrixDQQQHmSEeU8hnKayzMi39Qk4yMeEAax2p8bG7Yf+ybJLaew6pNa+45R8XlhpF898cs5E9W9IFW2tuj0VW1ADAZ+0juCxc8FWkeqTt0c+T2oYav+ur2TdUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5NIIpv1xH0QXtcx+HOG4mcBFgX1tYikfsP5vA+BS/Y=;
 b=pRdQNBzP8/EWQipnQKwxQqak/GcirmihNOj0ePo3FjNeM5eSL3prUJsnAVwKmva4UVmiRysctHjrJlgTJZOif1rKCjCzOyxt8Gc3ucXu4+ma3gIGqg1Ue1tjFE1aeZ6S0Gn0JcD4i7fwbocSJY7mHyOCLQM+mIXwIlw/21bVLKgOoJfkFbFgS57vEYeZ0RTPkz4ZSHps+67RYtfblHX1RD92Wrp8oOUXxr+E7r0Y7LQSa41qZ3ht//I3HgsBItUwRLDhYQoP/UOPKnuzCp6yzq9vgRDtwN4xoGkk6CobRZkUrsguO9RHG4OXv3ulpYfW1qaA/idlaQSy/+b9CWqTtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5NIIpv1xH0QXtcx+HOG4mcBFgX1tYikfsP5vA+BS/Y=;
 b=12DyVZXI9HGIWcHeuZjnnz+wcJ/PamsfQtnTZAPOHEyPBHrvsMLri6E8079hnMfTic7s/AMYImchj2xFnxV/tBK32Iz+3x01s7oLIflIdR/vTpt34auqd1NcsmQuRKGzbIZO0g/vl/29Vu6SuAkyRFpPaiwIGwYR9KWNMolqz7o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by PH7PR12MB8179.namprd12.prod.outlook.com (2603:10b6:510:2b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 08:24:17 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee%7]) with mapi id 15.20.8857.019; Tue, 24 Jun 2025
 08:24:17 +0000
Message-ID: <9502503f-e0c2-489e-99b0-94146f9b6f85@amd.com>
Date: Tue, 24 Jun 2025 18:23:54 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH v2 04/51] KVM: guest_memfd: Introduce
 KVM_GMEM_CONVERT_SHARED/PRIVATE ioctls
To: Vishal Annapurve <vannapurve@google.com>, Fuad Tabba <tabba@google.com>,
 Ackerley Tng <ackerleytng@google.com>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-fsdevel@vger.kernel.org, ajones@ventanamicro.com,
 akpm@linux-foundation.org, amoorthy@google.com, anthony.yznaga@oracle.com,
 anup@brainfault.org, aou@eecs.berkeley.edu, bfoster@redhat.com,
 binbin.wu@linux.intel.com, brauner@kernel.org, catalin.marinas@arm.com,
 chao.p.peng@intel.com, chenhuacai@kernel.org, dave.hansen@intel.com,
 david@redhat.com, dmatlack@google.com, dwmw@amazon.co.uk,
 erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, graf@amazon.com,
 haibo1.xu@intel.com, hch@infradead.org, hughd@google.com,
 ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz,
 james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com,
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
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <CAGtprH_Evyc7tLhDB0t0fN+BUx5qeqWq8A2yZ5-ijbJ5UJ5f-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SY5PR01CA0041.ausprd01.prod.outlook.com
 (2603:10c6:10:1f8::16) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|PH7PR12MB8179:EE_
X-MS-Office365-Filtering-Correlation-Id: 83a6d231-1ce5-4521-6e26-08ddb2f8829e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVlNTkFmNmR3U3BWMGZGaDZBYUorNUZtOFh4cTRqdEpFQnJzaWxRenVCSjBJ?=
 =?utf-8?B?eDdBM1lSRmJLd2lQUGtlczBtWkxjQ3pOQjFEbTlvellpZDlpQnVZSTA3dXI1?=
 =?utf-8?B?WlgyWS96ZkczOG5Hekg2dlJZOWo4Q2QvSWhBa0xnd1EwRmJKTkVzYitwTjNF?=
 =?utf-8?B?dnB0S3orWlRtZ1pjbkNTaG1RNWovOUFRYXNiWk4yc0haWEdGSTNnODN4MG9m?=
 =?utf-8?B?N2JVWUtKTDYyLzhwRDA0dytyT0p1Vk9WOC9vTXlIV1QxRFR3bTV0RVJBVVRn?=
 =?utf-8?B?ZXJaNlhoNUdaZVhrejA1S2hmb2dCVUxpODd3U1JWVDhyM3dXQk5sbWx2a1Fx?=
 =?utf-8?B?RzJ4dHg3cVh5Rk1WWERTZU04K2R2UmdKQU5HeHpoNGdCNkZEdkpNNXdraDYx?=
 =?utf-8?B?WEVPN1VzYTNRTnhaUm1MRm9CMW1oaWZtN3RiYkFvakF0bURDZ1NFVFhhem1h?=
 =?utf-8?B?cnZOWksrSHl6V0grNDhiOUNzbHZDckFJMFI5OUpjNlZrMGVYMm41WkxISDRm?=
 =?utf-8?B?QmdweHNYODZuSXVKWHZoUEVaTVhuZmV5blZYNm9pbWR1VUxnY00vMC9OVUdv?=
 =?utf-8?B?SjFGa1BEQ3RPT3YyeUx6eTZFQkxodnNId2crU2lRQ01kTEdLaDg4ekNHSUoz?=
 =?utf-8?B?cVVqaEtoYnV1cWdxejFTam5abjA2YUcyZCt4WDlDM2NhV2ZabDlYRmtlcnA1?=
 =?utf-8?B?N2hMMmRiQVQvSTN2WllzQ0VNRVJ0MTZCNEc3OXBkN20xbEhHNVlaUVQ1aHNi?=
 =?utf-8?B?MVNuOXlRODBZVXM0VWxJMEpGWWJRbTZxOUZEaXZDYU1SVGcycUwzamx0bnIr?=
 =?utf-8?B?ZmFTWmVTZ3ZnbnUzK2JzYTlGT1dyMy9OZ1dDS1VPSUtwS3NjRDNHWXh4RGF4?=
 =?utf-8?B?VEQxR0FDZDlDSFQrYWxZMTR4MEFmSjlEZFozZkpwL0IzOUFxZ1c1YWNreFFQ?=
 =?utf-8?B?aldCdDJPTGliSm9hMXdhakZEWUVKRXpqSFVwMHdvalRicWd2WDB4ZHVLaVBV?=
 =?utf-8?B?cWNSNWhyV0dIMmZ2MjlYRGNUUmMwWU1LV09tSXowenlGSWVPMStINDYzd3RY?=
 =?utf-8?B?TytVUHczSzFybHQ2OExyOEMyYXg1ZCtDbHJXMFZ4VkRIMEtub1VWS2t1dklW?=
 =?utf-8?B?OG5kM1ROTHF5bGgxTW5YVndmbUlQRldUU2hDR1NWemI4N0xHRE5uZnZBYlpV?=
 =?utf-8?B?NU9iVi9XUThHZ1Z2N2t5SmYxbGtGcDlPU1Z5WEtvNFJtbVVCVUZvaWdRdWho?=
 =?utf-8?B?UmhNY1JtMmRnS2F0bWx0bm9QV2Y3YUhLM3RuTHVBK1dpQWkzYjlTUUZZcmRM?=
 =?utf-8?B?L2NZbWtvQWt1dmkzTGRnS3hKeXQyNk1vTEpObTk2Wkpvd2tyeXVpU0FSc2Rv?=
 =?utf-8?B?a2EvczA2NW1TNDdTblNmL3phdFU1ckVjVFJBZC9GN3U0eDB2czJTa1U0SlJQ?=
 =?utf-8?B?VzJvdUxuaWMrdHRuZ1JIdHpSaDJ0VzZDdyt1dHNzTGk4eEZrSG1QM25Ddm1B?=
 =?utf-8?B?TnR5aFhINHJUNXk4Vkg5RUFVMWlCMURHSTRSbFFYcWNIMFNTM0RHdDRQQndt?=
 =?utf-8?B?MVlIRi9zMjFyQkhYRStFVlhlSTVUV2JGRms4R3lDbzNFcTc3RitiZGRuY3RT?=
 =?utf-8?B?MkQrK1ord3BLR3prTDRnSDBNeW9jcVc4M0FyQTA5NmdMM0hIdndyNUhhR29V?=
 =?utf-8?B?NkdBQ05idzFsWWJVQkRMSFJYSzBlelFlQzBwOHdscTA2ZEs4WkkydlUzcDZ4?=
 =?utf-8?B?UDBRWkJNM2dFUDlaZWNMUGFzdDhGY2NWM1J1MXNRQ3ZvVG1WdmRUMEJnUmsz?=
 =?utf-8?B?SmtJdGd3ank1UU5BMzFNaC9hRHl2V25ic1NBY20vV3JOWU5GYThsNUZQRUZk?=
 =?utf-8?B?a05qTERPZW1Sak4rN0RTUVBKaTR1Z1lLUkkzdHo5VVlseHV3Q3FFdjk2RXNi?=
 =?utf-8?Q?xIOmqMBbyeM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REhuU05jMjVVT0Z5eFpOMWk4ZklDdnJ1MTJHb1U3OVNhYng2OFpaa3pXdzU0?=
 =?utf-8?B?YWFsN3ZmTWdGREpjYVJocTl2cmRMOFQ4SXZVRWZId2tLRG0vTFFMWWR4cS9X?=
 =?utf-8?B?REdhWkdES1hYemRDNDVZUmNlN3RrV2QybGE0RUwxWlZTQjJqMlpHQnNveFI4?=
 =?utf-8?B?dEpZYWpiV2ZTSWlhTG1Ccjlpam1zb0lDUXU2NnB5bWpNbzJKMlRQa3VNcmZO?=
 =?utf-8?B?ZHhFWDdyTm9tbmxVL3ZNdDdQdElWaEpiSUJFa2dxVFRDdVJsems2WTZSb0Qz?=
 =?utf-8?B?UStMMGdJd0Npb1N5Y0gvdXQ5L3pPb0Nyb3ZuK3V4OVNTaWQzZFhUYW1HTmRj?=
 =?utf-8?B?RmZxSHhuRmxzQ2lraVNGSlNpbTJtbC9Pb3BnU09VTlEySXN4YVJuUzRtZGdo?=
 =?utf-8?B?bXdXQ2tIMzBrWGdsNXdlUlo4bnhpYVpIbzFxWWJQT05FRk43N21TRUFtN1lw?=
 =?utf-8?B?bElBMmNHYWRRYXJBRkFLNHdsQ2IwSU1kY1hJNURUMEYxZHVaNGxLeEhMeEkx?=
 =?utf-8?B?ckFpaytGbi91S2psL2EyRG50aG02eGFyc0RRa2VXWWU0MjZCR3FmSjVVYyt6?=
 =?utf-8?B?UmgyNHcreEZwaitQalEyWFJKWWYwVHBvYmd5Q3dkbjRLdmZJM0RWOFE2R0R4?=
 =?utf-8?B?bTh6d1lGdDJFU1RJT1Rwc0FmSlhIa1hKYjBRWGxjckZFMVVjOGVEa0dUcy9t?=
 =?utf-8?B?Ukg1bTFxMHBzTTJ3bVF0M29FU21sQzIxSktCYUw3aGZWOW1aV2dMOTROSnhQ?=
 =?utf-8?B?d0dUS011Ymsxc3BoR2QrVTdXZ2RYZXZWckxEQ3VuT3NseDJnZ0o2YTkrOXBJ?=
 =?utf-8?B?UTdsaklFYU9OVFFYUUJhQTIwL3hHb2lUb2tRN2l4L3ZpVGRuUzBIZnRuelBS?=
 =?utf-8?B?ZEV6VG5pemdFdFVLNVZEYU5NRU1BYnZSWEdKL2RQQ3BDOXVpU0ZDdXYxRS9C?=
 =?utf-8?B?MUpMcHlkR3pxNE9TYjNNYmJoS25yUGt0QmRxcUt2Y2czVkZhQWlwd2pzbjhW?=
 =?utf-8?B?RHBiQUtIK2lMRkdXSzlmcEYvQ3ZZRFV5OWFXZGhhNTlGL1ZHdWF6YnR0ejkw?=
 =?utf-8?B?R0szcks4QlNBYk9rV1FYcDZITmJEbS9GZTR5YVl3M0p3T1IxQWxlcVE5NFBw?=
 =?utf-8?B?ZzZDTEtzUkoyMGQ4cCtxdUZvaFlnRThjbHVzUDcxTDd4VGtabkIvZmFiU3RH?=
 =?utf-8?B?YWV1VXJBQ3FzWmY3aHczaGkzTnBPemJZMllwdlZ6amtXZGxyQUttbEdlVy9W?=
 =?utf-8?B?V1IwbkFEL0U0eWFqUTJUNnF4TnUvRlhjRHZCdk50NS9vZ0FHb0JHbTVKOGxI?=
 =?utf-8?B?Y2FYQ24rTG1YVjN3bUdzYXo0Uml3VWFlK3ZTK3k0YTRSNWg4TXhYWXpmTjBa?=
 =?utf-8?B?TDYzRXR5ZG9Ja2VLZERlNElQaHhwclEyTkhmZ0xzWXBhaXdyTXAxVVllQUtt?=
 =?utf-8?B?czFsYTBXMnZKVlE3N2FDU2tQc2pVMDVIbWlaTW1NTkpsaUc1NE5GZEtJY3NJ?=
 =?utf-8?B?dHpSM3dwY0xJeDU5QzF1bmJNc01seU8zZ1M5T0ZRcFZVNVBoZDlPaUZHdWpi?=
 =?utf-8?B?TTZFQzdyT0FWOGdWTER2NGVwUFRJbm9BNDJTMUpNYjdxNTdnb1lmUVZyUDQ2?=
 =?utf-8?B?Y0xTb0FoYVFyeTNOQnpxelBzZ09IUndlb2hwYytIaEgrYjEyMy9QTGRWM2Fu?=
 =?utf-8?B?QU0xZnJBR0w0ZUE2NHJVb05MUEI5QzdNLzVNRWJzZHROdFpDWjdxdXNqRnJ2?=
 =?utf-8?B?S1QzTVRKaXJiQmJMMU9uMDd6WWd2SEx0cktQeStBVlBnbkp5c3ZZd1BERFNx?=
 =?utf-8?B?MVlIVkg3eFdOTUNzeWZFUFJIT2JoWFZkTTIvWUdrOERVMzZtVDNWNjlWK2R2?=
 =?utf-8?B?TDJzQkx6eU0vZVFKOFZyYURMU3FhNEpGZWlKOXh6eDM3TDhhT1J0OTRvTkpI?=
 =?utf-8?B?clNJWFV5aEdOL3lhOGhWT2VwcWJkd2lUVG5FS3gxY1FoZ0w2NkxQTytpNFkw?=
 =?utf-8?B?bWZnNzNkLzdrbUlJdURyeVE4cUs0Q3hDNjBzNEQ4OUdOQTZ6ZzMrZ1VhNXl3?=
 =?utf-8?B?aUhtc0t5YXRtTnVMQUZzZGVIbjFRSjRCcFFQbkhKM0p4ay9vMU0zWnlCcnFk?=
 =?utf-8?Q?QsRYaBBRYwCH8c0+lDyEe+4P4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a6d231-1ce5-4521-6e26-08ddb2f8829e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 08:24:17.3105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CQN4EGzg4+Gmdthl+8N5HEAUAMR9dyrv6E5cQo5dbgG2Are2O/n6t5iAM8hs2iC+FYUCYEI+1SxvYKplw1bptg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8179

On 21/5/25 00:11, Vishal Annapurve wrote:
> On Tue, May 20, 2025 at 6:44 AM Fuad Tabba <tabba@google.com> wrote:
>>
>> Hi Vishal,
>>
>> On Tue, 20 May 2025 at 14:02, Vishal Annapurve <vannapurve@google.com> wrote:
>>>
>>> On Tue, May 20, 2025 at 2:23 AM Fuad Tabba <tabba@google.com> wrote:
>>>>
>>>> Hi Ackerley,
>>>>
>>>> On Thu, 15 May 2025 at 00:43, Ackerley Tng <ackerleytng@google.com> wrote:
>>>>>
>>>>> The two new guest_memfd ioctls KVM_GMEM_CONVERT_SHARED and
>>>>> KVM_GMEM_CONVERT_PRIVATE convert the requested memory ranges to shared
>>>>> and private respectively.
>>>>
>>>> I have a high level question about this particular patch and this
>>>> approach for conversion: why do we need IOCTLs to manage conversion
>>>> between private and shared?
>>>>
>>>> In the presentations I gave at LPC [1, 2], and in my latest patch
>>>> series that performs in-place conversion [3] and the associated (by
>>>> now outdated) state diagram [4], I didn't see the need to have a
>>>> userspace-facing interface to manage that. KVM has all the information
>>>> it needs to handle conversions, which are triggered by the guest. To
>>>> me this seems like it adds additional complexity, as well as a user
>>>> facing interface that we would need to maintain.
>>>>
>>>> There are various ways we could handle conversion without explicit
>>>> interference from userspace. What I had in mind is the following (as
>>>> an example, details can vary according to VM type). I will use use the
>>>> case of conversion from shared to private because that is the more
>>>> complicated (interesting) case:
>>>>
>>>> - Guest issues a hypercall to request that a shared folio become private.
>>>>
>>>> - The hypervisor receives the call, and passes it to KVM.
>>>>
>>>> - KVM unmaps the folio from the guest stage-2 (EPT I think in x86
>>>> parlance), and unmaps it from the host. The host however, could still
>>>> have references (e.g., GUP).
>>>>
>>>> - KVM exits to the host (hypervisor call exit), with the information
>>>> that the folio has been unshared from it.
>>>>
>>>> - A well behaving host would now get rid of all of its references
>>>> (e.g., release GUPs), perform a VCPU run, and the guest continues
>>>> running as normal. I expect this to be the common case.
>>>>
>>>> But to handle the more interesting situation, let's say that the host
>>>> doesn't do it immediately, and for some reason it holds on to some
>>>> references to that folio.
>>>>
>>>> - Even if that's the case, the guest can still run *. If the guest
>>>> tries to access the folio, KVM detects that access when it tries to
>>>> fault it into the guest, sees that the host still has references to
>>>> that folio, and exits back to the host with a memory fault exit. At
>>>> this point, the VCPU that has tried to fault in that particular folio
>>>> cannot continue running as long as it cannot fault in that folio.
>>>
>>> Are you talking about the following scheme?
>>> 1) guest_memfd checks shareability on each get pfn and if there is a
>>> mismatch exit to the host.
>>
>> I think we are not really on the same page here (no pun intended :) ).
>> I'll try to answer your questions anyway...
>>
>> Which get_pfn? Are you referring to get_pfn when faulting the page
>> into the guest or into the host?
> 
> I am referring to guest fault handling in KVM.
> 
>>
>>> 2) host user space has to guess whether it's a pending refcount or
>>> whether it's an actual mismatch.
>>
>> No need to guess. VCPU run will let it know exactly why it's exiting.
>>
>>> 3) guest_memfd will maintain a third state
>>> "pending_private_conversion" or equivalent which will transition to
>>> private upon the last refcount drop of each page.
>>>
>>> If conversion is triggered by userspace (in case of pKVM, it will be
>>> triggered from within the KVM (?)):
>>
>> Why would conversion be triggered by userspace? As far as I know, it's
>> the guest that triggers the conversion.
>>
>>> * Conversion will just fail if there are extra refcounts and userspace
>>> can try to get rid of extra refcounts on the range while it has enough
>>> context without hitting any ambiguity with memory fault exit.
>>> * guest_memfd will not have to deal with this extra state from 3 above
>>> and overall guest_memfd conversion handling becomes relatively
>>> simpler.
>>
>> That's not really related. The extra state isn't necessary any more
>> once we agreed in the previous discussion that we will retry instead.
> 
> Who is *we* here? Which entity will retry conversion?
> 
>>
>>> Note that for x86 CoCo cases, memory conversion is already triggered
>>> by userspace using KVM ioctl, this series is proposing to use
>>> guest_memfd ioctl to do the same.
>>
>> The reason why for x86 CoCo cases conversion is already triggered by
>> userspace using KVM ioctl is that it has to, since shared memory and
>> private memory are two separate pages, and userspace needs to manage
>> that. Sharing memory in place removes the need for that.
> 
> Userspace still needs to clean up memory usage before conversion is
> successful. e.g. remove IOMMU mappings for shared to private
> conversion. I would think that memory conversion should not succeed
> before all existing users let go of the guest_memfd pages for the
> range being converted.


Ah about that. Actually IOMMU mappings can remain the same in a case like mine TSM+VFIO RFC based on the Fuad's older patches, here in particular:

https://lore.kernel.org/r/20250218111017.491719-13-aik@amd.com

which works nicely - mapped it once and forgot.

Now, I am rebasing my RFC on top of this patchset and it fails in kvm_gmem_has_safe_refcount() as IOMMU holds references to all these folios in my RFC.

So what is the expected sequence here? The userspace unmaps a DMA page and maps it back right away, all from the userspace? The end result will be the exactly same which seems useless. And IOMMU TLB is going to be flushed on a page conversion anyway (the RMPUPDATE instruction does that). All this is about AMD's x86 though.

For now (and for fun^wexperiment) I disabled kvm_gmem_has_safe_refcount() (04/51 adds it) and it seems to have no effect untiiil memfd is closed - folios_put_refs() crashes in list_del(&folio->lru). I wonder now what direction to go from here.

My TSM+VFIO RFC uses the hw ability to DMA to/from Coco VM (==AMD SEV SNP VM), both private and shared DMA at the same time is going to be allowed. Thanks,



> In x86 CoCo usecases, userspace can also decide to not allow
> conversion for scenarios where ranges are still under active use by
> the host and guest is erroneously trying to take away memory. Both
> SNP/TDX spec allow failure of conversion due to in use memory.
> 
>>
>> This series isn't using the same ioctl, it's introducing new ones to
>> perform a task that as far as I can tell so far, KVM can handle by
>> itself.
> 
> I would like to understand this better. How will KVM handle the
> conversion process for guest_memfd pages? Can you help walk an example
> sequence for shared to private conversion specifically around
> guest_memfd offset states?
> 
>>
>>>   - Allows not having to keep track of separate shared/private range
>>> information in KVM.
>>
>> This patch series is already tracking shared/private range information in KVM.
>>
>>>   - Simpler handling of the conversion process done per guest_memfd
>>> rather than for full range.
>>>       - Userspace can handle the rollback as needed, simplifying error
>>> handling in guest_memfd.
>>>   - guest_memfd is single source of truth and notifies the users of
>>> shareability change.
>>>       - e.g. IOMMU, userspace, KVM MMU all can be registered for
>>> getting notifications from guest_memfd directly and will get notified
>>> for invalidation upon shareability attribute updates.
>>
>> All of these can still be done without introducing a new ioctl.
>>
>> Cheers,
>> /fuad

-- 
Alexey


