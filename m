Return-Path: <linux-fsdevel+bounces-36403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC909E3666
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 10:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C55A1691B1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 09:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8431A9B4F;
	Wed,  4 Dec 2024 09:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOFdUK0c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FFE194A6C;
	Wed,  4 Dec 2024 09:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733304218; cv=none; b=ZoCxf7HhzM43qrJJOjNO2NoHQz9A3LSPOXZA+MDjl2nHhDbeD936ImWYXE4rbap5N2OKi7saK5lRjENgGMmvoOpe0CIYZ1GN4C5oOeC2mOh61mUiGNjnHaooDnedNO35hgFcHI4yykll+F3/IRWLYs5T0vE3Nuz0THHRWufrqRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733304218; c=relaxed/simple;
	bh=+jxrpgOc8YRFvKhsGN3KT5S1Zrea+B9ujyT15jDkXso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lYvIJnFmMGmOirfdyJIMn2neWxVR8PN5xwfbnp6sFCYQF7SYXdoknGc9xX41bSXk8ldRnWqkZ0Qh9BChb7BAprZ7ePjwGaexmPitcWn73FdQ/pNgDP4gW1FCQ+7ymWJtZxEZN9nd4vzigv4nUCF+pw7+fsz2Q/yTYZX4HTHq750=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOFdUK0c; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ee51c5f000so3671088a91.0;
        Wed, 04 Dec 2024 01:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733304216; x=1733909016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nz2e3VSCrpn4SKKkp4jQQlYfLBK+Znn2f2u0fakLSII=;
        b=dOFdUK0cGTaZsTI3RQ4qgwyBAP+09vvujmfZwG/5fRO7+cfAPgs7Hy3gk/wx2hemnv
         Pnvwdms9jqoKUtbJHAa2pSnZ3rOVGSKJNgDR2sDQ/CfN3xNe/oMCwb+30LgcjjhAmEzu
         7AFXZZNcd2SSa8m8vpvIziven6POyHjfk53Hn1CKPWhxGYmFLaMdQQSUUBtYrSOi6qe7
         b0A5z/aI52HV41q2gSg6pp5xByPFmDBfOn474W5Ugtfb7sEYhYFairWu3H7i47vEckdJ
         I9Yor254btQPBwjxakNb+8mBqtLHwi6osXYTtWmL6bg9Plno0K77SzG+CVZ+TZRgVR/g
         neiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733304216; x=1733909016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nz2e3VSCrpn4SKKkp4jQQlYfLBK+Znn2f2u0fakLSII=;
        b=UNt2umIsFVveR3d2N+ZxDNLJNttsyUxKRqFCjcDKqfBoMTgrvHNtInJ/TmqC8T9YpQ
         7GPdEi9LPi5SWB36vgGJk17H7wIvIoOr9byQcy1YxGJFbLQmChxTr/3v7pTOETIg02Lr
         nOnTsmvBpFfLaSmLn7MtW8MZvZ40RYhazOtsFux96F+w/+OSSpwYAgjuBa0D+usYpfI5
         YduL9V2dUw1wYYz8X0AWHicIma91GqBbLiVfQm5uGg9FKYWy7EmiuwxK8Xns+B0Hkukz
         Tcf61coZPr770UQGTMk6T+cK9K7h15eybOraa08uVzBwXaiEXBpM9dOBi6UT2mJHdBL/
         Of4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVLmH9YeDgKPGRJKtzzFTY3lnjSdZm9Yjl5kI2OaMTW/QQ6gYOr2SvcHUDjfcdGTKMFotiayRJZhExbuApj@vger.kernel.org, AJvYcCXE70Om/5YFd398G+oV5CZdY7FwSfj9r9wa+LBQhhC/f9dYH/v9UweUDY+yU/Ew6QGjqrPwC5mLaeTlFUUv@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi41P7RSLi8pA4TKF13vIsHKyHiNL4DgNg1O5cFi7Kdw4VHbb1
	FuywMEox86WTMrTreHl3dmCAdGSrnJPlnPjhXBtSPPkVCbxoqYAS
X-Gm-Gg: ASbGnct2AhIrpRCEr66ug8rx39L3PoQFDy68n5w2RVF1lcoF+dGXvDgu9AzoTlIUrrJ
	R3VpTgO10mPsbcPux+GXdkGPOZVxoMyvU2N4DtVvh3Se/dDqEsMAKXvcpipZzFrBmQXYCMUB8Ei
	AhsL4vpDwmmW35Z5cWiHSrQRViZq1VlWL7HPUYR6xE0FQraLfA4/UT9lcz/8AvLz/EckQ7WzhkC
	Gwtq2nwUtRZXZDbrc/+rHlfMeE8zv4DBCK60JYdlJUDrN2P1l3mHjAvFdt+Uuh3JRmvVQ==
X-Google-Smtp-Source: AGHT+IF5RLOaNDXo8xPTIFEfvt5JYaXp6AXl8CzksFQ0CWpQDcHplYW5AVdla0MveIHSTbl677g1jQ==
X-Received: by 2002:a17:90b:1a89:b0:2ee:97d1:d818 with SMTP id 98e67ed59e1d1-2ef1ce6b09fmr5023185a91.3.1733304215835;
        Wed, 04 Dec 2024 01:23:35 -0800 (PST)
Received: from vaxr-BM6660-BM6360.. ([2001:288:7001:2703:d6db:3ccc:88ed:bd6c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2705d42dsm1032243a91.8.2024.12.04.01.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 01:23:35 -0800 (PST)
From: I Hsin Cheng <richard120310@gmail.com>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	I Hsin Cheng <richard120310@gmail.com>
Subject: [RFC PATCH] file: Wrap locking mechanism for f_pos_lock
Date: Wed,  4 Dec 2024 17:23:25 +0800
Message-ID: <20241204092325.170349-1-richard120310@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the implementation of "f->f_pos_lock" may change in the future,
wrapping the actual implementation of locking and unlocking of it can
provide better decoupling semantics.

"__f_unlock_pos()" already exist and does that, adding "__f_lock_pos()"
can provide full decoupling.

Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
---
 fs/file.c            | 7 ++++++-
 include/linux/file.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/file.c b/fs/file.c
index fb1011cf6b4a..b93ac67d276d 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1181,6 +1181,11 @@ static inline bool file_needs_f_pos_lock(struct file *file)
 		(file_count(file) > 1 || file->f_op->iterate_shared);
 }
 
+void __f_lock_pos(struct file *f)
+{
+	mutex_lock(&f->f_pos_lock);
+}
+
 struct fd fdget_pos(unsigned int fd)
 {
 	struct fd f = fdget(fd);
@@ -1188,7 +1193,7 @@ struct fd fdget_pos(unsigned int fd)
 
 	if (file && file_needs_f_pos_lock(file)) {
 		f.word |= FDPUT_POS_UNLOCK;
-		mutex_lock(&file->f_pos_lock);
+		__f_lock_pos(file);
 	}
 	return f;
 }
diff --git a/include/linux/file.h b/include/linux/file.h
index 302f11355b10..16292bd95499 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -67,6 +67,7 @@ extern struct file *fget(unsigned int fd);
 extern struct file *fget_raw(unsigned int fd);
 extern struct file *fget_task(struct task_struct *task, unsigned int fd);
 extern struct file *fget_task_next(struct task_struct *task, unsigned int *fd);
+extern void __f_lock_pos(struct file *file);
 extern void __f_unlock_pos(struct file *);
 
 struct fd fdget(unsigned int fd);
-- 
2.43.0


