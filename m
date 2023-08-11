Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB92779726
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 20:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbjHKSi7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 14:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjHKSi5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 14:38:57 -0400
Received: from outbound-ip7a.ess.barracuda.com (outbound-ip7a.ess.barracuda.com [209.222.82.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69FF30E6
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 11:38:53 -0700 (PDT)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101]) by mx-outbound12-57.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 11 Aug 2023 18:38:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUEvV0MMTSGWyFcv6yCYWgB63qeZEQinGC3d413EHF0wD+RwpR+DxKCBxc9Et7HwLH2feoLmWqz5N4105EE86/FRN3oEp/ofN/bLKdmAYrmfEs0LvGRwN7an4B+QymsMDG09O94+b2LHRUff9tToUQgAsMCMCwi+2yXkQa/XZ9txDiUjPNR8uwi7bJcxQnr3+GYu79MiPUbr6MJ3CFhKL28GZAfVhVPtQe3vA/pgFeTUrDhHNlAMbdNu5maUPEXkrZ+ZFzyrBotvxe9KZwXWOEc3hoPc7FRSWNph1VchI6TjkJ1Rw1WKLuiakUvLRmCeZEJJ72WdIisJnlvXIkd32A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ahHQLBCIo4xLtEMkDJWK0ZnYsbNe0wNTUzEIwRRe3U=;
 b=T5c2KjJAcVUTHfDShYgNS/LeNEnFnubHmo+rYsV7TYpW2QM/Uc5DauOTL5mA8bWiO2OyUhpcsiQHjv9osNyXXuRX76gfVyoTaR54+cBOPpat2WqQirletyz233liLYrQG9UF4tBd2rAZobDqVHl1ew73QUkVD09NA22M8PxP2PMr+/Q7A8+fbXKBmhj+nMjn7/YzIYaKSKccv4b3X4XQsh9c7OKhPcrli0/k5cqVktVcHcwEr6w++b/3+sC9n1OiO2kG7vYDhfP18cMmKsZnEbO36oaGOMgmXFh6wyspr63VzjlqTMD33jyE6+Nl4Xmr1Sim+gwEVBOaYTBC8Vvz9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ahHQLBCIo4xLtEMkDJWK0ZnYsbNe0wNTUzEIwRRe3U=;
 b=uq/IIVJlovk/f6qqMuO+SvRVsyd9uwynzIblqP5Qy82xF2SWY6sXvQZI0RSSCCRJAPeayjCXrZBuIhNPIEWci+PDqImcVJ9dyxS2FT2UYtCa+BbNIgMxPcaESpUm2et19ZYqJTDyQtpZky8xhP3r5Xsafuoq7Vqng6yRD33xAtc=
Received: from BN9PR03CA0285.namprd03.prod.outlook.com (2603:10b6:408:f5::20)
 by LV2PR19MB5885.namprd19.prod.outlook.com (2603:10b6:408:174::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 18:38:32 +0000
Received: from BN8NAM04FT003.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::a0) by BN9PR03CA0285.outlook.office365.com
 (2603:10b6:408:f5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 18:38:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 BN8NAM04FT003.mail.protection.outlook.com (10.13.161.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.20 via Frontend Transport; Fri, 11 Aug 2023 18:38:33 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 036D120C684B;
        Fri, 11 Aug 2023 12:39:37 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, fuse-devel@lists.sourceforge.net,
        Bernd Schubert <bschubert@ddn.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Dharmendra Singh <dsingh@ddn.com>,
        Horst Birthelmer <hbirthelmer@ddn.com>
Subject: [PATCH 5/6] fuse: revalidate Set DCACHE_ATOMIC_OPEN for cached dentries
Date:   Fri, 11 Aug 2023 20:37:51 +0200
Message-Id: <20230811183752.2506418-6-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811183752.2506418-1-bschubert@ddn.com>
References: <20230811183752.2506418-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM04FT003:EE_|LV2PR19MB5885:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f1a64fe3-1e84-425a-8e3c-08db9a9a2a91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M4tGFFXltK7oWflCwVXPDh8zMvOvVp1DlFvfGmh7J0Jerg40XHhn8+U1SXBwiYSm1jK6USE7YhPDtUYGS5ZurPW3hu6WZeRaWyuUgR6Phe7sVFMThYOSA/YnbsVcO2vyWOC2dpifcteIooe+OCLy8LqDd27mzHPeyUU+BORfGfKfsqG67yilkM49hkvpYi1XKAuLzUSb+evzWIGuuECZAx7NDDAXtIX20oncFQVgB49eAXEQgrzM6QV/dGu2cp+5CJW8cOdSD/87Y8k+6RKkCxrX03VeQ75YP/ShedWNp6k6wFw/smvgS7p9SsE6Iy1vv9r0hl+Wy/2jULP5GfTlg+aiNVmVnyKxQSNGa5BQ5FHMThUtWV+ad1bHeQDr0pgGBagjhbxUP3y8CbSwPMPE9jJL9TZ9QEK4tnxYA1ss7Q3yGw5pnVmK0bdxIpzrlNz2nXE/0AkU8btVlrqgSpQ/mJwQdxlxqtuuXwaTGd4JNqcy+kLb65nCB759snxjDBCOloGSXBdpaE5Uw22smaOFOTGyLyalDeZbqwA/4tEwfnymMQkgsDx7f9JVKOyT7+fjBAyrozMSIkZ1X13cCSiOIwb6J4D/Y4miCLkzskxcUi8cI6NYc4GYYkUUebjHFdW4w1EHyawk25uWFyMEEzJm47KJW8bdupn5OEz+vMbk+XIfJWkp625KUrL0szo+08ZEl1qKg7vd4DB7svk4v9kRgGDV+Tn4UCFBtBkUtF1cXUQ=
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39850400004)(82310400008)(186006)(1800799006)(451199021)(36840700001)(46966006)(2906002)(356005)(54906003)(83380400001)(1076003)(26005)(86362001)(6266002)(336012)(8936002)(2616005)(82740400003)(47076005)(81166007)(36860700001)(40480700001)(478600001)(6666004)(36756003)(70206006)(316002)(4326008)(6916009)(5660300002)(70586007)(8676002)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /BLItIcmWb6sAPbcvjXzcg1GVo7A9hmsE1pDelNUgM5zJrhcqenuVrlf+zhsYLI/FKTcMPInB7wQpU3zPD578UlWSM7gs7zmCyjobxkr5aLPyb1bty0f+0n+Cb9bTZCmyQJ7H7NxFJVdYPeHm1E5sb5oJbuAj0LkAhMJ3NQ3tBMACs9r3rgoID0k9WjSZgnU2KY07Lo31CtLWsM+NSte/I0r7bUcyHhLq2sCtrvfJwDVbrPOqUAtSux/WKlYtECOHOOuX4um24fShPinO+VAHJshAeEsYvKVMb0jWsAe1hkVgLtbbQTXHSyZmYZnFgpa+XM/c3j+dOjz8+TiKnEHwdnwiip5yn5xfYY1v1dcJCRfsI8+394xfc3LejB1IPH9baOaEhSDmqJ3uXaeSqgvVr81PvlFC35jbR0SqPMcQQ2U4jTkSI+V9O08ofk4nPNFct0lXpTgJrH00VdZ0VyriGHdiLBh0lsn8Qo8JxwcbFI8aA4Nq5v4ukEBB7U2gHUYZAKw8zp7rRN2QSxUMw96nR3dWO9JLo5T6NlIHuRBDGFOFUxRa0aISU7FhbhNEQvIXwdxXZ2KZdD9ZpXfn+wcr4w0ImpM9Wvgqr8Xz0IFEkJGtIlFDqmlrVybh3szRBWkElp8DXjetDvRZjGbFEOP5Y7YVnjRU1Vece9m3owzNhl25oT3pPHNT5SC0hapkZctnrx1AP7/AFmDq8jATxRcvClYmFGslAPT37V1ZQTZaHv77/RgmZIDbYNSPpG2A5/Sq0TzEaUAEM9/4WpCjcRmObuZwu16jjoXDtYQ4pHPmdpMqrVLEC3PYPpsLfgIluusetK7eHEzYiNYKeEwYveicnVGeA7frP5WGFn5nJ/0tzIk2ASV0StpZyi5wqcBXxZ7RdfDjVioMxeJWEFlM0aL5NnHhX6II3XkxUm/l5PM/J8=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 18:38:33.1630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a64fe3-1e84-425a-8e3c-08db9a9a2a91
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM04FT003.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR19MB5885
X-BESS-ID: 1691779119-103129-29064-6501-1
X-BESS-VER: 2019.1_20230807.1901
X-BESS-Apparent-Source-IP: 104.47.70.101
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViZmRgZAVgZQ0NI4zSg1xSzJJN
        XAyNLM0NQgKcXU0DIx2dLEyMwgycRMqTYWAORVPT9BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250079 [from 
        cloudscan10-134.us-east-2a.ess.aws.cudaops.com]
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

Cached dentries do not get revalidate, but open will result in
open + getattr, but we want one call only.

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
 fs/fuse/dir.c | 58 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index d872453a6cd0..067e1a2fb23a 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -193,6 +193,25 @@ static void fuse_lookup_init(struct fuse_conn *fc, struct fuse_args *args,
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
+	if (flags & LOOKUP_OPEN && flags & LOOKUP_ATOMIC_REVALIDATE &&
+	    fc->has_open_atomic) {
+		spin_lock(&entry->d_lock);
+		entry->d_flags |= DCACHE_ATOMIC_OPEN;
+		ret = 1;
+		spin_unlock(&entry->d_lock);
+	}
+	return ret;
+}
+
 /*
  * Check whether the dentry is still valid
  *
@@ -230,24 +249,10 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 
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
-		if (fm->fc->has_open_atomic && flags & LOOKUP_OPEN &&
-		    flags & LOOKUP_ATOMIC_REVALIDATE) {
-			spin_lock(&entry->d_lock);
-			entry->d_flags |= DCACHE_ATOMIC_OPEN;
-			spin_unlock(&entry->d_lock);
-
-			ret = 1;
+		ret = fuse_dentry_do_atomic_revalidate(entry, flags, fm->fc);
+		if (ret)
 			goto out;
-		}
+
 		forget = fuse_alloc_forget();
 		ret = -ENOMEM;
 		if (!forget)
@@ -290,6 +295,16 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
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
@@ -297,6 +312,12 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 			fuse_advise_use_readdirplus(d_inode(parent));
 			dput(parent);
 		}
+
+		/* revalidate is skipped, but we still want atomic open to
+		 * update attributes during open
+		 */
+		fm = get_fuse_mount(inode);
+		fuse_dentry_do_atomic_revalidate(entry, flags, fm->fc);
 	}
 	ret = 1;
 out:
@@ -943,11 +964,10 @@ static int _fuse_atomic_open(struct inode *dir, struct dentry *entry,
 			 * return -ENOSYS for OPEN_ATOMIC after it was
 			 * aready working
 			 */
-			if (unlikely(fc->has_open_atomic == 1)) {
+			if (unlikely(fc->has_open_atomic == 1))
 				pr_info("fuse server/daemon bug, atomic open "
 					"got -ENOSYS although it was already "
 					"succeeding before.");
-			}
 
 			/* This should better never happen, revalidate
 			 * is missing for this entry*/
-- 
2.34.1

