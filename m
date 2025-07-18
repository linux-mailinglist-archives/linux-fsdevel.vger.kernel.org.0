Return-Path: <linux-fsdevel+bounces-55439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAA5B0A6DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 17:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C9A8A41471
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 15:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AED62DE1FA;
	Fri, 18 Jul 2025 15:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IJgsx7d1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF26014D283;
	Fri, 18 Jul 2025 15:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752851547; cv=fail; b=DFM5SGp27+ZAuq2ujBB2GwDjlAsvKf/NgJOlE6PJLFwoF5GJ+uUkDCoZMkOmGkjPfHZXwaU/xKe+MF13DNnHrKTDX3DdFPjbmmIaqMPsKSItFXZRSL2q7v5/YagsluxkPDp87MeUUUNe+RF5bGRMJOnpyzzot68HsTCejhEGMb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752851547; c=relaxed/simple;
	bh=hcGbN1pM1Ofo8LmpK5tOvJmGFXnwnoLfyAIHG7ljmHM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CUCd8D7ttDLBYmwVVcH9z9cIZm21vF6nhDwuL78LTcYRdSW9HcffZMhKyYJWh09k243RgaB1WRA4Fwq9GUWKzFKzQSMXC5ajKLEXBUL6kp3w44RO+D0qkeQcuA9uATnyEhHO6mYJYnBdLrySY/fDHzP/DtprEnrb/ar+LoA2xds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IJgsx7d1; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752851546; x=1784387546;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=hcGbN1pM1Ofo8LmpK5tOvJmGFXnwnoLfyAIHG7ljmHM=;
  b=IJgsx7d12zaRQF45kAOVO+1LDDYrZyoXsHHZIalrenKnAu96lIDTVzZ1
   WRjNMyQUkWmEvtTM08R3iMKWS2W7LeM5AFDeFeBDpSf3wRg5RyuMi/wL8
   XNwXFvW4nH/FHZ9oN9BWyEbwvCYYrA70dLbz5WDrLM6wPvUnK3s/hpeYg
   7DnuLTeo2z8MOn/97HYLkY1ivlHjnObptfw3jRMrlNyPysM/EpYhwCeqZ
   ADnhkPweBAqDzllJ91POmOPiqGVmfGVqCjT/CQ/hGcV4HmsHpsSfyaARk
   UmCd0Ra181duolKQBnfouWyHP1tjlTzNo5ZtLSG75ov2/qcwIoM/elvAE
   Q==;
X-CSE-ConnectionGUID: RJRCPhenQ9u9K+zGwViEag==
X-CSE-MsgGUID: kcOA5k+3QTOWmgNGl2UJ0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="55233653"
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; 
   d="scan'208";a="55233653"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 08:12:25 -0700
X-CSE-ConnectionGUID: dAeHgryXRWK4sFDCyKFj6w==
X-CSE-MsgGUID: HbjIL0JTQ42NZR/mjVwYjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; 
   d="scan'208";a="163708357"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 08:12:23 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 18 Jul 2025 08:12:21 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 18 Jul 2025 08:12:21 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.60)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 18 Jul 2025 08:12:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVX6Fx7eg18TJx36vNhTnl8zuysfvWT38vreutSVrSbHUfudqNMtIeFyN1xPDSukmiTHOZWBpWrCnSFdprYb4pEWQR17/RzYRXKLsLfvyx7+C0uos9u1GB31zM3kZmg4AwyWRQ74WfZRNtkqk42J1amsiH2MA2xFDLIA7eQgTrvYYc/8qih5X1hFFdRPG8xGgeV2zWI9IfqyGYOWXpkWEmoRYe0lFVzeMEBm/PtSk1yLJQIEInTraTsztt5Qw/qC6H1tITqo/YiSfdil19mX9WrCQc5VDQ5QrMxcgbWxr1o9qlq4v2Vc8FRluKfem4ATqQCOsYDx+WPpJh01Nn7ipw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=We3KXD8ls3nuzRx8BgUTt0rmqz4/ZnJLTeVxbFhsB6U=;
 b=LsxqBsh0n3DZ35v+HOJxgoLrQFWWM/w/5oDbqEDkpBM7GX7OPOy+/JLIdYB9qFmRw8JoRwM5Yx1B/5zEZ7FvlKvcpnAGo+UXK4NZkgjQ5Uz6NAMfTJ4hRE+16QhHtrk3sZh31jOVQ1MzDZ2pLaQTTmrb8Oc3Mo7R4POE0vD233PlOr6eAQspkMEax6YN9Fwvz08fix8luw/3zTYv6+BEvwpYhBw4RaHf0G1a0zyes7BzJ0i2wochtZrGAkDb8G3F7bc9oYQzeax8+ypcjYOPto6gqtlD0E+Eh409m1KOYtWlQwAYID7jSLimBaDvOHBqq8Srn1Q5257LM+m7/I1Vvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by SJ2PR11MB8421.namprd11.prod.outlook.com
 (2603:10b6:a03:549::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Fri, 18 Jul
 2025 15:11:48 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::19ef:ed1c:d30:468f]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::19ef:ed1c:d30:468f%5]) with mapi id 15.20.8835.018; Fri, 18 Jul 2025
 15:11:48 +0000
Date: Fri, 18 Jul 2025 10:13:07 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>, Ackerley Tng <ackerleytng@google.com>
CC: Yan Zhao <yan.y.zhao@intel.com>, Vishal Annapurve <vannapurve@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Alexey Kardashevskiy <aik@amd.com>, "Fuad
 Tabba" <tabba@google.com>, <kvm@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <ajones@ventanamicro.com>,
	<akpm@linux-foundation.org>, <amoorthy@google.com>,
	<anthony.yznaga@oracle.com>, <anup@brainfault.org>, <aou@eecs.berkeley.edu>,
	<bfoster@redhat.com>, <binbin.wu@linux.intel.com>, <brauner@kernel.org>,
	<catalin.marinas@arm.com>, <chao.p.peng@intel.com>, <chenhuacai@kernel.org>,
	<dave.hansen@intel.com>, <david@redhat.com>, <dmatlack@google.com>,
	<dwmw@amazon.co.uk>, <erdemaktas@google.com>, <fan.du@intel.com>,
	<fvdl@google.com>, <graf@amazon.com>, <haibo1.xu@intel.com>,
	<hch@infradead.org>, <hughd@google.com>, <ira.weiny@intel.com>,
	<isaku.yamahata@intel.com>, <jack@suse.cz>, <james.morse@arm.com>,
	<jarkko@kernel.org>, <jgowans@amazon.com>, <jhubbard@nvidia.com>,
	<jroedel@suse.de>, <jthoughton@google.com>, <jun.miao@intel.com>,
	<kai.huang@intel.com>, <keirf@google.com>, <kent.overstreet@linux.dev>,
	<kirill.shutemov@intel.com>, <liam.merwick@oracle.com>,
	<maciej.wieczor-retman@intel.com>, <mail@maciej.szmigiero.name>,
	<maz@kernel.org>, <mic@digikod.net>, <michael.roth@amd.com>,
	<mpe@ellerman.id.au>, <muchun.song@linux.dev>, <nikunj@amd.com>,
	<nsaenz@amazon.es>, <oliver.upton@linux.dev>, <palmer@dabbelt.com>,
	<pankaj.gupta@amd.com>, <paul.walmsley@sifive.com>, <pbonzini@redhat.com>,
	<pdurrant@amazon.co.uk>, <peterx@redhat.com>, <pgonda@google.com>,
	<pvorel@suse.cz>, <qperret@google.com>, <quic_cvanscha@quicinc.com>,
	<quic_eberman@quicinc.com>, <quic_mnalajal@quicinc.com>,
	<quic_pderrin@quicinc.com>, <quic_pheragu@quicinc.com>,
	<quic_svaddagi@quicinc.com>, <quic_tsoni@quicinc.com>,
	<richard.weiyang@gmail.com>, <rick.p.edgecombe@intel.com>,
	<rientjes@google.com>, <roypat@amazon.co.uk>, <rppt@kernel.org>,
	<seanjc@google.com>, <shuah@kernel.org>, <steven.price@arm.com>,
	<steven.sistare@oracle.com>, <suzuki.poulose@arm.com>,
	<thomas.lendacky@amd.com>, <usama.arif@bytedance.com>, <vbabka@suse.cz>,
	<viro@zeniv.linux.org.uk>, <vkuznets@redhat.com>, <wei.w.wang@intel.com>,
	<will@kernel.org>, <willy@infradead.org>, <xiaoyao.li@intel.com>,
	<yilun.xu@intel.com>, <yuzenghui@huawei.com>, <zhiquan1.li@intel.com>
Subject: Re: [RFC PATCH v2 04/51] KVM: guest_memfd: Introduce
 KVM_GMEM_CONVERT_SHARED/PRIVATE ioctls
Message-ID: <687a6483506f2_3c6f1d2945a@iweiny-mobl.notmuch>
References: <CA+EHjTwjKVkw2_AK0Y0-eth1dVW7ZW2Sk=73LL9NeQYAPpxPiw@mail.gmail.com>
 <CAGtprH_Evyc7tLhDB0t0fN+BUx5qeqWq8A2yZ5-ijbJ5UJ5f-g@mail.gmail.com>
 <9502503f-e0c2-489e-99b0-94146f9b6f85@amd.com>
 <20250624130811.GB72557@ziepe.ca>
 <CAGtprH_qh8sEY3s-JucW3n1Wvoq7jdVZDDokvG5HzPf0HV2=pg@mail.gmail.com>
 <aGTvTbPHuXbvj59t@yzhao56-desk.sh.intel.com>
 <diqz8qknhj3l.fsf@ackerleytng-ctop.c.googlers.com>
 <aHjDIxxbv0DnqI6S@yilunxu-OptiPlex-7050>
 <diqzqzyeg3j2.fsf@ackerleytng-ctop.c.googlers.com>
 <aHm2F95XwzdD7nod@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aHm2F95XwzdD7nod@yilunxu-OptiPlex-7050>
X-ClientProxiedBy: MW2PR2101CA0002.namprd21.prod.outlook.com
 (2603:10b6:302:1::15) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|SJ2PR11MB8421:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aeffe16-6119-4e18-c7d1-08ddc60d6a60
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cUFjS3dLUmc1aGdWTFY2NzhHN1g3WUZHQzQwTGZ6Tk5tMmtrcmJaU0RnN1lZ?=
 =?utf-8?B?Q1gxUks3WU1GM20vaFJ6STRDL2c4Z0ViUDZmVEtZZW9HWExPSlNZamtJNFdQ?=
 =?utf-8?B?eU5LbzRsaDJ5YXpaL0hjRW1oV2FUM0hSQjVPSGFLV01aQnhKYUh1ak5YRGdq?=
 =?utf-8?B?ekcvR1JBanQyUzFuVWFsNG94T3ZWajhOMDRnMEpQSVMxSVhJOTdWSjM5dkY2?=
 =?utf-8?B?a0k1Zk9uQzdPVVhjUWRQQ092Mld5emV0K2R0WklkNUZBeHdnTC9lUUJWSUNh?=
 =?utf-8?B?dXEwYThvbDNmSENEbHhzeHlySytBNnVDbFljMXJhMlhvMEJoUTBDcDJyemVr?=
 =?utf-8?B?WmZraUdhdEJhcmd0YXdGT3VwRnNqM210Q3pNdFUvOG9mdzNTd2FvOXpmbUJO?=
 =?utf-8?B?dklwNUxLZjhLdnRVd0ROMXFhNFFwdUtoaFRWSmg2NWFhNi9Qa1NURVM3K0lZ?=
 =?utf-8?B?SzNDZTJ2NFcrZi9XZnBzbjNkWFR4THdjRTRsby9DKzVKc2RvS0lhN2hLYWZo?=
 =?utf-8?B?MExJZm9wTG9ZLzUwYk44VGRURVpjTm5KWEhxdFNGY1I5QWw2a2xiYlVlOVlS?=
 =?utf-8?B?QzFYVCtCODhzdVBFY0ZTVXBqVFZYT1VzM0Q0bjAyZVhNRTRBMmV1MmwzS1pK?=
 =?utf-8?B?dUYvTkdtdVczT2lSRWU3a1J5VjJxbVZJdm91MWNFRHM4Zjk4UlNxK21kY0Vj?=
 =?utf-8?B?Z08xa3UzR0tQYVlvVTI4RE5vVldLamxQeWtjcGVZeUNPN2NBNk42ZHdSU3pI?=
 =?utf-8?B?WnZmUUEveko0SGdJbTNwVWlGMGh2OGJUak90VmRNZFNFaWZleHlSVGlkUDhz?=
 =?utf-8?B?YzR5emdkOVlHYmc0YjhqKy93M3RQQWk3bElnbjEvMzR6bGZETXZwNmFPbDc1?=
 =?utf-8?B?RVlia0pjRE42RTRVcmx3N2t6aVpkZmtLWlRZOEx2WksvbXV3dGlMNnU1NmJP?=
 =?utf-8?B?V3EyVmJwS3BRQmdFS2xCc2QxL2ZyMjF5TVp4YVBXK0dYRVVRTVJ4QTh4ZldU?=
 =?utf-8?B?RmdFMnRoWTdObDNLc2NVWXNvd0JzTzd0M0JpcHc2Y1RDUUZyRUYrVWVtTjBR?=
 =?utf-8?B?ZnIyVWxaU1gvZ0tLZTJJY2tMeTVJc0syYURpOVlpbjJYWWJxYnl1U3NKQVY0?=
 =?utf-8?B?bGJTbTFLOTRZaktmWXpQcTdNaUtxR1d5cHM5QzU2eHpsNWxnb2pWUXdzdVRD?=
 =?utf-8?B?ZWs5WEY2LytVaHNHLzAycWFBWXRBZnVudkJYYUVzZjlNdkRlcHFTYjE0Y3NI?=
 =?utf-8?B?TzVrWEhDWHhyUlUvMmJtNmlFeDJqaGwwRG0rV2lvby9uVmVoMFJkQStVZlRm?=
 =?utf-8?B?c0NhSEM4QStOSWIrNHlsTW9HalFkM3V5bmliTmpXaU93VkxrT2gwMkRqOVlX?=
 =?utf-8?B?UllQREh2L0lnNDdBLzV6SlFNRElmaCsvK1l6TVd3cFBHY25wQnEzc3kzRDJC?=
 =?utf-8?B?UDV3TXppVHpBTFo4UUhpTHV4dDVlbTVyQWYwanNGV2lFYWNKeU1LWlpvTlRO?=
 =?utf-8?B?WHRleXk2d1dGdXRSWnc5U0JnTEd6RktlSjhkVEdvcFNXZFJ2dVFlcUVUTldq?=
 =?utf-8?B?c2J5c0FXTHllL2xvVkwrS2x4OUdqd0xJYllGOW01RVdpT1lMNGZMajVjSFJK?=
 =?utf-8?B?S0tBOGo5RWVkcHdDNUpOWHVNTHBGbG1LY2JiN2pkWGNSaDVlZWNLR3d5eXhR?=
 =?utf-8?B?WUwrTU9VbmxwZjBEaGNDYVBRbmJKY3g4RWxjN0kzMkllcEFlMFN4WFRyNkV3?=
 =?utf-8?B?R3pwZVBDT3owbmRxZTVHa1dPRjVoaFpCMUY2YjdqTDl2NnBOakZURVRHNlE2?=
 =?utf-8?B?T3l5bWdLRnc5a1M1V2R1dmNhZXc5T1R6bWI4QnVDNzAyOVBRUmRIZVNCalNh?=
 =?utf-8?B?Y0VleUpTanVUSDdnS3htbjQ2QWh3NXJOTWZPbThZRmtpdGFHSTJEWkZUYWVl?=
 =?utf-8?Q?sj9ZR+jaRuM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVNtWlRINEN0WEJPTnhDdTFuTmtUUzVmTG9QSVd5UXl1QWlRZGFTSVJvdFI1?=
 =?utf-8?B?YUdrNEZkTkVINTQ3ai9VTVhVZVRrd0VVb2UybXRjMEJFZUhld2U4T1g2TGRt?=
 =?utf-8?B?ZVRFQzJtRHhnT00ydGhudmloZmpUNFZPbW9EMkhHSk1LcmYyVXFRSVZIN1pU?=
 =?utf-8?B?Q0dFRkdaYmgyMTdoZGhmUjRSUDc3OGorUkNpRklOVEROYnNmRG05a2JGWC9x?=
 =?utf-8?B?V3hXSk13U3BaWmxaNDRkRmowdW4xRWVmdnVUMXdycUNNd0JvOXJ0OUk1RlVP?=
 =?utf-8?B?cnJRSzRKM05MNjEwd213UVltTW94NnpoTDFWaCtHVmpzMDRPdkNwYlRQcWdO?=
 =?utf-8?B?dFVrTVZaVGNGRlZPZGlnb3NMelF6WXBGanNSbld3RkMyK25zdHVLVXN4eGE4?=
 =?utf-8?B?S0huMFZGUnpyMzZ5bWZTVmU5TjRrbWs4bk9FTUVVWnFGZ1I1c21vTUpiRzJn?=
 =?utf-8?B?Z2xVcjV5RDVtR0RhVjdQdEZkbHlWSFNXY1RDZXdkbUJOSEY0K0ZBV0o2cUFY?=
 =?utf-8?B?djRobGJ1YWY0N0h6QlFxVmNDanRML1FGSFRob1pySGRqU0JhZ2lJYnpEdjI3?=
 =?utf-8?B?OG43bWEzWEl3bVdxR0ltMjBIMXN0cmJSbWs2bGp3clJ6SVhTeWZudnBkUWto?=
 =?utf-8?B?R3V4aGV2YzZva0s5WUtxZU42QUFXWHM2dEpEemIrYkk5WCtIQWtJQTVNTEFL?=
 =?utf-8?B?dlkxeC9yMEpPdVBrajJYVkFnUUdGS3VvN3EzRVk0L0h0U2FTaXNTWUxSaTdk?=
 =?utf-8?B?YUI5MHp5RWpObmNwNFB4OVNXMU1DYXVJVzhZODRxNHIwam5SdW5HS1RTdFM5?=
 =?utf-8?B?c3J4YkhiaUlVd0hiT3ppa2FWUWVOS25TSXNzSXhnV1V3M2dSSy9ydmZPanNI?=
 =?utf-8?B?UHdCd3JhN3o0NEJ5bU03dzVhdWhuejZzUEoyQUswdTVvMjM0QzRLOUpWYlFP?=
 =?utf-8?B?MkZLY05qb2s0RTE3eFlTMVhJcWNtMjYwNUNaWmlMNld0MzF1R3YzcEVXeGx2?=
 =?utf-8?B?YXN3RE9WRUx0NVNUWXNMZWtiUmRtaThrV3d4Rk5xTEtVOCszbWxKdXJEaVNn?=
 =?utf-8?B?Sko3bXdka3JCVHZUa21meCsyOEU0cmZxZ1FwdU9zN1NvanlYRHE3bUVna3d6?=
 =?utf-8?B?aUw5UXRrM3k4Sng1TGdCMTNRZlJCR1Ivai9qbHdGQloydTlKNFRpVTJqK3Zq?=
 =?utf-8?B?N1NxMm8zVjExd2Vmc2ZaY3VZVlBlL2pGV2NBMnFaNEsyNWVwekQ0UUZNam5R?=
 =?utf-8?B?cWhzTmUyYjV2ekRFbUNTRlNYVFJiY3hmYzdBMWNZYUkrbDZadi94Y3pJRk5I?=
 =?utf-8?B?VzNhZGR3SGY1UDkwRktDRjUwa3d3bjlMMGFOejd6WkRjRnIvOFhpQWNwMzhE?=
 =?utf-8?B?VzRER0Zid0pUUTVUbVlzY3hDTktoOWwyUXFYUzZlUU1TMU5BY1EvRWFLYnRF?=
 =?utf-8?B?TjVqa2hFVUZndExiNFdZeGtrb1VxNzBqMXBDblhaQjk1WlVaYzArcDUvOFJY?=
 =?utf-8?B?UFNTMkFxNFc3Q2xaVGtuMTNXK3lrWHltQXFrNXc5cGpXb0F6bnlSZXEyZTNw?=
 =?utf-8?B?ak1rNnQ1akhNL2tGZTZibnY4djRWd29MTU5tM0tYOHFnM3k1SVFqUklranNt?=
 =?utf-8?B?TVN6clp5Yk1tZ3hyTTg4NndpWHdpdFN5SFR4d1R2UzM1MVBBbXoyNVV6UE5m?=
 =?utf-8?B?dERITlZVL0FoTDVDVFpCd0RnKy9BZjNrTERMcjk2ZTRFblZaMFMxbndQdldX?=
 =?utf-8?B?Q2R3TjVhODZhOG9rakcvb2ttUTFXZjhKRXZVNmlQZ1hYUitJTUg3emxBSjA2?=
 =?utf-8?B?SFlTWTlrblAwVUhsVG1Rd2dlMHc4WE5va2xMK3ZHR2NIWkFEZlNUWm5CcnZ6?=
 =?utf-8?B?WHZEZjlDbUNuNllQZS8zTjVXaS8xOUZmQkhHZGloOERoZlVleEFnc21KMTV3?=
 =?utf-8?B?K3ZaWnlRemN0MytzdVFZVDU5ZlpMTHVGc2grVXVyV1dpRk0ySDZ2Z3pIcE5R?=
 =?utf-8?B?T3dpNEVET0xReURNeThzZEpBaFhyMWVWaWR0UFQxcElNWGxlbEhBZE9TOHBO?=
 =?utf-8?B?bnZPRFlQbW5VeFFIcXZURDJVTkVQb3BMNjlwR2hKN2x5TFZlMHBxL2I3eWda?=
 =?utf-8?Q?X41A9aqZ843wCBMxLPbVGUV0c?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aeffe16-6119-4e18-c7d1-08ddc60d6a60
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 15:11:48.0350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v9j/xvJdxzQ7R80OPyuN2XBIJpzMShd4I23YXAd+XziiWo7sQ23MkKxJXxEdEy/wIURbr81COYKQpk5yQoJeXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8421
X-OriginatorOrg: intel.com

Xu Yilun wrote:
> On Thu, Jul 17, 2025 at 09:56:01AM -0700, Ackerley Tng wrote:
> > Xu Yilun <yilun.xu@linux.intel.com> writes:
> > 
> > > On Wed, Jul 16, 2025 at 03:22:06PM -0700, Ackerley Tng wrote:
> > >> Yan Zhao <yan.y.zhao@intel.com> writes:
> > >> 
> > >> > On Tue, Jun 24, 2025 at 07:10:38AM -0700, Vishal Annapurve wrote:
> > >> >> On Tue, Jun 24, 2025 at 6:08 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >> >> >
> > >> >> > On Tue, Jun 24, 2025 at 06:23:54PM +1000, Alexey Kardashevskiy wrote:
> > >> >> >
> > >> >> > > Now, I am rebasing my RFC on top of this patchset and it fails in
> > >> >> > > kvm_gmem_has_safe_refcount() as IOMMU holds references to all these
> > >> >> > > folios in my RFC.
> > >> >> > >
> > >> >> > > So what is the expected sequence here? The userspace unmaps a DMA
> > >> >> > > page and maps it back right away, all from the userspace? The end
> > >> >> > > result will be the exactly same which seems useless. And IOMMU TLB
> > >> >> 
> > >> >>  As Jason described, ideally IOMMU just like KVM, should just:
> > >> >> 1) Directly rely on guest_memfd for pinning -> no page refcounts taken
> > >> >> by IOMMU stack
> > >> > In TDX connect, TDX module and TDs do not trust VMM. So, it's the TDs to inform
> > >> > TDX module about which pages are used by it for DMAs purposes.
> > >> > So, if a page is regarded as pinned by TDs for DMA, the TDX module will fail the
> > >> > unmap of the pages from S-EPT.
> > >> >
> > >> > If IOMMU side does not increase refcount, IMHO, some way to indicate that
> > >> > certain PFNs are used by TDs for DMA is still required, so guest_memfd can
> > >> > reject the request before attempting the actual unmap.
> > >> > Otherwise, the unmap of TD-DMA-pinned pages will fail.
> > >> >
> > >> > Upon this kind of unmapping failure, it also doesn't help for host to retry
> > >> > unmapping without unpinning from TD.
> > >> >
> > >> >
> > >> 
> > >> Yan, Yilun, would it work if, on conversion,
> > >> 
> > >> 1. guest_memfd notifies IOMMU that a conversion is about to happen for a
> > >>    PFN range
> > >
> > > It is the Guest fw call to release the pinning.
> > 
> > I see, thanks for explaining.
> > 
> > > By the time VMM get the
> > > conversion requirement, the page is already physically unpinned. So I
> > > agree with Jason the pinning doesn't have to reach to iommu from SW POV.
> > >
> > 
> > If by the time KVM gets the conversion request, the page is unpinned,
> > then we're all good, right?
> 
> Yes, unless guest doesn't unpin the page first by mistake.

Or maliciously?  :-(

My initial response to this was that this is a bug and we don't need to be
concerned with it.  However, can't this be a DOS from one TD to crash the
system if the host uses the private page for something else and the
machine #MC's?

Ira

> Guest would
> invoke a fw call tdg.mem.page.release to unpin the page before
> KVM_HC_MAP_GPA_RANGE.
> 
> > 
> > When guest_memfd gets the conversion request, as part of conversion
> > handling it will request to zap the page from stage-2 page tables. TDX
> > module would see that the page is unpinned and the unmapping will
> > proceed fine. Is that understanding correct?
> 
> Yes, again unless guess doesn't unpin.
> 
> > 
> > >> 2. IOMMU forwards the notification to TDX code in the kernel
> > >> 3. TDX code in kernel tells TDX module to stop thinking of any PFNs in
> > >>    the range as pinned for DMA?
> > >
> > > TDX host can't stop the pinning. Actually this mechanism is to prevent
> > > host from unpin/unmap the DMA out of Guest expectation.
> > >
> > 
> > On this note, I'd also like to check something else. Putting TDX connect
> > and IOMMUs aside, if the host unmaps a guest private page today without
> > the guest requesting it, the unmapping will work and the guest will be
> > broken, right?
> 
> Correct. The unmapping will work, the guest can't continue anymore.
> 
> Thanks,
> Yilun



