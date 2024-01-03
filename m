Return-Path: <linux-fsdevel+bounces-7294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D06698237F9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 23:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 553EB285404
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 22:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B606820DCB;
	Wed,  3 Jan 2024 22:23:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20F820B09
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jan 2024 22:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 403GjZuL025687
	for <linux-fsdevel@vger.kernel.org>; Wed, 3 Jan 2024 14:23:49 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3vda6tawnw-15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jan 2024 14:23:49 -0800
Received: from twshared38604.02.prn6.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 3 Jan 2024 14:23:42 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 5D94C3DF9EB5A; Wed,  3 Jan 2024 14:21:17 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <paul@paul-moore.com>,
        <brauner@kernel.org>, <torvalds@linuxfoundation.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <kernel-team@meta.com>
Subject: [PATCH bpf-next 18/29] bpf: fail BPF_TOKEN_CREATE if no delegation option was set on BPF FS
Date: Wed, 3 Jan 2024 14:20:23 -0800
Message-ID: <20240103222034.2582628-19-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240103222034.2582628-1-andrii@kernel.org>
References: <20240103222034.2582628-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: WEgeGc05nZWuQiAhkgCnM4rEQNJgspYf
X-Proofpoint-ORIG-GUID: WEgeGc05nZWuQiAhkgCnM4rEQNJgspYf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-03_08,2024-01-03_01,2023-05-22_02

It's quite confusing in practice when it's possible to successfully
create a BPF token from BPF FS that didn't have any of delegate_xxx
mount options set up. While it's not wrong, it's actually more
meaningful to reject BPF_TOKEN_CREATE with specific error code (-ENOENT)
to let user-space know that no token delegation is setup up.

So, instead of creating empty BPF token that will be always ignored
because it doesn't have any of the allow_xxx bits set, reject it with
-ENOENT. If we ever need empty BPF token to be possible, we can support
that with extra flag passed into BPF_TOKEN_CREATE.

Acked-by: Christian Brauner <brauner@kernel.org>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/token.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
index 17212efcde60..a86fccd57e2d 100644
--- a/kernel/bpf/token.c
+++ b/kernel/bpf/token.c
@@ -152,6 +152,15 @@ int bpf_token_create(union bpf_attr *attr)
 		goto out_path;
 	}
=20
+	mnt_opts =3D path.dentry->d_sb->s_fs_info;
+	if (mnt_opts->delegate_cmds =3D=3D 0 &&
+	    mnt_opts->delegate_maps =3D=3D 0 &&
+	    mnt_opts->delegate_progs =3D=3D 0 &&
+	    mnt_opts->delegate_attachs =3D=3D 0) {
+		err =3D -ENOENT; /* no BPF token delegation is set up */
+		goto out_path;
+	}
+
 	mode =3D S_IFREG | ((S_IRUSR | S_IWUSR) & ~current_umask());
 	inode =3D bpf_get_inode(path.mnt->mnt_sb, NULL, mode);
 	if (IS_ERR(inode)) {
@@ -181,7 +190,6 @@ int bpf_token_create(union bpf_attr *attr)
 	/* remember bpffs owning userns for future ns_capable() checks */
 	token->userns =3D get_user_ns(userns);
=20
-	mnt_opts =3D path.dentry->d_sb->s_fs_info;
 	token->allowed_cmds =3D mnt_opts->delegate_cmds;
 	token->allowed_maps =3D mnt_opts->delegate_maps;
 	token->allowed_progs =3D mnt_opts->delegate_progs;
--=20
2.34.1


