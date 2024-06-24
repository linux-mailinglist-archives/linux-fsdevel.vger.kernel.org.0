Return-Path: <linux-fsdevel+bounces-22270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC184915752
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 21:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6781B280E9F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 19:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0161A072C;
	Mon, 24 Jun 2024 19:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Jy8cDez/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6761A01C8
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 19:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719258071; cv=none; b=Xw1mxN0b1pZyLWCz+Ki5NIL5kodtitE0fu/LwcNmT9FxwnexfIkf9i7kfzRqRBg58pfTHKiwTmZwn5IdtTO1hZDbIV1MmxF5P2OcG9/8BAP7yE8LkrZ4KYva3o4h5/Lky0zPjMyXqickx5mNrZGDou+gvM43J62oY4zQMfQmAoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719258071; c=relaxed/simple;
	bh=JY8desCnZGfGCcwAJYVAT/H3v4UHKfupLgaJk2Z97jI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NcxIXtzkfrVdMloSamt0Ud2JVjL4YBUfUDUeugeLcYE7yhzPGYWM5I5NdUObr5d1mc+ozin+gt98uGO8rmDmB7oxWzN72D2SJ/lKZ3tV9GbFPfrhMdxuqTj0p0mfG6IM5ojEHn9c3arK+WrZ/auhwntglbqJ1BZGee9sJIFQFdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Jy8cDez/; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-25d0d16e38eso839182fac.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 12:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719258068; x=1719862868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Mn4lrx/Zmh33vObbaTy4J8GMzf6Ir22NpWlaU7qZ+M=;
        b=Jy8cDez/JmrK+XYbmnsPYcNo8Qr3CNtwRDMyWAvuWZdxbg43vupElyGLhcPOjJwhQw
         ZGI9etkQDhDwhxbYNR4UI6Oul6OdpLnFpELi4pzXv9WEswU24qxnIaowjFjVWVNasmWX
         DqL/2N+8zU/CUvmJ7EOsTkDZ194xsjZEl/aeJkmWuKwl7zAVWLuUi2vsuNRkYaxRkESh
         EhwHZ/EPwgrM0bCoxzfCCnR3v2uMGWOx9amWDEzXLrjQmWj8oQGinoWNkNH9QwzjWdMd
         ohQQrEXuhQGW4Ylky2jz11wlgiVSdUpPC2o/JLD/TEq5lCsz5ZTkpdi9bIjl+OWRuCMp
         vnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719258068; x=1719862868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Mn4lrx/Zmh33vObbaTy4J8GMzf6Ir22NpWlaU7qZ+M=;
        b=ujtA360slqEy1mr7XfwqFXVDZQZAirecVCNKB1QC1SHCHFNQgeVNb5/78IcujyqoFr
         4oju8xrUnnyQrVd73wJ/T9tpcnlslD1XCQYtYBVjkSfS6k9s4qBj0fn0tDw7VBCP0twM
         3xJI3MKGoCizzKul9U2rDJkGYpm7BvaMS5P9KcY4HaB9Ss3kKGhmjg3Ubzsa+DtuUcfa
         yGqCsWMi3cBuGXuGbpJ0kmrD1FIv64go5kg+vldR4SNYTEG/34DLmSwBCrzbOsqUqJLs
         YtGQLyN7mgD+X1imYUOT92Hl8EEKNue7HdYffLSrG8P0/JCIaP3f9e5aUdFSr8H1Kc2v
         zarQ==
X-Gm-Message-State: AOJu0Yz2KiHN3QgszSqYvKhAGTCOTpQ+AUQDjP1ODA7qz2RJuKOps52G
	KIRdBrLo+Pgzb0Z47FUIyDm85/1i1LxcZNZ05qAPDZtWH0FQAlfJ1IVZB8myVTbOwnefI+4p1ES
	J
X-Google-Smtp-Source: AGHT+IFhHtqnr4BvIholprKhwsCe6LjGyXizQ9Be97t+HwWgmHx+kgx0cXBu/JEeJwQKiaVKS//1XQ==
X-Received: by 2002:a05:6870:e242:b0:254:783d:aeb4 with SMTP id 586e51a60fabf-25d06cad9a8mr5788510fac.35.1719258067909;
        Mon, 24 Jun 2024 12:41:07 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce931bf0sm341929085a.112.2024.06.24.12.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 12:41:07 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	kernel-team@fb.com
Subject: [PATCH 2/4] fs: add a helper to show all the options for a mount
Date: Mon, 24 Jun 2024 15:40:51 -0400
Message-ID: <ba65606c5f233c6d937dfa690325e95712a69a95.1719257716.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719257716.git.josef@toxicpanda.com>
References: <cover.1719257716.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to add the ability to export the mount options via statmount()
we need a helper to combine all the various mount option things we do
for /proc/mounts and /proc/$PID/mountinfo.  The helper for /proc/mounts
can use this helper, however mountinfo is slightly (and infuriatingly)
different, so it can only be used in one place.  This helper will be
used in a followup patch to export mount options via statmount().

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/internal.h       |  5 +++++
 fs/proc_namespace.c | 25 ++++++++++++++++++-------
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 84f371193f74..dc40c9d4173f 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -321,3 +321,8 @@ struct stashed_operations {
 int path_from_stashed(struct dentry **stashed, struct vfsmount *mnt, void *data,
 		      struct path *path);
 void stashed_dentry_prune(struct dentry *dentry);
+
+/*
+ * fs/proc_namespace.c
+ */
+int show_mount_opts(struct seq_file *seq, struct vfsmount *mnt);
diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index e133b507ddf3..19bffd9d80dc 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -84,6 +84,22 @@ static void show_vfsmnt_opts(struct seq_file *m, struct vfsmount *mnt)
 		seq_puts(m, ",idmapped");
 }
 
+int show_mount_opts(struct seq_file *seq, struct vfsmount *mnt)
+{
+	struct dentry *dentry = mnt->mnt_root;
+	struct super_block *sb = dentry->d_sb;
+	int ret;
+
+	seq_puts(seq, __mnt_is_readonly(mnt) ? "ro" : "rw");
+	ret = show_sb_opts(seq, sb);
+	if (ret)
+		return ret;
+	show_vfsmnt_opts(seq, mnt);
+	if (sb->s_op->show_options)
+		ret = sb->s_op->show_options(seq, dentry);
+	return ret;
+}
+
 static inline void mangle(struct seq_file *m, const char *s)
 {
 	seq_escape(m, s, " \t\n\\#");
@@ -120,13 +136,8 @@ static int show_vfsmnt(struct seq_file *m, struct vfsmount *mnt)
 		goto out;
 	seq_putc(m, ' ');
 	show_type(m, sb);
-	seq_puts(m, __mnt_is_readonly(mnt) ? " ro" : " rw");
-	err = show_sb_opts(m, sb);
-	if (err)
-		goto out;
-	show_vfsmnt_opts(m, mnt);
-	if (sb->s_op->show_options)
-		err = sb->s_op->show_options(m, mnt_path.dentry);
+	seq_putc(m, ' ');
+	err = show_mount_opts(m, mnt);
 	seq_puts(m, " 0 0\n");
 out:
 	return err;
-- 
2.43.0


