Return-Path: <linux-fsdevel+bounces-73386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 531F7D1757E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 09:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D326305969C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 08:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B8E3803C3;
	Tue, 13 Jan 2026 08:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKGWchcl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C37237FF73
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 08:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768293646; cv=none; b=B70jwCwlWFz+z9vJg5oHvd3ffTtCyh8wvjfYMU1SBN/dKFPAdUk/4DRg6yiSgYh7OGUs6FMoZEp+n1fZkPCYJYLH4APRWGmVWjVzAvuwEhriFec7wwEayeahflMQjGbLkdZL7HhRZc93FUkv/W19oY4AygKTRbcjCq3STWAJYqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768293646; c=relaxed/simple;
	bh=qAXALiQee5PCgMuNzP+8+20gJry/3cCV7fbUKuyAqEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CDzDcPiyG6LD5zYeqyUv+Eex+mbBfB2QsOGc+fPdcoUYQIp9vAXS4dGPpfesXiceJ5qKdyNLe3+y5ssqIjI27yWayNMFh1n1XrxMQ6rmgmCOVXNaC77bh0kuV8P4dYIYN24D+4nVIIIfoQVTEPB8QEoSHylxoBqC66/wgTryZD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKGWchcl; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a0833b5aeeso72458835ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 00:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768293645; x=1768898445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8K90V/NjSUkaMdQnNoKszy21agLb8qh2JCner4OZGeY=;
        b=HKGWchclYX6gXzSbHmjaOq2cGO93tjnlUT5H8UOqxbkX4daiaWIdzHMvHBJ4l+qFAv
         LONfNBfyBQL+V+htLmq/uHQLa/nykeUWkae2GOK02zdq6XARCMEmF5ew+QyvErx48fFk
         1cbFAcecBsyhUvN+jnMPyRcpUXOTPtpzuGt6VyV8+GVfpW0jN7bi7UeARpG17OxVbqeW
         vLpVUnWfy2gF6irDsh2JzXXMLYrRJNaUXOYKURrfvYifUh6nyA1fqSUPLYwmk4wGk4rL
         wu/TrAlwHIKPpVllk2XLP4vZc/4eauC0D6ULm+22NWn4vmIcb/YaWZJMUYaEd5RyA5da
         8X9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768293645; x=1768898445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8K90V/NjSUkaMdQnNoKszy21agLb8qh2JCner4OZGeY=;
        b=n3x6STOpbx64LUegZk/2Q11iCY3ZoIOwpXBuEstXWES/SkSDd3n7WPHPBPSFDsEQpb
         YrvtBwGZhJeouYSA1x2HFi3yuRyYwiq8nK1DPT7g9+j0lJWVzH0iqwKzzSPzM2z0dwXW
         /wU6gcikYWUC9DmXFGbcCWAT/dpboCxn0+9MVrF20Hwg7M3Emr4l4kDrqdP+9FKV+TXD
         QUBApCBZTgTQ2CjyvyRnN+3uZ5vonkyqzJKH3bgxRzIcnN7KWg+snmL2pCD+O1l7TPEe
         einvT/H2UJ0dkH+rzwokiYJ8S43OIHJA30+ymNkLCGLvDJ/uoHHoRRhHonlpoBCHKLus
         WCVg==
X-Forwarded-Encrypted: i=1; AJvYcCX2mYFKUzcD/NgLQsK9H5CGHbZgFFGG4TPnreW2/W7QN4igxI15KFiTCLJlnz/tJWJpcWL6Eg4TCfxOxQWV@vger.kernel.org
X-Gm-Message-State: AOJu0YyOGaZZTfiqO0pIEbOq6iUKLBCu15C8SwpP3IBF+2CGc1mHgthZ
	1UZb22Bdd6Oe4En32wB9Ih88qR7xdPtzliWe/ZIEBq2upLgldxiQl4ba
X-Gm-Gg: AY/fxX72cMbuoGGfEZuq2i2VQ5f3dKVys80uvXAtlr06MSr+pWR4VX0vaXGyzLpx5nG
	ZbXeaiBDeCVDX8vfKMgCtHJKj/UJI22eTa8lAdbOWtKm1tYqx+/ePiGp2wYBNj+ZfZkR72zErDM
	ISuZgVkixotu+7vlQ4X2aZwpIwlzM0iQX1C5d5EEWQAItnowdr4NS8cawqOrmZ0UXBc9XdNu903
	hD9L8LWWaTY/QU+M7pPJUhkdSyvFqgz3heu6uAp9ZQvUvOUo2V4G6fmqtI5WdWKVuftUCgZ97pi
	1E8ZQRRAQgcHTRm44Dfx9NcfjPp1RewTnQpgKv+CqkKCM3ObuAcsN+rcjoRmalVmuqpH2j12pHw
	eRbNPpM5t19a6MYZeNgZiQcRKYd7DSxbSYVocOztVKNLKQZeWdqqlxlFw6HJCLdzkykhvvYn4cA
	ST8rn/1vK/0h9dmbkcKyxJ9+owUmkECqda7kNPZbkXsoWXpMiJ8DVNooWCbdqCUGXWRA==
X-Google-Smtp-Source: AGHT+IFdpgs5640oxrSHO5tQCC9VUL15DPy01h6peWIsoftQPRogijIN3S2FN1QGBF2IIgP5oMjOGQ==
X-Received: by 2002:a17:902:d60e:b0:2a0:ed13:398e with SMTP id d9443c01a7336-2a3ee4b22f0mr185826665ad.49.1768293644784;
        Tue, 13 Jan 2026 00:40:44 -0800 (PST)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:2365:8a49:f4ff:aeb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c48dc1sm191795945ad.40.2026.01.13.00.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 00:40:44 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: brauner@kernel.org,
	viro@zeniv.linux.org.uk
Cc: mjguzik@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+9c4e33e12283d9437c25@syzkaller.appspotmail.com
Subject: [PATCH] romfs: check sb_set_blocksize() return value
Date: Tue, 13 Jan 2026 14:10:37 +0530
Message-ID: <20260113084037.1167887-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

romfs_fill_super() ignores the return value of sb_set_blocksize(), which
can fail if the requested block size is incompatible with the block
device's configuration.

This can be triggered by setting a loop device's block size larger than
PAGE_SIZE using ioctl(LOOP_SET_BLOCK_SIZE, 32768), then mounting a romfs
filesystem on that device.

When sb_set_blocksize(sb, ROMBSIZE) is called with ROMBSIZE=4096 but the
device has logical_block_size=32768, bdev_validate_blocksize() fails
because the requested size is smaller than the device's logical block
size. sb_set_blocksize() returns 0 (failure), but romfs ignores this and
continues mounting.

The superblock's block size remains at the device's logical block size
(32768). Later, when sb_bread() attempts I/O with this oversized block
size, it triggers a kernel BUG in folio_set_bh():

    kernel BUG at fs/buffer.c:1582!
    BUG_ON(size > PAGE_SIZE);

Fix by checking the return value of sb_set_blocksize() and failing the
mount with -EINVAL if it returns 0.

Reported-by: syzbot+9c4e33e12283d9437c25@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9c4e33e12283d9437c25
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/romfs/super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index 360b00854115..ac55193bf398 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -458,7 +458,10 @@ static int romfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 #ifdef CONFIG_BLOCK
 	if (!sb->s_mtd) {
-		sb_set_blocksize(sb, ROMBSIZE);
+		if (!sb_set_blocksize(sb, ROMBSIZE)) {
+			errorf(fc, "romfs: unable to set blocksize\n");
+			return -EINVAL;
+		}
 	} else {
 		sb->s_blocksize = ROMBSIZE;
 		sb->s_blocksize_bits = blksize_bits(ROMBSIZE);
-- 
2.43.0


