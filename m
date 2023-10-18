Return-Path: <linux-fsdevel+bounces-618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D9F7CD9D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 12:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF0ED281D65
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 10:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAD11CFB0;
	Wed, 18 Oct 2023 10:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEAA1A702;
	Wed, 18 Oct 2023 10:57:07 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F054D10F;
	Wed, 18 Oct 2023 03:57:00 -0700 (PDT)
Received: from weisslap.aisec.fraunhofer.de ([91.67.186.133]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MMH2M-1r95ee1XaI-00JFRa; Wed, 18 Oct 2023 12:50:58 +0200
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
Subject: [RFC PATCH v2 05/14] device_cgroup: Implement dev_permission() hook
Date: Wed, 18 Oct 2023 12:50:24 +0200
Message-Id: <20231018105033.13669-6-michael.weiss@aisec.fraunhofer.de>
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
X-Provags-ID: V03:K1:6fQpbyJ4yqJDdtOE6U4o2qVRNJKIJVyBf29udf+uc+/N6tF9IoH
 8t1C1cC3mS3KGqZ/fM8NSuVnL6Vku/6d75OreD1W+PTZyYWT+AMUoZD8nvd5WUkz4It8oYV
 mgBzW/YuC1VAn4JxY8EG2yvXiiH+neM+67Kx7SQvAdbY4iqGXZEZfndLZ2yjmFqmQKH7x7O
 WCKWWnxi80y53tE+xJeDQ==
UI-OutboundReport: notjunk:1;M01:P0:KPld94mI8N4=;N5vkTOFrb90fmkbkDDAVyBwDY1S
 iSSlHRHjf4q3fcYpQi2uV4atpZakxYxRd5K/nnE5ZtC5OHztPnS+HrvCIicEdHDg0+dFvoP10
 9+osU9/vMqFSITdyeVzNKkDAcnG1s+80I0sonWh4ew4v/+uO9NOcfPV41jbKxk9finPj+wCYx
 Kf/R8sfgSSQdwc5WD7Jf912gqMx8ZJCk832N1cOv1dJta18N5Fp5zugPTrbgJ4nBN8VF1Dp34
 deE1sQxseptMz9Nu/2Jaq/FgSikZltEcyTYxvgLdpjKrCgt0yAzYk0mRp6qzZxldPIhp72DqE
 oCmYvd15SWqbRtsAk8Kosrwm2aOsaf63lOBgYL3TwYACa6U6jA/RlGVr7/0zNrLqJGSfXOHew
 Fija+0MTBFjwPztpJjjuRe/UV5oVpRqo+R/RpPbX6ZVtZlIJNO0j7V2HUqqGIvXDHqKDdhBDV
 0+qNsqdffVqcNUEzfM2SFk/ldpy6XAwm/rtuqhLPN8eDNdAGThTMVwHZrv1Tk2UiZ+ITMhjU+
 54q4O5fgJvI1Z/m3dfpahcZNyaPh9rJp+4EkzdtRthcZbK+aNpVtL2+3GQPYeuXNwzjMqS3+j
 0uL1A59J6xyLXFa0hBymQ7mB7SyOMUDCbwK9HxPrxBW3v3Q/E+d39PNe1+l/TKGp8a3nTEMVg
 ENSiswgiFJ0GYnRIDO85VWmEue6ZDo0jLMR0+vJOOJNY7+wGCpawu+w1R1VYSVhhto1BWjz9d
 1I99ijX+DKqk0YMLZchWWuaUpjODgCG4U2v/OEhdR74RUTdLqtIapgRVU5F5+zBjHm2QlrYC2
 SbQE1DWntVeHqDajVQJBuN4lODsT3u+riJIlOMK7El+bDwq+ZtxUxaweSmGRJYJYYa8ut2Y01
 Y1xFRIGWq0aAocm8sER2aELs2LbzJwq4bxJw=
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wrap devcgroup_check_permission() by implementing the new security
hook dev_permission().

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 security/device_cgroup/lsm.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/security/device_cgroup/lsm.c b/security/device_cgroup/lsm.c
index ef30cff1f610..987d2c20a577 100644
--- a/security/device_cgroup/lsm.c
+++ b/security/device_cgroup/lsm.c
@@ -14,29 +14,32 @@
 #include <linux/device_cgroup.h>
 #include <linux/lsm_hooks.h>
 
-static int devcg_inode_permission(struct inode *inode, int mask)
+static int devcg_dev_permission(umode_t mode, dev_t dev, int mask)
 {
 	short type, access = 0;
 
-	if (likely(!inode->i_rdev))
-		return 0;
-
-	if (S_ISBLK(inode->i_mode))
+	if (S_ISBLK(mode))
 		type = DEVCG_DEV_BLOCK;
-	else if (S_ISCHR(inode->i_mode))
-		type = DEVCG_DEV_CHAR;
 	else
-		return 0;
+		type = DEVCG_DEV_CHAR;
 
 	if (mask & MAY_WRITE)
 		access |= DEVCG_ACC_WRITE;
 	if (mask & MAY_READ)
 		access |= DEVCG_ACC_READ;
 
-	return devcgroup_check_permission(type, imajor(inode), iminor(inode),
+	return devcgroup_check_permission(type, MAJOR(dev), MINOR(dev),
 					  access);
 }
 
+static int devcg_inode_permission(struct inode *inode, int mask)
+{
+	if (likely(!inode->i_rdev))
+		return 0;
+
+	return devcg_dev_permission(inode->i_mode, inode->i_rdev, mask);
+}
+
 static int __devcg_inode_mknod(int mode, dev_t dev, short access)
 {
 	short type;
@@ -65,6 +68,7 @@ static int devcg_inode_mknod(struct inode *dir, struct dentry *dentry,
 static struct security_hook_list devcg_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(inode_permission, devcg_inode_permission),
 	LSM_HOOK_INIT(inode_mknod, devcg_inode_mknod),
+	LSM_HOOK_INIT(dev_permission, devcg_dev_permission),
 };
 
 static int __init devcgroup_init(void)
-- 
2.30.2


