Return-Path: <linux-fsdevel+bounces-19430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D1E8C56E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 15:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2291C1C22210
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 13:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03A714AD24;
	Tue, 14 May 2024 13:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAozbOGR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04E3146A9F;
	Tue, 14 May 2024 13:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692669; cv=none; b=PQokvjv0l7vBx7PBP/ci0gc3nokpArSAhBNEIfNr/pdyRf4JSOyYyOFdRkBwBrsIEM+DCwp0oOD4RWdIFOMIY1aMl6vnxqeaz2aBQ6CcUHE2+5s8BFH3tZzn22MlukFzfO1/YbxSZVyNa2ttQXqPWENroV76e5/7I3Sku1SgoCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692669; c=relaxed/simple;
	bh=guYIJsy3kCGaE8JFJGrMHROjk2P2zWMTT8kD0m4RCl8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mGeTdevpHUAFOt1dIOBeY364q1t36kSFsUuXmopmxRhf8cGziqeWg8y88k8Nft7Z9j5Y82jxGC1gYgKIEy/yn2SlEvG2mVarBVb2Vfa8LXxlS6YreSuag6Pw8KzfGYcVPnERRj4+zhCKn7XZnMnC5GCSheY4eiiJFuKfESS+vXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAozbOGR; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ec4b2400b6so46103605ad.3;
        Tue, 14 May 2024 06:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715692667; x=1716297467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMcl/ifCfcA1uYeFeWl4JOo8kfKdMw4mW78nzbs+K7U=;
        b=HAozbOGRT8A+40UZOF1XdLBhkiicFpDKmQefCWaQ8Cis8UYKsq6bGH7nderUf4NTUy
         bWfxnZtMuwGXTkF1l7yY85Gt3lR4ulaiwCA+FNL5W+4f3b6Ji7jxhGiB/7nhCVgi/Ipx
         1TDHRRT6mi6BTaZo5nne557NMX4tpZ6PjJb7TWTSZygo8zlRJ/sETdfgFCAb8sv9u1bW
         uIWUbzhk2rl81rW4wOcpQO5ObjaUKkHVhWIfBygIkJUmi4Y7bbSjD/gr2UkRvNAXZwWR
         cBHDhgzWcnZLdPJZWxMGnB6iV4ov4AQXHOkZV90KLRhe8jpweqN0e8VoJH84fqQGggHu
         za7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715692667; x=1716297467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PMcl/ifCfcA1uYeFeWl4JOo8kfKdMw4mW78nzbs+K7U=;
        b=Npak1TQDT/L3oXcIDGRrZTfzcZ7wX9XFUrvor6+3egaFYqmHD29NYD+C7pUAlKc64E
         ydqPF8bZDcf8GKOiCSWHwZ0i1D+QYNcIW3pcjpmhLHdrpxFLkh+3iI3hdMHNnJ+Q8PKB
         PT1CmT520fA+JZKOsYaY82AfC65vnhLlAFPvppFrO5nMKFCVQswyXZCkeYcttckfg8Xo
         OkqaEtvNhW8CP4ihpK9zH6NcnQZAK5nfp0YbSUc2yMwZapogOrBJ38QDlfAVrr0zrCdP
         +V20kfMiBhQR8i+PkLNlVQQYEZ+pRzDOtLLliFBSl1MHlDa1RMguCm3r8reHFOcoe6zJ
         lMjw==
X-Forwarded-Encrypted: i=1; AJvYcCVf67d/3p2D3PyaVM7hD/qT/CufB9kPiTfHcTbICTA5k2dVxeiM/mS4xKtRXZaiBfXqeUmRl8bxT2I9VNZqMI+zM/z53JDiNz6eyPVmYKwQFIH0LEPjKSysnLehuOLS643Q9Ijq9+XxtZpnxHGTgCDgWrh5fO86xywF7hc0Al130US5ivnb525P+L3c
X-Gm-Message-State: AOJu0Yy0pF7ixXEQnb1F3auMgV51TngR+Mnpsj2bULPq+JkYfPa640LL
	dAEYUNtkg4hGXbZZdl4DqS/WGDYJ1oneESkO4B4ZEn7iuN96hrhj
X-Google-Smtp-Source: AGHT+IFrvKjZ3mHAOmVF9/Ju8y89aj8T02fV5ZC9uqfRALJvdI/cz7D+y61X4xh5e9VPaz+KKtJzBA==
X-Received: by 2002:a17:902:f705:b0:1ee:b47e:7085 with SMTP id d9443c01a7336-1ef43c0c957mr156856905ad.12.1715692666895;
        Tue, 14 May 2024 06:17:46 -0700 (PDT)
Received: from wedsonaf-dev.. ([50.204.89.32])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ef0b9d18a4sm97277335ad.56.2024.05.14.06.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 06:17:46 -0700 (PDT)
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
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [RFC PATCH v2 08/30] rust: file: move `kernel::file` to `kernel::fs::file`
Date: Tue, 14 May 2024 10:16:49 -0300
Message-Id: <20240514131711.379322-9-wedsonaf@gmail.com>
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

This is in preparation for making `File` parametrised on the file system
type, so we can get a typed inode in file system implementations that
have data attached to inodes.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/kernel/fs.rs            | 1 +
 rust/kernel/{ => fs}/file.rs | 2 +-
 rust/kernel/lib.rs           | 1 -
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename rust/kernel/{ => fs}/file.rs (99%)

diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
index f32c2f89f781..20fb6107eb4b 100644
--- a/rust/kernel/fs.rs
+++ b/rust/kernel/fs.rs
@@ -14,6 +14,7 @@
 use sb::SuperBlock;
 
 pub mod dentry;
+pub mod file;
 pub mod inode;
 pub mod sb;
 
diff --git a/rust/kernel/file.rs b/rust/kernel/fs/file.rs
similarity index 99%
rename from rust/kernel/file.rs
rename to rust/kernel/fs/file.rs
index b7ded0cdd063..908e2672676f 100644
--- a/rust/kernel/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -76,7 +76,7 @@ pub mod flags {
     /// # Examples
     ///
     /// ```
-    /// use kernel::file;
+    /// use kernel::fs::file;
     /// # fn do_something() {}
     /// # let flags = 0;
     /// if (flags & file::flags::O_ACCMODE) == file::flags::O_RDONLY {
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index e664f80b8141..81065d1bd679 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -30,7 +30,6 @@
 pub mod block;
 mod build_assert;
 pub mod error;
-pub mod file;
 pub mod fs;
 pub mod init;
 pub mod ioctl;
-- 
2.34.1


