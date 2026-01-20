Return-Path: <linux-fsdevel+bounces-74562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A43D3BD77
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 03:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E27D4302EB19
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 02:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A40727144B;
	Tue, 20 Jan 2026 02:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M+90CQuq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874B71A238F;
	Tue, 20 Jan 2026 02:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768875513; cv=fail; b=L5QoA3LqvSjD0DCwgC2plYvjww4SXs5C6Ttjjq530QXtNKaimWdt56Yx6d3AbwMuYK/4q/4gDnkWCR+ue6Be/zE2DssTmsf2gpqoOSJ2JbdQD/Q4FGifB5S6vHjPqgDKM8YUtsDtqaLCeDDywSai/e+m//KL1atjB9pg4shYmjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768875513; c=relaxed/simple;
	bh=njQPirqL+3QGNr8SW6NPdLwwkCytTnlDPgXyN7AJS0Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VqJtLmiwUspQYUZL3ET+kmsFs16cpk2b4eQtTpSH4goDxkPG5Mk1myXWPHJsriO80YbVITd+pyOvgvY5h3XPt7RqygklfJlNuDyGbgaMZqax34sOm/k102qOB3Powy0mqW8kvAK04BSPjt5U5rDmAqi7ofzX+ulIfe0wqd9b3hQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M+90CQuq; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768875511; x=1800411511;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=njQPirqL+3QGNr8SW6NPdLwwkCytTnlDPgXyN7AJS0Q=;
  b=M+90CQuqDAGvYR3QLD/YmcUwkxMR1T7ENEyKtq0lraMr1J2nqKnC4RSO
   id7b9eh4MWGxYlKDAm5pIA7b5NFh1aDW2pIH4pAmz647Ut46xRrZ5zZN1
   m2RuGTssI2Urh2UO2hcGMYIF6qUGOCNXU41MO+JFIA+yZU9Lc+4QOlsEf
   Eyw9QQKj/v+v5iaIWPxsF87CJnkWJ8GxrChgfYzduHGDxS3HNbUuReUF2
   IZ8lBYw631ELFcSWewY1oUZ4jivUplKynl4Wbf05U1elJ5JtLk23z4xBY
   WXpY2dV/PTD5A+99CR6K+rAbg0dEB8gC32ZkDhj5yRvWuahs6ao8PMMxb
   A==;
X-CSE-ConnectionGUID: aPgD0Pf0RHKYq72fVq3RJg==
X-CSE-MsgGUID: 0vccItOlSd+9TfOOsA5TrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="69978080"
X-IronPort-AV: E=Sophos;i="6.21,239,1763452800"; 
   d="scan'208";a="69978080"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 18:18:30 -0800
X-CSE-ConnectionGUID: kxlxRTlRRcmfVcUBlFzfPQ==
X-CSE-MsgGUID: ctA0BwwJR52d3HrzN31+kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,239,1763452800"; 
   d="scan'208";a="210498005"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 18:18:28 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 19 Jan 2026 18:18:26 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 19 Jan 2026 18:18:26 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.40)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 19 Jan 2026 18:18:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VjihrXlGUMGxanuIETwaiFUjD3agXFcM61R+gFAFPMc/MsVn+VoAsNDIB/n+5qcjBSGFaN8LK3WNbJgl78V3wGPvGVboWD302hU/wYTUbzcX1PpFyih6QVpAaXT1+7y8rhVFuOGAtNrZUqKOqO+v+r0/xWjR74yAi+iVw/X9s5AJtomcArhVmNWy66/WGcI7FncRQDI/ucIhc+8h6Rp4pPy0y9hl47Y+By8Fg3YKt/qHEtrJHLY555GCzce14FYIfBUCiGUMWJ/ueNRU0lUJz2jL+jUIgHrE/PIqJpCi4JHc0+IE9kkru3uzPVMNkMMCKRjgXpWViBCiL5DwvavVhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HQwzvk+locx2JKHmamaHHFD0TD7Ylh1InoifcU6fdw=;
 b=WUxwrUPnKdjRdAANV34bgjkORjf8PVhhYcis18UtHDittL/mEUXttDhBI9OmwvB/HAdAUe/kFWfdzZkuoflBc8yoGCKCFYsPV9dTzYN7cjxEjCrAxqcrMerQIdGcCXmhoj0MFmFrLE7P0N6XujG11b6UqGMcKiKkQju+IGpS771lLZQqBQj8AdDd3/EJcjXGsAE8jQWxPbH8sVkwrW2eDMSJMbVgD5LS8PMRpAyHdwvlYQ+gq+pJgyGBybwFCmAd8/N3XwDdgGM2g3eCxQpuzfkWsag4BVAEvTWtHxxeBBP9+XJ4lfjPCJImDaZ+CJfJveFoL92yBuKMEWZn5dSPTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 DS4PPF6915D992B.namprd11.prod.outlook.com (2603:10b6:f:fc02::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 02:18:23 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::413f:aab:68fa:b1b2]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::413f:aab:68fa:b1b2%4]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 02:18:23 +0000
Date: Tue, 20 Jan 2026 10:15:19 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Ackerley Tng <ackerleytng@google.com>
CC: <cgroups@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-trace-kernel@vger.kernel.org>, <x86@kernel.org>,
	<akpm@linux-foundation.org>, <binbin.wu@linux.intel.com>, <bp@alien8.de>,
	<brauner@kernel.org>, <chao.p.peng@intel.com>, <chenhuacai@kernel.org>,
	<corbet@lwn.net>, <dave.hansen@intel.com>, <dave.hansen@linux.intel.com>,
	<david@redhat.com>, <dmatlack@google.com>, <erdemaktas@google.com>,
	<fan.du@intel.com>, <fvdl@google.com>, <haibo1.xu@intel.com>,
	<hannes@cmpxchg.org>, <hch@infradead.org>, <hpa@zytor.com>,
	<hughd@google.com>, <ira.weiny@intel.com>, <isaku.yamahata@intel.com>,
	<jack@suse.cz>, <james.morse@arm.com>, <jarkko@kernel.org>, <jgg@ziepe.ca>,
	<jgowans@amazon.com>, <jhubbard@nvidia.com>, <jroedel@suse.de>,
	<jthoughton@google.com>, <jun.miao@intel.com>, <kai.huang@intel.com>,
	<keirf@google.com>, <kent.overstreet@linux.dev>, <liam.merwick@oracle.com>,
	<maciej.wieczor-retman@intel.com>, <mail@maciej.szmigiero.name>,
	<maobibo@loongson.cn>, <mathieu.desnoyers@efficios.com>, <maz@kernel.org>,
	<mhiramat@kernel.org>, <mhocko@kernel.org>, <mic@digikod.net>,
	<michael.roth@amd.com>, <mingo@redhat.com>, <mlevitsk@redhat.com>,
	<mpe@ellerman.id.au>, <muchun.song@linux.dev>, <nikunj@amd.com>,
	<nsaenz@amazon.es>, <oliver.upton@linux.dev>, <palmer@dabbelt.com>,
	<pankaj.gupta@amd.com>, <paul.walmsley@sifive.com>, <pbonzini@redhat.com>,
	<peterx@redhat.com>, <pgonda@google.com>, <prsampat@amd.com>,
	<pvorel@suse.cz>, <qperret@google.com>, <richard.weiyang@gmail.com>,
	<rick.p.edgecombe@intel.com>, <rientjes@google.com>, <rostedt@goodmis.org>,
	<roypat@amazon.co.uk>, <rppt@kernel.org>, <seanjc@google.com>,
	<shakeel.butt@linux.dev>, <shuah@kernel.org>, <steven.price@arm.com>,
	<steven.sistare@oracle.com>, <suzuki.poulose@arm.com>, <tabba@google.com>,
	<tglx@linutronix.de>, <thomas.lendacky@amd.com>, <vannapurve@google.com>,
	<vbabka@suse.cz>, <viro@zeniv.linux.org.uk>, <vkuznets@redhat.com>,
	<wei.w.wang@intel.com>, <will@kernel.org>, <willy@infradead.org>,
	<wyihan@google.com>, <xiaoyao.li@intel.com>, <yilun.xu@intel.com>,
	<yuzenghui@huawei.com>, <zhiquan1.li@intel.com>
Subject: Re: [RFC PATCH v1 09/37] KVM: guest_memfd: Skip LRU for guest_memfd
 folios
Message-ID: <aW7lNx8u9f95YbON@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <cover.1760731772.git.ackerleytng@google.com>
 <02aad35b728f4918e62dc6eb1d1d5546487b099e.1760731772.git.ackerleytng@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <02aad35b728f4918e62dc6eb1d1d5546487b099e.1760731772.git.ackerleytng@google.com>
X-ClientProxiedBy: SI1PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::13) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|DS4PPF6915D992B:EE_
X-MS-Office365-Filtering-Correlation-Id: 92f02b85-515d-482a-0424-08de57ca3001
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?i7gdcSefouBuAbqWT29OixQpIE66AZgfMM5zVH1Djgg1AKkqkltV24zo1rw7?=
 =?us-ascii?Q?/FyKjx+0h6bTCbIUjXYmk4y1gWR+IRhawSE0S0HsvBBgt6vUvBwoBtaasnmr?=
 =?us-ascii?Q?tnZXPwQAhkLtulWTp8CAlI1WC/JtDdobz/e40KFHHFGVLq59w+91Kcff18Jw?=
 =?us-ascii?Q?rZSWMIqpu96LvdkAK1LkuT65pQc38z0AuJ66BfK35/5h54AWkmgDlGtgl8KV?=
 =?us-ascii?Q?SUXgKPxc+C0k+MZ5RwyGBmyQ2Y6utEssbIsLH/boHTslzMKMiL94UKmWix2f?=
 =?us-ascii?Q?A4Ln0s8OswqIhvhbK0pu4fNtTkHpSzZhBVPPCxd/44jorwiBqXXr6IPAcIqW?=
 =?us-ascii?Q?PPMNPn59yco7ki5h8fKE23MixfobOtFQj30SjmERqU/i6oya8aDecvi8C+XS?=
 =?us-ascii?Q?Vwaehyj5QK5EVgfx0j10+4gjnR1EjH20OPlqQ3E7R72FGmM8saZ4hlysh8D6?=
 =?us-ascii?Q?YDBnlmHKUu4gVmKxxRroJpyz6fEav103lTCOPSPpu2gMDX1N/Vk5MCNpjFW/?=
 =?us-ascii?Q?m9ftT0A/juriGoaJeS4zjHh1/HXh4wVQt5DH1YD6djWBVsqcrjuN6mcZXOdK?=
 =?us-ascii?Q?FCESsMkWzWUHfxKxpB2/MHlr9KanwAAMD8AqQ/x0Z5bMpbhPB1y8M+ZiWGYn?=
 =?us-ascii?Q?7ox9gc0zma/WPn76D1crAIotVv2elsGnnbEkvMKX41eGOlGYnUBHF3/KY5tM?=
 =?us-ascii?Q?3hGNdYiqgJhqjhinDKpUMFsve0HSZm1Gra0y509oiE4B/gUUnfWEd1bvIyx3?=
 =?us-ascii?Q?Kxz6fZh0TrpQFBibj0gBkWOJ/5ExVbgEsb0X5ZYKCmE+yWtgOPHpKmMUSfDP?=
 =?us-ascii?Q?WfC5G8kmHFLNHMqZNiEf2Bvj22iXsKxkPf2kZdKNQdJglJfIlE46Q+ZnOfsW?=
 =?us-ascii?Q?yKM0yMdWAqbV+ldJWgyjzZz6HNdGys+SE79mip4RAMEv8QeV8WV4csqEczQV?=
 =?us-ascii?Q?gzFT02IEfAkGFgX3QMBhYnadyIBwAjiJ3IVSA6rJsnqEwM8OYjGnDsTUbMr8?=
 =?us-ascii?Q?EQbPAd/Gzu+AE6mgvZ71o3gS2KzkEK/V+Rso7/BD6vF8Xh3pLpF2BYCGc+O6?=
 =?us-ascii?Q?kywZBEoytUZx3m22mt5klKW1QytTdLFuPuDHa8XB6bZcche6M41bb+Xf7L6N?=
 =?us-ascii?Q?e9aS+5o52lbLyMnf/1j6Ir9gJ1ce5z7EeIYGCEojfj1W84bchqkY3/xfXhW4?=
 =?us-ascii?Q?Ae6t2tzmWtsMm2xPpg/hVPbzGuXqnScNvRmia99jiDS3WA6CAHSZMB+VU7vp?=
 =?us-ascii?Q?a57eLgYRgSU9BwaEZYEpsuCCwaZxZsEXx0HvR1s7nhfrl9CP913osHaZfJzs?=
 =?us-ascii?Q?82OHrL/nfD+LoZTDxrw6RdDnVeLQX8nD0+y9MTD0W01ZI5JYFWNapvkWzNNW?=
 =?us-ascii?Q?FDz8xQbp+aRNtQD+XlxKSZATf3qmHHL98HHf4fQ4bYBR9kjU/AwyLRWHKeIn?=
 =?us-ascii?Q?GADPmgstoAeG5GVxP/vZVRbJkMF5XVn7JikrCM0uOp+OJNQPvJbZpLgV5hay?=
 =?us-ascii?Q?uPj0oxuacLMOiak5UfIk9qdxiRllPMRg0q/cj9ih7YSc5W7k9A1lDQKrpuWj?=
 =?us-ascii?Q?wGvlpCzHr5yNhz34lqQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jSlgfLowiC7/QAqJEVk/vdal6diiwzH9lDXNzBHsqSlEnPLNlwKoHYSYT2kL?=
 =?us-ascii?Q?FZWoXqj7oSwDXtJX9m/ts0NKRlgVmDLJnjBntyUYeXoKxSSRdfiM6cCLtop/?=
 =?us-ascii?Q?MhfrrtquTJmCZ+5EyS7QMKqE2hjayvKSZ6FGVYUIspkHFAhpthYW93rey31z?=
 =?us-ascii?Q?SrZARvAN7Nv6bIfXIFIIH4R5uNq5S3QgqJWyWrthhbhwXF23i5raRoV9x5O1?=
 =?us-ascii?Q?JAQ76knxlkK0bMSIEMJjggUXXufy7a63wu14ZDXXF47A87sWZ91/XBUQqQ84?=
 =?us-ascii?Q?eLLH7G58Y5YuWwcRhVrt/I1ogSAKjjt1KdFG0tFDkdc6/+AoQlWF5J2nKMta?=
 =?us-ascii?Q?Kh3C063Wy+ajbBFPgWhNm8Za4aXK+NGo1jSchBn2R3U40Ef6NQJWmliMDWfV?=
 =?us-ascii?Q?fjlCwifgFp/8sLzOAQ6oDTWkTXZICwUwdy4M4KNnjBPandnTzsnUqzo5d7nT?=
 =?us-ascii?Q?vuQSp8kRyT1tPXODjhSiYQ+IthqRinG6/fPEQnLhbz92KPKmJ5SGLl9wOW6d?=
 =?us-ascii?Q?NcBCS0zak0+Ax6zW/nmxzYT3EcMcsFl7qoKH/1/BxIpV6yOkGPlSro6osnvG?=
 =?us-ascii?Q?zm/QnOwV2XlRDFT/6IMS/GPRZWtiAUgRhUJQ9YnsqIfoNANyvP+10oBDnK1p?=
 =?us-ascii?Q?7ZaBRgmlkLEDR9DSmsQC4J+85BKsHC1LuqLulgeytAX7gA3yQRIdjoyj1gjs?=
 =?us-ascii?Q?kS6IPAmsm7GBi2kD1wWSXkcOP+pv+z0fKi7sOrvgPBBlmrgdfWtePDLRrWHV?=
 =?us-ascii?Q?b1OI7r1hBiIe4732r7kdV0bu6gM6kaoivzb4KkffwQLeiuw6UhkAjv5zJ4MS?=
 =?us-ascii?Q?WbT+1zWFox0Z7p8aiJvoL2f6K66oKX1W9tY4viJOg1CC6pC66z1OdrP7fc+8?=
 =?us-ascii?Q?cQ7REvbXcDrEej7/3/b4wxAkUg21ZBHiUny76So5SSrLRHbJh7BJjU0YbsSP?=
 =?us-ascii?Q?ej3szkMWjauwwbpXIt64kfdFL6Ako59ec0zUXlMcR65nYp+nINFooKSVQCWM?=
 =?us-ascii?Q?9+A/Bblcw5Owi2IPFQdBvv1PY32DDwW6d+s6JFv07+FQxrySzHR0E+EfFPrJ?=
 =?us-ascii?Q?RJ11pQOX6l/6A5zWKwq+bYcNZYfsS6FsRC1adGNP7O3eK0oeiqpKBBqjdr+7?=
 =?us-ascii?Q?YMMLgIZHKHHjiKbvTxTVWlpLALASKS+vBY0s9r+qS/jXMIqsn02OQw/K3jSO?=
 =?us-ascii?Q?5p3YYoaTa5HiTteWgb+AWvYx34kh8k2LpnJoi4K6+vesKgw2CBG06Y56fjvi?=
 =?us-ascii?Q?MVA/iEVQSlvyGa0dF8u9bp3My+MEV5NUuSAytMUBaCHeFy0CNVnA79T4OA4V?=
 =?us-ascii?Q?yq1DGi08bZpHXWEe/hl3/xza4bji0i1T3Y5Obm+xjlmhnlZBM+DJ2nRtbTDQ?=
 =?us-ascii?Q?z4yhvX6RRBHWgs69k7E0lVD7jXNrrqAzBQue4RXErp3QNDtVIbRzdczeyVm8?=
 =?us-ascii?Q?rtbClizz4k2KQlrnL+KsHBjBxe1ZWXGVJkPci0wm4wBtczdktym/8TVyNvLv?=
 =?us-ascii?Q?xhACZjXFsFNsqdYMJ72khUf1WE+0jnnZX8zFWo8o1u2RhMwd8SZA3SONgnKH?=
 =?us-ascii?Q?AhXudoIT+6M/vpw56JIdR2PtJclUKB9ikqQGkAg5H2bGtpCh3BFSL8eHs8ja?=
 =?us-ascii?Q?TkqUzRx6cUwNhpcpZejY9+9yRUAxdjfGvue3jFuYM5dotqvh5GCLKNVNFW5V?=
 =?us-ascii?Q?bToMwA0dREktFIoD1KRGtBrweR8PXwa8xoGUTqqGV6XS+qHRjVj7BXxWH48K?=
 =?us-ascii?Q?pIn/aN7klw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f02b85-515d-482a-0424-08de57ca3001
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 02:18:23.5607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0zrTPk8WhTkEIO6frjfgw/TVpIF3WyUqtRXp7F3U+/TaAZeMb85t5LbXmpXS61XG925ZcRTfKznWwqngoz3BBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF6915D992B
X-OriginatorOrg: intel.com

> +static struct folio *__kvm_gmem_get_folio(struct address_space *mapping,
> +					  pgoff_t index,
> +					  struct mempolicy *policy)
> +{
> +	const gfp_t gfp = mapping_gfp_mask(mapping);
> +	struct folio *folio;
> +	int err;
> +
> +	folio = filemap_lock_folio(mapping, index);
> +	if (!IS_ERR(folio))
> +		return folio;
> +
> +	folio = filemap_alloc_folio(gfp, 0, policy);
> +	if (!folio)
> +		return ERR_PTR(-ENOMEM);
> +
> +	err = mem_cgroup_charge(folio, NULL, gfp);
> +	if (err)
> +		goto err_put;
> +
> +	__folio_set_locked(folio);
> +
> +	err = __filemap_add_folio(mapping, folio, index, gfp, NULL);
> +	if (err) {
		 mem_cgroup_uncharge(folio);

> +		__folio_clear_locked(folio);
> +		goto err_put;
> +	}
> +
> +	return folio;
> +
> +err_put:
> +	folio_put(folio);
> +	return ERR_PTR(err);
> +}
> +
>  /*
>   * Returns a locked folio on success.  The caller is responsible for
>   * setting the up-to-date flag before the memory is mapped into the guest.
> @@ -160,6 +195,7 @@ static struct mempolicy *kvm_gmem_get_folio_policy(struct gmem_inode *gi,
>  static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
>  {
>  	/* TODO: Support huge pages. */
> +	struct address_space *mapping = inode->i_mapping;
>  	struct mempolicy *policy;
>  	struct folio *folio;
>  
> @@ -167,16 +203,17 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
>  	 * Fast-path: See if folio is already present in mapping to avoid
>  	 * policy_lookup.
>  	 */
> -	folio = filemap_lock_folio(inode->i_mapping, index);
> +	folio = filemap_lock_folio(mapping, index);
>  	if (!IS_ERR(folio))
>  		return folio;
>  
>  	policy = kvm_gmem_get_folio_policy(GMEM_I(inode), index);
> -	folio = __filemap_get_folio_mpol(inode->i_mapping, index,
> -					 FGP_LOCK | FGP_CREAT,
> -					 mapping_gfp_mask(inode->i_mapping), policy);
> -	mpol_cond_put(policy);
>  
> +	do {
> +		folio = __kvm_gmem_get_folio(mapping, index, policy);
> +	} while (IS_ERR(folio) && PTR_ERR(folio) == -EEXIST);
Why not just return ERR_PTR(-EEXIST) up to kvm_gmem_get_pfn() and have a higher
level retry?

> +	mpol_cond_put(policy);
>  	return folio;
>  }
 

