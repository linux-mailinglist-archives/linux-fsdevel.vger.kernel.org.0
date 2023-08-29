Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2DE78BE60
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 08:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbjH2GZT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 02:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233788AbjH2GZO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 02:25:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAC0198;
        Mon, 28 Aug 2023 23:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693290311; x=1724826311;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=OJf1u13fx1dA8c/g/ow0WKeU0lY1CXqIGNC2rUKq8u4=;
  b=b/jyYSqpESfQCW/1916rDZ2iJpOM/8j/dpgkZB9JcqsXX5cIkv/oUFtx
   HGcKJ7PDtDR5HcvWxvj/0R9kwedG1pdCTI6cuxYAJr1y023H0AMQ89GqF
   XCgGz1XkqRsD/5nyIoHnAgnSst9Uai/h1UFqnM5PfPEYLsLjpCcA8LrlT
   nyLrIdCH4jHJQwens8C1EXdUgtD1s/3IwLv94yWC6clDgM3i7E7AVkJtr
   8W4cp9Yhc5UIU4ZxBxRK6VpKeNQp+iE7KtDN0GwAZFkh9acRfszWEnUFA
   6uOz12vHx/N6CSCdOTT6R+vvGn1I2ndrAJzY6itPWopQ/GBzXEAcTVBGT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="374181248"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="374181248"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 23:25:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="767943917"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="767943917"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 28 Aug 2023 23:25:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 28 Aug 2023 23:25:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 28 Aug 2023 23:25:10 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 28 Aug 2023 23:25:10 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 28 Aug 2023 23:25:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBVbS8dVrOVGt/iTiDn5p2HIstnb4yt0auTvbVV0X4EbhZScNf3Dz0AbB9jPlTZE+i+5Stp4V/GQ6QVcDiE9VjPJbjgq+RKPWbgB2SQVkt/yxQEVMR98wbZe8wbbepr9dwHq4zQiS1D1L2UdpC3UekToujqrkoS7PrJO+KhXSCYgKmC+elVoqaJED6x1vg9fzJBO6wUNIFEjddYdIlkSw9oDZm6EKdNa9ZMXXgCPmKNo7uUDfTSzTt9VoqTkFR7OUHEYt41cVNdeDAAM19JF07sd7ONwQQB5ftPfmhjeKMEy4qybK+J+4bO5b+FPdbS+mSmQEIWH62w8o/6H40zO8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVNTNUoOnro7mQU+ySdXC6pviibr1VNWL5y2lKNu0Yw=;
 b=KnwedeS3fEmvZHTVWG3Wy6RVc0ojKSfSYn1M6OmB0XQ2kePOjUSKnXn7YkkfHW8IXTRsNeF+Nyfs/n8lHTknclHSTo1gJIXuraFt8D7g5YF6E8OAAfe7ku+IetbhYxs9uJ5AqxyZqZZE9AgnNTOiW3RkLotM1r6N739r+bUr6IOd+wU2aZKkp3JsjaubXI0Ilj5pu0kCA+bxul48uZdG9dY0p+YjRmKnOeIpdpJzXs8goJUqors/3msPrRF0MRVNsRwdDJflJCju5NF3q2YJnJOapnhxtlPUYcYInbarOqwWbUo3mOz5u3+1gtzxjp7Iip5a1VaQeGPb1XxbYsAEsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SJ0PR11MB8269.namprd11.prod.outlook.com (2603:10b6:a03:478::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 06:25:03 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 06:25:03 +0000
Date:   Tue, 29 Aug 2023 14:24:53 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Jiao Zhou <jiaozhou@google.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-efi@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Jiao Zhou <jiaozhou@google.com>,
        "Ard Biesheuvel" <ardb@kernel.org>, Jeremy Kerr <jk@ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH] kernel: Add Mount Option For Efivarfs
Message-ID: <202308291443.ea96ac66-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230822162350.1.I96423a31e88428004c2f4a28ccad13828adf433e@changeid>
X-ClientProxiedBy: SG2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:3:17::18) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SJ0PR11MB8269:EE_
X-MS-Office365-Filtering-Correlation-Id: 1468896b-5d2b-4914-089f-08dba858add5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: INRdPYtDt0kzfGliW862iNCXz0uU/SP6SAOOqJckvLwKO+DLcCO2RCwhXGIC3CRO3bGsHb93oNWKIV0UpJ4boCyZEzyEeiCoX9fQ1baVQPop55d0a3B1+uzMWqudfLn1xMpt2Oqafr7MhUbVr/tvPhyJ1oYwyns0LGTvnUsU+Msb/PbznwK2nj9PjRelqNw3ofLlDurgIFHgabiimU+V8hXJbTI7YSM9b89LFI52vcEl/e5Ot2Wy1aOjKzSteW7HF4/Lm+Z/n+lFWveofjrlNmpDgTDa30voVzkevIPqlHlnUpqvsQBc5cILgomB9QupIX1jQq2iSLLcPlYd5JxtBkY3hlDsZYm33xDWlFVdv2mm9fA3xh3d1lpiygF16NBerG2iQrxczr/peJfyJVgndiMlh7MOmvKkEySddvMmLICmEy/PW5fAs2S0eH6RE9b43Z5FfASjH8SDcjv3Q7HYHyV8rci1cLcbH8aCygeGw95hwwcUvKEJYXqcUbKixic6uMnzdC75+84l5iBh8JSctqWVTV0Jo8YiHYSkkTyw2Muhv5zoStNS8MDqw5GTwET5RJxCOSboQQDmZKFGtAXiD2d8k3gt1u/4oWDmhlLgwXtrHzSwbtFtGuXa2ekHgQeK9tYh5/tvc7qxOpd41Ev+/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(376002)(366004)(136003)(1800799009)(451199024)(186009)(8676002)(8936002)(4326008)(6916009)(54906003)(36756003)(66556008)(66946007)(316002)(66476007)(5660300002)(2906002)(966005)(41300700001)(6486002)(6506007)(107886003)(2616005)(26005)(1076003)(6512007)(38100700002)(478600001)(83380400001)(82960400001)(86362001)(6666004)(505234007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2Tuf12AUMHw77MxzZ5vQTOb2nUzC52iwr2JE3BL34W6228Mnjt3WAtqGRMVt?=
 =?us-ascii?Q?lZhSxJ6xzeDsEslRtSl5oXvaf8aBcZqbhk7LR5WghXSLQOc9yv8cPYC/by4f?=
 =?us-ascii?Q?4FpK7v1nFzPqlhLeIniMtUucIq9rbSIJs29HiQb8RpNrGIUyxFmEl8hGWnFM?=
 =?us-ascii?Q?A/0p95PLTLtkPebNXwvt3/vlsnOK3WR69OXPeFp+kB4IzhVfVutMMnhmIojj?=
 =?us-ascii?Q?J09+yXApOgCyBFFzsC8zWbonaHjPuBJvlEfqDHuc9eANuzyupxjmwKBiV9o9?=
 =?us-ascii?Q?CZM/WXl0W+RTQR2X3Mk7Dhok6KqyL1MZzXAEZl7+xtGpTDyo8npSbEG32xiU?=
 =?us-ascii?Q?+BU9yAr2cHW3geGAUTNyoCrov+O1Lp5fMMEPCYP2XVSMKFH5ic/E/HKib1Gg?=
 =?us-ascii?Q?yeJaHmB1t46t64tKGQA+Iq3ZZ3Q3ligHs69rv7KfJ6RpUw/zjBIlDLpl7OE1?=
 =?us-ascii?Q?Ze1XYU0VFkdNVdLiw6XEeboC8TSn+hSd0KgVWyK5soXMgEvG/Ydi3dD8qvPA?=
 =?us-ascii?Q?qicQNyy0JPvsnhBjImxoJi21sVycn1+nvZsdez4nD8rIfuPQEalCdaCQgMUt?=
 =?us-ascii?Q?Ro+0BzozvVQURUyGRymrD9gZp1bYTupLzemo3QNqzvHL2+1gVFapv71Pgq/R?=
 =?us-ascii?Q?y1L86Rj80bZsfYm9/49X0VVuXRDL4if8C5GanXyoY3ab0Sm/9sOZzCbBUYF6?=
 =?us-ascii?Q?oOC2fbHOADsA0Jr+YzlOr4dul0eLNzEeSt8SCIuQLAkOocz9CoYXeHU+gDJu?=
 =?us-ascii?Q?1opPNzllIDzliAjYiEjlFU8D1qOv3/op46xKIGZ27gnuzCdwtHodPdRNyx0P?=
 =?us-ascii?Q?je9bg7C1rhAP+42hkocDoadzQloN15rRLB1lgYdgQrZYp80fwwm/8b9R+GDD?=
 =?us-ascii?Q?lkPUsmDtUL8AIYRgrGQT5JMxh2UwKM7et2PjyadvnPOcjt7GxqSEPSsjds2B?=
 =?us-ascii?Q?Dl7NoXTJeAVCauly0hBjONKSj9Ob3Ygf5ZEHp19CbJEzYf5j8p6G5FkziC0r?=
 =?us-ascii?Q?O/BwnDGe05lYzTOYp86Zcv0J3Lvvp0N0D8VRIzvB7R2rcOXUESj8CWf8e8ml?=
 =?us-ascii?Q?a4o16/WIUfDzOk8My+neVejRw3JkE0MZj0XSpa5E+rhCEtLWcBFbDRRECpBU?=
 =?us-ascii?Q?QB4oqwYWkr/c0g4A5mC6JMTtuaVQLoZOInN0qAZgxwhg7I0rjTOjuLVnUPTe?=
 =?us-ascii?Q?0SI+q7AQ/X/66MQW3I5sgu80UwuyuejF3Qkk3JzUZvMX6yFj4KFxXx0rNSBI?=
 =?us-ascii?Q?1ZkcAvHfB2Z9Udi1THKZq7rwVq4TDcauqYVAB+xTGjf74c4CRlqet75AeQSr?=
 =?us-ascii?Q?P+1um9Kt7iZwV3buGy6+h6YzPbd+osLq1POMksD8Z7I014OanLEHNESWQ07/?=
 =?us-ascii?Q?X1JMCxQaBH8i5zhOHLisgGX9a4WfO2Lb/Uss6Zi2Z8czg9fSA64dkHBQpLo/?=
 =?us-ascii?Q?q6fdcfzwhqgGRjQsGXO4mhpFVx9zbo1MgI3WuOvm+UojSHI35ORfC3sMiP+4?=
 =?us-ascii?Q?YO7+6mEXkBkifg45nfCeyJC2w1J1hXCHkIGYzg+JuIlKSUeno5Vt//Z/4G+j?=
 =?us-ascii?Q?YMzeUdgP3nxebOJW2WoaN4K/49DML5S8nWLySA/hC0rYbnF8mb2tBTzgqpc7?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1468896b-5d2b-4914-089f-08dba858add5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 06:25:03.2540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ouxAnunCeWH2YbQ45/KHkQ1GNVjJP5P6QVD3O8n0RMbanUfSqfGsbmj2lcUP5MuT2IudEJvaugroilrWVIRdVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8269
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Hello,

kernel test robot noticed "BUG:KASAN:global-out-of-bounds_in_fs_validate_description" on:

commit: 635056da10724c7af59483a8251f8e6432b50faa ("[PATCH] kernel: Add Mount Option For Efivarfs")
url: https://github.com/intel-lab-lkp/linux/commits/Jiao-Zhou/kernel-Add-Mount-Option-For-Efivarfs/20230823-002613
base: https://git.kernel.org/cgit/linux/kernel/git/efi/efi.git next
patch link: https://lore.kernel.org/all/20230822162350.1.I96423a31e88428004c2f4a28ccad13828adf433e@changeid/
patch subject: [PATCH] kernel: Add Mount Option For Efivarfs

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202308291443.ea96ac66-oliver.sang@intel.com



[   17.276007][    T1] ==================================================================
[   17.277001][    T1] BUG: KASAN: global-out-of-bounds in fs_validate_description+0x1c2/0x1e0
[   17.278097][    T1] Read of size 8 at addr ffffffff84f20b80 by task swapper/1
[   17.278821][    T1] 
[   17.278821][    T1] CPU: 0 PID: 1 Comm: swapper Not tainted 6.5.0-rc1-00012-g635056da1072 #1
[   17.278821][    T1] Call Trace:
[   17.278821][    T1]  <TASK>
[   17.278821][    T1]  dump_stack_lvl+0x32/0xa0
[   17.278821][    T1]  print_address_description+0x33/0x3c0
[   17.278821][    T1]  ? fs_validate_description+0x1c2/0x1e0
[   17.278821][    T1]  print_report+0xc1/0x280
[   17.278821][    T1]  ? kasan_addr_to_slab+0x11/0x80
[   17.278821][    T1]  ? fs_validate_description+0x1c2/0x1e0
[   17.278821][    T1]  kasan_report+0x154/0x190
[   17.278821][    T1]  ? fs_validate_description+0x1c2/0x1e0
[   17.278821][    T1]  __asan_report_load8_noabort+0x18/0x20
[   17.278821][    T1]  fs_validate_description+0x1c2/0x1e0
[   17.278821][    T1]  register_filesystem+0x73/0x2b0
[   17.278821][    T1]  ? pstore_blk_init+0x720/0x720
[   17.278821][    T1]  efivarfs_init+0x24/0x50
[   17.278821][    T1]  do_one_initcall+0xfc/0x480
[   17.278821][    T1]  ? trace_event_raw_event_initcall_level+0x1c0/0x1c0
[   17.278821][    T1]  ? __kasan_kmalloc+0x96/0xa0
[   17.278821][    T1]  ? do_initcalls+0x47/0x5b0
[   17.278821][    T1]  do_initcalls+0x2ae/0x5b0
[   17.278821][    T1]  kernel_init_freeable+0x313/0x570
[   17.278821][    T1]  ? rest_init+0x260/0x260
[   17.278821][    T1]  kernel_init+0x23/0x240
[   17.278821][    T1]  ? rest_init+0x260/0x260
[   17.278821][    T1]  ret_from_fork+0x22/0x30
[   17.278821][    T1]  </TASK>
[   17.278821][    T1] 
[   17.278821][    T1] The buggy address belongs to the variable:
[   17.278821][    T1]  efivarfs_parameters+0x40/0x80
[   17.278821][    T1] 
[   17.278821][    T1] The buggy address belongs to the physical page:
[   17.278821][    T1] page:(____ptrval____) refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x4f20
[   17.278821][    T1] flags: 0x4000000000001000(reserved|zone=1)
[   17.278821][    T1] page_type: 0xffffffff()
[   17.278821][    T1] raw: 4000000000001000 ffffea000013c808 ffffea000013c808 0000000000000000
[   17.278821][    T1] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
[   17.278821][    T1] page dumped because: kasan: bad access detected
[   17.278821][    T1] page_owner info is not present (never set?)
[   17.278821][    T1] 
[   17.278821][    T1] Memory state around the buggy address:
[   17.278821][    T1]  ffffffff84f20a80: 00 00 f9 f9 f9 f9 f9 f9 04 f9 f9 f9 f9 f9 f9 f9
[   17.278821][    T1]  ffffffff84f20b00: 04 f9 f9 f9 f9 f9 f9 f9 00 00 00 00 00 00 00 00
[   17.278821][    T1] >ffffffff84f20b80: f9 f9 f9 f9 00 00 00 00 00 00 00 00 00 00 00 00
[   17.278821][    T1]                    ^
[   17.278821][    T1]  ffffffff84f20c00: 00 00 00 00 00 00 00 00 f9 f9 f9 f9 00 00 00 00
[   17.278821][    T1]  ffffffff84f20c80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   17.278821][    T1] ==================================================================
[   17.311721][    T1] Disabling lock debugging due to kernel taint



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230829/202308291443.ea96ac66-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

