Return-Path: <linux-fsdevel+bounces-17019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BD68A6287
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 06:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D20791F21D27
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 04:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E215F37160;
	Tue, 16 Apr 2024 04:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LSP0PI2Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED7C171D2;
	Tue, 16 Apr 2024 04:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713242582; cv=fail; b=auCPxCqUbxJzpaPkyTBsJydrZh6aWmjZoQUDanvuZO9MWZB4n9+12cg7rZlsT4QbXDdWqTNDVAitX41bU0Zj3jnDJ+rtnIRSW8niXihX+wd1aGVQ7rgjK9m6A4dvI64wjoVPN0wky1mmM+RBWTi0bvRQo1XmAg8eUMMLvApJ7xE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713242582; c=relaxed/simple;
	bh=nguOUyKg136HmwxTFMkFwX6c9QjunoAjPn0rurRMBBw=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=hKLq8gZXegCKbXy6sZl9YkhARfjcgmPT804JqBqKa/Bh8Cfmz7+ismovOlpYhDjEiOEmywdOD+wghUbFbHiqYKd7eTQdyjj02BMJk/oOVfzxcrMZYp3VPm4KS/zogy0sQCqbPmmDm8KD7Vlp04bhicHEaWHI6Cht4NjqWwRmV1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LSP0PI2Z; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713242580; x=1744778580;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nguOUyKg136HmwxTFMkFwX6c9QjunoAjPn0rurRMBBw=;
  b=LSP0PI2ZPTKePJnUEmYyvBa52cS5A84LXHiir4u93a3eJRdvIS371Ugu
   DhbjV3X+X1kb6qTZ2oqvhhvBVPznTJdG4EQMm/0Jx4p3ljZePDaaJc2xk
   X+yGKdgEwIk21iroDjwtBK1FF6XJ64vhe2us7xbs2gmGhTNvdYVxxK93L
   U4lp91NbBQekf2lUHi01NRxdadsfKukpiCro0+0gRWWjFMFcU6mCqcyMb
   vsG0Nzg8Fahkt/0VTodN3fmqyGN7fQ010JMsG8nBypgcYNfsOhl6REnFc
   BjX9NSdaYWkn5qOx4kl4i6y6hfwpuCFxko89uCmlVyb9cf+b8bMQ6F6Dc
   Q==;
X-CSE-ConnectionGUID: 0mLC5c5MQXuDq6BRI2fHbA==
X-CSE-MsgGUID: azpOID6uTTGy5/SwP8/AVg==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8769260"
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="8769260"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 21:42:59 -0700
X-CSE-ConnectionGUID: OA/o7J4vQKS726w9zHInqQ==
X-CSE-MsgGUID: LYrLB7eBSxq0Ga/WEgAi3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="59583827"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Apr 2024 21:42:59 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 21:42:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 21:42:58 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 21:42:58 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 21:42:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOL8QlpV0rBE9uUu6+338gvgGfQaXTiXYaUEU05DKJea+LkfWGMbq6ht+MUBJhPZ8/ZlNrnswd5E2qHEd2YCj3MHyhDEFqSSD4g7f89PV1DcNPNvYGapV6e0WTIWNUGvMa1QSr2VIhq3fYLuZ4GABkrctRMYlh0MeDarsG6MSj+Et/W1K1VhPiwtysSfi25kk5OS9dB0O9Hi5+jLAhNWm2pO3pgKQgRaT6ceuv5EV8SMid59oQAq2m+pBJtYhaKTnjBQn66tje1DVnAG54nlOtje6AleaaUXK29p5Jjchpzx5XJT8l8FnWkjDJM1xdaUuztQPQiUN4/YX+AcLN4z6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wna9GG5gehmbd5bzzCG77tFqfOi2Q9bVZZKvG/ktUXg=;
 b=JOxn0ks9JUUoLHB9lx43UX7YS9VKK302L4nKXwEAqF+Qf3qGQXRCuevQAltqpol2CR2cvp19sJ3Dk4BsEUrlDv/Htk8Hml1bB1+NvwcEvaLzRmrm6/odDeiUCPlNcwvgERi6okk44wMyEoDcPhRw2DK01s9GtAsV3ctgQbtlOTP1VrxCu77AyRaMsV/CVlcQjH9pmBZ7DKRKQuS5urXkUhECSmANvJMCJRPidJvBuxNyBZNxxfw/wnDOHGspRI5xD3fsZKQ364OBQ2PXaDKhsQxZHUowcFoXLpcwtLQTPmjMCReLkhPASDHnuidq9Gzp4FEfuV9vyfED5WKg58RYZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB8521.namprd11.prod.outlook.com (2603:10b6:806:3ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 04:42:47 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7472.025; Tue, 16 Apr 2024
 04:42:47 +0000
Date: Tue, 16 Apr 2024 12:42:37 +0800
From: kernel test robot <oliver.sang@intel.com>
To: David Howells <dhowells@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Steve French
	<sfrench@samba.org>, Shyam Prasad N <nspmangalore@gmail.com>, "Rohith
 Surabattula" <rohiths.msft@gmail.com>, Jeff Layton <jlayton@kernel.org>,
	<netfs@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-cifs@vger.kernel.org>, <samba-technical@lists.samba.org>,
	<oliver.sang@intel.com>
Subject: [dhowells-fs:cifs-netfs] [cifs]  b4834f12a4:
 WARNING:at_fs/netfs/write_collect.c:#netfs_writeback_lookup_folio
Message-ID: <202404161031.468b84f-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SGXP274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::25)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB8521:EE_
X-MS-Office365-Filtering-Correlation-Id: bc828df2-b49e-4e42-67eb-08dc5dcfaa04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tx1+Es2HJyoAP/tpQLXMAbVkgPui3Zk9FtEvfV1bpfMnWtpi0xMdjQWk/bcDsh3OUk0oJSC+rB+QXNLpIiu60S9UNIjphU+Sl3BDHlc3OT+oB/bsjY+k7+cVA6Ix41jCRJMwI7myZOi6vWTF4V77xCeRgkYZLQMOHxAAIbuXYsvbBSLvW6kg6X/ImA/qRQRZl/lkDL7hG8l6tVBCkWHgLbUYQvAnxXLUifkA2zhcnnlHPd97pW5Vfpoj/gwsiUr+bYQde04CHvCLVX39dLA3iZ+jKbWLBQd2+XT0l9A3jwqU3MUK1LQjz+2nwYHfn8Tl9p4aWsT6duNNh8d8xbYUJJi8qP3MCPKWSzBffneWsPhwgquS1oh0SVwZ9ESMpPRG/mjwvMDjNApWZh8TqWjulaf4vdK1vlWBbesiIRkJflTGfGDFHzOR5ER4f3R1bKvpVnxBoZw0LOb1zU9fKfzKvR8P2fuOSTgmSDaYAXJWCbkjYIDLA+7Pip36Fo+N4q5ApfW1LoHhXepUsG3lOUppp2goFZFDwhIfpD8vX7Z11nOKP4t00+478RsCmDpLfjcTGOerkQ3wqx+1HKIrLIyh4bDZQmm41h/opJU99kQUJyc38MmSfstBTqm6dFWkr902
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wh6GyOwKYo69KvALP+CvHtifsFzGAuLIio4EM6BYumBJYbo3XK/bmB19KWbQ?=
 =?us-ascii?Q?VWvAd01I7l6QPMU5GxhWnoB4jQzZpp3ipg7RlCY5SbFQVKGZVytnybaBz0zo?=
 =?us-ascii?Q?Fnj7Af80eP5wSknPoFzz1S/mW8V3GcRIpZ25ORQ8L6lB8b/eIJaC6PaDURbV?=
 =?us-ascii?Q?pml8QO99uPSM3yJfC2XL4NP+5KvNaN/pxWNa9y+1Lc5Aw1Xc6ybkIjFYwb5F?=
 =?us-ascii?Q?SDz+AUsRDmwX/C3JIJ3ON2gXeSCDyVvFNfROW3jVCT8re0STie5Vpls7LTcq?=
 =?us-ascii?Q?yXdh7phJ3rfFydoyt6GhnURdb0iLifgNPLOxDLkFSkAI9WJ5Z1Q1KphuNQD0?=
 =?us-ascii?Q?NIBGQUYySvC7huI+YBhldTDHqqKxqE6vlBSMLE3AONDqlVhBCrEp6PL6VlJO?=
 =?us-ascii?Q?fZ7h3iMJm+/co2gFK8yL2dQzrjdLpRo/zldpft3s3GMGKqJMC3/P0uGXZPs9?=
 =?us-ascii?Q?ptO1DYqq0yDQssdcG/HbVjLP1pLplceg3lHYkaPdFefcQxcAOq2oN/+oysJZ?=
 =?us-ascii?Q?HRGMqKUhWip1jpUoPGjoBJ/7e8O8ezZEWBFjEg6r+thaQcBKcdetgkJOKVaR?=
 =?us-ascii?Q?fIVsdA/tunFz037s1i0FXKSNxQ5LmsXprGyjs97UlH2ahJ37nDGxpTOiZCJj?=
 =?us-ascii?Q?/D72dccF8pm2MiDml4XPuJF9d4zSZzojkU18xkh0m91xBZ33RmnUcA7R/zJU?=
 =?us-ascii?Q?QElDyGZk6fTreMUCAY7MLYdqiTuSUhmNtZB+FslygNQr6beqQV/2MQuwI3jt?=
 =?us-ascii?Q?PgE68saVDDY2tuFUWb+L8o0ZzkOlC8mRIx56+TCnSZwo4zNfPQeEKRRrquD+?=
 =?us-ascii?Q?GMRcgG5TsE26Hg6oKsm4dLXQHQVbQD6398tvU6x849h6PSDyzcg17rMSH/JI?=
 =?us-ascii?Q?4gGszEMb57+ZFP7YvQMTaIhCUSQCuMdfs3EWmVhaXZpTL0gyHFNwHlezr5Ib?=
 =?us-ascii?Q?XuIthtLfjNVqg41aIcrB7J6R6TUlomTCsAK4hjBb2kZXKk8mAkL5zPBziQR9?=
 =?us-ascii?Q?o0b3aZqJiiS1LJ4nDfEilovZtflb1Efrv+lyH1yiubgnLWrkhXYB2fDBK4Bo?=
 =?us-ascii?Q?kVmP/Cl70kfjbYwLDOyEuP+NZcjjKgJ3+EPtQCTmPx4tvn6aQ+mejzHnDNLn?=
 =?us-ascii?Q?zUuw82Cyw4B8E9bX2Jk4xIgG9sm7TFGjv8bFuu4EYKaEgQO7hF/JmufgIr/1?=
 =?us-ascii?Q?TR6jAgcG/IE4K6CPFd99VL3Y2kHuWeMZQFchE7+g5//VtUCGc1CbDaqwqYRc?=
 =?us-ascii?Q?vZg8DUdUCluO/FKckoYHZ8IFTAOAHERL3Fqd/GIMpdRGo2d8c6wlgNPdU8x7?=
 =?us-ascii?Q?feMtIvtFb8er1QFeWZrjeXijmjx5PH8y1n8PIoNEaekMW+FP4/R4kPWgqHLG?=
 =?us-ascii?Q?Beto6NLZ86PWK8SfbXFpe6cRHFnCwHtycfUjWgEqLjvqYdp9Z1DNyqiu/m5L?=
 =?us-ascii?Q?82l/+nEj1/gdEWbgdm6LlRsl4TuP76ZJ0FL0NcJkxe9dM0tUoUROw+tf6Ag+?=
 =?us-ascii?Q?r4EWNb4AWANzjUaC2rZEC1GFR/6KN8cy6n2MdIySSgUOunQf+2pCM/h97Vam?=
 =?us-ascii?Q?aA0TsNxqtt+kq3M0tpGk630e1Hpeb4HZKeeSS/py6TfQ0h3Qsw0YMhqq9qiU?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc828df2-b49e-4e42-67eb-08dc5dcfaa04
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 04:42:47.3343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D6ERlBCD1JYX2xSFBAqYheEA6QHseolbr8Xju42rA0x8m2OMFtJstlt7pGfqqsnOINYchXqey52msRBpRf2GWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8521
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_fs/netfs/write_collect.c:#netfs_writeback_lookup_folio" on:

commit: b4834f12a4df607aaedc627fa9b93f3b18f664ba ("cifs: Cut over to using netfslib")
https://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git cifs-netfs

in testcase: filebench
version: filebench-x86_64-22620e6-1_20240224
with following parameters:

	disk: 1HDD
	fs: btrfs
	fs2: cifs
	test: filemicro_seqwriterandvargam.f
	cpufreq_governor: performance



compiler: gcc-13
test machine: 96 threads 2 sockets Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz (Cascade Lake) with 128G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202404161031.468b84f-oliver.sang@intel.com


[   51.734544][  T654] ------------[ cut here ]------------
[   51.740181][  T654] R=00000012: folio 11 is not under writeback
[ 51.746415][ T654] WARNING: CPU: 34 PID: 654 at fs/netfs/write_collect.c:105 netfs_writeback_lookup_folio (fs/netfs/write_collect.c:105 (discriminator 1)) 
[   51.757394][  T654] Modules linked in: cmac nls_utf8 cifs cifs_arc4 nls_ucs2_utils cifs_md4 dns_resolver kmem intel_rapl_msr intel_rapl_common skx_edac x86_pkg_temp_thermal btrfs intel_powerclamp coretemp kvm_intel blake2b_generic xor sr_mod kvm cdrom raid6_pq crct10dif_pclmul sd_mod crc32_pclmul libcrc32c crc32c_intel ghash_clmulni_intel sg sha512_ssse3 ipmi_ssif binfmt_misc device_dax nvme nd_pmem rapl nvme_core nd_btt dax_pmem ahci ast t10_pi libahci intel_cstate acpi_ipmi ipmi_si crc64_rocksoft_generic mei_me drm_shmem_helper i2c_i801 crc64_rocksoft ipmi_devintf ioatdma libata drm_kms_helper intel_uncore mei nfit crc64 lpc_ich i2c_smbus intel_pch_thermal dca wmi ipmi_msghandler libnvdimm joydev drm fuse dm_mod loop ip_tables
[   51.775438][ T1342] Events disabled
[   51.821864][  T654] CPU: 34 PID: 654 Comm: kworker/u386:27 Tainted: G S                 6.9.0-rc3-00036-gb4834f12a4df #1
[   51.823577][ T1342]
[   51.827064][  T654] Hardware name: Intel Corporation S2600WFD/S2600WFD, BIOS SE5C620.86B.0D.01.0286.011120190816 01/11/2019
[   51.827066][  T654] Workqueue: events_unbound netfs_write_collection_worker
[   51.838243][ T1342] Events disabled
[   51.840127][  T654]
[ 51.840128][ T654] RIP: 0010:netfs_writeback_lookup_folio (fs/netfs/write_collect.c:105 (discriminator 1)) 
[   51.851254][ T1342]
[ 51.858206][ T654] Code: 48 89 de e8 c9 ad ff ff e9 62 ff ff ff 48 8b 53 20 8b b5 ac 01 00 00 48 c7 c7 d0 e0 97 82 c6 05 12 0b c0 01 01 e8 a7 f8 b9 ff <0f> 0b eb a8 e8 1e 99 ae 00 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
All code
========
   0:	48 89 de             	mov    %rbx,%rsi
   3:	e8 c9 ad ff ff       	callq  0xffffffffffffadd1
   8:	e9 62 ff ff ff       	jmpq   0xffffffffffffff6f
   d:	48 8b 53 20          	mov    0x20(%rbx),%rdx
  11:	8b b5 ac 01 00 00    	mov    0x1ac(%rbp),%esi
  17:	48 c7 c7 d0 e0 97 82 	mov    $0xffffffff8297e0d0,%rdi
  1e:	c6 05 12 0b c0 01 01 	movb   $0x1,0x1c00b12(%rip)        # 0x1c00b37
  25:	e8 a7 f8 b9 ff       	callq  0xffffffffffb9f8d1
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	eb a8                	jmp    0xffffffffffffffd6
  2e:	e8 1e 99 ae 00       	callq  0xae9951
  33:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
  3a:	00 00 00 00 
  3e:	0f                   	.byte 0xf
  3f:	1f                   	(bad)  

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	eb a8                	jmp    0xffffffffffffffac
   4:	e8 1e 99 ae 00       	callq  0xae9927
   9:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
  10:	00 00 00 00 
  14:	0f                   	.byte 0xf
  15:	1f                   	(bad)  
[   51.858208][  T654] RSP: 0018:ffffc90007f57d80 EFLAGS: 00010286
[   51.858209][  T654] RAX: 0000000000000000 RBX: ffffea00081f3340 RCX: 0000000000000000
[   51.909493][  T654] RDX: ffff88df016ae2c0 RSI: ffff88df016a0b00 RDI: ffff88df016a0b00
[   51.917619][  T654] RBP: ffff88816bbc8280 R08: 0000000000000000 R09: 0000000000000003
[   51.925740][  T654] R10: ffffc90007f57c18 R11: ffffffff82fd56a8 R12: 0000000000000011
[   51.933861][  T654] R13: ffff88cf8421af00 R14: ffff88816bbc8280 R15: ffff88816bbc83e0
[   51.941993][  T654] FS:  0000000000000000(0000) GS:ffff88df01680000(0000) knlGS:0000000000000000
[   51.951072][  T654] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   51.957817][  T654] CR2: 00007ffff7e0ed90 CR3: 0000005f7de1c002 CR4: 00000000007706f0
[   51.965946][  T654] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   51.974071][  T654] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   51.982190][  T654] PKRU: 55555554
[   51.985880][  T654] Call Trace:
[   51.989369][  T654]  <TASK>
[ 51.992447][ T654] ? __warn (kernel/panic.c:694) 
[ 51.996657][ T654] ? netfs_writeback_lookup_folio (fs/netfs/write_collect.c:105 (discriminator 1)) 
[ 52.002864][ T654] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
[ 52.007512][ T654] ? handle_bug (arch/x86/kernel/traps.c:239) 
[ 52.011982][ T654] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1)) 
[ 52.016793][ T654] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
[ 52.021948][ T654] ? netfs_writeback_lookup_folio (fs/netfs/write_collect.c:105 (discriminator 1)) 
[ 52.028140][ T654] netfs_collect_write_results (fs/netfs/write_collect.c:128 (discriminator 1) fs/netfs/write_collect.c:547 (discriminator 1)) 
[ 52.034062][ T654] netfs_write_collection_worker (arch/x86/include/asm/bitops.h:206 arch/x86/include/asm/bitops.h:238 include/asm-generic/bitops/instrumented-non-atomic.h:142 fs/netfs/write_collect.c:637) 
[ 52.040078][ T654] process_one_work (kernel/workqueue.c:3254) 
[ 52.045046][ T654] worker_thread (kernel/workqueue.c:3329 (discriminator 2) kernel/workqueue.c:3416 (discriminator 2)) 
[ 52.049749][ T654] ? __pfx_worker_thread (kernel/workqueue.c:3362) 
[ 52.054965][ T654] kthread (kernel/kthread.c:388) 
[ 52.058967][ T654] ? __pfx_kthread (kernel/kthread.c:341) 
[ 52.063652][ T654] ret_from_fork (arch/x86/kernel/process.c:147) 
[ 52.068171][ T654] ? __pfx_kthread (kernel/kthread.c:341) 
[ 52.072850][ T654] ret_from_fork_asm (arch/x86/entry/entry_64.S:256) 
[   52.077711][  T654]  </TASK>
[   52.080821][  T654] ---[ end trace 0000000000000000 ]---



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240416/202404161031.468b84f-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


