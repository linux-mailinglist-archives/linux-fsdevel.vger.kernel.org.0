Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E635B0D44
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Sep 2022 21:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiIGTad (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Sep 2022 15:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiIGTaa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Sep 2022 15:30:30 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E872D9E0E1
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Sep 2022 12:30:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpGIt5yTY7DuEiNGJT22K+FwNlox931Np3gTe7e+Wh/aeiVqBC11BJZ4Ez9ES/E3LKY4PjaXQBpD/CQQBfi8fKnRgr4Ie92UANlpZxHRbD3wnGJHGZU2hnUZlsMoPMipqPSlHYZ4XeBRrO0W6PuT/IQXzAGJvsZeRyaq4WrINEbkenB+LQdZL+coLR9nB8e9X1AH8TDCQjeii776QZocWFgreekoLHlcBM3r4fu0NqpS6XtyVYieO50D/JomR8mQ37mh67vnx/fLlQXfuDgiDEmUVqb7K5u5/ecz0sPdBpVJgctkGrUtQXLiOo/H+1YDobutpYHHPflvx6oGv1z+Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0D2IL4VT5OxeY13hSJy9sKXeJEY3kME5TtvDf2cIkUw=;
 b=ZhHr2pCd/YGHIQ9EFIiv14J65Y4jlnJQJFqG0PR6ijeURv1WA3MqUaxKDeABjY05JNaz4J9IpXTAV/iipj/elD5R7OJ/nWdu0CC7N0Qtlv5yE9T9+QocRV6o9cRHj/P9psivY/SPjuZvirOAxrrojQkD3tFK9JlFb1VCUxLFOAt5qo12L3aM7Vt4cJRqaoDelmQ95zZ+VAYtcqqrsoQe7R2rVRRRi9Ugpuhe/8kWbyaVG+z1jBkHcYNA9RNbeDh82e6A6MxKyczltniWBongWYtkhsvzcurqMV23rV5Y0tozboj0PIho1K1JYecdZyQCd3uuroSlc4OKcxkcNDWKxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0D2IL4VT5OxeY13hSJy9sKXeJEY3kME5TtvDf2cIkUw=;
 b=GF1ZnabSZe0L+WzSh+qhcC6wjZe1VHwfAJJ+7pclVmtfw7dgKqlDUZ+PoeiIGFzC1UhOvLqzLdN00oyqX2XwPvZxSr5JnOrKCw/uZV3syUMpSJMGtLNvDmABkVvZTW54mkExelWpAr8XOvmiBhurdkw65k6pQBP2sknYY81k/dshvz2DvAq6FOp1bWPt5s5od/4MkRgW/uT7VU40tBGVCR3+KL1P7SwQpFHO+8Zzei8P71YleUXJjhALpT48MjEgi+GhwcU0M1vxPFiF/al7cGwAfOT4m3fyPWxh/6C/NpSSwIwDOHVpc8bTW5IEbyzxHmg1nG9pL8ltsYiHlCrtCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BY5PR12MB4052.namprd12.prod.outlook.com (2603:10b6:a03:209::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 7 Sep
 2022 19:30:25 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5588.018; Wed, 7 Sep 2022
 19:30:25 +0000
Date:   Wed, 7 Sep 2022 16:30:24 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/13] Fix the DAX-gup mistake
Message-ID: <YxjxUPS6pwHwQhRh@nvidia.com>
References: <YxdFmXi/Zdr8Zi3q@nvidia.com>
 <6317821d1c465_166f29417@dwillia2-xfh.jf.intel.com.notmuch>
 <YxeDjTq526iS15Re@nvidia.com>
 <631793709f2d3_166f29415@dwillia2-xfh.jf.intel.com.notmuch>
 <YxeWQIxPZF0QJ/FL@nvidia.com>
 <6317a26d3e1ed_166f2946e@dwillia2-xfh.jf.intel.com.notmuch>
 <6317ebde620ec_166f29466@dwillia2-xfh.jf.intel.com.notmuch>
 <YxiVfn8+fR4I76ED@nvidia.com>
 <6318d07fa17e7_166f29495@dwillia2-xfh.jf.intel.com.notmuch>
 <6318e66861c87_166f294f1@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6318e66861c87_166f294f1@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BL1PR13CA0272.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::7) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 367f3b2e-3383-4b67-3b93-08da910769b6
X-MS-TrafficTypeDiagnostic: BY5PR12MB4052:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ixFIBq7K/0DtRAaWkVp+B7grMJQSA19gK5NiE7NjKphrdBLjSSlgSiGHKvd1SIySopWMscv+lvqIVw2FS4dfNrdk4/tTIVbMRbef24adoF/3ECIh10VL5YocqoDntpLPwNqYLmZk3m6GnSf1SySZbnT39T3CDFpM2YL+tK791AKdWr0mfkvVi2HTzTWPC2CpLcwkNpQgyAtg0NSP1o+lhK21MjvtWWn4mZtF+BolgVqrgwrv9+zF5n4Qo6+vMhci5n3uP1Ma5DynnzZE3OV5O/59WDMNCyKZTqpfS3C++pqPkqyejZVPb49fdmkILNvFEZqMhVof9o04cj013j03qmFqt78vRx7M7mAIBJNA7neC1AT3ZZYoC5hpYCS1iAtMyqyo5QEacq8tddPaJzzjcqFgaDT4VXEb5X3vNYZR3LPaDApWSmJsZVKWmZWIb8EkzkKc8VOfdj4bmkGHfnZcT1n0f3nkZ6FIjNofFVELS66L6hSaiZofkD7ft/h/+CSJasnOjnJzvAgmaxl8QtUHhyhQkHlRegh/Y/gX0XPDJMpUG3iqF69EhKontRla/TimgxXcsRkJRYf2upXh5G3iENdbWjfpbeQ8tToSLHTj0XlQ/svU9/cY4ri6rTEH1heliSGaABxtbhxLehynSvBwGrm2fgcRdm6GcCYcKJ9LAf4C/D/kg/GB8IrQmeOIEVmY7wILkClxsXV2hYj3NRHmhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(8676002)(86362001)(4326008)(66476007)(316002)(66556008)(66946007)(36756003)(8936002)(83380400001)(6506007)(186003)(41300700001)(38100700002)(6486002)(478600001)(26005)(6916009)(2906002)(6512007)(2616005)(54906003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JRdzssDcoMiHXQd86LLNPGyKHJn7ydvDUPWTDNrmHeo4nlF8U1Mj9wVaByXb?=
 =?us-ascii?Q?g6oep5c/qJjvSRKetEQy38gy3RxiObIm0aq2majgSi2fIsVjAXf3IBt3rtbw?=
 =?us-ascii?Q?m1RbNIdCf8QIa5ZOL8+cPtoWkDEE9hsJegQGIGMU04zUYnH1x8jezWUO0ZTH?=
 =?us-ascii?Q?GcXCH6AH+7MGtVl5y28Si3aCxIOl4mk8gyw62GV1WAK7mZkn1sS+zq0yHXxI?=
 =?us-ascii?Q?NLe2w6Y0qBaTyzDPR9QbHOa0Zv9gJkxT03UEo6Rq3YBl1ZqngghvJEGq1Shl?=
 =?us-ascii?Q?nYVblZwjwoz0xr4DmWowD4PKkn4jUADAHLjHvIiJRWVHx7aMmemgTJHP2xKz?=
 =?us-ascii?Q?E7SN12Ee9zttMphqiWyqBW0F3Bm6zdy9WUAErxz8Fa7gByeulPQMQOk7bV22?=
 =?us-ascii?Q?p3xqUegaxogikjyPQ6YUShrX5trcwChHY2urHM3rr08OgVPlD/Jb8PYA1jW3?=
 =?us-ascii?Q?F2nWsNWfeu+9FMhY7ukPLOlgRvaLk9EE58M63ATih0jopkKJUyXt6quG5jBG?=
 =?us-ascii?Q?Ma2eDOEdRQKrcdAhLpfH0ME9XfyR/NB2F8PEEd4f9vC8XeM3hNtVd2mAltdE?=
 =?us-ascii?Q?LiL9dbS+2fWbNMHQeDqsZhx35t50Z1so2eLvtrjxoIDpj+w/eWkB+BrTzQlv?=
 =?us-ascii?Q?6ISEHU1RdKCfm0SGrcSPEmvprx2Fe5pfoiJNkJdGSXbCSMUwLEWciLC8xoeV?=
 =?us-ascii?Q?kQCQGawAxL0Z6MJBJVNjD8NqAKG+U89i2UpbndXTnavJ3XxCipbtWG42gVFY?=
 =?us-ascii?Q?jNP7mOSIGuvO4TBPKlZo322ztCz8cmhMYxWwnITzyXqqTR1L1lraOCHXG8Qe?=
 =?us-ascii?Q?IE5NeKZFvEwP19fv2QRsLf1Qm6NQoXSadHbdrtaK4VEe2hu5k2F8S9p7U05W?=
 =?us-ascii?Q?WEXgpu43lTUqm6+Pq+ja1p7rQxHJp7tn3ijK/bx5pb7MPyi0/5R9HjJWK1C7?=
 =?us-ascii?Q?d33vd/t2kOpKCZX1I4a4IWNmg2waHrRRQzEgfo/1QwilHS+4HWZJwbiHyGxb?=
 =?us-ascii?Q?BEOwgoG5z/2+zCtJlqUY1jvpC62RVBN6WXKKdngfFp7SQ9zS4H88mpRKkNst?=
 =?us-ascii?Q?mbZvFle+Wb6UywFKP+Ukc/ONgJaR4v0i2DL2IvCfRBYFY5jblK2YzSi+Dqm0?=
 =?us-ascii?Q?EqIH1Y7vKiMOrKooTYHxrHJYasDdK8smHiSOE17ZUMH0iyWCQII6eyS6WAN0?=
 =?us-ascii?Q?fO1tcfnBpzNEp+xO2trItak+WaQeFVvXA4SfmvyBuuEy24/d7ituE3r/feyi?=
 =?us-ascii?Q?u5bRf+egSg0skvRPgEcF0/whSBNV2gpuAYDVc9LMFUKky43qw4JIrb113GJm?=
 =?us-ascii?Q?RfAdizkh2xAFmULCLRJrFwnvTmSedsuAnYeeZa0DK2qhPhzq1z4yVPhq5R0E?=
 =?us-ascii?Q?+H/H7qIajSjk7tqqp7IYL4ytVfpQkeXUPN5PkMXylH5V78UQaSAhU/6PLapm?=
 =?us-ascii?Q?e0LOweiJjX6RCrpRF5a7l8WccYBO46XN7JUKXesPt46uXBB/GpPOBrBZtKp7?=
 =?us-ascii?Q?RKosY0AccQNFOXiQAdf2fxthFXgxQYIZ77TtsMlyF+H441agBKlUbzhJOqY9?=
 =?us-ascii?Q?7TDZ5+uxHsXq7aPf1fO+nP/2fK3yNodLVZC1AtO6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 367f3b2e-3383-4b67-3b93-08da910769b6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 19:30:25.2582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B6dnApKbR86K76sXnyJdT5hi8j/VNXV0UlBm5flxRJT8iua44jYCJb8Lo9zq4vKi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4052
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 07, 2022 at 11:43:52AM -0700, Dan Williams wrote:

> It is still the case that while waiting for the page to go idle it is
> associated with its given file / inode. It is possible that
> memory-failure, or some other event that requires looking up the page's
> association, fires in that time span.

Can't the page->mapping can remain set to the address space even if it is
not installed into any PTEs? Zap should only remove the PTEs, not
clear the page->mapping.

Or, said another way, page->mapping should only change while the page
refcount is 0 and thus the filesystem is completely in control of when
it changes, and can do so under its own locks

If the refcount is 0 then memory failure should not happen - it would
require someone accessed the page without referencing it. The only
thing that could do that is the kernel, and if the kernel is
referencing a 0 refcount page (eg it got converted to meta-data or
something), it is probably not linked to an address space anymore
anyhow?

> under filesystem locks. I.e. break layouts is "make it safe to do the
> truncate", not "do the truncate up front".

The truncate action is reorganizing the metadata in the filesystem,
the lead up to it is to fence of all access to the DAX pages from all
sources, so it does seem to me that 0ing the refcount in advance is
exactly the right thing to do.

It returns the page back to the exclusive control of the filesystem,
and nothing else does this.

Jason
