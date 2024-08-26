Return-Path: <linux-fsdevel+bounces-27242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0393E95FB8B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 23:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2CF7280FC1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 21:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21621993BA;
	Mon, 26 Aug 2024 21:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5uAnZld"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C44881E
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 21:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724707205; cv=none; b=m8PDq86U22ezsHimdBZJNi5rZISqt/2Vjvo1VwLW19g7W4XEgXSQXQySmfZgxshAZO2bsUlbJ1Y1yNtpRcR4gWo47AMGT/ETYcu9iYlb/IGAYRjwrUAweaXUzgWS+SUuZi5RlxCy6X1QP+GT6bEvWljTVQvhUeo2e9duB8F3BVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724707205; c=relaxed/simple;
	bh=d1sw3RklYepjEi8jrs758o0Ste9SePDfyolWUw0Jdxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMZUfZXQGAPTd7y2AhLt23DcqNd/FRgbzo64d0BkQeOKoZnVECJ+QcOTZssdGdxtkWEV3PuJQCtMg3M7GNwmLNKZUFs3tA3gsWPm4lYuQMvAHQ/7XBFtE6ILwPvYDLVUhZjJr561QXtj936JJxSXsl/FMb6F5fDx2hBU0nu6V3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5uAnZld; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e1633202008so4727146276.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 14:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724707203; x=1725312003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=grTnWehlIm/aEMMtVTYddChEg6d1BbxYt+fz0gv8hQY=;
        b=a5uAnZldFb4U0bUld0PZQZjFudKPHnojFCT4Pnnr4Cpa9CfwX9Q2GCrOfhZhT1Jb1O
         nvoXKlyc5AbtmsEHNxWkTJeOm0sPjJN82YX8FQK1FuOJTom9OeFu1hDlzOpjefys27Gq
         QFu6oj6m2TrAI54nR8+ikofgPCk0Pmg6og9xRG0XQpUYqjOK8N5MDp90sbjDcNhH+gIS
         L9nTR0QPLUd6gjKfL27AAbinRS/bdtiGHJ/gvpNhlblst49JSC/Png8mQhDZztIn02kh
         rTvEWsTRBh1P2q4mbGp3Y96j6xq6ClHDFZye+H2u8yD0XuMzRmtN9Vti8FydfdsPLNLd
         F1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724707203; x=1725312003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=grTnWehlIm/aEMMtVTYddChEg6d1BbxYt+fz0gv8hQY=;
        b=siiiym/A5KTyclrgCAI2hNEpKF/d9AAqFDPwZoGDIhM1Q2Yo3Ucvmodco4nv9I6As2
         DYDI29ST1JqVyXu7hCZIff8tDuOJE6UFUj1a0X4vZzvZkIwZI+Bx4CYiPiqA+n4/jjlw
         ZHD0rPIHwyCjLDct/Uc880S+AG6i4dbAE9KQwz3VrIU4Dj8pA7BnTLz5XqKFzoIZZO+e
         sDVm1qZXZfSUCq8BaMOlantDwvx41sKYEDlj8JBhL0ml2wPvhQkvuwyk/OcsTd1YnA9u
         M0klc9JgFGN9yXqGUBBdLLrWDlersdZpzl91hOdZsHIFcu+YS6n8NoFhJfrXtQANcKgg
         sALQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcFCJmJYAb4WA8xeRVCsHLXnf103EdcZu+qgeEgOGoHjBk08PisSwS+F0cFMSF37D1ELb2TCpdRLfzzEF5@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfa6snRO5fjV0d5gHHqiPdmNChqhxs8Ga+K5qBeL+858Qxs6En
	BCj60u+4B9HNfH4xQ4+Sbea4chspGClYOZ8Y2dbJ6L46sAllvp0s
X-Google-Smtp-Source: AGHT+IETDX8+GE+Kwr0asbT4H3r3OxV1hmmp7+osRDVF3LTxazxEZzjHT6ReLXdInHEVRA81eYHV2g==
X-Received: by 2002:a05:6902:102e:b0:e0e:3ee7:751d with SMTP id 3f1490d57ef6-e1a2a5a6a10mr921048276.11.1724707202790;
        Mon, 26 Aug 2024 14:20:02 -0700 (PDT)
Received: from localhost (fwdproxy-nha-116.fbsv.net. [2a03:2880:25ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e178e43fc98sm2232312276.11.2024.08.26.14.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 14:20:02 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	kernel-team@meta.com
Subject: [PATCH v4 1/7] fuse: drop unused fuse_mount arg in fuse_writepage_finish()
Date: Mon, 26 Aug 2024 14:19:02 -0700
Message-ID: <20240826211908.75190-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240826211908.75190-1-joannelkoong@gmail.com>
References: <20240826211908.75190-1-joannelkoong@gmail.com>
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


