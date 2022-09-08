Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43CB5B2626
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 20:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbiIHStf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 14:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbiIHStc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 14:49:32 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF45A45C
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Sep 2022 11:49:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYyb3FMfrBa8IJlOh6i7zdcphutsbjdbCIQ40Ne0WqrDp9elSm6aClIKr37A3oHpnwv/cb7NHwWJqiiYIJYgir5lkyuUvTfXWah+ikYlAXzpfNgACXtoBGk1hINJRjG8JxOXvs9M2QdeInaXsp6Hxv9pQ14pzzpLgN2lvXbDmjElXb+h7XvCZeh1wMp9jHuykaQHxkkM80blrCHqB9PnaxSxCyxcnISuYLpx4PFR0E8Lq7mWhCORyTk4bSL+Dw/UWXbTHhlj/yxURQI3RAyYoJUCzFGiaNMOGm1Q9zxkDUQpjOyRAQPtZmvZQaWt+EKwgpycjPcTPI/sx7KXPVmd2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/fo4OH3zDpxbb5IhFWYYv0r9/6bHmJJJAPySvTU3VY=;
 b=XwevFLRUra9jBVHRLN7qmyTxRQvCm+8LDKjlw4xsy5hLdgOxGO4cgls/8T+YS1PmXMNLvFFZ8m1eO2IRMkkzeRvyJ6WYSGrqmnWSsrHzjg/b8tKrfwdfAu8kBQ3f8Oy0HqqDBkPhR+OYO5AW7iNtFazZKBJRSaPhdJKksOWr1zOorn0Fm3qq2qYqpH4nV6oghfU+jIeXvc8JbQd2ciKNyIzUYAfrUKx5XL9h8JXOs609qjjmfosV8aY5Zd/foN1TmtH6ZU3qA8g8aI6LWBfobi/StI0bGx6hbb/DgIb2YGuSrAbyRdZNu6fzII4J7E9J0UXUbZm6XM8o5q7T+u2f1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/fo4OH3zDpxbb5IhFWYYv0r9/6bHmJJJAPySvTU3VY=;
 b=SL8NUrht9R5HodVVEm9qwdDf7g9zr4HD6dDvAHkAM9xs6vAm/WwrjxC53QsFx9mNvmLFuVIcvW6Va60XiTbNjFj2D4uCTXWeREZWIntWKRWcMJZJjsA6Ly8w43A94nNnvS2qsQ/sDPmBQuYBsQpt8JbRVXQvdmvLYogQ5YQR2FBuer12nQBimlVpXMlP0u7p3sOtp8Mo7mjUZl1XfpvL4CT3ExvBCXYCQFSAzM8zUj4Z6L0GDS1egvNmDtJuCAzrUdbFgn+4gcfbHUbxmsBNS4JG5YxJeswobqcabqxcao4YDwnAasN7CXCGXHEvkMf5luD1EE/CNhUOuFjE3kOEWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BL3PR12MB6644.namprd12.prod.outlook.com (2603:10b6:208:3b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Thu, 8 Sep
 2022 18:49:25 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5612.019; Thu, 8 Sep 2022
 18:49:25 +0000
Date:   Thu, 8 Sep 2022 15:49:24 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/13] Fix the DAX-gup mistake
Message-ID: <Yxo5NMoEgk+xKyBj@nvidia.com>
References: <YxeDjTq526iS15Re@nvidia.com>
 <631793709f2d3_166f29415@dwillia2-xfh.jf.intel.com.notmuch>
 <YxeWQIxPZF0QJ/FL@nvidia.com>
 <6317a26d3e1ed_166f2946e@dwillia2-xfh.jf.intel.com.notmuch>
 <6317ebde620ec_166f29466@dwillia2-xfh.jf.intel.com.notmuch>
 <YxiVfn8+fR4I76ED@nvidia.com>
 <6318d07fa17e7_166f29495@dwillia2-xfh.jf.intel.com.notmuch>
 <6318e66861c87_166f294f1@dwillia2-xfh.jf.intel.com.notmuch>
 <YxjxUPS6pwHwQhRh@nvidia.com>
 <631902ef5591a_166f2941c@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <631902ef5591a_166f2941c@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BL0PR0102CA0003.prod.exchangelabs.com
 (2603:10b6:207:18::16) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|BL3PR12MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: 065d1899-e735-4067-3caa-08da91cad9fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: URQdMlEpllj/UfMnhfGc36X11TsoKK6sWRoKl6bSE+vbpSFwEHAN5YfgegJbp28HUXpR9Doss1puhHsoyRB1I8M+PCZczrVWGEBUdYl7r3Xiyf2ffTEOR9XwVyM51eu4oq6YjtV72DadQ04I+yAHWK8c25V1GKe5qjrfgBJWyVLeFzUavtgw1oBOZ0DZKTl7czkq05fxEzSDGek3KygqOjRDBbfGP7spVlEfaCfaWAM2qSYHq9xUGPnbt/99JgzsDXz0x9ZvThUAD9e7YhCn9b4/QXh4NuRmSY/poYngp3/jriRz7r/eBL6U13zHRkzPHEFwzduQuOihiwyBcnVEyv2cMSIsFs+15/uljHBP3gLZKNMMHyVemIIbFn5twgDPEtYCxF78SSvUTWYf/w4yO8MC8W7mb1FNqRHLQMQ4CWCWjBZ9n07ayG+HOkyMdELAr6BlXIZKb5H2fQZjontqock3+rTkWdV1Y7Giw0yfFWrU4JdFTiluTFr3bWvd7fI16PlCg4zRZKzz18RIrYVXiGhxTbYg0rBzGyQaNZsvQfhO6bQd01HxRPbwX1s125xf92BJN+ylRl9HO++n6gD9yXB4ZIdalQRkytuy+cY1xkjwA9K5DjvYmOlcGTNRVnlOFdLQwczUtMFyzVg8Y5dPPcpnCXx1ZgHQPPGJ1yN7QP1G1+K2PRD96eE66xeoXTdIjQTf+gPWEtQspPbqF9/Oh/0csBPU0HuvFFSl10NO6fqbk+KuUSXKxBu3EbWZfJqu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(6512007)(6506007)(478600001)(26005)(6486002)(41300700001)(2616005)(186003)(83380400001)(38100700002)(86362001)(8936002)(66476007)(8676002)(66946007)(4326008)(2906002)(36756003)(66556008)(5660300002)(54906003)(6916009)(316002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UDd/KXauMJtbRhy1IXs0p8eQ888TiB2JjAB1pHontVwUcPSu48w55Qm++3LE?=
 =?us-ascii?Q?wf7E45Xa0tlqFLoKJDz11Kgrg2Dn1n8+MIub8RpjERAH2Jp5gFZ0CSHX9TuI?=
 =?us-ascii?Q?TNsAuyuYOKlKKKBifjzWVZaiSm1Z+W5LR6LZ7p7G0W79GNJIv74ldOj95DsT?=
 =?us-ascii?Q?7tnBPCPCuITrPXhFZ5vcvqYsa6xK58hpvH+wbcbOuhFkdwkMEdCfKeHdXl/M?=
 =?us-ascii?Q?XfVQtQIE2UBtCHYb3NRMZbx1HZ9bg754Qz1LvKSWjwFFFfl6hAFwxnAoWL5r?=
 =?us-ascii?Q?Ubnd3295I0rb8JfN7xB2gP7w9XyvecpucwKHu4qIphwyqeqLf62+taMJGX7a?=
 =?us-ascii?Q?adhqt25qQRjf04UaVzZPlFCHf3hjGenBcU8xCLlVRziOly0gwQEb3F+Zv3YX?=
 =?us-ascii?Q?aZgKwSDZKaxK/hSfS5S3N2zLtIgjpoOYJOH23SbGXf2nLwb0WjzzAky706OE?=
 =?us-ascii?Q?TEy+chFHCoqVT574aiHytjWALaX1Uljl3tpwGoFgMGfMpziacLb/3jfsAKuo?=
 =?us-ascii?Q?wx02tJQHpS4XvYPugyBUL0hr5xRaekRycEXBOBVKbKVN4hFGCvUz+sNfAdMI?=
 =?us-ascii?Q?q92yg6iBrdZkP/PHkRMAMs6TM7THDrIm9zileePnb4HFXJMQGhEHPybtmI/u?=
 =?us-ascii?Q?yh5CcGXO5GA+xG42qoRycX/p8RhQQOQ9C1F6mw+JphNWYyYnFRFCEcVl2nzg?=
 =?us-ascii?Q?tHONDEDfDvNKcV/UE3X826ipyIFtNvs80fDQFbfGHKrCuHH0REK4cqKeDu2k?=
 =?us-ascii?Q?QjZpx83jIzUJbAdTeUIFyTzhEk6KQMVEWbGGfzYfI8Svq2fhHmXsoBPjkU8f?=
 =?us-ascii?Q?w25cV7VrGsweM8jExN0VArZbVhprt2K2TlEu74ZVBBsc0nsg5UVNkSO4vVqz?=
 =?us-ascii?Q?bTwHYwROMzGIv1JUdtJzU1uLAOMSQ8pUgvTWRHyao8Fr07E2AhSQCmsoole/?=
 =?us-ascii?Q?2eSbUCf2dG8W3yWIGZOQlABnBbJrxQoxs/LDSt1Gn0Dxv5inwcIMoQOT7JTi?=
 =?us-ascii?Q?iJtf55NATBo//+u+dOjYPMvctTAGaMzvsc/HGDqpsRkN7pretqQyFMIfVd56?=
 =?us-ascii?Q?YluNsm5NaD/JnfuKEnlrOwucID/e8Te5NjFKS47UzdijLgjj/hyxjPZ1ecmh?=
 =?us-ascii?Q?5gtVQOI537Hn6JGC4emm7OYcKd0YrBKb+BAwykwkrTDfdJu2hicldhILOA4h?=
 =?us-ascii?Q?KCBcHKZdFtlPzNwaAnBgy7q47Q5DtNosSKSpFNrfzv9kqzoTWuZWS/CpERRW?=
 =?us-ascii?Q?f16j++tX7nk6igyaQgS3PS8vhpQulCMGeDaavOPKFiBfk56IvpYB6Cu0eYPO?=
 =?us-ascii?Q?ApqQ7V+vjOr98Qib/hU8diQ0nsrKabnBmeRRREE5X8lmlC0AO9iNcbL2kBy6?=
 =?us-ascii?Q?b8FOnGJ0EDh0wDf4Bf32TR/ZD3d1nloYToKNhzFIgwgBfFgVmW7MrThemhQg?=
 =?us-ascii?Q?c1pB1hZ58yNd9pf9bzESOxOHTkSjDETt8oL2FSSSJLLQjIdfA1we4mHbk3qF?=
 =?us-ascii?Q?mxrBEBvaw481ddXQqopAgZ5uBrFEkvdhZlCJWuL99myBbBBAL2ewhAykSDl4?=
 =?us-ascii?Q?0iiYK40tsfJ87Na+H6UYV/XVegQQLf/c4PluKL5a?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 065d1899-e735-4067-3caa-08da91cad9fd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 18:49:25.5206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tpXP+EGNvct01P0ipzURg69eV14LjkxuDyFTMLzMnJz2PVqNolaOrofGvXdGeo/0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6644
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 07, 2022 at 01:45:35PM -0700, Dan Williams wrote:
> Jason Gunthorpe wrote:
> > On Wed, Sep 07, 2022 at 11:43:52AM -0700, Dan Williams wrote:
> > 
> > > It is still the case that while waiting for the page to go idle it is
> > > associated with its given file / inode. It is possible that
> > > memory-failure, or some other event that requires looking up the page's
> > > association, fires in that time span.
> > 
> > Can't the page->mapping can remain set to the address space even if it is
> > not installed into any PTEs? Zap should only remove the PTEs, not
> > clear the page->mapping.
> > 
> > Or, said another way, page->mapping should only change while the page
> > refcount is 0 and thus the filesystem is completely in control of when
> > it changes, and can do so under its own locks
> > 
> > If the refcount is 0 then memory failure should not happen - it would
> > require someone accessed the page without referencing it. The only
> > thing that could do that is the kernel, and if the kernel is
> > referencing a 0 refcount page (eg it got converted to meta-data or
> > something), it is probably not linked to an address space anymore
> > anyhow?
> 
> First, thank you for helping me think through this, I am going to need
> this thread in 6 months when I revisit this code.
> 
> I agree with the observation that page->mapping should only change while
> the reference count is zero, but my problem is catching the 1 -> 0 in
> its natural location in free_zone_device_page(). That and the fact that
> the entry needs to be maintained until the page is actually disconnected
> from the file to me means that break layouts holds off truncate until it
> can observe the 0 refcount condition while holding filesystem locks, and
> then the final truncate deletes the mapping entry which is already at 0.

Okay, that makes sense to me.. but what is "entry need to be
maintained" mean?

> I.e. break layouts waits until _refcount reaches 0, but entry removal
> still needs one more dax_delete_mapping_entry() event to transitition to
> the _refcount == 0 plus no address_space entry condition. Effectively
> simulating _mapcount with address_space tracking until DAX pages can
> become vm_normal_page().

This I don't follow.. Who will do the one more
dax_delete_mapping_entry()?

I'm not sure what it has to do with normal_page?

Jason
