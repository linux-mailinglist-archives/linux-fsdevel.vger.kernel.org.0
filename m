Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073736B362F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 06:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjCJFta (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 00:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjCJFtR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 00:49:17 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2119.outbound.protection.outlook.com [40.107.117.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85CAF98F8;
        Thu,  9 Mar 2023 21:49:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=llbxFj5A8Pbl87w/YTIVEIrd+dLjORS5zqa4RUc90eLMOGYyueJy9tcOtRk9vbjaJZ8jBG5cK2vCFkPU/CxmbYnJ59VvLL0LKf2VT8LgjyGvWKJLQrJzqjXINcFfZ4qsBtffC9DczNIXvLa5YYaV53T2/ehEMWMRwDNVNW7PXbAfqVCpAe+3KZZzIGzzeX/+GmD+meH4R7xo+Nvdo2mMIC+59vae9qn/toqE/1HdeLgLorSCbpOG3LS70uKzfzHqzPOIJ6AnS7nHPZ4lJ9RYg4j7iY8er6ZYsfDCSKiUiup4v09uwx1k6tkHTnpH1Zpx9taGFHb3ajL2gdxIE5sebQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmlasZs7L9i59O960XBl4d3nj4wDOMVdMNim3PUurcc=;
 b=VFm+ELPcTfQrL67yRFEjGfVw63ChzoYW+cofV/6UwRZdhbV9A2Imi2eA/guhgIJUs0qeShuXUZiPvWZeuHFOA7G3S/p4IAA4vhorb9oBSLe9GZQak986VkENlezLmFXiyF3o9hrteWi2VQcEW4fsnJz7Auoohz/dqA8D94LdsabxTjmd+bgRN9e8uHLShKZoM1PP+reOS4Gf+1uWELpUUS4Ic2Dq7vXLL6KE1dmZLLVs6q2K6t1fURnhPw2Kyto1ooLrMjc+lVUcaU9JHGreujZVFdl3hrWkxUzc/Z3TxAiI02R3wjTSZ17/ZxW7qpNszXouorw0lTsz3YgpkMO0kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmlasZs7L9i59O960XBl4d3nj4wDOMVdMNim3PUurcc=;
 b=qqcZTbIkOD5oSFSGF9jmYNAyyzk9qIvGt3UaUx9dSIfZcW1tvbVCTFDCGEqdPC28mP+UUXsz2K08YW8SsRW7ERdVfAiPaMo5vfDenRFMTbcczR00jtUmjjJXcY5vJuTz003xaHZi+j/C23CU+rlYVcIj8iUWBsDrArUC+k7xhmu4RkvKTxNMDlgIG9S4Y3D5XoVrnOXH6uhiX3ErrFj2MxTZbsCNyaUq3WNhVz4DY/8hu9Im7lENLh1dR58mVM3b0dG4r0sYKZRkjsVNIWVOSr+eTCAmbKSX3FX7G54zSZ2oSIORw5YB0M9CboDmtCxLBBZ/s3TC23CucbXV/K8S8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB6023.apcprd06.prod.outlook.com (2603:1096:400:341::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.18; Fri, 10 Mar
 2023 05:49:13 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 05:49:13 +0000
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
Subject: [PATCH v4 3/5] gfs2: convert to use i_blockmask()
Date:   Fri, 10 Mar 2023 13:48:27 +0800
Message-Id: <20230310054829.4241-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230310054829.4241-1-frank.li@vivo.com>
References: <20230310054829.4241-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB6023:EE_
X-MS-Office365-Filtering-Correlation-Id: 47e9e2ca-c6bf-4ac8-d9e4-08db212b2d80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jqOXpbKKBVqWpr0dTOVpkjybpTY4ounv9sUogJZZ+14GmnUxIJP3zAmXaF2q5jNmCgcVri2kQICUNGngkbcZxAQ7Z+/Yc3jMCy+Jbv6h4FByrtNlkrjEkirZ80P7SjsgDFmy1/sWGYvMGaYx4Wna3Fup/i97OQal/uyWBENzCaZlKjWPBsPxIQxuu5fyUkvqtUjyN3CHVCZ3xEQ6PWSqu5RmcqCyQ0fSlLAZ721hSEyFvUluxBxp7s+TrrNKu8GRfjIF07fJnC1GiTq1w02QEZ7dsvYDgNvXsGynb9o3D+Q8/g1acv3PVbKSMt+HvZjeT+hn6Wuvw9YWgLTXZb0LvoWVy4HOXVZrQkhuiR0Ljcl8hvZJF26EP8nw7hG2WnRzS0VWDFZe2NhB3R7NMmdWFKgiekq1Ozq7ksitzlajfKhpJ8QdquNxo2lEQ4thaD2cLHx4gl8edCG4Brt4JjLG3U67LD1JjNm7b7+pXNS9RHhPDMB0U5hmNivDiyWvNsUZPGv1/VFV/JuprsH1D2/+5DMpaCoZPZqQeoeLs5FcXryDDVxY1HStMQxjpJNDUotM9bSuZDyD03EjGEGOPExZXsgWZfcWimjYbbVvB+5olsEBYlSKEfhZcZyunCRYgyGwgznuKS4Xk6sEDYqPxOyfpyFZhv8NTed0731r9jsM7X/6LkoH5A/Je5jON8yAwjbeGfdL4yyRW5f/On3MCbhVyzO8k6ybrm5Jc1d7RxUgtZ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39850400004)(136003)(396003)(366004)(451199018)(52116002)(6486002)(1076003)(26005)(6506007)(6666004)(6512007)(107886003)(186003)(4744005)(41300700001)(66946007)(66476007)(66556008)(4326008)(8676002)(7416002)(8936002)(5660300002)(86362001)(2906002)(36756003)(316002)(478600001)(921005)(83380400001)(38100700002)(38350700002)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4JvqmstesADRGcqKQDYSmBc/deP9207tey/Q/upFcxNOzhMB1TFJ+wldA2z8?=
 =?us-ascii?Q?GJ+NPJj0DtzgiUazSSreJj7+Zap/ChQIjlYh7i9ej+r0SHKGqPS2GkQ/pAHt?=
 =?us-ascii?Q?rrkyPrTaoCkroed3+wpT9DaBqWS5GXrxRVM6zSOj24yE5Szmjwku2bQ2Tqaf?=
 =?us-ascii?Q?8xhvR2P/Mc5XStyKJm0errjJmqU66o0CPrOfpoXMqanCfxq3n4CvNcdEW+yU?=
 =?us-ascii?Q?ZIyOfsurcRPJittQetAvrrK1xkWa0ABXA04PNla0/S03n+6tS6l+fLGq+/5K?=
 =?us-ascii?Q?fXgWcH3ZxcF35sfAWFHYEAYN3Dm04cz7aIA3lndtrXKJbsoeKaK5utWGl/j5?=
 =?us-ascii?Q?7EDIZ4m4hNIn2B2pcBHTNqlowSO6rQz1q2yTq3nVf0EcUfErADRixqq6xoYH?=
 =?us-ascii?Q?MZmPyJdnAWAhzORoNKI/bCgU3Z7GBaZejgvwopniG9hbEnSukC1ImKQiQH10?=
 =?us-ascii?Q?54HEaNydDISy2Fro1nmwp3BtKTD+d49TxMxqlVDdEyduQ9xwTHcrraaRICUO?=
 =?us-ascii?Q?0TMaoww8C3IyOBq0aTsybHD8vY24/+f/DWFHv9HKHCtdWUvmbCvjaN04FIm3?=
 =?us-ascii?Q?NkQYPciOtlVKLDAV5NIaIUfA/R1baxJ2aC/gA+qf/ahQ48WtN14ikcEcu8vP?=
 =?us-ascii?Q?Hh/ZrB51sPlpec8DsC5tGcaS6We2IzuGUaSA5xUKXL2JDL+UCg0IBIcwiEzV?=
 =?us-ascii?Q?/h2qEYvhDBQrzPEuClG9BD6xsYbuZahS+UDhVHV2jy5Ns0dwTo5P/CPagrGD?=
 =?us-ascii?Q?6hr6u/q5b5blPPgBvSvhN0fnenmhfz0UuezU7caHCkYPSxUsJAkNMqt7BCV5?=
 =?us-ascii?Q?JymTSHeqiv7VJ21qOC2rUmQ5MbKE1/EBgcQ0Wbwra5Gne22OsVh92FNH3TP5?=
 =?us-ascii?Q?9U9d5G7nZP6+C9BQYcgRNT1akHpNKnhe86X3o0akq0xHXrpECfwU6I9Lp9m6?=
 =?us-ascii?Q?msVXmMafscERDv7r8QjWyNYDXGDzn2S6qSP6WEdQK0fDz28EWR5lbrZVvW8S?=
 =?us-ascii?Q?nf6N7QInlCdH5Ov/HUoRTzPCw8Ca0AudjdRbxR5AkMLz5Tg4QqiCCilY+q7w?=
 =?us-ascii?Q?YksKKW6r6dS2sgjK9wXvebL7TBWijzI0LbZjixIXGndY8S1r6cnNGZPVCBdd?=
 =?us-ascii?Q?HYg84v8E6Pgj8G8lAAbEIUkmg24SpbiHnKjrstqoSIVIefVFAaAx0CjS6gD2?=
 =?us-ascii?Q?lr+mpQ15n+MTA1MGywnqjb2AbFV84ErLL1Celyrxt05R8gQlSZsnrnAqXfX/?=
 =?us-ascii?Q?UTaL3hYAiHTHCe57W2mDDARZO8dRSCEY7sLK9D+3qJmzUv0KS+zUYV4lXvkZ?=
 =?us-ascii?Q?wI29Gjj0WlISAMFBPoz7dld6xXU6hSxiec7aLITC3ZgKkOJSltb6A3PmBoyt?=
 =?us-ascii?Q?/Tsm6Zk/XJTs+y70upzL8vSmC9QFsYEDNe/hp2BJFdsoTz1BTws4c5V5r2Eg?=
 =?us-ascii?Q?Zt/bhwWb9H7e002cXIwEToeYG73IalZ10jeYTHWLLEolZiHAHddcD1YPfmQo?=
 =?us-ascii?Q?DuYX7PMN8aZJVOOFBHUhw2kXl4rG4HbLXflN3p1rzndEyrb8om+i7tEJthp6?=
 =?us-ascii?Q?mkgf7yhUII5bKH5X6HaRU8o4F3OtahxX57cKp1il?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e9e2ca-c6bf-4ac8-d9e4-08db212b2d80
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 05:49:13.5817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kkZaT5SAT+VtFLn5GdMdMhP+iOBx7jEePtaccpqasgv/WkwLUSErXAHUKqvpIVncr5ZnpLJApNGFlGDdVflQRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6023
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use i_blockmask() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/gfs2/bmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index eedf6926c652..1c6874b3851a 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -960,7 +960,7 @@ static struct folio *
 gfs2_iomap_get_folio(struct iomap_iter *iter, loff_t pos, unsigned len)
 {
 	struct inode *inode = iter->inode;
-	unsigned int blockmask = i_blocksize(inode) - 1;
+	unsigned int blockmask = i_blockmask(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	unsigned int blocks;
 	struct folio *folio;
-- 
2.25.1

