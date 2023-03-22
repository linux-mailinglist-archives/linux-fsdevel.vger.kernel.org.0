Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B886C5177
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 18:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjCVRAF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 13:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbjCVQ7u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:59:50 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2094.outbound.protection.outlook.com [40.107.117.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461BD61AAB;
        Wed, 22 Mar 2023 09:59:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7xLpHYwOGdK5ug/T998yB/7RkJgrgLuIulV9r2BXxLhLlSq61FGaVUdaAOEGqMBwQYkSk2h98ot2J+4FPEXEcfiZ3CYHKNJOIhQUp64CL+ca6EyC/66XdWDJOO8Is3w4w8D4IvHubRPESZKua5KoPV7mtCOHY7ILim2CtHeGYNff+KzDto/Ous7Dv9RI/oohhFaatDh3FpHHgZZpmZgwVESQ+HTpque4YpDREg3yXYbODY9XIp8D/N3BXWPhxrIe0pfEiH5YmK/VcJCNJ6AjT49mRytGUCJQ4Ei9zvU8nSy1886nRkXTfQ/w6TqA+GRlJ7ltrfCXfwoV3cEy3SBrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ecBOFBL5r+bnKKNsVchdUNnMVHFYGZmRu2mS3y21Ns=;
 b=FWDIv8fwiEHcMKMKR2ev8dd/q744mP1zMGDbQwNV0h7iy5Kk0DNiQwEQsIBB8jl6ZySHIf0EhtNARwSJtmIwMyZ3bgIbK+BN18EIwHzNGcyWK4sQ3CpYP/2wXcSSFfpwAnTQL1a1DP8b/RUXa3pJYAHGRI0J0oCpveMZZEZc8BWcePrKT+8IYMMEFrn7zBQ5G4YjxKeLZ0ARAOXQ32hGYrtCy+qD5nIPAiUk2fG3So0F6SzA9hxk/F9Nl3eMgrwj8YEcEjn5/tZhayq2KP678Z8jaW2ogHK5KvthrTGoLnMN4xmwDDHxtZ79Ae1X+7xNfnftcgh6fBZ3VfEF2pGEdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ecBOFBL5r+bnKKNsVchdUNnMVHFYGZmRu2mS3y21Ns=;
 b=c9lb6r1H7Rpv0moDMTBx1tBnGVjIsfssaS8/Z8FHEvlCkfn6yUSPp3AaE24JaeVZhv9b87lTHz9Un3KwsPGWcaFspcE2LxHkgglsVY14y5QS8U193SChy/ZJyeelole7/qVT9FGHmUljkfdwuRDFJIaQS52EL6fyVr5zKNSvOeS8IYhCsQAjEVLyp6boRy+QirxVQdu+WGSUJX0SRMK+HQg0dd7LFGFUB/dNpTsf555woq6TlxYqQtM0wCY2jObh6XysZhNwbnssbHZmEC2RS3H4mIecn5KOG9eF9nAxzqxShQuxUPcXD9y8uqv2NY+7Hai040KIwzp4ytkT1hgUJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SG2PR06MB5238.apcprd06.prod.outlook.com (2603:1096:4:1d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 16:59:40 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 16:59:39 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/10] zonefs: convert to kobject_del_and_put()
Date:   Thu, 23 Mar 2023 00:58:59 +0800
Message-Id: <20230322165905.55389-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230322165905.55389-1-frank.li@vivo.com>
References: <20230322165905.55389-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SG2PR06MB5238:EE_
X-MS-Office365-Filtering-Correlation-Id: da99ab68-5a3e-472c-a988-08db2af6d31c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g+Txg/37YzT4+X3Eygw3GS4f3rwgKPGdVxMClhKnPuh6c1nnl+uJ/yS+k1xC37s4DDtn9AogFuAGIlP2W1pKHH/6btGAcDawNBGteJ61vzwaTxciX0V+9W2VRiLkkqGS6GuxUYMD9J4kyQqvKoqZfDU0p5gcJ356Bq6ADkFHf7RL+8JPrq+1tM39FbnHkQTwO5Nn5hiByfMkuQdO01ZPUj/nXGTDXVxOOr+WtWZctIr9m+y04Bi0PSbVsUr0arZUCBQMIXOmnN0NOrwRrBBll23Y3lITzA1qNG9iDGP5/EOjuYPG8lxzECF7Zjg86BsiHMcOW8v/3cVpBdm76sdUE9LsYyYciWeoYfyDaXlCqc82hBo/BM5DGmLTCf51FRf3k4GeshevHXKWJGP2sVOtrjux1iybH3npUkBeWFNGlY483bI7V5Cz/yEqsO2dTNK0u9JVSIDsi9dtDu7ctzIuq11TN0S7nAs63GfV28DKCsyXgQD/IZ7m4RE+fKkm3vo+hiZrF8+skrlP7xxsFRXbtMHfBBntu1poeEK1rPSZ7jlTfw3fOQDJ2BO2TgQ3VISQAJtCXrg6iPURiLK4IWInStp1roYSEjpqHlmKP9VDm+wOTgtPogzX79TZuZ4yb4c2Uqc/mrO1RGIusns3pliTn3Bk2rgnMPv4QfUcGKOZV3D08/t9eGj/8hhsAztK92vyQdVX14BNr89YCKrSpipROg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199018)(2616005)(6506007)(52116002)(478600001)(6486002)(6666004)(83380400001)(110136005)(316002)(66476007)(66946007)(66556008)(6512007)(26005)(186003)(8676002)(54906003)(4326008)(1076003)(8936002)(4744005)(41300700001)(5660300002)(2906002)(38100700002)(38350700002)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oFTngEOiHyR2je4N3zLoLge8Mf/kA2dSlBxmb2bR1dYy8guWZIW2ACpGZPOD?=
 =?us-ascii?Q?fYn6fz9hRy7igZAJSG1iy9W8kULvkxXDLiqcZORJ/kmsPiUP6caYak66tVZI?=
 =?us-ascii?Q?bogGnUvzKqSuA7baLKochSzsezgmoG7D88MSpnPQG65eUfIWX6KVT7kd6/rH?=
 =?us-ascii?Q?i0cU7j4wz0CGnv1P6w8q+LCpTcWZ0RkE84Fj8DbYkahnN7c2yht6Qijt6hZ4?=
 =?us-ascii?Q?QmpqeZfN/3Aae4ZT6EEV/guIxXYrweO0DiR1b0zseE+UYbkEkIxB6vypBZs2?=
 =?us-ascii?Q?rZUGH4ypkhnM8R1Cz5zJWCWvojLgDtGpTJrcHG1hQMeyTYE1t/XLY4bNCB9o?=
 =?us-ascii?Q?eC+k7klUdMe8ov/F5bL9Uv8Nv33bk1aBCqs6YalYKrVa7gW2NwOT2LbTKN53?=
 =?us-ascii?Q?O6sDL3+KZX/1Pz6+4GCjBoO8/lbutJMGQmwx/yAJir1vwuW+B0DmfrZiMa2x?=
 =?us-ascii?Q?4m4mu6IPwB4B8fWVq4PjGDWk0b3n+Y+uF3NDTMI/18loPnqHky7KALCH8bUJ?=
 =?us-ascii?Q?I8N9cddobL1Tf7OnsnbOctewUqf8q33IhweWOQRMqFU6YKXPtaIisqh6/DR5?=
 =?us-ascii?Q?48i1kb441iMR2oKkYTrqmL5D+fuWWjtbtG/Nc1YjUHQMvhxrcKbe9MyrXKd/?=
 =?us-ascii?Q?Cxe+msNZszrGuOAw6qLaA06i9898eNL1FSP0BCYE7J4ZmIGFyIx+lId7rngz?=
 =?us-ascii?Q?9cyaVHNLCMQzTtvu8mimn1FR4ior3jNZmy3PVnT5Z/v8IITRNJT24EaGw40J?=
 =?us-ascii?Q?IS15TdBoaeIzbkoc8j7j+sbj9OmWTkVxDFVPq28aOsEqCG+t4j/SLo6wt4B4?=
 =?us-ascii?Q?qNzhATj7l1P2x42tswOy6PF0YEL4wGGjuWQ2coljoI+GGLBWr6OJeLGo8Vt1?=
 =?us-ascii?Q?qvd8FSpiKCn9CQyQ82264ZEGxcYfBLkftiYG9ULNZprJJGYBaxuektOCocBk?=
 =?us-ascii?Q?IBthYpZLHyCoXVjB2YQwmi65lRdvZKp3c/YSKa0rml/o0BDZLiZKUq16bQ21?=
 =?us-ascii?Q?+m7vTiJ5TYSP/jouy09RRNCIuLpFux4s8RYyyM/AEVQCPkYD5/nwHfI4r1NR?=
 =?us-ascii?Q?aG5zSjZfqzLyYV+azppFjiw+L7JvxcyeqnFXPzLM/b0siX/s3uYmtve57U5E?=
 =?us-ascii?Q?eIa/FIn2trEjoo4X9LViazgAOS4x5go4e0NdjLVRJAdKYKx+wRfOHmba9BeI?=
 =?us-ascii?Q?TjSGJfn1YE+p8pSetKdVrR1a31pzRCgaHlFGzBcS/5KUKcYIQnRM2RXLqK/B?=
 =?us-ascii?Q?rcnMYiilkx7O90vAxphb2C8PZm57Kg45cgBpU7p0Ijje9s8MIq5cfCaGjSlR?=
 =?us-ascii?Q?wDWiFRZA35dENbGllC4vUu85tX7YilnGi+4r0fhDOO/8b0xldOITagEAKR2u?=
 =?us-ascii?Q?PcNp+g6QUW1UmzDJ452t4Zrm1m5B5kw1Cs6rYnXAYQ6OLYeYYXmBwNJsB8Z3?=
 =?us-ascii?Q?T5poY9/YXEACeZ05dEltPqSpIoMNOjayQclx5NZYmmAFHb5DWJIOoq+aEfJu?=
 =?us-ascii?Q?xiRdMQMxPhTIDPcT+pefq4yHv+CusUkTC3shYtZ4y0fGnOoEyiNjxxQnLCiB?=
 =?us-ascii?Q?UztUzjekXmYOiJ5gp4z9IWRmExiT15ME3ZoKMQRz?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da99ab68-5a3e-472c-a988-08db2af6d31c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 16:59:39.7592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gi2U7ZaR7deqhVriXbvHyMpXVpj3dqfbkk9a3q99UzSTwvnaWEOMSXhRBidKzUNWzch14uTt4N88xDzvy+XKpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5238
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use kobject_del_and_put() to simplify code.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/zonefs/sysfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/zonefs/sysfs.c b/fs/zonefs/sysfs.c
index 8ccb65c2b419..5e117188fbb5 100644
--- a/fs/zonefs/sysfs.c
+++ b/fs/zonefs/sysfs.c
@@ -113,8 +113,7 @@ void zonefs_sysfs_unregister(struct super_block *sb)
 	if (!sbi || !sbi->s_sysfs_registered)
 		return;
 
-	kobject_del(&sbi->s_kobj);
-	kobject_put(&sbi->s_kobj);
+	kobject_del_and_put(&sbi->s_kobj);
 	wait_for_completion(&sbi->s_kobj_unregister);
 }
 
-- 
2.35.1

