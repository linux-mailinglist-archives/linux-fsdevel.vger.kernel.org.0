Return-Path: <linux-fsdevel+bounces-68349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 27500C59635
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 19:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 79A99500B02
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 18:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E1535A12D;
	Thu, 13 Nov 2025 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtGWwWjq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504BF33971D
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 17:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763056742; cv=none; b=YkqujlFWz+uAidfX6AltDT70pyRC7WBjhSG2lVK7X2Ypf3zNc7dgZOaa3OzeGgxdx/39d3v2RxbSTmFciYSujkRFkio5p+rYQhXC9uUh8BfCsBnjD8encLNZOI3cWF3GHDryZ9uHhZuVmVZwFQIyJe489HjLCg1jXK9K4BMm7d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763056742; c=relaxed/simple;
	bh=tzAHs/NW8hzxVyE7YgViwF3ICFGUKDmj3FMEsxS6U1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aWR4h+9xrmojvY4mQKURog4o8HllrHac+0c0EjTBAYxQcdDRR+9RLtQivGnPCruwTK5k68C3guLOlCC/OQ5e3PKfXiPyuLcDb6rwz1BGXFX1yBlbUzQerlwehiNrplk1GWeqmwmV5lzOV1NeTYLeSmHpXQP3V9FCWIveS5bTPvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtGWwWjq; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477549b3082so9991095e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 09:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763056737; x=1763661537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ONlXezZ8rYOFy9RaN+13wK2rQQVa66Pyx3TL3D7WvBY=;
        b=FtGWwWjqZFjpPt47P6Ju8vQUDh2w77wo3rilojDASBwiLmhr+U4TBZdbK0/XZLsJEL
         XGryyTvMkwp5vDHs7uV3O8qOa5KjDnn1rRAgIsxCFzc5khwhoVDYtzeeiwDWPaP9HQdw
         b50QahjM2tWnlynEOd2xg15yRJ30W/HacQOEV8cpeqG5vcE0Ivt33Nxz8b2GOO9dunN4
         eASNN5elj7l+mKhEu9RnRUsEaQup7Dm9Ejo1lEqZwRPSGRIY9wCZqzb53z5LN4fNzZfk
         OBNUbzA08oIv9Ud3pxIBrFgrUW24KGwEwzhZMvIDSCd7Evq1uMhyswb3sboH6TPkpB0d
         kfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763056737; x=1763661537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONlXezZ8rYOFy9RaN+13wK2rQQVa66Pyx3TL3D7WvBY=;
        b=CgOouFWQM2LUn0tHRgVtVwiU74rTaMzYxaTZSb/p4+d52voKtFjvyiSMSfvb1BO4L3
         1BgTCdK4RT6djiz1gmKmFB2Vi0+ydZ5bILFe+inmbN4u9A9X7DH9biur6oMYbdOfxN51
         R6WwYnyuYmnPO3ICrdPHgFOdxTKxROpwmgXZq4qa61dM9h8UTlIlqgXHpJTj8qnGJora
         68YEIE8Dl8s/063fL4/WwHpTt9gGMqkRrFrgSO5jRGK08eR7+T9K1SsTMvSAx1ehH6bc
         26U1Nu8JprSUgz4o7wiLhgbU3nrxc0KnPkdeES4i+PMiFpMKajySD6uJTjE9ZG9mkCDD
         S3yA==
X-Forwarded-Encrypted: i=1; AJvYcCW6vcqbkGzQ8O720rztT+G3lz04rTmhsjUbC2g8vML+t2W4uxv3cpbo0KJbF0cI7YDozHkRNaR80O9HfE/Q@vger.kernel.org
X-Gm-Message-State: AOJu0YyrtNiZEBsL/vaSImzwSttsU6vXG3I3NlFzt1LhRllxs4CIOQ0+
	0nfvVw/bqrLPUOmw+XQKfOCSp7InUAUxUK8UUWJD4de+zOCCjB4Bkv98
X-Gm-Gg: ASbGnctNn4LMDFezjZrNUgK1Swwh8dlVNOXoIGQxWiTDHNtM5Pj6RYSw/8j/N/BMnKW
	CYuf7seEObXCFOhVxe7big9y3jhxRsWr4YhUa8du1YT4v0y0vb3MACPMR9vSMixCdTnJNioVlKa
	pPthMmEGMJ+GAOFPHlIcgWuvwAdZp5zRLvBsAoIqR2N2L1IqCzohgZRnARyTwPox1X6brfJJixp
	rJX7f1Z2F1Tv9Ah9UuSp8uRfQQ3ceXVjLCr8yJlPs4HBIFyDogAO+srs8btexO7ky+rOD9P0J44
	3/VJNobMj/adEjR0pGw4HJxumXxVWs1c2ewDoWQaWRaLM1RqYgzA3+hkiZFxVvGnkz8M3LlW8O2
	fYv/ysclQrwn7Zespeu1mO5m8Kga3qd73Y9WkGqUihy9jLxV5wt0mPkTtQvJkRgnt3b4BYtvlXy
	kwK3JWPO66wkJUgiEqbS77BBmzU4NTvVHMJfPR/MNcTKhtVtr5
X-Google-Smtp-Source: AGHT+IHaYkfhslit1+bZ6h2bKwMphvfyMMNqhnEV5TKWd6eJOYYn+BKKgD1tVDFC16Scxd44ybfeUg==
X-Received: by 2002:a05:600c:3104:b0:471:14f5:126f with SMTP id 5b1f17b1804b1-4778fea6cf6mr3947605e9.33.1763056736734;
        Thu, 13 Nov 2025 09:58:56 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e95327sm98888575e9.12.2025.11.13.09.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 09:58:56 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org,
	jlayton@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3 1/2] filelock: use a consume fence in locks_inode_context()
Date: Thu, 13 Nov 2025 18:58:50 +0100
Message-ID: <20251113175852.2022230-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Matches the idiom of storing a pointer with a release fence and safely
getting the content with a consume fence after.

Eliminates an actual fence on some archs.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/filelock.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index 54b824c05299..dc15f5427680 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -241,7 +241,10 @@ bool locks_owner_has_blockers(struct file_lock_context *flctx,
 static inline struct file_lock_context *
 locks_inode_context(const struct inode *inode)
 {
-	return smp_load_acquire(&inode->i_flctx);
+	/*
+	 * Paired with the fence in locks_get_lock_context().
+	 */
+	return READ_ONCE(inode->i_flctx);
 }
 
 #else /* !CONFIG_FILE_LOCKING */
-- 
2.48.1


