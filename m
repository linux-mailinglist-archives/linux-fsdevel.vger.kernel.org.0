Return-Path: <linux-fsdevel+bounces-59820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8791B3E318
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 14:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6738118939A9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 12:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C95E3451C8;
	Mon,  1 Sep 2025 12:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="XP7+ZoAj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31EE341AD0
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 12:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729845; cv=none; b=D5Gut9LSSP2RSsGuQipUBsOs9Dn1xpnjvZfTSpgjAvJuk/WRhraGz+JFYlIxQgjigvIE/OX4B/m8V34+kl4w0l1SfWeTDO62h8GT04Aab5V8HQajLDQu8Cs/ZiL3PNfIlwR84rqZDnE0AjNh22kCAafh4Ckw6Q9WcGbYsWFaEOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729845; c=relaxed/simple;
	bh=JLsm20nRUfCdVD6uJy+GUl3NfrLb9BR0ocnDc7c6Sws=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HJeP3NwpqHFvLjhl5DfJc/y2bMdtCWKP3DT/wrOPJQ7n21S1YGkH6ax2zGamEIH2zyz6E5DLBsqiY2mT3Z+QP5UgxgoZVbQ5xyg1U4HufQV23Wna5nYYWTHDJYHjy+Y25pwTRtf7ejAnpI9ZWariXmJU1hPDvj3CM1r+dqROO/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=XP7+ZoAj; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-61d143aa4acso3415514a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Sep 2025 05:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756729841; x=1757334641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zbWUBNes5mrbySu+U4Jj7Tp5fvMH1UIkvlFNU4FTVkY=;
        b=XP7+ZoAj2t+s/GqoFImqvaRcFKXis5a6i5gTR8BK58n5jcvvJvZHMf6vUAHpplIU51
         +SbrYotB8qxVo1h8sLJ84e8ImOgY98uja9OZndbkvHgLgHteEOLQ8edqMl6Eb4uivxya
         /9x2ggMJocoeC/7pAFQi6yrww/lmHDMRDlytUnW84ZYu9FuRZff8dkS5bL1Mc5k7iJ7+
         eChSaNk0sssJNnCct0MtOPjNu3J554hm5e77ImZd9KhHTI6Zn+8DWLjh/cTWTLUamb2K
         B3JEl57OmmcqJ/CZNam1VstrIWRULwuzdFIApVWAKSIKeChVcrm3dkw9iffdQEDGUfmx
         5ADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756729841; x=1757334641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbWUBNes5mrbySu+U4Jj7Tp5fvMH1UIkvlFNU4FTVkY=;
        b=CQm80QhW+jU4T8Cv8fjoflPCdgkwscPCtwi3yllgF6LsqBbhwwiH/MmRJ+ku2Sr66x
         q/qKE8ytiC9/cjbSHC1xsFZD/VbFhZPBx6qdtWfblTYHlPq0FILZFJZnxtK0krZ85MVQ
         OVqNyI20rLLxSkdiX2l1d3FQoXmWof76R6SjUKswekGhwPjHEA/7kjR7RNBkCAbap2HC
         Nq3fhCgztWTMeEPr/kG+KWyeP/Z+cJi8X91rLwSZ1TNgZI9ruMLcjsSzL+i/YPKdKn8o
         eT3rpKcDQYY+pB7SN+xyIutnwKmWH9FDxhgVkWNd1TLhz4WtAzGVANdboze/l0I4QDsh
         8BUw==
X-Forwarded-Encrypted: i=1; AJvYcCU+Og/w0E3MsklkuuRrpGosTDUsZtMpWsgr/y+v53TDEed1+9sT3SYTr6BtqLaDF9xM1zdTe1ombhT3/mzP@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh/dp7bwY/cT3kYugxR9Gx2DJenCcLFCNNpFQpsTFJrxKjLia0
	asr7jTECoQ9DwFCKjWfEElZ8HOXwq8nzbr9CFQbLOnoHbuXSIV9a2raOE7lONUUDhnI=
X-Gm-Gg: ASbGncsmtNErhPGPh7QIZVLTqMwX+c0SPYzKq1GtkEmwOVYfA9ZVkUUYI95SKUbZgnx
	aYaIaesa0AXDMj1NZI6CwT6fEKNP8CGEAK9QBoIilrTsjU58Dn2KKWm7WStdsnE49JUTqnOBeub
	HTwG+gso+iisNqb1HGpke+V0lJzl3sPCb7MRV9+chdS20cbwJ6cJuDzj1Ht7uwv84UMdpXWgJPh
	ep03VXeg8g53uBX656uLiCX6Sj6COaUIUcbJ0Z/uCB4R+N7dMqvd5hr9qJ5SP1Yek13ObTfLkWi
	h2YcdmFQUU5xH1HzfX3gNr6hYpc1V99jUNX9mLTiOFPO44FAX/1LKWUCACmwElSUh4St2Y/aISb
	4K0iIMi91gGC5xi1ddxNvminb6h7fmPM275BtYr3ga0V1YgF7ImkCAW/cXPyBmqYjTr+/TIRKVA
	a+5mxqSbaKhydDZBMVPK+q3WZboy8ZVSW0
X-Google-Smtp-Source: AGHT+IGRe72s+UHTnGokGr7x1pyG7G81cHBjYzB5waC3bIIZTDAVVMuEn5lgB7KxjuKhIwvrTnRPsQ==
X-Received: by 2002:a05:6402:2554:b0:61e:ae59:5f04 with SMTP id 4fb4d7f45d1cf-61eae597256mr563365a12.27.1756729840654;
        Mon, 01 Sep 2025 05:30:40 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61eaf5883b6sm255566a12.20.2025.09.01.05.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:30:40 -0700 (PDT)
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
Subject: [PATCH v5 04/12] fs: constify mapping related test functions for improved const-correctness
Date: Mon,  1 Sep 2025 14:30:20 +0200
Message-ID: <20250901123028.3383461-5-max.kellermann@ionos.com>
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

We select certain test functions which either invoke each other,
functions that are already const-ified, or no further functions.

It is therefore relatively trivial to const-ify them, which
provides a basis for further const-ification further up the call
stack.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/fs.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3b9f54446db0..8dc46337467d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -537,7 +537,8 @@ struct address_space {
 /*
  * Returns true if any of the pages in the mapping are marked with the tag.
  */
-static inline bool mapping_tagged(struct address_space *mapping, xa_mark_t tag)
+static inline bool mapping_tagged(const struct address_space *const mapping,
+				  const xa_mark_t tag)
 {
 	return xa_marked(&mapping->i_pages, tag);
 }
@@ -585,7 +586,7 @@ static inline void i_mmap_assert_write_locked(struct address_space *mapping)
 /*
  * Might pages of this file be mapped into userspace?
  */
-static inline int mapping_mapped(struct address_space *mapping)
+static inline int mapping_mapped(const struct address_space *const mapping)
 {
 	return	!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root);
 }
@@ -599,7 +600,7 @@ static inline int mapping_mapped(struct address_space *mapping)
  * If i_mmap_writable is negative, no new writable mappings are allowed. You
  * can only deny writable mappings, if none exists right now.
  */
-static inline int mapping_writably_mapped(struct address_space *mapping)
+static inline int mapping_writably_mapped(const struct address_space *const mapping)
 {
 	return atomic_read(&mapping->i_mmap_writable) > 0;
 }
-- 
2.47.2


