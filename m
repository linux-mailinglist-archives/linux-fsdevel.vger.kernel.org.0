Return-Path: <linux-fsdevel+bounces-48518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B72AB04F6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 22:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B5F37BA800
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 20:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1561C21FF28;
	Thu,  8 May 2025 20:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMx7ia6y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0C54B1E72;
	Thu,  8 May 2025 20:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746737470; cv=none; b=hwJClmkqOrtiYA97eX6xfvlaWMjOkMfi5JMEqA7i+5VGJcGdkBAWokwtAN0rfXHjQMyqFyljdERyc3tLN+MG+YEUJf5x2asSQXHQ4ZnPPN8LSiNigub7oRj1hiRDdl1iTTnXQ16Vg/OL/WRy+3kVV80DQ8BLm8RLoiwfv+dQQTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746737470; c=relaxed/simple;
	bh=QVm0uyNSO/VFxj94+JRLwKO2G6Pwo2JivogFQEdGsmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j9oXAyqsd99jeZeo/GtBfYE0XSTU4fnw4Nqqz35sw3kqrYSVkQCTyvIh6BPFNpj5jlon7kENhu/TnyHGv7nMYPixp1UgfcpuklshQ5Ys6p8vqwMRTDBD1x+nMucbP37olfr1pJork1pvwposiyBbLAqaemZG+j0PsFZwZCz/Dfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMx7ia6y; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7376dd56f8fso2079164b3a.2;
        Thu, 08 May 2025 13:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746737468; x=1747342268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rlh3y4pOW5NNlyq2ZzC8Dny/eY2TOnuloEOE1GZr1C4=;
        b=nMx7ia6ycLEd/uxJgDYkcei2E1RTEmf6YOp8Jn4GYFaHIkjw1/p5D7hVtHXlRAGupl
         abbCxbooa1REuExq1NrcispW9Psa6cdvSqBCLrQWwuVzMcc7pYjrYOBDXrpUvFttvR9Y
         b+DZPTVUhA5GTHVQSgo10PNZy1GF0TVTN2nxi8r53YkaKEJVO7zV0B3GvY//jgTkTb5n
         AnU3b4TvA/1i8mvm7NH1U4jeXUpHgWiva/Chi/ruvPfrlrbliXGDh2u4lxAsFS1pknyE
         4Vtu0akfe72Y2J4oaGhmPjOiIfvraWElkuUU7f2L+pD6hvRO2P+Vo7L3yByUhjCI2Ev1
         pz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746737468; x=1747342268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rlh3y4pOW5NNlyq2ZzC8Dny/eY2TOnuloEOE1GZr1C4=;
        b=cHc8z+RYwE+xOKUT9lbiEdWOL+pwpAS0V4MGoIMzIjzLaMrRK13rSSSPkfKfvCXAY+
         /kYSDo/hR/l9lFhkLFwf5RA0SaaC/GmsN7Ih9lcgVbTqVE0j9OaKPfXF8ROvb42WVcQ2
         5t6e0MdqkgoOqhPNYx8xYAN19oEGos+oS3cCQxNk3+PsYTJsYdJ7WD0hYelPzISxE6yt
         JzQRuo2DtRGtqCJWSlpQNIVNf9oIOzxjpFzyS2QQN0gTdEuP3TzMSzBByx7nU8p5evCl
         itpQe1iDyCinGKWKkijvOp3kZNJnxgSJ+xwNYYR4U2BJYuW7X7eb5vI2icmLIaDmM0XK
         Klfg==
X-Forwarded-Encrypted: i=1; AJvYcCUrsG7TMTfstcnRJ6bOklrYUKG/YTIQOh4+1DHahgVU5VofKaRdKQDuSjAu5RUfhJgpBp6lIlBsHUN3z7Gv@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5oEdT9I/mHtxRpS4vYVYKzf6OegMFhzojfU1QfPmTUzg/yLMR
	cHRdbuLRst5E+VUJc9+lHPdN7A+Pz3oJQ3FqTrKk8CVgYDhzI1jZPxHDtQ==
X-Gm-Gg: ASbGncvDyTUAaXsYmeYq390xE6phyksk0aPBZKB0OuxjPjdvZIAbciZYHFbpJBKCteo
	7kFJlccu1GW6BWniQShlFic0sgcSyH3hnvwSvqeb2sErbCwzng67GeLRgumr45pJ4UAHZsQePvD
	/TAhKb7jFUINb+YyyuMpCkt9Al0tPuip7nNHEfVSRDC4O5LL1fCTNz2rvfeu2wf9B6YF1BB6Kf+
	YQBMJZEU+esIuXlMCv9zri0CxIn9c1scboI1OIjmGrNO4Pm4kb1RMdzj5vD+x4eQUL3MkbTg6Rb
	QEDbJnk15uD1+h3q501GXzKfrwAXv5WkQusyc3MU3DUVJ5k=
X-Google-Smtp-Source: AGHT+IEbQ9K8dieiMW+yInkZ4IadlvdAYu7C3khoe5NQMXstd92UkTYxKSkrMVxk+hHCt+rYIiKlwA==
X-Received: by 2002:a05:6a00:b88:b0:736:6202:3530 with SMTP id d2e1a72fcca58-7423c0214c3mr998689b3a.22.1746737467753;
        Thu, 08 May 2025 13:51:07 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a97de2sm463763b3a.175.2025.05.08.13.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 13:51:07 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	John Garry <john.g.garry@oracle.com>,
	djwong@kernel.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v3 2/7] ext4: Check if inode uses extents in ext4_inode_can_atomic_write()
Date: Fri,  9 May 2025 02:20:32 +0530
Message-ID: <f6592ee7a4fc862d19806e4ab9e4a4ea316c4f9b.1746734745.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746734745.git.ritesh.list@gmail.com>
References: <cover.1746734745.git.ritesh.list@gmail.com>
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


