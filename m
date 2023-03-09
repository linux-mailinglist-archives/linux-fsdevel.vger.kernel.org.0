Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76CF6B2065
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 10:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjCIJnu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 04:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjCIJnk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:43:40 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2104.outbound.protection.outlook.com [40.107.117.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256D1D462D;
        Thu,  9 Mar 2023 01:43:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyn7YCxxuNbOxWA+YYTRV8tYUDLT5HgTfGm7rfviLCvo8YHu1ElfhF+2gYgHGz1kuZVIJvuh1GeCWXKt83foYawjf5GunbgeVW8DS4U5z07fukFMNVjATuN060kg3XoBULOWiyF42qcKtSjwvoP3cZYVfc+N+0tKmr3PIIt3fjvsXThXysOVKwNFpQWWtIzmOF3u6UzC/7jy+j1pY+PSsQ8z45Y9z1uh3ys+pi7Tun5B6q6lWJ96yds8wicqBxHYgB9R9vrTjQE2Q6RmkJ3o6BR+RXTRgjwD0Ha8reeHYPISJ6F2QgmkBruKt1Oq0GHju80rLbnpwBzr9ldhyNZWTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUYza8g2PyCIiC2OrOmKbG3IQTXkQ4xS0l+bQ/UtoeM=;
 b=CxzQ5LIKO/AVNQrWynR4wv8ePw+K/B+Bpj96+a6/YcM8HjJJiDw4InnL/Hk8LL4UIlCCTJH4iK/E3sEM7KSeM+uY5a7nePGNGSsELXIhpsruBj8dMpQoGy4ceuV3TiRxkYxm62AuAANMVXoKiBJ5JIIHc120BzYyyJU0Kcg4bRcFM5LFVbtaa5w9znf+bReHAGj3FV2ZY+vJPI6GIz8OI1h8+ftsXKBnaJw2LRQ9p6Vjisz7ilSm2IsV5iiA6pf3/dNxa/IguTpotqiy9X3n9qDXPqxxxYS/vwGn3L/blsELPk+TnkcnPlJ9HE5oU+gO3qb1OtdrL/krc5DeZM3AVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUYza8g2PyCIiC2OrOmKbG3IQTXkQ4xS0l+bQ/UtoeM=;
 b=KpMPMDOZ9tHyaFfdBYeDIe6tyJnYr2ez2I5X8ZzUQmzCs0GJ30RAdaPPPZQr7kQnhvHC48GnVFlYtWZGGCXyNeA1u83HWFZgWGOjjn3E7svPHYeXKDvkET0/Ps9ZsRHNI4seeWkyFLnqf5tCUX3rHHtWW4pgDmkgba0gDXqOoLXdds8qWmtpeXAGM9cB1Njov7XRffcUoO73g1yGI1GWO4U7u3zEmWtyC7XntYr7w1c5VNWng2yljY35F5gsmqTnpMTkjkQqWM9eDHgkk2tQpRnVe8kD6z6uhKAkkNVIxktpR8xp8kbMBiv4iUvCnsJrn2BuOuNCXJJOlbDwzrABwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com (2603:1096:400:1f5::6)
 by SI2PR06MB5412.apcprd06.prod.outlook.com (2603:1096:4:1ef::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.18; Thu, 9 Mar
 2023 09:43:31 +0000
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::a2c6:4a08:7779:5190]) by TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::a2c6:4a08:7779:5190%2]) with mapi id 15.20.6156.028; Thu, 9 Mar 2023
 09:43:31 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        jefflexu@linux.alibaba.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, rpeterso@redhat.com, agruenba@redhat.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 1/4] fs: add i_blocksize_mask()
Date:   Thu,  9 Mar 2023 17:43:14 +0800
Message-Id: <20230309094317.69773-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0035.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::22)
 To TYZPR06MB5275.apcprd06.prod.outlook.com (2603:1096:400:1f5::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5275:EE_|SI2PR06MB5412:EE_
X-MS-Office365-Filtering-Correlation-Id: ccdfc196-f1b2-4666-7081-08db2082bdd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qae3vB1q5azCwwMFBxFyNfulkS2fKl26dHrPR5EE2x89+PmGv+wkF4/+4aKLws+K7tg8UH2kUAZO771w1fj59D5/YRnvOqbqaNGxw/L9+6R4e9MlwrJ89LG+aO7hP5uPVucjhn9HQVzG7Vd6h1sTMpvYGa7IKcA0GqEqL9yOinjY54lR3g1tQX69gg1Pi00ck9+rrauET6gapdYqqNfoz4PIOKsXCKnpga8DbQZxpv/GOpKGazvOlVAvT5b1YOn8CoWMOLLFS0Vs1alJOdhrJ2tA7KMQ+MQn83aOHkYTfiGl9sb4D1H9XmVZasohnH9srt/IW0HrF2npeyFvyzcLEgPYNUft/Sja1P96GOVSsYR71QkbFBtJZRIGVzwSW3hJO9ZkYN5pfkRcKCQng2voJNcQm2Ti5Qh7HpTwP75UmRR81QjoosxLTVIE1MdfG+LvZUzPAqrcTQEzrTUkTu59KALngE4jJeF0asBpip6l4zlLvWphQvjvLEEOLgdbZUvs5ZJ1H7knJrSAxkroXDaHLnISfO1IphYeyWe0mDtbKi94bL3lPhpMptOweVXd5g9ZwVUW9GVZ8nbsqgXn03rA1zc2RDtPcyAgXSnEwjx88rsperdZf3ZiJYccY5e/8F3wxEYywh4ThQbzpCtYkRFaXGTVRZOtfJOTQaa0wIKoxcPcQdDPHm8Th1a7AP4zywn447BAzuVTD4CXEJHXiUq0q9byEhNehwijGoPn2g76q+0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5275.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(451199018)(107886003)(6666004)(83380400001)(36756003)(478600001)(921005)(38350700002)(316002)(38100700002)(6486002)(2616005)(6512007)(52116002)(6506007)(186003)(26005)(1076003)(5660300002)(4744005)(7416002)(66476007)(66556008)(2906002)(8936002)(41300700001)(8676002)(4326008)(86362001)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jegshxbn02X1nQ9NnM0gp3J6Xyonqyz267OOMRqinh4BkSeL3sTf6HJBFoQR?=
 =?us-ascii?Q?g28Nq5NlTjXow0dveGB5xSz9VCunB/WBFaN0pphNfUfW9+QOgNN4nldxdg7D?=
 =?us-ascii?Q?QMREfd2XUCC3IFhFKaFrSiUOZbAb3i3rNDAchTCFwbV24SswW1UK5wE5nopn?=
 =?us-ascii?Q?BNAiGz2hr9KwxThzquTdnrouRTl0TCfLgdkEFTZ0wBnnCoO8hlKhqK1rAOev?=
 =?us-ascii?Q?7ltEAKcwC+TigMLZHJeXcvNlDQ1RpPPidCu4J5ELguMtYxHqTHRoMZQkcSdi?=
 =?us-ascii?Q?wmFSu+LDSg49LB1Fn5AqmF0v4sq1wMf1tJu5yvFT5V2Sn412oMxFKB1vMrhT?=
 =?us-ascii?Q?Awut0jFKDo5fcbGmaS1D4eER2/O2TruCOHVU7gkssx6qWxpwH7WcTeElKeja?=
 =?us-ascii?Q?6o8zNDtfymrZUIGMHmhxjE+/KO3/UtZfvX+67XdHrmo2zUfZ3ks1OwEQvXdU?=
 =?us-ascii?Q?Q1C59ITLACRUv8pM8aEJUmFqWfKxE/A85CfCxspRupXXPmZNfPG2PqILBsqz?=
 =?us-ascii?Q?lO/6Enjak8gUggluwzbWHXdtUkyPakMRPzoxfqU6SfX1DQtVJgsB8+BV2s56?=
 =?us-ascii?Q?heYKICWrCvEBWUj/AdoFQvcVxsPwayzr27iQoQektPtXPWwVu1JrZC0iLoar?=
 =?us-ascii?Q?tDSVqhV7VhmMqUjANrmoE4+QViNwnKPYWxMUp9nexImyj6+OtaeWxcRgnFHI?=
 =?us-ascii?Q?Wu9/c62rBcyGOzWgZ6jj+yNUz/ToP+ZLa9ouML2AnaCvozxTymQL2aj7EVtl?=
 =?us-ascii?Q?qTTO+ekKCpkxKj4u5Mve3JByPVKxjn9nF3RBTqSPdQsShpXZCqeNjaKo0XWf?=
 =?us-ascii?Q?RJtrg9qdIjxR9k/y+gZdZ9rgTwvDSwO3y2sZ9ZA6ZoZNhtUeBStEI5mFoh2U?=
 =?us-ascii?Q?9CPSAQy+2esQi4JqogFK9RrlsqxDclAhletMVoa0TaNIFMtFv6mtCcddU+D8?=
 =?us-ascii?Q?de6fYhaF2b5FQ4AM929O/mwS1nH7HUx+WFZ6Zf0e5pmC8stsOkesmCF1xKLO?=
 =?us-ascii?Q?Mo73eIzcPGfGQKgyo7LJUG+S0ZiNH6xE5lRamHlvXpctNxsrC1HT6F4cIKH4?=
 =?us-ascii?Q?Vhbq8uSM1k5v94WkE8a1nTJzZesmPJiY12EKS0w+ga05a2P8oG2o9H0fUymr?=
 =?us-ascii?Q?43eWt3AqRkEDbXwJmQbmhelBqBa0YjNP1j5xcsbac9YbaVX1O+v2axGF3GSB?=
 =?us-ascii?Q?uHtHLrYg89VoZuelcMJKSaUWSx6ezrAZvoTN6Vve9NYW0K0vzjIBIESweNA+?=
 =?us-ascii?Q?UFUr8PHW9r9H1YV0zfTWx+KgyrUQ/afUCr+WbnCg7l5ZRavI/0QrMm9vrvr/?=
 =?us-ascii?Q?b2ERtetmSdI9a/nitJ4/7Mv3qq7pEvYRSZlXmTjDm9eZwlfuQVDGkva875ou?=
 =?us-ascii?Q?yireaBY9gj0KH3Ah3u+wcbVUeUxPuJwt0L3+e3dwfAfa0E9ixPRs0HL3gT3g?=
 =?us-ascii?Q?hYBSrMzQAB5yWzUZI1dPOfa3oDN/PSFKfJNyREEHaq1JekyPDjfPuGXdZpJy?=
 =?us-ascii?Q?nIMF6/rkqLHLoj0A42LqL+5uzHoJU1uq13V/cLGA/EotBOlITFqskY8MdmMD?=
 =?us-ascii?Q?WbiCAxhSRdoEr5ZKFV6ofdSTmnx3+7Tzol4eWcbM?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccdfc196-f1b2-4666-7081-08db2082bdd2
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5275.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 09:43:30.8079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yFyq14KB3cuZWCF5cyf54mK1ICs+rCE80rakkE22SpYH+jFpm73e0dq8Ro89rResc+AGFx8Lcowq7SYuTmndCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5412
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce i_blocksize_mask() to simplify code, which replace
(i_blocksize(node) - 1). Like done in commit
93407472a21b("fs: add i_blocksize()").

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 include/linux/fs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index c85916e9f7db..db335bd9c256 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -711,6 +711,11 @@ static inline unsigned int i_blocksize(const struct inode *node)
 	return (1 << node->i_blkbits);
 }
 
+static inline unsigned int i_blocksize_mask(const struct inode *node)
+{
+	return i_blocksize(node) - 1;
+}
+
 static inline int inode_unhashed(struct inode *inode)
 {
 	return hlist_unhashed(&inode->i_hash);
-- 
2.25.1

