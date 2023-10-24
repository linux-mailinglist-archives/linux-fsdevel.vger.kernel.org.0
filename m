Return-Path: <linux-fsdevel+bounces-1093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA69F7D548C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 16:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E17281A1D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 14:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55732C84D;
	Tue, 24 Oct 2023 14:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lxA+ktu1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C500231A61
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 14:58:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED8ACC;
	Tue, 24 Oct 2023 07:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698159514; x=1729695514;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=C6IdOkpwYw0wn6gnNyHdezVBscMASvkkdmL0IsrKTB4=;
  b=lxA+ktu1i7bHsnLoRENmxbe3jf3C4T4B4nPolAFkKBEniXbkGT3TL8Fm
   fBcw3XfRPDNhQmQU8zSXP6KSxDxS6/naJ41WwAPP6ZRuixXl53IsC+c5Q
   QLK4D0cfs3n2t2Wz845tf9UJ/oUY/OSpmv6HaSG/1Ti2qoW1Bc9vYBhJK
   wNBC+srRtpSiUu4QyDvgVj0XHCGdt+dFZHdldOsQ3f9D8ovvHL3hS+8fS
   vlpRMdwGcM1Sf2+mBkYDnshsc6TuJVmjDDhVQ+GCNVjIKQZWKsrqyP7QA
   hGUCSbKjHczwVFvalprYTZwWZ+0yS0gNzHp2jvT7TraeR9ULXkpoDwLaT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="8628355"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="8628355"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 07:58:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="752020214"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="752020214"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2023 07:58:26 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 07:58:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 24 Oct 2023 07:58:25 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 24 Oct 2023 07:58:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wjuk/pW9epPX/FOusgSl61Vvmw84JesLRZd3LwcWwOptsjmdAAnCP6GLaZoZyDXRUlVUCm2t7HSrioob3mEvfYbqywggvyB2in5FRKzWG/7OwwGtI7i7dc26YC3ThQhr6Yb0HlhPoAhj9DtE1/XfnHNANgnIAUOt7q4zokWMQOVLNYqyVMs8dF1gVItB/ZJPsGETIKW18arZFOEtPJo06KY1L4y19oVRaNmgMn9eM4md7YXpOXPO3j0+fSJ4KKx+Szj2+WVGrsB/qLN9ldLxmCUuVnEp9G1bt7bya4Lp4Yr82lrM/x+nHdXtWwv1wQzPnq2/sXoutNoL2Wt1153Yng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8XBX0j0ydhGIkL0qgMDNdsWCbMCEwGqKzO5JaoqHWE=;
 b=oasHWGF65Gf4GOH7Eqbr0jC9LBQ+3vJNQ0++pzuXAn6VcNN9YeKG7X8ryKqW8xPAgUBqHigcImJnSp0kjE1lPd4wuk5yPYjjq8Lkn3tlFGdDg6wdm7UQSw7oZwuaGbAt3lizzkeSpMOKRdt8i85n8Ry5ADKvFCmILrIs9ot3gVqYr2nGwnyYPEirPFTfy0O2Sm2SY5Tis0vjBE1X5OQvSq+2tSZdtmwFajwc8BcNXMRElzVVJDpyV8ioecCrtdOJcVhEU1FWkUdWBDbF6UVDS/IjjX2GmRWh4ZhRZbIiAqeKJFRT67EUxz3kzcgub3C9jkgX/opluaoebizjaE3HQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by DS7PR11MB7691.namprd11.prod.outlook.com (2603:10b6:8:e4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 14:58:18 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6%3]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 14:58:17 +0000
Date: Tue, 24 Oct 2023 22:58:10 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Roberto Sassu <roberto.sassu@huawei.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-integrity@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [robertosassu:ima-evm-lsms-v4-devel-v7] [evm]  ea31d8b249:
 Kernel_panic-not_syncing:security_add_hooks_Too_many_LSMs_registered
Message-ID: <202310242253.12601f42-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0194.apcprd04.prod.outlook.com
 (2603:1096:4:14::32) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|DS7PR11MB7691:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fb0d005-0329-406b-943b-08dbd4a1a7f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z8Y892IxGcOzDujuH7M8MGPlp1/7KsjZj9+TzWscmcW9JRqkK8dVp0KGvtI/b9pq08GBYSJk/3H2gF3oo8y4ZOQx3n2fTJT64q4PedDQAC/443Nw50eoZ257iqPxqzw5kVCg3REZpnTU3EtM6x88LNTFNMXX2S546XFarWhxsk3Bxbs9/BK87wjdICVSda2vR8jlKkkNSxW+ifwA3QWiJ1f0cfrEuwD6YKFpfPxzJSmxXXTr/6Tg1hPKxPSJirOIPTQMCb+67VaYkiy33QKRhKNfCFhea4OXzPchc1u+j2zfK9Iag6JzHXKgxO9olBIqfxRuiAKa7uwPRvn8+AJc6RDBofBt3dlrxk5iz0IWOnuK7xdD7sk7l4W8Z9Yo9/UNYPgdHh9IyB2b33kComnfWevKeBJn7e887CPNSEQ52siNquIxT/h8k+ROM/qN63GPS04w7xJsIHYhaL91Rfb1zOeJb2mzwrSiBt5G2e8StmwWqwM7buVrWNGcdWa8GdmeMsg5oRQFa8GFA/7SGYFJYG/YkFBxAd8RoClo2Fw6wsZFc9FN0RCa+SoL0/IZCGf1rbIC/zXYTkXzTIjEp9I4qQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(346002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(2906002)(4326008)(8676002)(8936002)(5660300002)(41300700001)(6506007)(6666004)(83380400001)(6512007)(38100700002)(86362001)(15650500001)(82960400001)(66946007)(107886003)(66556008)(66476007)(6916009)(316002)(966005)(6486002)(2616005)(26005)(1076003)(478600001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D3x47SiEMm1AhHLrMXWKPXLklSD6+Ucor8mfmh+Kq19GI7Z09SJSvO/Yhq9c?=
 =?us-ascii?Q?Y9bEsui4PD1hK8IN2+MNpHG2iuFj4ceG4qb9uDa2dJkfCyqtb5TOfd2NSmQK?=
 =?us-ascii?Q?zGXm3IiV5AgaDEsaTGOIoteLbmDoapaQSC/e8KB5VN1KyA0aOx41ZVgXJ1Fy?=
 =?us-ascii?Q?NekXeJCaD6XapxNBT/OgY8OcD0Hp0ifW7n2x1toLbJ3G8bHNbFFEfcIw5bIe?=
 =?us-ascii?Q?duKRQMFeKBGFLWHde0tBQXSvQ8dBliqsro0vprX6Xvkw6A12ONyNnBhZ3YXM?=
 =?us-ascii?Q?xh6Rk1pGWYDlor8ARA7Sft9GnVmsKb8sOj9FZDE0wQUQi21nPzczLges4wF4?=
 =?us-ascii?Q?X8PdLgU4i0/w5fa7OK4KWZkNdcKolUmtsHavSdFb2HtHKMTMduitC//xjr2G?=
 =?us-ascii?Q?wL/Tp0gtPhdZCtrK9zsdTjABE/tjUPLccvr0zHqbYYAHGkN5bWlsi6yDlgGm?=
 =?us-ascii?Q?yoAayFY3MJ6/GP4BKGQXGH4i9UzM498AOKn29dv+m4/XzE+/OqkWHEqwvckI?=
 =?us-ascii?Q?gYIPcIL1NrpqBRMWX9HBW8a0pz+V9IMudtnRUFMbASXrJYJDbw59O1AuZS4H?=
 =?us-ascii?Q?Vqm56KeplXNJxyQ+Ouij5La2NLBjHVpssZtU9lWvNmSjS/+BUhSx214z56ah?=
 =?us-ascii?Q?NpTFGO8hyhVqTyVHS+TvZkCOTjH45MGgxhIgqIxWMRFvhtrg3kV6xocfBhr1?=
 =?us-ascii?Q?7HP02bLrDiL7lbIikbI5sg7kS2QMuNwykN9Vr2HqdjiAKypfTpzi2QkUZyb1?=
 =?us-ascii?Q?YrXkmhM0x+wLbVgdcR5k8/Q4pM9X8+1zVLSWVTgFM/y7v+uRlHeMB9dYhW/K?=
 =?us-ascii?Q?Vvkos7AAjosrQewZhRmPz8tAKYPkSnjmpAfurM2JxWd2Xn1ztnEZ75cOMw+/?=
 =?us-ascii?Q?YvJ29ePDWp1gP+cSu/vOrZkk4Zkw+ughjjzo7HUniQ/teE5RULD6gtni6xWG?=
 =?us-ascii?Q?X3sI+mCL/Q9dS10bfir18t1uT3MH2O1U+y2tj4cScWf+J2KIVbrLXqPOaUq7?=
 =?us-ascii?Q?j7w9YTeomjHWtJozZzTpGFCTOd1mvv2lr5w6yaEVnmBmXj7mg+hYaiuS4Wzf?=
 =?us-ascii?Q?SPw37BWDTaBSESX3IoliTxMq48hiK2hnlWHLGhvUpj2leAsyENSnGdidfg6i?=
 =?us-ascii?Q?WAPo2wS0CXA2JNfODOcia74wCuEtqq3R3ml0RL/Z0QG5NXzB/EwvhFL/AQE0?=
 =?us-ascii?Q?Ak7lo4uhNggnfOLi4NoPcfKkKBMGcANHW3tbywLRNpk0fZNiBOeU+ZpJPJDH?=
 =?us-ascii?Q?ZkJFHgwbOR/dljkJLAI1WQTlS9tEydQ+32g7K5oA8hHJ3dX8kiMk6+XHEWKz?=
 =?us-ascii?Q?2j1JgYT7HTUOQ+EjZNbSmNLHIm0OvpVssSR7uj39IhnsxS8rp32pLy40BMpZ?=
 =?us-ascii?Q?WsdOnn2ugKkkT4Q9V2kneK8/vXYe/Lme7plFPRcWq1xFtahPpPNsNdCXC6PE?=
 =?us-ascii?Q?tR+ax3H2ftdGkCzblUbh6hpnt9B2Lu5WgEzP0F1Ou1BFolAsnA0L0oLHXqPF?=
 =?us-ascii?Q?QlDPcwIqlunOYGDs/v4Dqp32U9QkSuxUduwVIQIo8XjI2wPk2Vz3xgb+YBjz?=
 =?us-ascii?Q?3DkOTjxm1GRNiHrM8spNxQkXj3q+kg1HouZTFCfRcJPHVbNFFfyDeUvf016T?=
 =?us-ascii?Q?sQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb0d005-0329-406b-943b-08dbd4a1a7f6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 14:58:17.7654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hID5v3OuXGZB68VFSABI6NLa2ksyjAW5ZgA6g7H0rno7Mv/Pil+Jq/kB1ctVBpzpC4teh+f7+V7U9XdP/CORRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7691
X-OriginatorOrg: intel.com



Message-ID: <202310242253.12601f42-oliver.sang@intel.com>
TO: Roberto Sassu <roberto.sassu@huawei.com>
CC: oe-lkp@lists.linux.dev, lkp@intel.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org
BCC: 



Hello,

kernel test robot noticed "Kernel_panic-not_syncing:security_add_hooks_Too_many_LSMs_registered" on:

commit: ea31d8b2497ad757c81550037fe49a28e8fe5887 ("evm: Move to LSM infrastructure")
https://github.com/robertosassu/linux ima-evm-lsms-v4-devel-v7

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+----------------------------------------------------------------------+------------+------------+
|                                                                      | df77cb3dab | ea31d8b249 |
+----------------------------------------------------------------------+------------+------------+
| Kernel_panic-not_syncing:security_add_hooks_Too_many_LSMs_registered | 0          | 6          |
+----------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202310242253.12601f42-oliver.sang@intel.com


[    9.120367][    T0] x86/fpu: x87 FPU will use FXSAVE
[    9.133888][    T0] Freeing SMP alternatives memory: 32K
[    9.136370][    T0] pid_max: default: 32768 minimum: 301
[    9.144589][    T0] LSM: initializing lsm=capability,landlock,safesetid,integrity,ima,evm
[    9.148867][    T0] landlock: Up and running.
[    9.152625][    T0] Kernel panic - not syncing: security_add_hooks Too many LSMs registered.
[    9.156308][    T0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.6.0-rc3-00044-gea31d8b2497a #1 0abe8f00443bfd0d07e7cec4aee08e82c1b9667d
[    9.156308][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    9.156308][    T0] Call Trace:
[ 9.156308][ T0] dump_stack_lvl (kbuild/src/consumer/lib/dump_stack.c:107) 
[ 9.156308][ T0] dump_stack (kbuild/src/consumer/lib/dump_stack.c:114) 
[ 9.156308][ T0] panic (kbuild/src/consumer/kernel/panic.c:340) 
[ 9.156308][ T0] security_add_hooks (kbuild/src/consumer/security/security.c:559) 
[ 9.156308][ T0] init_evm_lsm (kbuild/src/consumer/security/integrity/evm/evm_main.c:1046) 


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231024/202310242253.12601f42-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


