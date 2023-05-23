Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B968C70D424
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 08:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbjEWGm2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 02:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjEWGmZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 02:42:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FF8109;
        Mon, 22 May 2023 23:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684824143; x=1716360143;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=l96wwqGXoD09WRBUohYBhQgyE3yqpNe68h7vG3Kk/ik=;
  b=EEAAJeOsctGKTURKWnIypsRVCGXYoY6OzsPwQ0Yru6sOO7cZ9VtGa/I1
   sXEQikUYIlyHxLFzsdEpcAhFpggYaOqInTWnNKht2iCYY52KJZmx3qrNv
   YMDSwNzp9zm+uWm1FACBQvidy2yZtUanMOEvdCQoYXBOY97W4qWz77djZ
   bMm5nL2Wdm/k8qW1zOU4uJtDO/nCoJbyBS/JGLacf7WhHFoTQJwRi40R2
   Pue2NIHSQkndEbCTFfuAVoX4EUI98eBdl/i/zI+L2de27pGcHIGFfZuNe
   sAayWEBVq3GdW6dchKB7Sk+R9IypHj32++jikLC5B+qUsYYydKEDnX6M+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="418857444"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="418857444"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 23:42:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="773698587"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="773698587"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 22 May 2023 23:42:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 23:42:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 23:42:06 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 22 May 2023 23:42:06 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 22 May 2023 23:42:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4/kUhBK3Byt1Ino+uHKoQvHm8Jg/CQTutGbvWvo7K3P4HeGB6ihHo3cKVdp8yT4BHZfGNLUrLk5sy49k1GguD4xclpHqhTP97YjPWou5DkWyhmA5nNBvMhjHqYEMkI8tsaxfA+S0xdtTDL3KNNae0uuRPPN9aBpu0uVgqu2hYtP5sVrVyvRnIpHnlQGErzxAfJo/tkY0eyPVAzNFxlBeBK2oBMOfENpWz53D/sJ9P/l9OpLYbVQBozjsEK4GtJ3ualqlGPMEGiJeOlXRSugJDJvY2rAZuyg7QQ197Tr7axjAWFDrFdy21pGpbjZIxU9gr17Wkxgvs+3UBOCa+j/dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEkTPAHrvpLorXwpmncEpwz7zbFMIoLp3rgaas9aKqc=;
 b=VEfpOf6FpUBdgNRbWSyM8G30o+8NfdDaW29sGJ8ByQXXSF4TVa6fjGxS6gEky+ywFyStNQEH7awQ+gMnzhPWjC33iZPlcYyPn/YQE5K57G2pEV/8mS9PEyw4Q1uJPs1Sgeaf7XE0wFhO4WxQ5nfPDVhsDfjIuokW77u9apNoHwtCYpKtV8qbYs9dfre3xFT5RzigWje4/Cjna2U31xYEhs8/YrfplYSWWzs4YtdhVwYXktreuca1JnFZlfPMcOKqUtZUDasrI0ANQBD4KWXVAKyxWRgkCwXwAqLxpxwc5UpwhdEM8ltlYMTjaa4m25wRVHmls/9p/sV8WxX7C6kApw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by IA0PR11MB7791.namprd11.prod.outlook.com (2603:10b6:208:401::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 06:42:04 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::7ca2:120f:99dd:7812]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::7ca2:120f:99dd:7812%4]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 06:42:04 +0000
Date:   Tue, 23 May 2023 14:44:02 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
CC:     Linux regressions mailing list <regressions@lists.linux.dev>,
        "Darrick J. Wong" <djwong@kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <heng.su@intel.com>,
        <dchinner@redhat.com>, <lkp@intel.com>
Subject: Re: [Syzkaller & bisect] There is BUG: unable to handle kernel NULL
 pointer dereference in xfs_extent_free_diff_items in v6.4-rc3
Message-ID: <ZGxgshkmJ5+24etW@xpf.sh.intel.com>
References: <ZGrOYDZf+k0i4jyM@xpf.sh.intel.com>
 <ZGsOH5D5vLTLWzoB@debian.me>
 <20230522160525.GB11620@frogsfrogsfrogs>
 <aa3fcf2f-013b-358f-e2d3-205e40b6908a@leemhuis.info>
 <89b7cfee-164a-470e-c375-73b109fdf214@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <89b7cfee-164a-470e-c375-73b109fdf214@gmail.com>
X-ClientProxiedBy: SGAP274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::28)
 To PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|IA0PR11MB7791:EE_
X-MS-Office365-Filtering-Correlation-Id: 4869b2db-4203-4f1a-0670-08db5b58d1d4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qw2oaccox9n0ULZ/lMQKQ7QT7DNHcxI0vMQ18Sf9MYpaD/gmV13eDUUYiqOaD5sXcaqu8NZlfDS+ufqTDDOgYA42B2uCxu6cbLI+sz19rVs3pyb9Fa2sjwk04B5raiZsNgVAWBNcD+d3/RQgWrJBW05w9HcMmh7Wr0wVAZ8mpbt73++OuFX+QUqdMhTUpWzLFaWgvWSgxH5j3Lx15RrXBUvIT+pZsVMrbhZuqbj77dNrNGvd1WIJlPSQbjW4xqQviZPvnKv8/zqgSgPvAeo4e2X+ljExD0VVZONnmer3ROfqhMxRp7ek1TRCXu+utoX2BcDON6DgfvwEHF+P3PwFOUHWrgIq45yim06vxuhqJTYJKoXlgZHebzYpXG+vatmTJc+eUaqcR/tfdWpTCl2THWfCVLKf8v/Mw2VGAa4/19UsoYXtJke6LFCcSHFl5e70KbxTtqYXLT1y7rU9n9C2CGlWT8ker4tZgkwxRs8vG8WEb01rs1OWHA+J5pefSY579nCP7naXtou82kNo++AOCDSzsKr9PuRb2ib2OhhjIbiS1S1Pn/wKDcQULXIs4JaOr8Av/5SEg7pBlPnGmw5W5r4963vK8EX/dkmKPFw1Ztw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199021)(53546011)(26005)(186003)(54906003)(44832011)(6512007)(6506007)(86362001)(6916009)(66476007)(66556008)(4326008)(66946007)(316002)(478600001)(107886003)(82960400001)(41300700001)(2906002)(83380400001)(38100700002)(5660300002)(8936002)(8676002)(6486002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ON2DHCTsSlTsyLPgcEZw+PVsdYIot2nQIoHhAHXPNN3gMV8fHjq2J7iDgYEA?=
 =?us-ascii?Q?hnrJ15UG7C1r0nZvekZmdysEB/joifmrxyb41OyDu/fSTUp8XkYoCpZ6ct9b?=
 =?us-ascii?Q?yMeYbOM3PPdJj+rlKKRLa21P+7t3J2Z/PuNEMYNUQ2qbitBdzaQsjEzD0Kr4?=
 =?us-ascii?Q?JK1TN7CGQpuMkshRJ48oWQgn+rpcpoAnUVSLCWt7LvoIDk9GKVMD4rGuX2Cg?=
 =?us-ascii?Q?UQOECNG1gPCBiVWEOfXzSEr2UD46QRghEiJw8uXamTcYLOPQ1O4jcjG2BAZ9?=
 =?us-ascii?Q?mwNNNsl6H60zzNzlkvzFkg9Xk1rYgpYLmCc/TjFeTbAObO/Z+ZbYXVMXkzV2?=
 =?us-ascii?Q?Tx5H2CV0zdIZe42Vn0kzDJmEjM7sBQWCfy8bK5Udhh9i4s1OvRQy8mVc50Wt?=
 =?us-ascii?Q?2b9UZuHMgGiIXZy7emisGwsyz8b8ce2fGmJ8y3pc6+VKyOl5KWyzlf0zk3Pq?=
 =?us-ascii?Q?HRccp3pfEDpCqCAMtSIucZAk1Rk/MT/eqSVUZG3x8f5CdxbaKRXhZUFBHsI8?=
 =?us-ascii?Q?8Dp6E7hLYjCtGgPsQ8KMFcFJLJuttYtDdav/kW/RvzchaNHWN9e0SDk8/ORC?=
 =?us-ascii?Q?3c6pnBKhT/Ffcd4GsJ9e1S0VKLuaAriptFkYtAu2CdEzcEwzVgw2UsP8c7mK?=
 =?us-ascii?Q?27EItw9cc5C3daniBMPQq6HtlfV88CyNbcrpq6mLB3JILYqvxn/qMojeg1ln?=
 =?us-ascii?Q?9VACC9Iz/KULjhV5QjFrfeJ8V5Hf0WXtC1gXy7fjq1lI7sbA//RrXfaY99LY?=
 =?us-ascii?Q?y3e5VnuD1bSD6u2Hm+/swcg3xkc5r8GrosEPrCQSZKLKyVa8qRba5nCimYi6?=
 =?us-ascii?Q?Rr6VLKxaRPQgtpLgUqh5XdfoK2sZnc1npC292/7E9gChBqgpROOTFZyE9Yks?=
 =?us-ascii?Q?gs64DK/WgTs5/iCIn13yeITurXQMOWxrApxYUfoP2d0uEatmzD+IJOsbhc/k?=
 =?us-ascii?Q?/X0MRpEtw8BLVZQ9ojSnujAasQVZcYNm9q99lL9bXuzfjhBByBpqKTPrD9ZV?=
 =?us-ascii?Q?p7nUvWtkSSdKv3HG3fA34sFr/tflxw379s5yN174+MEFqSM6oONolxzjZLZc?=
 =?us-ascii?Q?QM6iWL61CnGTBQ0LvNpqN9rSOGL9WkQMdFOpBi30FlMIHICgJ8Um6qu/xKqZ?=
 =?us-ascii?Q?J5eiuXlLRMe/xFUQnlBf24i3fIou0/BaxesNvbiuKAiRxTzdpMK0jAnOn7Vj?=
 =?us-ascii?Q?Kpy0MtfbvTC54OAL3DG1Lc4LTZD+Kc+t6RBunpjrOf3E8U2jdRv8MqMRix/W?=
 =?us-ascii?Q?1kENLeFYIE+b2wtx4SSF4vuP4cmTEZOuZGHH6al2gwltASFTWzLk/MDC4NK7?=
 =?us-ascii?Q?VUVVlXhVr3rPZZlkk5xIZ4CHAk2dd8bK2R6J7bfkmb4z1OjXg/SaIl2DV1zR?=
 =?us-ascii?Q?WP5VsMDypQVMvd4EGCd3mxAfDPByYQv6wLuoFXDZcLeAotNhac6oh09jGtPl?=
 =?us-ascii?Q?Z2SbKXy9Jd3XkSZJ/4tLIm8o0k5kKxax31SBlDFuDpfrDbqgdFnfbf9QjJfR?=
 =?us-ascii?Q?T/dZJ2aLo451V4ot6a3lM8ob3tjYB43t/Zw7OgO+HHHqV6cTfk6hPusiT07M?=
 =?us-ascii?Q?ekx2ZmqfR3siAn8YNSpDQNV9yOP8exNHxlg04myL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4869b2db-4203-4f1a-0670-08db5b58d1d4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 06:42:04.1031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6YmA873HLyRPcTvZFVmGwaxExjF7OY6mwF7cpWr4i8vypMn69AB6vSyvgIKcJ7EqdnQwbVa5eMHFs1suMTlZLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7791
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Bagas Sanjaya,

On 2023-05-23 at 13:08:32 +0700, Bagas Sanjaya wrote:
> On 5/23/23 00:05, Linux regression tracking (Thorsten Leemhuis) wrote:
> > Darrick, sorry for the trouble. Bagas recently out of the blue started
> > to help with adding regressions to the tracking. That's great, but OTOH
> > it means that it's likely time to write a few things up that are obvious
> > to some of us and myself.
> > 
> > Bagas, please for the foreseeable future don't add regressions found by
> > syzkaller to the regression tracking, unless some well known developer
> > actually looked into the issue and indicated that it's something that
> > needs to be fixed.
> > 
> > Syzbot is great. But it occasionally does odd things or goes of the
> > rails. And in can easily find problems that didn't happen in an earlier
> > version, but are unlikely to be encountered by users in practice (aka
> > "in the wild"). And we normally don't consider those regressions that
> > needs to be fixed.
> > 
> 
> Oops, at the moment I didn't know how to distinguish true regressions
> and issues found by the bot, so I thought that both are regressions.
> 
> Thanks for the tip!
> 
  The bisect used keyword "xfs_extent_free_diff_items" to bisect, and seems
  it's not accurate this time. I will consider improving it.

  Thanks!
  BR.

> -- 
> An old man doll... just what I always wanted! - Clara
> 
