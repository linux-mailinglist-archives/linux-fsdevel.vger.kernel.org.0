Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04FF66017E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 21:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbiJQTlm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 15:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiJQTlk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:41:40 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6573B691AB
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Oct 2022 12:41:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOJYIeKWMpFn4twV4X3AOXDs4LVC0Y3OTHWLF9a15Unw97YifaNXNkT1MRCymrYqZWLTql7TFskdI/eeVII5UiZBZbT1cEQz7f/Du+wiGOxn+O00bdvOe3G/2RbAUsL69vEokjZYiE4oZ56TSbANxPr0CIEpiZXQSY26F4fL1ynWa3tG6DZsu6j1Ly8vuWA1fGwugjgBLNpu01EA7yzRnFgBJhWRka3s0ivAm6qW+EdPspWho3Tyb+znW6hkpb2nz9/CNewZHcQtSCRbgafKH7kPOBScr31kbKI33qsCvAE0/NPGnPymTlyejocObY1OZlA083tKgw5opit3FqG0rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OI52WrM/pjowC5LFZHWBudb8JnCXmGKGpPiPF/LSwk8=;
 b=KhpUCOB4km+v7k1uZS0iU2HzZk5kHlFcCVcIh0oK3V87acQZ2sROrO5ffEprEz+JC8pmkUSUV7uInOrniV6/MUjyLAZbSuPhSYqFmB2VoJ3/CEkVEIDirier38N07m/erxwCBJodkhvZrlHCq0V9NPbEqN8WX8psfmV2CSt1T0dnKsxY0FsXoCpIKZaOChb/k8Bl56G9nK2plsT480RKFEdWbut+/db3ubgQ7S47ysjd0Kv26o3jBK3fQPhqR6d4iyNsASWMPBCASHTJt+S6MfbsQalKfRwUERR9xbLua9TQKcDHSP3Zwk1owv+ts8/+KNWd4nOVvdPhYZqtTfiziQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OI52WrM/pjowC5LFZHWBudb8JnCXmGKGpPiPF/LSwk8=;
 b=C5kPYhFTBuSGSqwZpRZf4eHMqgn9SFW9wE0+3O7HV504plXKqv8tHcfSL0BTkMW/u/E8e12tAzbyzeJNJ641qIM++jjDJpNjQbaxRbmRdruJ0sI1VS3zrnZDIZzG3wGl4H7CBvBbrTjca9B2Bz64riubU9geH75jqyR5/xVV/I7P76oWeSwDRum37PzdcFYW+GocXCTsi+oNF/eRqH9Gn782CdrrY7CS4KMdDzieeGIq9aAYRdFtdlv7vdmtl/u5QU8l3hR21EJLFeb1ChT0Jh6Do0ZWd5wgOHJQoralIz8644uBYTnYWCyZtbgsE5xB7k76xCVz38iey1HusW+xYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB7946.namprd12.prod.outlook.com (2603:10b6:8:151::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Mon, 17 Oct
 2022 19:41:37 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 19:41:37 +0000
Date:   Mon, 17 Oct 2022 16:41:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>, david@fromorbit.com,
        nvdimm@lists.linux.dev, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 10/25] fsdax: Introduce pgmap_request_folios()
Message-ID: <Y02v7/FIh6K2JlHm@nvidia.com>
References: <166579181584.2236710.17813547487183983273.stgit@dwillia2-xfh.jf.intel.com>
 <166579187573.2236710.10151157417629496558.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166579187573.2236710.10151157417629496558.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: BLAPR03CA0095.namprd03.prod.outlook.com
 (2603:10b6:208:32a::10) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: 88ad1897-ab9c-4055-e261-08dab0779abf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xUKDo6NqbWwf5Wc08cDKWzhWn6/OARTWTwe+ZzwoZh00Qw43qFv2gRd16QLtDrQslx+ZKEmSj6I24pKH4e95vY36iZKQ6bGik0pEZSMGgqBorWt88oXN99gqPtAvGKPRgeBbi4co3X0/hMErE8xLMaZnoiHx867jmUfcGOKcWr5vb7JvuxZbH1cD+dolWELKswlUflATXhBurQpxskU3cldbTuwWqUCkMYNqMuiNRjYNnQIqJS/4TQd6wogW8XBhWY59XFqdG3m/QziVXgt0RBn6LElXu9/1yJ17iupRCvfFLTffZ5vG60EHcZ61WvrX1+7LJfAQVGfU3Em8qqy6oBay1VKcx0QJuo7KC30vizz2qflqSFLaZ1+9luBpaKyj+ec+mk1OWtbnArfBhZJWjDJhH2KkJfn+XvbKYKe+apFvTLx5dBV9F9PTbLzMIiai1CwSdXBi9QG6j3xWnWPDVhcgKxsq9+SefZErdpJ0EjRGlnRAoPowmz6MPCocQI0jo6pQry4nigPsV9AGjIibmcHU8c7QHWFI2fIiTHX7zNdJP3FJxpyAqJ14v8YLatmbL/Sz6HrohUym1Egq04dlqvT4qXZ0Doj+fGK7zETYnys0tnlHcc53BqOoAPRWf38/1plovtRsOLXmdjhogBwci9DTLRLPmYdaL6TDQBhzxxr3aZxtxl3Qk7Ap2S5+uFUKY1We58PFtBxiDbdi/qS6Cw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(451199015)(38100700002)(86362001)(6512007)(26005)(41300700001)(6506007)(6916009)(316002)(5660300002)(54906003)(8936002)(6486002)(4326008)(478600001)(36756003)(7416002)(66476007)(8676002)(66946007)(66556008)(83380400001)(186003)(2616005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OsYmngNoi17T3pDU8+fvhOtSVSJKtWoTwozPg5TJrr3dYY7AfjKIT4zUJCzE?=
 =?us-ascii?Q?2AfKRNjPrFyFfRtRMZ8LXc0x9Jal+uFdC6BAPSBqh8gAtQciKNlo1/Vof9eZ?=
 =?us-ascii?Q?/BF1kC8vBO5+TSEo8tBi30fLTeDfEFT/S/yrYiqhmRtc9fFlT5pURCYVa3NN?=
 =?us-ascii?Q?bzuz/RzEhppBfmYe38XeG8p49Zt7ZlKwawM9fNH4ncK8HvviisFUz0d2Htzo?=
 =?us-ascii?Q?adeiiY//Q/Kr7F/j/VnJy4VKdKdE4u7lCXIy7RtiKKQEpkNWvXFj7qoTjg1J?=
 =?us-ascii?Q?ivgoFE8hlteWiq86dybPc5tu2pWX8XwRqN9cJJisVLc2nBLsqUJXYVQaED+j?=
 =?us-ascii?Q?vYpzIZS5lM8r+ktev9gTviRFVPsMWWpUcQACQdA2AAUyBQmBx8t+16zCjdXw?=
 =?us-ascii?Q?yg81b+C8CMgFgIQI+8oxx9fbwQ3JjbmMIGZ3awZ4d2X4Qy3IZZwmwPWfOL4T?=
 =?us-ascii?Q?oq0h1s3TnOOdWEOnGQpTU2Xv9lfYSTooXlpeeo2GdV3IOShM0AUaci8JBnqo?=
 =?us-ascii?Q?O0jgIUr6wbUvZ6CPzxgV/3d4TQ7TDRaWcARC37dqbppgNNqq4BP8zypdTOps?=
 =?us-ascii?Q?YpvX1Ujhd+jhE1Qi8J0nwbsfCTpwHJie5MGyOpCxO+t+3w48Nn9hnzh6UgUz?=
 =?us-ascii?Q?Nor4bl4DfTc1BcxNhmV76xixVUdoMzFI9zzndevKyJBLovOa6sLlWfUorrnF?=
 =?us-ascii?Q?RJxs89zkDmLSleVy/OPjDdtFDO5juTh1cEyqfvSkco/in2PAnYxNL2Qri+hC?=
 =?us-ascii?Q?vH3JLrD8pHyjRcu9GKO0dWW8PJXdkHQoPoeTriLbWd81qupfe3w6exGxer0F?=
 =?us-ascii?Q?7lihwpDhzgGIpj3GTtzkotJZmDDFqyX7pA/r6HwEwvxLBW6BVgP7NwYjoddu?=
 =?us-ascii?Q?LpuhzqFVK5+s8ReJaSU32doY6D1B8S03qCiPwWIYbQLxjlAtGZZ8hw1i/zWq?=
 =?us-ascii?Q?bMTBXluf9ROawHywZrkllsTVdZzuKmwISV/+wfs/TJpaVED/MLAnLqnMxr7A?=
 =?us-ascii?Q?Xq7vAqurHLq2hwoIZfip17Yx1X/XNgIa07JicVcRkzkW/xP/aoe/cK8K7LRv?=
 =?us-ascii?Q?ngC+vKaEjJC9F74U7aK7EtnnTvYbwoeRS+cqaSmBliwm94hpDLulL5qeNpHs?=
 =?us-ascii?Q?s62u1I0WsPdEy9NZu6Kr3vOZW6okSA+VPFNB41OKDNIJnvMlh1d3i0m8oS44?=
 =?us-ascii?Q?PsGmAZNHAk1AMJmvKX9R9DxzGAEWWj9gcg7tV+9BbLfC+mrV8FGTIfLKd8mG?=
 =?us-ascii?Q?JcBShVF47Nw+ahg0TTH5Sz3KDh0PpjhZT8EHWKseDbQ0PPeamNtwu7O9YlEi?=
 =?us-ascii?Q?2GrjrUxnYSYsYWtKrs2w856I/VagMOryNdWqSNoJtfs6wOkwn4Biysudlvse?=
 =?us-ascii?Q?HeT7QFEAqN5xZJj7mVU0M6R5l4J0a/wN+jdran738dcC3u6lP8KWwfLnAGvh?=
 =?us-ascii?Q?LwzZT3sRJwSQi7NRVHXQ70CEpHtn3bBApXxommqxeS9haKgM89PdbN2xddfF?=
 =?us-ascii?Q?M3NBOno+o/UR99UuwIP4kgCk1bnS8X/tNwrGFFZc/znfvo1UUGM2TtHz+w64?=
 =?us-ascii?Q?ULaTUrFDEydl/7Ni2BY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ad1897-ab9c-4055-e261-08dab0779abf
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 19:41:37.1615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rw4lCxNv/unCL9iCPE9Brd9EgK82eFdC98G/G15kPMjJuiqbuOVlsBMTd7QZH42h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7946
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 14, 2022 at 04:57:55PM -0700, Dan Williams wrote:

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

This seems strange, I would say if the folio doesn't have 0 ref at
this point it is a caller bug. The caller should only be able to
"request" folios once.

Ie the caller should not attempt to request a folio until it has been
released back via free page.

From a FS viewpoint this makes sense as if we establish a new inode
then those pages under the inode had better be currently exclusive to
the inode, or we have some rouge entity touching them.

As is, this looks racy because if you assume transient refs are now
allowed then their could be a 2->1 transition immediately after
ref_inc.

Having a release operation seems unworkable for a refcounted structure:

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

As if we don't have a 0 refcount here (eg due to transient external
page ref) we have now lost the put_dev_pagemap()

Jason
