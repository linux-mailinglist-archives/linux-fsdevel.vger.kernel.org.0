Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035C8601923
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 22:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiJQUOf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 16:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiJQUOQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:14:16 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on20616.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8d::616])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21983262A
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Oct 2022 13:13:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WnGIbvov95b4XPzb8Ev7m4Q07aCuUKYyEM0fxlsvvZ/edkgspm40YiPVXuP3bRkDOwNLQ1QGyDsOAHitWMwVE+Y2fVD6tf7toObLExbF0sUY40dfmOGFxXd3VbANBy1IH21GoMur49cbI9TH9zTYSBG+XGozVfbx0kal6ITz25HViWl0FDIzLynSnpHxDDHHDAaoqZbvNNcRAam/hBBCMohTwvG04p0M6NPG93dX9lOyzeoCbEqf7WSMvRbW851DEbH5c0foh1KT20fBY7stF1kNo9LO+h+u114a7zsNGLUy03qYWHWOIbA6rmQtsfMymMtbepEBGifCOoMCahSwSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AALkPvdfiGPakr1hseol/GRUDIkQ9GEP2CD19CanZ6I=;
 b=m9ZKBJRwRElv7dyCLkn5qxfcD2Gj1KZxINinQ4SoOh5j60Haj2ZkK9+ktTRY4tTuPXmSmvZkDjiiHTtaoNMOjpXMaeKxMVdFgkkjYY47/nssakRhZR5r8qHUKZLHK/vM2YJkzwInTduHcvuYVv0W+69BYftWtmCoyIGNVhCk0zfDeXtCHAXqRZWfauNGR1mDWLtvWISkK+TN4CfuHVnUuCJ66di+X+gk2Q89OH6LH+8VX33kkYDyEDVmjSfYZqrXXDwnHbPBKX1snj3Xp5JiAEStl8eJxkmGWHql+uIt9csXovdkHJLsy5r+JUU638AhTXEl8vAdZtcgNv/5Yu1H6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AALkPvdfiGPakr1hseol/GRUDIkQ9GEP2CD19CanZ6I=;
 b=mbGfiXHB5ACJ89pXQTg0LU3widGqlyp3THAudfPc4rJNNi/ztyQUtXjAbJ9cl3UjPniW0YnrHKWLFI8O7zp6sqQarTIXsjjlqefQ+GO2BTkrpcJZDBKFkn0xPCmEyKoIIvbrSmhDjazRq6JJ/kgQq71XqQmJEfuWhAClfKeEdT1lejwjr3jw/dVfkyt/MlFlmWaLvnj8bDJfB4fTaSMkRjEQnW76cuhaLUTMhzTwSqzygFsw2gTJpKodr2W/xSVU9YuBFmJjIAoTDdxFGibFKGBrLgeBQZIVb3lXkrTFmxuGEPIK1lfZhUAkIoc5whE3E/lnNWjgo/RJYozK6WR4uQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB6581.namprd12.prod.outlook.com (2603:10b6:8:d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Mon, 17 Oct
 2022 20:11:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 20:11:33 +0000
Date:   Mon, 17 Oct 2022 17:11:32 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>, david@fromorbit.com,
        nvdimm@lists.linux.dev, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 10/25] fsdax: Introduce pgmap_request_folios()
Message-ID: <Y0229P6z0E9Niw+9@nvidia.com>
References: <166579181584.2236710.17813547487183983273.stgit@dwillia2-xfh.jf.intel.com>
 <166579187573.2236710.10151157417629496558.stgit@dwillia2-xfh.jf.intel.com>
 <877d0z0wsl.fsf@nvidia.com>
 <634db5c1f602_4da3294c3@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <634db5c1f602_4da3294c3@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BL1PR13CA0231.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB6581:EE_
X-MS-Office365-Filtering-Correlation-Id: 07f57113-ee93-4ab3-cdd2-08dab07bc976
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AmffXZ+liUMsha8n/ZbfOc2waChSAYxeZEZg7qUMVktyYhvv0MuNWGIchI9j4oOHuWsbt8QxK/zCTRdHygbzyf6ZYuUBDDEu61Kj7Ah9w1X4qOUeZBYBLxzwS/r12NRj9iefB53m/T53ZXCpCitaNeKDgd3H/skgm52fZsHoV19jw5iQBsKgi4GMA1tLlxKeG5pKrEKuGJ1RaL3OUoN3iQaTbwcIwmTJuD+w9cxnmE7d/POSFhhoj0rFlKOIM6dbakh7tpYmGK55kf0GkSlCoQPS9d7fokdYoaUMi3hJyvsKipvXtuT5dkvuZHWmG9y2V+0EuIMMG0BMMJpSDZk6fU0tUY/aK4Z1y7g2Kj7fsR2lQtBoCan9hVJVbVGcAqRawtrdPeUpK2bqinPF4ysezeQ6S3gfbqIDvEB30G5ZAUEE/nTFnzZf+a4ge4guB5Al25nOJDt1SqnR0YQdKLf7YqhGi6zYFOR3Ja/ssW8kGDHDo+tGvD4hV2+kZeBJqZLo9lE+bENauSanaIGLozV2+0JWYZdRg/EFQJgOVD9WX8RryO/OhwYp0tawTSX8rbLUWs5s7UsIR88OG+2zW0jCSt4afkhdEFNlJhPaGNipCBfIl43I+64TniVHxf29Z6F5Z73thiqAjTxUBQyc1htjfIv8ud0DU9culMqO1Jj1CjJa0ZXKtUE2RqvDf6DvwIyX1V3iuDI+WX9NxzV11dD/trcbMVwxlw6RVfc8Lj2s4iFj26HAcz32hQ7YWDjdW1lx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199015)(38100700002)(478600001)(6486002)(6916009)(54906003)(36756003)(6506007)(41300700001)(2906002)(186003)(2616005)(316002)(66476007)(86362001)(4326008)(8676002)(66946007)(66556008)(8936002)(6512007)(7416002)(26005)(5660300002)(83380400001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x4WuTzur1lRffNq5YlRDQD6Qlc8GIfUYoaQn/jEsI6oxgJi7HJSiOAVF+8iS?=
 =?us-ascii?Q?GNC8KthqnYyuC+6HLvnUJRxVWpg0KhTS+N786LiYm0p6qRTNPIBtq1+LuY9D?=
 =?us-ascii?Q?En4TBbVe0eGIpXlvZoSjP71IdIJYyVxoSewVvA4b56FAi/Iqttpm73GdL73u?=
 =?us-ascii?Q?koNNWvF0gOSK3Mix/mdwy2xT3ZCMVvEDZhf1M9BEg3uNshhsKZftcmwuFpy3?=
 =?us-ascii?Q?Gc3PL0BmusNYG/KFCRuOd6B2ick1zy5zkvZE7iNlDZqK3L7OWav364NfXQOi?=
 =?us-ascii?Q?cCJjIEJd7BxKY7B7ap4Vx9zaDrOPZu33Tt0hSVKfnM7JrbYa/CUthJ3OFGXT?=
 =?us-ascii?Q?sJM/WbSIYUPZv7P6txQ2mwK/j4huYc/l52uYTTt8OUYCVFGRv0skQYzctr5G?=
 =?us-ascii?Q?Ub2XG5t7m35KTXq4jGn4Vv+ul9Uj5GwC3iVt2Jx+4geglRhuse3tbKYSpc79?=
 =?us-ascii?Q?ip/2L/4ba1AKvcMQF3Qrv7JvEqXQjdeKay9H5cpeptxt2nRpCQmJ+A9cm6DV?=
 =?us-ascii?Q?FX9om+Mxv7aJFH4W4pE6j3Bj+10DUDtUajzhmk4q7X82ldeZpmbO1P4In4oJ?=
 =?us-ascii?Q?GstbsGZGRWlZYwmYWE07gsIPXFXTGSH447MDvj/DKl80g+Ja+i6aLcxoKD4q?=
 =?us-ascii?Q?S+w7Voyc/BCy8W/h6OEVT3Gk+ngneRC+Vv+cQymx9Pk81h7wxUVw2H0/YK97?=
 =?us-ascii?Q?djfmz1U7pMaEmacMKyPtQ5cSMKkovMGEO1Z25t+5E54YD+75GEZePPQGSlMJ?=
 =?us-ascii?Q?xVAkyx9ndeGAriOwB4cVQneKicA3ae7iRlzg7ugDfcurlWsNb3P9cBmZw0SF?=
 =?us-ascii?Q?PToBPqp3wniP2lMS7nONwfhLP+JY+WfX9A9hZ4ui4Cfm4JCSPvlAkZjlzap8?=
 =?us-ascii?Q?x/VOkPoP5GSy9q4NwWE59ZVjvBM8mBqz99Yz37ILcUrzFEsFp1pVCwejTCg2?=
 =?us-ascii?Q?kzdEK5WZWC9ZfdSM5usI2PAdjLXiUr13j1o/M/QOE8DvXD6N9nWkbfwbklY3?=
 =?us-ascii?Q?9zr3sCxcB5XngP4GNJ9Zyobt5w9u1KWBLVttBEelPs/Hd1LBUnBDBI0/boHO?=
 =?us-ascii?Q?jyKDKA326M3pDNNQfYXLiXh1HLiAu7T5E4wMBcAOoe/PErCRJmO3g79NzF/J?=
 =?us-ascii?Q?VhA+wNb6ZYOA7To2czSXrm70GUIlmDKK5rcNhyYbqunTnYzzYlQd55fj7ip1?=
 =?us-ascii?Q?g7h1k9wUEZLQ5HDc/FeKHffvFJSxj3+9K5vfUe4DakZoV40YnVYCVHMNZa0k?=
 =?us-ascii?Q?iMkZNQdpqQS0bpbYFQ3g8IixBnChckgALZErscH0WMmK9MxbxuNt2J5EUlY/?=
 =?us-ascii?Q?rG7SX+b+HiN4t8EqcL49awChF1/O5ZwKlccCGPEatwJNJrW2bv8emcNsr34O?=
 =?us-ascii?Q?Ri+j1qHWYvVsfKFbxghzlpPHSd0yxgJq3QWpfkRk7z0zEyhnwmpS87qZi5iS?=
 =?us-ascii?Q?YfuXK55dAizOOjAoWjlinOE/ZFjp7pfbLu/NCKQKClcWoacAth4b44NCBVnI?=
 =?us-ascii?Q?i0lSJU/Q7SZpMkL3FRhuQiBqBDyUiCn5Waq1V6o2gqkox6ko/NbW0pimCzam?=
 =?us-ascii?Q?E2xL2iFH1KIQgxLwjX8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f57113-ee93-4ab3-cdd2-08dab07bc976
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 20:11:33.5068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hOladPwjsJkxnCuDGr6PMyHDUlsbh32L8Kpakmgk0/h/GTAeQShRZApYZZQG10HM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6581
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 17, 2022 at 01:06:25PM -0700, Dan Williams wrote:
> Alistair Popple wrote:
> > 
> > Dan Williams <dan.j.williams@intel.com> writes:
> > 
> > [...]
> > 
> > > +/**
> > > + * pgmap_request_folios - activate an contiguous span of folios in @pgmap
> > > + * @pgmap: host page map for the folio array
> > > + * @folio: start of the folio list, all subsequent folios have same folio_size()
> > > + *
> > > + * Caller is responsible for @pgmap remaining live for the duration of
> > > + * this call. Caller is also responsible for not racing requests for the
> > > + * same folios.
> > > + */
> > > +bool pgmap_request_folios(struct dev_pagemap *pgmap, struct folio *folio,
> > > +			  int nr_folios)
> > 
> > All callers of pgmap_request_folios() I could see call this with
> > nr_folios == 1 and pgmap == folio_pgmap(folio). Could we remove the
> > redundant arguments and simplify it to
> > pgmap_request_folios(struct folio *folio)?
> 
> The rationale for the @pgmap argument being separate is to make clear
> that the caller must assert that pgmap is alive before passing it to
> pgmap_request_folios(), and that @pgmap is constant for the span of
> folios requested.

The api is kind of weird to take in a folio - it should take in the
offset in bytes from the start of the pgmap and "create" usable
non-free folios.

A good design is that nothing has a struct folio * unless it can also
prove it has a non-zero refcount on it, and that is simply impossible
for any caller at this point.

Jason
