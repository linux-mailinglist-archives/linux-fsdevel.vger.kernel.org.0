Return-Path: <linux-fsdevel+bounces-77154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAjhFPRfj2nNQgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 18:31:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D27138A78
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 18:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 55252300E2B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 17:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D25C30E0FB;
	Fri, 13 Feb 2026 17:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FJiu98gp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D5F286A9;
	Fri, 13 Feb 2026 17:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771003888; cv=fail; b=bUNxQ9xf5KHR8JQmrD4vOvayROhkHB6GhBRHKi/58J1c7dmBs/b4UmmKbmTSVzVye8FMjFDt9qMDqFAEUwet8jadLkg3BXRUvbHG1tRmtNPi9DlVEU4Spxri+MXiN3pu8e1cmWlxzqvngSezWQAjA0qXCcjWKnX80prmsiLlz64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771003888; c=relaxed/simple;
	bh=UY9ci/wtYON8pQIZSnQluqIOv1WOt2DHwSGPzrCCRVs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Sjw0ciXGdXJx/NnFLDGWkHFU/+5m8R1CmyiyHbIA9dVH2tKJH36frFmi/1ElkBHRmYNHO+bDaX5c7qk1gp3yuWRzUiLDmta4Jv/DxNLaT9vc57fr6twbVeyba7yVqhrq7XGiNzcpnvmIqHGiICXF0ioOAVf+Ac1ZyjfYaQEtGJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FJiu98gp; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771003887; x=1802539887;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UY9ci/wtYON8pQIZSnQluqIOv1WOt2DHwSGPzrCCRVs=;
  b=FJiu98gpOJFDNhQ7nbwnpWxCndcuYrxFb3tAX3hI5FpOqQQFyV62eCYR
   9ziRaVAsFO3dUk92Ih6mvgdIHgsVOwZa1ylctENt5aDswo+P/sfK6ju76
   YoYqeVXvYmt+aHf78idaCaORIiH3q26q2f6ypIgSw5JAS5AFFFsaTduon
   j31sMoHfL/WcmaNr5gpFjXn3pRSQUSWnYcos7jWzOJJ52m641RbaYCcDV
   GPPzbG0JgAidwtB5kjZx3LghVB3Rze7BwMa/xnlkoMT+PqFgpqY58jxL8
   9EuDIK6meD3M210zINCUsJ8r6KOpGoPlFsOqmnRHBv2jmtj++Ftg4vEQi
   A==;
X-CSE-ConnectionGUID: oQXIDAFpTDezGgh2HWRrMw==
X-CSE-MsgGUID: OWgLhhFdQsGktLRpSpZVtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11700"; a="76036730"
X-IronPort-AV: E=Sophos;i="6.21,289,1763452800"; 
   d="scan'208";a="76036730"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 09:31:26 -0800
X-CSE-ConnectionGUID: PAXAeTC9Tt6pr9atjLseNA==
X-CSE-MsgGUID: UZKIGKnWRLymTQ6nW6eOvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,289,1763452800"; 
   d="scan'208";a="211661631"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 09:31:25 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 09:31:25 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 13 Feb 2026 09:31:25 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.55) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 09:31:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mjMZIjv6czODS60YPyXsVuCzS8aKf3NNIrwWooJmlBh/ZBdG6Cjcll+gYonogdRegW8qYSwmCPb65k/QozIrgCjDt6trl4XS5aZnhix19bT2dGKhG/zqXD/keE5A+TpQLlvIZyOce/s1eJq+obezocJe4eDV+z9lafAL/YU99xAxzxZGVo3CIsHTFS3pDMZxpEn/JNSH6oa62J0oHk/FMPW5ZbzLseS5MZsO/1QroHxbnw41QdAlc6NMng3Mudpms1EFagZDb6wbYRjSD4quKth6RadjDdaE7vMWreSIfpLUeupivQUX+iXEXWx0ZdQYuYIzh3ZzI4fvayhNmAbtdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tDsYC05TUoBT2rMclFyioF2XPm6eRFvBQUxQonYH2w=;
 b=iXlaw9JI7EQrCoA10Xdh3QZCfb1HETR/4xUYn8ahkOluDtM/4D1ea0xjigHSUQfZgVXLQc7RdiQl/QVvFy0S672/t5vWXBxmP9HGoW4rZfA+i9s3GCnOwz8hxmomlbVmzD3BNqwlcrG9/Z9akpqGScQ4AZ63RQXqLeESv3qs4f0wwn0z2p2xUmY6fecwzRBfWq9a380IYwhi7YCD+9I7iPJqrJHGLXoecPGqDt4edTIdgz6qULBQXMpkdAR0iHQZIgvkYpZarDzG+m6PUAjY653nzy2gWQdqRFMrSNJqORXMzqaNiAz3j4hR07a+kTTxerBzkayi4DOFnA/3Kkn0SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS4PPFDB7809488.namprd11.prod.outlook.com (2603:10b6:f:fc02::56) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.14; Fri, 13 Feb
 2026 17:31:18 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::b437:3b5f:e6c1:3d13]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::b437:3b5f:e6c1:3d13%6]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 17:31:18 +0000
Date: Fri, 13 Feb 2026 09:31:09 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: "Yasunori Goto (Fujitsu)" <y-goto@fujitsu.com>
CC: "Tomasz Wolski (Fujitsu)" <tomasz.wolski@fujitsu.com>,
	"Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>, "ardb@kernel.org"
	<ardb@kernel.org>, "benjamin.cheatham@amd.com" <benjamin.cheatham@amd.com>,
	"bp@alien8.de" <bp@alien8.de>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "huang.ying.caritas@gmail.com"
	<huang.ying.caritas@gmail.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"jack@suse.cz" <jack@suse.cz>, "jeff.johnson@oss.qualcomm.com"
	<jeff.johnson@oss.qualcomm.com>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "len.brown@intel.com" <len.brown@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Zhijian Li (Fujitsu)"
	<lizhijian@fujitsu.com>, "ming.li@zohomail.com" <ming.li@zohomail.com>,
	"nathan.fontenot@amd.com" <nathan.fontenot@amd.com>, "nvdimm@lists.linux.dev"
	<nvdimm@lists.linux.dev>, "pavel@kernel.org" <pavel@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "rafael@kernel.org"
	<rafael@kernel.org>, "rrichter@amd.com" <rrichter@amd.com>,
	"terry.bowman@amd.com" <terry.bowman@amd.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "willy@infradead.org" <willy@infradead.org>,
	"Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>, "yazen.ghannam@amd.com"
	<yazen.ghannam@amd.com>
Subject: Re: [PATCH v6 0/9] dax/hmem, cxl: Coordinate Soft Reserved handling
 with CXL and HMEM
Message-ID: <aY9f3SZ7dp0P4sEi@aschofie-mobl2.lan>
References: <aYuEIRabA954iSfR@aschofie-mobl2.lan>
 <20260212144415.10418-1-tomasz.wolski@fujitsu.com>
 <aY5DpvAvqxqWZczR@aschofie-mobl2.lan>
 <TYRPR01MB16276AE76EB8585F3786510F59061A@TYRPR01MB16276.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <TYRPR01MB16276AE76EB8585F3786510F59061A@TYRPR01MB16276.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: SJ2PR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:a03:505::12) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS4PPFDB7809488:EE_
X-MS-Office365-Filtering-Correlation-Id: cf9af1e0-ee28-4b8c-8b7a-08de6b25b264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nV08Q8jTOVYMJxtwoUNWwV3QmJoZtIl8gZdcu2PC3rrr4ykJGgcUa5eBg4wr?=
 =?us-ascii?Q?vNAlMbMQwsjCu96tuXpGB1cgGNe6iw6Dm832s7qu1LEotJj4dq9vnb4SzZdK?=
 =?us-ascii?Q?SrOsD+Lf7AR5A+u9pfGLtwgon+29hoJdB5Fa2+xkxXw9vkAnTQjpgl/w5xd7?=
 =?us-ascii?Q?dNmLRG64TA4NwwzwG0Jau3PnUO4Kq4qHR1FLhZh3uEbJATrtZakQrP5ldYrz?=
 =?us-ascii?Q?ZhrheGRBrbcKYlzVERV0FLvZvtFjiyMvycWyu6sjFJhnV9yTyQVqDuZA6F6x?=
 =?us-ascii?Q?xXuEfTfh2v2qIaUb6bK4ftdRsRYfa4XzsmseFi/Iii2To9F3/Q0mf0rDRdnt?=
 =?us-ascii?Q?5HbXte8IVhXXLe6DoWY7iFOlOUTDHef1TX1Bbe3RZRR9V0SqgMBlNDhbSHaz?=
 =?us-ascii?Q?KLxxiEPlJdoC0KuIugHnj+k9f56mpAmHYE6T8ZJVBtRMAdD5fcP+D/IDayU6?=
 =?us-ascii?Q?/+HL01mNG5NI3AJLbZX8a0EPw0Ax8Oa263DFZxWzweM+HV2EOI6XS4D6XTJh?=
 =?us-ascii?Q?jg+XboiXNS5TVZXRxIJdzSfLYY3+B8bzw1Hz/o6lbSakafs0gcUViFzlaO0c?=
 =?us-ascii?Q?Ug/irRPP8wMYF9aOmQ61a7NmlR6kS0XffSdW9mgr7AJpJHFbvY82mVgII86G?=
 =?us-ascii?Q?eUt+gW/F+bLUvo91OHahFuMswRyyvfmGK9AdJXPTB26C9BGsaabSXyynWxu6?=
 =?us-ascii?Q?ntAD357p+oPEqwLthWc15dhuI+ifN2TxtGhG+vrlgU1iSZdPSiYm/QH+lnFq?=
 =?us-ascii?Q?vtylS+ZwgNllspHlhVmKGbJoe9lYGDGUuQ9eBexTr73JiBGMJfnstQWBCk7Z?=
 =?us-ascii?Q?rPjuTN2HLEBPmd1WY/eAXaE1RDaMF0HMSK3zPATL7V+3nDWVfTfLEURfVjZ4?=
 =?us-ascii?Q?c2MxFOdafjSh8KTbO5O0i5LMAurOLnKiun+Qht0xT962tyE6/GASLs4O87dR?=
 =?us-ascii?Q?iVkdXrGJ+90yAhbvyT3uZ0KMBkQIPcQkcl1Mi06FaKdfyoy/kvq1V6emgNvE?=
 =?us-ascii?Q?jxXNBbWlP+uhzmttvd3rD2+/OvOHLEetDYSbk1DHdBBHzwHG3Niqd2tb4DSv?=
 =?us-ascii?Q?E0R/OqIxN20/so1PXgGRZrXYrOfthxoxGwzi2SIR5Rzh6P+k1+TNsXKne5lU?=
 =?us-ascii?Q?LrLZLicCImAKNg7qPiCekyROMDI3EgiLKaLNaVuYvm1DkROS8awEYbA/1HCh?=
 =?us-ascii?Q?HzsagEl5kK2X96b8gfUsnxWJGF2Ov32zYLqOXo4NOLIu0DlKOekgHxU2EZG6?=
 =?us-ascii?Q?AYF3Vv5I5VIB/+UQs9krwEA9IJWDBMX1iGPBcc8dQg3x9QZparKQRdgh4CfM?=
 =?us-ascii?Q?FTW8syqJSkZYFMT8bEDTfPSIfoL20Y6aX3x/u5TYY5gSR7mwEjqdpqXX3D43?=
 =?us-ascii?Q?NeqyKAIruTA4LQyuwlCrJXyZh1fXODqbQIDq5DxxSQWUuEq6ReG9n9QNlQXv?=
 =?us-ascii?Q?31HhXB0S8FysZ5fLW06VicDY4OWNOhEpAYEl6KU9Y0nH531BBs3IY23lcTlA?=
 =?us-ascii?Q?8GPXBCiEcP9VGy05/nenxbtshshhBSezA3e6IUqMmH7pfx/7AnDw51k2H/CQ?=
 =?us-ascii?Q?X45BkYBhvlcYyeG//BbJucpuG9zCJT2+yoznCjLE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FM7JrLH9rPSMkfIcYf8NMBCcIC8SoovnF50IURXapc1LRYoYBt5xOX63SD9z?=
 =?us-ascii?Q?jLmU0+GJqhhKQGySHFUCP+o6TvC9OZ+h9rvVJYef39vhkoXfa1Wp7zfcoy/w?=
 =?us-ascii?Q?f2m2DkBbS6hFWRFDulgF92YxB7BymKL5cZ/s6bbVcqAqNNoEsE4kUKG2YXPt?=
 =?us-ascii?Q?IG+KhWOeWCiHGV5fylbmrNBJBAWbDKBwNmiCofiiV9p8UmeIoWnEguUjBMI3?=
 =?us-ascii?Q?VbjnqVYnHVIDoZ5hbbmTMHNW1rdDx6kMyLZv9u32Zfhx2azV9QlVtAX3AHiI?=
 =?us-ascii?Q?8+wRHlB5OG1GObmMlfNA/xprYgV90xZuVcYoSNjNaQy82H7eCWPIy1v+BSDb?=
 =?us-ascii?Q?6PYoEZ1egoY21WoW/hj4Nn7D6y0h0hjkhIw3R296Q+k9ZXFdDzYgHXr7M5KF?=
 =?us-ascii?Q?e3lfODA0v/JTrMid+VIWr2Li4KWXBZ+MmBYEioStwCyZrX5Q+Y8j2iEpBKpe?=
 =?us-ascii?Q?+XxLuoH8jOOxsQwDLvK/gbmXwJPJcT5zkqd/cnOv3Ra8qRq6LX6OlPqaSwoS?=
 =?us-ascii?Q?ovSO+I34/XzuId55pchk3+G+nxSM+LRAjk9acd79tR3G4/spxO16BE7i68v6?=
 =?us-ascii?Q?hI2jOmV5DR6GkKjHBK67rQ2rvaMtI6q/ABZXB+96CGAFM2L4QCy5BdroXbU/?=
 =?us-ascii?Q?Y0q0j8rjZiC2E3CEOxPnTZpValjcwmeZ7NTUGnjhVTG1Qi7Wn+dZlgv2UZKR?=
 =?us-ascii?Q?QoENhWsC5vetKdl3rB5oVTzt4L4t9rSENQTZIUU0mM/t2eIC4K+0r8jHYyz3?=
 =?us-ascii?Q?9ffNzvVakuzirqoC1ZxcLWsEhwHxKrKNc1w8NzwpLXabyD2XG3DX8dgr8/oE?=
 =?us-ascii?Q?b5JgCQtfZ3SseNIWHFlKiFvBAaOJEDFPA0IvyN7JI4OI22XGHHpKWu4CS8+n?=
 =?us-ascii?Q?dtgmZo+YI7OYdC49ZL+jq904Lq1PGtBtoiRRWmCOODyeAco/VCb7yx21yOFt?=
 =?us-ascii?Q?CxfSAsBiYuN6SCvIEWz1xgslW8jW6ZR+QHrtVG7X0zZp40AYMPjDjT6VmQn1?=
 =?us-ascii?Q?iBiXPU9QCQRogMD13G3NsQd4zeRcCtt+u6bWUeSsiYsIbkeQcks94VDrKDiZ?=
 =?us-ascii?Q?20F2zhvPa0p5B6hMI3Mx1mLRjujpZsTuycTqi36HTS0MJRHazik1xER9RfyC?=
 =?us-ascii?Q?Aebip7pZVZ6iSf/drUZTdzBXoDqZRtv3wQ+ehwU9H2V762d6EBDcp7O+uPsI?=
 =?us-ascii?Q?ZEK1Rk31vHO91LGWY9dD5JKsau6j/JIkDfy1oWBkanKyAacWvkzIsZ+9QTgi?=
 =?us-ascii?Q?fv3xPYshyw5YOLupLohktU4Wv/UjE+DUbmHOPA42Y+uFuMwfLZrBDYLxri7V?=
 =?us-ascii?Q?glkcx5aqljvNGSMdu6QPqLfyqRIjiZQt2Uh5rX9MDOxt1MwgwqJy9I+jEA3H?=
 =?us-ascii?Q?9fJhXzj5b+uwsFnxf7Nd1jZw/kh/AnhV2Uex+ZCqnwjoJJcUbSygNJ0dT5oj?=
 =?us-ascii?Q?9ueOW1xT3ndiT5RnQuaIT/BqAUgTfQv7FlrSTjabtq75Trl8sCnJ0ur2/PVA?=
 =?us-ascii?Q?sbHxdboOD72Y5i5M+TcbV8HXkNIJbxOf9U0JoU1r3PnGdxJ+b7kDYv2v6d9q?=
 =?us-ascii?Q?1BXZrLZTQk2OBZWsq8PXRuqc5YXxvJ5PZkmRnQgIpOrgMiHAq93guS9I46bd?=
 =?us-ascii?Q?9pEsw4BgCMvLiuDoNSMA9TMN4tFxUQRPRVP3UQppcBASA9GrykfOnXcYpNDR?=
 =?us-ascii?Q?2j+0S30k8KQYe/1y89zTWtgTAasfvFVX17UfS4sKpNFwPIxHLM1FVfjAFFGM?=
 =?us-ascii?Q?4ewVQENQvIDHZeJsCHqgEXlSY39wZIM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9af1e0-ee28-4b8c-8b7a-08de6b25b264
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 17:31:18.5622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j+iUFVz2wPCSpL3I9eD0HGdKtRW5z+KVUBf8yXAwgv0rb4VxZUL9fiNawXsHsTbHSv0r1XVC35JA4YY2Tr6WYrS0sE/ymEbUSY9pEZRk13w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFDB7809488
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[33];
	TAGGED_FROM(0.00)[bounces-77154-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[fujitsu.com,amd.com,kernel.org,alien8.de,intel.com,stgolabs.net,linuxfoundation.org,gmail.com,suse.cz,oss.qualcomm.com,huawei.com,vger.kernel.org,zohomail.com,lists.linux.dev,infradead.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alison.schofield@intel.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: F2D27138A78
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 07:47:08AM +0000, Yasunori Goto (Fujitsu) wrote:
> Hello, Alison-san,
> 
> I would like to clarify your answer a bit more.
> 
> > On Thu, Feb 12, 2026 at 03:44:15PM +0100, Tomasz Wolski wrote:
> > > >
> > > >FYI - I am able to confirm the dax regions are back for
> > > >no-soft-reserved case, and my basic hotplug flow works with v6.
> > > >
> > > >-- Alison
> > >
> > > Hello Alison,
> > >
> > > I wanted to ask about this scenario.
> > > Is my understanding correct that this fix is needed for cases without Soft
> > Reserve and:
> > > 1) CXL memory is installed in the server (no hotplug) and OS is
> > > started
> > > 2) CXL memory is hot-plugged after the OS starts
> > > 3) Tests with cxl-test driver
> >                                or QEMU
> 
> Though I can understand that cases 2) and 3) include QEMU, I'm not sure why Linux drivers must handle case 1).
> In such a case, I feel that the platform vendor should modify the firmware to define EFI_MEMORY_SP.
> 
> In the past, I actually encountered another issue between our platform firmware and a Linux driver:
> https://lore.kernel.org/linux-cxl/OS9PR01MB12421AEA8B27BF942CD0F18B19057A@OS9PR01MB12421.jpnprd01.prod.outlook.com/
> In that case, I asked our firmware team to modify the firmware, and the issue was resolved.
> 
> Therefore, I would like to confirm why case 1) must be handled.
> Have any actual machines already been released with such firmware?
> Otherwise, is this just to prepare for a platform whose firmware cannot be fixed on the firmware side?

Maybe I'm misunderstanding Tomasz's Case 1), because this is not
a work-around for a firmware issue.

The CXL driver always tries to create DAX regions out of RAM regions.
That happens if the CXL region is BIOS defined 'auto' region or a
region requested via userspace. That is irregardless of Soft Reserved
existence. Soft-Reserved is not a requirement for CXL or DAX region
creation.

That piece broke in an earlier rev of this patchset [1] where the calls
to devm_cxl_add_dax_region(cxlr) started returning EPROBE_DEFER.

I intended to point out to Smita, that behavior is restored in v6.

--Alison

[1] https://lore.kernel.org/linux-cxl/aXMWzC8zf3bqIHJ0@aschofie-mobl2.lan/


> 
> Thanks,
> ---
> Yasunori Goto
> 
> 

