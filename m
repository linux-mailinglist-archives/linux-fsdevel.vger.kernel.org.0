Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725D45615FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 11:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbiF3JSG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 05:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234166AbiF3JRr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:17:47 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFE23B3EA;
        Thu, 30 Jun 2022 02:16:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OgDeWxUgudCufb/AgSW91agR1LHhR22Zr7Ln0uRExcks6Fvm7kQ1o/6O7shukdw0sqrUQsC5BY1+WioCvR/7vWQ3VH/eL7YXw+NgfFcXq98goE5v0H9S3FrLrhLenf9bITKUyqY2/QP+Ly1SBPCCV+kk2ipCKJ2xne0j4ffqJZrbIysnoad6U0r7PZj82NWknYA8T4REQcJGfa5AzgAz+qtASLvy+pfAJObk2Wk/5BgKAMX5yU9u7byC5UGKQJNuaJsSs0EQGyEWmp/xKZzyrRy7O1W0x2gd/FBqOYKDg9L+blp4BDrUI63jOqdVO47v87Yk5fM5+IlOLfKuMK6vbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPZs7OYN4FZ+SmQc9J9/JunPcK7ctzZQQiiCscacw4c=;
 b=izljQfwPVJIxrzh96HDuxTAkEYyfb9IkrmxqGFCqKk9y7AUdfeCEXGXwE0k8WgXaMxg9y+BNngqUHOvyaHg8DjW6Td7l0Oo3yw+oUGWvNOu002mR5+jDbwdUZN4m9LQ/AuMtoccam8HHrEdyWwD99hXSJMIHgcYj7m+vMdEJMJyq00X4x545X4sPTyLmR1JagvYlhJuoptaWI77//cM7Nc/wnnyQNHqVsDZxwBy3uvBk63DMCMoUqztnshMHaagLI9FOfcVoxH1qf6Jv9Sd4u0C8mMVrKhtjbqErcPGdrEJe9UmRLhoGfW93SE2IeWdXpY/hn5LSc7Hf24kXPZZl9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPZs7OYN4FZ+SmQc9J9/JunPcK7ctzZQQiiCscacw4c=;
 b=gc6vY7/mJ9sKWVdd8lJbnSyEwtgdj45E0JFL0pguj9yetUemsUbAKMozq4gHGUQ/+AQ1BTYraetAJu1WSt1JJR4sM9fNUR1AtROLjHcLEHE7PmUev79ZQ4Zgli/PB64kqoQIAucrHdmqUzYNb+rLPUR+MOHylwi+5sqeO9vfHi6FfZuC4CjYgG9/RZxKzYkaJByayQQBXMEd94ai5boCjlnn8DHLMkOQo6ad8XfebI390zFF4n+kxnXnKkzyoon3eBrraX9NhjZv39ubcvEDOPoYuYF7HmqT1UQCQtf0Ns5VZAsN7YMF1cnTA1/XnQkmrf8+MnzQJjbcDgFucQ2lVA==
Received: from DS7PR05CA0056.namprd05.prod.outlook.com (2603:10b6:8:2f::17) by
 SA0PR12MB4509.namprd12.prod.outlook.com (2603:10b6:806:9e::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.14; Thu, 30 Jun 2022 09:16:21 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::d8) by DS7PR05CA0056.outlook.office365.com
 (2603:10b6:8:2f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.7 via Frontend
 Transport; Thu, 30 Jun 2022 09:16:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 09:16:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 30 Jun
 2022 09:16:19 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 30 Jun
 2022 02:16:17 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-raid@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>
CC:     <axboe@kernel.dk>, <agk@redhat.com>, <song@kernel.org>,
        <djwong@kernel.org>, <kbusch@kernel.org>, <hch@lst.de>,
        <sagi@grimberg.me>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <viro@zeniv.linux.org.uk>,
        <javier@javigon.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <dongli.zhang@oracle.com>,
        <ming.lei@redhat.com>, <willy@infradead.org>,
        <jefflexu@linux.alibaba.com>, <josef@toxicpanda.com>, <clm@fb.com>,
        <dsterba@suse.com>, <jack@suse.com>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <jlayton@kernel.org>,
        <idryomov@gmail.com>, <danil.kipnis@cloud.ionos.com>,
        <ebiggers@google.com>, <jinpu.wang@cloud.ionos.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH] sys-utils: add blkverify command
Date:   Thu, 30 Jun 2022 02:16:05 -0700
Message-ID: <20220630091606.21438-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8a7615d-6536-4168-d780-08da5a79323b
X-MS-TrafficTypeDiagnostic: SA0PR12MB4509:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /gFexYLbuJWWOmZCrSbTLHFRex2OzHKuh8+0vf7K6T9OYQooUHXncpKUmPu9X65F8NhznKSDg1GNQniduTLMT2B4f2eGf69wvQbcvr0UDTHe0lSaMfqhbXb1uS65c/JWGkqBgxHdFzg9Z77BV4HncsUOdwTR7wWB+MHdzG5ZxAXmqGtyHUVm2wzX/0PYljAQt1jLK++yzNjuHcXJbj3LljZjTDl1ZcjimHjMEbxaqpB+uuway7tJlOl49JLBMrUdQQOu7EywpJvcU2ttFt6RjKF4WcR7DGizmacAKLb7oDQdb+Y+/ndlzWQmd5HAXe3ZuRwvy709zgoIEn+qf/g+Ik5pvU70RTqqIHKUVTYDzg3JeB5uwgwU6ibzT952assl14mLx+AE5ponGOR+Dc04cwFJcD4dK9COVAIi/AbOQnQZqoNFPoJMi5Gub2MhY2rr5glIr+RbLNZWuQ3WfufTUoHmBr0srNfflrhGUVATPJ08Bd3dwYzWfwo8eSMIw6GrS4LPhjBkW/UJXPLivOKnXp3xp4g1Bh6wwwQb25Egyby/dfmFUJTPLyHvEtvPhYBSpgdNcpILoq5EyzblD+W9njbtbqKpzJ2zvuDwNxnVWHkVLlwX6JoPtAxdb1V7vfzY/EDc+QjnzvyG4KBsaVCDZbm7MBtgxvSb1oh5XVmUZGs7FQ2905okMtmrac47/IzEKME0Sj9FD/O5gbCSXD/V9fEXhBvO3cLJrlKD0acC2PEIQmGxUQlaF/kLyErbX1RqqQ+xOMouPCzFunhamUHvp6C1M1GDHs5vTpA4bzhnPFVLYgzIPsAQtkKBJ5U+uOWw2/iMuRw1V4qG215VcqSGTMvuQE8udSF2DCVKnNrNLGcJad7LOx8azNfAahGcD5IKrbhwwuDPmJD6YzI/Xr52O6cfimL4qv8ytU2V2kYrdQu4nJ+G7x92UwHfIeHW33S1
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(346002)(39860400002)(46966006)(40470700004)(36840700001)(8676002)(4326008)(356005)(54906003)(478600001)(40460700003)(7696005)(47076005)(41300700001)(336012)(6666004)(186003)(2906002)(8936002)(426003)(110136005)(7406005)(26005)(7416002)(16526019)(83380400001)(30864003)(1076003)(2616005)(107886003)(40480700001)(316002)(36756003)(82740400003)(81166007)(36860700001)(82310400005)(70586007)(5660300002)(70206006)(2004002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 09:16:20.5109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a7615d-6536-4168-d780-08da5a79323b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4509
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 AUTHORS                                       |   1 +
 bash-completion/Makemodule.am                 |   3 +
 bash-completion/blkverify                     |  34 +++
 configure.ac                                  |   4 +
 include/blkdev.h                              |   4 +
 meson.build                                   |  12 +
 sys-utils/Makemodule.am                       |   9 +
 sys-utils/blkverify.8.adoc                    |  57 +++++
 sys-utils/blkverify.c                         | 207 ++++++++++++++++++
 sys-utils/fstrim.8.adoc                       |   1 +
 sys-utils/meson.build                         |   5 +
 tests/commands.sh                             |   1 +
 tests/expected/blkverify/offsets              |  48 ++++
 tests/expected/blkverify/offsets.err          |  20 ++
 tests/expected/build-sys/config-all           |   1 +
 tests/expected/build-sys/config-all-non-nls   |   1 +
 tests/expected/build-sys/config-audit         |   1 +
 .../expected/build-sys/config-chfnsh-libuser  |   1 +
 .../build-sys/config-chfnsh-no-password       |   1 +
 tests/expected/build-sys/config-chfnsh-pam    |   1 +
 tests/expected/build-sys/config-core          |   1 +
 tests/expected/build-sys/config-devel         |   1 +
 .../expected/build-sys/config-devel-non-asan  |   1 +
 .../expected/build-sys/config-devel-non-docs  |   1 +
 tests/expected/build-sys/config-non-libblkid  |   1 +
 tests/expected/build-sys/config-non-libmount  |   1 +
 tests/expected/build-sys/config-non-libs      |   1 +
 .../build-sys/config-non-libsmartcols         |   1 +
 tests/expected/build-sys/config-non-libuuid   |   1 +
 tests/expected/build-sys/config-non-nls       |   1 +
 tests/expected/build-sys/config-selinux       |   1 +
 tests/expected/build-sys/config-slang         |   1 +
 tests/expected/build-sys/config-static        |   1 +
 tests/ts/blkverify/offsets                    |  91 ++++++++
 34 files changed, 516 insertions(+)
 create mode 100644 bash-completion/blkverify
 create mode 100644 sys-utils/blkverify.8.adoc
 create mode 100644 sys-utils/blkverify.c
 create mode 100644 tests/expected/blkverify/offsets
 create mode 100644 tests/expected/blkverify/offsets.err
 create mode 100755 tests/ts/blkverify/offsets

diff --git a/AUTHORS b/AUTHORS
index f0e88af19..3cf8f7452 100644
--- a/AUTHORS
+++ b/AUTHORS
@@ -15,6 +15,7 @@ PAST MAINTAINERS:
 AUTHORS (merged projects & commands):
 
       blkdiscard:      Lukas Czerner <lczerner@redhat.com>
+      blkverify:       Chaitanya Kulkarni <kch@nvidia.com>
       blkzone:         Shaun Tancheff <shaun@tancheff.com>
                        Damien Le Moal <damien.lemoal@wdc.com>
       fallocate:       Eric Sandeen <sandeen@redhat.com>
diff --git a/bash-completion/Makemodule.am b/bash-completion/Makemodule.am
index 5d59b5593..3857bd705 100644
--- a/bash-completion/Makemodule.am
+++ b/bash-completion/Makemodule.am
@@ -279,6 +279,9 @@ endif
 if BUILD_BLKDISCARD
 dist_bashcompletion_DATA += bash-completion/blkdiscard
 endif
+if BUILD_BLKVERIFY
+dist_bashcompletion_DATA += bash-completion/blkverify
+endif
 if BUILD_BLKZONE
 dist_bashcompletion_DATA += bash-completion/blkzone
 endif
diff --git a/bash-completion/blkverify b/bash-completion/blkverify
new file mode 100644
index 000000000..dcbae19b0
--- /dev/null
+++ b/bash-completion/blkverify
@@ -0,0 +1,34 @@
+_blkverify_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-o'|'--offset'|'-l'|'--length'|'-p'|'--step')
+			COMPREPLY=( $(compgen -W "num" -- $cur) )
+			return 0
+			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
+	esac
+	case $cur in
+		-*)
+			OPTS="
+				--offset
+				--length
+				--step
+				--verbose
+				--help
+				--version
+			"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	compopt -o bashdefault -o default
+	COMPREPLY=( $(compgen -W "$(lsblk -pnro name)" -- $cur) )
+	return 0
+}
+complete -F _blkverify_module blkverify
diff --git a/configure.ac b/configure.ac
index 3ac79a503..050017cae 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1993,6 +1993,10 @@ UL_BUILD_INIT([blkdiscard], [check])
 UL_REQUIRES_LINUX([blkdiscard])
 AM_CONDITIONAL([BUILD_BLKDISCARD], [test "x$build_blkdiscard" = xyes])
 
+UL_BUILD_INIT([blkverify], [check])
+UL_REQUIRES_LINUX([blkverify])
+AM_CONDITIONAL([BUILD_BLKVERIFY], [test "x$build_blkverify" = xyes])
+
 UL_BUILD_INIT([blkzone], [check])
 UL_REQUIRES_LINUX([blkzone])
 UL_REQUIRES_HAVE([blkzone], [linux_blkzoned_h], [linux/blkzoned.h header])
diff --git a/include/blkdev.h b/include/blkdev.h
index 43a5f5224..6b5683b99 100644
--- a/include/blkdev.h
+++ b/include/blkdev.h
@@ -64,6 +64,10 @@
 #  define BLKDISCARDZEROES _IO(0x12,124)
 # endif
 
+# ifndef BLKVERIFY
+#  define BLKVERIFY _IO(0x12,129)
+# endif
+
 /* filesystem freeze, introduced in 2.6.29 (commit fcccf502) */
 # ifndef FIFREEZE
 #  define FIFREEZE   _IOWR('X', 119, int)    /* Freeze */
diff --git a/meson.build b/meson.build
index 460c322e7..1c92d42b0 100644
--- a/meson.build
+++ b/meson.build
@@ -1346,6 +1346,18 @@ exes += exe
 manadocs += ['sys-utils/blkdiscard.8.adoc']
 bashcompletions += ['blkdiscard']
 
+exe = executable(
+  'blkverify',
+  blkverify_sources,
+  include_directories : includes,
+  link_with : [lib_common,
+               lib_blkid],
+  install_dir : sbindir,
+  install : true)
+exes += exe
+manadocs += ['sys-utils/blkverify.8.adoc']
+bashcompletions += ['blkverify']
+
 exe = executable(
   'blkzone',
   blkzone_sources,
diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
index 22047d9bd..61daa3c23 100644
--- a/sys-utils/Makemodule.am
+++ b/sys-utils/Makemodule.am
@@ -194,6 +194,15 @@ blkdiscard_CFLAGS += -I$(ul_libblkid_incdir)
 endif
 endif
 
+if BUILD_BLKVERIFY
+sbin_PROGRAMS += blkverify
+MANPAGES += sys-utils/blkverify.8
+dist_noinst_DATA += sys-utils/blkverify.8.adoc
+blkverify_SOURCES = sys-utils/blkverify.c lib/monotonic.c
+blkverify_LDADD = $(LDADD) libcommon.la $(REALTIME_LIBS)
+blkverify_CFLAGS = $(AM_CFLAGS)
+endif
+
 if BUILD_BLKZONE
 sbin_PROGRAMS += blkzone
 MANPAGES += sys-utils/blkzone.8
diff --git a/sys-utils/blkverify.8.adoc b/sys-utils/blkverify.8.adoc
new file mode 100644
index 000000000..0cc3881d2
--- /dev/null
+++ b/sys-utils/blkverify.8.adoc
@@ -0,0 +1,57 @@
+//po4a: entry man manual
+= blkverify(8)
+:doctype: manpage
+:man manual: System Administration
+:man source: util-linux {release-version}
+:page-layout: base
+:command: blkverify
+
+== NAME
+
+blkverify - verify sectors on a device
+
+== SYNOPSIS
+
+*blkverify* [options] [*-o* _offset_] [*-l* _length_] _device_
+
+== DESCRIPTION
+
+*blkverify* is used to verify device sectors. This is useful in order to provide low level media scrubbing and possibly moving the data to the right place in case it has correctable media degradation. Also, this provides a way to enhance file-system level scrubbing/checksum verification and optinally offload this task, which is CPU intensive, to the kernel (when emulated), over the fabric, and to the controller (when supported). This command is used directly on the block device.
+
+By default, *blkverify* will verify all blocks on the device. Options may be used to modify this behavior based on range or size, as explained below.
+
+The _device_ argument is the pathname of the block device.
+
+== OPTIONS
+
+The _offset_ and _length_ arguments may be followed by the multiplicative suffixes KiB (=1024), MiB (=1024*1024), and so on for GiB, TiB, PiB, EiB, ZiB and YiB (the "iB" is optional, e.g., "K" has the same meaning as "KiB") or the suffixes KB (=1000), MB (=1000*1000), and so on for GB, TB, PB, EB, ZB and YB.
+
+*-o*, *--offset* _offset_::
+Byte offset into the device from which to start verifying. The provided value must be aligned to the device sector size. The default value is zero.
+
+*-l*, *--length* _length_::
+The number of bytes to verify (counting from the starting point). The provided value must be aligned to the device sector size. If the specified value extends past the end of the device, *blkverify* will stop at the device size boundary. The default value extends to the end of the device.
+
+*-p*, *--step* _length_::
+The number of bytes to verify within one iteration. The default is to verify all by one ioctl call.
+
+*-v*, *--verbose*::
+Display the aligned values of _offset_ and _length_. If the *--step* option is specified, it prints the verify progress every second.
+
+include::man-common/help-version.adoc[]
+
+== AUTHORS
+
+mailto:kch@nvidia.com[Chaitanya Kulkarni]
+
+== SEE ALSO
+
+*fstrim*(8)
+
+include::man-common/bugreports.adoc[]
+
+include::man-common/footer.adoc[]
+
+ifdef::translation[]
+include::man-common/translation.adoc[]
+endif::[]
diff --git a/sys-utils/blkverify.c b/sys-utils/blkverify.c
new file mode 100644
index 000000000..9d6c3a85e
--- /dev/null
+++ b/sys-utils/blkverify.c
@@ -0,0 +1,207 @@
+/*
+ * blkverify.c -- Verify the part (or whole) of the block device.
+ *
+ * This program uses BLKVERIFY ioctl to verify part or the whole block
+ * device if the device supports it. You can specify range (start and
+ * length) to be verified, or simply verify the whole device.
+ */
+
+
+#include <string.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <getopt.h>
+#include <time.h>
+
+#include <sys/ioctl.h>
+#include <sys/stat.h>
+#include <sys/time.h>
+#include <linux/fs.h>
+
+#include "nls.h"
+#include "strutils.h"
+#include "c.h"
+#include "closestream.h"
+#include "monotonic.h"
+
+#ifndef BLKVERIFY
+#define BLKVERIFY _IO(0x12,129)
+#endif
+
+enum {
+	ACT_VERIFY = 0,	/* default */
+};
+
+static void print_stats(int act, char *path, uint64_t stats[])
+{
+	switch (act) {
+	case ACT_VERIFY:
+		printf(_("%s: Verified %" PRIu64 " bytes from the offset %" PRIu64"\n"), \
+			path, stats[1], stats[0]);
+		break;
+	}
+}
+
+static void __attribute__((__noreturn__)) usage(void)
+{
+	FILE *out = stdout;
+
+	fputs(USAGE_HEADER, out);
+	fprintf(out,
+	      _(" %s [options] <device>\n"), program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs(_("Verify the content of sectors on a device.\n"), out);
+
+	fputs(USAGE_OPTIONS, out);
+	fputs(_(" -o, --offset <num>  offset in bytes to verify from\n"), out);
+	fputs(_(" -l, --length <num>  length of bytes to verify from the offset\n"), out);
+	fputs(_(" -p, --step <num>    size of the verify iterations within the offset\n"), out);
+	fputs(_(" -v, --verbose       print aligned length and offset\n"), out);
+
+	fputs(USAGE_SEPARATOR, out);
+	printf(USAGE_HELP_OPTIONS(21));
+
+	fputs(USAGE_ARGUMENTS, out);
+	printf(USAGE_ARG_SIZE(_("<num>")));
+
+	printf(USAGE_MAN_TAIL("blkverify(8)"));
+	exit(EXIT_SUCCESS);
+}
+
+int main(int argc, char **argv)
+{
+	char *path;
+	int c, fd, verbose = 0, secsize;
+	uint64_t end, blksize, step, range[2], stats[2];
+	struct stat sb;
+	struct timeval now = { 0 }, last = { 0 };
+	int act = ACT_VERIFY;
+
+	static const struct option longopts[] = {
+	    { "help",      no_argument,       NULL, 'h' },
+	    { "version",   no_argument,       NULL, 'V' },
+	    { "offset",    required_argument, NULL, 'o' },
+	    { "length",    required_argument, NULL, 'l' },
+	    { "step",      required_argument, NULL, 'p' },
+	    { "verbose",   no_argument,       NULL, 'v' },
+	    { NULL, 0, NULL, 0 }
+	};
+
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+	close_stdout_atexit();
+
+	range[0] = 0;
+	range[1] = ULLONG_MAX;
+	step = 0;
+
+	while ((c = getopt_long(argc, argv, "hVvo:l:p:", longopts, NULL)) != -1) {
+		switch(c) {
+		case 'l':
+			range[1] = strtosize_or_err(optarg,
+					_("failed to parse length"));
+			break;
+		case 'o':
+			range[0] = strtosize_or_err(optarg,
+					_("failed to parse offset"));
+			break;
+		case 'p':
+			step = strtosize_or_err(optarg,
+					_("failed to parse step"));
+			break;
+		case 'v':
+			verbose = 1;
+			break;
+
+		case 'h':
+			usage();
+		case 'V':
+			print_version(EXIT_SUCCESS);
+		default:
+			errtryhelp(EXIT_FAILURE);
+		}
+	}
+
+	if (optind == argc)
+		errx(EXIT_FAILURE, _("no device specified"));
+
+	path = argv[optind++];
+
+	if (optind != argc) {
+		warnx(_("unexpected number of arguments"));
+		errtryhelp(EXIT_FAILURE);
+	}
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		err(EXIT_FAILURE, _("cannot open %s"), path);
+
+	if (fstat(fd, &sb) == -1)
+		err(EXIT_FAILURE, _("stat of %s failed"), path);
+	if (!S_ISBLK(sb.st_mode))
+		errx(EXIT_FAILURE, _("%s: not a block device"), path);
+
+	if (ioctl(fd, BLKGETSIZE64, &blksize))
+		err(EXIT_FAILURE, _("%s: BLKGETSIZE64 ioctl failed"), path);
+	if (ioctl(fd, BLKSSZGET, &secsize))
+		err(EXIT_FAILURE, _("%s: BLKSSZGET ioctl failed"), path);
+
+	/* check offset alignment to the sector size */
+	if (range[0] % secsize)
+		errx(EXIT_FAILURE, _("%s: offset %" PRIu64 " is not aligned "
+			 "to sector size %i"), path, range[0], secsize);
+
+	/* is the range end behind the end of the device ?*/
+	if (range[0] > blksize)
+		errx(EXIT_FAILURE, _("%s: offset is greater than device size"), path);
+	end = range[0] + range[1];
+	if (end < range[0] || end > blksize)
+		end = blksize;
+
+	range[1] = (step > 0) ? step : end - range[0];
+
+	/* check length alignment to the sector size */
+	if (range[1] % secsize)
+		errx(EXIT_FAILURE, _("%s: length %" PRIu64 " is not aligned "
+			 "to sector size %i"), path, range[1], secsize);
+
+	stats[0] = range[0], stats[1] = 0;
+	gettime_monotonic(&last);
+
+	for (/* nothing */; range[0] < end; range[0] += range[1]) {
+		if (range[0] + range[1] > end)
+			range[1] = end - range[0];
+
+		switch (act) {
+		case ACT_VERIFY:
+			if (ioctl(fd, BLKVERIFY, &range))
+				err(EXIT_FAILURE, _("%s: BLKVERIFY ioctl failed"), path);
+			break;
+		}
+
+		stats[1] += range[1];
+
+		/* reporting progress at most once per second */
+		if (verbose && step) {
+			gettime_monotonic(&now);
+			if (now.tv_sec > last.tv_sec &&
+			    (now.tv_usec >= last.tv_usec || now.tv_sec > last.tv_sec + 1)) {
+				print_stats(act, path, stats);
+				stats[0] += stats[1], stats[1] = 0;
+				last = now;
+			}
+		}
+	}
+
+	if (verbose && stats[1])
+		print_stats(act, path, stats);
+
+	close(fd);
+	return EXIT_SUCCESS;
+}
diff --git a/sys-utils/fstrim.8.adoc b/sys-utils/fstrim.8.adoc
index 7accc4273..8f20a6311 100644
--- a/sys-utils/fstrim.8.adoc
+++ b/sys-utils/fstrim.8.adoc
@@ -83,6 +83,7 @@ mailto:kzak@redhat.com[Karel Zak]
 == SEE ALSO
 
 *blkdiscard*(8),
+*blkverify*(8),
 *mount*(8)
 
 include::man-common/bugreports.adoc[]
diff --git a/sys-utils/meson.build b/sys-utils/meson.build
index 4b6cb7a1c..f27c8165b 100644
--- a/sys-utils/meson.build
+++ b/sys-utils/meson.build
@@ -70,6 +70,11 @@ blkdiscard_sources = files(
 ) + \
   monotonic_c
 
+blkverify_sources = files(
+  'blkverify.c',
+) + \
+  monotonic_c
+
 blkzone_sources = files(
   'blkzone.c',
 )
diff --git a/tests/commands.sh b/tests/commands.sh
index aff324c1f..a6db49339 100644
--- a/tests/commands.sh
+++ b/tests/commands.sh
@@ -50,6 +50,7 @@ TS_HELPER_MKFDS="${ts_helpersdir}test_mkfds"
 TS_CMD_ADDPART=${TS_CMD_ADDPART:-"${ts_commandsdir}addpart"}
 TS_CMD_DELPART=${TS_CMD_DELPART:-"${ts_commandsdir}delpart"}
 TS_CMD_BLKDISCARD=${TS_CMD_BLKID-"${ts_commandsdir}blkdiscard"}
+TS_CMD_BLKVERIFY=${TS_CMD_BLKID-"${ts_commandsdir}blkverify"}
 TS_CMD_BLKID=${TS_CMD_BLKID-"${ts_commandsdir}blkid"}
 TS_CMD_CAL=${TS_CMD_CAL-"${ts_commandsdir}cal"}
 TS_CMD_COLCRT=${TS_CMD_COLCRT:-"${ts_commandsdir}colcrt"}
diff --git a/tests/expected/blkverify/offsets b/tests/expected/blkverify/offsets
new file mode 100644
index 000000000..cf1270a11
--- /dev/null
+++ b/tests/expected/blkverify/offsets
@@ -0,0 +1,48 @@
+testing offsets with full block size
+Verified 1073741824 bytes from the offset 0
+ret: 0
+ret: 1
+ret: 1
+Verified 1073741312 bytes from the offset 512
+ret: 0
+Verified 1073740800 bytes from the offset 1024
+ret: 0
+testing offsets with specific length
+Verified 5242880 bytes from the offset 0
+ret: 0
+ret: 1
+ret: 1
+ret: 1
+ret: 1
+Verified 5242880 bytes from the offset 512
+ret: 0
+Verified 5242880 bytes from the offset 1024
+ret: 0
+testing aligned steps full device
+Verified 1073741824 bytes from the offset 0
+ret: 0
+Verified 1073741824 bytes from the offset 0
+ret: 0
+testing aligned steps with offsets and length
+Verified 1024 bytes from the offset 0
+ret: 0
+ret: 1
+ret: 1
+ret: 1
+Verified 1536 bytes from the offset 512
+ret: 0
+Verified 1024 bytes from the offset 1024
+ret: 0
+testing misaligned steps full device
+ret: 1
+ret: 1
+ret: 1
+ret: 1
+ret: 1
+testing misaligned steps with offsets and length
+ret: 1
+ret: 1
+ret: 1
+ret: 1
+ret: 1
+ret: 1
diff --git a/tests/expected/blkverify/offsets.err b/tests/expected/blkverify/offsets.err
new file mode 100644
index 000000000..8898aa149
--- /dev/null
+++ b/tests/expected/blkverify/offsets.err
@@ -0,0 +1,20 @@
+blkverify: offset 1 is not aligned to sector size 512
+blkverify: offset 511 is not aligned to sector size 512
+blkverify: length 5242881 is not aligned to sector size 512
+blkverify: length 5243391 is not aligned to sector size 512
+blkverify: offset 1 is not aligned to sector size 512
+blkverify: offset 511 is not aligned to sector size 512
+blkverify: offset 1 is not aligned to sector size 512
+blkverify: offset 1 is not aligned to sector size 512
+blkverify: offset 511 is not aligned to sector size 512
+blkverify: length 1 is not aligned to sector size 512
+blkverify: length 256 is not aligned to sector size 512
+blkverify: length 511 is not aligned to sector size 512
+blkverify: length 513 is not aligned to sector size 512
+blkverify: length 768 is not aligned to sector size 512
+blkverify: length 511 is not aligned to sector size 512
+blkverify: offset 1 is not aligned to sector size 512
+blkverify: offset 511 is not aligned to sector size 512
+blkverify: length 511 is not aligned to sector size 512
+blkverify: offset 1 is not aligned to sector size 512
+blkverify: offset 511 is not aligned to sector size 512
diff --git a/tests/expected/build-sys/config-all b/tests/expected/build-sys/config-all
index cc09c6596..108a7f798 100644
--- a/tests/expected/build-sys/config-all
+++ b/tests/expected/build-sys/config-all
@@ -1,4 +1,5 @@
 blkdiscard:  libblkid 
+blkverify:   
 blkid:  libblkid 
 cfdisk:  libfdisk libmount libncursesw libsmartcols libtinfo 
 column:  libsmartcols 
diff --git a/tests/expected/build-sys/config-all-non-nls b/tests/expected/build-sys/config-all-non-nls
index cc09c6596..108a7f798 100644
--- a/tests/expected/build-sys/config-all-non-nls
+++ b/tests/expected/build-sys/config-all-non-nls
@@ -1,4 +1,5 @@
 blkdiscard:  libblkid 
+blkverify:   
 blkid:  libblkid 
 cfdisk:  libfdisk libmount libncursesw libsmartcols libtinfo 
 column:  libsmartcols 
diff --git a/tests/expected/build-sys/config-audit b/tests/expected/build-sys/config-audit
index 4031db086..548ba483d 100644
--- a/tests/expected/build-sys/config-audit
+++ b/tests/expected/build-sys/config-audit
@@ -1,4 +1,5 @@
 blkdiscard:  libblkid 
+blkverify:   
 blkid:  libblkid 
 cfdisk:  libfdisk libmount libncursesw libsmartcols libtinfo 
 column:  libsmartcols 
diff --git a/tests/expected/build-sys/config-chfnsh-libuser b/tests/expected/build-sys/config-chfnsh-libuser
index 0059b3812..564aa5dc6 100644
--- a/tests/expected/build-sys/config-chfnsh-libuser
+++ b/tests/expected/build-sys/config-chfnsh-libuser
@@ -1,4 +1,5 @@
 blkdiscard:  libblkid 
+blkverify:   
 blkid:  libblkid 
 cfdisk:  libfdisk libmount libncursesw libsmartcols libtinfo 
 column:  libsmartcols 
diff --git a/tests/expected/build-sys/config-chfnsh-no-password b/tests/expected/build-sys/config-chfnsh-no-password
index 35d5f722d..1aad8484d 100644
--- a/tests/expected/build-sys/config-chfnsh-no-password
+++ b/tests/expected/build-sys/config-chfnsh-no-password
@@ -1,4 +1,5 @@
 blkdiscard:  libblkid 
+blkverify:   
 blkid:  libblkid 
 cfdisk:  libfdisk libmount libncursesw libsmartcols libtinfo 
 column:  libsmartcols 
diff --git a/tests/expected/build-sys/config-chfnsh-pam b/tests/expected/build-sys/config-chfnsh-pam
index eae24a293..a7d7e8766 100644
--- a/tests/expected/build-sys/config-chfnsh-pam
+++ b/tests/expected/build-sys/config-chfnsh-pam
@@ -1,4 +1,5 @@
 blkdiscard:  libblkid 
+blkverify:   
 blkid:  libblkid 
 cfdisk:  libfdisk libmount libncursesw libsmartcols libtinfo 
 column:  libsmartcols 
diff --git a/tests/expected/build-sys/config-core b/tests/expected/build-sys/config-core
index fed47bb64..33f7c38a0 100644
--- a/tests/expected/build-sys/config-core
+++ b/tests/expected/build-sys/config-core
@@ -1,4 +1,5 @@
 blkdiscard:  libblkid 
+blkverify:   
 blkid:  libblkid 
 cfdisk:  libfdisk libmount libncursesw libsmartcols libtinfo 
 column:  libsmartcols 
diff --git a/tests/expected/build-sys/config-devel b/tests/expected/build-sys/config-devel
index d80af4675..9fc453d04 100644
--- a/tests/expected/build-sys/config-devel
+++ b/tests/expected/build-sys/config-devel
@@ -1,4 +1,5 @@
 blkdiscard:  libblkid 
+blkverify:   
 blkid:  libblkid 
 cfdisk:  libfdisk libmount libncursesw libsmartcols libtinfo 
 column:  libsmartcols 
diff --git a/tests/expected/build-sys/config-devel-non-asan b/tests/expected/build-sys/config-devel-non-asan
index d80af4675..9fc453d04 100644
--- a/tests/expected/build-sys/config-devel-non-asan
+++ b/tests/expected/build-sys/config-devel-non-asan
@@ -1,4 +1,5 @@
 blkdiscard:  libblkid 
+blkverify:   
 blkid:  libblkid 
 cfdisk:  libfdisk libmount libncursesw libsmartcols libtinfo 
 column:  libsmartcols 
diff --git a/tests/expected/build-sys/config-devel-non-docs b/tests/expected/build-sys/config-devel-non-docs
index d80af4675..9fc453d04 100644
--- a/tests/expected/build-sys/config-devel-non-docs
+++ b/tests/expected/build-sys/config-devel-non-docs
@@ -1,4 +1,5 @@
 blkdiscard:  libblkid 
+blkverify:   
 blkid:  libblkid 
 cfdisk:  libfdisk libmount libncursesw libsmartcols libtinfo 
 column:  libsmartcols 
diff --git a/tests/expected/build-sys/config-non-libblkid b/tests/expected/build-sys/config-non-libblkid
index bc34d67e6..3ce1809ea 100644
--- a/tests/expected/build-sys/config-non-libblkid
+++ b/tests/expected/build-sys/config-non-libblkid
@@ -1,4 +1,5 @@
 cfdisk:  libfdisk libncursesw libsmartcols libtinfo 
+blkverify:   
 column:  libsmartcols 
 fdisk:  libfdisk libreadline libsmartcols libtinfo 
 fincore:  libsmartcols 
diff --git a/tests/expected/build-sys/config-non-libmount b/tests/expected/build-sys/config-non-libmount
index 890f7c2f9..cffdb0f42 100644
--- a/tests/expected/build-sys/config-non-libmount
+++ b/tests/expected/build-sys/config-non-libmount
@@ -1,4 +1,5 @@
 blkdiscard:  libblkid 
+blkverify:   
 blkid:  libblkid 
 cfdisk:  libfdisk libncursesw libsmartcols libtinfo 
 column:  libsmartcols 
diff --git a/tests/expected/build-sys/config-non-libs b/tests/expected/build-sys/config-non-libs
index 5bf0e0c9d..018d7d96c 100644
--- a/tests/expected/build-sys/config-non-libs
+++ b/tests/expected/build-sys/config-non-libs
@@ -1,5 +1,6 @@
 agetty:  
 blkdiscard:  
+blkverify:  
 blkzone:  
 blockdev:  
 cal:  libtinfo 
diff --git a/tests/expected/build-sys/config-non-libsmartcols b/tests/expected/build-sys/config-non-libsmartcols
index d58ec93c3..13fcba8ea 100644
--- a/tests/expected/build-sys/config-non-libsmartcols
+++ b/tests/expected/build-sys/config-non-libsmartcols
@@ -1,4 +1,5 @@
 blkdiscard:  libblkid 
+blkverify:   
 blkid:  libblkid 
 eject:  libmount 
 findfs:  libblkid 
diff --git a/tests/expected/build-sys/config-non-libuuid b/tests/expected/build-sys/config-non-libuuid
index 77912475c..373351d26 100644
--- a/tests/expected/build-sys/config-non-libuuid
+++ b/tests/expected/build-sys/config-non-libuuid
@@ -1,4 +1,5 @@
 blkdiscard:  libblkid 
+blkverify:   
 blkid:  libblkid 
 column:  libsmartcols 
 eject:  libmount 
diff --git a/tests/expected/build-sys/config-non-nls b/tests/expected/build-sys/config-non-nls
index fed47bb64..33f7c38a0 100644
--- a/tests/expected/build-sys/config-non-nls
+++ b/tests/expected/build-sys/config-non-nls
@@ -1,4 +1,5 @@
 blkdiscard:  libblkid 
+blkverify:   
 blkid:  libblkid 
 cfdisk:  libfdisk libmount libncursesw libsmartcols libtinfo 
 column:  libsmartcols 
diff --git a/tests/expected/build-sys/config-selinux b/tests/expected/build-sys/config-selinux
index fcb55bda2..e9d637a9b 100644
--- a/tests/expected/build-sys/config-selinux
+++ b/tests/expected/build-sys/config-selinux
@@ -1,4 +1,5 @@
 blkdiscard:  libblkid 
+blkverify:   
 blkid:  libblkid 
 cfdisk:  libfdisk libmount libncursesw libsmartcols libtinfo 
 column:  libsmartcols 
diff --git a/tests/expected/build-sys/config-slang b/tests/expected/build-sys/config-slang
index 8eea3cf1c..fd6d1ee1e 100644
--- a/tests/expected/build-sys/config-slang
+++ b/tests/expected/build-sys/config-slang
@@ -1,4 +1,5 @@
 blkdiscard:  libblkid 
+blkverify:   
 blkid:  libblkid 
 cfdisk:  libfdisk libmount libslang libsmartcols libtinfo 
 column:  libsmartcols 
diff --git a/tests/expected/build-sys/config-static b/tests/expected/build-sys/config-static
index 8d1b4b9b5..69c258c6a 100644
--- a/tests/expected/build-sys/config-static
+++ b/tests/expected/build-sys/config-static
@@ -1,4 +1,5 @@
 blkdiscard:  libblkid 
+blkverify:   
 blkid:  libblkid 
 cfdisk:  libfdisk libmount libncursesw libsmartcols libtinfo 
 column:  libsmartcols 
diff --git a/tests/ts/blkverify/offsets b/tests/ts/blkverify/offsets
new file mode 100755
index 000000000..56e27f6c1
--- /dev/null
+++ b/tests/ts/blkverify/offsets
@@ -0,0 +1,91 @@
+#!/bin/bash
+
+#
+# Copyright (C) 2022 <kch@nvidia.com>
+#
+# This file is part of util-linux.
+#
+# This file is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This file is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="offsets"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+ts_check_test_command "$TS_CMD_BLKVERIFY"
+ts_skip_nonroot
+
+ORIGPWD=$(pwd)
+modprobe -r null_blk
+modprobe null_blk gb=1
+
+DEVICE=$(ls /dev/nullb*)
+function run_tscmd {
+	local ret
+
+	"$@" >> $TS_OUTPUT 2>> $TS_ERRLOG
+	ret=$?
+	echo "ret: $ret" >> "$TS_OUTPUT"
+	return $ret
+}
+
+ts_log "testing offsets with full block size"
+run_tscmd $TS_CMD_BLKVERIFY -v $DEVICE
+if [ "$?" != "0" ]; then
+	# Skip the rest? For example loop backing files on NFS seem unsupported.
+	grep -q "BLKVERIFY ioctl failed: Operation not supported" "$TS_ERRLOG" \
+		&& ts_skip "BLKVERIFY not supported"
+fi
+run_tscmd $TS_CMD_BLKVERIFY -v -o 1 $DEVICE
+run_tscmd $TS_CMD_BLKVERIFY -v -o 511 $DEVICE
+run_tscmd $TS_CMD_BLKVERIFY -v -o 512 $DEVICE
+run_tscmd $TS_CMD_BLKVERIFY -v -o 1024 $DEVICE
+
+ts_log "testing offsets with specific length"
+run_tscmd $TS_CMD_BLKVERIFY -v -l 5242880 $DEVICE
+run_tscmd $TS_CMD_BLKVERIFY -v -l 5242881 $DEVICE
+run_tscmd $TS_CMD_BLKVERIFY -v -l 5243391 $DEVICE
+run_tscmd $TS_CMD_BLKVERIFY -v -o 1 -l 5242880 $DEVICE
+run_tscmd $TS_CMD_BLKVERIFY -v -o 511 -l 5242880 $DEVICE
+run_tscmd $TS_CMD_BLKVERIFY -v -o 512 -l 5242880 $DEVICE
+run_tscmd $TS_CMD_BLKVERIFY -v -o 1024 -l 5242880 $DEVICE
+
+ts_log "testing aligned steps full device"
+run_tscmd $TS_CMD_BLKVERIFY -v -p 5242880 $DEVICE
+run_tscmd $TS_CMD_BLKVERIFY -v -p 1310720 $DEVICE
+
+ts_log "testing aligned steps with offsets and length"
+run_tscmd $TS_CMD_BLKVERIFY -v -p 512 -l 1024 $DEVICE
+run_tscmd $TS_CMD_BLKVERIFY -v -p 512 -o 1 -l 1024 $DEVICE
+run_tscmd $TS_CMD_BLKVERIFY -v -p 512 -o 1 -l 1536 $DEVICE
+run_tscmd $TS_CMD_BLKVERIFY -v -p 512 -o 511 -l 1536 $DEVICE
+run_tscmd $TS_CMD_BLKVERIFY -v -p 512 -o 512 -l 1536 $DEVICE
+run_tscmd $TS_CMD_BLKVERIFY -v -p 512 -o 1024 -l 1024 $DEVICE
+
+ts_log "testing misaligned steps full device"
+run_tscmd $TS_CMD_BLKVERIFY -v -p 1 $DEVICE
+run_tscmd $TS_CMD_BLKVERIFY -v -p 256 $DEVICE
+run_tscmd $TS_CMD_BLKVERIFY -v -p 511 $DEVICE
+run_tscmd $TS_CMD_BLKVERIFY -v -p 513 $DEVICE
+run_tscmd $TS_CMD_BLKVERIFY -v -p 768 $DEVICE
+
+ts_log "testing misaligned steps with offsets and length"
+run_tscmd $TS_CMD_BLKVERIFY -v -p 511 -l 1024 $DEVICE
+run_tscmd $TS_CMD_BLKVERIFY -v -p 511 -o 1 -l 1536 $DEVICE
+run_tscmd $TS_CMD_BLKVERIFY -v -p 511 -o 511 -l 1536 $DEVICE
+run_tscmd $TS_CMD_BLKVERIFY -v -p 511 -l 10240 $DEVICE
+run_tscmd $TS_CMD_BLKVERIFY -v -p 511 -o 1 -l 10240 $DEVICE
+run_tscmd $TS_CMD_BLKVERIFY -v -p 511 -o 511 -l 10240 $DEVICE
+
+sed -i "s#$DEVICE:\s##" $TS_OUTPUT $TS_ERRLOG
+
+ts_cd "$ORIGPWD"
+ts_finalize
-- 
2.29.0

