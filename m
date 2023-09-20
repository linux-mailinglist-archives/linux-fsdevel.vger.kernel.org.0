Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6677A8AAB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 19:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjITRfL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 13:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjITRfK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:35:10 -0400
Received: from outbound-ip141a.ess.barracuda.com (outbound-ip141a.ess.barracuda.com [209.222.82.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C162DCA
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 10:35:03 -0700 (PDT)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41]) by mx-outbound47-222.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 20 Sep 2023 17:35:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R34CydF1KkaXZZaUBSBLf+HUz8FyiBBKnxig+wZxRs9TY07T80jMU6iZZidI3Q/ewBiocncM9SHTK7+zp8uHizDpweQyAQ5mzgHXfOeMMh5VZAujeFvXi4x7k8K0FvEPrR03e+zypP1WsnriygNnlP4RhkB627hJuKv9wsj/937fx0GBz++Wx0DcIhKXpj0zyDTh3cd25e6JMghE8Zz5G2/wvT5GElq2nSlcURCYbQKCB7J5/ePQLLl+EZ1uiq+TMJMdjuzKG6lfFPOS4sj/6zML6VkODJkJ7bzm8GNg6RGU1Zz2PiavqLEs0AQa1Vxiqo5XH+7aAWAYqIEOOZbsAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQhiNYZxNCqIYSC0x3YMHHJRwnKRTwmTeDL54z9n008=;
 b=SuZCA1Cz7ljeDLKDFPYc7K107XnHiAab4ZNIT88IQ9IjHNCjoUsyBko7nsvMQM2gFgZaZtR5jUvX/OonQ3uV46nKv9V0lnaSYwMEEuTpyJyykQ/ifkyHC/xFGWbQcCLVtSOqxS85YCzDfyB+hB1jqdnLd0MLL0Yqm+OgZ7Y+4DHz55VdyvePbXxa7bMX1iHkYrhs8xGA1gxmuVRg6aczr7NTWfpgpySb7notOqrCDOZGqYuFT0L5NCm6IE7FooOHo0BTDHp0SxtuSSOiSoKoarC5lr1iSHVYotWndlA4LUze+1a3LU0bjvKDo1AkZWuo84p6AZpdheBFHbRjQG85LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQhiNYZxNCqIYSC0x3YMHHJRwnKRTwmTeDL54z9n008=;
 b=gSlrPDP45DnOXPYkbA7i2bUQZ2MH2rLTG7iGJebS/9ls4U9nX07yYh0GbBNhPVEuECwkNRgSHPbhGdhYw6Cgr3rn+GwGGGMPDGFlYSajRTCKAvD43DC+D7sHWsG+vYaNR+McXpydRWzIAO1C2N0jaUr8xQhKb4XvL00o5BlRFdA=
Received: from MW4PR03CA0240.namprd03.prod.outlook.com (2603:10b6:303:b9::35)
 by SN4PR19MB5472.namprd19.prod.outlook.com (2603:10b6:806:20f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 17:34:57 +0000
Received: from MW2NAM04FT025.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::a2) by MW4PR03CA0240.outlook.office365.com
 (2603:10b6:303:b9::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30 via Frontend
 Transport; Wed, 20 Sep 2023 17:34:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 MW2NAM04FT025.mail.protection.outlook.com (10.13.31.128) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.20 via Frontend Transport; Wed, 20 Sep 2023 17:34:57 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 36DD420C684C;
        Wed, 20 Sep 2023 11:36:01 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
        Bernd Schubert <bschubert@ddn.com>,
        Horst Birthelmer <hbirthelmer@ddn.com>
Subject: [PATCH v9 7/7] fuse: Avoid code duplication in atomic open
Date:   Wed, 20 Sep 2023 19:34:45 +0200
Message-Id: <20230920173445.3943581-8-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920173445.3943581-1-bschubert@ddn.com>
References: <20230920173445.3943581-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM04FT025:EE_|SN4PR19MB5472:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d5bbc374-2a7a-4d7c-f3e6-08dbb9ffe876
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /aF4PQ5mSc4QrSMFBdBs+N/g5r4yE/9bxQpgKo0DTgSTz0ipvpxKBIYlkQK97/i1BsQpgVjdKCfTqfxqkE4fN3sikzUAH6fpW5bYRiBOgeOdhPQ3tWTnwZcLcvCd4SJ+YJ0atKIKGDuNegw6jTUl6pockCJBNIi1yIBxAqd98k/PAOuFi0wTlwK+lt5Xa54aBD3ENMBtWbg+GIOr/ESEZrXuedNwcXQwdv0JxF+YsSOCvIPcW8Usy6vfC8zypj+iey50TToPsRV0o5NF2xZ6LVRuB9VBREEYyXzERgWGEjsMn3d6PeMlsH17Cm52nTCUNslxf4Y6eBFbz/zAa6AbmjZJ4q9CufI3nxspZw9bFW0+Fpn270XxdLbollKASy7qv0h950/qWrLTdh3oZNCjXJFceiEX2pp3GyuTsdwCuJqjyhI2N4sX9DoMsIl5d3ReroKlwt+bVdjumtsRlvabhfRoV4VftgNUd0E1KYVlmUsHnBQRpY0WmwUzfc/OH/aVwjuUt1rm8uG3ppvjPDikUjqvbkPSPBJNVDm030qNH/mVXsb8IweSrv99TQJBEY+6HZLaGwLpjBfz5coaPsbbRBQZR1tlV3hr24+omk3eqrVGKPDzr4uHqWK5dB+Cv3cdUJdrGzRrMMfpvCEVugyijyKLSOhJButD8ga2Q++lbcqsKpQrUcfrxkAGRdlvvP0dRysdJINVCK7vPMy6CdknTjxE6gm8oeG3oN7gEwQM+rVd8ykH5y+uIeRHAWtNj29jE49qZqBWXPPT6UmP+OBd/Q==
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39850400004)(396003)(376002)(346002)(136003)(82310400011)(186009)(451199024)(1800799009)(36840700001)(46966006)(2906002)(83380400001)(86362001)(6666004)(36756003)(1076003)(2616005)(478600001)(6266002)(336012)(40480700001)(26005)(8676002)(36860700001)(8936002)(4326008)(47076005)(70586007)(5660300002)(41300700001)(316002)(81166007)(356005)(82740400003)(54906003)(6916009)(70206006)(21314003)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Hwvl/eH6eJM6+x7z/mEyCA4guQI3jkweL+BfBaWw2EjIe+eimQG+ganriOkVNlh/gb5FcRP+x0ucjqBiYN/Rq8jMBuMxDyj5SZgVHS9gqq9gK4OUHyjHMoe2iW5i7maoig5+eWdyXir15gnmCXh7ZkYXS3s9MmXUEjbbTD+57PuVXKkDSRT+ULt5ZxC/GOQyGBcMff+8+hbzMjAhPkpIk5iJXKWc9S+Pq8Mu0ntixdKVjxcjA8SsHIPq0qNRrjeNlYwz5/icMl64zuGTQtBPj15q4OtvE4BF6/HQW+A3Tye3JDSG+JeK+v/gkTDYeA6i+NxYOUSJ1QH6CusqVBWaSDhD9y5fls4GufjiBMnvguvPJu5JAEPHJdmEpC0/t+Nz/TggAuuPAWW5da6+iIliWE5+oEUK9vRf+GKLnmEV+NozHKE86M02QYdzD1saG410hphoewRD44G9dN9iNFo7sC9hN5U7AKEbVk6LUaLAZubmBAjKattiGWpiFq3CS8vL7UFW7inrZ1qJp87NkpuEYSgByslXfdjyKY58CuQUdAhqF5Gb9DHbgTN7B9t5NWKrWcdUhZ7aspVER8jdeu1j3RewdiZd5WgLYYUMDZgO0jXPMWqcO6nj9IrHTuJwfuq8mywOz8EZCRbJL5A0OgtAmTI6oNOZol2n7x4DjRYdEI+qKDUyo+6CYrfRXpO92NyN+iJ/mofA9pmoEQePx6TKoaUtoJoSnmfF1dmqNX2TVVQYpOmw2vVndWeBp6WCJGQ5h7AumsrJfryKttzFi7QZCNGbSB1kvX4QdLtRiz9NKGmYfGKQisJdK7KSiY/EDAD4/R/NiMc/h6ulbUovyvGy6Qc/H/bfGOVGAdP6W5+/LC4=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 17:34:57.0184
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5bbc374-2a7a-4d7c-f3e6-08dbb9ffe876
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM04FT025.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR19MB5472
X-BESS-ID: 1695231300-112254-12344-2098-1
X-BESS-VER: 2019.1_20230913.1749
X-BESS-Apparent-Source-IP: 104.47.51.41
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkbmxiZAVgZQMNHCLDE1zdzc0C
        DJMNE8JTk5ycQ81dI0JTE1yTw52cRQqTYWACKZhYpBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250962 [from 
        cloudscan9-231.us-east-2a.ess.aws.cudaops.com]
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
 fs/fuse/dir.c | 48 +++++++++++++++++++++++-------------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index e2c397e6e4bf..4e285af2f17f 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -806,6 +806,25 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	return finish_no_open(file, res);
 }
 
+static struct dentry *fuse_atomic_open_alloc_dentry(struct dentry *entry,
+						    wait_queue_head_t *wq)
+{
+	struct dentry *new;
+
+	d_drop(entry);
+	new = d_alloc_parallel(entry->d_parent, &entry->d_name,
+			       wq);
+	if (IS_ERR(new))
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
@@ -834,17 +853,9 @@ fuse_atomic_open_revalidate(struct fuse_conn *fc, struct dentry *entry,
 		struct dentry *new = NULL;
 
 		if (!switched && !d_in_lookup(entry)) {
-			d_drop(entry);
-			new = d_alloc_parallel(entry->d_parent, &entry->d_name,
-					       wq);
+			new = fuse_atomic_open_alloc_dentry(entry, wq);
 			if (IS_ERR(new))
 				return new;
-
-			if (unlikely(!d_in_lookup(new))) {
-				dput(new);
-				new = ERR_PTR(-EIO);
-				return new;
-			}
 		}
 
 		fuse_invalidate_entry(entry);
@@ -998,26 +1009,13 @@ static int _fuse_atomic_open(struct inode *dir, struct dentry *entry,
 
 	/* prevent racing/parallel lookup */
 	if (!(flags & O_CREAT) && !d_in_lookup(entry)) {
-		d_drop(entry);
-		switched_entry = d_alloc_parallel(entry->d_parent,
-						   &entry->d_name, &wq);
+		switched_entry = fuse_atomic_open_alloc_dentry(entry, &wq);
 		if (IS_ERR(switched_entry)) {
-			err = PTR_ERR(switched_entry);
-			goto out_free_ff;
-		}
-
-		if (unlikely(!d_in_lookup(switched_entry))) {
-			/* fall back */
-			dput(switched_entry);
-			switched_entry = NULL;
-
 			if (!inode) {
 				goto free_and_fallback;
 			} else {
-				/* XXX can this happen at all and is there a
-				 * better way to handle it?
-				 */
-				err = -EIO;
+				/* XXX Is there a better way to handle it? */
+				err = PTR_ERR(switched_entry);
 				goto out_free_ff;
 			}
 		}
-- 
2.39.2

