Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 461C538257E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 May 2021 09:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbhEQHll (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 May 2021 03:41:41 -0400
Received: from mail-bn7nam10on2055.outbound.protection.outlook.com ([40.107.92.55]:59617
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235357AbhEQHlf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 May 2021 03:41:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffchRFe73SzQZstOEla4qtDSUn8lB4/b4D8wW/yDw+MJb3khtHX8oTqcK3r+hU0xEH5wxikkjz6kXOzP7dSedO5hycWZeKaUd8de21rXqfasuNUzT4Ih9H0Qy/H9btvkVtceExuOEAO0tvv/WBKg0XvMU5uOSJD3CCjOzU6p/7feWFsYxVuwkP/5VLRLGMOXJq0d9SxPSAoF0bYGYqvZJ0bpvOq0+VJ+kK5XHh38Pd5dtuKnrR7MmvfHGNh5Z5sf1xQ549UvNIKYeJypSyfjtfHqUO6BQsRj3CzmW2Ha+ZYB5LcHGXr4ZBpT22ONDkNtOKCy3KULGwhXV9D/2uzpIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p63QmlrIqLy0lHz3U7W7gyM86gQzm39eGs15jDMi/5g=;
 b=Pd7iPJL2nbiMTIrXmO9IUnimh6ibb+sAebRXosYoNxayfQniv1yyFvWdXFOmBN2iW/fatOxdqVxvjOjt3JSQxGwIchqC6jypQJxJdOobHw6oN3X6rOyH4vw2TYdvz5esKCg/kIzv0p98graijYx17sqjdOk7ZwhH/rNTo7R/VbES7J+21fD9biritZs+6rin8cfIcKBffvZosMdv/4gMmcR+VSz7FkXLmmHjclZkVsY7umlupjrlBgZfSwxfvKCjPU+9AnSI89mq3GAaI6N+v3K9cHrkYW0VMM0nK0UZi7LBmtJhwmWdRiMUAy9GkTfKnjl8YZ2rwlVN3HuOyjPSzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p63QmlrIqLy0lHz3U7W7gyM86gQzm39eGs15jDMi/5g=;
 b=GX2ey0/dhEr3/aLYhHC0YwNOxu3CFLY1OzyXx54JxXbFj3WvHDolBh8BGGsWhGfT5JGYANoBAIt2p81ifj+O7BjWWkNjcC0vVaDLF4gYliJx95MYvYZBIsnofxchMUfnDmWbeEupDMCI0M9nmwkI+ihuWqBJCR1LJRmyjNXwc14=
Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4202.namprd11.prod.outlook.com (2603:10b6:5:1df::16)
 by DM6PR11MB3866.namprd11.prod.outlook.com (2603:10b6:5:199::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 07:40:18 +0000
Received: from DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::60c5:cd78:8edd:d274]) by DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::60c5:cd78:8edd:d274%5]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 07:40:17 +0000
From:   qiang.zhang@windriver.com
To:     viro@zeniv.linux.org.uk, axboe@kernel.dk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs: simplify super destroy
Date:   Mon, 17 May 2021 15:41:17 +0800
Message-Id: <20210517074117.7748-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR02CA0128.apcprd02.prod.outlook.com
 (2603:1096:202:16::12) To DM6PR11MB4202.namprd11.prod.outlook.com
 (2603:10b6:5:1df::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpg-core1-vm1.wrs.com (60.247.85.82) by HK2PR02CA0128.apcprd02.prod.outlook.com (2603:1096:202:16::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 17 May 2021 07:40:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80e66a83-7a55-4682-e74a-08d919070418
X-MS-TrafficTypeDiagnostic: DM6PR11MB3866:
X-Microsoft-Antispam-PRVS: <DM6PR11MB3866DF6F1D4D70F48EB4809EFF2D9@DM6PR11MB3866.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:119;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /4jgc766WsqIrsSejW8IqySvjprhbUfMIs/1ohYwjl7sL+UHcIRpXwMf+z+sozM7iVeGVJ/Tqb6/YBCSbn9phV31KosKPA05UX/TO3tnRUvY8EMwOuh5iUhG+0UgNFMy0Zi1pUsfpQFhLAY2jCrHCsxUmWBnlajf9CVubch2zjey7KXtaX8SEcaxBP/9QOAdz5gIdilMAIs5eVbs0qg18Q/RkfWw3Gs/BlCuh8nu06S+hw1TF7Yx1f6HX1owfEzY6znxf/QRjNL9AglrPm4OIfKJlAydUUZ1nJDJhIjWjNODcBoU28Ghb7R8I4bFH0sYvph+heYZY9UOuafW6kUNVXQKu8yQ04uUqvD7WGaA222WzZ0TiHBPKaid2pGQfFJAmY/KbrlB8pOF/je/MjZGi3uI+6uloL8GjteYI5KMfKt+2q67enSpnR7L2TsP1pdmPHQqNLEsIb6MxeVC45+lmfJVkGfaLlNjpdtMn2jQ0tLQeBoWRouQoi3TUbIFNNiG/mcCI/pdcD+SqpDcl1q0ROBCq2sWv3q7WqVc1eIl9o00y1SeIGfZlXtTjWTNORprnCNGqi7fN0qnT0W6PWOexZssLHKfGpO0LyrvjGFtzYYYDJgfrvLvY3qEPQJ4tyHpE+9UFLJpi0Da156H99hrIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4202.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(366004)(39840400004)(396003)(66556008)(4326008)(1076003)(6512007)(6506007)(36756003)(66476007)(52116002)(9686003)(66946007)(956004)(8936002)(5660300002)(8676002)(2906002)(6486002)(478600001)(16526019)(38100700002)(38350700002)(186003)(316002)(2616005)(83380400001)(86362001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?QT7KqFxNvaeuZdd5hAHkyGYZK77D77acYPfrozqcBwJ3Ik3LEymAaBIGgkGF?=
 =?us-ascii?Q?DefO2180O4Tklsr0plFjPP96TZe0ik6yEkhbvZQacQTWmY3RvviAyaA/N0/V?=
 =?us-ascii?Q?LpDspSemGjVKdeoPLHkVpRP4x/DJBU00OsUivuR0kwJf6sPn6RGrLGr0nX0s?=
 =?us-ascii?Q?F1eHWL6TCqm+Z9nbivrD044KQ0PrYQav11FoQxOxMCICXB0UEG9Win1Rh1qO?=
 =?us-ascii?Q?YgJp2Os0J93OflNQAvlNxlTn4v0xm0t37aLsBVNJihAUw4eOEPYfzRJVjYv5?=
 =?us-ascii?Q?aqaQGeD/vQnJEhBwBC9AncjCR/crHBD5jPJ+qxPZPTn9PDhfAqlJCzosXZmm?=
 =?us-ascii?Q?/kzUQFwpmAc/ydDasTAHtA/sCZp5VNY58BR9AIEHV98Odw69oEzCUGAg+j6V?=
 =?us-ascii?Q?tut2TlQQxs1BMqROt3Z1P91VMNOq1MI9lCRZafagfrMbGVKK8/HS0gszS7u+?=
 =?us-ascii?Q?yLJZuKROEiBOvv+xViw5zOLUAAnSbtJTRaNG/QZvum40r2BqJqaUwbiT60XH?=
 =?us-ascii?Q?CopR1wVMktKHFgPkxYY42FTyS5R+OPAtU4Iu/s7L5zbwETQZuh3s95PWrrSg?=
 =?us-ascii?Q?5W2EvwTRo2FYyJH37Ihg1o2L7XtVQG8KPh3ext3/1hBjQdQiBsuBwbxVvhyw?=
 =?us-ascii?Q?+6GgVimhdmV8zodIMfuQ3HxXJndZSFREtybcyH/ggvm9dReB04YOWZhTV7lC?=
 =?us-ascii?Q?y2StYUx68tAo2rwBYX+h+tNVqZp1DpR3+o2+QKS/A6rCMH3qEUBFZDx4Ver0?=
 =?us-ascii?Q?931GzWHBzAQfD7KFBc8yaco5hDTWYwf3zgTc0kztZHBH/JrE7GXx/clpPFnl?=
 =?us-ascii?Q?TKJ2t97qJd0p0D8scz12OzaUEzmt1AYbPwgx7Tg1dljEFP2WgH9axHHGKOdd?=
 =?us-ascii?Q?vFoJrsrF4ZbAiJmQc2nIlwTYY0ESKbTicEGsrE2Lm7i0WC+THqcaMG3JZMNI?=
 =?us-ascii?Q?ntmuHe4Pjx3MqZvzx1YFogxScMIO+cxl+PjRnns+OyIkDLC9xhW5z9IvAR5l?=
 =?us-ascii?Q?jndNdbIX8aAeSbTGPV8OxjiQk3QVLEHSj4cgJrEpkBZBQrrnDpmy/giiqTBF?=
 =?us-ascii?Q?mVnCGMWmhr2l2jUV7WjdQOFQDSPqRj0BtjN6VF5CE/GZP++oYZh0htqTDw5Y?=
 =?us-ascii?Q?aqdV8dOYe7/RGGLTDsd1Yy2AFJQWuvyQTy6nTftRAEUCDtfuA8k536qYCdLZ?=
 =?us-ascii?Q?RCIZQRO0Zt0azjjFKLnBaIj1VcpTiSfKYKwpLWSUY4GZmWd1xuCjFBAPQGuk?=
 =?us-ascii?Q?YOl+vCYJRD4feNfpXT4GXRI6dfrCiXUrEfJkPjx7BAZljHydtU425Csc5B9o?=
 =?us-ascii?Q?qSk2tGTNwhcsT2u9bDLW1nuC?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e66a83-7a55-4682-e74a-08d919070418
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4202.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 07:40:17.5671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s5f+kNJW53KyPuMZ0UiiAbcoEdymYzLqjHDzpixstxXD0ry9kjacqfRrg6ibQ0VXPED4kogVRWtfPtKnTFAKsvfTfTraGxV0on2c7sQVJ0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3866
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

Simplify the super destroy process through queue_rcu_work().

Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 fs/super.c         | 15 +++++----------
 include/linux/fs.h |  3 +--
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 11b7e7213fd1..6b796bbc5ba3 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -156,8 +156,8 @@ static unsigned long super_cache_count(struct shrinker *shrink,
 
 static void destroy_super_work(struct work_struct *work)
 {
-	struct super_block *s = container_of(work, struct super_block,
-							destroy_work);
+	struct super_block *s = container_of(to_rcu_work(work), struct super_block,
+							rcu_work);
 	int i;
 
 	for (i = 0; i < SB_FREEZE_LEVELS; i++)
@@ -165,12 +165,6 @@ static void destroy_super_work(struct work_struct *work)
 	kfree(s);
 }
 
-static void destroy_super_rcu(struct rcu_head *head)
-{
-	struct super_block *s = container_of(head, struct super_block, rcu);
-	INIT_WORK(&s->destroy_work, destroy_super_work);
-	schedule_work(&s->destroy_work);
-}
 
 /* Free a superblock that has never been seen by anyone */
 static void destroy_unused_super(struct super_block *s)
@@ -185,7 +179,7 @@ static void destroy_unused_super(struct super_block *s)
 	kfree(s->s_subtype);
 	free_prealloced_shrinker(&s->s_shrink);
 	/* no delays needed */
-	destroy_super_work(&s->destroy_work);
+	destroy_super_work(&s->rcu_work.work);
 }
 
 /**
@@ -249,6 +243,7 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	spin_lock_init(&s->s_inode_list_lock);
 	INIT_LIST_HEAD(&s->s_inodes_wb);
 	spin_lock_init(&s->s_inode_wblist_lock);
+	INIT_RCU_WORK(&s->rcu_work, destroy_super_work);
 
 	s->s_count = 1;
 	atomic_set(&s->s_active, 1);
@@ -296,7 +291,7 @@ static void __put_super(struct super_block *s)
 		fscrypt_sb_free(s);
 		put_user_ns(s->s_user_ns);
 		kfree(s->s_subtype);
-		call_rcu(&s->rcu, destroy_super_rcu);
+		queue_rcu_work(system_wq, &s->rcu_work);
 	}
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c3c88fdb9b2a..2fe2b4d67af2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1534,8 +1534,7 @@ struct super_block {
 	 */
 	struct list_lru		s_dentry_lru;
 	struct list_lru		s_inode_lru;
-	struct rcu_head		rcu;
-	struct work_struct	destroy_work;
+	struct rcu_work         rcu_work;
 
 	struct mutex		s_sync_lock;	/* sync serialisation lock */
 
-- 
2.17.1

