Return-Path: <linux-fsdevel+bounces-49882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C28AC46F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 05:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C12011890B36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 03:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC64A1CAA6C;
	Tue, 27 May 2025 03:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sn1pDoEW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF55010A1E;
	Tue, 27 May 2025 03:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748318251; cv=fail; b=nEh1+zF9spP2BCZwyNSkIBY1G/hvwN1gx8+IfKdIs3AD2MJgnjSfFkijK9jDSR0KQv2Eyxj6A/p5bJYI6h2IvibJ+JTyiIx82KZHr+zerMRxVGyMmIe4tp9Ze5CyozSr2xyrmtVEq1kBvU0LrHi6BJSpICxDJsDTJhV50Cms4YE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748318251; c=relaxed/simple;
	bh=wdAaj+T+GHddu1tichy8e8/mESEDZanGU+ZSwOh0aX0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BMe92K4c5HL7/ppGxkdgfkhpJZxeZHgogFKprLDPFzpOBzp+AGlOsTmCXYVVkJavg+fbpHYjK+X+r6y119OKgjFZJPcYxenJlKu++iFCeHYR4QbjBnd7rZ57bXmSx0IIP7CtxaXhMyxdZOBOd4/NMLIlPnbLLThD6aAanvvj4Lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sn1pDoEW; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748318249; x=1779854249;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=wdAaj+T+GHddu1tichy8e8/mESEDZanGU+ZSwOh0aX0=;
  b=Sn1pDoEWbB6TqJtXvtsDcZPF1vPvf3/Yva9wEQh0OGWu4n6PaMyXHA2O
   FhvVfovKcn61tCyqZwkKZ3jW2V5rnsiiAb5KNzta0BVeG4TlhRV5R4P12
   2jP6S50xT115s0Fu73boJ6hGrV1OWRog1vvg8PMh/n9e91u7e/cXtxLsX
   qskOyN26o9R47RaCdvt6xK1M+URRaorleYrfWA5i2ySnmMWLX8hxlw3kw
   hGkQFhuNNMh8b4I/gfWkPV9zDOxIcIYFvNma3rJWSwNaqmVPdZP8gGC/C
   FB3j6ia36cx2EB5CveWX0zzlX921Cyvr0C7E23Ilts/Jx+5m/4JKljpQ7
   Q==;
X-CSE-ConnectionGUID: NpsFJQjHQMC5W2Enr01oGw==
X-CSE-MsgGUID: fh/gXO9RS5im0jspQpF/Qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="50216890"
X-IronPort-AV: E=Sophos;i="6.15,317,1739865600"; 
   d="scan'208";a="50216890"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 20:57:27 -0700
X-CSE-ConnectionGUID: sPzu0k7KS2y0N4B0K/ewZg==
X-CSE-MsgGUID: FdM18qZjSXWjyVKTv0wk2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,317,1739865600"; 
   d="scan'208";a="142545714"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 20:57:28 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 26 May 2025 20:57:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 26 May 2025 20:57:26 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.59)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 26 May 2025 20:57:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WUZ6EicUGzesS9ZFopf6Vf+6BssQwlbOuhwklKnV1GGefiv9krJtm2bo3WNcEgY4clKjactlQrK/1eVm11UWLilg6fs63/bpNaNEDThvegV9HOckC1NL7koaQawtmI3yj0zsTJ5FLbL5+0ZJdVdqKjigL3z74TAiRb6QFnz4ODJhLBmRySBHqV/OkCtmm9UMAcT7XsXnEf9v+MygiLizUcyijM4r4b4rle9ZubX3EiVVTqrxir6nvq11eRAZIrcfUhlraVsegbbqNseN+8hW+39ZZxrFNtioe0A9Xze4d8NAohl3mwkzqiZCjsWhx6h1QCEfJUbK1iVvuto57JtRvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/EpB9XwrZj68UTjBfpaf7/PyCNCMp9gFcO6dM1RWNeI=;
 b=EhkGrVvLCZPyF2gpNs23hm7tEZigx6RA/M7V7ryvmLxa4oqX2XQlMgPGvwAgA6p3RIk/pJ0GDWMVUezh9xvsY+5uQqj8uiHL9z9MLzWL/ZW5NyTmT5Xbibr0a+v9rCIvjz5bM9Brc4YhP/vVV5FspxAGC55Dh8xsKOKxgvF3LnXfaEdYDGmL7wb2w9r9eaIhK+Z2/ySko+KYau3F3B3iRYI9EUMyooQ5YFfzGCgt/I2/P23hoHY3ZNT2k7W2pUnOgdJxif5dDGfa7IqVNSeDsbjbPZAqklS8AifaZ4Em/Ym0CTjnbMtDcz1tG0h1tP6zK+jevalpB7AqN0XrCGU6XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 IA0PR11MB8355.namprd11.prod.outlook.com (2603:10b6:208:480::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Tue, 27 May
 2025 03:57:09 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%2]) with mapi id 15.20.8769.021; Tue, 27 May 2025
 03:57:09 +0000
Date: Tue, 27 May 2025 11:54:32 +0800
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
Subject: Re: [RFC PATCH v2 02/51] KVM: guest_memfd: Introduce and use
 shareability to guard faulting
Message-ID: <aDU3eL7qQYrXkE3T@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <cover.1747264138.git.ackerleytng@google.com>
 <b784326e9ccae6a08388f1bf39db70a2204bdc51.1747264138.git.ackerleytng@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b784326e9ccae6a08388f1bf39db70a2204bdc51.1747264138.git.ackerleytng@google.com>
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|IA0PR11MB8355:EE_
X-MS-Office365-Filtering-Correlation-Id: da58fc7a-e153-4dcf-e16a-08dd9cd28d6c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MVODEFq27qvYTVEqCqF36YlTJq4+1/xE97LmqCc8MYRXmXQhyabgs0FOuV2F?=
 =?us-ascii?Q?BYg6bdhOebfAeoIxqjYDWp8jGuKa41qjLc6x2o+oYF0VNYAsxSkNbmkGMEcm?=
 =?us-ascii?Q?T2l34GQk+PGjcQU5NRfTUBGaGcPPkl+zRPOtqGhMHfWd9qqwRZOzRKu0KULx?=
 =?us-ascii?Q?9cKP3NBbxvSnFxb70q5Q+X88zaEcctAekLEHtC/wBsPK8X7t75SIMNqL0ZG7?=
 =?us-ascii?Q?WnSGqnWsdDfU6PoHXnNl7+jc37vqKo1Jc8+jBczTr1mv7NKE9kuo73bJcrAj?=
 =?us-ascii?Q?AscRY6YiTpgQtnI+b5qXL3DQwEIE19FzVG9J0pJSE61a8fRxvPs+SME386wI?=
 =?us-ascii?Q?0yekR9cdfB6zpAqtj+cCJgoBwx0t1RtfkvJ4NBi7sdh6gLADwAEihJJvwq6U?=
 =?us-ascii?Q?eYHoVxEs0DA5FnAU7YZzo7IE7Z+1qxdUT6sxks7jG9F3hH9DYbZBa5xb5MmW?=
 =?us-ascii?Q?t5LM4xIIVDCym8iJfcs8pdrb4nVpnd1LZZLO9+vWOXnfihuYXvPT1Xcn2Jge?=
 =?us-ascii?Q?09KB++eRcnpA70XXXCqRhLZw77EYm8iT3Z+Pfq51vfCC4G2sfRHFbhI7XRT3?=
 =?us-ascii?Q?i6XKSS7E9zupqeLxnFv3xWGUqAZpPy+xB96A94ymgGQ+Nr8G9vBew6yY+SB9?=
 =?us-ascii?Q?c7WsJ0tkcIZroKMSeiIx4PS7F1nPYnyIQuw0JqbZ8bIyA64XI9RZKhylXW6g?=
 =?us-ascii?Q?FOOI7+lf5SK7z/c//F2PH9EFet6E4GWmJOnBJ9GrXomi5NnI+SqkfGtMDq45?=
 =?us-ascii?Q?0clx9Avvogxgw/p2k9oIGLfCH+kiKu8U9hOWF79iAcEYz0FT0Zka1m7SSQvM?=
 =?us-ascii?Q?MYHEfvMAHryU0Zd+CwYEjKpbB1YEjJFkaXU75tR+C+9mlQIjyR95NkNxxpfs?=
 =?us-ascii?Q?2dOLWydOpEGSsgj6y7Y4gx37jfZ0AYxHGbSIUNWSujaZorX00HV8bR+7npQE?=
 =?us-ascii?Q?Bv5rtXFEPp1HN9iCd7Cj/tjc+pVb7CNPhZ4sPGA6QyI32b/1PGZfisVZFTHW?=
 =?us-ascii?Q?fVf6ZCa4IEhuZ90gnmpha/uRYz5APeqTyry12k602Lpa/x4ZT/2y9qxlCEzz?=
 =?us-ascii?Q?CHQpqU7M6hIOAVB7RWmGMqXiJBLwplD/+iPUk24sqA/UwYC0ieyV1crH7M27?=
 =?us-ascii?Q?31+YDrGw3xyLb94+CHiwxbK6CpqiX24ZCKA+sEsQ5IRf9io8WcIyrAroEwN9?=
 =?us-ascii?Q?QTJU2n83XP8DEiirYD9CZFrT/ZjObe9ARy/OXxS/IMPW6YiXKBKXlaFQegqr?=
 =?us-ascii?Q?RNvqZt8ox1VXtp2B4GaJXAllTzdkLNBK8Q9rPrSsAhvRh7Dzpw8jrvjDfdrP?=
 =?us-ascii?Q?O81R6UfXAsXvRy9usnxNJqQJ1JzSg0u8oqRur9lIX1tmfKs/aKp8U/ZuXNu4?=
 =?us-ascii?Q?7k5C6AJ3UPnxGTyza6IhEOkR+L3N/Sa4+0S+e9nktJPasSZ258cs0gO+vasn?=
 =?us-ascii?Q?IBiwx+oKICA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TmLbdE4UeIlF3RPHudm0mayuO3H+Wyw9PZIYE+Hd7EJL8NyUZAtZJ2YcbsI5?=
 =?us-ascii?Q?7DMxpKOZXEgOztqE9IyICbkjotbQNX+QYoQPQj+bGE2/xbUuDaI9kko/oNY2?=
 =?us-ascii?Q?x2vtYXkysZvK7FdwZ6IItx+Wwv9kBosCT/YaLSkPHqNzbKOz8ndag3kvYmkV?=
 =?us-ascii?Q?LqPoePFJYi40fNmY0ngafCM1zaHoelZSMaP6iI7it6KapNiYmxqAu99iJcy5?=
 =?us-ascii?Q?BThC7MbXmYBuuVkN+PX8ftboxAVA6w4nLIZ7Z+H1RkhZKucRV6zT8hzEt9SB?=
 =?us-ascii?Q?Rv/oLC8R2IOVdG/HzNRpJAUed5Pocz2hO/hB9tD1zeo3JHRT/rS5JyBG0XgM?=
 =?us-ascii?Q?DDgcUh+WUq7f+hY0gbuORPWBuwwe1WSaCeicCvqyYzIsUlL3E79QfAtVluau?=
 =?us-ascii?Q?eMeulF1dL83n9wo5QWu7AVoV6iEyooQfq2kMsYsWYW3Hv6cTnPEIcjVwjDE0?=
 =?us-ascii?Q?nswyPkC32/L0Tr8FqztURJAqZdL94dt/nDHOb6b5zx+0EW1FIe+jrBwDan+y?=
 =?us-ascii?Q?0woUUdq0iepN2u4fSjWnPXrnHZudKOXS6RCJlxAR/7IayX0Tr8mtTYHCn3l3?=
 =?us-ascii?Q?NKgkYQBnUySKkTeqMlK5oArOZZFin2N2HOLXA5YH4U2sbqAVBDOvuSulosRV?=
 =?us-ascii?Q?9BQfRuSWPnZY+Ex5MY7G+C+aWabjLoqcfZLFOfmB54uA89QPYs5bxfDIbpcR?=
 =?us-ascii?Q?XXS8fz6UzjoMXraJLO/ArtJSOmb0oJsRT7Be+DViHNmZLQ/hELypGgzgiB1c?=
 =?us-ascii?Q?R6TIayqHJknn3alOBk3Vp7JL5EWHu/qHtT7lUTkFOmHD90RIONFXcakl1vY5?=
 =?us-ascii?Q?d8rvykJZZ6t/FonlTMpErekZiRrEHwGX3q4cr+ms88/gTNS9cVHxnBs6WIRH?=
 =?us-ascii?Q?Fsm1+AOkJoaAcf1pEKwyRXuPNlnUUpBfIN77Ie531PI1xQ7m4O3cSLP6IAey?=
 =?us-ascii?Q?mjFqlHTiWVenyF1/g2Z4vTpeveCW8LZPk8iD2FtVB7BJYTzFr0ArtOOVtXmE?=
 =?us-ascii?Q?RewwJXGIxwTk3M7L5f5Q9FzPKgxX6MwNKko/1FY3eu9TKq7NZg2msFrTpZwc?=
 =?us-ascii?Q?RdBY+V05Br4KpwLo33r7WOVFMb/13PtHBQpYRzxpHd0jgLEbvZ1FPvHJBR7U?=
 =?us-ascii?Q?ze82rsZwuKSZqR/EtVhvrrhSHoBTLqj70ezCnoXYHU2tCVEyHeUAln6bZITT?=
 =?us-ascii?Q?0ro9/09rd9q/XHwdBAdRVYUqDZh2r5VBjJmopj8WWoH2OLH5/US/iEGnz6Eo?=
 =?us-ascii?Q?v6K+2M1++MdnvVm0oPg4BqSePT4WqKPdRFh4sE9P0Y4Fe1Tbz5KnR4YftZ/9?=
 =?us-ascii?Q?zTMoTl1Itc+z6jZhlXlNue8ATJs4WI32nPd+9mjG2mrZW7OAFpS23ABMRW/j?=
 =?us-ascii?Q?naQg+UkMl3Tk4Zsb7A1kuqHtIR32CITsS6uYJCvqwy6mb+jekFEUhMlvsyJe?=
 =?us-ascii?Q?nVE9gDz12hv9y1OIJ8m/3zY5Mioo8ffRcxxXVX4DjQcFfGSn9hh0osqCRAou?=
 =?us-ascii?Q?ODdS/bUT2OoyXUR9VJLOg6I1gBQnR3ko1TN8GIc9MJvoccjYumeeSkXbMY1M?=
 =?us-ascii?Q?p8R/rcJk+kvL2wqectBjiwmO0tr3bdr3HfSUAFQG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da58fc7a-e153-4dcf-e16a-08dd9cd28d6c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 03:57:08.9159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ahWo7Xlw6EM00UthVkvG021dY10njt3+Gs4ro5LVsPnJlYV4koc3hKHmRoxwL2+4Off/JsLrIliicG3w/NgLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8355
X-OriginatorOrg: intel.com

On Wed, May 14, 2025 at 04:41:41PM -0700, Ackerley Tng wrote:
> Track guest_memfd memory's shareability status within the inode as
> opposed to the file, since it is property of the guest_memfd's memory
> contents.
> 
> Shareability is a property of the memory and is indexed using the
> page's index in the inode. Because shareability is the memory's
> property, it is stored within guest_memfd instead of within KVM, like
> in kvm->mem_attr_array.
> 
> KVM_MEMORY_ATTRIBUTE_PRIVATE in kvm->mem_attr_array must still be
> retained to allow VMs to only use guest_memfd for private memory and
> some other memory for shared memory.
> 
> Not all use cases require guest_memfd() to be shared with the host
> when first created. Add a new flag, GUEST_MEMFD_FLAG_INIT_PRIVATE,
> which when set on KVM_CREATE_GUEST_MEMFD, initializes the memory as
> private to the guest, and therefore not mappable by the
> host. Otherwise, memory is shared until explicitly converted to
> private.
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Co-developed-by: Vishal Annapurve <vannapurve@google.com>
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> Co-developed-by: Fuad Tabba <tabba@google.com>
> Signed-off-by: Fuad Tabba <tabba@google.com>
> Change-Id: If03609cbab3ad1564685c85bdba6dcbb6b240c0f
> ---
>  Documentation/virt/kvm/api.rst |   5 ++
>  include/uapi/linux/kvm.h       |   2 +
>  virt/kvm/guest_memfd.c         | 124 ++++++++++++++++++++++++++++++++-
>  3 files changed, 129 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 86f74ce7f12a..f609337ae1c2 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6408,6 +6408,11 @@ belonging to the slot via its userspace_addr.
>  The use of GUEST_MEMFD_FLAG_SUPPORT_SHARED will not be allowed for CoCo VMs.
>  This is validated when the guest_memfd instance is bound to the VM.
>  
> +If the capability KVM_CAP_GMEM_CONVERSIONS is supported, then the 'flags' field
> +supports GUEST_MEMFD_FLAG_INIT_PRIVATE.  Setting GUEST_MEMFD_FLAG_INIT_PRIVATE
> +will initialize the memory for the guest_memfd as guest-only and not faultable
> +by the host.
> +
>  See KVM_SET_USER_MEMORY_REGION2 for additional details.
>  
>  4.143 KVM_PRE_FAULT_MEMORY
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 4cc824a3a7c9..d7df312479aa 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1567,7 +1567,9 @@ struct kvm_memory_attributes {
>  #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
>  
>  #define KVM_CREATE_GUEST_MEMFD	_IOWR(KVMIO,  0xd4, struct kvm_create_guest_memfd)
> +
>  #define GUEST_MEMFD_FLAG_SUPPORT_SHARED	(1UL << 0)
> +#define GUEST_MEMFD_FLAG_INIT_PRIVATE	(1UL << 1)
>  
>  struct kvm_create_guest_memfd {
>  	__u64 size;
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 239d0f13dcc1..590932499eba 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -4,6 +4,7 @@
>  #include <linux/falloc.h>
>  #include <linux/fs.h>
>  #include <linux/kvm_host.h>
> +#include <linux/maple_tree.h>
>  #include <linux/pseudo_fs.h>
>  #include <linux/pagemap.h>
>  
> @@ -17,6 +18,24 @@ struct kvm_gmem {
>  	struct list_head entry;
>  };
>  
> +struct kvm_gmem_inode_private {
> +#ifdef CONFIG_KVM_GMEM_SHARED_MEM
> +	struct maple_tree shareability;
> +#endif
> +};
> +
> +enum shareability {
> +	SHAREABILITY_GUEST = 1,	/* Only the guest can map (fault) folios in this range. */
> +	SHAREABILITY_ALL = 2,	/* Both guest and host can fault folios in this range. */
> +};
> +
> +static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index);
> +
> +static struct kvm_gmem_inode_private *kvm_gmem_private(struct inode *inode)
> +{
> +	return inode->i_mapping->i_private_data;
> +}
> +
>  /**
>   * folio_file_pfn - like folio_file_page, but return a pfn.
>   * @folio: The folio which contains this index.
> @@ -29,6 +48,58 @@ static inline kvm_pfn_t folio_file_pfn(struct folio *folio, pgoff_t index)
>  	return folio_pfn(folio) + (index & (folio_nr_pages(folio) - 1));
>  }
>  
> +#ifdef CONFIG_KVM_GMEM_SHARED_MEM
> +
> +static int kvm_gmem_shareability_setup(struct kvm_gmem_inode_private *private,
> +				      loff_t size, u64 flags)
> +{
> +	enum shareability m;
> +	pgoff_t last;
> +
> +	last = (size >> PAGE_SHIFT) - 1;
> +	m = flags & GUEST_MEMFD_FLAG_INIT_PRIVATE ? SHAREABILITY_GUEST :
> +						    SHAREABILITY_ALL;
> +	return mtree_store_range(&private->shareability, 0, last, xa_mk_value(m),
> +				 GFP_KERNEL);
> +}
> +
> +static enum shareability kvm_gmem_shareability_get(struct inode *inode,
> +						 pgoff_t index)
> +{
> +	struct maple_tree *mt;
> +	void *entry;
> +
> +	mt = &kvm_gmem_private(inode)->shareability;
> +	entry = mtree_load(mt, index);
> +	WARN(!entry,
> +	     "Shareability should always be defined for all indices in inode.");
I noticed that in [1], the kvm_gmem_mmap() does not check the range.
So, the WARN() here can be hit when userspace mmap() an area larger than the
inode size and accesses the out of band HVA.

Maybe limit the mmap() range?

@@ -1609,6 +1620,10 @@ static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
        if (!kvm_gmem_supports_shared(file_inode(file)))
                return -ENODEV;

+       if (vma->vm_end - vma->vm_start + (vma->vm_pgoff << PAGE_SHIFT) > i_size_read(file_inode(file)))
+               return -EINVAL;
+
        if ((vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) !=
            (VM_SHARED | VM_MAYSHARE)) {
                return -EINVAL;

[1] https://lore.kernel.org/all/20250513163438.3942405-8-tabba@google.com/

> +	return xa_to_value(entry);
> +}
> +
> +static struct folio *kvm_gmem_get_shared_folio(struct inode *inode, pgoff_t index)
> +{
> +	if (kvm_gmem_shareability_get(inode, index) != SHAREABILITY_ALL)
> +		return ERR_PTR(-EACCES);
> +
> +	return kvm_gmem_get_folio(inode, index);
> +}
> +
> +#else
> +
> +static int kvm_gmem_shareability_setup(struct maple_tree *mt, loff_t size, u64 flags)
> +{
> +	return 0;
> +}
> +
> +static inline struct folio *kvm_gmem_get_shared_folio(struct inode *inode, pgoff_t index)
> +{
> +	WARN_ONCE("Unexpected call to get shared folio.")
> +	return NULL;
> +}
> +
> +#endif /* CONFIG_KVM_GMEM_SHARED_MEM */
> +
>  static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
>  				    pgoff_t index, struct folio *folio)
>  {
> @@ -333,7 +404,7 @@ static vm_fault_t kvm_gmem_fault_shared(struct vm_fault *vmf)
>  
>  	filemap_invalidate_lock_shared(inode->i_mapping);
>  
> -	folio = kvm_gmem_get_folio(inode, vmf->pgoff);
> +	folio = kvm_gmem_get_shared_folio(inode, vmf->pgoff);
>  	if (IS_ERR(folio)) {
>  		int err = PTR_ERR(folio);
>  
> @@ -420,8 +491,33 @@ static struct file_operations kvm_gmem_fops = {
>  	.fallocate	= kvm_gmem_fallocate,
>  };
>  
> +static void kvm_gmem_free_inode(struct inode *inode)
> +{
> +	struct kvm_gmem_inode_private *private = kvm_gmem_private(inode);
> +
> +	kfree(private);
> +
> +	free_inode_nonrcu(inode);
> +}
> +
> +static void kvm_gmem_destroy_inode(struct inode *inode)
> +{
> +	struct kvm_gmem_inode_private *private = kvm_gmem_private(inode);
> +
> +#ifdef CONFIG_KVM_GMEM_SHARED_MEM
> +	/*
> +	 * mtree_destroy() can't be used within rcu callback, hence can't be
> +	 * done in ->free_inode().
> +	 */
> +	if (private)
> +		mtree_destroy(&private->shareability);
> +#endif
> +}
> +
>  static const struct super_operations kvm_gmem_super_operations = {
>  	.statfs		= simple_statfs,
> +	.destroy_inode	= kvm_gmem_destroy_inode,
> +	.free_inode	= kvm_gmem_free_inode,
>  };
>  
>  static int kvm_gmem_init_fs_context(struct fs_context *fc)
> @@ -549,12 +645,26 @@ static const struct inode_operations kvm_gmem_iops = {
>  static struct inode *kvm_gmem_inode_make_secure_inode(const char *name,
>  						      loff_t size, u64 flags)
>  {
> +	struct kvm_gmem_inode_private *private;
>  	struct inode *inode;
> +	int err;
>  
>  	inode = alloc_anon_secure_inode(kvm_gmem_mnt->mnt_sb, name);
>  	if (IS_ERR(inode))
>  		return inode;
>  
> +	err = -ENOMEM;
> +	private = kzalloc(sizeof(*private), GFP_KERNEL);
> +	if (!private)
> +		goto out;
> +
> +	mt_init(&private->shareability);
Wrap the mt_init() inside "#ifdef CONFIG_KVM_GMEM_SHARED_MEM" ?

> +	inode->i_mapping->i_private_data = private;
> +
> +	err = kvm_gmem_shareability_setup(private, size, flags);
> +	if (err)
> +		goto out;
> +
>  	inode->i_private = (void *)(unsigned long)flags;
>  	inode->i_op = &kvm_gmem_iops;
>  	inode->i_mapping->a_ops = &kvm_gmem_aops;
> @@ -566,6 +676,11 @@ static struct inode *kvm_gmem_inode_make_secure_inode(const char *name,
>  	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
>  
>  	return inode;
> +
> +out:
> +	iput(inode);
> +
> +	return ERR_PTR(err);
>  }
>  
>  static struct file *kvm_gmem_inode_create_getfile(void *priv, loff_t size,
> @@ -654,6 +769,9 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
>  	if (kvm_arch_vm_supports_gmem_shared_mem(kvm))
>  		valid_flags |= GUEST_MEMFD_FLAG_SUPPORT_SHARED;
>  
> +	if (flags & GUEST_MEMFD_FLAG_SUPPORT_SHARED)
> +		valid_flags |= GUEST_MEMFD_FLAG_INIT_PRIVATE;
> +
>  	if (flags & ~valid_flags)
>  		return -EINVAL;
>  
> @@ -842,6 +960,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>  	if (!file)
>  		return -EFAULT;
>  
> +	filemap_invalidate_lock_shared(file_inode(file)->i_mapping);
> +
>  	folio = __kvm_gmem_get_pfn(file, slot, index, pfn, &is_prepared, max_order);
>  	if (IS_ERR(folio)) {
>  		r = PTR_ERR(folio);
> @@ -857,8 +977,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>  		*page = folio_file_page(folio, index);
>  	else
>  		folio_put(folio);
> -
>  out:
> +	filemap_invalidate_unlock_shared(file_inode(file)->i_mapping);
>  	fput(file);
>  	return r;
>  }
> -- 
> 2.49.0.1045.g170613ef41-goog
> 
> 

