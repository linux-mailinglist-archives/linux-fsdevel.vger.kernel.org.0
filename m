Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E302B78C961
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 18:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237411AbjH2QLx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 12:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237418AbjH2QLq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 12:11:46 -0400
Received: from outbound-ip7b.ess.barracuda.com (outbound-ip7b.ess.barracuda.com [209.222.82.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFE01BD
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 09:11:35 -0700 (PDT)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104]) by mx-outbound47-9.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 29 Aug 2023 16:11:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vn3ahbIGn4XGoTI3uWBVk1pUccG0d9UHFnlkOIxXTjBILS766JSAQm6jsbx1hPef901RT/iNUW6IJ98ZtdrMafsS1yioe1m5pC10950Y04sDqd4ons7HaYk5Nl95HAxDEYlyiu8ls1EEoBkOS47k9LNUhMnfJEh5e3DfwFIBa1eahfVAzQpXq1h1KTUmUCPDnuW5DEVi8IlL5FcUkyjFrE4zpZuc72w14zbmIXCWFHKtsjD2YqXFImMJRnN35z3TMxf4fsVNpCy7lnVgEMf2Dx+Xl4TCWvRtV7CRAY9mndMBTQI+eMEZiXcEe4rLPj7NIpmYarwdBjgauJNxwjGyMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wuM4tKUjd5s+yfzROImPt5Hy+IOVlM2RyzqipRv/UBI=;
 b=Beeywe4Vz/UXNDjS5GFOWuCP5nMdZQoL5wXF5TymMvHIyvfWG8oftlYxjpvCm8ZaWkPvi/yVke1b9C+w1jFbBkzDxGepbt3LEYdHLa6JTvAhNvWRfLKZ2GC9xV8VXODuVwXsE1Tr5vGihL974KZicB/3+diNEhVThEfUK3AA1R4jZfJt9sNmFYqjdEikHjRGCU+dL9olU6SXgdj0JO8QinHWK5bsu5y59B2g8UUKyeZ0VG4u/h//HlPbIyT4tznYFsMc6yGZqWKcgrpnU3Ck2X7aaodiDoxy9xW350+nRuT6TbnjzWTFWYyIkYORMkph8SSzmw+b2wy6ql0WXT2HPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wuM4tKUjd5s+yfzROImPt5Hy+IOVlM2RyzqipRv/UBI=;
 b=PFvEwv99jVmdov4d/g09FrT3RbU0OSF20NP7pzvlRD4zbfCHImwiV0U0Bw8yTJ/7R8M558bLo4/QePne42sE55MtLKcyKHV4Ie8GMYqiGL1BY+43QHdCpkB5GkWW2Z8CiMS4ZSRN5HQlKGyyXAbauUnRmwy2gnjcUIOhf5wcP+8=
Received: from DS7PR03CA0149.namprd03.prod.outlook.com (2603:10b6:5:3b4::34)
 by LV2PR19MB5742.namprd19.prod.outlook.com (2603:10b6:408:17a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 16:11:26 +0000
Received: from DM6NAM04FT028.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::5) by DS7PR03CA0149.outlook.office365.com
 (2603:10b6:5:3b4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18 via Frontend
 Transport; Tue, 29 Aug 2023 16:11:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 DM6NAM04FT028.mail.protection.outlook.com (10.13.159.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.18 via Frontend Transport; Tue, 29 Aug 2023 16:11:25 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 4E4C520C684B;
        Tue, 29 Aug 2023 10:12:31 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
        Bernd Schubert <bschubert@ddn.com>,
        Hao Xu <howeyxu@tencent.com>
Subject: [PATCH 4/6] fuse: Rename fuse_direct_io
Date:   Tue, 29 Aug 2023 18:11:14 +0200
Message-Id: <20230829161116.2914040-5-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829161116.2914040-1-bschubert@ddn.com>
References: <20230829161116.2914040-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM04FT028:EE_|LV2PR19MB5742:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a8edb295-9df1-4a76-db94-08dba8aa984d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YZoZz53HpP6/rL3pg7bDB36BjIeAjTbVwjpknsWgl5wCC7tD3SJRe5pBXWW9UnZz7vwp9AGKMuPLmue0eFhOcntT131Upj+jd3Go+oaTC8CFnmcpqwl5icXfvVQ8CVf5mtbDcn53UUmwjFOkLeTRbBrBjIcN9E5kHSnazVAuEFQ7+yTBtDXALdlzbzGRRpOh9w256juarsw2zH010Tkbc3n33iQ8sEeOa2TpHKQ9ZdXk9H/NlA1/yvX9SRmWuItzQBiQPDMYZndpehCJ4sEeo3rkFvRWunH0DkwZzWoHt8U6n+dHoNubn1HWKtiS7RjLyhHTPsBwDemrH1YjICITGEIKRzEYbKbjdRXkkNB1dDCSpLMC7n1n4+3SE/Yq8bHfZHYe8dOfZ3mmiKFhfhW7124bfBhndXCfgJ998SDgqA9dl4jAOkZW6acvwBNsOrXIJJZ12APcUZoWJotA1BjMcAhnVs+opzcOvFscTa/wwky6Ow17hbLXL1o768Bdf68vzAyziGf+3e8gBBSJKMJRh6Cnd492UhwN9buRHHXBm6e53MNKVp4n4mEFyFo0QsY9ySXyQPBE2fc1VeQ/XAtL1VtHGRGAOsQuDIYifqcEurFBX0bdPI5keBgr/y+t77MKmGZ0f9j+nrFyxmHNI+fiQggxdH4jc71fEuE0VCeQH69F4/oN0MQ+F9zPb6O2O1NnH/B8O+PFW3FKz6I2660mKnnb4X/TnBlWS7u7PcrEX94=
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(396003)(39850400004)(376002)(451199024)(186009)(1800799009)(82310400011)(36840700001)(46966006)(6666004)(2616005)(1076003)(40480700001)(86362001)(5660300002)(2906002)(36756003)(41300700001)(8936002)(70586007)(70206006)(4326008)(54906003)(8676002)(316002)(6916009)(356005)(82740400003)(478600001)(83380400001)(47076005)(36860700001)(81166007)(26005)(336012)(6266002)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: F01O5I2JgwxwLdfJhDrbJQOV0Tu7B/4Uyar5tKMH2lNvhvoBIaJaYMgKp9SizeVZHnHAko5IusZSE6ZJFJueoxGXjaDlQQsgAcZ/0KrSoXwdoa/v8ZGCmejGhQK+71mqEwxQZ2mQSGc1xQc5nptn1lqsXfY0ooglTDzo/iVhkAFbSuESlqy4tYOa0ytopBjq/2J6t9Gnst1vWwGPzr5kQ8az2ePYWwmzxwnZmg6+BQWh58vUvuWcKMO8DxUdYyBoHsSrO6XKal4YZiPEO3sE2fV65KAafcfegBMwIB0TIcYqsGW717c0+tOQJfcP7jCIvSK9IYJhDJ2tKqia5up+FmHOCLCXvj3OHjqlGcSVjBPvMRcR/IMZJfrOrJPmCyaoPQHRKFxSCuKu36G+AhIwY2zVOndviAcmInyKpComrXsSMzGVO2r3lJkIqaIIEDivPt4uhtmwfgufJw0+HKmjx6oHdK6gDweEpgRdipUIPNqxCJUCcRHQ7342QGnniNjgr7cQM0PbTBJ0dzWEJKr8ny2xV3TrimGtJJhJw9cv5Ht2G4WMpAeVd9mSY7Kk5sIG/i/WW6m8CTycctOBEs1INcMNdhSI8Er9b+gtgswoG6mBumnyLxhMjvrQPOOTtBIAn6Snr2QdPQ4JSItXTrQleG2AsHqMAiD4+iLG5qhFGt6AZmK1mfx7JBbcTm7vo3yCuh0VGczh2imS69QjcEzoYVSGUIDIdTKxocx+B6qBO2nmD/+PvhyH2uCVsN96DjItmugpsibdb/8TOu1PiyBxsnuxq+urV9J3N1Hf/zOxzG/1bhGqD9K5o7jNIPAlx2jDvcZUKclitkM2i9lPN9V3Tp8YLjvX+BSg+u+N/1d1bA1hdltwmxKDarPvere7RRP3iWsKvGbchRD6+KWabu4RBQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 16:11:25.5422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8edb295-9df1-4a76-db94-08dba8aa984d
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM04FT028.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR19MB5742
X-BESS-ID: 1693325488-112041-11132-321-1
X-BESS-VER: 2019.1_20230822.1529
X-BESS-Apparent-Source-IP: 104.47.70.104
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVibmBsZAVgZQMM3ExMAoxczM1N
        DEPC3VEIgsElMtk8xMTQzMDS3NE5VqYwFT5zfqQQAAAA==
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250471 [from 
        cloudscan17-1.us-east-2b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
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

Just to avoid confusion with fuse_direct_IO.

Cc: Hao Xu <howeyxu@tencent.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/cuse.c   |  5 ++---
 fs/fuse/dax.c    |  2 +-
 fs/fuse/file.c   | 14 +++++++-------
 fs/fuse/fuse_i.h |  8 ++++----
 4 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index 91e89e68177e..c267ae9dcba6 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -96,7 +96,7 @@ static ssize_t cuse_read_iter(struct kiocb *kiocb, struct iov_iter *to)
 	struct fuse_io_priv io = FUSE_IO_PRIV_SYNC(kiocb);
 	loff_t pos = 0;
 
-	return fuse_direct_io(&io, to, &pos, FUSE_DIO_CUSE);
+	return fuse_send_dio(&io, to, &pos, FUSE_DIO_CUSE);
 }
 
 static ssize_t cuse_write_iter(struct kiocb *kiocb, struct iov_iter *from)
@@ -107,8 +107,7 @@ static ssize_t cuse_write_iter(struct kiocb *kiocb, struct iov_iter *from)
 	 * No locking or generic_write_checks(), the server is
 	 * responsible for locking and sanity checks.
 	 */
-	return fuse_direct_io(&io, from, &pos,
-			      FUSE_DIO_WRITE | FUSE_DIO_CUSE);
+	return fuse_send_dio(&io, from, &pos, FUSE_DIO_WRITE | FUSE_DIO_CUSE);
 }
 
 static int cuse_open(struct inode *inode, struct file *file)
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 8e74f278a3f6..423e40ab3e31 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -731,7 +731,7 @@ static ssize_t fuse_dax_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	struct fuse_io_priv io = FUSE_IO_PRIV_SYNC(iocb);
 	ssize_t ret;
 
-	ret = fuse_direct_io(&io, from, &iocb->ki_pos, FUSE_DIO_WRITE);
+	ret = fuse_send_dio(&io, from, &iocb->ki_pos, FUSE_DIO_WRITE);
 
 	fuse_write_update_attr(inode, iocb->ki_pos, ret);
 	return ret;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a6b99bc80fe7..f9d21804d313 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1467,8 +1467,8 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
 	return ret < 0 ? ret : 0;
 }
 
-ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
-		       loff_t *ppos, int flags)
+ssize_t fuse_send_dio(struct fuse_io_priv *io, struct iov_iter *iter,
+		      loff_t *ppos, int flags)
 {
 	int write = flags & FUSE_DIO_WRITE;
 	int cuse = flags & FUSE_DIO_CUSE;
@@ -1569,7 +1569,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 
 	return res > 0 ? res : err;
 }
-EXPORT_SYMBOL_GPL(fuse_direct_io);
+EXPORT_SYMBOL_GPL(fuse_send_dio);
 
 static ssize_t __fuse_direct_read(struct fuse_io_priv *io,
 				  struct iov_iter *iter,
@@ -1578,7 +1578,7 @@ static ssize_t __fuse_direct_read(struct fuse_io_priv *io,
 	ssize_t res;
 	struct inode *inode = file_inode(io->iocb->ki_filp);
 
-	res = fuse_direct_io(io, iter, ppos, 0);
+	res = fuse_send_dio(io, iter, ppos, 0);
 
 	fuse_invalidate_atime(inode);
 
@@ -1635,8 +1635,8 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		if (!is_sync_kiocb(iocb) && iocb->ki_flags & IOCB_DIRECT) {
 			res = fuse_direct_IO(iocb, from);
 		} else {
-			res = fuse_direct_io(&io, from, &iocb->ki_pos,
-					     FUSE_DIO_WRITE);
+			res = fuse_send_dio(&io, from, &iocb->ki_pos,
+					    FUSE_DIO_WRITE);
 			fuse_write_update_attr(inode, iocb->ki_pos, res);
 		}
 	}
@@ -2972,7 +2972,7 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	}
 
 	if (iov_iter_rw(iter) == WRITE) {
-		ret = fuse_direct_io(io, iter, &pos, FUSE_DIO_WRITE);
+		ret = fuse_send_dio(io, iter, &pos, FUSE_DIO_WRITE);
 		fuse_invalidate_attr_mask(inode, FUSE_STATX_MODSIZE);
 	} else {
 		ret = __fuse_direct_read(io, iter, &pos);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index bf0b85d0b95c..05c5cae59bad 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1247,17 +1247,17 @@ int fuse_do_open(struct fuse_mount *fm, u64 nodeid, struct file *file,
 		 bool isdir);
 
 /**
- * fuse_direct_io() flags
+ * fuse_send_dio() flags
  */
 
 /** If set, it is WRITE; otherwise - READ */
 #define FUSE_DIO_WRITE (1 << 0)
 
-/** CUSE pass fuse_direct_io() a file which f_mapping->host is not from FUSE */
+/** CUSE pass fuse_send_dio() a file which f_mapping->host is not from FUSE */
 #define FUSE_DIO_CUSE  (1 << 1)
 
-ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
-		       loff_t *ppos, int flags);
+ssize_t fuse_send_dio(struct fuse_io_priv *io, struct iov_iter *iter,
+		      loff_t *ppos, int flags);
 long fuse_do_ioctl(struct file *file, unsigned int cmd, unsigned long arg,
 		   unsigned int flags);
 long fuse_ioctl_common(struct file *file, unsigned int cmd,
-- 
2.39.2

