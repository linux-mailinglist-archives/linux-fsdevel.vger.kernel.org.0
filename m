Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AFE6B2454
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 13:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjCIMlT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 07:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCIMlS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 07:41:18 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2110.outbound.protection.outlook.com [40.107.117.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BDCE4849;
        Thu,  9 Mar 2023 04:41:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odETv7lDPYNueYF0EnAKbcfUQzcYdBA+BccCukEvJ0kBpHOM+d0+t95BMpeee4ssKLNltnTqgRVBVKjghC1/euOrVLTZAsl8Ig38poUh7I5IDKIDtLyisT66wbGUuEZ/v+rHvqzWj6gfq2FfKHlLjhOZxObHqEGuGACs/Luh8XMi+ce4qSp3gmRGgVNUcbcC7xJ1Q8T3ZlHn4HdVdfGcAmjiZQ8Y0UWhO4e9k74KHT+plen4VMi84Go1Jd699AMgtLf7TgjIE7hyDrxCLZWje9/9MM6eZShtwpImu8I/mC/dnWvIpjzUh71tZZzXEN9Ho5glYp8npU4qsLe6OtWxww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xyp6khKdIkhA5xSLGNeZkhNG4sPGA+gYtVZl2iVCnv8=;
 b=YSqf2sWkvyZFXstIPrZ7IQ35FDo0ZzXBbYbnFbiviS4Lm4krbWsyIM5doOaggz1l3vTkrftYHBrUlNmL/NvPIxNtiS1z3vMAJQBX7jp9jIqHVygvh7OYeSD3Drs/rbCxFidUaiRjcXsmWxunal30cLmO3rU6EOHC5MANxnl52dSfo4osy4THBUXjV3qDQmrsDuJZt6urdxruCimtvGDpjXcpXkbVGLlVFRq4WgBwELkHIu7Ic6wTiq4qnBuCPxsgBlscil0hGoixJtrXUA2U99INjEa1jkDRi5VOS6fMqa7ovatA+9r3WVHqm6u52sSguoCK9nFaS+/X8juTZ/YVRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyp6khKdIkhA5xSLGNeZkhNG4sPGA+gYtVZl2iVCnv8=;
 b=TX5bYM/ZQEqj6ynWAyqFFJLtnxP3cYWT+bvBmtHfmXB/Sa7xlbC0MuCu91miXQfw6o4qoBP7p6owdJSQ84PGuvQMOaa/nMr8891DsEN+ljgGTuFXFPNkuCG8BBdp+xwNYo/lMxEdBgYj1Z2npcv9W7iBeFFArRXh3VIJOJoFa6F3Ddn/DAHLBDAVQtjW0fS/q5QAzGRqs01sEuX/VYy1d485P1CF679jNnMAlbP80ia8DqMfVDP/3si7qLBwEJS1aNrsdeviYA9RR4CrZqe2YBacN5LsnlTae4+qMk1shKUGVkfJfGjfz1V99XM33JuwnGATWqU2Hscx+16hKQyFSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB6054.apcprd06.prod.outlook.com (2603:1096:301:104::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 12:41:09 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 12:41:09 +0000
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
Subject: [PATCH v2 1/5] fs: add i_blockmask()
Date:   Thu,  9 Mar 2023 20:40:31 +0800
Message-Id: <20230309124035.15820-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0006.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::14) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PUZPR06MB6054:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eae045a-6ba2-4a96-7172-08db209b8ee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6P7++5T/2tqGKxda9iuUKw8ulfTUUCg6+UoNEWVIwNSjwA0epc3XEC1YFz9RLh4sSlWci34CCE1ylqMfd5Wv8cewLK3O8QKpg3kW5xKUQXMIPokQVHmwhHNHSr2FTd8oJZlTHA4M83vAhzNQqPgoaWGvOsTblnNSpDrINP/sRffSMe4YIRvKwJvmq4QA7Ojsd18NLMKh0EoyHenKEVZO7+fY9M+3dMA8N/eH5SJ6ez4opLM+wEHZ3HiJ8YrW5tu+l9THAo95XU6iaof+xB+iYasxA2WAlHAqLdZv/oIP0F2MnpbOg3b4WEwLrE7MzB+t1AaPZUlnSz4Ff0QoKY4UVKKwNfbsAOC0XGEslYUmVWbbbGG0rIY+J7VJszha1uEjcW46BB9B3vLAUYYjDm0KTMXKUkBMkI6X+hNQ+tZpkAU3cJgDuEySrz7tVxJL3ADuNfKSgEjb4vITTzsSsJsZua/RfI4MOTeJxFlLvwU74kkH+D0U6oy8H62p/hMjnpspfGvmZ7H/jRRbAMvNzimghS/GxaI6LqX1l07wsSL98kWSDjbzSXCzxmPP/j6C4XMOooyqar24Ao1WvVzYTd2rAOPn+M4aO0XJQCflH0S/uHl/ZurWDrsZ3s8TKSpWHebHiTFJXLMMBe8hlXl5wGiHn72OEhdia6zM8/l1KBq+YFHUz3oTTlvmYmqVXTfWwnHU0l43U5xYaVO6dbOuoFU1v4WxkthZkhKnfb1cpEo7hbI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199018)(4744005)(36756003)(5660300002)(7416002)(83380400001)(107886003)(6666004)(26005)(1076003)(6486002)(2616005)(52116002)(6506007)(6512007)(186003)(66476007)(478600001)(921005)(4326008)(8676002)(66946007)(66556008)(8936002)(41300700001)(86362001)(316002)(38350700002)(38100700002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qwUd1U9/ddEhpB5ym1KhX/c+Jrt5cpwDYPe76437Qh0GFP1W3XGo9N7Jp+7J?=
 =?us-ascii?Q?z8XOi2+403LUHNwtqmHA5tUEmsJUwMX8yjLSfNGiZ9ao6gbpUf9DUDuO/Sak?=
 =?us-ascii?Q?/AbFXwwhUOhsDO8I4jqj1fCZP1DqR3wtDu9UpNR5G1s31KyhrMIPwW29nXmK?=
 =?us-ascii?Q?CAH5nKSM6ghRhTVuVQ7yjxBN9cApwhcORjiYyPf4A6Wpo09xhSh/+XplQDaX?=
 =?us-ascii?Q?/7lkW5yHD8hxhkSOmwF5z7yJ1ezQ1qpBBuc0vzQkXPDKTdR5RVRuDNnMNSYW?=
 =?us-ascii?Q?e5fMSTXoL2dLZntSxXFVEqsLq6QouBPfO5aVmGf5q04fR6NAoFQbw22WAQuS?=
 =?us-ascii?Q?dPrJep0pLV4TlqV3APbH9MDaAqJmfAfjcIeUF0AKGx5MYUOc94knFjcTbLrR?=
 =?us-ascii?Q?BpY9m6dd33yBblVODvBiCbBGAX2eR1XHVk9pbjtpN/gjulLc8pcaTkt1wmE/?=
 =?us-ascii?Q?IpZ+2lFrR3p7IDLvsfunxeBN/vK5WO3S3NyqaTCKzARPIJ0jMoBQR7dW4Bvs?=
 =?us-ascii?Q?XfC6HOtiFthuKBV8dz4tOEOkSH77AnrsXXJxRyyMg4ONhI77vrzbTWGvNni6?=
 =?us-ascii?Q?5JYKauIwacNdaMTbNqRb6WX5FLyOfGPBL3zpGny4TffQafW7Xe57vbrRpb7i?=
 =?us-ascii?Q?1egJQBp1cTW286wP92BSDSSES0wBxVK68iQh+TYH2ifhK/jit8D7g3yS+66l?=
 =?us-ascii?Q?qUHPkbtPDE1fTgCrrMqM+baMTeVxmYMFGQE11UU6scs3NiSah49r951GpYqN?=
 =?us-ascii?Q?mNc0dyfQA2gfE/vJFIQOjFuwTm39Ncbtt6GERbDPdlqgrQGk0+eHEiTyGtmi?=
 =?us-ascii?Q?QTXsbVJ0yVU14o/Hlien5AjdK8z/CwsVCyQZ6xWopCfdV9RE1+hYmjCOivcP?=
 =?us-ascii?Q?yZAFmyKj/4KHUJjB74hK2IUKGPIGOYrmdFDLGlb5yaJuC11GwLX0jk6F3YKY?=
 =?us-ascii?Q?O7zxkv3+dyCyvlXg+5y/agU51wKtlGXRmynLz4K9kSxHY/wMhWDS3cn6TkxH?=
 =?us-ascii?Q?oM+D+nwbPwO0YxGSd/9K/WCzeyXoydYcl4zgng8A3VzXpHc6p2Gibw2ZCcvv?=
 =?us-ascii?Q?Igt/EKLXgs08FBrPoKHJ19D4hlk1xe3m6OyvX+A2v4syhmA/MtX3huAZFDlu?=
 =?us-ascii?Q?NDEaeJxkaIHS2U0P+1ugrx4EgT9zT38+Dzra5TmMYUEdf26LhM0JqBXABp2j?=
 =?us-ascii?Q?01d8ZWJHUGo2PCqBKt8K5gGVKtOMwF/zgEIKVtzX21w9OLu8Stj1zmUXvWbs?=
 =?us-ascii?Q?IC3N0LyUuInxob1V9ABPenQt7HuKzMUK1Uf6/+mbiFJsF7HzxJcfeV43N+6G?=
 =?us-ascii?Q?3LmwYSZwG+V9X6DAGPYfxWhdfdAHutIeh1ioookV/ax2ITMrUuLlqIQKjIGj?=
 =?us-ascii?Q?4g0g8UePAGa4otn58WXE6XM4uR1A2nbKIpXbWjKbBCr0DT/gSDr5c9NtfvVR?=
 =?us-ascii?Q?F0KJHc5jIQXmpgX0C5pA8dDRQSR5fpolU1uBFKDifIkBuQEtHKG72XbpZD+h?=
 =?us-ascii?Q?GXzIiLhhf85vKsFwgjGDDVObDqYOL1ZFIF6WdnRHzhhWNhmlrm/qkL9t61Ui?=
 =?us-ascii?Q?CbrNvqJJgvSEJA+OBOquxBi3z/oSpzkbPsA+rXax?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eae045a-6ba2-4a96-7172-08db209b8ee0
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 12:41:09.4338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hIwsa5dMsMOPNVWk3UVyOvQAp9MVjcVoSIKUNaLd8ql1Zznrw5khsn1CPeaHJtkuSbq3UFTLetoWINaXLzFwnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6054
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce i_blockmask() to simplify code, which replace
(i_blocksize(node) - 1). Like done in commit
93407472a21b("fs: add i_blocksize()").

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
v2:
-convert to i_blockmask()
 include/linux/fs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index c85916e9f7db..17387d465b8b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -711,6 +711,11 @@ static inline unsigned int i_blocksize(const struct inode *node)
 	return (1 << node->i_blkbits);
 }
 
+static inline unsigned int i_blockmask(const struct inode *node)
+{
+	return i_blocksize(node) - 1;
+}
+
 static inline int inode_unhashed(struct inode *inode)
 {
 	return hlist_unhashed(&inode->i_hash);
-- 
2.25.1

