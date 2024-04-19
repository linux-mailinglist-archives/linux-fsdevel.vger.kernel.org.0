Return-Path: <linux-fsdevel+bounces-17288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5909E8AAFAD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 15:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F7212830B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 13:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196B012C817;
	Fri, 19 Apr 2024 13:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GbUwI2Jj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C07BE66;
	Fri, 19 Apr 2024 13:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713534469; cv=fail; b=F5LhzAYFON6QDJfpQX9MOj53zVUEB69t/DjocPcn1X+Gbe0svyNCC4m+vkkNTS3UbwOlGC5e9TVX05TWK6Uha0R2I2iz8rjSVoMzf5UVXO6puvDF3tMqVs4wEiRADe6yIO3d9TXqq+dvH/eGmQsP5MdrbC6Hax3pAh/fRUXtgEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713534469; c=relaxed/simple;
	bh=Bn+g8RbWmto8aqbTTYM3QjT/t8xRB8bEzlUUSLiGpRE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D7R9ocfpKqZW/M5HIWT6/jIeqIfs7rhqo/BgeHBtZVeJBVGCWbiV0Wm8kAiIuDZKzGX1C10RrA+ShFunUJVLX0sybaMSwNGB2j297/1HX2oYPtE0cHv9aZRiNsxTsuKAIp4j2YLs69e6G4S3S5Es/JR98oU22YA/MNDEwGrkipE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GbUwI2Jj; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713534467; x=1745070467;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Bn+g8RbWmto8aqbTTYM3QjT/t8xRB8bEzlUUSLiGpRE=;
  b=GbUwI2JjWHemJVH80Q70K4Wqk63xC2CT+AsHVp9a1uYfMVX8D69Z7w0P
   ZF4h4FSWvHfJ1OT9/GPc0RhwlHszAdzn6WPjGol9ccGGcu3pAwBTeQIM7
   2t8nAXiLOfq++PLsa5oaULWKKKKOLWyD3ibWlEz517M2pJWCzDvtRJZKM
   HrBA4Jmr6n0N/U+B8gOWTDHrktATJlB/Kbs0ESsVpspKcAe/bCgjGiWpq
   wZ3SZJUiXbubwf1ekLWiy2k5sHYxzbhKcxB+rQjLmWVDdNYXqn0FrKqTy
   wSKGAx/1+Mj9yN0ccZDbXVDutrmy13e0N0ik6Cl/lBBGBF4chT6mj5daE
   Q==;
X-CSE-ConnectionGUID: tzeKkEtVSyiAFi4MwMzSFw==
X-CSE-MsgGUID: RXHMX6O0Qn6X9WA66JDAzg==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="31617651"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="31617651"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 06:47:47 -0700
X-CSE-ConnectionGUID: C5jaKtuEQoii+6nMaNlbVg==
X-CSE-MsgGUID: V2Xqs5cxRJWxUL8f7hje2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="23393679"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Apr 2024 06:47:46 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Apr 2024 06:47:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Apr 2024 06:47:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 19 Apr 2024 06:47:45 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 06:47:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B14KeDolmdLo7JjZBMb5qz42jb8Qwt2jRXb4/Rd02/A7ShQyyqQEyTSIH1nQKq6keazbK3UaHImZes3rEmuLmoZYF/H+qhrmxmU/NvyPbE/+zLR32nMN7J25gk63NsDF4VydQH7/xHVpj49r5SenJPQRhnjDv9Etrld2ZZgjzIi8YbAdT8Zfuf9y44c8xigwr5t2LPWKuosBnB7+BFB7QWZkOIDLgcHRitIjfBMrQG8Ab3E4FuoqY4Iou9LNgZkWSBs335dDnFq9KPPMChWxp/eApJyMc+WUH7RmeJksrDYhRrFk7mQS0BLjTPOfTMDxxACZGVyJvK9Tqs/UDNaKsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7aUfhomKlQCqaPylFPObE8eG8DYwRwntHauFYQS+hLM=;
 b=Q5rko2Skdgkcm06J907YZ7ksG4vpqDBut8BxlLeAl3VxWHzeE/L1UdBFdIFAb3SEdvzM9VZKF6HQAgY5FtfJ/D7tcnqqMbprNrLnJBCw/5YoJEkR0B+1WhOtW4Ipx02IllNEkop2Qr6JQr/JmIgK0I4Is5KyOUK14wniSefbdNL5dzujFwIZp7DAm3Jdlh/+UcbCuk5otiAlmE66Y7EyvPuolBBGTfUh6K8d3sAM71lze2TT2mwQ9Pesuxt9RZVGSvUErWXuBFiNIox5/C5vdgOn33M3FZoocOGW1J4q/4BWRUiB6HoXBzQa/OrtflzlfNxZOs36WLeGN0pnJF3GZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by PH8PR11MB6707.namprd11.prod.outlook.com (2603:10b6:510:1c6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Fri, 19 Apr
 2024 13:47:43 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::65ce:9835:2c02:b61b]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::65ce:9835:2c02:b61b%7]) with mapi id 15.20.7472.025; Fri, 19 Apr 2024
 13:47:43 +0000
Message-ID: <17c68728-9125-4597-9e3e-764b209edcd7@intel.com>
Date: Fri, 19 Apr 2024 21:47:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/18] mm: improve folio_likely_mapped_shared() using
 the mapcount of large folios
To: David Hildenbrand <david@redhat.com>, <linux-kernel@vger.kernel.org>
CC: <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
	<cgroups@vger.kernel.org>, <linux-sh@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)"
	<willy@infradead.org>, Peter Xu <peterx@redhat.com>, Ryan Roberts
	<ryan.roberts@arm.com>, Yang Shi <shy828301@gmail.com>, Zi Yan
	<ziy@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Hugh Dickins
	<hughd@google.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
	<dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, "Muchun
 Song" <muchun.song@linux.dev>, Miaohe Lin <linmiaohe@huawei.com>, "Naoya
 Horiguchi" <naoya.horiguchi@nec.com>, Richard Chang <richardycc@google.com>
References: <20240409192301.907377-1-david@redhat.com>
 <20240409192301.907377-6-david@redhat.com>
 <b05cdac2-84f2-4727-af6c-3b666e6add14@intel.com>
 <7a8eb8c0-35e5-4f45-bdd5-11a775ae752d@redhat.com>
Content-Language: en-US
From: "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <7a8eb8c0-35e5-4f45-bdd5-11a775ae752d@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0325.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::8) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|PH8PR11MB6707:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ea7e921-2cc8-402d-4a35-08dc6077493a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B095LejE0P1j7I/ha2MObppl9hghkYYrs5gfhdjD1wK4aOsiPvIBeQrLJ2OD9TnrCd+XZ+3sU3RLYJX2jed/DqmmTougFETP9FKCZg+upDBOX4Vnns4z8H+9G7vaRJlDi5nEboYXlJnQl6J3pffsrxwtp77GNSjHW1AzalGsbMQtt44UN3DcnRULNjPZSjphskf3fZNUfIj1QVg/3XpFO+0FPC0WGa6qYNJ8vXq09VEt2e5o5cDMALfSmto8uRXskm3/E1XJI83QYyLd9tqB6r8zESDqXFZw/FUXTGxG3C52SHuya0KcyaRD4N8EoU1feCMQwlm+mbYr5Nj6wO4b0NSjuoUHqgy8g166Wt69i9s5J1E0Owc0T79okLEwcZdM9E2bwomvTqt4Ws3q3z5D0mMqFituq/AeUhJ1l7aQttqG4y4ttnFihdcmxNdLUUYF469IstfPMmYZKpqen2aONOUIY+Z8aygrYRln2owLG4JmXd9DxdGAGUywbKUEnxr4Upj7QcShQ+ElDjP8+We53Uo+WFDhlqvHxFGllnmf0yM1Spynd+7dZjjIOjJYzn59NCAIN6RIc3IakHknhtaEzyaws4w9ZbU7Z3Pu8Jxn2vm7AcPmr+AhEdVCcQZJ0aLjqGJ5sChyrUyVZIJ5t+2pCOdfqVFtWKXD4zRNxX1i2dA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGlPdXFWMmoxYVlMMHM5cm9ocWFLQTFiQnlJcG1Na2tOY2Z0RGF6MFNCL0lq?=
 =?utf-8?B?aHFjb3pUbVo3ZDQ3bW1SRUZ4SEdKbzVRUGtMQ0V4b09OVlVpeVJEWXdLNlBY?=
 =?utf-8?B?T2xjckltcGN2bXJkNEpLWm5uWDZwUkNZRCtQME9LN0FHeTFwV04wUXpWeVRo?=
 =?utf-8?B?UGtaWHlHRTcvQVdBNXphVEdKdHVvRXRiUVpnQ0hzOXB6MWlxRFpWcGxzSm1U?=
 =?utf-8?B?UGFZSEx1WHhaYU9tWkxGbjVrenpHME9wclZxd3ppbll0VkhQWWdjanh3T0pW?=
 =?utf-8?B?Nm9sSFRnRzV6SVYwTDl0OGpwdy84WHpGWTNSWXpPZzdlb1JTZm1ScGFWTXhY?=
 =?utf-8?B?akVMWldMS08xM2h0TktUdFJGSEp1dDBTQkNOZ2QybjFJTVJZSkF3OUpoUzIy?=
 =?utf-8?B?SXlKVTlKUTlLc3liSHZ6aHVmRU0rWnFoSjBiTnZwQkVTOGx5Y2w4ZnVEeSs3?=
 =?utf-8?B?WjhkL2Z6V1FTWk85Uy9OWGlqOVN6akRsc0FQVFREZG9WTlI0RlhFR1ZoUGNj?=
 =?utf-8?B?ajJmNDZ0VjlFSS82Mmg4SGwwQnJFVEhpMjlPY09NT2JqWDFMekpXR1l1R2hQ?=
 =?utf-8?B?Zk9aTFhSU2EwTGY2eC8ybEd1L096ME9PdzdTNFRXU2lPNmJYeWlHd0lJdUlI?=
 =?utf-8?B?enErMk42UjZOQ3NVZHNlSkdmZkM0dy85OWZ3UG9sVFRsYTlCbjJkYWl0cHBQ?=
 =?utf-8?B?dEp4WFk3VDRkN1E5Wk9VYTRmUEMrRzJWajNReWJtdjJCSDFhemVMQ2Y5Mkhw?=
 =?utf-8?B?bEZ5U1NhV0lUaHpqS3cxcTRzcndKVzBBWmk2bE8wVGpDZmNMQnkreEdsaUZy?=
 =?utf-8?B?dmtFY0RVeVlyTnVCQi8reEVaQVhSTktpSVhWNWY1a0VkMHJFNWFMKzBuNHpP?=
 =?utf-8?B?dFZGUzY5OGhpMEpRRGhVYU1Wa0k1RjhZUUJmLytvOW5JVlpQcjA5Z1R0NzZX?=
 =?utf-8?B?VnNET0J3VDhUem4rRlRDMUFmMmpsUVlwbGVpdlhvQjVzSTlTaHFzdDBlMDlO?=
 =?utf-8?B?UVY0WExGZ2Nra0xxMnlodlVkVW5SeGI1cy9NZXVVU0g1Yk1EOXJyRDJCSWJw?=
 =?utf-8?B?Y0xpQmo5b2puLzViaHM1TXI1NU41ZHhJUDU2cTE1ei9Ld1YyOStzQzJTZVBp?=
 =?utf-8?B?d3dkcXNiVjh5cWs1azVlbFh4Mkpaa2s0MXBmekRLRmRTRGp0LzdFcjZTSDFp?=
 =?utf-8?B?MlM2K1N4WlNDSGNpZnVuSFRtMXlQNXVRdGo3ejFXQVJoSEIvZnk0NDlXUk82?=
 =?utf-8?B?cThxT2VuWkQwVUFFVUJwUkpMNE9pek9aaFVGbkM2RjRDN3NUWTFZejBhUzRk?=
 =?utf-8?B?S3d0aExwVTBmSGtOQ3RneXNlSDRqWGlPVDVZN1h0OW9ZSGlCRFlNSXhyRENp?=
 =?utf-8?B?ZnR6cEg5VkRSRzU4dFVMZWtDUko5TlQ3VThPK3VSN05HYVNiYjkwK1FGeCti?=
 =?utf-8?B?SFpjNFJVVGIxQmhselhpejN2WCtya2gxWTlHQ1N5OG9PakgyUUV0TFZjMzJ5?=
 =?utf-8?B?c3dsbVlrWHhyRDRjSWs5d2hQb1lETzB3NXdKQk5zcHhHTy9wcnoxYXIwTEJ6?=
 =?utf-8?B?Q1RxUWRCSWduQXVSQitOekNmRGdlTXpQT0FTaFBoYk9iV3JlQkl0MGNicUJ0?=
 =?utf-8?B?NmxkeG8wVjVEWmttVHIzcXVtc2tVcTF6UVhCTWp3RTJGaDRKTE9hNkR6NGUv?=
 =?utf-8?B?cGo3RWdEQU0wOUV4SzkzL3c0MHhOWjNOdUhkOElKVEQwcHQyZHVqbWZVcURL?=
 =?utf-8?B?TkpIUFpJcTlPVUhHNmJBMmdodnZHZlNsSUZiRFR0MGpOVUpCNzVITk9JcjJi?=
 =?utf-8?B?ei9JSEl2V2J3dTVlTHltNE1QMUZ5MWZ5RHB0RUR2cHU4YTdNTkd6clVCTHVv?=
 =?utf-8?B?b1NGWFAvbXNWRzUrQ3hUY1lYRkxXT3M0ZWJKcUprVTNTTWpFUEhFT25NRTBZ?=
 =?utf-8?B?T0VHcXJ4V3ZReDlWZlFHTTV3ZGM5M2xHTlorWjVSR0dMUTRoNk40SEF0RWd2?=
 =?utf-8?B?QzFjVjU5OU5lNDR0azFXelJ2VUtIRzVWOHppTnFobFVoYVhXMnR2dkFsRDZr?=
 =?utf-8?B?eFNCc1NzcEMzOHAxUTBkc1lRMTVuMDhSOGR5WEV5ZEVBa01sbjc2SVBHRW1U?=
 =?utf-8?Q?A8DkF2WtxYVo3nfBV/31Y1/RX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea7e921-2cc8-402d-4a35-08dc6077493a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 13:47:43.2617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 31PNlTsF/DvDgVBO60eYNKKRMLIdFkH8JxkDtqzY7jp6zy3vBfznMnutp1BImUrEMmidVzgzLZeMAxZTwKCaPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6707
X-OriginatorOrg: intel.com



On 4/19/2024 5:19 PM, David Hildenbrand wrote:
> On 19.04.24 04:29, Yin, Fengwei wrote:
>>
>>
>> On 4/10/2024 3:22 AM, David Hildenbrand wrote:
>>> @@ -2200,7 +2200,22 @@ static inline size_t folio_size(struct folio 
>>> *folio)
>>>     */
>>>    static inline bool folio_likely_mapped_shared(struct folio *folio)
>>>    {
>>> -    return page_mapcount(folio_page(folio, 0)) > 1;
>>> +    int mapcount = folio_mapcount(folio);
>>> +
>>> +    /* Only partially-mappable folios require more care. */
>>> +    if (!folio_test_large(folio) || 
>>> unlikely(folio_test_hugetlb(folio)))
>>> +        return mapcount > 1;
>> My understanding is that mapcount > folio_nr_pages(folio) can cover
>> order 0 folio. And also folio_entire_mapcount() can cover hugetlb (I am
>> not 100% sure for this one).  I am wondering whether we can drop above
>> two lines? Thanks.
> 
> folio_entire_mapcount() does not apply to small folios, so we must not 
> call that for small folios.
Right. I missed this part. Thanks for clarification.


Regards
Yin, Fengwei

> 
> Regarding hugetlb, subpage mapcounts are completely unused, except 
> subpage 0 mapcount, which is now *always* negative (storing a page type) 
> -- so there is no trusting on that value at all.
> 
> So in the end, it all looked cleanest when only special-casing on 
> partially-mappable folios where we know the entire mapcount exists and 
> we know that subapge mapcount 0 actually stores something reasonable 
> (not a type).
> 
> Thanks!
> 

