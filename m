Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D5472ABEC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jun 2023 15:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbjFJN6X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Jun 2023 09:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjFJN6V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Jun 2023 09:58:21 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414833A8D;
        Sat, 10 Jun 2023 06:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686405500; x=1717941500;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=X0/KgWlrskqzqASOXiWuDGPoVAZ2qii1ds68VKxLtd8=;
  b=ZvI+bdOWKeGpG6Ipb9UlcCMpLLuUzQKndo27Wb1bmb0kEw00zVtjUmIe
   UCkvkLJIh4r8i+Ze9L/aE9G+ATUuEBu8TohjfO8Ro4A9smA44Tfeo+nFV
   Kqz8yPmBS5QLqABzZFcMxn7nMqMIXfgwRD6zTvaUfenvD8IMkIiArOjEC
   psZw6otGG+MiZUAHKglz4Igu6nEA9lZ1ZEqmSUWlw4sAKZbESyjf1QvgD
   KYU+0erye3tZ2Q3Gu2lKskRQQdxGreLaOpRFjboieVkhmc3jUUYauYdnm
   FirZUfy60aBoUbXa5mooqrGmugjbTV9xchofPIaEe3bNWVaBuAmiAz4UO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10737"; a="421357609"
X-IronPort-AV: E=Sophos;i="6.00,232,1681196400"; 
   d="scan'208";a="421357609"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2023 06:58:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10737"; a="780639920"
X-IronPort-AV: E=Sophos;i="6.00,232,1681196400"; 
   d="scan'208";a="780639920"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 10 Jun 2023 06:58:19 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 10 Jun 2023 06:58:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 10 Jun 2023 06:58:18 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sat, 10 Jun 2023 06:58:18 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sat, 10 Jun 2023 06:58:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrslMywDj9GrCEko99J4TlSOxkJ6UudE8/5dPGJUNjsn/M+FwB5LDM2calcV5ZQQKY5PugB+CPUmnlPXeW0xx6fFgLyOOJnXYtMP1hwmfpdTy6Ck5mib6yLMrW1oQxYE8aqdFNuY3GFqV+O6XV9O5k7QhQqRCFKBD5kJaZvx6e087jgMIYGRzcLLeerMhwl45pAu2s/KQNmHWUEwQ+FFdo7VaJRx+bEPu2DHs/ysXdqkwiZzyqt/xH9e9t6+VJs/oN1BvhvInDCd/yY634+7wo7kXnVsJ5poi0KWug1nod1uFX6aZ+wwH1oz0RGvmIjduZUFc8QrBdIan+ynFhgTIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5fO34VYbU/5e2TRASngm14qXfq67K1guqtlj6Ucqpo=;
 b=S23wJi7rn65BaY5kgizDddhfEtPdZp/Xt8IPwCA6slafoV0NcWgpa+1FLBdEvhz3QdRFjRDYOZKjIVJT99gMm8B+XjeX7v7IW0rOU2Bv8WtoaOmVmmR8VUNyLUQG8uhASvhqliIeGd12yPxYCywMVt8y7ably/ayERFkFyS0WG4OJJqwKTfrmo5ltRNqFplpmcKcimrXN3L8StywGBMxiSJDazwKSuddZxrSF8AjHNzddubl2v4XMZDoI/4HQvmmzjeldTVW+/gEgVmlH31DnYjEtK/gOhFho8ldTpUF66aEyHtzKSlvpbfzUmzUkmzhKPt/3RGkOjMIPMpNxwvVMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by CO1PR11MB4946.namprd11.prod.outlook.com (2603:10b6:303:9e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Sat, 10 Jun
 2023 13:58:13 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::35cf:8518:48ea:b10a]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::35cf:8518:48ea:b10a%6]) with mapi id 15.20.6455.028; Sat, 10 Jun 2023
 13:58:13 +0000
Date:   Sat, 10 Jun 2023 21:58:01 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Joel Granados <j.granados@samsung.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <mcgrof@kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 6/8] test_sysclt: Test for registering a mount point
Message-ID: <ZISBafxGTnw89EtV@xsang-OptiPlex-9020>
References: <CGME20230604144143eucas1p1ba7a3773905187be28571e973ef6e118@eucas1p1.samsung.com>
 <202306042234.f2d7beff-oliver.sang@intel.com>
 <20230606092717.uesyzrptbsbzefbq@localhost>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230606092717.uesyzrptbsbzefbq@localhost>
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|CO1PR11MB4946:EE_
X-MS-Office365-Filtering-Correlation-Id: 9239f242-b15f-4aed-cdfa-08db69babb12
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o4b0rKgbwfCTQzk4lA3fozGNQq6+muaO+DpdDedMjyY3bnh3TT3AKIVdVHBRBGcXSJRNtodzpwZOeYjR7+A3+gwfiyDal60qeAA+yGVVmQ7/2MPGDODsriT6UoUkKm9OQ2F/vECmxEVPyMQVuwVsHl7T9iStCnSr8Ws0pctUIwxKK8EMapUj7+Uh0QIujXLeE5D183VCQklnS/EpyhoMrrXrlr5411NzbZ2pGQlfCUkh3uMqG0dDfGEvPnCRiGGeiS0/BptKrnVHdQPaSwR1YaNG/OH1XOk1q90RMPqlIfyQTP2+Y4BIkSf/i/6c8jDa47Ebq+0Clo49UVIYiAxssoR1Wdkx81xRi/qxFiFQ+X+zZySC0ksgsdi3rvMdg6p2sVnVds9ACEvrOX9iw8PkBDRx+xW8wSzXs9uOFfSuZC49XkXtSS097VQp4HqHCs9vDY4RCRPpOVjdppXK62fq1OJfDQqGj/+g5O2qhnrb8XIBxfLv97SkA3ap5VY2H6vH/fSD1R3go0B47M6eYLNpFRxKProV6aByWCXBfN2UCM4AQnQmfn54MBlC5cqkZpNT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199021)(83380400001)(9686003)(26005)(6512007)(6506007)(41300700001)(316002)(82960400001)(38100700002)(186003)(6486002)(6666004)(86362001)(2906002)(5660300002)(8676002)(8936002)(33716001)(66556008)(6916009)(66476007)(66946007)(4326008)(478600001)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j/2MFK/96jhyOmohNkFELwxiX9K09+X65vtHkMSJsUmEj1gfPyIhM7uiXy61?=
 =?us-ascii?Q?8aycV1qJjGJh1YKk1pgjox94SLMYi0u/rI7MdKI9y3k0ouw1P8OHZZ3+whXs?=
 =?us-ascii?Q?/FyX5ANlGfekPrBjZZVBKFyZDPpWFHYCcmhFAvna4B8uLWiU57x8nlvargq0?=
 =?us-ascii?Q?BiXnOrQXFV3UWIVoDN8iWIbJcH6oPz1wejxXYBV1qmDUkHrKMyC8H+s0Y3bu?=
 =?us-ascii?Q?eR4jd18C8+XZwsyJsEjDcuFaOeIoWV6H5ORNnsVbT6i+S2kYNJQnotJf1sAt?=
 =?us-ascii?Q?fImnRK5qvKm7q+M3Ikzs48dk1MfXvNDg/uT/Divs7yiiMnOuKVFOR/vXELlh?=
 =?us-ascii?Q?e0K3ppRsNIhsD8IRTpY+PhXvWzq/U4Kj+BazGnVXF5ZkryaKeF0ZYlOsAijR?=
 =?us-ascii?Q?guYAmft3GaHtIW5oZ55MGZlH8DRHUgGNcjP6sQTniqBmORrXmG6lEEEhy4NE?=
 =?us-ascii?Q?O02PDzRUjbUeTpUtN3MQjcnGjpAlKVxoL6sugEbDTWPS3vK7S99+T6+hc0el?=
 =?us-ascii?Q?/iCeGbPY1/Reh05ivg4xNC7byFzp7c5lbWXBj0DJxA4/0rFNnzb1lI/RhMth?=
 =?us-ascii?Q?Pupr81QlkfLgYysNr/vIy2FaRYFcfkKz1vs00UQXny/1FT5Qimi3GGPlFOjr?=
 =?us-ascii?Q?YNdxlj9LLxhKSNj7fqKynV4tkLk2ffGfMS4MfLzFeJB+qJmOtbWmksGRrX4n?=
 =?us-ascii?Q?1xjEuFMRrTuIt3PuQ9Qf88WFSxn6CCtL3oFTSQVUcy41hI1yfhjxoN0aPDND?=
 =?us-ascii?Q?K/ilsUH2vDO7dddVCFh00q9bMllrX/1+0xpHMal2AH/f+ZJtn+7FIbuQDvE+?=
 =?us-ascii?Q?RSjuaBY6AOV97aagF6e8SvigIT/aBa8fhERORxM6NkkyHAW0VWIaDA5SMN6v?=
 =?us-ascii?Q?+7u1O12sPUqAZC2wHG/19IKKgSrhti9+9vmaYPMjmTrhzSuMZlxvSckEVHQv?=
 =?us-ascii?Q?rCN3/QKp1fBaITTtGuTGFYG/KIDVWyPdCb4xICDTPD/0SPVpg9s5gdd6TtZv?=
 =?us-ascii?Q?fnG+rO59w356/8poCd7GiAvTvOQ0uo/oRc+J2Ce3gU3IjCIdWz2N087Do3o/?=
 =?us-ascii?Q?XALjYb6PpUA83asFQ0/tXfcsjEDDjlUOZZlWFsPuwxC1kw6NW/J0V9JqSXid?=
 =?us-ascii?Q?pE6aJRRjD07HJp3aeSLS5ZQ6bx3YYyR8JFCtjzgnIr0XFT2jgmOX5bDQg3Te?=
 =?us-ascii?Q?SUZ+IvEjqECmGwjSimgoUAv3hgFZ0m5o56IZr/p64BSwZLBVrwh7pMG/0WOb?=
 =?us-ascii?Q?73mgRjWLpxQhJuCo3vw6uQC8m/5Wiq2HvDzM+oL5DJx2xUdSnW/TgjM5D4fK?=
 =?us-ascii?Q?Q840vfxdf+2WFPcFF9/emK4PrwcZ/hp47E4ixtmGdIk9jqlzabwliwuzTlpi?=
 =?us-ascii?Q?X1VYEBfydCJM4WQoG7IlfFSoUgDoMXXKh6DFf6qei5UN2KsYDLXOu5x3GSZm?=
 =?us-ascii?Q?JrSxQOZcid7mUi1YMn4j7iBk9E6MaphKA136bna1xw+ruPLlwEXcWLPMGY/S?=
 =?us-ascii?Q?y/WbYOicXW27fNySSNcL5g/t3XHyLkGSZuxmDtL+KW2Jn90TzPszbg8WZutI?=
 =?us-ascii?Q?nUA9cS/3loQSu1P+y5pdQQXhi197j7sMH8Dp8tMC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9239f242-b15f-4aed-cdfa-08db69babb12
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2023 13:58:12.9572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t2Wektm3y9aUijnlS0++IqNA+zVlS+iRJaCiLhA9Xq3yoM5iuESY+Uf6DuHMnLUTvcqpwT6L0OFdliApG/7mXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4946
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

hi Joel Granados,

On Tue, Jun 06, 2023 at 11:27:17AM +0200, Joel Granados wrote:
> On Sun, Jun 04, 2023 at 10:41:05PM +0800, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed "sysctl_could_not_get_directory" on:
> > 
> > commit: 1997935e918fa4c07b70be47ef8f37622df427bd ("[PATCH 6/8] test_sysclt: Test for registering a mount point")
[...]
> > [ 15.271017][ T1] initcall io_uring_init+0x0/0x40 returned 0 after 87 usecs 
> > [ 15.272122][ T1] calling test_firmware_init+0x0/0x190 @ 1 
> > [   15.274422][    T1] test_firmware: interface ready
> > [ 15.275240][ T1] initcall test_firmware_init+0x0/0x190 returned 0 after 2200 usecs 
> > [ 15.276480][ T1] calling test_sysctl_init+0x0/0x630 @ 1 
> > [   15.277687][    T1] sysctl could not get directory: /debug/test_sysctl/mnt/mnt_error -30
> 
> This is precisely what I'm trying to test. I'm trying to create a
> directory on top of a permanently empty directory and expecting the
> failure and checking to see that the mnt_error directory was not
> created.

got it, thanks for information! now we noticed this commit is already in
linux-next/master, we ignored the similar alert from test results.

> 
> @mcgrof: Can we just ignore this 0-day report as a false positive?
> 
> Best
> 
> 
