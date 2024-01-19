Return-Path: <linux-fsdevel+bounces-8291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1DF8326A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 10:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F04CA284668
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 09:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAF23C07B;
	Fri, 19 Jan 2024 09:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K6TS2gx+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E401D3BB35;
	Fri, 19 Jan 2024 09:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705656465; cv=fail; b=mMoVAx1VRtmpvVFNktTdpMf75WwAqwvKiaPQolG+KUAHoW1sN0tCzluaH+rM929gb5ywwOejnsAPYArO5vntgSRt7EEqCIL9tltjkS5MKDVFvZ7iRoje+wNgCr1aZa5/Wes+ru2cEEI9a053/bSGx+yKsaS2tGpUB9myVi0gxvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705656465; c=relaxed/simple;
	bh=yNfSFt24U+tGvP+o4jAE9TWtaFfOdvaEF1Uqj6vIULw=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=S5gig1L08ycfgWZ0muUFqZ9rsDI7TqNDgSz92INXacH9dw3xow6+/R5/bNOUgfrjcOYe2ydFR7D8sGcJ9QY3eLiFFE8ZLnza+6o0Ea4ZcfH6HVp/COj5f99wAhZ2cJia7HRUlma528YGN+53rqtz8VgRVutWcC1N77PNE1dzPk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K6TS2gx+; arc=fail smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705656461; x=1737192461;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yNfSFt24U+tGvP+o4jAE9TWtaFfOdvaEF1Uqj6vIULw=;
  b=K6TS2gx+RTluc3vkAxsm2fnLuXPUTLaSSZ2x7Vt9m0YebsdoQsrwuujd
   f3Bg4qocwt7WDk3vg/KbRnvYoHMv7wnNadSgOMYZulM3WQ0Ap1LnGKbYL
   EFIYZP5wTQ5dR4yfAHPpuPgBsbGMkx5yhLYFMncJ3Aq4vyrBUT5CgZ69v
   pvHgn21zqzLZPKwxKkQ71vT/sSJgMv/RxKrkkpnvtylF+MYiETsAGiB08
   bF/82nSrTDAZx+p0Nvjlqa1kW1U2g73dC2XyfDAI3wMo+HZriNIjaHzoA
   VG81sblKfLzGSu4jaZyIYfXFjIsSCQn0lVlYWOEfMthNtXy0Xc6vEhGaM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="404467990"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="404467990"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 01:27:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="27010453"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jan 2024 01:27:40 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Jan 2024 01:27:40 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Jan 2024 01:27:39 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 19 Jan 2024 01:27:39 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Jan 2024 01:27:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4hTN5DPwZDRowYcBS/DQi2vFvWz01sRqBd6cJv+5XCDPrcOn6M3MzFelLLvqwo7/C3aX1V7t3TpnuLRIlTYkj9P9bjgBCVJLPda53WDQJBwrde3eKyz2lQL/OBFg9b/KzFTOd2qa4Qe+LfZuSbxNsikWKO8+aZwb1LIrOtxBToUF0ewapapuzQ5N3dCKIqZykE8DSJw7AXMHgUrNfZXh/P870+3HEg71R3nyqVAhsbyzFE5zkz0Dv8L0llHlYfAvs7HE65Yxne2a0O2AQenCZ08daZ+7bTyvRpet6upCPN8y75spxKpboJeMpaDjANwtA0zwUEaVMJn6DWRyqFxuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLLw/RiJrI+8+3xVO4YtanwiAIkAC0roTgnV+4p6New=;
 b=nwmCdHWH9W9e3z3aO0+ShA0joSc0PtBOH3hyz5xTtcV3dk52iKrQRyEBb8Ip9HkzIIIa+uWiSlhDNVh/XQaaXYo/crcT1gAzGoJMvPKh3sl/4O6yG2CQcefN83OCTOIM29Pq7i6/9RwDnZ9CYfsiYTWBwS3UPqKaGgLzmbrlSqbzDSaSeXGqBbFXren2+bz5x+a0phfMEe+FxE6rzEEQ2J1YPt5kHUOyN2BQnQdI4cs18FYmhJhzwv+jyPG3W1cGK2kG6c8fYrkdsHzQJdyqkR2Das4jUUGDOb4B7qpy44UvVM+d6wDlcde2QPBg4SOUtpEbWqNoaZlqWGM7NHcMCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB6043.namprd11.prod.outlook.com (2603:10b6:8:62::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.26; Fri, 19 Jan 2024 09:27:37 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::3230:820:c8c6:de0c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::3230:820:c8c6:de0c%6]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 09:27:37 +0000
Date: Fri, 19 Jan 2024 17:27:28 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Joel Granados <j.granados@samsung.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [joel-granados:jag/sysctl_remove_empty_elem] [sysctl] 15acdfcefd:
 sysctl_table_check_failed
Message-ID: <202401191627.63051dd8-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB6043:EE_
X-MS-Office365-Filtering-Correlation-Id: 44d9e2f9-a234-45d8-545b-08dc18d0dfca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tixWTTM3qojHMMe+raFCL9tR+YPH2ZtbohyUTJQavIBFpIOfEHXaYBNStdAI69EawWiBZRCbn5Jf+aJsuiPTdJZ2SJASp95MC1mx2tIxSjlL284+bnSywLmh7rY8fon0rurSnSrvh6bGc15FV+8/tel1pC2eAeisIFny8ziOORsOQjVBveER9tUCzR/0M4dsBuivRxCwj3sIPNDxV7uUXqfBr6P/R+XcWKJBmdtL+hG9QwfVJTZT3///R+AFCJu7eXVVfJGc1zUSThnhNMwAYn5vvf8kUUY+LFcdq+Mq8ZbdMYHlisqlgiOw52fYjQfRUXph8ZDZmIKuNhy/9QcJVjWhhhK3QpGpCOCtG0axnFCIiosH5BAk2Q85UmGiRyDmWyous4fPgceG27RgHiGCjd3eHfRH8M/dAr15pS6DR1UxvCaIKHqKDyGi2k6BsSwqY+er2FTB30qIFdy3MV9RWrMselXLY3MnAPFYOumOkr1Nr9ooxNQdrUxoBS1E56o9pxyl4iU6XPNaCqu7jUZpMS80kcQO4RwI7AsewDQcoUo94rT4PDvt8nPLtqc2V7SWX4KCNA1ebrofrlX1Lkp4Jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(346002)(366004)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(1076003)(2616005)(478600001)(26005)(6486002)(6506007)(6666004)(45080400002)(6512007)(107886003)(83380400001)(966005)(2906002)(5660300002)(41300700001)(66556008)(66946007)(66476007)(6916009)(316002)(4326008)(8676002)(8936002)(38100700002)(36756003)(86362001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zsoUxlPPza1pKjtOjDVSENTV59zKuj0c05Mt0OSybFiKJU4Si0rZJUxHr0DO?=
 =?us-ascii?Q?+C19blsXrrPh0/aLORWfaLe3PzbAJ8O/efk2OCV5kcPQCQDfDDGbi4p/0xA4?=
 =?us-ascii?Q?MRIyldAhkucOaQUAHIlUxhCQBRz1W48CoAlYhfBko+1QYpt0NIFKJZbOZbm7?=
 =?us-ascii?Q?tA5hsuVclKrkQCuNzz+D+3wV1hRFKd5NQE3rB3tu3P7nTP8d5bucpNLOc9ra?=
 =?us-ascii?Q?FVVPV35cq6m5LQ7Sd2C9O+LVsMcv1paEGRXGiTbeh+K4yfADbTw5EXJwMn7N?=
 =?us-ascii?Q?SCCUuPpcPMoy51NMQ5qrampBGECXkdtPQv5lYiSqouiwWtA3GEnCOYZ0qwqx?=
 =?us-ascii?Q?AjRVbssutwTN7xoVMapDTUhT8b/Rh53QkcqaZXUf9ZUIvwK9JkHPfjGEqatq?=
 =?us-ascii?Q?exDzjUPT8k+JUeWKRWAI0Vrb7bmkft7vYOVOga1EFMs5C6jX2ph4zBEw5j+R?=
 =?us-ascii?Q?7Z96ldTb1S/MEbmcagJUi42tJviN3YDMg081LqhRFpdp9gOOhpA7HOXfeV6r?=
 =?us-ascii?Q?w+UYeH7klQgiBP2W1ya4CY1/ofbVDxyEYL9js2AtKzF42y5BrDwtVyRFDNY+?=
 =?us-ascii?Q?WN5p2obtOTlWfgqxs0SLoE8VgmN8Vk8+kYIIL/iBzoAriOKts6K22l2Kchm4?=
 =?us-ascii?Q?V3kucC1iKO8+YJ68YeLXgDtRq2xxazT2UJCTNmf1FNdR40PepJskYW7W9/qi?=
 =?us-ascii?Q?WvUr3zBIdQgb/u9btlxiDuiixsCwm5bg2cFwx0mk76repGd3h6nKOWw/6BK4?=
 =?us-ascii?Q?47fjPcQaaidIlbVdv2FXkV0ZKD7rr4rUiDg5Pv5ANrqhmBsojHnfHqVGGylo?=
 =?us-ascii?Q?2sdfUAdmuVTftMX7sZSIuj3Q4zEg15xR9xgMmmS+chrChOKQL8tPnHBObwD7?=
 =?us-ascii?Q?WYJvldHr8IEM+mFaugcg/ypj4s9/UOxDnu9Y8USggp+jCV9kSRiSeSSHYVLV?=
 =?us-ascii?Q?y8FtVBiCcN8B/7UeqGm1E9mw3OX4JtfiztLQxfLI+TRsDpz5EJ4mclyQHXnl?=
 =?us-ascii?Q?bxwr77kZCP2BtXPe98T/70cO9fuuoo1uD70FQpmzFKQQdpeF7e4XZ1XvL8CR?=
 =?us-ascii?Q?A94x8Cv6o/q75v29Ff17NF6Hf8zt3ZG5YWEV77zEe1UXJsS4eeEAjr9gdJbM?=
 =?us-ascii?Q?v/lcmFz/JSSH+5MibMzM77+HgY28uvrvTF5s6fDhNtDwEayHNeobrui6LM0G?=
 =?us-ascii?Q?WQBNiVWSzkBXct6yYpi0oLPG95wGO7cXRWU9B2UpvHBSqNQ17lmjDszgt+6B?=
 =?us-ascii?Q?k4hQ7DTnu2ZoPhOaeMAL2BSjRs/la+vlIWjNgSo4Z0C6YBtl3uyP3Yb7M2PX?=
 =?us-ascii?Q?ZRWpp4GNscgJIAcKa2akB4usm3vMxaGsCh0Thm0s7iOaS47H36CjtOclr/wd?=
 =?us-ascii?Q?cbYrJRr+nhn1ZWZ5ktLRPUhXVyMolxmb6zqlYiWg4ZMsgICPkkPSze+VHF+N?=
 =?us-ascii?Q?2CJZlJNYFpFRzxghmiJprw3xPpPslHtttCQHuMm8UBJH2RSkrXSSyoWBLtax?=
 =?us-ascii?Q?quDWPlHGH/79Zxmaj/boxyYJd/rFvythFOUynk7siAGncaCEouq3/zXc5M0x?=
 =?us-ascii?Q?3yLDS+LuA37vgGr/3a7/JKhJLkoCULduPI/5v/r0uSEH3nSlStJFPjyhLY5y?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d9e2f9-a234-45d8-545b-08dc18d0dfca
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 09:27:36.9742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O38Rmhs05mDhfPYrTa6U2ZmviW3/+FqXS44IS6SDjPd8ByUXb4BvhlwbsX8iBxlzUa1d7SE1PmiBqF+/W1QfOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6043
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "sysctl_table_check_failed" on:

commit: 15acdfcefdf6023d165779105b254cc410297526 ("sysctl: remove the check for the end empty element")
https://git.kernel.org/cgit/linux/kernel/git/joel.granados/linux.git jag/sysctl_remove_empty_elem

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+------------------------------------------+------------+------------+
|                                          | 19bcf4e935 | 15acdfcefd |
+------------------------------------------+------------+------------+
| boot_successes                           | 19         | 0          |
| boot_failures                            | 0          | 25         |
| sysctl_table_check_failed                | 0          | 25         |
| kernel_BUG_at_kernel/ucount.c            | 0          | 25         |
| invalid_opcode:#[##]                     | 0          | 25         |
| RIP:user_namespace_sysctl_init           | 0          | 25         |
| Kernel_panic-not_syncing:Fatal_exception | 0          | 25         |
+------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202401191627.63051dd8-oliver.sang@intel.com



[    0.403101][    T1] sysctl table check failed: user/(null) No proc_handler
[    0.404663][    T1] ------------[ cut here ]------------
[    0.405346][    T1] kernel BUG at kernel/ucount.c:371!
[    0.406217][    T1] invalid opcode: 0000 [#1] SMP PTI
[    0.406343][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.7.0-rc6-00006-g15acdfcefdf6 #1
[    0.406343][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    0.406343][    T1] RIP: 0010:user_namespace_sysctl_init+0xcb/0xf0
[    0.406343][    T1] Code: 2d 72 64 4c ff c6 07 00 0f 1f 00 fb ba 01 00 00 00 31 f6 48 c7 c7 20 5c a5 90 e8 00 ab 9b fd 31 c0 5b 5d c3 cc cc cc cc 0f 0b <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 66 2e 0f 1f 84 00 00 00 00 00
[    0.406343][    T1] RSP: 0000:ffffb68040013de8 EFLAGS: 00010246
[    0.406343][    T1] RAX: 0000000000000000 RBX: ffffffff9158f710 RCX: 00000000000000b8
[    0.406343][    T1] RDX: 0000000000000000 RSI: 0000000000037160 RDI: ffffffff90a4e020
[    0.406343][    T1] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffb68040013b90
[    0.406343][    T1] R10: 0000000000000003 R11: ffffffff90ddd6e8 R12: ffff99113fc7a000
[    0.406343][    T1] R13: ffffb68040013e00 R14: 000000000000040d R15: 0000000000000000
[    0.406343][    T1] FS:  0000000000000000(0000) GS:ffff99113fd00000(0000) knlGS:0000000000000000
[    0.406343][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.406343][    T1] CR2: 0000000000000000 CR3: 0000000433c1c000 CR4: 00000000000406f0
[    0.406343][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.406343][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.406343][    T1] Call Trace:
[    0.406343][    T1]  <TASK>
[    0.406343][    T1]  ? die+0x36/0xb0
[    0.406343][    T1]  ? do_trap+0xda/0x130
[    0.406343][    T1]  ? user_namespace_sysctl_init+0xcb/0xf0
[    0.406343][    T1]  ? do_error_trap+0x65/0xb0
[    0.406343][    T1]  ? user_namespace_sysctl_init+0xcb/0xf0
[    0.406343][    T1]  ? exc_invalid_op+0x50/0x70
[    0.406343][    T1]  ? user_namespace_sysctl_init+0xcb/0xf0
[    0.406343][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[    0.406343][    T1]  ? __pfx_user_namespace_sysctl_init+0x10/0x10
[    0.406343][    T1]  ? user_namespace_sysctl_init+0xcb/0xf0
[    0.406343][    T1]  ? user_namespace_sysctl_init+0x35/0xf0
[    0.406343][    T1]  ? __pfx_user_namespace_sysctl_init+0x10/0x10
[    0.406343][    T1]  do_one_initcall+0x5b/0x2f0
[    0.406343][    T1]  do_initcalls+0xc6/0x170
[    0.406343][    T1]  kernel_init_freeable+0x25c/0x330
[    0.406343][    T1]  ? __pfx_kernel_init+0x10/0x10
[    0.406343][    T1]  kernel_init+0x1a/0x1f0
[    0.406343][    T1]  ret_from_fork+0x34/0x70
[    0.406343][    T1]  ? __pfx_kernel_init+0x10/0x10
[    0.406343][    T1]  ret_from_fork_asm+0x1b/0x30
[    0.406343][    T1]  </TASK>
[    0.406343][    T1] Modules linked in:
[    0.436350][    T1] ---[ end trace 0000000000000000 ]---
[    0.436931][    T1] RIP: 0010:user_namespace_sysctl_init+0xcb/0xf0
[    0.437526][    T1] Code: 2d 72 64 4c ff c6 07 00 0f 1f 00 fb ba 01 00 00 00 31 f6 48 c7 c7 20 5c a5 90 e8 00 ab 9b fd 31 c0 5b 5d c3 cc cc cc cc 0f 0b <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 66 2e 0f 1f 84 00 00 00 00 00
[    0.439835][    T1] RSP: 0000:ffffb68040013de8 EFLAGS: 00010246
[    0.440346][    T1] RAX: 0000000000000000 RBX: ffffffff9158f710 RCX: 00000000000000b8
[    0.441190][    T1] RDX: 0000000000000000 RSI: 0000000000037160 RDI: ffffffff90a4e020
[    0.441598][    T1] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffb68040013b90
[    0.442345][    T1] R10: 0000000000000003 R11: ffffffff90ddd6e8 R12: ffff99113fc7a000
[    0.443229][    T1] R13: ffffb68040013e00 R14: 000000000000040d R15: 0000000000000000
[    0.444599][    T1] FS:  0000000000000000(0000) GS:ffff99113fd00000(0000) knlGS:0000000000000000
[    0.445346][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.446029][    T1] CR2: 0000000000000000 CR3: 0000000433c1c000 CR4: 00000000000406f0
[    0.446598][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.447346][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.448197][    T1] Kernel panic - not syncing: Fatal exception



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240119/202401191627.63051dd8-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


