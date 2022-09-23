Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16CD5E80FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 19:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbiIWRmc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 13:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiIWRmb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 13:42:31 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581EE25C5D;
        Fri, 23 Sep 2022 10:42:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJ+DMukW4KToRMHdR45fLtxYfFmNAMFYnrJwQnxw4VpovISpw2xZKK7hjJegnRjuNI6maLTjJrf730dfcES/tn1SO9bVqDk4+edkowzZl5Pfla4+AqS6KspU/aSc97S1SJYga8/w4SImg084Maxf+BC6xAgnSZimn27skNak8ZGxB8a0cOrKzKyz0VK/R/zQE0q3l2VdhLBS1a52OBnKCbPNsptvwsqMEuv7y6V3Y0zxnd2VuYARvkaycktdTBZQ03tMewBwSSHAFJP5G5zoyt5KOxbMM936lA2ThZLEIBEPeL/uaohfl5wHwMFqA8n5fQerpN+MZ+p+sWXge8FoYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mxuJ2UaqE340BCDMHPEPcTbFhSlojnrOKn2aCWzCSU=;
 b=XDRGhOSKYKckLWLARHJUgrjMZHc1Mu2ZbCBIf7WQHd8O9i7azqWsN1ovIYvdQbIqh1HQzCVCax3bLmX4aJ0Rgi/abafwhFaBKuN7JOacJlVU/QnRGFWuPgQA0DOR19OWyvovjtjr1V9LTTel2Jy7GOSTEagl8epaObfYJHczHELnfuCEp5YC3qpvcxLyw5GvfTE/dLPUu4a0rq190JoyiDWQqEodELTLK3A3i7op24PNv3ZC+I/xy8hWx7urP286yVxQOK02xGF0vqduv/QOExhAzikbv/qMmqv3ik6JYT/xj8m8fYG19B1m5S0FXjGsd2pv+VuFotazUN7hubMwQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mxuJ2UaqE340BCDMHPEPcTbFhSlojnrOKn2aCWzCSU=;
 b=Y2g+G68iWHeRbU9wV8Gtd5CZ6O6VLOSJdnVUND3XqRrfyVafSqdheZx3jy3W5uMG2Fzy6v+uYoSivp4P9W5zd6hjiEfiopUoisoAFzdcFTz2B/9NALB42mTmk4X3tZQYsVaoxyW3TjBSXT62ClHTg8MuzE6RNdT7FD4QuBxFM8umWehnKl6C7MBxNfR+C/Vy7JYRYYTjrM3bYj5BbNmzoMJ9cb1WkVjJrjrthtQD32I4OyUzhMUEyIGL7TGkdKUPcc4G6NW/bNjpqHEd7BL2cWyp2ktPSBSJC14MbDH9IkrPEmC5X9rLczjJv6PjGuvFoyCkOLFdthEYWtTUHzSkBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN0PR12MB5882.namprd12.prod.outlook.com (2603:10b6:208:37a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 17:42:28 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 17:42:28 +0000
Date:   Fri, 23 Sep 2022 14:42:27 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, Matthew Wilcox <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 10/18] fsdax: Manage pgmap references at entry
 insertion and deletion
Message-ID: <Yy3wA7/bkza7NO1J@nvidia.com>
References: <632b2b4edd803_66d1a2941a@dwillia2-xfh.jf.intel.com.notmuch>
 <632b8470d34a6_34962946d@dwillia2-xfh.jf.intel.com.notmuch>
 <YyuLLsindwo0prz4@nvidia.com>
 <632ba8eaa5aea_349629422@dwillia2-xfh.jf.intel.com.notmuch>
 <YyurdXnW7SyEndHV@nvidia.com>
 <632bc5c4363e9_349629486@dwillia2-xfh.jf.intel.com.notmuch>
 <YyyhrTxFJZlMGYY6@nvidia.com>
 <632cd9a2a023_3496294da@dwillia2-xfh.jf.intel.com.notmuch>
 <Yy2ziac3GdHrpxuh@nvidia.com>
 <632ddeffd86ff_33d629490@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <632ddeffd86ff_33d629490@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MN2PR01CA0045.prod.exchangelabs.com (2603:10b6:208:23f::14)
 To MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|MN0PR12MB5882:EE_
X-MS-Office365-Filtering-Correlation-Id: 1795f795-587a-43de-ef23-08da9d8afbe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3u2o33zHnWHdzRZW68SgZ2ovQJfjmQYQVa2fhqZf8B1fkluXJtV42A6KxHdVuVZ3QOKoOq5xgXnTB5T4mNDmmXz2XStM34ohEaNas0f8PwT+Ocm5soIBGFhyfIdaSD38Ssf4EbqwtiwKMZ48ork8VRqC7/Txi7cfN9p1THW+tBzFW6jz96r7S019coqsG0BpUU19DvxlzU6sOMUMCvw4UL2cTesfxpoTbmUwKVvJGAN0cDiiLAsJjGGtC/JPwG53UX2ZBpR4VkCWJaXCEFPVGasF9sc/m6mHWBYcZvJQhsZ1P3mbVFFVjYG9J5UK5veDyryWhzDe/wriDUW9VBZfmZcT3yLPdjfZ3AOzZJT9D8d62dPGXYySw90Xi+FjJm6hADfKs74jRL9hSMDPMUzHo/2akA6HY92E4AsISpKsmbQH5pcEQA+sOhW7Wk+BRl3BR6ohb9kXgWoVYKgTksN/MlYuAMWJim6aQARwzKtUxrDdUINS1+1HayHRG2sS4uEXQpuTzIrM4217qcYFNGofVrJhOKacbPPrqNE3ZaMw9sfqS6L2+lWN6UwKL5aHRDXT/nc/96RzXlPBmIbQT29Y8/bXQEypXjH63zsMIEDHbXeezs+0r6ve0U234CLYDMyETYSLN1yRgzptr4mKHZSg4oZbt0aYdxDS7Tc8k4FaaAyAU4KyolbXZipMSWFwK5b+lXb/8ZrdK7wI0zasAbcxOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199015)(6506007)(8676002)(66476007)(66556008)(86362001)(66946007)(41300700001)(4326008)(8936002)(26005)(6486002)(6512007)(316002)(36756003)(6916009)(478600001)(186003)(2906002)(2616005)(38100700002)(83380400001)(7416002)(5660300002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jMc5S62bdSvBTmu+UcpvOjOCtFa+Co2TmNpWbugmv3EMS1q1Hy4SZwrH63v7?=
 =?us-ascii?Q?iqyVdvHWA+ifGUeneE+E+KVl9LNrmmi643OzZ2LIlMGAH9PlD588314MKs9i?=
 =?us-ascii?Q?aSOwQeLNsJ4Fq2TjjGMMQ5VZQs3YmfQM5xw5Mi4GODhTc1zGDsBpXrwTbn+N?=
 =?us-ascii?Q?1JsWNwXGOXME3fo9zw8xCzElOh0/KG/86os2M6ycVECxgB8C/jWpi18B8VeV?=
 =?us-ascii?Q?GmeQ9JY1QoglBfnoBwaUGpM4uzip5vXrhBg1YVH8FYJQ37S4o9GXyTMKSf+v?=
 =?us-ascii?Q?tfOhzlltecjo1V/4xr5SG7O/w6dElvvR46L0AKMCsqN96A9zP/9e5OXX2MaX?=
 =?us-ascii?Q?8yW0deBCIvzCInQ/RQ2fkTsBa2TVWECCyMabNorXTXLdxQYLO2Vvx7ggEasC?=
 =?us-ascii?Q?vRPHlKLjKsTxfgVZcDRjPFrd2U/TsjJwgvciJQUq0ugef1f3yJeLJjyE6jta?=
 =?us-ascii?Q?uUX6u4LO/mbZ27n9KoQFA0XvNPn3iCW7s71Eq4Ek4a1VTsZ366juLuZWc5Xx?=
 =?us-ascii?Q?IhrLHdHMxp5k2UG+Cy1w8tNBnMQlztHR4Kxihu7dR3XtKDCMFsDqc99sSjNP?=
 =?us-ascii?Q?/HM1H9vR42IgGYCmKw5Igb+IZ6RhoncUx4AwFxDHDBqrJGtbVn9UQnwMg92o?=
 =?us-ascii?Q?ygemDGFFgzhs5IfiRIlscUk7xJtChe+L6kT+c9cAUsZOhgBVEX4pI6+vWI1j?=
 =?us-ascii?Q?t4SXgHm/kt4JNUTJSCo6GVx7Z+iVYDXftdlzQsRKsZTH9ZmatWYYDW4P2bz/?=
 =?us-ascii?Q?dEyy+e4VKSUv6I1RcbY9Wqg3nrktqpXwMRcdM6Y77TX8D2DYpCQxV/Jy1Sbb?=
 =?us-ascii?Q?gJavGQUOpOmc8DmbJjTQXgSIjOD7cIJCk2YijeB4UvOwHpSHai8cqNcWEM/p?=
 =?us-ascii?Q?vkmjw11ORrpKb8D0q3Kp0z0kBKZzAVXZPt4Vc4+eE8VDZ4exORA47yedmk0f?=
 =?us-ascii?Q?/N9bpxGnpmQSU5/qYxyoNBbzjfJwuNaBA0CUSbPBjBlUYoHGV9LfOf8St0FK?=
 =?us-ascii?Q?gq9d3Qi8BtzlGeeCBavjGw+ax21j/Akixge9HxYV/7oUy0j1KjwxuI1Jh34v?=
 =?us-ascii?Q?gr14mSdvIvClB279p53MZmEFi0BUf9n2JvNJlnUGlycbm731ubORUJO/C2a/?=
 =?us-ascii?Q?YRzJffNebMk3EU4wkViPtCviKG79WeeSM/NV496yWcS3eKmKzcFlnbyHiHYE?=
 =?us-ascii?Q?e8xx0axXN0dU9hycKtuvVmJgSOTcgN9RV8+s7ZUvnFN0QGjTaHuYci2ePCXc?=
 =?us-ascii?Q?aDV41Vn1fN9ZfJHYIwmmyZKE8MadT/cOTs3b7njdv6gb4uIX4Vyn74ERnA88?=
 =?us-ascii?Q?dUOzBtPhr3Pb1fx9rh+gjUy01+TShYkKRdG67JYa/blRkmLzFm9hwiOS/kRr?=
 =?us-ascii?Q?NtRldqxcqK3RS/7bmwrWviox97vqlAgLQyIcSBfjakrabr3ZfHIMsYEkWq6V?=
 =?us-ascii?Q?xSdKvEerzDfv1ZxOXGFU/8In5ob0djcAfacPihw2Rge7N2JAgMA60O2HB+Qf?=
 =?us-ascii?Q?IMtVpiv7DFm8pBw8fCKExHnspUgYKpsgCzwZem+swCrVfijij0kOh9quBKgw?=
 =?us-ascii?Q?r7wWDKOfxK2rMlbmPFhqOlbMY6Luds7AYikGakOn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1795f795-587a-43de-ef23-08da9d8afbe3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 17:42:28.4663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jtC9cEeuoEPk9FBLNAdHbS0JZ6zaiUxuAslRrE/yX8AfYxdBJj13DP75dTKbdF1j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5882
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 23, 2022 at 09:29:51AM -0700, Dan Williams wrote:
> > > /**
> > >  * pgmap_get_folio() - reference a folio in a live @pgmap by @pfn
> > >  * @pgmap: live pgmap instance, caller ensures this does not race @pgmap death
> > >  * @pfn: page frame number covered by @pgmap
> > >  */
> > > struct folio *pgmap_get_folio(struct dev_pagemap *pgmap,
> > > unsigned long pfn)

Maybe should be not be pfn but be 'offset from the first page of the
pgmap' ? Then we don't need the xa_load stuff, since it cann't be
wrong by definition.

> > > {
> > >         struct page *page;
> > >         
> > >         VM_WARN_ONCE(pgmap != xa_load(&pgmap_array, PHYS_PFN(phys)));
> > >
> > >         if (WARN_ONCE(percpu_ref_is_dying(&pgmap->ref)))
> > >                 return NULL;
> > 
> > This shouldn't be a WARN?
> 
> It's a bug if someone calls this after killing the pgmap. I.e.  the
> expectation is that the caller is synchronzing this. The only reason
> this isn't a VM_WARN_ONCE is because the sanity check is cheap, but I do
> not expect it to fire on anything but a development kernel.

OK, that makes sense

But shouldn't this get the pgmap refcount here? The reason we started
talking about this was to make all the pgmap logic self contained so
that the pgmap doesn't pass its own destroy until all the all the
page_free()'s have been done.

> > > This does not create compound folios, that needs to be coordinated with
> > > the caller and likely needs an explicit
> > 
> > Does it? What situations do you think the caller needs to coordinate
> > the folio size? Caller should call the function for each logical unit
> > of storage it wants to allocate from the pgmap..
> 
> The problem for fsdax is that it needs to gather all the PTEs, hold a
> lock to synchronize against events that would shatter a huge page, and
> then build up the compound folio metadata before inserting the PMD. 

Er, at this point we are just talking about acquiring virgin pages
nobody else is using, not inserting things. There is no possibility of
conurrent shattering because, by definition, nothing else can
reference these struct pages at this instant.

Also, the caller must already be serializating pgmap_get_folio()
against concurrent calls on the same pfn (since it is an error to call
pgmap_get_folio() on an non-free pfn)

So, I would expect the caller must already have all the necessary
locking to accept maximally sized folios.

eg if it has some reason to punch a hole in the contiguous range
(shatter the folio) it must *already* serialize against
pgmap_get_folio(), since something like punching a hole must know with
certainty if any struct pages are refcount != 0 or not, and must not
race with something trying to set their refcount to 1.

Jason
