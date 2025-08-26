Return-Path: <linux-fsdevel+bounces-59277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E2CB36EC3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1025464EE3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475DA350835;
	Tue, 26 Aug 2025 15:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="du07Fhm+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8D53705A0
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222914; cv=none; b=WBXP2ROPNDP0ruxC73Om3b414AsvbqYo+dLK8U/gJZJhIQxrnQPGv/8oQwukbI9A1SGoxWBdnZfW4hGevj3EnR/YhfpY1ItVBnv5VM9bSjc0lfj7mURyXzjGvNClKTBI0SWT7tVwTuP10ILlxpQX1sjrLck/C224jGhe7zBduT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222914; c=relaxed/simple;
	bh=dwwe0MEH5iO3x5aF5QurpKCYlNFdYiCh2i6JCishoj4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pjfyEzFd3gyVqT++ZA1KQglqZqWuVkI+lGnP9isAxG7hl3e9vWqERERWyKEAC8XK7AQoC9h23ZbcVuLAUD132vkAhUPmaVKB1OmzM7GY+Z1yDq/sq/DayZpZvlSrMxTVecj75gBNs7WxTIqSmgnThwUtUTdi7x08pLzqQT2IU20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=du07Fhm+; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7200a651345so22682557b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 08:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222912; x=1756827712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yqvplDu+lNSK1bVRdwN5sEI2iN4Y4F8Nug6abxM7ea0=;
        b=du07Fhm+E2K75A21FLUay2gY/LIECLDwj8QJpWSLT7JEI1eYR/PzKjv9AjIMUAf+3Y
         0mQyMgg26Y+H5drT1jRmdaTurj79cVC4zl+yNoF+SyXJOrSR8tlTcsbHyeCr0OqeeEr2
         g5wnR7B7nVP50zr+WRcdoT8MQWTVYTZ+BrM1HqoNHvtdKCTP/LGgri6n6gz/zJOU6fnO
         f0Hf7bCn3xUYy2SpN28T5B8cWL6ZEuQck6b5rhndsVyIz69FYDYg/0bitHGlJmD+a3Zq
         zi+KbNH7jLO6Mnc+dpu9whKOdXv8DtVurbaJZdq624RXiQE1gWtjCVBWShg010G51Zui
         LfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222912; x=1756827712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqvplDu+lNSK1bVRdwN5sEI2iN4Y4F8Nug6abxM7ea0=;
        b=lNySDIUE4q808e3+yCjejtUMufUZ0F76ET68mEzgcEY/Uul0mP3qj6EH9wmeF7s1AQ
         trDA2yFzfVJJ4UzFQfHtZV7rwH+BLPC5GPK7xSWQ+G3Lt98ywOs4YlrOTJrmqRynxRKb
         xl7vEmN35FtxUHDKmK0azQJ+H+StZS7i1MdV8s5x/6j6JaaJwYjDRD0awUOXk3aP74/t
         DT7kxWHPiE45/k2PwMwl+7Y2wOK4o2+Inhap80AbbzquqyxdyRSzHUqGqJcDvJDiJ0b9
         nPnhTjGD7OUq21Y0iNVQTe2RVflCjuz2JFKc5aFu0fZ/YlLVEhchiU1/gBFOqNv+bPPh
         rRMw==
X-Gm-Message-State: AOJu0YzmRvGeuVsaR2Mdbepo1W/GAqxAXa9LfFYfv0FwLeVUx4EHpx/1
	WuFWQVdGCFFaen/SNoqAeI9SlZYK96+IvAn3UdmcYLTLbdf2xF+QX+9Z5osY6cGhIPhv96yvU1p
	DKOll
X-Gm-Gg: ASbGncsIu099MKTNha+LQh37UomTXuXGZ6s6hyEfm5fTdEvx5XR4CMX5DsVxk7ytuwa
	AWnNiYlHcEwPBdExxyH5dWD5yUUV9lYuZg48gTkhVJyqV8K+urmmnG7+EfUfDdOYGThCAROdprG
	NVIs+h/4/uDY/IBO2/vYEzgTkWs9Mi612RmTTV5/GEHWvkIkc5sl12WUU4pM2/7Zc+v3Nsh6qqO
	Xr25nSVEzVwTeMEzJLpl226r+gY1906XKfxUIHpZndTCsNHmFMg5a4eTANHXoVZgB/Zr2HzW09V
	8x4UoPb+Y1g+PiWvkGyB9EUutQCPEDBXUcGDvco1aGuKEjS4s8FDcB36uZAjQx0Grpcd6tI4ATO
	TrNfqgdb837wT//QV1J8tRFGuAd9RHD+4cC8XKgFzhYDO2QLS0/SY/aIoJvw=
X-Google-Smtp-Source: AGHT+IEmTijuWh+ST4YjRGo7H4pufM7FApdnNjecK9pfpFaUwQCk/e/q5IjGGvh2/UXNpr28Nq68Jg==
X-Received: by 2002:a05:690c:2606:b0:721:2c21:3614 with SMTP id 00721157ae682-72132cd7378mr19923627b3.22.1756222911738;
        Tue, 26 Aug 2025 08:41:51 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-5f65a223d29sm2530427d50.5.2025.08.26.08.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:50 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 43/54] fs: change inode_is_dirtytime_only to use refcount
Date: Tue, 26 Aug 2025 11:39:43 -0400
Message-ID: <caa80372b21562257d938b200bb720dcb53336cd.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
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
 include/linux/fs.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index b13d057ad0d7..531a6d0afa75 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2628,6 +2628,11 @@ static inline void mark_inode_dirty_sync(struct inode *inode)
 	__mark_inode_dirty(inode, I_DIRTY_SYNC);
 }
 
+static inline int icount_read(const struct inode *inode)
+{
+	return refcount_read(&inode->i_count);
+}
+
 /*
  * Returns true if the given inode itself only has dirty timestamps (its pages
  * may still be dirty) and isn't currently being allocated or freed.
@@ -2639,8 +2644,8 @@ static inline void mark_inode_dirty_sync(struct inode *inode)
  */
 static inline bool inode_is_dirtytime_only(struct inode *inode)
 {
-	return (inode->i_state & (I_DIRTY_TIME | I_NEW |
-				  I_FREEING | I_WILL_FREE)) == I_DIRTY_TIME;
+	return (inode->i_state & (I_DIRTY_TIME | I_NEW)) == I_DIRTY_TIME &&
+	       icount_read(inode);
 }
 
 extern void inc_nlink(struct inode *inode);
@@ -3432,11 +3437,6 @@ static inline void __iget(struct inode *inode)
 	refcount_inc(&inode->i_count);
 }
 
-static inline int icount_read(const struct inode *inode)
-{
-	return refcount_read(&inode->i_count);
-}
-
 extern void iget_failed(struct inode *);
 extern void clear_inode(struct inode *);
 extern void __destroy_inode(struct inode *);
-- 
2.49.0


