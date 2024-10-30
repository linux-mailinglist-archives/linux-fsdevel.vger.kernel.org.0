Return-Path: <linux-fsdevel+bounces-33292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 093AA9B6C0F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 19:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B41E91F225CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 18:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0781CC152;
	Wed, 30 Oct 2024 18:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUJn1DBJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F151BD9DF;
	Wed, 30 Oct 2024 18:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730312752; cv=none; b=U37rjr9hSiS1Cbmh0mo2K7eoOUWe/aMyrZ3b9Y37ojVFVBP+9/G6L/1oaOxc+MF+QNodz3FoFpR6nUQfiqFBIlUm/xJIhYkb+W3ZQEMKQYMeB3UL1CL0uWv3MO9x7u4OTrg//zKw4NsdzoasxUbrPOzHGOf4p/E4G9sl2gs4WEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730312752; c=relaxed/simple;
	bh=NHxp+POG47JxZdOeOYq5ZodzrSlAFfIp+98+cQE2Qas=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=jyj8ixyyK6N7Mjx8ePpALdPzUzeA5eOkAZgL6SVil3kHPfWUQXCeR7vRCZo7b6mf0kFKBap/sE7xt0JEmdb95b/ilbJnS+HYQyrh78KJzV9VsqtT8JBK39qtvjPnzF+E0mZqGMCv8q5EQ1Q2td6smEEeSwX/fsLxPtgig6q4JL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUJn1DBJ; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539e59dadebso197420e87.0;
        Wed, 30 Oct 2024 11:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730312748; x=1730917548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mn1i7qoZ8NMfOBLftMvEfbMqW6KLf/BKi0sKeBQxk/k=;
        b=lUJn1DBJTBRKSkzuAFyJZFuMdtv3pRf3AqodR67271eU0eLUkG7rU/KnNV8dnvnJTz
         P1bQ2njdgrRos7yv9NPqXicoXkizevuegEZIT6WwItd+2zGoX/B06Rk0TofCZmqwl8sq
         zG8ZVwGVjqr0Jw6LOsmclqSsXK4QYY5h/DVj3oj6S7Z1RF6YjmY2aXTs8aoStIMbVT7Y
         ePT3qmGWXwfF8CVWm2ilfREsR2mXiwt9ZvM0kq7Hwq4SCQGoaS1BzC5yu70tBwVvJUrz
         Hbr6ejlobcH0lRPJrXt27RTzLgnhKFsOQuQHkzovXdn/N1DFJ4j6L0cHqAU9znj3Pj+c
         uWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730312748; x=1730917548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mn1i7qoZ8NMfOBLftMvEfbMqW6KLf/BKi0sKeBQxk/k=;
        b=LpE23Aombs6j3Nym56L02j8Lo5mnnY86PVJdguEaJ9ouWwqBRQasqSNm2hYx+0Jqi7
         z2X807YVrdr1PmmcBCK9qcyb1HN8Awu8YwMZ1gbk5H3M3FsbGvfc0fJn/7Bws4Y5lQQ+
         mX/hr/7lyYhME7L3mnioxNehPPkxJxiF34lJS5AWSdjR88WyoEYf24YP2OQHfwdi7kRi
         DC2XP1iS+OsS2TnmmgIS1WeuXpz2/AeUESCjIH71Fwyb47Xl1AFP1YU2cYJw2zFwAH0B
         d4I+TBRqYQl0P0lAtTavB9jbF/CFfBnaPOvh+TFdHd6bNun4YAUEqjFzZuOJpbY0Yil+
         2IgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZ2xMXqry4KjDu5ZWxze4Chjp/1hHZCBY5sL0JcbH0RdfY9/UKcNJUo86Ldomz7AixIgHOmWl0G1NRmoMg@vger.kernel.org, AJvYcCW26ioAArzniWDApTGSlyukBvBemGsHmy8j5iOdOtwxjysDLVCaY0ldBtDaZUxBuvfg+u/P1vUSZaoWzUTp@vger.kernel.org
X-Gm-Message-State: AOJu0YxqCVmfShYtPT6Q2W77uNQWxao/FLIzLmoiKT8S97WOBKriuPrq
	i5CIX4+5cRXNhhanBx/8lwjHHYjY3EaczFr80snxFZNwSd5d983AiLcEbVGp
X-Google-Smtp-Source: AGHT+IGHVr7esO5Qax4uXPQVscjJOvQZjbcTjf2xBgTiQKVFHFL1ZaLzbdEEyUyAUWRnEv5syp3e+Q==
X-Received: by 2002:a05:6512:b14:b0:539:96a1:e4cf with SMTP id 2adb3069b0e04-53b3490f291mr8622627e87.32.1730312748174;
        Wed, 30 Oct 2024 11:25:48 -0700 (PDT)
Received: from localhost ([194.120.133.34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b47aa8sm16041634f8f.51.2024.10.30.11.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 11:25:47 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next][V2] xattr: remove redundant check on variable err
Date: Wed, 30 Oct 2024 18:25:47 +0000
Message-Id: <20241030182547.3103729-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Curretly in function generic_listxattr the for_each_xattr_handler loop
checks err and will return out of the function if err is non-zero.
It's impossible for err to be non-zero at the end of the function where
err is checked again for a non-zero value. The final non-zero check is
therefore redundant and can be removed. Also move the declaration of
err into the loop.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
V2: Move declaration of err into the loop as per Al Viro's suggestion
---
 fs/xattr.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 05ec7e7d9e87..fd4e3ab8034d 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -1005,9 +1005,10 @@ generic_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 {
 	const struct xattr_handler *handler, * const *handlers = dentry->d_sb->s_xattr;
 	ssize_t remaining_size = buffer_size;
-	int err = 0;
 
 	for_each_xattr_handler(handlers, handler) {
+		int err;
+
 		if (!handler->name || (handler->list && !handler->list(dentry)))
 			continue;
 		err = xattr_list_one(&buffer, &remaining_size, handler->name);
@@ -1015,7 +1016,7 @@ generic_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 			return err;
 	}
 
-	return err ? err : buffer_size - remaining_size;
+	return buffer_size - remaining_size;
 }
 EXPORT_SYMBOL(generic_listxattr);
 
-- 
2.39.5


