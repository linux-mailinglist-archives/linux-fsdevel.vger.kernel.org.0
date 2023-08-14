Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F49B77BB8E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 16:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjHNO1I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 10:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjHNO0o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:26:44 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4A9B2;
        Mon, 14 Aug 2023 07:26:40 -0700 (PDT)
Received: from [127.0.1.1] ([91.67.199.65]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MwjO6-1pXnAR2Gdu-00yAHm; Mon, 14 Aug 2023 16:26:17 +0200
From:   =?utf-8?q?Michael_Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
Date:   Mon, 14 Aug 2023 16:26:12 +0200
Subject: [PATCH RFC 4/4] fs: allow mknod in non-initial userns using cgroup
 device guard
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230814-devcg_guard-v1-4-654971ab88b1@aisec.fraunhofer.de>
References: <20230814-devcg_guard-v1-0-654971ab88b1@aisec.fraunhofer.de>
In-Reply-To: <20230814-devcg_guard-v1-0-654971ab88b1@aisec.fraunhofer.de>
To:     Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Christian Brauner <brauner@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, gyroidos@aisec.fraunhofer.de,
        =?utf-8?q?Michael_Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
X-Mailer: b4 0.12.3
X-Provags-ID: V03:K1:KnYIKMx55P6NK3c2PuhV1Jjt7cPFGO+HnnkYu53YVAgcVZCfr3h
 4Z2EvDbitfpN9SHiCXEva3v7Eaf1aqh0jCzx/Pl3/T06bVjGJ4ocF2ilWIUhc+nmNzH/FRG
 ou/GAwoz57HLmMHB4NUbU2EhXSeSHNSfOPLl/Yz9JRTO7gOXJqqlGq8PpaoO75Z8t0B5ue2
 51GzcyHexLZZdjbOwbofw==
UI-OutboundReport: notjunk:1;M01:P0:ZC+KimZeN+Q=;hFy3WtlerHgRnIyCK1FgNycDelT
 tSlbU/EinBU2IgWv2cHad0g4tD/fF+XI/Ihofiat1cpCrsjndEekjM+UPJV6aFTt1lpByeW1z
 6KuNn22ma5Ca1BEgu8H3jQP3Gx+AsouUS4uCllJIzlUodx5Ol9Zkty4Dd/KFGMvwg7SRbrxgN
 FU+G38weWulGB2RPunAeLAdu8vGaW01v30ucduy9O1NVgUCJ/F2OaEt9fv7s29Gq4SOk4EGXk
 qWaYLp+8+2xE6evTly40GIDQ4QZILo8i7I8sTTaXQ8rFA6t2INpG90HiAE6PAFQLK0M58O6RA
 Iwnzyv/3jmubBV12eNR8ROfaRJsmvjf8NMpfnt6zfHv+5tNLaN7/9m37Ns4l7ZNEpwX/eenHY
 23WDlsZ+DRIsb52kTAReNlXdwA/0ES+Oyo2BymranLj8I8G6D+1sXuos5YMscRESK8eD6p98m
 OKxr6ZcFfRVc+DwxdinnZHasr/E5/6M877674vSsw4zIt9bS3a4/lsvuNsJjyjmiqX3sHGEV7
 0XK7xE0Zu9ypCA7h4QUoPp2fzZydhdah/rGsPlCOckNd2g3eHqQ/fdyrE0epm4Nz/zI8V3hJR
 EqiwS8lFuhC6ktKVHRWmKKOf7h8eO4A3nzIJjdvB/NlZsS/8tWnyFlLaaI6YWWmDgGUCbwfXN
 rfKhbqAd7FDeN7v1fbDPRbeco1Ra9PRlkgs1sHgq5nzTzdL45llUn+YPndRWpDtcf8NMA+KXC
 ghNRnOwuIIstzPpWoX6EZhh/J9n2J12FzG3WYQ4nijD+rm062r3S/dczEUtHfx8crJUCWNPLL
 LSDhQXheZ+/esG2G4p7domdRczsbff0xcNCW4ts4NZjhW80v2BpneNCL4jfWQPZqDEK2X0/ec
 LGbvzftt1FUL72Q==
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If a container manager restricts its unprivileged (user namespaced)
children by a device cgroup, it is not necessary to deny mknod
anymore. Thus, user space applications may map devices on different
locations in the file system by using mknod() inside the container.

A use case for this, we also use in GyroidOS, is to run virsh for
VMs inside an unprivileged container. virsh creates device nodes,
e.g., "/var/run/libvirt/qemu/11-fgfg.dev/null" which currently fails
in a non-initial userns, even if a cgroup device white list with the
corresponding major, minor of /dev/null exists. Thus, in this case
the usual bind mounts or pre populated device nodes under /dev are
not sufficient.

To circumvent this limitation, we allow mknod() in fs/namei.c if a
bpf cgroup device guard is enabeld for the current task using
devcgroup_task_is_guarded() and check CAP_MKNOD for the current user
namespace by ns_capable() instead of the global CAP_MKNOD.

To avoid unusable device nodes on file systems mounted in
non-initial user namespace, may_open_dev() ignores the SB_I_NODEV
for cgroup device guarded tasks.

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 fs/namei.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index e56ff39a79bc..ef4f22b9575c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3221,6 +3221,9 @@ EXPORT_SYMBOL(vfs_mkobj);
 
 bool may_open_dev(const struct path *path)
 {
+	if (devcgroup_task_is_guarded(current))
+		return !(path->mnt->mnt_flags & MNT_NODEV);
+
 	return !(path->mnt->mnt_flags & MNT_NODEV) &&
 		!(path->mnt->mnt_sb->s_iflags & SB_I_NODEV);
 }
@@ -3976,9 +3979,19 @@ int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	if (error)
 		return error;
 
-	if ((S_ISCHR(mode) || S_ISBLK(mode)) && !is_whiteout &&
-	    !capable(CAP_MKNOD))
-		return -EPERM;
+	/*
+	 * In case of a device cgroup restirction allow mknod in user
+	 * namespace. Otherwise just check global capability; thus,
+	 * mknod is also disabled for user namespace other than the
+	 * initial one.
+	 */
+	if ((S_ISCHR(mode) || S_ISBLK(mode)) && !is_whiteout) {
+		if (devcgroup_task_is_guarded(current)) {
+			if (!ns_capable(current_user_ns(), CAP_MKNOD))
+				return -EPERM;
+		} else if (!capable(CAP_MKNOD))
+			return -EPERM;
+	}
 
 	if (!dir->i_op->mknod)
 		return -EPERM;

-- 
2.30.2

