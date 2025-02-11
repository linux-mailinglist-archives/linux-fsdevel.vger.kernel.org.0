Return-Path: <linux-fsdevel+bounces-41496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDB2A30085
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 02:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94ED1167B80
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 01:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E2F1E32D6;
	Tue, 11 Feb 2025 01:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbeGbyfq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB421F2C49;
	Tue, 11 Feb 2025 01:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237493; cv=none; b=ey+M/f2zZi5CMTknP3g2A29H26jDjygUvD6IYUqvbuhmuQjahL10slwPOqlpE3ukQFvxq08pfC/WjoCQ2CQDx2Nf8xyByMXxsBMpX7lfgaG0SphS3xj+bdRR+RRBtprCYVIb/VPe/ZYk08eOktTkrew2qmi99ZKwVLVp9Q4uzSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237493; c=relaxed/simple;
	bh=M2o2pjvV6GmDtkDKgCAzdZyI9a4yVUIBYtGJWCHpJkw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ISkg9ka0HBX+Hf7wg0FEk6iJzORjwgIB4iL3d1DEm3i/2JgaSmnRGp/CSzX3EcaPRY8wgU0UELFtH1L/DJxAwUkm7Kggyid1vUoRaFBEmig/VLaU2xi0KMOL6+qm7JOIhqJCTfj+tuKWXnUd2u/AzdGMES3NbXsfnGxcpd0KoJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbeGbyfq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDAC2C4CEE5;
	Tue, 11 Feb 2025 01:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237492;
	bh=M2o2pjvV6GmDtkDKgCAzdZyI9a4yVUIBYtGJWCHpJkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IbeGbyfqyemsXBEPC28n9sdmiUpAG93JjKNuqPWgLcKhs6bYTavlWZ6iKHlT3lpWZ
	 zsdja6N6KPOf9ROd5QgQev6u9MyY/JVu0cG6nyxLq6Y3PtDlArXIX0DPbZE9+mac9D
	 h6L5ha/5lZgp+iR2+472uQn3DdmJRSyOESJPY++bRu9eYlk31kKs2HatMigKQ+igip
	 LNKQo46MKHLNa8lgAhWT5o3pYQiX1B07FmOyEgQC2dxtX1VUU6/gzF+KMuZnDzHmP+
	 4E7f0Vn4rxGaap3GrRRnObqtBZX05hUH0le7eW5Wkcw6Zhb00rvkNi1i399jY7I5u9
	 yBvicrAUY8pqA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Brahmajit Das <brahmajit.xyz@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 18/19] vboxsf: fix building with GCC 15
Date: Mon, 10 Feb 2025 20:30:46 -0500
Message-Id: <20250211013047.4096767-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211013047.4096767-1-sashal@kernel.org>
References: <20250211013047.4096767-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.13
Content-Transfer-Encoding: 8bit

From: Brahmajit Das <brahmajit.xyz@gmail.com>

[ Upstream commit 4e7487245abcbc5a1a1aea54e4d3b33c53804bda ]

Building with GCC 15 results in build error
fs/vboxsf/super.c:24:54: error: initializer-string for array of ‘unsigned char’ is too long [-Werror=unterminated-string-initialization]
   24 | static const unsigned char VBSF_MOUNT_SIGNATURE[4] = "\000\377\376\375";
      |                                                      ^~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Due to GCC having enabled -Werror=unterminated-string-initialization[0]
by default. Separately initializing each array element of
VBSF_MOUNT_SIGNATURE to ensure NUL termination, thus satisfying GCC 15
and fixing the build error.

[0]: https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wno-unterminated-string-initialization

Signed-off-by: Brahmajit Das <brahmajit.xyz@gmail.com>
Link: https://lore.kernel.org/r/20250121162648.1408743-1-brahmajit.xyz@gmail.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/vboxsf/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
index e95b8a48d8a02..1d94bb7841081 100644
--- a/fs/vboxsf/super.c
+++ b/fs/vboxsf/super.c
@@ -21,7 +21,8 @@
 
 #define VBOXSF_SUPER_MAGIC 0x786f4256 /* 'VBox' little endian */
 
-static const unsigned char VBSF_MOUNT_SIGNATURE[4] = "\000\377\376\375";
+static const unsigned char VBSF_MOUNT_SIGNATURE[4] = { '\000', '\377', '\376',
+						       '\375' };
 
 static int follow_symlinks;
 module_param(follow_symlinks, int, 0444);
-- 
2.39.5


