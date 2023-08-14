Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560FE77BB8D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 16:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbjHNO1G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 10:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjHNO0p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:26:45 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41A6E9;
        Mon, 14 Aug 2023 07:26:40 -0700 (PDT)
Received: from [127.0.1.1] ([91.67.199.65]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MC0HF-1qdUU141YD-00CR9d; Mon, 14 Aug 2023 16:26:17 +0200
From:   =?utf-8?q?Michael_Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
Date:   Mon, 14 Aug 2023 16:26:11 +0200
Subject: [PATCH RFC 3/4] device_cgroup: wrapper for bpf cgroup device guard
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230814-devcg_guard-v1-3-654971ab88b1@aisec.fraunhofer.de>
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
X-Provags-ID: V03:K1:eZ1bcl/qUp/USJZEuscMU0XkBYRRzn/ZnVwtDVGvt8VlbAaRHzn
 3fw0y8DLmlAla58hSO9qkLHjlcj4UhHhqMmUUWJrI9YcmzlsIycllF2K4HQ8mML2xTSEZKF
 YfwpV7MfWD6rA0VsUzx4TA08P/5TODnGSrkqa3MmjRr8uzutlTgYUBvhWerF8dedD8eZeq/
 vRMIKjiSm2u3an9j1efcw==
UI-OutboundReport: notjunk:1;M01:P0:6nqlDtKzeQw=;r1tH9lsibZO3DNJQqiovKwBrXV6
 uzXQ/KvQQ34/Ix/MUk6kQw/pwwC9ZCc+43YmYQs96/LPSNazeMuR7AJtTxumxlVWm39qJe9Yn
 3+v+UE6f/+gTlgw6ubJM3eSDc8gDaPT+zr1CnNJChDfYdCZDLSMyYmZc1Hv2vXayGySKF3xRn
 nLrPCGcc4SHLrQm4bxNTviUYoLsZ5bNgwz2tii7a5dTJTkG6X0KmrX8VmpQcUUKTylxTbviys
 qF5MVAMDnXRJrImMQ8wU9Swk7uA1OqWJS6prn+Zuw3a3DkbUwFRJf+Hyzobp8ps1Q0AN9hHv3
 EFc8qg7OoFWLoDUDC0OZgokIjpHbMi+ZMKAfq7T2TWY1bgs84XKB7nq/FqV1/THzUU2pz/kwm
 arHJ3UthpPGf4JdBmk9spBXujOt3Bo4DEzKjKfBWx96+Itn8wDnK3eomZ5Q1qhXVV/wS7vR5p
 FRjC7U526KUNkvYsGVMukyRh4DeVEJizL9urhhtaAYdZKBoDY8nLPRc0R3PSbMgjNvojbt+CE
 a+QVMq3L0HhgRSHocZBBUbetCa+mlD2u36vgcESWEzBGnz0caE8gSFkFvZ9uoEjPGNDq+uzmg
 G0fTXqPX97jFkzvYA6cl2INI6IopeN0lmJlSARElCRzLdrVfW4SyXc8Bf5isQe7k1SIz5CO18
 fs753EpKhUHHMNd+m+9xLnZXYX5Cjau6CE+yvu/X2wqxybtBjQaGASIstVfMeOe9ccZFbeeou
 BESWC0Zkgrs9eRSJFb/p14OzloBKWl5bERIPO5bkyXmJA3UKplOu8RIZF8Wvl0aqJRoUcx5wT
 6b8MfvQFORZ2/SktvhsF6cW5NwnNcdZK78Z8y3d86WQvY+8FwaCMVTpOon5EZgVKKhfHmplrN
 ciwhslV9RGi4+UGNBunTRiwWup/UQ93DZoUk=
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Export the bpf based cgroup guard through device_cgroup to others.
Thus, devcgroup_task_is_guarded() could be used by subsystems
which already make use of device_cgroup features, such as fs/namei.

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 include/linux/device_cgroup.h |  7 +++++++
 security/device_cgroup.c      | 10 ++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/device_cgroup.h b/include/linux/device_cgroup.h
index d02f32b7514e..00c0748b6a8d 100644
--- a/include/linux/device_cgroup.h
+++ b/include/linux/device_cgroup.h
@@ -65,3 +65,10 @@ static inline int devcgroup_inode_permission(struct inode *inode, int mask)
 static inline int devcgroup_inode_mknod(int mode, dev_t dev)
 { return 0; }
 #endif
+
+#ifdef CONFIG_CGROUP_BPF
+bool devcgroup_task_is_guarded(struct task_struct *task);
+#else
+static inline bool devcgroup_task_is_guarded(struct task_struct *task)
+{ return false; }
+#endif /* CONFIG_CGROUP_BPF */
diff --git a/security/device_cgroup.c b/security/device_cgroup.c
index dc4df7475081..95200a3d0b63 100644
--- a/security/device_cgroup.c
+++ b/security/device_cgroup.c
@@ -874,3 +874,13 @@ int devcgroup_check_permission(short type, u32 major, u32 minor, short access)
 }
 EXPORT_SYMBOL(devcgroup_check_permission);
 #endif /* defined(CONFIG_CGROUP_DEVICE) || defined(CONFIG_CGROUP_BPF) */
+
+#ifdef CONFIG_CGROUP_BPF
+
+bool devcgroup_task_is_guarded(struct task_struct *task)
+{
+	return (cgroup_bpf_enabled(CGROUP_DEVICE) &&
+		cgroup_bpf_device_guard_enabled(task));
+}
+EXPORT_SYMBOL(devcgroup_task_is_guarded);
+#endif /* CONFIG_CGROUP_BPF */

-- 
2.30.2

