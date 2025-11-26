Return-Path: <linux-fsdevel+bounces-69894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4713BC8A218
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 15:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BBEF84EB90D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 14:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC94B2D9482;
	Wed, 26 Nov 2025 14:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HD8sE2CK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF8622FAFD;
	Wed, 26 Nov 2025 14:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764165719; cv=fail; b=sGa5F2Gw7t2WeNxYFMSBrATLdhzay4ONmGpVdvi58MkOfHpvv4kjhsFMNtV3Dc91AR8sUMrD0RfGQF2gdMaAq9UviwQjTfIIOfl0EBwus5+1ZHfb7GTAzCmm5VVcuKC0acEZpKn2JTGIn0QzLN1Bk4fSGZua4gJgCN5+GbQerAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764165719; c=relaxed/simple;
	bh=uzgSHu13cwZ9P6w2u7zlG2cOEXNVNz18k9846kZpEzc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ot1cTMSiDgIL7BQziu1+9fMawi9WSHuTHgGIHQZSHl9qidnxUs9SyXrcp2smDKMnyG9tFpEx1tLM9Zu9xvwAxDd7WngkTqnGexG1auK8H4mRqqpgt8qW/AZdUapU4SLhDQaExaHf4sVMgBeQXK5tGMZPL2kw4Zvy5AJ7qHIaB4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HD8sE2CK; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764165717; x=1795701717;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=uzgSHu13cwZ9P6w2u7zlG2cOEXNVNz18k9846kZpEzc=;
  b=HD8sE2CKoPcbf9KZ/x3/3+W0Tb4HJKNMq5BryuUpJcYrtnBC4JEBHNjS
   EF1wxuPsPiODL/bhFKXPDEF4D6vy4IXkj4ZRgMFn8N5DXlN44XAEznpkR
   yh4rBxBuULrttQLMhf80U/R1BO8YV0NKbhvbSNduo1Dk9ZGIpZl2hDdTK
   fsdYUQEmROdT6pPiKr0zIhwtjG/L7G+bqO7uvbxqCPJuDi5ZH2f/r4DST
   kgUKNlgoo7wZ0jQEcsh+oqc+LOxxwW/lkdvrl0C7cPTQ9uKzVw6s2NXqD
   uFQaIeaclUkVLdvKSoojEi+A4on2Whkmqb3l7HMYgOz4BDaQNWw2G7Gyv
   A==;
X-CSE-ConnectionGUID: BY/0NFQlTTeLgb59Er7yqA==
X-CSE-MsgGUID: /sAEI/WaTdC79LzZVJKTsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="66160466"
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="66160466"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 06:01:56 -0800
X-CSE-ConnectionGUID: l5pmJU+4SBetg9Wv4/8KLA==
X-CSE-MsgGUID: z4qRnmuySwOw2v3KnFKxFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="197117453"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 06:01:53 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 26 Nov 2025 06:01:52 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 26 Nov 2025 06:01:52 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.33) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 26 Nov 2025 06:01:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WYjHZDvwTpitokSf4WV7IpkfuYLMEoUHrSEH+XjoaBXNd0hxtUtsqXGsgtj1CRpF9alpiTFYKPWHOnqNj6TngYYDfmVjxtUeJ86Pdh+GvFAygcYD7BvjfNsFkrEa2uMRi0Q5Jy7cW6S8GiQgrtO94V1gIgSYXfqEj2UM96z5+iSjDGzFSKnT98Jxu8QaCzXMab3gY3mdTj/0FenFqgng+jSZiMBJ48V3VgnRT968YMPDGnfJDU1+AP/xggwF78T80eyEytMnC7Umf3g94m4l0BsymFfXuI8KgDxke9Pj+orh4Rn/kscswk4OHmKVeGjdItIjuk9K6mSUtBH8QzMM4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GDz8nwT26Q3pH9vY5kO58hm7SJRpbZMiMn24s6tRRs=;
 b=p7i4XHFTcYFWHNIbzFS1TojCiATd51IXSbcMP5YIclU6l69gfpgE6Bpe7I0F26RqMHUADpYQOAwnSRSHOML3WioZ5kYeQrxks3Z6u8GA7Bl+IDp7QoJk5ZIkUHrmzvv2rA0eJ86t5te3Y07+CNV10nYF2m7de7FA1v5yd4acCpagRuZU2PVLDqg9edsjHICEmWLzzPxtXWM40c6sJFbv41ScLor+C6sgEbrwSQP4BWSfVPJkhfEG8gUvZGIpZ09iiqF+ZeIRJJ9UqmNTcALzjs/1TyyZ3Oobbcx9sQIO0Ro2wz8LP2mFR7kzvIxu6dB0NsBfvHx0ksFCOPecd0bX5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB6795.namprd11.prod.outlook.com (2603:10b6:510:1b9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.15; Wed, 26 Nov
 2025 14:01:35 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 14:01:35 +0000
Date: Wed, 26 Nov 2025 22:01:22 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-fsdevel@vger.kernel.org>, <viro@zeniv.linux.org.uk>,
	<brauner@kernel.org>, <jack@suse.cz>,
	<syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com>, <frank.li@vivo.com>,
	<glaubitz@physik.fu-berlin.de>, <linux-kernel@vger.kernel.org>,
	<slava@dubeyko.com>, <syzkaller-bugs@googlegroups.com>,
	<skhan@linuxfoundation.org>, <david.hunter.linux@gmail.com>,
	<khalid@kernel.org>, <linux-kernel-mentees@lists.linuxfoundation.org>, "Mehdi
 Ben Hadj Khelifa" <mehdi.benhadjkhelifa@gmail.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH] fs/super: fix memory leak of s_fs_info on
 setup_bdev_super failure
Message-ID: <202511262155.f86d1a5f-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251114165255.101361-1-mehdi.benhadjkhelifa@gmail.com>
X-ClientProxiedBy: SG2PR01CA0135.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB6795:EE_
X-MS-Office365-Filtering-Correlation-Id: 43a054d5-4123-4ad4-83fe-08de2cf44f68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aWafNEXcH/w7/IzhQ5x2w8oIXCy62FX8lufN0DySZAICXa63UhFdzcIdAAtv?=
 =?us-ascii?Q?62WNZFI36Ue+bW+pgS/3QJJZ8IVaC6T2UTBolYtiXhyLGI6v4mK9gqDWjenv?=
 =?us-ascii?Q?BCwp3UKcT0vzPBY/9lEx1Vd0+9T4vK0wCiKNx4LqE6do4Cr9/C8XktmNRe9X?=
 =?us-ascii?Q?0Fmxb6kiCwutM6RrKgf2w6Wj6bfrtiGY+dwAEgY+IlBnuH612YzdyhmhmPtD?=
 =?us-ascii?Q?pGQLjenJPtNsje/+WP3BjVhJgYrfnErSuiTLufRlyZ7dEEbaiypdLOgoqvIy?=
 =?us-ascii?Q?YvtPDSbZRAaAbsnaIXq1VdQXt5fopDKtlCFiXVeL6haH+cWHwogXVUN2Flbj?=
 =?us-ascii?Q?Ady+v7RCAnYORB1+3Fdq3vK3tGmNg3h/gpbIHJhyWUYMWPgFornW6/8YNiCX?=
 =?us-ascii?Q?AdLAXA7QBw5Kc7e49TC+ZOnWKSw0KHgObwgi2f09m9XZCk+quVpf1vMhisFu?=
 =?us-ascii?Q?q4oImrHi++ngdFEah4eXc6G4uVulBUq5s37XwndaFIZUWMxn3jaz2lab15jM?=
 =?us-ascii?Q?eu8zuzELUUN/E7DOvj7zfsPA+Ka1hFqBZQVaZrm3zu8w5Xp0eqVe1VDrdDa5?=
 =?us-ascii?Q?suAVc/MhacPNQIEojjLrVNy8k3Nsc6X3e08gvMZJjxDhmgTRTgw04UhNoyVz?=
 =?us-ascii?Q?Hb0UIu3jjovCXtQzJX9AbTD+jjza8yW1G0D4Itxo4nRS9SuEc3Jn7pH5DmiS?=
 =?us-ascii?Q?Rke4Gs1M5wHT5udlpRK9qmwNUt01eEGT6z36y6W0p8grLMkWbnfa7J8RJBqN?=
 =?us-ascii?Q?BkfyASgS56sK5HNx9N/0pfjWHvPvpwo3O8RbhBf5o1XkpPjjH+dh48SnU7DO?=
 =?us-ascii?Q?jl4VRj7oVP4rbVDRTfwn0y93AyWw7hfIXq5cY33ljjXLi8MT0urO7tD1qB1X?=
 =?us-ascii?Q?6T2FgqH3mUvZ53VLjUDnjjNQNSXpHV8HEX9Da8cGM9zFTB/NI8Myti2tpHJB?=
 =?us-ascii?Q?4w9v/plrjmlTBIAWvI1O6z/zKFdZfpeLHEYk12e6tA7PzfYFYbCWFEro3jWo?=
 =?us-ascii?Q?1DN4wyPcq7SGxbCkUIrZcjMbmPZ8ORJiU/TOOZUpUIvfODWUUlRNbk/aNhil?=
 =?us-ascii?Q?ZTeyW8LmwXwBl8/1Jnh0bYSNbeeEhQQduDa+VZ5ZDNB+z1TxER3MZni5w9iQ?=
 =?us-ascii?Q?tbHCsWefbG69h6h2SavvY2wuZIfCed8SPqYSJsYMCKo38Rvanpmv4DJzYeXz?=
 =?us-ascii?Q?WqagzFmDQ78ihLD9oC2mNy6VBFv5Gicn3kVAdwbKzJh1L/oKwCJ72Z9Wyve8?=
 =?us-ascii?Q?PIi3kUDLy0+DyF0XPxa0vZfa2oR0DaqedDekwgK9oNQ6w5rssLk71iLlFrf8?=
 =?us-ascii?Q?sPIDySF7gluIiIbVCCDKDw5BVo+kil/09TkIRF0lyGL7x8ro0jM5Q+rD7aOC?=
 =?us-ascii?Q?Qbsa9krSOjd/Yhutkb2au1DH5HnGegmydKm75XL+uOEzRHDkHA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rLLl981eW7S1OdSgjATZg/BcO5QmTHNEjy+89YS5pkuCFAz56ffbETy+Adga?=
 =?us-ascii?Q?jG48qiST4cLfDEv1nSVWa9zk5xhCaxmZE+zfJcQZx9D5SDD+pKaq/GuigiM8?=
 =?us-ascii?Q?8bXTskY8/8+YXVpFgvBMH/4pp7eDHloDWT1c45TrKb9p6UPxA/Oum380uDWm?=
 =?us-ascii?Q?E7gYT1czY7stkrMYw5t9YWjITwQAkqFDsirX+YaG/OhhxjvPxiUfS4qqlClx?=
 =?us-ascii?Q?NvbC+z/hM/enLb73GvTTm5WiOL7deA8BYtCNBMS2aO0yZwU0n4zwRsjmwdqu?=
 =?us-ascii?Q?t3KrDLOZI6cDm0m1SNaP6V5EKTN0Zilx2kYyn4kMaShUy09HJvNLD/Pu6dnn?=
 =?us-ascii?Q?NYtvMwIv6ckbvpjVYDBq0m0G0y4EJ3QNDHhzX84MQ7r8tarrkF158zOSyb6u?=
 =?us-ascii?Q?j8+Pbp4JMY2j+OOQW+/qqWgU3slyHVVqaY5qZTecHhxz1XE35EpRkdj1weSh?=
 =?us-ascii?Q?7dciJnM/xr+8TpF+PFpOJyGR/IGtU3yWoQxeheDuZLunh1kmPOyF+8lsEZvN?=
 =?us-ascii?Q?OdsC1eJCqc7Wu2xWqmGoa9f7Q5WKYHowSblsf731xYsUw7x7gbuc8KPC69KH?=
 =?us-ascii?Q?LK+Pf5JDMmZ0kOkqeqK+yLwtpAkvw4QmsK9JjfYoPB8zasWy6uB1Znu+NcZU?=
 =?us-ascii?Q?wXy45aktXR40xGjAtB/DbmhPTcLVz8vZUlKhnYCIzYdG7qSz4zf7k5IlcALc?=
 =?us-ascii?Q?l9HL/8glWVRmewammQ3sVrPs+4H5tInpHSllCFjRKofcTbAtepj8GNmoXgmn?=
 =?us-ascii?Q?xsvcPSqXSPxt5vwX1O2TwPUcBiJIBaIAA/fTWsVuxxJYU762Rtr31OL3Feqt?=
 =?us-ascii?Q?ciTsL3Yv6TZ8GRmqk02HNx96eroeJJFR2y/SiRnkdrVUyhgtG+Yyt8/QiFRS?=
 =?us-ascii?Q?m5WwRButAOmb/U9+SdAGDEvYglU9FTXuwmGvtI9sm0HIm8omWRy2gv4y27t0?=
 =?us-ascii?Q?Z8Kt6zjlMLNTN2Ah3VL5L8sG2SeeTI7eikGP7BXm6asDkOgcE8uBmpzadH+O?=
 =?us-ascii?Q?cSdULM/XIgqO1P9YXGkehX+PbNMjdqmq8jsNrXYP6+9gPR1l4rtyPVcnsmXt?=
 =?us-ascii?Q?c+jQSyFSIMlT5c8PT6oYMVoxBbEvjWyjT4YkqZe38ser8SGSJIPb0G3TDy2A?=
 =?us-ascii?Q?+6o3q2Py8ATp/TCCr3Kb0oDWxocUacccQO9ieKC9hWu8lkD5FRcFlAm3x3X6?=
 =?us-ascii?Q?K+vQQRPV3ihGDPEpN+NYKqsA/mqbqmLTNSNC0mKcxEZhys66wCRj+xAirZV5?=
 =?us-ascii?Q?x82F/b5QsSeI27Oteb/6+qi0iaPG6NL1WQgdXmRzbwMW/xwXY9hREnfGEOG4?=
 =?us-ascii?Q?ziPBsTfRSDPxca4znkeG+Dja4pv536wXk6XPIWcoschvqoKsQCN4S1zNubd5?=
 =?us-ascii?Q?U3tMK6AcI4VE3we8PWWvout6L5xrb+NmY5oVj1viNNG8I4yXiu5DjzkgNuJ3?=
 =?us-ascii?Q?FFZiDAc5sEqtgXGIT5r2EY1FwfMC0O71VzKCcf0AqWkMItDTokK9kYh8m5Kh?=
 =?us-ascii?Q?AuWWIB/1V6bO7MV2cjhQKGr8mBwcQSBOUXFkY2E5YsOp45bkUBbUJLmfU/kJ?=
 =?us-ascii?Q?e+Miv1YsiJpOxTLX+WrGlxIVEr/MMZMPBiEeePWA02GrGgc+BpgS1P38+3nP?=
 =?us-ascii?Q?vQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a054d5-4123-4ad4-83fe-08de2cf44f68
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 14:01:35.0318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3cpG7ewljxeK2yRi7un+88GP7gHVNhOFxADL2VfEeq9vDW3XszaQSRIun5VxgFv77M7xeOz6kEqMOVv03e4vnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6795
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]SMP_KASAN_PTI" on:

commit: 45f3d9974e382495db777e0290a32ba0cd6f454b ("[PATCH] fs/super: fix memory leak of s_fs_info on setup_bdev_super failure")
url: https://github.com/intel-lab-lkp/linux/commits/Mehdi-Ben-Hadj-Khelifa/fs-super-fix-memory-leak-of-s_fs_info-on-setup_bdev_super-failure/20251115-001149
base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 6da43bbeb6918164f7287269881a5f861ae09d7e
patch link: https://lore.kernel.org/all/20251114165255.101361-1-mehdi.benhadjkhelifa@gmail.com/
patch subject: [PATCH] fs/super: fix memory leak of s_fs_info on setup_bdev_super failure

in testcase: nvml
version: nvml-x86_64-4cbe1fd37-1_20251013
with following parameters:

	test: non-pmem
	group: util



config: x86_64-rhel-9.4-func
compiler: gcc-14
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz (Haswell) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202511262155.f86d1a5f-lkp@intel.com


[  164.783048][T42994] EXT4-fs (loop0): VFS: Can't find ext4 filesystem
[  164.792057][T42994] EXT4-fs (loop0): VFS: Can't find ext4 filesystem
[  164.798663][T42994] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN PTI
[  164.810433][T42994] KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
[  164.818722][T42994] CPU: 3 UID: 0 PID: 42994 Comm: mount Tainted: G S                  6.18.0-rc5-00215-g45f3d9974e38 #1 PREEMPT(voluntary)
[  164.831362][T42994] Tainted: [S]=CPU_OUT_OF_SPEC
[  164.835992][T42994] Hardware name: Dell Inc. OptiPlex 9020/0DNKMN, BIOS A05 12/05/2013
[  164.843927][T42994] RIP: 0010:fuse_kill_sb_blk (kbuild/src/consumer/fs/fuse/inode.c:2126 kbuild/src/consumer/fs/fuse/inode.c:2153) fuse
[  164.850056][T42994] Code: 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 75 6a 48 8b 9b 90 03 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 da 48 c1 ea 03 <80> 3c 02 00 75 60 48 8b 3b e8 ec f8 ff ff 48 85 db 74 1a 48 83 c4
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 00                	add    %al,(%rax)
   4:	00 fc                	add    %bh,%ah
   6:	ff                   	lcall  (bad)
   7:	df 48 c1             	fisttps -0x3f(%rax)
   a:	ea                   	(bad)
   b:	03 80 3c 02 00 75    	add    0x7500023c(%rax),%eax
  11:	6a 48                	push   $0x48
  13:	8b 9b 90 03 00 00    	mov    0x390(%rbx),%ebx
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df 
  23:	48 89 da             	mov    %rbx,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
  2a:*	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)		<-- trapping instruction
  2e:	75 60                	jne    0x90
  30:	48 8b 3b             	mov    (%rbx),%rdi
  33:	e8 ec f8 ff ff       	call   0xfffffffffffff924
  38:	48 85 db             	test   %rbx,%rbx
  3b:	74 1a                	je     0x57
  3d:	48                   	rex.W
  3e:	83                   	.byte 0x83
  3f:	c4                   	.byte 0xc4

Code starting with the faulting instruction
===========================================
   0:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   4:	75 60                	jne    0x66
   6:	48 8b 3b             	mov    (%rbx),%rdi
   9:	e8 ec f8 ff ff       	call   0xfffffffffffff8fa
   e:	48 85 db             	test   %rbx,%rbx
  11:	74 1a                	je     0x2d
  13:	48                   	rex.W
  14:	83                   	.byte 0x83
  15:	c4                   	.byte 0xc4
[  164.869568][T42994] RSP: 0018:ffffc900022dfbc8 EFLAGS: 00010246
[  164.875504][T42994] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff81580d23
[  164.883352][T42994] RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff8882004c8014
[  164.891213][T42994] RBP: ffffffffc020dba0 R08: 0000000000000001 R09: ffffed1040099000
[  164.899068][T42994] R10: ffff8882004c8007 R11: ffffffff81e792d8 R12: 00000000ffffffea
[  164.906921][T42994] R13: ffff88810dc18390 R14: ffffffffc0446ab0 R15: 00000000ffffffea
[  164.914770][T42994] FS:  00007ff3e6309840(0000) GS:ffff88821483e000(0000) knlGS:0000000000000000
[  164.923579][T42994] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  164.930038][T42994] CR2: 000055c480d92328 CR3: 00000001ec872005 CR4: 00000000001726f0
[  164.937888][T42994] Call Trace:
[  164.941038][T42994]  <TASK>
[  164.943841][T42994]  ? __pfx_fuse_fill_super (kbuild/src/consumer/fs/fuse/inode.c:1939) fuse
[  164.949619][T42994]  deactivate_locked_super (kbuild/src/consumer/fs/super.c:434 kbuild/src/consumer/fs/super.c:475)
[  164.954861][T42994]  get_tree_bdev_flags (kbuild/src/consumer/fs/super.c:1699)
[  164.959839][T42994]  ? __pfx_get_tree_bdev_flags (kbuild/src/consumer/fs/super.c:1662)


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251126/202511262155.f86d1a5f-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


