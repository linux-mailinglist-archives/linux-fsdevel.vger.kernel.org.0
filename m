Return-Path: <linux-fsdevel+bounces-19456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 313408C58D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 17:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B84C61F22249
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 15:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFFB17EBAD;
	Tue, 14 May 2024 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ynDfwUYW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DE417EBA0
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2024 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715700954; cv=none; b=bjb3gbUOyWpsa/HRl3chIzSOiduS9M8kVYMFCVisquHO3Dy4P9vRaRLBVbupXaMYNNXfRE5Rsd9F2kpxPwMumIjEQzI3uXGWv5GGZ1skIDVJuay4536D7Htf6pXnSRor1a7rvnJ7IJltuTEnQ818y3T1YI50bHexop8NrB3LrFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715700954; c=relaxed/simple;
	bh=tyOLfaPN+vxyxmvRN25LjWKTOxGw/TP319a6bq49tsk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QBK2J8qTiYm+IvK4e1LERjELFime74Xhrp/NGdoA8dAwhs0fe1erHCfbTrJwXcWk2Fmny5Fr+3vzAMB//YGtShxThG6Q7SON0pWuWI24QdawL+cwJ3fc7r/KnQ2Ygm/gO4rwt4Jw2rZQrO0pQy8RwlMxbM0MS3utzTwiIyIyghg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ynDfwUYW; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be8f9ca09so99430257b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2024 08:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715700952; x=1716305752; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8h1heic/WIrKkqKhGl4cPRJjsIzjvgjOs1wUbMcKuFY=;
        b=ynDfwUYW+cvf9+xm+MI9Ojrd1a3pWQ1eMwSiVDRgo5hvJ34CY0ajJCLvQrnQcbxnzB
         F/jsiZJA1q3LkwABfDAzGIxBZxQqRhseh735q/W1Ol8QrWoMPwPw19Na8M8A7BGnqTMw
         d46WVyKjN1JBjt+HfRZGkgjgMn6BwOMRylL+jWHSkIpzbYbEOgsDZ9GFl0pnG/FT4mPc
         Ea8uYOOHvFr+ZXyc3gkd95KmZaqGv+zpQMnML9cvIYHR70ekfbY1PGpvsP3CBG/GgdyE
         WXCaJnArwoX2BTUJscw9lUkPpRkraFiHnQE2f1FbbZRJ9UHg/mIrAxXZZ65GZEO9uybv
         6fag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715700952; x=1716305752;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8h1heic/WIrKkqKhGl4cPRJjsIzjvgjOs1wUbMcKuFY=;
        b=eFlbJoNthSwZ380vrei2QnEl05ZjjQNw99E7ai15iRi8QvXH8qeHyp9S/l/PN9pXO0
         ps7HIyP+wBVanv1YplZ0tJvfre+48Hmugt+XsX77XYWehvU1aGXYWtVQkFOhWjAo+MgX
         KfRbml5QaXeTkWwNwe0qk59kON7BmcdtZg1rLBobJvAZj62ap83NN4t8CgFxNhEYVZx4
         3jgMzDzVV/10vToipbB1EdCo+2/J1QMsfZ8DCo3jtYtP2wHy9BSAW5WfkE/8HIP+36aT
         dwiCVryx62htIZYLKyinfB9bbgJrcVwz5y/kxiFnCV0Rj7Hr1Z8M/rEVrCkeAbHPIFPR
         wtfg==
X-Forwarded-Encrypted: i=1; AJvYcCU94xciMjc1pugGcpCqOSybpUgl0I0vq/9z8BKHZ68WAlRNy6cY2CTW+yXiRIDr3v5PiZdnCvhmUwAyz1x2keaVFlhUGnx40PmRr35Ctg==
X-Gm-Message-State: AOJu0Yylm04bzDYlj9OUSEzgit//20bCam9xvdaIDMuv8nm7kL3ef/Ks
	AmU6ohrFYW04Fm8GlzMCZRUIg6Qc0SNjADJdwcM1XB4eAaIFdyPF/nmM4el1bawBBTfJlchMS4D
	XJw==
X-Google-Smtp-Source: AGHT+IHHSpuTeQek++mFAxLfFAuVppDkYeHqFcKCHk5mMT50eANs346lK6L2OcocmRuT5s6DVjOePQGuj8k=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:e8f6:c5d2:b646:f90d])
 (user=surenb job=sendgmr) by 2002:a05:690c:3802:b0:61b:e2ea:4d7b with SMTP id
 00721157ae682-622affa5943mr35383047b3.1.1715700952239; Tue, 14 May 2024
 08:35:52 -0700 (PDT)
Date: Tue, 14 May 2024 08:35:32 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240514153532.3622371-1-surenb@google.com>
Subject: [PATCH 1/1] lib: add version into /proc/allocinfo output
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, pasha.tatashin@soleen.com, vbabka@suse.cz, 
	keescook@chromium.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"

Add version string at the beginning of /proc/allocinfo to allow later
format changes. Exampe output:

> head /proc/allocinfo
allocinfo - version: 1.0
           0        0 init/main.c:1314 func:do_initcalls
           0        0 init/do_mounts.c:353 func:mount_nodev_root
           0        0 init/do_mounts.c:187 func:mount_root_generic
           0        0 init/do_mounts.c:158 func:do_mount_root
           0        0 init/initramfs.c:493 func:unpack_to_rootfs
           0        0 init/initramfs.c:492 func:unpack_to_rootfs
           0        0 init/initramfs.c:491 func:unpack_to_rootfs
         512        1 arch/x86/events/rapl.c:681 func:init_rapl_pmus
         128        1 arch/x86/events/rapl.c:571 func:rapl_cpu_online

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 Documentation/filesystems/proc.rst |  4 +--
 lib/alloc_tag.c                    | 42 +++++++++++++++++++-----------
 2 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 245269dd6e02..97d76adb1ecf 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -961,13 +961,13 @@ Provides information about memory allocations at all locations in the code
 base. Each allocation in the code is identified by its source file, line
 number, module (if originates from a loadable module) and the function calling
 the allocation. The number of bytes allocated and number of calls at each
-location are reported.
+location are reported. The first line indicates the version of the file.
 
 Example output.
 
 ::
 
-    > sort -rn /proc/allocinfo
+    > tail -n +2 /proc/allocinfo | sort -rn
    127664128    31168 mm/page_ext.c:270 func:alloc_page_ext
     56373248     4737 mm/slub.c:2259 func:alloc_slab_page
     14880768     3633 mm/readahead.c:247 func:page_cache_ra_unbounded
diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index 531dbe2f5456..777b5cebf9a4 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -16,44 +16,51 @@ EXPORT_SYMBOL(_shared_alloc_tag);
 DEFINE_STATIC_KEY_MAYBE(CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT,
 			mem_alloc_profiling_key);
 
+struct allocinfo_private {
+	struct codetag_iterator iter;
+	bool print_header;
+
+};
+
 static void *allocinfo_start(struct seq_file *m, loff_t *pos)
 {
-	struct codetag_iterator *iter;
+	struct allocinfo_private *priv;
 	struct codetag *ct;
 	loff_t node = *pos;
 
-	iter = kzalloc(sizeof(*iter), GFP_KERNEL);
-	m->private = iter;
-	if (!iter)
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	m->private = priv;
+	if (!priv)
 		return NULL;
 
+	priv->print_header = (node == 0);
 	codetag_lock_module_list(alloc_tag_cttype, true);
-	*iter = codetag_get_ct_iter(alloc_tag_cttype);
-	while ((ct = codetag_next_ct(iter)) != NULL && node)
+	priv->iter = codetag_get_ct_iter(alloc_tag_cttype);
+	while ((ct = codetag_next_ct(&priv->iter)) != NULL && node)
 		node--;
 
-	return ct ? iter : NULL;
+	return ct ? priv : NULL;
 }
 
 static void *allocinfo_next(struct seq_file *m, void *arg, loff_t *pos)
 {
-	struct codetag_iterator *iter = (struct codetag_iterator *)arg;
-	struct codetag *ct = codetag_next_ct(iter);
+	struct allocinfo_private *priv = (struct allocinfo_private *)arg;
+	struct codetag *ct = codetag_next_ct(&priv->iter);
 
 	(*pos)++;
 	if (!ct)
 		return NULL;
 
-	return iter;
+	return priv;
 }
 
 static void allocinfo_stop(struct seq_file *m, void *arg)
 {
-	struct codetag_iterator *iter = (struct codetag_iterator *)m->private;
+	struct allocinfo_private *priv = (struct allocinfo_private *)m->private;
 
-	if (iter) {
+	if (priv) {
 		codetag_lock_module_list(alloc_tag_cttype, false);
-		kfree(iter);
+		kfree(priv);
 	}
 }
 
@@ -71,13 +78,18 @@ static void alloc_tag_to_text(struct seq_buf *out, struct codetag *ct)
 
 static int allocinfo_show(struct seq_file *m, void *arg)
 {
-	struct codetag_iterator *iter = (struct codetag_iterator *)arg;
+	struct allocinfo_private *priv = (struct allocinfo_private *)arg;
 	char *bufp;
 	size_t n = seq_get_buf(m, &bufp);
 	struct seq_buf buf;
 
 	seq_buf_init(&buf, bufp, n);
-	alloc_tag_to_text(&buf, iter->ct);
+	if (priv->print_header) {
+		/* Output format version, so we can change it. */
+		seq_buf_printf(&buf, "allocinfo - version: 1.0\n");
+		priv->print_header = false;
+	}
+	alloc_tag_to_text(&buf, priv->iter.ct);
 	seq_commit(m, seq_buf_used(&buf));
 	return 0;
 }

base-commit: 7e8aafe0636cdcc5c9699ced05ff1f8ffcb937e2
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


