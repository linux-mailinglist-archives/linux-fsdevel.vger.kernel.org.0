Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF273C9C65
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 12:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbhGOKKk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 06:10:40 -0400
Received: from mail-eopbgr70098.outbound.protection.outlook.com ([40.107.7.98]:48611
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232495AbhGOKKi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 06:10:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gh+XlOLrOPdFNvy+j0HGQIdoTxooFoFpl3nru1M4uHiwvkUOaNmxdLK1ECCMJcgOISbyA1MP7aRWfR8rYxOQGlK0Nm3PAyFBxdPL1u8mm6Wdx8Fu8xZUFUUbD6Wo4jeTHTpUjFZqmGuqM3MFaUQiUb6rZlarEkV4mlp37JyDe1P8beptgXd80ZZGcy7OKBZdU8ACEoZdC/R2/6k56vikCRT8RkeaVHAtW6D1m4SzpDfdIBWASdx9gKIp4ssK5b5XchxPEpelQ5cB2G2FIJd9o2w6BT6ub7ExhSf33ImFDXSPOZlBGnq4MvDUmude7yitAunXuGIxXtzwkM+e1xSvGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nSYwDNS+/5G8ExMeeHKnPnG3UUt8OG+PdEZ46phabA=;
 b=fIBDQpY94uaB+vaCnaauVK+MEk8LfYjYj9IGZQxJRvQFrvBFoGiVxDeUoftzwGPLumjX1Ssm8kwU8Rko+CiSvwRS3aIoVw+QF48GTbQUMhu8s3mWcfv25JVa/6b33EgKpjmVan8aF0oSR2ggNnsXllxA0DuM8sDIsd1padpTbcxAgWxDmUFVZDTM8ReUkiLIxyna0+Whl6hTpExsIqwqLlUzZLqD2tgC6H7hEUhn+lwktN12Rg3N5cqSUvVu7GOflpvRNG36zKMAL+YD5F6cFtlEF/7B/HoSvziK+ZWO1JjhdoB63jjCuC+AT5GC7XMN0HTEcktjNcB/PInL47GIkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nSYwDNS+/5G8ExMeeHKnPnG3UUt8OG+PdEZ46phabA=;
 b=WROBsdFK6j56WlKsgaxTdew8J9+i5kEdhbOLvbsbDTrSwZH1uu8JqvCJ+k/GXCSJsNUn5k5/LRGg6PNe436m52QXljdwl1U3YFjHQVT7f1SH5rPN9NUnVuMR99ckahcHFOUtsnJSS+KSTXVdrmBEImOPKrvMO8c4Xm0tQh2Bi1w=
Authentication-Results: ubuntu.com; dkim=none (message not signed)
 header.d=none;ubuntu.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com (2603:10a6:803:114::19)
 by VI1PR08MB2975.eurprd08.prod.outlook.com (2603:10a6:803:44::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 10:07:42 +0000
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::c402:b828:df33:5694]) by VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::c402:b828:df33:5694%7]) with mapi id 15.20.4331.023; Thu, 15 Jul 2021
 10:07:42 +0000
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
Subject: [PATCH v5 1/2] move_mount: allow to add a mount into an existing group
Date:   Thu, 15 Jul 2021 13:07:13 +0300
Message-Id: <20210715100714.120228-1-ptikhomirov@virtuozzo.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR2P264CA0039.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:1::27) To VE1PR08MB4989.eurprd08.prod.outlook.com
 (2603:10a6:803:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fedora.sw.ru (46.39.230.13) by PR2P264CA0039.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101:1::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 10:07:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9e42545-1d3e-4aef-bf82-08d947786263
X-MS-TrafficTypeDiagnostic: VI1PR08MB2975:
X-LD-Processed: 0bc7f26d-0264-416e-a6fc-8352af79c58f,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB2975125BA23B0F8DB83AFE0AB7129@VI1PR08MB2975.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w34qPPW5U5AQu41ebA/TdGMCZBz4PTQDb7SbptyRSxrVKFM0IFrp8UjG0N4uBLrsk8MuK/Cekk/dAns7ukyGgZsThlOKYmMjUXkh6tYutZI7n02PsHPuutYUtxrwK0W4b19LT41VhlkUWerJ4BGMIogSc66pQaIoVKeqoUk/GpOFKxmGf99ZXYm9lKRb64LZMdRBuTMcQGTcCEV9IFc+HZFwTu5zMpiXGyE0eLDs9p/+jyhrUjsVzs+6LVLSRiX0Uequh2xQMYcmeXIg/vRDLf8MxGuo7CY1XkvN897bzhqQ2D+x84ltiIL/yDtBlqNqi1mac3SRMkLcBq/QWawlXwEbd8xMo4M0XKD/dE5RVzLykpI2griwkgUZc0llmPPov2muRutPYaXL6sbB3DuHZOc4JqzvXTBwdmr5hWMk1LOIgcEDRZyRhG0RBbgFsdXXWOGM5wynCQtUrzjP3Fqqeev3LOKx7LJPV5AUsPSNXZ6eqaBJj7ipO+ADaEBLgS8hNOsqnJykxzdXA1vD7n/NlrUHJCdn0V6suDCUwiqiV58vhWNKPkLdzdFIIIV5aDG+6Pwbc6soy8v/xxCdOoV1UtSfTVLFdCx8wjp6+PicskqsV/sb1k4J0lPHAH0DM+C+I19QgyvjfN92oyFj0E+ioaXfKk/R4oP2ghN+XG0z52/YFk1DS4L+ziWrJs6WQiJWtpEJulyMkSWjWV2oUDrxeO/lC/nH2pGJHOiNi17Xc84IsKy2+V51EFIAkMw1Nm1Edf6LL1NflPTUhWEHKv1nJmd+tVLaX5+Ia0IljmEztbZcFsCCQoT6eJ35mPo1EAaA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4989.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(6506007)(4326008)(6486002)(6512007)(86362001)(2906002)(54906003)(36756003)(52116002)(956004)(2616005)(26005)(5660300002)(66946007)(83380400001)(66476007)(1076003)(8936002)(38350700002)(38100700002)(6666004)(66556008)(8676002)(316002)(186003)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ErePowSeLhvcjRUwmbOSOPZvceSWaOsvMZ3GHHW7g5Wl7++E2NwiVaVhgJpP?=
 =?us-ascii?Q?4RlM4A2V+TFs3t4w+DMwYDMemWB3MtMYWRC/ICu1XJNCQLYYX+hev3UJV3cQ?=
 =?us-ascii?Q?0QdtB4513nIn4gif0lhsDYHQTHr6nxVliwcJlWC+5r2URBWFrBLfJPphTlWg?=
 =?us-ascii?Q?FRQokKOSVeLHZxO7wfPb6nss0KuriUFwIFP5m6oBmImEquzoUtFH98OuCVfR?=
 =?us-ascii?Q?W50GBP/f4EZ8NVGHUCW/agrKfdZFhkubDkv/OHhjF6BZiaSLJABE1p/nwbCf?=
 =?us-ascii?Q?evNR9+qn/IxN7Mgbdr4gCoUc8OGcvbDOP1vwu2x1YwdK1xQiWzFakKgKNq5I?=
 =?us-ascii?Q?pbFZZLSi04lPnYyfTg3BaJCipnz22rL27ppqwAV0kEealkFcOMyMKLo4EMMi?=
 =?us-ascii?Q?NIEQSD81xU/BsqQgXkn2e1LUIfApOwmXVig9WQkRi8y6v22Ft0xXp/bo/WQ9?=
 =?us-ascii?Q?hTjyB18J7jjOaDBnbIrUUigygDPT8Fm85OgUsIon8P4ZBfx4ygvY8kH0MX1b?=
 =?us-ascii?Q?pcxTgWBYYCS/hkInyYRpg+FhcgScFxmfYonVE0JfP8ddWMO8CwNFvbCHN+7h?=
 =?us-ascii?Q?goy0IutPH5ixA8NinL2nCZSgvZAirawB1LVCO2LVcW2PWveY7XK+pZz5SxOQ?=
 =?us-ascii?Q?ca4IFGQhbHfjaxlsz+F46nZTG4qVp6MSCAdMUZn502DX1XTh8rs2W1No/Ztl?=
 =?us-ascii?Q?YW6IrlNeZgsPfhihiZPatDemTHaBT6JEopBmWisUreFAVUE7hY7/FFMOwU0u?=
 =?us-ascii?Q?yZ2R/W60CyZGaUMv8coFvc4wTXmfOpt6TsRp9GqQ2uKYt1OHP7YfmBWMFlaD?=
 =?us-ascii?Q?hkU0VIsr3sZD1YX1X2K5bWn10bss3soxR8Hid2sRim326Z1DBfI9pXNwz55F?=
 =?us-ascii?Q?n9lKDb+0pEeKBPaBpb3vFlkoCqsnmitOInLk+Fgj/LyW2c2F2eNy6NwqCOA7?=
 =?us-ascii?Q?98BLf2mOPuwIRmqwwE0zbJP/6YOsfm6Iwka0EmieAwDCpgx29F6fS1AINBd8?=
 =?us-ascii?Q?oPOqQ9tKmXUf1fDKOj0UYx8GWeBFYP4c7+caanyULA5jvV9so7CLrqYUBR/n?=
 =?us-ascii?Q?IMEgwk5ldn47oXFGWaz1sz2RSLlPMRXha/LJBvWghz5+/RVSiL4gxPXCdwBw?=
 =?us-ascii?Q?KshvutFYJYa6+M4vbks3WcDrVzmrnYWDRjJAoRyufGr0M3Mig4Y4S4SJd+Rt?=
 =?us-ascii?Q?k9KmVvxfiKtg8bVvrcD8SBp+rNXvO/ZXajXnPWU/P9gK31dkON48IuBsWoIN?=
 =?us-ascii?Q?gTC0KS/bxg9KEvUSz7Uafq1zlfHmWNy2IjPBNwRC/MIxPzcfQRj7QfltGCUr?=
 =?us-ascii?Q?ugXL/ogZWUHZjlddgaZfrl66?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e42545-1d3e-4aef-bf82-08d947786263
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4989.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 10:07:42.3796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +rZSboxGBF47KlEDOLQaFvMklYSkayL38ZkDRend5cIexsD6d1O1CWw4oZbSA2vy/wV/8ixvhRDvkRUzhqooIiJNyARlgG2MObIE37rJFvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2975
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

