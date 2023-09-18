Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2DE7A4F79
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 18:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjIRQnU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 12:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjIRQm5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:42:57 -0400
Received: from outbound-ip7b.ess.barracuda.com (outbound-ip7b.ess.barracuda.com [209.222.82.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855085BB1
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 09:41:15 -0700 (PDT)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40]) by mx-outbound46-141.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 18 Sep 2023 16:41:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLr40Can983te6KAR1byFpDvIer65vKsh5nvYOVfDqTA3pWPlwbHaI1QdvTSn6vIVhxxlwsdF9BR7Bfg2VPPAfPlTp3GAsniSl2ycgszewqW0WmOflbwiiDUtQuPQkZ7uJ7ZueXrwOiy3Lw6b6eYVE2t11tQmTYUrmF2UBW1ykANWQfgwzQXb8RWkiqaUtv3BOuRny3gGeJ1+GkVjaqaWNM4JOvYA1TXUC4GN41Xvj+3a9RbPaKSIRO6K8C+wl7oY2HPfcaidyIMaL6Rqtm65N4kZLOxoy/+3F7zg7o1FcePo5JCxlBmq2mJMBOSmUkjS8xDTFHDxAA+I+TTb4t19Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wvcr6JAu6wZQWzCOK6TNKaH2lcx0FmUBW4GnWOO9xOs=;
 b=kIowpYCVzzi9mJ7ayf09N2Le0oFh0CffjHI+1cQNCz2HlJ9qflxhET3/m3b5YJF9smFVGUjpQrVh3jvUm1I44pR5k2gTE46z5IlQaJjC1h1nkv9gOlmt8kQkIde6EvEnrtDB9tdBBzdjTQDLxk5JUWVCFlHxz/LxNl5zZq1rKVHop2ZtjICsQIkWtWtwyezsiOjeModO+7EFR1ciRDzLRB2DhQIKYyAIVlLdl8LVpSzTn3GSzmvobuEXZZHnauph7l+NIdJc0dSyrqKajyXfNHSzOB7Ab5b9R/27hpJJHKBoUOfZQUSOhO9cVJ8bbXpbvSkB8Hamnf2ggDF0scmO/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wvcr6JAu6wZQWzCOK6TNKaH2lcx0FmUBW4GnWOO9xOs=;
 b=iqoTqn6hMXwbp2erZHRY+dRk7Xxo0n1niqjc2V2MrMTcSHwVDT5UUqPWxv43t6FYuvLbKZtZiayNUlN7xa+KOYXx80a1AT9Frs4vylZnjELMZY4NXRD6cT5H1KNI81uzEcClBtB4wM6qfSllTdm5/44pRnYAA78H7hyu6TCFEBA=
Received: from BN8PR04CA0052.namprd04.prod.outlook.com (2603:10b6:408:d4::26)
 by DM4PR19MB7263.namprd19.prod.outlook.com (2603:10b6:8:109::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 15:03:18 +0000
Received: from BN8NAM04FT029.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::76) by BN8PR04CA0052.outlook.office365.com
 (2603:10b6:408:d4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Mon, 18 Sep 2023 15:03:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 BN8NAM04FT029.mail.protection.outlook.com (10.13.161.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.16 via Frontend Transport; Mon, 18 Sep 2023 15:03:16 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 7A98020C684B;
        Mon, 18 Sep 2023 09:04:21 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
        Bernd Schubert <bschubert@ddn.com>,
        Hao Xu <howeyxu@tencent.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v4 00/10] fuse direct write consolidation and parallel IO
Date:   Mon, 18 Sep 2023 17:03:03 +0200
Message-Id: <20230918150313.3845114-1-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM04FT029:EE_|DM4PR19MB7263:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 479d76d4-f9e5-42f2-59b1-08dbb8586349
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M2ScKu37VWODDGzNAgq4cVrItI2C7C0A1zaOnqRP4td328GfwVaZqc2CJj1B3eg2P39Io+TVRu62Lm5nN0j5mw2yH5hI1zllTCE5fdxgg7JwRvqC5OUPkPgwNbMYkVpjbcg0bPs5n6VahSAYPq/v3g0q3Nftqu3T7FTp/KKT6UgjuYxJ0vkXgpsoZ6dJGLVq5WptF5dRczQK8oR02FdM25MDqVe/wPHuxXIV9+Hff6S6fxTAsfcnDdFU5vTvFlwrEQGcRm3/y65C5GaoZjXefePbXny56rGvwzLqVOeZbRvM7YePQhY8x/RUEutrheFdyyxFl4u1PWHNZLjqoYx+XX7QDqz1jzf4i4ahKt0oDLrA/TbkKPjDu/6WEZlAVZKh/y9V/nidc6XybFcB3mo+Rl8h4YrA3y24iPipoNKr42Qw0sQuetNxjhv/hDpK6DK8OVuNsyLZ1stSDUf5vQ8hsRFrTqBNjbCRsjsCm2wgGzM+e5k+psagWX9nfSriqp/coC6HpIRam0KKCfxsqPRTt9x50KZBJ9BE7llIg+hM4MVRw6QD7xraTFEb92dzGOnpWsBLZ77RQyhuumwNgZAErR4NorYW1gRmaZ1Xq9/+TZLUR7Y9JBurF1CLd+ZVauvkLs+ulvinOBw1mEPG/ASwYQQdU4jNK8zokn1qQ13v7IvQ1DAfuq2jNuBGBjGwC2PnWRq56rgGlA1iZ43jWtKZpHRQsRhoMnDFWw/oMvuhWGncI0+Ds1vadDaFiiSIBkuw
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39850400004)(396003)(451199024)(82310400011)(186009)(1800799009)(36840700001)(46966006)(40480700001)(5660300002)(86362001)(54906003)(316002)(41300700001)(70586007)(70206006)(6666004)(478600001)(6916009)(8936002)(2616005)(8676002)(356005)(81166007)(26005)(82740400003)(2906002)(36860700001)(6266002)(36756003)(47076005)(336012)(1076003)(4326008)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: V/B2B5yzzgly2W8znrKmy+TVY2Bbn6baJ1c91wz+BnAldUov7Xy+PmxYd2znPWIWvVpVXzvdWs4kGiDFS0Pu9qKZmjyCCKNH08DGFCiK56j8UmjK+kdeexNxMMmzcjqX5lpYj+oG4wpPmtyQDqXqeMEgRiwv0meWBuGGRagYLGLGNajVPzpY4FlNRfiqSALlk9lMafsxm76GtnN6OlZfMbrk5vFTR5sLoTxT965ZVmtxF7nR9NtyWonpqytQRiDK+hN/98TGwYI5etEOCCGHkXEz7Hx4RXe0rLol9X31mX9gQ7WxaCga16IqtBL2Z7YA6EMiosmbMaGqHi4EEK9VYU5Cy77W0LNqWzOZ1jzJuhAI0LFpRGQLE2hsFZBQYsnhQfQRg+xho/YDCXtNkL0BE4iJbZteQRgtmLYs3cdhaO3d6Hbi8Ki28pTeo3Tnlo3egnylKAwF0NqC0UCPfAV7NRTJGGArFYuamJygvBv5ehteres1p2DSYxVtHNUQ7h0tImJLHkLN8zAZQPb3UzLIQ8FbynpC2Ei5qOykQb1c+FinMbg7uvw+6cKIzwr5Hr75vBgQrP/NQ/+qsGLNa8+jgWlZ5qSE0uVSB/Mz/4HeDzVxdShnz3fzTA1/HIpJc0L4GygtI/KcHOzzVUOUpgb+Jd81Wv3LItN3ibyj3bCLIfqE9mo1dhclQq+U6Kj1WWOaOrxkf73EUPNymveLWgDUlhnqwNpeBOM8IBToUfExikOk8ut6q4TnVmyN3GFtnQ/z0h3mqNMzhNhxzGlR1qB51yjOPh6SXcEkXAyzO6CoBmzpI8FrHHUVxPyE0v/fUOc8te8dvLmh7O75ZFOHUCtl2PxwczWlAJKQw3+uE0gxgYOEGAXr2+PNrCVK/MctecxnVW3jUFOfnYtfHnnKwa5B9mZ6fs66Wwg9wDqe9un5KFU=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 15:03:16.4035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 479d76d4-f9e5-42f2-59b1-08dbb8586349
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM04FT029.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB7263
X-OriginatorOrg: ddn.com
X-BESS-ID: 1695055274-111917-12363-4259-1
X-BESS-VER: 2019.1_20230913.1749
X-BESS-Apparent-Source-IP: 104.47.51.40
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsZGpsZAVgZQ0NzQzNzYONHI0C
        zR0CAxMdEkNTXJ2NLU3MQgJTkxyShRqTYWAEl7UpxBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250915 [from 
        cloudscan22-167.us-east-2b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series consolidates DIO writes into a single code path via
fuse_cache_write_iter/generic_file_direct_write. Before
it was only used for O_DIRECT and when writeback cache was not enabled.
For server/daemon dio enforcement (FOPEN_DIRECT_IO) another code
path was used before, but I _think_ that is not needed and
just IOCB_DIRECT needs to be set/enforced.
When writeback-cache was enabled another code path was used, with
a fallback to write-through - for direct IO that should not be
needed either.

So far O_DIRECT through fuse_cache_write_iter also took an exclusive
lock, this should not be needed either, at least when server side
sets FOPEN_PARALLEL_DIRECT_WRITES.

Regarding xfstests, without FOPEN_DIRECT_IO there are no differences
between patched and unpatched. With FOPEN_DIRECT_IO the series
fixes generic/647, which was failing unpatched ("pwrite is broken").

v4:
checkpatch cleanup

Addresses review comments
  - Fix shared lock in fuse_cache_write_iter, file_remove_privs()
    needs the exclusive lock.  In order to know if the exclusive
    lock is needed the new exported vfs function file_remove_privs()
    is introduced.
  - Also fixed for the shared lock is the fallback to buffered writes,
    which also needs the exclusive lock.
  - Fixed is the accidental turn around of false/true in
    fuse_dio_wr_exclusive_lock().
  - Added documentation in fuse_write_flags() that the IOCB_DIRECT flag
    cannot be trusted.

New optional patches
- "fuse: Use the existing inode fuse_cache_write_iter"
- "[RFC] fuse: No privilege removal when FOPEN_DIRECT_IO is set"

v3:
Addresses review comments
  - Rename fuse_direct_write_extending_i_size to io_past_eof
  - Change to single line conditions in fuse_dio_wr_exclusive_lock
    (also fixes accidental parenthesis).
  - Add another patch to rename fuse_direct_io to fuse_send_dio
  - Add detailed information into the commit message of the patch
    that consolidates IO paths (5/6, previously 4/5) and also
    update the subject.

v2:
The entire v1 approach to route DIO writes through fuse_direct_write_iter
was turned around and fuse_direct_write_iter is removed instead and all
DIO writes are now routed through fuse_cache_write_iter

Cc: Hao Xu <howeyxu@tencent.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: linux-fsdevel@vger.kernel.org

Bernd Schubert (10):
  fuse: direct IO can use the write-through code path
  fuse: Create helper function if DIO write needs exclusive lock
  fuse: prepare support for shared lock for DIO writes
  fs: Add and export file_needs_remove_privs
  fuse: enable shared lock for O_DIRECT / handle privilege drop
  fuse: Rename fuse_direct_io
  fuse: Remove fuse_direct_write_iter code path / use IOCB_DIRECT
  fuse: Remove page flush/invaliation in fuse_direct_io
  fuse: Use the existing inode fuse_cache_write_iter
  [RFC] fuse: No privilege removal when FOPEN_DIRECT_IO is set

 fs/fuse/cuse.c     |   5 +-
 fs/fuse/dax.c      |   2 +-
 fs/fuse/file.c     | 189 +++++++++++++++++++++++----------------------
 fs/fuse/fuse_i.h   |   8 +-
 fs/inode.c         |   8 ++
 include/linux/fs.h |   1 +
 6 files changed, 113 insertions(+), 100 deletions(-)

-- 
2.39.2

