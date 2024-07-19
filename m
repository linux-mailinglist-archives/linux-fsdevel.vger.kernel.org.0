Return-Path: <linux-fsdevel+bounces-24021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F2B9379E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 17:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29ED1281E29
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 15:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EB3145346;
	Fri, 19 Jul 2024 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="OsXR4VIB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B8F1E4AD
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jul 2024 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721403076; cv=none; b=ZZob/NVqehoskCBc46xGA65y312gV3LjP8eQDkpyzgayUYIj+KFXqnz2k5UQOew4nZQoczSCMWnuAkaCEh3/to43Wo6vcCo1UMG6BKF1Yhu/LIFH7riA7iZKjQB/ieW9kh7fweElW2n+aFGlyi0ASIdttm3HG9ZgdsIp41bHbds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721403076; c=relaxed/simple;
	bh=pphRo5cAIY6sXyWotHh3OYUODOC3SG0MiMZJ8lGUQvU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kiCK1hj3wC11/7sYkxaxv8SbYVSdcR3Z6zbFSQGwJ9AAoU0Yx9um0Fstzd9xqne9dxfUCftHVoyvPVDyAS/AVAq6pWDTbRbs1Bk5YklazB5yFK0GUuHb2lHwsDrz/d0pJzEYBngdkMyBTOiIBT1Bhcdmp77NNIyJPuka3GJk9TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=OsXR4VIB; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6687f2f0986so19180187b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jul 2024 08:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1721403073; x=1722007873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DV/bmBiugHCOGdiwdB7fAnf5wKaKZzTHXbldMI40hCY=;
        b=OsXR4VIB21ZIodPT/6Kn+CHAyf7wX8O3/2lihEK5UUdGhGgJ8XZMudtWdbZTzXv96f
         tEUQXT4cQSoBxXHnVrSvg/RCW48n21PtU0TtFnHackzBrzxeDWCm/BB3MKzqK9aV8Y5X
         P14LPvkLinpwYoTBhR3qA45l6OXthF/6Q7PtnDPBUrqvDe/FUpptGr39sdZYX8+USwxW
         bz1aI0YBMpd3zNxczOxtjLewfIg4OH8zTu8/BKLqImzSVdhVvzrmXkub6Jmtds4AZGHw
         KAixulpn/EB9emdlVr7iTgd+1tOK4263jd2Kio2/6FBTtfyOVTYtrf72Ct9ftkFvn4x6
         hD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721403073; x=1722007873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DV/bmBiugHCOGdiwdB7fAnf5wKaKZzTHXbldMI40hCY=;
        b=fjV35WaRVDxkhyTIinz7c/gL7os9IQmyut9S1FXLH1NqyPtRdg0WpVJRXFc+07daVq
         FnQqMeNcjZsY8s3oS/zs8EninZ8OeiAmQETdNVnJuH7G8cbLdgoF2nOrrdTMbhNJFmhi
         szjSJbUPu4Elr7+zwi6FGFnGq66NVT9Ia9ouSNxUfA/ACWkN+5NzTXxH8bxPROP67g1e
         M8IB22+c5we9PHrRrcFRv0l8ulUA0BvTHxfeL0b/i9ThKKVAqwD+mMyYQYeI27i9fc2h
         JlNUKyWfjhn2h/0jK1JiVGBo96wW5xky4g1GgWvbq2Kob5zkSK8Sh5EGoXn2xR/2XlVd
         D0iQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8GfXifNbzkFckzQg2YjwS+nE2rB5IrjmazzBmAu7TiaTNnhPEyYYf8jQUPMrHmRNDFGLBxAqj8qe1G3I5RLgvLkLbCLtA9xqfQnNjZQ==
X-Gm-Message-State: AOJu0YwWVP3JVc1w2XqjrOxIoulyUZLeLZDUaa+hDnzkhykCR9ZOpG1u
	I+irv+8Hs7u28PCM67hysn74NyWmolh3m6QEnA2lTkC7sDZboB0npTrooJJc1toJVbeXkhlrMTP
	h
X-Google-Smtp-Source: AGHT+IGhUJiykEUB4QmHpTZdwE/HZzkuQYUkKPp9R/NXo9PtPGW/2D7OwtLdGtt5Lq08zPZzOAreZw==
X-Received: by 2002:a05:690c:c03:b0:664:f825:93ca with SMTP id 00721157ae682-666023932d4mr75001117b3.25.1721403073229;
        Fri, 19 Jul 2024 08:31:13 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7ac7f15c6sm8467606d6.68.2024.07.19.08.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 08:31:12 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: jack@suse.cz,
	amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] fanotify: don't skip extra event info if no info_mode is set
Date: Fri, 19 Jul 2024 11:30:48 -0400
Message-ID: <adfd31f369528c9958922d901fbe8eba48dfe496.1721403041.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously we would only include optional information if you requested
it via an FAN_ flag at fanotify_init time (FAN_REPORT_FID for example).
However this isn't necessary as the event length is encoded in the
metadata, and if the user doesn't want to consume the information they
don't have to.  With the PRE_ACCESS events we will always generate range
information, so drop this check in order to allow this extra
information to be exported without needing to have another flag.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/notify/fanotify/fanotify_user.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 9ec313e9f6e1..2e2fba8a9d20 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -160,9 +160,6 @@ static size_t fanotify_event_len(unsigned int info_mode,
 	int fh_len;
 	int dot_len = 0;
 
-	if (!info_mode)
-		return event_len;
-
 	if (fanotify_is_error_event(event->mask))
 		event_len += FANOTIFY_ERROR_INFO_LEN;
 
@@ -740,12 +737,10 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	if (fanotify_is_perm_event(event->mask))
 		FANOTIFY_PERM(event)->fd = fd;
 
-	if (info_mode) {
-		ret = copy_info_records_to_user(event, info, info_mode, pidfd,
-						buf, count);
-		if (ret < 0)
-			goto out_close_fd;
-	}
+	ret = copy_info_records_to_user(event, info, info_mode, pidfd,
+					buf, count);
+	if (ret < 0)
+		goto out_close_fd;
 
 	if (f)
 		fd_install(fd, f);
-- 
2.43.0


