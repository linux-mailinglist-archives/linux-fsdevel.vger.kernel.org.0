Return-Path: <linux-fsdevel+bounces-25657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 096EB94E94C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 11:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA7E2282701
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 09:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8652516CD33;
	Mon, 12 Aug 2024 09:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSqNqVs9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B38516CD09
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 09:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723453692; cv=none; b=gRyGeKnRhLO8J/ZkpsCGl4VJPWLD87YdYwi9xTteWtOpfEZonLilJUY6Z8M9IYnQmi/Tw7ioo17SYAVKbU5niSLVSyyyawUa7flwaH8o5S7Fcw5a/lGhuriFvVevHYnqxAtQRPD8cLGZzTAy1VRdPkjmRJ+PBEKs1WPjeYCrs2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723453692; c=relaxed/simple;
	bh=c0nm3wMgXT/i4pvayoamWwOeLf1vT1TOhysmNV/MZ4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YzG03juWu1IldVlo3nSfHQGkEHqsUAu0fDs6rWAuiSr74Uei3ufZrTYV9hjUnS63b1/iIOMjdvTe7p+xSzLqP6T6R0Seegu6JxYV07YVqfczJ5pYewAHFdqjuJCI6qI95PJTyMKLAqdZHvfiwR6wIt5vvAKgtaGoLkCImSV4bYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSqNqVs9; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7c3e0a3c444so809049a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 02:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723453690; x=1724058490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uW/wggQt4+fC5FS7O2qa+UrIg3yhUVffXpSgh2WeTHM=;
        b=WSqNqVs9YaPLBcbT3rhuF+IBZt0BPbuUoibPTv/HUz4B00TibdqqJ8SRYv8ZO7syRE
         S9E+Bnf8PfpX0jOzL2nUvV2Cnr0TJpFAtCVM38pQC6mQ/O4lVYpE4tw0IdpQ5PcaExpV
         F9RysxbiE8MAtcSszW4ALEwoFBeI5xvnXxZc4nGGutHR4vkHXixHPzPOzqJ+WG97nEP4
         sHbZ9jqE0FFFOknpZFt9YwEqtWaxYvwPTP4CAcTzgXaWF4Ww9RMBbIorh6Adlu8bH6sI
         2LLc3zG94NF+NDYw+lRmz3VdZXWoBRtIwISb8SeCwUXYF8h2QntPZSGPz9PSu19zXYIo
         YLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723453690; x=1724058490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uW/wggQt4+fC5FS7O2qa+UrIg3yhUVffXpSgh2WeTHM=;
        b=Z9Yp59D2SZzZEgyDiRrIzQsIVNGBrmGLAubAIse41AzlDzxHggN6F9EassObQRS6Sq
         kcuWNS44YZ7+wUh2P9MGQw7vlVLBgRSf0e2qLizQansc04eu6v7TaYJT0HAfGQoZG8S8
         hnqSYHm14t8hD7tzS0qyrhNCazz+EoIkZLsIY/s6fHwqF4SM4a4ef4JIYJabXI7awhL0
         yS9f5pvJxEdvIyl+ZkM16wZzvTlGchG9nspU7zxET9fnjTWBB1cskuQt67YjaKneKw4X
         TZMoZ7VCwTdR2wJNLOv07r6uStghk4osbqtUUmBFw5Zp0xkyG6Mofrcg1NTLGguVrth3
         o5Pg==
X-Gm-Message-State: AOJu0Yy724v2TXkwdY2XuUf1gmkx4fpNvzktsS1znvEwJ7hw5IoF3exv
	0X9AN/qyaveVTm7qvRo32961bm2trf1GSj27MKr29Ag1+ifTVW0I
X-Google-Smtp-Source: AGHT+IE1i6xyCeItPKPHLZKTP2IE8z8mnnUgaQUwOgbT0kf6fXpWdfbwyKP6TfANTizn3kIlf0hKgA==
X-Received: by 2002:a17:90b:3557:b0:2cb:58e1:abc8 with SMTP id 98e67ed59e1d1-2d1e7fe73acmr12996541a91.21.1723453689637;
        Mon, 12 Aug 2024 02:08:09 -0700 (PDT)
Received: from localhost.localdomain ([39.144.39.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1fce6cfc1sm4450262a91.6.2024.08.12.02.08.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2024 02:08:09 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	david@fromorbit.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 1/2] mm: Add memalloc_nowait_{save,restore}
Date: Mon, 12 Aug 2024 17:05:24 +0800
Message-Id: <20240812090525.80299-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240812090525.80299-1-laoar.shao@gmail.com>
References: <20240812090525.80299-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PF_MEMALLOC_NORECLAIM flag was introduced in commit eab0af905bfc
("mm: introduce PF_MEMALLOC_NORECLAIM, PF_MEMALLOC_NOWARN"). To complement
this, let's add two helper functions, memalloc_nowait_{save,restore}, which
will be useful in scenarios where we want to avoid waiting for memory
reclamation.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/sched/mm.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 91546493c43d..4fbae0013166 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -484,6 +484,36 @@ static inline void memalloc_pin_restore(unsigned int flags)
 	memalloc_flags_restore(flags);
 }
 
+/**
+ * memalloc_nowait_save - Marks implicit ~__GFP_DIRECT_RECLAIM allocation scope.
+ *
+ * This functions marks the beginning of the ~__GFP_DIRECT_RECLAIM allocation
+ * scope. All further allocations will implicitly drop __GFP_DIRECT_RECLAIM flag
+ * and so they are won't wait for direct memory reclaiming. Use
+ * memalloc_nowait_restore to end the scope with flags returned by this
+ * function.
+ *
+ * Context: This function is safe to be used from any context.
+ * Return: The saved flags to be passed to memalloc_nowait_restore.
+ */
+static inline unsigned int memalloc_nowait_save(void)
+{
+	return memalloc_flags_save(PF_MEMALLOC_NORECLAIM);
+}
+
+/**
+ * memalloc_nofs_restore - Ends the implicit ~__GFP_DIRECT_RECLAIM scope.
+ * @flags: Flags to restore.
+ *
+ * Ends the implicit ~__GFP_DIRECT_RECLAIM scope started by memalloc_nowait_save
+ * function. Always make sure that the given flags is the return value from the
+ * pairing memalloc_nowait_save call.
+ */
+static inline void memalloc_nowait_restore(unsigned int flags)
+{
+	memalloc_flags_restore(flags);
+}
+
 #ifdef CONFIG_MEMCG
 DECLARE_PER_CPU(struct mem_cgroup *, int_active_memcg);
 /**
-- 
2.43.5


