Return-Path: <linux-fsdevel+bounces-36614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78ADE9E68F1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 09:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD9A01886D7E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 08:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937CC1E1A31;
	Fri,  6 Dec 2024 08:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7xy+32A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFA41DF985;
	Fri,  6 Dec 2024 08:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733473904; cv=none; b=ParK7yKqxxuKcepEk3YZMI+6dqkal4U4cIz18PHKpTrKBivbV/iJll+MEFjmtggRKrjDrfvtvR1IyAvLXV1fRqgD87epWbfL6gflhWpmkrQEiTsxG33zdWzSXmmXrO8YzK6X2mPB+KKQeSy+l0SUf9lNQEoHdL0cG6D7/GxJ/DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733473904; c=relaxed/simple;
	bh=JqJYyNs+EZIorojWZ80JEwxFDXIe0wdVEqTThkDqp/c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QwaU7FLOjKc/wIlPNfvriqS7dWiRmtjFXp2mrFldEh05Wb3y1bEOek3s8uTzyrsOPjWaDxAcuSAxkYEtxQYYiPIrUmZXKKI9aesvj2BHVVYr2WwZDas/5FmGiyCxt1anVA8ACZnM6/B5Ptsbev/Jz5kygCU0H15vdKutfdV5Z1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7xy+32A; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7fd24730dadso607305a12.1;
        Fri, 06 Dec 2024 00:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733473901; x=1734078701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gaIpQvkdoMLTjaf/6msdYPERNNt0XKX/eslq4dA70x8=;
        b=P7xy+32AVCx1DIBrbLOY5mux49WxVK1eaFvluvQal7EiXJRRZlw+JpwfjTbEEr1K2J
         iRZff2yU6oNG0KU5V0P70DVvIP4POe159VO2qb1nTLGnIHVB8FbEOgC7g8lPR2C0Ek0P
         raN2WsVbfJUwWD/oRHuzLKn5VfMQSrd1FKLvYX3zA9t3trxkJ63j8RBSED2UiFr6z+Oh
         Rqmk04ISkruNlBIaCs9LlWvsDMKUJ/WkVEyUd12lfTZihrmE5xbTMIOhBcFC7MBL+9kQ
         71BJ9osLoHRzysvbtEcr9b73cvE+6ctSRenZBbc+LS7/Sb9FJpIB4GGMYSaCPP+EJyg1
         Hk0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733473901; x=1734078701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gaIpQvkdoMLTjaf/6msdYPERNNt0XKX/eslq4dA70x8=;
        b=nvT8XuY/xlebapwVwdiaOlAHm+ezIA/HmUXXUOlfvVPe744u0AnNEhaeMbo/208RdO
         N0/ahrGVw/q3fCWlBj5nEnpu/FJz0hnz4IfihlbkoH1pOWlOeEgoy0D6G6UrcQekDrAy
         fyN4EwcdcHujlY5EiCulTaA9UF9OrMqS5iLJeMqXg15ukkvKuD+yIW8CcyX/zVno7+M3
         dvAhx7CWVkHfcF0wuE0LIHiBT2F+OwAXL4GL0NyE39TKeiCPbFz/uUelbyuGoQ05fikV
         pJOimPA46pLxuNjjeGUnojvIRVcY9wyJO3bscgWakA88WqMdSluWIAclCItK2l1JpVSB
         rQWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp49PACHJLW7VgYVb2RrZsRoCV73P93SU4vscekwCWDhgkdnlFwZNpJXPO+soTyFJH3olmxkaL@vger.kernel.org, AJvYcCWLduZSO21N3xEUqXr28x6rTsdF5Mdd3p2nxxLJkosHc5CrZ/L3Yfj3e+1tMrgoda0wn0r2bwZShEtu6XQ8@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/SFvw1NjbVg8J24AqSxAy2Z3Marbr/TmW8DseNllfSJcbI5OO
	FYd0u5N2QrrTjogVR+jpkhExWbQA8A+1UcC1lbQpGKwkZwlx8TXT
X-Gm-Gg: ASbGncspQHGDh9JGxkv79mxRXEhjJSBZyD7aFs1wKuwu6jJBsrpawlsliiXi6X86JY2
	9EwiI/sF58KYO/TEJGERwduwz9J2qr+PQ20ENdB7MBelQD3aJAcyRM/Ll6YdUxc1e/ke82VJx3M
	4upkD+Z6Qg+8dNm5iFqwX5+s0ChuM94UuDsmxcK2Sz+E7C2qjVbr13qCxD4YcqYJUDMH/FW4Xxi
	2rFMGyIbqQSmaY6fIEQ+OBd
X-Google-Smtp-Source: AGHT+IEvLMZ3ZxPJciJz3ObXqoij4WO4W4Oiw708kBft81mgnEsWCEQn/YsBCCJOK3kpW/swgyQmpg==
X-Received: by 2002:a05:6a20:7fa6:b0:1d9:1a77:3875 with SMTP id adf61e73a8af0-1e18715fceemr2397434637.42.1733473900638;
        Fri, 06 Dec 2024 00:31:40 -0800 (PST)
Received: from localhost.localdomain ([39.144.106.32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd1568f29esm2550866a12.15.2024.12.06.00.31.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Dec 2024 00:31:40 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org,
	david@redhat.com,
	oliver.sang@intel.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Yafang Shao <laoar.shao@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] mm/readahead: fix large folio support in async readahead
Date: Fri,  6 Dec 2024 16:30:25 +0800
Message-Id: <20241206083025.3478-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When testing large folio support with XFS on our servers, we observed that
only a few large folios are mapped when reading large files via mmap.
After a thorough analysis, I identified it was caused by the
`/sys/block/*/queue/read_ahead_kb` setting.  On our test servers, this
parameter is set to 128KB.  After I tune it to 2MB, the large folio can
work as expected.  However, I believe the large folio behavior should not
be dependent on the value of read_ahead_kb.  It would be more robust if
the kernel can automatically adopt to it.

With /sys/block/*/queue/read_ahead_kb set to 128KB and performing a
sequential read on a 1GB file using MADV_HUGEPAGE, the differences in
/proc/meminfo are as follows:

- before this patch
  FileHugePages:     18432 kB
  FilePmdMapped:      4096 kB

- after this patch
  FileHugePages:   1067008 kB
  FilePmdMapped:   1048576 kB

This shows that after applying the patch, the entire 1GB file is mapped to
huge pages.  The stable list is CCed, as without this patch, large folios
don't function optimally in the readahead path.

It's worth noting that if read_ahead_kb is set to a larger value that
isn't aligned with huge page sizes (e.g., 4MB + 128KB), it may still fail
to map to hugepages.

Link: https://lkml.kernel.org/r/20241108141710.9721-1-laoar.shao@gmail.com
Fixes: 4687fdbb805a ("mm/filemap: Support VM_HUGEPAGE for file mappings")
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Tested-by: kernel test robot <oliver.sang@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: <stable@vger.kernel.org>
---
 mm/readahead.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Changes:
v2->v3:
- Fix the softlockup reported by kernel test robot
  https://lore.kernel.org/linux-fsdevel/202411292300.61edbd37-lkp@intel.com/

v1->v2: https://lore.kernel.org/linux-mm/20241108141710.9721-1-laoar.shao@gmail.com/
- Drop the alignment (Matthew)
- Improve commit log (Andrew)

RFC->v1: https://lore.kernel.org/linux-mm/20241106092114.8408-1-laoar.shao@gmail.com/
- Simplify the code as suggested by Matthew

RFC: https://lore.kernel.org/linux-mm/20241104143015.34684-1-laoar.shao@gmail.com/

diff --git a/mm/readahead.c b/mm/readahead.c
index 3dc6c7a128dd..1dc3cffd4843 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -642,7 +642,11 @@ void page_cache_async_ra(struct readahead_control *ractl,
 			1UL << order);
 	if (index == expected) {
 		ra->start += ra->size;
-		ra->size = get_next_ra_size(ra, max_pages);
+		/*
+		 * In the case of MADV_HUGEPAGE, the actual size might exceed
+		 * the readahead window.
+		 */
+		ra->size = max(ra->size, get_next_ra_size(ra, max_pages));
 		ra->async_size = ra->size;
 		goto readit;
 	}
-- 
2.43.5


