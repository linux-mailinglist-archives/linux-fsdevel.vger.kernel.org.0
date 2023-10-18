Return-Path: <linux-fsdevel+bounces-614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B16F57CD9B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 12:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CC35B2100D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 10:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6DD2AB47;
	Wed, 18 Oct 2023 10:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1DF199B8;
	Wed, 18 Oct 2023 10:51:33 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D99D109;
	Wed, 18 Oct 2023 03:51:29 -0700 (PDT)
Received: from weisslap.aisec.fraunhofer.de ([91.67.186.133]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MAtoX-1qhkY30v9N-00BOPd; Wed, 18 Oct 2023 12:51:02 +0200
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
Subject: [RFC PATCH v2 09/14] lsm: Add security_inode_mknod_nscap() hook
Date: Wed, 18 Oct 2023 12:50:28 +0200
Message-Id: <20231018105033.13669-10-michael.weiss@aisec.fraunhofer.de>
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
X-Provags-ID: V03:K1:5lxDhBdnRK6z/qneyHrExxpGGfNqKmn9/t+GHCV67i7gdyqABcu
 sqNuzvbWCst+BiDlXc96S54DVuWryXVblKlyxZ0G+0XC241SZV/ZSM5WIzaOYnGa2HwVhD7
 w12pjkFUdUUIkGyG6Y/MWWJZTpEwRid3PsLC7MyY+Om2nm6t0bHDIB2WtzcILbedxiB17w1
 Bpg7935I0mCv9jw2zLkcg==
UI-OutboundReport: notjunk:1;M01:P0:2+i2Uh/X6wo=;2uxYOw5HC84hKPQexFNKPLKAGkt
 fQYhBSxyE+Ny/qlYqBNh/lRNoj42Lvenpzoqt2sOm2fb+ItLxK2aqhvRnBuFWEBxBV2pkGfJP
 LAqSq1V7TtAdHMMxnT6flWVbEJw+eHAGjOobF7hT2NJYUGKT21zIJ7HY5dUUVbNLy5y/vRBD8
 1T8q4EotydMXbeuFrz8QJx0J+W8yFO2rFizCl7PrsLIOJ/cCvLfdoD8xj9lTUa3Ea/OLXBUJ8
 iDtALlENbL5H32dD4XJjmauzfESGsfYA1O5BC2zco6zwEP0IFpAMzK3ptiddi64N9yyk4VFu8
 lu31rT2lrrjcuz1QwvaME+6njgIpYTvLZcrKN0P4Q8ZcpY1JyBbnnYnUghq4+3LrIbTa5nTOc
 4QzBp6H7vYMPeDLhlGokJggteXh7QlSbtGyom1xXBxlhk9FrQNg0WX2AdqGqIQIhKsz2DShs8
 VHMOQHRqat2gdEuf76pB5RSMak36+SS16dZpeJCjNq0vuasSM+Q5hq8MwyaEPoaWUdhY+IeE8
 5Gobc5CWqypvuYQGijWmwNT/5O2bmLmBaP8B1DuzVi5bWN30oioawo2FEmbyu32jDVyV42ZVD
 2Khd2mrRFNcUge6Xc05REdy4mMIc4pmF+6D4qU9+nZ2fPHum1D4GN43IzUAi/fQVR6Cj3VM2w
 WuCnLxjl9jrN2xRPoyd6iXZdeHgKhpyuKqOvd7/b/rmstCPY23TZqiFDNqfQKrYnDCXEuHNYM
 i3jM5RmJVmJ2993fmi1/CK2zJVhsHYRyn9a/1Iwf9lnX6x8eSvO2X6k4ONeKEpUDX9+S4PzJT
 NlmyYPjb+abDxWdmHgRnZN6yEMH6yPeUt6QpqbwMmqmvsJhMuko00/NRJEpAFW8Qe/VrgQ6hC
 d0PA89QcvI6H7fw==
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Provide a new lsm hook which may be used to allow mknod in
non-initial userns. If access to the device is guarded by this
hook, access to mknod may be granted by checking cap mknod for
unprivileged user namespaces.

By default this will return -EPERM if no lsm implements the
hook. A first lsm to use this will be the lately converted
cgroup_device module.

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/security.h      |  8 ++++++++
 security/security.c           | 31 +++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index a868982725a9..f4fa01182910 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -276,6 +276,8 @@ LSM_HOOK(int, 0, inode_setsecctx, struct dentry *dentry, void *ctx, u32 ctxlen)
 LSM_HOOK(int, 0, inode_getsecctx, struct inode *inode, void **ctx,
 	 u32 *ctxlen)
 LSM_HOOK(int, 0, dev_permission, umode_t mode, dev_t dev, int mask)
+LSM_HOOK(int, -EPERM, inode_mknod_nscap, struct inode *dir, struct dentry *dentry,
+	 umode_t mode, dev_t dev)
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
 LSM_HOOK(int, 0, post_notification, const struct cred *w_cred,
diff --git a/include/linux/security.h b/include/linux/security.h
index 8bc6ac8816c6..bad6992877f4 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -485,6 +485,8 @@ int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
 int security_locked_down(enum lockdown_reason what);
 int security_dev_permission(umode_t mode, dev_t dev, int mask);
+int security_inode_mknod_nscap(struct inode *dir, struct dentry *dentry,
+			       umode_t mode, dev_t dev);
 #else /* CONFIG_SECURITY */
 
 static inline int call_blocking_lsm_notifier(enum lsm_event event, void *data)
@@ -1400,6 +1402,12 @@ static inline int security_dev_permission(umode_t mode, dev_t dev, int mask)
 {
 	return 0;
 }
+static inline int security_inode_mknod_nscap(struct inode *dir,
+					     struct dentry *dentry,
+					     umode_t mode, dev_t dev);
+{
+	return -EPERM;
+}
 #endif	/* CONFIG_SECURITY */
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
diff --git a/security/security.c b/security/security.c
index 40f6787df3b1..7708374b6d7e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4034,6 +4034,37 @@ int security_dev_permission(umode_t mode, dev_t dev, int mask)
 }
 EXPORT_SYMBOL(security_dev_permission);
 
+/**
+ * security_inode_mknod_nscap() - Check if device is guarded
+ * @dir: parent directory
+ * @dentry: new file
+ * @mode: new file mode
+ * @dev: device number
+ *
+ * If access to the device is guarded by this hook, access to mknod may be granted by
+ * checking cap mknod for unprivileged user namespaces.
+ *
+ * Return: Returns 0 on success, error on failure.
+ */
+int security_inode_mknod_nscap(struct inode *dir, struct dentry *dentry,
+			       umode_t mode, dev_t dev)
+{
+	int thisrc;
+	int rc = LSM_RET_DEFAULT(inode_mknod_nscap);
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.inode_mknod_nscap, list) {
+		thisrc = hp->hook.inode_mknod_nscap(dir, dentry, mode, dev);
+		if (thisrc != LSM_RET_DEFAULT(inode_mknod_nscap)) {
+			rc = thisrc;
+			if (thisrc != 0)
+				break;
+		}
+	}
+	return rc;
+}
+EXPORT_SYMBOL(security_inode_mknod_nscap);
+
 #ifdef CONFIG_WATCH_QUEUE
 /**
  * security_post_notification() - Check if a watch notification can be posted
-- 
2.30.2


