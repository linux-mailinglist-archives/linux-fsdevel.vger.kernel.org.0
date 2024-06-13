Return-Path: <linux-fsdevel+bounces-21577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDB0905F9D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 02:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ECC21C21754
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 00:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943A22CA6;
	Thu, 13 Jun 2024 00:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJp9VgaE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B1D15CB;
	Thu, 13 Jun 2024 00:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718237554; cv=none; b=rEjK1q1EBkvAjoeQD1Lbg244LSPTEkprU1i/UsdLPjyUapdVHKqBsL0vWLTnX5x5i2PuYBWq01OfSe6vzvuALfGCpkDDq82ICkRxyDuCxPEAJoBAvVPdCxi0xFolaOgle1V9jI12HtXMfkzoRUEVnB7xBvLbpEfUw3J9M66ja4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718237554; c=relaxed/simple;
	bh=8EUyhfj+zpqg4Fce77r2+ZXQqEGm3vNZ/nYjDp2Nkc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U57g4pSxf925xCiFteMQkZ60Mr+j83Q6cbO4UiCGFW4xNeHQxw9popR0lMIa0aLibHw4cf89Qiaf4/CGPWo2CyRcvGoo6JEn3HPS6Dv8DCF7W74funWOw+z/T/wp1tqfQ15vj41GRdySpMtCC8CEqA4qBHIvSEs0QwwJ/70wadQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJp9VgaE; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52bc335e49aso558904e87.3;
        Wed, 12 Jun 2024 17:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718237549; x=1718842349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXABC3gILXNUweUcHa6z6RMjkl0AXhA15Mutin2/Bpc=;
        b=DJp9VgaEUCVmwAuDgVdyCna+LtZ+JrlYoUXYW/xSKPW4+BVNLf1cH/YSRuRRpJG+BS
         1oCHXvnysEnhM9w9YTVvX0wdOK8gN3qTsxVwBggEMruDdMFXfzTLrweB173GaKncJhb/
         /BCT4YY4RrJrKqviPmIO6iyir5SCTW07s2BAVFcT+Gix9o/LXdnQPFwWIlukN2k0plpR
         mZ6tS7y5bXmscBWGTXqoN0YgMM09sbPfe9417thSUfmnBJTZ5m1o2A3UiGoVQ8J2MxcX
         15Fwj/6nzhKyAsSjIns9cg/bQs3fC0S0pTLO0KD94yuAIoBl9r/gbN7xFdsdDzJM8xnh
         8zRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718237549; x=1718842349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXABC3gILXNUweUcHa6z6RMjkl0AXhA15Mutin2/Bpc=;
        b=SVQEzLaXL7Np4nqANjvZ4MdUs2Tu/vUHaoEnXssG/E8ne1FMR8Kb4oUYKIClEmkRuA
         /8vrnrUfc6xnJ2QJBubf1Y9cYJDAHIGhAqdE50D4kpUm5V05iSXEAtyS94JgsYsykqZq
         ZXP0nTK5TJRdyBtxwKzFj7cnqAYS5IE9hZ5fzJagfPE7y7kmOge1zwFePYUjsKmARg4/
         cFt9MCfYcyIJhATbLN0INbBrKUlsSC/CHUnbipO7hXU2veA6ereFdSEH1AYlDUJJ1agE
         6IjrOP4lPhcSm3+Kr05x5PZYgAS04B5xmPEjuS499PrlzvryyEMlddr7xiHd5tNawXgL
         Q/nQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfT9y035cb5LWkFHFswqfmkNzRYrIXCH/PyG4W/QqxGXnXBtjBCEP1FsYryDvPJxFqhCgw7gew2bU+OYuIWoW7nMpJ+a2hoTjRq3KSkHdrqCZrlos2sz+LwoNFxAZHQ86AeFNZZmjHWm+IJQ==
X-Gm-Message-State: AOJu0YwnhKa9hpOEHjjvBK0LmMDlUm5H2TyJqUS9AtDUKKHhpMQMfhHB
	V/VTVb1YWUSFV6TE0eJt5ujivFah+4FAyHiFuplqi+MhiEkEtzxb
X-Google-Smtp-Source: AGHT+IGjPBG5pMhwkwGYp05epSPLIMXAMD1I3C5uel4NRtBgDRj93E7KJ2rVGTs5w8txmElp3SaDCg==
X-Received: by 2002:a05:6512:2f7:b0:52c:88b8:12ab with SMTP id 2adb3069b0e04-52c9a3c7362mr1662292e87.23.1718237549121;
        Wed, 12 Jun 2024 17:12:29 -0700 (PDT)
Received: from f.. (cst-prg-65-249.cust.vodafone.cz. [46.135.65.249])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750f2489sm145114f8f.69.2024.06.12.17.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 17:12:28 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: torvalds@linux-foundation.org
Cc: brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 1/2] lockref: speculatively spin waiting for the lock to be released
Date: Thu, 13 Jun 2024 02:12:14 +0200
Message-ID: <20240613001215.648829-2-mjguzik@gmail.com>
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

The usual inc/dec scheme is to try to do it with atomics if the lock is
not taken and fallback to locked operation otherwise.

If the lock is only transiently held routines could instead
speculatively wait and avoid the acquire altogether.

This has a minor benefit of slightly speeding up cases of the sort,
which do happen in real workloads.

More importantly this fixes a corner case where lockref consumers
degrade to locked operation and are unable to go back to atomics.

Consider a continuous stream of lockref ops from several threads and
another thread taking the lock for a brief moment. Any lockref user
which manages to observe the lock as taken is going to fallback to
locking it itself, but this increases the likelihood that more threads
executing the code will do the same. This eventually can culminate in
nobody being able to go back to atomics on the problematic lockref.

While this is not a state which can persist in a real workload for
anything but few calls, it very much can permanently degrade when
benchmarking and in consequence grossly disfigure results.

Here is an example of will-it-scale doing 20-way stat(2) on the same
file residing on tmpfs, reports once per second with number of ops
completed:
[snip several ok results]
min:417297 max:426249 total:8401766	<-- expected performance
min:219024 max:221764 total:4398413	<-- some locking started
min:62855 max:64949 total:1273712	<-- everyone degraded
min:62472 max:64873 total:1268733
min:62179 max:63843 total:1256375
[snip remaining bad results]

While I did not try to figure out who transiently took the lock (it was
something outside of the benchmark), I devised a trivial reproducer
which triggers the problem almost every time: merely issue "ls" of the
directory containing the tested file (in this case: "ls /tmp").

The problem does not persist with the fix below.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 lib/lockref.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/lib/lockref.c b/lib/lockref.c
index 2afe4c5d8919..596b521bc1f1 100644
--- a/lib/lockref.c
+++ b/lib/lockref.c
@@ -26,10 +26,46 @@
 	}									\
 } while (0)
 
+/*
+ * Most routines only ever inc/dec the reference, but the lock may be
+ * transiently held forcing them to take it as well.
+ *
+ * Should the lock be taken for any reason (including outside of lockref),
+ * a steady stream of ref/unref requests may find itself unable to go back
+ * to lockless operation.
+ *
+ * Combat the problem by giving the routines a way to speculatively wait in
+ * hopes of avoiding having to take the lock.
+ *
+ * The spin count is limited to guarantee forward progress, although the
+ * value is arbitrarily chosen.
+ *
+ * Note this routine is only used if the lock was found to be taken.
+ */
+static inline bool lockref_trywait_unlocked(struct lockref *lockref)
+{
+	struct lockref old;
+	int retry = 100;
+
+	for (;;) {
+		cpu_relax();
+		old.lock_count = READ_ONCE(lockref->lock_count);
+		if (arch_spin_value_unlocked(old.lock.rlock.raw_lock))
+			return true;
+		if (!--retry)
+			return false;
+	}
+}
+
 #else
 
 #define CMPXCHG_LOOP(CODE, SUCCESS) do { } while (0)
 
+static inline bool lockref_trywait_unlocked(struct lockref *lockref)
+{
+	return false;
+}
+
 #endif
 
 /**
@@ -47,6 +83,14 @@ void lockref_get(struct lockref *lockref)
 		return;
 	);
 
+	if (lockref_trywait_unlocked(lockref)) {
+		CMPXCHG_LOOP(
+			new.count++;
+		,
+			return;
+		);
+	}
+
 	spin_lock(&lockref->lock);
 	lockref->count++;
 	spin_unlock(&lockref->lock);
@@ -70,6 +114,16 @@ int lockref_get_not_zero(struct lockref *lockref)
 		return 1;
 	);
 
+	if (lockref_trywait_unlocked(lockref)) {
+		CMPXCHG_LOOP(
+			new.count++;
+			if (old.count <= 0)
+				return 0;
+		,
+			return 1;
+		);
+	}
+
 	spin_lock(&lockref->lock);
 	retval = 0;
 	if (lockref->count > 0) {
@@ -98,6 +152,16 @@ int lockref_put_not_zero(struct lockref *lockref)
 		return 1;
 	);
 
+	if (lockref_trywait_unlocked(lockref)) {
+		CMPXCHG_LOOP(
+			new.count--;
+			if (old.count <= 1)
+				return 0;
+		,
+			return 1;
+		);
+	}
+
 	spin_lock(&lockref->lock);
 	retval = 0;
 	if (lockref->count > 1) {
@@ -125,6 +189,17 @@ int lockref_put_return(struct lockref *lockref)
 	,
 		return new.count;
 	);
+
+	if (lockref_trywait_unlocked(lockref)) {
+		CMPXCHG_LOOP(
+			new.count--;
+			if (old.count <= 0)
+				return -1;
+		,
+			return new.count;
+		);
+	}
+
 	return -1;
 }
 EXPORT_SYMBOL(lockref_put_return);
@@ -181,6 +256,16 @@ int lockref_get_not_dead(struct lockref *lockref)
 		return 1;
 	);
 
+	if (lockref_trywait_unlocked(lockref)) {
+		CMPXCHG_LOOP(
+			new.count++;
+			if (old.count < 0)
+				return 0;
+		,
+			return 1;
+		);
+	}
+
 	spin_lock(&lockref->lock);
 	retval = 0;
 	if (lockref->count >= 0) {
-- 
2.43.0


