Return-Path: <linux-fsdevel+bounces-4296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A00A07FE6F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 03:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D10A11C209B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 02:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD9D134B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 02:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FEA170A;
	Wed, 29 Nov 2023 17:33:32 -0800 (PST)
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5bcfc508d14so372983a12.3;
        Wed, 29 Nov 2023 17:33:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701308012; x=1701912812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aiBO6Tfcfmapi0KtPcDAbnGaOP6QP7emo+YH2VfT7Uo=;
        b=L8OvxMufFteQacMhZU9Fh4oeCac/i3epWbFZQYdvnRXA5czoT/eIxlL8TGlbCgEAe+
         vzIcMF3B2JL6eDV8Vb8OmdpVrhDGjAluhpEaKNNkIaomjyt3G4S346/nrUtnAiJvbfQQ
         OVmpKEWW6cfsHld4P68LPpX2wbqt2WZx/GWT4CJYWPjsssZ7FHooIoiiOdviMBp3rE+o
         yuQyJJttrtUc4UaMs7M6yiczUYdqTEU9muy6XNtfnTwNJctPr10jxodT61yTKWnB9n/5
         qLfIRetfp8IHgQHSixaXuyYmqIOXrkW9CXo8CmotDHvOWZiqfQTCy214c0H4v97FBfYt
         +/6A==
X-Gm-Message-State: AOJu0Yy9j77ROSif9QWZbV1slq7aUg5QP1kOla6tZ+tSzbnUqdc3bpR+
	5JFsapwGRoK5Pr+nWGtir1jcaExIaRiJtw==
X-Google-Smtp-Source: AGHT+IHr8YOy7bgizrhgbpTs6tWdN7ASweQPkN5KiwH79oPVcY31DwLt+hrKumJWhW/dENd+Jidoyg==
X-Received: by 2002:a05:6a21:150b:b0:148:f952:552b with SMTP id nq11-20020a056a21150b00b00148f952552bmr27881820pzb.51.1701308012243;
        Wed, 29 Nov 2023 17:33:32 -0800 (PST)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id g4-20020a17090ace8400b00277560ecd5dsm2021936pju.46.2023.11.29.17.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 17:33:31 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Daejun Park <daejun7.park@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v5 01/17] fs: Fix rw_hint validation
Date: Wed, 29 Nov 2023 17:33:06 -0800
Message-ID: <20231130013322.175290-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231130013322.175290-1-bvanassche@acm.org>
References: <20231130013322.175290-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reject values that are valid rw_hints after truncation but not before
truncation by passing an untruncated value to rw_hint_valid().

Cc: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 5657cb0797c4 ("fs/fcntl: use copy_to/from_user() for u64 types")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/fcntl.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index c80a6acad742..3ff707bf2743 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -268,7 +268,7 @@ static int f_getowner_uids(struct file *filp, unsigned long arg)
 }
 #endif
 
-static bool rw_hint_valid(enum rw_hint hint)
+static bool rw_hint_valid(u64 hint)
 {
 	switch (hint) {
 	case RWH_WRITE_LIFE_NOT_SET:
@@ -288,19 +288,17 @@ static long fcntl_rw_hint(struct file *file, unsigned int cmd,
 {
 	struct inode *inode = file_inode(file);
 	u64 __user *argp = (u64 __user *)arg;
-	enum rw_hint hint;
-	u64 h;
+	u64 hint;
 
 	switch (cmd) {
 	case F_GET_RW_HINT:
-		h = inode->i_write_hint;
-		if (copy_to_user(argp, &h, sizeof(*argp)))
+		hint = inode->i_write_hint;
+		if (copy_to_user(argp, &hint, sizeof(*argp)))
 			return -EFAULT;
 		return 0;
 	case F_SET_RW_HINT:
-		if (copy_from_user(&h, argp, sizeof(h)))
+		if (copy_from_user(&hint, argp, sizeof(hint)))
 			return -EFAULT;
-		hint = (enum rw_hint) h;
 		if (!rw_hint_valid(hint))
 			return -EINVAL;
 

