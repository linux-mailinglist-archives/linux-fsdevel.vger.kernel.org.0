Return-Path: <linux-fsdevel+bounces-55782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E76CB0EC09
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 09:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04E4C3A94C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 07:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC6E277815;
	Wed, 23 Jul 2025 07:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BK9SyRDO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76915277009;
	Wed, 23 Jul 2025 07:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753256057; cv=fail; b=qBgtfmKR2q4W4ZCcleQp7RX2uhksA9Sr0U8xz/Ps3SRFVBGHfmAi2SGkAPQ1HZsfO5U9eM3hTROb7hg2zho31WHwBShqQvipLgPmWmgozubt1B9b7SjMVmHaCTeuJN+5Dsxsr5HxKloozrlBFx5Kh8shs5PSTlPGV/7OduGmb10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753256057; c=relaxed/simple;
	bh=21mT3ng9yC9VDzErVtaL3R2+8c65XHXfxhInAEqCOgQ=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=Ych4vLg6tBg75aLDCQHcNzjvWUCirGBouCWc41Bi7nKel0j3bheJ6lZ96ySnS/B/W+dNTC7w05KJ/JhC/cFkmAfnDauLdrsbUFVjExjI4a2Pqfs4FkxWDy2/Pp5iB0xuPoTtfHYSv9VTbWfV9PdTEaxCPv6eQN0Aw1wVExYLdAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BK9SyRDO; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753256056; x=1784792056;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=21mT3ng9yC9VDzErVtaL3R2+8c65XHXfxhInAEqCOgQ=;
  b=BK9SyRDOFqTZ6zCZj2/0sc7PhZJTxEBRddXzHUlhLCKeJy7WrZaf1gva
   YbwWkVrB34ACz+dKk0fuqrgj6TKwzJpIQZMFqpAph6HBJh6bLhJExnqM9
   8C9IDzTEhhDw4SOU/ZFboRluYvU7Nz1SRx670EZOlXh0U32ennqYfp6Rt
   qvsJIWPkPizq5UdVVWwDWg6jnd7k+9Lxyj2Ja4ZIllWWduqtd4z2BxKTh
   TUaJnhw/yUnZePXOwXRR63oQlmCJO1tjaCQ/1RLg/9KRoOP+DL4oFRV0h
   B9zaydHbLqDAPPO8AFhETNPmylBLlgE/xxwXgnALXZF2kokyVHlM8KZzd
   Q==;
X-CSE-ConnectionGUID: 18MGwXmBR7qdLjyQpXU+xA==
X-CSE-MsgGUID: +i+FHxo0QFy4azuCO2gSAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="59185856"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="59185856"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 00:34:15 -0700
X-CSE-ConnectionGUID: H/rhqdLSTL2pSHHmwKfE/w==
X-CSE-MsgGUID: 53bA8/7JQlm/SqDWzyd3mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="163597240"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 00:34:15 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 00:34:14 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 23 Jul 2025 00:34:14 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.40)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 00:34:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CweDbP2lekQeB1OCLCJ6EcQ5CLa9DoNUZ+YVHcmGYbSO6VOWOJweXroBixKYcs5rXGa2Joms9Smza8QRLMIiyJb8T5gBqEhocTB31yYzWetdCPgR3PhzG7VprP2v8RejluXzV8gXfDoskfEgYX81C73z4wDWGPlzCyMtdMBbwEUXsSHxH2/Ue01o0oUrtuLbBbvWrxW68m8dv6kOFyMoq/mk9vw+77pxsIffQrJ8x/eAnVDXgMCXiLomzc0TooecfuJGidcnG6QOOiJWHKsK8YY59PcBbdEy6oucXuGs+w+h6REN/LWwLNShTwsVPnfEP/AGX8pe2KIhd1I+VjqpDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8dqz0UI4yzRqRL2VK5u5VxqYHfyeNL2jS4/MF5miKM=;
 b=Ug18FYHmEadZBxgD1ByTE4yQAzkabxhQniHa2Rnje6hXIoev3Y1Ev2QZpXrJUgU5wLEO4YdErnfJIPnXLcT7xw3sRuwVb5Njju5nvg8GAkR7TsgSjrXRASPuAzJ4hYVJ2lYbumIKoClkQjFUXrl/aYV7npN7yXih7B8yoWSnP1OHWvAjWqbn6zguLKCJtRPVL1Jo4qdjr6rGVVVoRN+uoRoPmUsz5jT/L5Y6upEE+6huRqQVgTzPgOmh70oUJlbUXRybnVHnd9MYCE00OVKd/pMtDwzwo03W0GxUTMvaTC31l3MvuyDoUZZtZczW0huueUKN+QXZLkYUcUDsZ7/gdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB7711.namprd11.prod.outlook.com (2603:10b6:510:291::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 23 Jul
 2025 07:34:11 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 07:34:04 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 23 Jul 2025 00:34:02 -0700
To: Alison Schofield <alison.schofield@intel.com>, <dan.j.williams@intel.com>
CC: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, "Rafael J .
 Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek
	<pavel@kernel.org>, Li Ming <ming.li@zohomail.com>, Jeff Johnson
	<jeff.johnson@oss.qualcomm.com>, Ying Huang <huang.ying.caritas@gmail.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>,
	Greg KH <gregkh@linuxfoundation.org>, Nathan Fontenot
	<nathan.fontenot@amd.com>, Terry Bowman <terry.bowman@amd.com>, "Robert
 Richter" <rrichter@amd.com>, Benjamin Cheatham <benjamin.cheatham@amd.com>,
	PradeepVineshReddy Kodamati <PradeepVineshReddy.Kodamati@amd.com>, Zhijian Li
	<lizhijian@fujitsu.com>
Message-ID: <6880906ac4e68_14c35610091@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <aIAwnACBeWindJ-s@aschofie-mobl2.lan>
References: <20250715180407.47426-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250715180407.47426-2-Smita.KoralahalliChannabasappa@amd.com>
 <687ffcc0ee1c8_137e6b100ed@dwillia2-xfh.jf.intel.com.notmuch>
 <aIAwnACBeWindJ-s@aschofie-mobl2.lan>
Subject: Re: [PATCH v5 1/7] cxl/acpi: Refactor cxl_acpi_probe() to always
 schedule fallback DAX registration
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:a03:217::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB7711:EE_
X-MS-Office365-Filtering-Correlation-Id: 1972839a-8487-42fb-9cb7-08ddc9bb4d2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejNPaG9BbmJuSjJlRzFEYzVGQnM0U2R3RnR4dS9sOThsZGMvcHdqM1ozWUVv?=
 =?utf-8?B?N3RGTjdJcWdVcCtjY2dxNmkzdEpvRXVMUWNRYU8yVHE1NnZxOStuOEJaUExO?=
 =?utf-8?B?bFZhdDlUV0RXV0hTenBPSWxJVGgwRVhGRVUyWjR4aDAyWHB0akNDN0oxODQ0?=
 =?utf-8?B?aDZQdG12SHBQMDVSWVA4UU5wUUNEOW1ocU43UC92VGhSS1hkajVvdTJqeU1o?=
 =?utf-8?B?dmZqWTFMVStGWVBjM1hIdmRiTkFibGhCVm1PY1Yvc3V3V1BxdmxYd010eFVR?=
 =?utf-8?B?VEd6NVBubUh4czZYNkxZOFNsaEduczhSc1BSa0svNW40SHArdmZWTUhoVUlP?=
 =?utf-8?B?YmF0NldLOFgzV2VGQXZOeUY5NU9xQWVHSkxjUSs3ajlXMzBNVzVuZUhsQnBT?=
 =?utf-8?B?TThaaDBVTzRNMHc3RnJKbXhWbjRJbTFYWWNMT0Jta3dxVFdkNXprMUwxQnl4?=
 =?utf-8?B?dXV1b2VPTFluTjlZOXJwZ1Y2OU81cm5jMnFIYlUrZXBEVXRsT2M5YmxwYWFl?=
 =?utf-8?B?eHJhNlhzRTM4akYyZ25xaWpnVlg5UFlobDhBREMzM3ZLeENUSlJPYXZrZngz?=
 =?utf-8?B?Q3B0bVFKdGNtWTd1dlFLKzVWU3Y1VjFjRGFFTTBwdExRYk9mZzZzWTFQWk92?=
 =?utf-8?B?aUxJVmNYSHhxZGllMGZ6dlN3cWlPYkt4aWsvQXZkRHQ2QnkrTmw5RzJDdFp4?=
 =?utf-8?B?Ykg3c3M0OFVsYlJjemowMzlXSUxFV2Q1SGRNZDdJdWNTTTQ3MDJoT1BjdWZx?=
 =?utf-8?B?VUgzUUpKcGh0dStodDVtMVIxOGVYNGVPcmVtRms3TFp0U0lYOFlzb0o1U2dP?=
 =?utf-8?B?ckE3cElxZmdwNGZLSHJQY1FWZFVCZjFzNktiK1VpRHkvZjY2eW9jeHl5NmhV?=
 =?utf-8?B?RDNTbUV4UmNJY1NCNzVWbHFjRm9Hd3g0MHpHLzR6WDRZR2p1bHFvWFZ5ZXI3?=
 =?utf-8?B?RE5OQmlOQVNNaE9RYW9Yem9BKytkWmhCU21Ua2RJUldibExlWktRdjRJRWhK?=
 =?utf-8?B?NXhFNnQ4NFVNUWRlVHdxcEVlNzNaQTFJWjZqZ0dGMk44aFc3a2t2WVpCQlRR?=
 =?utf-8?B?YUZ2a1BRWjdERXlpUHNGeGxpckV0WUk4Y1RoZytuVlZRbjFwYUdBV1EzVTdZ?=
 =?utf-8?B?SXRvYWNidVF2aS9ISmlIbUhkZ2lCaHIzQUs5bEVQUERxWm56RnUrR2N2VDVh?=
 =?utf-8?B?S2tRaFcrNXBHdXVOQ3FPcUcvRmxBTUZYNEJTc2lIRHdlRXRETXNubEFOVjUr?=
 =?utf-8?B?S2x0akJRK0N5U1hkTTdoZDduT05qbEs1cmJaTlZSWUF0c3YwNTMydDJvR0w1?=
 =?utf-8?B?aGxySU5SRjRhc1EvRzFwWm9hUk9aeVpubFJHdG9NaFhpUWt5UmY2M1BuVFk5?=
 =?utf-8?B?bTJPMlJ4bEliR29SQ0IzMm1mTWlCR1VybnYzblBjalNMbEh2UWxRb1hGd0dR?=
 =?utf-8?B?QXhSS2JMa2NCZWdOblNObzVZdS9tSGREYnFwWitBRVlzQk5SMnFFK0hmUzNG?=
 =?utf-8?B?UlBPaU0xc0U5RDR4bEdMa3hXS25PMTVYT3BDNW9tOGlDWVVMOE1WaWpkazFh?=
 =?utf-8?B?NVBNdS9ObXhheVExcVoyZG5OU2VpWGR1bklDY1cyNmlJVzNFVmlhenJZV0VP?=
 =?utf-8?B?TVROdFBjK0RNNElhWnFXeFRPQnZjK3l6SmlmU0xwMHdTMWF2dExINVluSklR?=
 =?utf-8?B?ZmxMamFURWtraTdZNmR1Tmd6SkFpUXpWNEk1NDQwMXFESjdseGlVcDhLMWxw?=
 =?utf-8?B?NVVJZ3FWaWlqY1g2WTBCR2RPT1BuRlR6dWFQRGhyVFEzVUxuUmlwY3BiV21y?=
 =?utf-8?B?R0hUUnNkUE4vbDhTNGwrZU9vNlVYdDNRSzBDYXNDbkJiUlNzS3RDcDN0NkUx?=
 =?utf-8?B?TmlqWXBGTHdoL2ExYWE2bzlpSkJoVUpUOHR2WjRVbnZtNU0xYVZjR3ZSTmpW?=
 =?utf-8?Q?lURpHKeIzkw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkVVbU41Q2lTUnVFTDIrVnJwVjBkSVB2SjJwUHVINTJ5a2pTaW5mUGlRNkxD?=
 =?utf-8?B?Q2laZDVUaTZFbU5qYzkrWkFVV1NEb3gybys5YWpPTVFYaHdFVFlscy9wUWdm?=
 =?utf-8?B?eFNUbFZrMk5NbVJUdndMdzV1Qms3UHl6dUNTbm9oMlJMVCtWYndIT2FUR1NZ?=
 =?utf-8?B?bjRTMTcwMTE0NkJUbmNYWmd5akVVWjFKUkJ2elp2M3V2RHhOY0dWQ1QxSHNr?=
 =?utf-8?B?Nnp3aHl5S0JuMWRHYUVBc1VNVC8xRVU4b0hlR1hjd1lwYUJvODNzSDN4ZXQ3?=
 =?utf-8?B?dkt4TUJ3Tkp2UUM2cDRRRU9zdkFBUVNHK1JUeFVuZVl6VlJFWTVvVm1tMkNw?=
 =?utf-8?B?Y1ZLdnYwRHdVUTJxV2MrRy84UzRneGllMUtPbHFkMW10aFBTS01GM1hTWnJD?=
 =?utf-8?B?Z0xJUjRyb3JmZldGRXFWanFtZlFUaWZmMHlZclVkN1pQZU15djFienlKSmg2?=
 =?utf-8?B?TmlTSkVCbXIyWkpjbFprczlPeTRuc1RmMFJSY1BCYkZpeUFlSnB0c2ZLQWtB?=
 =?utf-8?B?NVhIMlJINDVLMmUwMnh6cGVvYURkbnhjMFY4dE9oV0FMTEF6Sm5zV3JMelJh?=
 =?utf-8?B?bzJLNDQ5U1BTZ3p4U1ZidjZiWWxrazBJbEtFb2hjeTlJOVBFSFZKOEovSFJZ?=
 =?utf-8?B?VEdjUnpYb29nRXBjaWZCQlFDM1cvV3lmRWJKVy93K0NMR0paRUgxNmh1akFi?=
 =?utf-8?B?TkNlc0xHSU1yTkJFK280ZU5naXYxODdRSWFIS1dic2JNV2Y0L3NOZVhzVDBK?=
 =?utf-8?B?Y2ZDVEJRUHVCODVlUkg2Ym02dnNtQ2lpOTdPN2FJTGxZWU5HWlFRZmdKWi90?=
 =?utf-8?B?dm4wU0QvRlEwZUZXdlBTYjVzVmQyUjdidkplQ1diOXR0SVBPQXY2bjNTem5a?=
 =?utf-8?B?dWN1eXhvaWpGTGU5d0piY1F1eDBHbzRNK1czTlFkRmZ1VWhpZFI2R3VwZytW?=
 =?utf-8?B?VTdscVBienlwdFpFbmZReGI3UWNqRkRXRjQ4L2FHOGFqalFVOU9maGQrNy9k?=
 =?utf-8?B?TE5KNGUrU2t1MmREWHhwR0VIVnhpeU5PamtocVZHOUpoT0tBb1dKYVZQeWZU?=
 =?utf-8?B?RUJxRzE4UlRXRFRGYUxVdWhJTXFGa3JnZXZ4YVplU2EzTGJvWmpwZlJDc1BJ?=
 =?utf-8?B?aERVdTFaNWNrUEE5SkJRczdsMWRUWWVEaWlndnR6ZFRBb1YyME94RnFEK05N?=
 =?utf-8?B?aWJMLzQzRUxBSFJoa3VlZ24zcENGQVB3azJmU0hyUldqQTl6WDR0YlVSN0Ju?=
 =?utf-8?B?OU5ManFWcDBWcER5ZCtOVWV3M2xBMjRWdm41cVh2NjJxV0tldmVncll2NHB5?=
 =?utf-8?B?cEE2aDZpTDVxa2Z6Y0ZINVgxeVNJdm81M3VQekFlSk02dzFZZGV6eThEM291?=
 =?utf-8?B?UHg5MExvd0FINTZuS3FBd0R0TFNSVy9vNXJRcmszWmh6ZStYSVA5eHd1YWx4?=
 =?utf-8?B?LzYzTUVaRkcvV1ZVb2FpcUltZnhTZ0puVVpqdE5ueUhRWm16NkNxaEo5ekhh?=
 =?utf-8?B?b0g1N1pWYVBmRzhTWGdsSFozd0lqbnRGMGk0SGoxZ0R0UW9GMU4rYjRmYjF1?=
 =?utf-8?B?V0NEYi9TN3BMUGdZa1pPcjFUL0NxbjBkTWxrbzJ6Rlc1OTZOWEFHWDhNMjdF?=
 =?utf-8?B?N3NoTmpoVkZhNXZobmt0QUlVUXNHdEJDelZLMlJQL1RlZ29KUXdteFNYQUN4?=
 =?utf-8?B?ZGNIaUZYb2NjRWY2emdRN0hzNjNVaDNxb09hci91dzJRVkJzK0N4MkVXdGNy?=
 =?utf-8?B?ZmZIdEZKNFFsLzVUdlZnTnFUYlZhVWcxeHI0RjVVZ0ZRQzFabmlCSWFVeTZN?=
 =?utf-8?B?SGVobGZaOENxK2dDdDloZmVHYnd6K1lTSXhndjZHTmZMVHlOOEJSMUxyMjlM?=
 =?utf-8?B?cUNuaTFlZWNjenk5eDRlRnVUZlA1bnczOUd5R21XMmFtb1JSeHVuVkxFa0dY?=
 =?utf-8?B?dklINEtqcVBIbGhsMG42dThOK1E1bW9YcndOcHpIQjVNWkhEaUg4Q0hhOUVX?=
 =?utf-8?B?bFdwOExlemVoQVZmUTN4YWc0Mys0QXZvN1F6bDY2Q0J4cit3RC9IOTRtVk90?=
 =?utf-8?B?Y2NxNTBZOGJoVGNzcVdjOE5sdnUrZGZOdnduZ1FmNXZrbldHY1hLMWNaaUxj?=
 =?utf-8?B?dU9LdzdvajFqRXJlV0R5czJ0UG56NHJhTmYvOGUzNmFtWDdkWkVXM2o2elVV?=
 =?utf-8?B?WlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1972839a-8487-42fb-9cb7-08ddc9bb4d2e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 07:34:04.8874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aZOsVEQ1Hs9+cC+bUSNM6O55edEDW4r6c1qGL66Lx3X+CUpSuTsmSzMkhwoEnmQC1FiYa0ESTaUgqjEkqwS/vL2dlrKfkvQC++kjlSMWR9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7711
X-OriginatorOrg: intel.com

Alison Schofield wrote:
> On Tue, Jul 22, 2025 at 02:04:00PM -0700, Dan Williams wrote:
> > Smita Koralahalli wrote:
> > > Refactor cxl_acpi_probe() to use a single exit path so that the fallback
> > > DAX registration can be scheduled regardless of probe success or failure.
> > 
> > I do not understand why cxl_acpi needs to be responsible for this,
> > especially in the cxl_acpi_probe() failure path. Certainly if
> > cxl_acpi_probe() fails, that is a strong signal to give up on the CXL
> > subsystem altogether and fallback to DAX vanilla discovery exclusively.
> > 
> > Now, maybe the need for this becomes clearer in follow-on patches.
> > However, I would have expected that DAX, which currently arranges for
> > CXL to load first would just flush CXL discovery, make a decision about
> > whether proceed with Soft Reserved, or not.
> > 
> > Something like:
> > 
> > DAX						CXL 
> > 						Scan CXL Windows. Fail on any window
> >                                                 parsing failures
> >                                                 
> >                                                 Launch a work item to flush PCI
> >                                                 discovery and give a reaonable amount of
> >                                                 time for cxl_pci and cxl_mem to quiesce
> > 
> > <assumes CXL Windows are discovered     	
> >  by virtue of initcall order or         	
> >  MODULE_SOFTDEP("pre: cxl_acpi")>       	
> >                                         	
> > Calls a CXL flush routine to await probe	
> > completion (will always be racy)        	
> > 
> > Evaluates if all Soft Reserve has
> > cxl_region coverage
> > 
> > if yes: skip publishing CXL intersecting
> > Soft Reserve range in iomem, let dax_cxl
> > attach to the cxl_region devices
> > 
> > if no: decline the already published
> > cxl_dax_regions, notify cxl_acpi to
> > shutdown. Install Soft Reserved in iomem
> > and create dax_hmem devices for the
> > ranges per usual.
> 
> This is super course. If CXL region driver sets up 99 regions with
> exact matching SR ranges and there are no CXL Windows with unused SR,
> then we have a YES!
>
> But if after those 99 successful assemblies, we get one errant window
> with a Soft Reserved for which a region never assembles, it's a hard NO.
> DAX declines, ie teardowns the 99 dax_regions and cxl_regions.

Exactly.

> Obviously, this is different from the current approach that aimed to
> pick up completely unused SRs and the trimmings from SRs that exceeded
> region size and offered them to DAX too.
> 
> I'm cringing a bit at the fact that one bad apple (like a cxl device
> that doesn't show up for it's region) means no CXL devices get managed.

Think of the linear extended cache case where if you just look at the
endpoint CXL decoders you get half of the capacity and none of the
warning that the DDR side of the cache can not be managed. Consider the
other address translation error cases where endpoint decoders do not
tell the full story.

Now think of the contract of what the CXL driver offers. It says, "hey
if you change this configuration I have high confidence that I have
managed everything associated with this region throughout the whole
platform config", or "if an error happens anywhere within a CXL window
you can rely on my identification of the system components to suspect".

> Probably asking the obvious question here. This is what 'we' want,
> right?

So, in the end it is not a fair fight. It is a handful of Linux
developers vs multiple platform BIOS teams per vendor and per hardware
generation. The amount of Linux tripping, specification-stretching,
innovation is eye watering.

The downside of being drastic and coarse is worth the benefit.

The status quo is end users get nothing (stranded memory), or low
confidence partial configs with latent RAS problems.

The coarse policy is a spec compliant, safe fallback that gets end users
access to the memory the BIOS/firmware promised. It buys time for the
platform vendor to get Linux fixed, or even better, these Linux
coniptions catch problems earlier in platform qualification cycle.

The alternative fine grained policy hopes that the memory the CXL driver
gives up on was not critical or indicative of a deeper misunderstanding
of the platform. I do not want to debug hopeful guesses on top of
undefined breakage.

