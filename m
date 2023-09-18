Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C577A4F66
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 18:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjIRQmE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 12:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjIRQly (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:41:54 -0400
Received: from outbound-ip7a.ess.barracuda.com (outbound-ip7a.ess.barracuda.com [209.222.82.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF685B8D
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 09:40:15 -0700 (PDT)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44]) by mx-outbound11-163.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 18 Sep 2023 16:40:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJ48ypbTgXk5yIR8HsMAVCbgShW19N0ngJg1NrsLWHLsKW9UwNIjahvVApRKCMNTUbY2J2M81ZFzmUG74JWOEbp2veDFt8/HPaLswYrAwBW+Oy0wgzmTww2B/eVpJDc9zsgLhsEB8ccacE7Xg1IMXfBRGZNIwopplbq9vH/QZKIMWso+LQ+KTBVQTqzG5e6c+f4OnR2nZ+WUK1KBqwtjTfOqLH3F94M7rYdnapSb2D9iIGR1ZL35zL0tsz5wAmFLdcTZOS+Ooz5ZwSP+M3QMzMnwZVogeGFREJa7GsDsd0nZizbzobb5BcuX3BwieAp5NeXq1tCVlxVZeLosN/r6ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEKxj1woarFZs4hVj0u89yjWwOVMVli+PwRDZv79UGI=;
 b=IPcFEYTIr/h6b1WMNBHu3lmdm3jjPhZoKWTVqeOdaqohDOJsftPUmlM53TP4BLGxArCJGLwUjvbl24+zOf6fsEXe6Vtl/xkSxSkqOUWeQvu2o6DtfDB55uAdWSPD9KaiJIq/oS21dJu6oZtQzOe/9CZZt3lsokXg0YWDlcayX9z+4bg+OcaYXsumXQkZh5xxe4BaBuwYljz0ZGxHk3dv69DBX5/QuDwZMdXiwZ9JS5zIUXlQ3gXV6VwkX/gKOya+KmsQQWgRZRPRAXvDQENaPzBMCa7OQfRrGxH47WCgYqpu3865OyVyZvD6CqOAoKu4BiZ4ie1OclC77V5sMXFBmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEKxj1woarFZs4hVj0u89yjWwOVMVli+PwRDZv79UGI=;
 b=qFyYX2YOPLiM0+vp89ZcloxOyL5gIUuP93t6vkic1qZ+mue5knIGWA46mB3MCLMsMZPHNH2/WXNPmh6gLs0OffK7jr56Ei5e4iOCMwzcE53159Y813fUr1ynXoKIU6gvP9g1Pf1qZAe1lAxp6ILT3FpKWe9qwGYO0csZR0CT5tw=
Received: from SJ0PR13CA0240.namprd13.prod.outlook.com (2603:10b6:a03:2c1::35)
 by SN7PR19MB6758.namprd19.prod.outlook.com (2603:10b6:806:265::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 18 Sep
 2023 15:03:19 +0000
Received: from MW2NAM04FT012.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:a03:2c1:cafe::67) by SJ0PR13CA0240.outlook.office365.com
 (2603:10b6:a03:2c1::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Mon, 18 Sep 2023 15:03:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 MW2NAM04FT012.mail.protection.outlook.com (10.13.31.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.15 via Frontend Transport; Mon, 18 Sep 2023 15:03:19 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 6A6EA20C6850;
        Mon, 18 Sep 2023 09:04:24 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
        Bernd Schubert <bschubert@ddn.com>,
        Hao Xu <howeyxu@tencent.com>
Subject: [PATCH v4 03/10] fuse: prepare support for shared lock for DIO writes
Date:   Mon, 18 Sep 2023 17:03:06 +0200
Message-Id: <20230918150313.3845114-4-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230918150313.3845114-1-bschubert@ddn.com>
References: <20230918150313.3845114-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM04FT012:EE_|SN7PR19MB6758:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 68c350d4-26a1-4aa4-b91d-08dbb85864e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OmO6zeyjSvBrMIpHwe76cnhBAGf5qccRSI4a6ny71EeNt/r77xeOym0xrKZ8kvm1ISQFFUU47nxhn1IDksxWG+/YmbngNlHTLjtqkAPuiPFJIqMjlARj+MWULDogj8+g2tOniZS0EsP8oHS5qFuMU5NE5RG2GCQ7+EPyiIbDbANbmLZsEPGjSTm70LMF1p+Bc+XpXxSbFFk1ju08hd+epG80xs6uhtTuOGgXTWrIh5+8qgJhnXNxm+IHK3TTUKOrdDiad/LDBmVbPX6Mw/qEdjdQmv/rtvL9m9ExQRGm+C2KZy0ibsOZgu7JV5Pakvk0qY34XqC6KFLP4CFy8ymesQc3H+gKqH4EacxhX443ipDDCl9XhTwLGJrEpbSsP+MA6T+5xaExu9iwiOyTzh5YoEI1OY3JvWk7xPZgvYsvIiPsx+y5l/NEKS0SCUT+EF5/z9LoMV296bt/qMNzOnOOTKr4pzH6S42fqAUhQijJ3Gl550hkLZrkUcrhjN08eYIm7eYMk+3BjLKRxu56rlQ64YrPyIdrnQl2twF+gTI8MW2yEms6XhYrM+uMGck1/WgsTdpO6sLkUqqFVyb82GNEct0LOHE11vUVyou/3gDDE3c6cQNCojJvWhwg2qivY6nG37pEqlVWOu9s9sMFC3O4V3db6OqtFu9NbO5tZpHp0FDZvVRE+dmnnZcakGN8uJIeqO/pGLEQvKC8crKvY8T8lgoA1iekDXZhkb7t72ae7mSI6WAZWsT1B7AtHAf+wSF9
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39850400004)(396003)(376002)(136003)(82310400011)(1800799009)(451199024)(186009)(46966006)(36840700001)(356005)(81166007)(82740400003)(36756003)(40480700001)(86362001)(478600001)(70586007)(70206006)(54906003)(6916009)(2906002)(6666004)(8676002)(8936002)(4326008)(5660300002)(41300700001)(316002)(47076005)(36860700001)(336012)(6266002)(2616005)(83380400001)(1076003)(26005)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2RCuP3HSRHhbkB8JX07A8aCRDyL6/KG1UJcLCErtiEPRMAY1nxn/nryRqXyzNLW4dFmRvfWthF1psanbkhlpFbSb8DBTsHORrWT1Daiv6HUob1LmptCOc9eW47dvKIjG1pXmYanMxQYxNUVYDB3qKKgtCOvNOv8l1fU8KTYmqK6onoZY/ZLRyZFxb5v792mgEPzBTvNwHKv4wb3mVqsPtL47hEvk6ApIWFncHssOpnPlow7izgp6+Ti39ZDkyG/gpfosdBr4kRvgbwkImpc3aRGPRzyf/pxLy8xNn5kxREM7LsX9eH5bBA4MGVmLnC8gXiX6RaGGMxvTYYlsX2ll9TIdi++rwQwuTpVUONPsAWRNmaWUdGcCeg+3bo6SNQiNNGW+Y8sBCBwvBX1/Jpxt4WsWQ12eI9tA1dU2gvwp+Vlzhaq+Tb3U55jo67qrO38SQnheaDt/gdSUfLtzzDC78j/Ht/udjXLF6eqX1RdErjKU8vZC9xDfHIJsIOimLl0peO7KmRS+VXWvc3xgkMM0Pz5DDydeFNkIeehSAxnCdCBhghI7tP2P2Smh5H3zYboK8b17vc+srKRt38w/gV+o5Ek94QWVJWEla1jJhKwSYReXaEfRv7dkJ8+BhMQ48pW39HIUzXUzDI+AO/oBfGN//ZxU/ivcwYF+BEoVL0zFCahE62oD506beoqmVaHwa9JRxnpyTx0jISkzDHfcTb5jXkBad+D81q37hjm9yJKm6xTu3HeWR4SUcM6HQRpW5pCSx+RKz/4AA83r1pRPXtSFNz/Zm7oY0gUhNXxMapC8cNreqt9Bab3iUu64soyjrF17pIlE2wqUXkrHTinfFDzIZYYG3Ewgq7IDk3P7YhjbQwMDZC/ctxuppLABA/KOALtUWaI4tBc/fleBYGqoZW37rA==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 15:03:19.1816
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c350d4-26a1-4aa4-b91d-08dbb85864e7
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM04FT012.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR19MB6758
X-OriginatorOrg: ddn.com
X-BESS-ID: 1695055214-102979-23088-2255-1
X-BESS-VER: 2019.1_20230913.1749
X-BESS-Apparent-Source-IP: 104.47.74.44
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsaGhuZAVgZQ0Ng81dLEIM3CLM
        Uy2SzZwiLV1CTFJNHcyCjVzNgoMdVQqTYWALbZZWRBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250915 [from 
        cloudscan10-134.us-east-2a.ess.aws.cudaops.com]
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

Take a shared lock in fuse_cache_write_iter. This was already
done for FOPEN_DIRECT_IO in

commit 153524053bbb ("fuse: allow non-extending parallel direct
writes on the same file")

but so far missing for plain O_DIRECT. Server side needs
to set FOPEN_PARALLEL_DIRECT_WRITES in order to signal that
it supports parallel dio writes.

From style point of view another goto target is introduced,
although the existing writethrough target would be sufficient.
This is just done to make the code easier to read.

In this commit the exclusive lock still enforced by an
'|| 1'. For readability this will be solved in a follow up commit.

Cc: Hao Xu <howeyxu@tencent.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/file.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 7606cf376ec3..76922a6a0962 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1313,6 +1313,10 @@ static bool fuse_dio_wr_exclusive_lock(struct kiocb *iocb, struct iov_iter *from
 	struct file *file = iocb->ki_filp;
 	struct fuse_file *ff = file->private_data;
 
+	/* the shared lock is about direct IO only */
+	if (!(iocb->ki_flags & IOCB_DIRECT))
+		return true;
+
 	/* server side has to advise that it supports parallel dio writes */
 	if (!(ff->open_flags & FOPEN_PARALLEL_DIRECT_WRITES))
 		return true;
@@ -1338,6 +1342,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct inode *inode = mapping->host;
 	ssize_t err;
 	struct fuse_conn *fc = get_fuse_conn(inode);
+	bool excl_lock = fuse_dio_wr_exclusive_lock(iocb, from) || 1;
 
 	if (fc->writeback_cache && !(iocb->ki_flags & IOCB_DIRECT)) {
 		/* Update size (EOF optimization) and mode (SUID clearing) */
@@ -1356,7 +1361,20 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	}
 
 writethrough:
-	inode_lock(inode);
+relock:
+	if (excl_lock)
+		inode_lock(inode);
+	else {
+		inode_lock_shared(inode);
+		if (fuse_io_past_eof(iocb, from)) {
+			/* file extending writes will trigger i_size_write,
+			 *  exclusive lock is needed
+			 */
+			inode_unlock_shared(inode);
+			excl_lock = true;
+			goto relock;
+		}
+	}
 
 	err = generic_write_checks(iocb, from);
 	if (err <= 0)
@@ -1374,13 +1392,24 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		written = generic_file_direct_write(iocb, from);
 		if (written < 0 || !iov_iter_count(from))
 			goto out;
+
+		if (!excl_lock) {
+			/* fallback to page IO needs the exclusive lock */
+			inode_unlock_shared(inode);
+			excl_lock = true;
+			goto relock;
+		}
+
 		written = direct_write_fallback(iocb, from, written,
 				fuse_perform_write(iocb, from));
 	} else {
 		written = fuse_perform_write(iocb, from);
 	}
 out:
-	inode_unlock(inode);
+	if (excl_lock)
+		inode_unlock(inode);
+	else
+		inode_unlock_shared(inode);
 	if (written > 0)
 		written = generic_write_sync(iocb, written);
 
-- 
2.39.2

