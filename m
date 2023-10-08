Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E05D7C02FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 19:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbjJJRuL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 13:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbjJJRuK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 13:50:10 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6399299
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 10:50:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUBCwP4gLb7t8+VZawUfUrnbQlbAj/vmlNQEzQ4p2Fuaw/x2DDDsRcfxokFwfHEZQr+Axc6T4CiTVZ7skyxl7w5iLJkBvOTv8ihqC5sQm0tec1LHwbE+4ROWy2r2KTRg7DxnJDTgah0Zm/q11+I3hRcMBZalpTjrSbjMtCFKW7v5d374EcClGiETgCD7YNB+3Ds/F1R4yJm9Cy87Szuur0khs7ffjQ5P4DNZf8EajbCGbxQzOCoCjUn2prTokyjhVy1ndx/GyJfKmvbOJW/SVLarbO1i6JpDPG5DBHnRj1r5phARLSlU3vZNUuxtplaYweCixw3Yc5iv7LFepQPbMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FS5B225dhCReZjrCHL1Tws9UdiPQfmwsEBFr91e9Vc=;
 b=V1xfw9H7Gz8pmAR6Ch39YVgSIFJEq0yZK714vUtjpsplEwHHgxEgdWTVWXcYuwWg+NfjDmvkrBNKPWSIboawtGbwk4YfvWm9iDpr8nscQJ9E238o9aLkENZJuFqhrcVBYb1j8rDKlE4gsXsX9kv6QygneZ2LL0JHZTk/4qLKWj5E7QJOpwhS0DjjRMRE9pFy+J7wHe+q0wdp+w1EVOD5l87Kp3xlPa2qo4C45RJqZZWPKos1+ff1JqeRVA4BSwhH62TqKarWsDRKveI/HGtVGyGtyXc7cCT04zk62uColJFi51scCtYwldpau28/X7TyMhSRGx26kOPFi8s9gJHx0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FS5B225dhCReZjrCHL1Tws9UdiPQfmwsEBFr91e9Vc=;
 b=jfimbw7FclIK2kdsOtBPldjOH7X3dFEngng7FLVL3bN1NhbhovYuxC9BBg1IrAgNOUb5r6LyxoyqJ14VxJ1aFWglELPrJJ6q928IFEtnojwRDx7+YQbyp0gWz3v097VQ7r0lNC8OVGsEwkprZoU7n5valfX6qWtonLTRlpMMrOo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by DM6PR17MB3961.namprd17.prod.outlook.com (2603:10b6:5:252::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 17:50:05 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::bdfd:7c88:7f47:2ecd]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::bdfd:7c88:7f47:2ecd%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 17:50:04 +0000
Date:   Sun, 8 Oct 2023 11:34:45 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 08/39] mm/swap: Add folio_mark_accessed()
Message-ID: <ZSLMFXrDFhzI5ieI@memverge.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715200030.899216-9-willy@infradead.org>
X-ClientProxiedBy: BYAPR11CA0081.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::22) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|DM6PR17MB3961:EE_
X-MS-Office365-Filtering-Correlation-Id: ce7dea48-bbb2-4051-0675-08dbc9b9559a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rC3dGq6VY6oYKTWJRXWuUtV2WlGTBAxGwc3h3kLnIhCxxGvXAKnKZNRgDYYBlBq20BZAYwFv4V8B1a+p8xriDB4AKi34IWKyXRIJwf+s69HNvKImCjNP3g3NsnG8GKsTQyezIjRT/sYKG7fY6voX5ot22y4RBVWQPqTx3WrrWHZfgGzyFOcJHTcQ2ByNJiO1Tqviy6X77Typq7m2jmgbUV0I09XmXzxYqJSMOCC9dgEZpIaRhJI3HMBNLpPnCXhDlHlGKdbBG+/LYeaFtPvPpHGnGC/ZPfOcED0tGDTxVBj/KqJEwKB+7HWUKnkBS+Sp8r7OcrhCvBWVobF8OmyR8Q4s+j9Be1uzSzbNw8A5SV3dsXFxS1USyWmuare3kr7I9Ve66S5VbAafJvkE0LBfwZRUI+UDqkcWVwNQLr3G/zx9oMkUXdiNOWyM/iiNY6uPK1iGeC3qtZwrPeLdsQIPppMqmARQk7sKnTUw8/GNBjjd0PFFig+/DJtCMxLfc7vKNqPkpuLJwwNm+Oj75JGP0vSNrC3xz6BUa+ur85gCJPHq+V65LZ04zoYUWVvsnDhH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(366004)(39840400004)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6512007)(2616005)(478600001)(6486002)(6666004)(44832011)(26005)(83380400001)(2906002)(5660300002)(66556008)(66946007)(66476007)(4326008)(8936002)(6916009)(8676002)(41300700001)(316002)(36756003)(86362001)(6506007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ax/pH/Fjel6t/kmUgF0KHaSz2plzLoaX3e+OTpH7QR58Y0q40RYcH0u0LjGE?=
 =?us-ascii?Q?VrYRlmr4qtkyrEycI7zYUAgPldIh++3CbnFLsM3BtvLDand6ZHC2BFKtVL6k?=
 =?us-ascii?Q?/eXqjSGVKbdLbpKx0lx6LMygMnweRkn3X6arWhtTHPR01VX1rMApHN+CpkL9?=
 =?us-ascii?Q?JcSbqIWI59gA4bF+iInHbDVV6Yp02DI+m9crdhwiEwVe0s30q0S7s54kA0O4?=
 =?us-ascii?Q?8wLwNyN+IMp+3uyNpFC4a4JBekFWkPaS0Gu0dk3nsfsV1zyUq7VedrjCGhdJ?=
 =?us-ascii?Q?uCUwpUr/Dpz4hFBX97ocvc/VQNcMgZ3h48Dc+f5yxuxNuEnRbzOK7/olSyco?=
 =?us-ascii?Q?l1nHlbWIv0GmBiVxoXpDGqU3LQ7cxr03yp0c2l6ZhH60sXWoiUC1ykzaRCFa?=
 =?us-ascii?Q?Fb57SVLFRKPFrved5cvuePekyqbap4hgcN4kQG1sC2ttFbc2K9+6sXoulYzY?=
 =?us-ascii?Q?hBcD4HD2cRxZWYljhAijpzZmm3DhfaD67hgPSL+FmS6H6jpLhlzv2LSF3Ham?=
 =?us-ascii?Q?IWVIY9mOVLO/PR3WV08a+r9sxZ0owFYwwhZqJI5I6ZLFTGUyAEiOSlhbf4ns?=
 =?us-ascii?Q?7I4b8UMMEMCFSuNz7rMUBmdRITfUI5M3nEZgF8HfuCSxH0pjkqw6Q1nQ0WJn?=
 =?us-ascii?Q?QG2J/G4NrGhv828HDkEGTdPm9lMFU1ZnNn4u8Ouus9WCXMbFf7RJMhK8XESP?=
 =?us-ascii?Q?8VkbRg+pRXJsoH+m6p86PFEjJRI1gNiPAZfl0Kvd3uvrnMUTNW1kePDywx1M?=
 =?us-ascii?Q?XLS4DOh3FSh7wo97Xbj0Ixz2kFoRIg7t0z8vZP32im8tbFnA9B/pxrpHYBST?=
 =?us-ascii?Q?rCa/9RJQxbDusamWxGP0qwcS3ss5XjByOgPehJTohfla/uMUtuIx1nLumAhC?=
 =?us-ascii?Q?wSCxkF9XfAdk5ea+dwe9ZNhW0MenNfnk+TxvkjPbYOC9SpnIiWAXf91jSdbS?=
 =?us-ascii?Q?ATj/W6whwWgzzVn8RzA4G7Zp/7oHGaV4xJKGkE5r+COVUs6ngAQDPpA2CWgY?=
 =?us-ascii?Q?BPAJVnTriMB6gqduaFYaQAXVoovTo27dNnGyiTT5jdIlPNjPPCm6ZTvj776M?=
 =?us-ascii?Q?78AQvICLRzg3ZjygKtBj8On09Ld4zDX4OOpQSCrskRitWXs66YiUdTidEwkW?=
 =?us-ascii?Q?wgJCV/w2dftb7GINa591qXkFRv/G9i93vyfwEr9FMs/d2p4kIempTQFDMULn?=
 =?us-ascii?Q?/at1ZIadohVOcuqMdoLeP+FvI8mWQqTY7WLHvfyqivottMXkHWcPbzkGV2Y/?=
 =?us-ascii?Q?9ZLy29KK0QkUl8AdubnAhhwQvO6hzGyc9qfr9LDziToZO/MuYSDoUk5YWd+S?=
 =?us-ascii?Q?L7DVpbjMbDSilZb3XlBf3ILN4Hz0L/ovORNZKV2r1HZwfSSXc82YbLDyHCsQ?=
 =?us-ascii?Q?V0gBrW2EpS3zJOrL5w4IYOs8aCbdESKYruxx5cg4wu3zQ8UyTQxgI11yR4zk?=
 =?us-ascii?Q?fCK0zZMDoGFaWZYxw5FWqc8hAFpo/ZoxpkXsueMoaPjIhc+DZ9NT9MG21c/D?=
 =?us-ascii?Q?67XtJo6s64Vg+khb1L19Y3RjWJR2I01TnCPtA/6Qv8dus01IooeWU+Mq/MEf?=
 =?us-ascii?Q?mv7p0q6qGxA6jVTc3TIJZ4MKSwJwFtKeLkCk/yD4FUTZlLAZCFTXguVsPCgB?=
 =?us-ascii?Q?DQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7dea48-bbb2-4051-0675-08dbc9b9559a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 17:50:04.7607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mLgJphU8XbCN2/6IAg9LBZ5HivrxrxgpB5kD4ezhWevyxzhAhbYUA49RlLR9i0z31jgMpy3lfOpCDdISx3yl5uyWwj6VZte5e8I9r1olunM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR17MB3961
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 15 Jul 2021 20:59:59 +0100, Matthew Wilcox wrote
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 989d8f78c256..c7a4c0a5863d 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -352,7 +352,8 @@ extern void lru_note_cost(struct lruvec *lruvec, bool file,
>  			  unsigned int nr_pages);
>  extern void lru_note_cost_page(struct page *);
>  extern void lru_cache_add(struct page *);
> -extern void mark_page_accessed(struct page *);
> +void mark_page_accessed(struct page *);
> +void folio_mark_accessed(struct folio *);
> 
>  extern atomic_t lru_disable_count;
> 
> diff --git a/mm/folio-compat.c b/mm/folio-compat.c
> index 7044fcc8a8aa..a374747ae1c6 100644
> --- a/mm/folio-compat.c
> +++ b/mm/folio-compat.c
> @@ -5,6 +5,7 @@
>   */
> 
>  #include <linux/pagemap.h>
> +#include <linux/swap.h>
> 
>  struct address_space *page_mapping(struct page *page)
>  {
> @@ -41,3 +42,9 @@ bool page_mapped(struct page *page)
>  	return folio_mapped(page_folio(page));
>  }
>  EXPORT_SYMBOL(page_mapped);
> +
> +void mark_page_accessed(struct page *page)
> +{
> +	folio_mark_accessed(page_folio(page));
> +}
> +EXPORT_SYMBOL(mark_page_accessed);
... snip ...
>
> @@ -430,36 +430,34 @@ static void __lru_cache_activate_page(struct page *page)
>   * When a newly allocated page is not yet visible, so safe for non-atomic ops,
>   * __SetPageReferenced(page) may be substituted for mark_page_accessed(page).
>   */
> -void mark_page_accessed(struct page *page)
> +void folio_mark_accessed(struct folio *folio)
>  {
> -	page = compound_head(page);
> -
> -	if (!PageReferenced(page)) {
> -		SetPageReferenced(page);
> -	} else if (PageUnevictable(page)) {
> +	if (!folio_test_referenced(folio)) {
> +		folio_set_referenced(folio);
> +	} else if (folio_test_unevictable(folio)) {

Hi Matthew,

My colleagues and I have been testing some page-tracking algorithms and
we tried using the reference bit by using /proc/pid/clear_clears,
/proc/pid/pagemap, and /proc/kpageflags.

I'm not 100% of the issue, but we're finding some inconsistencies when
tracking page reference bits, and this seems to be at least one of the
patches we saw that might be in the mix.

From reading up on folios, it seems like this change prevents each
individual page in a folio from being marked referenced, and instead
prefers to simply mark the entire folio containing the page as accessed.

When looking at the proc/ interface, it seems like it is still
referencing the page and not using the folio for a page (see below).

Our current suspicion is that since only the folio head gets marked
referenced, any pages inside the folio that aren't the head will
basically never be marked referenced, leading to an inconsistent view.

I'm curious your thoughts on whether (or neither):

a) Should we update kpageflags_read to use page_folio() and get the
   folio flags for the head page

or

b) the above change to mark_page_accessed() should mark both the
   individual page flags to accessed as well as the folio head accessed.

Thanks for your time.
Gregory Price


(relevant fs/proc/page.c code:)


static ssize_t kpageflags_read(struct file *file, char __user *buf,
                             size_t count, loff_t *ppos)
{
... snip ...
                ppage = pfn_to_online_page(pfn);

                if (put_user(stable_page_flags(ppage), out)) {
                        ret = -EFAULT;
                        break;
                }
... snip ...
}


u64 stable_page_flags(struct page *page)
{
... snip ...
        k = page->flags;
... snip ...
}
