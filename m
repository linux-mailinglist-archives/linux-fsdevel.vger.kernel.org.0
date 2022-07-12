Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483AC571056
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jul 2022 04:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiGLCje (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jul 2022 22:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiGLCjc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jul 2022 22:39:32 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE9B8C76C;
        Mon, 11 Jul 2022 19:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657593571; x=1689129571;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Tqqn7n5G9atdeX0TyirP31UmOSuxZTIYeAd6aN5uiE4=;
  b=bRaCns8ankAhDow0HDCSLruVho4+hQYv0hUhmQRYVl27qFJgKbkjkBCr
   inNRbHkpUf17XRj2HWjfVixQahsH2PM4+E6sWn7Fh9moAT841tqZ1o8CX
   B4L7UgH3lp2z5CBDQtufGMAtHQsONncZb6ldsyR1uAc02/8LEiFauqtWa
   r1N552GRCYr4i8RuHn3kDsYnTonpjY6N49KNa8H6Q/5S3EERePMd55iuJ
   U8dlZZLV1+agGyl5UOZqZ80G6imSqP1Zob2MS5w/BaTq2VUna1IEhe9g8
   eYvNQgUjrXL0FF0D7Y9IG9YVhbIaou2AGkpaORaG+31mXZiMErGCCXobr
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="371129179"
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="371129179"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 19:39:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="595122845"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga002.jf.intel.com with ESMTP; 11 Jul 2022 19:39:29 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 11 Jul 2022 19:39:28 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 11 Jul 2022 19:39:27 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 11 Jul 2022 19:39:27 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 11 Jul 2022 19:39:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTkfebjL13XeSSict0syx8/LD/WjJW1445kXgeInYG9TzAquADItLTs3zfmMlsmxnU+VQRFi6w3WF1aELbIus5/QZnXqaHMOE7Ipfmetu4u0o6IfXA/GJHoNpPGGA/D1/B9LUmb7C6wU3Opnbu3FqtGkwnC0VpehQcs55pui/bKkGzCoI/mqk0+w1AsLPx6yYPi7rSd5QZ7CEUZtHVMFbND/NpBJxdw59dsRK4TbD6xExkvjCgeEQHk/QkSkZ0VHxjlcKCRtT5jj42jZ6YvmEFTYIG/TUGl0JaKPBgLJDGTuvyrtuMOSpkHHMkVjA1LRmc98zyYKHdd8z7c99bfmMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/MUzRys3a2grhSplw18vM/9dz28UCEUmiOqEH9nhKqI=;
 b=eJOtu9x2nOuFlm30wu6Szp13epuKHE3R4/UQn36OQskxmn3dFvQlEqrTFf5nDIrasPR0zJHswOeVa3S5vHXJOM8LHoDMmsEKSDKPNdWvKfupLGjj87L7gHXadq6+7iHmhzJdv5DEpfygCuCYM1Scw0yW9WdQ7oVbqzmnFToDg2Q06p7g81Wcp5MAaDHg8+REruxi+3lEVvHSLYsnMONI9D1asyevi31g1SdzgG5Th2NTuqXqe4LpFx3SsHSrzPNfJ4SG4ye/IJwzbmhN0XyTv5Hfn6cMFolo1/CezFHFqhvCaS88MVTA9k4LrSGRK0kWZCl70DmBybm4G/NCG2542g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MN0PR11MB6011.namprd11.prod.outlook.com
 (2603:10b6:208:372::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Tue, 12 Jul
 2022 02:39:20 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5417.026; Tue, 12 Jul
 2022 02:39:19 +0000
Date:   Mon, 11 Jul 2022 19:39:17 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Muchun Song <songmuchun@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <jgg@ziepe.ca>, <jhubbard@nvidia.com>,
        <william.kucharski@oracle.com>, <dan.j.williams@intel.com>,
        <jack@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <ruansy.fnst@fujitsu.com>,
        <hch@infradead.org>
Subject: Re: [PATCH] mm: fix missing wake-up event for FSDAX pages
Message-ID: <62ccded5298d8_293ff129437@dwillia2-xfh.notmuch>
References: <20220704074054.32310-1-songmuchun@bytedance.com>
 <YsLDGEiVSHN3Xx/g@casper.infradead.org>
 <YsLHUxNjXLOumaIy@FVFYT0MHHV2J.usts.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YsLHUxNjXLOumaIy@FVFYT0MHHV2J.usts.net>
X-ClientProxiedBy: BYAPR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::32) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: adedf25b-8889-47f6-0ad5-08da63afb8bf
X-MS-TrafficTypeDiagnostic: MN0PR11MB6011:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hJ/420PM0t/I4B72kkybFBWn+EUwPKyJo81+zixWmvYnTnQDF35cC1G7yDEbnW1g7YWQIvfwjISSKMAaNm8JM/Jtp6ydvQwFFfcJ6UvCZBYLYWVzf8WsSQyWxB3noAFBASqQX5AFQ4cT1SVZj9Zy0nahPrfS6viYmT41VAa6WBWAos6UwJbzMGonLTcBlOjwuvOLvt6dhpYkkzePgIhypNfHUozOHMFvb3uUsceGuzLW67pc9znvqiSYYQqhR14TBODpiBPlVhsv8OjHav+nCR0GrZ2YKcekQZHG9XJRXwt4LDInxnZckIdn3YA+0Z7pNOLfDf/nj0nPvlBzcMY8no0h3HjptxC9AKNKfmaLsYqmoqZEYD4duyk/kvqu7RMZBOcughgqEq0GZ79H3Ckth/LsPp+TVOWaaJfZL5kX4X7uIc77XNnElw140r5OToj/ppw6+UIDtF+Ttee3VC8264agCF2ELnrWnRHv4Jh58NPvVGrSm6smvW0zYEvm4wH0XVtz0XVaJQ1fqcX5W5Q6uow1ItS3k7uSkwyNRe5DH0Pv4lyqBInNn5zFVhOzi2Hme0wXZWRrEqFrLt3CL9LZ8fHnLxYvMmi8O8xFz8ZUZ5sTFj2+XuTFsUD5DuZ8l2EoWmlLyuF8I5XR+SetCIx7T3b1PMl2h6MIMluPGdZHfj9gCHJwcnUfGD9mImgAr4sBq2kOOCvZ7qF161a+8kGM4PZW9LcFwWEAaF0faQTQSQkRvo4/nSoaPR5FSg2tx75611L05ykEgcs9z1RSWFNJKls73dcQtvKVjOe/4Fo4u4EoV7QVT7ZQtbkJd3ZBu/Nq+2QW1xtz2PZpSHH+MqGuig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(346002)(136003)(396003)(376002)(478600001)(26005)(66556008)(6506007)(6512007)(186003)(41300700001)(9686003)(66476007)(82960400001)(83380400001)(110136005)(66946007)(8676002)(6486002)(7416002)(8936002)(4326008)(316002)(86362001)(5660300002)(966005)(2906002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yRpNG9dnK0OM0nxNjk62V1EkCAc+u5qeH1xYLsgRASC2t2YQkJ1OKSpqgHru?=
 =?us-ascii?Q?zO7KIU7Wc74K5mMaiaSzFF/873f7AmH2amnBd+zVg6b0ziHhVduhX0wIPhHR?=
 =?us-ascii?Q?gf/BPteNBVsqSZmQfqqpXtNE3kRPnHbLGsE0lnmTYWCNZ/KyudG3q6a9vSgw?=
 =?us-ascii?Q?ByV5b3gKgrvYhazpy6ub7Nku6QWsqtq7XRQeuGQYtLo1xn33uhH4hACfURdA?=
 =?us-ascii?Q?aUAYRSESsEniKGHlHXVs/aLkvVZ+4c1QC7vkhTa1klAM5/neefuDgwlF92Ab?=
 =?us-ascii?Q?NwrTcYmQZURC4HMtWWmu23Nyu8SATI2A1NRKmbxmiqhPSeqjuF53u311RhAX?=
 =?us-ascii?Q?JovyHfzNxEIxzCoibjXbcpQ835Ea3eWSBGHfdKs4hdTH4DFJ9Kcj7X7XkJCV?=
 =?us-ascii?Q?2JPiwJio14asjQjZnLvUTDStbXSNpIT6dGhD0Bi+licIY3HQTQm1Ejigfhj+?=
 =?us-ascii?Q?PIvXl2d2YC4GU9ibUMfAkH57JcZPFWAk8qImmEigtvXFrO6QEJ2TzqE9y3vL?=
 =?us-ascii?Q?6HFWCZhT2nYgw+LSQ+BicOaWkING+hfuXETeExk6SjamqpTaz6M8+oij12YE?=
 =?us-ascii?Q?jKUVr/vjPewcmg82lt0ZMcES+P3jJb5CnTQfePTHiwG+HtIyRP70pfDLAhP0?=
 =?us-ascii?Q?OtpOLovftHY8bi9pRU5sUa5ZsTonSX+Q7Vr0O+Sy5Bfgtk6nkJmVsDufctxz?=
 =?us-ascii?Q?AgPH9eafIMEFX5GfaGuO46pqOam1Ffxr/z7XNFFnNb8MNZ5P9Dc1PHUUcgQ7?=
 =?us-ascii?Q?sIvPUfJqdOgrHDsDxpb11VmpaSzI343iMTK5M5s8UdPMXhQcy3A9MwdYi+Bx?=
 =?us-ascii?Q?uZuqDCWBGN1oDgaKdWupP4D4RXx+By9TrnKh+WIcra4oGjhYleQ9VKa/Z8vW?=
 =?us-ascii?Q?cDVbOumCFrl0JtvCpc+rc65zDweVfkOSKIqBZXFIX5v8EcQKJUtjAMsG8F2G?=
 =?us-ascii?Q?LvFCnpZtwDVi/kUelIHojrJChJahMtsMKjZVAPO7CO4vfYaf0XvJZ3xItOGT?=
 =?us-ascii?Q?r+qtNPHLpxCHj3B54ZnFKzkA+47kqKPxkNEaLorNhmcjXKiA+om/uZwpSolE?=
 =?us-ascii?Q?3SeB1YGaKGkdPTgTuwddNcr7lzBmmLrZ1qa9X7uDnZ02e4ZO0Agj6mmZgBNX?=
 =?us-ascii?Q?OjHzHzVw3HsivaXC4B7CjIOzS9kXYJfSd224j2VLXk68NvC3me5CC1x2eW0O?=
 =?us-ascii?Q?5frQoLRn/OKSiPMZLVj7Rj1mgG3YzBNFcaLtXFkO7X7qDJK/5DLT3Z+bK0H6?=
 =?us-ascii?Q?MFCPETue5KpS/j1Bpp5sdu6WxPNYeaHxnN2zbScQuXNW/2QVJI3rq1kbmz1x?=
 =?us-ascii?Q?A8agEnv3cG01UffQR3rQifaCihfuTPIgRjdgQCZZ3hFhvttdp2ngV7ZQwAwN?=
 =?us-ascii?Q?63nOUh3WA2EMnwO3Q0YiDv1r90ZYFxdX3v9BpG9enX6qa2YRUxOKMq8s6F24?=
 =?us-ascii?Q?VJBB4q2+nbPVeRl7UCSR6S7k1yv7kwHrb3U/2e0iY9r9+B4BClNzA0qcROEq?=
 =?us-ascii?Q?OCIhHETt7lV2CX0o8CWun3/sM/F+D04qNn8kdQdyjqA5UeculeX8/qX+BC3x?=
 =?us-ascii?Q?Labm8iQWPsp6h+QCoqIDbggUrIG1xvkr+P+exfabC2Wjb43nBB51C0Az1/V2?=
 =?us-ascii?Q?+Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: adedf25b-8889-47f6-0ad5-08da63afb8bf
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 02:39:19.8800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ApRDIpxknI9RfQw1ypZU40IYji3r9515eLw4mmQQtKwZAgDbGQQhgebpfrsRoC/vOiw+6a7F0qZYUiyiNNSElD/em1ccg8jLm8INH1WGdy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6011
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

Muchun Song wrote:
> On Mon, Jul 04, 2022 at 11:38:16AM +0100, Matthew Wilcox wrote:
> > On Mon, Jul 04, 2022 at 03:40:54PM +0800, Muchun Song wrote:
> > > FSDAX page refcounts are 1-based, rather than 0-based: if refcount is
> > > 1, then the page is freed.  The FSDAX pages can be pinned through GUP,
> > > then they will be unpinned via unpin_user_page() using a folio variant
> > > to put the page, however, folio variants did not consider this special
> > > case, the result will be to miss a wakeup event (like the user of
> > > __fuse_dax_break_layouts()).
> > 
> > Argh, no.  The 1-based refcounts are a blight on the entire kernel.
> > They need to go away, not be pushed into folios as well.  I think
> 
> I would be happy if this could go away.

Continue to agree that this blight needs to end.

One of the pre-requisites to getting back to normal accounting of FSDAX
page pin counts was to first drop the usage of get_dev_pagemap() in the
GUP path:

https://lore.kernel.org/linux-mm/161604048257.1463742.1374527716381197629.stgit@dwillia2-desk3.amr.corp.intel.com/

That work stalled on notifying mappers of surprise removal events of FSDAX pfns.
However, Ruan has been spending some time on that problem recently:

https://lore.kernel.org/all/20220410171623.3788004-1-ruansy.fnst@fujitsu.com/

So, once I dig out from a bit of CXL backlog and review that effort the
next step that I see will be convert the FSDAX path to take typical
references vmf_insert() time. Unless I am missing a shorter path to get
this fixed up?

> > we're close to having that fixed, but until then, this should do
> > the trick?
> > 
> 
> The following fix looks good to me since it lowers the overhead as
> much as possible

This change looks good to me as well.

> 
> Thanks.
> 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index cc98ab012a9b..4cef5e0f78b6 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -1129,18 +1129,18 @@ static inline bool is_zone_movable_page(const struct page *page)
> >  #if defined(CONFIG_ZONE_DEVICE) && defined(CONFIG_FS_DAX)
> >  DECLARE_STATIC_KEY_FALSE(devmap_managed_key);
> >  
> > -bool __put_devmap_managed_page(struct page *page);
> > -static inline bool put_devmap_managed_page(struct page *page)
> > +bool __put_devmap_managed_page(struct page *page, int refs);
> > +static inline bool put_devmap_managed_page(struct page *page, int refs)
> >  {
> >  	if (!static_branch_unlikely(&devmap_managed_key))
> >  		return false;
> >  	if (!is_zone_device_page(page))
> >  		return false;
> > -	return __put_devmap_managed_page(page);
> > +	return __put_devmap_managed_page(page, refs);
> >  }
> >  
> >  #else /* CONFIG_ZONE_DEVICE && CONFIG_FS_DAX */
> > -static inline bool put_devmap_managed_page(struct page *page)
> > +static inline bool put_devmap_managed_page(struct page *page, int refs)
> >  {
> >  	return false;
> >  }
> > @@ -1246,7 +1246,7 @@ static inline void put_page(struct page *page)
> >  	 * For some devmap managed pages we need to catch refcount transition
> >  	 * from 2 to 1:
> >  	 */
> > -	if (put_devmap_managed_page(&folio->page))
> > +	if (put_devmap_managed_page(&folio->page, 1))
> >  		return;
> >  	folio_put(folio);
> >  }
> > diff --git a/mm/gup.c b/mm/gup.c
> > index d1132b39aa8f..28df02121c78 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -88,7 +88,8 @@ static inline struct folio *try_get_folio(struct page *page, int refs)
> >  	 * belongs to this folio.
> >  	 */
> >  	if (unlikely(page_folio(page) != folio)) {
> > -		folio_put_refs(folio, refs);
> > +		if (!put_devmap_managed_page(&folio->page, refs))
> > +			folio_put_refs(folio, refs);
> >  		goto retry;
> >  	}
> >  
> > @@ -177,6 +178,8 @@ static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
> >  			refs *= GUP_PIN_COUNTING_BIAS;
> >  	}
> >  
> > +	if (put_devmap_managed_page(&folio->page, refs))
> > +		return;
> >  	folio_put_refs(folio, refs);
> >  }
> >  
> > diff --git a/mm/memremap.c b/mm/memremap.c
> > index b870a659eee6..b25e40e3a11e 100644
> > --- a/mm/memremap.c
> > +++ b/mm/memremap.c
> > @@ -499,7 +499,7 @@ void free_zone_device_page(struct page *page)
> >  }
> >  
> >  #ifdef CONFIG_FS_DAX
> > -bool __put_devmap_managed_page(struct page *page)
> > +bool __put_devmap_managed_page(struct page *page, int refs)
> >  {
> >  	if (page->pgmap->type != MEMORY_DEVICE_FS_DAX)
> >  		return false;
> > @@ -509,7 +509,7 @@ bool __put_devmap_managed_page(struct page *page)
> >  	 * refcount is 1, then the page is free and the refcount is
> >  	 * stable because nobody holds a reference on the page.
> >  	 */
> > -	if (page_ref_dec_return(page) == 1)
> > +	if (page_ref_sub_return(page, refs) == 1)
> >  		wake_up_var(&page->_refcount);
> >  	return true;
> >  }
> > diff --git a/mm/swap.c b/mm/swap.c
> > index c6194cfa2af6..94e42a9bab92 100644
> > --- a/mm/swap.c
> > +++ b/mm/swap.c
> > @@ -960,7 +960,7 @@ void release_pages(struct page **pages, int nr)
> >  				unlock_page_lruvec_irqrestore(lruvec, flags);
> >  				lruvec = NULL;
> >  			}
> > -			if (put_devmap_managed_page(&folio->page))
> > +			if (put_devmap_managed_page(&folio->page, 1))
> >  				continue;
> >  			if (folio_put_testzero(folio))
> >  				free_zone_device_page(&folio->page);
> > 


