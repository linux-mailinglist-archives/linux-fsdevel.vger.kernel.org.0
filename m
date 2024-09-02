Return-Path: <linux-fsdevel+bounces-28226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC359683B8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 11:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFCB6B23A61
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 09:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD5A1D47DF;
	Mon,  2 Sep 2024 09:52:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462061D4142;
	Mon,  2 Sep 2024 09:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725270737; cv=none; b=DM2pcC7wkeKmGA/U4swMDcoTerQizLgTl3G5GBE7VYMvT1LccsdqUDv6tPFDlt4Pc8l/k6PBsQyI+umJXkrtXMtkoPwGPuvGEsJa/nYbV5uIAKOSivdZhz6caJBIfW8Jsiuhu1BirgDJSsFhD8/5KuaemxsxbLbSiFLqGo7iydc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725270737; c=relaxed/simple;
	bh=UnnOxysnYIVE0lfzosvVxtlnZhIMcEr1N3hjgvRmdr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2wF9A4ANOplX0dmrNNB/JXprloe1apqfhrU6uQ9L4tYJ5zOlywrDrrUBTdMbVs9cdZKdMkRpZ8RGTrrP1HRMiX11b2Zu3pruQaBYcFLuI/ZT5B5hnGPb57rHFC4zrtfcnQvgBn4VjvbUNj3cMvIYJFInUyWDSbIQBG0fDsZNrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a86859e2fc0so453037166b.3;
        Mon, 02 Sep 2024 02:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725270733; x=1725875533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6o9ygZ5FbRqLnsF4xwAbutRPIFsChsjRgZv2/olxe98=;
        b=wMPC7nXYuYbFMYB0sRUO1ER43b/VdritipfEQscOCkzs6+CaFniE2BawYcT/Ko+yPo
         QoyqRP2KczI2B5vEECZpg9dPuw4Oez+HkhkWarjmAkv4QCy18HSmP3K7+puctSQJiOxE
         iaoH+YmlWnsDEo4t39Ko5AHDIFYLvSypvW4ZTtSzEe1e05jKY3ZFbpmMQ/fN/QVN+hPs
         kU8KthdqCyRGVjohRmkbsMpKpwlLRQ93d881QTBrFxDN8Elnm7JAKF4YybPayaiQrzpi
         Zol2HNNEDyS+U/wH/2crQmisiAoWXPuxS45H+PuSqfvcUcktMVvj9Vux1M9z2rvoydm4
         6mAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH+huCxb2rBZOV0NrgEwMLkBPW7hhGGOvUnJJKBfkxPZGn9TKboby9M0F/jz+uTcn4avC/ZRO+yIXDqSDO9w==@vger.kernel.org, AJvYcCWgO/zRlOMsCHvOJaMkySEinDA2ns5TKNJZsHsScDI7rbJbkE8ZZ4elTN2k0af+wfezhcqNzZZ//EJriTmo@vger.kernel.org, AJvYcCX+2QUhqjZqmtZxmTQdaHpDin8+8ubNo3xGizBLnAjkYDsvNCjKpw41Bz6HegbSsz4OBIOLqEnSEeyIv0zNel5/AzCQoxAY@vger.kernel.org, AJvYcCXMPYp8bc67cT655jr4eAJZ6Qfg4QgG9gWP4EzJZTWA2Flik1W9b7LpQkWFZ32sGl1qRA8uIVh1fuiYE77ewg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/e6psCkQUz0bzGxj7hXbYp3wYU0gDJ89G3Q3TCeWxY1zfXzLQ
	OIDL2tUPlZXc2BH8HCwcj0/Q2YtD2ymGQOMuIJUaV3Yh+PhDjg+E
X-Google-Smtp-Source: AGHT+IHugKwJ39IPMvFnRChZY0EvVCQYJUWKLCu3bRnc6OhGcrV7kB+jwS2h0M529y96bsLiRTRvnA==
X-Received: by 2002:a17:907:31c4:b0:a86:92fa:cd1d with SMTP id a640c23a62f3a-a897fa75723mr976108766b.49.1725270732803;
        Mon, 02 Sep 2024 02:52:12 -0700 (PDT)
Received: from localhost.localdomain (109-81-82-19.rct.o2.cz. [109.81.82.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a898900f079sm535327166b.66.2024.09.02.02.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 02:52:12 -0700 (PDT)
From: Michal Hocko <mhocko@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Yafang Shao <laoar.shao@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	jack@suse.cz,
	Vlastimil Babka <vbabka@suse.cz>,
	Dave Chinner <dchinner@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michal Hocko <mhocko@suse.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 2/2] Revert "mm: introduce PF_MEMALLOC_NORECLAIM, PF_MEMALLOC_NOWARN"
Date: Mon,  2 Sep 2024 11:51:50 +0200
Message-ID: <20240902095203.1559361-3-mhocko@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902095203.1559361-1-mhocko@kernel.org>
References: <20240902095203.1559361-1-mhocko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Hocko <mhocko@suse.com>

This reverts commit eab0af905bfc3e9c05da2ca163d76a1513159aa4.

There is no existing user of those flags. PF_MEMALLOC_NOWARN is
dangerous because a nested allocation context can use GFP_NOFAIL which
could cause unexpected failure. Such a code would be hard to maintain
because it could be deeper in the call chain.

PF_MEMALLOC_NORECLAIM has been added even when it was pointed out [1]
that such a allocation contex is inherently unsafe if the context
doesn't fully control all allocations called from this context.

While PF_MEMALLOC_NOWARN is not dangerous the way PF_MEMALLOC_NORECLAIM
is it doesn't have any user and as Matthew has pointed out we are
running out of those flags so better reclaim it without any real users.

[1] https://lore.kernel.org/all/ZcM0xtlKbAOFjv5n@tiehlicka/

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 include/linux/sched.h    |  4 ++--
 include/linux/sched/mm.h | 17 ++++-------------
 2 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f8d150343d42..731ff1078c9e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1657,8 +1657,8 @@ extern struct pid *cad_pid;
 						 * I am cleaning dirty pages from some other bdi. */
 #define PF_KTHREAD		0x00200000	/* I am a kernel thread */
 #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
-#define PF_MEMALLOC_NORECLAIM	0x00800000	/* All allocation requests will clear __GFP_DIRECT_RECLAIM */
-#define PF_MEMALLOC_NOWARN	0x01000000	/* All allocation requests will inherit __GFP_NOWARN */
+#define PF__HOLE__00800000	0x00800000
+#define PF__HOLE__01000000	0x01000000
 #define PF__HOLE__02000000	0x02000000
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
 #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 91546493c43d..07c4fde32827 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -258,25 +258,16 @@ static inline gfp_t current_gfp_context(gfp_t flags)
 {
 	unsigned int pflags = READ_ONCE(current->flags);
 
-	if (unlikely(pflags & (PF_MEMALLOC_NOIO |
-			       PF_MEMALLOC_NOFS |
-			       PF_MEMALLOC_NORECLAIM |
-			       PF_MEMALLOC_NOWARN |
-			       PF_MEMALLOC_PIN))) {
+	if (unlikely(pflags & (PF_MEMALLOC_NOIO | PF_MEMALLOC_NOFS | PF_MEMALLOC_PIN))) {
 		/*
-		 * Stronger flags before weaker flags:
-		 * NORECLAIM implies NOIO, which in turn implies NOFS
+		 * NOIO implies both NOIO and NOFS and it is a weaker context
+		 * so always make sure it makes precedence
 		 */
-		if (pflags & PF_MEMALLOC_NORECLAIM)
-			flags &= ~__GFP_DIRECT_RECLAIM;
-		else if (pflags & PF_MEMALLOC_NOIO)
+		if (pflags & PF_MEMALLOC_NOIO)
 			flags &= ~(__GFP_IO | __GFP_FS);
 		else if (pflags & PF_MEMALLOC_NOFS)
 			flags &= ~__GFP_FS;
 
-		if (pflags & PF_MEMALLOC_NOWARN)
-			flags |= __GFP_NOWARN;
-
 		if (pflags & PF_MEMALLOC_PIN)
 			flags &= ~__GFP_MOVABLE;
 	}
-- 
2.46.0


