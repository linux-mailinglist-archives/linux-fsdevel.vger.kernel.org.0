Return-Path: <linux-fsdevel+bounces-14646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 063D187DF46
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 19:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25F7F1C20969
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 18:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B201EEF8;
	Sun, 17 Mar 2024 18:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bepefZdJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE401EA7C
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 Mar 2024 18:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710700929; cv=none; b=HouKkP6cMJfVtZSFSTXzKQmw4Hq9gNnYisD9w6ZgUNHrtM9GnP3WzQv+RDfLS39lo6oCgO+l9ctBv+D2Z4fbSCTsRCwsOZ1V1fXaNWNBvsNqz6dOrnApWfdbp4eVkdxCiQGPg9Y/S3oXRnbDc91YGoP53Cq3LNoopudCM4oN1q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710700929; c=relaxed/simple;
	bh=MCFcqBmg1KP2U9pXvH/3pP52+XpvkOpsBrhTisykTC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JNItpCi8To+//zq+YH9bxxZuCyZgOmd8CDUZdz89cIClT8l6mbhyVDFHPQBUFiHPT8kfAUeFlKb/lMYO0M+WtnvITCmElQ+bPdGxQvocfhPp5PZlX4dD/qdi/aotD+jIGuV3j/ZdehgqZW9YMbLqyIFVQgZUY9B9PJHcDdjooq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bepefZdJ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3416a975840so372146f8f.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Mar 2024 11:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710700926; x=1711305726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yp2LrzU9cjuWTZ6nXXcqs34SIuhKhJtTF6aPiuNmIcE=;
        b=bepefZdJWuwV0nLaohyKJozuL4hGR0+rF47l354qyi0RvypzubBF0I7bAN6/3r6AEp
         33MvJ/L7TXNq4blVFKky9rlQudKw3BAbczwTHw2tuGoNQPWtkNDvGzEGVlRQqlZFIPWk
         +tZnAs/KeWnOuYuz94RiIvf+dGvjhQqL157TqYa7fwosISmowkUMVVllvnIp4ygz6QTz
         t38sT36eBmGdfpP2IQV7LdQ0R/+R2mkWSsxKArc1w57M4jzr92V2wDsTYXEI0IXvgbL0
         QIgDk3EKwmuQSHfwkSPWgPbvtpspjAhWyrdkLid5Fki7A1GyO1wSyfCWHugF1EE2YnID
         0fcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710700926; x=1711305726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yp2LrzU9cjuWTZ6nXXcqs34SIuhKhJtTF6aPiuNmIcE=;
        b=lnz33k3bQh1oA/gSCVu+WJPbVjxet/IU6BO9IorKMaaQ1Q6qg9yu8UPejQmEbeRFvf
         WXkSTzX8xv1JbOqQB3yQ4TLzeDiYchu+4LlSYYUwCpGLuBMO5I12pc+D6v4BWaggTSSq
         7Y8TwiFShY8s5uIogn3Yrey00PurqiSfPagRqK1VBoA5sQmxsG6RNDnJaA18eI21Y45Z
         y0l70wAxcUqi+wZTalFq+kwSy/pGQWajuXzYre3XVwyeNT10nKQqpPfxcb554e8qbK7e
         SUfQeecNExazbShPzHiTICt0q0H90pKCXiB4icuq7lGspViolF1ux0b4fCm6PZt4BoY1
         XqRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQzFsbmRaC11JDkzkfamzTfPp6zLWKdkjhmEQIpkFghQb4K4Z/U+xd7QvMYjojs7oORkDTISQ6v06cRPD7FJMa0nxXJIzuimS1INWpXg==
X-Gm-Message-State: AOJu0YzE7anT0JtLlnbCrRiKbATRQzpg/g+0zyakJnFhNIA2fGvEtuIU
	pz+Oo/ZjJ6YCqbmB06+xALYx0fCQGmhia/beqge3tB0NG7i0Y2zb
X-Google-Smtp-Source: AGHT+IHqmnYjqwGh3KQEjLCSEa974aXms0Cd/FscpLr9UlSMFlXzcFVV38+1XHbcJW+1/d/7YHejBQ==
X-Received: by 2002:a5d:4a44:0:b0:33e:4969:f05a with SMTP id v4-20020a5d4a44000000b0033e4969f05amr7482150wrs.37.1710700926050;
        Sun, 17 Mar 2024 11:42:06 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan (85-250-214-4.bb.netvision.net.il. [85.250.214.4])
        by smtp.gmail.com with ESMTPSA id bk28-20020a0560001d9c00b0033e22a7b3f8sm3070716wrb.75.2024.03.17.11.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 11:42:05 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/10] fanotify: merge two checks regarding add of ignore mark
Date: Sun, 17 Mar 2024 20:41:48 +0200
Message-Id: <20240317184154.1200192-5-amir73il@gmail.com>
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

There are two similar checks for adding an ignore mark without
FAN_MARK_IGNORED_SURV_MODIFY, one for the old FAN_MARK_IGNORED flag
and one for the new FAN_MARK_IGNORE flag.

Merge the two checks into a single location.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c | 35 +++++++++++++++---------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index fbdc63cc10d9..04b761fd47e6 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1412,18 +1412,6 @@ static int fanotify_add_inode_mark(struct fsnotify_group *group,
 				   struct inode *inode, __u32 mask,
 				   unsigned int flags, struct fan_fsid *fsid)
 {
-	pr_debug("%s: group=%p inode=%p\n", __func__, group, inode);
-
-	/*
-	 * If some other task has this inode open for write we should not add
-	 * an ignore mask, unless that ignore mask is supposed to survive
-	 * modification changes anyway.
-	 */
-	if ((flags & FANOTIFY_MARK_IGNORE_BITS) &&
-	    !(flags & FAN_MARK_IGNORED_SURV_MODIFY) &&
-	    inode_is_open_for_write(inode))
-		return 0;
-
 	return fanotify_add_mark(group, &inode->i_fsnotify_marks,
 				 FSNOTIFY_OBJ_TYPE_INODE, mask, flags, fsid);
 }
@@ -1913,12 +1901,23 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	else
 		mnt = path.mnt;
 
-	ret = mnt ? -EINVAL : -EISDIR;
-	/* FAN_MARK_IGNORE requires SURV_MODIFY for sb/mount/dir marks */
-	if (mark_cmd == FAN_MARK_ADD && ignore == FAN_MARK_IGNORE &&
-	    (mnt || S_ISDIR(inode->i_mode)) &&
-	    !(flags & FAN_MARK_IGNORED_SURV_MODIFY))
-		goto path_put_and_out;
+	/*
+	 * If some other task has this inode open for write we should not add
+	 * an ignore mask, unless that ignore mask is supposed to survive
+	 * modification changes anyway.
+	 */
+	if (mark_cmd == FAN_MARK_ADD && (flags & FANOTIFY_MARK_IGNORE_BITS) &&
+	    !(flags & FAN_MARK_IGNORED_SURV_MODIFY)) {
+		ret = mnt ? -EINVAL : -EISDIR;
+		/* FAN_MARK_IGNORE requires SURV_MODIFY for sb/mount/dir marks */
+		if (ignore == FAN_MARK_IGNORE &&
+		    (mnt || S_ISDIR(inode->i_mode)))
+			goto path_put_and_out;
+
+		ret = 0;
+		if (inode && inode_is_open_for_write(inode))
+			goto path_put_and_out;
+	}
 
 	/* Mask out FAN_EVENT_ON_CHILD flag for sb/mount/non-dir marks */
 	if (mnt || !S_ISDIR(inode->i_mode)) {
-- 
2.34.1


