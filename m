Return-Path: <linux-fsdevel+bounces-28424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2908F96A214
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 17:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A14EA1F23944
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 15:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE27118BC2F;
	Tue,  3 Sep 2024 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Q/Y5sx7H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BBC1925AA
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376637; cv=none; b=WMJT7ZVayDkp383t8SzDBDW4uYQ0Y174QTnuO0801bAh0t8fuEv8Ivmxa1IxPXlXIeSkkKLggGJTbuDo3BsNZy39eIN6yF62m5Wcuxj9/fEtbdZxsuJ6Ghx/tyTvUvXRJDeFaTuUjgdOCuxU0qTpXG3kOeZ2le//OVj+kI9Hv94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376637; c=relaxed/simple;
	bh=ezrwIWPEtkVKsO2BZ8GHjfDUp3paNgF+C0sOeuA/x40=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lA+4UFpKKBi4ABdQmrjhLs/6DakUJqwYL4Y+pd2eCqK7qlsGNZl9lmX7JvqBRz1o7TAGvcawQcfXbiiSQnk7WlYdSA3tIE3VB4AwyAOdNJXKJB+lXFN/3XMZtv50odi60vZBR92QQpojkIyfW3PY00H4cKpNFyBbulz3pU0b5iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Q/Y5sx7H; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BA36D3FADB
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 15:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725376633;
	bh=UlVqr8qfq0zm4LadiFaTT35TCbrEM7DrGylkId+7er0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=Q/Y5sx7Hjj9AbUArEUlD5AOtdoWF3y4v3vXtcfd6nk7K8F9zM0xym8Zp7m4taBnI8
	 JVdquzhnM0MWeDE+S3T29vJJgT0tz+3eXd66a/DkGIRr+vB13t1BYeSc7uiRzpxOKb
	 6oeGYseQgLT7TahKYdTt1Je21izR/Ohy0lNF2pejpwyO3Lb7wChyz09w4snQwKIw3T
	 KeSCwy1Sp2wEop2DTQALtgOpaWqe2q1wZmXC3HzARLQqkl2cvIipjlxbGIdEB2zMO1
	 btU6gfUX0sIyyjIPU6280CIoXvR1seSYXUgiyncTNV6QxZrck/TWegXOEdNaupB1f0
	 y2FDagf6g+gxw==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a870cad2633so477433966b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2024 08:17:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725376633; x=1725981433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UlVqr8qfq0zm4LadiFaTT35TCbrEM7DrGylkId+7er0=;
        b=SGKN3N1zwQjLEPCZxyZJBuBXmfxuf8FLcNyk9a77/ttj/G8Xx4eUhkWVNyV6qEI9oO
         R32XNnKK5Sg6nu8XosUEuIrjhurAYAByxTAJRvWiaRPg8SVi/lmxwp0tSdq5cRw8WMza
         UDSlkydnAKC0iieON6/kPulfJSwFyQJ1YJ+HEvPUVk2itAbXgdv3UAiEBtsfd5mLOstn
         Hx6ntAfQBUxOBD8MQZFndwE/9PL2F96B9VsP1DyepCZTfxtZewParLc5uDbZ56ROyfnb
         r9z9ZcLo7lZwqfs9NCt2wpQkMfskQRTQXLJ3HsHJS1QFMwiwWTqXN+i32lCjs4yK7lkG
         o/KA==
X-Forwarded-Encrypted: i=1; AJvYcCUHKSOlZ1f83nDom+5bHM7jmiaNQk4fHsZ9Zqo1wR3j3zeqx7DBhxKWJGqYjmRuZ29wMCzAOevxMnWA6Prm@vger.kernel.org
X-Gm-Message-State: AOJu0YyQJ/VaRPNauLvVTX/aRx6NemWIZmh6hpKpflr/QZotWE4CLjmn
	RZ3usYW2C3+1Q+KmFh4rTkakLTnqmbxm+SQz0he/cN2T1/1pwMB4fMvE+lDX3LJCoI3hel4npkU
	tkkPp3OnZiNwtM5/nFCsQXWZHi2q1K5lmtyjSn/KnRkwKU6tlc4r7ibIt1bx6VHOERwh73/gwNY
	y0e8I=
X-Received: by 2002:a17:907:9487:b0:a77:c30c:341 with SMTP id a640c23a62f3a-a897f1c3e3dmr1290755866b.0.1725376633315;
        Tue, 03 Sep 2024 08:17:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGL2gL9kVUAD7c/U4EREwo/0f6jUYuTiYlOJEoA7Rsdp22DZQmd9M2c7KMwQk3rXunkx2Y1ag==
X-Received: by 2002:a17:907:9487:b0:a77:c30c:341 with SMTP id a640c23a62f3a-a897f1c3e3dmr1290754566b.0.1725376632859;
        Tue, 03 Sep 2024 08:17:12 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a19afb108sm156377166b.223.2024.09.03.08.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 08:17:12 -0700 (PDT)
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
Subject: [PATCH v4 11/15] fs/fuse: support idmapped ->rename op
Date: Tue,  3 Sep 2024 17:16:22 +0200
Message-Id: <20240903151626.264609-12-aleksandr.mikhalitsyn@canonical.com>
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

RENAME_WHITEOUT is a special case of ->rename
and we need to take idmappings into account there.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: <linux-fsdevel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
v2:
	- this commit added
v4:
	- support idmapped ->rename for RENAME_WHITEOUT
---
 fs/fuse/dir.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 08bf9cc51a65..d316223bd00b 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1025,7 +1025,7 @@ static int fuse_rmdir(struct inode *dir, struct dentry *entry)
 	return err;
 }
 
-static int fuse_rename_common(struct inode *olddir, struct dentry *oldent,
+static int fuse_rename_common(struct mnt_idmap *idmap, struct inode *olddir, struct dentry *oldent,
 			      struct inode *newdir, struct dentry *newent,
 			      unsigned int flags, int opcode, size_t argsize)
 {
@@ -1046,7 +1046,7 @@ static int fuse_rename_common(struct inode *olddir, struct dentry *oldent,
 	args.in_args[1].value = oldent->d_name.name;
 	args.in_args[2].size = newent->d_name.len + 1;
 	args.in_args[2].value = newent->d_name.name;
-	err = fuse_simple_request(NULL, fm, &args);
+	err = fuse_simple_request(idmap, fm, &args);
 	if (!err) {
 		/* ctime changes */
 		fuse_update_ctime(d_inode(oldent));
@@ -1092,7 +1092,8 @@ static int fuse_rename2(struct mnt_idmap *idmap, struct inode *olddir,
 		if (fc->no_rename2 || fc->minor < 23)
 			return -EINVAL;
 
-		err = fuse_rename_common(olddir, oldent, newdir, newent, flags,
+		err = fuse_rename_common((flags & RENAME_WHITEOUT) ? idmap : NULL,
+					 olddir, oldent, newdir, newent, flags,
 					 FUSE_RENAME2,
 					 sizeof(struct fuse_rename2_in));
 		if (err == -ENOSYS) {
@@ -1100,7 +1101,7 @@ static int fuse_rename2(struct mnt_idmap *idmap, struct inode *olddir,
 			err = -EINVAL;
 		}
 	} else {
-		err = fuse_rename_common(olddir, oldent, newdir, newent, 0,
+		err = fuse_rename_common(NULL, olddir, oldent, newdir, newent, 0,
 					 FUSE_RENAME,
 					 sizeof(struct fuse_rename_in));
 	}
-- 
2.34.1


