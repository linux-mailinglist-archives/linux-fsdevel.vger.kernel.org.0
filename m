Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A288377BBDA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 16:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjHNOk0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 10:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbjHNOkT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:40:19 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F7CF5;
        Mon, 14 Aug 2023 07:40:17 -0700 (PDT)
Received: from [127.0.1.1] ([91.67.199.65]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N5UoU-1pgYbq1NVa-016zzS; Mon, 14 Aug 2023 16:26:16 +0200
From:   =?utf-8?q?Michael_Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
Date:   Mon, 14 Aug 2023 16:26:10 +0200
Subject: [PATCH RFC 2/4] bpf: provide cgroup_device_guard in bpf_prog_info
 to user space
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230814-devcg_guard-v1-2-654971ab88b1@aisec.fraunhofer.de>
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
X-Provags-ID: V03:K1:o8/eibR0KEBv814SkAfdQUcPXonJ4/KKrEByU28jqQCeZFziDrX
 Jh/nBbMV0+Pqqx0ZAhoiwrS6qeOne5dKIiuY7ocFyLjGOOWLJVKoYkYM6ll2MwgWWbd02yC
 8gLOxL4UU8xYYbb9wkiOmLprQj5Y48d6pl6OAUe6EJRZhNRbc3c8LTgWhkdNLxUdooHCahG
 lW5Zf1nZFvO/RPdhxsTPQ==
UI-OutboundReport: notjunk:1;M01:P0:xxe2lkYlnOU=;2D+cFgrrWAhPUaEiBJb1W4nqw5v
 3u/N/KWFj85CjLC09xRjrG2hLIM0DQUtynr3J216+IVA2UgW+Y5TDtMW75Gxn0CMBofS0XDes
 gXHA2Tz6feEpXNk1cHRhuz7zH+JkhGEsdiY7b80qufCZMBYS9Hfd3A9gz4SKlTxe4HHUQLB+/
 dgicc6X9CLgVR7MTx5LVKf9hYCkJsZTfsnKV6cK76o+xd+TBiliKO7LB8/M9iIxVjbmtJS44o
 u81FLIfYqPqJK45u8frJxbmKWMnC1rVCX4G+DomMJzlgDel407Ji6diLlt9XJaYMsho+24DBj
 m43tSSFi/rdECLXDsBlN+j3G3UuikprxUn14hmIp9a0R9Kv6TREnZQ5bNfw9byEhBmP28zRCr
 qPcT6O1BRAwUJxYGQ40FmwWewhqkEkr3nz3ptN8UT7ssfxNPOH2YF48XdFh9q3NEVuGHVHSp2
 GTWp+nkuXL3DlCq4dym8HWXUdSP0rwb/qM3XKK1eOeR4q0x0Ss+DBPyBXxHLMwH8rhnhfjPT5
 BHPWBUICqzNmKlNgjwoDUEpAkOkaHa2SRHVJ3d/s1BE5EC/zddh4DmbbrmNjNFVkYuBNob1gL
 P8fEDFqOSXvTeLgOM3MYVVZZfrbNyhjDRu8JfMaKArd9YLj1isYZ+35IHArukCuqTKGJty4Cq
 6lr7apRBTqCs2zhsY87i4WD6Jse/95ZZlXNGZRehGMWpEL9Yevy04REwOJzYw0zBUIY2GlzVq
 cAwGxAF8ezlsgk/Z8GRT+pvwxDNtzahwUag95krLReBFhNLRjmGDjAsQra8TxhECiTWBh/4Fo
 zTqks+EEDiPxxQHClhD9T7Ehrzgq2FrfRjG8cJ952TEvV0Kzoz2yThdZcH5Ozu53lzs9tArf2
 3yCavtTKp+73glg==
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To allow user space tools to check if a device guard is active,
we extend the struct bpf_prog_info by a cgroup_device_guard field.
This is then used by the bpftool in print_prog_header_*() functions.

Output of bpftool, here for the bpf prog of a GyroidOS container:

 # ./bpftool prog show id 37
 37: cgroup_device  tag 1824c08482acee1b  gpl  cgdev_guard
 	loaded_at 2023-08-14T13:47:10+0200  uid 0
 	xlated 456B  jited 311B  memlock 4096B

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 include/uapi/linux/bpf.h       | 3 ++-
 kernel/bpf/syscall.c           | 1 +
 tools/bpf/bpftool/prog.c       | 2 ++
 tools/include/uapi/linux/bpf.h | 3 ++-
 4 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 3be57f7957b1..7b383665d5f4 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6331,7 +6331,8 @@ struct bpf_prog_info {
 	char name[BPF_OBJ_NAME_LEN];
 	__u32 ifindex;
 	__u32 gpl_compatible:1;
-	__u32 :31; /* alignment pad */
+	__u32 cgroup_device_guard:1;
+	__u32 :30; /* alignment pad */
 	__u64 netns_dev;
 	__u64 netns_ino;
 	__u32 nr_jited_ksyms;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 33ea67c702c1..9bc6d5dd2e90 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4062,6 +4062,7 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 	info.created_by_uid = from_kuid_munged(current_user_ns(),
 					       prog->aux->user->uid);
 	info.gpl_compatible = prog->gpl_compatible;
+	info.cgroup_device_guard = prog->aux->cgroup_device_guard;
 
 	memcpy(info.tag, prog->tag, sizeof(prog->tag));
 	memcpy(info.name, prog->aux->name, sizeof(prog->aux->name));
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 8443a149dd17..66d21794b641 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -434,6 +434,7 @@ static void print_prog_header_json(struct bpf_prog_info *info, int fd)
 		     info->tag[4], info->tag[5], info->tag[6], info->tag[7]);
 
 	jsonw_bool_field(json_wtr, "gpl_compatible", info->gpl_compatible);
+	jsonw_bool_field(json_wtr, "cgroup_device_guard", info->cgroup_device_guard);
 	if (info->run_time_ns) {
 		jsonw_uint_field(json_wtr, "run_time_ns", info->run_time_ns);
 		jsonw_uint_field(json_wtr, "run_cnt", info->run_cnt);
@@ -519,6 +520,7 @@ static void print_prog_header_plain(struct bpf_prog_info *info, int fd)
 	fprint_hex(stdout, info->tag, BPF_TAG_SIZE, "");
 	print_dev_plain(info->ifindex, info->netns_dev, info->netns_ino);
 	printf("%s", info->gpl_compatible ? "  gpl" : "");
+	printf("%s", info->cgroup_device_guard ? "  cgdev_guard" : "");
 	if (info->run_time_ns)
 		printf(" run_time_ns %lld run_cnt %lld",
 		       info->run_time_ns, info->run_cnt);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 3be57f7957b1..7b383665d5f4 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6331,7 +6331,8 @@ struct bpf_prog_info {
 	char name[BPF_OBJ_NAME_LEN];
 	__u32 ifindex;
 	__u32 gpl_compatible:1;
-	__u32 :31; /* alignment pad */
+	__u32 cgroup_device_guard:1;
+	__u32 :30; /* alignment pad */
 	__u64 netns_dev;
 	__u64 netns_ino;
 	__u32 nr_jited_ksyms;

-- 
2.30.2

