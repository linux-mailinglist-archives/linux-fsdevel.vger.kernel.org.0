Return-Path: <linux-fsdevel+bounces-75552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FbXFeb+d2lqnAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 00:55:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C40568E5A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 00:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B58030484EC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 23:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83073311C1D;
	Mon, 26 Jan 2026 23:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W9G3qB3O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E19309EF5;
	Mon, 26 Jan 2026 23:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769471645; cv=fail; b=Qo7f/qkieLWuzBggC6c2jWdwZ/aJYIFoZbjm4K2Vef4U4Hr666rUCi2I6I1rpElX5tKH7oNCHc0PyWSrTcDdRO4pYIuKfKmYuF9dehraDMk3VXz3rD3ZJb5/PVHIvkuBIwzE+pfQuP0dmcCWwDRB8EaRkQfdlrcy9TcnnEV4BC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769471645; c=relaxed/simple;
	bh=UT+ID87fa06cyOoSvFzdyNyHCYim9AMBRxcveDfsKvs=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=WnMb0je848/pBw3X1YTCzGuKd0sbz/87xeZS/DwD1GF5Vp42RrOhbrhIENp6pLPwiraF2YFkEziDkNv/c7rVFumPIYMvLnliJCTgTVdAHXXpFBMU96f9RQHB9enUwS3qc6cynjmJ1PX8vpNn67LVqZQV4vh/VEl1WZzOwDJyxA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W9G3qB3O; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769471642; x=1801007642;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=UT+ID87fa06cyOoSvFzdyNyHCYim9AMBRxcveDfsKvs=;
  b=W9G3qB3Orze5ZqPS09xU6zGu53DHrPX6g/ne3aIJkcBCYv1bfV+rxPSJ
   6JC7iaiAXgUps6+JLeNMWfJJ0boTtO1wldADVEh5p0/N4SqPeXszKmX4P
   AFHQm30RCYF24Eqe81SP48YxS1f42hbWvOb1qt+YAcU5JIoCMfYpOn+1I
   JgWcSXQu0RpHQxOPB93RKm3JuUKWqoIxN7xUpxFXHGMEtpPkDyHUdDMi+
   +oREaHc4xPeaJPB8Rd34YUChfKYDxGw0wk+92F8YRRAF4Gqze5+YM2EfM
   rQJctLhy/XZNRNoOEUwEu6ERZzRtp/jOjRy3/AKUdP0UktItpXBnxRSvy
   A==;
X-CSE-ConnectionGUID: J5UbyY7qRoSfyX40IAxQdA==
X-CSE-MsgGUID: YfrmF+77T3eR/JNKnU7PIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="81376285"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="81376285"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 15:54:01 -0800
X-CSE-ConnectionGUID: jrK8Osx1RH6BYNDagm94+w==
X-CSE-MsgGUID: 2/fa+ZYBRbm1N73kAVLQyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="230771042"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 15:54:01 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 15:54:00 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 26 Jan 2026 15:54:00 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.16) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 15:54:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wYeGFrSZxQZ0zpetwZElLooyDkoJF9Z0cCHgz739jtx/bQKQz7RQJ9RS3p9cLOdftcHj0avIZcFegit01eS1BlVidvLw8Ub8bNcndom17elodnTlLr2wDhwUxAp8qOBp8e+2QhzCEHvYeBvXdjOrN5kCgR/eN8evdqmNoECrpZITtu0/C2dGi+rK2JOCnxmixAOD6xGiAepf8Re9IWwqTNzCWWYkazvo/OymmljzdpuSgg9if1GlaYCePYDIL4coC0p766/16mBalBZXusc/VipkH1VZf6KNvAf8mDZ024rRdegrLa9G6Bu41SX1DBuWtPob13vo9KXWLKavHBsVzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UT+ID87fa06cyOoSvFzdyNyHCYim9AMBRxcveDfsKvs=;
 b=hmC/8GdE8DqvyIWqnAg1UgMUaSmQnPkgokDoMxx6LmG59f7MKHf4zkQGsK/RgJkjD+wZD4ijuNUdjKE4ZLTzHigdIma8sIXrHa4zjjhvWrhucMynrd4lQBVxBXrTiRLNzjO1AiPYpKRj2lTfsqbb7lx6Vx0p4jTN6wlyxdLYcYZhAteG3zcS+Q5ooiXVeouW2TBLLh02Qab6kJUeh6BmF8nT1exTerPn3y4u/xyp9dELLghkJ27fA6EPnrUWB29Z4MaX7aKx/RJ/f8iIb7MXqkhQcsgotf++lMqqVQ963MsE/H7fjjaUB0ECpFszpK8wSwgK9pMS0ioj9N1vQ3T3Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB7701.namprd11.prod.outlook.com (2603:10b6:a03:4e4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Mon, 26 Jan
 2026 23:53:57 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 23:53:57 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 26 Jan 2026 15:53:56 -0800
To: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>, "Alejandro Lucero
 Palau" <alucerop@amd.com>, Smita Koralahalli
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
	<lizhijian@fujitsu.com>, Borislav Petkov <bp@alien8.de>, Tomasz Wolski
	<tomasz.wolski@fujitsu.com>
Message-ID: <6977fe94d8ee_309510033@dwillia2-mobl4.notmuch>
In-Reply-To: <84d0ede7-b39d-4a41-b2b6-8183d9ccbb9e@amd.com>
References: <20260122045543.218194-1-Smita.KoralahalliChannabasappa@amd.com>
 <20260122045543.218194-7-Smita.KoralahalliChannabasappa@amd.com>
 <e38625c5-16fd-4fa2-bec0-6773d91fd2b4@amd.com>
 <84d0ede7-b39d-4a41-b2b6-8183d9ccbb9e@amd.com>
Subject: Re: [PATCH v5 6/7] dax/hmem, cxl: Defer and resolve ownership of Soft
 Reserved memory ranges
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR03CA0143.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB7701:EE_
X-MS-Office365-Filtering-Correlation-Id: c3fa6f21-133a-474c-6db1-08de5d362b48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cU1pdzd1MDViV0JsS2JPUDdOLzBEVEVJTHg5WkRCRDNyN2pBWTlwdDY5aUt1?=
 =?utf-8?B?QU9GeEFXRGJzMjh4T1BqeGdYcVErc3c4YnJyM1N5aDFzYkhRek1nQkVDZ292?=
 =?utf-8?B?a1NicVdQTWhvWGpBWHh5Q1pBemJES0gyUVU1cG4rUGZ0SXQ2amFiSXlTTyth?=
 =?utf-8?B?Z215VUx3V0tvblBSNEx2UFpLSnYvMDh5RnUyTVBTdWwweWhLZjhYZzdIUk5B?=
 =?utf-8?B?YjN1cnFhMzJ1U2RNNzNGS3VBS1MyUWFoOTdNb3RyOCticGcrVUc4Z2ZiQlJv?=
 =?utf-8?B?NWdOZ1lvcndhM1BITG03T3dwRm5yMDFVUUhjaTFBa08wR3RrUTd2Q0ZlQ2Vu?=
 =?utf-8?B?dCtqcitpd3FkR0hWNG9ZcUVGemhRMVZQVjRJekhKM0M5YURlU2ZRUmRmZUdM?=
 =?utf-8?B?bndrbWsyVnY1RC9ad0daaFFLd200Q3lFbnR2YU1oY0h3aS9UcU9nRUJod21v?=
 =?utf-8?B?d3RVclVwd3dFYTEzWGxuam9HR044c1JsNDJpa0FmMkF3cllSQVZ1Q2h0NlVR?=
 =?utf-8?B?ZGw0QjZIaEZ3b2ViZzdMYytFakNLWkpwVE9tQnpZRkRxRUFCQWlOWWlxMk1P?=
 =?utf-8?B?Y3BpaXZENVF6aXRtblNXelVCWlFDZkl5QzRHSlJXTDRkVWdMTjlUd3V4bTVt?=
 =?utf-8?B?WWxQd05aeWYzQllLVm5MWEUyWHVNOUZTNWJqRkJuZzBSS1FyWFMxNEFvSkZV?=
 =?utf-8?B?OEhiN0pQa3pVM1Mva29LRFBYckU3QW5VVUx0enk1Ny9GaUE2NmRzdmxhdkdk?=
 =?utf-8?B?VWN3UWc1TG8yM0JnSmJUbnJLeVllUFhYYnZINHpMWkhEUUkrVmF3MGNsOE5B?=
 =?utf-8?B?Y1dDSjV1aDcrdm9qTFZWdlJxVUpVVGM2emM4Zjg0czNlazMwZzFPem1rMmpE?=
 =?utf-8?B?bE5vQk9udy9uenhxUTY1TTZ0QStJQVZrWUV3TW5lNWpsdUlIblVkT3MxdjVG?=
 =?utf-8?B?ZkUzc21GY3lBSlVZYmdHM3FoMWFZKzI3YnM4SDdBN1gzNlJrMVFTNWppS1p1?=
 =?utf-8?B?ajFocmpDamJNKy85K2RCNG4xcDcyU201aFErNG9aMFRuMm94WFlTUnVOM0Rj?=
 =?utf-8?B?ME5ObzJ2RWRUS0NITk1zSTFybWw0ZndCdjJuaXJUbVhmcnBYWVVZckMzdkE2?=
 =?utf-8?B?ZDlRUEZVdUYxcmlaMHpWais5WkhtNVNrbzhYWTlaby93SklYazlDdXdpZG5W?=
 =?utf-8?B?Y1hMcEtUdS9jVkJFR21ieW5rNWtUUVI1QVBiekR6dHNmYmtzY2NZTzlLaEZr?=
 =?utf-8?B?T2svSlBMMFhGQ2xNN21MYm9Eb1ZOU3lkMWhxSW1aNWZ1UXIzRTlrem5mYzFi?=
 =?utf-8?B?N0hSTWRuNm52U25TbWcwNXVRdng0M09qemlDdHFIelpnb3ZVdXdOSFZNWkdv?=
 =?utf-8?B?UEFwV1JSUUI5czY5eEI1MW8yZGdINE9TajJiTDFSZEl3NFRYR0VuTHpScS8r?=
 =?utf-8?B?cG12R0VNeC9qTDFiUXBuc2YyNDVDVU1WV1lKVFdnaVlYWnZNOFJhUG5zeVF3?=
 =?utf-8?B?TnlWekc0YzQ5ZUR3ZDk4emVoSWt4WTdjVGhYRExJa1lDWHVJU2ZUWkdtemUv?=
 =?utf-8?B?c0xTN2N4QlBVNU1jdkxtZjB4Yk9NL1kyc0R2Wjc3Z3gyNXVNeTJ3TjFvcEQ0?=
 =?utf-8?B?MTZmQjBkcDV5NFRsYThrdm9RUkY5RlN2MFVOcFVYMnR4V3FwV1hJL25wbXpG?=
 =?utf-8?B?dWF2SytNeS9FSVJucG5TdzdYaXJVMk1DOFNQQTdXdlQvNEhhUlB2SXoyQU5X?=
 =?utf-8?B?MnBTTkxlbFJzNjArUU5KWjBmbkdnRzJ6ek54RTMxcG01bXZQV0g2OUtkWHJr?=
 =?utf-8?B?V0JXdlkvU1FnYmhJajhUS2dUQzJWYjl6bS9qQldlMHo0V0RzUmVxRmEyNi9Q?=
 =?utf-8?B?elBXWXEycXl2QTVpV1pRaTIvMTZKTytQa3VZRVRaSVJOdGZnSnlhNHlFRG9K?=
 =?utf-8?B?Nng5QkU0Rk5GaDQ4ak5WKzNVaVRDa0RyTkNpL3NYb0NRMEIzY1ozMGlaOFhH?=
 =?utf-8?B?UndHNXdHdURzbGN1YXRnWWRjamErUkxDRmdld3lRZklMeWlUS2kwTmRDdjNI?=
 =?utf-8?Q?BAnPLc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnpWdnp0czJYVXFpMmxIcEdIdDYrV0UvUm1ucS9FQkpnTHd5eVlob0tjMzhj?=
 =?utf-8?B?VjNWeVpqSWRuWlJqR1VkWGFib1YrSEZteFlVUUxSa011RVBUZ3puQzNlVkph?=
 =?utf-8?B?WE5zYnVWc291TkliQnJVOUp0U3k2TXRYc21wdG9qVWZoalJTckpoN0pRUndr?=
 =?utf-8?B?V0t4Q2FIaVU0c29yUFR6eVpMaTNEU2FPNXBjR3FPdWcrY01NaUUvSXZUUTk5?=
 =?utf-8?B?bkZ1N1g0dFRUUUZPd2dJQ2NRWkh0OVVBTnh1MHcrcVpzZnJpUE9xZDR1dWZH?=
 =?utf-8?B?bTFic3RSajh4b3pXUldtVmFQZVRTaEFKbjhiZ1h1WEVlR08vQkVZbmlvaEU3?=
 =?utf-8?B?cS9WYTZvUEpFaHRoOEw3bnRxMG5oYWFJRXB6aDg2Y1Y3WktHUEhCL240alZo?=
 =?utf-8?B?dFM0UGpmUTZBdmRrSTg0SkptdjJDbURJY1VsazNLS1RmdmlwZWtDMGNXNkdX?=
 =?utf-8?B?NTdoZ0d4d0xuK0o1bGpLbGluQ0NOTTA3Yk5PZzkzZWpobHhPRUoydk92eUtt?=
 =?utf-8?B?aWMrQWRDRHhUL3YvRDFCUUQ1TzlkdHVXSDlpSlRQSVFXUmg2TllObTgrVitk?=
 =?utf-8?B?TEtCR01vNmpldjFIcmNZdG1vSFI2MWFYaXp3NFVnVEczS0d2c21NZDFOa1kr?=
 =?utf-8?B?VjU0akY2ZzJ2R1FJOUdUOTBhY1FGMUVONE1LeDc0RzJ6NnJJUHNIUTIwZ2pS?=
 =?utf-8?B?THcwRXhGTmxQK09IelpWbUgzVGVwbkdkcDFsKzdXWFhVRlRXTmYxRUNFMlJa?=
 =?utf-8?B?VVo4dW1ZN1g3RFdqT1NkOHhsVEJTWS9wVVRDMCtNNkxQTVBxUDdtVU9TOHZK?=
 =?utf-8?B?enE5UGxmcDRsSDNXdktFcU1abmwvbm9XcmxtT0U3Zi9GNzVnc2FFMUl6cnFC?=
 =?utf-8?B?RThBRE1iU0UydDR6V2t0MCtOYTErakNoaC90OHRQaHhKbWhTSTFMYVlWWlhG?=
 =?utf-8?B?Rkd3Mm5kRGhXcHFnNW4vMEhINnpTRWI5UUxqNlVjNk5UZ04wSGM3WFJvNHNO?=
 =?utf-8?B?K2w0MndrTXB4M1k0d0xMOWY2cldFNE5xclE2NVJyajJnQjZiMmNzOGQvTmxB?=
 =?utf-8?B?cU8yWnFCRFFaYkVFZ2NTUEpvdWRZMTdnNnE1Q24wVGtLdVpOL3FndlloSC9r?=
 =?utf-8?B?NVF3eldOZVVrdWM2YVRqUW9lK00yQ0F6QkhDYUVBc2FUTG5odk1OVXQvY21u?=
 =?utf-8?B?Z1FuSEVuUWNya0tYSE53bjAzVTdDUXFiWU5VSGtUM2hGLzNRNGNWR1lSOURh?=
 =?utf-8?B?OE9pMjQxeXpZdzQ5UWFwVE5kK1BTV1FIdVIwM3NmeXVtVVljVklia1RvM3NM?=
 =?utf-8?B?N3pXWkRnZjRBUk54bkxVS1JoNDUyU0NKTWFEekNyTmMzM2paU01nR29hdEg2?=
 =?utf-8?B?ejZjRW04RHVPbWtHa005NUQwR2tFd0hCVTY1ZVYxTjNNN05sWFI5Q0syRXU2?=
 =?utf-8?B?aUpRVDMyazU0OXJzSGJlcFVqRDhPWUZWRnBHTUttOVFRcFFqKzlzY2VMY3dj?=
 =?utf-8?B?bjNocTJxV1VtVEVVR3lpM0JCTTRDWlVocjhXQ3JkbTBiUXZpOEJrczduSnRV?=
 =?utf-8?B?azVVd09aRkY1MGl1Qjd2NW4zVUpaRnFDT1pxaGlpRXJvam13bXlTajE0YmZk?=
 =?utf-8?B?OG9VWmtZTDVTMzgwVEhXYnhXYlFCQlZXUEhzWWRPWTJLRDFwbG1QQ0Ewakg5?=
 =?utf-8?B?R0UyR1dDMkoyc05SbGZGZUZweEFlUnFqaVQ4aHpQQzlaTUpDYXFCQUNtaFZP?=
 =?utf-8?B?QmRiOWlIVG5nc1RaQUFuMTRDWnZmV2ViYWYzRU10b0UrNVBQcXJGUVhFQ1Ri?=
 =?utf-8?B?bnF3N2J5elhIc3VTTkZ0MW1WNFkrMTRQR0REc0o4b2c0bDk2cGVqOUVRUWlE?=
 =?utf-8?B?WUJFaHVFOWwyM0dIT0pWeXMyUDFoR3NVYXltck1yc0k0dko4R1JOQ2tPUGhq?=
 =?utf-8?B?TG5mU0FGejh3N2drWmg5SGlYSC9MUkowdFlVZURTK2w0dmxwUkhmci9yMENC?=
 =?utf-8?B?MzNDcUJUR2F6OEFpMHRtSERRRkdGb2Rpc0VaU01MNGV1MXY2dXVmVVhVMjBk?=
 =?utf-8?B?ZmVyZTk5MldqQjhSU1lnMzU0U1lXdU9oTUcwMCtkdDNHVWNocTVQYmNubVJT?=
 =?utf-8?B?Tnl0SzdUZWNlN3hDYnJTL0VNaTFkdU1jaVVTMTc4Z3FMdzNHYURNd0F1ZlVZ?=
 =?utf-8?B?YlNoVUF6QUFUcitwb09XSDhNbzh5NXpwUVZkR2wza0lsL0w3dDV4LzlhK1NM?=
 =?utf-8?B?TEg0ZG1wYnYwbE1QODltTENZKzZnNS9EdHkvaGRyNXh5aVBKM2U5dElOdjA4?=
 =?utf-8?B?US9FalJBOXFvT2hVdG83aTM1QUxtbW9TZFROSWdFZk15dWNVcm5kSFZjZTlC?=
 =?utf-8?Q?hSArVGMUhxYfgWm8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c3fa6f21-133a-474c-6db1-08de5d362b48
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 23:53:57.0268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +THWfcfZL3jVHptTePBq9J4VnlD7Rj/gSwpYRT0mMSLXj1GHwsXd0NRvpjlJ0Qf88jo47PZcKQy9q3t1mOQ839XLp+XAc67A+XGctiRiTII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7701
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[35];
	TAGGED_FROM(0.00)[bounces-75552-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lpc.events:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,dwillia2-mobl4.notmuch:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.j.williams@intel.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: C40568E5A0
X-Rspamd-Action: no action

[responding to the questions raised here before reviewing the patch...]

Koralahalli Channabasappa, Smita wrote:
> Hi Alejandro,
>=20
> On 1/23/2026 3:59 AM, Alejandro Lucero Palau wrote:
> >=20
> > On 1/22/26 04:55, Smita Koralahalli wrote:
> >> The current probe time ownership check for Soft Reserved memory based
> >> solely on CXL window intersection is insufficient. dax_hmem probing is=
=20
> >> not
> >> always guaranteed to run after CXL enumeration and region assembly, wh=
ich
> >> can lead to incorrect ownership decisions before the CXL stack has
> >> finished publishing windows and assembling committed regions.
> >>
> >> Introduce deferred ownership handling for Soft Reserved ranges that
> >> intersect CXL windows at probe time by scheduling deferred work from
> >> dax_hmem and waiting for the CXL stack to complete enumeration and reg=
ion
> >> assembly before deciding ownership.
> >>
> >> Evaluate ownership of Soft Reserved ranges based on CXL region
> >> containment.
> >>
> >> =C2=A0=C2=A0=C2=A0 - If all Soft Reserved ranges are fully contained w=
ithin committed=20
> >> CXL
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regions, DROP handling Soft Reserved ra=
nges from dax_hmem and allow
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dax_cxl to bind.
> >>
> >> =C2=A0=C2=A0=C2=A0 - If any Soft Reserved range is not fully claimed b=
y committed CXL
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 region, tear down all CXL regions and R=
EGISTER the Soft Reserved
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ranges with dax_hmem instead.
> >=20
> >=20
> > I was not sure if I was understanding this properly, but after looking=
=20
> > at the code I think I do ... but then I do not understand the reason=20
> > behind. If I'm right, there could be two devices and therefore differen=
t=20
> > soft reserved ranges, with one getting an automatic cxl region for all=
=20
> > the range and the other without that, and the outcome would be the firs=
t=20
> > one getting its region removed and added to hmem. Maybe I'm missing=20
> > something obvious but, why? If there is a good reason, I think it shoul=
d=20
> > be documented in the commit and somewhere else.
>=20
> Yeah, if I understood Dan correctly, that's exactly the intended behavior=
.
>=20
> I'm trying to restate the "why" behind this based on Dan's earlier=20
> guidance. Please correct me if I'm misrepresenting it Dan.
>=20
> The policy is meant to be coarse: If all SR ranges that intersect CXL=20
> windows are fully contained by committed CXL regions, then we have high=20
> confidence that the platform descriptions line up and CXL owns the memory=
.
>=20
> If any SR range that intersects a CXL window is not fully covered by=20
> committed regions then we treat that as unexpected platform shenanigans.=
=20
> In that situation the intent is to give up on CXL entirely for those SR=20
> ranges because partial ownership becomes ambiguous.
>=20
> This is why the fallback is global and not per range. The goal is to
> leave no room for mixed some SR to CXL, some SR to HMEM configurations.=20
> Any mismatch should push the platform issue back to the vendor to fix=20
> the description (ideally preserving the simplifying assumption of a 1:1=20
> correlation between CXL Regions and SR).
>=20
> Thanks for pointing this out. I will update the why in the next revision.

You have it right. This is mostly a policy to save debug sanity and
share the compatibility pain. You either always get everything the BIOS
put into the memory map, or you get the fully enlightened CXL world.

When accelerator memory enters the mix it does require an opt-in/out of
this scheme. Either the device completely opts out of this HMEM fallback
mechanism by marking the memory as Reserved (the dominant preference),
or it arranges for CXL accelerator drivers to be present at boot if they
want to interoperate with this fallback. Some folks want the fallback:
https://lpc.events/event/19/contributions/2064/

> > I have also problems understanding the concurrency when handling the=20
> > global dax_cxl_mode variable. It is modified inside process_defer_work(=
)=20
> > which I think can have different instances for different devices=20
> > executed concurrently in different cores/workers (the system_wq used is=
=20
> > not ordered). If I'm right race conditions are likely.

It only works as a single queue of regions. One sync point to say "all
collected regions are routed into the dax_hmem or dax_cxl bucket".

> Yeah, this is something I spent sometime thinking on. My rationale=20
> behind not having it and where I'm still unsure:
>=20
> My assumption was that after wait_for_device_probe(), CXL topology=20
> discovery and region commit are complete and stable.

...or more specifically, any CXL region discovery after that point is a
typical runtime dynamic discovery event that is not subject to any
deferral.

> And each deferred worker should observe the same CXL state and
> therefore compute the same final policy (either DROP or REGISTER).

The expectation is one queue, one event that takes the rwsem and
dispositions all present regions relative to initial soft-reserve memory
map.

> Also, I was assuming that even if multiple process_defer_work()=20
> instances run, the operations they perform are effectively safe to=20
> repeat.. though I'm not sure on this.

I think something is wrong if the workqueue runs more than once. It is
just a place to wait for initial device probe to complete and then fixup
all the regions (allow dax_region registration to proceed) that were
waiting for that.

> cxl_region_teardown_all(): this ultimately triggers the=20
> devm_release_action(... unregister_region ...) path. My expectation was=20
> that these devm actions are single shot per device lifecycle, so=20
> repeated teardown attempts should become noops.

Not noops, right? The definition of a devm_action is that they always
fire at device_del(). There is no facility to device_del() a device
twice.

> cxl_region_teardown_all() ultimately leads to cxl_decoder_detach(),=20
> which takes "cxl_rwsem.region". That should serialize decoder detach and=
=20
> region teardown.
>=20
> bus_rescan_devices(&cxl_bus_type): I assumed repeated rescans during=20
> boot are fine as the rescan path will simply rediscover already present=20
> devices..

The rescan path likely needs some logic to give up on CXL region
autodiscovery for devices that failed their memmap compatibility check.

> walk_hmem_resources(.., hmem_register_device): in the DROP case,I=20
> thought running the walk multiple times is safe because devm managed=20
> platform devices and memregion allocations should prevent duplicate=20
> lifetime issues.
>=20
> So, even if multiple process_defer_work() instances execute=20
> concurrently, the CXL operations involved in containment evaluation=20
> (cxl_region_contains_soft_reserve()) and teardown are already guarded.
>=20
> But I'm still trying to understand if bus_rescan_devices(&cxl_bus_type)=20
> is not safe when invoked concurrently?

It already races today between natural bus enumeration and the
cxl_bus_rescan() call from cxl_acpi. So it needs to be ok, it is
naturally synchronized by the region's device_lock and regions' rwsem.

> Or is the primary issue that dax_cxl_mode is a global updated from one=20
> context and read from others, and should be synchronized even if the=20
> computed final value will always be the same?

There is only one global hmem_platform device, so only one potential
item in this workqueue.=

