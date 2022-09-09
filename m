Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24385B36C6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 13:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbiIILxo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 07:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiIILxl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:53:41 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FAD6DAE9
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Sep 2022 04:53:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSHsZEPhbFQ4GZmXyg2qeqpe6sznylNEu7xUUX1508y+jK4XhbQxmPUlGKMCT2ZfLsAd1KPlxMaE8ZrQwvuZ8D+BoMkzb9kiHciF6eU2IR/q0hk3rDhJeaQA27eecfsp/q29wrJEg/z3A3XzkJ1pu5A/ytpfJNM6dsPNicyhDese22sN2UQ7TwaXsX4HI4bIQVIY/qXTDoFQ9FnQvDNAh1u7q77iOUgFIlRGdo+jlNaiGzNYQVjc5ChWDw7VyogFaQApjuY3pXEc0JMKZ7iTibDCDrCXulgfUNVfzCoUodg9oqGul++IBErRJTA+Yyn4XUPQ34buP4tZh2fDjC6xcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FV1k5TDzQ50SbvevCBKfExutFwzqbbCAxLRJ0UGhpKA=;
 b=g5xv/ZAB94jQIOo+iCwB1+1ic0GqQ+VSuUPP08r6kbOr/SGj5o93d3a7ZIHSrht/jAVPPKEohGU6LB/fCLoM5G2oIbA4eBQ7rllgiXQKaMA4Jusjs+YB9tammXDpniu80r3SbrMj+6ePrdHdfNcX00mdJxG7JWPx1GHdRoCiRdSKQ+a+SK8+IB+mSdH3oerrnTH9S0Q9C8Rw+uzMPNXMB/NO1TDHK4PNsQF5MG3EIemYOlawFLCWHb9DyIa/o7htPQJZA3ThYrPPs1OfzZVkyMNRbFpUp4gfkVORFqaTlQNy6vhMFxWS9NQd8+jP8Jk06DgbiFssqJDFlIXUd9pt9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FV1k5TDzQ50SbvevCBKfExutFwzqbbCAxLRJ0UGhpKA=;
 b=tfLIoJnwYcpMBzmywcnIy5aiYdzE8hCMp7fL/bwREygf+PrN1QZI4im7qoJNVy7VH/wcnn087YyUpRNvrL67pqKQjLVv9bJ+Q8kUBNhG235pKoXPHTC4YerXeIfR3c66dEglxX+I3K/3ZBn2l96rxPuLgsuFeEwlvbE/VqRyKMlVkSBro+crl8yX8lSyAHAxxZqKkHNuqNlwrylMvXohSUA7MUsR/awVhugj7p8C41ef9GSMIEawwn0JsDx4Avo6d/LXviUIGHppQ97yJAlTmwX12dw/uAGl8ehAlRcSZcPF/WPI3oFADqtuv60V7gu7kIZ5UxtjEv6P6M8qsSxdJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DS7PR12MB5741.namprd12.prod.outlook.com (2603:10b6:8:70::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.14; Fri, 9 Sep 2022 11:53:38 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5612.019; Fri, 9 Sep 2022
 11:53:38 +0000
Date:   Fri, 9 Sep 2022 08:53:37 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/13] Fix the DAX-gup mistake
Message-ID: <YxspQQ7ElQSAN/l3@nvidia.com>
References: <YxeWQIxPZF0QJ/FL@nvidia.com>
 <6317a26d3e1ed_166f2946e@dwillia2-xfh.jf.intel.com.notmuch>
 <6317ebde620ec_166f29466@dwillia2-xfh.jf.intel.com.notmuch>
 <YxiVfn8+fR4I76ED@nvidia.com>
 <6318d07fa17e7_166f29495@dwillia2-xfh.jf.intel.com.notmuch>
 <6318e66861c87_166f294f1@dwillia2-xfh.jf.intel.com.notmuch>
 <YxjxUPS6pwHwQhRh@nvidia.com>
 <631902ef5591a_166f2941c@dwillia2-xfh.jf.intel.com.notmuch>
 <Yxo5NMoEgk+xKyBj@nvidia.com>
 <631a420ad2f28_166f29423@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <631a420ad2f28_166f29423@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BL0PR1501CA0011.namprd15.prod.outlook.com
 (2603:10b6:207:17::24) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|DS7PR12MB5741:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a108c50-9d16-4e8f-a99c-08da9259eeb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4P1F+vcwNCik/LGPJc4S2OSVIJ1kHQAkJK55JH7IuWcAjcbKduqflm3ecJhYb4RuNAWDMoNOpRVtg9IV7cKxq5zNgH9qK1KF4bpgQy0SkGyWTDzFeMBNPyiV2qIXwTefIV3k5UVA7rT4BEgyBkpTK70lCdKh+0VJqnUZvjTi0v+lc4sU4tpPXVOvro189xLclprHBnyS0W+gM0CCgJQroHsf4waWNd3z3LahhX4trdnE9gAKY/U7+ZbiEPFXOZrwMnFhjP2Q0HA6gsDy7Si6qF7HtuSTbwKhR2jNHabY6k5o//S7QEazpEvYC/A1COFakiRrAyfrABN4Cy1BNopiEkY+nwV3ZXrjyvbgyXC9hOgAognQCtFMDFZPJtDBOTitCPqz7KG730Dlmm7YB2538kvE/XYTonVdAw6fZu3ZqaxHycGHYfwnPUEsptrrKZ8WHr0AP1kX3gURk2n3yf56sYybILw6x4MAugHwFHdmxA8Fcs2vXCGmNIP7emTuosXXYZ9Da1leA4/ejoLqmN/YYZ6sVTFGqx3pSEZo60UVt1jp42YkiKOZF29FqXW2XLbGrL3m1+Ys6SksozpXlhM8uVvIU2X/VZPf8CG3mCdM74ILD4QDkDVyW2L2eJYjw1qdEjqwwv6l4tcjZsYmnHH/FPnttxrhcbXosY7BpZxzqdCuEv5joQKKMNcaVmwdYLeT52HpimSDssjVm91b+py5TQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(478600001)(26005)(66946007)(66476007)(66556008)(4326008)(8676002)(5660300002)(6486002)(8936002)(6512007)(41300700001)(6506007)(2906002)(38100700002)(86362001)(2616005)(186003)(54906003)(83380400001)(36756003)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KzO3S9GUpnBOddxEfFNrIbWoFCieXEWJOxPMEYl3LjOgYjEMJ7yMBRtqunUu?=
 =?us-ascii?Q?sYtgnkWBOnKc/drXWnV9nwZ2/wXDCJTs3Uevkoqm9Sny8w4ifkX2kiQnXxeL?=
 =?us-ascii?Q?M7Fittdd78ggH8rQah4/b5D4+hgctM03m8ljSdvfrG4hVBgXQuKPx9skUfUI?=
 =?us-ascii?Q?DjkGuvo0znACJqJNMnduGXjA3FkpvmVGns6R+8//OIpts3O9y7Z3djfCTHdV?=
 =?us-ascii?Q?A2R394DIT9F6eBlmGm37KlgiMuDZZVHoO5omapNTf+/NXQQ2gwHHhSXAnDuU?=
 =?us-ascii?Q?2R4hGFwU29sPaxknm637s7/Svw6C2FRDNIah05c7Pk0T/wbZMC+q8ih3+cWQ?=
 =?us-ascii?Q?IWaSp4gjuU7JmORqwYwgkot/DHFQnaXH9BkTKSj7hQ1uxUiz4yVvJn23coNP?=
 =?us-ascii?Q?xT7PXJ0SSfNJ3hgFTt2y1pPpA9x94spCMg73c71DMguknyMBiBJpYJXtJKoa?=
 =?us-ascii?Q?2byvfY1jnL800OFVlml3V3h1mtrbGp5V33mnH1VyvFf8b/ztgl9fqTcD2uoA?=
 =?us-ascii?Q?BLILMGRJ/nXAhadaUlo90wZa6bMN9m93wQXaXo7pFLRxx7zKRfR4tBAV+ytN?=
 =?us-ascii?Q?k1ErNFxfSeFdQtLHrxJQuAouSndQIDvE7vIjiGVir3nViGAvpwUqw8DakVka?=
 =?us-ascii?Q?HmElfXizbEj2BDpXlGIgGDkpLVnlUFEbXL5oVRK8HnGkOB9XibO8Qc5O0wCF?=
 =?us-ascii?Q?GC9tib6XtS2VU+fNYL82m9QCmKM/zk0RYjS8W5tfHcBJV7nY3MMMV6NzVuDB?=
 =?us-ascii?Q?hiiLRzOmYgELVcY0uTpo0GHRVXhZNikjaEBtaCp7HNdaD1wZ15ngo7ocgUSk?=
 =?us-ascii?Q?bGgAYF5dGgYlrwbGwM28s8FC6UrN4p39GAYt7voJOUKLgIU0+wW0ocEb3AAu?=
 =?us-ascii?Q?CXx9Z1u9oOA1paNB0G04PmeHfKyGMNVOueDo9hm33dDRlqTdw86o3mHFaNjI?=
 =?us-ascii?Q?0a6eTxLgjpGlsdz5bSAQ2xYWJQNAefU+hacuPRZMdwXtJucu4hph0xzYGSct?=
 =?us-ascii?Q?CBrJX8Hlpb44q8WAuU/UywYU5oPka7mdZxZ5qDZhhBRhuWVUSR97tC6GCHKV?=
 =?us-ascii?Q?jSA884wRbgJNKO7bI80Yq3pEDrd4LKmmlPxKWwNovMTf6qK1kZkbncbBDtt+?=
 =?us-ascii?Q?hy2XVn4TBrPcGMPGphzoane9z6yqBhp3yPQxEgQ9LJ4rGS4JaFLvZ5xC5wHl?=
 =?us-ascii?Q?d5MFONoa7TKCW1kP+AJLdU0DoZQV6q6D+b/H9fG7kUEMYSvdxzr/m8RtdC+8?=
 =?us-ascii?Q?uBNK9AsaSVmSvVDas64bOzjI75PL3EhQQw2m1iWtL5+sRgLhNB2We24Jhl6X?=
 =?us-ascii?Q?hIZ+Ro5FlmmOWbd0HzyhZDfSTgrwwOMkC6tRFR0kDd9kmb8SpOHPcjt/V7EX?=
 =?us-ascii?Q?J40Bn0VPVPCZHO+/sDSI/pGNAwUoCx6lRnQEqTnbRlF4jp0XjxZ5+2pwKead?=
 =?us-ascii?Q?blA9cMy5tN6F99rlmFpMAmClcaifcrOyTO8vk+oo/KniNUyRGIW14IVNiAz/?=
 =?us-ascii?Q?xSSx0vlv7DXTG/jpx44cl6PihIVoPTe2MM/wFS3sjhDeOuV7k6Fw/J/LqYGg?=
 =?us-ascii?Q?PZB5WAB28arqU27YIqC7TMfNqWMt/iV5pMS4g0Iy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a108c50-9d16-4e8f-a99c-08da9259eeb5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 11:53:38.4281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fWft2s+gHO30tnUY8w6ubCt9lItC3vvp9WqaDF05e+RUFPJa8UxJvDXxab2HR7OW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5741
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 08, 2022 at 12:27:06PM -0700, Dan Williams wrote:
>    flag lets the fsdax core track when it has already dropped a page
>    reference, but still has use for things like memory-failure to
>    opportunistically use page->mapping on a 0-reference page.

This is not straightforward, as discussed before the page->mapping is
allowed to change while the refcount is zero, so there is no generic
way to safely obtain a pointer to the address space from a 0 reference
page.

You'd have to pass the 0 reference page into a new pgmap operation
which could obtain an appropriate internal lock to read page->mapping.

> > I'm not sure what it has to do with normal_page?
> 
> This thread is mainly about DAX slowly reinventing _mapcount that gets
> managed in all the right places for a normal_page. Longer term I think
> we either need to get back to the page-less DAX experiment and find a
> way to unwind some of this page usage creep, or cut over to finally
> making DAX-pages be normal pages and delete most of the special case
> handling in fs/dax.c. I am open to discussing the former, but I think
> the latter is more likely.

I think the latter is inevitable at this point..

Jason
