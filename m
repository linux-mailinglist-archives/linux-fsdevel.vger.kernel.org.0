Return-Path: <linux-fsdevel+bounces-36341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2069E1E2C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 14:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D012B2852C2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 13:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4EE1F12F5;
	Tue,  3 Dec 2024 13:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZWc3wLs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503CC2AD02;
	Tue,  3 Dec 2024 13:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233801; cv=none; b=EPBymPPOPTZUo02LOEZHCqKMN/JCYUjiYE6RsP7RLleN5E0Eik7Ksqd2kwZD0ChjN0z2zlp3JWlmxsYeXrvtfYyllyQtaBzC8uH7nLo9RWUbf2ev7lwzNflBZKqe4eX9LSToEXQOGoTUsY4Cf8bzVb+B+KIp06oa7z8KYTbrK68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233801; c=relaxed/simple;
	bh=Cxe/k9iCkaQjBBgRvDmHIpPIPMbe7bhm0ofM7w3fC4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bRJ6/p2Og8oPCDaQNdEwQFKPLpOCu8oNoR4+grCX7F0BV6smgB+MTj+zF9SN685vJcf4syOC09D3KezKkiT5pSV0/Umexkq9HrhidFIh+sLuwUU7KaxhSKrYkAVUPTexyfv4bvVuo9yy9iW8B3rLzgT5qCI2/++AGFCPW2nOdrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZWc3wLs; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-215cc7b0c56so3172775ad.3;
        Tue, 03 Dec 2024 05:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733233799; x=1733838599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wrWeEjYD6C32kDH9Wy7fR9BLzK2OqNy/5AsIIlJG/qg=;
        b=dZWc3wLslhqhIiSY9KvR3vDVBzOn2pYBBo0rnivSnapKK+kIHGh4ycT2kgzJORObja
         Y3m0YLEiCDn6sZJVCTIKsiShRxOD1qN95DMZEzDnfvU+J4vFeWZRKf7rJ2b9npVkuQYp
         sHgsblV7RuO/f/G5IXgZZxC2+zzka6XHGJNH5gSB7GkZpvS1ZcjaUl3cfV6xCOao/Ujn
         DksW3igGAwRW3lzbjNdSSmNYjm8sz6G9VMxG9H+saMnvhm1Tlm2tarCgMWXzIVsZUNKy
         f1ZZJ0OCm3h0aNGdI4y/coYZLnUP/2vbcQySLdeyBkwQNUDrQQTzpz5B/AjvPgU++Mg3
         BBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733233799; x=1733838599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wrWeEjYD6C32kDH9Wy7fR9BLzK2OqNy/5AsIIlJG/qg=;
        b=aycaHDULyXJ+uiEIHcMI90lQIOCJrT5KbtT7Jmvqq/tMTyAFwhuTS9qLnH0GfiqgMQ
         EgayiUeaMvlaon04n5sORLc1ans3tdmXph30pDEvFVgU0Z9UGu7VWL5SkPReAhkCH0/5
         Gy6YTn9UfdO0EXLol8fsC7Zsq4pyeniY3lxOj1KkZCdL4FNJiS/1McS/SDRwJMUWREaq
         c9+29E6BXhmBwjsSyq0zthEaiyhcHwG/UB9xyO7faK9JRV3XnknOBHLgmkuzKj7I082i
         gEFzCZIwx8cPztvJ25fYSIwTMuQCBqQFMlc5o3m9mqB4wUJglXJf14u3QKbKITjURiU/
         kBAw==
X-Forwarded-Encrypted: i=1; AJvYcCUIDvC24HP93i4Lap/qxK1HZ1Mv1/L+4eQOf/Kn/uxQ7s6CvrX6xC9GThuK0qyDTWXRhNLspiFI18fgt1T4@vger.kernel.org, AJvYcCVv03rb05JMGW2pTxXAkTOauPw5j00JCHSbjhF1K+Oawk88dbqAFTFMeC2fGgKCCVAYPakIGr7Ra85+hM2c@vger.kernel.org
X-Gm-Message-State: AOJu0YxP7PT8ZtvxbNFCDOYvaEGjuM4V3aPfCPk6HfqegK354rb6aleN
	QNTiExEEZJITMWN5JJa331AecwCFGtjnqDuJFBiRP55CDi2MGjuG
X-Gm-Gg: ASbGncuzL8nPABsSY2VoFLsR2koORO/gLTdNIYeseU3j67XfyrA4xnvnIW8JL5LlMnd
	h2PAk+qNMdDG3vgsbWj/UPy/6yxIINFufpw4C6bDVuKfr7IU8OJ262Vr3IMYVRL2EQ4td1ScPgw
	7EW05eECZV+Lvy+fJvx9RoIUA1x8268YBk7k2+pwnqTheiNBdciQfua2xflgwSNJMf8IqmGRG7w
	GC5CVku5MXGzxhXrnhQWO9+Nm5b0H61Sr5UHX0DtnTWKxarx6X7Al4CTYMS8m2MwKI=
X-Google-Smtp-Source: AGHT+IGIJBbhiflV+C90jpzpvrzchfkyMrxi/56fWyyZnzCIcxngq76SpJzowglJgC/KJ6dWDnW05g==
X-Received: by 2002:a17:902:d2c9:b0:215:681d:7a52 with SMTP id d9443c01a7336-215bd17a76cmr25562285ad.55.1733233799585;
        Tue, 03 Dec 2024 05:49:59 -0800 (PST)
Received: from localhost.localdomain ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215b46e99edsm16990065ad.80.2024.12.03.05.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 05:49:59 -0800 (PST)
From: Wenchao Hao <haowenchao22@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Oscar Salvador <osalvador@suse.de>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Peter Xu <peterx@redhat.com>,
	Barry Song <21cnbao@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Wenchao Hao <haowenchao22@gmail.com>
Subject: [PATCH] smaps: count large pages smaller than PMD size to anonymous_thp
Date: Tue,  3 Dec 2024 21:49:49 +0800
Message-ID: <20241203134949.2588947-1-haowenchao22@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, /proc/xxx/smaps reports the size of anonymous huge pages for
each VMA, but it does not include large pages smaller than PMD size.

This patch adds the statistics of anonymous huge pages allocated by
mTHP which is smaller than PMD size to AnonHugePages field in smaps.

Signed-off-by: Wenchao Hao <haowenchao22@gmail.com>
---
 fs/proc/task_mmu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 38a5a3e9cba2..b655011627d8 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -717,6 +717,12 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
 		if (!folio_test_swapbacked(folio) && !dirty &&
 		    !folio_test_dirty(folio))
 			mss->lazyfree += size;
+
+		/*
+		 * Count large pages smaller than PMD size to anonymous_thp
+		 */
+		if (!compound && PageHead(page) && folio_order(folio))
+			mss->anonymous_thp += folio_size(folio);
 	}
 
 	if (folio_test_ksm(folio))
-- 
2.45.0


