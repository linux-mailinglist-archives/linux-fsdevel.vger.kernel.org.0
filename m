Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA0A7A8AAA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 19:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjITRfK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 13:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjITRfJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:35:09 -0400
Received: from outbound-ip7b.ess.barracuda.com (outbound-ip7b.ess.barracuda.com [209.222.82.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF87BB
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 10:35:02 -0700 (PDT)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174]) by mx-outbound17-66.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 20 Sep 2023 17:34:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGkuY5qLUu5DNfvr1wsNjH9mb0vOYgHnr6QuqrBhyqJFQu0PsSe3NYIeKW1jpB8MUf/VOwVe4o631FhVCumVx/jFtA/9UhAqdQlSO43ws+HVYHPqsoXfheXNy+I2O489atwZEPE/pnWNyXl0OWmyTA1z/vsgC6d9qzuT4+4YtO3foS91izp19ZpSQxmZTaDmAmjfpVKLuubUtqyQ4hADGMxNXTQiY+r/2YgtH7OjCa9mqwwcD6lo7swljaN2th4IeeNwe+wJS94HuyRSY7KlWK1Vv9z0nD/UA2g5qpHesRWxmshoG/qNyrqiYdIRnbeFP+EbgTS0HXkWBPDYOoXYRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnAv9eSklNgUbvw+BCiAvWERywVGheoB8VOv6vhtePA=;
 b=PFkaZgxiRz663B6JQOR7gewXzaU0HdJmfxY3iqDpwmCdBJ0C9BxtattdDaZILQ0bz0mfwyJ3K7t36lVryC8CDydxQQzW/FQcJ8QLEqo2wG2sSlTAF8r+wZwk/AQFeGNWH/ueNAKLQetjFWCGHdVgNOS32yJ4r+Fcv9jxqiSFIdqG6dCELQNiUumk95a+nanDF02TLjbdhKO5ooBD1IYXO6cROi2Ywyh/znIGsjJSp9NW12lOde/vP3WlkEaSJl+2guoTps/rkkRhaFej+ucsdpcjrEEy2Vi9PjtPmobCkU2NwUr46qXsp+majs6BRT2qOLUEjxEDXFGQfnrrHtzyDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnAv9eSklNgUbvw+BCiAvWERywVGheoB8VOv6vhtePA=;
 b=g9aYhnh6giucryiB51PEqb5csYvjvNROHGk1TaTt7SAuD3+iOGNjTQbdfI6hvJK1S6qtFR9GvS1VSSNe5VF6srNKc2hbeuSC891WQeQxdaEKfhytwvHAj/iy3sgPF/DcrAdQmUAQAjw+1nRqJR33uf1hJafMQomJgjtW6X4bqsk=
Received: from BN0PR04CA0026.namprd04.prod.outlook.com (2603:10b6:408:ee::31)
 by CY8PR19MB7273.namprd19.prod.outlook.com (2603:10b6:930:99::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18; Wed, 20 Sep
 2023 17:34:55 +0000
Received: from BN8NAM04FT041.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::c2) by BN0PR04CA0026.outlook.office365.com
 (2603:10b6:408:ee::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.29 via Frontend
 Transport; Wed, 20 Sep 2023 17:34:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 BN8NAM04FT041.mail.protection.outlook.com (10.13.161.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.16 via Frontend Transport; Wed, 20 Sep 2023 17:34:55 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 3C2BD20C684B;
        Wed, 20 Sep 2023 11:36:00 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
        Bernd Schubert <bschubert@ddn.com>,
        Horst Birthelmer <hbirthelmer@ddn.com>
Subject: [PATCH v9 6/7] fuse: Return D_REVALIDATE_ATOMIC for cached dentries
Date:   Wed, 20 Sep 2023 19:34:44 +0200
Message-Id: <20230920173445.3943581-7-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920173445.3943581-1-bschubert@ddn.com>
References: <20230920173445.3943581-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM04FT041:EE_|CY8PR19MB7273:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2328f052-7e9a-4139-c539-08dbb9ffe760
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h2cSyGauaCe2hkOo1ebvxpqMCJIfqP7Bo+6UMhlLY636x+s8146UmchHLh31AM6okl7GF7pyPSNpa41io6GpSW8dlhmQ42zfw97UhNmrz/jaPHAz4RAyGO6EWdm3UFcdke++282q0vEkL1o7zZLdxLYorAap27Ae5vEHmwXPEkUthQTMa0e6jO86PpRpuQFYbOPhbu7C8zdzEWu3ZXucL6BSr36beBgXgjfV2gzYsZa15ApxI5lmgUzHdsKMvhTtkWbcnhD7wFqFcho+MjvYrMEPBiqUq+74j0ZS/sTYCsTX5KNhw7ugu5RK67H2LrFfCo5U6pjTTnXKpnBBjhKGh+CNh5jI3eq8W5JVUC+rWBbBPk3oZDO/TiIaE5vvsdKrDh8rdmu7nx5S7FBbCn/Qgj/I0dEGqyr0fFN20p0MVBINwMKJGtWi/5TeKLLI9GdxeWmG2bSwQSk3ELxJ4Tb+5fANb6KT4CodjiBKUe7BFHLCV79FEARDoL9j8QM1xbl6PPBMxs5pEgjgTsSDO4hmA54MwF9+RnWkSoj3DvQb7IPJIzP5roBcj2YuZQq/hmzk421L0mPmRB0iKKcRbzGZJnviXxhROok5089fNa731MnpTb+BvMNW1zLei003aOXZ1pYcXlnfPCWEsHi69qJHHiQE1MGApUg64Q+NPGaeGtLM8LjwzsbtnO39WA6CWjI701m41FWn2wO5z/eghG4E5mHGxsDaQdzfs2fUPpiZ93c=
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(376002)(39850400004)(451199024)(1800799009)(82310400011)(186009)(46966006)(36840700001)(40480700001)(70206006)(41300700001)(70586007)(54906003)(316002)(6916009)(81166007)(82740400003)(478600001)(356005)(36756003)(2906002)(86362001)(5660300002)(4326008)(6666004)(1076003)(336012)(36860700001)(2616005)(6266002)(8936002)(8676002)(83380400001)(47076005)(26005)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: auN3agotPlK4nKXgO7H/0rdChuU05WnqpPGwd5iA9Mf5KIoHnGGyOoKm/sHuDoIOdIihzoq3DHCIP1W6DwgHUGt8YswSsdjuaqc3oHYeCGJLwaSswXARBQ/S6ifB7UsG/CL6MyH0PKw3+jdVlMzd6sbszJgoORHqqA/BVpTHPaGqzjmdpLB3++JCcyn2hu2kvRxrXJ3CH8KL+vrvu2DZ8hqzQLt+qDEC626k25lZq8uWbLVV5mQkr3gEAmqojvRBZ8SJP8e+Sa6qOR3wBNlp5dCJgrFrrzdV95jyd1ekbNRxfRLTkBhD9+OpkeWre7gwgktd9Ud5jPmSuBcRuZPrZ425b2pkiJl185Nyz9Czkp01Tc6MmGPdjRgdXB7jsjaIfrVFR8cPSJSgbXiIVybygWug+p1VTjU7g2Ez39oFdTo930EZUwuvzonZMSMiqdVKNi7GloR8E5xeQoSMN4jv9MLcjFv1CWqLv43ip5Zl6dBXI1QXyDeZmxBEAj91tpFtL0Ihh+ghrov8JuRYMcDHT9IrbmClRmHc6SsjdmIGTiNwvSQHm+42+3eK3dchVE9ZHuT3Z+Zd75rV/Nqbg/3g1HdjvAn+9mcu5K3soXdcG09fDv7BuB3Xpx8zLFCesjg4HvMfyg+ET7RGg1QlWvCMrY5FDXh+5MXRu/hE04gRsa2CH+/xImXH1c8dAeU6sysjpTWQpa5g75VvKsOOMamHW6xeG0cnuCye3KbMfpNrRp+0dcXtvDJTbUNiiqNLtLNIRw6ZFjfxIOxjacfSjXdk1aMiLV1T2tMphwN/Y2MGqz4604h3IkrKf8tEbVQlme+VnRL2DQngOWEvrvxACOsaioUBlpGxeHQBb43782as+o0=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 17:34:55.1485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2328f052-7e9a-4139-c539-08dbb9ffe760
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM04FT041.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR19MB7273
X-BESS-ID: 1695231298-104418-18341-14534-1
X-BESS-VER: 2019.1_20230913.1749
X-BESS-Apparent-Source-IP: 104.47.57.174
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsaWxpZAVgZQ0NTE0MzS3NLQPN
        nUwtTE1CgtOdk40dwy0TTZyNDAwMRcqTYWAMcHNY1BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250962 [from 
        cloudscan13-242.us-east-2a.ess.aws.cudaops.com]
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

Cached dentries do not get revalidate, but open would still result in
open + getattr, instead of one atomic_open call only.

libfuse logs (passthrough_hp):

Unpatched:
----------
unique: 22, opcode: OPEN (14), nodeid: 140698229673544, insize: 48, pid: 3434
   unique: 22, success, outsize: 32
unique: 24, opcode: GETATTR (3), nodeid: 140698229673544, insize: 56, pid: 3434
   unique: 24, success, outsize: 120
unique: 26, opcode: FLUSH (25), nodeid: 140698229673544, insize: 64, pid: 3434
   unique: 26, success, outsize: 16
unique: 28, opcode: RELEASE (18), nodeid: 140698229673544, insize: 64, pid: 0
   unique: 28, success, outsize: 16

Patched:
----------
unique: 20, opcode: OPEN_ATOMIC (52), nodeid: 1, insize: 63, pid: 3397
   unique: 20, success, outsize: 160
unique: 22, opcode: FLUSH (25), nodeid: 140024188243528, insize: 64, pid: 3397
   unique: 22, success, outsize: 16
unique: 24, opcode: RELEASE (18), nodeid: 140024188243528, insize: 64, pid: 0
   unique: 24, success, outsize: 16

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: Horst Birthelmer <hbirthelmer@ddn.com>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/fuse/dir.c | 49 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 12 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index aefd783c7552..e2c397e6e4bf 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -193,6 +193,22 @@ static void fuse_lookup_init(struct fuse_conn *fc, struct fuse_args *args,
 	args->out_args[0].value = outarg;
 }
 
+/*
+ * If open atomic is supported by FUSE then use this opportunity
+ * to avoid this lookup and combine lookup + open into a single call.
+ */
+static int fuse_dentry_do_atomic_revalidate(struct dentry *entry,
+					     unsigned int flags,
+					     struct fuse_conn *fc)
+{
+	int ret = 0;
+
+	if (flags & LOOKUP_OPEN && fc->has_open_atomic)
+		ret = D_REVALIDATE_ATOMIC;
+
+	return ret;
+}
+
 /*
  * Check whether the dentry is still valid
  *
@@ -230,19 +246,10 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 
 		fm = get_fuse_mount(inode);
 
-		/* If open atomic is supported by FUSE then use this opportunity
-		 * to avoid this lookup and combine lookup + open into a single call.
-		 *
-		 * Note: Fuse detects open atomic implementation automatically.
-		 * Therefore first few call would go into open atomic code path
-		 * , detects that open atomic is implemented or not by setting
-		 * fc->no_open_atomic. In case open atomic is not implemented,
-		 * calls fall back to non-atomic open.
-		 */
-		if (fm->fc->has_open_atomic && flags & LOOKUP_OPEN) {
-			ret = D_REVALIDATE_ATOMIC;
+		ret = fuse_dentry_do_atomic_revalidate(entry, flags, fm->fc);
+		if (ret)
 			goto out;
-		}
+
 		forget = fuse_alloc_forget();
 		ret = -ENOMEM;
 		if (!forget)
@@ -285,6 +292,16 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 	} else if (inode) {
 		fi = get_fuse_inode(inode);
 		if (flags & LOOKUP_RCU) {
+			fm = get_fuse_mount(inode);
+			if (fm->fc->has_open_atomic) {
+				/* Atomic open is preferred, as it does entry
+				 * revalidate and attribute refresh, but
+				 * DCACHE_ATOMIC_OPEN cannot be set in RCU mode
+				 */
+				if (flags & LOOKUP_OPEN)
+					return -ECHILD;
+			}
+
 			if (test_bit(FUSE_I_INIT_RDPLUS, &fi->state))
 				return -ECHILD;
 		} else if (test_and_clear_bit(FUSE_I_INIT_RDPLUS, &fi->state)) {
@@ -292,6 +309,14 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 			fuse_advise_use_readdirplus(d_inode(parent));
 			dput(parent);
 		}
+
+		/* revalidate is skipped, but we still want atomic open to
+		 * update attributes during open
+		 */
+		fm = get_fuse_mount(inode);
+		ret = fuse_dentry_do_atomic_revalidate(entry, flags, fm->fc);
+		if (ret)
+			goto out;
 	}
 	ret = D_REVALIDATE_VALID;
 out:
-- 
2.39.2

