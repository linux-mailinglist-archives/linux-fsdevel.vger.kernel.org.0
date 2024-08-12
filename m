Return-Path: <linux-fsdevel+bounces-25652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7578094E820
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 09:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1740282FE1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 07:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC458161306;
	Mon, 12 Aug 2024 07:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLAxAHZr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D7715443B;
	Mon, 12 Aug 2024 07:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723449434; cv=none; b=sElzzmtjkRm6rTqGe1U3vebOhMOCMl7T5lzniDazQ81AtxZG7olCUVt7LVIOiCMj1XTvdNfy9KxDCxbcJn83FHimd3s87J/3PnpfMMQY8jo+QWVqgsQ6N7Z2Xdq1q79xku7E8Q0FtnXxh4rX+mnB7vUwYMY3aBcCzv3CTVbxeRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723449434; c=relaxed/simple;
	bh=t8lC8DlFUS6Wm89+wt8jl4yxaIZoAgXtH6rTQS8a4go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pp5tKZ8Ddq893uRTxPe8AszF2+OwmuQeiJrFYpYRvtezOcx2SYrXl+j6BOTSEhjsTwRKGLrLk4rrbE2ulklhf3paVmaTt5YXI5VnNC99gvi0vpcLw/d6lYUr3eDuXp1pp/ZJkzXbNNkcZBLFwpriR9wsyHq3Zut+cRTuQ8wgFws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLAxAHZr; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7b2dbd81e3so501477666b.1;
        Mon, 12 Aug 2024 00:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723449431; x=1724054231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpHFKOA3+VSmgmP7qbAiCZWFl/wO/RVQXZM/gWknRxA=;
        b=NLAxAHZroo6azEZJQz6dj4U4FmLLpDAf00LM8jJYdHgjVnj4tPsvDq3LXiXSMKp0/T
         fq80wagvj62zfGbufIaNq+SjcR+gueCgGD1VknCJE1iA8S3JQ50Pph4ILGzSyDCSAq0f
         JzMOK7NpuGQE/v8TYoe5NwyQfn8N+6CBjvaAMjVUF+dl7GxW1PXbwz1YX7gXs0OtfWvR
         5FovcivzZ5e8VT6ceeRNfoShqLuPEfHlQeZXD+2bZpFZB57ZpCVa6gVjPjYl1xi3CRNR
         /keX+QqTahUjyqVJOJVzqDl+gHn1znvK1e5L4+J2hzSzSjUPgmSEY7XG6ZrIkdg7k82f
         ysdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723449431; x=1724054231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lpHFKOA3+VSmgmP7qbAiCZWFl/wO/RVQXZM/gWknRxA=;
        b=HM7BNeNKas9H3mCbiJwX/HdqI6LX6f/abnPmBsTtRKBQS8RgAT5DTGBjjD7IZN0v/y
         xnb97/lYe0PLQEvqLkp2xBVFX5AiYkyiWOvtSI5E4FLeJYfao3GzQ0Xx1+QDajz8ku9g
         cizf/UAZVfsh00ykzQLhp0NWMjoZDBnDil1jl8Vvb17Vwa0WmwH9ul790h1Q4Y8Ja+Y6
         caCQduhGx4OrA98TMI30GrNqX+UhXQubUbwQbM2e9/WoApmT6ggWoNH+7ujGnSVoeWtf
         TiVxf6uZVgm8ge3/4E7PAA8uyZ4pG+MldQ9TMdpEgVpimJDbtx/hhXlMDJnKUKZVdsOE
         fF2A==
X-Forwarded-Encrypted: i=1; AJvYcCUwCiL0aQV4TSX9gWG8tFPWYW/ubBoTuwLlBVA64Ye5XQhJew3pl7WS6tW8EgWsdGeF9wJ5Qah1KToSwNqW9M37VOja6XASfgLEtYwhMWRZ7qicM0RYFsYFkyKYIJ0ABmD95AJSaM8hzoEl/w==
X-Gm-Message-State: AOJu0YzkgsRRqnpKJQEfjyu491rgY/9CvWoxtps6fkELtfmQ9rS70z6E
	oWwupRWbO+WJZoI2Cb4lHRHc+37kYXbk+rbfKY1hlpPJw18FDcEs
X-Google-Smtp-Source: AGHT+IGZQ5jztRS8FRL19cLL3yCfXOsQB6OjbNxKAtxOuU0133wDifhKBJ/E3So5fxHU5Eb+tf4xAA==
X-Received: by 2002:a17:907:c8a7:b0:a7a:9447:3e8c with SMTP id a640c23a62f3a-a80aa55253cmr577948866b.3.1723449430345;
        Mon, 12 Aug 2024 00:57:10 -0700 (PDT)
Received: from f.. (cst-prg-72-52.cust.vodafone.cz. [46.135.72.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb08fbd7sm206988766b.26.2024.08.12.00.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 00:57:09 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] close_files(): reimplement based on do_close_on_exec()
Date: Mon, 12 Aug 2024 09:56:58 +0200
Message-ID: <20240812075659.1399447-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812064427.240190-3-viro@zeniv.linux.org.uk>
References: <20240812064427.240190-3-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While here take more advantage of the fact nobody should be messing with
the table anymore and don't clear the fd slot.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

how about this instead, I think it's a nicer clean up.

It's literally do_close_on_exec except locking and put fd are deleted.

boots & does not blow up, but admittedly I did not bother with ltp or
any serious testing

 fs/file.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 74d7ad676579..3ff2e8265156 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -389,33 +389,38 @@ struct files_struct *dup_fd(struct files_struct *oldf, unsigned int max_fds)
 	return newf;
 }
 
-static struct fdtable *close_files(struct files_struct * files)
+static struct fdtable *close_files(struct files_struct *files)
 {
 	/*
 	 * It is safe to dereference the fd table without RCU or
 	 * ->file_lock because this is the last reference to the
 	 * files structure.
+	 *
+	 * For the same reason we can skip locking.
 	 */
 	struct fdtable *fdt = rcu_dereference_raw(files->fdt);
-	unsigned int i, j = 0;
+	unsigned i;
 
-	for (;;) {
+	for (i = 0; ; i++) {
 		unsigned long set;
-		i = j * BITS_PER_LONG;
-		if (i >= fdt->max_fds)
+		unsigned fd = i * BITS_PER_LONG;
+		fdt = files_fdtable(files);
+		if (fd >= fdt->max_fds)
 			break;
-		set = fdt->open_fds[j++];
-		while (set) {
-			if (set & 1) {
-				struct file * file = xchg(&fdt->fd[i], NULL);
-				if (file) {
-					filp_close(file, files);
-					cond_resched();
-				}
-			}
-			i++;
-			set >>= 1;
+		set = fdt->open_fds[i];
+		if (!set)
+			continue;
+		for ( ; set ; fd++, set >>= 1) {
+			struct file *file;
+			if (!(set & 1))
+				continue;
+			file = fdt->fd[fd];
+			if (!file)
+				continue;
+			filp_close(file, files);
+			cond_resched();
 		}
+
 	}
 
 	return fdt;
-- 
2.43.0


