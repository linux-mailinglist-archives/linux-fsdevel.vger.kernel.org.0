Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC7560CEE6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Oct 2022 16:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbiJYOYX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Oct 2022 10:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiJYOYR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Oct 2022 10:24:17 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2091.outbound.protection.outlook.com [40.92.99.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBAA120EF7;
        Tue, 25 Oct 2022 07:24:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8d6gisf9EYZWZknpcb8sl3/mtE/W2PveCD8RJRrW/UH1FJfcIATboE81s/0rHzX8d8WqcjhA02S2AEyP5O6yH/RnY4Zf11G771aNwhW6pK2/+Xwa6CIkwz9CLy6KBW3Y2YLVEw1oexnsTObU762N5tf5q1xWKIG8D5u3+UeF7WNTVPrUfRnhqmU8vPzUA6trm6xpKlRqZGzKWrHA+Rpn/Q84kBJ1nGPx3hcf2vN1v0ms+FrwClFQximXvBncqFfqCXQ+TuiI2Do6JnIRM5RyxdkZlT7j4IJlJw3vzPkmrvxtmIMGaEuGBXnJVhPjJUxeH2AtJLRK27hDlCyx5pl6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zcJljTMGPXUFkxnYOBBsjcF6wkPBV/qn1j1NedUcSI=;
 b=Jyr83BI3D3myJ9vDjS9H1n+UUlRNDoKi+WKs2aKPQUlICGZiSSYPxiDY5FcW0zWmo3imeiZpsra30CKu7fHWL2CLsYr7IlreDfh7n26UIujLrGvgLSWYVNC0l4MSfWyqy9FUwV8//wC3zn4zd9coDahXHqwCXbXk4XnHzLEB3E2z+W9Vm6vWmwKnde0fDAJPSEYy2e9ZWdsqWiK6jrt6PLvtHVmw3u6PgGb7n0tLw6oHb7nYhKlABaXYTekIeByTiNqmq99NOZcJxRlHmJeaLB88sFT7thgt27Z9RrRz91p5UMQ4t5jwb5Zht1JbMgF0XN9lSxhfpZcBpQCCZVItbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zcJljTMGPXUFkxnYOBBsjcF6wkPBV/qn1j1NedUcSI=;
 b=cEUQ9JzE0jzvXYRZ7EbfiiGLfCJxG3TaBQo7qN6Jj0osfQx43DeI1/rKk2eA5B+5rh8DHht6foI1BZeVw/EUZqLIRn2N0aHRqAKbHYPc6iV0Zz32STINXVguL6cAxAFxk2v1vTZfTFc//y97OHdXd/TzkVw7q6p1FKtlsHhVfb6xE1eqcsm6le605Z9cZmN3zgs20M1pcDroE8gV6oE+LUX+SUJiwZEV56TRGJnfmdjzNd0chJehfIRFLUePl9R7TN8FlG2qQrv3psCBi5fGKLRahFtJFo9676x+UhrQUFClOhPywM1M1kRMQE9wLPJN/vsH9X8fiVXabCzqLpxegQ==
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:152::9)
 by OSZP286MB2109.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:16f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Tue, 25 Oct
 2022 14:24:14 +0000
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::4722:62da:4861:9d73]) by TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::4722:62da:4861:9d73%3]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 14:24:14 +0000
From:   Dawei Li <set_pte_at@outlook.com>
To:     viro@zeniv.linux.org.uk
Cc:     neilb@suse.de, brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dawei Li <set_pte_at@outlook.com>
Subject: [PATCH] vfs: Make vfs_get_super() internal
Date:   Tue, 25 Oct 2022 22:24:01 +0800
Message-ID: <TYCP286MB2323D37F4F6400FD07D7C7F7CA319@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [diWMgxRunJzNYx0/olHyjYUUZzsymLO9v1JWIG5E8so=]
X-ClientProxiedBy: TY2PR0101CA0033.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::19) To TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:152::9)
X-Microsoft-Original-Message-ID: <20221025142401.2876-1-set_pte_at@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2323:EE_|OSZP286MB2109:EE_
X-MS-Office365-Filtering-Correlation-Id: 6761b73a-cd58-4902-bd7d-08dab6949773
X-MS-Exchange-SLBlob-MailProps: rYPt1fhvLTUdhmixpIsBU+VLc8pOS1tvP2p9uIgy0kcKaxLLgM267BQnJS/ufmk+bhqsMyizz4Z6HsQrdJdzZa/xW25s5a/45HbBfvSiaokIuTLemcV4Ll/jufPqkxytVD665XJxq8APS8B23KLB2erCzqm4WhM14ozavrMP6aSua932fyYepD+tS4bMlbpmhppkCdiM5XK76BueRbpHzByiPUN2gtHuMxJbdP7mZfsipZBRa9cxk+LU5g5w5ktsZJHGzEY8eYZmcK9O3G8cFLMpvYCOGhThhTJCg6Tl8uzOcFcmuTQ/UrUYCbsnk435Sp+jA4lHQB0e/yEQg9yzOHqHEf7lPddvmyVztyupMqnk+j7MxMcphZjLJCCqsvV0vbz6aV+kilTe3lI5H7ns7AaqjSX0idqZvPCfN0Bq2HliUq+BfqdRITjeDelOYr9Fu+x+i4hmElMWcAuM4y8fz8eHq8OPQGyfnLRqsABqtjUds8aDoGGx/9mFKaqx4SN/e5jkvOt3wP7P3YHwPZ69Qs5nqG03fNsOkdugJb77q8buf6QT4KK/TYvOBMeUgKlF0tTzFHygR5OLDIBW5pTFJbjv7QZ0lJtytldlPKr4xI8UPdBpODCp3570Ud+yRrSVnqCaC5Ev3TUhg/ihmW+rMt9aJ8NVZDYqME8EfdBVxpIG8KOyMBE3NVU57VbJDY2JjLZvq+/Q8oUX67eWl5lO9A==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZOXzW3X1FfREjqhGB484RUGuSB4cebN+S6wbPi+wHkG/W+uwfyMDA2BdKAozjLRgTBxPjh47yoIPJh+g/7ouyIE5q/sE1y7EamW8sktGtOQJr81Is0B8z5xaBbf38bbJb+x+u1AgiNDk2m0n+XWykxg74rV9JcPLCF7lVUcdlAtb210xkQNimume+b4YcYuHabu5qakYOkDbhJuaSFM2PY9zgNndXkm8PXCBLeBvPsa8SOY3AupUOsfCvd/dWMEkKUrMteQ+OC9sEdSCUsyTAY6hhiDONfDcAQC+SQVyKJU+8skgO1S3yBOS5Bjb1pGmmQOjCXcyBsdyq7RSUfKSEp8lX4hObQebLYr5G78jD8zkkMqioG2x+83ESnWPEOaOqBV/bRejL89er8FMb3KgE6jDG+7shUvCxSLCSGmHob3MTbPlFJWyj16W+PVb6ZAqCLS99TfK+Bdvc+Q/l2+5I8kb+wBaIB5omdXfH/G4H+E2Br/VLWdIeFJQHYR7nBHZ6k8k8TlzOoBYYbjDTDASH6d1GiOXM7YAgljEhf1GFeEj5kXBCPw8Zpxfg7sXazgdVeqNW6xwUGdFKlSrWqzJgIvAQcsEdKfMt4oqYLbV9qRRayKCjahxmQWKkK9jvU8CYDpcIxGfDV8vR2AFbKLpZ+kqAqW4nPYmSFGbsHiYp5JJsm+VpoLYxM6bgvafXSE1
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7/Gi2NOnVVe/eaNHPXdJmNOHITc3L7+U/LGtnRCjcCyzIWd/06VYjiNhMsfd?=
 =?us-ascii?Q?N+PyY3nTUUFwe06Wn9lfkAwYEezAytk0hrtOT3Vfav+C680Hjqp5Emtzgijn?=
 =?us-ascii?Q?S3ttZimwRmDddkUbHlWghNVsfBCfwL3Y5/LsEImtKKsY41lcCPc+3faCwcQ6?=
 =?us-ascii?Q?KJojAKOfqY2Cexykc5hquue0Ps5rc+ACLX+O22vfxE49MO37jAb3KnBja/2j?=
 =?us-ascii?Q?qO2NmZRZnNFYxT6TjWeQSJwmE+hfmcGlLF13BMU5a3f3lPfkAuO/IDTGf5kP?=
 =?us-ascii?Q?TY7fFLCKt8fspEMsJVqIggbBYAuMGVuLX4TFwb3NuqAjwim9xDTwjZriC0jR?=
 =?us-ascii?Q?IYTGaSc/u4ddGX3zlM740dC5AJloSIoJodD/Ee/qrpj2YDRo0R6pfeM0Y/aZ?=
 =?us-ascii?Q?GBuXbh6uH2JR2lvexfI4YRTUH/Clk8yXNXj1v4k9JKwLyn/Q2J0Gm/HHKtzg?=
 =?us-ascii?Q?SJQWWt3o5f7PnufaqgBb75mjBKTPU2S0O9ZWhbw5aOC6nZ2GADWl80ctQwC0?=
 =?us-ascii?Q?SFlW/7zVYdjsvrHwogvQlP7zYh76/MoP/g//5ZrOMVGXlDVBLc9KpfIUXQgw?=
 =?us-ascii?Q?eGkC/LCZC1XZJf7nTQ0U2i7h0ej7UVW128VlOErzsdezWmymelupGjJd5q5+?=
 =?us-ascii?Q?AoApptzkfOEhtSq1JEcuMnZ7OfcKj3GeV9QuIOVx7xv36haW9hdhbnb5r2WW?=
 =?us-ascii?Q?fjgKXaTIx6m4pvkJnyIP95d4E5fY/55rST9vOqg73UFWmASxr6Uz933h8Aj6?=
 =?us-ascii?Q?CecqCZCcMA5Pmvz0UI4saC4HSAef58FJ0aiN0IbLMPPrfjTbIdjlTpwSx8+O?=
 =?us-ascii?Q?44T2lIBC/DJlwOSmBX0Uz7CZD8XM5Ob6agXUKmXuRWkq+iFdO2KabTFRe3MH?=
 =?us-ascii?Q?CL7P4acvduUs/rjOcQ30tQpMpZZi85O29INQS5yf2UUuNEiUsy3hanEWgo92?=
 =?us-ascii?Q?UgFsqUa2PAFmLFciMC4HfauvRYD9vmUDb/MFD68FV2deqgfSY9G2wRyChclJ?=
 =?us-ascii?Q?TA47Z7HwWJheN9KpN0rlC83iprNhxZIFB9M12F31E0DfDu7WPiq+sBrJnvU4?=
 =?us-ascii?Q?SgFotzHhL8dOfO/dZiY+nLzWaezKmR745PYK7ppC+mSaSj8XDpk+3qDV7VAZ?=
 =?us-ascii?Q?hBc3drjEPU0cL6G6dFlCVfaA5E20Xoln1Aim4bKhCFbP8dsto1qDKblDyday?=
 =?us-ascii?Q?PiV3pkPMpdGOs6RxjdAg9bsBxJnXWQWO9zpFYbpEFKYyJC2lbqpEYzAyR7gd?=
 =?us-ascii?Q?ygiOoJdmgJ6QZ3Y7Cqm5gWrzXSnheJq8SV5HkX3LKg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6761b73a-cd58-4902-bd7d-08dab6949773
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 14:24:14.0894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2109
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For now there are no external callers of vfs_get_super(),
so just make it an internal API.

base-commit: 3aca47127a646165965ff52803e2b269eed91afc

Signed-off-by: Dawei Li <set_pte_at@outlook.com>
---
 fs/super.c                 | 3 +--
 include/linux/fs_context.h | 4 ----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 6a82660e1adb..cde412f900c7 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1136,7 +1136,7 @@ static int test_single_super(struct super_block *s, struct fs_context *fc)
  * A permissions check is made by sget_fc() unless we're getting a superblock
  * for a kernel-internal mount or a submount.
  */
-int vfs_get_super(struct fs_context *fc,
+static int vfs_get_super(struct fs_context *fc,
 		  enum vfs_get_super_keying keying,
 		  int (*fill_super)(struct super_block *sb,
 				    struct fs_context *fc))
@@ -1189,7 +1189,6 @@ int vfs_get_super(struct fs_context *fc,
 	deactivate_locked_super(sb);
 	return err;
 }
-EXPORT_SYMBOL(vfs_get_super);
 
 int get_tree_nodev(struct fs_context *fc,
 		  int (*fill_super)(struct super_block *sb,
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 13fa6f3df8e4..8b3df5ca8f33 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -154,10 +154,6 @@ enum vfs_get_super_keying {
 	vfs_get_keyed_super,	/* Superblocks with different s_fs_info keys may exist */
 	vfs_get_independent_super, /* Multiple independent superblocks may exist */
 };
-extern int vfs_get_super(struct fs_context *fc,
-			 enum vfs_get_super_keying keying,
-			 int (*fill_super)(struct super_block *sb,
-					   struct fs_context *fc));
 
 extern int get_tree_nodev(struct fs_context *fc,
 			 int (*fill_super)(struct super_block *sb,
-- 
2.25.1

