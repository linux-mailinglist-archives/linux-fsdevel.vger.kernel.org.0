Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9F25EBA77
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 08:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiI0GT2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 02:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiI0GT1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 02:19:27 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43846564D;
        Mon, 26 Sep 2022 23:19:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUpVQtUzMbCkXXFEUH3+xW4XsR7WIfEQJKWSnHkDy4MRSfWhSJxKSzDNCtpTQkG62Rw40HJu5ePnYrKmM16GhIbh7RseaPF6o78gmYQx8/CAUteZ3WNnruA3iLJfrpkDDffdLHOynKzSWUpybxPHHGoyUhSg9kBInIX4blTtxS4zhHlKjg0KIJoKLGCIpGgmpQQkXVuaNt0E4yJ3JPpmYSv3sXnOyoDUIBmrKk+Yi5ykNXjaYNpP0Pl/ECe4L8oe06bRMQf/jcAiYtJ0mltUKIXStvXVdNcn1z1Hx3PXjsz8bpUTtcFFr0AJ5HNdKXOPRurbSTrjgVrXFOHyMI41pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGtjP5vcPZ3DK4sGhHjIlMyi905GAQXL8vOk+v/btow=;
 b=JkbPMFuWyHujzr7Zv1aMhP4veYFsc2NaAwZTXw04sgV+BwczLIwzhkN1U6v7CvycxS0tsHkOSBbx4HeDdYih/aWCE5p+7WpHdK2HGI28ELMalvLeVeP2Bo6d8XbNBlKwbCWxv1Qebz2enuQOZrJKUWmk4VrpNceat1rbbLlPPtBIQJ2oMQTwraniHOeOB0iF50WH+RqLAJqXjIMfta9WRYWm2vwrkxzhirRdoJBj0dZ7qzFhLKXaf2DxPgROoLzNDCmD+sFy3nRpMqZKo7XPLiBmM2zD/Z1Gu7DBdgjf4R79a/Jg+y8PPGT78s9YZvBsBViKi86ViqXletlxK/p+1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGtjP5vcPZ3DK4sGhHjIlMyi905GAQXL8vOk+v/btow=;
 b=gbsev0kEv12WZB6R4A+i1tiSOPPBi8dUwL8T9FFuU8dvFBgVo2nh2dWPES8i54dauo8rRCca0yYOqqiEfUOuRf9rrWFh5iUUdIKVHWKWUnTPxQJJzZagubE8CC/PcdXAYATI7/xx7UqiJUG99wyNSZsMVDTlOME6tdEkAQXARPg53deVOP+F23TIn3bPgxHAPIBie3uGrK77HgYTw+Lc7yA2cuHnQWEJk0rFJ8861PUsROPMGTz0pPMNUJ151UKfGkdG5GHl/wFeftsZGY+kBVPpVDr22yzfajB48YOlNdqbG5SDkG4gNBbZD9vfSqZNwyNjyeW/IIoQX7NviOyngA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DM6PR12MB4912.namprd12.prod.outlook.com (2603:10b6:5:20b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15; Tue, 27 Sep
 2022 06:19:24 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::4064:6c13:72e5:a936]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::4064:6c13:72e5:a936%5]) with mapi id 15.20.5654.026; Tue, 27 Sep 2022
 06:19:24 +0000
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
 <632e031958740_33d629428@dwillia2-xfh.jf.intel.com.notmuch>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, akpm@linux-foundation.org,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 10/18] fsdax: Manage pgmap references at entry
 insertion and deletion
Date:   Tue, 27 Sep 2022 16:07:05 +1000
In-reply-to: <632e031958740_33d629428@dwillia2-xfh.jf.intel.com.notmuch>
Message-ID: <8735cdl4pk.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SYXPR01CA0085.ausprd01.prod.outlook.com
 (2603:10c6:0:2e::18) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|DM6PR12MB4912:EE_
X-MS-Office365-Filtering-Correlation-Id: 5826157f-9fde-4ffb-d427-08daa0503964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S2T/hg8HZPyiw3ppsuGnS9MKPdPh50XBPc1MGINWOS7lmIKQB232nhY9xOUcS3YWnTDM/k5ERUNYRUmcfqiFZSI7UUWHEjNYNZvVd+K3/vwdvjf+J9vJ85Hof6bxogQBw7e+p14E26Ho3KAz591mQ+H3CntSXPHTyUUnoWok8rTRaDdBQebC7qKf26XJqgDYbLrRHXiLk2f7BtOXBLxv5KZkpSow24MwJY9/W8ilLXGzGvbQ4OJswG0Rb8oSf2PPFCkt3zuQiiOYPyb1gIlZ8cLRnZoFejb4orG6RNW298zh+cR3v2vhtR6/L0+6LH2cUwxx1JQzHVIl0VsYvx/UkbY4OH3CMRUG7ZWvvB+lS+JiVibOFjResQ00/+b52seyCPF/255EJ4DZ+VKO4he/kNCcwDBHr2xOQ4D62L+RYqrhiPkW0iclP3hZEV4DXK+IJmJZKjb0fVviTg1fJReYExNPxGPcO4ECFP6fNk0gx3X2/csh/pWWa8TX7g7EuqENZR5Qb3ZmR4TL7It+jLzkXw8TsMbQg/5h+Qr/Xr6603sXylkbu2m0kdbVi4VDp+MnZJKnaMAp1Hpds5IWxoQQCFZS1TVYf1w4RUzrLl2+KnrsFitDnj13xptuBl5I9Vwfa7Zq73KG5HAZYp0CfQSH9+h4U24+QRwPpFIqAGHcSaxBK5zPnVvltP5CGPP9EoOiSLJKQDzRlmwRqzCSDSWKEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199015)(41300700001)(7416002)(2906002)(5660300002)(478600001)(6486002)(86362001)(26005)(6512007)(9686003)(8936002)(83380400001)(6666004)(6506007)(66946007)(4326008)(8676002)(66476007)(66556008)(186003)(316002)(54906003)(6916009)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TAH10BDh5iSFUab6wUF8By6PKcLhxwiyyDpPNPP6z6FDlK5I4/j/g4z/AWWw?=
 =?us-ascii?Q?g57dDWeywTgn8j8qbWcz/aatKdm9ASiM+qE6wAUtxwZk4S/4xNJaDjELiBvL?=
 =?us-ascii?Q?u4qNbTr4Uv+Snh9RdGbi/ck1TZukACxL8+42mzA5kh58zFpjdhnhdVO0/ZTF?=
 =?us-ascii?Q?4EcNI1/EkSQVKObUbRQh0dHuvnv9JW6p+C7ACnA53A/Ey6Wq96fF12+r+UQx?=
 =?us-ascii?Q?pv5JBbWbzj5qCXgkH6ngwiJ7NEikAocbIT6leIU7GNc7xmROa2qLpgPSm/E6?=
 =?us-ascii?Q?oZP2pyVxlUzFTpDvy/PUZYxddkQsYP/+Y1qJ2UfWd8RbNt8RFzzijCVPdl5R?=
 =?us-ascii?Q?gyi+5OaUsr2P7MYQm0sSEJ7Be9LJVC2+7BqU4xlH4mY4YvNORE6JT51Vh+cp?=
 =?us-ascii?Q?rzfaCP/SgtMjyDe3510e4NVRYjXU2lrW9w2FtEdfVF8rGnW4qzQ0R00vkF96?=
 =?us-ascii?Q?IaU2rA1h4WivnD1ka+Qq1sBLv+WWgjQh+PLxuYtw/4PmGYv7+CHcHUUEwAnV?=
 =?us-ascii?Q?zsck1HWt+ggYHVcV+eiSr4dsjPt0wqMO7yRpobHXVZpWG8lbx/yQJkGveRnd?=
 =?us-ascii?Q?wxYPW7N65UZA092n6lFA/HWKhg619l0eIZAoPKEayKJK5rxcMVzbjthWe2KA?=
 =?us-ascii?Q?P55XRZGtlBEjaKN9TXF/zGfEefTJtX3iY0PgluKZtcXwLen7vpa3MrbapdMu?=
 =?us-ascii?Q?S4ZrwBoieq2MDMESMRS6WybZi6MrdHHKArahud7RolsSB1t/S4cOYCdt1X3b?=
 =?us-ascii?Q?OfKTYx5m9G6JxGKChTpaiVSmGuNduU/G+AYb9bLtNS5GNPP9RXQK1Pl/fvTQ?=
 =?us-ascii?Q?hfPO77he0wO5X6lLLyx9h6wUrBrDrf8VM47juEsOkrF5Zu7WKljXDTQq6GbS?=
 =?us-ascii?Q?T+nvFhEYjlZraVoLeAaajnr4tdqYs777Yk5PqXpylRSvZcNANEQ/eqVB23mP?=
 =?us-ascii?Q?3Baj4bZChtz2VebWyR2bsENKSPbnLQukS/FbZ7RiNkRv491qxINrPHPB0WRg?=
 =?us-ascii?Q?WvxLTpB3ik3Tj2NlQJ+51msye2lJT3kf/AVM8SK6WNURlBAY/diCuhBImMUJ?=
 =?us-ascii?Q?hxiZsYY8qjIb+YGHDcO+0++0HypoGuxkbffYYp6YbSGm2jx/E5K4w79vovPb?=
 =?us-ascii?Q?vqnxYaFPhL++A5fQXzBg45QRj9KWZxcl05W68LzFs3OdMR+rUTlnBSYi0oct?=
 =?us-ascii?Q?HqL2l9bdklr2bY0A+uZvVp0dCAU8qWFXX4s8rIa5pP1ZTT3ku1F9Z4RCGj6g?=
 =?us-ascii?Q?G0+rNR3yQp+2OSZWHd3ppZa/hrPLxKNG1/AO1RiQ/L6WUdM+EIm7BbORaN30?=
 =?us-ascii?Q?64r7vUArUkjJ87c0UiSZJluMYuME7hAZkXfyN0Miwl7WgtotGsC+jtC+Kus2?=
 =?us-ascii?Q?oCcatgU778+Mn0y6QLR/kP2jKZXfO/cbSsMt2f+Xz/g+aEMvnxRhL4YJXB84?=
 =?us-ascii?Q?KQXoKNNNAsO0Uw/dvB0UUrHSXFLuwc0EtpBY5pUOQns7OohgYQo0jZVlnHlM?=
 =?us-ascii?Q?6uNCD2KYNYO7QFJk3uuK+0zYp5AjUj/sIqhiZIfl5c7bzN1w4Ed/xnAsWLH3?=
 =?us-ascii?Q?sENdl2IPmoU98EoBd1XoZph8TROAkP8HrWRU2IPK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5826157f-9fde-4ffb-d427-08daa0503964
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 06:19:24.8645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2YDXtOYAG1RrKWkGKjftnOWfgkHwJvkQgJofFT1VVIlQoYCjpbbExSoyHllrRxvboWAZOYq7GT+GA/iUw2VBlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4912
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Dan Williams <dan.j.williams@intel.com> writes:

> Jason Gunthorpe wrote:
>> On Fri, Sep 23, 2022 at 09:29:51AM -0700, Dan Williams wrote:
>> > > > /**
>> > > >  * pgmap_get_folio() - reference a folio in a live @pgmap by @pfn
>> > > >  * @pgmap: live pgmap instance, caller ensures this does not race @pgmap death
>> > > >  * @pfn: page frame number covered by @pgmap
>> > > >  */
>> > > > struct folio *pgmap_get_folio(struct dev_pagemap *pgmap,
>> > > > unsigned long pfn)
>>
>> Maybe should be not be pfn but be 'offset from the first page of the
>> pgmap' ? Then we don't need the xa_load stuff, since it cann't be
>> wrong by definition.
>>
>> > > > {
>> > > >         struct page *page;
>> > > >
>> > > >         VM_WARN_ONCE(pgmap != xa_load(&pgmap_array, PHYS_PFN(phys)));
>> > > >
>> > > >         if (WARN_ONCE(percpu_ref_is_dying(&pgmap->ref)))
>> > > >                 return NULL;
>> > >
>> > > This shouldn't be a WARN?
>> >
>> > It's a bug if someone calls this after killing the pgmap. I.e.  the
>> > expectation is that the caller is synchronzing this. The only reason
>> > this isn't a VM_WARN_ONCE is because the sanity check is cheap, but I do
>> > not expect it to fire on anything but a development kernel.
>>
>> OK, that makes sense
>>
>> But shouldn't this get the pgmap refcount here? The reason we started
>> talking about this was to make all the pgmap logic self contained so
>> that the pgmap doesn't pass its own destroy until all the all the
>> page_free()'s have been done.

That sounds good to me at least. I just noticed we introduced this exact
bug for device private/coherent pages when making their refcounts zero
based. Nothing currently takes pgmap->ref when a private/coherent page
is mapped. Therefore memunmap_pages() will complete and pgmap destroyed
while pgmap pages are still mapped.

So I think we need to call put_dev_pagemap() as part of
free_zone_device_page().

 - Alistair

>> > > > This does not create compound folios, that needs to be coordinated with
>> > > > the caller and likely needs an explicit
>> > >
>> > > Does it? What situations do you think the caller needs to coordinate
>> > > the folio size? Caller should call the function for each logical unit
>> > > of storage it wants to allocate from the pgmap..
>> >
>> > The problem for fsdax is that it needs to gather all the PTEs, hold a
>> > lock to synchronize against events that would shatter a huge page, and
>> > then build up the compound folio metadata before inserting the PMD.
>>
>> Er, at this point we are just talking about acquiring virgin pages
>> nobody else is using, not inserting things. There is no possibility of
>> conurrent shattering because, by definition, nothing else can
>> reference these struct pages at this instant.
>>
>> Also, the caller must already be serializating pgmap_get_folio()
>> against concurrent calls on the same pfn (since it is an error to call
>> pgmap_get_folio() on an non-free pfn)
>>
>> So, I would expect the caller must already have all the necessary
>> locking to accept maximally sized folios.
>>
>> eg if it has some reason to punch a hole in the contiguous range
>> (shatter the folio) it must *already* serialize against
>> pgmap_get_folio(), since something like punching a hole must know with
>> certainty if any struct pages are refcount != 0 or not, and must not
>> race with something trying to set their refcount to 1.
>
> Perhaps, I'll take a look. The scenario I am more concerned about is
> processA sets up a VMA of PAGE_SIZE and races processB to fault in the
> same filesystem block with a VMA of PMD_SIZE. Right now processA gets a
> PTE mapping and processB gets a PMD mapping, but the refcounting is all
> handled in small pages. I need to investigate more what is needed for
> fsdax to support folio_size() > mapping entry size.
