Return-Path: <linux-fsdevel+bounces-54456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B15FAFFEBF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 12:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D7E958719C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 10:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D65C2D59F8;
	Thu, 10 Jul 2025 10:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+ZiI1Hb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85362D59F6
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 10:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752142119; cv=none; b=tDM6134yRzudVy710x8yr4r7R98j41me+E5sHTGRhLN4Q5/pKpHNTCz39f6PmAzjV9avC/F58jkTIYraoeutqRkkNc7gYSkJgjuRUyOxL44bk1ANRdiUu3Y7VVhRvKvEemxVQuw6AE6L8QyBDPxU20BgbbF7VlyXnZgTWZRyPNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752142119; c=relaxed/simple;
	bh=m+SrFe29Zr4ZRWseZFhSOg4azcr4ULUJzP1LUf8f6fg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JjzZLY7AfLzaP66utvqyd20ypHGc60/B4J9xem9khOoxV6rOF0O4MXBbgyQKsvyfAN91MPV5XSHyh5qlyqkXn9lrwQW4iognExBwh07YRiMoziuXpvwOfpKC+Hb1UNy3W44T2uUgyDgnp8ycOhFh2Jc0oxxmaZ8+bBEWaD4ROQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+ZiI1Hb; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae3c5f666bfso127258166b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 03:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752142114; x=1752746914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vNvRTYjK5BEYvNkySGuo2GuRaRuNFuPo1sBPw5iZWUw=;
        b=b+ZiI1HbPJ/1E7aKMv25ZJsGX/XVaxG+xCWJO7GD33qCLd4dgUjBWU2Dp53m6cbdT7
         tly2fru5AxxNmEenaxlibYxfaV6TP0kFK3yxMcfFnVTDjnxGkIqkIDno10y/jypS2m+H
         MaeXeAeJtT8Xvm5QYbMCBysYCFDtbKFl7281syeUorBAt9IS9UnJQ5hgY1MTw66NPEAo
         M/cGXh09PSFH1UwyUQcU3Dfoa1q9KG69hi57Te931MGL3BtQX+nhUA1Gkp9KHqkPad+k
         AbKkz43JoindzXzIBUNafYxeQdnH7i25QIq55LxEVxE/0irLSYa0uVPrAaj4Yw1CgTIT
         zSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752142114; x=1752746914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vNvRTYjK5BEYvNkySGuo2GuRaRuNFuPo1sBPw5iZWUw=;
        b=NiJtYXIpUHGoxKuSBQ6Nosu4274tPYGWOtAHrrBb1vYENC38SyKAJEpuWrVGj76Mfj
         NjEQTA1zbSLSDicehxPR3GvdA/6iOxFK4Q/xk/mEyC5Dp+hbqH+E2KIeWNcWlK9E3vM1
         1mu95MQG/k3ktSDY4pmbnvxg7pC6whGsZxH1UzZenuB9Qn8F0ZiI3wCfYwrtWdWMcKAt
         /oZ9o9+bxYElCrtGn49moPxmB/QxYe+squ7dcB3Z/Qlc5hPBp9gKTibj/2bpFjWeSoei
         w4sOjC2BkNjfwT1xyse22+/tInFPDMW4OOFmfJmkFtzSTldMGCir+W67dWpRJNtfa4Du
         nlYA==
X-Forwarded-Encrypted: i=1; AJvYcCUWVtzhXwUdlootJjWSRliQ89hhJG6mrnY5TKpOmHAaCGFs+PlRB34vk8XfgdVIQiBdb17NAlGAgYYQDcy7@vger.kernel.org
X-Gm-Message-State: AOJu0YxpMb70wW0D6TxYXAmywPvKASYs6DYRvZ2H0vPYbuK1E+DOPQJy
	Z4CFy5I2BB8q66H39CJXmWdCNuXjvMOFlHX0Bj26YzKDfpm2IpXP5FwJ
X-Gm-Gg: ASbGncs1qOhbUzrb4pRCzwJbxSg86nHektoiTOGFnvl/t5vugKIstNzg1JfqvEjVUIt
	Dvk50u46ghSign3ttqpLoF6QzDyjkEWZfZPw0x85Yg70iuZ+mq6nJg8AmvbJvDTKyBKpTy7/5wY
	YDjeg+hzXqyeRKbSwiq6Nq1Id7+EiP7IbKdnIe2bTE9T3ruJKvJStJIah3Z+GVaOzavwtKmQ4cA
	qusIwdBbcaGu1DaZmW9xN2nDL8sKs83MoAe0MEq2WSh9Cwh+qjPn1gHkzuuIcsPZTL2LttDjJAB
	VfHqbqWCz61zUsdnRogF+I8b6zbP+vL6HT6YUZb8SFYCqtNnGUPrl3OndnILxt+UrnSxN0zKNpN
	lXJaJrIHrnBc5QPeFf7DLsNNRl+nScaeP65bCug3qyhlGtZyc2wtd
X-Google-Smtp-Source: AGHT+IFyz0Q++z3i7eLH7FvoT3HZs0mOtatoV6pmW8i7/zaMU6WjQ/RSXKD3fE9E1TzYNOlgEQA9vg==
X-Received: by 2002:a17:907:7fa5:b0:ae0:b3be:f214 with SMTP id a640c23a62f3a-ae6cf58c662mr569143966b.9.1752142113685;
        Thu, 10 Jul 2025 03:08:33 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8294b7bsm104273466b.136.2025.07.10.03.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 03:08:33 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] fuse: do not allow mapping a non-regular backing file
Date: Thu, 10 Jul 2025 12:08:30 +0200
Message-ID: <20250710100830.595687-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We do not support passthrough operations other than read/write on
regular file, so allowing non-regular backing files makes no sense.

Fixes: efad7153bf93 ("fuse: allow O_PATH fd for FUSE_DEV_IOC_BACKING_OPEN")
Cc: <stable@vger.kernel.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Miklos,

While working on readdir passthrough, I realized that we accidentrly
allowed creating backing fds for non-regular files.
This needs to go to stable kernels IMO.

Thanks,
Amir.

 fs/fuse/passthrough.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index 607ef735ad4a..eb97ac009e75 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -237,6 +237,11 @@ int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
 	if (!file)
 		goto out;
 
+	/* read/write/splice/mmap passthrough only relevant for regular files */
+	res = d_is_dir(file->f_path.dentry) ? -EISDIR : -EINVAL;
+	if (!d_is_reg(file->f_path.dentry))
+		goto out_fput;
+
 	backing_sb = file_inode(file)->i_sb;
 	res = -ELOOP;
 	if (backing_sb->s_stack_depth >= fc->max_stack_depth)
-- 
2.43.0


