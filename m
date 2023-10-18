Return-Path: <linux-fsdevel+bounces-608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5187CD9A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 12:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE613B21338
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 10:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419E81A70D;
	Wed, 18 Oct 2023 10:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729B218E05;
	Wed, 18 Oct 2023 10:51:31 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B995FE;
	Wed, 18 Oct 2023 03:51:28 -0700 (PDT)
Received: from weisslap.aisec.fraunhofer.de ([91.67.186.133]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M2Plu-1qpDK02lgs-003vUA; Wed, 18 Oct 2023 12:51:06 +0200
From: =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Christian Brauner <brauner@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Paul Moore <paul@paul-moore.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Quentin Monnet <quentin@isovalent.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	gyroidos@aisec.fraunhofer.de,
	=?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
Subject: [RFC PATCH v2 14/14] device_cgroup: Allow mknod in non-initial userns if guarded
Date: Wed, 18 Oct 2023 12:50:33 +0200
Message-Id: <20231018105033.13669-15-michael.weiss@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231018105033.13669-1-michael.weiss@aisec.fraunhofer.de>
References: <20231018105033.13669-1-michael.weiss@aisec.fraunhofer.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:p+Jv7n/tSXj9VOdub/TyRhRZeiciOIbTx11fcWiGi9mKRboHY1V
 l3Y/axn61Mwfb1USZtNvgmraJ1CvN/YuyhUiM8MPPLLy3N9UcB3qIkXNVazSm0dD2d1J8N7
 uPKVlmahAJpd7/TQyOQPb7QixZrgDlGBQnVqsB55vJGRa/srXyHE/FYrh62/Xb6SLAiNIAZ
 EMgJSuPBLUzKhU2OZ8/jg==
UI-OutboundReport: notjunk:1;M01:P0:bWVLZ0m+uHw=;xZezacsXngGcvH0Bz/M7eP4ELMi
 4AKs7tVSf04OhugwkXmK4kLGTy79PUmq3E2OhojNEXh7mA/P5Hpkd6Gu0iNxVex7N+b38m1mw
 VG5DJO61uPkIhhatZiKXD6Vx3zU+0tf3LRFT/ESZuNw5udUo0lkQnujM0x5hWzT0LyrE9+d/b
 bhjdwEyoyDQQGmcD0CppnWSXW89XpgCccRVLuKCdu4QHEusAaK4MVVDJTGfR01NXZmSjNWjOb
 ltu5zGJg5ezN8IwQ2hNHvQExD5LjaoTZ+7P4RqikOQc1i9kld9B3P23uCh1tIV8G4zdldqNeg
 lyBqE5//uO9VydAokKzr3xW9nbaXMMtXLRk7mGYWQdYcrk3HsUQ4TBjUzHNicacwq75pWhbxS
 7lBcWLXhK67HHijf88W4b9QMXfQMRzh5X3DN2XItGKVjt7GbFuXNSf+XLYThWQSqztBliLqW5
 i/4Hj6LkNwZ4Eud3ros5+f8VhB25d7CCBHPyd5iisNKQK6/KUAgJ5TRp9/ML5g+oWw39N7o+G
 IOhGCaGWeKEgKHLFxhSt4RPDyAd79tLzKBm/f1ayZmE3jLkXNlI3WWtuLVH4BHMeru1gfnRQL
 H53jjRvlxHM8oJnEkMFMSVOy1heQJoZdn4L6b/iLuwMS3bthXFxHdR5BMcTZ+aiyXck2IawtF
 Fv6ynUUeUInBWzpwk9fteyiPvcGHZ6d1lFvMvzlR0+CoeeOHLuHXDmbeoqptZAqR54RdpT0j1
 yYmDGKaAf+ECfucMZWyjtBcHEnq5oeAh7poy5o9pnUOVCgwB6JexbEOSsbIPR4G5VqU9fUBGO
 l2558RO1KZDEekYpURHUWxC7tDkKBFud3PReNx1rcIcp33BT2sCWJ/hBXh//CIptigA+47bzj
 s8PUNBkPd2dr2ko+XFC1YNa8YlxpfKA4R0w0=
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

If a container manager restricts its unprivileged (user namespaced)
children by a device cgroup, it is not necessary to deny mknod()
anymore. Thus, user space applications may map devices on different
locations in the file system by using mknod() inside the container.

A use case for this, we also use in GyroidOS, is to run virsh for
VMs inside an unprivileged container. virsh creates device nodes,
e.g., "/var/run/libvirt/qemu/11-fgfg.dev/null" which currently fails
in a non-initial userns, even if a cgroup device white list with the
corresponding major, minor of /dev/null exists. Thus, in this case
the usual bind mounts or pre populated device nodes under /dev are
not sufficient.

To circumvent this limitation, allow mknod() by checking CAP_MKNOD
in the userns by implementing the security_inode_mknod_nscap(). The
hook implementation checks if the corresponding permission flag
BPF_DEVCG_ACC_MKNOD_UNS is set for the device in the bpf program.
To avoid to create unusable inodes in user space the hook also checks
SB_I_NODEV on the corresponding super block.

Further, the security_sb_alloc_userns() hook is implemented using
cgroup_bpf_current_enabled() to allow usage of device nodes on super
blocks mounted by a guarded task.

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 security/device_cgroup/lsm.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/security/device_cgroup/lsm.c b/security/device_cgroup/lsm.c
index a963536d0a15..6bc984d9c9d1 100644
--- a/security/device_cgroup/lsm.c
+++ b/security/device_cgroup/lsm.c
@@ -66,10 +66,37 @@ static int devcg_inode_mknod(struct inode *dir, struct dentry *dentry,
 	return __devcg_inode_mknod(mode, dev, DEVCG_ACC_MKNOD);
 }
 
+#ifdef CONFIG_CGROUP_BPF
+static int devcg_sb_alloc_userns(struct super_block *sb)
+{
+	if (cgroup_bpf_current_enabled(CGROUP_DEVICE))
+		return 0;
+
+	return -EPERM;
+}
+
+static int devcg_inode_mknod_nscap(struct inode *dir, struct dentry *dentry,
+				       umode_t mode, dev_t dev)
+{
+	if (!cgroup_bpf_current_enabled(CGROUP_DEVICE))
+		return -EPERM;
+
+	// avoid to create unusable inodes in user space
+	if (dentry->d_sb->s_iflags & SB_I_NODEV)
+		return -EPERM;
+
+	return __devcg_inode_mknod(mode, dev, BPF_DEVCG_ACC_MKNOD_UNS);
+}
+#endif /* CONFIG_CGROUP_BPF */
+
 static struct security_hook_list devcg_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(inode_permission, devcg_inode_permission),
 	LSM_HOOK_INIT(inode_mknod, devcg_inode_mknod),
 	LSM_HOOK_INIT(dev_permission, devcg_dev_permission),
+#ifdef CONFIG_CGROUP_BPF
+	LSM_HOOK_INIT(sb_alloc_userns, devcg_sb_alloc_userns),
+	LSM_HOOK_INIT(inode_mknod_nscap, devcg_inode_mknod_nscap),
+#endif
 };
 
 static int __init devcgroup_init(void)
-- 
2.30.2


