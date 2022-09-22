Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A9F5E56E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 02:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiIVAEq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 20:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiIVAEo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 20:04:44 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06A139BA5;
        Wed, 21 Sep 2022 17:04:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBC2wws2+j7LOsm+zeQFx/cNtTR5Aox6U2rCpqqaq/aW4Ha8P6NyBXaAjhAY0hatoIzA9aHHhkZkymgdVmw5khmpe4fdwA68OUhcxl2B2b445TKp/zPPj+KDCEwyiPSmIZ6fJoPdOfBt7Gbg2ytsshcUjQUbQmfSaVxkC/3hNnjlIChZCEfV4HYTprHCiQTeZBb1MVXHhe6W1ifb8oEMwM7Kl+Azcew57IJontXSMdt13pCorrEAARLuqCwf/hqm8Q23TBYT3K7/sv9vWqJSUCJhb+Ic+P95v/2Bbj8aci14QjBCZCfnYyleny9Q6b/zYBUHk5xzHoW3vLxMzXnPVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14hbZGX5yqD0OZ+VQaymg4C3pW1k6dlxVMu0mx6Rfck=;
 b=UP6sYY76H179l7kVTKHpAGp6QnGSEQawG0DZqI72REGuYyVnfHOJ5a27hlWu+8Vo14cm2HoQChCEWE73IISNUmdI+yEtIwpp1s/ng/cGcoZ1NFg+SZpm8QG8wMqN/IULgMU9VMB/U+j2SNbIeQYJ8ry4PMa9ebeSgiotGdm4K/9pyJ+Qt5J5EYAgEbOIUe+RRj64hsOm3IZsJTWEkEpuzDHn+6oiQQvJ/oRQeM+CMqtNwX8ibdh2hD73TJfGWcorczqqC7imUiiGYdSj/+VeRSl4RiIfqvxUTORGHPkYWNaQhrLyhO9Zmv9FDR+NLr7D+H1eLdxLHzTpF7nhl5Yebw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14hbZGX5yqD0OZ+VQaymg4C3pW1k6dlxVMu0mx6Rfck=;
 b=YZ/wxwjQT1TxvboufcB4vzHmrbs9kQXLZVMaq1jrTvt1wWkzx1+SyeSWUFXb4hEXl+d9uqaENJlDQSaVPIOKsP1RIWTs7tnC7/8Rdd9YpUC00+ZrDcP34FKxSEtLO7fRKX3LB8B+JMMBH/+c4QUuXAyjx8ok6s0gLRAvKn1mR7djkupYCossgsuz8iPOfTrX3kWgrgRxry7ox5P4qhF+P+NoZ0Waz7KIxe6l8NAg/5dqDBtpzvElRAN7mvta427tUAQK18j1+Q80Y4kCXEmta5Ak1SK0JVk1lPh0LuOeRjX2oaWGEv+pfyBrqRQAenxpMTUYwmNOewiFtAAIXrY/5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by PH7PR12MB6860.namprd12.prod.outlook.com (2603:10b6:510:1b6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Thu, 22 Sep
 2022 00:04:40 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5654.018; Thu, 22 Sep 2022
 00:04:40 +0000
Date:   Wed, 21 Sep 2022 21:04:39 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Alistair Popple <apopple@nvidia.com>, akpm@linux-foundation.org,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 16/18] mm/memremap_pages: Support initializing pages
 to a zero reference count
Message-ID: <Yyuml1tSKPmvLS6P@nvidia.com>
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
 <166329940343.2786261.6047770378829215962.stgit@dwillia2-xfh.jf.intel.com>
 <YyssywF6HmZrfqhD@nvidia.com>
 <632ba212e32bb_349629451@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <632ba212e32bb_349629451@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BL1PR13CA0113.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::28) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|PH7PR12MB6860:EE_
X-MS-Office365-Filtering-Correlation-Id: e852bd13-5614-4b3e-9af4-08da9c2e0b8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VLn0kkSMYIqv0GWIne946pkm4ABssQsaAhAX/it7GKqXIyrsHhUAUTAZrjcGOEO+Y52iSrMzm215TR9JyT29A488nQH3s+Xsiq7qGIhn5QuPNjGSiJ1yY65lo13WBf1VFP+88MoEY/kw5eXUW1avwFmQzg5Fdc0ZdMYpECtJjbuZAo4/XPDqg4EGOzCtTqHRqVC6FwhT2TV00KBQlJsaruOBSME6snZ4UmicO37PNnTPez7f1wbqPXiF7s/9EVTdMnRXQgXpahgWUcboQfgVnFh93EkcgMoUCuKARQVdN5dwzcH+Hb/JJlx7ZTuWQfIX72CosbDdlUjeTHjgKSANbRwC7rIBUXQOf4vcGA0WRHwUmB8ecLVIDyPC1tFFnMkJ43Z/snbH/u8RJ/hPd2NqTzRgKDd/r29CEmIfFOaLPbCZ0CAtesT2No5RuvLwJI6p9BigSyPiaglRbrFl7eBJmd+Kzfewo7fwBpYdxxBJCP+GZXA0VdfESRcko80fwFyPZ9d0Xb6q+Qcme8Sd1iKiRhlY8b4TSpS4TABIX0nAwwCB1pNdvGp3HSnDPtUz78SG3FdLZg1QgZ2jasm6A0h1m96OInzY23Z8ZPFGKRK5ZouC6iJFCwBF8WiYg15UUlSGvljz9wdL7VmAJBHspUQwoBnclIJGKX/VpF96W62FMV1OC4uvPQyvriNtWvpvhRyUbbS64Ydh2Jnu4iQ6rQS+OQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(451199015)(6486002)(478600001)(36756003)(8936002)(26005)(86362001)(6916009)(54906003)(316002)(66946007)(8676002)(4326008)(66476007)(66556008)(6512007)(41300700001)(83380400001)(2616005)(2906002)(6506007)(7416002)(186003)(5660300002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c48huTx8runhCy2FduEH7kbz4rIHctAThWDIPBmEHhcSGkl6i5C3x6PFRYo+?=
 =?us-ascii?Q?L9/oAtVYIbg/ewAJkainFiTRNg0H6rAnECxgUr2zrte4px/HucTyK9tLQRJv?=
 =?us-ascii?Q?ZaNwLdUNqdWbWawh7YwU5MxQw/1QflVlGzYvPfSELkLtjakkKth1ig/ZZHgf?=
 =?us-ascii?Q?aXTzyGKcoPYbymZ8wGOHmrRKmWVHhkohWyzpeakFCsydFy0YUPtRJPsA0a1y?=
 =?us-ascii?Q?d9kQBIPz8Qi3Fl04U8aK03RQX6xBXYPD3lIEVU8rGy6GlEnXZByOT8SA0ZyS?=
 =?us-ascii?Q?1QxkQUSMEIqZhLGp933PO8TZrzy3bIkDItck2tn2n2qEeZjAasC7wM1aswU1?=
 =?us-ascii?Q?Pg9yoPr2Lt1Har9prvfCaNI07FwVEDzojeEob1kkivmKWO6z9aP7ISRBd3ah?=
 =?us-ascii?Q?0nD75VAkoCeizmjXwOV8K2ck8Y/lMtOdqakmyD8ncM6u9R9iHPZzRs+5WiyX?=
 =?us-ascii?Q?Yz/7k+6HK+aP3gu/u4shAw7j+z+o619sKjy4ppnar5nb28E1scSRHIhhtRZN?=
 =?us-ascii?Q?Bho9BRIiIqkSuwxz5PNepd1osx8BomYkj/AyRBl4OHXxS05AaajoGlm14+qK?=
 =?us-ascii?Q?78Rfkb1GQF2OR2WfY4uWf1raRP34xdsBwhIUNOncUXlnR8vR1onUxANwNdzn?=
 =?us-ascii?Q?8hlQZzty8PEaoxlVnlwgMub/sjITk5iFLEnPC8utSu/Wh2mJktP8FUy9rcST?=
 =?us-ascii?Q?wKElJ8cGxlgmscOitCHZ+c8hptMEPgatstTL47Cjc0PjKi5YsNt3UJfwTgQ8?=
 =?us-ascii?Q?n1K92r7vlfArgqlBLKd8a5MGQXT03WeGgoBvqA/JOnSkynh2RjxO8BC2KFcV?=
 =?us-ascii?Q?idAI3+cHZZLptKfXZMhA5q1qhScw/2ZQpFDI7ovt9NKbd+aYYGFHSGwbx7JN?=
 =?us-ascii?Q?wsbKOAMgHQhcjxV8V8cKWAuRsKeHHThy0hhQ2eoHFdx5TA5VAEe3UYolkhEm?=
 =?us-ascii?Q?ijkFy3o1T3wlLsld64LuUL1aEQeKShv+jbcS64bAJshbspkxqqUxaM0CeJ8U?=
 =?us-ascii?Q?YHeSmmd+BDaBOhfNTwbzv032s/+AsFkpO1tYbnkrXiASb7j7acpKulBWRbEr?=
 =?us-ascii?Q?W1oMH4lNGfxRMONU36k5gMBod1ATXkuiZTiMVuJB4Ee+mvToFFqWeISikBxy?=
 =?us-ascii?Q?pwcL1lBQZVp3ehcD9jSRvnIh6gV5oUTS8oBX/1aU2u0QEoICjL+G6eMZu06u?=
 =?us-ascii?Q?k6EVOhd3VlXtCnYJ6UA/EE5Iwmz9WNyDG3xlhmH2fJCIOO8p9d0aP0PPufvh?=
 =?us-ascii?Q?Ac4Lk2JsvRa/MaEfCTADHY8QOM18GPtjejuaGJWgUI1AAipApd+OSqEksSPe?=
 =?us-ascii?Q?K6+W8+TXRTIEIsEqclSaU+lz27+A1fL1137OdP2pWAyVSYK1w+kGmLRKbGu8?=
 =?us-ascii?Q?Yz4HM3hdwoNXlVQa7nm7ktwSvPH4N4MeQEa8jAS3Fi9x2N02Py75YOvPcO4t?=
 =?us-ascii?Q?r5kkBzsa84qkBt2t8BDelN9SSNeRwWdLFGV3W9QXP5v4kw/IdAYDGyLulYa+?=
 =?us-ascii?Q?Liw/ubEBcrdMFQmjvvmpEMTXMHaEv0nyjNyVoLWg/nYo/2yuwqRMaAiTDlgX?=
 =?us-ascii?Q?XuPOs48ZhxSMDg2bQUjDjfam/bg3l5/GQrcUsCp0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e852bd13-5614-4b3e-9af4-08da9c2e0b8d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 00:04:40.4010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eHF4A0nJfGdbUw6aAra7KGRI/kWyNdlay9aOthytdzvmAcTE9H12xeNz3PCsUh+3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6860
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 21, 2022 at 04:45:22PM -0700, Dan Williams wrote:
> Jason Gunthorpe wrote:
> > On Thu, Sep 15, 2022 at 08:36:43PM -0700, Dan Williams wrote:
> > > The initial memremap_pages() implementation inherited the
> > > __init_single_page() default of pages starting life with an elevated
> > > reference count. This originally allowed for the page->pgmap pointer to
> > > alias with the storage for page->lru since a page was only allowed to be
> > > on an lru list when its reference count was zero.
> > > 
> > > Since then, 'struct page' definition cleanups have arranged for
> > > dedicated space for the ZONE_DEVICE page metadata, and the
> > > MEMORY_DEVICE_{PRIVATE,COHERENT} work has arranged for the 1 -> 0
> > > page->_refcount transition to route the page to free_zone_device_page()
> > > and not the core-mm page-free. With those cleanups in place and with
> > > filesystem-dax and device-dax now converted to take and drop references
> > > at map and truncate time, it is possible to start MEMORY_DEVICE_FS_DAX
> > > and MEMORY_DEVICE_GENERIC reference counts at 0.
> > > 
> > > MEMORY_DEVICE_{PRIVATE,COHERENT} still expect that their ZONE_DEVICE
> > > pages start life at _refcount 1, so make that the default if
> > > pgmap->init_mode is left at zero.
> > 
> > I'm shocked to read this - how does it make any sense?
> 
> I think what happened is that since memremap_pages() historically
> produced pages with an elevated reference count that GPU drivers skipped
> taking a reference on first allocation and just passed along an elevated
> reference count page to the first user.
> 
> So either we keep that assumption or update all users to be prepared for
> idle pages coming out of memremap_pages().
> 
> This is all in reaction to the "set_page_count(page, 1);" in
> free_zone_device_page(). Which I am happy to get rid of but need from
> help from MEMORY_DEVICE_{PRIVATE,COHERENT} folks to react to
> memremap_pages() starting all pages at reference count 0.

But, but this is all racy, it can't do this:

+	if (pgmap->ops && pgmap->ops->page_free)
+		pgmap->ops->page_free(page);
 
 	/*
+	 * Reset the page count to the @init_mode value to prepare for
+	 * handing out the page again.
 	 */
+	if (pgmap->init_mode == INIT_PAGEMAP_BUSY)
+		set_page_count(page, 1);

after the fact! Something like that hmm_test has already threaded the
"freed" page into the free list via ops->page_free(), it can't have a
0 ref count and be on the free list, even temporarily :(

Maybe it nees to be re-ordered?

> > How on earth can a free'd page have both a 0 and 1 refcount??
> 
> This is residual wonkiness from memremap_pages() handing out pages with
> elevated reference counts at the outset.

I think the answer to my question is the above troubled code where we
still set the page refcount back to 1 even in the page_free path, so
there is some consistency "a freed paged may have a refcount of 1" for
the driver.

So, I guess this patch makes sense but I would put more noise around
INIT_PAGEMAP_BUSY (eg annotate every driver that is using it with the
explicit constant) and alert people that they need to fix their stuff
to get rid of it.

We should definately try to fix hmm_test as well so people have a good
reference code to follow in fixing the other drivers :(

Jason
