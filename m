Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055625E5706
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 02:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiIVALF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 20:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiIVALD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 20:11:03 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398C0A8CDA;
        Wed, 21 Sep 2022 17:11:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8+HAbM+ecL45+y7FyyKg7gpQIJDAQ+TT58zNZoWcoArY9gfhNjn6uKetpJLYI/fi+F4wnzzY9s2b4U1FdLZX3yx5HFUw6p/U8kuoti2TGQpxjEhpuYpoQ+idBWP/ch1pFNz3Qyn71ZSRWGasSs9piV0yhGtM0NttT5q9p2FK2Ism5SZZ9NtdgSAS4K7ta5HWzgB0VF+lcu2pFGujN/3pY5snM8rcnISuk3zj3X+lzXSY6XAWzpyjLhf2xTyLGHV1I84JNB09HwuRrlIwHaJs6dadEpfrFo4p8TQSYN9Yn7MnkQ38Kae/6PImJvi7sxkr83v6RIj1H48h3CPofVXUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lfD0Ghdx9k7JqlBYnIR5+9bNu8Is1JDMV5hPpvvLGic=;
 b=C4L0iuAY7ZdSQ5qVzjol8uCXFZkOxhYnrd4NiBnvMdz1tQ/wSTixpdT+9XBnjR4fV3Tb33x76LuuxKpolcsEMcLdDyczuTgrEO21hdroDfQeBm34IdWrlFK9VI1x1CqpKOYXJ9olkIEGMNbSUvJIqd+6znGkn8DlR3fqRP/RS28ypiLSYafqBHQIJcsmv505Hw7o8rLPSav83BI8bELxcz3ZAPjWz/WFjEUTqkIwXNk9RRsW53D+wY7w1eF2V5mhpMVzqsVPjX+JI3kO2lfS8GggD7xpv97y14WBaDjE4sL7rGAnwvawRxNyuRufiRUgP3jr1uFs9Izi1pGLsYretw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfD0Ghdx9k7JqlBYnIR5+9bNu8Is1JDMV5hPpvvLGic=;
 b=XYct6Qob+BUBcNYDs7xt9FFf5q+DLvpn9JrmsLtgTmDrYNaOGv0QTzsPfIOT5K8oKj6TNE3D+MLBSZligOti9UbBgU348EtERXZ6Nqg+gKFlOcU/mgF6BB+gDJVrS2fi5SUPDNii8aU9myMfW4zL4l260yu33kYnwEuHgm1vDsbQxeQ2gojx1WTt/tVK2tjWUdAyboW2gw6FdmIUNZmVM1Urkk3kb3GAm9JLsu32QdbQpBfPhu18V2e2QLdgadcGuIWv7r+RJeBwnu1hY1u4HhdEw/7rvuVPeZp1W4luiwtUNMYKy+3HWwvQC07Et1GRHEFPT4Eg4prOrgJjdZIa0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BL1PR12MB5731.namprd12.prod.outlook.com (2603:10b6:208:386::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Thu, 22 Sep
 2022 00:11:00 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5654.018; Thu, 22 Sep 2022
 00:11:00 +0000
Date:   Wed, 21 Sep 2022 21:10:59 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Chinner <david@fromorbit.com>, akpm@linux-foundation.org,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 05/18] xfs: Add xfs_break_layouts() to the inode
 eviction path
Message-ID: <YyuoE8BgImRXVkkO@nvidia.com>
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
 <166329933874.2786261.18236541386474985669.stgit@dwillia2-xfh.jf.intel.com>
 <20220918225731.GG3600936@dread.disaster.area>
 <632894c4738d8_2a6ded294a@dwillia2-xfh.jf.intel.com.notmuch>
 <20220919212959.GL3600936@dread.disaster.area>
 <6329ee04c9272_2a6ded294bf@dwillia2-xfh.jf.intel.com.notmuch>
 <20220921221416.GT3600936@dread.disaster.area>
 <632ba61d7666a_34962942a@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <632ba61d7666a_34962942a@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BLAPR03CA0084.namprd03.prod.outlook.com
 (2603:10b6:208:329::29) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|BL1PR12MB5731:EE_
X-MS-Office365-Filtering-Correlation-Id: 29c44de1-b3ac-465d-220b-08da9c2eee12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F1ppEliV65E92PIPvn5jbmq4an7SW0j8iCpa399j/nsLLrzo/53Me+fcRqZnM7SlzGN7g80KRpp6nLNuJwhwDSqW0VoOJ52coqsaChvi0RDiJnfFCP0Qh3KrK+IYwaIZ8KLFefXu/iD5dCsI0L9+dtPE2Y989UlRJ3VP9ofn6L/fVcVCr5JShHFX5JDeY5bgGjsMUawkGkGFky13kn5TrjTt5I+U9VUUM7K4uV9eC787i2/S+ImBnSJ1pZstnBj+MvYhMDvp5T0XhV9U6ZMrPFZktvb/Tj2pJlhqG4d3ZVibD2w5y5Tknv5duObUpsr7zB6C9WBJyrz7OZs0ngdh+jZYyzoZA2VTGe0fGkgmG12TH10SepBGw8nfjD2zsSUyH6ewn3ve75TquVZTUV9gifIiQw5wd1AXaCbPAO04tAV9WGxyvJlnk5zFQ3ocNcb9/CAEQRfQ2ORc0rCLiNidrmdjeYpZMt/RlmCTAfy3xjgFI10ng9op11fFXtweH84JwKbbHgtnL/5nzLia+TlvyP2mDvZO/ip+T7LpQmane1ep9SkGyq9YtpocXl+RoNxzspI62kymFhqij+l1N4xQRa2mU9o6184cKq5aAnJCO2q33EJnD//p7pF6WrI3HbBmmRPOaEdr36GAQ+jlhOLAQqi0TYwLqWdno/g+ZT9t0Rk21SIW0QzwcdTRY60Zwp7q72Qb7xirvDWcDmKYRs0McA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(376002)(136003)(366004)(451199015)(2616005)(7416002)(83380400001)(186003)(38100700002)(8936002)(5660300002)(66556008)(66946007)(4326008)(2906002)(66476007)(6512007)(86362001)(478600001)(41300700001)(6506007)(6916009)(54906003)(26005)(316002)(6486002)(8676002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mfuXFjSmWuGSlRjmMeotFschbb+RiKA+nXHpFjdTyS2MIlJP2/dNP6fI+7vD?=
 =?us-ascii?Q?+3hweXzjwqt+d5ip6r4mtmdK8lFiuGWKceVicdtPwbw70JC74wDqBxngIXCs?=
 =?us-ascii?Q?oRoXZPEeJhWrAsFqG1/hqtnb6zaq+J5G1cYGJxUiJWic5CfPB7N/HuQhktmk?=
 =?us-ascii?Q?e4Eb6PrHjJKGFy8VU6RFLwIKTuDO7nrs5SCVw++/q9m8Invh21p9bWmVUwFD?=
 =?us-ascii?Q?fTapfptrvzdZyeKBtcAoe4TNcHQZwWLBleCWsz0SDByWT5OZhXdqXUpxp0PF?=
 =?us-ascii?Q?9OVePQw2fIGgFzJ6SyY0wo4NpUa+5mCtoc7XEaEC8NMHlYbUz/GslhoU0Xgp?=
 =?us-ascii?Q?Xqr73+yuDEPPu5JXtJdf8STUIZH1T9pDSl9HPTuiddzq149BLra8OuIGFgra?=
 =?us-ascii?Q?hssFeCF2ueNzTbbeLuc+GOotQKNYsWFJ4ZObGqM8UFVxNL0INayEx0kG4zkv?=
 =?us-ascii?Q?WaBPjC2/wAwzYESlUT0A0Ng1idwOH1mTXb97T5zb4pDQAhq14uzw3ZTTu7kx?=
 =?us-ascii?Q?LkFIy9goFB8WBJcn68SKlGb5I8jg0zdP8Z12ZVrDYj7z7NUPymFMGBAdEcKW?=
 =?us-ascii?Q?H+vSXufA3zPsA/p8ycHg4j7GtTKaMHK4xIw5BT+FsHWYaPU68Wet3lL1Pnjv?=
 =?us-ascii?Q?QHsGnhlnhIi0a7/0jPtvEJ5IiZ8d/6xjX1x94Fc+Gfh2RP9IId4yLbq32JzG?=
 =?us-ascii?Q?Q7PI8l0q179z6CU3O58Wx7hm7C9GAcATM+Dub9GtudaPhpu6mTvNI6JYRF2a?=
 =?us-ascii?Q?qKayuDfl1GrYAVjsXNPbpiu2UZs1kh6NXvxb/Gt04xj3hqNsL+dVDijyXpYi?=
 =?us-ascii?Q?M1RHl7XxiWVC8w9fgChjpb2DPbce/balKfNGa0gOF64CXpvDcpmPMsxDJ/lM?=
 =?us-ascii?Q?LdBYJ8YmyKNpnjde/NeRmABKJwgBj+4jPHde9PR2FISh/nw6vgRvBFpkfJgh?=
 =?us-ascii?Q?6qM1xzqJTbhMDsNHEfqYDFQ/QM9yK1l5YLAf+k2J9pIHcJOWJl3HbOdRHLj5?=
 =?us-ascii?Q?Lxp/mOQkP8lg7UwumESy9pa8zS+dSC4oDatslSo996gflwdbZroidWQurxa4?=
 =?us-ascii?Q?c8LaS/dDBNV7PmfMUBohVEII2s/SXJ/DVFo+6+eTlVNeRC79SEamqlLvlBoI?=
 =?us-ascii?Q?yab/eHkY2X4skIrm4KjwJOwOWfvS0yXCLZQ6eTgRtk70HVawfF003ejkz6xl?=
 =?us-ascii?Q?u3mUca7cb8aHY9UcBQZxyCGxFsHjvoBX4K92nhxPAa6EnXE5XC98zc/v2aCt?=
 =?us-ascii?Q?pK/pI9AIFyXGcO85LWuhXGCwayWDKKv3sGkw3xKM5PSbZ/BdCAelgODg5E7h?=
 =?us-ascii?Q?qhEhXTqBU7RIsd3pQX2Pl7GQ1naC3+ol8pgPEdMI5n3EKzui5EfIhGAakO2/?=
 =?us-ascii?Q?dRV9ouBhSY+8B6JOkSv3cvvBSrEQxGjjvwFqNEYia2g9tmSjPijToFEFG7zM?=
 =?us-ascii?Q?3OnsICHs2mO49WcF/DfcYl/lpM46bJgFKFsIqJvGXyco8HB1kWRs+syz6A56?=
 =?us-ascii?Q?ya8r/TO1PeTHOIxBq6AvZgsLvGbJRixSQF2Eq+xNQSIHLGirhbAO7Ku5kRpJ?=
 =?us-ascii?Q?YiZbr/HoGjieU3jDKjvUwFSf8tuu8cokX+/7+GM/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c44de1-b3ac-465d-220b-08da9c2eee12
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 00:11:00.4503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U9SkevczG4Y855p7wEZk2tbUJnb5aAkRtH40Fkw64EqnsIHqmV1HArpXmMwoc3nx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5731
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 21, 2022 at 05:02:37PM -0700, Dan Williams wrote:

> The scenario I cannot convince myself is impossible is a driver that
> goes into interruptible sleep while operating on a page it got from
> get_user_pages(). Where the eventual driver completion path will clean
> up the pinned page, but the process that launched the I/O has already
> exited and dropped all the inode references it was holding. That's not
> buggy on its face since the driver still cleans up everything it was
> handed, but if this type of disconnect happens (closing mappings and
> files while I/O is in-flight) then iput_final() needs to check.

I don't think you can make this argument. The inode you are talking
about is held in the vma of the mm_struct, it is not just a process
exit or interrupted sleep that could cause the vma to drop the inode
reference, but any concurrent thread doing memunmap/close can destroy
the VMA, close the FD and release the inode.

So userspace can certainly create races where something has safely
done GUP/PUP !FOLL_LONGTERM but the VMA that sourced the page is
destroyed while the thread is still processing the post-GUP work.

Jason
