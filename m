Return-Path: <linux-fsdevel+bounces-8517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C73838955
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 09:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F48328BA30
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 08:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B794E56B88;
	Tue, 23 Jan 2024 08:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e3fi1ACM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AA153812
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jan 2024 08:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705999424; cv=none; b=Ra6IqH0em/1J8hrJavxvXd3UrMTSE6oav36tYtXhN6wwHL9e+8EwzrGUV9xNoz5noieDcJYJNGuSLwIZpr+YQyVKyRl0+MXJDZIt6Po+owsyf0E2TgyUbf/WY9pwMkdJhZHkPUjLxTUco1q21tRb7nO0rLxhrA9UrVfYGA1Wb/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705999424; c=relaxed/simple;
	bh=B7PssBOICoFvPqIqe5On2XOkFBaVN+2Gu3JrcNpc0eE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RCNNA2uOjDG+G1VlCrtrN+CIp7zDz05AoJKCXJAekSzLCxWxM32UTyP11lXKXg7rfZhQunJqXAD7hh2KjlWhV2avvvabsVKPfqQX67YFUDl8A96fNcTuztMPiMJifmoxVLKoE0XqhAQdJq4didALPWynfYozVVoecF4tz8SiVcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=e3fi1ACM; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d746856d85so10267265ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jan 2024 00:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705999422; x=1706604222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+S82JcQ77wXurvtSuZs9kIC3sCK0bQARyKU0OrPqvY=;
        b=e3fi1ACMh7eYHGf3Lv1aEfsoXhLkwPLVCRkI40nWXKB6bIJ3DIkGU8jsxmaGg5LC0s
         x3ObHCsYlhEQIHLjAFfcqSXUik5qiZjLP7n6mTLZHdXHp5nfnwk7puszAdTKPgTRBq+5
         6pTPTY6Q+glaziN0REoMdjDDOFKPONYuQVs3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705999422; x=1706604222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H+S82JcQ77wXurvtSuZs9kIC3sCK0bQARyKU0OrPqvY=;
        b=a0x8ImyTVHRGW/AbL+H3B0f4v6dxgbHRv+rALw7iCov0Ditw4GYAhRc13XWaLfcMkl
         gK0K7W1bA+gMI0rCxYn/erKb9VhudP6+MuBt5krMdDLZlJ7lTyUPCZWgu+ATWiu+NUA4
         TwXMBM/dTH9lwaMV17pRjcHgVUpZUrGyGNRYeqMCzN2d8YiidQCvzUa+haPXE+GPwLua
         QvN1ZCKYKIXo/d6MzSoKoanBnaoQlT9T1C6yeWHyUWZG6/W56hD3N4+NhhgwGSrHEfo8
         68LgLa7MfdYzYw0ACQGNijxB1pxuT4+VvLvhWQ71Ea+lwOKfDVRJEFxJe6CzldlUpHAV
         fw/A==
X-Gm-Message-State: AOJu0YwPDioDej8mUrO4lQni0MuxyLce17GISfij40bWo//79Kn+HzOJ
	LxKDH2rK3f9dFbjCmfmubr7vGx87+pm6txvJEFYwIoMPYb9IUv3U486dioL3
X-Google-Smtp-Source: AGHT+IEmWnMs8SorwD58InSy4V7znbni1y6M5n9s84hmNAP6xE1Tz8pmUde7OAux5WZib+FTp6rWiQ==
X-Received: by 2002:a17:902:8c84:b0:1d7:1c89:a622 with SMTP id t4-20020a1709028c8400b001d71c89a622mr3000465plo.48.1705999422303;
        Tue, 23 Jan 2024 00:43:42 -0800 (PST)
Received: from yuanyao.c.googlers.com.com (174.71.80.34.bc.googleusercontent.com. [34.80.71.174])
        by smtp.gmail.com with ESMTPSA id q12-20020a17090311cc00b001d6f7875f57sm8383232plh.162.2024.01.23.00.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 00:43:41 -0800 (PST)
From: Yuan Yao <yuanyaogoog@chromium.org>
To: bschubert@ddn.com
Cc: bernd.schubert@fastmail.fm,
	brauner@kernel.org,
	dsingh@ddn.com,
	hbirthelmer@ddn.com,
	linux-fsdevel@vger.kernel.org,
	miklos@szeredi.hu,
	viro@zeniv.linux.org.uk,
	Yuan Yao <yuanyaogoog@chromium.org>
Subject: [PATCH 1/1] fuse: Make atomic_open use negative d_entry
Date: Tue, 23 Jan 2024 08:40:30 +0000
Message-ID: <20240123084030.873139-2-yuanyaogoog@chromium.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240123084030.873139-1-yuanyaogoog@chromium.org>
References: <20231023183035.11035-3-bschubert@ddn.com>
 <20240123084030.873139-1-yuanyaogoog@chromium.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With current implementation, when fuse server replies a negative
d_entry, _fuse_atomic_open() function will return ENOENT error. This
behaviour will prevent using kernel's negative d_entry. The original
fuse_create_open() function will get negative d_entry by fuse_lookup().
And the finish_no_open() will be called with that negative d_entry.

This patch fixes the problem by adding a check for the case that
negative d_entry is returned by fuse server. Atomic open will update the
d_entry's timeout and call finish_no_open(). This change makes negative
d_entry be used in kernel.

Signed-off-by: Yuan Yao <yuanyaogoog@chromium.org>
---
 fs/fuse/dir.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 4ae89f428243..11b3193c3902 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -843,8 +843,15 @@ static int _fuse_atomic_open(struct inode *dir, struct dentry *entry,
 		goto free_and_fallback;
 	}
 
-	if (!err && !outentry.nodeid)
+	if (!err && !outentry.nodeid) {
+		if (outentry.entry_valid) {
+			inode = NULL;
+			d_splice_alias(inode, entry);
+			fuse_change_entry_timeout(entry, &outentry);
+			goto free_and_no_open;
+		}
 		err = -ENOENT;
+	}
 
 	if (err)
 		goto out_free_ff;
@@ -991,6 +998,10 @@ static int _fuse_atomic_open(struct inode *dir, struct dentry *entry,
 	kfree(forget);
 fallback:
 	return fuse_create_open(dir, entry, file, flags, mode);
+free_and_no_open:
+	fuse_file_free(ff);
+	kfree(forget);
+	return finish_no_open(file, entry);
 }
 
 static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
-- 
2.43.0.429.g432eaa2c6b-goog


