Return-Path: <linux-fsdevel+bounces-71645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D083CCAF65
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 09:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 40A323012DCE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 08:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7766334C1F;
	Thu, 18 Dec 2025 08:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJW+NtJt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEBB3346BD
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 08:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766046908; cv=none; b=aeoxfcVjh/4suS5FfxyCDSb2dulDmUR7MJ+fKZEVhD4NflfAbLTxmnmbtEL+XJ4eax5z8uT697r/z3EYveDY/PIvdjxYo9N4JHoUEgQZQntXUX5Z9iqVmD3p3oBfNF3FR8UCvBxvfArQq9e1JV8izlR4F46gsudvOMdYR6B4+sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766046908; c=relaxed/simple;
	bh=JXMvn1NMlj4tmOrWG0zkpmdnP/Xw/eEoEIkqSGKLsO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XIcM1Dwlphay9uJHmJsYJuUhYm0fi1RNB0zBlXqIJWiw0Pxq7s+Ug9u0Np1oTa1P5KUMm6cSgp6nStkjv9eVwrr9qlCCXxakco+78mV0kYRBk6yMJVdt+0lb+GXMVeK8udItJ5Ta7sC6Adsh6/TJkqLmVwEcDnqeixBui+uPJS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJW+NtJt; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a12ed4d205so3448455ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 00:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766046903; x=1766651703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WO1WrE07m4/ps4EUGl0M4D/d+Qo8L6vNQWiuLZIYXDo=;
        b=iJW+NtJtwh9sFFeUAWBjcxyS+O9+2t5o23Pn0HL3rl2kQD6HPaTV9JixYVJn8ZfDdx
         8evzVZJyBcFPfgU3cY4kk0GO9/VannJeqNBS2110uXdQxI5w6z6kV8c7mGhT7oCl6dnT
         M88SzArq0qjSCK/Hr7h7Z8DJWRhhwktri6jDYeJfx/97VybnOIVWMOzYXa7XxSqnI6aO
         huYXB+4DVIe/sV3p+taiVknKHEzh6VVTmJSHlJ9s8gdzuGjxP/ekU3AJU86hvIYPDpgR
         6gJ3MhXyRcS555EYrVcg9IPFIBDpz1VHGmjZdyoo8Fc6gDP00DC5/ZWaKG2m5+IKesDK
         2VaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766046903; x=1766651703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WO1WrE07m4/ps4EUGl0M4D/d+Qo8L6vNQWiuLZIYXDo=;
        b=u4TUdnuM7s68BDylamHdqS7I4f4E1WbnphM7Px/pfGv+6jPCfMyeZgXcI2Tq/2iCQ0
         T4dI49kVoRiPxQdsjPhrMxJ8GQRcyy0UJntbaFCxI5kTrcauKFgZWt6oxkf7iTWdlnzs
         lD2K3wi4+lCt4mR68CDDY1Umr/bJeJFLM3/imA8AmC8CvfVF+jqDwMd2UupMlavLR0HV
         x1oUhvKvDDfP3ZUlOp2mCGv9YEwgveKQw7Zp9/hf0S/nSRyfrja0iQZ7tS+vVJ7TLfr6
         4WxG7gesv76DSzzesycOjOGf9oI9qTX2pMgtAGxRPx1buA5qHc7CBgbahd4CdMDvmsUv
         NRjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm/+P9JQ3T3nlD18yvHS+4USgQrvmv9MkMk69qsIg3W5hxfeabAZB3Y6xYQkY7CPx33arRubfBcRYa8yi5@vger.kernel.org
X-Gm-Message-State: AOJu0YyTxoNLwGELPPZwWGvyacuwJmEGgoZaROYMmh2QmxKTrhN+MItE
	DJ55uf9h9XPAcd7yu2AA2SS417QYoM7q27cNFGONIPR0UQLdtdplnICt
X-Gm-Gg: AY/fxX61BIZLE+aUpuSrHwFVgbZB8YEhUK5bBj8fDS+PniGLOH+IejG+0q8S/QdzNBQ
	YFft1J+LDVckBiRe1ZXWrARjf40T5LKAlWEZ9nIOA8CP52nH31PEMD5D4QczPPJB7aCpaaYu7o/
	KvcCmS4g9zRMuyTVQ77Z2Xn+XWrtoX8Jgo3TMangtb0u/243EVGVhyoPvWRd773GYFCBq/M/BDN
	grbZUAg7w+COVNwamCULhUExY3nkcFHq4dZHFqwMnHKf6tvzeSk7ZxrXFjHW/Z94r8XyQqfUqy8
	0E2zjENU8RceVbZwSlFHZqbyrfwDlVcj83564P8scAic3FbW1O9fo2u4QnLv/wOotu8hLoRqXFT
	WeUDsWEsmxV9w53wz9QXlWHt34t7xTc6DnCuoWVxjlGbWc6RSOHfgNdiEaTyXZPSZupDhWeZEB7
	oo3xHbAxz/K0dbY7fbZnSuPXotMsI=
X-Google-Smtp-Source: AGHT+IH8gkkTwp8YPa+LkoM3wopB+gBYFIKVpM+V2RfNoNV9Ryp2Tzknos2ZVIGVgmGQwlizhtYNUQ==
X-Received: by 2002:a17:902:d50c:b0:29f:3042:407f with SMTP id d9443c01a7336-29f304249dbmr209086775ad.21.1766046902814;
        Thu, 18 Dec 2025 00:35:02 -0800 (PST)
Received: from localhost ([2a03:2880:ff:8::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d087c710sm17312585ad.6.2025.12.18.00.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 00:35:02 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	csander@purestorage.com,
	xiaobing.li@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 18/25] fuse: support buffer copying for kernel addresses
Date: Thu, 18 Dec 2025 00:33:12 -0800
Message-ID: <20251218083319.3485503-19-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251218083319.3485503-1-joannelkoong@gmail.com>
References: <20251218083319.3485503-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a preparatory patch needed to support kernel-managed ring
buffers in fuse-over-io-uring. For kernel-managed ring buffers, we get
the vmapped address of the buffer which we can directly use.

Currently, buffer copying in fuse only supports extracting underlying
pages from an iov iter and kmapping them. This commit allows buffer
copying to work directly on a kaddr.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev.c        | 23 +++++++++++++++++------
 fs/fuse/fuse_dev_i.h |  7 ++++++-
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 6d59cbc877c6..ceb5d6a553c0 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -848,6 +848,9 @@ void fuse_copy_init(struct fuse_copy_state *cs, bool write,
 /* Unmap and put previous page of userspace buffer */
 void fuse_copy_finish(struct fuse_copy_state *cs)
 {
+	if (cs->is_kaddr)
+		return;
+
 	if (cs->currbuf) {
 		struct pipe_buffer *buf = cs->currbuf;
 
@@ -873,6 +876,9 @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
 	struct page *page;
 	int err;
 
+	if (cs->is_kaddr)
+		return 0;
+
 	err = unlock_request(cs->req);
 	if (err)
 		return err;
@@ -931,15 +937,20 @@ static int fuse_copy_do(struct fuse_copy_state *cs, void **val, unsigned *size)
 {
 	unsigned ncpy = min(*size, cs->len);
 	if (val) {
-		void *pgaddr = kmap_local_page(cs->pg);
-		void *buf = pgaddr + cs->offset;
+		void *pgaddr, *buf;
+		if (!cs->is_kaddr) {
+			pgaddr = kmap_local_page(cs->pg);
+			buf = pgaddr + cs->offset;
+		} else {
+			buf = cs->kaddr + cs->offset;
+		}
 
 		if (cs->write)
 			memcpy(buf, *val, ncpy);
 		else
 			memcpy(*val, buf, ncpy);
-
-		kunmap_local(pgaddr);
+		if (!cs->is_kaddr)
+			kunmap_local(pgaddr);
 		*val += ncpy;
 	}
 	*size -= ncpy;
@@ -1127,7 +1138,7 @@ static int fuse_copy_folio(struct fuse_copy_state *cs, struct folio **foliop,
 	}
 
 	while (count) {
-		if (cs->write && cs->pipebufs && folio) {
+		if (cs->write && cs->pipebufs && folio && !cs->is_kaddr) {
 			/*
 			 * Can't control lifetime of pipe buffers, so always
 			 * copy user pages.
@@ -1139,7 +1150,7 @@ static int fuse_copy_folio(struct fuse_copy_state *cs, struct folio **foliop,
 			} else {
 				return fuse_ref_folio(cs, folio, offset, count);
 			}
-		} else if (!cs->len) {
+		} else if (!cs->len && !cs->is_kaddr) {
 			if (cs->move_folios && folio &&
 			    offset == 0 && count == size) {
 				err = fuse_try_move_folio(cs, foliop);
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 134bf44aff0d..aa1d25421054 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -28,12 +28,17 @@ struct fuse_copy_state {
 	struct pipe_buffer *currbuf;
 	struct pipe_inode_info *pipe;
 	unsigned long nr_segs;
-	struct page *pg;
+	union {
+		struct page *pg;
+		void *kaddr;
+	};
 	unsigned int len;
 	unsigned int offset;
 	bool write:1;
 	bool move_folios:1;
 	bool is_uring:1;
+	/* if set, use kaddr; otherwise use pg */
+	bool is_kaddr:1;
 	struct {
 		unsigned int copied_sz; /* copied size into the user buffer */
 	} ring;
-- 
2.47.3


