Return-Path: <linux-fsdevel+bounces-40996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEBCA29DC2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 01:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C8D31882A1E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 00:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7929DBA27;
	Thu,  6 Feb 2025 00:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Stm7bnkb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ABD23BB;
	Thu,  6 Feb 2025 00:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738800074; cv=none; b=i10te8eVofy8Z8DJDddKSeb82N5y185r1/b4MmDnu5/fgWCWQ8Kwm1VTd//dAucryTh2kUSkIfGoCgz2qOkcHVzEs7xQmfcE7pDiSOuKDiurQEHB66Aj4/oEIumqnh8WfSCYiRremlTTq+I7FEfHfJhfMCdYJrg7b57agFezHV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738800074; c=relaxed/simple;
	bh=hd3ovGCH+17/SzLA1mhKtfjiaqNSAaKsaCShd3W4CrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZR8Xt+j5tVB4nk8RHNPiodsgOFP+Y4Ln4Kv0SnxYq5LYdsgl97V3ussYNA5s93BYLYw70Smw5iaX5BGOuqLjh+IwVT6Oj9vby5lLi+4BtdlhmuB+zilGvNaHNhPSceSJHVZCQeSPc5dUZhGHqKzPEL9uiBPNfpqIt+X2Otkgy5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Stm7bnkb; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so788036a12.1;
        Wed, 05 Feb 2025 16:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738800071; x=1739404871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uXojsIFnvoXxK5/ugaHJriavK6SmalT0dz3QwgLstS4=;
        b=Stm7bnkbNTSvfa4azw3VLY2sXuFAM04z96HfDer3OYF1GKN5Ox0ZnTPzFUZCWEQfi7
         9Wn9utTwKtg3MTWE8l4GZbaVoGgGTn1/kCWVKKW7DS38H+smb39en5h9v/9iU5ze4QPE
         XcpVMCR7DYL99MMnWgcDURGBzDwPSU7hb5x0hZ0fiiwPW81qk8eOvLRcncOmZ6u1AjbP
         FSlnk83BD/0vLVV7XxBW0jJIUosGIp1/QkFjS24wh52Z4NJmfA3QwCP9FumfvHIcse6s
         lk4LDkX1dYBrs6m1v9EwbwmsmKL9zlJgpsIZdS29wE/zdI0pma6TogQrowW8sErq7+nN
         XLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738800071; x=1739404871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uXojsIFnvoXxK5/ugaHJriavK6SmalT0dz3QwgLstS4=;
        b=KHgiJl/VOMiDe8mZ2gaIh6AWcAaJM9/tAZOtsz2nUJdFD5TTUf5eU/z1sg3P0q3TBU
         YayXdM2cElYVqgOk4fDuaAkHXoVrfds1a5ms6hKxolzITHaGzpJ1HN+2DNEiY4NSIRVS
         YWezk5gIfUOTb+cPCBGaXUPlTd/lPRAtvXWflk2lzi3ephIK7rFuC2mvOebc68I2Wvou
         uKDm2kjFoussM0lctBqJUEQlESbldb6dJeBb3W4a6Hrac+V3UnFs0g980e7p1z0QAG2j
         IT4g2rIZHAnT/cC/jYqHmwrIvParVkWZiaYHDDEG34tc7b+Qf57qQTbarGb9TquvwpFh
         HJKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQ5Vjkh7n+QPnBbTktPSN+sR9mfJsD12Vqey9xikhUXFAFgXUJEJuqAYt8zriRGYDICD6JQ5cdNEJQgEl0@vger.kernel.org, AJvYcCXdiaE7xqPFNIazSJwfYPy3m5qFNSyubGhu1cymyjw1aXuVku9PCB9exlKHmLe93HJA8MkwPUv+g1FUzNYA@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi2wL8S07aShWL1UyjDoBGOQzHmDHkVBMVkKZmV3WBEeqV3BFp
	/I694d/6BZNKvzbnexqjQUGYLADsoagxzADj+hJKBa7yrGD6zz7P
X-Gm-Gg: ASbGncuUqFTi73Fd+XGac8CpyuXpCKDW2VrKpU70Oq2iu92HVaRGgk03ByCxiDmx/Mj
	pFTw+2ce7IGDHzUSuviTHT++nHP/uMCkTBAExF88gomDWYSGscKlDY4XuOUlEnTaKb+VRddXDQA
	xx3fJjLL0GfmdLKcGBXFF0d5vzn7TdnGP4y8b1G7CNH61nwzj2Mwrh6LiIQq2AUglcJeek1Dzj6
	NDrdhLSd3sQ0vUOifYAPw1axJVQp+d9TF+783lIYDV4M1jgltWOMkAYUstq8jL8Hu3/0nGQmhHy
	IZuQcfCOznzGsO3mEqGDAhpdUopYtZQ=
X-Google-Smtp-Source: AGHT+IFgfeOEwR7VAYcDaFbR/ZCg2ogD+q93Z/2jNTbR/1vbcb0yq2jzp4NwjpqKVaeGZEFjJ23EQQ==
X-Received: by 2002:a17:907:2d07:b0:ab6:c4e0:2d18 with SMTP id a640c23a62f3a-ab75e23e9f7mr534534366b.16.1738800071015;
        Wed, 05 Feb 2025 16:01:11 -0800 (PST)
Received: from f.. (cst-prg-95-94.cust.vodafone.cz. [46.135.95.94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab773335252sm8179766b.131.2025.02.05.16.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 16:01:10 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] vfs: inline getname()
Date: Thu,  6 Feb 2025 01:01:05 +0100
Message-ID: <20250206000105.432528-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is merely a trivial wrapper around getname_flags which adds a zeroed
argument, no point paying for an extra call.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/namei.c         | 5 -----
 include/linux/fs.h | 5 ++++-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 3ab9440c5b93..3a4039acdb3f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -218,11 +218,6 @@ struct filename *getname_uflags(const char __user *filename, int uflags)
 	return getname_flags(filename, flags);
 }
 
-struct filename *getname(const char __user * filename)
-{
-	return getname_flags(filename, 0);
-}
-
 struct filename *__getname_maybe_null(const char __user *pathname)
 {
 	struct filename *name;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e73d9b998780..85d88dd5ab6c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2840,7 +2840,10 @@ extern int filp_close(struct file *, fl_owner_t id);
 
 extern struct filename *getname_flags(const char __user *, int);
 extern struct filename *getname_uflags(const char __user *, int);
-extern struct filename *getname(const char __user *);
+static inline struct filename *getname(const char __user *name)
+{
+	return getname_flags(name, 0);
+}
 extern struct filename *getname_kernel(const char *);
 extern struct filename *__getname_maybe_null(const char __user *);
 static inline struct filename *getname_maybe_null(const char __user *name, int flags)
-- 
2.43.0


