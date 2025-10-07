Return-Path: <linux-fsdevel+bounces-63522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A941BBFFEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 07 Oct 2025 04:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 06BDF34A314
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 02:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93801EF09B;
	Tue,  7 Oct 2025 02:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TR0zvPSm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AA78488;
	Tue,  7 Oct 2025 02:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759802612; cv=fail; b=bVKvGX2GraOEDwKHYs+mK8fKrP1HEtC9wdiiyavT7Fz4CI97W1ODi4AvMseI3fSAKArYZ9f2841P68hUAVS7zdZv9F0O9VYYSvmlT2LKxe5BoUknSnjeuORK7eZ8QzS12ahgqERlttb6/jkvnmmYSRMd5vXP66NgtIJB9oA/Zcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759802612; c=relaxed/simple;
	bh=kNsU8yLthhsJKpZQI4hocvoF3LOpkw0fIlbR9pJD8Lo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OGqmxeuOpohnF2kR5hJrATAKovdmS6+BgcU5pBTJnIrDgs0xySKTmHm4k+MCjVnkS9MaxrkKQRzIML9sBCgEHawpPUERLTD2O/S1i3pOSuiMx3feJ2MHSbEe3ZidlEcmxdo4SwFe8FAut7wnF+jokTDUwOu6FmF+JZkmA4+1qGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TR0zvPSm; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759802610; x=1791338610;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kNsU8yLthhsJKpZQI4hocvoF3LOpkw0fIlbR9pJD8Lo=;
  b=TR0zvPSmCN0S02/FB1mdiRs/fD7fOGRMKbE6+u3XjrvfPafNxMwC99kP
   b0TdBmvfRgLTpopaARqrO4z0mvew1kUGJGUnv7JQLyqREY9LsjRe5LdX9
   VmCkmp2C1tFhJhs4OOA/El79OwlcoKd+Np5l/G0ZNwl1Pybjsu6FvQAMf
   3aUwTis9C+bGnDSQ896G7LK9vAoJeZMGTNlriIsFYwD11W5OTeJ8jsJ7j
   htyBcAikErdabPtexcYjIWfGn1sOLYAkrQHA3pJMqjP90+YK3i/EZD8cV
   mDIEEoWDD93gKVWBtqMUdvcdh+Hikwbnf2txuLeaHWehMB00TCMYWLr5n
   A==;
X-CSE-ConnectionGUID: w/U1QjOWS6KaGNGce5C4jA==
X-CSE-MsgGUID: FfhRuxY7TNaQtBRv0ORAtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="73334681"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="73334681"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 19:03:24 -0700
X-CSE-ConnectionGUID: gKoPitK/ReKh4opwDaeLBQ==
X-CSE-MsgGUID: IggHJuPORG2kuHkYl6QsFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="210706790"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 19:03:20 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 19:03:19 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 6 Oct 2025 19:03:19 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.52) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 19:03:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oDjQBmnCpnhlXI7whn3zEO597IbR7M3CeARX0rs9fRJDlDzQYBoDfkpmS3G9g22Nw8M8Y8sICOGxeeZKvEdx0boMCTVUpPc0YyJL1ft72W2iNJHO7kHZ7V7wxB+lwG9jcVhs5DW5KonXH/nkUXQ2EEn3RUOV6rVW/583fz4Q0dNv64DVJhvYLEE5SkvJVchV0QwpttRtOgSQZvsHNjkQpP8EyfrFZzR4OxhztrvVV+n6J4blhX6haoR0c65pI6Gk2MT3D8K5GT34H1uDdakpkucwfGAWAviBSFbZB6a5oPNgHowRfgdn1LMEePCi0zVRSI0PFyWi3bXWb6Fo/OqLJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zi5NX3fCvWrWAxGvwqlHhcb+5GDLCfn8bCimrlB4JQY=;
 b=e9zzmizY9RxSF9pWnVdrhF6n12UNkngjuvihmBJM4VpT+ULETUY180MnRcYkaxaF0lu/MM7tofVQGyp4dcL/lG5jvIca9zIt1ZuMj0zDO+5ML3YhWwHuUsuyz2w8TSsux74og1tOguO8RIO9Pa+m0FXB2ha9PKovgTt1oBwfEm0gsl6yOxPv18qj5vU5WmyhkxNDGmcsHoaCeL6vrPyOhfXQUOqiSqkp0Y+YyrwOGzc1vjCE8veTnb6jdhVWBqsy+FY2NBR548GnKIW9YBwHN4P9wUqtMkOPHcZiUxccluudxC/og63lQ0ETB+o5jFB7ecHOx28AUm7lAw1yPTt/VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH7PR11MB6473.namprd11.prod.outlook.com (2603:10b6:510:1f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 02:03:08 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%7]) with mapi id 15.20.9182.015; Tue, 7 Oct 2025
 02:03:08 +0000
Date: Mon, 6 Oct 2025 19:03:01 -0700
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
Message-ID: <aOR01dEJJgt0et_M@aschofie-mobl2.lan>
References: <20250930044757.214798-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250930044757.214798-5-Smita.KoralahalliChannabasappa@amd.com>
 <aORscMprmQyGlohw@aschofie-mobl2.lan>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aORscMprmQyGlohw@aschofie-mobl2.lan>
X-ClientProxiedBy: SJ0PR03CA0189.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::14) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH7PR11MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: 46015e41-c7be-47ed-e234-08de0545a86c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ak1m7InAxffNWqBML4aWNQHJEiY2VkbHLlcvTOuMRWoJoO0tPP1g9Ue6Y1gV?=
 =?us-ascii?Q?dbuUyD86L+epiNe/wDMY4V1ZTE4y8j/Vior6xeVXFNT5ItCg8Giz9LwrPQCN?=
 =?us-ascii?Q?VyAUYym8AClXXllaei2xfFvii8IfInFysItetTra2F0WFIbegvyiaASAZ6xV?=
 =?us-ascii?Q?7kKEAcVbzex2O3Tt4YsDiJSl7xsAVy0wCfbltdWK//SHLHhKTocLdGSe+9PU?=
 =?us-ascii?Q?Uv5jJCXxhXXrAlV3tXnq2bAQ+zOLzqQefVkX5wWrYD4f1Gs867029/AzNZgs?=
 =?us-ascii?Q?cCUkLMjRay/7cOCmuYuVDf5IVt6d3J1rSoEqaJVNLnYPt68PvQuDW3vYJ41y?=
 =?us-ascii?Q?OCGLYGN5duR3f7gn/m8SuGK8Rwyt6TCE2vUqOiXZL+3BmiKuVFXYvWjce1Gg?=
 =?us-ascii?Q?zGG0kcFCCC1yW+4iY6N0yMBnjIB9bssGJW15m2lDyYsN5PvBNnpzZ4qOhtzo?=
 =?us-ascii?Q?8yvgJHNQhYlsBwWA2nsC2VBF4EIFrazpCqA1blLYhBEJ8wfFJCyuLCqm6r6C?=
 =?us-ascii?Q?vDX+f2MBlycX6aNCT72Hw+uya+QXX5RciVicRdsZGQ0EAWEiqdQlfB0ZaVGN?=
 =?us-ascii?Q?zUHiSrsiTUk5nCGQO5Nf/9ybq4IcMybBJGb1nardlklpG7FE+8woYVK3QnmY?=
 =?us-ascii?Q?G7sl2mlmTekJ2flGGTG8HVPY8ElwYY+kRWiY9SwWTBNoee+3qoO0zOHHPo5E?=
 =?us-ascii?Q?8GYOUb8goLfdIB8DMXnxtgjXeWbB/WU96IpIjgo+CuZN1MeEsyIAgNnJhj9o?=
 =?us-ascii?Q?edpJeEv3Mp5azTd4ZvbuDoeQvdNalgjGrnes6viXjJadgXWD19rZOFkCcfTa?=
 =?us-ascii?Q?U0UsVrSoimfKmxO7hXS8jIYfnMx5TFOfsrmtr5C6e+6hsWw6JrVXbb0Dm1r0?=
 =?us-ascii?Q?bzfnNQK+htpuC1iiQlvxtkhwsE+qoUUmuXXDS5wFZIeBpr84r7pM0WhPaNUf?=
 =?us-ascii?Q?ppRiFU4mWpsYSoHaA5a41zq0RvC1/AzQp5FBhhluji9fc2k02A0n7MEH7Rk/?=
 =?us-ascii?Q?yb/2SMDjOYsp0Ok7x8QAZm6KnbDRpwaGtW5x0hp9jh+F3QSn1Hq7n/kXERAJ?=
 =?us-ascii?Q?pDC8MePZuPqgYNwyA0T7bair8J2OfSgosrXja1wtUYnPHQS3WQHwBh4JpPPm?=
 =?us-ascii?Q?aCEl8tzLnvFd2BbjG0rl0Lv/aXcPlzCAk7zaPD7XTq6TaimlerxzJbqKaUhR?=
 =?us-ascii?Q?Y8sSWo1p4+ne65L2+M/vJbXiF1kw5f8Y3KMSuHgxSwoGOYPEEN/l/xfvDcSC?=
 =?us-ascii?Q?QR1/WQa7scQ0rteuMD2LZnqnN1udD3e+aqJQEIzathyOalNj9I0KP9Uip8oE?=
 =?us-ascii?Q?2MipPFOn9IEvk4uPCCcSvr94C+4I1+9ww2ChjSWHUbMLoQbmWSoJEXl0D6ep?=
 =?us-ascii?Q?9QpB40xjfBS9GdRAp0f/exvqW3rM9nnXjKHSn8Li4T1GyfwW6TNjN5uxHPM7?=
 =?us-ascii?Q?bjxeSjco1vTC3JoSA74AQNF+Rf2sli3e?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?03CKbP1pENRqqRZasSx0TCdokJn9LIvTRhR8TyqcmQ+8QM2wordQceEM9B8y?=
 =?us-ascii?Q?sOG1w6QknaGnj3AY5aW5X4cdXgPoJdbODEgHUNnTUvVRdZox3PjpzLto00QG?=
 =?us-ascii?Q?/N3AI8SG2mvnkhWMsCjJKkF+5xFdkp07XBG38We2mHUKRodmy6tGQ1j4QmYC?=
 =?us-ascii?Q?FKnwrGrWhYVvn0bAmHFxZ9Jh3PtPNC+EQ+QldtRRWLmuMfrIjHw0fU4Xy5wf?=
 =?us-ascii?Q?9QRkB0oY/NJlvKBukEPTFQ+9ACvImHp70ZwVHO8sPQA6lVvWbgOWVn04jrCC?=
 =?us-ascii?Q?XqZtbVKi5WiT49WWU8Aqt1P4GG7yL+AQeQm1d97YFEWZzJlckiPaZzaUU/Ic?=
 =?us-ascii?Q?TlUSXcl3zi1N80tzDQhCBTophCR1XhNA60Xcn/8YlL70eNDSkevP7DjU7+XV?=
 =?us-ascii?Q?7fEKWDsxMdVU3I5wj11de2xjqT2EWlv1CtL9TwJPeTBd8nKFZ1v49KRYdyaI?=
 =?us-ascii?Q?4Pn1IcQkUTecxrcjY53p5hRMhkKE54zkdSBHBRIADZilT4xCsxYNb693iZlK?=
 =?us-ascii?Q?jIjv4JRuc3GNYhSDyL7wygTtaMQz5/ehrOntGGye7mi5UHnjTrCK4d/K2waw?=
 =?us-ascii?Q?B+Ds8FBc5mZy+pPHMxNNH9+WUbKyx1vkvpIYJgRSqlxGDTE6d+7/4GpCigTX?=
 =?us-ascii?Q?Yh0smEOhD73EbMNiZojBmADvTS3JI8mexXBDJoSDarcSWyrKD+X0nWB5qRrO?=
 =?us-ascii?Q?1TOEcVsQf8SY2MFRjI7CYNiwekJ+6Yo0VsD2dvpZ/HhfLWa39PtEoFQcZ1Fp?=
 =?us-ascii?Q?hXJUIYiNfkjcnfNCitWqkC5eytDCoEfYsEO/FuaykLB0l3PbSA5ZsS5xlG6v?=
 =?us-ascii?Q?9PmERe/cKHou5YvaFxWdQQQiFjNRVb/Yo22ch1lW59v8vfahGkTmwi7XwVi+?=
 =?us-ascii?Q?l0+Jk1zEX9MEjfMVE30WY0lM3bRt+euH6y38XrQKUhB8go1phL7qdyBkhF8I?=
 =?us-ascii?Q?Op1+wx04uhHUt2F4cCkesj3Tz/sDy+eskyfE3Tm7Ry1XnoqoBnD1JLWZ12Mo?=
 =?us-ascii?Q?mBFMWrXYH2RgWI01rItPSs8oQyv4XDW6AzfIgqK2Z5NuPoq+2GhrGabwLNaX?=
 =?us-ascii?Q?v6NrZvAlFndy6tY0BsEIVJckv87dZW64h29mSEK27/OngH3DkNhtgGxi7fQ1?=
 =?us-ascii?Q?G4TaLwrDvOBIG9kKo/n91EtWgKRvd28LiRIpBiJyixfnAN72nuUVcbuNaKbF?=
 =?us-ascii?Q?poV3N9eQfPtwJOfXSdW3qigWtL8CAuNrPMmJzmLtOeEtNFEsnNbakSqxLkJt?=
 =?us-ascii?Q?by8CPZ9dRPZBpEFOP1OKyyDb5QZMxkWI18nWLJte/rgPJofA2qP+r2SRvKzr?=
 =?us-ascii?Q?1Lb4+NOinmdh7uiBnZrErn1nxPAuqnP32tpKOrwu7MNd4IN6h3cu+T607qcI?=
 =?us-ascii?Q?3dBOsXjBXrXuBVBBxw59n7f7qmPfug+o2jq3+wuWzFn2cMIdMXmfPrngK3+n?=
 =?us-ascii?Q?Vcy9TKzAY5PH6g1gHXVpZ13zv5XOxqL9Z8ab1zf5dgCr3sX1B1vP4K2dJUwe?=
 =?us-ascii?Q?AJpnakD4gyI5uuuK65xO1I7dyUdXhUFZ+VMnan4RuAYa21EDZBIdXKvlu1Ya?=
 =?us-ascii?Q?ww/1mrr8HvT6K5dEZRITYHWalhl24MOUW+wW0aQxgRloKgouKON7AzG+Zc6s?=
 =?us-ascii?Q?Kg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46015e41-c7be-47ed-e234-08de0545a86c
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 02:03:07.8183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W2Y1pXLwSodmyblqS8d8zmr62vfh2cMoMmJ6A/qdBjE03w93Lg5W5a/oCxhB8R46O0Md8amZimi9cD42bE/u0MS0SsssyADcnTz9P1JFgTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6473
X-OriginatorOrg: intel.com

On Mon, Oct 06, 2025 at 06:27:12PM -0700, Alison Schofield wrote:

snip

> > +
> > +	/* relies on cxl_acpi and cxl_pci having had a chance to load */
> > +	wait_for_device_probe();
> 
> The wait_for_device_probe() didn't wait for region probe to complete.
> I couldn't figure out why, so I just 'slept' here in my testing. 
> How is that suppose work? Could I have something config'd wrong?

FWIW I tried region driver with .probe_type = PROBE_PREFER_ASYNCHRONOUS,
but no luck.

snip


