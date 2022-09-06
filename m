Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDDB5AE73B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 14:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238818AbiIFMHt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 08:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239058AbiIFMHe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 08:07:34 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA97796B0
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Sep 2022 05:07:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J15WbXJQbCBmyjXUioXlzTt/b+71Imh/jfgG93Ke4qDW1hwRZWq65n3egZvqDnVDzWe2mgRHZtN2Xk10+++mfmQ9ESVLmpjC0/1Hpxoz9KGfzy9R/u88KiSbaJHnOMXd3ZSTBX3gOttoqO6s1asDKZIvwSJJHn4Bfo2EWOZ99wdilJpD1Ye77Jyrq/pJr47ijeFJlqjDuY8tmnvPG68hBqHebUGWZT8EWEJWpE5Q4E0YfU66e0Oi5X3E1dETQ2gwvBtjfzYqjObOLH62QhYa4YkHgp/Si97T6wuP5mqKZnOKigiavw22RlOleUQKy2Mc3WBNNgvxTZF6L0JFlZmz2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtjthwCRVK2QXGOiEFatajyV7XtFjiTbDAgQPkxXjBI=;
 b=nyjvreEF/fbH3Vvku3HLgS/lAPhMqNwG7RZUtWu8tm+NnTE7N6NX1fR6gkKDzdIyxw35MAXxR0B1BfkrEjJKvNun8rlgV08qcV5OROLbOTNx9HCeuyLOhEbd65WEfESp7WgEH0CW2UPqFPkaPNsKwPt5A5h9HYtROIdus5Blf3asBogrVDn5CEE4fsYKkd1beBJU+Rs2hJ//YEGiKL3u36gou5L71WJm24t0yCxQn9pNkhOJyIR95BzsGvl3XzrweZ36sTX8/FsuQ2Om64ZNfGAHqR9qp+ezCu6epUKhGKBbkKMZBCuzbM8eCKMsY6hN3M5j9AjkE0T3QrIqYoE8lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtjthwCRVK2QXGOiEFatajyV7XtFjiTbDAgQPkxXjBI=;
 b=sYyWQvH5OHdiWhe3LLnmmKKlXlXqnPeAPCvK2zJ9wt6oRJKaz4lJTBFICjfwLA1X1qJt4cZWUSTh/caDVCckvTyCBuSgcC4sZ0sufyNs+ehpSzFvK5btQWIPFXqn2z2a4gVs6CF+aeY8ydxD4vTDUDuWbAJiQ6NHdT7LLtdMm6FkcekBSsUAgjNeH4o50z2Cp01+9+B1UQnfCfO2+N+QPiSGoUKpjuk4FysaSHMMT8y5pyAepwOCG0viHxw0Fd+ErR8cLpT5uVvt+ZgI3o0vIJAMW99RPWOIgufHtqQwBp4SB0m6hBT3GADZK9CD22clLoKJmMQ4jqInekojgIddFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Tue, 6 Sep
 2022 12:07:29 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 12:07:29 +0000
Date:   Tue, 6 Sep 2022 09:07:28 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/13] fsdax: Use page_maybe_dma_pinned() for DAX vs DMA
 collisions
Message-ID: <Yxc4AMcFRJC/O0H3@nvidia.com>
References: <166225775968.2351842.11156458342486082012.stgit@dwillia2-xfh.jf.intel.com>
 <166225777193.2351842.16365701080007152185.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166225777193.2351842.16365701080007152185.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: MN2PR01CA0007.prod.exchangelabs.com (2603:10b6:208:10c::20)
 To MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0e7be7c-86c6-4686-607d-08da90005eae
X-MS-TrafficTypeDiagnostic: DM6PR12MB4355:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WxwYyRc7Y8Cmmvh2Jmyk9ro+Kh41QMySW5aKjw2/8gd0lR6nQJjNXrCI5T9f1/5J5sawlE+XPoLUIpB5jw7F7/ISkSZtH3NzkorkV3ABkI3aOt64g8On0O43G2Dsp1BXXa8hQcBgVFkFTJL9kS1WQzJqoGhBWYGzo1gGyDup87P2hr1DDUg/9CGFmsgW1Lje0i4P2BHzTI6FRMy1jt3ggX14f5ZzLXtBnpE9qpE6RxWJ31t5o+UjzhweCb0YiZ9wCE+2eCC42g9T5+KFSY8BKMgLN0Kqczk+o9fiXPY/fQpbhaXjpsEyZi+pzwJn+GbYH8IhrMlEPGxBkZOIljC732oWE+jiNE7pu0a85RFZ8Vi1geUCz8reQcruxUmHpgyrxLZNMFhHE00idE/NnAt7P2IIExbIUqOW7uR30XRwlSvT0HSGhF+uDQFLkXKP3839mGxaPKcyvfXqzD2aMyfG4ouF/IKVaTDy2LaEke2PsfSyACwGbleFX6EFsC7HCntHIlSQpgxCEpKD3vt9ZreSjGFHerBUD2LCE+f7t4DpXryNPeR52bRHygd6zNHJPwHazlUjT+OgGO0RaqpbGEbblNb8ppeoTTQlxx2mA6O8fKawNSUZvtuP98tPtQFFj/byvt/cM0bWY2QX2zlmn3r1v4cpMmPuyrvUaMGvJxsqe1RWz1/rRMJizuOTrxHKXOwGQ1Dn6kUOCTJVguL4xR5rAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(41300700001)(38100700002)(6506007)(316002)(66556008)(86362001)(26005)(66476007)(6916009)(6512007)(66946007)(4326008)(8676002)(54906003)(8936002)(36756003)(2616005)(6486002)(478600001)(4744005)(5660300002)(2906002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6716adNHSzw4ZCoCCahq36D5ezFEOsyV9SLjG6FHZ713Mh/YGnyMdkwkj5G7?=
 =?us-ascii?Q?3YU8zqvOTFsO1mU0G2CqKp4/95Ozjt3im8ugE8xL2AJjMCVC+WWJ+qQJBLyB?=
 =?us-ascii?Q?GexsuiybAhaDbddhu23LFU+wneMvxE38WiGbY0SQrT3T0khQHVtp4UvAmHA3?=
 =?us-ascii?Q?NDIcCy94ig7GHgziFXhJYfk6P0NAQgKGXnTQTlpJfnhYT2gaF9e0eF7gSENJ?=
 =?us-ascii?Q?/zZgi/VS/BqnND4MZCVDhpSkg521TdFWIG079sBMbHD9zDexGN1QqtasoHee?=
 =?us-ascii?Q?P4t/LqdccbJw6CDqJ7JMDDXWItTC5xfcSvmdMK2QGK9UPIXG+ZAIDNFq6fU8?=
 =?us-ascii?Q?r/+QpOQ8C311fROo8FWCvx538GDSskJIgKN2DeXV58mwnk60C9L58cADTxey?=
 =?us-ascii?Q?t+ibkueyKpft/0ue6X9GB54u9vFe91i65UDa+iIyKMD1B8A3BXCyu2EtOLE3?=
 =?us-ascii?Q?CyfeD8RTE7B2jk7wmeip7s3JjAsAgAdqk5oLr+KeL+kIdqb3M/hRdLfFhyoc?=
 =?us-ascii?Q?IlkjIxb83YekOcHK1p7conkrdo4T2X8p88PEN7zWBzWZtB8G362ZWvgnBSiC?=
 =?us-ascii?Q?ll3+WvRhIT/lKFSnIb70izv16pLm0aQwnc/Kh3+mIsbCoyHXdVNr4h0U9vxW?=
 =?us-ascii?Q?jzIJP+PNcOgpovNDR86/5i9jkeFTDVB2Ar9PbOHZE+3bngtN50h5B7D+C2ok?=
 =?us-ascii?Q?l6vo8Q831bvMcoO/Lw9UTuBKOxw1mWNQ9ITjXnM/SscukDP0BBxi7jqCa47H?=
 =?us-ascii?Q?GR1rZemC0zloQWufTar7XFCpLtgXM1d+T5h/KRPqnfDArxEvsQgHBMcrVhhm?=
 =?us-ascii?Q?fvut2kRR+tSrzqichWE8uX5hL1zobKs2MKwiFU1dVnzS3Ty81m9k65PhePkW?=
 =?us-ascii?Q?k+2L+J6IRnuoEZ3IVorzG4q/YtLiX5aP39y7oKEWY4SrypmYZ4j0/LsMflzg?=
 =?us-ascii?Q?Is9QnDqJ1pSwX8pN9CioSFUiVBspvX4LFm1IVtrykPD+a3wZEIoFE+BRyPYr?=
 =?us-ascii?Q?cFDZkvEPQ7JxH5SAHYb117vL1bMUc4rbziY4BIrLfZtlNsLNYRr5Ro5SjoTg?=
 =?us-ascii?Q?uRyGNHEdu3zmf9YxeOAMSZYN7DzZD3xmdx5mAxf0rkeooteRM/Bk8+N29Dmq?=
 =?us-ascii?Q?eX+Rdpr32w0FlMmuAHdBS8tNg9lEt7n7AW6DKi+c2lhQ+S8uXIfq/MCC4yL1?=
 =?us-ascii?Q?7tmOjQDLQ3vLWqGdFnXYD0aL5ZfkqdtcKC9pcaN7ybflrBRFVJBVkbMZklef?=
 =?us-ascii?Q?QM42TePVQMADNovBZRNJ8t1F4sUZu7MDK946JQh6wKvLLv8I1prf6orRZxQm?=
 =?us-ascii?Q?duuBvYC41MeBIZMXvIcxOb3DyKcBcC3lPrxQDevc2bb9oWhjYv0f9ixWTu+d?=
 =?us-ascii?Q?q+KRVu+cryBOjSfDmDWmWOmwuPv809FgYIB2N3v3vETCyiRNsnUx4qXA0WEX?=
 =?us-ascii?Q?iL3BuZMqBGeMs36t3b2G2uIi5BZ7J8AOasLrnT7V7YPoyDeSHLt+NdIBq22V?=
 =?us-ascii?Q?InGGwhEMo6ggVrMCVKj0Lv7hnowbK8TBdgku9vJwKZNrm81ylMYxwW2VQnOH?=
 =?us-ascii?Q?/R85zZp2GUM5eymfwTKzP7F+WDpk9tB/5LoxOojb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e7be7c-86c6-4686-607d-08da90005eae
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 12:07:29.0482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xP0ZiiovnM+FyWLcSiT18beSi7RkvxgFNE/Wkko3/cor68iqDZ2Fg2JvfHE/A2sb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 03, 2022 at 07:16:12PM -0700, Dan Williams wrote:

> diff --git a/mm/gup.c b/mm/gup.c
> index 732825157430..499c46296fda 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -177,8 +177,10 @@ static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
>  			refs *= GUP_PIN_COUNTING_BIAS;
>  	}
>  
> -	if (!put_devmap_managed_page_refs(&folio->page, refs))
> -		folio_put_refs(folio, refs);
> +	folio_put_refs(folio, refs);

Can this be made unconditional at this point in the series? Shouldn't
something have been changed on the get ref side?

Jason
