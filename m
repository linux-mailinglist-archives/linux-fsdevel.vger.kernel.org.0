Return-Path: <linux-fsdevel+bounces-35876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1AE9D9383
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 09:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F04AB214A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 08:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5751A3042;
	Tue, 26 Nov 2024 08:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bx5Slapc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C9014A85;
	Tue, 26 Nov 2024 08:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732610681; cv=fail; b=k4dgAUKjwvGQe2EMmr5ioAoTa/sDIGKTUtAR4qN5ql6M3yLYoxbUNSmFEBJgXysE7cI87orS8tY/xeYsMUO5WeZIOS4ZDuitJfmjb7cjRW1HBRfJ4YYY+MRxUFqcV+Clf2yjiT+uSO4Ck5ZwC9NXdksE6JQb/fLdXAADNPOIPtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732610681; c=relaxed/simple;
	bh=uADWmElw6qH5PgrEHwoNUBLoVKumqh8AnRIv6426zv8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=ZGHzl3YxNGyVy2iiD0jwgl8GB5Sro3fH8wH3fsVW6wpjAQzOCirR1DexbCWlrza2u06FYPjYyIzBYv87mGz+VMIWPeQzT993Qr3VHumdseQ4OpmgnMHXWobhzVKJKe71uc0O5l5i2vrlRiFIaJjL9BM4pUayZheDlx9v1BD7ZNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bx5Slapc; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732610679; x=1764146679;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=uADWmElw6qH5PgrEHwoNUBLoVKumqh8AnRIv6426zv8=;
  b=bx5SlapcR+BMEHVnsgw2e4Sxk9IeWeOR4o4bKcXb0MrMGk+HyoXcktBS
   LGthLbS07Dkj3QuhKE0XCF+K+IW9c2kAM4FB6visI84yt+W6vMFJiZu6t
   csctCFhetT03P2QzRHTgmsIcr0SHQ5MHZZqKzxoCUtwp+YzW+ZXW7U6ep
   sfh8Iebu1bLSrj6eT0HSCHBoX0vlnAI9Uhb1CaJkOXwO68z6i8j+AeX75
   wjDqkxWzK3cQ4KkiyIPLzzYG4j2ez1gPW7gOjKHQilaFTi0hiOwlwexOn
   HSpxYQbsOZCenL7xTSLPtjiilurOrjAanfumDAKQ3/wljiUgXipbObC1q
   g==;
X-CSE-ConnectionGUID: V4gxFdXQRJK7j+CtJXGInA==
X-CSE-MsgGUID: Z43+ddfPT1WWthaGz+g5xw==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="43418772"
X-IronPort-AV: E=Sophos;i="6.12,185,1728975600"; 
   d="scan'208";a="43418772"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 00:44:39 -0800
X-CSE-ConnectionGUID: IA4DzctzRtyM1CHobhBoFQ==
X-CSE-MsgGUID: OiNRwKV8SbSQJ0jvH9GxIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,185,1728975600"; 
   d="scan'208";a="92011451"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Nov 2024 00:44:38 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 26 Nov 2024 00:44:37 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 26 Nov 2024 00:44:37 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 26 Nov 2024 00:44:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZ9Maj60YzwfwxOF/R6srys23rcTMl8F0V661LPgq4gVE8CBy8j8/Xd0+wmtyJrFlQ4HZkxOsP5E1i6hrFay5rfYuCEJ8B3bVh7pbTUJr/vighv+7sz9U1B6YVHm8ztFh64VfyWJwa5U8FQ5AN5D1oNWL0GlpNEHEND3if/lZjTTXyAZ+YjNs3eEpb4Hv6YnIzG2iD7H0WJEIXossCIchIV+XhkFU979eZk2V/yY3ZpaMsSs2u1wLAP1oNMgmKXzj7LxkAj42k+PebBaTw5MZ033Z6RSRsryVjZkb7KRBXkT4naoMfnk3SVn2I/yB7vSpBfnJkSwBCR6pbJNTOSWIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uo3SN+/KiW79WaL4QHGPOmnxY5n+TMii74HP5EZFipE=;
 b=xcKs7qrNvAewcbsZyb7Em4qdhhPK7leHN+BGRdtgtVuYKQjKcY6GxCfuQtpQN5KEZFVJfD2QwDN9Oan3myk0OQKpYJT7ARXhoMN+mFwsmYKFtTWMnUM23jbf5i66SCA0HKWK/+f3ynoYpaphmeFUw7MKR0l2wNZ7bTbUqDK1fkEOyVkimyu4raWGG5d9R3nZ2RdTmwHDXVVigJJXTssAH2x4uy/IioN49K5U6O/74jb7SA+4+iIhQ1pI2MHcZcX+4iH2C1uNuqmewz78bQRc0L+08Jodun6R5XZwl27gnHUs/t68aU776yMRaU0s9IGM+rqjCDfIuSmuU9xht1Badg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BL1PR11MB5286.namprd11.prod.outlook.com (2603:10b6:208:312::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Tue, 26 Nov
 2024 08:44:34 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 08:44:33 +0000
Date: Tue, 26 Nov 2024 16:44:23 +0800
From: kernel test robot <oliver.sang@intel.com>
To: David Howells <dhowells@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.com>, Trond Myklebust <trondmy@kernel.org>,
	Jeff Layton <jlayton@kernel.org>, <netfs@lists.linux.dev>,
	<linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [netfs]  d6a77668a7:  filebench.sum_operations/s
 158.3% improvement
Message-ID: <202411261616.c29946d8-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0028.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::21) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BL1PR11MB5286:EE_
X-MS-Office365-Filtering-Correlation-Id: 245a3200-836c-492c-62f6-08dd0df68d02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?4vZEw0kBPW/+GDF7spe3EFvIFhjStqzBHWpfEMQpN7jKIL2BhUrpItNz/f?=
 =?iso-8859-1?Q?s440y1KtQ4hD+gV8YlKy6Q7Lb7bn6o2sjAAR0SdrQohJEWeAa4ZFNTy9Up?=
 =?iso-8859-1?Q?khztoF1/Lc06574yvjVi1bF2Ku6qmzFVhCBCcqvrF7wQHBU/1KNjCFXti5?=
 =?iso-8859-1?Q?vIULrIz7Y6w53xPtvtMf+3EOntCgubWLMWuHRumBkKeXsfH36rvfpsrt9r?=
 =?iso-8859-1?Q?APRlYwOLYGXS+5t4nNO946uFqjxxFYRuj6tW+HUzFPH7NJUH4CbJFTg9pb?=
 =?iso-8859-1?Q?KrjCACoRCla52xULhjjltoYX0ON9YQwaxnNrQc69nTetMybXobD/D+ObYt?=
 =?iso-8859-1?Q?HmozC9mZDr4eCf+l9/yHpRPh7A1GMh801Pcw0VZqK5uN7oe0SGos8h2NZY?=
 =?iso-8859-1?Q?VXDoKNIhf+HXpXIRPBCyy78hkJ3UxQe01HYOOSimyGotXnZSwwkbZNSgI8?=
 =?iso-8859-1?Q?uc4P/Ub+pLGWQvR70SZy4ZtmxgOHh973mQV/h+X98lhL8t5RkR78Z6PJ/h?=
 =?iso-8859-1?Q?5iLoHNihylmeS9dRgTNO+cFpp0yUQrGSid3S2aeKQFYVSfmVCpWf9xVklg?=
 =?iso-8859-1?Q?mlFS3SStOlCWChv/3+/eAvMPP77iUuFfHCrzONpEvdMUNIirYZ6bWs0KLy?=
 =?iso-8859-1?Q?zuiKPBC7kfeDc43M3COvLj1zRfy9G40YuPlHHlRdmVLdjCkJ58o+sStkyh?=
 =?iso-8859-1?Q?J/mIxxYpm1gzY5HiJ1rgKB62VuFsTHja+UVahA2gM31Zp1I8NWHXiupiUu?=
 =?iso-8859-1?Q?/EYmGgFeVsDv/554NZ3bkEkcpHgUR8NBFVCVdL2Yc0NYpoM0wZcLAh4bOq?=
 =?iso-8859-1?Q?n/OC0ONfy7YH9yUx+ZrO8qvsZ7tGYTN/hjw+JfFuhnUybD9Yj68n+5SBWl?=
 =?iso-8859-1?Q?XOl4eJJcqqzkz2tBT/oW2lutvne7w+rClRFKiPjNnUXE/Y4fFA+/9wRmkq?=
 =?iso-8859-1?Q?dyvalHmumf3ZYwe5HAMG2Mp5ahT4gVQJZEJBRV10MHkWhEYRDFM41UVH+h?=
 =?iso-8859-1?Q?UY6z08lJqqHMgmIrInaVq3ygl9jCPGVclNu7iJvLx7RyR4xM33hpgOA16p?=
 =?iso-8859-1?Q?9XmL7sjNmeMpLzNKf6BC0+oSraLNZUYkzdCSJbBxQvfx5MOr49B1YF6TfN?=
 =?iso-8859-1?Q?a2fdlcMmBTvyUJA4EFqYL4v718DqArHtFgSwd+I+aV03My8iTQC+8iyPgx?=
 =?iso-8859-1?Q?9Lh+aF1FBqnTQP115AFrePaXg1h+a0t2T4kh9ArjrKWE1eJagqp2HWZzFu?=
 =?iso-8859-1?Q?q8HZExe016PnyHowOj/FqKGLVEFPlwcLuPnHlMoNbvLYbo3+j4uosIbsOX?=
 =?iso-8859-1?Q?eX54SsfdLFLIpvzlpRi6Ya23fd6uw7ebvpr9TCeAZYS3vQ6VIKBTfGauNP?=
 =?iso-8859-1?Q?2I3hN+C5W8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?MnxaGXyTKgHqtaXLK6gtC+BsTJ0wzgXcZquwuxNbNMPxTssSTznJVRvTY4?=
 =?iso-8859-1?Q?zRVFh/dkqF2UiwGI3/1wmU+euQ4UzktoCvUnyN+ck59mQtJa614UMrlYcV?=
 =?iso-8859-1?Q?DPFV6+KZtAyYCtobKEIQi2xOA/KysKk0Hq/iI23LdtWZnzluQKuvJIH4Mg?=
 =?iso-8859-1?Q?F2Ubb+yHEX6c2654GoByl+nESLqC1/56rwzVDAbmo8TAFReUeQTU7o41Xp?=
 =?iso-8859-1?Q?xswOOffFvxrcL+mtcDYsF156pz6M/WCcURsfYe+172xqTNYw6cc+Yusg6A?=
 =?iso-8859-1?Q?m/bQ513TbhL4+F8PB+el4HxK1ARWBC2U32gdU/XxNBfgsUYnYVisNngXOX?=
 =?iso-8859-1?Q?JUJUJ6bUrqSFHlXAe07AYnonFNDoVmnF7gpVOjeiXrf9yN9TuM/jciXdu6?=
 =?iso-8859-1?Q?AMkETREE19+/CA9QBiTU3/9R91d65T3BbRyKoMQboM8cWgr+zAj1YZnxeS?=
 =?iso-8859-1?Q?kaSCtx7Br3s/SfbdnLfZ7OBx7ASd8afWhtI4PI1TkRxRxXRRWfSx3QTIwa?=
 =?iso-8859-1?Q?CQvlv2uVU3JRP8U0HrTWrHLscsCszMWs1fwtyPl3RVpktL++fxjNKBg4e3?=
 =?iso-8859-1?Q?3IvwWtmAJNJu0xoJH4QbsHUqVJhzpVLWLYLRKDi3yFJXGgYnxlHAZPh3aJ?=
 =?iso-8859-1?Q?j7pQUzVLZHZy1dZ38Rxx60NU9CsvyBVYLC3T6DLvnk4vIKGxDtfNxt5HZ6?=
 =?iso-8859-1?Q?eeVBCnkszFNmUZDwaAilvOc4L8dFNwPOuHeCX+Ho6DW+836KoWgLL5WNd+?=
 =?iso-8859-1?Q?f/PTyzqujWat4bDxPagj7x1YOE0wTimvuhtzMPwdIdh6sqCtNc5JAWpbVP?=
 =?iso-8859-1?Q?dndYWoiehXy8l+8702olk7+VrUVO9615XmoE+JMs6IaMYStai7jFf46sei?=
 =?iso-8859-1?Q?lUX19MH7L2ihx6RsYLGy7+le+Xu3RUjE8DbcvDO/X1t3gvPJg5hHKLZrnR?=
 =?iso-8859-1?Q?TH4fibIPMK9ScLnr3EXVBFwOqIw2p7hkI82q1dytZRgNOEs7eW/GS833zH?=
 =?iso-8859-1?Q?W2SAuqY/BQSuR+UYsMe7Zc+nek/zMOWm0iilDI/AAxNRDbc4JfbrSxQ7wk?=
 =?iso-8859-1?Q?4PdH7/fkOaIuLL05emZbVvRBIsmQ5YSqNYmQ8ZmM0+Vz0AJ2/T4aFkZw8a?=
 =?iso-8859-1?Q?0UeDDdDd+4U7RWrQi6Yz/ovp5vVemfF4LnWvzHo0f9XdPo34mmeKv4p8BN?=
 =?iso-8859-1?Q?guu/YsEB7QK0ki05mpCF5T3y9E5qDdPRs39caPZ1hpa/nefqVIPr2rzDcw?=
 =?iso-8859-1?Q?FPa/9DIe88OP4StJnqPEzQy6HtKfN+c2HDwLGUDfGtvlvNKflFlbDjOakY?=
 =?iso-8859-1?Q?CEHQc/HdZfRGLVrG/joBkHBh0wKSI3q+WPnLEgmq8Fa2CeBwysI+NSjD56?=
 =?iso-8859-1?Q?y0V0JT22RitEGMnX6dM6lPX++Jc6yZFEw91QqE4JOZJwwI3EMImQAOcIqx?=
 =?iso-8859-1?Q?QVJjPjMLMvnvXfGIWiMMppI0F6mZsC9eOQy3dqLJgR7utQBrQucRwyNfdH?=
 =?iso-8859-1?Q?gu2rttvJNttq+/PBalHN5k7t7BCjQpu/oF9bBrQ+XxLjRizajF2nxVKOuR?=
 =?iso-8859-1?Q?n/+1eJWT+2mrSdPjYaua1zFDXNcAMEPi5fBe6mEDE0MJ1fsN2ifcs9lCWH?=
 =?iso-8859-1?Q?ng9C3wueEjssBnapvcKs7M3ovyAyo+fi8DgBySBT89I0uxYDO3l2xZQg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 245a3200-836c-492c-62f6-08dd0df68d02
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 08:44:33.7086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8f5uBs/lvATuIHZNb+xy1jXTN/F0l5WtFR++li9oDfDX7Qi3kRzw15lNcRZr3ZuICMXddPpjFoUsTEXYVM02pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5286
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 158.3% improvement of filebench.sum_operations/s on:


commit: d6a77668a708f0b5ca6713b39c178c9d9563c35b ("netfs: Downgrade i_rwsem for a buffered write")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


testcase: filebench
config: x86_64-rhel-8.3
compiler: gcc-12
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
parameters:

	disk: 1HDD
	fs: xfs
	fs2: cifs
	test: randomrw.f
	cpufreq_governor: performance



Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241126/202411261616.c29946d8-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs2/fs/kconfig/rootfs/tbox_group/test/testcase:
  gcc-12/performance/1HDD/cifs/xfs/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-icl-2sp6/randomrw.f/filebench

commit: 
  6ed469df0b ("nilfs2: fix kernel bug due to missing clearing of buffer delay flag")
  d6a77668a7 ("netfs: Downgrade i_rwsem for a buffered write")

6ed469df0bfbef3e d6a77668a708f0b5ca6713b39c1 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  10356023 ± 13%     -88.4%    1203898 ±  8%  cpuidle..usage
      1862 ± 17%     -45.6%       1013 ± 23%  perf-c2c.HITM.local
    564994 ±  9%     -86.4%      76928 ± 36%  numa-meminfo.node1.Active(anon)
    585171 ±  7%     -84.9%      88374 ± 38%  numa-meminfo.node1.Shmem
    124475 ± 13%     -92.9%       8821 ± 14%  vmstat.system.cs
      9926 ±  6%     -39.6%       5995 ±  4%  vmstat.system.in
    576365 ± 10%     -83.0%      98054 ± 27%  meminfo.Active(anon)
   1481440 ±  4%     -33.1%     991806 ±  2%  meminfo.Committed_AS
    613566 ± 10%     -79.8%     124007 ± 22%  meminfo.Shmem
      0.02 ±  3%      -0.0        0.02 ±  4%  mpstat.cpu.all.irq%
      0.60 ±  2%      +0.1        0.69        mpstat.cpu.all.sys%
      0.18            +0.0        0.22 ±  6%  mpstat.cpu.all.usr%
    141224 ±  9%     -86.4%      19203 ± 36%  numa-vmstat.node1.nr_active_anon
    146313 ±  7%     -84.9%      22087 ± 38%  numa-vmstat.node1.nr_shmem
    141224 ±  9%     -86.4%      19203 ± 36%  numa-vmstat.node1.nr_zone_active_anon
     91197 ± 22%     -93.7%       5768 ± 19%  sched_debug.cpu.nr_switches.avg
   6021808 ± 30%     -96.1%     232641 ± 32%  sched_debug.cpu.nr_switches.max
    616189 ± 24%     -95.9%      25525 ± 31%  sched_debug.cpu.nr_switches.stddev
    144168 ± 10%     -83.0%      24516 ± 27%  proc-vmstat.nr_active_anon
   3501815            -3.8%    3369305        proc-vmstat.nr_file_pages
     28035            -5.9%      26386        proc-vmstat.nr_mapped
    153431 ± 10%     -79.8%      31026 ± 22%  proc-vmstat.nr_shmem
     25506            -1.6%      25092        proc-vmstat.nr_slab_reclaimable
    144168 ± 10%     -83.0%      24516 ± 27%  proc-vmstat.nr_zone_active_anon
   1443064            -7.1%    1340212        proc-vmstat.pgactivate
      2557 ± 14%    +158.3%       6606 ± 10%  filebench.sum_bytes_mb/s
  19644866 ± 14%    +158.3%   50742596 ± 10%  filebench.sum_operations
    327385 ± 14%    +158.3%     845638 ± 10%  filebench.sum_operations/s
    163882 ± 14%    +189.5%     474419 ± 12%  filebench.sum_reads/s
      0.01 ± 15%     -65.7%       0.00        filebench.sum_time_ms/op
    163502 ± 14%    +127.0%     371220 ±  9%  filebench.sum_writes/s
     56.83           +29.0%      73.33        filebench.time.percent_of_cpu_this_job_got
     85.87 ±  2%     +20.1%     103.10 ±  2%  filebench.time.system_time
      8.54 ± 10%    +115.4%      18.39 ± 16%  filebench.time.user_time
   9795275 ± 14%     -99.3%      67709 ± 70%  filebench.time.voluntary_context_switches
      0.01 ± 29%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      0.01 ± 19%    -100.0%       0.00        perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      0.00 ± 67%    +469.2%       0.01 ± 12%  perf-sched.total_sch_delay.average.ms
      1.33 ± 13%    +975.0%      14.30 ± 33%  perf-sched.total_wait_and_delay.average.ms
    724911 ± 10%     -89.6%      75232 ± 36%  perf-sched.total_wait_and_delay.count.ms
      1.33 ± 13%    +976.1%      14.29 ± 33%  perf-sched.total_wait_time.average.ms
      3.47 ± 11%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
     54.35 ±  8%    +403.1%     273.44 ± 19%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
     19.50 ± 30%    -100.0%       0.00        perf-sched.wait_and_delay.count.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
    280.83 ± 12%     -79.1%      58.83 ± 24%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    649458 ± 10%     -99.1%       6085 ± 56%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read_interruptible.netfs_start_io_read
      4.62 ± 11%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      1001           +25.4%       1254 ± 17%  perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.01 ± 22%    -100.0%       0.00        perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
     54.34 ±  8%    +403.2%     273.41 ± 19%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.01 ± 19%    -100.0%       0.00        perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      1001           +25.4%       1254 ± 17%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.15 ± 44%     -69.5%       0.05 ± 28%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read_interruptible.netfs_start_io_read
      3.23 ±100%      -1.0        2.18 ±142%  perf-profile.calltrace.cycles-pp.cmd_stat
      3.23 ±100%      -1.0        2.18 ±142%  perf-profile.calltrace.cycles-pp.dispatch_events.cmd_stat
      3.22 ±100%      -1.0        2.17 ±141%  perf-profile.calltrace.cycles-pp.process_interval.dispatch_events.cmd_stat
      3.12 ±100%      -1.0        2.12 ±142%  perf-profile.calltrace.cycles-pp.read_counters.process_interval.dispatch_events.cmd_stat
      0.42 ± 34%      -0.2        0.24 ± 28%  perf-profile.children.cycles-pp.perf_iterate_sb
      0.42 ± 22%      -0.1        0.28 ± 22%  perf-profile.children.cycles-pp.set_pte_range
      0.11 ± 38%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      0.11 ± 56%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.read@plt
      0.02 ±141%      +0.1        0.12 ± 29%  perf-profile.children.cycles-pp.aa_file_perm
      0.07 ± 55%      +0.1        0.17 ± 29%  perf-profile.children.cycles-pp.fault_in_iov_iter_readable
      0.07 ± 55%      +0.1        0.17 ± 29%  perf-profile.children.cycles-pp.fault_in_readable
      0.09 ± 50%      +0.1        0.22 ± 28%  perf-profile.children.cycles-pp.getenv
      0.21 ± 30%      +0.2        0.37 ± 34%  perf-profile.children.cycles-pp.__perf_read_group_add
      0.19 ± 44%      +0.2        0.36 ± 34%  perf-profile.children.cycles-pp.pcpu_alloc_noprof
      0.82 ± 11%      +0.4        1.20 ± 13%  perf-profile.children.cycles-pp.sched_balance_update_blocked_averages
      0.11 ± 38%      -0.1        0.04 ± 71%  perf-profile.self.cycles-pp.copy_page_from_iter_atomic
      0.11 ± 56%      -0.1        0.04 ± 71%  perf-profile.self.cycles-pp.read@plt
      0.02 ±141%      +0.1        0.12 ± 29%  perf-profile.self.cycles-pp.aa_file_perm
      0.02 ±141%      +0.1        0.12 ± 31%  perf-profile.self.cycles-pp.getenv
      5.49 ±  4%     +87.1%      10.27 ±  4%  perf-stat.i.MPKI
 6.113e+08 ±  6%     -21.6%  4.793e+08 ±  5%  perf-stat.i.branch-instructions
  12875097            -9.6%   11640297        perf-stat.i.branch-misses
  26605878 ±  8%     +61.4%   42952527 ±  5%  perf-stat.i.cache-misses
  89659393 ±  6%     +53.9%   1.38e+08 ±  6%  perf-stat.i.cache-references
    126410 ± 13%     -93.0%       8884 ± 15%  perf-stat.i.context-switches
      1.85 ±  2%      +8.3%       2.00 ±  2%  perf-stat.i.cpi
 2.757e+09 ±  6%     -17.8%  2.265e+09 ±  4%  perf-stat.i.instructions
      0.58 ±  2%      -8.1%       0.53 ±  2%  perf-stat.i.ipc
      1.00 ± 13%     -97.3%       0.03 ± 57%  perf-stat.i.metric.K/sec
      9.63 ±  4%     +96.7%      18.95 ±  2%  perf-stat.overall.MPKI
      2.11 ±  5%      +0.3        2.42 ±  5%  perf-stat.overall.branch-miss-rate%
      1.56 ±  6%     +19.7%       1.86 ±  4%  perf-stat.overall.cpi
    161.89 ±  7%     -39.3%      98.29 ±  4%  perf-stat.overall.cycles-between-cache-misses
      0.65 ±  5%     -16.5%       0.54 ±  5%  perf-stat.overall.ipc
 6.088e+08 ±  6%     -21.3%  4.791e+08 ±  5%  perf-stat.ps.branch-instructions
  12794450            -9.6%   11566995        perf-stat.ps.branch-misses
  26464019 ±  8%     +62.1%   42902925 ±  4%  perf-stat.ps.cache-misses
  89144844 ±  7%     +54.5%  1.378e+08 ±  6%  perf-stat.ps.cache-references
    126023 ± 13%     -93.0%       8808 ± 15%  perf-stat.ps.context-switches
 2.746e+09 ±  6%     -17.5%  2.264e+09 ±  4%  perf-stat.ps.instructions
 4.542e+11 ±  6%     -17.4%  3.753e+11 ±  4%  perf-stat.total.instructions




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


