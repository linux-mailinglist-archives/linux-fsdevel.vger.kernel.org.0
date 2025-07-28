Return-Path: <linux-fsdevel+bounces-56166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C169B14315
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 22:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E180418C2D84
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 20:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C50927A92E;
	Mon, 28 Jul 2025 20:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aka+waiD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9183279917
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 20:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734694; cv=none; b=oL92AU3fhzJYvyvDLpVguPd7+pKvFiTodS4AwPod3LwhO5174ViDEvt2yijoqVsS3jCQk3XWgOMRsiLTV+ZWchprrfWjLdt8AmZxfoiy7E1vs5lQ9U7buhIhse/+CGiFasG5h+h7TME/2/VAuXHc9nQxJpGn6gwDpzL0aPtkdmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734694; c=relaxed/simple;
	bh=Cc8jfD9UXHnTL28T91p6u/Kf5oNqaZTP/JPhzrOnvHE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=pnRXqFQSJp14+v+hT7RWMPU5t1CF/JrB7ROf1JcvVl6mINtHahkr4KTeyZFKopqnNhA0fSKMs7yA1t2brN1qKk3r+ewTGE6+lfvurkJrBYbAFRuYYZ+NKr3Dx/G8S7LYc531X+l2gQYgFi5mcKigsFGkSwzFaFlBeVFJ8jbIjew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aka+waiD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753734692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gsNqASzsrM4FhxhYhZwqXoEsfSVZFoKy3EvjkkcLH3A=;
	b=Aka+waiDguz8v1PGXphElIQUdS98Rvft4ghwJC4+2sMMi4yhIjVqtCGPzQT3NnX6Tk19kN
	LIInpZqPRpS9GzyVm1baRwU6m3rMDpjvwalRj9JSI/BItaDpq9sd23+DK4tyI1EF6J6DNV
	RbyV2kEzBu84UAu6ocOAlxfmnSjMg2E=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-3WS0FFtWOhif_UQDwKdsmQ-1; Mon, 28 Jul 2025 16:31:30 -0400
X-MC-Unique: 3WS0FFtWOhif_UQDwKdsmQ-1
X-Mimecast-MFC-AGG-ID: 3WS0FFtWOhif_UQDwKdsmQ_1753734689
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-615145b0a00so1382602a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 13:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734689; x=1754339489;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsNqASzsrM4FhxhYhZwqXoEsfSVZFoKy3EvjkkcLH3A=;
        b=mi9m1U2rd1sPAJ4CJgs9NqC4mZZW3QueBcX6EYyT/ocMm8SP33ZlY2dfhGgpsREoRm
         NAVfeXD+WmJMDLILXUNgBsP5eyiDNw784fl5La7UyDpwtb3hMLl1GLeAXAkgRunv0Wx/
         0wmB7OI3PV6WzjKZNmmAm4poLQ1nPIWwZSv9EMualt6J8hcxpVqHBPfJheyr6F9m6Zg7
         9ZCrz8NVAd49H8ledVnEMQCE89sQj8RHvraKCkFZq88j1soMgWX5rS7DUWXqTuerMvyk
         Rb0XDen7KVYZbOnb/21Z6wbRGHPN0qTDdVnZSTW7ru3YCPFDk2vEdG2rCgs+IF8sDssA
         AenA==
X-Forwarded-Encrypted: i=1; AJvYcCUilQAxv4LzFYgF+40a6XgawV4VENMuL6zr8dwm9sm3G/6fgCq/dNurvFPs6tjGjumVTTLzKaoUVD2NCKne@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ5mI87BIlg/tcMoDWlZXljOZCPSBSPR2U2j8AJaqL2kTTcJE4
	R4Ffd6jL9uY2G4hRwwQYBKw+obBBRnX+wcPYBGOQ04h2avujNMfuUexnc3yNxlhltg8QHZnE8Bg
	G8FBDKowEjXV2aIZ3goIQDVL3Tpm3DYkIOEHARcCRoEIZyrW5CZlN4MI+RlbojlY9iUmQ5U/FjK
	pFiqg1yDjCydz0IdeYm1filte5YZt2+b0mp4YFPdHHl3mK6Zkieg==
X-Gm-Gg: ASbGnctl1QMWK9C4mZUTRla9Ea8Q3sL4bhdWmumMTJSfbbVofXQT+WmZtXBAPL7Kx+4
	EzOtK8V8Y8Eo5Xw3ZWXhFAecObxql/8c0FB/ldg9A3C+NfQzMvAJ7SJ3ilWkaig5xbEyzc/69Bo
	IKvdKqPJxUPedOIr6zaybQ5cJCFnUvPxxGGGrnFwHy9LnYLbauE5Yca3vDQcrgZby5vPLcZZbpe
	ohXsm2Jkx9VKohhgNH+Rb1uUAbtNCMvcEBODJbcFAsqVLp7ZAjTOxcpvlrxKUd2gBACcKJwv7OO
	YCZ+2f6wcqFbra+bokBWR7m7//owVh/dHxcb93k7Vh4IEQ==
X-Received: by 2002:a05:6402:518e:b0:615:5799:72eb with SMTP id 4fb4d7f45d1cf-61557997743mr3139605a12.4.1753734688737;
        Mon, 28 Jul 2025 13:31:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaXCTtgJBVa+Xs6kxiTyulJmF/M7m0cchmWiQmoT0v4y+AxWRRt3r7Xo334Ukqtepms8Dudg==
X-Received: by 2002:a05:6402:518e:b0:615:5799:72eb with SMTP id 4fb4d7f45d1cf-61557997743mr3139564a12.4.1753734688186;
        Mon, 28 Jul 2025 13:31:28 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615226558d3sm2730656a12.45.2025.07.28.13.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 13:31:27 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 28 Jul 2025 22:30:11 +0200
Subject: [PATCH RFC 07/29] fsverity: pass super_block to
 fsverity_enqueue_verify_work
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-fsverity-v1-7-9e5443af0e34@kernel.org>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
In-Reply-To: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
To: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, david@fromorbit.com, djwong@kernel.org, 
 ebiggers@kernel.org, hch@lst.de
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5317; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=1QRoKp7YVPVu+fLZj5koefoGqFZX89pyv0L/h2jQYGc=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMtrvibdN+/JCpGnfUXNz+X1rPJ8H8bJIuRzTSzsWP
 f2J/47tduEdpSwMYlwMsmKKLOuktaYmFUnlHzGokYeZw8oEMoSBi1MAJhJ7g5GheVdk1ctL5zRD
 7OY0yn0vubOxPpXP2kb/WMdxBt/156PsGBmmGH9eyBBcxbozT8i95Lv6ird39X8e/VNu73FCd9J
 6NmNuAP6WRjs=
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

From: "Darrick J. Wong" <djwong@kernel.org>

In preparation for having per-superblock fsverity workqueues, pass the
super_block object to fsverity_enqueue_verify_work.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/buffer.c              | 7 +++++--
 fs/ext4/readpage.c       | 4 +++-
 fs/f2fs/compress.c       | 3 ++-
 fs/f2fs/data.c           | 2 +-
 fs/verity/verify.c       | 6 ++++--
 include/linux/fsverity.h | 6 ++++--
 6 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 8cf4a1dc481e..9d56eb353ced 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -336,13 +336,15 @@ static void decrypt_bh(struct work_struct *work)
 	err = fscrypt_decrypt_pagecache_blocks(bh->b_folio, bh->b_size,
 					       bh_offset(bh));
 	if (err == 0 && need_fsverity(bh)) {
+		struct super_block *sb = bh->b_folio->mapping->host->i_sb;
+
 		/*
 		 * We use different work queues for decryption and for verity
 		 * because verity may require reading metadata pages that need
 		 * decryption, and we shouldn't recurse to the same workqueue.
 		 */
 		INIT_WORK(&ctx->work, verify_bh);
-		fsverity_enqueue_verify_work(&ctx->work);
+		fsverity_enqueue_verify_work(sb, &ctx->work);
 		return;
 	}
 	end_buffer_async_read(bh, err == 0);
@@ -371,7 +373,8 @@ static void end_buffer_async_read_io(struct buffer_head *bh, int uptodate)
 				fscrypt_enqueue_decrypt_work(&ctx->work);
 			} else {
 				INIT_WORK(&ctx->work, verify_bh);
-				fsverity_enqueue_verify_work(&ctx->work);
+				fsverity_enqueue_verify_work(inode->i_sb,
+							     &ctx->work);
 			}
 			return;
 		}
diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index f329daf6e5c7..e9ecfc7830d7 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -61,6 +61,7 @@ enum bio_post_read_step {
 
 struct bio_post_read_ctx {
 	struct bio *bio;
+	struct super_block *sb;
 	struct work_struct work;
 	unsigned int cur_step;
 	unsigned int enabled_steps;
@@ -132,7 +133,7 @@ static void bio_post_read_processing(struct bio_post_read_ctx *ctx)
 	case STEP_VERITY:
 		if (ctx->enabled_steps & (1 << STEP_VERITY)) {
 			INIT_WORK(&ctx->work, verity_work);
-			fsverity_enqueue_verify_work(&ctx->work);
+			fsverity_enqueue_verify_work(ctx->sb, &ctx->work);
 			return;
 		}
 		ctx->cur_step++;
@@ -195,6 +196,7 @@ static void ext4_set_bio_post_read_ctx(struct bio *bio,
 			mempool_alloc(bio_post_read_ctx_pool, GFP_NOFS);
 
 		ctx->bio = bio;
+		ctx->sb = inode->i_sb;
 		ctx->enabled_steps = post_read_steps;
 		bio->bi_private = ctx;
 	}
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index b3c1df93a163..31b45abb26b7 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1839,7 +1839,8 @@ void f2fs_decompress_end_io(struct decompress_io_ctx *dic, bool failed,
 		 * file, and these metadata pages may be compressed.
 		 */
 		INIT_WORK(&dic->verity_work, f2fs_verify_cluster);
-		fsverity_enqueue_verify_work(&dic->verity_work);
+		fsverity_enqueue_verify_work(dic->inode->i_sb,
+					     &dic->verity_work);
 		return;
 	}
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 31e892842625..e4e4697ad0d3 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -215,7 +215,7 @@ static void f2fs_verify_and_finish_bio(struct bio *bio, bool in_task)
 
 	if (ctx && (ctx->enabled_steps & STEP_VERITY)) {
 		INIT_WORK(&ctx->work, f2fs_verify_bio);
-		fsverity_enqueue_verify_work(&ctx->work);
+		fsverity_enqueue_verify_work(ctx->sbi->sb, &ctx->work);
 	} else {
 		f2fs_finish_read_bio(bio, in_task);
 	}
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 917a5fb5388f..ef5d27039c98 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -363,13 +363,15 @@ EXPORT_SYMBOL_GPL(fsverity_init_wq);
 
 /**
  * fsverity_enqueue_verify_work() - enqueue work on the fs-verity workqueue
+ * @sb: superblock for this filesystem
  * @work: the work to enqueue
  *
  * Enqueue verification work for asynchronous processing.
  */
-void fsverity_enqueue_verify_work(struct work_struct *work)
+void fsverity_enqueue_verify_work(struct super_block *sb,
+				  struct work_struct *work)
 {
-	queue_work(fsverity_read_workqueue, work);
+	queue_work(sb->s_verity_wq ?: fsverity_read_workqueue, work);
 }
 EXPORT_SYMBOL_GPL(fsverity_enqueue_verify_work);
 
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index d263e988bec2..8155407a7e4c 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -186,7 +186,8 @@ int fsverity_ioctl_read_metadata(struct file *filp, const void __user *uarg);
 
 bool fsverity_verify_blocks(struct folio *folio, size_t len, size_t offset);
 void fsverity_verify_bio(struct bio *bio);
-void fsverity_enqueue_verify_work(struct work_struct *work);
+void fsverity_enqueue_verify_work(struct super_block *sb,
+				  struct work_struct *work);
 
 int fsverity_init_wq(struct super_block *sb, unsigned int wq_flags,
 		       int max_active);
@@ -271,7 +272,8 @@ static inline void fsverity_verify_bio(struct bio *bio)
 	WARN_ON_ONCE(1);
 }
 
-static inline void fsverity_enqueue_verify_work(struct work_struct *work)
+static inline void fsverity_enqueue_verify_work(struct super_block *sb,
+						struct work_struct *work)
 {
 	WARN_ON_ONCE(1);
 }

-- 
2.50.0


