Return-Path: <linux-fsdevel+bounces-70368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA9AC98ED3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 20:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D85A8345BAB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 19:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F372620D2;
	Mon,  1 Dec 2025 19:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G71mCmHS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB48224A044;
	Mon,  1 Dec 2025 19:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764618980; cv=fail; b=YbyU2fIVD5V4hY380K8EhqF5ySat36KtpbUGTgTn54kjngQPCKAcHDV5L63Kv7YPBr4jUaOxIR7nRVPWwkIzV+uge5TI8uqTLUr+z4+DB5ImYgGpQErMP2G/n610aCD3urhBmdotx9gN1HCvQ0iwGeK92/DHy44h/Xbv8nxjrow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764618980; c=relaxed/simple;
	bh=dw0Y6jbpcX3djgHEg8HSZgiM+pRzwEoZfXdMsvxkvjQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l2kRYXi7ODoym9onQYTPfHNwdG6cm30BlID669YkFaiJUB6AyOWGv1eWvK9bBefmUqoePLe03RCbJrrKyHBlV9Nml/zFV8rq3d/2DGoMvK5T3CRlf5NiXe+olJEPGIm4K9Lp0I2CEiOPRU2slXf4A3vNQmNMliBY5s8rzzzIAak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G71mCmHS; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764618977; x=1796154977;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dw0Y6jbpcX3djgHEg8HSZgiM+pRzwEoZfXdMsvxkvjQ=;
  b=G71mCmHSmkiwm2sZBS5wVTyEMh9n7PBpaLLjEG14KCdmPUTPK61yppBp
   NXzWhCMd82rCCL6yXpNzJBHpyKEGB3CPXjqWNEhDhpTq1z2cBPg/VnM7a
   sv3FmKR9/8fhP4201ohQkgtmtyG19C2mylnoQJAePvIEI8Ob5p94D7QwV
   KCstqzF2QsXMYNr5n6z6UTg8cwqBI8aMDlOOLlnfPstuNq591FybRCCXr
   iy0fGse7snB6SizSC7sDhG9XjCOq0GEct8aXOlEzjwQ+WrIJfdH/kNoBE
   qSm0qm8N7vvPCGG+aSWD8UUXCsoLX3US6wqr6yCNewUcvxJpXP+Dzt4+f
   g==;
X-CSE-ConnectionGUID: 2pFTbCv1S1yf6qEmG9faPQ==
X-CSE-MsgGUID: /LgKju+qSoaAudXJXyDbYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="83965092"
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="83965092"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 11:56:17 -0800
X-CSE-ConnectionGUID: 5mqnHMouQv+9I/NYaSOYGw==
X-CSE-MsgGUID: Xt/Wb0rpSx2BPq4wiDbyoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="217506663"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 11:56:16 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 1 Dec 2025 11:56:16 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 1 Dec 2025 11:56:15 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.44) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 1 Dec 2025 11:56:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nhk9CLggMorDhr75nu+uu9ytDDNz/PP9D3xoICI+W0FhxsVTVZ4dYdXfk8ir8QLIKA3DGiwBSK04ZkNQAues5tNaFcjPIxmwoFtG2FFTNH9FB/+sN00RP/fKHTAFF2j0sA6Qjru0vCj860DphG/hfaeQbGND1d83yD7AZDcdWgHYQqDn+2xj9Pi6POZVu5Ty6u4xrCFnHtyPZC3MD5ylAIkSGeAnJ4oyu1i6gd/Jt1AFTtGgBt1nFw3gtLhocwhyRKG78WX5BtoTA4/jQDi3rMg1CCXZJlHDgxZq2pi6yxenc/F/1j3dcj6gqtOmmnMEYoB1bMe7j36nQUzQ47nycw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUI0JEztSAi6RM+IITzX4jBzlfKWdXxVujfpvk2H1kM=;
 b=nhKnYJcwQcI753q10MynWR3kgHPFkhlsr1RTteFV3qJgsYNqSzpEfjHE2mlXQvrDcC2BWTxO/EisNgS25C2Dh9aPKgV0Fchkj2xMoTgANOW88NgM8iPWGX8BxUt0oYt27Z2WmgVhoSkFZc5bzJ8aSSRih5R1ZZygifUoBZFHrTHX1fG9k2jGyw1bcBdd5EI7u3mO6nV7FMrL9foH8dcGKZ9cK7Lpss9Qm3zgPhuqDkrXpUZMgSDVdkdlEOnjrVw+COJA5w1tH5gyzHGSX/oA3M2LwNB6Ts60SpLnnu1PHUrR0jGfddcNEKrpcEnSJ0plTDvdAQRTHK7cg9Z5A1F66Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA1PR11MB6781.namprd11.prod.outlook.com (2603:10b6:806:25d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 19:56:08 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 19:56:08 +0000
Date: Mon, 1 Dec 2025 11:56:02 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Matthew Wilcox <willy@infradead.org>, Jan Kara
	<jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, "Ying
 Huang" <huang.ying.caritas@gmail.com>, Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>,
	Nathan Fontenot <nathan.fontenot@amd.com>, Terry Bowman
	<terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>, Benjamin Cheatham
	<benjamin.cheatham@amd.com>, Zhijian Li <lizhijian@fujitsu.com>, "Borislav
 Petkov" <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v4 0/9] dax/hmem, cxl: Coordinate Soft Reserved handling
 with CXL and HMEM
Message-ID: <aS3y0j96t1ygwJsR@aschofie-mobl2.lan>
References: <20251120031925.87762-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251120031925.87762-1-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: BY1P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::17) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA1PR11MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aaae78a-31c7-442a-797d-08de3113ab19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2No5i4mi1aQt1+EWQX9F3ZPceDVIqGL6QDF7R93/0pMoUbaL5ZJhod0RCern?=
 =?us-ascii?Q?j/Zq1otejTGmHqKkRn45uSzISe03YF0lSvXzH6pLbn3iyzBzyrxNTTAN+No0?=
 =?us-ascii?Q?IyOv4hAUp18doKU/KvIyPoBNVdw5UJGB7QyQDQ+r+/YzgCJyb0djeiFGjPGM?=
 =?us-ascii?Q?IUlDwt1bxjxcPijqJzUUlY5A6bH7GLp5kvz+TOb0ABTXx52wxNAit93M0IWd?=
 =?us-ascii?Q?mZk3lUTo72FmeFq3vQEeOS01xBVFwK4WN7VvO1MIXMv/XPmP5MsEnCNcqLf2?=
 =?us-ascii?Q?Dq9MSiqRirkr0kZk1CeMUj8zNJxsAuPItByWryYNOZdpX8FPfXLeYvWxg/Mx?=
 =?us-ascii?Q?/F29RvbpCnunAxiGTf9KESAH7wWPLssgQzVss7ylrM3PE3WasuXoMI9d27pE?=
 =?us-ascii?Q?Qx5X8x+9VJQL2AyB9dFTJHQHve+GR0hSkmGTmD0JVE2YMh6kqXJDt7ETJ0ZH?=
 =?us-ascii?Q?iOw9NCndkFzrTjtyhY+KNvlfJmBaM3Xq8iReS9SM5lYNg932TsO5vcke36Jt?=
 =?us-ascii?Q?A++WnTynzqG3edRXjsnho0iEo+2AryJub6YhxFYUekAHPa56dgXWYGjtKQLy?=
 =?us-ascii?Q?Z2up6Y7SJZ9lE1QbmpeBIjhdg08+CfYViJ3WN3cvWHpxN35fLksRbup6P6wS?=
 =?us-ascii?Q?vxMylqxOWRgEApIfBoyL5O0kVOZESDz5qgfidKYDgYIGvRgAJljfaPHH6lPE?=
 =?us-ascii?Q?vk8+9FMEEfikLGDZ4D3GFDYO2irH+RMP77dFL7Xw+F6/gR7GYvCZ3HdquCMz?=
 =?us-ascii?Q?O+xGnj+SD4k+vY9OyNB0Oz19K7L/FZV61g3VAYIGcz94+LGZIIu5TEVigm8S?=
 =?us-ascii?Q?ylds7v/yeO448LIUdsC5HlC4bldcdJ0X/SAYHMpGMClYPOsqgBZYFlDosmME?=
 =?us-ascii?Q?EnajVfIgaMkpFZBrLjZO/Hx34J0BgUjKbTl035iFFVP0oec96ujIwno+ECQ7?=
 =?us-ascii?Q?yuZoF62HJmGHmkMbTs+1QWofAMFi3P8KGk2spjUiZUe49qS8wJySMgotIQJ7?=
 =?us-ascii?Q?1J8k3wVlnbC8b/25vpxqh1rUoe5kvFMseqnW/3fYvdLnDZw09uCzuj7HUBCf?=
 =?us-ascii?Q?E5zbW1GaVSUbbOnnuaE+WjTnWHL4sbX70300uBTl1bvDu52xXEy1DaKc3FXG?=
 =?us-ascii?Q?eyLEkx2ecIbHrknGaBdkHB/1Ki8nUKfgJqV3MUkGzzJaTMBwaFDQCpy1rt6S?=
 =?us-ascii?Q?1Gi/Vn/cJAxQkcMO9lo2Oxw+UjFI8R+WlAuMtVKFdhLJKg/nDdfQyptTQNIx?=
 =?us-ascii?Q?ODJMATAusY2437OFbIn6GCnJcwIuEi6+HUGiXu7td9P6BeCOMaOOA0soFwYr?=
 =?us-ascii?Q?FqJ4jkJVgff8/2EyWjJjOSG9Pe6+er+QfLhpYAl2DrlnV/bHGv1Ae2el4D3W?=
 =?us-ascii?Q?2IIOzoSHfUMmmPCsYVvEiRJH7vew/lTQQPJOX8e9f2nr2q1qB9jRDGmgH8tM?=
 =?us-ascii?Q?xvqpEwViymck7aJfJAxPglLJYZDzv0QEQ4hKARilMUI3HjDLkUv8ZA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BtxKjHu9sYnstS89SVtK8T7o3J0HB+sXIce5aHxOU5czOKlutw3R/48wLsO+?=
 =?us-ascii?Q?jfnBECl70DTSc5rJxf9mjGtxvRiu3STaN8N04T2CJt7AERCdqmsMUbmU4Ro5?=
 =?us-ascii?Q?meVm5YHKV3Z4nFHHOujmhVla628HwkqmnH0H767FqZCDiJ+TtZP/ekiVBS0l?=
 =?us-ascii?Q?NEb56ZT89rs08JNmNwhJQKpRYHEc2ZWr2wBH/PrJhAcwcf05sBFVpZnSPdz0?=
 =?us-ascii?Q?qQ9JcKC7E2vXxJgF0/wq5se4C9PEaDJmTIrn4Ed92rGOt8SyA63bwtxGaXaJ?=
 =?us-ascii?Q?IfVXXrWnGJMLJzUA8hBkzp4Kxm8Jx6xt+wOZIsxBZuN4kkJ25KdteZx2gZiZ?=
 =?us-ascii?Q?9+L8TEGtbPckgUn5me+6WTZdVAxqSKYhaxbbU0zweuPVRCDIUL/91trPSPbQ?=
 =?us-ascii?Q?ZlFzc4zZaDNZwB3Wh6OskeqHTRY3UbOAYV9WkJD1DP5Kobn0GciKqfTLPJU5?=
 =?us-ascii?Q?RYBBH3wu5oPMUzNfqm4AMukRu5uvektgCxQ7OoKTgR0+uVPZ3xkucUA/zPag?=
 =?us-ascii?Q?CwlsPoiHT2UiDFnoA1o1FGmRyPUvAoUFLywYYe4KAe/qFH0UysCcVj9AJMNV?=
 =?us-ascii?Q?En+MHpEUgszaSdeAGcCVTJ+oax6W5HnxzIf1t673urcfsQX6aWSGypKtWiru?=
 =?us-ascii?Q?FWw0GjMMMSJpT6Hk43sr4I+v3RqA/RKO/A9kLU+txYauKdJuBtwaz92SavQi?=
 =?us-ascii?Q?ySSD0q2vtGh7SHq1rYi8yY5UFqCmkUIOtsdeNOhufMeTmNb6apmfK62qHF8n?=
 =?us-ascii?Q?95TElI4GQp2+diTiR4MUqVYhWiqoLojk6Qp6aH1fGH3xuHysMtLYt4i6o0xJ?=
 =?us-ascii?Q?VW+3awHRq8i2HH2O037Iq832mA/vZHn3A8sHeUIEccJyBmJA66tr/J2sdZ6q?=
 =?us-ascii?Q?mRKNuNNv9iyaJJaJXnSi/mA0+Xv51dJ9D0kfmV7O8124afm7NcT1ZKwN8zKT?=
 =?us-ascii?Q?ircFYKkjhlOYTwz3ve53rBm3gh33wp9nbgZS85E3ptDPxC2knaLDD4MCfNEH?=
 =?us-ascii?Q?+oJs+4jjfzkZIdNDfah/E+jfhwWgTy0esDq9urwEgxl82X/AyntOXjErFfqQ?=
 =?us-ascii?Q?Gc/iZyIpAA2W+aE/1ewn0hHTRuyO9MyqFe4rxdQvolTo7PvHZsiGOttaet70?=
 =?us-ascii?Q?GRAzRZltWkzmugxf/Of62ksbfDnAU8rhCRcJfxY1ZcAE5PvCdsprKoBySlDp?=
 =?us-ascii?Q?0PlhOc/6+q9qxZ4hYLQb4l/m+KnAnDwUZ1kzhm6KJZwCSHDAPwDCx28TSc1a?=
 =?us-ascii?Q?Xfow+3QudLqkeZXTuKuImr8ino9Y94uzLg5UpjagEqlPmi0ryl92qHaSNMFY?=
 =?us-ascii?Q?24oml5aeZ7KS9RIUapvfHDpalfVuJn9Buskkl2sYRjpiWCVRoH5qBywCJccy?=
 =?us-ascii?Q?jbtUDI/tH90hPWZ3pf97dso5ArsURDVJhwQs14TmYw6e3AAvDpjtFCJ3UnLV?=
 =?us-ascii?Q?EyiH2E6w/gFOAMUcF1+i768BCJS64ILrNDwfRYWhPoCSMMFDgTJkh3HUBUj7?=
 =?us-ascii?Q?iWKbU6syCQ4e7i8xxJd1WCqRZChjQ8cRePZDmXobREE7WaQUnLHp70MU0jAS?=
 =?us-ascii?Q?4+vrtDu9TT446O/GtSvadgJDHl1VuEiB6Q9mtZ6hlRmmd8QCxY/B1owC4opn?=
 =?us-ascii?Q?bA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aaae78a-31c7-442a-797d-08de3113ab19
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 19:56:08.1038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fzti6ZveKilqB6VE/NTcgdDvkLEi0Jh0mrRtpcTwsYmrFCtJk7qh6k4m86HjIlog5/HFWh/6ZKTIRW8qGeO5ufKXPr6ydsE/m1V21YOLNDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6781
X-OriginatorOrg: intel.com

On Thu, Nov 20, 2025 at 03:19:16AM +0000, Smita Koralahalli wrote:
> This series aims to address long-standing conflicts between HMEM and
> CXL when handling Soft Reserved memory ranges.
> 
> Reworked from Dan's patch:
> https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/patch/?id=ab70c6227ee6165a562c215d9dcb4a1c55620d5d
> 
> Previous work:
> https://lore.kernel.org/all/20250715180407.47426-1-Smita.KoralahalliChannabasappa@amd.com/
> 
> Link to v3:
> https://lore.kernel.org/all/20250930044757.214798-1-Smita.KoralahalliChannabasappa@amd.com
> 
> This series should be applied on top of:
> "214291cbaace: acpi/hmat: Fix lockdep warning for hmem_register_resource()"
> and is based on:
> base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
> 
> I initially tried picking up the three probe ordering patches from v20/v21
> of Type 2 support, but I hit a NULL pointer dereference in
> devm_cxl_add_memdev() and cycle dependency with all patches so I left
> them out for now. With my current series rebased on 6.18-rc2 plus
> 214291cbaace, probe ordering behaves correctly on AMD systems and I have
> verified the scenarios mentioned below. I can pull those three patches
> back in for a future revision once the failures are sorted out.

Hi Smita,

This is a regression from the v3 version for my hotplug test case.
I believe at least partially due to the ommitted probe order patches.
I'm not clear why that 'dax18.0' still exists after region teardown.

Upon booting:
- Do not expect to see that Soft Reserved resource

68e80000000-8d37fffffff : CXL Window 9
  68e80000000-70e7fffffff : region9
    68e80000000-70e7fffffff : Soft Reserved
      68e80000000-70e7fffffff : dax18.0
        68e80000000-70e7fffffff : System RAM (kmem)

After region teardown:
- Do not expect to see that Soft Reserved resource
- Do not expect to see that DAX or kmem

68e80000000-8d37fffffff : CXL Window 9
  68e80000000-70e7fffffff : Soft Reserved
    68e80000000-70e7fffffff : dax18.0
      68e80000000-70e7fffffff : System RAM (kmem)

Create the region anew:
- Here we see a new region and dax devices created in the
available space after the Soft Reserved. We don't want
that. We want to be able to recreate in that original
space of 68e80000000-70e7fffffff.

68e80000000-8d37fffffff : CXL Window 9
  68e80000000-70e7fffffff : Soft Reserved
    68e80000000-70e7fffffff : dax18.0
      68e80000000-70e7fffffff : System RAM (kmem)
  70e80000000-78e7fffffff : region9
    70e80000000-78e7fffffff : dax9.0
      70e80000000-78e7fffffff : System RAM (kmem)


-- Alison


> 
> Probe order patches of interest:
> cxl/mem: refactor memdev allocation
> cxl/mem: Arrange for always-synchronous memdev attach
> cxl/port: Arrange for always synchronous endpoint attach
> 
> [1] Hotplug looks okay. After offlining the memory I can tear down the
> regions and recreate it back if CXL owns entire SR range as Soft Reserved
> is gone. dax_cxl creates dax devices and onlines memory.
> 850000000-284fffffff : CXL Window 0
>   850000000-284fffffff : region0
>     850000000-284fffffff : dax0.0
>       850000000-284fffffff : System RAM (kmem)
> 
> [2] With CONFIG_CXL_REGION disabled, all the resources are handled by
> HMEM. Soft Reserved range shows up in /proc/iomem, no regions come up
> and dax devices are created from HMEM.
> 850000000-284fffffff : CXL Window 0
>   850000000-284fffffff : Soft Reserved
>     850000000-284fffffff : dax0.0
>       850000000-284fffffff : System RAM (kmem)
> 
> [3] Region assembly failures also behave okay and work same as [2].
> 
> Before:
> 2850000000-484fffffff : Soft Reserved
>   2850000000-484fffffff : CXL Window 1
>     2850000000-484fffffff : dax4.0
>       2850000000-484fffffff : System RAM (kmem)
> 
> After tearing down dax4.0 and creating it back:
> 
> Logs:
> [  547.847764] unregister_dax_mapping:  mapping0: unregister_dax_mapping
> [  547.855000] trim_dev_dax_range: dax dax4.0: delete range[0]: 0x2850000000:0x484fffffff
> [  622.474580] alloc_dev_dax_range: dax dax4.1: alloc range[0]: 0x0000002850000000:0x000000484fffffff
> [  752.766194] Fallback order for Node 0: 0 1
> [  752.766199] Fallback order for Node 1: 1 0
> [  752.766200] Built 2 zonelists, mobility grouping on.  Total pages: 8096220
> [  752.783234] Policy zone: Normal
> [  752.808604] Demotion targets for Node 0: preferred: 1, fallback: 1
> [  752.815509] Demotion targets for Node 1: null
> 
> After:
> 2850000000-484fffffff : Soft Reserved
>   2850000000-484fffffff : CXL Window 1
>     2850000000-484fffffff : dax4.1
>       2850000000-484fffffff : System RAM (kmem)
> 
> [4] A small hack to tear down the fully assembled and probed region
> (i.e region in committed state) for range 850000000-284fffffff.
> This is to test the region teardown path for regions which don't
> fully cover the Soft Reserved range.
> 
> 850000000-284fffffff : Soft Reserved
>   850000000-284fffffff : CXL Window 0
>     850000000-284fffffff : dax5.0
>       850000000-284fffffff : System RAM (kmem)
> 2850000000-484fffffff : CXL Window 1
>   2850000000-484fffffff : region1
>     2850000000-484fffffff : dax1.0
>       2850000000-484fffffff : System RAM (kmem)
> .4850000000-684fffffff : CXL Window 2
>   4850000000-684fffffff : region2
>     4850000000-684fffffff : dax2.0
>       4850000000-684fffffff : System RAM (kmem)
> 
> daxctl list -R -u
> [
>   {
>     "path":"\/platform\/ACPI0017:00\/root0\/decoder0.1\/region1\/dax_region1",
>     "id":1,
>     "size":"128.00 GiB (137.44 GB)",
>     "align":2097152
>   },
>   {
>     "path":"\/platform\/hmem.5",
>     "id":5,
>     "size":"128.00 GiB (137.44 GB)",
>     "align":2097152
>   },
>   {
>     "path":"\/platform\/ACPI0017:00\/root0\/decoder0.2\/region2\/dax_region2",
>     "id":2,
>     "size":"128.00 GiB (137.44 GB)",
>     "align":2097152
>   }
> ]
> 
> I couldn't test multiple regions under same Soft Reserved range
> with/without contiguous mapping due to limiting BIOS support. Hopefully
> that works.
> 
> v4 updates:
> - No changes patches 1-3.
> - New patches 4-7.
> - handle_deferred_cxl() has been enhanced to handle case where CXL
> regions do not contiguously and fully cover Soft Reserved ranges.
> - Support added to defer cxl_dax registration.
> - Support added to teardown cxl regions.
> 
> v3 updates:
>  - Fixed two "From".
> 
> v2 updates:
>  - Removed conditional check on CONFIG_EFI_SOFT_RESERVE as dax_hmem
>    depends on CONFIG_EFI_SOFT_RESERVE. (Zhijian)
>  - Added TODO note. (Zhijian)
>  - Included region_intersects_soft_reserve() inside CONFIG_EFI_SOFT_RESERVE
>    conditional check. (Zhijian)
>  - insert_resource_late() -> insert_resource_expand_to_fit() and
>    __insert_resource_expand_to_fit() replacement. (Boris)
>  - Fixed Co-developed and Signed-off by. (Dan)
>  - Combined 2/6 and 3/6 into a single patch. (Zhijian).
>  - Skip local variable in remove_soft_reserved. (Jonathan)
>  - Drop kfree with __free(). (Jonathan)
>  - return 0 -> return dev_add_action_or_reset(host...) (Jonathan)
>  - Dropped 6/6.
>  - Reviewed-by tags (Dave, Jonathan)
> 
> Dan Williams (4):
>   dax/hmem, e820, resource: Defer Soft Reserved insertion until hmem is
>     ready
>   dax/hmem: Request cxl_acpi and cxl_pci before walking Soft Reserved
>     ranges
>   dax/hmem: Gate Soft Reserved deferral on DEV_DAX_CXL
>   dax/hmem: Defer handling of Soft Reserved ranges that overlap CXL
>     windows
> 
> Smita Koralahalli (5):
>   cxl/region, dax/hmem: Arbitrate Soft Reserved ownership with
>     cxl_regions_fully_map()
>   cxl/region: Add register_dax flag to control probe-time devdax setup
>   cxl/region, dax/hmem: Register devdax only when CXL owns Soft Reserved
>     span
>   cxl/region, dax/hmem: Tear down CXL regions when HMEM reclaims Soft
>     Reserved
>   dax/hmem: Reintroduce Soft Reserved ranges back into the iomem tree
> 
>  arch/x86/kernel/e820.c    |   2 +-
>  drivers/cxl/acpi.c        |   2 +-
>  drivers/cxl/core/region.c | 181 ++++++++++++++++++++++++++++++++++++--
>  drivers/cxl/cxl.h         |  17 ++++
>  drivers/dax/Kconfig       |   2 +
>  drivers/dax/hmem/device.c |   4 +-
>  drivers/dax/hmem/hmem.c   | 137 ++++++++++++++++++++++++++---
>  include/linux/ioport.h    |  13 ++-
>  kernel/resource.c         |  92 ++++++++++++++++---
>  9 files changed, 415 insertions(+), 35 deletions(-)
> 
> base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
> -- 
> 2.17.1
> 

