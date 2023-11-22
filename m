Return-Path: <linux-fsdevel+bounces-3416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E78D07F4631
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 13:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1471280D31
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 12:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05C85A119;
	Wed, 22 Nov 2023 12:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbQ3AgFe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8B41AC
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 04:27:41 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4083f61322fso34004955e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 04:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700656060; x=1701260860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/NtyG2csDvfekP/QlGFua/QNT8LSYgZ+R+0ttn+W20=;
        b=GbQ3AgFeLGa2zcx7QX2A1Lx/Ztd405naYIfnlEwnOz8WhpW6Ea0d/8dWFA56M0tYIY
         XCMCQva3eMB4jT8QdfeKL6nCkhsdT5sEe06HrFCn+SkxFMUOHHqqVgduIgDHNTK6m53+
         I7B2AXo87VmHoQiX6jlZzny0ceA1kH8fsvH9nblaIeDkCUnl+GNhZN+MMsGJcJYxBFA6
         A1WSa6YNiQM9YQ1J6J/f7HG64mu8V9oMEOzdqUPnsclz1ygvVOVJmH1ZQAEJVnc3VB6z
         XJ/Jt3+31l6as8BQN9xxRA+kNDYlSorbnOtCdFPjzpG2uJyxqjevfOEgjx9pqXHrdq3t
         U2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700656060; x=1701260860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/NtyG2csDvfekP/QlGFua/QNT8LSYgZ+R+0ttn+W20=;
        b=Zx51XNlfKtlRvgYqIsPJsmsW0sKVxkwC1JtLQHtloBJcMTOQ1LemG5Eosb3h+XMlkC
         kYqrPkRnQpaDZJsmY9XRPJdll3BKrmr5MvzjTrNNQvVxPtx4JlWAXmkA+BI1iDeEnyGE
         YfKpj9GPc6P3QtPLyU7iPdw4bDz1sldr8rNzaG9P3NB0Q1NUHWhAuHw1r+Oss6epMY5q
         P6mufAtwWoyqOmiJu9dW1uYtI/cN0A6MO2b0IwGXrBW+mHFdXeilxJ8sxSm1gNFi7vj5
         3/+uw/Xr652gNC+RGP4DiyuyxyeA2FLHgV9j+b747mgMQk8Sy/ERwwkDJniGxK8Djiu9
         ewug==
X-Gm-Message-State: AOJu0YyHqvzP5OiCAwiIoVKdO0PE+m6ZLqF/10CCRC9uARChDYnm4Kuy
	sUyhwXuairNmRNVR966zjqs=
X-Google-Smtp-Source: AGHT+IFwTgaeYuDnvTKeFAITYvlJKsz5NMgCcgLwaja4X5I+NiZORddiUpb53XfLWEpgMVLvKxB5Mg==
X-Received: by 2002:a05:600c:1c9d:b0:406:f832:6513 with SMTP id k29-20020a05600c1c9d00b00406f8326513mr1723448wms.3.1700656060036;
        Wed, 22 Nov 2023 04:27:40 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c154e00b0040588d85b3asm2055556wmg.15.2023.11.22.04.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 04:27:39 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 14/16] fs: create __sb_write_started() helper
Date: Wed, 22 Nov 2023 14:27:13 +0200
Message-Id: <20231122122715.2561213-15-amir73il@gmail.com>
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

Similar to sb_write_started() for use by other sb freeze levels.

Unlike the boolean sb_write_started(), this helper returns a tristate
to distiguish the cases of lockdep disabled or unknown lock state.

This is needed for fanotify "pre content" events.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 include/linux/fs.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98b7a7a8c42e..e8aa48797bf4 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1645,9 +1645,22 @@ static inline bool __sb_start_write_trylock(struct super_block *sb, int level)
 #define __sb_writers_release(sb, lev)	\
 	percpu_rwsem_release(&(sb)->s_writers.rw_sem[(lev)-1], 1, _THIS_IP_)
 
+/**
+ * __sb_write_started - check if sb freeze level is held
+ * @sb: the super we write to
+ *
+ * > 0 sb freeze level is held
+ *   0 sb freeze level is not held
+ * < 0 !CONFIG_LOCKDEP/LOCK_STATE_UNKNOWN
+ */
+static inline int __sb_write_started(const struct super_block *sb, int level)
+{
+	return lockdep_is_held_type(sb->s_writers.rw_sem + level - 1, 1);
+}
+
 static inline bool sb_write_started(const struct super_block *sb)
 {
-	return lockdep_is_held_type(sb->s_writers.rw_sem + SB_FREEZE_WRITE - 1, 1);
+	return __sb_write_started(sb, SB_FREEZE_WRITE);
 }
 
 /**
-- 
2.34.1


