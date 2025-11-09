Return-Path: <linux-fsdevel+bounces-67586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3890C43E34
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 13:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9EAB1889F07
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 12:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7044D2F2619;
	Sun,  9 Nov 2025 12:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMgoG7sp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670572EC56D
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Nov 2025 12:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762692783; cv=none; b=Z1nTsxsRiRpqsKlHOckUexjlkte/NxLviDDnTInYAfFfCQWRU/MsYOgk7kYOFUciOPEa2yFmIEwUJ3gD4p92oUo7tDi/YyBH4/jTpDNPaVMFkLe1eOhOFadwrUq7dpQBwjSW+tDnvo6slTlT+YUlc21gnGtyP5br3IQQiBeUAEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762692783; c=relaxed/simple;
	bh=Wd53Qgttz8/HlKQBRCBgJT+eS7yPLn9ZSZ4MOrmxLtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FmEbv0tLQQlmfet1f10jVfLFKNTV1B7OKDpOmTY0YdpeRqsRuzYgNplAETd9n47DSXbxErJKfgS/+9e6oRA4UKbtrwFLfMFHP0NajdJhJdpZTNikwZIbQbQiiCqAUq47E+TWj0CcPtlOCkVId8WsdjrQyBLYgSAInNmUd8vl8z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMgoG7sp; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so395201966b.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Nov 2025 04:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762692781; x=1763297581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F6A/B+9h+I98s/YXTKbkuHwVutCPQptulwBnbhPRTRk=;
        b=QMgoG7sp7ZCgC1uoTQbOTDfQXJW3FoJY7fIqH3Ow0bZFopTbmsTkmxYCYbhbWElZSp
         Y+TqozfYDBGmo/Ob/johX266OJbtDLJndN+PFmGylivH8t48lsJbh09DmGpNZObMv6Yt
         k4P+jv7R3FxTNYdiMmWpwArzcrfYsYyZUpFzM8DDOK6XsEUZCrLRmd4LSgBijtfe33sG
         6P0QBUgDXweJBQJN8PhT4W4oPUC5Gs8MRQVLzZDaut0BedjwPtiqinwoQ/y58zSr/T+3
         tbMPn+ml83xGMwUbRqOH+Ur5mCwlTZUwwpYiozgL9XPrejql7e7Zw1Xy+w7owxtel4nf
         zDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762692781; x=1763297581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6A/B+9h+I98s/YXTKbkuHwVutCPQptulwBnbhPRTRk=;
        b=Yy7an7f91wqF5ZxkrPqS4oBh+Cd3v2eAGDGmNOtVO99JO0ev2Nz/V0k9TaoO7XYI9D
         fTKlm4/JWfHT2P3WigVWUyG7xU3WHxiAIoBHHvW9WnBmL9roNz/QYSmVYo8U6uLpVt9C
         ntiv4DkZ2Vg0K3yzFBuH2canAzLLwyjhA70WiZigmXJp5yBKNiGBtKwXD3bsJ/2W+wYK
         pk3CE/sdHYThNV2rNtTnIlQUhq2Tm/mdiNU2emYgCc5ZUFUtzeH5ZfHIA4xFpCR6cWYL
         OlkclBCO2KZO7vuvmHwoMZQ9N+DDiLGGh8fHEmeQMro+ikACBUsoelQmooO/AcfDkl5a
         0nbg==
X-Forwarded-Encrypted: i=1; AJvYcCW6L04K8zSiIUretL1EKqL9MXqUPAZocUuboO12RSV2FXO2JzPvDDWo3qiQFkCs4sAfkN5UfFI5XkssIGU4@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa+bAPvOzv20p4aVZKy9bJNVn7kmuzOAeDiVUfJEL7JOvEQdvg
	ttbqq0cGMEip5hyYWBJcoRIlj3Hp+qNQ4z5nb3P0RaVJyPspny1DTcm2
X-Gm-Gg: ASbGnctxpadjiFYQMZ4t7HG96Hxu5g62jI3Pl7uQTlhBLz+CzXrp43fZG02Dqk7cu4w
	n/i/8tR4XbidEGnoRWcmEo1t5/0ZBcIzz6JgpuCoy7bcItZEXfDa1HxE55db6z/PEigJn1dnZz6
	+L0e+0xwcxERybb5il8KG9S8wfwU05EC+KhvDAKHwLUQ/Sm3ezTpoubJzqYNLcv2lUJT1C+yk2g
	y9LAZfeMk4bxH/DVjGHOJhIc5gpYfakcGd1ZdpQFFQdcQH/LI/ICZ2bZlSy2MPM08IXZSK+O/mM
	Rh03QEtdTUMF/IvKmn+oMFuWf5Cg3xb5uN9j1qnxzunytUvYMhgHyiPL7Bj/ofsetSpNhglbNac
	eprCQsKOkS/pGIl3zQEscipEYGBcSrGS3N/1xc7SGn7YbKEYyi0fzEnvjosQk9aUgIGdYPapSJ+
	Og8iE1gyKGlPwi8HPqQ6o2b4vYAfmdA+eIgb6/aLZhq9BD2kUmaOFhCjykBhQ=
X-Google-Smtp-Source: AGHT+IET1KPf2B7oL/QwV+UKZAET/LutOZL+3WDxwucKxa22W1E/RosCqKFp+QL/ZmCkc+0H1lrDlA==
X-Received: by 2002:a17:907:944a:b0:b6d:4f1d:8c9b with SMTP id a640c23a62f3a-b72e047b413mr384785566b.28.1762692780735;
        Sun, 09 Nov 2025 04:53:00 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97d3c0sm822225766b.36.2025.11.09.04.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 04:52:59 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: touch predicts in do_dentry_open()
Date: Sun,  9 Nov 2025 13:52:54 +0100
Message-ID: <20251109125254.1288882-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Helps out some of the asm, the routine is still a mess.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/open.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 1d73a17192da..2a2cf9007900 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -937,7 +937,7 @@ static int do_dentry_open(struct file *f,
 	}
 
 	error = security_file_open(f);
-	if (error)
+	if (unlikely(error))
 		goto cleanup_all;
 
 	/*
@@ -947,11 +947,11 @@ static int do_dentry_open(struct file *f,
 	 * pseudo file, this call will not change the mode.
 	 */
 	error = fsnotify_open_perm_and_set_mode(f);
-	if (error)
+	if (unlikely(error))
 		goto cleanup_all;
 
 	error = break_lease(file_inode(f), f->f_flags);
-	if (error)
+	if (unlikely(error))
 		goto cleanup_all;
 
 	/* normally all 3 are set; ->open() can clear them if needed */
-- 
2.48.1


