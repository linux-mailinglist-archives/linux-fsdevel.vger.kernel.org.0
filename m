Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE79678ED3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 04:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjAXDI6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 22:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbjAXDI5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 22:08:57 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D4C39B81;
        Mon, 23 Jan 2023 19:08:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BynGDmXtGWL7RJpy3RUdvBJDxWtjB+7xo8SS08+adjDehPGCQOpHtP4aU9LOZeDAlX/oJHZvJvGoPrc+6gNCKJPWc/Hn9eOets/25hcofeySkq+LqNg5t3J1BS9+o+OdEnSthZIQM8N/N0aRFKr5LtmNQIDFPV4YTE37hqbS5x4tdcwY1ZpTg1UNFc8EP5ZdPMVbNwp/qClwCwbqOEA7Hs4Xm9ZCrat0Ww67Yw5ZPn66lrT22iv5FY5noJk6Ltx0NJHHDFfulpg2qQYhtch33h8HKr5bSCvUb0rhrpQzatwnEsyti8GJI0WeI/OeqULigWH/DiLX74BGcGhpum2GBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4eGON2eMjRCnKUByBv5u1B2n4uxcM6IvnS6kEreEN/c=;
 b=dU+wDIXO1ccC+vSRnLduOSpbE1GJp8pKtyA002EFkGoI9omZ8Uyvkyf8MmAWdpNbBV4SfHHn41JhRCQtd8CtYalPSrGv1VnguNUWDYguEkiLx4QhrUyfXCFyNSEnUfOUtKukHvqAed2hcCqJUzTD8ytEVmwb03M8E6VgAhaeol4g5mZ7+v47AvepEfGdWdxijrSfXBYWF/Lz4XiVh0mH+Sffw+CSQjhixd33hRUPoxsCE55CfsDBBbWRfj9K+B7Kjm0Lr8QV+gxZElpip+TZMZHUkX8DIk7TJGCLEU6gq+hF74Dy13NXpqyilvx5Lk9q4VOb1pa48Ma/yw7bTRmrzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eGON2eMjRCnKUByBv5u1B2n4uxcM6IvnS6kEreEN/c=;
 b=bpX0OuDgwyl6hwctQdxLe1Q+KIhqiSaSX7Xq7g1x57R7srhTUOC9vLY9iIkM0l4M5Zkolbikfvk2gcYR5w86lfyJJbEsA63Z2ou7rPXdFG7bdbFaO7sBKej0lN2kxk37q35EIn0DTBmenWHMLCDOYGt7c59LyZHxG+vyiwKkOQjwfXaMRgtjuDx0KLswvCsasm4Cx9uxoydd5Y8+JioBIGzYSeJyMbzKD25GGcRNICOzi8mxv/M2jCf9146sH8K6P0DQB7XNOJwFwdJoCqh6v+wkeewHgxS7oyLIDHL+6+GZrtlJTI6C3yytYlJDLrJroOO6JcyOWXg/Wh92cTkl4Q==
Received: from MW4PR04CA0325.namprd04.prod.outlook.com (2603:10b6:303:82::30)
 by MN2PR12MB4189.namprd12.prod.outlook.com (2603:10b6:208:1d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 03:08:50 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::15) by MW4PR04CA0325.outlook.office365.com
 (2603:10b6:303:82::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Tue, 24 Jan 2023 03:08:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.17 via Frontend Transport; Tue, 24 Jan 2023 03:08:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 23 Jan
 2023 19:08:40 -0800
Received: from [10.110.48.28] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 23 Jan
 2023 19:08:40 -0800
Message-ID: <31f7d71d-0eb9-2250-78c0-2e8f31023c66@nvidia.com>
Date:   Mon, 23 Jan 2023 19:08:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v8 10/10] mm: Renumber FOLL_PIN and FOLL_GET down
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
CC:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        "Jan Kara" <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, "Christoph Hellwig" <hch@lst.de>,
        <linux-mm@kvack.org>
References: <20230123173007.325544-1-dhowells@redhat.com>
 <20230123173007.325544-11-dhowells@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20230123173007.325544-11-dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT065:EE_|MN2PR12MB4189:EE_
X-MS-Office365-Filtering-Correlation-Id: e00a5585-07fb-4ab7-3b2e-08dafdb85121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E9uu5fLWKc0Ma1rEpINxbaKMay6F5wgBKjA6lcOLSfFtjySQLE892uZh1b6Fp1G2lfBO9/8zA/FNkxFSCjaZejZK8gdGj0abeQmFegOOeVS4PkfArtHrx2DDl23DKmhr8XaUwwcbVWwsgHEWzdN1vZCgZ5SDkktYXuH5WxQFs0Oo5z2Eg21gqQB396qkvRQID6dpf+D4+W56I12LVMLiblw3wDawR/GUYpz+F1dWYO1utGAFCI4UzZ+Yhayd/dVngbvBqkw9BrZ3FXXdo2DpaKyuav1aATS2TaslIS+SHFqv14h+BYyCG4lqPcclNsA0MqPcOSEGTYH57V9DAjnxxSo4OMZl4trLmQgx6SO2Ytc8HjguMX2xTh5FGQYKPj4RcPGXgQxVYvXN+iSvNcpnzl/YK9qd7IbFk3zYVme+sn3x0+XbsPQvUFnfg4mQ8Kvsxr5E03tpUGos/iI9C9oFw/vZH3dcnbez5hUT0cNUsG3jJxz84IxIVqf8gNitbLoEfXAOJVj4uHN9qlVYMBnkmLclsBU+v6FUN9TkkPLBkLcViph2GZ7md84Rv3KBxaKd6stl9+EiGgfpuxOP9CcmI9BQuEdb/QnPe5e8AY+1PUC3d9DPTzKDRSXzHrYXdmtsZLpGjdNa4fQzn2PDinrMmy+RWX3tnNF64fiBAlDCpeWkKtFG+UcEeXgy8oRl6y+6hnXTV0mRvUVYwFnj3ishZ2IjR9EW1F+uSqL/YI3l/l4=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199015)(46966006)(40470700004)(36840700001)(36860700001)(83380400001)(82740400003)(7416002)(41300700001)(86362001)(356005)(7636003)(82310400005)(2906002)(5660300002)(8936002)(4326008)(40460700003)(16526019)(40480700001)(26005)(53546011)(8676002)(186003)(47076005)(336012)(426003)(316002)(70586007)(16576012)(70206006)(54906003)(2616005)(110136005)(478600001)(31686004)(31696002)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 03:08:50.2194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e00a5585-07fb-4ab7-3b2e-08dafdb85121
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4189
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/23/23 09:30, David Howells wrote:
> Renumber FOLL_PIN and FOLL_GET down to bit 0 and 1 respectively so that
> they are coincidentally the same as BIO_PAGE_PINNED and BIO_PAGE_REFFED and
> also so that they can be stored in the bottom two bits of a page pointer
> (something I'm looking at for zerocopy socket fragments).
> 
> (Note that BIO_PAGE_REFFED should probably be got rid of at some point,
> hence why FOLL_PIN is at 0.)
> 
> Also renumber down the other FOLL_* flags to close the gaps.

Should we also get these sorted into internal-to-mm and public sets?
Because Jason (+Cc) again was about to split them apart into
mm/internal.h [1] and that might make that a little cleaner.

Also, I don't think that there is any large readability difference
either way between 0x and <<1, so whatever you and Christophe settle on
there seems fine.

So either way with those points,

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> ---
> 
> Notes:
>      ver #8)
>       - Put FOLL_PIN at bit 0 and FOLL_GET at bit 1 to match BIO_PAGE_*.
>       - Renumber the remaining flags down to fill in the gap.
> 
>   include/linux/mm.h | 32 +++++++++++++++++---------------
>   1 file changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 3de9d88f8524..c95bc4f77e8f 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3074,26 +3074,28 @@ static inline vm_fault_t vmf_error(int err)
>   struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
>   			 unsigned int foll_flags);
>   
> -#define FOLL_WRITE	0x01	/* check pte is writable */
> -#define FOLL_TOUCH	0x02	/* mark page accessed */
> -#define FOLL_GET	0x04	/* do get_page on page */
> -#define FOLL_DUMP	0x08	/* give error on hole if it would be zero */
> -#define FOLL_FORCE	0x10	/* get_user_pages read/write w/o permission */
> -#define FOLL_NOWAIT	0x20	/* if a disk transfer is needed, start the IO
> +#define FOLL_PIN	0x01	/* pages must be released via unpin_user_page */
> +#define FOLL_GET	0x02	/* do get_page on page (equivalent to BIO_FOLL_GET) */
> +#define FOLL_WRITE	0x04	/* check pte is writable */
> +#define FOLL_TOUCH	0x08	/* mark page accessed */
> +#define FOLL_DUMP	0x10	/* give error on hole if it would be zero */
> +#define FOLL_FORCE	0x20	/* get_user_pages read/write w/o permission */
> +#define FOLL_NOWAIT	0x40	/* if a disk transfer is needed, start the IO
>   				 * and return without waiting upon it */
>   #define FOLL_NOFAULT	0x80	/* do not fault in pages */
>   #define FOLL_HWPOISON	0x100	/* check page is hwpoisoned */
> -#define FOLL_TRIED	0x800	/* a retry, previous pass started an IO */
> -#define FOLL_REMOTE	0x2000	/* we are working on non-current tsk/mm */
> -#define FOLL_ANON	0x8000	/* don't do file mappings */
> -#define FOLL_LONGTERM	0x10000	/* mapping lifetime is indefinite: see below */
> -#define FOLL_SPLIT_PMD	0x20000	/* split huge pmd before returning */
> -#define FOLL_PIN	0x40000	/* pages must be released via unpin_user_page */
> -#define FOLL_FAST_ONLY	0x80000	/* gup_fast: prevent fall-back to slow gup */
> -#define FOLL_PCI_P2PDMA	0x100000 /* allow returning PCI P2PDMA pages */
> -#define FOLL_INTERRUPTIBLE  0x200000 /* allow interrupts from generic signals */
> +#define FOLL_TRIED	0x200	/* a retry, previous pass started an IO */
> +#define FOLL_REMOTE	0x400	/* we are working on non-current tsk/mm */
> +#define FOLL_ANON	0x800	/* don't do file mappings */
> +#define FOLL_LONGTERM	0x1000	/* mapping lifetime is indefinite: see below */
> +#define FOLL_SPLIT_PMD	0x2000	/* split huge pmd before returning */
> +#define FOLL_FAST_ONLY	0x4000	/* gup_fast: prevent fall-back to slow gup */
> +#define FOLL_PCI_P2PDMA	0x8000 /* allow returning PCI P2PDMA pages */
> +#define FOLL_INTERRUPTIBLE  0x10000 /* allow interrupts from generic signals */
>   
>   /*
> + * Note that FOLL_PIN is sorted to bit 0 to be coincident with BIO_PAGE_PINNED.
> + *
>    * FOLL_PIN and FOLL_LONGTERM may be used in various combinations with each
>    * other. Here is what they mean, and how to use them:
>    *
> 
> 

