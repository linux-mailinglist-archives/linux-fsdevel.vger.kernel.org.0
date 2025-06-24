Return-Path: <linux-fsdevel+bounces-52691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FD0AE5ECD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 10:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0054B1BC0D86
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 08:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0522566F7;
	Tue, 24 Jun 2025 08:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n8TJR3FE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786D8255F56
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 08:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750752714; cv=fail; b=ZI1nx3B8TsKzW9YDws807oBNDOtzPMkr01+opIBxUBWLL3/IoMr5JmYnVr564diHRZm2f34U6CaQ+81/P4SjD8J7wDxMyvgO3gJUOh8F3ue1UcwL+7ikxH85uOq6dh5sTODH4BhPCNq38CW+5EwJuJD4vLHavZvF22y6QoKr9bU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750752714; c=relaxed/simple;
	bh=jhaC9cY+dP1SbUVZTsm7MtmUBJuGYwxa/cT2ZLbZMdU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=s4hkwEKfrjhdAHG2kAKvYE46VvyCx76MHFp7QrtHYOgDkfVus4fTfMC5f9dPJoPobNxkl/LdgGb4iSBAZgekyJrNkFU1kSQHeVAU6sA2t+TjH7/lmaLTPtJdvzLOuhWLJI364u2vuADLaB2sss0dudPoplroWetOsAjOxtWv/gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n8TJR3FE; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750752713; x=1782288713;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jhaC9cY+dP1SbUVZTsm7MtmUBJuGYwxa/cT2ZLbZMdU=;
  b=n8TJR3FEtGuTSZ4ESoSxRs8doGFL5q1k4kqLzzo2K06xj4Z6LPv6Cb9b
   P/6pQzfMaY/M5FVuDUZ4OEfM/6wiPW8zPhZpjKR3qcVI1v8H8WjMycMwH
   i+iQ0I2R7kfQY9I+hnkkE+5KkQ+r6EWQT2KQKnZxdx2jvo6zfJIyxEgS4
   XsbHBtlKeVkQiRSV4Rq0QX8V7pXjhME/oEpa/YiR6Kpfk9J1e1so+iOzw
   usVzxLi4DewC+edSaTHXRB3wx5WXu0GWjlr/QFAEBrCerwoPcN6txCoXD
   +PI1Ld6QOFDBKe9zKfGQnU0mOAt6ZkUzfbCBwN2v65wKiMEJN0ANZjVQz
   w==;
X-CSE-ConnectionGUID: PHdMgmVPS4mzE8QWAvI5Tg==
X-CSE-MsgGUID: 2ONhVpvZRr+b+nfi1nscDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="63584115"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="63584115"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 01:11:52 -0700
X-CSE-ConnectionGUID: X18o+fHJToCnKHFZhHA/qg==
X-CSE-MsgGUID: HXYEZq6TS9i8LPKzAxzjOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="156231179"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 01:11:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 01:11:51 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 24 Jun 2025 01:11:51 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.64)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 01:11:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KX18W1ThFu12RRZCXWzonIfFSJhR85/jHtCCkyJO7Ss9XtqX4i93zhlp4pOmHnuouiLpkdLdNtgYnXBVfgU51/saBIyV8XucvG2SaVZCw8YDDL6i6j8nqZnBFplW5lTjqOT70ANLUMGDNx4T2czEkDwlF4cwiFLEG0VKKdPlOrYItt82ylD1JeSXnxuh1AafoFdH+PKTtn57VbUZJQPHdIBXcG6qJthWiiKsiz5lVCkSN5TM5/jUz1lii+ZKJ6NngupztIiDeSQFoPhG32UQPcRqZbuZvDeDFy50KYQwnMLQbtTJKb7JodrIB8TDTBBEWbJ8GeVP8k3wevhtRDg9AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yDdJi4wFUrasIceVBLRbk6571bv1Uy03bvjvZg4ioo=;
 b=BZbAGb33ZRWabbF6e42sliNllDWbDIUuJKz5hwFl7GBTUZfXFW2tA/xR34fohqc4PrMg7C9mRFlnUmvWxrimmqo5JYlW4VVJ0yFJWNFvOlfzr8CdpsM9W87HFanvwNh/6IgggvWzQlaCPpBVMflqE6gm7ehLPXT5cWvTzCXYK7lZMR9WSh6ZhU3+5uhBE/0HsV6XKF6xXY12VPWUgWN0jxge/gRJ6bqa3epWMSIth+HLhu/+T565pSGo0Satgj02i+uXJGAgrtGcYaMsElmN+axd10XRZnWAaUzB1W2/KT32jjuwSp0O06pNW8g0xEH2qkjJouu7kpBicwhsFCD7lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB7277.namprd11.prod.outlook.com (2603:10b6:8:10b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Tue, 24 Jun
 2025 08:11:44 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8857.025; Tue, 24 Jun 2025
 08:11:44 +0000
Date: Tue, 24 Jun 2025 16:11:34 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<xudong.hao@intel.com>, <oliver.sang@intel.com>
Subject: [viro-vfs:work.debugfs] [vmscan]  1c90302a35:
 kernel-selftests.kvm.access_tracking_perf_test.fail
Message-ID: <202506201427.7fc6ab94-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2P153CA0030.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::17)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB7277:EE_
X-MS-Office365-Filtering-Correlation-Id: 299b5337-f6d4-4352-7c94-08ddb2f6c1cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l7UQTGvtWfFmG8bSqTtEpP2gjhCS3iYrMPrDK9Ok+heBOOPTQ4a/k7eeZz4O?=
 =?us-ascii?Q?Ua14PiwDE+4Q7IqR+QX6Io4ydsi2LRR5uEMCfIQ7cZXx7TqcuXxBVUjXq5AG?=
 =?us-ascii?Q?hubjmKJX31dkLaviKrL8BQ6vPFgwTwhgt/suidDVS8eQYlI0CK54rsqK59VZ?=
 =?us-ascii?Q?pxNweh3qP5W6kD9h2YA197QQ0gXf8SMPM2Y3yZg0Mu2ILD2Ev5PbH3dZx4/n?=
 =?us-ascii?Q?hueIiJ3s7TmDoXjlDwELTgDJpYbXY01EzBktnjRwvZi00/+fUK3gF5UKBABh?=
 =?us-ascii?Q?CPDgEodmuz9fERBPMO+tmBBZCDUBm+O8dYAmbYdyJ4BzZoHVoxD5Zkl4U2DD?=
 =?us-ascii?Q?msAMXa9oJslFH0TElvb1O3wvw3tbd9e5eParWczFU9tkiSHWIh4mNV14cO/D?=
 =?us-ascii?Q?RWM1CZn6smoJ3sbX1Z4ufJC+rNJnnnvr1tE+NmJ/HvwAhor/6UVuQSR4d+kL?=
 =?us-ascii?Q?8Pv5oYWcefppptaYlzzUWPw1EiGnT9bB5eCG3M5M1rnN7tooDY4gIY+1JGq8?=
 =?us-ascii?Q?auVlJOFlIn4UmYtzjCR9Swg3/lUMYwajMkGUIDmn3Ub1Wll5ks/WkTmzfdNh?=
 =?us-ascii?Q?VqhRlHR/5IyMbpLz9OeCgBpripTV0m5ct9N5n+LwBl686W8o1+yu4oqp7xB8?=
 =?us-ascii?Q?2DDpnJUE6zy2xOu5UtUg1RlEh6scX85H4DJq8zUanjMdxNXdxQKm3fgN9Vh7?=
 =?us-ascii?Q?gCseo/PNFDbT5O1FLa9hLgylmNFWAOTEvOkM/Yn5YCx8sHPdxKg6wthFJ4VR?=
 =?us-ascii?Q?th8rGcKSk/ng6fyPM+GY/KtDL3pvXMw9ohnUOpnBOxVtvw9pLHOivkHJ3V1a?=
 =?us-ascii?Q?cxS54dzqmvfOJlqPwGwIwGw/qUrpqkaXsSHnn47J4lvMWHFAyPQWlBKSB8/X?=
 =?us-ascii?Q?bHE5kMSq0Sqp9aByGb29cRIjtKay1nYC0POFAGKVaM8/8jnUseNxLYoDDJxp?=
 =?us-ascii?Q?4DBpHvwpQz6S40HPeKMKB37vApjUoRbBuvZ37akXLSJwDi2K5GXONBzQnZH+?=
 =?us-ascii?Q?EY87l9qq1nykvMTLcWE3LSrgRoNSoQGn+0N4y5iagRnHXMaHVPvC0Ipz5Rze?=
 =?us-ascii?Q?ND+DJI0v/Hj06zZXUoF5V/OfuuEyFUv9Bcd/gN8/EtnjN7/ey2B3uQPjhMbo?=
 =?us-ascii?Q?DUOFUyHOKCv/Djuq0Xu6Nr31PUn0AE9iBmM2opVQIYSXGGmdzE2E9hNTS13i?=
 =?us-ascii?Q?tm2AJ6T1OA89RxecHUkJxIL1eF6Z/gdF0+9/IIXmAZO4iFKRFmpcCpTtwj/l?=
 =?us-ascii?Q?q9xKIeme7HMB9jsB02Y/9J1i1mqkdvThOOqg/roD6NTOVOy3qKG8P0pBp9xI?=
 =?us-ascii?Q?v5gTyk3cgzvfi5wGg/SjWFUXNcwH5emISpSRtsjE5S190PgFl+W1E/MTIvTf?=
 =?us-ascii?Q?r4JPbcjIAj9L551f3MYlg1rzA3Vw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6XkntcpL1V2LNixNJ/IdFp3lFmvoV69I6xgTD7mLQHUcr0XGh4mim6jwow/3?=
 =?us-ascii?Q?gv2+Ybu/GqYODq2nwVYkXlG0WsNy1CDXZqlOSTJOKi7tn1mv9nrFZ5agO/4A?=
 =?us-ascii?Q?JPzlPLBeE0Ig2wtDheO+Z0ZhIbehnFNxSHapCwwLynlCksuod0XVeSY9qmfn?=
 =?us-ascii?Q?PqxF3Z2RG4vl1wq1h+wScsRS9d8fZyM/b41nf0T/l6Lo875PU4+HHqE2nKDm?=
 =?us-ascii?Q?vcPv7KHi42BoxOGrT+QXzMw14GE4EoXDNzuvpH378v3d41tazMfHLxETTNbz?=
 =?us-ascii?Q?XRha7H7zF2kqUOmItRYHp89NoBLRNRZ6nm/9r9IgKEodzzc6jh7AzgBZ00ni?=
 =?us-ascii?Q?2GQjbTE3sVXgD3cE/qEKP5fUv6kI377fLKsnDSaKQBe96vD61A7BOX3chBvm?=
 =?us-ascii?Q?Gkpy+G8jGjLFCsuj7f8qVW+NhuqLx0jcc1BSYzLa0r0u1qz/jySo6+BxI+8t?=
 =?us-ascii?Q?I7Mp48gymxWngEgzCwki/7gRwkHjQUUoEeRlDmzy7MKzHnKF8guP+rNuvUk7?=
 =?us-ascii?Q?5h8M8oKrMjd6cCxRmayuu3vGn+ZivMn/tCOKyJvMJE2IcqoAd899mUYc8esF?=
 =?us-ascii?Q?YBjhn8g0w9jnR5WHgsZf1BhyYLea0JoDvqn3Ijq5+Z131IRSPaGF7ivJjNrn?=
 =?us-ascii?Q?aqKjAgZjVE1nzV7CTEbiDPKBSuzSvwPIQigJO6xEsQTxvgdCOJnIuA59cF6/?=
 =?us-ascii?Q?L5YGSQ7yoaIvYIeS/E079jBsCJdbUFAX6vJuzHXVfR6Te/n0aYpnYglBBihK?=
 =?us-ascii?Q?zWH099JRkxaow06SIKCi5txGBhKm15zBHNX4vsTBYCyMaxsO9E2PNrZZyQd1?=
 =?us-ascii?Q?YAlwP904n3Owo043wC/Lx/aBHfPuC3yO6nJdT6LDiaUeae69wX1J+9VhwdPz?=
 =?us-ascii?Q?0h+06OsawEMGXC2EAb0DesuP2JSPKAEDBUGzcXKc4fLGdQ4/8eHzfOzi6n4P?=
 =?us-ascii?Q?N7Nnhob56E/nSac07gZwigwqKfApp/ATQEz0U3BMeCa9Z3r/1NnBLXsneQfq?=
 =?us-ascii?Q?pYixW6JCzv6uv/VfIxVGuyXAtNbKFJIUsSVEpTgTbWLWeVxbkAF6y819O8Q6?=
 =?us-ascii?Q?7iA49HaxYOVpj7EcarZyVS9aSLRevUk1SkF5605/+hXWeCduNrbTJtpk5Ay5?=
 =?us-ascii?Q?GUGPL+dSoCPm++kkmwHbKZziJb2I7wCAtZ6qPhXuUmCvzmRbCcn0co+jLb/6?=
 =?us-ascii?Q?jOffii6xeJr8T907The2o8/xheXmU/v/emc08N2Lfs90BZOIPlEEwdrdIZmN?=
 =?us-ascii?Q?H3Dd2vwuJ1V4DgBY3SIL7Vdl+Cyy60fqrjtfOXpoLbp7NwwjkvcUOuLh04Ae?=
 =?us-ascii?Q?VwJu8gFzFCsbIl3hkY8B1Ael3IQ96EVKZ5QuuE2WpFXPjAd6yqbLCGc9aMOq?=
 =?us-ascii?Q?/B19RCaMLsXLlU2ujXh5rgaelS0W0oHLwuReEkWLv0VVU7cWhz6xXfxrCuTp?=
 =?us-ascii?Q?qfmk3ZjgOPg8OWAqxowogoFMtupwxwtq+AWXNUurGhUi8CwwYBQ6UawT/FTr?=
 =?us-ascii?Q?Q0I6KM5lI272e02F5/Cfn7a3Yr5SH59Kv2pWwF0THRC25WZhimMExYM2v22T?=
 =?us-ascii?Q?g299P7FxNAmdse01ndsnJvUJQm6GCfJU6MoKCSJwg2P8bnm4vi351fmR/6wG?=
 =?us-ascii?Q?UQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 299b5337-f6d4-4352-7c94-08ddb2f6c1cf
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 08:11:44.1956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l2iJ2iV8C6y1xm1sfcRPhzLgc2OVaVZdxkPQiKTe90SrlAFsnMNdzwQOWwmU7mgCIaWdPNRgaACEMnoRVAONJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7277
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel-selftests.kvm.access_tracking_perf_test.fail" on:

commit: 1c90302a35bd038c176ce0bf731221b28369bb36 ("vmscan: don't bother with debugfs_real_fops()")
https://git.kernel.org/cgit/linux/kernel/git/viro/vfs.git work.debugfs

in testcase: kernel-selftests
version: kernel-selftests-x86_64-7ff71e6d9239-1_20250215
with following parameters:

	group: kvm



config: x86_64-rhel-9.4-kselftests
compiler: gcc-12
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480+ (Sapphire Rapids) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202506201427.7fc6ab94-lkp@intel.com


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250620/202506201427.7fc6ab94-lkp@intel.com


# timeout set to 120
# selftests: kvm: access_tracking_perf_test
# Random seed: 0x6b8b4567
# Skipping idle page count sanity check, because NUMA balancing is enabled
# Using lru_gen for aging
# Creating cgroup: /sys/fs/cgroup/access_tracking_perf_test
# Testing guest mode: PA-bits:ANY, VA-bits:48,  4K pages
# guest physical test memory: [0xfffffbffff000, 0xffffffffff000)
#
# Populating memory             : 1.643991832s
# Initial aging pass (lru_gen)
# ==== Test Assertion Failure ====
#   lib/lru_gen_util.c:166: *end == '\0'
#   pid=11817 tid=11817 errno=0 - Success
#      1        0x0000000000408dd8: memcg_stats_handle_in_node at lru_gen_util.c:166
#      2        0x0000000000409034: lru_gen_read_memcg_stats at lru_gen_util.c:221
#      3        0x00000000004091e0: lru_gen_do_aging at lru_gen_util.c:309
#      4        0x0000000000403526: run_test at access_tracking_perf_test.c:436
#      5        0x0000000000403d8c: for_each_guest_mode at guest_modes.c:96
#      6        0x0000000000402bfd: run_test_for_each_guest_mode at access_tracking_perf_test.c:486
#      7        0x000000000041d993: cg_run at cgroup_util.c:382
#      8        0x0000000000402869: main at access_tracking_perf_test.c:591
#      9        0x00007f381a5a2249: ?? ??:0
#     10        0x00007f381a5a2304: ?? ??:0
#     11        0x0000000000402990: _start at ??:?
#   malformed generation age '0r'
not ok 76 selftests: kvm: access_tracking_perf_test # exit=254


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


