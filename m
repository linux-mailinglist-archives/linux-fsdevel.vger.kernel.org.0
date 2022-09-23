Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9568C5E824C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 21:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbiIWTEC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 15:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiIWTEB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 15:04:01 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71875115BEB;
        Fri, 23 Sep 2022 12:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663959839; x=1695495839;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Y0QgUWY4pZ5zkfS37U6ZzM4ZW6nE0HKIU9LR+1mGTIE=;
  b=O6A3prQyw7r8K6ukujuWbfPrAIo93EI467qbt9h0jd4dvXfIoIaw2lEh
   ivtJAhpDg6RdO7f2UXRsv3RHo8Yt4ycylcpOFbAYQzIe7FWMO4y4yyLRM
   9CsnCOvfJ7WrvLZIYA347kRq+gYzOouxdnSEkl6bEiGhXt4c5+j1cCI0Z
   gmgIy3thsxbVBEDeRLj2v+uS7cbeXdcloCk1Ho91Or55HGd7fBqQekSl8
   9xPji6evYFmzcQCGQf5yq5Q3U2OBy2ej77yWyXP4lhcdrGSJl1DnQcCLu
   8SDqjWdrXp6EbQnJ12cCX+jeDnR8ACaQ4qTQ0M9efQ6omT8q8davrFgP/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="283775106"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="283775106"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 12:03:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="949133264"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 23 Sep 2022 12:03:58 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 12:03:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 12:03:58 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 23 Sep 2022 12:03:58 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 23 Sep 2022 12:03:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9wl7zHps3V6nnveTp40aqY7dJgwRxvBz/CMgndO2VDy6zdueSLiSSal1ESPB6P7mFvMixRCENBJSaVyBU8fS0/b1qtUpAMoVJu4d6bYn8MtG/JawINkUmuOMabX8KoQ6hJUiN5NbNtJYwJnydyVN56hxpdqWeeKQC/g759MC4GRVEGvoH+aX+CATEgSICY3EXhHz4mm9UjaRQ0zQpCIItp1CYndeP3QJNtuICtan29Co9tbESPg/iBNvHGqz+TWeqkuc5b0uYFxF9uXJKLs5MUtdEImS4/xZq1/fdyHEI3b2q/7a6urL5DJ0gLtPP6aN/V82uI6spoqOJ3O8tqy8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdKRjL4h/QIGyvP4fNMpO3szis+Q/YKmSPDlydrEyUc=;
 b=CUfl67itocp5O42aDK7Go/0jlCnkWx5C59+JKZFscw0u1QXSbtf0VWgbvT1gWF96JMMpNHz1Q6CF4ei8nEMnCuU1EDgLZtfZ5zKH/UyWEsuHv7iI6E3umxQ4b02XQA+9pxsGCynZ7YhAR15LOSRzszp9MwQ+hl7TA9KhQFWyg8UPb06fFyShoGy620PZvL0N/9Z8t9VReI3r05NyHzgoK1nSLo9Daf6H5hm7IaDQ4t9LZUHrN8HI/J9qrNGhrYoJNLyZ4oYQ4KqmWE4Cxj5knJbz+iTvJsdOkdN85q+iBMovn/IDBGwWJc5vOkXidfsZ2maSSE6jW0QoWC0MKUZFiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SJ0PR11MB5199.namprd11.prod.outlook.com
 (2603:10b6:a03:2dd::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 19:03:56 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 19:03:56 +0000
Date:   Fri, 23 Sep 2022 12:03:53 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>,
        "Jan Kara" <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
        "Christoph Hellwig" <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-xfs@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v2 10/18] fsdax: Manage pgmap references at entry
 insertion and deletion
Message-ID: <632e031958740_33d629428@dwillia2-xfh.jf.intel.com.notmuch>
References: <632b8470d34a6_34962946d@dwillia2-xfh.jf.intel.com.notmuch>
 <YyuLLsindwo0prz4@nvidia.com>
 <632ba8eaa5aea_349629422@dwillia2-xfh.jf.intel.com.notmuch>
 <YyurdXnW7SyEndHV@nvidia.com>
 <632bc5c4363e9_349629486@dwillia2-xfh.jf.intel.com.notmuch>
 <YyyhrTxFJZlMGYY6@nvidia.com>
 <632cd9a2a023_3496294da@dwillia2-xfh.jf.intel.com.notmuch>
 <Yy2ziac3GdHrpxuh@nvidia.com>
 <632ddeffd86ff_33d629490@dwillia2-xfh.jf.intel.com.notmuch>
 <Yy3wA7/bkza7NO1J@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yy3wA7/bkza7NO1J@nvidia.com>
X-ClientProxiedBy: BYAPR07CA0068.namprd07.prod.outlook.com
 (2603:10b6:a03:60::45) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SJ0PR11MB5199:EE_
X-MS-Office365-Filtering-Correlation-Id: 31e831da-eacb-43b1-b4c9-08da9d965d3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T+U1PNFfecaTt4qAGrOEpi8TnZpdd5MT4Lofpi+DK5An5WtIW7bN0Pg+yNvKuruOR/NdFNc4X25DGHN+cbWYtiKZt+rr6uRZrwh7amcakSPw/hLrqLrjegonD00jYdypbNgtmETxWPY2TblBEenrM5LbHTGFuHEGfAdciR+12KYiEpD6f6M/lDROyMTb377MK9XzV7rzjPeTjOLnYTSSRCBx7TXtfqA4vdPl3kYsCM9FFChOuFK/wqzs89YWIgx+IFB1C/KeW01vEKXaA5ABitxv0lZp2b/g/ftebgG6/Up5WNpumxwfR5Zpm6rYkmpy+tyi+ssz8PaXJ5g/bQuJhZbrlE7dkywzvPeQKD16tzXHERS6zh22/fOuvk8zTSp4L+TPxm4dEk65ZVkzsgTjRvucndP3vMWbsFebsC9Lg1CQUAUu/w56TWCLCpuUZX7QUtKIIY0eMlwBFThofNF3e0AF5Sz+gGw3eKmeOJ7VWhOUZzedesCEziLq/8vaAkBJGWCmr/nhhINGc7O3Z5BKQLobDJuz5Afhy1rw2kaV2k7+gTZlDBJlXtl4oLTkIKCU3LQfJgRMC/JGgMaUbFWw6BqxVv83d2nA74CSFbKRI4OlxvK23zcTQ6uwjebVjGklzuHQEITexp0ktBH7bNjnTxopMDzEZ0L3oz+cfwV43xaFOMxeHtXF+PNckYSrqjG0dC/kc8IzmyF0ZiZRL2R0JQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199015)(8936002)(66946007)(4326008)(66476007)(8676002)(6512007)(5660300002)(66556008)(7416002)(2906002)(6666004)(86362001)(6506007)(41300700001)(186003)(26005)(54906003)(316002)(110136005)(478600001)(83380400001)(82960400001)(38100700002)(9686003)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M3rYidYD6zWykUjoP56dAFZ7MtoB4e6N+nzSYNRdXuI8pLbP6xS+nNWtAjCP?=
 =?us-ascii?Q?vTfLsVmNqcoqEy/fTAvFMhTR7aO4jjuDHse7ECnPnsbNLzU5m8Zn2M+ZNtwd?=
 =?us-ascii?Q?sKw9IvkpEcr/diJVbH70hc+hfNf9897aKm3QppkQOLvgO9fZbYA3Zcc4llL4?=
 =?us-ascii?Q?uG5CnPE72jGw8NAwhfC46nXebJwFiaHvxy5030EapQmfSmCqNmq+CLXLeYbF?=
 =?us-ascii?Q?ZkcYrnGELzH89kMfIFyKaoo7Y3CUXXjDFHfyvddKHslSWblrdSDyUuwyOg/Y?=
 =?us-ascii?Q?5l4rd4+Z1nAI169lpXFmbPCHd2eB2RkmkHLsOJpZMwFDSK2PYXKMSVua4EXq?=
 =?us-ascii?Q?zRO4IEh/HMKXQ/6rJy+3lOqlxrIt7wHeHH5pjK8PlP2wJRIUFSthXIsX4uS6?=
 =?us-ascii?Q?tD+4DheF4izZZ1yO5ORmfO5VSxT2+FPzdyQGs24AtHuV8DeCrAqIPMP9KBPC?=
 =?us-ascii?Q?to/C7S/AXBdF0G7qIP3zent0RX/Ky588+eTvjXFckeml2aMazDTSjYDy9Vwr?=
 =?us-ascii?Q?N7jwU6NA0beJZsA9po73Qm6lmMPA7t89KrSDo5dUwMfiYWTJiZDqgMZCzlpk?=
 =?us-ascii?Q?+wbHfauY+HkTWb169hP4YiEsxxWjSlQiiD2y4WQSOXo7rosfpeV/HXNIvGdr?=
 =?us-ascii?Q?6w4iNue7YvRchkvQCdBhtt5A/6D5PBEF3Rk3Jux+D7RospZU26UYvDUdHpUK?=
 =?us-ascii?Q?ESi4cRGjiQYwhRtzc/HOQxAO1fUpudT7uif+JE8mofE6MQggbctQj446nlkS?=
 =?us-ascii?Q?CzVvZ41JFwLk220b5/6GbNsiH7ItdvRYzbHi5Ec62J3cJkhHbNfPJ0U49NrL?=
 =?us-ascii?Q?W6CqA50bFDRpQpr+kCLnG6VCNQ+rqJzezhimYVzCGtV+SqhnDyEkMKIJcRSM?=
 =?us-ascii?Q?uWOKyPuCjmckDDhDNn6cUaP7QWA7/1D1ho/P7V5Zf9cBcpudIhUN+hjBZ9yK?=
 =?us-ascii?Q?Dk3UUn/822B7mdmoiHqiySoBCOXJhyUR/jfTmpZ+fmtd7EVLo7WfJunjDGRm?=
 =?us-ascii?Q?Ix+qNriG8P+tY7Y16ELaIshenboJkNFuoB1Yb6zL4we1bi9YQRNE7+yNCE9R?=
 =?us-ascii?Q?xehHEqxvgfJf2V6DfMxP6/5B1JHMr8ahzQjQll6JRyoKcAx54YJDLC19Abx/?=
 =?us-ascii?Q?o+VQlsmtvhUfKtwwiv8WvV+QMiXXyrmowZAihRmGHh1S8hAtsOkYhnXJK6k9?=
 =?us-ascii?Q?k3PFV89oHgCgz+EvrVW3mxrVt13qNFU7K1zAp734edyAhsNVgbOtxpr5fcfa?=
 =?us-ascii?Q?jfN5ubel6SNSX+qP0M5qfM0QjTAU94YioWkag3dSHFgCRfVwm/YRxsizcKIk?=
 =?us-ascii?Q?XY5tCql9Ehkx4wpDDNENJZHABDmu6Sg0gfEc8eHv4a8ik/S6Ux1YLJrAZ7CX?=
 =?us-ascii?Q?LQX0F5km6Z7xgLvenRt4vmulyCs2Zp01vBD2WgInxbdX+oIN4l7vnZh6Zl9I?=
 =?us-ascii?Q?3anenjAruvfnk3JJjVfzRmgc9YQ/ro53gXjrbocwI4dJSldkFZj2ZoZN3+e8?=
 =?us-ascii?Q?neSLuC/Lmm8vx7ka+fmi13gPd+SBOYeNMNAiig34tj2q4p3CR1e4mKplZqDW?=
 =?us-ascii?Q?QdTQxSuFIJQ0WNko0IlRXGVUAMCsYlLz+dYuOGq04jyIVAOTr6ljg+vVQych?=
 =?us-ascii?Q?fA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e831da-eacb-43b1-b4c9-08da9d965d3b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 19:03:56.2445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8nj56Fw+c1Kl0FJqUjQzRT+wNiqH3ZLrCo2ImpOfWCCDNUAXD0By9q6ce6oGWDK32+f+Gr76dL5UUnW+3GHlrfk0Y/k0AbwsU8L0HGAp0pQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5199
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jason Gunthorpe wrote:
> On Fri, Sep 23, 2022 at 09:29:51AM -0700, Dan Williams wrote:
> > > > /**
> > > >  * pgmap_get_folio() - reference a folio in a live @pgmap by @pfn
> > > >  * @pgmap: live pgmap instance, caller ensures this does not race @pgmap death
> > > >  * @pfn: page frame number covered by @pgmap
> > > >  */
> > > > struct folio *pgmap_get_folio(struct dev_pagemap *pgmap,
> > > > unsigned long pfn)
> 
> Maybe should be not be pfn but be 'offset from the first page of the
> pgmap' ? Then we don't need the xa_load stuff, since it cann't be
> wrong by definition.
> 
> > > > {
> > > >         struct page *page;
> > > >         
> > > >         VM_WARN_ONCE(pgmap != xa_load(&pgmap_array, PHYS_PFN(phys)));
> > > >
> > > >         if (WARN_ONCE(percpu_ref_is_dying(&pgmap->ref)))
> > > >                 return NULL;
> > > 
> > > This shouldn't be a WARN?
> > 
> > It's a bug if someone calls this after killing the pgmap. I.e.  the
> > expectation is that the caller is synchronzing this. The only reason
> > this isn't a VM_WARN_ONCE is because the sanity check is cheap, but I do
> > not expect it to fire on anything but a development kernel.
> 
> OK, that makes sense
> 
> But shouldn't this get the pgmap refcount here? The reason we started
> talking about this was to make all the pgmap logic self contained so
> that the pgmap doesn't pass its own destroy until all the all the
> page_free()'s have been done.
> 
> > > > This does not create compound folios, that needs to be coordinated with
> > > > the caller and likely needs an explicit
> > > 
> > > Does it? What situations do you think the caller needs to coordinate
> > > the folio size? Caller should call the function for each logical unit
> > > of storage it wants to allocate from the pgmap..
> > 
> > The problem for fsdax is that it needs to gather all the PTEs, hold a
> > lock to synchronize against events that would shatter a huge page, and
> > then build up the compound folio metadata before inserting the PMD. 
> 
> Er, at this point we are just talking about acquiring virgin pages
> nobody else is using, not inserting things. There is no possibility of
> conurrent shattering because, by definition, nothing else can
> reference these struct pages at this instant.
> 
> Also, the caller must already be serializating pgmap_get_folio()
> against concurrent calls on the same pfn (since it is an error to call
> pgmap_get_folio() on an non-free pfn)
> 
> So, I would expect the caller must already have all the necessary
> locking to accept maximally sized folios.
> 
> eg if it has some reason to punch a hole in the contiguous range
> (shatter the folio) it must *already* serialize against
> pgmap_get_folio(), since something like punching a hole must know with
> certainty if any struct pages are refcount != 0 or not, and must not
> race with something trying to set their refcount to 1.

Perhaps, I'll take a look. The scenario I am more concerned about is
processA sets up a VMA of PAGE_SIZE and races processB to fault in the
same filesystem block with a VMA of PMD_SIZE. Right now processA gets a
PTE mapping and processB gets a PMD mapping, but the refcounting is all
handled in small pages. I need to investigate more what is needed for
fsdax to support folio_size() > mapping entry size.
