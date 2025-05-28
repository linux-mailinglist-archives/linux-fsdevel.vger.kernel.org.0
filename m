Return-Path: <linux-fsdevel+bounces-49972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A38AC67F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 13:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162C33A76FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 11:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BF7279785;
	Wed, 28 May 2025 11:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MJpfPPHa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ACA202C26;
	Wed, 28 May 2025 11:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748430112; cv=fail; b=TneaaDpB8r8d1Yv+ujMMvnwNkcN/eJrzSPi6gApXeyVrI46mDzbLSdsFTYQVVbvvLaSdW4NKInvFgxpRauAIr+pnGVuxA7c4OKUnFIGK29RORfWjykvzGdZILe50rrz6v08EpyiXkUp/kwrngDu6HfJDqGMAbYTncqrapV2QALM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748430112; c=relaxed/simple;
	bh=japyi3q9MOOVSvow+MNX/9JlH3JYo/aYnbKpJX/zsE4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iLMCTIIk33AMnpzHz4HWe8x8m9CS4fl35ZyMFHTe5AF/tJRrmUsPC9rqy+Afwsv46hutCLuZuFUmUYxloGI+J3KkSWimTb4jcwtFaJON9OC6dRn+KHuthj7iKy0Aw5pjFrVxXMPMr0StQ/co/2nv8a3sva05PyUqkrhvwZZFKcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MJpfPPHa; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748430110; x=1779966110;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=japyi3q9MOOVSvow+MNX/9JlH3JYo/aYnbKpJX/zsE4=;
  b=MJpfPPHaZF4OJAGl1rxOPH8qz9XDq/AB2uoYt0d5SBx9Lz5k8wVMyISs
   9zhCgCllJd7yIiGDohp/YpBOEAV+CI3slXHsJ4rZyANSSQt1RQpvz0WPC
   F4Kb6SR7mRm92DLZw7yzSSxgh0rA4UYISfiu+mFCXTdrpQRl4Q72LjiHa
   VAKWgGU0ySWBf4crO+Q4N4UPyE4C57CPElbye4D60V4jjeV+NzY2Hvc1S
   YF+0WFUFAFAMGlmNrBk1TWTy5k6f+7w5jpGC9iRXv9+aUnZXrQh58/VOy
   07RRWmTv0ZQxW94PA+oh7ghO5kZjEugmIvNVT3Ta3cDbvOXSYQtiNRxvW
   w==;
X-CSE-ConnectionGUID: wNP/MaiwSfyA1voC2Lbazw==
X-CSE-MsgGUID: /xy8FYxtRDW3tReZeREcxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="54254051"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="54254051"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 04:00:54 -0700
X-CSE-ConnectionGUID: MpzwriitSLydxaGMbPE4Uw==
X-CSE-MsgGUID: Y3ctCRKBTCafbmR7or88cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="143658597"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 04:00:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 04:00:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 04:00:48 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.51)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 04:00:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rJ5mmahMGXTsbehPiKp5RsIbAXXbIjik54FUY3o4MQoJUu0iEsUe9VWJdjhGsAWcktpU5IuxcrstGnZCakl33XiwLc5XP/WqJ8s/TZKJPXN3C+521BxRqiByUMQ/+6CO923dFJDiEkMQKSC1fZIgc8BxKGYtv5dGDkFlW/s601VpUpHXd6UdFzuqmzpl5nO+fn91v5ojL0+QlCykSIS5+KLmeHaUHmJzISDNgd1TdkrD75RT5BKdetK4tHoFKsFNBy38ZoQxTLWuEJ7cvt2MKgpOlBr2M4r+jaDXTPIwWRNUDpoJJ+eRfR+UERZ/eO/tYOurCJh77bWwDWmBa0tV3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g14DI+HMBISeBZmZux0iMxcOROzRLlY425X2xaZM7ck=;
 b=SKiqQJUhU5ksheK//qDD+8kD3XzPZsCdkjhOA3P8gWshDakAlCYGG0Zt8lmZ4aW2puDXNU+yNowuIaOJyu/aAySi7cGRMe409Vr3zwCXw0rx9P14vKFvFGJWevOThFqp7TgWRA0CPubJlyWVCag8qwD+pshk9rZqcnffLPPR28C4xWwylGM0rKb05I16yrD/z/MwG2FNR9NBNLeaUEpAxZc4p0EIgTS/DqllkrbDVDbmqniTCzdB8FUkT/thhpmHt0+RFPnbkdYwvzCQE2WdGvgGE4mS1S0I6l9CKDJj2qzMsip6+KN3pnb8qY6RWhloP/nKh7F5sLEKyZjQKbyVGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 SA3PR11MB8003.namprd11.prod.outlook.com (2603:10b6:806:2f7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.29; Wed, 28 May
 2025 11:00:43 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%2]) with mapi id 15.20.8769.021; Wed, 28 May 2025
 11:00:43 +0000
Date: Wed, 28 May 2025 18:58:04 +0800
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
Subject: Re: [RFC PATCH v2 33/51] KVM: guest_memfd: Allocate and truncate
 from custom allocator
Message-ID: <aDbsPMghVC1yemiH@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <cover.1747264138.git.ackerleytng@google.com>
 <e9aaf20d31281d00861b1805404dbed40024f824.1747264138.git.ackerleytng@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e9aaf20d31281d00861b1805404dbed40024f824.1747264138.git.ackerleytng@google.com>
X-ClientProxiedBy: KU2P306CA0045.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3c::17) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|SA3PR11MB8003:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e20488a-10c3-4fa4-47d4-08dd9dd6e3cf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FYDwB2GIgLSoef+E0A0guBWKjfFqG3d0tK6JOtwix9xjwQaGEkJcMH/ZH6eK?=
 =?us-ascii?Q?b17SQDFBI0AEzR8NKU/R45XcG6uiJm87tUNHv99ktw7jsQi31ciR/dglIbjl?=
 =?us-ascii?Q?rv71/alojhY5caCSDtlOMDI+BbbVEw/qDR4DD9xcHKoWYbMw6+SonxZvQ1yD?=
 =?us-ascii?Q?d3LUv4YOuLQOXWGQILwqj4akhkvn1P/CcbUTYPl5TGqV0MV7XZJJewg2qXP3?=
 =?us-ascii?Q?qQqw0OTYoW2HpO0CSwFa1YKahq2nOvQO85502E+9DiNOy9my/HC4Uyw+Np+0?=
 =?us-ascii?Q?vvCDr9jXTOcrSg/lcNu3dew6m3EwzvyeptR0tywaxOpkietjwMYVWTz0zNfn?=
 =?us-ascii?Q?xfyaH1iNvU2eNi4+I1LwmJJxPqAtOxaRzLh3VM5ZVgZPHAG8jog1E8kNxdQV?=
 =?us-ascii?Q?uVbH+qo88w/m5QMA/dfj0bw3RBqDkxeJyj6/k4OXq9UplNpdG7KlBDDpfl65?=
 =?us-ascii?Q?YyYivAQCFUFo85raq/Ef9PVBs4bYXn1VRHdnAeq/DYqlF6GosjyVyO5SRR8n?=
 =?us-ascii?Q?ti8948HMpSuRvb6C49B/xPSgCCss2po+vV5UIZQ9viKZMPndmfEoxrNYW9zZ?=
 =?us-ascii?Q?Z8q4ZdFMUGQDDY02zsUJBuCMUEQiGdg1TXhxsLcmwktSocTYuTyTmd9qx3UB?=
 =?us-ascii?Q?NHbTLWd29hFNHN81C/OdUxB+NgNV+DKbE26JDAteixkJErAlafceFvpw3Xvn?=
 =?us-ascii?Q?rcNCUR8sfgVFP2qaA6/trEPPDskcALZNdkoCAUlwMI6mxKzIdE620tNNA+3q?=
 =?us-ascii?Q?NTBzEHh2uAKSTESAZJOqvDEJcWaFXFqi6Z+57ynPYEUYPpaYyXdtX0bPyiGV?=
 =?us-ascii?Q?J4dpqDGQRgYLK9HM1S1E5YE71/nF5+f0Jauoq59R4ZcmB7ul6zNg5O1ejvLa?=
 =?us-ascii?Q?3uoDCLZhfqsWG05IqDEaGzW81CQPG9KFfmotK4juOAdSnatLjRtSwrxWdTOC?=
 =?us-ascii?Q?jIbjLCoWfrnCOO6dNw09U/m0N+M/ipcjw3kSnNHA9Ra0YvzofUX8SSqfeGax?=
 =?us-ascii?Q?f5iNz+Zzkrxt242HdPL8TvkcIaQzEr3qcPEK0fviwHRfmJRb+c8dfLBEzoHu?=
 =?us-ascii?Q?w6fU1hHGnROq6ylZI9cTYEbsaDo4XkfWbiqsvLJcgBdswlk2gCdY7Ck3AV8u?=
 =?us-ascii?Q?qtnkswPCfT/OMyFHiFgLMM6sVTS92Zmr0nQS7PrQim3bbr2reqQEQ5RDExam?=
 =?us-ascii?Q?fbP71zHxP59KkuHDYxAT8jjQEIAD+WJzdWzqAVQAugw5Sxcqjd35pbdKK41D?=
 =?us-ascii?Q?TiNUPQDENzARFyxEpf+9kfmJuAf1kXlKQnYr1+/uB2qqHq+AKYGxkeMY8fUV?=
 =?us-ascii?Q?Q3lSI+wFH7GQFwIfTElIAUq3VhSlFD+GOgf5W0dufw/xmT0bDXL8hfLqMAwH?=
 =?us-ascii?Q?Pq0BYvQ7tD4xz9C+So1x2Dlk08L25CkIOWfN3cexlRc2xyynfl95wIv4StSW?=
 =?us-ascii?Q?5BnQyApGbXw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9sL6XpCoAsHhGf5BBL8v94j9VfyZNuPHJpzTWXsFlAnpoj2rMiPea8jezjtB?=
 =?us-ascii?Q?qNGfEbbqWEO0iMxGr8EMuX+vUAzACND1ddCuPO5J5ynyxmaZrXP5vJ2H1eAn?=
 =?us-ascii?Q?k1MNXl6G/Tyn9AJaBEZVqx7KZnkW/+Yu8YMkffRJZgGUWXlLH3DNzOZRWbkk?=
 =?us-ascii?Q?alPuRFW0vAfjJKp3JKh7Pyo2kLGBFCDkIMeIkFKiNNnM5l8GRkWV/t7LyeD7?=
 =?us-ascii?Q?lAWxfDaaD9wVJWJnJsr86N0U7ivFONq5QhKrt+mtwZSsYeq7wTg8xENYk43t?=
 =?us-ascii?Q?JZGDC1Pq9eVo3LnXjS1MebDOPTpZdlNPcBjR4t4jojKprZzzoPav6sI3QX5f?=
 =?us-ascii?Q?buoL7IBFRwL9QD19tDbWFfaHc7Xuj1P857HDejswxpMNS8Z1RnT9slyRaqAR?=
 =?us-ascii?Q?hFcFLdhfkfwFb/P8DN049Ja320wTmdW2K0JgcXXe94RV27rAxcXpKtcsnpsh?=
 =?us-ascii?Q?+7ekEKDKHshw77tqSe4E/8AMyV1Mh5FuRIO5ZhLEgem66CzeL1Io0rk5WAHW?=
 =?us-ascii?Q?VVbwIwe/r0GGpdKaSqKl9yO30zEU+LKLuLiTWFWyEsvjGD78csdvBZ5qqRWg?=
 =?us-ascii?Q?EOzEoY5sKEJZjspvnN/0fwzZgYpF/wgppyIU4lf8D2FBlDmhzY/vXPpcFEUd?=
 =?us-ascii?Q?CKA4X4OBZ6GHVewfENOygApM5AHvDHCItuVQ1DUzsd0FQQYg4r2vKoMC+tLT?=
 =?us-ascii?Q?ZjkrR6doTxjiFuVQbrZkjbpsInlHtkr84qZhAe/s9zvbJX5QjGiqlNG/Hplh?=
 =?us-ascii?Q?atmKwHynDcq6C4s7LERCiMimRctbt/Q7zli8m6jpTSqrAHiEGH5Z8B/w8SYM?=
 =?us-ascii?Q?iajaWcb5jqMx+VGrmoz3C4TtQIvlFzAj5UsZFn2KUHdXqrEpBL0ZP9zExN7/?=
 =?us-ascii?Q?5y9M9U4S0zTHLGKZMJ9f4NdhyVi8QymzBOi5R2VgBHje/pr9HMni1tr3Pke7?=
 =?us-ascii?Q?zQBKzOd2jK5UB3YF7wgY72/NtFDJXurKADjMIQBPH2BAFRm7U5AlBA69gZhQ?=
 =?us-ascii?Q?Xv30ufNS4t8ekg+JZ1q/z4i1j8Qq/QuN+s0b0W/CN4uzU6HGdY7ydsU7Pise?=
 =?us-ascii?Q?OP3Lw14vri5tPkQyyG4Yr9TSJLKGxQoLoN+P/YQFEOMZmArEJpmy59zzrRwn?=
 =?us-ascii?Q?yseRhmC496xUsG7dhKVCh8medk+LcXJTPihba8exsi3vtI2rnIxy4HdZXaeR?=
 =?us-ascii?Q?scNPLnepEoZPQMiUUaXIRfofHzKWkPYewzEo5b4SV5xan75oClIEsJolmhLp?=
 =?us-ascii?Q?O0wDqGR4IOtAnsJ/3BMP+rWBqtIX/eddSgoiPxKPuJqMhumyULCtPEkfG87t?=
 =?us-ascii?Q?jsBiRjLzPKCAHvJA/Ii1kS3HqziQQR+Rpzaly7ZqhYYoxZYsoKAdvg3JADJm?=
 =?us-ascii?Q?Gx53r77tXlUzYURQ7CaXLHlBAreW82a+gKvgjngoffWwHuU+mhY6gvYo5cPl?=
 =?us-ascii?Q?+CFhsptZxo8FSHy/KzRQzJvz9kFE4b1Z5B4DloB4Nc1FU+sKDCMOszJjJJxM?=
 =?us-ascii?Q?WAHH34sPaFVBTRaY1o6yyztlU1bsOaI2NMhSff9EZK4lJu60KYEZNGVy/hWv?=
 =?us-ascii?Q?TdoBOVZtsCjdXRybbvSouJynqMXTv464esFSWK6v?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e20488a-10c3-4fa4-47d4-08dd9dd6e3cf
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 11:00:43.1146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XuJvKOs7a810QCXZkAu93JfspxATFIlfae1U6AIz7kj1ABEHKOrAwRnjBqA+euhm/RjMKgU0EXnfO7cwFYitPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8003
X-OriginatorOrg: intel.com

On Wed, May 14, 2025 at 04:42:12PM -0700, Ackerley Tng wrote:
> If a custom allocator is requested at guest_memfd creation time, pages
> from the custom allocator will be used to back guest_memfd.
> 
> Change-Id: I59df960b3273790f42fe5bea54a234f40962eb75
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>  mm/memory.c            |   1 +
>  virt/kvm/guest_memfd.c | 142 +++++++++++++++++++++++++++++++++++++----
>  2 files changed, 132 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index ba3ea0a82f7f..3af45e96913c 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -7249,6 +7249,7 @@ void folio_zero_user(struct folio *folio, unsigned long addr_hint)
>  	else
>  		process_huge_page(addr_hint, nr_pages, clear_subpage, folio);
>  }
> +EXPORT_SYMBOL_GPL(folio_zero_user);
>  
>  static int copy_user_gigantic_page(struct folio *dst, struct folio *src,
>  				   unsigned long addr_hint,
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index c65d93c5a443..24d270b9b725 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -478,15 +478,13 @@ static inline void kvm_gmem_mark_prepared(struct folio *folio)
>   * leaking host data and the up-to-date flag is set.
>   */
>  static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
> -				  gfn_t gfn, struct folio *folio)
> +				  gfn_t gfn, struct folio *folio,
> +				  unsigned long addr_hint)
>  {
> -	unsigned long nr_pages, i;
>  	pgoff_t index;
>  	int r;
>  
> -	nr_pages = folio_nr_pages(folio);
> -	for (i = 0; i < nr_pages; i++)
> -		clear_highpage(folio_page(folio, i));
> +	folio_zero_user(folio, addr_hint);
>  
>  	/*
>  	 * Preparing huge folios should always be safe, since it should
> @@ -554,7 +552,9 @@ static int kvm_gmem_filemap_add_folio(struct address_space *mapping,
>   */
>  static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
>  {
> +	size_t allocated_size;
>  	struct folio *folio;
> +	pgoff_t index_floor;
>  	int ret;
>  
>  repeat:
> @@ -581,8 +581,10 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
>  			return ERR_PTR(ret);
>  		}
>  	}
> +	allocated_size = folio_size(folio);
>  
> -	ret = kvm_gmem_filemap_add_folio(inode->i_mapping, folio, index);
> +	index_floor = round_down(index, folio_nr_pages(folio));
> +	ret = kvm_gmem_filemap_add_folio(inode->i_mapping, folio, index_floor);
>  	if (ret) {
>  		folio_put(folio);
>  
> @@ -598,7 +600,17 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
>  		return ERR_PTR(ret);
>  	}
>  
> -	__folio_set_locked(folio);
> +	spin_lock(&inode->i_lock);
> +	inode->i_blocks += allocated_size / 512;
> +	spin_unlock(&inode->i_lock);
> +
> +	/*
> +	 * folio is the one that is allocated, this gets the folio at the
> +	 * requested index.
> +	 */
> +	folio = page_folio(folio_file_page(folio, index));
> +	folio_lock(folio);
> +
>  	return folio;
>  }
>  
> @@ -736,6 +748,92 @@ static void kvm_gmem_truncate_inode_aligned_pages(struct inode *inode,
>  	spin_unlock(&inode->i_lock);
>  }
>  
> +/**
> + * kvm_gmem_zero_range() - Zeroes all sub-pages in range [@start, @end).
> + *
> + * @mapping: the filemap to remove this range from.
> + * @start: index in filemap for start of range (inclusive).
> + * @end: index in filemap for end of range (exclusive).
> + *
> + * The pages in range may be split. truncate_inode_pages_range() isn't the right
> + * function because it removes pages from the page cache; this function only
> + * zeroes the pages.
> + */
> +static void kvm_gmem_zero_range(struct address_space *mapping,
> +				pgoff_t start, pgoff_t end)
> +{
> +	struct folio_batch fbatch;
> +
> +	folio_batch_init(&fbatch);
> +	while (filemap_get_folios(mapping, &start, end - 1, &fbatch)) {
> +		unsigned int i;
> +
> +		for (i = 0; i < folio_batch_count(&fbatch); ++i) {
> +			struct folio *f;
> +			size_t nr_bytes;
> +
> +			f = fbatch.folios[i];
> +			nr_bytes = offset_in_folio(f, end << PAGE_SHIFT);
> +			if (nr_bytes == 0)
> +				nr_bytes = folio_size(f);
> +
Is folio_lock() required here?

> +			folio_zero_segment(f, 0, nr_bytes);
> +		}
> +
> +		folio_batch_release(&fbatch);
> +		cond_resched();
> +	}
> +}
> +
> +/**
> + * kvm_gmem_truncate_inode_range() - Truncate pages in range [@lstart, @lend).
> + *
> + * @inode: inode to truncate from.
> + * @lstart: offset in inode for start of range (inclusive).
> + * @lend: offset in inode for end of range (exclusive).
> + *
> + * Removes full (huge)pages from the filemap and zeroing incomplete
> + * (huge)pages. The pages in the range may be split.
> + */
> +static void kvm_gmem_truncate_inode_range(struct inode *inode, loff_t lstart,
> +					  loff_t lend)
> +{
> +	pgoff_t full_hpage_start;
> +	size_t nr_per_huge_page;
> +	pgoff_t full_hpage_end;
> +	size_t nr_pages;
> +	pgoff_t start;
> +	pgoff_t end;
> +	void *priv;
> +
> +	priv = kvm_gmem_allocator_private(inode);
> +	nr_per_huge_page = kvm_gmem_allocator_ops(inode)->nr_pages_in_folio(priv);
> +
> +	start = lstart >> PAGE_SHIFT;
> +	end = min(lend, i_size_read(inode)) >> PAGE_SHIFT;
> +
> +	full_hpage_start = round_up(start, nr_per_huge_page);
> +	full_hpage_end = round_down(end, nr_per_huge_page);
> +
> +	if (start < full_hpage_start) {
> +		pgoff_t zero_end = min(full_hpage_start, end);
> +
> +		kvm_gmem_zero_range(inode->i_mapping, start, zero_end);
> +	}
> +
> +	if (full_hpage_end > full_hpage_start) {
> +		nr_pages = full_hpage_end - full_hpage_start;
> +		kvm_gmem_truncate_inode_aligned_pages(inode, full_hpage_start,
> +						      nr_pages);
> +	}
> +
> +	if (end > full_hpage_end && end > full_hpage_start) {
> +		pgoff_t zero_start = max(full_hpage_end, start);
> +
> +		kvm_gmem_zero_range(inode->i_mapping, zero_start, end);
> +	}
> +}
> +
>  static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
>  {
>  	struct list_head *gmem_list = &inode->i_mapping->i_private_list;
> @@ -752,7 +850,12 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
>  	list_for_each_entry(gmem, gmem_list, entry)
>  		kvm_gmem_invalidate_begin(gmem, start, end);
The kvm_gmem_punch_hole() can be triggered by user's madvise() operation, e.g.,

mem = mmap(NULL, test_page_size, PROT_READ | PROT_WRITE, MAP_SHARED, guest_memfd, 0);
madvise(mem, test_page_size, MADV_REMOVE);

As the mmap'ed VA is only for shared memory, it seems that the madvise() on a VA
range should only affect the shared memory. However, kvm_gmem_punch_hole()
indiscriminately truncates or zeros any memory.



> -	truncate_inode_pages_range(inode->i_mapping, offset, offset + len - 1);
> +	if (kvm_gmem_has_custom_allocator(inode)) {
> +		kvm_gmem_truncate_inode_range(inode, offset, offset + len);
> +	} else {
> +		/* Page size is PAGE_SIZE, so use optimized truncation function. */
> +		truncate_inode_pages_range(inode->i_mapping, offset, offset + len - 1);
> +	}
>  
>  	list_for_each_entry(gmem, gmem_list, entry)
>  		kvm_gmem_invalidate_end(gmem, start, end);
> @@ -776,6 +879,16 @@ static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
>  
>  	start = offset >> PAGE_SHIFT;
>  	end = (offset + len) >> PAGE_SHIFT;
> +	if (kvm_gmem_has_custom_allocator(inode)) {
> +		size_t nr_pages;
> +		void *p;
> +
> +		p = kvm_gmem_allocator_private(inode);
> +		nr_pages = kvm_gmem_allocator_ops(inode)->nr_pages_in_folio(p);
> +
> +		start = round_down(start, nr_pages);
> +		end = round_down(end, nr_pages);
> +	}
>  
>  	r = 0;
>  	for (index = start; index < end; ) {
> @@ -1570,7 +1683,7 @@ static struct folio *__kvm_gmem_get_pfn(struct file *file,
>  
>  	*pfn = folio_file_pfn(folio, index);
>  	if (max_order)
> -		*max_order = 0;
> +		*max_order = folio_order(folio);
>  
>  	*is_prepared = folio_test_uptodate(folio);
>  	return folio;
> @@ -1597,8 +1710,15 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>  		goto out;
>  	}
>  
> -	if (!is_prepared)
> -		r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
> +	if (!is_prepared) {
> +		/*
> +		 * Use the same address as hugetlb for zeroing private pages
> +		 * that won't be mapped to userspace anyway.
> +		 */
> +		unsigned long addr_hint = folio->index << PAGE_SHIFT;
> +
> +		r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio, addr_hint);
> +	}
>  
>  	folio_unlock(folio);
>  
> -- 
> 2.49.0.1045.g170613ef41-goog
> 

