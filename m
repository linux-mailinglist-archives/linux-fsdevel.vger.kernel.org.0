Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01AB75E5879
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 04:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiIVCRt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 22:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiIVCRr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 22:17:47 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABCA7434E;
        Wed, 21 Sep 2022 19:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663813067; x=1695349067;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PBqlMreOFTWJrVAfvCv8tjlOOJC6GMkU8I9M55dlgr0=;
  b=Vt9cCXOh3SFEn3ETCBxa/vgvuIRnizuIXpuqrKTDofA8IB4BtIV2Qkj7
   Cauoy3rODjsw/Cpm4iBbz/cIAcC/LofIfuy4UYq2OnOLJaeQbb4kT6FvW
   lrqXcQ7vMd7+99g3U4Ikvu51cVoB2z05/VeV9JSRYInbWJiEOdhTv6Wn9
   Qo6bywtTJAmlvGBCDreInEO5cesvrx9CHedG7QEqaYmdOxoyYr+r1nt49
   VCHilzNhHXB8+aTLnbjANygBy9oElVq3y7k6/55TamlN+Zc+JLqNyxUnU
   B9anwwJUCwjJU5LDv4KUOBBnu9aWyMpuxbm3UMc22dsjHLLbOow4Ahtal
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="297775785"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="297775785"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 19:17:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="619603363"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 21 Sep 2022 19:17:46 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 19:17:46 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 19:17:46 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 21 Sep 2022 19:17:46 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 21 Sep 2022 19:17:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SR4AjpG0lHLg2EYmGHJSpri+ASMb16IqqetQzGchR94a0s4isl/ykvDkSFPgWCWfT5DKPyMakS+gCFQ23r40X7zSJQcZLj1l5SjJTr4QV1VWflmBROeM7vCwPYquPXkwoV9lciP02HE+MmerNFu81AKs71mg2iHXV3Brr1nXcqj+wlJSPcXKAY96GOu/VRp4hMvGgdfT+skIkVgga6NNhBCPWLrsZajDIPZI/vbD9UCr3GCZ8PhBjqJ24E3G6pa8OOYZYQMId5KjnvhQk3QIb7AZtBbJT6zjXxSdqmI4OPhgLd+WbgjKt8OpEHKT3Z1Vg2C0zJrQa+VR+0uX4DZOcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OyorMiGMWXdwD+Rvtq6b3gHgF3nxd/KTX8wYy5y9aak=;
 b=hfhO59lLJLX2OGiuG64DW3T3jfNs0p0VD4oK5tS1anjGaYzI2RpFrJo5GNyyQCEHrcGnTkK32MyeiJFwqgIaR+WfuLjIg+U8VNcGSD/KMhhiS/qA+CQDSgMa7sfyINsCzjWSNModkvwoG+BqdW/C/7JcFZTIanMGD94yUcf2JPCtgohMFPuIsxv2c7hq5g60CCmE1Duu9pgw/KA93397vN56XkRKoOWFmsEQTDnsaE8PqT0Pg42vXiAcSYmUsTxmrDaL6dr9Rji2JVmRFjiafajg3hBsS0ldyIhMmoUazRo6Fg+MkP0DM+zIMZsANoovO5ZmQisUDldEMHeR3KV88A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CY5PR11MB6390.namprd11.prod.outlook.com
 (2603:10b6:930:39::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Thu, 22 Sep
 2022 02:17:43 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5654.017; Thu, 22 Sep 2022
 02:17:42 +0000
Date:   Wed, 21 Sep 2022 19:17:40 -0700
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
Message-ID: <632bc5c4363e9_349629486@dwillia2-xfh.jf.intel.com.notmuch>
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
 <166329936739.2786261.14035402420254589047.stgit@dwillia2-xfh.jf.intel.com>
 <YysZrdF/BSQhjWZs@nvidia.com>
 <632b2b4edd803_66d1a2941a@dwillia2-xfh.jf.intel.com.notmuch>
 <632b8470d34a6_34962946d@dwillia2-xfh.jf.intel.com.notmuch>
 <YyuLLsindwo0prz4@nvidia.com>
 <632ba8eaa5aea_349629422@dwillia2-xfh.jf.intel.com.notmuch>
 <YyurdXnW7SyEndHV@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YyurdXnW7SyEndHV@nvidia.com>
X-ClientProxiedBy: BYAPR07CA0050.namprd07.prod.outlook.com
 (2603:10b6:a03:60::27) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|CY5PR11MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: f56afbeb-d681-438d-76ee-08da9c40a178
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xmte8j9JVrQlRYZ4btEd4bxR21cbFKxrN0YQvjfz/r+A6RbZN3KFMe3bMjDv5Owltby/KUJv4a3VaOMCxU4aNsCQ2RbWPBkXFpvqFaww0FV+GVlV1/39PPnKSlw1fpOA3+xEIRlocRjeKUR86MacWsExB10+9KI6h7ry+lBFou/gTUmsSjQ0Z4HCSdqwRrJ8Tnx+Tl3b/8CvuSn36ScUFTytMtlJxR1pbRW4YO+KlIRdRwqg9nl9RRYbg2+UotFbw2o79E+rtk7SBN9ZN6UomMOzOmUnvwsRXG7B38xoVQxrPpwU2zizre2fIS1vZx8Ov435zywierzzYGRURWNUavYzFXeOp/DLGr5FCE+NU+om4ZnusTKb8O2XW/K6K00ioSU4vYohOOfH9XJNwJMeBqPR9ExKXp5nFR6LR6u4MpW+sk77MQIzNzOAbQVKlEUn+txmUfoKrGe1gLqyQGQQ/kWsLmLyjPAXzriTQES2zCgbanxEcLXrvIlnfQbBsoXLrGUh2BvAFvBBUgcaEiSBsZRNUqECfHv7lRUwMToqdaLCOdHM5EWn/15wzbtHCacqdCPJzfPYsG+/RVwV2XEJz2OVD7V10Oykp7SkyrUu2kGxrexEHMbnzOxY2kREBFlkyX63gFq1JQUDD7dNe8rZLTA7dZtZc3ejaQ5XsspgWILehW1YwNgXsZjKMfnFW1J07ovRnWHvkoxWKaUJlcufqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(376002)(39860400002)(136003)(346002)(451199015)(54906003)(316002)(110136005)(86362001)(4326008)(82960400001)(7416002)(186003)(83380400001)(38100700002)(6506007)(41300700001)(6486002)(26005)(8676002)(66946007)(478600001)(6512007)(66556008)(9686003)(66476007)(5660300002)(2906002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wYcUBXJPrV5d2VMgg6iALESWGzWWHqalIct9+FUntAX0gVWvIzN6aGKLYEqE?=
 =?us-ascii?Q?ktKugjG/uteauMfOPgcKGS06VOmceROBOwNtTvxShBV/AOBTmSBLH2uxXvfy?=
 =?us-ascii?Q?lSMYBIS8t7IXet7dPMWkv/1T8KpvP/NExCaSBRBvNzbfEJCrWKDSZbpgVq8Q?=
 =?us-ascii?Q?udJATcJrqw3eDoCFnXq/lVq20B3Wp6zeuBaSFq7smPUc+iTfNeBe9o/s57j9?=
 =?us-ascii?Q?nOJa0yUsEmZOuBoG4hEMIc0LYE8kFZdCWJJT39XWAmYD5FDq1twYh77GWCPK?=
 =?us-ascii?Q?KctdbObyCZ6W0aynuUBu5ZyehMnYsUiRfFXM+sXOyI1HFplJpaGgpAXS93Bu?=
 =?us-ascii?Q?AmCnKXH1k2nHEfgSjukAjb5Z6h3dBfteBG51PjIcK4LSUQTFkJ5ErHGoHLtU?=
 =?us-ascii?Q?+ZfLsovAtWFZlyTYwtRTPfVbWxIQ1BmMzQIddIV+aTuWSvcQMA15O1QCexQj?=
 =?us-ascii?Q?2121RnYQpvdnlO1GAHQ7UaPWZ19TLXIOFfYyOMnI3MNcJNBsF+YT9PjuLYRr?=
 =?us-ascii?Q?emNbZwtx+6U9XuuOsvl6biKflOWxXthzZfoQgVT/p98m/VcwbFpbJlEzVjYP?=
 =?us-ascii?Q?s20ETG1b36iCpyeT9/TCQR/5vrTw3rZNKcDKBc4qrDiDONoT6hS7pYQy+X7l?=
 =?us-ascii?Q?7rBdGEMdcpff8/+wiCBi9xpPX0rWjP9mZenZ3InS+e/7ywlcN+qQRUHJzWka?=
 =?us-ascii?Q?aMbMO7szK8RU7FRfJmmMJdflLokjSt3FICmGrzEvgdftuHr36BeweTdesuCU?=
 =?us-ascii?Q?sLDlMO/BWNclJaqTvJT83S3/BpUePQxZjVQ6ac7jUmJkA5CeENQf9BpKgwAq?=
 =?us-ascii?Q?7G1BJ74baH/EjDa5D2v5lTUOgnrQ70WCy/Szfa00zfqU4LqQ/J+d1aGniWxi?=
 =?us-ascii?Q?VOq0zLv5Qg+mlkHiTMXrr4t/dRxB4+hddww2lFEim70evSBa7EPox7tryWeK?=
 =?us-ascii?Q?5qXTCgz9JPALvjWIyY9lDzSnq1JlbOsHhMSo2qmZGg1EdXzd9VoPJUbMpmDd?=
 =?us-ascii?Q?eOt30HH6xDMpkfRtbG9IIb/i1pAEgttt4Acg0D86tfd/OQMgh14ntJUNolo/?=
 =?us-ascii?Q?RkhJW02u/67+4LT3XtpCSjQ3z7jpbmlVh2MDEtvuUtz8ytYL/JSNPP0cr+YF?=
 =?us-ascii?Q?34Fk1eKaPGDgTdY+PoCkpKgqK170O0XVe+XVYziD3QfejWwLW4PFYd+8OFR+?=
 =?us-ascii?Q?Ni2HsPA9XamSWALe0tNRdghALFyrXpTC1c9mEiPtUFOb1hL1sJJ1to2i8OqX?=
 =?us-ascii?Q?S3a4Oq6R/fE+b+0dpwpuOmy+xnki0DvcVNfLc/J9owMoI44W4z/vVQ3tHdVi?=
 =?us-ascii?Q?Wx2o9yPAGSfl49ZaSrwIIvMnh4A0d4Y/4zkwczCY7wQ8W/YAQzAWJAGHDcDu?=
 =?us-ascii?Q?3zDsPt07Uyvve6IAcOO0Ejh4AKhSgSCoLY7MLg0uYB4Xpfugk4+t7m+6h653?=
 =?us-ascii?Q?rSvwQsKSg1UBbIGLFy67Yn1PcZWE1EMgqjGs8kC81lH6d+nVZoJ+10XuR7b/?=
 =?us-ascii?Q?Aaqe5Jsh5bYXo36J2H1R6GZEnMYi+/Vj5ePE0MyN8+zonEV7WOqm1r8EoPD9?=
 =?us-ascii?Q?l33uKNNHmTcY9pU4o01W46eTqAgCBD73rtLwdiU47+tL/oL+6T6CqhLYJXwd?=
 =?us-ascii?Q?Hw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f56afbeb-d681-438d-76ee-08da9c40a178
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 02:17:42.8462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9bLR0pg5U/eG7YTwIQvOA5/vNNRxG71Vikwpgk6+0RekK0rhjAdhixwagfZovQnG5r601I8rpxR6TYjLB8K8QZzp0VzZ7RavHjW2ytTw+/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6390
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jason Gunthorpe wrote:
> On Wed, Sep 21, 2022 at 05:14:34PM -0700, Dan Williams wrote:
> 
> > > Indeed, you could reasonably put such a liveness test at the moment
> > > every driver takes a 0 refcount struct page and turns it into a 1
> > > refcount struct page.
> > 
> > I could do it with a flag, but the reason to have pgmap->ref managed at
> > the page->_refcount 0 -> 1 and 1 -> 0 transitions is so at the end of
> > time memunmap_pages() can look at the one counter rather than scanning
> > and rescanning all the pages to see when they go to final idle.
> 
> That makes some sense too, but the logical way to do that is to put some
> counter along the page_free() path, and establish a 'make a page not
> free' path that does the other side.
> 
> ie it should not be in DAX code, it should be all in common pgmap
> code. The pgmap should never be freed while any page->refcount != 0
> and that should be an intrinsic property of pgmap, not relying on
> external parties.

I just do not know where to put such intrinsics since there is nothing
today that requires going through the pgmap object to discover the pfn
and 'allocate' the page.

I think you may be asking to unify dax_direct_access() with pgmap
management where all dax_direct_access() users are required to take a
page reference if the pfn it returns is going to be used outside of
dax_read_lock().

In other words make dax_direct_access() the 'allocation' event that pins
the pgmap? I might be speaking a foreign language if you're not familiar
with the relationship of 'struct dax_device' to 'struct dev_pagemap'
instances. This is not the first time I have considered making them one
in the same.

> Though I suspect if we were to look at performance it is probably
> better to scan the memory on the unlikely case of pgmap removal than
> to put more code in hot paths to keep track of refcounts.. It doesn't
> need rescanning, just one sweep where it waits on every non-zero page
> to become zero.

True, on the way down nothing should be elevating page references, just
waiting for the last one to drain. I am just not sure that pgmap removal
is that unlikely going forward with things like the dax_kmem driver and
CXL Dynamic Capacity Devices where tearing down DAX devices happens.
Perhaps something to revisit if the pgmap percpu_ref ever shows up in
profiles.
