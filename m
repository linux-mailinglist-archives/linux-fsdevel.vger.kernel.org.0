Return-Path: <linux-fsdevel+bounces-49155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C101AB89D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 16:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3D137ADE0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 14:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43368206F23;
	Thu, 15 May 2025 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mz7ptl3j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E7A1FAC54;
	Thu, 15 May 2025 14:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747320602; cv=fail; b=IGcrq3dxi3qBrvrzsotkQ90DvWiGtVJkLAmwXDHQjfu4OGKF/dckiixb3FFtxeACm2g55e8evpQ7vrK4aSCYYfwta5nnsN7kyxwOnIW2Atb3Msic7slkq7INNFoq/gay27K3EUuWV5ccoYKlG27vsdN/I/gZ5cLtK1tB77gpQdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747320602; c=relaxed/simple;
	bh=UsBLHT6hmOmZyql79FrxttauCj2DYE0rjwn8+01PCZo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U61hKhOhesaFoyVMx8yP8Jjhn7DCbZffJl+rSGpcqHh56lJYRH+s3kGgSMH3Ju1ncsQzd1289U/PJa2hURkrvx+DGrAV6rry2NvkSgVElAku/u8qDz2o5/fA+M5CoOT1EI3m/2n+lrs3XB80mPqcA6Pnjp4vdgUAxNMMB/sDQBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mz7ptl3j; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747320601; x=1778856601;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UsBLHT6hmOmZyql79FrxttauCj2DYE0rjwn8+01PCZo=;
  b=mz7ptl3jAnFjCX9IDGuI9DKasrU01ND42j/e9PPNr62kO0+bnx0ASDwZ
   yeJ5Tm7QfhicVVPgqnDm4+bZ7ggtVU57xl2zhPKw2D0i+oUz3BkZJD8ur
   rBlglR9Q+CcAm824Q4bmZUxqla+/WBsSoNebnpD4Li0yYkvcUYKn4jjhI
   RDiYrpIieCpvZZH7MnUICt6cyJ8UmuS/VPoiQB62OW0JE2emwI4rT/KQq
   Xy0xbrhf+7zb6MT03lyZNGK/xPG5x4MfMBHDwj2rBtZ7OCCJ5py99Swbz
   YAuVzLLld4cGSamDMwahI6UoVVcMzvMhVGoyqVmaEgm26Uls9WDeR0No7
   A==;
X-CSE-ConnectionGUID: W6U9YRKnQOqwj5HKKrQIWQ==
X-CSE-MsgGUID: EOe8T2IlSyCqfkmRIaTyig==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="71773016"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="71773016"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 07:50:00 -0700
X-CSE-ConnectionGUID: +y6Flt65QmeRZeQN7fBqqw==
X-CSE-MsgGUID: jfKfrMa3TiSfWhLNx8jFQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="138119653"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 07:49:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 07:49:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 07:49:58 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 07:49:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TS9a7azZBneZlW6SIeGl7mQAKurBnM1H/AbvOcIp6bmGaYef2+k7DQsXa8RtFwgwNiRdeGPnCcEMbuTn/fCkVuPzoUPnuYZqdz6rRCftUrBPa7b1AVcqtS5csgVM28pPk/EKMYklKyqstSNNG8KVu9O/lrIm6Bsf6G4+edNrIOdLeDKjRrCkRl5jIf58XBF/N+ndURRI3mww0zxYqiy4A4l8dI/vxQ4EgqQ0NT4SXxvd3/3oGChjy9ClNryk7WuQlFOQDlHVZaNd+uW8S+NX6DFvdZC5s56xqEOBj0+gc/0IJTHbHgxC1AOYyrc+xMAuMnLdXLGP3hD6VP/2NKXc6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnhRb+mgWm7K8Z7yR2Pp9WTJzZeiyBtbhvtVf+LYTAs=;
 b=W+THiCZBNQLIBMR1Qoew+Se0sfqOpkIE5Ir6Qv51pgiSagi05A90GbS69bytmyIaOJ66eOZs+142W2Vs6KEes2o/ptvLT64EFFPa3QN3wwrxcsDBWdzOw16oqxybdnxb/Yf765hRMuxZ8hjAiBcI3sd6cvMGjg9zLKkw5LvVY1m3Z5Xjo4DqBMtS95kkY+KKvH/u3QYxgmaNUEagjv/NZI2vL38I+YKLmA1Lc+mCt2wvD8As3gwEe22WxzFT2ASJC/htctum13TZl/vfkNOyxeRhy8ymZ6L2/hL5BpGOJfznch1CNQ4EuImW5qvQ/S0MTLmonNYAWNmyiVYvZNAThA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA1PR11MB6146.namprd11.prod.outlook.com (2603:10b6:208:3ee::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Thu, 15 May
 2025 14:49:53 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 14:49:53 +0000
Date: Thu, 15 May 2025 09:50:26 -0500
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
Subject: Re: [RFC PATCH v2 04/51] KVM: guest_memfd: Introduce
 KVM_GMEM_CONVERT_SHARED/PRIVATE ioctls
Message-ID: <6825ff323cc63_337c39294e3@iweiny-mobl.notmuch>
References: <cover.1747264138.git.ackerleytng@google.com>
 <d3832fd95a03aad562705872cbda5b3d248ca321.1747264138.git.ackerleytng@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d3832fd95a03aad562705872cbda5b3d248ca321.1747264138.git.ackerleytng@google.com>
X-ClientProxiedBy: MW3PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:303:2b::25) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA1PR11MB6146:EE_
X-MS-Office365-Filtering-Correlation-Id: 042f48ff-290a-4286-1316-08dd93bfc03b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vi4bloaL3+wxjkxntI3yPAzkRYHvLnezCmHpJ5nd/l6q+qzkEymQQc+CNBAd?=
 =?us-ascii?Q?biwcOTIJO5/pVZWeTW8FPE++mlTCaMRYj/B73hyWqBs7+oW8xOONO7Qdi3kb?=
 =?us-ascii?Q?iVYPSj3lxxPVqmkKtiNzXM4vkA97QzlgroZvjO6K9jL5AsiGsaSR507s+YT9?=
 =?us-ascii?Q?1UpHhe1ISVdXijBE+Z7SQYLUfaRDWYL+OxmZE4O0/aNYnC37zEzJjjkO7Dcj?=
 =?us-ascii?Q?4qu6YpvDEPLztcd6lXpH11j0ku0+vcj3MrD5juezHkJdUdx+MCN4zNUWYwOJ?=
 =?us-ascii?Q?CUSzEVXVfpifKziCIyQW7pLzvj8sUn6TSW/bLKyI74VBCcdVSihp0S+/mWwH?=
 =?us-ascii?Q?9WAens9TtvtkTbjIF4CBznuhSAL6cyBfeHTFo7zdCWQ1ja4NkmRmfndgUQoY?=
 =?us-ascii?Q?rT4UFWGzfYD/QsCmsfkkcNhp38Rs/nMG4kL+waqNbyYVGbpFDju7rvBEX8Kc?=
 =?us-ascii?Q?VzrKJrRuXbdw054NXjABduQfsaSph8zdQoaxAOLp7+xTMiNkutT6/CN5fNSI?=
 =?us-ascii?Q?NF5ooM9H8KonkRCVOOe8Zw3B08eblh1lDi2WbxHdVs+U+KwH5T+O6nwOgv8f?=
 =?us-ascii?Q?ke6xAFN22MIbX5rVRxy/6r58JYt/6pV5rbevvLxqq30qIsOx4uRKuOyhoOTn?=
 =?us-ascii?Q?DydGNXmAv006h22URwUpJ41ErgiZI4dI8XQuccs/JRNj5V0YpynNRKxjtXzD?=
 =?us-ascii?Q?lt2Qc8WplMh8op+GHc5EtV26jF6Iydv9T0XCZOKpyxHklqO9vPehpwwb5vMg?=
 =?us-ascii?Q?QExTCd20+y5ZJsh6frDm8b+HYpd9V2HkkApwhhDXAVxBUI5MxbamxQKXdE0G?=
 =?us-ascii?Q?6aOJ9BmWCehxerfiDcPYZRCXY37qhg24NJDHU5iBpBqBhBr/Pa6eq6gZL7Lj?=
 =?us-ascii?Q?wtxxo7QvxY2OOasGEj6622ImQZRbZqlgXirpnYb+w65ol3gyAdB+AqxSMAlV?=
 =?us-ascii?Q?Ts9geK3IODaiTzR9NHSImt6ZbfjcJNXGLOseKeDGw90dH5on4zAo/QDHyLEz?=
 =?us-ascii?Q?gurls1reoFrlCdHAyAS/m1E8my9owPUMlEU00+WqLmx4FeghMgbXJzZ+6sKZ?=
 =?us-ascii?Q?21LB3qTqDCDvc4D/XOf1yYkcaTCrWEZouxw31hgAy8HU6wNXHNStA0tBIPny?=
 =?us-ascii?Q?xi42g+8Vdaa9sRZKjwFmsV2mVCKi9zX63Xp/3TXdJ7yh4y1hqO9pMZ6DRSqb?=
 =?us-ascii?Q?xnry6Cxm1UuaoHnWGXmgg4aEOWaj/M/9HQJ34ultVUP//XPfagWZKKdhESxm?=
 =?us-ascii?Q?bEpTgbiIMAt6Tg+AoRiPJj4Jnl+6zwLyWgIleLDc54OGDnw+E7HTwokyjl8m?=
 =?us-ascii?Q?ChyOAFHvN6OgaiMv9vaLmO2BEWEL3x6o6E5OFZ0U8YYOheE1XzmnMwK10EbV?=
 =?us-ascii?Q?yZIZatHU8F3CFOownyn/8FOiMsi5rG+JsCRTo/TCE4NmrNxfykduB35KW8EI?=
 =?us-ascii?Q?CoORUK9wy5E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RaMC3/Y9/NJuvqD6JbrmFfpFkAVcIkNDgTzhMpTJTujdI2Z0tBJdSYSDEej8?=
 =?us-ascii?Q?bUBgiCHIgyn7jcrEjmmtPNtKdIDgL5wHCcuphwi5SKYEVCqUKRlqrmKQk7J9?=
 =?us-ascii?Q?g+MIqJrKgcRFS78fyWGHBvJdX65iidmuWm2XMjIPZ7RdQY9eE7MuQiSR4K4h?=
 =?us-ascii?Q?PwMQ6TEQx/sZmat4bxTq/apalhNN3jdhMwE08wBn1Za2DpetBf9Q+8zxfDR+?=
 =?us-ascii?Q?mGrpGzQgBFF8RiFHcCC5QWprsEYvDVLnwY3P1fEArIK0rlUGsGkjd0V1Ch4V?=
 =?us-ascii?Q?cyEX+E64rRMRNaYKRq+nh4N8UJbBSoi4tBMX2EwqiN19OW6EBrL96I+bCfRz?=
 =?us-ascii?Q?23x4QqY1gpcPrZJRveF0hd+WxA0bsJCaqqD2euvTE/tY3Nmo1EOVpefKxuJg?=
 =?us-ascii?Q?iq/dUzuZutBLRmlO5sREDRDqrVZqps3sM+RCl4XbMz5H6gktlAtBcBmnUVVW?=
 =?us-ascii?Q?ROF8zjxsLBHFLmyS4jlnoNMqbNWvAAyTGb4Fz6OnFt3PE8UuNeN7LPjkM5YA?=
 =?us-ascii?Q?wpHd41SaVYL66zK2gOcUw5n6em3Y1MNPieyLrgDqQNOcPnPIRWyaZTCZe8de?=
 =?us-ascii?Q?zJHVEkktv0lsrbfPX/X/it+1eiL5iWZ0BNf9tvKK200yISWac0qtVFSZMXfb?=
 =?us-ascii?Q?VMRFLJuBtbW68Rd9Uxq542FoxU8Mbe8paUzHSP5O5pMTHLDw9+FVUWo0YQi6?=
 =?us-ascii?Q?EuLj23Urb91mranRgtdPucB7TFol/e6hexylqoqc0Hr1Pojq+gkiTiEMiRZM?=
 =?us-ascii?Q?gkX7r3fw+KGXTqLlUE0MBRwiz20NbaDe9r1MI1Zqi83E2sp++2Kn86QvLTdd?=
 =?us-ascii?Q?5UAM8jSB2ol5uo3G4kWcdYyjk7OwRkE0tUpMlKjkgPlz/ehKYwRTfs+sz52e?=
 =?us-ascii?Q?TAQXDe/GvNuyEPSA/eVuCD0mtj+dGd7F7sP2d/rooA9wg+rqyMJnBZNFDMbg?=
 =?us-ascii?Q?NnmL1uZiLc/dM0ILFp/PDPm+0djBYoHddOlHOWdz6lsHhWEsAeCXtyqGm9oa?=
 =?us-ascii?Q?NZqUiSivGEGZOSKnxuaqPVG1BjsJgv2MBEauYOeL0Iun0PKaGDTT3wzGYjL5?=
 =?us-ascii?Q?mUHzv+pInVagSij2UjzViX1vBLIYTieZUa5/m1eS0YY+eYhYpxLvwXt1U7eL?=
 =?us-ascii?Q?N/Bd9Tfzkm3Wh7y1kdMRm3zPkEWApC603UGpPbbCcrUNCAqR9u5mnrJVO/Y8?=
 =?us-ascii?Q?XzYj6nu7I+jyUXAEvLj/46G5GN2LOXYMAe8haAlXGOfJoglZOzF2CdVvUDnC?=
 =?us-ascii?Q?3dU2vcsFRo0/Of1D5fBwr9YHYt0sOVkV3X/WiEBjWodWy2BRzJz/XBCwSiPQ?=
 =?us-ascii?Q?WZpwATiPXPP/HRh6GXePmy9uae76LUS4u8Yg+76kjs0rA8jrRuf0e81ye6Kr?=
 =?us-ascii?Q?B1InqLWXmdst7TbDec/943Xu3vPk1VATpnUjrJkrk8cJd9ANvt6IqtK62KHl?=
 =?us-ascii?Q?ldEcVzDeul5OecCJo8nBPSLC+WnjSrdYWNIQkeuu9vXWXNECaRmpA9GLny3r?=
 =?us-ascii?Q?p52NmyUITZCX36WW+HHFWrR3pxPRQuVGUFXmr5lCory2xdCGCQjvJlfHu4Zj?=
 =?us-ascii?Q?tkY9lPfdeJWHofY5E068gTNg28Y4NRVSsrU9QpRB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 042f48ff-290a-4286-1316-08dd93bfc03b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 14:49:53.1862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qaXVDZJOFsVZNkzuavzulcZSGEPSsllDCLwnp4Yyt4EpwTsT8MN4BaaUv9KmmI3t4Q1RJfE0K/PcYpM3GrQRHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6146
X-OriginatorOrg: intel.com

Ackerley Tng wrote:

[snip]

> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> 

[snip]

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 590932499eba..f802116290ce 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -30,6 +30,10 @@ enum shareability {
>  };
>  
>  static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index);
> +static void kvm_gmem_invalidate_begin(struct kvm_gmem *gmem, pgoff_t start,
> +				      pgoff_t end);
> +static void kvm_gmem_invalidate_end(struct kvm_gmem *gmem, pgoff_t start,
> +				    pgoff_t end);
>  
>  static struct kvm_gmem_inode_private *kvm_gmem_private(struct inode *inode)
>  {
> @@ -85,6 +89,306 @@ static struct folio *kvm_gmem_get_shared_folio(struct inode *inode, pgoff_t inde
>  	return kvm_gmem_get_folio(inode, index);
>  }
>  
> +/**
> + * kvm_gmem_shareability_store() - Sets shareability to @value for range.
> + *
> + * @mt: the shareability maple tree.
> + * @index: the range begins at this index in the inode.
> + * @nr_pages: number of PAGE_SIZE pages in this range.
> + * @value: the shareability value to set for this range.
> + *
> + * Unlike mtree_store_range(), this function also merges adjacent ranges that
> + * have the same values as an optimization.

Is this an optimization or something which will be required to convert
from shared back to private and back to a huge page mapping?

If this is purely an optimization it might be best to leave it out for now
to get functionality first.

I have more to review but wanted to ask this.

Ira

[snip]

