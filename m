Return-Path: <linux-fsdevel+bounces-605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FD87CD999
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 12:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B446281C3F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 10:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1293F1946C;
	Wed, 18 Oct 2023 10:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923C28F7E;
	Wed, 18 Oct 2023 10:51:30 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F13DB0;
	Wed, 18 Oct 2023 03:51:26 -0700 (PDT)
Received: from weisslap.aisec.fraunhofer.de ([91.67.186.133]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MgRYd-1rSNl42vux-00hxGN; Wed, 18 Oct 2023 12:50:53 +0200
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
Subject: [RFC PATCH v2 00/14] device_cgroup: guard mknod for non-initial user namespace
Date: Wed, 18 Oct 2023 12:50:19 +0200
Message-Id: <20231018105033.13669-1-michael.weiss@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TCVDyjf67Quvox1tp4WburW/i7Xe/kyPWdjmzGhKsLmNJhAaQH2
 JzqDx60rVSzXILqGgNPJ2FL262n2DzwsQ6lHSxTjmMndb/72enwe/eoNm5pmlTCJHeNKnM5
 dY3QeS+AB/bMN/ItKAZkwHBTWhnX0kW0VBBMnMLu2JI3Uk+BZjRkcMZOJ7rnqbkerft4Pip
 MRtE5jMbwlFMHhjk3227Q==
UI-OutboundReport: notjunk:1;M01:P0:RSiS08FjHjk=;Xt8B6O+IPCTcbtrS0RzTbhWPatn
 w4Z4ZjSOHsWVc9lHtN5nkEeQ8iw7Xh2igz/53X6wmdvRDci2y9ZAjJSj7c9es+e8UFs5UFqpY
 VRokr4QZyegA+3LWLt4WyZFSioEaQhfnfPBDKAsBsWIhBK709nLKduJGmJGzGQFPEteSusHvT
 x9q6zkl0zgB68OkonHBFIb054fNimuegxVPKGeuiVk46Db6BC+jo6bspNWD8LFE7ahr+dyAmt
 lfptmIyGb0KQ1PAtWUmbcM07l4rc0+ICJfyosbG6IpmwAfnCq+JQBSNg2v0bTVomZ4xaxHdZS
 GrRks1NqMSfCUFYuPPQYmREXQ3phcP5y9WAmyUhQs6AufjY0LwkMXyq6apA6/O9FSHt2voPpC
 SsZQ8Toh5HISaW1fFK3p9jUXLCqIaBENwbj957443a684QIA4bqd7Q+SohWOIbTXIXoMLem9I
 6o85j/m6AqFvhZcy85GBcqWjny15LNndr+V+rpoZ35kvf0Juiy6U6tNeSgJAzrZ3UxKpi5+ww
 B12HIhEtiyVxqx7xjegUhY0orNPI4jshap5F/7dhr9NoKshXUVHDupFXZRN7TxmMAOn4+THqb
 WSjGe5lRJvcTV9SKpv9mZtdOmbFyNyfVwLnyKuqtMIMh58fYxiVHszG6L6NCT/QrIirfVFS/G
 HfDW9+Qe1F3srC8VWJAPLfK/E6lgNtfFYNmBIZWJ2Axc6UaBglOqshsKIuyF0+zE7nuq9JfU2
 CTRgwLQwiZf5did818d88choCVjif3EHrB/0hTVRueBqU4HsTQ2WfNdPKjXhdNZxnBbJZJIK3
 puDMKfBvrHTB3sangcuBxHb5B0X4U0pSd4ZtYZ8Xh9kattEDOktAMqgbgR+be03/vjLOYuzZN
 tsyEdzR2wfSEetBYFkdNB2m3QS8zNCm2KdSs=
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Introduce the flag BPF_DEVCG_ACC_MKNOD_UNS for bpf programs of type
BPF_PROG_TYPE_CGROUP_DEVICE which allows to guard access to mknod
in non-initial user namespaces.

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
To avoid to create unusable inodes in user space the hook also
checks SB_I_NODEV on the corresponding super block.

Further, the security_sb_alloc_userns() hook is implemented using
cgroup_bpf_current_enabled() to allow usage of device nodes on super
blocks mounted by a guarded task.

Patch 1 to 3 rework the current devcgroup_inode hooks as an LSM

Patch 4 to 8 rework explicit calls to devcgroup_check_permission
also as LSM hooks and finalize the conversion of the device_cgroup
subsystem to a LSM.

Patch 9 and 10 introduce new generic security hooks to be used
for the actual mknod device guard implementation.

Patch 11 wires up the security hooks in the vfs

Patch 12 and 13 provide helper functions in the bpf cgroup
subsystem.

Patch 14 finally implement the LSM hooks to grand access

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
Changes in v2:
- Integrate this as LSM (Christian, Paul)
- Switched to a device cgroup specific flag instead of a generic
  bpf program flag (Christian)
- do not ignore SB_I_NODEV in fs/namei.c but use LSM hook in
  sb_alloc_super in fs/super.c
- Link to v1: https://lore.kernel.org/r/20230814-devcg_guard-v1-0-654971ab88b1@aisec.fraunhofer.de

Michael Weiß (14):
  device_cgroup: Implement devcgroup hooks as lsm security hooks
  vfs: Remove explicit devcgroup_inode calls
  device_cgroup: Remove explicit devcgroup_inode hooks
  lsm: Add security_dev_permission() hook
  device_cgroup: Implement dev_permission() hook
  block: Switch from devcgroup_check_permission to security hook
  drm/amdkfd: Switch from devcgroup_check_permission to security hook
  device_cgroup: Hide devcgroup functionality completely in lsm
  lsm: Add security_inode_mknod_nscap() hook
  lsm: Add security_sb_alloc_userns() hook
  vfs: Wire up security hooks for lsm-based device guard in userns
  bpf: Add flag BPF_DEVCG_ACC_MKNOD_UNS for device access
  bpf: cgroup: Introduce helper cgroup_bpf_current_enabled()
  device_cgroup: Allow mknod in non-initial userns if guarded

 block/bdev.c                                 |   9 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h        |   7 +-
 fs/namei.c                                   |  24 ++--
 fs/super.c                                   |   6 +-
 include/linux/bpf-cgroup.h                   |   2 +
 include/linux/device_cgroup.h                |  67 -----------
 include/linux/lsm_hook_defs.h                |   4 +
 include/linux/security.h                     |  18 +++
 include/uapi/linux/bpf.h                     |   1 +
 init/Kconfig                                 |   4 +
 kernel/bpf/cgroup.c                          |  14 +++
 security/Kconfig                             |   1 +
 security/Makefile                            |   2 +-
 security/device_cgroup/Kconfig               |   7 ++
 security/device_cgroup/Makefile              |   4 +
 security/{ => device_cgroup}/device_cgroup.c |   3 +-
 security/device_cgroup/device_cgroup.h       |  20 ++++
 security/device_cgroup/lsm.c                 | 114 +++++++++++++++++++
 security/security.c                          |  75 ++++++++++++
 19 files changed, 294 insertions(+), 88 deletions(-)
 delete mode 100644 include/linux/device_cgroup.h
 create mode 100644 security/device_cgroup/Kconfig
 create mode 100644 security/device_cgroup/Makefile
 rename security/{ => device_cgroup}/device_cgroup.c (99%)
 create mode 100644 security/device_cgroup/device_cgroup.h
 create mode 100644 security/device_cgroup/lsm.c


base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
-- 
2.30.2


