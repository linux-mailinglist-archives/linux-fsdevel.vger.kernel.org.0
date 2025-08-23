Return-Path: <linux-fsdevel+bounces-58885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8537B3291B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Aug 2025 16:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1B03A278FF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Aug 2025 14:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F401E2858;
	Sat, 23 Aug 2025 14:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N82ZZf3B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A92B3BB48;
	Sat, 23 Aug 2025 14:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755958946; cv=none; b=d6Mx2lF56ZOj51JGB/UNY8z15XAOaXfMYiD4foUfEow/2WRLmyTfyMN/V/eRVQRGYk66s1pVl5xIH3nVztKoHzjq1DXJM3oo+WchWY8au0s6dPVQZ42t1Y/5iAz+AOI05vLaNiZmOFcEObhj+xudohgHk4G+6uNTgFtkNTDWqdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755958946; c=relaxed/simple;
	bh=C/1iNPBSdG7umnedy/flwGy8EOjLG/X0pyL6b5D2UCA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qxQKxdh5nKL9QctIDtEOvo/yGmePSFCcn9b5hy2ZH6PuPQcpVG/PBFLKhJLp+w2GWoblNPqI6wYke7x6Pog6+meu91UDtduSIOy4SWB8g5ZcmI7NYKfd1HoutLO+pFIDuxRQSZcmLlvTnU/YFnIhbWxFH1oJ5SsNr8LKOp6KJF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N82ZZf3B; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b47052620a6so2991492a12.1;
        Sat, 23 Aug 2025 07:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755958944; x=1756563744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B2pLZ6fneCyOAbhDYEuecMxHBI+84kQqLbWExnfJAcU=;
        b=N82ZZf3BrYbUiLL3+R01nf7xLAzol+BqQACLKlQ9Veq48jzyTw6KKRTNtFC4OZEQbX
         gm6eTmtwsNz42UGKGkTzUzgZjS9ahrpKtTAP1cUTbvLCEaY88ex58NxrrMUZV6sUlGBS
         QVqS1dKTYBpbTJ6RWVIPDPJqWO5J76cJxSyIFgb+GEvxCHRVE187CJBuMdjDR4ge7YXX
         dwa2Htbmci3gPc4VoPQGgZ6ouyoz6v4a+RQTQFcrv8e+AuV6Wi0avBFjZ/zD3CRoATGG
         l71k6yU9eJTwGKy5VVddyIp7EAkFBAIFSKn8m5QPZygRuRHaWKYcfFPUC4dKA44pJbqu
         R0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755958944; x=1756563744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B2pLZ6fneCyOAbhDYEuecMxHBI+84kQqLbWExnfJAcU=;
        b=W6+mnv4M+zk/sGMBW4dQxbHZgXU8EI2LsVTnBxWE8uaZZd8ldE/FiKaig+gLO59Nou
         VWldOxj4Z/EZrIl9fNWfCa53sZRVAQJrnZSurZ8ae76D5tHlACYBrBiDbiUbwkmwYdMS
         VprpBq5juK0Key7dQmbXK/53q2V8UimliY4ZIkxKOdOSK/vE4yeUV4Nt9dDV0HArWxju
         tVsXODX0mwbtPpgxQm6r8NjFLUp6i3XEV7lIgZ1CBn/jvg0kM0FT5q/7dSzu0jaAgH+Q
         fp0XeiNgMEy1j1LsIWqStGxUUOcNBiyxFOKuvHUnJnjTOsq/c18UeAEoJqhgw3z8pu2v
         lNOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUifSs1qivCqd11KRz9GZHwKZAIF2bjh+FMOY29cHF5Q3HsC5zA4sZIA9345TGj0j9KclYnCu2NyWI8BMz3@vger.kernel.org, AJvYcCXVDBPZ+y9sqrTvsWuqozQpH+YJ68g6wvzvX8u+Wr4rg3Z+xWqP3ZFBJAnKVDob/EMghSYdqTQCwuGL5aRw@vger.kernel.org
X-Gm-Message-State: AOJu0YzzqPN0Wtnpa2hHn1mzN7ztaHxxjV/RSeOmZwa5zoYFb1FauqPT
	fxPC6NUWXFDcn61KDYQr24mEC1Vw5fXFzf0zOZ3t1mD3u3oFCBLb/JfB
X-Gm-Gg: ASbGnct8EGIz1YQzSwshbRnblLBLAQB/xSN5wXRt9X+peXKYxT9rtC5t3jJCbEgrEXS
	iHI5nNXs8IAWim2rtV/YJEEhGpoIQIDJqbuOUMHFonkjykreqUTO6yvZ1EZ++goXev/gPnmt+5S
	mw+OXxTC4lXRHY38vuJP7Dl53tfoTkIpmrGY4SX/bABJjur9gF5dcP/pFjeLDmuQwDHi8JHJEc2
	KweyWmi7LpN53QXGJVr/o68NizHWVUpPfzfc5Ja86lV9/uqH4tXKoRLbvEICnx7a6JUAMtaETmI
	s/v7Nk4hOp5lL8kgHtBfQvB5t6QiOyGy2D2cRwQituMbICC61hC9FWD7k3NRFxFVlg9iuXeAqQK
	ykYhxYvNSjN1mStYgr/pubLUJY77aOA4Lxn137e9qaDLsXkkJ
X-Google-Smtp-Source: AGHT+IEOFX/aSCAjZmA0Wf96xLKSsK8y7GeKGOE4IS1zqaRJ9wp1aNZoMYqmpn6W7dylWmaTBAfVAA==
X-Received: by 2002:a17:902:ef50:b0:244:5bbe:acde with SMTP id d9443c01a7336-246340540ffmr81583055ad.28.1755958944287;
        Sat, 23 Aug 2025 07:22:24 -0700 (PDT)
Received: from localhost.localdomain ([114.79.178.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687b0feasm23688255ad.46.2025.08.23.07.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 07:22:23 -0700 (PDT)
From: Prithvi Tambewagh <activprithvi@gmail.com>
To: skhan@linuxfoundation.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: Prithvi Tambewagh <activprithvi@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fs: Document 'name' parameter in name_contains_dotdot()
Date: Sat, 23 Aug 2025 19:52:08 +0530
Message-Id: <20250823142208.10614-1-activprithvi@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation for the 'name' parameter in name_contains_dotdot()

Signed-off-by: Prithvi Tambewagh <activprithvi@gmail.com>
---
 include/linux/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index d7ab4f96d705..64e3c99d60f6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3281,7 +3281,7 @@ static inline bool is_dot_dotdot(const char *name, size_t len)
 
 /**
  * name_contains_dotdot - check if a file name contains ".." path components
- *
+ * @name: file name to  check
  * Search for ".." surrounded by either '/' or start/end of string.
  */
 static inline bool name_contains_dotdot(const char *name)
-- 
2.34.1


