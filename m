Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8945A6017B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 21:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiJQTcc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 15:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbiJQTcK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:32:10 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4022676970
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Oct 2022 12:31:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vhzg3Q+LbzlPDKnry8al4eGFJ6o3Qx+mp0qHlKjbfNUkkY8zqE3W5hPJoZEBhooPMSpu16JROaucIShgdOLcf1QytJa/DHSeUJTY1L/ZVw1D8hpG4zIfbZfp1NOwQfkSRoBFEsN6ZX1N6BF3bDCaDWzSkReTqD3V/JKN5eHQ5WxNwLBNgOOlP9fPfSdJH8fw2XrkaVESUIWyL7Gnsu7faF9B7uTDFl4LbhHloifpOYzMJ5nxplZEOnfEwqk+/TwLvN1Md5DE0OLzVMZ68JvTUpmCI7xFYHfIx8echLYksg01CL+zUKRpilhbAqLDQTk0hY0VocN7L/4Ijh0fhQrWIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1R4SEcX/NTGM+iEH3JVhYm4vd3kW9CTmvMj0YkYRPU=;
 b=fIINjK7SYHcn1x1ZIqVwyy9AD5MGYHM6JzrdN5a1WkcqPr1AwzVY/f0kCltLiQ8W9KmHR/3TvxMY9+EYAg0QvY5bzjcNesMXTGBkudPY0DgQf5wHKHvWH9827qkn0XlXebpJ0HtzGHDIGIpcECfbn3wIgWu/XTt/FY9yQS0Fdal7anySEC5wt03tBf9Fawx01AMH2fq4QCABXLfWtfG2tX+sqovC2+SIWmdHmCXGRHOQKe8bbb1Xg8xbc3BQIFVesAlQDLydffWzCVNY0vDYgq9lJiaCF/nbfuwYg9ZcHtMGx2gVH3H0zn92A2QgX2dN+TrOToxwdTqSFdOuYVpS0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1R4SEcX/NTGM+iEH3JVhYm4vd3kW9CTmvMj0YkYRPU=;
 b=dpFv+/F1pGK8fn9YFMayIrg4hf7wb3qH9Cl5e6PAGZy4Ia7OayLFTWG3RQeFnJjG8FquPd0veZlIWPKUSmmfojJygVqnK1szSmY1Dl3vg6XNps7lO2lRfwmKapfE0T8do1dunJE/678k1WqTIRzRdBSci7BdZ9Luao+zNqXL8ewXzxGd4ZukWOZEm6LhbPpI4gu8Jt+QuEthWH6DjdTH6fdq+QRQoeFav6tF6kIYsYwxhQ7THrgx72dmKcblA4liGVmBO4yFGTGL1dgYUzTTnWO9Oihg6a27WrIrP9PpILUd4EiUsPAFzyYfr0UPR/Lgc8IXp6YNlgLdqlGwZARNEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB7232.namprd12.prod.outlook.com (2603:10b6:510:224::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.31; Mon, 17 Oct
 2022 19:31:43 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 19:31:43 +0000
Date:   Mon, 17 Oct 2022 16:31:42 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>, david@fromorbit.com,
        nvdimm@lists.linux.dev, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 07/25] fsdax: Hold dax lock over mapping insertion
Message-ID: <Y02tnrZXxm+NzWVK@nvidia.com>
References: <166579181584.2236710.17813547487183983273.stgit@dwillia2-xfh.jf.intel.com>
 <166579185727.2236710.8711235794537270051.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166579185727.2236710.8711235794537270051.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: BL1PR13CA0363.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::8) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB7232:EE_
X-MS-Office365-Filtering-Correlation-Id: d11e3262-aa7f-42bc-040a-08dab0763909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OcwAi7s0f/WmmhSLhzqMeMH8vDnxz1f+Vb2escwc453/17fpjOhdcvxLAwNfPoP/J4WTxCBpiIpPE6m34xrKzLVZrixA78IxEd1HjQpCRE4D186ld7XecFSGeq5ZnqRlbS/56kx02HujtcN5Ws70leUx9jm4thgg1JCAXOQQuGPvcK+hJFBWDDQkGDpKj11LsTqFGTuFfgN7vIyLIVGdqNztU6zyFCdutRkrRY8yVTnM5+CudFZBBFKvig6neOMv6kWmSgyRIG2hOx9GwXfHKvhIDLFctIIQtWKe7gNcHfqop0CgtiJJNc+qAa6AbUBmfNpqzOtxNNym0vImst5dnz4+68X1vE5Bl5fQSuz4m4d1wcuvPHCgSzP9SR8pZlsTzTX8tMTjZkQfNfDY5LJ/8PFlcYqxJxHeTgNv2CAUl26jSgwEuTRJDnVol0dGKXdlXZuMQ//cspa7fhjukVXtliuyWiR11/wbFqMsd3Z5osw2z+/RofAT0RJ29j0ah+bjFGk1HDFulekU2n7JvYrn0BqqYBiSRht2b17rW+8ONEeqjOthciPlwZqjMuZ4oLt4F7NoPcbq56uSREyZIlVq7/fxBzMG7l2S6mgqJUxO7GZmXTTNmzsnrTrFLHiyMmuqMmOFSYhwAG7TuHYB1XjuVG0mnwxS6WV0v/AduDF7gwZgrlfdZ+jZNTLQMNELImG+fAud7bfoIJsvRPbXjK+G3N3fnLZrMul5pnn28DIvz2APzH4or8nEib/tXHDLRnv/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199015)(36756003)(86362001)(2906002)(4744005)(8936002)(7416002)(5660300002)(66946007)(66476007)(41300700001)(66556008)(4326008)(8676002)(316002)(83380400001)(6486002)(54906003)(186003)(6916009)(38100700002)(2616005)(6512007)(6506007)(26005)(478600001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lniN+3uN/3adCGu/YK+943lsSpy4U65eIxHMdEuA5KXR1zzTJ+FdLoQK2tC1?=
 =?us-ascii?Q?d7PitV2skuYNoJWU34eLTK4opeaEOKZEJfs6+WSALxDb2sYVUeMKNLefEKlH?=
 =?us-ascii?Q?7NML18wv9ecmyoIzsIB7eOckEjmJOA2iGtU9SHGBRBEf9zDqXtx4jJd3I/aJ?=
 =?us-ascii?Q?ZfcNBmzpHtz3ux/8wNAtWkT4RDFTYDV5zxIQ8KRWYFGZc4UYEY0qPloB4vQA?=
 =?us-ascii?Q?YfmgmY9FZm7imqkSG5pDrzOomqx4zS07XHCU52OtvzoTFwLYU2Pm7O7EFuNA?=
 =?us-ascii?Q?rMWDFehOochJeB/0jyswrWG5M+MPNXv4+oBSf28fkFOb3351pWUl4k/OZ98o?=
 =?us-ascii?Q?QRocWCg1kfN1dReKpcWt3wB5W+i3h3YImjK4asUFtPKMYtv5Tvys5nE+R3iR?=
 =?us-ascii?Q?hPcD3c2IamsmERza4FfqVccP5wGFk0KjbI7H5FZUErR2fcsuo/KpuqsWWu+k?=
 =?us-ascii?Q?z6exM8A/BgWDvNy1E41IbOkS+yk/XDcj7kJa1XSZgJv6g+f+tjHUxKXAFXMi?=
 =?us-ascii?Q?IIbGGeiNwLHX99tT7MMoxxx9jN8OYcnfBgq08qmejwAFR7BBFH01UyqQQz/A?=
 =?us-ascii?Q?JFxCMN2yCKJSbfOsxbXOtWratNe5QKQoR/3QvhtxBOdPSs4AthKDkFkknYsy?=
 =?us-ascii?Q?Yco8EL/DeFz51jgtAB039dnKrkfQ9QHpN+YOwd0smwtFBcGSXNC7n2CB7aU1?=
 =?us-ascii?Q?SWpPxUIdYsmJdLADmN6LnSyyIqt/YZjx6gOCb280KT4p9z4KghTW+v56iydr?=
 =?us-ascii?Q?eU23Jn4rqsDa5ZcDmkI/YEBpFKbBypyZYSIRatMQSKVhulIEGhYz3uTdreFO?=
 =?us-ascii?Q?vZrf2DvJ7MVyUdNgkpSfuaQZElwGW1O0DLkJvdCkM0MFwQoOl6L6ZJjmz1MY?=
 =?us-ascii?Q?EnFpi7g/72qxIpGew/Gu4E6/w3XZxESEQqBYiT3i5uoVClKrdwp/UGkdsWei?=
 =?us-ascii?Q?VhvVOL66rK63YnY8+UR/EUL9ElyOTLR9In7BXcHfK9LQv41YzGZT2zO354E7?=
 =?us-ascii?Q?Q0pnMlRs70e7grjJq03k/gUGVn8PWcU8tlPHH5xeBgdlv4FYySynZ8zoMYiG?=
 =?us-ascii?Q?WYrp3rek/3pW3i/hPVmS6BBonyFntPeolmNR/8+8OTvAe0VCecxCPe85Wh3P?=
 =?us-ascii?Q?vHVcxfZxgcmIHqyAM9RZjU9dCD3T5gOcVdPxL78q6qcyQRfB+0AyBs4tQ9aE?=
 =?us-ascii?Q?AE2Nt2Cdn/6akurQoUH10KCQwADYo5qxTdkvM++zWUx/5OE5kftY0xfHs1Y1?=
 =?us-ascii?Q?aleNU+bqQNVHzCrwprcFK44H3wHggnAAYDyz8SzYWIEtSrX2OAihUNcnI0BA?=
 =?us-ascii?Q?ZZxSD4HxaRRMr7NE99nCmxTeqJa1O0e00hFQDWagsTG8SwgSGmOhM2LEnFmQ?=
 =?us-ascii?Q?Cbf2w9QahvBn/soRGHQkwFmY6wR+wzg3xeLolKsUBS6BacyWvlLojFlQXKHQ?=
 =?us-ascii?Q?vrj78XVFQo6GGs9Odeyea8hC4KTFkpHCkeREkmRikDuuE/3/rjQWvznPJxZG?=
 =?us-ascii?Q?E/mbTC1xL75BLmo3NN5GLRsfK7Y23BzCuyOdwwUIoqjiSvezZz6vgXU31NXr?=
 =?us-ascii?Q?wq4JBDIOOKcx3tUiwew=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d11e3262-aa7f-42bc-040a-08dab0763909
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 19:31:43.7274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ko+LWsCOO8qr4GSmWkoT0KHPljm9jQDn8/vBOXw93JSpcTXbkyHAHicQl5owwGSJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7232
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 14, 2022 at 04:57:37PM -0700, Dan Williams wrote:
> In preparation for dax_insert_entry() to start taking page and pgmap
> references ensure that page->pgmap is valid by holding the
> dax_read_lock() over both dax_direct_access() and dax_insert_entry().
> 
> I.e. the code that wants to elevate the reference count of a pgmap page
> from 0 -> 1 must ensure that the pgmap is not exiting and will not start
> exiting until the proper references have been taken.

I'm surprised we can have a vmfault while the pgmap is exiting?

Shouldn't the FS have torn down all the inodes before it starts
killing the pgmap?

And since tearing down all the inodes now ensures all the pages have 0
reference, why do we need to do anything with the pgmap?

Jason
