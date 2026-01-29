Return-Path: <linux-fsdevel+bounces-75912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFgKLu7Ye2l3IwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 23:02:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AB0B52BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 23:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 316DF302D0B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 22:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B470436921A;
	Thu, 29 Jan 2026 22:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="goDWFVDM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9735036921F;
	Thu, 29 Jan 2026 22:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769724099; cv=fail; b=gPib6kygT4o83XVuWIta4EP04vjmwNs5CkZsv36hL3C0A6glrANEeTm1Ys5BWvI4U2uG05M+k7dT6FUFC8hmA9OFfaQJbthK+5xVVnjzVcOXwqZ0YKuT20zQxcUdveTEOiTKktJnYPfJZsMP3v8idPqvdsmudemH8gxZyz5WZhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769724099; c=relaxed/simple;
	bh=d32GNA4luqnoEH8wCmBSCd4fd9U8Oh2vRtX3lDTEqRM=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=jGzYWrN98qVzEzw58SVNx/LrZ2TYwFd4T0j1dZRKaXo1gbvdaXyGHdusc88sWhF8pjp+c0gB0UaPIy65DXm3eyRo/7zs/ndm7hZV+/I2tN8vC/ghvQltFx3rPEJZGfTwjiyPDa0I9DcM4c/FLMpUKWwJIr4XWHVN3mTLCjtMAps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=goDWFVDM; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769724098; x=1801260098;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=d32GNA4luqnoEH8wCmBSCd4fd9U8Oh2vRtX3lDTEqRM=;
  b=goDWFVDM/OfOl05seClUI7TUbY2MZ6xQGzY6k9qJ0FmxzFIfHtV2aaYS
   7/YFwVNX4isGOH/YwzS9TJyKUl4NzJ8IXrg2SBQPzLV5oeDiqAkd6yIoJ
   zbypcPMkCKpEJQlFw7exuNz0biIF2Qe0gkz5Ybkvl0DNqQkKcPcZ3qdZ7
   FvGS9I5B/JGN8yBKCjP23XwPaoptLJi03z8D6OaayYQ834f9bNzIjnxKP
   gP+OIIUrn14igFG8z5IvP5m4JVEeTuOY0wB+oD3Qq/vLyf43hQET1v0rR
   zuAiH+PbMYrdCqIs2zAM2t8H6VE7oOusFZ6TcnzFt71jjhdbp2w2hPhn1
   w==;
X-CSE-ConnectionGUID: VrPrsUu8RLyBqVP5bF5Qwg==
X-CSE-MsgGUID: XJeNtZ5SSCethFe/VYcKmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="82345437"
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="82345437"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 14:01:37 -0800
X-CSE-ConnectionGUID: j6Ax+6pmQ7GKLc6jIMJsFA==
X-CSE-MsgGUID: bbDpjKCtQZyVYSiytm0nkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="207938497"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 14:01:36 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 14:01:35 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 29 Jan 2026 14:01:35 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.69)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 14:01:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t3asIFSOzBJnFtGnfJ6ZNDQ7mrWeyly5Y8P4Cx3Xdy00rS/rNs95FBzt2S1avyBbBYyAbnv63seyNY8M5tj6GxnP7NHJPxFeU3U0bS39m+g41qRNPpKBQM1wRWkmUS2nH6jE6xHq6khwgjG9Qyv1YO8peePrycVvkex1yyIm7MimKwKzhlICcDzOdpcOUt2I2qFysk2sEx7S8qOCqSPKfP36q1T6k09dULRjO9CDZt+Qisk7CQRL3sbhEo04nbEwy2iJT35ifgaxJYbzJYtVZhFgcNYR9rhJjMR7hDbDORYrmXobG/mcLWEuTaya6nuCj0kIy6FNKJZCKKfcGjsgJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xy0FmoQidCe5JsOebOu1HH1BwVmBUatOmYaMn8Rd/OI=;
 b=gtGpg6DVAl+jGs0aJNko5c/f4auq1lbOm3K1svhfoBEn60F92QRR4KNx7AbiTCJV6ftBnc2eI4JpKibcNQGsNg7PecUXJj0fPbsELnw0VnFbMG1CZP2AFkSG/ukiT8fxxUoF+ZW92XXN19+b9y1pvESsQJMPlZRE68TA4jiw0JI5PFLUf/jJZoN9Es7yXwOdZyA8yoglkykSGIOeHkWO/YtHHG1Msff6NlRbwQlwtajJ50gvGV266JFKRhBCGygELdFAsgikm9YhTsPjBDZp7S2V5Jfus9ZzNH7I6k2lWUDxu27WT0VXnMeeSiN3S075CukcH8erbE1QPWz+9uC/hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB5885.namprd11.prod.outlook.com (2603:10b6:510:134::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10; Thu, 29 Jan
 2026 22:01:28 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 22:01:28 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 29 Jan 2026 14:01:27 -0800
To: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>,
	<dan.j.williams@intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-fsdevel@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
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
Message-ID: <697bd8b7fb6f_1d6f100e9@dwillia2-mobl4.notmuch>
In-Reply-To: <b137dd39-dcf6-4203-adab-8c9ee2b3e6ef@amd.com>
References: <20260122045543.218194-1-Smita.KoralahalliChannabasappa@amd.com>
 <20260122045543.218194-7-Smita.KoralahalliChannabasappa@amd.com>
 <697a9d46b147e_309510027@dwillia2-mobl4.notmuch>
 <b137dd39-dcf6-4203-adab-8c9ee2b3e6ef@amd.com>
Subject: Re: [PATCH v5 6/7] dax/hmem, cxl: Defer and resolve ownership of Soft
 Reserved memory ranges
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY3PR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB5885:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d0a7eea-5cea-4309-3235-08de5f81f42c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a05pTzBta2pZUEZJV3hKUEZlVlV6TXQ4bDVIU2VhY1Z6am11ZjFsclVNSWVZ?=
 =?utf-8?B?V3prOERHb09PRTJJV1NDYStrKzQwbCtWS1hYSkFYRlQ3SGh3dEpMUXlJVGFs?=
 =?utf-8?B?V1laMzNWekkvdWlnNHBHYlhFNEcvODdSUmJldDhhNG96aUttZW00dllXMTZ4?=
 =?utf-8?B?b3F4TldXZG1UUXhvNGlLMlhGMHAzMm5ldWZGRU9FMVg0NE42MXZGYmlFVHIv?=
 =?utf-8?B?WWxEcnNVMTVYeTBxdExaYUtHRm1CeGVLZHM3d2oxVjlER3ZQemF4bWJwMFN5?=
 =?utf-8?B?QUw3RlUxdHN5STFqUldiYm1pRVl1M1dEWmN1cmd0R2pMU2dVeEhCSEtHZ0FW?=
 =?utf-8?B?VXN5T0N2R2x2UmNORDBhUHZTTzFtRTZGV21xQkpoUEdPQ3lDZEdOK0x0Zlpy?=
 =?utf-8?B?QnBmVU0vN3plSnVKNUtFbzFQR0V3S0liQWgvVlFXcXN4WUI2Zk5vcERnYXhm?=
 =?utf-8?B?M3RwNnlDTVhMQnZ3ckVxcGpLc1h6TkI2eXZHanp1T3IwclZyS0FTNjlEbWIw?=
 =?utf-8?B?RzVMZjdGTDduOG1BMEkwemlGV21WVWoxb1lzVnRLWisyS0x6ZDdXeTlEQ01s?=
 =?utf-8?B?SWZPWUZpaVMxUmN1eWc1K2VvS3ZvbW5jVisyY2dZc0VPMG8yTmQvb1Z2WGRx?=
 =?utf-8?B?R1c0cVdPQnJOUHpCc1oxQU9XZ1I2N01HWHdkbi9wV2MrSzNYWjBuY1FjdFI0?=
 =?utf-8?B?cFNKR2NQeUNxcyswOENrVjdlaFJ3Lzh3YytYaXNkZ1ZmelR4ZVB0Tk82dk1P?=
 =?utf-8?B?SUI2OHZzUmxMQlRlcldKaTc5alBGNG9pbHJTMFE4bUc3cUorQWNTV1FqN1Bx?=
 =?utf-8?B?d2liWVJyN0tRRk9PNm5IZkxxL0JOUzdXUDB0Znh1UXlpaVAxWTVWMGRremhX?=
 =?utf-8?B?c0J6bXFsYm16MFJsOTFmQ2ZJYnRkaXdXdnhTd0N3NTVZdHdUcDMvdG9VbXF5?=
 =?utf-8?B?MEd1a0tjaVdUUGVmTm55NjlwUW9xU3l5eU9YSHBNTDlnWVp1UWRRUitmUTBM?=
 =?utf-8?B?K3NCNXlYMmU3alhqSDBFUjlXTlNDM1BzTUdRVE5sZVRySzlRNUk4eW15Y0ZR?=
 =?utf-8?B?SnRPcjlPT1RQWndZejhta0tWaGJXbENkQzRjMWZjNmJoZmRhbWwxR3hBNm95?=
 =?utf-8?B?YmtuZ1d0RjU0TW5WRDkrMGI3SnNrMTVjenJjUmd2bnd6UGNVaGFueVVrbzFE?=
 =?utf-8?B?Q3ZZQ3UrMjQrWnB0ZDFpc256SERJWGRmQTk5THZCMkRERy9GUE5NUVZxQ2di?=
 =?utf-8?B?Z3F1OWNXQ2R5Y0w1ZHBTeHZ1KzI3VEhvSlM0QThPWGsyZTU3YjZMc2dCSzBp?=
 =?utf-8?B?S21tTWI1VU1hc1VyaWtYV1dhSDRqVzY5K2ZpRVdveDRDam5hOFN5MUFqaWRF?=
 =?utf-8?B?QXlGQVpxNDk5U0tRanpaREJ4YncwUnc1ZEU2ZXNRUHRtNjk0VklEOTh0Ky9s?=
 =?utf-8?B?Zy9jcmlyb1ZuWDZUaStKL2dkMVNEZUhrSHRCd3ByMDAzRm90ZVdNeFRFNllz?=
 =?utf-8?B?Mzd4UVFNaktNMWRnOEdMUW1QY3V5NUdvbWxaWWtPNFhVVEpkRldPY1o4Y3B3?=
 =?utf-8?B?NDd1VzhtSW9Pem1FZHltMjV4SFVRWnhpZ3A1cUZ2T3lHVC9zNFMvK3RGdVFW?=
 =?utf-8?B?VWI4UEkvZllhV3R6NWgwdk04dFlvWWo0dEJSZ2xPQWdTVTF6OW40d0VScVZY?=
 =?utf-8?B?eGYwUlFSMXdVdGpnb1JpbEE1Ky8ySDh5dUpiU2xTQldNbUpiTndKTmg1QXF2?=
 =?utf-8?B?THZEaEJKUWduM1pWcCtpejhjMEVDdmtLYm9zWllSbHFRVXk3MG9JRUZMTi9i?=
 =?utf-8?B?MUd3ZGJwWnZ5eHNOQTdaOWQvRWJPTE8rUTJzUk9hd1FhaituWTVBT0Q0RXB3?=
 =?utf-8?B?YXBGZnRCNnZMRE55dkNlRWIrY3V1YlZqdnZhUGkwREVvSTdWNEIvNlNEcC9B?=
 =?utf-8?B?Um5WN1pXQ2ZxV3RUaGRDc2x5SFlXUHpHN2tDcjB2aE5kWG1LTmlVS1JoaFJL?=
 =?utf-8?B?ZnlGT2lVR1dySkpCMEY2RkVjaUtWL0I1enhCZGRKcUJmY01nTUtSN2JOU0F0?=
 =?utf-8?B?MmlDajhPcXdwMjNhQU1TcUowS2t3N2czeWRFeXk0a0Y5M1VzUktxRm4xU0g4?=
 =?utf-8?Q?go24=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDhJdm1jSUVQVmVXTjBlT01zcXZtaFdaSmxpU2FEOW5oNU1xNklnVG9JRkZY?=
 =?utf-8?B?emVtaUxZeDBPMnBmTGkzd2phV3VGYU5tcXZIWUQ2ZVhRWVV1R3RVMDV6cEpZ?=
 =?utf-8?B?cTJiY2tIcVVCNUZrN2NJSEMxWW53ZjlCZW5RayszUnJtT2lsSWVzbWtzdEt0?=
 =?utf-8?B?UW1BbkFBSU83dUpjcVViTUluaXNNTDB0c2UzWUVhMHlwVGJDTEIwVnNkQzhF?=
 =?utf-8?B?YTZuRWRjSG5sTkppOU4vdXpESFFkU0ZnU2pxNmFXMEJFR01DeEorN1pzeUp6?=
 =?utf-8?B?bnRRSDJmQzRFZjkvaGxwV1JmYlFLSW5US2pYWGlNdEZlL21FYVFTMXE4V0po?=
 =?utf-8?B?QTVnQ0hBNnIzWE9IMzVHalFBSEJCdFVYRlNqbGFhVnE2dmMrd2phT0hqdEhZ?=
 =?utf-8?B?SzFSd2RnS2I4dy91dDEwMGg5eGZ2aFJzSmNXdlRYdEwxdTgyRTkwSm5mZTlH?=
 =?utf-8?B?OUttWVE2dVUwSlFmNEtXSC9qTWZzZVk3MGlTL3ZXV3JzYTNnaW1sRUpVQlIy?=
 =?utf-8?B?KzFLTGdPclozY25ZQjA5UzEwQVRSbEdhMXNVVzNCN2Urb3ZIdXJhQ3MxdlBH?=
 =?utf-8?B?Vk82Q0hvNFEzeFRMTVU0cGd0WlVGWVF4WldlcUdCelkrTDlMblZDYXdJQ2Vp?=
 =?utf-8?B?akFVS29NWWpNbXFDYVVVSTdRVXZkTTB3V0NqbnJ2TmhjMXVxd0M1T1hjbklv?=
 =?utf-8?B?a2tuRE9kL0xObmFQWVVMMEFTM3V5L1NCNDhJQTYrMDdrczl4NTQ2aFh5bktD?=
 =?utf-8?B?dVR1Tkpua25uV01lZFJxdlZockF3d0RMdi9RWmh6RWFLTWpMUi8rRC9Zdkd3?=
 =?utf-8?B?VUE3OFljckxvMFpaV29wMkJHc0ovOXVybFFRdEwzMk1EQnpkazF3aHpZQ2FB?=
 =?utf-8?B?RGtqdzFqQkxPdE8rMzg0amNROHpGZTY1SXdjWnJqWEk3VFJPZGdoL2FUUk13?=
 =?utf-8?B?UXpUSFd1ZzhWb1lZdVcrS2tON051Um9qMUpjVDlrL1VpR3RpT2JOcDJCSWRu?=
 =?utf-8?B?NXgybmg3SnFTYkhuUzR3L3daRWVWYmUvc1lZOVJOY0NScklhYjhMQjNuTzla?=
 =?utf-8?B?TGJKQ2o4LzZyTmhGZ0g4RzhNYzRvaFR5YjVsVWR2cDdSbUlNdDFTSU1PbzRG?=
 =?utf-8?B?T3d2TzZyVkZJUGQxak1lZTdCNEp0R2Z2dURLbXJ4ZkRvVXRmVE1SR0NoN1d6?=
 =?utf-8?B?TnhNR3NsSWtSSHA2WWNUbXZqbVF4ZHR4ZEYwUUsxOFdXU09MTmJNeU9QMCtJ?=
 =?utf-8?B?ZGU5R1k5NkZhU3BEMDR4WjFtQ0gxVUkwdnUzTUQySmVKTmgvU1VFeWl0cXNz?=
 =?utf-8?B?Mmp2ZXVRWVRnS2xUMUU5aFJTUlZKOGIzalZNaDR6TkN4anRYb2tsZzJsZEcx?=
 =?utf-8?B?cEg2R1d5clF3WmpTU3lUM3JYNHJ1M3ZDY3kxNUFBNFdsWkJ6bWNuekZHNXlh?=
 =?utf-8?B?UU1qUEtXMWdRc1pMeEJJR1UyNEhodFM2Y0xGNEtyTS9jOC91YURrMi9VRVBS?=
 =?utf-8?B?VFZKNkFsY1dLWmVOZkRPNGlTRHJxMG5iaCtUZ01QaXJONmNsTGVRdHRTbkRN?=
 =?utf-8?B?aVl3MDEwMXV6ZlZRVWt4WUlCVjE0STZmVnQ1a2t3NzlFNkp4OW0zRE93SlFr?=
 =?utf-8?B?V29WTzRYL0dRQUxDalFQRVZQSW9rSWpHdndDZ0trTlIvZi9XRlNzeGxGMmhU?=
 =?utf-8?B?YW5yK3pINlNCU3dpOUdDaWJFRXJpN0pTMitUbEI5bjR4RkdtOEVGRVBNS3hV?=
 =?utf-8?B?T3ZqSkt0ejNnNFJORTVmMmZ2QmpzdUs3c0tIYjNXd2Vyb05QQVdhTzYzS3RN?=
 =?utf-8?B?UlExc1ZUNUg0OUhxQ0MwYk5wWjFrdE90SmhrQ1RXSVJ0K1M5VDV2UE5lS3F6?=
 =?utf-8?B?c1oyeFFXcldJaVJaYi9wU0VsVkhUMTlRYmUySzZoWHVZNWpZQ2I4VkRZRDQ1?=
 =?utf-8?B?a1FScEZsbmdCZ1doQmliUEhuNlBCNnJMMlR6UWJQclh0bFlyZDg4YzVUZm1P?=
 =?utf-8?B?S0Q5c3VhNkxFemxHMG1CUFE3NENodnQ1bmczMElZMldlQmFjckJMV25XR2ZP?=
 =?utf-8?B?N0xId2d6ZjQ4dlRpb2xRQWVISmpxYnpDVHVLZll4Q3dSY2FjaTVta1Jod210?=
 =?utf-8?B?QjUrd0hYRWxrcXJ4c3RPRHNmL2FqSHBjSkdoanB2ZjRNeXRINjlXVTFHdmsw?=
 =?utf-8?B?a0lyZEZXaDNDRktOczAwamc1K0tjM0V3WGE1cHlxdEprZFhCek1saEpBc05h?=
 =?utf-8?B?NWlaaFB6dFJxNklGay9MeGVEbDI2ZE5rM1Mra295S0Vnb0xIZDZ6aURqdnRG?=
 =?utf-8?B?WXZmbElNdjc5UGQ2VHpPZHAwQm84Ym1CYWVzekU2cWlXY2diMkt0NGFVNTJa?=
 =?utf-8?Q?FAwhirCnMEvkj2Jw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d0a7eea-5cea-4309-3235-08de5f81f42c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 22:01:28.6830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AhM3mtgdbqr4RhLywmi/RGYhnLLCJYkAXiYE3wfdlasCHfRPNaazAe9m9vMkx/XFRc0c6Xg/ksVldc8flyOLfAV5rksjm1CfBP5bFgxCn6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5885
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
	TAGGED_FROM(0.00)[bounces-75912-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,dwillia2-mobl4.notmuch:mid];
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
X-Rspamd-Queue-Id: 59AB0B52BE
X-Rspamd-Action: no action

Koralahalli Channabasappa, Smita wrote:
[..]
> > I was thinking through what Alison asked about what to do later in boot
> > when other regions are being dynamically created. It made me wonder if
> > this safety can be achieved more easily by just making sure that the
> > alloc_dax_region() call fails.
>=20
> Agreed with all the points above, including making alloc_dax_region()=20
> fail as the safety mechanism. This also cleanly avoids the no Soft=20
> Reserved case Alison pointed out, where dax_cxl_mode can remain stuck in=
=20
> DEFER and return -EPROBE_DEFER.
>=20
> What I=E2=80=99m still trying to understand is the case of =E2=80=9Cother=
 regions being=20
> dynamically created.=E2=80=9D Once HMEM has claimed the relevant HPA rang=
e, any=20
> later userspace attempts to create regions (via cxl create-region)=20
> should naturally fail due to the existing HPA allocation. This already=20
> shows up as an HPA allocation failure currently.
>=20
> #cxl create-region -d decoder0.0 -m mem2 -w 1 -g256
> cxl region: create_region: region0: set_size failed: Numerical result=20
> out of range
> cxl region: cmd_create_region: created 0 regions
>=20
> And in the dmesg:
> [  466.819353] alloc_hpa: cxl region0: HPA allocation error (-34) for=20
> size:0x0000002000000000 in CXL Window 0 [mem 0x850000000-0x284fffffff=20
> flags 0x200]
>=20
> Also, at this point, with the probe-ordering fixes and the use of=20
> wait_for_device_probe(), region probing should have fully completed.
>=20
> Am I missing any other scenario where regions could still be created=20
> dynamically beyond this?

The concern is what to do about regions and memory devices that are
completely innocent. So, for example imagine deviceA is handled by BIOS
and deviceB is ignored by BIOS. If deviceB was ignored by BIOS then it
would be rude to tear down any regions that might be established for
deviceB. So if alloc_dax_region() exclusion and HPA space reservation
prevent future collisions while not disturbing innocent devices, then I
think userspace can pick up the pieces from there.

> > Something like (untested / incomplete, needs cleanup handling!)
> >=20
> > diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> > index fde29e0ad68b..fd18343e0538 100644
> > --- a/drivers/dax/bus.c
> > +++ b/drivers/dax/bus.c
> > @@ -10,6 +10,7 @@
> >   #include "dax-private.h"
> >   #include "bus.h"
> >  =20
> > +static struct resource dax_regions =3D DEFINE_RES_MEM_NAMED(0, -1, "DA=
X Regions");
> >   static DEFINE_MUTEX(dax_bus_lock);
> >  =20
> >   /*
> > @@ -661,11 +662,7 @@ struct dax_region *alloc_dax_region(struct device =
*parent, int region_id,
> >          dax_region->dev =3D parent;
> >          dax_region->target_node =3D target_node;
> >          ida_init(&dax_region->ida);
> > -       dax_region->res =3D (struct resource) {
> > -               .start =3D range->start,
> > -               .end =3D range->end,
> > -               .flags =3D IORESOURCE_MEM | flags,
> > -       };
> > +       dax_region->res =3D __request_region(&dax_regions, range->start=
, range->end, flags);
> >  =20
> >          if (sysfs_create_groups(&parent->kobj, dax_region_attribute_gr=
oups)) {
> >                  kfree(dax_region);
> >=20
> > ...which will result in enforcing only one of dax_hmem or dax_cxl being
> > able to register a dax_region.
> >=20
> > Yes, this would leave a mess of disabled cxl_dax_region devices lying
> > around, but it would leave more breadcrumbs for debug, and reduce the
> > number of races you need to worry about.
> >=20
> > In other words, I thought total teardown would be simpler, but as the
> > feedback keeps coming in, I think that brings a different set of
> > complexity. So just inject failures for dax_cxl to trip over and then w=
e
> > can go further later to effect total teardown if that proves to not be
> > enough.
>=20
> One concern with the approach of not tearing down CXL regions is the=20
> state it leaves behind in /proc/iomem. Soft Reserved ranges are=20
> REGISTERed to HMEM while CXL regions remain present. The resulting=20
> nesting (dax under region, region under window and window under SR)=20
> visually suggests a coherent CXL hierarchy, even though ownership has=20
> effectively moved to HMEM. When users, then attempt to tear regions down=
=20
> and recreate them from userspace, they hit the same HPA allocation=20
> failures described above.

So this gets back to a question of do we really need "Soft Reserved" to
show up in /proc/iomem? It is an ABI change to stop publishing it
altogether, so at a minimum we need to be prepared to keep publishing it
if it causes someone's working setup to regress.

The current state of the for-7.0/cxl-init branch drops publishing "Soft
Reserved". I am cautiously optimistic no one notices as long as DAX
devices keep appearing, but at the first sign of regression we need a
plan B.

> If we decide not to tear down regions in the REGISTER case, should we=20
> gate decoder resets during user initiated region teardown? Today,=20
> decoders are reset when regions are torn down dynamically, and=20
> subsequent attempts to recreate regions can trigger a large amount of=20
> mailbox traffic. Much of what shows up as repeated =E2=80=9CReading event=
 logs/=20
> Clearing =E2=80=A6=E2=80=9D messages which ends up interleaved with the H=
PA allocation=20
> failure, which can be confusing.

One of the nice side effects of installing the "Soft Reserved" entries
late, when HMEM takes over, is that they are easier to remove.

So the flow would be, if you know what you are doing, is to disable the
HMEM device which uninstalls the "Soft Reserved" entries, before trying
to decommit the region and reclaim the HPA space.=

