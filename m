Return-Path: <linux-fsdevel+bounces-63282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D808BB3F23
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 14:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99AD81C7CDC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 12:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3983112D0;
	Thu,  2 Oct 2025 12:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gr+l6Os9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72253112B8
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 12:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759409735; cv=none; b=uMXnaPh6+VbeD7eQWrUh6cKbd5yOrBDNSznOq8ZcqdAHECc85StDY8tB0EmRDEJj2Il1JMUKBgOwSKEM3UarRgkAGBX6nRznBtYi3duj7/QC6DpwX36IWbNYAQy9OgAJyqJP5tc83rBvypr+qTpaHEqcMRIZcCwCZMrLOMYv0vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759409735; c=relaxed/simple;
	bh=bBoPByU0u+Zox2711PmvFaMUe787bDzh8gdKqG+iuX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MoE4wv1R7cii3nmMcgcejN2LZVtcvb2DJYybeM8H1Mrl3eppgFD73X2KkWyRJizgZgO/TMKk+pzTbkUadagpxB/fW4PXCCwyLYpZFy//jlpk1WhAANiP3G909cq9x4UcZVSJN7amSYjq9+cduS/iDejLbMpYYu2kt7KuOzh/F/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gr+l6Os9; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7811fa91774so883778b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Oct 2025 05:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759409733; x=1760014533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZnL+H7vxHEMgbhRqepsLGLcPNeyBbhnobl0F6exUMM=;
        b=gr+l6Os9n30Qbt5URAwCsMoOKLPuYq0O+Upj66H/9iI6DZbBjRifZJ2a/DHfk4kKDl
         sEN1k5crBD58tcibf8mYdqgP4FDL1wD6j08yk2VK4+9Ile3X/VOcNHkBsoysE+iW3FMr
         KSTf4o4uKWjea0ZJX4bTGoqMiPi3KxoHAREfuHdK4SdpVPbK59bRWa05Oo+lMXktujFE
         /yTdBGSYNPw2mmWuzgOqO4fxOQ9pnW3lcRM6/X9GvFj7DkqyE4yRj7zFmz8b4KJ0pg0u
         PQdN3QODWZtfm2jwjdGdXJ4wzTRrdszj5yunGmqU5Q3/W3TdmOuKQNfgFQEDgq6M/eEF
         ks3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759409733; x=1760014533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZnL+H7vxHEMgbhRqepsLGLcPNeyBbhnobl0F6exUMM=;
        b=KSSPD7Okpmz4DgLq7+l/14+NhnwYgNhYpiDb4pDH9+XlQ/Zod2O/gUlh3lJlZez1g7
         6d+wb9w6NYSxE5JcC8SJ8d0j9e/LSc4TGyhbDnVflUH9E/Oq+hOGk27Y1Bi3Jl+RyNCU
         xJYbrjtspInW5ptfYp5fGAo6P6PbtUBvPOnyp6hNEuXBzy4KZfOhvViJPwm9EvNMhTGX
         8sk2Hk3D/JykNNea/CevAYds4EyYXEHD6KfoNjpJOebO6j+q79qYRRnVBr/HnoIaXBex
         J96kyiVP8BqZKJA8zoZdyQSyO8/XuD+1jj/JTA2+WO03szUbKYg3gUxRvppSLx0yPOoe
         kAIw==
X-Gm-Message-State: AOJu0YzPW7ni4l9yzX4IhF2Uvws55fHev3A687qpeCn8YcAah14Zn4ue
	7OF+cRLRwFdMApheer5tXg9zQWYZGnox9RMLl5TPxj2LqZSCFI4AYpnr
X-Gm-Gg: ASbGncvIHpJKXqQdNPtXR6j/LmpXL39LSYR/tNOvqBq6KsPIJF+5DPbtFNCQVhPdVUy
	r5tBab8eVEZpM4ZCSmrMmVIr+2K4XTO4aRkwMsiJhPtUCpx7boSlfPr4Z8kDOroGCGJqanuy9Yr
	UOtqgEhZ0hVlxFstZcEsuIPLPMP2UVl+JLsvv/TzzaA7OCLnU+iH4FjTJwWWRsdTE31HMln2mIa
	Y7VeyGvyElvW6eWljFevCXP/N7XegxWtjHn/ua9EaiZbnepRn8qnynpNKdISr9KibIt+L6Ztcul
	bcpbYePXyxNgEPK9BePXMO1LOYqe4bqt0mVRZq5i37CEQYUDug6xZrzL4YWqjYZ3F/LW7HLINbs
	HKWco5V7XPIDM56/vvsvFIKtfQ9gFiPRQDlFCJZbTNM3zXAynPZoWoxFGWA==
X-Google-Smtp-Source: AGHT+IHQERmfs2RD78TSJO1M4xWw3jZsSBvgjQ16GqqTIwVJMEmNueVgzhZUrDF50m3mwbjFfRlmmA==
X-Received: by 2002:a05:6a00:bb0e:b0:781:2538:bfb4 with SMTP id d2e1a72fcca58-78af3ffb4demr7059773b3a.10.1759409732860;
        Thu, 02 Oct 2025 05:55:32 -0700 (PDT)
Received: from fedora ([2405:201:3017:a80:9e5c:2c74:b73f:890a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01f9a2b9sm2165556b3a.19.2025.10.02.05.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 05:55:32 -0700 (PDT)
From: Bhavik Sachdev <b.sachdev1904@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksa Sarai <cyphar@cyphar.com>,
	Bhavik Sachdev <b.sachdev1904@gmail.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Jan Kara <jack@suse.cz>,
	John Garry <john.g.garry@oracle.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Andrei Vagin <avagin@gmail.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: [PATCH 1/4] fs/namespace: add umount_mnt_ns mount namespace for unmounted mounts
Date: Thu,  2 Oct 2025 18:18:37 +0530
Message-ID: <20251002125422.203598-2-b.sachdev1904@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002125422.203598-1-b.sachdev1904@gmail.com>
References: <20251002125422.203598-1-b.sachdev1904@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

We would like the ability to get mount info for mounts that have been
"unmounted" but still have open fds (umount2(mnt, MNT_DETACH)).

This patch introduces a new umount_mnt_ns to which these "unmounted"
mounts will be moved to instead of their mount namespaces being NULL.
We add this umount_mnt_ns to init_userns so all "umounted" mounts are
accessible via root userns only.

Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
---
 fs/namespace.c            | 14 ++++++++++++++
 include/linux/proc_ns.h   |  1 +
 include/uapi/linux/nsfs.h |  1 +
 3 files changed, 16 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index ae6d1312b184..70fe01d810df 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -107,6 +107,9 @@ struct mount_kattr {
 struct kobject *fs_kobj __ro_after_init;
 EXPORT_SYMBOL_GPL(fs_kobj);
 
+struct mnt_namespace *umount_mnt_ns __ro_after_init;
+EXPORT_SYMBOL_GPL(umount_mnt_ns);
+
 /*
  * vfsmount lock may be taken for read to prevent changes to the
  * vfsmount hash, ie. during mountpoint lookups or walking back
@@ -6121,6 +6124,17 @@ static void __init init_mount_tree(void)
 	set_fs_root(current->fs, &root);
 
 	mnt_ns_tree_add(ns);
+
+	umount_mnt_ns = alloc_mnt_ns(&init_user_ns, true);
+	if (IS_ERR(umount_mnt_ns)) {
+		free_mnt_ns(ns);
+		panic("Can't allocate initial umount namespace");
+	}
+	umount_mnt_ns->seq = atomic64_inc_return(&mnt_ns_seq);
+	umount_mnt_ns->seq_origin = ns->seq;
+	umount_mnt_ns->ns.inum = PROC_UMNT_INIT_INO;
+
+	mnt_ns_tree_add(umount_mnt_ns);
 }
 
 void __init mnt_init(void)
diff --git a/include/linux/proc_ns.h b/include/linux/proc_ns.h
index 4b20375f3783..c1e8edba862d 100644
--- a/include/linux/proc_ns.h
+++ b/include/linux/proc_ns.h
@@ -48,6 +48,7 @@ enum {
 	PROC_TIME_INIT_INO	= TIME_NS_INIT_INO,
 	PROC_NET_INIT_INO	= NET_NS_INIT_INO,
 	PROC_MNT_INIT_INO	= MNT_NS_INIT_INO,
+	PROC_UMNT_INIT_INO	= UMNT_NS_INIT_INO,
 };
 
 #ifdef CONFIG_PROC_FS
diff --git a/include/uapi/linux/nsfs.h b/include/uapi/linux/nsfs.h
index 97d8d80d139f..8bb0df8954bb 100644
--- a/include/uapi/linux/nsfs.h
+++ b/include/uapi/linux/nsfs.h
@@ -51,6 +51,7 @@ enum init_ns_ino {
 	TIME_NS_INIT_INO	= 0xEFFFFFFAU,
 	NET_NS_INIT_INO		= 0xEFFFFFF9U,
 	MNT_NS_INIT_INO		= 0xEFFFFFF8U,
+	UMNT_NS_INIT_INO	= 0xEFFFFFF7U,
 };
 
 #endif /* __LINUX_NSFS_H */
-- 
2.51.0


