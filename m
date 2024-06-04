Return-Path: <linux-fsdevel+bounces-20968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 466968FB811
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 17:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E999328452D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 15:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A026D14885C;
	Tue,  4 Jun 2024 15:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+JOkelR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856F7144D23;
	Tue,  4 Jun 2024 15:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717516404; cv=none; b=g6yN8xwFR7E0R2XF4VstYZGHAPTa8J3E65raf9uqLEPAzoMV7meEb7pBFr+u8rKwK2kngc9kdTu2I+M4zgWk5WCTXB7DTEnMRssbGXkCOUMlMnDerL6d42CZ4GIPsGCu5giSDpd6SjPjLxIPQNwo88GzhOADd++oXrZb7zW31Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717516404; c=relaxed/simple;
	bh=kAUbSWZu/OF2JsDzEwfqVSaWjodhEmkXT4WzF6JA3HQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LolR3Ah1e3BMEKfqi7qIxYFCQDGZXbdcsXPawudspdX1xkqky401y0Fw6RvXQ95mx5K5QU+wJERIdDEcswNXCL3IJplO/On+aq1OyiAnyKRqLQnyfZe7TtHZ47hnV5uQo5tCS5iKDc0U7UjQwa7K/tzZ9qM5eSOa8Mp4aBYsPyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+JOkelR; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57a30dbdb7fso1789939a12.3;
        Tue, 04 Jun 2024 08:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717516401; x=1718121201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X41l9HlS1nc5iU7TqM8UMs4TqS7XVR3m4QqEEfH5sx8=;
        b=B+JOkelRjgL6pV60yTJExdwecOoQOdz8XNANEsgfq3tTF0PWw9kkOArOYmp3u7RLU/
         +CBt2RyK754SrjdcFAHuhPO6O8dxquvbRsElggaXkWsP49fj69wibvxpTnWQQjwsZwng
         /nrJSP92Bg9WYcdwGX67H/UFVxza+nbZ7sQc/WpXlqxf0VhLE2ZU/ldG8p/5bAHDn9EJ
         jjMnh5qZYvDL5JLqSOMwoQp6pOzVpfd7faPySzV/PQll8fEQ7TjiHKipQhrlMiMJRY/v
         TyqB8Q92ZQs3PPBg4o7VWzuFacWCir7AZSzigYNWKLb8ZGCk4eWdUzXGA5sQzxrOyfFI
         VYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717516401; x=1718121201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X41l9HlS1nc5iU7TqM8UMs4TqS7XVR3m4QqEEfH5sx8=;
        b=r0f96GGg5fxpbadhjffBI/aCxqKimZI7NQxQ+y6ZCP1J3lsPl9+65St7PxZrrCCLk4
         144D/oA0ORLHpxj7yyc4pqOk2FfuPlg1T35CRDIbuA/22ecPGRL5RgUInS5RorFQJJob
         /d/V6gj7VYSDDYBX0gy3rrINdIbUNwLEjBWA6xF5n/lqXWwXRcnsE+WcNghsMt3rOHjB
         avfYeUujiC2PzvefXFhySj5C/VNXs9X3ViyJ7yj2DOHgN4vtodtWl7dhUXC7YY3r+pCp
         /Ds/l3WjwBPGzaAMue5hCoGz984Bb6I/x76aHx8AtS7W9Gx9I9eDcfRdeztYWWEtCqXk
         1Abg==
X-Forwarded-Encrypted: i=1; AJvYcCWPWLgeXgKsPODvZDAZO3b5/ODqTRJjxCHrRJK8+tGHv4ezDyBjw7voLSeQ+8PFvXf0MzUssvwKdI0gsqfwpm6FHzkUaFIMCl345t7khbvttNJHltCxdek5tzBZFEeSH/LAsEL4P7Pmr4cSfA==
X-Gm-Message-State: AOJu0YzZMY1dcCdYN3mn/6TTftP9OqQhl8K0Sxc2QA3jyNpzQ1DKjI6F
	5aAA1DmJvCXJj8T9pg8TwC98at/F7uGlcoAqqAtN/i1ZivBLp/as
X-Google-Smtp-Source: AGHT+IFAkRcSmB0oQofZuTC56FBTE9aVGJAt+c/6xgXpiXgjfNI7f19R2PmjUc3upWoKhiksr2jvjA==
X-Received: by 2002:a17:906:aac1:b0:a62:a63c:18f0 with SMTP id a640c23a62f3a-a681fe4e408mr788174766b.1.1717516400529;
        Tue, 04 Jun 2024 08:53:20 -0700 (PDT)
Received: from f.. (cst-prg-5-143.cust.vodafone.cz. [46.135.5.143])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68e624db7esm423380066b.66.2024.06.04.08.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 08:53:19 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 3/3] vfs: shave a branch in getname_flags
Date: Tue,  4 Jun 2024 17:52:57 +0200
Message-ID: <20240604155257.109500-4-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240604155257.109500-1-mjguzik@gmail.com>
References: <20240604155257.109500-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check for an error while copying and no path in one branch.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/namei.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 950ad6bdd9fe..f25dcb9077dd 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -148,9 +148,20 @@ getname_flags(const char __user *filename, int flags)
 	result->name = kname;
 
 	len = strncpy_from_user(kname, filename, EMBEDDED_NAME_MAX);
-	if (unlikely(len < 0)) {
-		__putname(result);
-		return ERR_PTR(len);
+	/*
+	 * Handle both empty path and copy failure in one go.
+	 */
+	if (unlikely(len <= 0)) {
+		if (unlikely(len < 0)) {
+			__putname(result);
+			return ERR_PTR(len);
+		}
+
+		/* The empty path is special. */
+		if (!(flags & LOOKUP_EMPTY)) {
+			__putname(result);
+			return ERR_PTR(-ENOENT);
+		}
 	}
 
 	/*
@@ -188,14 +199,6 @@ getname_flags(const char __user *filename, int flags)
 	}
 
 	atomic_set(&result->refcnt, 1);
-	/* The empty path is special. */
-	if (unlikely(!len)) {
-		if (!(flags & LOOKUP_EMPTY)) {
-			putname(result);
-			return ERR_PTR(-ENOENT);
-		}
-	}
-
 	result->uptr = filename;
 	result->aname = NULL;
 	audit_getname(result);
-- 
2.39.2


