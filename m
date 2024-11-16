Return-Path: <linux-fsdevel+bounces-35006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B0B9CFCEC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2024 07:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9EBA2879D8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2024 06:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B767191F67;
	Sat, 16 Nov 2024 06:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcfKbr6x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF5A372;
	Sat, 16 Nov 2024 06:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731739298; cv=none; b=g/ougazgrBi2I+cMYDWPKkEbCrxtgUTfGUSRcNeYslHvXWQpLksLy+jBvevSsxsmVLcY3hp0xc08K4SqMsHJ8y+Kdm+QkxQTLURNySqHtQ3ABIaRs+yBp8LhzXIeKPok68V3bJRF6jEHz2R0YqX5Bk9kwOaRXaewVPtv22IsOXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731739298; c=relaxed/simple;
	bh=VulH+KhWYNszXMFW/vC/4n64rTJ2zXIHgSLHDn9JUZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rrYo1KwQo0K4ykoZw0Q7THiJ3C/LnUD+Gq5JWzupQQ5oW4arGt50vDTGatj73HdZTWQ5DwVrnw3NWP3eREcnzbgZQgn+7bbWwH8ac25nHFr4nDhYFo1zYTbnw5olCcA1hTIaOv36GYiOu8esmPjlEpZtzOPt4RNRxn2d2nVjyGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcfKbr6x; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53b13ea6b78so464600e87.2;
        Fri, 15 Nov 2024 22:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731739295; x=1732344095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GSqB1ZG3zrm6HjbgNzhu/Y0VVIHRXr02wctn/d0ReOA=;
        b=jcfKbr6xgSDiK2OAdX+BCeiQx+j7Vo3b0a/xQITaDq7DZRaNpUmSe+klV53Vaco7pC
         ZCNqr2rOKsD0X+kt5imVUFyxIAFUeqqyzP2nTz9nvCVngmMbc/kTYfw2bfLSACqjAIVo
         pHoJs4V9tjfP+BL8ErJ1Hi+bUxBez3CLS2eup1mDSYDKp6P5S3N9XFMU1JmreKqazJKx
         5ha42t8gp0ToR8+WNcAkJaESvIOIF9WDrxhiZYhkQZ7Y9GaWGG5r/e8TvmwfAHZyVSWO
         1iiFqCBob35XFUs6fgPcYAVGiYF7dS6aTwpthEw8MbD8iWJCj9UvOEJmBXf4u7a268d4
         E0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731739295; x=1732344095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GSqB1ZG3zrm6HjbgNzhu/Y0VVIHRXr02wctn/d0ReOA=;
        b=SlBknNzpbgj3aTkCID8wknoTSqUqtnUe8nX3guJJSTwC3MuNq2XXMQAX2iPaPeX0uM
         /oXJKgPyDC0YRUyqwiWjEajMeBwbmTfvOAF7FhO4C2TifX6r1yJD3fmZwnMQbqdWoxxe
         tb81Q9a/wgoWOFyE0Sy8vcyhJu2Ord+Nz+s+gpK0/2kfqmrHKVQPgWZvztBEr6ILLfQg
         YxDP7jmL12YKlXOZiI8bzvWvauOwrXaroey+JyN05YQFZG88xagiybkhWBLbM3gbinvy
         Uq085kTZgo+ZL4OSgFu5klwIQcRKL9DxGblzPM3DmMng1yDzWszpr635e89lnnGtzqy3
         v3og==
X-Forwarded-Encrypted: i=1; AJvYcCVpATFud11tYXg769JMwAo9PgeG8vVVWzMg1SYM0repq/Vrtes+yM0/usNmkwRVZjQ5fFHp81O4zgsjfpRk@vger.kernel.org, AJvYcCXfE71plRIWYVfD08OsyFHMk7rZcvRDyBUBQrVqDRdCCkuQg3b60vphTaOYebT8CvviI7NU2RUKiJ13AfGX@vger.kernel.org
X-Gm-Message-State: AOJu0YxFCCr5ideFpeKTYpVoBme5x5UEwX3UE0XuL3dh4w6UjC3EuPK/
	OKBmFXkWwYfs6qRyvrImG16LDSCbUvLb4OhJheSPgx07kVtT/B/q
X-Google-Smtp-Source: AGHT+IEzn0yB83UQVNZL0IDB0dCXekHn4LMseJyTAqJdIMUxf2tyGEnb4+/KmfUfeih70Hkaj9jtYA==
X-Received: by 2002:a05:6512:2316:b0:53d:a556:535f with SMTP id 2adb3069b0e04-53dab3b16f7mr3517405e87.40.1731739294700;
        Fri, 15 Nov 2024 22:41:34 -0800 (PST)
Received: from f.. (cst-prg-22-33.cust.vodafone.cz. [46.135.22.33])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df4fc07sm262480166b.44.2024.11.15.22.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 22:41:33 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: delay sysctl_nr_open check in expand_files()
Date: Sat, 16 Nov 2024 07:41:28 +0100
Message-ID: <20241116064128.280870-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Suppose a thread sharing the table started a resize, while
sysctl_nr_open got lowered to a value which prohibits it. This is still
going to go through with and without the patch, which is fine.

Further suppose another thread shows up to do a matching expansion while
resize_in_progress == true. It is going to error out since it performs
the sysctl_nr_open check *before* finding out if there is an expansion
in progress. But the aformentioned thread is going to succeded, so the
error is spurious (and it would not happen if the thread showed up a
little bit later).

Checking the sysctl *after* we know there are no pending updates sorts
it out.

While here annotate the thing as unlikely.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

This is a random tidbit I found while looking at the code, I don't think
this is a particularly impactful problem but definitely worth sorting
out in master.

I doubt it warrants backports to stable so I'm not cc-ing it.

 fs/file.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index fb1011cf6b4a..019fb9acf91b 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -278,10 +278,6 @@ static int expand_files(struct files_struct *files, unsigned int nr)
 	if (nr < fdt->max_fds)
 		return 0;
 
-	/* Can we expand? */
-	if (nr >= sysctl_nr_open)
-		return -EMFILE;
-
 	if (unlikely(files->resize_in_progress)) {
 		spin_unlock(&files->file_lock);
 		wait_event(files->resize_wait, !files->resize_in_progress);
@@ -289,6 +285,10 @@ static int expand_files(struct files_struct *files, unsigned int nr)
 		goto repeat;
 	}
 
+	/* Can we expand? */
+	if (unlikely(nr >= sysctl_nr_open))
+		return -EMFILE;
+
 	/* All good, so we try */
 	files->resize_in_progress = true;
 	error = expand_fdtable(files, nr);
-- 
2.43.0


