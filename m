Return-Path: <linux-fsdevel+bounces-24270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 884B293C842
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 20:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B21EB21C12
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 18:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1E03CF5E;
	Thu, 25 Jul 2024 18:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="yvZQyzd1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DA52C6AF
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 18:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721931611; cv=none; b=IH/xym6IHmaxmWBvinn8Tf35wLLpPrfjGnGjGoD0mgPxmmB7eLpRJLkryqHxeOPT+f2bXBaXq9cE1qWon2y9380MEEdv+jN746bfGmdwd5pm2/lftkpT620WmNq+gXr4cfWdsvqGhWOlLwRlqmeNK9HQ33sxrnWQaOI1X+gI5nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721931611; c=relaxed/simple;
	bh=2q12dkxaS6jdsO0ZX8aKRcWpRxg++ZfB49vQCSIBovo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QC0yB38wC62GS15B1ydS6amGIuQ9r7gZBRcTd/B+Y4X/eGuMmO47OlnyTxDstPGAhXqOwI686+0H3EBr8XvAzTpz5VQ2QXYwTm+6m4K/0EbG+ULjgwl49LqX0mGZKkIWX7sQoLmZmPVH5Zoi9ktyk5U/tfviH6S1cjQC7pBtt5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=yvZQyzd1; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b7aed340daso8335576d6.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 11:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1721931608; x=1722536408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sFrDVuPu4/h/LKzVqtml7n9Q6NeN61sPKHdlckX8IzY=;
        b=yvZQyzd1g/TiGylLSRxrHzjUxGObNXpi9DMyh2EK79ao6gHexzqjPE1+XN2Tu/AIT4
         UtTViCjuTfcelm+Jm3VM+1whAgIXlv3SqlrnCgjCQg5+iT2ItXn6x74bf1KejbRzVt+n
         tNgTS57rxAZiuM6w+jpya1lCL3tFhVjj+yAOY7vYw+vicUIzDPLvYnuXlG6HHl2P/JHg
         xiXWj1bG9U5SdubiMHPrR7uGJUd3YdqUnt6rKSRcXFfgQrrv02ZW10vdsxtPolcIZOLh
         8+cYER1iX59rJBZdRuc0vgYQvTnw565UCCQ+THJEtqMx335T6lFi8uaNsgdxFQKN4FCg
         FxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721931608; x=1722536408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFrDVuPu4/h/LKzVqtml7n9Q6NeN61sPKHdlckX8IzY=;
        b=i3FJzTRPJf/JZ6t9JG4Q6RuKrUunH/MVwe1w79dJXFrpgVUp5N9xb2snySvjiV0FiD
         ZtJybBAKSN7BD48A+g8DalhrfpmTikgkSf7qY3sv6bEDSuF0PGqjFHYzXZSg0PXIKn2J
         tCTCrwWP42mIG6DwRWuZeju9i4AlwULh6m7IjA4H/h7TfyoyVuJwZD65298zA8uIzcne
         nXc5FgXm7RI8zZBWq1olqEIIWRriFJT30hyFmz9uAWsgN1wiF8xY1fWLv9rUXfgyaTfU
         VtpakebEy5vke8RfHsMb5gp3MCY4stQChNS5EpGQTXujg4LUXwB8jpJnWd3OhDEABysz
         /55Q==
X-Forwarded-Encrypted: i=1; AJvYcCVLk5868jBgNXm7lqyiQorw0/MYKsyNd4eF/tejQA4WTuMF74PhH+dx45igA8F2daElunqe+aw1ox8Ujc6oCCJeG6qCyzk+ZLmCnfP1xg==
X-Gm-Message-State: AOJu0YwPt3QCiGkkVdVRFkuS+46+AoS56oUyB6EPry0Ujv2STPWXNvPp
	c5aC16RRlVbJWfEOMP4tQQukVxfPK6Zb6sj9KTgDABHidCrF+O9AcOLZiTe4LRo=
X-Google-Smtp-Source: AGHT+IGVxHU1enxjhA8FWGninJI7PsY9Ay6HOvxLlJOAphJxhxy2M1Mx7BA32agODRR58D5p4qyK2Q==
X-Received: by 2002:a05:6214:627:b0:6b8:6f42:69dc with SMTP id 6a1803df08f44-6bb3cabe9ffmr48073076d6.39.1721931608422;
        Thu, 25 Jul 2024 11:20:08 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f8f9e11sm9519376d6.48.2024.07.25.11.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 11:20:08 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org
Subject: [PATCH 03/10] fsnotify: generate pre-content permission event on open
Date: Thu, 25 Jul 2024 14:19:40 -0400
Message-ID: <c105b804f1f6e14d7536b98fea428211b131473a.1721931241.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1721931241.git.josef@toxicpanda.com>
References: <cover.1721931241.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amir Goldstein <amir73il@gmail.com>

FS_PRE_ACCESS or FS_PRE_MODIFY will be generated on open depending on
file open mode.  The pre-content event will be generated in addition to
FS_OPEN_PERM, but without sb_writers held and after file was truncated
in case file was opened with O_CREAT and/or O_TRUNC.

The event will have a range info of (0..0) to provide an opportunity
to fill entire file content on open.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/namei.c               |  9 +++++++++
 include/linux/fsnotify.h | 10 +++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 3a4c40e12f78..c16487e3742d 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3735,6 +3735,15 @@ static int do_open(struct nameidata *nd,
 	}
 	if (do_truncate)
 		mnt_drop_write(nd->path.mnt);
+
+	/*
+	 * This permission hook is different than fsnotify_open_perm() hook.
+	 * This is a pre-content hook that is called without sb_writers held
+	 * and after the file was truncated.
+	 */
+	if (!error)
+		error = fsnotify_file_perm(file, MAY_OPEN);
+
 	return error;
 }
 
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 028ce807805a..4103dd797477 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -168,6 +168,10 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 		fsnotify_mask = FS_PRE_MODIFY;
 	else if (perm_mask & MAY_READ)
 		fsnotify_mask = FS_PRE_ACCESS;
+	else if (perm_mask & MAY_OPEN && file->f_mode & FMODE_WRITER)
+		fsnotify_mask = FS_PRE_MODIFY;
+	else if (perm_mask & MAY_OPEN)
+		fsnotify_mask = FS_PRE_ACCESS;
 	else
 		return 0;
 
@@ -176,10 +180,14 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 
 /*
  * fsnotify_file_perm - permission hook before file access
+ *
+ * Called from read()/write() with perm_mas MAY_READ/MAY_WRITE.
+ * Called from open() with MAY_OPEN in addition to fsnotify_open_perm(),
+ * but without sb_writers held and after the file was truncated.
  */
 static inline int fsnotify_file_perm(struct file *file, int perm_mask)
 {
-	return fsnotify_file_area_perm(file, perm_mask, NULL, 0);
+	return fsnotify_file_area_perm(file, perm_mask, &file->f_pos, 0);
 }
 
 /*
-- 
2.43.0


