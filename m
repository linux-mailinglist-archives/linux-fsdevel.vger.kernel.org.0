Return-Path: <linux-fsdevel+bounces-59913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFB3B3EFF0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 22:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B547201AEB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 20:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEDA279334;
	Mon,  1 Sep 2025 20:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="WgByGC6N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBBC2773F0
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 20:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756759840; cv=none; b=udHLBHqDkqCSQ6REg/zQbZAi2jd95GynDEmunKObGeErkV1x3pZQFFrFxwriWExhp5NVJ/osQgLS2byAHmT/N/yjw8hTZ9pAYvNKvx5iZrUmyUWlES2dJ3oxmrMBQiTcndzLPtBQPbCU939Xzk+jSfBbSGSrCcnOzcteiRWXJrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756759840; c=relaxed/simple;
	bh=pIfWjTspfVpzMSCvftG/V3B9Wm60B/72pG+k5Selb38=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UNWjhpkOStiJbXliEIm3e71gdfM0jJXnQKzf/Ob31i6e2rAavsrAZoEPvdKDjhJwmTO9+IOeBOUfilgqg1PbUP5yM1Q4oSj+Lv2D40s3ZYBtyNy4sgKIigXC9tJLASBfEGsZSFtLqYLHFYo7rON9/y9U9kw6e8fDQDrZ1Q3ZWz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=WgByGC6N; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b04271cfc3eso186749766b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Sep 2025 13:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756759837; x=1757364637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1NuH6wEtYyVWN8h/tjwWnU8YD95rrkeNOHDYWS/pAsg=;
        b=WgByGC6NSlJR76DFMsCh3TbOuWDHYmmut9svV5zqWVLCNb2irhPSefTDsy3Fgt1xAe
         /qZFWmgwyplyxGVhxeJBKnndKGspwrntEcGMqeGDtGCZiK19PtNEAkGkQKdvO7vKZCh2
         UO9hew9rsRZXQ0fjM5K1UJDO/+PYrxysRjn8132+uVCHCJ0H7R37uyX9DlAEniWYoHAp
         pdvbi0pcxU7/l9sV/Q6GcEh1iPXnejY6x/AQ8aHXUGQfKEFSKFk4wrGyyVj/VqetKIIj
         prE+bb+OrNfy+D9+paZyG3U6vLfEfQbVbzKBUM2Jva+/Mmmy91D3nJOQQmemKZ02jknX
         oYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756759837; x=1757364637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1NuH6wEtYyVWN8h/tjwWnU8YD95rrkeNOHDYWS/pAsg=;
        b=VMpMuN0W/dSvjhOBeVaFQ8HTZoemEHq4+7HW3GeuwH6Tm+EhJtd/mAdqN2kAUMJzJ0
         OQAcbJlt2ekS6Uv+aASGbJhMormVPSXvKQW8xOotd7nhHmiqRqKLB/FAQyD66xknPFqW
         bl15nPzXCwdurnY/lE34xL0jM4r383G/aEA7QuSv8Dq/1U5PpCdD2fQUkDUFAb4c2Wl9
         vXYq22QJ0XrBHDK59lOeeHeOt2R+cT5Hva5LqxHb5bODZ4EGZa85HNNA6VS0bWp35LKw
         of4N/ps772VzMs4yMW2pDHVRy4P6JkHIEUAaQK8AwleQt2zsyvkWW+j+/IpBMAlQALr3
         FB+g==
X-Forwarded-Encrypted: i=1; AJvYcCXrjcghlJoOJ4NFksAXygY0F61ytZk0/6FuwblQLMMoixTG6WjMRAQhONw7FicyKkiwi70a4DVKLQBHdHbj@vger.kernel.org
X-Gm-Message-State: AOJu0YwjLrJSD3tlS3VHyhVmJvY/UnigA7WYPtAp6s4hlG8DCCo6YFvN
	hpAa5svQCfBgzwkO6xs4Pv0XeJlCaPpzWVx06J/zkMkKzLUCz4jzshTF/Klm2qtbkwk=
X-Gm-Gg: ASbGncvVtDvXWlLqRy2i9H70gHfqNBYPT02zwxypvnHIcx8b8S1jRhH5iOco8YVJkcO
	Unn6MWobsOZuqNVN3wX6L3qMqnzS+uPgxqRn0u8tW8/CXexKHZUR8FrS77ATQiyJpmvu+qJfFcT
	xGCBHRngXp/18joNmBrp20r0gtcfxnB1zUV9LQonyyIa9C1pfuEWnShoxmQQ6odXTL4nnGtCdMC
	nqzz0pUX//lGpkWOlIsYLAz+hIdbmK01UuaGjm+OoIPTIZPGqxbiVhjoHdTgg1wpooZajqIasWb
	cXYR+6hZK6uZIzb8DWAvlhljok9OJQET3eIF+2nU6YJaclfRBZ5dWN3MajASl2yLGSVuV+QrVDs
	U2auoxEWXrW6TmcX9kR3v3ZZ0nSnqkfLYBu0Cu8tAaNCxSxCNJ6qGrQNWIJXXYXgkZ6JOTy+man
	FletLNuxikmGlItISYsourbw==
X-Google-Smtp-Source: AGHT+IFXutjj9GtlvsHvyB1kBP2ci7mQOIWVVvptrXf9bm8LYmlGCi75h3LAGpjp/G/Rnzqw/keEdA==
X-Received: by 2002:a17:907:3e89:b0:af9:e1f0:cd30 with SMTP id a640c23a62f3a-b01df53b7c4mr910004866b.60.1756759837088;
        Mon, 01 Sep 2025 13:50:37 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcbd9090sm937339066b.69.2025.09.01.13.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 13:50:36 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	willy@infradead.org,
	hughd@google.com,
	mhocko@suse.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	vishal.moola@gmail.com,
	linux@armlinux.org.uk,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	davem@davemloft.net,
	andreas@gaisler.com,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	weixugc@google.com,
	baolin.wang@linux.alibaba.com,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	max.kellermann@ionos.com,
	thuth@redhat.com,
	broonie@kernel.org,
	osalvador@suse.de,
	jfalempe@redhat.com,
	mpe@ellerman.id.au,
	nysal@linux.ibm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-parisc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 05/12] mm: constify process_shares_mm() for improved const-correctness
Date: Mon,  1 Sep 2025 22:50:14 +0200
Message-ID: <20250901205021.3573313-6-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901205021.3573313-1-max.kellermann@ionos.com>
References: <20250901205021.3573313-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function only reads from the pointer arguments.

Local (loop) variables are also annotated with `const` to clarify that
these will not be written to.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm.h | 2 +-
 mm/oom_kill.c      | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 18deb14cb1f5..f70c6b4d5f80 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3840,7 +3840,7 @@ static inline int in_gate_area(struct mm_struct *mm, unsigned long addr)
 }
 #endif	/* __HAVE_ARCH_GATE_AREA */
 
-extern bool process_shares_mm(struct task_struct *p, struct mm_struct *mm);
+bool process_shares_mm(const struct task_struct *p, const struct mm_struct *mm);
 
 void drop_slab(void);
 
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 17650f0b516e..58bd4cf71d52 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -490,12 +490,12 @@ static bool oom_killer_disabled __read_mostly;
  * task's threads: if one of those is using this mm then this task was also
  * using it.
  */
-bool process_shares_mm(struct task_struct *p, struct mm_struct *mm)
+bool process_shares_mm(const struct task_struct *p, const struct mm_struct *mm)
 {
-	struct task_struct *t;
+	const struct task_struct *t;
 
 	for_each_thread(p, t) {
-		struct mm_struct *t_mm = READ_ONCE(t->mm);
+		const struct mm_struct *t_mm = READ_ONCE(t->mm);
 		if (t_mm)
 			return t_mm == mm;
 	}
-- 
2.47.2


