Return-Path: <linux-fsdevel+bounces-43540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1EFA583DC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Mar 2025 12:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED93918953DF
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Mar 2025 11:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14F91C8FD6;
	Sun,  9 Mar 2025 11:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGP6L54/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3F71ABED9
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Mar 2025 11:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741521138; cv=none; b=jfxhiOj26AIzHbBKhhcoeWvy8DRs4sKralWj9ub9Kj62s4wrHtaLnvRQ50iTMAminkn9oJI2G6Z//GWq52XDOF4UOqIGDkuaJCD7wMq2BWWpyymEH5JmG4rDlSd3t3GZYfeieeffVAi1t934qeVUv3ZWOyfT5ODFpswZbURM+74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741521138; c=relaxed/simple;
	bh=v1AiuT/CsHaF4DORU3umNKJnzuvwf6GbTcErvVyheKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VBYqpMmDtHb59mGkKDYZposklR4XUcy3jXApqEBsSTwwykrV2c1EIFt0oVi0xOMQeL/pAhxbS+msz7xLzkTHgKt0yVzIOhJ/5RPlh4FVGi5U2lgzNKq2bB8X7ZYNxfPwowP/iFsq4WI2cNiYixmiTwb5/sSpH9W/YErvpZ3dEWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WGP6L54/; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e614da8615so2234989a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Mar 2025 04:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741521135; x=1742125935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQxU3YbjwPi42MJWqznBxmkWXlGLCR5XrFXf/1ZtZ8Y=;
        b=WGP6L54/D7tVekwgU2koyO1Nfz0l87vyThRLD3Caya0lJYFI/88DKrqhTiABrotkdZ
         BGwnRCdaXQGJ4gM65oyIAUJjFI9QcWLWR552f6YCqHwSYv5fyx/YuBt5D9h5iMOrieks
         tG0efI3kdo2Uda+Zf5cjbxQQQ+4RJaiO7yd4rEpK1pFdHa/CU9E+2VhyP8ts1qXk4iT7
         6Bp3zKi5uTTViCsVtrlQcQF30R57bZQLZUx6tBAeWVfK2mICHZnTkQRnSMhI4LME6rQb
         fuqAfulwv6kDm8OEbvTr40rgtfNALK3IvqGvhUx96WWKRMFgJ+tZOZOz9jgUERcsvKRW
         DNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741521135; x=1742125935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cQxU3YbjwPi42MJWqznBxmkWXlGLCR5XrFXf/1ZtZ8Y=;
        b=dKNWcLJ8gBcoo0djlwz8PL9Azi3QgAJuXiJs9bFgO64Gult+VF+XkekdLJJKsLIBb8
         e7wsI03Kt/KiqEibdoH3nvuDItNI1pezTxmYuuxCPl3p+6jYWBTw5X9CcwSkDkhATdzy
         TvrciL6wxDLQC3K+gXLSPTd+eXPTUvEMO95PDr9BpVjxdQvdgyk962EL+uxbS5n0aDiy
         ap//yKJXkYiPYESBZMU7ZDMmKaZou4Lbzf5y95HsnKTXLywZn8Aipt9mTj5G6CpX3tnR
         5aEqaW2qj/PjpYoqV04kyCKKnlnm2zY7nM7mmI9jWeIluWk4620CXM4M/XeJqmV1MqDM
         kf9w==
X-Forwarded-Encrypted: i=1; AJvYcCVznsjxIIohIne/sXauDxsYKkrmE5vY8CM9TB2/k/cW0UsUGXPvix4NDr0WI39vuvtiFm+wJM5HOhwWb4jc@vger.kernel.org
X-Gm-Message-State: AOJu0YxrbZOwEgxRl6RdT41CoJVmaTIYc4p04zmnDNnXFaHVKzCN2Y6M
	CrpeWOx8gBiPM/w8zr3ofDPJbxA+A6K/a9SADFxUa8qz9JRhOOMKvfj/rSHW
X-Gm-Gg: ASbGnctT1Q+EmD/wpcBnR8eQCQE3OeHytdJHHj7levzsKmC6tuC+p1x2fdKNsmjva+Y
	5Ulb+HAEecoZJYiuR7sB/gbYj/+ht+MbJdqHaMK4z9mFeQUdPhwP9+YizIYzKfRbocHJz8JQlYU
	0Mp6bwqiOJh60E8t1gcBkySceKHtDJ2kGhbcLfVvqBduEvWSdmQOQ7xkOBvaybxhmp5V5Nf597r
	KGJiCSDuZsW8/Pbc8rfBV48Dx3E55nhdMaSimg1FOcA+PADv/ftN/qoZLK8VOY5ep/bSqJEzbAR
	IxZ+kQmcXeP5wTz7ACOTk/qGwsmZGySdz2KQX1EMAdP0H3+HZcybevzTSZhCcCj4COfTU1sPO5j
	LMQvmdudGpssW5sX6MDo6vBELTkPuBIo4lkUQSw+4wg==
X-Google-Smtp-Source: AGHT+IEdAvFB3nHM6lOreZ+GpHnxIjFzrc+aUy9jA6DPfto13ags5Nl8gygQACk+A0j+X7HvoZbeXw==
X-Received: by 2002:a05:6402:5213:b0:5db:7353:2b5c with SMTP id 4fb4d7f45d1cf-5e6150296ddmr6286841a12.11.1741521134566;
        Sun, 09 Mar 2025 04:52:14 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c74aaff1sm5270273a12.47.2025.03.09.04.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 04:52:13 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] fsnotify: remove check if file is actually being watched for pre-content events on open
Date: Sun,  9 Mar 2025 12:52:06 +0100
Message-Id: <20250309115207.908112-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250309115207.908112-1-amir73il@gmail.com>
References: <20250309115207.908112-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 318652e07fa5b ("fsnotify: check if file is actually being watched
for pre-content events on open") added an optimization that may be
premature.

Patially revert this change, leaving only the file type check, so that
we can use the FMODE_FSNOTIFY_HSM() flag to check if there are any
pre-content watches on the filesystem, which is needed in some cases.

If we find that we need the extra optimization we can reconsider adding
it later.

Fixes: 318652e07fa5b ("fsnotify: check if file is actually being watched for pre-content events on open")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fsnotify.c | 29 ++++-------------------------
 1 file changed, 4 insertions(+), 25 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index fae1b6d397ea0..dafcaa6f8075f 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -650,9 +650,8 @@ EXPORT_SYMBOL_GPL(fsnotify);
  */
 void file_set_fsnotify_mode_from_watchers(struct file *file)
 {
-	struct dentry *dentry = file->f_path.dentry, *parent;
+	struct dentry *dentry = file->f_path.dentry;
 	struct super_block *sb = dentry->d_sb;
-	__u32 mnt_mask, p_mask;
 
 	/* Is it a file opened by fanotify? */
 	if (FMODE_FSNOTIFY_NONE(file->f_mode))
@@ -681,30 +680,10 @@ void file_set_fsnotify_mode_from_watchers(struct file *file)
 	}
 
 	/*
-	 * OK, there are some pre-content watchers. Check if anybody is
-	 * watching for pre-content events on *this* file.
+	 * OK, there are some pre-content watchers on this fs, so
+	 * Enable pre-content events.
 	 */
-	mnt_mask = READ_ONCE(real_mount(file->f_path.mnt)->mnt_fsnotify_mask);
-	if (unlikely(fsnotify_object_watched(d_inode(dentry), mnt_mask,
-				     FSNOTIFY_PRE_CONTENT_EVENTS))) {
-		/* Enable pre-content events */
-		file_set_fsnotify_mode(file, 0);
-		return;
-	}
-
-	/* Is parent watching for pre-content events on this file? */
-	if (dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED) {
-		parent = dget_parent(dentry);
-		p_mask = fsnotify_inode_watches_children(d_inode(parent));
-		dput(parent);
-		if (p_mask & FSNOTIFY_PRE_CONTENT_EVENTS) {
-			/* Enable pre-content events */
-			file_set_fsnotify_mode(file, 0);
-			return;
-		}
-	}
-	/* Nobody watching for pre-content events from this file */
-	file_set_fsnotify_mode(file, FMODE_NONOTIFY | FMODE_NONOTIFY_PERM);
+	file_set_fsnotify_mode(file, 0);
 }
 #endif
 
-- 
2.34.1


