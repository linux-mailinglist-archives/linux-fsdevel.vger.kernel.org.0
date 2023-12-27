Return-Path: <linux-fsdevel+bounces-6944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D299781EC59
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 06:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9700AB22227
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 05:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0575053AE;
	Wed, 27 Dec 2023 05:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iHGnn4BQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67E35398;
	Wed, 27 Dec 2023 05:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703656374; x=1735192374;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Q/aINvEr1OYfofc/Wge6fy9wESsLxzslSYJcm2wtJuI=;
  b=iHGnn4BQLgfTSUjVxwXAeKP1hP3rkn/4IWbgBCmjv3lNsGcLOTcnGfVL
   ICZnLe6IXWv/lZfLHEKunNNZCTdZUbMM1gWyehT3fz2XlryQuUsFLOhTL
   jqJCXPZDdTmXbC5bMBeR7UoDihZVODzGzN2Dr1Y7i1qixaxDm9XnZioFv
   8NYn/Mnt2nxmnX4Z+tdAeuGe4CYAizhQdgj05vOio6oCx/JNcm1cJ+Az5
   4y1HY1YKQ2is1h1gAneC3mAH4WJvR8s4y3Z/GPStxPg64F773w8EASA0L
   Bwp6suWyam9gPciXwhZ+UGywZmNHXQk4C6attLCiN1LtVrZ/m97gU1qik
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="3245607"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="3245607"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 21:52:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="848598841"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="848598841"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Dec 2023 21:52:53 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Dec 2023 21:52:52 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 26 Dec 2023 21:52:52 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Dec 2023 21:52:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mz8HXyumqqTb5tJANYS5fiLGVO4+FhfHfv3d3uSA948PTGvrby6QisKmfDEMxKJtPT1ZNNAacR8ywefjjNJwhWvJ9EYLzJCR4kvJrl0CNV3JUd5pNXZCW8EggwJf7IchKQwav4TCPCfd2FHks8aYt6Q+XFjw+1uIz7p2U/MZHT7VSejGz6BImR4U41m+xWDjVTU9xSBztHebVoV3RTyUwnoPWiWE8KumekaUNLkb4bB3GGZ4MrcgJneq3XxKOxRD6LphveXAy+QzjqgFemoDBOCAhoCItZkM4PxlKTCex268r5CuRVVMx766j2L3I9onHtu92vbEeDIAczszAdhJfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ALSWyBpvM8UFv5TsjIeSicrKnKNhS4eV4wVE5drMr0=;
 b=lbvm1nVqrvzQmOhVDeq0kaf+MMRQ2M+JjKoAb76kAqS4AxANRY1GgBR4Hw/lOuJ9SAsQsAHp/0kHZLdEfmxKe9a2Pz0Fz94r1pcmhJirfh/khRewKcZ6389vgvl3hDkMwsDoq6c5j83LKHQVIKlBExxWA0zQ0wdiEe6umSRrDZEceUWU/nGwe2PGKOpNctJtk1hIoRt/XygpvVXVqbAiFSHd++Shb9D4+ZVnmSGEcT8ztVtmP2/W9fBKyXq+6J6IeTR5VOp/f3u3qktAM/wmxwYJkWbXDMeFZ3Sn8WsbX2YCM7vagGIKHLHre9yuGwq1Y8v+gcn63859tw0qMUAkEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 05:52:50 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 05:52:50 +0000
Date: Wed, 27 Dec 2023 13:52:42 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Matthew Wilcox <willy@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Zhenghan Wang
	<wzhmmmmm@gmail.com>, <linux-fsdevel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [ida]  af73483f4e: WARNING:at_lib/idr.c:#ida_free
Message-ID: <202312271025.7f350868-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0043.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::12) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_
X-MS-Office365-Filtering-Correlation-Id: 0553de30-5904-483b-079d-08dc06a00f96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C4y/xGGNlc0nbQmKZZR4No2yuScq3xBtdOkjcFvy2Bg3QQzcCiL1bt5Jr8srfWnn5xoibRooppbxFpGJijDTp8+tGBIJPG2qOy1OBzMfU8kdNo9ehpejs1MHzaZKSp6hXZYfQPVoiEhfmXwPyN9roX0dN6igSM0V5YyywQxVRHxj4aehIFDXnqZdLF/EFBHq2GjSeFYHMSWpMWgeMPpAkgDyEde9WYBfI1M8tLpP9yw9QSl81zvCBLZWO4mayY2QsMRwkKApY3vET1ogP49KQGepSlo2sFshNWNGlFLySDUTisA7UwsZS78xg4ShUN2vdw/EiHu4pN96kjG46JUG8l3dQOXDETdLnxM9LfiCJiN5upQKZoZW+XaAfB7Lnpo6YvGd67B1lCtuWYPiv+pZEUVqQ8JarCFC1DGC9zdudttixPg0rNp9n78UjW/NNMZdu5NdlTlIpRYeY52LU2YhSTvml18KImjC3pA8hPzYL6s5/IFeOlt/CM0sVPcksp1PQdYmRIBbl+0ZZFlFabAAwOFLpDt64pO7zyBNT1fJIbHpiX8SaXEce3jjx2lmPTz8vpW8b7jXUOAOdmeVF9kkjZkfygIVzc02iVBnscjoUmadMobothvUVPbaba/utOkUNJaVV5yfn9UVn+DXnN1KzZa3tdwKtHnjmftgiuMDLvo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(346002)(396003)(230922051799003)(230173577357003)(230273577357003)(64100799003)(186009)(1800799012)(451199024)(41300700001)(36756003)(5660300002)(2906002)(26005)(2616005)(6512007)(1076003)(107886003)(6506007)(83380400001)(45080400002)(6666004)(6486002)(966005)(478600001)(86362001)(8936002)(38100700002)(4326008)(8676002)(316002)(6916009)(66556008)(54906003)(66476007)(82960400001)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Kshw2mU5657mQSal7KbzJA3g3LLTkaFWUF622+2y9cBTxk6Ubjx73ZKX04Hu?=
 =?us-ascii?Q?kOBSxITwnhrhEjFyuz8WPTjiJ5/dt/KmFUFwn3jzb9qlDwFKOVPZ4ByZ6l2z?=
 =?us-ascii?Q?vdOhtOYXhfnQsaj47BkY8CGsL2T1rb83vLMA2QeAOeMnNrWd/QTKIl5Qt+Bs?=
 =?us-ascii?Q?rtA0Vc38fEGOmvMZFxCu5Pp3ZOnrMQyoefm0Jw1uIVnNH7VChMlpwCrbQu6v?=
 =?us-ascii?Q?USRQbTg8m5OzCvW1fMw5FsiuTPsbZtHrujHWZQpbTZes0d4MQ+rcT9QYvLjg?=
 =?us-ascii?Q?4rafHUrPS3cvAYX6OPTDmAP9DWPXMcyKGtdWhIDr1uCzPZPhx/EZt/3r8jrA?=
 =?us-ascii?Q?O4nEgc4pKQ8dO08Ql1DRmpKcvG6lklQPY2+0dPvEsgUFobKjLEbO5IjaMBSW?=
 =?us-ascii?Q?BcMypXDc2zqSHie1+hUsxuMOc08a9cG9IQM3zP3uIB/Gbw+ZijGf/aibAUPP?=
 =?us-ascii?Q?xVAsRzwp2kK7BYEjVMjT9onRp4PwcG1OgeJF8WqmyJ+DDfzYupOhy2LEExAZ?=
 =?us-ascii?Q?Yg4ic9PkgD5HmrBzwQym5fpxi6NLplRLabSPKBUN/sFK9fBDTIvaicPBxLTQ?=
 =?us-ascii?Q?VCgkvWNBGJ1ylL7EXkYaWZktb3o5joshLkpUJNuPgJ9TLHqXFuij5IOilOuV?=
 =?us-ascii?Q?UJOBCxS02LoSsGY6bSoZu/bYRLspyvl9IJoluQ5qsG53O13VW+uk45+m2CDo?=
 =?us-ascii?Q?+HXXyXn46dQBsVNGLaq4uGvyErXj8yscdVxtFq8wBbdpDsGw8l8ig1IKkGXf?=
 =?us-ascii?Q?lBr55XYLjtRoMjxxG9fQckeZ4K1+MUOUrXe9kXhbiX8LhgrFflgVCbXIWro2?=
 =?us-ascii?Q?SBxOkMA0kYPYrNko153x54gEa5tqADmiFysyPKsBA2MqSgapzm7C2VDAwmio?=
 =?us-ascii?Q?tRzRFjyuxDTlupc5/y1R98Gl0EfSG5oVGAINfOcBglvjwwner+CMoEbSQf56?=
 =?us-ascii?Q?OUv7vGVTbeVrPQAMI45kWX2w56UXVE+bXHmgGhuMDM+elwaBdcFNBYZ9OyQQ?=
 =?us-ascii?Q?YILPsPe45TB4SU5uf3J89pow0ESxL/RRyW6fgBz2kGGwDl0fqcCh/q7SKaru?=
 =?us-ascii?Q?g+kwJML5O0IhF9cx82IgohzdxyfEd9ih5RRX8tuD0bajEDnfScDYulPeR0FA?=
 =?us-ascii?Q?cB3Xpg4xEY/nwEqQ7qsbyehGxyroIiF70w1r8vSGk7bxwbsLFSP/sBUy3OMI?=
 =?us-ascii?Q?UkE4aRFC8eFCT9CzYO15Ieuc75cxZ+Y6aKMnH+hU6YzU4rn+droR+p3ABSPx?=
 =?us-ascii?Q?TulzRqMrGL5+J4YcKqleab5UAjW2Yw0CoJ7gs4f2+uvG8l3+OwBSiAwgOA9y?=
 =?us-ascii?Q?k5qyjPHabrpNMYpB8YUcEPC0Qic0lMtQ45zEUCwJQf7rAWvA0SmC25mduBek?=
 =?us-ascii?Q?Gj5wHwy0CpVoguJ5Oii9AduJoes7/hr/GviW6ycD4t7wENrRFlG9YXNNJ7/A?=
 =?us-ascii?Q?Yk07Gp3/H8RwwnVYAnCKKP0L4y5f+8Qd1p8aGPlmoOfPfbIQLGmRAvxlMrqA?=
 =?us-ascii?Q?GQHvbEwNmr748WG5du22appM5keEvHITpL2PaXHxu7+YCvQ4d45Wswwp82nG?=
 =?us-ascii?Q?ya4pYEHLKfvS584htcFvXjDPQvZlTzesKDXBVNRtYWklQGHNx+bUsxyhSRWQ?=
 =?us-ascii?Q?xg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0553de30-5904-483b-079d-08dc06a00f96
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 05:52:50.7294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6UdyGL3e2NYBOcYoOWITAc7p+vXDNdlsnRwH/THh4LPUZexljQSO0zt2GcTy44UvyoXE5LKTagVV1j2+cTyzmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8603
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_lib/idr.c:#ida_free" on:

commit: af73483f4e8b6f5c68c9aa63257bdd929a9c194a ("ida: Fix crash in ida_free when the bitmap is empty")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master 5254c0cbc92d2a08e75443bdb914f1c4839cdf5a]
[test failed on linux-next/master 39676dfe52331dba909c617f213fdb21015c8d10]

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+--------------------------------+------------+------------+
|                                | a9e01ac8c5 | af73483f4e |
+--------------------------------+------------+------------+
| WARNING:at_lib/idr.c:#ida_free | 0          | 13         |
| RIP:ida_free                   | 0          | 13         |
+--------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202312271025.7f350868-oliver.sang@intel.com


[  147.266132][    T1] ------------[ cut here ]------------
[  147.267720][    T1] ida_free called for id=0 which is not allocated.
[ 147.270105][ T1] WARNING: CPU: 0 PID: 1 at lib/idr.c:525 ida_free (lib/idr.c:525) 
[  147.272261][    T1] Modules linked in:
[  147.273472][    T1] CPU: 0 PID: 1 Comm: swapper Not tainted 6.7.0-rc6-00167-gaf73483f4e8b #1 daa788c750d4052b7c3e67e211823fb8f7ec7373
[  147.276598][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 147.279512][ T1] RIP: 0010:ida_free (lib/idr.c:525) 
[ 147.280869][ T1] Code: e8 d5 b7 06 00 e9 94 00 00 00 41 83 ff 3e 76 53 49 8b 7e a0 4c 89 ee e8 4e ae 12 00 89 ee 48 c7 c7 40 56 db 86 e8 d0 33 bc fb <0f> 0b 48 b8 00 00 00 00 00 fc ff df 48 01 c3 c7 03 00 00 00 00 48
All code
========
   0:	e8 d5 b7 06 00       	call   0x6b7da
   5:	e9 94 00 00 00       	jmp    0x9e
   a:	41 83 ff 3e          	cmp    $0x3e,%r15d
   e:	76 53                	jbe    0x63
  10:	49 8b 7e a0          	mov    -0x60(%r14),%rdi
  14:	4c 89 ee             	mov    %r13,%rsi
  17:	e8 4e ae 12 00       	call   0x12ae6a
  1c:	89 ee                	mov    %ebp,%esi
  1e:	48 c7 c7 40 56 db 86 	mov    $0xffffffff86db5640,%rdi
  25:	e8 d0 33 bc fb       	call   0xfffffffffbbc33fa
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  33:	fc ff df 
  36:	48 01 c3             	add    %rax,%rbx
  39:	c7 03 00 00 00 00    	movl   $0x0,(%rbx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
   9:	fc ff df 
   c:	48 01 c3             	add    %rax,%rbx
   f:	c7 03 00 00 00 00    	movl   $0x0,(%rbx)
  15:	48                   	rex.W
[  147.285910][    T1] RSP: 0000:ffffc9000001fcc0 EFLAGS: 00010246
[  147.287600][    T1] RAX: 0000000000000000 RBX: 1ffff92000003f9a RCX: 0000000000000000
[  147.290130][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[  147.292478][    T1] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[  147.294746][    T1] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  147.296921][    T1] R13: 0000000000000246 R14: ffffc9000001fd50 R15: 0000000000000000
[  147.299360][    T1] FS:  0000000000000000(0000) GS:ffffffff876d7000(0000) knlGS:0000000000000000
[  147.301863][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  147.303576][    T1] CR2: ffff88843ffff000 CR3: 00000000076b1000 CR4: 00000000000006b0
[  147.305778][    T1] Call Trace:
[  147.306783][    T1]  <TASK>
[ 147.307689][ T1] ? __warn (kernel/panic.c:677) 
[ 147.308848][ T1] ? ida_free (lib/idr.c:525) 
[ 147.310354][ T1] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
[ 147.311607][ T1] ? handle_bug (arch/x86/kernel/traps.c:237) 
[ 147.312877][ T1] ? exc_invalid_op (arch/x86/kernel/traps.c:258 (discriminator 1)) 
[ 147.314319][ T1] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568) 
[ 147.315780][ T1] ? ida_free (lib/idr.c:525) 
[ 147.317007][ T1] ? ida_destroy (lib/idr.c:488) 
[ 147.318327][ T1] ida_check_bad_free+0x23/0x200 
[ 147.320141][ T1] ida_checks (lib/test_ida.c:206 (discriminator 4)) 
[ 147.321415][ T1] ? ida_check_alloc+0x180/0x180 
[ 147.328122][ T1] do_one_initcall (init/main.c:1236) 
[ 147.329710][ T1] ? trace_event_raw_event_initcall_level (init/main.c:1227) 
[ 147.331457][ T1] ? kasan_set_track (mm/kasan/common.c:52) 
[ 147.332761][ T1] ? __kasan_kmalloc (mm/kasan/common.c:374 mm/kasan/common.c:383) 
[ 147.334110][ T1] do_initcalls (init/main.c:1297 init/main.c:1314) 
[ 147.335391][ T1] kernel_init_freeable (init/main.c:1553) 
[ 147.336847][ T1] ? rest_init (init/main.c:1433) 
[ 147.338185][ T1] kernel_init (init/main.c:1443) 
[ 147.339643][ T1] ? _raw_spin_unlock_irq (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:77 include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:202) 
[ 147.341086][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 147.342257][ T1] ? rest_init (init/main.c:1433) 
[ 147.343489][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
[  147.344899][    T1]  </TASK>
[  147.345857][    T1] irq event stamp: 16601637
[ 147.347086][ T1] hardirqs last enabled at (16601647): console_unlock (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 kernel/printk/printk.c:341 kernel/printk/printk.c:2706 kernel/printk/printk.c:3038) 
[ 147.349820][ T1] hardirqs last disabled at (16601676): console_unlock (kernel/printk/printk.c:339 kernel/printk/printk.c:2706 kernel/printk/printk.c:3038) 
[ 147.352396][ T1] softirqs last enabled at (16601672): __do_softirq (arch/x86/include/asm/preempt.h:27 kernel/softirq.c:400 kernel/softirq.c:582) 
[ 147.354955][ T1] softirqs last disabled at (16601655): irq_exit_rcu (kernel/softirq.c:427 kernel/softirq.c:632 kernel/softirq.c:644) 
[  147.357497][    T1] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231227/202312271025.7f350868-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


