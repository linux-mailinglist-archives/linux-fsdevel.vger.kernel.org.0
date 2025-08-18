Return-Path: <linux-fsdevel+bounces-58200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2A3B2B049
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 20:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EA7156679C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 18:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AA03314B1;
	Mon, 18 Aug 2025 18:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJEbi1py"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464AF3314A2;
	Mon, 18 Aug 2025 18:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755541646; cv=none; b=F8R+KsSE3Qsh7RlUb/YaL8LxbfCgu8NOH5G7vbdrjDxlp19ItXC3wfsevECOl4SajXGRb6ccdPzCWEItNn3Aa9l//zj1Lw/O0U7BU8D6bGJ9ZTsHqvErYgLY6mvLEUyKAeNowt9ujUxy21pMoXXPtdrgHZAC6npIT8kMOhJTfgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755541646; c=relaxed/simple;
	bh=JCKUiyE7LvQKokD1Uq6GmQAvtruiQweC9XXHp0iTSkI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KbE9lzSP0EPRL8TNnfYGImv3tZQ2Du0Y2JzO9/gbsdjflVKpzCLXMVnFf8bLeklU5/dM5sVt+RAEni/ztPUiZPSBLb1YOx6IStj7dsD9LuM1g/962Ek1TfqdfMTLJdSaEAn41a7yzFP03rR+iprsKPlgIIelPbSPJ9hQKirkPlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJEbi1py; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-b47156b3b79so3328833a12.0;
        Mon, 18 Aug 2025 11:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755541644; x=1756146444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1UBICNtV01HOUgPFmy2kmdepvqLkWf1wTnkenSpn6Mc=;
        b=kJEbi1py1EgtZuF9iamw3yU5fLp70od7KchmM/gYHg2i5nowyPRMSFawTZn5xxmMh9
         ZZcJ0pvCugHFXUQL8RLTqOkQ6No56qBydMrVTVJNjQ83cG3SmKnHFTv29dasdQtWrhEN
         tW14dplwrR4gnqiBVfmOHBc6WUrjfN1hpuxSCm/DGkgytfwA2K84Ti3WJSEI4HC3j1jk
         2nb4Rd3mGUXma8LnWjWXQP5F3TOLiXwzSVPz9fAw5M9lsFtSikykyVqwU09RxH0YVi6x
         8bGUTGJ9E2GB1uWBjUfLl+MA8a6gf8lE/C+GZ7b1LithCS1rwD7CtLRTadX00LCiXui+
         Aqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755541644; x=1756146444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1UBICNtV01HOUgPFmy2kmdepvqLkWf1wTnkenSpn6Mc=;
        b=hqbZBVa5R8IZm9KDS6EVCRG2JFL6ZmXUd1orHpkxIE3ZFuL0vjJQMFLqc6BnwlPpuv
         nxdxjaRn365OqYb6AbfyWO2tmf/49xY39l+n4In87dM/+CbhRGY3Xuq3CWPcpHDYSt0n
         pFkiwocivSZShfsVxPoo5QFpkjgh9q1n08gvg0OI0twmg68A/RjbP8LAzoIqlazYOyPr
         oaa1HJsKvjiw8JqcfmmdQ1Gg5rNyiHUQ/gYj2NrdPj7qe1HtlihTRFCb0ui1vyWf7hsz
         RPW8ikXbkZziilNA00ZiXsH2HQX5XJZRT0Xw92G0w3Z/PTBA6v+HfQf9ht56Wp8KLk3s
         QmgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLfNHDkrxfJJEsH+0K//12bcod9KBApLWynYy0Hs5lLdNf1AlOZ/HwOU5kiyStC2IbgYB77jc+ShkLtF9T@vger.kernel.org, AJvYcCXVanXIhf67CDRusINzw72qDIB6FiYinWRfpa1c9P50N+6zHdo/cmzBwSA2u4df+4G3q2XjrqLrMuw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh0wwKFmZdt+eAnPjtB10B4rHwgFmNy3+4cUhRmn4v26HVy2ve
	78TN5EEiKFRRWlyOMXICRzspKnwV2uwdvWoo0KnmyDIkcfj9d0p1d+xN
X-Gm-Gg: ASbGncttNPDsA2iBKqNeTd41YovI8LGYbZ9zkprbPzaQ77aBadnQYjK3ZpEeTulssA6
	LOFN35PTXCbD0B8rKfSjsTV3nGv+SVC/iAj+XZx6232bxh7a5FUyTbuBoRsp7bfzf2Akk9itnSB
	g21ykp64Cn8x0N+Dsi9vVT35W+nB7rSVMAeoJOY2HY+4FvgjQgOkZzW9q+zY6wcNJC14uplCseC
	pTxnYyDh+Orz3e08mQvVDTXK1HktF2t9Aov5MnPhhHeOglI9wFlgo4QbqkAtldEp+6rgfdXHHEA
	KUhZ5RI8YcabyHFPgfEpKeOsrl1J+bDggYQNZxQ3REU4AOtDdEAjnHyPDjeT+1BLj1eb7Y2dgCt
	947U+YUvT4kNwnlQ24W5CzExbH7rqGU/py1mU
X-Google-Smtp-Source: AGHT+IFo9q22uJAU9Cy1g8OPxX2RxfH+wNKYrCEg9SFElzcpE0VunUzB4MWZu5dWrCeB513oCefNkg==
X-Received: by 2002:a17:902:ecca:b0:240:5bf7:97ac with SMTP id d9443c01a7336-2449c9be48cmr6168945ad.16.1755541644414;
        Mon, 18 Aug 2025 11:27:24 -0700 (PDT)
Received: from Ubuntu24.. ([103.187.64.31])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50f576sm87080265ad.101.2025.08.18.11.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 11:27:23 -0700 (PDT)
From: Shrikant Raskar <raskar.shree97@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Shrikant Raskar <raskar.shree97@gmail.com>
Subject: [PATCH] fs: document 'name' parameter in name_contains_dotdot()
Date: Mon, 18 Aug 2025 23:56:52 +0530
Message-ID: <20250818182652.29092-1-raskar.shree97@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds a brief description of the 'name' parameter to resolve
the kernel-doc warning.

Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
---
 include/linux/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index d7ab4f96d705..9f5c91962e85 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3281,7 +3281,7 @@ static inline bool is_dot_dotdot(const char *name, size_t len)
 
 /**
  * name_contains_dotdot - check if a file name contains ".." path components
- *
+ * @name: file name or path string to check
  * Search for ".." surrounded by either '/' or start/end of string.
  */
 static inline bool name_contains_dotdot(const char *name)
-- 
2.43.0


