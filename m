Return-Path: <linux-fsdevel+bounces-75819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHA1BF+demlE8gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 00:35:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9440CA9FD4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 00:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 615B7301C595
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 23:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0173446B5;
	Wed, 28 Jan 2026 23:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zuuch/9A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8CC2D8799;
	Wed, 28 Jan 2026 23:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769643347; cv=fail; b=YYCVK4dijhoQKkYSpp6NOMeAtFUHsOo6E1cQe4gSCCVxqB/iiYydx4b2fFjxZUYfrCtk4zco0Epq+QrBqvalruh0UXeMtatzPeFP4ysHIWItKJ8g8RlYDCG6tCgOO77N58WlBdNbIocDDV0312qYXqRA8Vsx8NiUS5WvGTzwRuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769643347; c=relaxed/simple;
	bh=Www1AgCSr0gkqfqlVAvKYQbdIGWmGqXMRfQJX4KQmRc=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=usHcoVWWmHtpNW75JcW8zdIH66M5wOq8cVTg3aqaMUb5C0wd1THIvDyugIfEnm4mPx6UGbn2a4veXey7CUJOP/3hbtMBW9MJCctTPvextgtaDjExUd0OHdN1VuxdGYxcSSwjcVKTkVWV6KzvBHnNl0+UStQ4SikVfwRaLy469Ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zuuch/9A; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769643344; x=1801179344;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=Www1AgCSr0gkqfqlVAvKYQbdIGWmGqXMRfQJX4KQmRc=;
  b=Zuuch/9A60/sHAFBZJYvXUmcgjxrX9nR9uBGPCc7i0/NgUX3gBO5zgES
   AWbpP5ngl33mAXOdPBdpXyzIXlbm0qZo6UY2hFqhwM1QrS7PNed72PzaV
   mnqrEhxvCvAfpFTlvYze7fF3Y/GeHUqk/fzgIzuBwPKLncFTFLkvCfIqd
   oLsAAGLi6zgtSJ+js26A1sWaw7ICH7DarSpVPQbQbuRqL5c5tL7xjCG4B
   rcicgf9Cy/X8pGqkcVbCbRxT3Osb88EtmyV4eHoWjkYtEaTSMGrNRO5sg
   kLLxAqpx4zbcNiLE6fLrbbyxoQB2XJf7XwiSu49fsl6rWoh1DjVxfc42m
   g==;
X-CSE-ConnectionGUID: CtuP7lzeR8y64T62isHNUw==
X-CSE-MsgGUID: y4wctVbrRpqyEn6UueOPXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="71035398"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="71035398"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 15:35:43 -0800
X-CSE-ConnectionGUID: P/BPir+qRaCsTx0ta1f8ww==
X-CSE-MsgGUID: l3Pjy+fsTj+ZVYYuf92Ojw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="212491421"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 15:35:41 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 15:35:40 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 28 Jan 2026 15:35:40 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.59) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 15:35:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M4BoHppBrbncjejR5EFiGoMjsFxQvVDwZ7lJk+2o35a0J67PFb4S7REIwmkROzdX6dYudPEtf766+oYiGOSDygPz48RE7IJmqkgSCEWJV/WsVcOhNZ80/oFI65TaQTGjZKh4HX0EMoNTfZjLZ7UQnX2v5PPBwgMUx4jL6awZiwYY80x30h+0kWA3KfdKId53UL9N39gwIi0E6GWIyAc9wKOjfunSwhDiF4uWoNO7Nxq1VD6zi+SOzf0Tewln/eMUml7hKIefnXwCHv/uyUi9KVYLJKjska1ZEUDbZrjWA8a/47hdwvyp7xGEDNuNLwqKnNF0wkXRhBOASKBAPR4+4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MqcN4cvT5Au7nLJY7Cmaj7tPfx8AqjrtPCQZ/U6qNj8=;
 b=pLZWHQfwzDMaNJsqFkgtD/YQ5cSeQSNGEvVpCmp367dg1BIpKcoTWyyjzMtsO/68au7dKgJHcoByIOB0hPTrBzL/A3pLzcur3+J8dKfixuIrfFp60Rz4mf3LC+YO5JjMBm/i3asszJnBBYlpwuwJcTkB4D0g9bJG3o8DOw9xl512cPk9P8mqTAscWas4qx1h3Bzoem0k4zKtG1gA8nfPEYh1oEiJ2p74iQaQGXX3neYgZvEQy+KEOveM0M4O1vWU1p2QahiogRiIxi8IbXuflIpAOguhJ1gop+IFjPYbT9OsgB7rvO3brEwI1Hk3HD3oH9XNPcCiRZXLpVPMpqq0Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8752.namprd11.prod.outlook.com (2603:10b6:610:1c2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 23:35:36 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 23:35:36 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 28 Jan 2026 15:35:34 -0800
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
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
Message-ID: <697a9d46b147e_309510027@dwillia2-mobl4.notmuch>
In-Reply-To: <20260122045543.218194-7-Smita.KoralahalliChannabasappa@amd.com>
References: <20260122045543.218194-1-Smita.KoralahalliChannabasappa@amd.com>
 <20260122045543.218194-7-Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v5 6/7] dax/hmem, cxl: Defer and resolve ownership of Soft
 Reserved memory ranges
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0089.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8752:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d3adca7-1463-46fe-04ca-08de5ec5efe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MTdEYWJtb2cveDNzanhacVFtNUdLRWczSTQwK0JjZkpQR25KN3F1WTV1VFVD?=
 =?utf-8?B?dlVzMXNJN1I2TlZvMlVZSkR4citCRllBWVY1dU5KYTBFZW9lREs2M0h1cWZj?=
 =?utf-8?B?Mm1yOVBmQmJuclNBa3ZTVUZ0RkN2N1lrREpiOGtuNXZFeCtyUlVGbHE4bU1G?=
 =?utf-8?B?aWxjcC9wUzVqaTVOSFBESnRWaFpjTFd3WlZoUU5FakRVSkxPNC9nN25YajVy?=
 =?utf-8?B?cFg3RHdLZ0VLTnozakRBdVkvK0hRRWNrK3NiNlBEZ2NCSThWcHV1N01pMVdH?=
 =?utf-8?B?ZWJkR2FmKzFoVksxRURodUlzdTd2MmZvZ3B0WnY4UWZqbWtxWVFPblNXZTMy?=
 =?utf-8?B?Q1ZDL2JkTFZFSGptR3RtVmtnRmZNUDU1dmVHK2hwZDMwdjlzeVJBNFkxVCsv?=
 =?utf-8?B?UFFSblE3ZWtYSjBQMXM4QlRJelpWV01VdUZ3Z3ovRzhRbnJCQXdBR0N0Qy80?=
 =?utf-8?B?RTdVc3lKWGpPdE5wODdzZGdIdnNaMkFyMU1YSmgrQTJsbjlXNzRvTitZWUdz?=
 =?utf-8?B?M2RYcmpmVjVaQmExVGdEelkwQU8yL2ZFQXNCZ1dJcUsvK003L0FJVEo2L0tz?=
 =?utf-8?B?aVQyTWlnaHUrUUJSR0oyTm5uTHM5b2ZjYkt4NlFkbkdVaGgzSGk2Sm9lNW9x?=
 =?utf-8?B?VlRXdUZCTklzM05PTmRJUU5CQjRXY1hGWUtzYXFldFhlWTRrT3htRlpwWlg5?=
 =?utf-8?B?UHZLQkF6YStMbm40VGY3M3lxRVloQ3kyUnE3ckZoaGx0V2lhTDdqS3dRbmdV?=
 =?utf-8?B?b3Zsa3dQaDY2WVdDT0NiQU5aQ0JpcTNIbEwvbTRMV3ZsWGE1V1QwWG1WVDcr?=
 =?utf-8?B?cVR4THlWdjFyNzQwaXB2bDg4WHJianZEV3BENVYvL2Zlb1hQMWQ0MjZ0czF6?=
 =?utf-8?B?ME5lT0RZYXBiZlpuczY5T0ZWVWJwdjBhemlaN0VWc0gvNC9tVVkvWDZDRnpo?=
 =?utf-8?B?THFUNzB2N2FrSTVhMDU3VnBtVEtmTUFDTExrZytxNjEyMzY4Y0xNRkE5Q3BX?=
 =?utf-8?B?WWZra25lcndqSUVxWW5uMk1kbXAzRjE0Sld4dGx6c21WM3dIK0FzRVNNNzBm?=
 =?utf-8?B?bWxTRzVuV1lsdkh6ZTRyR0g4aE5VM0VBVERhU1FZSXpPQnlPSjBRa2ZXNlgx?=
 =?utf-8?B?N1ZNeE1WdXIwc29RZjY4bk9ieDZIa0lTbzNXcGkyelNtOXp5b0xqbENIMXpX?=
 =?utf-8?B?MTRTVzBiNHNDWjYxV1lrVERNU2duR0UwMzYrNGFTTSt5cGorNGNmZWNFc0lG?=
 =?utf-8?B?TzZBaTF1RDFKb3dEOXg0eHppaHEvK08rQjN4QnFiSHhjcWZBNkEyN082eVps?=
 =?utf-8?B?TjVnbjl0WENMaXh4UkZxRW5PanhteG9jRS9oRzl1K2VhV0txUHNkUmxXZWx5?=
 =?utf-8?B?WjNFdXJVMGhwMS8rcXZJcVgrbnB3NmdWZytWK0MwcjRvTEF1ckdRdVpYR21O?=
 =?utf-8?B?MEFNV2s1TDdRUEhjR01SaVVxcDVLKzhVUWtDM1hjTzRvaUJuWHd2NXBWSm1I?=
 =?utf-8?B?WndCVENBUENhRmFtYURNRUpiQXdudi9yS3p4bSs0RzlVZldaV2tLQkFVRkgw?=
 =?utf-8?B?Sm56RytmcEt3ZzBpZDlNWUFPMUZidUIveTVvaHBjQzYrUWl3NGJ0MEg0Wktt?=
 =?utf-8?B?Um16emRuTHh0ak04WFRWRW45ejlMUUZ0UXhHYjZMWHZCNi9RRmhSTWZ5VU94?=
 =?utf-8?B?UWE2M2ZvOTBMMmxjNkNrcGJzTVhmcllFdE1ITW9hcFF3M2NoWVJYQkJsUHc2?=
 =?utf-8?B?ZlIzWnBKY29rSXhZR2dZeUlJZk04THorcWVIME5jbnFIY2h3TzBiZWV1WkZQ?=
 =?utf-8?B?ZDg0bmRhQ2x6UHI2amVzOXFteFI0TGdFVFN2UHFURDltMElCSkFWaXpGbHVG?=
 =?utf-8?B?Rjk1SjlQMXBOR3NhNVJaY09weFd4bVcwQSt2VWZRN29oS1d1eDEvQ05yaVc1?=
 =?utf-8?B?SHZHRzhFZUpSMS92eGZyTHRramJaN2xMemphNDlMR3BuRnE5TVVxd1FNelJq?=
 =?utf-8?B?aDlTQ2hrd1NjRzlydzE2WnhrUmQ0SE15cURTRllud2lncklwZ3dLS2FHcHox?=
 =?utf-8?B?TnpYMG5JU2M0bVpPN3RUZXNuUXVrWlJGK0xscUVwZzNLRHpOd1U4RE84Vlc3?=
 =?utf-8?Q?AgvA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1F5OGJsZnluK1pPbGJIOC85V1NBV1Q1bkVWN0lBYWh5bXUwSmRtWnlnUFpF?=
 =?utf-8?B?TS9SVXlZcGU0TForc2R5cmxsOS9hT0l1bWZydnA4aUJBWmJKdkovOU5HZVFW?=
 =?utf-8?B?T3praU9tclI2TTVTTWxYZURuVzdUSkI5eWt3eUtsTTkwNXh5TW5nSVFqL0t6?=
 =?utf-8?B?bGdzUUJwdVNKZUxxblByREZsMklpczJnUVdlWFArV2JrRGNjbENncVIzYTZ4?=
 =?utf-8?B?Y2FLcFNaNmh3Ui9yakpOZ3JVSFFYcno0cXI5bkljaExYNElnWlczMWd2dCta?=
 =?utf-8?B?a2Y1R3dPU293Vkc1L0VSZGt4WGlVU2VDRG1OZXJGYzJCSFpvOGxqcXI4Ui9m?=
 =?utf-8?B?bUMwZEQ1UHZDaEtpQUJnZDg5dnBENFgvRmRyNHZrUDl0Z3dQSEVIRk1lamFs?=
 =?utf-8?B?YXFIdkdTaUVFNXRka3I4eENHclVyOWRqUytsNXJsOU9kdm5HS2I4aEpMbmlN?=
 =?utf-8?B?SldGejlFNHhVYjZuSndzaTlaQlpJZ0k1Q01WaXhkZjJsU1ZBOXZiWmcwVlp3?=
 =?utf-8?B?ZzZsbnlicHBSdUZ4b3o5QnpucWQ2NTAwN1lVcnoyc3E4QU5yNWtYSm1CZ1ZI?=
 =?utf-8?B?SktNUW4xc0tHMVJ5MThPY2sxbktEazdJbk05em13S25ra2dPMGFueDhyWlkv?=
 =?utf-8?B?QXlrbkRWTVk0ZFlLQkR2dTNCYjd1NjU0Y2FYaXkzditvbFk5cnA3MFRIa01H?=
 =?utf-8?B?OFBDWEdhelp6MGFwY3hJaHNEZUJLbk92dTBTdWhINnRnZUZtYWhqeTdsSTYz?=
 =?utf-8?B?aW01aVJkUExTVjhjVFY2NW1QRVlYaHd5WGFtM1ZlNmFHczR4eWsvQnBwcW5n?=
 =?utf-8?B?K0lBeThxOXNrWmJMYThNWXl0WVVZMmhPTk1UUlU1Uy9qeE9QVnAwZmdPOW1k?=
 =?utf-8?B?OGpzZ05oRjVvRHZIeitpajJ2bG1pc2IrV201dXVnYktna1pVYWxndC84UkM5?=
 =?utf-8?B?MEUvdlFKWVZLOElKRXVLV0JXeHR6MUViSTQvUmRGdDJNYWlpYkxVOEtaMzFv?=
 =?utf-8?B?QWFEQ2hqZHdLbllmRTFKaDl0VkM5NGhkN0RyVDlEN3ovN2tlY3JhK1dHbWVQ?=
 =?utf-8?B?ZFpJUVpsc1VDQW5IcHBXclBvQVp4QmVGZE1EZlNNNVZNVjQzWmdmbDVxZEky?=
 =?utf-8?B?OFdqSE1CMzNnQVRQZ0RpaktUUFJuc1JUcXBYTCtXUEMvMFh2VXN5MU1LZXFt?=
 =?utf-8?B?aEZMa0xzVVhpSEVuKzVITEhzYzlZMGJzemxicWVTL2J2aWxHM3U0Z1dwYkVG?=
 =?utf-8?B?UFdVYi9yeCtJYUtkUm1hV3d1OVBjMllWWkZkbDdDTWtOV0hGTVJpdGxWZ0Qy?=
 =?utf-8?B?VS82ZGVIb0hrQXphR1NOd2J1Z0poU0NPMDFWUVBwemdBQlR6QmlXUUx0aXBJ?=
 =?utf-8?B?MXJYcldzc0wzZWZmOUNEUG1nZGQ1bGljMXY1UDh6c0k3WEczcDMvV1NOclNT?=
 =?utf-8?B?R3R4SWZSN2p1dnVhTUFmeVRlZy9ydC9JNmw5ekRIaDIwTUhUQ2g3T09sVlV6?=
 =?utf-8?B?bG1ndDNxT3grS0pyL2JjNktHSlBiaU53M1ZhSmIvOWtyWnZ4eHBCWGpQUU5m?=
 =?utf-8?B?ZkI0MDJzSThYV3oxdERZQ0M5enpDOHhiQXlGejZGcTd1NThMdW1KYjR0YTEw?=
 =?utf-8?B?VmZ6K1A2VC9ma3pIRXZYMjlyZldaN2dKSFdMVkVnZkRaSWVNRWtOVVJnSlRU?=
 =?utf-8?B?VWxHS3hVaFRNek1MNUpZNDdaOXpwdkRXdkJBbHVzMnA5K1puVS9ZVHB4RTZt?=
 =?utf-8?B?NmNPdWRiYXltZ001cjJncStsRWo4dTV2bDRGbU8rbFh4cWRUWWRUTjZ4OWlx?=
 =?utf-8?B?OG9vWXd6bnp2Wjg4bkxZRWo2bTluaVN0Wk0yK1dEeTJOSGZCQUhGQUYwU0dn?=
 =?utf-8?B?d20xa3l1Z1ZuY1BheC9Fbll0WDNQUW1ua1A5T2pySTRiTFpsemcyNC96d29U?=
 =?utf-8?B?a2FRL0Ric25zZ3BrMDJmSCtNVTNuS1ZTbWNsZ3RFeHZZaEYzSjZRN0pMdzRk?=
 =?utf-8?B?L3p2TW4zdVNvSkpJdzlCbzVYQWFWOGJFWVFKVGZzYnlyaVNqYkFIZms3S3BL?=
 =?utf-8?B?SUkzdXkyVFhjcDNtdStTNnc0TUhndHVLRjFEdlRkMWtpRDI4Smt4cDZLNE1L?=
 =?utf-8?B?RUlKVkl1YnNIMXJ2a2hUZzNrQ1ZLNHdGOGphVjdVdktPOEFMeUpIL1pSeFA3?=
 =?utf-8?B?NkhzQXI1Njd5bWc5eWxlc2Y5M20vRmxGUUxxd2dRN2ErR0JTM3pOZmhSbWdi?=
 =?utf-8?B?SnFBN2E0NUJDVDR0SHZPS0VsZzkvWXpiM21TSGlvNU1DYmlHSDV1M3pIZzI4?=
 =?utf-8?B?WFVvYnJmZ2kzRnNTV0ZtSFFZSEplbUJKVzl5c0VNU09jdG5kSHMrdXFaOWxV?=
 =?utf-8?Q?xtBkzS3Nce65Xgd0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3adca7-1463-46fe-04ca-08de5ec5efe8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 23:35:36.1332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gzlZVsEUikmYyk0cWkMG98bZg20AZVwAO1mUJgEaI+SI9zH26TNU7ADNIur3yUUFYdaTXTCqgV56byTXBC2s5TcC7XgYQZ+dbuweIXP6GUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8752
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[34];
	TAGGED_FROM(0.00)[bounces-75819-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dwillia2-mobl4.notmuch:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.j.williams@intel.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 9440CA9FD4
X-Rspamd-Action: no action

Smita Koralahalli wrote:
> The current probe time ownership check for Soft Reserved memory based
> solely on CXL window intersection is insufficient. dax_hmem probing is not
> always guaranteed to run after CXL enumeration and region assembly, which
> can lead to incorrect ownership decisions before the CXL stack has
> finished publishing windows and assembling committed regions.
> 
> Introduce deferred ownership handling for Soft Reserved ranges that
> intersect CXL windows at probe time by scheduling deferred work from
> dax_hmem and waiting for the CXL stack to complete enumeration and region
> assembly before deciding ownership.
> 
> Evaluate ownership of Soft Reserved ranges based on CXL region
> containment.
> 
>    - If all Soft Reserved ranges are fully contained within committed CXL
>      regions, DROP handling Soft Reserved ranges from dax_hmem and allow
>      dax_cxl to bind.
> 
>    - If any Soft Reserved range is not fully claimed by committed CXL
>      region, tear down all CXL regions and REGISTER the Soft Reserved
>      ranges with dax_hmem instead.
> 
> While ownership resolution is pending, gate dax_cxl probing to avoid
> binding prematurely.
> 
> This enforces a strict ownership. Either CXL fully claims the Soft
> Reserved ranges or it relinquishes it entirely.
> 
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
>  drivers/cxl/core/region.c | 25 ++++++++++++
>  drivers/cxl/cxl.h         |  2 +
>  drivers/dax/cxl.c         |  9 +++++
>  drivers/dax/hmem/hmem.c   | 81 ++++++++++++++++++++++++++++++++++++++-
>  4 files changed, 115 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 9827a6dd3187..6c22a2d4abbb 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3875,6 +3875,31 @@ static int cxl_region_debugfs_poison_clear(void *data, u64 offset)
>  DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
>  			 cxl_region_debugfs_poison_clear, "%llx\n");
>  
> +static int cxl_region_teardown_cb(struct device *dev, void *data)
> +{
> +	struct cxl_root_decoder *cxlrd;
> +	struct cxl_region *cxlr;
> +	struct cxl_port *port;
> +
> +	if (!is_cxl_region(dev))
> +		return 0;
> +
> +	cxlr = to_cxl_region(dev);
> +
> +	cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> +	port = cxlrd_to_port(cxlrd);
> +
> +	devm_release_action(port->uport_dev, unregister_region, cxlr);
> +
> +	return 0;
> +}
> +
> +void cxl_region_teardown_all(void)
> +{
> +	bus_for_each_dev(&cxl_bus_type, NULL, NULL, cxl_region_teardown_cb);
> +}
> +EXPORT_SYMBOL_GPL(cxl_region_teardown_all);
> +
>  static int cxl_region_contains_sr_cb(struct device *dev, void *data)
>  {
>  	struct resource *res = data;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index b0ff6b65ea0b..1864d35d5f69 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -907,6 +907,7 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled);
>  struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
>  u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa);
>  bool cxl_region_contains_soft_reserve(const struct resource *res);
> +void cxl_region_teardown_all(void);
>  #else
>  static inline bool is_cxl_pmem_region(struct device *dev)
>  {
> @@ -933,6 +934,7 @@ static inline bool cxl_region_contains_soft_reserve(const struct resource *res)
>  {
>  	return false;
>  }
> +static inline void cxl_region_teardown_all(void) { }
>  #endif
>  
>  void cxl_endpoint_parse_cdat(struct cxl_port *port);
> diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
> index 13cd94d32ff7..b7e90d6dd888 100644
> --- a/drivers/dax/cxl.c
> +++ b/drivers/dax/cxl.c
> @@ -14,6 +14,15 @@ static int cxl_dax_region_probe(struct device *dev)
>  	struct dax_region *dax_region;
>  	struct dev_dax_data data;
>  
> +	switch (dax_cxl_mode) {
> +	case DAX_CXL_MODE_DEFER:
> +		return -EPROBE_DEFER;

So, I think this causes a mess because now you have 2 workqueues (driver
core defer-queue and hmem work) competing to disposition this device.
What this seems to want is to only run in the post "soft reserve
dispositioned" world. Something like (untested!)

diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
index 13cd94d32ff7..1162495eb317 100644
--- a/drivers/dax/cxl.c
+++ b/drivers/dax/cxl.c
@@ -14,6 +14,9 @@ static int cxl_dax_region_probe(struct device *dev)
        struct dax_region *dax_region;
        struct dev_dax_data data;
 
+       /* Make sure that dax_cxl_mode is stable, only runs once at boot */
+       flush_hmem_work();
+
        if (nid == NUMA_NO_NODE)
                nid = memory_add_physaddr_to_nid(cxlr_dax->hpa_range.start);
 
@@ -38,6 +41,7 @@ static struct cxl_driver cxl_dax_region_driver = {
        .id = CXL_DEVICE_DAX_REGION,
        .drv = {
                .suppress_bind_attrs = true,
+               .probe_type = PROBE_PREFER_ASYNCHRONOUS,
        },
 };
 
...where that flush_hmem_work() is something provided by
drivers/dax/bus.c. The asynchronous probe is to make sure that the wait
is always out-of-line of any other synchronous probing.

You could probably drop the work item from being a per hmem_platform
drvdata and just make it a singleton work item in bus.c that hmem.c
queues and cxl.c flushes.

Probably also need to make sure that hmem_init() always runs before
dax_cxl module init with something like this for the built-in case:

diff --git a/drivers/dax/Makefile b/drivers/dax/Makefile
index 5ed5c39857c8..70e996bf1526 100644
--- a/drivers/dax/Makefile
+++ b/drivers/dax/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-y += hmem/
 obj-$(CONFIG_DAX) += dax.o
 obj-$(CONFIG_DEV_DAX) += device_dax.o
 obj-$(CONFIG_DEV_DAX_KMEM) += kmem.o
@@ -10,5 +11,3 @@ dax-y += bus.o
 device_dax-y := device.o
 dax_pmem-y := pmem.o
 dax_cxl-y := cxl.o
-
-obj-y += hmem/

[..]
> +static void process_defer_work(struct work_struct *_work)
> +{
> +	struct dax_defer_work *work = container_of(_work, typeof(*work), work);
> +	struct platform_device *pdev = work->pdev;
> +	int rc;
> +
> +	/* relies on cxl_acpi and cxl_pci having had a chance to load */
> +	wait_for_device_probe();
> +
> +	rc = walk_hmem_resources(&pdev->dev, cxl_contains_soft_reserve);

Like I said before this probably wants to be named something like
soft_reserve_has_cxl_match() to make it clear what is happening.

> +
> +	if (!rc) {
> +		dax_cxl_mode = DAX_CXL_MODE_DROP;
> +		rc = bus_rescan_devices(&cxl_bus_type);
> +		if (rc)
> +			dev_warn(&pdev->dev, "CXL bus rescan failed: %d\n", rc);
> +	} else {
> +		dax_cxl_mode = DAX_CXL_MODE_REGISTER;
> +		cxl_region_teardown_all();

I was thinking through what Alison asked about what to do later in boot
when other regions are being dynamically created. It made me wonder if
this safety can be achieved more easily by just making sure that the
alloc_dax_region() call fails.

Something like (untested / incomplete, needs cleanup handling!)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index fde29e0ad68b..fd18343e0538 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -10,6 +10,7 @@
 #include "dax-private.h"
 #include "bus.h"
 
+static struct resource dax_regions = DEFINE_RES_MEM_NAMED(0, -1, "DAX Regions");
 static DEFINE_MUTEX(dax_bus_lock);
 
 /*
@@ -661,11 +662,7 @@ struct dax_region *alloc_dax_region(struct device *parent, int region_id,
        dax_region->dev = parent;
        dax_region->target_node = target_node;
        ida_init(&dax_region->ida);
-       dax_region->res = (struct resource) {
-               .start = range->start,
-               .end = range->end,
-               .flags = IORESOURCE_MEM | flags,
-       };
+       dax_region->res = __request_region(&dax_regions, range->start, range->end, flags);
 
        if (sysfs_create_groups(&parent->kobj, dax_region_attribute_groups)) {
                kfree(dax_region);

...which will result in enforcing only one of dax_hmem or dax_cxl being
able to register a dax_region.

Yes, this would leave a mess of disabled cxl_dax_region devices lying
around, but it would leave more breadcrumbs for debug, and reduce the
number of races you need to worry about.

In other words, I thought total teardown would be simpler, but as the
feedback keeps coming in, I think that brings a different set of
complexity. So just inject failures for dax_cxl to trip over and then we
can go further later to effect total teardown if that proves to not be
enough.

