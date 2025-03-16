Return-Path: <linux-fsdevel+bounces-44150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C32FA63802
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 00:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50471188D66A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Mar 2025 23:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18701A23A5;
	Sun, 16 Mar 2025 23:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9AQV3b9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC12199E94;
	Sun, 16 Mar 2025 23:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742167474; cv=none; b=K3IaixsDnsJNsOrKirQwdXagRxi66pw6G0k9aTRiwznx6faMzTSQgmRIiNh9lZbkzeeefBZj5CbALN2JRWsCFfX51QBF91qNICox8rhj/uo2+TY3NViTrpu+V5NqSHsQ2Fu5gMpl6ZK8cBcfhwR7mreuRKp3Ucbho0IChVC7UoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742167474; c=relaxed/simple;
	bh=o8eQgeGPtZihVG/PijoiUznJGFjprjCaGiX4A/YJgLk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hEs4bn82UH2XjtikPtjTx4JFa8vPlvchsSpZ5UdMKX/bGSesxq6U4y4+qbmlVexsju1D8EMHf4RTqzD6l/pg4BwPY0CwHsBuGiAuZLk0OIxLzagJYlHxgJjya9aPYXlXV+rN0P9jTxv5P9QiKArrdIETh79YbbVVAK/r/9vAuNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9AQV3b9; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac339f53df9so93886266b.1;
        Sun, 16 Mar 2025 16:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742167471; x=1742772271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iox79toLFRQ4duXu/fplfKE03Az8gPUk7RB9gwhhD7g=;
        b=e9AQV3b9XmV18W7xYGwVY2WpGTSjNPhgxKG6ADKtc4S8denShktIuJ9YOZTtgCG+uR
         rPWLFRpJsyW9ce3IHQgu14U1Rylzy+08RsptVZlkLn2F6TjNmRGWfmGUhoOSyaecf+WM
         mwr+3SgG31oElpj3SSoGLvOSjqyKjJ89GZPVk5+uuXJNtEhOyN5U8Mtq7gu6OuZiXKYS
         0DFbPwP6GO6sc1SvsY8TZSUnjCi77aRfjQu+ub6qgEbjn4CJQI3oKqSl9/H+yCXVcY/2
         bcvCeWzBDjL21m3dV1SNITQu2KdDGqv7QQwPZ32QZKw2Sl0m8dOcTo8W6TbzbVO1lyhU
         MDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742167471; x=1742772271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iox79toLFRQ4duXu/fplfKE03Az8gPUk7RB9gwhhD7g=;
        b=CEeJfGiptNnJiT7n1j/BnETO0cgien5eEY+aEkG1QP/BKR7ga+mWEdgUUAm9NcdRZu
         ZAh9ppYbEZeVzCYfO82Nx2zjpsNNPRweVwlXwuvsUEnlElh+qYCWPcGDVFC4JrdGuJxr
         S06whBswlhIZNUuVMY6YSsmOBPcE8ufi89UOGAKrgMYM/CqSx6RLYXOG+0xitZcdgS5+
         0NEdkZvI/y2GbbK49IFPbER7oOqfrgFlwS+obaCvsG5kFCtoddeeYQJMkcbasXG5JPEO
         6o7Iz8XGAzPxTLNFe7uESNgS4FRc6kr1q+BBOwTer6yw960nyWSYLpvfZSk5lzPaGCoG
         /OlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQziBprZ0/j2L1AXz/GemDqztw0r9SNx2Mnn7Of73rtru0HT3nXqhJ7hS0/EAfaMFMGoDmW+cVwZgqbpNn@vger.kernel.org, AJvYcCXSRTKPwF+ymfQFXz84wzg46UYGsMOSbHtINHesjjq1pfVckIaGfcuOOXVa2bCH5PwmO2nR4tt0PhxmsocJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn4it3D2qZ7zuADVQqMpmAhmBijYTEoLvUxt7fpk/EarqkYlZY
	fWV3xBraI5MSqhQg8JS5gO9AnNqCr6PLa9NOfnX6ZPwcFk5+E9IxxCIhfA==
X-Gm-Gg: ASbGncvko8jErQ+fVSJlTAH61j46/6aaff/cnWMNeZTWPhozp8s4I75AMmuEjCue7Fl
	uZxaPjeiEBZeH9GzyK2UqSjd74S2FQUB5IGFS7ZCGwMFP8GamhjSEbo2S/+GC55xo8n7BsI9jbo
	KE09D7W7U7p9PY94V+l7V6onH7XJm8I1r2qU81W5ZcA9eaURxAJcbV54YHxD0Ix5lKyQIxSy4+p
	N8LSXT5B3bD3Q1n+3KRApND5vithIHd3U4bBQzOQffrgAuAiSJwOgmiXDNkjujkeAVg4HhSVA6f
	1pi+bnOuf8SG/4jv7fxHN9seEBUyXzxTLIYTqKHr3s4/xBQuYCw5nvNEjjFyjlo=
X-Google-Smtp-Source: AGHT+IF76w3efXZamZ5NhBRCQp+3Lt0vIz0OUy0BmgkcVmcfWu8K4VwYwvb1g+lW7UM5OazH+J1Weg==
X-Received: by 2002:a17:907:9694:b0:abf:6cc9:7ef2 with SMTP id a640c23a62f3a-ac3303bc642mr1207601466b.42.1742167470629;
        Sun, 16 Mar 2025 16:24:30 -0700 (PDT)
Received: from f.. (cst-prg-23-176.cust.vodafone.cz. [46.135.23.176])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314858a8fsm549984866b.80.2025.03.16.16.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 16:24:29 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: use wq_has_sleeper() in end_dir_add()
Date: Mon, 17 Mar 2025 00:24:21 +0100
Message-ID: <20250316232421.1642758-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The routine is used a lot, while the wakeup almost never has anyone to
deal with.

wake_up_all() takes an irq-protected spinlock, wq_has_sleeper() "only"
contains a full fence -- not free by any means, but still cheaper.

Sample result tracing waiters using a custom probe during -j 20 kernel
build (0 - no waiters, 1 - waiters):

@[
    wakeprobe+5
    __wake_up_common+63
    __wake_up+54
    __d_add+234
    d_splice_alias+146
    ext4_lookup+439
    path_openat+1746
    do_filp_open+195
    do_sys_openat2+153
    __x64_sys_openat+86
    do_syscall_64+82
    entry_SYSCALL_64_after_hwframe+118
]:
[0, 1)             13999 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[1, ...)               1 |                                                    |

So that 14000 calls in total from this backtrace, where only one time
had a waiter.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/dcache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index df8833fe9986..bd5aa136153a 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2497,7 +2497,8 @@ static inline void end_dir_add(struct inode *dir, unsigned int n,
 {
 	smp_store_release(&dir->i_dir_seq, n + 2);
 	preempt_enable_nested();
-	wake_up_all(d_wait);
+	if (wq_has_sleeper(d_wait))
+		wake_up_all(d_wait);
 }
 
 static void d_wait_lookup(struct dentry *dentry)
-- 
2.43.0


