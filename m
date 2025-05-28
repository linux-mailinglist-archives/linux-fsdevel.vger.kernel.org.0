Return-Path: <linux-fsdevel+bounces-49973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AED7AC6803
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 13:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF28DA220D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 11:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B24C27D776;
	Wed, 28 May 2025 11:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H7SbS2xP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1654E279333;
	Wed, 28 May 2025 11:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748430209; cv=fail; b=MRJNePkL/gNMAy5hRFeqpusCR0IbnzpRGc8JMzPLtJ2Ghw460F7pEmhYkzAN+QJQxhw9Oi7Zo9TZ7iAEQS3ozSTbH/kwKGatsdF0LI6uc+tdfZ7fImUtYKXSgBJGi7T1+nIg9bDNUYVXAgdtoN+WI3Ztmtr9CK2EagFZazCfOh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748430209; c=relaxed/simple;
	bh=WZR7tQB1LJhu+9v91I9pG3/hzweDs1StmtZ78yVTjUg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p4IlWZBpI4YFGHAjwRUOg6xLDO2A1uohkx3tLEg4f79eBBcajtxhi7N3j18M74hK/CkyefvxDnSB2bOZ0zd28AI3uq8wnp1qV3jpi54cZgVSF3DMqwHV+5j6NHbq9dslbvRaEcwAlzqLLKX/NODIyYx9TghU3pfxjr6VXfjRC9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H7SbS2xP; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748430207; x=1779966207;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=WZR7tQB1LJhu+9v91I9pG3/hzweDs1StmtZ78yVTjUg=;
  b=H7SbS2xPRBt9HPF9idjyURqNERfEdZ8vAY0kku+7uXAlBdg3FuEJBNxO
   ajYZIQW+c0lu+2bR3QTkmEnLRSHyINII1mR40VBV0CWonS7ryfFd9l2Cz
   Y8rqx747wQfcEZ6VlKqbF+VHXiPmh3cLU3hHkmMxYSokGG9eV3c5/S+fZ
   EWrg6o6w7EjUtBwvptb5rfkCybfQrrT2x1jLfQTrEk+HSBYDh9lJ6b/4n
   iwEFiKp3QRx8GcPFTg4+K6GJfFwmexim05MSPm79zparCDcbPDmb2CEme
   QzxkUeGGe+Njni4ida9I6/LvsGhbbMXKf7xHL0idEOy4/nbVud0T1kaDh
   A==;
X-CSE-ConnectionGUID: SQucqdNlTQWczRHVxmsbXw==
X-CSE-MsgGUID: 2AetXi5YT5GvKqJm6NUASw==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="61799438"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="61799438"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 04:03:21 -0700
X-CSE-ConnectionGUID: QKHVld68T8mlxmv0Ig/K4Q==
X-CSE-MsgGUID: T/mZ1PGzRBiv8IYA6XWpXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="147093876"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 04:03:18 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 04:03:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 04:03:17 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.74)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 04:03:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSYYbcAlptDE6DqIARhFDifGX6QKW4hzXPdONNXJQPt+WXH98WYxk7ncWlQhwDbULSBGUt8cHOohCqUt3ECxqrNnX8KQh+XBHXoRy6QNBcV4F8vyG5xyIVmWd/4yjBF1+dKCI3uLqkSEqSsVczOm0vYFh2p2rpOACu8hvxmUERsJdRa5h4WPdpY67OmbyOgJiuT4QTksGzDxdXE8lVi+/WADn7kb+ZqT9XAf93jggTpe33XYcZ9gpbM7Q4HFLsD92CvCST3M7fW+FxEggZStb1kc+ki/uLndWrFHnunbkGAGmQIIrHbt7Eeeo+fbIaT9ntT3WWheBTH1MAVRvxXQOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlV3SwneMAMeJkpoN2FgHwuGWMdHEU5cixO/XjrZ4Io=;
 b=X6fr0tABz2YjajZMENkgzSpKd9Z13Im3NbOu85mBokk8xuw5qumnub7rObis6gkCjYpy+QZYf1wPkrxhgex2h3WnPmSTKYRECtyM42OfNAXtaX0W6NlpKigOnoe14iBQkkO6A2z/aFaFs3ljcvONOjUAA4BXvqVFxkBDv7IXKY3NG+IDRDm70gpl0YIWbAnNcTjAnCb8VWROkVpMiOruNay+XRCnzx3DpAduw5RU18nhrilxHc2+cvhh4dsYw3K7p6XjY1okZLn+kWHVE5e3e+jDUWdli/sMPOm5ihjvDSYDKfgGAxb2TR9cGo+S6f4Fjxqdx/mvhvp2O4F2Q+o5aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 SA3PR11MB8003.namprd11.prod.outlook.com (2603:10b6:806:2f7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.29; Wed, 28 May
 2025 11:02:53 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%2]) with mapi id 15.20.8769.021; Wed, 28 May 2025
 11:02:52 +0000
Date: Wed, 28 May 2025 19:00:16 +0800
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
Message-ID: <aDbswJwGRe5a4Lzf@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <cover.1747264138.git.ackerleytng@google.com>
 <625bd9c98ad4fd49d7df678f0186129226f77d7d.1747264138.git.ackerleytng@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <625bd9c98ad4fd49d7df678f0186129226f77d7d.1747264138.git.ackerleytng@google.com>
X-ClientProxiedBy: SI2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:196::14) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|SA3PR11MB8003:EE_
X-MS-Office365-Filtering-Correlation-Id: 207562ac-6671-4df0-f705-08dd9dd7312f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2ZMw3ii39VTNkSGTXs3sSel+Qums+SII0Th57ehA5kG5KuZeoYKazvstQnAZ?=
 =?us-ascii?Q?hE4PquOhtlLDqfLx03p/bMHFQeOMj54a88iyspxKmWVq5M6fOencQgN11+tX?=
 =?us-ascii?Q?knk9PXV+rB9nHtGkus+IzDdKb4vfVu2DOPRQ8Zcyjr+Lrwxz7V558SyPTmzT?=
 =?us-ascii?Q?WtM113rDtTZL/FKsxx/WoLsiXaFsHBMZ+Gd1ppKbup2QkQLLgqwiGNNms4I9?=
 =?us-ascii?Q?hwBuO3za3FV9qCBLfa/8RrZ2Vqi9B/4XuoEpc+cszVEUS6ufJdcQndepKe7g?=
 =?us-ascii?Q?pOhWhR9/ElcnbTSpXYWO8qp+G4cKVRLbORs6MZbvn5wUW4GVMhDqM0RlzezA?=
 =?us-ascii?Q?//bcLel0PM2dDSwfWy172J6KUNyTxe2bAXFEZfRoUWKvluEUjqz/R2KJlAod?=
 =?us-ascii?Q?c74Sfw/ss5Kohw6eZM6OazHtQLSmx2M3HiEcwAT5tyC58doU1XoTFIeiCFQc?=
 =?us-ascii?Q?dvNmfNkSb7IWSTgv+B6uo2LwYqCyYEdGM9RrCxT9q8sS25HfzUuUZ6b81LSm?=
 =?us-ascii?Q?GXSQoXl1ddCLbe4tIqFpRttHT2rut05r3+KAU6RrglIhtiKZ5nUdfZ5mjREW?=
 =?us-ascii?Q?zJpAkfxcRmMGid27wgEcXOCS/2r459f2WOAoWnn3FcwObjrhpWOl6EvK64bC?=
 =?us-ascii?Q?EwNX3F3fTbsxdBUjoCzCGgJHnIGHzfl3TNnQ2q6Yd92JkE5C8cz9CvTKtFxZ?=
 =?us-ascii?Q?SBR6pFO5yy9yTLBenEWMQGzdxRbl4kkA9TFC6bHRjplIelrpR41XKJkJAt3G?=
 =?us-ascii?Q?cVKFlZw/zNtVirWL13GuYCJD9IWkRJTJC4VMCrkcXeFkr3mkm2Z2qNzce4Ip?=
 =?us-ascii?Q?56+hv1qRmXhZm6erjnDHQHBBuB5yW69kvAZKJThGZaaBTtHVGjjhqxDI09br?=
 =?us-ascii?Q?EKo7YwAH2p7uAThq7Qe1g8Appns7YytewxSSq/AEHEcq+cZLHW2Qc0U5Mk+p?=
 =?us-ascii?Q?pO8YFRJxvv2dZBGa4fE35hk/QrOzSlRu3Sj954atLYhEWil0rcJEw7s+Zwrz?=
 =?us-ascii?Q?TgbS4q/lkPy70bjxo0Sh2AODDhoID5RKN2FPF4H3EPFsNYxM1aW1Iv73CjF5?=
 =?us-ascii?Q?sqU4/UhyOiiqPYBSWIry1Qe+n6czhb2tUZfvRs8tje+fH/0ZbYU6FYyyaTsm?=
 =?us-ascii?Q?U+mZxpW+hNNe99mLuJEKJNs23iCaU5PQBjLwmt92BiEohHLB1S5u816SBBPs?=
 =?us-ascii?Q?kce5Cx5k4BypV1r0+zOr7tht0d9uqOc1+MOzAUNtv8gMnpDyUB7ikv5nXuJJ?=
 =?us-ascii?Q?vZKm3+b6cV3jb4ZnUOBdsYUSrcx8F+QqIEbTwFeOmIdyUlefjDol/wwjPTdp?=
 =?us-ascii?Q?El398ycOSkqXgW72CFGDPhP6kdMmdzXrwfSnB5H6rV71d0fbqtUOmAne7Byk?=
 =?us-ascii?Q?DE1bXXoK0YQSlwy5avkABL3Xg9Zpi0GzS+1uvYboa9pfdOYyc3oScoa+32Jf?=
 =?us-ascii?Q?O4cpSJlfST4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wMxOB19zsH9AAl2ev6Mg7pdDeY9RbsFBveq742egFeC50R8OhVHu3itmKonm?=
 =?us-ascii?Q?ZuwGEJYo+SXu1AHBBOWBiCXkuJe36tisaqNrDSO3w5ZThwdMoC/8dsC/FQRx?=
 =?us-ascii?Q?YHCJ9A/GlSqk1NtG1SRBTPHe3erAt6HM8k+fDt3L+o5yrpHSgGa+HoyAUc44?=
 =?us-ascii?Q?f1cMkEoNu3JJELJmQC7/o6xrkgtvEBSPp+RVwssnMZeG2Ho/YOVcD/s9isd8?=
 =?us-ascii?Q?rqlzCL6mzADKcU2CUCkHK0DF5jg5uixKxPuA2k8hkmNWeBOV45sD4xT+kTUT?=
 =?us-ascii?Q?jnAxmImgsXT8HJ80CcH/rgFZzCls90xnCTV6sdJprJBgmi0bchgo2+8N6JLR?=
 =?us-ascii?Q?nhJRFTu6f5MrhhZ37rg6Kl86bRlWfwTukHqAZJoXH1fzLbD1h7+rPQqxpOEr?=
 =?us-ascii?Q?3dMi3Lma5nbXfqsNrjSjNyMdJazcKo7ai8WusMOrZaqALxwplZNCxjjBJCSd?=
 =?us-ascii?Q?lKAJorJjJUkyS5bFGgEHigznPZjHDF80ESZG652XlzQSiBwxAUGVaoCLLJDz?=
 =?us-ascii?Q?FjDYD5PF/IO842Y2nzhTT63cJUWdRU5B/JmgkzYDKTQlbAWTgmhwRdr/xHVd?=
 =?us-ascii?Q?7/TXyFBvddHLXi6xd1Z5OvnVhGa4B0MwAsAOn1i/Jrqa7/KO3y49pYn3Uyab?=
 =?us-ascii?Q?O7/zE58M8tZwwXmdSrGt1+dQwwBgKAXxq8Qm71rCZFnovY1ltSOlQuVdIEDw?=
 =?us-ascii?Q?thbTc+VUNjZsM61PC92ZcRv4Kfri5ttilvEdbO4HU5LN0FuKP3k93YM5mx3W?=
 =?us-ascii?Q?7iEkp2KoMoTkzdiGwnFS6CnQ78gBrVUnbhC/LvGDx19/TZsoY4z5X08IqwjG?=
 =?us-ascii?Q?cTgfto/cNxHN7AIgCapynn8wQysyGja94Ry7fSlSU2xR5GfNIJlHUOtf9Yak?=
 =?us-ascii?Q?c0/BnFr1fdF+FuZFtScFFW368qdw8uaEJhN32Fwi/3NeKNY7emx/LiyoQ4Nn?=
 =?us-ascii?Q?+XbTPzm3x5601fJbmcaGHh5ZREARwT3dtB47IDRncG/tVvNgB+PYKod1edy0?=
 =?us-ascii?Q?O+rkl3xMJTPh6gRWbBgt8GIE9bmNfel/S5gJ8jV8aU21ML5Aky9l7oXhNVcX?=
 =?us-ascii?Q?O1il04yYXZTHMGxG35t1aSSzjqi43ZKiW8PvVoqUE/70snbCEQN1RLFaHSJ1?=
 =?us-ascii?Q?ZrHRt5aslFiGPRB1qw2OfyBHj9Tjf8bL4vOMEI7xh07Tm9q2ysPPiSkCE7S0?=
 =?us-ascii?Q?W0lCMBlX3uxVQj89ZNZUAmgfQ3Osro3F/S7A3l3dEn5uRG/UG3MQJWEZPONs?=
 =?us-ascii?Q?xQG+baVYhOkzGZka+WGwMhFaZ11pnm2+ijXSAfwWsfrL94+0ewT7AxQ7N2+Q?=
 =?us-ascii?Q?SDBUqEVgn7s1jRJP9D9YsuNGXxoHwLT/c9e0aJ4fyQmv4abzeNqprc+hFPcT?=
 =?us-ascii?Q?z0PPXYKCKMkjMHNLpl9Kxfl7Lhf8WWQO8K24oXTc1bSfwm6Aziabh7vX2USC?=
 =?us-ascii?Q?fbXZHMBc5dpnCVW9QK33BcNXKnlRoNo93JNtN7h1yEFbnKkmi0hRxXdiQTJc?=
 =?us-ascii?Q?hEpCVHVoFUw6i0zFYdMgASHw1pP+wLTTyzOsnfJSBLzLbhWna2k036vdRypU?=
 =?us-ascii?Q?KzU1NHNocTBTclJ+kUu6RsbOuWjxCNXm9pcx5fb1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 207562ac-6671-4df0-f705-08dd9dd7312f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 11:02:52.7711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IAO8Bda1XHgMPuulh5JFrdZHRHWvWKsy8K49DJ62da8wSvUXpnzkcvqMVmnptqe+2MSae2tCT9fdKT9pun2b7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8003
X-OriginatorOrg: intel.com

On Wed, May 14, 2025 at 04:42:18PM -0700, Ackerley Tng wrote:
> Merge and truncate on fallocate(PUNCH_HOLE), but if the file is being
> closed, defer merging to folio_put() callback.
> 
> Change-Id: Iae26987756e70c83f3b121edbc0ed0bc105eec0d
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>  virt/kvm/guest_memfd.c | 76 +++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 68 insertions(+), 8 deletions(-)
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index cb426c1dfef8..04b1513c2998 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -859,6 +859,35 @@ static int kvm_gmem_restructure_folios_in_range(struct inode *inode,
>  	return ret;
>  }
>  
> +static long kvm_gmem_merge_truncate_indices(struct inode *inode, pgoff_t index,
> +					   size_t nr_pages)
> +{
> +	struct folio *f;
> +	pgoff_t unused;
> +	long num_freed;
> +
> +	unmap_mapping_pages(inode->i_mapping, index, nr_pages, false);
> +
> +	if (!kvm_gmem_has_safe_refcount(inode->i_mapping, index, nr_pages, &unused))
Why is kvm_gmem_has_safe_refcount() checked here, but not in
kvm_gmem_zero_range() within kvm_gmem_truncate_inode_range() in patch 33?

> +		return -EAGAIN;
> +

Rather than merging the folios, could we simply call kvm_gmem_truncate_indices()
instead?

num_freed = kvm_gmem_truncate_indices(inode->i_mapping, index, nr_pages);
return num_freed;

> +	f = filemap_get_folio(inode->i_mapping, index);
> +	if (IS_ERR(f))
> +		return 0;
> +
> +	/* Leave just filemap's refcounts on the folio. */
> +	folio_put(f);
> +
> +	WARN_ON(kvm_gmem_merge_folio_in_filemap(inode, f));
> +
> +	num_freed = folio_nr_pages(f);
> +	folio_lock(f);
> +	truncate_inode_folio(inode->i_mapping, f);
> +	folio_unlock(f);
> +
> +	return num_freed;
> +}
> +
>  #else
>  
>  static inline int kvm_gmem_try_split_folio_in_filemap(struct inode *inode,
> @@ -874,6 +903,12 @@ static int kvm_gmem_restructure_folios_in_range(struct inode *inode,
>  	return 0;
>  }
>  
> +static long kvm_gmem_merge_truncate_indices(struct inode *inode, pgoff_t index,
> +					   size_t nr_pages)
> +{
> +	return 0;
> +}
> +
>  #endif
>  
>  #else
> @@ -1182,8 +1217,10 @@ static long kvm_gmem_truncate_indices(struct address_space *mapping,
>   *
>   * Removes folios beginning @index for @nr_pages from filemap in @inode, updates
>   * inode metadata.
> + *
> + * Return: 0 on success and negative error otherwise.
>   */
> -static void kvm_gmem_truncate_inode_aligned_pages(struct inode *inode,
> +static long kvm_gmem_truncate_inode_aligned_pages(struct inode *inode,
>  						  pgoff_t index,
>  						  size_t nr_pages)
>  {
> @@ -1191,19 +1228,34 @@ static void kvm_gmem_truncate_inode_aligned_pages(struct inode *inode,
>  	long num_freed;
>  	pgoff_t idx;
>  	void *priv;
> +	long ret;
>  
>  	priv = kvm_gmem_allocator_private(inode);
>  	nr_per_huge_page = kvm_gmem_allocator_ops(inode)->nr_pages_in_folio(priv);
>  
> +	ret = 0;
>  	num_freed = 0;
>  	for (idx = index; idx < index + nr_pages; idx += nr_per_huge_page) {
> -		num_freed += kvm_gmem_truncate_indices(
> -			inode->i_mapping, idx, nr_per_huge_page);
> +		if (mapping_exiting(inode->i_mapping) ||
> +		    !kvm_gmem_has_some_shared(inode, idx, nr_per_huge_page)) {
> +			num_freed += kvm_gmem_truncate_indices(
> +				inode->i_mapping, idx, nr_per_huge_page);
> +		} else {
> +			ret = kvm_gmem_merge_truncate_indices(inode, idx,
> +							      nr_per_huge_page);
> +			if (ret < 0)
> +				break;
> +
> +			num_freed += ret;
> +			ret = 0;
> +		}
>  	}
>  
>  	spin_lock(&inode->i_lock);
>  	inode->i_blocks -= (num_freed << PAGE_SHIFT) / 512;
>  	spin_unlock(&inode->i_lock);
> +
> +	return ret;
>  }
>  
>  /**
> @@ -1252,8 +1304,10 @@ static void kvm_gmem_zero_range(struct address_space *mapping,
>   *
>   * Removes full (huge)pages from the filemap and zeroing incomplete
>   * (huge)pages. The pages in the range may be split.
> + *
> + * Return: 0 on success and negative error otherwise.
>   */
> -static void kvm_gmem_truncate_inode_range(struct inode *inode, loff_t lstart,
> +static long kvm_gmem_truncate_inode_range(struct inode *inode, loff_t lstart,
>  					  loff_t lend)
>  {
>  	pgoff_t full_hpage_start;
> @@ -1263,6 +1317,7 @@ static void kvm_gmem_truncate_inode_range(struct inode *inode, loff_t lstart,
>  	pgoff_t start;
>  	pgoff_t end;
>  	void *priv;
> +	long ret;
>  
>  	priv = kvm_gmem_allocator_private(inode);
>  	nr_per_huge_page = kvm_gmem_allocator_ops(inode)->nr_pages_in_folio(priv);
> @@ -1279,10 +1334,11 @@ static void kvm_gmem_truncate_inode_range(struct inode *inode, loff_t lstart,
>  		kvm_gmem_zero_range(inode->i_mapping, start, zero_end);
>  	}
>  
> +	ret = 0;
>  	if (full_hpage_end > full_hpage_start) {
>  		nr_pages = full_hpage_end - full_hpage_start;
> -		kvm_gmem_truncate_inode_aligned_pages(inode, full_hpage_start,
> -						      nr_pages);
> +		ret = kvm_gmem_truncate_inode_aligned_pages(
> +			inode, full_hpage_start, nr_pages);
>  	}
>  
>  	if (end > full_hpage_end && end > full_hpage_start) {
> @@ -1290,6 +1346,8 @@ static void kvm_gmem_truncate_inode_range(struct inode *inode, loff_t lstart,
>  
>  		kvm_gmem_zero_range(inode->i_mapping, zero_start, end);
>  	}
> +
> +	return ret;
>  }
>  
>  static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
> @@ -1298,6 +1356,7 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
>  	pgoff_t start = offset >> PAGE_SHIFT;
>  	pgoff_t end = (offset + len) >> PAGE_SHIFT;
>  	struct kvm_gmem *gmem;
> +	long ret;
>  
>  	/*
>  	 * Bindings must be stable across invalidation to ensure the start+end
> @@ -1308,8 +1367,9 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
>  	list_for_each_entry(gmem, gmem_list, entry)
>  		kvm_gmem_invalidate_begin_and_zap(gmem, start, end);
>  
> +	ret = 0;
>  	if (kvm_gmem_has_custom_allocator(inode)) {
> -		kvm_gmem_truncate_inode_range(inode, offset, offset + len);
> +		ret = kvm_gmem_truncate_inode_range(inode, offset, offset + len);
>  	} else {
>  		/* Page size is PAGE_SIZE, so use optimized truncation function. */
>  		truncate_inode_pages_range(inode->i_mapping, offset, offset + len - 1);
> @@ -1320,7 +1380,7 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
>  
>  	filemap_invalidate_unlock(inode->i_mapping);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
> -- 
> 2.49.0.1045.g170613ef41-goog
> 

