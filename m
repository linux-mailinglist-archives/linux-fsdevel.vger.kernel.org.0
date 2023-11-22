Return-Path: <linux-fsdevel+bounces-3414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1A37F462D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 13:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FC97B2130C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 12:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECF356457;
	Wed, 22 Nov 2023 12:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jldAFJsn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD81D76
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 04:27:44 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40b2a8c7ca9so13396835e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 04:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700656062; x=1701260862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ft2LGKKVGThLTaqBJZNAonNUXY157MwkC9X0m9a0ncA=;
        b=jldAFJsn8eoEVoErqCmGssT5aBXSH41E5JOhtE6T1ZQnO1HsofE8gSeZxssPXsFlBJ
         PeG6SbATcnP68GN7VU7LYxBYiIvTtQlubUf1Y/ZJFVsOF3vD67no8qES0o91IoXHgAgh
         5Ni7TmRD8mZvAfyDFCjeZazKBjx62TJm0wcNqky9WpdtRgMeuyPcj72vvCjFcczvjWlC
         x/I7RGh09DEE8O/3jbUd6ZGumlOrmSHzb4DuN3InVQ2rWRrtGQpSw8aTdhkj3VP2svmF
         /MEjF1SVAf3p+pveKkuZDVm7ogPh5an/w6t8Rbcfhj31LJyhblSmGymBWWdTmLpE6YwE
         yt5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700656062; x=1701260862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ft2LGKKVGThLTaqBJZNAonNUXY157MwkC9X0m9a0ncA=;
        b=lEecP1Vc5YcAxezaD6iP7hoo+DL8sMlaQ57e9Kihwp5/0ymU0bhzbwzvPQLx1jncqK
         AMgezhoUjvab79JHMHYqmjeRQxKfRfdAwFZ6GQE6/HPUh58uUy201LlSvR4yPQDj/rYJ
         Dw1L/QmwGgYCGbl4i7urfULREQu4qB/6WhSdiFNSXTnmSApFYwXfDoWDpnzjyGNRDhDX
         nGZI2k6iVWEDukKFRQwIrA1+Bp7JJWO94AQuT0OElNkb6EoYHwX8Gzan8BbHYkhjldKM
         yskKFxyTcYWAvTHoNAlvRtyqjvJaY6BqmIsjV2upb49GBFjsQyBrCims641IfB6cSDR+
         xaDQ==
X-Gm-Message-State: AOJu0Yy5I+fgh60iJ5vNroqt51sH0qpzSoWaokuGs7bTz3BAoWfyswz4
	UCICKKzjZ+E3ur8Efd6rspM=
X-Google-Smtp-Source: AGHT+IHr0fPUpguq8U+hzbMwuCMk7JhoZNGHBJLwgeyoWOmZWpvXJFuws7Rhni+qzXdEt9l3LbAqpQ==
X-Received: by 2002:a05:600c:3caa:b0:40b:2a18:f1be with SMTP id bg42-20020a05600c3caa00b0040b2a18f1bemr182868wmb.1.1700656062507;
        Wed, 22 Nov 2023 04:27:42 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c154e00b0040588d85b3asm2055556wmg.15.2023.11.22.04.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 04:27:42 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 16/16] fs: create {sb,file}_write_not_started() helpers
Date: Wed, 22 Nov 2023 14:27:15 +0200
Message-Id: <20231122122715.2561213-17-amir73il@gmail.com>
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

Create new helpers {sb,file}_write_not_started() that can be used
to assert that sb_start_write() is not held.

This is needed for fanotify "pre content" events.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 include/linux/fs.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 05780d993c7d..c085172f832f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1669,6 +1669,17 @@ static inline bool sb_write_started(const struct super_block *sb)
 	return __sb_write_started(sb, SB_FREEZE_WRITE);
 }
 
+/**
+ * sb_write_not_started - check if SB_FREEZE_WRITE is not held
+ * @sb: the super we write to
+ *
+ * May be false positive with !CONFIG_LOCKDEP/LOCK_STATE_UNKNOWN.
+ */
+static inline bool sb_write_not_started(const struct super_block *sb)
+{
+	return __sb_write_started(sb, SB_FREEZE_WRITE) <= 0;
+}
+
 /**
  * file_write_started - check if SB_FREEZE_WRITE is held
  * @file: the file we write to
@@ -1684,6 +1695,21 @@ static inline bool file_write_started(const struct file *file)
 	return sb_write_started(file_inode(file)->i_sb);
 }
 
+/**
+ * file_write_not_started - check if SB_FREEZE_WRITE is not held
+ * @file: the file we write to
+ *
+ * May be false positive with !CONFIG_LOCKDEP/LOCK_STATE_UNKNOWN.
+ * May be false positive with !S_ISREG, because file_start_write() has
+ * no effect on !S_ISREG.
+ */
+static inline bool file_write_not_started(const struct file *file)
+{
+	if (!S_ISREG(file_inode(file)->i_mode))
+		return true;
+	return sb_write_not_started(file_inode(file)->i_sb);
+}
+
 /**
  * sb_end_write - drop write access to a superblock
  * @sb: the super we wrote to
-- 
2.34.1


