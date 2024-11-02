Return-Path: <linux-fsdevel+bounces-33574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC0C9BA312
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Nov 2024 00:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 470621F22731
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 23:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5981AC44D;
	Sat,  2 Nov 2024 23:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ipMmSUB2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3E3380;
	Sat,  2 Nov 2024 23:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730590517; cv=fail; b=GUgtq9k5HQy1mzcVqqoS+3KoJdDvtFt+gIqi9rVs4T6vNtmr0Gua4Xt4CcW26Xn23uNyZMGi9A2uKzSWSXawNzuGfRAU/WRfVV65NrPiE0CsnMbCsvTMOS+9a6erIjxc+lCpqjBP/hyL8KLZLNMqq+N6OPHmeC4I1BZM+YHKju4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730590517; c=relaxed/simple;
	bh=8CLI6VLnNXaxWjK8J7qofzj2+F6vaJI3r8gJ5k+mkEI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G92lK/BY0e+2hH519SoJIrBcalY8AK+7pBvk75qMlTaSq5dYL0+Btw91FuYaSJ0yuXnfhpSy2X+ys9KF5ejo+eNHB5g7BgJczLzn2N9eSNxay06SXx0fRxab9KEVFXDJ3a6FT7aiLlp68ESAZbuBh4eZl66xANmmg0DItK1WMvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ipMmSUB2; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730590516; x=1762126516;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8CLI6VLnNXaxWjK8J7qofzj2+F6vaJI3r8gJ5k+mkEI=;
  b=ipMmSUB2Az+RFZ6ZBcp+5qHfMn0jKDiLyo3hkCDqFRLfniBpACEHfWNj
   fAjQDPgHnufRZRBw358tBKx6/Jix4TIWrHrLIgdb2pzZMjTnzMUCyOoTx
   J7tCnXnntEmB9x2jISzfYD1rH1QG3sFRQeMOkQaAwgTyGrLY7kdIa7jhd
   MX70yO+LFTSVBWh/bHVyX7wiTYzX5MI61dfoC+Rx4pDugAukj8tUxy1Wl
   qdWLWfIVYJvdky30wwykRquYdpBcrbEAvWe7BUlMMmN1oOEpnVQ/9SOYP
   fVslsZp9iDXNFCD0pPwkFs+OuS1jH+CfwWYgeN4hCDo5QUUj0xMqq+sLK
   Q==;
X-CSE-ConnectionGUID: 3PAPBpDdRjOHa6jFyozb8A==
X-CSE-MsgGUID: 7JhcTSsTTMWcaRCWuze4qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11244"; a="30543076"
X-IronPort-AV: E=Sophos;i="6.11,253,1725346800"; 
   d="scan'208";a="30543076"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2024 16:35:15 -0700
X-CSE-ConnectionGUID: ccPDuuefQEqPi/++gK/86g==
X-CSE-MsgGUID: m202+9HWR+Ko4+A+gQ/QKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,253,1725346800"; 
   d="scan'208";a="82956949"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2024 16:35:15 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 2 Nov 2024 16:35:15 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 2 Nov 2024 16:35:15 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 2 Nov 2024 16:35:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VR8XJoa6EQAz0Kl0sAbXtdnmXUxptW5ihbn90B2iysAmleHz8dNXacwaTaQxVPl3vSzWtg0Hj7fR2ndCfUrO9ixGvFFGXanhe2h1GrxTEXxqOp0mUUAS+RqYvrvyvAEXBnOGZ6ZbeRwuu6XQASuilLXuZi9Eq3IjVMK3O6c6agg58WYrGTb1vtLfB3i/xEDuIZzMwgNZ4vQc4nuqY1HvAqnAiMs3V7vodawaRsXWpNnoif31H5yj5FxKRpiv3T2vGZHPQ6jYnsZzs8yI8fVIl1OUP0Bl++EXRS8BZehxypCdJyzplwp97BUQzXdmUFrsPs1WCBOZkLty12xCcbG6OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGaH5gmAdrXpOETMGq6PXX0HKy2XaAyWbsuE74IbZjg=;
 b=h4+cNrEbVlLR0gddMqAuB5nW4U7vil5ZIxVVlEecpnbO3meVG8HE/8Eb2c8XrG8TNHabHCFZhpCXRTNAgx7NekGyg4PclBJ7/Bjkc6kw7R2qxVWsYBtyIRZycYwP0YqrEmuSwt4uewATPT3eY8tOZ5zBEzo8VlF+3qOStVTueySF8Q/UOC2eGrprBpUOgBuNir/HqLuFEayiq2v6EriWfhUzpnXTs42H4a/GxTRzLdp8m03lNrUt0ozXuaT0Hfz34WuAxRTKmEmzcbOiYtjT98MagajqeL1osxV118wPX6NiN4QCNG+8KMRnLR2v+348UxbppvA7LPKzJGJNDP0FPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4886.namprd11.prod.outlook.com (2603:10b6:510:33::22)
 by CH3PR11MB7770.namprd11.prod.outlook.com (2603:10b6:610:129::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Sat, 2 Nov
 2024 23:35:11 +0000
Received: from PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::9251:427c:2735:9fd3]) by PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::9251:427c:2735:9fd3%3]) with mapi id 15.20.8114.028; Sat, 2 Nov 2024
 23:35:11 +0000
Message-ID: <540c4198-95a1-45de-8904-5ae3bc85f7b9@intel.com>
Date: Sat, 2 Nov 2024 18:35:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 5/7] eventpoll: Control irq suspension for
 prefer_busy_poll
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
 <20241102005214.32443-6-jdamato@fastly.com>
Content-Language: en-US
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
In-Reply-To: <20241102005214.32443-6-jdamato@fastly.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0150.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::35) To PH0PR11MB4886.namprd11.prod.outlook.com
 (2603:10b6:510:33::22)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4886:EE_|CH3PR11MB7770:EE_
X-MS-Office365-Filtering-Correlation-Id: 394a016f-7b32-40d8-bd98-08dcfb96fe72
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?STdHbDFTelM3RENucUJqRi85YUFzWlBBYUd6REVBVmtVTTR5L2hqYUNyMHNF?=
 =?utf-8?B?OFo3SzBCUU9hMG1CaklGc29TWmJBMkszMlFDUWNHd21vRm9PT1hLNlEyOXpn?=
 =?utf-8?B?MTF5TmNMNmpsc2tOQ251WEhSYnNnbC9EaTgvU0hqa054WEc1a0p5M2YzSWlk?=
 =?utf-8?B?VnBNcVFjVUZ0bFI2UGFQb2pwQ2ZMSDEwekpENVBlazZ3WEFCSzlOQVE5eXJZ?=
 =?utf-8?B?S2JUT05xLzNVQ1ZCL0U5RXdKRUp3TUlxQ1JCZm4xVGU4YnpnOU9XRkJkYW1R?=
 =?utf-8?B?MlJXc0QyVGpiUEpyWVJubEhscU5lMDMrVy9VeU55dWhRWTAwSWE4R0MyUmdk?=
 =?utf-8?B?ZE9JS3Q2U2YzTThta3UxMzJSOThxSjdzVGxLRndVakhSN29pT2V6aVRhcWt2?=
 =?utf-8?B?NkNKL0dGS0xNTVVaWjBNUGx4SEZnbVU3TlBabFlkSGtuUW13cmFaZkpoc0FK?=
 =?utf-8?B?cUNpSEhXUmp3VThCbDRxYTZ3Wk9FcnVXTFRNckE3SnRmdkF3VFJYUGJKTVBp?=
 =?utf-8?B?Z2plOStFMXJHa2hZN3ZRUlBYTDh6dzBTSHU5ZDZsRWsrakNTTk8zYk9vRVRm?=
 =?utf-8?B?VUwvaXJBdzBLN2ZIcDRzdXQ3WExybnk4OWxVc1hQZ2VieTVMUW1TYXQyWDVl?=
 =?utf-8?B?S3VwUnBYSUpqUEtoK1ZRSm5mOFFiZ3UvZzA4cnRzWkRPK3dMV2M2alhmWDZq?=
 =?utf-8?B?SzlJT2NxbnVYYmw4aWpGVW5aNVFxZ1FnUmhyaWZxbDdDdDd5U3NLaitFSXlW?=
 =?utf-8?B?dEFUNE0xb0theXhhT3YyTkZCSjFkb25EZVMyajFtVWJqRE9nQkpBYnQ2ZGFM?=
 =?utf-8?B?WUN3QzRJSmhDTlJqcHVtQkZKWXdDM3phakUvWnVyRkU3Vlp3eDVuWFFMQWVV?=
 =?utf-8?B?REMwRXlIa0puczRlcDBqTDJwVi94ZVdTUzJxcTcwZmF3NjY2REdtUUV2MU05?=
 =?utf-8?B?dXRVeEtqaWUyM3lDVnlxUXM2RGtvT1JRYjBsQ0ZuL0wzZW42OEc0bkxyZFN2?=
 =?utf-8?B?TUo3aVcwU0c2aEQ3UmwxNkZHME1yQlc5TzQyemRIMHQ5bnR1eGNXdHJnTFVW?=
 =?utf-8?B?clJOM2dMU0ZTbGtUMERHVW5yOW53dEg2aFVXTnlKVHZiWURXTGhuRzc4S1Zw?=
 =?utf-8?B?YWExODYrZnVydEFuUXo2VlQ2eDE3MGFDQVZFbkcrbDFJVnl2YUdpWFlTSml0?=
 =?utf-8?B?Yk5DUTVodVB1Y01oQzAwUWxySEV6cjg5Q3VYdi9paTJjSmlyMVRPZFlKWEFV?=
 =?utf-8?B?TjhDZEtkbEdXN1ZlN3ROdTNmN2VOeFRwNkhOUzVZNGNFZmdLb2ZqS3JvMnVM?=
 =?utf-8?B?NHUvOThBdDZKemw4QTA5VW55MEk2d1FXWUdCODFRVnVPZTE2TUFQWWpUZUs5?=
 =?utf-8?B?MnFKY0NUQk9YQWk2UDcvb1RoYVdYZENMMUdnbE1nLzEwdG9rWmxIUHJpNC9K?=
 =?utf-8?B?cHRhcGtXbHZ2cFN1bDhYS0RhbkJWTUpCSmVRL2diNkVGOENMczY4OFUrcTRj?=
 =?utf-8?B?VVQxV1N1WkpyQkxYQjBTQUNZWC8xOHcxMUs2SC9HalcxSElmOTMxNVdibTBW?=
 =?utf-8?B?SCtaS0NaaXhCZXhIR1d5S2I5Mk81SDU3bFRScU9tZENsbWozZ2dSRTIxcUdx?=
 =?utf-8?B?OHpUT0VpVFRiVlVZR05JMHdiVFUzODJtbEJqVHJtYWdiV2YxTjRkYmlVc0Zt?=
 =?utf-8?B?V3h1MCt1WWF2R0s3TldjVitVOEsvTkVPTXhPY1FVak1GeGhjVmFyekwrall2?=
 =?utf-8?Q?sgcnKKprztMgWkOWXOM7tWEWldapO2BcrbmokPu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFpQM0ZDYWhNdkJoRmMzSEIySkJ3dDJ6ZUgyQ3hIQjZza0FqSHcxOFZTQUxt?=
 =?utf-8?B?Tkc2RkMzU3BtTURJYW9MMnFxRk1xenFTZ3AzRTU0YlEzMlBkbjZpK2xDQnkr?=
 =?utf-8?B?MmVRcDB6akF6dndEUGxwejBoMHF0QVhIK2o5K1FYMVorbTdyWTF4WVNWU3NL?=
 =?utf-8?B?Qkk5dmMzMW9HVmU5YUJLUURmcldqMm90QkthWTJROGI3VzJrdWkxb1NsT1Ju?=
 =?utf-8?B?cjQ0UDNKcGNDK21GZHpmZG8razR4V2JWajBFVlk4VEg2WTFwRDZXMXF0UXd6?=
 =?utf-8?B?NE9iS2d4OUFjK1VvWCthUU9ZQ3FqMzVNS0ZjcmpHY3RIdnFldGVRUHczQ2Vj?=
 =?utf-8?B?RlNKcHV1Y0pIQURhYVlGa3dsOG8vNGZqcG5mUTlZMk0rdkRzYTJxNnMrV2Ru?=
 =?utf-8?B?Nm9FYzdGWDNQUFRvL1pFQjJSOEUzY1RiRkNPUHFJbHVXekQxOHRpU25hdWZ0?=
 =?utf-8?B?SmJ0V3cvZ1BMcTBWTkpjejBBTXlmc0NSL0dKZW0wTFJ4bzJQM0lTRWh6U2lW?=
 =?utf-8?B?WFA3Nzdva0kyTTBJWUhWUk4zbFd0MUtMMGZHTDRONHE1NlhpTG0yTjJJVGxy?=
 =?utf-8?B?VjNzd0FGU1BpUnVDdVRzSmFyR2ltdU9iRmhaczI2eU1LSnA5Mi9ScjM3UFZG?=
 =?utf-8?B?cVdadTBxRUlQL3ZyZC9YVGg0a1J1MUx6d25JZU5sdEZZN0lrZHpUdDBmL04v?=
 =?utf-8?B?VlNYUmJIWmRhdUQrYnU3VFhvNVpqYWlSZkxQdS95amZ6SEVKZVJNT240c0Ru?=
 =?utf-8?B?bHRuY0NCNjBpa3FCSVRweWpwRVRTazUyblZhMkdRek5BUTd2RHptRGJBOUho?=
 =?utf-8?B?VENVYXZvajh1OG1KdnZoTGVOY3NoZS9JNlREVEdMR3E5SjJhdXNCSHAxeFBF?=
 =?utf-8?B?eG12NjdTdHpheXJ0ZVZCekJ5WktLcmQvNnZscjY1S1BoM002VTRqMm03b05J?=
 =?utf-8?B?SUF2SWJ3NjlZUkl1RzVQVjc5aHB6Tkp3VHd5NUNmOVJuTEgyc2JDeWZEcDhx?=
 =?utf-8?B?RUp0TDhZa3VGZnE0Z09JODRXVFloL2lRWS9iK1dMU3FLRHk5MjBsUVZ2L3do?=
 =?utf-8?B?V1JLOVcxMjJ4YjR4Rk5tdGRDRzRNbi9iYU1XRnpFT2xLK1V3VzVEUUxqYTU4?=
 =?utf-8?B?Tk1pY2J6TFFXN3ZQSFlrQ1duMHROOGt2RzhMTWZUU2pPWFJhZVdYYi9Hdjlx?=
 =?utf-8?B?djRBbHVxS3VoMExxQUdaK0QycGRxSjIzVldtQmJGUTRtQ1IvU2I3ajRTSitE?=
 =?utf-8?B?SkdKTWlxVDFINE0yeTNMVk9ESUx1WTlQNW1BaEVUZHlkZ21sZHQvOXBOSHYr?=
 =?utf-8?B?dmp6RmFHbVJZMllWUnpMUExOZ3BkV3hrM2NDQkNSalErRDdHOXdTNVc1UTQ1?=
 =?utf-8?B?cldaaFEwWmxYN2xHV2IwUTVFMWNXOTZaSHhlRktCKzRQOEJwNzhjU2o2VFJQ?=
 =?utf-8?B?bEVIOEg3anppRHFQYjNyUnExcHFsczgyUU5XNFF1V1psYW9TR0lGNU5xN0pV?=
 =?utf-8?B?N004VlBXcFlGUm52RmY5VGdZM0JpS1lXczVlZmd1MlNVeDZjTmhMVGVGaXpj?=
 =?utf-8?B?VmliMURINEpNdDVwbkVFNEtXQXArcjJ4K2E2cVhLZW1YQjFuMUs2NmtORjNT?=
 =?utf-8?B?d3lOanN6eUw2dlJCR1pIRkJPcTdhMTU3cm9uRm5rVFNIc1ZKQWxnbEJoMzFG?=
 =?utf-8?B?dUtrWEdHRm1hVmJuSTBseGdqR2RRM2s4YUhaM0gzbitBVWx1ZTBZZ0dVQnRM?=
 =?utf-8?B?VlptdDRrcVk2RjFxQVF1ZE5xMDdiMUcrb2xTczBpQjZoNVNKWTViTWQ3WXNK?=
 =?utf-8?B?L3NudUwvQjN0Z1lxVzZiNkk2aTFLMmJocTVhN09QbUpYNG9Qa1lYbmxQSGFp?=
 =?utf-8?B?aEJkNWsrdklMZ2pOcjdEUFpOemdDdDFjaVF5REV0aWkrY2J6OVpPcVg2eWM3?=
 =?utf-8?B?WU9WL1JHMXBjT1laOEhqRURRWjBVR1Q4V1NVTmYwcXlqNFRJb1QvQnVBeURF?=
 =?utf-8?B?bjBWWXJTcGQ2S1VnRHFHcmgwdjZPVmI1YklSc0g0WnZ2S2Q0aGwrNk1PN1dm?=
 =?utf-8?B?Q1ZLQ1g5cUVDNHhNTEUxMnNqWm9lSStsREwyclpUSXlwRXFVQnp4QlNIZ3Fw?=
 =?utf-8?B?bzN4SjQ1MDAwZVpycUV1NWtUUUp1TVRWOVBrUGxjTlNqU1YyNzZvd1VSdnBD?=
 =?utf-8?B?ZVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 394a016f-7b32-40d8-bd98-08dcfb96fe72
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2024 23:35:11.3492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JwUoFPokS4MHTr8pD+P4DXUvcTglWO0vDYybYN9blCGGKZpRCNXdBHnIkEXQe2yrSwY3Htdws0JxYszzR928xgr339DgosnL/uHhKt5p3kA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7770
X-OriginatorOrg: intel.com



On 11/1/2024 7:52 PM, Joe Damato wrote:
> From: Martin Karsten <mkarsten@uwaterloo.ca>
> 
> When events are reported to userland and prefer_busy_poll is set, irqs
> are temporarily suspended using napi_suspend_irqs.
> 
> If no events are found and ep_poll would go to sleep, irq suspension is
> cancelled using napi_resume_irqs.
> 
> Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
> Co-developed-by: Joe Damato <jdamato@fastly.com>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Tested-by: Joe Damato <jdamato@fastly.com>
> Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> ---

Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>

