Return-Path: <linux-fsdevel+bounces-30739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1E398E135
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 18:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 182721F24383
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 16:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4760A1D130F;
	Wed,  2 Oct 2024 16:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsDtcZrK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9861D0F6F
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Oct 2024 16:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727888117; cv=none; b=E6cP0ngf6hNNqK6s4WhtT9D14n3VDPLnd4d2Ai0uSORglIYqtE3K9v3kVRYGmGDat3To0BEKpIbEAkK71env5oZPVpE7Zyv2JKSOET/sSO8Zr+/k6R+lMKkOd3qPs6a1+YugYiAOdx3BrYNoK3/CsMuss0n6J/HMkJJGd/jALVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727888117; c=relaxed/simple;
	bh=GVmbCVtfZnjYqSYEejfzaURXqzMI4CvteqR+q+WZbHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BlddWkpgbbdKlM3LVKs1WKD3TUyj7pW8ooSd8BkMGljYf3XUvD4bJF/rej1G5Ewckeb8RFnG65ufIGINBdsniNAgs3mD7b21l/Bz3B4+w/I2M1uD7Mhr7v+pvzl8XI8UaRN+05muTu+4oIVv9SEfuqUEfLN8llBgkfwzUT8d9TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZsDtcZrK; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e25d164854dso5977471276.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Oct 2024 09:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727888115; x=1728492915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayYt8HUs11at+3z73eOh+NfMxShVgyFsh4X25CI12eM=;
        b=ZsDtcZrKWbgQA3A94YsyOlOMvoDpJoS7eO+ii550jnGJVnTK/mIkLHmYLBLrDYs9sE
         MjMu3XF7s/hBID2ldDgB2tu7Qvfmi+wAvVSgVlKJ2JY9iJgmU28lkFx/f7pOP2OEUWn8
         2qBtjjiQeTT6VQSyDB/K4Y7jj8D3UewQQwXr0ugPmDU6oE+fP8hLKoLMGEhyDAu3rTxD
         dYLW9i9+8qfdkOl/OYO0FHQzqE5VnhpDjI43IeqKtoPzMAhwzD8U3MgW8bcCnwGi17LR
         DpdL29dVjuEk8qHLzCMBBc1dNbozgCYFE8APisbz9X5nBoG1sILZO9jy8dvutRbHlpX4
         aPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727888115; x=1728492915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ayYt8HUs11at+3z73eOh+NfMxShVgyFsh4X25CI12eM=;
        b=LoXWTqzvsrjvsBf8c56dwju0sVYrp/dgA/Ft+QPXg3mZWHkjnxZJBT9tuUcRhG8Jqj
         qRxtoejR9vmgINxtpNUiSe0vUG9yBRnGTUQLwNptuOz6pNE1F12lgUIBvleX0vn2VdnW
         Gp0wX375HGqM1NVdm+RNS9MTSCcSy4WnDV/Pbt/9L0f7JjXQNN9lJcNRmI2ewbVvPfEG
         XBT5j+E+8cVWOroqEHmreEHUi+RHZGHB37JupGHRFT5x2O3U9X0bYts2lKFReajWcxWD
         39QvHeLFpmcByGZkDeuAJMPPeRgUEhYtUwxnhvttbS/07FODArgbLlbT/S8GAk2+CLJo
         7yhA==
X-Forwarded-Encrypted: i=1; AJvYcCX0yG8AQscMxb6s4nSTzmGozj3U+ak/IKt+4yGs+PkHzh/GlQPWbYiN0bzu4ZMOKF/I+FE5fI5jVruYYYqu@vger.kernel.org
X-Gm-Message-State: AOJu0Yzklz0ZpJ5217pGGqg8kcSzN0LV3oirMsN+2lFgIdRmI0qjL/3h
	EfplHBKasLzMGlIqn1Rup+1Jp9Gz7WPSwlHsuXo+eYMfcJljyYtb
X-Google-Smtp-Source: AGHT+IH1qiAUfpE/+bVfMhhEatU8c4gDi/yaWzaQtR/fvKL06J+MYmB/NV5+3Xi4ga/ecqwJTaWq/w==
X-Received: by 2002:a05:6902:100b:b0:e20:805b:9678 with SMTP id 3f1490d57ef6-e2638434281mr3429055276.48.1727888115008;
        Wed, 02 Oct 2024 09:55:15 -0700 (PDT)
Received: from localhost (fwdproxy-nha-115.fbsv.net. [2a03:2880:25ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e25e400f009sm3993772276.17.2024.10.02.09.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 09:55:14 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH 01/13] fuse: support folios in struct fuse_args_pages and fuse_copy_pages()
Date: Wed,  2 Oct 2024 09:52:41 -0700
Message-ID: <20241002165253.3872513-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241002165253.3872513-1-joannelkoong@gmail.com>
References: <20241002165253.3872513-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds support in struct fuse_args_pages and fuse_copy_pages() for
using folios instead of pages for transferring data. Both folios and
pages must be supported right now in struct fuse_args_pages and
fuse_copy_pages() until all request types have been converted to use
folios. Once all have been converted, then
struct fuse_args_pages and fuse_copy_pages() will only support folios.

Right now in fuse, all folios are one page (large folios are not yet
supported). As such, copying folio->page is sufficient for copying
the entire folio in fuse_copy_pages().

No functional changes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev.c    | 36 ++++++++++++++++++++++++++++--------
 fs/fuse/fuse_i.h | 22 +++++++++++++++++++---
 2 files changed, 47 insertions(+), 11 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 7e4c5be45aec..cd9c5e0eefca 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1028,17 +1028,37 @@ static int fuse_copy_pages(struct fuse_copy_state *cs, unsigned nbytes,
 	struct fuse_req *req = cs->req;
 	struct fuse_args_pages *ap = container_of(req->args, typeof(*ap), args);
 
+	if (ap->uses_folios) {
+		for (i = 0; i < ap->num_folios && (nbytes || zeroing); i++) {
+			int err;
+			unsigned int offset = ap->folio_descs[i].offset;
+			unsigned int count = min(nbytes, ap->folio_descs[i].length);
+			struct page *orig, *pagep;
 
-	for (i = 0; i < ap->num_pages && (nbytes || zeroing); i++) {
-		int err;
-		unsigned int offset = ap->descs[i].offset;
-		unsigned int count = min(nbytes, ap->descs[i].length);
+			orig = pagep = &ap->folios[i]->page;
 
-		err = fuse_copy_page(cs, &ap->pages[i], offset, count, zeroing);
-		if (err)
-			return err;
+			err = fuse_copy_page(cs, &pagep, offset, count, zeroing);
+			if (err)
+				return err;
+
+			nbytes -= count;
+
+			/* Check if the folio was replaced in the page cache */
+			if (pagep != orig)
+				ap->folios[i] = page_folio(pagep);
+		}
+	} else {
+		for (i = 0; i < ap->num_pages && (nbytes || zeroing); i++) {
+			int err;
+			unsigned int offset = ap->descs[i].offset;
+			unsigned int count = min(nbytes, ap->descs[i].length);
+
+			err = fuse_copy_page(cs, &ap->pages[i], offset, count, zeroing);
+			if (err)
+				return err;
 
-		nbytes -= count;
+			nbytes -= count;
+		}
 	}
 	return 0;
 }
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7ff00bae4a84..dcc0ab4bea78 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -291,6 +291,12 @@ struct fuse_page_desc {
 	unsigned int offset;
 };
 
+/** FUSE folio descriptor */
+struct fuse_folio_desc {
+	unsigned int length;
+	unsigned int offset;
+};
+
 struct fuse_args {
 	uint64_t nodeid;
 	uint32_t opcode;
@@ -316,9 +322,19 @@ struct fuse_args {
 
 struct fuse_args_pages {
 	struct fuse_args args;
-	struct page **pages;
-	struct fuse_page_desc *descs;
-	unsigned int num_pages;
+	union {
+		struct {
+			struct page **pages;
+			struct fuse_page_desc *descs;
+			unsigned int num_pages;
+		};
+		struct {
+			struct folio **folios;
+			struct fuse_folio_desc *folio_descs;
+			unsigned int num_folios;
+		};
+	};
+	bool uses_folios;
 };
 
 struct fuse_release_args {
-- 
2.43.5


