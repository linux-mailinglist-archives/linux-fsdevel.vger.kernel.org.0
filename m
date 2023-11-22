Return-Path: <linux-fsdevel+bounces-3408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E63357F4628
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 13:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E64D21C20A53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 12:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED79A4C62E;
	Wed, 22 Nov 2023 12:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuGNx7Yf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD495D7E
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 04:27:30 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40b27b498c3so13588095e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 04:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700656049; x=1701260849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YXJnavEvyqTVLwl+pbbW2xACRDZ3E2hP4AVvMZfR94=;
        b=MuGNx7YfoiG34rHJcZdvcKDu4etFJXQ5s9uq/BND5YHOmok9XS2evg5qksURQraBuP
         7YMxDPWddPxnX8Vof0Kl60q4N83OSeDI8GYybwV7d8SqIu0R2UhCK2q+tRJFyv4WIBJB
         wja+CoDdd2pzQzrwhUNnuIwC1hb19CBEkuXJRsDOmP/3aTjzb4ckg2HL4Z0sNo5WEGAr
         7X49Ni+DOFdsjB3EKBWfrmEHB8j43QWvVhFgzq7cPLTMknXKtbDg6//qHCydt6r/6CL8
         ltGlSRJjTF81MIzZ0TXm0MINJ7EqV5URmugJrSB0e9lSRhHliwVEdS6qjEvPHWhMnl82
         aWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700656049; x=1701260849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8YXJnavEvyqTVLwl+pbbW2xACRDZ3E2hP4AVvMZfR94=;
        b=ejH7whw9ZIrI67nLiY2ENi9VTaeMk3ePwHcbWk3gNzCG5wLhPiT9zCFViciuAvaPa4
         GsWL9hH/cNC+x3kF760aVG2q6D1ZxJ4rTQZwXXbQsUSiFmDgcB0E0NZmEI0fcKTPirQI
         UZG35BdeTUYwtSWqaUEigm7l/OPIMeXn5jH+wIgFyO5QDjWGk6U4HhjkQ+1zlNgTaauS
         imITmQGkQ3tJzX2JeBuClnG+9VyR0/B3kFNroOJifQFDFd9v+h+iTa+3HBhp0/ceqz62
         aDI3S5e5ylaDTbUMa3DWO2SMx/tRJFLjD59bDjelGzz8H4AH/QxcQIqA+abPMZRmgu45
         sc5Q==
X-Gm-Message-State: AOJu0YyqTtX+MSRJjTm9LXO2m1ENvtbxqCFM9KnQuG9tW/BSETYqaYrb
	27G4yqFB38CaOb54t3EGHHU=
X-Google-Smtp-Source: AGHT+IFGJuzxMweAc5o/1H5HCkmTHUulb5IJTfUUSsVaQfU9k7Oc08xaROer/w4SnGFCUFtJ4CyfHQ==
X-Received: by 2002:a05:600c:4695:b0:40b:3056:7420 with SMTP id p21-20020a05600c469500b0040b30567420mr1213580wmo.39.1700656048957;
        Wed, 22 Nov 2023 04:27:28 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c154e00b0040588d85b3asm2055556wmg.15.2023.11.22.04.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 04:27:28 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 06/16] remap_range: move permission hooks out of do_clone_file_range()
Date: Wed, 22 Nov 2023 14:27:05 +0200
Message-Id: <20231122122715.2561213-7-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122122715.2561213-1-amir73il@gmail.com>
References: <20231122122715.2561213-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In many of the vfs helpers, file permission hook is called before
taking sb_start_write(), making them "start-write-safe".
do_clone_file_range() is an exception to this rule.

do_clone_file_range() has two callers - vfs_clone_file_range() and
overlayfs. Move remap_verify_area() checks from do_clone_file_range()
out to vfs_clone_file_range() to make them "start-write-safe".

Overlayfs already has calls to rw_verify_area() with the same security
permission hooks as remap_verify_area() has.
The rest of the checks in remap_verify_area() are irrelevant for
overlayfs that calls do_clone_file_range() offset 0 and positive length.

This is needed for fanotify "pre content" events.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/remap_range.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/remap_range.c b/fs/remap_range.c
index 87ae4f0dc3aa..42f79cb2b1b1 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -385,14 +385,6 @@ loff_t do_clone_file_range(struct file *file_in, loff_t pos_in,
 	if (!file_in->f_op->remap_file_range)
 		return -EOPNOTSUPP;
 
-	ret = remap_verify_area(file_in, pos_in, len, false);
-	if (ret)
-		return ret;
-
-	ret = remap_verify_area(file_out, pos_out, len, true);
-	if (ret)
-		return ret;
-
 	ret = file_in->f_op->remap_file_range(file_in, pos_in,
 			file_out, pos_out, len, remap_flags);
 	if (ret < 0)
@@ -410,6 +402,14 @@ loff_t vfs_clone_file_range(struct file *file_in, loff_t pos_in,
 {
 	loff_t ret;
 
+	ret = remap_verify_area(file_in, pos_in, len, false);
+	if (ret)
+		return ret;
+
+	ret = remap_verify_area(file_out, pos_out, len, true);
+	if (ret)
+		return ret;
+
 	file_start_write(file_out);
 	ret = do_clone_file_range(file_in, pos_in, file_out, pos_out, len,
 				  remap_flags);
-- 
2.34.1


