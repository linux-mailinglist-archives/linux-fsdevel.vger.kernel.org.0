Return-Path: <linux-fsdevel+bounces-60876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A51B527DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 06:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6C5B7AF378
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 04:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C259425487B;
	Thu, 11 Sep 2025 04:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTb2Cf4P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899AB248F72;
	Thu, 11 Sep 2025 04:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757566574; cv=none; b=e+WSfQQP3aLCNU6k364TBq4Cn8eWsbr8vX0fsFi9GyYk86hyt8xibVT0SFfDxfUKIExbK7IN/vQ9tfVynje8+6EOpwUZS4T540XCOA4Y3cXuuye00ZGUewvIt3NZ+GXf0VtQRl4JSkfE2bzMHLF5Hi7OUv0Cd2FsTb3WmBVskGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757566574; c=relaxed/simple;
	bh=CP3LXTksQglwFNpnXr0hPsTeP7YFtJ0DHIn/IRdimlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VCjhnnzKeIHzaJEuh2A5y5++1u5d6HKVpjtRiMuUlzfkxbKBPkY1U/Fc/ME1cXI3KqceAAOeTjDo3z7E6L6H3xkGFdLAdCWqiDMHkamth/WZVoOke/XR7KGPKDmg2gDO9GvnomVajQDy+gOyM/gzaf2PRmGgKY5fXcp+Q+evIpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTb2Cf4P; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45cb6180b60so1667845e9.0;
        Wed, 10 Sep 2025 21:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757566571; x=1758171371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/znQVoqdYnguqmx5WBg8gphSRKbnjv7YqaJ0uXheApk=;
        b=WTb2Cf4PmWTbVkQoUzX0+Uef3EKEBv88yQpHVXuAqPz5qYmIXWQOtUgm8Eh9CvUkHP
         8wFPfrgQ/i35W5FAf7+SVcqKRTHmlp+VJI+Ek/RCbzL1x9LGBNsoo5RuleXd+Le01Acq
         3XifXX9x6/jfub+9mtbeWf8fLWEKgA7wHj3gRTulzOIMXFZFgrMQJ+6UU3u+mX7+17yD
         dpkuBfY2bxQqpv5yPf7opnyVpp9FNE2eNbSbnEmIv++zvZLFk+kWNCA3KNTAkKRSBAxA
         rhSKzkGhXIR3Yxx7EcfY28igevFqvcRGmTR0VzEqfd1vbefjLrBY36AH4c305EBp16iS
         yNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757566571; x=1758171371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/znQVoqdYnguqmx5WBg8gphSRKbnjv7YqaJ0uXheApk=;
        b=MK9/f+62PIcWMgf7z3nkBEh/xcZ53oDamUVHTnT2KWJUm6vxIWmQe4Jw9pqCxqQvgs
         71gRE9H4lkdP6ezsbIeebAlx7tFQtHLylIrYzwSz42T5mf2pyA0kjdQw0StHiXj0gYYL
         CbMMp0miAxYwbyKNQVfhWzCm5PsGzpNIIwBCz9ugP+bmxVYD/itYr5af+F8pFthS1uuh
         6nHYftgqzkm4IDfHHB8bi6IIyOr49Kafp06dHhQtj4YU+kRdq7E/Z8vcA8bdRZ/umaeY
         T+ZrVpzdIS0AUngm1CUW45ON8CyY8cyCjiQRfOdZkAzR1t5tVuOVT5vywNKZmIBrR1hz
         Qs1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUS4w6e5aje1jt/9zEQkaFgSCLo6pCiG7/eCm2F1TGIVQcmOG8JgE5RqEa80AHEuQ0ESzb2Hsz/un1j2w==@vger.kernel.org, AJvYcCV8jXa2g4BT+KVsZ39TRDCXv8EWjz6HWzgOC6CU10aHqWo4mMbJHmj/GcvzwJiX40qCjZnBEmUkRrZhNxky7g==@vger.kernel.org, AJvYcCV9V+LfDMSB4bmWUWIpO9MV9UG/wpNHyTR5ZqT21iGN+wOi3zlvbbkBqyaUS/SQmMcbcP+NXj20kZ7QiQ==@vger.kernel.org, AJvYcCVU3PfbADvBIffriit8H02qTIMTxMw1+px8hOp35BJ4oi0I5Ej6Z8s62NKwS7HejgDTMk7xUDVwCmWl@vger.kernel.org, AJvYcCWDtHxZ9+dymG9nyS8l0H/+i6BCNKs/tf/h4sUxepurEF0Rpa0Fqy0M7CQJd9EIyFBFOEA5lzM6DJ4d/nGY@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6zM3WiYXzk9JHYtQp1uQGHCtkusEslaQ532YkhGUfwk3qKeje
	BwTkEjp7J62KukCDAx18kOKnk1YRqTHKK4DIlbWBSdgmVIQO7q1dwdzT
X-Gm-Gg: ASbGnctySV8ojlqFNMpCw+q/y1mDRorS0pdy4HcV9rglRkZ+FvAaz3X50Tlxuifw0GX
	PGGwcYKCvfSjH9WkdFgJokyGLa90X1zXBxDy4Qa8jN9C/Mbuhb0N7w9Uf62XsWHe8p/ig4VA/h5
	PQh9GZYCnMqZXPgGCOXYdDm5Zqgkvb4LVDCx/8k02PVfwPhwjHrOMOm7QoKL8k/LtshswsF47BS
	rM0UgAzRytAzXsMHhRXfoK3p/MMcBeIeufnGD8rH9fzujt7oECVpY7JHAau5pet0ZBlGqJZ2W8l
	rsxXrmxL46WaSkctGG9aftR/e5ZkNgY3T5abZ79ktGUGuKcemODcQumvfS1/mOdbw3f9Sc6vM4G
	QSHuZgKmxO8L1P3WxsC2mw45IoMAmqpmzTJlVfF4t
X-Google-Smtp-Source: AGHT+IE+08c9X5HobyMLxXhZ3NFl5GxQuz/7iatm7LXGN82shDvsjXSG1iJZArieNMj/KCrR4Zsqig==
X-Received: by 2002:a05:600c:1f91:b0:45d:d5df:ab2d with SMTP id 5b1f17b1804b1-45dddeef92cmr155477075e9.26.1757566570508;
        Wed, 10 Sep 2025 21:56:10 -0700 (PDT)
Received: from f.. (cst-prg-67-222.cust.vodafone.cz. [46.135.67.222])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607e9e6asm889419f8f.62.2025.09.10.21.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 21:56:09 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com,
	kernel-team@fb.com,
	amir73il@gmail.com,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3 1/4] fs: expand dump_inode()
Date: Thu, 11 Sep 2025 06:55:54 +0200
Message-ID: <20250911045557.1552002-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250911045557.1552002-1-mjguzik@gmail.com>
References: <20250911045557.1552002-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds fs name and few fields from struct inode: i_mode, i_opflags,
i_flags and i_state.

All values printed raw, no attempt to pretty-print anything.

Compile tested on for i386 and runtime tested on amd64.

Sample output:
[   31.450263] VFS_WARN_ON_INODE("crap") encountered for inode ffff9b10837a3240
               fs sockfs mode 140777 opflags c flags 0 state 100

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/inode.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 833de5457a06..e8c712211822 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2935,10 +2935,18 @@ EXPORT_SYMBOL(mode_strip_sgid);
  *
  * TODO: add a proper inode dumping routine, this is a stub to get debug off the
  * ground.
+ *
+ * TODO: handle getting to fs type with get_kernel_nofault()?
+ * See dump_mapping() above.
  */
 void dump_inode(struct inode *inode, const char *reason)
 {
-	pr_warn("%s encountered for inode %px", reason, inode);
+	struct super_block *sb = inode->i_sb;
+
+	pr_warn("%s encountered for inode %px\n"
+		"fs %s mode %ho opflags %hx flags %u state %x\n",
+		reason, inode, sb->s_type->name, inode->i_mode, inode->i_opflags,
+		inode->i_flags, inode->i_state);
 }
 
 EXPORT_SYMBOL(dump_inode);
-- 
2.43.0


