Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7CC79C797
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 09:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjILHEk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 03:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjILHEe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:04:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E1E10D3;
        Tue, 12 Sep 2023 00:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694502267; x=1726038267;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8l1EAd5ygZDNVdBpUd8s+ZgbYk9PI2ZKr1xUgd09Ojs=;
  b=jVqWi89lWRd9Pu5bl6DIh/KtSHZrTw7zqAJAhvmnSPmLJXZJxG+aX10P
   IkF8UUgGGXTpzZvS+bAF2eregaQdcBriTwONhKK6l9CGbu2sx8fD17bDT
   EyT8n/Ou6TaTgMRxY6k6T1UE7I3pEkycTJLel/TbsA77nVmXTQZpZPAT8
   um6scaG01+5jk67wdn9PNgKvqTFsguguruM4VBUGlv9xBEjMOSwh0snEE
   riUWyoqAT8d/C0cLVCd8b+mKXoOeMKGyW3UFkGquzLSCxw9EVbfllfo/B
   ad3Gjq7tXlS17vjXlBGdH972ebFRwE/XXN4+h0/6bCs503oWjhUbxgc4D
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="409247749"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="409247749"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 00:03:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="737022117"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="737022117"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2023 00:03:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 00:03:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 00:03:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 00:03:01 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 00:03:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYz6W7Ncz0kWZwt9DSbPaY6oFsfQkPC19D54kGanu0klvnjn7ONRmtNgi7Jsq0vdFkeInEuIukUXtDbt9PIqB6fHLVO/y2LCK8ky0Iig6ED06q3f6gtm2JmWuQD+scJ/td+QTrJZXAajPdj2PIM9LmRVqg3xpeP0QGLPstzPlziLvttJ/O9ZBzCIxfRpKvRVnwDwRr84TMYDivBwrMPzk8UzbHuIplqyno/6GJoxElnXHzpN5SYkSbIYPg1WQ2wl/8/usbrevwMl3bHm1apWqaCcxBqMlsgJmeZe02EcFP7/7e2u7hzuE23H8KiDjyPG1GveohBE19BRq156Ck8Fdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jsIjr1kIEFNtBhaUsN9mX6xWu2hzcjZvvbD9SRc8lY8=;
 b=fLL5Cl7mPKaDnxsiLKb7Rsio5ouG3qCJeDeC3gzib9dDb9zNoZ4K0kTX17Bcf2N1WY+BZN/aoTCAoLqVYXyLfg/4W5e61mX19gTtiZ8DjiJF/yEce5caCCOWirxxBN21QAWkVnDdGJ4D3Sq/czdl4YG+i/ilDzDCtvWUVXcOxrT+hLTaDSv0eQjoJCJ+NU6E1GL6v4Ywww4QReLe3djeCreNl5vc/BdTHflz/r4S5yHsROjlIUB20f3G8Cw1IcnDLQy8RVLj2hAZFBRzCtAUctrLfq7u4Xat7SYXdIccbXO4KNC2PznHikexHw0pXfgN7aeA9S4GIL4EWGr4eW4jtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by MW4PR11MB5936.namprd11.prod.outlook.com (2603:10b6:303:16b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Tue, 12 Sep
 2023 07:02:59 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 07:02:59 +0000
Date:   Tue, 12 Sep 2023 15:02:49 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Stefan Roesch <shr@devkernel.io>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        <linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [proc/ksm]  8b47933544:
 kernel-selftests.proc.proc-empty-vm.fail
Message-ID: <202309121427.f3542933-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:4:186::18) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|MW4PR11MB5936:EE_
X-MS-Office365-Filtering-Correlation-Id: 59a6ff83-ce4c-426a-5580-08dbb35e4c11
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7638PeqUWpxky1TaPdw+3+9PwRymRvlw1qUAgR1kGJ5Swvxz/SiYJUH6JHiGOdvnp2JsCyUo6R3L0n0pInsBc5Rgypai1OsbWkaQ41Fv0cSg2hYTZvNOAB8tSOZTUVYD2beUQTCxFTYsUlVYxH33cwQ+q5cx91bhVLwJ9/1UaGaDKN6xZEYQjt0KNjG8fsxYGoelH/1i1ouHeWXY7FfEoHX9qIphKE1U+Ps4M96YgrXFnFfG4ifqJ5cEsS8iMaNzEv5E89puUmfQSZZKdH4LCcbiuvs3RYvVBkLtY0DqaLieuU0SP+O4KsTMIBrp7SpwGEhnTtOIiV1QNuZMwjd63lry/+o4vgqJ8xxfVMcpdVTmX0piGqDxt9sBsuA0rARJb27Fh2YUrxW1H0Mxv/BYfbh1AbzvzZVd/ucLeoxo+ZHGbcsyjL93FXvS9loqSVq5zG3bVmjRPezxjjz//uhv2WYG133xQ6LLMYN2AmY0ItKlmHkkXRtTqNimTTVEzzyAoJbLSOFL/NUINteJBYsgX4LFSPTCu4Fz39wcWaSN82iT3NjTBgumFd1RDv39aY/1w8njO9QUXPG/weJ6Kfr02Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(346002)(39860400002)(366004)(1800799009)(186009)(451199024)(66946007)(66476007)(5660300002)(82960400001)(6666004)(2906002)(83380400001)(6486002)(54906003)(316002)(6916009)(66556008)(8676002)(1076003)(6512007)(26005)(966005)(478600001)(6506007)(41300700001)(8936002)(4326008)(2616005)(107886003)(36756003)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DCVwsjgbiifao6+38wgKld6ux1JrBN/Jx0X+06L3gM5tQg9ZT4as6Qvn0jJi?=
 =?us-ascii?Q?Sck0hJBET8Xumk2fcaZiE+x26vOa6ATaECU+hnlyL0VRI3py2fvLbiRDBd+5?=
 =?us-ascii?Q?JyDwi9AAZ2PSSo8A57nwu7q6Tb4v9EoJQZax/1eYQNiwccmehj/0yH8FRBi9?=
 =?us-ascii?Q?B43yvWQTbXxCgqmfePNeNN/U44+fMPzVVBH+Ech3eMgdAqM6HI0xX2qqeUim?=
 =?us-ascii?Q?9aMmeqg0nhosMvxWAWTLFoSVTKjkql0Q/v7MyiFHHmEkxfW3On5dEynp9FQs?=
 =?us-ascii?Q?KcCyaYg/BTuL97hcJQunGKD2ZlEc9KppMi+nRVph0jEZZg/WP7W6bMCRtbLD?=
 =?us-ascii?Q?kuevEPFx7MbhF8D/nJ5Pe2q6b7sIUmEipH8/UnQOznDwokdAd0LaYgXqDrm9?=
 =?us-ascii?Q?5AIY1JCBVD4ujssaF3Y4mzJsHlNQvea24tuJH6er4ZqLbjO3Ryc84B05K2Cf?=
 =?us-ascii?Q?P59VH0Kx42F5YttpJll7MfoJZwY7gGtRMwXv5TGU31Xp9neOqydNLuxbz8AD?=
 =?us-ascii?Q?P49qNhgaRMkxXG9Uy6mJO07zdgyi1Z3pAyNcsnKd+d7877zDbij5mhIZaKAp?=
 =?us-ascii?Q?wRlBF/x0zTvMAYrpeCqMucxWTdGQg9vZ6dxGWRzPrGWXSToWjmCFJzgV7k5b?=
 =?us-ascii?Q?/4h8Ccs+ULqSRmM0nsbslJGzzdRuYvP3MPPwCoz7uY3Xk4C5U6S1OL9CI/x4?=
 =?us-ascii?Q?8FIbXBkZPvkPJDTLDDgg0lRApiZjd/IFPl6iJioGO82chYEsXanu4t0QRwsw?=
 =?us-ascii?Q?Ab+XB6hb15tsb/cbVre177VFRxPQcYLt7eyMx2gMZiXoYRsvTD2MunF8tvCz?=
 =?us-ascii?Q?aWFbIwueygqX+DAecf0nRBaxkfBKuAbuopjTwaRX4dv4XblpPDkt8O/tFvcL?=
 =?us-ascii?Q?QUV9kHDCQtYdPKtL892DCLk15TriCrxrkmUDXuFQKamTrnWCp+WLjjfaTqU4?=
 =?us-ascii?Q?T123Z1cXHqzv8MJT8mGhOBP0PQ4/51LZn/9Rgh3SNMNPKWkBCl8vh5B3Nj4N?=
 =?us-ascii?Q?/41PrL7WHk5c+b4H5gwE+yKOP+SP4B2aXBn5jBGPnEPvfpvPnbZuuqzdsChW?=
 =?us-ascii?Q?CLLEcz9aTlpWampeXiiAU+dBKDaP8pVaUsXvXlSh/sU+VEWj7TLaY1UP7nKD?=
 =?us-ascii?Q?JFOe5hgX6pwZYV//8bnoRcUtZDU+yjtnjxqsJWqrIPy1uEt9UFfKWKqa8+lw?=
 =?us-ascii?Q?ByByR1cwQ+OUQ4MvbpcX+4WykXfqBKYfR9XRLZND/NHdENKiXbflwwFw7pHG?=
 =?us-ascii?Q?/HDOkMCyu4Mqkb/SM2quIx6MAy1V4z7Pa/WbUk8riROop/23RtMjiu8BaLY/?=
 =?us-ascii?Q?RwcV3/6CHPbY3MANBRPlj6hkrG8bvtfQmOEy4ojfrBSph6zwKfg9qVXDs8jX?=
 =?us-ascii?Q?ZwqrI82K+dfgGR1Z/Mb7LjFBqLx0DpWKhR2rhkdvuByVss0Erd1UKHf6Rd3C?=
 =?us-ascii?Q?26ako92ktbRtDkWtUKxRQVIu/JyhZ5dFsFby4cthpXGnVIVdwJaJKdqMXSXC?=
 =?us-ascii?Q?W3udxY5JgfUxKDDxxWskhpDV0DNQuh5f/ze3ckXBJAZOwgZjrouZZ9tND8qc?=
 =?us-ascii?Q?KS5QxjTlbyzdgIQuW9Yo6TDq/vzuUq388r2VVV6sf8FDMUSa++vzGbRJOYvN?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a6ff83-ce4c-426a-5580-08dbb35e4c11
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 07:02:58.9439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iYSjxSPaKuEv+L1N/KxxJ4wT+eSMMreCTtzEWK4vD4Y4E4SLFLxbq1c72YMzcF2ZAQ3Fa+tThPI/ttMUn/rc0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5936
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Hello,

kernel test robot noticed "kernel-selftests.proc.proc-empty-vm.fail" on:

commit: 8b47933544a68a62a9c4e35f8d8a6d2a2c935823 ("proc/ksm: add ksm stats to /proc/pid/smaps")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master 0bb80ecc33a8fb5a682236443c1e740d5c917d1d]
[test failed on linux-next/master 7bc675554773f09d88101bf1ccfc8537dc7c0be9]

in testcase: kernel-selftests
version: kernel-selftests-x86_64-60acb023-1_20230329
with following parameters:

	group: group-02



compiler: gcc-12
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202309121427.f3542933-oliver.sang@intel.com



# selftests: proc: proc-empty-vm
# proc-empty-vm: proc-empty-vm.c:292: test_proc_pid_smaps_rollup: Assertion `rv == sizeof(g_smaps_rollup) - 1' failed.
# Aborted
not ok 5 selftests: proc: proc-empty-vm # exit=134



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230912/202309121427.f3542933-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

