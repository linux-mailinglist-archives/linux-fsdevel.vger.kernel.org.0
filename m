Return-Path: <linux-fsdevel+bounces-62243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC3EB8A6CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 17:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEB064E10DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 15:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C9E3218B3;
	Fri, 19 Sep 2025 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJBQjcPj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E19E31DDA4
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 15:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758296970; cv=none; b=ENUADZNDbbzEMxXSxGxuDpfAvKuqwKNQFCBbqyEx2yn+AqYJQ1vVPWzAcrwFMgVd2VUa5V/fR3Y6JPQ35yEl8+qFwOVRx/7Wj48RbJaPcSOzp+chM5ZVeu21YCClsR9gdU3GIZmGc4EdsNhy04mwtfw9ooBttpYobXEBYWUrMtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758296970; c=relaxed/simple;
	bh=mwvxOTrWUws8OMACY4TrEt0dK3mhZILNulqgYpZhPQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pUKB686KqgnmhREqhm0oNWmC9fZmvwpurFkYK6enSehQZ0hJ9C1AEySf8PhE19oMzpeo2BYzb0NH/nohfBhJTbTfO4HDS8Woj+QBRK6yl28uKGqT7rUt/IDjmtNGS+8otZVbkIt3yrCvLjgqI8oC0d5ub/6WGwF7w1rLRb8Ih8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJBQjcPj; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3df15fdf0caso2034857f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 08:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758296964; x=1758901764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61d6oBaZHfUlKu+4j2QssmtpKiSdVI4e5z02o4UC0u8=;
        b=gJBQjcPjlAVeXIpKpiWI3+YDxneMBgccZS+2jAHDPUzhYn10d5TKf6h1KrweDA6RhW
         UCyXNyqTdbV4ksXQ9Hruor1pS/Nrh0aKOWopUOnOLvo7Aq3XzjCX3LMYkZyP+MTEWuIZ
         72MMwgTJ/+c7MZ4Yk9cvfcRUK+fmxNUgxfLs5AMa7zLy2HBlNaVVA+q8s610ZmJ1gu2k
         uwr/jtN9VkhflldfMdHezQ2g2lSOU/JuwjzMQanXUhgcSpaL35sdvGfyrhiig6ZoNtZ4
         bJ6SB0Fjvjy8yyMOIrOpIQWSXTsKkWc0APM6pQvyG1/onArV5YwjQI2bwtEVYlMijfCp
         3MWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758296964; x=1758901764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=61d6oBaZHfUlKu+4j2QssmtpKiSdVI4e5z02o4UC0u8=;
        b=jxPN/m3u6rewcqJf57TGHfXKmkcSzvLwiJ6scUTcn8F193JrzMuxpAZWc90E2/Got+
         iybytfaLgIomaVwN1AVTRpGNKBVXR3LHtKMLX7xGpYByuMEEN/iTUpSWg7nZufHkREmG
         7axuZTjnlH8V5j7PAwOGhpN5ilxmoNtgas9ISUL4yDetkU3nGxCqps5o1Q6Q0j0oVKLA
         YwhD0RSKojWsCyfMuULDad9STlpXK/Bskxl/T8cnEYWArLx1Ks9mY8jMjK8VZ+TSaJXR
         95/jVo+VkLVgNWBmwOFEDcMmnVRHQI3piR6Dnx/GqpyNnKXCvCxAwV5ZNasfJt97l6Qr
         Gc/g==
X-Forwarded-Encrypted: i=1; AJvYcCV0Ua4/6VjgHjx5tL+YG1Itxt50NT8u4/it8RNGO3PiTutGOhnnLqRYl2NV0tuiLtZ4uT4+7Nstcc+GrsWv@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh7lQTraOfheK3ACW4VYq977N8pk5R0cmoKms9ZUp/YixlW0RQ
	3GcZ00fCVkbDKc89Xbtbxj0pnAmUGAQd0Rusn5Al/CNhXxhoKRIUFHkZ
X-Gm-Gg: ASbGnctj25O2VteXlX+CBhOT+7leH8jfmHmFHLwyJBf3YQ44xHzU/XP/UmAgLNJoD5a
	n0lkGprAiHLwBstMt7ZwIEZzfs4qjtybzqA+dP4d7CEv0bMPP5GVzLS/wlDeqF5e0q2Q38Hgg14
	gwZCQpcNqmlKp7itpjgZCw2QbUViR97ZQ0hGICkofujJ8H5v6dfu4Og09AnediwceIYBjkSqUs7
	CHhFC+sKj4/gslHIrASHCIGeDKIXYSw0CbWfJhaB6tn3daVZkPgKmKrI11vZ6qJmYuFBwEOEzpN
	Enbp4KlO/qFmPYTP+ir776rHkSN6r6lNiY+lHa2msGR9KhyxE20Sm5gH7CY5c4Jlw1Cptd3MVPu
	Y2Dc0cg0t4Dn963fftoaknkh1e5yaog5k61BPgvGi/JXBqWlAL8/HrmOKH2oFxm9kyrie4Jm2
X-Google-Smtp-Source: AGHT+IElu5efTxqeZRn/Q7DGHQ7xzDh6VVQxmvzWa6J1DdvqizNuOI3aGe/Bc0G2MqWrzLvaODXXhw==
X-Received: by 2002:a05:6000:250c:b0:3e7:5f26:f1d6 with SMTP id ffacd0b85a97d-3ee7bad15f0mr3165724f8f.13.1758296964249;
        Fri, 19 Sep 2025 08:49:24 -0700 (PDT)
Received: from f.. (cst-prg-88-146.cust.vodafone.cz. [46.135.88.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee073f53c4sm8446746f8f.3.2025.09.19.08.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 08:49:23 -0700 (PDT)
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
Subject: [PATCH v5 4/4] fs: make plain ->i_state access fail to compile
Date: Fri, 19 Sep 2025 17:49:04 +0200
Message-ID: <20250919154905.2592318-5-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250919154905.2592318-1-mjguzik@gmail.com>
References: <20250919154905.2592318-1-mjguzik@gmail.com>
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
 include/linux/fs.h | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4ba2b274588a..3d678cd02fea 100644
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
 
@@ -906,26 +913,26 @@ struct inode {
  */
 static inline enum inode_state_flags_enum inode_state_read(struct inode *inode)
 {
-	return READ_ONCE(inode->i_state);
+	return READ_ONCE(inode->i_state.__state);
 }
 
 static inline void inode_state_add(struct inode *inode,
 				   enum inode_state_flags_enum addflags)
 {
-	WRITE_ONCE(inode->i_state, inode->i_state | addflags);
+	WRITE_ONCE(inode->i_state.__state, inode->i_state.__state | addflags);
 }
 
 static inline void inode_state_del(struct inode *inode,
 				   enum inode_state_flags_enum delflags)
 {
-	WRITE_ONCE(inode->i_state, inode->i_state & ~delflags);
+	WRITE_ONCE(inode->i_state.__state, inode->i_state.__state & ~delflags);
 
 }
 
 static inline void inode_state_set(struct inode *inode,
 				   enum inode_state_flags_enum setflags)
 {
-	WRITE_ONCE(inode->i_state, setflags);
+	WRITE_ONCE(inode->i_state.__state, setflags);
 }
 
 static inline void inode_set_cached_link(struct inode *inode, char *link, int linklen)
-- 
2.43.0


