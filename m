Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAD66B207A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 10:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjCIJoq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 04:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjCIJoH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:44:07 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2104.outbound.protection.outlook.com [40.107.117.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FC0EB895;
        Thu,  9 Mar 2023 01:43:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HtCbZeIxuZQ7kgW4cmrm6ijN8dU3RA3sS0sm+J4AzzvKm30o1F43bIdUJLyiaaGahTtWlo+wPzo7NgeASiSBVHA8U2szobdA/s40zm8lfCsL+pKV0Yyl0hKM5Z6r0oVW7hQdbLYQ2Lz0Kqw004wpYFmpoTxuBb3OuMrj/F2rQmZKaxdS9bULF19CgPdEbFkkUYGqu1uf6E1KQQYFAs13gkI57uz/+O7F3afaiGR1jBGlrE1Gim+4XSWaG0UnhgNOKmyAQ9fn8Tb34fcpE+ZzMrhvP/9dzcewAbQmEKFafXNAGuD+0A8aYTB0nJUuOGbFPgVNtNsNYWQAHV/e5KiBdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6ywpp+MaYfcDgiblrRoKLkbtKySkxplHkGKUqIFFfA=;
 b=PRhKcatFPl6JjmSo/ZjX44nKLyU3QclfsTcInv0zneZdv4fV1Z0tQ1lXgSQwHLJ4S4ZQD2TFl8j5Mn3Y4sOMEDH+kFN15cJ0VoFC36qLwhzaacZV4S/1b2N8ahFSniMJeaG+Q9yB+RtRTpRZ3jTybFraxFU0ToDAOXz0RW848cRk1jXiXRwwjuGsvUe23c3CsJuQVyHtrGpatcARbk1gSkBryOm0P5yklMjKz6AEPwqbCBsGMnVMmiA30oI3xVIWFw1Aha0DeF1Tiq4U4WW4bBcz3Ue04JH8DTvKDvnuxo4ecbS2nl8xgmEijOtSeexIuDG/vFVpXwHPuRBTEdKITQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6ywpp+MaYfcDgiblrRoKLkbtKySkxplHkGKUqIFFfA=;
 b=AQDFlzFC7ujy3ZszvqugZ0RXOUbZoHxav3QIxDwcHEE/Y/AFsR7D3a66r6X6Y+4DOQLbH0rtGatGJbbt2Dfte1oii+tR3QbQzem5hbxGP5MfvS3ZSGPvG3gmuqACqjRQQobbl4OtQUuOtBnvtDXNw/ppvRJ1/a+5VEeJcm68LwGCH7+ByIiu0iZyLz+nTdVT9XlXD2ml162/5K35j5OSgcsVu8t1giT2cwNus8K16Kpw1F6Fj5lp0XpBRAnSdrrQ3ClThQoHkWDB4AzyXyhw3keR4ClC9c803zJyLkfShYcF9Ar1ZQfCAYO8DUIVQCxEKT9KOnxJYjrqQzUxIReSbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com (2603:1096:400:1f5::6)
 by SI2PR06MB5412.apcprd06.prod.outlook.com (2603:1096:4:1ef::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.18; Thu, 9 Mar
 2023 09:43:40 +0000
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::a2c6:4a08:7779:5190]) by TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::a2c6:4a08:7779:5190%2]) with mapi id 15.20.6156.028; Thu, 9 Mar 2023
 09:43:40 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        jefflexu@linux.alibaba.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, rpeterso@redhat.com, agruenba@redhat.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 4/4] ext4: convert to use i_blocksize_mask()
Date:   Thu,  9 Mar 2023 17:43:17 +0800
Message-Id: <20230309094317.69773-4-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230309094317.69773-1-frank.li@vivo.com>
References: <20230309094317.69773-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0035.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::22)
 To TYZPR06MB5275.apcprd06.prod.outlook.com (2603:1096:400:1f5::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5275:EE_|SI2PR06MB5412:EE_
X-MS-Office365-Filtering-Correlation-Id: 18824519-4917-42eb-ce3e-08db2082c3b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TaHlsuuOtIbomrEbun33F30ugrEOXJ7z7Q0SY8cVv5MIrgmcws0LK7tyQZFmF3bUwUXeqI7LVKBfYCvaPng0C77rfeutDLn4OyujHQvBwfxkskpriI0FTwFqZq3B3AJ1tc0Alx8pwwE1Ab46fSuk4WcqomTknLdGzQ0J6AAfbpPOXyvZkxfjzFk6QEYXYrgRxtw6VhCjCZGekDqf8rkVJ9bjvu3WIpDaGE84BCGs4UDKNiWMztZyhRM7h49QmC+W5Goxk+KZBvv8pE4Su3V2Aw2gmLNfMIQFo0Ympkre1RT4djoYHS98DQx9DkRGSnDH4z+yRO5aadNfYoELxV3+HknxoEosXEtK332zG8T8rFDqOR1p1lFG/kF9GXvB7XM7eZrH5zeVTfbqYLAnxO8N6e5fjGttoiXZ5B0oo0N9rSFo1XjOATzpboTGwwvJdqG6p2VjBVfx6KWvB7DG2XNS6YFPUAm2kq3ijeTmL78/ydOglM6Qyz4J2Vj6aq9cWqdDTGHtWEf0F+aiIXQk2HTgrkkwfXy/1LXtIwqIvyfu+zrmuDfG1qQIVz6yUllwPHM3Q23nFpqOQ2KSgFft73TbsCavC9J3aU0Xbja40jz76oJK71ItSUY1u3/kS+pKx0iuklIGW9Qz4mShWif9RF2UuOTatV2LlMLm+NVrurURe0t11O/mtVln27yH1MWWlvoJGQoznXJ0C13iofVMz3x61oEoZXyOXBFZWctXNTCv+QI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5275.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(451199018)(107886003)(6666004)(83380400001)(36756003)(478600001)(921005)(38350700002)(316002)(38100700002)(6486002)(2616005)(6512007)(52116002)(6506007)(186003)(26005)(1076003)(5660300002)(4744005)(7416002)(66476007)(66556008)(2906002)(8936002)(41300700001)(8676002)(4326008)(86362001)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dT5YCFQxsInUBwvXpmWXZj9wZoHXHujQhOb8lpLD2Ey+tI7ENdFBD4Qk1aoH?=
 =?us-ascii?Q?s9Yo+ujB/GCFUm0ZueVSgViCGVXJEsvV5KPjzJ7uMoibPWm+ITUo+JKLXuA9?=
 =?us-ascii?Q?YRHMQr9weeA/0x1cFPW41U2EyzdeS1xJ59Kz+dAYs1Y0VwlbLgihpurmOWWI?=
 =?us-ascii?Q?PJwxyRyertu3gwJZVdBgzrlpYP1gBoTygaSgMZ0SIabtawiRzDxq2Y+0Lwo0?=
 =?us-ascii?Q?C0x5CuQRMEecRJWvzN1ZejVyuSoCM8FpRpoDGCIqyZtwX0ucOqWk9JKpND2f?=
 =?us-ascii?Q?Yphz81dvQAz4cDWKXST+iNuqtmhicgXCwyBXNM58lJUz+cJLKB2nnRBVbN4L?=
 =?us-ascii?Q?zT5C0ZTFORSAXHw5IvJZ6t61U4JCXXxYQuLC9PImOjx2FnmQYqpYlWvdmhpJ?=
 =?us-ascii?Q?t1uEOor5n+gcDVuTYnUA42rMnGtkERVBUD5N1RjTFDIsNyJ7cmHK3ROZv6V7?=
 =?us-ascii?Q?IH1Jgp7qwpuE2Q4H508kx+OBXTupuXSG8WYLHB/BedzxRiUw9URpZyaq0WJA?=
 =?us-ascii?Q?mbVoasV5o+S13LPVsp0sTlLbNy1RncpcwLHn062i37CYNwSc9mPbTlXg0XnD?=
 =?us-ascii?Q?nuvNs3hdt7Am+YVzbIT/XtxyS403FG/vkdvWQmbS4HiT05zkwBiftHNsB8ZA?=
 =?us-ascii?Q?K4rUKlGWddzbe8d1AAeydrlrcToE60UO8jpDupqOWYFQwa4meV1Oihz5Cq1Q?=
 =?us-ascii?Q?8dZBg83gjCErAnW4noSsH01OBqzIT4ikAfRg6dO/qkipqdzeidBG6DWboO0m?=
 =?us-ascii?Q?/7O9E1Sj9QSGATj6yPi2aoHNJ3vLw1uWT5dyCwG8bdgPRSj6TV5zcFmnnMlG?=
 =?us-ascii?Q?Rh7FCU/lZciPhKyueWJiqoFd5EquCbDo9adyi4bjZ8zKB9CQ5+HabhKpv2zF?=
 =?us-ascii?Q?m8mwfRJ7gWgga2iIgsqY8sp+pwo2yMdVUbIXkoh1nTYeZ13zGy8e5Qx9yqOn?=
 =?us-ascii?Q?5/YxApa4fY1ms5tUX9wxzsn05ewWzRSbBkvnLe9t+lr5fDYU/y5QBTnnYvzf?=
 =?us-ascii?Q?DhWIZPyHomSjLxwgflmVU5dXsEHCAFijQCyyLaw7P8+dQg8CAgBvGIy9jVBX?=
 =?us-ascii?Q?gMqTlcdKmB2442zAcWIZuo7lQfpzTKYqxfmXEBeWazUsxN8bXgCFuB9QDrT7?=
 =?us-ascii?Q?7vAyODqeHJZWjh+e3O9Q9Yu8bUd5moxjBNN8aj4/gv8hHKQD8oTNh/qn4VP+?=
 =?us-ascii?Q?wmE7LdBcvkTVCzx6PgW5kLjQF3u2mk5Kl6YKlo1i2V9jy5PAK+xXqzpfUJ32?=
 =?us-ascii?Q?j3t3KMzgJFnQc1dx7dtGxeo7RJof4Btzci9x2JfKMJrw6dOXPK4rpbPrf8m7?=
 =?us-ascii?Q?0s+WgTBD16Vhwy8XTy+XeXyPJVhlrdwVS9+xijIou1LIQasyYCFtzYESsT7V?=
 =?us-ascii?Q?46bFIpXGXRx1EPQm5eebe55NSaHgtCYowfl6UlKiEwpHZpzOx1SuqOqMiScs?=
 =?us-ascii?Q?1g52MDJNUcojQo+zBMK7QTkYV3s3G/Du5pc44CyWqoI5h0YROcP8gRTFH5nJ?=
 =?us-ascii?Q?dsVw8SqQW8aWgdDRA3fOWXxA4ZQ4A/VLOhyI8zoMNkNV2+nVmNPgsN8KYF2E?=
 =?us-ascii?Q?B6oLoKkcyXwx3EyEE5FcyKTlCniRUJylsZeKkGh1?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18824519-4917-42eb-ce3e-08db2082c3b0
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5275.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 09:43:40.4663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AlXPPrRhlYwwhInBgPc50XLF92eY/8oke3tOmvR9MAg9qpaBSxwKOfQiIwTbxmoGtdOuEwNvSUeJFKREimDDgA==
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

Use i_blocksize_mask() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d251d705c276..c33f91f3b749 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2218,7 +2218,7 @@ static int mpage_process_page_bufs(struct mpage_da_data *mpd,
 {
 	struct inode *inode = mpd->inode;
 	int err;
-	ext4_lblk_t blocks = (i_size_read(inode) + i_blocksize(inode) - 1)
+	ext4_lblk_t blocks = (i_size_read(inode) + i_blocksize_mask(inode))
 							>> inode->i_blkbits;
 
 	if (ext4_verity_in_progress(inode))
-- 
2.25.1

