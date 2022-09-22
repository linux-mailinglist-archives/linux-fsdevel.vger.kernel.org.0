Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C345E5829
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 03:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbiIVBjv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 21:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiIVBjq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 21:39:46 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2076.outbound.protection.outlook.com [40.107.212.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CDA3686B;
        Wed, 21 Sep 2022 18:39:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxA6erL+9/Oilrz51YZ/Q25sIfZrpaDLEojNdc2Iw4E0I/8dxgA3THVYjC4UUMKl89V4/C3jq1eEhPz1UTRRJLMGsp+E96ktBgFpFM3qyFgv4veWPvh4r4wlqxUKJxQ+ziwW4JrWZ6C/uRg0YrQi1Sa0/HKPIsoEDI4GjnnRcHD2rUqkdR9iJoior1kAiEl9ckFSd+ICG6eaBpwiQhspjJ2WArAxFK+d8f1VbxXFak/bM5ykEpMr4l75Kpn3IzyC6bDqnS5i7v6T5QGGPl8igzsL6O0E+ghO9s0ZSVgWyjdgFhWDmENlbLqbZGQBFhCmVulccUzZDOHFD51jdeLXww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpZnZ4985GrKh8yPa8cOw2Unqe2KOmkyEkOfJxRtBZM=;
 b=bidYneCKbCppW85kx8LgkMSAQeMwxS5cENtncbOhfyX67xOaMnSVv1kQgESTdXpy2+J9eFEpSmzkpGW9uXd0XBi8RyiIm/AG+ZL0tsZO4SIJpw6dAIY8SQgMPnsJhiktqEQ8kAg8w+Da8ik3eyiucSWLx26iUzZUj/eJATi0yRl/ErzsX8zQfQLAD2YRWbVSiOlUYHe0/ugFZWCePVjNwrfC6s7Ti5gVzkOmF8+wB8GnF5XndnyRDpOZjA0Wb8PRB9I3bNPOck++WNGLLsndl/DxnhI5bONzeDzaTrUA7d7f/tdaoAXayfqWnMevIDWYoFUCyVFQBlgJ0koLSm9fjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpZnZ4985GrKh8yPa8cOw2Unqe2KOmkyEkOfJxRtBZM=;
 b=TXfqGSmDJfguQB/+gDRnsOXOqLoDtfzwMnxuyGC/0/HWgOfHC6nUoQeAIhZGi0ulIiFMJpt85VK+WkHtyKLsMT9D2lfb3e68066O58xupVSLlGWU3jGgzK8XJ3Ce2E0RKpx9O6poaSMmK6SXC7UTxFhGRF8QbA2DetU9dJhIvUDO01m2d9IOMQMgsHMpYjzeMvmh3/kdamVphL9Ku1+muZdqjXQ4N2Kuy3U/YZVyaoq+qvaqKvXtpiMl+h9MaWVX/+ullCaxpGUEhSAOti3/cSYfZrwFPrnzgZxCFKEEcnMhtInrn/Po3+JG3pej+R3HAHS7r+Zb6QuEaHKlGlF4zA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DS0PR12MB7679.namprd12.prod.outlook.com (2603:10b6:8:134::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Thu, 22 Sep
 2022 01:39:40 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::cf90:9a08:7869:7f32]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::cf90:9a08:7869:7f32%5]) with mapi id 15.20.5654.016; Thu, 22 Sep 2022
 01:39:40 +0000
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
 <166329940343.2786261.6047770378829215962.stgit@dwillia2-xfh.jf.intel.com>
 <YyssywF6HmZrfqhD@nvidia.com>
 <632ba212e32bb_349629451@dwillia2-xfh.jf.intel.com.notmuch>
 <Yyuml1tSKPmvLS6P@nvidia.com>
 <632bad8e685d5_349629438@dwillia2-xfh.jf.intel.com.notmuch>
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
Subject: Re: [PATCH v2 16/18] mm/memremap_pages: Support initializing pages
 to a zero reference count
Date:   Thu, 22 Sep 2022 11:36:13 +1000
In-reply-to: <632bad8e685d5_349629438@dwillia2-xfh.jf.intel.com.notmuch>
Message-ID: <87v8pgmbl8.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: ME4P282CA0011.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:90::21) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|DS0PR12MB7679:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ae8a69e-66c7-4be8-1f36-08da9c3b50cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cmcxRZ+tsorxnyA+twdJrXiVeqAsO6cCgEunl6a2Mn0KtMT4nUM3EbljqLv/djm4GMWTYy5tRdN6htCTz5HFvone6b2u+EPctFYCwdbDEIVvYeqGAq2YKVLQxWc3QHZ9MYUxvs8IPoFQEKDI26XYCT4LLqUG2OLejzZZBcTh+QirmLhmpq+8KGOzOQpXMlNnc0REOiotFmFYB6egDNbbBrOd9iqRg8LfbeEC/r6CF3E6Kc9UUd2qtcy9IYG4DwQT3yB1RI8j/Cgg15Bj03NnXOskODZQ4zV+vmtYGAG6a8Yk8xsg3BafWLS+VNgkvrQ9LjMr+/3RmNNXFnW43Pi0BPNiNpM1Ba4L7+2SiHY3vdnG3nisHR1OjJ96qdlkXgYntstiMhhpXC78t6Lj2vZuI+id/I49A0kh3/nXqyfoR/QGWxsmmemo1OTt8DpO3/X5z0iIKV+RZGtI/seCbQp3pPxWDnDb3g8I4iZWiWos4N+cF7D4+3Kaqwx4fi6Ufx9aHjwnIEDJvzmPCAGbnD/ryWpgY4wzse1zJDh5M983a17MDxKpBuHMtD+Ns/PKxqvkTOYTWnzBc0e6Izdxy9kV0fjoYgyn7taWXSDZBrUPRfXyzQzaAZrET7eLglDi48fb+DFz6pyQJyxXAEwMMNGJMCHXTHhGycAB9rE45plu7yK3ft7uf2NNOD/T1lhR6OwOfa+gxbxnTaiJyTNKOsthww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199015)(2906002)(5660300002)(66476007)(66556008)(66946007)(8936002)(8676002)(4326008)(6486002)(38100700002)(41300700001)(6666004)(86362001)(6506007)(26005)(9686003)(6512007)(6916009)(54906003)(478600001)(7416002)(316002)(186003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J45oT94GUWcgKWyB5h5VHo01SeIRvAa2CNdAzNEaa5ZWLHVH6NFLAotfgAR3?=
 =?us-ascii?Q?BTEs6XtC/mOaChrYZYkPmtAsZTfFjMUh9drbcmlLlCw7XGy7lftsbFrlDgst?=
 =?us-ascii?Q?yWOSHZCne11bIH6GHcW8QX2b+yXsGJDYKLLcYqbMkVUsb4kYPkMPpKZO2h1Z?=
 =?us-ascii?Q?wAu0Gg0+n4fITwnhLioDJHAZIrnueprzxF1jgVLdHT+cTi2QWaBNTeT8P4cs?=
 =?us-ascii?Q?5Kd89Jee6Jzd1i41fTorcK7rAtvdSgkfFCtbufeSGmllr4Jaz18ZMZhsuECc?=
 =?us-ascii?Q?1h/txBBhEQVi8uqQ/3n1auPBxqujDDBMU+8E2D9GCWvjlZ+othJY4yZqYgtI?=
 =?us-ascii?Q?5nQzy0HclG97BtQTlQXR+kUrpS2JfPX7x8hdb/JqjoujSsoAI2zpobJc+oXX?=
 =?us-ascii?Q?VIRiLpXm+Pl/pWoWBxp8ASmd9FOG4uNEnPHSW3zkcQjKoYFXJ/jXJF7I+kAi?=
 =?us-ascii?Q?+S9dqcV0AMM2jZxut36Odzgoxj5kBgrDEjsI0je3YPtp6+ZkKTI6PjO2t1gw?=
 =?us-ascii?Q?lyCbrnkUCCm9JM3D3PBW/3gSMTBCeIlldCjQOmPDYf4y2Yb+LCLumpMvx7Zw?=
 =?us-ascii?Q?CSoj59cDb1tyNdnhpkwHILfgfQXDtiW2n+Sqmmf/EkJIJszYlJlryTgz+v5k?=
 =?us-ascii?Q?jxTHEg+U1C/tL3z6/FIC61X7kTWyiRx92Pm1BeYVBvumYehofLyMTugRXMOx?=
 =?us-ascii?Q?/hgH4t+SUw45vLUhTVGOt3vBXfmHNO3ZoCnVM39HweXi0PnxPf1HcPguyPC0?=
 =?us-ascii?Q?+jMqL0pdv8uc36QCOQJVUo2siWKNKXQt1VAUxThZEhn5MG429wgFYPcybZP/?=
 =?us-ascii?Q?/U1atjvZzJmrOlu1Zt1Ho8qP6wCOx/AYCQZn0K8eElvsVXj5/NJRRw3zBptV?=
 =?us-ascii?Q?rnVAeFNHsA28qPysXmKa2oV0PsirqeBbaPPnQM7sCUfq7uP8ZXf15FQDNP+b?=
 =?us-ascii?Q?5uzqc6vEytU9ZA6QR0Ry+osxtidI6Whg5bo+Tc45+KdNnjPN6unlIR85JbVg?=
 =?us-ascii?Q?Vzk8bya9zNFkusLrMWKae6phOIU2xX7vqebmwwQZY98wy1eq5UWKRaX/bWB5?=
 =?us-ascii?Q?HzEw5uZQh20LEVMt8C68KHnHqkb088bTnymn2Kta3qOdl87vg9Uf1rGaPldt?=
 =?us-ascii?Q?eoCFjsTTAcVMLDn53gjlfVGcFkUaJFjM4CIjemQG2DkSrmJSxWFh2vpuo4AR?=
 =?us-ascii?Q?jynXcPmiUdRO95m6yhPoYPpkK3SgWOQZAh4uvwQajrOWt3SI3BANK4kH6Qou?=
 =?us-ascii?Q?mCI/5HR7vbF9SqzpHwHsOMb+m2s04O7wyfqxvUikUfH0oDF/MWhXy+1fB7w1?=
 =?us-ascii?Q?4TVNArDD6YcP4XqUnmflbryIr8oI3zauQy7a2oYf4qoM6NLLSPO6liFYGhCW?=
 =?us-ascii?Q?qsX8mNVi5lSkS/HTewDRGz355+/zcyh278jWVuVWmUkYm6DeZGUcBbPd4UJR?=
 =?us-ascii?Q?S/S1k30by5tEuUznAAoVBQGET87EB5WAIZjcjLEIW/eExpF0w6lxdo0RLgln?=
 =?us-ascii?Q?V0UKXNx2nQkxv4L6tvviBuNi+28XT+W7LCkQYDflLsXTbD84CPbCDoitpvQ+?=
 =?us-ascii?Q?tRoh4x5d//nIBQ2e8Ym6IIDL+o92bqQwDtT6rj+O?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae8a69e-66c7-4be8-1f36-08da9c3b50cf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 01:39:40.1601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hRuc4EjglqyJFqxZrxkWGFCSHTenV2eoW/jaLWQD/SV5cTcU7qY/gg7/E3qqV8YwLON7GNyjJQDqVwAGPsKEgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7679
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
>> On Wed, Sep 21, 2022 at 04:45:22PM -0700, Dan Williams wrote:
>> > Jason Gunthorpe wrote:
>> > > On Thu, Sep 15, 2022 at 08:36:43PM -0700, Dan Williams wrote:
>> > > > The initial memremap_pages() implementation inherited the
>> > > > __init_single_page() default of pages starting life with an elevated
>> > > > reference count. This originally allowed for the page->pgmap pointer to
>> > > > alias with the storage for page->lru since a page was only allowed to be
>> > > > on an lru list when its reference count was zero.
>> > > >
>> > > > Since then, 'struct page' definition cleanups have arranged for
>> > > > dedicated space for the ZONE_DEVICE page metadata, and the
>> > > > MEMORY_DEVICE_{PRIVATE,COHERENT} work has arranged for the 1 -> 0
>> > > > page->_refcount transition to route the page to free_zone_device_page()
>> > > > and not the core-mm page-free. With those cleanups in place and with
>> > > > filesystem-dax and device-dax now converted to take and drop references
>> > > > at map and truncate time, it is possible to start MEMORY_DEVICE_FS_DAX
>> > > > and MEMORY_DEVICE_GENERIC reference counts at 0.
>> > > >
>> > > > MEMORY_DEVICE_{PRIVATE,COHERENT} still expect that their ZONE_DEVICE
>> > > > pages start life at _refcount 1, so make that the default if
>> > > > pgmap->init_mode is left at zero.
>> > >
>> > > I'm shocked to read this - how does it make any sense?
>> >
>> > I think what happened is that since memremap_pages() historically
>> > produced pages with an elevated reference count that GPU drivers skipped
>> > taking a reference on first allocation and just passed along an elevated
>> > reference count page to the first user.
>> >
>> > So either we keep that assumption or update all users to be prepared for
>> > idle pages coming out of memremap_pages().
>> >
>> > This is all in reaction to the "set_page_count(page, 1);" in
>> > free_zone_device_page(). Which I am happy to get rid of but need from
>> > help from MEMORY_DEVICE_{PRIVATE,COHERENT} folks to react to
>> > memremap_pages() starting all pages at reference count 0.
>>
>> But, but this is all racy, it can't do this:
>>
>> +	if (pgmap->ops && pgmap->ops->page_free)
>> +		pgmap->ops->page_free(page);
>>
>>  	/*
>> +	 * Reset the page count to the @init_mode value to prepare for
>> +	 * handing out the page again.
>>  	 */
>> +	if (pgmap->init_mode == INIT_PAGEMAP_BUSY)
>> +		set_page_count(page, 1);
>>
>> after the fact! Something like that hmm_test has already threaded the
>> "freed" page into the free list via ops->page_free(), it can't have a
>> 0 ref count and be on the free list, even temporarily :(
>>
>> Maybe it nees to be re-ordered?
>>
>> > > How on earth can a free'd page have both a 0 and 1 refcount??
>> >
>> > This is residual wonkiness from memremap_pages() handing out pages with
>> > elevated reference counts at the outset.
>>
>> I think the answer to my question is the above troubled code where we
>> still set the page refcount back to 1 even in the page_free path, so
>> there is some consistency "a freed paged may have a refcount of 1" for
>> the driver.
>>
>> So, I guess this patch makes sense but I would put more noise around
>> INIT_PAGEMAP_BUSY (eg annotate every driver that is using it with the
>> explicit constant) and alert people that they need to fix their stuff
>> to get rid of it.
>
> Sounds reasonable.
>
>> We should definately try to fix hmm_test as well so people have a good
>> reference code to follow in fixing the other drivers :(
>
> Oh, that's a good idea. I can probably fix that up and leave it to the
> GPU driver folks to catch up with that example so we can kill off
> INIT_PAGEMAP_BUSY.

I'm hoping to send my series that fixes up all drivers using device
coherent/private later this week or early next. So you could also just
wait for that and remove INIT_PAGEMAP_BUSY entirely.

 - Alistair
