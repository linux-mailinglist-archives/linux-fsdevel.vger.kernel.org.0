Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E82779725
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 20:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbjHKSiz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 14:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjHKSiy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 14:38:54 -0400
Received: from outbound-ip7b.ess.barracuda.com (outbound-ip7b.ess.barracuda.com [209.222.82.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AD530ED
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 11:38:48 -0700 (PDT)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2047.outbound.protection.outlook.com [104.47.57.47]) by mx-outbound43-95.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 11 Aug 2023 18:38:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Znf8A3G9FfzFlBCh+A5RjsuhLX4ZnKxul6hiOfx9eHaIeIuC0M1q4SsJcjXfYobSeaddizLupd768mLOuoPGABX1Fhol+CNOijDhL4oidCbixKGa+hMU7WQXNVBQb1yL8wSC+63vcpedUkx+MzIhq4fRoWQaQQ8hSfCQbygYNlXE46bRMc+zRdrM9nDVVimewQG9eR/IuiOidwcd/pi5fQoYp0HKkPE8c3QiXT8mab3uBj3tbFbUlZqM8frjMvrM+vmluhHIoHmpk/ROs74XA7DkyGDREjOoyhdrjKYu5cktCkj1W/KGtotD5E68BObqrx6NowvC4eGebqxAQj7rWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKjyBGRmHM2FO5O+kc+f/LscX/QoRWAM5KBI78zcvtg=;
 b=Q2HdhZAjKjftoNjuYKqaOqWlKVypSy66LEXe+q+4cRs3Z2X48auUvqRFTDcRO5yXiU3tAlnDHX1ZQWJ1/G0dJrhuvnjJjJYyF54ouI88zSy82K+LuPuU2yJqEcADkcAxJLbFgwIze4Cseh8B9IJZJJ7dIpdLK/SLbcg7n7+96kOpUPmpnV02U/T2KhW2PdulcVuDr5rpL6aX7ScdS80wQsl0ulNm+9K0vcpRoTK7ASLRvvsFJlg5+hevZCTn4C3/GGzGvwWjYH96O3j3VlQIlI7+eOWIdgKVVWGslDIfXBL2JvSfjcBgRPaCjY8L9ntridfFc7UjfZhUeXFGZW4PAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKjyBGRmHM2FO5O+kc+f/LscX/QoRWAM5KBI78zcvtg=;
 b=S1/G/h4T8VsvEEG+Mupx06mlOUEYMCuiAFuVRptuF2OEVpSIgfRa1/gacCAQEIF7edQQx1vBHjqiC7ypry741Ki64OJKF/tdNBh21XG9Frmw3MazWleiHbY5rxP4rt7D7JtHvU2GgyTUde1cSIBbnCUQfY6r0zx6XT90MuqivEM=
Received: from SJ0PR13CA0193.namprd13.prod.outlook.com (2603:10b6:a03:2c3::18)
 by DS7PR19MB7723.namprd19.prod.outlook.com (2603:10b6:8:d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 18:38:36 +0000
Received: from MW2NAM04FT026.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:a03:2c3:cafe::87) by SJ0PR13CA0193.outlook.office365.com
 (2603:10b6:a03:2c3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.7 via Frontend
 Transport; Fri, 11 Aug 2023 18:38:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 MW2NAM04FT026.mail.protection.outlook.com (10.13.30.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.9 via Frontend Transport; Fri, 11 Aug 2023 18:38:36 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 8574420C684B;
        Fri, 11 Aug 2023 12:39:40 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, fuse-devel@lists.sourceforge.net,
        Bernd Schubert <bschubert@ddn.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Dharmendra Singh <dsingh@ddn.com>,
        Horst Birthelmer <hbirthelmer@ddn.com>
Subject: [PATCH 6/6] fuse: Avoid code duplication in atomic open
Date:   Fri, 11 Aug 2023 20:37:52 +0200
Message-Id: <20230811183752.2506418-7-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811183752.2506418-1-bschubert@ddn.com>
References: <20230811183752.2506418-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM04FT026:EE_|DS7PR19MB7723:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f5b0a06b-5096-4ffa-e21f-08db9a9a2c99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VoMxg/okmLJHafduNZttkb+p8sdEqMHlNqHBDWTbGzG7IkmZxG/B8uR9xFHEoUjydREaxFRzSY4Fr7ZaVHC1gaWUbjwPiUBO5jzogm/5b97XJgdqrvP1H55ZIs7f020fl7YXQ91KmJIe3oLDG/0T1QWzF1noU9BG8Ma+OayCJvVDzrfWGOUcl5jeWNhAISqtw5HxSE10zRJC7A08r2K4hmgyPTwqipcNqoauvCBsUpCbFJi4uCGvCoGSNGeY27kvesKslZUgpky9I1WqpUal8qqcKSI73b9qcZPITsA/bHzqGRPaQpLBIMAAmohZWqNl/e+p4VDu9OqSTesoZ8LFcxrSWXQQ0wTjfINI2X7ZKXj0HbuMrkt0F5oUhlRE7PEY0KmApr+0Pe8ZlomYb3ILDPlWdjhZPuT3qYX0ckCfL8fKUwskvHoos4ZRwLL/AvGidwnDUc2zaobCFxvKX+KZodiO/ie6sv0UauLaO2I5CZvC/nEFXIqSwayrTRykPzQcHb7IWpCQ1RB/Iiub7KM6ZHmYHHqmMs/BoJCrhj8gJXU3IYl7H2KL+8HTqCrADLcWR7Jd50Xo8DN4zpb+lTbAAnay1ruZcFmVe42b7fCrWm4FyBsvoOinBfwlcyCzOLVYNrzUIpPlAnVrY3iQa2+ZezZll6IEYhnza8lFTP5wTUaArYeqU6165jILorSt+kFQV3iQxCYHVEg+DK5v4hSPAK5ZqDMY1stEKRKee/4qMYiE0f8yy1uFOv42h09NmljMq1IkyYbqN4HgRb25cRE91w==
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39850400004)(376002)(136003)(346002)(82310400008)(451199021)(186006)(1800799006)(46966006)(36840700001)(36860700001)(2906002)(54906003)(4326008)(47076005)(70206006)(70586007)(6916009)(83380400001)(478600001)(356005)(86362001)(82740400003)(2616005)(81166007)(40480700001)(316002)(8676002)(8936002)(5660300002)(36756003)(41300700001)(336012)(6666004)(6266002)(1076003)(26005)(21314003)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lRz4nZG65S91CH7AxLmZkWnn9qPziSneI8nWf1qNOuiVFRmQrolISYWV1fxmpCLosjvs+AhLhWchMDZxHKCTd/BkIsd9OdSE+8BZafLLsGztmj1Yr0+ewMc/h8IzMdJj/jTDQjuK9K24S6UcOIx8LzPxvzylkKC+P+nvKfHmpSale8C94k58yf+JxG+5n9roQNIkTIJm27rtMMUIPgVWUd/oIVFkr7bs9EgkpsuYqPyQMqIrHcPjSn1kBAiSJjmIHLdTkUHkFp69CIRoHSlmV046uF7ZPVy7F7b58JNAhnvGOa33/OsVGGj5aHiNcvHp4ty1HCWLczliweywssVljBSwbx5Qrg8bpHJDRB6hwLWn8d4aDoULp3Lat8oO7Dsn5P+i1qtV2VAd/u6rAVJjYp3wMu899JKeu8JIiGNU4IQ0Jyf/TsOlx3870VSTsHc8QHO3L7VWulzbuuL+vlnitt5BYHzIdcSOm/wvPI2EmCe7c4MoExpEzAuXmAmzlI+w3DPGz90ps9Ng2a1oBUn9bQlARBF4V0u2DVOvulMIAElfsjVA5Uq1eIzAog6C8reiOGRVYKXNNtgLHJ6vAYZ8qjzTKZu4rghMNK03pSLA4bqyg5APPSPZoP+CFKFGILS4CSy43n4NoNUxBK3liOeNN6zw5n7xNWfsnu3hcsPf6Wz0kb9++9pH4ou4SmTKMdnum2ZvZX8ff5zgb2PPNdqjVFhiR3wbZKDXhJWfDtI+6lgXmXsMvpVmqnZZFb9wiTqXOF8ZySaK1+zEWTkPzNBM0AU9kS6hqqvpWncS74kK2rNniU0MJCWFHa9eEY3EH8pCUKqIrN4uG8gpZ8QzBtooWliLRwA0puqQyUGB4XdAGnYQkP2AEm6wBYp47KtwOc7c63y57PvIY/japREAvIsxijS4F6sF9pADwIxfwUgAxqY=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 18:38:36.6043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b0a06b-5096-4ffa-e21f-08db9a9a2c99
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM04FT026.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB7723
X-BESS-ID: 1691779119-111103-12494-6466-1
X-BESS-VER: 2019.1_20230807.1901
X-BESS-Apparent-Source-IP: 104.47.57.47
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYWZsZAVgZQMM3QIi3JyMwyMc
        nMINEiJdXMNC3V2CDVwsDSwtgyNcVMqTYWANDT35tBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250079 [from 
        cloudscan12-184.us-east-2a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The same code was used in fuse_atomic_open_revalidate()
_fuse_atomic_open().

(If preferred, this could be merged into the main fuse atomic
revalidate patch). Or adding the function could be moved up
in the series.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: Horst Birthelmer <hbirthelmer@ddn.com>
Cc: linux-fsdevel@vger.kernel.org

---
 fs/fuse/dir.c | 52 +++++++++++++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 27 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 067e1a2fb23a..f6f993a51d33 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -808,6 +808,24 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	return finish_no_open(file, res);
 }
 
+static struct dentry * fuse_atomic_open_alloc_dentry(struct dentry *entry,
+						     wait_queue_head_t *wq)
+{
+	struct dentry *new;
+	d_drop(entry);
+	new = d_alloc_parallel(entry->d_parent, &entry->d_name,
+			       wq);
+	if (unlikely(IS_ERR(new)))
+		return new;
+
+	/* XXX Can this happen at all and there a way to handle it? */
+	if (unlikely(!d_in_lookup(new))) {
+		dput(new);
+		new = ERR_PTR(-EIO);
+	}
+	return new;
+}
+
 /**
  * Revalidate inode hooked into dentry against freshly acquired
  * attributes. If inode is stale then allocate new dentry and
@@ -839,17 +857,9 @@ fuse_atomic_open_revalidate(struct fuse_conn *fc, struct dentry *entry,
 		struct dentry *new = NULL;
 
 		if (!switched && !d_in_lookup(entry)) {
-			d_drop(entry);
-			new = d_alloc_parallel(entry->d_parent, &entry->d_name,
-					       wq);
-			if (IS_ERR(new))
+			new = fuse_atomic_open_alloc_dentry(entry, wq);
+			if (unlikely(IS_ERR(new)))
 				return new;
-
-			if (unlikely(!d_in_lookup(new))) {
-				dput(new);
-				new = ERR_PTR(-EIO);
-				return new;
-			}
 		}
 
 		fuse_invalidate_entry(entry);
@@ -1003,26 +1013,14 @@ static int _fuse_atomic_open(struct inode *dir, struct dentry *entry,
 
 	/* prevent racing/parallel lookup */
 	if (!(flags & O_CREAT) && !d_in_lookup(entry)) {
-		d_drop(entry);
-		switched_entry = d_alloc_parallel(entry->d_parent,
-						   &entry->d_name, &wq);
-		if (IS_ERR(switched_entry)) {
-			err = PTR_ERR(switched_entry);
-			goto out_free_ff;
-		}
-
-		if (unlikely(!d_in_lookup(switched_entry))) {
-			/* fall back */
-			dput(switched_entry);
-			switched_entry = NULL;
-
+		switched_entry = fuse_atomic_open_alloc_dentry(entry, &wq);
+		if (unlikely(IS_ERR(switched_entry))) {
 			if (!inode) {
 				goto free_and_fallback;
 			} else {
-				/* XXX can this happen at all and is there a
-				 * better way to handle it?
-				 */
-				err = PTR_ERR(new);
+				/* XXX Is there a better way to handle it?
+				 * Especially !d_in_lookup?*/
+				err = PTR_ERR(switched_entry);
 				goto out_free_ff;
 			}
 		}
-- 
2.34.1

