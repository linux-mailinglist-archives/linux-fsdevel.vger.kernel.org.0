Return-Path: <linux-fsdevel+bounces-59273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70087B36EA0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 439CA1BC073A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B562FD1D6;
	Tue, 26 Aug 2025 15:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="uGC5UlYj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEE436C07B
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222908; cv=none; b=ccD/HpMulMMzN5BtX6EqXMf2sAU6+TQrvbk+tvF+NlxIlpNmq4bXtwQUuliTW88o2gbRWXbnjJBAZSBTpsBz8iqyM3pnYrOw23Fh5C5Js3bedp/oA4KmORWsfzEhERWxS13lcyEDQKVcX8Nev/ce4LfAk5DR7fUphM0n4nfdSBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222908; c=relaxed/simple;
	bh=GaKmvGab+0a2RrIuxhv8XqHzko9SenWylGMpW6UIOW4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yr/VPuPDCJMKohGDIntppHEvUchwtVx6wqEAI/bPoIVik/EH/sAFAk8TWB2M7RquqoqIcb9aFCl9TO7g7+vOpzLWKd74AdpH5DdQvPRplbFOOXhGbRFbDLhn9RDUPbDK0uX9OYQzlVHXXSFu5P8buuA171QOD8sy0EFPrkCZZAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=uGC5UlYj; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e931c858dbbso4584490276.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 08:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222906; x=1756827706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WTOjoTpV6m7hLv/F0NHjQx0Ply5AcqoXgmnK8+LDP5A=;
        b=uGC5UlYjbB6rOseH9rP9MBsmDrcW30L2b2JfgIYz8Eyj3xR/rQwJmfyyU66fGoMvZd
         YIn1TRYIdFSV0VIFkfvJv0Y5xYinUBAW72kL9idKUi+wb0zTYCBo08c3pOGQrl3SHnH9
         vxnF5uYsccZbcvX9GNwpv0/djWeDtHVRSa5Rz3Uu5EFHcpmCsexCUXNdQWgH+hTiw2kj
         VGL2vVIQfEfXhMWUQAVfWEBK1kyEfBiNFS6a4c1WOmK2x/Zw3eXkvzoZrOe8uhHAs5td
         Hh0qDI46iRuFdj4JGFQTJ4/oAy2+e21u+KIat1IEqO+Z6mbnDl7hhYAeweAmG3iwJoz1
         Qv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222906; x=1756827706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WTOjoTpV6m7hLv/F0NHjQx0Ply5AcqoXgmnK8+LDP5A=;
        b=Hc25SX+1fJWwNVnx9Ccx+DmTLm6qkMKpWdoZFc/nN3sgU503XIBMFnuJhUF1isK8Ro
         OhXMltqzr6jJzvrb4qLCmZhYAlaroU8L2gss/o9uIVi7UETFZGn/mXBGNWN0AFEZ203a
         I/oDHvIg4RVg5hW+BOPm26UKPuzU8tkfPqpDs1G0J6m+zhGhBFnZpxR0dejdw0EyFhR4
         VwAYzAHk4mbLMV2fO1k74/5PDRUx96HPQsueaOTuNjsKgF0hWjAPN2yNl79/p+wVQgdJ
         8FuklVTx1LIIGVpVOx+9RPvP818pKQL25VaOJeK5LmddzWtGyz1nZMYYeaI/Na6e+bfk
         X1JQ==
X-Gm-Message-State: AOJu0Yy0yDomoEdFp8f6glbN5yVZfThb57kd9uv5c+p2E56PgBuH0khy
	Y676pqN5eOYIS3hINdNWCWgtqFsB4ciAqxvPuIYM+Cpy3prsgg/VPGwVE7McXHIzNDGTo6HqdA+
	YiunS
X-Gm-Gg: ASbGncvWdxHOi6UfOLw2lzOVsG+dJpFZwBXWkv38bjrAkuG7APDSodUFNhN0/7px1Yp
	5OK4iIw0Gyd7Wvg8iKPdO8fy2Npt2fhbF94mQvRKlFFj06jPmNjfs+k90X/XsWYN/Zk7PJfA9jQ
	wdEfC0388sQYwOXS1pQQ0NJbAkoLMu3tSEUFdvIzKmlA9dXpgiScf1RfL9ImAk9HYkU5r9ils5s
	EOCQywNfq2eKNtRuee0dFQTotQgEOcXpFi5nqKk3I9U7GLZiG8scOW3gSsOXHM7ZePcSBiPbNib
	JtI+A1ooF6nYRdNC+wcmogvrpCWgGB7IYMfQof955cL289ktkUDqPiCbcH8DX5lkEZw0u3zvv4j
	LQRxMmRpG3mLS7FBmWDmUukf6K249QMD2eelYSWHo/fuTl0sqeS2JfsEMKGkyhelP8iOn+g==
X-Google-Smtp-Source: AGHT+IFjze0r20/WCdIbB5fda9LnJE1jWaThHGsQzBCPZUwgD9yRzYM9e2CgIgaMhoLiVnPc0UCoRA==
X-Received: by 2002:a05:6902:150a:b0:e95:3e67:90de with SMTP id 3f1490d57ef6-e953e6797fdmr9650941276.27.1756222905943;
        Tue, 26 Aug 2025 08:41:45 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e96eb3c35cdsm121586276.11.2025.08.26.08.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:45 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 39/54] fs: remove I_WILL_FREE|I_FREEING check from dquot.c
Date: Tue, 26 Aug 2025 11:39:39 -0400
Message-ID: <e2c8fe9fa28fb6e52d0e47e38d2ef93c9527b84f.1756222465.git.josef@toxicpanda.com>
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

We can use the reference count to see if the inode is live.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/quota/dquot.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index df4a9b348769..90e69653c261 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1030,14 +1030,16 @@ static int add_dquot_ref(struct super_block *sb, int type)
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		spin_lock(&inode->i_lock);
-		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) ||
+		if ((inode->i_state & I_NEW) ||
 		    !atomic_read(&inode->i_writecount) ||
 		    !dqinit_needed(inode, type)) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-		__iget(inode);
 		spin_unlock(&inode->i_lock);
+
+		if (!igrab(inode))
+			continue;
 		spin_unlock(&sb->s_inode_list_lock);
 
 #ifdef CONFIG_QUOTA_DEBUG
-- 
2.49.0


