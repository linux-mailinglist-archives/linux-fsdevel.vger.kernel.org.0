Return-Path: <linux-fsdevel+bounces-59753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED317B3DDF4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 11:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B29334E2021
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 09:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD99730E0F9;
	Mon,  1 Sep 2025 09:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Dl7V1wER"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339C230DD10
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 09:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718376; cv=none; b=r7cvHZiB+5DQ9lH9afonImx0algr4WD7xkqhWYRdvhvWECehF3IqIi+j+EKJHNfJDazmAq4NSjwL2ZItrsYgLy21wLvGIXoEYOYWu9eoOdxjxz+okAMQaphyBqa1zwtn+fKlMwt0niZz4QIw3920Ch5mrhKrylOuTMHMK1XnNw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718376; c=relaxed/simple;
	bh=fqMfYftVrFkOy3wbJRO7r0XLlbG/lU+7XLovauzZWxo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qwb2fxtwH8bX4uzlYivV0kTEWrdu2jSRq5OIcz0WFPMqhkCR9ULvUm0X1ZBkgNdVYOslzglILkqgyurO56CkrrrV/utdPLm9DoelYwdAbTCqH2AnVtvmz097ssGPKOloq00K4Pg99zkRTzH/jhi24I+srMXm79zUiTao5fAAKcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Dl7V1wER; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afeec747e60so610815766b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Sep 2025 02:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756718371; x=1757323171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8H3eprdm8oiBq+0anIaTODIO0eIcUyIWc/5jJ7tDkes=;
        b=Dl7V1wERFzMleKB/mcdbkOLSfivKh/0qTbbLHtW40hL12fF/PHC6FBC8qSvS+8F/AH
         5823j13P3EjHQyBXddCElPlgiJAomY75h48tIKrF7Aiqehm9JKkfycrMNH8tpoI8wWhE
         1kV99t9hXTKOXn52zT9HzwBCAp5xD3jTg0cA4HwqoPkGOq+MUNBgc4RNYD67veOaFXv5
         yMZaKCwx/18ovZe7OG6CWpIBvjMi9DTLZhuoxCYTOkVPoG3Z2oVQNvrAnl7JC2RXUv/e
         CqNkBD/dICQCC+BKKzxrAq0FOGHnwGkJC+NZt0j7I/UEBoL31gvVNsHRUc9JZHTuF0S0
         ksig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756718371; x=1757323171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8H3eprdm8oiBq+0anIaTODIO0eIcUyIWc/5jJ7tDkes=;
        b=Cm0l/RbK5wxyhXM7uX9yoDWSRKiL8ywDQLUGAZhbXS/w9NhcOVi3UhqXMB1HxbD8BT
         25fSW3lpnmXlw7qiK34nN9tLu5gjr4n3k/ZN7SBwIz0fZXLAyuTx0ggLNkjyj/mxjsPp
         NCdjz2UvQFaSL6i2LNLRAnwLCwlbVGXsPMykqknCkxUWTE6G2If0L4pLTElNZ2xDKfnu
         w2I/XKM9DtvCxYAP+etIZijH8QurP40Ta0y+wLFzEQo44kxkDy1c8e/jUQT9RcHQbXPj
         4YOdqR8XPq2gPD6o5l9kyMCefFgnv0snnx80ajeZdMTvnRyhPT7iVKLgOs2uhXdLzknL
         jUXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXC2GOqYJM5abpYWgoNaqi8dO+P8UHAo5Umc5amVCDt0wf4O0pZTc31xxsTeOH+ZrSbBgmRkbdfU4AYP8xp@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6uvo8Uy/Le2lOLpR30sUl3dy9Vvg6lOccah6h+p5LQ+2aP1cw
	edtLM0MrbySKjNrc7EBPYp7oxFXuQQ0PPALGPCpkhuiFb+2yC51pCZhXGDBWTqySO98=
X-Gm-Gg: ASbGncuygNS7y5Q13JCe5CxrVYP/yEbyClqiDaS9p5QIXpZ0I5KSoo7mzpM6eegqN/B
	bc3Dkx7ip9uvxRHVYB9XXHMx0CTAoFpzL6uovG5JCaW6EHqQpKSSmee4izSqKZgYkyIUGcbHG4b
	Q9FU8bwtZEhKwVAukehYJoiCG6yqzS1ZmkhjqEQUZBTT9UCF07/xJZDfqtmv5EX1XUUjygf054Y
	X538O8n22EF5JIRi4q0LwesbjQII9dFXlcqrN644OeRqbBK9HDGwpCD9ZD/CusXzaiiF77srxJO
	JYdW8jxW5r9efDucbV2joijFfgdkIeuJz0mIskoXxAAaUWlYrrVaEt8tGreZ3M36MwjcWY3W4vm
	syXcwHPxqDrIla+bWfJABC8A6LMKbUYZPRbmxGgKAE9K/7dSZTmaE3SOpYYcA2wXYtwDWl65a+7
	UgC9jLDo07wsRZdFYO7Sml8276wh4UWLL3
X-Google-Smtp-Source: AGHT+IF3CGqBNxa77EXUE/Gi7n0PBGLpiMmjL4vqume2Hy8S1ALFuVUh9cDg4qepPIlJtHhtd6svhA==
X-Received: by 2002:a17:907:7ea7:b0:b00:5399:f5c0 with SMTP id a640c23a62f3a-b01f20bfff5mr728590366b.62.1756718371341;
        Mon, 01 Sep 2025 02:19:31 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b01902d0e99sm541005766b.12.2025.09.01.02.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 02:19:31 -0700 (PDT)
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
Subject: [PATCH v4 04/12] fs: add const to pointer parameters for improved const-correctness
Date: Mon,  1 Sep 2025 11:19:07 +0200
Message-ID: <20250901091916.3002082-5-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901091916.3002082-1-max.kellermann@ionos.com>
References: <20250901091916.3002082-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory management (mm) subsystem is a fundamental low-level component
of the Linux kernel. Establishing const-correctness at this foundational
level enables higher-level subsystems, such as filesystems and drivers,
to also adopt const-correctness in their interfaces. This patch lays
the groundwork for broader const-correctness throughout the kernel
by starting with the core mm subsystem.

This patch adds const qualifiers to address_space pointer parameters
in filesystem-related functions that do not modify the referenced memory,
improving type safety and enabling compiler optimizations.

Functions improved:
- mapping_tagged()
- mapping_mapped()
- mapping_writably_mapped()

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


