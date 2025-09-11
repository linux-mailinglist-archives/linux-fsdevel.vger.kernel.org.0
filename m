Return-Path: <linux-fsdevel+bounces-60878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E0DB527E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 06:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C4D71C8023B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 04:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9654925BEE5;
	Thu, 11 Sep 2025 04:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqkSoDUy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A0F2417C6;
	Thu, 11 Sep 2025 04:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757566581; cv=none; b=TWfYp4MBfutPmC99HsVFiQJLV+sMc3wvgZYgUKphG0QUuXJFbxFo3BJ5oc+2pE+kWsZUz6r+xiXzDBUX4m/6+y0/JYwkQ4E5loOgZAy+I3lUrgaUmDKY2Vq1uFAZQsbOOHcHY17qSwqydPARkh6/gsvOkxwM8YCRRQwQwDlRknU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757566581; c=relaxed/simple;
	bh=+OpnHav0x6JMfHFpFQpCzutgMoUi/ESeVF79sx8hjFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7SybOL+jm++AZePX+H01ad7dAKAAHIE1Vd5vD8hSxiNp0gTP2d2bIVWYQxCNo+BP++E9B4dua/QEbZ0PFFOrqCLFimSOxwyA1CTADeZiqexRidbgPkpXGuHb1y6ii1MxqmgFy/ldiEZJda9GpcOpOCUiggHJPnFIqjXJz0xdu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqkSoDUy; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3e751508f21so188227f8f.0;
        Wed, 10 Sep 2025 21:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757566579; x=1758171379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YLHicn9dTH5/070mxiYCI0YLNhb1ob9gFIcwBqIMYE=;
        b=KqkSoDUyP9bVyU/6Zzvq1vQ243yvpp7pRKKz+3WNnadi7XlWQcY4tDJJACow/IFEHZ
         zSEURQk3sUQLnn+O6Z8EE6gCnGDzJU312Wn85YlowPMJvigFGSVCZr0AZV/YNfiB51ZD
         KSeFZFTMdebJaYbvbRY+EijNWoB5TWYt57XqO+ZsxLX1qVg4Zefzxi7Bx7FwTV3sFogQ
         jFwWAcfYnlHEHkHL5vIa930De0ds4ByhBEzE5WUM3OvqosWxZ8lLd4/q7NwdKvAGlEIY
         9Bz4gvnKX/lPMm3r9eGMiLrk9yYVKUv83zvuZ1t5RH2iRrmYgl0qpj/mx0DKaZd010/j
         i/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757566579; x=1758171379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5YLHicn9dTH5/070mxiYCI0YLNhb1ob9gFIcwBqIMYE=;
        b=agXIyWtcNighWHv7okyPiTfFhlyYXYhcquZqCdDye28XDnuQaH4lzoFehBLWJSV8zn
         zhwHJ9puEqcvSgaNuGH8cFBqRkpPfRf+K33IWL5Fs3Uk5Qgf7SlDHjVEPkn379ltelPi
         3m9mnoCtBs5kAlQ8CTVtVZvnqP0AO9i8YrJ/eu0LRElkULJozaq8PIYKb8fqJd7x/w1J
         Uf5kQNSrWDgiLeo8eoVtJLlh1rPdbsUGF77sfMls3b9zrVaKZ6pBfqUlNSQXfy9Cpd6z
         IZWPEr1eN4G1JtQri7SGbBbu06pAwqDxUe8cxk967zfAaP7DN/T/dLLQF4wVCEIF7a+8
         AMXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVi3C63hwQO6udS/D7927K6lD1BGkKNE5xmYGZ5iDJxdzNzp0Qkl1mi2fnOwc26ptYTROZ88T+6oDTG@vger.kernel.org, AJvYcCVigElzJKPS1En7S8jEtYuP7riA/u71ZA1xtWPyKEDLhYkj4oEd7L6j1MkklU32+tAcCHe+jpGpHwJOIcv9@vger.kernel.org, AJvYcCWkDl/uKRTYkInubxRzk/omCEBC2kbx8Zw0nAYmjdhvJzWIXlte1hrOzpVYcmWv9V5rhfUxwG576DQ70lxb5w==@vger.kernel.org, AJvYcCXEKwcIMvG7Q7s6lDqQMon7CkMQl3E6gwTKQm6Yt3oIdP7DbKRSzRe7bSj+/nzAwch7N69OnPcKIOVyLw==@vger.kernel.org, AJvYcCXfRTOGCw6iY3W6W3bVG2yTfZsCSWiuq0I79Ytmq4tKL54dYa/AELUULS+L2l8htZPx0A7nRenakPErTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5s5+lzN3jX/OnOuaVwmZkoqJPKXW9qserltdPwUKYEL3XYqyZ
	MxtRKTRG4u1Ac8gSckYChn91NwKLoMYLrIAXlX5aR+9OCoFdfYYHBYkR
X-Gm-Gg: ASbGncvTVSPn5A4muvTPtU8UhmAIAExh77ArTQRifeKOnCtlWK8ql5BX4lN73kaAyVW
	4J0mli4GQPUOWBKnF86ye70akwudCP5rFx4Qso8BgtIn1wnaVt28rN5p3B/aFY/8bN0v4UHDfBQ
	uImGhaFrPXjlWApxfUKLf39UP48aadAtQivuzPF01005BF8xOgZ/wRAzI3yjvgMZQeijx5zRX92
	9cuGJggIGIwCL/ms3XLZdCVQAu/2ydqwQ7h2B4mQN7XA5jtR+HLTBhC+sOeyxxa2cmXRBf52S+g
	bweoolh+ZzRfKhhPH4DoJgwqLTW5JlyLHOKqpVwIVdcUBE6Oe22sJZ3kqpBRGvEDq5xIGQ41ovJ
	R4tsghfd4Eq8Zk+JHypwWRKhCJjws7gQOGBk0hXoa3PKyQ1tWSoEraqwWXu/PAw==
X-Google-Smtp-Source: AGHT+IH43UmBU64jK+xL3m62yMA10v9nozy9RFWM7cuwJpC5B1nBbx9LsGq+u1ZXEjc4PtCQBy4Z3Q==
X-Received: by 2002:a05:6000:178e:b0:3ce:a06e:f24e with SMTP id ffacd0b85a97d-3e64c87e0a1mr12521762f8f.52.1757566578594;
        Wed, 10 Sep 2025 21:56:18 -0700 (PDT)
Received: from f.. (cst-prg-67-222.cust.vodafone.cz. [46.135.67.222])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607e9e6asm889419f8f.62.2025.09.10.21.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 21:56:17 -0700 (PDT)
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
Subject: [PATCH v3 4/4] type switch
Date: Thu, 11 Sep 2025 06:55:57 +0200
Message-ID: <20250911045557.1552002-5-mjguzik@gmail.com>
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

---
 include/linux/fs.h | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index ed482e5d14a6..fd8e68352fbd 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -782,6 +782,10 @@ enum inode_state_flags_enum {
 #define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
 #define I_DIRTY_ALL (I_DIRTY | I_DIRTY_TIME)
 
+struct inode_state_flags {
+	enum inode_state_flags_enum __state;
+};
+
 /*
  * Keep mostly read-only and often accessed (especially for
  * the RCU path lookup and 'stat' data) fields at the beginning
@@ -840,7 +844,7 @@ struct inode {
 #endif
 
 	/* Misc */
-	enum inode_state_flags_enum i_state;
+	struct inode_state_flags i_state;
 	/* 32-bit hole */
 	struct rw_semaphore	i_rwsem;
 
@@ -908,44 +912,44 @@ struct inode {
 static inline enum inode_state_flags_enum inode_state_read(struct inode *inode)
 {
 	lockdep_assert_held(&inode->i_lock);
-	return inode->i_state;
+	return inode->i_state.__state;
 }
 
 static inline enum inode_state_flags_enum inode_state_read_unstable(struct inode *inode)
 {
-	return READ_ONCE(inode->i_state);
+	return READ_ONCE(inode->i_state.__state);
 }
 
 static inline void inode_state_add(struct inode *inode,
 				   enum inode_state_flags_enum newflags)
 {
 	lockdep_assert_held(&inode->i_lock);
-	WRITE_ONCE(inode->i_state, inode->i_state | newflags);
+	WRITE_ONCE(inode->i_state.__state, inode->i_state.__state | newflags);
 }
 
 static inline void inode_state_add_unchecked(struct inode *inode,
 					     enum inode_state_flags_enum newflags)
 {
-	WRITE_ONCE(inode->i_state, inode->i_state | newflags);
+	WRITE_ONCE(inode->i_state.__state, inode->i_state.__state | newflags);
 }
 
 static inline void inode_state_del(struct inode *inode,
 				   enum inode_state_flags_enum rmflags)
 {
 	lockdep_assert_held(&inode->i_lock);
-	WRITE_ONCE(inode->i_state, inode->i_state & ~rmflags);
+	WRITE_ONCE(inode->i_state.__state, inode->i_state.__state & ~rmflags);
 }
 
 static inline void inode_state_del_unchecked(struct inode *inode,
 					     enum inode_state_flags_enum rmflags)
 {
-	WRITE_ONCE(inode->i_state, inode->i_state & ~rmflags);
+	WRITE_ONCE(inode->i_state.__state, inode->i_state.__state & ~rmflags);
 }
 
 static inline void inode_state_set_unchecked(struct inode *inode,
 					     enum inode_state_flags_enum newflags)
 {
-	WRITE_ONCE(inode->i_state, newflags);
+	WRITE_ONCE(inode->i_state.__state, newflags);
 }
 
 static inline void inode_set_cached_link(struct inode *inode, char *link, int linklen)
-- 
2.43.0


