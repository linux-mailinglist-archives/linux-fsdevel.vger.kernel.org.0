Return-Path: <linux-fsdevel+bounces-73506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EDFD1B04F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 20:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2AC7E301D5EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 19:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748A935CBB4;
	Tue, 13 Jan 2026 19:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZEhyWYr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860292C235D
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 19:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768332171; cv=none; b=makgKKGybUHOkcnEdUFDTE31d5+Xvj6IKAqjn23QVx0Cd1QI66DiEvMiOum8zlBWr/lxdwQt2k8l6vsx1xL298hfPra9vV/5CWdQNng5Mhim9iHIn+4R1d0FowXY2Z5APRaMJLw5P49px8RwZxVTvu90oAvxcQQx4OneHaqR8ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768332171; c=relaxed/simple;
	bh=j1L4pnOElRpSPj4zMiqTk5GgXs5WOyROVozsjEIozug=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SK/mYiwQj6hLHkz6dM66TSwNLa6qN4DJznWuVJzlgpgZAjgI1Q0dM8O7GlB7ZFbnAbZo8pmDphCpFx/hMMfURPnQ/TRlzRkzNHvugWPb8IjUxCPZlut/gcdMwNtyqY2U+IfoQ+2tr1g+zq0ETrheHmlO9rBdH4CGG9N9jQjei1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZEhyWYr; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4327555464cso4769208f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 11:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768332168; x=1768936968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OPO9uqIbyGUgN455QMIPxbZJ2oQ5aHU3z8mctC35CmY=;
        b=AZEhyWYrrYAERWefTeFSt+AW+fEyZa12y6rIp0Hkz6THvnOHgWfgSHoP0j4Wssg5Cl
         Gk8HOfNRT2xPDULgv+TqI+kG+0uedTuCIHUqTpM4dWLfqOm/FitnJNPGxGtcDVokBNL4
         8roR4PEbfNkkoMdQx2Qyg/JR3nbrhqf6YrPUuERETMlCc6JGUPpLim9Vll+r5gi0gGLh
         2uEOVytYWG0Ec67TixDtOqHOg0dAb3rglKUg5jPV1/0++9rxOXv3niT3tEVqpFz4MtfD
         L5P322M6J6IggiKgfykbvPmwNFO/+/YMBG1TfzRIZiQiJhEvqf1JZD6k65YWMLwxGL4S
         fM+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768332168; x=1768936968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPO9uqIbyGUgN455QMIPxbZJ2oQ5aHU3z8mctC35CmY=;
        b=sGFm0YAmtAs3U4++luDIZ73qAwu7J7ISfW0jBrXQqVwF0q8I7EOqH1Ad59hs1itnNR
         ibN0SFiP1Xnn56awKpG8bwigh7ZwFwXUXFB8gz/JbUpykaaIIFee/TXpYHq7FNOzlqeW
         xDIrO3ZwkhiN36RgR0knwp7n0XQ4hlfM+OGIN+pkSQf571difmtba2V5aGK0G5l8nov3
         sA7cThvlmjAReIVKaxe4P0uWzgpX0NhW86N4twOR0wV4ixCjTlGOsUA+N3jeoWtV1GMI
         GdODq5JwxVt3DckXPnSnQet/YsvnNbZlyfBSLAqNZo//c56uykZ8xgfruTsHpJMklHab
         VkQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdFAnx5GA04G/MGRz5Jj3plnXnC3MFNGsKMU1ZqKJSyAgIEn+K4vsioLIxdd5m8Lnah/7Oas4RO0BTgm9h@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9T+6+1mK4qIWldkZgvEnnBslRE87z1J4sWZPnxTuNdReRBZbJ
	/U4eIEaj/xvLxLl3qPzec5rnYAu8fNTzc12q5fj2+ylomXq9l9aSRQPShSPRJg==
X-Gm-Gg: AY/fxX52C1it/+iY49S0WTsrqHTv+5r9EW3DPs3IzZBYT9CylLOgY8amS+9VZuQduxE
	HCP4V39zWz7Tx9FJIj+YgZrhPQ0sVI8lO47G44uHuQscSOPaUrYqb+o+B1akT6NEbwHwWVKBVc/
	JUVJKLE540gjJqOnjYNEbe1wEC3ARysD+c7ufmmtSxezijTVysoCMfA6eztXK8p7y3XhUvLgFT0
	ZpCyYK/jVoeM2agzXGsdZxsDw8IkXwnQzaoZ5cR96Qmt6CbC746gFPU/LTpBxTLorBSg158gGjx
	209nbY02gbUKDM+lV9oHq49gYet+JPG0PhKK8JvjKauLyba++nnfZsseTIjFnG9jau7RzI/jxJS
	JwBfo9PV/djDASeWon9mb4VZC7n2njgS0gXos9axXRFhJtZq9GS7j+1+gaUGY/FA/N3Vcq9Z7Vy
	WLr+NdwcXznRpaYI4x1jRN5cUljbdlvEocHdZQUhqYhiGlBy1zwrKe0VPelfJuAHS9BAkadc2V0
	3gs668P7cg=
X-Received: by 2002:a05:6000:1865:b0:431:16d:63d1 with SMTP id ffacd0b85a97d-4342c548881mr9712f8f.44.1768332167701;
        Tue, 13 Jan 2026 11:22:47 -0800 (PST)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e16f4sm46863209f8f.11.2026.01.13.11.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 11:22:47 -0800 (PST)
From: david.laight.linux@gmail.com
To: Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Kees Cook <kees@kernel.org>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Theodore Ts'o <tytso@mit.edu>,
	Brian Masney <bmasney@redhat.com>
Cc: David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next] fuse: Fix 'min: signedness error' in fuse_wr_pages()
Date: Tue, 13 Jan 2026 19:22:43 +0000
Message-Id: <20260113192243.73983-1-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

On 32bit systems 'pos' is s64 and everything else is 32bit so the
first argument to min() is signed - generating a warning.
On 64bit systems 'len' is 64bit unsigned forcing everything to unsigned.

Fix by reworking the exprssion to completely avoid 64bit maths on 32bit.
Use DIV_ROUND_UP() instead of open-coding something equivalent.

Note that the 32bit 'len' cannot overflow because the syscall interface
limits read/write (etc) to (INT_MAX - PAGE_SIZE) bytes (even on 64bit).

Fixes: 0f5bb0cfb0b4 ("fs: use min() or umin() instead of min_t()")
Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 fs/fuse/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 2595b6b4922b..ff823b0545ed 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1323,8 +1323,8 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 static inline unsigned int fuse_wr_pages(loff_t pos, size_t len,
 				     unsigned int max_pages)
 {
-	return min(((pos + len - 1) >> PAGE_SHIFT) - (pos >> PAGE_SHIFT) + 1,
-		   max_pages);
+	len += pos % PAGE_SIZE;
+	return min(DIV_ROUND_UP(len, PAGE_SIZE), max_pages);
 }
 
 static ssize_t fuse_perform_write(struct kiocb *iocb, struct iov_iter *ii)
-- 
2.39.5


