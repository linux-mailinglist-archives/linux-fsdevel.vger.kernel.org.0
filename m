Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC1E7A4D6F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 17:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjIRPt4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 11:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjIRPtu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:49:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BFEE7E;
        Mon, 18 Sep 2023 08:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695051998; x=1726587998;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=vU9OgrSiPr3dY8+aGnQ5CSdKgXm/Hs5ApFOQREUdylY=;
  b=KTQv8EqWikn5KswiyptDCMvFdJXb0YHD52/SJlgzs6S5+TIN/MjXoeNt
   bHfIb6zW5n7w4q8PDut32EJgBNl8YMMS7ljUVBWHiwAlwgN6bgHolhzWP
   3fXKJjIf7AUgXsJ1MwZOSYanIKKv58nzCAVj3A1gM1UgXOLdbYppef9f8
   /32/1m+qz7aAr7My89W4BIBELcUuBQTqRwb/VFyLzYY070b/Ac6PuHOSO
   7HktHEwsqXkh0MMm/+yyayPompCuhFkt7kup/mluYgMm2hXHpcuuyfAxT
   6UcsMzeVVmSg2WldzlUd9VdgVpD4M0HsZgarfOge5GOyY90/sLXgqZbfS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="446129876"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="446129876"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 07:11:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="739145124"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="739145124"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Sep 2023 07:11:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 18 Sep 2023 07:11:58 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 18 Sep 2023 07:11:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 18 Sep 2023 07:11:58 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 18 Sep 2023 07:11:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7oj5sx23377IGmjFYXx38ctcbM5IFTv5usahnVCAz/vzORkqD3yp//OKfYNxg2PiRDgcpWM36LncoXG+q+VC3e65tJ7qVwWDHmYGWZ5lxWKSDyZFcpjcf7khaHTWtC5JYQ2z1hVshQbpGu7Kqd6R6sGojLEX/L45TTx4Htm71NUwo3UgXEFuCwqNA5tiBD6JmNmUiCtD4M5I+XOv9vyRwr5Hg7Mr05/ZgRYOvENANooEIWSLyKB0TdLyR8QdoYmlzwQuYpE5zmRG0vz6zX+npPoHAlMCKDAcB/ya9wy7FLZRY+RoOwuWqw2etn/M8ZifELhaW/XnyIzc/E5DYn5fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sl7TbGLZI9NivIimUvvZ1FdKXENi/lp5NmrNNWp4qv4=;
 b=RJlL4L95kYzZvI1GgMwDUWU3fNjpMy01QNXE8qZHrt4wzSww4TZb5prt65172ivK9t1CBc7nIV9q6pcKnQHc+uM1P63jCXRcLOATnZ8swOnbssmkMSdQFW+HPO1yFWfVzdoVTdSZGmDKOq5dtR/dJ1wd/fTWVzuCW2IbD23EYwYzahOxqGi45Y+jFvoWYX3fJVG8ZqgZ971I4C8Dm3ml3ZNxxNdPHQTW7YKf7wV6jg36nlvKXUaVYtIAYqaUko0ePwcFvtYVhZgx1yOJZEPaIMcmCef52rXSqPCwF73Jst2jLaQdTumGbbWigJCv9Yx8ZEdDU4CtBKCJ9Jo+tzAWOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by BY1PR11MB8029.namprd11.prod.outlook.com (2603:10b6:a03:526::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 14:11:56 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 14:11:56 +0000
Date:   Mon, 18 Sep 2023 22:11:43 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Sebastian Ott <sebott@redhat.com>, <linux-mm@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Eric Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        "Mark Brown" <broonie@kernel.org>, Willy Tarreau <w@1wt.eu>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        <oliver.sang@intel.com>
Subject: Re: [PATCH RFC] binfmt_elf: fully allocate bss pages
Message-ID: <202309181644.1932ad53-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230914-bss-alloc-v1-1-78de67d2c6dd@weissschuh.net>
X-ClientProxiedBy: SI2PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:195::15) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|BY1PR11MB8029:EE_
X-MS-Office365-Filtering-Correlation-Id: dff7389d-2077-4cad-053a-08dbb8513715
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LlF1sCp67DdWO6UHaUS7w2DjvMRPsuzVtmM7QKTBIjH4Kecj3Og7W17gEQXdM40E/odgnuCHnNpPfrmFojoLj6BYRJEqFMfnjcLwNmURPYkFFuQI4cR/fpJzfr5PWg+TPYz0tiLTTIvuaFGsUSMq0B3B06/GF1bTUc0zQ7bdfiW+bSm3+ngnqilRFSpatkMYNXkJh8sjbIcdiDwU9Usyt7hCl8zTOSSvUp5Wy3jNRdR+tuFNzdclxcLjrZDD4Lbjt37HMJzZRx3OcYEhY/l0ejMrDwMyr5vVE6A3IFnBoQXof5aa58BZIfqMTEcavoaehC+3iCcqRIBRnqwYnM3IKHZbioxJb5bEPzh192Nqaw4jwbaYm2VBfIK0MPftjI2NG1QdGFZh+m/1yzNQ0a98/0+oc7I10O/ZHGDYv5yU6OfZQoFcCv/DX5W+40Z+sSn/Tx9dhz9dHNbtX99Rt0pUwJRAX2tfmuBYm82Rr4LYa/x5xY0Fd4RwcPOmMa1qs+nLpbLJ/gFo1/vvHjDMe8lbUMV7Fnw0VZWOcemh205yjDoXl2dwSexkp59NOK9clLHLV+CJPvWBZblrM4vhJZDflQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(346002)(39860400002)(186009)(1800799009)(451199024)(66899024)(6512007)(2906002)(54906003)(8936002)(41300700001)(316002)(36756003)(6916009)(8676002)(4326008)(7416002)(5660300002)(66946007)(66476007)(66556008)(2616005)(478600001)(6486002)(6506007)(6666004)(107886003)(1076003)(82960400001)(38100700002)(86362001)(26005)(83380400001)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oZfCko/hUUFrhdaYS/7wbiGwNsd3k4xKGx4fUWb/is8VtWdqc+but4F6CaKf?=
 =?us-ascii?Q?UvBq077EV3EQtYFXMEWh4DgqhZpSV28Pt2693a1ej5qw3STm5velQHz4xKH4?=
 =?us-ascii?Q?3CCHZ+r7KMbUrVh87wHr6lWKOcsjDk8PGuHdbPKcufYBwx6w10EZjceXZDGV?=
 =?us-ascii?Q?OofH4XjKBGXSQfNa09+OiPg+9hserZgLeubDBaarirygCbalep0LQGtsZio9?=
 =?us-ascii?Q?twrJAwCRT/OUFlqIa8Issaa8iGSlRh2mmLXs2shu8k3//uzeW/WXl8z8UUf+?=
 =?us-ascii?Q?VpDtUadug4V4qIXIjJJSrMYuDf4dHppRMfbzBQiEE9BriC5k3++fdtIPAbp7?=
 =?us-ascii?Q?49UitE6clIg3tMCRAvyQswXUxBCsPJ6b9YDE3k/oeNHrHCFxTD1USlhIFfaP?=
 =?us-ascii?Q?1i4GqyUMnv7OIG2yiwNX5hI0ihchicgp1hgvtPsp+zf02LTqk3RsULqCnzI3?=
 =?us-ascii?Q?wW2pW1OR+dpQyUYYBi2eaSEz28it8tsUTgXqzEylqIBsmM5Ry1D8VgHcIcAQ?=
 =?us-ascii?Q?WxgHkqoyqk7zBEI+53pSjempHWkwtN3Od8EiLQ9vqDzR+QR+s9G1wsHNo0CR?=
 =?us-ascii?Q?bFgdlybjJ8o76CqYWjsERX6+C5hpRfJzjLp4qxNcqe4Rl1iSoNz/6zqP2oDt?=
 =?us-ascii?Q?tSt1f527Kc5+A/H3s/hmjlmR0EBVF5W0UlLJfzNhOigiGbHLDNRdsXhnGpZS?=
 =?us-ascii?Q?2xHlcjNMgKW6qRA65vrPjnS63YmQRZRJf3cADJ5S1KVvgQs5k8kDy2EqKU3h?=
 =?us-ascii?Q?HUN0errKuQ3iqNkhqMOuzNBevZzReBOXVSVrANS67Dx/eEZbks6vhRslOs4p?=
 =?us-ascii?Q?j+d1pP7u59iULHFYl0X1VqoGppbXpBX8xm6jkmThAQSJhCxtr+eHcZ1nZDxX?=
 =?us-ascii?Q?x02UHnYWa9MTWic6wTQLTlqrCj73LuQd8oYLqxleVjRRz1BGqE+UT5IxQdJ6?=
 =?us-ascii?Q?ifDAuVEsjIhLXJ+9xJJazIJdwEmqtSZl73hPsx3AbHPTBQ0v+zXS/awaV7ik?=
 =?us-ascii?Q?19wLVz7BzVcp5V2U5wwW3gJYTwWHb8qL9QQD8/+uLcXeFieDj6/lhtW23ghN?=
 =?us-ascii?Q?zNp6YRWO9J9jKtonyi9vOtqkTl5K4Q2rKsuxrX8tEYxu0DVgnMfBUgmy+eO2?=
 =?us-ascii?Q?RKim2fFt5Sx5UoM3EMOmpd4Oqccl99URu6tlCwsyw+w419kPzZWD1OZRd8Av?=
 =?us-ascii?Q?foUbTr7ruRf10xkXbuqljR/N+hX29hO6saZvW68Xnj50ML/CZ/6RBk5YwoC6?=
 =?us-ascii?Q?zN/UCMWh9d2aZE4T3oHyMmuzbuB4jODqgUmzNh+aWIKyKzBlZ2D1dH75zDYF?=
 =?us-ascii?Q?4IKl2rilR73kZrHqRFLBy2/X7UBKeNaHfNC4FYh3B8IpeEDkUxvbTap/1bzJ?=
 =?us-ascii?Q?66pn3QZDfDf3Sm2e4/GOF+v/xLrZYRpRx6ErEICr2owCzprL6pgSkuJbuwPS?=
 =?us-ascii?Q?LGc4zVg4bFATZclFCaXUa3nggR1W2xz1Yew6oU9nB5UkhGvaRBVrggDHP0fV?=
 =?us-ascii?Q?oG+rG5FfnJlVuRz6HxD3ZaGsZQmBh+db3Ritv9cKOaOhFE/vzQljEcOimuWE?=
 =?us-ascii?Q?pi2ekBP6D8m5VA4DtRdRWAjUGQ4CzciTxadyMCSI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dff7389d-2077-4cad-053a-08dbb8513715
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 14:11:56.2445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/6tFZ9R9pUzSjo11r6qsSUjQheH0WzEkeXGXSwYabt5xSTfamwa8WK2Ai4rdVXwln/6zKQ7Mv/N6PKFAn/Vkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8029
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

kernel test robot noticed "segfault_at_ip_sp_error" on:

commit: 13bd7a228b281e5cef2f51a236cafaa3400592a5 ("[PATCH RFC] binfmt_elf: fully allocate bss pages")
url: https://github.com/intel-lab-lkp/linux/commits/Thomas-Wei-schuh/binfmt_elf-fully-allocate-bss-pages/20230915-000102
patch link: https://lore.kernel.org/all/20230914-bss-alloc-v1-1-78de67d2c6dd@weissschuh.net/
patch subject: [PATCH RFC] binfmt_elf: fully allocate bss pages

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202309181644.1932ad53-oliver.sang@intel.com


[   11.004901][    T1] ### dt-test ### EXPECT_NOT / : WARNING: <<all>>
[   11.005947][    T1] ### dt-test ### EXPECT_NOT / : ------------[ cut here ]------------
[   11.006784][    T1] ### dt-test ### pass of_unittest_lifecycle():3252
[   11.008735][    T1] ### dt-test ### pass of_unittest_lifecycle():3253
[   11.009666][    T1] ### dt-test ### pass of_unittest_check_tree_linkage():271
[   11.010598][    T1] ### dt-test ### pass of_unittest_check_tree_linkage():272
[   11.011531][    T1] ### dt-test ### FAIL of_unittest_overlay_high_level():3542 overlay_base_root not initialized
[   11.012852][    T1] ### dt-test ### end of unittest - 303 passed, 1 failed
[   11.022721][   T39] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[   11.042019][    T1] Sending DHCP requests ., OK
[   12.032757][    T1] IP-Config: Got DHCP answer from 10.0.2.2, my address is 10.0.2.15
[   12.033736][    T1] IP-Config: Complete:
[   12.034229][    T1]      device=eth0, hwaddr=52:54:00:12:34:56, ipaddr=10.0.2.15, mask=255.255.255.0, gw=10.0.2.2
[   12.035554][    T1]      host=vm-meta-36, domain=, nis-domain=(none)
[   12.036331][    T1]      bootserver=10.0.2.2, rootserver=10.0.2.2, rootpath=
[   12.036337][    T1]      nameserver0=10.0.2.3
[   12.038817][    T1] clk: Disabling unused clocks
[   12.041570][    T1] Freeing unused kernel image (initmem) memory: 1036K
[   12.059292][    T1] Write protecting kernel text and read-only data: 10632k
[   12.075444][    T1] Run /init as init process
[   12.075883][    T1]   with arguments:
[   12.076211][    T1]     /init
[   12.076481][    T1]   with environment:
[   12.076818][    T1]     HOME=/
[   12.077095][    T1]     TERM=linux
[   12.077397][    T1]     RESULT_ROOT=/result/boot/1/vm-snb/debian-11.1-i386-20220923.cgz/i386-randconfig-016-20230915/gcc-12/13bd7a228b281e5cef2f51a236cafaa3400592a5/5
[   12.078684][    T1]     BOOT_IMAGE=/pkg/linux/i386-randconfig-016-20230915/gcc-12/13bd7a228b281e5cef2f51a236cafaa3400592a5/vmlinuz-6.6.0-rc1-00073-g13bd7a228b28
[   12.079910][    T1]     branch=linux-review/Thomas-Wei-schuh/binfmt_elf-fully-allocate-bss-pages/20230915-000102
[   12.080775][    T1]     job=/lkp/jobs/scheduled/vm-meta-36/boot-1-debian-11.1-i386-20220923.cgz-i386-randconfig-016-20230915-13bd7a228b28-20230917-97632-11h3y6y-5.yaml
[   12.082051][    T1]     user=lkp
[   12.082345][    T1]     ARCH=i386
[   12.082639][    T1]     kconfig=i386-randconfig-016-20230915
[   12.083177][    T1]     commit=13bd7a228b281e5cef2f51a236cafaa3400592a5
[   12.083743][    T1]     max_uptime=600
[   12.084074][    T1]     LKP_SERVER=internal-lkp-server
[   12.084522][    T1]     selinux=0
[   12.084820][    T1]     softlockup_panic=1
[   12.085181][    T1]     prompt_ramdisk=0
[   12.085551][    T1]     vga=normal
[   12.117728][    T1] [1]: RTC configured in localtime, applying delta of 0 minutes to system time.

Welcome to Debian GNU/Linux 11 (bullseye)!

[   12.189049][   T58] process 58 ((sd-executor)) attempted a POSIX timer syscall while CONFIG_POSIX_TIMERS is not set
[   12.234253][   T63] systemd-getty-g[63]: segfault at 484771 ip 00480047 sp bffb6e4c error 7 in true[480000+1000] likely on CPU 0 (core 0, socket 0)
[ 12.242969][ T63] Code: 00 00 00 b8 82 00 00 00 00 00 00 34 00 20 00 0b 00 28 00 1e 00 1d 00 06 00 00 00 34 00 00 00 34 00 00 00 34 00 00 00 60 01 00 <00> 60 01 00 00 04 00 00 00 04 00 00 00 03 00 00 00 94 01 00 00 94
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 b8 82 00 00 00    	add    %bh,0x82(%rax)
   8:	00 00                	add    %al,(%rax)
   a:	00 34 00             	add    %dh,(%rax,%rax,1)
   d:	20 00                	and    %al,(%rax)
   f:	0b 00                	or     (%rax),%eax
  11:	28 00                	sub    %al,(%rax)
  13:	1e                   	(bad)  
  14:	00 1d 00 06 00 00    	add    %bl,0x600(%rip)        # 0x61a
  1a:	00 34 00             	add    %dh,(%rax,%rax,1)
  1d:	00 00                	add    %al,(%rax)
  1f:	34 00                	xor    $0x0,%al
  21:	00 00                	add    %al,(%rax)
  23:	34 00                	xor    $0x0,%al
  25:	00 00                	add    %al,(%rax)
  27:	60                   	(bad)  
  28:	01 00                	add    %eax,(%rax)
  2a:*	00 60 01             	add    %ah,0x1(%rax)		<-- trapping instruction
  2d:	00 00                	add    %al,(%rax)
  2f:	04 00                	add    $0x0,%al
  31:	00 00                	add    %al,(%rax)
  33:	04 00                	add    $0x0,%al
  35:	00 00                	add    %al,(%rax)
  37:	03 00                	add    (%rax),%eax
  39:	00 00                	add    %al,(%rax)
  3b:	94                   	xchg   %eax,%esp
  3c:	01 00                	add    %eax,(%rax)
  3e:	00                   	.byte 0x0
  3f:	94                   	xchg   %eax,%esp

Code starting with the faulting instruction
===========================================
   0:	00 60 01             	add    %ah,0x1(%rax)
   3:	00 00                	add    %al,(%rax)
   5:	04 00                	add    $0x0,%al
   7:	00 00                	add    %al,(%rax)
   9:	04 00                	add    $0x0,%al
   b:	00 00                	add    %al,(%rax)
   d:	03 00                	add    (%rax),%eax
   f:	00 00                	add    %al,(%rax)
  11:	94                   	xchg   %eax,%esp
  12:	01 00                	add    %eax,(%rax)
  14:	00                   	.byte 0x0
  15:	94                   	xchg   %eax,%esp
[   12.256651][   T62] systemd-fstab-g[62]: segfault at 0 ip 004a0004 sp bf81264b error 6 in systemd-fstab-generator[4a0000+2000] likely on CPU 0 (core 0, socket 0)
[ 12.257967][ T62] Code: Unable to access opcode bytes at 0x49ffda.

Code starting with the faulting instruction
===========================================
[   12.266578][   T60] systemd-cryptse[60]: segfault at 0 ip 00453004 sp bfeefa7b error 6 in systemd-cryptsetup-generator[453000+1000] likely on CPU 1 (core 1, socket 0)
[ 12.271885][ T60] Code: Unable to access opcode bytes at 0x452fda.

Code starting with the faulting instruction
===========================================
[   12.276875][   T61] systemd-debug-g[61]: segfault at fffff000 ip 00464004 sp bfd3675b error 7 in systemd-debug-generator[464000+1000] likely on CPU 1 (core 1, socket 0)
[ 12.278229][ T61] Code: Unable to access opcode bytes at 0x463fda.

Code starting with the faulting instruction
===========================================


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230918/202309181644.1932ad53-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

