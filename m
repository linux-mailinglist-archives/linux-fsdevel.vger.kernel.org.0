Return-Path: <linux-fsdevel+bounces-75813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +G4ADAGEemnx7AEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 22:47:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1BEA9364
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 22:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C21823028ED1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 21:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E609337689;
	Wed, 28 Jan 2026 21:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F1OR/+3B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B37285074;
	Wed, 28 Jan 2026 21:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769636850; cv=fail; b=PYNVOZGPeuKFmg01N60aHyCWlbrLFI6hLczNzp8jwtstnmfCsklYtcdiuMg9iaMD8tX5HDENH86I0NmKPL2ztX/F2ElqcGRMSAKDnZxDeNQjvXM8Bhu0i1idqrPsqwwH4GKzMEptBLE72nIAjEYqDvO+wlY1oIDHOV8v3b7SjkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769636850; c=relaxed/simple;
	bh=KK0TVEzVWHHI4DOEO9XMJAeD/a8o+kPTzO6BNHpBub8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bdGOf60i4wTjIgRyLUxKxuXMJhtdtsOJPHgFAbVox6WmVFE0nteL9rgtLX+xMNmxFEcq8QwbWMbUOXZS50eCMBCR2hLuBNMDiwY9+HFBKeRfncfEaDk0MB0yzFHUOwYgbuh4cvvSYNixUZyuojThvmDOCl5LP+xrQdAsBXbxvUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F1OR/+3B; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769636848; x=1801172848;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KK0TVEzVWHHI4DOEO9XMJAeD/a8o+kPTzO6BNHpBub8=;
  b=F1OR/+3BHf3DuWSCv/m42hM/Vrwe+haLqIZd6eZx4Bu2pi48TID5eoRj
   99ilT1rGFWnJYTPfFRMV3zSCGRmyBYmg7NUZjF1ZH8TWl0i7ko7Rog+Rl
   h2saz8CyqPxsb7T01fByrahrG+tzkdMY4PDfweQ4FvnuM9Tes64QG0lll
   mAcyW+Q05pKncp8DVgXEAohIXpxu7hd4peQExyV/QwQ6vNgAI/0kTxouY
   B/9WbEpvRIut0scgufIC1XHj2M4VXGEMUO5ItT57LV17Wj7Jm7dFBrkwj
   TGGTr5XlQJ0ohY9guXbmjpWd7rnTxxWGNHdFzabUCVMmdbMf7qIf6UZ6J
   g==;
X-CSE-ConnectionGUID: S3BWLqgwTc2uan0sH7/zLQ==
X-CSE-MsgGUID: QdlrZp3fRFSpZBXI793ltg==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="70952801"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="70952801"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 13:47:28 -0800
X-CSE-ConnectionGUID: aaFaSNYfS3SdzqS7be+Mww==
X-CSE-MsgGUID: gtLrV4O/Qni4cOfudmTRoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="207513609"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 13:47:28 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 13:47:26 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 28 Jan 2026 13:47:26 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.30) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 13:47:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6c/M7CAdL9ERyFVWKHZ1oJnpK/Uye6YjcVTdHXrk5tl+b5qEblVDBbnMtOfoPR7mDi+55RrzdueGC3G/fddk3kHazTZbG7Z2OhMhJdT4yej7aMm+OlTBHKzqhSCaChxMA5OuedopoI2dbX/UIAtO65yrB0SY+FTfv1yOuBoj+D3XAQTYeGnkE6MfzNNYwuPXHzqVj8sVnGJZ/yGzzvXKfQKEmlg/JMGUMHLK4g9+DTLZl51nGyFioko6b2PbshYApEfrimzB3rMNGTbMos/nfGkuf4OROdTXys5NXGW1YmOhhKTtYeXt8BjS+wUSfV5sSxsrxWb8CY9kxJ8TcXU0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYi6LB9WHs4tzkk6usmfMkn6hEOeNWe5I27r8zgqHIA=;
 b=VQh0nUBGFvTnMsjf3fMSjNrhZfUnXvnkbCtPyhOCe4GD1lV4hJEl7dz3Kj0XeMaIzRVMXoo5zyFjE3Q9yunvLXfQS6lTPt+DvXciwmGRWtfbt+Gt9JNp2CTfJ3lpsMHczz1xvThLwX9Z9pHk57M9tvJuHNAikFrBkW1XKx2Phy+aPnQdYocSpCe+I5GARHpB8+K+VNrOdnTp0Qw4Ft836SFn1DUupoNINNkwONm/+NDJN6YYvgSm3V23s0teeFMOH1N9MK8OCr+YTQJevr/DCiHX4CFE+PPgii5+2WlSididgolNvF8raX0idqTNOb2lnCdJaUhnZ/sdl6h28HELyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM4PR11MB6216.namprd11.prod.outlook.com (2603:10b6:8:a8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.7; Wed, 28 Jan 2026 21:47:23 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 21:47:23 +0000
Date: Wed, 28 Jan 2026 13:47:16 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
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
Subject: Re: [PATCH v5 6/7] dax/hmem, cxl: Defer and resolve ownership of
 Soft Reserved memory ranges
Message-ID: <aXqD5JUmMJAiQU2C@aschofie-mobl2.lan>
References: <20260122045543.218194-1-Smita.KoralahalliChannabasappa@amd.com>
 <20260122045543.218194-7-Smita.KoralahalliChannabasappa@amd.com>
 <aXgXA2OYOUfyGlQF@aschofie-mobl2.lan>
 <5a150b32-2396-4870-8467-fc3fa9f8d0e7@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5a150b32-2396-4870-8467-fc3fa9f8d0e7@amd.com>
X-ClientProxiedBy: SJ0PR13CA0231.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::26) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM4PR11MB6216:EE_
X-MS-Office365-Filtering-Correlation-Id: 27ea21c6-7827-40b9-aee0-08de5eb6d1c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qkpXGHnwbEtjGMTZdjc139P6tzxt3qLo49wM7LtjFp+ZW+jnPv6YzlOVPYK2?=
 =?us-ascii?Q?wLy8yjMiSzn6PhFF+Ak9HGtLPYzu/T1s/3gj6oFriP92mXikibZ3RAUeXJbN?=
 =?us-ascii?Q?GmbBa7jMtfNb/HOSVNIbDwg63M23Yk7wf95/So1RAazfhJhAbkGuqPueaRNM?=
 =?us-ascii?Q?MwqdaYaGMBO2k8ZEVagXsB3f2Ge3kZZW60El2gsQjRAlY2tQsVobO1TfW7to?=
 =?us-ascii?Q?Bfq26u4oQ2M2zjR0XUDGW1bsrQkiUy1pW7H4NESmqGXFOiBgGCs6tTPUGtFm?=
 =?us-ascii?Q?cOKklQ8pq5T35o9zzWh17ADnRSTnlFHSSAqAziGOHchL2uSIjZ06YZjkU3Lm?=
 =?us-ascii?Q?KHuXIAMA4K89scR138iHpDlzlSm7OQT1mKrlSV3iAfSPNv2y6mjWooRao57i?=
 =?us-ascii?Q?1Qecbjsl+HoIj4tYroXta8C7wx2ElcEGRxY2hQQzKPGgrz21W7Iyajv1Nhp/?=
 =?us-ascii?Q?PXHAD69oa4OIwCBQcT8i3rLHwlJmhkPIZ2TlHVJqGsNTaCWdL2Wg+464TRQt?=
 =?us-ascii?Q?eW4hii78icmQl/waCcQEJT0dwZH4qRhYUhLoRRGIiKhHh9VqqqU7TT+bE830?=
 =?us-ascii?Q?28bLPNcP+sZ2HxYhUQ0ODHeYqOrwuYSuyEoB6CuO+ftJ6XZ+G8vxkuBcpCig?=
 =?us-ascii?Q?RDeWcGFOLqsu6Hj8kOpBvT+qCoxxCHT1x9wstKg0K5ggnaCPcS8Xl+kDRj54?=
 =?us-ascii?Q?23LRoaca3JXQvXexkP4OhJ1FTLN+UhGt4q1JTxnqNVbcqyIHzcfH0ttr9/oB?=
 =?us-ascii?Q?N1mH64z7tq0f5u2/gqX/eCpkhZtP/EeUVvQvrMQOf0+tEOchxYNvJhS71OOi?=
 =?us-ascii?Q?DdJbOb0ec13XvmVBjGTx6WPn1b1X5ubXSX0/Vg2EziGIZz0/mv2YAdeHZZjS?=
 =?us-ascii?Q?iw4HkPniFqqWvvblNUxo/qosVJSQA00xAvd16cpJ2qd2JX5InlG4QOZyDpuh?=
 =?us-ascii?Q?iEpT14bu2TCUbNGXBlxRRJs4ssoG6Duczi2qTCG3So6j8bCbaItQ8ugvN7IZ?=
 =?us-ascii?Q?ffp9LHUjKiCBL5lbsqEj77R0MzMf6jL6KbvK2YZoCtZo77k9X5v+qFV50iLn?=
 =?us-ascii?Q?T/s4eZIKR5Z7R2Yf1uB7j11ilaeJDu2CwqFwK1pkMvGM5yNcsAf8UQ0O+iqC?=
 =?us-ascii?Q?p/+fYAlWOTaYO/KcznXwUg423rzR3YY1myfuogogCPvdfGW9LWMMlPLfsGGe?=
 =?us-ascii?Q?0XqfYWGRxyAymy5WPBWMerE/KuSv1ECRvlceFBAPR+KpnWgoDZT3H8GBoBkz?=
 =?us-ascii?Q?B+cwdIiieXWcvtLdmA0r2Jpjz4Tzt/ifL8DJNwAQVdvWgjJ73GnuKD/7Qcl/?=
 =?us-ascii?Q?fhCTP7eMjIfpHCoU1+9CE1xWKc124raR3LBQAuPjAIzOB2h1bLY66Ctd1hCQ?=
 =?us-ascii?Q?mQrHeiuS/PJ+821lgt49qhj9tzNpMgo/Xi32leYcRRRdVrXv9flHku6M/hkP?=
 =?us-ascii?Q?rMKomiFXxY+vcZ5G+wI+pG7weSAIkUZNBdIJVa7rns1TzNAe84AAGM7vBw3G?=
 =?us-ascii?Q?EX9xz3niWGIKZv1ZfTRXVVEyUR3PWLfUEROKv9w+lPyNcwpe70PTY/Mfk1HQ?=
 =?us-ascii?Q?IS4UOD/81JSxoe00j80=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YKgrzEaiF4P7Kawu3OIT3QdorNZLbyA29x5/wULFuZZMnz3mDxXPzGFbQpWD?=
 =?us-ascii?Q?XSM7wniROplSt2CUAun6tFyL0AjYEYlnbqbzFJqRNyKRaKT+1H6gKKCmydG5?=
 =?us-ascii?Q?4fupKtpEdmTvFDhHTRAgTZVy8kqfeWMXhnFQLvolVllNmsEJvcSeIz8+zYDr?=
 =?us-ascii?Q?C7v1cYPcY61e6VkuI6ahd7hEJS76NVHlM8UKmFUHDmFMhlQ6wFcO3kVHKs8f?=
 =?us-ascii?Q?nWQFCieUoXwurhgIZLxeUqLr+5El/1vMovRICdz96ZY1hHsBUsLkKKmtVLzP?=
 =?us-ascii?Q?j3gBu+H3E4JUpTAX/5WbmeOEN2O/LrZMHxAyoYQwMZTuNZATeA8O37NPhNMh?=
 =?us-ascii?Q?N7ATLJPaL1qYhiL+aThTkNtbGMmaxRaQL295sEaUk8+ekw5gmNG3g5hqHn0z?=
 =?us-ascii?Q?dZwfXxt48r/AbFwOGKV0PPQXqIyiRnCGxJFZvnxPmQbXMSBktpA83cD8Xt2I?=
 =?us-ascii?Q?AlCniYs5wVzdJnywCxF27vzcPy279auMQwKF0D4UInNaY74h86omRQ5XbxCv?=
 =?us-ascii?Q?phWV4GKO7bGiC4f+yWa41dScILjbafc74LwlR3LrXGelbFp0eFhmC8pizjmJ?=
 =?us-ascii?Q?oJK720r9Y7uPAJTiEla7OgYH5t1enINA6mR3awIj6D2jt9ODnjzO+wzOhceI?=
 =?us-ascii?Q?NMo90Xy+lKInHm5yWpk1bjQe+DsLJsEwuotPErw8SuKUNV3mGtbjP/6/QVIG?=
 =?us-ascii?Q?nGo+8aalFvVtESIALH6TcdjtyaAcFjF48khuZoNBCIaoS3JJDelOYVCsmzd2?=
 =?us-ascii?Q?+lu8wTko+n3lPDasIXqc0jFXMWVJit5htWl4WUXhEzF7YyHErNplCMCBVIhg?=
 =?us-ascii?Q?9eRdXh6K0W4fF399OPWivVEdQUO6yU608RwqUKqzjkb4624JcYwQuRuFcETv?=
 =?us-ascii?Q?3kfxDK3ALHHZ06nLQTYQ4XYy022remC5h7O9LjkbUfqwb3kHj96ctQIFGMbE?=
 =?us-ascii?Q?vORt6AMMyIRZS2QNQMq0Mpf7e9h/rCfKpwY4XX6a4ye16HoW8XQDewCMCP9S?=
 =?us-ascii?Q?RvqUCiDKByCVDwdsgTP5aUQZDBUAVV2uvgPUlaJnj5KC1kdMO4zrXjYz9nZV?=
 =?us-ascii?Q?X8wFqTRjypdWsuyq7jSxvJZfth/9Pqinb7RkkUIh0tHuNjnORVdDBx81lL2a?=
 =?us-ascii?Q?rkJYn1qsGo6SuV3tdQ1c9rjSJPZDiht//eq18Mahs+Ca0wf3l9nMuy1EdbOD?=
 =?us-ascii?Q?oMmTZlSMIglUwZlRCbXM+d3nvpNW7LxRW0kQsiUxvDpNBK7mcydtCg1UVYxI?=
 =?us-ascii?Q?i2UJjIt3Q2w3WABXRGYbi9UqZj6+urtsaFVlpwhde1Qy9LIE3djmuokusE4L?=
 =?us-ascii?Q?Pv1aGMNxBglSPZbUXder8b2/rl10/79wuVqRhqSs6PFLepEP57478A65zV/y?=
 =?us-ascii?Q?5sQG2fCnMlfacU6iDyMcOr9QirPQeptp6yyZkXNq/wuZJG00x3ETAwtAKB+c?=
 =?us-ascii?Q?km/k5xqC35tJRMI6JMQculvQYwOQU8VjHoC4RqydwrpJ+kn8irkivAYhAKmE?=
 =?us-ascii?Q?jIBpZNywVjKo52mvXC+fs1DGpzWrOW4jOy8vkdiw7dTHEEoV83ktA2nNwv30?=
 =?us-ascii?Q?/AuQjL3tcnlg7pqMkIZ3XvnksO8ZvQOS8jhQ+P17lyWDmoFiuD1Fv2whQ0ld?=
 =?us-ascii?Q?z1qvWx2AVkm7yr5BNi50INLtTFWkeHyYC9wzyRywfv+McfJUjQzqQpeuDBp7?=
 =?us-ascii?Q?9u5yTWMTjGkYFAQt+RvND4EKGCxXqL0Ha0v39tP05w/F5Ggmj89a7lRevg4g?=
 =?us-ascii?Q?d57LKGv2UMIDzmBeQ07V/id6WONaPFg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ea21c6-7827-40b9-aee0-08de5eb6d1c0
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 21:47:23.0553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gN427KhJM2Tj8oDDRjZioyvyRqXoo0ahgi8mCBdG3UxJb5RyTpPvfOaplLu8fszM52eB+ypTAeKIabS19vamD3DwdKSqxk4n9/3hVY+wWTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6216
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
	RCPT_COUNT_TWELVE(0.00)[33];
	TAGGED_FROM(0.00)[bounces-75813-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,vger.kernel.org,lists.linux.dev,kernel.org,intel.com,huawei.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,aschofie-mobl2.lan:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alison.schofield@intel.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 9E1BEA9364
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 01:14:52PM -0800, Koralahalli Channabasappa, Smita wrote:
> On 1/26/2026 5:38 PM, Alison Schofield wrote:
> 
> [snip]
> ..
> 
> > > +static void process_defer_work(struct work_struct *_work)
> > > +{
> > > +	struct dax_defer_work *work = container_of(_work, typeof(*work), work);
> > > +	struct platform_device *pdev = work->pdev;
> > > +	int rc;
> > > +
> > > +	/* relies on cxl_acpi and cxl_pci having had a chance to load */
> > > +	wait_for_device_probe();
> > > +
> > > +	rc = walk_hmem_resources(&pdev->dev, cxl_contains_soft_reserve);
> > > +
> > > +	if (!rc) {
> > > +		dax_cxl_mode = DAX_CXL_MODE_DROP;
> > > +		rc = bus_rescan_devices(&cxl_bus_type);
> > > +		if (rc)
> > > +			dev_warn(&pdev->dev, "CXL bus rescan failed: %d\n", rc);
> > > +	} else {
> > > +		dax_cxl_mode = DAX_CXL_MODE_REGISTER;
> > > +		cxl_region_teardown_all();
> > 
> > The region teardown appears as a one-shot sweep of existing regions
> > without considering regions not yet assembled. After this point will
> > a newly arriving region, be racing with HMEM again to create a DAX
> > region?
> 
> My understanding is that with the probe ordering patches and
> wait_for_device_probe(), CXL region discovery and assembly should have
> completed before this point.

OK - my confusion. Thanks for explaining.
-- Alison


> 
> Thanks
> Smita
> > 
> > 
> > > +	}
> > > +
> > > +	walk_hmem_resources(&pdev->dev, hmem_register_device);
> > > +}
> > > +
> > > +static void kill_defer_work(void *_work)
> > > +{
> > > +	struct dax_defer_work *work = container_of(_work, typeof(*work), work);
> > > +
> > > +	cancel_work_sync(&work->work);
> > > +	kfree(work);
> > > +}
> > > +
> > >   static int dax_hmem_platform_probe(struct platform_device *pdev)
> > >   {
> > > +	struct dax_defer_work *work = kzalloc(sizeof(*work), GFP_KERNEL);
> > > +	int rc;
> > > +
> > > +	if (!work)
> > > +		return -ENOMEM;
> > > +
> > > +	work->pdev = pdev;
> > > +	INIT_WORK(&work->work, process_defer_work);
> > > +
> > > +	rc = devm_add_action_or_reset(&pdev->dev, kill_defer_work, work);
> > > +	if (rc)
> > > +		return rc;
> > > +
> > > +	platform_set_drvdata(pdev, work);
> > > +
> > >   	return walk_hmem_resources(&pdev->dev, hmem_register_device);
> > >   }
> > > @@ -174,3 +250,4 @@ MODULE_ALIAS("platform:hmem_platform*");
> > >   MODULE_DESCRIPTION("HMEM DAX: direct access to 'specific purpose' memory");
> > >   MODULE_LICENSE("GPL v2");
> > >   MODULE_AUTHOR("Intel Corporation");
> > > +MODULE_IMPORT_NS("CXL");
> > > -- 
> > > 2.17.1
> > > 
> 

