Return-Path: <linux-fsdevel+bounces-60379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9510CB4641F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 22:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EAA5560F30
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 20:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C9D2BDC37;
	Fri,  5 Sep 2025 20:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="Lwhn3tmE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC1829AAFD
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Sep 2025 20:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102516; cv=none; b=QJCdVxeyVahfhvh4wXQkrmflHcCU08daiwILbv3FYg8yuZwKjuYZ4V+qUtPH2k+fAiFpYSdRdml0uQ+uo42odiarWJ3gLlS5aIqpZFJDnEhCpnWb9BomEQYTSwzXOMYjoT2TzuZjXoo/uZG1RRfLO+//izupc3XprYxesz5VKDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102516; c=relaxed/simple;
	bh=TD4uknfHvyPGUWgQU96h069eDMk/ujCkG8PZe8GS5dY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=serSbF0ObeSMCgGv1trFRHk5gFVOdD3wy/T87NEpR6OB5Rb3+S6r73UILcwqJYhk2BUC3pAzAkvE/FAOOnNEstxfdQvaVQ1L9BTesxuB9Kj4vAreOGFX11KclUFxfz7YhRDoFGuM1w1lPAlcJ6ZBfjLwaEZ5eruvjQM1580tI40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=Lwhn3tmE; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d60528734so22810407b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Sep 2025 13:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1757102513; x=1757707313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSqTzH3Ilr3whep/qZ6sUBtuPUtJ/C3y9flz5RvNoos=;
        b=Lwhn3tmETD5YIO+8I42jJXqA++lpkeGu6GHVXPsPUuDWwmNHlhdEE1yf3EIfujcIUl
         r2uLUeNCDYUqZPTCaRc7TII7+IEIuemVeK7Co7WZt28F1ZQnbe8dLFrv0Cd4TnONjcHM
         3idZOjgiXgbMQNGNYZg/V9pMOwNlQ9WgZ1kJizouADBZBPUsLGUifHx4uIe5LsvPljUR
         3mp3ry3t9yWH7pXB+gIHKBiA4udUfKdMQ4saB/qxt1hQUsQkAoyCY4okNyD5Wl3TJhkq
         W5bcFOrr6pW8CX5XLHoHxcXLg2HY/TG/MFMkUhzRIDv1iWyxxH2Qyq47to/TMueV0cGK
         wCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757102513; x=1757707313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZSqTzH3Ilr3whep/qZ6sUBtuPUtJ/C3y9flz5RvNoos=;
        b=wDgrtX1Y1mhe2hlaLQo58UxLjzleA5Tp7v2JvgejYsE1k/BHXc5SbpsYexJ9KYzvdi
         geeXitJx63xmMRujGz0ytW143Agwaarh3ozPqvufZRZWcdT+bdr9rz6pr/+UYSsniZit
         lvktp776Plnf0XPY+oCGGoVZRosHh8Bl2opFCqZ4J0OBotu4M0EFUQi5pkFVXucVFPal
         bpJFZSf2rUTDH5MYm3GxuAMtgfbpKzwUEDPvE8KJkjcXV8g/W2BvIOrs2PAMljyCR0Ix
         L7Oox3A6uycc3w7g38b0r5Gj5cMsTNATUNcQhEBRChwitQrbg9UVgIBNAtIBzN6CngmD
         0bBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFKiZhKMkCuf7ecByyipesuamFa8i4K7aHFzDV8RRNjdkTbpDyN1MRwMWYw+zVfnmVoHFydbORo+Xn7hPQ@vger.kernel.org
X-Gm-Message-State: AOJu0YygBNHB2HkpuBVN70BAwUYeWP3Ny/tIp9cy8HZLuz8W6+brfN1C
	NilwDvFqhpyL85JmZQel9SX99HPXqujZ8z8iIlyAtdVEff5jT2n1F+HpGFksREv9i2wXaeCfs69
	Le4NMf84=
X-Gm-Gg: ASbGncup2pZeHQrh7t7z50tmt/UOaroo0ebqaK2l5LGoKdgI7BZDjFQwMR+I7hOwZrf
	cGQ9X465/GZNAvJ95lgLHCkfx3tV0CQjxcurZ/lM8JHeEWDgYlk3Kysd/RSry3V+sfmqgO+GmUS
	0Nn6RzslOdZZ1KqFHeT8XsLfly0eeZjgKQhj7L7OzYmEPrunCGb7np9XgZz419tArRz6Q0aCuK+
	YRylGodkjpKSC0Q2c87tQpuhvG9tVzi1GZhAmsKr4FpA+uNfRKWkc+7uB86M00pVa7BaKN7aKI0
	Z+hIHPn4IAEjQw0JEnssp0Ir95auAVQDm1daTL5OWH3GXdvebmXbaI2ZUS+bX3zEbTBN981c8zu
	3AM9R8ARrlYZgDVJ5wMQt7cYwBb2jaCbbxRs2N0qkzy7IsdUoS44=
X-Google-Smtp-Source: AGHT+IFasCo/NGSnZMQPhBzzposVJlw626v/3OHTnJGkyA8sFBQZu70NSBtyDPT8k4ZRmMSHloRwRA==
X-Received: by 2002:a05:690c:9689:b0:724:bbca:c028 with SMTP id 00721157ae682-727f5f43be7mr1273707b3.53.1757102513083;
        Fri, 05 Sep 2025 13:01:53 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:2479:21e9:a32d:d3ee])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a834c9adsm32360857b3.28.2025.09.05.13.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 13:01:52 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com,
	vdubeyko@redhat.com
Subject: [RFC PATCH 05/20] ceph: rework comments in ceph_frag.h
Date: Fri,  5 Sep 2025 13:00:53 -0700
Message-ID: <20250905200108.151563-6-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250905200108.151563-1-slava@dubeyko.com>
References: <20250905200108.151563-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

We have a lot of declarations and not enough good
comments on it.

Claude AI generated comments for CephFS metadata structure
declarations in include/linux/ceph/*.h. These comments
have been reviewed, checked, and corrected.

This patch reworks comments for ceph_frag_make() and
ceph_frag_compare() in include/linux/ceph/ceph_frag.h.

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 include/linux/ceph/ceph_frag.h | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/include/linux/ceph/ceph_frag.h b/include/linux/ceph/ceph_frag.h
index 97bab0adc58a..c88c0e68727d 100644
--- a/include/linux/ceph/ceph_frag.h
+++ b/include/linux/ceph/ceph_frag.h
@@ -3,20 +3,26 @@
 #define FS_CEPH_FRAG_H
 
 /*
+ * Directory fragment metadata encoding: CephFS uses "frags" to partition
+ * directory namespace for distributed metadata management. Each fragment
+ * represents a contiguous range of the directory's hash space, allowing
+ * directories to be split across multiple metadata servers (MDSs).
+ *
  * "Frags" are a way to describe a subset of a 32-bit number space,
- * using a mask and a value to match against that mask.  Any given frag
+ * using a mask and a value to match against that mask. Any given frag
  * (subset of the number space) can be partitioned into 2^n sub-frags.
  *
  * Frags are encoded into a 32-bit word:
- *   8 upper bits = "bits"
- *  24 lower bits = "value"
+ *   8 upper bits = "bits" (depth of partitioning)
+ *  24 lower bits = "value" (fragment identifier within the partition)
  * (We could go to 5+27 bits, but who cares.)
  *
- * We use the _most_ significant bits of the 24 bit value.  This makes
- * values logically sort.
+ * We use the _most_ significant bits of the 24 bit value. This makes
+ * values logically sort, enabling efficient traversal of the directory
+ * namespace in hash order.
  *
  * Unfortunately, because the "bits" field is still in the high bits, we
- * can't sort encoded frags numerically.  However, it does allow you
+ * can't sort encoded frags numerically. However, it does allow you
  * to feed encoded frags as values into frag_contains_value.
  */
 static inline __u32 ceph_frag_make(__u32 b, __u32 v)
@@ -67,8 +73,10 @@ static inline __u32 ceph_frag_next(__u32 f)
 }
 
 /*
- * comparator to sort frags logically, as when traversing the
- * number space in ascending order...
+ * Fragment comparison function: Comparator to sort frags logically for
+ * ordered traversal of the directory namespace. Since encoded frags cannot
+ * be sorted numerically due to the bit field layout, this function provides
+ * the correct logical ordering for directory fragment processing.
  */
 int ceph_frag_compare(__u32 a, __u32 b);
 
-- 
2.51.0


