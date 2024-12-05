Return-Path: <linux-fsdevel+bounces-36530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F529E54E7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 13:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BC131881782
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 12:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A18F217708;
	Thu,  5 Dec 2024 12:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNG+ucaz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D852B1F541D;
	Thu,  5 Dec 2024 12:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733400277; cv=none; b=usNQ3XzZVwtFv3LkhindLzjS+J8GxjQtyhN59qIA2g6sfKH+pJkkHjM1vqXK/5QKfYThm1XhTm2qB12Trkjw6eFo45CtVq6PXizZwd/XgP4AMZCImypWflXFygsvWlvjH/T1NmfTdfQOphOkH0mtVuvciPixC4vqufRqeoLksHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733400277; c=relaxed/simple;
	bh=CLXe9zQZTCkpanTwmMOGl8v9A9vh+311tmJkAVyV7/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f5kUQFWGRierNm/BsLxafKT8zfXdhsRuhhTcgd2FBtd8CoMtDOqu3IYG4vqg5nI/rR2SqToJfE7bQYc8T2X1bXY14ZveHcX0onAbV0Mn6zftvRO6pwUetSw0Hl/sw2XUqwk2BO0vakE+Ivzgn5N8fxBV27x0SyqgyScgoKHx35E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNG+ucaz; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa578d10d50so126473266b.1;
        Thu, 05 Dec 2024 04:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733400274; x=1734005074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/CO8vWK/YNfTkKcnhJMs36PMZVn1h69OtkbqJOOXag=;
        b=XNG+ucazvPVItF1UFe9+qa7eqtakAYvKqGKRoBfa3b+HSk3sUSC2s6RlhyModrc8du
         VFD6UF0wrV2fzMivy85lezrC2RIjlFisbgTa0esEK2Nzhd/21Qj5qVmBHNkPQhDr7S/6
         X7lIWyQcsKs4nrFeehdQD7wwRKZv1erYvN+IAYu0S9I75n3XmUeXqaiTtW7BiwxP2kOl
         hCDTMvu/SdKMWHQdbH1S8F+jN/uRRV7oiKhmaF04RcpmjOyi9rNVn77L+aPoA2jrMsNk
         s/hmH9wtrMbqyfPUuef7aj6uE3RZAlLhucGUsyhSPNU6BdqzpbQ2VEpciXmwh0D9+LMq
         igoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733400274; x=1734005074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/CO8vWK/YNfTkKcnhJMs36PMZVn1h69OtkbqJOOXag=;
        b=A59lt74xaqY0SitmKaCOqWw0C14bR9mD33Qk/2+nHMX10g7e1OgcKTxHkKPLOYSj/N
         VR5FTepP2Yp1flKOKXAcn6fdwZwzGpZpFGB0pXYB1Edi1PrbAd12kAkl/7Nbn6+xi4f1
         0cz/rSHEEMUt9J6OLUmBEJwJx+n88aIYltuSVQ33T62LfqVFdYy7p5MEcz1m9f8g6Q3+
         JgQVyMvf1BTI0e5PTRwypuIg7Lrhzb9f8IVTK0gBpTg/kOmKb0uem1m/zFooS1mHupBr
         sGouxmt3LoTkt/wymAQhyVh71wnws+ARXR276dBWpV7S6ZlQ3eN0fxQXCaRrWOcBj2X5
         eK7w==
X-Forwarded-Encrypted: i=1; AJvYcCVxLME6/S5ZTUeE6dPi+adC0a4Rym1cQTXLGmJEM3XSduLOdtEuIpeBblChQxy7a4/ZcK1XaqP62l5JXRfs@vger.kernel.org, AJvYcCX5hnXiqvjTys0nkFFuGC8YzsATuJrZVjlXWh/YH78rj6ivZKBhKMu2wJ5NvoW0rf8HTxMGLFUAtYmeFGjQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3LqoadGqeBsqVt9EGjO5knu53ZQxhec7WTcNH9GrgoIjnK7Lf
	eOlVtRLuQh0PrQETIbZsVfBSnTO1/xBZR59Prm+I7vvPNEVe0W3l
X-Gm-Gg: ASbGncvftNM/FvcVjMbbDdjgf1I8dIyzd84uD+qJJuueEufOzRUxwY/OIdczZuUGGwb
	eVR3nUl6uPwi01Gq9QV9ii90jiQ7pFV9jn3mRvqt97kEgeU2HBJXpo+MnuwjgUUGrny/M/V4nHe
	Mo81BC+sXLvwswaehaa6KmM/Hu3jNK2UpchINnJJsFfUmNfeJlEabuq0GR7z6HKPm7CuQR0iRan
	WQqGPx6FsbwtZ1WYqwAoAXJ+8fv9jE4BO8ckA5xLfb6Jq5Gx4FYZDF4aFODQU/zxA==
X-Google-Smtp-Source: AGHT+IGbhrudRQn+l8+scF6YF5REa/Rdq9waXnEnOv1dfQy99lCyNzpICpq89AfOZWNiPEfC/mYDuw==
X-Received: by 2002:a17:906:3147:b0:aa6:143e:12d with SMTP id a640c23a62f3a-aa6143e52e4mr420974466b.59.1733400273831;
        Thu, 05 Dec 2024 04:04:33 -0800 (PST)
Received: from f.. (cst-prg-17-59.cust.vodafone.cz. [46.135.17.59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa62608f57fsm83091666b.146.2024.12.05.04.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 04:04:32 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: paulmck@kernel.org
Cc: brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [RFC PATCH] fs: elide the smp_rmb fence in fd_install()
Date: Thu,  5 Dec 2024 13:03:32 +0100
Message-ID: <20241205120332.1578562-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAGudoHG6zYMfFmhizJDPAw=CF8QY8dzbvg0cSEW4XVcvTYhELw@mail.gmail.com>
References: <CAGudoHG6zYMfFmhizJDPAw=CF8QY8dzbvg0cSEW4XVcvTYhELw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

See the added commentary for reasoning.

->resize_in_progress handling is moved inside of expand_fdtable() for
clarity.

Whacks an actual fence on arm64.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

To my reading of commentary above synchronize_rcu() this works fine(tm)
and there is even other code relying on the same idea (percpu rwsems
(see percpu_down_read for example), maybe there is more).

However, given that barriers like to be tricky and I know about squat of
RCU internals, I refer to Paul here.

Paul, does this work? If not, any trivial tweaks to make it so?

I mean smp_rmb looks dodgeable, at worst I made a mistake somewhere and
the specific patch does not work.

 fs/file.c | 50 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 39 insertions(+), 11 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 019fb9acf91b..d065a24980da 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -233,28 +233,54 @@ static int expand_fdtable(struct files_struct *files, unsigned int nr)
 	__acquires(files->file_lock)
 {
 	struct fdtable *new_fdt, *cur_fdt;
+	int err = 0;
 
+	BUG_ON(files->resize_in_progress);
+	files->resize_in_progress = true;
 	spin_unlock(&files->file_lock);
 	new_fdt = alloc_fdtable(nr + 1);
 
-	/* make sure all fd_install() have seen resize_in_progress
-	 * or have finished their rcu_read_lock_sched() section.
+	/*
+	 * Synchronize against the lockless fd_install().
+	 *
+	 * All work in that routine is enclosed with RCU sched section.
+	 *
+	 * We published ->resize_in_progress = true with the unlock above,
+	 * which makes new arrivals bail to locked operation.
+	 *
+	 * Now we only need to wait for CPUs which did not observe the flag to
+	 * leave and make sure their store to the fd table got published.
+	 *
+	 * We do it with synchronize_rcu(), which both waits for all sections to
+	 * finish (taking care of the first part) and guarantees all CPUs issued a
+	 * full fence (taking care of the second part).
+	 *
+	 * Note we know there is nobody to wait for if we are dealing with a
+	 * single-threaded process.
 	 */
 	if (atomic_read(&files->count) > 1)
 		synchronize_rcu();
 
 	spin_lock(&files->file_lock);
-	if (IS_ERR(new_fdt))
-		return PTR_ERR(new_fdt);
+	if (IS_ERR(new_fdt)) {
+		err = PTR_ERR(new_fdt);
+		goto out;
+	}
 	cur_fdt = files_fdtable(files);
 	BUG_ON(nr < cur_fdt->max_fds);
 	copy_fdtable(new_fdt, cur_fdt);
 	rcu_assign_pointer(files->fdt, new_fdt);
 	if (cur_fdt != &files->fdtab)
 		call_rcu(&cur_fdt->rcu, free_fdtable_rcu);
-	/* coupled with smp_rmb() in fd_install() */
+
+	/*
+	 * Publish everything before we unset ->resize_in_progress, see above
+	 * for an explanation.
+	 */
 	smp_wmb();
-	return 0;
+out:
+	files->resize_in_progress = false;
+	return err;
 }
 
 /*
@@ -290,9 +316,7 @@ static int expand_files(struct files_struct *files, unsigned int nr)
 		return -EMFILE;
 
 	/* All good, so we try */
-	files->resize_in_progress = true;
 	error = expand_fdtable(files, nr);
-	files->resize_in_progress = false;
 
 	wake_up_all(&files->resize_wait);
 	return error;
@@ -629,13 +653,18 @@ EXPORT_SYMBOL(put_unused_fd);
 
 void fd_install(unsigned int fd, struct file *file)
 {
-	struct files_struct *files = current->files;
+	struct files_struct *files;
 	struct fdtable *fdt;
 
 	if (WARN_ON_ONCE(unlikely(file->f_mode & FMODE_BACKING)))
 		return;
 
+	/*
+	 * Synchronized with expand_fdtable(), see that routine for an
+	 * explanation.
+	 */
 	rcu_read_lock_sched();
+	files = READ_ONCE(current->files);
 
 	if (unlikely(files->resize_in_progress)) {
 		rcu_read_unlock_sched();
@@ -646,8 +675,7 @@ void fd_install(unsigned int fd, struct file *file)
 		spin_unlock(&files->file_lock);
 		return;
 	}
-	/* coupled with smp_wmb() in expand_fdtable() */
-	smp_rmb();
+
 	fdt = rcu_dereference_sched(files->fdt);
 	BUG_ON(fdt->fd[fd] != NULL);
 	rcu_assign_pointer(fdt->fd[fd], file);
-- 
2.43.0


