Return-Path: <linux-fsdevel+bounces-616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E733E7CD9D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 12:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A113C281CE6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 10:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F141A5BE;
	Wed, 18 Oct 2023 10:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5496619BB8;
	Wed, 18 Oct 2023 10:57:04 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCEEB92;
	Wed, 18 Oct 2023 03:57:01 -0700 (PDT)
Received: from weisslap.aisec.fraunhofer.de ([91.67.186.133]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MpCz1-1rJY4G0S1H-00qmy3; Wed, 18 Oct 2023 12:51:03 +0200
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
Subject: [RFC PATCH v2 10/14] lsm: Add security_sb_alloc_userns() hook
Date: Wed, 18 Oct 2023 12:50:29 +0200
Message-Id: <20231018105033.13669-11-michael.weiss@aisec.fraunhofer.de>
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
X-Provags-ID: V03:K1:1r5RyqGAN9dy40dCcTVA8P+ZdQrnAWjyMfT7NWw+AjP5k7SdSAx
 KK6ojyZeqMoIKXoNN5B05l8hRYYrpxg2YsWGs0W0oVR5FlK/vd0aZOYdG0AL/l+CQ5iGm5e
 O0YnfYkhugXo/lJhVr+PA2rOcH47EsknuLQQnKrXL07VgH3KwnC4ufExd7KzXs9PeBLvufI
 ET/oTA9gKppKW3e2BLdgQ==
UI-OutboundReport: notjunk:1;M01:P0:7me07hlkTME=;sNgRW1+b87bFkPd2ci/jNOKxrY/
 E3OsrEQIpRvOmvjffQg2b9fa3t3DZkvTrHLDkqf3oYKKFUgeSxdR5qG18aSrsBOK1Pa00KKbL
 /UQcWTQ/nuYrv0QvLDl50sf086WdgoBfJ2/URhBwnTv3KRQ7t1il7cgJceSozFxcemIogxidQ
 LL3M7TsNkb7ASSMhpnDNiMHiNTkCb1yiA82Nrq/W/9+yDZxO2s49HocioaBiV1xOGuEPUMONT
 5U3G+4fXY7tdTs13VnJmVlLF92Z5idVgVqYYm/5QZ5uKKT4maSQSfG00nf94lEsDFTiPIkn+S
 ZtHGKa+F96ZkdZjnU8HvdbGCQebFMQIM08okjd5W441mzGfzGU9FrScSOsOeecy9/uxvBGh3a
 o1NprWiXBUNBGiz81EQMjrmU3nCGoIFu9sjU7jb+HlsX6va7+AhzTp2gZDMHaOv+v2LTx7PCv
 JFP3BiK90WUmdBc1poLC6wEhfDmVzclkLzJ30wAC089UquOrE90adQwCB5QcDQMN9ffOqWgcd
 PiH00bjbtVzeuknhKCGGOYCVepoOa32lfVdtoXIlqaQOaa2WHt55aPihU/lIfuAdkTHb4HR4E
 b2I/CdlUPHHEg1y5An6i9eeJ/e4H4K0lGCHxR9Dw2sTu0iJFz7I06zTgsrXPoVkEopPu0r/48
 hY7IU5/UR9hiCk9hCcwQ8C/RkZiX0ZtNwi9crKi+5zomHZoKB22oZlbH/Cx00W6i9rUJAetZe
 KJ+cOaHVobJZdbTDq8FHjFDCH1XKnYFYP+kv+m289poYuRD09l91FbFx4B2n4y0zC4jKHAndJ
 Twfv3u/b7Mwi6HYZXKp8uVign0Z2zewzMYSYzTlx4nMib1DuCWW8mNEDVEuw6HK7uKorvcUhW
 sfBrRi+IYWzODCABGVCbEVEkHzTs9PrJrERU=
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Provide a new lsm hook which may be used to allow access to device
nodes for super blocks created in unprivileged namespaces if some
sort of device guard to control access is implemented.

By default this will return -EPERM if no lsm implements the hook.
A first lsm to use this will be the lately converted cgroup_device
module.

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/security.h      |  5 +++++
 security/security.c           | 26 ++++++++++++++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index f4fa01182910..0f734a0a5ebc 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -278,6 +278,7 @@ LSM_HOOK(int, 0, inode_getsecctx, struct inode *inode, void **ctx,
 LSM_HOOK(int, 0, dev_permission, umode_t mode, dev_t dev, int mask)
 LSM_HOOK(int, -EPERM, inode_mknod_nscap, struct inode *dir, struct dentry *dentry,
 	 umode_t mode, dev_t dev)
+LSM_HOOK(int, -EPERM, sb_alloc_userns, struct super_block *sb)
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
 LSM_HOOK(int, 0, post_notification, const struct cred *w_cred,
diff --git a/include/linux/security.h b/include/linux/security.h
index bad6992877f4..0f66be1ed1ed 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -487,6 +487,7 @@ int security_locked_down(enum lockdown_reason what);
 int security_dev_permission(umode_t mode, dev_t dev, int mask);
 int security_inode_mknod_nscap(struct inode *dir, struct dentry *dentry,
 			       umode_t mode, dev_t dev);
+int security_sb_alloc_userns(struct super_block *sb);
 #else /* CONFIG_SECURITY */
 
 static inline int call_blocking_lsm_notifier(enum lsm_event event, void *data)
@@ -1408,6 +1409,10 @@ static inline int security_inode_mknod_nscap(struct inode *dir,
 {
 	return -EPERM;
 }
+static inline int security_sb_alloc_userns(struct super_block *sb)
+{
+	return -EPERM;
+}
 #endif	/* CONFIG_SECURITY */
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
diff --git a/security/security.c b/security/security.c
index 7708374b6d7e..9d5d4ec28e62 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4065,6 +4065,32 @@ int security_inode_mknod_nscap(struct inode *dir, struct dentry *dentry,
 }
 EXPORT_SYMBOL(security_inode_mknod_nscap);
 
+/**
+ * security_sb_alloc_userns() - Grand access to device nodes on sb in userns
+ *
+ * If device access is provided elsewere, this hook will grand access to device nodes
+ * on the allocated sb for unprivileged user namespaces.
+ *
+ * Return: Returns 0 on success, error on failure.
+ */
+int security_sb_alloc_userns(struct super_block *sb)
+{
+	int thisrc;
+	int rc = LSM_RET_DEFAULT(sb_alloc_userns);
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.sb_alloc_userns, list) {
+		thisrc = hp->hook.sb_alloc_userns(sb);
+		if (thisrc != LSM_RET_DEFAULT(sb_alloc_userns)) {
+			rc = thisrc;
+			if (thisrc != 0)
+				break;
+		}
+	}
+	return rc;
+}
+EXPORT_SYMBOL(security_sb_alloc_userns);
+
 #ifdef CONFIG_WATCH_QUEUE
 /**
  * security_post_notification() - Check if a watch notification can be posted
-- 
2.30.2


