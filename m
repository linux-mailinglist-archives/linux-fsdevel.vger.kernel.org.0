Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFC55A74BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 06:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbiHaESw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 00:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiHaESu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 00:18:50 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698BDA8CFC;
        Tue, 30 Aug 2022 21:18:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cu4ZibaOSmtLUBAEXFuUzdscT9vjLl8i1cnBwgQcA02fM4AklZxiuZDfnpSAjIQ9QkGyaiv94jzfhs5z5P/t2CMMwJeVHDqN5D0DGHo/AlJ48dKiNZRu2bflFz5Z0hteDG1Lurna2akQT5Og4/86sViQ/iXv89dmM2Pq/7LDbUPebzayPkxVlpjyBr8pkbVOEsJn55Xx1AJGnH2Rs3EwFph7CI/8aEJRZ3lWKOy0eyRpLXQT0n7fGqWXYzydCIKSP6qpx8S6ViNXgU1jJu8yD4ggdV80Qmr9742qk8pahki8dhFR9nB9wMazqMwUVtUbZMHRi5VusGjJbJOihoxRDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94/SjAzGDj+eOXNQNiPy1hVg5d7HWR7l+Zp5Z4OYIJM=;
 b=es/6l8kePsJChVH7pl6wlSq5JSnWb8GGFC/qafNMmkZQF9K5V1H2irw3+jIiWaQYY1tFMNnql8sxbvtEMg1nNfzlRK/DBzpFd8OOYAPpyO+jaBO9SofCcrP7L+S2VeYFFvsy+lwmqqi5J3nR9PBUwzb2UN1WHdSLTzK1KSCEjO3aaMVy0xplxNgILAsQLsdDyroG8ccL71bAI6E/LbwO4hwZtgTH/VEPNClhjKTp3ThNaZfpAW+JPkE3qW2GQ7UDJL7KOXuGgl4MBtHT/opGhmH5T2RcrKuhMGdWjE6GpAnDx4TP1f3rPY0oTEyQ7Kzs8CcUa5DsXUbJPjGrpzdayg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94/SjAzGDj+eOXNQNiPy1hVg5d7HWR7l+Zp5Z4OYIJM=;
 b=MTWVtcTbDvc1NxucllPyJ26GWFV5cRBBEPhK+nurvZ8vds3qwl6mr+0ucspDzT0tawPCMKU+nREa9EYbDblDePQhBOp8xLoS8/aeisdAoWV9Xh6q73QtDcUseL5QZUyp4k4FmNxU5tLYZjgzLj6omoWCj76DxSP7avrbCYQWezGNUR7L4LDVwbI7vGkt/oBl/iH7O3Hi++VseCXURCZ1wNFt2ybWYkPkzWXOXsiz3x2vj9WtBf8aBp6H3rZ8EYNrzsB9uxl4HjFUYAKl6aFfqJWPbtOqBX+z9mEmRWZoSUOV1oWgf4eLI2etvbmz8/ogmZhCaFdu7F7M/7pcTI1l2A==
Received: from MW4PR03CA0312.namprd03.prod.outlook.com (2603:10b6:303:dd::17)
 by BL1PR12MB5142.namprd12.prod.outlook.com (2603:10b6:208:312::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 31 Aug
 2022 04:18:47 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::26) by MW4PR03CA0312.outlook.office365.com
 (2603:10b6:303:dd::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Wed, 31 Aug 2022 04:18:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5588.10 via Frontend Transport; Wed, 31 Aug 2022 04:18:47 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Wed, 31 Aug
 2022 04:18:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 30 Aug
 2022 21:18:45 -0700
Received: from sandstorm.attlocal.net (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 30 Aug 2022 21:18:44 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 0/7] convert most filesystems to pin_user_pages_fast()
Date:   Tue, 30 Aug 2022 21:18:36 -0700
Message-ID: <20220831041843.973026-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1211213-ea3d-4f34-5151-08da8b07e68e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5142:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gx0BqzKA7TWn0aa5fWJsqxaLt3EJrFWbVScQUrdyWjRkR4XExbYRBvZ7tCA6MXlWT/oM4VVtnHkSlF4MTSMdBwnpyIt638URodasd3/P78RPpR4pwI/WGAeA7f/e2C1GVmozciTBGB1mTyWusfnJitIBSS4TK68Cnqft2gxf6sM2HQvu+RZZQvg7lTY8OpOSb+buG7c46pTddOZt9eclcUM6luWid4jI8PIPPM2h1i4c+7xiUoZRhILMgW9a78UFI1fS/MFLGLCSjaszL4mAApkhDEKX08g3gDut4OTrrhBvN2uAb8r12Z2rBWOH3Gx4RyIXbKU0Lj3KDJySSAcBv0qxLQ6/+Zp9kXjyAbazFdALR+UOJBdOUv5FlGtMi7CgAoLhfzmi45f1pov7ZWZCwIj4+K91foyF2GofMp9E/WKkVhsHTgXDyesQsrKO91jYAWSuV4jOJnaRQ+s0eornTiyjSA846xHpTUloUwPhqak4o93bj4E2qpvLMaUVSNFvRlTKA+GhKoQOKA4QDNsuivY3JVknP3a9BqG3SOW5LFUOw6eDZK8Poyh8qGtIkMqqv5klZdtduy0CFVBB74UEaM9MZF4o+Aw5iPQvmqK7py+r8kehftAqUsad3SoJIhPPyeqr1Yrs9ao9ntAGuBstghjhVR87Mryd87DjHJW0sJkOg/BtAT63W2K9BEOCPV7R5hf16DM0THeuKhCY2Q8th9A/bzmSehfUD7uYuks2NcwLVtrDjyAHuKDP2ev+rkAo9Rx2zHF2SdtFkwzcuBula3Q150zLR3YRKBC/dhPkGn8GMtLP6S2Q9JHi4HHb54Y/2WTGS1BJlF81d04O/5CEt5snQPBZ3RjLZXjkXew40xI/n2jiiNTWwSsd6gW/jfYx
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(136003)(39860400002)(346002)(46966006)(36840700001)(40470700004)(36860700001)(86362001)(81166007)(40460700003)(356005)(316002)(82740400003)(54906003)(6916009)(83380400001)(7416002)(70586007)(4326008)(5660300002)(8676002)(82310400005)(8936002)(2616005)(70206006)(1076003)(186003)(478600001)(41300700001)(40480700001)(966005)(26005)(47076005)(2906002)(426003)(336012)(6666004)(36756003)(107886003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 04:18:47.4215
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1211213-ea3d-4f34-5151-08da8b07e68e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5142
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is v2. Changes since v1 are:

* Incorporated feedback from Al Viro and Jan Kara: this approach now
pins both bvecs (ITER_BVEC) and user pages (user_backed_iter()) with
FOLL_PIN.

* Incorporated David Hildenbrand's feedback: Rewrote pin_user_pages()
documentation and added a WARN_ON_ONCE() to somewhat enforce the rule
that this new function is only intended for use on file-backed pages.

* Added a tiny new patch to fix up the release_pages() number of pages
argument, so as to avoid a lot of impedance-matching checks in
subsequent patches.

v1 is here:

https://lore.kernel.org/all/20220827083607.2345453-1-jhubbard@nvidia.com/

Original cover letter still applies, here it is for convenience:

This converts the iomap core and bio_release_pages() to
pin_user_pages_fast(), also referred to as FOLL_PIN here.

The conversion is temporarily guarded by
CONFIG_BLK_USE_PIN_USER_PAGES_FOR_DIO. In the future (not part of this
series), when we are certain that all filesystems have converted their
Direct IO paths to FOLL_PIN, then we can do the final step, which is to
get rid of CONFIG_BLK_USE_PIN_USER_PAGES_FOR_DIO and search-and-replace
the dio_w_*() functions with their final names (see bvec.h changes).

I'd like to get this part committed at some point, because it seems to
work well already. And this will help get the remaining items, below,
converted.

Status: although many filesystems have been converted, some remain to be
investigated. These include (you can recreate this list by grepping for
iov_iter_get_pages):

	cephfs
	cifs
	9P
	RDS
	net/core: datagram.c, skmsg.c
	net/tls
	fs/splice.c

Testing: this passes some light LTP and xfstest runs and fio and a few
other things like that, on my local x86_64 test machine, both with and
without CONFIG_BLK_USE_PIN_USER_PAGES_FOR_DIO being set.

Conflicts: Logan, the iov_iter parts of this will conflict with your
[PATCH v9 2/8] iov_iter: introduce iov_iter_get_pages_[alloc_]flags(),
but I think it's easy to resolve.


John Hubbard (7):
  mm: change release_pages() to use unsigned long for npages
  mm/gup: introduce pin_user_page()
  block: add dio_w_*() wrappers for pin, unpin user pages
  iov_iter: new iov_iter_pin_pages*() routines
  block, bio, fs: convert most filesystems to pin_user_pages_fast()
  NFS: direct-io: convert to FOLL_PIN pages
  fuse: convert direct IO paths to use FOLL_PIN

 block/Kconfig        | 24 +++++++++++++
 block/bio.c          | 27 +++++++-------
 block/blk-map.c      |  7 ++--
 fs/direct-io.c       | 40 ++++++++++-----------
 fs/fuse/dev.c        | 11 ++++--
 fs/fuse/file.c       | 32 +++++++++++------
 fs/fuse/fuse_i.h     |  1 +
 fs/iomap/direct-io.c |  2 +-
 fs/nfs/direct.c      | 22 ++++++------
 include/linux/bvec.h | 37 +++++++++++++++++++
 include/linux/mm.h   |  3 +-
 include/linux/uio.h  |  4 +++
 lib/iov_iter.c       | 86 ++++++++++++++++++++++++++++++++++++++++----
 mm/gup.c             | 50 ++++++++++++++++++++++++++
 mm/swap.c            |  6 ++--
 15 files changed, 282 insertions(+), 70 deletions(-)


base-commit: dcf8e5633e2e69ad60b730ab5905608b756a032f
-- 
2.37.2

