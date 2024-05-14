Return-Path: <linux-fsdevel+bounces-19450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9288C5713
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 15:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A806C1F2242E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 13:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B1216D4CA;
	Tue, 14 May 2024 13:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNuQIRdW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710C515E21C;
	Tue, 14 May 2024 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692689; cv=none; b=WvAF/szPB8Bv5uSKFaU44lIHaA0+VBGIxD+IBNUNCoZGXXDtA1o40qtUHZp8hqNPnbGu5rFFRDrU9xVdtFK0BIGS+OgJiu9V1GhG/Gk3LoyceSOH3czsE4dbeJVSjp/dijN3KXnleLHa7QLIgz6rbJyE/8PdAqkgKVpUYCHtjs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692689; c=relaxed/simple;
	bh=6z1RI8g33lkqRGyE2YmVG8hRvjhcPCdneDUfYaUM/ZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TqaJvK8tbrMnM3e2DABgej2ddcLuJWQksxoX1XSzH599NH57uB7VA9pnF7hZvhD1TmaqAvpEfXEk7UopXpUB6gc1/ruT9I/rozVxu8GIcwERtrMc3eQISuB/ox+uzvJIsJVXgFcLSTZQdNsfMdQe+NqcD5R6vgSozG+PfhlcSC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNuQIRdW; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f082d92864so8599825ad.1;
        Tue, 14 May 2024 06:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715692687; x=1716297487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzlX6MytMtV0hY1Vkeg8NRqNISRVbi1aOoZP9vK22EI=;
        b=jNuQIRdW2zlSs4TMpMFBIiGalf7H9y2cU1YEp1ApHKK6aeey+q+3tKQgvUBUXCnz22
         z3qhTAPSUVbVMenGuDK2Owy9ojQ6iMWG/GJCDKGdo2kcqJV/G7f4tXhJ+8SkJ09tZmkv
         rLpT44/0h2IJbx5diVDnnbLG8yXi9tHw9mI/P4eO2W2/6N+sM0RSCjXT6L0qkj2axdgM
         zao6O9WI8MkrpdHAfEiMoj9+qLYPkWmgde9NoX4LM+SFDth+xDfgLWp0BcU/xx04+guP
         ZYGFSEdabhcgDWgT2EMXj1IE1ZfPZIf9Z9pUkSP08W3XPKBA8zYla6gz3K8ayGaSK/Om
         nRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715692687; x=1716297487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mzlX6MytMtV0hY1Vkeg8NRqNISRVbi1aOoZP9vK22EI=;
        b=qnRtjYVDTc5tAyISgWJr5UFd0XgL+R/5WB8ctXDzdlTPG5lRkIU12o2x4ptuY2MHeb
         gmTu46afsI/vziWs76fO2AEqj5D8/sYqAx7nVyyo7Nra82NwIZlND13NpG8bw7doBVjk
         14LALtGKDvNaNkA+/jxNN79pZyarTDs17nf0q3PvDYh3VIULIbx3B/RZvsXd5DsoJKCX
         j2oHnzMapc2rK3Mt/wF4C0mABlXykVxIQWUhV/VfpXeSm7uFC1rPoNVfocbN2MfD5cTr
         55fsz6QjBTXof5xn9zW2nBcilU7i4G/7Xnf6mKKZVGGh4JJ+7OoRp7Yno1xUuQlIz0a6
         J0NA==
X-Forwarded-Encrypted: i=1; AJvYcCUUqd1DAvs+GIgNoAL3Ou0FSDejdTggBx9P0lYxgX6o90w0ZxpoWOVWSEIJn3ukLAhpuqCN/Z4I5XOD+O7E3nnMvUqCxK1TtzwnwgI1qgK6nvogARQeU/6/FKsSDbey16FBamgfTcMAvHwG9rwXA3GBbalkh+INaU+OmBWAI1LGfTnU74+hIk14nleo
X-Gm-Message-State: AOJu0YwZsz7nJrGqSeYmEvbdxYRc/ACp+eGTDq3eW0cO/ZembKniYkaS
	BpyKz1bEEsM7S6yq6678zEcFXXmHbsj6CeLUZ5hJ0VmKPMjG+Enw
X-Google-Smtp-Source: AGHT+IFcS2xpKzPg2drbQuSK/tq8J0Pxz68uGmcCBBRMfNmdMiVNACt4X4HGf60/AnW8PrvGFTj4YQ==
X-Received: by 2002:a17:903:11cf:b0:1e4:9d6f:593 with SMTP id d9443c01a7336-1ef43e27274mr148874305ad.36.1715692686828;
        Tue, 14 May 2024 06:18:06 -0700 (PDT)
Received: from wedsonaf-dev.. ([50.204.89.32])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ef0b9d18a4sm97277335ad.56.2024.05.14.06.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 06:18:06 -0700 (PDT)
From: Wedson Almeida Filho <wedsonaf@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dave Chinner <david@fromorbit.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>
Subject: [RFC PATCH v2 28/30] rust: fs: add memalloc_nofs support
Date: Tue, 14 May 2024 10:17:09 -0300
Message-Id: <20240514131711.379322-29-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240514131711.379322-1-wedsonaf@gmail.com>
References: <20240514131711.379322-1-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wedson Almeida Filho <walmeida@microsoft.com>

When used in filesystems obviates the need for GFP_NOFS.

Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
---
 rust/helpers.c    | 12 ++++++++++++
 rust/kernel/fs.rs | 12 ++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/rust/helpers.c b/rust/helpers.c
index edf12868962c..c26aa07cb20f 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -273,6 +273,18 @@ void *rust_helper_alloc_inode_sb(struct super_block *sb,
 }
 EXPORT_SYMBOL_GPL(rust_helper_alloc_inode_sb);
 
+unsigned int rust_helper_memalloc_nofs_save(void)
+{
+	return memalloc_nofs_save();
+}
+EXPORT_SYMBOL_GPL(rust_helper_memalloc_nofs_save);
+
+void rust_helper_memalloc_nofs_restore(unsigned int flags)
+{
+	memalloc_nofs_restore(flags);
+}
+EXPORT_SYMBOL_GPL(rust_helper_memalloc_nofs_restore);
+
 void rust_helper_i_uid_write(struct inode *inode, uid_t uid)
 {
 	i_uid_write(inode, uid);
diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
index 7a1c4884c370..b7a654546d23 100644
--- a/rust/kernel/fs.rs
+++ b/rust/kernel/fs.rs
@@ -417,6 +417,18 @@ impl<T: FileSystem + ?Sized> Tables<T> {
     }
 }
 
+/// Calls `cb` in a nofs allocation context.
+///
+/// That is, if an allocation happens within `cb`, it will have the `__GFP_FS` bit cleared.
+pub fn memalloc_nofs<T>(cb: impl FnOnce() -> T) -> T {
+    // SAFETY: Function is safe to be called from any context.
+    let flags = unsafe { bindings::memalloc_nofs_save() };
+    let ret = cb();
+    // SAFETY: Function is safe to be called from any context.
+    unsafe { bindings::memalloc_nofs_restore(flags) };
+    ret
+}
+
 /// Kernel module that exposes a single file system implemented by `T`.
 #[pin_data]
 pub struct Module<T: FileSystem + ?Sized> {
-- 
2.34.1


