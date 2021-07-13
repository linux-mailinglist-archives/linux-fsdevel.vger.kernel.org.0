Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 424623C7007
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 13:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235933AbhGML7q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 07:59:46 -0400
Received: from mail-vi1eur05on2110.outbound.protection.outlook.com ([40.107.21.110]:65345
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235797AbhGML7p (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 07:59:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ut6ITZ5mH214VBZYpZ14FydZkaqV+QD/35ed+6t3u4f8uEz/j8UoSNhjcBS9BHYU/OJjefvEqq5kCJ71araycQzf6QMpAaAvr3Ab9SJEYwG7bY0edSUpAjOHf1DJGaYE6VD5Mkt5i6v+gJmkjgM2HkaK+Jif7qAp6skLLqiDdteyPwYEtWAtLWtxs4AXhaKI1aYlwUEc8VGPKtZcwwPeT3vNID3700jmNJU4v1iGjGBNmi9P1TZQxJwHGtWKoOhTTRMjcHFCDrg4tchf/puNd0Y6XJyhsM1lNZ15BhAFOu7qJDYd9raP1yy6gsZcj0mxSA9C8zIUXqGV8sTWOt1GfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RVvmhk6P5Q3uSjY+lZQF/bPSztywVEIFaVf4kLLCOc=;
 b=K8BdqElhax3XUJYbG1XN3YeqWEbobXfoyestxhzeVbPMxhxX9eeunErfltKgWMalIB+y1SxOmDectyiPXpFKagKflf79TcUVMmtniEb0pUdnhP6yhW4IQTrnOUGuABmm1Bm6iL2lke63PUvHmKFs3rz4k1rniNA5i7gAq1+9JNiSngq491JpWlGYZOWJjRFWpw45H7OwMNF4nZRDlQFYu+jziRqr8Vu6ZtSFUpIkwkzzwclkVDNTp1Lbh5S+SFqI3I9PJ+wkXYvd2JY4APGVqHbaT3TdKvzidu20P1B9dG10C7vITq8K92mV4hk0YPTbhniMSuT26cU/z2viVrLl0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RVvmhk6P5Q3uSjY+lZQF/bPSztywVEIFaVf4kLLCOc=;
 b=C7T4jdFpXtYp5VRbt4/2bEykoBW/n0OBlabtuLoKwYKEFIGUL7dExgyQmbpmqFesm+bYahAOxuEK3uU0oeVWhr6dqZ7g/Tv4c+CFpxIOrIQ3k6YzzaMDP3mV2gkIIXxDiJraVQvjIATl0tk5SXXJCBOC4cFrMOcPisGEPD5JfCM=
Authentication-Results: ubuntu.com; dkim=none (message not signed)
 header.d=none;ubuntu.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com (2603:10a6:803:114::19)
 by VI1PR08MB5373.eurprd08.prod.outlook.com (2603:10a6:803:131::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Tue, 13 Jul
 2021 11:56:52 +0000
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::c402:b828:df33:5694]) by VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::c402:b828:df33:5694%7]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 11:56:52 +0000
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
Subject: [PATCH v2] move_mount: allow to add a mount into an existing group
Date:   Tue, 13 Jul 2021 14:56:36 +0300
Message-Id: <20210713115636.352504-1-ptikhomirov@virtuozzo.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR2PR09CA0007.eurprd09.prod.outlook.com
 (2603:10a6:101:16::19) To VE1PR08MB4989.eurprd08.prod.outlook.com
 (2603:10a6:803:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fedora.sw.ru (91.207.170.60) by PR2PR09CA0007.eurprd09.prod.outlook.com (2603:10a6:101:16::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21 via Frontend Transport; Tue, 13 Jul 2021 11:56:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d749de7-a7e9-4fbd-f214-08d945f54dba
X-MS-TrafficTypeDiagnostic: VI1PR08MB5373:
X-LD-Processed: 0bc7f26d-0264-416e-a6fc-8352af79c58f,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB5373CA4682E794D5AD3DA394B7149@VI1PR08MB5373.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /r6VdK/ugU6+GgXQu9+KG7uh3OEsEvGdY8csGN+qfUUwXJDj4faoxusTZtQcSHf50efCHTMVOBsGMlXbmiVPodNVW+6P5lybumvNOxd0TBEz8tbARCEsxyZl0KIdNQaG3JVXp4kbYXjkiTQrrz8UrecHGpF3KslPcdvYj60CKir35mGu5in6aVPn+InkA2UOipZDzomQB1RgcxtAkXMAfu53c2qSiZmFhIe3HAfRlgSegJsM75rNYoPsu6430aNeVpGnbtf10I2tyMWVIXPnpM2MZ05UTGeFpwNeB8KbuvmNf7O25kAKMW3UpW9sEUsmh7Gmpe+8s56N2S8rU+hSoU8BBfgo0cNwxxUWl7Ne7nLy+BzrI2bU2+bSeQf/WS0NI5gEpQ1FJ5RvKtrScXd+DOFMa7YGruzj0VbSgmGQVgg6hCHMo/H3myJ35EplxRQv/0XhZ7kOD+OjOdFZP+2vLKVzE0up1t5qR9Xyxz7somcw2S06IYG4cQvgf8L4s8N3nIV1wFC0+WozmkdKeUjLP2yGdgHLjVd9eDbySUZoZXpGLgplZ/y27/zIQPL2DJNvOAhVCSA2iBusjs41GhV7SQXaSZro+hLGbV44iJZJw+h3rtzdDfM5hxzX2wogHy8q4KcD+yl1T44LpuZe7DiVGPnzt6ubO0jU7JT5H6N1u8PgZjnA8tqsuyKP7XChHEQedZYL1C1URwl9k6e2MV2iM5+WlT+13FE9hX1taOaghiPnM3vd7q7PfOp77C1rptqzpDln7oIsRHOkGm75O9vI5xld79cJ4GpJXG77gd0cPf+/4a04Ey1PBEvnRgTX63zy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4989.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(396003)(39830400003)(136003)(66946007)(66476007)(66556008)(6512007)(52116002)(1076003)(186003)(5660300002)(86362001)(2906002)(6666004)(966005)(26005)(83380400001)(6506007)(8936002)(36756003)(8676002)(956004)(316002)(38100700002)(38350700002)(4326008)(2616005)(6486002)(54906003)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2pUgRlAx6x96pI3WnZbu4CTuAy8fm3C93j9M9w5njiBwATetQplCpLz9o7QJ?=
 =?us-ascii?Q?FHemCFE8R/G3Svhjb+BPSmnrYT5LWFqTuEwl3TaO3H41pr/77EFnRMbysywf?=
 =?us-ascii?Q?G4l2xjtDBJQk9ROfEMNiHHM4N9o+o1ZDAiEUuBH1OatCDK83UUHdBfX3Ttny?=
 =?us-ascii?Q?E2+QDZBwO7IWZk1j0tV1cBbbVhgxQbUoYXZj23RI0ZbOxESfI+rfhSHwvErp?=
 =?us-ascii?Q?Rc2TN/fXhzFiDG+tgAb1Hl/nArSGBL5VcSJ6sdiKDFCuabWrA28bBjrcsAUT?=
 =?us-ascii?Q?ylAO1QFh0GBEdO2Q62UgE6RbvJLkj6kEQPF5PwuomgRvmfC6be6XVeSbyEQV?=
 =?us-ascii?Q?67aX4gqasPA5COZR6P7baYbn1AwxDRuP/PWsP0q3rvCp9yKWZdE05Y+7USiU?=
 =?us-ascii?Q?W0LgfA8QA5/QlY52TW5tL6LiVhWTjZPYanIFMdLJfKb7z3bG0LBosgzM4kzc?=
 =?us-ascii?Q?vkjVojMBNx4IzQSE+8Qtb4P4YTbETEQS2eXW5CuPmaY6uGTBHEr7m7DcpBNL?=
 =?us-ascii?Q?0bl1m7BLGQsSMAzxxMFQOmMF286ItIm05XWZIhqfpVZtiYS7cOmUQdHN2oUj?=
 =?us-ascii?Q?9gUeR9582GVvBU/ffUUgsVtwrdQDiidcihjdLARhUU8pqojDBHMQPCQ0I3kV?=
 =?us-ascii?Q?EWFLdc3lnGt6zrjUBqB6Jd6Cs7Y0h5a4OrLBByDPr8QZNfpqCbL3xMXNF13B?=
 =?us-ascii?Q?YGQHbldMrWDWOa1pcjF37r7i9wbbV2NQaF7VZkemwwBu6NRpnlRshlErcUTj?=
 =?us-ascii?Q?Bhf1uMKf1gY2xGrmmd6KCOSD1ee/oPyVKip97IUlQMERDJt11o/YtsTqEdZ8?=
 =?us-ascii?Q?424yGxNyQNWoW1brPQ7BmRKL/NFHEfeNj9JqDk9XeGqPsaQr2CgYIcQvhz0j?=
 =?us-ascii?Q?I0Devb//OCTceOK00i7pSiOojc4V00oSM7MfiqTBpdlUFoR7481Q45H0Pdur?=
 =?us-ascii?Q?g/3ZS+2VoNbz/wmjhTxkKBx8XU0P5WrqRTg5P1b2D1vgsaQmwlYeaxVJRtns?=
 =?us-ascii?Q?nnbzCHqCPu0k6ecNw0174tKJvZihbjYAODUalMqHni4HCdOS+GxXjKteFQIW?=
 =?us-ascii?Q?3xTF5/RzETbEfd1Jtr+FwAsDC0/3VJ8z+bP9+yh88SqHqL1TaCU/kiSbDfbu?=
 =?us-ascii?Q?CS7d2U3JTPD2BaIA+LB+9F4v6BMNYk9z7dNY24o/UqRWHhwEMjQnGnWzDknr?=
 =?us-ascii?Q?sz4ZUqjwLl8Df74DEOoVFnEag+MWqHaRExX6+6KcXdcjVqk942mEHdZDaHpJ?=
 =?us-ascii?Q?2XvumuUN+yHzXRnjqitYxvCK6R3Nnlvp/cjsvK0sYyZ7J2CpX9GKjG0sUPnt?=
 =?us-ascii?Q?52XRflwzS65+QTDG29mqEnBd?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d749de7-a7e9-4fbd-f214-08d945f54dba
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4989.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 11:56:52.6345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JLgByAuLPgptkw8PrfuBNvRSdW6nTdqG0eec64r0ebpgJfN4c+SXE+g9pD7K6nzhKRwEIUQ6CCVUIZZcdxsVL+6a85Nd0Wqi4ICxaoHm440=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5373
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

Also let's add some new checks (offered by Andrei):

1) Don't allow to copy sharing from mount with narrow root to a wider
root, so that user does not have power to receive more propagations when
user already has.

2) Don't allow to copy sharing from mount with locked children for the
same reason, as user shouldn't see propagations to areas overmounted by
locked mounts (if the user could not already do it before sharing
adjustment).

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

---
 fs/namespace.c             | 65 +++++++++++++++++++++++++++++++++++++-
 include/uapi/linux/mount.h |  3 +-
 2 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index ab4174a3c802..521cfd400d06 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2684,6 +2684,66 @@ static bool check_for_nsfs_mounts(struct mount *subtree)
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
@@ -3669,7 +3729,10 @@ SYSCALL_DEFINE5(move_mount,
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

