Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627075E6A06
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 19:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbiIVR4D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 13:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbiIVR4C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 13:56:02 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99844EBBFC;
        Thu, 22 Sep 2022 10:56:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fb7Pg4eKIfD/6OzH/1q2XEozjs85a4KPTC1jVbykErgH7+gDFGVzIBm60j7M14p2bv917JkHrImXWVc/9l3fmpgPNHoml6+dPW8swFmuh8ixEffbBntke9ub5PsqOJ8PBbjgBSZvpe/9D9q3TKSspjW5LSjFaDFyyS+baafiyc2b2yH91kTt2bXVNgPY3wzoki0ry3CHzbu6Ocv+x+5KgNGgPDWGUStvgw7zwNUd3UyW5XTICVQYvnfktPVYAJ7pYzt5lF2FTVUTC+jpOeTSNxcr9/t1xSqug/8ELvNuANry38Lu+0jmkXnUSgIu1pJi/VR2cXLRIhNe9iBytDJBDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUYd7Vr4T9LW+SgR8wu1dhGQVt+npJ+sPWcUGP4dgM0=;
 b=l9skv0XyCW2ozAwXvKejHZeNoYlMtwzmdCwlmBa4edU6YRNdhTIfJA1lFRTexbHfONwNazTKuQ+wTS32imrIStBtX6UzEt4Lf0he+ruLt4dcpwmt4Ijs/cb6oZ6jf5McSYx+/ALESlE7a/Sz5g1UgQjOx/raudGEeGE3mCgwVS1vQKy/QLc9pS/svg29JJa27Q4cUYvBU00lcAvan+6AsAm6t/EWMQvC039jdwOkoMACxqGZw3y/O/1LF09waOodHFfGz7+V0IClO0wsi2GypE0/mfTzfvhmP1K6KPtBgzIMqWWCWPJBkXBQbKQUgkif50RmHoyhDsLnvlksFJ/cmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUYd7Vr4T9LW+SgR8wu1dhGQVt+npJ+sPWcUGP4dgM0=;
 b=a/FcXNVTSu5hFcVXGbSa/6qwJhmv8LnBcjYAjpIOsnZqPz5V83SPzg6SGwALh6ftNn1c+lFWIlyIPVgCOWKO0YG+PHoh5dT8hJwQEVq+P9dzahmNiM2yG01wEO4SOv4TCEjSoquV4+OKh0p0XvuNHa5bzY8yI6qHgwuBilGwl7gfeIXEb9kXK5y+uloczg5IIDyJumLPHaRPt4BnhcghkEOCvyy3vdeXMP5l1Q5jvDCiJ23UJdJMMI/MsOpfjPiYe6Bdd672unPXbt/toWCylaaVIgJN+urpSid4xR2RStL0DBYzZzRgPQx8IaFBTQADH8hvxMB3kPVnnfqsnYzhVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BL1PR12MB5850.namprd12.prod.outlook.com (2603:10b6:208:395::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Thu, 22 Sep
 2022 17:55:59 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 17:55:59 +0000
Date:   Thu, 22 Sep 2022 14:55:57 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, Matthew Wilcox <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 10/18] fsdax: Manage pgmap references at entry
 insertion and deletion
Message-ID: <YyyhrTxFJZlMGYY6@nvidia.com>
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
 <166329936739.2786261.14035402420254589047.stgit@dwillia2-xfh.jf.intel.com>
 <YysZrdF/BSQhjWZs@nvidia.com>
 <632b2b4edd803_66d1a2941a@dwillia2-xfh.jf.intel.com.notmuch>
 <632b8470d34a6_34962946d@dwillia2-xfh.jf.intel.com.notmuch>
 <YyuLLsindwo0prz4@nvidia.com>
 <632ba8eaa5aea_349629422@dwillia2-xfh.jf.intel.com.notmuch>
 <YyurdXnW7SyEndHV@nvidia.com>
 <632bc5c4363e9_349629486@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <632bc5c4363e9_349629486@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BL1PR13CA0118.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::33) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|BL1PR12MB5850:EE_
X-MS-Office365-Filtering-Correlation-Id: bf053442-991b-4b96-0bec-08da9cc3b47d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4fwdqsWn21QmpfHk+u8FCNyBfFyYmOlUxHpkwWfuyu/xMrbskbK0c3b17+8uh+I/8Wb5RhdxC1KtQrnuuc/81jry68KnjEZvfPel5Xk5dDEgZyydxqwRFo3ir2LgFjDpvEIk3GBL7KwGO/5VO55gKxbXli5X25pR12EkLxkCForgQW0am1OnthlB4aKkWo4rXITVy16ddbr84JPftZ+fH9I77h8/FjzTg09GQxrzmGCH2OYGb04pfHfIvuF79poaO5S90N3Y0SCdh/txibGDELkrhoY39SbT+bffBpSbiTmBOvsjJoWAHoe7B4zX/UGJBnEini06UzLpigV8tE5Z+zgaD7+qML8uvTlf+C43RXYpmCv0jqTOJB5spkSOxOEosHH4hI2n/7fBlTRscvmbv0EfwscmquEgqEnJ0nte6LngCdCp08L8ZOf3ITVrCTnaUX1l/RXNGC5SluPXGxLISgFyGirzScffa5TCX3cRF+U6tqykc/J0oMYgW824hrt/5Z0kMhjJJD6waZvfKI9u6LEkrfW1Yf4Jmc0ZiPgx39bnVItIzSr4OfauaPkbhvOMGsVmhDtxfzOTS2u09I968UYm4I/wW2aLx+rmPwElxRqwX8w/N5fgbd5EjW8gUZBs6gva/eRLv1jftcZXceN5zV6PuYhiD5O1/2DhGQLgVJx2Gse8Cjb6LdkkTR8oy17Z3DyDX+8hyk/h5DZJ2/qBpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199015)(186003)(83380400001)(2616005)(86362001)(7416002)(38100700002)(8936002)(8676002)(66556008)(41300700001)(5660300002)(66946007)(4326008)(66476007)(2906002)(6512007)(478600001)(26005)(6916009)(316002)(54906003)(6506007)(6486002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FLHSvSyGxDWSppy9l5AfVS/FeJZNn3RjsLG4wqV08IlUwM5FQ3PacwiVJah8?=
 =?us-ascii?Q?U3V6/jyTKO+Mpvp/0xN76uYyGz9KoqjDlrCHYC84aJH4YFpobsTXNUTprIAe?=
 =?us-ascii?Q?H7e01Wl15cfXB7N7RJNk/Cq1sR5FU6U4oSNDzjkx1/ZlugPOFoEarBFWhaWT?=
 =?us-ascii?Q?J2UjovucuUJy9MAg5YsYrmviJrv+7T2/2EYsNlwt8GmtxlP7df9WwzMhs/G4?=
 =?us-ascii?Q?5rp5E4Ac1geUQnoQ03YJ4vDlhchvvtAImW5lmV6MC2dN+eo8xIQye6lGZv6+?=
 =?us-ascii?Q?dCCu8zzOnccMXkpo6yeN0uATJu0YxAsryMX3wIFI3E65w4F4aFOescM7TZhM?=
 =?us-ascii?Q?Io1rHwERU5M9X/Y7orZKfFzd72D1yfKMh18mZei89dfFC/sGx4D7XM2b2kRJ?=
 =?us-ascii?Q?q9P+LhOi0HARTP8HoPbNVKsQwNKhJqXz4PvfSCGSeAkcMSdpI1H0sKH2XbAg?=
 =?us-ascii?Q?3ZQWW0FD3qtoTI0hA8NeXyDmklN2IalPG03eQ5VpXgJxlZJ2BoYbdhgXadIW?=
 =?us-ascii?Q?ryX3vTW+gOwujzuA/RG64yzIvbgyK4EdR+8OjG+Y9Msowe3s86CwQKSGtcDC?=
 =?us-ascii?Q?rXG5bCZEDhT+U972G6HXR9gXRHErjKSoSEVrnbBgwTNZbFkRe+3GWojlGg4a?=
 =?us-ascii?Q?lBsE+rsVDV3x1foVtZsJgu2duh+MiG+ILsuHCX/uNvGi1gWUg2ob1lBi6qHN?=
 =?us-ascii?Q?DZLc/mWEpkH38L6172OwinweXa7b90CnD2KeewnONZHEhWYAY6HBtspwxzSn?=
 =?us-ascii?Q?ssRpkarZbFujzZSoFN2CS5qLX/gctWMZSUfAu/z/RBK9VhP6F82UdcpXuXYz?=
 =?us-ascii?Q?BxMtUWBrS8u9HpihoZPIKpo4baPYefdiBSLUis/PR9H1rmNT2YxxpWCHVQ9u?=
 =?us-ascii?Q?OV8P+pJVt+4pwVPy9yY+MEqBm7yPD6TPXGFHv5oA2dEj5gZPYeZRJDCNWayv?=
 =?us-ascii?Q?okjOqiSyUQMVegEMkbZ5786DaXdQ5Fdx7gW/j8sZ/yn1DZN0GGpR1GjIDo2n?=
 =?us-ascii?Q?1TvnM33jXpNn9sZz04nCQD9LMl+tWkCsVfejF4IBgtUb5D2fBfgqjQ5IBnFH?=
 =?us-ascii?Q?+CYTTpPTw09Ohm7/FERV8STD3FZVy/0mAEsvHRZ792JeJ8VClK9RAsdz9lht?=
 =?us-ascii?Q?cSUofaBpwxSrIEcCTWx+1PVOhr5rWIhuic3YYHn9DsKDmVraUyiJY4IpJcqM?=
 =?us-ascii?Q?cDNx269BOOpYGCuJS/K7md/oNMZ+GtXZrVkVk3oI+Hi7+1pmmz4MggnEK4Yx?=
 =?us-ascii?Q?+ODJ76tHrv9Uf3sIahDzJOl0jeq8Np4rnSgHsmoYLHbRG9PNTMrowmSdjeDC?=
 =?us-ascii?Q?bP74HXNjeSGzOWGB/VTNmRAydbYZ7j85XEX5QvJoxOhtULXJFILa+GRNkHSa?=
 =?us-ascii?Q?I/GztcfVrwYFRAubiMSUXSLCkgT/GM1KkKUy35qN6tAZNK2KVBBP2pggsCoD?=
 =?us-ascii?Q?yA83DnI3Uj1bo9IpSaTVjfm5doYfAizDK9oEfJLxsxw20AwPQDE42cWF6UZP?=
 =?us-ascii?Q?9j+e8AVr1UoDeGC4rUovEBhe/+Sy7rKNN6c8mjUaB0SLQAtUwqPVLphihKxk?=
 =?us-ascii?Q?A0ofNjafndtNJ1Z8fIu1LgY6r5C8wpdon23XHAkH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf053442-991b-4b96-0bec-08da9cc3b47d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 17:55:58.9339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BCLf8z0i7ihkSVpuTU9r2fqVSlXKnybTXXNCSOfoox9uNcClL0m50cM+yvV/tgBk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5850
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 21, 2022 at 07:17:40PM -0700, Dan Williams wrote:
> Jason Gunthorpe wrote:
> > On Wed, Sep 21, 2022 at 05:14:34PM -0700, Dan Williams wrote:
> > 
> > > > Indeed, you could reasonably put such a liveness test at the moment
> > > > every driver takes a 0 refcount struct page and turns it into a 1
> > > > refcount struct page.
> > > 
> > > I could do it with a flag, but the reason to have pgmap->ref managed at
> > > the page->_refcount 0 -> 1 and 1 -> 0 transitions is so at the end of
> > > time memunmap_pages() can look at the one counter rather than scanning
> > > and rescanning all the pages to see when they go to final idle.
> > 
> > That makes some sense too, but the logical way to do that is to put some
> > counter along the page_free() path, and establish a 'make a page not
> > free' path that does the other side.
> > 
> > ie it should not be in DAX code, it should be all in common pgmap
> > code. The pgmap should never be freed while any page->refcount != 0
> > and that should be an intrinsic property of pgmap, not relying on
> > external parties.
> 
> I just do not know where to put such intrinsics since there is nothing
> today that requires going through the pgmap object to discover the pfn
> and 'allocate' the page.

I think that is just a new API that wrappers the set refcount = 1,
percpu refcount and maybe building appropriate compound pages too.

Eg maybe something like:

  struct folio *pgmap_alloc_folios(pgmap, start, length)

And you get back maximally sized allocated folios with refcount = 1
that span the requested range.

> In other words make dax_direct_access() the 'allocation' event that pins
> the pgmap? I might be speaking a foreign language if you're not familiar
> with the relationship of 'struct dax_device' to 'struct dev_pagemap'
> instances. This is not the first time I have considered making them one
> in the same.

I don't know enough about dax, so yes very foreign :)

I'm thinking broadly about how to make pgmap usable to all the other
drivers in a safe and robust way that makes some kind of logical sense.

Jason
