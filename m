Return-Path: <linux-fsdevel+bounces-29803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B1097E0F2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Sep 2024 12:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A95028143A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Sep 2024 10:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB27D175D2E;
	Sun, 22 Sep 2024 10:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9Y7LDq2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F245524D7;
	Sun, 22 Sep 2024 10:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727001538; cv=none; b=TCEoNXETYojpq1z1hK5wj7eV61wcqak5aHzvtgKxHcFpuM4bJh1J5IFIWHcltuYqsKa7fHuIflSqDdC01wEmTRx+UiV001rbGrk6OTlDjP+xPBMVNUyobblo3XtpjCuARmixLRNE6mlIcylKaSfx/eRrRM/fd8OYs7C+ERltblM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727001538; c=relaxed/simple;
	bh=VG8wPAJlOh7wH7VZbFM1FggN+JzxIWkCE5thtmcsAyw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=upqOB5oR1HdsyO0gekHfJKBhevQhNZnK+lqf2WEer+UPlDCPBZhZI2GwscmW3VlWQ6m4L7fT7WyZ5XebZlZA9Pqf2KffW4KAKxuz868ZeTb9czujPOS+bA1CZfn958waL9WVDsATYmNRzJhTr4FlKB0o2L6S3pwiyqNsOgVFpy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9Y7LDq2; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2d877e9054eso2436855a91.3;
        Sun, 22 Sep 2024 03:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727001536; x=1727606336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uYFzsddciP2dhrvjy4QZaLUgZ3fluZaJRBZ4LzxsQdQ=;
        b=V9Y7LDq22RLTmAkWzFKjwoPPkgSizDVjHhvvX9BAm+9/cre9YfJnp13GR2hQ/9yYkC
         m2MJs2ZEoKQ955yLiTL/W+a5CszeaoATkAcAwaTb103t0/98ai8uA9pKXtEhGTzUB6ul
         KBjeidjrUK+5KjcuBASrd4yWQsXdLfFqAq6Fyz/kUI28QZooo2WAse/VRMxt23dmSLJx
         mFZEZDatTXAXypuwc4WHdssmUH/FK+vfYG6lRA+DLnY2Bt3RaROcot9hAzQxQtgq9CR2
         IBvlmDsYsa1B6Io0pM3c0rAuruGLiWIfOwuUuAV9HjYsNFMDllgcpePYCMLgF4Pky6Na
         n7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727001536; x=1727606336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uYFzsddciP2dhrvjy4QZaLUgZ3fluZaJRBZ4LzxsQdQ=;
        b=iF00kUYbeHAzvin3Srx4Z/Fz0tJevo+MoMgtSwwK4RZcJ1yse1JXH0VfKjW13AoCjh
         t5XeFmxwva7rS3ndsqDwBkcWgT28IoZvaEtk7zn5nCcq6aYMjiTKkiDUM5yeJ7Dvi/MN
         6vxUTcyz6SB7rdvwzBB65PuPs06bIar0OjbXvZCJJiBO7uj21k6dogQfb5HY142MAOzJ
         ZSJINF4zQuNIVHbBT5QcL/m+ohdbbkjlfWrx7CukX7YOpFfjj0HO/dkbiS8sQgbgClkj
         j1IJ7Mf531fNewgqo6aDPJVqCNn1wm8yDQ/PCrgPGTAp6p2U8iS9Sd1Ehos3mLvTjuf0
         oDPw==
X-Forwarded-Encrypted: i=1; AJvYcCV2amRQzZU8W0jU0yAdd+Nu4TD2UKZcKWKR52oxrocHzSTKldtK44MdOYkJByb93o0H2fDUMWKKwYQXaPq1@vger.kernel.org, AJvYcCWDg18W5El+Gg7lMOvlM2AgEoumNJn0mn3P4FSHwCc/wpAdcyXqO9UCz2UueJxjMRiq+Su8LFDg/A00Sgpb@vger.kernel.org
X-Gm-Message-State: AOJu0YznhWmA8hV05EsXZjo36FZaqBrnF87bYhIE7Z4+OVI9PBrBQS3/
	OHni4hi11CLn2kPSQJ64FnltTnX610jEAI/WLp7LbiA46D58oHLyQ6KDQg==
X-Google-Smtp-Source: AGHT+IHylK8Omp5kXM0sa2aS8a2vC0yRnn4oCQirRZ/15SzF/TczC9anJd49liFLbVbPHGgyng4Vug==
X-Received: by 2002:a17:90b:3c4a:b0:2dd:5e86:8c2f with SMTP id 98e67ed59e1d1-2dd7f452285mr9607651a91.21.1727001536130;
        Sun, 22 Sep 2024 03:38:56 -0700 (PDT)
Received: from localhost.localdomain (111-240-85-119.dynamic-ip.hinet.net. [111.240.85.119])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd7f7c0ff7sm5235084a91.5.2024.09.22.03.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 03:38:55 -0700 (PDT)
From: Min-Hua Chen <minhuadotchen@gmail.com>
To: 
Cc: Min-Hua Chen <minhuadotchen@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] proc: fix casts to/from restricted fmode_t
Date: Sun, 22 Sep 2024 18:38:29 +0800
Message-ID: <20240922103831.130355-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Peform a __force cast to fix the following sparse warnings:

fs/proc/base.c:2320:25: sparse: warning: cast to restricted fmode_t
fs/proc/base.c:2377:42: sparse: warning: cast from restricted fmode_t
fs/proc/base.c:2477:48: sparse: warning: cast from restricted fmode_t

No functional changes intended.

Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
---
 fs/proc/base.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index b31283d81c52..cb32961dfb4a 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2317,7 +2317,7 @@ static struct dentry *
 proc_map_files_instantiate(struct dentry *dentry,
 			   struct task_struct *task, const void *ptr)
 {
-	fmode_t mode = (fmode_t)(unsigned long)ptr;
+	fmode_t mode = (__force fmode_t)(unsigned long)ptr;
 	struct proc_inode *ei;
 	struct inode *inode;
 
@@ -2374,7 +2374,7 @@ static struct dentry *proc_map_files_lookup(struct inode *dir,
 
 	if (vma->vm_file)
 		result = proc_map_files_instantiate(dentry, task,
-				(void *)(unsigned long)vma->vm_file->f_mode);
+				(void *)(__force unsigned long)vma->vm_file->f_mode);
 
 out_no_vma:
 	mmap_read_unlock(mm);
@@ -2474,7 +2474,7 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 				      buf, len,
 				      proc_map_files_instantiate,
 				      task,
-				      (void *)(unsigned long)p->mode))
+				      (void *)(__force unsigned long)p->mode))
 			break;
 		ctx->pos++;
 	}
-- 
2.43.0


