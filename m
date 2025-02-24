Return-Path: <linux-fsdevel+bounces-42440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B8CA426E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 16:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29A4B16DBB7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 15:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FB726137A;
	Mon, 24 Feb 2025 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B5qBLRKQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2302586E8
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 15:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740412124; cv=none; b=qyd0l9Vce0+ykemwZrQyqQyBO028MuxAnB8Z1dmUoSEWfRBq+CAIdBu1YLsaZi2fCy5VTxdxFXckkJs/D8doBGs+qdKx6uWj7Hpq/jzCQSPqCx4mGaouUe4UO83IlbkkzzxQgNfViGkAVzA1sFnn7ywj44WYoZII5mnf1pRCcqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740412124; c=relaxed/simple;
	bh=Yoe+1Q/wd9KnY0rECwMRuQsaRIV7NNTtgYXl3H+TA1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bbCRh6nBGPIvrZDvtA0pInwFRdDpshnL4jOx5foTvIR3wfIPX/7SZmCrYZ7ajcYlDldQPfd1T1jvX+49YXnVkdsnmYUglQTEw0nQVGaXlsBiwN0jbagfZ+3fQHnz/FEMISqbVB3vnoBk220jYFLa6WInX7eeOZyqscijM8gGZpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B5qBLRKQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740412122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VZ6BYY6WM+ve8w+hCFhsoiQPqDoYIprknITffKagk4A=;
	b=B5qBLRKQPojI0aIGX90Sc7vxMw/g8bW2gYLhCkWxxIyGk7t2LUFRtmX3joc0j8f+ld5KOg
	04ugIFzQ8DAhh+t1JCiR9llsD42LE8JkKcu7tBlcV85C4qtXC+JV0CPtENpr2xlc4fuMHl
	sRdEW+gorkJJxARZFh9lSiwQnyQ4TBU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-gZoFgYrROPmA-GAdfOk8Lg-1; Mon, 24 Feb 2025 10:48:40 -0500
X-MC-Unique: gZoFgYrROPmA-GAdfOk8Lg-1
X-Mimecast-MFC-AGG-ID: gZoFgYrROPmA-GAdfOk8Lg_1740412118
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4399c32efb4so23195595e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 07:48:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740412118; x=1741016918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VZ6BYY6WM+ve8w+hCFhsoiQPqDoYIprknITffKagk4A=;
        b=gxN2qo9Y3SFV8xzQgrlz4d4bKO1/aAVk9f6LFoJjzqUa3IDsuNpe6TPa1j7Ci7L3jU
         ScJl5MCm0FweYBwb3zHb6aLjPMwTQINIm95LTEsH5X5S/kYsojSR9YGLax35w9YZcKvj
         ttHqtGI8mit/IhrZbkdETXqOPnUWFWQbUuXr6e33sVJYzqabm990FCgLUs8Cz9QAH6Y8
         l83z6QVoGeKX/73EYjGWyp8kEr5/SUW5fTHWs8N9vUnGS6FfdpXBkk3CxchUs5xZcSiE
         Fg6iOpsHCze7PX5yRH4/AFaxcQycpq8j9IIzLu/m9/HcJH2RnHEVMEld6cOQ3vfUx8e0
         u4BA==
X-Gm-Message-State: AOJu0YyuOFQ+msQQMI65m+UNn8+sOguIJoif53SY6+MMkRIyMzIf8TsU
	gJYgjfGpbr26/WgJ+0lo/RNJsh97L8YBNEOFrYO8bBoPNOGqW2L61FOLVm4yvtmohSSjKGBJcsd
	UWxqul4nnZ/xdl49ksQooMVzwwM0dvvez3VYvfI1pRYPkVDDKADZcrePHOFWorkM=
X-Gm-Gg: ASbGncucGl6o+4m7LUqrWgr83YwRkGGpT+tVi61xG+mHgU2Ja7KlBlVo5dhaEwfou2C
	ourxuNabuem6e+k1qCxj3y5CfeZKdMvnC946mlKdyMcD7LJi6Jp6rH4Z5HqM4g6Ua7GfVn5/jDH
	oHk5AEgQAoZPpup6/g346QStujvt8qejrqs3l/e/ECX5Z4cKQW/pawX6JTYJDwDeutc1P2LhyaB
	4mvvU8NXfl+Ea482kHgzytVd5ZcAB1Oqee6H2i8TLAoNWxdAYqZLjbeXnzeJHS3asLr1j1Vo8y3
	GCN/rE2bnqNG6y/CoL7hTTj2GobRyTop8bYEPGWuvtnXyPs5bCq+Kf3g/YPvCMMpgt7pEeu4
X-Received: by 2002:a05:600c:4ec7:b0:439:95b9:99f1 with SMTP id 5b1f17b1804b1-439ae2e1d53mr110480795e9.4.1740412117910;
        Mon, 24 Feb 2025 07:48:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6TrZ14Kh1RvspHl0cC4TVOhV53fmM42M70m1mCqCLCXtOJB/rbhrvWdei//Y3u75VLLDQ1g==
X-Received: by 2002:a05:600c:4ec7:b0:439:95b9:99f1 with SMTP id 5b1f17b1804b1-439ae2e1d53mr110480595e9.4.1740412117540;
        Mon, 24 Feb 2025 07:48:37 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (89-148-117-232.pool.digikabel.hu. [89.148.117.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b0371cfcsm108736435e9.36.2025.02.24.07.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 07:48:37 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: selinux@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>
Subject: [PATCH] selinux: add FILE__WATCH_MOUNTNS
Date: Mon, 24 Feb 2025 16:48:36 +0100
Message-ID: <20250224154836.958915-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Watching mount namespaces for changes (mount, umount, move mount) was added
by previous patches.

This patch adds the file/watch_mountns permission that can be applied to
nsfs files (/proc/$$/ns/mnt), making it possible to allow or deny watching
a particular namespace for changes.

Suggested-by: Paul Moore <paul@paul-moore.com>
Link: https://lore.kernel.org/all/CAHC9VhTOmCjCSE2H0zwPOmpFopheexVb6jyovz92ZtpKtoVv6A@mail.gmail.com/
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 security/selinux/hooks.c            | 3 +++
 security/selinux/include/classmap.h | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7b867dfec88b..212cdead2b52 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3395,6 +3395,9 @@ static int selinux_path_notify(const struct path *path, u64 mask,
 	case FSNOTIFY_OBJ_TYPE_INODE:
 		perm = FILE__WATCH;
 		break;
+	case FSNOTIFY_OBJ_TYPE_MNTNS:
+		perm = FILE__WATCH_MOUNTNS;
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 03e82477dce9..f9b5ca92a825 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -8,7 +8,7 @@
 	COMMON_FILE_SOCK_PERMS, "unlink", "link", "rename", "execute",   \
 		"quotaon", "mounton", "audit_access", "open", "execmod", \
 		"watch", "watch_mount", "watch_sb", "watch_with_perm",   \
-		"watch_reads"
+		"watch_reads", "watch_mountns"
 
 #define COMMON_SOCK_PERMS                                              \
 	COMMON_FILE_SOCK_PERMS, "bind", "connect", "listen", "accept", \
-- 
2.48.1


