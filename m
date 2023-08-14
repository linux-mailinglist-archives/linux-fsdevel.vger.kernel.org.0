Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA6777BB88
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 16:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbjHNO1F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 10:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjHNO0p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:26:45 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE2AFB;
        Mon, 14 Aug 2023 07:26:40 -0700 (PDT)
Received: from [127.0.1.1] ([91.67.199.65]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MPaQU-1q93rQ3A5C-00McXu; Mon, 14 Aug 2023 16:26:14 +0200
From:   =?utf-8?q?Michael_Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
Subject: [PATCH RFC 0/4] bpf: cgroup device guard for non-initial user
 namespace
Date:   Mon, 14 Aug 2023 16:26:08 +0200
Message-Id: <20230814-devcg_guard-v1-0-654971ab88b1@aisec.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIA52mQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDC0MT3ZTUsuT0+PTSxKIUXVNjS4vUNAuTpDTzJCWgjoKi1LTMCrBp0Up
 Bbs5KsbW1ADCjRChiAAAA
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
X-Provags-ID: V03:K1:hIHseR4NX2v+oVLVWIR3eBmYnYX16KvaNir/lP7CqCj9R7emg2A
 h4qgJgpcSqbgMuoDnE4dV8xuRTQdEeUlzdnZMRCetUS4j40J4gCBQ7kNHYitq2Cg9TNXMJA
 Q/7Hyv0lO+UZ037YlYuc4/AG/8KC9PeYAS0aXz/O3zZ6xYu0LiKmm9qVBzkQQ0yjYybC2A+
 D8ZCXWaOpWHXkFvI2geCQ==
UI-OutboundReport: notjunk:1;M01:P0:Wn0nJbt0je8=;tWVT0ICJzmsMZinTMSacg1Vbk5V
 0c5KcWQYbQnZBAF4nqMvxOCkemgBIWvM9AZOoiskW76O0H4zDNWtnFM5Z1KhQXNS3jJQdjBZm
 ThYXYYtXJqLb6isUS5HV1rg66sHB1SgoGD2zqhNF0Ra+IZs0orBOAdvIYDYLrO1FSfH8uSEbZ
 UpLs6ZfbgsmxitpJDoNkbUVNWx18TzRjNh+LVK8iD2WhoPExM+JSWnoSPrYdf29HlyPI7WaLR
 W4vgVqH/zUFK+ThPGHCAMGbZaBSDBRdUIyU49WdSOD5jJBHBto4NrqaVyMOpI3UnC+TrqAVS6
 OJqJT5e1LbF9JM6o6SKq8RUjx2TIF3maPdbnI4/gVu8qG9n++L5y02+dof8P/ilvmQgth+0Rz
 /TReXUPOBBkBWg4IG+H5Qc9XMbOgapDGoxCQAGNKtYKhBkHc7J3BduSq4DhdSOwkDXMr/is2E
 ZiHGmnsX+n4TsuAjKzlIOisVBeRLQmDbXuo7KYp8AcxQHmVJV5sUjJ8fI4pIX0Y4Di9lp3gkz
 a5OuTcXqDO4h7MaRyYxcJHoZwCBWSZXKZSPSqASuRqQdBp9gddCXOepYxKhESlBCj8dYZ13VG
 MoiK0kSyKg6WhWEOf8+CXMrRTi8+K+vAEIO7GPuzMRxTK38C5qMQQPJ4Kj7EM4qRg7/Bd89BV
 lRwl62IovW0weZv3NmeFCBTkyXRQ3iVViLSmMPekd6Luzr1HVuiK2Oy1Ww97BJsXKVN4HjTod
 eK8GBIAYnoL528SFaWZpYhmuMlMHSBgy9JTGkBsdbj9iH7qRzi8eVQSHHjprCUzzyzd6rcthN
 7hgxieLec9+/V3DC3f0eRkx8ueYl0ttKQeqFEBViCErsAd6SZ8BzjKRLVg4tEOsnSm/11h1k4
 N3HctchflRbCOMw==
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce the BPF_F_CGROUP_DEVICE_GUARD flag for BPF_PROG_LOAD
which allows to set a cgroup device program to be a device guard.
This may be used to guard actions on device nodes in non-initial
userns, e.g., mknod.

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

To circumvent this limitation, we allow mknod() in the VFS if a
bpf cgroup device guard is enabled for the current task and check
CAP_MKNOD for the current user namespace instead of the init userns.

To avoid unusable device nodes on file systems mounted in
non-initial user namespace, may_open_dev() ignores the SB_I_NODEV
for cgroup device guarded tasks.

Tested for a GyroidOS container generated by the cmld using the
following user space patch: https://github.com/gyroidos/cml/pull/394

I discussed this internally with Christian in the UAPI group, earlier.
I put this to the public list now, since also LXC/LXD Folks have
announced interest on this.

This series applies to the latest mainline v6.5-rc6 tag.

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
Michael Weiß (4):
      bpf: add cgroup device guard to flag a cgroup device prog
      bpf: provide cgroup_device_guard in bpf_prog_info to user space
      device_cgroup: wrapper for bpf cgroup device guard
      fs: allow mknod in non-initial userns using cgroup device guard

 fs/namei.c                     | 19 ++++++++++++++++---
 include/linux/bpf-cgroup.h     |  7 +++++++
 include/linux/bpf.h            |  1 +
 include/linux/device_cgroup.h  |  7 +++++++
 include/uapi/linux/bpf.h       |  8 +++++++-
 kernel/bpf/cgroup.c            | 30 ++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c           |  6 +++++-
 security/device_cgroup.c       | 10 ++++++++++
 tools/bpf/bpftool/prog.c       |  2 ++
 tools/include/uapi/linux/bpf.h |  8 +++++++-
 10 files changed, 92 insertions(+), 6 deletions(-)
---
base-commit: 2ccdd1b13c591d306f0401d98dedc4bdcd02b421
change-id: 20230814-devcg_guard-5398ef84bf7b

Best regards,
-- 
Michael Weiß <michael.weiss@aisec.fraunhofer.de>

