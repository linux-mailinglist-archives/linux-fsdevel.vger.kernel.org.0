Return-Path: <linux-fsdevel+bounces-19474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C28718C5D89
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 00:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F3931F2217C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 22:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7745181D03;
	Tue, 14 May 2024 22:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GYMQc6NT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0391DFFB
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2024 22:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715724941; cv=fail; b=RC6bXvT7sEoVNu5rxkvrNz1dvB4YWcdUVKt51tXLUkpJaS9F/tg8/kNnXCdEWuikxGeq5w3YxTW067s4mGqaCNUky9NxGa2FYaM3EFt1Z3vFsydIPZ/333CelV9AzHDmaeWkda1ZhtKZ90dTuchXsjjIEmRBVucy8wKWUFmjYTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715724941; c=relaxed/simple;
	bh=iEJr4U9NbbBGv1drW4LrZ6gcK0FycSaFK1nqSNPTz04=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LZDGwSMAETYnacklGqCInUwKTX14NwvnwTGkShNmnwAH4+iRoYXby5XCgtoPKCD/qgh/hsY15IaUiBaS+xvqyL9FKP8S3vbBe4JTMYXEwvvDEu6tnDhyfn7vlY3ZZVYKLK3N0iRfoKQiBnnHPMUgVbHqWMgkQkSu1LXt3hV00fI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GYMQc6NT; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715724938; x=1747260938;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iEJr4U9NbbBGv1drW4LrZ6gcK0FycSaFK1nqSNPTz04=;
  b=GYMQc6NT8v0tasAZX4qG/wfrg1KrJrDijmytjzuObLwtl8Ynwz6Tu8ei
   NO62OnnVQOLgHe0fteQ232WH/TedWXGBOccTOsll40I+Xh98jHt4Pktlo
   I1yRojcJ7zsRXpJSqUDyaf9DEnFY9yCgJ6ikcAvIzdwx2SYxmsGqqogA6
   6JbUZY1qedanqusEzRoTdd0q/zVn+6rFM7YkqMypsFg5PsC/QpT0oCv4r
   OloSKvm14+4CqwmHlG0kuwTe3jvQ36LGipgPHwlRwS/uDKKb/VjmKkQ6L
   oNMIgf1hKuQ6ZkQSw+Dct0Dm87RGTvJPdAVBu9VDfryiztaOW66O0biXb
   Q==;
X-CSE-ConnectionGUID: kPQgfQn6SFidZU4NkzYdCw==
X-CSE-MsgGUID: fa5fwyBQQz2Gxr6pz2CihA==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="11864076"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="11864076"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 15:15:38 -0700
X-CSE-ConnectionGUID: A9IlZiDqRi+/2fhjZXoATQ==
X-CSE-MsgGUID: srN8k2VlRCyj49yuQyAiVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="30916253"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 May 2024 15:15:38 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 15:15:37 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 14 May 2024 15:15:37 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 15:15:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gC2ZtYSuxUu+UkFpAHZVrH5sbobBoVfKMib+DSheuqglQKpt1J+k8d7Ujda8pC/JBtKN2VUUDaGqW0r+5NCWEPW+uJzO2tYj1nvzUeMSj4InL6EIM9x/LZH1IrzMxLqRfpJM9z/EaR/usWhw9EnTe2Bs0zLi5hUwjNwdSYsGKMkezvB8OsE7+TZqSu/LQOAgV6tM2PezXEkNp7zjuLsDFzAKVVjNWcjAOuIBxwkUHlGzg1ljKj/QR0Mx0NC0gbA3y9J+Y7bKUOHjWKErAxXjuR2baILudv23nOsLIVM2EQR/cppS2P2qV4ub85sgofPG9Ky6j4NRb3ExLAkf4WwfBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhIfOvWXZwnILqg0jIsIEUO4mfikenl9AJ6PcZeEZ5w=;
 b=b1uN5TMY2n+idcGtVXnKjMyyvp2fYr7XvrjRDCMLqQNToBg+4oxGnAhMv8SdvvqQp2hUVW8xJ9m7N1ZkJEWsHJnlVPBomUIrkEm3JeqXx1i6cQDlgIt709KptoVcv7JeZJehJUjlPn9MddZVLv6CW5iHBWThlYe06heFJx7qRxCK/y1f7WudbJrSJd/czfnFx8giYGcSLeAwoo11W81opQqEOtC/+wXqsCTARp3il32/s6IhI+3UwHFwdUJsEvz6ROtA8xesr/DJmfW6fn1LuhndSnVkejSDJbTz4YKBQx/f1HqeRjcLE6l6qP6q9prkFTKd0Lpx/K1fxeIV8PZEQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8441.namprd11.prod.outlook.com (2603:10b6:610:1bc::12)
 by CH0PR11MB5268.namprd11.prod.outlook.com (2603:10b6:610:e3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 22:15:34 +0000
Received: from CH3PR11MB8441.namprd11.prod.outlook.com
 ([fe80::bc66:f083:da56:8550]) by CH3PR11MB8441.namprd11.prod.outlook.com
 ([fe80::bc66:f083:da56:8550%4]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 22:15:33 +0000
Message-ID: <3de1a823-542f-4a4a-aa98-2c45474648bc@intel.com>
Date: Tue, 14 May 2024 15:15:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/xe/guc: Expose raw access to GuC log over debugfs
To: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	<intel-xe@lists.freedesktop.org>
CC: Lucas De Marchi <lucas.demarchi@intel.com>,
	<linux-fsdevel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
References: <20240512153606.1996-1-michal.wajdeczko@intel.com>
 <20240512153606.1996-5-michal.wajdeczko@intel.com>
 <d0fd0b46-a8ac-464b-99e7-0b5384a79bf6@intel.com>
 <83484000-0716-465a-b55d-70cd07205ae5@intel.com>
 <3127eb0f-ef0b-46e8-a778-df6276718d06@intel.com>
 <3c8ad7c7-c144-4045-a2a2-c33f54223623@intel.com>
Content-Language: en-GB
From: John Harrison <john.c.harrison@intel.com>
In-Reply-To: <3c8ad7c7-c144-4045-a2a2-c33f54223623@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0221.namprd04.prod.outlook.com
 (2603:10b6:303:87::16) To CH3PR11MB8441.namprd11.prod.outlook.com
 (2603:10b6:610:1bc::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8441:EE_|CH0PR11MB5268:EE_
X-MS-Office365-Filtering-Correlation-Id: b7038391-80d9-491a-10cb-08dc74635f3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OXFYbGQ1d1JjdGVjOEJzNFZObnllMFNwVW4zOHlySkRwRUVKNHUyMzJQV1ZL?=
 =?utf-8?B?a1hZek1aR05RK2hpTzZvcjRGVGpXSy9xcVBObmw3dTlXUkdvcEJaQ1dhQjdC?=
 =?utf-8?B?bkw5NVkvNXg3bmhCSUttaUV2ek1hdWpTNUgwK2dob05VVzUyNUg0Q3hyRUg2?=
 =?utf-8?B?QnhZTWxBZGdTbEVlcHRyQ3JvVTVLNnJtRUtKS0JmNDVUOVN5RER5aVVqOWVS?=
 =?utf-8?B?UU1KeUREZWxLL0duaGUwQXEzRUVwYWRuQ2RIWHJUR0hpYUFYbjM1VHVHZkdu?=
 =?utf-8?B?YW9MVktLOXU4N2hlRWRuRzBCQTg3aDRlaThXek5Lakt0K2RzKzUrdDZXVS84?=
 =?utf-8?B?WmJjSzQzczdQMFRhUUZkM1pwN3p1WmxZWUFuL0RVQi9KNkFON1VvWFJxRnVz?=
 =?utf-8?B?dUMwTCtjR2NoWXNSZmJPL3ZHc1I0T0RtYmVlbUJOZ0l6NkxjanRrM2tFTjBP?=
 =?utf-8?B?Y1p2Ukw5bWNLNmtodWRnemNjUDZBeGtHVmZ5T1hncXExNVNnZnBFMllYV2lq?=
 =?utf-8?B?eTdZWEVLVWJldGhxOGkxbUJXUmt5UmR6MVRVanl0NzRXejF4WGI2dTcyQS9w?=
 =?utf-8?B?eXdRVjE1VG1DOTM1UTRuVGJVNXY2RzBPVTBsT3hkNTdVemdpUjNYN1RYb0FU?=
 =?utf-8?B?bFBwNnJMbHg5aThYeGVjTWs4YjV6ZDJnWU1MdjBkYS9McjNQd3VRcmlyakFW?=
 =?utf-8?B?QnNuNTM5bzhieUtZSzFmNkpCZnZBcjk3QTB5RVphOVo2ZEVzTXY3Z1dSdmNm?=
 =?utf-8?B?RHdadmxvM3JaejEraU00bFNTYVd1RURLQVZndTFzMDJsbCtmOXZzY3h4N0hB?=
 =?utf-8?B?dGh0cElVQS9CYlhMVHo4anFmR1ptSTNHUFo4S0o3ZWtmbFpRN1RxSTZZbER1?=
 =?utf-8?B?cnJWSkFYcHcwdEg1WFBaMnk4cGQ3d092SytqMU1kbHc0OUdBSS9IdlZERklD?=
 =?utf-8?B?MkZmbmNvN3JKV0RPNjByYk5HdDhsY0pZeWszdlRBSzZhZlhQWDg5L0dZWVJJ?=
 =?utf-8?B?V25jN3JmQjd2WllJWWp4WWoyQ2d1Rk5ueHp3Wm13dDl1MlhlU0xVMGJqbkhn?=
 =?utf-8?B?SDZXQUZsUTFReE1rN0ZXbkNyL1JvNXd1Nk1TUElWeXlOOWxVN0wwbTIxOFp0?=
 =?utf-8?B?Qnd2YXNQazZJNWdSMEZKcEEwVjVZRG9nR203eWNnZkVYejErL0x5MHo3US9W?=
 =?utf-8?B?K0Q5MVFUclRLRGMrTGIxNWxyWGFza0JyYmx1QVYxak5FZDk2SStuOWFCY0ZC?=
 =?utf-8?B?U2hneU9iekZtL3g3eERjbVpDK05YVkRTVDF5S3NNS05qekNEeGYwbFI2VXB2?=
 =?utf-8?B?YzkvTXVvRUdKYVJQWE5OTnB3eXc5M3VtT2NPTS9mUGdQTTY5Vk44d0MvUlR0?=
 =?utf-8?B?Q0tZVlMvR3h5TUs0RlJwK3FoVlV6enRBSmQyLzJSZXZPZ29pU2JxYWRBSGNr?=
 =?utf-8?B?Qzl4VWkzbWFoam5qZ1dYZndhRGkxZVJkQ3dIWkZzYmlJTW9JYXpZMzdIZ2RU?=
 =?utf-8?B?MkxDTktvVVdJM3hCRGNpOVRNa1VtZVhETUNRVkFXaHlxWUgrYnEyRGtnNVVS?=
 =?utf-8?B?cXV1VHl4QUJiR2xqTDNzOTRoNzdKUU4xcndSV29ZRngvQ2d0TE1IWFdmSHpo?=
 =?utf-8?Q?67OWrBh9P7F3slyLQlPTdlDeuWT+tgOd/DUC+vir/2Q0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8441.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REY3d21iNWFSVTFINTRBWHVYUWNPcVZOVGNJUDZoSzlrdHlmSVlXb0pFUG83?=
 =?utf-8?B?UXpHTEQ4MFJ5dEM5ZnFZeDlKZDc4V1hkNzZ6TThDazBRNy9ieUg0b2FRM3JP?=
 =?utf-8?B?UU1seXhOZlhScS9hbGk4UFFVdW56eU14blNvSkk1T2ptaEs2R1pBS2FmN0Z4?=
 =?utf-8?B?SFZDM1ZDaGhFVXJkSmlVL0xrendkYU42MGErN1NOTW1CZ2x0Y3kySWVGVkQy?=
 =?utf-8?B?K2tTTjhLaGQyOEFadnVrZXV0MC9yRTBVMHNTRVpoL01DSXRyNFJ2RWhMOVhH?=
 =?utf-8?B?SzRBSWNjUE5PYmdSTzBNL0lqYU5vdW8vbEd5SDFYUjlVL2ZidTRaUVI4WVpF?=
 =?utf-8?B?T3RYMmJJNWlOeVZqYlM5YXppOXIra3BrMWdGQW15dkIyTnUrZE5CU3hGWUFZ?=
 =?utf-8?B?diszWnBnc3JCNjhBam1HYzdqTmYxUzVmVzlYNEFyeHMrMXBicFk0RU1GZE82?=
 =?utf-8?B?UStoNE9tV1o1ZUdldDc1M2pXQkFMQjlGT2l2NHdMREhLOGFJNDFqcnpvV0Jh?=
 =?utf-8?B?dU1ob1Y4blZ4MTZPdk9TNXZFNWl0NGQyR3phS2tGa2psR3A2TkxGMVc0RVl3?=
 =?utf-8?B?V3p3NlF1ZW82K2lCLzM1WkVxaE5SRkpCY2wwV0RXTUV4eDI1anN0VWFGSVZj?=
 =?utf-8?B?R1FTNkgrS3hpaEVETVZYemw1MVllamxyb1ZVcFlnQkFXZ1gzcEZ5VUhtbUY3?=
 =?utf-8?B?dkVVZS9XdUJHdTZCODFOYk5KU3JWT0FwYU9Sdnh2VGtob0Y2cHY5aUhPOGFk?=
 =?utf-8?B?S2JtQmlHcmtvOFEzTnBhRGNNeDk2OCsrRDBEemIzaWxQL2xyaVRtQ0ZtZTB3?=
 =?utf-8?B?NS83TVlPSmpmNXBxdytIcm9nRkRkR2xrS2VCNlEwaVY4YnEzYUpKRU1VZU5R?=
 =?utf-8?B?NVBRRjlYWThHcDBwV1AzeFNtZm9lbWJzdnhGcjY1RnRiUXJNVDhpcVZ2Y2M0?=
 =?utf-8?B?c0pqV1l4amxiTnl1Q2phV0hQb0Rqdkl4ZUJubUxMb1ZJQVB2SjBYemZueHFF?=
 =?utf-8?B?RjJyL05yN1NXc2dHMzZUTytRUzNiNDZYYmFyL3UrVy90YnVUR2syVUNJMjE1?=
 =?utf-8?B?cTJhcVpPTVBoZEk3RlFXazg5VjRCNFV4cFZmdW1tSzJtNEhzTXdWNlFTWU9o?=
 =?utf-8?B?d2Zmb0tSRm1HMkV6SXAybDVVaTREYlgza0tHTlY4c09YbFB4dUJjeUVaN3h5?=
 =?utf-8?B?Zy84RDZOUm41bXRTTldKdElFb2FiRlMrQUxFclFYVzRZUnM0cXdPSWswZmMw?=
 =?utf-8?B?azNCbHhiZlorNElyMExvQzRoQ0FqRHdYM1ZpaTdVSXh5OFRhUHAyTitGNFc1?=
 =?utf-8?B?dnRoUmtKOStUcDBVK2h2Uit5OXc5b1dJZFdlZlNTeGpQc1RXeG9yaFd0YTRJ?=
 =?utf-8?B?RW9XZnNPS2NYRktsTTlsS1RRUDhjQ3JBaU5wRkpnQkp2dkhkUlFRNWF2NHUy?=
 =?utf-8?B?VjJTN3FhSHVvNHNiYXhVTTk2Sk1LTkpsUmlJSHh5S0xucWYyQ3lpZnBFT0hs?=
 =?utf-8?B?NVdkNGYyQVVSOHJKSHRzK3pwRHR1QXJOZWpkcW5ONGd6eTljdjZPQUh5ZDBK?=
 =?utf-8?B?NGNFKzgrd3VkK0tWOFFUckR5bExjbWRWSi82SWRsenRlTWRuNVdGNTV1Z2Fu?=
 =?utf-8?B?MVM5RzlMRFBuc1hPYlVML24zMUZlOXFhdE9QbVh0cmtFUGxMUXZUUklyOFYr?=
 =?utf-8?B?VWthUFpHa295UmdFWjNjeTdTV2tEYjYvNHJ6aGVDMkU5QTQ3NkFwZ0pGY09s?=
 =?utf-8?B?bFhNUTcyZWRWd0ZWWW4wcWFLV2NiY3BmNUp0S1BNdnpQSjNsY0lSYkdqL29t?=
 =?utf-8?B?YThZZ3ZjVzMrMUJkTk5rUzBQZkU1bDAzWjBlNTlZNlZlWjgvT2VYa0xYVWdy?=
 =?utf-8?B?Q0ZZd2NjWDRELzl1SGFobUlwZkh6TTl6NEhBU0d5MVlPYTVnblNOSWppUzBy?=
 =?utf-8?B?RVJKWjVLb01zM0VaREFFSHJrZkRqVjQwSVk0VnZ2MGpzeVNGYkJTSGxSL3Nu?=
 =?utf-8?B?ZGVqdXRnSWhnV1Z3aG5icVBMUVh5eVlKYkF0VTdVVnB3ZVE3RHZjdzFlMnM0?=
 =?utf-8?B?RlVVOUtRT3NnU3E3aE5EczhiMEtmemM0RTV2N3gwbXQycDhlcHVoMW9FTzFW?=
 =?utf-8?B?R01YYU1GWHlVNm1CeXpFR05lYjZtYXpDVXR4dS9INFd0Q2Z0YjhqV3hwUGpu?=
 =?utf-8?B?alE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b7038391-80d9-491a-10cb-08dc74635f3a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8441.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 22:15:32.9522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9457E72zkE5XOIyVyR3GnocnWHjC4RQLQhaSU9D94DhnkSokhpqhewmSoI/fu11kefCYWjPEtiRH4u5iNFL4qI3MBvFO0Pa1VCJniMdOFlw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5268
X-OriginatorOrg: intel.com

On 5/14/2024 13:41, Michal Wajdeczko wrote:
> On 14.05.2024 20:13, John Harrison wrote:
>> On 5/14/2024 07:58, Michal Wajdeczko wrote:
>>> On 13.05.2024 18:53, John Harrison wrote:
>>>> On 5/12/2024 08:36, Michal Wajdeczko wrote:
>>>>> We already provide the content of the GuC log in debugsfs, but it
>>>>> is in a text format where each log dword is printed as hexadecimal
>>>>> number, which does not scale well with large GuC log buffers.
>>>>>
>>>>> To allow more efficient access to the GuC log, which could benefit
>>>>> our CI systems, expose raw binary log data.  In addition to less
>>>>> overhead in preparing text based GuC log file, the new GuC log file
>>>>> in binary format is also almost 3x smaller.
>>>>>
>>>>> Any existing script that expects the GuC log buffer in text format
>>>>> can use command like below to convert from new binary format:
>>>>>
>>>>>       hexdump -e '4/4 "0x%08x " "\n"'
>>>>>
>>>>> but this shouldn't be the case as most decoders expect GuC log data
>>>>> in binary format.
>>>> I strongly disagree with this.
>>>>
>>>> Efficiency and file size is not an issue when accessing the GuC log via
>>>> debugfs on actual hardware.
>>> to some extend it is as CI team used to refuse to collect GuC logs after
>>> each executed test just because of it's size
>> I've never heard that argument. I've heard many different arguments but
>> not one about file size. The default GuC log size is pretty tiny. So
>> size really is not an issue.
> so it's tiny or 16MB as you mention below ?
The default size is tiny. The maximum allowed is 16MB. By default, you 
get tiny logs. When a developer is debugging a specific issue and needs 
larger logs, they can bump the size up to 16MB.

>
>>>> It is an issue when dumping via dmesg but
>>>> you definitely should not be dumping binary data to dmesg. Whereas,
>>> not following here - this is debugfs specific, not a dmesg printer
>> Except that it is preferable to have common code for both if at all
>> possible.
> but here, for debugfs, it's almost no code, it's 1-liner thanks to using
> generic helpers, so there is really nothing to share as common code
>
> note that with this separate raw access to guc log over debugfs, you can
> further customize xe_guc_log_dump() function for dmesg output [2]
> without worrying about impact in generating output to debugfs
>
> [2] https://patchwork.freedesktop.org/series/133349/
Or, we could put all this extra effort into doing something with 
tangible benefit. I've probably already spent more time arguing about 
this patch than it took to implement it. Time I would much rather be 
doing something useful with.

And my point was that the dump size is only relevant for dmesg. For 
debugfs, the size simply does not matter. So trying to optimise the 
debugfs dump size but with a downside of making it more difficult to use 
and more susceptible to issues is a bad trade off that we should not be 
making.

>
>>>> dumping in binary data is much more dangerous and liable to corruption
>>>> because some tool along the way tries to convert to ASCII, or truncates
>>>> at the first zero, etc. We request GuC logs be sent by end users,
>>>> customer bug reports, etc. all doing things that we have no control
>>>> over.
>>> hmm, how "cp gt0/uc/guc_log_raw FILE" could end with a corrupted file ?
>> Because someone then tries to email it, or attach it or copy it via
>> Windows or any number of other ways in which a file can get munged.
> no comment
>
>>>> Converting the hexdump back to binary is trivial for those tools which
>>>> require it. If you follow the acquisition and decoding instructions on
>>>> the wiki page then it is all done for you automatically.
>>> I'm afraid I don't know where this wiki page is, but I do know that hex
>>> conversion dance is not needed for me to get decoded GuC log the way I
>>> used to do
>> Look for the 'GuC Debug Logs' page on the developer wiki. It's pretty
>> easy to find.
> ok, found it
>
> btw, it says "Actual log size will be significantly more (about 50MB) as
> there are multiple sections."
16MB debug log, 1MB crash dump, 1MB register capture -> 18MB actual data 
size, expands to about 50MB as an ASCII hexdump.

>
>>>> These patches are trying to solve a problem which does not exist and are
>>>> going to make working with GuC logs harder and more error prone.
>>> it at least solves the problem of currently super inefficient way of
>>> generating the GuC log in text format.
>>>
>>> it also opens other opportunities to develop tools that could monitor or
>>> capture GuC log independently on  top of what driver is able to offer
>>> today (on i915 there was guc-log-relay, but it was broken for long time,
>>> not sure what are the plans for Xe)
>>>
>>> also still not sure how it can be more error prone.
>> As already explained, the plan is move to LFD - an extensible,
>> streamable, logging format. Any non-trivial effort that is not helping
>> to move to LFD is not worth the effort.
> which part from my series was non-trivial ?
The doing it properly part.

If you want a functional streaming interface then you will need a lot 
more than a backdoor access to the GuC log memory buffer. You will need 
all the user land code to interpret it, do the streaming, cope with 
wrap-arounds, etc. Effort which would be more usefully put towards 
implementing LFDs because that gives you all of that and much, much, more.

>
>>>> On the other hand, there are many other issues with GuC logs that it
>>>> would be useful to solves - including extra meta data, reliable output
>>>> via dmesg, continuous streaming, pre-sizing the debugfs file to not have
>>>> to generate it ~12 times for a single read, etc.
>>> this series actually solves last issue but in a bit different way (we
>>> even don't need to generate full GuC log dump at all if we would like to
>>> capture only part of the log if we know where to look)
>> No, it doesn't solve it. Your comment below suggests it will be read in
>> 4KB chunks.
> chunks will be 4K if we stick to proposed here simple_read_from_iomem()
> that initially uses hardcoded 4K chunks, but we could either modify it
> to use larger chunks by default or extend it to take additional param,
> or promote more powerful copy_to_user_fromio() from SOUND
Which is yet more effort to still solve the problem in the wrong manner.

If you are trying to implement streaming logs then we should do that via 
LFDs as that is a much simpler debugfs interface and only requires 'cat' 
on the userland side. If you are trying to solve the problem of multiple 
reads of the buffer for a single dump then a) that is not a problem on 
physical hardware and b) it does not actually solve that problem unless 
you take a snapshot on file open and release the snapshot on file close.

>
>> Which means your 16MB buffer now requires 4096 separate
>> reads! And you only doing partial reads of the section you think you
>> need is never going to be reliable on live system. Not sure why you
>> would want to anyway. It is just making things much more complex. You
>> now need an intelligent user land program to read the log out and decode
> I don't need it. We can add it later. And we can add it on top what we
> already expose without the need to recompile/rebuild the driver.
Or we could put that effort into something which will be of significant 
benefit to all users of the interface.

>
>> at least the header section to know what data section to read. You can't
>> just dump the whole thing with 'cat' or 'dd'.
> only 'cat' wont work as it's binary file
Which is still a problem.

>
>>> for reliable output via dmesg - see my proposal at [1]
>>>
>>> [1] https://patchwork.freedesktop.org/series/133613/
>>>> Hmm. Actually, is this interface allowing the filesystem layers to issue
>>>> multiple read calls to read the buffer out in small chunks? That is also
>>>> going to break things. If the GuC is still writing to the log as the
>>>> user is reading from it, there is the opportunity for each chunk to not
>>>> follow on from the previous chunk because the data has just been
>>>> overwritten. This is already a problem at the moment that causes issues
>>>> when decoding the logs, even with an almost atomic copy of the log into
>>>> a temporary buffer before reading it out. Doing the read in separate
>>>> chunks is only going to make that problem even worse.
>>> current solution, that converts data into hex numbers, reads log buffer
>>> in chunks of 128 dwords, how proposed here solution that reads in 4K
>>> chunks could be "even worse" ?
>> See above, 4KB chunks means 4096 separate reads for a 16M buffer. And
>> each one of those reads is a full round trip to user land and back. If
> but is this a proven problem for us?
So what problem are you trying to solve?

>
>> you want to get at all close to an atomic read of the log then it needs
>> to be done as a single call that copies the log into a locally allocated
>> kernel buffer and then allows user land to read out from that buffer
>> rather than from the live log. Which can be trivially done with the
>> current method (at the expense of a large memory allocation) but would
>> be much more difficult with random access reader like this as you would
>> need to say the copied buffer around until the reads have all been done.
>> Which would presumably mean adding open/close handlers to allocate and
>> free that memory.
> as I mentioned above if we desperately need larger copies then we can
> use the code promoted from the SOUND subsystem
Even more effort.

>
> but for random access reader (up to 4K) this is what this patch already
> provides.
But why do you need random access? Streaming? Then implement LFDs.


>
>>> and in case of some smart tool, that would understands the layout of the
>>> GuC log buffer, we can even fully eliminate problem of reading stale
>>> data, so why not to choose a more scalable solution ?
>> You cannot eliminate the problem of stale data. You read the header, you
>> read the data it was pointing to, you re-read the header and find that
>> the GuC has moved on. That is an infinite loop of continuously updating
>> pointers.
> I didn't say that I can create snapshot that is 100% free of stale data,
> what I meant was that with this proposal I can provide almost real time
> access to the GuC log, so with custom tool I can read pointers and and
> log entries as small randomly located chunks in the buffer, without the
> need to output whole log buffer snapshot as giant text file that I would
> have to parse again.
But why do you want to read small chunks?

John.

>
>> John.
>>
>>>> John.
>>>>
>>>>> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
>>>>> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>>>>> Cc: John Harrison <John.C.Harrison@Intel.com>
>>>>> ---
>>>>> Cc: linux-fsdevel@vger.kernel.org
>>>>> Cc: dri-devel@lists.freedesktop.org
>>>>> ---
>>>>>     drivers/gpu/drm/xe/xe_guc_debugfs.c | 26 ++++++++++++++++++++++++++
>>>>>     1 file changed, 26 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/xe/xe_guc_debugfs.c
>>>>> b/drivers/gpu/drm/xe/xe_guc_debugfs.c
>>>>> index d3822cbea273..53fea952344d 100644
>>>>> --- a/drivers/gpu/drm/xe/xe_guc_debugfs.c
>>>>> +++ b/drivers/gpu/drm/xe/xe_guc_debugfs.c
>>>>> @@ -8,6 +8,7 @@
>>>>>     #include <drm/drm_debugfs.h>
>>>>>     #include <drm/drm_managed.h>
>>>>>     +#include "xe_bo.h"
>>>>>     #include "xe_device.h"
>>>>>     #include "xe_gt.h"
>>>>>     #include "xe_guc.h"
>>>>> @@ -52,6 +53,29 @@ static const struct drm_info_list debugfs_list[] = {
>>>>>         {"guc_log", guc_log, 0},
>>>>>     };
>>>>>     +static ssize_t guc_log_read(struct file *file, char __user *buf,
>>>>> size_t count, loff_t *pos)
>>>>> +{
>>>>> +    struct dentry *dent = file_dentry(file);
>>>>> +    struct dentry *uc_dent = dent->d_parent;
>>>>> +    struct dentry *gt_dent = uc_dent->d_parent;
>>>>> +    struct xe_gt *gt = gt_dent->d_inode->i_private;
>>>>> +    struct xe_guc_log *log = &gt->uc.guc.log;
>>>>> +    struct xe_device *xe = gt_to_xe(gt);
>>>>> +    ssize_t ret;
>>>>> +
>>>>> +    xe_pm_runtime_get(xe);
>>>>> +    ret = xe_map_read_from(xe, buf, count, pos, &log->bo->vmap,
>>>>> log->bo->size);
>>>>> +    xe_pm_runtime_put(xe);
>>>>> +
>>>>> +    return ret;
>>>>> +}
>>>>> +
>>>>> +static const struct file_operations guc_log_ops = {
>>>>> +    .owner        = THIS_MODULE,
>>>>> +    .read        = guc_log_read,
>>>>> +    .llseek        = default_llseek,
>>>>> +};
>>>>> +
>>>>>     void xe_guc_debugfs_register(struct xe_guc *guc, struct dentry
>>>>> *parent)
>>>>>     {
>>>>>         struct drm_minor *minor = guc_to_xe(guc)->drm.primary;
>>>>> @@ -72,4 +96,6 @@ void xe_guc_debugfs_register(struct xe_guc *guc,
>>>>> struct dentry *parent)
>>>>>         drm_debugfs_create_files(local,
>>>>>                      ARRAY_SIZE(debugfs_list),
>>>>>                      parent, minor);
>>>>> +
>>>>> +    debugfs_create_file("guc_log_raw", 0600, parent, NULL,
>>>>> &guc_log_ops);
>>>>>     }


