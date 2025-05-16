Return-Path: <linux-fsdevel+bounces-49302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA5EABA46E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 21:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27D32A22824
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 19:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0F027F73E;
	Fri, 16 May 2025 19:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HvV2M2SR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABCD1A2643;
	Fri, 16 May 2025 19:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747425533; cv=fail; b=CaUx9jPvVUg5GZ+10U953dIYzpJW2sNCn3bTbDOrFo1CFohT8+F1EmctcysGitb72bslGjtyW0dgVPnTupBxjr2Vqu9IVV00+jS0gdmSKkOnIYA/haVjqXK7YqkAQd1nTb48pI7GGcha/Xd3NsTSenhNmY5H7kFgqtrxxm7QxRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747425533; c=relaxed/simple;
	bh=Po2rWb61GeTftKyCsnHv/ezbvyoiQjkVBfe8Y8k5B6Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oN7erVJT4HUuDY1gqItoX5KvlGl4EfEa0PUirKWHjj4FkOmPq8ALvLg618mWLn6Lyd3iw7YIlwJR+K4zIsZNjVEGyfjAVl9oPOFmRFCt9+34jK+elzImF+L9E9/JYTiyhet+Q4FszV48crT161BWj2BwGeUrbYobKuYgNedruW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HvV2M2SR; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747425532; x=1778961532;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Po2rWb61GeTftKyCsnHv/ezbvyoiQjkVBfe8Y8k5B6Q=;
  b=HvV2M2SRKhAhuLIB3tPYF1DmvWhD8P4vtWeH0dU0nEtCG9inrP1uApzq
   m4RYz6wzlOtWsXHiGsaALqZigfheFFVXDTYz5B7bAAhoOosFQNUNrafwO
   8A9W5J+hyR5DM+a9QbTlENa3nwXUMzND53dPj6UvKNEIJUxcl0HSpczIu
   JCruJv09ss4+tuA5C34RhY1QtYvWxdUIg+EKtaS4lZXEyVWhdwud8+WUF
   BGlVELOTzuRvPmZhy93iSU45Xuk+ckYuCY1TfvHyGr5mHd4wl/GlR1rIR
   g1/Y2AgbFyLBpjLac2fSa/R32L8SOqFNEFhN3uTHW6kxl99CfpTijis3H
   g==;
X-CSE-ConnectionGUID: OAL+O1hnT7Kxr5KDJi7HAQ==
X-CSE-MsgGUID: gOE6/33LTe2LvqXf1oL/Xg==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="53226868"
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="53226868"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 12:58:51 -0700
X-CSE-ConnectionGUID: gcRP901pSBmatcbxsEVmcg==
X-CSE-MsgGUID: cIyIhlx1SYq20Bgskl7Z4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="143757368"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 12:58:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 16 May 2025 12:58:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 16 May 2025 12:58:49 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 16 May 2025 12:58:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bBl19/oDwZgYGeWXDFIjTjFgR8PiIZTtXZyz/qblZ5xuURVcFUkWK4+H1ncYPCmc7Vkjh5MxvuqzqyZEm0u9Sisf+IHejrfvDB/jKD/cCBvWPF0gVVMw0nMKsmMDMhLatmqCTRaL6+fDUGk5eB9OxhFL45GqsEFP5WO7VENkPJkH0KRUgCQJLYWHU///vOIUg5SzX6W623Ha8ZQCFt6lRjojSaib39MzuS5CtLhVIVk2AvrSjOJ0RT3pK1KO5B7Qdsd73lzi+KEAJB4BkEc2+s4nrHzIo8PvoZSuQ78AN5U9IWzWN8X53kQjF/0Bux+0h9+zIc30xd6BclMEotSL9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TV6/IRAIOkQ9P5+UYT970fK4JwgvAkLaajpgF86MpI=;
 b=he85J3O+jSI0zP/elds0OaVvKSIUYlpt07txuWD7calPb56uRByZ3eKIEdGy/vqj4tT8RWjxDEcM9LG77MVuQkMDfALSZ61qao1LqfULcDOVE7iaSdOzFHZhqDgS7EtxMCI7gv6kXBAl//KNTEvsh1cs3Kv9Wk+ohIBJsFgrhIWOgwBRFe55UKIkJDRCKDqAGPraSLcum92qdRgxspPkETcDyMeE9hcOYQsfkKUogyw2rzv5JGjwTadg/KMxmpe2xJsSWTH8K6XU7ZN7jIJyLOu42bLGA/QaeQyfLpaT6wdy0a193qQt8P+3ntIpB446ydEFzbRUft/ukR62UvUDrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH3PR11MB7370.namprd11.prod.outlook.com (2603:10b6:610:14e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Fri, 16 May
 2025 19:58:45 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 19:58:45 +0000
Date: Fri, 16 May 2025 14:59:19 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Ackerley Tng <ackerleytng@google.com>,
	<kvm@vger.kernel.org>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <linux-fsdevel@vger.kernel.org>, <afranji@google.com>
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
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
Message-ID: <682799177f074_345d2c29482@iweiny-mobl.notmuch>
References: <cover.1747264138.git.ackerleytng@google.com>
 <6827969540b5d_345b8829485@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6827969540b5d_345b8829485@iweiny-mobl.notmuch>
X-ClientProxiedBy: MW4PR04CA0036.namprd04.prod.outlook.com
 (2603:10b6:303:6a::11) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH3PR11MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c6f3bf4-5634-43b1-7048-08dd94b4106d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uxVnPrXKFatIUX59pBqyr3gpG6JcUHvw+a3EyyX3YblIXPsm65KRkH/8PyQJ?=
 =?us-ascii?Q?qbdku5+ytGPMqJBMxxMjrlCVrLi2HmRUd3IBolY9hbiJL0UBYEWZk34+yaiM?=
 =?us-ascii?Q?zy+Gcc0aBudnauzocSyQiSUS9w2snEgfqVqlkua5enJLjTh7icEYAzVpgYDe?=
 =?us-ascii?Q?Vo2bvUOFxCT6j+aysYVJh21aClr1ROXCYvrAZ4TfGdb4KDSGQAVTcFWAD55n?=
 =?us-ascii?Q?HEECq7VbyzVm78svjNexcrXr10SA5DKOS5Rd837LLsipzvmwLdn9bxoP7kID?=
 =?us-ascii?Q?/g9Bsv3PBYtsZFNLVEjKRs8mmdFlLnfJ02/OouWpsFckgRsu2nx065edq1GN?=
 =?us-ascii?Q?+VPvomsou9CfB+2fnpwUinYC8XhNeDvUSPp0Ope54hB1Xn3g5k5UgF+sMPbV?=
 =?us-ascii?Q?KPmlJNpBQhOXjUdJj5PzK7T5bQZiWaoPCv1TKK9236G3xWa5NLY2ix3CqgR8?=
 =?us-ascii?Q?N1fNezYXSdRMxJE/vkoU8dEeKlzP1Xc7MGVwEG1d9si3qVc3x0jtZtdT9rOJ?=
 =?us-ascii?Q?byeALB92UmoDZrRtzPuZzgiGDn+cm4TIiz5ZflUvZ+sAXzF0xNA65/iP5G5y?=
 =?us-ascii?Q?gqql930sPT0UFfXVjIOwg3sw+rRllHvNqJJKpHs3la3WGM6soj+xhJoIMaKw?=
 =?us-ascii?Q?CXgZ8JkDQXn6KaoxYlxkA4bZrNFl7OYY+z1XtL86dpB2JfyS2I3UsLi6OheY?=
 =?us-ascii?Q?IdTmDNzrs5b+CebU7+8tde83O6ERAgeOEL2PA9Bx6Qg7+/Ut+9fMWzH88jSa?=
 =?us-ascii?Q?poERoUkdmppf14KTaCEjkfi25pFsjwBKRbchNPtqXKhWrtWmtO5toVRbLS/v?=
 =?us-ascii?Q?VhN/sRhMnS+U4nvo557mYuFiyMrOzrpEJPAB5MUXOZCtf80Td/a12wiJDBzZ?=
 =?us-ascii?Q?1EqOWXciDsypWmcZsQCry9BKLeivBU9VG/X8iTb+EM1HtGfqasfyhC8aA46U?=
 =?us-ascii?Q?e+ULdFXsgfKtbpGpPIbcBNYZlrHDaje5pb1x57PIJJA7KiyY7S/TsV2OUHp0?=
 =?us-ascii?Q?XsFjLnoNbl0/9DSxI9gOeqr3L/TaISio8j8XmRunB5bF05mb1EAlQ1ZyRZ2h?=
 =?us-ascii?Q?7eK+oSwsnxkXw/1dXhmBRV2UcFy9YrfbUJ39QwIxms96CWGDhY6eGtVjmCMO?=
 =?us-ascii?Q?uDFotb5wcbqLVaFGNfqVU1bJg/zapi4vXDg8mI9HJyuFBsJlQB+eOKOkFTou?=
 =?us-ascii?Q?21SHxbVaD/IxGNMGDeD1+mgOjciPif453+HUbLxhVi7avzo7EEOYAm16s3Nl?=
 =?us-ascii?Q?A0cSH1nF8sN9MIKKOqXh1mXGP3+X+7TOnpUQpu2p829gYxGLa+zLSHxtb4BI?=
 =?us-ascii?Q?pyKVC0/YWeBjFpcUaNYUFUXID/y/Aqpw0Ru81HGJsA2HngJJguMmXi5qrlll?=
 =?us-ascii?Q?JVIwVUz+VSnUI8E/2en5iVcbszJ6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pf9PurpbN3AcqTQFLmHwj9UmQIBTkGJlUmT0VaHM5f0OC2IAqHN/WDGggvFP?=
 =?us-ascii?Q?HrqWvDCVsXsKdTZbvrn7vj/LifrXpu06XlVycQ8wmZIZXJI4Iib2S1vfS55Y?=
 =?us-ascii?Q?DJ5SkW1mRVTrkJuEkHV4T5Q/BeRbdAMD2SZUFVvyE6NOVPQTx3+vITowCEVB?=
 =?us-ascii?Q?bhIyDNzJj3HDXj13RtcRTJXVRvjYCFnmK6Rw9uHFthBahLUuEsdk76jb1m1k?=
 =?us-ascii?Q?jhBAYLTD8CesJq/IqycuwC8MZVW+rtVfnj4ip94OaRjb1vmLq4SMIS1ObLRo?=
 =?us-ascii?Q?viYEJSQENfI0TEjTcZveq1Jmhaq6NBcqNRoCGGCOkIPgM4bJwHHuQgwbiBqw?=
 =?us-ascii?Q?uOLgDzXs+JNQ6LHJBim8IvgwUzlQDxqHdf4PY1LPqWgWaT2hLxJAJ6DxVbnQ?=
 =?us-ascii?Q?yZdzh+nGutR9AY/8mhpBQNgZaZYzcvfU2aYNSnRD4N6tVRzXRbqPQaWfIru3?=
 =?us-ascii?Q?2cxnW9iKvrjiumEdrViVbeErNjP/VMVE6Ew76/EXisXJ9hLmGBxFENnLuvjW?=
 =?us-ascii?Q?MNd2sbz9+mUzicMoaHaKxMoMlNUG4flXJ0ASoZqB8omLl8HDbsQM+A2fYjl/?=
 =?us-ascii?Q?VUE3ngEyNjYlhKdy6dq+63F04YOIADnOEyyOnObK8H71tqYQOR8W9qEA7lW1?=
 =?us-ascii?Q?bXN0OuvEegeVb6lj3ZGkYNAlaU4Bx+NvPDPxcZdFoKkCdhIsMlArCSFGR4Uq?=
 =?us-ascii?Q?tgQOjMYwy9wI9OmkiyeYM0hdJfOneB7Qe4KN+1kBfHzpenUf9+lPg1V5+/28?=
 =?us-ascii?Q?NA2YRvoE8rwq9l30C+eauXiDUITt87X3mfAO0AAnVmTwiUM4U6dkOGn291rX?=
 =?us-ascii?Q?8UsEBgKy2MWf9IV4eN6raf4XLQEofDesX+WI0Q3AsvNYHkFxla2dSrNpxmNG?=
 =?us-ascii?Q?e6mwYwd7axG0sbnO0z1e3EOI3OvTCpB7SFaXfvx2GEJB02Kj6i1nRn39iw4n?=
 =?us-ascii?Q?ASE/5TKQn/J5DRF1samXsiqcl4KIHp/WAyxhJAVDQHm9QtvTU+NtwbWIWcGQ?=
 =?us-ascii?Q?bg2bfpwCF2+KF4KobnUl8ypZYI9oDMV6GZtUMqpLuEfdiQmsBha7ZdyxBopd?=
 =?us-ascii?Q?Ya8DPZ/uxpnp0kJeDrPVqbRzTVGrg3scpkztLJC53GXP2pN/fbA5mXq4xD69?=
 =?us-ascii?Q?xB9Stej5MD1s5VUeNulYlYvfWmqFjAY1+SzUZd2DMj5AABr6ip3vM5hVPpZH?=
 =?us-ascii?Q?Lm6mMyT3pjb+uGajluNnSfuX1RwdUq3mvMXVl8d4rLhpht+c5sb4AtLcvRZ1?=
 =?us-ascii?Q?j/6LJ7x/jHc8T4Geaq3W3BlcvnaEHXgO8HtqKJljQuXzXiOUy2wVTYg+SHLx?=
 =?us-ascii?Q?X/8WtmA6kveUXtRFpjMda+F8VZ6X1g8sxybrNpcUqbjCpgkxRvcbUMUj4lly?=
 =?us-ascii?Q?P00huxogFU6qA+mc5S+Mp+gO5xo/2eMDyQbSSxbWLF+CYS9RlX+UQznvvts1?=
 =?us-ascii?Q?4g+L0yNTs81iWhYm1rQAjdvbGQHwSUI55lBh5F33zrvTNi1lWBXyilFaTBuq?=
 =?us-ascii?Q?TZPpAOetTtkm8pHOIfnwzxWIyDlCaC12AlxXk+FWNNxmcKibzzQuP+slrQ0z?=
 =?us-ascii?Q?/p1wRJEqDtvKkj7AC7yzz17xjncBGdNQuWfIUf1r?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c6f3bf4-5634-43b1-7048-08dd94b4106d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 19:58:45.1105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YrlkvVFZ8bMkYU7RGjMjm/cg3cYJS1qcltSd8OZK33iq/dbmPC0Rb+K3cVsa1Tn69tsvFtBPnv2+lAYbrkfnog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7370
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> Ackerley Tng wrote:
> > Hello,
> > 
> > This patchset builds upon discussion at LPC 2024 and many guest_memfd
> > upstream calls to provide 1G page support for guest_memfd by taking
> > pages from HugeTLB.
> > 
> > This patchset is based on Linux v6.15-rc6, and requires the mmap support
> > for guest_memfd patchset (Thanks Fuad!) [1].
> 
> Trying to manage dependencies I find that Ryan's just released series[1]
> is required to build this set.
> 
> [1] https://lore.kernel.org/all/cover.1747368092.git.afranji@google.com/
> 
> Specifically this patch:
> 	https://lore.kernel.org/all/1f42c32fc18d973b8ec97c8be8b7cd921912d42a.1747368092.git.afranji@google.com/
> 
> 	defines
> 
> 	alloc_anon_secure_inode()

Perhaps Ryan's set is not required?  Just that patch?

It looks like Ryan's 2/13 is the same as your 1/51 patch?

https://lore.kernel.org/all/754b4898c3362050071f6dd09deb24f3c92a41c3.1747368092.git.afranji@google.com/

I'll pull 1/13 and see where I get.

Ira

> 
> Am I wrong in that?
> 
> > 
> > For ease of testing, this series is also available, stitched together,
> > at https://github.com/googleprodkernel/linux-cc/tree/gmem-1g-page-support-rfc-v2
> > 
> 
> I went digging in your git tree and then found Ryan's set.  So thanks for
> the git tree.  :-D
> 
> However, it seems this add another dependency which should be managed in
> David's email of dependencies?
> 
> Ira
> 

