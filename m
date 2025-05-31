Return-Path: <linux-fsdevel+bounces-50262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65692AC9D5E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Jun 2025 01:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4868418996E0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 May 2025 23:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C06C1F4CB6;
	Sat, 31 May 2025 23:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JjaFeU/i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0694514831E;
	Sat, 31 May 2025 23:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748735113; cv=fail; b=SV95GgyV3HwFUqRF3dt4wFJ7tVlhiaWvW1dF3jhjuqyUenLR7PjtO1nZlbt/AUkLlCwEsb85WIE6wACfwZNsP7B4QNJIrySEvmDHHMIPbereHRM69jewYTjHhKwy8QHvFvgVtbaME35qP02+Vs+6Kiy1OVHdUbmRT5VmMXikvN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748735113; c=relaxed/simple;
	bh=tq7OPFEd457FQ6GzmbkLZisNt2V7xB9oIBDCOtcKA8Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BlYfT6mtqx/qgUxZ7pf9VQnU6pzYJaR723mbvbeeI9cK+Nlbrte6E+pMRv/Mba53R6A60NprPHNW2rMXPwofrlijxWCyqoF55Ae5qvqjmCNbUNRexnyD3xmXmjxBKg0HQgBwn0YHD90Hi/dpmZc+qYLdezKgGWqXG7Ivrn7ddRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JjaFeU/i; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748735112; x=1780271112;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tq7OPFEd457FQ6GzmbkLZisNt2V7xB9oIBDCOtcKA8Q=;
  b=JjaFeU/iAgAndbJCWIn4/n2C+sp1QXpaSfZ+8ZfU/UCqT6Bhy20KMLUa
   4iVyPigSF3T+ddwKjl4CGJ8xRZO87J+pEORNkSt6hBOoi7spH+8bpgKm0
   5gKV08gRYuN9ihLvUPd/BQNdXty3GL2x0SKWIU4lbCC/XUfNi55IA4Cjo
   pUVddNC4b0iY4cUBj2paogniqUQT0zlkwz6S5b+XMrFdi+dwabltQKzxn
   us4pB/EFJ01aAIAz4QsjpbAfSdibejQ5hGHp+2X1gClO5jdQEbZVY6egF
   Dn3qhtZZ+t5P09ccs9YRJyWNbZL0JhgRXV9SziBIaVbFA8u6xCC++ubVe
   A==;
X-CSE-ConnectionGUID: QEtGqluyS8eWDUGygBlU+Q==
X-CSE-MsgGUID: VWfPY1krS+azQcSE0T2w9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11450"; a="54456189"
X-IronPort-AV: E=Sophos;i="6.16,199,1744095600"; 
   d="scan'208";a="54456189"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2025 16:45:11 -0700
X-CSE-ConnectionGUID: ztTP1XElR0yQfhkFJQG/2A==
X-CSE-MsgGUID: 7D7R5Zy1S4OaKtSqqUY1NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,199,1744095600"; 
   d="scan'208";a="167388454"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2025 16:45:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sat, 31 May 2025 16:45:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sat, 31 May 2025 16:45:08 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.86) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Sat, 31 May 2025 16:45:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s5TqZuJNdJNIaUHgt+k7/UrGPab1XVXjJ3Hatv2yNW4tlm/R2PthgClPhFiZMx1RRJukBzbZEIXiRhh+90wqs9dTLkFwruzNbiCELx3ZcpkFwNO3HQPICymS3RTrp5vKmwLF8NhdrEPe3EwNHG6otaXMSQaWbJnKUz5pdOGVJlD5imBH1CW5u9q0xLh3xSNH5ATgLgEt26u3oIlrqu+9ElNz7nzPFlz0iw/iwWShS3/G0xwdSRYDWVyqcGnPhql4WWwF9Y5bNJ3QrNCPe17rjNf+7bFvdP2v6tkuGXigExNriRVkpHf5ZA4RxWK6LOIVQDQgsN1qS6slbVh+kltgtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tC86QTZDXAMQoa9ZFP2UL1nRVrYivZshlv1IM+fn68E=;
 b=c2v2RY+ii6l1XEN5e2aKDB+RAP/YiwrmfEXV2X1z5d0MSKew5IDjeNM6AufHY5hymsxHBrHiheCMVf4bJYhaC4CL1o8FDF8+oS2cd7hKLBMLXI6a/reFK2lv+sQY2f7JhXBN8r9KQpaaClRWxo7fZo685Ij1we77YHGVSRXm6FYIuZWxhn6mrFr+Hoq4XgMIk0NmOU0cVAG8A1gAq9qmLQLQxn7Z6xVdvjwNCIAkOW+m/BFXJeR2zDdBXkWXpbESd03S3hh3bLw4aOSLzgJ/j5yrKl9iPsOZrkXhqvRwgaPeOGe3NF1F8Bx9p31xdQrSiIXsLM3vlS2ho218SiHPoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by CH0PR11MB8165.namprd11.prod.outlook.com
 (2603:10b6:610:18e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Sat, 31 May
 2025 23:45:06 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::d013:465c:f0c4:602]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::d013:465c:f0c4:602%5]) with mapi id 15.20.8769.022; Sat, 31 May 2025
 23:45:05 +0000
Date: Sat, 31 May 2025 18:45:55 -0500
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
Subject: Re: [RFC PATCH v2 22/51] mm: hugetlb: Refactor hugetlb allocation
 functions
Message-ID: <683b94b359be_1303152941e@iweiny-mobl.notmuch>
References: <cover.1747264138.git.ackerleytng@google.com>
 <1f64e3c7f04fc725f4da4d57de1ea040b7a56952.1747264138.git.ackerleytng@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1f64e3c7f04fc725f4da4d57de1ea040b7a56952.1747264138.git.ackerleytng@google.com>
X-ClientProxiedBy: MW4PR03CA0222.namprd03.prod.outlook.com
 (2603:10b6:303:b9::17) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|CH0PR11MB8165:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ebefa72-cc41-4518-8f40-08dda09d2b3d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aFO+4wu9qGMXfcsSt3syY1pbTmPaB78C5iPvbdhqDDi/S9cXnAvtnWgXeSL/?=
 =?us-ascii?Q?7b5d+zWDCa0a4YSa75/B7epHxwLwYYTK2excuMAnx8+gxV9J5d6tGtrBfAk0?=
 =?us-ascii?Q?JyCqQn0600bpEidiRwfDV+r0w1Tis/Kg7yaBHibzkEV2K2Z+guVPrdp5+imf?=
 =?us-ascii?Q?tP2pDLkI6T1hwHGnQVCDV1gxwPZT+lv6bBRgMuDzQBCY7cKgFy5KRBAkKXR3?=
 =?us-ascii?Q?CrpVHIPDMETntRFYZ6rzbKRmUgMl5xEJHIuJbRyJN6sefUYKd8esW6gq3Yfv?=
 =?us-ascii?Q?nbiB4CyUIop+DLKHqIRMX9uKmoGswmelz4bLmqMIlcHDiMFsTjacocVHSYn0?=
 =?us-ascii?Q?cuaL2oOJCW0+ibQJZiT/PybGdzwsUGjkQSzag5rbWPVvPqBaUYLwcR0cQIA6?=
 =?us-ascii?Q?fyF5eJQK8VUzNXeITSt7RULVyUDpyZ30Wl3hKO8EiqP1ieOACbY1t4HsPtSs?=
 =?us-ascii?Q?Nq9WcZuteYBsypM3YdKgkKHYqea2RI+xGf53DsGHYpfyxaO5E5w8C4hWH2/V?=
 =?us-ascii?Q?JSA41lrunnvPqatXouQfylR4uuiPdaeQYolAXM9ZZ731BmrpQazQykHrVdrK?=
 =?us-ascii?Q?AOLhpHlcbtJeHWFrJoQDpoOWi7uHicm4b45M1kAA+QPvk6hDwkJCyRHn+gwK?=
 =?us-ascii?Q?1s+2VN6jYw/P39Y0kY88I2SX4qn6qoZ/7NKEzqFNK3EZwr+bycXgpLR42HYC?=
 =?us-ascii?Q?MANExqAt2sT3iiNcAmxwTIXehygtdh5nMK+wVT3sYxk9SMH0Ql6HBtKaFrtC?=
 =?us-ascii?Q?VY8UjhYiUVdt6zj9eBAEMsVAT7UNpEL+57dsgkDLFspWTIlBUUEaniJDUPRI?=
 =?us-ascii?Q?/5SiRoDpu+yrnJpGGtoDjSySfHgkoUrDKRnh3kbM7VKQeSK/fyobad6WUAQp?=
 =?us-ascii?Q?eAlowKCnawt1tyh9Lt6Xq1jI2N6wap1abIiUmE024X8ZH4HwNrKDitMI1B2y?=
 =?us-ascii?Q?AmZUzt7TTQi66CZU66XYsGF/DxgBNmHrj7NbJtMvP3zsfiLx0F4+4oPaue9q?=
 =?us-ascii?Q?W5eDd9WxvhwqJo0c9EZkft6dstiKtGsv8acb0dksFSf0SQtcP3JrBrPI9zGM?=
 =?us-ascii?Q?UTMVn9tmVb7xSbGQXiWWzGAaXEYl9RSDx441S7CbI4h+a+khZvbrzVwjbVFP?=
 =?us-ascii?Q?8l1iZx6KlM5MkLvLFwx40z6oVQ1GLMVBOr37ECE80cdfU6CwetD6IPjLx5sT?=
 =?us-ascii?Q?GgSD64A/F9UY3HEJhDfnNTHCck00fty6SUaTfuh0p7r+SykUlj1/is2Ei5fF?=
 =?us-ascii?Q?NT+OljzXUQU7o4wn+3NCkRYT4AboJDFwj0USi6e+xV/nk6z+E0ibP5xg6mMs?=
 =?us-ascii?Q?o0qxt6+FoS2AxLw/W+Mc4fO7HqvHlHr2ByinOs1XF6ksnlADv+kD1D2C0u0E?=
 =?us-ascii?Q?wwG9LnpKdRkDVc+IET4WLX2Ss2vhCfAXEerPF6pJQbpnYcefNnNszNLQl8g6?=
 =?us-ascii?Q?+TPWJKSaGLU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rOH+Cr2kHurmT0xM+kRr78kEGCEXP9VMKcCBsIGxnUpHGBsjmhD8gr1ZIN0t?=
 =?us-ascii?Q?xx7eTlTH3M1Qv1U+9my/xoQe3jRYIAjOxe9wDaG1IOOWpSoUFRTEENgJTkNX?=
 =?us-ascii?Q?QR4PBMLGBLthw5XvfUya20uNQrLf8cpjhkjTleRwjo1nKK6NUmxaKxOt2UMG?=
 =?us-ascii?Q?eGGE6gM7n7vtcLkzkoPAOJLxjSHbmD702saXCWCZllJyaPkUupPr92Jq7P0O?=
 =?us-ascii?Q?BcfOU8ZVLzXCG7OoUVchkzfxGCSW+MEFfRHtRKKutmhN3oH4Ft5+mgNhMzGF?=
 =?us-ascii?Q?GZdeolI57OmOEaU0Zf/Cc1T82aN78UU/FRilItrW5uYkT4nsNwadSTk0ZYYr?=
 =?us-ascii?Q?DP1MQ/iXF8izZzEOmnbCh4HRkySXeZgiv6wY5dIFnSgmyRCNscEUmO9NRW5t?=
 =?us-ascii?Q?el0eIIoznZy1pTV/yH+o+RIQopuVdF3AwMl4Mjn42JzGzy0p1VCo5jN4NEGU?=
 =?us-ascii?Q?IR1Y4UbLA6XfB3zV+F/1uJQsZSSiDRTVK6zlnWwR9/8ErDlEiz3wpB+U0exs?=
 =?us-ascii?Q?LjYghVOYV6sNp6sN/PXdnzUmG6j34lDWJns5dlWlAqztAxBU3dEnOwiNGkRg?=
 =?us-ascii?Q?A9jp7FN6HCfd94W5KqMzxa5aZrer8lfZ1SVEFAoSebc3kwOrNcGYPo3Tx4dA?=
 =?us-ascii?Q?9Lac4geYGOI3cuKmx5tChJaZbWLUC8j9qwDCQeqr89XRCws0OrPffMMPBnJJ?=
 =?us-ascii?Q?DwObZCW20j8CJz/yBAxGSpSJLHhPOrTb1Kdv4hyhrQm4gC0ysSPJDjPHb5OB?=
 =?us-ascii?Q?bhqqBj+ToEf0fFqFoacoJkwubqegfiRGzSZjHUzLm7+6fq+D5WVvKB7yYyF3?=
 =?us-ascii?Q?qTRHf5m0ziGMm7HHerxTXD0RnLqme9VqZNi8C5I5Ykyhb96qeZu+SycQiPKa?=
 =?us-ascii?Q?imvWQT/m2LoVBySE2Dsk0ZrgPmqg9T9V04/XybjM8jMepImwPD1OKM0IP1JP?=
 =?us-ascii?Q?gtRwJBlz63vOw3cF5Q2xlOMr1/F8U0jhGdgRDJ6fXI9wxGnAPiSGuveR62O9?=
 =?us-ascii?Q?+8pwevtHj+4aiiQ1kH2HHEWa2SttSOtQUh6qb6+4Qo9tQ6TMlOMANrkhlBZQ?=
 =?us-ascii?Q?sWdn9aMrJi4KCAV6Sv8+3Sx06QGfH98SI4cAadD3sv1LWwuiZ99Eb5a0nYTz?=
 =?us-ascii?Q?ZT6qPhbd2tvjibVWeOz/OA9PX4JnfFZx1ROt0AVQ7F+nzX0i2b+3Q5RZX/0F?=
 =?us-ascii?Q?UNsEqug+kr05deXbTKKY1wMf/XvqnO5f/6R7UUv0Pi6aYOuEainlX8i6Fs35?=
 =?us-ascii?Q?e9fYAXk0seeL+qmvEJbmJ01498d6h7ZvefpEKYBv/r5SeKRiRZwloVGMlrFj?=
 =?us-ascii?Q?NJQr5apUhpGWWW1SjQN66UfY9akm3yfKQO1R5mwqBfZ4atkwHyt7k8BURDQF?=
 =?us-ascii?Q?GbiuoI7rlENs0R40m5ySiknAW8PiI37dYFWxmvRLWyzCYzjOmFfYBVmi7924?=
 =?us-ascii?Q?pC42+Efm5yarjNIHl+3SdELYKTGzr1ucYBBV+mDeDd+cnHIwSqQGz+l6nefy?=
 =?us-ascii?Q?Tcuxp0IrHfceC+p0kLN/Lpzs3EWRt5mE3fjmgwm0ObZfGqSPBbmQiFFEaMM7?=
 =?us-ascii?Q?k5kff6LlVXsgMJVgsg0A02M5vJZLzBT3dsI6rrO6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ebefa72-cc41-4518-8f40-08dda09d2b3d
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2025 23:45:05.6572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H/k8/XoeyWxhF8XBXQu3rdWNArrq6gd7wPNmJj90rg5N7swB+q/CGWYXpAhHd154pexMittw/fBq8m2igIWioA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8165
X-OriginatorOrg: intel.com

Ackerley Tng wrote:
> Refactor dequeue_hugetlb_folio() and alloc_surplus_hugetlb_folio() to
> take mpol, nid and nodemask. This decouples allocation of a folio from
> a vma.
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Change-Id: I890fb46fe8c6349383d8cf89befc68a4994eb416
> ---
>  mm/hugetlb.c | 64 ++++++++++++++++++++++++----------------------------
>  1 file changed, 30 insertions(+), 34 deletions(-)
> 

[snip]

>  
> @@ -2993,6 +2974,11 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>  	int ret, idx;
>  	struct hugetlb_cgroup *h_cg = NULL;
>  	gfp_t gfp = htlb_alloc_mask(h) | __GFP_RETRY_MAYFAIL;
> +	struct mempolicy *mpol;
> +	nodemask_t *nodemask;
> +	gfp_t gfp_mask;
> +	pgoff_t ilx;
> +	int nid;
>  
>  	idx = hstate_index(h);
>  
> @@ -3032,7 +3018,6 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>  
>  		subpool_reservation_exists = npages_req == 0;
>  	}
> -
>  	reservation_exists = vma_reservation_exists || subpool_reservation_exists;
>  
>  	/*
> @@ -3048,21 +3033,30 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>  			goto out_subpool_put;
>  	}
>  
> +	mpol = get_vma_policy(vma, addr, h->order, &ilx);

Why does the memory policy need to be acquired here instead of after the
cgroup charge?  AFAICT this is not needed and would at least eliminate 1
of the error conditions puts.

> +
>  	ret = hugetlb_cgroup_charge_cgroup(idx, pages_per_huge_page(h), &h_cg);
> -	if (ret)
> +	if (ret) {
> +		mpol_cond_put(mpol);
                ^^^^
		here

All that said I think the use of some new cleanup macros could really help
a lot of this code.

What do folks in this area of the kernel think of those?

Ira

[snip]

