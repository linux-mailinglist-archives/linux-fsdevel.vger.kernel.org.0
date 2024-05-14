Return-Path: <linux-fsdevel+bounces-19407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFF68C4DAC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 10:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18F551F22B51
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 08:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2401862A;
	Tue, 14 May 2024 08:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="baXW2jUX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAE2182B5;
	Tue, 14 May 2024 08:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715675076; cv=fail; b=GaOEI2MV4wqLaby2StaAakc02rwwFRt3nO1muIXt1PCPPXCE08mUHvaGDeHra8tV34z9qoeGzTZTPVyZxRhN9kx3ffvVVfFz/u0DNk1MxP/+/KuYZ+qVliOIlR+E1fqfkzk2Ef11ihPRJeBo3hWDQAgGpH5cG2XdomT3ZGwy0vk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715675076; c=relaxed/simple;
	bh=BeHwasYg6aEA4WIMiC++CqZ+jhRg2MChAb6uZ+OflsI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UkYDpZ8eYchSrUSbyBhi8jZAL5Z+ucli6AVhcM/25JFUgaEgHSbORDozajOEm87XiYoz3iiMrWrlcr3DFfZHvao8YyOFqmaod+5fu8bIgC6T3+KXRoO5/mkqQOwsk2B7dOJEpwoN8xM40SRezZa0iOyprAKZP5XeV6kr901lR1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=baXW2jUX; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715675073; x=1747211073;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BeHwasYg6aEA4WIMiC++CqZ+jhRg2MChAb6uZ+OflsI=;
  b=baXW2jUXfkT7d3vWHpnC5s4SEWZMkOLqlfhBYxleonRpzlLpElGraIdc
   vAUCMdg0Pq14Qef30yEIHeu27PwduMgdwaXVcJ6ySFdwQC55NkE3fuU+x
   5ovbwl0dI6D5GJas0qf48FDli1MQ8f1DfbGiJdt8H20cUVxi8Pg3H29eK
   FPBOrYk3C0y9bjzUD0W8aW0L/ZamKjRg4dx7qejvGpIF6Yc91Zo5Np4va
   x0NKwXer5UGuU9/DWbdDjrN06nb26z56BYL+HLbG1SRiS70XM3kv1GhBJ
   PX/WFTAT1SAUJ+pdOgyA+MQPWQOLjpYrKsqdlNmzmJTH29pP8vIC50quB
   Q==;
X-CSE-ConnectionGUID: Ti7p/xqeTHmE5FnjkQsK5g==
X-CSE-MsgGUID: QU6Omxp9QASVOsTxkzIyOw==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="11775231"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="11775231"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 01:24:32 -0700
X-CSE-ConnectionGUID: m35sQIE1SOeJgIolhklINA==
X-CSE-MsgGUID: WouN9gjAQ6ip7jnVnMnplw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="30653370"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 May 2024 01:24:32 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 01:24:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 01:24:31 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 14 May 2024 01:24:31 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 01:24:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0IgNdRSdaY5KV163Zzcg4VUVPwjMeRN6E7r0ImqNo/e06q9dZ+d87T9YDaoVtirTgjP+jJrM7/TNILIegrENFTBV3RkWlD2p2iKiow8evOVU0Ertc9C1HnD3IG7x5TkD9Qno08wr2qZDXu7S6PK0aKoaQwdRdf55LjZAGC+4yov+qwggiWicv3Aithac2oSalEw4SZOAuISxLIaCZhJzj57ESx1uBBO6JOHogfkL8F6hYnC2wHKvtKg3V+ik3DZ6nT6DF06SWKRiQzA3r5k8oRMk1A2azQ6QXJtn5jcCKhSilTIY2VTffXHr8LfsMjXe4K303V1PuR+l6WCer+IEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHMWFMAzN/iDq0OSLekEW1AblTNdj7WxUY4ovi/0oys=;
 b=EG9uBAzpoQGF5nwuZO12AshHixtZJ9H8UXahDcerWb5AxUy9dB/Q2yro0QCFzEPALc6szb3CP30q/JOiPn6Gqxoikhi1CgLtMfleShZWfIYMiz9csOwv1xGzsl0sFVImdwJGqsC54spoVpVJkH154bAEmkRKTFqMDN+chO1pRsVqFePHFsLPhrxyROmowSz4JkBW5rWNld04J6woH04YfXeJv1VmV3vJjsUiTtR0qVpHOqRwUq8nixuNr530uMyKH7nx+TAPsOO0EIxpFdEazx7xiQugB6xj39CNrzwlLhlbm1QbkQmU7n8YeVwOa42n+EWWNyr36cXh8DTLCm9w0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SN7PR11MB6900.namprd11.prod.outlook.com (2603:10b6:806:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 08:24:29 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 08:24:29 +0000
Date: Tue, 14 May 2024 16:24:19 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: David Howells <dhowells@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Steve French
	<sfrench@samba.org>, Shyam Prasad N <nspmangalore@gmail.com>, "Rohith
 Surabattula" <rohiths.msft@gmail.com>, Jeff Layton <jlayton@kernel.org>,
	<netfs@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-cifs@vger.kernel.org>, <samba-technical@lists.samba.org>,
	<oliver.sang@intel.com>
Subject: Re: [dhowells-fs:cifs-netfs] [cifs] b4834f12a4:
 WARNING:at_fs/netfs/write_collect.c:#netfs_writeback_lookup_folio
Message-ID: <ZkMfs6m5KtcdhAAf@xsang-OptiPlex-9020>
References: <2145850.1714121572@warthog.procyon.org.uk>
 <Zin4G2VYUiaYxsKQ@xsang-OptiPlex-9020>
 <202404161031.468b84f-oliver.sang@intel.com>
 <164954.1713356321@warthog.procyon.org.uk>
 <2145949.1714121817@warthog.procyon.org.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2145949.1714121817@warthog.procyon.org.uk>
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SN7PR11MB6900:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f687b13-902d-44b0-350f-08dc73ef4654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4E5j45DP4EWcgGPk1j7YhV+lBwSgtMfZZ/M2exB4ayUB5PLkDGkUN9qEwgA9?=
 =?us-ascii?Q?wY0RSbj7h0tE1dpjfSe1uQ81vBFT0Q9EZ/1wwwNvc1qSIz+5/3DemQFwtZIw?=
 =?us-ascii?Q?uvQsLT8x5ErtYXrfHwmdwxgEo5Tpg06Tl9pvuf/rOkyIb/fjhVNumNTjU+yp?=
 =?us-ascii?Q?Lo8hiwmFoTAOBg+sn17qaRh6SzIPBHJwQgz92Y96OkmCt2mYjTVzC9g55Xv+?=
 =?us-ascii?Q?ZwA1ih4a2QtK2VbfdJXncLXcOKTZEJ09ZEYQCHJLTVboOeLT0UZWiSuHmg2M?=
 =?us-ascii?Q?aRfTO7zZz/is98grPkYCdaWdfaFUp7+vyvttcRWiTaXXcduDOHbO4zDlrxp9?=
 =?us-ascii?Q?L5GBs4s/zlU10KHZR4QbiYcXlzMozrpsxkGet4zrIHuZvG8cNiN5RGUx40+5?=
 =?us-ascii?Q?PMPf0Y3WkZiKdpfCZSzD0Iz5n49AKqq+qPY4FHqTQxWDQbpLid63G2rKhNiO?=
 =?us-ascii?Q?Ubk567Gm3fgmAlWsZfeFS5rPZqgMezEhvUdWIid4LFsoKU80M8bvwVRp3mxH?=
 =?us-ascii?Q?koj6bp1MS/BB/5s5W1e6/77pn9WIjSbP4GTz4R2U5MIyAA2kajEgRbX7Cr9e?=
 =?us-ascii?Q?ZZa+Az+PxJjvAKz3wWqIQnDE6lNWz/ZEKyOaQ+ox5VA6Zr07RN1xFznAuEMP?=
 =?us-ascii?Q?Yz3SN6h0tDdXNtkaD9CdTrgoGs0TwNLTqz0ImwFgCu8Coc+JeUgWDcAmvKuY?=
 =?us-ascii?Q?4fbguXIhPL+APy4yuxe2Yji56xBScKj9jKpU1MLDOSZk+oRXGzGc/eIKfUeq?=
 =?us-ascii?Q?Gc3r9114wvpzmJcEZb5nExVUFx7HxDK5KUPEFHKE9asQwmBmhtNYzwS1uRNG?=
 =?us-ascii?Q?tOi4rO/jY0JjE5i6FlGx4p0EX7yZohVvkHBjOVcBFLiE8EIGCeD8icAoMdz5?=
 =?us-ascii?Q?KKDRECK0zoHTWOmn5628EeCMtVxG6IZrQqKfG52A42G1rhZBc4gdc2CiRHMx?=
 =?us-ascii?Q?ao9YYqiYxF13PPc2w34ZISXfMHUcD5LD0iOLoes5Wd818aUjaOxRDmBPP3rC?=
 =?us-ascii?Q?WieL+hRVADyVZD2xtAuTCAN32S6v65NLgF6aN1q46fjFR7Sy9cb+5s4ksYkl?=
 =?us-ascii?Q?LBbzhGqzZZqdgwgzvwo7N50wsjcdksN7cLUGZBLI+2+SL0mWu4WDVsFXCDiD?=
 =?us-ascii?Q?Hdots9izTQ8ouGEowTx/bCS47gIlkCWraGxmd2LJd20lmE6BH6I1J1Ftxcac?=
 =?us-ascii?Q?DaARUeVag4dP1vE5JCnQPPQY41kbUzECgOhTHszvHUZWwtPb0cZkcSK6A6g?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6Is5elQeerUsRRfMeWCpfvBqZ+0qO9VEsPqh0lEvGcd/VJdOVBMX0xi3Arhf?=
 =?us-ascii?Q?zMh56NY9cMMQqGm+YEREdubV3RnsF7wn5w1zFm/3K7AKXBDjCoWwGiCYsgkk?=
 =?us-ascii?Q?sKpW5ciOsEuu3xgpf38BlwXw3Lok3zfQO9+Ctl2UzEia5FJ1fe8+rRpUTgX8?=
 =?us-ascii?Q?MSXPctzlcp/RbmAqB2jz6qRpJtTQCQMx10X/SwFmVKlDy88ykSUJ7nRZKFBZ?=
 =?us-ascii?Q?GU+5rxDEfkBuzHLmJiejVUEtOR01+4RA7vlm83ZEq/KucVeE3UAEL7L/rKK4?=
 =?us-ascii?Q?ySNIRnsPe3xnqtle7bo1596Y95BetiA7EyEwb7DGgRTdg8D549WaNQO/ixF1?=
 =?us-ascii?Q?VdZOOYlWaXXwnP9eegJQ6GWOGPbmZmhsUwtI2iMPmKTkUNyraRjU7jnE1wn6?=
 =?us-ascii?Q?rl4GxsVIPD5+aDzy7Y0XuX5hOxCU8IShKuCJeas7IB23E1imMvfgKAG9eV78?=
 =?us-ascii?Q?wKwGrREvbOlZTBUesteDnbgZoOo2zmYyNWWHNFQNu7LznGkYEQURFmgtWrZ1?=
 =?us-ascii?Q?Z3hse8wP9d2wlkGJfMolPkFSNBTQtb0iETyzLSTYCtOzTpaztwerB6FVmCbR?=
 =?us-ascii?Q?vh7zp2/uwjI6K4buF5LAk8ZVe4d+kNoEXV9odV2u8H5k/pwB+cMSIkhksSoM?=
 =?us-ascii?Q?rSVRJWyxrDZVfJT081RqnRw4ilrqfH74NeC9K4VB+6fAuhtffdVJIz4R2gR+?=
 =?us-ascii?Q?dwJmt1Inezf1PQ9aZ9dMQIKd+MLV8RPWxGAn8RVwlcpNpqFscr2lWJ/6aJoY?=
 =?us-ascii?Q?MWs0zAF6fLjfkHRY6sqsmsMBVArAaNE4eqLDtsA47mJk7y/0Iqy7WSbWSFMk?=
 =?us-ascii?Q?dV10+iQKnM3a0JlCMypYv5GAUS8r3JWb6tvosKwNYqZKspiJZo/RZLas3HPS?=
 =?us-ascii?Q?hPkYzouFmd0/iI7Uum8XMe7mcG0ynonquQJBXf2CBjJC20hnkLudsIcQN9Yf?=
 =?us-ascii?Q?5DLt85/lJ3+BVQSHw7Ae/rW1rakqX+rjVe9ufYjjAoFXUihkLN6pJ2A/ozxA?=
 =?us-ascii?Q?XVSMlLhrXUln95k+v5FqBfQGjbkmSJ9a2BDZ4OsmJNxwxT8We8km3bFLETiP?=
 =?us-ascii?Q?Zrqf9hdwmGe2XWbBN346082WxoP/+3AdbZQaB88Iwx3fUA64Y4SxV94MLxXQ?=
 =?us-ascii?Q?J9E9XkoclzijPrhYwRuvriiUFrcpia/qIve5KorYs2gO0pW8ttNwEP2JyGcb?=
 =?us-ascii?Q?jt/eN02QBifLMEqmI2NC6IH9CXIf3hkE2lGXhFKWh76l84utv0kShZVEE9++?=
 =?us-ascii?Q?ET4WokZCE1lvwFdZjgb6cQDCOPJUcDSgRVsSKgRR/oBsPU/TFVXpwjbXKuNA?=
 =?us-ascii?Q?RPH+Vq03wEncek8pI/OZxxmHCvK7nwG01RqFtRMJa/VG1u0k04Kgp5QlZlyE?=
 =?us-ascii?Q?CqdTpjm839a/rBdTQtI4g9kQTA8gI78pYX4524RthPZtlzV9ns52on0MTNzh?=
 =?us-ascii?Q?+ku9enXGU+uX3hni8QDyuIZZHxD8GTLIDd2JLJNOBlUMER8cqvvErQgBlhhU?=
 =?us-ascii?Q?SrO0d6TvvU+2R8qq6NpdWen74yeaZNB3YgQQqpI0+9bllr1WdhW9Ic5UkfW5?=
 =?us-ascii?Q?k3z58fHRq9TsIsQzowgukz/MyjPyGlMbn3AUQEcM+d8Iym1+phnunrZtIbQX?=
 =?us-ascii?Q?1A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f687b13-902d-44b0-350f-08dc73ef4654
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 08:24:29.4948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: REqmA86amYeT6Lae3/YmbkA7lnPasiLtzhkYk69FqF6+DwVVcaJR3+rohdYYgT/FaJ8WnGqCx4ihX0ih45kucw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6900
X-OriginatorOrg: intel.com

On Fri, Apr 26, 2024 at 09:56:57AM +0100, David Howells wrote:
> David Howells <dhowells@redhat.com> wrote:
> 
> > ==> Retrieving sources...
> >   -> Source is https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >   -> Cloning linux git repo...
> > Cloning into bare repository '/root/lkp-tests/programs/turbostat/pkg/linux'...
> 
> Actually, it cloned the linux git repo twice by http, once into:

this is quite bad ... fixed now.

> 
> 	programs/turbostat/pkg/linux/
> 
> which is a bare repo, and once into:
> 
> 	tmp-pkg/turbostat/src/linux/
> 
> which has all the files checked out.
> 
> If it must clone linux, can it at least clone one from the other?
> 
> David
> 

