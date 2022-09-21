Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF955BFF94
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 16:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiIUOKy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 10:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiIUOKp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 10:10:45 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41868E0DA;
        Wed, 21 Sep 2022 07:10:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqUI+CHxcjCosoG3vd852mQqqV7qDy5CqqOBDbHRTK1uZUiRHlmNZzKMaAr6ZYaVSSxwCuNkDL8fbBEAhy2iscjhi3l2N5MvrhEupYwe1fMbyvTapHUOvdybD9JxZIOigX97l9TGyTFptNL5D/qmCN6VjaC6ME442JIb77mbiY2WgvCNgBAnx6qAP021+hB3Bfxap+WvZwo+Tch3JAixBGkabKEJe9h4/Bm/+dl1XkUmINIA0MWjadO+Im7oPH1OS6XL0ca2eZIbZegKQJH5+8b9eS0hUz812SHp3HZL8te4nILDjJFPFHQAV3O/hF9yje4AinUdp6ARB28TBeAWkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJS+Rrn+hgF13hGWR2dza3J6d5hy7BxMAKRiDc0GH/4=;
 b=G0mRK35JWQlhAC0QGp3/2MO1HyjRgSxsdt/vZHpeGpvAQ1RrU7nbu0WSPP2XOujeZpSB7SdwLwRM4Pzp2/Obl7K8z285SzwAWe9MekugcFVOKGP6gA0wzV5TjuFHVe+SMv0VGbvLYFyv30Pnoxb+vYXreqNVR6enjt8dc2JbLwLNaDmLBk1YQBtHJu5jnwTr7Jog/WpGVntIMwgc8ywex838PnuvjkZ95qh+6d5TYBvCNKw7WeOTM8nQBiX82kmkiLCgX94nhnqGPGC6ErMnRIMdOQOH9BeIBUeLrmt5BNpgg7A/WtJ9jmceUkUWLlSua9MR5tXA34tPzwWLqzUz/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJS+Rrn+hgF13hGWR2dza3J6d5hy7BxMAKRiDc0GH/4=;
 b=Q8f2wcAW+yzSE3+2iiWlm+MrKITDeQ8QBfGeVNXDUrMTvTKND7l8zGyLRnv3vFVsnSssPKRCMluflr14VPQkscwIqMBPqeA4Rg3z5SNo49egZavUAJwnNB4JS1V/Jy+Lw9dLaDFidf8d+p7oXG+IJkk4dNe+j+z0M8r8Sj4A1r11qnfUVnZTXid1yw08bvzS0edwQvTVymeTQbLZ6kMZp0sgQogvELZgHkODMCkaDi2kKt3xoA05uO3iYBIoXs0BIcd2GiqPqEUFpW+dgLMdbvVnup4QWv6+gLLgPCpqCJ1HOPbnfwpmHjmMQf4Fh4NCFlsL8CQXW8Xi9HXayrsyPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH2PR12MB4905.namprd12.prod.outlook.com (2603:10b6:610:64::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Wed, 21 Sep
 2022 14:10:37 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5654.016; Wed, 21 Sep 2022
 14:10:37 +0000
Date:   Wed, 21 Sep 2022 11:10:36 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, Matthew Wilcox <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 15/18] devdax: Use dax_insert_entry() +
 dax_delete_mapping_entry()
Message-ID: <YysbXPnA3Z6AzWCw@nvidia.com>
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
 <166329939733.2786261.13946962468817639563.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166329939733.2786261.13946962468817639563.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: BL1P223CA0007.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::12) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|CH2PR12MB4905:EE_
X-MS-Office365-Filtering-Correlation-Id: b9b8a288-aa92-4995-6350-08da9bdb0e54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BD4neOhkh9d0TIKBnB5gfYl7W186BDth345zh8yuY1BA2Z2N4cO/7Dw+ZAmGy0tq3mkFB599trRMqSEoE/QHJPL1w6RYEmYwzqWobZ4CA5R7yCNxpgFx7U+Aw+n4lsh7OKabDgOfq9YwxRxxI6lKaq88fuxpqLtLskPzloxkosQBBkjyEGqB9unKnaACIJ3FULZ6Fs4IMIT+3w9v7T2qs0oUfyc74Rw8d+9p+3bjv6HZJHxqVNv5KcGhpFGzYV1wjYI6tTClXdraSwDoXa/yfPYM2obAoA8x9WnaSPM69K7WD6QU39o0nMtsOz9I5qGjXWXamWSOqNEgkjdEAKvxudILqCtyk/T+E3go5XpRbQy3hfwfc4u5VtJ8th+7WAZ7LgQ7B+c7EbZ+80qqa29IJGG/6tLRG4Mln7WN0lIHeaNvgn9HU68Rzd+nI2SiioIyB3IXHOY3hYS3yJUzqCzYd/jkataOEej3Lesh3DZlz+2YjoSlHy6BUoLvSe6gAIUd2WOCLB5TYE5Mwh7rc5IMJeTI4Ai+nG4Pl/pAIYNqQXl6B4w9mvP/YFOhgYX6WOyoUOyX63qIeK5/4XFEsk86Lo2I5beMAfHw3w6vzZYUJTaWRWN1oPhpd8voiGKThNIFWym6f+/d6igUHxotZHanzhUs5wE9qHRP7J4pZoRbLBUza1M9NExHDlFhn9eQNKOuBem1l+1ixE+xmEk2p1yU6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(451199015)(26005)(6512007)(2616005)(478600001)(6506007)(6486002)(41300700001)(38100700002)(86362001)(186003)(8936002)(36756003)(83380400001)(66476007)(66556008)(2906002)(316002)(66946007)(5660300002)(54906003)(6916009)(7416002)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w8CyrvbyXu+/6j8KrRQK5Jk0St6G/2Tngt7AuLXFcA3d9mVsWtXRMCtpnF8C?=
 =?us-ascii?Q?iO3LET7tK1vhVVxGpepCJNS+7onKOdLwcI1AXE9wPfEpvIRufJ3EaXPsrN2w?=
 =?us-ascii?Q?kNGtv4OOD+nGoECrpAd+G2cKbSQ+VCL5nD3GhJXSV9OOEXa59C39veQguZ41?=
 =?us-ascii?Q?b7YYrGgZkjRmwJOa5Di05cm57ToRxncLn8/llPqQ0xI7UAerjUNLOOxnB2NP?=
 =?us-ascii?Q?0yCaT1FTt5aGEOyg9rTEgIyUdU5L66iDQsCP2yBNL2hYhOqt9gH+ylxyryVL?=
 =?us-ascii?Q?GJJWNpbYCUYIiDDB6CLVlqkfZjGU2JMhV3uGBePqAiGa2JVCOjnMGQLqTEjp?=
 =?us-ascii?Q?7AHKirWsXl6HyegZ2UnLSgHeQosKAlgicrsJdTKiuBcn3y2kjnmfK0MfOXvl?=
 =?us-ascii?Q?JIMVbZVsxXSKfiLUrhvYcgZndcx932DDF/qD7u5aQfFL648H2GhY533mGAY5?=
 =?us-ascii?Q?yByg81cnbhKbAPIg/6VR2JgqTxbhth4gYwfMvgnVpircfabkGdj/trT5OD/Y?=
 =?us-ascii?Q?cr3eKELHRhqUHRx0GbtQzcKxLJwq4/bDEaMlMw+GqTwGDmtak0cUWSeYO2us?=
 =?us-ascii?Q?S4pAx9Fb10kzVPXZZDZdGYlRLEwInpYZmurlWnMdma8ZyqA+GlYAjiFGcczC?=
 =?us-ascii?Q?tUyJ2NPznKkJ+peXAGvTGTs0h6r2HtOHmkNYPScNf62SHg33YDRB/bAmQdyC?=
 =?us-ascii?Q?mGbsJVgpEI4TUC89DyeiCRT4F5p0RSfgFH0fSqKY6vGWS73fTz1FHHsfsfzF?=
 =?us-ascii?Q?Wt/Dq6RKa8bTlzbS7hvv9lS9WH9ALEEEyeXdpPrTCA7bFvWBAhofSvESyhM/?=
 =?us-ascii?Q?YVnvPFR6+XQy9dV8gkbDuE0QIiVx2UWxxCXi0Rxg0607pWleeMsPaDbgtW4O?=
 =?us-ascii?Q?HjJPxWa6VALIrxE7iw7yv7BaKUwG35VhZVAwPyO6KEF5OVK4mO3Ck7/C4zKU?=
 =?us-ascii?Q?UDDZ0KH85VKP5/re/l2tsNjF2ekKYOV4+ZAdr88EOoF/74onetRNPGXdopm6?=
 =?us-ascii?Q?ysNKsTFaY5TUy7mQnMg9sBzsdI4+K1ATOE32W7f8qKsXQKMhiWeERZEDUGxs?=
 =?us-ascii?Q?gTBdjHCWr0S81On9PkRPrcT8seRjakGbbyH9EIsv0v4xOI5MpR28qYj90NO/?=
 =?us-ascii?Q?+z/1a+zrVZn5bFxYVrbsZwYpwuhUdwn/hfJ8zK9rnyiBnwsgP83gPd2Wpgbd?=
 =?us-ascii?Q?cBF+1TPvGx/vFa63MXqdJvE6tjDaC+YWFz6Pn6gD0wMr62GFpKfrbb8PI5E9?=
 =?us-ascii?Q?kCv/Jr59quWJVcGBOA/oKupT4bzkYG9anowtum7QeTTJL9yek4Jeiq0UjHFu?=
 =?us-ascii?Q?6fTdlxqaF0nwwe/73s03TAAPlf5SIQm81isDPJm63MuuyBSUqepCtFckDxnU?=
 =?us-ascii?Q?C0ti1Zp/pfFJc0mxt5XDBmQQuEkkOgvDIM6ev+6myKSmgZ8M9pkb+IgIkC1B?=
 =?us-ascii?Q?/DmluC7Wif67Vwc2Iygyu7YFurGV5/invVUrFg8icNeqLV6FHQ+1ndYskwcw?=
 =?us-ascii?Q?GNHU4NeOutFLVtXMCoS+EFUR6du1+tKUX8kCGeEDBc29wOTWAlqudMyrFnXw?=
 =?us-ascii?Q?9n3hgSN3l935vmz53sCbKSENNNOSVFYnIYnAi2ZY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b8a288-aa92-4995-6350-08da9bdb0e54
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 14:10:36.8619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+XyaIlUb5kOxdf/eQX5XxXq02W8OHs6q47EcNg52hlLou87Dw73MIc+fCCCb8FN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4905
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 15, 2022 at 08:36:37PM -0700, Dan Williams wrote:
> Track entries and take pgmap references at mapping insertion time.
> Revoke mappings (dax_zap_mappings()) and drop the associated pgmap
> references at device destruction or inode eviction time. With this in
> place, and the fsdax equivalent already in place, the gup code no longer
> needs to consider PTE_DEVMAP as an indicator to get a pgmap reference
> before taking a page reference.
> 
> In other words, GUP takes additional references on mapped pages. Until
> now, DAX in all its forms was failing to take references at mapping
> time. With that fixed there is no longer a requirement for gup to manage
> @pgmap references. However, that cleanup is saved for a follow-on patch.

A page->pgmap must be valid and stable so long as a page has a
positive refcount. Once we fixed the refcount GUP is automatically
fine. So this explanation seems confusing.

If dax code needs other changes to maintain that invarient it should
be spelled out what those are and why, but the instant we fix the
refcount we can delete the stuff in gup.c and everywhere else.

Jason
