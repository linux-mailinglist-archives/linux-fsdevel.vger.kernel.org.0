Return-Path: <linux-fsdevel+bounces-40789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A9DA27ADB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 20:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69C12167D11
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 19:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52ACF219A66;
	Tue,  4 Feb 2025 19:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gWNW5B9d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177522010F5;
	Tue,  4 Feb 2025 19:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738695983; cv=fail; b=nnLQfaMU6Qc7A2NLsgiHACbcfFn9/zopR32BLCQDXiDAtlqyOVXWo2cRtO+6wewZ5dqhDDKRlHnV3gTfDWfijg9MN5bJIQ4w8eR0o9aBFQLpv79RMmMA+4lD6p1xB65FTC4UZ/ARPk8jNP3qoQ9Y0Zk0xLlXtMqP/Qux+zpkdHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738695983; c=relaxed/simple;
	bh=cM7MGCNmgEicKq6tPE7BvkQtbVVInIiUj+wIq5lwFyA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i3zU1Rvq0hoXiFnjvCtg9lc97HK52Ftf3FxX/K7Yc8/5+KU8S/41/n+yTgEABP7bSVabK/YkzMUdc5l+UiINwlcU9QAx9HtHgPzOFUZtNaothjbgZAXcjp7gZchlupCsJrTytPmFhythvHGEhQrTxeBNNvFTIAJnJOLKkaikF2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gWNW5B9d; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738695982; x=1770231982;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cM7MGCNmgEicKq6tPE7BvkQtbVVInIiUj+wIq5lwFyA=;
  b=gWNW5B9djg55jkeqLyHaM1WMZvg9cfGoye5EN12S4dkouuDkjqR6YJsO
   shQ1V7Zz7XIVNktQg5RpRqX0EAVEz4eNIAN5BNbDQblDf99KOzDwR7LGU
   DgVyYXMCprc+mJat92eXhAnffZbyrI5MhddYCfPC012ZrhehlskDRBqJB
   HOwhyd52t/8Iu55PTJ546xTVyhx+gbQjEmt8XvX+wch0us88hN3sNYYxj
   +WIFFDCgDeTl8oKIIOstH1D/ZcH3TcjjvH+fu67bGzOBH3TqrSe/EKQfu
   0/hO7h0zbPbZwH9L9UaJ47SS/ldP3Bt9BpzhU9mRPeREcvf5TsYFodN19
   w==;
X-CSE-ConnectionGUID: a0qrmAfUQHaF42XjdFSjQw==
X-CSE-MsgGUID: bL3/RP0NQ2uWAHQ7mw2F3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="38940926"
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="38940926"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 11:06:19 -0800
X-CSE-ConnectionGUID: cgVrTHTLT9Gce/m9jLyLaA==
X-CSE-MsgGUID: EU75cmYRTcmdII97AMI25w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="110457826"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Feb 2025 11:06:18 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Feb 2025 11:06:17 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Feb 2025 11:06:17 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Feb 2025 11:06:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P5QP9gGXJac5pfw6erGVuge8VUwHxdUDOnIBNxU2frBt/5WOAzhIAUipGiGxITFac9pasUozGRYdrs3fHLvz8jy2w0ipyoYAHJxRgWoVJFOkcLdla/yR+4DN6IKeQaVVBPUTN09EaBJEZkF0ktYeKXSnQO9Eu4prj0j3hLH3E8M7ZOf0mHtBvY1TB2lW+wSpslcbObMioU/hD6UsVM3iPAhztDZ/mV0La3VXWrc9Rp9rICLs3Vbmqwt8g96GsONM8NJmQAvfLrUETw616WNxhmXENek6OO4fOco4j7vSjIAPG4AJH+R0SaWMasjY8ohe4H+afetqU+XQIt4GZMsAQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHL/St7chsRUkcMGx7UK1wa5r/a3m1wpwlC0b7MYDoc=;
 b=PEIJtz2fq2f3TkWZZ43W5uBljE7Iwze6Bs+vdb2G7AH+P/kbY1I1fpJl8Xdp5ciDxKjvF9cX7R1U37E9AQYSP/6pdNJLtcsUNEihOLapoBS2ofuVwV6iapVbzAzOyzgetF12xCZjpjHFHX2LNYhmJhgspqk7Z4J9sh1VP/zZwdc3EbL+ST6FE4koFA0nQ6ADTecs1+0t41MGILThvQ5gkXqOYvosYTIKNt6VXyddR1dFB6s488uaM8AnbwQBCPtOk4Yu9toahjLCppNwQjq120K0BO53loO70f7/LPN4Y1Isju+gMSGRwJCqSahAgXic/7o1TWR6mNRT6WQNno0ASQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW3PR11MB4681.namprd11.prod.outlook.com (2603:10b6:303:57::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 19:06:13 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 19:06:13 +0000
Date: Tue, 4 Feb 2025 11:06:08 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alistair Popple <apopple@nvidia.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<alison.schofield@intel.com>, <lina@asahilina.net>, <zhang.lyra@gmail.com>,
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
Subject: Re: [PATCH v6 23/26] mm: Remove pXX_devmap callers
Message-ID: <67a2652083600_2d2c2942f@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
 <78cb5dce28a7895cc606e76b8e072efe18e24de1.1736488799.git-series.apopple@nvidia.com>
 <6786b209929e2_20f32945c@dwillia2-xfh.jf.intel.com.notmuch>
 <af6btaxeeodhvqrmjmdmz7vx2f7fvnavepyhweisagl2boitr6@77pwrvms66hg>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <af6btaxeeodhvqrmjmdmz7vx2f7fvnavepyhweisagl2boitr6@77pwrvms66hg>
X-ClientProxiedBy: MW4PR03CA0126.namprd03.prod.outlook.com
 (2603:10b6:303:8c::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW3PR11MB4681:EE_
X-MS-Office365-Filtering-Correlation-Id: 65d682e8-fbf2-4655-c95d-08dd454efe29
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?38/jBVutNU1lcJEx4SAahZE/kZ9xRVS3Mpu4a5tX7Wd9Q7VTZtalAcYMKFrz?=
 =?us-ascii?Q?fxeQ5+YZZqFQ/TZEj6+gg1PjfVOmFBsmOb9K3HWi2WyZQ9NasLqCPJAoGBqI?=
 =?us-ascii?Q?oZwWuwbg4fRLLZ2bI166mee0AB/p1D1uBENqrgmCZvOUVDSNsQzz578wcuPm?=
 =?us-ascii?Q?RYvgtyMoWWbcaHEjGbEJeaoz4jbNmlGr4/uisOpqNfS+xUCAyQuOCV/hsQiU?=
 =?us-ascii?Q?LmJVKsvYi78/6olL0qMRweGvJ9w/sxcqTDa9wfwCmi2ciV5MfKFowsANKJeQ?=
 =?us-ascii?Q?KoUHsJpPT6U5nPOiYxM9g1uiecqxCuPFnYAslQApJ1klf6vBrJHYnc5IWHu6?=
 =?us-ascii?Q?EuP7A9caYoiYD+xz+iOLXWzgxrBIfIp640q0S/8RIqP8i2TAky16ePhqPGT5?=
 =?us-ascii?Q?9kT1b6ihlfPEFmHES4vOT6AaHRf4j1fO4V+qxRz9CbY1avgwvOL1NfDXHVFa?=
 =?us-ascii?Q?75a9TtHuucz/jc1kVlii6DeDLdocu+FpHfpoxRuMtmUaHu/74yeNARDuddSN?=
 =?us-ascii?Q?CbjH4qRPjPvdRCawesoCnekhEmGBFuUyv81uwxJPeiJ5zEOV3wl0GfDAKjOS?=
 =?us-ascii?Q?dJnWdFgvMkqhTv7sUPlFzlczGHEtdABhqISRC5XCeUciN2FVyeKiOy2xdZ9U?=
 =?us-ascii?Q?Htff1EY3ellwCwUgWhC1p65j77vZdHCHEsIAKVbeatk/fZ7jy9bvL8s4py5E?=
 =?us-ascii?Q?27smhDQKech39uGsxgdcN0IB/CQoGJJfpctE6Si7rBFdAN2nVp3T5oNtG/hU?=
 =?us-ascii?Q?LDjxnKVv9we12gKup9B3YgdVk0BkCF9oQOdlk/K7iEL3JJqTD4NUOFeZlM+d?=
 =?us-ascii?Q?0Acb6P8DbZ/+Ib9GZBS8jtGwRGJye0QyMymiPYF000rQAAepGLa+j01yilyB?=
 =?us-ascii?Q?lYvjzIDcuucugs7GWav5Ji/MXhLSK/XjziT9yerKnUorlMRqzEn0A8d/5+i7?=
 =?us-ascii?Q?u+fAS3OEtIKKL10iRuJ4SqAzf9c2B84HoJGTd+ibsoi4XVIb3NqyyW0NnFLh?=
 =?us-ascii?Q?mVGHyqYNHPmXhoPC6VoCbjZaEToaOD6wwReSMGQ5Vrd+LPRmVMUgnvJF2fCq?=
 =?us-ascii?Q?al/ZiK5qLzWLUPcpAwCtelngMbFxRCpUYGhlPtN+h+Bz9nv0MKnvl3Ohl7mh?=
 =?us-ascii?Q?H+otIadcWaQq//O0kmUr2GrAaA1qicAQuDjVvJVCe/BbUlg4BJMZ3Zzi3fDJ?=
 =?us-ascii?Q?p/PVBP59H3NYoM4ekx3XxGu0eKWNeJ9wTmi3aBgnDRWx+h4Bl3Jg+xwkcKmn?=
 =?us-ascii?Q?Pcyebi2X3CCodwdoOxf29ckpQIYMwFXyigTJHnoFNQR+FKdr1pOrfVYdZKsg?=
 =?us-ascii?Q?aNwGMBkVX28+BXh6nwLQTeoGCVtDyNLLz0bVREfDr0hzMJFLgahAR2x6Nxxr?=
 =?us-ascii?Q?U/0BoUW2YLnVpDbYnYcYvxzf+FkG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XeMP8ttk3s+N5+hpdQF1bRq0qPjd7lXFQIuAfROA5jmDZ4HOEuojQ5VgRg9m?=
 =?us-ascii?Q?Avw1AQs7JY7vBBaJH6KvKKG9jBI7Si80nzo0h/DIAvhEy53ak5CbaNUyF8cd?=
 =?us-ascii?Q?u02h3aBIENBQJcMlM7hwUbrELqV68umzrgsxz5koW7zuQRTwKr7lHoXTO/uY?=
 =?us-ascii?Q?+0Iu0asHkHeLSHaUOWK3yy1Mxx+x+jYN4QLV2+ifnn7HnMExFugJRbQHPj8B?=
 =?us-ascii?Q?+ZObL0P4kAVjSYk63aKFLbocCJf9LO6OkKmswuPxkof+ouNGWpQeyYaRvHDO?=
 =?us-ascii?Q?Q+G+BaM8mDozEAYTAUj+hY1G7TXQfHqGueZwKbcOxc0DFeK8xnVhlTRB1vpJ?=
 =?us-ascii?Q?VcSMWJMG02ptDGDYrRGsAmAsqKvGsfA7wYtISAAk2I6yT2zHI1/RyTfqm09W?=
 =?us-ascii?Q?ch1/LMT+m1c1cUnhdwru57jRaoCeb1KFOx8Gts6lXZp9aDBQSzZJXV3Iowuu?=
 =?us-ascii?Q?4U70fOPAAxKTyKUwaR4bnqRlUuWXAQitwf2552sa3i2F+5MaQT0Dod56vID/?=
 =?us-ascii?Q?P1wRgTCDiejp2K32AkzBSxLT5Ghp8qPr07LD4U1yGRb2sPxEICeB/upVz2gH?=
 =?us-ascii?Q?Lj/SGfrLb97TekmzPwcwpXy52aKhnYsNhs52VaoRdIiT72HcJYVKii9WtG+j?=
 =?us-ascii?Q?Pu1kmbCyqo0O9GIRwKhRa5HaUyGa1EW1k2YlQeYZmoNyLJGtWsiY64FOpoPd?=
 =?us-ascii?Q?86VFAFDdsdt8xCuUOlI70yRDYM9nFq+pJkbAktavpUgWDsftIB4TkA940HiI?=
 =?us-ascii?Q?F+qiYRfwlkyGVfYJDeHjreJfRSkGgZawDBv9IVh6AJsZmZGojX5ubtW20Z1m?=
 =?us-ascii?Q?4UTt2r/yba7gcHxWHDu9dQaKJfOBBixx1VOHtMDV0zBCLc/j7aoqzTxct4hC?=
 =?us-ascii?Q?6dfJpVkMvKiQOvKc8AsfTBsI089eB+3brWl9O5Y5GXzOwPAdT/t0Ee8r4/JI?=
 =?us-ascii?Q?qpQlOsjEOLNy0/7GkKDEkmc1IHPlCTn6NsQnO7Lz9RKbtwY+RLmd0BFQocDU?=
 =?us-ascii?Q?7fH4hYtIXBF0+SL+cDiprqUJlBaWYaLXfrtILirqbtzNpKxCB1IencSumSHb?=
 =?us-ascii?Q?B169cokQNGmoDr2BnCFCuEqj9GvRQfWbOx2dGZ+3RudiozDqkyG8rCSdIpo9?=
 =?us-ascii?Q?guK+GZYGlwG6/I3WUl/ewNastrNcMSKrMN4LANaAcFlSYHaF1unj2o8sPaei?=
 =?us-ascii?Q?UF627RnbqabBvgpAiTe8aB7TfSOcoXxy0MkztecYLv6hsk2Km1AfQ/cGXoj6?=
 =?us-ascii?Q?vVjQo+PjxAQOsLEDK8zfkfg2GzKvPxj7FNdEc7j6A41DEQUadyW/mEBU7pO8?=
 =?us-ascii?Q?+dOVugMwy8P7xQfrO27N4zuepvikCYIp/28A+XGJSe4t5wKULhwQbIrrWRgO?=
 =?us-ascii?Q?kuM3AtaaUoNPucTqH2AeNEW56WnO54X6KCfa3OFqUqqnFvZAGP8JSUJTdwbF?=
 =?us-ascii?Q?sOHHloBFFs7LdReFhADR6VDkATcPqe0xMSQKq7JvnaO74HnjaedWwU/dgZNV?=
 =?us-ascii?Q?bk49vfT1cruO3nLtn+wkQAvzxyxpcaKcLY7I+dcnRunDSRNLaUkgDGFM+lZq?=
 =?us-ascii?Q?8l4G+lsfv6F1OE3gqXRkNIzz5EH0+ZtuCnHNkDZBBlaYVtivPhr/ZwlQ6f+O?=
 =?us-ascii?Q?CA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d682e8-fbf2-4655-c95d-08dd454efe29
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 19:06:13.2720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bai+4sWbbYao3zHVdLBBVndvnfLDkTR6YSXYR9CkJA8kr3l9w7rN7EVm+6Kcdme17POc0+1d0t8SMj7jH6GYlnPJy5Yhs6Pr9yjI/agoY5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4681
X-OriginatorOrg: intel.com

Alistair Popple wrote:
> On Tue, Jan 14, 2025 at 10:50:49AM -0800, Dan Williams wrote:
> > Alistair Popple wrote:
> > > The devmap PTE special bit was used to detect mappings of FS DAX
> > > pages. This tracking was required to ensure the generic mm did not
> > > manipulate the page reference counts as FS DAX implemented it's own
> > > reference counting scheme.
> > > 
> > > Now that FS DAX pages have their references counted the same way as
> > > normal pages this tracking is no longer needed and can be
> > > removed.
> > > 
> > > Almost all existing uses of pmd_devmap() are paired with a check of
> > > pmd_trans_huge(). As pmd_trans_huge() now returns true for FS DAX pages
> > > dropping the check in these cases doesn't change anything.
> > > 
> > > However care needs to be taken because pmd_trans_huge() also checks that
> > > a page is not an FS DAX page. This is dealt with either by checking
> > > !vma_is_dax() or relying on the fact that the page pointer was obtained
> > > from a page list. This is possible because zone device pages cannot
> > > appear in any page list due to sharing page->lru with page->pgmap.
> > 
> > While the patch looks straightforward I think part of taking "care" in
> > this case is to split it such that any of those careful conversions have
> > their own bisect point in the history.
> > 
> > Perhaps this can move to follow-on series to not blow up the patch count
> > of the base series? ...but first want to get your reaction to splitting
> > for bisect purposes.
> 
> TBH I don't feel too strongly about it - I suppose it would make it easier to
> bisect to the specific case we weren't careful enough about. However I think if
> a bug is bisected to this particular patch it would be relatively easy based on
> the context of the bug to narrow it down to a particular file or two.
> 
> I do however feel strongly about whether or not that should be done in a
> follow-on series :-)
> 
> Rebasing such a large series has already become painful and error prone enough
> so if we want to split this change up it will definitely need to be a separate
> series done once the rest of this has been merged. So I could be pursaded to
> roll this and the pfn_t removal (as that depends on devmap going away) together.
> 
> Let me know what you think.

I tend to think that there's never any regrets for splitting a patch
along lines of risk. I am fine with keeping that in this series if that
makes things easier.

