Return-Path: <linux-fsdevel+bounces-16337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5397689B63A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 05:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7796A1C214A9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 03:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B556FB6;
	Mon,  8 Apr 2024 03:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Su+jvl/N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9C5567F;
	Mon,  8 Apr 2024 03:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712545488; cv=fail; b=PhC/bHamsZgkvfw9vacfsC8+xNsdr4tGe/jwE9bxHl9t27f/6SYr/AG+di28sLZxn4d/iidbhW+aciDCdNo1vacu67rpQf3hJaNmsrDttsRWPx/N+vxmYKd0PpkuaCA1kNKZGjcj4WCrkQ1mrgZYa4r1l2v+9K4Py2ePTGGDky4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712545488; c=relaxed/simple;
	bh=uYk764/6KaoT/+HlWtJ16G5qV2tOQnw+YbQxzGrDFao=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=CdB3UrNYtoMk4aRct52X8LippL75lROJ9yR2R5TCO0cToWVkye8DLWZ1rYFCv/BQhAJDsA55v/X8GdtIiA3zfMtIiUrzFVkGcwCRGfPDEb0/qTVXFThtj1JwV+Hhp3PwWbpoHQjNXxlBoiaXE/KM9Vh+CoAnWYgRI+g6eyAD/WE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Su+jvl/N; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712545486; x=1744081486;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uYk764/6KaoT/+HlWtJ16G5qV2tOQnw+YbQxzGrDFao=;
  b=Su+jvl/NCt0A+E0c24XmGr9AudW3n8rBY9nP3ZF2wrV53WMQxO/azRLG
   9V0acP1iGF6/GB+d1/WOFsnLTJNWHWIM/MXrwk6qwflGnCw/gVo5elAKD
   BUAR9MlkV1R2mhhbpwqh51LyNOA7mikOnNYdAnoxtHzvWAdZMvEjR/L+q
   NBG3UyJcVU3EGA5gI8tROHBJbYPi4iM4CQlXlSh+B+plr5qrR6DKIcOlT
   yagdujH1CNnY+q0tGBTG7cPj2+Un8cEkF3EsONWMzn3bgqru9mD8l9DsS
   86uh3vpUExcUMx/qYiue6D7gNOIBV/pUse9p1xUP1hiXqQltTPT+aB5ys
   Q==;
X-CSE-ConnectionGUID: 3+MLU6B/RQOCymWbxm4r0w==
X-CSE-MsgGUID: IoZI3RU5TMaDDpLFyhb0Hw==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="7642221"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="7642221"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 20:04:45 -0700
X-CSE-ConnectionGUID: ArJUln0gTt+bm2jPgRkYUQ==
X-CSE-MsgGUID: Wt0GdtHLSGqpWDX5vRwpMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="19794504"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Apr 2024 20:04:44 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Apr 2024 20:04:44 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Apr 2024 20:04:43 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 7 Apr 2024 20:04:43 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Apr 2024 20:04:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzdjJX4F30OlmG0KeejE3fY3CHyCf866cljBG7WEwJPR/kvytzIZHMtOvCBjMMagung3nXaEzcxZauaPnukWMiLSoREXz/PMo/3aCP4diaV0WAVMJHU8N4VMFt5t98ShGNshY5FGVYiqTn/NEyFcowsKLJHOn2XJcaBsfGQjRS1HPaS9ez8sgTPXPL9j7sw3AaJR+o11CnmpprNxyTlEMicaxFj3Cp7rD+f2QDW03g864ARiQstRDbWYozfFmGssLDcfSRsn8Mv/Y6k65K8jGq2mG7ym6490wHF5zSaC8SpfabLk0FRfTSc3kHSl1UmkJRvqmHcZwLQxT4vGPLkZrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99flzzJk7Izo6OcIMxuky3u7RPlETzfjAWeNU/iODWY=;
 b=GGwOZg/7cT6Iiyd1418ZqYaUgK7eafwfWkoqSox3g51V01S2SSBxVgMXwAuQ3Tvskt7ne/xPZ+fMgHjf0D5fIa7b26rZtChpvCdxVo4lkYhWRotAkbZuzlgR1K61mtjn0/HMeQWw0NWdulLxYCf0YIJapNrWGkciWVkrl8BIgL+xqvHU+EaIzVDZe0svZ2ev8x5DvinWMyEdLk+PwUmdyieAJc4Tsqx+NO7HUBQw2vreFrRhDaH4Yjp6YD5pIi+gqkzBlOsEDiqYgM19nKcXklMDWB7oZpA7msIgwZK/+LbfjNdCurNcscLqB+tvIHq3dRzMVwOLsFzdC+II4Lr/2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CO1PR11MB5060.namprd11.prod.outlook.com (2603:10b6:303:93::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Mon, 8 Apr
 2024 03:04:42 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7452.019; Mon, 8 Apr 2024
 03:04:42 +0000
Date: Mon, 8 Apr 2024 11:04:32 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Jeff Layton <jlayton@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	<gfs2@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<devel@lists.orangefs.org>, <linux-mtd@lists.infradead.org>,
	<linux-xfs@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [fs]  541d4c798a:
 BUG:KCSAN:data-race_in_atime_needs_update/inode_update_timestamps
Message-ID: <202404081036.56aa7de3-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0033.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::23) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CO1PR11MB5060:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lt6aRq+pr2Ln9qPJPgDbWtCoJFsWooL/R9U7P6y4tNcKEt3bVE7PbtCqaNG7REKszG6JYFx3OarH6q6FsV/Q6GHfe0dqU4XwonBQJIef4ES2ZbGjKxEcSqF9Vw2l/YPfszI6TaDyFHRi9T4HLbNn5uSSSWMAXx2oBwtZlI45qbvue2pe1sl14xqZSzJEstZRt/3i+GUL3j/HI8C0A0l5qUu+0+ldu6l8Z8kAzqumeMakXTi9nzTc18/ASjtYP06rPF4H3eJI7M65Wh+at1xb8W9ftkhJn9byoABawkz9INyrU+Rl8PObXD0wbMeSDGU5oci1LLwcWC02AMENtaUlJQmK5NWWypvF3vlDAHR69Ye8V6D+qHE4jvt1ThQi3q+4TmjZgbE9AEvqRRl23j3uoU1OAp4Fd8K4BaAxkrqBfnQElvZFB5Ybn6uGieo0VHmrr9Z9COPiFcPPxGTSKvEbMUahJ0Y2qd8gKX8MapiUPSfpdGINhFMDmdew6HmXqeApwrWAPiquKHJmf1Ct4atGg/NiORWk10/1tIj9i1O5yBSFLYBkTyZv9YZyMk8Oobf0J+kvk5fJAqeddTP/DUpoGr7QGEfRQ31cHxecO1S5PSEdNaIRQbsnXVC8cd6XUu9v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F2cY3WZHQrY8TJ3uLhzbF2Swjg/rlCzIVE4karWMcCMOSnJZ8eIZNDjUdy+n?=
 =?us-ascii?Q?9avLQq3tXOMCPQXLJJXKYW0ro0unMNeCWI0H8wjlF+lgiITleNLm8DGx8O1H?=
 =?us-ascii?Q?mEm8AjWfQcr+mIOvRCEl3HCc3zE6cvCxvt9UvXCjMbGFCR2wSoCmeIC56JxZ?=
 =?us-ascii?Q?BW1XNc6VAqSBQtozjC6faG0sTSgbiOUfYmDR4ZNs0GSZTY392SLsWDjCkTzd?=
 =?us-ascii?Q?pHgbpYCZjZhGPnNFgO9U94dj+/DQhiLdoJRl7ove+yCBfga4PqmH4vxYsjn0?=
 =?us-ascii?Q?QOAiC2+nLBP6Y3/u/gRAFD3dCAhC9wr4jTiiIXeyw5QQxSFShY0uavmetwMQ?=
 =?us-ascii?Q?X83/28vvb4an509EoqmXdrivEk1dXZy5GQcmovvUu1klHVuwH0KMY6wQyNiI?=
 =?us-ascii?Q?L2YIgM7zcU8dbi8y3a47cjplO4lEXQkKYJVqrsCA1sNyjK/7JPHBUjsvyXK6?=
 =?us-ascii?Q?bBM5t3AJDjOw+zFi11xDkGYmN1WxC/yTxT7/FkItFoRClqIv4/ZFUNJFWHZe?=
 =?us-ascii?Q?EKn9Xwiysp/eIJ8Mw9FVi2XzS/hgrCNUKqzNKaDjqEFCYvLsnxZCdDqCDkTx?=
 =?us-ascii?Q?jF2PeDiF5Z7PbZ1qkMWJKyUSYwzAiN6KkVAyuZKOC+OxD8XYhiwSUvaUKFhO?=
 =?us-ascii?Q?JL0D3ehiBYeInSTQl5ux3Hb3IVzuMnCPtml0lrpG03/8GjY1kRAljgd3TEuS?=
 =?us-ascii?Q?CiG6ZiL5MkXMk49djpqw/h3bobWh11q004jpfpVruqWgNyBqdCky0YuHu4eg?=
 =?us-ascii?Q?XYAoZ0yEXj+rrVRhjGv51BvEyCPolcE73ulp4UCfd5O5HgfgRwp3LpoZx/ok?=
 =?us-ascii?Q?W3KVwffCi1oifZyTVRulw8Zyj5S4YAUYaiL89MNXRTfw2lIfK16esL9KNlP0?=
 =?us-ascii?Q?S/WFwK3XCIkYTkCTLmEfIjKRHDn4LYtBUc2kryVm6hcAe6oRz/STXBuTgWU9?=
 =?us-ascii?Q?N8uRxTWFdmectvZSqLibDrheTkcbrUQEYAtxZ+vPxiX6zvcBQmW4Y6Wj5X2v?=
 =?us-ascii?Q?1ZCq6DTRUeGU7Cxx6076hOf/TMoqNxMnMep91Z2venDhUHay78wMcw8V6xrv?=
 =?us-ascii?Q?up8jxQ75bYeB5PJGaYjonyWwwyt0hsrkyLwTcImtWnWr7ms2FGcWwtOuAuUE?=
 =?us-ascii?Q?ghLLvtImcXmJOA4X+1L5hnhizsX+cFiSCCXPmXzBOtR4yW/QCjv9E+LpyUdz?=
 =?us-ascii?Q?K3ADxVc9Zgajsj3G2uD0aP9ROV19Kag3i/Sl2UUvUtOd8h4GQLyCM/KxF2e2?=
 =?us-ascii?Q?C8Z02u4upvDCxHTcBKiX/ZfdeIYw/Hs0U2rFgtxVYOiafAbrfYljXqUFd5c8?=
 =?us-ascii?Q?RmY1b5THGxspoaCZ8iJKNQo6JAuCSHDnGzkJlJtB9Vm5ML/E+HZq+BKfdZqp?=
 =?us-ascii?Q?fNizKe6ifSfns0G/yVNKk/KGheIEE/7iKlTo3gjsjV3aApEyU5PXgACsXKSW?=
 =?us-ascii?Q?70PFopYdZcY8CZoIXNUCaX+DgM21RfHNYCtkMGsoecoCTIudXrq4rgCo4NrL?=
 =?us-ascii?Q?SphxXqlgWAOH5x4PNwp9R6RJaTO9pNXxUzTVp81kEcNo695i4JCLTZhwirwF?=
 =?us-ascii?Q?/h1HsvK0mbrcsewWPzmvPL7FgG3Z32BrfGJJdpIN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ee5022-2534-4f20-6913-08dc5778a2ad
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 03:04:41.9599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LrrXdX/mVHBokcAavil8qtuincZ1J2934ecm+S+2sdkRiZPK0jKWB0cLywzv3rWiDcjUjFOqUyRV+Cqe7/SSoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5060
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:KCSAN:data-race_in_atime_needs_update/inode_update_timestamps" on:

commit: 541d4c798a598854fcce7326d947cbcbd35701d6 ("fs: drop the timespec64 arg from generic_update_time")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

in testcase: trinity
version: trinity-i386-abe9de86-1_20230429
with following parameters:

	runtime: 300s
	group: group-04
	nr_groups: 5



compiler: gcc-13
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


we noticed this issue does not always happen, and parent has similar ones.
we don't know if these issues are expected, just report what we found in our
tests FYI.


0d72b92883c651a1 541d4c798a598854fcce7326d94
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
          8:202         -4%            :202   dmesg.BUG:KCSAN:data-race_in_atime_needs_update/generic_update_time
           :202         11%          22:202   dmesg.BUG:KCSAN:data-race_in_atime_needs_update/inode_update_timestamps
         48:202        -24%            :202   dmesg.BUG:KCSAN:data-race_in_atime_needs_update/touch_atime
           :202          7%          14:202   dmesg.BUG:KCSAN:data-race_in_generic_fillattr/inode_update_timestamps
         21:202        -10%            :202   dmesg.BUG:KCSAN:data-race_in_generic_fillattr/touch_atime
           :202         12%          24:202   dmesg.BUG:KCSAN:data-race_in_inode_update_timestamps/inode_update_timestamps


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202404081036.56aa7de3-lkp@intel.com


[  179.356355][ T3221] BUG: KCSAN: data-race in atime_needs_update / inode_update_timestamps
[  179.363113][ T3221]
[  179.363323][ T3221] write to 0xffffa34c4c66f600 of 8 bytes by task 3222 on cpu 0:
[ 179.363951][ T3221] inode_update_timestamps (fs/inode.c:1923) 
[ 179.364410][ T3221] generic_update_time (fs/inode.c:1948) 
[ 179.364823][ T3221] touch_atime (fs/inode.c:1966 fs/inode.c:2038) 
[ 179.365207][ T3221] generic_file_mmap (include/linux/fs.h:2245 mm/filemap.c:3616) 
[ 179.365721][ T3221] mmap_region (mm/mmap.c:2751) 
[ 179.366104][ T3221] do_mmap (mm/mmap.c:1362) 
[ 179.366448][ T3221] vm_mmap_pgoff (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 include/linux/mmap_lock.h:41 include/linux/mmap_lock.h:127 mm/util.c:545) 
[ 179.366840][ T3221] vm_mmap (mm/util.c:562) 
[ 179.367181][ T3221] elf_map (fs/binfmt_elf.c:378) 
[ 179.367586][ T3221] load_elf_binary (fs/binfmt_elf.c:1187) 
[ 179.367996][ T3221] search_binary_handler (fs/exec.c:1740) 
[ 179.368434][ T3221] exec_binprm (fs/exec.c:1781) 
[ 179.368813][ T3221] bprm_execve (fs/exec.c:279 fs/exec.c:383 fs/exec.c:1533) 
[ 179.369251][ T3221] bprm_execve (fs/exec.c:1885) 
[ 179.369784][ T3221] kernel_execve (fs/exec.c:2023) 
[ 179.370172][ T3221] call_usermodehelper_exec_async (kernel/umh.c:114) 
[ 179.370673][ T3221] ret_from_fork (arch/x86/entry/entry_64.S:314) 
[  179.371043][ T3221]
[  179.371253][ T3221] read to 0xffffa34c4c66f600 of 8 bytes by task 3221 on cpu 1:
[ 179.371864][ T3221] atime_needs_update (include/linux/time64.h:49 (discriminator 1) fs/inode.c:2008 (discriminator 1)) 
[ 179.372294][ T3221] touch_atime (fs/inode.c:2020 (discriminator 1)) 
[ 179.372669][ T3221] generic_file_mmap (include/linux/fs.h:2245 mm/filemap.c:3616) 
[ 179.373163][ T3221] mmap_region (mm/mmap.c:2751) 
[ 179.373533][ T3221] do_mmap (mm/mmap.c:1362) 
[ 179.373950][ T3221] vm_mmap_pgoff (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 include/linux/mmap_lock.h:41 include/linux/mmap_lock.h:127 mm/util.c:545) 
[ 179.374338][ T3221] vm_mmap (mm/util.c:562) 
[ 179.374673][ T3221] elf_map (fs/binfmt_elf.c:378) 
[ 179.375070][ T3221] load_elf_binary (fs/binfmt_elf.c:1187) 
[ 179.375498][ T3221] search_binary_handler (fs/exec.c:1740) 
[ 179.375941][ T3221] exec_binprm (fs/exec.c:1781) 
[ 179.376294][ T3221] bprm_execve (fs/exec.c:279 fs/exec.c:383 fs/exec.c:1533) 
[ 179.376712][ T3221] bprm_execve (fs/exec.c:1885) 
[ 179.377063][ T3221] kernel_execve (fs/exec.c:2023) 
[ 179.377452][ T3221] call_usermodehelper_exec_async (kernel/umh.c:114) 
[ 179.378061][ T3221] ret_from_fork (arch/x86/entry/entry_64.S:314) 
[  179.378434][ T3221]
[  179.378635][ T3221] value changed: 0x000000000402a3d1 -> 0x000000000411e611
[  179.379219][ T3221]
[  179.379411][ T3221] Reported by Kernel Concurrency Sanitizer on:
[  179.379920][ T3221] CPU: 1 PID: 3221 Comm: modprobe Tainted: G                 N 6.5.0-rc1-00096-g541d4c798a59 #1
[  179.380804][ T3221] ==================================================================



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240408/202404081036.56aa7de3-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


