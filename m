Return-Path: <linux-fsdevel+bounces-30196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8C598784F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 19:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6B601F23C7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 17:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB111165F18;
	Thu, 26 Sep 2024 17:29:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA411607BD;
	Thu, 26 Sep 2024 17:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727371795; cv=none; b=EF7TWLXf/ee7qhHmbA3lF+6lGGXvlxCuTShtviLSJctzXXlSoA14EwFKNyaq+fe03slhLhhoZqTvMNS8IZTR8KnQIkZKEJCIVNNtAfYU/qAFCrqJiAbR5UyavOJtJ6D7mijHfOQrBDWpOw0hYozVDLTgexM2kDmI6OevUbE6uIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727371795; c=relaxed/simple;
	bh=8xKNSHWkcqrg6r88sLQaXmLj7zEFq+0sVX1LVH7RV+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WhFBmfFvxk5fQqxosxGao6A/ZNegb5Zrs8nbJMyQa1RA4AM/LYKCQ4opOVlzEvVps0uMyYdDEWQsY/Lw7OotKLQZ++VURxCoEkDe6xfWk0gYF5sQrDvkOu1SK4HpRxXYFQird+btPZERBMX/trMwZFY5NCWT+sHeFBxWqiqsqFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-536584f6c84so1669491e87.0;
        Thu, 26 Sep 2024 10:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727371792; x=1727976592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffsv1LeC8EujkTx2A3lpobd+BleDrt/S6J7AA1ApFjs=;
        b=CiWU/qUh+CGPKXLbPnhppeQId/UhxhU6GdWrJhcwrclFXoRhKnZWDXasmQ8V0zsu26
         d3tUQt+/4BHyATY1l9pHxUpza9QtkqPOUk+pnTWzOvOCenjDDS+0lMjDC1TWjFSPuHAX
         TEzOQZjzUNvUY6s/t5g7Mfs5duRhkFmvNLLa4a5hY8WcooZCQzBpQ3Q78HPqtxrb85zl
         89gtJPBwGQ79kObeL9iGzYAqGmFuTrvbCdTM31CqeAfLbTJbP0TlyGhVGIQ67kCe74ER
         PAKiDuFlPq3hU6qgcLL8H5oI38SRhVdf5SNYYxxH4TP2YAbnY79PB+Q6w14T6RWt/Kzd
         N2lg==
X-Forwarded-Encrypted: i=1; AJvYcCUS6HFf2HiyBr/MK+zS6qto9KLOFV8B5nVBsxSBz2PnddPW4Hq6J4DBubdy7Z0GyLyirAEKFJIZDZxAwWN5@vger.kernel.org, AJvYcCUvx3MMptUYsypxJBw9owLM76ep2y8blx1UqD4oFqSN/EZai0uP2BOALi7b48sK9pWOZjjhA7nlI2UnovQf/w==@vger.kernel.org, AJvYcCVsGitrOwcD2BgPt3l7zGcite0M5bz52E7FiBKDl2RPZETz7k1otDS9RogvxG9YiiShwnKwum2c/Qc0z2sVwBHc31PYLz9f@vger.kernel.org, AJvYcCWWHBQOQ8KC0GZQj2hwJUmVoC02rKlWpQfd+0YReRhvz1h+gwLlBuoktfrwCApR83COlYuQ7jHyJVNrhnPA6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzA2PEXCDHATAPCL2UalgXYD5/Kb4ME2HV/3kt3GF+ehiMcO3ge
	sFX04gBk23YIfSEZXgl7XZr3PKVmynvJc+cmZw9cAyeKvILFon/r
X-Google-Smtp-Source: AGHT+IEP73qgWnQxHPW9p55unyaKmqDcpa3txiiqcVP8opZtPYfXDue7QX25cqRZ3xX5ddAIs8g71w==
X-Received: by 2002:a05:6512:ad2:b0:52f:89aa:c344 with SMTP id 2adb3069b0e04-5389fc3c23dmr252834e87.16.1727371791504;
        Thu, 26 Sep 2024 10:29:51 -0700 (PDT)
Received: from localhost.localdomain (109-81-81-255.rct.o2.cz. [109.81.81.255])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88245eb15sm145336a12.49.2024.09.26.10.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 10:29:51 -0700 (PDT)
From: Michal Hocko <mhocko@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Yafang Shao <laoar.shao@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	jack@suse.cz,
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
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Dave Chinner <dchinner@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 2/2] Revert "mm: introduce PF_MEMALLOC_NORECLAIM, PF_MEMALLOC_NOWARN"
Date: Thu, 26 Sep 2024 19:11:51 +0200
Message-ID: <20240926172940.167084-3-mhocko@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240926172940.167084-1-mhocko@kernel.org>
References: <20240926172940.167084-1-mhocko@kernel.org>
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
index e6ee4258169a..449dd64ed9ac 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1681,8 +1681,8 @@ extern struct pid *cad_pid;
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
index 07bb8d4181d7..928a626725e6 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -251,25 +251,16 @@ static inline gfp_t current_gfp_context(gfp_t flags)
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
2.46.1


