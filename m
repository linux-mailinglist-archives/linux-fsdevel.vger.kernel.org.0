Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CE973D5C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 04:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjFZCW1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Jun 2023 22:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjFZCW0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Jun 2023 22:22:26 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2120.outbound.protection.outlook.com [40.107.117.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF6918D;
        Sun, 25 Jun 2023 19:22:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ud0KCepAa2AAhRzEOJKS7KaM5Gb6UHvkwugk7lnZBLDSK3d5Mw2s3tk/GCz9fxCLuD6df8eWu+IDpDSSckjiaS6bS7X4KlsdDqaKQEz3P2vQWN+5NtjBBj1ggkZhMKGc7HfBXcscdhQsBHQFydcEfsPmVUbi6cavRmIRifr+b6mWZl5HUczrySDL3N8KvnkyCNgyUP104sQ/z90/XaqC71gvKFjN6Qb1AsnS4lYzQIKppZ0q2X9e9ZkwiuSUHx2JdIqu+XEamQC8lSrz4aqUc5kWTSWJ46CMRw7eO0c8JU0PQ3Mv7SpCrnZB1B36TePGv1Mdvyt38EtfVvZxLe0BVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1VZXuA5FY4aP11+wbi0TJZvIsm2JQmjpPOm1lMiyjI=;
 b=QvTDy9n5Qrbztr697ZXBsPEq196xUjesQytYV2nWMYBmxFEZH6KH1+TJbrot52SsXfWkU7bdkIPVPJZiVhLTd+grvUp0r/cbwp7WJJ/Zw/+BGahwhfFm8Rkw1/xmyNrJqNqhy1mURrifA6gQXKnU+Ew9RgWEO6Dhfyygm9hZw1p/knFIgbM1snibq8di4SSa4+m/xq5sbu0/GKJ0JrYmwfBj8oZPVZjrV9IcufLyNsw8aF/imTv/5FLxYuxoVZv+5+gcMpQcgjU0xI93kHZcO4KjmaAMifRvFU8KueLBhvJ825YHIdLkHL0UBs7fllIkCGS5A1VvRP//ZuY6FM7Rsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1VZXuA5FY4aP11+wbi0TJZvIsm2JQmjpPOm1lMiyjI=;
 b=pJPSISTfERgBHhZMEq+CRzow+WCTcZymkb8mZFO8ycN9hoxCsVINW9uMWy+x+wUccsJTB7/WtAncQHDdSs2IrELsQusjdCG0Wd3adkZKv/zarFeUopN+kg4E/J2ArUo8gGleJH0HHWSKb0VZl+yeXIc3FNtYlyasHpZ6pDiIkm8C4+6ROs6ME46Xb7Gekyj21J2S6KXjKwyxfdRAXqoIV/qxhgXqrLKXl1dUG3Tbfxc1/5dqXLgxkOkyIbMw+th9XSgv8N9Hdz7VTsosTNAhp4JTc7M5PdMIt6URLCf3nCGSmzDU/sADVY1T09VepN98tN7zI2F3Djp4ul7q45ytwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by TYZPR06MB6215.apcprd06.prod.outlook.com (2603:1096:400:33d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Mon, 26 Jun
 2023 02:22:21 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e%6]) with mapi id 15.20.6521.023; Mon, 26 Jun 2023
 02:22:21 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, luhongfei@vivo.com
Subject: [PATCH] fs: iomap: replace the ternary conditional operator with max_t()
Date:   Mon, 26 Jun 2023 10:22:12 +0800
Message-Id: <20230626022212.30297-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0073.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::18) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|TYZPR06MB6215:EE_
X-MS-Office365-Filtering-Correlation-Id: 59a5cb2c-51ef-4512-36e9-08db75ec2bf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rQnW5s3s3eqF6eXYojZ966ddSjDSsQ4fX0S0awi2r2KuNsO/FioLUNyOO31BeIv+vx0/siU7Wk0GC8wPrSydonY7nFTHFfSCUDVY4iT11nvL+Xrp6LHYtTyvGLlbI0J5icii02KDGsA3ge+jiVhS8x3eHVuWR8JW5y28TIORN6JT3DEk77S4VezSRtOH6aRvyFsl/W+q4YeTDgB4wbFzOrIudNsN6h+vR2gXksEbELIhg7837I37HQ7Z8a4+oWRKhBOF/1uAY9M8mPDYS0ZeQ7igp0ecCY9nihOMdiBqX1jgcTnW9Bi1fK/+Mx8NHDgri+9gXUz/boSqzFZebV2FjPxF/t3IoIY57S9aZiAOuAMKAZ6oTAT9fg16RxtgucssblOmlIS5GHpA9ZIucl7vzd5ho4NJafN06wOIuIC1s81rxQfPwYtROZZ2K2DVZeaVmRHfGoP/uDvXXx+WrIrpSPROb/KQy+WP2Koy5PaC5Cwv5EUQEGdUtH//GMCZZ/QNZSI8IShu8byyHv9jO/ua8HZbegMw3X9IwsVqHdO8QAcciO0clC2UK3D04Y1E6cFUemepi9L4pDr5EhmtDhvZ6+GnoOd3XO3rwOSXa8QRHjAdSMxNzBy+EsSF6wVvDIXx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(136003)(346002)(396003)(376002)(366004)(451199021)(8676002)(8936002)(66556008)(66946007)(41300700001)(316002)(66476007)(4326008)(6506007)(26005)(6512007)(1076003)(186003)(107886003)(2616005)(478600001)(110136005)(6666004)(52116002)(6486002)(2906002)(4744005)(5660300002)(38350700002)(38100700002)(36756003)(86362001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?opzszIhSluMuDS1yygl2L+OWslmMcscICaSckKS24DMyfz9q3h1etlFyCo3/?=
 =?us-ascii?Q?7FG3ei7X2uFIQwZKyj4BGpl+vkWRnxKosqcNRPG72ASGne/7aGLIf4zE2jfj?=
 =?us-ascii?Q?pUzScd1fOf00EiPM1rvBa0I1lVDQwqAWsRSF+1/vJTVt9yIaMprk3zGoNial?=
 =?us-ascii?Q?VB4jDadKjKA4S46FGHYbxrPwkzc0dqYrS/WFpBwkrV2lNSA8iZyR1n2PV+Vl?=
 =?us-ascii?Q?dbZU9Hx39zSIVYGW9hLVFf3bjbRpowSNVyrKcZhNZrSC+5T1UhbRhpIcje+K?=
 =?us-ascii?Q?XlckC8AT/tuDxxcKBVWxyeXSzwy9HMyjEXNP7TdXhFnF4xzQ2rv5WeK9Qnnz?=
 =?us-ascii?Q?V/NzYIfr1R4tezOM38+9GRBhgYvn8iKF54TkITKv/e2dM0AP3f1NOEpQyedX?=
 =?us-ascii?Q?2iPplNZEd10WKxIWYC0v4La0UPj4vdpSkfnckjGQD1w3Li94AZ53scNA9Wh2?=
 =?us-ascii?Q?Uar3GXtlpyZq/zz8hqKiBCFKN09f1NiUKACaX7PYlwZctSmvULocLp8qU5ZP?=
 =?us-ascii?Q?lfoBoFbOZ7+QRs7jQou4qTbMhpjclAgvtJzTZl0ZCZF0QVjJ5M5dsHSjnW99?=
 =?us-ascii?Q?MwUsNDCnhHKz9HhuMuzkRLCkk8nMqUJbtlWsNq/ptzkvgqLeHZymJxzfUxYl?=
 =?us-ascii?Q?xLkWUtZ0/UzC31h0n9EaHiN5g5BTmNxAfPgxfmna8VHYFohAuZfHBVWp922K?=
 =?us-ascii?Q?FgbBtOpztkgPLJYCl7N8M0QWxdh9jeGMtMRd36PI+kQafVLPj7VMy3Px2zZd?=
 =?us-ascii?Q?kDWh/h3d4wBgQfuMc/Y96eFxrL8o30oOosrisafdXf4sLFsPiz+9t9+2ocFt?=
 =?us-ascii?Q?2GUCVeWgoV0TYAzmR9zPmiWC7KlkXYBU29M9NQM0blX95yZ/ILA7LDtWM6//?=
 =?us-ascii?Q?dOCIvjYD6429zoswsNyb5y0ycfc3VEmsMYVqCI+YrYeFnutQomp+RvaL4T2q?=
 =?us-ascii?Q?t/bAopijd/6dLbeC2YZUT+RrJ6SCQzGTAUD2J7/L3tMHcgydo9U+vkCNFtZc?=
 =?us-ascii?Q?V7nyBJ1VIrmfNtjshn+LJKJkvaPNqU61SOrz7k9TWq0miMPmQUS11ezDQ6lR?=
 =?us-ascii?Q?eJL9AD66UeK5q0pYTrGJiH+ZGC6JSDjTE8pdsaEOTUlV6pQmT6nVQypTaYdU?=
 =?us-ascii?Q?T/491YiOcpgY9FUgZAaQj4EYqkiCw3xOHv4XPSL6kG2UtL+HX4AiS3iGQjnx?=
 =?us-ascii?Q?kQUk811iIClM/yKSW2yx0FHNORJy1qrNaVkVpByig0GeRpU1n9OhE0WMmJci?=
 =?us-ascii?Q?43d+A9p4uDSWSfrbmMWHxnDqCzhVyY7+apXJtl8Prw8/hvooZuI1dAoAaKbd?=
 =?us-ascii?Q?sgsBjQLgCxu78S92PQKXHsh9S9p1U2m3+T3ncCyj24w/g4oBhWzTnLF8iwfL?=
 =?us-ascii?Q?GzDfLLVCRUXWBUr9YmuGr+2Qiyb0DQcaXwjv5aHNwb2kTAmPP/WmxD5g6efr?=
 =?us-ascii?Q?kI+gUTKU/P1nO8vUSKn5RCLCys6JVE03eMPH1aWh4nSXhG4HeffWHWQjKR28?=
 =?us-ascii?Q?/sleuoZPl55Ui8gBOILnoIlXJqcsS37+gKOyi/R37oUpdd+b1ilbmAPEoDxf?=
 =?us-ascii?Q?HlDi5cBcOSomRuBM8IXmaLrAuz2UJtfmt0BPyBnV?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a5cb2c-51ef-4512-36e9-08db75ec2bf6
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 02:22:21.5700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S6MMS7ms5UfbzlmA4CkgUSQFOmzfcNyfbRf/MLbLQC1cpcVFs1QWPcyxYq9Jx4A6SxRkd+3IZ1NayDUYVH70EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6215
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It would be better to replace the traditional ternary conditional
operator with max_t() in iomap_iter

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
---
 fs/iomap/iter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
index 79a0614eaab7..528fd196c50b 100644
--- a/fs/iomap/iter.c
+++ b/fs/iomap/iter.c
@@ -77,7 +77,7 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 
 	if (iter->iomap.length && ops->iomap_end) {
 		ret = ops->iomap_end(iter->inode, iter->pos, iomap_length(iter),
-				iter->processed > 0 ? iter->processed : 0,
+				max_t(s64, iter->processed, 0),
 				iter->flags, &iter->iomap);
 		if (ret < 0 && !iter->processed)
 			return ret;
-- 
2.39.0

