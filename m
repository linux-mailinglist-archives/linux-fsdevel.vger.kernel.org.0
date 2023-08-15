Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE8D77C874
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Aug 2023 09:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbjHOHTm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Aug 2023 03:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbjHOHSt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Aug 2023 03:18:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10B0E5B;
        Tue, 15 Aug 2023 00:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692083927; x=1723619927;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=5XpCcFJpJi3Z3d17NMBNJeyregEfUJc2G6U75fGVvEM=;
  b=Wlex80kYy9oPsLRAGki58KzEEYFtg/+ejRjQrbFxyrB02JAKH7f2paNz
   E4s8OtueFSX1JCqkQIWPNSKmqgWZxp03btnBc6tneELEF2uHtu+bXLgzG
   6mNyAYcylXXjFxiFwadkWS/l2ItNEXLZSpum4oJp7aNUlZo7JAyOy4kVd
   NMI8wAukz9Jl+3qigq41cxy7UAl6M/GyN2LfVmGK8ZTRLYLX1DWsF3WMo
   SOo/tfjERn7eH4lQVvBE8EhnNue+wfHwtRHPr/mvcZomverwrxSQyoyuR
   nj4DPrlL984kGuDyKqi8qubrcBfDaUT8zslc4wkov11Vj0qaETT+ENyWO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="371127868"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="371127868"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 00:18:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="727286875"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="727286875"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 15 Aug 2023 00:18:42 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 00:18:41 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 00:18:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 15 Aug 2023 00:18:41 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 15 Aug 2023 00:18:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfqcHLtEmj69W+tahLxvCMnsssBPNAwonMeYlFpsfIIRwnV4zrIgruj7p18W3DB+y491vcFKQYcx7sWGf4hTlTkSrlZllvMxIanREOWrJD4Bhs4k0MVPXZD4Ne2XNkZ4XDPZDQvux9ive1y05nAnytEim8ngzQsU8e0V+yBQAGbSJyGR30EaqW6hctFLPNzu/xPVHMdlKQLBIDfzL/bzjCuv7sKn9Bsviq1SLhjxe8qemopkpWGC3v7gWaH982KmpT0/eTmoWyzPUYzqvNUEkov4g8VD2fbOI0upw6iUgUrhsATYmK8EvgCTkCOysFmWFiUafZxp6LpEa68T4C3mSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCoC7YmrLtu+Dzez9a/9KLf2r18pMmkP0ftv9FnBbLk=;
 b=EIsfLnWdWI1O+vLhtfyWar0gRMFxqvWR+edcDrtOwl5BfTLc8gqZsgzv0wlxqZrwMufVWnCgnYoqxyB6lhS4LaCncWdtlW1nmdBlubANfMa7wT2ijA6knMAJGE2gTQeZNOWiu69eOZmWEdr0ZwQJOT8duZCnM2eRSysKSVVaIg671FlH38sVJqYOILvRDJjYQqgPgbhHyMoV40Gc54QXWLCr3qE+/nuTJz3hmeeRWyHOcxXBErt8SoeC8buVRdnnQOrvfWUF9KQajVLRybs7d+cvXx2t/Msghy2nbwBCC3rSsPu0peIM82bQ4DwGuvJjv29o7FZBWdv+fmVIPdd13w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SA1PR11MB6735.namprd11.prod.outlook.com (2603:10b6:806:25e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 07:18:39 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 07:18:39 +0000
Date:   Tue, 15 Aug 2023 15:18:22 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Michael =?iso-8859-1?Q?Wei=DF?= 
        <michael.weiss@aisec.fraunhofer.de>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-fsdevel@vger.kernel.org>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Christian Brauner <brauner@kernel.org>,
        "Alexei Starovoitov" <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <gyroidos@aisec.fraunhofer.de>,
        Michael =?iso-8859-1?Q?Wei=DF?= 
        <michael.weiss@aisec.fraunhofer.de>, <oliver.sang@intel.com>
Subject: Re: [PATCH RFC 4/4] fs: allow mknod in non-initial userns using
 cgroup device guard
Message-ID: <202308151506.6be3b169-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230814-devcg_guard-v1-4-654971ab88b1@aisec.fraunhofer.de>
X-ClientProxiedBy: KL1P15301CA0050.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:3d::16) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SA1PR11MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fbfb083-daad-411d-54c9-08db9d5fd911
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 44H3n5vx449/oLlV0+twlwORdMCQGl5Cb3URYxDTOkJYFI+6wk5Q5wDf5Kn11vh735M8YwqB+9bGzRm0sOOcH8qm2672hV6YSLgoB/sc2Am9P4lfpkW+sM83UcryX699aXAU7vgAHEWozp0iZWd+UfDKZj1ie3f5rYXcZtPf5ECNWOm0cMVpBqiMzLI99UiMKnbtHEQhUDoPsns/BN9lxwV6Qrm4hvHZzmBOSQWo5CsIRVxRja77Sp8U7MWmdHvs4FrMkqfqb9IDzO0wtP0xFvBiWF1C+jV6kYuasAh4w/GneEZWM3QrH2O3xxjFWPc6SHGQJbcJ+oMRhrs58y17MRiZCetBUp5vN4FEBLmU1UaR0zWgOrWxsmRnMWsdIUfqdNQBAxayeKQsQ2Sw2nV0nHwm2LIqKf+bLy54X0dzaNEslNOcTPUD3sL7oFPI0FuFLsCMqrdb8/TtdxCPCOYih0KKiqzWKDHxMoXUOyGA6F0syJxB3Xu14nxr1SkhZ68p2K2AMj0mtsDpiRwcyEjOHhzEfN47wf4dkQi1jyhj1W1Vglqy3M8jJOand48c661goE+/KpgCE/ooTUEs9gfZYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199021)(186006)(1800799006)(1076003)(26005)(107886003)(6512007)(2616005)(83380400001)(6506007)(41300700001)(54906003)(66476007)(66556008)(66946007)(6916009)(2906002)(316002)(5660300002)(8936002)(8676002)(7416002)(4326008)(478600001)(6666004)(6486002)(966005)(82960400001)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M+uhBqSjQmM7DVkZ88wUUon3wJOS03Hk110MbPREd9i7zX6D55SeLwBdgjgA?=
 =?us-ascii?Q?QToF60IicHaY6pjrfPkpzN68o9eYqqwbR9tmasMyiFLHi2gm0HK78LVgyc+o?=
 =?us-ascii?Q?ZlaZYBuNt0Ur8kVCjYKtfdRgm52Xt5v1FifQkUGGGdfYp2rajEIyY5VBSxoV?=
 =?us-ascii?Q?FpVk2e7XOLeLsfHDWGMKmjRILsvSP556xx2G89d4qXDziHQz5KcTN5KqqyXl?=
 =?us-ascii?Q?7JwBXzzTibg9whAtekQKTYAluabZGMjc5UT0D1SVRIGid9EqqLr5hcI24d4D?=
 =?us-ascii?Q?kG3Fjeq47XvywPQzRnQEZcbZisuQvxoanOSdcwJC+6m5B2X4N0CdYvte0NBA?=
 =?us-ascii?Q?N5PCIC7D1X9GJIkLumJfULALhINNYzYhm6I8KoE0PHaFkd8yJS9bP5W66COk?=
 =?us-ascii?Q?C4Go21eBVcAF7WcZOzpejIi5iUV3Y6oCXm2K/y03Ntqn/ouU8GvAjgwJ4azs?=
 =?us-ascii?Q?yMnw5dZ72i+ex86PX8WS+6bKMdBtas3szEqoUScPuO15Tp2DNBrv+lw6U+rE?=
 =?us-ascii?Q?85VEFBqITJyAVc+Y00xNpkBmLVhng7329A9mUMF3UCKn0TFgSJV7YMRnwcTQ?=
 =?us-ascii?Q?pmwADCYKIrP5s+UGtkCed5wwF5WFzDaGYawpmKgbtbUeK/q1BmD+CRW1+Qas?=
 =?us-ascii?Q?8Yz+OtwX+hBFy8+Aaw0wQIR2CdrF3VhyXvIv0sPi31qYxIcM8Yv4I2tww0O8?=
 =?us-ascii?Q?ryR73wycoXTHs1Lt/PP5RVMvYJZa3lYkIAYmhoj5xz6brbLVVSUDguNi71Vo?=
 =?us-ascii?Q?mJt4KCdzq28wSD6ySIxFsMdijJ2lb+MOPdXuhMvzPjIon4dPQfbbqIOg5rNq?=
 =?us-ascii?Q?YWqEdE1W3zWy5Qv5XbpKvjyzZJASJ2xF36r54cz24jogL4BBR9WDcETaIZyx?=
 =?us-ascii?Q?r0NR/1nch+Q7xIsctQhIdDEYVa/KPmGOHovgWcs++HCGa2rN3Yta/aORTnMh?=
 =?us-ascii?Q?BE4yVKGy/jq2w7YzJHmX9hyyAMTI0Gc5aWTPIr8ne1X7EA6JkD1AtDy6G9Ut?=
 =?us-ascii?Q?bCFOwz+TUZceKb69xB3JfoT6lJLQgl6WQQib92rS7hGqhymhBmGpgdOsM/1Q?=
 =?us-ascii?Q?BI+jsj/ouzqhhtvHBbTEYcSaXqNUPs+P5PIh7VwBbzvJUuPWzoZzrsybPm7e?=
 =?us-ascii?Q?RXwW3uyRy7YdAdbl0w7Vi3Tba5gh3TJeIGQCZCIOZrlLSsTPVJMUnwf4r4u5?=
 =?us-ascii?Q?fGDvnlJkOXhZ25bRTNf91C+sEkQUj9Yh5VQfyasUImZJyJ/+gn39+QP5mBpY?=
 =?us-ascii?Q?3oXxS20j2+SdgIuZ4V5INPOf65md6xJ6QGAlJX7OxcWLdGO+8Hrno6vaVT5q?=
 =?us-ascii?Q?Uh9UnZxNG6LsiyvV44oSboqoDr2t9kxB+/X5H+vIRh3OYLyRsVd6IG6qEgOq?=
 =?us-ascii?Q?QF5F/b7xhaV5CezWYn8g6yKgJekD5DRioBIZFSRGDVuUBsJgNK2cYUq8NkSI?=
 =?us-ascii?Q?6WxjWPIOs/IM5mCqPTXzs51l/TJ7Ej5fSgEGTioxbaA/CVH7JA6tnlTA6JYd?=
 =?us-ascii?Q?R54WW878qth5GFdhWsJ6YMksi8elgZnoDkoLtSWPIXE5+dDSAJWYkup6Yj6q?=
 =?us-ascii?Q?UBTwqwuJfqkKIGtpBy8Od07vZxFwKFhscrZ5g23KpNREHZX0PfiSZwlD5cBI?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fbfb083-daad-411d-54c9-08db9d5fd911
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 07:18:39.5475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eT11Z7SQssxRLOfkk3UU9qTU4BwCjWNbbN3D/0MfnXZTQxGPH/7vXBalyhMqZZzeOEHAe9MQsRRWOb1+rc1H8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6735
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Hello,

kernel test robot noticed "WARNING:suspicious_RCU_usage" on:

commit: bffc333633f1e681c01ada11bd695aa220518bd8 ("[PATCH RFC 4/4] fs: allow mknod in non-initial userns using cgroup device guard")
url: https://github.com/intel-lab-lkp/linux/commits/Michael-Wei/bpf-add-cgroup-device-guard-to-flag-a-cgroup-device-prog/20230814-224110
patch link: https://lore.kernel.org/all/20230814-devcg_guard-v1-4-654971ab88b1@aisec.fraunhofer.de/
patch subject: [PATCH RFC 4/4] fs: allow mknod in non-initial userns using cgroup device guard

in testcase: boot

compiler: gcc-12
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202308151506.6be3b169-oliver.sang@intel.com



[   14.468719][  T139]
[   14.468999][  T139] =============================
[   14.469545][  T139] WARNING: suspicious RCU usage
[   14.469968][  T139] 6.5.0-rc6-00004-gbffc333633f1 #1 Not tainted
[   14.470520][  T139] -----------------------------
[   14.470940][  T139] include/linux/cgroup.h:423 suspicious rcu_dereference_check() usage!
[   14.471703][  T139]
[   14.471703][  T139] other info that might help us debug this:
[   14.471703][  T139]
[   14.472692][  T139]
[   14.472692][  T139] rcu_scheduler_active = 2, debug_locks = 1
[   14.473469][  T139] no locks held by (journald)/139.
[   14.473935][  T139]
[   14.473935][  T139] stack backtrace:
[   14.474454][  T139] CPU: 1 PID: 139 Comm: (journald) Not tainted 6.5.0-rc6-00004-gbffc333633f1 #1
[   14.475296][  T139] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   14.476298][  T139] Call Trace:
[   14.476608][  T139]  dump_stack_lvl+0x78/0x8c
[   14.477055][  T139]  dump_stack+0x12/0x18
[   14.477420][  T139]  lockdep_rcu_suspicious+0x153/0x1a4
[   14.477928][  T139]  cgroup_bpf_device_guard_enabled+0x14f/0x168
[   14.478476][  T139]  devcgroup_task_is_guarded+0x10/0x20
[   14.478973][  T139]  may_open_dev+0x11/0x44
[   14.479367][  T139]  may_open+0x115/0x13c
[   14.479727][  T139]  do_open+0xa1/0x378
[   14.480113][  T139]  path_openat+0xdc/0x1bc
[   14.480512][  T139]  do_filp_open+0x91/0x124
[   14.480911][  T139]  ? lock_release+0x62/0x118
[   14.481329][  T139]  ? _raw_spin_unlock+0x18/0x34
[   14.481797][  T139]  ? alloc_fd+0x112/0x1c4
[   14.482183][  T139]  do_sys_openat2+0x7a/0xa0
[   14.482592][  T139]  __ia32_sys_openat+0x66/0x9c
[   14.483065][  T139]  do_int80_syscall_32+0x27/0x48
[   14.483502][  T139]  entry_INT80_32+0x10d/0x10d
[   14.483962][  T139] EIP: 0xa7f39092
[   14.484267][  T139] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4
 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
[   14.485995][  T139] EAX: ffffffda EBX: ffffff9c ECX: 005df542 EDX: 00008100
[   14.486622][  T139] ESI: 00000000 EDI: 00000000 EBP: affeb888 ESP: affeb6ec
[   14.487225][  T139] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00200246



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230815/202308151506.6be3b169-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

