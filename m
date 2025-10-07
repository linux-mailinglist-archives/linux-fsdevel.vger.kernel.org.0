Return-Path: <linux-fsdevel+bounces-63521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F402ABBFF5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 07 Oct 2025 03:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB27D3A7732
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 01:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4511E835D;
	Tue,  7 Oct 2025 01:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C/oT/9ok"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE6763CB;
	Tue,  7 Oct 2025 01:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759800458; cv=fail; b=uQ010daSris+Fnlbaua8L1RC106cwScF5fMnO53kgdiL5/u9cIGeiFsNNyFigKh7otvud/gOqGH1lpcKC2WYXttk5p/1Ro4jLGGYIKpA5w5sUbBIbR0tuvsBRY0UQFm38pGYMTznGX2kB0PfQUK4vcb9sPvqPnZxzkB+xh4ZZs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759800458; c=relaxed/simple;
	bh=ffVjvLkrDZDHqEr4T9weyJ4cmpZ3nwK9e804OmOJf4s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TNYRiqYn56Ie+t7JvOgwzQfHHhcTUdHwXK7EdsqV4uugQA8sd+hD7ye6ZpCu+VCb9GgN2I2csiqEZnd8TXhPYY+va/4vn38PtngGsGRlNebwExcPVLrx3MPtC/RP1Ncm3H7qGt4hKZzzX1zjN1GxloWy8fCR9GLD3g0DVNVc6ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C/oT/9ok; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759800457; x=1791336457;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ffVjvLkrDZDHqEr4T9weyJ4cmpZ3nwK9e804OmOJf4s=;
  b=C/oT/9okcz3zLWIJXo6owso6BquL8q2HnkDxHPMz0sCooULaus2Uvr6F
   eykgrP5QPleVJT/EixhRGpa+FnlMSEeVomsQizWUd8z0tp1Ddd8ezfree
   FyA0xAJxI5kmUHMrZRjahAG7RzllZThiaKFvHm4i5Qk6Yf6kgpGJrmFnc
   rCQmBFUH83qlOZ6WXZ8D5J/KN3wzM1gr22AVNrgwW3neq3D5zj8Zkn/Zh
   zAi9xYOfv1U916FTlzHbOBGBtRehtOTPWPeSiN0u91jbS1/aaXRlFeq/U
   Etxbk4W5Jj4h+5TiSRN9Grjs+T5zaTACyhTz+WTqMmgT9Upxo32CZQzRG
   Q==;
X-CSE-ConnectionGUID: ScKjjE3ySlGVQBYeZO0GcQ==
X-CSE-MsgGUID: 5HNfCUx9QUO+EKVpRKi0iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="62079562"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="62079562"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 18:27:36 -0700
X-CSE-ConnectionGUID: ADapZAugSPyofVys2rWCqg==
X-CSE-MsgGUID: kx3rS3GvS/q5CE28Y5jiEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="179681952"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 18:27:36 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 18:27:35 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 6 Oct 2025 18:27:35 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.21) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 18:27:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w1qBEThEgsjkyCB48UWis8SQH6hQ5+h7b/NxWrROnnOJbF5HifYtEaFEZipR5nYNG4x/Q738yhpSoIwoNf/FAGhq/yrvIzNVYYMezKd7y9URCUZauJD7gj3+CKtEKsAG+kIsJUpLnotQ/qF0jpj8KLhadAPeWMgqE6AKWAq4/HrL31LRbz2DT11zYBHwPiHs3EgSlcabmIY5DSsT9RpmSMk4nX9yyA/BqHW5QOuBoh5KV4u6G6yM6FvgFAe6SjVhOtnGg7r8pxiMGRHUFNJHdN4hWgEF5sjUcyap6B9nDnCuOkCBNuf2ulC6rJwh0e2m0ziUf9npgEPwvDUvHl/Ggg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFaFGaPGPQsT/Wohaz8fuhZTXLaWZsALgYJYQdfYw7Q=;
 b=j/mp/qaGRjoWolU2pb5I8kpDtxovhKoEJc3UnVg9DMR6PAYPTAxIRi4W0dKm7tv1+5dk4qTQ2ewV6ZzGneAgwSPACkyjHlmiEMBGuVo9y7wqS4oKNu90KSSAiC99R6qGPlk9e77QGFNGR+gMsLMsK7ZMAPoDSEDLcttS/Ci1Ys9wd9eY8izt8NzqJqHaOkuQPoIRax1J0IlqYYF5uZDx0ruiESWtgc9JpmMF0D+S6z0HVAUrCdCm0aQsEwop2x00lVGpE66vzQq3DXkHm5a78BvvM7wKT+OCx6xQ5Rdd3FqcfswJTXjjTFUfvh2IFbmVr3XxY3bwbWjVExqJPpmMrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 01:27:24 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%7]) with mapi id 15.20.9182.015; Tue, 7 Oct 2025
 01:27:24 +0000
Date: Mon, 6 Oct 2025 18:27:12 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>, Matthew Wilcox
	<willy@infradead.org>, Jan Kara <jack@suse.cz>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek
	<pavel@kernel.org>, Li Ming <ming.li@zohomail.com>, Jeff Johnson
	<jeff.johnson@oss.qualcomm.com>, "Ying Huang" <huang.ying.caritas@gmail.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>,
	Greg KH <gregkh@linuxfoundation.org>, Nathan Fontenot
	<nathan.fontenot@amd.com>, Terry Bowman <terry.bowman@amd.com>, Robert
 Richter <rrichter@amd.com>, Benjamin Cheatham <benjamin.cheatham@amd.com>,
	Zhijian Li <lizhijian@fujitsu.com>, "Borislav Petkov" <bp@alien8.de>, Ard
 Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v3 4/5] dax/hmem: Defer Soft Reserved overlap handling
 until CXL region assembly completes
Message-ID: <aORscMprmQyGlohw@aschofie-mobl2.lan>
References: <20250930044757.214798-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250930044757.214798-5-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250930044757.214798-5-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: SJ0PR13CA0151.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::6) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SN7PR11MB7420:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bf7e981-d6de-4026-598c-08de0540ab01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pU4YIlgYQHOrMGRC+umDlGycKckfzFwB+iSgK7QD9CGck+RcxZ6Vmw+/joOW?=
 =?us-ascii?Q?3jIZWBHDt2FOKs6AtgLAYYVMbosiFtm2HmI1oe7bA1GlWtgJk8qOTzefBA5D?=
 =?us-ascii?Q?3obvZoc8ptmiZTaHSnzhIR10ZLnRCb8qC9yXNJd6c3iEk/auCzDygPjeKW+P?=
 =?us-ascii?Q?e8q7bYLuXKzzdKfmSUTAVD4d8cQeVQAVFuFwULKhJoyMUse/6s1qJqwBJrYe?=
 =?us-ascii?Q?VerjNcv9M8Ak0ulPO0gcWMdgIOrQ0xnI4/kHNuGkpHBvKWsLJ6gXT+3bko/y?=
 =?us-ascii?Q?QrQ4qOp2eesmUhGtM2rK5nsa22MpeW13a2oNL0pqEjlxzAWF7b1naREVyaJ6?=
 =?us-ascii?Q?75rdtbRGmHQWalP8nnKE9QSM9QDfcZ4fakDpH9ToqjoGi7kHRjBKlcf5WI0p?=
 =?us-ascii?Q?Q8YGs+XEE/CTydvn/fKbjJZuCV+O5IGTlvGT7sgOzpp+Hud2QJJkZpDjTpn2?=
 =?us-ascii?Q?3P0HlOMpby74OMjbIaf/VUrSFb3cg9GpNMbj6NeAsAkn1BUJBWEYvaF3xhoP?=
 =?us-ascii?Q?oSUSQMFLiQBZXq5Fr/mDgGRj6/QvT0vL85edXUHYdnez2yheyRZE1RBd+fY1?=
 =?us-ascii?Q?W57bqIKBK4B7LSVLSE56a5waNN8bHVIXTpecbpnwvvz+X761FtsgxuUrm0LD?=
 =?us-ascii?Q?c+2qmZEX854s/TqMYoykv2j51Nv+jOsVkC9BWaO9a8ng/jXMCR4fxMGtYI2L?=
 =?us-ascii?Q?/flVoVEwutkQziikU9CHK8vnRaXCJjyseVqS0LjDynmUTCjDXrmgWsCybJW1?=
 =?us-ascii?Q?pSoywP7fXbu4r2DDuuBu+fxsrQ7z9WML7VdG9kRogZnmbPiyMC03hvY+vjhq?=
 =?us-ascii?Q?gjCodb09DsXzd8P/Idq3HpU6R1dgx9empj3LrddqgwXuiDZQnbmjbyqZtiD8?=
 =?us-ascii?Q?ghJtzGE1uapTNOZvOVpuAXEPRilk/zvY4RkxZVVnPxVVmlNBrTibOiLeIpXf?=
 =?us-ascii?Q?WobSV6N8xG91NrnIZw0THRp75e4SClvp1JO9cxXeZ5PN7k6Pbc7AMtClrfpb?=
 =?us-ascii?Q?4VilVyzTjwbrxq7XzERRcSqaYMI9G82Tl2f1QI38w/mW7taMZUmAm1BWwiD8?=
 =?us-ascii?Q?0tCtHC9B4nZss7RoWoGvWCSVFDrnRGilvVxUCy0QhNwfsAsx+wkH3l7oTebn?=
 =?us-ascii?Q?V3l0KOodBb13YE2y9okD2YosPFiYIYurWnLRYNpPwDQjZ/tH1D9SSEOyDHtl?=
 =?us-ascii?Q?eRlykVYpioxg45S0l0qfYVeV6hOrWL3qoyt2dQdDqf5nFd++TvNkrA3oHJoK?=
 =?us-ascii?Q?yl+HiMZJalKBqgIdrY/Z8a8iFI5+uoLVHcZp1TdiSviv5jyDOU1HyGDTwJlH?=
 =?us-ascii?Q?mlEaEnOiOtUMz7/fF+IV7KepvsmiZhRvBZo3NvtSMkqmj4bUa8dFLyiqAA9T?=
 =?us-ascii?Q?RWbu+UiRXWfMe0gUkVLX4wDKeFqxrXeILt4JBNgQlbhxy4dya5r+BnVM+ahe?=
 =?us-ascii?Q?pKNDU12ckGBJc/GUzN58hspGxED4S0ca?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MoknnhbepnMYzWMTOax5py3Wtz24WtnTY14Uwao8VbaB+ns1sRL6WAMbbXjb?=
 =?us-ascii?Q?0sbD4llKGl5x+vZp6iQ1NK4rYk54PZ0lL9ga7qgkiKq/x/esNhr8Lyli7KmZ?=
 =?us-ascii?Q?VCk6mpqyZ5S4r+HLGykUSHZTgNVU1Lk60lGNcloRk+/gR59v5AYvyPl+huXF?=
 =?us-ascii?Q?dgqZ/4+DcAn4wRQE8cFWmv2gVF2s9r6ljHOj3yGijPEnXMPUfYDCXO4vIfQo?=
 =?us-ascii?Q?a3IkG1OEVCuYdURUKkxXOCWURBExYlRADBJFJ9KAkUHDyQHeIS3Nrd25L/7s?=
 =?us-ascii?Q?hTIPjJbQ5dbZ4gNbaA5W4ewplcyvhD7AiucQLVmWllMTeK6dkGyM3gVof+GJ?=
 =?us-ascii?Q?yJihBrcrWbtuQuMJT0s6oP5BiUOdZj7c1pHlQmqvBzDRoyBA6Iwmav4pcT11?=
 =?us-ascii?Q?E4CtJ6cVuOCHceHBudtqQ8Nwh/JLYxKRllJ5ENYbOENi+RkqDUQsGoPwr1xH?=
 =?us-ascii?Q?LLom8cvvVK8o95L8/AK6PfxLOM70CTS4SKqsXEUPbVmGdak69h1S2L6DFi52?=
 =?us-ascii?Q?Kk7kZH0Cup5Hvg7WK2QJqgYRtW2wPLhsj0k6AhG8fwhqe9P88F+yEgCyvJb4?=
 =?us-ascii?Q?L/CRN6OhRVy7I14Yn8oocHH5u+062bYQwfUdOir/kPvvJp/w/8IvhXg3KhVv?=
 =?us-ascii?Q?/Kil/h/XA6mUB5maJIW/8Rqs+4HqfCmBDr8RRSZipnKfgPxBIRo9NKghaVPm?=
 =?us-ascii?Q?ylFlYnLSENScgk548NsUYxgN8Tuo6WYcLdfW0weZFKGVL51zHGMTNkm42O15?=
 =?us-ascii?Q?/dk65Z7uSKsdx1Lq7gFHnPfvhGYa8rnXXYo+0HPj0ESto+1r08CAtETK9acE?=
 =?us-ascii?Q?jbgqAIK5ybIQOGsHL/M+SgxI1X06pD4/Y9HUJRCRod5PxluxGU8E836aRio5?=
 =?us-ascii?Q?S/xSSLO0ZbHmjT9JH2aMHrQ7WvIML+WnjiTSyOHyZU2LPxQvmUggeCtcGVjD?=
 =?us-ascii?Q?PQNR4g0x/4Ow5PwZ7XzSTU+uDMieOyf4fYoqWYqfYLDYfv9bk51gNhmO2MZG?=
 =?us-ascii?Q?rJcJvTS2yIEe/NTDlkhKfTR4uLMNsw+Ld4M/EYzAZFe2QJvmqfCDR2sAFy2L?=
 =?us-ascii?Q?/Sw9ON3Y0KEiwZOHJ67M/hnRigFbZC0GDJQbmfQ6uxkhx5d16mZtSDO7Dpaa?=
 =?us-ascii?Q?IU9/BkCt1+ABLk5aP94D+mCBManZR0/QW06sI65NFsRk0nGIsrGisLZq75/I?=
 =?us-ascii?Q?etqFxEQNYlnkV7o5Nu9veHUBLAxhPpLDjvkf8P5JgMAg77pVjRpy70I3cfbl?=
 =?us-ascii?Q?HCmLykLnt6xiOc+lhA2clWe5Ufcit0yzaV4URK5Oy7DPthSohjwDn3nctDnX?=
 =?us-ascii?Q?MpeK2v8etWY/Dm3FD2jXtmCCF0dTNFQI1STFR1Lb1+Wfl8dkteYXLqmMggNp?=
 =?us-ascii?Q?WOtTZieXzLGaiw/yLEZyHXhsv1VETHSrVVsL1bd9giNQmlE9hgsUKNQG/RMp?=
 =?us-ascii?Q?TfWcpfguCsi9KActeHaHt8WLupBi4jD7ugHAdBKVGvhMK5fOh+Lv9uZv638u?=
 =?us-ascii?Q?S1cXUIYBXDPyIInu+j9/wwthEuo0faISV8N8oa1azNYh21OmH140pjTYrlWf?=
 =?us-ascii?Q?9I21rKn5z1LN5XPAxgbfNKaQH9pXAwlsLQCVZlB9+nOWn8J28/oA8B9iUs8V?=
 =?us-ascii?Q?1A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf7e981-d6de-4026-598c-08de0540ab01
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 01:27:24.1408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BiliQsNlDJKUN4LqBwX/ikSMtky+yI4mZi5WsKMpZNTdyWCpS09+HNC+zY52Zj+fw57A9+r7og6alb/MMQ+rWs+4faSS4SPqoj24BlBYAOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7420
X-OriginatorOrg: intel.com

On Tue, Sep 30, 2025 at 04:47:56AM +0000, Smita Koralahalli wrote:
> From: Dan Williams <dan.j.williams@intel.com>
> 
> Previously, dax_hmem deferred to CXL only when an immediate resource
> intersection with a CXL window was detected. This left a gap: if cxl_acpi
> or cxl_pci probing or region assembly had not yet started, hmem could
> prematurely claim ranges.
> 
> Fix this by introducing a dax_cxl_mode state machine and a deferred
> work mechanism.
> 
> The new workqueue delays consideration of Soft Reserved overlaps until
> the CXL subsystem has had a chance to complete its discovery and region
> assembly. This avoids premature iomem claims, eliminates race conditions
> with async cxl_pci probe, and provides a cleaner handoff between hmem and
> CXL resource management.

Hi Smita,

I've attached what I did to make this work for handoff to DAX after
region assembly failure. I don't know how it fits into the complete
solution. Please take a look.

Thanks,
Alison


> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
>  drivers/dax/hmem/hmem.c | 72 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 70 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
> index c2c110b194e5..0498cb234c06 100644
> --- a/drivers/dax/hmem/hmem.c
> +++ b/drivers/dax/hmem/hmem.c
> @@ -58,9 +58,45 @@ static void release_hmem(void *pdev)
>  	platform_device_unregister(pdev);
>  }
>  
> +static enum dax_cxl_mode {
> +	DAX_CXL_MODE_DEFER,
> +	DAX_CXL_MODE_REGISTER,
> +	DAX_CXL_MODE_DROP,
> +} dax_cxl_mode;

DAX_CXL_MOD_REGISTER isn't used (yet).  I used it below.
The state machine now goes directly from DEFER -> DROP.
See suggestion in process_defer_work() below.

> +
> +static int handle_deferred_cxl(struct device *host, int target_nid,
> +				const struct resource *res)
> +{
> +	if (region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
> +			      IORES_DESC_CXL) != REGION_DISJOINT) {
> +		if (dax_cxl_mode == DAX_CXL_MODE_DROP)
> +			dev_dbg(host, "dropping CXL range: %pr\n", res);


IORES_DESC_CXL doesn't tell us if a CXL region was successfully assembled.
Even if CXL region assembly fails I think the window resources still be in
the iomem tree. So maybe this check always returns true?

Can we check if the SR conflicts with an existing iomem resource? If CXL
region assembled successfully, it'll conflict, otherwise they'll be no
conflict. No conflict means the range is available for DAX, so register
it.

Here's what worked for me:

	rc = add_soft_reserve_into_iomem(host, res);
        /* The above add probably means patch 5 drops */
	if (rc == -EBUSY) {
		dev_dbg(host, "range already in iomem (CXL owns it): %pr\n", res);
		return 0;
	}
	if (rc) {
		dev_err(host, "failed to add soft reserve to iomem: %d\n", rc);
		return rc;
	}

	dev_dbg(host, "registering released/unclaimed range with DAX: %pr\n", res);

	return hmem_register_device(host, target_nid, res);
	}

> +	}
> +	return 0;
> +}
> +
> +struct dax_defer_work {
> +	struct platform_device *pdev;
> +	struct work_struct work;
> +};
> +
> +static void process_defer_work(struct work_struct *_work)
> +{
> +	struct dax_defer_work *work = container_of(_work, typeof(*work), work);
> +	struct platform_device *pdev = work->pdev;
> +
> +	/* relies on cxl_acpi and cxl_pci having had a chance to load */
> +	wait_for_device_probe();

The wait_for_device_probe() didn't wait for region probe to complete.
I couldn't figure out why, so I just 'slept' here in my testing. 
How is that suppose work? Could I have something config'd wrong?

After the long sleep that allowed region assembly to complete, and
fail, this worked for me: 

	/*
        * At this point, CXL has had its chance. Resources that CXL
        * successfully claimed will have resources in iomem. Resources
        * where CXL region assembly failed will be available.
        */
       dax_cxl_mode = DAX_CXL_MODE_REGISTER;

       /*
        * Walk all Soft Reserved ranges and register the ones
        * that CXL didn't claim or that CXL released after failure.
        */
       walk_hmem_resources(&pdev->dev, handle_deferred_cxl);

       /*
        * Future attempts should drop CXL overlaps immediately
        * without deferring again.
        */
> +	dax_cxl_mode = DAX_CXL_MODE_DROP;
> +
> +	walk_hmem_resources(&pdev->dev, handle_deferred_cxl);
> +}
> +
>  static int hmem_register_device(struct device *host, int target_nid,
>  				const struct resource *res)
>  {
> +	struct dax_defer_work *work = dev_get_drvdata(host);
>  	struct platform_device *pdev;
>  	struct memregion_info info;
>  	long id;
> @@ -69,8 +105,18 @@ static int hmem_register_device(struct device *host, int target_nid,
>  	if (IS_ENABLED(CONFIG_DEV_DAX_CXL) &&
>  	    region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
>  			      IORES_DESC_CXL) != REGION_DISJOINT) {
> -		dev_dbg(host, "deferring range to CXL: %pr\n", res);
> -		return 0;
> +		switch (dax_cxl_mode) {
> +		case DAX_CXL_MODE_DEFER:
> +			dev_dbg(host, "deferring range to CXL: %pr\n", res);
> +			schedule_work(&work->work);
> +			return 0;
> +		case DAX_CXL_MODE_REGISTER:
> +			dev_dbg(host, "registering CXL range: %pr\n", res);
> +			break;
> +		case DAX_CXL_MODE_DROP:
> +			dev_dbg(host, "dropping CXL range: %pr\n", res);
> +			return 0;
> +		}
>  	}
>  
>  	rc = region_intersects_soft_reserve(res->start, resource_size(res),
> @@ -125,8 +171,30 @@ static int hmem_register_device(struct device *host, int target_nid,
>  	return rc;
>  }
>  
> +static void kill_defer_work(void *_work)
> +{
> +	struct dax_defer_work *work = container_of(_work, typeof(*work), work);
> +
> +	cancel_work_sync(&work->work);
> +	kfree(work);
> +}
> +
>  static int dax_hmem_platform_probe(struct platform_device *pdev)
>  {
> +	struct dax_defer_work *work = kzalloc(sizeof(*work), GFP_KERNEL);
> +	int rc;
> +
> +	if (!work)
> +		return -ENOMEM;
> +
> +	work->pdev = pdev;
> +	INIT_WORK(&work->work, process_defer_work);
> +
> +	rc = devm_add_action_or_reset(&pdev->dev, kill_defer_work, work);
> +	if (rc)
> +		return rc;
> +
> +	platform_set_drvdata(pdev, work);
>  	return walk_hmem_resources(&pdev->dev, hmem_register_device);
>  }
>  
> -- 
> 2.17.1
> 

