Return-Path: <linux-fsdevel+bounces-26048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42288952C1D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 12:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DB69B25F8B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 10:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E158120FAAB;
	Thu, 15 Aug 2024 09:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="DKXqD5e9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3E8201266
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2024 09:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723713909; cv=none; b=YqpaT0JwZiYZotynb0/2FfixYP0WJST2YOMfHLahSbqE1TtXHI9/PYcrhBtxA12acGqLq+Y5TBb2of8bnYvzoGIZy6TlL1iIDN4FzZaYfXW9S4GZlH8c//CAeCovfsm7sMLWUA+RQaI9MZ2nlJWpYZ0jDWYu5UGVK3NGJNCnEUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723713909; c=relaxed/simple;
	bh=4adc61tKzjK2fTdo7B9pTquQAHQKVd/XEnUnW9CoK7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rMPDENPrrGvUQ2E3iZ+hk2cZKVWE5qUL5o8dj71CT4YzwVC896lf1cI9YMbeCwBl5ZCkpuvguLwuu3qMMgokF2SkQV0wZJdY8+vrZW0W1ZzisfjNxjF4lPzy/wuE7K5cdbM9AaTmGpyFut4O6GNjqudpVXSl5jSWgMRKJIS9Ftk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=DKXqD5e9; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6D9003F31C
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2024 09:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723713906;
	bh=ftHOv+os2MH3Qk9OKnsGMHrGZxHBoFg3umKFJ4e1joU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=DKXqD5e9tHFJS/l+r2i86IlJfKbS9PFq/X6Jj4pjfhuwvKJL/HpOPsFJKMmLIk77f
	 Hd7dFi8dAMV1fgJyK49q0ZSdoL57991ge89/T4q/bkffN2pvstqg8Z8QcHQhjDH81L
	 gSnTxMzgDTxmUfkvFWdf5VxmlU2ort6Y5yULD2s6T8NWgxydsGaOwPzI8Zr0QI0l/L
	 vv8uYid8OUpaImQI4vWMwYuG54B/JBbFKBK1Ej4lraly5CXynOD2HuOuyeWZnSFt7H
	 UN3OBgoILwsGfkeQEMVozK0mDfkAhQhDCQs+dM3PxJdj2q/WOwYnTjzNs8pfL+UoaK
	 YcwFd1Y3AZcqQ==
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-532fbabc468so773704e87.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2024 02:25:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723713903; x=1724318703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftHOv+os2MH3Qk9OKnsGMHrGZxHBoFg3umKFJ4e1joU=;
        b=Sr7O6pQA4MBAUtSSz5L25iiP2HVfUUnfav4pQLcSJuKUprzdlu4xqpHlQ6Gq537VSB
         yjY9GO3YOx5LQp+JFycDAhYHvbO8kzzf0ffTV+cYNimny7n+hpIxQIuasCTKLHPKmHAx
         Q60EUAzqfOlhdNS7plfh8j4P793qw4EVgolT2luKTtWXarcQ+ji89B7R72k367kbESAJ
         zz6Ghn9kNkYS+y6rzYwVgihLR35hGDaV5r8Tj9By1ALwe0lorNc7KA00QmC+LVJzCub7
         KqNrEguWV+LvA62MoHcA57NCmdg3FxzHenu2VC7vanY+rCcozn/oRdtNjwdw58kbR5oM
         4D/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXrvLuO12w67JPeI6xfnStkIECxyC/O+6iRyIJd1748CJdOggP9pug4DYaq2kviZFAtilMCk+r/vWZcRRzTfUXq6ZFICJM67kwiqUx9Dg==
X-Gm-Message-State: AOJu0YyFkfAsNWityC4na4+u8CpN948Xvrad7U+09vKx0WzhFmtx0M1l
	sf9eAmvwqPrbctUIflD4mzw5Pgp76a3ETB8g1bEgSYRgPp9SSoDgc2Ue8U6EXR8NhFvjiTOwQig
	nF930O7Og9+qQLIdrNAcnRPEbV19U4TBXamQeNYPztHok5pdCaY3btEXPBTxr81ebyc9Zvp5DSs
	5YnpE=
X-Received: by 2002:a05:6512:282a:b0:52d:582e:410f with SMTP id 2adb3069b0e04-532edbbcdddmr3352411e87.46.1723713902558;
        Thu, 15 Aug 2024 02:25:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTZkKDHUW/a1SQ8jPfQJ+Q+tEU5ep/4T2uXV0NfHa+967OhzX5TBfB5pRRpmHTOYVJYolsYw==
X-Received: by 2002:a05:6512:282a:b0:52d:582e:410f with SMTP id 2adb3069b0e04-532edbbcdddmr3352395e87.46.1723713902114;
        Thu, 15 Aug 2024 02:25:02 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383934585sm72142866b.107.2024.08.15.02.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 02:25:01 -0700 (PDT)
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
Subject: [PATCH v3 07/11] fs/fuse: drop idmap argument from __fuse_get_acl
Date: Thu, 15 Aug 2024 11:24:24 +0200
Message-Id: <20240815092429.103356-8-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815092429.103356-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240815092429.103356-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We don't need to have idmap in the __fuse_get_acl as we don't
have any use for it.

In the current POSIX ACL implementation, idmapped mounts are
taken into account on the userspace/kernel border
(see vfs_set_acl_idmapped_mnt() and vfs_posix_acl_to_xattr()).

Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: <linux-fsdevel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Reviewed-by: Christian Brauner <brauner@kernel.org>
---
 fs/fuse/acl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index 04cfd8fee992..897d813c5e92 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -12,7 +12,6 @@
 #include <linux/posix_acl_xattr.h>
 
 static struct posix_acl *__fuse_get_acl(struct fuse_conn *fc,
-					struct mnt_idmap *idmap,
 					struct inode *inode, int type, bool rcu)
 {
 	int size;
@@ -74,7 +73,7 @@ struct posix_acl *fuse_get_acl(struct mnt_idmap *idmap,
 	if (fuse_no_acl(fc, inode))
 		return ERR_PTR(-EOPNOTSUPP);
 
-	return __fuse_get_acl(fc, idmap, inode, type, false);
+	return __fuse_get_acl(fc, inode, type, false);
 }
 
 struct posix_acl *fuse_get_inode_acl(struct inode *inode, int type, bool rcu)
@@ -90,8 +89,7 @@ struct posix_acl *fuse_get_inode_acl(struct inode *inode, int type, bool rcu)
 	 */
 	if (!fc->posix_acl)
 		return NULL;
-
-	return __fuse_get_acl(fc, &nop_mnt_idmap, inode, type, rcu);
+	return __fuse_get_acl(fc,  inode, type, rcu);
 }
 
 int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
-- 
2.34.1


