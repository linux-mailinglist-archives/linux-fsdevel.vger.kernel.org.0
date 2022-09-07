Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58CDE5AF934
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Sep 2022 02:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiIGAzI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 20:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiIGAzG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 20:55:06 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F0E3FA1A
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Sep 2022 17:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662512101; x=1694048101;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+VL8uqerZkRkQYIfxvY3d6COSDpk5V4SQyb3Tqs9rYc=;
  b=L8EIz8mZ5fkwbPjABm2CqQgWvHdRCXh2SSlhaCR7Jctr345+Lzmh747X
   dXHMC8JPeNeBusGsElH/E/zbz8QJKgk/h8Khf1vb5a0t1Ydx21S4qa581
   FTx0CoqePIDr14jK6EVafVO6+uET0ITgKYKdFXEbZG3RC7UdMwEi2rBD3
   l39upqaHVUrKawGIh3+i/rH6oiicCv9zEOVIjCEhKr/pWsNsPqYyCayOh
   fJs2nMrUpr4fY/oSvICwsbqal0gwjsng+kZR8lNOrsgK7Ctd2S8YtrFbb
   leD9HIvTWHbrf/TdX25EzIOq++g8vg7PmoBAKIQHl5DDRBsvzn6qAvKRS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="283744936"
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="283744936"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 17:55:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="756572639"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 06 Sep 2022 17:55:00 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 17:54:59 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 17:54:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 6 Sep 2022 17:54:59 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 6 Sep 2022 17:54:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=civtswuBtrmbhxOIVq32yyIahY7StbI+8vmGTdwVJeyrzN2eaw84mk9uEvTbBp42Mvi8lJMY9qKmS+oabXnEAhiQM8SmrnIEZU6knzYyVQkyAYPGv1fYR0dxbo0K9EbW0wOEe4rQhnndLpqnPCV9V+U+R0fm72Qdsul9h8f69/+fZbEl/fKGPn/IxTkyjYxMDt2GYIDKkvvTIGb2ONCjS44V33qEKADemqD5oQwSwxF6feKPOZEyEHtY38eBL0OIfaeN5CgdbaprSrgd0QptCtU9uTWq50ws92omI2txDcXqpPgXahbQ5mlgxcaehLDat/mfEJEZZkChLPUapjuc6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XwtyWa3ucPTNT4mxEQr8ZhlJpAzftv92tBzfWF1dRdw=;
 b=OEesnLbt4bIhgcKrnYlw9QuuzRYPgjDipNsVQhlBkbYU5c9vNp2m8CG5lEg7dPCMqGaZtbmHRTb4QLUTr/6GL4lOMQY++Q5LkGsVjKio8kXEyBmOxvQFXBnVmZORvyp49t7U92nlgx8EfZDTRht5dvaiRZlvaPMhJMBibYj734D1AzFd4q2idVBIWkBIl6Q7RZMP+XXwKR2BFalfvL4agJuKDIiJkGtrGtuvWKMbX9IEy+hiECwDmAHJEblLZ9t9DzZdyypPy5jam7xjMtvoCPgY7gOKVxH8wIspf1FqXg9plzQfMkpwYB03X4yR43jFUi393CSvBAHXnpeMaNd+uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SN6PR11MB3309.namprd11.prod.outlook.com
 (2603:10b6:805:bd::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Wed, 7 Sep
 2022 00:54:57 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5588.017; Wed, 7 Sep 2022
 00:54:57 +0000
Date:   Tue, 6 Sep 2022 17:54:54 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>, <linux-mm@kvack.org>,
        <nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 00/13] Fix the DAX-gup mistake
Message-ID: <6317ebde620ec_166f29466@dwillia2-xfh.jf.intel.com.notmuch>
References: <166225775968.2351842.11156458342486082012.stgit@dwillia2-xfh.jf.intel.com>
 <YxdFmXi/Zdr8Zi3q@nvidia.com>
 <6317821d1c465_166f29417@dwillia2-xfh.jf.intel.com.notmuch>
 <YxeDjTq526iS15Re@nvidia.com>
 <631793709f2d3_166f29415@dwillia2-xfh.jf.intel.com.notmuch>
 <YxeWQIxPZF0QJ/FL@nvidia.com>
 <6317a26d3e1ed_166f2946e@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6317a26d3e1ed_166f2946e@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BY5PR16CA0026.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::39) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7477329d-f44e-47ba-291b-08da906b95b0
X-MS-TrafficTypeDiagnostic: SN6PR11MB3309:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QyZWc9KIDLtW9uDMXYB53/VXlHiiPH+hOFSuI1ZslQ3mKqDrZiq9JgHAAzSDOXLEQ6Iq2ll6V1aQaGNLKed3lL7uAEiwDDcaB998IWaGgb88GrhSwB0Zw51gRcQkIFmoLpSvUg3M2l5YIElh7oGFngXbnaF/MIq5SwaevAdxL/QCs0JBZmIm+Zeyg6RwiNQa0Ek54c0QWEicr8rZCPUgGvOf8UvvHRaWkzAX878JdC09V1FBuspMjL/tuxjq0rTF3HOCsxGfDgxjJlJlZWs0TT7f5GSezPcKFByNW28fuU5wig1HS+pjl0MEgKmIlwXLxA0R39iMPH8/nczygSCxsYjj08ou8qpKolV4bbPR4ysIQSNIn+/ld6gHiVw52BUA+Ojx4WyUSv8jnwLHQsmsAExxGK2Jh+uzwg8ztj2E0RXnXOQbAXatlO0MoraGfscdNr4PVfodBULRHedj2ua0JGt9dBOzun26wlxrOrQIOrxZxHOooWD823Xeiq178ecEAKEAT10VQAMMtapIrQ6t+ck7yu2hbHsXzIwL6CeQ0O19JzScvLNaPzBTUR6pbMvgNc7haOhwX+U9q+DHF9D18Y0aVKIIZ246/xry0ewY0SdleOoBJxza+KeVeCg1nIuUDskSHOiBjtb+PTQZk4HuGt7ajfrrgeKGTU1pT4SfxxStiTAvZEcXujcIFn//T5bF/rDxK4bPb9AUBV54hlgPFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(346002)(366004)(39860400002)(396003)(41300700001)(110136005)(54906003)(478600001)(82960400001)(6486002)(316002)(186003)(38100700002)(83380400001)(6512007)(9686003)(26005)(6506007)(5660300002)(8676002)(7416002)(6666004)(66556008)(86362001)(8936002)(66946007)(4326008)(66476007)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AmEaV+sIgfoSANn2oPapBc6sr4AnDiNNAkpnIvkmj8mv7PUk9G/uzcyKwPl8?=
 =?us-ascii?Q?DrE/MTVyAVSZuyRPUW7YwYbhxkt0bEQAuhzpBH3XNtuf5niEbek+GfHNW4eb?=
 =?us-ascii?Q?2XuRyKC3Ez0GUbMusfv8o35htcHrsOtrG0HBx0zwDjzSzprGvXlPtLmawQYO?=
 =?us-ascii?Q?F9awxrmnTm2AScdAwyRSGkoGkMuYMxQe+DcM+WZ0pEJMhtL3UxUa3ldQf1Ma?=
 =?us-ascii?Q?eHvq/SLZd7w5aPqysjMx4QOuhUlDVA0dIzdQlriEHa+41o3ZLZkFfwfAdGA2?=
 =?us-ascii?Q?eex89tQ3+L4Zz001CVhM+tou0owJe2ix6lTcMx4tWsrIJmpH4+x+0qhIL5kW?=
 =?us-ascii?Q?LOWkCa26mptVQY1JNg5OXBSjpXGI13+abYcohL8kXTT26+i06qEhk5O7SQqU?=
 =?us-ascii?Q?zBnmCvqsijTU+TbtNSrvCO7NIbIi3vKXi1/W3DDYCODegScD0uVPxUnWjdC+?=
 =?us-ascii?Q?9Dp6Fl+yNOW0Q+XkYwdKmzagrPVi2f8iOB3557Df+o68Yv9v2QCSzzg/Zxx1?=
 =?us-ascii?Q?f2qxi1ouwrgG3V17q2b7QqaTYycGWUDyzsVXh7shlAqJD9ODFhSKwdiSpcpC?=
 =?us-ascii?Q?wyFyjgPffHUk+yptXJyKTO0YoqcUPYh8eoF3ZU4cbz/BBTbBG8e2vdkextJ1?=
 =?us-ascii?Q?yH04u9IYClUZI1sHsKqFHhhVcvQdhyPh1WFMwZ9YN2gPoqh+H25SKcsKQ0HJ?=
 =?us-ascii?Q?2jETOs4ErZgkdQAF9+7JTrcydvkwDKl5Xu5gKWrSC1y+rDJXTrwQE7hDO3lY?=
 =?us-ascii?Q?kQUp1Gi1jZbewFl7B8keX48xsqIVaKAb0p9ySGdoAw22+2n+mycjQK86iPNu?=
 =?us-ascii?Q?jYW155iliTDiKRglgMNadkiFqgfVT9PlHcLAg0myCX9qy+TovJFIKZIwgL9w?=
 =?us-ascii?Q?H4g+PDLrccp+B+hpnZWdfv1ptgsKX8g0XWYPpdOGfC/6IA9gYTWdTR3Z8Qwt?=
 =?us-ascii?Q?1HAjEzZaa8KsCEL1t+ZpwnqJU9rSDJs4liuydUHPYQ1bGRxAp910RqlI/FdR?=
 =?us-ascii?Q?YebAG1Aid1qK6sUE/LgEOaj5C7j0CuJlBVxMK0ILqydS3BmnurR+5WUOyO65?=
 =?us-ascii?Q?qRZSpV0qslPAl/SLynovZB3ADC7QUBx/Z/1jGpjpxXXwnBr/x+a8d+TVcFB8?=
 =?us-ascii?Q?r15miL0b9humr0BVxE/hgeaIbzzIprXnE/7ND7MNRx2qlM7ODS9Atvo1PCXJ?=
 =?us-ascii?Q?TVCrrElUOxfwvU3sdHaS+zymX0stK2ldIJEL/2l5ULSBFqKw53HvqPCDMaQB?=
 =?us-ascii?Q?bldgp5bP/TToD3n/LA3JOVK4VHjvHFRkCxA2pbPxH7YIwdf4bTUP3IodQxRk?=
 =?us-ascii?Q?1b0W2mfdFghYcSqOwRarzNK5SE5TOQ3aoCrypxRJ1Pto4PnO2gUwLoLpheYd?=
 =?us-ascii?Q?34RN8OAgdhT3uyaAYnZ8+lKfGesf9D0MYFxTg9gdMRC0rCHG7PvTUFFT9/mO?=
 =?us-ascii?Q?W0zbY2uvm2lcGTlgaKEKygFTT8XMXbDV9wYEVEolYTV8BbVqDxjOQzS0Boee?=
 =?us-ascii?Q?z2JoLmoFtBCOyCjiVYkUWzLkF4OunTIa91sro1/n8wtN6Xltj/SSMf0cDtRX?=
 =?us-ascii?Q?FaRD0c/fHe7OzM6uGyuntP0WAPJDq8HBJcYxTcq2o2Sk6HbpxcAPxZbs0RqO?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7477329d-f44e-47ba-291b-08da906b95b0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 00:54:57.5628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ifCT9emUnlq7I0rPad5jX5kVFqgrKBT+umvpae8Mtl/0RRvmOqSgEr8ffmch+e7DGs0+0Pi3F2vT+BArJJzmcbn328OOMVG+UB2I3IhMfWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3309
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dan Williams wrote:
> Jason Gunthorpe wrote:
> > On Tue, Sep 06, 2022 at 11:37:36AM -0700, Dan Williams wrote:
> > > Jason Gunthorpe wrote:
> > > > On Tue, Sep 06, 2022 at 10:23:41AM -0700, Dan Williams wrote:
> > > > 
> > > > > > Can we continue to have the weird page->refcount behavior and still
> > > > > > change the other things?
> > > > > 
> > > > > No at a minimum the pgmap vs page->refcount problem needs to be solved
> > > > > first.
> > > > 
> > > > So who will do the put page after the PTE/PMD's are cleared out? In
> > > > the normal case the tlb flusher does it integrated into zap..
> > > 
> > > AFAICS the zap manages the _mapcount not _refcount. Are you talking
> > > about page_remove_rmap() or some other reference count drop?
> > 
> > No, page refcount.
> > 
> > __tlb_remove_page() eventually causes a put_page() via
> > tlb_batch_pages_flush() calling free_pages_and_swap_cache()
> > 
> > Eg:
> > 
> >  *  MMU_GATHER_NO_GATHER
> >  *
> >  *  If the option is set the mmu_gather will not track individual pages for
> >  *  delayed page free anymore. A platform that enables the option needs to
> >  *  provide its own implementation of the __tlb_remove_page_size() function to
> >  *  free pages.
> 
> Ok, yes, that is a vm_normal_page() mechanism which I was going to defer
> since it is incremental to the _refcount handling fix and maintain that
> DAX pages are still !vm_normal_page() in this set.
> 
> > > > Can we safely have the put page in the fsdax side after the zap?
> > > 
> > > The _refcount is managed from the lifetime insert_page() to
> > > truncate_inode_pages(), where for DAX those are managed from
> > > dax_insert_dentry() to dax_delete_mapping_entry().
> > 
> > As long as we all understand the page doesn't become re-allocatable
> > until the refcount reaches 0 and the free op is called it may be OK!
> 
> Yes, but this does mean that page_maybe_dma_pinned() is not sufficient for
> when the filesystem can safely reuse the page, it really needs to wait
> for the reference count to drop to 0 similar to how it waits for the
> page-idle condition today.

This gets tricky with break_layouts(). For example xfs_break_layouts()
wants to ensure that the page is gup idle while holding the mmap lock.
If the page is not gup idle it needs to drop locks and retry. It is
possible the path to drop a page reference also needs to acquire
filesystem locs. Consider odd cases like DMA from one offset to another
in the same file. So waiting with filesystem locks held is off the
table, which also means that deferring the wait until
dax_delete_mapping_entry() time is also off the table.

That means that even after the conversion to make DAX page references
0-based it will still be the case that filesystem code will be waiting
for the 2 -> 1 transition to indicate "mapped DAX page has no more
external references".

Then dax_delete_mapping_entry() can validate that it is performing the 1
-> 0 transition since no more refernences should have been taken while
holding filesystem locks.
