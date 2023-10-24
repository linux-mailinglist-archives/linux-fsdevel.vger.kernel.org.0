Return-Path: <linux-fsdevel+bounces-1001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D667D4ACE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 10:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 296B11C20BD2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 08:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA22171B5;
	Tue, 24 Oct 2023 08:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ai5TqzV5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAD3134BD
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 08:48:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B498E99
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 01:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698137313; x=1729673313;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=L8TI/iUXl3tePX2XjOj/2usdk56ycetCkmROpiM20NI=;
  b=Ai5TqzV5n4qoTW16g+WiDO9k8Tx6GZ8VT6UQaQe7EMEObCgtlXUnfRcn
   e/Uvu4VoRl8AUnmL9haqGzgiP5wJObZC0wwnVON4bJV3u1t8O/+GQ7hWF
   IatLmHw9sGxJ6VapTkj6XV0mqaugjs/8k8MouN+q8QVCrqbMGHehS/kJV
   jMasnSBm6tQ2+Gy1elK1INKcHpucm+u5gXdK5RIb8PFc26af520DCMaKn
   fuJFKAwv4/3GqEjN3MyQjXIcqAsPIiylZH9kHXcJJJofdqvgPEQIEsQML
   Lrw3ga1VS/uiNTt1otVnTzKwdjKdnK5lyGyozFP3VAcgVEUqKitdjQrMW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="367242727"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="367242727"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 01:48:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="882043773"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="882043773"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2023 01:48:33 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 01:48:32 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 24 Oct 2023 01:48:32 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 24 Oct 2023 01:48:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwPcMS6EqwxNi/oKo/3SxBR1TcI18AMB8w2SAAULiYt28MeT8RV2yjRVJ0XSRAA+5Ve3AxNlMM362WBlJInE1lKLrO7DFyFqZiwKmmBlR8rBV59cEfDAd+znREJG95RMFewpXoPXyHA4I1F/5/dc7oYozzmiUJPnt8yNbr+qiH9qLmriYq146udFrhi2I0xjSldLfp0PLGshjGFPdEDdFZPLM2xtAKk8Jyk7jEW+3kd866rSnLUKdauDkjhydUoqo/W2SyzC/HxkeOvDnGy8QaKvj2OG5UmoI7Q3AkZWnwSB6zCbKlIygHufQSv99RfreLk8iRjYk+ukHYxm1xABjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1c4C8ICiIApzTCve02pFG0DPJ0HRIV321yMAL8C9tuQ=;
 b=IlAj45qWBzQTvvWzceWHGBiICbmGaDEUAOPeLvMT67qcUbDLLaxMwIB51P5BpNvGOlBtBUD8xWfCpvA7bGNlcRkamjow2FJhr3LXo82Jk8wIbYnp+8TPXDEsAVKyuguG5bL/vuPlwyo0dvFLjMfvGKmED9q0vLPB9MtLfzJJjojDSy0aBlLseRxtKPishvzO74u4k4bFIG4gJxwBmofPJm2TCuy4O8hlGbBOKWf0Yz/19eTugQDxIjxIPXsE/wVNlKMvnG1ONxb0E/gj4NEEcSjDcxTpUE+CBNYwsgMmNfkND6+X4KDYNsQmaYLiC/XJquHrh/972GldShRdLFXpcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by BN9PR11MB5515.namprd11.prod.outlook.com (2603:10b6:408:104::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 08:48:30 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6%3]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 08:48:30 +0000
Date: Tue, 24 Oct 2023 16:48:23 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Jeff Layton <jlayton@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [jlayton:kdevops] [fs]  c8e00140fa:
 BUG:unable_to_handle_page_fault_for_address
Message-ID: <202310241644.67f17b98-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG3P274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::30)
 To PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|BN9PR11MB5515:EE_
X-MS-Office365-Filtering-Correlation-Id: ecd8abb0-a07d-4455-2b6d-08dbd46dfef3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7DVbMBMvC8VV9gBMjGuXH7SSPYpxWABCF4dYrHxkpMun778M5OVwDitJiyp6B3z/GhBhkRsjFbFDTBiH4HHgq0VIhVr3x6WZXNxkv2IPJMfejDmyDvmYLjh3+U6L18iH052LDj1v87YwF2zd5vLUaWlxJue/MYZvby3M84dcc5XirMyAW8/Q3zuPe2s10fyYO/dFwPbSNEsJqlmpXjUEsujxlh1KiWjMYVnu0w2rhBPgRFD+mTLrgByeE/Cmh4RB6+XO07j+35P2nUw4gfGnRFSF1DhhAUOMPywSAyVymOpwa6ypgNHesCx5J5TODs8z08CVyNC/YvjFz4QdCJuwJOhbuzirV61zlSi9SKfRK2xv1XS187iuALJPASrQOQVbTytIsCxVEwFxZsBk7o2WsYUyhpbWRVdgT6BIwTCzY0RdvSK4bm1eteAUA61yTI4OeYUqr8IdhV+7eSAUGfToKZ7uNAyMzGnU32aUgQl2rCb7rN1XnFYzYHR4k2jrTmWIqhn7UFpUoZopPk2/7jl7/MioYJzDdt0t0Iof+QUZdgXzF1P3+YDPhXhTxj+8GT9zHW27W3n448TOsPOMFsQFGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(26005)(478600001)(1076003)(6512007)(6666004)(86362001)(6506007)(316002)(6916009)(38100700002)(66946007)(66556008)(66476007)(36756003)(2616005)(966005)(6486002)(107886003)(2906002)(83380400001)(8936002)(8676002)(4326008)(82960400001)(5660300002)(41300700001)(45080400002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WpYtUfN++zRmlP62uMyJo4lvmY0sfqHbTsaS//Ya2aixalo/JpaV2/byI/mY?=
 =?us-ascii?Q?TzfOMyshhTv2xrADWr8rizP+Ee9Zq4RPe/h8sUwvqOE0jN7n+G2KLTjX+FXH?=
 =?us-ascii?Q?TgBemXPOTsi5u/GMVdp2iRQ3FIMIGVdq0Tz9jJhGLTQP7JU6VuPuOV2x5tEh?=
 =?us-ascii?Q?+SpaCaj6D3nZYRzexfJ0l6Kys4AZnZ0T4IhUfErgZ1CXzLj1fMr0qpdNZxDy?=
 =?us-ascii?Q?NcWt9qto2eHHAUkFQHGnSG2iNxGGKza1BhQvm0/GZ4HDNcbGB8J7fBciUcVn?=
 =?us-ascii?Q?XbidbbEGocI5PEKRj3vbDVifxWLiCdeLue9LH7+7R7NvsS1hDkvTojcVJIWQ?=
 =?us-ascii?Q?SmyIRMTFTy1eRer0Yg9BlsVXeiBaMH6S0dxcaGzIS+qVHUB9UvJP2C8/8sKy?=
 =?us-ascii?Q?/aB/c6E5GphTQwT761VXxZRUiwR+YmLFSujH38ZDDNXZaOpt7nYm0UyATrEh?=
 =?us-ascii?Q?IEA1u7fL6n6BrIqCz+mS3sFG6rthY/01qTVNZWPkr8dwV8pf2Pl3bx7sGLrN?=
 =?us-ascii?Q?R/Al4fHAb4Le8b7mHeK2Wjk3r9e92w8RvGGBzHMvTxSfIxWiY5Ij252GPuvl?=
 =?us-ascii?Q?uipV6NBvUMBEY7euy0dB8PnPWL0stPk5+pyxZxSf+oDQq6U6qGct6/rxmLAw?=
 =?us-ascii?Q?Sdq444IyZs6vyVqjB3VG15f0eVy7iUK8A3zSG8H9oVJJpDL4Xk8zrMYu68mN?=
 =?us-ascii?Q?BnqY91s4/Qd41Y4JXyM68PoxGLKTxF3ouDDUG4xbUTLbCyCQTEvxk5v31srZ?=
 =?us-ascii?Q?ziwqHoetf9ju+pB363Tgbi56nqCu2PQ+jcukm1H8yUFkJNnyYjeV9rhNRWWj?=
 =?us-ascii?Q?1qUvslVS1ywYWgfKLeIDjyg18ImNAXMd42UGcZuanZEJoVECeXnJ+eF7JWeT?=
 =?us-ascii?Q?yPRHEiQ4nXC0XH0iGxagKpQ7CDLR3ZZ6LLne9FGYyQOZxwY56UftoEbcK50C?=
 =?us-ascii?Q?0GCwXodSvPv18FjmXtdHKajJr2KwNssRa9z03kTpyevsR38Y3KH/rh3nb4dl?=
 =?us-ascii?Q?jLfLX9HsXB3FZbg1EJw4Nv3WtYO+mV+Uesisw04p6tFFYFAC0u8gs/yvFpRH?=
 =?us-ascii?Q?fD5DMGCQSfpmkzJADlD7v+mgktqm0dLVnc6nFvIoQj1+DIOfGCSkqPaX1ODZ?=
 =?us-ascii?Q?AUiUAEXaPkv9OYUE2+cwpRe0UzKdNGLmYRWtuCGJ1ReQN8d0XsN32C1weGoI?=
 =?us-ascii?Q?zdxxw9Szjq/9eYAzJlAqiFxZRMp5oPtkoUrRL/X80Nbdli4/X0YOVDawNNZ4?=
 =?us-ascii?Q?mzIrSWcTWt+nkGmBxjhG2QwHvHwTs+L3Bc4Dy8fKObiZoN+9GZK9T0XdS3jp?=
 =?us-ascii?Q?u6bUT0YfKbIIMzLEwOc2M9JHm65qmO1E+llzLuSct14Bzd3k1VGVLvn26r5I?=
 =?us-ascii?Q?c2ZXJsir35YbzF4bG35UCGZxgfaDXtpvCYYFFBu7DwGlCtqdyNldrqlOszz3?=
 =?us-ascii?Q?/XMyXSHvUUR8KSYjV4BJIbO1YYxDDt6eg0L08fZssK+tIDVFaURB6QYnPG16?=
 =?us-ascii?Q?0YK1//lPGf3JNp9xi5H/XXTUvEA+4d2ZpYlpP5WPgN+nqocQGaIDaybUo8fw?=
 =?us-ascii?Q?NrVS8dungKKdJKWqV4NlB4gpyMeHvfsTW/cfE05gXfYii1AYbhEsuZIucQ1y?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd8abb0-a07d-4455-2b6d-08dbd46dfef3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 08:48:29.9269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZaSDMS7MAsp2AHN1I47hE8x1FiYjfeYWNDVx5TDqpW7TUEFTMpJnS+jIBgqs4Z8j5AMZsBzjwfYdc822F4ZdqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5515
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:unable_to_handle_page_fault_for_address" on:

commit: c8e00140fa86367e0840b148e5ad41f5ae6e24c8 ("fs: add infrastructure for multigrain timestamps")
https://git.kernel.org/cgit/linux/kernel/git/jlayton/linux.git kdevops

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+----------------------------------------------------------------------------------+------------+------------+
|                                                                                  | 84f0c2d484 | c8e00140fa |
+----------------------------------------------------------------------------------+------------+------------+
| BUG:unable_to_handle_page_fault_for_address                                      | 0          | 6          |
| Oops:#[##]                                                                       | 0          | 6          |
| EIP:percpu_counter_add_batch                                                     | 0          | 6          |
| Kernel_panic-not_syncing:Fatal_exception                                         | 0          | 6          |
+----------------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202310241644.67f17b98-oliver.sang@intel.com


[    0.988550][    T0] BUG: unable to handle page fault for address: 26a4c000
[    0.990169][    T0] #PF: supervisor read access in kernel mode
[    0.991590][    T0] #PF: error_code(0x0000) - not-present page
[    0.991876][    T0] *pde = 00000000
[    0.991876][    T0] Oops: 0000 [#1] SMP
[    0.991876][    T0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.6.0-rc6-00092-gc8e00140fa86 #1
[    0.991876][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 0.991876][ T0] EIP: percpu_counter_add_batch (lib/percpu_counter.c:93 (discriminator 1)) 
[ 0.991876][ T0] Code: 43 34 11 53 28 f7 de 64 01 30 89 d8 e8 ea 5e 5e 00 9c 58 f6 c4 02 74 ca e8 e2 6d 5d 00 eb c3 e8 5b 96 bd ff 8b 4b 34 8b 7d e0 <64> 8b 31 89 f0 99 03 45 e4 13 55 e8 89 55 f0 89 c2 89 45 ec 8b 45
All code
========
   0:	43 34 11             	rex.XB xor $0x11,%al
   3:	53                   	push   %rbx
   4:	28 f7                	sub    %dh,%bh
   6:	de 64 01 30          	fisubs 0x30(%rcx,%rax,1)
   a:	89 d8                	mov    %ebx,%eax
   c:	e8 ea 5e 5e 00       	call   0x5e5efb
  11:	9c                   	pushf
  12:	58                   	pop    %rax
  13:	f6 c4 02             	test   $0x2,%ah
  16:	74 ca                	je     0xffffffffffffffe2
  18:	e8 e2 6d 5d 00       	call   0x5d6dff
  1d:	eb c3                	jmp    0xffffffffffffffe2
  1f:	e8 5b 96 bd ff       	call   0xffffffffffbd967f
  24:	8b 4b 34             	mov    0x34(%rbx),%ecx
  27:	8b 7d e0             	mov    -0x20(%rbp),%edi
  2a:*	64 8b 31             	mov    %fs:(%rcx),%esi		<-- trapping instruction
  2d:	89 f0                	mov    %esi,%eax
  2f:	99                   	cltd
  30:	03 45 e4             	add    -0x1c(%rbp),%eax
  33:	13 55 e8             	adc    -0x18(%rbp),%edx
  36:	89 55 f0             	mov    %edx,-0x10(%rbp)
  39:	89 c2                	mov    %eax,%edx
  3b:	89 45 ec             	mov    %eax,-0x14(%rbp)
  3e:	8b                   	.byte 0x8b
  3f:	45                   	rex.RB

Code starting with the faulting instruction
===========================================
   0:	64 8b 31             	mov    %fs:(%rcx),%esi
   3:	89 f0                	mov    %esi,%eax
   5:	99                   	cltd
   6:	03 45 e4             	add    -0x1c(%rbp),%eax
   9:	13 55 e8             	adc    -0x18(%rbp),%edx
   c:	89 55 f0             	mov    %edx,-0x10(%rbp)
   f:	89 c2                	mov    %eax,%edx
  11:	89 45 ec             	mov    %eax,-0x14(%rbp)
  14:	8b                   	.byte 0x8b
  15:	45                   	rex.RB
[    0.991876][    T0] EAX: 00000001 EBX: c2df4ca0 ECX: 00000000 EDX: c15cef45
[    0.991876][    T0] ESI: 00000020 EDI: 00000000 EBP: c212be18 ESP: c212bdf4
[    0.991876][    T0] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00210002
[    0.991876][    T0] CR0: 80050033 CR2: 26a4c000 CR3: 02704000 CR4: 00000690
[    0.991876][    T0] Call Trace:
[ 0.991876][ T0] ? show_regs (arch/x86/kernel/dumpstack.c:479 arch/x86/kernel/dumpstack.c:465) 
[ 0.991876][ T0] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434) 
[ 0.991876][ T0] ? page_fault_oops (arch/x86/mm/fault.c:707) 
[ 0.991876][ T0] ? kernelmode_fixup_or_oops+0x78/0xd0 
[ 0.991876][ T0] ? __bad_area_nosemaphore+0x11c/0x1f4 
[ 0.991876][ T0] ? bad_area_nosemaphore (arch/x86/mm/fault.c:867) 
[ 0.991876][ T0] ? do_user_addr_fault (arch/x86/mm/fault.c:1476) 
[ 0.991876][ T0] ? exc_page_fault (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 arch/x86/mm/fault.c:1513 arch/x86/mm/fault.c:1561) 
[ 0.991876][ T0] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1518) 
[ 0.991876][ T0] ? handle_exception (arch/x86/entry/entry_32.S:1056) 
[ 0.991876][ T0] ? percpu_counter_add_batch (lib/percpu_counter.c:93 (discriminator 1)) 
[ 0.991876][ T0] ? sched_core_share_pid (kernel/sched/core_sched.c:225 (discriminator 16)) 
[ 0.991876][ T0] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1518) 
[ 0.991876][ T0] ? percpu_counter_add_batch (lib/percpu_counter.c:93 (discriminator 1)) 
[ 0.991876][ T0] ? sched_core_share_pid (kernel/sched/core_sched.c:225 (discriminator 16)) 
[ 0.991876][ T0] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1518) 
[ 0.991876][ T0] ? percpu_counter_add_batch (lib/percpu_counter.c:93 (discriminator 1)) 
[ 0.991876][ T0] ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:63) 
[ 0.991876][ T0] ktime_get_mg_coarse_ts64 (kernel/time/timekeeping.c:2371) 
[ 0.991876][ T0] ? __lock_release+0x4a/0x134 
[ 0.991876][ T0] inode_set_ctime_current (fs/inode.c:2563 fs/inode.c:2576) 
[ 0.991876][ T0] ? inode_sb_list_add (fs/inode.c:496) 
[ 0.991876][ T0] simple_inode_init_ts (fs/libfs.c:1929) 
[ 0.991876][ T0] __shmem_get_inode (mm/shmem.c:2459) 
[ 0.991876][ T0] shmem_fill_super (mm/shmem.c:4356) 
[ 0.991876][ T0] ? shmem_fill_super (mm/shmem.c:4356) 
[ 0.991876][ T0] ? shmem_fileattr_set (mm/shmem.c:4267) 
[ 0.991876][ T0] get_tree_nodev (fs/super.c:1335 fs/super.c:1354) 
[ 0.991876][ T0] shmem_get_tree (mm/shmem.c:4375) 
[ 0.991876][ T0] vfs_get_tree (fs/super.c:1750) 
[ 0.991876][ T0] vfs_kern_mount (fs/namespace.c:4751) 
[ 0.991876][ T0] ? shmem_parse_one (mm/shmem.c:4424) 
[ 0.991876][ T0] kern_mount (fs/namespace.c:4754) 
[ 0.991876][ T0] shmem_init (mm/shmem.c:4615) 
[ 0.991876][ T0] mnt_init (fs/namespace.c:4738) 
[ 0.991876][ T0] vfs_caches_init (fs/dcache.c:3351) 
[ 0.991876][ T0] start_kernel (init/main.c:1053) 
[ 0.991876][ T0] i386_start_kernel (??:?) 
[ 0.991876][ T0] startup_32_smp (arch/x86/kernel/head_32.S:305) 
[    0.991876][    T0] Modules linked in:
[    0.991876][    T0] CR2: 0000000026a4c000
[    0.991876][    T0] ---[ end trace 0000000000000000 ]---
[ 0.991876][ T0] EIP: percpu_counter_add_batch (lib/percpu_counter.c:93 (discriminator 1)) 
[ 0.991876][ T0] Code: 43 34 11 53 28 f7 de 64 01 30 89 d8 e8 ea 5e 5e 00 9c 58 f6 c4 02 74 ca e8 e2 6d 5d 00 eb c3 e8 5b 96 bd ff 8b 4b 34 8b 7d e0 <64> 8b 31 89 f0 99 03 45 e4 13 55 e8 89 55 f0 89 c2 89 45 ec 8b 45
All code
========
   0:	43 34 11             	rex.XB xor $0x11,%al
   3:	53                   	push   %rbx
   4:	28 f7                	sub    %dh,%bh
   6:	de 64 01 30          	fisubs 0x30(%rcx,%rax,1)
   a:	89 d8                	mov    %ebx,%eax
   c:	e8 ea 5e 5e 00       	call   0x5e5efb
  11:	9c                   	pushf
  12:	58                   	pop    %rax
  13:	f6 c4 02             	test   $0x2,%ah
  16:	74 ca                	je     0xffffffffffffffe2
  18:	e8 e2 6d 5d 00       	call   0x5d6dff
  1d:	eb c3                	jmp    0xffffffffffffffe2
  1f:	e8 5b 96 bd ff       	call   0xffffffffffbd967f
  24:	8b 4b 34             	mov    0x34(%rbx),%ecx
  27:	8b 7d e0             	mov    -0x20(%rbp),%edi
  2a:*	64 8b 31             	mov    %fs:(%rcx),%esi		<-- trapping instruction
  2d:	89 f0                	mov    %esi,%eax
  2f:	99                   	cltd
  30:	03 45 e4             	add    -0x1c(%rbp),%eax
  33:	13 55 e8             	adc    -0x18(%rbp),%edx
  36:	89 55 f0             	mov    %edx,-0x10(%rbp)
  39:	89 c2                	mov    %eax,%edx
  3b:	89 45 ec             	mov    %eax,-0x14(%rbp)
  3e:	8b                   	.byte 0x8b
  3f:	45                   	rex.RB

Code starting with the faulting instruction
===========================================
   0:	64 8b 31             	mov    %fs:(%rcx),%esi
   3:	89 f0                	mov    %esi,%eax
   5:	99                   	cltd
   6:	03 45 e4             	add    -0x1c(%rbp),%eax
   9:	13 55 e8             	adc    -0x18(%rbp),%edx
   c:	89 55 f0             	mov    %edx,-0x10(%rbp)
   f:	89 c2                	mov    %eax,%edx
  11:	89 45 ec             	mov    %eax,-0x14(%rbp)
  14:	8b                   	.byte 0x8b
  15:	45                   	rex.RB


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231024/202310241644.67f17b98-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


