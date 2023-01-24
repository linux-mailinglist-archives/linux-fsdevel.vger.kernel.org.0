Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12B3679CE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 16:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbjAXPG5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 10:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbjAXPG4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 10:06:56 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E94458B2;
        Tue, 24 Jan 2023 07:06:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZ3YDvQ9Yv6X0kBOEIoB6RVVv9WpECpnBni61YdXLK5DCpkm39Puec8A5/CPFWyD8i/kjFu/T2Pyh/2gOIb46VTKGaUCyQxY2yZE94DvBbGtV6vQ9iohE5dvqycEPSwlHZjIYLC4svCmKWhh9kosammu7ZMwRyYLJDhKJWNRO/IjS3255TyGXq6b3q/zGXj16XFIfL8QLCKH5vr/J9pSDU1+1lufdEHXvy7NL2+bguITdEjW0mZsjkps7ldYoE/G8aNbp1nLZM1O7hZ16Tqwk4EwrAN0WK3irDnv5ZFYTJvM2Zr2XroUPLW9slUckzsmExOiMJ+rGXGbkqYpxE+L1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzVs4MXVe2Mozf8Np2zvMWZl1pOLw1fmLFhqeZWzxeM=;
 b=e+q+J1nC2xHpQuOX9U71d3hLIPUCLdRGvyADusCgXEOZM9yhxCO4pYC5Dpaxrn0UibqPrRnsfZVywvvzNpWwtqWKlG43/dsoMDidHPAE3tNnLnIprwZPBWvyF5S7sL8iWkYPHufxYn30wQhOv5PuFMdDjRs9wmILj7sfxidYGHFg5yQjQPSs7gfUzFGrdy6oOk4xYj9VRjgi/DzHVUfHiUXyRqSASm8nNTbYdIRwKzuReZAEw8y0nKOtaXERtPw9SlFOKDUox1r3MJyp0L5ca4Uq6hwUgISjg5PF8oweXfDGaH8JNI1qIZgd6wQKSne1Tz8l7wG/d7Kf73yErTME4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzVs4MXVe2Mozf8Np2zvMWZl1pOLw1fmLFhqeZWzxeM=;
 b=kYDcWZUsGA+fEGwxQYCHnZ/tFqL41dp9nF2Inwq01WMDLJkW2eT9UuUWWcXQMCTEeoMfGwC3K1zZA1cWuVVIGw8cwIaPqAz2/Gw8MsMhTimEVvZQAKNyH4g/Nf9Fzj7rIk8Agsm75FOfOr1JeLF3SlQz1nVcIxYGu7C7MRoFMhaLQ5wtw2c1Ap0tDBY7FIHEecMU6hobICZ32VrEZEDFBvH1e8tsqk3W7DpohCJ+Uh1N9zfusoyNR3QX4gk9UwN3e5Q3dn/zQZpQZR3AVgLp8bU4CA04Ke7YgCPxeQy7wi3Bep4qU3aA1wOvtbsATxTNqhlNjyesvdxuOoAa45IewQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB5768.namprd12.prod.outlook.com (2603:10b6:8:77::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 15:06:50 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 15:06:50 +0000
Date:   Tue, 24 Jan 2023 11:06:49 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     David Howells <dhowells@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-mm@kvack.org
Subject: Re: [PATCH v8 10/10] mm: Renumber FOLL_PIN and FOLL_GET down
Message-ID: <Y8/0CaBzL0VPyE2D@nvidia.com>
References: <Y8/ZekMEAfi8VeFl@nvidia.com>
 <20230123173007.325544-1-dhowells@redhat.com>
 <20230123173007.325544-11-dhowells@redhat.com>
 <31f7d71d-0eb9-2250-78c0-2e8f31023c66@nvidia.com>
 <84721e8d-d40e-617c-b75e-ead51c3e1edf@nvidia.com>
 <852117.1674567983@warthog.procyon.org.uk>
 <852914.1674568628@warthog.procyon.org.uk>
 <859142.1674569510@warthog.procyon.org.uk>
 <864109.1674570473@warthog.procyon.org.uk>
 <875206.1674572365@warthog.procyon.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875206.1674572365@warthog.procyon.org.uk>
X-ClientProxiedBy: MN2PR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:208:d4::43) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB5768:EE_
X-MS-Office365-Filtering-Correlation-Id: cb7f38c8-a126-4089-5e58-08dafe1c9ea2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VVyXofzPs49DZVB44Rq+RTI6PfudQ0TFjS4dMorBUImrNK24B45gPDmNMOKxQa+c8WJfwJi65cUWKvRuBAtiaYj8Qf4jKdS/3oJeJJrAeoHh/XP9TPlRMallobZ2ECPz58+i5NWSYmBUAnE2Ikb33YV7487wxUZ8CLlE2bjwVfg19bdv7TAks3LrF9YM8PTZwrtan4dQo7LicVnpD5nnaJMkKjmjEbTXEbtWkzLTmgcXcRbwCGcWW8MQRVylqWx1+lzmzSXmgP44rU787pGNfniS8erVLXzHkdSiocliUCDZ6sqr853zXhsLuBALExjqbeEBgJBldDshl4HInR+XaNAm9VEZUn3QsebvU2wpWu+oclqADgXQLV+nUQD76WyWDRD78qtdJ8zvKWcWXrdIzux1+zJ3Rz63lnUTr2FxMPxo5HXkiMZQc9afouwqxxjSdqpQviYexDVFw5V4t8iKIevKLAKxyg7Tk9vO2pqguS6KqBiQ/3L9DpKRB0Mf9h9NbsKlRa3uX8XRiijfli9Hay6aoEaWk4Uu8IzqxqHAg/R9pFDzUMCPQFjRdavxiKNGQ8PoAcwmZvwLXz4ofjk+Xri/Kv1GLIwyCvsmWAgOipzSf0l3BovFvTWKwHt+YDkgusEI/sxAIS2ZvXXXHpXHxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199015)(36756003)(41300700001)(86362001)(7416002)(8936002)(5660300002)(4326008)(2906002)(83380400001)(38100700002)(6486002)(478600001)(66946007)(6512007)(6916009)(26005)(6506007)(186003)(8676002)(316002)(54906003)(2616005)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VC9ImlOQ4yEUZ7/ps7cAbMw6yJzp1lxKeM88Rw8LYYpGE5WXYukIsDEc5aCT?=
 =?us-ascii?Q?iPJsrE3yy2a/r3L88cqyS0VfCNSQJ0M9jbsioUSPfY8717z7AO0xJ4BtawqB?=
 =?us-ascii?Q?Dx/m7ckd+9L9DIjGDMfWOWII9/OYuYdF0qRv9jFrdAE2vR8w0IRVzB1Mvhyy?=
 =?us-ascii?Q?iL36CodOJJn3VeprwxN+t3rrfLS1FZ+MblFNFVJxcx+A++mLXWgNYD4bw+M9?=
 =?us-ascii?Q?1DUn6uZrbLn3e3SG2BZVMIAp1W1Nf4EYwFCs3zNs3gAprFGsBRLFhcZSh/0Q?=
 =?us-ascii?Q?QxudCjVUlcwZv5TOoA5RsFfAnrJ+WZ1pIiaRkBGd5mqqhCJUVk8zwW+BrGLX?=
 =?us-ascii?Q?iPZ0XQYL4FCc7EJX8UMsEeSKHrpeg2RzdwumX028DJ1GhIb1zqIOuXaUGwSx?=
 =?us-ascii?Q?i7Uak7tiEaXdSCAfyZZRl1BanMEa+ljRHlswZkf4Mrr2gMvVjtUKicjNzx5F?=
 =?us-ascii?Q?2TFiVM87rmV3kuIhZEkumn05/oo1WAc+MoXXyUikCXKkP4lDd/Z9bTZs5bfu?=
 =?us-ascii?Q?ThYJOfc9As6nNZ21ujm14m6s60SAox3FOTvx+rAZu60v7ZqPb0FqnH+0ouJi?=
 =?us-ascii?Q?W55THvzajxNgAvA7qf80hRRgEuOlL1I4YN/KGkd2r+6A7IosB2fBowrAYeqj?=
 =?us-ascii?Q?sSDlh77bJgGBtktb/dwqBtJXY8bRQ2hOU9ZAJxl89G/11A0Hus0k2aZzqjDx?=
 =?us-ascii?Q?KGn6Ohs8GkxnbJieyhvmQoXGnu3ri+zYrRrW0Vqd7HVGpfsnPHk2YjqUAdwB?=
 =?us-ascii?Q?q21O7zLCu3EGtIPR3DkUqNgIoEmuMRrRd2d1rcLgo/3bEnE8MeSK9nAEwarx?=
 =?us-ascii?Q?pnHPyW3ogkXZouwzqrOZFPk6mydA4tWXtrN6DHGuA/8RXS+reOcCAgySMlgo?=
 =?us-ascii?Q?YXMWYioZHcPpYsSNNieDijqmvwjPCePRHpkB9eVK+ehO45gSPx9kLI3CBkrD?=
 =?us-ascii?Q?cyCUxGVjhMlgxPbSHxAO5dJBRcZkMAdY9fuoH6giMd7OAbKS4XrgJM/fFJ5F?=
 =?us-ascii?Q?oj+dWkX0uHE5zXT3+5QtnGLDzyJZOtFFEocUSP9DjXLCj1UVU24RqcyUnLVu?=
 =?us-ascii?Q?Bau9f8filcuNtpIfvufc1LKKGsIAHhAhDOdGRULd/UY4ltg0DAbFDaDWJhCv?=
 =?us-ascii?Q?ITzyJfS2bxPsjmVcQSEi97c9NMz3q6+MaYbqUcTqQliGmz2RgKiDxlWw2Uxo?=
 =?us-ascii?Q?WMS3oYLiMvfTbhsAkrTtS4zM7VvHhFujNHX6nKSW+CvSvWWGo8082Heph0tS?=
 =?us-ascii?Q?XBMzJHP858TDqA5I3FApT5e2jBzPK85+MegjgygOXgRICpANBz/XWcH1yXV+?=
 =?us-ascii?Q?7HqJGa9LZ9eqpIu+FzvMTEqYSo19poLu4P9wqwFUddr2iye4jN9gvltLGd36?=
 =?us-ascii?Q?G59CaUusWJdZU9hn8wVOPHTi+4njbYimMk3YznwH3it0rmGKj6/cap1oHIpW?=
 =?us-ascii?Q?qmZSFeGHXBJjKdOQl7xYxX/+TKtT0YXZQ2dwTfZ9bPuSabClEbU2qyTL8jXu?=
 =?us-ascii?Q?S6pKXS1BumwTKJbUJp1PRUCN+CKjyHYIYdKtSpDT6f3krl1cD3TkJH5vim6l?=
 =?us-ascii?Q?/MWpfdcoF8PhtpOM5TWdw0+hffWV6cxJSUB1g5Y2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb7f38c8-a126-4089-5e58-08dafe1c9ea2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 15:06:50.2073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A+q/TnHc21MgIu0dQopiLDOYDlYMT9RENpCGqsCO8PK5M1dEZREpTLeiAk6jtJdi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5768
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 24, 2023 at 02:59:25PM +0000, David Howells wrote:
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > What is the 3rd state?
> 
> Consider a network filesystem message generated for a direct I/O that the
> network filesystem does zerocopy on.  You may have an sk_buff that has
> fragments from one or more of three different sources:
> 
>  (1) Fragments consisting of specifically allocated pages, such as the
>      IP/UDP/TCP headers that have refs taken on them.
> 
>  (2) Fragments consisting of zerocopy kernel buffers that has neither refs nor
>      pins belonging to the sk_buff.
> 
>      iov_iter_extract_pages() will not take pins when extracting from, say, an
>      XARRAY-type or KVEC-type iterator.  iov_iter_extract_mode() will return
>      0.
> 
>  (3) Fragments consisting of zerocopy user buffers that have pins taken on
>      them belonging to the sk_buff.
> 
>      iov_iter_extract_pages() will take pins when extracting from, say, a
>      UBUF-type or IOVEC-type iterator.  iov_iter_extract_mode() will return
>      FOLL_PIN (at the moment).
> 
> So you have three states: Ref'd, pinned and no-retention.

Isn't that this:

if (cleanup_flags & PAGE_CLEANUP_NEEDED)
   gup_put_folio(folio, 1, cleanup_flags & PAGE_CLEANUP_UNPIN)


?

Three states - decr get, decr pinned, do nothing?

Jason
