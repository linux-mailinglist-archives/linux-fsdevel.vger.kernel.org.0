Return-Path: <linux-fsdevel+bounces-75836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHJOAI7PemnU+gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 04:10:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3ABAB57D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 04:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26489300AC2A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 03:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F923357A20;
	Thu, 29 Jan 2026 03:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XiO7A/p5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4702976026;
	Thu, 29 Jan 2026 03:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769656193; cv=fail; b=L2CJ2p3xjo26mitaReonoM1J/8T/a3LxaDLAY7wpt5zwZgYwhTfSztot3ecxQxl3QUNtaHadql9RdfbyOR7VOT7f4Yf2hdsJzfnJKcxPMz31IMAYy08Z+c/SWdW/VKZoF2nIaDBUPY1i1jaOZ20poQprAPyfY1IwOqTHEHdzy+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769656193; c=relaxed/simple;
	bh=l11HeQs8kl39sgNN+uWpOvc08aA2u95Rv3Grw5XsvyM=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=gWoOPQG0jkrTGlVnNSKFushNagnB3tmVRvlSRtyVOgKLs8MgnOrcbkcHAn7ivIbU7nH50cYp4H5CP0zYAMuYJA8mGcoS2cO/JssmUt9wIy+HDnWGkjCMx9CMPxuyMWLiEOJuEaGNTDPypGXFTRVX6NBOpGCW2dyQBRwJ1d+DJbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XiO7A/p5; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769656191; x=1801192191;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=l11HeQs8kl39sgNN+uWpOvc08aA2u95Rv3Grw5XsvyM=;
  b=XiO7A/p5Wc8MmuuFA8fAqavjWLRSJXEeDiV6OSyzpnmKJzyrpWibalIV
   9avao9wHyOJVg5kEFEEO+MhhqRLXLjjCtpMbQSu8r1OjfgCMGK+e38Li1
   oLE1Td2C8j3Cfj8XiAmuubTMtmy5pr2I5pWe7G7n/OhAZaEs2pI+vMmXm
   Bokx61U5kTZvR/kpUAWfH4yiaQ0TDsTAeJvj6VUWP5fmX6KFy63QMdn0w
   yDVmLUKJBKGGgUFZLRbqqnabNRjFFz3EG55Z3pJmxHhGJLhje5JPwFsSv
   ZvwPWMYZF7XXw+/ZyArqycPDcMI3ef85/Rxwyc4I2opSWEvHrwRzWOz/o
   Q==;
X-CSE-ConnectionGUID: n86a5Fh2R/mk+4k1b8UYZw==
X-CSE-MsgGUID: eXFJ+VZ4R+G+z6kvKtG6fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="58463299"
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="58463299"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 19:09:50 -0800
X-CSE-ConnectionGUID: wBHXD/FaSOmRBCUE0R7Vfw==
X-CSE-MsgGUID: 8ahZJqjqTqSTXfBVhlhWIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="212950861"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 19:09:49 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 19:09:49 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 28 Jan 2026 19:09:49 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.10) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 19:09:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WzGfXKZ3XvTQhrf0cR+VxJx57X2qZnTNEOFKQb4iRlUeIPU1iaK+WbNe8ldezClHP0ipmS2m0B4zq8P4/m3cmhh0FkVJnVfrpCvj0OTCN8MipoTTNf125ecyfZfNTOEL4QGsdQfzWjjhPWsofHRK/eF1+XQ48kRIob3iLTZVH14Z4rpYCQk0ejiLWhzKE27Pami5T/kGt8VG+w4i+E83OluZcTmtxOwP28Rp+Wn7qHucNcy+CniZ038W4y399KSS2vvqtUoRU0f0B4s7UakqaM6VB2vINlf2JXvm1cAcjjasu/R6Kbjky/uERv62OIi2g/CZpe+rJBbxz3byloy3zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4n4rTtYxB88lbdL9lEdOx/LJDY1l4Exkaa0UfubmoSg=;
 b=h5Cvk4d9OsXJdzijSlydHcxoMySwrIPRWzFuVBvZ32trDmUivUpgPGu1PUv0jkpMs4C4Q0RUZ5tD8wXf6lXafDzn6dZBSNvoLN2UHNU9SrfxY6F/D/oTpJG0xYTIlrFJuSP/tAFlm9pmvm4pZNESQkJa0V1Vj/s+RwftZWownihP+o2l6kJuNfBfubNYnNOrhL6CBlo9vIormUWWJPqMOzto8Qck55+hcLRNkJbM9hap0WeKhTVy3+YAYffbFKirFg1EQ98oHKjc5RP2og1lv0SqCjs2fUNTG+/5KR3emL++zf6U9fvr/cNN0c6UupqCB322DqQA7TbDBEr+dP4+lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB7504.namprd11.prod.outlook.com (2603:10b6:a03:4c5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 29 Jan
 2026 03:09:46 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 03:09:46 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 28 Jan 2026 19:09:44 -0800
To: <dan.j.williams@intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-fsdevel@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Matthew Wilcox <willy@infradead.org>, Jan Kara
	<jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, "Ying
 Huang" <huang.ying.caritas@gmail.com>, Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Nathan Fontenot <nathan.fontenot@amd.com>,
	Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>, Zhijian Li
	<lizhijian@fujitsu.com>, Borislav Petkov <bp@alien8.de>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Tomasz Wolski
	<tomasz.wolski@fujitsu.com>
Message-ID: <697acf78acf70_3095100c@dwillia2-mobl4.notmuch>
In-Reply-To: <697a9d46b147e_309510027@dwillia2-mobl4.notmuch>
References: <20260122045543.218194-1-Smita.KoralahalliChannabasappa@amd.com>
 <20260122045543.218194-7-Smita.KoralahalliChannabasappa@amd.com>
 <697a9d46b147e_309510027@dwillia2-mobl4.notmuch>
Subject: Re: [PATCH v5 6/7] dax/hmem, cxl: Defer and resolve ownership of Soft
 Reserved memory ranges
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0063.namprd05.prod.outlook.com
 (2603:10b6:a03:74::40) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB7504:EE_
X-MS-Office365-Filtering-Correlation-Id: 0991a23e-95fb-44cc-5ba1-08de5ee3db3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ymg3YTdQVDVZSTcrTndxMW5KYzRCMGUxYWJaOGUweHA2OHNlYVlUZnRLL01U?=
 =?utf-8?B?WVVaRm1TZldvZ084dDFDdHZWOWZGblZaRFZiNmhKa0p1dDRvU1VnL3RBZmNk?=
 =?utf-8?B?UlI3MXVCZHJYd1VKYkFVQUF0aXBUM3dqSU5hQlQvakhNT1dlQ1RuN3RKb25N?=
 =?utf-8?B?a3F6ZUlvY0EvMW5KekI2T2FNc1JhcXN6TElaRktxWjBFVGlpV3dEWjBIc3hW?=
 =?utf-8?B?dTR4cW94SER5WXBLQy83YWlQK3VsRlFZU04wN1NURjQ2K0lKM0hNbEY2Z2Nz?=
 =?utf-8?B?WnNSRjQ4WVdBYnhsYXc4RkRUM29QRlZFOTB3amNFQ3ZYajd4SWgyVVhYYkFI?=
 =?utf-8?B?WWJFc3k5VVNxZ254Nlg4ZkIwYUJLenhlWUd5OU01YUZ2akNlSXNvSkVFSnlF?=
 =?utf-8?B?ZVNubUhFY3hZVkN4T3FWKysyN0pjdWp0K3ovY2ZJeHo5ODNyMmR1YTJQc3Rh?=
 =?utf-8?B?dkFNS0w0M2hYMktkNk1xVCtlRzlqNUdSMlE1clZPMnByMlpnYWdyTmpkMmdS?=
 =?utf-8?B?WGZaT0s0VlFWM0cxQW8rRmdEdWdLYXhPRUR6bWJZaXdGbmZTQ0ppcHc4b29h?=
 =?utf-8?B?ZEllV1FKWFlYTnkxZFdobHVHTjhUa1lkMFdTdEI3cjI4U2xGZUt4cHU2R0hC?=
 =?utf-8?B?VzhJWWw0dElpamo4RHVLUytIc0hJWndNK240UE40VGpwc0wzZG1Sc1NqaEND?=
 =?utf-8?B?Y1FFWUdHQnRTOVhkWUFlc0MyRGFjMnowWThyN2xKWHUyNXJ3SWRVRlJGUXpZ?=
 =?utf-8?B?VTJZTTdKcjV2bXVIZUdhT25paEJmdEwyRm14M1NCUklVd3pIS3RENVJzQ2pa?=
 =?utf-8?B?NjFXSUZKdUxoOTVpMkFXU25FNmVncHdoT0FWK1lqbExiM3RlcFA2UDl2THkw?=
 =?utf-8?B?amt0UUhwWHlLQUl0SzYxVUhtVDU2YTdYQXd4TWxWaXZtY3VURnd0VWNlRXZy?=
 =?utf-8?B?bW83dHhPUkRVZzV4QlVUSllnZXNpaG1vbFhxTFZ1R1Z4aHFyQlZNU3NYbjRQ?=
 =?utf-8?B?OUZERzFNTG14UGs0ZlJ3R3VxQjZuakViams2Z3lMaTdQUEgyWEV6azI4UTUx?=
 =?utf-8?B?dUdNWFBDWStJcWNMd0RINFQyMitacVRuMmRtOHVaQmVnbEdNaG0rdTQ2U1VK?=
 =?utf-8?B?SHI0VVVHbFFNa1JjekVTNklYa0pISmorc3R4WWFiYkRpeGJlQ1lZeS9zK3gy?=
 =?utf-8?B?RmgrSjViWXNOYXMwSFBpeXNYdVFhUVVXWUg3bnZhTmowRzZRbWtweWhBbXJB?=
 =?utf-8?B?SDJpVitaZG56enNmdmpkWXFoR0ZpdkU2V1JnYTlJbitpeHNGN2pnUkViSm9S?=
 =?utf-8?B?dGFpVGdkMEpibU1aSWN1bDFFVmc2YW90TzZLY2ZBUEdzdTFibXJOUzdrckkv?=
 =?utf-8?B?M0dNQVNiQW1EUjRxOUZyZExFOWhXZ3JiQ1ZnV1BpQWRMUG5tZ25rbFJEazlj?=
 =?utf-8?B?ODZFdlF5TUZyQ1d2elVScm1NMnZMTnhWQlZLQzd1bUdzaVZJOWJMTHEvcnNM?=
 =?utf-8?B?cjhJeDRrUWN0ald2c3BOR3BvOHI0UzVIY2o2QUIwcVlnWFU5S1lML2VLeEpM?=
 =?utf-8?B?eG8rcEttbXBXNzVsNHBsVS9NTUNvZDFyNTJMaEEwM3FGb1hLeVlja3N2Z1l1?=
 =?utf-8?B?R2lHZGxWZmdwRCs1L2tDSnVhOHBkaUtCdFZEaFBCRnkrTGpkcmZnMVM3UGhC?=
 =?utf-8?B?SkpsV2lqSDUvM1A0dmduWG5qenpPUzdRNmFkV3NPUitBK2l0UUlQSmlmcXFo?=
 =?utf-8?B?azVyU2FNb1FGTWh5MlBzS2pSMGcza0pJbjQxaU0vME9aT3ZSNEMxUnBtWE12?=
 =?utf-8?B?a2N5b2I5VTVISWRzVGpaZ1ZzTHk2NGxiMStzWEk3OUp6N1lXOXE0WUVrRlBm?=
 =?utf-8?B?TEtVcGtHWlR6dVJxSVZwRXU5VTRmL3dhTThnS3c0WTFGclRKTTg2blo5NW9i?=
 =?utf-8?B?ZzdRaHRRczRFeG9VR0tuYis4akkxNDE1clI0cG5iaGFiQzdKRTdCQWxiTGxN?=
 =?utf-8?B?emJ2dlJ2ODRrODUvdHRXMXNqNUR3ZlREQ1dnWVhHWDFBcU5jMllSZnlzcGVr?=
 =?utf-8?B?VENGeUtvTCtOTnRFbWttM09UVStpV29Fd2NTSUYxc1piekdOdUI4TThUVDlO?=
 =?utf-8?Q?F4ic=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0c3dWxoU3FwTFVWZ0hpZFJDMStkSWV4b0N4cWlQa1B0MWk1RE80dUFvWWJT?=
 =?utf-8?B?S2U0VEFiMWZKalBoZThUYm8yTXpnTDVCWFRxeVFRLzMvZkU5YytNZzdFUmJY?=
 =?utf-8?B?VExwcWwwSXRaayswSTduZFdkVGR3LzdjZURXN1UxOVdpcGtBY3FDSE44M3k2?=
 =?utf-8?B?eFFkclBXQmkrRmdGZXdReWdWWjdsWWdrWmFVS0Q4bHl6M0Y1Q1EybGQ3SGU1?=
 =?utf-8?B?RG4xTTFOOUg1MlhDcGxYS204bi9CdmlvazR0SkVmNUsrYzZVWVNyZTZFSkNL?=
 =?utf-8?B?dnFJWUNVdksyZVdnQnpQT01VSm5hbzNmdlZ1VCtCTjBNM0hheWJnNnFjZnkz?=
 =?utf-8?B?cEJSU0tCSUkrazEvUGphT1NnT1Y1MTkyTWZnbFd0aWtFL2tzbkllMFhFMGhY?=
 =?utf-8?B?dTh5Nm84b0NQQnZndDFwVXRwc3kxaUdIMTUwdGtmblZjbWNhbXV5S0pROEgy?=
 =?utf-8?B?RGNJaTdDTURkOHdMMUZXN2EvekhIS2VQeEp4YStONExvWE92dFhXUTZlYStn?=
 =?utf-8?B?UzVyUnQxcVZnTHpnbml4WXMxeFVQMm1vYzZKK3g5ZFZWak9OaWdXVXB0eWlJ?=
 =?utf-8?B?MUMxSVRKSnB5NkhGaUVxWjlCMDhOVVhHVkxTYVAzMUpVcXNjb3ZQbWI2eW51?=
 =?utf-8?B?K3VDU1EvdDdmTlJkRWw0K1RoNmVwSTREd3V0ajYzbU5sMTB0SGRleDNPWWg0?=
 =?utf-8?B?WktybDJwc3pROW03MFdGaUxXaEFEb056QkJpRVljRnpDdFlNWDBmS1BIVzEw?=
 =?utf-8?B?NVFtRGxuRzd1Y1lNd3lpeitrOHhGSXJlK05NT3RZVllFalB1OTQzZENuVkpa?=
 =?utf-8?B?ZmhMRHMrcStkSGdUcnhtbVBaU3pVdXRLM0ptVXJQMXdBU1A2ZDdrWjJoTkVK?=
 =?utf-8?B?Tk5PNjFaWnhqQW1Xb3BORDlrWnRkMkNRUGgwZ0QwS1dKdjFqQkhuRDBvTTVW?=
 =?utf-8?B?aEpPVUxxTWJsTGFZdVZtYmRlWVFLTEhaZUJybW5CMWNGTCtOeFlFV0dlZTY2?=
 =?utf-8?B?andvUVQwanoyN2g0UXFlTzFRME1xeGZRVXowT2RnZUR1OFliUHFnQ1I5SE9t?=
 =?utf-8?B?Smg1eVArZXJNamREVHJSRHFQWkEzUXV6cDFBbWdDd2tRclBkWFpNOUhlci8z?=
 =?utf-8?B?VGVidWFFN2RSc2I2OGxHWFF0c2xLc2w1S1BOOGhLWjlORkhKaTFJTllUSTdk?=
 =?utf-8?B?cURnUEI5aHJ0VnFSN2lYTkVZZjFMZDFuTkc3OGc0ZlFobUhKNGZIaVZ3cnd4?=
 =?utf-8?B?UEVmYlVkQWJyencvVklRT2x0LzFtejRlOEJwYzVUOHJrcWNIcTlBYTE5K0Zk?=
 =?utf-8?B?bzNPR25xdEhmekw1T2E3R3FMalZ3ZkpzTWxPZmZIMDNGN1hTdW1KOXZ0SW9u?=
 =?utf-8?B?b2hyVnhNSjliK0VkZ1BLb082TERyV1lLb25pMFFqZzNpSzBjcXlzdE1KWUQz?=
 =?utf-8?B?c3ROVGt5WERYZjg3WUI3MUcxMzN5bDkzSnlLZHdzYk9VYVNBcEVCWnQxK0Jt?=
 =?utf-8?B?dVlydlpidER1RllIaXhoZXhmbU5Qb0kxV3VYOURIMlgvN1E0amFBRHFhT09h?=
 =?utf-8?B?UXloMnBxYVFmaXZGUFBkYzdMWjlncE9TRHIrYU5POVVtcHRnb2p6dnZmT0dz?=
 =?utf-8?B?UVlGSUpQQVNMaG9Uai9XL3lGdzBJYTh2bFBSRjZ6TTBXc3ZQbmVZWXkzUmpK?=
 =?utf-8?B?ZzNITTdZMXpLZ3hHZzQyL2JReGJ2emtiMit3QkxvRjY0RzJLQzV2SHNTS3BW?=
 =?utf-8?B?TmFHV2hDSGovbS81ZXNBNXZwcENDSjFoeG5tNEpMTk5ER2svMWU4UUplK09R?=
 =?utf-8?B?Q2xMZjhJWWxIdDFwRVJBWW5WRU5nNzJLRTJrd3dmU0cwL1BjVWpYQTIwMUda?=
 =?utf-8?B?TFFwZnIveVhKeU4yRXJYcDdzSlNjbHFablh5OGdkbFJST3c4UnlMQjM4bmgv?=
 =?utf-8?B?Y2Y5S25ReHVmSU5rOVhENUVVeW1TN0taK20yVXZJY042am1zS1g5WkJaSkhm?=
 =?utf-8?B?T1AyQXJqMU5PTjRTdFN4VnJXQkhkTHh2OGE0eUoxaWI3TFlSVncya2tuN0JK?=
 =?utf-8?B?K0J6RGVDZ2lvdGNJeFBweVhxWmNEQVdKTXdCVHppRnhIcFptbGt1SHFNRThp?=
 =?utf-8?B?ZzUrdUNtMjQrSXNEaW4xS1ZiWTNIY09odXNTREpaWmx4ck95SkRHT1NrZUJ0?=
 =?utf-8?B?RmtGTkJSQ0owSFUxSkhjMGR2UWRNbXFKTlltZnNqOVZqUEpLaDZpYTY0aTEy?=
 =?utf-8?B?S04wMncvdlU4MUJpUVlSQlVPWlNvWmpOTFppMDEwWW5yTDJ4SHZ2SU92ajM2?=
 =?utf-8?B?SU9ZMiszNENSNitkN3FpSzVMV2lYdWM1NnplMmZYRjNwV0h5cXl1Y2lnSkha?=
 =?utf-8?Q?eBFPaSDrr00KYctM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0991a23e-95fb-44cc-5ba1-08de5ee3db3a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 03:09:46.3424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wsaO+gsFqb+S/jR2PANXz9gNLkffaSMVJ7IT6jYsg7Yd/uJawyc0I2BoxCBxhMImgr9ZHZyDrobwr7sMMv66OoGI1NZjFXLqV2GAuW4LQ28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7504
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[35];
	TAGGED_FROM(0.00)[bounces-75836-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dwillia2-mobl4.notmuch:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email,intel.com:email,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.j.williams@intel.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 6F3ABAB57D
X-Rspamd-Action: no action

dan.j.williams@ wrote:
> Smita Koralahalli wrote:
> > The current probe time ownership check for Soft Reserved memory based
> > solely on CXL window intersection is insufficient. dax_hmem probing is not
> > always guaranteed to run after CXL enumeration and region assembly, which
> > can lead to incorrect ownership decisions before the CXL stack has
> > finished publishing windows and assembling committed regions.
> > 
> > Introduce deferred ownership handling for Soft Reserved ranges that
> > intersect CXL windows at probe time by scheduling deferred work from
> > dax_hmem and waiting for the CXL stack to complete enumeration and region
> > assembly before deciding ownership.
> > 
> > Evaluate ownership of Soft Reserved ranges based on CXL region
> > containment.
> > 
> >    - If all Soft Reserved ranges are fully contained within committed CXL
> >      regions, DROP handling Soft Reserved ranges from dax_hmem and allow
> >      dax_cxl to bind.
> > 
> >    - If any Soft Reserved range is not fully claimed by committed CXL
> >      region, tear down all CXL regions and REGISTER the Soft Reserved
> >      ranges with dax_hmem instead.
> > 
> > While ownership resolution is pending, gate dax_cxl probing to avoid
> > binding prematurely.
> > 
> > This enforces a strict ownership. Either CXL fully claims the Soft
> > Reserved ranges or it relinquishes it entirely.
> > 
> > Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> > ---
> >  drivers/cxl/core/region.c | 25 ++++++++++++
> >  drivers/cxl/cxl.h         |  2 +
> >  drivers/dax/cxl.c         |  9 +++++
> >  drivers/dax/hmem/hmem.c   | 81 ++++++++++++++++++++++++++++++++++++++-
> >  4 files changed, 115 insertions(+), 2 deletions(-)
> > 
[..]
> > diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
> > index 13cd94d32ff7..b7e90d6dd888 100644
> > --- a/drivers/dax/cxl.c
> > +++ b/drivers/dax/cxl.c
> > @@ -14,6 +14,15 @@ static int cxl_dax_region_probe(struct device *dev)
> >  	struct dax_region *dax_region;
> >  	struct dev_dax_data data;
> >  
> > +	switch (dax_cxl_mode) {
> > +	case DAX_CXL_MODE_DEFER:
> > +		return -EPROBE_DEFER;
> 
> So, I think this causes a mess because now you have 2 workqueues (driver
> core defer-queue and hmem work) competing to disposition this device.
> What this seems to want is to only run in the post "soft reserve
> dispositioned" world. Something like (untested!)
> 
> diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
> index 13cd94d32ff7..1162495eb317 100644
> --- a/drivers/dax/cxl.c
> +++ b/drivers/dax/cxl.c
> @@ -14,6 +14,9 @@ static int cxl_dax_region_probe(struct device *dev)
>         struct dax_region *dax_region;
>         struct dev_dax_data data;
>  
> +       /* Make sure that dax_cxl_mode is stable, only runs once at boot */
> +       flush_hmem_work();
> +

It occurs to me that this likely insta-hangs because
wait_for_device_probe() waits forever for itself to flush. So it may
need to be a scheme where the cxl_dax_region_driver registration does
something like this (untested!):

diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
index 13cd94d32ff7..6a1a38b4f64b 100644
--- a/drivers/dax/cxl.c
+++ b/drivers/dax/cxl.c
@@ -41,7 +41,32 @@ static struct cxl_driver cxl_dax_region_driver = {
        },
 };
 
-module_cxl_driver(cxl_dax_region_driver);
+static void cxl_dax_region_driver_register(struct work_struct *work)
+{
+       flush_hmem_work();
+       cxl_driver_register(&cxl_dax_region_driver);
+}
+
+static DECLARE_WORK(cxl_dax_region_driver_work, cxl_dax_region_driver_register);
+
+static int __init cxl_dax_region_init(void)
+{
+       /*
+        * Need to resolve a race with dax_hmem wanting to drive regions 
+        * instead of CXL
+        */
+       queue_work(system_long_wq, &cxl_dax_region_driver_work);
+       return 0;
+}
+module_init(cxl_dax_region_init);
+
+static void __exit cxl_dax_region_exit(void)
+{
+       flush_work(&cxl_dax_region_driver_work);
+       cxl_driver_unregister(&cxl_dax_region_driver);
+}
+module_exit(cxl_dax_region_exit);
+
 MODULE_ALIAS_CXL(CXL_DEVICE_DAX_REGION);
 MODULE_DESCRIPTION("CXL DAX: direct access to CXL regions");
 MODULE_LICENSE("GPL");

