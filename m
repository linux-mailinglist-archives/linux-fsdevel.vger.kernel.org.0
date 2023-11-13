Return-Path: <linux-fsdevel+bounces-2787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7007E9727
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Nov 2023 08:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B094B209E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Nov 2023 07:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE194156F9;
	Mon, 13 Nov 2023 07:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="icQjKiVn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8D6154B3;
	Mon, 13 Nov 2023 07:59:21 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D762710F3;
	Sun, 12 Nov 2023 23:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699862359; x=1731398359;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kTmBPMVE/2ELObgNWHexFQZvYkNCYFwnrNDifYCkE3A=;
  b=icQjKiVnVe2jxOv/h8Iif/6fu7rgCfUzGOTrJl7TaK/dHxZIHR+VjA9w
   jNIy0hktv6Eap6qlWlOivT1+YGK+sWODfBSktdvo4s/BZ98AIxxKpBecT
   sfEVYQDMsXEUmGJCk1rBCk4EpNLCaCQ5kmVB2r7lfap+tBtd3ziszsozs
   fmyrUap/O5os3fdOKMZE0gAGqSCaTMVREUj3b/81TF8/GzzLufnfaz2np
   23hERk/qMr0zBETEtiMamsUcwNBET2Ij6eIqrMkmyqQDlKY5SdG0jzlgU
   ln7kLHA1Olof9T7kceETngigM8VKCRTon38xbtnBgf3qLcr3c6MN0SHTz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="11942357"
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; 
   d="scan'208";a="11942357"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2023 23:59:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="907972813"
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; 
   d="scan'208";a="907972813"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Nov 2023 23:59:19 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 12 Nov 2023 23:59:18 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 12 Nov 2023 23:59:18 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 12 Nov 2023 23:59:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dv6RAkM+duFw53x59Eqpzk6vXf+cTzBX9FWvL1lULlShsgcJz5IH31YpR3Dum13BktBvNNYF6jNmRmU0h/tpHKghalDmmzDC93vO/ecrQKGRJ0C3Qmp0F2swSdGAyFlbBAMDKt04P7TEa8Kn6+W/FqMLHX0dXYvwEQpG1K8gZgIPzrB0Io6dNXQHgDb3wIrtRPlMMqt0eCdtVry/DlM+uZs4sfH17odmlQ+rkO+WdzmHkhgeTgCOJ1lSSQTrogkuFsymCzJ+pNs11KUyjwQpt74wZic6NCMskS4j/J/zDp22d88WL/jNISo2iZw67sVKK22RLHWlq5msPuVXy+LUWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKibrpww95Lyq2q88dFZCqsKzTdI13IDXQYQ0ISR4Bs=;
 b=QNrc55wWJFNcPDNYV7ryUarUu5Iu3w1g5YaIYGk9JiY8WpWCb4zg8ZId/RnfZdM6o0otQteSfMaD9iQl8SpyGIiF135X2LcbgYXQ0y1ns4kMGXH2O3m329kDE1FAX8CK11XkWAvZ61y6nSrJWJsXKqgboNLooTLDCuatJdK5QQzdxjEblZD5dfGFa+YXq/kqmA0+yJhjrXnaxoJyq7PsZ+/9xIpGhO3fWWYQ5TZOzujZ+LWZBDWwxvmxHLIMLK7WYRJpQdJqIJ0zH5+xbh9sAaosnRPtJcxv/SUpztPEu1O2JzBzNIzB6YVJkyRklc6dM3iKTIcXsuafm7NxJnCxsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by PH0PR11MB5206.namprd11.prod.outlook.com (2603:10b6:510:3f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Mon, 13 Nov
 2023 07:59:11 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b8:30e8:1502:b2a7]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b8:30e8:1502:b2a7%4]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 07:59:11 +0000
Date: Mon, 13 Nov 2023 15:59:04 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [viro-vfs:work.dcache2] [__dentry_kill()] 01b17d53ce:
 WARNING:possible_recursive_locking_detected
Message-ID: <202311131520.ff2c101e-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0028.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::21) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|PH0PR11MB5206:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e761ace-3053-4d84-8f07-08dbe41e6bf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hd9UYvz2GTxcKUHsH3WmPK8F+1JF5En3TsuHjHbWoL6D/xDtNwWglSK5k58k8FqbrGN2Es34rFP82PIZKKmL4iQsVjN/ouGhE9XckWvnJWNz0t+cS+F3FULZErhfrkdZjXI4GPBhl1Yk4j3A77lXF8f5Ga+XjrwoRsIZn1ykS5AkwxG46vs0AeSdC7vxhsubdUMw7W8opr3D5VsjJsaeEjb++0DL051WCRjy9plY3ul9pIsTizFl9a7ZHIijs6bR7kjlmmESMxqDf5tB2aYLTV1uw5ZvrojiHWlpCfl7XEXg4Brw0IGWdWii5YEmK149UFcMkB+RGMQWq1t1QbHFBUu60Znci1ejRzeFh9ECyJGl8PEKg5PxZ8RjRlUQEAxCl9KUHpmbCb/sMhHeK9uWZFp1zrKqCRVQ+THKvm+F5qrxZx+LbPHsiRn0RkqgCtIkObjdtzHBTSvKbgIQsKPI47QbttcBRRkL9yuF1czTX6fXGdQZSpuGpV2OdgXCvbSiollq42JDuNPqLjy/jQ37SSP9Hiwul1kOUVbJkBbNMekRYq9yRgIXtXfvkAUv0WDEFLhVbJcRrqmJvcQ6s5mHzMCgqCExum9SNaBlKhSZmsFq22rGMcn0RNbX2YgAkIPbwDiSM0AcJmM5DovsWwcLnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(366004)(39860400002)(376002)(230273577357003)(230922051799003)(230173577357003)(64100799003)(186009)(451199024)(1800799009)(6916009)(2906002)(66476007)(83380400001)(1076003)(107886003)(4326008)(41300700001)(8676002)(8936002)(66556008)(66946007)(38100700002)(316002)(86362001)(5660300002)(478600001)(6512007)(6666004)(6486002)(966005)(6506007)(36756003)(82960400001)(26005)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?apTck1odZrVM6XnwUaLsaSux2qujgraWvBNsQG/XBB/fnF1HL5RiOcvlDVxN?=
 =?us-ascii?Q?hp4tUwG799il+P4wZCiA6YWxefXxNSGwCRaTV0mkJ3qeAsEu1y2b7F3DgNUa?=
 =?us-ascii?Q?IAUHE3+gjMumB/InctECScXBYost72rpTgvdlO9x1AQFoLniFvH1b4qo7Xh2?=
 =?us-ascii?Q?rgT9JPqoivGK3OHUddaO31NzfAA5Q52WkeYhjxdxMBSrIAkDTXatJdXFHx4C?=
 =?us-ascii?Q?qSdDsYfCqtcKKLHvt3coWlAuUAzQ33dVUrONxE7SclQC4Nv/9KAfQqLMw6K1?=
 =?us-ascii?Q?ft15wL07IuT3HvfadmwQVQ17gBmCBnASHOvaO4NYsd0JGP2UV4XPsVLkBoHY?=
 =?us-ascii?Q?NmyeMkdDox1vQTMsf9GIZHuQiE1Sq5ogMTWSFf3tZzBxpvozw9vizer70aG+?=
 =?us-ascii?Q?SsE7SfJbJ/o8QMk9dbAIbr8t10GwIUieIZ4fBUrkgLAvsbJUsZqhRDttgYSr?=
 =?us-ascii?Q?k3mzNRq8JV5PHjoG0eDlhrW4W8dxtZT7nfl9vpnpuudT9gIgUq7G08J865sv?=
 =?us-ascii?Q?mBGI01Fp2pfx4YPWolvXT4ehsxdROaKpipI5izJ4EnaJfG5uf0h7E+bty8Ap?=
 =?us-ascii?Q?wUxOoXbYW1wTTUoMNaSqIAyKul9gXDwn00NOh3u9S7gvrVz3OK/l2KcgtxVD?=
 =?us-ascii?Q?M/hfb1V+ePHFZpCYpIWrc5G4MRw8lr0bskXsQ4VFSCTV1DH949J6UU8ge8V7?=
 =?us-ascii?Q?AAi0jwID4CD4VXhMTeUMiiHyFjgSfJw+ax4C4O2kCl82/NygxAuqozVRNWGv?=
 =?us-ascii?Q?46Gn30V+OVdF7yK8QsOLAdDLv30b74ktLxgGwuUgrMPz5S4TK3L3gEZR7jQL?=
 =?us-ascii?Q?BEBi3UtoLYP2KAJPft4NESUPKm+RouEReCRt4sTL0PR76MqrK15IWVuQFLAs?=
 =?us-ascii?Q?J9Gs8T59ci1uH9sip4TDj6QKtA04AWiLvvhYrhHi9rt+0BspT7DefInErCpR?=
 =?us-ascii?Q?r45wMuUmruhwLfXX2sT9ptLpG79tBD81lWJRyCnPsl46SWbSbQ2QqhYmgymq?=
 =?us-ascii?Q?O8x0VpdfvV24njoCyIWtWQ9l2fZWKluRhH87byrsRebKM7CXag3Qdq75ieAO?=
 =?us-ascii?Q?zZz3dRjVMd8M8qGODj4lJahogA4TsrJkqeImNAEqoNf2FY6WlNXqDWpSmKsL?=
 =?us-ascii?Q?8tLg+cm2dC9ciVvLF7naSOWI8TWq6bM1aOx4tZY+ikWKFb/7HoPNSPXZ1ndn?=
 =?us-ascii?Q?QgpeHgnFvx9ZFWbs/0o9MYqm/Kniij9mnJQ8kMhZwu/zv8zf1RrzWwUnVrGU?=
 =?us-ascii?Q?GmlWBSsj4iYGSIqdkpJXPPipfIEcUj+wGoTKbO4l/vA4iz7wIFRHB6+vUktf?=
 =?us-ascii?Q?06RSpNibKpZ84TyX1QMFCgNgFO4pCrOBbUp69EQZgAmps6nny7DPajrvu+Hj?=
 =?us-ascii?Q?mYYZlehGsaSZMTkDpWnuR/DSdMoKh/sZj5WsRTpJGePO5AoHTxiorOh7gonh?=
 =?us-ascii?Q?xFOXaESSAzwab5IV/V6sE2BaJAVAWKAZn8wQ4ykLXvs3Ev8X7bX6VrY9DP3M?=
 =?us-ascii?Q?gqeD3Efzkv793dX1QPkJZAyN1sWv0H1VljRPaFqqkOtP/j//sEpbGUgTaVWh?=
 =?us-ascii?Q?VNJ8MyftP6Yh5BzUTbCMTsye8LYY8rzXfUYsHyy/n+05KwoVLNYqrCMwmgce?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e761ace-3053-4d84-8f07-08dbe41e6bf3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 07:59:11.5950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gMmBlUTyq8g8rg4HHzg9iS/y1+WER8tdu67Q7gbFleLhff53JHQBt3mzFkYV1T7fLglDZSkbNGS3c4QH7GiGwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5206
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:possible_recursive_locking_detected" on:

commit: 01b17d53ce197777be701269395edba2fe27069a ("__dentry_kill(): new locking scheme")
https://git.kernel.org/cgit/linux/kernel/git/viro/vfs.git work.dcache2

in testcase: trinity
version: trinity-i386-abe9de86-1_20230429
with following parameters:

	runtime: 300s
	group: group-00
	nr_groups: 5

test-description: Trinity is a linux system call fuzz tester.
test-url: http://codemonkey.org.uk/projects/trinity/


compiler: gcc-11
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202311131520.ff2c101e-oliver.sang@intel.com


[   12.984549][   T32] WARNING: possible recursive locking detected
[   12.985224][   T32] 6.6.0-00022-g01b17d53ce19 #1 Tainted: G                T
[   12.985995][   T32] --------------------------------------------
[   12.986664][   T32] kworker/u6:1/32 is trying to acquire lock:
[ 12.987128][ T32] c140539c (&dentry->d_lock){+.+.}-{2:2}, at: __dentry_kill (fs/dcache.c:547 fs/dcache.c:616) 
[   12.987128][   T32]
[   12.987128][   T32] but task is already holding lock:
[ 12.987128][ T32] c1402084 (&dentry->d_lock){+.+.}-{2:2}, at: __dentry_kill (include/linux/spinlock.h:351 fs/dcache.c:615) 
[   12.987128][   T32]
[   12.987128][   T32] other info that might help us debug this:
[   12.987128][   T32]  Possible unsafe locking scenario:
[   12.987128][   T32]
[   12.987128][   T32]        CPU0
[   12.987128][   T32]        ----
[   12.987128][   T32]   lock(&dentry->d_lock);
[   12.987128][   T32]
[   12.987128][   T32]  *** DEADLOCK ***
[   12.987128][   T32]
[   12.987128][   T32]  May be due to missing lock nesting notation
[   12.987128][   T32]
[   12.987128][   T32] 3 locks held by kworker/u6:1/32:
[ 12.987128][ T32] #0: c12cb2b8 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work (arch/x86/include/asm/atomic.h:28 include/linux/atomic/atomic-arch-fallback.h:490 include/linux/atomic/atomic-long.h:81 include/linux/atomic/atomic-instrumented.h:3196 kernel/workqueue.c:669 kernel/workqueue.c:696 kernel/workqueue.c:2600) 
[ 12.987128][ T32] #1: c1ac3f20 ((work_completion)(&entry->work)){+.+.}-{0:0}, at: process_one_work (arch/x86/include/asm/atomic.h:28 include/linux/atomic/atomic-arch-fallback.h:490 include/linux/atomic/atomic-long.h:81 include/linux/atomic/atomic-instrumented.h:3196 kernel/workqueue.c:669 kernel/workqueue.c:696 kernel/workqueue.c:2600) 
[ 12.987128][ T32] #2: c1402084 (&dentry->d_lock){+.+.}-{2:2}, at: __dentry_kill (include/linux/spinlock.h:351 fs/dcache.c:615) 
[   12.987128][   T32]
[   12.987128][   T32] stack backtrace:
[   12.987128][   T32] CPU: 1 PID: 32 Comm: kworker/u6:1 Tainted: G                T  6.6.0-00022-g01b17d53ce19 #1 330148d6df35f2d99e64624286ad750c7614ad4a
[   12.987128][   T32] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   12.987128][   T32] Workqueue: events_unbound async_run_entry_fn
[   12.987128][   T32] Call Trace:
[ 12.987128][ T32] dump_stack_lvl (lib/dump_stack.c:107) 
[ 12.987128][ T32] dump_stack (lib/dump_stack.c:114) 
[ 12.987128][ T32] print_deadlock_bug (kernel/locking/lockdep.c:3013) 
[ 12.987128][ T32] validate_chain (kernel/locking/lockdep.c:3858) 
[ 12.987128][ T32] __lock_acquire (kernel/locking/lockdep.c:5136) 
[ 12.987128][ T32] lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5755) 
[ 12.987128][ T32] ? __dentry_kill (fs/dcache.c:547 fs/dcache.c:616) 
[ 12.987128][ T32] _raw_spin_lock (include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 12.987128][ T32] ? __dentry_kill (fs/dcache.c:547 fs/dcache.c:616) 
[ 12.987128][ T32] __dentry_kill (fs/dcache.c:547 fs/dcache.c:616) 
[ 12.987128][ T32] dput (fs/dcache.c:1990) 
[ 12.987128][ T32] ? dput (fs/dcache.c:836) 
[ 12.987128][ T32] dput (fs/dcache.c:858) 
[ 12.987128][ T32] step_into (fs/namei.c:1556 fs/namei.c:1840) 
[ 12.987128][ T32] ? walk_component (fs/namei.c:2003) 
[ 12.987128][ T32] walk_component (fs/namei.c:2008) 
[ 12.987128][ T32] path_lookupat (fs/namei.c:2482) 
[ 12.987128][ T32] filename_lookup (fs/namei.c:2513) 
[ 12.987128][ T32] kern_path (fs/namei.c:2610) 
[ 12.987128][ T32] init_stat (fs/init.c:133) 
[ 12.987128][ T32] clean_path (init/initramfs.c:333) 
[ 12.987128][ T32] do_name (init/initramfs.c:366) 
[ 12.987128][ T32] unpack_to_rootfs (init/initramfs.c:451 init/initramfs.c:504) 
[ 12.987128][ T32] ? kvm_clock_get_cycles (arch/x86/include/asm/preempt.h:85 arch/x86/kernel/kvmclock.c:80 arch/x86/kernel/kvmclock.c:86) 
[ 12.987128][ T32] do_populate_rootfs (init/initramfs.c:693) 
[ 12.987128][ T32] ? process_one_work (arch/x86/include/asm/atomic.h:28 include/linux/atomic/atomic-arch-fallback.h:490 include/linux/atomic/atomic-long.h:81 include/linux/atomic/atomic-instrumented.h:3196 kernel/workqueue.c:669 kernel/workqueue.c:696 kernel/workqueue.c:2600) 
[ 12.987128][ T32] async_run_entry_fn (kernel/async.c:129 (discriminator 5)) 
[ 12.987128][ T32] process_one_work (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:444 include/linux/jump_label.h:260 include/linux/jump_label.h:270 include/trace/events/workqueue.h:108 kernel/workqueue.c:2635) 
[ 12.987128][ T32] ? process_one_work (arch/x86/include/asm/atomic.h:28 include/linux/atomic/atomic-arch-fallback.h:490 include/linux/atomic/atomic-long.h:81 include/linux/atomic/atomic-instrumented.h:3196 kernel/workqueue.c:669 kernel/workqueue.c:696 kernel/workqueue.c:2600) 
[ 12.987128][ T32] worker_thread (kernel/workqueue.c:2697 kernel/workqueue.c:2784) 
[ 12.987128][ T32] ? rescuer_thread (kernel/workqueue.c:2730) 
[ 12.987128][ T32] kthread (kernel/kthread.c:388) 
[ 12.987128][ T32] ? rescuer_thread (kernel/workqueue.c:2730) 
[ 12.987128][ T32] ? kthread_complete_and_exit (kernel/kthread.c:341) 
[ 12.987128][ T32] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 12.987128][ T32] ? kthread_complete_and_exit (kernel/kthread.c:341) 
[ 12.987128][ T32] ret_from_fork_asm (arch/x86/entry/entry_32.S:741) 
[ 12.987128][ T32] entry_INT80_32 (arch/x86/entry/entry_32.S:944) 
[   13.024050][   T32] Trying to unpack rootfs image as initramfs...
[   15.772392][   T32] Freeing initrd memory: 128724K
[   15.773782][    T1] RAPL PMU: API unit is 2^-32 Joules, 0 fixed counters, 10737418240 ms ovfl timer



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231113/202311131520.ff2c101e-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


