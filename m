Return-Path: <linux-fsdevel+bounces-20299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C668D137B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 06:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4595C1F240D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 04:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3721BC4B;
	Tue, 28 May 2024 04:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9FSdQeg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754D51BDD3;
	Tue, 28 May 2024 04:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716871020; cv=none; b=tlawZbhUtc8pvfyvLb5MG9xdgQPvWwzOyOGFFqgXkETmNwMimpJGJf/iMZ83jHtPAHYaWSMjQ2NsMnD7N/HgYxLPAta1fz0sVREezfUE569FpMXsz3qtrtxsgM98v9QGZzwwZIYN4hK7K8tBhUdLvCNp7V4UuZo+mEvAUjO1hdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716871020; c=relaxed/simple;
	bh=MS4B72KcEpFN4nMYnitg2ucbdTv03oWLHZnAIzFvHDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IVR0HiBSy9lDwiMEk4371+clg9ImKiI8GddRhk156ZoYG6uO8FwtIAxpBwQ1flnt61vWIiL2Y48d+RY8DTipRzpXfu54bXzbeJ7tNWWxvL15zCEYflN7tak2O/5VOy2eiVbdE8ImbyourgJUjKcd8mCx0ptl7xO6CZjlC0q/XC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9FSdQeg; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3737dc4a669so1967515ab.0;
        Mon, 27 May 2024 21:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716871018; x=1717475818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chqMLO0lJarOLrixR82N6SZNqIuZ4mrAeYapuhiOCdw=;
        b=L9FSdQeg/xyGCQoy4/wC7OHtM7HokV5NltLumj8h9SpU0xUv21TnlWSfbHg9HnP9/t
         wro3N9JgST33f7gRCCBZD88py+wN3wHT8UgzTdzYQvDMBPzr0kRUrUvGJutMC917D85L
         /L5f9oBM8ONOj1CDS5Jb/2VJRzqOIr798usP0ACC2OZ32mq8lzDWfNbvY23p4y69FMl/
         Xk4x6fr9M/s3oBFkM2OIyDI4YmsVWTL0ATK21ocCXGU3rG8IgfJrCtF6cSAikkBsCz0X
         0wZ8GwP8loIO2ap/vcWw1hdUhRdol7PCTzGCsgZYNzNE/cEpMSSJDQHr4AEsl2asMmQ/
         TqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716871018; x=1717475818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=chqMLO0lJarOLrixR82N6SZNqIuZ4mrAeYapuhiOCdw=;
        b=N/AuMmoN/tiiCdl35WFLX3BvsGUKrHMi0NvXfhvIH99SKc9O8J+Y8aEaPyJKWrLaBU
         un3HJ0GV+JCJu43/EiXJvHP0eNn4Gd7trmZEIku1r3biRU2gAWpn+SSqgRTjJTO/XfsS
         e5H4PN4ojImBr0dNtR3JK5pF6ODI3tbyhVDujEP6cZDZX5ToAarQJQ7C+1djlSd0ZlZe
         oNjnFi/z5knFjMc2E+Ds34DCbpuuT72qy0wT0S8mk4svgYwESn3N/BGVqAezlmCtCuFe
         wQve+3CX0ZXpG36RcIvcjJPKEEiv+QGc2lTb3HcjpyVBVQoccA0V+BIgEYfkeSG0LN0u
         j0MQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3EHIs+AUKQJ8Pa680zfQUXhtYZLFeD4rLfitDnuTF3ylqYxFyyc5Du4Ym4sNbfOiJMOgRd705hjlTlLk34fQ4WUnfIwXpFYtppN33DnMVcYtiO3Ai3Vhu6xeJcZLPxWtK75Wkg7al/OXM5Cwg
X-Gm-Message-State: AOJu0YzOtsDhlJwRn4NBrb+zr63sRFCGOvbGPZsc6n/E4yjsx7Vnhmnx
	u38qLvNLcAe+Ro+G2gIfsk+eb2kWBv3YvcRXDl2E6kTOoXkjhiXJ
X-Google-Smtp-Source: AGHT+IF1ZBdYjK+gjqWp+ChM5Z+O3AHYUHB2Ce5LIaX1/JgZu59pkf6wzNsKjEwpaznKI6EvnMkDjw==
X-Received: by 2002:a05:6e02:1a86:b0:36b:3af2:2349 with SMTP id e9e14a558f8ab-3737b282f5dmr135113625ab.15.1716871018602;
        Mon, 27 May 2024 21:36:58 -0700 (PDT)
Received: from fedora-laptop.hsd1.nm.comcast.net (c-73-127-246-43.hsd1.nm.comcast.net. [73.127.246.43])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3737d1468b7sm18013605ab.26.2024.05.27.21.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 21:36:58 -0700 (PDT)
From: Thomas Bertschinger <tahbertschinger@gmail.com>
To: kent.overstreet@linux.dev,
	linux-bcachefs@vger.kernel.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org,
	sandeen@redhat.com,
	dhowells@redhat.com
Cc: Thomas Bertschinger <tahbertschinger@gmail.com>
Subject: [PATCH 2/3] bcachefs: Add error code to defer option parsing
Date: Mon, 27 May 2024 22:36:10 -0600
Message-ID: <20240528043612.812644-3-tahbertschinger@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240528043612.812644-1-tahbertschinger@gmail.com>
References: <20240528043612.812644-1-tahbertschinger@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This introduces a new error code, option_needs_open_fs, which is used to
indicate that an attempt was made to parse a mount option prior to
opening a filesystem, when that mount option requires an open filesystem
in order to be validated.

Returning this error results in bch2_parse_one_mount_opt() saving that
option for later parsing, after the filesystem is opened.

Signed-off-by: Thomas Bertschinger <tahbertschinger@gmail.com>
---
 fs/bcachefs/disk_groups.c |  2 +-
 fs/bcachefs/errcode.h     |  3 ++-
 fs/bcachefs/opts.c        | 15 +++++++++++++++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/bcachefs/disk_groups.c b/fs/bcachefs/disk_groups.c
index 521a86df5e52..5df8de0b8c02 100644
--- a/fs/bcachefs/disk_groups.c
+++ b/fs/bcachefs/disk_groups.c
@@ -511,7 +511,7 @@ int bch2_opt_target_parse(struct bch_fs *c, const char *val, u64 *res,
 		return -EINVAL;
 
 	if (!c)
-		return 0;
+		return -BCH_ERR_option_needs_open_fs;
 
 	if (!strlen(val) || !strcmp(val, "none")) {
 		*res = 0;
diff --git a/fs/bcachefs/errcode.h b/fs/bcachefs/errcode.h
index 58612abf7927..a268af3e52bf 100644
--- a/fs/bcachefs/errcode.h
+++ b/fs/bcachefs/errcode.h
@@ -257,7 +257,8 @@
 	x(BCH_ERR_nopromote,		nopromote_no_writes)			\
 	x(BCH_ERR_nopromote,		nopromote_enomem)			\
 	x(0,				need_inode_lock)			\
-	x(0,				invalid_snapshot_node)
+	x(0,				invalid_snapshot_node)			\
+	x(0,				option_needs_open_fs)
 
 enum bch_errcode {
 	BCH_ERR_START		= 2048,
diff --git a/fs/bcachefs/opts.c b/fs/bcachefs/opts.c
index e794706276cf..e10fc1da71b1 100644
--- a/fs/bcachefs/opts.c
+++ b/fs/bcachefs/opts.c
@@ -378,6 +378,10 @@ int bch2_opt_parse(struct bch_fs *c,
 		break;
 	case BCH_OPT_FN:
 		ret = opt->fn.parse(c, val, res, err);
+
+		if (ret == -BCH_ERR_option_needs_open_fs)
+			return ret;
+
 		if (ret < 0) {
 			if (err)
 				prt_printf(err, "%s: parse error",
@@ -495,6 +499,17 @@ int bch2_parse_one_mount_opt(struct bch_fs *c, struct bch_opts *opts,
 		goto bad_opt;
 
 	ret = bch2_opt_parse(c, &bch2_opt_table[id], val, &v, &err);
+	if (ret == -BCH_ERR_option_needs_open_fs && parse_later) {
+		prt_printf(parse_later, "%s=%s,", name, val);
+		if (parse_later->allocation_failure) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		ret = 0;
+		goto out;
+	}
+
 	if (ret < 0)
 		goto bad_val;
 
-- 
2.45.0


