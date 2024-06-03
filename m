Return-Path: <linux-fsdevel+bounces-20857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAADD8D888F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 20:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B4A91F22AB6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 18:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7D01384AB;
	Mon,  3 Jun 2024 18:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WetvLmim"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB61D137C4A;
	Mon,  3 Jun 2024 18:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717439052; cv=none; b=cyc09YjMPu6IBG3tS28XTEo+n9OHW1kQuBVvabyb+mP4+0C/iJZjCtJr+KnnvlWQn/YWrZdoBbPoTrl6fCC+bXWacnOtm2jankZOIbLp+Pm1wUI5gQUoiWOXdSDT8quSjCMvlh+mljwYYH7GGW0fEnjcu1astrWYMG9Pu8j8jY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717439052; c=relaxed/simple;
	bh=hDcknhcOYWbRk6WkT26dnpu/5uKCkV7h6LNO0ijMspA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pi8N37wEVelnQND3jYO4I/yueTob6g8028gQHWC93gnakvSvvzizLtJhGpk8EFUuQ/SiZRjX+F1mZ9QOW7iELS3zwd5Cw29wJnMX0hRPwtDWaXyALCXyXAqkP53113kbIyNY4Bu0VRsK0zpu6uIEXQ04ExZuz2UxteDF0xD9ykQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WetvLmim; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5b3241a69f4so2220034eaf.2;
        Mon, 03 Jun 2024 11:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717439050; x=1718043850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5EI4ejkvsKs4g2VYFTyDLmFa3QzZwi5NQWive6oeaWA=;
        b=WetvLmimo28CDbCThVCrz0/B+CodS7qK1CVeYair99Dk5L5LitBL1bu/8e9ikyZwXn
         qEW0kf6y0N10foLfhnkoJqWKaWeSdNTw+nNF3u3ldOMYF7xB97lbUd8Jn6A+6kVm5Jgf
         gE/nX5OG68RD8ol3QcXByR9WiQJIym3jRxXFCrwVMvqKRKEpKC5MS1huy5djEcQZ7Hiq
         pxZyvWaM/1vWETbEOtW7Sm1wyz/qYi87YcoFAWmuxuW3WdpkdGyvVAqi4DXnwwEUDCvM
         AXpyAu3R/sQit94Ft3Zy+QUUdtTLph9fUZ7rHWl1+GNZFzV5wi0EeIWotRfFz4PZMpKz
         Sw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717439050; x=1718043850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5EI4ejkvsKs4g2VYFTyDLmFa3QzZwi5NQWive6oeaWA=;
        b=KQwtzJBbBmBf26WTHlX8iaqbdAuVHXOsJeFKJAVzatJ30a8CTBDqiE/wCEfgVcc5Fy
         cP9G5hvPcDBmnRMht+7gRXKuAx65UT2fIT5l2X/S/m5cyFJ8XYOyHY6v+i7Xm9K8bJ58
         NEQCA1oVmW/LeQ8LEGqPKMK7viMXF1C9C4NjrB8hCzrw59FGxgXfjRAPrKcz5b8Ufl/W
         4WfXz7Aje4VUeIAa8GGdmScRK+eCkn9KNAEOFE1sRmjgvdhtKvmoi4TaUYpPuTcC2c+7
         wd0lZxmDylnxRSAolM1ftiEv8F5cJ3tFOOfdIEPqkkgj/Sc9kh10UMgyDumTM1Yz1/GS
         S+Xg==
X-Forwarded-Encrypted: i=1; AJvYcCWbF80KvX3+mh4WMNeQ7DQXI8+bsPj3oOU5OSxQ7v3Lt9oJh1kqalGE4ApyKTrflVSwVO7vCcJiKdCjnihbCktCjCLMeOyVI2x/hHlahtbK5TS7fUTPMug6ikovUXhX/Dy6yjLpsVjLd90/sA==
X-Gm-Message-State: AOJu0Yx1OzbmFIlL5M/f8B3NX9OF+6t+5AJx7Df/clLfyNYib101WvXx
	6lWDQ4RZR8EkLLWJIAcNfIuVgVq3wVXpCHaclsmKQKf+3l7CcviiTuaf97aW
X-Google-Smtp-Source: AGHT+IF/PMhSgjeWGpH+lwhjVNWk5wZqk+U9pM49w8GWSnAmdfw1UbZDr9/cU2rHjJbRKm8oEEESpQ==
X-Received: by 2002:a05:6358:f44:b0:183:612d:44a1 with SMTP id e5c5f4694b2df-19b490c54bamr1072290955d.28.1717439049552;
        Mon, 03 Jun 2024 11:24:09 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c1:3c:9322:2d09:c2c:3b62:755a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c35a4ba741sm5075892a12.85.2024.06.03.11.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 11:24:09 -0700 (PDT)
From: Amit Vadhavana <av2082000@gmail.com>
To: dhowells@redhat.com,
	jlayton@kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	av2082000@gmail.com
Subject: [PATCH] netfs: Fix documentation comment for netfs_wait_for_outstanding_io()
Date: Mon,  3 Jun 2024 23:53:56 +0530
Message-Id: <20240603182356.11682-1-av2082000@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the parameter name in the documentation comment of the
netfs_wait_for_outstanding_io() to match the actual function parameter.
This change ensures that the kernel-doc tool can generate accurate
documentation and eliminates any warnings related to parameter mismatches.

kernel-doc warning:
  ./include/linux/netfs.h:532: warning: Function parameter or struct member 'inode' not described in 'netfs_wait_for_outstanding_io'
  ./include/linux/netfs.h:532: warning: Excess function parameter 'ctx' description in 'netfs_wait_for_outstanding_io'

Signed-off-by: Amit Vadhavana <av2082000@gmail.com>
---
 include/linux/netfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 3ca3906bb8da..5d0288938cc2 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -521,7 +521,7 @@ static inline struct fscache_cookie *netfs_i_cookie(struct netfs_inode *ctx)
 
 /**
  * netfs_wait_for_outstanding_io - Wait for outstanding I/O to complete
- * @ctx: The netfs inode to wait on
+ * @inode: The netfs inode to wait on
  *
  * Wait for outstanding I/O requests of any type to complete.  This is intended
  * to be called from inode eviction routines.  This makes sure that any
-- 
2.25.1


