Return-Path: <linux-fsdevel+bounces-32070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1CA9A0289
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 09:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8170B286D14
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 07:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B35D1B81DC;
	Wed, 16 Oct 2024 07:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kuzXlzis"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCEB1B393A;
	Wed, 16 Oct 2024 07:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729063653; cv=fail; b=hl9QRPDo73blYk/N3GBCf3XeHAKYSg2i8Jfo3fcYUfTpFJgVtwZnt+zmZFii/eU6cR72mPLoJ46SW79nUiJupRSoYuHk/pnia3ZbtICIsbWJ45jgWysCVn3OCOYTxWfCoDIvbR4DgMKP9ydO2zDyrWfQkf6InON6RJLuCGrsifg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729063653; c=relaxed/simple;
	bh=GliCOqUYPE5nb5iWhCHqVI1CA3j+88lkLOsKQaxefZk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=fuDVfho3BEtAc3oc7G1q4a65fZeM0oeXbQZ9wXiYi90b/zwzRr80d1BRJBuDoolCdQV6IR5RK7vvUIHPCfd3ZI5Qm1Ux56/nEl6Cw/L8wxLmgmn1DTTwWcuqkrLGV3hLaTSXOb8PubLCDO+7mdrzjTP01XJ03AIXe3cpHJZ5dD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kuzXlzis; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729063652; x=1760599652;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=GliCOqUYPE5nb5iWhCHqVI1CA3j+88lkLOsKQaxefZk=;
  b=kuzXlzis8xCh0L1qmThuujXtniO82GyapDh4kMHW7eUiAO3GnWIcgDwl
   QCk/sDvzAB6I51kBqhtpLF5A7uQswdlRc6Wm6ItZagkJ41+JigWgRcWuy
   ilAkYQkbaXBOSzJ0RE5dJ4I66NHz+T/MakR6WWpfcEe4/OiQ6Bj1geSMx
   axD+khDXKT8jYbMMEBJy8kkEYg2PAg/q+4s+SJXdBcAVzY1LU3AoULub1
   kXK0ymN/H/jLJ7ulT/82mDX4Zevxsn8ieZwXV0ceHwtKAf2z8Ejoi4iMD
   tGZRxI/JvpC7KCcTq+GJaoe14dW7ENL8gLg+oglQaJec60QmAz9NXXu2z
   w==;
X-CSE-ConnectionGUID: d2XCItApRXiRsDJDOV1Ufw==
X-CSE-MsgGUID: NqeOWg+qRP6v2MF8OMlHZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="39867827"
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="39867827"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 00:27:31 -0700
X-CSE-ConnectionGUID: IxoznmCZTgeNKmM1bYndgA==
X-CSE-MsgGUID: /kf19J2BQhqKcPkVeGf3xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="77818022"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2024 00:27:31 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 00:27:30 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 00:27:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 16 Oct 2024 00:27:30 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Oct 2024 00:27:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ri7OF4EJ4BEYyhkNlKV6P+yxT6y+O5fb/W03Oz1tyhVZx5XKPG9Xw9dz5eP4iFRNTo1MxvRAvCy6M4DFCqWNBfI05R9WTozGAUKKWV3KxmaeoPVTKwxDxMHg4+rNEn6bNxOyCNaKy53Ng3b4GY8BOv8QRos0hvzLPZSApcu3j5TFP5nuFVZkqMXJk1RWesNg0p/hDaE5l3zly55b1pnyeziOwCVzGnHh9fkGr4lcU7J3tj7mXFHEepynQc4bY8Mzr/NTed3dO3aRxbrYh3bAwX4/03Cg6P4yHkHEpW9ArjU0DxpFc6i4u1C8XeY1yzTHm/oChWfRFka6hDd120yI4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0pqvkLNBjhXDsRMywIURt2gdYjvGoylHAfSUDkJfxk=;
 b=vrPS6z2a5SPMp55nccaz9kMHJUah4+fG3hEDP/vEnJoDOn8CPfKGc5yN93/CX22LHv4XP7hijQkBU12EZ1a2JWByLBOVmNQV/aH8pY78QnMl5eoi1GtG0Ytky3/5NuaZ7bub3VHqNMod7qsA/tUbMSOr1W7JI3XLW+Z4JTmGvOxyTIYey/yf71Xo3PyBieeYRT5YWvGuhd7CnreUyLsaEy+w9DlbMl0U2np6S+M/XBBCPFidSmRAX+VE/dUEJbBMGmhQm6qE6OsUlxQL+syzAGQ66AnRv1THiKqJI4T4m0cP0q1BJXwHWWyZ8UCgUurPWw3KOu7+oOiO0VJmvXwwcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SN7PR11MB6972.namprd11.prod.outlook.com (2603:10b6:806:2ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Wed, 16 Oct
 2024 07:27:28 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 07:27:28 +0000
Date: Wed, 16 Oct 2024 15:27:13 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [x86]  2865baf540:
 stress-ng.access.access_calls_per_sec 6.8% improvement
Message-ID: <202410161557.5b87225e-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0036.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::23)
 To SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SN7PR11MB6972:EE_
X-MS-Office365-Filtering-Correlation-Id: b3286ae1-7e94-41fb-3946-08dcedb3fc02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?V5q1Fe+8FxJCT6kvwuhoZx3deFYMGda7AA6iCUbsW4R/YpqhUhW3ai2EKL?=
 =?iso-8859-1?Q?a1wEThTD13kiW8xspkn6ExiowloIXcolPF9DPlfneIRTX5K7mADh7KKtPd?=
 =?iso-8859-1?Q?doQQO+i35mIwlf0z36A5MYzEwoYRDDhh/44fXOR8zkUG9B+/cVdAnedbdE?=
 =?iso-8859-1?Q?MyrEXxyHTeDseQvldRrVNZZvvd0y6Nnw5XP40a7RM4221dYvLca/LdaMUw?=
 =?iso-8859-1?Q?BLk67Vw0ooX4KToh8N0h9IB5MVpo62WvF2UTEN+UrEYQ6JS3h0eGB0nVie?=
 =?iso-8859-1?Q?VQ4K3kV57iLsCsJIaFZDQpVLzgmRAS9Y8qxKiMkOUBWUzkd9yHrwpaGMNn?=
 =?iso-8859-1?Q?u8dJVKX2J+5yewPpPuC4Rc4CpVrjCDDjT8ajuyyH1DOGpbbNMvfIlr5cW0?=
 =?iso-8859-1?Q?KxV1/WTD2MTxRIB3r+2K+hzPL1WhdRWj/NnRI6mnRdavTD6YZ+aXdsoq2e?=
 =?iso-8859-1?Q?I3S/1grodVm4MCYAwQzlpfl8d5xElWk6C734obigRwei9oKsxq3lI+NdJ6?=
 =?iso-8859-1?Q?op30ysi+tIMlYCLVb8HQJR32xz8ju6hk9hC24psmnwg8/PjBnWDg0J6MBK?=
 =?iso-8859-1?Q?ExhgE9g10Q292I1s3RmlrUIZ+0pRJIxbKvV22fqlqIlKlvB+yQ9JpMHxWh?=
 =?iso-8859-1?Q?6pvU1pWMpPEthNahmoRIFFewJDnqbW2avpd9n+bjYhvBnuymLDG36bUT6/?=
 =?iso-8859-1?Q?/grcgX5kgfChxghrxK0+Y4vT/iI5r6ppkdUrSzfrI+q4bIdEOPHtQWnFI/?=
 =?iso-8859-1?Q?VP5dmbMSu7dzRMg4EaimNEhOyRuaHrg3DfroY+5fqo4WfuEep8p5k5pa9d?=
 =?iso-8859-1?Q?+86xq+05CD3W+BWPcj3/xCs8gLj3MI88vrvLTKi68gYC40UUa7Ouj+L6Gi?=
 =?iso-8859-1?Q?blIJEU4IfmAndUOiDbGYL69p+x53dFVzxlWzeO3H+C1sfFhqNi4TEEGL8V?=
 =?iso-8859-1?Q?RC24FBvtFjE7GtNt9+e3DD8N/Pg7B6aRbZukNHK9eavDpg9bdM+xAFBLHT?=
 =?iso-8859-1?Q?MtMzsFHPNGVs815BsMa/P3wKmGHM/cuYrjrpzlj4NDxCo99V7NMeH8tos8?=
 =?iso-8859-1?Q?bSGQFfOFyjRZv5cB5ZKRoI4rnr+ZMqFijpzoUEJtq1vjh4ZbUw9wm1baEM?=
 =?iso-8859-1?Q?FYOTSRBcWa9z8JZExKfZeiaFypRSSzoBeNshWOw93AY0yfPI2F5dY7GDjm?=
 =?iso-8859-1?Q?IiVU4ubed//zIpt1s2MtSoHZck5TASiKuAgJCFTH2E/0UCxBCDTLquxEFO?=
 =?iso-8859-1?Q?UGm9b2mrRqIng7Rwn64ATcfdF+oFZdk6fdTi8A+2U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?6+wKxkW+YlVBlErmUPhc9ykulb2EEfroN2uKNvIeBKCb6/D9QLisZlqW1J?=
 =?iso-8859-1?Q?8gLmzl0WbeEiU/CspzzxogF9q9/xQnMWRrK5Rl2jeZTUzEAH+KNnDFFZ+r?=
 =?iso-8859-1?Q?K6vTchw77uKcZ8WHOJ6XM/UGXodV4U+mxCAHZgt8sWYuVZlCQzKca6PmUQ?=
 =?iso-8859-1?Q?Sog4FcZR5eB0d/9umN8/XrIxUe8Yxoye0nZSBmThS22qhflRo13MmMOpze?=
 =?iso-8859-1?Q?iv669fc5lOs3ORTOnPgHXcdiq09T4lrgPr8Suh7ThMot2/a8ASfs40Tp4F?=
 =?iso-8859-1?Q?9ufQ/A6+wStUJzBz8fvL7mvc2jlb5eUAa6TxMiDrWxtX91QzKl9qTPlHdf?=
 =?iso-8859-1?Q?ENXOX9eYqipXRONObhGah2LEhAwFe4UFNo5vOaYBYpiWFXMLqMcuzNeT/N?=
 =?iso-8859-1?Q?RytNakH5c7NurksjyaroaxvOY/ryDnR7mCIrTolV/8jj2tg5GUN3y6MZd+?=
 =?iso-8859-1?Q?BzmYnt8oezzt4zk0pJTRJqF1XpiakAb+YuT/FDSsHtdJP9te5ZDyo0iYQ5?=
 =?iso-8859-1?Q?ACy0Cx7nDqPpUr8TBmr75mZRYe7q82xaOEpMKeU7sSKYP1BCltwAd4BzVM?=
 =?iso-8859-1?Q?tGV9QOpavvRX8+7uYMeYgoW7sJsSHGbi9xgEEJFtmwZ7hz/eU99E9HfV3p?=
 =?iso-8859-1?Q?mDhnu87vIsaTXm/8LRjZNWyYApbd3ront960tYEp0N+M9nhrK18PLsNREW?=
 =?iso-8859-1?Q?1rMrlCbiazhq9QzSxJwPpP/Gm2Yeb4KF2DRAKaiOK8z9rhxGeGoy5h0W0S?=
 =?iso-8859-1?Q?NLZubiH9yjf1ZhNzkBt9zz1NCXZINg4q5eNwn3d7iYgoboQmJ1OMFu3MQJ?=
 =?iso-8859-1?Q?c1SEEWMJFrNXb3FY//7vyJpLe3gNa52hplpoR4ikL4rM2C4R73FMdejTdy?=
 =?iso-8859-1?Q?Ocuz0bjPo4UNs54x44ez59Ou1gplnoNI3aZN3C+bU7QKZX0I54Xfp//aRs?=
 =?iso-8859-1?Q?MbFLttf47Lpl19pdHE9SEAPNOcNb/iw1QxtOWlQF9X2h7lWUb0ANyB5Fp7?=
 =?iso-8859-1?Q?qbbVAckC8PM47vIWM/8K0lLGbG6Pds/1Y/0t0rQGzMryl9IPz3KGh9gXHG?=
 =?iso-8859-1?Q?4jv4GyuUX7bw0hRINrzL+13GvslHMf27DFLaiTiRGiFiZMWLnAfzpBmqV2?=
 =?iso-8859-1?Q?QgWpTDxpTmQ9nEVtqzL/O9Pz5lDtuXi+1R4m6up+o+aQEhaJKXr7PEmDKY?=
 =?iso-8859-1?Q?SdcbpjaArgMah6f/oWucsZjC1bqkUUXgRCMitl35lD5Yg7KzG+zvG2nlQf?=
 =?iso-8859-1?Q?BRTc/VeuKUVwuca6MCF7cO52GEzM7KGmF+1eZMG4cWRuXh+Wtd3twiskkN?=
 =?iso-8859-1?Q?cOkTfvm/MHJN2cXNVCj6Zv/mqsgWRDvu40UjUfEW4UPgTo/C2kuaGglKF/?=
 =?iso-8859-1?Q?FnCmXuXJ+xSyTDlJvFO4lR09Y37YSojr1V8AHntWsHsfWUJuKb3pjxHxb0?=
 =?iso-8859-1?Q?7W+UBfEWkRjdwoIdW5oVclAheCPe5AuecBb+AzQEHEFKsRggiQQf6MGPfW?=
 =?iso-8859-1?Q?q73KqDmWPLa3ESZoDY2NzP6ygU6RnHO5zmMC/OR8qtx44ZwucmYLP2Q4fY?=
 =?iso-8859-1?Q?NM+Bbut9R6dz1fi7lPxMLGMGNSuCE4mPkSZV35NVhGtAt/6kClG/AlMBdg?=
 =?iso-8859-1?Q?8/xedn0DV64t77jPze/055Tpdf29LoRJ3H4v9sv+jgIANbvXbbDxUbhA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b3286ae1-7e94-41fb-3946-08dcedb3fc02
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 07:27:28.0537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AYG22DKripWD6ic2AAw9YYK2Wqdu3D/dZyQUSFtgMM8jAhW50dvgAxgIT0ffV7qGiqWKfNtKkEmQdykT/of1jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6972
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 6.8% improvement of stress-ng.access.access_calls_per_sec on:


commit: 2865baf54077aa98fcdb478cefe6a42c417b9374 ("x86: support user address masking instead of non-speculative conditional")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stress-ng
config: x86_64-rhel-8.3
compiler: gcc-12
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	disk: 1HDD
	testtime: 60s
	fs: btrfs
	test: access
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241016/202410161557.5b87225e-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/1HDD/btrfs/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/access/stress-ng/60s

commit: 
  v6.10
  2865baf540 ("x86: support user address masking instead of non-speculative conditional")

           v6.10 2865baf54077aa98fcdb478cefe 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      1008 ± 35%     -45.4%     550.53 ± 74%  numa-meminfo.node0.Inactive(file)
    100.41 ± 55%     -63.1%      37.01 ± 70%  perf-sched.wait_and_delay.max.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
   3373715            +6.8%    3603928        stress-ng.access.access_calls_per_sec
    252.58 ± 35%     -45.5%     137.68 ± 74%  numa-vmstat.node0.nr_inactive_file
    252.58 ± 35%     -45.5%     137.68 ± 74%  numa-vmstat.node0.nr_zone_inactive_file
      4.08            +3.5%       4.23        perf-stat.i.cpi
      4.10            +3.2%       4.24        perf-stat.overall.cpi
      0.24            -3.1%       0.24        perf-stat.overall.ipc
 3.326e+12            -3.2%   3.22e+12        perf-stat.total.instructions
      2.33 ±  5%      -0.2        2.10 ±  4%  perf-profile.calltrace.cycles-pp.syscall
      1.85 ±  5%      -0.2        1.63 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.faccessat
      1.86 ±  5%      -0.2        1.65 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.syscall
      1.76 ±  5%      -0.2        1.55 ±  4%  perf-profile.calltrace.cycles-pp.do_faccessat.do_syscall_64.entry_SYSCALL_64_after_hwframe.faccessat
      1.83 ±  5%      -0.2        1.62 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      1.87 ±  5%      -0.2        1.66 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.faccessat
      1.73 ±  5%      -0.2        1.52 ±  4%  perf-profile.calltrace.cycles-pp.do_faccessat.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      1.48 ±  5%      -0.2        1.27 ±  4%  perf-profile.calltrace.cycles-pp.user_path_at_empty.do_faccessat.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      1.49 ±  5%      -0.2        1.29 ±  4%  perf-profile.calltrace.cycles-pp.user_path_at_empty.do_faccessat.do_syscall_64.entry_SYSCALL_64_after_hwframe.faccessat
      2.19 ±  2%      -0.2        2.02 ±  3%  perf-profile.calltrace.cycles-pp.access
      1.84 ±  2%      -0.2        1.67 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.access
      1.86 ±  2%      -0.2        1.69 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.access
      1.76 ±  2%      -0.2        1.59 ±  3%  perf-profile.calltrace.cycles-pp.do_faccessat.do_syscall_64.entry_SYSCALL_64_after_hwframe.access
      1.40 ±  2%      -0.2        1.24 ±  3%  perf-profile.calltrace.cycles-pp.user_path_at_empty.do_faccessat.do_syscall_64.entry_SYSCALL_64_after_hwframe.access
      4.91 ±  4%      -0.6        4.28 ±  3%  perf-profile.children.cycles-pp.user_path_at_empty
      5.28 ±  4%      -0.6        4.70 ±  3%  perf-profile.children.cycles-pp.do_faccessat
      1.39 ±  4%      -0.5        0.84 ±  3%  perf-profile.children.cycles-pp.getname_flags
      0.95 ±  4%      -0.5        0.41 ±  3%  perf-profile.children.cycles-pp.strncpy_from_user
      2.41 ±  5%      -0.2        2.19 ±  4%  perf-profile.children.cycles-pp.syscall
      2.25 ±  2%      -0.2        2.08 ±  3%  perf-profile.children.cycles-pp.access
      0.12 ±  6%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.btrfs_init_metadata_block_rsv
      0.08 ±  8%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.btrfs_find_space_info
      0.10 ±  4%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.fill_stack_inode_item
      0.48 ±  3%      -0.1        0.40 ±  3%  perf-profile.self.cycles-pp.strncpy_from_user
      0.08 ±  8%      -0.0        0.05 ±  7%  perf-profile.self.cycles-pp.btrfs_find_space_info




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


