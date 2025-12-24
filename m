Return-Path: <linux-fsdevel+bounces-72072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA686CDCE0B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 17:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04D4F3026A9F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 16:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86508329390;
	Wed, 24 Dec 2025 16:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIwO9sNp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9529A257824
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Dec 2025 16:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766594608; cv=none; b=KSEyO2m0beixDsuamkOaZvio99k1dh5hHab4cZXNnJXtNT/TrgHEimDFo7s+F105BQt+llMJPXvyMT15vxcLwMbYVhgWzfvuUXSTH6A1JQQOcwKG2PSmBFnRuIhhNYTiGp0K/8mRp8aPkAeti1OHg2ioqVmZw35sNn5BIgnT6Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766594608; c=relaxed/simple;
	bh=AiiMcR0T/Q577F9tdt0FEwOLmgTPTKSndvU3PGKdp/o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZB1oKO98VIZ/ZYQnaya7obfoek2y787xVjhAgmuS+yXKSbV14mSu3SyH6MWrRjosAT3Nqfe0uU67ATE/3DjDOAvoWx3YAFrHSnwsk+e4qkir615jhuxuMtHxUD/G568EKUGGNXLzvKOUBR7azkGPolOf793s3AF0agmF4/cQAuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIwO9sNp; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7f89d0b37f0so3563183b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Dec 2025 08:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766594605; x=1767199405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ssG8N04RBTKk33KNiGJ23C3mBaOiOd3tZk3DIrx1DLk=;
        b=HIwO9sNp7ygPXHdecLYt65BdPrIwZ81jqG4QXbrXwjDaosmeqf35Bwt8GOQFCJANyI
         1LlmSuzAVZ/PmhYhGxU3uqG5KWCkmZTFU/fzfeLeve/DSU6GFMfN9XV95ZG9C2oqn8uv
         mdkb7Dfv0/7+9st5Hyy3BxICyqIOiZiEnfB6R4NUoYgt4Uzd9M+OZHxgWgpZhLNZZ7mR
         unpy2bOU9OmcRKepWnPIwgOYE4jP0nnado616WTk3gyVfldiVhpH+LNZ27Ug6i2xKqlw
         BhN8z3dffGJ2S8c7VOrDqEnPPiGNo9B4dKnAooSofCpu/TFqsXci5/3283CO7YBuqBTU
         +nUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766594605; x=1767199405;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ssG8N04RBTKk33KNiGJ23C3mBaOiOd3tZk3DIrx1DLk=;
        b=Qoz1eCJE3OTlVtTeXr34JUWOd8hUtEJmiTjxbrU+cThwCGWYIVCElFBcHVgsOen2v6
         2XDQaFrWrwZz4NulU91GN1Jd3Xdz+FhHsmnFk1pYdLTjBrmCpLSBrww5d+S0bwDHuvjg
         uZGPPi4iLPuAgxbf9v+uIkMNOAEP1KnOXmlf47CZTkPnucWLoG+y3d5dt2BtDnjXAI6N
         BDcTTXO+yPggCDW2TwKYosXbqBXDFk3oUvO+S1pgBbr9uK1xLy3rsy+om2IjJaensppm
         ISxPLtMcAg8+i7CyWQkio35gqWYvh65Q/nkGHojXmGqgfrBDOld/yAu2GnNNrQFVYDCW
         dnwg==
X-Forwarded-Encrypted: i=1; AJvYcCXrw9BLO2BrCZh9sFF4BTW5SgG0Z5krreH/CqGocvkdFN8EBOp7xM6sQFE0tRg5mrgjOFlmyz0CZNsNSwnW@vger.kernel.org
X-Gm-Message-State: AOJu0YxYrjD5zv1aiEZb5dGQGir76F8LhLeTYDrVlUkhM+eiT0B1VWer
	VWMGcmu9m5GlpOfHBmD1X/NC/YblKeIQsyZL1IFeLzNqVzW0IpV5dFq1
X-Gm-Gg: AY/fxX4RdVnVp+I6ZzjKukBVlcnFwTgEmUNldWyBvx8DqnsKhyfbv6zSsRe+eH6qvsR
	RCeTa1W/WtCyzXXDVGEp2nU+I9s1e3E4L7NCw17hpWZayilWGHjyumN2241bYXyUDPJ5Jba6fpU
	m0yDktX35qDR/WU3rE5zaohYxZgcn/CHUW0UFBTZ6UMtbsZuRtOkmYPIhOGMn9m46Hx7hViuIeN
	zVnOGGrrOTVG8aE5a2JG+CPC05RZMCju3eQ3/5DuDi9ivomzwOuaySgFwaVsMi2e7OMgy1iwDLn
	dwiHNgiUOzf8fD8PPQC4LJ3/t+TWdlwjTtQHJIWhnetZfnCItf4QDVFJs5Q+HHd0juTqHOhckTR
	e8HFxqbFGoIhk4Rk6pojjrx0xAHsu17AKgAQXedk0bQGqRa/3cDMsMPNRp8dEQCpC7r3SqT2gXo
	3t3bjkgeL/WXJK3RYjMdqvVcqAiRPx4fbT3VNT/uE=
X-Google-Smtp-Source: AGHT+IESuNtdg7r6U8V3avyj/W74Bs7jNYRoapVQX/S1yMhl+s9xpYrFbDcjHGddBIRzo8KRQZaBBQ==
X-Received: by 2002:a05:6a21:328c:b0:342:fa5:8b20 with SMTP id adf61e73a8af0-3769f9332a1mr18035364637.30.1766594604796;
        Wed, 24 Dec 2025 08:43:24 -0800 (PST)
Received: from localhost.localdomain ([111.125.235.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c82a10sm159726745ad.26.2025.12.24.08.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 08:43:24 -0800 (PST)
From: Prithvi Tambewagh <activprithvi@gmail.com>
To: axboe@kernel.dk
Cc: io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	brauner@kernel.org,
	jack@suse.cz,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	Prithvi Tambewagh <activprithvi@gmail.com>,
	syzbot+00e61c43eb5e4740438f@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] io_uring: fix filename leak in __io_openat_prep()
Date: Wed, 24 Dec 2025 22:12:47 +0530
Message-Id: <20251224164247.103336-1-activprithvi@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__io_openat_prep() allocates a struct filename using getname(), but
it isn't freed in case the present file is installed in the fixed file
table and simultaneously, it has the flag O_CLOEXEC set in the
open->how.flags field.

This is an erroneous condition, since for a file installed in the fixed
file table, it won't be installed in the normal file table, due to which
the file cannot support close on exec. Earlier, the code just returned
-EINVAL error code for this condition, however, the memory allocated for
that struct filename wasn't freed, resulting in a memory leak.

Hence, the case of file being installed in the fixed file table as well
as having O_CLOEXEC flag in open->how.flags set, is adressed by using
putname() to release the memory allocated to the struct filename, then
setting the field open->filename to NULL, and after that, returning
-EINVAL.

Reported-by: syzbot+00e61c43eb5e4740438f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=00e61c43eb5e4740438f
Tested-by: syzbot+00e61c43eb5e4740438f@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Prithvi Tambewagh <activprithvi@gmail.com>
---
 io_uring/openclose.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/io_uring/openclose.c b/io_uring/openclose.c
index bfeb91b31bba..fc190a3d8112 100644
--- a/io_uring/openclose.c
+++ b/io_uring/openclose.c
@@ -75,8 +75,11 @@ static int __io_openat_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe
 	}
 
 	open->file_slot = READ_ONCE(sqe->file_index);
-	if (open->file_slot && (open->how.flags & O_CLOEXEC))
+	if (open->file_slot && (open->how.flags & O_CLOEXEC)) {
+		putname(open->filename);
+		open->filename = NULL;
 		return -EINVAL;
+	}
 
 	open->nofile = rlimit(RLIMIT_NOFILE);
 	req->flags |= REQ_F_NEED_CLEANUP;

base-commit: b927546677c876e26eba308550207c2ddf812a43
-- 
2.34.1


