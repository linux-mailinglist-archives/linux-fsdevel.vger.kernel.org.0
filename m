Return-Path: <linux-fsdevel+bounces-46419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC6DA88EFD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 00:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D39EE3B1518
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 22:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8971F417C;
	Mon, 14 Apr 2025 22:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnLAYvOs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED24F1F3FE3
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 22:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744669355; cv=none; b=MIdSyFriJe/XbR+6vG0f+Kr/iFmoSmGHaNjv9HvqLKfCBlN0Y6k1oHgA/WH1jQH2+qDsEwlFw3dYwt0fW1OxhcK3L04Th5JiQeThcDmz0bougE8FwOuyA6bc+9onjRTKUw9qjQ7pz/wYNkBuqNsK6k9nC4S9hom6Qtvrc8A5R7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744669355; c=relaxed/simple;
	bh=c3Ira/qZWt/+WI00jJNeL0xnK2kNz/dNjlVo3GsPrtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LiYFRWd788OA2oE/PI7yIzfj8MelpsAMWO0iux3riL+zUbhrOWD1qpepsTpwGWRZ0MZnEJI0yugrjmv/TAn4h6x4FzKZ06PPwrko09SQhKWePPhlyLLP4zm9uFU1x5/cumi6I5WNhU7nq9ZTjD043KlC3XI/wspYbHA8IfjEuYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnLAYvOs; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-227b828de00so43907945ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 15:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744669353; x=1745274153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+oWkQQZCAOmznqdU/77/ScxMiLxoOGJqTV4LeWuhZ1M=;
        b=DnLAYvOsZGo8XYU8Fn+pxcK7gCVQuz47u1i5S3qjgRMnW7qSatO9G5Qwt7MOrAXafS
         EV5nRrDXNxEcuB0Ez6rKDNtCnBiIWIedT+hky2f/PPVg5B5Dm5t9SR39LY6Q5S7aWRvY
         li/hpeXyD8vO42zqeWku+oMTZTfRR+Bh11fLohNwkD5456ykI4ocoY0eD+c+R0U5lwhI
         vJUe3SVFAsHSTON7KVcrAuOnltyYEKam6WNsRnDeQykOePlwGSzfysIngXgqpts8BEF0
         3bvdgOKMMme1UN+31KOmftNk1msMII3NFwQgUk3R7d9HyDghI6tDs6GpDW6o2Odg9iDl
         bj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744669353; x=1745274153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+oWkQQZCAOmznqdU/77/ScxMiLxoOGJqTV4LeWuhZ1M=;
        b=stP3+gnJJ+ipOlZj/gJ2f8gi4xrdeI94qeu5Kb7byB4KUdfYOt2Ius6anyE4fPpsno
         tk6we4vsrzpCxS/BkOqNiiH1DNliNntQxWVDzqgirUY7SOMYOZ1NVAtarSlVbnCugCDM
         K6aDtkznUun8r8WGZkzwgzYMMaJX6bFJVGeD2VKS0gkFT9X6+uVMnYV+3Dorq0xsDIkn
         vnvf6CjhCsM64/plQKVfmz53TByOkG11QGkFnRlnL26AVkIHqUJxFnhKvnYief5wMcz6
         W823pjlkOkM+e/KuI6T5o501kCYejwh+6WNMV2qApteNsf47e38BFxp3FCS+HujUARAg
         1H4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVqmctGo69LJWC2qCykaMyhpBT+izUAcTv8D11yLM05WJ2BpZHUwMD6V6H5zXBSt3Cgfctz9pZC5IpPKP7Z@vger.kernel.org
X-Gm-Message-State: AOJu0YxTD9KiYAH2JJ5ksnOoGdt/UJzdvIQ/Euv3W8lTKic82jDWCxkl
	WCfzB0SKtMLVbww5xWzbHzxZpONngu7+vM+GVUumoTOw71ZEwilb
X-Gm-Gg: ASbGncubpV95aqEvNrtZJkBU5WuYXK0gPSG17v1HhTvmmKHTonZtMhuJl/z8Jby5YH0
	usdP3Z7GeTdohiZgaUyaf8Voq+aCtAX2UegiUbkxrPk0xPWTYhhjN0Oo8DVPYpRVdoD68ZsZ3ED
	K7Vq8G3MwBn1dDt4X3YMRzBBFAI7asHYsTXFMe7Ya4/8UN4AcuI3kT3N8Y6o9L+gaVZbjkY8VFX
	dqA4eZLC7ZO6jFdsAXfcXqkG5yWTwxJZgwbQf5wMJP81qeWl0KH0HLaUj/tliV11jo3hG1ZXuyq
	/yY+f7fn3zLjC/bPqU0Cm3fZwXIj18uK15CU
X-Google-Smtp-Source: AGHT+IHEGRK/+NruAidysEEd0d6+/ry3wrbvhjNA81WN8QlEjydKcUEb/SGYslzu/JsgG0cqfHY9dA==
X-Received: by 2002:a17:902:fc4b:b0:223:5e56:a1ce with SMTP id d9443c01a7336-22bea4f26afmr196339345ad.32.1744669352990;
        Mon, 14 Apr 2025 15:22:32 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:72::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b8afe3sm104279825ad.75.2025.04.14.15.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 15:22:32 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Cc: jefflexu@linux.alibaba.com,
	shakeel.butt@linux.dev,
	david@redhat.com,
	bernd.schubert@fastmail.fm,
	ziy@nvidia.com,
	jlayton@kernel.org,
	kernel-team@meta.com,
	Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH v8 1/2] mm: skip folio reclaim in legacy memcg contexts for deadlockable mappings
Date: Mon, 14 Apr 2025 15:22:09 -0700
Message-ID: <20250414222210.3995795-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250414222210.3995795-1-joannelkoong@gmail.com>
References: <20250414222210.3995795-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently in shrink_folio_list(), reclaim for folios under writeback
falls into 3 different cases:
1) Reclaim is encountering an excessive number of folios under
   writeback and this folio has both the writeback and reclaim flags
   set
2) Dirty throttling is enabled (this happens if reclaim through cgroup
   is not enabled, if reclaim through cgroupv2 memcg is enabled, or
   if reclaim is on the root cgroup), or if the folio is not marked for
   immediate reclaim, or if the caller does not have __GFP_FS (or
   __GFP_IO if it's going to swap) set
3) Legacy cgroupv1 encounters a folio that already has the reclaim flag
   set and the caller did not have __GFP_FS (or __GFP_IO if swap) set

In cases 1) and 2), we activate the folio and skip reclaiming it while
in case 3), we wait for writeback to finish on the folio and then try
to reclaim the folio again. In case 3, we wait on writeback because
cgroupv1 does not have dirty folio throttling, as such this is a
mitigation against the case where there are too many folios in writeback
with nothing else to reclaim.

If a filesystem (eg fuse) may deadlock due to reclaim waiting on
writeback, then the filesystem needs to add inefficient messy workarounds
to prevent this. To improve the performance of these filesystems, this
commit adds two things:
a) a AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM mapping flag that filesystems
   may set to indicate that reclaim should not wait on writeback
b) if legacy memcg encounters a folio with this
   AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM flag set (eg case 3), the folio
   will be activated and skip reclaim (eg default to behavior in case 2)
   instead.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Miklos Szeredi <mszeredi@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/pagemap.h | 11 +++++++++++
 mm/vmscan.c             | 12 +++++++++---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 47bfc6b1b632..14c17279333f 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -210,6 +210,7 @@ enum mapping_flags {
 	AS_STABLE_WRITES = 7,	/* must wait for writeback before modifying
 				   folio contents */
 	AS_INACCESSIBLE = 8,	/* Do not attempt direct R/W access to the mapping */
+	AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM = 9,
 	/* Bits 16-25 are used for FOLIO_ORDER */
 	AS_FOLIO_ORDER_BITS = 5,
 	AS_FOLIO_ORDER_MIN = 16,
@@ -335,6 +336,16 @@ static inline bool mapping_inaccessible(struct address_space *mapping)
 	return test_bit(AS_INACCESSIBLE, &mapping->flags);
 }
 
+static inline void mapping_set_writeback_may_deadlock_on_reclaim(struct address_space *mapping)
+{
+	set_bit(AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM, &mapping->flags);
+}
+
+static inline bool mapping_writeback_may_deadlock_on_reclaim(struct address_space *mapping)
+{
+	return test_bit(AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM, &mapping->flags);
+}
+
 static inline gfp_t mapping_gfp_mask(struct address_space * mapping)
 {
 	return mapping->gfp_mask;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index c767d71c43d7..977ae68b6d5d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1165,8 +1165,10 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		 * 2) Global or new memcg reclaim encounters a folio that is
 		 *    not marked for immediate reclaim, or the caller does not
 		 *    have __GFP_FS (or __GFP_IO if it's simply going to swap,
-		 *    not to fs). In this case mark the folio for immediate
-		 *    reclaim and continue scanning.
+		 *    not to fs), or the folio belongs to a mapping where
+		 *    waiting on writeback during reclaim may lead to a deadlock.
+		 *    In this case mark the folio for immediate reclaim and
+		 *    continue scanning.
 		 *
 		 *    Require may_enter_fs() because we would wait on fs, which
 		 *    may not have submitted I/O yet. And the loop driver might
@@ -1191,6 +1193,8 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		 * takes to write them to disk.
 		 */
 		if (folio_test_writeback(folio)) {
+			mapping = folio_mapping(folio);
+
 			/* Case 1 above */
 			if (current_is_kswapd() &&
 			    folio_test_reclaim(folio) &&
@@ -1201,7 +1205,9 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 			/* Case 2 above */
 			} else if (writeback_throttling_sane(sc) ||
 			    !folio_test_reclaim(folio) ||
-			    !may_enter_fs(folio, sc->gfp_mask)) {
+			    !may_enter_fs(folio, sc->gfp_mask) ||
+			    (mapping &&
+			     mapping_writeback_may_deadlock_on_reclaim(mapping))) {
 				/*
 				 * This is slightly racy -
 				 * folio_end_writeback() might have
-- 
2.47.1


