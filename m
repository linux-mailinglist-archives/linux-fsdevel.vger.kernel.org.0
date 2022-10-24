Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097DB60BCF3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Oct 2022 00:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbiJXWB6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 18:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbiJXWBm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:01:42 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3618168D;
        Mon, 24 Oct 2022 13:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666642529; x=1698178529;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+wNQItI3R2UyMsrI/ksq4sPNTF173f/r+kMvgPbyG88=;
  b=R9kmmnjAZ6CAHprZNeEHDcix4KQbyklpKTLGdS7LnA1ge3IV+59x2ECm
   krF/IaohdFeOwNfveJVZ0t/RCepnfNlf8bwyo/HXuLFtGSjhNI/OLtcpn
   DqC2JM9+5RLiBywtZLKd5RzXzks3gCXcqu423SWq3xvsL78MiNUBPuas0
   kiuWbA5wS8v0Ks4pMnbDubhjLFsb653CKGaK/2lG8JOVGdLgOnERNSSap
   0A5dsig+5pvmDGfk6ScU4DmJbbf9Nq4asOy3sEPV5TJFDM+kMqjf6xkdA
   ACB3BaODySg+Ika0xrpA9T+ZIPNo7MaIVcRjJO12JDIkqh9toV5OQP360
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="308603731"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="308603731"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 13:13:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="631383493"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="631383493"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 24 Oct 2022 13:13:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 13:13:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 13:13:49 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 24 Oct 2022 13:13:49 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 24 Oct 2022 13:13:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PD6FRCoftMNiHVWpBBgYAu/t59Ke1yxlfFPlprQDsvoecgpijvjUcUFzriu6tndpgtIZE+elwX66rbwChrhsr2DIkr58V1RfOb2cs9kJbmSgwT4/MTm8wt/cm0VWRMNr4+RbsmqbBDwmCw6YLh5YDSxHxvTxnb4zids2es/iDXiCuJEMV0nG0GAipauR6M3dbbGpcKRBIcnBzToq9ATjRYJdgvOfAHCkypJIhURnSmMMfKc5yNw+3Ot/5S70IBTbCWz1K/VNnIqAh/4r9XYi4LMSO9HIl+rpcTd5b/CuiMbuBq7Pt8mHvlRI3YNWAuXICJco+yT3wNuUAPevfb0Oxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DieKnPjjQmE2SUNcDYY5Md7Pw8cNBMNz6d8G8JoiP4=;
 b=f9IPCbDkAT4ykdUMGap8JDxda54HxkC4L67ZLXLT80a8WvvZLxAI4L1IMpNY/mH0XFDVd1/vE3xNrWvJ/juFjLSEoe1H6r6oVCLGWXkgLEGmZ9V3X7vwTvnjYHapERo9As3tP4LJ+Jg30TFpnNm0Dji/uEfWWwu6gqnsHlDmdCWLUVks1G4V4Ob8kgMjv3WQ7F+1f5nXvqhmT9Bg+O9QwPwZppXug5eh9J97WLIMZfMl1VQ4WIhuQ4BW3RMP9RlSVPzkWjqkU3vhPWmd05wlOggFJ4Erld9A1zDWFcq+GI14iNYjPKfDJajciR7t1jUfAOHirp/U8s/uSIx/NEYVWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SA2PR11MB4889.namprd11.prod.outlook.com
 (2603:10b6:806:110::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Mon, 24 Oct
 2022 20:13:47 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5746.023; Mon, 24 Oct
 2022 20:13:46 +0000
Date:   Mon, 24 Oct 2022 13:13:43 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        <jesus.a.arechiga.lopez@intel.com>, <tim.c.chen@linux.intel.com>
Subject: Re: writeback completion soft lockup BUG in folio_wake_bit()
Message-ID: <6356f1f74678c_141929415@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <YjDj3lvlNJK/IPiU@bfoster>
 <YjJPu/3tYnuKK888@casper.infradead.org>
 <YjM88OwoccZOKp86@bfoster>
 <YjSTq4roN/LJ7Xsy@bfoster>
 <YjSbHp6B9a1G3tuQ@casper.infradead.org>
 <CAHk-=wh6V6TZjjnqBvktbaho_wqfjZYQ9zcKJTV8EP2Kygn0uQ@mail.gmail.com>
 <6350a5f07bae2_6be12944c@dwillia2-xfh.jf.intel.com.notmuch>
 <CAHk-=wizsHtGa=7dESxXd6VNU2mdHqhvCv88FB3xcWb3o3iJMw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHk-=wizsHtGa=7dESxXd6VNU2mdHqhvCv88FB3xcWb3o3iJMw@mail.gmail.com>
X-ClientProxiedBy: MW4PR04CA0289.namprd04.prod.outlook.com
 (2603:10b6:303:89::24) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SA2PR11MB4889:EE_
X-MS-Office365-Filtering-Correlation-Id: c367b995-a440-462a-4b54-08dab5fc41bc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ijhP9moEfGbw5jMBu/4rxc9wP0i+Rz4+aFG6gRIc4batFaUVTzj5EwiF0a/tGOaNH28ZYNaMlq0WajEUK9umWKs9S45hV2kWNfjfR+jUad/jda8rgpb4Jw4hs5xkCakeZzSVrLPjmPZfYxUPoRf8Mae41dbTmpjzqAxPnt1Cuk4Cx6EP9NKIN9iH+I49U3qy9QfBR9KXD27JrGfw7w7mi1370RsYreQ6m0B5qQbdIHA7a0eZPMEdxSbC71NjE33szBon4vow/vQbEOiuw0TZy34q9ecR2lesLBf2PmW00PCXePYrgZBBWB1f17Nf5TTqGiLyXPh9/tPdcGvduM0h0Fx3vp6vUsTYM7Cusu88q8XIM3HnaEqVXKg2uH1yx5his9gOxR7wU2DjtCMFUnwll7YgtbhkpunBZd9UtAyvaTUO6Y6uoMNpBrfzDGkZmRObYqZwQCtzPE61fL/5lit24K1F2AZjrEJZc//gcBh14QX2S56tJw3ouxsYv5z4+a3gWgXk6oZLe+bghQivxgK+OuKzg6RMuHcIa3A2T241/wIKp63c0IOgNGY18lqXpLWVf6gRRj6gKJVkti/Foj5MPYxvOOWZM7DTscOc2gr6FAX6hXMMDmwUwm+C8xo9GsPNS2a71svcMrdiLLnBEOyzpK0qCGF3fbhDkDG+soykLg6T6rEHMtWn4Y4ujyzgKJd6e21URO2WSZjlea7Zoc8TT+GBZlndDCj4gMM7McV85Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199015)(38100700002)(82960400001)(86362001)(110136005)(316002)(54906003)(966005)(478600001)(6486002)(8676002)(41300700001)(66946007)(8936002)(5660300002)(2906002)(66556008)(66476007)(4326008)(83380400001)(53546011)(9686003)(6512007)(6666004)(6506007)(26005)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iAWcp+gsVck1gZ2t2wEHYShqd+7LBiX6Gitdh98htvXWKf7s45cWVxb4mtdy?=
 =?us-ascii?Q?z4fYB0/DGtiHYCB+jco0JF+0SpBu1+q3Sfq9gNQH/I+xaO6LzMqPGpMgZETT?=
 =?us-ascii?Q?lyqq7KnRnlD9Mzgu0fLcOxbM4WOQaS3CyPZZ+/f76aH0uAX230VYMPpUzik+?=
 =?us-ascii?Q?fQoid7vQdAOSJatqMq0H/FQ3VQv4esMdBW1oUtni0j7Dl+uK/GYnfz9id0Ex?=
 =?us-ascii?Q?EZpJ7ZAcF+068IYwjJymPNBWUkZQcxmt6t2MJNYiTdfzvG+ES26xpRQxPzJS?=
 =?us-ascii?Q?pf7PQqON0U3EmJpqzSeqva05yNTh6OBW2uy9+64/jvGtp9rhe1DM3fpUtD5I?=
 =?us-ascii?Q?PFsUk71A/LVk4zs/hQ+1CKqkx6aIK9QPleCRlGjDfIduod39eBD2p7av8ocQ?=
 =?us-ascii?Q?/U/9N7K2DgcfoJztmprAqFEqGsjbI36+1kCyKA1QFTu3lFNj+ZA8pdcekxH8?=
 =?us-ascii?Q?eb+UIbPObsSjLLItcOi0w3MHM2gv7KNUr25g/cPudBK1ZY7/idf3ceZf8mN7?=
 =?us-ascii?Q?B7IFAn5F3sy4xelqB/OUoXboGbxTkRZ3SPvaKxWAwlV326ES80qKQoNEdjot?=
 =?us-ascii?Q?q9aun/0MdY7IuZU6thhDy2W8vBcTRN2VNnDZBwAfC0edJ2ti7/kptM2cTJ/o?=
 =?us-ascii?Q?tk6IW1bXrWvguCUBVpRywbmiewtrzKpRbbjgQHBPx8AqU/HwLLxkAfzaIl75?=
 =?us-ascii?Q?7pFFXXh+weIjUgC+lXdXyAbQ3zbrNANIIQn6GJQgYFfafAaTuA/+9/L3f774?=
 =?us-ascii?Q?dwqTVGN2pij3/BBF9VYqzTLBCdElJ92QQA12bpQ7gZ1ZTDJTrT+0HH06dJRs?=
 =?us-ascii?Q?ZtDjXzgCsWbNcJGLfkRSkUh8uFfffNIvnfgHjYcD9mTbkI697uum1ViOJd2J?=
 =?us-ascii?Q?wZO91aL1Aa0EMEd9gMmAg3qAP0VH7SWkxfoE3O1u87HVAMbIqZrCQ8bK/x6d?=
 =?us-ascii?Q?FK4v1aQV1SwynkzGyg6JxXudeG/oDBrsILboOuAYxwhyHvzD1g7JGCM/orCv?=
 =?us-ascii?Q?troeNPj2dgDl5wfhpcaPzY8sQPq2f9IecvoArYTE8LfSyBtTPCWfzNqigU5T?=
 =?us-ascii?Q?ebihFLi1R5iFcxUyNzdoG+b4r0B8nqWhqQv38VhfxcuRtSVjJh0w8y/JOoOJ?=
 =?us-ascii?Q?+k46bqXUnqcdjLeQs97t6xbK+TCs9qVmWznJm0q23pbGNpQyzlx8Pb92kWcI?=
 =?us-ascii?Q?tV94ZzlSo+pPlxnGSh1d7pKOs6I1rBQjLT8JfIkcHrg5PIkz9ncsOkXfeyxk?=
 =?us-ascii?Q?UBYtwrQjonXHbonXXk71UlVGDELC7NZaIOjbn4HY227Ft2mtSsOfKqzEYwF4?=
 =?us-ascii?Q?1S7JwxZciEHu/bJZ3D+FDtiv9LJsdUrVL7h5SCm42u27Pw3ncOB1UyoCnO3x?=
 =?us-ascii?Q?u7OMyblmYkiEwrBCq2/mZy8pDc+gwpv3lnfIooqpmiYwz41lTGRDNidyjjZ1?=
 =?us-ascii?Q?euTXqLdYfMAq3Nkufz9dSLcvJwvXPg6IjqkK/9KoACf7gEP7lSCmeFMRHbUM?=
 =?us-ascii?Q?2lYz/t23KcjKl3cLCef6G5hP3uLZZhgYL7OZSE0Zfkj3jmlG4bp6JgGqvRPa?=
 =?us-ascii?Q?85Rc7nWAaXqIizxAVntCuz8sP9VIXSqTdqOEnYeXJTki2Mn2mPWFzrhj4qNg?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c367b995-a440-462a-4b54-08dab5fc41bc
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 20:13:46.8091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0UmntFST/2evA5vt1AklTVnFmFiS6yv4SwEtAezmtPL7sgzG+rUhoI2tuF/dilIcB7pfXOy5Fu09Y7ecU4UgicmBsZqOtSYZGfy22pEM19M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4889
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[ add Tim and Arechiga ]

Linus Torvalds wrote:
> On Wed, Oct 19, 2022 at 6:35 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > A report from a tester with this call trace:
> >
> >  watchdog: BUG: soft lockup - CPU#127 stuck for 134s! [ksoftirqd/127:782]
> >  RIP: 0010:_raw_spin_unlock_irqrestore+0x19/0x40 [..]
> 
> Whee.
> 
> > ...lead me to this thread. This was after I had them force all softirqs
> > to run in ksoftirqd context, and run with rq_affinity == 2 to force
> > I/O completion work to throttle new submissions.
> >
> > Willy, are these headed upstream:
> >
> > https://lore.kernel.org/all/YjSbHp6B9a1G3tuQ@casper.infradead.org
> >
> > ...or I am missing an alternate solution posted elsewhere?
> 
> Can your reporter test that patch? I think it should still apply
> pretty much as-is.. And if we actually had somebody who had a
> test-case that was literally fixed by getting rid of the old bookmark
> code, that would make applying that patch a no-brainer.
> 
> The problem is that the original load that caused us to do that thing
> in the first place isn't repeatable because it was special production
> code - so removing that bookmark code because we _think_ it now hurts
> more than it helps is kind of a big hurdle.
> 
> But if we had some hard confirmation from somebody that "yes, the
> bookmark code is now hurting", that would make it a lot more palatable
> to just remove the code that we just _think_ that probably isn't
> needed any more..

Arechiga reports that his test case that failed "fast" before now ran
for 28 hours without a soft lockup report with the proposed patches
applied. So, I would consider those:

Tested-by: Jesus Arechiga Lopez <jesus.a.arechiga.lopez@intel.com>


I notice that the original commit:

11a19c7b099f sched/wait: Introduce wakeup boomark in wake_up_page_bit

...was trying to fix waitqueue lock contention. The general approach of
setting a bookmark and taking a break "could" work, but it in this case
it would need to do something like return -EWOULDBLOCK and let ksoftirqd
fall into its cond_resched() retry path. However, that would require
plumbing the bookmark up several levels, not to mention the other
folio_wake_bit() callers that do not have a convenient place to do
cond_resched(). So I think has successfully found a way that waitqueue
lock contention can not be improved.
