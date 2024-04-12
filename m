Return-Path: <linux-fsdevel+bounces-16823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4ED58A3496
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 19:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C702284749
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 17:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D182F14D2BD;
	Fri, 12 Apr 2024 17:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OmF/gApu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFC014B098;
	Fri, 12 Apr 2024 17:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712942416; cv=fail; b=jt8ynle+ukhuw1N8AX92auOP826yIOahm+LLQyvxnB+6n2/nPkf7sAdE8ajC/MdV7uajisVE+GywubLuhGnDVeTF0Lpw5bVZL2Q9tJLbGhtbgqvE+3v7fix0ktnqZ+zOCkeqKFA5EfP+2mmAPn45VWqeX6OKmUHrfLUVWO7/N1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712942416; c=relaxed/simple;
	bh=sAxqs2m1ol8ML1gQffVWq0NFT46/+O58gH1XvRoUVvw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VBAqGDcvwDZlqCyFqHCvng9pe9QX2xRE1AuRvWhnrEH1owq8ESg0t30gA+bDVjp+lZViH0ONc08B9FyUQoekXDXAyGCJbc0dTPPYHPfBFasJMgVdibfGLkQrbBqtO2HomsIQVf9H8+XHBR0mV3HYnpjES48LmecjZgtzNrStSAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OmF/gApu; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712942415; x=1744478415;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=sAxqs2m1ol8ML1gQffVWq0NFT46/+O58gH1XvRoUVvw=;
  b=OmF/gAputfvY8EV8NLKfFlWIc9n6hfrz5GZ7/iyOEQtrTNfFwd0DEQPU
   ea5j0prOkN8eJc8a3drJsd9/GSV6rcHPajgOx24GCjkD8EUNL3OEHjgnN
   y5jJtI8NU3DcvQq/qHHu82wsSLSOv9uDHQ0qU+Edu+A1dUfhYlaotENBT
   wzPzN39udD95YtadDlrK+5tfwO21PfkovU5r96678HBT3WQpgRt+eiuNm
   fSHisJ8PH9jkEJECZr4VYvsjdI2/5VQb4IaRBuvqu08O1lwg3UmHAvQc5
   I9xOQXlaOQPAA9cjteKb2Vt6AZmHN7RIShQH2EETGywLGi+6dBGszdjrl
   Q==;
X-CSE-ConnectionGUID: CayXw8DjTeWKNYQoaIqbZA==
X-CSE-MsgGUID: gprObHDVQa+JPXyoGb6ldg==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="19800981"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="19800981"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 10:20:14 -0700
X-CSE-ConnectionGUID: H2O5VX56Tr+UmThlBoIf5A==
X-CSE-MsgGUID: 09V3DO3rQ1ucGH4RZJ9xQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="21283087"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Apr 2024 10:20:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 10:20:12 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 12 Apr 2024 10:20:12 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 10:20:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOg2BkNkto1uB6zdRGJk+DcsoWYpweOPrO3HHRdtRC66q89bYMRRHZ+86R0kHteXNo3S08JE82tMe7m2SNP8wTda4BDWYSDdZUulrDdYDs15lGX0K/j1XHAhbP6C1msOneXM3AUsvcKQLirsM8j9zl3BbUYJbgiGf3rCbqxt82I3YKVQGVqIccn3XdVP+/krMOjZvJgCbEtfAG6xmiIb321bIXTU+1GVI7fUiNISJiF8nxbeY4oc/H7YWMJn6dfBlNB5411B6EFTMCKXtxLf8aMwF8NLlovO+3qzD1UTV77kbC9z7FAZqXJ6UJN1hhpc1v7FG5MZaMGRE9i5Fd6O1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAxqs2m1ol8ML1gQffVWq0NFT46/+O58gH1XvRoUVvw=;
 b=WtyIbdLpRLQR4TVeoKoPs97m7T6BqzmLb4FVcBKwc/M2QB4wLABWqlBuaN6H1iWyZqPxP7ideP/bReFbNTqLErmBM1Q3GEnTO5ie/eNZSne8sIlMC1qJbPHsiml7Mp7Mpx0yREVDGIQ0SzE/LxUdhtt8IZLE7APrzVsIB7zALRVgTCrcXW4RZVvaCTJvTLCH/AF+KOqjChuQ6LVo1wFfjql+6FQL0hDjAIZWTC3Uh56z657tTB5Hgoh5vJTbdS2kJFdzNVnOvA9vwVZYw90YLkheZy08SNXeRg5V3S3l06ShCYmuyevW6cvo6T/0fhNbFPslnUP2lP3ZgiHhsHMmyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB7562.namprd11.prod.outlook.com (2603:10b6:510:287::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Fri, 12 Apr
 2024 17:20:10 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7430.045; Fri, 12 Apr 2024
 17:20:10 +0000
Date: Fri, 12 Apr 2024 10:20:07 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alistair Popple <apopple@nvidia.com>, <linux-mm@kvack.org>
CC: <david@fromorbit.com>, <dan.j.williams@intel.com>, <jhubbard@nvidia.com>,
	<rcampbell@nvidia.com>, <willy@infradead.org>, <jgg@nvidia.com>,
	<linux-fsdevel@vger.kernel.org>, <jack@suse.cz>, <djwong@kernel.org>,
	<hch@lst.de>, <david@redhat.com>, <ruansy.fnst@fujitsu.com>,
	<nvdimm@lists.linux.dev>, <linux-xfs@vger.kernel.org>,
	<linux-ext4@vger.kernel.org>, <jglisse@redhat.com>, Alistair Popple
	<apopple@nvidia.com>
Subject: RE: [RFC 03/10] pci/p2pdma: Don't initialise page refcount to one
Message-ID: <66196d4726670_36222e2942a@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
 <a443974e64917824e078485d4e755ef04c89d73f.1712796818.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a443974e64917824e078485d4e755ef04c89d73f.1712796818.git-series.apopple@nvidia.com>
X-ClientProxiedBy: MW3PR06CA0004.namprd06.prod.outlook.com
 (2603:10b6:303:2a::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB7562:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f41ee61-081a-4b5e-55a2-08dc5b14ce7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZO+U0yLwqxwfYgq1DGxcO6IfKGZsTyYsDRugPLrAJj1qxc+Px+CaPyGCXeH58Gdnxh2mleFCZCpAMNBbiT0YbqnjqLbrrS7Lc9yIKAk/a5DuZbS9x78IqtYlpo62Ss2y0xa/meJ7xq7MsnXTL9F0QC4Fn68tnccE95w0+LyZeLDHdnpMQuK18P7r/QMPOB70Ro16QqLis01JAM9YyEB7VafzoWAd9tO5r+jhr96ZiSqqt20chxmt7sNILk2qTuBV24txzC1ITVsruM9KZ7NWGmf/9pJeA6+sRK2LV+m8ZSSGq41S2k0W/9WQwJsxlX4CuZolB5eTSjcnA5ZKMcWn3NAqXn4f2N0QH8h/9zAiMUL01jvAve/ewqh7weJgeNVZKEHiy/gAV45s9m4i14XGjfdGQpjwzuxhZK20cQhwU9MgcThJaDJyZvZeI0jLtrGQ+CbpaS9wpOEXOA4smFxyrjtiMCamiqItapKtKM4gOnxGcBtfOyRGnOjaWb3ZOg/rYAGK1FDvJwVr4Q0ZQImtT2Eex6YtGtZsxQTA7me5qURxZ+w2ZLEE3LwuEy0CbSCD+i8n7LvtHPg47jZpCrnSWRswWngBHc8MY2CeW7YROf8QFhBxOeK9VvO44TJ+/IeZZp3T9a2vZpaO1DbHuXsjLxxdp81XPQ7AF5ZOD4Qtvwc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K8ylK3EdEEcjkDoWQq3nN/lzP0+Vk61mFO7AOAuovdmddVVJRdMKnbG0bUfX?=
 =?us-ascii?Q?Drz39rYP3UnQ5EU0qg51o/CfoYjv+QUBH+Ti7cmO/4zjc1u5U25FUW3RMb8/?=
 =?us-ascii?Q?WBuO9yjICzXlxzqAL13w2WSflV7MOy/fmENyHpDtVmwHTxOQpZUmENZkqNJw?=
 =?us-ascii?Q?sMxDmHOHIU05mFkWi4mDus70XhXuuJf4JaygCjc1qcvQyFOKhZuXH4Nx4euI?=
 =?us-ascii?Q?l6p2uBmGenDNV9DJDVAsfKwY1atX/t8Mr2cX7AO/NeKPZncMCDIaB5pI4J76?=
 =?us-ascii?Q?xlycbB/C4BN6X7bVnvqprnMtzmNHoXt6g9SLFELBJnX2s25pXMxao/wdyVe9?=
 =?us-ascii?Q?o6Rp2aczqZoY0+d26R6Vnlo0f0JjkOcDpd1EN48tTfRdKt5udHUyuoovBqyA?=
 =?us-ascii?Q?nN5CQL2Zr65NBCihtafQ7W+UHcxsw3lf2QCcvRAwLDnkHemLo67HuBk7tVRH?=
 =?us-ascii?Q?4V25S9amGJ+gp7j5O/A0Cs648w2KTKV3jHD/yxKOZBHSRBRplMwWnaF0BPWL?=
 =?us-ascii?Q?rtt5hHfPyGz3bWqowdkU2djmbugi3wr664+a8tX24GtNwzF9vzrg+KmQpX6N?=
 =?us-ascii?Q?KfU5SFTZ70YmIHA8LDfgCHxDi5DMaq8DCO7cXDeT1HwwqS0/n18wKu9nGMPc?=
 =?us-ascii?Q?00P0r/+vIH9DiQe+IrV55fk26G8OvyC8/g8H3Fp4V0ONemLBiaqtR7/m1MK2?=
 =?us-ascii?Q?EZruR+9dP3NaYM70aiyLgRvau74g9e4K7a3o9hVxx8ZEASHve1GB/rXeSvfa?=
 =?us-ascii?Q?8zzJ9jORBgtxI1wZ4mgRXcInG5wdES2YYWDlB3pkx54YcTYoTIhVjo8CdFpB?=
 =?us-ascii?Q?Jp2KnsvRfn2OZrm6cu871kXK/BiZ8OrsKFFTyN9hMciZTr6zjxSKMMIvZsRF?=
 =?us-ascii?Q?ZNZh/BoY9bYDfBL+xugAUXAp1w5nt6XuquEgGCeUHFuAQZCmT3PUqdUbUEaO?=
 =?us-ascii?Q?+3r6xfaDBCZ7GCA1pd5cDp5y8aIatzGAp5JWsBNFAQg5RjjFuu+fJGEB8d0b?=
 =?us-ascii?Q?v9WSDNFNmBwoCMriO7OapE5ebwj7c20BaURpHnivaToJDwLYAcm9A/zO6Bbl?=
 =?us-ascii?Q?ieFb6It1jZxWNbbR+E/w2DrYAw/isZIRzW+C/5TYuPmOnZ2WBrqFDkIHVGlU?=
 =?us-ascii?Q?zeAMeW2kTWLRQkxxjN3ZTfM1/WFDpnBpOGu24Ok3QgLJ40Ufht32M+UzZ38L?=
 =?us-ascii?Q?KjpnT6UyZExQbbUcu5H550bFARBBa4Ki6BEu6joX2iT22IM0zCzdb8pvl7Rf?=
 =?us-ascii?Q?RO06trKWaaJgeyTrCsMn1+97fKQweD6utpM4p0yxXVHwmc4fA/FPn7LryFkU?=
 =?us-ascii?Q?4Gl07hWm0ZsAu8N+c2Pc0rM2B9SpQd93jhNNRYIHjmiOox6kQUZrJWTSCRoi?=
 =?us-ascii?Q?4iEMIqM5atyhPB52YFgVzqcUpHtyIjbevk0TTKR1VBve4hoxrKCt44we9/pk?=
 =?us-ascii?Q?Bk6G0vE1KQX5kCmFhTgFapmoyrfUFd51zxhT/bHyMCIpcbs5G8gwjGbW6hck?=
 =?us-ascii?Q?P8+Ga33jec3lDk3aVch3YGMsBWxFRtG94cLepqICWruJqzyjoj0SylsCWKuV?=
 =?us-ascii?Q?WjfLcZ/UONpy9+FR2IdPehvDNzM9mpp9egox3iROP5QjafzJq1PvtQ0J0xb+?=
 =?us-ascii?Q?qQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f41ee61-081a-4b5e-55a2-08dc5b14ce7e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 17:20:10.3751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+x87c+ZMwfe8DqOGhoaQAIIxf9vlKj400pn0zPfMcpKOR0sZUI0f8mzPmW19SuEePEaon+33QIxUX0lGRvTEpA5pGBVXKh62e+svuipF/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7562
X-OriginatorOrg: intel.com

Alistair Popple wrote:
> The reference counts for ZONE_DEVICE private pages should be
> initialised by the driver when the page is actually allocated by the
> driver allocator, not when they are first created. This is currently
> the case for MEMORY_DEVICE_PRIVATE and MEMORY_DEVICE_COHERENT pages
> but not MEMORY_DEVICE_PCI_P2PDMA pages so fix that up.

I know you said to hold off on looking at this series until you fixed up
the kernel assertions, but I would not expect to remove logic before the
replacement is available. So this seems to be in the wrong place in the
series, or am I missing something?

