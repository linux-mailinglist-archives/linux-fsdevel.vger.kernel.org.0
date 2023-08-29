Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E9D78C964
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 18:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237326AbjH2QM6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 12:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237444AbjH2QMp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 12:12:45 -0400
Received: from outbound-ip7b.ess.barracuda.com (outbound-ip7b.ess.barracuda.com [209.222.82.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B081A1A6
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 09:12:07 -0700 (PDT)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107]) by mx-outbound17-154.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 29 Aug 2023 16:11:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5Kc9p2Qe0CxE8fYob4Gg7nvjl+2t7C7gDlB/wU557byMHfWVd+Zz4H8kL0996zS+sVs9+HQ84c7Sb+xbsnrJ40IdVya6Z8Wt7mk+hgh6VGyBlkn5nhlh0deoznVj7B/EiKy35eFHnEPIWGd8CAfZzIFwPqb5fUoanDHsbEG4UHScYPWYHTIrrI9iHx947Rs1SUvj/SH0DD+bs3pHClG5IIMYqhtMtAGXiB7KsF7XO+gcRhbMYp7+k2PAWl77XGVxj8LHKewJb8W+sU3X+RrfczIhQtELN51L7unVqZbd7Nydz4V6yQe6vKm41UEiJIdjjOAyY2KOKg7RQcx9Z8aIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pg7YH6UttqfeJMxCpLoLYjoxRfR3isuHHZV9AEi8C5c=;
 b=XAkzG6+/xkVCNktNt+nF36G50mnb4WCSNswTF1Kys4Ai4Qarup1PEkZ/Roaai47NcZZy9XjBPU6hcjKzPDk0znRjlvMTY6NLjuuAqP73QyNic3+PZVxNSxXqWDZbd8kL+yqZrr8j7N2ZozK9BvVOwv9pGxb2wBKPpOQJqx9KHWvM8Q2qFYs+GCnMrukt+Wiu6flQ/RgWypuCkpgGqE+zFi+rnVkbv0aJbxjj6Rgh4MpP8doELlj+xew87qfaAJsi2eBr4vmv3+UBRvV904LZ9CqseqUTZuIUhGNIizT7Lgww/zIqYpA1CsrvJdre/w4LDMlZ/uS+2Adw6u69tsn8EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pg7YH6UttqfeJMxCpLoLYjoxRfR3isuHHZV9AEi8C5c=;
 b=XcU2hI3f7yE6Vb3FY26jEY41PFdyckS4dovNvBoXccCWMI5uOnMoPlb1mSgC58El02TNVMoWVs6AAVvMQtvgxQ+bGqz1ngICF98soda2t2bkj8ZL56qh7j5+c1KGWJAcwCvwSTq8JyQZX/KQaIaFO9XuZeRjSxlQXTxXU6yLTms=
Received: from DS7PR03CA0198.namprd03.prod.outlook.com (2603:10b6:5:3b6::23)
 by DM4PR19MB7899.namprd19.prod.outlook.com (2603:10b6:8:188::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 16:11:26 +0000
Received: from DM6NAM04FT037.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::8d) by DS7PR03CA0198.outlook.office365.com
 (2603:10b6:5:3b6::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.36 via Frontend
 Transport; Tue, 29 Aug 2023 16:11:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 DM6NAM04FT037.mail.protection.outlook.com (10.13.158.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.18 via Frontend Transport; Tue, 29 Aug 2023 16:11:26 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 48E8920C684C;
        Tue, 29 Aug 2023 10:12:32 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
        Bernd Schubert <bschubert@ddn.com>,
        Hao Xu <howeyxu@tencent.com>
Subject: [PATCH 5/6] fuse: Remove fuse_direct_write_iter code path / use IOCB_DIRECT
Date:   Tue, 29 Aug 2023 18:11:15 +0200
Message-Id: <20230829161116.2914040-6-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829161116.2914040-1-bschubert@ddn.com>
References: <20230829161116.2914040-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM04FT037:EE_|DM4PR19MB7899:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 74521d06-0882-4f1d-f32e-08dba8aa98e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dJkSsPmx94LJHxtDhYoDuRO87XOhFLqdpge+FSEDZF8o4H6EjZT/4q9hFQnriZ63InvY9z59QGbEESiqKwIhaEGQEetZ+6OZadiHiLUOBv3VhN87ePxZt0byeI7r80UMFDUgfQvWpuHsuZulOiyg/uVrUIVO614dqGe68lnnhqtxfYYAkswbA0LXkldL/QAYvWfQpFuexMAIFTLO+okSDY3i5ZZjNH1b15WWfr7KFOgcqnHfrLY61uJuwDwzO9W52pSYcKFAd+PK9N0IE+IccoEorfxHlo7xd+1vhjaeu6mIBIdyHgtTwKqVDHvltb/VaUvpDYLe3SC2rjaLBen0jh6axNxJM0j4cslFfya0DimGXiFZ7zhJYtLgq1FsgVtG2kC/kT3vHvGclluSK6OPkYBrxr70Efo9gCELGKLjpOtXwJTWbJqz5Q/iD+1GDQHOQgGBAzLFAPKLDhqixQoDxEo8FOo3Zzq01zrrOjxOnkjhM3HhonFb27d0iq43SUF/OZREGYlynFrki0eXB36V71S3d5PHEmqdu9IyciJZxFsvEvbIsNe90al5JsI3KjmIIEaeWcz1nZcpoQG5Mjiv/By2EDaF/WYjFAD1axxKS3/FKLs5IX1KrGdvytIEEzcl4d2wPeZDdc3GPzrTfnLBdt62M9shuIZXeNWPv08i9jpmAAdzg6Ma9iLuepbUF4bn7f+1Uny46ztcwQ4zGWjvM3hB5NmARGhcpMXiGIbhiTg5vGaTXG3NM3DrGAHCkxJp
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(39850400004)(396003)(186009)(1800799009)(82310400011)(451199024)(36840700001)(46966006)(36860700001)(41300700001)(26005)(356005)(81166007)(82740400003)(6666004)(86362001)(83380400001)(478600001)(47076005)(6266002)(2616005)(336012)(1076003)(40480700001)(70206006)(70586007)(54906003)(2906002)(6916009)(36756003)(316002)(5660300002)(4326008)(8676002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: N+laJ+8GyHvp9osKUI9Ep5iL3n5oV2StAnj9PCVY50HwiLju1EuMX70J2Ehuk+51KurG72t5SjoqwETYA8oSn81TUxYY/5ZKx9w+bb6Cy4d3rJZGel04tcF8Ebr07MuCZf/cG4p2eMxpk4VbbSX1w3WRVgGQ1XwpCi3pPEH0HwUjX2p58fwBGUCRvguC+Igggv14RfF6r2GwfyA3L/m3+W0KHD+c8HD7wAge4cek3YEYi14++qbv6l6uYDtMuuo7grl3dFyKyyitTN6+qP/M800zu/itq3l5BRzRoEmjqUkuuuBj+QjctITnvsEYWkrwT4hqR1Ti7Silykor22QUciLPoSZFh/HX/SlfxL8cJDK4M7GVrCXpqd9DSHKjsCJ2zQGh0Yc5Lj+KsAub3ynZ/KEE1/mYR4UwOGab/T3nLjGQ57xkgRq6X0ex/8BGdq5dZ6FfBhCIAHQ9WasulqcoktHLbysnxwTcZJhGFPgAQuainC6SGXn25mWi/vGyq4/n7Y9KIjwSDHcL/gSbT+s8bMEh+z6JomflhcmfubwpvnyASsU/Uo46+4/QD2XK6kye7LcGSCG7ey5DSJG9jcO/a+uma752hW1QzCA4ISWoU76td7pGzBcz0urH7Zk5ff+oXYfoAmwjS3SZ28mMuv+thJWL47guz0htO49d8vuw41xup0dtwF+VXF5dsxVjbhl1PQHaA2KNSgBKlVmXOsitS7y3gzy3M8mvYHiTj+R5++9N/wpERHhyd1csI28tv48NSzndMcaKBHEcY+wtxnqK83S7KaH0RQ03vdzEYiJVA1yNBGNRF05Mf/z/lGcBKJRws39lXLCSzPWuQPW+uadHUsfKyH3T2w5lYN9alWNQf01/IxotFTYV2TTvDyzaDZTw0JHoAVV91xU9toE2AGrvXA==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 16:11:26.5520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74521d06-0882-4f1d-f32e-08dba8aa98e7
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM04FT037.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB7899
X-BESS-ID: 1693325492-104506-21430-533-1
X-BESS-VER: 2019.1_20230822.1529
X-BESS-Apparent-Source-IP: 104.47.55.107
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVibGloZAVgZQ0NDIJDEpxczYMt
        UwzdzQzNwy1Swp2cTANNEo0cQ00cRMqTYWAEoXh9pBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250471 [from 
        cloudscan14-41.us-east-2a.ess.aws.cudaops.com]
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

fuse_direct_write_iter is basically duplicating what is already
in fuse_cache_write_iter/generic_file_direct_write. That can be
avoided by setting IOCB_DIRECT in fuse_file_write_iter, after that
fuse_cache_write_iter can be used for the FOPEN_DIRECT_IO code path
and fuse_direct_write_iter can be removed.

Before it was using for FOPEN_DIRECT_IO

1) async (!is_sync_kiocb(iocb)) && IOCB_DIRECT

fuse_file_write_iter
    fuse_direct_write_iter
        fuse_direct_IO
            fuse_send_dio

2) sync (is_sync_kiocb(iocb)) or IOCB_DIRECT not being set

fuse_file_write_iter
    fuse_direct_write_iter
        fuse_send_dio

3) FOPEN_DIRECT_IO not set

Same as the consolidates path below

The new consolidated code path is always

fuse_file_write_iter
    fuse_cache_write_iter
        generic_file_write_iter
             __generic_file_write_iter
                 generic_file_direct_write
                     mapping->a_ops->direct_IO / fuse_direct_IO
                         fuse_send_dio

So in general for FOPEN_DIRECT_IO the code path gets longer. Additionally
fuse_direct_IO does an allocation of struct fuse_io_priv - might be a bit
slower in micro benchmarks.
Also, the IOCB_DIRECT information gets lost (as we now set it outselves).
But then IOCB_DIRECT is directly related to O_DIRECT set in
struct file::f_flags.

An additional change is for condition 2 above, which might will now do
async IO on the condition ff->fm->fc->async_dio. Given that async IO for
FOPEN_DIRECT_IO was especially introduced in commit
'commit 23c94e1cdcbf ("fuse: Switch to using async direct IO for
 FOPEN_DIRECT_IO")'
it should not matter. Especially as fuse_direct_IO is blocking for
is_sync_kiocb(), at worst it has another slight overhead.

Advantage is the removal of code paths and conditions and it is now also
possible to remove FOPEN_DIRECT_IO conditions in fuse_send_dio
(in a later patch).

Cc: Hao Xu <howeyxu@tencent.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/file.c | 54 ++++----------------------------------------------
 1 file changed, 4 insertions(+), 50 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f9d21804d313..0b3363eec435 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1602,52 +1602,6 @@ static ssize_t fuse_direct_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	return res;
 }
 
-static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
-{
-	struct inode *inode = file_inode(iocb->ki_filp);
-	struct fuse_io_priv io = FUSE_IO_PRIV_SYNC(iocb);
-	ssize_t res;
-	bool exclusive_lock = fuse_dio_wr_exclusive_lock(iocb, from);
-
-	/*
-	 * Take exclusive lock if
-	 * - Parallel direct writes are disabled - a user space decision
-	 * - Parallel direct writes are enabled and i_size is being extended.
-	 *   This might not be needed at all, but needs further investigation.
-	 */
-	if (exclusive_lock)
-		inode_lock(inode);
-	else {
-		inode_lock_shared(inode);
-
-		/* A race with truncate might have come up as the decision for
-		 * the lock type was done without holding the lock, check again.
-		 */
-		if (fuse_io_past_eof(iocb, from)) {
-			inode_unlock_shared(inode);
-			inode_lock(inode);
-			exclusive_lock = true;
-		}
-	}
-
-	res = generic_write_checks(iocb, from);
-	if (res > 0) {
-		if (!is_sync_kiocb(iocb) && iocb->ki_flags & IOCB_DIRECT) {
-			res = fuse_direct_IO(iocb, from);
-		} else {
-			res = fuse_send_dio(&io, from, &iocb->ki_pos,
-					    FUSE_DIO_WRITE);
-			fuse_write_update_attr(inode, iocb->ki_pos, res);
-		}
-	}
-	if (exclusive_lock)
-		inode_unlock(inode);
-	else
-		inode_unlock_shared(inode);
-
-	return res;
-}
-
 static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct file *file = iocb->ki_filp;
@@ -1678,10 +1632,10 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (FUSE_IS_DAX(inode))
 		return fuse_dax_write_iter(iocb, from);
 
-	if (!(ff->open_flags & FOPEN_DIRECT_IO))
-		return fuse_cache_write_iter(iocb, from);
-	else
-		return fuse_direct_write_iter(iocb, from);
+	if (ff->open_flags & FOPEN_DIRECT_IO)
+		iocb->ki_flags |= IOCB_DIRECT;
+
+	return fuse_cache_write_iter(iocb, from);
 }
 
 static void fuse_writepage_free(struct fuse_writepage_args *wpa)
-- 
2.39.2

