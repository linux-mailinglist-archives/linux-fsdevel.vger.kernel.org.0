Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2155AF4A3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 21:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiIFTmR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 15:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiIFTmK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:42:10 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60B4832FA
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Sep 2022 12:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662493321; x=1694029321;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3ScElBOUparfzIB+K2OWfeDqsoVZWXIeCMsg6xB0WO8=;
  b=Hg0xR851fDaxrCbQhRkGwdWLFzF/Mqtq8A43YuOAzYQfG+GGOFKOo8ZL
   JIReJTACj29jZ1F13uKP37egaXTOvI9si2hj+nV5C3mh7ZN4y0I47sAGr
   SPeZpKHz2LklwjllagiwlUI47SpbbM72KsDLWmTAy5XkSTo8lfQxylMkT
   KbeoAN+8C0tcHWXS9+Rxfp7R3Ik6nWk7IfQaWRKM9nhaF0OYVCqSdUuOh
   oqCHgHVpM3twaycm8RBP3T8yvQ3kaSGNxa7ivfXLZiBB7vefQAm3R1fUl
   DHmSOuV3wz1PpI0Ryyx3LSf5msCo0GJjkT8HCcgt+Cqjb5FCchKxuwR3r
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="279701393"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="279701393"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 12:41:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="647345927"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 06 Sep 2022 12:41:52 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 12:41:52 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 12:41:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 6 Sep 2022 12:41:52 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 6 Sep 2022 12:41:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CH2YZ/G4GiUVEYlz+QUq9GA4YpjUJ/vBiQT7zMNg6hb4wLR/8zsWOab+ZWtpJxGNa3NPuYQv/fTvldJZ5PY127PXECP/un7i73HQcheU05t6wOdsD6ZDdEvO7btl8YUKduCGjNgdR1AuUX9vMwsWHjAKxrNE/jD4vvB05q9AsC0C3b+89wcQuGFTdl094mzLxHVkDa6vJj5AP04smgRt1xZ8/1MHs1wODL1QShxaZTkA/e2ieo2Vpwt7mT5WNSMDv4duKqQ9Cz/qcUN/cMzv/IgfIk3nt43m5jWdCtMClLH14808zK9P2Qxs1IYjepD/+cJ86y1fllUZZF8aNuzdGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJBhj2xc+euT1zW53UM2Uuwd/d+l+QiJV1q871i7LRU=;
 b=UUiNKHqMXeGnxgb1Phh832lQQj7yVu2MT9rnqlZIyrjmvNh9Jpifd8R71v6aFCHRCuNg0yW9/ne2nshOZqif3Oal1MFMsbgf9ai8pTjelvujogsLx6yuhSoznLzuDo6yPf5sTXC/Anng51Nww/7SPR/CsUI7GAy93wCzAbs0iJltrTNIhC9tKkNTXXh6z7ZL3cBy4QvWrD+CQhbtSjBz2y8D2rzw1y1S2NzG4kebr3ovk8nZYaJqj/t35P7CiY1Hn5j56WGhZ9zyXa+Ftp1WVyW3JfwdtM4ycHgw0Jr4yZ8x+NEtHC8MFc3PD1NDD0v0uZf7tLoMLYvJLQsuG7fttg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BL0PR11MB3362.namprd11.prod.outlook.com
 (2603:10b6:208:61::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Tue, 6 Sep
 2022 19:41:36 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5588.017; Tue, 6 Sep 2022
 19:41:36 +0000
Date:   Tue, 6 Sep 2022 12:41:33 -0700
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
Message-ID: <6317a26d3e1ed_166f2946e@dwillia2-xfh.jf.intel.com.notmuch>
References: <166225775968.2351842.11156458342486082012.stgit@dwillia2-xfh.jf.intel.com>
 <YxdFmXi/Zdr8Zi3q@nvidia.com>
 <6317821d1c465_166f29417@dwillia2-xfh.jf.intel.com.notmuch>
 <YxeDjTq526iS15Re@nvidia.com>
 <631793709f2d3_166f29415@dwillia2-xfh.jf.intel.com.notmuch>
 <YxeWQIxPZF0QJ/FL@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YxeWQIxPZF0QJ/FL@nvidia.com>
X-ClientProxiedBy: SJ0PR05CA0027.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::32) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f20af3a6-ad4a-4d56-512a-08da903fcf5a
X-MS-TrafficTypeDiagnostic: BL0PR11MB3362:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZKkeAzeRP/5M72IKwXVGIQXaCtLFc/CZbp1yqXeSpv7/hvn0xcb3UOk7DjAS8mz1iu+QgH/bFA4IoYll9AWVpjeJSXooqoQ3oH6Mnv72yjrev9LHCGpq1Sty4YpgrMsnjlcuWCGJ1kB8FfiYSiZE5eC6pFh/uVPA/GepzQpgt+7oU1qUuZpED0X63/s28dD9p8rlx3/H+Yh69gBvrgjSnZEt2scCJihYjWkSUy6yHYIpuvKxVsKy/A+DlW90L/bOmrCzdLfu1979Ytyb2uTWdpo+B5/+vjt2epc3FEfp94EnAS1VoICbLSCXvIJ/6W/MuhgrIfjDADhudUb+DARyVvQR2HMAq9yzscE40ih4C3o6hG+4g8WWyJ7+9/lunBk7pmWH9bPZgiElrpvfgnmkpfKZ3VUyBTyo1M3woPvVrOdnW3Saig5F/mwJcllCRsZDNgAqrhljGWA6inaM07csWBLpru2p7UyEpRaCzIoq02w4afL++DUR1VrmefMkqXxbyU1RYNsByMhJfHgFPgbcWKJ/xFId5sSoT6e1ouB7Cfx2fXsWuvycH94LVi3kBjXcIpe9BTrNHAV62L5S+myl6DvhoYsjsP9j7+z/xzDEX37LUTUFrbno2eM8pJc7pSHQdUYCsdrPSs9unFn2S1Xh56AO6SCdLSs4nOwGHHfEsJ68qGr0cvNvPu1sxWU/xpVhwjkQlVu2yBHsFkc3h6n8Yg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(39860400002)(396003)(366004)(136003)(8676002)(4326008)(66476007)(66556008)(82960400001)(66946007)(38100700002)(6486002)(41300700001)(186003)(6506007)(478600001)(110136005)(6512007)(9686003)(54906003)(6666004)(26005)(83380400001)(316002)(2906002)(86362001)(5660300002)(7416002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BhmREcpRBeRRKQy5f72gm7JwzL94rh+/sTtqrWPH8+KrquvAL6vnVZF9mkyf?=
 =?us-ascii?Q?Ftin1tn/sJc/vUVzCd71rSmA3Sb+P8wF8PrYAQZwsYlmqap41N6gYip1cEEV?=
 =?us-ascii?Q?6nCZOzJHbHzMwWDTKGVdu+DQmajVPGFW7K2s7KV9cwXh29fDkWO3ZbmUrbu4?=
 =?us-ascii?Q?JaY+kUmFdjhnkIGoBBtuXOWzkHu2x7+jLB8Yh19SLfMQIK1vAYyrFpEl6qCo?=
 =?us-ascii?Q?dzoS6m2/xUWIK1RKCzWc4JBb0DyQd/BsaU7RvOam4Ny5Um42DfIrvvlBK4rq?=
 =?us-ascii?Q?SRP0ElxinvhgVkYJ3fonGsTAPMPA29FWYJtEF3VQE1LF8oWtfOYsPVhOHtFu?=
 =?us-ascii?Q?e+CGPWdwws5dS0zPh5uKyTqnHclv/ByKBaWplKN2WlPyGKNsI1yy5FLMIu8P?=
 =?us-ascii?Q?ErKLDj6P+arJBlgJCfpJsMcWQ2dCIAWzRCYnYb0ginTdT3vLI4Z6/s2jkdCQ?=
 =?us-ascii?Q?GnzQVQoC2fCKx6HulCRUryTaB81ky51JLhpctnTC6kMFbh+mOP6eKaYIe429?=
 =?us-ascii?Q?LvDNtkbSlbRjCTsgOiT5XgQd8S186Rmt8B5CcyIejgA9Qc/vpaipccCLueVs?=
 =?us-ascii?Q?ZStbJGwFrJvrGby/0KwkF0SvqMahHbAKJGDfvDGKT/W0suQJG2c8ZgqCjw5L?=
 =?us-ascii?Q?XUBfFQdJbD+ieM3lF06S4c1U5x/WQLq1TF9QxGk9jC/DObUN82ZZvrojUB+D?=
 =?us-ascii?Q?aJzUFhG7k1qzvB5It4X0pBFUeWT3vMAQkEnfb3bYY9r79JYqXv/DsjQBjZYw?=
 =?us-ascii?Q?j4aPnQdHnciQp5sBMlWrWN5stXMfDvi4EgE+ncVXMJJrA8EwdPM9ehpFk6iw?=
 =?us-ascii?Q?pU7DjmestqvrzJQnTTkEj7j7r5X2yV+j6jKQfNd0jLFzDjypeCaOEHh4MrdV?=
 =?us-ascii?Q?9KgH9SkPUteNDEYjKzvWiXa8engUCMJdVwccs1TECS2zhRI31gkp42aAz/l8?=
 =?us-ascii?Q?SNdeAH32x1qNth6iRAhYakuT4SK7UvpiHfJvh4KSbiV0OLV2YD75tTZrct4X?=
 =?us-ascii?Q?fgWcrwAy+j258Ds7DIwMBU9uqa26OQg5R/rd6qArc2HvT+ZedY2plFjixxHJ?=
 =?us-ascii?Q?oiZBn1H+5LvCN8BS5DhpKYJrCkeEZQTXajTEbYttyoSxc5+hUU7AyBH/DLEF?=
 =?us-ascii?Q?YvQxUoK+M1ow4q21OqCLn/IMALA3t9n7LLlNSEJT4pCzqBwGvsvaXu7r/5yu?=
 =?us-ascii?Q?mHpToOdxiiZk+kspaoJhHqlsrjCPvS1IIfGpFP2zfeijcQM+fpP1BWLTxGy/?=
 =?us-ascii?Q?/A0r86P/rj9gBIZik5/pa9GZXVeL8GfV37XMJHNtsSSCuULKUBbaF5yhehGB?=
 =?us-ascii?Q?g8XT04jCynnPsamNJ2MCdR7DJgYot+93RPjFgFaLdwz6o849UO7lbOj2w9VD?=
 =?us-ascii?Q?Bnz7gxkp1uGoNsuvS+vKZNryDnVsJ6YmLhsT7qfX7CnG12FJKdwrPPK7Z4u1?=
 =?us-ascii?Q?q7vsy20lfHwj1xV47yGaSHAJVwtVnXd9l6g9sQyDcakyIlE9E02cdi5RCeCi?=
 =?us-ascii?Q?w+9FqAm2yto9+VZqaXGbh2KZ3hbVKMixhj0r+Bo1l3KYhuCR63UoAvp7dcIy?=
 =?us-ascii?Q?88anT0SXzNqCzefg+E96sn52DKB3n3kmpP8gfryO4qEbWrWK90V8mWayb1Qr?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f20af3a6-ad4a-4d56-512a-08da903fcf5a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 19:41:36.4832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZjfhufQ0daAhmUBrRhaG1D33ueBxLzScEEIFQXp61Iq6pRwpQMDxti/LY29dLSssfePjobbFeUCA+k9YP5Zzg13nRn0QbfOwvgMucK0Mmrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3362
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jason Gunthorpe wrote:
> On Tue, Sep 06, 2022 at 11:37:36AM -0700, Dan Williams wrote:
> > Jason Gunthorpe wrote:
> > > On Tue, Sep 06, 2022 at 10:23:41AM -0700, Dan Williams wrote:
> > > 
> > > > > Can we continue to have the weird page->refcount behavior and still
> > > > > change the other things?
> > > > 
> > > > No at a minimum the pgmap vs page->refcount problem needs to be solved
> > > > first.
> > > 
> > > So who will do the put page after the PTE/PMD's are cleared out? In
> > > the normal case the tlb flusher does it integrated into zap..
> > 
> > AFAICS the zap manages the _mapcount not _refcount. Are you talking
> > about page_remove_rmap() or some other reference count drop?
> 
> No, page refcount.
> 
> __tlb_remove_page() eventually causes a put_page() via
> tlb_batch_pages_flush() calling free_pages_and_swap_cache()
> 
> Eg:
> 
>  *  MMU_GATHER_NO_GATHER
>  *
>  *  If the option is set the mmu_gather will not track individual pages for
>  *  delayed page free anymore. A platform that enables the option needs to
>  *  provide its own implementation of the __tlb_remove_page_size() function to
>  *  free pages.

Ok, yes, that is a vm_normal_page() mechanism which I was going to defer
since it is incremental to the _refcount handling fix and maintain that
DAX pages are still !vm_normal_page() in this set.

> > > Can we safely have the put page in the fsdax side after the zap?
> > 
> > The _refcount is managed from the lifetime insert_page() to
> > truncate_inode_pages(), where for DAX those are managed from
> > dax_insert_dentry() to dax_delete_mapping_entry().
> 
> As long as we all understand the page doesn't become re-allocatable
> until the refcount reaches 0 and the free op is called it may be OK!

Yes, but this does mean that page_maybe_dma_pinned() is not sufficient for
when the filesystem can safely reuse the page, it really needs to wait
for the reference count to drop to 0 similar to how it waits for the
page-idle condition today.
