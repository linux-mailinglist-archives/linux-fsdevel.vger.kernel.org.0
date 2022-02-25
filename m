Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981054C4082
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 09:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238643AbiBYIvN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 03:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234783AbiBYIvI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 03:51:08 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2075.outbound.protection.outlook.com [40.107.212.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169841768E9;
        Fri, 25 Feb 2022 00:50:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWXkZJwh344h+L+QMjEEulCM/4Rcvk8D4l9fdaOSDeEr67XzEFUIvrF80aHUDCwK94ENtH1Ke5Y+VskpmVvlP7nA6KfUajS/0FyxSf8wj6tGab2DW+hFc2SiIjn66s8qnpfuS73Wgy1arfMIzL7gwUROUP+Ht933K49mHAXJrizxhVsJuLw76V3TQzMHvPg6Lape5g6qTawSqbhAbOxY7t+Ga40/yiY0eyjKzpCnn5Im3xGilUHilLy59QIy391xTxVhFQ8AYDo2B3C6dV2N9TX+5eYv8oIjbdQqiGMyp5zk4MU1ScHHJCaZv/c0CJTgBLsGT2e46YsvTxI7T1bGCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0n8ev9AMBSMqlnN0/cyDpI/UWtzeuKRnrgYyjeviz0Q=;
 b=XyOjLNLCxk9cXKhcR6jnfSy7okG8M8DXfU9QqM+XFwZxDeRGSyTNnGn91loW7sLTqdeNWP/LjqtC0OHuP6zOexratnJSn9zBEgJs43hsXMdQtWfhawMyK4tORZuISj8AJsukzQUQ6Ej/VimVrVmyoibdwDhJvRYuPaVHeHqh1DcRKUF1ueDH7kCvcNBfItaf0tEN7AqEfzwvS77cdqM0Dr3hUfw6HS2IoXGxlkj5YSPHPAG20KzaBn1Rdiv0eHo54517OFRV12meu+vTfkNaB25lytoTBArmoE7UHNMAJqu2K0rMwSgiHrk3W/0uHNBNz+UKKVX79DeoJTXa8UoUfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0n8ev9AMBSMqlnN0/cyDpI/UWtzeuKRnrgYyjeviz0Q=;
 b=Yvf6TTYTE7WYcsXIsWujaSzn7HClNkLQlzCKsq61jOPdn8ViHpZAqBdSzck0HSMPOPZn+GUhsgwW9uD1gI3U9dxgh3bv5AtNQZAPRH2Zk0bt8HVc0mElL2FYQ5akia/CUiQiks3SkUQJPTHGc/cA2qc8xNFTUGyJDcrDLGyATDw6vWC3026hqnd/qg1mY626EA+wRUKyohNbLKahl6icP6DqZQ4jF9vTiFlaFpzWf53U79zr0/gFNcbXpKGTqTrysVJFVmz7FHg8KcQwpVKNHYgJ3IgWJWfSIpKzXy7wpw0LdUgxDaiFAjqiJ0CYltod5QeLoPCBQ/8St+hu1DGoXg==
Received: from DS7PR03CA0189.namprd03.prod.outlook.com (2603:10b6:5:3b6::14)
 by CH2PR12MB4857.namprd12.prod.outlook.com (2603:10b6:610:64::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Fri, 25 Feb
 2022 08:50:35 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::11) by DS7PR03CA0189.outlook.office365.com
 (2603:10b6:5:3b6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22 via Frontend
 Transport; Fri, 25 Feb 2022 08:50:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5017.22 via Frontend Transport; Fri, 25 Feb 2022 08:50:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 25 Feb
 2022 08:50:32 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Fri, 25 Feb 2022
 00:50:31 -0800
Received: from sandstorm.attlocal.net (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Fri, 25 Feb 2022 00:50:29 -0800
From:   John Hubbard <jhubbard@nvidia.com>
To:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chaitanya Kulkarni <kch@nvidia.com>
CC:     <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [RFC PATCH 0/7] block, fs: convert Direct IO to FOLL_PIN
Date:   Fri, 25 Feb 2022 00:50:18 -0800
Message-ID: <20220225085025.3052894-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 312e37c6-a7f9-4410-a35c-08d9f83be323
X-MS-TrafficTypeDiagnostic: CH2PR12MB4857:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB48573B2324DD67F876897E1BA83E9@CH2PR12MB4857.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1QkznSnsozaEtR/jvOsIISDz9XwDxaG5Qrz7zuOM5AdixnoO+t9kONDWj0e9fvUm6Q38nb0DxGFoEOBYmQyGXwNBtKrq3Onp8ZBEv2wgy44RIxchngwU/0e4gQLPPCQFb2eYhVVZ68czHfkQeDwioTk68Yl3MfH1O2zuuROI1xzaHeolHcc/0bPDyrIJVqiSHhjglnrDW+Xtd28oj//n6MWb6pjDek8OT3b0l1cs28TCY0qlTo1KDm8xFCu/8mVVmpt+FXb3s44WK44QRHl0hxk8KPAnLXZ7o7svcX4eCdqbWFfuc/2nLKNwUsyCgCnygLAvGTUO5JKBgzGi2X8yFQR4pvKUOptigoKrpASsMwNml40HG+SuYs6JqplcHDUSpSNrPE+n6JIkYWtyycv39vVkAjOkMa25OblBcD3oGZyhOJmCLwLxuIPT9Dcv+bG4jqNejTjICbYIMcT8rgiewoMHI7FrtuTzid+d0bTvBPQ7+wYRX7YLb7JvQauvpcdsAtmlO8jBIc+KINwLrY72ZBV12oIycEyUWSwHTlxgJGfQZ5vrbDRUoxAA5gCxaXgH7VOOgTZB67iMfzFECTp24664UIDrqp/2c2bPtUXG7ABhPIC7tZDoI7uZP15Ml1LZAV4Z7CPlZw7j5KQO4GbUT0leOfV8XJDUwjib8s4285t/fKNWNHevp74YZN30zjsoWrzDAo/5kJVyw/r5MEM/WKvjPWTctzjs4w0CqqXQMc5tTop0y1vTJpo5mExYplWa2/RVYJ18FWe5ZsD0mJn5mYz/aVvjXKfETNI5zae9/cwVtBwK86r/N5AGjttHs1stDsB/OUBoAsayJ+79UdTW9+/6g10iIVPTSKMBbEA94NI=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(110136005)(54906003)(8936002)(6636002)(1076003)(82310400004)(966005)(86362001)(107886003)(508600001)(36860700001)(40460700003)(2616005)(6666004)(356005)(186003)(4326008)(8676002)(83380400001)(26005)(81166007)(921005)(70586007)(316002)(7416002)(426003)(70206006)(2906002)(336012)(5660300002)(47076005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 08:50:34.6064
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 312e37c6-a7f9-4410-a35c-08d9f83be323
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4857
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Summary:

This puts some prerequisites in place, including a CONFIG parameter,
making it possible to start converting and testing the Direct IO part of
each filesystem, from get_user_pages_fast(), to pin_user_pages_fast().

It will take "a few" kernel releases to get the whole thing done.

Details:

As part of fixing the "get_user_pages() + file-backed memory" problem
[1], and to support various COW-related fixes as well [2], we need to
convert the Direct IO code from get_user_pages_fast(), to
pin_user_pages_fast(). Because pin_user_pages*() calls require a
corresponding call to unpin_user_page(), the conversion is more
elaborate than just substitution.

Further complicating the conversion, the block/bio layers get their
Direct IO pages via iov_iter_get_pages() and iov_iter_get_pages_alloc(),
each of which has a large number of callers. All of those callers need
to be audited and changed so that they call unpin_user_page(), rather
than put_page().

After quite some time exploring and consulting with people as well, it
is clear that this cannot be done in just one patchset. That's because,
not only is this large and time-consuming (for example, Chaitanya
Kulkarni's first reaction, after looking into the details, was, "convert
the remaining filesystems to use iomap, *then* convert to FOLL_PIN..."),
but it is also spread across many filesystems.

With that in mind, let's apply most of this patchset soon-ish, and then
work on the filesystem conversions, likely over the course of a few
kernel releases. Once complete, then apply the last patch, and then one
final name change to remove the dio_w_ prefixes, and get us back to the
original names.

In this patchset:

Patches 1, 2, 3: provide the prerequisites to start converting call
sites to call the new dio_w_*() wrapper functions.

Patch 4: convert the core allocation routines to
dio_w_pin_user_pages_fast().

Patches 5, 6: convert a couple of callers (NFS, fuse) to use FOLL_PIN.
This also is a placeholder to show that "filesystems need to be
converted at this point".

At this point, Ubuntu 20.04 boots up and is able to support running some
fio direct IO tests, while keeping the foll pin counts in /proc/vmstat
balanced. (Ubuntu uses fuse during startup, interestingly enough.)

Patch 7: Get rid of the CONFIG parameter, thus effectively switching the
default Direct IO mechanism over to pin_user_pages_fast().

(Not shown): Patch 8: trivial but large: rename everything to get rid of
the dio_w_ prefix, and delete the wrappers.

This is based on mmotm as of about an hour ago. I've also stashed it
here:

    https://github.com/johnhubbard/linux bio_pup_mmotm_20220224

[1] https://lwn.net/Articles/753027/ "The trouble with get_user_pages()"

[2] https://lore.kernel.org/all/20211217113049.23850-1-david@redhat.com/T/#u
    (David Hildenbrand's mm/COW fixes)

John Hubbard (7):
  mm/gup: introduce pin_user_page()
  block: add dio_w_*() wrappers for pin, unpin user pages
  block, fs: assert that key paths use iovecs, and nothing else
  block, bio, fs: initial pin_user_pages_fast() changes
  NFS: direct-io: convert to FOLL_PIN pages
  fuse: convert direct IO paths to use FOLL_PIN
  block, direct-io: flip the switch: use pin_user_pages_fast()

 block/bio.c          | 22 +++++++++++++---------
 block/blk-map.c      |  4 ++--
 fs/direct-io.c       | 26 ++++++++++++++------------
 fs/fuse/dev.c        |  5 ++++-
 fs/fuse/file.c       | 23 ++++++++---------------
 fs/iomap/direct-io.c |  2 +-
 fs/nfs/direct.c      |  2 +-
 include/linux/bvec.h |  4 ++++
 include/linux/mm.h   |  1 +
 lib/iov_iter.c       |  4 ++--
 mm/gup.c             | 34 ++++++++++++++++++++++++++++++++++
 11 files changed, 84 insertions(+), 43 deletions(-)


base-commit: 218d3ca9c0ea1c35f1bc5099325b7df54b52bbdd
prerequisite-patch-id: 7d5a742e37171a15d83a9b3ac9ba0951b573eed8
--
2.35.1

