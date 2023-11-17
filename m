Return-Path: <linux-fsdevel+bounces-3105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4F87EFAF6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 22:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AB311C20B40
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 21:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC0326ACF;
	Fri, 17 Nov 2023 21:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="XEX79j1b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD09ABC
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 13:38:51 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6bd73395bceso1883697b3a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 13:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1700257131; x=1700861931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V83WWTjr18Il15OBb68SAB6MSjKGeFK0q0ZpRJpEjKQ=;
        b=XEX79j1bGFSEFB2ACkXZ/R3OgHOc5F7iQomIXlN/cHA+iTQ4+c4ekm4qsLgdqzjv0j
         seoY1Z9CBsWzyQRrCDX9/YjlPqfovtR5uz9lY21qL/579r74h0Wdb4YBYeEPaNpR3OZC
         ki88b4IS7y2p9WucrwL/hCzOwxaUdam59WSliny1/2Zu3PaSzhzz8k0AVzjPShB5jGp7
         NqUsCoWrCwoSIgIdU38B32dDPcknRdXD2Uk86MYssfkTTq4WJOTLSYZkSzdFkhm94ukI
         ZsuAzZYIkqtzZwJAUENGC9Kr8jWk8/ozan4XsLfCNKLfOngKcXT/pSGlSgr7cEm/mL8Y
         /bZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700257131; x=1700861931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V83WWTjr18Il15OBb68SAB6MSjKGeFK0q0ZpRJpEjKQ=;
        b=l9utjGM3yjdqC98IvGlfP+w90L6t7Ex3frctvumROKWgMhNxU/P32Otj7cb5L2BUTp
         URnMVyjTK7ujrlLB5g6mkE4ytTpQpnPEc6G5CH/S/4c8cyfsgElYAUCKXGt+nQEHtcK0
         p5tZoealSeDIvion69epc/8rqKFEo80PczCJxfWCnk1vqRI3mk2mLAyT69eOBdE/NDGS
         dUpSgCDOA7OpKeJ9b2WzX1B4p9X9Mixl1pC1R3CER0Ws6WZCOIh5Cwhn8SukSN/E0kUU
         o8n9IYm0kq3fX5ZxUVgWcVd+0rH3Pn83+qHU/hiP/07X3EABZNyMNJriWCWiKECliEPc
         NNVg==
X-Gm-Message-State: AOJu0YwSoeCqtV2HEaMqiWBy6kYLsE960ohpdL0WWWC8ApHP2/zOvjY6
	k+QDmq6rQTCQPiV73Dh99h3u7S1AIcMswano3gk=
X-Google-Smtp-Source: AGHT+IGh6iTOa8ZLG1OgoKz2r5+pUSy+q5808oU4LyF71xppgP6bH04Rter23Y1DP8jdehVuI53XpQ==
X-Received: by 2002:a05:6a00:2d04:b0:6c3:3cb0:d85 with SMTP id fa4-20020a056a002d0400b006c33cb00d85mr10085883pfb.0.1700257130842;
        Fri, 17 Nov 2023 13:38:50 -0800 (PST)
Received: from telecaster.hsd1.wa.comcast.net ([2601:602:a300:3bc0::1923])
        by smtp.gmail.com with ESMTPSA id f52-20020a056a000b3400b006a7083f9f6esm1844028pfu.23.2023.11.17.13.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 13:38:50 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: linux-fsdevel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>
Cc: kernel-team@fb.com,
	linux-mm@kvack.org
Subject: [PATCH] iov_iter: fix copy_page_to_iter_nofault()
Date: Fri, 17 Nov 2023 13:38:46 -0800
Message-ID: <c1616e06b5248013cbbb1881bb4fef85a7a69ccb.1700257019.git.osandov@fb.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Omar Sandoval <osandov@fb.com>

The recent conversion to inline functions made two mistakes:

1. It tries to copy the full amount requested (bytes), not just what's
   available in the kmap'd page (n).
2. It's not applying the offset in the first page.

Note that copy_page_to_iter_nofault() is only used by /proc/kcore. This
was detected by drgn's test suite.

Fixes: f1982740f5e7 ("iov_iter: Convert iterate*() to inline funcs")
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 lib/iov_iter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index de7d11cf4c63..8ff6824a1005 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -409,7 +409,7 @@ size_t copy_page_to_iter_nofault(struct page *page, unsigned offset, size_t byte
 		void *kaddr = kmap_local_page(page);
 		size_t n = min(bytes, (size_t)PAGE_SIZE - offset);
 
-		n = iterate_and_advance(i, bytes, kaddr,
+		n = iterate_and_advance(i, n, kaddr + offset,
 					copy_to_user_iter_nofault,
 					memcpy_to_iter);
 		kunmap_local(kaddr);
-- 
2.42.0


