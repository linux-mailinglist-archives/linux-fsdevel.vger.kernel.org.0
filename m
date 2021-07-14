Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D6C3C854C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 15:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbhGNNbE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 09:31:04 -0400
Received: from mail-eopbgr30125.outbound.protection.outlook.com ([40.107.3.125]:16355
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231478AbhGNNbE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 09:31:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LH8bgp453qXl7BzmaoikQNKujiD8vLWAwJllFP0vpcdfjaIbNrfQdRAoi6x70c7ypwE455fIfntfnbRD+gETjC8wCqoZD044V5cpen/ZAt+UQ94H/9SMLoTEzr4QwOS+YGQN9TiJB2MmTQXYq0Ih06JRxid228ebBpJU/+T8S0ePMjzfm5kxDN/FlrMhmV7qFwdb3LBDCubxLvH5GDEfQ1HyJAX7jmgOs6BhWjbgArsmXCM2NCuzzEPLUQa07qcLZzMJEw57q3OjNuLF00amIFyXaHDMf0aR/TheX+ka2IFVYsDyFjnQn+W4UNE7nOcxtIivHDtxPEPsmD1WMsxkmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDb72DE9scJtrqVZqmCn6C3VEpaCOhYFU5KMjH1OQj4=;
 b=Yu1qqh+Y8XlPsNHm7nKkXOQCb3ddcfcEqj8Y3RjOQ1F6lDSeoxGPq6pi25TAYiT+mjmCIMyLIH7oOk+3npxJHuiKehFTTnVmzwYIVwfUXhHc7sZ8zHxjuPMjmiFqFuW8YU3E3vfsSup85nOrhFIu/E4xWicBcIweZlmzlIwRIZ6WNWBuy8E3YhoFjbF488LHnwzfK57eq4kJEC1AOJr6lV9+FfVGYkfhs14U3vIJ7e2Yr2stxRchng8k2KmiTvuR7deklUMTnbzYfEgYOc1xKu5P3sfsk0UCr22o6Vy+ddDfh9gPiseexfS5hkKIMuPYXOtocVpkKLaDxdN33jdSMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDb72DE9scJtrqVZqmCn6C3VEpaCOhYFU5KMjH1OQj4=;
 b=fp0EHKW1+aWVF7lhwojQsWSF+UDajeoeV8LrnNFE3n4fxruIQ9vpbv+V9khu0G8ZY3WQKBb2qsuIsvRfRUIn6nryVJhp9h2UVFmsYoVN7yTCPS49QEdrGTHZgOoESUEmoHrh2B2EwGx475jFOcVd6vvk3racOSh7FYLpJXl/ciA=
Authentication-Results: ubuntu.com; dkim=none (message not signed)
 header.d=none;ubuntu.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com (2603:10a6:803:114::19)
 by VI1PR08MB2765.eurprd08.prod.outlook.com (2603:10a6:802:18::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Wed, 14 Jul
 2021 13:28:09 +0000
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::c402:b828:df33:5694]) by VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::c402:b828:df33:5694%7]) with mapi id 15.20.4331.021; Wed, 14 Jul 2021
 13:28:09 +0000
From:   Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org
Cc:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mattias Nissler <mnissler@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrei Vagin <avagin@gmail.com>, linux-api@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/2] move_mount: allow to add a mount into an existing group
Date:   Wed, 14 Jul 2021 16:27:53 +0300
Message-Id: <20210714132754.94633-1-ptikhomirov@virtuozzo.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR1P264CA0020.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19f::7) To VE1PR08MB4989.eurprd08.prod.outlook.com
 (2603:10a6:803:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fedora.sw.ru (91.207.170.60) by PR1P264CA0020.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:19f::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 13:28:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3dbb224a-7825-4f8b-77d1-08d946cb3858
X-MS-TrafficTypeDiagnostic: VI1PR08MB2765:
X-LD-Processed: 0bc7f26d-0264-416e-a6fc-8352af79c58f,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB27653E1B8ADB3148B356FAC4B7139@VI1PR08MB2765.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wBFl/J0tf3wwRvm7b6f/duqooJRDzCZGvoFggGVqXycffZI9UpQBHafVov1cR6ZjP8vWrFRad3GkcpJeuxgncQlqW9cxomCHvZhlfyM4c28m2vbenna3tVySLcfLzcHYV65sYJ3jeNtYtNQwrW6SBF1jp0vhpfhvoRBMvWuA6wjhVFxtffWEnhr2pEOfXRo5VAUw79ejwcMjPCDI07P3lNIa5/bKWU8ONKAa74pfKgMgDZEyqRc7+wDcgqIjdMpF4tUavRl7wDtM+w1N7orR50FStofjfFwyq7zaZtFybJS9HNJNqe0lPWzhrDxS1BKTLhLYwYBTFp5OYgVGEGdrV8o1JdPZpsm8aq5f2EDYJ6W4kbfd1MN6mTyE8XwfWE10aox84e/WFpkfv5m4dXFxUROnco0qBmtd4hCrHD+uzJkkJnr4m+hVUa1PMBBAhQrrJTiAWIbO5LRRaYy4XqNs5xKA8MYLUAR1zzxjGtbaVaQTZQyUwrLcbCfcZvnjYTLq6hKj7L7oHsklYVnKsnPDuuFQmVGzHZNJCrx+stPeJMyYrZY0EOuh6jFnGEXCZfpzFyIa9K0/S0HKfGhY8vAkISWCjm0JrCB83wTWXArMNyosxZ9UxNyexb2IBpSCgJg+oYpIOL7b5LnpIaZQ57F4/6Wt8DmFqZsAApjVrm1IL41RvTAyJ7oGDW7WZRGgyaOjIq7M1yVBoy0H3s2l4KAbYb8wbinwLvdVXS5FfJOtR+wurCi7KPxhiNLxGeVI+/HPE7wXyjA4mJ6vB9kLJJjfkOvCXtL2XxPBlp7jGrWHwS6O6e3m6nu+YKATzd3lAb3K
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4989.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(376002)(366004)(396003)(136003)(346002)(6486002)(52116002)(186003)(36756003)(6666004)(5660300002)(66946007)(38350700002)(316002)(8936002)(1076003)(6506007)(956004)(86362001)(66556008)(4326008)(6512007)(2906002)(54906003)(8676002)(83380400001)(2616005)(966005)(478600001)(38100700002)(26005)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ahS5S4hcxpEhw6ysmxG3igvM0YRoGZLz6bCLwRJfTU15FhFPL18GuYbWf6ru?=
 =?us-ascii?Q?I6KUkopwZyKLOMmP/V0qCrLSYraGzYquQ3LhRxQ96zKyyhjZ7Zox9+alalig?=
 =?us-ascii?Q?iSSniMd2UVvBzV0n9D6fnXr5diEdGk2lIQRM0r5McNffPk9qsKZ5jZk1oRg9?=
 =?us-ascii?Q?0biEg7wM9NCKvS4jqegdn5Nr6cXqAgS6IdDp2MOiKQI9LaTjPiltBp3VtPaF?=
 =?us-ascii?Q?EvbX+MpDhHYBNwEbIb8EheZkK3gtOSQMJf6s/yVhqs+iV4G9IqgP+DFFNS0E?=
 =?us-ascii?Q?SoX10c0aYw3z2ME9eE/qUleKWYR/DUGAwRteBtr0Z/C66tD4VDAoBvxoDgBI?=
 =?us-ascii?Q?uss7nBUqTAQlNS87PI10VkQtcSc2TB4QObkLBCxLho/uEjlCLLv4ethbZk3p?=
 =?us-ascii?Q?ZjccgdsLnq81HfFBenhBtgvNL5BKAiVrAXI+9qjILXNUu8FaN/K8bL8Svuaw?=
 =?us-ascii?Q?qbPc3GJQjHlcL+Arlz5M/vpoFqJ93qKVsrwcJFG4LDtuGiGriHdPR4+vJzY+?=
 =?us-ascii?Q?QgkiU109Lpa1pIREB15HRAfzndXdaipG0Pko95VdzWy8Xu0FMkfPFsFqd91t?=
 =?us-ascii?Q?PICJ9ePcUdXrzsa5Jyuq3HsU0EcsDTLg9ekHfTF64MWRm3WuzAUEeTyTJy2O?=
 =?us-ascii?Q?Jnm8fWUuihsgdlUJl6NbsHBt2kLx4av0GS5mZHQD4nAQ88eq/2iYf5EjRl88?=
 =?us-ascii?Q?4t+G34/FFZsNdjLVk6BjdX+dF6t4F0/pMLrOKupkIQDBS01gxnuUusw1SIUz?=
 =?us-ascii?Q?Hxl6Vvbm0NlAoFPcoSn3n8aDwn6UuIMvbNaDb9AX1J7008wffRq1XzGyCUiN?=
 =?us-ascii?Q?JCL7OIKCDGXu6BM3J8Dq9MX6X9ioYY57aUy12t5LAU1nddkbfBikJIouDVsz?=
 =?us-ascii?Q?KQn3UbjRskHscFpA27UGj0wwlBxsZYWNBHlZJjya0Rd16rrADnOGXES20LRu?=
 =?us-ascii?Q?kfB5OoJUShfMVQ8jro1DgG+Lp7h9iS1DMrZtHQaI6wBFr/8+FfARtiy0NCID?=
 =?us-ascii?Q?LPfncdOhmEsqiNBlPdYJqsp5O3zajXkPYZPIW3gmZ+IGWi/9bGdnR+gaarQc?=
 =?us-ascii?Q?DmB0PsIV+BvsHz1phj61tf9jvk+qlXkRVsZtHejyBYeBHuFSGuSjUShNMUdf?=
 =?us-ascii?Q?/OH01z0RI6BVk5C2fIxlkvU59xCd7xvKRdYdM9IgdY6F/kBoNTmWf9JfiYyt?=
 =?us-ascii?Q?3nv0BNYFJcfllyRGDWoSpQKzhfjICuSZw0PyEubClQUCOM9wSwCEXRybx+In?=
 =?us-ascii?Q?LP4i/RUyB37lUsq62Y0ScECCa7gkbcQas8Kyj7y/rmLhx2tbEwthR1jKA30c?=
 =?us-ascii?Q?yElnHDjDCNkPLBG/+Hi4F0UB?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dbb224a-7825-4f8b-77d1-08d946cb3858
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4989.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 13:28:08.9571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FSqcdQz4rwJyaqiHEnuG9KhQFD1gOXfOBam9mjgb0QhfSPf6P+wXC62DTUM2d31D8JtY7UJJMkJLERF+ZLWla/gFqQuwVNVrT49iKWVpZkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2765
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Previously a sharing group (shared and master ids pair) can be only
inherited when mount is created via bindmount. This patch adds an
ability to add an existing private mount into an existing sharing group.

With this functionality one can first create the desired mount tree from
only private mounts (without the need to care about undesired mount
propagation or mount creation order implied by sharing group
dependencies), and next then setup any desired mount sharing between
those mounts in tree as needed.

This allows CRIU to restore any set of mount namespaces, mount trees and
sharing group trees for a container.

We have many issues with restoring mounts in CRIU related to sharing
groups and propagation:
- reverse sharing groups vs mount tree order requires complex mounts
  reordering which mostly implies also using some temporary mounts
(please see https://lkml.org/lkml/2021/3/23/569 for more info)

- mount() syscall creates tons of mounts due to propagation
- mount re-parenting due to propagation
- "Mount Trap" due to propagation
- "Non Uniform" propagation, meaning that with different tricks with
  mount order and temporary children-"lock" mounts one can create mount
  trees which can't be restored without those tricks
(see https://www.linuxplumbersconf.org/event/7/contributions/640/)

With this new functionality we can resolve all the problems with
propagation at once.

Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Mattias Nissler <mnissler@chromium.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Andrei Vagin <avagin@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-api@vger.kernel.org
Cc: lkml <linux-kernel@vger.kernel.org>
Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

---
This is a rework of "mnt: allow to add a mount into an existing group"
patch from Andrei. https://lkml.org/lkml/2017/4/28/20

New do_set_group is similar to do_move_mount, but with some restrictions
of do_move_mount removed and that's why:

1) Allow "cross-namespace" sharing group set. If we allow operation only
with mounts from current+anon mount namespace one would still be able to
setns(from_mntns) + open_tree(from, OPEN_TREE_CLONE) + setns(to_mntns) +
move_mount(anon, to, MOVE_MOUNT_SET_GROUP) to set sharing group to mount
in different mount namespace with source mount. But with this approach
we would need to create anon mount namespace and mount copy each time,
which is just a waste of resources. So instead lets just check if we are
allowed to modify both mount namespaces (which looks equivalent to what
setns-es and open_tree check).

2) Skip checks wich only apply to actually moving mount which we have in
do_move_mount and open_tree. We don't need to check for MNT_LOCKED,
d_is_dir matching, unbindable, nsfs loops and ancestor relation as we
don't move mounts.

Also let's add some new checks:

1) Don't allow to copy sharing from mount with narrow root to a wider
root, so that user does not have power to receive more propagations when
user already has. (proposed by Andrei)

2) Don't allow to copy sharing from mount with locked children for the
same reason, as user shouldn't see propagations to areas overmounted by
locked mounts (if the user could not already do it before sharing
adjustment).

3) If From is private for MOVE_MOUNT_SET_GROUP let's report an error
instead of just doing nothing, so that the user knows that there is
probably some logical usage error. (proposed by Christian)

Security note: there would be no (new) loops in sharing groups tree,
because this new move_mount(MOVE_MOUNT_SET_GROUP) operation only adds
one _private_ mount to one group (without moving between groups), the
sharing groups tree itself stays unchanged after it.

In Virtuozzo we have "mount-v2" implementation, based with the original
kernel patch from Andrei, tested for almost a year and it actually
decreased number of bugs with mounts a lot. One can take a look on the
implementation of sharing group restore in CRIU in "mount-v2" here:

https://src.openvz.org/projects/OVZ/repos/criu/browse/criu/mount-v2.c#898

This works almost the same with current version of patch if we replace
mount(MS_SET_GROUP) to move_mount(MOVE_MOUNT_SET_GROUP), please see
super-draft port for mainstream criu, this at least passes
non-user-namespaced mount tests (zdtm.py --mounts-v2 -f ns).

https://github.com/Snorch/criu/commits/mount-v2-poc

v2: Solve the problem mentioned by Andrei:
- check mnt_root of "to" is in the sub-tree of mnt_root of "from"
- also check "from" has no locked mounts in subroot of "to"
v3: Add checks:
- check paths to be mount root dentries
- return EINVAL if From is private (no sharing to copy)

---
 fs/namespace.c             | 75 +++++++++++++++++++++++++++++++++++++-
 include/uapi/linux/mount.h |  3 +-
 2 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index ab4174a3c802..a7828e695e03 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2684,6 +2684,76 @@ static bool check_for_nsfs_mounts(struct mount *subtree)
 	return ret;
 }
 
+static int do_set_group(struct path *from_path, struct path *to_path)
+{
+	struct mount *from, *to;
+	int err;
+
+	from = real_mount(from_path->mnt);
+	to = real_mount(to_path->mnt);
+
+	namespace_lock();
+
+	err = -EINVAL;
+	/* To and From must be mounted */
+	if (!is_mounted(&from->mnt))
+		goto out;
+	if (!is_mounted(&to->mnt))
+		goto out;
+
+	err = -EPERM;
+	/* We should be allowed to modify mount namespaces of both mounts */
+	if (!ns_capable(from->mnt_ns->user_ns, CAP_SYS_ADMIN))
+		goto out;
+	if (!ns_capable(to->mnt_ns->user_ns, CAP_SYS_ADMIN))
+		goto out;
+
+	err = -EINVAL;
+	/* To and From paths should be mount roots */
+	if (from_path->dentry != from_path->mnt->mnt_root)
+		goto out;
+	if (to_path->dentry != to_path->mnt->mnt_root)
+		goto out;
+
+	/* Setting sharing groups is only allowed across same superblock */
+	if (from->mnt.mnt_sb != to->mnt.mnt_sb)
+		goto out;
+
+	/* From mount root should be wider than To mount root */
+	if (!is_subdir(to->mnt.mnt_root, from->mnt.mnt_root))
+		goto out;
+
+	/* From mount should not have locked children in place of To's root */
+	if (has_locked_children(from, to->mnt.mnt_root))
+		goto out;
+
+	/* Setting sharing groups is only allowed on private mounts */
+	if (IS_MNT_SHARED(to) || IS_MNT_SLAVE(to))
+		goto out;
+
+	/* From should not be private */
+	if (!IS_MNT_SHARED(from) && !IS_MNT_SLAVE(from))
+		goto out;
+
+	if (IS_MNT_SLAVE(from)) {
+		struct mount *m = from->mnt_master;
+
+		list_add(&to->mnt_slave, &m->mnt_slave_list);
+		to->mnt_master = m;
+	}
+
+	if (IS_MNT_SHARED(from)) {
+		to->mnt_group_id = from->mnt_group_id;
+		list_add(&to->mnt_share, &from->mnt_share);
+		set_mnt_shared(to);
+	}
+
+	err = 0;
+out:
+	namespace_unlock();
+	return err;
+}
+
 static int do_move_mount(struct path *old_path, struct path *new_path)
 {
 	struct mnt_namespace *ns;
@@ -3669,7 +3739,10 @@ SYSCALL_DEFINE5(move_mount,
 	if (ret < 0)
 		goto out_to;
 
-	ret = do_move_mount(&from_path, &to_path);
+	if (flags & MOVE_MOUNT_SET_GROUP)
+		ret = do_set_group(&from_path, &to_path);
+	else
+		ret = do_move_mount(&from_path, &to_path);
 
 out_to:
 	path_put(&to_path);
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index dd7a166fdf9c..4d93967f8aea 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -73,7 +73,8 @@
 #define MOVE_MOUNT_T_SYMLINKS		0x00000010 /* Follow symlinks on to path */
 #define MOVE_MOUNT_T_AUTOMOUNTS		0x00000020 /* Follow automounts on to path */
 #define MOVE_MOUNT_T_EMPTY_PATH		0x00000040 /* Empty to path permitted */
-#define MOVE_MOUNT__MASK		0x00000077
+#define MOVE_MOUNT_SET_GROUP		0x00000100 /* Set sharing group instead */
+#define MOVE_MOUNT__MASK		0x00000177
 
 /*
  * fsopen() flags.
-- 
2.31.1

