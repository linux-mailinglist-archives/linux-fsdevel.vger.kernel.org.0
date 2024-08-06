Return-Path: <linux-fsdevel+bounces-25104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AEA949253
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 15:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64725B2CF20
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 13:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC871D54F1;
	Tue,  6 Aug 2024 13:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SB1HuP5N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC86A1D2F7B;
	Tue,  6 Aug 2024 13:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722951889; cv=fail; b=T+V+Mk26HNZ+ITvZUgwwBnyrabhDXP/N3W+eC82F9CShtjfLB4otzLFE+xg/Dw1uxfnLma6MaUjm/U+oCGq5ScQSbSlqJ4kA4FKmjR9rW6sZr0R47F5Q5sxMn5OOREmr7YK8JHAoKw3gaV+/BNVJKbGJrL91YTH3P2KSdemMZCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722951889; c=relaxed/simple;
	bh=c08DB0fUippIgNUnQj+VI3nCWNsECnmb+h5rH8XjeS0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jxjG0JYkhA1ZusNXrkcrKAUWp7OGLSK4pCKHN45UNeSff0FYXA4OQNcdCwuhABrWwS6kQOyzwpQ4SONgSw2tB+C3/Byd2EulkDnqMI0SOIMfro8QSswJUWLrYTS50AVPPFC+zrTZwrpxUWs9tt4Jyr0JanccXKC/GLI33sS34S4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SB1HuP5N; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722951887; x=1754487887;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=c08DB0fUippIgNUnQj+VI3nCWNsECnmb+h5rH8XjeS0=;
  b=SB1HuP5N3ao50yMgvLpzCSHy/Unij7Hwk4Fsp/PZaOVsDHqL+C9u/3IG
   XbUykE58rKo4XNAyREkzidtTIkCNLhjKjHKWwxtBBE47/Gl8HTwcep3GK
   58eClr7/kcUQy/BgMwbhooQBKYeQkYqPVcomD0DF/7vSBuF5041yKzvsg
   QfareAil7LVx2iB8DoGWuegaurXJmsa+K10prlSLJ+ZhsyTByguVpd50I
   2G0rjqQllD9OQ1yi0nQAllpgYCqgVEiMzzMeM1E7gRtKpAUdrSa3zfAAo
   8/vnnUOiPOrOHHqe0jnzS7//RN/m1yuuVpstOob/6u7eXSYVamgrC2Wri
   A==;
X-CSE-ConnectionGUID: ONX2vKEySBu9WRlzLV85Gw==
X-CSE-MsgGUID: xZvwXItsRPeNUrTKi40VqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="23883150"
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="23883150"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 06:44:46 -0700
X-CSE-ConnectionGUID: vkNm5v4lTxeZA/ywPQoLAQ==
X-CSE-MsgGUID: tifAmTNgTyihmV+oW5YCzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="60635458"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Aug 2024 06:44:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 06:44:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 6 Aug 2024 06:44:45 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 Aug 2024 06:44:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YdDCErlYTRScfMd9nXrJZVn9SSbYjI6PAXzMql3Zo1qGsVTBBnrqfXJKzBvuojy8OU08c7+mQEQEhd1JTRT7vBUrFJKfsM6Aq2ZrhNcx8KO4/2V5XEqg9TMhzcSNKOZg436JsrMemw5X1CUtxpthD54j+wBxLv6dH/lMEUDYZY61XPjOQBIS3EY57EomnAyLTBEuU9E6Kfv4tiXBgRKfNHKsM0SpDuiAn+Yk7LYdi6wL4wqm1R/9U5aSWcAt6D6dfN4/efTpoSeTCjJPxOBBVRWVeRp5aTJ/FHMQKBbESOVOTzB/giCRJ7Pe/pEAIhpcjwI+x6tXMOwr8Na8BJKVAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EoobCzKXeNwnB0aTWTXJFscTHand60FoghTiuH6addY=;
 b=LwwZpa6Sgbj2g7uuaTb/+nF71bDrsmdPYzyv1u54RNYKheeyxnId90RG1mnnSnXNDoUIXkcHeqKrnHqRQ3CSW+bzaMgREVwHgcIXu+3381VRu5ZAGccbmiFX/3ggOhf0g5VEyzQXBJh+gvdKqUcwq+4O2RsEPTi9GGd6awmPWk9+oVgxLrNi/VWNqWc8qAF9ohIdu/QNV1gC6Bc5PY+TV1qilJHrUMLjv7ElXTYc34nQt5miVtPYEPIcLw5FfKqPJRbGJr4atMnJC7AyKtsHU1IN3pbcsQ6m7PEdsm2a+vKr+N8gbtl+7mW6jv2uJEjPuFn7SXI0t5qK4pqXCutyBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CO1PR11MB4788.namprd11.prod.outlook.com (2603:10b6:303:97::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Tue, 6 Aug
 2024 13:44:42 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 13:44:42 +0000
Date: Tue, 6 Aug 2024 21:44:28 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Yu Ma <yu.ma@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Jan Kara <jack@suse.cz>, "Tim
 Chen" <tim.c.chen@linux.intel.com>, <linux-fsdevel@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<brauner@kernel.org>, <mjguzik@gmail.com>, <edumazet@google.com>,
	<yu.ma@intel.com>, <linux-kernel@vger.kernel.org>, <pan.deng@intel.com>,
	<tianyou.li@intel.com>, <tim.c.chen@intel.com>, <viro@zeniv.linux.org.uk>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v5 1/3] fs/file.c: remove sanity_check and add
 likely/unlikely in alloc_fd()
Message-ID: <202408062146.832faa23-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240717145018.3972922-2-yu.ma@intel.com>
X-ClientProxiedBy: SG2PR01CA0189.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CO1PR11MB4788:EE_
X-MS-Office365-Filtering-Correlation-Id: d9e84194-8f5c-4b09-d7e8-08dcb61decc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?NP6aHZ+FPxXyRF4Hn7LGnTPT6v32x262rZQSLBc0mO1KwphVOYX0AYHSVq?=
 =?iso-8859-1?Q?4csyH2me/7Acj64r1RGcOcaCD4Jyo3bjHynTs5k1YQc/zt3kPT5Bihcsi4?=
 =?iso-8859-1?Q?j3AlZnEbhY6jK3hHPK2o5rzd7UuRajhzRQOzvQF9l0CdTo7gpau+8i9vdH?=
 =?iso-8859-1?Q?LqZILcGUn7uD+DwynRqjdBTvIpSiBV7OSU3E0RAtBmo2sceaL8hWc13VAd?=
 =?iso-8859-1?Q?Tczn0mlfoSbmYv8AZ9+bJxE3B65esGOh4wgy6to07/SOEJMf0tMvTKpoT/?=
 =?iso-8859-1?Q?ugPO/ZXavYkIt3cVaU1qoMT9dsl++LmG7uCpA9mlgj9ox0FGvaFS0yHvro?=
 =?iso-8859-1?Q?U7nPHHROHy9ljLrfmzIuq6zCpl9afyZZvZt2icqNBHvwjXLEpdoq7XXlzO?=
 =?iso-8859-1?Q?i3y5ercFqT58upT17KxP6LTQoh25flLXIlvuA7Hp+EabfOBEG6YLjmyZv5?=
 =?iso-8859-1?Q?aZiw6497m3FVLIN/kRFXzBa1MdqHxYV17poAYdDqBKYoTol6W0BWroaCta?=
 =?iso-8859-1?Q?Mp4N5SOzzvTDDht4D3Sq6KBUb0Cyj9rZmAhYehGwo8qSlz4wATYWe3wfAa?=
 =?iso-8859-1?Q?k6gSgL3Mlvfi+g+dkNz112QSZPHKosuJyrNFKyh2rtX9Izao9EKDLl1lPX?=
 =?iso-8859-1?Q?JNFdSCPL929qr6LOH5aAYfhJP2GNb8UBQv6Bj0xWINgJtzcnW6fB++VDQY?=
 =?iso-8859-1?Q?YTsH9Y4iwG835sJNQuy+H9iuc4bqTY8M36igYEjA0QW+xqQGREMqS3u/ZU?=
 =?iso-8859-1?Q?yhHruBifKxawnqkUl53ges2aWPshLaW/xb4sdr0zgkJThsXCCIi3wY+sjy?=
 =?iso-8859-1?Q?wP6xg03SF/Pp7hKk60NFpfLrDG76WLcHsXCpuR1ecs5c41klOTcQRHKjsA?=
 =?iso-8859-1?Q?OPjlWpz5gFLfXcJNwWzWj5S4fh4rkBL2jFAodwvQeMfyv7EQEb06dJaC1W?=
 =?iso-8859-1?Q?1aipMWRZS+E2ZftDsWiBjYP3OuzpFgoI0c6hXfOfriEll+xpXZXslKO/4W?=
 =?iso-8859-1?Q?SpDSX6JgYeMIb2s5tm+6Jr8K+xgtvmQiX1iHQmV7dfhN5oMlKYbvCrvfp2?=
 =?iso-8859-1?Q?OS+a5CWjtqPH1RjDWcIfOrcwVDXQSGNDkHMlTQGgzu7lL+PcWy/D28Yqny?=
 =?iso-8859-1?Q?Uh1xd7et+UrY52AoUubaMXTCpjSg+dl6vGXsai1USi7tI+2g0ksv7xmgnE?=
 =?iso-8859-1?Q?czYRynBYizroNfaanTaCiR3mBxO6XKFhga2uoz+GN2t5r6dp7MY+EWG7jj?=
 =?iso-8859-1?Q?Z9/hi83uQMiFKAgb5f9dtG+WcyKi7rjWPR3b2j7Dr+1iT1Q4RDmGyggnU/?=
 =?iso-8859-1?Q?XPGFWqk9vEz5rv4/uZss1AMnHY6pwDLlGvdoWgkmVqZYLU0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?TLUVLqbiX9ggGr/EAeOdDxurCp9d3JVjgNVRH+ZM/WuWuMJCiKU4LGqPME?=
 =?iso-8859-1?Q?oS/pnr9QaGoGQF/vSuQ717960wwjXLfczlx3XRbOJG8/3sySGCPfz67lwT?=
 =?iso-8859-1?Q?TBai/T76RulayO2pYSD/nuuPchw/BCZvYqbE4F9SON8ArtI3uQi//erPLI?=
 =?iso-8859-1?Q?zeizzFtlQTlLZ3isGnXjpIeyud7EH7XXoppCF1uZbDQkiPRmdex51LUvbK?=
 =?iso-8859-1?Q?KGfl1LCTPtInhL2ew0ashtE5KLVZ7aiNAR+BPn5GARG0BcyjOZX+820kpW?=
 =?iso-8859-1?Q?1VJ9PuMT2gIsuxXgGWv4DdN1k1MqvKqp9vtl3TCHhoGAF+B683Zpfvrh8j?=
 =?iso-8859-1?Q?1yRbKEfjvxfR0t40uWrMkv4e7SP/LgGXuG18k7PhYAHDO68R8PMdxW0Fjs?=
 =?iso-8859-1?Q?ddwHLTDfR+HPgQldyb45vU0diWJlgVeqhpc35bwdvzQXVJzBcvCZtYMn+f?=
 =?iso-8859-1?Q?0Xgq88oX5OWQrZAWtZfMbh2s5nwZI20Ce9/hYZmVXvmeuzxLPkyr2/kJNg?=
 =?iso-8859-1?Q?BHdzAUPt/SyeAygV5oAMmh9kggoEBsRqN7e39UgTrKNKxsDcaGAongtscJ?=
 =?iso-8859-1?Q?WuQeYvL/KTRlN4bIh1sCEGdVyd3i0T4EQuqxdrlZrxOr2yuHBt4WNOViGS?=
 =?iso-8859-1?Q?bNbRGmhGOyK/MD3B3dTYGnMxzoo+ztuZUptD+7fOyu6JdYfFAmaOmemDkV?=
 =?iso-8859-1?Q?3kg5xPlO+ZHFMHqFqx6Gv9lJEImpg+McT/dmHHYpoLNl5XcK5t/905heog?=
 =?iso-8859-1?Q?D4vEwL6gu6tLeaVfPzbi15MANn8WJIwt1BgAPkQtfsxBeSENFYGXI8mUQk?=
 =?iso-8859-1?Q?GxvYaK5LQH5ra/uYt00gYIJZS1u7D1uIezwQyxiHwC+Z0teDKMJs9r11u8?=
 =?iso-8859-1?Q?dCTac9dRpVvGG+uD+S80VRD0ua4+XaIirW0KvgK0qa9HF4unuX2dZDW1SC?=
 =?iso-8859-1?Q?hMYuh5bwXbu6ZVB6NP/PiksnYLTxl74+7Foy/dvW6ifWay/hWcg/VIC7p7?=
 =?iso-8859-1?Q?GSjeTtzZTBae7H/yG6ZQyDOuC9bO6Y2ZftIbkuMCeWb8bZRMLZ+GdSodj3?=
 =?iso-8859-1?Q?TJUj3iL2LerFoepvquIgAzAwHhlYES7TxLFRobMihBpjlyuMRt6IzWTB1c?=
 =?iso-8859-1?Q?1MgOMpdQJN3HYGFUKT4ioKHDQbLADbefi86XFelqsKWtTehJThGyMG3riB?=
 =?iso-8859-1?Q?HC6vm5uCxmIIT7N3fY0lnPiSsmzXvs+lU8/jiVLav56GwI0kgUd3h4zWiD?=
 =?iso-8859-1?Q?WQStMOHucJVrVQg0bMdQRH3HL+HOHfMX+xoSVDxIfckmwmDcjZ79+yF7CQ?=
 =?iso-8859-1?Q?3rChlsVzLyr6koIrQIp3bx5c0CxGCcf+n7iFv8K4p6ZFm1CLK1YfGsRDst?=
 =?iso-8859-1?Q?5Y/tQIVFjqncR5IE3oFiXDI3MzalFsEpeWCJ9t6AxFPcD6VXBtyxtO2qDN?=
 =?iso-8859-1?Q?CAPlEbAslcTlVQ4Jz37SxvoZnLiikB+KhaFRplXlIplfb9hD6wv9xtVuqz?=
 =?iso-8859-1?Q?9nW4jGc9p/SXEfZvJl3OjPwedXhxIgRSBC5mRjlkamDb4lj4SXxcudocdL?=
 =?iso-8859-1?Q?0vG3JCsCv80td/PMKiSA+pSoLCc2UsnjadGAFN2Bw9gwNir4KGfpeDYep+?=
 =?iso-8859-1?Q?hQy+svQbGz90OHY7tsCPeun5dos1ntvSQ8wP+amTWNiPPtEQmkIyjHDg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e84194-8f5c-4b09-d7e8-08dcb61decc1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 13:44:42.5497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BsY+tiFiGrv+INUtki3Hi1+GW4RdgyR0Tr/t4Jm4l3O7E9wfKZVfLrgF/Vd7ACMqOX4rsNrSSayQpy7kau5LOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4788
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 1.2% improvement of will-it-scale.per_process_ops on:


commit: f1139c8e66d5c618aad04a93a2378ad9586464f9 ("[PATCH v5 1/3] fs/file.c: remove sanity_check and add likely/unlikely in alloc_fd()")
url: https://github.com/intel-lab-lkp/linux/commits/Yu-Ma/fs-file-c-remove-sanity_check-and-add-likely-unlikely-in-alloc_fd/20240717-224830
base: https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git vfs.all
patch link: https://lore.kernel.org/all/20240717145018.3972922-2-yu.ma@intel.com/
patch subject: [PATCH v5 1/3] fs/file.c: remove sanity_check and add likely/unlikely in alloc_fd()

testcase: will-it-scale
test machine: 256 threads 2 sockets GENUINE INTEL(R) XEON(R) (Sierra Forest) with 128G memory
parameters:

	nr_task: 100%
	mode: process
	test: dup1
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240806/202408062146.832faa23-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-13/performance/x86_64-rhel-8.3/process/100%/debian-12-x86_64-20240206.cgz/lkp-srf-2sp1/dup1/will-it-scale

commit: 
  5f30e082ab ("Merge branch 'vfs.iomap' into vfs.all")
  f1139c8e66 ("fs/file.c: remove sanity_check and add likely/unlikely in alloc_fd()")

5f30e082ab8b3431 f1139c8e66d5c618aad04a93a23 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    377983 ± 69%     +74.1%     658036 ± 17%  numa-meminfo.node0.AnonPages
     18.17 ± 10%     -48.6%       9.33 ± 35%  perf-c2c.DRAM.local
 8.796e+08            +1.2%  8.903e+08        will-it-scale.256.processes
   3436082            +1.2%    3477810        will-it-scale.per_process_ops
 8.796e+08            +1.2%  8.903e+08        will-it-scale.workload
 1.517e+11            -4.3%  1.452e+11        perf-stat.i.branch-instructions
      0.03 ±  8%      +0.0        0.04 ± 36%  perf-stat.i.branch-miss-rate%
      0.93            +3.9%       0.96        perf-stat.i.cpi
  7.13e+11            -3.5%   6.88e+11        perf-stat.i.instructions
      1.08            -3.4%       1.04        perf-stat.i.ipc
      0.93            +3.4%       0.96        perf-stat.overall.cpi
      1.08            -3.3%       1.04        perf-stat.overall.ipc
    245130            -4.4%     234451        perf-stat.overall.path-length
 1.512e+11            -4.3%  1.447e+11        perf-stat.ps.branch-instructions
 7.106e+11            -3.5%  6.857e+11        perf-stat.ps.instructions
 2.156e+14            -3.2%  2.087e+14        perf-stat.total.instructions
     14.90            -0.7       14.20        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.dup
     12.01            -0.7       11.32        perf-profile.calltrace.cycles-pp.__x64_sys_dup.do_syscall_64.entry_SYSCALL_64_after_hwframe.dup
     16.54            -0.7       15.88        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.dup
      6.44            -0.6        5.89        perf-profile.calltrace.cycles-pp.alloc_fd.__x64_sys_dup.do_syscall_64.entry_SYSCALL_64_after_hwframe.dup
      2.86            -0.0        2.82        perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.__close
      8.94            -0.0        8.90        perf-profile.calltrace.cycles-pp.filp_flush.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      7.76            -0.0        7.72        perf-profile.calltrace.cycles-pp.locks_remove_posix.filp_flush.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.58            -0.0        2.54        perf-profile.calltrace.cycles-pp.__fput_sync.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      1.11            -0.0        1.10        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      1.33            +0.0        1.35        perf-profile.calltrace.cycles-pp.testcase
      0.54            +0.0        0.56        perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      0.79            +0.0        0.82        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack.dup
      1.33            +0.0        1.37        perf-profile.calltrace.cycles-pp.close@plt
      2.73            +0.1        2.78        perf-profile.calltrace.cycles-pp._raw_spin_lock.file_close_fd.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.05            +0.1        1.11        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.dup
      4.35            +0.1        4.42        perf-profile.calltrace.cycles-pp.file_close_fd.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     22.18            +0.3       22.51        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.__close
     21.50 ±  2%      +1.5       23.02        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.dup
     12.10            -0.7       11.39        perf-profile.children.cycles-pp.__x64_sys_dup
     34.79            -0.7       34.12        perf-profile.children.cycles-pp.do_syscall_64
     38.04            -0.6       37.42        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      6.48            -0.6        5.90        perf-profile.children.cycles-pp.alloc_fd
      1.86            -0.5        1.41        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.57            -0.1        0.47        perf-profile.children.cycles-pp.fd_install
      9.11            -0.0        9.07        perf-profile.children.cycles-pp.filp_flush
      7.93            -0.0        7.89        perf-profile.children.cycles-pp.locks_remove_posix
      2.61            -0.0        2.58        perf-profile.children.cycles-pp.__fput_sync
      1.16            +0.0        1.18        perf-profile.children.cycles-pp.x64_sys_call
      0.05            +0.0        0.07 ± 13%  perf-profile.children.cycles-pp.clockevents_program_event
      0.51            +0.0        0.53        perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      2.17            +0.0        2.20        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      5.72            +0.0        5.75        perf-profile.children.cycles-pp._raw_spin_lock
      2.10            +0.0        2.13        perf-profile.children.cycles-pp.testcase
      2.02            +0.0        2.06        perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.13 ±  2%      +0.0        0.17        perf-profile.children.cycles-pp.dup@plt
      4.38            +0.1        4.46        perf-profile.children.cycles-pp.file_close_fd
     23.00            +0.1       23.11        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
     59.27            +0.5       59.73        perf-profile.children.cycles-pp.__close
     28.73            +1.1       29.80        perf-profile.children.cycles-pp.entry_SYSCALL_64
      1.86            -0.5        1.41        perf-profile.self.cycles-pp.syscall_return_via_sysret
      2.28            -0.2        2.12        perf-profile.self.cycles-pp.alloc_fd
      0.54            -0.1        0.43        perf-profile.self.cycles-pp.fd_install
      7.87            -0.0        7.83        perf-profile.self.cycles-pp.locks_remove_posix
      2.47            -0.0        2.44        perf-profile.self.cycles-pp.__fput_sync
      1.23            +0.0        1.24        perf-profile.self.cycles-pp.file_close_fd_locked
      1.09            +0.0        1.11        perf-profile.self.cycles-pp.x64_sys_call
      0.51            +0.0        0.53        perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      1.29            +0.0        1.32        perf-profile.self.cycles-pp.testcase
      5.66            +0.0        5.69        perf-profile.self.cycles-pp._raw_spin_lock
      1.95            +0.0        1.99        perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      2.85            +0.0        2.90        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.02 ±141%      +0.0        0.06 ± 13%  perf-profile.self.cycles-pp.ktime_get
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.dup@plt
     22.93            +0.1       23.05        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
     10.11            +0.2       10.34        perf-profile.self.cycles-pp.dup
     13.70            +0.3       13.98        perf-profile.self.cycles-pp.entry_SYSCALL_64
      9.84 ±  3%      +0.7       10.51        perf-profile.self.cycles-pp.__close




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


