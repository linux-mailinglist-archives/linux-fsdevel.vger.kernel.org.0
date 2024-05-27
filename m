Return-Path: <linux-fsdevel+bounces-20206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AC28CF943
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 08:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3C4728177B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 06:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E9C17555;
	Mon, 27 May 2024 06:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ndcTtwpj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59762EAF0;
	Mon, 27 May 2024 06:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716791854; cv=fail; b=nRbbgi3kIGf2N6IhNxEhqDxPnJchcuFOkuXO+9XvDS7GHIkeNVKzMZXMD95hwiploayzTDNBn8DkpcQ2aCX8qd3VYTTQHaCJXFz+voAJlIUUb8R7R26Pxwj7aFptjSbtWDIznvsS6C1MOwDyWkY13epmli+ylKoomX2vRvy7uGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716791854; c=relaxed/simple;
	bh=dAezSRRP9ch7G0ZgGy+/l0y6amUG40FMqh7eKhsir9s=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rCHsO9NFrelDyUbvw7O0tJLtQzZKeU4l7aawJygQ9p7tRVfc1h4CA2sfEnk5hGt+zv+9JGcojuwYNlSE/h0zyQRsbIg4fj1b9UvOSEV5JeWip5Wzvbj+gHZLftq4Xr2a2F8jE/ZRhF2WQnKz5u8iDuk1PY+ojJJ1J7ZtrklugF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ndcTtwpj; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716791853; x=1748327853;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=dAezSRRP9ch7G0ZgGy+/l0y6amUG40FMqh7eKhsir9s=;
  b=ndcTtwpjtGH5WGM65NkFFEN2aIwKV+90j1446jhnnlSWdfaWHSzDQSBQ
   ggltn608lOGXqziVdfsrxSEdBO9y5N82lTCcAVRQgo/h/9i3+Mpzy7XAD
   aBp6JIoJEf9bFOcY4WC5FrFQa0TerLyDZAxMu+byGM11+B4kgPWhMQRBX
   93Ic2xYI5/fNFDnCqxQJ5XT961GGFSZip/9A1GoW/dWr3cU1IOXd+qtRL
   SfC3iDfPgIcOj7Lj5ih+T9tK9m0QZ7tkRbVG6/HO3c95JTloIu7VbnQbG
   ttTDTQlUcdvSKx5M/zE225x+2VIXF01vpR00n6ChOlI71jqAJmUIG0lOO
   Q==;
X-CSE-ConnectionGUID: NoU72EoVRpmfL9XBg1OzJg==
X-CSE-MsgGUID: sW8iSJFqR4eEiypSiI1ZRQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="16882037"
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="16882037"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2024 23:37:32 -0700
X-CSE-ConnectionGUID: CSeUlY9wSfCvT/NF5KaVdg==
X-CSE-MsgGUID: 7Ydq7jc7RJ2nEw+zVWyGww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="39507901"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 May 2024 23:37:32 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 26 May 2024 23:37:31 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 26 May 2024 23:37:31 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 26 May 2024 23:37:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlR+oXXlgM11rhSKXl58JaK5bA2qJnvHFG7FKMXt6fO/Ndq7lC9MiaMM4nfMRyJuNR+T9E0RVnqWXfzUG/lJICiOr4eNZgtd51IrtIJKnhfE8FxF60yBJtavFgCljY5Z3lvwdpRTIroSfk67IhNBVE9Hjj3GqDx7+tON1/lOu1dsVgVfhpWDeLVjNZ+Xl++FmiaEHzpUqFYnyCw24+CASM99VHTG9t7L8jZYEZSJr5rws2KptsF91+eFlJJVrZ18Li2SeZpeEr17a2mMbokxeCSL6r3WJmKjbHvJDyHDiJjCrj5ad2cctKDrCiL8xUnXR2mzCPZvPb4RPdIZUqahFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KiOQS7MsbVMFWXn1KVR+6ygeO8ySHez25iBg6X+qCUE=;
 b=LwgBPP+b9oqiqAaTXqTe96c2qhAlNzDK//uagz2gU0p7BOEyuh+DIZ2vBkixdz0gbKllG/Ib0RY9DRcxPDlW26T2TEyY7/zSpSfKgeCWRTBhFQfhUHRofTeFp7kPpce43givNiRMG0dDvpDCKPSJSO7x6+hp8c9Bww7tytrsdapQoA569K0hbuvsb6BgZDnTtVVO3fezzWlkBZepVL1BkjeTt0ypx/CU9C2bLMacN/P/C+3ChVCw3w9td6fMa/mR3EVu6cQ6Wp6lWzBYYvR6d1oFVBggBxpX4aqUxJ2Uzq0KRr4GSpGF83KkFx6lWGzlQXjbuYmJHFYBC+BxFWsKGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB7287.namprd11.prod.outlook.com (2603:10b6:8:13f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 06:37:29 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 06:37:29 +0000
Date: Mon, 27 May 2024 14:37:17 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Dave Chinner
	<david@fromorbit.com>, <linux-ext4@vger.kernel.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ritesh.list@gmail.com>, <yi.zhang@huawei.com>, <yi.zhang@huaweicloud.com>,
	<chengzhihao1@huawei.com>, <yukuai3@huawei.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH] ext4/jbd2: drop jbd2_transaction_committed()
Message-ID: <202405271406.9b9763f6-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240513072119.2335346-1-yi.zhang@huaweicloud.com>
X-ClientProxiedBy: SI1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB7287:EE_
X-MS-Office365-Filtering-Correlation-Id: 99765554-82cc-482d-690e-08dc7e177aa7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?8KkgyvDbeWN7t6Vvd28lPp0V97ieu6UeuUVwr2vNPoyiY3o593nKyqvMqm?=
 =?iso-8859-1?Q?baha05lb8/dCLJmWHsE4ynyphLn2EWfHqIFrdPgVZHuw3UvPB9VlGJFe0P?=
 =?iso-8859-1?Q?P/vL0pTqt00LbpCvmlWQmUb/9Hs09vJa0Vyr23bkTblNawVHb1+XlxLFW/?=
 =?iso-8859-1?Q?uqGjDlzLK98s5nupWmiX6a/N0HPwPl9+GNgvNCjkH9pCLmr5G9FF7o0aQ+?=
 =?iso-8859-1?Q?SKj6xIMFfd+6nSgUETx22LK8ERrtZagRPi0CRDqDXvLc9rq9aiDLlVaL5p?=
 =?iso-8859-1?Q?7DqrDXBCAebJ53P0EcY5ARqZ9uW/JUF+45XE45HCcRU0LwNkI/lFm6J3yf?=
 =?iso-8859-1?Q?0kMSr6/UjcwUgJ00xXQFC8uGR4qqoj8qwAKhWy8anZ11ZGbrt5jCCJX5K9?=
 =?iso-8859-1?Q?wRt7a+vMrBgqfFlYtmC7J2NpJcB8IqNAtX5sfu+LPEkm/eX0HV1KhgcRyi?=
 =?iso-8859-1?Q?ol7bCD3UL5qSutmPMW4E/E0lcN8I+yfvVW5N6Mt/WYp9OUWInpaasD+Yor?=
 =?iso-8859-1?Q?+av1veyZ04o+sLst7WvgcurI6Qnjm5jzDd8gEG9b6aFdFBw4In5slZEtgY?=
 =?iso-8859-1?Q?GY97fxJU3waSHfD5K5NkweqC1MU8mTGDp1NNvt6YHoQQOTllWyR0Hyz6v+?=
 =?iso-8859-1?Q?/FSnddIdOVu1OKkfYO/bXl84fj7fTWd1yy2yk11C7PR+X3WZvSPfgN/EAk?=
 =?iso-8859-1?Q?YM3OtTJ4LO5iXtJLEwPfy69td2NelPul/XcETPRak/ESlnJRvhjM5dWzdp?=
 =?iso-8859-1?Q?XIq+08u2a08Z0izMGQ/RX0FBIRv5oe14aXh5vQioVjDKnYF7B0uQH7T86s?=
 =?iso-8859-1?Q?fkIR1JEJLBpAMuFIWH7QfsKICgjbdP54Yv1y1dEjQwoK+VNCE9ie0hdTJk?=
 =?iso-8859-1?Q?U5/D/XQA6Zz14o0VLK44c1R6HYvb6hkA+Cq+GD4I53WJbV7BBGCftoqSvX?=
 =?iso-8859-1?Q?xoyaT03ixEpOrKHXqzDXTK5EN0HKDKTYdJ3gMcXpUScnaHVAxh6b1CFVmn?=
 =?iso-8859-1?Q?IILBOIWv3njIKoTyV8ak/5FNAVu2Urg6JFca7tcb+Ft0zP4hlEqFKAlh+R?=
 =?iso-8859-1?Q?kpIVBtX2uIin4obItHcWSjVEMCDhWB2t2nrjLUcHDmeChNUDVyLN1l30qe?=
 =?iso-8859-1?Q?57QmCq7l9JEeLX6+JIzY7kwAA/gcnnjc/zKpD27itukatoiSqC6GIGeBrb?=
 =?iso-8859-1?Q?iRNVo2ZkEfdL3sfE0ho30jlAiPKokgtZNmQ18BGQ3psRSmCTTDsDWZbxl1?=
 =?iso-8859-1?Q?09CJFUH7M5Smyr+em2ICvOSvaJDNCaCWhXtzjv8lo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Y4AU1RVR6pSvgmxLKs7bxB7WENPH5N9KOXjr11WqkFA0qzCXUfGPJl6Ykg?=
 =?iso-8859-1?Q?A3L+nFANIyyqEG+83+IDXqgSQZHYWkirxBVXklr+D8w22Uu4Jh4Sr0d1pD?=
 =?iso-8859-1?Q?ohCpwsTNgQ8F7LyfjWYbemJUf72YiIVFmndzVMIv3D8VbaXe3J0CeMrbWJ?=
 =?iso-8859-1?Q?TuHKJ4E7uwIv61aDR1djCKeuVQj0Hjt5nx3KiK1tihypY8PTxcbPmHKQZp?=
 =?iso-8859-1?Q?fgWr3O/g7ZRnXYGqsNqNe7S7RJzDJR8CohdJfp/YB9PKDxXFPA8OXEfCXl?=
 =?iso-8859-1?Q?KJjyCpCCdUrBO02OcxiUpAjEKZSquxd66bI1CwqLYXXRFrZXX6yfPxCPVl?=
 =?iso-8859-1?Q?g2Ja0t8WcsLYX/URoGRnxOa3JcV412k/AsnshYdnbufhnGtootPDrfXW7w?=
 =?iso-8859-1?Q?shuEb6VZBPj4/1ZKYeNDJBm5TRcJGo7by2w8x/lBDZUYC5wHeKOzC3GdIN?=
 =?iso-8859-1?Q?r9Ir+y7mW2sFdyEsLuQCNGAdHBHFAqZ97sg0liDjFUfvEzXVqPp3V4ygwA?=
 =?iso-8859-1?Q?WA8vZBEdr45BAXwjYaaOZnmoDAgF8CKxz9WccheM+raMlTS17qdOYPKuOf?=
 =?iso-8859-1?Q?6XAZK+j5HCPxGeEeZb5kp/YOiZibM4FJoqhs0LraJIlXRmt7vS8BvtQpqL?=
 =?iso-8859-1?Q?Y3EPnjl5XSJEzjri7iiDKojB4HvDsz7a9b74NrD3lmqk3wee4qFozZJvf/?=
 =?iso-8859-1?Q?mRXDsGMOJ52bHunAf9OgLEdhgynEt5ZfXLdnxemL5LEJZ/HewMkdZEZsKX?=
 =?iso-8859-1?Q?ExbC4Uwxu0Wl376wprTf39AcndWLy8BGwVKGteH7LSVfDvbgHMkE+dA6E0?=
 =?iso-8859-1?Q?4bpXy4NV6oyItlkrIETQ5KzavQBx7aHURSkHZdt35I+HBVx44oJ/gboNsR?=
 =?iso-8859-1?Q?PO5RR4NLVIsO36mJSyYqiFuFv3XscyDERKYmgsDpPetndfo6GgtVsKRwRR?=
 =?iso-8859-1?Q?RlNZ650BGhE78IE/PGX2qaGgfG3QJ4u+PYepMtSArlu9tLv2ZJGXwkjfyz?=
 =?iso-8859-1?Q?9VR65HKnLHbJuLNTBFg9s72GlPE4TTwc8JMbZ0sEmgYOTO6+w3c3JqOMnc?=
 =?iso-8859-1?Q?B/drT5qZ+hrUKusDa/SjCNxK8jKaau1tlniMA7q85TKid68F8/q3zfMWFx?=
 =?iso-8859-1?Q?J4PKf/CuU4K2S5XbKT9bQlIWmcGxcyNODzDRFj9ASsiUwA6YhYOIWl+DiA?=
 =?iso-8859-1?Q?QgEmwbQd/LsS2p6u7IKUj5Sb7UmT9zHoO87zfbXYh4F3ijThDqzzEdgLgK?=
 =?iso-8859-1?Q?q03R7x7SiQoUnfwH7ES1z34wET7oNMmsrc0nFih7m7ruO/u5PoHIxu36me?=
 =?iso-8859-1?Q?qVH5bcepGSt3J7oXGhiOttLUaZgCTJVJ0vfUexVDZT9EC5yKPjcD3JVqA0?=
 =?iso-8859-1?Q?27kuoBc1xv/SDm1aursLZ7Qjrybde1g2YuKCisZ6l/xbi7rCxjsGACsYun?=
 =?iso-8859-1?Q?VQr+5wIq+iQYuem1fpb97HGiV0R2fphu0WOwQSDhgz4h2oCB/W82LMLX2S?=
 =?iso-8859-1?Q?p8wVhFlWuhv7sQIo5v3Og/u4HARQChFGAJT4Eq6DxWu6F5jayWYhGlXQiI?=
 =?iso-8859-1?Q?Di8RUAaAyW3pFo+ZqvSz3rOTOPI6LqBbVL85QJoKAq6m2HBzp4XoTqv5TK?=
 =?iso-8859-1?Q?XGAcg+HH3+Frr181n7OVAOo9rmH6QUqCvtWkh2A9A9T46fqxKLe4UENQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 99765554-82cc-482d-690e-08dc7e177aa7
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 06:37:29.1110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jbc1GeCvK70Pw/1LLtjP9YmOvjWUD94725mzCtdE0qJ9elh3SapTp5/PEJ4C9JC6lcQDDzilJsOvqrG+IGeNPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7287
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 674.0% improvement of stress-ng.fiemap.ops_per_sec on:


commit: 8a7952dd64b38f3ac2754ca550b52ac3ca921c1a ("[PATCH] ext4/jbd2: drop jbd2_transaction_committed()")
url: https://github.com/intel-lab-lkp/linux/commits/Zhang-Yi/ext4-jbd2-drop-jbd2_transaction_committed/20240513-153311
base: https://git.kernel.org/cgit/linux/kernel/git/tytso/ext4.git dev
patch link: https://lore.kernel.org/all/20240513072119.2335346-1-yi.zhang@huaweicloud.com/
patch subject: [PATCH] ext4/jbd2: drop jbd2_transaction_committed()

testcase: stress-ng
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	disk: 1HDD
	testtime: 60s
	fs: ext4
	test: fiemap
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240527/202405271406.9b9763f6-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-13/performance/1HDD/ext4/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/fiemap/stress-ng/60s

commit: 
  26770a717c ("jbd2: add prefix 'jbd2' for 'shrink_type'")
  8a7952dd64 ("ext4/jbd2: drop jbd2_transaction_committed()")

26770a717cac5704 8a7952dd64b38f3ac2754ca550b 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      1.13 ±  5%     +52.7%       1.73 ±  3%  iostat.cpu.user
      0.01 ± 47%      +0.0        0.04 ± 44%  mpstat.cpu.all.iowait%
      0.02 ±  4%      -0.0        0.01 ± 15%  mpstat.cpu.all.soft%
      1.15 ±  5%      +0.6        1.75 ±  3%  mpstat.cpu.all.usr%
    100427 ± 42%     -59.1%      41106 ± 66%  numa-vmstat.node0.nr_anon_pages
    149979 ± 34%    +205.2%     457720 ± 31%  numa-vmstat.node1.nr_inactive_anon
    149980 ± 34%    +205.2%     457720 ± 31%  numa-vmstat.node1.nr_zone_inactive_anon
    402376 ± 42%     -59.1%     164453 ± 66%  numa-meminfo.node0.AnonPages
    424656 ± 39%     -57.6%     180029 ± 58%  numa-meminfo.node0.AnonPages.max
    620453 ± 33%    +198.4%    1851452 ± 30%  numa-meminfo.node1.Inactive
    601997 ± 34%    +204.4%    1832749 ± 31%  numa-meminfo.node1.Inactive(anon)
      2387 ±  2%     +12.8%       2693 ±  4%  vmstat.io.bo
     10.17 ± 13%     +83.8%      18.69 ±  3%  vmstat.procs.b
    201402 ±  9%    +631.9%    1474068 ±  6%  vmstat.system.cs
    167899            +5.5%     177141        vmstat.system.in
    347.50 ± 16%     +53.4%     533.00 ± 10%  perf-c2c.DRAM.local
      4232 ± 48%    +166.1%      11262 ± 24%  perf-c2c.DRAM.remote
     23484 ± 10%    +119.8%      51621 ±  7%  perf-c2c.HITM.local
      3377 ± 56%    +179.0%       9424 ± 27%  perf-c2c.HITM.remote
     26861 ±  7%    +127.3%      61046 ±  5%  perf-c2c.HITM.total
   7612782 ±  7%    +676.3%   59099460 ±  6%  stress-ng.fiemap.ops
    124734 ±  8%    +674.0%     965466 ±  6%  stress-ng.fiemap.ops_per_sec
  12752270 ± 10%    +643.8%   94847653 ±  5%  stress-ng.time.involuntary_context_switches
     19.02 ±  6%    +124.6%      42.70 ±  5%  stress-ng.time.user_time
     62295           +17.8%      73411 ±  4%  stress-ng.time.voluntary_context_switches
    262799 ±  5%     +90.1%     499700 ± 43%  meminfo.Active
   3750501           +38.7%    5203048 ±  2%  meminfo.Cached
   3989040           +36.2%    5432649 ±  2%  meminfo.Committed_AS
   1154859 ±  3%    +105.8%    2376633 ± 12%  meminfo.Inactive
   1118790 ±  3%    +109.2%    2340758 ± 12%  meminfo.Inactive(anon)
    362491 ±  7%    +153.0%     917217 ± 19%  meminfo.Mapped
   5902699           +25.8%    7426870        meminfo.Memused
    546333 ±  3%    +265.7%    1998111 ±  5%  meminfo.Shmem
   5963280           +25.0%    7456799        meminfo.max_used_kB
      0.92 ± 16%     -21.5%       0.72 ±  8%  sched_debug.cfs_rq:/.h_nr_running.stddev
    809.29 ±  9%     -15.5%     683.50 ±  7%  sched_debug.cfs_rq:/.runnable_avg.stddev
    567.16 ± 10%    +123.7%       1268 ±  9%  sched_debug.cfs_rq:/.util_est.avg
      2015 ±  8%     +41.9%       2859 ± 11%  sched_debug.cfs_rq:/.util_est.max
      0.75 ±223%  +23377.8%     176.08 ± 20%  sched_debug.cfs_rq:/.util_est.min
    447.08 ±  8%     +19.1%     532.35 ± 12%  sched_debug.cfs_rq:/.util_est.stddev
      0.92 ± 16%     -22.1%       0.71 ±  8%  sched_debug.cpu.nr_running.stddev
    101043 ±  9%    +621.7%     729210 ±  5%  sched_debug.cpu.nr_switches.avg
    176826 ± 18%    +423.9%     926474 ±  5%  sched_debug.cpu.nr_switches.max
     17586 ± 35%    +762.4%     151656 ± 44%  sched_debug.cpu.nr_switches.min
     54968 ± 44%    +170.9%     148885 ±  5%  sched_debug.cpu.nr_switches.stddev
      5712            +5.1%       6002 ±  2%  proc-vmstat.nr_active_file
    939938           +38.6%    1302470 ±  2%  proc-vmstat.nr_file_pages
    280225 ±  3%    +108.7%     584958 ± 12%  proc-vmstat.nr_inactive_anon
     91383 ±  8%    +149.7%     228197 ± 19%  proc-vmstat.nr_mapped
    136324 ±  3%    +265.7%     498577 ±  5%  proc-vmstat.nr_shmem
     25123            +2.8%      25834        proc-vmstat.nr_slab_reclaimable
      5712            +5.1%       6002 ±  2%  proc-vmstat.nr_zone_active_file
    280225 ±  3%    +108.7%     584958 ± 12%  proc-vmstat.nr_zone_inactive_anon
     15324 ± 30%    +359.4%      70400 ±  9%  proc-vmstat.numa_hint_faults
     10098 ± 24%    +283.5%      38729 ± 19%  proc-vmstat.numa_hint_faults_local
    604637           +86.4%    1127295 ±  4%  proc-vmstat.numa_hit
    538359           +97.1%    1061202 ±  4%  proc-vmstat.numa_local
    532388           +13.4%     603511 ±  3%  proc-vmstat.numa_pte_updates
    723145           +72.1%    1244321 ±  3%  proc-vmstat.pgalloc_normal
    383685 ±  2%     +21.4%     465726 ±  2%  proc-vmstat.pgfault
    152450           +13.4%     172900 ±  4%  proc-vmstat.pgpgout
 2.951e+09 ±  6%    +571.9%  1.983e+10 ±  2%  perf-stat.i.branch-instructions
      0.64 ±  4%      -0.2        0.40 ±  2%  perf-stat.i.branch-miss-rate%
  19046341 ±  4%    +291.2%   74517781        perf-stat.i.branch-misses
   9666270 ± 31%    +318.8%   40484483 ± 19%  perf-stat.i.cache-misses
  70884859 ±  6%    +367.8%  3.316e+08 ±  2%  perf-stat.i.cache-references
    213832 ±  9%    +623.2%    1546476 ±  6%  perf-stat.i.context-switches
     15.20 ±  7%     -84.9%       2.30 ±  2%  perf-stat.i.cpi
    414.63 ±  5%     +10.9%     459.73 ±  8%  perf-stat.i.cpu-migrations
     26710 ± 31%     -77.7%       5960 ± 22%  perf-stat.i.cycles-between-cache-misses
 1.501e+10 ±  6%    +556.2%  9.849e+10 ±  2%  perf-stat.i.instructions
      0.07 ±  6%    +515.9%       0.44 ±  2%  perf-stat.i.ipc
      3.33 ±  9%    +626.6%      24.22 ±  6%  perf-stat.i.metric.K/sec
      4908 ±  3%     +26.6%       6216 ±  3%  perf-stat.i.minor-faults
      4908 ±  3%     +26.6%       6216 ±  3%  perf-stat.i.page-faults
      0.65 ±  5%      -0.3        0.38 ±  2%  perf-stat.overall.branch-miss-rate%
     15.14 ±  6%     -84.8%       2.30 ±  2%  perf-stat.overall.cpi
     25496 ± 29%     -77.2%       5824 ± 21%  perf-stat.overall.cycles-between-cache-misses
      0.07 ±  6%    +556.1%       0.44 ±  2%  perf-stat.overall.ipc
   2.9e+09 ±  6%    +572.3%   1.95e+10 ±  2%  perf-stat.ps.branch-instructions
  18850245 ±  4%    +289.0%   73330498        perf-stat.ps.branch-misses
   9571442 ± 31%    +315.9%   39805993 ± 19%  perf-stat.ps.cache-misses
  70175556 ±  6%    +365.5%  3.267e+08 ±  2%  perf-stat.ps.cache-references
    205492 ±  9%    +636.9%    1514212 ±  6%  perf-stat.ps.context-switches
    405.62 ±  5%     +10.8%     449.30 ±  8%  perf-stat.ps.cpu-migrations
 1.475e+10 ±  6%    +556.5%  9.684e+10 ±  2%  perf-stat.ps.instructions
      4823 ±  3%     +25.8%       6069 ±  4%  perf-stat.ps.minor-faults
      4823 ±  3%     +25.8%       6069 ±  4%  perf-stat.ps.page-faults
 9.213e+11 ±  6%    +555.4%  6.038e+12 ±  2%  perf-stat.total.instructions
     85.73           -85.7        0.00        perf-profile.calltrace.cycles-pp.jbd2_transaction_committed.ext4_set_iomap.ext4_iomap_begin_report.iomap_iter.iomap_fiemap
     86.11           -84.1        1.99 ±  2%  perf-profile.calltrace.cycles-pp.ext4_set_iomap.ext4_iomap_begin_report.iomap_iter.iomap_fiemap.do_vfs_ioctl
     50.51 ±  3%     -50.5        0.00        perf-profile.calltrace.cycles-pp._raw_read_lock.jbd2_transaction_committed.ext4_set_iomap.ext4_iomap_begin_report.iomap_iter
     96.50           -12.4       84.06        perf-profile.calltrace.cycles-pp.ext4_iomap_begin_report.iomap_iter.iomap_fiemap.do_vfs_ioctl.__x64_sys_ioctl
     97.49            -5.6       91.94        perf-profile.calltrace.cycles-pp.iomap_iter.iomap_fiemap.do_vfs_ioctl.__x64_sys_ioctl.do_syscall_64
     98.08            -1.5       96.62        perf-profile.calltrace.cycles-pp.iomap_fiemap.do_vfs_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
     98.13            -1.1       96.99        perf-profile.calltrace.cycles-pp.do_vfs_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
     98.14            -1.1       97.05        perf-profile.calltrace.cycles-pp.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
     98.18            -1.1       97.12        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
     98.19            -1.0       97.14        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.ioctl
     98.22            -0.9       97.31        perf-profile.calltrace.cycles-pp.ioctl
      0.62 ±  9%      +0.3        0.94        perf-profile.calltrace.cycles-pp.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.62 ±  9%      +0.3        0.96        perf-profile.calltrace.cycles-pp.schedule.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      0.70 ±  9%      +0.5        1.18        perf-profile.calltrace.cycles-pp.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      0.87 ±  8%      +0.7        1.58        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      0.87 ±  8%      +0.7        1.59        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__sched_yield
      0.00            +1.0        1.00 ±  4%  perf-profile.calltrace.cycles-pp.ext4_sb_block_valid.__check_block_validity.ext4_map_blocks.ext4_iomap_begin_report.iomap_iter
      0.94 ±  8%      +1.0        1.98 ±  2%  perf-profile.calltrace.cycles-pp.__sched_yield
      0.00            +1.1        1.10 ±  2%  perf-profile.calltrace.cycles-pp._copy_to_user.fiemap_fill_next_extent.iomap_fiemap.do_vfs_ioctl.__x64_sys_ioctl
      0.00            +1.3        1.35 ±  8%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.percpu_counter_add_batch.ext4_es_lookup_extent.ext4_map_blocks
      0.00            +1.5        1.48 ±  2%  perf-profile.calltrace.cycles-pp.__check_block_validity.ext4_map_blocks.ext4_iomap_begin_report.iomap_iter.iomap_fiemap
      0.00            +1.6        1.58 ±  7%  perf-profile.calltrace.cycles-pp._raw_spin_lock.percpu_counter_add_batch.ext4_es_lookup_extent.ext4_map_blocks.ext4_iomap_begin_report
      0.00            +3.2        3.22 ±  2%  perf-profile.calltrace.cycles-pp.fiemap_fill_next_extent.iomap_fiemap.do_vfs_ioctl.__x64_sys_ioctl.do_syscall_64
      4.96 ±  6%      +4.8        9.72 ±  2%  perf-profile.calltrace.cycles-pp._raw_read_lock.ext4_es_lookup_extent.ext4_map_blocks.ext4_iomap_begin_report.iomap_iter
      0.78 ±  7%      +5.4        6.22 ±  2%  perf-profile.calltrace.cycles-pp.iomap_iter_advance.iomap_iter.iomap_fiemap.do_vfs_ioctl.__x64_sys_ioctl
      0.62 ±  6%     +50.6       51.27        perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.ext4_es_lookup_extent.ext4_map_blocks.ext4_iomap_begin_report.iomap_iter
      9.55 ±  7%     +66.3       75.88        perf-profile.calltrace.cycles-pp.ext4_es_lookup_extent.ext4_map_blocks.ext4_iomap_begin_report.iomap_iter.iomap_fiemap
     10.12 ±  7%     +69.9       79.98        perf-profile.calltrace.cycles-pp.ext4_map_blocks.ext4_iomap_begin_report.iomap_iter.iomap_fiemap.do_vfs_ioctl
     85.84           -85.8        0.00        perf-profile.children.cycles-pp.jbd2_transaction_committed
     86.14           -84.0        2.10 ±  2%  perf-profile.children.cycles-pp.ext4_set_iomap
     55.59 ±  3%     -45.8        9.83 ±  2%  perf-profile.children.cycles-pp._raw_read_lock
     96.56           -12.1       84.50        perf-profile.children.cycles-pp.ext4_iomap_begin_report
     97.54            -5.3       92.26        perf-profile.children.cycles-pp.iomap_iter
     98.11            -1.3       96.84        perf-profile.children.cycles-pp.iomap_fiemap
     98.14            -1.1       97.00        perf-profile.children.cycles-pp.do_vfs_ioctl
     98.14            -1.1       97.06        perf-profile.children.cycles-pp.__x64_sys_ioctl
     98.22            -0.9       97.34        perf-profile.children.cycles-pp.ioctl
     99.42            -0.7       98.76        perf-profile.children.cycles-pp.do_syscall_64
     99.43            -0.6       98.81        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.39 ± 21%      -0.1        0.25 ±  6%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.14 ± 24%      -0.1        0.03 ±105%  perf-profile.children.cycles-pp.build_id__mark_dso_hit
      0.19 ±  5%      +0.0        0.21 ±  6%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.08 ± 13%      +0.0        0.11        perf-profile.children.cycles-pp.switch_fpu_return
      0.09 ±  7%      +0.0        0.12 ±  5%  perf-profile.children.cycles-pp.update_process_times
      0.11 ±  5%      +0.0        0.14 ±  6%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.10 ±  5%      +0.0        0.14 ±  5%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__fdget
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.___perf_sw_event
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.__dequeue_entity
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.__switch_to_asm
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.pick_eevdf
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.__switch_to
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.00            +0.1        0.08 ±  4%  perf-profile.children.cycles-pp.rseq_ip_fixup
      0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      0.27 ± 22%      +0.1        0.37 ±  9%  perf-profile.children.cycles-pp.perf_session__process_events
      0.27 ± 22%      +0.1        0.37 ±  9%  perf-profile.children.cycles-pp.record__finish_output
      0.26 ± 25%      +0.1        0.36 ±  9%  perf-profile.children.cycles-pp.reader__read_event
      0.00            +0.1        0.11 ±  3%  perf-profile.children.cycles-pp.set_next_entity
      0.00            +0.1        0.12 ±  4%  perf-profile.children.cycles-pp.update_load_avg
      0.08 ±  6%      +0.1        0.20        perf-profile.children.cycles-pp.do_sched_yield
      0.00            +0.1        0.12 ±  4%  perf-profile.children.cycles-pp.put_prev_entity
      0.02 ±141%      +0.1        0.15 ±  2%  perf-profile.children.cycles-pp.update_curr
      0.09 ± 36%      +0.1        0.23 ± 18%  perf-profile.children.cycles-pp.process_simple
      0.00            +0.1        0.15 ±  3%  perf-profile.children.cycles-pp.__rseq_handle_notify_resume
      0.07 ± 57%      +0.1        0.22 ± 19%  perf-profile.children.cycles-pp.queue_event
      0.00            +0.1        0.15 ±  4%  perf-profile.children.cycles-pp.clear_bhb_loop
      0.00            +0.1        0.15 ±  4%  perf-profile.children.cycles-pp.stress_fiemap
      0.07 ± 57%      +0.2        0.22 ± 19%  perf-profile.children.cycles-pp.ordered_events__queue
      0.00            +0.2        0.16 ±  2%  perf-profile.children.cycles-pp.yield_task_fair
      0.00            +0.2        0.16 ±  3%  perf-profile.children.cycles-pp.ext4_inode_block_valid
      0.20 ±  5%      +0.2        0.41        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.09 ± 10%      +0.3        0.38 ±  2%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.62 ±  9%      +0.3        0.95        perf-profile.children.cycles-pp.__schedule
      0.63 ± 10%      +0.3        0.97        perf-profile.children.cycles-pp.schedule
      0.06 ± 11%      +0.4        0.48 ±  3%  perf-profile.children.cycles-pp.iomap_to_fiemap
      0.70 ±  9%      +0.5        1.18        perf-profile.children.cycles-pp.__x64_sys_sched_yield
      0.13 ±  8%      +0.9        1.05 ±  3%  perf-profile.children.cycles-pp.ext4_sb_block_valid
      0.94 ±  8%      +1.1        2.03 ±  2%  perf-profile.children.cycles-pp.__sched_yield
      0.16 ±  7%      +1.1        1.27 ±  2%  perf-profile.children.cycles-pp._copy_to_user
      0.20 ±  8%      +1.4        1.59 ±  2%  perf-profile.children.cycles-pp.__check_block_validity
      0.20 ±  7%      +1.4        1.64 ±  7%  perf-profile.children.cycles-pp._raw_spin_lock
      0.41 ±  7%      +2.9        3.30 ±  2%  perf-profile.children.cycles-pp.fiemap_fill_next_extent
      0.80 ±  7%      +5.6        6.35 ±  2%  perf-profile.children.cycles-pp.iomap_iter_advance
      0.64 ±  7%     +50.8       51.40        perf-profile.children.cycles-pp.percpu_counter_add_batch
      9.60 ±  7%     +66.7       76.28        perf-profile.children.cycles-pp.ext4_es_lookup_extent
     10.16 ±  7%     +70.2       80.39        perf-profile.children.cycles-pp.ext4_map_blocks
     55.43 ±  3%     -45.7        9.70 ±  2%  perf-profile.self.cycles-pp._raw_read_lock
     34.41 ±  6%     -34.4        0.00        perf-profile.self.cycles-pp.jbd2_transaction_committed
      0.10 ± 10%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.prepare_task_switch
      0.08 ± 11%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.__schedule
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.___perf_sw_event
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.__update_load_avg_se
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.update_curr
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.00            +0.1        0.06 ± 13%  perf-profile.self.cycles-pp.__sched_yield
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.__switch_to_asm
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.__switch_to
      0.20 ±  7%      +0.1        0.28 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock
      0.00            +0.1        0.09 ±  4%  perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.00            +0.1        0.11 ±  4%  perf-profile.self.cycles-pp.ext4_inode_block_valid
      0.00            +0.1        0.13 ±  5%  perf-profile.self.cycles-pp.stress_fiemap
      0.07 ± 57%      +0.1        0.22 ± 19%  perf-profile.self.cycles-pp.queue_event
      0.00            +0.1        0.15 ±  4%  perf-profile.self.cycles-pp.clear_bhb_loop
      0.05 ± 45%      +0.3        0.38 ±  2%  perf-profile.self.cycles-pp.__check_block_validity
      0.03 ± 70%      +0.3        0.38 ±  3%  perf-profile.self.cycles-pp.iomap_to_fiemap
      0.13 ±  7%      +0.9        1.00 ±  4%  perf-profile.self.cycles-pp.ext4_sb_block_valid
      0.13 ±  7%      +0.9        1.05 ±  2%  perf-profile.self.cycles-pp.iomap_fiemap
      0.16 ±  7%      +1.1        1.24 ±  2%  perf-profile.self.cycles-pp._copy_to_user
      0.19 ±  7%      +1.3        1.52 ±  2%  perf-profile.self.cycles-pp.iomap_iter
      0.29 ± 11%      +1.6        1.88 ±  2%  perf-profile.self.cycles-pp.ext4_set_iomap
      0.25 ±  8%      +1.8        2.04 ±  2%  perf-profile.self.cycles-pp.fiemap_fill_next_extent
      0.27 ±  8%      +1.9        2.21 ±  2%  perf-profile.self.cycles-pp.ext4_iomap_begin_report
      0.38 ± 13%      +2.3        2.70 ±  4%  perf-profile.self.cycles-pp.ext4_map_blocks
      0.78 ±  7%      +5.4        6.23 ±  2%  perf-profile.self.cycles-pp.iomap_iter_advance
      3.98 ±  8%     +11.1       15.12 ±  2%  perf-profile.self.cycles-pp.ext4_es_lookup_extent
      0.56 ±  7%     +48.9       49.48        perf-profile.self.cycles-pp.percpu_counter_add_batch




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


