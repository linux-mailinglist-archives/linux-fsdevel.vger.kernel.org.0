Return-Path: <linux-fsdevel+bounces-5151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D305808AB6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 15:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F9A61C20999
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 14:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4854437C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 14:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AeCxmXEo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1EC11F
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Dec 2023 04:38:37 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3316d3d11e1so526278f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Dec 2023 04:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701952716; x=1702557516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UbZB0CaH91bRuP24YpEqRFbdPVMxUfK74+WxyAJmrLc=;
        b=AeCxmXEoWfymT+nlcLQdsAS8pyYJwdcga+zse2i8Z1tPVtEJJi0JMk5IBnWqp07mU+
         Ym7B/u0sD22lC51h3KGbIJUvubI3MR+8bRqoWEJJbGa+4TdQUq8WlbA5DHylvx9eMtMB
         SDqIyqTgEBvELd+0DHNUcuC1KwIeIQcsUDKXzbpRiG51IzC6CDBDv/Wgq6LHXjwPgSUb
         kckvOY7WdzLxBZvVCwWC1kSp2tLOcTx/ZowfJmmleU0EMRNkdeW3KeWCB7UH/v33NBgb
         inlucDGicf1eanv6MgNgqzSmT6jo4azGEw6S0fpGWFs8/HdrfhDhvEaZIlH8poTM3yV1
         yluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701952716; x=1702557516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UbZB0CaH91bRuP24YpEqRFbdPVMxUfK74+WxyAJmrLc=;
        b=HESU2AtA4AIEDP20gOfQZuyx20JtCQ486VmktT8S6+zUU8R4sXwn062+TnPaIAeirz
         07wkmFikgWgkEuxQFS54QGr97pmwQwt9O6eYE3hFOhK+elAqfgqY0pX5xxRFmug1mJjs
         FoL+pfipn+I7rrM5zvxCtXhqNfAiCxa9oN24VEEhshYGFZBv1RbM6wzrPf3NFLmqmFdx
         2oEGlCPjoqUXANytaHgrsweZs29woWx4CurvmSQwtEsnp1r/CrfTLp0Q3KezgHKGwiQM
         +lFzEARchaDn8IKl8Tae1lD9MD1m4S6AyxuEyHEK1Y/V/W02+IVLPL22E9RDTuIxbgH0
         bZBA==
X-Gm-Message-State: AOJu0Yx6CJI5+pNol9xE/WkjpIhhccSeDFPWr06Uz/4Ke4Dj5eL7/bzo
	FhYA56oudC68qxQP2e9uTKE=
X-Google-Smtp-Source: AGHT+IHAIaA0fb1AzIYgK5DT484BcQ6jp4mmRHpMyIXBdkYjt806RenC9+C9Oqaf/pMcwlXJV0pR3Q==
X-Received: by 2002:adf:e80e:0:b0:333:870:bbc2 with SMTP id o14-20020adfe80e000000b003330870bbc2mr1642327wrm.9.1701952715835;
        Thu, 07 Dec 2023 04:38:35 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id z17-20020a5d4c91000000b003333abf3edfsm1332431wrs.47.2023.12.07.04.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 04:38:35 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>,
	David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/4] fsnotify: split fsnotify_perm() into two hooks
Date: Thu,  7 Dec 2023 14:38:23 +0200
Message-Id: <20231207123825.4011620-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207123825.4011620-1-amir73il@gmail.com>
References: <20231207123825.4011620-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We would like to make changes to the fsnotify access permission hook -
add file range arguments and add the pre modify event.

In preparation for these changes, split the fsnotify_perm() hook into
fsnotify_open_perm() and fsnotify_file_perm().

This is needed for fanotify "pre content" events.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 include/linux/fsnotify.h | 34 +++++++++++++++++++---------------
 security/security.c      |  4 ++--
 2 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index bcb6609b54b3..926bb4461b9e 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -100,29 +100,33 @@ static inline int fsnotify_file(struct file *file, __u32 mask)
 	return fsnotify_parent(path->dentry, mask, path, FSNOTIFY_EVENT_PATH);
 }
 
-/* Simple call site for access decisions */
-static inline int fsnotify_perm(struct file *file, int mask)
+/*
+ * fsnotify_file_perm - permission hook before file access
+ */
+static inline int fsnotify_file_perm(struct file *file, int perm_mask)
 {
-	int ret;
-	__u32 fsnotify_mask = 0;
+	__u32 fsnotify_mask = FS_ACCESS_PERM;
 
-	if (!(mask & (MAY_READ | MAY_OPEN)))
+	if (!(perm_mask & MAY_READ))
 		return 0;
 
-	if (mask & MAY_OPEN) {
-		fsnotify_mask = FS_OPEN_PERM;
+	return fsnotify_file(file, fsnotify_mask);
+}
 
-		if (file->f_flags & __FMODE_EXEC) {
-			ret = fsnotify_file(file, FS_OPEN_EXEC_PERM);
+/*
+ * fsnotify_open_perm - permission hook before file open
+ */
+static inline int fsnotify_open_perm(struct file *file)
+{
+	int ret;
 
-			if (ret)
-				return ret;
-		}
-	} else if (mask & MAY_READ) {
-		fsnotify_mask = FS_ACCESS_PERM;
+	if (file->f_flags & __FMODE_EXEC) {
+		ret = fsnotify_file(file, FS_OPEN_EXEC_PERM);
+		if (ret)
+			return ret;
 	}
 
-	return fsnotify_file(file, fsnotify_mask);
+	return fsnotify_file(file, FS_OPEN_PERM);
 }
 
 /*
diff --git a/security/security.c b/security/security.c
index dcb3e7014f9b..d7f3703c5905 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2586,7 +2586,7 @@ int security_file_permission(struct file *file, int mask)
 	if (ret)
 		return ret;
 
-	return fsnotify_perm(file, mask);
+	return fsnotify_file_perm(file, mask);
 }
 
 /**
@@ -2837,7 +2837,7 @@ int security_file_open(struct file *file)
 	if (ret)
 		return ret;
 
-	return fsnotify_perm(file, MAY_OPEN);
+	return fsnotify_open_perm(file);
 }
 
 /**
-- 
2.34.1


