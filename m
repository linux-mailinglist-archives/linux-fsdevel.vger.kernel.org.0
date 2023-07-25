Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3BC761DBB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 17:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbjGYPyw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 11:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbjGYPyu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:54:50 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA442116
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 08:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690300484; x=1721836484;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GFdcUJUqVmt8sB9COC1LxtZbrHoeqn55DEvM6i3tlTQ=;
  b=IDslxWmCIvWIcB9Pbet5Lfg6Lu+6VltjRHlo59Lx4/2Zks4Zlp+Bcf6O
   vcQzNiz2nsDz3SWnqhiBbQ2MSbLGBFckwdxBqlwfOBR2mdlc01OUlESv1
   T2O8ZHi5RNwTRJrNkgJPzIH3iZPo1/cxtLhQkZHtLVIRTawf3TrfW/woZ
   8AK9Ro24GALcToRH3h6MP4fbM18kemLT81DsUDsu8fqpM8XtrbwLctQa5
   8wuChVkYRi5hurKUhEqOYmYFpQBGqcp8zabc0N8NBg35lvAIjM+ordsPx
   6ZIVndZV50prr1RFTs8uzJekIQiKCPRpzThvE8EWKC6VFrV/oLmyXv8yf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="348043456"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="348043456"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 08:54:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="703336724"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="703336724"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 25 Jul 2023 08:54:43 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 25 Jul 2023 08:54:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 25 Jul 2023 08:54:42 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 25 Jul 2023 08:54:42 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 25 Jul 2023 08:54:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3Xy3D3BV17QiG5X4l12/n93ZTMXw//lesqlblE/TsUtETXMh+FWCXebXeyfxFnTlMaCm1M6mEdAzMoxVLA2oFXhbNAiifTs0YjadwefEXYDd/sNHEji2MH8HPHhFB2fV9PKlyMFBVDEoC9PTW8tIYRpSX02zXrOHa1BoEL2pik4wIAaxn+gBdvvdYUeA6fqZUGMdodqc2NgjsHO9ode7fDTAjLroAOHvosZwd9nrzPVO+cCtwyfKabmQVHhwE6PDF5uks67kIQDTIIq7NQU4jix8dnYBDDLjdDjqT+KQyrIa9Dfqm8K8OtQQOSlVtT5zNIh0v9F4TjnzONaMWH5+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRTIO5xKnBNIDKHL1n5lkRXb5zqRx0ZctSvkAmn1eeE=;
 b=OE/s0QfNyNOZOYPk+ka06C5yewOAXGLtdIOwKF/HN0gW8Ds1GvnGpJ0Mz+vZDXSlydw5opjIcZ8/TcJ3kvC6ySsV90Kq+Pyw+KiD1koUzZasSMGb60qoAqtSOVTUaB71Nrxm4VPmQqwSVrlV0AhelkaJzmKnJmoXD5xef8N6LJ8kTaOadyV8MUXUoCdfXyzR5IEMs+nB2JiwfVP6neul+MRYZUn0f0nKV9kcE1gXd/C0Qldf08g0Xqaxhti3jrGXyINr1Uq53IS+lU19UqhkhnifGu7HtOQ/y36d4cvP/meoxT/9KNKZLKzPI3OYuIlngkJRg+0M/SPo+D3BaPO5Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by MW4PR11MB6738.namprd11.prod.outlook.com (2603:10b6:303:20c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 15:54:40 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::aa71:69cd:a453:98ef]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::aa71:69cd:a453:98ef%7]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 15:54:39 +0000
Date:   Tue, 25 Jul 2023 23:54:26 +0800
From:   Philip Li <philip.li@intel.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
CC:     kernel test robot <oliver.sang@intel.com>,
        Chuck Lever <cel@kernel.org>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        kernel test robot <lkp@intel.com>,
        linux-mm <linux-mm@kvack.org>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "fengwei.yin@intel.com" <fengwei.yin@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Hugh Dickins" <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Jeff Layton" <jlayton@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v7 3/3] shmem: stable directory offsets
Message-ID: <ZL/wMvYSjRU0L6Cp@rli9-mobl>
References: <202307171436.29248fcf-oliver.sang@intel.com>
 <3B736492-9332-40C9-A916-DA6EE1A425B9@oracle.com>
 <53E23038-3904-400F-97E1-0BAFAD510D2D@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <53E23038-3904-400F-97E1-0BAFAD510D2D@oracle.com>
X-ClientProxiedBy: SG2PR04CA0165.apcprd04.prod.outlook.com (2603:1096:4::27)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|MW4PR11MB6738:EE_
X-MS-Office365-Filtering-Correlation-Id: 31ee02c3-987b-4a9a-654b-08db8d277416
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kSBy/P6n5MmOdoaV1ltswnU79nFE9NDDF7cQUjE9fM9inPukKMpH41+8DPCbih1bcNk9FlQ5TEC39dhdd7WdV8phj5bklOZdcW1LQCnkbyb80ifhAHyMCdO810s+ufV2RqeD2ub9SNvQekuZc1jN1WorSAfjljJhYglu4hUsKdXIvq7aT31ue00JL4eF5lbJt/bTkKUsv8o+0MbgbjJ4dhAjphgeI65kd7IvLh0ppJ0eovVWeN/wFUyW1P8UkxHbSe/IaE68ARW0Tj2LaW13RUaxIYdaSCmydLO2UbYTL4KE0PtxMkwvBkeuzvG+rwBOYHqu7yUPUrvKZw7VRnFRfgKL9YM3Op4mPlmarhHuZJsa/veFAp5hyIpTmVXr92QUjm5FzjHDI/Q8XFNt0Eu+YFybj7I/ViDudRZfoMhC/dLdtWf4qI9pSSQKU9bcF7q3BbjXy3j+Ou8KSqwX1ShgxwzLSxxrnAJIDwGUvVym5txU/fofDMJIWFge4hxyph4Z/epHnuVawaHrHor8AJ0+CkeeM3nIkNzWp+MqKf47AUiaKszSzBqa+xy5Nc7TY/Hn4zvsMLw8cvmNM6a0dGducQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199021)(53546011)(38100700002)(82960400001)(186003)(6506007)(26005)(83380400001)(30864003)(2906002)(5660300002)(41300700001)(8936002)(8676002)(44832011)(7416002)(86362001)(478600001)(6512007)(19627235002)(9686003)(6666004)(66946007)(66556008)(6486002)(66476007)(966005)(6916009)(316002)(4326008)(54906003)(33716001)(66899021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?clOITJredtp/FPWyEh2LbkbQ1hRFeG8r8Ta8oVqS+7HI/A5K/jwKbWoqbSG4?=
 =?us-ascii?Q?VevptcvqL7vc0jW6CQKiyvMTFy2Xx8K+LSYSpwGjCBfwdpnjRDol7RUs97aS?=
 =?us-ascii?Q?H6DAUs3WGB4PN7iHEgT+KMaPM0SU/XgUYXSgzPHvCLHPx5HZ5/ONOcfk7Wo2?=
 =?us-ascii?Q?aOc12sYbLbnKq59ucKCnKYg5E5j3TZbt2xtVzTSN+kWgPGfzuznT58uNug2G?=
 =?us-ascii?Q?5ZXkXn1ljLr3K5U5m71cW4M+3SM0UJW+G5cx3cbg5kIKKi1TgMvnNpSHfFvQ?=
 =?us-ascii?Q?I/+obC5RA64O7t9YkvWj6MbiJleJm4BCqejYL1+BBaKs+kpSfKVHqoUeETsA?=
 =?us-ascii?Q?vzyESNDxMVFsMYJA1eJTIH2WRa42g3w807ZRLVyF7sqr4sHPB6oxG0JbKALP?=
 =?us-ascii?Q?Dkw9HEjCsRVQ2lgUEpDNMb+wS5Pz0NoYuAqxXqrLUiM9wboR0WUtAnyLeJMt?=
 =?us-ascii?Q?E2t5s7No9IbJyxgb+kld/whzp40wJrxi5OELhbBDYueOstpD29jVJ78urINe?=
 =?us-ascii?Q?BqibGSA0z4Ncu1AXpo+jF7eHjj9Bl+1/Z72MvWZ0LAVCi51Qb9AAhce+om0W?=
 =?us-ascii?Q?Cp3FRJjBsRDRbfyAtlnN1ZU5aVxc06AS8AQskCsW3rWEhVYEqD0zofD1cIWq?=
 =?us-ascii?Q?bQ8r39WSfkzfeZN0IMRwaNjcvcoj79BM84dgBU2wEKZpT76B4mzPutIFEPq5?=
 =?us-ascii?Q?DxvfWKjgGzfeP3Xh1FVgDEQhdSgfb+IG5pFRIcEXnGlyK6Dwfv+AgErkfNT4?=
 =?us-ascii?Q?tFdD3rX/dJ69ZrFjPcOCyJ9vrjnbqj1PUY7GrJLTSdQRsO5g2G3TQBE4dap8?=
 =?us-ascii?Q?ZE0ACVdsZbXrOppRN5os09RtShTL1WwtyEfrM+83cP5wchWWlpq8ML+Q8yPY?=
 =?us-ascii?Q?i4tiNzBctpFmVzK6vfDZWm120OAzSSK8dEx2MUpHTuaR6XdhG0r2Q+b6SUB3?=
 =?us-ascii?Q?fIp26vikN0ux/TaHyc3+e/eqBxIH6iTXt1XkQZ8rRNERROFRRuXvPZ89tX8D?=
 =?us-ascii?Q?b2rlwF6TnHYJZuqx5DMNJJ0xK/w20X9efNt8jiLuAdT98CJRjtam7/z8WbLx?=
 =?us-ascii?Q?5PdSYWpKWoApTnxDaCWTr6lLCMoQfvs04CwALYA1cGKihYQ7uF4k/9xJpwsV?=
 =?us-ascii?Q?CBNJy72AnywB0suIKOhY1QlP4ntYEWqHfIRvOrK3PVFnSpN7DqcM41Wk8gHu?=
 =?us-ascii?Q?i5vGDf513HSubAJeek6w42jbmnGceU95TIX8cVdVob+BbknmEi5uslvzId7K?=
 =?us-ascii?Q?1aXHkYxrFtMHIeg/xD2/0cXJu4MGq1QQ92L438mSh4WDw8KknLtwV6AydPjn?=
 =?us-ascii?Q?njlGlSy7jyBEWjm5dBCLFN8Btq03VUM+Gdp8vH3lh2WJmcSafggKq29wJJIC?=
 =?us-ascii?Q?Geqro+hcDvX/r2gcKkl0zjcdOHkzcRmVb1SxmaxWjooErjiXqkjLfNAzx4dN?=
 =?us-ascii?Q?YneK4Ydawe7mmZb4vyQU7FO1WU3x5NfWjCIhZFH0gBUq295FNVkGPqhgwDjn?=
 =?us-ascii?Q?cxUdMA2MIxKMU+9wtEQ5tH9ZnzDNd5OAxWSNmXsteVcEma4y3sqj+hNlFPVv?=
 =?us-ascii?Q?41kuFaZCLhpJIEryDMYfNRqcFh9o42ZEB5vkuw+H?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ee02c3-987b-4a9a-654b-08db8d277416
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 15:54:39.7941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1cI0O/k3MMn5GH1rCX1CoKj07AjkrZSCfC/BupDGsmyo+oH2qqJKWWc6iouvJDf+XjlIuNS6kQUfuta8LY7PDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6738
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 25, 2023 at 03:12:22PM +0000, Chuck Lever III wrote:
> 
> 
> > On Jul 22, 2023, at 4:33 PM, Chuck Lever III <chuck.lever@oracle.com> wrote:
> > 
> > 
> > 
> >> On Jul 17, 2023, at 2:46 AM, kernel test robot <oliver.sang@intel.com> wrote:
> >> 
> >> 
> >> hi, Chuck Lever,
> >> 
> >> we reported a 3.0% improvement of stress-ng.handle.ops_per_sec for this commit
> >> on
> >> https://lore.kernel.org/oe-lkp/202307132153.a52cdb2d-oliver.sang@intel.com/
> >> 
> >> but now we noticed a regression, detail as below, FYI
> >> 
> >> Hello,
> >> 
> >> kernel test robot noticed a -15.5% regression of will-it-scale.per_thread_ops on:
> >> 
> >> 
> >> commit: a1a690e009744e4526526b2f838beec5ef9233cc ("[PATCH v7 3/3] shmem: stable directory offsets")
> >> url: https://github.com/intel-lab-lkp/linux/commits/Chuck-Lever/libfs-Add-directory-operations-for-stable-offsets/20230701-014925
> >> base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everything
> >> patch link: https://lore.kernel.org/all/168814734331.530310.3911190551060453102.stgit@manet.1015granger.net/
> >> patch subject: [PATCH v7 3/3] shmem: stable directory offsets
> >> 
> >> testcase: will-it-scale
> >> test machine: 104 threads 2 sockets (Skylake) with 192G memory
> >> parameters:
> >> 
> >> nr_task: 16
> >> mode: thread
> >> test: unlink2
> >> cpufreq_governor: performance
> >> 
> >> 
> >> In addition to that, the commit also has significant impact on the following tests:
> >> 
> >> +------------------+-------------------------------------------------------------------------------------------------+
> >> | testcase: change | will-it-scale: will-it-scale.per_thread_ops -40.0% regression                                   |
> >> | test machine     | 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory |
> >> | test parameters  | cpufreq_governor=performance                                                                    |
> >> |                  | mode=thread                                                                                     |
> >> |                  | nr_task=16                                                                                      |
> >> |                  | test=unlink2                                                                                    |
> >> +------------------+-------------------------------------------------------------------------------------------------+
> >> | testcase: change | stress-ng: stress-ng.handle.ops_per_sec 3.0% improvement                                        |
> >> | test machine     | 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU @ 3.00GHz (Skylake) with 32G memory        |
> >> | test parameters  | class=filesystem                                                                                |
> >> |                  | cpufreq_governor=performance                                                                    |
> >> |                  | disk=1SSD                                                                                       |
> >> |                  | fs=ext4                                                                                         |
> >> |                  | nr_threads=10%                                                                                  |
> >> |                  | test=handle                                                                                     |
> >> |                  | testtime=60s                                                                                    |
> >> +------------------+-------------------------------------------------------------------------------------------------+
> >> 
> >> 
> >> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> >> the same patch/commit), kindly add following tags
> >> | Reported-by: kernel test robot <oliver.sang@intel.com>
> >> | Closes: https://lore.kernel.org/oe-lkp/202307171436.29248fcf-oliver.sang@intel.com
> >> 
> >> 
> >> Details are as below:
> >> -------------------------------------------------------------------------------------------------->
> >> 
> >> 
> >> To reproduce:
> >> 
> >>       git clone https://github.com/intel/lkp-tests.git
> >>       cd lkp-tests
> >>       sudo bin/lkp install job.yaml           # job file is attached in this email
> 
> Has anyone from the lkp or ltp teams had a chance to look at this?
> I'm stuck without this reproducer.

Sorry about this that fedora is not fully supported now [1]. A possible way
is to run the test inside docker [2]. But we haven't fully tested the
reproduce steps in docker yet, which is in our TODO list. Also a concern is
that docker environment probably can't reproduce the performance regression.

For now, not sure whether it is convenient for you to have a ubuntu or debian
environment to give a try? Another alternative is if you have new patch, we
can assist to verify it on our machines.

[1] https://github.com/intel/lkp-tests#supported-distributions
[2] https://github.com/intel/lkp-tests/tree/master/docker

> 
> 
> > I'm trying to reproduce the regression here, but the reproducer fails
> > at this step with:
> > 
> > ==> Installing package will-it-scale with /export/xfs/lkp-tests/sbin/pacman-LKP -U...
> > warning: source_date_epoch_from_changelog set but %changelog is missing
> > Executing(%install): /bin/sh -e /var/tmp/rpm-tmp.Py4eQi
> > + umask 022
> > + cd /export/xfs/lkp-tests/programs/will-it-scale/pkg/rpm_build/BUILD
> > + '[' /export/xfs/lkp-tests/programs/will-it-scale/pkg/rpm_build/BUILDROOT/will-it-scale-LKP-1-1.x86_64 '!=' / ']'
> > + rm -rf /export/xfs/lkp-tests/programs/will-it-scale/pkg/rpm_build/BUILDROOT/will-it-scale-LKP-1-1.x86_64
> > ++ dirname /export/xfs/lkp-tests/programs/will-it-scale/pkg/rpm_build/BUILDROOT/will-it-scale-LKP-1-1.x86_64
> > + mkdir -p /export/xfs/lkp-tests/programs/will-it-scale/pkg/rpm_build/BUILDROOT
> > + mkdir /export/xfs/lkp-tests/programs/will-it-scale/pkg/rpm_build/BUILDROOT/will-it-scale-LKP-1-1.x86_64
> > + CFLAGS='-march=x86-64 -mtune=generic -O2 -pipe -fstack-protector-strong --param=ssp-buffer-size=4'
> > + export CFLAGS
> > + CXXFLAGS='-march=x86-64 -mtune=generic -O2 -pipe -fstack-protector-strong --param=ssp-buffer-size=4'
> > + export CXXFLAGS
> > + FFLAGS='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1  -m64  -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -I/usr/lib64/gfortran/modules'
> > + export FFLAGS
> > + FCFLAGS='-O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1  -m64  -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -I/usr/lib64/gfortran/modules'
> > + export FCFLAGS
> > + LDFLAGS=-Wl,-O1,--sort-common,--as-needed,-z,relro
> > + export LDFLAGS
> > + LT_SYS_LIBRARY_PATH=/usr/lib64:
> > + export LT_SYS_LIBRARY_PATH
> > + CC=gcc
> > + export CC
> > + CXX=g++
> > + export CXX
> > + cp -a /export/xfs/lkp-tests/programs/will-it-scale/pkg/will-it-scale-lkp/lkp /export/xfs/lkp-tests/programs/will-it-scale/pkg/rpm_build/BUILDROOT/will-it-scale-LKP-1-1.x86_64
> > + /usr/lib/rpm/check-buildroot
> > + /usr/lib/rpm/redhat/brp-ldconfig
> > + /usr/lib/rpm/brp-compress
> > + /usr/lib/rpm/brp-strip /usr/bin/strip
> > + /usr/lib/rpm/brp-strip-comment-note /usr/bin/strip /usr/bin/objdump
> > /usr/bin/objdump: '/export/xfs/lkp-tests/programs/will-it-scale/pkg/rpm_build/BUILDROOT/will-it-scale-LKP-1-1.x86_64/lkp/benchmarks/will-it-scale/writeseek2/export/xfs/lkp-tests/programs/will-it-scale/pkg/rpm_build/BUILDROOT/will-it-scale-LKP-1-1.x86_64/lkp/benchmarks/will-it-scale/dup1_threads': No such file
> > /usr/bin/strip: '/export/xfs/lkp-tests/programs/will-it-scale/pkg/rpm_build/BUILDROOT/will-it-scale-LKP-1-1.x86_64/lkp/benchmarks/will-it-scale/writeseek2/export/xfs/lkp-tests/programs/will-it-scale/pkg/rpm_build/BUILDROOT/will-it-scale-LKP-1-1.x86_64/lkp/benchmarks/will-it-scale/dup1_threads': No such file
> > /usr/bin/objdump: '/export/xfs/lkp-tests/programs/will-it-scale/pkg/rpm_build/BUILDROOT/will-it-scale-LKP-1-1.x8/export/xfs/lkp-tests/programs/will-it-scale/pkg/rpm_build/BUILDROOT/will-it-scale-LKP-1-1.x86_64/lkp/benchmarks/will-it-scale/brk1_processes': No such file
> > /usr/bin/strip: '/export/xfs/lkp-tests/programs/will-it-scale/pkg/rpm_build/BUILDROOT/will-it-scale-LKP-1-1.x8/export/xfs/lkp-tests/programs/will-it-scale/pkg/rpm_build/BUILDROOT/will-it-scale-LKP-1-1.x86_64/lkp/benchmarks/will-it-scale/brk1_processes': No such file
> > /usr/bin/objdump: '/export/xfs/lkp-tests/programs/will-it-sc_processes': No such file
> > /usr/bin/strip: '/export/xfs/lkp-tests/programs/will-it-sc_processes': No such file
> > /usr/bin/objdump: '6_64/lkp/benchmarks/will-it-scale/pread2_threads': No such file
> > /usr/bin/strip: '6_64/lkp/benchmarks/will-it-scale/pread2_threads': No such file
> > /usr/bin/objdump: 'ale/pkg/rpm_build/BUILDROOT/will-it-scale-LKP-1-1.x86_64/lkp/benchmarks/will-it-scale/poll2_processes': No such file
> > /usr/bin/strip: 'ale/pkg/rpm_build/BUILDROOT/will-it-scale-LKP-1-1.x86_64/lkp/benchmarks/will-it-scale/poll2_processes': No such file
> > + /usr/lib/rpm/redhat/brp-strip-lto /usr/bin/strip
> > + /usr/lib/rpm/brp-strip-static-archive /usr/bin/strip
> > + /usr/lib/rpm/check-rpaths
> > + /usr/lib/rpm/redhat/brp-mangle-shebangs
> > mangling shebang in /lkp/benchmarks/python3/bin/python3.8-config from /bin/sh to #!/usr/bin/sh
> > *** ERROR: ambiguous python shebang in /lkp/benchmarks/python3/lib/python3.8/encodings/rot_13.py: #!/usr/bin/env python. Change it to python3 (or python2) explicitly.
> > mangling shebang in /lkp/benchmarks/python3/lib/python3.8/lib2to3/pgen2/token.py from /usr/bin/env python3 to #!/usr/bin/python3
> > *** ERROR: ambiguous python shebang in /lkp/benchmarks/python3/lib/python3.8/lib2to3/tests/data/different_encoding.py: #!/usr/bin/env python. Change it to python3 (or python2) explicitly.
> > *** ERROR: ambiguous python shebang in /lkp/benchmarks/python3/lib/python3.8/lib2to3/tests/data/false_encoding.py: #!/usr/bin/env python. Change it to python3 (or python2) explicitly.
> > mangling shebang in /lkp/benchmarks/python3/lib/python3.8/lib2to3/tests/pytree_idempotency.py from /usr/bin/env python3 to #!/usr/bin/python3
> > mangling shebang in /lkp/benchmarks/python3/lib/python3.8/config-3.8-x86_64-linux-gnu/makesetup from /bin/sh to #!/usr/bin/sh
> > mangling shebang in /lkp/benchmarks/python3/lib/python3.8/config-3.8-x86_64-linux-gnu/install-sh from /bin/sh to #!/usr/bin/sh
> > mangling shebang in /lkp/benchmarks/python3/lib/python3.8/ctypes/macholib/fetch_macholib from /bin/sh to #!/usr/bin/sh
> > mangling shebang in /lkp/benchmarks/python3/lib/python3.8/turtledemo/bytedesign.py from /usr/bin/env python3 to #!/usr/bin/python3
> > mangling shebang in /lkp/benchmarks/python3/lib/python3.8/turtledemo/clock.py from /usr/bin/env python3 to #!/usr/bin/python3
> > mangling shebang in /lkp/benchmarks/python3/lib/python3.8/turtledemo/forest.py from /usr/bin/env python3 to #!/usr/bin/python3
> > mangling shebang in /lkp/benchmarks/python3/lib/python3.8/turtledemo/fractalcurves.py from /usr/bin/env python3 to #!/usr/bin/python3
> > mangling shebang in /lkp/benchmarks/python3/lib/python3.8/turtledemo/lindenmayer.py from /usr/bin/env python3 to #!/usr/bin/python3
> > mangling shebang in /lkp/benchmarks/python3/lib/python3.8/turtledemo/minimal_hanoi.py from /usr/bin/env python3 to #!/usr/bin/python3
> > mangling shebang in /lkp/benchmarks/python3/lib/python3.8/turtledemo/paint.py from /usr/bin/env python3 to #!/usr/bin/python3
> > mangling shebang in /lkp/benchmarks/python3/lib/python3.8/turtledemo/peace.py from /usr/bin/env python3 to #!/usr/bin/python3
> > mangling shebang in /lkp/benchmarks/python3/lib/python3.8/turtledemo/penrose.py from /usr/bin/env python3 to #!/usr/bin/python3
> > mangling shebang in /lkp/benchmarks/python3/lib/python3.8/turtledemo/planet_and_moon.py from /usr/bin/env python3 to #!/usr/bin/python3
> > mangling shebang in /lkp/benchmarks/python3/lib/python3.8/turtledemo/tree.py from /usr/bin/env python3 to #!/usr/bin/python3
> > *** WARNING: ./lkp/benchmarks/python3/lib/python3.8/turtledemo/two_canvases.py is executable but has no shebang, removing executable bit
> > mangling shebang in /lkp/benchmarks/python3/lib/python3.8/turtledemo/yinyang.py from /usr/bin/env python3 to #!/usr/bin/python3
> > *** WARNING: ./lkp/benchmarks/python3/lib/python3.8/idlelib/idle.bat is executable but has no shebang, removing executable bit
> > mangling shebang in /lkp/benchmarks/python3/lib/python3.8/idlelib/pyshell.py from /usr/bin/env python3 to #!/usr/bin/python3
> > mangling shebang in /lkp/benchmarks/python3/lib/python3.8/test/ziptestdata/exe_with_z64 from /bin/bash to #!/usr/bin/bash
> > mangling shebang in /lkp/benchmarks/python3/lib/python3.8/test/ziptestdata/exe_with_zip from /bin/bash to #!/usr/bin/bash
> > mangling shebang in /lkp/benchmarks/python3/lib/python3.8/test/ziptestdata/header.sh from /bin/bash to #!/usr/bin/bash
> > mangling shebang in /lkp/benchmarks/python3/lib/python3.8/test/bisect_cmd.py from /usr/bin/env python3 to #!/usr/bin/python3
> > mangling shebang in /lkp/benchmarks/python3/lib/python3.8/test/curses_tests.py from /usr/bin/env python3 to #!/usr/bin/python3
> > mangling shebang in /lkp/benchmarks/python3/lib/python3.8/test/regrtest.py from /usr/bin/env python3 to #!/usr/bin/python3
> > mangling shebang in /lkp/benchmarks/python3/lib/python3.8/test/re_tests.py from /usr/bin/env python3 to #!/usr/bin/python3
> > *** WARNING: ./lkp/benchmarks/python3/lib/python3.8/test/test_dataclasses.py is executable but has no shebang, removing executable bit
> > mangling shebang in /lkp/benchmarks/python3/lib/python3.8/base64.py from /usr/bin/env python3 to #!/usr/bin/python3
> > mangling shebang in /lkp/benchmarks/python3/lib/python3.8/cProfile.py from /usr/bin/env python3 to #!/usr/bin/python3
> > mangling shebang in /lkp/benchmarks/python3/lib/python3.8/pdb.py from /usr/bin/env python3 to #!/usr/bin/python3
> > mangling shebang in /lkp/benchmarks/python3/lib/python3.8/platform.py from /usr/bin/env python3 to #!/usr/bin/python3
> > mangling shebang in /lkp/benchmarks/python3/lib/python3.8/profile.py from /usr/bin/env python3 to #!/usr/bin/python3
> > mangling shebang in /lkp/benchmarks/python3/lib/python3.8/quopri.py from /usr/bin/env python3 to #!/usr/bin/python3
> > mangling shebang in /lkp/benchmarks/python3/lib/python3.8/smtpd.py from /usr/bin/env python3 to #!/usr/bin/python3
> > mangling shebang in /lkp/benchmarks/python3/lib/python3.8/smtplib.py from /usr/bin/env python3 to #!/usr/bin/python3
> > mangling shebang in /lkp/benchmarks/python3/lib/python3.8/tabnanny.py from /usr/bin/env python3 to #!/usr/bin/python3
> > mangling shebang in /lkp/benchmarks/python3/lib/python3.8/tarfile.py from /usr/bin/env python3 to #!/usr/bin/python3
> > mangling shebang in /lkp/benchmarks/python3/lib/python3.8/timeit.py from /usr/bin/env python3 to #!/usr/bin/python3
> > mangling shebang in /lkp/benchmarks/python3/lib/python3.8/trace.py from /usr/bin/env python3 to #!/usr/bin/python3
> > mangling shebang in /lkp/benchmarks/python3/lib/python3.8/uu.py from /usr/bin/env python3 to #!/usr/bin/python3
> > mangling shebang in /lkp/benchmarks/python3/lib/python3.8/webbrowser.py from /usr/bin/env python3 to #!/usr/bin/python3
> > mangling shebang in /lkp/benchmarks/will-it-scale/runalltests from /bin/sh to #!/usr/bin/sh
> > error: Bad exit status from /var/tmp/rpm-tmp.Py4eQi (%install)
> > 
> > RPM build warnings:
> >    source_date_epoch_from_changelog set but %changelog is missing
> > 
> > RPM build errors:
> >    Bad exit status from /var/tmp/rpm-tmp.Py4eQi (%install)
> > error: open of /export/xfs/lkp-tests/programs/will-it-scale/pkg/rpm_build/RPMS/will-it-scale-LKP.rpm failed: No such file or directory
> > ==> WARNING: Failed to install built package(s).
> > [cel@manet lkp-tests]$
> > 
> > I'm on Fedora 38 x86_64.
> > 
> > 
> > --
> > Chuck Lever
> 
> 
> --
> Chuck Lever
> 
> 
> 
