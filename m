Return-Path: <linux-fsdevel+bounces-62497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5EAB9580A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 12:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF9582E600C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 10:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5418A322A02;
	Tue, 23 Sep 2025 10:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhZGN+uX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32C3321437
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 10:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758624457; cv=none; b=sOYzqvAzYc84BjmINZ5RYiZ8nOSOo8PBPJ90iHHDZ+BvauO5zRVvS4I35CG2LnaWk9TwZNiCDfWgfYoi/bzwRhndXTQCX9lOsp4uxpiH1/0G2JmZ+btsQnMWCzJZsywd5LyTFamE0MHW4c8vWKxabVfLTPrfa8Ns32f/IuuLMNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758624457; c=relaxed/simple;
	bh=ouMLdiYXJEV/tbThHG/kXZjFoWBywpLKJo/Paio0wwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tZMI0ZGMtVABbJozoMwcljYQDVLJhzNaNiSKY0VViJXWU4lwgEylpwKJckVDsLz9/HlpUt4uO7wGq4KQzv4xiBsoATA9Z3WfZfJ1dC2CSNEy/mrJJ8otKBq1rsNGS6VnSKeDc8mw1whs3vS+aiESenEK6bf6CkVULho8gHg4oXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LhZGN+uX; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45f2acb5f42so39850515e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 03:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758624452; x=1759229252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjQhtecysAf2+Tm/SiAxvWYNu2I/ZUKX2kulTrssyjQ=;
        b=LhZGN+uXvnRcZp/BkNSZYpY3HLnrF3MIXUHwRe5694SHPoiXPSjIF5o1Cx+hffoY2D
         wLQnIdbqbp35ju7NMkMmutMG6NxIK8kC9I0PKqjPRo3MlN6mwCJzofAiR4aChInAl7Dv
         uaazvsOcIgmaXfy/dWRVf/OhqHPCYnw40d9hV0nqJHuGnrYlHFvc4aKobLXWjPH/DEGO
         5oFXfC+bDh/jOq/E0hzacTXcCu3dhKCjCeiUmPNy1FWresmWjR9SPuCx7AQWtSGJxaGZ
         jYjbsboNrycDe21fu6Ip2tQufSoGiGGCcxId78Js5h4L5suYrY2HneCBlUZX9HB6XZjW
         d+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758624452; x=1759229252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UjQhtecysAf2+Tm/SiAxvWYNu2I/ZUKX2kulTrssyjQ=;
        b=XE0Nn8pF+13sAU+6kQQXi+GnWbwrOnO0qj5LrjkKD0s0XpLg/GwnVpBvrzC62TlDbz
         OxN8EQZjK3DaVWgRULIryxEdATVxRI/TpRisGQQVdl5B5X65+8y+E+fAdS7/yh/QuvWH
         Gt5llzmUNa/AqI91IN7N10LYO1IrEFposjsgUYtf+S2KXCh6FwyxyeNgLoRAfv6aY5ig
         yk425yQyZpHdSKcWg5fogXMkycWbVBGtwajX/cUFBnb4kBAr8fiZCXUz2TGFtwHmPxaV
         afGmfMWmqWzxDQsIr8d7rQ5imO/McPenBacuEyJjzutpxMTxPMZvGySh9sktr/nPMc+X
         hcdA==
X-Forwarded-Encrypted: i=1; AJvYcCVTJ9aQxTkcA1whXOam/WS2eH4zD5nImqiqsVQr+lZ8BdCFFTBLMQzw5J31OZdeKpXXMN/GrvZWf9KRJ79u@vger.kernel.org
X-Gm-Message-State: AOJu0YwsbKMhH+qsivLQHqR24Bn0gJ/zMXpCQ7ZxXmN9n1HcMTxvh4WO
	JL0nOD1RyZsBhZIIXqW46friPKbEiRrAFs7QKf/cTIj+osEVNRXE08PU
X-Gm-Gg: ASbGnctRcgfODrWpaUP2wOgti2LVC+BJXpbka03hijNlV+XImZZcJpqcgv0thajfjO3
	fk4mGAPZe6D847JaFSgoYg3nUuGWbf96p3RnUmey705cQFJ6j58zdo7obkFcEURLTdGyNUzb3RM
	Gd759OmFf6K4/6oQwhxQojm4et+xUNl3HO2pnRCYBjYtg92SqCQ6BsMNyqpuoBi62TAMdq4E+cC
	NsC6XE7MI/QfNoOtDuDNCY7+8JQvwHibuiahECPq+UPDBmFNSjbC7XpOlmJ2cX3iE9OeZ//o1dX
	myS4QyDcQqKXkl+PV3UzRnjjL37AvkpStkXFHsEJfPp686/t3Bz9AK/y5V2fyvE6a+EIfwwAivT
	PLK4QwyBbmnOCQRSlSYD5sd3R1GVkXjldOnIDXLvlRjCEdX+Q4ArDBlU8p7g0uSl+xVv0TUPqoo
	FkN5f4
X-Google-Smtp-Source: AGHT+IEVb9i92+ZMOauFSkmxexkNVrc4dNm4CbgsPp4IcZSL124eR4borVyarFVwdram0vM+rxqviA==
X-Received: by 2002:a05:600c:4685:b0:45c:b6d3:a11d with SMTP id 5b1f17b1804b1-46e1e1121edmr21348615e9.1.1758624451919;
        Tue, 23 Sep 2025 03:47:31 -0700 (PDT)
Received: from f.. (cst-prg-21-74.cust.vodafone.cz. [46.135.21.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e23adce1bsm9710525e9.24.2025.09.23.03.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 03:47:31 -0700 (PDT)
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
Subject: [PATCH v6 4/4] fs: make plain ->i_state access fail to compile
Date: Tue, 23 Sep 2025 12:47:10 +0200
Message-ID: <20250923104710.2973493-5-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923104710.2973493-1-mjguzik@gmail.com>
References: <20250923104710.2973493-1-mjguzik@gmail.com>
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
index 73f3ce5add6b..caf438d56f88 100644
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
 
 static inline void inode_state_set(struct inode *inode,
 				   enum inode_state_flags_enum flags)
 {
-	WRITE_ONCE(inode->i_state, inode->i_state | flags);
+	WRITE_ONCE(inode->i_state.__state, inode->i_state.__state | flags);
 }
 
 static inline void inode_state_clear(struct inode *inode,
 				     enum inode_state_flags_enum flags)
 {
-	WRITE_ONCE(inode->i_state, inode->i_state & ~flags);
+	WRITE_ONCE(inode->i_state.__state, inode->i_state.__state & ~flags);
 
 }
 
 static inline void inode_state_assign(struct inode *inode,
 				      enum inode_state_flags_enum flags)
 {
-	WRITE_ONCE(inode->i_state, flags);
+	WRITE_ONCE(inode->i_state.__state, flags);
 }
 
 static inline void inode_set_cached_link(struct inode *inode, char *link, int linklen)
-- 
2.43.0


