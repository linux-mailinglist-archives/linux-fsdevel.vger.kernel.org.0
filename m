Return-Path: <linux-fsdevel+bounces-59821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A3807B3E31A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 14:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6FBAC4E28BC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 12:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BDE326D77;
	Mon,  1 Sep 2025 12:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="hZ5F/T7b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA423451AB
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 12:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729846; cv=none; b=mZZ6RgITohy9AWzuEHORqyrXXhnd8ckB8kaeLmhIyV+CDlasFYHzogAJ0VMt9MJ4zqQVmzZ/soWeyIrRVXA2b32ju5xsC1VqooeX23gWbG49cTfpwdXmjFqTlPuPPRUTJLZvlc3X3fhZxysmP1Xlzw7mjGo5AMvQv1nY7jYDp3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729846; c=relaxed/simple;
	bh=+cxA2vPSNHRr3wvM2KI++2tH84Pma8OrgGCHv4aVaOg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BVAAqDNpDosQCBsPGP2wDx8KB0OZ68DZNhVSI5hSb4dTPt/q9BYK2dxPusKq/4ete/MpZ4jJUjC8Qve8NADzqcgzK9eHGhpnkafU3r0WHuMnA/O1F81Ew3Qe8RgPgA5vpk6+dQ7j4V8BSJd5AFuoKNgAHK7kWuDCj6/RbiByt5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=hZ5F/T7b; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61ce9bcc624so4672134a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Sep 2025 05:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756729843; x=1757334643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qlcCpJbD4nPkPuY3yUCOwN5ViUagWq+iHpO5z1mw7KA=;
        b=hZ5F/T7b5ogdP2zIwS2beyZHiGHk1+XC2eeXxcULdlvnW1Qfwq3v3qhdS3HzZ/ke6i
         5aofx44Vci3okcSvD+NJ5d8aUUe81DaRYRI62gRGHaQ356kUTRWx4PGjmcbA7+R+Kk0W
         w5CIFFJJ5MwUK8wOchLuAQ+cRzKPe2L0SPg0C9B92RKpjNxYzM8HJ+ZB9Jvd4NqCxnuc
         FosDiN5pEmLLsAP/Xh7OUY6aKsvmoVYIgNzs6L/oiewJa/5mjN6m0MCx3Jo0RwHJf72I
         eE9i/UnBEou8WSX3ZjYyB3V9cbrUZX3eF8vQR8yykRh+Wj/Fw04dXjpcJtR9Yx5tP11D
         Mpbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756729843; x=1757334643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qlcCpJbD4nPkPuY3yUCOwN5ViUagWq+iHpO5z1mw7KA=;
        b=nRzBiEmXlAI6vBFLmnHOToUtzrbV/M4oobbWvGiALrp2s3Bnia3tSptsOZJPH6921s
         tybL8y0QCnRoLH/OHgODnbBN2lzlvJwPp2sNf5MlVyGluAonKIfoBI9Cm38IIttpFxjX
         hPaStAb4IDbBLM3jhA3XNvF+4eiPs1AJyajJB9dhhaoGgYRGa/c2QRcpYDnKSjr1kbIa
         JjYkirO37ozGMpq4SFByP878mGrHGdGNlqNIC2XtgXZbrMY8VD67xIgcUBzDe1F/4hH9
         d8pbsKz8G0WKwUeoyzsk8dPuPUA6PmUbIxiho1aMCgWORzsqC6jvzzqg0edNSQSSvkQU
         CjLw==
X-Forwarded-Encrypted: i=1; AJvYcCWQEOwnOKeldn6cayNVziw9HriBWRxwHf0Gtk/qjV8gkxxLwetSf1UpGmoTGS6I8e46dy0uC+p9nlLbI3WF@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Qs/DA41v7zQL8RaoiZZy8dSj8anEhpX4CZCwDMTOFTICf8WP
	//t0XpHTw5cAjLlbXtVyw4Q056qVQ38cZ/67IisczFCCtXrmInbVhBuW4gnicm4nfMU=
X-Gm-Gg: ASbGncvpr0oTvrH0whDtEg00V1Aa1VmA/4jWIbl1FmF4KAirpifWG57bhQflenmVg8z
	RFP3CjnYtdWRmsW1MLIM23VScuZUd99n0od5k1BqJCgSjKbGYmTHS5DbS8FxA2lCWvm4ISvPVjh
	y0bPLdDUl/53tRWGaxJggaMe1azjEFdW8WSlP3HIMyMAZzN50zIehfjgHkQ6JZmcJ44Lqdjgbkc
	rN5REIBzLurXmNwjPhbq3YeDYjycjTz/Pcdww833p5uzndkJUxmEV2BuSdGAf6Dlk/a6F0rc2nH
	/bRAILcIldM8JixU92OHKpfoGYHYyHIjl0HumL9cuTiuxpo6i1MU1E5LPIre8COBarJ6RDsQkeg
	9Jcg5z527O6ZIyPTx29PovVU8rZTe8D807fyj1dTYurQPiqsZ81UlamOmdx2d4IYFExiXh0oZ4U
	dulbtlyTOBAPWO9VS3nqxM3A==
X-Google-Smtp-Source: AGHT+IFO4D7bAoVhJtV1jctvP5v6tn3ybzaRVaB/XhRQIb32ZxZbdyWzguubllrCoRGqVBHHdeayTw==
X-Received: by 2002:a05:6402:52cb:b0:609:9115:60f1 with SMTP id 4fb4d7f45d1cf-61d2699f676mr6340759a12.16.1756729842457;
        Mon, 01 Sep 2025 05:30:42 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61eaf5883b6sm255566a12.20.2025.09.01.05.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:30:42 -0700 (PDT)
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
Subject: [PATCH v5 05/12] mm: constify process_shares_mm() for improved const-correctness
Date: Mon,  1 Sep 2025 14:30:21 +0200
Message-ID: <20250901123028.3383461-6-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901123028.3383461-1-max.kellermann@ionos.com>
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
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
---
 include/linux/mm.h | 2 +-
 mm/oom_kill.c      | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

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
index 17650f0b516e..6a888a5de2a4 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -490,12 +490,13 @@ static bool oom_killer_disabled __read_mostly;
  * task's threads: if one of those is using this mm then this task was also
  * using it.
  */
-bool process_shares_mm(struct task_struct *p, struct mm_struct *mm)
+bool process_shares_mm(const struct task_struct *const p,
+		       const struct mm_struct *const mm)
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


