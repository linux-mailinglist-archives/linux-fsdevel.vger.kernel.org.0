Return-Path: <linux-fsdevel+bounces-7508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26185826438
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Jan 2024 14:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49AE8B21691
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Jan 2024 13:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE56513AE4;
	Sun,  7 Jan 2024 13:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bdkXkKU3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABF013AC8;
	Sun,  7 Jan 2024 13:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704633609; x=1736169609;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=S1tPERa3IUe+DTnMmdNLoTU3GGX9oKE+zy0uSwj3BRI=;
  b=bdkXkKU3h5PBwBs5eU8PTLbmhgaGDeNE/3i+vG+8nV91T3W5krZItgPb
   XOkKzBTm2psELQrhvPrXpdXEgznjHRbvT1jaic+uQdSXm1aJWZTw/rXTB
   wsJcFMnw+CEA+86qAVyTMEmzDD6ftT4PmcYQSed3GPQxhoW5gMn5Fm425
   aS+As/6s/9l3Eg33seqP9lUicFel6fGLZ2lLLFT0BOYFXqQx7ttrcshyU
   xPv7LrerMfRnHIQdUZFSNChWBFDfnMTA2bCZ6zcJFoXGRhsL2jhtyzCxo
   DgCFxYuIUqAeHMSaxUtn1PCfUpECuKBpky8I6x+l/bCyNp7JZbN1L9SdQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="4818263"
X-IronPort-AV: E=Sophos;i="6.04,339,1695711600"; 
   d="scan'208";a="4818263"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2024 05:20:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="757380388"
X-IronPort-AV: E=Sophos;i="6.04,339,1695711600"; 
   d="scan'208";a="757380388"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jan 2024 05:20:07 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Jan 2024 05:20:06 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Jan 2024 05:20:06 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 7 Jan 2024 05:20:06 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Jan 2024 05:20:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIUWcBoZYa8SgetCIdRje/oomSMLXeVfLT4u7/V7vu6nrlSt2tH2aVVgWWr6gClaTP/EIwXFO3sNmw82+yqK6jKBVaI9Td4u6jnBUGVCytB12MtZMd5yGwE1MtqFNs9TvdaIW1+TqOepqBJfTe7jQEeAolfIglimKOqs2a2Kzyw8h8cexWqHiUL7Gouv1ll4SHEO064QGepsRjuKpQYgWqnnEJmYvsGqAXJHp5NRjGP2+FJav1V2On7tLvkE0p6YESLD2Gg6wzt7W8N9az3v+iAUrUVHpJmDBvkJ5LBHwHFarNBDEfbbzZ6JAFQPtdadU9dGdDwpanOQs4NyATS+0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KED5miN+LJr6rn82LnHm/lpAw90UNGbdIrL3mPS5yHg=;
 b=Nz9BDOeum3vPGM6ekXLAuk7tEb7PdqlRm0LoH6rnKGN8iLavbtbKTZsza/oyZfin5Y5pyYef2kDwJbd8Affdn1Lrsf9JLKBUZ6k/ORpd4tzaLUVQ+Zko8bFqBEbR4y2G06GB9u7nglxWCjBLN0UUQzSmRqscsjW3KYldRVtG25UR5zoQIo2IcYE+Aj+2eOlcYp6yQiV8TXErE8IQWsmC/PenHJfJikJ6Q0qOXb+n7YXzM6WxseDAOCz4YULpluautoU3DZBYafKE+E00BuLNbfydxhkH2ujdwWCHW6cT8u0QFDXMPPtIjQgBJZwHRHc4An5ZClliG8i69tK2UjRAUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8396.namprd11.prod.outlook.com (2603:10b6:806:38d::18)
 by PH7PR11MB6449.namprd11.prod.outlook.com (2603:10b6:510:1f7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.20; Sun, 7 Jan
 2024 13:20:03 +0000
Received: from SA1PR11MB8396.namprd11.prod.outlook.com
 ([fe80::8f:3783:755a:1935]) by SA1PR11MB8396.namprd11.prod.outlook.com
 ([fe80::8f:3783:755a:1935%4]) with mapi id 15.20.7159.020; Sun, 7 Jan 2024
 13:20:03 +0000
Date: Sun, 7 Jan 2024 21:19:52 +0800
From: kernel test robot <lkp@intel.com>
To: Baoquan He <bhe@redhat.com>, <linux-kernel@vger.kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, <akpm@linux-foundation.org>,
	<kexec@lists.infradead.org>, <hbathini@linux.ibm.com>, <arnd@arndb.de>,
	<ignat@cloudflare.com>, <eric_devolder@yahoo.com>, <viro@zeniv.linux.org.uk>,
	<ebiederm@xmission.com>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>, "Baoquan
 He" <bhe@redhat.com>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 5/5] crash: clean up CRASH_DUMP
Message-ID: <ZZqk+AnXbqnJuMdF@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240105103305.557273-6-bhe@redhat.com>
X-ClientProxiedBy: SG2PR04CA0170.apcprd04.prod.outlook.com (2603:1096:4::32)
 To SA1PR11MB8396.namprd11.prod.outlook.com (2603:10b6:806:38d::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8396:EE_|PH7PR11MB6449:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ffee6a1-cf77-406f-786e-08dc0f835b61
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oLI9v/4edeFPbWM8YQNMGoEokuv1IpNZCx9fh9Ha9w34c3vXGNIIfkBjSzKyf4aeDJmM+pUYZ8dX5Fb4VurdNZ1d+QmeFQy0AdnlrWb+aIAkWRxjO8eAN8Bg9NvkhaNUAGJAGqfMQOdUfbzN7p9Chm9Ru/1jse1MwIji7c5/0pxTzhd05qOtcS1q7ns1iKf3iuLHR23vd7LKvlox2PfmIDcK/qMRudMMGwTL2SEIZGobuDkX9LiL+eLjtyuC6zqKWTQp3Uuq2k4kEzvC6dqnsOcfwVRTdcx/+YSZ/sJXnP/WgtlJfK21/FJuhiCw9al3pVjFhIQLfmtod16pezCC0WGzVNciGy7jCUxdRrudLgxUsBEvaLirfu1OzmdDTXsIQCQBfH5mCCUFK62aPeq0qZzIsnuzTUvT6hCq1EVqIUZ2ZuHR6zOsQCIzPlmyKduqyUADDjr++OjNneLQJ+8dEECbky0H8Q6FuYV6o/dcus7J8oAPVo+5MExunQwDPui6F/JOevcoRnrkbG5xsCeiqsy7S5r7KsBZPvIuK5JKai+SGQ7ydZlTnbyZ3pruyDoE4m1BXygfpjn1gtJMg4CLAdfZFLj7lpKVL26JvNXUAGztrr8ggy/c10gdD+HGfd8T4WhmKfDXquo4b7RjA3mm0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8396.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(396003)(366004)(346002)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(2906002)(38100700002)(7416002)(5660300002)(82960400001)(86362001)(33716001)(41300700001)(316002)(54906003)(8676002)(8936002)(9686003)(6512007)(6486002)(107886003)(66556008)(66946007)(26005)(66476007)(478600001)(966005)(83380400001)(6506007)(6666004)(4326008)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P+Gxy1ITa7FlVzUnvJfSxAq+bX1TI1uJx6ZW9q6SEaa4x25eV4j+bqWVRaId?=
 =?us-ascii?Q?uA1k4mt/COo57gFItfXDqgAAvzj/hB5V8Tnq7jQ2ZNAjRgQEGwLBfSo56XDl?=
 =?us-ascii?Q?XTx3ADOl2X3POvby1oUCiJ9+yZ9kKYTh6JszuBTKpB2Kx6wcM2udh9VU3aNA?=
 =?us-ascii?Q?sluoZl1lN2XZzP+kU9+zyM3B5uDDUFBd6DTf6nspdqsD22Mrp4aa+u6AP8Q0?=
 =?us-ascii?Q?TXluuNlCzB602PEYE8VyQm1VXKQtiLwrgqoSwtImYxO6hp9bpQGtlAkoKu5t?=
 =?us-ascii?Q?qLCiNNo9moNMJ0eMp1PhDy0Cqf+9mofPKebdnKX1LRG9lfQlDXNqCihF6aW9?=
 =?us-ascii?Q?uG3fa6fr9fxdXEjngryS1NjVHoT7b281cAI+gwCKZc9+J7AY9DRExOfZw/4C?=
 =?us-ascii?Q?TnZOx8Tc3qJm4fcrlMbPkLltWtjm9EHcqh+hKM4C55bcwMXAVLbdHmrUZwht?=
 =?us-ascii?Q?AuIRKZazknu5l4l6zsmn04o3vsoDdv2B3BrMC7yarIsjdQB1xvLcEHWZ1idM?=
 =?us-ascii?Q?kSkNClMAQDhVngNpMWo0o3jZayjlaXmwZXSV3MEp5ilQoOmBpWB//HIqaTJj?=
 =?us-ascii?Q?oMG9NrYDPMIFddr15ZD7061ZyczhVZBJAso2fH/4vB2+5HeFYo2p7OuRLKEa?=
 =?us-ascii?Q?uiKKXofLfmzlzdh/L+WzqhHsPjskb+JbBAFMY/d2tYH93Jsz/T5Ux/HgXtNU?=
 =?us-ascii?Q?V+hNudTtecq/vBKPMdDGiksgYMdL7k/srw0nEUjb9+kpnq5BXDczWO+M/ley?=
 =?us-ascii?Q?YaTmEhG97fQyWL3uzcxDoianl8QdVFHmC35ckKM0aOgatgOuLsj3O6CzJRa/?=
 =?us-ascii?Q?+ifrKbuHMm3aLnJF8QKTsKB20Kt/snl78Xlu+BQlamE1QgerZGJMb0Y/i5iS?=
 =?us-ascii?Q?DTpJ6qjrKzhYMH7NHL3SBeNozg3kLJoiJ29/Gp12T0ggoa9InB+PTikCe6cO?=
 =?us-ascii?Q?CRbGoThBExjiqwYuYCgLNcVDwM/okUmiMZPUmyxq1pYSLG3Z6p5KUodKjo1Z?=
 =?us-ascii?Q?GcPPkPBICR45CJiP7XuVt895mkEclzvTZOc34sQTsnDLYe/j2pE7ycu3VMDD?=
 =?us-ascii?Q?7EyCMWNuZ+zrfCgP7mdjZMEpLss0yvVLklWfSvZc8M+gO3VOAMZviaumx2hN?=
 =?us-ascii?Q?b2MRw45UnTeX1GS66q3H77DhTfmmcR7efYBkrcl1ZLUdYZU8GYWlZG7g08NH?=
 =?us-ascii?Q?zJYVq9YyTdgQANyRZOGYKFE4cFrRMOpnH4wfVyMf2/LZXf08WZUnhQivCeg4?=
 =?us-ascii?Q?xbcp2bYelAqP/D+nX1LeKnjwg2elIVPbiSs9RsUBd4dMlnctD2SPDDDRl7Gv?=
 =?us-ascii?Q?wL8nfWiY5vy8wWPQzhNzYve1UoT5NWSEQhOd0Y5dPZpclA6z5pHZ1gIEPs7+?=
 =?us-ascii?Q?1TjfmVvVsZd1kkeEIcRC+fpnKkIhvIE8pFHWW0mY9Spy+3EqndolZJeHep6W?=
 =?us-ascii?Q?qppKOPZkFvgEdeNM8z3NfyLdzrvA/8lzW14kYQxoxfq0twhxCFy32484OQ4t?=
 =?us-ascii?Q?ezRc1D6NkZrywxXiZ/HuYGlZ5fJZAZ3n1cCe9CUISLB71ZYsb4aDRmBeIksW?=
 =?us-ascii?Q?Erwh8QmF/9axzu4W6OxvJ3jHUaNHr6NFQh2uw6BbPFO/W/nGWOOEmIb4He4X?=
 =?us-ascii?Q?iQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ffee6a1-cf77-406f-786e-08dc0f835b61
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8396.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2024 13:20:03.4191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6mwp+F8Ao3ekxOBl4FXGQIVWFEIbrM4bZnHl/vxY1CeCBR++whdqILb2kk78l8bQhRL6c4WBAviF7+fm406H+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6449
X-OriginatorOrg: intel.com

Hi Baoquan,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.7-rc8]
[cannot apply to powerpc/next powerpc/fixes tip/x86/core arm64/for-next/core next-20240105]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/kexec_core-move-kdump-related-codes-from-crash_core-c-to-kexec_core-c/20240105-223735
base:   linus/master
patch link:    https://lore.kernel.org/r/20240105103305.557273-6-bhe%40redhat.com
patch subject: [PATCH 5/5] crash: clean up CRASH_DUMP
:::::: branch date: 2 days ago
:::::: commit date: 2 days ago
config: x86_64-randconfig-122-20240106 (https://download.01.org/0day-ci/archive/20240107/202401071326.52yn9Ftd-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240107/202401071326.52yn9Ftd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202401071326.52yn9Ftd-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: crashk_res
   >>> referenced by initramfs.c:638 (init/initramfs.c:638)
   >>>               init/initramfs.o:(kexec_free_initrd) in archive vmlinux.a
   >>> referenced by initramfs.c:638 (init/initramfs.c:638)
   >>>               init/initramfs.o:(kexec_free_initrd) in archive vmlinux.a
   >>> referenced by initramfs.c:0 (init/initramfs.c:0)
   >>>               init/initramfs.o:(kexec_free_initrd) in archive vmlinux.a
   >>> referenced 77 more times
--
>> ld.lld: error: undefined symbol: parse_crashkernel
   >>> referenced by setup.c:479 (arch/x86/kernel/setup.c:479)
   >>>               arch/x86/kernel/setup.o:(arch_reserve_crashkernel) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: crashk_low_res
   >>> referenced by machine_kexec_64.c:539 (arch/x86/kernel/machine_kexec_64.c:539)
   >>>               arch/x86/kernel/machine_kexec_64.o:(kexec_mark_crashkres) in archive vmlinux.a
   >>> referenced by machine_kexec_64.c:539 (arch/x86/kernel/machine_kexec_64.c:539)
   >>>               arch/x86/kernel/machine_kexec_64.o:(kexec_mark_crashkres) in archive vmlinux.a
   >>> referenced by machine_kexec_64.c:539 (arch/x86/kernel/machine_kexec_64.c:539)
   >>>               arch/x86/kernel/machine_kexec_64.o:(kexec_mark_crashkres) in archive vmlinux.a
   >>> referenced 36 more times
--
>> ld.lld: error: undefined symbol: crash_update_vmcoreinfo_safecopy
   >>> referenced by kexec_core.c:522 (kernel/kexec_core.c:522)
   >>>               kernel/kexec_core.o:(kimage_crash_copy_vmcoreinfo) in archive vmlinux.a
   >>> referenced by kexec_core.c:610 (kernel/kexec_core.c:610)
   >>>               kernel/kexec_core.o:(kimage_free) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: crash_save_vmcoreinfo
   >>> referenced by kexec_core.c:1053 (kernel/kexec_core.c:1053)
   >>>               kernel/kexec_core.o:(__crash_kexec) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: paddr_vmcoreinfo_note
   >>> referenced by kexec_core.c:1148 (kernel/kexec_core.c:1148)
   >>>               kernel/kexec_core.o:(crash_prepare_elf64_headers) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: append_elf_note
   >>> referenced by kexec_core.c:1390 (kernel/kexec_core.c:1390)
   >>>               kernel/kexec_core.o:(crash_save_cpu) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: final_note
   >>> referenced by kexec_core.c:1392 (kernel/kexec_core.c:1392)
   >>>               kernel/kexec_core.o:(crash_save_cpu) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


