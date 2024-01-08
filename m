Return-Path: <linux-fsdevel+bounces-7541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAD2826D80
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 13:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 697F0283793
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 12:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AED41758;
	Mon,  8 Jan 2024 12:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="JtN9iQVC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176794122A
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jan 2024 12:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 30CA03F5A7
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jan 2024 12:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704715814;
	bh=aN55u2dkdKkT9zGjEjP2EnVAXA2m3PLWvFfoTZsXkV4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=JtN9iQVC11J1SchqzCJSRAg67r4S5UDZyehwGkKERF25+8lAosFuE4pCdCR68SB8g
	 MphGgwr75jSZnX/s1MOP7bth5iHDAe4utxzy6DV+IRP0sG+Jz/3KkyTRDTpND605Lo
	 4267d/R91yMcgAy8x2myT4H+wGqVTJQUjrCLMep+yhAtJTuTHCgF7BG4aC3aKyP4TE
	 WL1V3HacZaHShDyeE8V3kmpas1YukBQxfNwjoNpQDQ/FMAv1FHGEZ5MAa0Mk+5SATp
	 2DKmUXnVcVzUmZf3sPGuyWCjlBE1HoSlXHQFPV4IaSUfiQkSdBMfVj2R2yF/9XSQNr
	 ANkiBvT+2Wrxg==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-556c60c7eb8so779385a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jan 2024 04:10:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704715814; x=1705320614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aN55u2dkdKkT9zGjEjP2EnVAXA2m3PLWvFfoTZsXkV4=;
        b=CHZimnpJPZ9dIH9SQ9sKIA83EoOFChqa/G4f+TZEvxZq5Lp8RviaQaYwIlLndU/cht
         VrkZW6isf0fvRxuY9ZRTROBPuc62ZJBIaAJ8ajERVkWt2tMnjl9ZL2hn2rz62Zez2Cz8
         +JCmahteBIN927SSFjrT21w+n5nF83czAQNiKK0U82IZZZjNKte07vnDcxkJKVKKKW/l
         H6QK0W9rnvkPI992KDKlvUiESWT6s+wY2WzMYptpOy1H+bkKcb1U7jJNZQ5Q5ITZHp7U
         wWWVTCobMcMF+O9gsGQfxJY7An71aZjrNB4Wz9ZCwY1Gfi8d+JZbAwqLNNK7R98aHyiy
         JAEw==
X-Gm-Message-State: AOJu0YzreVr1kgtj22JXQaXlkc8MEBnekpqgnaxJ1OR6WmzAxryIWNRZ
	rg2DL1f+kdZNzqBeg/qs9lGv4TTcs6Ft0FNGl1kl+nY1XMdMcDI+iI/2MPE6EFwvH9S+efLdG5R
	PozuwzYUfT/8ckGxZiLxK9hLLBtvmf7fDq9RWlMgqyYeLw00CVQ==
X-Received: by 2002:a50:8ac4:0:b0:553:a041:3560 with SMTP id k4-20020a508ac4000000b00553a0413560mr2378966edk.58.1704715813685;
        Mon, 08 Jan 2024 04:10:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJP5eOOFi4zff3/kz6KkKpi/0hmrVe9vDrjDdCDnW47eqq7qvcAY6eriI0cBf+y7RTehsDkQ==
X-Received: by 2002:a50:8ac4:0:b0:553:a041:3560 with SMTP id k4-20020a508ac4000000b00553a0413560mr2378953edk.58.1704715813387;
        Mon, 08 Jan 2024 04:10:13 -0800 (PST)
Received: from localhost.localdomain ([91.64.72.41])
        by smtp.gmail.com with ESMTPSA id fi21-20020a056402551500b005578b816f20sm1767959edb.29.2024.01.08.04.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 04:10:12 -0800 (PST)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: mszeredi@redhat.com
Cc: brauner@kernel.org,
	stgraber@stgraber.org,
	linux-fsdevel@vger.kernel.org,
	Seth Forshee <sforshee@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/9] fs/fuse: support idmapped ->permission inode op
Date: Mon,  8 Jan 2024 13:08:20 +0100
Message-Id: <20240108120824.122178-6-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240108120824.122178-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240108120824.122178-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We only cover the case when "default_permissions" flag
is used. A reason for that is that otherwise all the permission
checks are done in the userspace and we have to deal with
VFS idmapping in the userspace (which is bad), alternatively
we have to provide the userspace with idmapped req->in.h.uid/req->in.h.gid
which is also not align with VFS idmaps philosophy.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: <linux-fsdevel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/fuse/dir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 5efcf06622f0..f7c2c54f7122 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1558,7 +1558,7 @@ static int fuse_permission(struct mnt_idmap *idmap,
 	}
 
 	if (fc->default_permissions) {
-		err = generic_permission(&nop_mnt_idmap, inode, mask);
+		err = generic_permission(idmap, inode, mask);
 
 		/* If permission is denied, try to refresh file
 		   attributes.  This is also needed, because the root
@@ -1566,7 +1566,7 @@ static int fuse_permission(struct mnt_idmap *idmap,
 		if (err == -EACCES && !refreshed) {
 			err = fuse_perm_getattr(inode, mask);
 			if (!err)
-				err = generic_permission(&nop_mnt_idmap,
+				err = generic_permission(idmap,
 							 inode, mask);
 		}
 
-- 
2.34.1


