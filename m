Return-Path: <linux-fsdevel+bounces-14644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F080687DF44
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 19:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E591F21058
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 18:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31FD1EA80;
	Sun, 17 Mar 2024 18:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2ej01KW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8B21DA32
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 Mar 2024 18:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710700927; cv=none; b=Cew/1Y22t0JIVsUB7AqFmlXv+MIVZrsFI1xQEH70DWeJ2F7GtCzQu9Fd3H8aVxcutJ1ncaGwGpzK0r7+o4ul1IvIDt0HgIo/ZPyxJrGgDXCW8Gexzfz09L6NGuV12nP2rMQ6GJ1lIWypbTXCHITQVEeouthZw94XIKt6PtQGQSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710700927; c=relaxed/simple;
	bh=b1nmrhnKlbgAnrs+A7smEMaL+SFM0ggOlWq8xOjj4Jg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GLhobr4y1NFFc/fhUj0m/7TFchtUVHZZmi9T7k+ZrdjNNqhKaTI7B/F8RRIsP2vIC+GSvk2oXufFqARiuNE1ubAQOzL7c/YNthXKq5XWNoREjEG2ITQ4LgkPz7x+Oev+P56foriMXxNdQxQO0FqELSBWbC4oaaYA1zHrd5uLDpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2ej01KW; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4140cc9c64cso5578115e9.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Mar 2024 11:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710700924; x=1711305724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iP9fJ6fV6eZFDgaAPgCF6fVivcex8rLoYCaP4556RYk=;
        b=K2ej01KWqzybeTJFg1UbIxe9vB4KPLy/B9/+YLtWlyehjUjJwRENHzTZzUKIzxu6vO
         WVl5X/mDRUhdv9CD8lpkQ7jKpKfI+BZIHeoTsuRgTSxaqlsN7GuJ3gf3VyrnjqiAEe6m
         DEprt5K7C2ki7BtruVFn+xTM2Rw0k1JC3PICsbeXKnJYem3NQEWb2E88bKp5a44Ng+98
         k2vUKNJjJBlltOBP/4bnQ1D/BcxzLyJ55QV4f3zGcdvf5lEzd06LpdeSqrN5WDVZroEf
         HFp7eU8JMWrfbOWlKcCPyNRd6LUj08xPt9t/HDLFOj52vdb1peglFIsEVGjzf2/4rWek
         yOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710700924; x=1711305724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iP9fJ6fV6eZFDgaAPgCF6fVivcex8rLoYCaP4556RYk=;
        b=KhKIEFhckFRe0W387LjJHsmAMUcRSw6/runPysfcbKEp3F8CFyldZFTrzMnchwESW5
         +CuCXMLf++2YAeXEXI5aCV+XtgSmOxQJCF68XrT7MrVkLbGE5YiXlNO+fLYLOXhfES/q
         JIX+PR7MMRNsSmtDS1eCyFjet4zrtZ2uPOBpqCFOUv9K1Ck9OU98ILJE5US9QuxVHl/0
         vDG+BjMPEI/ZBl1GLMFi8LYqYxdtrKQWW4l5PQuqqt9jvwzolKPLvbbO7vaDPHemUNrY
         OpuHxhzze/WwnWrHYULbAHNm4Kh2+TLVYUDRk30fJWPkN2GdnURkhE7MqTrGUj53o11K
         UFww==
X-Forwarded-Encrypted: i=1; AJvYcCWjK1UHxx08sEW6j/gxNMz575zw6H3MEFAiUqcXznURiR7h9IUgT3/Z4Jfy/lnrH/OjrXnhk/5C1C2Fzeo+VDBVtuORsnnN1pV1T0k1rw==
X-Gm-Message-State: AOJu0YyyJmgOuXq9QoR0PFC/lGj6maqlDOSne+o5dyE3YEVfzFQyJBoA
	q8H0UPnU/DR6TFdbvjwnq2GNgyFF1/OtbKd89nBKoQ4cpz9Nd4n1k4c1VLuY
X-Google-Smtp-Source: AGHT+IFZltH2Oajcvo12Bf5h5d8fyuYfcck/r+dXghpeAuXZy50+vZz/jqpmryt72IwnSWaDNwdovA==
X-Received: by 2002:a05:6000:ad2:b0:33e:c7e2:2b64 with SMTP id di18-20020a0560000ad200b0033ec7e22b64mr4124423wrb.42.1710700923696;
        Sun, 17 Mar 2024 11:42:03 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan (85-250-214-4.bb.netvision.net.il. [85.250.214.4])
        by smtp.gmail.com with ESMTPSA id bk28-20020a0560001d9c00b0033e22a7b3f8sm3070716wrb.75.2024.03.17.11.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 11:42:03 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 02/10] fsnotify: create helpers to get sb and connp from object
Date: Sun, 17 Mar 2024 20:41:46 +0200
Message-Id: <20240317184154.1200192-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240317184154.1200192-1-amir73il@gmail.com>
References: <20240317184154.1200192-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation to passing an object pointer to add/remove/find mark
helpers, create helpers to get sb and connp by object type.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fsnotify.h | 14 ++++++++++++++
 fs/notify/mark.c     | 14 ++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
index fde74eb333cc..87456ce40364 100644
--- a/fs/notify/fsnotify.h
+++ b/fs/notify/fsnotify.h
@@ -27,6 +27,20 @@ static inline struct super_block *fsnotify_conn_sb(
 	return container_of(conn->obj, struct super_block, s_fsnotify_marks);
 }
 
+static inline struct super_block *fsnotify_object_sb(void *obj, int obj_type)
+{
+	switch (obj_type) {
+	case FSNOTIFY_OBJ_TYPE_INODE:
+		return ((struct inode *)obj)->i_sb;
+	case FSNOTIFY_OBJ_TYPE_VFSMOUNT:
+		return ((struct vfsmount *)obj)->mnt_sb;
+	case FSNOTIFY_OBJ_TYPE_SB:
+		return (struct super_block *)obj;
+	default:
+		return NULL;
+	}
+}
+
 static inline struct super_block *fsnotify_connector_sb(
 				struct fsnotify_mark_connector *conn)
 {
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 8339d77b1aa2..95bcd818ae96 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -97,6 +97,20 @@ void fsnotify_get_mark(struct fsnotify_mark *mark)
 	refcount_inc(&mark->refcnt);
 }
 
+static fsnotify_connp_t *fsnotify_object_connp(void *obj, int obj_type)
+{
+	switch (obj_type) {
+	case FSNOTIFY_OBJ_TYPE_INODE:
+		return &((struct inode *)obj)->i_fsnotify_marks;
+	case FSNOTIFY_OBJ_TYPE_VFSMOUNT:
+		return &real_mount(obj)->mnt_fsnotify_marks;
+	case FSNOTIFY_OBJ_TYPE_SB:
+		return &((struct super_block *)obj)->s_fsnotify_marks;
+	default:
+		return NULL;
+	}
+}
+
 static __u32 *fsnotify_conn_mask_p(struct fsnotify_mark_connector *conn)
 {
 	if (conn->type == FSNOTIFY_OBJ_TYPE_INODE)
-- 
2.34.1


