Return-Path: <linux-fsdevel+bounces-61751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E750B598C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 16:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65F5E7A1B23
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 14:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BE936935F;
	Tue, 16 Sep 2025 14:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iW6+BSMB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8E1315D58
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 14:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031213; cv=none; b=qWiXnRNwrErc1lIisZVLx1FL36La4gmxdXgJq+e5nB5Q+q6TWNw8FFZcMmdRgnYE7vSNWpjnj4rhbHQU0ziurJGRzcDX2jR/l4lq6B6usjxbnFiBxu0gFodmFmgLIM85YvfxZ4f8nClcZaw9VTNSONEESPLUzYu/6OS4w8WtMlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031213; c=relaxed/simple;
	bh=QCGFM/cnMeWMX3htX5p6eryZx4ChTW6raUZie6Xkq4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o3MS93FO9OJ46Cu6oPe2f4yVctgjAT/h8C0PZk3IMqebuze3zInXpf+8pRlS5LH1AgEnRW3ONHgoKZzdWollUPDcU4BHVS4sOUxjuV5HcVyboTqp604h6IhZkzc4jtBNt8lKBxSaG0O/cK8lboRKubzIcYAHnKzmpfInVKyvHHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iW6+BSMB; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45b9a856dc2so34724685e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 07:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758031210; x=1758636010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3p/HZf12MlzeyzMfr2O5f/PDaT3y6+eiNIS1WtKNH8=;
        b=iW6+BSMBZRvQB1yYWR4AswPcskWhLKeXP2AgMF33mGwxfNGuGLGG/iihOf97Pk3Egf
         yascFKoHCofXHSCGwGWX85WoMawk1WChMZ2vVnBG5iceOVpKN1kcV8Sq5dP7TXvzTpIL
         TpTrFz3zsxDGASFjV56JglRetgt4y5Spwz0nRpIUcispuuErnBKOR8ORLItpMcNX/DWx
         JqKQ8dlFndK3il1wKHydLbizCGikW+CjagTFk6DCX6io+CAyV7kIPQcS70mCyMP2Aq/a
         iEywUIfKGqKLHljPOQVCcviJjYxpEO4D/xI2iJ4m+NbU8iNfvItPWbS4KyfakuHJ7dH5
         odog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758031210; x=1758636010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F3p/HZf12MlzeyzMfr2O5f/PDaT3y6+eiNIS1WtKNH8=;
        b=ODqJFCEUykP4ITGaLKFKBNK/nwZihYPrbx6XJbeFyt2JKhJjOV/tXox/Hxj3nobHdX
         SWpyxhKcoqt4qDdDjPqzylieQ70INXIXFyvHJu0pQtsHtzZ+ZbnziyqmLp7OxtC24cT2
         UCve8ftIEx0gNwsnxbvFIV+aez/YKvW1V08XuF3bQWfUEIqBall2aCJNuSavMvbeDZ4J
         Td+rDr3Lu4yDUA9UcLF0FjtLsB5xM+LVR57lw/m3fw4IJIOW4ojVjoZ9HeyL3Q1TPjlq
         GEeAI4TUlrKRpJ0ItJwKrRUb5/7z4BM3a2vZzDOQ++YB+B1CSXxzhEFPpFWqx6zU0I2H
         a6QQ==
X-Forwarded-Encrypted: i=1; AJvYcCWejv6c6DTw39el7MMMi1iILGiRgKCB8IR19uz5Pr71PbSEh/xMm9Zo0ZXlSI+7/2oE2i7zfiqBcdcfmW16@vger.kernel.org
X-Gm-Message-State: AOJu0YyBcjmIeHKb+Lacct7Go97zabNXPNnUknbRd/nnMBqlZz+tY9rl
	zftH/UcZQMSjtWQfe1Aav+zyUZYs+zQ+OnKgzHJ2GlFD4ZzGT3zDitl+
X-Gm-Gg: ASbGncuJwaydZ2b3SK3IcwKLj64uyjxBqIyiLwfw8Q5J8QD346zz9wpdoatzAefHbjv
	ABM8GU938OvVcs2lFYh6j4E2rPhQGhBM2Q6nMMOzJZyGhUgS43exB+Ph1ch1ousxHhzB4M7XF6S
	jCx8N2jftJM1TeZewPXIkAGc/9QCM809wj0zBcP8Xa7h5CXdrwGL0a6zgvpcp6bkbiuRCNxyprb
	QLDkWOLz8LauqfbMCDTRUMRdAbh2j8AbRs3SgYPMwFyYkoxGxCn72rjn5CMl7vDCnYSLhWsMNKm
	8bV8xjEjHUmj4JaNNZ5WzSvmDPWeFTGY9bTyog6W2p5jiwuK+sOJRWkBQ9DqvUxu6Kn1FzoOKBr
	ucKngEYaDY2jYc7uxZBCbtm9/oalS2n+FTZnQBhLMUAi/qL6Qv/IWVVvfrTXWcifT5bj92WOW
X-Google-Smtp-Source: AGHT+IG3ojTnTVy1hdNr03FmdV6E3sTeXWaDybJz1f1E1nvEGmI8CA+2Pel84ZsC9/O7zHxZywZmtw==
X-Received: by 2002:a05:600c:5246:b0:459:e025:8c40 with SMTP id 5b1f17b1804b1-45f211c8aa9mr181401305e9.10.1758031208380;
        Tue, 16 Sep 2025 07:00:08 -0700 (PDT)
Received: from f.. (cst-prg-88-146.cust.vodafone.cz. [46.135.88.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7cde81491sm16557991f8f.42.2025.09.16.07.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:00:07 -0700 (PDT)
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
	ceph-devel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v4 12/12] fs: make plain ->i_state access fail to compile
Date: Tue, 16 Sep 2025 15:59:00 +0200
Message-ID: <20250916135900.2170346-13-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916135900.2170346-1-mjguzik@gmail.com>
References: <20250916135900.2170346-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

... to make sure all accesses are properly validated.

Merely renaming the var to __i_state still lets the compiler make the
following suggestion:
error: 'struct inode' has no member named 'i_state'; did you mean '__i_state'?

Unfortunately some people will add the __'s and call it a day.

In order to make it harder to mess up in this way, hide it behind a
struct. The resulting error message should be convincing in terms of
checking what to do:
error: invalid operands to binary & (have 'struct inode_state_flags' and 'int')

Of course people determined to do a plain access can still do it, but
nothing can be done for that case.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/fs.h | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 11eef4ef5ace..80c53af7bc5a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -782,6 +782,13 @@ enum inode_state_flags_enum {
 #define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
 #define I_DIRTY_ALL (I_DIRTY | I_DIRTY_TIME)
 
+/*
+ * Use inode_state_read() & friends to access.
+ */
+struct inode_state_flags {
+	enum inode_state_flags_enum __state;
+};
+
 /*
  * Keep mostly read-only and often accessed (especially for
  * the RCU path lookup and 'stat' data) fields at the beginning
@@ -840,7 +847,7 @@ struct inode {
 #endif
 
 	/* Misc */
-	enum inode_state_flags_enum i_state;
+	struct inode_state_flags i_state;
 	/* 32-bit hole */
 	struct rw_semaphore	i_rwsem;
 
@@ -906,19 +913,19 @@ struct inode {
  */
 static inline enum inode_state_flags_enum inode_state_read_once(struct inode *inode)
 {
-	return READ_ONCE(inode->i_state);
+	return READ_ONCE(inode->i_state.__state);
 }
 
 static inline enum inode_state_flags_enum inode_state_read(struct inode *inode)
 {
 	lockdep_assert_held(&inode->i_lock);
-	return inode->i_state;
+	return inode->i_state.__state;
 }
 
 static inline void inode_state_add_raw(struct inode *inode,
 				       enum inode_state_flags_enum addflags)
 {
-	WRITE_ONCE(inode->i_state, inode->i_state | addflags);
+	WRITE_ONCE(inode->i_state.__state, inode->i_state.__state | addflags);
 }
 
 static inline void inode_state_add(struct inode *inode,
@@ -931,7 +938,7 @@ static inline void inode_state_add(struct inode *inode,
 static inline void inode_state_del_raw(struct inode *inode,
 				       enum inode_state_flags_enum delflags)
 {
-	WRITE_ONCE(inode->i_state, inode->i_state & ~delflags);
+	WRITE_ONCE(inode->i_state.__state, inode->i_state.__state & ~delflags);
 }
 
 static inline void inode_state_del(struct inode *inode,
@@ -944,7 +951,7 @@ static inline void inode_state_del(struct inode *inode,
 static inline void inode_state_set_raw(struct inode *inode,
 				       enum inode_state_flags_enum setflags)
 {
-	WRITE_ONCE(inode->i_state, setflags);
+	WRITE_ONCE(inode->i_state.__state, setflags);
 }
 
 static inline void inode_state_set(struct inode *inode,
-- 
2.43.0


