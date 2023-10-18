Return-Path: <linux-fsdevel+bounces-609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A59F87CD9A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 12:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DA2AB2158F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 10:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7F218E30;
	Wed, 18 Oct 2023 10:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F371945A;
	Wed, 18 Oct 2023 10:51:32 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8809F101;
	Wed, 18 Oct 2023 03:51:28 -0700 (PDT)
Received: from weisslap.aisec.fraunhofer.de ([91.67.186.133]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N8EdM-1rfLHD3yTI-014Buu; Wed, 18 Oct 2023 12:51:04 +0200
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
Subject: [RFC PATCH v2 11/14] vfs: Wire up security hooks for lsm-based device guard in userns
Date: Wed, 18 Oct 2023 12:50:30 +0200
Message-Id: <20231018105033.13669-12-michael.weiss@aisec.fraunhofer.de>
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
X-Provags-ID: V03:K1:QKuNcHsyjzZeVFhJge7r9EgZaJUd1hSQUNm5KrdnKw9WPc7MzKn
 oARcftJeCxBau0k8RbuFVQsbaKvoER/ApOI5iziIof3ikARFUAYuQ/e3CpGm2DvTbMneYjZ
 3mAX2olG5AbqRXD86FY2w3uJ7IS/uhVx/WgvP8bUqG6rm8A9UyrXr2PJ8PYZ5hkTbfiuPsc
 R65uN8EIxjOlPB7Uel4gg==
UI-OutboundReport: notjunk:1;M01:P0:UsmMmelH1QY=;Te31CKQmgxElaICDoMa60Hv9NZr
 V7G+LrLIi9tu0IPzzq2E4kLeXGgyZnPSxd4kOwZQGmR+qzhpNrEKSesPDqB/jdYVUzYevhqkU
 JasgoppivfgdH7GD47iRzHYMH+Ba3JEcNFoIcXGt313SnBMDRQMv32dBKGVzbx4kGSP9WhOFV
 nwfvj9+HHXgmUCEBukfuf9VNUDl2rdO7i83v1xmJl4Cg9O3MI3sANH3Ff7LjbbjJQwtshK7S4
 q7Nco8SVY99bn3hIKBxk5TiEMWUYRB53apBZ8cT7RwjaN5LYFnIWdnOrUkGUPETqffBVymt+F
 xePopQ1rUUR+6t1U4kzi8E8LDVtjqQhSVTsf3lLxYMuRChNAnEMvLLLViyVCWQcOKiTrPj2NU
 vhV85ztJkAkDnQwv5oI3uPKPeDnDjKMmnYQfE9y9ZX8wKKzG9TKcGbe7EAi3jWyMoaqXZRuzk
 JbyzfpiiTzcnWM5QJugsTt+qPJoTEQvuPpVYy1JJT2/faj9V35B4fEJzZgQ1LkAld78JVwcD2
 4tH4DE7joCdgoNdPIQsHTNIjfpMHrPjGs5uk4R8l6PWmKxwhdF8GYifopLp8HnrUcznBxqRmH
 jAbig9gTzAfKD/KLTCxrE2ORxhfyVvmaOw2oG028cicY/hXniY5taOu29c+l20ZiBHOkYr7QW
 zZmjytwe7FKRBT7p8jD9C90WMRXXDBn+UtKTiUATgzZhlxK2mGxvGXy4Ox94qvEDhpXQbaWam
 Ua3y7egjlnbF0P/3ji4700ALzjAYV5ZjlY++leIpVqA6Z5EZ18DL2XQCTrwjygDe9rcqNhCxm
 a/KNT4V6WtGUrp86t4Q/tXpHjkl/1iWtd/0bJUE8V/nGKq/Hf+3nm/4n0FitxEAER+klCFsL2
 DZRdVItQ32YjjNA==
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wire up security_inode_mknod_capns() in fs/namei.c. If implemented
and access is granted by an lsm, check ns_capable() instead of the
global CAP_MKNOD.

Wire up security_sb_alloc_userns() in fs/super.c. If implemented
and access is granted by an lsm, the created super block will allow
access to device nodes also if it was created in a non-inital userns.

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 fs/namei.c | 16 +++++++++++++++-
 fs/super.c |  6 +++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index f601fcbdc4d2..1f68d160e2c0 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3949,6 +3949,20 @@ inline struct dentry *user_path_create(int dfd, const char __user *pathname,
 }
 EXPORT_SYMBOL(user_path_create);
 
+static bool mknod_capable(struct inode *dir, struct dentry *dentry,
+			  umode_t mode, dev_t dev)
+{
+	/*
+	 * In case of a security hook implementation check mknod in user
+	 * namespace. Otherwise just check global capability.
+	 */
+	int error = security_inode_mknod_nscap(dir, dentry, mode, dev);
+	if (!error)
+		return ns_capable(current_user_ns(), CAP_MKNOD);
+	else
+		return capable(CAP_MKNOD);
+}
+
 /**
  * vfs_mknod - create device node or file
  * @idmap:	idmap of the mount the inode was found from
@@ -3975,7 +3989,7 @@ int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 		return error;
 
 	if ((S_ISCHR(mode) || S_ISBLK(mode)) && !is_whiteout &&
-	    !capable(CAP_MKNOD))
+	    !mknod_capable(dir, dentry, mode, dev))
 		return -EPERM;
 
 	if (!dir->i_op->mknod)
diff --git a/fs/super.c b/fs/super.c
index 2d762ce67f6e..bb01db6d9986 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -362,7 +362,11 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	}
 	s->s_bdi = &noop_backing_dev_info;
 	s->s_flags = flags;
-	if (s->s_user_ns != &init_user_ns)
+	/*
+	 * We still have to think about this here. Several concerns exist
+	 * about the security model, especially about malicious fuse.
+	 */
+	if (s->s_user_ns != &init_user_ns && security_sb_alloc_userns(s))
 		s->s_iflags |= SB_I_NODEV;
 	INIT_HLIST_NODE(&s->s_instances);
 	INIT_HLIST_BL_HEAD(&s->s_roots);
-- 
2.30.2


