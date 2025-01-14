Return-Path: <linux-fsdevel+bounces-39107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17037A0FE71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 03:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D46933A5837
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 02:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB10230984;
	Tue, 14 Jan 2025 02:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FMxkSMZ+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DE73596D;
	Tue, 14 Jan 2025 02:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736820367; cv=fail; b=OQ//0o43V1GgPxUzfhUl3lFnS7/M1ktJXpkeneQChWOJnQfL1uQlBrIs8C1A+aBPIUkkQZphpq+cYxVHJJHEDil9ZxETSMve09anSr7guZtKgPftzjvyGZ92PUk5iazORIHd5Y7lvHkgkcGrVOGh0ZyaCXmPxbojfaDE7VYXPIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736820367; c=relaxed/simple;
	bh=3mz+GUpdna4v37XcPOMQn09FpqEBnSIMzEp3ye8uJv8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RTGaJRGuhGWzkYbP6g6ANtNlGiMHghi8LxL8C0fepta3eo2zYSCtwtELtgCFVC3/STobPSbUBvwtXJb8AGZpj/0+QdmGTIlNDm0DW3g5kd8auJTnv+uaePvDQMe/NVPSkUbgpmGxzDCdpQpkHurQnAuS0Y6pInA4XEM4+nkTDs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FMxkSMZ+; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736820366; x=1768356366;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3mz+GUpdna4v37XcPOMQn09FpqEBnSIMzEp3ye8uJv8=;
  b=FMxkSMZ+OizoVEq+XJh538C0N4bHhQ9x70ddCvFH+MpRz6npcDorBRFv
   sXFldpva/SbFvLSnwAkD+5pKiEInJZ4r4WKSqmimZZY6GssvEYx9//gSB
   LzUKIiyKJsTqUAzeHpV5bgra6Vm3+N5cRWoIyjhpKI420bdrO5BjE2IkU
   Ec7NZfeHGbYip7L4obeTtiMeRBMnDx0aC7rgk+Y+WdWhKB+q48NHcF7xc
   +zXApxZBDFbiUoQ7W11/4gOcRefdwXtjwKitRKZ9QGUQAsnEvLg2SDxWu
   t46vuKx0zPj/A6Pf1r790EhkbhEQ+nXvHaNfCu2GN+uNM5tY0X6EL396g
   g==;
X-CSE-ConnectionGUID: TPjZQz66QFiaHDPpKZWXmg==
X-CSE-MsgGUID: rUChWMYGR0eg3zS2rOSN6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="37013543"
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="37013543"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 18:06:04 -0800
X-CSE-ConnectionGUID: YVBejp6dQbGuGU41OHDh3g==
X-CSE-MsgGUID: SgxJxzTjR8e95tbghloXAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108718707"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 18:06:03 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 18:06:02 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 18:06:02 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 18:06:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YhxvjcoWKHQQQ2AHDrtm6LvoBGtDKvYBuPg03aysbhtrD5ymdIO2Uym3REXI3zZVLki3PbXwguXnzKHzCDpbdFdhkCFt2JfnzF5vRKxbcdmNBYFVMM6hmtw4OUZA1IupQ47y2L9obggDeYsj0BNtWctcd1l4yvlhHPPInPDmgEmaRcQJQA1MH0MdExpn+IJBtqhXxdei+UKf04LG+Qz/mnZsCGIwmEoQQRnDdSRRqi65FqWZtp3SqWL0jU3Obga2FNHsmLLpOTGXnYooffRpfR4x4SZ0UGp8OqnPJiO2KWZuRgEEKlcpfVViaij20u624tmiAdm9sCw/Z3HdDkQNPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avQmPXU3jxYBmhipmsCZPcIgW05rJBp072Vnqpg4L6M=;
 b=NigzofrfqPDvFVDTue7Om6i0oGhnRghhkDNAOQRhvsNy1vXWkZUdxerS9uNsCpIXBxRLt6nZok49C7OPJaGLvLHsNjGaTOqA46bvcYcotE8OUxbpL7DFk/ASOzV8t3i5nrBNoexDmTsW/SzYlWv0ygyMZCa9RB61kqUrc6UH3cNbH1cbbUiMAcGwSyDAQQ6zH+fp7/hBtE3+labSUJ9ecsLQ6v5oPRu2FwF81oe40ffwR5PVr9T5zDTeJUUY9avfukGwamQiztLNRU1fVvMCa+9s5irIoVWWk0l+SuuJVuhWLx8h6G32T4GErG12sJ8Xd2ylWHnBYWvFH+fzCs5hDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB7781.namprd11.prod.outlook.com (2603:10b6:8:e1::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.18; Tue, 14 Jan 2025 02:06:00 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8335.011; Tue, 14 Jan 2025
 02:06:00 +0000
Date: Mon, 13 Jan 2025 18:05:56 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alistair Popple <apopple@nvidia.com>, <akpm@linux-foundation.org>,
	<dan.j.williams@intel.com>, <linux-mm@kvack.org>
CC: <alison.schofield@intel.com>, Alistair Popple <apopple@nvidia.com>,
	<lina@asahilina.net>, <zhang.lyra@gmail.com>,
	<gerald.schaefer@linux.ibm.com>, <vishal.l.verma@intel.com>,
	<dave.jiang@intel.com>, <logang@deltatee.com>, <bhelgaas@google.com>,
	<jack@suse.cz>, <jgg@ziepe.ca>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <dave.hansen@linux.intel.com>,
	<ira.weiny@intel.com>, <willy@infradead.org>, <djwong@kernel.org>,
	<tytso@mit.edu>, <linmiaohe@huawei.com>, <david@redhat.com>,
	<peterx@redhat.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxppc-dev@lists.ozlabs.org>, <nvdimm@lists.linux.dev>,
	<linux-cxl@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-ext4@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
	<jhubbard@nvidia.com>, <hch@lst.de>, <david@fromorbit.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <loongarch@lists.linux.dev>
Subject: Re: [PATCH v6 17/26] memremap: Add is_devdax_page() and
 is_fsdax_page() helpers
Message-ID: <6785c683ef691_20fa294dd@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
 <99041691148ed3ef92546aee0dc0cd78ff143ab1.1736488799.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <99041691148ed3ef92546aee0dc0cd78ff143ab1.1736488799.git-series.apopple@nvidia.com>
X-ClientProxiedBy: MW4PR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:303:16d::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB7781:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f7e530f-d557-48ef-e3a0-08dd343ffdf2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GeWsDIxTr9li6xhn2S5QL1t8HwwJ8i+I7FHTwNCOZV9XZFT6hw1D+2Gwg/iY?=
 =?us-ascii?Q?8ldVxedvkOCGqdnqfN5hAiHLpQAiBwwNgGnGo6+3gU88iuoLiwTDhmD3m13g?=
 =?us-ascii?Q?QH6fTGD/sr3kbMNPrHoQKeJgKpEOOfvYSXGw5qr1PrWgpzOgR1iWSRUmWqD9?=
 =?us-ascii?Q?HmS7WitsrUZ0TzhebQiGXVUNq34Gsp5NCJW2INaTf1a863N45I9KREIXJh3B?=
 =?us-ascii?Q?zbbDcWzKS7btrcVAggLAbDeF3h8qmhoirtyCGwEHURmwSvTkW0aIWqJgXPNQ?=
 =?us-ascii?Q?bC9e8BhcZG+laf5KgrSHap+9wmtSywF8t9mnwTEQZRQiZdws7BAfKngoDWyR?=
 =?us-ascii?Q?ABDiDCV1XclO603Psn0HKhJkZmXAM7D/gkNQNiRjHsAQHR+3Le1ZWif0AiST?=
 =?us-ascii?Q?EzXNOjs/a7oHeHIcPWCcy2HQpWAThHGmsf2l0vk9MijKuiOGw/myBo1TCCvB?=
 =?us-ascii?Q?khK4UexQ1eSE5IZ9ZEMmRYqlzNxruA7tckoVVagNEMCxLmp0g4JU4+NIk+H3?=
 =?us-ascii?Q?tTWXvMBehykjuirwA+tXWDfRiBepI6KxYBw01kKizC9BJ70hGisDSXG7FGo3?=
 =?us-ascii?Q?YYThmgOeayzxhrNQPsaq7UyIR/4jGn69x3QI8YVV5+/OngTxaQzFeN6nVuWg?=
 =?us-ascii?Q?tDcDLKVPTE713HU9/IzSO1m8Etz4hkNA312HqYejlkTchXY/KYJHZ6O1D+3M?=
 =?us-ascii?Q?PNss8KbnOaOY4nheMlnpu7ldUDN3/rBLfWoFSnObodgqsuzmzghHljNOz56y?=
 =?us-ascii?Q?s+zlIdzoyF5KMEzMidMvh1adP7avHL6HV6k3JhUzF8JIVXjPuJSosVB9pjKk?=
 =?us-ascii?Q?CvLjU1qZ3hHUtK/F5Xiv7vhETgHJYtDoguj+pv66PPJkitLwTSVT/CurcPsw?=
 =?us-ascii?Q?PdRkQShpb89Ctrp3fdEZiJsyXh+U8edm1aaNFcBJHzDufomGFk3Zs0KMwwTd?=
 =?us-ascii?Q?fA/F6n+/ekYUv98pwIFcFLxXHJuaMHKun7pswMwUq38iwZNxkc07/e+7HoAP?=
 =?us-ascii?Q?sjcRCU1u8ObeKUXdq+YTG/1n0GXuAuJ5Be/WmYZ+NuWRNNFkBxMtD3EA2cWI?=
 =?us-ascii?Q?mXaUY++RbXRsJ499mn8+Bic9zcKUrluZ/mwxOyWIbrz5p+GDKkX0BPrrNZ6q?=
 =?us-ascii?Q?26d3t9MloC4H37EmNV8EtciFkaHJVRCASWtDyzeAKojlBv8LhWZCMOa+wUVI?=
 =?us-ascii?Q?kJ1+rzFPZ8VZGyagTg3d4ZLfTC7/94/YqGLmicMEq+f4nm7HbtOJe7Qt1XdD?=
 =?us-ascii?Q?R3NnmD3qR4n1xU9ZYYgKs/qtH3pFq6W5iQAIJCxkOHRx3EpPeIvgKZa304+2?=
 =?us-ascii?Q?/Mie87/+D60rmvQVqMGsFf2VULHEHgxxc4egtPIY1Na/118K0zID0jq6acZ/?=
 =?us-ascii?Q?I1z1aZsiVbMOUrJzKGpzQM0/Z1Wo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GTPwsB+6P6UL6PfepUwwJS0kMAGRxQwKC4DXPKayYepRrHla5gDxiiz66cmC?=
 =?us-ascii?Q?IpKnGTrnpCObo52kEiz9RAEvOaGyvonlqUOzH4xb/7hK/R2H1HeTmw7HITbZ?=
 =?us-ascii?Q?bIUOhocPss/3XoX4dcomeC/0WNSf5UoEvCzJa06zRkkBp+jMawLSN2D+7YJt?=
 =?us-ascii?Q?7J1vYFA0xdJjh1ip/EpVec11TzJ9VGpEDzIpwmq68+hVn45lmjAsh2+hW7Pr?=
 =?us-ascii?Q?kOWVnR7MnpuNjApTJDsz3uLeXC4Xu1XwaWvE2T6UWPrNZuhmF4AzfXiPgll+?=
 =?us-ascii?Q?HoHbHY9X4kvAyJQPr+JsGvtN2peOmEFoZb5kXDtDiUhWT+tQ8b9WC02JS/Hf?=
 =?us-ascii?Q?4wvJy3/cMZxjBf8dba+ni2cA0ZWAc9V641iLijTMGlApxJMWbFaD+bmQWx7u?=
 =?us-ascii?Q?KhIHA9iGQY42GMJNME0GS4b10GLViZuTonxY7ga4SqDWy30H9laxRU8Of/dh?=
 =?us-ascii?Q?Q+tp5TyPqJxRzAmxWWTUTcQGh+1G4vqfbPfwpUF8AH7gSAyeuyx54s3eSq16?=
 =?us-ascii?Q?lNQFESxeLwYZPZMxuZJ2TY3mmKr4lhIjAmqaux1DDk37m0/L3rgvQd5EpEVF?=
 =?us-ascii?Q?FktciOC0WPWlgmaef6anSKwE6X+SLqhOwz2+MR9IpihrdZXCRGhlQ8Ziww9g?=
 =?us-ascii?Q?JwdIT1GxKHtlW734vLmgM2ierK4lNuYagdM92Jbjnph0RtJloJK1yEy/7+fY?=
 =?us-ascii?Q?6jlsiPzxOj+G7rB8p3aVpAca56drjT5Zcz0kt39zn6jJiC4eRn8r1T3Jx78V?=
 =?us-ascii?Q?P82mLqpyoqFcrgOWmLZuD/qewcMRUvr2/tVdIki8T/NkMnj+cUAAG1Msn5oJ?=
 =?us-ascii?Q?xf/KaTsiFQvu/ys39LWOhd8Xdq/qb8pXGCRax0RzTLfmx/1aZEe7gXQ0ji+I?=
 =?us-ascii?Q?oZIc4FoXRZFbQJGGTt45C/Y8vOv9w1625lUBHWf0nfytoCcjZoD1a8vxXDo4?=
 =?us-ascii?Q?nIpe0RD6fTIlh4WknHkOHxfl+iv/GQOmmBkxa4whKlU8IBgARxYhG8OX5Bip?=
 =?us-ascii?Q?ikwu1ZxJuiwRa+J/ysI3ETbGxBlX0wioF/673CwPrCEK+Liaj38smQQAe18+?=
 =?us-ascii?Q?MmA4GQKaPh/SUYyNFgB7CT4JeGNLw0wCKB2dmJ1p0N1MXZGK3drFr2rxrYOZ?=
 =?us-ascii?Q?izbHLaLQ62f3281J6GBhy0cPLrEkJCYRFnGUMn+BFCnSgSzbF/bFtM73h/Bt?=
 =?us-ascii?Q?VVjKCsYNzPIIemA6TKHAREcca/WAH/2oAk8yayprgT/iMnx2tji2O5T5yYNx?=
 =?us-ascii?Q?9a5IXGnhvXCs3PgEsGBlSQSUq3DOqgQG7cW/ItpXx1ULhsrj+S/SJn0j3+5Q?=
 =?us-ascii?Q?1R74ncoxrhiRaffqTcpDYI7COf9iO/AI6fUUT/ONhw6kGwVrlmII5CMLokaq?=
 =?us-ascii?Q?e+iNbejlYPM5QF2OCKU3SGH5TxWcHNg6mxDEmPys0/ZudeAOTDji/5AAmVbe?=
 =?us-ascii?Q?NMxxe6jy+LEMrYLU2n0ztYXUYuaeTluVt/8Woy43tIBo4JRetMuAJxuilLBw?=
 =?us-ascii?Q?YPFw//LRECqY90QPmOBvDO8bX8WFmgXJUm+6zqsKg2AsqYBhxPtZi5BLOaNB?=
 =?us-ascii?Q?Ls4O3Vc9/WcyejACit9wPgkUltNO+iqezwjAwAo5u+zL2acD/7yRh2wzfds2?=
 =?us-ascii?Q?uA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f7e530f-d557-48ef-e3a0-08dd343ffdf2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 02:06:00.5985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nMIJErFOvQx2/jXSNhpSK/AGHgBP0In6iy/WqL0S8LlJDiipau+hGLvXwKD5EIMh9CsvOCQfKopbTcqbnope+g2I0cdBQjHKbGtS8Y9Fb5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7781
X-OriginatorOrg: intel.com

Alistair Popple wrote:
> Add helpers to determine if a page or folio is a devdax or fsdax page
> or folio.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> 
> ---
> 
> Changes for v5:
>  - Renamed is_device_dax_page() to is_devdax_page() for consistency.
> ---
>  include/linux/memremap.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

Patch does what it says on the tin, but I am not a fan patches this
tiny. Fold it in with the first user.

