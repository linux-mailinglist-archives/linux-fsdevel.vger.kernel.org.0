Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD01F7A8AAD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 19:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjITRfW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 13:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjITRfU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:35:20 -0400
Received: from outbound-ip7a.ess.barracuda.com (outbound-ip7a.ess.barracuda.com [209.222.82.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92010CC
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 10:35:09 -0700 (PDT)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102]) by mx-outbound14-166.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 20 Sep 2023 17:34:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0WHJVkrsceBYW1YIZwIN4xuZh8RR3sGrdKCoLAQSb6nI7DNk7/bfhu8FcLdwDQVlTqZXmU21Mkk7+ThIpUDbDwWmYL1QGVIJ5CosXGRPxjeVF6kv+qUz0yWzv7zIaUNxz7uAz3mrcSXQxYmnnf1hEpQR7Kb2BpAM1OCqC3iz7vamS5nJpflJL3bvPlm5SXt6zxBjMf+jlyX2LB7xW8Wba33EeHp8DcNXtmIGF3LKsRiJleNB1WF6YoVm38VPIJj5I2+g8PEDSD5ThS4K8uFE1S5nTbXbAa9ZbkcWw4RHsGDwXQbODxnL6/A6A1aAPc8JRVlL4CZ8rXjoYElyPE19Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HzE+7kHzN2f5CR/TI9nlO1F7CK36ngpY6AlE5EIhYZI=;
 b=NpwGutmlvtO1aqrZOm6usI0URPZcZC472pjnL0jYkEyIQyvgDLMKSZotWzTleQFu1mRXlLOSX6KO0vvhcokUnTYsB72YX2iNb9Vz5v2m1MTTfQv+cNlR4AFurlpgDOzpZDXHkYsINnvPWWJY6D1F3cOmYIrYvq+jG0v+wKjaE31MZVTW0QwiZBux5NdrFrEY0DYk6jv3uNd1MYxS+ojIQ+2UJoXt4ZktvZmH89Kjyh/bMtrhhFzOxbVFvFYTpGrmlFoESOl9cWUTr7+zNgHyzDdMm6TjS9QCwW+wV0oV2rCsJXdNursR5m9W8g+34FzBQSC5j8jf6Wbh0KZJmsX5OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzE+7kHzN2f5CR/TI9nlO1F7CK36ngpY6AlE5EIhYZI=;
 b=WXu/wukKGmI35d5VeOg9bJjlLg0iEVdnv5tXT4YhsXRPqZnaEvBsxwPAxQuFvtSe/P08pbDKEtVibt83lyhp7yvWIR1/11bXU6i/CetoM4Mhhzwlzpy1uBS3e2Cpb09tp0tvyrGbp301joTkA8JKAf+e6XCtiMRtLVKOVeIecSI=
Received: from BY3PR03CA0005.namprd03.prod.outlook.com (2603:10b6:a03:39a::10)
 by DM6PR19MB4025.namprd19.prod.outlook.com (2603:10b6:5:24b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 17:34:52 +0000
Received: from MW2NAM04FT044.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:a03:39a:cafe::82) by BY3PR03CA0005.outlook.office365.com
 (2603:10b6:a03:39a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30 via Frontend
 Transport; Wed, 20 Sep 2023 17:34:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 MW2NAM04FT044.mail.protection.outlook.com (10.13.31.2) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.20 via Frontend Transport; Wed, 20 Sep 2023 17:34:52 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 4BD8620C684C;
        Wed, 20 Sep 2023 11:35:57 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
        Bernd Schubert <bschubert@ddn.com>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v9 3/7] [RFC] Allow atomic_open() on positive dentry
Date:   Wed, 20 Sep 2023 19:34:41 +0200
Message-Id: <20230920173445.3943581-4-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920173445.3943581-1-bschubert@ddn.com>
References: <20230920173445.3943581-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM04FT044:EE_|DM6PR19MB4025:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9617c545-c291-4748-32b6-08dbb9ffe598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fVI0O06L4EZ2OirX6plPRHR56hJ6/V2FWfG+Qycv30KsesYNIniwUvTO0fAONJ2rHZ9R4ynqinaOQ0cMfPA768HXK3ppsarulaT2Ko9mEszTR9G84RleWeAbthiF34XCnAugaFOMCEXqUpeS73mwpd/0823Ez2ZnOa79ZjN7o6sdqdeeGT8v+183b9lFfuIQekcCKS/L2WckCAy5rydT9v7PwcTb3JS11eeilxcbxw31JtuKRvVlxlovng5tDW0cKMmoOcIQnayPM1Y8RvqAdTpxY9CcF6pW96kd3GqJVIzXzWJlUGWa9OrJ84/Vdi1IcHXSZR2gmM+9YUAIUFV9ChOLdKVjeYbA9FE66vrVnDV/I9kM6LufvjfC46pzRFzZlKGb1TAT2mjAMHGbFzIV0Ru4BmFtZ7BTnJjqvATcwKI1GZPFf6PvGps1sbPmP76ytjPivWnDKHNOWx+HaliYdmpPCZqHPx3EmVKybcCA81t0eyt34HRse2hupcc1VkTFKgx2PIqOR736AHNlxM7kJzPjT2aT8DwnU0XFgBjhWYlWBCcD3h/6tu+P6joal/7dJp6auX9yjK2lTYIxcsK00/omolLeVmH4D8pFWRyWVzc+gr4RZzOfxU9UhPD91bB5wn081mz7Jax+ZmOPHdP9rlE3GDtakxb9sMuwYoPedSW5kbHaim8q9yDo7nWdWWkdfSHen0VLl8ExTMPen+lcYfKVqeQQQpU7N0XybFuNiw/0qz030gJCcDarezMQkY6O
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(39850400004)(346002)(186009)(1800799009)(451199024)(82310400011)(46966006)(36840700001)(6666004)(478600001)(36756003)(356005)(81166007)(40480700001)(82740400003)(36860700001)(86362001)(26005)(2616005)(47076005)(336012)(6266002)(5660300002)(2906002)(6916009)(316002)(41300700001)(8936002)(4326008)(1076003)(70206006)(83380400001)(8676002)(54906003)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?JFnzcVAoEsB14qzkmWPZiBVhIpACvWoJ83cCnM6eAewAgVeN2IzJaSyM2m3/?=
 =?us-ascii?Q?3bflUTU7q7utHr1IC8zPuwDE42XRSL12AHAD7GG5+0hZCsZNQnt40AbXLUyK?=
 =?us-ascii?Q?7LArXVmLhFI1OkOSEmVCIIbOPcLI273b2p79XtKNWK1wS6TobDadKetUQ1Eb?=
 =?us-ascii?Q?dA5O/2xlqmn1DY/6JK/X90TOWFA8VvVjWJi6Ouie1LJVg9/PnHO+03jQxgxv?=
 =?us-ascii?Q?sExGtA3qFgDosIKLuK5vrWTbm8yZt/t8W43TLqWo5NQj9jHm/uve/s8h917A?=
 =?us-ascii?Q?5WuEwSqUBgQi5T0P+jukKqXnrDGi2RByVdd0a6lScflX55bTHSL+h8C/xCh7?=
 =?us-ascii?Q?9HHgWaCXeo3kzaZhBpViWTKcrCsxeBXqDg6qshbegU0GPkyp0FNCnw1hu4y+?=
 =?us-ascii?Q?XuORzOM8j3dD6kV+Wka/tl0GruZkTUdkyHqKxP95jc1CoLL++QvLdPw9s0p5?=
 =?us-ascii?Q?5pA/anhmwVzWOEGZdTRM9SZb296jRK9fBvVWr1k/cgUEk3eKqGwdp65jndIh?=
 =?us-ascii?Q?rVqs3oXr4d/gJCzvv/gD2XP3k6xK7eKOf3Oi6tav0UIoLmN93npLDpFKQ7D9?=
 =?us-ascii?Q?3oD37+ix3edWLwoZNnRlxqGeaqCBqB7xk4x2Ki59mdnlCtv1P21V/fn6Hfyf?=
 =?us-ascii?Q?ZAX+qZc8Gx1VD8Gx3Lv7YBfvL1Om6APJsFjVWFw7Jo642HF7mrnBtO3oS9O7?=
 =?us-ascii?Q?XjdED4tdzjFXRVRi4OBLC4rpmrAGxPnrDyPRv0zYpy6SqfBhjXtPqzSK9Cte?=
 =?us-ascii?Q?jLMGN7k+Z2EQyrAWtbXe9Nsdcyp15qyFalZ79X0YjHtEdF4XUX7tAcQjaG/R?=
 =?us-ascii?Q?yYCsZN5Ho2YiG33JWrBcGNCqPqy7Cw7u3dZkzB4LL+EYzcWTUEG2HgCxhWm7?=
 =?us-ascii?Q?eEpRMpQ0vTpg66SSAhCQRJmEqjS7qrbVD9LzzFyJPvGQOv9orwMRRp1yWYqa?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 17:34:52.2031
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9617c545-c291-4748-32b6-08dbb9ffe598
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM04FT044.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB4025
X-BESS-ID: 1695231296-103750-3125-5195-1
X-BESS-VER: 2019.1_20230913.1749
X-BESS-Apparent-Source-IP: 104.47.70.102
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVibGpiZAVgZQ0Mgy0SQ1zdIixc
        QiNcnC0MA0NdkwJdnC0sjQwiLVyMxMqTYWALyzOdZBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250962 [from 
        cloudscan15-125.us-east-2a.ess.aws.cudaops.com]
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

From: Miklos Szeredi <miklos@szeredi.hu>

atomic_open() will do an open-by-name or create-and-open
depending on the flags.

If file was created, then the old positive dentry is obviously
stale, so it will be invalidated and a new one will be allocated.

If not created, then check whether it's the same inode (same as in
->d_revalidate()) and if not, invalidate & allocate new dentry.

Co-developed-by: Bernd Schubert <bschubert@ddn.com>
Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/namei.c            | 25 ++++++++++++++++++++-----
 include/linux/namei.h |  7 +++++++
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index e56ff39a79bc..f01b278ac0ef 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -858,7 +858,7 @@ static inline int d_revalidate(struct dentry *dentry, unsigned int flags)
 	if (unlikely(dentry->d_flags & DCACHE_OP_REVALIDATE))
 		return dentry->d_op->d_revalidate(dentry, flags);
 	else
-		return 1;
+		return D_REVALIDATE_VALID;
 }
 
 /**
@@ -1611,10 +1611,11 @@ struct dentry *lookup_one_qstr_excl(const struct qstr *name,
 }
 EXPORT_SYMBOL(lookup_one_qstr_excl);
 
-static struct dentry *lookup_fast(struct nameidata *nd)
+static struct dentry *lookup_fast(struct nameidata *nd, bool *atomic_revalidate)
 {
 	struct dentry *dentry, *parent = nd->path.dentry;
 	int status = 1;
+	*atomic_revalidate = false;
 
 	/*
 	 * Rename seqlock is not required here because in the off chance
@@ -1656,6 +1657,10 @@ static struct dentry *lookup_fast(struct nameidata *nd)
 		dput(dentry);
 		return ERR_PTR(status);
 	}
+
+	if (status == D_REVALIDATE_ATOMIC)
+		*atomic_revalidate = true;
+
 	return dentry;
 }
 
@@ -1981,6 +1986,7 @@ static const char *handle_dots(struct nameidata *nd, int type)
 static const char *walk_component(struct nameidata *nd, int flags)
 {
 	struct dentry *dentry;
+	bool atomic_revalidate;
 	/*
 	 * "." and ".." are special - ".." especially so because it has
 	 * to be able to know about the current root directory and
@@ -1991,7 +1997,7 @@ static const char *walk_component(struct nameidata *nd, int flags)
 			put_link(nd);
 		return handle_dots(nd, nd->last_type);
 	}
-	dentry = lookup_fast(nd);
+	dentry = lookup_fast(nd, &atomic_revalidate);
 	if (IS_ERR(dentry))
 		return ERR_CAST(dentry);
 	if (unlikely(!dentry)) {
@@ -1999,6 +2005,9 @@ static const char *walk_component(struct nameidata *nd, int flags)
 		if (IS_ERR(dentry))
 			return ERR_CAST(dentry);
 	}
+
+	WARN_ON(atomic_revalidate);
+
 	if (!(flags & WALK_MORE) && nd->depth)
 		put_link(nd);
 	return step_into(nd, flags, dentry);
@@ -3430,7 +3439,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		dput(dentry);
 		dentry = NULL;
 	}
-	if (dentry->d_inode) {
+	if (dentry->d_inode && error != D_REVALIDATE_ATOMIC) {
 		/* Cached positive dentry: will open in f_op->open */
 		return dentry;
 	}
@@ -3523,12 +3532,18 @@ static const char *open_last_lookups(struct nameidata *nd,
 	}
 
 	if (!(open_flag & O_CREAT)) {
+		bool atomic_revalidate;
+
 		if (nd->last.name[nd->last.len])
 			nd->flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
 		/* we _can_ be in RCU mode here */
-		dentry = lookup_fast(nd);
+		dentry = lookup_fast(nd, &atomic_revalidate);
 		if (IS_ERR(dentry))
 			return ERR_CAST(dentry);
+		if (dentry && unlikely(atomic_revalidate)) {
+			dput(dentry);
+			dentry = NULL;
+		}
 		if (likely(dentry))
 			goto finish_lookup;
 
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 1463cbda4888..a70e87d2b2a9 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -47,6 +47,13 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
 /* LOOKUP_* flags which do scope-related checks based on the dirfd. */
 #define LOOKUP_IS_SCOPED (LOOKUP_BENEATH | LOOKUP_IN_ROOT)
 
+/* ->d_revalidate return codes */
+enum {
+	D_REVALIDATE_INVALID = 0, /* invalid dentry */
+	D_REVALIDATE_VALID   = 1, /* valid dentry */
+	D_REVALIDATE_ATOMIC =  2, /* atomic_open will revalidate */
+};
+
 extern int path_pts(struct path *path);
 
 extern int user_path_at_empty(int, const char __user *, unsigned, struct path *, int *empty);
-- 
2.39.2

