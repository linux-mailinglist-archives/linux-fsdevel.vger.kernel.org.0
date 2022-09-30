Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CAC5F1158
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 20:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbiI3SGy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 14:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiI3SGw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 14:06:52 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210DB5AC7A;
        Fri, 30 Sep 2022 11:06:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZT7TIqupUpf4IhMViVvZNTIVcuWVgTgzdNO5evlNZGZBgwxrjBfOu12A+fgYHxtjDYiHQ+bdeZdRMoyd9EkxBkOvzmh3LCeisiTT+bBTSqtPeXe5H+UEXoZwxS9eqQzo2jRP45WEXwmmuhm8+YruQbzyNiaHlgjnQYtYYLIRrChuiSttW/ydvIrkf/FMKivr7BEBmue13Upf5tesCTfMm35cxp5NHnqI1lKOm0ifZbiUxrmAFt4ZIBr3u81N/KpFPREmobMGMgpf3dLVeZPhAsBqsZNyDKVVUfUIkt58LlqQapkzMp8tOLXJXKH7X8mnhS8mA7tl0JC5zR5pOfllg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bb5uFiZYs8lanDro5sdYFGcDBK4MEWw4eYq0LXwYFpo=;
 b=FbWDOaN4/qisrmN+yJ3pVgmxBt2ePE6+V3cEL6+BFTF4Q1/fSZI6BXkiNl/Tm3T8LroWX6njKE0lXECecxld32bH1cUt10lgCWanzxhVQVB26A6mReyfJfn8Y+Qi+/ab0+v4iEL4m3B3Ws9T5y3wlSdL2f06IFgCGLblJQgrNOIbrpunFyQ/W5FKDXMfuz71wmJTog827n7maPD4ecRR3EtwA0qqLvfkVnQ3rkRtZoNlGL9emy4wmRWsuJalKNAN2Ktt15dYcHXV+vj2RhPmZfcufTOtOowWZ8o8VhyW4k2j3guCHvKoOlHSaPE8XhQJBkI3Mhs/+tZnzMSfLTQK6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bb5uFiZYs8lanDro5sdYFGcDBK4MEWw4eYq0LXwYFpo=;
 b=fp2nbgtxNJz05yAmH3FCNqHowNYaa//vGxsaW+8OfDlywjsCBxuQyRs29eyoVfT1oOnIWl21XyrUfOffSg1jhHTkg4vgdy3oP/NuAl3AwN+bvdByi/3/boqWwqaqDQ8OvB8SRAYPv4FHRpm2MdgI/Y7Cuz+zbL7rOBA8gj2jOI9rb2TFmCwRGBxeH29ZGuUf+L+9HmEBIIc38nJKJfGRXEc/QcPRbh4cet0ep2p+kYZu0/orGGkNckuoRfO1vd6U54Pnp1CWtePmKuRRyRBDC4SHAVnvdDlDQ81/dhcyTtJUcS5woa21Ikom8TLDKhiiooLJyXblWvVgwJa5adS2Zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by PH7PR12MB6809.namprd12.prod.outlook.com (2603:10b6:510:1af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Fri, 30 Sep
 2022 18:06:49 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::8557:6d56:cba9:dbba]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::8557:6d56:cba9:dbba%5]) with mapi id 15.20.5676.023; Fri, 30 Sep 2022
 18:06:48 +0000
Date:   Fri, 30 Sep 2022 15:06:47 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        akpm@linux-foundation.org, Matthew Wilcox <willy@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 05/18] xfs: Add xfs_break_layouts() to the inode
 eviction path
Message-ID: <YzcwN67+QOqXpvfg@nvidia.com>
References: <YyuQI08LManypG6u@nvidia.com>
 <20220923001846.GX3600936@dread.disaster.area>
 <632d00a491d0d_4a67429488@dwillia2-xfh.jf.intel.com.notmuch>
 <20220923021012.GZ3600936@dread.disaster.area>
 <20220923093803.nroajmvn7twuptez@quack3>
 <20220925235407.GA3600936@dread.disaster.area>
 <20220926141055.sdlm3hkfepa7azf2@quack3>
 <63362b4781294_795a6294f0@dwillia2-xfh.jf.intel.com.notmuch>
 <20220930134144.pd67rbgahzcb62mf@quack3>
 <63372dcbc7f13_739029490@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63372dcbc7f13_739029490@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: MN2PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:208:23a::19) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|PH7PR12MB6809:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c5a7adb-a01c-4197-8f3c-08daa30e8b2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sHUOI3cABZy6S4rj94mUkz2C26FaM2RzHqO8AR/6IfstHq0WYVKxIqmQJiDcrVXo27mlyrkxWqZfwwPxPzVyXFgRlwsivfrztrI6oKYNWbLKOMns1N8dwNUswcKupNsHIYagBZZwg9RcPRdv7VLfxxAI0lWNYAYIfMhCgA9WIQLa39mRyx37zcTabjhuroDGqyU2YBjCAYcE41F0UZD6UzhVSr5ubcBv+9KZzZiBKC//nzvaxuizfbExw00aS39aZjgtqGlqHIx+y4Z269OKnjHqBF7BfKxEK9VdtB9GiBOr3iX8D1C85Czu2gS/OeCNESVmSBQGBGiAxOn9AlZZzgKOrr5gtQG+WGwiV8FxJKAG1PxtAA7QRNSH4ZOkuol8OW4EVdxuwZkZoaKX+Q4EOuzWNGI7ad8d2LkN7zOS6zrwP0rfl+mBfsXHE2/V8C4AzrwRjFIABJsRAUGXzO7Z9T/EHyylZ2t6GWNT2XFRu0HwJY0v/LX2Hc1uZcA7wg/LyY51IusygAUTwzklv7TmE7M73FPK3lD2kFT2dI91RT08pJW+3ETbJROWHJqao8zVW7VXngYjVPmW51dxz4LgKiktjnPvduKjisPynPSeW7N9QOgXaIWqh4QNMcMOTapqm0fRo1TCJWVJ/wJ9e4gkjQVOwjNaSHmwWeQDsqRt9FFXfxypILzyzEnFJ5BVF+m/3y3NkKLNrKgpTdFpj+fTrZU9yYGCw3fb4AkNp2Lyt3BW8PcAz5d6p/v+qwIlUb38
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199015)(478600001)(6486002)(66899015)(66556008)(66476007)(2906002)(6916009)(5660300002)(7416002)(66946007)(6512007)(186003)(2616005)(6506007)(316002)(26005)(36756003)(83380400001)(86362001)(41300700001)(54906003)(8936002)(4326008)(38100700002)(8676002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vwSCPACWCehZ61pX859K6ldd/hYj/z2HSvFfD3HhEaRqRqg5Chq2tAc3OF94?=
 =?us-ascii?Q?4rDevhDZ82ydw7OEbiaFszyylFmTZgdxhy0cowMlpBal/wrZTEAm+OLMxtQN?=
 =?us-ascii?Q?Sg7BfK9KPNFgNBnDTxAJkaPmiEwqar7LdFi1w/LXQ9BkIw3Gpg9XFMtMjKLv?=
 =?us-ascii?Q?r/TNxmTJ2F/rFLbzR7FgB/bfRry49FwkZJe6mxUVdqza3piIdOobomUAzC5k?=
 =?us-ascii?Q?Pt+8kqrW/iJfrpypPTszBuylqwo29wrndNWR0l43asDgzOZSqSlmUMWaBpFb?=
 =?us-ascii?Q?ZkdH1eCuA3z7oFlL89yU08u5sDu8IPkNDaSYPmcV5FUsRv2JdaCT9hYcIkTM?=
 =?us-ascii?Q?VRasf/uKhRUt6D4HFdOl5vvNx5iHmTNx/lFWZ7BHSqtM2s72Log0928m/O1J?=
 =?us-ascii?Q?aqdIrYfh9HZRVwIlZNtJziqLt5fAc4Rt9ke5JV0hFihqzueOzpetM8wrPMS3?=
 =?us-ascii?Q?6hDH1N+YoWuElwK82KjYZT0D/WoLbZt2LP6kYG34+corJp7zhilq1jGFDU+v?=
 =?us-ascii?Q?A4BF5K3CJ1QGHXuakF25jeStid5v9IWtQcXGEwuKuDMSf5aMpLrYHHyG2rRO?=
 =?us-ascii?Q?T6p7rbc4oQ/EJNijJoLCtXsKi4WekoPh0GrGiZHTN+rffCX9hhUbmdZFQwn5?=
 =?us-ascii?Q?KtOnyvvp/q97E4KHc2/U051xcA4C0ib80/2a7Lwi/4BzptLrZKetJAxo6bbx?=
 =?us-ascii?Q?SLjPYu+Bs9yqXbatxBwv9oLlRFGfUoLQNKlCp9Wum8/0gusYe6jfYL7ZDuOq?=
 =?us-ascii?Q?co/dLjVfnzJHuRmMtAFl866pstH+mi92rWvHyZyDAtrBXvCcdJn6ejofI/DQ?=
 =?us-ascii?Q?u6cOM4/A3ecBRM4LAtp2/BIa159LcQXvGeZaV7rHwvhZY49mxxI8SMEoGpCm?=
 =?us-ascii?Q?tMtTvziRX0TLHfIzJW6jM/ANsbHIkgxATZ/9fmJDYN6VPQ6oYXOSv+Irjat0?=
 =?us-ascii?Q?9Hhk6wQwNCMMZtnUEhCe8LIulnbUSIHpMqgC/NWyp9xFz0/a+B1Eb4PvZNwD?=
 =?us-ascii?Q?q12cvp/QapxxbjJHm7MExHv6rrF1qf8J2ZINaJcJobo/GX9sHKQoMYMWByLJ?=
 =?us-ascii?Q?Nx/OR2RiUiAotVAAb9dZU9iI7nqeK7DIx9NyogzfOBpZh9tl52qilGfmK+54?=
 =?us-ascii?Q?nrWBrnmSenYh9OJ5st4enANMBB77mMD7KzafVqaSH/mQdI7MhEhqVEnGv8RY?=
 =?us-ascii?Q?lXDTfnC2CFVW5qXe4Plb9jl91oWpaQXxURYgHJpsP/vvp4JOyYO6az2cRLlf?=
 =?us-ascii?Q?wizX3PyIGouXwyHwlecMhKvhCTZXvHJoDJiwExC9U54fZg6UYrLQl2tkTQCF?=
 =?us-ascii?Q?A/5Au4NUGDqgcCcnKX/+d6cpZ6QAHALtH3bOz2mzaHNVDlrc2yez/vr1ktN6?=
 =?us-ascii?Q?fUfKlWm6Qot0jvX6CDoa1sLkgRuG83a33gMKHfXcQ3FYC+TPYMmzu87+515B?=
 =?us-ascii?Q?uE7svM5Fggl4HxcUGbLdGTtF5d2ga5gvHpyB7KGv/rEbebQhaLDdBGeSJ/T+?=
 =?us-ascii?Q?vRuRZPzYUMzTFxxI/sAVACaI1bLDb6m1UFjQUYDw8l30JL56brxyqklUY6WF?=
 =?us-ascii?Q?KmTDyD9/a8x5ejdaRE0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c5a7adb-a01c-4197-8f3c-08daa30e8b2e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 18:06:48.7876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FfY8d+o+4W779KJcZ1jNXczR7gBEpBhAnShus+6HbNQbh7Tk5OksH2geP+UJoo1J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6809
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 30, 2022 at 10:56:27AM -0700, Dan Williams wrote:
> Jan Kara wrote:
> [..]
> > I agree this is doable but there's the nasty sideeffect that inode reclaim
> > may block for abitrary time waiting for page pinning. If the application
> > that has pinned the page requires __GFP_FS memory allocation to get to a
> > point where it releases the page, we even have a deadlock possibility.
> > So it's better than the UAF issue but still not ideal.
> 
> I expect VMA pinning would have similar deadlock exposure if pinning a
> VMA keeps the inode allocated. Anything that puts a page-pin release
> dependency in the inode freeing path can potentially deadlock a reclaim
> event that depends on that inode being freed.

I think the desire would be to go from the VMA to an inode_get and
hold the inode reference for the from the pin_user_pages() to the
unpin_user_page(), ie prevent it from being freed in the first place.

It is a fine idea, the trouble is just the high complexity to get
there.

However, I wonder if the trucate/hole punch paths have the same
deadlock problem?

I agree with you though, given the limited options we should convert
the UAF into an unlikely deadlock.

Jason
