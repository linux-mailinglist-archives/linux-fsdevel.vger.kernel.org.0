Return-Path: <linux-fsdevel+bounces-33099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2B79B41DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 06:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 273211C2184D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 05:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFD0201005;
	Tue, 29 Oct 2024 05:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="doIuz1vZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE37F9D6;
	Tue, 29 Oct 2024 05:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730180906; cv=none; b=ISiv6wxNg5jcXw4OcZ6c70le1jhFgrhMrVGUJ54R+aDkGtrC7obNrDqF4Pr3y645xTJQUS+vgWAim9awkJfze4lws98LUpbJW9UdOzJUaBHi3BpbZ/fKm5KQuqoeSkm2b+8n4klT/l/F4bKsl/tsROYNirq6jdsSPb9M5LcNzFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730180906; c=relaxed/simple;
	bh=U/2upvTYP6HiOsz6xzi/fzYA8tHZeZDspIBT8uDlfJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sWqHlh/dp4Y2F84hzC6AgPUUysbPXxcKszlI3ervf8Jril32PWWUcT0zKk/31yzFAUvoIRtOBUfx9hkhS+0kX/3f+ZyuqiO+x5r5xU9dILak/Ew53mPyJD8K6lmPL6s96njtt5WQpEroFS7vTys9LAx8Joux8zW1PxmZIzVHgrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=doIuz1vZ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5cb6ca2a776so6745942a12.0;
        Mon, 28 Oct 2024 22:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730180902; x=1730785702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=57xthECTmh4BEVXc1Pcmo8D6nxDE2AQUy3jBnLDXMsQ=;
        b=doIuz1vZvRfnleuf4QmcnEp+twy6kaK4rn9FB0XNqPZYeaVbmTmzBIpWIDrxcE9gYa
         tVLPp7HNfVZtaSZYthGJPW3/Cfm+dGA3BO27Kr1Dz4hzCu5z0XaTzZQrdOzdjS7J5ni7
         xcsB/YFvZuJqUGB3tnfob+bWOicUPaim2Mzve1a30BZvE5igyhWgDptfzcXLNzgUcdD0
         60Mk+QwVzWCtlxCAfXt70RcgPY3luBdxzv+CoJ2i/aZ0frwRvqRWKp4JmysoWndUQ00F
         8T8kC7THw2k3MKsGG5ZoG5cd/fx1PlbqyVmPSqO3zWDgtLDMJNOvgs0but8GctYcYzE2
         vmfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730180902; x=1730785702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=57xthECTmh4BEVXc1Pcmo8D6nxDE2AQUy3jBnLDXMsQ=;
        b=r77G4IsT1yURpgJr5k+GrSH+EcniiyKaSn98XRNPYWM2hm9KRO4Jfzn6KLC+52yGQJ
         I84RdAKw7DruudWQJkRhgYkAPRiihpn54NvfGv4+i/YUH8AT8gpWT/lIayYHHpv/ddHO
         lvVukdxIwVZHqloewdUUYzDJT9Ax0ltB1cMH8F+qUZ5w03x/SPgG7K8tLlzzKuSaw/7M
         Xm64yjH6bogsePs9R8GtKR4MQ3VhVv974pLrHHzFmo1O8RHndkbwZZ2/JusadThJ0dwT
         HvW+9qmnaJLimT148vHilNoj7SciFSCXqyyAw+iparqakBmKr+udG07TXGa0bSFCCDhQ
         2j6w==
X-Forwarded-Encrypted: i=1; AJvYcCV7t0SXG7IpCQ1kHPtTa268ZVhkPExlXrz+ucyGYGaKm45qIfMTfqrQLeauUa456V7535mCrsGZmKNOxm4Z@vger.kernel.org, AJvYcCVKr8h2hNmKIvNnlTCLKs8GundbyTpqW1v+31FmeIqIuG7U3pa6R6+qbfsJ5Y1cI0p+ud9QBp2qpW2utl0b@vger.kernel.org
X-Gm-Message-State: AOJu0YybnjMoY/ORunqarnklPWTuSBoySaTNqmRVC6X8qXDGKSdV8KvB
	oUGsO8N7FzCc90T4knvAVB0YRR4Ij1KOsKek8C3jR2/xvsK/hPWYDHX0hA==
X-Google-Smtp-Source: AGHT+IFvdgjVcJYmAdfYJvwMjn3xzv0yIBo0H9H/vj2Jc2yx84aGfMNulUd0kGnbkj7iucEeLn/Kqw==
X-Received: by 2002:a17:907:9408:b0:a9a:6855:1820 with SMTP id a640c23a62f3a-a9de5ce1590mr1071926266b.15.1730180901920;
        Mon, 28 Oct 2024 22:48:21 -0700 (PDT)
Received: from localhost (dh207-41-108.xnet.hr. [88.207.41.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b3a08478bsm438239366b.199.2024.10.28.22.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 22:48:21 -0700 (PDT)
From: Mirsad Todorovac <mtodorovac69@gmail.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Mirsad Todorovac <mtodorovac69@gmail.com>,
	Jakob Koschel <jakobkoschel@gmail.com>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	"Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
	Cristiano Giuffrida <c.giuffrida@vu.nl>,
	"Bos, H.J." <h.j.bos@vu.nl>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yang Li <yang.lee@linux.alibaba.com>,
	Baoquan He <bhe@redhat.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Yan Zhen <yanzhen@vivo.com>
Subject: [PATCH v1 1/1] fs/proc/kcore.c: fix coccinelle reported ERROR instances
Date: Tue, 29 Oct 2024 06:46:52 +0100
Message-ID: <20241029054651.86356-2-mtodorovac69@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Coccinelle complains about the nested reuse of the pointer `iter' with different
pointer type:

./fs/proc/kcore.c:515:26-30: ERROR: invalid reference to the index variable of the iterator on line 499
./fs/proc/kcore.c:534:23-27: ERROR: invalid reference to the index variable of the iterator on line 499
./fs/proc/kcore.c:550:40-44: ERROR: invalid reference to the index variable of the iterator on line 499
./fs/proc/kcore.c:568:27-31: ERROR: invalid reference to the index variable of the iterator on line 499
./fs/proc/kcore.c:581:28-32: ERROR: invalid reference to the index variable of the iterator on line 499
./fs/proc/kcore.c:599:27-31: ERROR: invalid reference to the index variable of the iterator on line 499
./fs/proc/kcore.c:607:38-42: ERROR: invalid reference to the index variable of the iterator on line 499
./fs/proc/kcore.c:614:26-30: ERROR: invalid reference to the index variable of the iterator on line 499

Replacing `struct kcore_list *iter' with `struct kcore_list *tmp' doesn't change the
scope and the functionality is the same and coccinelle seems happy.

NOTE: There was an issue with using `struct kcore_list *pos' as the nested iterator.
      The build did not work!

Fixes: 04d168c6d42d1 ("fs/proc/kcore.c: remove check of list iterator against head past the loop body")
Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Link: https://lkml.kernel.org/r/20220331223700.902556-1-jakobkoschel@gmail.com
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>
Cc: Cristiano Giuffrida <c.giuffrida@vu.nl>
Cc: "Bos, H.J." <h.j.bos@vu.nl>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Yang Li <yang.lee@linux.alibaba.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Yan Zhen <yanzhen@vivo.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mirsad Todorovac <mtodorovac69@gmail.com>
---
 v1: initial version

 fs/proc/kcore.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 51446c59388f..25586ec4096a 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -493,13 +493,13 @@ static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
 		 * the previous entry, search for a matching entry.
 		 */
 		if (!m || start < m->addr || start >= m->addr + m->size) {
-			struct kcore_list *iter;
+			struct kcore_list *tmp;
 
 			m = NULL;
-			list_for_each_entry(iter, &kclist_head, list) {
-				if (start >= iter->addr &&
-				    start < iter->addr + iter->size) {
-					m = iter;
+			list_for_each_entry(tmp, &kclist_head, list) {
+				if (start >= tmp->addr &&
+				    start < tmp->addr + tmp->size) {
+					m = tmp;
 					break;
 				}
 			}
-- 
2.43.0


