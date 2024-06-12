Return-Path: <linux-fsdevel+bounces-21550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B69290591C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 18:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D8591C20DB8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 16:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC12B181CF3;
	Wed, 12 Jun 2024 16:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpKSVlTp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB9C17FAB2;
	Wed, 12 Jun 2024 16:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718210845; cv=none; b=cMPFi2NEkWLZTuVtJxG7880Xfgemk5knL/q/gWFye4RhM39ScIXldjgPHLdOoXQnITdghSci/09EXjq3AxKac2v945A16AvB9hjjuKYNo6CC0iWEImvZI64aInRzGPbsXvmVSTwpPsb9nDfDlAHXtrlWaGMHFES52pBHvjRy3tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718210845; c=relaxed/simple;
	bh=i1VqQul0aDavmR/6DXs1c0vrMHV9t54lQ1/SdKFFgcA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KUb7hlIxZRZSssstz33JWNkZFItl0/W9aO0LiisXAk07Y5hRBxM0MdD+QB778NzITjwAaSB/+rLHuv4N9DFCeE4mjQYDCggRHfG10rdimB/KsmPPFZ9EDbhdP0ts8+aXJ5j/eg/Rf7p6ih32LolfEc4LO8ua6coySMP/Wb1SsC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpKSVlTp; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52c32d934c2so105074e87.2;
        Wed, 12 Jun 2024 09:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718210842; x=1718815642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3LSxFCdDc2AZqzsEX2s/C0J4Wg0gWxXtxhy1sWyLans=;
        b=SpKSVlTpjgDwftsFOBfi9fyEoCinBkQpmrLfXi8v8dtabzEWdQtqjJSp/l9XkPZMQQ
         qfJyUu3TCAHAQ8on3hR2HfRMk2FIYx1G8kabtLkm/Tx7brPmZcHsX/i30hDfdg+4Gb3N
         7LT3hUGeZOwgEVrvy+H+WAQQnEW/y/xD1DU11wIf6ZP4WH4RM01RLSXOR8b5r9/3kPK9
         4GrQJtGySGtv3ANAJh91vpWfEdXBA0LCrcpGYgFmkJ0QeHNUR7H20SXDxiqUoNJetB2D
         0Q0IYrYLoSSB5KYju+KhpBLcme03NpdNS/UtySh2W51bi12TzO0KOzcfTf7Z8nP4j/pM
         C2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718210842; x=1718815642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3LSxFCdDc2AZqzsEX2s/C0J4Wg0gWxXtxhy1sWyLans=;
        b=woG6VKWWja0rJCHlmJ8agtDNCdbtd+s49vpCaxTsR6Z3uLVcfhFNNymzQV9xKwwker
         qAN5IkQUrZQm3lbIAQKxHjQRHkaXLUI1H27S3m2VT6KYwhydliVgBko4xT8Oq838j2R2
         HUkehZz4f39wytCkod1W3uNCi0C1mUzjckv/bvIywC9M1imvHxTieNG+A0rP/TSkSKzY
         fpR1HRfzhpAjUsZNEhmuQCMQyBqQWssWyRknStU/upSnHB8EDt3x3vMfW403CCAFzPTk
         lWdepkbnixbIZC+qYU3qzBcqPt0VwlVg9sOJXjLCJEArdyCdWWELECEoYnx1JrtbJv0I
         mHZA==
X-Forwarded-Encrypted: i=1; AJvYcCXpYbhXTwz9jRWim2z7O13GNv/Dln0/mBd4c40ghfzaU7fNO07WSGMu7r7UHSd+TCoOQDYPetnt5ud5/bv18xLNV1iEX6i6dDEgpzZYJ5wziceTZUeRVd+XFWu7JQbEeJ1bN/CWBxvdk5rboA==
X-Gm-Message-State: AOJu0Yx+llM9p+YrdnnRBX7NRfTBoGKMxhr92TPRP77QSM1MVkRtmi+k
	9guXrkn2EYSuGcyKZld7nUS1KREMYgPwRvthmCCEUOgYhvTyHmDupKoWDQ==
X-Google-Smtp-Source: AGHT+IHQuyWYKttlD7FyL3MnPGfd0WS563CXW9xMTDu6ak9IsSR1KZ34aIT41UCLCfzx1GUtyPkiXw==
X-Received: by 2002:a05:6512:3b27:b0:52c:6ff5:aecc with SMTP id 2adb3069b0e04-52c9a3fe607mr1642650e87.51.1718210841736;
        Wed, 12 Jun 2024 09:47:21 -0700 (PDT)
Received: from f.. (cst-prg-65-249.cust.vodafone.cz. [46.135.65.249])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f0ce4b62fsm13786703f8f.80.2024.06.12.09.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 09:47:21 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] vfs: move d_lockref out of the area used by RCU lookup
Date: Wed, 12 Jun 2024 18:47:15 +0200
Message-ID: <20240612164715.614843-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
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
  38.09%  [kernel]              [k] lockref_put_return
  26.08%  [kernel]              [k] lockref_get_not_dead
  25.60%  [kernel]              [k] __d_lookup_rcu
   0.89%  [kernel]              [k] clear_bhb_loop

__d_lookup_rcu is participating in cacheline ping pong due to the
embedded name sharing a cacheline with lockref.

Moving it out resolves the problem:
  41.50%  [kernel]                  [k] lockref_put_return
  41.03%  [kernel]                  [k] lockref_get_not_dead
   1.54%  [kernel]                  [k] clear_bhb_loop

benchmark (will-it-scale, Sapphire Rapids, tmpfs, ops/s):
FreeBSD:7219334
before:	5038006
after:	7842883 (+55%)

One minor remark: the 'after' result is unstable, fluctuating between
~7.8 mln and ~9 mln between restarts of the test. I picked the lower
bound.

An important remark: lockref API has a deficiency where if the spinlock
is taken for any reason and there is a continuous stream of incs/decs,
it will never recover back to atomic op -- everyone will be stuck taking
the lock. I used to run into it on occasion when spawning 'perf top'
while benchmarking, but now that the pressure on lockref itself is
increased I randomly see it merely when benchmarking.

It looks like this:
min:308703 max:429561 total:8217844	<-- nice start
min:152207 max:178380 total:3501879	<-- things are degrading
min:65563 max:70106 total:1349677	<-- everyone is stuck locking
min:69001 max:72873 total:1424714
min:68993 max:73084 total:1425902

The fix would be to add a variant which will wait for the lock to be
released for some number of spins, and only take it after to still
guarantee forward progress. I'm going to look into it. Mentioned in the
commit message if someone runs into it as is.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/dcache.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

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
-- 
2.43.0


