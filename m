Return-Path: <linux-fsdevel+bounces-49140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D722DAB8886
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 15:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36067A061E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 13:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0A619DF60;
	Thu, 15 May 2025 13:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WKVeUohU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6E361FCE;
	Thu, 15 May 2025 13:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747316956; cv=fail; b=hycXNPUGqyK2J/y06AB4QLYhaUWssbmQ7gQmLKaXontz1o/10B3K72SGs8lxYoSfd/wvkOULoxde/1f0K4Gm7j4jqASuBnXYYP/HAW4WTIuP32SvmeavddLR1SPrZt373ooDPaGtgcS7lvSyIBE5nws1TIzeaJDyexfQPs3xvbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747316956; c=relaxed/simple;
	bh=nqtlTzHOkGhV9nsCwrm4LtFS2pIgX2IMi7707iwqmLM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XbbwYh2nG6UDATrWh8JT/rCtgXVuqr6e7Gr+uaZdu2/0sDat94u09MCBJLTdrTqs3iFvdICuaSFeYPKNCmfdVAvlZwlOIiNmqmpeAif3OTmClt/2yfVE/5TP5xb1K8DjNKc4IeL62EpzlB3R9Y0Nkt1JSkUHyOQumh4/Z2ewLHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WKVeUohU; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747316955; x=1778852955;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nqtlTzHOkGhV9nsCwrm4LtFS2pIgX2IMi7707iwqmLM=;
  b=WKVeUohUEVPnzNtC2X9w0uZB2pGrQWo8Fq3x6cB0MXZwiJHYzqCgvRaz
   mr7iIUzdjToElto2Xfaw3dQgsibMJE9JMBdmo3jszs0+s/ZqBBQTMGtAY
   xfvZfCyD7he+ddIppnlv01erd+iPLoPDWv6ijgc1P6IDEBRkOFkLSbxJp
   4mQShcsJm8t5M+M75Chzice2ppz1nzkZ/Djdv6vy+Zz8Ld1rg0yyd8DoB
   SgvoOYwhF2/l8gG1u24FsVDgE5z5ouz+Q/AIsKHW3pR5WnsbpZNm9RSCs
   KuX+Pedn00x3Mz4V/D3rt3vEZz1oMWAYPRo+HZg5eaUklpAiDCLdiqNtA
   w==;
X-CSE-ConnectionGUID: wPbapACNQmSp3GrhW7LliA==
X-CSE-MsgGUID: 5N2nTjV2R9mIXAX9+81xzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="60268530"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="60268530"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 06:49:14 -0700
X-CSE-ConnectionGUID: FQsc+nXlTAeec0KZnl4EZg==
X-CSE-MsgGUID: BrMkT6twTtKxzWCigspwuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="139369356"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 06:49:11 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 06:49:10 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 06:49:10 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 06:49:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZnvAwvOUJbYGQj69AaKCJZOpAqtsctIgy/u51FiY8caROzQlnl6Vqv5hLz5I/vA8OeU8gN8CjODpINWewxeJ0J66kqJX+6f0obI4T51qAR7z81srzcjHrINwQeTxtmcKJgmL9l5rL5v1pFKneYjHwMPLjHOrzkk235HE0eBdsn8q4nQv3d4xZDmBSaJ1HE0Isu4SQuK/n+TFNJAfmxoo2QzOer2Oovx2FvUni+2cFOFvBtQIIgKBeJTsangFEZYdCs+t4ZMj04qkK/p93fDvSYva8R22ZcQgP0vTPZprtnDXfUURXV3R2sm8eNMGpz+j6XNEsw69ak1OqZiNo6SX3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgZj202aF2joKNLQ9HVKrg7V1/VcuY8r0voiVaaIEQw=;
 b=yFryjRRV9mC8SffiEhYMwj/83UxxiHEiFCMMliJ+0PshWMCMTvaBqOjmgKnkZC1y1WFk2FE9pR7Noayw6c+V+802RHYWLf6es2nN24l2A+qKRVBjqJDj2v0fUr3OEgvW33NlN00wl5erj2N1mJYZNeufIk4NthuJtGA0r8IRrdMh1RWf43LkttSsBpSdnl+TstH7gmjvWOpwlJVAynoUjtY9Tz2D0m/4laFCWfOsK8LMalBMPQ9NNVeEZBBmqKPUB4xL16QN2pLcVzVi7JyeOCldm+aXo0cHssXsNI4Hln+of2jXyMka2TvqYu4WjPr7b8GN/w7wDIx0fhXQ+AT6Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM6PR11MB4628.namprd11.prod.outlook.com (2603:10b6:5:28f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Thu, 15 May
 2025 13:49:07 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 13:49:07 +0000
Date: Thu, 15 May 2025 08:49:39 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Ackerley Tng <ackerleytng@google.com>, <kvm@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-fsdevel@vger.kernel.org>
CC: <ackerleytng@google.com>, <aik@amd.com>, <ajones@ventanamicro.com>,
	<akpm@linux-foundation.org>, <amoorthy@google.com>,
	<anthony.yznaga@oracle.com>, <anup@brainfault.org>, <aou@eecs.berkeley.edu>,
	<bfoster@redhat.com>, <binbin.wu@linux.intel.com>, <brauner@kernel.org>,
	<catalin.marinas@arm.com>, <chao.p.peng@intel.com>, <chenhuacai@kernel.org>,
	<dave.hansen@intel.com>, <david@redhat.com>, <dmatlack@google.com>,
	<dwmw@amazon.co.uk>, <erdemaktas@google.com>, <fan.du@intel.com>,
	<fvdl@google.com>, <graf@amazon.com>, <haibo1.xu@intel.com>,
	<hch@infradead.org>, <hughd@google.com>, <ira.weiny@intel.com>,
	<isaku.yamahata@intel.com>, <jack@suse.cz>, <james.morse@arm.com>,
	<jarkko@kernel.org>, <jgg@ziepe.ca>, <jgowans@amazon.com>,
	<jhubbard@nvidia.com>, <jroedel@suse.de>, <jthoughton@google.com>,
	<jun.miao@intel.com>, <kai.huang@intel.com>, <keirf@google.com>,
	<kent.overstreet@linux.dev>, <kirill.shutemov@intel.com>,
	<liam.merwick@oracle.com>, <maciej.wieczor-retman@intel.com>,
	<mail@maciej.szmigiero.name>, <maz@kernel.org>, <mic@digikod.net>,
	<michael.roth@amd.com>, <mpe@ellerman.id.au>, <muchun.song@linux.dev>,
	<nikunj@amd.com>, <nsaenz@amazon.es>, <oliver.upton@linux.dev>,
	<palmer@dabbelt.com>, <pankaj.gupta@amd.com>, <paul.walmsley@sifive.com>,
	<pbonzini@redhat.com>, <pdurrant@amazon.co.uk>, <peterx@redhat.com>,
	<pgonda@google.com>, <pvorel@suse.cz>, <qperret@google.com>,
	<quic_cvanscha@quicinc.com>, <quic_eberman@quicinc.com>,
	<quic_mnalajal@quicinc.com>, <quic_pderrin@quicinc.com>,
	<quic_pheragu@quicinc.com>, <quic_svaddagi@quicinc.com>,
	<quic_tsoni@quicinc.com>, <richard.weiyang@gmail.com>,
	<rick.p.edgecombe@intel.com>, <rientjes@google.com>, <roypat@amazon.co.uk>,
	<rppt@kernel.org>, <seanjc@google.com>, <shuah@kernel.org>,
	<steven.price@arm.com>, <steven.sistare@oracle.com>,
	<suzuki.poulose@arm.com>, <tabba@google.com>, <thomas.lendacky@amd.com>,
	<usama.arif@bytedance.com>, <vannapurve@google.com>, <vbabka@suse.cz>,
	<viro@zeniv.linux.org.uk>, <vkuznets@redhat.com>, <wei.w.wang@intel.com>,
	<will@kernel.org>, <willy@infradead.org>, <xiaoyao.li@intel.com>,
	<yan.y.zhao@intel.com>, <yilun.xu@intel.com>, <yuzenghui@huawei.com>,
	<zhiquan1.li@intel.com>
Subject: Re: [RFC PATCH v2 03/51] KVM: selftests: Update guest_memfd_test for
 INIT_PRIVATE flag
Message-ID: <6825f0f3ac8a7_337c392942d@iweiny-mobl.notmuch>
References: <cover.1747264138.git.ackerleytng@google.com>
 <65afac3b13851c442c72652904db6d5755299615.1747264138.git.ackerleytng@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <65afac3b13851c442c72652904db6d5755299615.1747264138.git.ackerleytng@google.com>
X-ClientProxiedBy: MW4P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::28) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM6PR11MB4628:EE_
X-MS-Office365-Filtering-Correlation-Id: f5f0df1a-f451-4a64-2397-08dd93b74313
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HvFigmNtoEpt9wRbnKAyGzrTZmsyHlJMcDw7TzH3PkA6wU8lHI3URx6MRYeT?=
 =?us-ascii?Q?iaXxciNU83coeoPgd4XJjUmsDSjeB6PUEh6qdtuRmwfnZucy4td01pYkF7jM?=
 =?us-ascii?Q?++TbubJJc0iJtftckv3F5lWbA/3BwspWTHgs3yU9XKnOOnqNKdn7Ev9dEynx?=
 =?us-ascii?Q?PeY5SZDTmvGKFznI2ynRnlmMBb1us776SU/od5V1B5ex7w16VUoLli6eZAJ1?=
 =?us-ascii?Q?GcJ0zeTrc7zAKqt9IHwMuMvhnkn7WNGDPILkvJYvLhix1CvFa9omOq0BoOpa?=
 =?us-ascii?Q?HL6Nop3bTtcNzEQrKdYu72erz4nZrEHjCFmygQzisbH+FAPd8SJsgbCYQAay?=
 =?us-ascii?Q?3iHOYYZU+eP0oTs5jFMi88taLfx8knCw6kRghy2JlmmDW2H22tiRwG3zdcPp?=
 =?us-ascii?Q?H15AGgZes0JWoFfvbheidizqn+kLscF9tpcpRfAnSfiNLep/VcHKejO4iWBs?=
 =?us-ascii?Q?Gti45hEQaDMl1chjf8P1YVGoYNufvJrYDAuzGRqGh+46rbDdeit5LIp1Yv3W?=
 =?us-ascii?Q?bxpoL6KtAV8vILglO/eM7qX/yPU6uSNRR4XLfue8l9PKZ6kZj5OynG4S3UXB?=
 =?us-ascii?Q?lZLz0aIbPb+iBQvOd4NBg6vhYKW2NTd0ns1j0PpHEZtHkXrCWSeH98OSj+sT?=
 =?us-ascii?Q?13zhvITSonMLH0atu7lCaDQeKU+pRO0CrYt2998dxunJl0vYS4mA6c9frCx2?=
 =?us-ascii?Q?PdUXWOUueuSaoui4on9Kosr3G8hljpXf07AZG0g5qGmA+Q/1PtUy14W5myM2?=
 =?us-ascii?Q?h1uPv0rjoPTh6f9hlFrS5ilyvqV7rS6jIE3BZThfC5brgql5KJor6hUetBro?=
 =?us-ascii?Q?YljxvO/I6S6HRBklg+HYCeablfVPcNzm54bbaByPAKQtA4J0mLawzXRixEf9?=
 =?us-ascii?Q?I1326T4RFXMP/YK0W9vz193KhcuhgZNfNfcX7nC7308aIAZZ7O2WjarNWriz?=
 =?us-ascii?Q?MrZch7cexQnat7uzm8gVwRya2Osavl5MLmb0fJQRAeWvKuXzf2FFf814IPPB?=
 =?us-ascii?Q?MDxhEF+LD2yKQAtpGqXpdhyXZrylBzFM8+L2OeIyZL0bbOO1rIFwYqYQmdzO?=
 =?us-ascii?Q?f4x8XwexhfwQD9Yk1ncYa0fHbnFFEBbUoFUFkFXa797nlDGudzxg66SNwtOj?=
 =?us-ascii?Q?27q/IyIbfgTVX+xP+cQjt9uZixPjpuGOdZYgJUWNNd5XnuxkdYpEgqXkPTzu?=
 =?us-ascii?Q?hO8XWd1eXoBbFVMlrXkajyIH7ZRFgMV5sis479CyvvSzg9mk3quXjfhRlz92?=
 =?us-ascii?Q?QlMou1oDIrjxha3/SdBhhAWCwiUvAsll+nXmVFjgrYIEc5opiyN5+iZ/wcVt?=
 =?us-ascii?Q?2qyLU7j5d+LGfvAfnH7IGe1DAfoovncc6kLC5H3VspIWftghPcnSmz2A34kj?=
 =?us-ascii?Q?NKWcgVyH/dnQuhv4nDqw5ijZUBzqEG84bAUhNmC1/e5vmWvWmQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ytew5Zz4LrowHCX1q5V3usSKzRL5mQor/PdqhBXN3J6gTdxMaO9lwwoYkd5N?=
 =?us-ascii?Q?6BWmpMKMzoCv617YsOXXXDvE0ywGfEjzACw3b2pedh9Bqe4oxWa7N+cc43g8?=
 =?us-ascii?Q?DIIZ5CPYsdmJsF7fbq92u3HMZ4wZ4NSWzqOJI4p+cZeZnzbL+6E/wqlmqUWx?=
 =?us-ascii?Q?DhRmB7URuKa3p+w+3B34+nY3wzbUCUbync4MB3ZVXumFsWjCRsWs5hhABhQA?=
 =?us-ascii?Q?tuFGXYeRL+oJ0j8B1rRt85u/nrNZX2k9z1XwM95Dn/vAMzN8k5ysRj9RkwQk?=
 =?us-ascii?Q?9BD8s44vrdWx78oI3u7qhZhrc7hPFdPJzWeyBqIT9a3HKYr6PVDbIMRj3k/S?=
 =?us-ascii?Q?CpiOZ3Y+5n/Fb9GWqDOYfiKdDubSlEZDdbAxjnnVUtrvtdx1sqtoFfO1D6sP?=
 =?us-ascii?Q?AJCytcTlRk+qFjqQCqXmMGXhLIoGR18avuNtf4rsEZ5zXXLNwV1a9jzDoUma?=
 =?us-ascii?Q?rAJyRan1soSQdO2TVmZVKRzvt/c3PXbs14wKxrqhQZOD1mTnWEOtMqp0LFny?=
 =?us-ascii?Q?jhq1qmFxFTYZsVZ9aFWoyq6Zw4mPIsFqno4PSNH/+IfaTGJv+5+85dL5Toph?=
 =?us-ascii?Q?hUZSH0CKdV/gkpk+Gd9l6igMu6GUbECKoCvjEWAwHPcnFSFZ1qfZb8rpIq3m?=
 =?us-ascii?Q?VwfW04pzJq9JXxyYmNjbkaRDp/lQKOogM+MruqfMaOayCgbac4x/GND5cpQ7?=
 =?us-ascii?Q?9YEUBH8WDlmMmQ7RRUKj/sqdMiyv8FwHTw05I8Mx2osOcKMTwMDJCQR3vZna?=
 =?us-ascii?Q?F/zZ7UETHht30Dn6i5uL63weNLyqlP2bf6lTMoGPh64SE+U+hzyaeRywgqiE?=
 =?us-ascii?Q?ryGPM8Ckjna3Me1p9QWXK1YEy0xBFYgUN8o44ytxprPF8dYLpNgmtlPkT6Pt?=
 =?us-ascii?Q?dF+EbIUEXqanVI6Y9dX4/awvQH9kBTmGlszVrUeSppK6HZNmUP5awkvPeZzO?=
 =?us-ascii?Q?h1ru3AdrV4DkKx8cmSPBnpy8fAgbSPHCcfjXY3jI2ysp9fs65XH6k27KjQ7B?=
 =?us-ascii?Q?syS6SJ4naEM4F8PbLAxXB2SCNKPOOpCVNBuScYRDhFNdHueJAZ8yatP8FXaP?=
 =?us-ascii?Q?hXwfE/v2K9lb2gXMb/ztUc0u8Wdy6cpJ4qT8GA9wnR/OKDaAOrGZQCqwZ49q?=
 =?us-ascii?Q?ZvgmZiTNGlbXiO4rOJ0C4WtW+xpc8FJFfRHde1P7uN1AHwi4zeK6bgcCQimz?=
 =?us-ascii?Q?9E6nHda/CzI6D9CMhKq2oCGrH+UMmPqNzkxlaruoCQxQhhnA1RH6+LgZ3ngj?=
 =?us-ascii?Q?J6RHAO818fAooRPD6xL/Yie5JKST0/ZrQfkQ5y3pw3ywsgFaXh9Vv8d9gSun?=
 =?us-ascii?Q?r80a2MyRz2S5vSxNRhYWKB4GcIpht/rBc6tplfS/uRBLg/vMnejxzhYh2hFU?=
 =?us-ascii?Q?5NvCCHEfOmCahV8TZw3oWf9KT5ZSTDx5pCPnCYxGv2444vX22ZI+qgHG9bS9?=
 =?us-ascii?Q?hriS42/jls4uwu7a9bhHFAagGpbjQMlAx404PHd8A+89yImHKyNTStujyiqj?=
 =?us-ascii?Q?ijr6IyjMpIVAKirUhFkRbWi9dzD9O0N/TJpQzgv3VG8vmwltbam7JuyCrx6m?=
 =?us-ascii?Q?ACt/BVJFdbpZVXnu/Cwb8ghMItLtrFzwd+CV5vOH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f0df1a-f451-4a64-2397-08dd93b74313
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 13:49:07.2328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DeGbuYXWfkbp6QoqA50IFpqge8o4AyXvJu8yMdZUG9PyKJ3DTbPO8yYmBx7sVz9TARHqt/4Ls5n1RbItP/1vSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4628
X-OriginatorOrg: intel.com

Ackerley Tng wrote:
> Test that GUEST_MEMFD_FLAG_INIT_PRIVATE is only valid when
> GUEST_MEMFD_FLAG_SUPPORT_SHARED is set.
> 
> Change-Id: I506e236a232047cfaee17bcaed02ee14c8d25bbb
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>  .../testing/selftests/kvm/guest_memfd_test.c  | 36 ++++++++++++-------
>  1 file changed, 24 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
> index 60aaba5808a5..bf2876cbd711 100644
> --- a/tools/testing/selftests/kvm/guest_memfd_test.c
> +++ b/tools/testing/selftests/kvm/guest_memfd_test.c
> @@ -401,13 +401,31 @@ static void test_with_type(unsigned long vm_type, uint64_t guest_memfd_flags,
>  	kvm_vm_release(vm);
>  }
>  
> +static void test_vm_with_gmem_flag(struct kvm_vm *vm, uint64_t flag,
> +				   bool expect_valid)
> +{
> +	size_t page_size = getpagesize();
> +	int fd;
> +
> +	fd = __vm_create_guest_memfd(vm, page_size, flag);
> +
> +	if (expect_valid) {
> +		TEST_ASSERT(fd > 0,
> +			    "guest_memfd() with flag '0x%lx' should be valid",
> +			    flag);
> +		close(fd);
> +	} else {
> +		TEST_ASSERT(fd == -1 && errno == EINVAL,
> +			    "guest_memfd() with flag '0x%lx' should fail with EINVAL",
> +			    flag);
> +	}
> +}
> +
>  static void test_vm_type_gmem_flag_validity(unsigned long vm_type,
>  					    uint64_t expected_valid_flags)
>  {
> -	size_t page_size = getpagesize();
>  	struct kvm_vm *vm;
>  	uint64_t flag = 0;
> -	int fd;
>  
>  	if (!(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(vm_type)))
>  		return;
> @@ -415,17 +433,11 @@ static void test_vm_type_gmem_flag_validity(unsigned long vm_type,
>  	vm = vm_create_barebones_type(vm_type);
>  
>  	for (flag = BIT(0); flag; flag <<= 1) {
> -		fd = __vm_create_guest_memfd(vm, page_size, flag);
> +		test_vm_with_gmem_flag(vm, flag, flag & expected_valid_flags);
>  
> -		if (flag & expected_valid_flags) {
> -			TEST_ASSERT(fd > 0,
> -				    "guest_memfd() with flag '0x%lx' should be valid",
> -				    flag);
> -			close(fd);
> -		} else {
> -			TEST_ASSERT(fd == -1 && errno == EINVAL,
> -				    "guest_memfd() with flag '0x%lx' should fail with EINVAL",
> -				    flag);
> +		if (flag == GUEST_MEMFD_FLAG_SUPPORT_SHARED) {
> +			test_vm_with_gmem_flag(
> +				vm, flag | GUEST_MEMFD_FLAG_INIT_PRIVATE, true);

I don't understand the point of this check.  In 2/51 we set 
GUEST_MEMFD_FLAG_INIT_PRIVATE when GUEST_MEMFD_FLAG_SUPPORT_SHARED is set.

When can this check ever fail?

Ira

