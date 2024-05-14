Return-Path: <linux-fsdevel+bounces-19446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A338C570B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 15:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16A741C223FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 13:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F31A15DBC4;
	Tue, 14 May 2024 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFDcfdj8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A3715B548;
	Tue, 14 May 2024 13:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692686; cv=none; b=T3I6J/LqnoY3IJXUsvr6pysWzML6iP8z41LlfbLZMIu0HaTEYs4QsRiz1pMl2rsyF0zZXnT0JRzPN0QzqtHVOllDDAM+zJVL30WrsOJjbd3S/v+OIEySfrLOcVziv77YWCC2INf8wtJYMHTQLr6tEZHah2X3xnBxTj+7ot1g5gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692686; c=relaxed/simple;
	bh=D7M8pVfsTC+fSZDKePS+b8y4ahUIRhAr9xpbzUfnsDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mYid40QstFctTEMWlUS/UldC6ysozyutdnD37EkFNhd+TzZRYdbzvM5nDkIZnnj1+KBtWtbUEBtJ/OztH7eg9M+A6PcugCM3tqDmN2ldMDjbJUgxIRwupVe6SwJzPo2vJq0wyLdsLTIP0vXw9EpHFWWFEbUcJhRzik/gOsEwQLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFDcfdj8; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ecd3867556so42342155ad.0;
        Tue, 14 May 2024 06:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715692684; x=1716297484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Tvk+4/cuasxtbCoAfEn0BfCmyFKQZmSR0C0/ucGLyo=;
        b=dFDcfdj8pQNRTweaurimWIJCywJHGrB2DcY3yTJ91hhlSUVFrpi9JvyTwlF48u8/eX
         wInrPQrlY/XWQoOJ5cgiuFKjXcKLnQT65qDUK/35jWqCWcmQEH90imuP2JsZhxYZu9XM
         0Hley0N1O/CF8KUxWNg2r79YkUgLJeL7Vt1wbuXizfqfNXDGCwe7Ug8LaH984l3hpgUZ
         YqzuiYzDns+h7i/3U8CyMaggH5r8NdaFMCaUPEQNg6cuIdcfnt2ZdyymqW6w7Tjy1NYh
         FuEOdj3RAy7RkRtGMsQekW3POYKXeI/xX9te0C14DrSg4sD+SngWG6gBX84ZuRHwCMpn
         Vekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715692684; x=1716297484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Tvk+4/cuasxtbCoAfEn0BfCmyFKQZmSR0C0/ucGLyo=;
        b=FzhO1XfPG0gMrrG0OT360wfbut2kvbwYfUDavSjPVYgo6Rn5IEixBgbK8OfSmsojcK
         xtzbzTsXg9pj1ckSPPfCyDqIe2F9l1IVmmy9/Od52RCr0pLkP0YymkKu6+dF2qyGI8xY
         bMK8AyEoEKnkP79sTJz2K+xfrVw1UVbQl0SgHIWtzJIpCmqpIyQVRaE1PIHImwk3b6rn
         LMGlpKC1O52N0puMZpPRV9tmVf38PiYBWgbhRpoycDuTCA3H/appKJB4GKFELnl2IOQl
         gfyiaDiINNt9YwF+rnqBd1yGjoDq2oUkFMHJkhQf93psl/yRNMBS+O1hqrKtYQ1UixFu
         8RdQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6JIJjCHZ8YvoFfOTKdEfRNCnOysIgb8iIswTUQhYMV21Rm/xXMSEfqMcdQij3Wc7AzXi6t5mHPdSLV7TtIZUPEimwAzRToA4BIZXM3JxJRTOlz7JS9Sj24S2URS4Jss+iJvyooZiPWu3ms+TxZy7iQDpX2ErrAf9OfF2kcgmIdfMdzVdN/1I1DqDO
X-Gm-Message-State: AOJu0Yx23ESPJfW+4biFREr7ewZfzZU9N3/0V20orQ1qSUJjOlRlPWwO
	R+mm2VChZT2KyRlYyvs4AGXhq0zORu8njmYYMPCbv0uXUza63Mwk
X-Google-Smtp-Source: AGHT+IHFc1KLRutr9+TMQCXqLb/r6uooGYKc4ocbDY2OD5+gzl/iFmilc83xdO0NRL6HAhYef4qn2w==
X-Received: by 2002:a17:903:1c9:b0:1e3:e081:d29b with SMTP id d9443c01a7336-1ef4404fc55mr159384335ad.45.1715692684001;
        Tue, 14 May 2024 06:18:04 -0700 (PDT)
Received: from wedsonaf-dev.. ([50.204.89.32])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ef0b9d18a4sm97277335ad.56.2024.05.14.06.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 06:18:03 -0700 (PDT)
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
Subject: [RFC PATCH v2 25/30] rust: fs: export file type from mode constants
Date: Tue, 14 May 2024 10:17:06 -0300
Message-Id: <20240514131711.379322-26-wedsonaf@gmail.com>
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

Allow Rust file system modules to use these constants if needed.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/kernel/fs.rs | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
index d64fe1a5812f..4d90b23735bc 100644
--- a/rust/kernel/fs.rs
+++ b/rust/kernel/fs.rs
@@ -31,6 +31,33 @@
 /// This is C's `pgoff_t`.
 pub type PageOffset = usize;
 
+/// Contains constants related to Linux file modes.
+pub mod mode {
+    /// A bitmask used to the file type from a mode value.
+    pub const S_IFMT: u16 = bindings::S_IFMT as u16;
+
+    /// File type constant for block devices.
+    pub const S_IFBLK: u16 = bindings::S_IFBLK as u16;
+
+    /// File type constant for char devices.
+    pub const S_IFCHR: u16 = bindings::S_IFCHR as u16;
+
+    /// File type constant for directories.
+    pub const S_IFDIR: u16 = bindings::S_IFDIR as u16;
+
+    /// File type constant for pipes.
+    pub const S_IFIFO: u16 = bindings::S_IFIFO as u16;
+
+    /// File type constant for symbolic links.
+    pub const S_IFLNK: u16 = bindings::S_IFLNK as u16;
+
+    /// File type constant for regular files.
+    pub const S_IFREG: u16 = bindings::S_IFREG as u16;
+
+    /// File type constant for sockets.
+    pub const S_IFSOCK: u16 = bindings::S_IFSOCK as u16;
+}
+
 /// Maximum size of an inode.
 pub const MAX_LFS_FILESIZE: Offset = bindings::MAX_LFS_FILESIZE;
 
-- 
2.34.1


