Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23EF590976
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Aug 2022 02:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbiHLALz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Aug 2022 20:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234978AbiHLALv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Aug 2022 20:11:51 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDBA12D0B;
        Thu, 11 Aug 2022 17:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660263110; x=1691799110;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5wS6rrV06BCw25YCOy+fEIRI8J6W/lqIIvEQMG6v5eQ=;
  b=eysnshAuwKfrElzi6Lp0y/Mhc9+DOyBuFCcEiEnx8iLocphq1bJB534R
   2ZuehWsaUvDx4PcOKOGCewzZlepDwitqDwjKZArO0jSXE4e7fFaxUjaZF
   s8O3KvVMYM5jsokZuh8Yh9WAmO35uniz3AfY+Kk/R2Xl48YVAnK9Iybiy
   3aLytLFnCMVFJUDQVELDQ7PszIiXMZvUJxNwxD7dbBT9sAr8p0Z8B4L0S
   /+c3ZS9DItVyc/bZfXdGvhht5o9tYdcKjJApmpNUYgPcolI0WWhsy6Qq5
   N5DH8crvzMFY+jyYMrPs/PNnFtURgpJ98vnNYPSpp0V/7VkQfk3NJCHEV
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="355493922"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="355493922"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 17:11:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="556333922"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 11 Aug 2022 17:11:49 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 11 Aug 2022 17:11:49 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 11 Aug 2022 17:11:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 11 Aug 2022 17:11:48 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 11 Aug 2022 17:11:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBDH5q6WOduiFoCyyLjaWMhQchifUZ/tSGr7Rd7tmqKoi4xzzfQh0nRYoCDydxaSwEi8QVUDdEApkxGm3X3cD8PPNUqcCf+1RJRcnH0HdBrFZFw6Za/RBgEIMcWiC8JHn4v3B3IHYni0UlxZBmbZ+o1klZBT847Q94EaMGXOTpv2v1Nm7WT4e+uqcdgSFVueULXJtcAcWqvPimaNUYzPKwXzwPir1iA3SocJog9RwrPxSvOwlFGxva1XGC/nEJOHi018b86gQUIjyd7ENAPmzQMMKmtrftaBJMSVPqykIxgJ9G6VQJ1ba0bg1TiJhiVsaa52V7/tpfnwv/neZopeZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBhHUTH+9GNdied5TFUcxqx3/6ELyQz6yXp/rza8D8k=;
 b=EIjCqYmXp14+2qARIqHFux2M1kTxDpFdu8nv2Y6Bjluh3CjCB7BXZRsXxxN+Y86p3/nppMcBioLFz56bACI1gGdxfs+M9qAlKZpElQcj/A+3ednWSjY9U9AXaSSq0NyoZWr2ZtAKzSkig70s3kQY9Hbj2GSOuQ2u2yGJM2uPl8lBOPz105kVJxAXUmuv6fSfHf/fbPJzhtW0mm1ywVA2PNYmkLfL2uNa7AtueqnMuQbuM8QsRSjnMKhs4l+fCR8kDiuD5KtsrAKiDKUwKfm/xQO3GmmIjIS4r8IY9LqBPghKt1UbARv+lSP4JpGHByNV8oAKDwvQV2MQPb17sp1Jmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 BN9PR11MB5452.namprd11.prod.outlook.com (2603:10b6:408:101::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Fri, 12 Aug
 2022 00:11:26 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::a85f:4978:86e2:8b44]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::a85f:4978:86e2:8b44%7]) with mapi id 15.20.5525.011; Fri, 12 Aug 2022
 00:11:25 +0000
Date:   Thu, 11 Aug 2022 17:11:22 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Kees Cook <keescook@chromium.org>
CC:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        <ebiederm@xmission.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-next@vger.kernel.org>, <sfr@canb.auug.org.au>,
        <syzkaller-bugs@googlegroups.com>, <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+3250d9c8925ef29e975f@syzkaller.appspotmail.com>
Subject: Re: [syzbot] linux-next boot error: BUG: unable to handle kernel
 paging request in kernel_execve
Message-ID: <YvWaqhLGsBp9ynIq@iweiny-desk3>
References: <0000000000008c0ba505e5f22066@google.com>
 <202208110830.8F528D6737@keescook>
 <YvU+0UHrn9Ab4rR8@iweiny-desk3>
 <YvVPtuel8NMmiTKk@iweiny-desk3>
 <202208111356.97951D32@keescook>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202208111356.97951D32@keescook>
X-ClientProxiedBy: SJ0PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::28) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 000bb078-9de0-438c-b6b5-08da7bf7324c
X-MS-TrafficTypeDiagnostic: BN9PR11MB5452:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VzG22P7ajQJC28Knv+d8741SuBzOPc9MXRvpg85uPcaud+UMKuA4d6/b9pbOuSqCkyUQsuvH+3EVVYEvK3Ko8Tlp8PrpFB5mh4ecRK7zB2eVhc3G9Ikm7WVBr2mldqbNrOq4/jQW0xehdpG4nX8t6/tZ+Wpu/XwsfbU95IgsJY6hr5fPOcWMznZ1z85iT5HOCsaSh5M/1GM/+jaEB1wEjAxxNARo4xfRD7sVjq2EuHwj00oqSKZJvBcknKtPNKmYPNNEsdAQJeP6V1qxI1jqENs5eFxS6/LfV8ZOyaUNvrt06a58hafy0ngPpCNl8svrAel/+FGvKTRBGqoZW0z4pXPFkAsQG0Js6P8Zv2EmB7CHB2XdYqAhAL9LnC/hg5q/0STkTaadCgQGghkCNa79EqU1rF4GEEpLEHZfrz32uJPqv0F2J+h5ih4mn0weyrbU52HRSss183kmMSwiqoTTGCBpurXuwrS3iK0l+tuOymIJH62V7YfLU8alYi3vfCAaaxqN0JLkH/64SqEbeoVAMrkm0TtZLYCrPsKqZnVTWZweICAnjmMy1H+IhdR2XMvicDSQ7fSCWwmdBfjnSL9nF/PE/qZeDhiMHuLKHf3Wb0MvJ4xgk4NSv2MwDFNi0Rd2VjoaqnJfyy+kv90Vh73XuAB8iYhQ3y3AxIfUS0cXpcRvYzVG/Z4UTxY76Rl6n0DsbsOBX2JpVFnp2rNyYty58G8w3zwct3uvoJAZYENHzwOWkUFf7znfRlfnczr5a5BvMEXeVVjbM2jyOnSkcQXxOZDuAZE1ecbN9246BhDgzeiCfhn/8BNDz7wg+dNP6dxU50skvi5MDCN6/F7G3RrY2HIEjYJ9CehD7G6xHw+//lI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(396003)(39860400002)(136003)(376002)(346002)(186003)(83380400001)(82960400001)(33716001)(38100700002)(478600001)(966005)(6486002)(66556008)(316002)(6666004)(41300700001)(6916009)(7416002)(44832011)(5660300002)(54906003)(6512007)(2906002)(8936002)(26005)(66946007)(8676002)(9686003)(66476007)(4326008)(86362001)(6506007)(99710200001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qrMoW/YS1R1M6aP+D/hrCEkP2HlRwtDAeb4muJnA25Yhdhy+pvXuzgFQjQy5?=
 =?us-ascii?Q?gzC18t+5faUqFtf9aJw0PnWgqm3ORgCZV90yuiewCyb0F5hGYjfQPmJ79VQE?=
 =?us-ascii?Q?EYA75heZoPDQ8xDNSTbA9EqTGib+t5k1fQPVF5P0wH53mRYY/i/AVJzoC2bV?=
 =?us-ascii?Q?S6kgU+Be/395QZ3Ui3enB0YrRWH6zZlY5bwuMmcyufQqq76LvXMEm3OePMmf?=
 =?us-ascii?Q?IZLPOrHLHEK5XrJLwbmvU6W1Yt4uTOjcFrrR6ifhxr7c/DfAUrF4LUJYsj5A?=
 =?us-ascii?Q?QyXsyG7MhFPptbH4KdDr+ZGFHKQd+rAqok7FzhvxPLULoi+slZAIptWZOZ9F?=
 =?us-ascii?Q?EhuHK6cBSlfug+nYtYWPOmpTfuFwwQ9WBVAMExD7HQabXaSS7YHb/tGMFCeU?=
 =?us-ascii?Q?NWdoGpVFjIyc1w7aDwuYZUgJ4Y5nwi7zJm+Ps+AV+Ixg85Moo3LeRLtoi6mk?=
 =?us-ascii?Q?xY/QdbER04QH8dqClhGdPK4AAPxDSRg6axV0iKz0apph0Lpnsmf9iXH8uacQ?=
 =?us-ascii?Q?O/FhVNr0nLPGlWw9nY+nCnFYVVATAt19iyTKRlj0+yyzsgR5uGf+R9fDG9Ni?=
 =?us-ascii?Q?4LBNvI8QjIm+KKRl5sNmRbtFlEesTWq7ckCPlCEBOidWdHnw0wA8a1UcaY40?=
 =?us-ascii?Q?xxzuEMiYrvLL/AFDjvdlmq828Z+7ct9+xM1B+9GNuZmyVLeZ/9f5l5oltAup?=
 =?us-ascii?Q?zFciI2afurmV+MamkG+rfHJL4Vldfbe9xB8Sm3+T6qd4/lS/r0vt7SDkRBP1?=
 =?us-ascii?Q?4dcJaWQ2F5brFQZOcddcw88bnsaGmcPc8mxjOB55e6pAvk/xQ4D7W8CGbFMT?=
 =?us-ascii?Q?Skc702tjeyke5dtEHKZ5g5v3LILn/QGN4jOSxdc+ch8WHYilgn5NTFrG4o03?=
 =?us-ascii?Q?DG5BEVuI4/+wOj5MV1kkD+O4b4FEAXgRWX/VjLeXTBOaFOPfMYN7fIV4sJWz?=
 =?us-ascii?Q?igMDYjN8dDaQxgb0fczZnSR2ZZEZ+83YZg73Suky1GqhWv9KHEqIuy6z6dJb?=
 =?us-ascii?Q?2/or6BL5q93H5g5PXUHnGNKHjgg1AiyEIMpjKowXux09PbNbmVQfHAIgsOol?=
 =?us-ascii?Q?dg01cSlm4bfQ8qiv1V0Ta4Xi828e+tGCmhYW5+Fre1+Tqhjr5AwjMVHcO+7e?=
 =?us-ascii?Q?z94pwNcuGAuvYcAQF4wXYK/plWL5WDtujOnv2xrBw8aBiFQE/uZhp6c3Br0u?=
 =?us-ascii?Q?VMETXUF4Qm9SAFSUXDGBGb6kqwhoq8QAFXM3dg0nrBHyJ7gD0FGMhoUy5FC1?=
 =?us-ascii?Q?+QjX1uz6WLVuPqpYFuAUdeOU8fn93d13j5iliZHhS7gLYZjDXLS7lekNMntJ?=
 =?us-ascii?Q?yvybgbKDmmwDnP0B/EIoJrptp7JfU1T3IZJ2yxiHziBrEdvRaqJzJaTeJqbu?=
 =?us-ascii?Q?vyV9QYUxN34l9CsteYMx+CIFyo3SnwFdKVXIWJP2IhUgpPIXnOl9lz5rIvqv?=
 =?us-ascii?Q?6n4EYpxvuqAchSpnhKF+UG29Z1YcKHc0gB2FV4S4xHCeq5KDRbR+qUuPOibc?=
 =?us-ascii?Q?MoBde6ClhYVVg+Uuj98hZeExVCz1Nb/UJB1YsUPmhrrL/oxv5LQA6RYTR25e?=
 =?us-ascii?Q?C+Qfz2v1vSB4OmVIW64kwwFNyjVCI/oFMu5nRzSs?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 000bb078-9de0-438c-b6b5-08da7bf7324c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 00:11:25.8623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WKgIsbnwHXc1Nl+BvmxYjUxBpbAcOc27u+GTL/j5TXC527TTHDlBFRQGXEq2I8tKcwUpQCVtBNdudEJher3o1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5452
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 11, 2022 at 02:00:59PM -0700, Kees Cook wrote:
> On Thu, Aug 11, 2022 at 11:51:34AM -0700, Ira Weiny wrote:
> > On Thu, Aug 11, 2022 at 10:39:29AM -0700, Ira wrote:
> > > On Thu, Aug 11, 2022 at 08:33:16AM -0700, Kees Cook wrote:
> > > > Hi Fabio,
> > > > 
> > > > It seems likely that the kmap change[1] might be causing this crash. Is
> > > > there a boot-time setup race between kmap being available and early umh
> > > > usage?
> > > 
> > > I don't see how this is a setup problem with the config reported here.
> > > 
> > > CONFIG_64BIT=y
> > > 
> > > ...and HIGHMEM is not set.
> > > ...and PREEMPT_RT is not set.
> > > 
> > > So the kmap_local_page() call in that stack should be a page_address() only.
> > > 
> > > I think the issue must be some sort of race which was being prevented because
> > > of the preemption and/or pagefault disable built into kmap_atomic().
> > > 
> > > Is this reproducable?
> > > 
> > > The hunk below will surely fix it but I think the pagefault_disable() is
> > > the only thing that is required.  It would be nice to test it.
> > 
> > Fabio and I discussed this.  And he also mentioned that pagefault_disable() is
> > all that is required.
> 
> Okay, sounds good.
> 
> > Do we have a way to test this?
> 
> It doesn't look like syzbot has a reproducer yet, so its patch testing
> system[1] will not work. But if you can send me a patch, I could land it
> in -next and we could see if the reproduction frequency drops to zero.
> (Looking at the dashboard, it's seen 2 crashes, most recently 8 hours
> ago.)

Patch sent.

https://lore.kernel.org/lkml/20220812000919.408614-1-ira.weiny@intel.com/

But I'm more confused after looking at this again.

Ira

> 
> -Kees
> 
> [1] https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-patches
> 
> > > > > syzbot found the following issue on:
> > > > > 
> > > > > HEAD commit:    bc6c6584ffb2 Add linux-next specific files for 20220810
> > > > > git tree:       linux-next
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=115034c3080000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=5784be4315a4403b
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3250d9c8925ef29e975f
> > > > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > > > 
> > > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > > Reported-by: syzbot+3250d9c8925ef29e975f@syzkaller.appspotmail.com
> > > > > 
> > > > > BUG: unable to handle page fault for address: ffffdc0000000000
> > > > > #PF: supervisor read access in kernel mode
> > > > > #PF: error_code(0x0000) - not-present page
> > > > > PGD 11826067 P4D 11826067 PUD 0 
> > > > > Oops: 0000 [#1] PREEMPT SMP KASAN
> > > > > CPU: 0 PID: 1100 Comm: kworker/u4:5 Not tainted 5.19.0-next-20220810-syzkaller #0
> > > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
> > > > > RIP: 0010:strnlen+0x3b/0x70 lib/string.c:504
> > > > > Code: 74 3c 48 bb 00 00 00 00 00 fc ff df 49 89 fc 48 89 f8 eb 09 48 83 c0 01 48 39 e8 74 1e 48 89 c2 48 89 c1 48 c1 ea 03 83 e1 07 <0f> b6 14 1a 38 ca 7f 04 84 d2 75 11 80 38 00 75 d9 4c 29 e0 48 83
> > > > > RSP: 0000:ffffc90005c5fe10 EFLAGS: 00010246
> > > > > RAX: ffff000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
> > > > > RDX: 1fffe00000000000 RSI: 0000000000020000 RDI: ffff000000000000
> > > > > RBP: ffff000000020000 R08: 0000000000000005 R09: 0000000000000000
> > > > > R10: 0000000000000006 R11: 0000000000000000 R12: ffff000000000000
> > > > > R13: ffff88814764cc00 R14: ffff000000000000 R15: ffff88814764cc00
> > > > > FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > CR2: ffffdc0000000000 CR3: 000000000bc8e000 CR4: 00000000003506f0
> > > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > > Call Trace:
> > > > >  <TASK>
> > > > >  strnlen include/linux/fortify-string.h:119 [inline]
> > > > >  copy_string_kernel+0x26/0x250 fs/exec.c:616
> > > > >  copy_strings_kernel+0xb3/0x190 fs/exec.c:655
> > > > >  kernel_execve+0x377/0x500 fs/exec.c:1998
> > > > >  call_usermodehelper_exec_async+0x2e3/0x580 kernel/umh.c:112
> > > > >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
> > > > >  </TASK>
> > [...]
> > > > > ---
> > > > > This report is generated by a bot. It may contain errors.
> > > > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > > > > 
> > > > > syzbot will keep track of this issue. See:
> > > > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> -- 
> Kees Cook
