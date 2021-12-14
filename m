Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2839047425A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Dec 2021 13:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbhLNMT2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Dec 2021 07:19:28 -0500
Received: from mail-psaapc01on2118.outbound.protection.outlook.com ([40.107.255.118]:18240
        "EHLO APC01-PSA-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231873AbhLNMT1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Dec 2021 07:19:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKvmJKclUXVd5nyuPLKm1Lb7WvMddKQnuLIhTq+NIrGOgfdr/KCLLTAjjX5WFVLl6BhSjAyLM6TXBua5puRRBLs/8JlqqXekapGGATtpqFnPu6fU+oBW2Nr/M5Vff5fpsemde8XyqGBp43twdRa+jk9QgS+4wA1WWSOFaO1LvqGpeQMyu1qGmjOjxY9QhNWBUyLO95ofEEHfYaL6cJ67cZxRkXyaYOFohTMg35kGa0DMtV/jDH366uazoUgiEM72uM75WVwFHqF4AVfEE3IIBflibotbzsMpmW5Dbgvco4OFm1M4UBWrHHfrvv/9yPImdne8Z0/muBNCfDj+UAPJHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvWt3Be2NLRBg1GF1A+32kUZODMRqKqiSbAx0cFmqx8=;
 b=MvTMooBCgc83wFRO2MHF8TIoPGXoIjiZMUpetToj/tJOjRUgyIKCJ1o2fw0sgYsnwU9OJRicOLT2ZNDeYIGzLe5wiN80PpfAgeuovqux8OhexJy+cmGT8YLORZ3tu4XnAWcVAEB7dIwhkrd5ow9TBXgtfKETSFMor1r++DfMrATpiBj+7J4ydBFb5fXJpff/eg5Z9tjLBgMHYT1oNhS16jhDqatecDkopRabYhI33HRzVvFgQQguzyqt16JnWMoAZzu872nsa6m6rMvB5G3Gu3cg2TIn+lU+iH+e98s/p0NrTdL3ea7HRrDtbUjqg3UaS3MrvHkqgNAatqFoEmSylg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvWt3Be2NLRBg1GF1A+32kUZODMRqKqiSbAx0cFmqx8=;
 b=TghOitOoXQWLUd/vcqWDsxPHri90hG0lryrfaXLgCmeoNxqPGI6k97eqoXK7M6EM6YLq6C+Zqw99rLf/aOjPNdKk7gz9OF+4J0/ZXOkHNGzfjA7WOv49oe8RPhwtGhX8RqamE7Uee7ERLcT8Ca0lAtYFrrvdk9XWD1jJpDQ89iw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3084.apcprd06.prod.outlook.com (2603:1096:100:32::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 12:19:25 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::a0cf:a0e2:ee48:a396]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::a0cf:a0e2:ee48:a396%4]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 12:19:25 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] fs: xattr: use vmemdup_user instead of kvmalloc and copy_from_user
Date:   Tue, 14 Dec 2021 04:19:17 -0800
Message-Id: <1639484357-76013-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0017.apcprd03.prod.outlook.com
 (2603:1096:202::27) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dff82dbc-4585-4ea4-10a0-08d9befbf7b5
X-MS-TrafficTypeDiagnostic: SL2PR06MB3084:EE_
X-Microsoft-Antispam-PRVS: <SL2PR06MB3084DDE4595DA070D62BE9BBBD759@SL2PR06MB3084.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:386;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1//Nd4KWagDShq4z+JSCBR4ScZ8dQVcnPq+VoR+YpIApbHCRilZ06N7yc2OpEA6408IzXDRi6Ita4DAeN6yapMGJg0WX2+/TGIvRs5Bds5Qpfqtc7JCp3M9kzZOFzaWjKg1v4rFT3dWqVz3bsSgxKcHJ3h4VVgmorSrbwVKE9ockZECOdBILsRZliMqi2un/tyfMvpgiBZttC0FEwbGfIr7Zxf02ypjg+fnjBRMOc9TI2GxbcRbQJ6OLuRQeHfba3vxHuc2D06Dc8YFQwMmt9KLdc4Xro5E4/FwxFOQt+yILfoyvMTlu7sojlLTUppuYrtnegsBecgkU/OR+kZE5A2sMusqv+nOpkXJObEWXnVHaw+Nfmu8nfwlHefaKtjkvd1xPNSB0YDhYhQwjqLbfG7th0lD4Xk8+qaGh2/Ur+LqTGHCGcLSIollsiZHn2Ago2xdnNybEzh6WOU1TwyM/cwCT07IJ7NVxKdWDt2V5CLcFKkzS9TwmKGWV44cQaG6/lAgguM547AQSQqwZSIjrPXL9fDM2va5XInMDu+NQQTukiNOfzD/8SXspwqsCnzubaGHvCdyBFuQ4hD/kaqRBbVkqUtHq/XELE5zip9tIfsYeRaH2y5pZ0hMxDeFnSYJsQSuXLzFn5EROVP+JKf5bK0TJhSoTdMtt99XHnhTas2LRnY2fyqzHQzPqMOi1sIkwa18OgbLjxcKEdev9ksuJSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(107886003)(4326008)(316002)(186003)(6666004)(8936002)(2616005)(66946007)(66556008)(66476007)(6486002)(83380400001)(26005)(508600001)(5660300002)(6512007)(86362001)(4744005)(52116002)(36756003)(6506007)(38350700002)(38100700002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uwaDWZIvK1ysk2CVZ1W5lerkuUKRTAQSvHY5kauuxJhVwriyJPD1Qip/tdAK?=
 =?us-ascii?Q?JMgWnvgq0DIJkc8mgkarQZeC4IUAXuFJefX4oAZ/vIEgIQcAGCLewd2Mu+Cw?=
 =?us-ascii?Q?/fcVn97pT/OEw2orcNun++RaHPU+zZMPRK4dcs+ySvVXrE0o/g5aokWoJ10T?=
 =?us-ascii?Q?DP6+VoOkihK/D/fK1Hqx/x0wO5cQRDSNEAj/RAuzd7Me4k3pBhz6LHngKjTG?=
 =?us-ascii?Q?Gx2ra6LNA5MFrt51maEt1rA2KTOl0K+aYS6iT605JiLcrkuflgeQ7PTuT5C0?=
 =?us-ascii?Q?2alB6VyIdmbxlpegpdys0vtYvFaSJ5N4CrIsoXjOuU+GVnG6c3xhb9AeT+NW?=
 =?us-ascii?Q?PXoUbXRSK/Y7g/sOG3wvn1MYMciD7nQBVX1ZP6ou1JoQt+HyPudvxEKmEpVA?=
 =?us-ascii?Q?2MtbirAUkwlDdg5/pqdu96qCdL7ifvg2E9JS0gefgOs052xrBe6EFU+pg9V/?=
 =?us-ascii?Q?6azKJvB23/7eiP8BISbQJWSHoyNamznJ8w/BTLnjCcjAfXOJEfzHxUxCoj9+?=
 =?us-ascii?Q?Ld0fPFubLx4gi1XFn12pXdPoufao5AWuxzxB7PJPhbPoldUUtfu2/yqLZtWM?=
 =?us-ascii?Q?Y4II2anzReiz1jKr4jl3oDxnHXPAqj4aQ79MOtrQOur7imhcBYab43rouXsX?=
 =?us-ascii?Q?+hFlFwlyEP3IMGO7ske10QvfOwR53nR9p2I0o3bbCXT76I93Ec3p5uHRR7Sy?=
 =?us-ascii?Q?niRmSfSW9cGX968JLkvwhE4tOR/lrPk5GTh6i/Ca4JxahZ4DYtvvxQISg4Z7?=
 =?us-ascii?Q?VIvdRRkptgxezazOTiujEoMA3DkHeXa+ZI5M7u2yDJFuIU2U7TbD8GTRtqfb?=
 =?us-ascii?Q?aNvjarJuYRD83fG4PTZTqDjWsZ6sr7lc/VTMhgqcsHGYmhWD7l7AAom7xvD1?=
 =?us-ascii?Q?PAtOsGsv0FBVKKB/cDBWOpKkMX8/RZ/S3pKttRCeDIieFmqWjksJspXVxhPZ?=
 =?us-ascii?Q?PMugT8Cv1mtuZt+V1lH1GtNgUinIxcYFiB+sUN8Jgzo75QuqrtTUgsVt9pjm?=
 =?us-ascii?Q?YC01DkwzJ4Kcx1F60PLpzeBGKOAsabXXUd/mDRHTsJeZ8zb3V7ForJ2SSs+r?=
 =?us-ascii?Q?IpYjqhDER6PzBP4TewcvMLjGatLkHGvP34XbeHJJgPOnFAuLTxBD8Le5Afrd?=
 =?us-ascii?Q?s8CgduyDqUX+KRzwrMaUHkKOk96cShealcMrEippFdi8uBIYPNEBNjG34PTM?=
 =?us-ascii?Q?I8BCLKD4hhT72OsRtKpIt/lE26NcLckMvEXL13gPQi/AN9t3WGwqomGzaLQ6?=
 =?us-ascii?Q?4Q+7Nq3Pb6JpY/B+8SbTe/1hDU2Um+UVJX8yh/F6Qovf2+VCzuXbO5IbwNIR?=
 =?us-ascii?Q?q0rQbMHTaivEXvYbFZZLQNK1gKVVIVBtp/KVqsgcLgrcW6DRpMCKCCgZ5H7h?=
 =?us-ascii?Q?nixWkdw1TUbMLV6S2mvQiyTFgaFIm5yGIUaf5SEVGt6xqPtUVYuJnUQgZLC1?=
 =?us-ascii?Q?FvGENtS2OqQ+dZP9cgGuUqU6u2EiapzNuyGhnllq1MQV7QiwURusyS6yubEU?=
 =?us-ascii?Q?UWqAG6SSTYWlrGBYSX8hsyYa5V7TGIhFG9Z/REXQlmdOqaT5nCCy1S+eKoXv?=
 =?us-ascii?Q?tpQq8IoR/ZIdYErOZIUBcldqmdnbeY4cM3eCUDHepN0PCucrYrWLqaVyt4RF?=
 =?us-ascii?Q?TWMBhfmQhEO4vYCU1vReh8A=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dff82dbc-4585-4ea4-10a0-08d9befbf7b5
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 12:19:25.3472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3zBf9UX32GLnsdaOTCo0H2WEuvtJXWgtkOPyCDi+9OmsfjikBrKhzNLRRQITDiyhCdZm6Hyfuwx8JmIrxeRL0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3084
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

fix memdup_user.cocci warning:
fs/xattr.c:563:11-19: WARNING opportunity for vmemdup_user

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 fs/xattr.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 5c8c517..71c301d
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -560,11 +560,9 @@ setxattr(struct user_namespace *mnt_userns, struct dentry *d,
 	if (size) {
 		if (size > XATTR_SIZE_MAX)
 			return -E2BIG;
-		kvalue = kvmalloc(size, GFP_KERNEL);
-		if (!kvalue)
-			return -ENOMEM;
-		if (copy_from_user(kvalue, value, size)) {
-			error = -EFAULT;
+		kvalue = vmemdup_user(value, size);
+		if (IS_ERR(kvalue)) {
+			error = PTR_ERR(kvalue);
 			goto out;
 		}
 		if ((strcmp(kname, XATTR_NAME_POSIX_ACL_ACCESS) == 0) ||
-- 
2.7.4

