Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CB663E5E9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Dec 2022 00:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiK3X6q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Nov 2022 18:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiK3X6o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Nov 2022 18:58:44 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D847655A9F;
        Wed, 30 Nov 2022 15:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669852723; x=1701388723;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VsUJ3EzwHCFyp+FRnNMB45IfG/dc6jDepLYiRGfqs6o=;
  b=KLHKeOpGSARqk/7+nKoAEhkn57Umuza3PR2uaK6liGN5xCuk6VRIfbFd
   hidT/0cIJkZq8sHfw1/yNGPbi7nnCaaouLnilVPLM0LryzSQXsJ8cjhsI
   RJK1a3DU2exDFT8Gar+Qz4FQYsHhMqUgDe1T0Nqc/9mzNr9202poMkmip
   w+lF4xxnSwqjuN+OkCC69AQUjJpNbGt3e80lTe+vyZr8RaCXauEjzV93h
   dAv0IQbg16auATytUVvXkJHebEJ5+kkZSwJPa+wpTp+S+WrUeaeYZ3Gjs
   UgpnVKE6e1l97m8yK7QRaTbssCtk8x5ajaetHI/1vR8tLqZvpqbSyPNNu
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="315563157"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="315563157"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 15:58:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="622077786"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="622077786"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 30 Nov 2022 15:58:43 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 30 Nov 2022 15:58:42 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 30 Nov 2022 15:58:42 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 30 Nov 2022 15:58:42 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 30 Nov 2022 15:58:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xzfu2RENVeSJNrJIYA3nEYSj78Ikem7FJi4/X8/EIKWLDj05QMdMfFsCh3ewDa+FUX9xSFqMknCdHvB2QDIyF1mstgliyYyJSg7LjFfv27HtJPCpOfcnQxS9eeE/vKpg6ogGM34cmNffkbc0iB8/4LkTF+oVlZJsC+dONqyNluCdYampAxEq0g9ZKXyL/jmcGzMBraIsap4DTYx5UgTIWKwgiypcJd5RngvB17LWOvsIvRMyorrFXR/6QbpGE4xdPixujwH+iyfYeJ2C4OVobYq5/ZzmFllZK6lKBvWETMyebMGsH07O9QurhgnGZnqpIrA43fxA4WA5woLF81w+Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12xDd/zgycmw+G1Rz63tq3xFS5db/T6ftStwJ252/jw=;
 b=WGadCJkuIa497DpTCBDE3IyfNzqyVFKeLZalMP6TkzNqpv5hLVUq6EC91wGWHAlWV8Nuq2zuDdVpoqwHgKxL+ii+VcvlkiziGZVg5vlVk5lqgWvfUT0FEpaBMEG6qJ0UpvhVeyAzGoWVuXj/ijASPZK7OeTURLu8PNmJB2zirIjeCpSznUC1sP8hhAz/eRpvPUem9tLRud7ubndLnKHa/W2nkAuhcpAaXIGMKrHiBNRzS6/23O6paQDrywrrUm7NCGNJepOZXEOnSAxzM0UN4EwvXFM+Pud/E5zkoW+yFMJMvLhiMgcrETYcvAQ4kiak0VbMrbgLV0xcVutPXJaKoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by PH8PR11MB6755.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 23:58:40 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 23:58:40 +0000
Date:   Wed, 30 Nov 2022 15:58:31 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
        <david@fromorbit.com>
Subject: Re: [PATCH 0/2] fsdax,xfs: fix warning messages
Message-ID: <6387ee2769155_c957294c8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <1669301694-16-1-git-send-email-ruansy.fnst@fujitsu.com>
 <6386d512ce3fc_c9572944e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20221130132725.cd332f03ad3fb5902a54c919@linux-foundation.org>
 <6387cfcbea21f_3cbe0294b9@dwillia2-xfh.jf.intel.com.notmuch>
 <Y4fid4ZFSUWvWzNH@magnolia>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y4fid4ZFSUWvWzNH@magnolia>
X-ClientProxiedBy: BYAPR05CA0090.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::31) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|PH8PR11MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: 38c568b8-47cf-47cd-4964-08dad32ecdbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /4DzgwG5LPslZQuCUhR8m2x978dp0BJ1PHwA9lTjD9WYrXMDS+OaipcFeSGegk0kBaUXCjYSxCOEEtcWI899EWrkVxNIwu8vosEMXdQXnySGJ1RnFdlhe+bYnCCt9xX43YpJEI5tIZ+FI4QbFOsO991fR0scX3y3HMabLKqgVu/kn7R0TV6llVf6bITuQr6rojf30mM9k9HeQ6Ib4UDDlYLQUcCQxJtZSU53ux0+3uznsufxjJwIHO2mikREBda73oVbFSL/SRRaIGNdO2BXvzt/jTZJI/Tiudd6LmJRM1RoDjIznv5jsyC0oGDP7b3pJmbC8fCNp2Nu97NIQWPtHPWlqyQOyaDdwrjVGHTzlqttBt581Fz1Yljss1ikAXIjBkXu/wezZlWVg1JAAtsbpgg8W2RxFjt2Gb0wAgNdMSVEIceRlwH2r7gKDrIl8W3IhF35ZIKTxW3W88ACbD0t93dqC6axHirk9jPnWKl+/HD4b8lrhxGWLaBg7lf958w+HI/YgJwglxKvkI2vA7nzo410SfMDvWEKtOoOlhO7O3zUfEglrcEqQVmX0IWZRaKDTtZB6x6CvYYG+rRveJBNiZFpRZ2aix08R9PhgBNDhwMxd0nWkreJJQqUJpNv3ZUypZXzocBD2uQYRb4fE+8vJyGN+tYnst4FlcqW6JuNC7aRpvfmUMBr00XT0H2V4f+Bl+LEQ5gIXptw5UVVGR0IKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199015)(41300700001)(6486002)(86362001)(5660300002)(66476007)(83380400001)(8676002)(316002)(66946007)(26005)(4326008)(110136005)(9686003)(6512007)(6506007)(66556008)(6666004)(966005)(186003)(478600001)(82960400001)(54906003)(8936002)(2906002)(15650500001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PhiBfkH3z5aZvnwsialWA9lIrJn6c/pWcPZwJdirsCN+0/McPPt5YyqMLAGT?=
 =?us-ascii?Q?oa74AI63Ubl0A98dUHS0wlUtqD9G5tqcdvN5Ql7XCjukwiTCTfkNF+0aVOY5?=
 =?us-ascii?Q?bTRhD4KTknQOX/cyPqTyp5O2vNGtXVWBNtEhkryEwjC1pA/3pofH89h7rqj+?=
 =?us-ascii?Q?s1WSA+HA1W36rGkj5asdx+Eb3FZwA/qVQhUgcrdMLTar9dECB8PL73oZNcTA?=
 =?us-ascii?Q?IqNYki8fJUN4psOUwWDOYKImQYFNa76CnmRCepL+rsapB577NVogWN0bQk+o?=
 =?us-ascii?Q?tcG9IBVT1awmSURFAhaGcwttbmgyPmhqrYUMtSPgZrOTEzwT7mwTTXOca0Kd?=
 =?us-ascii?Q?GBtZaNjLE6pZpc6OgOJYzCJfGvKpvAdrY+KhbBUYGvRcW05j+k5f5ZEcoGef?=
 =?us-ascii?Q?6TqbWXUA075LV3CusxmL14FUOdyeW6yOkgsnRsWbHaYPqD9uhk+lkYL4vQA2?=
 =?us-ascii?Q?VN5UQ9LdEr7iasbq/FEa9OPSFNKRHSWAR5z3dtBM29dmRZ9BiltutObFixZ7?=
 =?us-ascii?Q?RqXFIbaVCfK21W+CLbSxlNs3l+u3vFfQcN53ATCiQDqxFvkGAecQfdoX/3VS?=
 =?us-ascii?Q?1LfrZUk3J8QaJ+Bd5uYYwa7NOxCaNu1vZ/OJ6YjDZ/njj1e7kC9hNnaa/NiM?=
 =?us-ascii?Q?HATnIo/Mp3caJo03BMl03g0JCvZ0+EMldz88iOI8BjKfjfeFkMXHiWzhm1i6?=
 =?us-ascii?Q?c5eOBPZpFE/PTyu1KG4X8yceXie/WLuqBUTBYPgFGU4dNsOjuZEiorCzRiKF?=
 =?us-ascii?Q?nGALz6YyVfQwWLeH4SOm6gmng8Hax2yVuGuGJ6bsgIQjv6zJeSjP668UqHSr?=
 =?us-ascii?Q?kOyP1U7e0J9JLl3fXiB9lcJbyYTZ66CmxTh7WyXUDtCyCRObQMnIySgcHz23?=
 =?us-ascii?Q?0MaMmrPe0k9d9t6mhJ9J5lE57aARf9nR+ApiMG64E14KQB56em/KZOh0vSU5?=
 =?us-ascii?Q?eJapYne5aznNJFRRxy2pbZpEv0Ou7tez0l5hG/DhYe8HgMNkhNBaK7lElwE9?=
 =?us-ascii?Q?uaTVhmEyRFM+AdrHwDMkr9VXexGc4CuEIRweBVSuh3pNpq8Ofuzx7rIMlFBW?=
 =?us-ascii?Q?W66Jinx4tEOnktcwuG8NY/P9+zkVNQHZfD5/HHovko6iNv47A1BFC1naRFBc?=
 =?us-ascii?Q?e1IRGnXG9u7inUOXovtCjS3pbg9VM50P7HvJ0wZA/h0+piL0IxX028+bOCSK?=
 =?us-ascii?Q?yn+3cpVz5RDWgxhVwKPXL2yBoUUHqRkugHPJ0d+xMlniZlPIb0Bry69Wd5FZ?=
 =?us-ascii?Q?aqSy3ui0qjPXTB8XYc3I2wtrvlaVpx4NU0UZKlwqX8U2fRW287Y1lVxjZXNf?=
 =?us-ascii?Q?dKG//QNoYInnq4apzoK2m/T8F46m5zwauPEWMfNViNZxuAij4CSZ7BKfKee+?=
 =?us-ascii?Q?eauaXkAf8ODzcveJy3JtN23DJXY+6ZUBADKwUC3ICiOmFNfXIuhCXM4Odw6u?=
 =?us-ascii?Q?tEcGeGdngDuwtJNrhgQylA+tQfKEOnfby9gLzUBN2CsxH0fEHeNgFku/B9Ot?=
 =?us-ascii?Q?wlukbH8O/HSo0ElofdYNIKlezn36TD0Jw9Ic5T250Tjw7UCI69IhA87fsnrr?=
 =?us-ascii?Q?07oCN+T/VwE7U8rKGqiiHCTN4O4YSZlDhn4gxn2dhDeofAHJeXpbQpsQ60NW?=
 =?us-ascii?Q?1w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c568b8-47cf-47cd-4964-08dad32ecdbc
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 23:58:40.2002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rukAqVaH3CIMDzJDVlfNKqfFWgxAc2VlszriU4aofRWcODg8aWPj48/j2Ek4EygxtOJOsx404QQ+yRwCZF/kdkulY3laOOV4RSL/xVCSAhs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6755
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Darrick J. Wong wrote:
> On Wed, Nov 30, 2022 at 01:48:59PM -0800, Dan Williams wrote:
> > Andrew Morton wrote:
> > > On Tue, 29 Nov 2022 19:59:14 -0800 Dan Williams <dan.j.williams@intel.com> wrote:
> > > 
> > > > [ add Andrew ]
> > > > 
> > > > Shiyang Ruan wrote:
> > > > > Many testcases failed in dax+reflink mode with warning message in dmesg.
> > > > > This also effects dax+noreflink mode if we run the test after a
> > > > > dax+reflink test.  So, the most urgent thing is solving the warning
> > > > > messages.
> > > > > 
> > > > > Patch 1 fixes some mistakes and adds handling of CoW cases not
> > > > > previously considered (srcmap is HOLE or UNWRITTEN).
> > > > > Patch 2 adds the implementation of unshare for fsdax.
> > > > > 
> > > > > With these fixes, most warning messages in dax_associate_entry() are
> > > > > gone.  But honestly, generic/388 will randomly failed with the warning.
> > > > > The case shutdown the xfs when fsstress is running, and do it for many
> > > > > times.  I think the reason is that dax pages in use are not able to be
> > > > > invalidated in time when fs is shutdown.  The next time dax page to be
> > > > > associated, it still remains the mapping value set last time.  I'll keep
> > > > > on solving it.
> > > > > 
> > > > > The warning message in dax_writeback_one() can also be fixed because of
> > > > > the dax unshare.
> > > > 
> > > > Thank you for digging in on this, I had been pinned down on CXL tasks
> > > > and worried that we would need to mark FS_DAX broken for a cycle, so
> > > > this is timely.
> > > > 
> > > > My only concern is that these patches look to have significant collisions with
> > > > the fsdax page reference counting reworks pending in linux-next. Although,
> > > > those are still sitting in mm-unstable:
> > > > 
> > > > http://lore.kernel.org/r/20221108162059.2ee440d5244657c4f16bdca0@linux-foundation.org
> > > 
> > > As far as I know, Dan's "Fix the DAX-gup mistake" series is somewhat
> > > stuck.  Jan pointed out:
> > > 
> > > https://lore.kernel.org/all/20221109113849.p7pwob533ijgrytu@quack3/T/#u
> > > 
> > > or have Jason's issues since been addressed?
> > 
> > No, they have not. I do think the current series is a step forward, but
> > given the urgency remains low for the time being (CXL hotplug use case
> > further out, no known collisions with ongoing folio work, and no
> > MEMORY_DEVICE_PRIVATE users looking to build any conversions on top for
> > 6.2) I am ok to circle back for 6.3 for that follow on work to be
> > integrated.
> > 
> > > > My preference would be to move ahead with both in which case I can help
> > > > rebase these fixes on top. In that scenario everything would go through
> > > > Andrew.
> > > > 
> > > > However, if we are getting too late in the cycle for that path I think
> > > > these dax-fixes take precedence, and one more cycle to let the page
> > > > reference count reworks sit is ok.
> > > 
> > > That sounds a decent approach.  So we go with this series ("fsdax,xfs:
> > > fix warning messages") and aim at 6.3-rc1 with "Fix the DAX-gup
> > > mistake"?
> > > 
> > 
> > Yeah, that's the path of least hassle.
> 
> Sounds good.  I still want to see patch 1 of this series broken up into
> smaller pieces though.  Once the series goes through review, do you want
> me to push the fixes to Linus, seeing as xfs is the only user of this
> functionality?

Yes, that was my primary feedback as well, and merging through xfs makes
sense to me.
