Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBCE601DF3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 01:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiJQX5u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 19:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiJQX5r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 19:57:47 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2048.outbound.protection.outlook.com [40.107.212.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4A47E003
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Oct 2022 16:57:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVtR9HgcDwMSULRv2btLBCoBwVHIz7VnjpeoyfUJgBDivCZQO2wYlq3fcxcGncJArz7h/4yFBGidz4lUsooop68PjsOMs2pZSWwoqjQsGZExRpFlmXW0YOGaPoZJ+3k4xVdjKgn1zrmOVg2acE2FHjZMw9ru8YETV/UeAyu+nOKZfoIuNhKE8BCOUCK4y3b7QZ5KWQbMKs93+0QdVlfaGvM0y4e8r4wxXbYytDxoMXRzug57lGicLZ9Vd6e4oMRe15GiSSwrQE5ulmv+noTiSjaMhnT9VHPg8wNBjNjgeUYpp88566h2Ma3BZMnGpODkFRJZCOf0MsrhDruVKw5sCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJswgQF7yDRxuPkE9MOxIgSKghGL0AI5vJr2W+tpcBg=;
 b=ftBZf2npw6nJvAeAI60rPnnpKD6kL8K6COoiziJ7a27Ws/PWyyr9gTPpcMz61gJxlGjBNB3UAnV2Tl4mJNaLbiCb7rPShcT9ULRTgZGDHXxuVM1d2FPSu6E0B/SW6ELZJc1kT3bPvIpkjKi3uPR4R9tYWVu4pDUVMS5bq2Yy+xYrsZ9zhYZCLEtxZCrrR1JCdabeFOX4a8YsHfSa03leiYNIRtyagwrrbLKPJmcmYlDuaMsY9f4h09ITRqbUSpF1ksU66kFW8thkkF3kyxK/u1gBCYhXpg1QGSsloUn3Sxy7dA25+CsIVn39+I1bhGTy8VfOYvULFueMOQ7CbEdMpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJswgQF7yDRxuPkE9MOxIgSKghGL0AI5vJr2W+tpcBg=;
 b=Ux2F1gIkAEuRdhcdHwIbzbrokEq2RNAIWj6F3029cRs88FIOMy0ZAzzGwmTeJgj0CaYpRHOYLCg4RlNyzzMwIrzub+XnNlO7TLfTD9EO7mFpupNBYr4grKmXQIB+G7iWoDkNU7kNVOr/HoGTyrdHzYMkGwlv89p+dyws83YX6FCBKlYWSQo0oITveKwLUa+2V9PfKTeXM1pMwB0a/6h3WB9NTkoHr6TLf1BCOW3vIOl7SVgb48Ix5Wsxog3s+E4nDun0LXujTw1vddf+mh0vqXpbvmr4Au+LJqIcdUeB4EZYJuBhvNA1nK/s8WVAho8CmureZOsWgQoLdDImAmPCtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Mon, 17 Oct
 2022 23:57:44 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 23:57:44 +0000
Date:   Mon, 17 Oct 2022 20:57:43 -0300
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
Message-ID: <Y03r9wBs4Yk8LyC0@nvidia.com>
References: <166579181584.2236710.17813547487183983273.stgit@dwillia2-xfh.jf.intel.com>
 <166579187573.2236710.10151157417629496558.stgit@dwillia2-xfh.jf.intel.com>
 <877d0z0wsl.fsf@nvidia.com>
 <634db5c1f602_4da3294c3@dwillia2-xfh.jf.intel.com.notmuch>
 <Y0229P6z0E9Niw+9@nvidia.com>
 <634dc046bada2_4da329484@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <634dc046bada2_4da329484@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BL0PR02CA0046.namprd02.prod.outlook.com
 (2603:10b6:207:3d::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB5520:EE_
X-MS-Office365-Filtering-Correlation-Id: 673433a1-4191-4869-835d-08dab09b6283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HhM0hAhfi7w0E0KFrhrQBBaw85x4uA16LT4P865/3L+rv0bkhcKHsBZuc6BBiH1y3E9s+4T2KoFx4ikJzzcYbpzEJ6YZPYmvFOXucdmvgOHUWh/lIdZKMS+GVdTS7/4vaMKwznUiP/RGBlTI0332YtyNqdm7DeAWsFRKFPZbesbWLwHk5pE0mjvu4AuLSIJMMbyX2JkF/Pg+Bom9SeYnbubKqKpDm6KUpHMWWnc0Ek8dinvWiqMVa8T6vOufY31prTfqeXrJl3jBMnul/wv8msvT615M0B2v6GDlawhIoIUfdY3OIJEFB4jr38Hhx9HkW2INiA/J5kKKOUyg4TDSf62M+fwmFjdKFjaj4iNaB8brqwxpdxEfz+u1zc4dOrcxgbcNL4JxbzXyXVktMZseyQav6bSZ7UFr6H4j4BjESaGXqG3SWndN6bkouNTj8usjr2kianHzUJ1vI9d6dxduCUNazHNpGZU0sKWmWxIGzexjW+smZd28AgpFMQpU82RAUHr8unfyRl/GbHyGHfJ76fgjG9gxBYVCMuKFYnkxtuf20QtjdkLnErgdhvtvHRkAM6lqY+Ckg11fPVuejeByRE+Y+apyaB8UMb7dUHtsRQaXdGckDx2jnThf40mZytbXe0IkVKXmK7H7VSH0ZU3eWZEORrK7Nu4nPLNoO48DdHifw69yt0a+8b6n8InUEGiVjPTemI9RplSqjtsORFY6MQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(451199015)(6916009)(7416002)(4744005)(66556008)(54906003)(8676002)(66476007)(316002)(4326008)(6512007)(26005)(41300700001)(6506007)(186003)(2906002)(6486002)(5660300002)(8936002)(2616005)(478600001)(36756003)(83380400001)(38100700002)(66946007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4OoJuvvxqNgEK+adltYY1rscYeswkT3YX8bNorye6SSZsXuOapr2Tt9aovwR?=
 =?us-ascii?Q?5AULBA7MgBAevag8iYoDdx4ysV9Ri5gyn5CMIZmBaaO/y5Xzn2XMRNMgjn/N?=
 =?us-ascii?Q?XY+4hUKd11A6PyeLNmFubLtJ0cmV6I1TSOKKr8Vz0lTfWbOZQExtsQTkvPqh?=
 =?us-ascii?Q?2WHGqC/f/qjXGZJVmwCZqekEqF2KaKhekpWsgGHeC+nopgVG4sVlXysjiN1s?=
 =?us-ascii?Q?kd6dfb82AxWbcYMO3pRjyf9GgbUBR2rSWJIZSx9CSfgzbPltH+Tjl/Q7onLM?=
 =?us-ascii?Q?ex8eI9MQC7/MJSH08sN0J81dpaQumTyYeKg+8yZ6u35xtvB1+4Gpj696s6En?=
 =?us-ascii?Q?cszSCpIbY5uHJlRl4ROvkG4bewPhWlAvQBuFq8vz6eyVk6821oQp2ND+/1dI?=
 =?us-ascii?Q?zd6bLRdU0M3SoXhaPtL/IHORf6yc4DReTCDJthH7F8BHVQzHnRn6NE+asgay?=
 =?us-ascii?Q?ki7yMj+VmhH6KGUAa9m9L0FAGBHOKETNQXaTP1wqruUBLl+Ip0lpKPiCCHoS?=
 =?us-ascii?Q?yybMN5E8YDyI01zPYt3aRNPTKQ75NP91VuI1O0hdelAlNQ79QWGgBpvTik4D?=
 =?us-ascii?Q?+khlGXA7S+/pwvYLUKAMLv5pmdhWkKNClqPELADmj/uf49wg1CZfd1Md8gEG?=
 =?us-ascii?Q?N35Jauw/aFqcl/G/rJYWogKWS7f2PC67vUyQUqkNuWaT3mKHKAcoYretkD8w?=
 =?us-ascii?Q?ZalsfPqsgkpD7pzIop951/mTk3bQL+HLRXeF+aZaT+LcfVtB6lQsA5CLW4cg?=
 =?us-ascii?Q?K+R6llIGE7VzIwr9N4rLawi3qAgbZkLXL7FsUQjpKF65IPabC/LpfgyeLtDm?=
 =?us-ascii?Q?o0QrJTUHddOpa2Tadwg6bzfmoA6/dQSlylyItFqpKi6RlElvhrEQHXlRFl1Q?=
 =?us-ascii?Q?Lb0oeIK7kI8OZAaqIBs9czG0o0MgWQedDVNTtdue8dfkOtEkE9zqiOMOWqd6?=
 =?us-ascii?Q?G5/fp0A187wBZfm4Z7AMgY4zDLsx7ZCySKoB4CUGmH9ouqAizFydZCj/yiLI?=
 =?us-ascii?Q?DnDqJM/W1hD9Ddip1ChjAcThGwWKshgNVtJ5NFMRaL/RxQxirg9+knQ8X9mo?=
 =?us-ascii?Q?cS7jTOuRluXmYU1uorwoK2f8k6LqPARCd4Alc+61aLOVFkk2Z5WYYpvXzAWg?=
 =?us-ascii?Q?cvxS3yiwgnSwZqDkLCFZRqa33eH0VqohZnNm2OwVqu5Z1UtQHxOaFod/vQF4?=
 =?us-ascii?Q?EcIAaXhy2XFRIYfNfEeeNPHF+4a8O4Ok31NyKVuY2dOvFrIojlULgl5CsMh4?=
 =?us-ascii?Q?DnS//KJWSL0gciP8h2FL3luYxjEVHAy6SS6rqtW0RCzSWSZdUP2K1ytt9uc4?=
 =?us-ascii?Q?6vw+/4OSU9z5aj3Yx4Lfe+nYSjzgJzoXGRcncyCOHTsZEfnkYAElJvgE4roC?=
 =?us-ascii?Q?XtWlUbEhrLhrdSqmCUUF2mZeDj8U+LxnB+nuVHqHtjeubbzYZKVlamh5404z?=
 =?us-ascii?Q?upNnsLluuwhf0I+IwoXfBoECpxitekWBClzNO6yU0nc9HPvBTADWNrsjh2u2?=
 =?us-ascii?Q?xCEQciXptW5DJ+bE+G/+vqUd50PtwpjfTgxzOkt+IdiawEnVZn7JY7OUbymY?=
 =?us-ascii?Q?VKp9jZU9WS249qPDmZA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 673433a1-4191-4869-835d-08dab09b6283
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 23:57:44.7126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 24l0yEKkvXxK1avcWkL1iWVtZhKo3XO6cJF33AUQ+I7M0COHu1EJmaXV5BGtIV3x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5520
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 17, 2022 at 01:51:18PM -0700, Dan Williams wrote:

> > A good design is that nothing has a struct folio * unless it can also
> > prove it has a non-zero refcount on it, and that is simply impossible
> > for any caller at this point.
> 
> I agree that's a good design, and I think it is a bug to make this
> request on anything but a zero-refcount folio, but plumbing pgmap
> offsets to replace pfn_to_page() would require dax_direct_access() to
> shift from a pfn lookup to a pgmap + offset lookup.

That is fair for this series, but maybe the other pgmap users shouldn't be
converted to use this style of API?

Jason
