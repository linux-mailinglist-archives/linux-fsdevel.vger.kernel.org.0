Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65EE03491B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 13:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhCYMPi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 08:15:38 -0400
Received: from mail-eopbgr150122.outbound.protection.outlook.com ([40.107.15.122]:4165
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229626AbhCYMPO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 08:15:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBQGw6PLWBGswq4dCPxnE9H24vbHFRMG0pxJmKsDG2G6Fjq4nn+VEq1yHjPKKCJ3gpRDkLOwKeWVj+iKoy3a1auVsXj8JrsBdT1PrARtfgx3ZpaXhzwdbAmiiap/2M6msUBkKtf+ZYgRPPWiG+YUo9zRAwkx3hErtR0rR8PewSoqqBJfe8ZqYY9A/wU6a83oVxDXr4RjqZ5ABMr2n8mZEBAGoJj0MrK7UXnMy/UtzxUznTwpoQYqXopQEogzIAK3aHnELUKUM/F8WB8INtba/SF5g3cbV3UTFxBlXIbh/s4ppQ1RR3CZYyaLE28kGhLb9N3L2oMf0G093h/gDNt7rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0K008gh8LQGFzJI82B5JUQUf3XFwVA4iFKsbIf70M0=;
 b=LbpkExwH/5Y4Fbb/3RCbFOmWiuSTKpAu0isYtTbPfbL8Fy0J2CL1h/uPMAk2xUF83bPZNDAZQgFeMjBO+qKe1wZG1s7CjClYYpKtzn01KtAfZi+7FfGBMHs3+pTGYZdpbOgGw8fMmzOOVR+lhyTu7j8yxnxMv6TIOh4oP1BqbSATcT35v9OF4VfawkB+9u6chr9osXTK4GIfBOL6UJLCZpSe3Tju01KU2ogLby7jd/p43KYqP5TXwXox6qtKLetqhOomsdRvTcqCnQZxwPhp6yFP1nvFzUmmfV6fGaylAT+AMgRKTeuaY096vLmQvFJIHxWXnXXsYAAZk6TcozOxJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0K008gh8LQGFzJI82B5JUQUf3XFwVA4iFKsbIf70M0=;
 b=i7RwmLtoS+6sp/0MIIl5pz6ApUCjEqNEmV/ZJdi43RI15v5gav+MOj07f4qx2IE+6BihkaYvLb4cPkgv68Pea8oNuKrRPsidVSEHwhO7FCB946MiGpMdCZDs+NkNDZgqt0kqg/RlBL3XIYxkWdmgdI8GA38MKS24K4TeOYgh2Es=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com (2603:10a6:803:114::19)
 by VI1PR0802MB2543.eurprd08.prod.outlook.com (2603:10a6:800:b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 25 Mar
 2021 12:15:10 +0000
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::d1ec:aee1:885c:ad1a]) by VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::d1ec:aee1:885c:ad1a%5]) with mapi id 15.20.3977.029; Thu, 25 Mar 2021
 12:15:10 +0000
From:   Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Mattias Nissler <mnissler@chromium.org>,
        Ross Zwisler <zwisler@google.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrei Vagin <avagin@gmail.com>, linux-api@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] move_mount: allow to add a mount into an existing group
Date:   Thu, 25 Mar 2021 15:14:44 +0300
Message-Id: <20210325121444.87140-1-ptikhomirov@virtuozzo.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [81.200.17.122]
X-ClientProxiedBy: AM0PR03CA0001.eurprd03.prod.outlook.com
 (2603:10a6:208:14::14) To VE1PR08MB4989.eurprd08.prod.outlook.com
 (2603:10a6:803:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (81.200.17.122) by AM0PR03CA0001.eurprd03.prod.outlook.com (2603:10a6:208:14::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Thu, 25 Mar 2021 12:15:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95e53fca-731f-40e4-e086-08d8ef87a295
X-MS-TrafficTypeDiagnostic: VI1PR0802MB2543:
X-LD-Processed: 0bc7f26d-0264-416e-a6fc-8352af79c58f,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0802MB25437FCCBEE097C213EFC49FB7629@VI1PR0802MB2543.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wqWQcb6vypBCGAbQUA8ZfFqGXJQDbcBAnHdWl+3yMWrbmEFfWnHK+gZ+iy+IUFxACx/dZJYyO+sspttK4Si67Lrpi7N4uUiECcYSZEHEu2QqKNdJqyAmuj/TUjpEFyaTi1y7NfoL9EYPNWcoz5fnIZBIOfY/DOl7jRQdV9Khm0NBWZRiQRYNPeVZlXuP0C1wSiGiGvRJIWPjyDBoGtAZDedd1HVa/geNicNvhKvltZxPdbfjByp6gC2mf+ruoScGYf0xiCz7mM5o+PSZ+VFU5bZct4ae4tHK1iiB3sODEO1g1HT1obJeJhjSmzWYTd/CkTfOFWxTGH67VkVMWE5Y6MC6SCZELb7B47TwV/KrHqXRV4KK1UjIzvTZYrZ8kvRf/hEMo2FdPI6TtXS0oBNvLKfRYq0HOGKUBPgOI397CineILG/qKzFaQCpewVHBi/oW891HJJeJRJoVo7pwF3hGCzpVsXL1Hk3ZPg63ApmgUSVyIcARxv5tGOytlAfqtBiloTSFOm6mMWWhYPMHSxbXEx5aK6YKXWDdeslwkluXCwIBMAIziX3OZ4iLeqo7D0O/DglP0HWm8bbdkiWTefaxJ6EYNVCYv4EK5Mb7yPMnoH2VAd+m4MHp4tck7iI7rBnRUCcXiR0o5+RWQiGqrV/gzXD49kJPzvN8DX8djKqEuFkYVohRmT1yojo3T4V63vGrn2SXOPVBODEh2I5GqHzijvUsXBp6AN+6IfR4wkdTKYg2OjOZI1CmpDYfqOxC5shqWLyJyrRVqhyyKFBWJ32HA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4989.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39840400004)(376002)(346002)(136003)(366004)(186003)(8936002)(6512007)(16526019)(54906003)(26005)(5660300002)(6506007)(38100700001)(6666004)(86362001)(6916009)(316002)(478600001)(52116002)(1076003)(966005)(36756003)(6486002)(2616005)(66946007)(4326008)(956004)(7416002)(83380400001)(66556008)(66476007)(2906002)(8676002)(69590400012);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?P31iqXXC/R7H1LbJUlJ2TsByN5FsZiKkFlPMGTPdQU0kIKzBB8n83s7UkLTi?=
 =?us-ascii?Q?Q9+6PXYnIBlFPRwYYLoUlufAELzgxOtwRbLb7jbcEhWk2XHnmzabSq7dFeEp?=
 =?us-ascii?Q?jwRX4QE1Bb+UYQaqEXz+Bq+FE0u8t5Lz6aiEyPJY5OWg7Ua3AnWH8yHoJIio?=
 =?us-ascii?Q?pzPK/gr/IQblXbQYE3JsYzoXGq7+uX2rA57Kn3bTiYpm9MuXzM7gNUorofTI?=
 =?us-ascii?Q?HyZkGZecitMylzitWuUGy7TSUT4Dl1FPRUEHeYxwQSB1QXNLGYJJ91cohkU3?=
 =?us-ascii?Q?rrn16cYCLd2mTcp7BLQ8fZ1OkB6l7gpP3BcagAVhfOLXLJE8dhXDkYcdptnZ?=
 =?us-ascii?Q?AKMivk3hQ/DVEOS/HxneCeBixy1abTy41blb8G55aMdYEaov1auBL7ltuNtp?=
 =?us-ascii?Q?aGwU7KMq1G42iiTmt++ApXpu72axL1tYEutRcp9Wg0I+pR7hQ2xs/1KKhBwU?=
 =?us-ascii?Q?CrK+FFgX//QAEBhFvRSK6beO8B6QzDD+/L0warh1Gp9g+2DmF8BsU7EhPxdd?=
 =?us-ascii?Q?OjiGNH8Rqgm+hVmGaXcpiiAwrSsb3V6EuS/pC4Gv9LPqlcFTcupdhtWS9h3D?=
 =?us-ascii?Q?tMRDjwwuhUaaOyzzv1Lq9f1zQaRv2EYARRp1og9IoqwOMF5cHfz/U0gRgGzz?=
 =?us-ascii?Q?/857z6F0SzNwvZ9kNJxOhFB6l+E1k6MObRfkx1ig76nU8q2iyGfppcLyxcei?=
 =?us-ascii?Q?RDps8n+GfR/qJM5t2JIId/rbMXGP2XvlbLFyHuNUTi5WDYRQmCVe/BvLXdwH?=
 =?us-ascii?Q?aug2ErtO/CFQ14D8FReZ4djJ0v4L4Dht0aRJ3Md3PvnH12rwvFkjd5Pru7Dz?=
 =?us-ascii?Q?OJ02f7/ou6Zh/Hq1R4ohYxRzQY0ULFk3HJd6gd3Ae8nGY6adH2SVX2i9b8u3?=
 =?us-ascii?Q?C9Fcln7p5SPoCUVNiNmGBXA4Kdx0otcKEf1D2twteJhzgaiRIL8bD4hkez7r?=
 =?us-ascii?Q?9nXMq8W2KFQsvV6wlo1+mAFDb5qFIqOT0p3ZxM12z/bUbdiOHXIYyB0UCL+j?=
 =?us-ascii?Q?BtWkyP2JD2HOPGQOZxBx1yslztD7RqMFAECIfFolbbf6L/5l3QyYdvCNorBR?=
 =?us-ascii?Q?lsNbiHe/PPlD2YOkPJJx5hp6VCtksKJrGxwN4vhq47yZjpEn5U4YycnsF/ri?=
 =?us-ascii?Q?OeZDQQSDh9+GXXAer0MdRMEZ0EQkDLvNdX2YUytqM6DNPvsDob+L3AO5WCrF?=
 =?us-ascii?Q?VjUTMy2fzrwdoJUiYxKe1hYwyd8IKSh83BwsARts66OTNgtZbWkexCTUnkxs?=
 =?us-ascii?Q?lzRbzn7KZqQsHt/SdIuvS4CV+Ce6y64VhHBiVUZ7Wus+Rp5zjirLo0gyyGoB?=
 =?us-ascii?Q?vBmjzvItUMdcrh9mrhWFBTsc?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e53fca-731f-40e4-e086-08d8ef87a295
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4989.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 12:15:10.4877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: obILiLPOpDOS5IIzezc/YBdtcl0nix/+BH6ycCUjB38fjvNF8L4CAKFKVbGI7PKcNXBknSdMpdDOTnPyiJkjZoVmvvRQSl8OKPJBZJrDfSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2543
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
Cc: Andrei Vagin <avagin@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-api@vger.kernel.org
Cc: lkml <linux-kernel@vger.kernel.org>
Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

---
This is a rework of "mnt: allow to add a mount into an existing group"
patch from Andrei. https://lkml.org/lkml/2017/4/28/20

New do_set_group is similar to do_move_mount, but with many restrictions
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

2) Allow operating on non-root dentry of the mount. As if we prohibit it
this would require extra care from CRIU side in places where we wan't to
copy sharing group from mount on host (for external mounts) and user
gives us path to non-root dentry. I don't see any problem with
referencing mount with any dentry for sharing group setting. Also there
is no problem with referencing one by file and one by directory.

3) Also checks wich only apply to actually moving mount which we have in
do_move_mount and open_tree are skipped. We don't need to check
MNT_LOCKED, unbindable, nsfs loops and ancestor relation as we don't
move mounts.

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

---
 fs/namespace.c             | 57 +++++++++++++++++++++++++++++++++++++-
 include/uapi/linux/mount.h |  3 +-
 2 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 9d33909d0f9e..ab439d8510dd 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2660,6 +2660,58 @@ static bool check_for_nsfs_mounts(struct mount *subtree)
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
+	/* Setting sharing groups is only allowed across same superblock */
+	if (from->mnt.mnt_sb != to->mnt.mnt_sb)
+		goto out;
+
+	/* Setting sharing groups is only allowed on private mounts */
+	if (IS_MNT_SHARED(to) || IS_MNT_SLAVE(to))
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
@@ -3629,7 +3681,10 @@ SYSCALL_DEFINE5(move_mount,
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
index dd8306ea336c..fc6a2e63130b 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -71,7 +71,8 @@
 #define MOVE_MOUNT_T_SYMLINKS		0x00000010 /* Follow symlinks on to path */
 #define MOVE_MOUNT_T_AUTOMOUNTS		0x00000020 /* Follow automounts on to path */
 #define MOVE_MOUNT_T_EMPTY_PATH		0x00000040 /* Empty to path permitted */
-#define MOVE_MOUNT__MASK		0x00000077
+#define MOVE_MOUNT_SET_GROUP		0x00000100 /* Set sharing group instead */
+#define MOVE_MOUNT__MASK		0x00000177
 
 /*
  * fsopen() flags.
-- 
2.30.2

