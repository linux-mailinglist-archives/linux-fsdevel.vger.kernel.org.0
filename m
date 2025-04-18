Return-Path: <linux-fsdevel+bounces-46696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D74A93E5A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 21:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50A5B464D15
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 19:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DE422D4F0;
	Fri, 18 Apr 2025 19:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXnAr4jb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177F4219311
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Apr 2025 19:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745005150; cv=none; b=B3sOj2zKuRGa7SrKUJn2o0Qoj7BTdxFaEPZpVV+Ms4y8YLEbkYv+rhiaydPEfo8lVVUTnW6XxchfCCUvhqpYDAsHYLmLRxkEFA/7y9ElRKrT1lcPrR1SLMHxp2t0RFtTI/xqzIHtLZjQt/saJINP5zETIea5QANv/j1wl1DBQIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745005150; c=relaxed/simple;
	bh=wd+kmj+aiKg8EaOK0U9K+C6wkSPJBe2WMOHNPJsAUv8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pQgwsxeyZaWJ8bbbivgl/j098zOhUBe+fb2VSvWlEeByt0xvXmYshyS2srgxmeMrO6LHKOLTsqYbfxOvqJl1qbLokcqPWaNi91s2QRO9xNwj8nRvIq0txIF74RPc0FwRkVs4ZfkU8Ns6xmQggB07/X01TeAuQSLwhfMvfJj1QKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXnAr4jb; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac289147833so403264366b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Apr 2025 12:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745005147; x=1745609947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lyI4eT+swBQCF92TWf6HecrXYqnCLMgXQTRWK/kenY4=;
        b=mXnAr4jbIi1FBaVBLeOJYkyE9QHEEm+wsfmJ8NqMYzpVo4AR2spv3ax4uukP9fQa2s
         v+t44EOzsh1Dpo8pYYzgbJSMEFmXowvz0/FLib0U/O/P5UUtn0eyK5St05GFGa2uoeuO
         c3nhjOUGROzg7mcy3fxecUEFrOsFXdzL6ZAPxv2Z1nS70+Z9d1kCdwjgjTTxetph4rIU
         WS65GC7Z7JjPqcsCXfdo0tcY+eZtzIg0QDPapeFAf2HB2gKKLgdE6VQ/yloICOmYBu42
         Op2AethM05OAoWcii0y/2e/IZT+rprSXXZUJkQVHv1gu7Y+Kwe92ouh0/Bm7+K12ba9g
         U6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745005147; x=1745609947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lyI4eT+swBQCF92TWf6HecrXYqnCLMgXQTRWK/kenY4=;
        b=XSYVrnh5D3PX9cA9W35oucnVfgx6RN/BC6eEuzZEZ1V7KqvCfgZ8VQnV0o5fxdOkij
         f8pkwkfof0LEfId9GoIkr0Ds9Y6U+LHZW2BSVJY+X1BVrJ6Zz9GgDBwIp8FeTIs6YPSS
         9yCxbXj5fe3zGaef+fBzvg+1VjzqwQ031rQ4dzeO8hK13SOl6doN5Gn3A/HTN7YiPirv
         1Z3aN+WX5W71Du67+Ukg7T6OEUDD+eI4gQBTxIgyPgKmkdSL5v5HxL0BH5e6lC9BdJhE
         ceYxdHFUrKt5OG1ZvQnxEwS7emPpQKVHFwXe57PkM4UdCiSs88M+juUAxUZWvFzEb/Tg
         Id6g==
X-Forwarded-Encrypted: i=1; AJvYcCXq5anH3E14bR0bv9su4RX3rGQWx+ZY6r3OcSIqbYOlmnjYNC0lJYBR5YxrT1+/ZxRVc0C526m4r4d7ok4f@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5ZtaTkxCAcOyAng974do7Gpjc89DCJ8dnPM4qhu5eRSm7R7NA
	3MrdusyADCFdgvaFuVzkOJ8yZsNc0vEtLZYdsExil/tcesrZ4C6ZzXZR5d83
X-Gm-Gg: ASbGncuskdvgR794xk1H3EtYh+xtekSjzoRmgDIu7zqGVKnQePF+/BZMf5WK/B9Kvau
	z7IsYmn0nhce4pMK6NSNV8UFFQsJAI9ReEGE8WLjVv/oUUWNIPs9NEa5c5yEjKACcO4KAEs6HwF
	MLwyduuMfwp3ZsTvmHlkD7FKmnI7/jKdjJQFSjSbHHqMfFhUSaQOM0I5NSNsL+UK0WV4Zit/mYy
	TEo/KJ816ouNXAwevktl8qcDTcU64hGWnSbFR2lmvf+1WCOEO6ae01SIao/H9QWq4biSfdEpXCQ
	PRlZlYr4E/C++o1KodYdVySQNUFYS2fRqA9vE20yHKeNuehdfwLxixFMzSFEsSolHTcjxMRbZDP
	mUbx9+L9uiERlvLTO/YoKViPu4DBzI1ew0/Z2Uw==
X-Google-Smtp-Source: AGHT+IHFD9woAGmmdK3v4T17TdsRtT0XSAuTMh6ov9ub5vAZOSjEBUbxpHPu5PvgGWWivtwSU5JgLg==
X-Received: by 2002:a17:907:9622:b0:ac6:fe8c:e7bb with SMTP id a640c23a62f3a-acb74dd6016mr330684566b.55.1745005146906;
        Fri, 18 Apr 2025 12:39:06 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ef4798fsm156084266b.151.2025.04.18.12.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 12:39:06 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] fanotify: fix flush of mntns marks
Date: Fri, 18 Apr 2025 21:39:02 +0200
Message-Id: <20250418193903.2607617-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250418193903.2607617-1-amir73il@gmail.com>
References: <20250418193903.2607617-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fanotify_mark(fd, FAN_MARK_FLUSH | FAN_MARK_MNTNS, ...)
was incorrectly implemented and causes flush of mount marks.

Fixes: ("0f46d81f2bce fanotify: notify on mount attach and detach")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c |  7 +------
 include/linux/fsnotify_backend.h   | 15 ---------------
 2 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index f2d840ae4ded..87f861e9004f 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1961,12 +1961,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 		return -EINVAL;
 
 	if (mark_cmd == FAN_MARK_FLUSH) {
-		if (mark_type == FAN_MARK_MOUNT)
-			fsnotify_clear_vfsmount_marks_by_group(group);
-		else if (mark_type == FAN_MARK_FILESYSTEM)
-			fsnotify_clear_sb_marks_by_group(group);
-		else
-			fsnotify_clear_inode_marks_by_group(group);
+		fsnotify_clear_marks_by_group(group, obj_type);
 		return 0;
 	}
 
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 6cd8d1d28b8b..fc27b53c58c2 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -907,21 +907,6 @@ extern void fsnotify_wait_marks_destroyed(void);
 /* Clear all of the marks of a group attached to a given object type */
 extern void fsnotify_clear_marks_by_group(struct fsnotify_group *group,
 					  unsigned int obj_type);
-/* run all the marks in a group, and clear all of the vfsmount marks */
-static inline void fsnotify_clear_vfsmount_marks_by_group(struct fsnotify_group *group)
-{
-	fsnotify_clear_marks_by_group(group, FSNOTIFY_OBJ_TYPE_VFSMOUNT);
-}
-/* run all the marks in a group, and clear all of the inode marks */
-static inline void fsnotify_clear_inode_marks_by_group(struct fsnotify_group *group)
-{
-	fsnotify_clear_marks_by_group(group, FSNOTIFY_OBJ_TYPE_INODE);
-}
-/* run all the marks in a group, and clear all of the sn marks */
-static inline void fsnotify_clear_sb_marks_by_group(struct fsnotify_group *group)
-{
-	fsnotify_clear_marks_by_group(group, FSNOTIFY_OBJ_TYPE_SB);
-}
 extern void fsnotify_get_mark(struct fsnotify_mark *mark);
 extern void fsnotify_put_mark(struct fsnotify_mark *mark);
 extern void fsnotify_finish_user_wait(struct fsnotify_iter_info *iter_info);
-- 
2.34.1


