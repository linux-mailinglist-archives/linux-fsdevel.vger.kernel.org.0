Return-Path: <linux-fsdevel+bounces-4156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE967FD0FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 09:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 297BF1C20921
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 08:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFFA125AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 08:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BqLTFAPS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E201735
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 22:46:37 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ce28faa92dso49491315ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 22:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701240396; x=1701845196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RyxKGsDDmionjo2B8miY6iT9daY13roQZ6KjJIz8GxU=;
        b=BqLTFAPSs6vp7tZc5N6YUjK1ZFb6s3/RIiG8FWvjZ4ukzi2F1RPfAgpmzYe1O0SLSU
         tjlC4ueVlMBnIyVQcoLn3/Ik+DmtrghSr2JZR23BnAnPbHGdoK/jDLWb+/C2paWE3D4a
         olLvC79OLcj6ii24mtsqJz4kXaqurnCpgzSik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701240396; x=1701845196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RyxKGsDDmionjo2B8miY6iT9daY13roQZ6KjJIz8GxU=;
        b=Hnu6TlQDRnLCnwoGP2vch8BvsTPPqSPBBxvaBkBOyiXjHLYdrX0mGSPSL874Ngr79M
         gvWC4LqcOFsBCuP6HWuRup2ix8DEVSRapcf/7KnAi3IwZLwLVEerNaBC2aAnrowS1LNb
         oHhYnolSAkJo8+ypdI0Ck8vw1niql5ZFe7UeG+OSBfzFGDA82Fu+Wfb73H8LPrRSV/8L
         JxQazeGFRpFOekhYigb0odAaTsg4cl9oR7174zkDEb+UZ5NtGTepRhPX1/jZfst0Rovh
         yeHg/g8bsN4Za+682JJBXKMm3JmgeLXA/RlMBXMsnMAvLRsXM0S1pAozI9up3Y68KOEu
         WEGA==
X-Gm-Message-State: AOJu0YwUrbXJtnyoDRc04Wlnhj3+EsnxE0BcDJWT9Re9sZJ77Nu2BIOS
	vACvAkc78g0PLNbCjGHo8PBOHN++1uNpI1IuScGe
X-Google-Smtp-Source: AGHT+IG23nU4vS1DYp5SlYmmlq7+8C9LOr6OEIhmtL9SDb8Kwd2Yx1xArFoilngLPfE1+7D2X/qp6Q==
X-Received: by 2002:a17:902:e552:b0:1cf:fe32:6319 with SMTP id n18-20020a170902e55200b001cffe326319mr4506271plf.53.1701240396455;
        Tue, 28 Nov 2023 22:46:36 -0800 (PST)
Received: from yuanyao.c.googlers.com.com (0.223.81.34.bc.googleusercontent.com. [34.81.223.0])
        by smtp.gmail.com with ESMTPSA id ju12-20020a170903428c00b001bbb8d5166bsm11463203plb.123.2023.11.28.22.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 22:46:36 -0800 (PST)
From: Yuan Yao <yuanyaogoog@chromium.org>
To: bernd.schubert@fastmail.fm,
	yuanyaogoog@chromium.org
Cc: linux-fsdevel@vger.kernel.org,
	miklos@szeredi.hu,
	dsingh@ddn.com,
	hbirthelmer@ddn.com,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	bschubert@ddn.com,
	keiichiw@chromium.org,
	takayas@chromium.org
Subject: [PATCH 1/1] fuse: Handle no_open/no_opendir in atomic_open
Date: Wed, 29 Nov 2023 06:46:07 +0000
Message-ID: <20231129064607.382933-2-yuanyaogoog@chromium.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
In-Reply-To: <20231129064607.382933-1-yuanyaogoog@chromium.org>
References: <CAOJyEHaoRF7uVdJs25EaeBMbezT0DHV-Qx_6Zu+Kbdxs84BpkA@mail.gmail.com>
 <20231129064607.382933-1-yuanyaogoog@chromium.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, if the fuse server supporting the no_open/no_opendir feature
uses atomic_open to open a file, the corresponding no_open/no_opendir
flag is not set in kernel. This leads to the kernel unnecessarily
sending extra FUSE_RELEASE request, receiving an empty reply from
server when closes that file.

This patch addresses the issue by setting the no_open/no_opendir feature
bit to true if the kernel receives a valid dentry with an empty file
handler.

Signed-off-by: Yuan Yao <yuanyaogoog@chromium.org>
---
 fs/fuse/dir.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 9956fae7f875..edee4f715f39 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -8,6 +8,7 @@
 
 #include "fuse_i.h"
 
+#include <linux/fuse.h>
 #include <linux/pagemap.h>
 #include <linux/file.h>
 #include <linux/fs_context.h>
@@ -869,6 +870,13 @@ static int _fuse_atomic_open(struct inode *dir, struct dentry *entry,
 		goto out_err;
 	}
 
+	if (ff->fh == 0) {
+		if (ff->open_flags & FOPEN_KEEP_CACHE)
+			fc->no_open = 1;
+		if (ff->open_flags & FOPEN_CACHE_DIR)
+			fc->no_opendir = 1;
+	}
+
 	/* prevent racing/parallel lookup on a negative hashed */
 	if (!(flags & O_CREAT) && !d_in_lookup(entry)) {
 		d_drop(entry);
-- 
2.43.0.rc1.413.gea7ed67945-goog


