Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07697A2E1A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Sep 2023 08:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236463AbjIPF7Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Sep 2023 01:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234360AbjIPF7C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Sep 2023 01:59:02 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2094.outbound.protection.outlook.com [40.107.255.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19EE1BD3;
        Fri, 15 Sep 2023 22:58:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDk0O/YaH7xyvSADWY04a1Kq8EGI/a5uCsp6KhZSYSo4mcQBTC0K3FqoyMmQCOuyzszKHoeaSQK+sVOXWXq6YvUInntUHT79NriY//cdDeFd7evD64LHrUFtTXQanYjWt8HVgx/5fg7d40n/shjSTKTnNIvPo6sGvnc0YRHutLX/PSH9Ike3MnBzhSAy04MMaLIHu9bfe/RZqCM6wICJtPAAVkh2ESlbQJTzAQMgGZZrQOyTrXZebI/BcmhAazTAeNUWQzdzEFUbDH76JyhbOoWfsjKObUixo6RJ1eB8Ual3s5lZaHcubiLCGbH+VyoEwPAVUB07Zmf3OJOKcqQ3dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hm+lhYvKGPsgiAdh1aD0tYmNntDmEqvBMPH/tRN53U=;
 b=HAJ/1kvn5pYDgOKvk/eLTfQYyglZK+qStSAM2VKVa5AlU/uE9ixBKDwIv+6tqTCr1f7NnJaXeC7q57ROqIS5o4Xhgn7t0NdBAw2oTzyMiW56dCr3XlVz7k88cUMdxvLqDUPlM/pGaqTp+4m5OWtgX8QAC6zVK9WFECJCnDlMKbj7Rr/J9nL1h5khB6fZNqoeHgbXCrB78qblTXgFnD8T9EsGUVUuPtiXsFCdNr8yXpYLs2hPSZcmSrGh5nYH/TDFw+YrvC8gXssSyAOX7Xd6jkMhMvQz/QFUk4BQYPmP/5rNLsiSzk4z6dSkjx7Cr1XeI8qVjuLXDgWEtqhte8SGqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hm+lhYvKGPsgiAdh1aD0tYmNntDmEqvBMPH/tRN53U=;
 b=btv3VC6TnuJ3GYAppBIfYTusj/NvRsKBVRckd8FNktlLTqUqV+0ULcLcazUgu68ihEYzULikPliYTb7SnBeqn6hHrYxBL5izl2G1juQbEl3Ku/lyW7Vf+cWynu34XlwVt4Yqj02pH/A+3kCB9vQdP5VPeBFc3Vuo96vBj99aJ0/Kp0YjnnlFxPSzhR2koFMX60JTQuWD6aAjP6Dg/JtTGvQDL0/CoWu4OJuA5ASriUokvwTbsUtft2hfwmA26POfF2hjfQmkcy6SKz6l1psZTebF/GtsrMzdvw/n8zVKwii4ih5vduovw0HS5PNDRZI08SQL84H+zEEUkHAHQ+aMpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY2PR06MB3342.apcprd06.prod.outlook.com (2603:1096:404:fb::23)
 by TYZPR06MB6308.apcprd06.prod.outlook.com (2603:1096:400:41d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Sat, 16 Sep
 2023 05:58:53 +0000
Received: from TY2PR06MB3342.apcprd06.prod.outlook.com
 ([fe80::60d3:1ef9:d644:3959]) by TY2PR06MB3342.apcprd06.prod.outlook.com
 ([fe80::60d3:1ef9:d644:3959%4]) with mapi id 15.20.6792.023; Sat, 16 Sep 2023
 05:58:52 +0000
From:   Chunhai Guo <guochunhai@vivo.com>
To:     jack@suse.cz
Cc:     brauner@kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chunhai Guo <guochunhai@vivo.com>
Subject: [PATCH] fs-writeback: do not requeue a clean inode having skipped pages
Date:   Fri, 15 Sep 2023 22:51:31 -0600
Message-Id: <20230916045131.957929-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::7)
 To TY2PR06MB3342.apcprd06.prod.outlook.com (2603:1096:404:fb::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR06MB3342:EE_|TYZPR06MB6308:EE_
X-MS-Office365-Filtering-Correlation-Id: e47af366-76b8-4c1d-602e-08dbb67a0120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J9Db6LnaDZ0M4MtzW8SxMRsXalYGwjEdGsQg/MbD3ZHfSUJiMcTSFeY0UA0f9GML1zsQVyGYpxXAoRdj1KFxcrrwNze+m9k/9IshFbopAaWi5SHIrsowFZ2zurSsl+p9wcxDcf9gSzOapCZchUAxRTT+nmFh7jQeoD5vHIy9uccFFyGI0eFqH4ifuhS7kx/oDDN74J5oFqPtHqVSSG5Jma99Oz+esMkWoxB1z/pca3ozPycC3PyxHCAAAtGPodjLBpcH9khcfYJzVApTEJufnRYROcCFF2ug7obwd2ZrsFEHrG831Ve68QGwhEzp3ipFy03BJeFIFK+FpsdQmZ74UALDNrNNfB5aOgw+2d7n2Xm0HaVP2Fl7Iz8VhRsiCNuMA7V6WuHq2/acEmCjsp74IKTRSvtAfj/tBn3icvq9pykBGwfsE7RW45H4bvfg8mRnxnMBCAXXUJBB/bgk3V4I73xazRe4zyLcUaq1hvRyUWkkN4oMpGD55ByFYhvT1UBV3n+jO423yZi2zWKklT3V4zeFlOCxuJ0+uTSPgOtZ53HCInFwvXq/BdvQe3EiBPg58Q9D6fSm8FKwdsfrYhzfsNZytJNOU8deTbDtBIlGPexa55IVoQ/jspDlucF+GOLT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3342.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(366004)(346002)(39850400004)(186009)(1800799009)(451199024)(2616005)(1076003)(107886003)(26005)(6486002)(6506007)(52116002)(6512007)(38100700002)(36756003)(38350700002)(86362001)(83380400001)(5660300002)(478600001)(41300700001)(316002)(66556008)(66476007)(8676002)(8936002)(6916009)(4326008)(6666004)(66946007)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qDGpopi8JF+iX8k2A8cJbYksi0DF+lcIGt8efgluxczroKjnV104l0c197qs?=
 =?us-ascii?Q?z0oPJ1j6xXylpwks5VTXmg30DlrNajw5Ygdzga90a1XfIFRnJUxs03u0JEf1?=
 =?us-ascii?Q?/U6XPbCQ6r2hW+2gZwlEdDSW5fPrChOAIrwwvjLPTj4pcCAG4ZkZ0xoBuNWt?=
 =?us-ascii?Q?qGp+uWtu6uXW7PhzZM3yWW9yqNm/INIUUY7F7fENtjJHJ5OrWFES/G3OwZGU?=
 =?us-ascii?Q?ZWlD7nttv3iRPd5OXs5wAuTNSnJZMg//WnnZghyTO9sEdB9dGNOXqNt5+zY8?=
 =?us-ascii?Q?8geegdjcrA+4IsO9W1WftHuxT9C3tD16NIfRpTxgT4y6jndkzw0iorra/qgJ?=
 =?us-ascii?Q?ED3KfBx55vkRXtR68dR4uTKkyJhip5UW5ZdwvvJ3XarYdY2KGLJVp9XCO11e?=
 =?us-ascii?Q?VJnXNPU4SIbNO7RGVt3KVeLjXpdeS3KMSz1FqeB1BVs8lhFnYlTkOwDFEENs?=
 =?us-ascii?Q?epNT+0Fe1OY9Tu5uZW5AVFBkIAql07RPE254+Sw8P9G6Bk0ROXRaRdttdoQg?=
 =?us-ascii?Q?miLRjsefBv/M4i1Chw62TS3Iq7wF8T/yqdiA7BC2srFiZgeFfzPBgALw6ViK?=
 =?us-ascii?Q?Z3795kks+ISaFInL6cJbM2gxrVmEwwa6dovPWDe8S8SMJPCxf980dotbP/od?=
 =?us-ascii?Q?eYIPlDN9624vDQMtnj9YXUE4Wfc5gt3SaTHd55o7sSg34m9kXS6IMbWrfgP8?=
 =?us-ascii?Q?Od+6u8jVQ8BKANXDilpJk/hQ3pFOlj4emyuWSgljrPr9OmGtpit1Cg1lY8k+?=
 =?us-ascii?Q?ReO5QxoHIyJQcsZpgQkiq+weayY2rWI5xkthAxhkPhBQX4B2GdCNxSeaG5Ob?=
 =?us-ascii?Q?fb/8/bcluNeeDTCDVh+2g9BHsa4JkV9woCA0e50qieT1eh3o7yGFH8rll0mW?=
 =?us-ascii?Q?HZSEvLjl0sN+dmTRQ04Ysg1yPcnMDmUwmKq787J29ZKQ7DXwgqfQT2xkQwaG?=
 =?us-ascii?Q?aKyoRYT7/XrxKij9ycLnh+jMVgHT8Ode/+bxD0DkTNDpKzsy6t3jA6A5OnvS?=
 =?us-ascii?Q?dIEDOg6ATxWaYFep59LsDLJAnN1b6oy8kqY8PFoYMYK7cG0wMROEMcveoyaV?=
 =?us-ascii?Q?5oLC/Onlsk0/H+PJY7MsMXSClvzWsMUXYuxZu2rby9793bbh7ifrBOvWUw44?=
 =?us-ascii?Q?F5JcH6lUPDXKUYnSDadVwrcxgoYWWRxMO3we3SjFNyrh7zTuUjs7wiet6fGQ?=
 =?us-ascii?Q?5qfKusmnl1fX1mphIoKeizZxTGxzv7cSrhLdXb50e1Oa366IHelHKmQRBXqH?=
 =?us-ascii?Q?EDaeU3NujTyKV5ufwTqPj/6aR6XmdQOQAL/EcQ+dd8COa7Z8i4WTeUhoTv8z?=
 =?us-ascii?Q?uvC/wJkc12mIN6oYOKlFSQgyP0RcQK9+sqVALzrhKTnK68c2TvGJYApwARbr?=
 =?us-ascii?Q?gkvlFoMr0xwd3JW9pp3MprPZ8Dgh2M8lObkPw7QZMpeyQXQj9TPv9LU4i3I1?=
 =?us-ascii?Q?CA/26+DDYVD4jWMp4UbbxbVi1r99k9yegd4CeQLS4wDpJEic9u/WLNDiT9F4?=
 =?us-ascii?Q?Y6gALjdWqlcI3RGBN621WWg9rqQzOdUbydrb8E2unonLtgjsq7lO59aJKv0g?=
 =?us-ascii?Q?j9Z8T9I160m2VBnlwz7KqSx8G3IZnCL9Hzgf1pxd?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e47af366-76b8-4c1d-602e-08dbb67a0120
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3342.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2023 05:58:52.6948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4n8aSjGY5OZHHIcmWGuAmxPW/FfYqPX8gXcY4l4JizId39cU7XkDPrbY+YoOCbKq8O07/SxDjJm4GR0hsRVmNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6308
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When writing back an inode and performing an fsync on it concurrently, a
deadlock issue may arise as shown below. In each writeback iteration, a
clean inode is requeued to the wb->b_dirty queue due to non-zero
pages_skipped, without anything actually being written. This causes an
infinite loop and prevents the plug from being flushed, resulting in a
deadlock. We now avoid requeuing the clean inode to prevent this issue.

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
 fs/fs-writeback.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 969ce991b0b0..c1af01b2c42d 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1535,10 +1535,15 @@ static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
 
 	if (wbc->pages_skipped) {
 		/*
-		 * writeback is not making progress due to locked
-		 * buffers. Skip this inode for now.
+		 * Writeback is not making progress due to locked buffers.
+		 * Skip this inode for now. Although having skipped pages
+		 * is odd for clean inodes, it can happen for some
+		 * filesystems so handle that gracefully.
 		 */
-		redirty_tail_locked(inode, wb);
+		if (inode->i_state & I_DIRTY_ALL)
+			redirty_tail_locked(inode, wb);
+		else
+			inode_cgwb_move_to_attached(inode, wb);
 		return;
 	}
 
-- 
2.25.1

