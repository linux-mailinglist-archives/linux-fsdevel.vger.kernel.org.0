Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF17D5AF297
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 19:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239290AbiIFRaV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 13:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238920AbiIFR3x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:29:53 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A2C1ADBB
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Sep 2022 10:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662485027; x=1694021027;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gWNIIWQV8yYn0t8pUVE9gyJM68HQzY8Z604s/T2Rq+A=;
  b=MGZCUUCm4VsfxNuk55HnMKBa9ZZiAniTQ7thgmXzRXF1M/jJb/kWXY+o
   xVSSszn1I9FqMxRpJIsbhJzeIbHE64y1lpSyF58baw0cYR+2xQGQVs8g3
   U4FxUcKjdNUhxgdroPYsefTmHK6YFBfYZh92aWFmLu0aKhEc5l8nb8aS/
   vHji1M3mgaH9X8xclXmbuAkLxkJzpQgKmSsIZbPdKSHwXkUj/RtR2jDI5
   trqk/wL4NSQpc3CURs7CGSjyo8JPSnci0RFRHx1jB/8WKrjUeeVoI4/b0
   2NGSJUVfeN1fHzv5AcrtQStLl21WimUh7ljH9Mf/JOWqfxSL+QDH2dL3/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="297440194"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="297440194"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 10:23:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="614168789"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 06 Sep 2022 10:23:46 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 10:23:45 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 10:23:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 6 Sep 2022 10:23:45 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 6 Sep 2022 10:23:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7L/LmCQOVVkj6w2mp6/6rx2pZoKbj7AeFeSkrJruGaJzRYg+xAZlo6SBRTKInZodHM3IzV2/ns5evNbSqMps5/laHF3j1hzoKgnq4lemz5yXI0rRVsO0xUow341w89Ic7x0xlfDFFVB96zgitP9WQyR1judNpTQjrLwjkC8wU7whc/g/uUZvUVTND9cjCxm6Sr+JLlF3UizQ0QEX+2iQcefXKj+VcsV3zynDdHUS8NwWEWzEg/Dd8o3SuYPSAs8ndKM00p5y/2OBaq3y+SMOMnb4DA2F3w1/rCqo960k0Ca+7qA2tmmpaSiIj3LJVXDENGLcW8kL3ZmkaqxCTiiQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XsQP8AhxzANTBqpsTpW5DuHFGqQ7ZkMzNZZl1nJ2L5o=;
 b=dtvz7f5uuymAX1/JRzvZPe5UzYT4YKx1ikMLlB7q/qJybNC/kpscz9NjSA8LdZ8hgFo+T32HyRnAwn5cEpA1DIbZ96gZCDMTZQwJ7wGwnohylpe7XymQv4mUU2e1CyzNJb1CIXRbTJKJdnT93Oz+Ig/RYthaBPJf98eQKiHzgWjLuJZx2Ov7vdQrlZu00j72+4t0IhCKRM2qIk2DtgCzfjmlV0oPh4mgxQ8yDrwYkMJJjRIPDRsiO+AgU6CUlwMFuxkGikCl62Pu7h3PyieUcX6NmofTan70ZiwgUIuQuNK1W0VEkTjtiSyDXpSCNBOHRiau20khFthynXjuJQBbAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CH0PR11MB5691.namprd11.prod.outlook.com
 (2603:10b6:610:110::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Tue, 6 Sep
 2022 17:23:43 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5588.017; Tue, 6 Sep 2022
 17:23:43 +0000
Date:   Tue, 6 Sep 2022 10:23:41 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>, <linux-mm@kvack.org>,
        <nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 00/13] Fix the DAX-gup mistake
Message-ID: <6317821d1c465_166f29417@dwillia2-xfh.jf.intel.com.notmuch>
References: <166225775968.2351842.11156458342486082012.stgit@dwillia2-xfh.jf.intel.com>
 <YxdFmXi/Zdr8Zi3q@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YxdFmXi/Zdr8Zi3q@nvidia.com>
X-ClientProxiedBy: BY5PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::26) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e60c2e0-a22f-47bd-21b2-08da902c8c4d
X-MS-TrafficTypeDiagnostic: CH0PR11MB5691:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bzZ2zEHGGtgyShvfB1tmwubXi/hH2gnT4T8LpbE5+pUZWaGm1M9ykBIhdAMr5KcilYDnIxdMuFgaQwTcxZpLRLolwqsLPCTIzht/WgDSvPixplvqo+FeH3JIE5HcXHOgNLpX4hbwn3cr7n2Vm5866HUsloLcOK1k38EOfAI8a1wd4Xca1UaAPocp8aStlIEarnda9TbbJcu/2zOMGuu8nDj9GRmyUMe7OpihJ8RDzyMwjFJrGByMwlP+FtqBgZ148JQ2EeYjo6sSistscT498Y4n4Gsf7AbI5kcLr73yR+JlaCB5MUWwIjsb7CJpAR5sQCriQczxB/VFVYGe4mppSQIk/7UzQcair6Pk6AqyPsTUsTDNeoZsOsEWmUMHmaCKlsCj2/AEZPLpeVmoPmiWYkU1wknEyW6jhXuR4cXIeO2BjbSdv1qh3JV0WgYo9JfqOR0eQQbtXepZ/WkBhB8ozBgqRcDqYUVBKhSHgICS5XbeShbywsWHpBu4MCQ8zJjkaWv/B/yTVuYBJzr8Xsy3/uUtHp95Dbq35idfGEe4dQSSXzFanjoHHsHmLy4D2o+bQMUGgMH4k+KTFT3QX7EQbj+0TqqWf9fPeOiZRUi0sepQ5q/eiSYPbICl6FHhykQ0wO8iV8SYLqxgX6set8GTpxrW4e0OfPCpwiHrYrGC55OkEC8xkrnyOUiHQp8gRlwze49TVi46CHr0hfXoMu8C7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(396003)(366004)(376002)(346002)(6506007)(6486002)(86362001)(83380400001)(66946007)(66476007)(8676002)(4326008)(66556008)(478600001)(82960400001)(7416002)(8936002)(41300700001)(9686003)(5660300002)(6512007)(26005)(2906002)(316002)(54906003)(38100700002)(110136005)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zVrbYnhOHtDJpmGm6de5qVjVo9WCtMbYxj9Hz4d1Ng3UmJelugfg7nP4cv85?=
 =?us-ascii?Q?SAMLKob5wNWMT5LA+/WlL3iUX1r1ueFuNgxO/9hCUuGcanAQi0B8qMvSWE3H?=
 =?us-ascii?Q?YVaSQe0FgHEQsHFprja30xiy9s2zGMHnazR4cnZlicv0V8aLNjqaoz/UNvr1?=
 =?us-ascii?Q?PiZ3DwgVZRKez0W1s8oWKKzauZA6SKF4UTN82fv/Jkqvql058Q2XTlgUByi5?=
 =?us-ascii?Q?4e1JeLeACP1kXCTB734KunxH8Q75wzAYHtI5/4Jc9zYxAxsJ2jPqGImmlqnm?=
 =?us-ascii?Q?5vep1Xza/0U2wa4ikLEnjAaMqwKYlu13Kn5sRK+bCT1KxPKZbI+sLdfXtg3P?=
 =?us-ascii?Q?6+NIisZaA6vHRcOscnlZmIgniODbYimRe935Pjt9C1UF0DWhW99ehSHLaoy9?=
 =?us-ascii?Q?IZSJl+EFmJwjNeAh5GUWgjgi4uSle94MMYddaZ/Ua/xlh9fiTHBAd8q/fKgH?=
 =?us-ascii?Q?9J8PW9fQ25Tnr73stvgpgFHPK/BC6b5mcOZS1j6h/vsLGrCCtZoNClUw5BNo?=
 =?us-ascii?Q?QZ1iJZkU2ZfZTDO/432z2XJdQJrTDcgqGL5c85ru4MOEgDw77LLYX+MuCi3D?=
 =?us-ascii?Q?2U7xVquejTqEihtqBU+BfNcw2JG7wePzVfc+ZczxRZ1yhC0g8ICeOU5ImDef?=
 =?us-ascii?Q?Q+hhvsIa/phSvnU0XVwmuoo/RZHkiPL0bGbfwKIbzNcnBxAmQgg7zsxyRlrI?=
 =?us-ascii?Q?A4j5HnXydYIWQcgTDkCVU/FcAUJuUIt5weNJ8Y3E91nvI9KTV1Gf/kEtEuNB?=
 =?us-ascii?Q?zv8kAliNwX0eXta2TYpBa/iRF83QbHdL5pzX0pFnbMOf52fOqNyyL94rPtrA?=
 =?us-ascii?Q?1bh410/RBN1AmbqZgLIPZ5GvpEfTn7aKEmz5ql/nlEUR/YRwHLbZ2Jb5zoWD?=
 =?us-ascii?Q?Edx6fNS1MruzNKHNSR3kNM+SslFaHG+SL0RLFvgfl1mFbdEHSclV7RuCc/v/?=
 =?us-ascii?Q?WAYW3IiYYlHGeIeUMKIzg0OO30GK0cUKAYAMG9hKjgF9doDlgGodz6CHXL3W?=
 =?us-ascii?Q?09eJ/GDAKJxquZ0zMI9hWUo4Oq7iBSx7wCNcIilWvDKxTxgKXmokt5yn/ndQ?=
 =?us-ascii?Q?DkXOwx+1OkTEPfGfPNWWKIuZfVJsHrXX1OF5IF3JbBJWnOAKwOoXacmEQ84j?=
 =?us-ascii?Q?krmb1rfaLFpCTnNhrd1vmhgT/2N/xWpwEGaduARNSNBDfl86P72RH9NTmovS?=
 =?us-ascii?Q?lzeKVCemgG4B+Hhvs/GjP41AiqdWbl7VXwIUp6r3lkxjWDNG3KaD/HlisAzG?=
 =?us-ascii?Q?lnMjr4z51cNrH359KUoLHdIyLOrxZXRbVrvG23ZQEATvW5He0XnYp+0Bv9Lp?=
 =?us-ascii?Q?7IU9K6DhNAk1A0TQWZ2KqVALIgvREefDoamVH7ftGYaB5Acr3q2O7ag+rPB6?=
 =?us-ascii?Q?gauh0KE2Q/inKyoRwe1bSx8MgHdobtlFBwMSmO23Z4tu621vexX0I/RwhVQV?=
 =?us-ascii?Q?Cp5FQTY3FX+xMk7MtL649F/GzcPFWvApJGl5z0Rv7E7jg8BxcyMvCnsZCe0e?=
 =?us-ascii?Q?3L+rpKxLpo4S1vCUeXU9nFOyD2W2O+InyWPoRP5gvgGLvc+17EM/8Rm7YjfM?=
 =?us-ascii?Q?XRwP0zx9Fi6UrQuXs5kxQaWcKzXFiaHd3quMVckPKdiCFeLbZtLqufpjaNd6?=
 =?us-ascii?Q?0Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e60c2e0-a22f-47bd-21b2-08da902c8c4d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 17:23:43.4734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 77pG3TM+vgjfYJMooPIkuQJjyri2HPfB6rx3h/NhRxlfyT6bc8FHX5UzyOV5z04o05jxETa65VUOCGfh7EAKmJZsBipfoonH2Sg9cjMycqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5691
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

Jason Gunthorpe wrote:
> On Sat, Sep 03, 2022 at 07:16:00PM -0700, Dan Williams wrote:
> > tl;dr: Move the pin of 'struct dev_pagemap' instances from gup-time to
> > map time, move the unpin of 'struct dev_pagemap' to truncate_inode_pages()
> > for fsdax and devdax inodes, and use page_maybe_dma_pinned() to
> > determine when filesystems can safely truncate DAX mappings vs DMA.
> > 
> > The longer story is that DAX has caused friction with folio development
> > and other device-memory use cases due to its hack of using a
> > page-reference count of 1 to indicate that the page is DMA idle. That
> > situation arose from the mistake of not managing DAX page reference
> > counts at map time. The lack of page reference counting at map time grew
> > organically from the original DAX experiment of attempting to manage DAX
> > mappings without page structures. The page lock, dirty tracking and
> > other entry management was supported sans pages. However, the page
> > support was then bolted on incrementally so solve problems with gup,
> > memory-failure, and all the other kernel services that are missing when
> > a pfn does not have an associated page structure.
> > 
> > Since then John has led an effort to account for when a page is pinned
> > for DMA vs other sources that elevate the reference count. The
> > page_maybe_dma_pinned() helper slots in seamlessly to replace the need
> > to track transitions to page->_refount == 1.
> > 
> > The larger change in this set comes from Jason's observation that
> > inserting DAX mappings without any reference taken is a bug. So
> > dax_insert_entry(), that fsdax uses, is updated to take 'struct
> > dev_pagemap' references, and devdax is updated to reuse the same.
> 
> It wasn't pagemap references that were the problem, it was struct page
> references.
> 
> pagemap is just something that should be ref'd in the background, as
> long as a struct page has a positive reference the pagemap should be
> considered referenced, IMHO free_zone_device_page() should be dealing
> with this - put the pagemap after calling page_free().

Yes.

I think I got caught admiring the solution of the
page_maybe_dma_pinned() conversion for replacing the ugly observation of
the 2 -> 1 refcount transition, and then introduced this breakage. I
will rework this to catch the 0 to 1 transition of the refcount for
incrementing and use free_zone_device_page() to drop the pgmap
reference.

> Pagemap is protecting page->pgmap from UAF so we must ensure we hold
> it when we do pgmap->ops
> 
> That should be the only put, and it should pair with the only get
> which happens when the driver takes a 0 refcount page out of its free
> list and makes it have a refcount of 1.
> 
> > page mapping helpers. One of the immediate hurdles is the usage of
> > pmd_devmap() to distinguish large page mappings that are not transparent
> > huge pages.
> 
> And this is because the struct page refcounting is not right :|
> 
> I had thought the progression would be to make fsdax use compound
> folios, install compound folios in the PMD, remove all the special
> case refcounting for DAX from the pagetable code, then address the
> pgmap issue from the basis of working page->refcount, eg by putting a
> pgmap put in right after the op->page_free call.

As far as I can see as long as the pgmap is managed at map and
free_zone_device_page() time then the large folio conversion can come
later.

> Can we continue to have the weird page->refcount behavior and still
> change the other things?

No at a minimum the pgmap vs page->refcount problem needs to be solved
first.
