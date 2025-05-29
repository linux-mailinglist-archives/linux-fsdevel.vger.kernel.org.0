Return-Path: <linux-fsdevel+bounces-50022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92875AC7670
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 05:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F1E6176FF7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 03:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7821B223DC4;
	Thu, 29 May 2025 03:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J3hEsJZk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE6A19B3EC;
	Thu, 29 May 2025 03:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748489354; cv=fail; b=t9YLLSBx1HT/YhljhVAV3qpYnn94InuzwyuYC6XwHpAhm2emAZAGyjsX5xnQbAxv/LlIIhwF4DiA05Yyl6A8IwMkLqGmLy6q3EZ4/BT7ezm8pKsIh/OP2c7u7agmLV24u/06vKswaIK7dEocsz18zS3XRdondLjGSpLX3oED52c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748489354; c=relaxed/simple;
	bh=WUlGSD4uDj3D5n6XPTHKwcEDC9hOaGH7sOhqyncDqNE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AbkgAPkNMwRydjULn5PQhbiXrrfqDNLdwjLp7I/2Hwk4vBEXhUDxmX3Itq3VDSrpc4YoqxKqm4KJ9Pm6i86C6/DMvfeBpy8OepW4qHVYOZKwvGUvtuJdiFPsknFGTmvzw0DmoWAJWtfwFuVHyvnRVdv//4EvXKz6GnWx9jeSEHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J3hEsJZk; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748489353; x=1780025353;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=WUlGSD4uDj3D5n6XPTHKwcEDC9hOaGH7sOhqyncDqNE=;
  b=J3hEsJZkvKmeU/ZFoMQXNg96+JLSFeRgGCt7tXlKObhhwRj7NGtr4LqF
   U9uClL4V5WQNOJ94If0FFmcISA2btvZJ0bfOLNR2sx5IK6BQ+k3VyOVKv
   bB3rkygs9ZpbD5f78i0Hd77qyPPZxQk5o4meCoTVAlkCBs1gbucDi62+g
   nOL/Mt8lCR2wvfwqvDl5TDFcanSB0E6oUdmCUZVAg0HY2C+wDJivgo8Bj
   14dbBcVAHMM8z8h5I4rtxF8LilxBz6SGYr4ry8C3NC5OpiOPDAYazZlZd
   OcdGnq9EfQYu98zegPXtGJUvguUa7tqsq7q3jnNbrs2OBaV7am4+uV072
   Q==;
X-CSE-ConnectionGUID: TKefnIV7Tei/TZz9euzUxw==
X-CSE-MsgGUID: p5xJzylKRa2SNziGrxCzqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="50421825"
X-IronPort-AV: E=Sophos;i="6.15,322,1739865600"; 
   d="scan'208";a="50421825"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 20:29:11 -0700
X-CSE-ConnectionGUID: 7izqJ7hKSBidFNN2LPq6ow==
X-CSE-MsgGUID: ps+oXjXgSp+SWsntuWQ/vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,322,1739865600"; 
   d="scan'208";a="143332433"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 20:29:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 20:29:10 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 20:29:10 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.67)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 20:29:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zCHQvEPVjM40g4KCT590o5/fZIcGLT1X28ezQ7UYdonEC5gN+Rh51Fn28h505pCjVUvYPekZL4uW2VhiBE+cIzAdjwECTM2PCORr7UhIRg2MTmmrelo28E/zrJ+hv94+vtEWeazH0eUOTbRJTX7HAHQ4qGAzgDfKufZRQw6dKRJphtexTwE3sx3PeAqzUMkAej7Cqa6uM2g6llq6uKrdHFSK7/qXub93mPvqqykkkOFMzCQ7uP76qbVeLIiW/QnziOCmOqaGrFhH332DjdJUSOVCzOQ42FP+qFeqk+DxifEvgx64LCSrFFpdyxk8gko7xGgVoo3reMIZPf9Z4IdAhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13Ze10yOQQOA6cejzxnZp3AVo0w8y+E4VhhrX7nVr5A=;
 b=OYBI90lZk1mZUFz3rilf/y9Z2WLkagg3cGxFTvkDht7nsjjG53GT8h8RPNTuhnYqUqdOBlhOcV3uhN7i2HhC6XIruwpepr9Qh07FLNjTFCHMt96mhTddsOJdUJEHsg2R/58Spvj2ky3jf1J2lKuIAlagmf66Q9XbBg8yz6vYj52LZ2HpvNP/+tGEiNXQUZIpPiTEP59A9SIkE9KswmKj9R6qRbYCjW4/bQbvpvnVJO/mNYihdye5PsMFrghJacPWqR8hbRnv+fIXMXVAtrnr2+z8Z0sDyUCS41yxzWGYS6gd+6TfuOjiihVMDnHFwdWSYLgV22nRaSlEETgYNsoZrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 DS7PR11MB6200.namprd11.prod.outlook.com (2603:10b6:8:98::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.26; Thu, 29 May 2025 03:29:01 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%2]) with mapi id 15.20.8769.021; Thu, 29 May 2025
 03:29:01 +0000
Date: Thu, 29 May 2025 11:26:23 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Ackerley Tng <ackerleytng@google.com>
CC: <kvm@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <aik@amd.com>, <ajones@ventanamicro.com>,
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
	<yilun.xu@intel.com>, <yuzenghui@huawei.com>, <zhiquan1.li@intel.com>
Subject: Re: [RFC PATCH v2 39/51] KVM: guest_memfd: Merge and truncate on
 fallocate(PUNCH_HOLE)
Message-ID: <aDfT35EsYP/Byf7Z@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <cover.1747264138.git.ackerleytng@google.com>
 <625bd9c98ad4fd49d7df678f0186129226f77d7d.1747264138.git.ackerleytng@google.com>
 <aDbswJwGRe5a4Lzf@yzhao56-desk.sh.intel.com>
 <diqz34co8zaw.fsf@ackerleytng-ctop.c.googlers.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <diqz34co8zaw.fsf@ackerleytng-ctop.c.googlers.com>
X-ClientProxiedBy: KU2P306CA0013.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:14::17) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|DS7PR11MB6200:EE_
X-MS-Office365-Filtering-Correlation-Id: a4d18bca-8f98-49e3-cc67-08dd9e60f464
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5ytspJQCzJ4N1id/MjSm1PI+uYZISiyO4BlG0Sbbp08BDmDaAq+EO/VC/9sh?=
 =?us-ascii?Q?G5QtV0lh1vum3YZbSN+iyZFLuta6URcVty/YtJEl2Tm1BPuAM4p5Jwi7f5i9?=
 =?us-ascii?Q?hAhEMQXzZXj5J9Sq3AbB+WLUjOrjh4aIIlGuo8emc2kw3mtvMitjP9yNU4im?=
 =?us-ascii?Q?uUlVG40Ng/CmcAbViKwsULlW3CPjZJZ1ElXYML3cc53cis8K90cy71/E6Yr2?=
 =?us-ascii?Q?F+1vFhEGlVftBUgLxGFL8tyLVmsj6AUCefyIKFeowgF+TYKPb2PlUzhynVEC?=
 =?us-ascii?Q?+Go5g25Yu4laqWncBLNZcdKir8qdr4FEI01fRv5m+XuvuXUR22j4b9K0j4GN?=
 =?us-ascii?Q?146J5j+ArT63/DaejCpTvcY4F396ncxMgHOQA4GzunxvgCoKJI5Vyt+XRtHa?=
 =?us-ascii?Q?rMEYFDVWpzOJa4DXYfrhkzwFrukZ8+GKsYdM+rIc4Jn/7CWuzizs9na9E7dG?=
 =?us-ascii?Q?vWmn7D6UGlfXhkpbqW8/3ZRKA9AH6kzxF2s/YgjhSVcqGry0nwU0ffrfTI/O?=
 =?us-ascii?Q?b5IMzEtyQgNZ0g4C66R6Rwr/la65b3fn34ZESlr2OEGLRI2/4nW7rRLCXvYL?=
 =?us-ascii?Q?FkX2UJVxxYDgFZnRKrZJyZW69KjsKtVGd0i3pjMGzpgLskUyHEBbwgwVxMQY?=
 =?us-ascii?Q?wOzFc1GhQ4qVPWFOoQxvP1UgnDMPRDxz/nGVQoXQvhN7GCLGczOgnit5dLIF?=
 =?us-ascii?Q?P2uQwsa0k4wZWEDoFlF2LQS50ODu9dOhgyckHk8Dv+8UEVd/0T8R3q2PC3IW?=
 =?us-ascii?Q?s/XOJTZWXSzA437rg3+UQiljDHag/B/O06tlaI87v8P6yHpM6P4rXMRVmpSE?=
 =?us-ascii?Q?01EEALQ+F5YEQpKHjkVJ8xuKUxyeJv32mZHkP4aF5BeuyBDnOt4h31OD2jIl?=
 =?us-ascii?Q?SF5ar5JPbAgaWk6bvnxYOpP49zNiG42yKhQYM2MaS+i/Y3H+z+i5A15hhFHT?=
 =?us-ascii?Q?lwT5yaWtPA29Bb2dYY+A2soOD4pIOj6UFv9MitZb8YRwm+dlfcFwA6ecF31E?=
 =?us-ascii?Q?bq/A4pnP+93VgdT1k1+G1sNtbTJHWQ16CNWAzwXc4Mo+HWJqT91tdKFnweFX?=
 =?us-ascii?Q?H7qcbHw8/6jtrjc2RBhg0hDfw7y8SlBYd0fxC5GihC+obPaYuHE5zKIBgYTv?=
 =?us-ascii?Q?076+GBhCil3hEwsiXeestCthY/UPRoHNbFUkEINM1CmW5Fo4+XQVC7DBKSQV?=
 =?us-ascii?Q?KeKd8v08dI7px6Z4wNJmH8Ankfy4VTxDDU7nnzkxBf/VX4Q0R/d4eLlBv1WB?=
 =?us-ascii?Q?VDsWzxlscsf71HJAAzpllrKURfRa2JLxvhFdLsv1o9bSIQ/iWdokFUHFOVcO?=
 =?us-ascii?Q?tlpOOqZswvGkInOEAibkWsgtAPqBCqUHdcdurMXG8UFLvXEDDHBMAAjOPtHX?=
 =?us-ascii?Q?EhA+BQOKYBMibCIDGKTV7hD0GaHwK6GTVf4pfuuguPaqPcGwuCIjwoEQ5DEb?=
 =?us-ascii?Q?26ulBN0lxDw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rhdhoUxu46gGdog66W+lG91jP5wGq4SRnczroS7+OjI+Tr0EwqE+/oJnOtEP?=
 =?us-ascii?Q?OeIxN5xUqGU7yQg3JcB46GSVrhHOClVtWDHg2PnieKeC/EoRcUQ2SIWq34FK?=
 =?us-ascii?Q?3uOQ4pyQuvGpHNJ/9NmSRQYy73hDUtJbGfRMXCAfPcL2ifjfJP7iF8cYT4bl?=
 =?us-ascii?Q?9Su19rdEpP2iiyouVQ9TMa15OiSIxRS8P+BFSZnHQlbZ1w1Qq40jyo25YhVg?=
 =?us-ascii?Q?wrH/DjHy1DnbJAlfEZTYF9maVgfdcIdHITerSxhR/mZa1+Zsc2lml8+6a7um?=
 =?us-ascii?Q?RnzF0qQpTx32h/cFFKBrs8VyNn4QZgVcEs4JAHbVRzihqkiXVWRAYJhMKP9T?=
 =?us-ascii?Q?PbGXCYbZ8/hwEtJf+A4hQG98fVN8TE6SX3GOQmbNYQKRBVc8vo4yZJ6kcFI4?=
 =?us-ascii?Q?FvSbQgERKMnALPh9dgN3pNXR5mQf/rSsbMMr2S3kVimsA3fovpgqwVCCl7Xx?=
 =?us-ascii?Q?QTpY4vHyPtJVcTaEskShgy5QzzjGcw6huro1KvmbjjL4HHfsavPV3QX7kYKm?=
 =?us-ascii?Q?w5WbmLrtizv4imu6PBEjeBp86mtPkDNOGV66cpjiNeHJFTeWOWcS/szZxDW/?=
 =?us-ascii?Q?H4JG7s/YSlxr4JKv+24deKRMADtGqGRUW4jaevGBc0+7YiUQ5BghEU+Btzft?=
 =?us-ascii?Q?cFyyLQbR1MPV90qxueYvQJPQcAr+OVOxgw0JxVZ9IazObeNZ4UnjrENISzTS?=
 =?us-ascii?Q?g+lYlpps6vS5RIeKzsPJ+6xXyt9/ona4HeFOp9T9EhhA49empqRgCOKamdsp?=
 =?us-ascii?Q?v74NmArfKpEh2dZd4kmq3fu9Y5wJmuybfYd9ujnVrY3/DGAdXw73xALZwU/h?=
 =?us-ascii?Q?0pnmpU6F5/o0Dv8fOPhtbO6Xu0adbfHfMGVhFR57d67FDHegj/Vc63kHDW7N?=
 =?us-ascii?Q?MfgMzCdt49F4ju184ZDAzj5+A2XUE+B5nSVDoUrKMuoW15hUYpPKYpClcob4?=
 =?us-ascii?Q?EmUoDhMZ5EPRE99KFOwJqYlmSpQXNqDCcj5CtsROHcpM0JGPrSwykOtKoLBX?=
 =?us-ascii?Q?T/qEgdepTaubCJZfEun2G4syah940RarI/3kXCeFRxnej8PMIQCAfds2HIL0?=
 =?us-ascii?Q?2bfgU5OJ3Dbt7Ztq1T43RLPTM8mcJU0D/tzdPbotsH5fSjng75t6kEelx+d8?=
 =?us-ascii?Q?gmvHlRnEPfbcxEPoQsbIPT+6PoNjLJD7+thVLl3+H9YnkOgmtyfQ0Hw8BmWk?=
 =?us-ascii?Q?8f17kYtl3T9e+mOw2fmj1Ub5Yef6zucDnt8VDDOcvDlMR+z+XPNjhODcRlo+?=
 =?us-ascii?Q?iOxOaiu3CMXzpdXrCEf33UYWy+dNdjZ7zw1+iTy/YpI2hs84EtVSLSl65Vwo?=
 =?us-ascii?Q?n4auW23IJC35gr7c7XqkyDucMa/ZDjaszV/IhW8QSOpuFna3yZxjhwqbWQyF?=
 =?us-ascii?Q?xfqywPg1pXPSKtDZoPNsa/mwr1KZWmHIgnLOOMTwGkZtb01G0h2nh6iEcGdp?=
 =?us-ascii?Q?vG35QbrsTmUKM0fcnVbjwwn/zyLW4znWgxKwt/bHohruMW7MdAWBt3Z35Q9K?=
 =?us-ascii?Q?WcJe3iujUnwlQKK1XTFdWdtxgQ97dL6KVK7TEd2xv8r4z75rBcC35v5pmLXL?=
 =?us-ascii?Q?LrnhBheg4aIcG5O6DPqi7IUxSderCceUgtY/4imJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d18bca-8f98-49e3-cc67-08dd9e60f464
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 03:29:01.4069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N4Gwg0OpH+0tfT92PunverBcjD13SQGB6sFJdVuT7vp3p4v9g400ESPy9dVO5g7Y23SSUHGZoIv7HDKVPaLyAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6200
X-OriginatorOrg: intel.com

On Wed, May 28, 2025 at 09:39:35AM -0700, Ackerley Tng wrote:
> Yan Zhao <yan.y.zhao@intel.com> writes:
> 
> > On Wed, May 14, 2025 at 04:42:18PM -0700, Ackerley Tng wrote:
> >> Merge and truncate on fallocate(PUNCH_HOLE), but if the file is being
> >> closed, defer merging to folio_put() callback.
> >> 
> >> Change-Id: Iae26987756e70c83f3b121edbc0ed0bc105eec0d
> >> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> >> ---
> >>  virt/kvm/guest_memfd.c | 76 +++++++++++++++++++++++++++++++++++++-----
> >>  1 file changed, 68 insertions(+), 8 deletions(-)
> >> 
> >> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> >> index cb426c1dfef8..04b1513c2998 100644
> >> --- a/virt/kvm/guest_memfd.c
> >> +++ b/virt/kvm/guest_memfd.c
> >> @@ -859,6 +859,35 @@ static int kvm_gmem_restructure_folios_in_range(struct inode *inode,
> >>  	return ret;
> >>  }
> >>  
> >> +static long kvm_gmem_merge_truncate_indices(struct inode *inode, pgoff_t index,
> >> +					   size_t nr_pages)
> >> +{
> >> +	struct folio *f;
> >> +	pgoff_t unused;
> >> +	long num_freed;
> >> +
> >> +	unmap_mapping_pages(inode->i_mapping, index, nr_pages, false);
> >> +
> >> +	if (!kvm_gmem_has_safe_refcount(inode->i_mapping, index, nr_pages, &unused))
> 
> Yan, thank you for your reviews!
> 
> > Why is kvm_gmem_has_safe_refcount() checked here, but not in
> > kvm_gmem_zero_range() within kvm_gmem_truncate_inode_range() in patch 33?
> >
> 
> The contract for guest_memfd with HugeTLB pages is that if holes are
> punched in any ranges less than a full huge page, no pages are removed
> from the filemap. Those ranges are only zeroed.
> 
> In kvm_gmem_zero_range(), we never remove any folios, and so there is no
> need to merge. If there's no need to merge, then we don't need to check
> for a safe refcount, and can just proceed to zero.
However, if there are still extra ref count to a shared page, its content will
be zeroed out.

> 
> kvm_gmem_merge_truncate_indices() is only used during hole punching and
> not when the file is closed. Hole punch vs file closure is checked using
> mapping_exiting(inode->i_mapping).
> 
> During a hole punch, we will only allow truncation if there are no
> unexpected refcounts on any subpages, hence this
> kvm_gmem_has_safe_refcount() check.
Hmm, I couldn't find a similar refcount check in hugetlbfs_punch_hole().
Did I overlook it?

So, why does guest_memfd require this check when punching a hole?

> >> +		return -EAGAIN;
> >> +
> >
> > Rather than merging the folios, could we simply call kvm_gmem_truncate_indices()
> > instead?
> >
> > num_freed = kvm_gmem_truncate_indices(inode->i_mapping, index, nr_pages);
> > return num_freed;
> >
> 
> We could do this too, but then that would be deferring the huge page
> merging to the folio_put() callback and eventually the kernel worker
> thread.
With deferring the huge page merging to folio_put(), a benefit is that
__kvm_gmem_filemap_add_folio() can be saved for the merged folio. This function
is possible to fail and is unnecessary for punch hole as the folio will be
removed immediately from the filemap in truncate_inode_folio().


> My goal here is to try to not to defer merging and freeing as much as
> possible so that most of the page/memory operations are
> synchronous, because synchronous operations are more predictable.
> 
> As an example of improving predictability, in one of the selftests, I do
> a hole punch and then try to allocate again. Because the merging and
> freeing of the HugeTLB page sometimes takes too long, the allocation
> sometimes fails: the guest_memfd's subpool hadn't yet received the freed
> page back. With a synchronous truncation, the truncation may take
> longer, but the selftest predictably passes.
Maybe check if guestmem_hugetlb_handle_folio_put() is invoked in the
interrupt context, and, if not, invoke the guestmem_hugetlb_cleanup_folio()
synchronously?


> >> +	f = filemap_get_folio(inode->i_mapping, index);
> >> +	if (IS_ERR(f))
> >> +		return 0;
> >> +
> >> +	/* Leave just filemap's refcounts on the folio. */
> >> +	folio_put(f);
> >> +
> >> +	WARN_ON(kvm_gmem_merge_folio_in_filemap(inode, f));
> >> +
> >> +	num_freed = folio_nr_pages(f);
> >> +	folio_lock(f);
> >> +	truncate_inode_folio(inode->i_mapping, f);
> >> +	folio_unlock(f);
> >> +
> >> +	return num_freed;
> >> +}
> >> +
> >>  #else
> >>  
> >>  static inline int kvm_gmem_try_split_folio_in_filemap(struct inode *inode,
> >> @@ -874,6 +903,12 @@ static int kvm_gmem_restructure_folios_in_range(struct inode *inode,
> >>  	return 0;
> >>  }
> >>  
> >> +static long kvm_gmem_merge_truncate_indices(struct inode *inode, pgoff_t index,
> >> +					   size_t nr_pages)
> >> +{
> >> +	return 0;
> >> +}
> >> +
> >>  #endif
> >>  
> >>  #else
> >> @@ -1182,8 +1217,10 @@ static long kvm_gmem_truncate_indices(struct address_space *mapping,
> >>   *
> >>   * Removes folios beginning @index for @nr_pages from filemap in @inode, updates
> >>   * inode metadata.
> >> + *
> >> + * Return: 0 on success and negative error otherwise.
> >>   */
> >> -static void kvm_gmem_truncate_inode_aligned_pages(struct inode *inode,
> >> +static long kvm_gmem_truncate_inode_aligned_pages(struct inode *inode,
> >>  						  pgoff_t index,
> >>  						  size_t nr_pages)
> >>  {
> >> @@ -1191,19 +1228,34 @@ static void kvm_gmem_truncate_inode_aligned_pages(struct inode *inode,
> >>  	long num_freed;
> >>  	pgoff_t idx;
> >>  	void *priv;
> >> +	long ret;
> >>  
> >>  	priv = kvm_gmem_allocator_private(inode);
> >>  	nr_per_huge_page = kvm_gmem_allocator_ops(inode)->nr_pages_in_folio(priv);
> >>  
> >> +	ret = 0;
> >>  	num_freed = 0;
> >>  	for (idx = index; idx < index + nr_pages; idx += nr_per_huge_page) {
> >> -		num_freed += kvm_gmem_truncate_indices(
> >> -			inode->i_mapping, idx, nr_per_huge_page);
> >> +		if (mapping_exiting(inode->i_mapping) ||
> >> +		    !kvm_gmem_has_some_shared(inode, idx, nr_per_huge_page)) {
> >> +			num_freed += kvm_gmem_truncate_indices(
> >> +				inode->i_mapping, idx, nr_per_huge_page);
> >> +		} else {
> >> +			ret = kvm_gmem_merge_truncate_indices(inode, idx,
> >> +							      nr_per_huge_page);
> >> +			if (ret < 0)
> >> +				break;
> >> +
> >> +			num_freed += ret;
> >> +			ret = 0;
> >> +		}
> >>  	}
> >>  
> >>  	spin_lock(&inode->i_lock);
> >>  	inode->i_blocks -= (num_freed << PAGE_SHIFT) / 512;
> >>  	spin_unlock(&inode->i_lock);
> >> +
> >> +	return ret;
> >>  }
> >>  
> >>  /**
> >> @@ -1252,8 +1304,10 @@ static void kvm_gmem_zero_range(struct address_space *mapping,
> >>   *
> >>   * Removes full (huge)pages from the filemap and zeroing incomplete
> >>   * (huge)pages. The pages in the range may be split.
> >> + *
> >> + * Return: 0 on success and negative error otherwise.
> >>   */
> >> -static void kvm_gmem_truncate_inode_range(struct inode *inode, loff_t lstart,
> >> +static long kvm_gmem_truncate_inode_range(struct inode *inode, loff_t lstart,
> >>  					  loff_t lend)
> >>  {
> >>  	pgoff_t full_hpage_start;
> >> @@ -1263,6 +1317,7 @@ static void kvm_gmem_truncate_inode_range(struct inode *inode, loff_t lstart,
> >>  	pgoff_t start;
> >>  	pgoff_t end;
> >>  	void *priv;
> >> +	long ret;
> >>  
> >>  	priv = kvm_gmem_allocator_private(inode);
> >>  	nr_per_huge_page = kvm_gmem_allocator_ops(inode)->nr_pages_in_folio(priv);
> >> @@ -1279,10 +1334,11 @@ static void kvm_gmem_truncate_inode_range(struct inode *inode, loff_t lstart,
> >>  		kvm_gmem_zero_range(inode->i_mapping, start, zero_end);
> >>  	}
> >>  
> >> +	ret = 0;
> >>  	if (full_hpage_end > full_hpage_start) {
> >>  		nr_pages = full_hpage_end - full_hpage_start;
> >> -		kvm_gmem_truncate_inode_aligned_pages(inode, full_hpage_start,
> >> -						      nr_pages);
> >> +		ret = kvm_gmem_truncate_inode_aligned_pages(
> >> +			inode, full_hpage_start, nr_pages);
> >>  	}
> >>  
> >>  	if (end > full_hpage_end && end > full_hpage_start) {
> >> @@ -1290,6 +1346,8 @@ static void kvm_gmem_truncate_inode_range(struct inode *inode, loff_t lstart,
> >>  
> >>  		kvm_gmem_zero_range(inode->i_mapping, zero_start, end);
> >>  	}
> >> +
> >> +	return ret;
> >>  }
> >>  
> >>  static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
> >> @@ -1298,6 +1356,7 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
> >>  	pgoff_t start = offset >> PAGE_SHIFT;
> >>  	pgoff_t end = (offset + len) >> PAGE_SHIFT;
> >>  	struct kvm_gmem *gmem;
> >> +	long ret;
> >>  
> >>  	/*
> >>  	 * Bindings must be stable across invalidation to ensure the start+end
> >> @@ -1308,8 +1367,9 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
> >>  	list_for_each_entry(gmem, gmem_list, entry)
> >>  		kvm_gmem_invalidate_begin_and_zap(gmem, start, end);
> >>  
> >> +	ret = 0;
> >>  	if (kvm_gmem_has_custom_allocator(inode)) {
> >> -		kvm_gmem_truncate_inode_range(inode, offset, offset + len);
> >> +		ret = kvm_gmem_truncate_inode_range(inode, offset, offset + len);
> >>  	} else {
> >>  		/* Page size is PAGE_SIZE, so use optimized truncation function. */
> >>  		truncate_inode_pages_range(inode->i_mapping, offset, offset + len - 1);
> >> @@ -1320,7 +1380,7 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
> >>  
> >>  	filemap_invalidate_unlock(inode->i_mapping);
> >>  
> >> -	return 0;
> >> +	return ret;
> >>  }
> >>  
> >>  static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
> >> -- 
> >> 2.49.0.1045.g170613ef41-goog
> >> 
> 

