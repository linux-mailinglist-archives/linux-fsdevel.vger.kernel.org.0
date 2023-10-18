Return-Path: <linux-fsdevel+bounces-619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E4D7CD9DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 12:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E43FB2151D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 10:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD391E503;
	Wed, 18 Oct 2023 10:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E65B1A708;
	Wed, 18 Oct 2023 10:57:07 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D99FE;
	Wed, 18 Oct 2023 03:57:01 -0700 (PDT)
Received: from weisslap.aisec.fraunhofer.de ([91.67.186.133]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MhWx1-1rVgc83BZ5-00eePP; Wed, 18 Oct 2023 12:50:55 +0200
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
Subject: [RFC PATCH v2 02/14] vfs: Remove explicit devcgroup_inode calls
Date: Wed, 18 Oct 2023 12:50:21 +0200
Message-Id: <20231018105033.13669-3-michael.weiss@aisec.fraunhofer.de>
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
X-Provags-ID: V03:K1:MwrgA482pCeYk6KYV5/2aD7JrSA7beredsb42ak4qjUk29yCG4F
 7ozM/orvi5JvxuxaHlfd7s3x0H6l8BEfSx9VyqBcaIMLhD2HvadYIa310SbPVj9WBZNA5hN
 eyEBw2WJnInrwDmOLPUoqvtPwe9sY67pqLb7cEuGdcA/Yz8Qz3Zy7I/E6gv2ci5xum09k4D
 o1DVQbV79xFvjqjsXz2pQ==
UI-OutboundReport: notjunk:1;M01:P0:1PbBlzRlcpE=;1PQasu6XjQfwCddLHV02Vs2Km+I
 mCHapxjy4piWul7yxhld7hFtIyqov59KRgk/xxmmWaDICYqlPkE7cQ/e/TgZXI1rYvmt932js
 NB6XZ5PZxAlDZdC/GcfnM28zEVKaVAw7s0PwS5uEUvI9jy+szhJqcABicjROD6csQWS3mqJi5
 cTjQsE/5DDjUi94ATRXwsoeQKJ19Sj9o1615svODHUtw02Sef+9nYRb/ak8qSYwewJyANFrUA
 eiKDldV1luSBV9xgikMW7JeHh9rmfQVJvbcwh8CHfhA9vcMotyoEwoZ5tsN6tTWCrScXw5y3e
 chcPudB3+H3NdPqfRFUq67+xxz3I2Sqx8PcSxkVZlCMPe7Q/3KGKkZHGftG37q02lAsRczTxg
 qNySApya/dYiqVM7AYXSmt2zjhCq0m5fzNAk6kHRjL+G/RTCS0HJkmkxq0XtULXKA42bR3b/P
 pspj/yaxSe8m1Mo5ub0FAqv0e969zM3zhAF7RDAQjGWonGD7kBii0cH/mYSSrqAoEAK1eo4jw
 t0wlLEfkxYML28X7/003vWddEB3a27aKLHdGHnf1sXzuTzeJiCektpr0ppgvoxAmUYwRkOd7U
 XcVV4otNWI5FPR/JdkAcH5Rv6aVUsjEEwUQny8xwZrj8oHXDB41KEkZTI159qq9XnpTGxpBpO
 N7htj1qHtJY0sMZ/IejuxmBWZPJYCtsNOQ0swLTnvhhYTxyP/LlN/gmi1NwUNUDRAIK3FKsZQ
 KgNfJDJVAWJFCt4oPmGKNHrTP5wPFCx3NLRsW1Dk0jnXp/tLtSgwuf6W+GJf2ZtK78H79ROOG
 zE8tMIMWL4gPQouWVfAv7rvp2nTsbmZ/1ir6hbBIAiySGjsLKTIZyiY+pnIoKjVgh/bxO6nrZ
 RV/jBc5FLTsgYN3Pl9orJp06QaHtJjLnnfhI=
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Since the new lsm-based cgroup device access control is settled,
the explicit calls to devcgroup_inode_permission and
devcgroup_inode_mknod in fs/namei.c are redundant and can safely
be dropped. The corresponding security_inode_permission and
security_inode_mknod hooks are taking over.

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 fs/namei.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 567ee547492b..f601fcbdc4d2 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -34,7 +34,6 @@
 #include <linux/capability.h>
 #include <linux/file.h>
 #include <linux/fcntl.h>
-#include <linux/device_cgroup.h>
 #include <linux/fs_struct.h>
 #include <linux/posix_acl.h>
 #include <linux/hash.h>
@@ -529,10 +528,6 @@ int inode_permission(struct mnt_idmap *idmap,
 	if (retval)
 		return retval;
 
-	retval = devcgroup_inode_permission(inode, mask);
-	if (retval)
-		return retval;
-
 	return security_inode_permission(inode, mask);
 }
 EXPORT_SYMBOL(inode_permission);
@@ -3987,9 +3982,6 @@ int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 		return -EPERM;
 
 	mode = vfs_prepare_mode(idmap, dir, mode, mode, mode);
-	error = devcgroup_inode_mknod(mode, dev);
-	if (error)
-		return error;
 
 	error = security_inode_mknod(dir, dentry, mode, dev);
 	if (error)
-- 
2.30.2


