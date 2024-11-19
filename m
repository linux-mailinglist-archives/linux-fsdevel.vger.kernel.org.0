Return-Path: <linux-fsdevel+bounces-35185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A4C9D22BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 10:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E12C0282177
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 09:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7841E1C3F2B;
	Tue, 19 Nov 2024 09:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2BMDGQb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2031C330D;
	Tue, 19 Nov 2024 09:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732009586; cv=none; b=spZj4+g2XIv3ZFV1YuPXsBWgSeQsynSIIkQNO/R2mwuHHSLzcr7HdOesGiHWEqDnKqcReAGr2yiguSM/uq5q+W8IYmt8R54AARrKciI9qUhqDNyloiFX1H+bmHNq95z25ZZ1+FpgUObz2aqK3JnNZ37R2anDvsTeWpWaLf++OYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732009586; c=relaxed/simple;
	bh=8BIcT4mZcMGzCARR7fQzz3Vku6S+0XbDDO2hSqwMkhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lRR0oJl2knwNUTtrrak6olzvMQO0/GzjEp/oeZQCkX0EM4i0o52+bYEteJwkXVJd04ijz7PKx1JhlFjyCZqGI+KMJ/+caWPVQPCKd03McYLwGsDkFU1wQ9yrNUAEM/Gu5E0ZEzWfpZXk8oo16brI/6S+KZY6Bv1sJ2rL02yvwuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2BMDGQb; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c96b2a10e1so1144765a12.2;
        Tue, 19 Nov 2024 01:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732009584; x=1732614384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRjdlYzPvkDGyceNUheL6XnbeGUmofPVBhVXYJCZjS8=;
        b=A2BMDGQbfxClJxUuP82vWaYKSjgcQv6pxZpUKEQAse46zClSXMtSFF3p1+aF+TKoXa
         hjOCI5o4b/+V874MXo2B/FaYVld+Jab9JR7dyr0ka4eIb0KxirBrZetgL1ZFB/dcmbPi
         /8DEE+fsZke7pWGUFEgPFVDtk21zsPDbtfnk051nMb01glzwo7oa33u8AENmd5d60VRl
         tgier9+ig+GN1SAbYxXoz3WqS3+aGjSFON1akjjHa2C0SA1Uxmtuc63WHYTIwtpYLJtP
         1RVwG+1O4wftdxs9eV8Hew7GQCkqJ0P4lhGxt6nGB1wFilddO99FA0AY3iiH+SrKvYlS
         rKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732009584; x=1732614384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gRjdlYzPvkDGyceNUheL6XnbeGUmofPVBhVXYJCZjS8=;
        b=oTHl0CnlrErfoLJHXcBQTkN/fxRALgDZey34ujHFGwd0hPbQcdbj5ZipFrhIdREzN3
         nOcQMi+UYNqYe67R/Z7PY8KdEUtyNu3znmbyRj/7XnyqPytClnH7w2b8yP5nalyuOOAf
         RtdXMEeFvP9d+/NsmrmHZux+YGknsVFM7HMQWIz2uAsN0tn3AWT149RCxpkEjfLjBJRc
         Fk+iWgNlq6S642GFP/FVf9G7SBIx2EWghhixz3/b8AlM3nChkeh1g8QQYdCu8k/P0s6D
         tamybAc9m52VyA030wufIw23CdS66RDfXLZ5dy7isHo9HVue1wr5AKghQ1PeLD42uzFp
         PiyA==
X-Forwarded-Encrypted: i=1; AJvYcCW6ffwvtCxZbeJRYvUAHd4k9AWhP47A6D9Gh/kKMeUWaFqz5QvNDdduxk8SIANbZHvGCntXU/MXCLlT2VBT@vger.kernel.org, AJvYcCWFZv6bx1U2XCfTFD6knqAXfbcTMA4+u84oqt6JNwUHEMdAhSS/hFwKXFXZd+Cyn14M2vLK7DHMuec+YffcZA==@vger.kernel.org, AJvYcCXjgC2dCg/5Fs6Vmtx1gWxmCoHhn+PduysRpVNBSGsf4ngPHVNfmeNYlAqlv7H38EI7sQwkA5iz8zIF@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4D7Tb6MAahv8k5VroauZXPZctA1wUeQRqxRkB1xZxTiOPmJYA
	yNZNdvqhwxgDun8euHpaZSgj28cb3P+O7WjJt1ozRPYG+xZpwgv3
X-Google-Smtp-Source: AGHT+IENGIigl1Ik7Rf/ZJmBgZi3Rx84+DKOI+SOYgqn4TNYTQoyphRR0vTCB3wZq2zJh9NolYXLRA==
X-Received: by 2002:a05:6402:1e94:b0:5ce:af48:c2cc with SMTP id 4fb4d7f45d1cf-5cf8fcdfb82mr12601421a12.27.1732009583401;
        Tue, 19 Nov 2024 01:46:23 -0800 (PST)
Received: from f.. (cst-prg-93-87.cust.vodafone.cz. [46.135.93.87])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cfcb3edce9sm1821154a12.35.2024.11.19.01.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 01:46:22 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	hughd@google.com,
	linux-ext4@vger.kernel.org,
	tytso@mit.edu,
	linux-mm@kvack.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 3/3] tmpfs: use inode_set_cached_link()
Date: Tue, 19 Nov 2024 10:45:55 +0100
Message-ID: <20241119094555.660666-4-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241119094555.660666-1-mjguzik@gmail.com>
References: <20241119094555.660666-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 mm/shmem.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 3d17753afd94..698a4bbdc21d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3870,6 +3870,7 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	int len;
 	struct inode *inode;
 	struct folio *folio;
+	char *link;
 
 	len = strlen(symname) + 1;
 	if (len > PAGE_SIZE)
@@ -3891,12 +3892,13 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
 
 	inode->i_size = len-1;
 	if (len <= SHORT_SYMLINK_LEN) {
-		inode->i_link = kmemdup(symname, len, GFP_KERNEL);
-		if (!inode->i_link) {
+		link = kmemdup(symname, len, GFP_KERNEL);
+		if (!link) {
 			error = -ENOMEM;
 			goto out_remove_offset;
 		}
 		inode->i_op = &shmem_short_symlink_operations;
+		inode_set_cached_link(inode, link, len - 1);
 	} else {
 		inode_nohighmem(inode);
 		inode->i_mapping->a_ops = &shmem_aops;
-- 
2.43.0


