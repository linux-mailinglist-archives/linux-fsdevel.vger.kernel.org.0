Return-Path: <linux-fsdevel+bounces-49299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE50ABA3D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 21:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9743A3BADCD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 19:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8925927FD75;
	Fri, 16 May 2025 19:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bo7N5pmf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A477322579E;
	Fri, 16 May 2025 19:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747423884; cv=fail; b=rApUevmYJI51nYWyN9axke8HMbqgMblPXsjkrisWCnuAXaSOLvs+wBRoRcRF2ZiKwrlLWbLT5373N1k01eQ9dJBUFuU8aLAzoDLHlBBzg6ICDokRlrrlhtLuudqNewUw45yoP03w1Z+9pXMykxdKI3/E9e/7nDwSWp7EgzAjvjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747423884; c=relaxed/simple;
	bh=UT3hCACU54AcoUFPSJYdcsbTP2ftTEdmKrNckDo5AxA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oMHjPhlEd9NRbx7V/gS4YFQEtX+qaCt9YTr6zLcwt4TJVP+M6ORCzF203FP/qve41KIqwxhr9hVq4agMs3G7oBvTlxJ00mUd7zKG/yO1nmz99E9AlKphGCryaSPaKRbG3VtkmV0VGC9ALVIvgS7WohUe9WlsfHyigbofc2QDHqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bo7N5pmf; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747423883; x=1778959883;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UT3hCACU54AcoUFPSJYdcsbTP2ftTEdmKrNckDo5AxA=;
  b=Bo7N5pmf1TeNYnc1eNNGsQHelxkNrTiRRHT20PDXlI4lRLIN4Vtv/TEn
   9a0tXMzUm7447H5J4c1xIc+mgWLClDxNFXyli3mOee5MMrCHxDviUomk2
   p9IiLeA0ZYXrWlUvoIlrFRSeZ3PqeR7kNeQ5AbDsLoVpwectdUrxd8wXi
   4XNgqpFKsDYXDkzJanddBloAT5QgGpUOUf16GN9uCgK2jCQwV/c2oiiwU
   CxrrRh2pUXRFmXM3Cwankw6Tx9wn2kGScNSmHjRsYNIYF/mJRQExqBLIU
   WZJY9Jw/lw6o375Ysp+qZA2XIwJfJEpSFa3X6HlU+z1+rCru3bTkXIpv2
   Q==;
X-CSE-ConnectionGUID: K0wPtSQLQP2LUuI8fFTYVA==
X-CSE-MsgGUID: DS09NWyXTwSgfgYRFHDCVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="59635745"
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="59635745"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 12:31:22 -0700
X-CSE-ConnectionGUID: trABqg1ARJKNAOmgSQR2wA==
X-CSE-MsgGUID: ZuPYf3LBRPaeiZZZ5CR+ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="142774250"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 12:31:20 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 16 May 2025 12:31:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 16 May 2025 12:31:19 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 16 May 2025 12:31:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bmYU8vLcYWY8h18UOpSQID5C9J3+BzxuLQuUKwTTEF90RgkXtedmRZ1eDFy7K5kEfo2Bdpz33yRFMQie30rRNWfMDiYPQFK5vylpTAfkklllIxvyI2yyBOQOYszuxS5yE8iz1loRqFKu2d4FNssGfizjakG1LKL3tIvE6KP8H1s6OuUQ2E4eBE99tJfntssFh+5KAUq2XGvhcuEU+Kk6HeTZS5NmcY+KXxapPt0eFwN7E5AllhWccv/nbncpz3aBdRMnq5+gEUljq/bTCOVBUZTzHUL6wEM+eNmnJqTYECOMxTgk2iZmlghWQFzoLXCx14LHHnV0uJlBNSg+Z+t7jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ptOhPihm8lnQT62A9fA9Z/3HZTfsXg8YtrZQbbsEdE=;
 b=FXXtpx9OxPjkyEd88Agl4Zy+jxOaFwnNTvjDUI29OQfcUdo45fyanAsAH7B3GxX7RwCdedcViUCgvscewE3tln2PA7EfaV6gTiaD9aw0+YEo12/Z8/RtolqrEjFflsl9lHZup991H1HnssOXDhUr4H4JThwTTMnaeRQysZmPrdEBio9tw3riYe8HwUayC90nfebW17+/CHJWMPqia5Dsfomea1qmwffPCk97OZgqzD9+Y8gdyrcSiJB8j45fmAs/Yshf/lh3tgWNbmmAq7HV9nfcjDWHVAyMMtcRCz/DqDc4hV/0FHGF7rH+v3eJViWXy3bOZqK/ui4P9K6MVwbhxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA1PR11MB7942.namprd11.prod.outlook.com (2603:10b6:208:3fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 19:31:01 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 19:31:01 +0000
Date: Fri, 16 May 2025 14:31:36 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Ackerley Tng <ackerleytng@google.com>, Ira Weiny <ira.weiny@intel.com>,
	<kvm@vger.kernel.org>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <linux-fsdevel@vger.kernel.org>
CC: <aik@amd.com>, <ajones@ventanamicro.com>, <akpm@linux-foundation.org>,
	<amoorthy@google.com>, <anthony.yznaga@oracle.com>, <anup@brainfault.org>,
	<aou@eecs.berkeley.edu>, <bfoster@redhat.com>, <binbin.wu@linux.intel.com>,
	<brauner@kernel.org>, <catalin.marinas@arm.com>, <chao.p.peng@intel.com>,
	<chenhuacai@kernel.org>, <dave.hansen@intel.com>, <david@redhat.com>,
	<dmatlack@google.com>, <dwmw@amazon.co.uk>, <erdemaktas@google.com>,
	<fan.du@intel.com>, <fvdl@google.com>, <graf@amazon.com>,
	<haibo1.xu@intel.com>, <hch@infradead.org>, <hughd@google.com>,
	<ira.weiny@intel.com>, <isaku.yamahata@intel.com>, <jack@suse.cz>,
	<james.morse@arm.com>, <jarkko@kernel.org>, <jgg@ziepe.ca>,
	<jgowans@amazon.com>, <jhubbard@nvidia.com>, <jroedel@suse.de>,
	<jthoughton@google.com>, <jun.miao@intel.com>, <kai.huang@intel.com>,
	<keirf@google.com>, <kent.overstreet@linux.dev>, <kirill.shutemov@intel.com>,
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
Message-ID: <682792986c060_34533a294d1@iweiny-mobl.notmuch>
References: <cover.1747264138.git.ackerleytng@google.com>
 <65afac3b13851c442c72652904db6d5755299615.1747264138.git.ackerleytng@google.com>
 <6825f0f3ac8a7_337c392942d@iweiny-mobl.notmuch>
 <diqzmsbcfo4o.fsf@ackerleytng-ctop.c.googlers.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <diqzmsbcfo4o.fsf@ackerleytng-ctop.c.googlers.com>
X-ClientProxiedBy: MW2PR16CA0003.namprd16.prod.outlook.com (2603:10b6:907::16)
 To SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA1PR11MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e7eedc9-ba7f-4c7b-4472-08dd94b030bf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7nTt572uCfCRxMhQNHYb9xyixxLk7ifKSnJ/QxinhrIb4c7rUbOpY2i/f8cd?=
 =?us-ascii?Q?gBxN+txHIdizsT5i7U1ARnuoD78sqho8oJ+/CeiMAVVbSS4VY0MLELqwK5aL?=
 =?us-ascii?Q?ygQMNf2Sa0yLsJRgayA/Lm6alRvKlQr0y2H3d7CYFNI/Me1tqrr5Od01CTAf?=
 =?us-ascii?Q?cPP+s6TGfKx5bV/Xf20IR5ZH8lOXCcVapsQyeGsQ3YGclCXJNpx1q+XCW3fY?=
 =?us-ascii?Q?fCF3ZlVEiqrLj4EYbTMWbaztVWfm2ZVQINe38x2fg3DFE+1IouqPB4XlZ0No?=
 =?us-ascii?Q?LGhPtakIwBNMmt7rpe0lLbtCkdXzMkS4mjSMk9R9QGFT4knGeJsQVUaCaWUi?=
 =?us-ascii?Q?6pAAJOkilCux5brHA1p8uJSL2jcvIuk1gVlI3k1ItFAc4gNYwanVFxdV13R0?=
 =?us-ascii?Q?QKYL6oNFiVCr7wDjhcyZRT8PWP2SYZs5D0o878s5/BiJNnpEI+vOVjydO/PB?=
 =?us-ascii?Q?FHOA0KW59+ciF2pA0kyoN/9wIEIPoyOglPFAQc6mTlqrVYGMTH3PYZMidtnx?=
 =?us-ascii?Q?t4GmoTrUjXDj1/24kiexr3T72TvAVdxYKUKQULsgAa8jdNMyB8dcSCqHoNsm?=
 =?us-ascii?Q?OHuNRrlJWk2/WDmZdD0TbgWYvYMg2sN7kSIc0lq8ruQhqubYE8mSfwJwRW6Z?=
 =?us-ascii?Q?ybbtOI+HyNremEbmi0Ob4wj4qgbbBJgjA17V4a8tvhZySwJRApR3sdeK72wE?=
 =?us-ascii?Q?dUKVpTagHhZr5fymK0Swra9JEjtuPHi1PyX8hyu9DR2q4BmavuX/MUspHgea?=
 =?us-ascii?Q?VO0IhGUNFFYNT6BA+ytjWvHD446BQ3UfePhZUedUEOvhRZ4sIAYprEBBprO/?=
 =?us-ascii?Q?VPaW3J4KeHi+UR/75VvLrq3uSTRVU2xrBwpkWMPikJTGSQ98zLCMXFUwq3Lk?=
 =?us-ascii?Q?Tw/wD+2NXvRRNXODHweQJEnzav+MG31Dw7TUx4ph24v8/F9RbNiDT9PJk5Uf?=
 =?us-ascii?Q?DQKmb97XPczSGy4G4xXEBAk0YQ6Vl0sJFOFlPskK8JZsvFZ9Hqz5W+OHbbAn?=
 =?us-ascii?Q?zDvzRiqCpvRdWcChL09eYAMRUUvp7JCmXKsfzyt01pMRlx3SD9XGj86LOM+j?=
 =?us-ascii?Q?XN/v8hU2rChQfymb3MXzHIkFTIkM2qfipPZSYy7yo4sTTyvWNMEv+W+1OaLP?=
 =?us-ascii?Q?HHhdrWh141CDNNyNdUlFxY1Mp/0RgVmQN3un06cdsnQoeuW/N6l3lq9eZtPq?=
 =?us-ascii?Q?T9RmalRoZzUVHzp1altFbn9lw32F8hjlSeNfwjCOQ+nVoJCIvydyrISIPgky?=
 =?us-ascii?Q?5koB6yxKmPGmVqaIPj2T26ldNq/yrKR/tMxgIGm+dK30xpG2E38GEyU/p0me?=
 =?us-ascii?Q?rCcIn1q60ekIQDN3XhUPIOlhkNnYVl4KA+bKWVAIjj/KZRFuq6oxyCN5bw4s?=
 =?us-ascii?Q?PEFh/SOZew+/iMRYA2LgFyK3P2l399Zd3zkLmPVhNJ2oyvi+Pg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i8jtgAf1OW2QVrlb7W82DneTOeKqMX8luKCLhZ14aqhfBguLIzmG+kdwxZxC?=
 =?us-ascii?Q?K4ck+Z/RUMu9kgHcpD4ZowNltqDnW6OQ9/wjHaUQN3rVU2W1uIMFQiceIyC2?=
 =?us-ascii?Q?ysHr7JCL72afzkRNOYpAQ6VcUFTlDSi8l2E2Jf0YbCqGp5FkiGiQWSz4/N35?=
 =?us-ascii?Q?JcQEX7b6i/ppwW2Vofg1DUdpjz4XQNBUljUYeT2MXSaa2frqkexfNif/L83V?=
 =?us-ascii?Q?CXut+z/+3BmC+3VxvhXVj+qthlNgkPWatCmTP+dBdzTXeyGVu9xw0u3MJvAG?=
 =?us-ascii?Q?3dVGOENoxZRHGNUrq/k+BO7Js+Vanhspl57LOfGuSSP92YOGc0uPyQ30fEg6?=
 =?us-ascii?Q?LvK684NVi8KxAIJSvW3vDrT3Ok+iDqEG0w/PuuLeeGSH77A5xRhzSyp7kwpI?=
 =?us-ascii?Q?OzbGzX2ZB3G46VTR7wo3OjmtfsKWlWOrG9r/YEPRv/HhYBw365tuwCpBoa5x?=
 =?us-ascii?Q?/FebZKR8ByCNaFLZ6UcAPtS4qmMlkTLluSDNksYV1FjEzWdKFYs127R6Lpef?=
 =?us-ascii?Q?BPCBVufz+SNajTMOamlmYMliCG08iXJ+DMEWZ7IUJb035MnK/dDQe7hB8Zq6?=
 =?us-ascii?Q?y5LUDeO70iXKr8W2b4xiPznktL66EePBPqAOFm8O4WFiT4AbUpTlG/8yPU0Q?=
 =?us-ascii?Q?kGwTuerbT12txNoKVls5cJocvB5MiUPAY/N+EepltC7LLHnt1e216Into4Hi?=
 =?us-ascii?Q?BQEMUxNDGH6ihsgukyZXKMqhFjB5JTGIiV4t++BV/pL4mXyJPh4EoydAIoZk?=
 =?us-ascii?Q?s1eM6VQEmsbi2tXfF/p/mTyp54z4GBArNpam9mhO+325ftNe6VVUJUU3yUDm?=
 =?us-ascii?Q?QX55JhqoeKD9whx/PX38lY+YBechuUKN20/beIpPkWc1/Og7clihSPEQk5uf?=
 =?us-ascii?Q?SZBFWmgOn2YPNcVpWJU9aC28NDoUhQ2jAMw842fW9efWOh8BiWbvczSZIkhW?=
 =?us-ascii?Q?feZm1guCADTvgwbE7WNtCtUsKzQjLGLUjoPN9hvdC5RgKUdGVQpFKCeC6kSx?=
 =?us-ascii?Q?hEovG6kxzj2/cLkTNcDc3x1SPeaCRuNw79iR/XHfpSZXQ3Ry9OPhS0PS+upY?=
 =?us-ascii?Q?dCt2vnEqI/z8RgUGeEXmZB0ZvA+F8xHN0aBBtkkV+PcPFHxf1W7bqzYJ/aMc?=
 =?us-ascii?Q?ShNC2nZnbAO82+P2jX0q7BTugCEW+EStz0CbQBB2FlIYjkC/yKi1Nm5NMLIy?=
 =?us-ascii?Q?ixSoiqU/KuCv4y1qZqmdkc7SQUTCcmY/BN1D3hchECMLcwazgbFr3ecEYlol?=
 =?us-ascii?Q?fDQHCNYf3VhqgWgOPCBo7ZRIThVw7G1e1MtXBOMMajMSxFjBKiMU2S5aeOrL?=
 =?us-ascii?Q?8SGWNiUAzlUPkBWNSWcMDzC+6/TGXM7oASpExXhmTSWZ9Qae683SvjduERaN?=
 =?us-ascii?Q?swTE+bJj0a5wKlihA5nOq2gLWaIiWJqhTVx9TzBXJVjeZX619ikj8CL4n+B+?=
 =?us-ascii?Q?1tUlvgLCIeVUMfxK8GQqDIvziwXXRppnUY3Gul3lFGWE7Twg/PeT2LlXpGWU?=
 =?us-ascii?Q?PMIPWdbhcsS/TlhzsPWqDRwuSFcGW+Ity6+VJljfqgtnjsAsmjhez7s5f4JC?=
 =?us-ascii?Q?cw5yabWxDU0sAd7t3bNqTIVnqbT6y+LsOQ1mhBsU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e7eedc9-ba7f-4c7b-4472-08dd94b030bf
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 19:31:01.1974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lokYeLQ30urFO9q9twpcurlxiH9vIljohhWOcpUkSnrad8F7/rOeg8C7+A6BxYSLvyEFkZ0vwhLIlGC9EOejsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7942
X-OriginatorOrg: intel.com

Ackerley Tng wrote:
> Ira Weiny <ira.weiny@intel.com> writes:
> 
> > Ackerley Tng wrote:
> >> Test that GUEST_MEMFD_FLAG_INIT_PRIVATE is only valid when
> >> GUEST_MEMFD_FLAG_SUPPORT_SHARED is set.
> >> 
> >> Change-Id: I506e236a232047cfaee17bcaed02ee14c8d25bbb
> >> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> >> ---
> >>  .../testing/selftests/kvm/guest_memfd_test.c  | 36 ++++++++++++-------
> >>  1 file changed, 24 insertions(+), 12 deletions(-)
> >> 
> >> diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
> >> index 60aaba5808a5..bf2876cbd711 100644
> >> --- a/tools/testing/selftests/kvm/guest_memfd_test.c
> >> +++ b/tools/testing/selftests/kvm/guest_memfd_test.c
> >> @@ -401,13 +401,31 @@ static void test_with_type(unsigned long vm_type, uint64_t guest_memfd_flags,
> >>  	kvm_vm_release(vm);
> >>  }
> >>  
> >> +static void test_vm_with_gmem_flag(struct kvm_vm *vm, uint64_t flag,
> >> +				   bool expect_valid)
> >> +{
> >> +	size_t page_size = getpagesize();
> >> +	int fd;
> >> +
> >> +	fd = __vm_create_guest_memfd(vm, page_size, flag);
> >> +
> >> +	if (expect_valid) {
> >> +		TEST_ASSERT(fd > 0,
> >> +			    "guest_memfd() with flag '0x%lx' should be valid",
> >> +			    flag);
> >> +		close(fd);
> >> +	} else {
> >> +		TEST_ASSERT(fd == -1 && errno == EINVAL,
> >> +			    "guest_memfd() with flag '0x%lx' should fail with EINVAL",
> >> +			    flag);
> >> +	}
> >> +}
> >> +
> >>  static void test_vm_type_gmem_flag_validity(unsigned long vm_type,
> >>  					    uint64_t expected_valid_flags)
> >>  {
> >> -	size_t page_size = getpagesize();
> >>  	struct kvm_vm *vm;
> >>  	uint64_t flag = 0;
> >> -	int fd;
> >>  
> >>  	if (!(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(vm_type)))
> >>  		return;
> >> @@ -415,17 +433,11 @@ static void test_vm_type_gmem_flag_validity(unsigned long vm_type,
> >>  	vm = vm_create_barebones_type(vm_type);
> >>  
> >>  	for (flag = BIT(0); flag; flag <<= 1) {
> >> -		fd = __vm_create_guest_memfd(vm, page_size, flag);
> >> +		test_vm_with_gmem_flag(vm, flag, flag & expected_valid_flags);
> >>  
> >> -		if (flag & expected_valid_flags) {
> >> -			TEST_ASSERT(fd > 0,
> >> -				    "guest_memfd() with flag '0x%lx' should be valid",
> >> -				    flag);
> >> -			close(fd);
> >> -		} else {
> >> -			TEST_ASSERT(fd == -1 && errno == EINVAL,
> >> -				    "guest_memfd() with flag '0x%lx' should fail with EINVAL",
> >> -				    flag);
> >> +		if (flag == GUEST_MEMFD_FLAG_SUPPORT_SHARED) {
> >> +			test_vm_with_gmem_flag(
> >> +				vm, flag | GUEST_MEMFD_FLAG_INIT_PRIVATE, true);
> >
> > I don't understand the point of this check.  In 2/51 we set 
> > GUEST_MEMFD_FLAG_INIT_PRIVATE when GUEST_MEMFD_FLAG_SUPPORT_SHARED is set.
> >
> > When can this check ever fail?
> >
> > Ira
> 
> In 02/51, GUEST_MEMFD_FLAG_INIT_PRIVATE is not set by default,
> GUEST_MEMFD_FLAG_INIT_PRIVATE is set as one of the valid_flags.

Ah My mistake I read that too quickly.

Thanks,
Ira

> 
> The intention is that GUEST_MEMFD_FLAG_INIT_PRIVATE is only valid if
> GUEST_MEMFD_FLAG_SUPPORT_SHARED is requested by userspace.
> 
> In this test, the earlier part before the if block calls
> test_vm_with_gmem_flag() all valid flags, and that already tests
> GUEST_MEMFD_FLAG_SUPPORT_SHARED individually.
> 
> Specifically if GUEST_MEMFD_FLAG_SUPPORT_SHARED is set, this if block
> adds a test for when both GUEST_MEMFD_FLAG_SUPPORT_SHARED and
> GUEST_MEMFD_FLAG_INIT_PRIVATE are set, and sets that expect_valid is
> true.
> 
> This second test doesn't fail, it is meant to check that the kernel
> allows the pair of flags to be set. Hope that makes sense.



