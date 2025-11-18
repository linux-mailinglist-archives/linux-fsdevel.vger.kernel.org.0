Return-Path: <linux-fsdevel+bounces-68904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 06800C68047
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 08:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5693338330C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 07:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEC6285041;
	Tue, 18 Nov 2025 07:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4su/OUH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDF3302CB0
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 07:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763451229; cv=none; b=n3YK+du/laZLIdVkOpn0BXC3CpHRs4YpLmxkEeXjE34MLPt5x7UM8U4tTohnEbCuOVKS2P1iXngk8bLTBBDu/jdKXdwfSzILaPIEBvDHP7pPTDwsnZ+CWaR9GOV0XYODlxrh3gWDjdBge+Rd0d74cBqtZ521rDiwCnG1/dFljWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763451229; c=relaxed/simple;
	bh=vkJoHPwUOiA1y+t+xFAUd+VYtBowksslpmiRUNve3nM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=drkEVWvz0cgl8Sj54ZK3jXcbLqJTJ8zigksic9G9rce8/rgcZXHbXoD2Cew3n3V5PUFHucXr3ri+a3xPGY7pnFqiHQCSHG63qnoPEQuRoNp/OLRbCrQD4PUXHsFOt/Z6KPJWWORWMokZ8S6bI+AdmLfe4bY2e4+pktQd+0kS56c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4su/OUH; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34361025290so3918677a91.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 23:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763451227; x=1764056027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/11oJc7pkxq+ZLI3C2eIn2iwTR/gnHtRsFCFVhXFqk4=;
        b=Q4su/OUHOVg68pDlIcdE1e0pfUPtcxNPasbUVuhcXHAe/R5chDryiYgJzqfhUjJIiM
         jP3PriB89uCKxMkSZKw7LFXURm6n1MgFksmBhS1EJNVxmYbaxQEWRe2RwNb4xQ+giP42
         mIEI4Qq50nAkdEXke+OEk/JYCfX0L3kHRfDD/EuMSCdvU/+humkN77Bg5NRqgf1nkYz1
         HglwJI/Y+E8DscMmshh8nZxPUnKAHhBjVl5N7k3hQGl5MhwekJmypbgCH4gjEimYeD89
         YjOUuvv7sfXats5YTyVxsQQtqm4mEzSdGjZKR0BJMFhY9A5kPQpc5838RYXW1et3yD0D
         ZA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763451227; x=1764056027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/11oJc7pkxq+ZLI3C2eIn2iwTR/gnHtRsFCFVhXFqk4=;
        b=wgFin5kQp+n7Hw88n2uhCYRJ+KE6rxhjNSRCbo5Iv+W7jFfTQAlv/YwIeaY1pg1H4H
         7/zthz3pfr51FTxMitVdPy85L26NRlfCvFODwmvyjg5HI1D4F6l4yKAvR0FToHyLTNvs
         i8soIbAjkuXcgZXbhke0Aobni3kgjW4Mgrv/l2IcKUMf5D3osEmOV5107S3H+twK+QiT
         NDWE2LrdrRriGjU5rc+O1nqZvrEDDn4fVpbPBx95Wz+b/BxDCpH9I789JCFa8QHmFyYn
         7lVfPPtnV7o6pFIU65zHBg1sTLmC7FWqUPHQsJBk0Ft9rec7cQz7A2DnD8BqBB2Uo/NU
         27Yg==
X-Gm-Message-State: AOJu0YxAFyjl3kiC/Vzr38S2izX6A9oWIT7s1jtcvSyh4lRUc3XVCZo3
	SGYngaq8FZabfm1gDjuTrqNI+1BRppsaSQgZVn+mQz4jViyLUTgq0ld9
X-Gm-Gg: ASbGnctak0DgCVJmRzdy+pR2XpF0t1KFWXXqQ4t2qxE7/O1NDZ+GSY9xeUj4LYXQcA3
	Piu/L7ZOKSS0SnyfiQVAFUuAIViPBDQjl8jdHQxydsKXSWb7dIMYvvfW1BIElxtAitEr3yuJf/J
	2XhAWFKfVtLWssX4UTWJPYEd23M2sti3K0aDOLy+IVJw1MXuEseRqyELk9dat2+Zca07D4se5rp
	vveRlqoYYF8SQ/ifh6/DWUQ7AyxZV/cWUqgA1+KIU5LQj39an8JmXZjgfzxlQ7cYGB0Qwj8fHyq
	BK+zTuCJiwhdnle9IhN6KCvMc2QE7N+vGdyKsRQZrpWQyOa9i63B9Y6J+uroDlRt18qxteGw6C2
	M/UtyHe9426NBX4yKfNJXfXo+uW936nXo1d/gihNCmwWBtG1VtKWwYq3D5l2rOXKZjJKmerpJpq
	RGkAs=
X-Google-Smtp-Source: AGHT+IG2DuA6A51YRHTtEjGoz9S7FizPgzZO/BFJBvhxPpxgRwGstHsS1U+/5Q6IRcq7f3WAvllNIg==
X-Received: by 2002:a17:90b:1a86:b0:343:7714:4cab with SMTP id 98e67ed59e1d1-343fa52559cmr15801614a91.22.1763451226526;
        Mon, 17 Nov 2025 23:33:46 -0800 (PST)
Received: from 84acb1020363.. ([115.25.44.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345b053038fsm623686a91.14.2025.11.17.23.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 23:33:46 -0800 (PST)
From: Jiaming Zhang <r772577952@gmail.com>
To: linkinjeon@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	r772577952@gmail.com,
	sj1557.seo@samsung.com,
	syzkaller@googlegroups.com,
	yuezhang.mo@sony.com
Subject: [PATCH 1/1] exfat: fix divide error in exfat_allocate_bitmap()
Date: Tue, 18 Nov 2025 15:33:38 +0800
Message-Id: <20251118073338.576334-2-r772577952@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251118073338.576334-1-r772577952@gmail.com>
References: <CAKYAXd-eqH0HW_=bvTBx+ETtLO505ELRNMcjnUtFgq4waAMEVQ@mail.gmail.com>
 <20251118073338.576334-1-r772577952@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable max_ra_count in exfat_allocate_bitmap() can be 0, leading
to a divide-by-zero error in the modulo operation (i % max_ra_count)
inside the loop. Avoid this by adding a check for max_ra_count before
performing the modulo operation.

Fixes: 9fd688678dd8
Closes: https://lore.kernel.org/lkml/CANypQFb0NeToJrTY5PQi57K_440xQJ1uUS2pMOKqLsqTdEGbRw@mail.gmail.com/
Suggested-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
---
 fs/exfat/balloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c
index 2d2d510f2372..0b6466b3490a 100644
--- a/fs/exfat/balloc.c
+++ b/fs/exfat/balloc.c
@@ -106,7 +106,7 @@ static int exfat_allocate_bitmap(struct super_block *sb,
 		(PAGE_SHIFT - sb->s_blocksize_bits);
 	for (i = 0; i < sbi->map_sectors; i++) {
 		/* Trigger the next readahead in advance. */
-		if (0 == (i % max_ra_count)) {
+		if (max_ra_count && 0 == (i % max_ra_count)) {
 			blk_start_plug(&plug);
 			for (j = i; j < min(max_ra_count, sbi->map_sectors - i) + i; j++)
 				sb_breadahead(sb, sector + j);
-- 
2.34.1


