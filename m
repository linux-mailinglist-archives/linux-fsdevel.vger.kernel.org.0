Return-Path: <linux-fsdevel+bounces-55781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBD5B0EBF8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 09:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 632113B6CFF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 07:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BB227701C;
	Wed, 23 Jul 2025 07:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="norSESZf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F182749D9;
	Wed, 23 Jul 2025 07:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753255915; cv=fail; b=O6DP8/b3QYvya3EIzEVXyKPREjMs2GzLpB60zgsbV+7NX7g3/mdcdHJ3ydrhLmhzNXvDS9SWs0mf6PP7V1LafwKTR4aHhJeQl+ZEe3peL4rnGur26Kpw/kPmSVGPsorC+WFNM33dFXo29Rcy8u9VptPqbs9TukGxHs5+u5aKows=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753255915; c=relaxed/simple;
	bh=DBOmUTgzQmFIGgAD1LdJlMkqNBzwltd+0csRLgn/IQo=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=nYb7KMvyzD25aJWscEbWaVwhLARnw1eHHw03psrzXL17JFpPRepZRBS4lwtprWzzjA7+3TEU40z4PvThz6ImNhKhk6IBKB/vuIF2W+DqfKswwCnzUBWJXZ3YuUf0Mp2Hg9RbVrZpeeWDYqY2C9mCVFaiNd9BLCrN9fhg0nY46yU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=norSESZf; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753255914; x=1784791914;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=DBOmUTgzQmFIGgAD1LdJlMkqNBzwltd+0csRLgn/IQo=;
  b=norSESZf0GjDwwYM78EFlC/bn1eKS7Qrsw5SANto8BEwgOyuqCnEZlxl
   vCwu2hoVCKygcnAHnY93tQDZpPq8W56hQK8akWh2+zW3l6+YSwzrNF3S2
   e9LJBnAUbqqfxp5WxAeSGmLzi2HvGR7ImkfMbolwKUIL0sZN9JY8nYyQO
   Ie1o44kRWG0m+GnutvSko+tQg4vZffQgdU3oMyOU+adirwENn5Q5q4UU8
   MDdKPReDuFMCFDmYt480klN0YVw4+f6oyRN36jQKgdINK/g0ShXDBsV/v
   F0/9inVEd2qna+6WHC/69T0QRRWmrqZ/C6vgIL1l4Dt8HFICObupE2SCY
   w==;
X-CSE-ConnectionGUID: RgIQfXB0T+SxxKqLgnhr+A==
X-CSE-MsgGUID: TMwtA8SqTGimWJlvtG2TzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="55482009"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="55482009"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 00:31:53 -0700
X-CSE-ConnectionGUID: 9jNJqxwvTNC5yaoo8XIZ8A==
X-CSE-MsgGUID: dvNjdn/VSi24bsmZTZ3zug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="165003779"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 00:31:53 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 00:31:52 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 23 Jul 2025 00:31:52 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.54) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 00:31:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yatg8NOWAXux8UykKTR0+glmFsOr+Bt8XcawvbD8zb3TB9VpDl2pcCJDucOWjnpODTa3hOWMN7h5woHyHjXOmimEhxuVkM2GdgzXzauEz2YduwD+5afjcrLwVFjsDqQ7uS7PufOVAhGZkQKxKkbAvtZVbdM7RcOA9hWcSslPeL25t5pIjOtUJqkYJ8uBRZVSyHUg9vaa8Vv6GJ0JkQPQQKqPRX4C4rUC+Rto8Qhhu42EkOeGRtuP+enNjtO7NuBOwEAz0/W01U131egrooVkuiZ9F+eHnie2CG4tUm9w4kM+Thme5xxYrsSmorhC6scnguKETUb3A5fPLLsGnC0KkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHoKdps3shwvb6FVC2li4cHZH5A3VnnIVWMhDva//HE=;
 b=LZkZHReIctNro3fOPWIuNEcqJmFYKl0fO94fnE4/mKjsCq7W7Qi1dbxXWqoR5qqReEOY4tR/o/5DrQpr2CbxH7kixBQP30pKEmhoo/wdwGjzfOTtYgBP0J/jY1+/++cUpIQPea1H4uxYN8oSk9n6eaZpe9hTZ6btA/f1KP6I/D2qmEv9pt5bHppIV4fqHnoUF5O96Rd9obVB4q/WCxcSMkSjkYrdiISutMboJeoLyrDo27lNHpqOVzHm7/VeWHx1Km+KKvUFjCOPf3TkAwYq21YaDGtrKZInTJC0CbQiiIMCbRWlfVsX7sR5y6QLQxUeqdFFTBVTD8XmfCuWOH/5Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB7711.namprd11.prod.outlook.com (2603:10b6:510:291::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 23 Jul
 2025 07:31:03 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 07:31:03 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 23 Jul 2025 00:31:00 -0700
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara
	<jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, "Ying
 Huang" <huang.ying.caritas@gmail.com>, Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>,
	Nathan Fontenot <nathan.fontenot@amd.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Terry Bowman
	<terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>, Benjamin Cheatham
	<benjamin.cheatham@amd.com>, PradeepVineshReddy Kodamati
	<PradeepVineshReddy.Kodamati@amd.com>, Zhijian Li <lizhijian@fujitsu.com>
Message-ID: <68808fb4e4cbf_137e6b100cc@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250715180407.47426-4-Smita.KoralahalliChannabasappa@amd.com>
References: <20250715180407.47426-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250715180407.47426-4-Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v5 3/7] cxl/acpi: Add background worker to coordinate with
 cxl_mem probe completion
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0151.namprd03.prod.outlook.com
 (2603:10b6:a03:338::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB7711:EE_
X-MS-Office365-Filtering-Correlation-Id: 6887b3ab-e34c-4870-7b87-08ddc9bae0d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SFBMeU0ybE1MZlpWWHRNUXZsUE5URS82b2hKOGt2bDlBck5WbDdJZitVQ1Fr?=
 =?utf-8?B?ZUswUU5DTE1mbTA0RnJmY2F5ZW5EYVovM0dRVjFWeWd1bGZvdWxkTUx0endn?=
 =?utf-8?B?cy9OWjN3NklmNnJJSVdxL1M1RmcxM1RaTXZJYTAyK0tNRE9nN2NZd0VkVGdp?=
 =?utf-8?B?MjRvUXNCTllCN1BWQm8vay9ya29YdUhaM0R0VEw3TnlpOFdlRHZLeGZjejNi?=
 =?utf-8?B?QmRlTTI0S3JqZ0FqZDRVWTFaMHU1RDRrRGlZTmdLV2hqMXhDK0hiMlNUQzda?=
 =?utf-8?B?OEo5cUQvWk53b1ZDYS9YbHUyNWJWSnhMY0RRVzVVWE5FRTh1Slg3bXJyVHhk?=
 =?utf-8?B?S3hvR3Zwd2lzeDd0YldmNmpmZ2hyZ1dqOTZJM0gvTUNLa04wVnFZK3Y0ZnJD?=
 =?utf-8?B?eTZOMUlZUkRTSDlYRTBDY0FJTWE5MFVsTnB3NTNxY3FBVWdiNHFhT3l5U2xu?=
 =?utf-8?B?b2R6UnpqZnZ1MXdtYWdQOUNORFZmUEZBSHZaTlVWcE44ZjBtUncyOHNER0hH?=
 =?utf-8?B?RjlWQ1RVeDlKQnl0bEl5MDBTbVhpZVJ0RHVnRDBqaHZxdkhDbkZZbW5Qcm9S?=
 =?utf-8?B?M0lFYjUwazVudEtWVUt2RFhuWXJ2aHZONmZmaG1RQmt1WFFvK1IxU0lyRi9s?=
 =?utf-8?B?TXlJdFJBSlJzZERlWVRxS1ZTbEtwTy9pKzBWSUliUGlLYW5EbVdvUXViR1F1?=
 =?utf-8?B?Tnd5ZFpmY01WZGdVUER2Y2ZSMytVVmg4SlhkRGlaWG5TTjJrdFM2OTh3b3Ix?=
 =?utf-8?B?OEp3TERlNmEyYnVVT3lLMTgvK1B0c0hITVk2UCs5MVNkc05ObEZIbzJwc0Ur?=
 =?utf-8?B?d1NoaVZHeGJLcHkvSldUMUZWT0FmMVdZN2FRVkQ4eTF1Mk0wdWtRVzF0MlhJ?=
 =?utf-8?B?TlBZeTVsSm1lWkFyQm52WUxpVHFBRVk4b2thU25aK29VYnpyUmJxRDQrUTRj?=
 =?utf-8?B?VnBqNVMvOUNHcmN1TDFkNm94T1RRVUJkczgxcEx3ZlpUZ2t5ZVY0QU1iOWh0?=
 =?utf-8?B?U2kybEtueXIvbCs5U1hrSWI3SVNZNGlnemhrTk16cy93YzRXV3NDZW5XRllG?=
 =?utf-8?B?eDk5bVU3SFhtZVlKWWFCQUpoRk1GMmVKcWFKUWpZa3BLMElBekFDNWgrSHMy?=
 =?utf-8?B?K09GVDhoajRCdUFDTi83L1pFckQxdUcycVZ4aU9wZ094WGxxSGJqZFpHeXhv?=
 =?utf-8?B?b1VYd0wvVHp0TUYrOWJYNFdLSnRHVHZ0c2NxcDJlbDM5WmxLblQrOFBYZnJl?=
 =?utf-8?B?SFkwNG9BWUR4Q3JFeGRTKy82WUpqdVpRakNCVmt2UjE4YjlST0VmZnpSS1Nu?=
 =?utf-8?B?d1VHS2xINmdTL3kzY0RZN0N3WCtqQkZwaDFjRkF4NXdWZHZzZDF2L2FFbFlG?=
 =?utf-8?B?cGhYeW1YemNmNk1UbkUrSG9kcDNLREx3STF0R0pPV01paXZiemVVRjErU290?=
 =?utf-8?B?ekRJdGZXWmg4c3A5STI3MjdieDU3ZFRVS3lNTTVLdzR5VWdKMEVvTytrWlpR?=
 =?utf-8?B?TE1Ta2RkNkRKWkM4WG9yT2FyZnBhWDRJUFNSV21kWmJQVndCMFp1a2FmU0VY?=
 =?utf-8?B?NjlwRnFCNzhZdXpJUWpRV1FncFcwVC8rS2RacStKWDBKYW04bnYwTW9sTE9l?=
 =?utf-8?B?aVVNOEtaL00yTnBvZHFZWmN2MU1DRTlVVkhlMTJKWlUvSzFiN21EUmRhUjdq?=
 =?utf-8?B?OHFsZ2JUdGdUZWI3blRpemsvUjRlVzBUR2szNGNQMmZFZ2ZReFFUbFdockda?=
 =?utf-8?B?dDhFYlR6SjJESy9KT2MrQ2taSFQwU3lkSkhNYS9BT3hkMmhidGVNWC9BbWI5?=
 =?utf-8?B?U1pJN3BsS1BtdlRNU0oxNHlHVExHemRnWFhiR2ErUFAwVW81UEdpQmhEejU3?=
 =?utf-8?B?MmkyQ1VvZGgzRmpHRkJveHZrTEswSmttSytNVUhzQW5sQWFMYnkrcVR6R0h1?=
 =?utf-8?Q?jfIyh62RFcA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTBlb1VhcldXZFlISjV0RkgrVXZiTGordW92eDZaZno3eHN1QUVTLzB4MTcr?=
 =?utf-8?B?dDZIVkptWFNGK2g3VWlPWlFwTS9RRExjcEg1N3NyVFB5ekQ1QllVVldqSWlE?=
 =?utf-8?B?ZHRoamxVblZZZHEydVBxd3FjdVNjNmlmQmJPNG9YTEhqTmNHQXhHTWN1MER5?=
 =?utf-8?B?eHAvdTB0dmFYbE9Dc3RTVFd1eWJqQTlESTcwR1hQSDFaSVlmKzdUdTJmdFdQ?=
 =?utf-8?B?a3ZyT3NOOU0weVp2OElkdXNtMjJwRWY2NnJnSEl0eTVKOHBOL1NZTHdJeFRx?=
 =?utf-8?B?TEV2VTVvOU5GcVpjRTBwb1c4MUtTbHhMaTBIKzArSTZNNU55QjA4cGhna3p1?=
 =?utf-8?B?bXlIYjcyL29aR0pUT3dTeXFMM0s3Y2UzR1luRXpOWmY0a0ZYL20vVVpkTXA3?=
 =?utf-8?B?Ky9kcEk0ZFNPUnBXdHJqbnQyRWFBZExLUmtyWGs0RGU3blFBck01K00zOGJu?=
 =?utf-8?B?ZXorekVyaUtqdXZPcUcyMTdrcjRFVmdidEpPUmpFOVNRNGM1NWhHeVJNOEtM?=
 =?utf-8?B?L0VKb0paVHQ2NVJMNHMvVEx6ODI0aVVwWWVRajQ0Y1lDVzI1ZWErYUZkSndU?=
 =?utf-8?B?UlZSbnZMRTRMbFBsd0FWWmIvRXhNRnJMS2tSNzNvZDJLaTdEWHpGNDd6a2hq?=
 =?utf-8?B?eDNvUkZMVnAwYW1aMjZpQ2pJenZaYjFTZk90UUhLK0VpaWkxejk2ak9pblhC?=
 =?utf-8?B?dWdwNG9udUxUOVlMY0dLSFJkaDdEeTZ6eG5jb1E2ZGVoYVE0ZU9wendybU9V?=
 =?utf-8?B?cGtVdWtRZm5RcTByZmQ3Z2dhRTNIV0lXVTBpaTdzVFdzVy82cTJtVXRsaWNF?=
 =?utf-8?B?ZEtZdHpPTmVGZGxnL2VEVUxHQ1JDaHg5YVZ4NWd5OUw1M0RpN0RUNDlnQkhL?=
 =?utf-8?B?TDNqRUlLUjZKQVA3dVZtVE9ZU09hb1VVd09kR3RMTGVGZXEzdjZFdDFpa2tO?=
 =?utf-8?B?Yzg4OU0rUDUwQlFranhPYmNnNU41RGFQMzErZHJpRCtkejJRMVF5aGV5R2NV?=
 =?utf-8?B?ZEh6LzZqS052MnFDUFQ0S0hqTitjdTIwNlJzSHNxOFRuTUZ0Ly9RcU1PMzNG?=
 =?utf-8?B?bGJ1eDdJdDRybUdOOTRhV3hSVnNENUdFelRSczVHNE1BZmhoTDhzUmlKLzRw?=
 =?utf-8?B?YUFxWnRoK3Vtb08vSFN5VktHeHplaEtYbFRhK1FSeUpBRHM1am9HR2Y1WlMv?=
 =?utf-8?B?WnRXN1hqQTFVckluaU5sZ3dFZ3pXVHVFUmhMRldqUjBWVjFYZURpd1dNKzNH?=
 =?utf-8?B?b05aT2NGRG45RGNWcDc4TU1kaUhpUVptcU9BWHVMTzlCaXRTLzdjSkN2M0lI?=
 =?utf-8?B?QmZGWGw1bnNERjV1NWtZLytDR1pnVWh1OW54L09QcmhReVhTLzFnNzJHR2Qx?=
 =?utf-8?B?OE5HNmdrdTdOTTlTb29ET3prZjh6UjlWNFpQN1JzRFdDMzhndjY0eGZlUFBV?=
 =?utf-8?B?Smh3enZHMHVhSDRrQnFrRTYrNXNSOGpra2xDY2xXd1EzOERuWjYwMHRpNFhB?=
 =?utf-8?B?TlpSUDBjdWhMTWF5eTNlZC9uYnRjUHlNZEZVMEtGSHExaG1nNjBUaHNDWFhx?=
 =?utf-8?B?ZlNsK0JmRUFZWnVGUFI5dHo1Rm9KQlc0OWlZWGJ4NnNzUHhxYkJJR29jVnBa?=
 =?utf-8?B?UVpnclE4aG9XN1h2SHkyNUlzVnNEZkxrM0UzV3pZU1BTQk5xQ2NrSEtzWjJJ?=
 =?utf-8?B?b0NDSGRQTlJXMUN2Qk1tbFYvczF5cmEvTHdwVXlqV1pQWTZMSkF5VVFkWkd6?=
 =?utf-8?B?bEljU2JRdHBtbFI5WmhuNHo3MUk4T2E3Qm9PT3NKK2VOU2p2YWl5d2p2eGE5?=
 =?utf-8?B?d2FDaFpqa0RWNm13TXRlVmp3U2E0NFZaUFlIVk9GZjQ2aHppOFFJM2sxWVhC?=
 =?utf-8?B?TG5qNHpoWWxzYWZ3eko0aHRjeDBYODlhTmhkUDc4VkszMlM2dHp6MXlhdisw?=
 =?utf-8?B?YWR3VURTN2NndmZvUzczczlBY01iRy9kNU5wSEtEWE42cXZDdHlOeFdNQlFq?=
 =?utf-8?B?cGtVdk1IMzNtUHZyZG5CNEVaNmFYN1FhYWdhTDFFWDA0Y3RBQ28zWStpc1RU?=
 =?utf-8?B?b0ZEMlo0VDBYRGlqQVVPVExaK1NhZmxzNHVXNDVDZEZZSmRON1IzYTQyNEhl?=
 =?utf-8?B?c2QwRDlmR3RBU01HRjVoTXAyaDR0K1NCNGRKWENWYWZQTGJFcWVPMlRNaDdI?=
 =?utf-8?B?VWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6887b3ab-e34c-4870-7b87-08ddc9bae0d4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 07:31:03.1883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /UiGVbo3T1QC/BpPYHKOzmB6JqvycWwpd8ZyHWTa/doAUTU3eYPfDFA5THm7rzQQHnGwDkhEOSq0pGZcm6HczM+lGRJwl5Vv7Mo7V2QS7uQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7711
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:
> Introduce a background worker in cxl_acpi to delay SOFT RESERVE handling
> until the cxl_mem driver has probed at least one device. This coordination
> ensures that DAX registration or fallback handling for soft-reserved
> regions is not triggered prematurely.
> 
> The worker waits on cxl_wait_queue, which is signaled via
> cxl_mem_active_inc() during cxl_mem_probe(). Once at least one memory
> device probe is confirmed, the worker invokes wait_for_device_probe()
> to allow the rest of the CXL device hierarchy to complete initialization.
> 
> Additionally, it also handles initialization order issues where
> cxl_acpi_probe() may complete before other drivers such as cxl_port or
> cxl_mem have loaded, especially when cxl_acpi and cxl_port are built-in
> and cxl_mem is a loadable module. In such cases, using only
> wait_for_device_probe() is insufficient, as it may return before all
> relevant probes are registered.

Right, but that problem is not solved by this which still leaves the
decision on when to give up on this mechanism, and this mechanism does
not tell you when follow-on probe work is complete.

> While region creation happens in cxl_port_probe(), waiting on
> cxl_mem_active() would be sufficient as cxl_mem_probe() can only succeed
> after the port hierarchy is in place. Furthermore, since cxl_mem depends
> on cxl_pci, this also guarantees that cxl_pci has loaded by the time the
> wait completes.
> 
> As cxl_mem_active() infrastructure already exists for tracking probe
> activity, cxl_acpi can use it without introducing new coordination
> mechanisms.

In appreciate the instinct to not add anything new, but the module
loading problem is solvable.

If the goal is: "I want to give device-dax a point at which it can make
a go / no-go decision about whether the CXL subsystem has properly
assembled all CXL regions implied by Soft Reserved instersecting with
CXL Windows." Then that is something like the below, only lightly tested
and likely regresses the non-CXL case.

-- 8< --
From 48b25461eca050504cf5678afd7837307b2dd14f Mon Sep 17 00:00:00 2001
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 22 Jul 2025 16:11:08 -0700
Subject: [RFC PATCH] dax/cxl: Defer Soft Reserved registration

CXL and dax_hmem fight over "Soft Reserved" (EFI Specific Purpose Memory)
resources are published in the iomem resource tree. The entry blocks some
CXL hotplug flows, and CXL blocks dax_hmem from publishing the memory in
the event that CXL fails to parse the platform configuration.

Towards resolving this conflict: (the non-RFC version
of this patch should split these into separate patches):

1/ Defer publishing "Soft Reserved" entries in the iomem resource tree
   until the consumer, dax_hmem, is ready to use them.

2/ Fix detection of "Soft Reserved" vs "CXL Window" resource overlaps by
   switching from MODULE_SOFTDEP() to request_module() for making sure that
   cxl_acpi has had a chance to publish "CXL Window" resources.

3/ Add cxl_pci to the list of modules that need to have had a chance to
   scan boot devices such that wait_device_probe() flushes initial CXL
   topology discovery.

4/ Add a workqueue that delays consideration of "Soft Reserved" that
   overlaps CXL so that the CXL subsystem can complete all of its region
   assembly.

For RFC purposes this only solves the reliabilty of the DAX_CXL_MODE_DROP
case. DAX_CXL_MODE_REGISTER support can follow to shutdown CXL in favor of
vanilla DAX devices as an emergency fallback for platform configuration
quirks and bugs.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/kernel/e820.c    |  2 +-
 drivers/dax/hmem/device.c |  4 +-
 drivers/dax/hmem/hmem.c   | 94 +++++++++++++++++++++++++++++++++------
 include/linux/ioport.h    | 25 +++++++++++
 kernel/resource.c         | 58 +++++++++++++++++++-----
 5 files changed, 156 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index c3acbd26408b..aef1ff2cabda 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1153,7 +1153,7 @@ void __init e820__reserve_resources_late(void)
 	res = e820_res;
 	for (i = 0; i < e820_table->nr_entries; i++) {
 		if (!res->parent && res->end)
-			insert_resource_expand_to_fit(&iomem_resource, res);
+			insert_resource_late(res);
 		res++;
 	}
 
diff --git a/drivers/dax/hmem/device.c b/drivers/dax/hmem/device.c
index f9e1a76a04a9..22732b729017 100644
--- a/drivers/dax/hmem/device.c
+++ b/drivers/dax/hmem/device.c
@@ -83,8 +83,8 @@ static __init int hmem_register_one(struct resource *res, void *data)
 
 static __init int hmem_init(void)
 {
-	walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED,
-			IORESOURCE_MEM, 0, -1, NULL, hmem_register_one);
+	walk_soft_reserve_res_desc(IORES_DESC_SOFT_RESERVED, IORESOURCE_MEM, 0,
+				   -1, NULL, hmem_register_one);
 	return 0;
 }
 
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index 5e7c53f18491..0916478e3817 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -59,9 +59,45 @@ static void release_hmem(void *pdev)
 	platform_device_unregister(pdev);
 }
 
+static enum dax_cxl_mode {
+	DAX_CXL_MODE_DEFER,
+	DAX_CXL_MODE_REGISTER,
+	DAX_CXL_MODE_DROP,
+} dax_cxl_mode;
+
+static int handle_deferred_cxl(struct device *host, int target_nid,
+				const struct resource *res)
+{
+	if (region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
+			      IORES_DESC_CXL) != REGION_DISJOINT) {
+		if (dax_cxl_mode == DAX_CXL_MODE_DROP)
+			dev_dbg(host, "dropping CXL range: %pr\n", res);
+	}
+	return 0;
+}
+
+struct dax_defer_work {
+	struct platform_device *pdev;
+	struct work_struct work;
+};
+
+static void process_defer_work(struct work_struct *_work)
+{
+	struct dax_defer_work *work = container_of(_work, typeof(*work), work);
+	struct platform_device *pdev = work->pdev;
+
+	/* relies on cxl_acpi and cxl_pci having had a chance to load */
+	wait_for_device_probe();
+
+	dax_cxl_mode = DAX_CXL_MODE_DROP;
+
+	walk_hmem_resources(&pdev->dev, handle_deferred_cxl);
+}
+
 static int hmem_register_device(struct device *host, int target_nid,
 				const struct resource *res)
 {
+	struct dax_defer_work *work = dev_get_drvdata(host);
 	struct platform_device *pdev;
 	struct memregion_info info;
 	long id;
@@ -70,14 +106,21 @@ static int hmem_register_device(struct device *host, int target_nid,
 	if (IS_ENABLED(CONFIG_CXL_REGION) &&
 	    region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
 			      IORES_DESC_CXL) != REGION_DISJOINT) {
-		dev_dbg(host, "deferring range to CXL: %pr\n", res);
-		return 0;
+		switch (dax_cxl_mode) {
+		case DAX_CXL_MODE_DEFER:
+			dev_dbg(host, "deferring range to CXL: %pr\n", res);
+			schedule_work(&work->work);
+			return 0;
+		case DAX_CXL_MODE_REGISTER:
+			dev_dbg(host, "registering CXL range: %pr\n", res);
+			break;
+		case DAX_CXL_MODE_DROP:
+			dev_dbg(host, "dropping CXL range: %pr\n", res);
+			return 0;
+		}
 	}
 
-	rc = region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
-			       IORES_DESC_SOFT_RESERVED);
-	if (rc != REGION_INTERSECTS)
-		return 0;
+	/* TODO: insert "Soft Reserved" into iomem here */
 
 	id = memregion_alloc(GFP_KERNEL);
 	if (id < 0) {
@@ -123,8 +166,30 @@ static int hmem_register_device(struct device *host, int target_nid,
 	return rc;
 }
 
+static void kill_defer_work(void *_work)
+{
+	struct dax_defer_work *work = container_of(_work, typeof(*work), work);
+
+	cancel_work_sync(&work->work);
+	kfree(work);
+}
+
 static int dax_hmem_platform_probe(struct platform_device *pdev)
 {
+	struct dax_defer_work *work = kzalloc(sizeof(*work), GFP_KERNEL);
+	int rc;
+
+	if (!work)
+		return -ENOMEM;
+
+	work->pdev = pdev;
+	INIT_WORK(&work->work, process_defer_work);
+
+	rc = devm_add_action_or_reset(&pdev->dev, kill_defer_work, work);
+	if (rc)
+		return rc;
+
+	platform_set_drvdata(pdev, work);
 	return walk_hmem_resources(&pdev->dev, hmem_register_device);
 }
 
@@ -139,6 +204,16 @@ static __init int dax_hmem_init(void)
 {
 	int rc;
 
+	/*
+	 * Ensure that cxl_acpi and cxl_pci have a chance to kick off
+	 * CXL topology discovery at least once before scanning the
+	 * iomem resource tree for IORES_DESC_CXL resources.
+	 */
+	if (IS_ENABLED(CONFIG_CXL_REGION)) {
+		request_module("cxl_acpi");
+		request_module("cxl_pci");
+	}
+
 	rc = platform_driver_register(&dax_hmem_platform_driver);
 	if (rc)
 		return rc;
@@ -159,13 +234,6 @@ static __exit void dax_hmem_exit(void)
 module_init(dax_hmem_init);
 module_exit(dax_hmem_exit);
 
-/* Allow for CXL to define its own dax regions */
-#if IS_ENABLED(CONFIG_CXL_REGION)
-#if IS_MODULE(CONFIG_CXL_ACPI)
-MODULE_SOFTDEP("pre: cxl_acpi");
-#endif
-#endif
-
 MODULE_ALIAS("platform:hmem*");
 MODULE_ALIAS("platform:hmem_platform*");
 MODULE_DESCRIPTION("HMEM DAX: direct access to 'specific purpose' memory");
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index e8b2d6aa4013..4fc6ab518c24 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -232,6 +232,9 @@ struct resource_constraint {
 /* PC/ISA/whatever - the normal PC address spaces: IO and memory */
 extern struct resource ioport_resource;
 extern struct resource iomem_resource;
+#ifdef CONFIG_EFI_SOFT_RESERVE
+extern struct resource soft_reserve_resource;
+#endif
 
 extern struct resource *request_resource_conflict(struct resource *root, struct resource *new);
 extern int request_resource(struct resource *root, struct resource *new);
@@ -255,6 +258,22 @@ int adjust_resource(struct resource *res, resource_size_t start,
 		    resource_size_t size);
 resource_size_t resource_alignment(struct resource *res);
 
+
+#ifdef CONFIG_EFI_SOFT_RESERVE
+static inline void insert_resource_late(struct resource *new)
+{
+	if (new->desc == IORES_DESC_SOFT_RESERVED)
+		insert_resource_expand_to_fit(&soft_reserve_resource, new);
+	else
+		insert_resource_expand_to_fit(&iomem_resource, new);
+}
+#else
+static inline void insert_resource_late(struct resource *new)
+{
+	insert_resource_expand_to_fit(&iomem_resource, new);
+}
+#endif
+
 /**
  * resource_set_size - Calculate resource end address from size and start
  * @res: Resource descriptor
@@ -409,6 +428,12 @@ walk_system_ram_res_rev(u64 start, u64 end, void *arg,
 extern int
 walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start, u64 end,
 		    void *arg, int (*func)(struct resource *, void *));
+int walk_soft_reserve_res_desc(unsigned long desc, unsigned long flags,
+			       u64 start, u64 end, void *arg,
+			       int (*func)(struct resource *, void *));
+int region_intersects_soft_reserve(struct resource *root, resource_size_t start,
+				   size_t size, unsigned long flags,
+				   unsigned long desc);
 
 struct resource *devm_request_free_mem_region(struct device *dev,
 		struct resource *base, unsigned long size);
diff --git a/kernel/resource.c b/kernel/resource.c
index 8d3e6ed0bdc1..fd90990c31c6 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -321,8 +321,8 @@ static bool is_type_match(struct resource *p, unsigned long flags, unsigned long
 }
 
 /**
- * find_next_iomem_res - Finds the lowest iomem resource that covers part of
- *			 [@start..@end].
+ * find_next_res - Finds the lowest resource that covers part of
+ *		   [@start..@end].
  *
  * If a resource is found, returns 0 and @*res is overwritten with the part
  * of the resource that's within [@start..@end]; if none is found, returns
@@ -337,9 +337,9 @@ static bool is_type_match(struct resource *p, unsigned long flags, unsigned long
  * The caller must specify @start, @end, @flags, and @desc
  * (which may be IORES_DESC_NONE).
  */
-static int find_next_iomem_res(resource_size_t start, resource_size_t end,
-			       unsigned long flags, unsigned long desc,
-			       struct resource *res)
+static int find_next_res(struct resource *parent, resource_size_t start,
+			 resource_size_t end, unsigned long flags,
+			 unsigned long desc, struct resource *res)
 {
 	struct resource *p;
 
@@ -351,7 +351,7 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
 
 	read_lock(&resource_lock);
 
-	for_each_resource(&iomem_resource, p, false) {
+	for_each_resource(parent, p, false) {
 		/* If we passed the resource we are looking for, stop */
 		if (p->start > end) {
 			p = NULL;
@@ -382,16 +382,23 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
 	return p ? 0 : -ENODEV;
 }
 
-static int __walk_iomem_res_desc(resource_size_t start, resource_size_t end,
-				 unsigned long flags, unsigned long desc,
-				 void *arg,
-				 int (*func)(struct resource *, void *))
+static int find_next_iomem_res(resource_size_t start, resource_size_t end,
+			       unsigned long flags, unsigned long desc,
+			       struct resource *res)
+{
+	return find_next_res(&iomem_resource, start, end, flags, desc, res);
+}
+
+static int walk_res_desc(struct resource *parent, resource_size_t start,
+			 resource_size_t end, unsigned long flags,
+			 unsigned long desc, void *arg,
+			 int (*func)(struct resource *, void *))
 {
 	struct resource res;
 	int ret = -EINVAL;
 
 	while (start < end &&
-	       !find_next_iomem_res(start, end, flags, desc, &res)) {
+	       !find_next_res(parent, start, end, flags, desc, &res)) {
 		ret = (*func)(&res, arg);
 		if (ret)
 			break;
@@ -402,6 +409,15 @@ static int __walk_iomem_res_desc(resource_size_t start, resource_size_t end,
 	return ret;
 }
 
+static int __walk_iomem_res_desc(resource_size_t start, resource_size_t end,
+				 unsigned long flags, unsigned long desc,
+				 void *arg,
+				 int (*func)(struct resource *, void *))
+{
+	return walk_res_desc(&iomem_resource, start, end, flags, desc, arg, func);
+}
+
+
 /**
  * walk_iomem_res_desc - Walks through iomem resources and calls func()
  *			 with matching resource ranges.
@@ -426,6 +442,26 @@ int walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start,
 }
 EXPORT_SYMBOL_GPL(walk_iomem_res_desc);
 
+#ifdef CONFIG_EFI_SOFT_RESERVE
+struct resource soft_reserve_resource = {
+	.name	= "Soft Reserved",
+	.start	= 0,
+	.end	= -1,
+	.desc	= IORES_DESC_SOFT_RESERVED,
+	.flags	= IORESOURCE_MEM,
+};
+EXPORT_SYMBOL_GPL(soft_reserve_resource);
+
+int walk_soft_reserve_res_desc(unsigned long desc, unsigned long flags,
+			       u64 start, u64 end, void *arg,
+			       int (*func)(struct resource *, void *))
+{
+	return walk_res_desc(&soft_reserve_resource, start, end, flags, desc,
+			     arg, func);
+}
+EXPORT_SYMBOL_GPL(walk_soft_reserve_res_desc);
+#endif
+
 /*
  * This function calls the @func callback against all memory ranges of type
  * System RAM which are marked as IORESOURCE_SYSTEM_RAM and IORESOUCE_BUSY.
-- 
2.50.1

