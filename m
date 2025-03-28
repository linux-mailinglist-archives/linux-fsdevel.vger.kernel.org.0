Return-Path: <linux-fsdevel+bounces-45229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D28ABA74E6D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 17:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33068179693
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 16:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0251DF75D;
	Fri, 28 Mar 2025 16:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7HYaGI+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DCF1DA0E0;
	Fri, 28 Mar 2025 16:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743178597; cv=none; b=vGBZyNrHXdWxYU+6e2BPyYwQkSUmk0gMDLgd3Ts2wjrGNhR116vMU4l3yCYYlJusi4jrbcZ55rRfE05If9gYuG6ylaFPMeAn+TguHVqzKlIgtASloefJFHTmd+wsWZrRVReusD5fkPwIBqONpmw86YXNPPBrzV/NeGyqubqlJsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743178597; c=relaxed/simple;
	bh=rrucComhoMdFCmQO9zULVjvMKM4iND2xUOIRG11wNps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IRogo7EBwMhX2aJkAJOxSCOJDc/b3MxPYRVySfk2TVcnYSVMpBqaRcpSDkokpU2WCIEQ40tgRqgtDFIUaxkw3PzN6Uc9pI5shyz51z8FNhl93PECiEGiLdVz+fEu7coaOIoauA2HELq2eGeM9itdAwGFaQDpIezRCuOZ6k7kifE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7HYaGI+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E652C4CEE4;
	Fri, 28 Mar 2025 16:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743178596;
	bh=rrucComhoMdFCmQO9zULVjvMKM4iND2xUOIRG11wNps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M7HYaGI+EZny1Q4Wvsa91j9R3yjaXCN3KmVU9tkWSqqx42iyT/9quteNIy1s4SMR5
	 ZxET7rFYR005gZ8KK0NKf1BBVIzLetz4v/cr3+S6PiuhJPrgHGdxEImkXR8J/EfkLg
	 cgjlm6HOvG3hWadDaJW53ol+XaeLQg+0pn34+syyLLncjEqnkBFWs4OiaEx28RxwmA
	 Xr39BXAQ159j4A9lR7RQDKaS74cbsvQSMCTJ2y2HIuJCW30NpG2wz4FnhEiRz8BkVI
	 bHRANuxkcJqogypr0XjKsfZmpCV2OlnbXtE+jpjfGPC1VLyJKdvHKlz7awfvuRbDgk
	 FJQc2lAlF12GA==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	jack@suse.cz
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	mcgrof@kernel.org,
	hch@infradead.org,
	david@fromorbit.com,
	rafael@kernel.org,
	djwong@kernel.org,
	pavel@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	boqun.feng@gmail.com
Subject: [PATCH 6/6] super: add filesystem freezing helpers for suspend and hibernate
Date: Fri, 28 Mar 2025 17:15:58 +0100
Message-ID: <20250328-work-freeze-v1-6-a2c3a6b0e7a6@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250328-work-freeze-v1-0-a2c3a6b0e7a6@kernel.org>
References: <20250328-work-freeze-v1-0-a2c3a6b0e7a6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=2088; i=brauner@kernel.org; h=from:subject:message-id; bh=rrucComhoMdFCmQO9zULVjvMKM4iND2xUOIRG11wNps=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ/O+2sKXxPo8Xp0rmT8k5vC1zve4tNeS1VIHPsn5ySo dLlVY9edpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExksRfDf2e+WXmVy/7OvDAx JvP9opCQpgXzUvx1/xhlJO2Wv/O6bhIjwwwOc/mn8RejlcqL7rJFWFm2ZJbG8Alq1bl6vFKasS6 BBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Allow the power subsystem to support filesystem freeze for
suspend and hibernate.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/super.c         | 34 ++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  2 ++
 2 files changed, 36 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index 58c95210e66c..a2942b21d661 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1197,6 +1197,40 @@ void emergency_thaw_all(void)
 	}
 }
 
+static void filesystems_freeze_callback(struct super_block *sb, void *flagsp)
+{
+	if (!sb->s_op->freeze_fs && !sb->s_op->freeze_super)
+		return;
+
+	if (sb->s_op->freeze_super)
+		sb->s_op->freeze_super(sb, FREEZE_MAY_NEST | FREEZE_HOLDER_KERNEL);
+	else
+		freeze_super(sb, FREEZE_MAY_NEST | FREEZE_HOLDER_KERNEL);
+}
+
+void filesystems_freeze(bool hibernate)
+{
+	__iterate_supers(filesystems_freeze_callback, NULL,
+			 SUPER_ITER_GRAB | SUPER_ITER_REVERSE);
+}
+
+static void filesystems_thaw_callback(struct super_block *sb, void *flagsp)
+{
+	if (!sb->s_op->freeze_fs && !sb->s_op->freeze_super)
+		return;
+
+	if (sb->s_op->thaw_super)
+		sb->s_op->thaw_super(sb, FREEZE_HOLDER_KERNEL);
+	else
+		thaw_super(sb, FREEZE_HOLDER_KERNEL);
+}
+
+void filesystems_thaw(bool hibernate)
+{
+	__iterate_supers(filesystems_thaw_callback, NULL,
+			 SUPER_ITER_GRAB | SUPER_ITER_REVERSE);
+}
+
 static DEFINE_IDA(unnamed_dev_ida);
 
 /**
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c475fa874055..29bd28491eff 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3518,6 +3518,8 @@ extern void drop_super_exclusive(struct super_block *sb);
 extern void iterate_supers(void (*f)(struct super_block *, void *), void *arg);
 extern void iterate_supers_type(struct file_system_type *,
 			        void (*)(struct super_block *, void *), void *);
+void filesystems_freeze(bool hibernate);
+void filesystems_thaw(bool hibernate);
 
 extern int dcache_dir_open(struct inode *, struct file *);
 extern int dcache_dir_close(struct inode *, struct file *);

-- 
2.47.2


