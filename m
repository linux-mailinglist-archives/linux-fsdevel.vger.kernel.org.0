Return-Path: <linux-fsdevel+bounces-70618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 676F9CA210B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 01:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D15AC301584C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 00:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70E91DF73C;
	Thu,  4 Dec 2025 00:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PmwxtvjL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894271514F8;
	Thu,  4 Dec 2025 00:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764809429; cv=fail; b=sCG02CraOMuZJnSD8OWW9fUzhNHleNDGmI/hdMjWITtcWUBuZB+5nd8mwtBOy/2+avPmabCaYnfIZ9lg5ANS11B3vx1tQBnjG5V/BajGzIV56OeCryuOqp54gt6ebc9SLN7mbuXn7KBmAs+PCyL/sE7XfdFnNb7+Z4MVWJIBcNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764809429; c=relaxed/simple;
	bh=FOqaCzgcbz/sLIKuHOqFeeIuW5AwVPk+V2fQYXDfwaQ=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=AK27IfVqs9W2gmnV7r/qv2+L9f6A/gRNGwvZ8WOhJJmYLRz9Xd7nahzJBTOWonPBw8iPqDXsgWYCr6r7stnFQR9nsftMCxXGjesUKobEU51mdQ4bCMOgbxQKCIvV8/wphKZ0baKc5BLQYFJCeOkU+dXCA7ZlMj4OOcUNiDdykyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PmwxtvjL; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764809428; x=1796345428;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=FOqaCzgcbz/sLIKuHOqFeeIuW5AwVPk+V2fQYXDfwaQ=;
  b=PmwxtvjL+/mzEn5J6cRPuoDEppmX0BE8z4si98DSMaCTxESjLcu9zp8H
   LT8vH72bDO7nzu/hKyfUXoky20gGzgGKDuP1tVEerLUVO6IdmJ+yFYeJM
   Cnon+OfXX/mQ3qWcWsW+LBiZVPGlRi/a2ESgaFfyOTVTl0zZDkHEFgaBB
   TMg4X7ylfcTD0bpsnIEcsyf89cGx63gXWEBFYtsC3SLdEUYxzqwrzKuJ1
   US7mJuv8JEtcpwPSzX+gFa2d8OcKBxjXVbgxD6rStexKVHyTONdmCdAK2
   Oxrcy35mfpdPyPjdWoL2orwj1eRX92Csw33EikBLy3QNVNn+yELnJQyDV
   w==;
X-CSE-ConnectionGUID: pgNc+vf7QISXTc7KFOeO1w==
X-CSE-MsgGUID: B8T8x1eiRGSx6gliF2HQJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="66545690"
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="scan'208";a="66545690"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 16:50:27 -0800
X-CSE-ConnectionGUID: Axe8fpXsToOgrL3BpDSllw==
X-CSE-MsgGUID: HfB//CpNQjGzmQVTEsnA6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="scan'208";a="195255306"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 16:50:26 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 3 Dec 2025 16:50:25 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 3 Dec 2025 16:50:25 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.24)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 3 Dec 2025 16:50:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d5fNAoV8qv1jkjmmd+soXLHSZhYzUBgM3TdgWgOuRKX1JY4Swk/wmhSJLSZIMhXLTH2cVr52PFNa3aiw+9utdUVTGBa0jkkEpv4mQomCbyAP9w8YThO/KpfkWvmQQzc4/UDBxgPOZmMDYDI1Jgsb65G5mcVyq0dRvpznE60nWb/6PBSP3MbquT0CmtLnB8zfvB/cp1XFyFI+rPOKicLssKZcZUQEKiaruwc9dFLYehqGCmodr5LhCvRK4TuOtDIh/gx1D/gYwt3PiY4ngg8ZcixHqB0kj9bY1kAZcUSdot2xAdaUH4MK1B6t9293oJudu3YwAwTzcI6mwO2OMZAiTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYEeWTCSqulBwJ0fEPzzQy2/VfVlV9Z6qPLb1FKefRo=;
 b=nA4j/0uiTM/PIIA9es36t5GX5D1CW/0OPsbXUFNyk0QFJgZ2Frq7Cim+fxCR4W571QM2xbS5iDJsLsbimQZFrL+Hx/8iVnJEGwxVTSmO/1Q2JFouMvreTfTP5RwiXkCj9QT1CMaf9Ocd1cQhfgb4fGNP3Pf8RVlqcSQXPo8EM8soDXoy7Own7AkUmFsL/FQxOq33Ps4JHOkMfwxBIHyR0vXUNXkO1o3m2JPTlpKPu3bxfSYR8rgtW7pjXFsdvZWA+D2SGhuWnYcHtTttvKiQW1H501kPrtjjrKb12U4RHHM2XmMRNKvKl9SmbNuuIWiHjOMCS8amdnFzghJSqqFywA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN2PR11MB4678.namprd11.prod.outlook.com (2603:10b6:208:264::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 00:50:23 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9366.012; Thu, 4 Dec 2025
 00:50:23 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 3 Dec 2025 16:50:21 -0800
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, "Ying
 Huang" <huang.ying.caritas@gmail.com>, Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>,
	Nathan Fontenot <nathan.fontenot@amd.com>, Terry Bowman
	<terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>, Benjamin Cheatham
	<benjamin.cheatham@amd.com>, Zhijian Li <lizhijian@fujitsu.com>, "Borislav
 Petkov" <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>
Message-ID: <6930dacd6510f_198110020@dwillia2-mobl4.notmuch>
In-Reply-To: <20251120031925.87762-9-Smita.KoralahalliChannabasappa@amd.com>
References: <20251120031925.87762-1-Smita.KoralahalliChannabasappa@amd.com>
 <20251120031925.87762-9-Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v4 8/9] cxl/region, dax/hmem: Tear down CXL regions when
 HMEM reclaims Soft Reserved
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN2PR11MB4678:EE_
X-MS-Office365-Filtering-Correlation-Id: 12e8738f-e918-44d1-4ab2-08de32cf1b16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RE00RWN5Yk1NNDRTU0dCN01xTlkvaTJSTlJYd3pyUlNSZlNtdzdaWHA0UFd6?=
 =?utf-8?B?OW4rSXQxNmJnZElsQ28yaGFjOVB6MkQ3TzJmZWg1aHZKVjhVUnJKajZTZjBD?=
 =?utf-8?B?ZEYzeFZmdUZINWlzT1NJWk9QMlByemxoa3F4bWNLbzVraE9QMW5tdHd3MHcr?=
 =?utf-8?B?dVhBM04yTUsweTJleFhtVCtvUEhRZUZKWGhNKzFWRjdka1JadkdOK0hZVkRB?=
 =?utf-8?B?QUcrZnppMHZ4ZVIrTnJLQm9yNzZpRHJuU3BmOVZLblRUUmxreEZzOGYxaEF1?=
 =?utf-8?B?TGR6ZzAyUlFINzgxbmpqc2dxdkhjYkhWNVh1bkp4R1d4akFSVk5HMmt1UXhj?=
 =?utf-8?B?aGxqdFp2TW00MDgzK0NLSFo1TmhqeUduSWdzeDNxOFdIK0VieGIvTFhYMXZF?=
 =?utf-8?B?ZWRaN2ZwcXdIZVQ3OE4rOVM2dGtZRDlUQ2k1WXJJazllbzJnOVM1Z1RsZWE3?=
 =?utf-8?B?WmFRNFRZRUw1RGpLOUFYMGZYcS9HcG1VRUxIU1Vac0VrN3dVUUR0dDNmbEJu?=
 =?utf-8?B?QmZwcEZrR094bVUvd1pkeEw4cmFIMklpTDVIcXdYT283UkdOcXR2MXRNNW5B?=
 =?utf-8?B?YmZkSWFnMTlOOGJmemljcnBHbEJxTXdnSzgxd0ZFZ3QxcUhHUG9oYy9ibzJu?=
 =?utf-8?B?UlBOMnAvMWxOT3BZT2c4T3JsSGxrajZSQTJQVS9yK3o5cDlxZkgvc0NOL1FM?=
 =?utf-8?B?bzhaM3pHL3JpSVRIWm9vd1lFaURHMGc4YmxHSDkzNmVUMm92VlM1SkF3SkFD?=
 =?utf-8?B?bFYwWHFHMm1oMkgyODBGcytqd3oxQzdHR1FDN05TRjducVlyUEoyUDUzb1ln?=
 =?utf-8?B?aUJmclUvd0ZIalVuOXQ5Sm43Q01PVmJBSEhVTnJteElRbVlveGhWZUZ5cjBi?=
 =?utf-8?B?Znp0UkltQ25RVHg5aGRwMmJSMFJVci9PbTRvNEdSTkVJL1puY2JuM09yUzZz?=
 =?utf-8?B?R3R3U082Y29PNEdOU2RpWldUdTYwdE43MWZ2TzkybXRaMlVSUDhyRGJhTVlI?=
 =?utf-8?B?bjVUUFIrOHpTMFN3NUFXVWdseEFJVjBac3pKTVpMQUhFcER1Nzl6Ym5tZVJR?=
 =?utf-8?B?aUgwQlBzT3hGaTFWZlNUZ2V2bEdoRW5VV3RFU0o2NHZYM2FVQUt6cG9lQzlj?=
 =?utf-8?B?R2N0cmRoblhkSFh5N2xyWlBkODJXLzh3Z1hzNlkzS1huU2dRbER5R1ZTSjdM?=
 =?utf-8?B?OHdXS3dEMG1CWmQ0QWh0MVAvZlNtUGJsVEhGNXI4VFcxRWIxUUlUQnZSYTRC?=
 =?utf-8?B?RmhVL0NCRXVkZWFTekRFdE8rTXpHb2NOQStpRUk1MkliZGhYNnNsQldpTElM?=
 =?utf-8?B?Vlh4KzE2dnJHb3Ywcy9ubWFGM3Q4OUNjMURnSnRoczdIS2V3REhYWmRhaHlQ?=
 =?utf-8?B?Q0ZkRWlBTDRGcnlWV3ZtWXVOaG9kNEcrWWMrTlY1bzhlZWlvK1IwOVI1bFZP?=
 =?utf-8?B?MHVpNi9ydy9SRTVGdmNxd1ZTZk9aalhkUWk0ZUU4ZVB4RkNkajYwdGxZY3VI?=
 =?utf-8?B?Q2ZyMVFXRGxCQWtpTk1tSncvS2IrZHhqdWxPSDdwWTNSZitTS08wYk5hQU5U?=
 =?utf-8?B?RFZqc1IyNzFldlNrUnBZNmNxd1RQaWM1S1lnSm1ZcXlNS1VuWFZVcHR2NkZQ?=
 =?utf-8?B?NFNadWZSOGFnYm9ZT2JnVHdoOFdtL0NjbXRPRnh2eGJlM2w1cDhmZ3dUOEhi?=
 =?utf-8?B?cUloZmV3VHJ2YlREak1QdVVPdkU1RzZwVWUwaHdON1Z4dVF4dkVwZzh5RXFQ?=
 =?utf-8?B?TE5XcFZnT1pUNmgxc0RDbnhid0xLMk1TVXFScmdjTXg1QlY5TUN2RTY1MnRo?=
 =?utf-8?B?OTVZTi83Tm8yY0E5anlkVFpJaG5hUFEvU1BETkVBTXlhRm1GZE9tUnFoYm1r?=
 =?utf-8?B?dWlZKzNvaGJRKzV4RXpsSEtRckw1OVY4eTlGaGlkR0szbFRuL0tEeVRNbUlO?=
 =?utf-8?Q?RGnXxo6VpMjsCvnAo0qsGDs8oESW4c0/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RG9Hek5OOExBR2M3WTdjRkE2aUs0STVReUIrcHM1YTZucWZnYWZaV1RQZXpz?=
 =?utf-8?B?VTJDV29LNGVoOVRzWGdKM2NxTHNPRC9Cd0pCKzN3eTRHSndNYU9RK1diK2dT?=
 =?utf-8?B?YjV6SnJxbnY5RFZPYjhSb0lpNGt4OWZCK0l1aktocGNXK0p1SkltclBFSGNn?=
 =?utf-8?B?V0RhS2ZWUjRiVFRsVklDVzM5QlpSMFRPcVpmaW5mZHg3SHFlZlNEQXFkdmQv?=
 =?utf-8?B?dGtJeVhCYldZQVV1ZnQreXE5eVRuZXNOY1FhZ2g3VWtLZE5Na0VEVmoxRWRM?=
 =?utf-8?B?djdPU0lyUUVxT01uTFVldTRxRHVZVExDeGwrMDkrY2x6Q00ramxGbmZQcThS?=
 =?utf-8?B?SmVMNDNPWVR0ZU1QaDJtR3RRY21nbHdETzUxSkVZUnZwamljSFUrbkhob1By?=
 =?utf-8?B?Z0lGa3RQZjJyTko5Z2ErdXIwOVVjYXF6cXRaN2tpdXFMcC8zN09lc2N5cGhC?=
 =?utf-8?B?K204RGVoQThMWW15OE42ckJ0Rkg2eUx1WmovY211RzNuTHlaeURxcXNNNFEx?=
 =?utf-8?B?RWtYdTlEQW1XWmgvNHI1ZTBjTTRrZ1ZrajZUYU5lVmFzZktUZ1BZRlcvT1V3?=
 =?utf-8?B?Ny83YzNxM20wbFlSU29OVE5WbzIwUXhVYU1XUW96NVgzR2NQU1VYcVJyaUpI?=
 =?utf-8?B?RXNISGsxU1VTMGFGOEhxam9VdUNQSVdOLzRFVjBsYTlQSk9tNmVtZXVnb1cv?=
 =?utf-8?B?WlFNeHVkdHprYll4Y1NMS2hrR3NPVFl4Y0N3WTRQd3J4R3lRZ0Jrc1g4QUZF?=
 =?utf-8?B?L0Jpay9CTEkyMFZmektEcU1ySGJFdDBYOXE0TndiNFpBbldyL0F4bWt4L0J5?=
 =?utf-8?B?L2NhRXEzZWI3ak5rNy9udzBLY1JqTndYOEpPWEJ3NmtOUnVST01RazJydkps?=
 =?utf-8?B?MHA5enJnQ0xaZ2ZURFM5VGVaOXdNQ3JyTGxHMDNiUW5JQTNnd0xKczhmSHRE?=
 =?utf-8?B?akJVQ3dDNHdMTXQ5anMrN3kyd2ljZDNxRnExS2w4VkJweEFUVmQ0VklUZjc3?=
 =?utf-8?B?YjBhZ21NaWVHRFA5QzJaRDdMZjhQY0Fhd04yVElHTnhQUXVoWFp4eEMzKzhl?=
 =?utf-8?B?WWtzeU9HODhISy8wRVZ3R3BDQ2MxSEQ4UDdkWEY2UjV5Rm90Rm51K2JjSTNr?=
 =?utf-8?B?UEtWSGEzUWE2VHU3R1gyd0JZUWJhZnNLN0JiUGVRdDRUYUJOd0ZsbldkUjd3?=
 =?utf-8?B?K0RVaURHTmw2ZUVHUlNrKzhPSDU3SFRvZERNT3l1ZnA3QWRSMm03MC9KcUJs?=
 =?utf-8?B?QWJhSmRHTi9rT1ZhNHRPcE9hdERWYzVPTXE4Y2xMR0U2OUliRjEvc1BuVERG?=
 =?utf-8?B?UXp0WU1yOE45T3p0SXZ3ckRUbDdGK2V5ME4yZFZnVDk4OWpqSHp3WFlUbzl0?=
 =?utf-8?B?K1ZlMTRQVGRwamdqOFJZOWJWLzNCeTZHcHlQZC9oOUlIdlJlMTlLS1h5b2tV?=
 =?utf-8?B?MlFaUWRreDU4S1NEL2JpbFk3YWRoaXVNaTBrMHpjKzZ1dnBYRTlpZFplcm5s?=
 =?utf-8?B?SG1QcjdRQU1BYXRMNkJQWDRMd1Z6NjRZeVBjVzFrZklCaU1rSzdJNDhybHJ5?=
 =?utf-8?B?MEFlMDgxM0dJTmUrTzFreVlETEJKU29SMUw0aTFta1hWSm5UWUh1UHdjZlBl?=
 =?utf-8?B?WXhQVXRVcjU5MW5PK1pvblduQVgwbjdUTE10SHhPcDNIY3R4UjlxOGYrMmtM?=
 =?utf-8?B?VzVnOW5VdlFXMGRGTlVSZDRIcFc3VTdwamNmU2FJTTVyVHJ6YkZ2QWIzdlBx?=
 =?utf-8?B?dDNGTGJ3eHJKamtFbVdPL29EWUtRMUtSWVBlbFJpU25Uc1RZT3ZLMTh3RE9Q?=
 =?utf-8?B?Z3lsLzFEK1FscUhmdEZWQWdwWXZtcjh2U0FpdGpMOWs5U3VyK3JNYzZrKytK?=
 =?utf-8?B?a2FvSXBuYWxvY3RNWVFsb245MkcrWXVvV3EyKzk4bXRTQURFWUhYY2RGWFJv?=
 =?utf-8?B?QlFRRGZNc3pid21XeGdjOGowUDRqTFdTUFN4TVVHc1V2OW9sVWdwaDYyMlNl?=
 =?utf-8?B?dHFPNkdIeW1abms0VDN5K0I4eFpvVzczOHluaUNjTUZVemdMQStURWtqSXlL?=
 =?utf-8?B?V21taUk2OGxRVFcvNXFObHZjcHl2a1R2b3huQy9tUmFzcWtkdFRjZXVsS2s2?=
 =?utf-8?B?VzREbjFqY0o1bitNM2lCbEUwbFVmTVA4QkxwaFMrNk0xZmh5cEd6c2gvNDZF?=
 =?utf-8?B?Z1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e8738f-e918-44d1-4ab2-08de32cf1b16
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 00:50:22.9164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vjr2zBDJJLmw4g4TPK5Lx12hu/b55Bk4WZ0/2oDENE0kkW84JphW5kKH81x8uY69nJbWAWlsXKiYOOp2aO3yZgFyVWo3hFZ3kYYWFJcyY80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4678
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:
> If CXL regions do not fully cover a Soft Reserved span, HMEM takes
> ownership. Tear down overlapping CXL regions before allowing HMEM to
> register and online the memory.
> 
> Add cxl_region_teardown() to walk CXL regions overlapping a span and
> unregister them via devm_release_action() and unregister_region().
> 
> Force the region state back to CXL_CONFIG_ACTIVE before unregistering to
> prevent the teardown path from resetting decoders HMEM still relies on
> to create its dax and online memory.
> 
> Co-developed-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
>  drivers/cxl/core/region.c | 38 ++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |  5 +++++
>  drivers/dax/hmem/hmem.c   |  4 +++-
>  3 files changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 38e7ec6a087b..266b24028df0 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3784,6 +3784,44 @@ struct cxl_range_ctx {
>  	bool found;
>  };
>  
> +static int cxl_region_teardown_cb(struct device *dev, void *data)
> +{
> +	struct cxl_range_ctx *ctx = data;
> +	struct cxl_root_decoder *cxlrd;
> +	struct cxl_region_params *p;
> +	struct cxl_region *cxlr;
> +	struct cxl_port *port;
> +
> +	cxlr = cxlr_overlapping_range(dev, ctx->start, ctx->end);
> +	if (!cxlr)
> +		return 0;
> +
> +	cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> +	port = cxlrd_to_port(cxlrd);
> +	p = &cxlr->params;
> +
> +	/* Force the region state back to CXL_CONFIG_ACTIVE so that

Minor, and moot given the follow on comments below, but please keep
consistent comment-style and lead with a /*, i.e.:

/*
 * Force the region...
 
> +	 * unregister_region() does not run the full decoder reset path
> +	 * which would invalidate the decoder programming that HMEM
> +	 * relies on to create its DAX device and online the underlying
> +	 * memory.
> +	 */
> +	scoped_guard(rwsem_write, &cxl_rwsem.region)
> +		p->state = min(p->state, CXL_CONFIG_ACTIVE);

I think the thickness of the above comment belies that this is too much
of a layering violation and likely to cause problems. For minimizing the
mental load of analyzing future bug reports, I want all regions gone
when any handshake with the platform firmware and dax-hmem occurs.  When
that happens it may mean destroying regions that were dynamically
created while waiting the wait_for_initial_probe() to timeout, who
knows. The simple policy is "CXL subsystem understands everything, or
touches nothing."

For this reset determination, what I think makes more sense, and is
generally useful for shutting down CXL even outside of the hmem deferral
trickery, is to always record whether decoders were idle or not at the
time of region creation. In fact we already have that flag, it is called
CXL_REGION_F_AUTO.

If CXL_REGION_F_AUTO is still set at detach_target() time, it means that
we are giving up on auto-assembly and leaving the decoders alone.

If the administrator actually wants to destroy and reclaim that
physical address space then they need to forcefully de-commit that
auto-assembled region via the @commit sysfs attribute. So that means
commit_store() needs to clear CXL_REGION_F_AUTO to get the decoder reset
to happen. 

[..]
>  void cxl_endpoint_parse_cdat(struct cxl_port *port);
> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
> index b9312e0f2e62..7d874ee169ac 100644
> --- a/drivers/dax/hmem/hmem.c
> +++ b/drivers/dax/hmem/hmem.c
> @@ -158,8 +158,10 @@ static int handle_deferred_cxl(struct device *host, int target_nid,
>  		if (cxl_regions_fully_map(res->start, res->end)) {
>  			dax_cxl_mode = DAX_CXL_MODE_DROP;
>  			cxl_register_dax(res->start, res->end);
> -		} else
> +		} else {
>  			dax_cxl_mode = DAX_CXL_MODE_REGISTER;
> +			cxl_region_teardown(res->start, res->end);
> +		}

Like I alluded to above, I am not on board with making a range-by range
decision on teardown. The check for "all clear" vs "abort" should be a
global event before proceeding with either allowing cxl_region instances
to attach or all of them get destroyed. Recall that if
cxl_dax_region_probe() is globally rejecting all cxl_dax_region devices
until dax_cxl_mode moves to DAX_CXL_MODE_DROP then it keeps a consistent
behavior of all regions attach or none attach.

