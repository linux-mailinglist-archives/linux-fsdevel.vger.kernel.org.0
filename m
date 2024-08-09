Return-Path: <linux-fsdevel+bounces-25558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9597294D68A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 20:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B92531C220E6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 18:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B4015EFD0;
	Fri,  9 Aug 2024 18:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="aK/KphFn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D2415A862
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Aug 2024 18:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723229098; cv=none; b=DDv+yXLswRcFJ1H3z8znFe5AJO1lRvKZNs9EfgSgjFQ76llzRD7YWM5k03pSKdwkigvQB/bo/rAlLckgvlHtk0qfEpC7p9Bdm009K+pP8wNsEQqDy4MKN7XXImpMRCqMU+mTM1BXdDJtRJ4F+PjSOPACxra4xJ8nC1WYFTif5v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723229098; c=relaxed/simple;
	bh=2T/bTyebmmWzgd79hiDdf0J2vl5OhNotJm/x2K/voWI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHBU/VYyRiNNalBvIZwCVQVjJnygj4eyBv+CLBktTUUTHkJm5yu2NYp87qXGUC0RhtPsj/LGZAUBO3kIQeuL1SRx6X/WZcb7rSHbObV9ebQlYVpDh/9MDVI+Wuu0B6SqCRd5nVQzr7wTiKFaoWtM4GVfjRGYDNiJXwPs3dKcZ78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=aK/KphFn; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a1e4c75488so147118285a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Aug 2024 11:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723229095; x=1723833895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rE3z53SxlgArsKnVp16449O9VmLlGGSseshi4KP5xk8=;
        b=aK/KphFnztu0k+zKP8edP0bMnNQdw8XwKsOGrSCximDQNbqvL4BBB9sN07E9hXt7i1
         whbj8jtVeOTk9WFyMeyh7NSaVQ88s8xeiIF4ZJXQT3SbInQuNGVPXnvl5RMYo+g1vbRs
         1C0LrT+RJGXEmqjvzcgU1zMWpT348pckPA4bupKyDHEU1eisoI7cyT4oCdQ6OCVSsMEp
         DG+lF8oGLlrFxg8hS9I05Mv01Yij8MS/izcJ/HnnbFShCu2Ap8Ip0qggP0u2j8pxe8G7
         MZLk0KLCXAWeWtkMkktrTAUfFOvw+4c8Rb1HHTyy0JiT2Fw2HIXfvIlYb/xfJQwV5vFo
         61zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723229095; x=1723833895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rE3z53SxlgArsKnVp16449O9VmLlGGSseshi4KP5xk8=;
        b=XdAl75rPiGEK8YUC9/wwshtLlXLDBytwmXqIFspuEklNqMTtuTGChuESBVXEsZ6GGJ
         id/uDf8Al20NOfU3swDn2hZX1RKgqFyH7MW9qQ7uc4vW/3oTGwb8/jWaiyXh8wApGHup
         SdGaXcV/Btq7OildKN2Av+hcSNjIw6YaY0pouP+woc94RNCeD5ama6+Dd86qFzs+9QHi
         TsHjTeBvgyXrWzaW+RuxCmmNvUPVzywrJXgBaE60bI5T8eimzBwceRBX1ZP1sYGrIXP6
         tZCu4T6eIvXDxCLwPXng+Udemy2l3kkeiyOhnd7WFuSLUKZ0/+ZyR6ddc4LvMRXoMWHL
         qHmg==
X-Forwarded-Encrypted: i=1; AJvYcCU1K7cDZz1Uosa8sTNnPGQN49jbUs6mcH5qFVygPKYFtWgYEImpTb89G0SsD74veG9xTbhA5NkvCNRbHXp0jZ1Mv1HR9V+iP0pYqW7mTQ==
X-Gm-Message-State: AOJu0YxdNINc2CEbh+VcMHlxjT8fYSeV+fz5nd7p9x4tlV2DEDtigujj
	CHywKNT4wJO99N5VROxK9BzErvogCN5YKm+o6AAWDzybZnHsfVNjIieRhO1+MLjt/wvzPVUywwJ
	h
X-Google-Smtp-Source: AGHT+IE+4cAeGI2IrLHm9+QXQfJeM6o9eDiy6XNCvfHvWZenBULR3s4f7ggKi9MJTEoPvfkVGp5AYg==
X-Received: by 2002:a05:620a:2589:b0:79d:6039:783c with SMTP id af79cd13be357-7a4c17f0865mr249153685a.41.1723229094969;
        Fri, 09 Aug 2024 11:44:54 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7d820dbsm4254485a.66.2024.08.09.11.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 11:44:53 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v3 01/16] fanotify: don't skip extra event info if no info_mode is set
Date: Fri,  9 Aug 2024 14:44:09 -0400
Message-ID: <6a659625a0d08fae894cc47352453a6be2579788.1723228772.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723228772.git.josef@toxicpanda.com>
References: <cover.1723228772.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New pre-content events will be path events but they will also carry
additional range information. Remove the optimization to skip checking
whether info structures need to be generated for path events. This
results in no change in generated info structures for existing events.

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


