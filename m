Return-Path: <linux-fsdevel+bounces-41334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9257A2E014
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 19:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09B9A1884A76
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 18:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015BA1E3DEB;
	Sun,  9 Feb 2025 18:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWnIIGHo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8B01E3775;
	Sun,  9 Feb 2025 18:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739127343; cv=none; b=FOvzwebX8g2rxtVHm5kjVlY5IP/nSQ62jo8MKtEdkek+krrcIarbaMj/Q+JIUmkKXNfEaxqUZi0iBBU4aREfE7/XqOkjIPL1ZnsL3N5OHipANrAgqgS7/8PJUUpH7w3Of/tAVEn3b8R0pvNZTTAF2zeBQDgRzS0o1Wyz9FsWun8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739127343; c=relaxed/simple;
	bh=61udqkcEg9wcSq/halgc8JMmMFwwfrBUY4mtNHZNt8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcC6FXBOo5xRGAWFU+XVLd+tmpgkQtE0l9Sh9dsYFq9s+QWbVmtPZKWaAVimCQuJfoRSetpdspbVhzmdz9vTq74AMGEFGmIRqhaLiGfOnZLG7jU8RAdM6lpO6ct4/SeTh1q6EHseKmLXskcnBy7i5UcitxJU4eKztF4xCSi8BWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWnIIGHo; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab7c07e8b9bso39106666b.1;
        Sun, 09 Feb 2025 10:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739127340; x=1739732140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8Wgr0+Th/eZItEiexHX2VH44yFxgC7CrIHewPAPMnk=;
        b=fWnIIGHodDMiSmtg4RKubLpmTTRDM+zCHCH+7uFVTQpu227kcyPNLcwLyLGeeZMb5w
         XKlvJavrNjEaX+AOSmXTxYDjnlGn9NKzk+r8VCjy1XPguGmz+Oo0/JswORGVwPAig5F2
         NLk1Mh6JOVdLuHniIf40usO+WGs9gsnqTZs4AWM5kR+Hkk9s5FtUfG9350It5wdn12Nw
         ut58qd9QRkjYHFwb7jLYaWkrHdyYa9LbzJupDcOB5jKE58zGdHg3cvllPgYHOiQgQjjZ
         4jOLj7jkyz1MzBkoV1hbx/BSOXstvTU2qMxuiz8Hq7ZKbwXFDje5gNpz4e13QSows2Mq
         8Szg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739127340; x=1739732140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8Wgr0+Th/eZItEiexHX2VH44yFxgC7CrIHewPAPMnk=;
        b=fYMhr60QayftY51cclUKRbQUc3n4HMw8RaGhxa7HZj2Kd5lpkb5VjgALP1yHJeiAFE
         6WMdaPhFA82ePrwqpcRpjLpyJrHGEqPTVivYhyX8Ob7YjSlyL6l4yEb8GEDC4y8jzM8B
         cWV8L0nMjk0TeP0My3I+uq4FE3LOr3ljYru+cmWnHs/4noYRnQf2dGNJ0uPTEtwA3QtT
         y7mXdi5Wjq4T3YSUMM9wghwqfjznG7r9PIta+rsQUw7Q9NutBuNWdz5OpI8AsIZINSL0
         212CH144CdZyFHJxsisP5PH9s+vTve7omPsIRLbNt9o4St/ZOsdTPBqnxtuc+IOSZAUc
         y0vw==
X-Forwarded-Encrypted: i=1; AJvYcCVhAGMr2yDI7A7xmIPTfmypfinEZByTqOc0tDAR9igRHMlNVWH0vFS2fzg82ONOgrkDSRJe9lx606aXJ5oz@vger.kernel.org, AJvYcCWJvsgJuh/bmbJDlDBcEE2XMZMOCqO3n6OxABaU+u3kjF76SFGkWdQBl0aFF43eI49BhpLsUVNEdSk9JQuy@vger.kernel.org
X-Gm-Message-State: AOJu0YwQbt5H5P5zu0PiZOu97sDQikNxsI6NR/+aG9VT87FoOtrMrTz2
	m2Uaa50xiH6d6Ywb5bZcUca8UPHAWaw7yPGob1qlp3cmRjip5TqY
X-Gm-Gg: ASbGncsECcFHJTSzsuoD8kBKaBYWMPVCPd9t4klEYbsGdzHuoS8hhPTle0s/INNii9h
	oBcqzn1Zd70MCmX2gWk5S4Av3ZeroDjLTPgloJISqdXghisUtw9N5yR1gmaukqUSkvrnPEaL6yP
	EZVNKBg+ZP9Gk6Gaxssm7/hCbNOXayOMTY6WUCoohZrVgyUz1iTPeBufneeHGrB6+ZMobD197/z
	oWs2o6CQ7QGQbPGAPEdxvSKA3OGuWetN89v8yLw0Lq0xQVTVpBfIu+/qUj1DMltCRoZSt0YnsK3
	EZ5SJxkMhx1OZ+P9WE7rPViP/lUr6dUWQw==
X-Google-Smtp-Source: AGHT+IFRwO1qrAyYzxDW0kmOstWFYA6/jMcMo+ErrpykpQ5fdyvPNQaobkhgkCSDdH0JDq9yBx/2Dw==
X-Received: by 2002:a17:907:7faa:b0:ab6:fea0:5f14 with SMTP id a640c23a62f3a-ab789ada0e4mr1126946266b.16.1739127339955;
        Sun, 09 Feb 2025 10:55:39 -0800 (PST)
Received: from f.. (cst-prg-84-201.cust.vodafone.cz. [46.135.84.201])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7a82dba37sm318478566b.165.2025.02.09.10.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 10:55:39 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v4 3/3] vfs: use the new debug macros in inode_set_cached_link()
Date: Sun,  9 Feb 2025 19:55:22 +0100
Message-ID: <20250209185523.745956-4-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209185523.745956-1-mjguzik@gmail.com>
References: <20250209185523.745956-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/fs.h | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 034745af9702..e71d58c7f59c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -792,19 +792,8 @@ struct inode {
 
 static inline void inode_set_cached_link(struct inode *inode, char *link, int linklen)
 {
-	int testlen;
-
-	/*
-	 * TODO: patch it into a debug-only check if relevant macros show up.
-	 * In the meantime, since we are suffering strlen even on production kernels
-	 * to find the right length, do a fixup if the wrong value got passed.
-	 */
-	testlen = strlen(link);
-	if (testlen != linklen) {
-		WARN_ONCE(1, "bad length passed for symlink [%s] (got %d, expected %d)",
-			  link, linklen, testlen);
-		linklen = testlen;
-	}
+	VFS_WARN_ON_INODE(strlen(link) != linklen, inode);
+	VFS_WARN_ON_INODE(inode->i_opflags & IOP_CACHED_LINK, inode);
 	inode->i_link = link;
 	inode->i_linklen = linklen;
 	inode->i_opflags |= IOP_CACHED_LINK;
-- 
2.43.0


