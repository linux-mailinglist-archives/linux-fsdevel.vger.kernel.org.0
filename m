Return-Path: <linux-fsdevel+bounces-15962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEF38962B9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 04:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A2271F21C5D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 02:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588AD1BF2F;
	Wed,  3 Apr 2024 02:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cmp0v7VM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808E41B946;
	Wed,  3 Apr 2024 02:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712113035; cv=fail; b=LZLIzxSDSHXiYq58JHab98IvzMAHRjn13KwkmPIC71/mSP0XY8QFcDPl8hIIjtr1YnGTIFmWSwTlABGEoE9nYNWlkAX5kg/DRHhaccEJyTKwOJu2cG/2l9pSANBu71kKbClH/8Q2MLWWtGgMrS8XMIooHOYSeDPn71pwnKCxwO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712113035; c=relaxed/simple;
	bh=rJNXC5/GqfsVC5zlyCLeI5K/EwGpNw4Um1twQ07JMlY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Op57C/rovwwMdlBI0aRi7+kexRVSbCgbhVJx5uSy3enGxNESmUEpSUoqSRSPSnAyV2GlKZZdwCo9Sh1MWMfL6ZdJICEH5NxOUHD0IewL5mv+Yjmbv803oHa39MTKpasbxoWRkvvhDRaTs9h0x3GuotuEzyKT6PqNg7OKvj+LAqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cmp0v7VM; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712113032; x=1743649032;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=rJNXC5/GqfsVC5zlyCLeI5K/EwGpNw4Um1twQ07JMlY=;
  b=cmp0v7VMlr6YDQUF8RqkurwcDpERq2G9AChXLfph7o/TTpboZjmNe9iP
   poUQVQx62T8e8nsMadi/+L0ilYuGdO5weaaI2yYPwUQAM93r8UIpM3B9G
   TWqXREqi11mk6pdwgn9KSgOqXayuc9npbH04rOmrmO0tjrVY+GA9LDkJn
   hBH60nCZLV1jAcWfAS779XhST5copo4ETH1ykGGYL3V+ySPKjaejPLDxT
   TXKw1kbjRV6OkJh1x3IXU1VGy1RCcXBKBXeR96Zp4e6Ux9L4rzjv2UJnT
   hghER3SG1FTeAGstTlG9Z+IQj/kUo2yaEut3U/evQSM9ZrUxzSUjb9uZn
   w==;
X-CSE-ConnectionGUID: 3ihLORMBQ7mbuiRv1ME/OA==
X-CSE-MsgGUID: G9NyDwmaQOilMWv4BIZRvQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="18685747"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="18685747"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 19:57:11 -0700
X-CSE-ConnectionGUID: og/qF//nQ1CElx5/7NhdJA==
X-CSE-MsgGUID: KHSTd/gCSJaZBYSvn1bFtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="49504891"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Apr 2024 19:57:12 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 19:57:11 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 19:57:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Apr 2024 19:57:11 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Apr 2024 19:57:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Od5Ejonmsyr8w763vvcQ33983QlyvuWpKxf9JQzbxJhFpN5duDOIatqCecxxeW83jr6OqsvatfDD7tEQBqyn8wFa0NJtziTQS2Yvk2kkqJvq5s5P0y95/nvK2B+55IVlTiQ8DjLH+wBuLenJr7o26/w60w7jw777zA/n464W+xeppTePHMQt9vi2EOq9UG4mWUg+8DpkWAwY4B5yyYQtdHlY7nKnvBeYwtLZH7yBgzi/ZDjdro7d2FDLZjWe6lWApKqWf/Juf4i8AIR+PITEO22VZYSD7/Z7ZMgaZt8CU++lkcLAJDlmJ9eyq405ete5BXBIx3QLwGPVP5zMoQlS0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBsgqhHPCJUs7Gh+qoN6/qvwR9vfqAGRAu7vj5wFquY=;
 b=HQ01A06kXMuCxCQD8MYIr8U+xM7I1WMcel+XMTo+/ExfXo0CDB97daNFFOLwPjCk0AZeSxOCvc8NfV3vQ31FZoqpKh/82m/1jYNMkLD3+HtP6fjzWWXrMUqY9ccbdzI6PQdcyx4yh0saeb1BrghTTNe01zIwk0TZeUjXjoXz7uGvFmP1mnoRS0GHuXrDD+0EwS68taqNAilNhl1iQaBOzVWtxmJwScD+bThvD9NF5JKUJhb81AvzHxzLD1uojGYRF5bB4QbFzxN/3LPuqy2utlY7Mpcs8MMBWsia0nRbrEpeel1lZBPb41cuRxY1WMcKM+S2LmH1TId3UAP7j7/7Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SN7PR11MB6900.namprd11.prod.outlook.com (2603:10b6:806:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Wed, 3 Apr
 2024 02:57:08 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7452.019; Wed, 3 Apr 2024
 02:57:08 +0000
Date: Wed, 3 Apr 2024 10:56:58 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Jeff Layton <jlayton@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, NeilBrown <neilb@suse.de>,
	<linux-fsdevel@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
	<linux-cifs@vger.kernel.org>, <samba-technical@lists.samba.org>,
	<linux-trace-kernel@vger.kernel.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [filelock]  c69ff40719:  stress-ng.dup.ops_per_sec
 1.9% improvement
Message-ID: <202404031033.c2d3b356-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0110.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::14) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SN7PR11MB6900:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IokwdtEZglliFCvsq+b06346im0ioET4fNMr0Ae4tG+CJgkoSrQUH7XJm6Xn/gIzxNLfeGm/iJjrK/mmDnyp3/v4uJ796jY9r5nXcCsTiXQckBi/ql90dioAU++ziWQObqI7doxQMGNIKHDj1YHmIdYCOPTi1ZITIQmiDczHB4yQrEENQ8Y28Nudz1/Thr/sXDfssZ9SZSOkx0ECW4RWPgSeG8y/VhMI2LsRyI9fELrk5bUb1sirZtS4uiPA190QV0fhSIu5KnQoR8hiYggpaVYJksovlhzPykA7Wbe01kdnh6CRZMWE/NzmQpzcKdECdn8OKemfvmW5GZEay2TGL2kRgmprPpSJKlqBDrnmQpf8azHx0QBisSzIal3USJNoDwbBfvLG4I/jHEr8nVMZy8QKnvApRQ9Hu5wTamY8tTOCzLvyMiTuMn73a1DWc5V5f+Wfq6D2xFzG5RDw4xIh7linaI7UwnNEN7rWSwypnjQeKv3bX/EPFOv7gOQqbg0jXQj3AbqCrdt6+TZ69tP54/4E3WnvrzOE1x/qohy4ZLmj6oj3T/baBd/HTO+YGh8CzelTvKs5j6hAS2HbshCHVf+bwtJjZHEmPdWhPS5ZZG3MR/pQgj3kHH3dpUmmjkp5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?douaHqlvd4/25CVW/IJ/SIe9U4VFXzjBV/LBYe/VgjUUF4CESvz5l2dO6u?=
 =?iso-8859-1?Q?GcbWU4k8Qf0kYPY1loFjMi7XWGkKNFTy5v03bW3S2Gm02uVpOGnr4BlpKT?=
 =?iso-8859-1?Q?B4qbOkz7pYd3k7NFBMbZMGyHTB2kMumj2MZe9Rff6QHbTngwr6Ttfx6WOb?=
 =?iso-8859-1?Q?iJTnfffPZAFJSWFbwSHHOXOlniiJcDhcj9BEgCVRIVywkTyvYyjbadxGfz?=
 =?iso-8859-1?Q?wZ333MqABjf5T3f7cYN1WHS8VTDIHKe9FV9ooTx4oIoxLclBGbdg2ol+up?=
 =?iso-8859-1?Q?E8kjFGBbioLwryvv4ENmzSNfqq7W6AYP8g8doX+UpxchDqwHhdR20MFlbX?=
 =?iso-8859-1?Q?GgNo5gq1vDstr6hFC7I7s88N6szGjkMzWqMA0XlSpzgR9dS46Zswoy+0K7?=
 =?iso-8859-1?Q?+QxkmalnZraT62IG5YnQ8i9e/V0bZoeBKMHftfsAZKozRz9goeyVCkczo4?=
 =?iso-8859-1?Q?A9HgazaSJBnFPpWwO1B+n1RPYe1x+7R6hpoaSPrBfGeGeNmf7f3RfytM5E?=
 =?iso-8859-1?Q?FOIzIcRBQapNjD5eOraipB8/1EqwO8mqW6vArkoSx2r8xcR8v5LLAd79YU?=
 =?iso-8859-1?Q?uTIA7fzBQx3lkV7gjeDtAf5VIALQWym6KCABSOGVLmJ72NTH2/KuhQUUyt?=
 =?iso-8859-1?Q?I33FoLp20wGId5chW1CmAUWja3xZ2WN7qVtoHFxTb/vJLfWuF0+6to5ICS?=
 =?iso-8859-1?Q?T41Dtd+0JPcgINh0J4+UICgyNp5ZB/CNX8jQyAlfHiF+dMtYRD157mfqw+?=
 =?iso-8859-1?Q?lnSCr2BiwOfKVlZisIBlQAAoq89UiCLdutvq7gDGxcES8hR4lotDe/eJhU?=
 =?iso-8859-1?Q?/jpBzd5pcYQlT44S/B9OXlsI4LAU1JhILN2tHUPHYnrFI62lyGjNy33f2m?=
 =?iso-8859-1?Q?RkRtaWYlsGHjL8jHtRiGF5oe1vnnGQv7DFZ8V//cf1fuJ6tt1oL0XQCFzC?=
 =?iso-8859-1?Q?Ubnob0BEo6+PtiOdaGW39C/V2hl8YOjTlV4Y8GdayAWNO3pa3f+Nkudavv?=
 =?iso-8859-1?Q?B3QeSyFo5Kbam4DfZ0tsNCznM8z+dKj5AhhqBov2wfRSYmEqzY6qc5dStC?=
 =?iso-8859-1?Q?ONKeXIGYH/9X4yVAUbYz820ucu4xVwTMsJVxMPFxyzXm3kh+EUpbC/yW8a?=
 =?iso-8859-1?Q?FMF5shncyIWMFEGfSBhaU4z86C02j7HqIAwmPUsTpQnSLKECmwOckP5/8T?=
 =?iso-8859-1?Q?vgKPZw370tpZQiJ/2cFA/zIGGfrSC6RssM6L5PhudTrhRb/e2EmBhdyEqK?=
 =?iso-8859-1?Q?VsGjWIKhedojKFvOVyLmYE1PVrvThfyPeY8OuHxBCg14OcPqChek0bCs+C?=
 =?iso-8859-1?Q?FypR1C3NMZam986IgHcOUdnhn5cTArSn9qYyrIuvaMT4CL+ghmL8+qmtzG?=
 =?iso-8859-1?Q?WwDMQ5j4aDkPaIAn6KzJl/z2N84bRUNZqP1xHvbA9Rpy2F925MW66Go+zr?=
 =?iso-8859-1?Q?rKvWRZxSnJGJigNufj0wBdb+3RSNw8vza2bXljQcHtjDGVcO7lj6zVQk7Z?=
 =?iso-8859-1?Q?5rRDC2un+cUTxoiwFhGnLlUZXuNSx1+CPgGHYc3TRIvCEUagGZKyc998iB?=
 =?iso-8859-1?Q?rd+51FEgINVgE2Ga9bSPDTXdTw12siTF3FPcCG7X9F2DCQ6aOQrUWqWxGv?=
 =?iso-8859-1?Q?rZeBCXIjvlWy2uLgVbo4ybZ6UfDUFypHzOGddRZxgq4dsWUHzGFPvcoA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c752635-19e1-4028-1ca0-08dc5389c062
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 02:57:08.6722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eDwSIH/fX5pp1CAPOwpX9vAfF8MuVftjxLX0j9veNPckQ9lX1EdJ324ICPq5lyJJFHBKUqRgG/xEvjkK2rVQQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6900
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 1.9% improvement of stress-ng.dup.ops_per_sec on:


commit: c69ff4071935f946f1cddc59e1d36a03442ed015 ("filelock: split leases out of struct file_lock")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stress-ng
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	disk: 1HDD
	testtime: 60s
	fs: ext4
	test: dup
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240403/202404031033.c2d3b356-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/1HDD/ext4/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/dup/stress-ng/60s

commit: 
  282c30f320 ("filelock: remove temporary compatibility macros")
  c69ff40719 ("filelock: split leases out of struct file_lock")

282c30f320ba2579 c69ff4071935f946f1cddc59e1d 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    195388            +2.0%     199324        vmstat.system.cs
   1502041            +1.9%    1531046        stress-ng.dup.ops
     25032            +1.9%      25516        stress-ng.dup.ops_per_sec
      2020            -1.9%       1982        stress-ng.time.system_time
    176.48           +11.1%     196.06        stress-ng.time.user_time
   3992532            +1.8%    4063489        stress-ng.time.voluntary_context_switches
 1.949e+10            +2.3%  1.994e+10        perf-stat.i.branch-instructions
      1.51            -3.2%       1.46        perf-stat.i.cpi
 9.495e+10            +2.3%  9.711e+10        perf-stat.i.instructions
      0.67            +3.6%       0.70        perf-stat.i.ipc
      1.51            -3.4%       1.46        perf-stat.overall.cpi
      0.66            +3.5%       0.69        perf-stat.overall.ipc
    198601            +1.9%     202371        perf-stat.ps.context-switches
     16.89            -3.1       13.75        perf-profile.calltrace.cycles-pp.filp_flush.filp_close.put_files_struct.do_exit.do_group_exit
     24.02            -2.8       21.19        perf-profile.calltrace.cycles-pp.filp_close.put_files_struct.do_exit.do_group_exit.__x64_sys_exit_group
     12.92            -2.7       10.25        perf-profile.calltrace.cycles-pp.locks_remove_posix.filp_flush.filp_close.put_files_struct.do_exit
     33.85            -2.5       31.32        perf-profile.calltrace.cycles-pp.put_files_struct.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     53.34            -1.8       51.51        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     53.34            -1.8       51.51        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     53.31            -1.8       51.47        perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
     53.31            -1.8       51.47        perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
     54.16            -1.8       52.34        perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.62            +0.0        0.64        perf-profile.calltrace.cycles-pp.do_dentry_open.do_open.path_openat.do_filp_open.do_sys_openat2
      0.74            +0.0        0.77        perf-profile.calltrace.cycles-pp.acct_collect.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.86            +0.0        0.89        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe._exit
      0.86            +0.0        0.89        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe._exit
      0.60            +0.0        0.63        perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.anon_vma_clone
      0.86            +0.0        0.88        perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe._exit
      0.86            +0.0        0.89        perf-profile.calltrace.cycles-pp._exit
      0.68            +0.0        0.72        perf-profile.calltrace.cycles-pp.do_open.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.82            +0.0        0.86        perf-profile.calltrace.cycles-pp.up_write.free_pgtables.exit_mmap.__mmput.exit_mm
      0.70 ±  2%      +0.0        0.74        perf-profile.calltrace.cycles-pp.kmem_cache_alloc.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm
      0.81            +0.0        0.85        perf-profile.calltrace.cycles-pp.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.59            +0.0        0.63 ±  5%  perf-profile.calltrace.cycles-pp.__libc_fork
      0.85            +0.0        0.89        perf-profile.calltrace.cycles-pp.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      0.85            +0.0        0.88        perf-profile.calltrace.cycles-pp.kernel_wait4.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      0.65            +0.0        0.69        perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.anon_vma_fork
      1.09            +0.0        1.14        perf-profile.calltrace.cycles-pp.kmem_cache_free.exit_mmap.__mmput.exit_mm.do_exit
      0.95            +0.0        1.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      0.96            +0.0        1.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.wait4
      0.94            +0.0        0.98        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.anon_vma_clone.anon_vma_fork
      0.98            +0.0        1.02        perf-profile.calltrace.cycles-pp.wait4
      0.55            +0.0        0.60 ±  7%  perf-profile.calltrace.cycles-pp.stress_dup
      0.98            +0.0        1.03        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.anon_vma_clone.anon_vma_fork.dup_mmap
      1.44            +0.0        1.48        perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.42            +0.0        1.47        perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
      1.86            +0.1        1.91        perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      1.85            +0.1        1.90        perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      1.18            +0.1        1.24        perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__clone
      1.18            +0.1        1.24        perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__clone
      1.18            +0.1        1.24        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__clone
      1.18            +0.1        1.24        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__clone
      1.51            +0.1        1.57        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      1.74            +0.1        1.80        perf-profile.calltrace.cycles-pp.kmem_cache_alloc.vm_area_dup.dup_mmap.dup_mm.copy_process
      1.60            +0.1        1.67        perf-profile.calltrace.cycles-pp.kmem_cache_free.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput
      1.83            +0.1        1.89        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      1.86            +0.1        1.93        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      1.82            +0.1        1.89        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      1.52            +0.1        1.59        perf-profile.calltrace.cycles-pp.__clone
      1.82            +0.1        1.89        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      1.28            +0.1        1.36        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.anon_vma_fork.dup_mmap.dup_mm
      1.36            +0.1        1.44        perf-profile.calltrace.cycles-pp.down_write.anon_vma_fork.dup_mmap.dup_mm.copy_process
      1.22            +0.1        1.30        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.anon_vma_fork.dup_mmap
      2.38            +0.1        2.48        perf-profile.calltrace.cycles-pp.vm_area_dup.dup_mmap.dup_mm.copy_process.kernel_clone
      3.34            +0.2        3.51        perf-profile.calltrace.cycles-pp.anon_vma_interval_tree_insert.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm
      5.14            +0.2        5.37        perf-profile.calltrace.cycles-pp.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput.exit_mm
      6.76            +0.3        7.04        perf-profile.calltrace.cycles-pp.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm.copy_process
      5.87            +0.3        6.16        perf-profile.calltrace.cycles-pp.fput.filp_close.put_files_struct.do_exit.do_group_exit
      7.49            +0.3        7.82        perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.__mmput.exit_mm.do_exit
      9.30            +0.4        9.69        perf-profile.calltrace.cycles-pp.anon_vma_fork.dup_mmap.dup_mm.copy_process.kernel_clone
      0.10 ±200%      +0.4        0.52        perf-profile.calltrace.cycles-pp.fifo_open.do_dentry_open.do_open.path_openat.do_filp_open
      7.40            +0.5        7.86        perf-profile.calltrace.cycles-pp.dup_fd.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
      0.05 ±299%      +0.5        0.52 ±  2%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.anon_vma_fork
     17.56            +0.6       18.18        perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
     17.62            +0.6       18.24        perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
     17.63            +0.6       18.25        perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     19.31            +0.7       20.03        perf-profile.calltrace.cycles-pp.dup_mmap.dup_mm.copy_process.kernel_clone.__do_sys_clone
     19.75            +0.7       20.48        perf-profile.calltrace.cycles-pp.dup_mm.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
     28.58            +1.3       29.84        perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
     28.58            +1.3       29.84        perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
     28.59            +1.3       29.85        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
     28.59            +1.3       29.86        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe._Fork
     29.12            +1.3       30.41        perf-profile.calltrace.cycles-pp._Fork
     29.02            +1.3       30.31        perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
     17.87            -3.2       14.72        perf-profile.children.cycles-pp.filp_flush
     25.00            -2.9       22.12        perf-profile.children.cycles-pp.filp_close
     13.27            -2.7       10.58        perf-profile.children.cycles-pp.locks_remove_posix
     34.49            -2.5       31.99        perf-profile.children.cycles-pp.put_files_struct
     54.16            -1.8       52.36        perf-profile.children.cycles-pp.__x64_sys_exit_group
     54.16            -1.8       52.35        perf-profile.children.cycles-pp.do_exit
     54.17            -1.8       52.36        perf-profile.children.cycles-pp.do_group_exit
     88.90            -0.4       88.52        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     88.88            -0.4       88.50        perf-profile.children.cycles-pp.do_syscall_64
      0.46 ±  2%      +0.0        0.48        perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.24 ±  2%      +0.0        0.26 ±  4%  perf-profile.children.cycles-pp.memcg_account_kmem
      0.51            +0.0        0.53        perf-profile.children.cycles-pp.find_idlest_cpu
      0.61            +0.0        0.63        perf-profile.children.cycles-pp.irq_exit_rcu
      0.66            +0.0        0.69        perf-profile.children.cycles-pp.mas_next_slot
      0.44            +0.0        0.46        perf-profile.children.cycles-pp.___slab_alloc
      0.36            +0.0        0.38        perf-profile.children.cycles-pp.mm_init
      0.75            +0.0        0.78        perf-profile.children.cycles-pp.acct_collect
      0.47            +0.0        0.49        perf-profile.children.cycles-pp.dup_userfaultfd
      0.49            +0.0        0.52        perf-profile.children.cycles-pp.fifo_open
      0.55            +0.0        0.58        perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.78            +0.0        0.80        perf-profile.children.cycles-pp.rcu_do_batch
      0.18 ±  3%      +0.0        0.21 ± 17%  perf-profile.children.cycles-pp.process_one_work
      0.70            +0.0        0.73        perf-profile.children.cycles-pp.wake_up_new_task
      0.84            +0.0        0.86        perf-profile.children.cycles-pp.mas_find
      0.87            +0.0        0.90        perf-profile.children.cycles-pp._exit
      0.62            +0.0        0.65        perf-profile.children.cycles-pp.do_dentry_open
      0.85            +0.0        0.88        perf-profile.children.cycles-pp.load_balance
      0.69            +0.0        0.72        perf-profile.children.cycles-pp.do_open
      0.44 ±  2%      +0.0        0.48        perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.92            +0.0        0.95        perf-profile.children.cycles-pp.newidle_balance
      1.00            +0.0        1.03        perf-profile.children.cycles-pp.pick_next_task_fair
      0.85            +0.0        0.89        perf-profile.children.cycles-pp.__do_sys_wait4
      0.85            +0.0        0.88        perf-profile.children.cycles-pp.kernel_wait4
      0.98            +0.0        1.02        perf-profile.children.cycles-pp.wait4
      1.05 ±  2%      +0.0        1.09        perf-profile.children.cycles-pp.__vm_area_free
      0.65            +0.0        0.69 ±  5%  perf-profile.children.cycles-pp.__libc_fork
      0.97            +0.0        1.01        perf-profile.children.cycles-pp.schedule
      1.43            +0.0        1.47        perf-profile.children.cycles-pp.path_openat
      1.44            +0.0        1.49        perf-profile.children.cycles-pp.do_filp_open
      0.45 ±  2%      +0.0        0.50 ±  3%  perf-profile.children.cycles-pp.memset_orig
      0.61            +0.0        0.66 ±  8%  perf-profile.children.cycles-pp.stress_dup
      1.13            +0.1        1.18        perf-profile.children.cycles-pp.do_wait
      0.57 ±  2%      +0.1        0.62 ±  6%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      1.86            +0.1        1.92        perf-profile.children.cycles-pp.__x64_sys_openat
      1.86            +0.1        1.91        perf-profile.children.cycles-pp.do_sys_openat2
      1.06            +0.1        1.12 ±  3%  perf-profile.children.cycles-pp.ret_from_fork_asm
      1.54            +0.1        1.60        perf-profile.children.cycles-pp.cpuidle_idle_call
      1.68            +0.1        1.74        perf-profile.children.cycles-pp.__schedule
      1.83            +0.1        1.89        perf-profile.children.cycles-pp.start_secondary
      1.86            +0.1        1.93        perf-profile.children.cycles-pp.cpu_startup_entry
      1.86            +0.1        1.93        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      1.77            +0.1        1.84        perf-profile.children.cycles-pp.__slab_free
      1.85            +0.1        1.92        perf-profile.children.cycles-pp.do_idle
      1.54            +0.1        1.61        perf-profile.children.cycles-pp.__clone
      1.09 ±  2%      +0.1        1.17 ±  2%  perf-profile.children.cycles-pp.__anon_vma_interval_tree_remove
      1.23            +0.1        1.31 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock
      2.51            +0.1        2.59        perf-profile.children.cycles-pp.up_write
      2.44 ±  2%      +0.1        2.53        perf-profile.children.cycles-pp.__memcg_slab_free_hook
      2.40            +0.1        2.50        perf-profile.children.cycles-pp.vm_area_dup
      1.71            +0.1        1.81        perf-profile.children.cycles-pp.rwsem_spin_on_owner
      3.53            +0.1        3.65        perf-profile.children.cycles-pp.kmem_cache_alloc
      3.37            +0.2        3.53        perf-profile.children.cycles-pp.anon_vma_interval_tree_insert
      3.03            +0.2        3.20        perf-profile.children.cycles-pp.rwsem_optimistic_spin
      3.21            +0.2        3.38        perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      4.73            +0.2        4.91        perf-profile.children.cycles-pp.kmem_cache_free
      5.16            +0.2        5.39        perf-profile.children.cycles-pp.unlink_anon_vmas
      5.23            +0.2        5.46        perf-profile.children.cycles-pp.down_write
      6.77            +0.3        7.04        perf-profile.children.cycles-pp.anon_vma_clone
      6.56            +0.3        6.84        perf-profile.children.cycles-pp.fput
      7.51            +0.3        7.84        perf-profile.children.cycles-pp.free_pgtables
      9.32            +0.4        9.71        perf-profile.children.cycles-pp.anon_vma_fork
      7.40            +0.5        7.86        perf-profile.children.cycles-pp.dup_fd
     17.58            +0.6       18.20        perf-profile.children.cycles-pp.exit_mmap
     17.67            +0.6       18.29        perf-profile.children.cycles-pp.exit_mm
     17.62            +0.6       18.24        perf-profile.children.cycles-pp.__mmput
     19.36            +0.7       20.08        perf-profile.children.cycles-pp.dup_mmap
     19.75            +0.7       20.48        perf-profile.children.cycles-pp.dup_mm
     29.18            +1.3       30.47        perf-profile.children.cycles-pp._Fork
     29.03            +1.3       30.32        perf-profile.children.cycles-pp.copy_process
     29.76            +1.3       31.08        perf-profile.children.cycles-pp.__do_sys_clone
     29.76            +1.3       31.08        perf-profile.children.cycles-pp.kernel_clone
     12.85            -2.7       10.18        perf-profile.self.cycles-pp.locks_remove_posix
      3.16            -0.4        2.80        perf-profile.self.cycles-pp.filp_flush
      0.72            +0.0        0.74        perf-profile.self.cycles-pp.kmem_cache_alloc
      0.50            +0.0        0.53        perf-profile.self.cycles-pp.kmem_cache_free
      0.81            +0.0        0.85        perf-profile.self.cycles-pp._raw_spin_lock
      0.44 ±  2%      +0.0        0.49 ±  3%  perf-profile.self.cycles-pp.memset_orig
      0.57 ±  2%      +0.1        0.62 ±  6%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      1.70            +0.1        1.76        perf-profile.self.cycles-pp.__slab_free
      2.46            +0.1        2.54        perf-profile.self.cycles-pp.up_write
      1.70            +0.1        1.79        perf-profile.self.cycles-pp.rwsem_spin_on_owner
      3.33            +0.2        3.50        perf-profile.self.cycles-pp.anon_vma_interval_tree_insert
      6.13            +0.3        6.44        perf-profile.self.cycles-pp.fput
      7.02            +0.4        7.43        perf-profile.self.cycles-pp.dup_fd
      7.28            +0.6        7.85        perf-profile.self.cycles-pp.put_files_struct




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


