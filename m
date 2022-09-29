Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9A35F016D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 01:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiI2Xdh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 19:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiI2Xdg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 19:33:36 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEE2148A3B;
        Thu, 29 Sep 2022 16:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664494415; x=1696030415;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YODarNyCUPSF5Edu5GDkNQ/U/BYzubYuSL0cEGsufkw=;
  b=afTKj4GNof1LvRLcyLsoZikTtinT4O3vLLLqn7f88jRO6kDCcIX+XyQU
   i0BVaDxbdw2IqPlEb2y+EWI8o9bTwjCLSfkX26INWHP8DG+ces4Fp/G0n
   1gWOjdvE5bUA/epus/J6cLe0LUMsckNz+S6SDcns4twt1HzxRuMojmy/+
   wV/WvhG/kI2sJSc9DLZxrE/WLPXpvtwyJ072iuNMgu7c+DhbhVec+dNc1
   vfmwlE9I2BgJoGD3iOL4cKXYvYmcUG/mXMfVzfkrU+IN05yFCaizYFvb3
   XJi6Wnwdv1wZ6yxvUGe4cfffxR0/VUhB0PuhicZT5vykLY8SjHY0NGO69
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="285193024"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="285193024"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 16:33:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="711588817"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="711588817"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Sep 2022 16:33:34 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 16:33:33 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 16:33:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 29 Sep 2022 16:33:33 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 29 Sep 2022 16:33:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMJUKcxE5PH290xShl8JaVns9RwS3tzRMoR1PI+ZyQ5tUrWu2/7ztQKRCU3WGaQEm2vQjHJrtkdgPCZU/jeqFCKqzv3UviamLjLDBq+7KtjOKsOhnUVd6eBcF8h4zBOVHBKnvx2jJZmiTNtPLOvSHTQ9ozKCd85B1VTVyBSl5SYbtFKPi5nJr+QlDJTOw89rxxC26kSGtL24PD76e9Pcf1u0hu8QU0jY/YDKU7ORVlnWMIhxOeM9nnzcYEC6WLVaS7Qm7cq8LadmrzcrrpFdpn2U8YaVqccAw2gds6FPgUqqK7j6rRpd8Y+7k+YlpfACjhlVw/Rqck75fWLOBgx2mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYt3TiYg8LBLIfJZIj/MPC3BExVArjXnHuO7Pv9WkDs=;
 b=kBbUaDF8g+BWL324G5qqAJQM6MUIRayI4YKChDPx1AimuLoz4XdrB1bk6vuKS9ZXjrWXZh967QAThF1EdkEvY8xCNan4/lLGOWJjofLtr/ER3hjvHv7r9n55qETAI5xXk5G5VxOial58CUrrwIWxwdKV1qpLC7LW5mq3jfE1xnWcV6FZQj3oE3Z8IDrnZLbUychwAgs6EN92HiC8ytpkl+5GFRrn1A4dOkfDoUy6uhkJPZVVssZ/J6oxTjIJ4mrwpEQGSK3WoVhTHKPWVRiTfcS+4Pr0R2q/xOyAe814JsjGxQRCvGWPtRVPcsgmrn+Avr3ducR3zDedUXVStgTfPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by IA0PR11MB7210.namprd11.prod.outlook.com
 (2603:10b6:208:440::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Thu, 29 Sep
 2022 23:33:30 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5676.017; Thu, 29 Sep
 2022 23:33:30 +0000
Date:   Thu, 29 Sep 2022 16:33:27 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>
CC:     Jan Kara <jack@suse.cz>, Dan Williams <dan.j.williams@intel.com>,
        "Jason Gunthorpe" <jgg@nvidia.com>, <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "Christoph Hellwig" <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-xfs@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v2 05/18] xfs: Add xfs_break_layouts() to the inode
 eviction path
Message-ID: <63362b4781294_795a6294f0@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220919212959.GL3600936@dread.disaster.area>
 <6329ee04c9272_2a6ded294bf@dwillia2-xfh.jf.intel.com.notmuch>
 <20220921221416.GT3600936@dread.disaster.area>
 <YyuQI08LManypG6u@nvidia.com>
 <20220923001846.GX3600936@dread.disaster.area>
 <632d00a491d0d_4a67429488@dwillia2-xfh.jf.intel.com.notmuch>
 <20220923021012.GZ3600936@dread.disaster.area>
 <20220923093803.nroajmvn7twuptez@quack3>
 <20220925235407.GA3600936@dread.disaster.area>
 <20220926141055.sdlm3hkfepa7azf2@quack3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220926141055.sdlm3hkfepa7azf2@quack3>
X-ClientProxiedBy: SJ0PR03CA0039.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::14) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|IA0PR11MB7210:EE_
X-MS-Office365-Filtering-Correlation-Id: f1bee1f8-54bd-4d03-1ac4-08daa2730435
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V5/lihoI/MKJXlEBMEUM4NUPMUUkSzujDK+x8ynssmmJWCrI3OU8lLNo0x/EJL3QS3zx0R3jiuCnvu+CwVWi88wXxOrHr9UI1W3CWK78rEdojq3VXuYyRH+v0U38zXij2SWI7XKwyks9Tna/8Xl9+EVbrgSjQ/DH2e7+OMH07bIOvh3ce1PVEyRSt6AVSX1D1FuJ1RR2a7zZ2ricgOgBf9Y7eiGJjQoyGsLXLF3D+9Bx81Cnu2JPbOwEIPW3VeEwXJo5AgbVl0jwG2QSdcO7pyVQ97VKQsy9AKKK5UqshnDPTbzLgMMtJKj5xLw72afK7aMoI+xaN1TAtD38n9aAIGwop5r0SVGtO86f9vTeVP7DdgwovSNoVHW+EJmNQs4LNQKJK33yGlkz8bNeTh7oVpQnSK4+WH0JB9LtrCOEk4zjoUA8yXgLHv2jNESVMEeuFyDdm97I5ZBngmTpwtJCDZO/u6V3JPoZUe0gS/0FoKW/JJm9eg0aJ6mqVyHMYgiTE1A/tVEzSDJoJzOrOzTKTyyh2vIL/dnqJXZKmSRufZW8GAocCTpR6rYtBPMmLtH1StQlYI/OAolut4ajallcQCro0hGqUmqZHsWATMrmunwoaR7n9TfyIZNHK2GzusG/iCD23ePoJ9a6UHOr5KDJSfD08rZjAbWYhK+fLaOfdDLCYp9rOeyrB863MuujtTLtmhrM3NOYuHrWrLsZuWTC4wUX85aZHI2QnW2LzwGqlSuT6y+PHWPMpNzSNZ7AAtyZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199015)(5660300002)(2906002)(6486002)(38100700002)(86362001)(478600001)(82960400001)(7416002)(186003)(66946007)(54906003)(8676002)(110136005)(4326008)(966005)(8936002)(41300700001)(316002)(66556008)(66476007)(6666004)(9686003)(26005)(6512007)(83380400001)(66899015)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fZuncF4KqQ4D1lYmMqHPbzYgAfr9JdNAAL5NUAuVCWReUgIz7hAw6DpVampy?=
 =?us-ascii?Q?Db8NUK6EXtJoNuUV2+Ezau1xs8FHM3I2Q6kRHMRWUxZVtJmTuofAffTlKU/C?=
 =?us-ascii?Q?SiAoVPrw9/U0m3oaF9flZEPE2W2noxfNXEIEq1qf5WTF/2eNjni+lWGNY2pL?=
 =?us-ascii?Q?K8bbc688df24zaOffzRiGts2qZxVJbVOQ8cI03NU3NBEA4upgUbcHaDfOa9c?=
 =?us-ascii?Q?QBrvJCaHUE15U2TkbBTXByqmz7EsSzlYMhrv1yhnreOb8OWRMh98XAQXIFZZ?=
 =?us-ascii?Q?rU9C1uKimEWRpJ8JTPqLkfZppVEee4S0unqTJITF6RLwcolrTcdPKzxUWEMs?=
 =?us-ascii?Q?OzBJTaey3dRZkIiDC/YDUfQQ/vFxhYYM8YGUT/91znxjx/tVWfTGUjqvDb2L?=
 =?us-ascii?Q?JDlF/UVmibVfGh9NByK98FVOIz4wSUyo32vifzQEj6wS1iuzD7fON9ngPS0x?=
 =?us-ascii?Q?rj3thsuRQ7Fmy7zm5rz33YEX1H55zOlONMMu+d49DWCB1glukUNfi+YJCQfu?=
 =?us-ascii?Q?msaEvjouLbWl+pGGfXT7WMZCojc2b+WgrolOlCyR+7NFUxc8Tt/FtLUraKCK?=
 =?us-ascii?Q?fa9ic1yqybv5JvI70pUx9sFNnAa6vBFn/avXr7nJcNNnQd/hk6xBkWfAE32N?=
 =?us-ascii?Q?dJmu133nfKM1xXH8mj6j5fZ1+ATFe3RdLC+Bl9TpbhTeaSmKW0TdkhIqb68Y?=
 =?us-ascii?Q?rHlESb59lRLOop2tko2jn7MJcdD5xeM+Co6131VgdiSD9CIYShPAAj8J15tG?=
 =?us-ascii?Q?ArYYyPAnu75tWMlhwxBx6FybS4u5Zk2JlVX5SxIVZN6aM1625qwDX6ediXt2?=
 =?us-ascii?Q?JFTv9YdAHNl/XvgKqVLPF6+9/iU2X+4o1AIwngVBBSi2cKWanc0MeBdPkpQH?=
 =?us-ascii?Q?M6Gq5gi+A6OvZW4iknIxaPSFymDGE9/QgCu/wE+v+V060n94pslLcu94/KtI?=
 =?us-ascii?Q?9xqvwftu4Prk1/wpgoBzS0UYoZqMuHWRxfBGTYognSspT6PORHDmFbIBpM07?=
 =?us-ascii?Q?7Kuzoyg6EWusQF/A8QS5dxjtH2UtAZ5Mi6DrlFHWoGyhH+q6sex65RIU9QZJ?=
 =?us-ascii?Q?6UgBqx2BivfcS4nB6UeCPeDr+nDo7iZyTdcCoSMCYkNL/kovpouxtDG9pab2?=
 =?us-ascii?Q?SjJ3qeYTJfst7tYkr/tgE5w6X6oYOfDjl4Q9cAC0nVBr0pDpPLxeT+4XAL+S?=
 =?us-ascii?Q?HOeRaLSimtWsoI9qVjDSDjFBVBsNTSHJAMfxBwo+FkuebkbGxpviEuZtothA?=
 =?us-ascii?Q?q81EnFVF30fgZHjBie/HrjtFE6OpDV12yiE0rL59z+o96kOJkaiXcPGNGm91?=
 =?us-ascii?Q?FVX8EGzHxTBmuQ6szJ8TyuGWVfgIgTLXVGMryXSlyu3eQKbcLWwTSAVoxLy1?=
 =?us-ascii?Q?BEAKSiZlDqBIRG6n2pABdHMGSLCUYz5eu54WmbZaphclyunligYJO8UGd48s?=
 =?us-ascii?Q?vNqprJT/LJLpajwdB0S4R/Xo0s9wrbOY2uaV/PEvvnYMJSjHz5G/Z79VMiDI?=
 =?us-ascii?Q?RkQoz4Bu9TCf2i9Rw5t/EUpZ3xCoZjOibKpSiggkhpWO7sY72AuBKtSo0SG6?=
 =?us-ascii?Q?3NU8VOMsdmdPafHokH+H13fZ6Kn+r7qedjeRMKX3M6NLPnl4M0zAXHHWFL6G?=
 =?us-ascii?Q?bQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1bee1f8-54bd-4d03-1ac4-08daa2730435
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 23:33:30.4061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KFxikyDz/3+kbcnl/A8lptYVDe52QvVEAXI9GG0baEW8kI8dq2Ft4Am5qjMcYx76F5VOnzPix6s0pWanaRkFhULlzDd5ww7tOqY8zvusu50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7210
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan Kara wrote:
> On Mon 26-09-22 09:54:07, Dave Chinner wrote:
> > On Fri, Sep 23, 2022 at 11:38:03AM +0200, Jan Kara wrote:
> > > On Fri 23-09-22 12:10:12, Dave Chinner wrote:
> > > > On Thu, Sep 22, 2022 at 05:41:08PM -0700, Dan Williams wrote:
> > > > > Dave Chinner wrote:
> > > > > > On Wed, Sep 21, 2022 at 07:28:51PM -0300, Jason Gunthorpe wrote:
> > > > > > > On Thu, Sep 22, 2022 at 08:14:16AM +1000, Dave Chinner wrote:
> > > > > > > 
> > > > > > > > Where are these DAX page pins that don't require the pin holder to
> > > > > > > > also hold active references to the filesystem objects coming from?
> > > > > > > 
> > > > > > > O_DIRECT and things like it.
> > > > > > 
> > > > > > O_DIRECT IO to a file holds a reference to a struct file which holds
> > > > > > an active reference to the struct inode. Hence you can't reclaim an
> > > > > > inode while an O_DIRECT IO is in progress to it. 
> > > > > > 
> > > > > > Similarly, file-backed pages pinned from user vmas have the inode
> > > > > > pinned by the VMA having a reference to the struct file passed to
> > > > > > them when they are instantiated. Hence anything using mmap() to pin
> > > > > > file-backed pages (i.e. applications using FSDAX access from
> > > > > > userspace) should also have a reference to the inode that prevents
> > > > > > the inode from being reclaimed.
> > > > > > 
> > > > > > So I'm at a loss to understand what "things like it" might actually
> > > > > > mean. Can you actually describe a situation where we actually permit
> > > > > > (even temporarily) these use-after-free scenarios?
> > > > > 
> > > > > Jason mentioned a scenario here:
> > > > > 
> > > > > https://lore.kernel.org/all/YyuoE8BgImRXVkkO@nvidia.com/
> > > > > 
> > > > > Multi-thread process where thread1 does open(O_DIRECT)+mmap()+read() and
> > > > > thread2 does memunmap()+close() while the read() is inflight.
> > > > 
> > > > And, ah, what production application does this and expects to be
> > > > able to process the result of the read() operation without getting a
> > > > SEGV?
> > > > 
> > > > There's a huge difference between an unlikely scenario which we need
> > > > to work (such as O_DIRECT IO to/from a mmap() buffer at a different
> > > > offset on the same file) and this sort of scenario where even if we
> > > > handle it correctly, the application can't do anything with the
> > > > result and will crash immediately....
> > > 
> > > I'm not sure I fully follow what we are concerned about here. As you've
> > > written above direct IO holds reference to the inode until it is completed
> > > (through kiocb->file->inode chain). So direct IO should be safe?
> > 
> > AFAICT, it's the user buffer allocated by mmap() that the direct IO
> > is DMAing into/out of that is the issue here. i.e. mmap() a file
> > that is DAX enabled, pass the mmap region to DIO on a non-dax file,
> > GUP in the DIO path takes a page pin on user pages that are DAX
> > mapped, the userspace application then unmaps the file pages and
> > unlinks the FSDAX file.
> > 
> > At this point the FSDAX mapped inode has no active references, so
> > the filesystem frees the inode and it's allocated storage space, and
> > now the DIO or whatever is holding the GUP reference is
> > now a moving storage UAF violation. What ever is holding the GUP
> > reference doesn't even have a reference to the FSDAX filesystem -
> > the DIO fd could point to a file in a different filesystem
> > altogether - and so the fsdax filesytem could be unmounted at this
> > point whilst the application is still actively using the storage
> > underlying the filesystem.
> > 
> > That's just .... broken.
> 
> Hum, so I'm confused (and my last email probably was as well). So let me
> spell out the details here so that I can get on the same page about what we
> are trying to solve:
> 
> For FSDAX, backing storage for a page must not be freed (i.e., filesystem
> must to free corresponding block) while there are some references to the
> page. This is achieved by calls to dax_layout_busy_page() from the
> filesystem before truncating file / punching hole into a file. So AFAICT
> this is working correctly and I don't think the patch series under
> discussion aims to change this besides the change in how page without
> references is detected.

Correct. All the nominal truncate paths via hole punch and
truncate_setsize() are already handled for a long time now. However,
what was not covered was the truncate that happens at iput_final() time.
In that case the code has just been getting lucky for all that time.
There is thankfully a WARN() that will trigger if the iput_final()
truncate happens while a page is referenced, so it is at least not
silent.

I know Dave is tired of this discussion, but every time he engages the
solution gets better, like finding this iput_final() bug, so I hope he
continues to engage here and I'm grateful for the help.

> Now there is a separate question that while someone holds a reference to
> FSDAX page, the inode this page belongs to can get evicted from memory. For
> FSDAX nothing prevents that AFAICT. If this happens, we loose track of the
> page<->inode association so if somebody later comes and truncates the
> inode, we will not detect the page belonging to the inode is still in use
> (dax_layout_busy_page() does not find the page) and we have a problem.
> Correct?

The WARN would fire at iput_final(). Everything that happens after
that is in UAF territory. In my brief search I did not see reports of
this WARN firing, but it is past time to fix it.

> > > I'd be more worried about stuff like vmsplice() that can add file pages
> > > into pipe without holding inode alive in any way and keeping them there for
> > > arbitrarily long time. Didn't we want to add FOLL_LONGTERM to gup executed
> > > from vmsplice() to avoid issues like this?
> > 
> > Yes, ISTR that was part of the plan - use FOLL_LONGTERM to ensure
> > FSDAX can't run operations that pin pages but don't take fs
> > references. I think that's how we prevented RDMA users from pinning
> > FSDAX direct mapped storage media in this way. It does not, however,
> > prevent the above "short term" GUP UAF situation from occurring.
> 
> If what I wrote above is correct, then I understand and agree.
> 
> > > I agree that freeing VMA while there are pinned pages is ... inconvenient.
> > > But that is just how gup works since the beginning - the moment you have
> > > struct page reference, you completely forget about the mapping you've used
> > > to get to the page. So anything can happen with the mapping after that
> > > moment. And in case of pages mapped by multiple processes I can easily see
> > > that one of the processes decides to unmap the page (and it may well be
> > > that was the initial process that acquired page references) while others
> > > still keep accessing the page using page references stored in some internal
> > > structure (RDMA anyone?).
> > 
> > Yup, and this is why RDMA on FSDAX using this method of pinning pages
> > will end up corrupting data and filesystems, hence FOLL_LONGTERM
> > protecting against most of these situations from even arising. But
> > that's that workaround, not a long term solution that allows RDMA to
> > be run on FSDAX managed storage media.
> > 
> > I said on #xfs a few days ago:
> > 
> > [23/9/22 10:23] * dchinner is getting deja vu over this latest round
> > of "dax mappings don't pin the filesystem objects that own the
> > storage media being mapped"
> > 
> > And I'm getting that feeling again right now...
> > 
> > > I think it will be rather difficult to come up
> > > with some scheme keeping VMA alive while there are pages pinned without
> > > regressing userspace which over the years became very much tailored to the
> > > peculiar gup behavior.
> > 
> > Perhaps all we should do is add a page flag for fsdax mapped pages
> > that says GUP must pin the VMA, so only mapped pages that fall into
> > this category take the perf penalty of VMA management.
> 
> Possibly. But my concern with VMA pinning was not only about performance
> but also about applications relying on being able to unmap pages that are
> currently pinned. At least from some processes one of which may be the one
> doing the original pinning. But yeah, the fact that FOLL_LONGTERM is
> forbidden with DAX somewhat restricts the insanity we have to deal with. So
> maybe pinning the VMA for DAX mappings might actually be a workable
> solution.

As far as I can see, VMAs are not currently reference counted they are
just added / deleted from an mm_struct, and nothing guarantees
mapping_mapped() stays true while a page is pinned.

I like Dave's mental model that the inode is the arbiter for the page,
and the arbiter is not allowed to go out of scope before asserting that
everything it granted previously has been returned.

write_inode_now() unconditionally invokes dax_writeback_mapping_range()
when the inode is committed to going out of scope. write_inode_now() is
allowed to sleep until all dirty mapping entries are written back. I see
nothing wrong with additionally checking for entries with elevated page
reference counts and doing a:

    __wait_var_event(page, dax_page_idle(page));

Since the inode is out of scope there should be no concerns with racing
new 0 -> 1 page->_refcount transitions. Just wait for transient page
pins to finally drain to zero which should already be on the order of
the wait time to complete synchrounous writeback in the dirty inode
case.
