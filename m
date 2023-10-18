Return-Path: <linux-fsdevel+bounces-613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF147CD9B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 12:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F584B216D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 10:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B52200DE;
	Wed, 18 Oct 2023 10:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCF31A5BE;
	Wed, 18 Oct 2023 10:51:34 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058E410C;
	Wed, 18 Oct 2023 03:51:30 -0700 (PDT)
Received: from weisslap.aisec.fraunhofer.de ([91.67.186.133]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MIbzB-1qnFFs3Lb3-00EhG5; Wed, 18 Oct 2023 12:51:05 +0200
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
	=?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Subject: [RFC PATCH v2 13/14] bpf: cgroup: Introduce helper cgroup_bpf_current_enabled()
Date: Wed, 18 Oct 2023 12:50:32 +0200
Message-Id: <20231018105033.13669-14-michael.weiss@aisec.fraunhofer.de>
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
X-Provags-ID: V03:K1:c7boRBZce2o/4oyHXPUGFehTs5JEo4g6y6oz3dtk/Y6oo6Xq1OZ
 DyXf2R5XCAR9DzvSH64sG4crHyJQcx4oZLXOjTppA/Y29rRBvUthw5BF1I90tp85AhOeaEV
 c1i9nOH12egtUOHVDUgcg/Jwmabwg9DrnHrEGcJQt4+Qz+rnH1TqlyzQGjfc7d/4VKVcvHk
 6AsVvg4MCFwyIP4TKCUZQ==
UI-OutboundReport: notjunk:1;M01:P0:3YIXBCIAPsI=;VvwaHwhP8dS0yqCdMME8AKSP4u3
 t11wuyWmmbY4TIWIOAk+AMDBYGk87iFjxb0mIzvfGEHhvGxQH7Frw+5HgP4N8v6JfwSTzadTR
 bY7l7r80uVWW9czZ70/gzjsZzsvRXOt3pFzUtmVsLjqz/Asuvs/jZP4w5wYzRbYf695kiWZz2
 ai2fOmzF6kL4CuVbcgG8njL2jcatb7IsEz/88D9Y8CThrR4+BaPcrA8Ui69i/oTEkQzA5dXKM
 v9On9Q3AL7haTuz262+8HvgNoWyYg8RVD67z6XR7DSEp16hrupaDMwMuB2H9DEF8GesQWATNr
 WKPlj8R7bSFqNsWtr9MF0OcKJ4T2hfMzHGYl33inbj5lkMHm4aHArxKLle4p4ZenKpTjxJ+Cs
 AKjTOtB3ZBer8bPQwhDobC4qPB/kst1LezQybTmht5rdmO7rs1bcV1Y0VoxIH8InRbLTXbyCJ
 pnvnBTSKf8HslIjI2A1+E6IlswwutDjM81ds7L6K6Qgg0Z1pVV2s2V4ynNC22WKCnmJwFBfuo
 9upJNxY2uT5d512Hy6X13vSOHXbAWw/VeCx7in1qpMeWtev6mPN3LxYUw9QyqVs1C9WtJLaeX
 3b1WGpZEyBNdKvt3WUBhTmYLtqyxGz3FUIItFYaEbkrb6Ck1vXrbY3tziBHnhZPoAh1crM4bQ
 624UK5nwJtArRMyNpgpqtNVrO69T81tkHYuD08L9wM/p/Tlwi7ASU7a4LTvFnK/FpmZ7RgVgT
 D8yHsHwCVreZSedhBfh0LqWTTf4dNsvUorbV6EAgRX6Y9XRhzzSjam1/ZrRnYJKWiUKQuFEye
 MYGwTUwt4Q3QrwatpTk4/fYjQZ/zvEtpmfOU2kHb5HJ1HgbeJ8IFQyLxUehS4A6qtG0LB60Ae
 6BxrnuZmsGObyTg==
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This helper can be used to check if a cgroup-bpf specific program is
active for the current task.

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 include/linux/bpf-cgroup.h |  2 ++
 kernel/bpf/cgroup.c        | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 8506690dbb9c..655697c2a620 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -184,6 +184,8 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
 	return array != &bpf_empty_prog_array.hdr;
 }
 
+bool cgroup_bpf_current_enabled(enum cgroup_bpf_attach_type type);
+
 /* Wrappers for __cgroup_bpf_run_filter_skb() guarded by cgroup_bpf_enabled. */
 #define BPF_CGROUP_RUN_PROG_INET_INGRESS(sk, skb)			      \
 ({									      \
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 03b3d4492980..19ae3d037db7 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -24,6 +24,20 @@
 DEFINE_STATIC_KEY_ARRAY_FALSE(cgroup_bpf_enabled_key, MAX_CGROUP_BPF_ATTACH_TYPE);
 EXPORT_SYMBOL(cgroup_bpf_enabled_key);
 
+bool cgroup_bpf_current_enabled(enum cgroup_bpf_attach_type type)
+{
+	struct cgroup *cgrp;
+	struct bpf_prog_array *array;
+
+	rcu_read_lock();
+	cgrp = task_dfl_cgroup(current);
+	rcu_read_unlock();
+
+	array = rcu_access_pointer(cgrp->bpf.effective[type]);
+	return array != &bpf_empty_prog_array.hdr;
+}
+EXPORT_SYMBOL(cgroup_bpf_current_enabled);
+
 /* __always_inline is necessary to prevent indirect call through run_prog
  * function pointer.
  */
-- 
2.30.2


