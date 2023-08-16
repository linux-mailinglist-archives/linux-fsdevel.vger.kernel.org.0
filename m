Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323D577E3B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 16:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343658AbjHPOe3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 10:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343681AbjHPOeM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:34:12 -0400
Received: from outbound-ip7a.ess.barracuda.com (outbound-ip7a.ess.barracuda.com [209.222.82.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520402712
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 07:33:54 -0700 (PDT)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175]) by mx-outbound14-182.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 16 Aug 2023 14:33:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zrcdr2l8LyBS+t5PpXsJcEyG5cjfTGC8PZ3GW7mYR2QMsIGUsrU6fI0kj4jO6dcnFRstigADElcknDJUMA7rF7O/Z76X5N32Afk/BQ8dTxW5m5Aht0WA8d9khTgNTCTQRJcpu/vcTWM+fZxPJr+JYhSLtneZQrYKFhV0fQz6glp5ZcOFVdC1wKAZdze8JDCNbMISvauvPG7zUrslfjM1+qYcuvmQGTB21enIZLQ2tG/xmf/gFl3gS0z5+7z2k609yWZFoCaDvn+LC7FefvCjCfJgm61LwevY3BdAg3rPRisfnFm8J8CG2s+KKIK/MjQXWf0/Ihm5n+JqI6CCZqUILA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xs9ob3NEsMhQYyWRri+W4H0xC1LssKGJIOnEZa2Ans=;
 b=ZWZwp7Z+cGZE/4XY04z6fAo4pmgURpTNMGrSlgn92B8JGFmGoeEeEPyopV6587Bvs0wRbkdU6ENaNBnccn/ek0z3jVLQQ1Lm4ACEg4ayuS7z6bVCjDlYmhaXqR8zQJnJ0qA40nuQLMXQnFb3BxaK2K/wygrBx5in5qGXK1xa7CgQY370w6LFX/SU3vzRFR3Kbw+He0BdToonsaSlwrgNiQZ3xAys3ZWm8vbKAhGYh3lFKAtuouTwHiPAyZ4F7Q/xLTrEqPw58yUZdYNYUXd2py+jpBDAJksPBZnyVPoopVABEGbreY7sk6K5oK5ETEVVgvJoHzC/xpPCly8Mo0aWjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xs9ob3NEsMhQYyWRri+W4H0xC1LssKGJIOnEZa2Ans=;
 b=ztxeI2HvSgy13Co/tbOdH0OOMgUN47uVMsdqlyxLMEZ+KvC/z+DetM6QiQcATxDD3QDmrBdXWGnXaY7A1XF5gybR1huyIfX2CUDHQ4ZYkkeEw/Mih94fq2q2YIWHchnM1dLGHmRpxcP1gFrSbSFXIouZ5lgPTex7JG+kQsu4BNI=
Received: from BYAPR21CA0019.namprd21.prod.outlook.com (2603:10b6:a03:114::29)
 by CY5PR19MB6220.namprd19.prod.outlook.com (2603:10b6:930:27::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 14:33:29 +0000
Received: from MW2NAM04FT025.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:a03:114:cafe::be) by BYAPR21CA0019.outlook.office365.com
 (2603:10b6:a03:114::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.5 via Frontend
 Transport; Wed, 16 Aug 2023 14:33:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 MW2NAM04FT025.mail.protection.outlook.com (10.13.31.128) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.15 via Frontend Transport; Wed, 16 Aug 2023 14:33:28 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id AB32120C684B;
        Wed, 16 Aug 2023 08:34:34 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, fuse-devel@lists.sourceforge.net,
        Miklos Szeredi <miklos@szeredi.hu>,
        Bernd Schubert <bschubert@ddn.com>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dharmendra Singh <dsingh@ddn.com>
Subject: [PATCH 3/6] [RFC] Allow atomic_open() on positive dentry
Date:   Wed, 16 Aug 2023 16:33:10 +0200
Message-Id: <20230816143313.2591328-4-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816143313.2591328-1-bschubert@ddn.com>
References: <20230816143313.2591328-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM04FT025:EE_|CY5PR19MB6220:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c7107119-3306-486c-817e-08db9e65c21a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WyQMjfzh067XKbhzFiTugIkAQVZ8F1iqjx5+wo8B3ecqO2qjcuBmGjJTrycrfVry4oEPoFoTAhPAOk2YC/8l+zrIiSc2DD52OoBsEBddX9nlNwMuDP0iaC0zkfW+CzBdSZ18ojrsPJzo1Az4HM42sKKv8XA1Y7dUn47P15wGHhAnyk4m7AgZvbOUCYOUfBab4jf4QdpEBackoxZlQ3th7Smfwy0Yy1Hk6BIru0nl2b33rkdNpURoySKc3ZHqgY2bhUvX1M/tCfv3pXSWdHsj6ocGYwWNN4xlf7rQsQwGETFpYi6R0BoWar4pxgfsSOQrlfjf2wjBmDDZJ4JjYbG3LAgc3BLPbv+5y0EM2WqiESvB6C1X252x/Pleb8VbFu2qbdr0l0iZH7ZnkwW1gs1lTGcfZMtE4+SB2WF6we6rPSN2XjWnedIm6f3iYltFuk2WyePKImIsySOBlkxgIqjkmQQF00ekOfrb2uribsVt1E0EitfBZVb1lRNL5wXhobP2kgX7aQZWanscwozBo3Psr2dWpcWrAQTKlkwCQ02HtosJHpaaJuVvLdtSIk+edcUmS6ZiHTI01Ltt+qrdLnex9GjxZz+D6hwUtp6hQ24a4wTung1OgfW3pXQKyoHZKVhPJc/hrHE2MfH1ZCrGBKp+7CB84zCxk9ypFPE3AGk/gAF0PkuBjfMQBX1rE/nXKfkmpIicpruZQFqcil52Y4NQHuq2ns42uaSdGB1TRGMbUyzP7W8+e4TMV6cSSc4pA9lB
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39850400004)(1800799009)(451199024)(186009)(82310400011)(46966006)(36840700001)(316002)(54906003)(356005)(82740400003)(6916009)(81166007)(70586007)(70206006)(36860700001)(41300700001)(5660300002)(47076005)(8676002)(4326008)(8936002)(2906002)(83380400001)(26005)(40480700001)(478600001)(336012)(6266002)(86362001)(36756003)(6666004)(1076003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?k+ZwH8WwMpqiBkJ3T873PsFrINdOk1dccBGhYcW9GsMMp0s3i2tgeGTIHxhi?=
 =?us-ascii?Q?cfWlnxUAs7QRqn2ow78TLnt+gdsOtHzAbLAJTt+8oNWywTsKKDUVzeFoUKXb?=
 =?us-ascii?Q?rcbA/Sxp7IyyYDxmTGxqz3fmMKz9yp2VYONzuHY1/03aNJyUkni6n7Yz4UAw?=
 =?us-ascii?Q?baJFcJbiKZQjDOrHluo7CqQz46oWang33saFQ8Dbi4QfUw3P202AlRDKUkBO?=
 =?us-ascii?Q?HU2tyQPUlMyBwf/7ZZf7JQreyEEeQHpm56dpnWgEqcv2B3Ofqo3B00YWHXu3?=
 =?us-ascii?Q?yN/ypVOekEa1jiwM0krBv5QB0FpzCsuOUx2wgMwevjHSaGl+lLGH8ODaQGMz?=
 =?us-ascii?Q?r/p+qoCg4vGCddzm5/wZd02BvorE+vhnULiYBF6mBAkcAVIvM6FNzoMSuq4k?=
 =?us-ascii?Q?nhYIrbhCkYHLsybi6uFuSolvfGX0tlfG5tq9Iayq8iSBC2xO66P3A56sC1UZ?=
 =?us-ascii?Q?SWFG7dLqEPdnoWy8R5Vuj3zuFG6ejtWk3IpIk4Ww9VZGi/wF+GHhbvgiuQfN?=
 =?us-ascii?Q?WSZMyBBnyP3cz5yodgxoLQCbioIOLtL09ulK+a2v5pNMRKHWRJ1fGk9uU4IT?=
 =?us-ascii?Q?cOTyZeEILXfH8iNAZDAHf7pKGekVEqYZ4E0AXgMyVJZ8ARXMBCnCwhWwRRsD?=
 =?us-ascii?Q?5SwuunHa8Rb3YbDvwnKsh/80Ryn5uwrEZGIwYzl8Fp2pFhPQww0rdy4vLg1q?=
 =?us-ascii?Q?ODWypUHnKetjMZTx0I1cgpVHWzLfzn+JT7OvA9ez9SsSQTAFhi1ljUeRu/3E?=
 =?us-ascii?Q?E59348YmM9hJXbc7VHVlOXMM7XOMRZZKUuqY5NtnpTJo607PFpf0Ha9f6a6N?=
 =?us-ascii?Q?ED/QvBhe0r1YdGS0vSxMoUXP/LAoSPG/ALidEoXpU2My9QDiDOKaiP3bzu3/?=
 =?us-ascii?Q?T0o+xutxjJFIXdR0Auc/5IhJUeCAyh0jqxg+prvVBjg0DaH3ELSvwoOMPvyo?=
 =?us-ascii?Q?btWFY1fydz9RkCITIu/WrCmc9NhAVpjFmnJKSTEeH6cGnAmaNlWn0uMmrlPg?=
 =?us-ascii?Q?gM6D?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 14:33:28.7522
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7107119-3306-486c-817e-08db9e65c21a
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM04FT025.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR19MB6220
X-BESS-ID: 1692196413-103766-26829-915-1
X-BESS-VER: 2019.1_20230807.1901
X-BESS-Apparent-Source-IP: 104.47.73.175
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqYGphZAVgZQMNHA0NLS1NQsLc
        XUNMUiOdXQIinZMNkg2SA12cg01ThFqTYWANhWW1FBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250184 [from 
        cloudscan11-117.us-east-2a.ess.aws.cudaops.com]
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

From: Miklos Szeredi <miklos@szeredi.hu>

atomic_open() will do an open-by-name or create-and-open
depending on the flags.

If file was created, then the old positive dentry is obviously
stale, so it will be invalidated and a new one will be allocated.

If not created, then check whether it's the same inode (same as in
->d_revalidate()) and if not, invalidate & allocate new dentry.

Changes (v7 global series) from Miklos initial patch (by Bernd):
- LOOKUP_ATOMIC_REVALIDATE was added and is set for revalidate
  calls into the file system when revalidate by atomic open is
  supported - this is to avoid that ->d_revalidate() would skip
  revalidate and set DCACHE_ATOMIC_OPEN, although vfs
  does not supported it in the given code path (for example
  when LOOKUP_RCU is set)).
- Support atomic-open-revalidate in lookup_fast() - allow atomic
  open for positive dentries without O_CREAT being set.

Changes (v8 global series)
- Introduce enum for d_revalidate return values
- LOOKUP_ATOMIC_REVALIDATE is removed again
- DCACHE_ATOMIC_OPEN flag is replaced by D_REVALIDATE_ATOMIC
  return value

Co-developed-by: Bernd Schubert <bschubert@ddn.com>
Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/namei.c            | 25 +++++++++++++++++++------
 include/linux/namei.h |  6 ++++++
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index e4fe0879ae55..8381ec7645f5 100644
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
+static struct dentry *lookup_fast(struct nameidata *nd, int *atomic_revalidate)
 {
 	struct dentry *dentry, *parent = nd->path.dentry;
 	int status = 1;
+	*atomic_revalidate = 0;
 
 	/*
 	 * Rename seqlock is not required here because in the off chance
@@ -1656,6 +1657,10 @@ static struct dentry *lookup_fast(struct nameidata *nd)
 		dput(dentry);
 		return ERR_PTR(status);
 	}
+
+	if (status == D_REVALIDATE_ATOMIC)
+		*atomic_revalidate = 1;
+
 	return dentry;
 }
 
@@ -1981,6 +1986,7 @@ static const char *handle_dots(struct nameidata *nd, int type)
 static const char *walk_component(struct nameidata *nd, int flags)
 {
 	struct dentry *dentry;
+	int atomic_revalidate;
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
@@ -3523,15 +3532,19 @@ static const char *open_last_lookups(struct nameidata *nd,
 	}
 
 	if (!(open_flag & O_CREAT)) {
+		int atomic_revalidate;
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
-
 		BUG_ON(nd->flags & LOOKUP_RCU);
 	} else {
 		/* create side of things */
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 1463cbda4888..675fd6c88201 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -47,6 +47,12 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
 /* LOOKUP_* flags which do scope-related checks based on the dirfd. */
 #define LOOKUP_IS_SCOPED (LOOKUP_BENEATH | LOOKUP_IN_ROOT)
 
+enum {
+	D_REVALIDATE_INVALID = 0,
+	D_REVALIDATE_VALID   = 1,
+	D_REVALIDATE_ATOMIC =  2, /* Not allowed with LOOKUP_RCU */
+};
+
 extern int path_pts(struct path *path);
 
 extern int user_path_at_empty(int, const char __user *, unsigned, struct path *, int *empty);
-- 
2.37.2

