Return-Path: <linux-fsdevel+bounces-33573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B319BA30F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Nov 2024 00:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A998E1F21FBB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 23:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0891AC44D;
	Sat,  2 Nov 2024 23:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZzzgsrmG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CFD16DEB5;
	Sat,  2 Nov 2024 23:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730590451; cv=fail; b=mFMKN0ZdO0FPI4YZnj8wBbkbD2EWb/BBkUjg9rOTpvKeqKJfevE5m2/4pGSjEI93TIVAKUxNtqHiSpKzSpUa89BtEHQNNgpNBrUV9TQNHUGN+Uhol0WiDr0F3sloNpZM7RwKq1f9EU1G3VOfvHBFr0OQV5MFbWunTJ0uHM26yPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730590451; c=relaxed/simple;
	bh=KujX6+lKsGGqq1yAYMKpHKfsbeqsw+wkOZOkeArtz3s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VKls7aae9+DFNNklHhifQkqwyMiifSne5drn9uWqDf2yiAknqPuKk7jDmP4AKtWc42/cj2Kql7uBw6yOZF1cnYga3mRugUeAo4PNg4VzVT9YI8LulT6QX4pvAzOYF9uFSIxa7w7KXlT+3Ga3G0vzJlDIPLZ5XmSKfgkhXn8saaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZzzgsrmG; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730590449; x=1762126449;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KujX6+lKsGGqq1yAYMKpHKfsbeqsw+wkOZOkeArtz3s=;
  b=ZzzgsrmG+pDd/Xyfr62eR4B2oWED2U001wLSVv5vXp6Sag3JvYcpGt+R
   zomSC/UP00wgZj8+yDTZvdUGgO/jwoOBxiY7qfJMUO+FXZxugEyVqrK+s
   wpEspAr8aMk3TU6wqq9J/HhrrwtFVQK4deEyXFcgHOhF2x8Bzf9EDhsZ5
   phoWwnZ42g0byKUlpGMqS5jKCuo0cUUvgXZiThtMD8WNYiGhKZTeKy2sK
   DAE+m8DgYhEBBJx9sZZqkAFvsAl7Rq+M/4/S2X8Xnjh/p0GMBfDgtV2cm
   3oqJ/VqbbUeBi40faLIdRVGMK2FaeBasuIKn63tuETgJap6nawQILqGqB
   A==;
X-CSE-ConnectionGUID: jO4p59E5S0+VwU/TbKbNRA==
X-CSE-MsgGUID: tbhHD5YfTdqwCCl8K/3Z7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11244"; a="29741395"
X-IronPort-AV: E=Sophos;i="6.11,253,1725346800"; 
   d="scan'208";a="29741395"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2024 16:34:08 -0700
X-CSE-ConnectionGUID: n60NSsCAT+Cpsqi4RCrC9w==
X-CSE-MsgGUID: XaNxgnHeTjuCxoPrPDZNPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,253,1725346800"; 
   d="scan'208";a="106627711"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2024 16:34:08 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 2 Nov 2024 16:34:07 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 2 Nov 2024 16:34:07 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 2 Nov 2024 16:34:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xeQFwu0HfW27ofKasL8NjDCV7Nlr7GSs5NGjmFT97lcI5UbqHoExUbZOpVzf1NoztpZ8mJLNdG8d1d1vtDJoBdsiWVqVh2FVwmBrYz//JIX9eiylZh7YoSzzVh1Tf3pYt/Dq6w8B/kpvocmq3YfXgkSZqYZbe/CvCIAqtpxhxythU9U3qWxHiF77Jc2swoug32m0iRmBTsZZpez4rPeZ1xYD1sFerfEN9gLdZvRLlw25mJwxxK35AbLnHfpexgvHu4+Vd1tDaU24jzdrBdO9jzjzxs3jqalEcTzrkvRWaO88eTtqI55m7k9c+3DbaxCXa6ujMg2PkJiSW7pMbzyS9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pb50iQcv2VMD2Z/TxqrYJ8PSiBHCq1lhnLMLSLHpf0U=;
 b=dv3tSU21bktPiODnw9a0q8/rMYCbkIiWcyyd38mUrXnuKkDki0WVGl/ROtShXBRWYfoSe0LuQYo6OnuRJzNZHLDDeFBq0aHqwmrl0qVyXKw7CUBCmMlEhWpMsifngA/3yEEU8bE6OXfSUHg7xi9j63SwdsR5w2aSN0NrqBvQnIJCE/W8KQAJHLj0Y/WFTb4A93p1nz1GLG5nu5NlcT6+Q0J8D8E+Gu/JOd+VSTHo/CSnY3Ec56n6srsktkG8XCt/Bk6LPM/6/T9oLC4ilCh5Vm82bMwnVUbK4WM4LidYmqM9nivFq3aBAI1PI5lGj9DeUUNoxC7kY/DTJhYOBIVVIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4886.namprd11.prod.outlook.com (2603:10b6:510:33::22)
 by CH3PR11MB7770.namprd11.prod.outlook.com (2603:10b6:610:129::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Sat, 2 Nov
 2024 23:33:57 +0000
Received: from PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::9251:427c:2735:9fd3]) by PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::9251:427c:2735:9fd3%3]) with mapi id 15.20.8114.028; Sat, 2 Nov 2024
 23:33:57 +0000
Message-ID: <f34c989f-a381-47cb-b097-3dde9de2bd20@intel.com>
Date: Sat, 2 Nov 2024 18:33:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 4/7] eventpoll: Trigger napi_busy_loop, if
 prefer_busy_poll is set
To: Joe Damato <jdamato@fastly.com>, <netdev@vger.kernel.org>
CC: <bagasdotme@gmail.com>, <pabeni@redhat.com>, <namangulati@google.com>,
	<edumazet@google.com>, <amritha.nambiar@intel.com>, <sdf@fomichev.me>,
	<peter@typeblog.net>, <m2shafiei@uwaterloo.ca>, <bjorn@rivosinc.com>,
	<hch@infradead.org>, <willy@infradead.org>,
	<willemdebruijn.kernel@gmail.com>, <skhawaja@google.com>, <kuba@kernel.org>,
	Martin Karsten <mkarsten@uwaterloo.ca>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>, "open list:FILESYSTEMS (VFS and infrastructure)"
	<linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20241102005214.32443-1-jdamato@fastly.com>
 <20241102005214.32443-5-jdamato@fastly.com>
Content-Language: en-US
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
In-Reply-To: <20241102005214.32443-5-jdamato@fastly.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0018.namprd08.prod.outlook.com
 (2603:10b6:a03:100::31) To PH0PR11MB4886.namprd11.prod.outlook.com
 (2603:10b6:510:33::22)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4886:EE_|CH3PR11MB7770:EE_
X-MS-Office365-Filtering-Correlation-Id: c8e387f5-2a71-40f1-e442-08dcfb96d28a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OFZzRzVrVUJoZWJyajJEajN0THJ3amdWQzN2cVV5bFIxa2t3ZXovcjYwQmIz?=
 =?utf-8?B?T1lpUERYS2RpRldUN1RSN1o2ZzUvUXFsUWIwc0dwc1Z4VmtqTnFpZ29lOE9Y?=
 =?utf-8?B?Q2dvUUM4aEFTR01UeWd2QnBEM3VvRnY1RkhWSTZOMjYwWmpOVWtpUFlOYkFq?=
 =?utf-8?B?d3FlTEtXVDlUMTI5WHg3UzE3c3d1dGQwbzRTMklLc1FUdWlSQ3h5WUJPZW95?=
 =?utf-8?B?ZWFaSno4aUd4c25OcmlyWkVGT0hMWm1WZ0lMUzl1Wm1ETnFWS3FZSmtUL2ho?=
 =?utf-8?B?UFB6TlpzNXVUU2FEdS9xK25GQkFSbXRBcDdGem56eCtEa2V0eDZLeXQzSVpB?=
 =?utf-8?B?WEFBWWxjLzdxdnVUR2RWazRsNExUOFNWdEJ1V0hzYzEyc0FGdVI2Y21GdUI3?=
 =?utf-8?B?SlNsUW1lQWZ6NDFpcEw2UGJtZ3ZIaXlvbWhmbUFOZ2tLK25SeFk3MEF2Tno2?=
 =?utf-8?B?WG1LVUpvUXFhczRGTG5TZk5OYkNxWjdjYmdqZ0t6dGNaR0JYbXZXdTB4b0l1?=
 =?utf-8?B?K1RPVEtJZ1UvMGt2ZzBaWDhXT0F6cFhNbjJ0MUFnQWNyTmJWcXZpcmFoek9n?=
 =?utf-8?B?ejUvaHJ2V28raFltN0pIazV0NVl3b2xXV0EreDI5UU82Mkw5S0VIZHRDU3Jk?=
 =?utf-8?B?WmNkeHBlWmJ5K0dDL3ZIVFZEN04wd2xrSnBnY3hVajlYVW54K3c5bEh5a3Zl?=
 =?utf-8?B?S3BVYzdxSjhmZWRuQ2E2QzVDTEVLZVRodUI2YU5NZ3l5MDFOL0RBUVNKa2pP?=
 =?utf-8?B?SWRGdGdYdjRqa1pZRmtHSnQ4aEhtRllORWhzMjA5NTJiZXNNN3NHNC9HSzNl?=
 =?utf-8?B?b0hRdVdZekdXNVQ3RG56UFBDR0V2a1JIU0FGdVZKU1BxSEo1MU1oejNsbCtN?=
 =?utf-8?B?VWQwVTVHcHZSWWNDNnpHS3oraC8wV3dWRW9YUVdhK1pyMTlpYStidEUvQWMv?=
 =?utf-8?B?aC9BUUN0VzdLSkUzcjgyY3lJNXRTWnYvLzY0TzZXbHY3b1lxNGFmQlVLN2RR?=
 =?utf-8?B?OE9wbnBlK1llR0MzWndHUHkvZkNFL1RLeTQwZ0NxVkFGOFp1NGQrMVZJOEpE?=
 =?utf-8?B?djJYSFJidENsSnI0anBmUXd5ckVwUmdsSnlTa1poMkNUK0xxa0ZaMFAzVU02?=
 =?utf-8?B?djdaRktlK3AvMk85NkJHeXFxY0V2Vzk2WTd2UldmVW0xSXJaRFZRc3hWUkZj?=
 =?utf-8?B?amM4MjJmYnZXbXJRWDdsU3FSbzk5NnNVdDZrVTRHcUU4M2NQOXpDakYwenpl?=
 =?utf-8?B?K0Z3YSt1Q3BRb2h4S3JqajlaclAwQ25HSGR6azM3bTVQdjdUWWRYT2Y5TzFK?=
 =?utf-8?B?MCthcVVpQWNWMGtDT1RBL09xR3Zza2wyQmJhakZUT0g2Q1pVcDlsRTJIRGps?=
 =?utf-8?B?cVY4MmVWQjdidnpWTmhEMjhYRVRxMnl3T0ZYT1k2ZlJmWWY4M3dFTmdrT1V3?=
 =?utf-8?B?SkZSRklyMjlwWXZVcllrTHNrb1ZZaUpUTlA1aXdrYjdqTUNHeWRzK1cvWjV5?=
 =?utf-8?B?WGZaYURpRG02NnpReXREOFFaU092KzRpTzR6Q1dGeGhUWE9DWlBhZk5DVnVt?=
 =?utf-8?B?WENjVnVVcW1qSlFUbWJXUTVWQjlidjJzUHR0YXVKYm9wT25PUGRhL3EzNEo1?=
 =?utf-8?B?Yi9HN0E5eDZDelVRMUhlYTR5bEU4Qlo4RUllWUZFWjFxTzM4dzh6ejFPbXFU?=
 =?utf-8?B?djlrckpoYkNTcVpZSGMxRHBxZGVjTXF5aE9WQjRFZ3AwSHZLaGZlcFNwOGpV?=
 =?utf-8?Q?bkj5rla7Em55NQns7YvDaPstRjpF6hzjC0Xl6Yn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ei9HM25DR3dJNlRvZ2ZVeGpFUEUzb1p3K25kbmFIZDVqN0NNbTBoQmk4MjhV?=
 =?utf-8?B?dmJkeXNIY25ZTERDcC9UQyt0QWlBeDF3dUhrSmJDTmVEOHFlWW1QMFYvZVZq?=
 =?utf-8?B?dk5NRnlJWXFlbFpCLys5Z3A0aXhBN1pxSzByVUFxcnFqYjlFdVk2bG1UWnFy?=
 =?utf-8?B?di9NNUVpTUVwSWp4a2tMNnpPNVFrUDZtZWZMaVZrQW1JUWtSeHFWN3VCb1pG?=
 =?utf-8?B?a0daKzR4QWZaSEdJSmNseWdCcDduNERTN2U3eEpNQ2FaNWxhSjdWYnJzMTlH?=
 =?utf-8?B?anViNy9ab1N5SjJWWWp4QjJTN2JWVHFZL1Z4K1JvSTNEN05wSVBvQW9YWEM0?=
 =?utf-8?B?MzRJdFJ6eURMUzFRaGR4TmF1RnZpTXVUTW1Ub2paU1lZaWtGNHBDS2JGL0th?=
 =?utf-8?B?c2h5WXMxSVdzdnEyOWdzWXBYbE8vcTNYOWhURHpHdkdxK0VNZTRDeWRIVDNQ?=
 =?utf-8?B?dXNSTGczZS9tZ3hUMUJFOVdNODR2Y0FCa3NQeWwxNzRNdHc1UmY1UEl5TGlr?=
 =?utf-8?B?TjJ4RTB6M2lCZzVFdTcwM3c5bHJzbksvTC8wRmZkZXlHTlFGam52VHNGbDI1?=
 =?utf-8?B?L0prTDFvZTl4U3JIK0FMeEd6UlBaQVdNdmpzN29kd1dlYWlUQXpWVStYbGdX?=
 =?utf-8?B?Y1loTmdaTDBKT3R3WXU2dHNRRGxNUTdpVU9mOC9EUXdUU1k1SUF3SW5wcTh1?=
 =?utf-8?B?bWtiZzMzVWlRMHBmR2VlUGlMZnc0OUp5QmM1ZFJoWjE0Y1J1ekN4cnZCTHpn?=
 =?utf-8?B?RTNBbEhkYlNaNmNNSSs5cTZWaEVuWDNqZGZWSHFVMzhIQWdDWlo0d1l6SjJ4?=
 =?utf-8?B?b2xqcEZMZHBHSUQ2RVRDNnRVbHFiKzFRUEQxNVVuWFhldVhRRWs2dDY1UDZT?=
 =?utf-8?B?ZVdXVmdrY2hTRTVEbFh1UVgyeGZMUGZBeVVoZVdFRXhqU1BTNW94RUc3aXlo?=
 =?utf-8?B?ajlWenZMTXZaZTVxUGtuWWtoZms2cHI5bTk3SVduTE01cGtPK3lLb2VkSFI4?=
 =?utf-8?B?UjB1TzFtTEFFNTJnY1p1ZEVhd0lwU0VjZHptQjVXMU9VMlVpcDFDdmJIa0tZ?=
 =?utf-8?B?cFI1dERtbEMxOCt3THdRRUEwM0kxMDV5NlBueXY3YzQ0K2VXVjhEMGJQWStm?=
 =?utf-8?B?Slo3d3ZRN0VQZDgzODk0WmJSa3hSdGFxalZoK3hrWkNNQis5UU1hQWR5elNK?=
 =?utf-8?B?MjB3RjcvL01sSDJKQVpOc0lGdEFSMzhHWUJwSlNtbmN6OVNsVHdqWGZoMjJD?=
 =?utf-8?B?YmZ3bDNJdmo5ZUIrZENSY0Y4U0xBdk94dnNNTHVrbzRORitwZXU3VWZFWGZj?=
 =?utf-8?B?aFF5aFZsQ0tQeWRvTWpxM28rV1NJaWZTaWV5US9RY01zQjNRYWFUV0pvbDBX?=
 =?utf-8?B?WnR5TldvNjZlam0xNk5la1haOGpiNis2VFM2R1RSREFrVVBTcVFYOVNqUlFQ?=
 =?utf-8?B?cWlUMFRsaEtFaEtqdEp5dzBBbEkxVjFmcWozVVF5ZnNyRUJ4aXdUWXloeldS?=
 =?utf-8?B?V1BkL09mRUlDeDRDbkwvSUZXdG16RXM5ZGIzTUpyeWlzZkdPNnhqTGpLd3FV?=
 =?utf-8?B?clJzbkVVSjBPdjZCbitIUUE2ZUpYR0FqM2xoY0xQdzRyOHEzdSt1b3JJN1d0?=
 =?utf-8?B?UGlMeEY3cC9CSzlBREtTTnZvcTBnVG1xN3hZRFc2bE9PYmVyMThpcnBwZkVS?=
 =?utf-8?B?N3I1cDFzR3VzVTZpenRSbVBCOUF3R0ZrRDBFQ1hQejdXMkVDM0FyUzJwZk45?=
 =?utf-8?B?UWVxZHRLMk1RVmM4UUxyeFcvQUFMcTh0Zmowckh6TENTOGRWL3BIRzBRMkVC?=
 =?utf-8?B?NklXWmdFSzVnUGtsWDFMbVlaOE9qalpRS0pEMml3TGRublpYQ2o0VjdhdFF6?=
 =?utf-8?B?Z0lLV3NJUGRMaVdiSFY3VUV6dGl4R3pXR0hGbXA1ODlWWlNZOGpLMjlFckNn?=
 =?utf-8?B?U2hDYWZ5YjV2T2ZuTUpDcDFLZ05jTjBCK0VsNGhoNkJMc0pKaWw2TFBFUVNL?=
 =?utf-8?B?QlJWZFlzRTFmbnFoNmd0RkQ2OTJPTjJyWEZOTnBza29PaFZZZk9NMmZReEQ1?=
 =?utf-8?B?V1lJeitiUThIOEg2aDM0czBhR0dSSm5la1pUVlhIZlBna3JFQmZpYmgrSlRl?=
 =?utf-8?B?TVBsOGErTlFhVWlIOU11TE9GZ0kwUDN0eG44Zk5WOHVScXJsSFVUU0lBbDhr?=
 =?utf-8?B?L3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e387f5-2a71-40f1-e442-08dcfb96d28a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2024 23:33:57.6844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OOVTA6IXSie3iac+OAj05m3LfhHnr+Sj0KCDfm0EritYx7bw2ecbmLi28iY8hWKTcwckbiSz+Wb3AO9OiPmWEoQpo1E7erJNvDdlWgSFiP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7770
X-OriginatorOrg: intel.com



On 11/1/2024 7:52 PM, Joe Damato wrote:
> From: Martin Karsten <mkarsten@uwaterloo.ca>
> 
> Setting prefer_busy_poll now leads to an effectively nonblocking
> iteration though napi_busy_loop, even when busy_poll_usecs is 0.
> 
> Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
> Co-developed-by: Joe Damato <jdamato@fastly.com>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Tested-by: Joe Damato <jdamato@fastly.com>
> Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>


