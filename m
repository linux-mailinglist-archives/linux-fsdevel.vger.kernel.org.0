Return-Path: <linux-fsdevel+bounces-612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 023E57CD9AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 12:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFA09281D1A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 10:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F6F1F951;
	Wed, 18 Oct 2023 10:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C1A199AB;
	Wed, 18 Oct 2023 10:51:33 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E76100;
	Wed, 18 Oct 2023 03:51:28 -0700 (PDT)
Received: from weisslap.aisec.fraunhofer.de ([91.67.186.133]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MgiPE-1rTChh25ls-00h8BM; Wed, 18 Oct 2023 12:50:57 +0200
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
Subject: [RFC PATCH v2 04/14] lsm: Add security_dev_permission() hook
Date: Wed, 18 Oct 2023 12:50:23 +0200
Message-Id: <20231018105033.13669-5-michael.weiss@aisec.fraunhofer.de>
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
X-Provags-ID: V03:K1:38OgFLKeLVyUNOGAHePjb9eXHvugerr9x590L1H0mtjlQz8+EhP
 XV0kjjYTVCFzyaGkdhflveir1VfTbHqWmEmrXQtyoLpF30n5KODUjF3UU+cpbTyyK1iwGUL
 98DKPB1ud8WTDseAR2vCjioz+6oMKBxUcVxt/HrIf66Xag9WZPXIjI0gSRad84Fo9+Qg+f+
 r8wUVsa/nedGZEQ7akf6g==
UI-OutboundReport: notjunk:1;M01:P0:h+FTMlalFCk=;nEnL1o6Gxl+hnMse0JkKqyiTNUJ
 ZAsW1h9B9jFe9bGHwcaWr467ig8PZpstHYQG7WQb1NchktAHHKDokiRO+JrvwTk4Av+LyUoiS
 L5q8T9Fb7ZHcO32E1EeceOoInCWL9znSy7i8DVTwFw2t8G4Kk3PrRxHP9uqBorYYZt4E3NChi
 ZysfQvdgvpn6Qp415qcslsXB52+IBzvoQOjnpD4ke5Ls9A3Qe0pY5f3C0uP4vLU154f+IB5xC
 Sa/NUMrKYPewac4z/4M1hF3IF320oOaO8IOqHE52C/XOGPmIVmSyXix5PHxeToJN/9CK7et4D
 DXxg/OT4E83tyI42zOoo8FFUL6GIrimliJRSpQmVIrfuJn7SIAG6ddhs1Efqq02voeqfrVVgi
 QcDozmGbeDOEtVn0gcJMhGLl/b7gfe6Hbl5wgLEJKWzIBEDX+Y1IbVpXN2o/qjo8wXFmygbW6
 IgIJNNFEzUf/UMI4As47VOBj6F2umR3Cc09C3M/GWv3mYXipKH2kcj7m5ccDGkx+PO25Auwis
 TO/7DJ33E+EgDrMr04RTMIqYsUUW5s+/4rusgFphWcvx0NnNGYhLxwv3HGCS67vTzfG2SJGYu
 VLB1YWLZvyl1rWt6oYGhp82pZbS4vGLVh5QM5r86idKGBpdsdzOsDcOlRpDwsNKFCJFv0YeCg
 XJgsbSmSP+XVk9BEz6ouI47jOic5UBkWqacPs34puXKn/r7ocNFHV5Z8V+1YfUg2GXPouWg1U
 cpJKJsJH8rmEnQ+uAzvjY4NzgajwUzaMMIAoAJZ9H5qKc/Yyhi/EBAkpPqyY+ab/lLQbw/0qH
 1xjOpR+6kspKQ9DIMs02Nq48Ezkj3R8zk/0KaoK1UInHp8JdPjMvsI3pezMofo0hEBA+KrT6J
 VhdlJzkEMdwdOW6VrM/Tt3Wzlq203rPvQM+E=
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Provide a new lsm hook which may be used to check permission on
a device by its dev_t representation only. This could be used if
an inode is not available and the security_inode_permission
check is not applicable.

A first lsm to use this will be the lately converted cgroup_device
module, to allow permission checks inside driver implementations.

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/security.h      |  5 +++++
 security/security.c           | 18 ++++++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index ac962c4cb44b..a868982725a9 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -275,6 +275,7 @@ LSM_HOOK(int, 0, inode_notifysecctx, struct inode *inode, void *ctx, u32 ctxlen)
 LSM_HOOK(int, 0, inode_setsecctx, struct dentry *dentry, void *ctx, u32 ctxlen)
 LSM_HOOK(int, 0, inode_getsecctx, struct inode *inode, void **ctx,
 	 u32 *ctxlen)
+LSM_HOOK(int, 0, dev_permission, umode_t mode, dev_t dev, int mask)
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
 LSM_HOOK(int, 0, post_notification, const struct cred *w_cred,
diff --git a/include/linux/security.h b/include/linux/security.h
index 5f16eecde00b..8bc6ac8816c6 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -484,6 +484,7 @@ int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
 int security_locked_down(enum lockdown_reason what);
+int security_dev_permission(umode_t mode, dev_t dev, int mask);
 #else /* CONFIG_SECURITY */
 
 static inline int call_blocking_lsm_notifier(enum lsm_event event, void *data)
@@ -1395,6 +1396,10 @@ static inline int security_locked_down(enum lockdown_reason what)
 {
 	return 0;
 }
+static inline int security_dev_permission(umode_t mode, dev_t dev, int mask)
+{
+	return 0;
+}
 #endif	/* CONFIG_SECURITY */
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
diff --git a/security/security.c b/security/security.c
index 23b129d482a7..40f6787df3b1 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4016,6 +4016,24 @@ int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
 }
 EXPORT_SYMBOL(security_inode_getsecctx);
 
+/**
+ * security_dev_permission() - Check if accessing a dev is allowed
+ * @mode: file mode holding device type
+ * @dev: device
+ * @mask: access mask
+ *
+ * Check permission before accessing an device by its major minor.
+ * This hook is called by drivers which may not have an inode but only
+ * the dev_t representation of a device to check permission.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_dev_permission(umode_t mode, dev_t dev, int mask)
+{
+	return call_int_hook(dev_permission, 0, mode, dev, mask);
+}
+EXPORT_SYMBOL(security_dev_permission);
+
 #ifdef CONFIG_WATCH_QUEUE
 /**
  * security_post_notification() - Check if a watch notification can be posted
-- 
2.30.2


