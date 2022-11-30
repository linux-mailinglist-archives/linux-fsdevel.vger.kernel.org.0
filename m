Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B405963CE2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Nov 2022 05:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbiK3EAd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Nov 2022 23:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbiK3EAN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Nov 2022 23:00:13 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87C67614D;
        Tue, 29 Nov 2022 19:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669780791; x=1701316791;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=a5wFUq59mFa5NktTdGI2qqtcF5lyHRasOhDDKv0J9/0=;
  b=b7xUkRM6Z/o/d2OPxlmg/UqH+594oZmLe0Ctctb/eS8qfm830m5S82sW
   aWuuSOVApLCA4vLeai1sgcfjEuYhMfh/0lOM2LG9nxCZCo4IAbubwaSYj
   EMCTwuxg9qwttzsdY5pHmnezZhWvyAU4R0vYxoLMUE9DvsY9j4SyroP98
   AhQg216R+F2fQqN67pBCRGDy8eVdpKE3uZ8TecrNZlpppj1qP5lCI2VHo
   Ulpdg5DtPuYy0A6j50klOL+mVL1AFmVNNsm3wYz3MXeQEV9BTn/HgyQTI
   PINwv2KMDhYO3+DHAGaXd/1mrn39Qe5tDQKIvijaZMUCvFaEMB+9Fk903
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="298666133"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="298666133"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 19:59:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="750160806"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="750160806"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 29 Nov 2022 19:59:22 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 29 Nov 2022 19:59:22 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 29 Nov 2022 19:59:21 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 29 Nov 2022 19:59:21 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 29 Nov 2022 19:59:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8+lM7V5ID4ZOOXtDjyAKfiwG1W6InNGiZSMQAQLGj2B9UBdTkkA768vSfWSwajIBGaAfCr8y7W2ksBEuXtnTiJbgsL5Akx/ctEQlkNy6QX70sMEuUuQjZY7NTWDxj+JOJWp/zy7rpCsAJxF6xkq3ejKgvJPz0H5QaH4l0owChT+VnuH6veu73FJhafDjLSvzRdblFXcxrfIUbjbbw/WqS8QG7mpdOPQt1he9aLncZOQ+k1VQJZ1ynzxTa1KTFRO9kyPXcelrRmTdnVjpPOdN74KKcyMF6x6NA4kWqJpaWvSbhzpkXC2Cq6cAXGhi9Wp8lxoarqIlYzjrzlIoQ5Erw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q92VvA57SH4er3swwyyk6a+5ufzPPunPY32axGnSC10=;
 b=LckthqPm1UxnuKQO/VPDopF6uL00+CWTmtDPMUCgOpxnmlk5r4mvbFTW4UQ4V2DVSRPBHC/ueHnAn79KxQjD400tbLp4eoaZnWK2S2ynIGyQ6Q4eWYVyGMf70CdEKWN/PjXaRIAMsouEGGfY+dyzW9f6Pc4pebg+0O1geLJJfIngWcD2NoZ9ltk/3sA/WSQ3w4ndU/8xrkl2ZpUYrq4tmMUcaJAGIa42vmMXn/VRi536pFNbTsJparSrJGis+hPyhxSsDIKaRLd5gI92uWWs/ANgPhTw8ci4scTApQ9NdtuycmCAUVsE8NAJ25n1CiBr4sKOt5U9OGNpRHV+IyYNtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by PH8PR11MB7118.namprd11.prod.outlook.com
 (2603:10b6:510:216::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 03:59:19 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 03:59:18 +0000
Date:   Tue, 29 Nov 2022 19:59:14 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <david@fromorbit.com>,
        <dan.j.williams@intel.com>, <akpm@linux-foundation.org>
Subject: RE: [PATCH 0/2] fsdax,xfs: fix warning messages
Message-ID: <6386d512ce3fc_c9572944e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <1669301694-16-1-git-send-email-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1669301694-16-1-git-send-email-ruansy.fnst@fujitsu.com>
X-ClientProxiedBy: SJ0PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::11) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|PH8PR11MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: c1d1f885-30f3-4bb3-4264-08dad28740aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p9TO5h21LyNgftdth7NZ2KjCAyt8opZz3AEGlcneA0eqC7LiZOSCVBJzWPWGazIzFWxGICvoVwcM0oZzQFt/PQY97lk8YmWDQEtOQTUlNkcNaqmi8bgakWjGc0P6R7T7xqW0zQEpOgYN/JhSFPhKB3DhoVZNcs6ThcnKuDGHbfIPFhGZvd976yC8etE7OfxUeTpSQs4b3P4QA2EmxZx57s1YB5Uh03n88K8RoooXWUZ14yj4UrFl1MEW5IOm6fEQ9UzQ6rLlVowRhRug7lJcxW5gKNxq9+pv898s5qM7gXd7aNCtkcr6X4L2DszHRY8JN4uDEELKkL0HZUWePsDIcKEpUncjs8zTQ8R5HHDayBpcb3QVJBxh9yIOH9RoSEUGr1JAdcpGrvag5k0EakNicAsXnY81wYtvQB9kvUV7j440+2LFQYKvdiIsMZYNdtG4HEBWBe2eMHv5s4GKe1ViM0rbi6sKrwZPbVyI4esDUYC5wzCjlTvmbR/YKoXiaLWaPyfKF2mPmaHA3oQ2bZcfDytsd1RxBcyFoMfF+XXAzpaUaXlWwsHu4pY2YYq5sjGb2LNt+fhOHDUc6w8cz1vUsO4M18LW3iDGnMcVUsct/ek/eqnhOEW7JoytMYhgEgBToXOL0TWWeVxUB7mC/dASp+VhRGdpFgiCiQU5XfGuKXY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199015)(82960400001)(2906002)(86362001)(66556008)(15650500001)(66476007)(66946007)(41300700001)(8676002)(8936002)(5660300002)(478600001)(316002)(6486002)(966005)(4326008)(38100700002)(83380400001)(6666004)(6506007)(6512007)(26005)(9686003)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M2CPZ038+RBUQyoQhmerSg08s9lP1bxjSnuUvtmzquR6+gSUYybIfjRXeglj?=
 =?us-ascii?Q?W+/f+onyQpLKqx4u+p9cFUFB4DeHByPzP/KY2PeZVoNt88Ri+bJaugZuPCQb?=
 =?us-ascii?Q?l8SPQo4g8Atyaxn77NBVWhS5ZeXOajUKvRe2gbNwt1KiupNwrc11+9j7eOty?=
 =?us-ascii?Q?xlcQzJaYmkoylxpcfO8+axVr399W0YE6Kn2D8QHk81z0/gfdsQno9v7ICMJU?=
 =?us-ascii?Q?xZlJRvu9/c6wXUmqM6+5UGwxPcrIwnyeg6fc0o0Gd0/CIqHZ/dT0W+ylaW8X?=
 =?us-ascii?Q?UEya9IX2kI3HdfJXecg9rzA7TZ85Piwfz55JoheSKRWSoSycwan9K94Cl1oQ?=
 =?us-ascii?Q?flLX3AXGpSZ1HfO5LgKLIQlVmtq3BzQRsmeFInEi1ShMEdTvbdbWRu93KxDi?=
 =?us-ascii?Q?sBBqq/QwkV5U/92HVu4NBwnUQDptnpRuM7tND6lsLYBjdqlEgvOGm8PZUonv?=
 =?us-ascii?Q?MV3J/7c6rGImktrWsVdP5QnaWHnh8e5kXSq6dx1MinuoLgUSnoe4Nuy6EvIL?=
 =?us-ascii?Q?EfhUQEmMV9wREeIxq9221n49No8j8LWDPZ1crAuJcr8uohQaxnBgKJC/d1c7?=
 =?us-ascii?Q?m4sCgmJ1uRQ6stKLC3bMkDKydokLfEd35EZ0LGVoa3NCUhfcyiAQz0o71i/B?=
 =?us-ascii?Q?YY0ihxNu8zicE2KpjpJ0V7n7XNK7/02t+DJvtqTd8vkJ0Vz/uQw1r24eCwwS?=
 =?us-ascii?Q?L0K5rAxshaKdZX+OAHMITdCfGs3n/yQHktRwwlfB34n5gtNua35m8C+gvOOq?=
 =?us-ascii?Q?KfukDePh1vRfn4yRSFL4VKz7Crdq2ZqaDXIZ9OnYBIXSJGEj8ZwNDwfWBPf7?=
 =?us-ascii?Q?pwVxjv1XTr3T0wpV3Q3sZ7JdfGsCcz23FFjswOB82jqq/hODUzH9tq2uR9bE?=
 =?us-ascii?Q?VdR1CYSCNFgjTBlTrbGpxLTxnj8wsSyVoUTIyltsYQYqrio/wgWM7/fnpf/7?=
 =?us-ascii?Q?6Ubi4YSN/AN1+xTvEFeymKIpeLC42HO6YA4lcI6eA6v2YR9fuN8Z2+TIb6Ul?=
 =?us-ascii?Q?jHA9C+f4pfW6A2p9K6MsTLoA/F8rp+DL444ykXPVNL+cTVCwLiQeSjwT6Q/X?=
 =?us-ascii?Q?mr2w8D2Eidw+pBCLwoaZRuchydcduhVOH66iSlcJDlV0YekRiiLhtq9qFoe/?=
 =?us-ascii?Q?Fg9ZKx+eyGI4dcWvDF/B/5VG/3+4culpJkzHrY/ZIJqVK7qdRkvcIaqJT89t?=
 =?us-ascii?Q?oHyF/No6r13+jAak3Rl7bgT/ltNNJNbdvpiWelVaWCtHbBdprdEaNx4hCSrv?=
 =?us-ascii?Q?uifmYG6DSWnAinyWc9dVCM1BuzTYyw7K9DmKs9qDeY4k04IItUQAXx3O48mw?=
 =?us-ascii?Q?FHHOtO1v05DQajacejSaJXsbA0FG3ajy/7mexXtRvojjvHq1npdBcMUQ1ty+?=
 =?us-ascii?Q?D/FC6UjKjJ6kQPWmRwdvPO6JdcFF0YJvlaQOIdILZleAGz58Rr7NHhrI2i0Q?=
 =?us-ascii?Q?iU7HojEqEiHnUs1v73fE+lW0U53E6HbD7kjW2gFl6tgmMC/2VLc1Ad1EjIs3?=
 =?us-ascii?Q?3U498iPC3/eXpDu+F7dw403VZWp+xEz/p7nfQIuCWmiA3hlMLuk/FMSWrkuT?=
 =?us-ascii?Q?OnxhOG7aCsDmOEHxtW9iba6PPo7EA9tsIusGLWHmTqsTOJHl2ZJg35hgw6pJ?=
 =?us-ascii?Q?uA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d1f885-30f3-4bb3-4264-08dad28740aa
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 03:59:18.7413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cqlNTggRIVTgreyi3tqtqB2xiATYcyx9cZ5Z4fctTbqZDdFdSHcw5VOa7Yu5z0AslDyuNGnRx07Sn9MzNz4yg8OMtdocufHa+MJIDWeS3H4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7118
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[ add Andrew ]

Shiyang Ruan wrote:
> Many testcases failed in dax+reflink mode with warning message in dmesg.
> This also effects dax+noreflink mode if we run the test after a
> dax+reflink test.  So, the most urgent thing is solving the warning
> messages.
> 
> Patch 1 fixes some mistakes and adds handling of CoW cases not
> previously considered (srcmap is HOLE or UNWRITTEN).
> Patch 2 adds the implementation of unshare for fsdax.
> 
> With these fixes, most warning messages in dax_associate_entry() are
> gone.  But honestly, generic/388 will randomly failed with the warning.
> The case shutdown the xfs when fsstress is running, and do it for many
> times.  I think the reason is that dax pages in use are not able to be
> invalidated in time when fs is shutdown.  The next time dax page to be
> associated, it still remains the mapping value set last time.  I'll keep
> on solving it.
> 
> The warning message in dax_writeback_one() can also be fixed because of
> the dax unshare.

Thank you for digging in on this, I had been pinned down on CXL tasks
and worried that we would need to mark FS_DAX broken for a cycle, so
this is timely.

My only concern is that these patches look to have significant collisions with
the fsdax page reference counting reworks pending in linux-next. Although,
those are still sitting in mm-unstable:

http://lore.kernel.org/r/20221108162059.2ee440d5244657c4f16bdca0@linux-foundation.org

My preference would be to move ahead with both in which case I can help
rebase these fixes on top. In that scenario everything would go through
Andrew.

However, if we are getting too late in the cycle for that path I think
these dax-fixes take precedence, and one more cycle to let the page
reference count reworks sit is ok.

> Shiyang Ruan (2):
>   fsdax,xfs: fix warning messages at dax_[dis]associate_entry()
>   fsdax,xfs: port unshare to fsdax
> 
>  fs/dax.c             | 166 ++++++++++++++++++++++++++++++-------------
>  fs/xfs/xfs_iomap.c   |   6 +-
>  fs/xfs/xfs_reflink.c |   8 ++-
>  include/linux/dax.h  |   2 +
>  4 files changed, 129 insertions(+), 53 deletions(-)
> 
> -- 
> 2.38.1
