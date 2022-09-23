Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1225E7BB7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 15:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiIWNYb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 09:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiIWNYa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 09:24:30 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F50329;
        Fri, 23 Sep 2022 06:24:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGUuD1OS351fuB88mtAO3Y6uKnQUP1UlDrcDIBRbXtv3ghRmzSXZ3RxsGjHMx5TyzNVMNw7+O3RSDDcgrDPxsW9AAQIorY2VWFCNZiAjrkqnRrJmM9C9Pwo/KGf+2DtXe0EVOyJeMT7YKkIrdrCiZFPOjNV72E0t76nrPO86fpXIWr5j272ceoG916wJS9Y0iawgSONKk5iu0A5Ip1p8BguCUVlhuUoSsrjZPFOc9+lAKeAEqh/0QGATaB5jDkZwaZY/hU1x7x9J11oDvonSYfnSH5nhmfpO/xWUnmAOKdjcPdNY1uahX+/ZSmVGQvN1cgr0+b6dHrZIwbN8sWwXPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EShBqpI2YdlANh5XK1hSnmZ/ydYuzS5t+MNpyzRoEW0=;
 b=Kps9DTnm6gQqgHwtxlkumA3xH8Meh0aUzhoEuLoauKmvo6j8APWSK1JK+Wz49KRxScv1i9m1n8uWd/0rfMZYNeEHPGqJaTau9kevmTqJRGNVuKJx0g18xNQ4msph52xQj8AQUv0qapWIEZKy91a+Tr2xjrDbKSmgx4yKuzkZy1QabAsvC6FAal1Xl4szRCGpCBkLyTI0EDi4oqLseqi67ARN//Rth/BRqJbUJGSsnX56YFGEkmnpJMP/RW3MnNsMl8yAiMyPGPOr1sF3ZxB4uECWezs+cvGRzp+s/9ar4rxCszCUKzBIm/Oy9y7yvn62PdUz+jzZLQUo/ose09msBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EShBqpI2YdlANh5XK1hSnmZ/ydYuzS5t+MNpyzRoEW0=;
 b=hAyXZQe/WRbn+Pym1xmG2fz7FwX0kWhMiVbv1dNwNOrVbnJrfEGR76eU+A3GjaiaMeQ0IIp8Ors9amMTQW2GHcSeSzJlamp3ezM1P/VfAujj2lNr16xmpjn8AV6HlOKBGUbKfOxcYTNU8upyXvTAG7v2kC12h76+stIxeoPKkIpTXHf4I1xqMu6K3yAUnuX7wDNDrw2fu9hrhlTrc4eJ2618qX+6YwF4QD+wFH82tvOVivW994zUzbAu5tVWC+jadhDwa9jGvNKBcYbAEJe99JsztOTDcRBUqAKe2fM5C1XPSzsyzDuS651rQdHExeyZrbl4HbP1omUrt92IXlLeiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by PH7PR12MB6667.namprd12.prod.outlook.com (2603:10b6:510:1a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 13:24:26 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 13:24:26 +0000
Date:   Fri, 23 Sep 2022 10:24:25 -0300
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
Message-ID: <Yy2ziac3GdHrpxuh@nvidia.com>
References: <166329936739.2786261.14035402420254589047.stgit@dwillia2-xfh.jf.intel.com>
 <YysZrdF/BSQhjWZs@nvidia.com>
 <632b2b4edd803_66d1a2941a@dwillia2-xfh.jf.intel.com.notmuch>
 <632b8470d34a6_34962946d@dwillia2-xfh.jf.intel.com.notmuch>
 <YyuLLsindwo0prz4@nvidia.com>
 <632ba8eaa5aea_349629422@dwillia2-xfh.jf.intel.com.notmuch>
 <YyurdXnW7SyEndHV@nvidia.com>
 <632bc5c4363e9_349629486@dwillia2-xfh.jf.intel.com.notmuch>
 <YyyhrTxFJZlMGYY6@nvidia.com>
 <632cd9a2a023_3496294da@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <632cd9a2a023_3496294da@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BL1PR13CA0071.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::16) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|PH7PR12MB6667:EE_
X-MS-Office365-Filtering-Correlation-Id: c6153370-15cc-4534-af34-08da9d66efdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VvHBXVHy4FSBl66nUNMTF/ZKOzPs1bR1jlSzgMJi5aMFSBk2hL7uwfZOkAAUo8epwTex9OzMhWlzKhEpkbnraZgP+KAXXzz/jsr+t8L1l0t/h3xWGRG8F6U2Rv33csag/YUDC49h2K9aAvVHpbe/1Agugu9afIMvM2wQsTEq8QTuWd5G6eyE3B8GJl34FQEByRoj7MmDyxTkvbck/5Ax5C8JQhgpE+6h3ofV+NAd1+LGd/emwVYGkXM3WF65tU9NuXlZECR3Eze50Cjlmk2T7vFlnNdXmXW2CvmKHBHr0gA4KHKMXASLEcM+WT7QmHDQ1fHaq5n5HgbYiIeVzdfon4bv6x1i1x7kocfzLvFjnYWXswQg6tJpSAFrCMN65pLfmXwRc50ZShHJZSCUmGTslbuem+zwQyCAfS4sxottHo6LFLveO2KKWbbIRdrT/lj/n4zc8+BBGGrH909g4mbi4ZqvxWNXKW8BZb7WIy7Y1DyIxASfstMGllVDyqbvJjNnhEyctBlUys9pvKnSDwGABSeIqsvduBIWVAMyIHqncU8TXcyWO9tIpaVBlGkJl56Sth+dnlCBLt874YYYIG2PyMJ+f8A1rUsFGqBhH2WbYC6TEnUzRESIGN5RSQ/TUGOXZDWTdjQ4o2rjy6dJSNSxNv++V/LXJMx3AF5znuBfXUvKm6k6vXgID6woo06Bk+Xf8pgzShruBz7jybizp0xR9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199015)(7416002)(6486002)(6916009)(36756003)(478600001)(316002)(41300700001)(86362001)(4326008)(6512007)(6506007)(8676002)(66946007)(66556008)(66476007)(54906003)(26005)(8936002)(38100700002)(5660300002)(186003)(2616005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p6wkU1h0Yq9zlwNG5SIKvc06tIKN/Ghx9BKpwcUGiVGIdTirEvO23U/qVmer?=
 =?us-ascii?Q?qrI02UpYEW7WLq5/qlqSY4gy9roMyLG65SJsn5umviMCiEM/eIH2vuqJNlsC?=
 =?us-ascii?Q?q16BOIro1D4DKl6rVxLH9cvSYhA7gdw9O9IFkw01dF5HtKJiy+vzM7kh4zgh?=
 =?us-ascii?Q?RGn8zZR+bLySc/pa+/lPaRY1NYP7ziZjSjN7TU63DHJzwadKfFZ48MUWX9Qv?=
 =?us-ascii?Q?8RqJkmt2JTQrWBgQM+9maTiqkz/c23bfblj3828OZ1ttA9uvpe9cKqQeSzBb?=
 =?us-ascii?Q?V2YpspzEDpV0hs9+A1rlIonX5M4jr4zTRkLvGLfnPlzogh1+lUj10cz5ri8Z?=
 =?us-ascii?Q?zLwWrhO4OPQ8yt/FTb4GXrC61ex4rIGei8pxUrDHhzzleE/OpMt2zCJXdt3x?=
 =?us-ascii?Q?2tmCMA49p8Qvqg/b+wu9NKmUKWsJYZIW751t8v0aXxzXi6Bby5+IRCjGfjCz?=
 =?us-ascii?Q?YdyycV/X5/Gt3nN3sbwZLa3LDwF/dL1VR5SByI3FRvAX+s08/sWggmChFBRT?=
 =?us-ascii?Q?UWffrbLSBEX/vrwU+S9zuUc4q78QTtCC1/MM6hFGHTORSCbqP+2RCn4CUOk7?=
 =?us-ascii?Q?ArBMUL3eD6SR9hDGhDoLrtDoYme7RJMGWNqPsRFfPj6pdMqjxFS1XYEdwGpR?=
 =?us-ascii?Q?fbO4MMU1bfptoCwHB3HgERsc9HwSkdCynYIFn8liVxNAO5U4NayBJetTXNt/?=
 =?us-ascii?Q?ehVaCO3ZOgVUJQRFQ7Bz7FBqKZLEpvUlSQriNBdw+w0Wfm8a1ZdmjAbwJUp7?=
 =?us-ascii?Q?5KPRexWS9yHuzizllM5yr3DUTaSB4BZltjmYzq+/e3Gwi4r7LA5PnEFWzv+1?=
 =?us-ascii?Q?o6Se1zLtnwkFxeVH6+0GOLcmkb2COFnccbMZGZGAJDVsjaTMY2NWl/hOad5L?=
 =?us-ascii?Q?/ibwzdlXKGgdfixTGpINSuSoSE32BNQVPE3GhGw6CVbsELkdz1R82l42oxdm?=
 =?us-ascii?Q?U/k6QfQkSP94WkIzKMbC5qAH0VRHN0i+qRZS2CoBp79V4O8dXXV+4RMsZkkk?=
 =?us-ascii?Q?XpdD1QKse3xyBzFD9R5tw8CK7VJmYYnHqs+yeVD5hzNUfB575BsGBNl9eoV9?=
 =?us-ascii?Q?cPufslsf8deiOiWsn1a/EeNkKXitHsCeysrQZzIDb1rP+hr3Qr8voT+H4NGd?=
 =?us-ascii?Q?018cOYuLLDI2oeaV/Fxs9S60vn30uFXkKdVL7kGJTHm3P/wWDjmMH6k9rTw0?=
 =?us-ascii?Q?0KTxR+V8bJP4A50TQcAmT5edPfJmgdyviSjYD+54nFpeHXBoMcjYDYIsRiq+?=
 =?us-ascii?Q?TWA7zvs46x860uhZT5KRo0v/o5MAfpGBuDz5w02RJVT6IvTZy4XhxRUbL2Hm?=
 =?us-ascii?Q?6xwjd9Ek+0jVrdmXd1zOxFk0SHiGiHpMCGPRvyJYIwfeWL54T+tURJexWoWd?=
 =?us-ascii?Q?CVRhRQ3HGKJTMJuCfH7a7vlhb6YeFpbW9XqRYuJSA3DHmAxG4MdX0VLLjtWh?=
 =?us-ascii?Q?eoWLQn+jHH0vHqTvSzQrfTE1MSseT1YrR7RMyobQC2gOR0OBkbWqEmWp3D7g?=
 =?us-ascii?Q?ufYFURuo9WgBUObKuUX/Win9s3yHE5IVwpYqy4Rw+2QGqgPbBnz2Yfdsehwb?=
 =?us-ascii?Q?Lh1IzJD8A6Dct4sqbAi7Egz4wsnTk1C3JM9rkmBn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6153370-15cc-4534-af34-08da9d66efdc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 13:24:26.4351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W7Eykn7iJCMsvL6nrMpWD5d6hV7+6f3ZltCDSwk0L90j8wnIlznDXRVvKSHVE0Dv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6667
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 22, 2022 at 02:54:42PM -0700, Dan Williams wrote:

> > I'm thinking broadly about how to make pgmap usable to all the other
> > drivers in a safe and robust way that makes some kind of logical sense.
> 
> I think the API should be pgmap_folio_get() because, at least for DAX,
> the memory is already allocated. 

I would pick a name that has some logical connection to
ops->page_free()

This function is starting a pairing where once it completes page_free
will eventually be called.

> /**
>  * pgmap_get_folio() - reference a folio in a live @pgmap by @pfn
>  * @pgmap: live pgmap instance, caller ensures this does not race @pgmap death
>  * @pfn: page frame number covered by @pgmap
>  */
> struct folio *pgmap_get_folio(struct dev_pagemap *pgmap, unsigned long pfn)
> {
>         struct page *page;
>         
>         VM_WARN_ONCE(pgmap != xa_load(&pgmap_array, PHYS_PFN(phys)));
>
>         if (WARN_ONCE(percpu_ref_is_dying(&pgmap->ref)))
>                 return NULL;

This shouldn't be a WARN?

>         page = pfn_to_page(pfn);
>         return page_folio(page);
> }

Yeah, makes sense to me, but I would do a len as well to amortize the
cost of all these checks..

> This does not create compound folios, that needs to be coordinated with
> the caller and likely needs an explicit

Does it? What situations do you think the caller needs to coordinate
the folio size? Caller should call the function for each logical unit
of storage it wants to allocate from the pgmap..

Jason
