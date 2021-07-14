Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C45B03C8868
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 18:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbhGNQOS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 12:14:18 -0400
Received: from mail-eopbgr70109.outbound.protection.outlook.com ([40.107.7.109]:47746
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231919AbhGNQOP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 12:14:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tqj0GcPBQXybexjqMYBte6Vq9vqQbOdX00UbrdVDMmWKB2Kl0Q4w60yRcyrzXY4lmcei1ghlJrB56mLK3CrfC+GfiyMnr9viJrsCujnQvvTYpwy4cY7LXipfra+I04jhf09TAjHp92NJoW0QnR3LU6LqQ+TsdICWXp2iWF7dhcvyBEI0j7j2k8mP5LnAaWviV7UE3HUVEVXvURxE81UDnfhOwO+729pKE43qxmvb6f58L7W1jsCMp/AMmdGBm7MHUK7O7s9IdFgEVKSUIqeG2Sz9cK/7u9Moc9Uig65jMDJ6TMDOdsOv+B0U/d1NyFoy47VDojp7H18ZC9ldDvTT4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nSYwDNS+/5G8ExMeeHKnPnG3UUt8OG+PdEZ46phabA=;
 b=jsXf28bQpwZs7pSuS/LhQRODPmBDf+tq9uaiE0qGtXoxzGSIxAO82LUoXfO9umQGIHGLqxj/goVWAcgKHJ7gwSxdejLIEXRnqyASQF0EhgU80IO2+jXkbcqJ1B1v2HPqgh3ClZwxVG1Btudl5jn0GkDWNbbO8tiEBNdMwo2BK+bPjte+XCt3uNYK367QxwY2oUBGl01DL/AT8RXxzqDiXbgXsy8gTCZY/oNtNEBp4sDh9iBnAFyENzFgN83o5O6KUPhRZY8fbWAbMqVnFcWhQ9PQFvs0BwajP6ye94DRWn3QtRxg0Z6wlIkCJJ+SiCCkZqe+9PuhjmbuNS2fIURZjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nSYwDNS+/5G8ExMeeHKnPnG3UUt8OG+PdEZ46phabA=;
 b=sLQODg8F0oadNe2h42ixW23yEB+8lV2sRoOTGXF/KbDD86FH2VsyQAMByrkmoh/L8GHOQWLSLJC+btoSzxn4yjuzIEavg4P0ktl/CJIHpYmrjLNvpkJ7y1tJwlIwdLJ5I2mriT2hyXoToO44LkcHhU66Q1LXi8pqY/sE4NcJUEI=
Authentication-Results: ubuntu.com; dkim=none (message not signed)
 header.d=none;ubuntu.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com (2603:10a6:803:114::19)
 by VI1PR0801MB2111.eurprd08.prod.outlook.com (2603:10a6:800:8d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Wed, 14 Jul
 2021 16:11:20 +0000
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::c402:b828:df33:5694]) by VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::c402:b828:df33:5694%7]) with mapi id 15.20.4331.021; Wed, 14 Jul 2021
 16:11:20 +0000
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
Subject: [PATCH v4 1/2] move_mount: allow to add a mount into an existing group
Date:   Wed, 14 Jul 2021 19:10:55 +0300
Message-Id: <20210714161056.105591-1-ptikhomirov@virtuozzo.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0025.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::30) To VE1PR08MB4989.eurprd08.prod.outlook.com
 (2603:10a6:803:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fedora.sw.ru (91.207.170.60) by AM8P251CA0025.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:21b::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 16:11:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63b4bead-61aa-48ad-4b2a-08d946e204c3
X-MS-TrafficTypeDiagnostic: VI1PR0801MB2111:
X-LD-Processed: 0bc7f26d-0264-416e-a6fc-8352af79c58f,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0801MB2111957F038C31C3D727D988B7139@VI1PR0801MB2111.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q6//fcNnsT7ixpMFf9qaDkVaVjAzQxLv5pk4c+BDkbE7Eq371NBYJ8YjBtoDe5eWWlnoJH+j3lLFzRLESPSqyyLU8ghdfFlQ680AbnFYygvfiWI6SxBkgkIWaFFdaY2dQiax+/blMD47KGK5/JO0uU5HfqJiekVzyTKldbzfSrBP1kVRp3joimnqjScxLMtsQDvLulWM4q71XGANjCrbNi5pZ12Q8KtC+d+aACV8yhUWoEDxa82P0FyWzfN2J1pp04biU3T7c6ly/srfs9Rb6KgxV/F99+OdQHaFSWZmb+skvSfc5a6doVTfV055UUSTVD/Rf5fxvmILrOUaAySCxcF43D3XBuB55ArjoVvyDo51Q3Q4fLvZsgaUeIYzc4mh2JdbfP7sMyi7q4UTRndJ9oXNFFpQ5MNR3pjahvs0s+nlSfSSTmgzxjztwM0cfaOITPrFSRR9biP80NmTmopfAbLGfKExKoRA0TI65B7lGNfArGl3eJaehct8mFMS03g5tZUu3gOakWQNxxmnuA8T/Fva51W8Sab+XIhMLst0C5vMmehrjPxV68QUcd3fMP60u/RCIWR0J61kmudaByY2DbTgGvglmxevCzvQY6BV3hsqFro7k3DlkfB90V1CKNHeZUKUvIZWrQzMrvGQdpHHRY6MCrOcHWuqX675Al1qFtf8Deh+WZ8XiBgAdtGooCY414iZBH36DMDd3OKm8QYxmBB+kcD4MJu6IRMSDXyQ3DFmBCaTTAuFCbm8zwxmSbFijlvzYTM8TG0QPA5m2Bz8uLVpvmfawVNoBvfMpCTpNP83RwQX0IRvn/uDGnxTMMgX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4989.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39840400004)(346002)(366004)(376002)(136003)(2906002)(478600001)(36756003)(4326008)(6666004)(5660300002)(956004)(966005)(1076003)(26005)(6486002)(86362001)(186003)(2616005)(54906003)(66476007)(66946007)(8676002)(66556008)(6506007)(52116002)(38350700002)(83380400001)(6512007)(8936002)(38100700002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rx/xvIeaYZyvS6m3fj0VY4W3WXs1kdTZLQf+bKxZTc8OY5n6iQxEtZJMxj+Z?=
 =?us-ascii?Q?n5tMhCDh/DlKxuLyCPP0VuiyX68F2njvImwQeJUt3XKbROooGeglNPswO/yF?=
 =?us-ascii?Q?x/dShCbA82l5fMXLZMcLLqua1VhXvVaOvNT+0bmWBIxcvo0AFM9kglDXPZ0O?=
 =?us-ascii?Q?wuG6rmb1iaDytQmFA8EZbjLjjJefPGkEJYFpJrGYDjK2cJKmxe6AqNKsGJDR?=
 =?us-ascii?Q?9Cm8mvW1MxGUmCYNuFavR4bPPtywX8JQQii9Oz802DuM8I6XkSoQs0AbPfXB?=
 =?us-ascii?Q?OftFQBEcR2fMa5h9QoRbSvmLnQitQwb79iT2UHMQgf2vPFsXFOSq6daXgj2o?=
 =?us-ascii?Q?tm6UmjGyBu8I+EDrILvDXkqf4MSYwAJBXFAn+C0WekjwsutMuHyk2Ztoq/t2?=
 =?us-ascii?Q?j2h+CSVjvB1NLyfJp7fIzRoh4sD2Vrb9ksDGSglqFl0QbYZG7WC/jEfNxSTk?=
 =?us-ascii?Q?u0BZM//WyGHLGjgBQOWWrH8jtubAYOSHeNX1PHjhd7PQ7RLHpEk1FBSFcFRs?=
 =?us-ascii?Q?WND3rbOKx8R3b+08VS0jOGLPFs6rFdh3jrjMFZsg5uABCpiU0pM0KgpVdAHI?=
 =?us-ascii?Q?jiiPQnj/x6haeLz/7NoTrk7NPwY7x/UgY4ugUrIOtpEQMRIB7os4R61lltry?=
 =?us-ascii?Q?9RiAjB2Abm4xwwPE2iECTqH2M4daEPjoH/G5HuxP00ns2TNYHCB8QLGCiZ2H?=
 =?us-ascii?Q?S0s90e9MLvBoreR9817G3n0wOsEeDnD/ES2lFPw8vAJ/3kfrtRD8nsUoLmV/?=
 =?us-ascii?Q?W184lRQVNWkdGAOVOcoptFtyARWpveX6LBW2umBRNIku446eaj4ufmDgu4aL?=
 =?us-ascii?Q?uPdmTslidgMU+a409AGlhg+jrgH91pmVHMBWuBtwXY/DUGTtuijsNpEWh7mY?=
 =?us-ascii?Q?rCoz8EJ/ax5hb7stczg567i3gkBTiT6mzXKjvAey6Lw3RwJm15l/FyYfjTHB?=
 =?us-ascii?Q?JiyyZb+0n0pJ6ztQP4TQoWRVBprhajN7L0LUMTKcWe4D0MRuLTTeQJi8Kdw0?=
 =?us-ascii?Q?xtMs8XhR8UpGW5UfDICIk2aAROnGbV8hEJvDyA0K19VasOuPsLBnedTd9J+1?=
 =?us-ascii?Q?LHn3tK8KgsfE/0dahCKmgkNWlZhJuhu+6ilFDyK85vLFChKaB/MqPEJw7hkr?=
 =?us-ascii?Q?Znz8VYUcvpp5WQyxkdjcpgRs2MMuR5TaxoTzK2R8K02WfPmEg1dporGkEZbS?=
 =?us-ascii?Q?cjeNczRv83ot70IAVhtJ4fapCcGgH6Q6eq+1yRUf5ZWMowF28ol8CSDt4sDf?=
 =?us-ascii?Q?+RGeEaRGhx54zi761pX8WwjeHJogBA5ESaFJ4j00hUW8BQuzpmnleH7MNG+r?=
 =?us-ascii?Q?hQX6nkRSnKydVrAifC4xFiva?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b4bead-61aa-48ad-4b2a-08d946e204c3
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4989.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 16:11:20.8235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ImcJGeyvuvGMqSps55sVFtplCUJPIN5D5Jho6cPxdZ/8bezL2KOWxAqqYiquW7b//5C8tq3H+mCesjCv8uWn+Vym3ZnDiIDNXH4oxL+wum0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB2111
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
v4: Protect mnt->mnt_flags modification with mount_lock

---
 fs/namespace.c             | 77 +++++++++++++++++++++++++++++++++++++-
 include/uapi/linux/mount.h |  3 +-
 2 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index ab4174a3c802..5d0b477c2682 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2684,6 +2684,78 @@ static bool check_for_nsfs_mounts(struct mount *subtree)
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
+		lock_mount_hash();
+		set_mnt_shared(to);
+		unlock_mount_hash();
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
@@ -3669,7 +3741,10 @@ SYSCALL_DEFINE5(move_mount,
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

