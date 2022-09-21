Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079265E563E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 00:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiIUW24 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 18:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiIUW2z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 18:28:55 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCD3A830F;
        Wed, 21 Sep 2022 15:28:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnlkNFjojCnwr68Nh6vGPh+mSyDG+6arlZC6tsieYgf5giZkUCD4pGrL3Lf+hR5PnBeHGqvsbUHeX/PcZZM8s+LxHHcxvmYAyH6oouYUjvMAXD6TlG1yKSRdCbyydU56bzRpsYWC6z92oCocpbm45eNspl8acwWs+a/G2vYrV26fZFaTLoR4KupyQJkV9TUSJ1h4ucysuLD2e3r86GqEcCsoKSekuvtOA/vBx00Zs3v4h8voDGzEFidabKcnJzc2+bR86jFojYvTMl5i11DV1qLeG7bNce0S2wXqMGN18DljbsyC7gBCtONLcS+MmRllbucXRXFOuQP3zEymLn8Nlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YFjoB+VK1S8NMyEPWe4ky9JClSxYa/Fawj6M7M1w+A4=;
 b=QPM6MCuo3UXCnv/urahCIAA1NW/DhljthUAF69BrB2WGaEl+TwIucFsVwhlw1ycPV6+6HJHJRmy4916nvoYAYtD/jDq3GOd/LfzLZfgl/QB/FSR+8yQcbHdl07yWvqvhjqse1tdc4NpkWWunvfQEDxOAgRUomsfVtqtEXdnCBTPtFxnpAyqs0bLz06ovw0ojsGaVQldvtA/DyhBmouDvJwHod++eSxYp8ODY1ULBVxJ9ym3X3xO25T5KAX9wQGa6yvY+0V/zfDj4nhLpPR6Xe8XgOgy4ii0Cd2l0UPb6jAQPFuaMSl9aetWMcDLgU/oby3BocKeagk+1bowNXhXTKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFjoB+VK1S8NMyEPWe4ky9JClSxYa/Fawj6M7M1w+A4=;
 b=O9ZcLagyFhNejd600Di17U88M5tl6gyL5ZFTXtNxn9umR6yo/iGuYjp3sv4X5dHG4IDw8nPDKdY1KqYKtmHCBGikNaLvPiCRrApveS8UJjrkwGSft7yWDYyoc1kQkY6Axm9B/BTu8yioMJDfpi4fYVIqeVEjB8yg7QqLuqa9DRycBk9LkR2MQ7oMCMmGTC6tZ4bvVQ90wshNv6jw4pLL8lf0OhOOpUAZNSPZYWAmvk5VycrewkJC5r4vJNRsRx475hm7GyAV3XZ+UXoM70sKJ1jLeinUBolZizBUcGTopmFjrVVhN1eL38ftWmqCj6OoSTW/OcWry3k6LQzY6rQ9jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by MW4PR12MB7239.namprd12.prod.outlook.com (2603:10b6:303:228::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Wed, 21 Sep
 2022 22:28:53 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::3d9f:c18a:7310:ae46]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::3d9f:c18a:7310:ae46%8]) with mapi id 15.20.5654.016; Wed, 21 Sep 2022
 22:28:53 +0000
Date:   Wed, 21 Sep 2022 19:28:51 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 05/18] xfs: Add xfs_break_layouts() to the inode
 eviction path
Message-ID: <YyuQI08LManypG6u@nvidia.com>
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
 <166329933874.2786261.18236541386474985669.stgit@dwillia2-xfh.jf.intel.com>
 <20220918225731.GG3600936@dread.disaster.area>
 <632894c4738d8_2a6ded294a@dwillia2-xfh.jf.intel.com.notmuch>
 <20220919212959.GL3600936@dread.disaster.area>
 <6329ee04c9272_2a6ded294bf@dwillia2-xfh.jf.intel.com.notmuch>
 <20220921221416.GT3600936@dread.disaster.area>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921221416.GT3600936@dread.disaster.area>
X-ClientProxiedBy: BL1PR13CA0370.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::15) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4181:EE_|MW4PR12MB7239:EE_
X-MS-Office365-Filtering-Correlation-Id: a2479a70-4924-4aa6-7b01-08da9c20a9d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8OpuMXS7HQ/n4u1n+NJabt///u8/77MuLGUotn8M5a2GSH74+ok7y8CZfVWEEsZDKPg8je42ENT4lekQ54N3oNXrRJNFqeYuZdwhGrbArYVInN79hy+SZ23/r9UbQRKmArAGeTeT11wro2cMhgYSEFJb3DM6fnydaKRlRmeqHR2qyJ6ErbLzm7+53xSSpZQLR/eXtJGSNObUbUzpcGnXuaKslOepIJUwmYqd3AUuI3IzVevujHdBSkQ4stdWiqlP8eOXxFLwwEmlFbCS5uUQZ2ACmT+aPSpio16pnY+9WbFsX9lTYhwC0uAE0vSzTFfKek/JfMFUJqJzw83BIXsyP9Crn98An/BsI++NLdMz24HhrP6zW6iNazoPvK2I7ZxP494IP2ANcOZqnqs/oaUxt/mfj9EF/0AmaZ3hGWwa5hXdrHzFyjE6+xvfhJCqYwwCr9Y4EmCEZlC5s+s9hfqwNkNP0LPVVh0D0tVJGmOe71xtIw/46t+2pmiHnZ9f71V/cl6vo16YS+DXt3NbUT9fZOxzfw2/Yh7D5CtGhilQykCV3FcfY1SsLgFeTbUSKHuesxzDjw+Y/xIfNj9QFNwL/XST0XUkmiljj5xikIt3siAff0nq7/WtoegNtyUsflOUlDeSVPQ/1y2sHjvB1TRxv0/ixBRRwDFS1h7HJFM8YTuh8a2OGs9aK8vXedNgUGxeK5rqwFq/oA5mXAVcg4ttpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199015)(86362001)(5660300002)(6916009)(316002)(38100700002)(54906003)(6486002)(478600001)(8936002)(66476007)(4326008)(66946007)(4744005)(2906002)(8676002)(36756003)(41300700001)(66556008)(26005)(6512007)(6506007)(186003)(2616005)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P9H6TEH78ej55zo4HjZmL3nW6OSoe6h8thmVVQuz3m7tJ08+8lIXEDHEVJRV?=
 =?us-ascii?Q?JHMFrpT3FCgtwfSUbAkhmU76wLB0I0g7jdtHm6VnOWEB4Y1r+K+YQLoP3hI8?=
 =?us-ascii?Q?K7vUHJJ2vDSDHtTrekycPOe9+aBfi829em7MEOpDYQmBJiiK4yThRnItWKL6?=
 =?us-ascii?Q?ic9kZCDZZ1Nyl7N5k3C3G3kqqHBhAz4XjM9bIToje2WOIpv9NjFn4k4G+Aqe?=
 =?us-ascii?Q?VH9X9YT9mZrHCaZIU7DLk8mUy3Cd/YSf4OF/vRQPTGEMEjWdHGXDoq6XKPbM?=
 =?us-ascii?Q?dCnblzdLYn9KPvz0ennBeFtKQxhNP4a68WtnTkrF6F2hl2unt0xxJpkpRxKi?=
 =?us-ascii?Q?spXTc+lupengTRxu06rcEbitKry+F2TNNktQjado8zKn9XfCmj5/myWES04L?=
 =?us-ascii?Q?FXRWsspDkNGWCLRE+QPEUzgO9gqoz73LOxh78nV37LyQy1gBGUsKqrME0DZh?=
 =?us-ascii?Q?ynM0MtgkLs0HECpeEN2HN6KH0boO9XDoogbjk22eYZOy+IBHRPoBN/iElE0O?=
 =?us-ascii?Q?vwLkWyzpDCbQgQmYaULnIk2IquU70BdlStydQOZpVSZMo28ezfeJ9TlBDF3S?=
 =?us-ascii?Q?89WYSbgdR77pQvToJYts8zDmJ96vhJio40ILXNxPpbJUsuBNuJVnWc7ws+2Y?=
 =?us-ascii?Q?8ZOQh66hb7jc7MpY6H9D3OKi0YrCO1+9PlqHeU5tNueBq3fxmzPfe1Bazdog?=
 =?us-ascii?Q?EtPkSWSHuYdDyStO0hPOKD9s1G77ThaXeS6EMudOunFYobuIeWFjA1IBL1no?=
 =?us-ascii?Q?PscNe1pW7y1wGmMliBpzi4TPK6DL0EGvfmGvcIoWwl2wScK1JZaI6Cn8H0Yo?=
 =?us-ascii?Q?O5BWoCyYJjUVkSCBh0UNOgdB3CtyXmY4cDyVvv+JWq7TkJ41afMZOqsut4G6?=
 =?us-ascii?Q?4ZvCsP4lcYpdvxl5X3vmSqWP0+LbfB+u33rl4XHTbKfSM0+bC6auK5agO4d1?=
 =?us-ascii?Q?OYckzETJRlJfqx+f0mlDWEQLXLhpB4wmCfQZrJ+Ndj61sEHlkmJGh36vfTld?=
 =?us-ascii?Q?H1LbvBQJmLq7sg39GsGTUUXQQMN0WZzlrGjS5RstZ8Q11zHFEZ4lRwfVkxsi?=
 =?us-ascii?Q?h8r5SymoBGGcs+gf1ctU23ZqZJKe6a0fwdMtlUhS8/6uv3pNkME4IOKIs5H9?=
 =?us-ascii?Q?lGHjsuHrUo0o1NUZxCJr/AeEYm85oUtFuCRgNuW0zSb/xYXFcuheB/CviEHI?=
 =?us-ascii?Q?V8ILzE/xlaWL0l2j6E/g1DJTQDVTIqjbv3KEtZSylOrd7loyn+DS7woSTm7r?=
 =?us-ascii?Q?D2t7TRqV9ZtwQbvYOif2vyEOes8kWDS9ye5u0J9LGGTBR9q39uubGTFSwvw5?=
 =?us-ascii?Q?DbIvAghh7CXCjiNo1orChAoDZHqvjXrWHOADhXszzAdMMk4FRDj7uk5lwGiv?=
 =?us-ascii?Q?5zbBiGHMrc2wAoPmIMawjhTMmgMaFRFZD3UpDz5lQCjcfW/cJ/ONPip7zaZV?=
 =?us-ascii?Q?SyIEIsy3vt6wFJRbcD8ToMy/zhTcmtIq0OFHAr8xTqyUeZwPgXOUgDRkDei5?=
 =?us-ascii?Q?u1j0phymTj6k657N3UzBxsdlz5ymEvHD13sJ02y2jnab0Jhkeem5TMhWBJfM?=
 =?us-ascii?Q?2Cg1NgctXVI11HeHTUPGr3fsE+z+gtPwqEpmG+Hk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2479a70-4924-4aa6-7b01-08da9c20a9d9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 22:28:53.2597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 06c/oVcCp8X2vpHVBMaDdb9RFOTFpDs6CaAvrrtw5hMVAuLO955793hUTWBhxiNU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7239
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 22, 2022 at 08:14:16AM +1000, Dave Chinner wrote:

> Where are these DAX page pins that don't require the pin holder to
> also hold active references to the filesystem objects coming from?

O_DIRECT and things like it.

The concept has been that what you called revoke is just generic code
to wait until all short term users put back their pins, as short term
uses must do according to the !FOLL_LONGTERM contract.

Jason
