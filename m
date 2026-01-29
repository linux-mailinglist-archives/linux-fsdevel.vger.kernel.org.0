Return-Path: <linux-fsdevel+bounces-75826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Oz8vB6qtemnv9AEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 01:45:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE5CAA571
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 01:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E9C13028342
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 00:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B205535966;
	Thu, 29 Jan 2026 00:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YD2MNMCz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63862C187;
	Thu, 29 Jan 2026 00:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769647518; cv=fail; b=HTk8BfQ0YYEbqGGVK/mH+1PfUrRhjgo5oJFdhghGh7/LVOBANVzTo1vgyJ1nYaaTbxtrknHUmHrYgCH5pU9RxPLd4aSkx+HES3xalZuRLNlNYHGlwvJd5ZPMEfS2s+rUgzaAgMkqGjhchPiYTewjrGSr3V327CfLwgg0f4TuZog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769647518; c=relaxed/simple;
	bh=6Hi7ArYtggrWCwZs7x+KWjxIP8avNGF50quCw5EptB4=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=iJEwhaJOTmtq+2joAfXC+B7bZ3OmiRXdPHz6NVy2LclucKXOTypqgd6/Gwa20yytQvi0bEwBFlWWMmBzwkGo0I94sNfcDi0eyf9QTcGGWoHkuNLKygkOW4RWAOf40/l7I32BmikdzDq2F7VfB7XwP+lrfutemsofyVWOYQ/rREc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YD2MNMCz; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769647515; x=1801183515;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=6Hi7ArYtggrWCwZs7x+KWjxIP8avNGF50quCw5EptB4=;
  b=YD2MNMCzGZ+2M1XC9VUAbNeGpackMPQETptgQGMTAs0S3ilVsc/gYBNu
   14SQlzCkM+f+NfwLpTPvTaMT4hFwaxK6SgmIBVz/ALHA1H28qe8+EZnJg
   6ft+JP2rqjafSZ4z6tI002JQbyva2f4rf+SkRyNgxiJhkaMBHixj1615h
   mcqNyE2qBaE6iVrJARckZ5gm1z0UwKQkt/uKpqJlH6queHW5xprVhdRgn
   vR7zPfVBxUlsVwTgpNLuZDTsDgcw/FnDNQU+SKEjXrNu0F5BcTCTHkKm+
   S7HfaK0fdGHXysgOxomm9suYOeoWp7qzwsY1nnUW5NruB8spooG2V2Mkq
   g==;
X-CSE-ConnectionGUID: wo9f9bQmS2aJjMDxjeGo3g==
X-CSE-MsgGUID: zd/cNaqLTL2UDgH3g+S1bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="93533773"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="93533773"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 16:45:15 -0800
X-CSE-ConnectionGUID: 0nm+qzBpQ4utZTe7I8X18g==
X-CSE-MsgGUID: ouo8cBwNQ72T0CYcTGvYTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="208309020"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 16:45:14 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 16:45:13 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 28 Jan 2026 16:45:13 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.18) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 16:45:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mswcbj17yj+xsXcVLiKC4Zwgdxg6w4sABVA3TIsYuuehQTYZzai8NhpdU5ZmtObjYG3fcz6sE6XWrQxks5sVJoArXkL7PnhspM2Q1YUx93E2XY8VP4fNJouWCkniWoPwvRFvzpss8Nz1LPbBEUJbObplLvpxZXUnDBCx+dZ0tMkaFUSVpfEwnbw/gaZHEt+jIAN9NFYa4/aepA2q6JBGoRRniXckhOsBYV5bNtDqreMCBpAdApieBG32JyK/IoEMnODtEraglZpahmT0Pj9Nqy/d1znxGoO9i1B3e5KAiXb2pj2jJmc31EyXEqymy+3B9R56qsF1F6XdYWbxm9vAaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvXOJfMGM0qtq0jYA7+qTX1+rQGnDjhjcMbqrztLiCU=;
 b=k7waDP1GO/HQBoOQTmur+/CxwM2Vo3+5bNQen5VL4TTlmojYlimnFtyOHdBN1fIbTIGcJu0rlzB7XLXeKTAcd/5tPPUnJrGx/1//M/yBHfhIW9B4XTJWUbO9Wg7yZFAcQHIUtnZ8I+nMrYQIBCs8AUELppM7VlA889rcAYvtr6U/zxmVvPcV1OTGvhfgQxaQ3PPhz+aAV9ILiLPoOzEOtzRcGRB4n1MgJio0iTkf7vCGVEw9gyPCkxRENNw3EMuXUZLbF4hssTB08y8ENNBfje2HCYFKEgAT2/oCpKgGJ4apxhShDpAhAbgswcL1HAJZPi6qZJS1vZ2sXqJAZ9KIeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6288.namprd11.prod.outlook.com (2603:10b6:8:a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Thu, 29 Jan
 2026 00:45:11 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 00:45:11 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 28 Jan 2026 16:45:09 -0800
To: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>, Alison Schofield
	<alison.schofield@intel.com>
CC: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, "Ying
 Huang" <huang.ying.caritas@gmail.com>, Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Nathan Fontenot <nathan.fontenot@amd.com>,
	Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>, Zhijian Li
	<lizhijian@fujitsu.com>, Borislav Petkov <bp@alien8.de>, Tomasz Wolski
	<tomasz.wolski@fujitsu.com>
Message-ID: <697aad9546542_30951007c@dwillia2-mobl4.notmuch>
In-Reply-To: <5b4988a0-90e2-4f85-83bd-bf54b3f69a12@amd.com>
References: <20260122045543.218194-1-Smita.KoralahalliChannabasappa@amd.com>
 <20260122045543.218194-7-Smita.KoralahalliChannabasappa@amd.com>
 <aXMWzC8zf3bqIHJ0@aschofie-mobl2.lan>
 <9f33dc8b-4d0c-4e0b-8212-ecf1a2635b5d@amd.com>
 <aXfrptWS1C5Pm2ww@aschofie-mobl2.lan>
 <5b4988a0-90e2-4f85-83bd-bf54b3f69a12@amd.com>
Subject: Re: [PATCH v5 6/7] dax/hmem, cxl: Defer and resolve ownership of Soft
 Reserved memory ranges
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR03CA0344.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6288:EE_
X-MS-Office365-Filtering-Correlation-Id: fd128004-c1bc-4d00-1c59-08de5ecfa862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0JVUWl6VFJzcXNSMDBadDBQTWtWTE1IUi8rejdoekowYjY0SXY3Qmt5c3Nh?=
 =?utf-8?B?Ky9QR1VETmk1b2RZbkt0ZXFzQlYzenlOM0NLajVsZml2OTlMTlFza3kvOUJt?=
 =?utf-8?B?cHNCQWVXbHh4RjgwMVZqNjRTVk4xWnltV0dmcmN6SUYwU0Q1QndMQ0l1VkY0?=
 =?utf-8?B?bEJFUzhKR0dQaFRwZXFUR1Q0TUpDUW51TGRIK2FBWG5rVVZodmx1Qlp3RWpI?=
 =?utf-8?B?Yk5TTU5lM3dPWnAxZ28rUkZiN09HL0R0WElCL1BWWjg0b2NGbXA5ZXpsQ3do?=
 =?utf-8?B?cHpHYTByYzc1K3U2UGUyRkJoR0VkbzBMNzJJbzFoa0FpNmxsWk1JRDFyei9y?=
 =?utf-8?B?MnN5QzlSSmJ0M0RhdUtJaG5WeHNxSk8yUXJhOXg2MkxUZWxTM3FqRm01WnB5?=
 =?utf-8?B?SHVJZUVmbm56cFhKTnZvN1lNcUtUbDRTVmZmcVloY0FZMkw2YksrQjJzUEFO?=
 =?utf-8?B?UDQ3YW9EN013UXhEQ2ZWRks3Njg2ejRQclZWWVZKU2xrRktSNXRnWmd1VDdq?=
 =?utf-8?B?b0FMRjFQNnVwSTlvRDZhRDQwWjJpM2lQNUt4Wk0zMFFHZ3VaQ1lCb1JXZEZ5?=
 =?utf-8?B?cFlNYnRCWDRCKytkN1pib2tqMEdLam9oWG95VnJMTWdQTk0zS3dEYXNEUEJZ?=
 =?utf-8?B?UU9Md1V1cVdlMFh1d2hIZlJrQmlOQmxNcXE0Y0RNL2JMRS9obitTaEdIaFJT?=
 =?utf-8?B?RDk3VU0wdkNRd0xtV0lxS3VZMERHSW5yMmFyWEw5N081clNpV1kzOXF0eUor?=
 =?utf-8?B?MnpVLzViZ25zUi8zb0lhOW9yVit1bmdacmFONHE4NHdOZ1FuY2RQZzFaSFV3?=
 =?utf-8?B?eGhyajA3UEYxRkh2RHRQemtKSE53TE9zZzNUT3YzaUlwRlFxZWlWTVVSUUN3?=
 =?utf-8?B?MWZQd2sxV0I5YXRNN1M1SWEwVU5WR3N6SnNZM3Zaam1ZQ2Z5SmxYekhwZzJm?=
 =?utf-8?B?ODl5MzdIZEJHSFZGdXhlRzlhUDVvQUczc3V0YVYxbk11eVg1cjBIOC8zWHZq?=
 =?utf-8?B?VmpIS0lJa0UyajlyNmJEY1FDWUE5QmcyZUV3cHZnMW10L3BvaVZzMG9MbFdD?=
 =?utf-8?B?UWd0MzFYZm9XVXBZMWw1K3lyVmgwS3F1U3k3d2ZBRHYyZng3SDNjZ3ZkM2kx?=
 =?utf-8?B?N3E2eXpwdXZOaDNhY1d5dUlQYUJSaFU1aDgwdFhKUWFFVUpBL0RZQlAwUVFN?=
 =?utf-8?B?VzE0MklRVmJjYVVUTGJLNmJzSWxGZFlNWENwV25GTmZ1RVB0YkJ5M2tIaFBa?=
 =?utf-8?B?WEN0U2tObUVPOFJpQUxybG5kT3dxOTJvNnlNNEdZMlJ2a29lNmdWSlFJc1ov?=
 =?utf-8?B?ZUVURU9VN0ZtdEdPa1VmK056MEt4dFFqYXE4RXlkek9oMlVEOEJyb1czSitj?=
 =?utf-8?B?aStTVGRoeXZ5VUNkT0tyREpucTRnSGpNTGEvOFpoeWp6ZHM4Q0VJc1NhanR1?=
 =?utf-8?B?a2srdW9jMGhNTkVzZnZ6Q25IV0lUeUFqUGdQSHEvWGJtWUFTQVl6Wk44bjZ3?=
 =?utf-8?B?LyszUTJKbDNlK0d0SjliRm95enBTN25EcHkzMEdBdDR0YTdLN09mK2FUaWVr?=
 =?utf-8?B?RGtzMHJqZklXVnY3ZTQ0aEhOU2pEVHZXQkJMS240R2Q0VDByU3RpUTdaY2Ix?=
 =?utf-8?B?U1FsYnhQeXpjQUdWTUxmRUJzd1U1S0RwTXE2RWFUVThhalZXZUM1aDJxdXhO?=
 =?utf-8?B?Q1ZqOXBrRDNUMk1TSU5rdlRueHRZQmMwMjljTTNkOTdqRU1ybDlibmRSalB4?=
 =?utf-8?B?YWJFeGNBK3Q5YVhiZDhzenVZOGQ4a2tQVVhreTJQMlVwd3dWVFJrUW91VHEz?=
 =?utf-8?B?WXI3SjNBcWJ4aEVjTFZQb01BYUo2QVltUksrVURUSWR5RWN5UUJzdE5nYUNR?=
 =?utf-8?B?N1FxNEpibXpHUTExMys4WjRLNzlUQk4vSlIvK2hIQW55dE5KMWFaN0xaUk00?=
 =?utf-8?B?OE40MWUvZzlKelNBZ2xFMVVQLzg1RTFOR2pGWGFXcFoybnNob2tQcVZyUWsy?=
 =?utf-8?B?WmdERE9ZNlRmZllYUmhmcWVwNHZCS1l3alZYaGVpdlFMRVc5bGlPOWNOc3pD?=
 =?utf-8?B?S1ErZCsyZTdQMEh0S24yclo0bk1haE5tck40cDAwN3BSYmQyelVjdkdia2xi?=
 =?utf-8?Q?Q09s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEFCWmh2OGRvczVwNEo4NGQ5eFNZK2hBQ05uaDBKWVh0WmpScWFLY3Z2N21u?=
 =?utf-8?B?S2xYK2pFQitIWUJvWCtjQkJRdVV5WUlTNEFHUGFRai95R1F2Y1d3eUpJenJ0?=
 =?utf-8?B?Yi90V1Y2U0M0YnlnMFBPczBUOEgyZ3lXc2pzWFFyRGhKb3gxcFVyYy9nZEVq?=
 =?utf-8?B?U0gzODRZMlRtb2UyQ0dYckhSc0NDUUFHQldueUdiZ2tSS2NpaFNkLzVlWUEy?=
 =?utf-8?B?ZG82UkpMdndZTkNJMVRkQ0dUWFBBZFN3V2VsOG5rZlZPM24xSDRBdnlHdjh3?=
 =?utf-8?B?REhwOVpaMStjeDQyUG5rZzRyMjZEMHMxR0U0VEJIamNZcmNYei91S1UrODJ5?=
 =?utf-8?B?YnJ4QmY5OVlqWnVjSThmaVEzNjc5YXFYOTZLSWlyVVhjRWNZZTV0NHVHemNl?=
 =?utf-8?B?QUhuUEcvcENOOVd3cytJR1N1NFhUNC9FUGdmMzJMNWl3SjljcGsvY2doTUty?=
 =?utf-8?B?R3R5ejB0QlpXeDFsTk5XbHB6UDE0RWZwMHlsVlU1bGNHMUQyS25rL3ozbndN?=
 =?utf-8?B?dHFOa2FiNzJWZjdxdmh2b1doNkR5SVg4WEYvMUo4M2hRWWlGakhrRzZjSjZH?=
 =?utf-8?B?NXdzVlhDL3lLTHBTdjV2TlBPVFdFc1JuODJ4Y1ArK0dENHBUN3E1Y2VGK2NJ?=
 =?utf-8?B?OEQyMTI0aW1jMXhHNTZwNVhvUnE0REhqZHM5L3NQMFY3SE15c0dHcHpGa2lI?=
 =?utf-8?B?ZFhsVm9ZcjZCS3BQY2tOWUxQZzFxenJvdi9Xc25ZTW12VUt3MHBmVURFV1NJ?=
 =?utf-8?B?M3MzYWNNY1Joak9yNHNEMDdZTklBZFIreVJyRmd5Yi9peDgvUmtqR2JibkJF?=
 =?utf-8?B?TzlSc2V5d2drYXpZMFJudXA5NWpnUGF4WEo4WS9JQmxGZ2tGWEh2SmFVQ2xK?=
 =?utf-8?B?UWRIMTNQSHptcWZWd0lVYVFxYmgyOTgzeW1ZeTNPbU1CNHZHSE9EUndOcWxZ?=
 =?utf-8?B?MVl1SmIxMUpJd0VZVU1FOVVOa3dvdk9waUl5K0RWa2llM3dLVzBjRExGdVk0?=
 =?utf-8?B?ek4wcHIwNHlNWHlDVWw1RThNVDlENjJpaE1adEtnR21BelQrVjBzQTJDckx6?=
 =?utf-8?B?UmltaUdQN3pKSnVTS3I2QWE5cjgwb2hyUVR6cTVnLzZucnFOU1pNMFEvZXRx?=
 =?utf-8?B?RzNZTzdienVuYmN2enJuSXZqNnFkbUhjL0RSQTM5SnFzSmRkd3pQTkZKVXFE?=
 =?utf-8?B?T2ZZa0lkQjYzc3FFM0NsSS91RUhWK2p1ZmVGOEpTTzdsZUhBVFJzMjFHWGFI?=
 =?utf-8?B?YXEwVnQySDlOTzlnTmZIVUdXUTYyL1NmZ25vUEFMR0dvTjllOFN0ems2WGdx?=
 =?utf-8?B?cmU3cHFhNDRtLzFqTHdzZWs1STl2aWVEVmFUV1UvZUhMcGFWQVdyL0ZiNjZo?=
 =?utf-8?B?dXVLN2F3c29VWDFxTmtrUkNNMjh6RC9VZmQzUzQyS0JEeHNBUmF5WjcyNjJk?=
 =?utf-8?B?bFdZNTBKbVBmc1lZMGI5YytJZVNISUtydUJqdEt3clZuVUdUa3llMkh5WFoy?=
 =?utf-8?B?UEFNQ003dVFXNmdtWWdzRVcwQ24rOFZYL0JhbCtqYWVNeUNnSkRUWjZvRzBy?=
 =?utf-8?B?YmtMMWZTUlJpYTFCbWhvOEZtUGZUc24rcERCSFQ4RTNQMFZGWkpROXRwamdN?=
 =?utf-8?B?ZmU1N01xaWxsZkZDNlY3QlFPMEtuUEVTSW41Wng0TFBvRHE1dkFzM0VWVXdN?=
 =?utf-8?B?aEpJd092KzY0NGI3MTVFRytBOXY0STAxOGQ3eFlVckEvcjZNdnlleGthUVpN?=
 =?utf-8?B?TGV2VnFZUTRuMXNBeG8xOGxDZ2taNjFUV0F3b2xPT291ZmdmOU4xQi9HbHdG?=
 =?utf-8?B?bUxZd1VrdHZyT0IxMzE3aGoxU0N2MEZSYTJxdXd2QXQ4azE2T0l4Tm1PV1M3?=
 =?utf-8?B?WFVlTU9NN2ZFT1dOUGliRjgxR2JONHhuSEdKOEJiVWxnY2ZJL0pOaFkvT1Vh?=
 =?utf-8?B?VFJ5N2FTbnFSay9mVkxqelA2NklKV2d2UXVsMVJrdTBUdlFPQ1J5aEJxdkIr?=
 =?utf-8?B?QVZFeTdBN0Q4YzZFM2FXbW5RQVBnNXhRQWN2Z3Z5OWxoMUNTTDhZQkc2dHRO?=
 =?utf-8?B?VGUyMVV1Q0JYbExUOCtkK012ZnMyT0o0T0dLcTdqOGtBeFF2OFJPRnR0ek13?=
 =?utf-8?B?L2lHaEN3NDh0MVFpVHBRUDJQVVd2WUlWRHJYMlFuVU9xZXZPODFNQlRza1hh?=
 =?utf-8?B?UW8wVDErWFFQcTlTeG85dXhFVkdIcXM2NGVtR3VpU2EyVDdzWnZNSDVOdVhD?=
 =?utf-8?B?WGFlVlFVZ0JLaDlza3dkbGtxWnB5bEdTN3p3RjVLL1hncFczRWFvRGVPZVRF?=
 =?utf-8?B?Q0krNWJRM0pSeEkrc203VnJHOGhtRW5zZUh4ZWhybG8rSC83eWN0ZGVZNVVY?=
 =?utf-8?Q?AyeWwxM0BuLxcjwE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd128004-c1bc-4d00-1c59-08de5ecfa862
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 00:45:11.0928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WwmmDfKExmFLsRkg7M+SPMBvA9De7wVzxBJtOjh1uitbNaNyd3aqXaF1ieRs1LypcO9AiFvUaO3/ThYOvJ/FLppusRx0KmeAySKX6D03A3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6288
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
	RCPT_COUNT_TWELVE(0.00)[34];
	TAGGED_FROM(0.00)[bounces-75826-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,vger.kernel.org,lists.linux.dev,kernel.org,intel.com,huawei.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dwillia2-mobl4.notmuch:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim];
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
X-Rspamd-Queue-Id: 7BE5CAA571
X-Rspamd-Action: no action

Koralahalli Channabasappa, Smita wrote:
> Hi Alison,
>=20
> On 1/26/2026 2:33 PM, Alison Schofield wrote:
> > On Mon, Jan 26, 2026 at 01:05:47PM -0800, Koralahalli Channabasappa, Sm=
ita wrote:
> >> Hi Alison,
> >>
> >> On 1/22/2026 10:35 PM, Alison Schofield wrote:
> >>> On Thu, Jan 22, 2026 at 04:55:42AM +0000, Smita Koralahalli wrote:
> >>>> The current probe time ownership check for Soft Reserved memory base=
d
> >>>> solely on CXL window intersection is insufficient. dax_hmem probing =
is not
> >>>> always guaranteed to run after CXL enumeration and region assembly, =
which
> >>>> can lead to incorrect ownership decisions before the CXL stack has
> >>>> finished publishing windows and assembling committed regions.
> >>>>
> >>>> Introduce deferred ownership handling for Soft Reserved ranges that
> >>>> intersect CXL windows at probe time by scheduling deferred work from
> >>>> dax_hmem and waiting for the CXL stack to complete enumeration and r=
egion
> >>>> assembly before deciding ownership.
> >>>>
> >>>> Evaluate ownership of Soft Reserved ranges based on CXL region
> >>>> containment.
> >>>>
> >>>>      - If all Soft Reserved ranges are fully contained within commit=
ted CXL
> >>>>        regions, DROP handling Soft Reserved ranges from dax_hmem and=
 allow
> >>>>        dax_cxl to bind.
> >>>>
> >>>>      - If any Soft Reserved range is not fully claimed by committed =
CXL
> >>>>        region, tear down all CXL regions and REGISTER the Soft Reser=
ved
> >>>>        ranges with dax_hmem instead.
> >>>>
> >>>> While ownership resolution is pending, gate dax_cxl probing to avoid
> >>>> binding prematurely.
> >>>
> >>> This patch is the point in the set where I begin to fail creating DAX
> >>> regions on my non soft-reserved platforms.
> >>>
> >>> Before this patch, at region probe, devm_cxl_add_dax_region(cxlr) suc=
ceeded
> >>> without delay, but now those calls result in EPROBE DEFER.
> >>>
> >>> That deferral is wanted for platforms with Soft Reserveds, but for
> >>> platforms without, those probes will never resume.
> >>>
> >>> IIUC this will impact platforms without SRs, not just my test setup.
> >>> In my testing it's visible during both QEMU and cxl-test region creat=
ion.
> >>>
> >>> Can we abandon this whole deferral scheme if there is nothing in the
> >>> new soft_reserved resource tree?
> >>>
> >>> Or maybe another way to get the dax probes UN-deferred in this case?
> >>
> >> Thanks for pointing this. I didn't think through this.
> >>
> >> I was thinking to make the deferral conditional on HMEM actually obser=
ving a
> >> CXL-overlapping range. Rough flow:
> >>
> >> One assumption I'm relying on here is that dax_hmem and "initial"
> >> hmem_register_device() walk happens before dax_cxl probes. If that
> >> assumption doesn=E2=80=99t hold this approach may not be sufficient.
> >>
> >> 1. Keep dax_cxl_mode default as DEFER as it is now in dax/bus.c
> >> 2. Introduce need_deferral flag initialized to false in dax/bus.c
> >> 3. During the initial dax_hmem walk, in hmem_register_device() if HMEM
> >> observes SR that intersects IORES_DESC_CXL, set a need_deferral flag a=
nd
> >> schedule the deferred work. (case DEFER)
> >> 4. In dax_cxl probe: only return -EPROBE_DEFER when dax_cxl_mode =3D=
=3D DEFER
> >> and need_deferral is set, otherwise proceed with cxl_dax.
> >>
> >> Please call out if you see issues with this approach (especially aroun=
d the
> >> ordering assumption).
> >=20
> >=20
> > A quick thought to share -
> >=20
> > Will the 'need_deferral' flag be cleared when all deferred work is
> > done, so that case 2) below can succeed:
>=20
> My thinking was that we don=E2=80=99t strictly need to clear need_deferra=
l as=20
> long as dax_cxl_mode is the actual gate. need_deferral would only be set=
=20
> when HMEM observes an SR range intersecting IORES_DESC_CXL, and after=20
> the deferred work runs we should always transition dax_cxl_mode from=20
> DEFER to either DROP or REGISTER. At that point dax_cxl won=E2=80=99t ret=
urn=20
> EPROBE_DEFER anymore regardless of the flag value.
>=20
> I also had a follow-up thought: rather than a separate need_deferral=20
> flag, we could make this explicit in the mode enum. For example, keep=20
> DEFER as the default, and when hmem_register_device() first observes a=20
> SR and CXL intersection, transition the mode from DEFER to something=20
> like NEEDS_CHANGE. Then dax_cxl would only return -EPROBE_DEFER in the=20
> NEEDS_CHANGE state, and once the deferred work completes it would move=20
> the mode to DROP or REGISTER.
>=20
> Please correct me if I=E2=80=99m missing a case where dax_cxl_mode could =
remain=20
> DEFER even after setting the flag.

Recall that DAX_CXL_MODE_DEFER is about what to do about arriving
hmem_register_device() events. Until CXL comes up those all get deferred
to the workqueue. When the workqueue runs it flushes both the
hmem_register_device() events from probing the HMAT and
cxl_region_probe() events from initial PCI discovery.

The deferral never needs to be visible to cxl_dax_region_probe() outside
of knowing that the workqueue has had a chance to flush at least once.

If we go with the alloc_dax_region() observation in my other mail it
means that the HPA space will already be claimed and
cxl_dax_region_probe() will fail. If we can get to that point of "all
HMEM registered, and all CXL regions failing to attach their
cxl_dax_region devices" that is a good stopping point. Then can decide
if a follow-on patch is needed to cleanup that state
(cxl_region_teardown_all()) , or if it can just idle that way in that
messy state and wait for userspace to cleanup if it wants.

Might want an error message to point people to report their failing
system configuration to the linux-cxl@ mailing list.=

