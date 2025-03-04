Return-Path: <linux-fsdevel+bounces-43045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1162A4D396
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 07:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF29D16D850
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 06:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295921F4717;
	Tue,  4 Mar 2025 06:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KdnuHjj0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D8B1F4E2F
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 06:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741068911; cv=fail; b=VOZwM/poJwdXYlhkKWPdvIJ49URujpUa228+bqsuNXlIo8E0KEDWRAGOPDC+1sPWtUlI87ZE8nJqrHPwdHMe3WNm85uGdScIVEXRmS1oz4etVu8DaKnckFQtoNZq/GK/iemocPUpFwU6tAoij+5rfg0aRxO039PeDQZPtM9lJ/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741068911; c=relaxed/simple;
	bh=kCYE1Mx/miR4GxkZ3ULSCzOVXTc7kQVMfSBGIS/qnVM=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=HoSmCw4A5w1fq1QTnBaeXsdXTht2NGjZeYRHMkf7ZWx9w4F8Rmn1prnqPOVkEbx337xJo/RhlNn/+rsW+Lp0mwHiPHeEym7L4u35tXbv23f0xkvtEMoNaF/1NbZyXT0sMSxMKDggmcsf0NzCJn9XjgxA6L+n/lY+Z6RY+hpt4NA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KdnuHjj0; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741068910; x=1772604910;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kCYE1Mx/miR4GxkZ3ULSCzOVXTc7kQVMfSBGIS/qnVM=;
  b=KdnuHjj0lYwGYt8HaIjlWj/ZhkDmtkkho+wLUm/XQ53BVF85EPPassEW
   bL+Fl/Wgt6QoRSN65vEl4rHaOv4scWeH7WRbgLNzfQL3rQNXYeCu9Z8Zn
   f9VPpx71nS0JyO4uGXmMo5oVWdvduW+yGjVepvCoG1rGOVFxmJKc0SF4Y
   dPJ2fQOvNi6l+Rh3xn1GOUKEGzdKtRnINrLX+Cov4upyABMcl4YNzjAZK
   Q+OxUVR65HfaOjmSQL75bKBVZwDjPCQbHLFRoNs0T30YmszMxmRqRCAnT
   vaRc8z6If4pO+GNXLgDrVmlihenau8ZyE+tdYQ9PV9/vbfpeN+tYhNSsA
   g==;
X-CSE-ConnectionGUID: 5CrzAguvQPWtrfhOvD2gVw==
X-CSE-MsgGUID: Rg8V5uGkTB++P0ucECdO5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="42164153"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="42164153"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 22:15:09 -0800
X-CSE-ConnectionGUID: e2aI0mY6S8mjb8dpJRVKIA==
X-CSE-MsgGUID: d1Ij3yB5R52VyCepR6K/kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="118259170"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Mar 2025 22:15:09 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 3 Mar 2025 22:15:08 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 22:15:08 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 3 Mar 2025 22:15:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ibMu+FrVUTlkT4I0jcMiM4SyczChCQQat90JdaLIse46nifFjg36RFm5ivM0q7sWMBemQznC1Abnnyt634+M1eYisGs4R66d1ljvz6oMlxFrPFTqOxPstjvmzEcilvBcP48tTluWjxh29K7+RmFhLbN+ZMhUVnB4rlf7XIQi+6O0hv1Gtlyrok8FGwwJ4HcjqhvkoCfDzw+e3+4uhCR4m81RDEE5oBHPA7NOy3ze9IpLexPhSVD1+ImLFWNkWbncP3ABOAnLvwbTTQ6dolHNh54F5+4M7RqeR0GhzeHGTYdbvwrvTRivZl/DOiiDj4rkH4Fz5mHBJkttZwcFKSdR9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pn0VU78WQbpYgWUANDZBPRIbYBgF0lIc6v1+GEtUHQ=;
 b=igC+u5LDk/BbkBi+SI90Dy6/OdsVbmIhf7aDxH54+Ze7StKMVHuPQGZAPPdP15HPgrye7Q/PmZL3PbuUYEe95vaTxgnE+aJtF8tTgYHms3PxNHluB7GnBgNKtIhtujLcnO+5D/P0TKahQaqIkLHyIreMY3703ASSgC+924GIsBNJnyn6jcjvdjJ2yDbDKyxnMhqPzHg3LqRszaXQ3uglv3WMKh4AdDw6jgbAs+mVgofGlErt2waiVidoIHC1yBOfltxuHro3/E1dltq5nG97uT1gphPKmgkNhsx/HZH0/afmjX6OOcpruqluwlcKYLzXLgLNdaMRMyrx6QsSnMLA3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MN2PR11MB4726.namprd11.prod.outlook.com (2603:10b6:208:269::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 06:15:04 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8511.015; Tue, 4 Mar 2025
 06:15:03 +0000
Date: Tue, 4 Mar 2025 14:14:55 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Christian Brauner <brauner@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [fs]  becb2cae42:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <202503041421.38b0d0c-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::7) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MN2PR11MB4726:EE_
X-MS-Office365-Filtering-Correlation-Id: 694b4873-e75d-4e6e-ed12-08dd5ae3e6d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3sU4WW0kLWiMtTMaggTbb6QAAkp+tBemStsdtmwa8IajJVT3mVE+OsJhhLvt?=
 =?us-ascii?Q?8YZbcPNBuT3DkmG6J/MLHanoJlSJVGVN9p8titUQnVq7xCbou2s4cueCLylN?=
 =?us-ascii?Q?3KRB8IGwnQO93/eONlJ9xX6ogwqguKQNUaFNxof6KpsOAos4ZKJFQSSKIqIN?=
 =?us-ascii?Q?9s4FfAMmGColyk+Vg0HhFxgjEvz/1L0LHWCdwLot2mcRJ1HYzptry7IlOaVX?=
 =?us-ascii?Q?Xmi1mappBUc2h0PXfxy2HdxVGlczsfzEu7JIePZbKQO6+hz+SemjYk7fUdcv?=
 =?us-ascii?Q?P1lx+QbBvRjmF9A5u8YKP1xrnYRCTuoRDCIfOhccpueM7talZKuVBKX+0/uj?=
 =?us-ascii?Q?XIziqNYXalGUBzVsQYvNYfuZ6D+Qw06XPbvCIyXQdghDNwIjoHZE5eKzG5G6?=
 =?us-ascii?Q?hUPGhn0pp0Jddr8Gv6oZvp00P8ON/rAFYLSqcSkjhV+okhEQtZQl452WGr3m?=
 =?us-ascii?Q?EY8u3ODkU9xUpwcTwQSQN12xxyFXyNYRAa1VoYdIaJvpx81qGCazmgjtbLIt?=
 =?us-ascii?Q?1efW9wKb8P3D7w6g/yDV05/YlpK+clFlyZGWFMjaRopGuz09gwSwqRo/xxhb?=
 =?us-ascii?Q?qHXS5H43JJvNX8wi6xvwhJRO+ER/+J+B6fDPUJuSYRM1Wfkx3rx8pOLatIEI?=
 =?us-ascii?Q?H6m3Qtlorry7CjSY6OycdRzWwrMitg9oqP3pQrmWSqajoo7fRX0QsjizrpfC?=
 =?us-ascii?Q?myE5iD1PiAw5KfgA5jDkRht/PMAXKi2PeSJKyAuRBIGR7W4OHYHU1AzzejU5?=
 =?us-ascii?Q?xqAqbKg7/36VmX05lUuA93r1Tyq9tqatfUwjausfBHbvBOYAMD7CnflhciU5?=
 =?us-ascii?Q?/9w7YLf312kI50i8gE/m5c1qTVWGdi+Ozdwn/+JXEahQS1dvfHtWhMISboJW?=
 =?us-ascii?Q?r6tanLdzJjQxbh/Zfbn0ps0VRAG7SqW/scqOpOHJuj4x+khhed+rxf+UE2b/?=
 =?us-ascii?Q?xc/reQ/tI48gEzaOqErbWDNzgx9EUQ0YbGsLNsaoLOaglcbss2g+JHj5J2p/?=
 =?us-ascii?Q?nDLt2QDnLXfc7O9XWIAOG8KdO5hfCoPXhTH/dpdzjUpmOK8u52HaRbiu+hox?=
 =?us-ascii?Q?e1SjOduCLhsPrOjA/70yWYN9/Mk3q7OxMwhEMjdzQdSemS+YvEwl4PNAdbX2?=
 =?us-ascii?Q?+rwGiqRHNk+EV2HKh+GJXKw99LbOux+bi8Ijaeplx5TIU3d7PEF7c4S2BO0Q?=
 =?us-ascii?Q?e2PrNOMyX14bKJ5rstFwbqHFASLb7hBrkKlTapJgKpAQOGkQQg2YCIRzn524?=
 =?us-ascii?Q?P3Mpjl21v1pa2Xo1+i3Bz4cVLb2fMcs7m1eGRE4i3kSDC7S4JyVZYRbUC/nA?=
 =?us-ascii?Q?2kEnP/QfnF8wBdaSFOvWR8iCmTAyFkEtfx2g9QUb6baL2Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2Yl8mAw9JAQrE5w0auVaiM+wR+cc2t5Y9G8kC8RY5H+o8mavxJd7l+olziBv?=
 =?us-ascii?Q?lHC26htAVEPVwDE1RbAgCcPVk0DS17RCKQhs34UUnTNhM4SwpzHPlIS8Vg4F?=
 =?us-ascii?Q?RO1Vu400SPWLTZhOs15jMYJgTL7cP3MPF2I+yeyTZKrBZlyGFopu0XyAB5gz?=
 =?us-ascii?Q?zdcf9SXDVhh97SjBpCrJoMy7Zrci5ttrxzXv6Ea9O0IQeMYNIRQm2+FX5A0U?=
 =?us-ascii?Q?hAkYcgIxR3ZXtE9IgPO+Y5jAn5qj7B+Egkd25gFdaZd2iynqx+6NCUQL0+kx?=
 =?us-ascii?Q?tiNGVMQvG+UvJPs+/RMjAlRJrF5onVrrWHp22LCN8FvgIb2nn+Gqk8cRdcSM?=
 =?us-ascii?Q?udSmLnU2kp7VF4uUGsHN9nMxaga44Yw29uH4ThQ0Om2U4N+DThIGPQou1Px1?=
 =?us-ascii?Q?5LBuNCvbRD1Z9eVEwdBLXosaBxBx5XfurqdQE21svb8c1XdKi8LIJRJPPHQB?=
 =?us-ascii?Q?orqq0kb9EtKUUPWT9J0RUadMxo4XR0qex6yDP7dJOozzFEF0cUR7rwG5YmkU?=
 =?us-ascii?Q?bgHxYZFzVwTR1zvxj3ucKc0lLuYkDYZB1ZRBvrHo+3Fz3yee6EqFa3tvJoOo?=
 =?us-ascii?Q?jczW0EpmI7WLoAWKQJI71uCGWii9GW+KOh2rVOAJh1AmfjdArc23Jklrbg1x?=
 =?us-ascii?Q?/6ZjofOvRObl4AgUv++Nz8dTyKHOWKHs/w+plvivfDxJqkNoIUj8ohqdfr6k?=
 =?us-ascii?Q?TABLINuqGGwDumUYfuvDOSBQKya2llVPNM+Iy3uaNtBSj9+/45q0jeFnTtYa?=
 =?us-ascii?Q?IN110hQzD5S2TJ/fj+/sjbVcazEtyjA2lWGCK08AMN/R+pZVVBubP8nXoNts?=
 =?us-ascii?Q?UOQ14y0ciwxk9/ochpu5qHrQwhTldVrC+RPNDQrdOH9S9TaeIVsle0a+09GL?=
 =?us-ascii?Q?BP/DDb6hjJx0zDsQOnPX30FCqA1tMDHPNCG//pC1WGP0ZVA9aYEHzAVGQ0uG?=
 =?us-ascii?Q?v+E6V0Ah5GKSvib/GZq+hE32cipvdxDuIJILgJfLjxrkTn/wbrNhfw5kWOcQ?=
 =?us-ascii?Q?TzN6ViyqDD8c2TyAbyaE/AHD0aDbWHvpKk8WxCg2CHq2CZmKWNBUcIHBjLaV?=
 =?us-ascii?Q?mN1+WLYwuvjFxfQpx4ZE/DMtMFECaneUMJMhojsKMw+DTfCfLWjH5FRCkA2V?=
 =?us-ascii?Q?mMAifvKNfgCYqIECYeeoSVZaAL7PY1ztSBtDEU8U7qymCOVsrd43z0L3yCSo?=
 =?us-ascii?Q?0TxoInvS2DL5IY2C+EML7RlqRqcvsOUxAn5oiIz3CNk7pyW4PHI4Mk6jlQZp?=
 =?us-ascii?Q?s3gAlB1hdiOAyK46/UU96l99HZnXKF0Xwkdt/KpzMhMK/g56pPdgkPaYGc1m?=
 =?us-ascii?Q?bKMN2FCyxOgtPvVJBGpovSbKZYdZpKFoqI7aRiN23xWpg+H4ovpSoXt61V2B?=
 =?us-ascii?Q?l/A3EbBBkJJRhGQb0OgM6vMoCrZSATAqGjM163pbL170C31tPMSpXcpp0jCf?=
 =?us-ascii?Q?Ol+RZMTayOHQOCPUZwdFcLQOT8WPcCV/MFkNRey1ernoLeI0g4tywhCBzVV2?=
 =?us-ascii?Q?5cB5enL2PCJ9WCmj7KWNJf0zDRJBgQ16wx1d53XFH4YBhpieZW+HJQRJUrsk?=
 =?us-ascii?Q?Gb5WsYJRaTlub7BQNconF7mQvIkztCzUx4k7VBYLKsb8lzHm/dywCnZ3i+KS?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 694b4873-e75d-4e6e-ed12-08dd5ae3e6d1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 06:15:03.7000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ancJX89N/4KHBef4Xf2oDE7Wpu+PgqO3CPW0p9oS7Opj2L0s5avxx0xoiMyJ6S9wvyiduPuyTy6jJ0uF7q61TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4726
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:

commit: becb2cae42ea9092ad4fca06c85328e1f7f7312b ("fs: record sequence number of origin mount namespace")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master c0eb65494e59d9834af7cbad983629e9017b25a1]

in testcase: trinity
version: trinity-x86_64-ba2360ed-1_20241228
with following parameters:

	runtime: 300s
	group: group-00
	nr_groups: 5



config: x86_64-randconfig-075-20250228
compiler: clang-19
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+---------------------------------------------------------------------------+------------+------------+
|                                                                           | 822c115925 | becb2cae42 |
+---------------------------------------------------------------------------+------------+------------+
| BUG:kernel_NULL_pointer_dereference,address                               | 0          | 6          |
| Oops                                                                      | 0          | 6          |
| RIP:__se_sys_open_tree                                                    | 0          | 6          |
| Kernel_panic-not_syncing:Fatal_exception                                  | 0          | 6          |
+---------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202503041421.38b0d0c-lkp@intel.com


[  133.969970][ T4356] BUG: kernel NULL pointer dereference, address: 0000000000000000
[  133.971269][ T4356] #PF: supervisor read access in kernel mode
[  133.972087][ T4356] #PF: error_code(0x0000) - not-present page
[  133.972943][ T4356] PGD 800000016ebda067 P4D 800000016ebda067 PUD 0
[  133.973896][ T4356] Oops: Oops: 0000 [#1] PREEMPT SMP PTI
[  133.974732][ T4356] CPU: 1 UID: 65534 PID: 4356 Comm: trinity-c2 Tainted: G                T  6.14.0-rc1-00005-gbecb2cae42ea #1
[  133.976486][ T4356] Tainted: [T]=RANDSTRUCT
[  133.977174][ T4356] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 133.978731][ T4356] RIP: 0010:__se_sys_open_tree (fs/mount.h:152 fs/namespace.c:2873 fs/namespace.c:2943 fs/namespace.c:2905) 
[ 133.979644][ T4356] Code: 01 f0 ff ff 72 0a e8 62 8a c4 ff e9 59 02 00 00 4c 89 64 24 10 48 c7 c7 78 e5 6e 84 e8 8c c8 82 01 48 8b 44 24 08 4c 8b 68 d0 <4d> 8b 65 00 31 ff 4c 89 e6 e8 f5 8f c4 ff 4d 85 e4 74 07 e8 2b 8a
All code
========
   0:	01 f0                	add    %esi,%eax
   2:	ff                   	(bad)
   3:	ff 72 0a             	push   0xa(%rdx)
   6:	e8 62 8a c4 ff       	call   0xffffffffffc48a6d
   b:	e9 59 02 00 00       	jmp    0x269
  10:	4c 89 64 24 10       	mov    %r12,0x10(%rsp)
  15:	48 c7 c7 78 e5 6e 84 	mov    $0xffffffff846ee578,%rdi
  1c:	e8 8c c8 82 01       	call   0x182c8ad
  21:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
  26:	4c 8b 68 d0          	mov    -0x30(%rax),%r13
  2a:*	4d 8b 65 00          	mov    0x0(%r13),%r12		<-- trapping instruction
  2e:	31 ff                	xor    %edi,%edi
  30:	4c 89 e6             	mov    %r12,%rsi
  33:	e8 f5 8f c4 ff       	call   0xffffffffffc4902d
  38:	4d 85 e4             	test   %r12,%r12
  3b:	74 07                	je     0x44
  3d:	e8                   	.byte 0xe8
  3e:	2b                   	.byte 0x2b
  3f:	8a                   	.byte 0x8a

Code starting with the faulting instruction
===========================================
   0:	4d 8b 65 00          	mov    0x0(%r13),%r12
   4:	31 ff                	xor    %edi,%edi
   6:	4c 89 e6             	mov    %r12,%rsi
   9:	e8 f5 8f c4 ff       	call   0xffffffffffc49003
   e:	4d 85 e4             	test   %r12,%r12
  11:	74 07                	je     0x1a
  13:	e8                   	.byte 0xe8
  14:	2b                   	.byte 0x2b
  15:	8a                   	.byte 0x8a
[  133.982199][ T4356] RSP: 0018:ffff88819bff7eb8 EFLAGS: 00010202
[  133.983064][ T4356] RAX: ffff88819a47c338 RBX: 00000000000001b7 RCX: 0000000000000000
[  133.984255][ T4356] RDX: ffff88819a650000 RSI: 0000000000000000 RDI: 0000000000000000
[  133.985462][ T4356] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
[  133.986638][ T4356] R10: 0000000000000000 R11: 0000000000000000 R12: ffff88819a650000
[  133.987842][ T4356] R13: 0000000000000000 R14: ffff88819bd68e00 R15: 0000000000000001
[  133.989130][ T4356] FS:  00007f0d165f6740(0000) GS:ffff88842fd00000(0000) knlGS:0000000000000000
[  133.990567][ T4356] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  133.991590][ T4356] CR2: 0000000000000000 CR3: 000000019bc54000 CR4: 00000000000406f0
[  133.992731][ T4356] Call Trace:
[  133.993247][ T4356]  <TASK>
[ 133.993714][ T4356] ? __die_body (arch/x86/kernel/dumpstack.c:421) 
[ 133.994395][ T4356] ? page_fault_oops (arch/x86/mm/fault.c:710) 
[ 133.995182][ T4356] ? do_user_addr_fault (arch/x86/mm/fault.c:?) 
[ 133.996009][ T4356] ? exc_page_fault (arch/x86/mm/fault.c:? arch/x86/mm/fault.c:1538) 
[ 133.996790][ T4356] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623) 
[ 133.997605][ T4356] ? __se_sys_open_tree (fs/mount.h:152 fs/namespace.c:2873 fs/namespace.c:2943 fs/namespace.c:2905) 
[ 133.998433][ T4356] ? __se_sys_open_tree (fs/namespace.c:2872 fs/namespace.c:2943 fs/namespace.c:2905) 
[ 133.999267][ T4356] ? do_syscall_64 (arch/x86/entry/common.c:83) 
[ 133.999925][ T4356] ? do_int80_emulation (arch/x86/entry/common.c:257) 
[ 134.000690][ T4356] ? entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[  134.001567][ T4356]  </TASK>
[  134.002006][ T4356] Modules linked in: af_key ieee802154_socket ieee802154 caif_socket caif crc_ccitt rxrpc bluetooth rfkill pptp gre pppoe pppox ppp_generic slhc crypto_user scsi_transport_iscsi xfrm_user sctp dccp_ipv4 dccp ipmi_devintf ipmi_msghandler sr_mod cdrom sg ata_generic ata_piix libata sha1_ssse3 aesni_intel scsi_mod scsi_common input_leds serio_raw stm_p_basic
[  134.007226][ T4356] CR2: 0000000000000000
[  134.008040][ T4356] ---[ end trace 0000000000000000 ]---
[ 134.013890][ T4356] RIP: 0010:__se_sys_open_tree (fs/mount.h:152 fs/namespace.c:2873 fs/namespace.c:2943 fs/namespace.c:2905) 
[ 134.015705][ T4356] Code: 01 f0 ff ff 72 0a e8 62 8a c4 ff e9 59 02 00 00 4c 89 64 24 10 48 c7 c7 78 e5 6e 84 e8 8c c8 82 01 48 8b 44 24 08 4c 8b 68 d0 <4d> 8b 65 00 31 ff 4c 89 e6 e8 f5 8f c4 ff 4d 85 e4 74 07 e8 2b 8a
All code
========
   0:	01 f0                	add    %esi,%eax
   2:	ff                   	(bad)
   3:	ff 72 0a             	push   0xa(%rdx)
   6:	e8 62 8a c4 ff       	call   0xffffffffffc48a6d
   b:	e9 59 02 00 00       	jmp    0x269
  10:	4c 89 64 24 10       	mov    %r12,0x10(%rsp)
  15:	48 c7 c7 78 e5 6e 84 	mov    $0xffffffff846ee578,%rdi
  1c:	e8 8c c8 82 01       	call   0x182c8ad
  21:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
  26:	4c 8b 68 d0          	mov    -0x30(%rax),%r13
  2a:*	4d 8b 65 00          	mov    0x0(%r13),%r12		<-- trapping instruction
  2e:	31 ff                	xor    %edi,%edi
  30:	4c 89 e6             	mov    %r12,%rsi
  33:	e8 f5 8f c4 ff       	call   0xffffffffffc4902d
  38:	4d 85 e4             	test   %r12,%r12
  3b:	74 07                	je     0x44
  3d:	e8                   	.byte 0xe8
  3e:	2b                   	.byte 0x2b
  3f:	8a                   	.byte 0x8a

Code starting with the faulting instruction
===========================================
   0:	4d 8b 65 00          	mov    0x0(%r13),%r12
   4:	31 ff                	xor    %edi,%edi
   6:	4c 89 e6             	mov    %r12,%rsi
   9:	e8 f5 8f c4 ff       	call   0xffffffffffc49003
   e:	4d 85 e4             	test   %r12,%r12
  11:	74 07                	je     0x1a
  13:	e8                   	.byte 0xe8
  14:	2b                   	.byte 0x2b
  15:	8a                   	.byte 0x8a


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250304/202503041421.38b0d0c-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


