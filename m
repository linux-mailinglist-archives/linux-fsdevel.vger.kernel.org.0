Return-Path: <linux-fsdevel+bounces-41499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32925A300EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 02:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F27713A191F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 01:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E985426836B;
	Tue, 11 Feb 2025 01:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJdqx2SG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D105268353;
	Tue, 11 Feb 2025 01:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237568; cv=none; b=Ag4hElAfOY9iE/RKlxOmhj3Fn47r3qXjBpbwU1zjCtNPGWNhGpuSMi9+YSueQQHAjfzm7IZGjwug8B3B85wD3jT+jFSh8FrtXaY6VexHdAM9IKgXlHuWohXZKpLmBsUticBXdAUmmpO0NMJyAw8FDv/HcSUxwWmTAI5N41HJuuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237568; c=relaxed/simple;
	bh=OQNUzGizrNbSp6MOMrDJCWnxrsY/qqoTfQ60hKwmtn8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pbCgW3V+ax3wnQ/Sd/wJqvNZ3RAs8REtSo71s8Pw7lO0NisahgAUUEUb1J1RIxjWskz58i6xxbwu3KMNKp8UC6y/7HrER4nJvEbTMUk5CQCg2LUjSroqv0GW+ySVOcO+q6Wzr7cYXp+OY+n39FPgmhNp3HgVcTSDhOo6Z1lOuVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJdqx2SG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E77FC4CED1;
	Tue, 11 Feb 2025 01:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237568;
	bh=OQNUzGizrNbSp6MOMrDJCWnxrsY/qqoTfQ60hKwmtn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KJdqx2SGu+bep8ZqAf7RLrwTnpgYUec6Y15VGpnfhtxBxl8DDAA6vVT6otfrPAUN2
	 VlU24bKT6AG31yKXWSFtLjuJWPUEOMKUwhlr9cpVrQ6Ywj2DVfHzOcJ8++bdphcTe1
	 rL1jMMOwnc7SBrB64nRhYmz2cqYJh2tSSjiXN2TpGEDl0JUk298jVpnnNIsviuQpOb
	 2k6gWUehLabImqV2rIlyi5IU3Dp0ID+cu2a8AWhMqxI9bfdWdBvLhnNWEijZhoaENW
	 n3poQHRH23a4JbAQ8aZbCxk0hdfOjlo2TxXv1l63yDS7RlMKraXchkvhp+0YaJrdV/
	 PaIZebLZAcsQQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Brahmajit Das <brahmajit.xyz@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 9/9] vboxsf: fix building with GCC 15
Date: Mon, 10 Feb 2025 20:32:30 -0500
Message-Id: <20250211013230.4098681-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211013230.4098681-1-sashal@kernel.org>
References: <20250211013230.4098681-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.178
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
index 44725007ccc2c..20cfb2a9e8707 100644
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


