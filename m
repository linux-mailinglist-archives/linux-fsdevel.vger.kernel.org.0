Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D85B6B246B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 13:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjCIMmZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 07:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjCIMmK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 07:42:10 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2129.outbound.protection.outlook.com [40.107.215.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DB9EDB5D;
        Thu,  9 Mar 2023 04:41:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+aDgfiCOEJwtPdr/RurbHwiaSsy59hTzpptbbgkSbtTQUnTKi9KffeHS+6lNocTyuv8XsXHpMg3KNaoPCQ++/MqY7QapNyVVPgX2Hd1fQGbmPw5ngC4+PpL5v7AvJCIlArB4C+vYa58Z/00NKE4xQsaKoxJDVynY7H/+KXkeQB1of32m18e5Ia7khOgg7eznGIPQhuVXRcHWhDk/SfbAsMzS1TzGPVPqbGN703gi6lyS/4jnsum7b2GXTQtZ6dRpMUmgUs3mLJIWecJbfOnp2e+DXzUA6OXG/pOhXj5zTFTKwemuXDEveqLedV9LFhpB4YZIY+EoNM2oZTey9x0KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LlDfmkV9Ah+i9b+mzgZJx9kWyxH4piNrBP9agZqeWwg=;
 b=iLuOhdhFMKbm4suS8hDY9CIbEj5qxqfnUDHQPDp9GxfRKGlOy3CF8tpJOenghgbdU3baCmz7wDFqb9Iqtu6pRs95hHHLRYfkdbQWN0dzI6IWR/x1YrCn2eq2SegQp8T9VwF/5WbcK3OnxdOfDMaM2uf4zClTw+sNPR/QSdTeB4NQNTiPh9u9ZXdt9WKM3TpoITR4VISd0NzTaFqOcfG73wTkQlW6K7rsY25VkJ50x1t8GcnHtQNdwy4ymLqdSy5juRX4J7fAiV+6NQPpUWn8y4iuvmeZkyThLLjxf0FQ4wO0YyPO/pafkBqFhax+2dZRYEtcasZb0uVCy4mwNGIgJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LlDfmkV9Ah+i9b+mzgZJx9kWyxH4piNrBP9agZqeWwg=;
 b=SKFhkUKXZ88tt6swle/RzEOj+xytwYgsbXV3BfV8nioLgqYFYvHnpxhRZ/++53pGldB5rXLN3yylSw5vD5LeY5IaMVN53fRgDDbdACpYutMyD5KcZkqWDirQ7vorKeoBrlovogvxp5vjv88SEJN64SOY8pyUa8XtWNxaYEDNBSpX8yO46qQqMncxrA3KmlX3wv34moaxB93tXSulh5tiQFSjmsntmRXIBNpo7mwbm+AzcLzjUYq+FVJIUFO4iZ55T6F9RWm+yxDjZlvYsHeJHJQqjEKNp73AEUpTHPMdjI9vhxPQ4lXmCFy/i1aLbUetDmqVnSVMnRkcQOTJRomP7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6259.apcprd06.prod.outlook.com (2603:1096:820:d9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.18; Thu, 9 Mar
 2023 12:41:45 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 12:41:45 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        jefflexu@linux.alibaba.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, rpeterso@redhat.com, agruenba@redhat.com,
        mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v2 5/5] ocfs2: convert to use i_blockmask()
Date:   Thu,  9 Mar 2023 20:40:35 +0800
Message-Id: <20230309124035.15820-5-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230309124035.15820-1-frank.li@vivo.com>
References: <20230309124035.15820-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0006.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::14) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR06MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bdc6c20-59a4-497f-eb99-08db209ba468
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /9VgcMIo2XZSLx9n+63QodaSkZMcfSnK1zAiby6GGlf5cz9awbp+rj8OcpKLKq+bM3lYB48C2b4K/HSi1v1/VmZetp2vDydqNEZjtcq3L138BczYXPandBWcDb6aM3YtrV+atL9US08QWvFmCLaV+Q9YO4oKVMgcvP1WTmNuAec2//G3fYl8daQ9QFzEd2EgkvkjMGRaDQ+1MDbutBeR03AgjAhwgDiU7fduiaCo5KA0u/jysw5cQ2WX4WvyK1U8FpcjDngkKj/0p9rkT5ob1n4uNoKMfUkYKiwaqwK7ikWKsMcz3l1/kRRRsXnIJoN6JVsRad5mh1SI7phpkXLkDU5YzYvirboie1nqBFe33udS73tPPSoatipJNOuCadDmmefqfCPVDi0xr4Jliice6j+Vu5wq682msJFawltFzoWpOGMruYN4Yb5ibzNh5hom1hhZlenSArcVQVgD48wzELO7TE0JRC7b4J4+GgTsxxCx3Ont+Aau82GUbHUvoeu8AjW557OGM+jNUDwVvWn6T78I+7dbR555BlnAAR6QI9VEaDRnwsRsSfhi4eCCrmevcBb0/MPLz2CFCZF8Wtku87H9S7GfIaMRbFjWjARblMPsndqCaGOo7TL2HN5rCmJrcSE6jBqUw5lF82b/OiXr+BSwZ+jRSTizmO5VK8s7GPAOJDAUkdade2GA0arR2TD6IKGj1nd8TBsC7LL18c+CWzAibiHi6prbyzMPneeF0KM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199018)(36756003)(186003)(38350700002)(38100700002)(86362001)(1076003)(6512007)(6506007)(26005)(83380400001)(6666004)(921005)(2616005)(316002)(5660300002)(52116002)(7416002)(478600001)(6486002)(107886003)(4326008)(41300700001)(2906002)(8936002)(66946007)(4744005)(66556008)(8676002)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1J/QAn3VEwBO+3y1Jyd7huHzVmxpdJVLFGT0EC3kXaMX9gclQxiqvd3E9gV5?=
 =?us-ascii?Q?dPGM2hNGBRHR5fcviZ/u6awpK71ddv86TjKp5ApHjP/Q8UYZaUcGm3XVcKX5?=
 =?us-ascii?Q?a4UR8QWaMXikNymgUm4hZ3ajnookOA+ZcemVbAF3aZJqamwNhj9QaF7m61sS?=
 =?us-ascii?Q?ZZHOqCmSJddYuasY3hC5st1t4mzmD34bUwtLR8rq8i27kkVqrLWTuR/Ty2rE?=
 =?us-ascii?Q?NsiYryjCxVwLZMZSKAu6CUgIurdG2uVejI7PvcDAPPVDKDBg8ZoGDyWcI4y+?=
 =?us-ascii?Q?3Jh96ROgxLMrcFxuvQqlizB4WolEeSa5YCYyrJesSMBHz68pQfDbhXvu+t1T?=
 =?us-ascii?Q?EAKkzKPNxahctrsfrm2MkwapXXJzW/KuRf92/SkP2sltepl+mdacjdD4s6Ou?=
 =?us-ascii?Q?KNhei5ADvq+a5+k28TcEplp8fX60rmkTinLf28ryYETuB5v6bLNsL4VVo+eg?=
 =?us-ascii?Q?roGlVt1KkYN/1pZqML8AS7+yLtVurHOnt6HCD3TtLLO1nKpTI+CKRrkZj4kV?=
 =?us-ascii?Q?CJl6jDFrnbbGWxbJciFDZyyJJqKonOiBrjsWszEXJUtlSg7lqm1FaMifv+Zq?=
 =?us-ascii?Q?B868t1y0+TdFUxepHf19/3OcPyneP3G28dZvwVO/sydeR4MjQQGpcJsKZAfY?=
 =?us-ascii?Q?juwDNOIqHzN/Q87zgqaaElaZE4PVHf1FVngo9jhIZJtOOaJAi1pU38f6Ur7K?=
 =?us-ascii?Q?cQHM5D6jQxn+PKpuYNXoPK23jHzwkIvooLMukwOZtgp9xyJ/BEwZPJyk6xaV?=
 =?us-ascii?Q?PyJKLD/Z0hWf+BD4TUZxqspf704kYP1VL7bowWZtyT6dhnOrZX4s7Wd2dzGP?=
 =?us-ascii?Q?W9S16gTVuXryCcs1tWbRXtxaeTZJlfFNJskJZVwKVglz0XwubuJF5jghf+sZ?=
 =?us-ascii?Q?DzMd+XpZZ1N7LofcY9PO2yaQVJjPe9HTA189o/P/+nMjAoQYmFF7RXTr6tXj?=
 =?us-ascii?Q?Ufmcv6OCNix6R9oA8uuxX7NloIyA9KZ/x5XFGZ9OQWe0q7IenXvNvMu2Uh54?=
 =?us-ascii?Q?I6y2598dqTjp6oY2So5X16ETT7BPn4dEt/375hlmGdlrAcSubOIAEL+U0G3K?=
 =?us-ascii?Q?q6IUd3OVB5UFYudx5jI9rdGQuSmMRFIgrOsMG4CKibMOsPqM+Vuxtik3SfeI?=
 =?us-ascii?Q?fUoJZIom9+KL+qbV8VsI5rGwhv5M/G1zagM1l4378RvqHNOvjH3BRi5As5rH?=
 =?us-ascii?Q?b9yejqc9+PCK3CPIPpHDqAm3LkPKqF7DRjR1M6MiLzlI/CiMhYcocylW5BPS?=
 =?us-ascii?Q?4C/47wt7RO+4pl4p+FUL/3hgrhiKeJO5rwOcMLIw32YU4fArEw6VlWzemN/v?=
 =?us-ascii?Q?IB8UR7b1bxNL6huaL74HhKxPWhPIR/n2VM556DF4MEA8ayd7CKBv2zXg0UAJ?=
 =?us-ascii?Q?Z1mE5QN2W8Red4zUmy5hkopf81jtKMV3PCZAdx5QHsq60q/hW6ZsiQfblIop?=
 =?us-ascii?Q?kyjbBHli6MXNGd0ON5ydfTnFmb7CNAPdvrOpnuY7QzEGo6NbDRDbWId7Ie3s?=
 =?us-ascii?Q?pladYM6IJpn12JWQX+fFPfcXqXiIot3qKDzlBYNaXbe5+Eq/Mwk5mM5blgn6?=
 =?us-ascii?Q?0y0srKHwWGYPWphx3nd4mx+Z53HmFlNHYXKRl7H9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bdc6c20-59a4-497f-eb99-08db209ba468
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 12:41:45.5447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 069NZGzxhTPlg+X44XPS7qEWqIOlrvYZxF66H4bSU/VtWXymK9WtKd/hbTJLhLBwfdmQYZEIXtmcU5ae+DyFDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6259
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use i_blockmask() to simplify code. BTW convert ocfs2_is_io_unaligned
to return bool type.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/ocfs2/file.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index efb09de4343d..baefab3b12c9 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -2159,14 +2159,14 @@ int ocfs2_check_range_for_refcount(struct inode *inode, loff_t pos,
 	return ret;
 }
 
-static int ocfs2_is_io_unaligned(struct inode *inode, size_t count, loff_t pos)
+static bool ocfs2_is_io_unaligned(struct inode *inode, size_t count, loff_t pos)
 {
-	int blockmask = inode->i_sb->s_blocksize - 1;
+	int blockmask = i_blockmask(inode);
 	loff_t final_size = pos + count;
 
 	if ((pos & blockmask) || (final_size & blockmask))
-		return 1;
-	return 0;
+		return true;
+	return false;
 }
 
 static int ocfs2_inode_lock_for_extent_tree(struct inode *inode,
-- 
2.25.1

