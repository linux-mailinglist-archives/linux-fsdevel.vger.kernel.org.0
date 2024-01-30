Return-Path: <linux-fsdevel+bounces-9568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C30AC842EE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 22:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55892B22A43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 21:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB12A78683;
	Tue, 30 Jan 2024 21:49:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F182125D5;
	Tue, 30 Jan 2024 21:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706651362; cv=none; b=rh6Lk1RRHI0W+0go6N7Rlh4KGDnleG/wIBWI/15DlBU6r5USpNZQiwsjnWxsqvyJnlMj39B7akWKodKc86b0fZzdWB7dBrG+tf1somwr/i5EOgsLNBPTaqjDtT4mAr08qcmtwRKi1FSz07khgUF125JqWg8gPKnxaUibpCNMAEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706651362; c=relaxed/simple;
	bh=vmVbuBLGGmJbLqBdsBZlsxO+r+HBPr9plIctCgmEjYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KtIrkzFgaXedtf9yLbdWtc+5e2NQUHX48SmrqQToWjAC4YqAZUkT1Vd/ySBpxoEVEk2gf9Yd8BUO9cRN9Xa20xX5brJCquWXCT3JdEaH4zmqo5ogMkvKlwQRKeF4uN/fQZbL5CRl4ku/W6dpoHGX2bZqGudfKAHdAno5Jsk2pVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-595aa5b1fe0so2771094eaf.2;
        Tue, 30 Jan 2024 13:49:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706651359; x=1707256159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zk+B25u0to8P/Oq1qU35ckd3D9fSBALYYrjdMtzmKns=;
        b=hcQofI3fpjH786fyu+DxEE/WMPzIQUghGstA6gRJib/xXk1sgHeArt5yjC/QLC3Oid
         uXrv1LRtXawd6DC7ZmoILNPb7LJ6PsemIVXwVLdguLdgqqLsf/ExzFMtVPzL90FIY33y
         aFdqeBWJTQ5phobyhwQw3HDAghO+Jc+gXxlPUOAJ+eCR5qYZEe32UsW3YlyzD6mMMIME
         +8jQ3qh9Uu8HjyjEKdplFu943wdgKMplfIjGr4ZYKFdJFGFz7O7vssguc7rENFBOXesK
         k+1lgI1wQTnhnWjb3N/PvHNgtjJv8oFW2OEMAKJZk4znVQgM5lAXNf5NwY4hqQeqQUzT
         8V0Q==
X-Gm-Message-State: AOJu0Ywq+mYkeEjyEK8RkHmzGiswHiHl7qyvQEDaILJ9UsaEL0FPrgmb
	J4p/ZMte2z4q+N7a6wabwmAvRFCuNUjZjbL1rb3TE6uToW9EDJJl
X-Google-Smtp-Source: AGHT+IEbguL5PeS7i+fz7eVU5ysuggPugK9Nh4w/EyBtzLtv3ghZ92x0b0io5eChHYp8mpZO4X1Lhg==
X-Received: by 2002:a05:6358:180c:b0:176:cf18:d0bb with SMTP id u12-20020a056358180c00b00176cf18d0bbmr11545173rwm.13.1706651359049;
        Tue, 30 Jan 2024 13:49:19 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:f45c:fd18:bfa0:e084])
        by smtp.gmail.com with ESMTPSA id k14-20020aa7998e000000b006db87354a8fsm8285597pfh.119.2024.01.30.13.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:49:18 -0800 (PST)
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
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v9 01/19] fs: Fix rw_hint validation
Date: Tue, 30 Jan 2024 13:48:27 -0800
Message-ID: <20240130214911.1863909-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240130214911.1863909-1-bvanassche@acm.org>
References: <20240130214911.1863909-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reject values that are valid rw_hints after truncation but not before
truncation by passing an untruncated value to rw_hint_valid().

Reviewed-by: Christoph Hellwig <hch@lst.de>
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
 

