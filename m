Return-Path: <linux-fsdevel+bounces-28417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 274DB96A1FF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 17:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E3FD1F24B24
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 15:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D24E18BBA1;
	Tue,  3 Sep 2024 15:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="g+ofcIm+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D9318BB8E
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 15:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376621; cv=none; b=BiRxEI53s2+zmc/MBmVJwhHPZLyZC4nBGISirb+qFW8xBsQbMcZRxH1BwujVFQoY2kXi2TzwXd8OrqoIM6nQSxTHZN7DyorMGG+awOKQ29qYA912jS6v8sM8lmASgb/jMGSu+OVn61DbdDDpdZ5OrWxL8LbW66cMj1XZpuH5gJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376621; c=relaxed/simple;
	bh=+0zwTUGo6+RzPqyLPLoGhao9V7bGVcfHhuOQ58510LE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=er858B00057PCf+9Q8T1BAU4DIoVDjvBx3LqWfZGK9N/8UXYkN1k4OJ48HQU5TaxJaHy6PrsIfq+PIG6HnzdpAkFphhEoiH6jRot+oOaY8izlGOpdD+ZBg2Ek9Y+0B6Yp4c95Us9j4C5lRWTIpTX9Lg2jU+ku81W/YDQle5FKfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=g+ofcIm+; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0B8AE3FE1F
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 15:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725376616;
	bh=JC0kbEJjIhY7PwaINGFTAAblNYwex3Ap6OFdo5D4DqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=g+ofcIm+rqDR6dWLcimaW9z0m2Ifg9eK0bJtFN2JHnGERtxRkruqxNfejY80PyShu
	 oxseGvVNdE530qtdnGTlWe/oD4bR9w32Dxw3ftgptwWYrJyfYB6ILOuSdEqOPmudsM
	 WCvd1t7M0Nv/niZXSLwUJ/2CKKffWVSE31HB86MniORNWIfp8ZCd8lyQRYLjTCDLS+
	 sUSIZeWl1zTeElmaGkgDkE0JUz/MWleR2NVuaUAs9JARzTz2UHfli2LyJwkXXpzwlJ
	 B0XWtF/P1U4p59sLgA8e/16rD5Gkzj5d+qE1GAz1Va1GUH5naG+cDiN7AMwvwXUhZu
	 o6DDCK0ssBVNg==
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5c244732fe0so2932332a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2024 08:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725376615; x=1725981415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JC0kbEJjIhY7PwaINGFTAAblNYwex3Ap6OFdo5D4DqU=;
        b=q7lJrWwmaJC9lbK959WlsEJBn6TUF64SS/vgcGgSzRRtpFtePa8W6oP27vSRKB1T5H
         A0x6MpJDd0s/3854cw8nNtpccQZgnpiuOh6ENCTeqN4DyCUUiNYmIwIxB6edbZP98XEc
         cKorMuKTr02oIsTxK0z7AjGP9G3TM6FKy+wIyO6prCb2tr3znWPHp+oDx8inWfIYKblk
         rEPtIOaOE1qkej41Y/odBnbccweR7HLZjjugcf9FX7LJPbt7kamkCko8LbvM47DiVC3C
         lUXPboeE99Ql/6ERMz4HrrUdcqMNIQ3s03Yqr6azlFc817yS4TD3o1mmzd+Fzw9xzpD3
         6O0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQf0crpJKTjuyOYeMaM7F1EfgSBkSxn2NgILAElQMXNDAyC0TEWwROX2DyvsHfb2MBKONXnUcmSerEadip@vger.kernel.org
X-Gm-Message-State: AOJu0YwqrpmRGjv4qkfSJ+TnaDE+13girh6E4B1bAQ9n3qVqLTNHHqYL
	5U/Y3Sue2YrTEwMLiqva6osl7MuUfNKBXEBTqcjUad5WEmG6xKg2BLQpNSUlDzUYhlYH1SyMCdf
	EP2vA2GBmZOD65yj5j+OCY2Bcu5VXVijC+U4e07F48ZVqpsHaJOydlnkEEprTbfGn5L7s377vJN
	S2VUM=
X-Received: by 2002:a17:907:7f22:b0:a7a:8586:d36b with SMTP id a640c23a62f3a-a8a32df201amr77097766b.3.1725376615495;
        Tue, 03 Sep 2024 08:16:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6yFu1Bsw3W/nZaOc47kv/qKH1mcQ+bQ3WmyZBHT/KsKGUKlObSlloDjZT275IsdiJSzRa3A==
X-Received: by 2002:a17:907:7f22:b0:a7a:8586:d36b with SMTP id a640c23a62f3a-a8a32df201amr77095866b.3.1725376614995;
        Tue, 03 Sep 2024 08:16:54 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a19afb108sm156377166b.223.2024.09.03.08.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 08:16:54 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: mszeredi@redhat.com
Cc: brauner@kernel.org,
	stgraber@stgraber.org,
	linux-fsdevel@vger.kernel.org,
	Seth Forshee <sforshee@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 04/15] fs/fuse: support idmapped FUSE_EXT_GROUPS
Date: Tue,  3 Sep 2024 17:16:15 +0200
Message-Id: <20240903151626.264609-5-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903151626.264609-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240903151626.264609-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We don't need to remap parent_gid, but have to adjust
group membership checks and take idmapping into account.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: <linux-fsdevel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
v4:
	- this commit added
---
 fs/fuse/dir.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 2a8344776350..b0b57f383889 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -545,17 +545,21 @@ static u32 fuse_ext_size(size_t size)
 /*
  * This adds just a single supplementary group that matches the parent's group.
  */
-static int get_create_supp_group(struct inode *dir, struct fuse_in_arg *ext)
+static int get_create_supp_group(struct mnt_idmap *idmap,
+				 struct inode *dir,
+				 struct fuse_in_arg *ext)
 {
 	struct fuse_conn *fc = get_fuse_conn(dir);
 	struct fuse_ext_header *xh;
 	struct fuse_supp_groups *sg;
 	kgid_t kgid = dir->i_gid;
+	vfsgid_t vfsgid = make_vfsgid(idmap, fc->user_ns, kgid);
 	gid_t parent_gid = from_kgid(fc->user_ns, kgid);
+
 	u32 sg_len = fuse_ext_size(sizeof(*sg) + sizeof(sg->groups[0]));
 
-	if (parent_gid == (gid_t) -1 || gid_eq(kgid, current_fsgid()) ||
-	    !in_group_p(kgid))
+	if (parent_gid == (gid_t) -1 || vfsgid_eq_kgid(vfsgid, current_fsgid()) ||
+	    !vfsgid_in_group_p(vfsgid))
 		return 0;
 
 	xh = extend_arg(ext, sg_len);
@@ -572,7 +576,8 @@ static int get_create_supp_group(struct inode *dir, struct fuse_in_arg *ext)
 	return 0;
 }
 
-static int get_create_ext(struct fuse_args *args,
+static int get_create_ext(struct mnt_idmap *idmap,
+			  struct fuse_args *args,
 			  struct inode *dir, struct dentry *dentry,
 			  umode_t mode)
 {
@@ -583,7 +588,7 @@ static int get_create_ext(struct fuse_args *args,
 	if (fc->init_security)
 		err = get_security_context(dentry, mode, &ext);
 	if (!err && fc->create_supp_group)
-		err = get_create_supp_group(dir, &ext);
+		err = get_create_supp_group(idmap, dir, &ext);
 
 	if (!err && ext.size) {
 		WARN_ON(args->in_numargs >= ARRAY_SIZE(args->in_args));
@@ -668,7 +673,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	args.out_args[1].size = sizeof(*outopenp);
 	args.out_args[1].value = outopenp;
 
-	err = get_create_ext(&args, dir, entry, mode);
+	err = get_create_ext(&nop_mnt_idmap, &args, dir, entry, mode);
 	if (err)
 		goto out_put_forget_req;
 
@@ -798,7 +803,7 @@ static int create_new_entry(struct fuse_mount *fm, struct fuse_args *args,
 	args->out_args[0].value = &outarg;
 
 	if (args->opcode != FUSE_LINK) {
-		err = get_create_ext(args, dir, entry, mode);
+		err = get_create_ext(&nop_mnt_idmap, args, dir, entry, mode);
 		if (err)
 			goto out_put_forget_req;
 	}
-- 
2.34.1


