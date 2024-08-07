Return-Path: <linux-fsdevel+bounces-25230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE94F94A12E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 08:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74C3B28C2CC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 06:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED98F19412A;
	Wed,  7 Aug 2024 06:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C8pAVfKv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F07D50276;
	Wed,  7 Aug 2024 06:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723013729; cv=fail; b=IjijtpwavrsIIPzPk+mUyb7O6tjtO7Mr264dNUNUR1ROUmKnSefu0Pv58PXrkouxX12a+/0bV0bk7OArWKr7PzUqDUiA44Ebz/JLc/IIDVAKH9I+nv9gsPHJeJh52XnrU/WAiV6BQkh/fdbI1RsSM+QNP5nNOkxz3k4TFBKDpfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723013729; c=relaxed/simple;
	bh=sUQnm2k+YTwo/5qDNILRMpbRohZUgsJ4rhehjMKAV4U=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=sBMUFNqcbQs2JOvuhoTkxAYm7twgmj7M1/2bQqxa72s53klfMKPZLMxQzBAVuNtttjVMxg/3tdmtsvyPS6tkvFK+8HRiacf5Fzzas3qGuyDMFdWF0prnDIEm9h65fCuWdvFbDGuLZBlP4itnJE9Y4PqukJIR6QjKHje5qnenArA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C8pAVfKv; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723013727; x=1754549727;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sUQnm2k+YTwo/5qDNILRMpbRohZUgsJ4rhehjMKAV4U=;
  b=C8pAVfKv0PRGoZTWrqnNgJ+I0+ptnY8wClsY1T3np/AsaxQ4SkW1WE7m
   WWNC1PzBbt3tNjGQKPkCw+AmM3DAzQAg/2mSx9E4d8CgNZ9/wsjUOhgHL
   FP23m7DkP99Zk0s2L6mT+a4SrCpWmwgXUX5ScHmhbWDnfq5vEiwylQCuY
   48vU8WnWED0LR4HKw6KAElfUNrTfN93yiWD9uE4qHXlVq0zXomq7b+wCI
   DqDJYCnLuiAFVTiBqRbQpyDkZaHRaVHQm60/RcvMFDiNxd8Mm3E9ErMaf
   Mw8psrlPzljrKP8c1UrHr70wwo0YprbSVv71L9gcGukGdt+DyFrncm3X+
   w==;
X-CSE-ConnectionGUID: P9gCf+OATRi78iY9jQRENw==
X-CSE-MsgGUID: I//zV0QFS6qeHYM0SypiKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="21188080"
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="21188080"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 23:55:27 -0700
X-CSE-ConnectionGUID: woH333U6TfuFyvjWDf81Xg==
X-CSE-MsgGUID: 52xAxpBRSqKo4dNfFOJk1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="57296339"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Aug 2024 23:55:26 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 23:55:26 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 23:55:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 6 Aug 2024 23:55:25 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 Aug 2024 23:55:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JP7CTN8lflyWdQpmhfdp02vfID3f4hhcZI95Z3N7UUcGD0nEip3+xA4mqg1FOUMcXypy6U4P9wno+g47EQ0XB6iUY1Tu3+nSXQKj5wu9HdsCMqh1TkUkSBnVak7dVf8wQiQCCJS6zDXq67HmBOjV3jbctwLSNTUaTrc0N7DsA20k3RqvPaYxOKicn8DS1OgVaULD3ALH2/3+tBg9pcDNDTZKbvdZ+8OF3TRAWtfSJjtBZONK5oO4Tdi9a8UieHUbW7gmYxsthnoxPFvBZki0VduKVEQVkqXWD0TLQsLjOIRPl+ZDv/wbckc9QDzCgvAzt2DkWohotbq05LducgjRKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aD2tSCCD8+cqTdzrMIYhaeuYjXPeqP3lJ7rOU9g8KSg=;
 b=pdjTrE9+o1VByLJtEnxJHTSBUauUWq8nPH0FAYqYf4YOeOQ4by/julujFSb03M9RSpXxpZ3vV43mqtPb4uJ0T1bOsXpejjjqv9wsWHb4i/uNVPFwpmtmr0RH8H2k+Hio157W7OFINV1p8HYuCxosElkb87Q4S7z+y7U5h0/zak+FH+JItkc4T4G1lu6isT5EwlnJO6JJbI3HQsrApAE2rEi1Tve7e7KeiQbPCZm2Y6QljMPv6m7oBeg3Aa4E/q16zYZsF3i86aujsG3Gc/JkaA6CXKUElRuQwa6Sy9uZyskKuSfE9FNab+PX3YXlh9V1mEG2OhCuZUaiCEkzoFLdIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB6473.namprd11.prod.outlook.com (2603:10b6:510:1f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Wed, 7 Aug
 2024 06:55:23 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 06:55:15 +0000
Date: Wed, 7 Aug 2024 14:55:06 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Jeff Layton <jlayton@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [jlayton:openfast2] [fs]  49d6daad7b:
 Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]SMP_KASAN
Message-ID: <202408071453.34eaa8d4-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:196::20) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: e6dbbd62-e7c9-4342-7054-08dcb6ade444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jf17JntYGlV7ydizTqSYujHn+5IjK6J2T4J4kQqwqts9Vnr3SG/vOIKvBfq3?=
 =?us-ascii?Q?VQzVn2nC9sPjCx7ZB2Fuz1GWpoqkhfIGM7lfbul2KVvCRHthx5svewUPIYf3?=
 =?us-ascii?Q?XfC/9MzuAw1wPIPAHJi5k5Plwiby+/lYGMPgkO4SxVDjela6u0VeF1wGiaRs?=
 =?us-ascii?Q?IjYP9GwWlkKJ2OdzUzoypFg/AyXC0aD5VqVgUKiPaiNn2vwF1/iRnNQY9yLo?=
 =?us-ascii?Q?z3vh7rivtRf5ZUH0HgdeoC9gqD6gxxeSnKsd3xtLN5f3vNbuEEgdBqyjGv9k?=
 =?us-ascii?Q?EO7XCuz9Yl/rGqX7NbWw/Q5x+3pOL5cqSLJP/DfdRUl6S16CKsZiKEb8zk1n?=
 =?us-ascii?Q?2i3rpDuo9xs4TktlG4/3khKC/lJpUBHzFWKF/4Be0SaV/NmLlL28GH1PG+nV?=
 =?us-ascii?Q?+BSBYjcMZ9av70nsq969NDxJUZBxC9rwcYKDDdyADMi+5l85TWjPMXthvNuW?=
 =?us-ascii?Q?qBy/GWNG82m2YNQcJLn5/xTy/jEUDktkPQwShfrAp0EgcyD9D9kCX3shFKUV?=
 =?us-ascii?Q?M9T6PvlG7HW0h8bQp9eBcRJkXaGxkc3AtnrPG4z+fFZeeo79/mfi00HaKi5m?=
 =?us-ascii?Q?u21EBLa9dnVvo1nIc8n2BdGF+wrlcy5KKX5Gj5yY2vzd4yP8qVXuPuFeFvPZ?=
 =?us-ascii?Q?Eph1gDEKk935BK3G04zmA8uyi44ZdCacyv1mkGWja7RReMR2qR9eQ6+pl2wE?=
 =?us-ascii?Q?oTbycLrbxfNkYIfdffuGlYTkOj0bL1p7ygn7uQDDv3e4jRFaDei67ACSwIoK?=
 =?us-ascii?Q?gjsG3FSWt0iWqCcbGykTfP5yiVoxYslNTkcO8A0WdkejmSuCbmuIOfBErNsp?=
 =?us-ascii?Q?bKANPJR+JRqeOXvINpaGZmo5ij4W/YWZgF5LXpjrrSIvpqV42kLhhbQffzWJ?=
 =?us-ascii?Q?4ig6tYkaDWWOV92zT3KeSkF0cRGuavcnAKXUXwDxkBe4wbFYhP9Mt24RcWrF?=
 =?us-ascii?Q?wzHSAMlythJdnfFDcX+BoaE0QhYGFHb9asPvzgc3bNHD57kawNu8sQAVYFMI?=
 =?us-ascii?Q?krIzxwNKXUWYV/WyPO8m41tqrMqkhKNf+j0SgX0YS6khmhv9WT84ZVk2wYGt?=
 =?us-ascii?Q?IdtxgzJ6mxETXpSEu4Mb/mk6xhVvhAbL4ujrGBHm4ZV0MkwFjGCE6C/FZMqN?=
 =?us-ascii?Q?fz1Uq7L6wo32vxOSSdFxRzuWcN+QLPRGgqNXWG2D13TEep9zpB3jhou+cJZG?=
 =?us-ascii?Q?AotHhQzaKZLaESwpmcIX0f0o3qPZjakEy/ExR/PKjAXQZm5HZhT2ZZKM76Sa?=
 =?us-ascii?Q?MxGyJpehqr7hUGRV6dOr3VCZypjR1iSTJ1ScEUHKZPE6KbVkSlNGKQITRnz6?=
 =?us-ascii?Q?4k5UXkPaO0DxQs0e3QgMU3tL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mZPJrXoeU9qCyFsGP5/i9A5XrwZtWZSBnVd2BrNkNuivlFWV8Xs+TkzloecR?=
 =?us-ascii?Q?w2ZAB/pho9SQLAEYhmHJ0o5PjfeNVDp/oLyj4J5xkglWbfMIyi1Shdpmab5G?=
 =?us-ascii?Q?s65eW9jcJQFhPeSb8VK89CEF3h3RadmH8mOXpV8ZDsQwBfTxv4MEVZN8yn8L?=
 =?us-ascii?Q?j3qH8fOS+qw0M+G+Zsh+Zfojn7MoX/iLoqr8nGvUrQeahGxtKcVmbFr6Io02?=
 =?us-ascii?Q?eGROwMubt/oLfbrOH4+ayEyMS/+F+vX/NzH0qIlTNCQ/zbGdBOEtPjsqNJCK?=
 =?us-ascii?Q?o3kpsCw96JrvsTZfQ0uwewjf7HotUuKMQ+nVamkswlbfVa3j6YkyR4Jy16Jl?=
 =?us-ascii?Q?aokk+a3V3TypWWgMhCHamEvE4BJSTNEtM9UZs0Yh9LmIuvU36OIsdoTTXld/?=
 =?us-ascii?Q?pUygcmWcfkjmJeQabuYsG41Eq6vbGt80D9KZDeAFYplMWo0YYqnX37/CDAho?=
 =?us-ascii?Q?+UcENV3wRdYhKrZFe/RpPMTCBO0C4EUysSV1tDazfuAZnlHogkijLUoHiZYu?=
 =?us-ascii?Q?6J296NXedYISWdJ4+YssIyPZwJO4eU9iDDjRbCt+cSJ3LEIopx74Mkd6csFX?=
 =?us-ascii?Q?KKy5fvilkdlzzR5dTbEzCLufqskGdS9H70LovO2BGDlMFM3lUxrvy5vR6hlX?=
 =?us-ascii?Q?/yrH/RqZwpe/GzvbnZjivImMTXH1o8S7gKj0XNPgE+2h0sdJRT9a3HmKpubx?=
 =?us-ascii?Q?xDxrzYgZEtscPWXMrsYuVwuLZwBqOOeNQh6iV+pfPOr8hblN4gYm2Kw3glQf?=
 =?us-ascii?Q?oTP7QGfa7j1wYMJ7VD2Z2WI4WpLmQQPsre/Z7UnlCV7MsvmjW+zs6u8nOYsx?=
 =?us-ascii?Q?zkRQKgX0xYFBiGGcqIgduIUdYklUQv3LwJaN9Z+Q8fNsoMJ0xqoCeIXgHVh6?=
 =?us-ascii?Q?acZkBoZDqznxicarTFKyKzJDcwcRtcH3fgesUpEeCwQWbFWoTt1gZa2hFo6J?=
 =?us-ascii?Q?Oizcz9sUibF/E+ZNhpWuptdjbCaXpfvOzIly/z4bqOo8yl522SeOUyCp05w0?=
 =?us-ascii?Q?XVzR6Bzxe2N8nJK6lQGQSdjuLn4qSTQFgkib3bL0Ql4O632aOvv4VmCVDXW9?=
 =?us-ascii?Q?fVcOkkWReogPWFmMqNNmSVv9RB9ZLjpYH3lONiHFvmazhvVm9hjkqICp5Xmv?=
 =?us-ascii?Q?SEPTKVTH62MbDxmsQvvJQxnNlvK7eDEidQmBKDOzu95lRFx+P4dMGysmQUhr?=
 =?us-ascii?Q?ctDkRXB4GSI1yVA1IppFVwQrR5Vyh3ifnY1JOVxvS+XGCSW1Ed4jkMpg2rOh?=
 =?us-ascii?Q?TOraeirJxIKHoh+ZK4etom6CsPdhAEzJjzt5rZnIQolurmLGh5xmhuYnI8Qz?=
 =?us-ascii?Q?Y6xAuZ0LvMm2mN6K25reeai/Y5bpb6DhlIwM1gsAe1yXBPlowbOn4kg2ZEIP?=
 =?us-ascii?Q?ybQQgANFFtVB88/wDfhELs2aMMqttJQBRsz7UCTRnhnd2spvRVugwL8AuuDt?=
 =?us-ascii?Q?59E6zvzTlTeX15Zg6X4Gft22NFImuYlaQyPcAaHadKF0luRexxXE7Vy9BKlz?=
 =?us-ascii?Q?uW7DXCa9S9gdY2izoCoKLe7uGUzd6GvH0ac83JRXywztajdKfUF913eb8s9I?=
 =?us-ascii?Q?np2dF8dipUWfzF535DOXDUBiMDEBWpLEbK4KGb6gnc81hIvw16JyfLCa9S/o?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e6dbbd62-e7c9-4342-7054-08dcb6ade444
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 06:55:15.8419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OXp7mf5Dz7VsE+porjG2KPbdA+5BXxM/qqZcuf/fBT8iW/4eDju4k2rpRrXEwWIoVe7+MjzUnaaBOrDthQ6CCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6473
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]SMP_KASAN" on:

commit: 49d6daad7bed7e0c3f9a35580ffcc555f60ef54d ("fs: try an opportunistic lookup for O_CREAT opens too")
https://git.kernel.org/cgit/linux/kernel/git/jlayton/linux.git openfast2

in testcase: trinity
version: trinity-x86_64-bba80411-1_20240603
with following parameters:

	runtime: 300s
	group: group-01
	nr_groups: 5



compiler: clang-18
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+----------------------------------------------------------------------------------+------------+------------+
|                                                                                  | a8bf2854fe | 49d6daad7b |
+----------------------------------------------------------------------------------+------------+------------+
| Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]SMP_KASAN | 0          | 6          |
| KASAN:null-ptr-deref_in_range[#-#]                                               | 0          | 6          |
| RIP:mnt_want_write                                                               | 0          | 6          |
| Kernel_panic-not_syncing:Fatal_exception                                         | 0          | 6          |
+----------------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202408071453.34eaa8d4-lkp@intel.com


[  271.435943][  T250]
[  271.446722][  T250] [main] Marking 64-bit syscall kexec_file_load (320) as to be enabled.
[  271.446851][  T250]
[  271.458101][  T250] [main] Marking syscall kexec_load (64bit:246 32bit:283) as to be enabled.
[  271.458152][  T250]
[  271.614963][ T4341] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] SMP KASAN
[  271.617056][ T4341] KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
[  271.618650][ T4341] CPU: 0 UID: 65534 PID: 4341 Comm: trinity-c4 Tainted: G                T  6.11.0-rc1-00045-g49d6daad7bed #1
[  271.620705][ T4341] Tainted: [T]=RANDSTRUCT
[  271.621573][ T4341] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 271.623342][ T4341] RIP: 0010:mnt_want_write (kbuild/src/consumer/fs/namespace.c:515) 
[ 271.624475][ T4341] Code: 00 00 00 00 00 55 41 57 41 56 41 54 53 49 89 fe 49 bf 00 00 00 00 00 fc ff df e8 66 32 c2 ff 49 8d 5e 08 49 89 dc 49 c1 ec 03 <43> 80 3c 3c 00 74 08 48 89 df e8 9c 6d f3 ff 49 8b 7e 08 e8 53 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 00                	add    %al,(%rax)
   4:	00 55 41             	add    %dl,0x41(%rbp)
   7:	57                   	push   %rdi
   8:	41 56                	push   %r14
   a:	41 54                	push   %r12
   c:	53                   	push   %rbx
   d:	49 89 fe             	mov    %rdi,%r14
  10:	49 bf 00 00 00 00 00 	movabs $0xdffffc0000000000,%r15
  17:	fc ff df 
  1a:	e8 66 32 c2 ff       	call   0xffffffffffc23285
  1f:	49 8d 5e 08          	lea    0x8(%r14),%rbx
  23:	49 89 dc             	mov    %rbx,%r12
  26:	49 c1 ec 03          	shr    $0x3,%r12
  2a:*	43 80 3c 3c 00       	cmpb   $0x0,(%r12,%r15,1)		<-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 9c 6d f3 ff       	call   0xfffffffffff36dd5
  39:	49 8b 7e 08          	mov    0x8(%r14),%rdi
  3d:	e8                   	.byte 0xe8
  3e:	53                   	push   %rbx
	...

Code starting with the faulting instruction
===========================================
   0:	43 80 3c 3c 00       	cmpb   $0x0,(%r12,%r15,1)
   5:	74 08                	je     0xf
   7:	48 89 df             	mov    %rbx,%rdi
   a:	e8 9c 6d f3 ff       	call   0xfffffffffff36dab
   f:	49 8b 7e 08          	mov    0x8(%r14),%rdi
  13:	e8                   	.byte 0xe8
  14:	53                   	push   %rbx
	...
[  271.627744][ T4341] RSP: 0018:ffff88818b55f9c8 EFLAGS: 00010202
[  271.628844][ T4341] RAX: ffffffff81af73da RBX: 0000000000000008 RCX: ffff888188f3aac0
[  271.630255][ T4341] RDX: 0000000000000000 RSI: 0000000000000241 RDI: 0000000000000000
[  271.631685][ T4341] RBP: 0000000000000040 R08: ffffffff873f1b2f R09: 1ffffffff0e7e365
[  271.633084][ T4341] R10: dffffc0000000000 R11: fffffbfff0e7e366 R12: 0000000000000001
[  271.634486][ T4341] R13: ffff88818b55fc88 R14: 0000000000000000 R15: dffffc0000000000
[  271.635879][ T4341] FS:  00007f7d61daf740(0000) GS:ffff8883aec00000(0000) knlGS:0000000000000000
[  271.641827][ T4341] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  271.642991][ T4341] CR2: 0000000000000018 CR3: 000000011e761000 CR4: 00000000000406f0
[  271.644372][ T4341] DR0: 00007f7d5feaf000 DR1: 00007f7d5feb4000 DR2: 0000000000000000
[  271.645710][ T4341] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 000000000037060a
[  271.647057][ T4341] Call Trace:
[  271.647782][ T4341]  <TASK>
[ 271.648446][ T4341] ? __die_body (kbuild/src/consumer/arch/x86/kernel/dumpstack.c:421) 
[ 271.649315][ T4341] ? die_addr (kbuild/src/consumer/arch/x86/kernel/dumpstack.c:460) 
[ 271.650111][ T4341] ? exc_general_protection (kbuild/src/consumer/arch/x86/kernel/traps.c:702) 
[ 271.651155][ T4341] ? make_vfsuid (kbuild/src/consumer/fs/mnt_idmapping.c:?) 


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240807/202408071453.34eaa8d4-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


