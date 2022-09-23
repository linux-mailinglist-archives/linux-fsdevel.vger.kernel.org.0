Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7145E8280
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 21:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbiIWTXe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 15:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbiIWTXc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 15:23:32 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41BF12CCAC;
        Fri, 23 Sep 2022 12:23:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gH39KCFqPHQGyx+47OJ28XvIj7B9kqvG/MgEo0fBkYSURfQDxSpVGYRhAVEApBggZZodet0nv9g/0a4s9B2GhZC36tYrsTBiOt1LJeZZOFj252gkE9CUXBi5aR+5ipeAK9IRwS1TRvlaFt/XhUzRM5J3PSNgGLUvCgeksddJwssjVBPMULmglZTM/UwMdhLM4h683GbpLwWDTJSYVxL5nYFjmptkan3eVKxk9EX+GE2lZFMH4KPwiMHnhYZkyUAFWNm3FoM+9IGA/pr8wuZmit0Ff9AmEvePiXQgoLk4CW9F2vtK+0xcTZ9U6jKu50+UePjFBEg7kSH612dWOrGSzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVK/Z5zRuhte9hNy+yqLj5FhGmtu3n4t2TwOt95DtTY=;
 b=EyVC2UG+BWjx60eIRV75NavEEm4OiW4AoDQ6S8VaU2JK32XeDm+1tYI4cJVXigFHDcUqUwfRVS18Gwc6ErY4UIHgVbDHBzyK5cG/1CJf/mJ/sxJPPYiLl1rMESWFvDR+xjlnXoIqHBN9ymiatB0kfDdHo20BQAgXBr115TG77ugGLLh+1b2l3O3r8sB4kZC7aGqfWtQZldkIufipPSIozDlIyHW3oS5T/bxnFX4qYAijsIgpvaM+DNS+YD56WtVQJCa4+QcRcjdp5DT+/qSlyaUKORt9QKkz6wcrk3yxMs6HVElHQ8n6EDKGXGlHcsAR3ce/SZmxm9oWI65ssUwsCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVK/Z5zRuhte9hNy+yqLj5FhGmtu3n4t2TwOt95DtTY=;
 b=RopMQvwM8H9t/8QexA9+QPnA1AEnudFMwmL1PBYQ+CiZOV2DIiyzuTfrIPHa4PgGJiLMWNkRjJI67c91521ZqRgiTwdzMLxQh0pYIPF6iZvqBrBzvRf2pK6+tuLv79egP4AoT0TpZSaVsTleY3E8AC+Lxc+lQ4Wf4TvmrBo60BjFADymT6Qzzm+xKbUlVweLPIWVkXJdzRWlt4sYN71MqP6RsM3l0Zek6FmjFjankt322TbzvcGZv2sF0NAfTpc5O+qZSeAeFyReCBpdTJ5YzPiXgiOqmA413jUVs6sIxc8l2eja/iQNmMyiOAxqveqDeM2Kq0Y8sLu61hyts9T6lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by PH8PR12MB7446.namprd12.prod.outlook.com (2603:10b6:510:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Fri, 23 Sep
 2022 19:23:28 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 19:23:27 +0000
Date:   Fri, 23 Sep 2022 16:23:26 -0300
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
Message-ID: <Yy4Hrve6Ncg6YsGd@nvidia.com>
References: <YyuLLsindwo0prz4@nvidia.com>
 <632ba8eaa5aea_349629422@dwillia2-xfh.jf.intel.com.notmuch>
 <YyurdXnW7SyEndHV@nvidia.com>
 <632bc5c4363e9_349629486@dwillia2-xfh.jf.intel.com.notmuch>
 <YyyhrTxFJZlMGYY6@nvidia.com>
 <632cd9a2a023_3496294da@dwillia2-xfh.jf.intel.com.notmuch>
 <Yy2ziac3GdHrpxuh@nvidia.com>
 <632ddeffd86ff_33d629490@dwillia2-xfh.jf.intel.com.notmuch>
 <Yy3wA7/bkza7NO1J@nvidia.com>
 <632e031958740_33d629428@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <632e031958740_33d629428@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BLAPR03CA0082.namprd03.prod.outlook.com
 (2603:10b6:208:329::27) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|PH8PR12MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: 7892aff8-f4f8-494f-6ede-08da9d991796
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PR0tPDsJWqS/oNPRF8nR7KfY8KV87gWRKEpNZjgrVU71o3o0zKiVBQ2y+WsMq+7QadazgoAg2ItmG4jF1oNIb4ArebxiSTgSJOFEmk4k6g1Yub0sY2kr+MhSS2NZjRpRitLWFYswoQZ+S5QzM1WQUU7HrSqP+W1fGse+h+IGUIO45WAR1tM4Xa0QkYxsMtku+OM1tYxFqr4vBWBRKqjM5V2IF7+W81uRvcST79SZu5U70L6CojB/KlfJjoJk9d9IYooBfiYN1H9o/TukC6eOxDsvN2uQ8QIXsJ3D2ou+MIHEbGSucba5qncHzBADPX9B62sZQshXEeQbRl0ZNUnVfqAOMcCkd8rmxmXanaLV2LaLJr/QQBoL1Z2jwYAz8w5AoGOXmiIPUrB8ruGVD6qoxzSLu9iYmozio9oyYm0DBxfbXZeFe6afZ1YqhT4i/Rji3dga+zo1UwneXxNkbMoaoCbF47MEo06VJXsDOXKyYl/heM9vPIyagSoZ5r6Cd949Nl/kKEmA09F0RlYTzvyP9xX6SD94a61woRBkAHuE/FvxfY+9RGY0kYwdyGJ5BznBrkrCxWA5H2lGityP5LhrRgUhpKJfewn5Nma/aUK6GXYUOVIDAEf72faGF2TGA5/iVi7sH9/Ym7qnXhYFXFWfgxF+rar36sCevrSMnrSV3mNXnjlf4PhD883Kdu3bsx8QmUUvbKYAQ5LLRO3nIa2EYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199015)(316002)(186003)(6486002)(6916009)(54906003)(8936002)(6506007)(36756003)(5660300002)(7416002)(2906002)(86362001)(8676002)(41300700001)(478600001)(6512007)(38100700002)(2616005)(4326008)(26005)(66556008)(66946007)(83380400001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/z1snNPhOxxWHM9vbrZ7NcbtSWs7AJi7rv8E6mulvsvG/lFPTD7lQnertqSl?=
 =?us-ascii?Q?rmUg+Wu+yTgbnPhojSaFN3xoHWhyhglXG++ajDZz2t+/CB3Qw7gH+OVTIQ1v?=
 =?us-ascii?Q?RUTRzocwJwh8bJQ9cxuFiyPuOnp7oQ5HuIrnN4O45XLwlIToahURE6zjqO/f?=
 =?us-ascii?Q?/jTFOY2+zNZboQBIvzI6faGAyuRrBauW+hA5o0yc308eoXQrrR6qqrNwCWBV?=
 =?us-ascii?Q?Trgw4ZBIamIqvYKp/RAa8cWyf7OXn3WMjDN7kMou5RazDxX7fTrdthnWEeA7?=
 =?us-ascii?Q?AoPo3E1Omho9yQhQzs0za5CO1RzfMcekvumbPqBO9d2opOJU7aLoC5I6nPwa?=
 =?us-ascii?Q?h65moacerFz+cUsqBdeYZSpQd8aUVqkQh0gG07vPm6aCuehrG0lYyIS5ITsl?=
 =?us-ascii?Q?TXfigCZtVkQPbCh80ztPC7aEa5I3j2tzJQzyM7ll20z6upR25MCrML4kb/Tv?=
 =?us-ascii?Q?kXMiyp8A+oQ/fRwic1Hfx/A5uGPqmCVDdJ9EaddDonnxxLTSfWv1sIUF3/MH?=
 =?us-ascii?Q?d5FXexSMwhwPexyTlhj+l4eza2u4+xmKRo2O5mEjKD25EdtH/uqQg/tLT6oH?=
 =?us-ascii?Q?qr/7894OkxZvSTTNob3q3v0gqX2+GVvw5aVLhavQmVavhYmQoRYO4I3Y0yke?=
 =?us-ascii?Q?cwoNkg6O1+YUw8uR8w6WmQURAnIZ9uzzfkuVm8txGBHWgTPaUsgMFcLfpQNS?=
 =?us-ascii?Q?581kO8bIeZErbCZpSsmRD1YlAzgSmCuHb+YlngcWkVaLs4wS/A/1a7BsClYD?=
 =?us-ascii?Q?bV4Pw5+q5H+TuvvFd4NR7eeBQRwn9svRQb2lUra/SwhF2/uh/1xlBYn9Jtg/?=
 =?us-ascii?Q?aAETtyV3THZ856vWlS8+mCtZYfg7bNgeQsgpzEFh84cBZVVzUHg1fsk7q/nU?=
 =?us-ascii?Q?WfOf/XxdB8+TiiapK/fWSFJG2kDUrQZZPpugkUyWsu/QgN5DfMNpuDlFogBm?=
 =?us-ascii?Q?yRFdMXaLu6vcbIWG6Mdq59fiCnRK5XjByVMdF4zWo/ZbgCDlSE7q6pUNKNcF?=
 =?us-ascii?Q?ZNnEEVTF1cg2zch/pZ6Gdqjarhd9CqMD1IlJmPVSC1vZet2I8lCtkUwKZ2yR?=
 =?us-ascii?Q?hEJZGjH2o4GpCcY1rWVmhoZkI5V+bsLqLnKZSVteOsmERdDX6XoVBb7c+iWf?=
 =?us-ascii?Q?D6j0gydHyzpaI0IVKSkUuXofoJTDLUjYMFbQqKvXYts7SbOrQbdUAdCOdiZA?=
 =?us-ascii?Q?zxm520us0PJyB0NVHfNqI5oRtxT1ECVR5TEiA5quivAMYTUX9UsLJLBnE/6C?=
 =?us-ascii?Q?JHwFKg+urysSEtUQBUa4Rcja4QoZ57et4vRSCV9yAw/PEm7s2r9w3vHxSGnk?=
 =?us-ascii?Q?ukG5Hug9U22R2PyuFByBHseeASSdw+erDlaWPrK8QWW/3XQRe4jmDGombTK8?=
 =?us-ascii?Q?fLM9XCo1mXKEvuLZHXaZhjBsnCvK2uEguZJ2vYBLrANfW7jcZx61hrTrSkOT?=
 =?us-ascii?Q?P9uWqbFYNc8KyZg/5I5F7TkiV9MtTNdkHdAQR+gGIAh1Gzg+2QAl/Mt89HQ0?=
 =?us-ascii?Q?KKRuOfIcvoyHk+Lehuuf4ezX4zfIUvid/4+MIMBQ1BbxsXe2wpk6gXVlfSP7?=
 =?us-ascii?Q?2G7quzXGiwtERB5K5ftRKZgHdoQjfOSCkVET+qN8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7892aff8-f4f8-494f-6ede-08da9d991796
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 19:23:27.9356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nyVn+69DxCacTCH2F8ofuHhcDHyaQlflJ/a+g9qNpg2K//tbVci2xdWTjMiLRlP7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7446
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 23, 2022 at 12:03:53PM -0700, Dan Williams wrote:

> Perhaps, I'll take a look. The scenario I am more concerned about is
> processA sets up a VMA of PAGE_SIZE and races processB to fault in the
> same filesystem block with a VMA of PMD_SIZE. Right now processA gets a
> PTE mapping and processB gets a PMD mapping, but the refcounting is all
> handled in small pages. I need to investigate more what is needed for
> fsdax to support folio_size() > mapping entry size.

This is fine actually.

The PMD/PTE can hold a tail page. So the page cache will hold a PMD
sized folio, procesA will have a PTE pointing to a tail page and
processB will have a PMD pointing at the head page.

For the immediate instant you can keep accounting for each tail page
as you do now, just with folio wrappers. Once you have proper folios
you shift the accounting responsibility to the core code and the core
will faster with one ref per PMD/PTE.

The trick with folios is probably going to be breaking up a folio. THP
has some nasty stuff for that, but I think a FS would be better to
just revoke the entire folio, bring the refcount to 0, change the
underling physical mapping, and then fault will naturally restore a
properly sized folio to accomodate the new physical layout.

ie you never break up a folio once it is created from the pgmap.

What you want is to have largest possibile folios because it optimizes
all the handling logic.

.. and then you are well positioned to do some kind of trick where the
FS asserts at mount time that it never needs a folio less than order X
and you can then trigger the devdax optimization of folding struct
page memory and significantly reducing the wastage for struct page..

Jason

