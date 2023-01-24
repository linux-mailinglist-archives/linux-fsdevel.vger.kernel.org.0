Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D446798F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 14:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbjAXNNg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 08:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjAXNNf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:13:35 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BEC10ABF;
        Tue, 24 Jan 2023 05:13:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqv2HitQLl395vx9gd6CVRaCFHquhAgAC3RbyReWBDUsiz8R7ZNrlzYav8uHkbzK5KWtlhXzEpHYoeY4B3EJNyBGqoxpcPADgc8X4sV/qbyeZ2pFtfBavPjuW1uadscnnvX16PZzPsg/I8wG0EYgqP3U6gxJAr2UpdCtGe4zo6FYLA3C29TKX+LkMeQMhwQuDoGc6negJySkcqfHU8uXWLdJ4FgSrqWKv3wKjEZeFbBOgckQJoHuMm2Xhjpy8Mkuez2/9P/7O1uPdOaeWefvl6l08LIh2bTUCUdrzXqQZHxNKXi5+45LQqORVj+Aa8twu0i23pTm7yItjKDmTX5IKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7AFiIKvs3dGcAeesK0KyqFcg+WQPNa+62uCpGmG1Xt4=;
 b=AQcOjVbcXKSPh1vvpC8Y+JlVyowASRgk0LhBo2mZBcwFkz54An2yUepqyALR7oxA+tlhYSVvKZl/81KYMZ/uBBP76Zwj/v1Od1//jfVkdGOf9rJsmk22CmlWJG2LAzRQFndP4+ekD83otRwvv3ElX6EqFDyZwWXIaX1Jq0Olb4N4MzmsyvTpNFbYYtj+UxIz74A0NVvlbnnCriy8Ol+hsZVewI/JXVSL1PNSKbFkuBkbyqQPtPWJcGSCZpDnmYlwgx7wcb132k3XSQy5H2/x2Q1FHws/pAPhkA68WvCvMl95qgyyff+OyiYqCc2xWnjv50GZAW87gSmhp5LjJ3MdvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7AFiIKvs3dGcAeesK0KyqFcg+WQPNa+62uCpGmG1Xt4=;
 b=Rr/BzCPYuvAOQASttvuEys6C3Ft6v1bFl7KwbCl5vDil8yaz19zMlPqohF3Ba0AodSuH1HeKgxsvOjFiUdaG3wbicx+n/Q4prJt/3MEXPhFr5x3X2QQkzHSOXNbPpaUnubqFP8ReeJKurZGKtCnJJPh47RIKjK+Ay5vVi0meP0mC0nX0sR4zsdPHA6w7B6aIdGDf1D3yyN6sMIzcUvjh+qdMaElSDiRFA4CjQXPo3mCq3j7ICyQ/YHSAuyQZ/i1EZfADXAYglSgEMaqtgSxUiPzjfK6eZyKpQXsASkodO0XXTxzf1GfBMPI9D9vzQd0Gp4eV4ht3KEN5jYsdFtzIOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB8422.namprd12.prod.outlook.com (2603:10b6:208:3de::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 13:13:31 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 13:13:31 +0000
Date:   Tue, 24 Jan 2023 09:13:30 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     David Howells <dhowells@redhat.com>,
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
Message-ID: <Y8/ZekMEAfi8VeFl@nvidia.com>
References: <20230123173007.325544-1-dhowells@redhat.com>
 <20230123173007.325544-11-dhowells@redhat.com>
 <31f7d71d-0eb9-2250-78c0-2e8f31023c66@nvidia.com>
 <84721e8d-d40e-617c-b75e-ead51c3e1edf@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84721e8d-d40e-617c-b75e-ead51c3e1edf@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0290.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: f769b227-2f89-494c-cdd5-08dafe0cca69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EH6CbEseD75TPzFfM/G1F0e5kdSQp6Q6eg0/mUPlLgLAEnkHmX54VVIx/CdoJF0cO+UTk7PbjTO6BnncaHqx4fMWZWKIFiABz6OiW/EIfRDFO+7i7rV5gLFB0c/9dZ7aTRwoqjWX5el+3TZYP/UDuzM+4N03mdZUgYzM9K2mXIBoFAaw/YqSczTjtUmVrn0g3qBiu/RI+XKv9guQZhen2ABbJYYQkHzrpEvZWxqet5nVYo5y+cg2HqnNNABdsN2Wq5//BewdWctsn4w/M7YZ/jspxbOboCjhjhsZkYdfxkXWFhi/cI1pdmd11k0p7FS/TaBe19ORjrxxcZALKubOc8ibIxZEn1LBel4JiYiaRi6aCFfSVtmtpMY9T8KzPoNzfQ05qOUi8ig6z81qoNZRaNNnYQh3vKABtFQktUPaJ0fJp177figIHfV3dy7i/Lf1vRBckIvWi8TciJ75XoviHr2uaBnDV7pPJ+qkfnvKNYYqGl7f2Vjc5UFliPB57KRS0Ffijsuz/AGIrunVxpwE7/sB+ajtx4UtZe+ZDs14701mm3VerXcTg6zRvCKMySJewgxlWMYDIMo6eVXed4XVwWpCeRL82cgCNRhgX+OSXHPd6XCPHF2PTcSSlERK+shiXAyi4rqZbvqfuTqE9ZRP3TIFmvonQoYV1ar41qQ8kBWNhcef0bz4Y9fpEC5EVXypkPazborCVFy5jcNwLHTMNAkwF9nV2iPPfHxr1bVOqCY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199015)(54906003)(6486002)(66476007)(4326008)(66946007)(966005)(66556008)(8676002)(2616005)(37006003)(26005)(41300700001)(8936002)(186003)(6512007)(7416002)(5660300002)(83380400001)(6862004)(6506007)(53546011)(2906002)(38100700002)(316002)(478600001)(6636002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RaCSqPvhO8Cb1+dzHBtJHQa5CJLTlQm3XhG8BGgEqxwq0uD6qQjeM6MC/tGK?=
 =?us-ascii?Q?VxChK21aqTBN6keoAm4kGwqfE4e0doZjsHKytx3zfvSbFeyPM+zas6D9/KLV?=
 =?us-ascii?Q?/H8KK6DERwEcWLcYWPYJCukNYoH+TwsbOp04bCu5G2dXoAf2Qggp6QUJbGW4?=
 =?us-ascii?Q?5FJ+FXx8Y+JUhtbAf2ueXGn6H5ANNHLuq/TRn/4qUvW3HW6G+nzF/WvU+M5H?=
 =?us-ascii?Q?4dqEEwA/Sg1Lclh6gc+4ozRT5o8jQs7bvjkl/zDuckmDtfAJI/FWPr0kjER/?=
 =?us-ascii?Q?xBWa3C9SYiNI3NQ+wA8wVBgyUFe+4hAxO9FXBVianGplwaHKc1sn5eO+78Zt?=
 =?us-ascii?Q?ANMaYOJajTK6dYnomb3QWiBWq1xEQYlmC5S28I0nzOz8LNPkz5kUl1mL9/uJ?=
 =?us-ascii?Q?OYMuN1eb1Urk2nBLk5e1k5UV/w+2LajfC1gzZyDYKBHsHVPfcT2w2seeVk1l?=
 =?us-ascii?Q?XHH0wZZHZYeq0WhnW+BlpraDSTLgquUXeb/ukvjLJEkyL5Oa95zm9JSqISBZ?=
 =?us-ascii?Q?DEBFxPz6jY/lVWDBnd/CR9sP+wNSUk9eKl0oVPzoKfxY9V58ZC+Vn480iD9J?=
 =?us-ascii?Q?LdgGXRiBrowu5oZsl6wWyUu3/oOkoH3m8cWHXp9rXsYoIQiAqMF129xlvXdv?=
 =?us-ascii?Q?S0IjH1gsVKG8xMnQUScNzXtBzVCEQxUWV1T6GElhomCGwMp1Ihq5saCLh9Yp?=
 =?us-ascii?Q?96KXHkL9Vj0cDpBFdmR2ewhWymDoV2lnsVLAJ0I8nojBac8krM1uqSBZAZij?=
 =?us-ascii?Q?rf3EVlc3y53AtSV4uzmRafNMptQAxmN9itK5oxuGNGNs6QaVnZqYvYBCJsCt?=
 =?us-ascii?Q?Dkg0EON7wU1YTyP1wOea0NPBSIvSx9HwkagY/yQ99VSFuSWvNla0KzzD389a?=
 =?us-ascii?Q?xShYZQxE23pnG/SRYUoZu/0/mmA4uBU6BXnITty+hZlwdUhbxbVBl6zCg6pu?=
 =?us-ascii?Q?cjfXhTsFLRVzyCkyAh6CqH0NBNy12gmderVqEE9+rC6Mejdj64LrkaNnuVk6?=
 =?us-ascii?Q?RhceHbyO4G8F9oeT33LXmha6plt8f6p9J4cBcCUdLf6vg2u/HqfYNPQz86pq?=
 =?us-ascii?Q?/ZIe83/plNByJEoMV2P7lMALg+GWub5WW/k0jKrrM7OO6qER3gfYfR7Avl7g?=
 =?us-ascii?Q?ZOReKMSmGf0X83zsi+fLlFBy4uvBAW7z/f2UYTr7+soCnJUhB4FHKuB067yZ?=
 =?us-ascii?Q?ybHO10JrWCJ1iN54EUpuj4+yxhB4FjYYMD/eWoamvk/CwAEDJ0aCNCQHCr77?=
 =?us-ascii?Q?wrJzgGwSaeYl3NFEM/Rz63Lv8UWTydwh8t5B6lOVOgTitWzm+lvkCAQ3sjX+?=
 =?us-ascii?Q?+J93vKgQ3qukl3TZ7gbwshsL054wcMqU+GG4N3NljVaiMj4jVMYmRl2XNZf5?=
 =?us-ascii?Q?TbxsXOKkRJldjUOn3FHnfvVfYt/HpNx93Gl17ipG9yqR6CisKPydLHGk8+hV?=
 =?us-ascii?Q?i26nY45NcdpYsiqz+TO0UO2uouer9eCJXWC7Dy1c7DHEM0j6geujad8LJUG0?=
 =?us-ascii?Q?8utKe/5x8MRID4LnP5jGoQMsz9uhBjUi6JKGFzha3NnQG0DxoURaUAqxSvET?=
 =?us-ascii?Q?WnLe8lKTClL8txH8RYBEe6kxEQGAwYa99jT4046w?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f769b227-2f89-494c-cdd5-08dafe0cca69
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 13:13:31.6591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bXoMfrXIXUWgNJmlnNiPGkMIK1rPgChf5Ghcs23vfeYRMm78tisiSsFSztHDet8p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8422
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 23, 2023 at 07:11:42PM -0800, John Hubbard wrote:
> On 1/23/23 19:08, John Hubbard wrote:
> > On 1/23/23 09:30, David Howells wrote:
> > > Renumber FOLL_PIN and FOLL_GET down to bit 0 and 1 respectively so that
> > > they are coincidentally the same as BIO_PAGE_PINNED and BIO_PAGE_REFFED and
> > > also so that they can be stored in the bottom two bits of a page pointer
> > > (something I'm looking at for zerocopy socket fragments).
> > > 
> > > (Note that BIO_PAGE_REFFED should probably be got rid of at some point,
> > > hence why FOLL_PIN is at 0.)
> > > 
> > > Also renumber down the other FOLL_* flags to close the gaps.
> > 
> > Should we also get these sorted into internal-to-mm and public sets?
> > Because Jason (+Cc) again was about to split them apart into
> > mm/internal.h [1] and that might make that a little cleaner.
> 
> I see that I omitted both Jason's Cc and the reference, so I'll resend.
> Sorry for the extra noise.
> 
> [1] https://lore.kernel.org/all/fcdb3294-3740-a0e0-b115-12842eb0696d@nvidia.com/

Yeah, I already wrote a similar patch, using the 1<< notation, 
splitting the internal/external, and rebasing on the move to
mm_types.. I can certainly drop that patch if we'd rather do this.

Though, I'm not so keen on using FOLL_ internal flags inside the block
layer.. Can you stick with the BIO versions of these?

Jason
