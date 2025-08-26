Return-Path: <linux-fsdevel+bounces-59281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44775B36ED7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE3F74656CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A111E3728B6;
	Tue, 26 Aug 2025 15:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="krFGrNjK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EC9371EB8
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222921; cv=none; b=HZ6xM7O1StAT+2W3RAQy6//KcZOq+E8KOESbSLR8S+3lbWTCwDN7MUQWiJg90NHBg8qm5Jh0yp5DZ7S7wWjrUt88YMHInuNWhG5KVkP1/eQkpfVuqFxF049aRkC8tYH6ocjuURod1nB2qS04aqhQulGoYPAoN43Ug6zVbv3GYgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222921; c=relaxed/simple;
	bh=AyaIgaj6Jud8JERDUR0C4MqVOxuTwvj6iC1ttg70Qqo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mMMC/Okf817Rjp/1AtKVxjqB2XlE1vzjAbvtUmYTQpOkVjcpLUVfBBWYu4ySPuSG8EG6AnpYaCiACt1g0+XwsArNT+Qrx2hOH5ZgGqqROfAf1m+e8Qtr4PcvziEZbjYcC4GU7iaQ7BBGqiMNIvTkPpyAtFjmAypieeBy1rn+xs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=krFGrNjK; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-71d6051afbfso47596347b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 08:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222918; x=1756827718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xVq4Dudny0hs/Tg3SlCX7d6XKt3AfTMDJTBRxWNfvY0=;
        b=krFGrNjKM96R1p83X+oky4JLk2HFtPk+A8wMnnPefNfgzgmLK1KsUYQ05LdDwTjCGi
         ySQ/JOfyr+l8gXbljhhPr4cBIKcmh1lUOceV+UD2cCglX6KjOCO8AaDl97HLP1fjEdVk
         wO4BbBwfT9NSA6n4L8s0NzUjQuUEgV6Frr4SD8jLbIJ/gwj3olWfX4kY9ZvChT0zI5BA
         sNJeidPgJ4WdH7N21w3zUOmlh6a1Z7/v93WA8aRJK3LoXECzYR3SDknZYLp5rxGp9SPd
         srbz+OcP8CitgIZCu4CTJLaq01fG6al4BDbbBtXLv6ZIHmATERoVNeJLbRlpdosdGVD6
         7xIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222918; x=1756827718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVq4Dudny0hs/Tg3SlCX7d6XKt3AfTMDJTBRxWNfvY0=;
        b=Jp3FbpY/Ny/NcX8eo6WJPw9mXpUF6ZxWnjZpyPfK/Kx+vkfBdhqVVh4oqk+snu09fE
         D+6I3456vWzNirXBsHn6pEZLb9NVwgBHDq6b31AoHotCILrpb0n/MrcUn78Q34wiXZL/
         M3JwtuvKWIuvZ8KW/hbbE+gip4+NYDRxNho+Hul2KXoO+lN4m07h3VCXLCtoh+x732j9
         b3nvkxKLkfQIrp5ADAaOLWHnS9Q0KUnOi1YDmmhZJkkb2nNCD127hNW1cWkti79Q6lhE
         495YPU88AfdYR6RM6OMvIcvQ+iVWFt1lBZdRcgBcZ6gH02Ol9UGOwnNV343l5dGtljSu
         9qZQ==
X-Gm-Message-State: AOJu0Yx4VNEJohHsDWmXpfxoKmzWgbRKThTuDwrJ1D0tWvhAF3kKdW/O
	4mYv03tv9C2KW9Sn4qhQJWVla7QeXdtagjxoVMuf84X0X8wCdqS4Th4pdJg56kv876AtFMZwPRw
	wy/K+
X-Gm-Gg: ASbGnctjGHeFugqIsxwyj25INw2xw1R5G3GFEYdASO5NIhSGHx6we1ArVIMYbXnwo11
	k5ckl0o10XJbMSl+aUgLvWlO0KJ1D6/8B8buy+hX3ShWsZx24PnTfSU97FJRhEvCUs53typv9jN
	liyyQxgv+uLGjAjThrQBlMnC1ZfrWgS8REmMW4YSho6E7Psfl+n1lfG7jzK+ZhX7aanmpEvbeW1
	aXJjmiDhIAzB69AxJ0RspkK/IZfaUqLh2zHP+3Qe8Wgxk/4cFBUpseRR3DmpPZFCoB1K004buCy
	jCbje6LUfvnJbTvw4uocZByYvLc4F+zq3neXEfTMg6QuDRWOrTVLhC4zHhM09mgVVwqQ11E7NkD
	TE72sxDWH7ru1Q9rrzNv9Y9gVN/NuwDtpaLcHuOPCsHK2+0Mih6vUsWFdlVf66/mIkWejTPmm/D
	qLQhR4
X-Google-Smtp-Source: AGHT+IHLsg04WEluK1oVuZpp+6T+vzscvTqme64BMq5PmNGW6Hbr2OoPh7UrrVnEqIvcPfOFGZSMjw==
X-Received: by 2002:a05:690c:3507:b0:719:f7ed:3211 with SMTP id 00721157ae682-71fdc2b0312mr166349697b3.7.1756222917584;
        Tue, 26 Aug 2025 08:41:57 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff17339fdsm25186297b3.21.2025.08.26.08.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:56 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 47/54] pnfs: use i_count refcount to determine if the inode is going away
Date: Tue, 26 Aug 2025 11:39:47 -0400
Message-ID: <1d54ccfdd1e49bdb270e1cf1f6482b809f037d73.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the I_FREEING and I_CLEAR check in PNFS and replace it with a
i_count reference check, which will indicate that the inode is going
away.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/nfs/pnfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index a3135b5af7ee..e400e3334c75 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -317,7 +317,7 @@ pnfs_put_layout_hdr(struct pnfs_layout_hdr *lo)
 			WARN_ONCE(1, "NFS: BUG unfreed layout segments.\n");
 		pnfs_detach_layout_hdr(lo);
 		/* Notify pnfs_destroy_layout_final() that we're done */
-		if (inode->i_state & (I_FREEING | I_CLEAR))
+		if (icount_read(inode) == 0)
 			wake_up_var_locked(lo, &inode->i_lock);
 		spin_unlock(&inode->i_lock);
 		pnfs_free_layout_hdr(lo);
-- 
2.49.0


