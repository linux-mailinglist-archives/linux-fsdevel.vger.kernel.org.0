Return-Path: <linux-fsdevel+bounces-31831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F0099BF9F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 07:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06A9B282C25
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 05:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2AC13CFB6;
	Mon, 14 Oct 2024 05:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E3m6z0YF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148D854670;
	Mon, 14 Oct 2024 05:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728885532; cv=fail; b=a4EgGYJXaSUUoOKKheqwP0fv2YVUrO3Z9WXjsuQV2LZ27hsw2wH/qOuyffUdr25Z/orON7TYt6dCTU6IjUgmc1+aTa5PXKdfJnB4I8rmovoaQ9SnSH0hO0bS6170LA5j18SmpbxRUhBmnURcDFMP9IEHUeQ3W2QT5N7wuw6vy5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728885532; c=relaxed/simple;
	bh=bHkKh3DWueOanX9tnUWeCDSwkv4HlrHXt6yrpWbriTo=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=O2ys14a973xffJD+/J12eYYWeXCkTeR6zlz3qN7jM2pcmrr6GtaUQur96KaC53IKiBVrz/SU1/MAt6AdMJlunfMrvH7Nk2xjRIWQukZxwLKhazblz5s0lZ+Z/7M4Lp7p+djyy9IA9arevq11IrjkRPPLhWfWpuTGRQMpDBceBkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E3m6z0YF; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728885529; x=1760421529;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=bHkKh3DWueOanX9tnUWeCDSwkv4HlrHXt6yrpWbriTo=;
  b=E3m6z0YFv5cwCFHi96rfqWoQsyAWGWchFqPnvSWayBmtBAJsc6Z+1Xst
   yAiODPHdwXU7Jb2I6QcVp6i55mISXMSPnhbsyVDjMf6F+jk8SdL8HJmry
   jFgYzMX34QJ+lwGa7t37Ve+yk413Aq1g+b+SriiLAikEQ+BY5zfgaoY/v
   O0eSq8iQxaeYBR7hW768RqPo/AuEiQv4aluOqpmmzmSF16QqSLwb3cnS6
   6cgfvWs098fX8OcL/nvbFPCzW9ot6e9t9Uv4rsm8T2neYfXZS4eTR89qN
   0TOGsMav1W4nVsYVZ1HGC+kYva/UlOxAWQIroN4Fo9oTP1SWyVSTsRaxC
   Q==;
X-CSE-ConnectionGUID: lL5uI1K0SN+9nAHEPSOu9g==
X-CSE-MsgGUID: F62x0ya9RBG0kC3a6PJN/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="38772098"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="38772098"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 22:58:48 -0700
X-CSE-ConnectionGUID: y2f0th8jQwmf8ycw4UVhJg==
X-CSE-MsgGUID: aWf9FpbpTCmconwBeQ3gaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="77649065"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2024 22:58:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 13 Oct 2024 22:58:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 13 Oct 2024 22:58:48 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 13 Oct 2024 22:58:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DkW8WEGdzvBE7b6x5VKn4kubk8qs5PjaMTVL0GOc+BRU29x0tWOlL798QJOM7YjxhJ+jipBjc6WGsFhm82/j8YXCVZEO77IPnr0JJYcYMgXW+hYwdhwH36Lf2q326WZN6yxhxNeJQem4CE1WsY20UKB5Dg0f/E9/MMwTzpwIW3L/dhbk7kOroDx8mjuVht4H6kDGnHGttf5jchyiIZ+3MK2Hv8tqFVZSw+GTgoJ+3qcPIE0y1l0pWXlAZw9ZYU/VohY8/DzY7kK1BJlIShCkJZ2nG4k+Jiwlq1tj//DicYf1ZAK5ZV8J04ciOIb+RBIdG+yl+Nlxgn4tSp6ASct5ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JbtLL19ghMbQ4QfBDUDt0T8CeDEu9OeGkIVXmhXb/Jg=;
 b=CqucoMTigUZyYSvOMlNeoeuSRvCm7cDlxlLPWUPvpF39r0L61xiFYNSwckjIHlprJTX60xugqvzvpEZl8xvBZOZSkV10J10/mOemWLTHZ+lWCRwVkvnFTN9gJFOg72C0wYdYWQqT3uWFIxTp3HxMLfp/kHdMawXQdEqmHJRsUTl7UyYq6Gq3BRVA0gJuZ/cdAjqgsPx0FBiymMx1Xbv0EREjio5YqLEUijib4uUR+nG9V5JM94Imt4QoMCZVuWMExiUON4vEC6vD7yTRYf/aR4K6+phhH694eXiea7VnTamWPhDXTK5ROxXDCeOL/WcW1pwxpFkHOD7CbcG1R7QhoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB4878.namprd11.prod.outlook.com (2603:10b6:a03:2d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Mon, 14 Oct
 2024 05:58:39 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 05:58:39 +0000
Date: Mon, 14 Oct 2024 13:58:28 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Jeff Layton <jlayton@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Josef Bacik
	<josef@toxicpanda.com>, <linux-fsdevel@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<oliver.sang@intel.com>
Subject: [linus:master] [fs]  e747e15156:  aim9.creat-clo.ops_per_sec 4.2%
 improvement
Message-ID: <202410141350.a747ff5e-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB4878:EE_
X-MS-Office365-Filtering-Correlation-Id: c42b2500-4d10-44cb-4a42-08dcec154012
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?AU3JrhH51IDIGbBja48G4/4/eGGGto99gsuCHHGOk+bc/0xi4lzBqlJer3?=
 =?iso-8859-1?Q?v9IUJgtlbY6Oyeb50Cx09vAh3lKrzubiq2bb3Fw1IBr412bMtwmrEWsGS7?=
 =?iso-8859-1?Q?M9BvmU2olVBUDmAtUA9x1o+m5i5N2Ry6Lq5sLiOnM+60gF33bKVdq6Iop3?=
 =?iso-8859-1?Q?CVSR1xdcmJ6W6qoCTLpznazIetpWORsBpFU0zXVp+7PQ8cwXX2a4X6Wa3F?=
 =?iso-8859-1?Q?VBn1ay8rtvc9Sq7RIpGa7h6MVzxWdQFps+SBzffW6/hjqN0Q9Ys1+azXSY?=
 =?iso-8859-1?Q?nzoJtMKprUG+ylewQPNquqMbRoScB+UTVZHM+bahAn1+FKm0RmTUZivyZX?=
 =?iso-8859-1?Q?0OE7vV7pZ/gANqYidgET9AvQaDIw9HDRcu+l17xtpPqaLIRjn+kHTIyv3H?=
 =?iso-8859-1?Q?knEDZKsb/wLmb8aA3yORGWBkOzF3i6xvN3HBgr+bV2Ek8OyVdneLNIzgQR?=
 =?iso-8859-1?Q?w+zlWZ2lgKE0VmaMM9g0zl49Jj6/dT0D9KH/Zp7hXaYww2SDQODlmEMK1S?=
 =?iso-8859-1?Q?xACJulX90oxcZiziIa3YxBaHbdypnJtEIMFGkGAij1vv4x9W6ycNq2cqmO?=
 =?iso-8859-1?Q?xqqO1N37t0seMa+pzfcVLA2D6AO+qOE/P6X7dgQ0aBrNvntnnS3qoK22/u?=
 =?iso-8859-1?Q?pG/f1Gcsk32MdV0mPEUHd+TVeH3odqlCwUrHua1txTBbgOe7bkK/N2g7UJ?=
 =?iso-8859-1?Q?ujCnhN51MoC0GM2wWBNHxfOgid/Qrz6M/T0EAp6q9fom/L5Zlx/aaoJzKB?=
 =?iso-8859-1?Q?7KZ4/lBEpAZ3Znqx5zNpPsrigOHUVlPylxby9hDKaA6CvhQoEir2mHlYHH?=
 =?iso-8859-1?Q?z3hcCNq1xQkhJnjTHSVlmMPe71tSE4NOUrJT/fchQHwJUSwN3Zbv0aSFZq?=
 =?iso-8859-1?Q?i88a+7elz4UXr8JPfzsUWkAmGZOy1O41i9DqAEUArERDpiBbexldzVXOlO?=
 =?iso-8859-1?Q?bYukIjWbvDlfAJibugNhuXlw7RhbpDS5/H74oewuO99qAxBslJ3iEm1aW6?=
 =?iso-8859-1?Q?M0ZBZjMtRk02USfxe7bUpPqWj4tATH7Va1086ZR3fUIa83tbMhHC+LJtmu?=
 =?iso-8859-1?Q?c1yzV+0zcLbCLsiFm66RTEtudxFKiBIB/boAxqEB8Xnk9unQBrXw/5goyL?=
 =?iso-8859-1?Q?k7/4eS20scUcRQ9KpfYO+JLafAWFPod365q4WXWui+BsPdOCknZvOvMTy4?=
 =?iso-8859-1?Q?b/e1b/hkDUJ/ooef8to0aMpCqeDRJrJ2LQZNpCX1MfCZUo//4LbjtqipDw?=
 =?iso-8859-1?Q?74Cfid6sAZQzUzeN8T095xOk/Mya8siluNC+hxWp0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?tn9d9Ef9kz9p2CPF1zrcH8pvmM5vFMx+NbMiB5OpWo8Wh4qwQrfPyn0nrC?=
 =?iso-8859-1?Q?dBp4Q8LapErBgk24gm5qgx7kvi+ub+ee8nuK6PIVeql8XCqrNgX1BdVgqx?=
 =?iso-8859-1?Q?3fwjolJVQ879bfmbOjqUOSGVpzCN9BTvAwrtJDFedhHLgFeBqyHDZy3QZe?=
 =?iso-8859-1?Q?ePvcRuagdehPw8OIdpWs41ibMUafACvy5j3t8wxBkLG9nGXMoZjP7nR4RD?=
 =?iso-8859-1?Q?OuBHWql4jdylZj91+GNh5WfpwLNarzKs7lT8R20Ckw4nYMOt+rwbPiUQat?=
 =?iso-8859-1?Q?hqFyq3s1ILPFPI7+Uo5CCLD54hP/H+e6NE9gCwONhaRNXs/jcblTTiKp2k?=
 =?iso-8859-1?Q?xL2Slt2JZVsamytTWKLcJ4VtmlujRTtXxR3RMVOCO9ftnMQi++G6LPTytB?=
 =?iso-8859-1?Q?GYLz4pgJIjpEQegC7ws7B79N8XPAomBfJuHHeVKOIZHILkmDEG3u9vaWsV?=
 =?iso-8859-1?Q?7MTJwVJm6lRqsDvXCxipZNDNt/pquTddjYICjbBo/M8a6Mkf6OnpLN9Cf9?=
 =?iso-8859-1?Q?AeSUQyDCdbq5+wvqtox8ol7FU5bMa83iiWXdOkm6IWbXTDFINF2Ij5adpq?=
 =?iso-8859-1?Q?0Fx+ogRCt/6QRyFZDEFIj73xhWmr8HlBDfA5JDB9vKTYnOzsLKbT9aQoE0?=
 =?iso-8859-1?Q?odNlrexFBp0CZmksfLF0n6FYZRufibVTWeQVKor9tAf0ixSQSZO9/oTEV+?=
 =?iso-8859-1?Q?P6g9nGfuflEdIB9sCDX+T+i6hgHVOsxSRVP97yc2Bccnhcv6nrVIDasEY5?=
 =?iso-8859-1?Q?WYQA3veiE0wUoujPAUOii85DiTKlpBPB+QsMy8ADvBrLvczTqQJkse/Pp3?=
 =?iso-8859-1?Q?PKDI0Q51GkF/kZA0kKf4OO/tTTJ97vQVCRK4HR9iwpjBz0e5Dn5/QWigF+?=
 =?iso-8859-1?Q?aiLU5ka6Vbq75fy3+ER68YMagx5WUhFUJkdxsMsNrdYML1IYfvdRlpp6Qa?=
 =?iso-8859-1?Q?O/TLXMRqHTk5WjqNqSpLhiXWN8HfceXyAzjYSeD5cwlF0RZb8bBCbdbnF4?=
 =?iso-8859-1?Q?p5KgyhWAlKEQjGULlDI46/WGSwgGXoei9zHN4woKIFj78juUzuugVFNJ9R?=
 =?iso-8859-1?Q?vRJvo+xY9OZLmIlaGg2f2XInBikVyxszSO7ql/kK2a+A8eEmDOolQUNy+l?=
 =?iso-8859-1?Q?jdfszDAe/1u9ijRCtwYrXLP2XrqK6xFgVPg3AWx2xv0lzQmXvY9PEbR1P8?=
 =?iso-8859-1?Q?tXfaLa88DIfiG8qV3fvRs4XoE2SUkdt0wDZy/pvVsvypJoinIJFes83uUa?=
 =?iso-8859-1?Q?y3NaYDOiS/SaJ9OWHVIS7YdQXxkdqjvX8ErJcAAAV9fopEDMjENFyLdkQI?=
 =?iso-8859-1?Q?yz3kiJHvAIohHeZeVhpD111FNY0j8cAcvSYkt+qC19ZfalqsTst/W0/LE8?=
 =?iso-8859-1?Q?tvrRgqqW4Hkv9QZqe2fVtPJgorWryXqAn2cfdGiAuZJNk36zwdJ3B9ZHRf?=
 =?iso-8859-1?Q?mTfJtPK77AOOPQANmLcP8uK3u2AWF7UxA2mUaSFapTcdcPJZDHE5RT3GoM?=
 =?iso-8859-1?Q?vBopVErsLPKYbCdYrmCy74t0HgDEroTfa99N30dqCvdwBmWljwuWZ6/vAX?=
 =?iso-8859-1?Q?yitXtmxm6eUJPlJBdEhne11MZU/lFk61lE9lBvqm+fJcDaOhD/dPoCMUaz?=
 =?iso-8859-1?Q?juu7eXMEqSvybGOjr9XZHTK9BnFlUAjAu9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c42b2500-4d10-44cb-4a42-08dcec154012
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 05:58:39.4537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rtdoIsHnkF2XbBPcclIrE9fjhbPBwLMIS+ev87pDBhnB8KBFNoRj3F6LduSLOX/jAjSQ2mXWLgtj9gxMpOkmxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4878
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 4.2% improvement of aim9.creat-clo.ops_per_sec on:


commit: e747e15156b79efeea0ad056df8de14b93d318c2 ("fs: try an opportunistic lookup for O_CREAT opens too")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: aim9
config: x86_64-rhel-8.3
compiler: gcc-12
test machine: 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 64G memory
parameters:

	testtime: 300s
	test: creat-clo
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241014/202410141350.a747ff5e-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-ivb-2ep2/creat-clo/aim9/300s

commit: 
  b9ca079dd6 ("eventpoll: Annotate data-race of busy_poll_usecs")
  e747e15156 ("fs: try an opportunistic lookup for O_CREAT opens too")

b9ca079dd6b09e08 e747e15156b79efeea0ad056df8 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    448590            +4.2%     467421        aim9.creat-clo.ops_per_sec
      5868 ± 71%     -99.7%      19.67 ± 79%  proc-vmstat.numa_hint_faults
      2929 ±112%     -99.4%      17.33 ± 96%  proc-vmstat.numa_pages_migrated
      2929 ±112%     -99.4%      17.33 ± 96%  proc-vmstat.pgmigrate_success
      0.04 ± 61%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.mnt_want_write.open_last_lookups.path_openat.do_filp_open
      0.09 ± 62%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.mnt_want_write.open_last_lookups.path_openat.do_filp_open
      2.12 ± 44%  +24071.1%     512.02 ±176%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.04 ± 61%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mnt_want_write.open_last_lookups.path_openat.do_filp_open
      0.09 ± 62%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mnt_want_write.open_last_lookups.path_openat.do_filp_open
 7.648e+08            -2.8%   7.43e+08        perf-stat.i.branch-instructions
      1.60            +0.1        1.69        perf-stat.i.branch-miss-rate%
      1.14            +2.6%       1.17        perf-stat.i.cpi
 3.776e+09            -1.9%  3.706e+09        perf-stat.i.instructions
      0.89            -2.6%       0.87        perf-stat.i.ipc
      2.00            +0.1        2.10        perf-stat.overall.branch-miss-rate%
      1.11            +2.4%       1.14        perf-stat.overall.cpi
      0.90            -2.4%       0.88        perf-stat.overall.ipc
 7.623e+08            -2.8%  7.406e+08        perf-stat.ps.branch-instructions
 3.763e+09            -1.8%  3.694e+09        perf-stat.ps.instructions
 1.135e+12            -1.9%  1.113e+12        perf-stat.total.instructions
      2.34 ±  5%      -1.7        0.69 ±  8%  perf-profile.calltrace.cycles-pp.open_last_lookups.path_openat.do_filp_open.do_sys_openat2.__x64_sys_creat
     23.22            -1.1       22.16        perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_creat.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
     23.56            -1.1       22.49        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
     23.68            -1.1       22.62        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.creat64
     23.27            -1.1       22.21        perf-profile.calltrace.cycles-pp.__x64_sys_creat.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
     18.68            -0.8       17.84        perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_creat.do_syscall_64
     19.05            -0.8       18.26        perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_creat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     29.56            -0.7       28.81        perf-profile.calltrace.cycles-pp.creat64
      0.86 ±  3%      +0.0        0.90 ±  2%  perf-profile.calltrace.cycles-pp.security_file_alloc.init_file.alloc_empty_file.path_openat.do_filp_open
      1.29            +0.1        1.38 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.creat64
      1.01 ±  4%      +0.1        1.12 ±  5%  perf-profile.calltrace.cycles-pp.ima_file_check.security_file_post_open.do_open.path_openat.do_filp_open
      1.07 ±  5%      +0.1        1.18 ±  5%  perf-profile.calltrace.cycles-pp.security_file_post_open.do_open.path_openat.do_filp_open.do_sys_openat2
      1.53 ±  3%      +0.1        1.65 ±  3%  perf-profile.calltrace.cycles-pp.cap_inode_need_killpriv.security_inode_need_killpriv.dentry_needs_remove_privs.do_truncate.do_open
      1.65 ±  3%      +0.1        1.78 ±  3%  perf-profile.calltrace.cycles-pp.security_inode_need_killpriv.dentry_needs_remove_privs.do_truncate.do_open.path_openat
      0.71 ±  6%      +0.1        0.84 ± 13%  perf-profile.calltrace.cycles-pp.kmem_cache_free.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      1.72 ±  3%      +0.1        1.86 ±  2%  perf-profile.calltrace.cycles-pp.dentry_needs_remove_privs.do_truncate.do_open.path_openat.do_filp_open
      1.32 ±  3%      +0.1        1.46 ±  4%  perf-profile.calltrace.cycles-pp.__vfs_getxattr.cap_inode_need_killpriv.security_inode_need_killpriv.dentry_needs_remove_privs.do_truncate
      2.57 ±  6%      +0.2        2.82 ±  4%  perf-profile.calltrace.cycles-pp.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2.__x64_sys_creat
      1.32 ± 14%      +0.2        1.57 ±  8%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2
      0.74 ± 23%      +0.3        1.02 ± 16%  perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.alloc_empty_file.path_openat.do_filp_open
     11.00            +0.7       11.66        perf-profile.calltrace.cycles-pp.__close
     10.48            +0.7       11.19        perf-profile.calltrace.cycles-pp.do_open.path_openat.do_filp_open.do_sys_openat2.__x64_sys_creat
      2.39 ±  6%      -1.7        0.72 ±  7%  perf-profile.children.cycles-pp.open_last_lookups
     23.33            -1.1       22.26        perf-profile.children.cycles-pp.do_sys_openat2
     23.28            -1.1       22.22        perf-profile.children.cycles-pp.__x64_sys_creat
     18.79            -0.8       17.95        perf-profile.children.cycles-pp.path_openat
     19.13            -0.8       18.34        perf-profile.children.cycles-pp.do_filp_open
     29.79            -0.8       29.04        perf-profile.children.cycles-pp.creat64
     29.48            -0.8       28.72        perf-profile.children.cycles-pp.do_syscall_64
     29.68            -0.7       28.97        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.48 ±  5%      -0.4        0.05 ± 48%  perf-profile.children.cycles-pp.lookup_open
      0.92 ±  9%      -0.4        0.50 ±  7%  perf-profile.children.cycles-pp.try_to_unlazy
      0.78 ± 10%      -0.4        0.40 ±  7%  perf-profile.children.cycles-pp.dput
      0.79 ±  7%      -0.4        0.42 ±  7%  perf-profile.children.cycles-pp.__legitimize_path
      0.53 ± 13%      -0.3        0.26 ± 10%  perf-profile.children.cycles-pp.lockref_put_return
      0.52 ± 10%      -0.2        0.32 ± 14%  perf-profile.children.cycles-pp.terminate_walk
      0.39 ±  6%      -0.2        0.20 ±  8%  perf-profile.children.cycles-pp.__legitimize_mnt
      3.25 ±  2%      -0.2        3.07 ±  2%  perf-profile.children.cycles-pp.notify_change
      0.76 ±  6%      -0.2        0.58 ±  9%  perf-profile.children.cycles-pp._raw_spin_lock
      0.45 ±  7%      -0.2        0.28 ± 14%  perf-profile.children.cycles-pp.mnt_want_write
      0.52 ±  6%      -0.2        0.35 ±  7%  perf-profile.children.cycles-pp.security_inode_setattr
      0.33 ±  6%      -0.2        0.17 ± 15%  perf-profile.children.cycles-pp.lockref_get_not_dead
      0.32 ±  3%      -0.2        0.17 ± 12%  perf-profile.children.cycles-pp.down_write
      0.60 ± 15%      -0.2        0.45 ± 22%  perf-profile.children.cycles-pp.step_into
      0.31 ±  6%      -0.1        0.16 ±  9%  perf-profile.children.cycles-pp.up_write
      0.45 ±  7%      -0.1        0.31 ±  4%  perf-profile.children.cycles-pp.mnt_get_write_access
      0.48 ±  6%      -0.1        0.36 ±  8%  perf-profile.children.cycles-pp.__cond_resched
      0.35 ±  8%      -0.1        0.27 ±  5%  perf-profile.children.cycles-pp.evm_inode_setattr
      0.42 ±  9%      -0.1        0.34 ± 13%  perf-profile.children.cycles-pp.generic_permission
      0.15 ± 12%      -0.1        0.09 ± 12%  perf-profile.children.cycles-pp.getname
      0.20 ±  6%      -0.1        0.14 ± 13%  perf-profile.children.cycles-pp.rcu_all_qs
      0.13 ± 13%      -0.0        0.10 ± 17%  perf-profile.children.cycles-pp.mntput_no_expire
      0.09 ±  6%      -0.0        0.07 ± 11%  perf-profile.children.cycles-pp.can_stop_idle_tick
      0.06 ± 47%      +0.0        0.09 ± 10%  perf-profile.children.cycles-pp.inode_newsize_ok
      0.87 ±  2%      +0.1        0.92        perf-profile.children.cycles-pp.security_file_alloc
      0.03 ±100%      +0.1        0.08 ± 11%  perf-profile.children.cycles-pp.pm_qos_read_value
      0.53 ±  5%      +0.1        0.59 ±  3%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.19 ± 11%      +0.1        0.27 ±  8%  perf-profile.children.cycles-pp.setattr_prepare
      0.34 ± 10%      +0.1        0.42 ±  3%  perf-profile.children.cycles-pp.simple_xattr_get
      1.08 ±  5%      +0.1        1.19 ±  5%  perf-profile.children.cycles-pp.security_file_post_open
      1.02 ±  5%      +0.1        1.13 ±  5%  perf-profile.children.cycles-pp.ima_file_check
      1.55 ±  3%      +0.1        1.67 ±  3%  perf-profile.children.cycles-pp.cap_inode_need_killpriv
      0.33 ± 11%      +0.1        0.46 ± 24%  perf-profile.children.cycles-pp.apparmor_file_open
      1.67 ±  3%      +0.1        1.80 ±  3%  perf-profile.children.cycles-pp.security_inode_need_killpriv
      0.37 ± 10%      +0.1        0.50 ± 20%  perf-profile.children.cycles-pp.security_file_open
      0.35 ±  7%      +0.1        0.50 ± 20%  perf-profile.children.cycles-pp.security_current_getsecid_subj
      1.74 ±  3%      +0.1        1.88 ±  2%  perf-profile.children.cycles-pp.dentry_needs_remove_privs
      1.34 ±  3%      +0.2        1.50 ±  4%  perf-profile.children.cycles-pp.__vfs_getxattr
      2.98            +0.2        3.17        perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.57 ±  7%      +0.4        0.98 ±  6%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.63 ±  6%      +0.4        1.08 ±  5%  perf-profile.children.cycles-pp.lookup_fast
      0.00            +0.5        0.54 ±  6%  perf-profile.children.cycles-pp.complete_walk
     11.22            +0.7       11.89        perf-profile.children.cycles-pp.__close
     10.53            +0.7       11.23        perf-profile.children.cycles-pp.do_open
      0.52 ± 12%      -0.3        0.26 ± 10%  perf-profile.self.cycles-pp.lockref_put_return
      0.73 ±  7%      -0.2        0.56 ± 10%  perf-profile.self.cycles-pp._raw_spin_lock
      0.38 ±  7%      -0.2        0.20 ±  8%  perf-profile.self.cycles-pp.__legitimize_mnt
      0.33 ±  7%      -0.2        0.17 ± 15%  perf-profile.self.cycles-pp.lockref_get_not_dead
      0.30 ±  6%      -0.1        0.16 ±  9%  perf-profile.self.cycles-pp.up_write
      0.44 ±  7%      -0.1        0.30 ±  3%  perf-profile.self.cycles-pp.mnt_get_write_access
      0.72 ±  6%      -0.1        0.60 ±  8%  perf-profile.self.cycles-pp.do_dentry_open
      0.24 ±  5%      -0.1        0.12 ± 11%  perf-profile.self.cycles-pp.down_write
      0.35 ± 11%      -0.1        0.27 ± 13%  perf-profile.self.cycles-pp.generic_permission
      0.20 ± 21%      -0.1        0.11 ±  9%  perf-profile.self.cycles-pp.open_last_lookups
      0.16 ±  9%      -0.1        0.08 ± 19%  perf-profile.self.cycles-pp.security_inode_setattr
      0.16 ± 13%      -0.1        0.09 ±  6%  perf-profile.self.cycles-pp.getname_flags
      0.27 ±  8%      -0.1        0.20 ±  6%  perf-profile.self.cycles-pp.evm_inode_setattr
      0.14 ± 14%      -0.1        0.08 ± 18%  perf-profile.self.cycles-pp.getname
      0.32 ±  2%      -0.1        0.26 ±  9%  perf-profile.self.cycles-pp.common_perm_cond
      0.25 ±  5%      -0.1        0.20 ±  8%  perf-profile.self.cycles-pp.__cond_resched
      0.17 ± 11%      -0.1        0.12 ± 14%  perf-profile.self.cycles-pp.rcu_all_qs
      0.25 ±  9%      -0.0        0.20 ± 10%  perf-profile.self.cycles-pp.alloc_fd
      0.12 ±  7%      -0.0        0.08 ± 45%  perf-profile.self.cycles-pp.shmem_file_open
      0.13 ± 13%      -0.0        0.10 ± 17%  perf-profile.self.cycles-pp.mntput_no_expire
      0.09 ±  6%      -0.0        0.07 ± 11%  perf-profile.self.cycles-pp.can_stop_idle_tick
      0.11 ± 16%      +0.0        0.15 ± 12%  perf-profile.self.cycles-pp.lockref_get
      0.03 ±100%      +0.0        0.08 ± 14%  perf-profile.self.cycles-pp.pm_qos_read_value
      0.04 ± 72%      +0.0        0.08 ±  8%  perf-profile.self.cycles-pp.inode_newsize_ok
      0.12 ± 17%      +0.0        0.17 ±  9%  perf-profile.self.cycles-pp.setattr_prepare
      0.03 ±100%      +0.1        0.09 ± 15%  perf-profile.self.cycles-pp.lookup_fast
      0.17 ± 13%      +0.1        0.25 ±  9%  perf-profile.self.cycles-pp.simple_xattr_get
      0.26 ±  9%      +0.1        0.40 ± 25%  perf-profile.self.cycles-pp.apparmor_current_getsecid_subj
      2.62            +0.2        2.81        perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.41 ± 15%      +0.3        0.66 ± 15%  perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      0.57 ±  6%      +0.4        0.97 ±  6%  perf-profile.self.cycles-pp.__d_lookup_rcu




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


