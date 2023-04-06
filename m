Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E6A6D92B9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 11:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236222AbjDFJbR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 05:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236409AbjDFJbP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 05:31:15 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2130.outbound.protection.outlook.com [40.107.117.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3D865B6;
        Thu,  6 Apr 2023 02:31:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqjEbqHURaqcMLCvpVJkcjX4DP8yETLaDjThKMW8HWZkR63Q6iGS0jKbPXAYVR/zEMOvm4gikyi7P31fFgptQYsZhmIm8d1c4GM+6lanF2tvePsOoNhmPJ6XPzeVq8ZlSnAY5LxohWSireDEuGj2LpvVJqgJQSBrOyJXdtZaXclMAvljTvGY7/41d8Vi9ynZi+dYwqTIja1QOEO+clRYE7HB2nog+5hti83dA7O+YkjqD9GEfHYd+PwZ2gp4sCXCZfuAeXzYggCPGmomSYWgNzg2PYZk6NH4wQL/YPeM2+lXty87p8YRzKvAInYTrH/8vdNbTYTpwtCkTxIY4b7sAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jx3LPpRVZASZ0NonrMCGIl/8nEX/C7veMEX03jGe01w=;
 b=gwe03sjV9WeSxiBXNfHmRyFuEySvlvB+eP294bWGqDqhEfOoKvwbJ7fEJ3APwSEUFPfHgZFoPP703HSySwSmw7dvIc8oJzUSA7A8D889ajfHYAZ+xodgp7ufKwO/+SfMIEKD4KAiboT64BIkttdq0lM+mscyXu2GeRNKezRzaG4VwK4B8qarx1klLw/E7a1/6aDIyoWj0d8oktGx2CWdwFyiuD3dZMWksVQaQSAexKPqRR7cKgR6ONRBOhSEdHou2NyNCHq/5m/Na9Tr5o3Y63/3D0ruXAj7YnLEca9jSMkMs/pMDBSEAk8eGgnCNz9HgkoNhOvcHohQX44NRz0clA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jx3LPpRVZASZ0NonrMCGIl/8nEX/C7veMEX03jGe01w=;
 b=NJclsDNPTmlnWMMiSnhaZJOPVDvcFWDsY/whInLqg2my7dJ38Twlls71zUEBtBiwFucAgWbLQ/N5dOi7tfI+CySKYS7v5KAuIkjl7YWreQiUMpQFwYZjm0a6a5nhWxMMYdPEonEMHSQEF8yb1SNIyUCmVpZFrUwWnrMa/9e5oFCAs59tPE+XFtmlu3LI5bJedzQD1xuJ0z304aAGYE2dUCtQDyfiuZsXTyxALrGD9RgWloJRT3MIOcXftg5NgrN6ktKZP87lpM67f9onaffCHFFW0zP6uczoDUBn3Nme/pslWMEn5csrXcSCtSdfFqmfQ/QVPBMVY7Ijt1xy2Yp/YA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com (2603:1096:400:1f5::6)
 by PUZPR06MB5772.apcprd06.prod.outlook.com (2603:1096:301:f0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 09:31:12 +0000
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::16db:8a6e:6861:4bb]) by TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::16db:8a6e:6861:4bb%5]) with mapi id 15.20.6277.031; Thu, 6 Apr 2023
 09:31:12 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        jefflexu@linux.alibaba.com, damien.lemoal@opensource.wdc.com,
        naohiro.aota@wdc.com, jth@kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 2/3] erofs: convert to use kobject_is_added()
Date:   Thu,  6 Apr 2023 17:30:55 +0800
Message-Id: <20230406093056.33916-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230406093056.33916-1-frank.li@vivo.com>
References: <20230406093056.33916-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0021.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::8)
 To TYZPR06MB5275.apcprd06.prod.outlook.com (2603:1096:400:1f5::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5275:EE_|PUZPR06MB5772:EE_
X-MS-Office365-Filtering-Correlation-Id: 8170c1d8-b98d-4372-ff9b-08db3681a912
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 72ZPUACYtx/YRirpcMhxSmSupxy/1cYwOBu2VRNOkxpUKzY70bplrwgIRN17u8+H43D30OaqPWlTShbFDVosrcZk1m/ofO+NTJ2UcBjhGHbQHVPzLOJg+YK6l/jdXyPgEYALqTDURxchSfsqRbYOgz/p0uJjByQWzUHpsJu1KByZKXY+DvGlZe5TvSXVwIqIFi2oPxrTSV/GnnctZ3TxD4x+L7nTrjElDDyqIQkepj6wRKLWaskhB+o244bEW1ap7WjaYa2YN+JhH4mwN3Q6Cxn9oXxUnctBhC3OE6V6wsR81jOcbBSvD1U7m4it/4/KWgin1hiilBFuvTLX94TxSjhxnNC+8TwCzyaa1qCrh1SeKE41Qt8rwqMkVcTtYmouZF8QKUycpbFc0xd47Ht+zlwqWB/xLhQlJHJK0s/UCsMhXnH+DqqhKp0BAIJatKQDTbGTbJLETjtnynfi6nKNwEmnkzH24QiUSmsl5Vz9F3/Ao/fUTnxesutZAJxY1HIVA4neNNcep4+WV52583Hzj0TC5E2Ls6SUXplOspl8iCTuVDrSWQzW5sFrjeTH+uuap2ThHGQ3CVHYPM6NAQPJgLcUPEqwdfmSO5SjIPvGhN1Nr/475CRGVaW1yAwFbm+C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5275.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199021)(4744005)(86362001)(36756003)(2906002)(6666004)(2616005)(186003)(83380400001)(6486002)(6506007)(6512007)(107886003)(1076003)(26005)(8676002)(4326008)(66556008)(66946007)(66476007)(52116002)(316002)(5660300002)(38350700002)(38100700002)(41300700001)(478600001)(7416002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8xu4ODqKtAEl1g7E56zucgOxpsbcH9SlAcjmR8ueI2nrU8hvfWKC3AHqkiBe?=
 =?us-ascii?Q?V67C4dD7uK+b1EpisG7emocEAqwqOkrGRGD5N8H3UYCars6Kz5ILiLYlke5A?=
 =?us-ascii?Q?PEP9fSc1ej1k319glHbQS/vovIPPfWF5/3AUqSxIvJq8Ljgz6GedjIjiVWZu?=
 =?us-ascii?Q?X/84LGNjFbgraHdm8+P/pfi1CBnPXZ1ftpqIjb7v30uy0B1jefCiWV1yZD7y?=
 =?us-ascii?Q?5DOTNJ3hMfPIQk5hg1gZrtEj1mbTSYw0sXEq1DaKQDIdJyEOBOK/W/BHitV0?=
 =?us-ascii?Q?peWOghgs4M28bi8wbnXZqNIM54LENo90IRM6SXoCq5mwEpI/KplzQEf68eQu?=
 =?us-ascii?Q?gLQv3Su18mf9UVGAymh3dUlsbmrf4XoPAC6BXcvz8H841nTSBTZRLg3v7QTn?=
 =?us-ascii?Q?Vr6tLRXAvq1k0NXZ13E4Rp2bnTUpUrrAGMkdl+mZsDyEUkULyKI2YZtfHtca?=
 =?us-ascii?Q?27QQ/yTopMjWTjCT2rT9fDQ2NF7mnPXVyGtQdlAvWFoNTZMxCeJekwTAilDm?=
 =?us-ascii?Q?tDexjFpidJeB3xxS1AXDYxUD32UNnExBv2VKWe9ysWKxf7VB9qcnWaUZRnSo?=
 =?us-ascii?Q?x0BvwCPf4N2YKwJvAnsVEittK1kfvMaV9ijjszOrc3xz9PZ4otl9imyBp7ws?=
 =?us-ascii?Q?NtSEUwbza3NfHRLABBOET9FV783+hUqLPobHO5diyHn5xRmNMh1G1aS8+5x4?=
 =?us-ascii?Q?Z3HlxzS3fsDb6F+lP0Xoz5PSoSfW5yHB0NmbHN+GajicnJiSqJNUrW5C16T4?=
 =?us-ascii?Q?mhhpLSUl296x3F/jCiEnAasv8yR3rHhnWDRt/F+tCrFqCR8PgkfyjTTs1e/v?=
 =?us-ascii?Q?9qAiSVfMLyOBb14qzs4sk1DXH+6RdE/SjMyiBvWiwzwE7BYSl2hpF0zsETNW?=
 =?us-ascii?Q?EdT49MVuldHCGVocir5yi56wyRgorWwWnB/h8rChNKn+QXWUM7rIhcagONZy?=
 =?us-ascii?Q?hd4dRtLcddcYgnFOMgCeUJi8wTcUSQKdi+GwdaVUYnKCnET8jhChKqlI//HY?=
 =?us-ascii?Q?RI3Dz6IPEb3GQn6JdeDS9Plkd/zqj7lxsTBZf8UWoawKtubXZb0ZPiE4ICXr?=
 =?us-ascii?Q?5Q7vCoFuJtx1QKaAEe8uElrQSBxowB3L2QJ0g02bXXTzVDqGHRKjxQI00ti1?=
 =?us-ascii?Q?Xkiw4Z0kog876vt+pJKmXBneqUX01whm7i5uN1iFtJyGHnuv3RKwX8CU++ou?=
 =?us-ascii?Q?iEHJnOlKcWFdxT+x1THxJBxBrwydyLb1lfRzQB68j67HczBDfAFi3h13dljb?=
 =?us-ascii?Q?e5SBjrGBJZxfpJ6TztPePm4YxJQiBpNM1uFJ7R+yle6cxyQ6uJ2ax0/3IMVF?=
 =?us-ascii?Q?jLfeFTxKQ3BRGqyttJAN+wwbt66iaP9Ty43Zmd9dHeNc8CjG7PMtQ5vdHijA?=
 =?us-ascii?Q?vz8PwKU0on8e6VkL+ER8qNBuUGFyrHdJ2BdEsdjPoNGRAuzFWfex5/ru7cVV?=
 =?us-ascii?Q?JrSHYj466J3rB9CRKE3D7iojBp0w49acGWmj2V25IxI/2avkEKnkq841ss74?=
 =?us-ascii?Q?rT/JYHt4AAmLaaiV9GtVWpNX0g65lJ8UEaB/JS6W+AYoDSH6lyNY27RruuRw?=
 =?us-ascii?Q?/hKSYuaUaCuQv73mvJGt2pVomsdXh51cDBz+MM21?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8170c1d8-b98d-4372-ff9b-08db3681a912
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5275.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 09:31:12.0469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ucu/GWhOFtHHd9+lmAZP+zHCRhmy8WjLG6Owda8gfhS1ot0DwgzrvJF/ixbprPVuVtsZoo7q+Bl1MR1XyI38mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5772
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use kobject_is_added() instead of directly accessing the internal
variables of kobject. BTW kill kobject_del() directly, because
kobject_put() actually covers kobject removal automatically.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/erofs/sysfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index 435e515c0792..daac23e32026 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -240,8 +240,7 @@ void erofs_unregister_sysfs(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
-	if (sbi->s_kobj.state_in_sysfs) {
-		kobject_del(&sbi->s_kobj);
+	if (kobject_is_added(&sbi->s_kobj)) {
 		kobject_put(&sbi->s_kobj);
 		wait_for_completion(&sbi->s_kobj_unregister);
 	}
-- 
2.35.1

