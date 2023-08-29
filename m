Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3EA78C962
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 18:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236351AbjH2QM1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 12:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237488AbjH2QMI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 12:12:08 -0400
Received: from outbound-ip179b.ess.barracuda.com (outbound-ip179b.ess.barracuda.com [209.222.82.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956A21AD
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 09:12:00 -0700 (PDT)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44]) by mx-outbound44-243.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 29 Aug 2023 16:11:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PIGv2EA08fvo1dHzNvedzXWgH9eN4NJnse+PAtRPDrlAMTrVLutuC0OajS7ph+BYvterityZ/SZrAWQ683RX1CHRfkxccDOJ1+peKbUypLVbZ/j5Vt6FFoPn9toZrrGlAWup4T7ZhKP+P1aTW/H1N7SPA8xRzP2tEP7q8yNw7V/krRmDhP8S3ufwQGv2IA4Z8mHiHznXLcCTZMsW6vw23ut9YsHoSUFXBQ8+c9ylcT9fyifOD9Der05M5IqMc0sqJGlTzdYU0bC+SD643OUYigQElYuFK/rzKw2rWdy130nRRGDwAbWYpQ4btYI9WnC4wVRGgoE+117gjnWIRfScSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7nlRd4WNOPai7CgEpPPc0U8w+BE8B10HSW/FGqzcCs=;
 b=aZXT8EuBUN+k20dz+S3CXMyGWThnZJakvuve4HvUjYPD/gdD7MeaCWfhu4aJMLg3h3bIGFFZUEY6vfJguxz+EGcjymRwVpofCnZomBRi5tVxjZGP1ZNonXuhjH4fiY5XGhcBaHdtlmsoHLn97QKHv5QeL1ZR0aGK2iDMLA5wUk7saipaQTxl3oDbAr1qN6mQIPoO2l1JEmPqWegNUXNDKP45zU0I/Olv/QoZ5az5p+SbEw3xe9CayXODVdTZr8y+JUHRE+yGT3ia1vEzpbPNOuBp8ZRfr5gXVchDAq/zqtOCZscHev3oWe7c3MCAnErOHfWcexOt1PhTg082Uy+FUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7nlRd4WNOPai7CgEpPPc0U8w+BE8B10HSW/FGqzcCs=;
 b=vsmZtL7mrw+U+sDeVPNoHjxbGsqJSvmUoqLDrLxqFmAeVlrVD44qQTpBcLjDs9pct4pr/iBa36t6ZjY8Z2b5tDIcKOoAVJMhv5cbH5ZJvLhe0GHFJgdo8x7B3glP6elzZ3GJ9kSH3RyOkoX9SipHV5iHKjXShZgKBuyYp0YvGPo=
Received: from BN1PR13CA0029.namprd13.prod.outlook.com (2603:10b6:408:e2::34)
 by MN0PR19MB6067.namprd19.prod.outlook.com (2603:10b6:208:382::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 16:11:25 +0000
Received: from BN8NAM04FT010.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::39) by BN1PR13CA0029.outlook.office365.com
 (2603:10b6:408:e2::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18 via Frontend
 Transport; Tue, 29 Aug 2023 16:11:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 BN8NAM04FT010.mail.protection.outlook.com (10.13.161.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.18 via Frontend Transport; Tue, 29 Aug 2023 16:11:24 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 52E0020C684C;
        Tue, 29 Aug 2023 10:12:30 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
        Bernd Schubert <bschubert@ddn.com>,
        Hao Xu <howeyxu@tencent.com>
Subject: [PATCH 3/6] fuse: Allow parallel direct writes for O_DIRECT
Date:   Tue, 29 Aug 2023 18:11:13 +0200
Message-Id: <20230829161116.2914040-4-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829161116.2914040-1-bschubert@ddn.com>
References: <20230829161116.2914040-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM04FT010:EE_|MN0PR19MB6067:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e2b7e7fd-81e5-4f3c-dc56-08dba8aa97f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RTuYeqLTQ2NbcTzMDvuTkL48VRbesCibxSyyX+WssR1g8XcR2M4hVzI6NgoQXFS0vNw+ytVgGQBw2XHFu4lPo4OMor5KcdZBXcErvI4v/n0HwzrpQ+PrULnKigxrhFq6iCi8R/NqsuY/xWxrImnHmoH+zxtxTVC3e7tkh3JieOVgsiBtImge+Vui/NMtnODBR5p5KlmbpBAC5Q1jA07vYoL5dDqLnc4ROIhamdMyXeZ0+QS8Eotli1IGI82VQzn8gdH2L3GuZTbJr/f33eJNk6UbA/ok+ECEzDKm9KIrtcmsjLAAK7uXxu/Tj+P7gaY7BOiT60iHSGXjMXdK3Jo7A4aRd5yF4MhwFsIiRV/1bsTfo9wFyqO4Gpy1zLltzqatCdL2wtZdVFzLFRti+Emk+AZ1+CrFIKZm9LX01/wsgv1jZ4m6THbarrWCIrb/mK/4/ETICWQp+G2/NY8/lyxrSAwhyy5WvKoQO8wsAD7OK7OHNSPIei3wpazVKOGI8lDkJIIzxDn0bjlTUk5LFIMd3c2JNt9L87dPLVmpy8f9x0dkXVoxg4PGuB8WsVGSuD5iJ4ZoVTJNfQVKZus6Znez5+Ci+8Z9WKxr63pfkLvMRpgFOvEN5Yti7elr2iWUApustsd3YdprExQ/sUsqsAk0QHbPbF+bSSin53i5DdvncxijktDPt0mOs1sgJsRPxk/uH436Bsm5CUVjHTtMaFm0xBGGutq3rpdG8k4K07lJoUy7f1DZ3sl79Sc5UP6Owj1W
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(39850400004)(396003)(186009)(1800799009)(82310400011)(451199024)(36840700001)(46966006)(36860700001)(41300700001)(26005)(356005)(81166007)(82740400003)(6666004)(86362001)(83380400001)(478600001)(47076005)(6266002)(2616005)(336012)(1076003)(40480700001)(70206006)(70586007)(54906003)(2906002)(6916009)(36756003)(316002)(5660300002)(4326008)(8676002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eGU6z/Qx1IXj0YFKXtaP5RDlfaMQrnPKJPvxwcfJxtnHvIDGD0Yt+Y6dm9SMVd4sv1a5wwl8I9PEkzQ3PCKLyI1FMtAy0AB9tQ0s9KVBk1HRsvhSmnwfd49Vp2mLXoE0DkQrN/OtVMnupfeLke+LpTUF/HZa4Ujf/50aZcY79bwJr3/cUGz5FuR9lu52+68fh3ScsY6tiboma4kiN6SYeG5ZqgkfihLIufaIof7Kp2iQA3VJb3P1EhjYs/mO+ksqrnA50s4iQ1qJ7I7pJPtYn66k94Ndygn8idacCoXFbQBHGX+hfjNKqZ1GNQrEwJrB/VvO++aykl2u5HNBoQpyx3uXjuyPPypk/afhfFouLnI+QiXL4/A1exZjI51CNgha4SUUpQwrMG3YxIpx2ZQSYnF1FUmOo1m4hBJiyypsFN+LIyuXJsejgdeEXSBTUIImMT0DLClKH47yvKD/vmlRUdCqTmM1WzHH4dswafv7k08b0LMXEXFjXQRjUXrjGDlhbEPGDJaWzDMbJwE50TWRTauqQ0B0ape78l0xnhCphlHVTJRmTy8kHCJzXspmVDnrH8dgJ+FBz/BKEfq30zkkAHYyQ8c9VK2Po21N8V+dRReBWBoaZg7TJXy0+e9rhjE61/XW4sGoUHCY1qblSaQw/OHS6YT3s6a2Oojyh0NQzHChle61HczNRAWgzxz5rtK+VHDyMeA2a7/0/wTGDp7RN20Vq/kzLCroI4ueizTm19HcFwYmbDMRJtCqRAG6yXF1oyoVRdwPlkTKT5nhP81ZrOU18SJqTdUoCHMC1TleMNdQcSED8zjj7gV3YSnK4ykA9XfOq5Td+OZBCX6NOnxhYRzeubV+ktlYA6PQSSnl5yQRsIx3g5Pb9xJgVbtVUc37apzxHW9CGLzKdmdI3htU4w==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 16:11:24.8767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b7e7fd-81e5-4f3c-dc56-08dba8aa97f1
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM04FT010.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR19MB6067
X-BESS-ID: 1693325487-111507-24138-750-1
X-BESS-VER: 2019.1_20230822.1529
X-BESS-Apparent-Source-IP: 104.47.56.44
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkamppZAVgZQMC3VwNg02cwyLT
        HJ0sjMwMIs2cTc0tTQ0MjIwsDS2NxUqTYWAMc2cCNBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250471 [from 
        cloudscan8-212.us-east-2a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Cc: Hao Xu <howeyxu@tencent.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/file.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 6b8b9512c336..a6b99bc80fe7 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1314,6 +1314,10 @@ static bool fuse_dio_wr_exclusive_lock(struct kiocb *iocb, struct iov_iter *from
 	struct file *file = iocb->ki_filp;
 	struct fuse_file *ff = file->private_data;
 
+	/* this function is about direct IO only */
+	if (!(iocb->ki_flags & IOCB_DIRECT))
+		return false;
+
 	/* server side has to advise that it supports parallel dio writes */
 	if (!(ff->open_flags & FOPEN_PARALLEL_DIRECT_WRITES))
 		return false;
@@ -1337,6 +1341,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct inode *inode = mapping->host;
 	ssize_t err;
 	struct fuse_conn *fc = get_fuse_conn(inode);
+	bool excl_lock = fuse_dio_wr_exclusive_lock(iocb, from);
 
 	if (fc->writeback_cache && !(iocb->ki_flags & IOCB_DIRECT)) {
 		/* Update size (EOF optimization) and mode (SUID clearing) */
@@ -1355,7 +1360,10 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	}
 
 writethrough:
-	inode_lock(inode);
+	if (excl_lock)
+		inode_lock(inode);
+	else
+		inode_lock_shared(inode);
 
 	err = generic_write_checks(iocb, from);
 	if (err <= 0)
@@ -1370,6 +1378,9 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		goto out;
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
+		/* file extending writes will trigger i_size_write - exclusive
+		 * lock is needed
+		 */
 		written = generic_file_direct_write(iocb, from);
 		if (written < 0 || !iov_iter_count(from))
 			goto out;
@@ -1379,7 +1390,10 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
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

