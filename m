Return-Path: <linux-fsdevel+bounces-25429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9CB94C20F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 17:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C84CD1F2842E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 15:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BA818FC8C;
	Thu,  8 Aug 2024 15:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjMwUih1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464E7183CCB;
	Thu,  8 Aug 2024 15:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723132488; cv=none; b=HFxxgsD9BH6+eqzb7/eHZ/G4/xs3fwICEaYAaQQyXdyc/KSDA44dkvLZFSvgVLQR3SCL3StUamoyOiZT8aI+pmDHvu40mkKkVN3U3qA2ennvh5D4A+9oOIqzIvaSxQmsWjiXcLrI/ieE8VjRtFMbBLeeTzwj8i14O0aoWg8geLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723132488; c=relaxed/simple;
	bh=g2iwU3kTZWYexXO7EP+tPVGA5m/ulc15bcFrrIeT+2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VpTqYfnSvHbdwmZHnmUdCTebzbl1EfZ3ilyevWEBBzRwW3syAPinAgxB7d0O/osGkxU5SwKY63BAQC68rJcXbLRChbMV9uWM+pguUOwe/kr/sd0L5vFYc+Oe0ptErwborXi5arjeHCH5DPoR5IzECh6dgwF+290uq/k8JoeTjOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjMwUih1; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5a20de39cfbso1225995a12.1;
        Thu, 08 Aug 2024 08:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723132486; x=1723737286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mQ0G3gIYv0zW5ywze1/rQd1nVJRudLESup0uQOy1PM4=;
        b=fjMwUih19cRjvvz8bxpNcj7YnLhI+SsztZKSqb7aQY9c0n6k4DJL2Tv9cJSH5b8aij
         Hhg0r3i66TFB1gaVUxRZVCOS0L2dwsq2qBUVv9kCeGCIGUxJOZ+H83i/erMisn0frMsU
         IBf6vcmpI9w7ujeZh48cEOC6BXjM4RASlPDIwKsseOIxYjWl2G0YeQ5Lw9cifJ56kZxl
         HPdpCDVLEQo1b1C+Lb+zHh9PcZqqv0YRazEd/qXgNTSh8Bxic7tLex168RCDN7+iCXj1
         IVsTq9wmXzCz16oWie4zrRpwd4oNG1N2xRoZUiH0FxDRQXEkV8me0O1zbEXIPkh1DbEc
         ghHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723132486; x=1723737286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mQ0G3gIYv0zW5ywze1/rQd1nVJRudLESup0uQOy1PM4=;
        b=NuHxC9Ak4SEhTVV8SoZdnc643gJMLyjLsJLhToPjYdUdNISppbpovmsCVE7zSuKSaj
         pNQaFe+vmFf5Vzj+BxMmx0SGGAF/io1wjLgjSjgjyhnbvvVEWQXKRZ3qIFstyb3TrRfz
         Vm1G3EYBZj/jUm4fC5dJK5XHsUdRsfhDAorFkN8GTcVDeBaQ+6YohBhVUqhekNwyGnZv
         y+B++ThiMZ/ZadksZHSDEAI4kmqcUr9H9xCprbSXLtELsAS/ts+Rtx00QfBltYevLaCn
         yN9ntNTirjs+oFTb3xZkx+UWZH0kfZKNee0JtI0p/GIKFvDLUWy3jZ25XkipzBBBBfiq
         ohzA==
X-Forwarded-Encrypted: i=1; AJvYcCV+5bwrpadKC2eyV1Fb28IGQCKMXVeMBPnpj9C6NwODLRCuGY21C6iRwHL7TMWsr9a7Gx+jb2dVcCGfi3ckiuRUnQ3PHx9tD2/fnDNqObXGB4tRjjMD31cDy57/bJdUjQGdkqUax34VSeVaVg==
X-Gm-Message-State: AOJu0Ywr93n20H8bCZzvRaNkevSKxIqgB4uV6QTR6D/A4RAqYVQ2Ecge
	r4IBeGmF8mb7uB8qDUIS4vVIeBJ4pzCTqIdeEmIrzBkPd8V1mxlQ
X-Google-Smtp-Source: AGHT+IFiFsQmRCqKqrSpUCyJTAg+hoj7Nf9Zlunp7PnwX/h7AT7D2qpyBrWyLBDzqhhS0nNVq+/JTg==
X-Received: by 2002:a05:6402:50d2:b0:5a2:694e:5faa with SMTP id 4fb4d7f45d1cf-5bbb21f42ddmr1885843a12.8.1723132485167;
        Thu, 08 Aug 2024 08:54:45 -0700 (PDT)
Received: from f.. (cst-prg-72-52.cust.vodafone.cz. [46.135.72.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2d34a7fsm744335a12.74.2024.08.08.08.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 08:54:44 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] vfs: only read fops once in fops_get/put
Date: Thu,  8 Aug 2024 17:54:28 +0200
Message-ID: <20240808155429.1080545-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The compiler emits 2 access in fops_get(), put is patched to maintain some
consistency.

This makes do_dentry_open() go down from 1177 to 1154 bytes.

This popped up due to false-sharing where loads from inode->i_fop end up
bouncing a cacheline on parallel open. While this is going to be fixed,
the spurious load does not need to be there.

No functional changes.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/fs.h | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index ef5ada9d5e33..87d191798454 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2565,10 +2565,17 @@ struct super_block *sget(struct file_system_type *type,
 struct super_block *sget_dev(struct fs_context *fc, dev_t dev);
 
 /* Alas, no aliases. Too much hassle with bringing module.h everywhere */
-#define fops_get(fops) \
-	(((fops) && try_module_get((fops)->owner) ? (fops) : NULL))
-#define fops_put(fops) \
-	do { if (fops) module_put((fops)->owner); } while(0)
+#define fops_get(fops) ({						\
+	const struct file_operations *_fops = (fops);			\
+	(((_fops) && try_module_get((_fops)->owner) ? (_fops) : NULL));	\
+})
+
+#define fops_put(fops) ({						\
+	const struct file_operations *_fops = (fops);			\
+	if (_fops)							\
+		module_put((_fops)->owner);				\
+})
+
 /*
  * This one is to be used *ONLY* from ->open() instances.
  * fops must be non-NULL, pinned down *and* module dependencies
-- 
2.43.0


