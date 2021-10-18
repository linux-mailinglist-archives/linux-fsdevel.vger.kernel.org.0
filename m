Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B376B431756
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 13:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhJRLdZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 07:33:25 -0400
Received: from mail-eopbgr1300098.outbound.protection.outlook.com ([40.107.130.98]:4800
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229491AbhJRLdZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 07:33:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPTOH3DbcWFgE7YSs6Lspca0Ygp6sQLhs/Qk6yTSoSFSVriRRVmG5salPlzedgf7s8phsABzMbdsyw5kArava39fneGky6zw0Yt1nZtrpO2rLyU/sD9YPsoLvdWuW1ftBKvEEIENgvCNWm3Ye/SsAipFL0w/Bi73a4O++O3DA37LugAjz68g55laAZ5Icwj62a19uTL9Aa7fSGaMwKs1wc2NQxSOIK1hNQCUf8Ia+8pxhkncCgPHu02zKzkKP4Fcl/K+jnsB/uQACbNPpZ1GQ+8V/4KnH4VlkChwEjCfq+atg2B0j1Ypppqn+4UFBBZ/xwIB611ObGIGcSAamddnQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ly+ZKQtuQDbWgPZUYwjZn81RF1hjJ6N4vNitvO7evAo=;
 b=LNiAKDCpXRZ3WlIIAkBtTb32DY5Cf9R+MyjS1RciAuLnHL3E7107wLWrMBPOg9x6sqagpj+VtzvDOSDkKc9Uac5ZgrOC+fZzSFL6KF0omn47JEcodpOH474rOosqFXUOPdfnIrXt13ocP6qIUNWjHRfrjjqqyYgr/ysWdU2t35WwTTTiV8BCr80LlAdN4r01KHXdD4U7t8QK0C8BHEOJ7u9B21flglk1golqLJxopQxr8KAbe0dQkgdq5BXfjaitE2bRi3znKgfaYJ3btiSOFgJrcGxntuoKQO67lmfWDusXlskRg/J6atwCZNXskwS11dNblvg+r7Nrk49/Qk6MDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ly+ZKQtuQDbWgPZUYwjZn81RF1hjJ6N4vNitvO7evAo=;
 b=XxlJvSrFNf2/k/RmQ+7mwiIQQbaC33wyA3H2NFP2S6Xe8G8/OFVRu91Qj7JhkN62Ti6DD9UI3Jk3EN7U4m0B08P+LLxh3drj2gY/2oMGyPOiAkOh3vdzef/WCgUUkHIPLiAPVeZzMnZB5VKgLAjKsKVUsO3m2/90RSMQGjGe2l8=
Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3034.apcprd06.prod.outlook.com (2603:1096:100:31::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Mon, 18 Oct
 2021 11:31:12 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 11:31:12 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Qing Wang <wangqing@vivo.com>
Subject: [PATCH V2] fs: switch over to vmemdup_user()
Date:   Mon, 18 Oct 2021 04:31:03 -0700
Message-Id: <1634556663-38749-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0024.apcprd03.prod.outlook.com
 (2603:1096:202::34) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (218.213.202.189) by HK2PR0302CA0024.apcprd03.prod.outlook.com (2603:1096:202::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4628.11 via Frontend Transport; Mon, 18 Oct 2021 11:31:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c977ff32-8cb4-4d52-cd8e-08d9922ac9a1
X-MS-TrafficTypeDiagnostic: SL2PR06MB3034:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB303475210833CC120C75AD0FBDBC9@SL2PR06MB3034.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LclUXn+FKH8MlE+/9eKLCfpNe+wsm2Z7MDplUBpNqK/8MhCjw+7pm6piYrqBVkh48t50HT32TRf8mmaeeoiL/IIUmpKrJOMG44QaVUc7qdJ+wPSV8ME+G3kBWmEiiFtOkR05uNxU2i4j3Nm2qs5grb+vQ4b7IxypzZF07Mk7A6gQn5xlYD9f+a56MzL/TTiIY8uWClIIObFJjYRraCzp8NjnIMLzN362Vc5fATPe5bbYknv/mSfrfme74QchLRIqla443xHQjCFRtm7KGyqSj9JfGTZW4YtEcefPOBN87gs9P2vUlSaf2ghbD1/Vv+17pLlGJaGMjhfFcLoJ6KLGHYRi3zdsv0XijrrBaxBRgoBwgyKhBgbgXDW5PRlISMnHXpwJ9LedZyUaEDxngd0Rfih7Q+xqhqO1soeLxRiDSBrL6vc5e6LlTz5Ueo07btFysiK+zdU2P6gNu8LE6m7GlunR/rx/jEMmXzo8OA73vy6kXq6d2cV43r/3xCxXGpMmyy6CBySc5DizayCYPppj1jrW4G6FHpsuuTR/BeaJ911/0o4SxQsQi9wMdlBl4KG894cYz6MXHCpihXVEcFAn+gBwSXUoupvv4uZmdgGfphPR5HLHQFDey+q1AsghwAXbD0/ZcO4szoNNo7tJfznggbxPLqSgpxxsdLPRzG9ReQyBK7kHLT226WjGBw3O/CQR3qt9s5KkrI3uDIMazw1o+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(6486002)(52116002)(8676002)(66476007)(2906002)(6666004)(186003)(6512007)(4326008)(6506007)(26005)(66946007)(66556008)(36756003)(107886003)(316002)(83380400001)(956004)(5660300002)(2616005)(86362001)(508600001)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cRu4YG53xGRSIMjJWDywy7P/CTv/RS5Z1a2fKe1z2ZQRokEjXWtmKBrzwmUd?=
 =?us-ascii?Q?O1AlsTzJEMY1Sj9q+ks05aoNWf3Mf0s4fJnvktyhuldaMCgy7tIS2bDYcQYF?=
 =?us-ascii?Q?62FwaSIBl7rJWY6bDXGvImN5QeLrU+aeNfE48XlbyN6+FQ6AaCuje8LaMaSr?=
 =?us-ascii?Q?lOE/ql7CFDBQHQ3VcbUnSSR/XaZ6NPl1KuWXvm0lFeWSWmXuNJsRTwYs5/32?=
 =?us-ascii?Q?pyHv0nOrCHBZ3pifAOZ+XctT7v8g6RyLQ1mbtsOtlUFtWXUcAC7JuAdmtJhz?=
 =?us-ascii?Q?R2OTtn/xKb5xnhWiOppn/lgyxAyIcKhZSp7+KWwCHr41yGw4Ln0wOnn2KGOs?=
 =?us-ascii?Q?NqIBHL60Agg9rUdcoegen+9J/+muws8I5tb+tCuVhiRMc+yH9rU5w5VhwZTz?=
 =?us-ascii?Q?uxiMqs10iyKqKNI+t/K/vztK3C7efcYcCsdxDy/aTaA8hsTO+XMSXT79N5/4?=
 =?us-ascii?Q?ofZld9kZjZopNSq2jVKutgFrV5MGgLd6J9e+myMErB3UD0N2J5Uh6EKdxOgE?=
 =?us-ascii?Q?UTmZU+vHblTbvRxWn+4OyCxeI8nd6PyqEvrU/wWELIL4C/wVbAURtgPbGVEk?=
 =?us-ascii?Q?Mhi5YNJgrR0/ytY52+AWi95qbhkFsik1EZDd0E6FJL0OwEXuE24/K4tHsb0L?=
 =?us-ascii?Q?1ld0zaRHWG8D9upYp0PtZwKSOlg9BoodaKOmeNMDKWkoq8pLrubzkOfSqFva?=
 =?us-ascii?Q?3GifXCbFa/rd87WdncIpuMhZnAqIpb+thepgPZR8pJhb2juzQ5R+iYJowFyE?=
 =?us-ascii?Q?bVr3EiAnfiSYs5eTZdIeDZ4K1XuCLfWomxZ42B1NjjyPnx5tyCYVnTnwKoKk?=
 =?us-ascii?Q?DfW/BkJoVJlfLUdak6kSn9VCkGlLlZ+pOaVmgh+BIsHk19T71SKZsMkrysWR?=
 =?us-ascii?Q?lmjWa3e+lWguNpIQpYPC4gTxnwOSW8jaL2zP/vMAH5hhywOLOeIlxQZ9EBGd?=
 =?us-ascii?Q?9IAfxKDMQlUi/j5BNcdRraOZE3G53EZaesRbacmMUr7054AQpx8zW2ObZeai?=
 =?us-ascii?Q?R3eS7pMSg4lB1Cvl7IlS1eoRmP5W+9wfcF8dXsPT2ww0vql17Dm5F1eLpRGV?=
 =?us-ascii?Q?zVpdWhJ2anp4NKWTbvQl1l6/ruNigAPxHA/TL2V4ouuc45hhzAxs4cHZcFmc?=
 =?us-ascii?Q?hwWSHnR8kAmpV4IBEtg3eJLWqF3do36JJPUyqbRIKtBraKqd9vCihzrKuhQ/?=
 =?us-ascii?Q?CIqEtm2BRAJHoRYFvhXxG2WqHZGtBt+CP6a3T9DwXoy778fI1TolgK1TQNc/?=
 =?us-ascii?Q?r03OU3uAbov+Ftai6tudPBxsZmSHm3fEOCy+DwlHoYEPpC1nD49++lY8ryXB?=
 =?us-ascii?Q?PI/roEhBLIuVJSY/CxJqMpA3?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c977ff32-8cb4-4d52-cd8e-08d9922ac9a1
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 11:31:12.0440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KBS8iFpmbQWRu4khs584lFD18h9RLb68sGFy2B7KfSOuzzDnCQWSEDnPwUK1jxR555xzwgyMjP4HM9pG7UJeJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3034
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch fixes the following Coccinelle warning:

fs/xattr.c:563:8-15: WARNING opportunity for vmemdup_user

Use vmemdup_user rather than duplicating its implementation
This is a little bit restricted to reduce false positives

Signed-off-by: Qing Wang <wangqing@vivo.com>
---
 fs/xattr.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 5c8c517..288daea
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -560,20 +560,17 @@ setxattr(struct user_namespace *mnt_userns, struct dentry *d,
 	if (size) {
 		if (size > XATTR_SIZE_MAX)
 			return -E2BIG;
-		kvalue = kvmalloc(size, GFP_KERNEL);
-		if (!kvalue)
-			return -ENOMEM;
-		if (copy_from_user(kvalue, value, size)) {
-			error = -EFAULT;
-			goto out;
-		}
+
+		kvalue = vmemdup_user(value, size);
+		if (IS_ERR(kvalue))
+			return PTR_ERR(kvalue);
+
 		if ((strcmp(kname, XATTR_NAME_POSIX_ACL_ACCESS) == 0) ||
 		    (strcmp(kname, XATTR_NAME_POSIX_ACL_DEFAULT) == 0))
 			posix_acl_fix_xattr_from_user(mnt_userns, kvalue, size);
 	}
 
 	error = vfs_setxattr(mnt_userns, d, kname, kvalue, size, flags);
-out:
 	kvfree(kvalue);
 
 	return error;
-- 
2.7.4

