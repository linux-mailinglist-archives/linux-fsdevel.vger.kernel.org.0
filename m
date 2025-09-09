Return-Path: <linux-fsdevel+bounces-60631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D043DB4A737
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 11:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBDAB16BE1B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 09:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7702882A5;
	Tue,  9 Sep 2025 09:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HU+Ne10A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF93286894;
	Tue,  9 Sep 2025 09:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409247; cv=none; b=WT2213rYEc9bg/8Oph8TOPKOoQD6+fiYQwJsbvH970xWFO4MIr+NUueyyXLPO25tud22YQPPo7Ezlu2bWvD1a5OMnOaIhS7PLqDlO2kGgDM6I3CWWemWxjMqlrVanZ5SGZc6mFskK1z/KEkSoI7KvxYpHW8r9QSIP55mavF283c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409247; c=relaxed/simple;
	bh=CP3LXTksQglwFNpnXr0hPsTeP7YFtJ0DHIn/IRdimlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EM4c3w0J3F6pcDai1Z6xnWUlwTKlkC3k7boi9isBuo+or+WxI/IuYCLObjnNcGUOGJh3RXk+6FqUMVUFyk5SHjFHOVcZsbsNj69y1x0j+kJyDVqluc1pCQBoL88JrODuE5j060XYRUF6oOw0lYOshdntuREqiyDPsNjYMEm6JjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HU+Ne10A; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45b9c35bc0aso47315965e9.2;
        Tue, 09 Sep 2025 02:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757409244; x=1758014044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/znQVoqdYnguqmx5WBg8gphSRKbnjv7YqaJ0uXheApk=;
        b=HU+Ne10AWk3M61acTcknpNPScgbPCsJKjM4X5/bKZDkZwH+v41pMZTRXFJ5mxlBCGa
         8uRFKXFij1IR02M/3aAmAcp2jpVlxIbEpbFLCQcTGGcrL3VTYFuF0pGFGFmQQQG9aQKK
         FykBNSYvG7HBUClnr6NlsrJseYR/KyyEQ8TzKTC9h7s0xqLxFUanTegyLIFmFAeMTr+y
         STsJ0MQh1889z/qrh7Rrz+qhxPeJXixnq8MdPVADpJXlM4UXbsB7hZFWg0bKCZVCijW2
         S6dUeen/wrEzJC4zqGWTbGlu1X2/7omlvOHB1OwIGR1ny4MgDWbT7vJ8ZidVvuvGBnXV
         4Qmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757409244; x=1758014044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/znQVoqdYnguqmx5WBg8gphSRKbnjv7YqaJ0uXheApk=;
        b=DLX4rp7zmnEa8m4KFcPB1UvVkAI+eujMKhSiI/htaSU3atBKaBjSN38doDGBwY/trP
         v5LlHp8BJoDicCr6la2r+0Gzgq9A89Sk/DdjqcJfECI9FXvCv4UYZNP5fdUW8m8ArN3S
         xQC+7mPIDgRVzTMuepHPw427SpCWjVrxbVdql9KEz7UDUwKiBfovmWsQO+nWwFbc06Sg
         4yiGqyn0i/yN7aYsCDuy2UkwhCwc9zqDXsMuC8TTaLI8zKcQSGBVRmFwf9bE+2kWKtOy
         mLvrPirXuZZTX5ocpRpcJoHkS75cD5oCwH/nmKLgBpyf0HyoeWCft4IUt0mQzaeplV1N
         SkiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEwVSsZYtPecxA37b3oJXcKvat5ayz0uZJBlhEg1zHNI46LRO4DqfH+h+JWwLo7Z7h4AxRLD9cmPLuxA==@vger.kernel.org, AJvYcCWZ+Rv6aci8rbhQh42XHRQXGaWqlBfL3kCDFe+COytYhDRpFuP3dE8L4y3tluORyGkY5fNAHZsvfUrNVw==@vger.kernel.org, AJvYcCWeyHlJs+3XKocDFS+TO5gjRtoR0L60r01pFNKRsm/TIbS+3UJoDy51VvvF/OJQOiKr9QG3IjAR+SSq@vger.kernel.org, AJvYcCWqj7MkCA/a/JADTdzigyRXTJULiPpjvAgRK7VPZ57fVvz/FAifL4BmirkioXWDWIAPjvSGz6OEVXElxm0/4A==@vger.kernel.org, AJvYcCXXR6tLpHqUtXyue+vaAKM/AXZZpvfQmWbvDeeW+3gPSRIIH0dXgZJVEfjqKqdv6CM+r3L3JKFNAoe/GwXO@vger.kernel.org
X-Gm-Message-State: AOJu0YyJXwxWVKq7ytan3fryqvptP1fnw80Zw6Bnd36HSeQlEDHVz3v4
	cCeD4fyZC71MtdXmLJ52bv8a8ZrkxC6O8lcRKEXGqwH/weLS/m9uFl6E
X-Gm-Gg: ASbGncvkyPZhIOy5BSsjfg2SA/VXCJ45975YkEj9Zvna9Bqcy98+xOiT6gi9Z3GaUg9
	UkyOgPyQDpC6v+fScGDhdnWDebIrbHetMW+S/JT9aapbLABvE5bMQ3B9tjy8rz52ci7FKMD+ib+
	TUiF8xmNcjU2q2rIerhY7dNcQtnDVPwyQOvzS7pdUg4nDVNLeiMxl9Ht1iD4gq+GZh6uEf+Jfbm
	zJLw+gubPM5SNInbka6CrVXLVsgSRRo4F/EVxSmfs2McoNJachiPOMFKwxWmUQAbFh7PSHtEoHA
	h8AeDWa1zakYhswVZDMmLWhsOtLqgHVk/YBUTxULpM/VhfgwiEujP1jMmUBvmuC+dJx0BQKRIgh
	r0SCgf1InWcvtpNqJOy1y8fjd160uTIkNKdCTmJcl
X-Google-Smtp-Source: AGHT+IGumv6hXX0Ye+Kc7ZPtdtCMonFUD7y5t+JsaAGWTiBx9lCNtXy0TEMvDq2v7tSN4bX9gzdxAg==
X-Received: by 2002:a05:6000:1445:b0:3d0:820:6822 with SMTP id ffacd0b85a97d-3e637465d1fmr8289240f8f.22.1757409243864;
        Tue, 09 Sep 2025 02:14:03 -0700 (PDT)
Received: from f.. (cst-prg-84-152.cust.vodafone.cz. [46.135.84.152])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521bff6esm1810784f8f.13.2025.09.09.02.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 02:14:03 -0700 (PDT)
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
Subject: [PATCH v2 01/10] fs: expand dump_inode()
Date: Tue,  9 Sep 2025 11:13:35 +0200
Message-ID: <20250909091344.1299099-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909091344.1299099-1-mjguzik@gmail.com>
References: <20250909091344.1299099-1-mjguzik@gmail.com>
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


