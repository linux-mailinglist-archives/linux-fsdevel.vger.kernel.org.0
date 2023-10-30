Return-Path: <linux-fsdevel+bounces-1530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA0C7DB557
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 09:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41B0B1C2091E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 08:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630986FAF;
	Mon, 30 Oct 2023 08:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eayZRCRw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FE3610C
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 08:42:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09238A9;
	Mon, 30 Oct 2023 01:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698655347; x=1730191347;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=L4erzWZgQGNc8vZFePubZvd1GiM2V1Xo3yqM6FIqC5w=;
  b=eayZRCRwFUgk5ESR4DhVO+F5T5Ygzglnqzex4syTHakwnvK3zm6V0okA
   g0uNl6F7nPZc+4sEa/K+/82KayPIUbaNbhecag2OOWD8CW+1FpI4i1K0s
   H2+e/hnL0abkuZgGA8jv1YLAD9kPjC6cjmUWQcePvebvx8Jyzf5FPQH02
   VYX+OSN5YzTtRcHNMH0V0c3RNPqOIH9oClEfPlTfryUbUZBHQ1rS85sTH
   AB7JxXGL3kwA+tUzTSaSnv6OkJp2rOpA6jH+hOR3NGZPX3R1Bh7sI+8Y6
   c07WFxVgVBXn3w6GYzarXRUR16WOTtNTge/Kzw0NfkNCsJhvR5J0sAP65
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="899540"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="899540"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 01:42:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="763852158"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="763852158"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2023 01:42:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 01:42:25 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 01:42:25 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 01:42:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENW9Wcu+Vo39qDcPSsI1tv5/dFNlvZM3aHf9JABh1k4OO3ZLwwuQozPWJmU0k3nGwUt7stB2fdP983faicfD73W7eQvr3Jq3t6ZDR+XXBt4l/7a0qm7R6mUTHKWWuRAo5EJf1IEjwHrDvthk0/yNWxhFo1o2dacjyfb6S+6/B20aNV2kvpeQAqhamMBbY/qEKJddIqllucimbIGQjOVOpH5GpP2WYILB/nFwjd7Nb2BXSZtSDLLXDlNfrvysjWtLDq1X2aftlYR28Bsjw08htPxhiIWDvjetw9ZlOoG35KwUyNPOcpFKHZuYQMQ7LrC1TBGHC5I2aTWPlPBGP/YPsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trgH19hs7T31P1LslWGs3YMgKFNxxkkbyBmITEQOWfk=;
 b=atSeVzkQ3lmQG7YpJ94Hp7FFK/RDuI1wAfOv64M1EWc9xRpzamt7MA91cmbHx8XFaxnCFQTBjuGgHFpdiHCkR0oIQi0DGWp3woUCF1QWwPSpdV5Ng6cHHzvGqhIL+Qq/oK82Dyp549lgCbEOotOwrWuNxoyonYfphxd2AJcRII/lcAAff1gdoMorizVrB6ugAsRu4D3582jOjsnJoSz9X3hMUBEmLqJQQKBUQ8Uy8vaCUc0MxAYX+zl0fc0bAVCzWVigKFz4ldorh92VBN7l1ogAnzdbOdDcnTFQevncENLnAEM6zd95zfvBmIN6tt5bLN13dPmFUoFGsq/44MEd1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by MW3PR11MB4620.namprd11.prod.outlook.com (2603:10b6:303:54::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Mon, 30 Oct
 2023 08:42:22 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6%3]) with mapi id 15.20.6933.026; Mon, 30 Oct 2023
 08:42:21 +0000
Date: Mon, 30 Oct 2023 16:42:15 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [viro-vfs:work.csum-x86] [x86]  dc7d50c79a:
 BUG:unable_to_handle_page_fault_for_address
Message-ID: <202310301608.f6551e69-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: TYCPR01CA0210.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::9) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|MW3PR11MB4620:EE_
X-MS-Office365-Filtering-Correlation-Id: ef1539d2-0e81-404d-ac05-08dbd92421ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E2E1AkI+XdoyUUdAY5j30aaHCOrKuWqZuJxr4hIGqI3MCJNKzWTB5+IdUZZF+TY5RJUFZoORCn5677Dh+q981DQQrZEIxv9+jb0SjctZdAkaB6gB65rilsO/Z+qM/xaNjIXyvNvlRd+05ZUvc9lvphNob5m8LvwKCWecRcRpcKBf8O7/SJRYwMUuur0yY/1fU9A176wPdZmhw9ZI73GSRTuhwDGs6esZkQATPlCBxlhnP7VZ+zQcV3xFFP+1lQ5ggDdMmhhL1pPTMoaDWgHOXVWKb5cZENaaEYpAnt7j/D0+q4yFuJlK151WrsiSyCxPTWqGRClgdvTftAKXgXZ6g/xVP5xRIz/xs5LltALK6fhihkT2EFO7u+Ojw5Wfv1+T7irBwOX9T7YDL4C+YRAhndrQxD458CBi+mtk1Z6Htif+TJh9LwR2tlF6E1iwwjDsfRdkqPHTqzjEBxfU6p9r/dXJ5MuTisuOcMoyFWb0iiVjO5CoS10tbN080hJ9bEluHqcp/PHFPwARFSccZgdoZeKS270Ru/bsQrbZLZ83TDCGtQuY5Re+MueXKFiww+v6/f8GJyJR40bM2bePgEX4kw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(86362001)(36756003)(82960400001)(107886003)(2906002)(966005)(6486002)(6512007)(478600001)(41300700001)(45080400002)(8936002)(8676002)(4326008)(6666004)(6506007)(83380400001)(26005)(66556008)(1076003)(2616005)(5660300002)(6916009)(316002)(66946007)(66476007)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vTYGfXia5T2gALNAi5d4tY/DvV2hxoMmTojgWmT2igBv9DJGgb0abtPKd+N5?=
 =?us-ascii?Q?2Bn9vMjIKiAahYUUmwEw4NrKVzqYybrLTenrspD4NtHywzmYxg+fqxwvdeTk?=
 =?us-ascii?Q?mmqYESNG7Hh4RfGSfNBPE+EYvRPJveYTo1tI5f3HTXoDshCx0Byr20+MuQe0?=
 =?us-ascii?Q?fYpje1RLu2uyNGu6FKdD2cXGEoVGLZYC3KQTrgt3fV56FZfCm6fP8RfnHUMV?=
 =?us-ascii?Q?/QL+j7n8iJoxMrTiX8pUkcpqlZ2KDM1DtdHshtqgO4W0pUNCDTsdAJNPADa8?=
 =?us-ascii?Q?XB88It/1Cn6Y/WwaxJJxNPkDBtP9uCXjkHAmgDWde8Tc7UWDTEd8kDIr96RD?=
 =?us-ascii?Q?ZljyJ6TjsSTKXdUJPW/ExnSWwWzXiim6A9nPqeIUfQa7xEMJz9MlAy24DH7n?=
 =?us-ascii?Q?f36OyEuDj4LRP6oNACiXJVQEgmsaGQWWMFqhW3qiyunv7rgH+umoCRH+T9bm?=
 =?us-ascii?Q?9wKJMvm3XxQVOQUwewdLwYQLRYghkaANv3GJrPlJbsFCG+QszNlAKvgDIijH?=
 =?us-ascii?Q?ktyzbHXu8GEK0nOiMmoVDNfwoz3AI8t+9B4TNLTvqoWvTyGTzgevzkUA3Vr7?=
 =?us-ascii?Q?TXQ5lUe4VgtBsSPFsf06TOr6ie8zDTcGsq549m4acwrt2dbv6wVAORoxmQ+K?=
 =?us-ascii?Q?oQ5g6hFfpYXc12H0Qlg4Vcmnoo0X3YeXC+NvAdP9Pt0NwC5DHwzwZfaX7dIC?=
 =?us-ascii?Q?E1BjCc2E2RWRivDqxlDCUwVs3hw5ZVF/jOT3H/d7rlhg0eOzXlRfYsKpBDON?=
 =?us-ascii?Q?9qg5fUEkkCQ8otYOQF9z5XaLY87slLntqqNVoB09HMQyx6obw2VIuJxVLici?=
 =?us-ascii?Q?6Pi/DMhZdv8J8ReMLMaNwKLApRmU1hMWPRS8H5Z2sakI5sjU9NF70pwFZ5AI?=
 =?us-ascii?Q?Xb1XqMIgje3B2/i3gjAiPNQP/VIEbj8D3Qt0j2wYVrVtyQO2ZhOuFEJIFF7C?=
 =?us-ascii?Q?lpOTE4pz87xcaIBHQLtHcLOU2vXeO9SYWgmqmmcJILPwASRhX0htGVmFudF7?=
 =?us-ascii?Q?PodvqLyWGdGANOFtTjKusBal3JzTMiFQjZFJmrDxxMULjgZfp6ZTbcZbKZeV?=
 =?us-ascii?Q?kR+lXmmqEWmeX4EnFhepMm3hHN07yi1ihGIzaktXBAooHECHwmUxKy2jwVCL?=
 =?us-ascii?Q?BZb4HmdnxmTrXF4yjAoHlI6aJ87TOBO4UkAJ/wu1w5350HynH6UF4Ml4V7ny?=
 =?us-ascii?Q?AKwNrkE/5r45IZUymKQf3v/JcvIZonEFtp6+5Qf3RFHQqv/HIRFylzLQCaPh?=
 =?us-ascii?Q?M141AQmKWIuvvuSH7yb/B8Ow5bAcURDpI4i3PPU5IuhnqUermli3eWrMBUQw?=
 =?us-ascii?Q?+gen2DNIOFAEusz07+6OLT1Jr7yjyTbMl/ljbJQXZ9wPi9SJCc8W5WKq5Xt+?=
 =?us-ascii?Q?nVuKJe0qXSG3FVv9N9ICQzBWGlnKFloov1SRbkP6jlOqaiBAlqz/l42tkkfV?=
 =?us-ascii?Q?X7IVARnpO3ZvMW8e+nmwomZiSGQhcCGjDt5hDgd3Scpk4bAS+b4jB+xTZJOE?=
 =?us-ascii?Q?+DqUvbm0zkQhZ6DiOVZIVegi4Z2mF2bXU0PNxgPnGzZjKHLgmzMZ4su6/d11?=
 =?us-ascii?Q?OoCjn1OT3E7ap+CNd7hcyxk8+yY7AO7+hG2JNLO7iWmH086zfXJIodC4u7p2?=
 =?us-ascii?Q?XA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1539d2-0e81-404d-ac05-08dbd92421ba
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 08:42:21.2928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KBEhL4HvRzq0Ovww+ARRL5wRcRePTAz2VGjxvhE7XuKUEyxWtFOf2heC9mo8Sa28xq6dcyL7zb/sjb8q+v6bug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4620
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:unable_to_handle_page_fault_for_address" on:

commit: dc7d50c79a0bb5d28cd63b024c2e840199f96287 ("x86: lift the extern for csum_partial() into checksum.h")
https://git.kernel.org/cgit/linux/kernel/git/viro/vfs.git work.csum-x86

in testcase: boot

compiler: gcc-11
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-------------------------------------------------------------------------+------------+------------+
|                                                                         | bc6c76fc10 | dc7d50c79a |
+-------------------------------------------------------------------------+------------+------------+
| BUG:unable_to_handle_page_fault_for_address                             | 0          | 9          |
| Oops:#[##]                                                              | 0          | 9          |
| EIP:csum_partial                                                        | 0          | 9          |
| Kernel_panic-not_syncing:Fatal_exception_in_interrupt                   | 0          | 9          |
+-------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202310301608.f6551e69-oliver.sang@intel.com


[  293.263231][    C1] BUG: unable to handle page fault for address: ee3fe000
[  293.264348][    C1] #PF: supervisor read access in kernel mode
[  293.264930][    C1] #PF: error_code(0x0000) - not-present page
[  293.265511][    C1] *pde = 05df2067 *pte = 00000000
[  293.266034][    C1] Oops: 0000 [#1] SMP
[  293.266491][    C1] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G                 N 6.6.0-rc5-00018-gdc7d50c79a0b #1
[  293.267493][    C1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 293.268498][ C1] EIP: csum_partial (arch/x86/lib/checksum_32.S:200) 
[ 293.269040][ C1] Code: d0 00 e9 92 00 00 00 66 03 06 83 d0 00 e9 87 00 00 00 03 46 80 13 46 84 13 46 88 13 46 8c 13 46 90 13 46 94 13 46 98 13 46 9c <13> 46 a0 13 46 a4 13 46 a8 13 46 ac 13 46 b0 13 46 b4 13 46 b8 13
All code
========
   0:	d0 00                	rolb   (%rax)
   2:	e9 92 00 00 00       	jmp    0x99
   7:	66 03 06             	add    (%rsi),%ax
   a:	83 d0 00             	adc    $0x0,%eax
   d:	e9 87 00 00 00       	jmp    0x99
  12:	03 46 80             	add    -0x80(%rsi),%eax
  15:	13 46 84             	adc    -0x7c(%rsi),%eax
  18:	13 46 88             	adc    -0x78(%rsi),%eax
  1b:	13 46 8c             	adc    -0x74(%rsi),%eax
  1e:	13 46 90             	adc    -0x70(%rsi),%eax
  21:	13 46 94             	adc    -0x6c(%rsi),%eax
  24:	13 46 98             	adc    -0x68(%rsi),%eax
  27:	13 46 9c             	adc    -0x64(%rsi),%eax
  2a:*	13 46 a0             	adc    -0x60(%rsi),%eax		<-- trapping instruction
  2d:	13 46 a4             	adc    -0x5c(%rsi),%eax
  30:	13 46 a8             	adc    -0x58(%rsi),%eax
  33:	13 46 ac             	adc    -0x54(%rsi),%eax
  36:	13 46 b0             	adc    -0x50(%rsi),%eax
  39:	13 46 b4             	adc    -0x4c(%rsi),%eax
  3c:	13 46 b8             	adc    -0x48(%rsi),%eax
  3f:	13                   	.byte 0x13

Code starting with the faulting instruction
===========================================
   0:	13 46 a0             	adc    -0x60(%rsi),%eax
   3:	13 46 a4             	adc    -0x5c(%rsi),%eax
   6:	13 46 a8             	adc    -0x58(%rsi),%eax
   9:	13 46 ac             	adc    -0x54(%rsi),%eax
   c:	13 46 b0             	adc    -0x50(%rsi),%eax
   f:	13 46 b4             	adc    -0x4c(%rsi),%eax
  12:	13 46 b8             	adc    -0x48(%rsi),%eax
  15:	13                   	.byte 0x13
[  293.270832][    C1] EAX: 719f338b EBX: c30cc3da ECX: 0135749f EDX: c2c051b5
[  293.272687][    C1] ESI: ee3fe060 EDI: c639de3c EBP: c639ddf0 ESP: c639dde4
[  293.273417][    C1] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010a17
[  293.274185][    C1] CR0: 80050033 CR2: ee3fe000 CR3: 0540b000 CR4: 000406d0
[  293.274876][    C1] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  293.275549][    C1] DR6: fffe0ff0 DR7: 00000400
[  293.276033][    C1] Call Trace:
[  293.276402][    C1]  <SOFTIRQ>
[ 293.276744][ C1] ? show_regs (arch/x86/kernel/dumpstack.c:478) 
[ 293.277226][ C1] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434) 
[ 293.277670][ C1] ? page_fault_oops (arch/x86/mm/fault.c:707) 
[ 293.278135][ C1] ? kernelmode_fixup_or_oops+0x7c/0xcc 
[ 293.278755][ C1] ? __bad_area_nosemaphore+0x114/0x1ec 
[ 293.279378][ C1] ? bad_area_nosemaphore (arch/x86/mm/fault.c:867) 
[ 293.279904][ C1] ? do_kern_addr_fault (arch/x86/mm/fault.c:1227) 
[ 293.280390][ C1] ? exc_page_fault (arch/x86/mm/fault.c:1503 arch/x86/mm/fault.c:1561) 
[ 293.280899][ C1] ? csum_partial (arch/x86/lib/checksum_32.S:211) 
[ 293.281373][ C1] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1518) 
[ 293.281978][ C1] ? handle_exception (arch/x86/entry/entry_32.S:1056) 
[ 293.282534][ C1] ? csum_partial (arch/x86/lib/checksum_32.S:211) 
[ 293.282997][ C1] ? __skb_checksum (net/core/skbuff.c:3283) 
[ 293.283528][ C1] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1518) 
[ 293.284136][ C1] ? csum_partial (arch/x86/lib/checksum_32.S:200) 
[ 293.284593][ C1] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1518) 
[ 293.285170][ C1] ? csum_partial (arch/x86/lib/checksum_32.S:200) 
[ 293.285821][ C1] ? csum_partial_ext (include/net/checksum.h:187) 
[ 293.286518][ C1] __skb_checksum (net/core/skbuff.c:3283) 
[ 293.287229][ C1] ? __lock_acquire (kernel/locking/lockdep.c:5136) 
[ 293.288065][ C1] skb_checksum (net/core/skbuff.c:3362) 
[ 293.288738][ C1] ? csum_block_add_ext (include/net/checksum.h:185) 
[ 293.289326][ C1] ? reqsk_fastopen_remove (net/core/skbuff.c:168) 
[ 293.289857][ C1] __skb_gro_checksum_complete (net/core/gro.c:751) 
[ 293.290503][ C1] udp4_gro_receive (net/ipv4/udp_offload.c:635) 
[ 293.291078][ C1] inet_gro_receive (net/ipv4/af_inet.c:1571 (discriminator 2)) 
[ 293.291607][ C1] dev_gro_receive (net/core/gro.c:490) 
[ 293.292107][ C1] napi_gro_receive (net/core/gro.c:609) 
[ 293.292803][ C1] e1000_clean_rx_irq (drivers/net/ethernet/intel/e1000/e1000_main.c:4464) 
[ 293.293668][ C1] e1000_clean (drivers/net/ethernet/intel/e1000/e1000_main.c:3805) 
[ 293.294320][ C1] __napi_poll+0x20/0x1ec 
[ 293.295127][ C1] net_rx_action (net/core/dev.c:6596 net/core/dev.c:6727) 
[ 293.295860][ C1] __do_softirq (include/linux/jump_label.h:207 include/linux/jump_label.h:207 include/trace/events/irq.h:142 kernel/softirq.c:554) 
[ 293.296541][ C1] ? __dev_queue_xmit (include/linux/rcupdate.h:308 include/linux/rcupdate.h:817 net/core/dev.c:4367) 
[ 293.297376][ C1] ? __lock_text_end (kernel/softirq.c:511) 
[ 293.298120][ C1] do_softirq_own_stack (arch/x86/kernel/irq_32.c:57 arch/x86/kernel/irq_32.c:147) 
[  293.298950][    C1]  </SOFTIRQ>
[ 293.299512][ C1] do_softirq (kernel/softirq.c:456) 
[ 293.300247][ C1] __local_bh_enable_ip (kernel/softirq.c:381) 
[ 293.301016][ C1] __dev_queue_xmit (net/core/dev.c:4368) 
[ 293.301784][ C1] ? __alloc_skb (net/core/skbuff.c:651) 
[ 293.302546][ C1] ? eth_header (net/ethernet/eth.c:85) 
[ 293.303308][ C1] ? eth_header_cache_update (net/ethernet/eth.c:82) 
[ 293.304226][ C1] ? eth_header_cache_update (net/ethernet/eth.c:82) 
[ 293.305042][ C1] ic_bootp_send_if (net/ipv4/ipconfig.c:894) 
[ 293.305941][ C1] ic_dynamic (net/ipv4/ipconfig.c:1264) 
[ 293.306633][ C1] ip_auto_config (net/ipv4/ipconfig.c:1535) 
[ 293.307440][ C1] ? __lock_release (kernel/locking/lockdep.c:5429) 
[ 293.308260][ C1] ? add_device_randomness (drivers/char/random.c:926) 
[ 293.309104][ C1] ? add_device_randomness (drivers/char/random.c:926) 
[ 293.309918][ C1] ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:63) 
[ 293.310745][ C1] ? add_device_randomness (drivers/char/random.c:926) 
[ 293.311576][ C1] ? root_nfs_parse_addr (net/ipv4/ipconfig.c:1477) 
[ 293.312380][ C1] do_one_initcall (init/main.c:1232) 
[ 293.313158][ C1] ? rdinit_setup (init/main.c:1280) 
[ 293.313908][ C1] ? rdinit_setup (init/main.c:1280) 
[ 293.314628][ C1] do_initcalls (init/main.c:1293 init/main.c:1310) 
[ 293.315344][ C1] ? rest_init (init/main.c:1429) 
[ 293.316127][ C1] kernel_init_freeable (init/main.c:1549) 
[ 293.316899][ C1] kernel_init (init/main.c:1439) 
[ 293.317571][ C1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 293.318275][ C1] ? rest_init (init/main.c:1429) 
[ 293.318975][ C1] ret_from_fork_asm (arch/x86/entry/entry_32.S:741) 
[ 293.319729][ C1] entry_INT80_32 (arch/x86/entry/entry_32.S:947) 
[  293.320957][    C1] Modules linked in:
[  293.321646][    C1] CR2: 00000000ee3fe000
[  293.322326][    C1] ---[ end trace 0000000000000000 ]---
[ 293.323304][ C1] EIP: csum_partial (arch/x86/lib/checksum_32.S:200) 
[ 293.324048][ C1] Code: d0 00 e9 92 00 00 00 66 03 06 83 d0 00 e9 87 00 00 00 03 46 80 13 46 84 13 46 88 13 46 8c 13 46 90 13 46 94 13 46 98 13 46 9c <13> 46 a0 13 46 a4 13 46 a8 13 46 ac 13 46 b0 13 46 b4 13 46 b8 13
All code
========
   0:	d0 00                	rolb   (%rax)
   2:	e9 92 00 00 00       	jmp    0x99
   7:	66 03 06             	add    (%rsi),%ax
   a:	83 d0 00             	adc    $0x0,%eax
   d:	e9 87 00 00 00       	jmp    0x99
  12:	03 46 80             	add    -0x80(%rsi),%eax
  15:	13 46 84             	adc    -0x7c(%rsi),%eax
  18:	13 46 88             	adc    -0x78(%rsi),%eax
  1b:	13 46 8c             	adc    -0x74(%rsi),%eax
  1e:	13 46 90             	adc    -0x70(%rsi),%eax
  21:	13 46 94             	adc    -0x6c(%rsi),%eax
  24:	13 46 98             	adc    -0x68(%rsi),%eax
  27:	13 46 9c             	adc    -0x64(%rsi),%eax
  2a:*	13 46 a0             	adc    -0x60(%rsi),%eax		<-- trapping instruction
  2d:	13 46 a4             	adc    -0x5c(%rsi),%eax
  30:	13 46 a8             	adc    -0x58(%rsi),%eax
  33:	13 46 ac             	adc    -0x54(%rsi),%eax
  36:	13 46 b0             	adc    -0x50(%rsi),%eax
  39:	13 46 b4             	adc    -0x4c(%rsi),%eax
  3c:	13 46 b8             	adc    -0x48(%rsi),%eax
  3f:	13                   	.byte 0x13

Code starting with the faulting instruction
===========================================
   0:	13 46 a0             	adc    -0x60(%rsi),%eax
   3:	13 46 a4             	adc    -0x5c(%rsi),%eax
   6:	13 46 a8             	adc    -0x58(%rsi),%eax
   9:	13 46 ac             	adc    -0x54(%rsi),%eax
   c:	13 46 b0             	adc    -0x50(%rsi),%eax
   f:	13 46 b4             	adc    -0x4c(%rsi),%eax
  12:	13 46 b8             	adc    -0x48(%rsi),%eax
  15:	13                   	.byte 0x13


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231030/202310301608.f6551e69-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


