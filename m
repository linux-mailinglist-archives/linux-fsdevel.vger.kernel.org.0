Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC0D221EAB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 10:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgGPImr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 04:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbgGPImo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:42:44 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBCCC061755
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 01:42:44 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 17so10636631wmo.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 01:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jUBJ04Tw/aomYNAZEeJ5HmXe1ePS3U6CnKoM422Oh4s=;
        b=ClS/+M/ukqvR2mDyd4modrHi2wBHcGHZI7pN5DjPVwz3sQrEacmBiqk2SUyNmUuGYF
         mJDYvUZeP4kq/SlU09Go4R666ipufSVWvdnz8ed2Aeo5nj9fLSfeIxvHONBbx4hZ7Wtw
         dp9cMPERYKHz6O99CRKE32uJnpkUOQ2S5SIO8KC8csWKkB7ydAt3UCQR97fn56f/wK0W
         SyGUzPhQ7cnxbfiQmPC4fuVlPlGkp3tNql+PgpVbCsTAWotJE117aiUafTxfDq1+dMYc
         V0uKZxK3EuQgFzTzrtEZ5QLUM6O+0VM9g6I19BEgKBwmyNPRa6n1fvFy8HUPyH+hvmMB
         rPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jUBJ04Tw/aomYNAZEeJ5HmXe1ePS3U6CnKoM422Oh4s=;
        b=MO4/iyQPpaO7FionjtRuKXgvJiHhH9VtYT46sZ+qOr+oJbNGVFjZ9JwOji3SyRlsGP
         NtsrI/GrBKdsCwzLoxHGvLtmF0I69SNlKSYltrzK60O/IiJc5TWwCG+LjWjz61cFCxW9
         6pInOMatqCTWlL46dxIQt3zoKVlGVjouZQnqQTaWbQZFfHkFAuo5uPk01cBRTtos7BSw
         GLTBNrDBsAFwi3Xgguz1LORRal5PsYnckuNk7wT1PlPwHL6OlHOTza6RywqYGjxJqTLQ
         eed9fakwgDEK7ETmhosuVoIzmmj+UVVbrgrJ6c2I30W4cXFsqi4/8uCvRpmNXvEE5RYl
         0UBQ==
X-Gm-Message-State: AOAM532uxmFC5hXE0F6y+3C46OiKSLNWYqg8R5R9KVtOiRdTa/7yWBbL
        BAxyquO/aFzLUj+jIvBZTf8ewXSx
X-Google-Smtp-Source: ABdhPJw+1aiJPrPzQidaz+8krO8hFhFwv7tljJkIni1LvmAhppMDlFJHKrI2FIjcrOSS9Ipjjb9IBA==
X-Received: by 2002:a1c:27c1:: with SMTP id n184mr3473078wmn.6.1594888963367;
        Thu, 16 Jul 2020 01:42:43 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id j75sm8509977wrj.22.2020.07.16.01.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 01:42:42 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 05/22] fanotify: mask out special event flags from ignored mask
Date:   Thu, 16 Jul 2020 11:42:13 +0300
Message-Id: <20200716084230.30611-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716084230.30611-1-amir73il@gmail.com>
References: <20200716084230.30611-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The special event flags (FAN_ONDIR, FAN_EVENT_ON_CHILD) never had
any meaning in ignored mask. Mask them out explicitly.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 1e04caf8d6ba..6d30beb320f3 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1040,6 +1040,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	__kernel_fsid_t __fsid, *fsid = NULL;
 	u32 valid_mask = FANOTIFY_EVENTS | FANOTIFY_EVENT_FLAGS;
 	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
+	bool ignored = flags & FAN_MARK_IGNORED_MASK;
 	unsigned int obj_type, fid_mode;
 	int ret;
 
@@ -1087,6 +1088,10 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	if (mask & ~valid_mask)
 		return -EINVAL;
 
+	/* Event flags (ONDIR, ON_CHILD) are meaningless in ignored mask */
+	if (ignored)
+		mask &= ~FANOTIFY_EVENT_FLAGS;
+
 	f = fdget(fanotify_fd);
 	if (unlikely(!f.file))
 		return -EBADF;
-- 
2.17.1

