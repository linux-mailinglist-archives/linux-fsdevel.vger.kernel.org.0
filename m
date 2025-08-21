Return-Path: <linux-fsdevel+bounces-58678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6BAB306F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 665A9640687
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 20:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250B0392186;
	Thu, 21 Aug 2025 20:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="0EALgZJc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20673391958
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 20:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807681; cv=none; b=MuT0vwiuiseux1NRHUpkMm+vgABcESXFHerzXMLydKw4a1VtN6H6jWBv7d+/cCOR9jxKkzICNX5m4MPoXdIICtS7WrJOxLREfGh/UUiA4QPPy62qRC30/dNmCd95fXeNN6oAt0BdX8ptfQ5fTyrJApSFa2i9N3hPEIQMw6YdSJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807681; c=relaxed/simple;
	bh=BVFzQz5MM2vwh8WuHoPp+aDwxtfF8jTQaeq36xEpnFM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BsRNe3gutNmxaBGwN/CdGV/i5VVjOS2hf8hKpg9Uj/JF2fFhhvHgyeacYuSryGyg5LvzgekZDjNiaSwWvJ1KSDBDxceMWeZNkg1bicAD4+Za2R2v5N3ZCfegE50yEDxhUEL2LUJy/l/f22VE0P7rcBZWPJShxX1DSeo+TSbHWLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=0EALgZJc; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e94fc1e693fso1482651276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 13:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807679; x=1756412479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OJwH/2/AGfycifeN3K6mTcfvLjDiixS7hIcYHA0w3vE=;
        b=0EALgZJcGmEUK0G5O4pBhDWjcwtTiKu+ML1PFtFlnWJLRWnwJbMhtD7NKzAGLKSRyI
         2i2/21mj1G9SYs9Z52Gl/A03sJnpqd2vBA454oH5a0eECCXsjdVFRaveguTqQPLgXAIU
         As14Ad4hYniOV7Q/TitFvLF3BntzNRuAPcAjvWFHPffde6td9E82QvN/Z/F+LBuMDnz8
         KFq6dLUDp0aHPE1Qn1w2K0Gb12INRu2JLYIwaYgTYR0173ITncGGhgZefOjLFgsDoiT5
         pbnfUwmw7IN4vbBg4GJ6hd1qYtTfHIVcrnPRCqFGccfNWl9yM/741WuqSNMz3/IexkdE
         hcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807679; x=1756412479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJwH/2/AGfycifeN3K6mTcfvLjDiixS7hIcYHA0w3vE=;
        b=HJR3bJ2gtBkcIZ9yCD/nfgDoEGGNCs9KYyxtqFxOPjkKrjAhuDP43em1npqJPGAZdW
         vZhK+8/mSWgbosGzRYR1hmLzl4EpStOL+eKLwpwpf7/yLtbxy6nCIOEP529nfsHa5wjw
         YR2AtkBUbILvaj17e761W2lT+pxkfwFvIFsdfc00mSQsOwQ8nJVv7ARHrCiWhu4mHIqr
         Tpi4xAcVM1BzePZWgsSTQR6fDdGPM5I0T79yyRQJU3wVt25agmPsqAGyIZyCHCNIn2sy
         XzCxcg24JgR2ot50gZq0bjPi5e/i39DRdWsbXMmJZSo+GLlAMzc6LZvLlZFFC8N0RnPI
         jTxA==
X-Gm-Message-State: AOJu0Yw1dDu1ryNaywCXeYkNnUaHgoz5PruaBSpU0UTTix7ojslr5OB1
	ODCWh0FiptB63tuXagkJ2YKQf8yWP+3k8Bffgn4S510qX6zRmwh5lGFDZQd9R7XhTmoIOsOmWbo
	GJJjYs44Z+g==
X-Gm-Gg: ASbGncuSwh3ojmXYK6XX6xrrkwI7Cden9FU/AovX4V0JvlSOeJMYb1i1+NvtP43DIbm
	91fNygCnitmF93urv6qJCei2z91diEN1CyZT2pmprZ/souQYRkCnjUcXr76uod2X5ErESg69uxl
	zDJ2h46cGOs1zuCgssDtePKg3vzpwzmi1H4OKfzOHx2aziqL8MByi1LdJzpNmUFKAu5dCmdH34A
	kmWO2H+JVQPlc62icpiVBlL65jU80SlqBjBn7d6Hm7CPXIUdVa1X+f1AuXdbP9U3Cs1orhLf7Gy
	KWIguHz1hj3UrN26ja6NLMUkIq2baUPL9QIMDEvunYa3IZ22UUycVjpM7WZNV2ieZVpkCnXT0JW
	23wTlTN+atuqUQu1qyuhFT+DvScUCP7AJCcuR/GKA6SILfJ3Bw4HtDZ1W3t53ODS31Q5B/A==
X-Google-Smtp-Source: AGHT+IFLh1NRGdke0rPvIun6BwDM+j5CUgCx0MIDgv4txaYGE9873VFVFQQgPIyDR56MDTrNJvGMzQ==
X-Received: by 2002:a05:690c:305:b0:719:3e4f:60f7 with SMTP id 00721157ae682-71fdc3e8edamr6284457b3.26.1755807678549;
        Thu, 21 Aug 2025 13:21:18 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71fb82b39ebsm13478727b3.42.2025.08.21.13.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:21:17 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 41/50] fs: change inode_is_dirtytime_only to use refcount
Date: Thu, 21 Aug 2025 16:18:52 -0400
Message-ID: <b4913e1e9613eea90c47c2ec2d8de244e1478668.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We don't need the I_WILL_FREE|I_FREEING check, we can use the refcount
to see if the inode is valid.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/fs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index b731224708be..9d9acbea6433 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2644,8 +2644,8 @@ static inline void mark_inode_dirty_sync(struct inode *inode)
  */
 static inline bool inode_is_dirtytime_only(struct inode *inode)
 {
-	return (inode->i_state & (I_DIRTY_TIME | I_NEW |
-				  I_FREEING | I_WILL_FREE)) == I_DIRTY_TIME;
+	return (inode->i_state & (I_DIRTY_TIME | I_NEW)) == I_DIRTY_TIME &&
+	       refcount_read(&inode->i_count);
 }
 
 extern void inc_nlink(struct inode *inode);
-- 
2.49.0


