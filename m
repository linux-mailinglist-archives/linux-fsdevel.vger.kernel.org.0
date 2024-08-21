Return-Path: <linux-fsdevel+bounces-26566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BE895A820
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0F001F22EAA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 23:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3A117D8A2;
	Wed, 21 Aug 2024 23:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBef7OqG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786E41494AD
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 23:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724282713; cv=none; b=uDOqWX7WjSR5S5TVYFkZyAv4KwxtHFGhMioyrtlb8q/5YddBkUpEZ8D6wadgsW9JKWkMF8uVGbD4AMonZLyOFJc9i5w38vUuAneKJl4kwPl7FPCj5hcTSQH0lYC2Mf6+b6ZoPZAG4P4bNTOvKbtD+daz0otP0G+sSsMvBsLsizI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724282713; c=relaxed/simple;
	bh=d1sw3RklYepjEi8jrs758o0Ste9SePDfyolWUw0Jdxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cg/3t4i6s4Qgxxp3se4I1vGncAnUZGu48Aps73eE+ojRAnWXbL+tBRHbc80kBKKT0rtf9k7IzzRagneVgMVOHB8AbDbwN61WZUk07N49pgI+wJYsmCeFmQr8SPUcLypN6Hr9iZLh+TbjX6IJkheEFbDQ8ckmRpYHJvszMigm0ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBef7OqG; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e0e76380433so287023276.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 16:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724282711; x=1724887511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=grTnWehlIm/aEMMtVTYddChEg6d1BbxYt+fz0gv8hQY=;
        b=IBef7OqGu+xHkDppT6SMbo2H2tuGG1Vqf7GLfnHOZFYVLY/IbXAjKLJUEnTRroWLck
         TWUY0Mg3q0Y2YGBKq5ue3NbtxyKzjhYrea+9cFpsWRZweMiMLKY6HWTjg8Tm77Pz+AgR
         +2uQPFskuKbA196cY7hBx++DjRvApoefTJs2j9tCyt3gBWaFHDINWt8xCzYe9R6zUu5I
         NIJoHHm0oxt2WEqT8iOGj8tYzOo4Jzyl6s2TFRFY8tGz8ax36Q0pUdVChNndEW/yA429
         3Gi77CaUohtu6imj97eblV+D2H55DgqfcMGNfEE4wWDANnuyicNMw45ZDeSl97DsqJ9Z
         7Y6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724282711; x=1724887511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=grTnWehlIm/aEMMtVTYddChEg6d1BbxYt+fz0gv8hQY=;
        b=axxPUh7s6P9q8k+sfmI1gmo8vMzC0L1vZBKp5D/uKuMb8bFWjtuByK9VdwBjj+4CM8
         Gp0jkd9LP4AQAk6PpHXzpXQg5fLYfQFfKmWgObtdc2T+fywwFisFY7FL3ju9LHn/aKPP
         VvU1KcS3KjFhLWJna/OLYKluGsNrpb7OX19wmExDROp1V0WVV/U89Am5D9pl66crC78v
         FtfHk3w4NSGcP5c5qqbif3/kK8VZXHsg7Rp7xf/MNwUVUVP5UQBdwpGcxBMr+6rSMbdm
         RiDbHGklriO97FcCWCZx9mXGW04QzvJG5BC8jvos30Ymt9MZXNJlt+noWT1O1g4ng9FS
         mzfw==
X-Forwarded-Encrypted: i=1; AJvYcCWNQcDKJqPPG2qxpSIxtfEyFvhkLeBtVRyFdrScGHnLRE4BM9frQUeank7K5cj+cC72qiy+BHSEjeh3nZkw@vger.kernel.org
X-Gm-Message-State: AOJu0YyeesTFqzkdNP4feFPzbruMmjkPjK3OZqRR/B3HWKhTDiBT7UTY
	YlY71uCyfAukc0d0v6/dH2CJyyQdFSUmPLLkZMXXmYn5U1O4HpJF
X-Google-Smtp-Source: AGHT+IGqppsTZyTzyNWU0yw6RoixI5lQyS2OvmZ7sGnspvpCmCHu2HXWnUOZB1OlP4IQWOUmpxYWfA==
X-Received: by 2002:a05:6902:1006:b0:e11:7db3:974c with SMTP id 3f1490d57ef6-e17903c8130mr192827276.35.1724282711378;
        Wed, 21 Aug 2024 16:25:11 -0700 (PDT)
Received: from localhost (fwdproxy-nha-008.fbsv.net. [2a03:2880:25ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e178e56a2cesm59591276.52.2024.08.21.16.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 16:25:11 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	kernel-team@meta.com
Subject: [PATCH v2 1/9] fuse: drop unused fuse_mount arg in fuse_writepage_finish()
Date: Wed, 21 Aug 2024 16:22:33 -0700
Message-ID: <20240821232241.3573997-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240821232241.3573997-1-joannelkoong@gmail.com>
References: <20240821232241.3573997-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the unused "struct fuse_mount *fm" arg in
fuse_writepage_finish().

No functional changes added.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/fuse/file.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f39456c65ed7..63fd5fc6872e 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1769,8 +1769,7 @@ static void fuse_writepage_free(struct fuse_writepage_args *wpa)
 	kfree(wpa);
 }
 
-static void fuse_writepage_finish(struct fuse_mount *fm,
-				  struct fuse_writepage_args *wpa)
+static void fuse_writepage_finish(struct fuse_writepage_args *wpa)
 {
 	struct fuse_args_pages *ap = &wpa->ia.ap;
 	struct inode *inode = wpa->inode;
@@ -1829,7 +1828,7 @@ __acquires(fi->lock)
  out_free:
 	fi->writectr--;
 	rb_erase(&wpa->writepages_entry, &fi->writepages);
-	fuse_writepage_finish(fm, wpa);
+	fuse_writepage_finish(wpa);
 	spin_unlock(&fi->lock);
 
 	/* After fuse_writepage_finish() aux request list is private */
@@ -1959,7 +1958,7 @@ static void fuse_writepage_end(struct fuse_mount *fm, struct fuse_args *args,
 		fuse_send_writepage(fm, next, inarg->offset + inarg->size);
 	}
 	fi->writectr--;
-	fuse_writepage_finish(fm, wpa);
+	fuse_writepage_finish(wpa);
 	spin_unlock(&fi->lock);
 	fuse_writepage_free(wpa);
 }
-- 
2.43.5


