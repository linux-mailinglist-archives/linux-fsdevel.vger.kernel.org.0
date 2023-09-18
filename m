Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F357A4F5C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 18:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjIRQlD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 12:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjIRQkr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:40:47 -0400
Received: from outbound-ip7a.ess.barracuda.com (outbound-ip7a.ess.barracuda.com [209.222.82.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981FDE69
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 09:36:57 -0700 (PDT)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2177.outbound.protection.outlook.com [104.47.73.177]) by mx-outbound9-230.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 18 Sep 2023 16:36:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PvMeNJ68vTNNF0U8P/AvStPZzPrB+Yqw7saTIHlBjbKh/8JoPECAFWJ+W7TGZhLUCBQW8Czbg5Dge1p0ldn/P3I0nChKiVkcJuZmdNF/tK9sEBPvtc5OLe4G9aTQ/sNh3P65v6kVeJnW42UhH5sOtowBizuk3B67EBi2jOG02nF2Neu94i9GL/QeuydZAytkhf2mRoyADk0YfFaYK6yikAJ714mwliPb+PFPosARvFGwe6c3slKmBWyws+9td0U8me0PkNdVHXamxv0rKixALnuNlos1iBgIjj1gusmeZSR6rmw54Y8IRxQl6Wb1YHa+PQYxj+PENKXTX+B5SEH+FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2obs+iuM3XFh3K6/EWoiEgSzIAz2WXPWrrDT/U7eVc=;
 b=NEwaH600clbIBzBdtYnjAVXGAY8B0JX+2Psu1xjzgB8t59cvLnQhQZKbYJRMLD1MNX784llO96g0urG38AuMhEENRpm/ti0IZQA1Hu83YyGRrN+w4tV05OZ8JPGdk9Wo037GiJ3fL/qBwfVW2SPrCeyF7CAH6OCWwv+/r/iRsPoxIdQuv+LYzvctVpe1wAhZZUkBK8krQLIm8nSS5KG8kL5FtLXcN3EoFOKcqPXqN2OkpSovHqjMuGU8r6Vo+hdcBsIey674tGAkDS69qAhcyAI1nST5+2FOy1V851zwWF1CTZo1VvXd/3qTVd1vAmpfdPrDtTBsssJapK7X8buVlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2obs+iuM3XFh3K6/EWoiEgSzIAz2WXPWrrDT/U7eVc=;
 b=FJNogLQjjjiC0N/pUsdqnqcfBjqWry9t6ruXlkbkNBkjxV6Oz0BBYlFDNjtAl+ODGgFU9vYUSvnhj/7hV9+GSb2coYMCxexqmgAlt0riL8zxbKz4GjXoyd836c3Dt0ps8czF6ATZrKLFgXHI3Diwu1TjVIdDDfed81gyetjv7vo=
Received: from DS7PR03CA0156.namprd03.prod.outlook.com (2603:10b6:5:3b2::11)
 by SA1PR19MB4845.namprd19.prod.outlook.com (2603:10b6:806:187::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 18 Sep
 2023 15:03:21 +0000
Received: from DM6NAM04FT014.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::17) by DS7PR03CA0156.outlook.office365.com
 (2603:10b6:5:3b2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Mon, 18 Sep 2023 15:03:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 DM6NAM04FT014.mail.protection.outlook.com (10.13.159.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.16 via Frontend Transport; Mon, 18 Sep 2023 15:03:21 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 6010320C684D;
        Mon, 18 Sep 2023 09:04:26 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
        Bernd Schubert <bschubert@ddn.com>,
        Hao Xu <howeyxu@tencent.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v4 05/10] fuse: enable shared lock for O_DIRECT / handle privilege drop
Date:   Mon, 18 Sep 2023 17:03:08 +0200
Message-Id: <20230918150313.3845114-6-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230918150313.3845114-1-bschubert@ddn.com>
References: <20230918150313.3845114-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM04FT014:EE_|SA1PR19MB4845:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6e45832d-2f1e-42fe-d11e-08dbb8586605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wbiOx9zB/23s7GChEknpe/KkaWAT3QNlnsBwn5zfCOEKCNQzqMm00kgOipGg7uA4C6Z/lPwQc5CcF76aUmn7u1lzQGePIBMw+AnodlCxGVwnW2U2GZYlxih03G+RZGxCNQUjk08+KEPbJcZwDVpBikcZ0n40farQWqyi9K8pTNM+kank3EPXqC6J5s6+AmzWWQKNytyjvFr7qVQd4nUDbgwxjMldpADSpy8MqQaDm7BZvhHVe/Nm3FOoSjbg2Qd6naVfkyvD6FO6zPvURB+JdAe9yL4HYFQiqXzm4FZ1mznUOGjxQNRtY9ZjpCi5ld9zbTHx1nQUA9XaxkVPq+shdy+0XnejCjzt2uzfJVbUTLKMMTS9SW20/C8z/im/tAazF+SOYi/ThRldgXmgRmhTdE/4jkSC+yQA3SR+D6nQbicqC+Kf33yMQE6DeHRV85VcUOvCiyo6nkXbj3JcmPo50HoihgDlAx7cYMiutRsS57r9UARJb0FnIl0dig0L/53v1eUgd80zjZR1M2kHMsBBRlkfrDDezs1Q6iBrzyXda941AItJXRlpknAg+B6arBB1KQ3ufieMSQarOLJDl39Vq2U6BEMhs0x1ONB83+XBaGRzlEQam2dQyaxlumSIH6V8K+A2usHGbTOpEEIztQOgMo2m/oOHVBXq/yc2w0vTX5cWWoeYopdm7ROdSG2gl/hpbnW46knBY2qRt/nn4I9TutTvNBGjypsDnAd5mpvVIXzsDvS04vRcIL/HGGOIRTLm
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39850400004)(376002)(346002)(396003)(136003)(1800799009)(186009)(451199024)(82310400011)(36840700001)(46966006)(336012)(6266002)(36756003)(83380400001)(356005)(81166007)(40480700001)(47076005)(2906002)(82740400003)(36860700001)(41300700001)(2616005)(54906003)(70206006)(70586007)(6916009)(316002)(86362001)(26005)(478600001)(6666004)(5660300002)(8676002)(4326008)(8936002)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7RpesSNj/oJpXl8a6mSvIl4Gtwr9bYA+wkvXOJWVqVYeJQ+4uifuYhtS85sW64GVvpmIlvM20o7cp/+2/BKyZt3rnW4ANbQ4f7l5gBHR7Khn6co2T+E8gsOVOF6cExlELWjFquwAZgJjISDIZ1lzUlP3KtFKMfS+Qjlekn1musRY7Y8b5vheQOQ/i+EcBjRVTRdqa9ZPvG+3MKi6gEwXIwg5phfyKsjBGcvO/i/dXZ1kcoYsY3XGVft+OKhCPyOi2rYGfdzHSzarlA7J633L8jHPB3+i06u0YGbr0JSjtOo9E3t4s1JXtNG+Jqsy/LgZJGJQvSSv2k38KcqWrZj1iS6s8kmIl2EbfFNLJj5rhUgYoGSQc4MSu039uwT2txH4rUYLWpzMWuodLRmfKikay+6FplnPDLyLCafp892JIBVl+wAALz3RQ5DuSyNEcOjcp7khx867x4MtS/LUTJ32UXvWS+ezOzZ3R14jOOZXVRoGeQholRB4bcyLyfwN+oStJGXEg41tlGuB5E6NhOO51yiUBzKzaBxMVf8LEibsxusHawlsUvyzrl8wYs4QGcDoHWDVwATIybDGXzRTeBI5dbbj6CbmRoWLTemeEsf8+hhNe7rCKJwfh8Ze1gX/C+yo4U9tUPxi//p03fVZs3mezi6WH0/AAyXOihHiNvnzUMwO6WUZzi1xcwoQmCZLl6mKvQZWNAFbUXfXYg9/LhKo3dVVFVW9pLjlMOSpMWhKC0CxoPoGdxLY/ZQ4vw7PeIcnm5XE/Z/FQqA2TF1RkMu87zEZslWyjnq61eoBHUOmfVGT6fmJr0W8VVmnOeSWP0JmWrD7suk5NUS68OaxoYSUI5tXCNkPZv9Lh0FhvjO0zUXL+EfJh0WT1wZFt4fHoqs5CzyNZpSheXanrJ4Sniq/QeIEuldkRQ+4MIox+V99GzQ=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 15:03:21.0566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e45832d-2f1e-42fe-d11e-08dbb8586605
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM04FT014.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB4845
X-OriginatorOrg: ddn.com
X-BESS-ID: 1695055015-102534-27434-2714-1
X-BESS-VER: 2019.1_20230913.1749
X-BESS-Apparent-Source-IP: 104.47.73.177
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYWFkZAVgZQ0MLQzNAgxdDQ0C
        zJwjIlLS3R0tDCwMzE2NIoxcjCJNlQqTYWAAfz/y5BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250915 [from 
        cloudscan9-71.us-east-2a.ess.aws.cudaops.com]
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

This eventually enabled a shared lock for O_DIRECT writes
in fuse_cache_write_iter.
Missing was to check if privileges need to be dropped - if so,
this needs to be done with a exclusive lock.

file_needs_remove_privs and file_remove_privs are both sending
an getxattr call, assumption is that this is rare - should
not have a performance impact.

fuse_dio_wr_exclusive_lock() is not using file_needs_remove_privs,
as it needs to be called again while lock is hold - it would
result in a typical double call into file_needs_remove_privs,
with the expensive xattr retrieval.

Cc: Hao Xu <howeyxu@tencent.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/file.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 76922a6a0962..feafab9b467f 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1308,7 +1308,8 @@ static bool fuse_io_past_eof(struct kiocb *iocb, struct iov_iter *iter)
 /*
  * @return true if an exclusive lock for direct IO writes is needed
  */
-static bool fuse_dio_wr_exclusive_lock(struct kiocb *iocb, struct iov_iter *from)
+static bool fuse_dio_wr_exclusive_lock(struct kiocb *iocb, struct iov_iter *from,
+				       struct inode *inode)
 {
 	struct file *file = iocb->ki_filp;
 	struct fuse_file *ff = file->private_data;
@@ -1342,7 +1343,8 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct inode *inode = mapping->host;
 	ssize_t err;
 	struct fuse_conn *fc = get_fuse_conn(inode);
-	bool excl_lock = fuse_dio_wr_exclusive_lock(iocb, from) || 1;
+	bool excl_lock = fuse_dio_wr_exclusive_lock(iocb, from, inode);
+	int remove_privs = 1;
 
 	if (fc->writeback_cache && !(iocb->ki_flags & IOCB_DIRECT)) {
 		/* Update size (EOF optimization) and mode (SUID clearing) */
@@ -1380,9 +1382,20 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (err <= 0)
 		goto out;
 
-	err = file_remove_privs(file);
-	if (err)
-		goto out;
+	if (!excl_lock) {
+		remove_privs = file_needs_remove_privs(file);
+		if (remove_privs) {
+			inode_unlock_shared(inode);
+			excl_lock = true;
+			goto relock;
+		}
+	}
+
+	if (remove_privs) {
+		err = file_remove_privs(file);
+		if (err)
+			goto out;
+	}
 
 	err = file_update_time(file);
 	if (err)
@@ -1623,7 +1636,7 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct inode *inode = file_inode(iocb->ki_filp);
 	struct fuse_io_priv io = FUSE_IO_PRIV_SYNC(iocb);
 	ssize_t res;
-	bool exclusive_lock = fuse_dio_wr_exclusive_lock(iocb, from);
+	bool exclusive_lock = fuse_dio_wr_exclusive_lock(iocb, from, inode);
 
 	/*
 	 * Take exclusive lock if
-- 
2.39.2

