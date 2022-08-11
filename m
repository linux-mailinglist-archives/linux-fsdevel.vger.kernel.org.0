Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD57B590600
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Aug 2022 19:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbiHKRkH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Aug 2022 13:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234549AbiHKRj4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:39:56 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB11910A0;
        Thu, 11 Aug 2022 10:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660239595; x=1691775595;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yrvkw+cci9TbJPb+w//clcP/WE/d5azNJ5b08Nr/J4s=;
  b=DRPULetwHFBC+jTLd3/6XV1DmRioVkD+0Qok3hn+ED1/Ms5Ynn14Q66z
   nAQgmLytg7iwTGFGZ6/iV2UcF75Q/Ex5ySp3MJRQ7uvd9xBagQQUF9Pt5
   Fam7QOC8XaxeOzFih1OPqbXT/LUE4pMQnF4B8WkdpFRSss8cBQzebkKp5
   s1x2il6UNcpUyr5+35MZPMcDiSJS/sYbtytY1CpJ9e3poNLYp/U7IpXEd
   j6YzVI2BEUZQU7h9mMN+P1zrBkslw3Y8YoAuGWhYokmdKLsviEAn6lcie
   jEaharXvD31j1Fa5zKkYwPgsHem/7bcps1tXtx/2qPGmWpCnaCGvmOWnZ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="353158137"
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="353158137"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 10:39:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="694978248"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Aug 2022 10:39:38 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 11 Aug 2022 10:39:37 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 11 Aug 2022 10:39:37 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 11 Aug 2022 10:39:37 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 11 Aug 2022 10:39:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXpaq2ZAlB1wX35Rc5Z0h8/UuKzf1xF4IOZmCGuG5EcvPbsTPt96aytLnXqXLNjnlUbHPFRvd6dgiidVTXynAAvP8nv8qxMLdWUfqrLQagNzYR+1jrxz/F7qU+agN2P+pksC6/FQs5jr6FMUIRZ6SSXIq8NqolND3kN/vDPHyt44J7eAtAlrfMh4WrODR4XxQUMl2OZcoawwESnwYo1BZdCuScqWGrOTKabMvWulajWvyQ0VzoxnyEWbYYMWRX74D7FJRcsR9RBrVNiJsxK7qdVTiyrmokfUdXauwliK8hzIVmib5PiyhymcW6AkhiAu+s+ZgGMpJm87agh84ziFrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2+Bjd6sDrchMGDbmaCer/pmOycJMuUuTaaj0MkBKak=;
 b=UQIBkTC11Hq3sVjGgUgpgDhWYPKRumroKQHfDC6/TMW7hGhxwDuzPXR48dDqrw1Lm4LEQ7noKbc8b3JeBBCzIt8a6cRiEu37OYRBsKHOQ92n9pWaH6FL4dthzKTY3E0ODJ7lU0lTHK1VIQjd0Ct+O5OYNOcoj2GK/85JViJE8TJuDgTdXqMMziWPgnOOenDi+2Ed11rEro5IX1RKaSynrC3Gnehi+VNr9KDHJr5dPQfd6wa2+v6BVl9yXD4waSNy/f3B068/zQ8ZZ56iaOYH/NwAem26DOUDVkyLOoCi0wwCigtSPwSZjpM2CKCBIh8BNCfxwC1hCvGbns2y2i19WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 SN6PR11MB2621.namprd11.prod.outlook.com (2603:10b6:805:59::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.17; Thu, 11 Aug 2022 17:39:34 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::a85f:4978:86e2:8b44]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::a85f:4978:86e2:8b44%7]) with mapi id 15.20.5525.011; Thu, 11 Aug 2022
 17:39:33 +0000
Date:   Thu, 11 Aug 2022 10:39:29 -0700
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
Message-ID: <YvU+0UHrn9Ab4rR8@iweiny-desk3>
References: <0000000000008c0ba505e5f22066@google.com>
 <202208110830.8F528D6737@keescook>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202208110830.8F528D6737@keescook>
X-ClientProxiedBy: SJ0PR13CA0221.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::16) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6d37411-9e8d-49cc-ddff-08da7bc073ed
X-MS-TrafficTypeDiagnostic: SN6PR11MB2621:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rf/yo0BwCq2sC1jpIC0xOaed8DArN1EZDjRqEoXrV2w698gvHSfF45Fgaa+FfAuDEpiH7nG16zRDffblfL4CZrWpUFhi/jUd3I071p/0O+/BlKZsLuV8X2Hy9GRR1bQktL/alqPLy3AYGM/Qal4hwC3m0L7cpDA+A+nANab4IQi15l+akaUuTBLjLWq8UyKA71JJvqXfr+k+THV1bU8QyknIAgpojZpcPLem/NgoiC0SfwsecxSd6S9rJWdqimvsa4BWOep7FTWXPamdMRDN+2BrYonU2K/JHF17b8VJrmsY12CdTu/eWNNnQkZzn4qUXRstTEs5R15cZlonPp/7SXUHlm5u3TTmI2C38aKyzqKP/dQbWj08cefQY6R2U5puGdUtj88Kx70lmBk8Lw9Ij59YCuJwpcmrpB7PqPM8HLqTeof4lmhnERyPuK3A5lci4Ajj9BWcUOAw1Q6INfDtHs7JGnWtB+WS9EscJaQjhKz0t9p6UvgnZ70NonXFO4mMursIjOgE/kDbCkbLBcTpRTxO59+R/bJ1bfW9Vcjpmi9Mflvgw9G58A5WCBGOAlJErswOIJ1YTImSZ5TdSkuw6s0GIOV6EjCbzf/YjSng2A9Oc5LiYoLl4Za+66IrCXVGJZLaGtrb572R+OeYE3rls1JmKI3ZnDWrYzXBq/Jd4HFEQ+6NswCOh6Ze8x9akRwZ1zsMgyl7pBn7AOWGQ4sgn1iSvMCkvNKOcxWopofyybJOS97cIOdxOWbR/nUndo3EHHOC5JlEw5D4u/7RsvMS3GRmAS0TUF/cD9phc/lf4fffi1Nz0nGgRI6O4y/ZomEzGKAYWKJUZWCn0uWJu1NsB+ehH4fOxZAhHjYPuCrpMdOxtpxh3By0QNzUyV1uo6qn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(366004)(136003)(346002)(376002)(39860400002)(316002)(66556008)(6916009)(5660300002)(4326008)(8676002)(66476007)(54906003)(478600001)(186003)(33716001)(86362001)(8936002)(44832011)(2906002)(7416002)(66946007)(83380400001)(82960400001)(26005)(6512007)(41300700001)(6666004)(45080400002)(9686003)(6486002)(966005)(6506007)(38100700002)(99710200001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3Cd1s0hJUsBisD1neM3fQKmelNBaqFgFbYHhrqJ4Kc/Zl7+t0mGk5EYnie7e?=
 =?us-ascii?Q?qjrgVYmmLDNB0Gn3nA2Qs5CJrlrrTRfCGvGbmPyNJ8xzG8mYrb7Z/cOZNKpZ?=
 =?us-ascii?Q?kEJS7vKoYQjZyXgiD/DmHvA/hVw6b1Na/57luWgoUIwJG22UN2TEWqFf3Dky?=
 =?us-ascii?Q?1lqLcthTWu9kAyatV9XarhwZNiGnSsheHMPcJtaeLgmHroquluhQqD6hTdDE?=
 =?us-ascii?Q?SZ5w9+/PagFkEVy9zYusYrxuuReSCpYwcaxYW3x1OG+mi9sNk9hj8Qpk1a6U?=
 =?us-ascii?Q?GGSSb6hkysV9cNVBwu/3QTXmFUi/D/K0XHnPASvMC4oVH5BfmfG1+p9XFpD2?=
 =?us-ascii?Q?1Qj9SezJczfObQM401hYwYX5HQePIdoABC8OmlsOm2Pn+zGU4XX9XUs2TcHB?=
 =?us-ascii?Q?9Vgyi8l1IZpISxdhox/McOfvJzQ0KRDR3IJdqBCh0nshsX64p5t+QjFfhLbu?=
 =?us-ascii?Q?uWkTsGLtGjWDsNwvwLIfOHD70hdetj1ezrQ7uIzpmK30li5D8PSFUJZPt6OI?=
 =?us-ascii?Q?r3l2m+FMcsM8P8nc03Z2XZudEQszQHrGZPm8bhBqc4z2ADME8TY487gdigzJ?=
 =?us-ascii?Q?cXv7TWQBH7BBlJ0HWwaxQYGW7QAfk5y/PYTJuh7fd/1YbaHNB1SWZQRnDc8h?=
 =?us-ascii?Q?UkqVzVmG9IgxflF6QA0sR2FZn93/wYRXM+swdiVeYSjWxcYs/Iw4P2mbwE7/?=
 =?us-ascii?Q?Fxx3exDQJYUPcMuh2LLSQNVDA6guipUn/dw1Sa0MQEg7hDcbynCOv/K4nhb3?=
 =?us-ascii?Q?XtbMXn96wn6jvUnTGHcsk8X7epRoP+bTSQQcRKlaD4JBaM/idOq1fmk2ulR7?=
 =?us-ascii?Q?D5bd828lKqbnmMSzCpvasWOyhw/l47F6903uYd7V5cdJxSfaxkbLY+IZBzsg?=
 =?us-ascii?Q?tj3uko3qTuZ/p/tCZ9yt4Suj65n0c0T/J4gRG7/Ojao/ZxfD0XMiUDFMzWBx?=
 =?us-ascii?Q?G46VtAVvfBVGyh/MSPHDGkMyeartp1aSNwNBZN5aZ8dNlnDzkcdV/GNMzyjP?=
 =?us-ascii?Q?CoOtKFzs9+u6gXvKaheCvJ1MXRp6RBF3DknqknjQRG9LBImyvg7fUNCahXnC?=
 =?us-ascii?Q?QIutRFAIZrL08Ykibj73iMdnynrFXoV5ZxCJFnJpT6EViExipNurB3TJCo7J?=
 =?us-ascii?Q?/5BP7UW8uzboyyCgAks8qi4qkNNoe7HVEQDlnch/nWQlXTzrzZ6Jfo0CCJ22?=
 =?us-ascii?Q?uhbsMnwSMSjtugPogXNzK1jDy+Trutg2ftz4H6LVvnAzvFhL10R0x0xgIEdt?=
 =?us-ascii?Q?IiqHkGOt3HCqAVKCn5t31tndY7X1h/d5GQJ70i1Wle7hy5bIx+BRqt12Waqy?=
 =?us-ascii?Q?Yc943SptTjidrd74AoEEsi0pxY9I+ng4lMzcA6XXfPM9Jf2y5DM4NiBzzAcJ?=
 =?us-ascii?Q?7MwF+/6g4CWdvwB0bEDYfoO7hNxrMIBeuM5AXm5kcEneQ2JyTbRN4Tm3XuUB?=
 =?us-ascii?Q?SiWlntp0v65zW6iLcA/njgF9RplEERDjcF3FpOl5L5brS5uDQLXSdFHFE5tz?=
 =?us-ascii?Q?h5sOf/jahERVnBmz2jt7DfT9RHtSx1owiH2ywQDB9yc/4vcjLmsC0Av+MHM/?=
 =?us-ascii?Q?RiT1+2a4LpV29Mys9ED5ER26FgGUlZOtvddFs0Hm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d37411-9e8d-49cc-ddff-08da7bc073ed
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 17:39:33.6502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cVa/nQJt/XQ9qqx/G7eAi5rSyWMXBHyXXoBzd0EERM7CxtxeAvrSgD70NN0WLlcADTw4hd0h+TX2vO+tERHPIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2621
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

On Thu, Aug 11, 2022 at 08:33:16AM -0700, Kees Cook wrote:
> Hi Fabio,
> 
> It seems likely that the kmap change[1] might be causing this crash. Is
> there a boot-time setup race between kmap being available and early umh
> usage?

I don't see how this is a setup problem with the config reported here.

CONFIG_64BIT=y

...and HIGHMEM is not set.
...and PREEMPT_RT is not set.

So the kmap_local_page() call in that stack should be a page_address() only.

I think the issue must be some sort of race which was being prevented because
of the preemption and/or pagefault disable built into kmap_atomic().

Is this reproducable?

The hunk below will surely fix it but I think the pagefault_disable() is
the only thing that is required.  It would be nice to test it.

Ira


diff --git a/fs/exec.c b/fs/exec.c
index b51dd14e7388..3da588c858ca 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -640,7 +640,11 @@ int copy_string_kernel(const char *arg, struct linux_binprm *bprm)
                if (!page)
                        return -E2BIG;
                flush_arg_page(bprm, pos & PAGE_MASK, page);
+               preempt_disable();
+               pagefault_disable();
                memcpy_to_page(page, offset_in_page(pos), arg, bytes_to_copy);
+               pagefault_enable();
+               preempt_enable();
                put_arg_page(page);
        }
 

> 
> -Kees
> 
> [1] https://git.kernel.org/linus/c6e8e36c6ae4b11bed5643317afb66b6c3cadba8
> 
> On Thu, Aug 11, 2022 at 12:29:34AM -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    bc6c6584ffb2 Add linux-next specific files for 20220810
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=115034c3080000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=5784be4315a4403b
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3250d9c8925ef29e975f
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+3250d9c8925ef29e975f@syzkaller.appspotmail.com
> > 
> > BUG: unable to handle page fault for address: ffffdc0000000000
> > #PF: supervisor read access in kernel mode
> > #PF: error_code(0x0000) - not-present page
> > PGD 11826067 P4D 11826067 PUD 0 
> > Oops: 0000 [#1] PREEMPT SMP KASAN
> > CPU: 0 PID: 1100 Comm: kworker/u4:5 Not tainted 5.19.0-next-20220810-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
> > RIP: 0010:strnlen+0x3b/0x70 lib/string.c:504
> > Code: 74 3c 48 bb 00 00 00 00 00 fc ff df 49 89 fc 48 89 f8 eb 09 48 83 c0 01 48 39 e8 74 1e 48 89 c2 48 89 c1 48 c1 ea 03 83 e1 07 <0f> b6 14 1a 38 ca 7f 04 84 d2 75 11 80 38 00 75 d9 4c 29 e0 48 83
> > RSP: 0000:ffffc90005c5fe10 EFLAGS: 00010246
> > RAX: ffff000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
> > RDX: 1fffe00000000000 RSI: 0000000000020000 RDI: ffff000000000000
> > RBP: ffff000000020000 R08: 0000000000000005 R09: 0000000000000000
> > R10: 0000000000000006 R11: 0000000000000000 R12: ffff000000000000
> > R13: ffff88814764cc00 R14: ffff000000000000 R15: ffff88814764cc00
> > FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: ffffdc0000000000 CR3: 000000000bc8e000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  strnlen include/linux/fortify-string.h:119 [inline]
> >  copy_string_kernel+0x26/0x250 fs/exec.c:616
> >  copy_strings_kernel+0xb3/0x190 fs/exec.c:655
> >  kernel_execve+0x377/0x500 fs/exec.c:1998
> >  call_usermodehelper_exec_async+0x2e3/0x580 kernel/umh.c:112
> >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
> >  </TASK>
> > Modules linked in:
> > CR2: ffffdc0000000000
> > ---[ end trace 0000000000000000 ]---
> > RIP: 0010:strnlen+0x3b/0x70 lib/string.c:504
> > Code: 74 3c 48 bb 00 00 00 00 00 fc ff df 49 89 fc 48 89 f8 eb 09 48 83 c0 01 48 39 e8 74 1e 48 89 c2 48 89 c1 48 c1 ea 03 83 e1 07 <0f> b6 14 1a 38 ca 7f 04 84 d2 75 11 80 38 00 75 d9 4c 29 e0 48 83
> > RSP: 0000:ffffc90005c5fe10 EFLAGS: 00010246
> > RAX: ffff000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
> > RDX: 1fffe00000000000 RSI: 0000000000020000 RDI: ffff000000000000
> > RBP: ffff000000020000 R08: 0000000000000005 R09: 0000000000000000
> > R10: 0000000000000006 R11: 0000000000000000 R12: ffff000000000000
> > R13: ffff88814764cc00 R14: ffff000000000000 R15: ffff88814764cc00
> > FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: ffffdc0000000000 CR3: 000000000bc8e000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > ----------------
> > Code disassembly (best guess):
> >    0:	74 3c                	je     0x3e
> >    2:	48 bb 00 00 00 00 00 	movabs $0xdffffc0000000000,%rbx
> >    9:	fc ff df
> >    c:	49 89 fc             	mov    %rdi,%r12
> >    f:	48 89 f8             	mov    %rdi,%rax
> >   12:	eb 09                	jmp    0x1d
> >   14:	48 83 c0 01          	add    $0x1,%rax
> >   18:	48 39 e8             	cmp    %rbp,%rax
> >   1b:	74 1e                	je     0x3b
> >   1d:	48 89 c2             	mov    %rax,%rdx
> >   20:	48 89 c1             	mov    %rax,%rcx
> >   23:	48 c1 ea 03          	shr    $0x3,%rdx
> >   27:	83 e1 07             	and    $0x7,%ecx
> > * 2a:	0f b6 14 1a          	movzbl (%rdx,%rbx,1),%edx <-- trapping instruction
> >   2e:	38 ca                	cmp    %cl,%dl
> >   30:	7f 04                	jg     0x36
> >   32:	84 d2                	test   %dl,%dl
> >   34:	75 11                	jne    0x47
> >   36:	80 38 00             	cmpb   $0x0,(%rax)
> >   39:	75 d9                	jne    0x14
> >   3b:	4c 29 e0             	sub    %r12,%rax
> >   3e:	48                   	rex.W
> >   3f:	83                   	.byte 0x83
> > 
> > 
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > 
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> -- 
> Kees Cook
