Return-Path: <linux-fsdevel+bounces-49149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C331AB89B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 16:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E18EF1643B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 14:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FAD1FC7CB;
	Thu, 15 May 2025 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fh3cfGOB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4CC12CD8B;
	Thu, 15 May 2025 14:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747320363; cv=none; b=lLQjk3p7iIzX/Ae3zXNaFJkra1044FLherGDjfHvuXoTjXUQlkfiks62GuUN7iddFvbWx4OWpl0NUxGtuEkSEzLKujvV/dUwp+S397nG4i9P2x7edXnkjnK2Wjk5YI0DHlxtKt1tlQFuOCI0wmnsQGmUwRcNcWdedH3U83TvqOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747320363; c=relaxed/simple;
	bh=uP6tMGm9xi2j9pTznEkV9HDsT09jYV8jDGqz6ACeva0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ouDxnUHKptYnXOEq7/U3AFvqdjdKkE4+v2PaebiSNztDYk4ZMdTopusdWpE/JvPLpQMEa50ZLHxrKiMBmwe05bjJCUMrBqyiYXKDXCj4GQ9tZGSkc3Sqdhfj71dXQxV6pBpCqcBaK8DfD9uyhIOJODYYMJr1hKubWOoxJtyFJpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fh3cfGOB; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7418e182864so1135009b3a.1;
        Thu, 15 May 2025 07:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747320361; x=1747925161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VaNnp133QjePu0G+LkhstF0zTD9c9q+M1LCVIv6hFLM=;
        b=fh3cfGOBoBXoQvgOygqbWIjp8WOKcwLSw7jNtnH247agyOKplQ0rwVPkTsJKH4Dt4V
         OAy+SG4FpsHwQDrWScYvvnmkV7fWMwNTFl7dFpbB+T/pR54ZFglM9wIPfXPiacu9SbIM
         uxK4/hFnWWt8IrQlm5i5iOq18kdgI/Zu/4At0MhgX+3JRiGg5xOPGx/j808MVEWVXCgN
         9zYuBS9N+guwJZ7XqPW9YrLJAR1Yop2srvS8M1b9Q9uPepkCUL8oVvLA/QTMbIsYw3h0
         +EGXAXDM08nUOJOL9I1ah9WHIlo3HnKtAqmzX04u5qwJHrScurAZTgpN0l0aPnFpmJXm
         eQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747320361; x=1747925161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VaNnp133QjePu0G+LkhstF0zTD9c9q+M1LCVIv6hFLM=;
        b=ihof166jfvZQzcX3WqSSENAJT2ecVY+if+COjW6KwKtxqgHkq5k9l7N8T/RqZd5R5s
         IKrl+idL+p5Qyf+r5XZC/r8RYbxByDlGVW5LxS9BKaZZgilXVXz5rLF9fA/f5kq2WE3i
         b0BmXQQL4ZzxcPyHGqKdY2k7Nfo9swy8U6glEDJ/HnHhlU8r1DxcsQZ5N4kvz7eAVmKR
         oUViCg3uQ+zrFkSz3BEe5bAVj0KO7Jgn1lEYdYgtjuBs47qSs4MCApHzgRyjikg5fcgT
         HjGyxz4wOig05lNJeL9FuNuSDDVJP6aC4VcZcAohLMES7a+hXtR/Z4b++uSC2p+Fgpus
         7zHg==
X-Forwarded-Encrypted: i=1; AJvYcCXOSlx08LDDwwO/CDeX4MCLEvB7mVXsMiADxM3D3gbf2yFlle8ruQGHsrxf5yrH/8nhVKWIfumi7IHFWKl0@vger.kernel.org
X-Gm-Message-State: AOJu0YwsHoFqdz2sEVsCgEha+ozlJOh4qr67E1H/TsTdwkXABQfm0qAi
	NBuaw4Kc7gdh7W+aZ8S34EZZC3xYDKzh6Uymj5XjEYcQJjQRKspNaN0CEw==
X-Gm-Gg: ASbGncvlh+9WLKqq0kYTWsiWllZ+7XEB97MsyNgA3jNA2+zdW6tXdjQOkLf6/rXROnz
	rj29jxxRdFdVPI8PI1mCjfwBkEtRH6q7Ps1YZq0kwjBfc4XMxY/l3iTp+ZIAp9v9UB9EXaUl5aC
	an41J76+eY9wFaBEcPZVhW+sfqLREnhlJrtejF9xrSPTiFXRb/m55pnx7LwhkGvgs89nPD+GE1o
	4lanr+2nse2EkBKxbx0WrXOYk75b7cG88OsX7K0mDiQndlDxNgn+S1NWZ0xyJqhpvVdWSe8nEnn
	DjvX/Vx/YuYrvJqKdBDfnWA+Fh6+Snqhteq9t4iOZLHohwzbi2EibC1k
X-Google-Smtp-Source: AGHT+IHVlY3Ou5rSi9M6y+RVY3gWSstaRtz0pe8DyW0m0KLQHGBeSZtFTK/OI7PYBd5vkLayLZicBw==
X-Received: by 2002:a05:6a20:4311:b0:1f5:889c:3cdb with SMTP id adf61e73a8af0-215ff0975ecmr12533607637.8.1747320360481;
        Thu, 15 May 2025 07:46:00 -0700 (PDT)
Received: from dw-tp.in.ibm.com ([129.41.58.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf6e6a5sm3451a12.17.2025.05.15.07.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 07:45:59 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	John Garry <john.g.garry@oracle.com>,
	djwong@kernel.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v4 2/7] ext4: Check if inode uses extents in ext4_inode_can_atomic_write()
Date: Thu, 15 May 2025 20:15:34 +0530
Message-ID: <86bb502c979398a736ab371d8f35f6866a477f6c.1747289779.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747289779.git.ritesh.list@gmail.com>
References: <cover.1747289779.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

EXT4 only supports doing atomic write on inodes which uses extents, so
add a check in ext4_inode_can_atomic_write() which gets called during
open.

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/ext4.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 5a20e9cd7184..c0240f6f6491 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3847,7 +3847,9 @@ static inline int ext4_buffer_uptodate(struct buffer_head *bh)
 static inline bool ext4_inode_can_atomic_write(struct inode *inode)
 {
 
-	return S_ISREG(inode->i_mode) && EXT4_SB(inode->i_sb)->s_awu_min > 0;
+	return S_ISREG(inode->i_mode) &&
+		ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS) &&
+		EXT4_SB(inode->i_sb)->s_awu_min > 0;
 }
 
 extern int ext4_block_write_begin(handle_t *handle, struct folio *folio,
-- 
2.49.0


