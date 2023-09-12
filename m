Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DD479D359
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 16:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbjILONj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 10:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjILONi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:13:38 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2091.outbound.protection.outlook.com [40.107.215.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFF6CF;
        Tue, 12 Sep 2023 07:13:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTevNafkAoHQSc9cnxt9Od69WIGxt5+nqsA9RfCGe49L8UvkWJsSixx+8VlnojKe4xtk+oCi6wUyZx6gC3UAd8gJVdZhwVR5DFLTZ1i7TTsay5cwZwLL6xBWoRLr3bHXgafENrbkx02ttWWoYF/xBad+9BYtFb9ePfMXNnqyJAuSa/5yI92Tg52RmHowX3ay2jagd3pXop83g72tGvdzo5gNCDFi/J2CGMKcdCS4m+voINbaB/2iOw1qt/kBkvJhFElS64s+PgqGwerpDIcRcf7Wfbiv1RxLFiBO9nUbC/nq5Ha5yqRky6MGQj7YG/b87bOrQzAB3csThk6OeakQww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=leHni/rV083nmaV95ijUmrfz99VzOQVFds0i7ZePYm0=;
 b=kp+Exg6MUMW+rQ5n2vaxwO6T4ZgToxzrnufKTJZEBMjSCHncg2TUZNuiYNrP1/DqzDGY3K+4fGXzPA/UOzYllXY1pkXXW84kd+Jif2BQvJg+JlbOFz5JTagnTepIFVWPYRk1+v8Rr0YMUD693I1xIlQ52gPTV87d48CCiFtXiDUk8nn+zaZsaH+5zZd5TG04B77gwR7dFtJJa0mEEmTGQUApcrIhPyvCDRpw6GDBOcVpazhiA3+V6M1OXvk4DDLlanquGS3R/u+dBhR6BTFDXDmyRkaa5Ab4eU9SM/lAYDZt7uCy3QVbLgqTKhpIru5kzgNIp4ewrcKcfMqX2zWydw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=leHni/rV083nmaV95ijUmrfz99VzOQVFds0i7ZePYm0=;
 b=ocEFRGtguinMhlDStF+Ppiyzb/RXey1PYperpn0XGBwe7fCeW6pnL8gZK+peY6zbtODqQZ8FFBvv0fj2e5JHPg6UTM7qmEPWm+OhUC1bht3GKUX1U4L06EGxsUy523IXY/j61sqF5rMHg4tCTokvQBMwtxvuWVG3xCJQinUdm7r8wmgse6lEOyfFTBBU1Cpv7NEiyJl0jM/mA498qA1KebOAo6G0yok1Mkt8rGekzi1Z0wGlYuf6cd4VcULdoYqB/WmX6BfglJmI/+fU6RF15fjxW4ezJSIXEmDJY5Jzdio0YvLOMTJK3EpXCr2KkNV3bc+fAifBUIsu5NSsd6cUig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3338.apcprd06.prod.outlook.com (2603:1096:4:97::23) by
 SEYPR06MB6108.apcprd06.prod.outlook.com (2603:1096:101:c5::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.30; Tue, 12 Sep 2023 14:13:27 +0000
Received: from SG2PR06MB3338.apcprd06.prod.outlook.com
 ([fe80::1c:4eaa:202a:5485]) by SG2PR06MB3338.apcprd06.prod.outlook.com
 ([fe80::1c:4eaa:202a:5485%4]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 14:13:27 +0000
From:   Chunhai Guo <guochunhai@vivo.com>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org
Cc:     chao@kernel.org, jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chunhai Guo <guochunhai@vivo.com>
Subject: [PATCH] fs-writeback: writeback_sb_inodes: Do not increase 'total_wrote' when nothing is written
Date:   Tue, 12 Sep 2023 08:20:43 -0600
Message-Id: <20230912142043.283495-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0023.jpnprd01.prod.outlook.com (2603:1096:405::35)
 To SG2PR06MB3338.apcprd06.prod.outlook.com (2603:1096:4:97::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3338:EE_|SEYPR06MB6108:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ae9490e-d969-4148-2201-08dbb39a6e78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R91rs0aEI5Pi6wpsz4/uafXsCg2R/EFhZHrxe3/q4Afqjo1iuC7lvPQHCGJpMXLkZhS6wp4KVog4lham3aa5K0o+avi2IOg5TPBIS37pmeMdV/JRI7qc4iMptP0vXC4oZrv3n0uuKoOEgOrdu8f3oMSrJ6cZfdU+OmgUo4XBvrTzNTZ1SF8EVpZxIBO5v0lLp0ylIt8g/Wl/muKPV+R3BodhDGj2OvXts5FqAX2i90or6nCAwJhPZuNRtLdtmVCyzwSs38BrVwEXuReU2yG9Ogpg2YbsEIvq5rL/Iw7kfQ8/EVQKu4yCnWAN5X17K3eejBYXq1MTb2KTSADU52M5GuqmzXFLfxouLHj/FVbLe45EFuISQGHKkshAldWXS1OMBW3iVHU+GgO3BnBPStBnCDMg0+DjI2Hy0lTvMBSL5uWIhpK0je3EHFQVHfnM8rXfaIj3xidkrk5ourAKbwcjgCXplAj0C6M9oJE0FTOM6HKAPa9TU8hH/bzCNj3RHcfAk74Z3ydiGUbKuLOYBto37Gf9JnIvHz+W6OQQCHMBnC14j4klPfOhwzNQUKln6SVVJYW0Wu+pAPpfEaN4itfs5s69Pi9v9+7TCrIKtpLbU6EFXFm3HWzsDB2AXFE5WMwG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3338.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(376002)(366004)(346002)(1800799009)(186009)(451199024)(41300700001)(6486002)(6666004)(52116002)(6506007)(478600001)(6512007)(83380400001)(66476007)(107886003)(1076003)(26005)(316002)(4326008)(66946007)(66556008)(2616005)(8676002)(2906002)(5660300002)(8936002)(36756003)(38100700002)(38350700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GMnLJqIRqiJm0/bvZkhWH4qoy6bSfrbNcNzhrUna67qTKXbhH+NvGuXukDl9?=
 =?us-ascii?Q?gRlcH5glOey/OYOUKzmFAkpWtApTEk3WroE4AvyIam0/O61OF1SyrGFq8XwU?=
 =?us-ascii?Q?Fvnu+2Fd2iJJwmnuCZZfLKaaj1o6w0M/Vop/vutVVtiDVQE4PgO3gqwWAYWq?=
 =?us-ascii?Q?mvg2Z9hHuf1T5yPjvcpgfqjaJaYXzOGmHF0B1gCIO+UphM5z792AcHWVB5qj?=
 =?us-ascii?Q?qA17yOa/vr1+OzHlRR8LMLo+Pl2NQg4BfG+sryAMW6aIbY8ezLSmghTuDvyr?=
 =?us-ascii?Q?vPfUqWvoyFe8yRnBtY0OQVw5yN/goxnz8mMtfiUyZ0SVZeJJ3DS8/djIM1sq?=
 =?us-ascii?Q?RrwEUb/4MFjPZ/5NFTT1apU8dzAXCzKNc3ukeHtfmnrSWhGb2u7Z/cGFwkWq?=
 =?us-ascii?Q?W9BeHXnVfpL0lpMwkBGHv6og250INGKjcs6oQjSe3l5N8qja0bB0hDzFeikF?=
 =?us-ascii?Q?yB9+EFtcp31ywJfMxkWqiiQLKb+EvNzwlvVbiJqMrAFmcmx7YHpxhYMWy7qv?=
 =?us-ascii?Q?y9MBgtCq3jfUZSGCyGJsrfuJIvJpmpJmU0d0ZiEtFjROjToqYAlLmF/RfLkG?=
 =?us-ascii?Q?Y6auLCkuOIUIx7f8T+BYuBKv4Wd/WhaJQjEwaBtf1mDHyA5s9QMudz7IX/yG?=
 =?us-ascii?Q?X1A9+7s9CXB+kxb4jJk6/OHkWIi8/rg0O6NCRlvAWLUi5IZxYqL7xf7RpdYu?=
 =?us-ascii?Q?Amy/A2tpq/q7E7c7mqF/8C4ShwSlvwQrDUCVdum/ALUFIj5/nfrcU42umQM/?=
 =?us-ascii?Q?tj5rgfau81y0PJoeepyFbeZLb5pnmtqmmYI8Ksgsdi1XfpyT1/sFot4KikTp?=
 =?us-ascii?Q?I9mWLNlbDiWZ/DGfaEPLXKz/gzjfgGz7eT0DVVMAEjMBJEQFLv4BHx3dN62/?=
 =?us-ascii?Q?oHlvKnWUkJOp0hHKtM8oOL2YQmpjnW6i0bbM8OX2hP0QP4C7Sj703RRfw4Be?=
 =?us-ascii?Q?QEGi00n2FL+ltyXAy7ezqOsQ2hhgYnOHIsRKNTy8MbnXYTW7jVc761cCF+Ya?=
 =?us-ascii?Q?igY/mv3BJEsvjB/bFX9o+0GGeCpXX1lsE3sRsp/2a7DBuit3x9SpOnQ3B7Nt?=
 =?us-ascii?Q?dTReE/s5+c4Fg0JeVK1S0e4cGPC79zo2xqvFbaJGt1lVJopGWQLXb//jzGMX?=
 =?us-ascii?Q?XluY+kxk1VN9txHw3fev19g5jV/OqKVeY25gMpt9eauPa51T1w3GTeCzRD1H?=
 =?us-ascii?Q?nLBGrotG3bNaTBEr1KLRFvuuHPuyZwAHplIjd3w8MnyXOIr5N2TAKJYGWfWl?=
 =?us-ascii?Q?KEZx+OkFXTOETD+d24QdUAinkjXaFcqysnGAemywM5n/DgHejSNUEQCWezwy?=
 =?us-ascii?Q?pJJi4+nLvnz48c0mMr4W5hcN16TmfAB5nbN8LW0AVuAqqx7OOZ2a9jSgLlHF?=
 =?us-ascii?Q?fWiYIIBvrZ5uMuOwV9+pfiJCZld6eoy6Gpb+pRZ6MaxRzmd3otQXMP8hAutU?=
 =?us-ascii?Q?Qd1MyxERBSsiiMd2IOPWJohMWabPgz0XORHcfXPFo9dQ1J5bYtnB1QXsnidx?=
 =?us-ascii?Q?blZtyVFbezbgzRroao5z8MMGeVgFjwhmJI5nioCS5TN9yokzS8yxh5ADTz4N?=
 =?us-ascii?Q?O4bRmOY1xOmVNhSW4cK3jGMTKmmYXzEu7n9rkDyj?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae9490e-d969-4148-2201-08dbb39a6e78
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3338.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 14:13:26.7325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kpNJa8+EaNrHuxaHKBEkN4Fr5PcHIasQYfkrh1BonpjOqMB/J+Cty7iwT6Bl5Cro4GfP6ZL7rMjK9H3yiCyiqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6108
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I am encountering a deadlock issue as shown below. There is a commit
344150999b7f ("f2fs: fix to avoid potential deadlock") can fix this issue.
However, from log analysis, it appears that this is more likely a fake
progress issue similar to commit 68f4c6eba70d ("fs-writeback:
writeback_sb_inodes: Recalculate 'wrote' according skipped pages"). In each
writeback iteration, nothing is written, while writeback_sb_inodes()
increases 'total_wrote' each time, causing an infinite loop. This patch
fixes this issue by not increasing 'total_wrote' when nothing is written.

    wb_writeback        fsync (inode-Y)
blk_start_plug(&plug)
for (;;) {
  iter i-1: some reqs with page-X added into plug->mq_list // f2fs node page-X with PG_writeback
                        filemap_fdatawrite
                          __filemap_fdatawrite_range // write inode-Y with sync_mode WB_SYNC_ALL
                           do_writepages
                            f2fs_write_data_pages
                             __f2fs_write_data_pages // wb_sync_req[DATA]++ for WB_SYNC_ALL
                              f2fs_write_cache_pages
                               f2fs_write_single_data_page
                                f2fs_do_write_data_page
                                 f2fs_outplace_write_data
                                  f2fs_update_data_blkaddr
                                   f2fs_wait_on_page_writeback
                                     wait_on_page_writeback // wait for f2fs node page-X
  iter i:
    progress = __writeback_inodes_wb(wb, work)
    . writeback_sb_inodes
    .   __writeback_single_inode // write inode-Y with sync_mode WB_SYNC_NONE
    .   . do_writepages
    .   .   f2fs_write_data_pages
    .   .   .  __f2fs_write_data_pages // skip writepages due to (wb_sync_req[DATA]>0)
    .   .   .   wbc->pages_skipped += get_dirty_pages(inode) // wbc->pages_skipped = 1
    .   if (!(inode->i_state & I_DIRTY_ALL)) // i_state = I_SYNC | I_SYNC_QUEUED
    .    total_wrote++;  // total_wrote = 1
    .   requeue_inode // requeue inode-Y to wb->b_dirty queue due to non-zero pages_skipped
    if (progress) // progress = 1
      continue;
  iter i+1:
      queue_io
      // similar process with iter i, infinite for-loop !
}
blk_finish_plug(&plug)   // flush plug won't be called

Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
---
 fs/fs-writeback.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 969ce991b0b0..54cdee906be9 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1820,6 +1820,7 @@ static long writeback_sb_inodes(struct super_block *sb,
 		struct inode *inode = wb_inode(wb->b_io.prev);
 		struct bdi_writeback *tmp_wb;
 		long wrote;
+		bool is_dirty_before;
 
 		if (inode->i_sb != sb) {
 			if (work->sb) {
@@ -1881,6 +1882,7 @@ static long writeback_sb_inodes(struct super_block *sb,
 			continue;
 		}
 		inode->i_state |= I_SYNC;
+		is_dirty_before = inode->i_state & I_DIRTY_ALL;
 		wbc_attach_and_unlock_inode(&wbc, inode);
 
 		write_chunk = writeback_chunk_size(wb, work);
@@ -1918,7 +1920,7 @@ static long writeback_sb_inodes(struct super_block *sb,
 		 */
 		tmp_wb = inode_to_wb_and_lock_list(inode);
 		spin_lock(&inode->i_lock);
-		if (!(inode->i_state & I_DIRTY_ALL))
+		if (!(inode->i_state & I_DIRTY_ALL) && is_dirty_before)
 			total_wrote++;
 		requeue_inode(inode, tmp_wb, &wbc);
 		inode_sync_complete(inode);
-- 
2.25.1

