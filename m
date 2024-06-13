Return-Path: <linux-fsdevel+bounces-21578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87097905F9F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 02:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 302E11F214BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 00:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29E263A5;
	Thu, 13 Jun 2024 00:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nF3hm3Lx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3C52F30;
	Thu, 13 Jun 2024 00:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718237556; cv=none; b=QROAfvEkOT1WZgW+F53++ebcs0YhIK7VaEI20cNwPyPcXfO34qWUiUnN5NRyBZ7WJwKD1sb39ZaZ/WmkvMEoQ42UFo+enpU3bscyozQznwehoSah8fUaiVhNbSwar1bM/k0vi03Qur/TSH7nJ+WJhEkdD4hFFkktOKjzkepuRuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718237556; c=relaxed/simple;
	bh=4CN0BABw9P45+dIm5MM8+Z9BGuyxpCqM9kUy0ysbb6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+oT7Ytn7hwhyefLv/TpScCiuZkh2RqpGIGSh57tKijvMqskVT2VPwF5HkAoFArzU6n+WZopq7GwJzlWB39CXrQhqFbAJiyztgTmiqyL7Wc7ElVhBiFjSM/o0DLd7W2RpoMebQ26Px1m7fvWr3Ov8bDRpKHDVniV7DnE9zIOhRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nF3hm3Lx; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-35f24fabb81so458043f8f.3;
        Wed, 12 Jun 2024 17:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718237553; x=1718842353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=skJsGTfQA/atlXrCIf+eUs5ghWrbbjUT30HKSoC+DWs=;
        b=nF3hm3LxSxoGBHe/AmZlRSjhYXKvn/ywUys3ny+yNNOIzvmjNF+VRVZdYv6lrQ48ba
         U7pnqs0AlTVF5P3XCC0CZSrXA9dQKRkHeWdPC2Zetkbx28K7nXpZb9Ez9QGhzhhzikQe
         qzOL01R83/CiKsauLWL3yX7ptIyNSDgtV8Kb7rW9gee584GSYyo3r/fkhX0jBxfZYn2r
         q0+6U0HrqnaRr46P7QAcRMBJzl0VDEli6SdGPli4neYRZSJmTlcZ9+JFNEyD31zhC3fj
         XSrmwH4v5GWhSLDjOj9OIdVUqH0S+8HDURHh5OkhqbPHMgz6Te2Zu2Zon53DaA9EAjEs
         18jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718237553; x=1718842353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=skJsGTfQA/atlXrCIf+eUs5ghWrbbjUT30HKSoC+DWs=;
        b=j/SQsuYKvJDXYIgmGgAlqPGjUz1M/S0oz8KAAB5Wx2DUbQ1O3Dbv7e7ZhN3PyolNcM
         G4MHvNNX7msyX+/mD/1yO+807cnS2HZ3003Gu4mWWXBMscSCz6OFPFBsVm0QsJ1ly8X0
         HAs5YTmYKUnJ3kVHcy/OWDUeRK0KMoh+c1SnT/ga74GIahPS95zzcFZ6aSjdSJ4MM+cW
         Nix/V20QV43hdJ7oGOAmpmEC+o6PwAhe7FSSjzXyppkPPlnOWbX9kl3tK4dtvF6QLsmn
         dG/Q6toNIB+ShZlGZNbj9Bp76DBQMAK4zL7WKK1eFJtkt7c62RmyV71jwgO5+pDbHRWP
         e/Pg==
X-Forwarded-Encrypted: i=1; AJvYcCWguGp7RSQihVUi4KuiT2efIWy2GH7ffli5jm2j7vT/uzsweCLCEFFnH2INz4epJY1FBve6EiMjbjhV+rbqqPN1XUmd+p1sxQ/WaWXykZCRkHwlHm/helV7yiIx8wyKiy1ORB7H+KM1F2L3yg==
X-Gm-Message-State: AOJu0YwKtOTdpOgJFj8t6ZKPTUXUcXlkZAlcEQLQGliKhFewC8L31OHf
	56oIqJwdkjUxMWHmbSXE3zHaLCnC9xaLAV5lgXyihv8keHWJNj6bD/gfFg==
X-Google-Smtp-Source: AGHT+IFmdvPhq1t2HVQXAKgkUAxLvn/tCNhQ3cEx2SPcDqi3MH5JN7s2+xM+NatUFQjLGS7UgRfuAQ==
X-Received: by 2002:a5d:4d01:0:b0:35f:1c34:adfc with SMTP id ffacd0b85a97d-35fe8937f33mr2232162f8f.67.1718237552999;
        Wed, 12 Jun 2024 17:12:32 -0700 (PDT)
Received: from f.. (cst-prg-65-249.cust.vodafone.cz. [46.135.65.249])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750f2489sm145114f8f.69.2024.06.12.17.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 17:12:32 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: torvalds@linux-foundation.org
Cc: brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 2/2] vfs: move d_lockref out of the area used by RCU lookup
Date: Thu, 13 Jun 2024 02:12:15 +0200
Message-ID: <20240613001215.648829-3-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240613001215.648829-1-mjguzik@gmail.com>
References: <20240613001215.648829-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Stock kernel scales worse than FreeBSD when doing a 20-way stat(2) on
the same tmpfs-backed file.

According to perf top:
  38.09%  lockref_put_return
  26.08%  lockref_get_not_dead
  25.60%  __d_lookup_rcu
   0.89%  clear_bhb_loop

__d_lookup_rcu is participating in cacheline ping pong due to the
embedded name sharing a cacheline with lockref.

Moving it out resolves the problem:
  41.50%  lockref_put_return
  41.03%  lockref_get_not_dead
   1.54%  clear_bhb_loop

benchmark (will-it-scale, Sapphire Rapids, tmpfs, ops/s):
FreeBSD:7219334
before:	5038006
after:	7842883 (+55%)

One minor remark: the 'after' result is unstable, fluctuating in the
range ~7.8 mln to ~9 mln during different runs.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/dcache.h | 7 ++++++-
 lib/lockref.c          | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index bf53e3894aae..326dbccc3736 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -89,13 +89,18 @@ struct dentry {
 	struct inode *d_inode;		/* Where the name belongs to - NULL is
 					 * negative */
 	unsigned char d_iname[DNAME_INLINE_LEN];	/* small names */
+	/* --- cacheline 1 boundary (64 bytes) was 32 bytes ago --- */
 
 	/* Ref lookup also touches following */
-	struct lockref d_lockref;	/* per-dentry lock and refcount */
 	const struct dentry_operations *d_op;
 	struct super_block *d_sb;	/* The root of the dentry tree */
 	unsigned long d_time;		/* used by d_revalidate */
 	void *d_fsdata;			/* fs-specific data */
+	/* --- cacheline 2 boundary (128 bytes) --- */
+	struct lockref d_lockref;	/* per-dentry lock and refcount
+					 * keep separate from RCU lookup area if
+					 * possible!
+					 */
 
 	union {
 		struct list_head d_lru;		/* LRU list */
diff --git a/lib/lockref.c b/lib/lockref.c
index 596b521bc1f1..c1e2736a7bac 100644
--- a/lib/lockref.c
+++ b/lib/lockref.c
@@ -45,7 +45,7 @@
 static inline bool lockref_trywait_unlocked(struct lockref *lockref)
 {
 	struct lockref old;
-	int retry = 100;
+	int retry = 256;
 
 	for (;;) {
 		cpu_relax();
-- 
2.43.0


