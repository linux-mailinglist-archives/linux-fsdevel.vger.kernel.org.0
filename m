Return-Path: <linux-fsdevel+bounces-61685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 947F6B58D51
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 06:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 797221BC3347
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 04:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE48D2E22BC;
	Tue, 16 Sep 2025 04:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCCFjF93"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80372E229E
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 04:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998137; cv=none; b=egkZNORx3166MiaJoboHe6o/DlvuvOS/4Fd2RwychpPRlFlHsKok2gegXEMzb+QeeHfULWh0nwF+5FmTQRQLLLg6jw7Kxf2Uwq6V5rmxbwO3NqCJIuvgfJVA7a+M8e6KLS21W/ye0WeYsNFE36zt0LDxaNjt6UG2YBVRWBXNrFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998137; c=relaxed/simple;
	bh=p5MwokYTH6tczJBsI6u40p8nW7EOrH93nmvNjBcj/D8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QRQXAqXhW2PhFcP5L1EBgzyEU+3tDyG5HLLD3ThDLLtnIVS73xLekuTGsJR9msG3c5Anl6esHxzFSF5DM4hsxCvShOGGh/P3OkkI3kF1wUPuhZB+lv3MpaJmWbpqtowMMlVIcmkulDn5yue7JXpktLyeNkVkOE2MPGtOvikCPMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCCFjF93; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-266a0e83662so12427475ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 21:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998134; x=1758602934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+E/nxXHnOkpnquuQqI/t3YoOv7z+zhY+r7/SIcSNR5s=;
        b=XCCFjF93gE03XoD5txrRGrVa2Cinpuf9dfznUDiyWczEqJ/NViO8aFYCASV/tcASm9
         f5KFOsk5PZCVrn0wGqzSUFpGQfS2TXroxKwY3fjm5v8H0MZrmvPS3Gk4K4/flnFXJz9M
         N61WImCcsaO7sx60jDVbpP99sDm3mPAR0JjjBMhWWqCwEhxevWM57VQoKx0jUAuys6Hg
         BSa0+ecSoJQrp2zy0poaIzuSEu9xGk14EO1YJKRLVH06V0aibh7cAHh7R7d/mz+iRgA4
         YlgOoTc5CRsv4uXdgCGLuCJsLNv7Nmpo4RhwTjSBaWgkf6NtdAf5g4bFqPqF54kAKrDj
         Ni7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998134; x=1758602934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+E/nxXHnOkpnquuQqI/t3YoOv7z+zhY+r7/SIcSNR5s=;
        b=dkpcdkY8rDpOcUKMwkhhLgonyeZSAyZXYq5gt7Qi+GDBtMKLRHvHQEyEzyFgcAezS8
         XAd3iFf20zxvnA1lvMBZobGTG2RKExNByJxYbQleHe42QbJbOdG/WNf5FWRqFXN6RBoK
         maXGMTYxiu799eJODmsitSaG/DLX0Zq8byBbT0e+5WndZR5V1dsBSTfIzSJVM/jLp0i3
         ST8Gtem6bq/vKh/VHPuBxTRXny54SXJSprieDKHsNUws35Pm7HOBn+Pi1PchlgPobfbH
         QJe5yMc595v5Cch7CxnahzG38cuLu7g4Dejjl8iU+cWnQjsb4qvKs3MeYZQUYZjt8aaG
         F47g==
X-Forwarded-Encrypted: i=1; AJvYcCWSXPmCVfJuS/ZRzAGBimFfIaMTnauHkRSo32fRyMeW2bjoHNgjscc9ioyK5olgpluworheMu3bwcw9TDja@vger.kernel.org
X-Gm-Message-State: AOJu0YyVMW1uGF8Xa6MsJka6/w1DJiSN9v4YRPP056TxXkZR6FWQfKCD
	OnjE5BgUh6M6/i6X8MAToKUWRZZHvDcH4qhWmBBcMLuPUarxZCnFKwn6
X-Gm-Gg: ASbGncuXpIA5Dp+znoD+M6LUu12YtpEcLVaskMyGsERu3D8A6anZjqn6iHKkfF2FzX3
	KoJtlK82z2JkTUqMdimsh+a81ST2bqXdTIPDc1BOCTtQ+hXUTLAO7fITR6LUT23E22Zfn27LZMB
	gAdCgrn1OmAchU/kDN1Fu/XsJJCAV5Q9SJEtFHmV2nmo/Ya5dW2/Cj7na3pOSqnA56BHVvvNOO6
	S5AIPJ5EDdZYMtHky4EPNTVJ8SkT/yM16U6esGx5t7rHifz7pDl1imIld6STToUYULz//7dGowi
	LXO+lzxhpEN/lS2bZpHTcUkmZVeWP/eFSs4MkZ/W+06U9cNQkavAKfsa0aZZZhjnqu0uSrABkX0
	1wLhe2NGbGhvAyZwqKiZSzQjcLL7FTrzChINbYeJFWUyYPu4RKA==
X-Google-Smtp-Source: AGHT+IHsN0GBYzT4MMuIYjW4jOX+BASz3i1Lsko5ULcFSIEXx1CyBAF2xoChVB4z7RicwE9rHAP4nQ==
X-Received: by 2002:a17:902:db02:b0:267:b357:9445 with SMTP id d9443c01a7336-267b35796d4mr43637625ad.28.1757998133829;
        Mon, 15 Sep 2025 21:48:53 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:48:53 -0700 (PDT)
From: pengdonglin <dolinux.peng@gmail.com>
To: tj@kernel.org,
	tony.luck@intel.com,
	jani.nikula@linux.intel.com,
	ap420073@gmail.com,
	jv@jvosburgh.net,
	freude@linux.ibm.com,
	bcrl@kvack.org,
	trondmy@kernel.org,
	longman@redhat.com,
	kees@kernel.org
Cc: bigeasy@linutronix.de,
	hdanton@sina.com,
	paulmck@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-wireless@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-s390@vger.kernel.org,
	cgroups@vger.kernel.org,
	pengdonglin <dolinux.peng@gmail.com>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 06/14] ipc: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:27 +0800
Message-Id: <20250916044735.2316171-7-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916044735.2316171-1-dolinux.peng@gmail.com>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side function definitions")
there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
rcu_read_lock_sched() in terms of RCU read section and the relevant grace
period. That means that spin_lock(), which implies rcu_read_lock_sched(),
also implies rcu_read_lock().

There is no need no explicitly start a RCU read section if one has already
been started implicitly by spin_lock().

Simplify the code and remove the inner rcu_read_lock() invocation.

Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 ipc/msg.c  | 1 -
 ipc/sem.c  | 1 -
 ipc/shm.c  | 1 -
 ipc/util.c | 2 --
 4 files changed, 5 deletions(-)

diff --git a/ipc/msg.c b/ipc/msg.c
index ee6af4fe52bf..1e579b57023f 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -179,7 +179,6 @@ static int newque(struct ipc_namespace *ns, struct ipc_params *params)
 	}
 
 	ipc_unlock_object(&msq->q_perm);
-	rcu_read_unlock();
 
 	return msq->q_perm.id;
 }
diff --git a/ipc/sem.c b/ipc/sem.c
index a39cdc7bf88f..38ad57b2b558 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -579,7 +579,6 @@ static int newary(struct ipc_namespace *ns, struct ipc_params *params)
 	ns->used_sems += nsems;
 
 	sem_unlock(sma, -1);
-	rcu_read_unlock();
 
 	return sma->sem_perm.id;
 }
diff --git a/ipc/shm.c b/ipc/shm.c
index a9310b6dbbc3..61fae1b6a18e 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -795,7 +795,6 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
 	error = shp->shm_perm.id;
 
 	ipc_unlock_object(&shp->shm_perm);
-	rcu_read_unlock();
 	return error;
 
 no_id:
diff --git a/ipc/util.c b/ipc/util.c
index cae60f11d9c2..1be691b5dcad 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -293,7 +293,6 @@ int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
 	idr_preload(GFP_KERNEL);
 
 	spin_lock_init(&new->lock);
-	rcu_read_lock();
 	spin_lock(&new->lock);
 
 	current_euid_egid(&euid, &egid);
@@ -316,7 +315,6 @@ int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
 	if (idx < 0) {
 		new->deleted = true;
 		spin_unlock(&new->lock);
-		rcu_read_unlock();
 		return idx;
 	}
 
-- 
2.34.1


