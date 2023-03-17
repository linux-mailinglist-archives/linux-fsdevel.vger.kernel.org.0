Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E016BDE94
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Mar 2023 03:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjCQCZJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Mar 2023 22:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCQCZH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Mar 2023 22:25:07 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CA659806;
        Thu, 16 Mar 2023 19:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679019905; x=1710555905;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lN0S0duYEVhVpeYJoWbsZCurdfLSk8Po8nthinSp1NI=;
  b=SUW+Bl2u2CaNitcRu65C3k2PBAfUSYzxaeGG5xlDjUnw1C02nCZQk/3Q
   IgTL+QIV09NTQ1wKxV+FMyFg5OjlheayTiWy662BeAwHej0saepPsPMlq
   pPhIffQ14Sg2zGgxGB3lEM42Uazczc9kfZGk6byzF/n7CGteANcH87Q03
   zRGJU5wEuQB62DXR5fFGTaJdgvcISBwDnABzf8QM7lNIqjPa2DcjbFpbT
   81qeGBthsrB8fquPPKnUjz5xTDhS8M7RSVs/QdpElF5tCsFG51zYZxQSR
   Sdq8KMZhFVnZrohIoXZJOCdeskyA//W2Cin7yLYtbVGO66GSZDXTMmk5w
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="365858535"
X-IronPort-AV: E=Sophos;i="5.98,267,1673942400"; 
   d="scan'208";a="365858535"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 19:24:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="769187710"
X-IronPort-AV: E=Sophos;i="5.98,267,1673942400"; 
   d="scan'208";a="769187710"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Mar 2023 19:24:52 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 19:24:52 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 19:24:51 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 16 Mar 2023 19:24:51 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 16 Mar 2023 19:24:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hs5YdC7KLL2Q5rlrekDk83A+DIdht2/RFXmniNzh3oN/eWJIY648nNUJA8bOQIg6WlrbOAOdJxs535j5rFdLu0UXZaslkPK+MEfj6s+7gwlDw5ks6DebIBxwenVQCO0zLolmFMDf5jWAEBlj/o/yMMFunEU96jIKZmVTR43d5dIkaZU9Yvl6lK76YmU302LkooA5tsIrn1gWhbs3tIIW6iXI6a7R5rNRRIBVgFy1sJwwhq8+iOVcmX6RkwqLn6srzKWYEhYio30wh3TZ2r6oTcczcJm1BawZkVCne4OBXez0+MpQI8nsvN9R1DM5p1sut+HWQ5H5iiypfw10G5FL+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0YL0wa8vDpUsOp2T9OAKgdKcEz68gdusDSue7mfgpo=;
 b=B+xSrV2yKADWX3sbiTOvYq1MBMlLlaWgBH0HEnTOaplQUwQPerNdguqAroZyQGTNsoaEtlR40kU2EKqObbeUm3nA6c966hs24SLWtgBIZ/hcxkC62srKlXsSeYRZB6Or1/gDalfha0OzdzrLUfTRMFB5Kiid42SAAuajqcDwq2m6h6xRnqE0RcUY/PuN4crTV+EHDO3sjbsynwVByVckghMID0b4z57ykhmNIjWYcptldH+630RjVS29/DVsmwD4Owh00GAYxAoRsk5Z964DusszQZGZSfilmEHIMMjDZ00J1d1ndsLg0J2QVfTrFDiv8mNgj6TjsvVYUvvhpzTN2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by SN7PR11MB7139.namprd11.prod.outlook.com (2603:10b6:806:2a2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Fri, 17 Mar
 2023 02:24:47 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::66b:243c:7f3d:db9e]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::66b:243c:7f3d:db9e%4]) with mapi id 15.20.6178.033; Fri, 17 Mar 2023
 02:24:47 +0000
Date:   Fri, 17 Mar 2023 10:22:02 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>
CC:     kernel test robot <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <oe-kbuild-all@lists.linux.dev>,
        <linux-mm@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <yebin10@huawei.com>
Subject: Re: [PATCH 4/4] pcpcntr: remove percpu_counter_sum_all()
Message-ID: <ZBPOyjUIInaKhnNd@yujie-X299>
References: <20230315084938.2544737-5-david@fromorbit.com>
 <202303160333.XqIRz3JU-lkp@intel.com>
 <20230315205550.GS360264@dread.disaster.area>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230315205550.GS360264@dread.disaster.area>
X-ClientProxiedBy: SG2PR06CA0218.apcprd06.prod.outlook.com
 (2603:1096:4:68::26) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|SN7PR11MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: 85f7f642-3076-4b35-238e-08db268ec711
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +tz7+j8AdwtZb4bDJ2HZdmLB2v0ljS31mIib1M2Ev1/QtYtHalDZN6MawQGgj94wN6JRWNFJx9+8VpqWZgA3UAebvrzbskYAepe/UAgX1mFUp2f53feBWINXCBDpY0z5T2VGhT+B/JFDc2lScbp2lWVV5r1qvV3ZmBdi4Lp/AAebYwJ6oielrSgr+Pw67mf/UoaGU9qNt7GyYo1H5Y5bZjMwDwlkB72haDONFYJ0DUxOWMvyHz5gBty3dXzqRsUiYyZ3ddZtWLihE0y6meokG1gyNXWfQNTiCyEySQgnj/1STwYwHucCDjH9c6nraLjpnyNM1jztyJM4iELzIspI/KWZ5T7y4r2PmWZPG6ruBHRU4cF4PZblpnD0zLQO0SRFiUd+EB+ARstdiRWbzC7KmjMqt5ekM5++Bn/dW4pxIzBYLZJ3LB6472VpPkCYobnVFSxZOIRkU7zqrYILr76J+rJ3EaXSrh7/bZKen5yPqxdsRIPtpHOaMaozg9xSGYo5XNw0jsSQ/Qfu4L4j9v0bwTAwlIgM+UHRJNlyh9iB6MutvjPP5Bz/KzhS25XV94kKBplU+ZqOeMBpyIKF8c16GtichfYTJm1SUJ5dt7aSGaqA66eqmerXbSsFzgWN90ueDCrAqkCMs7N2OKJtijG3yOLPFOGYl43wG9gYFiQkXX8iIgTRwXcpV3G6NGTNNxPOAUd2kUM0zXi4qRAUi7ISBo9Dqv++C555kLxxFA9LWUw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199018)(110136005)(966005)(41300700001)(478600001)(8676002)(8936002)(66556008)(66476007)(33716001)(86362001)(66946007)(38100700002)(82960400001)(4326008)(26005)(9686003)(186003)(6666004)(6486002)(44832011)(6512007)(5660300002)(2906002)(6506007)(316002)(83380400001)(133343001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rocWwkkTVNsUXnULBKkGrLOa43+kPyEV9b75RsdFZAletRQDB335iKCFDSJV?=
 =?us-ascii?Q?P4sSi2hOsdwGzmXIFFrgzEGxyXOvG8pvohcniP2yeEOgoAac7OocIbm0Hh+w?=
 =?us-ascii?Q?KMFDM9raVoTxuMCg+xIIn0s8Dnz5cVw9kGrtGeQyHzfAREr+BIceW8EG/J37?=
 =?us-ascii?Q?ePzbdJsZw1BP8RjK36wJ8wMAr3t919zmsCWnEnoeyVBPJ9KD/X/DlmCih2YH?=
 =?us-ascii?Q?GoOGZiwszC55DCMzqkVFoGdlm9eF0Z6TzmD96QCKZxrqDWI838Z0YEs8U2EG?=
 =?us-ascii?Q?VOmSMme+cw8sWdeJhaJPJkSLX3EgdJ2GaVZuXpStvlP1TWsWONjhOTELH7fS?=
 =?us-ascii?Q?lKb0TLrxMm8QoVeb9BrbzzBEqKkrYuy985uCA8lgF0/t1UIzLqjnx86hYm2V?=
 =?us-ascii?Q?lCOh7lQDrdwoD+UlwnHT1H7cnOmK1LwPdR2vbJ90TQ7dl70vDrWcsKk0X/o5?=
 =?us-ascii?Q?yEFScCHP28Z9Ct+l/nVWH/QGSkpRUz0k5zudu1ZqvigDreBMZANd/gOkhpcL?=
 =?us-ascii?Q?I+KKL22ZGAjAhF0YJN71Myk7yziO3ZBkWDR7DIDX4ePJ7uDox67yAXA8pPv/?=
 =?us-ascii?Q?4TyPsiEDAclNMbGNBs7UUuaf87Mk3y2NGf77z9zLmatWzTGFvVWVqagP6JjP?=
 =?us-ascii?Q?/yPcMork8o6H1RnzElP4xkBfogS4+v3C9fnKleotsLIaPpd0mqCFIyp0oS8X?=
 =?us-ascii?Q?CZDM9czXmSRLobv+NOPllBzIzd7n6DzsO967S+VW09bGmUxoP/tiS2vIlJ2Q?=
 =?us-ascii?Q?QoOK+s1h5/QEOhVpdEFojoDvtSPk+sMQBXcSRy1ZVCphnorsMBrHiblP8RK0?=
 =?us-ascii?Q?iPCqZ7pphYH+yF6Ukbs42OTQfgVltd5D/DPRLXb415BFaOsOxQxaBW/7e4Ea?=
 =?us-ascii?Q?2lQJv5ySFOzfOIv7EXDpbDCpBXdYz43o7jHk2uKaaOWfLm0nfyC0FdstI/u3?=
 =?us-ascii?Q?jjVjvGLeF0cI3YIapr5iZ2ziyGhHF5hBuGprWTUnb0vz3VskYl3FQ9p3TtOp?=
 =?us-ascii?Q?8svxtp7lSJuzP57Of1eBYOJDjaxGPWrJS1H6S+aLozr6U/nG4sCqoPzqC/dm?=
 =?us-ascii?Q?g3rbdTlKyqDcfcUytkGe1A7I2ZaRcndcKRl7NE9VtLGO8K3Hq4ff6BQsTKpW?=
 =?us-ascii?Q?iNTDyRG+SccIFPZ3NseR/zvO5uAqFwwROQSHoIBH5XvrqC4LAMoIkfk/pBo2?=
 =?us-ascii?Q?DiJzPpmo8vSUoSmkzAaxIYFfL7YK9KbOTtaTc2+iqFkNu3VMJGQFcjhkP4ww?=
 =?us-ascii?Q?a/lxgzaGtW53gdW5KwCDwfouVfD1p35jWPJOlH8PcckBFnaFFB5ElDsGsFHe?=
 =?us-ascii?Q?VeHXNobKqcdn4l7Ot62dFtrY73BGaHyXy/6rMzyhed5M9RziDnSu1vwxumhJ?=
 =?us-ascii?Q?O6G7F2nVlNANYwaBY+BAON7oVj47Pn7U4wve6Su72wNPClTjZa/4u2dP9pZe?=
 =?us-ascii?Q?YQZXUJFO9RFtv/zQbXQ84xly4AOuPfHMTLTjo2bvYGY7S+CMc9hdgh5WrXWn?=
 =?us-ascii?Q?S9aFZDbzQfckCcmed/HL7iyY2O+BISG4OGzR9Ayu0rxhNPrmOOAAbSBifpFM?=
 =?us-ascii?Q?ja18TqLEgBCj/XGALQB7lDoUoeoi3fbtbLsBraE1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f7f642-3076-4b35-238e-08db268ec711
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 02:24:47.7568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7JNcE4VibAPFI7hPq54hYQPIsV+NFLg03hfX/MIUpPsYJ1RecJEWuUO8ceeqsdJH4JDjiHCqU2IbtShr5aZmtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7139
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 16, 2023 at 07:55:50AM +1100, Dave Chinner wrote:
> On Thu, Mar 16, 2023 at 03:22:31AM +0800, kernel test robot wrote:
> > Hi Dave,
> > 
> > Thank you for the patch! Yet something to improve:
> 
> No, ithere is nothing wrong with my patch series, this is something
> for _you_ to improve.
> 
> > [auto build test ERROR on linus/master]
> > [also build test ERROR on v6.3-rc2 next-20230315]
> > [cannot apply to dennis-percpu/for-next]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Dave-Chinner/cpumask-introduce-for_each_cpu_or/20230315-165202
> > patch link:    https://lore.kernel.org/r/20230315084938.2544737-5-david%40fromorbit.com
> > patch subject: [PATCH 4/4] pcpcntr: remove percpu_counter_sum_all()
> > config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20230316/202303160333.XqIRz3JU-lkp@intel.com/config)
> > compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> > reproduce (this is a W=1 build):
> >         # https://github.com/intel-lab-lkp/linux/commit/8360dcb55f1eb08fe7a1f457f3b99bef8e306c8b
> >         git remote add linux-review https://github.com/intel-lab-lkp/linux
> >         git fetch --no-tags linux-review Dave-Chinner/cpumask-introduce-for_each_cpu_or/20230315-165202
> >         git checkout 8360dcb55f1eb08fe7a1f457f3b99bef8e306c8b
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         make W=1 O=build_dir ARCH=i386 olddefconfig
> >         make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/hwmon/ fs/xfs/
> > 
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Link: https://lore.kernel.org/oe-kbuild-all/202303160333.XqIRz3JU-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    In file included from include/linux/string.h:5,
> >                     from include/linux/uuid.h:11,
> >                     from fs/xfs/xfs_linux.h:10,
> >                     from fs/xfs/xfs.h:22,
> >                     from fs/xfs/xfs_super.c:7:
> >    fs/xfs/xfs_super.c: In function 'xfs_destroy_percpu_counters':
> > >> fs/xfs/xfs_super.c:1079:16: error: implicit declaration of function 'percpu_counter_sum_all'; did you mean 'percpu_counter_sum'? [-Werror=implicit-function-declaration]
> >     1079 |                percpu_counter_sum_all(&mp->m_delalloc_blks) == 0);
> >          |                ^~~~~~~~~~~~~~~~~~~~~~
> >    include/linux/compiler.h:77:45: note: in definition of macro 'likely'
> >       77 | # define likely(x)      __builtin_expect(!!(x), 1)
> >          |                                             ^
> >    fs/xfs/xfs_super.c:1078:9: note: in expansion of macro 'ASSERT'
> >     1078 |         ASSERT(xfs_is_shutdown(mp) ||
> >          |         ^~~~~~
> >    cc1: some warnings being treated as errors
> > 
> > 
> > vim +1079 fs/xfs/xfs_super.c
> > 
> > 8757c38f2cf6e5 Ian Kent        2019-11-04  1070  
> > 8757c38f2cf6e5 Ian Kent        2019-11-04  1071  static void
> > 8757c38f2cf6e5 Ian Kent        2019-11-04  1072  xfs_destroy_percpu_counters(
> > 8757c38f2cf6e5 Ian Kent        2019-11-04  1073  	struct xfs_mount	*mp)
> > 8757c38f2cf6e5 Ian Kent        2019-11-04  1074  {
> > 8757c38f2cf6e5 Ian Kent        2019-11-04  1075  	percpu_counter_destroy(&mp->m_icount);
> > 8757c38f2cf6e5 Ian Kent        2019-11-04  1076  	percpu_counter_destroy(&mp->m_ifree);
> > 8757c38f2cf6e5 Ian Kent        2019-11-04  1077  	percpu_counter_destroy(&mp->m_fdblocks);
> > 75c8c50fa16a23 Dave Chinner    2021-08-18  1078  	ASSERT(xfs_is_shutdown(mp) ||
> > c35278f526edf1 Ye Bin          2023-03-14 @1079  	       percpu_counter_sum_all(&mp->m_delalloc_blks) == 0);
> 
> This change has not been committed to any tree that I am aware of.
> It was only posted to the XFS list yesterday, and I effectively
> NACK'd it and wrote this patchset instead to fix the issue.
> 
> IOWs, if -anyone- has actually committed this change to add
> percpu_counter_sum_all() to XFS, they've done the wrong thing.
> Hence this build failure is a robot issue, not a problem with my
> patch series.

Sorry about this false positive report.

The robot misinterpreted the link in the cover letter, and wrongly
thought it was a prerequisite patch for this patch series, leading to
this false report.

We will improve the robot and increase the accuracy.

--
Best Regards,
Yujie
