Return-Path: <linux-fsdevel+bounces-54432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03674AFFA40
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 08:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB100488441
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 06:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3E5287514;
	Thu, 10 Jul 2025 06:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gIH5Fo+i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D32817A300;
	Thu, 10 Jul 2025 06:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752130672; cv=fail; b=KcbGBed6PryLQXW4PI9KtkUY5a0GRj+TWLOqh2RK1Ex1cDptexbJd2QqBKVA7OXAJWtKVaCzbLfYZDGQ0ATZVhhrjOdzJshAqYZQC4JBJMpARl/8JYTlYn5PJVbaiwXH8SthVqnagqvelOLVAiOeBuO6pCEI4+RglEN6C8Cm4k8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752130672; c=relaxed/simple;
	bh=QviFC8191V7fEjye/q4rKx888CNpulT3kIhDZCxsbqU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O1isJSd2Zs+hEzOAJq/aum92FtOr3snS0P3Oj6biJsZxboq+nPcVlWbYMjPrGMDvVCZBvi7ryzimkajvBVlRc95upX8nORNnQ6sIODZPSbL2H78B42Wm0kYEwavvkKQ0ofIme5bfSllcXYfjwpmy0ypN9yNHK2ZF42dgyEGsyZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gIH5Fo+i; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pHM9sZIYGqZqMNOql/6J1W2fcUZWhN8a8DOLi7mpzripBEWvWkx1XWgX4iynZtONg3mgRwyZnHUjcnE1i/9S63Vuuku04CnHDNcl0f/og+backJKCPB9unBMZfJETUnPOpQ9GviAYuYU4QipRILOcwp4lU9Q1g9g29D7w1gFNcbrLI9V96QNvSbGoEEBwQFfM4chteoslBxoUuu+0niX46XAw2JeZWIbdGlaUkZEiRK1VGq71OmdfKgm7L+DHeu33svF2nI3M7hOSCzrKH8sC897iPsHrAEB96j9dpNXVlYNuVOhLr5rbIt4gbPved35JG7lNSkjj8Q4qbATtFuAyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXA/Hs7cimaxFh2CePsl6TKUIk059eoD81cwHWHuXOg=;
 b=HPRiPtjqRVWKO+nobwG0EFfr7Dj6HChr3gNFmBf1UQtu41y+zbyiBse4BlXrfgT8ZAQRI//42IEN3VpXivguYU8tFVsalG61qixeyrW66pfV1D6FcuhIDW4dE0Ilg3eiNB03h7T/nd7ouL4rioeujbAj1Dp92/t5SuAA/a0HBOzFMDOc4rajFAE1XX+UPJuMeegQJJr/v+NFSL8UKjeqKQ2JyC32fB/muNCVQoQ/10F6U2l1YxJXy4Ppa7g1Pvm3lQ2+C1CIOado1nk3w//stX48A8XILm5u9/h+X38K7vJ3AtIxHyxK2vjGDXvOjs+tFmHhQCrQ6Vhbm1rgQMGUcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXA/Hs7cimaxFh2CePsl6TKUIk059eoD81cwHWHuXOg=;
 b=gIH5Fo+i1uKWF8ofH6DKsgrb2peRka5iXEhahWU7/ZD3WHIkz84DHrUP+yrzOMd8+kGqtEvEHBCaYvZz/DMFhZPK9g5SFrhyNtpwz9ieoMDu4hIJs2YWAzTPedntucT2wD3M1PQiZ7Wg0BV2Nj18PG4mkONjA9uQZEa52QLhA6c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SJ2PR12MB9243.namprd12.prod.outlook.com (2603:10b6:a03:578::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Thu, 10 Jul
 2025 06:57:47 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee%7]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 06:57:47 +0000
Message-ID: <09db374e-fa7d-4c1d-bf03-aaaafd93bd01@amd.com>
Date: Thu, 10 Jul 2025 16:57:25 +1000
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
 <8f04f1df-d68d-4ef8-b176-595bbf00a9d1@amd.com>
 <CAGtprH-KhEM6=zegq-36yomZ8PX22EmaZpMPkLnkyzn51EF25w@mail.gmail.com>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <CAGtprH-KhEM6=zegq-36yomZ8PX22EmaZpMPkLnkyzn51EF25w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SYYP282CA0006.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:b4::16) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SJ2PR12MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: f2d53acb-c5ab-4b66-21f1-08ddbf7f13e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WmJHUVU0M0NPZENXdDNTcm5zdm1HUzJWWkJReU9ZVnM1anpQZm5uOUE0V2Jq?=
 =?utf-8?B?ZmIrdHF6QnVQWlBaZTBKakVBTE1SdFdpemJlSFFVNXJsbzhSQmgrdUJObFpS?=
 =?utf-8?B?am5pNG02NlZSL3p4V0swb2hrWmZmdk4zeEVJRnA2bDErVWZtSDhjK0pvSEtL?=
 =?utf-8?B?aG9TTE41dHRDTGYreldZblQvd3pyRnQzZEZSQVI0bE95RDMxOE5scjZ0M1Jv?=
 =?utf-8?B?Q0lNTjY1N0ZKdVNiaG8vZ1o1bEQ2Q01SRXZyNHNUakNXcUFYVkNzSkpmeHpV?=
 =?utf-8?B?cnRqdSt6RmwrUS9RaHJ4UkZJeHdmdXFMOXozZEg1elROaGhMS3JBSXJLVXVu?=
 =?utf-8?B?ZjFFZ2oyNXRZVVhZWUdNaG1EYkNEVVd0VW8ycFBCNllDRUhDSENaRnkvdlpZ?=
 =?utf-8?B?Zm9IUS9JbEZvNVlod0xNdXdidGxVaVVzL3ZUSXEvZWJna3B4L1pQQmt1bXZU?=
 =?utf-8?B?eVlGMWZIUThMZlR0RWVPMmZOSHdpbnMyaDRVLzd6R1FIeXE4MDcxcmF5YVgw?=
 =?utf-8?B?VlQ0K1ZPbGFIcEZiTW5Gbk1kTmdUQ0M5Y1BxcVM3RTNOdmVQMU1ncXdUTEgy?=
 =?utf-8?B?a1NoNTRQb0s5aHhBdWM4U3U3WjlxclNvTzkwNkd6M0xPZnl1dWVocS9RSC9u?=
 =?utf-8?B?OEtGV2hrNGxYSGxxamduRS9HNXlVM2cvL2psTFAybGhsL2ZFaFZBZGVTdUlt?=
 =?utf-8?B?WmFNN3hrRHFKUnJyaVIyWGZ2bHlpRS9qZmFXaW5JVElFbnlGZXFGZDEyUS9t?=
 =?utf-8?B?MEl4cFpaNk1lcW1NSW9rT0c4YURJWko2Qm1Dclg0dnVQTFg0eWkydmlnRFll?=
 =?utf-8?B?VXRLdXY3b3NYb29JbjRSTGZzMmZmbGNVZFdBbjE0d2ViVi9XMFdOdUZTZlJq?=
 =?utf-8?B?TllmLy9DWUZyNmpIbnFuRG1vRlZiMkc4c3lvZWFzV3VHK3FycDdrUEsyeVJ6?=
 =?utf-8?B?amw3b015VmhYVlYyTFRJaG9Ub1k0T000WFNOT2pmVldZTkhMQmJyZEhSeFFr?=
 =?utf-8?B?TzZITEpEcHA5QmNmSUh0ZmsxU1dCMk8wU3dyejc2aGgrT0hxZDR5Ky8xSzdq?=
 =?utf-8?B?N0RMa1p6bDlTcFgwbkZlbUhNZ094UmY1NWpDdHZTcXAzK3VOejNZMDZSRVNR?=
 =?utf-8?B?dEJLcE0xVUpYdkZ2Z2FLb1Nma0JwMjBIZXdyN2UwNlFIWmtvQ043dUo1UWZa?=
 =?utf-8?B?b3hHRUxYZ3R2Rm1mT3VUeXVWZVFNa1pyaW1oK2xIM1RUZHlKNHRoTlBiL2lG?=
 =?utf-8?B?dDFrUFNzUVpZNGZDMS9oMzQ0a2d4V2RrdWQ2OTdRY09KQ3ZTWjVJNmFlTzFV?=
 =?utf-8?B?VDhPbVdUc1huM3NwM1l5bGRURWF1cHdSN0g5b3ZLZW5DeTJWU0RqcERPaVNq?=
 =?utf-8?B?RlJQcURIM2l6VTN6OVA1R3hNRzhFUDNYdTFNVnNnektTWS8vd010dnhZaXNJ?=
 =?utf-8?B?SlhwajRZMFhwQWlrQVFrREpLcHpjNWh5d1FXL2FHQWV6alk5cGQvdjd4OXJD?=
 =?utf-8?B?TmhSWWIxU1F1K3FnYkpsaFJyUDVmcUJlclo0WHpROTNKRElmNjJlM1BRVkNy?=
 =?utf-8?B?M0EzVWxzRHNtUk5qa1Noa1JXTlNDVnNwdjdPY3JvU0VRWWh5MUtOMGJrUmY1?=
 =?utf-8?B?VTlhd2dQbXhNM0hCQzFCUHRRY1RrLy9mdnp5bW5nemhyK3o2OElyWlQ4cXlt?=
 =?utf-8?B?VmQ5bmpjMWZ2SmFZcDFmVVdqTm1rVzJReVBxOFBXVUpiY3dTVFZtZ0pRU3BG?=
 =?utf-8?B?R2xWN2NacVhSZ3gzaklHNHluQzVKQ1hHTVRZbmFFRDJZUnk0SjVMVWF0dDJJ?=
 =?utf-8?B?WlBtakI4cWRWc0tvaHV3N3hRQkVqZ0tGRzlLeXNSdXUzZlJsZDJvajgzRFlk?=
 =?utf-8?B?M0xoMmNocUtGS1V5cDhFRm83U1M5WkhIeUZUZXgyRXFCakxJVkhyQy8xbjVa?=
 =?utf-8?Q?RFxtc5ZPp/4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjJZWnlJVU56YndGTHV2aVY3MWR1R0xvWTYwNkNGNm5Gc2VpK2lHb25aaXVw?=
 =?utf-8?B?WTAwK28vcnBRc3FNaWw5eU5wZ05kYldZYlUyTDVsQkZxQ24wdVJTUUI3V1Zx?=
 =?utf-8?B?YkZlb20vNFVkeWNFQjhoU0djNEV2VTNoM3hTaWEyY01xTU9YVWtmV3ZLbkli?=
 =?utf-8?B?TisyMGw1NUhCMWhZenp4bmZOLzRKZGw2UklZSVZtYkNNM0pTSXNFRHhKekZE?=
 =?utf-8?B?NmZnMTBtaTEwN3c4ZW1SOW5sZHRYV0luVlhnRTNSQjZMMlJ0d1lGN0RGcTIw?=
 =?utf-8?B?ZHVTQ3REakxROWMvb1JTVElLZDBnc1MvaFZVSmwra1h6N2cwQncwQUxSRnlB?=
 =?utf-8?B?QVdoQ3JPQlUxMWFNOFVLRXFuencrY2Z5YURpTlhadm1NeHdhMVRCckhETmlp?=
 =?utf-8?B?azBNR2pMRVR3V3N0cU9nSjNHOTRqSFp1N2plOUR0dGZlK0xCZHlhWE5ERlVW?=
 =?utf-8?B?M3BsNUhyY1hvUmZlVUNDVkdvZEIwc2I2a05MWTlVT0FVVDYza2p5bWd3SEs1?=
 =?utf-8?B?cVAzZ3dqUGFkK0FOeDMvT1UzaFhncUc3RTZ4L25aM3lEMnBNbzdBNTlhTWV6?=
 =?utf-8?B?d3NsQkN0ZUpsRnVzS3YvOXZ5bzNUbWhENkdON20wczZvclZDTFpnT3ZrYWM0?=
 =?utf-8?B?dXpRWWRoUytlRDllZTJ0MCtPR0xCYXEvL2w3Q3hFMGp2NC8vb1VFRDJRZDFJ?=
 =?utf-8?B?b1VrSVJoSVBPOWlyWk1PUmY4MmFJa0lmdVVRNExCSUdKS1RUajdQd2pNOUFr?=
 =?utf-8?B?RXQrSE1oYWowTnRFemgyUHNLWFhMUFZrdSt4NXFCSUpzZk1NYURXOTdiYkJm?=
 =?utf-8?B?WWdZeHY1MFphbWpvaFAvaHFTT1lNSEM4MEJmbUZ2NnZHZTdtaEJib3RrUTZD?=
 =?utf-8?B?TFpmc0htbGNUb3V3dnAzcGdnOUNScnRnVjdnYWkzVFJRN3ZNV1VDTGhGVVZy?=
 =?utf-8?B?VFc5R0hISktUUXROZUhUNFdvMjZSdW9vSFVUbExDTXdlK1ZDbWZUUDc5bjhl?=
 =?utf-8?B?Z2d5WHRUOG81MG9lWDA5eE5BNWRRZTFXcUVkbXpNTXdZRlgzYzBmRWpqUG5y?=
 =?utf-8?B?QlJ3RFd5Q1Y4VmY5b21nL1ltZ0VYMHkrU2hwMVVxNEdGb2FXRHBtQ2RJNXl0?=
 =?utf-8?B?NzRtVFNtYjRpTW9xbTRkcTVYUVQ5czNQY0pFa1loZStYaXhTYnNaQVRnTzht?=
 =?utf-8?B?RTJkTmFOcHVxeStWYSt1Q0J5b09wejFheFJQdkVqaE5KVXlvaDN1VFUxYytH?=
 =?utf-8?B?d1ZMbDlNSTNhSWkxd2lRWTJ1bWtLcno3NjhOelNMUjZlQ1BIdjFLWkk1V1Jj?=
 =?utf-8?B?RkpORDBseHY2UzhtQ1Jma3JISmdCTmdwU3lYVklZSERaRjVmcmRZSlJuTEVD?=
 =?utf-8?B?bVFqTHBEUjYwMHNMVG42c0dROFlpSmdSWEI4R2drc0lycmdQdmR2aFRMSnhJ?=
 =?utf-8?B?dlJvdmJlekFyaXZhYlRKbDJMb0Z1dmhsekhIRkRPMGZob1Y1MkQyM0ZpNU1S?=
 =?utf-8?B?STVGcitxeFdPNDJTdmhvaU5MU0ZOM2JJakk2RWpkTU1RU2d4elloaXZQMUh0?=
 =?utf-8?B?V0RNSitnNmFncWRyQkUzU2VIeXBzRkZoYmx6ZStuck9OcFQrMUVxVWVWTnpW?=
 =?utf-8?B?YmJvU0grUFlLTE1pT24xcTA5UExaVVJNcTRSYmVWWk9qWVdkRVFMN01HNHB6?=
 =?utf-8?B?MzBWNURFTVRVdTlKbEFOZTh6U29OK3lqcTB4KzhKSGJyM3RGVFFESENWNVdH?=
 =?utf-8?B?M0JYcGdIZmw3TnhLU0lsbU5NYS9pb1dlQmhub3hCU0kyUXpvbGtUZjNKbDZI?=
 =?utf-8?B?c0s3c0JpaWlvQmpSdjB3cGZLaFV6ZDY2OEZzVU16STR3a2dEQXBvcUl4YmZp?=
 =?utf-8?B?Zk4wR1pjb0NyeWoxT09sbUFQaXFYT3hyTGpZeHdVbjI4QWYyejIybE9XMGlJ?=
 =?utf-8?B?dDZxem5La2VnK01pY1VhQlE3L1A0ZkduSGFpaE5vVWh1YlZocFJEd1hMaWZH?=
 =?utf-8?B?K2FMUUhvaVhPcHplQ1oxanBiOXFiZVdORGx1ei9KUDFVZTBCN1lHQk9BT1F3?=
 =?utf-8?B?dDNlTkFqMkQ2dVU3enFJWllTRThvbWJaNkUrVXBUVURqdHh6dHM5ek5HK2F2?=
 =?utf-8?Q?crExsggHQdCu8BMJNzWorxZHr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d53acb-c5ab-4b66-21f1-08ddbf7f13e3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 06:57:47.3741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tbkrabhUyaYIHnMjLD9gnM04YFXwRIj5tpGldIqkNWo48wqEgEip/cBzOvc8QEh7vV1PbVa8LSLuMClcAy+02w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9243



On 1/7/25 00:19, Vishal Annapurve wrote:
> On Sun, Jun 29, 2025 at 5:19 PM Alexey Kardashevskiy <aik@amd.com> wrote:
>> ...
>>>>> ============================
>>>>>
>>>>> For IOMMU, could something like below work?
>>>>>
>>>>> * A new UAPI to bind IOMMU FDs with guest_memfd ranges
>>>>
>>>> Done that.
>>>>
>>>>> * VFIO_DMA_MAP/UNMAP operations modified to directly fetch pfns from
>>>>> guest_memfd ranges using kvm_gmem_get_pfn()
>>>>
>>>> This API imho should drop the confusing kvm_ prefix.
>>>>
>>>>>        -> kvm invokes kvm_gmem_is_private() to check for the range
>>>>> shareability, IOMMU could use the same or we could add an API in gmem
>>>>> that takes in access type and checks the shareability before returning
>>>>> the pfn.
>>>>
>>>> Right now I cutnpasted kvm_gmem_get_folio() (which essentially is filemap_lock_folio()/filemap_alloc_folio()/__filemap_add_folio()) to avoid new links between iommufd.ko and kvm.ko. It is probably unavoidable though.
>>>
>>> I don't think that's the way to avoid links between iommufd.ko and
>>> kvm.ko. Cleaner way probably is to have gmem logic built-in and allow
>>> runtime registration of invalidation callbacks from KVM/IOMMU
>>> backends. Need to think about this more.
>>
>> Yeah, otherwise iommufd.ko will have to install a hook in guest_memfd (==kvm.ko) in run time so more beloved symbol_get() :)
>>
>>>
>>>>
>>>>
>>>>> * IOMMU stack exposes an invalidation callback that can be invoked by
>>>>> guest_memfd.
>>>>>
>>>>> Private to Shared conversion via kvm_gmem_convert_range() -
>>>>>        1) guest_memfd invokes kvm_gmem_invalidate_begin() for the ranges
>>>>> on each bound memslot overlapping with the range
>>>>>         2) guest_memfd invokes kvm_gmem_convert_should_proceed() which
>>>>> actually unmaps the KVM SEPT/NPT entries.
>>>>>               -> guest_memfd invokes IOMMU invalidation callback to zap
>>>>> the secure IOMMU entries.
>>>>>         3) guest_memfd invokes kvm_gmem_execute_work() which updates the
>>>>> shareability and then splits the folios if needed
>>>>>         4) Userspace invokes IOMMU map operation to map the ranges in
>>>>> non-secure IOMMU.
>>>>>
>>>>> Shared to private conversion via kvm_gmem_convert_range() -
>>>>>        1) guest_memfd invokes kvm_gmem_invalidate_begin() for the ranges
>>>>> on each bound memslot overlapping with the range
>>>>>         2) guest_memfd invokes kvm_gmem_convert_should_proceed() which
>>>>> actually unmaps the host mappings which will unmap the KVM non-seucure
>>>>> EPT/NPT entries.
>>>>>             -> guest_memfd invokes IOMMU invalidation callback to zap the
>>>>> non-secure IOMMU entries.
>>>>>         3) guest_memfd invokes kvm_gmem_execute_work() which updates the
>>>>> shareability and then merges the folios if needed.
>>>>>         4) Userspace invokes IOMMU map operation to map the ranges in secure IOMMU.
>>>>
>>>>
>>>> Alright (although this zap+map is not necessary on the AMD hw).
>>>
>>> IMO guest_memfd ideally should not directly interact or cater to arch
>>> specific needs, it should implement a mechanism that works for all
>>> archs. KVM/IOMMU implement invalidation callbacks and have all the
>>> architecture specific knowledge to take the right decisions.
>>
>>
>> Every page conversion will go through:
>>
>> kvm-amd.ko -1-> guest_memfd (kvm.ko) -2-> iommufd.ko -3-> amd-iommu (build-in).
>>
>> Which one decides on IOMMU not needing (un)mapping? Got to be (1) but then it need to propagate the decision to amd-iommu (and we do not have (3) at the moment in that path).
> 
> If there is a need, guest_memfd can support two different callbacks:
> 1) Conversion notifier/callback invoked by guest_memfd during
> conversion handling.
> 2) Invalidation notifier/callback invoked by guest_memfd during truncation.
> 
> Iommufd/kvm can handle conversion callback/notifier as per the needs
> of underlying architecture. e.g. for TDX connect do the unmapping vs
> for SEV Trusted IO skip the unmapping.
> 
> Invalidation callback/notifier will need to be handled by unmapping page tables.
> 
>>
>> Or we just always do unmap+map (and trigger unwanted page huge page smashing)? All is doable and neither particularly horrible, I'm trying to see where the consensus is now. Thanks,
>>
> 
> I assume when you say huge page smashing, it means huge page NPT
> mapping getting split.
> 
> AFAIR, based on discussion with Michael during guest_memfd calls,
> stage2 NPT entries need to be of the same granularity as RMP tables
> for AMD SNP guests. i.e. huge page NPT mappings need to be smashed on
> the KVM side during conversion. So today guest_memfd sends
> invalidation notification to KVM for both conversion and truncation.
> Doesn't the same constraint for keeping IOMMU page tables at the same
> granularity as RMP tables hold for trusted IO?


Currently I handle this from the KVM with a hack to get IOPDE from AMD IOMMU so both 2MB RMP entry and IOPDE entries are smashed in one go in one of many firmwares running on EPYC, and atm this is too hacky to be posted even as an RFC. This likely needs to move to IOMMUFD then (via some callbacks) which could call AMD IOMMU which then would call that firmware (called "TMPM" and it is not the PSP which is "TSM), probably. Thanks,



-- 
Alexey


