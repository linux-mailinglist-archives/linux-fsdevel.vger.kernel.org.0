Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4646D38FB47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 08:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhEYG4o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 02:56:44 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:26206 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230366AbhEYG4o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 02:56:44 -0400
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14P6rXj2017384;
        Mon, 24 May 2021 23:55:14 -0700
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2044.outbound.protection.outlook.com [104.47.57.44])
        by mx0a-0064b401.pphosted.com with ESMTP id 38rr6yr42j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 May 2021 23:55:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTVup5bs+NWT16GQFGOkYvLZUD76Q6MZut7tnwPGG76x1SnBbJpnYzXbuXpPTnrABMTuBsT66qlqvErIVuB5amZpT5FLqeviMvnsxpzoUCasa6NzGASgdhSugbVUtFnKxaXDhyEoC2aW5Im4rY09X9ugiGgGbrJoZdYSbzbGPW7hz4U8pk1I3ARRI2tScJRlTu9HBV/8oZ4urgghf8BGR4seXxqbaTqnCPqWWUs6NpmKdalmCp7u2G+KMDHitlfR8GRavarIgseeCbPypgOl7H10y/2Tf8CMGcN6vogsiV4MO5X+0jAKIc69BsVyaOiOsKV+7fo0Knu0GTpEPF54rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmkOwP5FK6W5EMD3n/2XS8eJR0O6goBdiRGieloYMTU=;
 b=l6vzzVlgm85XbVfMc7WlC2fw3ko0ieLhBX+K4+b8/xnJ16DWDUEmtE4lonmHB43KIwJU9+JZQ8Tv9SDC5Z16nUlg3RAng611Lm7wMW3J4oAbQIxHMcKolk6JPQQC9FYyzE+jjN+/XjwddvH91AZAvYviQE87pvFdjx9yPYUm8ppFFa+tQuzDrHgkezHNOtRFOO6csxmDgsaLSemtCSWZsGn/xGsnHyj3GXLRu+z7fgO3hW8lBkG9IloiD8Vxi98yXNjeV7f5aaPZjffm7Dk5DDcVxEE6WUJy4R2Rmq3TrfFzPR5viwImCU+i9K3PpkGoKi5w1uTL5v3eQeuUce8BRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmkOwP5FK6W5EMD3n/2XS8eJR0O6goBdiRGieloYMTU=;
 b=HdTv5UkZruEHqHuAHX5fQMdNDWoQ7ii6rU5P5X7fXjUvOYm/APw5J8kmTtr4dOD27dUpxhijuT4px/4d5p4/b8Qp/KeMoj/O4N4C9iI++d/P0rlMYpxZNao6fneUco5XltxHF2PcLU82UeOxk93IYo8dbr3f6ysRV9jZ7BI85RQ=
Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4202.namprd11.prod.outlook.com (2603:10b6:5:1df::16)
 by DM6PR11MB2987.namprd11.prod.outlook.com (2603:10b6:5:65::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Tue, 25 May
 2021 06:55:11 +0000
Received: from DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::3590:5f5:9e9e:ed18]) by DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::3590:5f5:9e9e:ed18%7]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 06:55:11 +0000
From:   qiang.zhang@windriver.com
To:     viro@zeniv.linux.org.uk, akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/super: simplify superblock destroy action
Date:   Tue, 25 May 2021 14:55:20 +0800
Message-Id: <20210525065520.23596-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: SJ0PR05CA0067.namprd05.prod.outlook.com
 (2603:10b6:a03:332::12) To DM6PR11MB4202.namprd11.prod.outlook.com
 (2603:10b6:5:1df::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qzhang2-d1.wrs.com (60.247.85.82) by SJ0PR05CA0067.namprd05.prod.outlook.com (2603:10b6:a03:332::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.11 via Frontend Transport; Tue, 25 May 2021 06:55:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 795805bb-8fd4-4fc4-442b-08d91f4a0a0b
X-MS-TrafficTypeDiagnostic: DM6PR11MB2987:
X-Microsoft-Antispam-PRVS: <DM6PR11MB298749F5FE971007647485F7FF259@DM6PR11MB2987.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:94;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qq33g7SI/lUxNThrgQVz4PN3WOzNW8XewzARZjnwWKK0m3YmKxMmQL03Q+Yxzo5eUXVd+krCMKc17Ef/JbIouirppUNRe+gpJi2YxVt2QsCXPGPU8B5tkLcqytvaEQUqTp+3nqMXkVdP1qiKp2q+6XpKEOT9uuaJilzBplEti1Mv4gltvzxAD5PjLpsqLkkzdSaIrfOt3KpZSmLjYhLjT4+UmrUznv/+ufMMaVFoWjBq5ItabnGyZM4sEkNlYhhy+/Z1Xo1iGOwwVxcRvFJ0b6c11InnG7K0d4ROT9IoUqOfLL2QKh4Gp312vOWaq5gvv8/AN+J8g9WRmaYUTX32tFznRahk59E4n+HAkVBye4xGhOZ3CxEvNID/GDxlQZEv2vvAb6FMDXg/QYw7gEwYfjokmiR2BCT20RThsZW9gI913nmBN/FdpmgCKVHBgXjzJYENh7l4enTVfWyLw+s/+I2jPRqVHl6bpNwoqiQhwgtcdmxz+qFZj1mEQ/R4yMohxXRdI3j4nZvXBFuJBh4FI1CE7ddYFzHZDb27O0g40EmAqkreH+3ajhRJ6rd6siru/FW8yj5hlRMdUk3OgQsGwkqu0k6zYNkUMnkCaeJfMbW1pNxDecU6fyaZRBfcvHtNvLl/iz2r1ktYCRwcyWwxwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4202.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(376002)(346002)(39850400004)(86362001)(2906002)(38100700002)(38350700002)(66556008)(8936002)(5660300002)(36756003)(6666004)(26005)(186003)(16526019)(956004)(2616005)(66946007)(66476007)(1076003)(478600001)(52116002)(6506007)(6512007)(9686003)(6486002)(4326008)(316002)(8676002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1TTHjp94JvXpRGHC96iOc7IM4aEI9PHZ4nyA8+lslJVe9ewbDVkpjh5XrZjO?=
 =?us-ascii?Q?wZMFKLpYkx4kZrvQhd2lIFcgtkBqhK6SwX6L14gfGIT7jBMKLwkTqXrwj55m?=
 =?us-ascii?Q?ATlAB5E4nk6pRVTrGWwSDACJTzr3WhFa6WScyFrR8RNcVFAAy53N7ie+z0OB?=
 =?us-ascii?Q?1kKTpqDjJOmxeip42skNxvn4NRCaacerbpbv+hILO6KQ3fl7V+6v7it9a2mT?=
 =?us-ascii?Q?LiknRM2ci+rySlTzomPl52/WxQHnlyYMtMamSaqCzW1IdOEugOgX++TCYG7e?=
 =?us-ascii?Q?JWBCF3oTgeehB4iEJef3AIebPQP7bDmyb+97iR49N0/U6P3dJEp4PK4A7FA7?=
 =?us-ascii?Q?nJ/zJ3PfVe+QJZkoc5XPtAcshKx/S9hJAIpz49t419s85l0+66bsd1K9TFV2?=
 =?us-ascii?Q?tkrWnwYbA0tyJHC6OIbmcbkmvITxWUEqM8zVm2J8MHrK5dUAxBUElbjKkkin?=
 =?us-ascii?Q?FBJTtsooMIm7PgV+PXL7X4nQuUzPkav646ZiWCWxnw8hQqNIFkjqoq64RqFJ?=
 =?us-ascii?Q?+aNDbwPUBTnatxJH8JAL3mRT5NmziVQInVUND6WhMzHuasMV4gRqVw8sYRdw?=
 =?us-ascii?Q?yMUXBHYd1zq7I633eJBORulFEk1ezscHHZL3eWRRAf+aMtO8nSwpW45Sh3M1?=
 =?us-ascii?Q?tbFb5d4UIM1uWP4zyOayEbkcFIPWapW3T/0Y6vfzncvpNKBQqLaiJrtnBYA5?=
 =?us-ascii?Q?01OfxiZ5jMSWncBs3a7WlpGt49AMqtiEAOrASElC6DjE8hB4H/L1wdhpMRBu?=
 =?us-ascii?Q?FD+/MbkQT4dgoRV66L4tOtMW2Vf1RZpwA2BzUNxJODcOCo04f4WTgN8psqcz?=
 =?us-ascii?Q?4qE5pmAhpWj3IxRYIw0dAzm3mqK/6yj/kHV6UmPJ14l59SYC6yOZHf4p8o1V?=
 =?us-ascii?Q?YKZrTZpl4bwdIUU1NGYCr0PCn3wX06w6O+O0hGsEPSyQb1eUW1oGtyhQ3MuG?=
 =?us-ascii?Q?uTG8XGcdbC+j+jEkazyU9mjlIcZ0kngWZinDbw1mt5UZrMDc7BNs4VK5on8h?=
 =?us-ascii?Q?62oFeYUCbGyeXsrqa0p3n+rG9KpsFrMiZsTV1zkRXrazQQy2DTnirV/2ZdYm?=
 =?us-ascii?Q?w2YDnZdz8W3srEaudN8nzfow/paq0FbrsvEFAkAlexvNgsZCb+B5eVarkOrh?=
 =?us-ascii?Q?BZLyZstGyCNI5N9o8kK0y80bNqRjNC+swxhk7H69e7IGasYVpEDDYB9ckjBx?=
 =?us-ascii?Q?UmDNcjOzhPGmgzEpNu6IF+3GbD5cgpW4J7A5WMVrJEUfi9dxgmySFnNd3niG?=
 =?us-ascii?Q?kuKl2nzLV4uMqybaXCxxOpdiwzgRy8e3/PobjJHysM59hn8dFFciTkWavZNy?=
 =?us-ascii?Q?66PZ4d/D0igQQIJd3+/SjKLQ?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 795805bb-8fd4-4fc4-442b-08d91f4a0a0b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4202.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 06:55:11.0155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uOmo8sXtgtvssG6kOlOZcC5954FxHxz6nGOKrLhSsLNRUtgBK5SeHbiPs8wWCsibqo7egco0FH7sOU1FGlZHAgdlPfFsX8UiPalLU3VzXmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2987
X-Proofpoint-ORIG-GUID: f28U2bsMEr7gG0vxz5DzBTghTStQBAE-
X-Proofpoint-GUID: f28U2bsMEr7gG0vxz5DzBTghTStQBAE-
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-25_03:2021-05-24,2021-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 clxscore=1011 malwarescore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105250047
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

The superblock is freed through call_rcu() and schedule_work(),
these two steps can be replaced by queue_rcu_work().

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

