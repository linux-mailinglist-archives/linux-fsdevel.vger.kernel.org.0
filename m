Return-Path: <linux-fsdevel+bounces-58685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D672B30718
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E69A264267E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 20:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429F63932C7;
	Thu, 21 Aug 2025 20:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="l+PlcfAE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502B13932A7
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 20:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807692; cv=none; b=QwFmhTyeGZfjCMDGnztnc9aF00DhjM6a+PdQ+T6zuULzEE7Ddn92QgWPZQ3lWobZTNmprJp4ejVWALScX27R4opi+X1oXdvKAiouUY+yCzv1mnFKOyBFMlgXn6O/z/BhxJ2J1I/T4OpqtAVJmRbDxTJQ9X4Z1xT99v2OKeJokQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807692; c=relaxed/simple;
	bh=K7JnBj/EGzyS1OdbBFrvkh4RZsBpYi+IyFwAgh+Lb+g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HXP+jKVVzssXxnBtS2H8eFoxvGc9o4II/R280S1Vvs1IdOR7NG6c0Ce9WgSfTEHxZU3MQPLpW+HgmnQQQUM6EJAHPsOpDo9y5Ox3lD6oh29+r1BKssH5LYLy1Ukbd7z8d8pGHFZketcdR4791fxaXtcMLttGmZ391aOX/JsQfIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=l+PlcfAE; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71d6083cc69so12303377b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 13:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807690; x=1756412490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jXIzcijPr4pONzroTEWGlRY1GomK1Uf0HH+VMUMLr6k=;
        b=l+PlcfAEmx5i2V8op88cnpZsuRkMTt7IYc41Sfy+HSvLebZfCwtTQZvCH8Bk6CsjJt
         K4jx60j64kmerkjnRTZbVcPgHZU736YIo+p+ZDF8yz/jjL9nIwB+u3m+OFY+rMpWwLAl
         7AH38QWbHlSX645VekRQcQVsAecCcb9p4J1Ml6vxH4WYtcAhaeCvGHNKmZjd8w8e611w
         KQ9KD5ssYCHEffbvY4RRx+FZBsp9k1jgMDuNc2cVHg7U5MhMZcTgIhIFOATLoc3Kciwh
         X/up8AhmF+Y5tChZcdZoK8E82UBhzCXt62EHRVx+lw9Ko0RyUcMS/yw0j5SMCS2XWAQi
         L/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807690; x=1756412490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXIzcijPr4pONzroTEWGlRY1GomK1Uf0HH+VMUMLr6k=;
        b=o0AFYiHaYX11/NUBsyu+Y7ZrSFZ3QMPk4drOUSBwxzyUnip3SlxjH+6oVl2AP6ird7
         OSCRC9zhh5gZDes1NbR6kHWQFjtBvF0IPINrqGH13YHX2i3XOfuViY4IbUitA2Kw5Dod
         QRV6QsZi8W4mut3CWU7D5iOo4hYFN2CUhGOrGCpzyT0MluuL3G6Qz3Xim9/t43UqFB/Z
         fweW1UpKSTw8BUyXCRqp6bJOZwt7l3u2kdc6aTFP0GX7EGZ8IOFFDGXK7Q4EVF4Y5xjC
         lDLzrXSLGEg4Mf0zyM5ywEB3iE2VgTQUVvGtCKKH+O8SzfBIK9ZSfD6NREpWlqCLGLR7
         nkhw==
X-Gm-Message-State: AOJu0Yy4Yi20UH57MnXuJH+ydpZyvqA1+gkR/0RdgXRCH/keLBNceYnL
	Nkm+FnaAyyy/gtfUUbGvS2Q+GfMBAB4ww9wbOaZMwfHlxYWjRlOGksc4G97UYv+MdFbOvZy4nqc
	HygbhtLjCQA==
X-Gm-Gg: ASbGncu/ZB9NH4u9ola2BalUMA2KAg/uxzvgi8kYuV+bItNhKKBREXdAWynoOF/xAMK
	zbEik0sMThbnsSKgQ2MWSs6M/IBlnnI//z1VfYgTVZdljPxB+WDSrUPYLtkzPxBM2q7r41mQJ4/
	UdKKFB+Yc0BS5T1etDn91zeJcNh/mAnuU79fHa8cAxyp4XVoE2LCzTn1InFhShwjzi0Erv1xkXV
	nSQseiqPPfwSaYLCvLdyr6kNAMiLQjuMNeSKs7WuTU9ZMubdoJz9ZgQxfwN0WpQIFri2PYL+qHI
	EnXbIeyyFlKvFP5PLCMT7ZzEqVEZ2/fHJRbA7wZEij/sA7qkNH0OH7/FmxKrc5gjAtjyZ9gW14D
	T4DLJxWA5oSENyTMKawy013NuSHrAV52yz4Cm56mAG427GI6YJPA/llOzfhns8TKc57+ybA==
X-Google-Smtp-Source: AGHT+IEO30NmlKq6gjexRRcDwC+IutcN4FswlbECizygJkS4EjREg3MgjupO6wxhwVTETYh4w1p4cA==
X-Received: by 2002:a05:690c:4d02:b0:71b:f755:bbc1 with SMTP id 00721157ae682-71fdc3e00bemr5400007b3.31.1755807689657;
        Thu, 21 Aug 2025 13:21:29 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71faf1e1459sm17292517b3.60.2025.08.21.13.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:21:28 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 48/50] ocfs2: do not set I_WILL_FREE
Date: Thu, 21 Aug 2025 16:18:59 -0400
Message-ID: <c00734df0a9773105cb274cf924f04ac73b3c4e4.1755806649.git.josef@toxicpanda.com>
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

This is a subtle behavior change. Before this change ocfs2 would keep
this inode from being discovered and used while it was doing this
because of I_WILL_FREE being set. However now we call ->drop_inode()
before we drop the last i_count refcount, so we could potentially race
here with somebody else and grab a reference to this inode.

This isn't bad, the inode is still live and concurrent accesses will be
safe. But we could potentially end up writing this inode multiple times
if there are concurrent accesses while we're trying to drop the inode.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/ocfs2/inode.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 14bf440ea4df..d3c79d9a9635 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1306,13 +1306,9 @@ int ocfs2_drop_inode(struct inode *inode)
 	trace_ocfs2_drop_inode((unsigned long long)oi->ip_blkno,
 				inode->i_nlink, oi->ip_flags);
 
-	assert_spin_locked(&inode->i_lock);
-	inode->i_state |= I_WILL_FREE;
 	spin_unlock(&inode->i_lock);
 	write_inode_now(inode, 1);
 	spin_lock(&inode->i_lock);
-	WARN_ON(inode->i_state & I_NEW);
-	inode->i_state &= ~I_WILL_FREE;
 
 	return 1;
 }
-- 
2.49.0


