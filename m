Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6646006D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 08:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJQGtl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 02:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiJQGtk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 02:49:40 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6D5DEC7
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Oct 2022 23:49:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ConQtKRW0ou7/o8TRQQtCX1yWDGmYzNakyu3N66qBnHSs03UVu+NUjvolsIfTDWhzsPIpd7mzfWlzSrdYxHEdG5FisPHOMdRKeOyrioT4Psxam0GSxwALGr5z/H7GPcmTHQZwTPXw10sOmi6mMifAa9WEJc6M7MdAe1vN4GYkiKwmRD+8kLevKnm0ld+jTkOpOD8nmVYp4IW3Yc8vr7QbYQe+Ivv35BJLbEOOE+wPEy/fvjny9hiEnEy+nG3knv0ufeQD5ycZ2m4UMaA91UiEJk4CK8dbk2FoP11cOLYsNpEPsKaakbQSj7Dc4/vR5bG3bT7kHPZUVy1YYcmqdIx4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9V3ndS+szv+Va8ICRs2Wx0cuNd1u+FQgVwEAIS0sdU=;
 b=HTEV7D2HqKwS6CsIVyJdgVZyJ3jq1Cn9OQ+uafGh6dqbI5TX3erJYdXvpEkKHUpidpTxNfwBlMwibffzS2EhTRCEgRT7S0SNu7pxLdAUqbS4Zx5ck+pREFW+pH99yH8ENcRubFdPtYF7lmxY1nZqF8YkAvV7rv10nfKbrgjwNYkA6hI669CFFc8aQ46x2dZK3LBloIADDpM80nANeJZxQCTjgzs3ow6XrORGVsYmUqwt8/xW2BvN3B7ML0FHCFskT9t+8pb9nAs5nqWhCHZRqtsMz7pVUKZTT6kd9sRZUbwN3jAOWGU8MK126wmUKvWYqNjuJljbB7k7FFN/gZLk6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9V3ndS+szv+Va8ICRs2Wx0cuNd1u+FQgVwEAIS0sdU=;
 b=o8OOB4Sdvaok0XNSY8SrGLsFmg8s99RJHhD8zlMh07DAYRJiIOK5lrN3n7jlRoqxN0NJwBZcltus1j3VVNShegYijJ+EVoXpNhkBIZ0RCHGjkSSVL9+K9GUOcLn9CNQn38ZrbXQMYpog6OH0zGqIPvfMKWxpWkZuvq//fptIGz2MGqlhvT26exGijDV+A7RLHG780TxA7dr1I1bRTVHOsnptFujpa96tGgHBMCnl0kwxL/0GKr3sIW/+nRTRILdeIUtODS2cGICaB3j6uxqT2VCvxB19CgpzUwzalwGjsbqXK/aS937LsQ7GmZTISu2YLqvvNQ3036TyfW7gRF/7Mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by IA1PR12MB6284.namprd12.prod.outlook.com (2603:10b6:208:3e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Mon, 17 Oct
 2022 06:49:37 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::6ed5:b1a6:b935:a4d8]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::6ed5:b1a6:b935:a4d8%7]) with mapi id 15.20.5723.032; Mon, 17 Oct 2022
 06:49:37 +0000
References: <166579181584.2236710.17813547487183983273.stgit@dwillia2-xfh.jf.intel.com>
 <166579187573.2236710.10151157417629496558.stgit@dwillia2-xfh.jf.intel.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>, david@fromorbit.com,
        nvdimm@lists.linux.dev, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 10/25] fsdax: Introduce pgmap_request_folios()
Date:   Mon, 17 Oct 2022 17:31:36 +1100
In-reply-to: <166579187573.2236710.10151157417629496558.stgit@dwillia2-xfh.jf.intel.com>
Message-ID: <877d0z0wsl.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SY4P282CA0011.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:a0::21) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|IA1PR12MB6284:EE_
X-MS-Office365-Filtering-Correlation-Id: d9e36b81-950f-4333-4f17-08dab00bc1c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uUHtFm5d/WqayLZEXEIeBLykvZNQGKcqKNU8OG5+w5VULhjsGa7xPu2KSSwTEBrmJ9DO61Te9iUVRmfpRuhgO0i869VibUF/VNAarnEJNAmaIByTkOkfr6hzgmwnjY6wjkJKDl0jfJNKnmaDx+77PZf6M7FjDKplGvsHEanI1up6++TuiQsTLyzexgRKi6ONVBR+ShnCO2tagswMKE7ccWNBatZkklHrYiNgTesI+SOOAglk3vejrhYXyRh3opm/DTSIuuMzIdcAL2GX7vazXAQ+19QDm6o8GnXDMaIKSfSch+clx6og0PEkfaVd+FKMMgHtW6avAq5W5y+ByTgDOQRXX9snOVuS7JVoPBAnP49fedUH/Lpua3zeVaLaMkhmmXw1LK0fZkk4nTV5NI9pILqemzxy3COxXtfcCP0HZXiOpoWafe69NMaBfzmT+rmfT/0r3+y0irjxdmFNBitCIKp4Yp0yYy5LB8ww/aAmRQZ1/jkdgy5CjkExonZWzNiTYWSsoiA229o2GkNvaqOTqimwKDl/AHIR77yOx2FRrYTmktbb+N3z19JefkGk4/+AlGWePMSGEq3wcyfx8x5hfMn8sQEFYPsQ1Z5oMHahTPzuDMfUdjbBL/Adm74AjHiIyc5WQW7gvOh1r8OYFyOATn8IkatbOPnLCu7M9OlY1TCBk4Eqrl5Fvv7ZPclKxqKXgPOawcxroZqXPF3hMQwDAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(451199015)(316002)(54906003)(6916009)(186003)(36756003)(2616005)(6506007)(4326008)(2906002)(6512007)(8936002)(26005)(5660300002)(41300700001)(83380400001)(7416002)(86362001)(66556008)(66946007)(66476007)(8676002)(6486002)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?35W/P9HNYg1bNg6/T61+yKWtWiLIP+sTNSX/EkUx4tdjNH6zcASxRlXZf40O?=
 =?us-ascii?Q?wMNU2bHpQ6tf/tvvWCmGhtufZG3SqzrL8pUFnufGCRs4qBzyb7NF3W1kF78W?=
 =?us-ascii?Q?CvZv1KM6bUjEQiqgmz1hx3h0HbEEtpgdputOJaNmR3SiivRs+Mvw9cqN9N4g?=
 =?us-ascii?Q?jGyfdsqsHiHEjwQVCQomNPDwC+thYnWosCMkV17cZqzyOB1N7mlWH6KUfOSU?=
 =?us-ascii?Q?jWxDylS1ZraUL6+7cjoy8XEyRdXhUd+ZHR4fBMRrW1m+bg+wZB/CdGBdcFFB?=
 =?us-ascii?Q?gkzNWT3Ax8u52CjwVfePNm3BdQA7FZeZdJxgjJLzbUkjeX4E6GCmFaVWzFER?=
 =?us-ascii?Q?QjcJWJ57maMW3THe/UNPx50zGa6s7QP9cJhQPCEcirvgfQN3miHpYltYbEct?=
 =?us-ascii?Q?OxDQNfoqK1jFIjE0UAl9CAP+9HxIWKAz3mtvlcOoVNpyIsFoGL2hqocNtfiY?=
 =?us-ascii?Q?kIWB4Kr3MFywXQX8jzhAfqzAhDW7nHGsPDLY/nvEnUTrOIhDPvXnG110cksL?=
 =?us-ascii?Q?OdU75ur0lIG8YHumc7MsobLnDZsxeiTqzquIiZbC6kLJGzDxvs2nusWzhNf/?=
 =?us-ascii?Q?wXK81Z7BnmSpCTdoHLpcEBHG6noqEMNO5tEOf1sG7OV3VAG739ApUzVCUxUP?=
 =?us-ascii?Q?ZqzTx8asD3I+9xw56iPdtjTeI1LgRv4iGQ0kp6el5hOLiqdSInWj5GaqKPFw?=
 =?us-ascii?Q?rxXB1+967TUeZlAIL5cJLPGfzEbNU/E3EtxHZYQR4h4dkV8TiYGIFGkmMNoX?=
 =?us-ascii?Q?/Pn26MGHCMSNbIVI0nQbkuy/7KBlJ9dtjagqqROaNCwS2EAaWGrSKnrc3FJl?=
 =?us-ascii?Q?yMHSQDXkRyQcLrC7viVY88irmVubYhxQCciCtV31qXfwkJfKkfmbAR+oL80F?=
 =?us-ascii?Q?tfzWqDienmZFPV8xDmcYuwiGxmmq+g2cxkTdLMV9nsR6LIv6E9ZlVh7ONgxP?=
 =?us-ascii?Q?EtpqRT5zlKRQ3RR4iu5A9Nt3seNY5T9T878hyNxcZaQhvhz7E+EGRKPOVivC?=
 =?us-ascii?Q?GIwTpMyvGy7YdAs18MJyRr0K5r6XrxlU1PGMkcNODWVInafSV+i2y5Hg89kh?=
 =?us-ascii?Q?f9l7pUYYcn1SdHz4+yFaUuNUDFrrADA9gYrJutCINHR8cPeF/F56RnB96Guw?=
 =?us-ascii?Q?agaH7C4gQ/XsQczrhkLAS/pb8vJJbR+8hL6iih6zFFIeGWz/J6QaEuwzhEi+?=
 =?us-ascii?Q?Dcq3ZAtj9xdE8tcfBAgs4NOu+1nhMDcQ2FdXpbulPDXLV0peMgPccVQhYzT6?=
 =?us-ascii?Q?OX1elpuEoCFHX/ncWHzGfHz7OC3urgWfCGkzAHiX36fMGtWlIy53CmRIz7LJ?=
 =?us-ascii?Q?0g3pA5zVix/8uoLa9qn6xG5S4/pLaKrcP+kpe/mb6Y8EW4gmhgFE4ci7inl5?=
 =?us-ascii?Q?+2F/+LMh1+R9fuQQaFR9rshZgpxQXbSfwL1yu+kI4ruH+o0nOPqu559E97Nu?=
 =?us-ascii?Q?as0lw3pKRnKlKu5nOMP5abNytnnGopHhSvgWXZEBLr1z1s5hNaUjGSs422qU?=
 =?us-ascii?Q?bjgUwASxja7rxbVsmVp3APG4lSzZHHBujnMCIOFKxGOxxa5MkdFJ7Uyr6gJn?=
 =?us-ascii?Q?wRvmneu38vaRbiPY0iALLVeOzD9/UayvnY1/Ysdd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e36b81-950f-4333-4f17-08dab00bc1c5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 06:49:37.1689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B9kL9i+EjjZjq5xkVfgdwx0UfFklFW6A4R+VG3jSb58OdmYqGUmmDCLL7Mb2Ar+n055R5EmhuW7lYWZZtSBJfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6284
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Dan Williams <dan.j.williams@intel.com> writes:

[...]

> +/**
> + * pgmap_request_folios - activate an contiguous span of folios in @pgmap
> + * @pgmap: host page map for the folio array
> + * @folio: start of the folio list, all subsequent folios have same folio_size()
> + *
> + * Caller is responsible for @pgmap remaining live for the duration of
> + * this call. Caller is also responsible for not racing requests for the
> + * same folios.
> + */
> +bool pgmap_request_folios(struct dev_pagemap *pgmap, struct folio *folio,
> +			  int nr_folios)

All callers of pgmap_request_folios() I could see call this with
nr_folios == 1 and pgmap == folio_pgmap(folio). Could we remove the
redundant arguments and simplify it to
pgmap_request_folios(struct folio *folio)?

> +{
> +	struct folio *iter;
> +	int i;
> +
> +	/*
> +	 * All of the WARNs below are for catching bugs in future
> +	 * development that changes the assumptions of:
> +	 * 1/ uniform folios in @pgmap
> +	 * 2/ @pgmap death does not race this routine.
> +	 */
> +	VM_WARN_ON_ONCE(!folio_span_valid(pgmap, folio, nr_folios));
> +
> +	if (WARN_ON_ONCE(percpu_ref_is_dying(&pgmap->ref)))
> +		return false;
> +
> +	for (iter = folio_next(folio), i = 1; i < nr_folios;
> +	     iter = folio_next(folio), i++)
> +		if (WARN_ON_ONCE(folio_order(iter) != folio_order(folio)))
> +			return false;
> +
> +	for (iter = folio, i = 0; i < nr_folios; iter = folio_next(iter), i++) {
> +		folio_ref_inc(iter);
> +		if (folio_ref_count(iter) == 1)
> +			percpu_ref_tryget(&pgmap->ref);
> +	}
> +
> +	return true;
> +}
> +
> +void pgmap_release_folios(struct dev_pagemap *pgmap, struct folio *folio, int nr_folios)
> +{
> +	struct folio *iter;
> +	int i;
> +
> +	for (iter = folio, i = 0; i < nr_folios; iter = folio_next(iter), i++) {
> +		if (!put_devmap_managed_page(&iter->page))
> +			folio_put(iter);
> +		if (!folio_ref_count(iter))
> +			put_dev_pagemap(pgmap);
> +	}
> +}
> +
>  #ifdef CONFIG_FS_DAX
>  bool __put_devmap_managed_page_refs(struct page *page, int refs)
>  {
