Return-Path: <linux-fsdevel+bounces-3417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8CB7F4635
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 13:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96CB6B21431
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 12:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E795B1EF;
	Wed, 22 Nov 2023 12:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQZs1iPl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA83BD4F
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 04:27:42 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40891d38e3fso30193455e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 04:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700656061; x=1701260861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFwbsIacRHUDU4cYIy1iRdVU0szb0nanBQz9AQM2gt0=;
        b=HQZs1iPllsF0L9jvqzRaC99Hv4UK2YPDxMd1ggF25DfiTDLeQH+kB+P2uOWjSFRJ0T
         yd0+gIfErysT2mMAxvT7J/NCZWTCXjj+UsjhT6XAchpXHi33TkDHzYJWflSf4CTAYwHk
         EYZvRlFF4Pwv6HNCkDp/DsN+o909Gm+oiKAKe3tr1QYPVu1aLZ1DqZ3PyVArFx72ulvA
         vPrErg3KrqrfETc2/k1ODzxYNc158ZBnb4GxCRu8hMDhTMdgWNRO18FVv3ZlpbVIDB8J
         mQxRaWkvk4vgt7zUUsYeLtFrEav3z9QCAAN5rNgKxBCQKxkKLs3mfehURUfd/auNDWWU
         MA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700656061; x=1701260861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rFwbsIacRHUDU4cYIy1iRdVU0szb0nanBQz9AQM2gt0=;
        b=IzQHhuueimaSWyi4XNOsMfQDMtV4dqkfs2axnJL0m/q8QTokx8wr3kdOU2+6Cfgu/x
         bGFxyCdYMFPy0XwjzF5GnWq68pQHSUjUb0QkSe2a3koXbcV3JMzPBSs9ufGW2tARRo4y
         V7hV6vJ2dT/GVJbeyeIpilYgFFgEfj9F/IZo0pj4UHYNAMBFlDyskBUO+d+U2iD3wX3M
         DI/r1mePd38KZ8F/epzIfzvR+jIyv+YgIJ2e9M0kdBfN3F1/SNddttwaIgqh6Qe6jl9Q
         M2u4VWPhdjmuwoSVv0FBzI5R75ewD6ubYJUUhy5I8Pg4CGmHxnU82QX0qYWn1K5gD9RK
         i9Zg==
X-Gm-Message-State: AOJu0YzSuRrw2IG+LF2SobPoBntMXc6VMhPB23c4Xl/OyuMGUdPl85aU
	bLxaLzuW16X3pbwcB/Qw9Y8=
X-Google-Smtp-Source: AGHT+IHZnber+Gts9EC1RabUkGRbKY6thcdyJ9UvRplQHGIg+DYlpzzfl4RAS6dZOGn/kw+DPyK//w==
X-Received: by 2002:a05:600c:3b8f:b0:3fa:934c:8356 with SMTP id n15-20020a05600c3b8f00b003fa934c8356mr1928098wms.10.1700656061250;
        Wed, 22 Nov 2023 04:27:41 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c154e00b0040588d85b3asm2055556wmg.15.2023.11.22.04.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 04:27:40 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 15/16] fs: create file_write_started() helper
Date: Wed, 22 Nov 2023 14:27:14 +0200
Message-Id: <20231122122715.2561213-16-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122122715.2561213-1-amir73il@gmail.com>
References: <20231122122715.2561213-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convenience wrapper for sb_write_started(file_inode(inode)->i_sb)), which
has a single occurrence in the code right now.

Document the false negatives of those helpers, which makes them unusable
to assert that sb_start_write() is not held.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/read_write.c    |  2 +-
 include/linux/fs.h | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index ed0ea1132cee..f9e0a5b1a817 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1450,7 +1450,7 @@ ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
 				struct file *file_out, loff_t pos_out,
 				size_t len, unsigned int flags)
 {
-	lockdep_assert(sb_write_started(file_inode(file_out)->i_sb));
+	lockdep_assert(file_write_started(file_out));
 
 	return do_splice_direct(file_in, &pos_in, file_out, &pos_out,
 				len > MAX_RW_COUNT ? MAX_RW_COUNT : len, 0);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e8aa48797bf4..05780d993c7d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1658,11 +1658,32 @@ static inline int __sb_write_started(const struct super_block *sb, int level)
 	return lockdep_is_held_type(sb->s_writers.rw_sem + level - 1, 1);
 }
 
+/**
+ * sb_write_started - check if SB_FREEZE_WRITE is held
+ * @sb: the super we write to
+ *
+ * May be false positive with !CONFIG_LOCKDEP/LOCK_STATE_UNKNOWN.
+ */
 static inline bool sb_write_started(const struct super_block *sb)
 {
 	return __sb_write_started(sb, SB_FREEZE_WRITE);
 }
 
+/**
+ * file_write_started - check if SB_FREEZE_WRITE is held
+ * @file: the file we write to
+ *
+ * May be false positive with !CONFIG_LOCKDEP/LOCK_STATE_UNKNOWN.
+ * May be false positive with !S_ISREG, because file_start_write() has
+ * no effect on !S_ISREG.
+ */
+static inline bool file_write_started(const struct file *file)
+{
+	if (!S_ISREG(file_inode(file)->i_mode))
+		return true;
+	return sb_write_started(file_inode(file)->i_sb);
+}
+
 /**
  * sb_end_write - drop write access to a superblock
  * @sb: the super we wrote to
-- 
2.34.1


