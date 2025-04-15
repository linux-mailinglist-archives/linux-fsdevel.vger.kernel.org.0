Return-Path: <linux-fsdevel+bounces-46440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 455BBA896DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 10:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18767441733
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 08:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FF227A934;
	Tue, 15 Apr 2025 08:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbTM3J1u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7141DAC92;
	Tue, 15 Apr 2025 08:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744706148; cv=none; b=nIq0VJUjGZGE1mgCo11L0ciGfuJNevdR5/jzUn9ttiixQY/b1+8a/sw3Kkou/E7DQVwq/Rg+ftpijyzMoyy3Mjw6wi++6D+l+ATvizOINEE7OkticwWpchfW1zPCJzrT9Uvc+bm16sPEGGzF0DCt1xEssuQ0WS5Q40VcuLirmS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744706148; c=relaxed/simple;
	bh=V1699VeLw28LsYN0B5Q7I8KcWdg2NFRLB5qafh9m23o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DZQwAkAdB/vvrV9isFHDmI6o6XLZTOmaR7V8xBkAB6ORXRwg4EoNsbYs9kl206zvpItDOc95bMnXlVYdmD0JazZlQ2jbbwXSP3KeB3E9gPw66Gx78wyWmG7Pzj3tLf0Gt8ja1dsS+bBO5jfNIMm9ovKsBxt7Up6vhcMWT/W7zos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbTM3J1u; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ff85fec403so5878481a91.1;
        Tue, 15 Apr 2025 01:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744706146; x=1745310946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b7wgcoQf1HXs+uoKapVgaPIMG7HIkBdUZKlvUkkaF2E=;
        b=XbTM3J1u1sO1pdUZLlZBisqxqKrSwetbgrSeJ+n0u4LN4OkexflhLGQLk1CKCQ7l53
         23hNxxieBobh8cAEaCqMUPccbrah7UDj0T/+/UPhj0NIpSE02M/6HGi/naOkiTbzeBFH
         h1xJyll3O5m335CFQrQi8w7S985VofkJN55Pxaui6mLMgqETCugU6bhoz3ODrEKjqcjj
         jj9WeX7+3/w6EPnKEDf62NMe0JL4xk65hYL7dm6FlLyERShyr7w5DZFu/OoRS3CFVSk3
         3eWFkeiKRIHsi1t3hLq2gYPh2xI5ktiPfD26L6gE5FNx6TO4h4J8sHFcURFlIwXdwPPr
         CM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744706146; x=1745310946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b7wgcoQf1HXs+uoKapVgaPIMG7HIkBdUZKlvUkkaF2E=;
        b=v9D6uHviGwtkx7NQWTsazWge9nEDaJ5uM8ZQr7Q+csnQYME8iCjlblCQbSAQ4YODm8
         qTJPxb6Gy03q8kFWMLCGH47ICJx5khVp16BtaU2u958ZZgvsd8zA/VpgBfLTu36MJh3s
         UoPcql3ksganAv4MOjGqt4lT6RLpRXKYukcxz8MnON/n0bkFVuBQu7GyC8bhWkWech+5
         Zr7ngfXc689nZNqs9+LdAq7NeDQ+pPnuKBG/+ZJTrAceViAORPw9LwiWQqeCWddpr959
         Y3dJtH2rohip5yL/rl05SA3LBXzGSnZghgSAavibMz+Jf5XSu4q/JLr2jRj6bbWB0bCl
         O9vw==
X-Forwarded-Encrypted: i=1; AJvYcCUA351BYpsyB0qw8tXgeZvFSsCSzE4oFi7tYbh9Z3W1Ai8xGTV+oZWKCtO4A1xJNqO9u/5Rty5yZA8gLac=@vger.kernel.org, AJvYcCUy+B7IgrvtHvxuvPnVdXQFr9cijODGpF+WTnkccfs96K3+IQcfn3oJglgy2a4Lm9B6dGs0G1fa@vger.kernel.org
X-Gm-Message-State: AOJu0YxzWdzdMwthZhCdAJV+JMY/OYVvKhm8x0V5oXVwrvyiIMSr+xK8
	aREtl3abaFGUjhy/soVU0NvRIOsOSq9yb4z2mNn3vjLWGbygh7Np
X-Gm-Gg: ASbGncsMe8EXQ3UfSZPnNfMGZiRJWKCoQs2oyDJnvTN4yujU/uuNMLOno7G60qU7xTf
	4z5ItseyLNjVd8Z5Sd0ZMIg4k0yIhKvsKcHf7TAUOWqo70eQapd37hZZa+OQeY3lLrMUjgHIH2/
	K6YazmrfZc/vSXC2YjdzBgYLYW/vw19Z6Mv54BmxkxkmWbap7TzAQvyy4Fol5jrUL9vyofxXzTN
	QyGHFsq0qjnz1AnQ5uFVNqG/UZBalfui6NVxQ56YZ0TcOzv+FPOJTdyCKlRXS4GrEE75Hm3X+Xk
	HFv/rf13dj38RMY5FNCd/3t8Uv6ckdGWcUJW3/I5/6QgNGw5O2MkQw29V4wl5Q==
X-Google-Smtp-Source: AGHT+IEtyDE/Rk+/GYGCjbdmJSJYIY9LwLisO4zjpojtftfoG8bs61Cw1ghB546bQODnjkT/w+EpWA==
X-Received: by 2002:a17:90b:58c5:b0:2fc:aaf:74d3 with SMTP id 98e67ed59e1d1-3084f2fbb88mr3594703a91.4.1744706145908;
        Tue, 15 Apr 2025 01:35:45 -0700 (PDT)
Received: from VM-16-38-fedora.. ([43.135.149.86])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306df06a767sm13973871a91.6.2025.04.15.01.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 01:35:45 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: willy@infradead.org,
	akpm@linux-foundation.org,
	andrea@betterlinux.com,
	fengguang.wu@intel.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	mengensun@tencent.com,
	Jinliang Zheng <alexjlzheng@tencent.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm: fix ratelimit_pages update error in dirty_ratio_handler()
Date: Tue, 15 Apr 2025 16:35:42 +0800
Message-ID: <20250415083542.6946-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinliang Zheng <alexjlzheng@tencent.com>

In the dirty_ratio_handler() function, vm_dirty_bytes must be set to
zero before calling writeback_set_ratelimit(), as global_dirty_limits()
always prioritizes the value of vm_dirty_bytes.

Fixes: 9d823e8f6b1b ("writeback: per task dirty rate limit")
Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
Cc: stable@vger.kernel.org
---
 mm/page-writeback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index c81624bc3969..20e1d76f1eba 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -520,8 +520,8 @@ static int dirty_ratio_handler(const struct ctl_table *table, int write, void *b
 
 	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 	if (ret == 0 && write && vm_dirty_ratio != old_ratio) {
-		writeback_set_ratelimit();
 		vm_dirty_bytes = 0;
+		writeback_set_ratelimit();
 	}
 	return ret;
 }
-- 
2.49.0


