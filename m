Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE6959784B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 22:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbiHQUwo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 16:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiHQUwm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:52:42 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15C9A74F4
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 13:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660769561; x=1692305561;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2LtIA02PjLLYNny/v/6cZdE/v2DMsjgON4oI30QEL2A=;
  b=MbisVbogqFOz8LJmtHXbNd/b1sVrK5zG3zwEqyxA8C3Bpb+mORnpFEKn
   I1NVjfBb560b+laC/0ETzcpZskELyJ9Ep21AsqgIiO/AhB5bISBsl34KL
   guax+dQOPpH5rD1Py7HUqviaZCufGz0KKmHCRxNNuz6fB8LO6Ib3EH6xx
   KxsKBMtPFTQwgHI/ojb4JmafhvWLPb9h4YTFlTHW69Mitqu8Eqre0kLQB
   9cFcyniMENPN4VUZkRkZ/KpORrJZ+9nsNbUqX1Ip1wyXbEWG8d3S2/kRm
   YejVbNxDrjp8UzX07IXTEyWkLY90hU5N+oKCY3SmmjC25ntRvHxKEBJ2K
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="354341303"
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="354341303"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 13:52:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="853176156"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 17 Aug 2022 13:52:40 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 17 Aug 2022 13:52:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 17 Aug 2022 13:52:39 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 17 Aug 2022 13:52:39 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 17 Aug 2022 13:52:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0w+g3wbJKZkLJ6ZW+dOn78jtZjlv6oA7un6A833WSHZhPLNPkodbEmAF4pnhRoeUocXo41ey/B5Aw8dNDZ5SqUQTSORTm6/oBGsCZP5+cKNbyPcJn9GKTQzrEKKd256QfMsLkjsvet6g6e7mKgZ1F2OWovWicDt+ZgyqXM9gQGb7xSZH56yjl5n192BHsI0135553yp0lNPSJzJhs+PXjCXVAWFQp0YJEmbFTQUZDLtKzVHhz4+rND/m6bxtYq/GtWKqPix6hvHuVhOyt+4RWaILiipFWv1bvu9FvJnNj4bIQ7vCVTQajYwC1aFuO71QCxqcOnrDZo8OmLzhPINng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKey0lkwcZE/c9vphr/Mx4YWiLf5iwim/duT/LAsKMo=;
 b=NNWdqXkXG3U60WFI2oLcOXms28RZPY2gYu36S72al0NcieSHIQBVKBIUqb1t68GLBnmuN+/7BOC4Aindn+tOsAzDeCisH3u6FAs4N0l8x7bFqwFeC+EsYeTiZ5OkZzxglbdQ8xMyGGDnYxC4nIqPOHdRiTW2kyB5Lw+jqkUHluChVSpelISZ10r/xCV0UUeYiyjRhr4931d8HfS+q48X6mpiG/tim6PPHLMX+x7zfimJRWqjyB/q3xSFJSYQ2SjxSxuS5j1nyVdzbrMculW08IhkjbxvuVKZjL8QVMDwFXNkCyUg2mfx28oEEH0IQLN0vBLkUTzaV6o/Q3ZbK6hD9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM6PR11MB2924.namprd11.prod.outlook.com (2603:10b6:5:66::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Wed, 17 Aug
 2022 20:52:36 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4ef:8e90:8ed9:870]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4ef:8e90:8ed9:870%5]) with mapi id 15.20.5525.011; Wed, 17 Aug 2022
 20:52:36 +0000
Date:   Wed, 17 Aug 2022 13:52:33 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: folio_map
Message-ID: <Yv1VETRRT95mV2d3@iweiny-desk3>
References: <YvvdFrtiW33UOkGr@casper.infradead.org>
 <20220817102935.cqcqpmuu3vanfb63@box.shutemov.name>
 <Yv1DzKKzkDjwVuKV@casper.infradead.org>
 <Yv1OTWPVooKJivsL@iweiny-desk3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yv1OTWPVooKJivsL@iweiny-desk3>
X-ClientProxiedBy: SJ0PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::14) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54b7be23-9b4a-4460-0f27-08da80926a86
X-MS-TrafficTypeDiagnostic: DM6PR11MB2924:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +H7GNb14s3mQPi4l8fWM/Eq1KBXWv2RS3VBVl1Ty3P292vP0nFO3QrbsJoW4Tp/Jr2dn2Z6btpQBm/aS7FOLwAwyFn2Aisl2UY7qaS918zPybmEjzA/dUTM2wdL3f77M1ZkWMB2aH4fxBYm30JQrAeDWf0dfybJrC2sqBjXIdL0/B9oYaE2AW6pK6VW286OBVImM1th+StStWNhhPbAHmUz4ebRjls54O3mFT02Bz597I7ZyKlHyeix4CP/ud/CNTsinwkxWnpOpWa5OS6GSYjceVAkMLXK8fdRgTDju0bl+4HvbtXulyw5ABBzyAsdLQ/VY4b0MsRvBcmVyjlSKC67lY+ULQRHFOCCcluIimws7ZThDecpTzBLaWoxjLmo+y9XrtmIYn/RZ8QRPY/yWS3EuG1SXNFXZGaiLEWlJyH/av74sDb4GbT7Qa9kJHPhgJoqqm8DA+HC8/nZZ3BkpjLAj58JX6hjkLL3OMuxgyQ1OqQzjGc6gh5q3PQqoCEX/Z8mgx4ny/NZ0/M2vGK9+SXytvdHHlKYpglA6e5nHm4u6Tf5JDIQZJuDaHRBQhTKb32yR5OPcmP3ohd+ysSiMaety6/M2c5cBjHutul+Il9plKygwFAr0Nl2NXYf5qOTgxux1A4umNh41PPI9IYdKGVXGc63Mgn2u92No1n9L2CX6YB43AtP4a4e684wUGh9t4RYF+1DLtZzeh66jgfLw6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(376002)(346002)(396003)(366004)(39860400002)(82960400001)(26005)(33716001)(83380400001)(8936002)(6512007)(44832011)(6666004)(6506007)(6486002)(478600001)(41300700001)(9686003)(5660300002)(66476007)(2906002)(7116003)(186003)(66946007)(66556008)(4326008)(38100700002)(8676002)(54906003)(86362001)(6916009)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lspyDE0lmcUFPesVs4YG9K7oSMMBa49lk8tSdrprYB/LLmxE79o7N4Yos+m+?=
 =?us-ascii?Q?5iGZFa72NP4j9tLXeHKuENnUkPkdRZSwb89UEQSA/Jczt1M1rRHA/EuZ5YVH?=
 =?us-ascii?Q?w3UjXbgxjpZNuOSd5CVQsBdyngHlvRkc5WsNRDBAvVI2LwI3T64w9cV3CYYn?=
 =?us-ascii?Q?PZOAfzhbQwZ4Nb0r3w16qE9bW3dB4ngMBcri8tmCSLg88S0ygMq/27o+aLw4?=
 =?us-ascii?Q?nUcoU8vYphuRXBQ29EUcRDDneKx/4HfcEMhXOxW/TtoVoxaoeG5vTLZ8DBkK?=
 =?us-ascii?Q?zZZrBN1jVpUdWrWrsfL9ZCvocF2JR8kJOKwp2inj3xnAxybj8NKFJenT3Pmu?=
 =?us-ascii?Q?i1uiOwk2WtFuuz/chdueDu0ccC/BP/Iyt3K0mU7k5EgoKGAVXyg/N0tVgjCV?=
 =?us-ascii?Q?6Fu/SHPnYVEqZxINP2G2eH/TM7QTF/kqogJi36Rwkuy9j74VowH9vFoP2ZeW?=
 =?us-ascii?Q?NsG7OuqHqMjXhBpdkh/jl4kakMJ2nTX88/YoSHJMBhW8FgBMy0Xam9DvPUz5?=
 =?us-ascii?Q?h+JpeW4vnveZhhvMdjuZ27uE7l7+k6idwV5XtkE/5SyEh9W4GYCj1BuNkSlK?=
 =?us-ascii?Q?y+oMyx014Sr4q8Rqh5wW7I22FWEwh89K5cIBKxQ7HD2obgOX4zvGs1VlV4cm?=
 =?us-ascii?Q?8aqWhtUoPI9wVo6K0pXwZDFY42IPoXaVLEXZSY/MSqLCIAWhCbcxCO2s/nV5?=
 =?us-ascii?Q?EGlwgXXQg7KT1E28TT9i6p5InO1Mo2WXiUdx2pkD0mE7VHyasgHXuovHPFcE?=
 =?us-ascii?Q?M6ejU7Y1029k5Y4yfX/xuFW8vr5ortwJtPtn2hv03ZmKckmOUU+mwm9eJ4pl?=
 =?us-ascii?Q?u3GnKMRNSGL/LYHQDq0xyiCLMpK8Zub1JZ7Mv8KfjufNS7d6dJHpByYaDoxV?=
 =?us-ascii?Q?IjLuDF4muniD3qtLxIKYxfADvgRRvzYScbU2MSKuZHvw44f8L+T2I+zwSYda?=
 =?us-ascii?Q?mK+7Y0ZxQV/HqCYhn32XrXrkjHjpdePlhS8lfTXsBN2Wk+yjkce8waW9Vmbw?=
 =?us-ascii?Q?NfURft1KZAWJCObP0Is9+DQhmnqB6ebInMkmXTOZLnlTgvYtPksuC2HHbZtX?=
 =?us-ascii?Q?7YlR7Z7eKwKMoJqBui/MHdKx2WamTsXAxCSltBazwXyvzeSyo4R1ohL6d/1/?=
 =?us-ascii?Q?8cBHjIE2Kh+wg48nk7mjGJ+3B43ppd01dJTdDgcB4f9YlHHW1APEFMU+H/Df?=
 =?us-ascii?Q?72i6xmgU1hO8AWOD/lu2E4zWQ3KOhgFwKNA7bwOxsdflVPdqJOeBp5TCBOFa?=
 =?us-ascii?Q?fXXL9wcNGsqpaNfL0lfgCnEBzj0J/gOG5Lih9rLfpoSQof+YUxms/PrGNDzU?=
 =?us-ascii?Q?O7I/IIj0K2SExk4FoiwBYinnzQRZO+gYQf8p1VsNHU+ruzcHtmjVk8gCr9SR?=
 =?us-ascii?Q?0AFCjgwQpuIE5qg/gtCxdTUsD6H2Nc9x9of66OjKS69jYplDXnG8/xNJjaPi?=
 =?us-ascii?Q?M4PlgWf0uezd3M/Y78ObRRyGU/DUJ1XRu0RARXODJRuZuvC/jRxfy+1JuhCz?=
 =?us-ascii?Q?DkpCzV4rTQnOWmCDWOGjPHyQ3Z7h90m6D8aONNuT9crMOwNKDlc3Tyvl9zlY?=
 =?us-ascii?Q?WNTOeUAEHZ1UaYzuZQYIY3pbQX8dvV/MM2dbpJsZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b7be23-9b4a-4460-0f27-08da80926a86
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 20:52:36.8191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Um9n+9YjzvLvxTIDp16JDeWZlf5yZSXHTk5mcWcB1wLbdZaELn6GooIZ9N+ws4n+Z+uurplAfMD3vYj/2rXeKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2924
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

On Wed, Aug 17, 2022 at 01:23:41PM -0700, Ira wrote:
> On Wed, Aug 17, 2022 at 08:38:52PM +0100, Matthew Wilcox wrote:
> > On Wed, Aug 17, 2022 at 01:29:35PM +0300, Kirill A. Shutemov wrote:
> > > On Tue, Aug 16, 2022 at 07:08:22PM +0100, Matthew Wilcox wrote:
> > > > Some of you will already know all this, but I'll go into a certain amount
> > > > of detail for the peanut gallery.
> > > > 
> > > > One of the problems that people want to solve with multi-page folios
> > > > is supporting filesystem block sizes > PAGE_SIZE.  Such filesystems
> > > > already exist; you can happily create a 64kB block size filesystem on
> > > > a PPC/ARM/... today, then fail to mount it on an x86 machine.
> > > > 
> > > > kmap_local_folio() only lets you map a single page from a folio.
> > > > This works for the majority of cases (eg ->write_begin() works on a
> > > > per-page basis *anyway*, so we can just map a single page from the folio).
> > > > But this is somewhat hampering for ext2_get_page(), used for directory
> > > > handling.  A directory record may cross a page boundary (because it
> > > > wasn't a page boundary on the machine which created the filesystem),
> > > > and juggling two pages being mapped at once is tricky with the stack
> > > > model for kmap_local.
> > > > 
> > > > I don't particularly want to invest heavily in optimising for HIGHMEM.
> > > > The number of machines which will use multi-page folios and HIGHMEM is
> > > > not going to be large, one hopes, as 64-bit kernels are far more common.
> > > > I'm happy for 32-bit to be slow, as long as it works.
> > > > 
> > > > For these reasons, I proposing the logical equivalent to this:
> > > > 
> > > > +void *folio_map_local(struct folio *folio)
> > > > +{
> > > > +       if (!IS_ENABLED(CONFIG_HIGHMEM))
> > > > +               return folio_address(folio);
> > > > +       if (!folio_test_large(folio))
> > > > +               return kmap_local_page(&folio->page);
> > > > +       return vmap_folio(folio);
> > > > +}
> > > > +
> > > > +void folio_unmap_local(const void *addr)
> > > > +{
> > > > +       if (!IS_ENABLED(CONFIG_HIGHMEM))
> > > > +               return;
> > > > +       if (is_vmalloc_addr(addr))
> > > > +               vunmap(addr);
> > > > +	else
> > > > +       	kunmap_local(addr);
> > > > +}
> > > > 
> > > > (where vmap_folio() is a new function that works a lot like vmap(),
> > > > chunks of this get moved out-of-line, etc, etc., but this concept)
> > > 
> > > So it aims at replacing kmap_local_page(), but for folios, right?
> > > kmap_local_page() interface can be used from any context, but vmap helpers
> > > might_sleep(). How do we rectify this?
> > 
> > I'm not proposing getting rid of kmap_local_folio().  That should still
> > exist and work for users who need to use it in atomic context.  Indeed,
> > I'm intending to put a note in the doc for folio_map_local() suggesting
> > that users may prefer to use kmap_local_folio().  Good idea to put a
> > might_sleep() in folio_map_local() though.
> 
> There is also a semantic miss-match WRT the unmapping order.  But I think
> Kirill brings up a bigger issue.
> 
> How many folios do you think will need to be mapped at a time?  And is there
> any practical limit on their size?  Are 64k blocks a reasonable upper bound
> until highmem can be deprecated completely?
> 
> I say this because I'm not sure that mapping a 64k block would always fail.
> These mappings are transitory.  How often will a filesystem be mapping more
> than 2 folios at once?

I did the math wrong but I think my idea can still work.

> 
> In our conversions most of the time 2 pages are mapped at once,
> source/destination.
> 
> That said, to help ensure that a full folio map never fails we could increase
> the number of pages supported by kmap_local_page().  At first, I was not a fan
> but that would only be a penalty for HIGHMEM systems.  And as we are not
> optimizing for such systems I'm not sure I see a downside to increasing the
> limit to 32 or even 64.  I'm also inclined to believe that HIGHMEM systems are
> smaller core counts.  So I don't think this is likely to multiply the space
> wasted much.
> 
> Would doubling the support within kmap_local_page() be enough?
> 
> A final idea would be to hide the increase behind a 'support large block size
> filesystems' config option under HIGHMEM systems.  But I'm really not sure that
> is even needed.
> 
> Ira
> 
